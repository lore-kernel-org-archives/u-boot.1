Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76612CDB483
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 12:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3072E86E16;
	Tue, 17 Oct 2023 14:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=48.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=48.io header.i=@48.io header.b="IV/PPfYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F8AC86E04; Tue, 17 Oct 2023 12:46:02 +0200 (CEST)
Received: from pruto.48.io (48.io [37.205.10.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1691186E04
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 12:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=48.io
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=srk@48.io
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by pruto.48.io (Postfix) with ESMTPSA id 4D5BF19FE29;
 Tue, 17 Oct 2023 12:45:59 +0200 (CEST)
DMARC-Filter: OpenDMARC Filter v1.3.2 pruto.48.io 4D5BF19FE29
Authentication-Results: pruto.48.io;
 dmarc=none (p=none dis=none) header.from=48.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=48.io; s=default;
 t=1697539559; bh=TKM7xPOoEFDh88zRJ4c4eIE7zK4174ENqk7WGFzKGbI=;
 h=From:To:Cc:Subject:Date;
 b=IV/PPfYZKZrj87OK8WW9CRCVqUB/QC2WFGOf4cMS+bi3iBC63rmuUmJUoCmcH5pqK
 kxEBkykEF41jrfcdvHOa9X3DNHqajqQYqgjR7j7vfx3wa4bbQ4w+qf1LH3CyOuLdsb
 VkJMH1DcdDtwIs/OsAQHM6G8sVRGwBfP3Y+/Dreo=
From: Richard Marko <srk@48.io>
To: u-boot@lists.denx.de
Cc: rasmus.villemoes@prevas.dk,
	Richard Marko <srk@48.io>
Subject: [PATCH] kbuild: use which $(DTC) as a dependency
Date: Tue, 17 Oct 2023 12:44:53 +0200
Message-ID: <20231017104453.2121276-1-srk@48.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 17 Oct 2023 14:05:15 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

If we try to build using external dtc using

> make DTC=dtc

we get a confusing error like

> make[2]: *** No rule to make target 'arch/x86/dts/bayleybay.dtb',
> needed by 'dtbs'.  Stop.

Workaround is to use

> make DTC=$( which dtc )

which gives make a full path, so the dependency
is satisfied.

This was introduced by commit
d50af66 kbuild: add dtc as dependency on .dtb files

and we extend it so it calls which automatically
(similar to scripts/dtc-version.sh)

Signed-off-by: Richard Marko <srk@48.io>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 8dc6ec82cd..04fc9b0752 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -351,7 +351,7 @@ endif
 
 dtsi_include_list_deps = $(addprefix $(obj)/,$(subst $(quote),,$(dtsi_include_list)))
 
-$(obj)/%.dtb: $(src)/%.dts $(DTC) $(dtsi_include_list_deps) FORCE
+$(obj)/%.dtb: $(src)/%.dts $(shell which $(DTC)) $(dtsi_include_list_deps) FORCE
 	$(call if_changed_dep,dtc)
 
 pre-tmp = $(subst $(comma),_,$(dot-target).pre.tmp)
-- 
2.42.0


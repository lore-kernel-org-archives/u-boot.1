Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7EFC67861
	for <u-boot@archiver.kernel.org>; Mon,  8 Apr 2024 22:52:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F72D882C0;
	Tue,  9 Apr 2024 00:46:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GxjmqSSK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 912FF8814A; Mon,  8 Apr 2024 23:29:08 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C8F880FE
 for <u-boot@lists.denx.de>; Mon,  8 Apr 2024 23:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 438LT0Xh101119;
 Mon, 8 Apr 2024 16:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712611740;
 bh=zpA3YmYCQZn/aMvhd1f2eG6EuOksF362zz8JDkB9Aak=;
 h=From:To:CC:Subject:Date;
 b=GxjmqSSKsbIQCwUERqaAkyZt9OSqQMFie8dskYAMCjst7bsqFWNxnOQl5vdYCvoNv
 YFn7ruIDhQw5eDP34D5nOdFsH662iHbu/HwxwhFW+q1z3YySjSmdQSaQO24lVb+5RF
 f/tNC63Bz5DVTQ4+WsQLYomhLGlsIvPwJ61vq+bc=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 438LT0Mq022525
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Apr 2024 16:29:00 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Apr 2024 16:28:59 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Apr 2024 16:28:59 -0500
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 438LSx3U041379;
 Mon, 8 Apr 2024 16:28:59 -0500
From: Jonathan Humphreys <j-humphreys@ti.com>
To: Masahisa Kojima <kojima.masahisa@socionext.com>, Sumit Garg
 <sumit.garg@linaro.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Jonathan Humphreys <j-humphreys@ti.com>
Subject: [PATCH] Makefile.lib: find capsule ESL dtsi file with
 CONFIG_OF_UPSTREAM
Date: Mon, 8 Apr 2024 16:28:43 -0500
Message-ID: <20240408212843.95871-1-j-humphreys@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Tue, 09 Apr 2024 00:46:15 +0200
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

When CONFIG_OF_UPSTREAM is enabled, DTS files are in SOC subdirectories (vs the
top level dts directory), but when CONFIG_EFI_CAPSULE_AUTHENTICATE is enabled,
the dynamically created dtsi file containing the capsule ESL DT node is in the
parent directory. This results in a build failure because the #include inserted
in the DTS file is local to the current directory.  Update Makefile to have the
DT preprocessing of #includes search in the parent (dts top level) directory
too.

Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
---
 scripts/Makefile.lib | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 12857316c58..62f87517c09 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -334,7 +334,7 @@ cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
 	(cat $< > $(pre-tmp)); \
 	$(foreach f,$(subst $(quote),,$(dtsi_include_list)), \
 	  echo '$(pound)include "$(f)"' >> $(pre-tmp);) \
-	$(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
+	$(HOSTCC) -E $(dtc_cpp_flags) -I$(obj) -x assembler-with-cpp -o $(dtc-tmp) $(pre-tmp) ; \
 	$(DTC) -O dtb -o $@ -b 0 \
 		-i $(dir $<) -i $(u_boot_dtsi_loc) $(DTC_FLAGS) \
 		-d $(depfile).dtc.tmp $(dtc-tmp) || \
-- 
2.34.1


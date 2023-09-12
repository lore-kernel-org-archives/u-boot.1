Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DB5EE3F37
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 21:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB6886E36;
	Tue, 12 Sep 2023 23:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="adLDLJEz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF98D86F47; Tue, 12 Sep 2023 23:35:11 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 3571686E13
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 23:35:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 141EF212BC3F;
 Tue, 12 Sep 2023 14:35:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 141EF212BC3F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1694554506;
 bh=rmz5hboYu867Liet5RzBBBjvgoUB4K4mP4A84wTuhMQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=adLDLJEzBqKXZ23Pf/nwXAxzTKMKIYDK9AaZsTQV9M0G8VZIk5yvYWJb42fg5Q7xB
 ubKNl0Vekaw6gwlvG+DUga08SvCsaHzXciOdWzxFN2lU1PU4PY7iI/9STFIqyeFXs1
 KqXEbLcXYXbkxsHhJ7PdZyq7ZGD6S7Aag0B+Sonc=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org
Subject: [PATCH v3 4/5] dm: core: Modify default for OFNODE_MULTI_TREE
Date: Tue, 12 Sep 2023 14:35:03 -0700
Message-Id: <20230912213504.65513-5-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
References: <20230912213504.65513-1-seanedmond@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Sean Edmond <seanedmond@microsoft.com>

There is a preference to use the "ofnode" API for FDT fixups
moving forward.  The FDT fixup will usually be for the kernel FDT.  To
fixup the kernel FDT with the ofnode API, it's required to set the
OFNODE_MULTI_TREE option.

To ensure existing users of kaslr fdt fixup are not impacted, Let's modify
the default value for OFNODE_MULTI_TREE to ensure it's always set if
!OF_LIVE.  This will cause a 1007 byte increase in the code size.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 drivers/core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index f0d848f45d..38e44ef6fc 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -424,7 +424,7 @@ config DM_DEV_READ_INLINE
 
 config OFNODE_MULTI_TREE
 	bool "Allow the ofnode interface to access any tree"
-	default y if EVENT && !DM_DEV_READ_INLINE && !DM_INLINE_OFNODE
+	default y if !OF_LIVE
 	help
 	  Normally U-Boot makes use of its control FDT, the one used to bind
 	  devices and provide options. In some cases, U-Boot must also process
-- 
2.40.0


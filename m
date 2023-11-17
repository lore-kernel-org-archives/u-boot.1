Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81CBC197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 02:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD4A8874D4;
	Fri, 17 Nov 2023 03:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nMh9G+Ta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A9FB86FBE; Fri, 17 Nov 2023 03:02:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by phobos.denx.de (Postfix) with ESMTP id 4BA538748C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 03:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=linux.microsoft.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanedmond@linux.microsoft.com
Received: from ovlvm106.redmond.corp.microsoft.com (unknown [131.107.147.185])
 by linux.microsoft.com (Postfix) with ESMTPSA id 0EDB220B74C4;
 Thu, 16 Nov 2023 18:02:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EDB220B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1700186529;
 bh=reovK8uNjm5WiKgGbU1V2boJW5Sb5+1TeXiaJtebFww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nMh9G+Ta5U0f31aO1h8Y8WObIf7ddXFTRVj6PLkZzvpcX4gFcxujmjKd9ldWhGVmS
 zQoA/M+vooOQISAqmoUf1S22m0WOP7Ux3+APOUrjQxNERU2xwXAkrfgo6vDr3I1X5J
 jYndGnWHaValcq7qurUc3r6eEal+QVnwhYnuuFsI=
From: seanedmond@linux.microsoft.com
To: u-boot@lists.denx.de
Cc: dphadke@linux.microsoft.com, ilias.apalodimas@linaro.org,
 trini@konsulko.com, sjg@chromium.org
Subject: [PATCH v5 4/5] dm: core: Modify default for OFNODE_MULTI_TREE
Date: Thu, 16 Nov 2023 18:02:05 -0800
Message-ID: <20231117020207.948636-5-seanedmond@linux.microsoft.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
References: <20231117020207.948636-1-seanedmond@linux.microsoft.com>
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
the default value for OFNODE_MULTI_TREE to ensure it's always set.
This will cause a 1007 byte increase in the code size.

Signed-off-by: Sean Edmond <seanedmond@microsoft.com>
---
 drivers/core/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/core/Kconfig b/drivers/core/Kconfig
index 737d4590d5b..c01a8dc7e0a 100644
--- a/drivers/core/Kconfig
+++ b/drivers/core/Kconfig
@@ -423,7 +423,8 @@ config DM_DEV_READ_INLINE
 
 config OFNODE_MULTI_TREE
 	bool "Allow the ofnode interface to access any tree"
-	default y if EVENT && !DM_DEV_READ_INLINE && !DM_INLINE_OFNODE
+	depends on OF_CONTROL
+	default y
 	help
 	  Normally U-Boot makes use of its control FDT, the one used to bind
 	  devices and provide options. In some cases, U-Boot must also process
-- 
2.42.0


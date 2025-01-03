Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBDFE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 13:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90EE58034E;
	Fri,  3 Jan 2025 14:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=byosoft.com.cn
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=byosoft.com.cn header.i=@byosoft.com.cn header.b="f6rZCAi3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACD280295; Fri,  3 Jan 2025 09:07:16 +0100 (CET)
Received: from zrleap.intel-email.com (zrleap.intel-email.com [114.80.218.36])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16174802EF
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 09:07:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=byosoft.com.cn
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=yanggang@byosoft.com.cn
Received: from zrleap.intel-email.com (localhost [127.0.0.1])
 by zrleap.intel-email.com (Postfix) with ESMTP id 9BC5DA32E13C
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:07:09 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=byosoft.com.cn;
 s=cloud-union; t=1735891629;
 bh=65oBWCPXNtaqZcAA3cu3tYFQPgbTDi28U3Yfb3QhgwU=;
 h=From:To:Cc:Subject:Date;
 b=f6rZCAi3KlzRyPaT+gEQiMkSVUMss3vCFenJ+qsrWC47exNiulk5dBBQEBFJT40rd
 OCZ6xsEpduG3/p/UjHeEZ4KAZwL9aOWTvif78ICT/Kp+9wanubz4YARmY6XiBpsBLc
 0eSLsQWsahtBdXol/S1JJbGnkm2TXcdWar4SvVcc=
Received: from localhost (localhost [127.0.0.1])
 by zrleap.intel-email.com (Postfix) with ESMTP id 7B0A3A32E135
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:07:09 +0800 (CST)
Authentication-Results: zrleap.intel-email.com; none
Received: from mail.byosoft.com.cn (mail.byosoft.com.cn [58.240.74.242])
 by zrleap.intel-email.com (Postfix) with SMTP id 43292A32E046
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 16:07:06 +0800 (CST)
Received: from localhost.localdomain ([192.168.15.254]) 
 (envelope-sender <yanggang@byosoft.com.cn>) 
 by 192.168.6.13 with ESMTP 
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 16:07:01 +0800
X-WM-Sender: yanggang@byosoft.com.cn
X-Originating-IP: 192.168.15.254
X-WM-AuthFlag: YES
X-WM-AuthUser: yanggang@byosoft.com.cn
From: Yang Gang <yanggang@byosoft.com.cn>
To: u-boot@lists.denx.de
Cc: heinrich.schuchardt@canonical.com
Subject: [PATCH] efi: Correct ECPT table GUID
Date: Fri,  3 Jan 2025 16:06:51 +0800
Message-ID: <20250103080651.666-1-yanggang@byosoft.com.cn>
X-Mailer: git-send-email 2.42.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jan 2025 14:24:13 +0100
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

Refer to UEFI specification 2.10:
  #define EFI_CONFORMANCE_PROFILES_TABLE_GUID \
  { 0x36122546, 0xf7e7, 0x4c8f, \
  { 0xbd, 0x9b, 0xeb, 0x85, 0x25, 0xb5, 0x0c, 0x0b }}

Signed-off-by: Yang Gang <yanggang@byosoft.com.cn>
---
 include/efi_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index f07d074f93..d3cf012693 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -227,7 +227,7 @@ enum efi_reset_type {
 		 0x71, 0x94, 0x19, 0x9a, 0xd9, 0x2a)
 
 #define EFI_CONFORMANCE_PROFILES_TABLE_GUID \
-	EFI_GUID(0x36122546, 0xf7ef, 0x4c8f, 0xbd, 0x9b, \
+	EFI_GUID(0x36122546, 0xf7e7, 0x4c8f, 0xbd, 0x9b, \
 		 0xeb, 0x85, 0x25, 0xb5, 0x0c, 0x0b)
 
 #define EFI_CONFORMANCE_PROFILES_TABLE_VERSION 1
-- 
2.42.0.windows.2



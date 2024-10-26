Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A9CD10BE5
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 06:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC6588E8C;
	Sat, 26 Oct 2024 08:41:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="RYqHAvCq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224FD8902A; Sat, 26 Oct 2024 08:41:05 +0200 (CEST)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D1B388FC7
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.c.hoisthospitality.com (unknown [87.215.50.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id DFE2B42700; 
 Sat, 26 Oct 2024 06:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1729924862;
 bh=2m6uBTzW/pwdbGU7YEFj/y2aXPHreUE0xwQksO0lGQk=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=RYqHAvCq40YZzX4aoc7nFY9VJCUjm2SdIUv4ERiWiBkH6vFwbk84apdv1Mte1DOc0
 /wagzw2rDwBy3reKbs/dUCJ45Py/YyqFZK82O8S4zVOGmzkKTjlpC4HFVrsF0SkGTz
 QOCaxsSdmDleNJvxTcUNTWMSnKgrS3CFxXhVLPVdor7J0NOpeYIrVa27n4T/0zn/ae
 2jtj9K7TLEr/RJNhmovpR1kDNgcMg8omFoWgEydZC+3U7cHFVe1oStgT4brmcfXO8t
 dGUoM2GTMEMqFDdqu6Y/QuAysvh5Pa0Z25ZUqvmWPkGekkJS7k0dps8IKjjkXqVkUV
 mYGMqAG4xXMDw==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Richard Weinberger <richard@nod.at>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 4/5] efi_loader: fix GetInfo and SetInfo
Date: Sat, 26 Oct 2024 08:40:47 +0200
Message-ID: <20241026064048.370062-5-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
References: <20241026064048.370062-1-heinrich.schuchardt@canonical.com>
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

* Some of our file system drivers cannot report a file size for
  directories. Use a dummy value in this case.
* For SetInfo the UEFI spec requires to ignore the file size field.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_file.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/lib/efi_loader/efi_file.c b/lib/efi_loader/efi_file.c
index c92d8ccf004..95b3c890ee9 100644
--- a/lib/efi_loader/efi_file.c
+++ b/lib/efi_loader/efi_file.c
@@ -864,8 +864,16 @@ static efi_status_t EFIAPI efi_file_getinfo(struct efi_file_handle *file,
 		}
 
 		ret = efi_get_file_size(fh, &file_size);
-		if (ret != EFI_SUCCESS)
-			goto error;
+		if (ret != EFI_SUCCESS) {
+			if (!fh->isdir)
+				goto error;
+			/*
+			 * Some file drivers don't implement fs_size() for
+			 * directories. Use a dummy non-zero value.
+			 */
+			file_size = 4096;
+			ret = EFI_SUCCESS;
+		}
 
 		memset(info, 0, required_size);
 
@@ -976,14 +984,16 @@ static efi_status_t EFIAPI efi_file_setinfo(struct efi_file_handle *file,
 		}
 		free(new_file_name);
 		/* Check for truncation */
-		ret = efi_get_file_size(fh, &file_size);
-		if (ret != EFI_SUCCESS)
-			goto out;
-		if (file_size != info->file_size) {
-			/* TODO: we do not support truncation */
-			EFI_PRINT("Truncation not supported\n");
-			ret = EFI_ACCESS_DENIED;
-			goto out;
+		if (!fh->isdir) {
+			ret = efi_get_file_size(fh, &file_size);
+			if (ret != EFI_SUCCESS)
+				goto out;
+			if (file_size != info->file_size) {
+				/* TODO: we do not support truncation */
+				EFI_PRINT("Truncation not supported\n");
+				ret = EFI_ACCESS_DENIED;
+				goto out;
+			}
 		}
 		/*
 		 * We do not care for the other attributes
-- 
2.45.2


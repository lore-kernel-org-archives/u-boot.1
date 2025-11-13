Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622BACD5BCE
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 11:56:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D635E83E0B;
	Thu, 13 Nov 2025 12:56:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="wemq12Ke";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NrTFgzdw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49B5D83E0B; Thu, 13 Nov 2025 12:56:07 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B58583DF7
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 12:56:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d6dyX1xXPz9tgD;
 Thu, 13 Nov 2025 12:56:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VF4GL1dXpWOryyDrYjZvw64n7vSLIBEjeXbOEI74FIA=;
 b=wemq12KeiSdY2NOuZDpj+D9SON2Ca5fs3oL65HAabmcEg2dPZ+nsa7RbrSalqi9i5JU65Q
 hwMSlIICmsKMzh0zijaZ4kRvvR69T2Bb6ghoO1lX8U6VMXO4PLoKXQ/6YgL9mhK3iN0EZo
 BFgP1NDzONR9FFKKhDFfliX4BX2RzRoAnXRHiTgQeS0KGlhlgk+bUuFOxHQDWmoGvFxw6F
 ehXBWhi+PHyl5kesqMs5gjOQgzE8Q43FiJGoGydoVYS7HRw6SGoAu/sxJAdDVKfwSgXLSV
 +j64AimiroWxNj/951DWP8KQM3dKLxRgwhGkDaxMg/VyABHdm2HeYISsaMee7w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763034962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=VF4GL1dXpWOryyDrYjZvw64n7vSLIBEjeXbOEI74FIA=;
 b=NrTFgzdwE/huqhrZAO/4zzs10+F2oF8k8ReAJOhGyDlV+2ht3CW0oZIpqS3InLRwI3l6tX
 99esyj4i4RnZu98HoezjrXdg61jkrbNEnaG7hd7sq4SP8Qx8Oe4wonLclHXFhil3hGHFhh
 B8obooqcbg8HoDd2tQaW5bGgDacIqRFwhP+HAyKAURY5tKGYd3he49+NVqcUKm8EJ8x/qv
 9EfP1MyHkXTVe9f3JkkGaaTPOYRUrsF8FsTe6BQHJG2Fe2bmKmZkq2n3EtOQP0jH6FaGUl
 Ml/aFpyRQSeGgTz5VyCSIsD1GolhQRG7edeeW1aGaKhiqrgy6ZdWD1fvdvg9pw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Wadim Egorov <w.egorov@phytec.de>
Subject: [PATCH] efi_loader: Assure fitImage from capsule is used from 8-byte
 aligned address
Date: Thu, 13 Nov 2025 12:55:49 +0100
Message-ID: <20251113115558.947903-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: b452efdeecbe22815c9
X-MBO-RS-META: 69kokwugdrnmi4ift95rnbqiqi59uwj4
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

The fitImage may be stored in EFI update capsule at address that
is not aligned to 8 bytes. Since fitImage is a DT, new version of
libfdt 1.7.2 rejects such an unaligned DT. Patch the code and copy
the fitImage into aligned buffer in case it is not aligned. This
does increase overhead for unaligned fitImages in EFI capsules, but
tries to keep the overhead low for aligned ones.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de
---
 lib/efi_loader/efi_firmware.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 216df83de67..953a310190b 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -651,6 +651,7 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 	efi_status_t status;
 	struct fmp_state state = { 0 };
 	char *orig_dfu_env;
+	void *img;
 
 	EFI_ENTRY("%p %d %p %zu %p %p %p\n", this, image_index, image,
 		  image_size, vendor_code, progress, abort_reason);
@@ -677,7 +678,20 @@ efi_status_t EFIAPI efi_firmware_fit_set_image(
 		return EFI_EXIT(EFI_DEVICE_ERROR);
 	}
 
-	ret = fit_update(image);
+	/* Make sure the update fitImage is properly aligned to 8-bytes */
+	if ((uintptr_t)image & 7) {
+		img = memalign(8, image_size);
+		if (!img)
+			return EFI_EXIT(EFI_BAD_BUFFER_SIZE);
+		memcpy(img, image, image_size);
+	} else {
+		img = (void *)image;
+	}
+
+	ret = fit_update(img);
+
+	if ((uintptr_t)image & 7)
+		free(img);
 
 	if (env_set("dfu_alt_info", orig_dfu_env))
 		log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
-- 
2.51.0


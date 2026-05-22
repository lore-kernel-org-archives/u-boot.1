Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E34CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF13A84839;
	Fri, 22 May 2026 15:09:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=binarly.io header.i=@binarly.io header.b="iYNsiNPO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11C7F841D7; Fri, 22 May 2026 14:31:56 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0C3841D7
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 14:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=binarly.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anton@binarly.io
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso3861808a34.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 05:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=binarly.io; s=google; t=1779453112; x=1780057912; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LN9DKj8LsN557Dg16wShu+wKPDV7eBZTW4TJLGjK3M=;
 b=iYNsiNPO0czT/oL/8cB4risnqcrpMPUftcEodaJwO8KmA1qdnzFhaWql/wec3TG8+7
 S4d+qIybAGvIMSBfiwA/Tx5BwB4E8x9Sg9kUfXD99UhU9HXyz/C3NuvUXBWzBJrBwnuV
 S9rRNnxvRbx1Pb4yml7Qx2FkFOGHXUeJMgwn2vytdgNGPzr0Z9NyijQaXM+9f+H2kNIP
 YctejO0vUq7baw1jI+ExXg34jiU/8810l7SMGYN9EMd8U2IzuZa45CP5Mj7R/s7jtUc6
 IOW+tkCkhvL5PQjGeqXcuFECEv9mbkDW7nIjpDcOPgDohCpdHZqBdcnp8wDqeAOd9D87
 Fv3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779453112; x=1780057912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6LN9DKj8LsN557Dg16wShu+wKPDV7eBZTW4TJLGjK3M=;
 b=pWVQIGltrmySJVJe/o8QrVL0mIKmSGn7oNmX2lsOk7ZsGyBKceCgvGSiW/P2XN9XFw
 3uBGIbpepCbKrV/vqY9UckiI+BAr5k1VHjDuwm2HP/KCbptcQhAkCdvnaHs/ahPdhuBN
 6Nlq/jE2dP3y/hA9I5h/cupr55IDXC9L75P/cGj4hkeOfgw4jbFe/YKr+CY6Y/49jLAM
 cwy3Q0xkGhzOv6u8yQ0iVI1aMtM1eZ3QTyHzOKqWSjWr1qjXZJf5jIy1t3P7oqMDx2U3
 H2aBrMIzWFcUhYWIh+xw0cVIUwzpQ/+wrDzxBbgKDonMjeW1DBNq5JApKji32NpLeGIg
 /qFw==
X-Gm-Message-State: AOJu0YwRIbpdHM0KWZbPzPj+3LrE2GO6EyDMmME/62uj5JAuBjc6cVd+
 vA9mp4gryFv6tJgGN/O1fwgqUoYVrPSr4zlpNfuXXhs/OQpis4NP6fR4IACR4crL8DvFZt80k0e
 bE0fZ
X-Gm-Gg: Acq92OFSofThyzrhLCH0BH0RJOalxVhg8KwjJbU+cuCZC4gV36yzQozrwMbdZ080u6T
 UoSig1ihXcFpoAXzjQfnI00M/ZuBbx+r649gvW1nzAkQKLQO6jyyZbEOUh8sLy2NcmmcwUCEeRA
 fM38zSBzk/PbAbDWCPrKRhkf6w2LlK1iGmvhS+F8oRZOJUTKWtF1R9EDiqFxKygSHW7HW23vaV0
 w2/hmmMHvWLo/pwtitXnQe6KsOF6RlwBUir2ZGSdNzC7W1ilnvqz8LG9qU27MOIVW+oFsDR4LJb
 VKCzQkjxYyoY31kb74RcRzZUi7I6PTgo3O8nUmfrF864pGShD//ib0lsQff9LPsviEgI/SsZ/jY
 PCQa+/GmF55lBDjaj3UTOpJLbq5IgjmdTjNZlxgg/FnYaBU1OtNeUgvirND1uEz6TrYXWctYvWy
 hLu6p8APx/Ccn7CJqLoCKnW6xWdQTWzfHorcAyTmqI7UVSP6tV0B6UdMmb
X-Received: by 2002:a05:6830:3789:b0:7dc:cdea:7d4 with SMTP id
 46e09a7af769-7e5fed4d4c7mr2236271a34.11.1779453112483; 
 Fri, 22 May 2026 05:31:52 -0700 (PDT)
Received: from localhost.localdomain ([93.174.85.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm4016553f8f.36.2026.05.22.05.31.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 05:31:51 -0700 (PDT)
From: Anton Ivanov <anton@binarly.io>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com,
	vr@binarly.io
Subject: [PATCH] image-fit: Check that external data is in bounds
Date: Fri, 22 May 2026 13:30:23 +0100
Message-ID: <20260522123024.6292-4-anton@binarly.io>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522123024.6292-1-anton@binarly.io>
References: <20260522123024.6292-1-anton@binarly.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 22 May 2026 15:09:24 +0200
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

From: Binarly Vulnerability Research <vr@binarly.io>

The fit_image_get_data() function in boot/image-fit.c resolves the
address and size of an image's payload. For "external" data, i.e.
images that declare data-position or data-offset rather than
carrying an inline 'data' property, it takes both the offset and the
size straight from FIT properties and returns them to the caller:

	int fit_image_get_data(const void *fit, int noffset, const void **data,
				size_t *size)
	{
		bool external_data = false;
		int offset;
		int len;
		int ret;

		if (!fit_image_get_data_position(fit, noffset, &offset)) {
			external_data = true;
		} else if (!fit_image_get_data_offset(fit, noffset, &offset)) {
			external_data = true;
			/*
			* For FIT with external data, figure out where
			* the external images start. This is the base
			* for the data-offset properties in each image.
			*/
			offset += ((fdt_totalsize(fit) + 3) & ~3);
		}

		if (external_data) {
			debug("External Data\n");
			ret = fit_image_get_data_size(fit, noffset, &len);
			if (!ret) {
				*data = fit + offset;
				*size = len;
			}
		} else {
			ret = fit_image_get_emb_data(fit, noffset, data, size);
		}

		return ret;
	}

All three properties (data-position, data-offset, and data-size)
are attacker-controlled, and there is no validation of the size
against the FIT image bounds. Moreover, all three properties may
take negative values since they are read as signed int (although
during the hash calculation they are later cast to unsigned int).

The obtained 'data' and 'size' are then used to calculate the hash
of the image for signature verification. 'info->crypto->verify' for
'sha1,rsa2048' is rsa_verify(), located in lib/rsa/rsa-verify.c,
which calls 'info->checksum->calculate' (set to hash_calculate()
for SHA-based algorithms in boot/image-sig.c), defined in
lib/hash-checksum.c:

	for (i = 0; i < region_count - 1; i++) {
		ret = algo->hash_update(algo, ctx, region[i].data,
					region[i].size, 0);
		if (ret)
			return ret;
	}

hash_update_sha1(), defined in common/hash.c, takes the per-region
address and size as an unsigned int and feeds it directly to
sha1_update(). If an attacker manipulates data-position or
data-offset, it is possible to trigger an out-of-bounds read by
pointing the region address beyond the mapped memory. Similarly,
with data-size manipulation, an out-of-bounds read can be triggered
by specifying a large region size that causes the hash calculation
to read beyond the intended memory region.

Fix: Validate the external data offset and size. Validate that the
external data is within the bounds of the FIT.

Signed-off-by: Binarly Vulnerability Research <vr@binarly.io>
---
 boot/image-fit.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/boot/image-fit.c b/boot/image-fit.c
index b0fcaf6e17f..4d0e8ffc79f 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -1084,8 +1084,24 @@ int fit_image_get_data(const void *fit, int noffset, const void **data,
 
 	if (external_data) {
 		debug("External Data\n");
+		if (offset < 0 || offset > UINTPTR_MAX - (uintptr_t)fit) {
+			printf("Invalid external data offset: %d\n", offset);
+			return -1;
+		}
+
 		ret = fit_image_get_data_size(fit, noffset, &len);
 		if (!ret) {
+			if (len < 0) {
+				printf("Invalid external data size: %d\n", len);
+				return -1;
+			}
+#if CONFIG_IS_ENABLED(FIT_SIGNATURE)
+			if (len > CONFIG_VAL(FIT_SIGNATURE_MAX_SIZE) - offset) {
+				printf("FIT external data is out of bounds (offset=%d, size=%d)\n",
+				       offset, len);
+				return -1;
+			}
+#endif
 			*data = fit + offset;
 			*size = len;
 		}
-- 
2.53.0

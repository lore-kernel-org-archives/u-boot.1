Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2BCC4345F
	for <u-boot@archiver.kernel.org>; Tue, 16 Apr 2024 19:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 548F788465;
	Tue, 16 Apr 2024 21:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vpYk7Hxl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D67F8844D; Tue, 16 Apr 2024 21:01:58 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BE4788437
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 21:01:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-434d0a63151so27017441cf.3
 for <u-boot@lists.denx.de>; Tue, 16 Apr 2024 12:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713294114; x=1713898914; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MXatlOLBI0X1BDcDrcwl78lVuLj5r3rz2vTPO2s1xYY=;
 b=vpYk7Hxln614icF8JWXNsOSMMQ3Vua2237weEzf0H3c0kPtIfS+wuGQqWUE+L4pMYQ
 qDdZKd+vHxGZMiIoL1yV9nd49v6SRjpkrsszXT8gVbyrAdKFCkZTqUgIsWQsPVyMtj4t
 esqcz0hOJ97JU263EjDRw0CDZe5juTa70s+u3rSt5BL1IcIOom92GVjAVRC1//kuR0Kb
 4K+T80MJ0B7KbIEzWogjLWjay1maC6KYE6PuyiTVB2yQVyLXhdNwQI6R2pIwWx4qASnp
 6OD8Y8JQkrbMup9ow+KlMMlS1b89es1LPbQbhIlArZ24mXolADONzHZDLgdrIUf11fcj
 KSxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713294114; x=1713898914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MXatlOLBI0X1BDcDrcwl78lVuLj5r3rz2vTPO2s1xYY=;
 b=Lphtz8naRf3GjpHB3aMAF1W3lNHo7j6EilHSBw9A/wDkRef40kr4yR1RPA/95BH+gZ
 RkpZ6RrQrGNYOwjxjPG23BudYPiMpFXBG2odxuD6szNMCPYbwjNkzn8qNG1t0U7afa8E
 V8uhq0cCkHevW3lgvFZ0MzJFjUq+hNNhTQdA1aya03QEbqdNpVytMeIgqp6/PRgqDXeo
 EODOTPdAQjthk2OyKIQ93BNnwQTghkNE5i2RfJOcqqKnpyS32gcMsllOLu3rowCid4he
 kHTAT3TSZK04g2ZaCAmmuumXO+B5jkExrJ+cWVv3Uklq6lLf5ssLQNRq5+58qw0UjhRk
 whbQ==
X-Gm-Message-State: AOJu0YwphxNo654vaX5Frj1AXO9s83TwIMJz+Si42Qn3TXDUv07QDvS0
 kjruf1cWrMsQ1XzMPqeTGT8IFaHJRkWciIi/kR4v611HC1Wdjo+z7YXcQpZTls8CXLNyJRpJpZ9
 B
X-Google-Smtp-Source: AGHT+IFJWm5dVe8Z5jvOKNlJsRfKCx9ZMOPIRONjSaYL3G2cCyI7WZ+e1iG/AiRC1ZANrVHTwmFOOg==
X-Received: by 2002:a0c:e786:0:b0:699:419a:fb4 with SMTP id
 x6-20020a0ce786000000b00699419a0fb4mr14791879qvn.6.1713294114153; 
 Tue, 16 Apr 2024 12:01:54 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-115-4-214.cpe.net.cable.rogers.com. [174.115.4.214])
 by smtp.gmail.com with ESMTPSA id
 n13-20020a0cbe8d000000b0069b59fb5829sm5971657qvi.44.2024.04.16.12.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Apr 2024 12:01:53 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: raymond.mao@linaro.org, trini@konsulko.com, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de
Subject: [PATCH 11/23] efi_loader: switch sha256 to mbedtls
Date: Tue, 16 Apr 2024 12:00:07 -0700
Message-Id: <20240416190019.81016-12-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240416190019.81016-1-raymond.mao@linaro.org>
References: <20240416190019.81016-1-raymond.mao@linaro.org>
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

When MBEDTLS_LIB_CRYPTO is enabled, use the APIs of sha256 from
hash shim layer instead.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 lib/efi_loader/efi_tcg2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/efi_loader/efi_tcg2.c b/lib/efi_loader/efi_tcg2.c
index ac056dcfc5..3c356abc6e 100644
--- a/lib/efi_loader/efi_tcg2.c
+++ b/lib/efi_loader/efi_tcg2.c
@@ -1321,12 +1321,21 @@ efi_status_t efi_tcg2_measure_dtb(void *dtb)
 
 	/* Measure populated areas of the DTB */
 	header = dtb;
+#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
+	sha256_starts_mb(&hash_ctx);
+	sha256_update_mb(&hash_ctx, (u8 *)header, sizeof(struct fdt_header));
+	sha256_update_mb(&hash_ctx, (u8 *)dtb + fdt_off_dt_struct(dtb), fdt_size_dt_strings(dtb));
+	sha256_update_mb(&hash_ctx, (u8 *)dtb + fdt_off_dt_strings(dtb), fdt_size_dt_struct(dtb));
+	sha256_update_mb(&hash_ctx, (u8 *)dtb + fdt_off_mem_rsvmap(dtb), rsvmap_size);
+	sha256_finish_mb(&hash_ctx, blob->data + blob->blob_description_size);
+#else
 	sha256_starts(&hash_ctx);
 	sha256_update(&hash_ctx, (u8 *)header, sizeof(struct fdt_header));
 	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_dt_struct(dtb), fdt_size_dt_strings(dtb));
 	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_dt_strings(dtb), fdt_size_dt_struct(dtb));
 	sha256_update(&hash_ctx, (u8 *)dtb + fdt_off_mem_rsvmap(dtb), rsvmap_size);
 	sha256_finish(&hash_ctx, blob->data + blob->blob_description_size);
+#endif
 
 	ret = measure_event(dev, 0, EV_POST_CODE, event_size, (u8 *)blob);
 
-- 
2.25.1


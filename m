Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4B6C5DF87
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 13:08:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1501406B2;
	Thu, 20 Aug 2026 13:08:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MwyQa3w4XcpA; Thu, 20 Aug 2026 13:08:05 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787231285;
	bh=8/gwiUUcgfAQ4yatIzS+T4Pi61ptkkrbwnq1RY1zbP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fr6Pxwj5prSc8fBKxV7qgDAHqp972Blvn4Rlo84ST9Bp8Cl8OTL5YdvZnPY9nn/vm
	 rK/mJtW9o2Mc8IJvgt1RGxYjvjN6Bkza8LAmAB1GGsFPMUFCLjeQZ1evQHFT7pl7Lb
	 SgVfEMf2WvK0HOUSB8JL3l1t9Jd9XIeD+y2mIjg+oa2sNXQAr9lSzIeQcrB8dCGGO9
	 4hKxMSheq+j9ooWaKOVzdDuCT7d0zzR4TgL8yfylVietYyx+KlSX7EO2PcfBgORc/y
	 CiRmDzl/gHJtDv/nC211fiAJNJKTkeOeUl/RofDobymayn7wjOhFl1R6b6EX6bSQM5
	 3Z9vrDLURHwkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2984240681;
	Thu, 20 Aug 2026 13:08:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC55739E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C290D405BE
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nb5TrFbkzQsh for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 13:08:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=Xb9DsaEz
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp4.osuosl.org (Postfix) with ESMTPS id ACF1D405B9
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:01 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 21ADB44B89
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 13:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787231280;
 bh=8/gwiUUcgfAQ4yatIzS+T4Pi61ptkkrbwnq1RY1zbP4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=Xb9DsaEzQm4I10/ODzrOyqGTfxgIC4N1FUapW4rLOGLrkpXdrz6DfjgFq8lX3kMR0
 PfOhZ0Gnw787m5DZOEBr3dqDknFBS2VHZgUGqAqMbNloloeU3CCngXaqiIzgs59ekx
 9LNcd6jxhyWSug2xl7bQWYhUJ6yakr4A3GzKEkgV8r969OXa+OkAUR4K/fWhHo0rRK
 G87qAqHCh3BujMSHi88qlqdLBvYnj4ol8kArbQfyuq0Ps1FW1dmNpppIQfcIC7Vx3a
 C2C4dcl1QqdVpAOTB+RbFiKE48fGeFmAsbr1SQTOl1HY1RxalagvkecbXd7QJeTJwo
 Ym5GZ0JFT3gEDJuDOTtpgRMUTQ7JxUgkC1jhRqS3JukIdE9JKjvsFQVgblk1G2218e
 we+9pfnkS/tg6h+kFUYwRiguz76ULo4YovSeSaG+6UNfLo/+w65nH1ue7JIJjiBNkW
 tnM/wJ4iKmsTZ1ct47U+X/qVM596NaGYFgAZgUem1OgLjRJVCrstgG+yGDjAm56Xzz
 CkxQDCqg3h7Q7WJDEeeMi7AqR8IAuO2YOuS3nxUPJUpOnWQlxb6Jv4tSk9NYvxBpVI
 qSAdiQeUM9O6CAZrqFjTnp99+eKCT2CzT1D5LwAD6MDMSuwjTwVynlFcVX1OveHqEL
 NQvd7zsINqukQbTUkUsCvJ3Y=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4955e865174so12114705e9.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 06:08:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787231279; x=1787836079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8/gwiUUcgfAQ4yatIzS+T4Pi61ptkkrbwnq1RY1zbP4=;
 b=FjsZdotO8q/uCa6jxuuWXYQFJQ9vPLNmTqZJIPYymw2MMvPxHhuPgxhU48cR/uWqO2
 nNvzxAOYZYaff1FIwxUhbj+0VlcVP2y9WRzmCstRFgX3g3IL5nxiNH/ONPDrL1Qjf6DC
 dCXpoIGog5vIvr55WmH1WfTiVX+JMqPUtavTshEz6NBvsc5V+ISVGokPn/7O1FC4+QgS
 /ZgVloLrH2E8p92hxEI6BE5Zcb97naaR8udKodlr9xDBUdkmFzDDqpJWi6Isg7ZbEPGb
 fnBj0+CTOCZ4OcKq28c3gyGxyHrqZKopyv7TSny+uimO2AJDYoKnU3Y5VlCZiR2DWhyk
 oZ8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrzniUMpHO9PkYCtA248wp2qnGVY7L8efqj7GL5knmhBtRwEsFGzFx6rNr2AnNQqeliHLwQbeY=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzDJ6ddRSX5x08QWbtBJ7tb7YRYnQrXNXiPxD/rLDNTJ8vhdm/V
 EHxxIgS8wRzkDYW1o7C8hBMcxe9lTlgUAcNDzq0FeNTmDub3O9pXpxRhLacxBv1BVgP2V8N59tX
 U2h+G+EpZLf72aTn7qfIr84mqZ9J8o+qpPFqk8klcnRoc4E0vqZct95L6SUMa3kHMueG3y8vNlC
 7ch80o2pbyfg==
X-Gm-Gg: AR+sD13m7owva36A90cWW7GPNwiqe1t7DeDpXCLssHkSphbJAq8QEayT84Y289NeqU/
 Vw7CUXYOpo99VAIe9SU1Y87iZaJhOKePDtU+dHnyNYhABMjaRV9y3YVh8YQWeiO1zfYoqvsnEsl
 Q4bInmTzsiA4tB2uc2OSs1xt1P1QWlbY0w4pjMhlrMJXSgt/RMwbUbtpGC1fXyaT6Yg3hljL3RF
 nXKEu0Z55j3aOothH2H/7/V+dyrkUGTKI0rUM97Ky1FTmlPlqkPJ/Fcw927IW4mSZVmQXTq14QV
 buXOE0DSglX6XY9QqJ6PCvuFARbC/RSbFNnSY8Ws3i7KMemprV2VCVisNWXrJJHL1wf3Qt0h4N0
 5ZXU5lgE1CW4wYuwRNGJ8+9bv33sHzAsuXFjJKuMbXpYrqgLq9J+ObXM=
X-Received: by 2002:a05:600c:34d1:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499aa14a6a6mr219122245e9.3.1787231279624; 
 Thu, 20 Aug 2026 06:07:59 -0700 (PDT)
X-Received: by 2002:a05:600c:34d1:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-499aa14a6a6mr219121685e9.3.1787231279262; 
 Thu, 20 Aug 2026 06:07:59 -0700 (PDT)
Received: from workstation5 ([2a02:908:1242:30e0:cba:879e:28f0:3c57])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fd7a9sm183722785e9.2.2026.08.20.06.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 06:07:58 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] efi_loader: consider type of platform_get_rng_device()
 return value
Date: Thu, 20 Aug 2026 15:07:46 +0200
Message-ID: <20260820130746.164424-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
References: <20260820130746.164424-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The return value of platform_get_rng_device() is efi_status_t.
It does not fit into an integer variable ret. Use variable status.

We already write a debug message in platform_get_rng_device().
We should not repeat ourselves.

The RNG device was available when registering the protocol. When it is no
longer available in GetRng(), this is a device error and not an unsupported
algorithm. Use EFI_DEVICE_ERROR returned by platform_get_rng_device() as
return value of GetRng().

Addresses-Coverity-ID: 532068 Overflowed constant
Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 lib/efi_loader/efi_rng.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/lib/efi_loader/efi_rng.c b/lib/efi_loader/efi_rng.c
index 9c5a60ea963..6c1c5f0be60 100644
--- a/lib/efi_loader/efi_rng.c
+++ b/lib/efi_loader/efi_rng.c
@@ -105,7 +105,7 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
 				  uint8_t *rng_value)
 {
 	int ret;
-	efi_status_t status = EFI_SUCCESS;
+	efi_status_t status;
 	struct udevice *dev;
 	const efi_guid_t rng_raw_guid = EFI_RNG_ALGORITHM_RAW;
 
@@ -125,12 +125,9 @@ static efi_status_t EFIAPI getrng(struct efi_rng_protocol *this,
 		}
 	}
 
-	ret = platform_get_rng_device(&dev);
-	if (ret != EFI_SUCCESS) {
-		EFI_PRINT("Rng device not found\n");
-		status = EFI_UNSUPPORTED;
+	status = platform_get_rng_device(&dev);
+	if (status != EFI_SUCCESS)
 		goto back;
-	}
 
 	ret = dm_rng_read(dev, rng_value, rng_value_length);
 	if (ret < 0) {
-- 
2.53.0


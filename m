Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413D3CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 16:36:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B077C80107;
	Wed,  1 Oct 2025 18:36:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="T1ZJsuAK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4232881D6A; Wed,  1 Oct 2025 18:36:50 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38994800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 18:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e37d10ed2so71563595e9.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759336607; x=1759941407; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=RDror+OewKEyTfOjytS84UuVnBsX4jawQX53OCSgL20=;
 b=T1ZJsuAKjLKMTrGEiPijiHAKM2utOKyrKB6p4Xu3EFjsned7EAKXsLashHWj5q+htr
 zccmhs1Kmzi85X8B999JHDT2iNlc3Wx9LVwUcdaHcBGEDlaNU+gvVxIIW+ZVUSAcjwCi
 BrMK5jh0Cuf8rE8T465TI0ZSrukMksUk9kI7kBkVIxkmltc5c4Dwc/1ZqMDokVhvsyJS
 Y+8EjQQnvKVgYv6x/4V6ApWdJqeyxcOWP5N1vZ66POVcPEgoQjX4B0QGQw7z75FOzJDE
 NZMginP9Gf37B7ebs/ohbQVmEASk1MN9JRETz/g3x5YImG5EN2WHs8a0AdjkwD7wmfZ1
 b9+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759336607; x=1759941407;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RDror+OewKEyTfOjytS84UuVnBsX4jawQX53OCSgL20=;
 b=eT5u/YoYD1OMrKX6VtqcRuAEGhZwpS5fLYH0R2umc4iM/EypEP/tZYv7o2zPcapjaG
 vvbY4Y9XkGGmO1aHU++GZC6LjHn0fDlJ81Tmv90GljpNFbFtx7Rb2riQ6msz+OgxCCB2
 73Y9Ejc7S26HFz6gtlLVEoKtZFax76U6FxEcPLmX/FsayL7sjbQ0Sjv+jbSLYNAB9xaf
 otNK9zlqFnCj+oGTO91REhKrhGQmBgkcqu2D+RzBM7KfaCFZzh8k0+jw2/Sonuqe4Z5w
 U7wfEPOE6jIqsZBaIek8Q1jEwyWQ/c8+Wpoe6F93mDMJtXpqCPqyoxyWxWhmALd2qDd5
 birw==
X-Gm-Message-State: AOJu0Yx/c4UR2Z/8CYi8HuMYMq0ma8GjRn+eK6T6U6TJURoNv/iRTruJ
 fhJYgD4F04c/m6g8LlWME2ZtOBhfWWAN9tGY1wd0Db/JPWALF2P3onq7sA1d95fKOewXbKlQSGj
 xw1ld
X-Gm-Gg: ASbGncvWUmOov4yKqkpbE2oh3+ZOrBLrsfn1LSF8dQi7m3xm7okvEM1bFZ4M7dcH+L7
 8R4mHfizqT/OVOnPCs2EFsvagqaDJKNIMfztOLiRA1br4QfRDmUJ6tlVATyAz/ZjIwuag9tpDNp
 JdmLf8CgKOMzt3W2ExqMyN6CjDa6EN8YLAoePCw2uDyDG1hVSZBi/Axguy/Xfi/63oCk5irfnMC
 bDvEla59hPYhIG0gbC8HvXs3r4h6cl+dyJQAAlTxuNiZUK21eZUWcaXyKkZRnoZXWqTwA3qGuIo
 i1evXVRNyFuep2wqUI3yTWH2WmfcNyiBQ/AbLk4yCjKQ+xQZjnguJhRjsk9lnL/bmOajD4PHEDn
 5s1rfGjoPjM8APN6mFuOcv7gFHU+DjQ4ZZYdUKqUPmxBR6rInkU5V+X24oGM/sweeI0q4ISw4LC
 c=
X-Google-Smtp-Source: AGHT+IGbCCKIqzz/y9/uEfPkAkW27TGpGMdcj3/bGEejqom38sX0KEu+1I47RqlMuBfw3KPsU10WbQ==
X-Received: by 2002:a05:600c:8b84:b0:46e:4c7c:5140 with SMTP id
 5b1f17b1804b1-46e61269198mr33679075e9.18.1759336607617; 
 Wed, 01 Oct 2025 09:36:47 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a020a3sm46477085e9.10.2025.10.01.09.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 09:36:47 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 01 Oct 2025 17:36:43 +0100
Subject: [PATCH] video: zynqmp: Prevent use of uninitialised variables
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-video_zynqmp-v1-1-34f1e59b9c34@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJpY3WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwND3bLMlNT8+KrKvMLcAl0LCyOjFDMLM+PE1EQloJaCotS0zAqwcdG
 xtbUAlscZVl4AAAA=
X-Change-ID: 20251001-video_zynqmp-8822d6863aea
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.14.2
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

The variables 'offset_matrix' and 'csc_matrix' will be used
uninitialised if video->is_rgb is false. Correct the logic so the
attempt to use uninitialised variables is not made. Also remove the use
of these variables as they seem to serve no useful purpose just being
aliases for arrays.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/video/zynqmp/zynqmp_dpsub.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
index 52af23c3c83592af4442af4fa7e345b85dabd9d2..a0efd3393f5fe2c3a468caec4ad81deef18dbdbf 100644
--- a/drivers/video/zynqmp/zynqmp_dpsub.c
+++ b/drivers/video/zynqmp/zynqmp_dpsub.c
@@ -240,7 +240,6 @@ static void avbuf_video_select(struct udevice *dev, enum av_buf_video_stream vid
 static void config_gfx_pipeline(struct udevice *dev)
 {
 	struct zynqmp_dpsub_priv *dp_sub = dev_get_priv(dev);
-	u16 *csc_matrix, *offset_matrix;
 	u32 regval = 0, index = 0, *scaling_factors = NULL;
 	u16 rgb_coeffs[] = { 0x1000, 0x0000, 0x0000,
 			     0x0000, 0x1000, 0x0000,
@@ -262,19 +261,18 @@ static void config_gfx_pipeline(struct udevice *dev)
 								video->sampling_en;
 	writel(regval, dp_sub->base_addr + AVBUF_V_BLEND_LAYER1_CONTROL);
 
-	if (video->is_rgb) {
-		csc_matrix = rgb_coeffs;
-		offset_matrix = rgb_offset;
-	}
+	if (!video->is_rgb)
+		return;
+
 	/* Program Colorspace conversion coefficients */
 	for (index = 9; index < 12; index++) {
-		writel(offset_matrix[index - 9], dp_sub->base_addr +
+		writel(rgb_offset[index - 9], dp_sub->base_addr +
 		       AVBUF_V_BLEND_IN2CSC_COEFF0 + (index * 4));
 	}
 
 	/* Program Colorspace conversion matrix */
 	for (index = 0; index < 9; index++) {
-		writel(csc_matrix[index], dp_sub->base_addr +
+		writel(rgb_coeffs[index], dp_sub->base_addr +
 		       AVBUF_V_BLEND_IN2CSC_COEFF0 + (index * 4));
 	}
 }

---
base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
change-id: 20251001-video_zynqmp-8822d6863aea

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED77C36008
	for <u-boot@archiver.kernel.org>; Wed, 26 Mar 2025 17:41:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3027281DED;
	Wed, 26 Mar 2025 18:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VfJPC+gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E496181B4B; Wed, 26 Mar 2025 18:40:52 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E062D81B4B
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 18:40:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so989535e9.1
 for <u-boot@lists.denx.de>; Wed, 26 Mar 2025 10:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743010850; x=1743615650; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HhIJRlbTOGLmXyF1Y1ZqzIUvJOx0pvDrHVji5qLs4To=;
 b=VfJPC+gk8WANmgWQWPHeMzWtcZtEOWQcWqHNu2mtE6axh8fCKhRivY20o2xUtBtyhv
 2ihPlkHtR1mvutmo0gbJ4qDv2dcNC9sTOi6dKYqVhNkvNoYuF+xHVEzn0VWmhmYjoeP5
 +RxZeGs+8zCvpv+vlM9pAJiGkvztKAMSC8MaaJzjrt8LO0mNovipwAFMufo/Qceq8bL1
 aj821DSSDLQCkcRxT8Vxp9YhvTSeIX6ArI/kQ4py7IDDZiNdJTNNUo8fjTuYrsoVAUv6
 l6dDyklukZL3wfU9Lm85mVeJ5Bo5mW5TogJEP2nQVrwsg/sqbH9fyB+f8LMmNMGsGydb
 GzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743010850; x=1743615650;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhIJRlbTOGLmXyF1Y1ZqzIUvJOx0pvDrHVji5qLs4To=;
 b=cxa11U5STyTEn2wX4qOu7p0pRc1pwCd8+iGTKJ2UilK+VDlvGSbvmemKl3+2AYTmKZ
 Q5vdrNSgp2uq9NAJzRcrXZhUGfS5+s1TG51+l4x9pkmogDD258U6MTDMEcD2HB37AVXM
 fi+ZPvaUH9MTFAq0A0y1GhIzubQSsVt9CjiGUXip8bKt1pGwR9Vx1anMhlMYSfq8Eng4
 LvGkNc7JpcrrHnnOwGY6HctbfpddfUZ6Sh6Uza8QcPjQ8ajO2PQIBODT88fOdxWO6AwR
 ataVITthtJ3QpC6wLee/FFVl3VGxPLfrhlhujCx7s43Ol1z5Rr+DrsT5Sd7AU0/h2Nxv
 h3oA==
X-Gm-Message-State: AOJu0Yxm9S/PV/cxua9xdaYGXOlQduXvYLcBhphWLFhQK5JI3/aV6GgC
 hBbtwHZK6s5r2wunRh/ZCpq5UnAGlrB5eYasL5F40q4Zn/TjNpW/IgQRQ38uVds=
X-Gm-Gg: ASbGncto5ZiB+MDbLITgVIifUMA7nWCVzxpvXehKf6kSXXl2OW1Jhy3kE2yfpYy2We3
 tcBm7Fli1PwB3nsZ2iE0mKKNdgh/Ib3DjGnDDu8xKY/Lw9pPDATiUJ5UywuLjfZ836BRqMoa0mR
 sf/cr6xZy47dCyCdJgsL/qWsCtspAjVlVsbu8j6U2xRKxHn3FRBWhmmQwikon5ULod9hUaEfBNc
 yddT80P6Pwtj8G1ttZi1eiocvMoNH0BYCWf9Uzon7cpyCPbyqSIaumTxloKJ4di7fAvdBigeVBB
 spFOWRrRHAgeNlk/PQUpmEpEsB4fSMsAI1Pgq/X2o5TGZeGIS/iz88TlmU8wAvBVr+exTg9yVKw
 VAjfiJt67hnxh
X-Google-Smtp-Source: AGHT+IGog/6T423JH6LR53fYJhJnTOEzse+YRtDN/hfiRk163ZaHca+D94+KfPe/t0H7APK97KOyBw==
X-Received: by 2002:a05:6000:1889:b0:391:39ea:7866 with SMTP id
 ffacd0b85a97d-39ad174b468mr278951f8f.19.1743010850312; 
 Wed, 26 Mar 2025 10:40:50 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9957d9sm17397321f8f.9.2025.03.26.10.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 10:40:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 26 Mar 2025 18:40:36 +0100
Subject: [PATCH 3/4] dfu: scsi: don't call scsi_scan()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-b4-qcom-capsule-update-improvements-v1-3-afe2e3696675@linaro.org>
References: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
In-Reply-To: <20250326-b4-qcom-capsule-update-improvements-v1-0-afe2e3696675@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Tom Rini <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XIOsPmy+vaBNCalESw2xbHebuoIH51ML6j82hKWz0Zg=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn5DwbnJux9kmPLtyJNzAyY8/1qMk53cOipJKl+
 ZtwO1B9u+aJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+Q8GwAKCRAFgzErGV9k
 thnZD/9J0Q7pzkZI1ZISnCSrtvl/AIUzUgaZPbSJpxEEsWrUsXDvgUYyDE+MUypjchz6WJyQ+Bd
 cbsn/Syue/6z7du/rNH+CYXrZHMpMfNC+gCscckjmmiSnVCY6A2Wu0OM3Psz4c9VfkKmxIj4hRj
 7M/ow7DKXz4APeKjnwPzEmmBNGKx79mMN7rsJtthuWwEUv5LM0tQydXLyymieT1NisFcGMkmi6K
 sBEGzMyxJXac9m63qMySp2Vgw7+i+l75YMK3TGUd+QQmmsQS0QuJUl6H9+gjiIttd9JhUEy0ag8
 oPKRG0/3nqlIeWoW+BSArdODPwQOPm9aSNRYsCDvx2ZAsh8SRaXfFf8qbHRp4NPtUpSJ85j5wOF
 w523xt/Q3nCqIPbnlRTbIzh+n4vGRse50w6chPTpU/TRK11q7M9yufRnzHXJoQt+kkMG3lySg0E
 8K3lYzHGyHIFlobYpj9Y/1O87moGKk5kfl9QCjWtb1IfqibirgVJbTZ8OdfIGv7YpO+Bf93FaLh
 SjR0+s8GR1LqeW4DrFFIBaUAFAvJkoCKg0ZrkTlUKc+9nEygm4o9noAjW1UoX0+BgeOlFsF7MPb
 AWBGfwL8cgW5YjzsiJcMAGiR0FFpoczZ9py1FgkVAmKO94wk+phrVS9xkafMxlSrSoE/3HsCPvX
 tsDNGeQ/Px0ohPg==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Calling scsi_scan() results in all the block devices (and EFI block
devices) being destroyed and re-created. This breaks the EFI filesystem
drivers during capsule update.

Remove the call, since boards really should be calling scsi_scan()
themselves during board_init().

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/dfu/dfu_scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dfu/dfu_scsi.c b/drivers/dfu/dfu_scsi.c
index 9f95194784c1de00458843276872b1d23d023444..a234548ae46dc2a6ae1ca5770accb58f43782239 100644
--- a/drivers/dfu/dfu_scsi.c
+++ b/drivers/dfu/dfu_scsi.c
@@ -341,13 +341,8 @@ int dfu_fill_entity_scsi(struct dfu_entity *dfu, char *devstr, char **argv, int
 		if (*s)
 			return -EINVAL;
 	}
 
-	if (scsi_scan(false)) {
-		pr_err("Couldn't init scsi device.\n");
-		return -ENODEV;
-	}
-
 	ret = find_scsi_device(dfu->data.scsi.lun, &scsi);
 	if (ret < 0) {
 		pr_err("Couldn't find scsi device no. %d.\n", dfu->data.scsi.lun);
 		return -ENODEV;

-- 
2.49.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3C6C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 13:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9251C8192A;
	Tue, 25 Mar 2025 14:03:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FDX/WoRF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF0281CAF; Tue, 25 Mar 2025 14:03:00 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E608981B42
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 14:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso35161545e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 06:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742907778; x=1743512578; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cQRr6w0G6zC7ZGJWBs0blumcTdX6WaxdGqlr3sVH2V0=;
 b=FDX/WoRFh1FFj9AX6cBMSUL7Hp/4jZg74LgCooQPFoP6KRItUiBHiAVgWrzfTgVWXS
 v72irrAKzPNeASdAu6sdvdaqi7wt5dWJLWlv5Y+ZTZqyw7dO6bdElbQLzk/m85pvman6
 DocVYAgZB1PaGUCQnR00+nygMTUZGdLjhGVVLyX013792gcVnvpktW5l/TWc+Gw38c1c
 +/MxhYGtmNwffNH1wdngQr5wtPAeQlIY1QVcWLxM4ESP8mrkU2Gsf6nt+uMlu4z7nTmP
 djGrrEx5HUsdbuBFYgRRWn+0DTp9/NZUV2d/wjss4xAsFU/MkLfwKTs7BG5l1d2dq32g
 mzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742907778; x=1743512578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQRr6w0G6zC7ZGJWBs0blumcTdX6WaxdGqlr3sVH2V0=;
 b=SwHllWgcEMd3VgA5OnvQiaNpEIiNgaLiz4Z9ENN/4+3Y45tKYs63JKEBoZGOmxy/Ys
 THJIy2tUsiKaP5E7jA7dbkLp4s206cfXhLclmxgMqTgRflGLBLI9en5+7nrM2RBrqOJC
 P+ld/b6U4nUEw8zBBNR9HNzE2p1X1uG4dpwBRSRKF2j5YoACXu4QZQCNPpPVG2rVRd6Q
 7zsbzdJZNiUZF6jLPMY6Ie/q6I7ZdHFFbO1SbcMTBqjynnqRd1IEqQgGLSEb319K6YmS
 mDo8E0lKyJGAme9B5LEOhLBjAyk4M5lsSOW9JAeuFYILqOacYJ7Vv/C41knry2dlTjLf
 4AvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhUpRdACLRj1Qahlam6J/PHby6YpMhilpfxfsrElOTGV68nblfjwaYbr+NCxdXvJN/2isveZg=@lists.denx.de
X-Gm-Message-State: AOJu0YyX8PMaX1ekmv/xC07i6peUDCTVQH+98z9oKYUQOUPSQqg+usDr
 fUKHdx3EXoDndkVwIGgcLBqbN7Fxu0mMqsIoNmy+zr2UTur9h16KyJYi20JhPW1RUtnzIU1FLzx
 /WeQ=
X-Gm-Gg: ASbGncsDl3+lSSh1rqJfHGx9tRu+6drAdbiMkN66mSvIRlylPfgQVzXSLMc0/A/RO64
 Yd4T/uAZkSxE+wKqgPHjQC5Wx0PPW5YRbMfLdTj00UG220Kspl15f/4WR3+mda3Xq3oVdEtQF5/
 cKQ1crDhQw1yHbzfDswXkVg89+BL6f4wuH8t4F3dGnrhN5U2uX6yHoZLqvtBmWPadjazpY78dSf
 C5U3B2YWRdZpRUM+4FWhVDp1Pho+I9OuZ1n2PMLG2J8U9zNrTtIKaSvAC+pIJTFUpsaM5qoGbRT
 7rLdik93UTwcMuSTGnLZYNRnsqGuzlr31vMoleqIikscGXvc9IIPtzxD57UDz+jc6L9E4TFARgz
 af6/ZX4UJBOVD
X-Google-Smtp-Source: AGHT+IG6u7/NTzQ1N2ms2KDi+fZ+pCEEDc1NXkm0LhZDZvf5NjCGO2axT6gQY4c2QaPr5VgniKCe7w==
X-Received: by 2002:a05:600c:4fc8:b0:43c:eea9:f45a with SMTP id
 5b1f17b1804b1-43d509e43c1mr161154595e9.4.1742907778194; 
 Tue, 25 Mar 2025 06:02:58 -0700 (PDT)
Received: from toyger.tail248178.ts.net (i5E863BED.versanet.de.
 [94.134.59.237]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed793sm204706095e9.39.2025.03.25.06.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 06:02:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 25 Mar 2025 14:02:52 +0100
Subject: [PATCH 1/3] scsi: fix typo in setup_read_ext()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-scsi-sync-on-write-v1-1-3575aa1342e0@linaro.org>
References: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
In-Reply-To: <20250325-scsi-sync-on-write-v1-0-3575aa1342e0@linaro.org>
To: Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=HiJHUQ0As//uZbfHPVnNG4S8lluRU1JKy79JCOKudc0=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn4ql/6a+ai2uyx1sWJKoAqwsAiM6cl6H1o5OJS
 NBmvGoZFPuJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ+KpfwAKCRAFgzErGV9k
 tuLxEACNCEI8tvKAA79WUOm9AI/0qgmA1vQaryWAlpyjtDIFZi2Y90nD9yube6CyRdoSnt9ZeuH
 ND0pPw2ONQxGg8YFcb3wYFRRycc8A1RFl3VPXgZwk5k1rXJ02dGE0amzIWUnDA5PDuRa7XUB54X
 SPHSv7KXnedxaZZ3W8aAPsdphDyMWFwlgm/T/ILeqm8C8fUtHAkINndYPrlfoyOXrNFelc2DLYD
 pAlFDeSnk0rfGJiBdZgqveP/vYFyzahwlvqBPmtO5TX9x/ewmnthliFiqYdhlDUElzkSuVQtxsP
 COW4b6jKW2FARSUrL4Xj4q1RzwLUJVmjaZCkP+SpcZCVd9EAkeOIN00F4yN6D6SRZyfSdiI3OrM
 z+hVtjGW/Y81DABbRpHeQxddzGzTIuuJPlD9iY3U/jYw2xtNH8lamp9OHwB1DIBVDYpggulcMD0
 uBULcq0yUQ4tdNHAUP1vWTPuGeYhVbTQsWxHTNIbcyP2aOVwbwcJ825ZzcxeN53LECvAADmObt3
 jx1j+QhdVidsOAWOuVm8MdKs5GumJq73EhghNieoEz5XxBhx7GgkR9xQnFkw6Z6V4slyjvzSqjf
 oOfYLuOfUsQdBbWGx7VAI+xShh8z6BLq94YTzWz75fpS9f9QdlYs03nhF7MMEZWe7l4u39PzSqf
 tSTBXnNaUhZaDYw==
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

This clears the 6th byte of cmd twice rather than setting the 9th byte
to 0. Fix it.

The only other command that sets the 9th byte is the 64-bit read, so
this likely never caused issues in practise.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/scsi/scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index cd0b84c062252118d250b9305728e03f61736600..34ac47c03ab397ca999abf130d84ccbd3be4c419 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -89,9 +89,9 @@ static void scsi_setup_read_ext(struct scsi_cmd *pccb, lbaint_t start,
 	pccb->cmd[5] = (unsigned char)start & 0xff;
 	pccb->cmd[6] = 0;
 	pccb->cmd[7] = (unsigned char)(blocks >> 8) & 0xff;
 	pccb->cmd[8] = (unsigned char)blocks & 0xff;
-	pccb->cmd[6] = 0;
+	pccb->cmd[9] = 0;
 	pccb->cmdlen = 10;
 	pccb->msgout[0] = SCSI_IDENTIFY; /* NOT USED */
 	debug("scsi_setup_read_ext: cmd: %02X %02X startblk %02X%02X%02X%02X blccnt %02X%02X\n",
 	      pccb->cmd[0], pccb->cmd[1],

-- 
2.49.0


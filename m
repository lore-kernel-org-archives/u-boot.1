Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 032F3CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:52:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7341283544;
	Tue, 30 Sep 2025 17:52:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xH99g5Y6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF4EA800B1; Tue, 30 Sep 2025 17:52:28 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2068802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:52:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so36441885e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759247545; x=1759852345; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SIofSK4A2dB1bGsknrp5lD8uwdcvpEtyNoPB5kyi2Qw=;
 b=xH99g5Y6kAYw9kRhVNNI+TWoADHQNy/mlrBnu2V+qRuWhxy5eUXvEvd47EVamTCSEr
 AnV3j9qB3BSAq8/oDIEuRpeZi8pD7vgAVqsHNWcmSAJ6gOJ/uVtbqWOKFUr2IC6216n8
 XwuLwTnxI+dylnSvbLMVhwxBqOSK0udikv6SOGcUkqGxubpj4SFMtW9+nJlzuIJkRmMu
 s9augSlJZsAchi69uaCaD0yaQvS4enW/BfW87jYI8EjNCKmvb4+dcanlKv8vUqsiKSAh
 on3lnEIqwiLqmke6P0VCR5O/ohPUGkXUjbaoJQ0fL+C6skaXHjeRpZNsVlvqG9zgsm6x
 ZFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759247545; x=1759852345;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SIofSK4A2dB1bGsknrp5lD8uwdcvpEtyNoPB5kyi2Qw=;
 b=LlMMQbZNLx0iRdFOH5QWTOvgJu5nL5jMv1J64ZVicRhp8crP4f4AlKGoPBu1sHs1CF
 NrRMDoGkGqCIzXwbplPMRZ2XBQw3n/M9Ble24eFK9Oyp9PNIahjYQ2XrhKxeMabJfuhz
 AlBX9uHV7kA9OFzAdhB1ZdfvZaYYEu9BjkC8tDRvUc3lEkl8dblKRttTS1de/5N+71wT
 TylvHdNXSrWdBzGuPvbrukv+q92YaAofo/o2dcAAS8X9rDU+Bsic6DKx9puMiQ5bIzXK
 Mxkzh1CMSzGLzil8vNbFGYtaPj2DvEQYyUUUj4ogfG4gg4siWrEgHhoYOIfuE80SI904
 rJaA==
X-Gm-Message-State: AOJu0YygWr/QU60q6C/JCqSKZIPA863Yzz3YwsaM690lpGUy/+fpxzL8
 cpFnmB7pBGhjKFLzkeCZrB06BepphgUQuKGvHslBULeFmkgaZYA4VMY8zfEggKyoRb9JC1TMgGq
 BFLt6
X-Gm-Gg: ASbGncuZ4GTEzqrSFBEo42zEln8ujYZoTEt5fIyHlkHi7EFw815YNMbPwQ7d/nnSsy3
 z9UErsmLlT2w+kimp+tUS+ZKrdqXLvu/KXxM4bJUU3uElP7hzI4WR9HZqRLEtSB1EiVN0KM+eNI
 nCue0gFQma5Vgen4hP2kAYCwJGoqIV5bvPas/nV0lg2dUTy64TyzCC5TtH5+Z6uD8cBsLsvYOuW
 PkFn56F715Y9Welu9Xx5zYbvVWUreqM+TEm8tGeEuwZEqUxepq8Pdu16EwfXKc01mRySVnSu37q
 os6BuF1qkSgcVhXZBatsdeB2O/rQlTIJFcU6rcuPuPOYa3Hu7mnm1tybjg8pEfbt3YfZIrZ37Rn
 Co3nEUtY9Vsw4RcfpChcU6cEkfoDN2o7FbDR1/Oz7tPNutlu9krkqofyVn8kD5kUY3sLqDZ7/yg
 ==
X-Google-Smtp-Source: AGHT+IGMuJJBzYj7MUlwRv3nFqz2XEbHJ8ZLMdTdSxzugtklsPZBVPsA11ypR5IxwxgO2LvatuqR0w==
X-Received: by 2002:a05:600c:474b:b0:46e:53e4:9fb9 with SMTP id
 5b1f17b1804b1-46e612be956mr2653405e9.20.1759247545084; 
 Tue, 30 Sep 2025 08:52:25 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:aed:2018:ed42:d786])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f3dcacsm64747165e9.2.2025.09.30.08.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 08:52:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Tue, 30 Sep 2025 16:52:23 +0100
Subject: [PATCH 2/3] usb: musb-new: Limit check array index before use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-usb_musb-new-v1-2-be0c9b79a8a0@linaro.org>
References: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
In-Reply-To: <20250930-usb_musb-new-v1-0-be0c9b79a8a0@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, Kory Maincent <kory.maincent@bootlin.com>, 
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

epnum is used as an index into an array. The limit check for this index
should be performed before using it to access an element in the array to
prevent possible bounds overrun.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/usb/musb-new/musb_gadget_ep0.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb-new/musb_gadget_ep0.c b/drivers/usb/musb-new/musb_gadget_ep0.c
index ea65326ab6264492ea668ddd047b360965a5ad19..25b1de6e58f9e2028e9b93a600d532ae0f5efcc1 100644
--- a/drivers/usb/musb-new/musb_gadget_ep0.c
+++ b/drivers/usb/musb-new/musb_gadget_ep0.c
@@ -96,6 +96,9 @@ static int service_tx_status_request(
 		if (!epnum) {
 			result[0] = 0;
 			break;
+		} else if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
 		}
 
 		is_in = epnum & USB_DIR_IN;
@@ -107,7 +110,7 @@ static int service_tx_status_request(
 		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}

-- 
2.47.3


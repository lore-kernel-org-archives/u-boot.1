Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63845CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 10:37:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 689C080107;
	Wed,  1 Oct 2025 12:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sdZz15J1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C7E82998; Wed,  1 Oct 2025 12:37:04 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3792800B1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 12:37:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e6771c523so561195e9.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 03:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759315022; x=1759919822; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VWi3z0lab9bXyQWEIGEgNAZ/uq2cM8i1nh2QJRfpP1w=;
 b=sdZz15J143hjDhBqG7qtQugmxSRxxmb06XGWju/snBSMZoTZLKlLfxsbG6DswanHH7
 2p8HnRrdjVJTMbxed58YUIbpZNuOB1kVLfiHLuUB6i9xifk43JsOA/dSsHmO1f8+T71S
 nLokOq2v0G/OJrNuqu53+jAIIOF+R+TVA8lyMcOZxUp9iNO3zh5NZ30WK39w19IKP5XA
 v7jfGrK3aeiyhNH4Rk/t5Ie1ngH665erWvFUXyUZiT1nc0Wd8z1cEsbHVN5PYPgKfmPO
 S9O+DKHesIWk8EBcYlfptbTELa/6T/as4OCDggr+Kf2Eh6362BDhC4nVKn0rb77ndwLD
 EnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759315022; x=1759919822;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VWi3z0lab9bXyQWEIGEgNAZ/uq2cM8i1nh2QJRfpP1w=;
 b=Jj0UqjgxvsooRhdaiL9UODRRbID91knqbLQQPoKO0S3sEuzSkxVV3usMNxOHzS/5+O
 CUSkEwfQdttL1eogSz709uJuTnfdjT27+USoWuNwYfylSI34HkvvGsj2ScQYjAktxVVK
 QGP5EBQdZQ2gjCWT5ye06Cp3MquCFdRBmzX9b9rGG5618viVIhUxDQM1lKdEsX8xml2L
 UqzTx+pqqGbHkIU7XtZaB3r+8cTEGwViQojrfiH/ddIyAIeGW/vb5HxGE0VoLUkoDCkQ
 S6DV92/07TLU1BZICvWzQr/R6itlpVbjmDz4GME2oAOQTlubMRMfnB5GD24fGBAV3hAA
 +Ukw==
X-Gm-Message-State: AOJu0YzxY2sA8+5knpEVoJGRqmsTRW5vKJkANym/oNwXzLmZRAuQyxKD
 s/qce2LPkB32W7qrRuFpYhNnsUOaw4Ir591P3Dc2vVDIf/MZmJ0Q8zq/8UQMGyiGWyI=
X-Gm-Gg: ASbGncu+OEhw12RqIXFSYl1asjZ14q+dBPRdWF1tjzCWJVVu7ExMf/RvayiJ2Zrgz+l
 GwlhUVDHaYazEKCo9nxTBVqFhlN1wAXoJluBXSIrL91FwbOdUOqsBnCQhM+8diziRJKZcxRqKV8
 9Jf2+/OCplSuoX5nHHJR/ajtoKm58MQOHBYBMe4ZdsBAS/BnFchAVZJ8I61jgZcvVFouAi6f8bF
 Je6LpIbsV7yBAtZq4N1aUaAllfUd8KsI+Ay/Iug/aQKXW6GDSZtHrL9SUo0hwDhwONiKGad9qYd
 zDMVLghn+AykC336ESljEdBQTtYsNohNfNQqMAULbiA6CgXHQO1Dv+p7RRbPtRj5OdPsyFLNZcP
 kXtrtW4D4xdTGqpBT6UkSr4PZLLiSjUcwGyrkNbWwGSupfpvHnDVPmrjzmvH0YE6AI8ajf4ihCg
 c=
X-Google-Smtp-Source: AGHT+IEZBGt3DZBjgmbElNa2MJ0KaM3WoedzBkT0AQzDNu11a5I2rXhZTEukF21WEZULr68Oml2pOQ==
X-Received: by 2002:a05:600c:1550:b0:46e:35eb:43a with SMTP id
 5b1f17b1804b1-46e6127bae6mr25487885e9.15.1759315022052; 
 Wed, 01 Oct 2025 03:37:02 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:ebd:e301:2e91:499c:12aa:e25c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e619b36f9sm33261415e9.19.2025.10.01.03.37.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 03:37:01 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Wed, 01 Oct 2025 11:37:01 +0100
Subject: [PATCH] video: rockchip: Set return code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-video_rockchip-v1-1-4933bdb56990@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEwE3WgC/x3MTQqAIBBA4avIrBNG6f8qESE61RBkKEgg3j1p+
 S3eyxApMEWYRYZAiSP7u0I1Auxp7oMku2rQqDuFqGRiR34L3l725EeadkQ3qWE01EONnkA7v/9
 wWUv5AFBQjJhgAAAA
X-Change-ID: 20251001-video_rockchip-a480d9178ae6
To: u-boot@lists.denx.de
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>, 
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

In rk_edp_start_aux_transaction the check for "AUX CH command reply
received" returns ret as the error code but it has not been assigned a
value so this could lead to the calling code silently ignoring the
error. Instead return -EIO.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/video/rockchip/rk_edp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/rk_edp.c
index 0ba68dbce3d126f8a3230435ffa0f780c1e08d61..7186abc9c6c93d05e774e61efa136bf98ff727df 100644
--- a/drivers/video/rockchip/rk_edp.c
+++ b/drivers/video/rockchip/rk_edp.c
@@ -216,7 +216,7 @@ static int rk_edp_start_aux_transaction(struct rk3288_edp *regs)
 	/* Is AUX CH command reply received? */
 	if (rk_edp_is_aux_reply(regs)) {
 		debug("AUX CH command reply failed!\n");
-		return ret;
+		return -EIO;
 	}
 
 	/* Clear interrupt source for AUX CH access error */

---
base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
change-id: 20251001-video_rockchip-a480d9178ae6

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F18C3601A
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 22:54:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CF5B820F6;
	Wed,  2 Apr 2025 00:52:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lBWA2cuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B91A81FDE; Wed,  2 Apr 2025 00:52:56 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 690AA80F6B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 00:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39129fc51f8so4518354f8f.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 15:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743547974; x=1744152774; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vCyZRTYLDfmguNjxIS97kTyRoqTJ0HpdK6Xxma5aFOA=;
 b=lBWA2cuNDOLQyDuiqaAWxtBeeX8zygagMXfDqpuYwpKTdVOs13GY/Hz7U0aEfMUBkA
 6I76j62OP/oggRB9WXbxokTE+mJ1qa7KSiXCDB1s6FDgpIXx2xjlfi6oxmarFJovzUhU
 uHBNHq9v2UGXqztnRdLhN0uc1vcZNU8nWzbVIBI7N9wcrQVsZGFeeV36cv1HF4qYrlz9
 rZ+Q0ulTGGT4jOZ3VsiKarsBgUz8+kpCJSLtODpgX+DACQvFf3t0fDFXq1dqftF5LnO9
 9ANr3WW3H+ktGcoapNop01OrMO1PHmlpdsnPujDLFzbPt57uMVEoCaYukTFgkA15y0ez
 WVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743547974; x=1744152774;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vCyZRTYLDfmguNjxIS97kTyRoqTJ0HpdK6Xxma5aFOA=;
 b=pnu+XF/VEwHBfm3VHJfAzV0VRX0+Z7XS4NHhFlsD/j7l4rO8LMbVuDkhIa6hA54j+9
 9aWeRuiFhP1YYy6PHBCecNK8CZiM41pE+F/q64sZzq32hB4H8M+7KlrMO/rFCyerD4ls
 IIczbnaV3Z+J0DKd6F+Fr4ljl/roo1OcgEl78f1It1Kspc2lU7+iCleOxLWZLosN9F1B
 5O9d7ApRAvbY6QM/nvtuZdwHM9oc+UeFAPutPKMhkJeSrBppTOEMfLXr9t3sVNHKLCN9
 wqH66GpdJN5iBJ7W8uCVSV8Q0PyfEtRQIemAd3QYwjZ/+AlCL2AUVI/y5SRskQA+EjRY
 FDyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgsJ0n3VzcLOXT7Mb3YpADMk08ZrFGSh2KE61ryFSeM2GPCjBkCIFaEBB2qiYnDg53KJF0+1U=@lists.denx.de
X-Gm-Message-State: AOJu0YzY4YATjIHDVaoj1hDxdwYqP9ymQQbtTJawPq/kR3CY9CA9GXgW
 8FXC8IFF182KfQLviKMnazHucC1WZQNSkfbpMckSFMLD2PGklHN2
X-Gm-Gg: ASbGncvnZZ1lftcGnxF+NLgqg2HB4Ilt2tvPMdlFO0fbVYCCl8inPFAzyV/DwvHNlw6
 Nm/P12whDW80lu6g2Qaj3zeZ+i+219nFLt2wTxc7refNnS1ih2iBz9DpGU0puzFAytV2XUWr/Pz
 SHEktCOgGh2JAhV2xPBdmLQbBkpDiANpKDioUG2EObP5FjR6NuRF/+uw/mANX3RA0tR0lnvfUTz
 ZJ0o3xri3obmNDwCksMjViS2751PG2Z3KAUbU97SEIxYcKcyo1xM1eTQgrBMZVl3BGNEkYaKlXt
 IMGLEx8ng5Zt380p5yvYjkpgHIqp4DJltddCu6m42iwPYxiSLDWoQqZF1+ohQXjsze24CFm4xB3
 0iVlXqP+hrLx9/A==
X-Google-Smtp-Source: AGHT+IFPZC5caVT0NPy5IonABzspDBarGRQAAJy7oKiKFWxIlNP3mVXTGEyvfv31fh5hx25WZVXMDg==
X-Received: by 2002:a05:6000:2d10:b0:391:ba6:c069 with SMTP id
 ffacd0b85a97d-39c1211501fmr8356275f8f.44.1743547973790; 
 Tue, 01 Apr 2025 15:52:53 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd77bsm2478625e9.19.2025.04.01.15.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 15:52:52 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Bruce Suen <bruce_suen@163.com>,
 u-boot@lists.denx.de
Subject: [PATCH 14/14] configs: airoha: an7581_evb: Enable Airoha SNFI SPI
 config
Date: Wed,  2 Apr 2025 00:51:46 +0200
Message-ID: <20250401225156.25790-15-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250401225156.25790-1-ansuelsmth@gmail.com>
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
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

Enable Airoha SNFI SPI config to enable support for SNAND flash.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 configs/an7581_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/an7581_evb_defconfig b/configs/an7581_evb_defconfig
index fa41a4bca97..c74247e13db 100644
--- a/configs/an7581_evb_defconfig
+++ b/configs/an7581_evb_defconfig
@@ -78,3 +78,4 @@ CONFIG_DM_SPI=y
 CONFIG_SHA512=y
 CONFIG_AIROHA_ETH=y
 CONFIG_MMC_MTK=y
+CONFIG_AIROHA_SNFI_SPI=y
-- 
2.48.1


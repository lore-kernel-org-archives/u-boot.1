Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C54C47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 14:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E88887C38;
	Wed, 31 Jan 2024 15:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nVokPC+y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6560987D7E; Wed, 31 Jan 2024 15:57:42 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E500C87D7A
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 15:57:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40e913e3f03so55255605e9.3
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 06:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706713055; x=1707317855; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ocX4wCRr/xKYsymt+/N2xCve0tHPW0XjSRi3+zxaAuI=;
 b=nVokPC+ywQCO16nbSrgOl3rqCCrlFNz2h9pGbPx29IyKs9T/ATIoNczCwBO8/eeTP9
 VjAqKi2oQZZsa8ahyuMDIL2vwiyefLUTZPB5hRxpI581QpnoVmL2ehps5aNkiKVtsUb9
 PGxtTSoUPbrbjiHKU9JQG2EhZcssu0HeyC91mKoT8Z51G0P9rIk18CJBviETDjIZWxq2
 WBrJTpihz/cfxy4fBOH/MRRZa5uMRDcScL26YsvHyXsEPh6BUDDuXORWW0NYNbyalLuz
 1/cN4EsG5gkA44/m03BMyz1FedJgDd0PkOIMXGu47Z16PLVQPokTv88CcoczLoTMgn2P
 8R9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706713055; x=1707317855;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ocX4wCRr/xKYsymt+/N2xCve0tHPW0XjSRi3+zxaAuI=;
 b=XawCa2fCRvQWIZ2XLrxJzcsZqwU2MuRdvpuPayrassrrcXVDTc39w55pPYhmInszF8
 gAv0py5aHorYuQik7IvxtJ0SGfUIAz/HM9uUvGVzYdLZCG5hM9PJ8A8RTZ+W8yhjzsZT
 2VnNUqPvDj3nktLhLGzRuSMCenIRYQ/W5V6w2u+/VZ9DecWpzGsR/Zlvgd+JMT+nfy1e
 A1Invam9kaD3okqCLBUqH1N/2sFGy/VQRwAMMrfSsYjw7s1P6nL2Sy7dg3kwWOAYkr3j
 cSPY3pe6o6nGntetstMZQCquVU9DRIkLYuG11to1qny1+KgvlgQ+RRzILR171MVQIMEr
 4XUw==
X-Gm-Message-State: AOJu0YwEC5YjQAlF22P4Jsm3AfCuxydR724uBA6dcG4z9d9NaCaKWYwE
 9h3uLfLG2Gf2qrmlQLXVw5/Fur7zZXUAvvmUdmNpRvgmGd/7u1TDksWDhS9uCSw=
X-Google-Smtp-Source: AGHT+IG6qGh2WhN338n4AFg20OiMFwuz9ig0yq/qv2iIKl3IcEqyP0O0X0Bx76bDNWah47LRpZd5fQ==
X-Received: by 2002:a05:600c:241:b0:40e:a7cf:10e0 with SMTP id
 1-20020a05600c024100b0040ea7cf10e0mr1696622wmj.20.1706713055472; 
 Wed, 31 Jan 2024 06:57:35 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 a15-20020a056000100f00b0033aee3bfac5sm7841912wrx.16.2024.01.31.06.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 06:57:34 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 31 Jan 2024 14:57:30 +0000
Subject: [PATCH 5/5] iommu: qcom-smmu: fix debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240131-b4-qcom-usb-v1-5-6438b2a2285e@linaro.org>
References: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
In-Reply-To: <20240131-b4-qcom-usb-v1-0-6438b2a2285e@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Mq4dbCoqOMRKge7c77AI6tE+8zvp4+6gdSSpmZvsAPY=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRd8bfOruUuWrN/+r+IzE9P1p1JC7Z1lY3xOpdiNmnW9
 XUWQj4pHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiv6cy/GTUEl/dtrIvR53n
 4Iy7j9N1uwRahdb9nzh9C/929l8yJ/4z/I/f5XbsX9P5gk7xzo/f97CdNvAUtpje/TfZfglP6K1
 NsoEA
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

The priv struct was wrong in dump_boot_mappings(). Causing errors when
compiling with -DDEBUG. Fix this.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 8e5cdb581550..f2b39de56f4a 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -319,7 +319,7 @@ static int qcom_smmu_connect(struct udevice *dev)
 }
 
 #ifdef DEBUG
-static inline void dump_boot_mappings(struct arm_smmu_priv *priv)
+static inline void dump_boot_mappings(struct qcom_smmu_priv *priv)
 {
 	u32 val;
 	int i;

-- 
2.43.0


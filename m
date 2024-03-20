Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6672C6FD1F
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 14:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0ABD7880E9;
	Wed, 20 Mar 2024 15:31:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iFpZicEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F37588085; Wed, 20 Mar 2024 15:31:38 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9AB880D8
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 15:31:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-33ff53528ceso2691135f8f.0
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 07:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710945091; x=1711549891; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PaOzLG56DkFB6GBvEZTyeRoaiYCJeFBFuCa0mEQreF4=;
 b=iFpZicEtJNtF5jFq8pVKopvpYfjvHSQA/m7o4/RKdrbjFtkSvACfX5GLvM9rhrppXZ
 2f/sNsXhd/75SAzE3xDybmlMsRO6FPzSKL2pLuVgzSRU4MKAN5VpbyWcry2XMaQMcBGo
 V6o4mN2ZNplJX8a0dpdAMmwssonKcmEYcSpPKBnbHV+UNwVmLQ9Hai0oVRwHcPB59ull
 ucJuiVumqsr6n30hVEo6ce7zYXXw/EIh29klT5xWAqF9wlSdIBZpZXQD6toiet91qIhg
 u50sJzPqfEz3Y9s+5yYunxwmPsiQHf5VccYt9Jo8smi1C3p4e0ZLbnMSdPMuBWk+VWRL
 zbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710945091; x=1711549891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaOzLG56DkFB6GBvEZTyeRoaiYCJeFBFuCa0mEQreF4=;
 b=SPkE6r2xPxE/XiiS+3hVOGQSZYYW5EIJO6O/q99d878HiaqHLFkn0kbVjvrgvLL980
 QerBF+ziWtS0Vh07RNtN/TAjAB0vQbscRQWql00zrjxiqvrQK9baq9QxZ5XMhY8O8q1c
 glDPg1qv/b8OCJMYawjblpq4kbXslAll6rvMfS1KOeYVEWI5lKcgRYct5EO18Ip32o37
 UD61JT6A2JpaHO2WLtWKQinJGALvdWO8mGHR4LSXdZNXua/63BnNcNOwlZEx+BAB8KKh
 fvO5fWCTpsTEyUTtm+fS4Tbdr7pZTJYZIjk9L8JtbLb/Y/1h3bDfF/n497hahDRUgcqi
 C1Qw==
X-Gm-Message-State: AOJu0YxXZLlX9bYJYnTacbzIeeP6WlYKL/8di1bd2vhJJbuhgcniYimS
 qF/sZVcZrSzlTE3Y6hS7+qPyIDx2CuF98kw0vJm5S6g7m70MpvSP8Wai5Vhfo5g=
X-Google-Smtp-Source: AGHT+IHgy1QonwnIrwX+dH49snP4jyLk7LvLl4b64bkcqlxzFSYGzYAgS+M8v1nr46jpLmDhz6JT+Q==
X-Received: by 2002:a05:6000:188b:b0:341:715e:36d4 with SMTP id
 a11-20020a056000188b00b00341715e36d4mr7891641wri.29.1710945091253; 
 Wed, 20 Mar 2024 07:31:31 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 az1-20020adfe181000000b0033ed7181fd1sm12036571wrb.62.2024.03.20.07.31.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 07:31:30 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 20 Mar 2024 14:30:51 +0000
Subject: [PATCH v4 5/5] iommu: qcom-smmu: fix debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-b4-qcom-usb-v4-5-41be480172e1@linaro.org>
References: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
In-Reply-To: <20240320-b4-qcom-usb-v4-0-41be480172e1@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=859;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=JSWCwSd/ls5fMK87FWiDEcIio+ZebyBVKrf19XCSuLQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRfn23v2f46Hvs2xennRf2dMiqrNxV0B/C4p71dsmN+8
 9SvkhKaHaUsDIIcDLJiiiziJ5ZZNq29bK+xfcEFmDmsTCBDGLg4BWAiVwUZ/ko5eu9qKwvMTdTw
 kdcrYb34QHfPwv96f7v+fXj8JenBnH8M/+u3/EkUWVPfn1uz8+mcvYe/XW6brGT3fpP8peJHEhf
 z+Q4BAA==
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 8e5cdb581550..f2b39de56f4a 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -318,9 +318,9 @@ static int qcom_smmu_connect(struct udevice *dev)
 	return 0;
 }
 
 #ifdef DEBUG
-static inline void dump_boot_mappings(struct arm_smmu_priv *priv)
+static inline void dump_boot_mappings(struct qcom_smmu_priv *priv)
 {
 	u32 val;
 	int i;
 

-- 
2.44.0


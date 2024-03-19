Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FB9C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:15:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A70F87F30;
	Tue, 19 Mar 2024 13:14:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F9JFV7Au";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FF1788024; Tue, 19 Mar 2024 13:14:51 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8013F87F88
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-414617882b3so8556915e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850486; x=1711455286; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PaOzLG56DkFB6GBvEZTyeRoaiYCJeFBFuCa0mEQreF4=;
 b=F9JFV7AuVk6xC2b5zSCNApa9jaXgizBgx/jtaGhBZyFxhnZZiE2bd5QRxmWVSJsMWx
 hplsUzXuEuTLnAOhxFkoffybKD6ceda8ZTBWgS6IWuaL7p2BI0WKxltPhsZtupEzF3vt
 JJB84Z9UrAOGA7UchHEW7LNpW6ZRIH9wkYUxEo6AwDHt6eN2Dc7V5qbbaDs9IcXIKVnH
 ESLqlTL989JZqUlWDM3C8eJUuHIfDuioBFRGbEd9g/PkEUWksp5V/n763AdYcL8bGET3
 Ez4H4x6vZOJPcDpaU9nGPe0TRBPpk29Da4mpZpZBojEJYg0+P6LX5WvE6/PTQXLcMfSi
 opwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850486; x=1711455286;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PaOzLG56DkFB6GBvEZTyeRoaiYCJeFBFuCa0mEQreF4=;
 b=X1B1dQQZnspbzPD91CBmTzxQ+QreO98tjHnnA9podvKTm9rtglBT9v6nvtYOx+4x1l
 3zEQe2ikc2ruV4y9WUoJLsdeuSTpFLZvN7jTPtwNYnVfNW3JlSe4jzNzBUaphOe7VChw
 eLM/kpLNclteNWAm5/4BcfNHKMLyJxEUjVf8q54pXIz/fl/qSeN63eV3wuQbUl+zs+/R
 sW4aKqLZlORw5FJRJx0UQdXG6ehA/yvrt88+MQCE9fUf2QxXp9gbQ7wZWG5eyOUAWJkE
 UayN2YFz4u3eWmOfEIXhkjaUPgV0TcAww5C8ZX7p7k5VqiDjHavU35lLYosZ338yLG2e
 k6CA==
X-Gm-Message-State: AOJu0Yw+/uDqBCIAuA3qo+CvU6o7kgNVkwrw4hDaJL46XtY7DFAbKPRN
 NkXg4ML4Hj6uF/sUsv/6UW5sIAn6m3l4OHkqszpiepU3mG4UhPNHPFLiocGNlWk=
X-Google-Smtp-Source: AGHT+IHRa1szDG33P7JjqXaCUdbsuAawQG+eEUJhHa7CvK8oLNINwBMlOoQM0hJJ4Y3I3nQnhCvb5A==
X-Received: by 2002:adf:ee4f:0:b0:341:84ec:fff8 with SMTP id
 w15-20020adfee4f000000b0034184ecfff8mr1636656wro.20.1710850486046; 
 Tue, 19 Mar 2024 05:14:46 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u8-20020a5d4688000000b0033e3c4e600asm12345792wrq.7.2024.03.19.05.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:14:45 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:14:28 +0000
Subject: [PATCH v3 5/5] iommu: qcom-smmu: fix debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-usb-v3-5-09ba1f86d259@linaro.org>
References: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
In-Reply-To: <20240319-b4-qcom-usb-v3-0-09ba1f86d259@linaro.org>
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
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfjesdOa63y1j1N3Knbp6s+VFKaKt5pxSj3Nqgm7JGJ
 yTyHvh1lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgIlc+8Pwz8r7knlCbOtFEwbp
 Pyv4xHP2egtqXgx8phdne9Dh9+vGJkaGBr/HjK57d5yZI7XtpdT2L2fZM14YO/zYde/3btXQv6H
 qNQA=
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


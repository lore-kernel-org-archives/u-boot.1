Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8C1C54E67
	for <u-boot@archiver.kernel.org>; Fri, 15 Mar 2024 15:07:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7B4188023;
	Fri, 15 Mar 2024 16:06:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yY5MAZau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42DD288008; Fri, 15 Mar 2024 16:06:17 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70EFA88019
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 16:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33ed6078884so255589f8f.1
 for <u-boot@lists.denx.de>; Fri, 15 Mar 2024 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710515172; x=1711119972; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zbk4r4UyBzKuozH08fyGqwtHnRd654EBpMK0f9wmWRc=;
 b=yY5MAZauBCgd5QwuzTK3jztJryPWMGC74BpCQDaXg/dNJGq44KzjS4WIpeJAEVZqD5
 fNdxUhIvEt+DlAyDcsorH+tvcg9eE04LM8miTWMJraK66rQCnX5FDCbeoX2AzpHVi1O4
 aVNBeH2wmdzq5P+S0Un4plOox40OWChTxXGYGTvBzSb0CGKgEgWxpBPgxJSTlTo20OkY
 Yo4g8HcCqGt/wM8hkHYTzzzHv2R0H/08L62a4oy4CFLgGFxUyz47UnM6OA5Hu4FT3SAK
 DPLgWggJaE5efSj+7P9AHXnO7sPSlJHZDsnJ2/YY+vLjZwM4bqaWmqV/G/QDeueoRcMP
 WnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710515172; x=1711119972;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zbk4r4UyBzKuozH08fyGqwtHnRd654EBpMK0f9wmWRc=;
 b=HiNNvnN+k4htyF9fTTxvh+u25ab6uQ54rLtslnZT1gDHkOtC0bO3wBSqMoDSF1bAfw
 g2WwDL4bPTeJP+5d9BnoxAio8Uy5qhkkvZ8Usu2cn4axu0ZNr8Uk9HjleIR4wr4K3Aye
 bFN6eY0RCJYdK4IpA/s0Celgxvh8Zn7P0ujBPhVf8NdgnRmIX1xmDGo76JGAAHAqvoi+
 WD2sNgL/nm7rAAzV3+c0y08B8f+lQ3BTntBjDyk+zSKRX9FukdV/XXr4I02xU7LKqOcV
 ld/cCOp7uMSqFnfzuotAn7mjzKyroBhN3+dwD7ABfpOIjiSUe0RuimlKhF/RutlypqvX
 Yr7w==
X-Gm-Message-State: AOJu0Yx5/y+u7cVI2VK8eztBISXBovtW8b/KvqdmrRUmp3o4kcN1NJLn
 YBT1L9ym0XelkkDa6mrpWBsEbqmAjwICa0nXtUYvSk1hVt+Wwtd2yRBrwntTHW/vPbz5hHw5PBd
 K
X-Google-Smtp-Source: AGHT+IENJ/9sQd/0FPlqvidJ7nJjIqTeGucjcRO/C2MdO8C9cqzba6lwgMA62WubYJqm4w1laMI4Og==
X-Received: by 2002:adf:f5c6:0:b0:33e:2d7b:c5a8 with SMTP id
 k6-20020adff5c6000000b0033e2d7bc5a8mr6838335wrp.17.1710515171690; 
 Fri, 15 Mar 2024 08:06:11 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 jg28-20020a05600ca01c00b0041401fbe446sm1939502wmb.11.2024.03.15.08.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 08:06:10 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 15 Mar 2024 15:06:04 +0000
Subject: [PATCH v2 5/5] iommu: qcom-smmu: fix debugging
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-b4-qcom-usb-v2-5-5467ec27cb26@linaro.org>
References: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
In-Reply-To: <20240315-b4-qcom-usb-v2-0-5467ec27cb26@linaro.org>
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=802;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Vh7wChQ7oSn3qK3m6JbZXYrVDFhwkmOI9fGRczQh+FQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQvyXfvKa6T8VW6sWjfifvbtQLWtc2UPs3w8P/mr3zNR
 q+urSlx7yhlYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQAT6V/O8L9ye/cD7colsS+N
 5kxKPJnIccd+iinXo3d24feD83+fV5rB8Ff4D4tpWETV/pOlMSEFd14Lxnx+c2nd8TnzTgf+WJx
 y2zUAAA==
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


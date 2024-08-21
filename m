Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95003C52D6F
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 13:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1A1E88DBB;
	Wed, 21 Aug 2024 15:42:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fxhzRRWP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F28288DBF; Wed, 21 Aug 2024 15:42:01 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5838488AC0
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 15:41:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52efc60a6e6so9447535e87.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 06:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724247718; x=1724852518; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cqF2st4G7Whhok3VZo6aDGC//+kV3J+exZKhkiiSLFQ=;
 b=fxhzRRWPt+qpJciGSAITWCo8l8X60UfTDq85wh8FY7dCx3uklUdpEcoF9mZQvZEARc
 JdrCoNahI2M7n7uxXFkWNU8HAYP8adAfEIdzL9A74GE5HVYfUWU28+jLirmyAHbts2I/
 SdPX01laMMuUBZNO1+eQTpYWK/pAO7J5BnazS9JOOedrSlBLeiX74zICTx9l/ogHIvar
 oyR9/w28as1z3kdFFAACkxGoDrWsz0kGqhEBXGOOnKRQeXi16Wyq/ZOkZwrDs+ZaOCj0
 Np0K2VryzXH+5acK/T8VFyaO/kiwyVE+oBQ9+t4QRslHCVoK+vniJFjWJmyiLbcrR+VF
 Ug3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724247718; x=1724852518;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqF2st4G7Whhok3VZo6aDGC//+kV3J+exZKhkiiSLFQ=;
 b=luGrCmqihUFezhJWv4e5vJ9xNHo14vlaEyeUAxelx59D64ZJJ1t0Wp71nzKQ4MjeF1
 +a5ZoV7GeqYCdriLcYtSAm+mGfHYq6wqLK7MUxTJJXQiQ+8YNOE8O5jZPRQOnykhrHyv
 SGgBu95T4t2+iops0PoEG1WJgUFfQdguMeIxCF/3egeF2vbuiLdkag3f/P1oZ+WId9d8
 CdjoDP22VLYkI737XGw5dPYXjw8n5aElyW4w8a8+s/+LSHr2DqhP6jBRBHoEr96u9caD
 MD/ZJMxHUIF5HVF49slrJCvxOVaE1BLLfvGg6DsgTGbiJ1R04nnqmP4eIiihjxGfokAz
 ayDA==
X-Gm-Message-State: AOJu0YyYd+xZ/CF0vx8K/xUigIplSGcNj9+ZYg92++5jyNrmeP/Dw2mb
 YdY8603ttFOxzF77F9uZemMCCMk9Yqe06DIg4zk9AmmXVSdjOM16xI4mPU3kNko=
X-Google-Smtp-Source: AGHT+IEiWiQ2+rnq9ygkkGwKWRO1l7vPXtE6nv9tq+GTkhXNeXOlV9Q+YJri22fWRmcjXR32eVPTAg==
X-Received: by 2002:a05:6512:696:b0:52e:f77b:bb58 with SMTP id
 2adb3069b0e04-5334858e2dbmr1246801e87.36.1724247718271; 
 Wed, 21 Aug 2024 06:41:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::676e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83839342f6sm904164066b.137.2024.08.21.06.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 06:41:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 21 Aug 2024 15:41:49 +0200
Subject: [PATCH v2 4/7] iommu: qcom-smmu: add sc7280-smmu-500 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240821-b4-rb3gen2-v2-4-49b07633f3a8@linaro.org>
References: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
In-Reply-To: <20240821-b4-rb3gen2-v2-0-49b07633f3a8@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=735;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kxKBScKaYeuETfEZtkdyvgk1CIJk9dkzDtE1GYwaPOI=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmxe6dVYUKBuKYzxniyjNVxYEoPmLImzpJJVKSN
 fZ8OGllgq+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZsXunQAKCRAFgzErGV9k
 thhHD/sEX0G2aVw1Y8dD02U8Fg111EK/PNvDyUlifhchP/sTDJHxyzWJc0zxsb1FtSosTWlnv1i
 tgFSLVCLklzMwrcUCZb5Fe/9bWGRL6Uz0dEbDXZohGWagR4SC9MoM/shyb6R7Xm2ywwaR1dBkHM
 alh2af0YAoJi0TljeQz70GlUCBAyLiLhLD9/V7JDfkdAgUj1R7tGibGbz7plVk1ySD/JUbXLyRD
 Oj3l66FUGleJAA+KrvbPR5sVcA8Zt+Mak0xp5xyjQ0T8TUNfwJF0VUgWEpiVHWZGPgOgw2OnE5U
 Iv4mBGteHGHC0WjCdjt/thyn2+QCx/LjPwrBDrsyw6FFyg43yWEmDkEgfCiTDSHMtTMSPLvYbXM
 b00Egv5OZrrhIGahpHxdd2Ui/6zicLanexZopGSaMu4DnMnhfm7GGdRxNphtP9VMWwgy+vePa+a
 ghVuG+oIgtIOoEwE/SN2zBpMIxLNuzTi3c80xsxh6uA+5VH9X937eNFlB0fouXJjG27Jo4NSbKL
 oeSE2rLXYtJ2bCV0ee7E5InyvUsdzHynjewLM0usEvnFHn433yCibXdQ1VjAZJVOJlFwxt85evc
 Y/3ckT+iau+N7Z8un7Vhsp2FKf/IR5/QGd1NrfOyZuZ4V3ojqtD71Hymz1874HoW492BdpUytut
 5WHbOvM4jWAm5dQ==
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

This soc doesn't have the generic compatible.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 7b646d840dd4..1b5a09bb7b39 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -380,8 +380,9 @@ static struct iommu_ops qcom_smmu_ops = {
 };
 
 static const struct udevice_id qcom_smmu500_ids[] = {
 	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sc7280-smmu-500" },
 	{ .compatible = "qcom,smmu-500", },
 	{ /* sentinel */ }
 };
 

-- 
2.46.0


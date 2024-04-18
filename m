Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B94C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB5B886B0;
	Thu, 18 Apr 2024 19:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W9+gFgTe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BF288694; Thu, 18 Apr 2024 19:26:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B2438868B
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:26:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-418a0256381so7876165e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461186; x=1714065986; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5u1Os4mPjY9uiiBmDt0/pCIDUWOOpkIMsv7xW5JLldI=;
 b=W9+gFgTeEWrUw/FVhD6E6aki+bEDwroAG4QZXXU6HNPgSkXldf81CAwFlWKNCjeqph
 iOz8/LnkNASUR/yhshOQYoMfzIym4ndWHI9717kgDHf8kpCdugsJ3OEUYHNZmN/aXnhE
 +mRvM+s9PdEO2/quw9t6cNQEopqgysySluzahAel3t+TDLxYq8KMtcar62wfL2MaACii
 98qsvgEPoQ35dSuO7mTT4EZIFggq3ZsFfiodmW9tb/LNZy0dNTVxdTx8In2e8/GN1tjk
 yakOsLnPrGMapRsuzkK+/Yra6/nP9bqACoL2uwP/kxdIR3h5h5GP3YauBYpPyGRAY3nx
 Sdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461186; x=1714065986;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5u1Os4mPjY9uiiBmDt0/pCIDUWOOpkIMsv7xW5JLldI=;
 b=Xm6Q6emp3aOSMay7qpop4VBRPy6bOtNel7nkCGWzG5/bGZkA8NQZ6CoKAhFhf9vg9Y
 8AOZxyUZvcybD7rM3vGHcSrHtDQ7XbG64ivI/n8OtWdA1EtOTHuiOYQSoMura8PFDzf1
 86jHeqJdk/CpgErGl1974lX0yt39DOOPkhAWFpjBx/FsXpuXIjGU6DHL3V4GBtk/PWJA
 9j5SinrN7OMQKnVxKazzXsvWuDQjKNQLfw0dgFPlE5yJrQptkCXAyYxNy7ikpxkyPWvd
 uGhfhtCNe4w+UXMAbhde77eH8SarxWLnXcvl2KB1glzjdLwn8etwDoK2uLfT2e/AL1Hb
 RMKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQHtwHy6MhF8eCF0RtH+F4HmX5ENr7xbod7CZyn+tU4Ozx1YvPGMpIxZZiXo7fpIaWuVWTOXbysuV8XHM/TOsj22bD3w==
X-Gm-Message-State: AOJu0YwCZgpM1OZH8vSmM7IlzBuIfTaHNn/mufcaikNdA9Cs7kGK/OyQ
 2wBTLaaKXvOQIQcfR9SLjbGTu+PwcUrC+Y+iY9MVSMNB8KO1SH7IElXjG2zKQbI=
X-Google-Smtp-Source: AGHT+IG3kQ+YCSuI6IhveMM4jq62O3x/4XGXlLiAig3yXyRpvyH/zTRM+tABBgZyMWCETksSvU7z1g==
X-Received: by 2002:a05:600c:3504:b0:418:d58e:2944 with SMTP id
 h4-20020a05600c350400b00418d58e2944mr2515032wmq.18.1713461186520; 
 Thu, 18 Apr 2024 10:26:26 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00416b163e52bsm7166057wmq.14.2024.04.18.10.26.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:26:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 18 Apr 2024 18:25:46 +0100
Subject: [PATCH 3/9] iommu: qcom-smmu: add qcom generic compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-3-f5f19d52969e@linaro.org>
References: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
In-Reply-To: <20240418-b4-qcom-rbx-fixes-v1-0-f5f19d52969e@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=843;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=s6fQFUO8M4qjLm/bsMgQzOPNj/VYaDfmD9iMPRCs0DM=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTF8H0f3iyweTT9jldDx0H3i3/NjnGZl0ftmJb+x11Ar
 6Oy9Ob3jlIWBkEOBlkxRRbxE8ssm9ZettfYvuACzBxWJpAhDFycAjCRWUKMDN2NV5uvzl3GlNxt
 0fhpg87KUCnNaVITmt1lTbM+KRzd9JzhnxrrQxOj/quvpttf5tQ78n1x5eVjWva3Yn9ndUT93O/
 GawgA
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

With the exception of SDM845, most other Qualcomm SoCs have the Qualcomm
specific (but not SoC) specific SMMU compatible string. Add it here so
we can match those without having to add individual SoCs to the list
here.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/iommu/qcom-hyp-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index f2b39de56f4a..7b646d840dd4 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -380,8 +380,9 @@ static struct iommu_ops qcom_smmu_ops = {
 };
 
 static const struct udevice_id qcom_smmu500_ids[] = {
 	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,smmu-500", },
 	{ /* sentinel */ }
 };
 
 U_BOOT_DRIVER(qcom_smmu500) = {

-- 
2.44.0


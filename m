Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D35AC71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 14:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A55382E35;
	Wed, 18 Jun 2025 16:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="4aahYcND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BE6282CF4; Wed, 18 Jun 2025 16:25:35 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A09DC82D66
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 16:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so11855694a12.2
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1750256731; x=1750861531; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zmbzx3fh17rUAoJV7iZdc4u+J3qhINFVsKlxp8yGSa0=;
 b=4aahYcNDf07je/D1tRQjkgSmSpRBdAr0C99gNBOg/vZl/742JTuI00W0y8B7juj00S
 N85WOY8lN6i5mMKTmylQfjUoZBHq/tl3Tr6FGbwdo9hNLBYqiT3tiH5ffk8RRRS+jnxy
 YqLY0fG5jB/4eiXNTrMGG5GWiCiKH20iAA+Uv79JWVcqNH8faDTeDbgWhowobBETIjOv
 z1CrciqNlQGpdPaj09vdTJglznm/5tVOdLnCPd7ixiMbo4E1VP/xLMzbOnegRLcc6Prt
 BJ7Uf+FBjhGQAElflHir1IGIN9Q7Q2lyZIqRyOo8ebCI02at3bMY/uqJHt5Ilas32OBS
 KUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750256731; x=1750861531;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zmbzx3fh17rUAoJV7iZdc4u+J3qhINFVsKlxp8yGSa0=;
 b=Qm/f0AUEmjsrPLTr4a49G1cyEUmvKv2OUoyVCd+oPBv+JXjo22Yz+97E4DfACgMED4
 3Y709LBfNUS1AdGwGH5lRoyILLdNTumNzJSkGDPZSUM6ahcNr5N82AzuZ2qnjynWGefP
 LSjbdlG/H8UT+lk4onY9SzfqgSJovAdZvy4hwf75Flmx5iGNNUAAokwXFhOV1yHc3tMJ
 Q5G2wuh5dQzxmnUuUNuXX3YezKfB21x6xI3qSqRiwgM9CI/zrkVLYmo3+gVk4s7mltii
 b1Xs1sH9xYT3QRhVj/x+yXOV0OORnr0Onth+TMlrM0pHTVEWKfYrelvCURs+CQMpAeEu
 rlnw==
X-Gm-Message-State: AOJu0Yx+/SXUqDxvOus7rUPREP1JSxGCRmDk6xM6SZtE3sEp1t0xbuG8
 FE6pEoHDdyW8Sn2qeMoNHw0g6W0GeMb8TAWNvRqindmggCRqXuOWpwjZonU3JZMGEIo=
X-Gm-Gg: ASbGnct4qYJ2hAy42vCLjvCI8NlVqQK5t+cp01z1NZhu11qx02Z25cNZIU5BGAFy7gP
 PpkRjWJyBRuIki/bIp1BA4MSbI3stZyTzE+5zolPJUK2j7lH3tLRtRvxrLQT0K3MoQ3Bp6i0tZc
 v+gS5bSg05hYenVH+hVwLJtkIbqVryM3KheHwriZHJ3sdW9CCQSz5Mn7swg85BQ8IOfOLMz7hRU
 q3UTfTyClTtYYftm4mHrpvW08Z7pzCVJuCGqYT2Mlu0TwSVIpt+CZgBPGQJWUuo4EcXUJ+DN6T8
 u1v8CnQUdpQp2juti0J46NdRNPNR7MGHWAAUK1y/6KTjiqnFgRmDsHjEUILs79c0FCPGzae6Y8z
 uWguC26VZpHiNiOOUG9DMLdm1borj7LiX
X-Google-Smtp-Source: AGHT+IGy+TS7OuP6QPNVAHs+Gx1zzTa042DNHAaSGFRL+JdTXMiPuQa6lSOboQQM+Ymuik3MFpDhSQ==
X-Received: by 2002:a17:907:3c83:b0:ade:348f:88ce with SMTP id
 a640c23a62f3a-adfad29a1a0mr1803977366b.12.1750256731041; 
 Wed, 18 Jun 2025 07:25:31 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-adec8159e19sm1056733866b.4.2025.06.18.07.25.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Jun 2025 07:25:30 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 18 Jun 2025 16:25:20 +0200
Subject: [PATCH 4/8] iommu: qcom-smmu: Add qcom,sm6350-smmu-500 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-sm6350-bringup-v1-4-3cc22aab7a7a@fairphone.com>
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
In-Reply-To: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750256728; l=834;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=oROJmE5AQXB5di57Dpto7OXf68djkjkPo1h58jnkyE0=;
 b=5t7EAIDAN5oMcxebBR7Kvpt8LV9oBsZjERIuDlsvN2n6wUNrdQNk2KtLoLNmu/YVEllNea3mH
 f8AHDpCaGuDAL+RkFuuUpA3ir19h34uG6hfJ1+n2I+LARRWWqeIX972
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 18 Jun 2025 16:45:31 +0200
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

This SoC doesn't have the generic compatible.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/iommu/qcom-hyp-smmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index c1b95bc8b8ca7463399c9cb801e7a9a6d004af53..3c0db9404584a2f54f8b44b13031df40bd1c2312 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -387,8 +387,9 @@ static struct iommu_ops qcom_smmu_ops = {
 };
 
 static const struct udevice_id qcom_smmu500_ids[] = {
-	{ .compatible = "qcom,sdm845-smmu-500" },
 	{ .compatible = "qcom,sc7280-smmu-500" },
+	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sm6350-smmu-500" },
 	{ .compatible = "qcom,smmu-500", },
 	{ /* sentinel */ }
 };

-- 
2.50.0


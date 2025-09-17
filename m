Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5136FCAC59A
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 16:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E123836F0;
	Wed, 17 Sep 2025 18:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="VRHgNRxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D8E835A2; Wed, 17 Sep 2025 14:47:55 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9F32833ED
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 14:47:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=luca.weiss@fairphone.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b07c2908f3eso800958266b.1
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1758113272; x=1758718072; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SxEcVgIh70BK9thokvA9B2LWWHxkWE0IyEANkCKLfis=;
 b=VRHgNRxAOAKlkGrAAJgk3MS83uBjfqEEYcHw4chW1zg49z7WTu5V7q0++RBF3A6I6a
 RkY9V3wruirVUESjzg7L718+lwz+G0aWjHhCxXIDU3ndvNk8LFUQBFd7w7sqftR6IQJB
 pPdaL2R3qAtsSqgaqkI7QaOUfjnU02Hfa1/pUw0USMR0h7Ttd0fGWRFzjOanoD/fKq4L
 dEdEwdmbbq8Cg7ZMI/q1QIW2P+JwgNumkEWwTv8NMgo45502qqgv71+kJph5VBBaeV42
 ndXWeQEXr2XbacpLuxisCEQk9ZQc8qXkvVStM1kHpPJ7hPVqOf7q/nhX92h1EJkQSXF4
 Y5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758113272; x=1758718072;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxEcVgIh70BK9thokvA9B2LWWHxkWE0IyEANkCKLfis=;
 b=eEtVRvVl6ClJYdH0WxTq7iPq65WVVt1jzZzII0pAQlA7Sc7SP/wCEz5W+BucO34ke7
 ydOJTgvGSMSUlnuzF5FNyIOqWZ9Hjb9tXRb8Mbv/AOd76me6Xo7NExdYsFxePpBhlqmy
 VOmj/HcX6TjXsS87w8AVs0fvAYBSyRYx5wgZY8CWqU3Hz1r68fqPjKuY2yZ91jFb3Lbh
 jLzVdGeRZwrERrFbEzOPzPqX79ehI5rkm1NWHSnBuRRdcI4R/HFPEQ/weCkQxVmjNsYe
 Ak7vVcO9NLQChEZnA1MhBEhHIxTcSZQoXQeMqeA9XAjtFfOtCef7+ANWtdydejLC7+BI
 QiGA==
X-Gm-Message-State: AOJu0Yz368Ww2cx0I4dCz+WZBxdXQn2pvBorLoOYIlRWi21bZqbtgcuT
 TLCfhIpkdRfiwfNBYY81ud1mh7dkE7kK6PRfe06I0Zl21F4pnR6J5XouwnTd6PDYpsw=
X-Gm-Gg: ASbGncsGWd4hZIYNYNg3zRa9O3q7LqA0ZCLIdEqXfyX4Vikz2kkCRzAKz2HCqD8PK3J
 hUOrsAQ4EJ9Hz7CI9R9EyimrSZ6Rm2Q1JjXoNTvoQw74MGJbEJ/iSXKvZSwGdQI+KdvoSy85RuH
 4yckcjH178LMH/uSWvsmsoBeWibSbPb1dhcw0m/87CFWJmEyKHWqd1DTjMO/OiwLKmgzfIvgCJg
 7vg3UNXDkAnLodkuzsWSXnCSdYdJxBrrRstSstrmeae4wByzXALBfzK1IVL9WpyzVjwXqXONjGO
 e/3f6KEu0n3Kho14VAQf3EWhGRA/s4gm9VhaJ86UDVShXEQYkDiS8wu2Op64WsMjfXONRUFjQeU
 IF9zMqHLdI3Zxwbjkuk1m1FFraSCPwMMlNHVGmPFtyIEwIVdEr7FckObdOiOhqF5jZLsHyw==
X-Google-Smtp-Source: AGHT+IGa/O9q6d2V70D2jm6GQYUkVjSe7PJPtXvIypBWeDHhzgctI5fd8AXt8/bNOWaI/JOXLm6BGg==
X-Received: by 2002:a17:907:7e96:b0:afe:7b35:9c8e with SMTP id
 a640c23a62f3a-b1bb50c417dmr273184666b.12.1758113272203; 
 Wed, 17 Sep 2025 05:47:52 -0700 (PDT)
Received: from otso.local (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b08cab32303sm937441866b.72.2025.09.17.05.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Sep 2025 05:47:51 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 17 Sep 2025 14:47:37 +0200
Subject: [PATCH v2 4/9] iommu: qcom-smmu: Add qcom,sm6350-smmu-500 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-sm6350-bringup-v2-4-13346fc2a2f6@fairphone.com>
References: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
In-Reply-To: <20250917-sm6350-bringup-v2-0-13346fc2a2f6@fairphone.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758113268; l=891;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=cV/hmxUtBaNFQD2Cs8B8FqDAMuMisARSsfLMqEf/2/I=;
 b=HwemhFrE6CqG4o8TammxkJEXX/5Umi0MliiDUkCA5wITvxKKnnUnaU0ZSiy5doGYbX8ba8AEM
 gD2KqIjPpMxAeNj69OM74+NzZfo+XhNP9y9XTiYrKVgophQyb7J2XOp
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
X-Mailman-Approved-At: Wed, 17 Sep 2025 18:22:41 +0200
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/iommu/qcom-hyp-smmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index 2e51ce4f242e44e670c9ba203db575833015e6bd..161e0b60091c104180b9020c03eeb2e86eba8a58 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -388,8 +388,9 @@ static struct iommu_ops qcom_smmu_ops = {
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
2.51.0


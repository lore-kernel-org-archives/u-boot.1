Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A795DC52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:49:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E837588BD4;
	Fri,  9 Aug 2024 02:48:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ebOEpGlk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BD4A88B81; Fri,  9 Aug 2024 02:48:58 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B1FC88ADE
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7d89bb07e7so187294466b.3
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164534; x=1723769334; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=j5mSbK38hTcwjtDq9YqD/jebYPtVMBgOCuwD99/r9IE=;
 b=ebOEpGlkvBnHqGYaGImGHyQh/PO8I/YVMG0NkVApd7FRBR8tLhZwxKZtWBJb0Sg198
 QWQswKlFmPSymwk3b8S2bj3qUJqEuZip9Fd4ujDNPOu4uUsnfEe9ibkHFFpb0LX3Mdog
 0zxbiK1QpCMr0gIpPSz255inqqoU+mxgj4PgmYbGXaCLSv8aBU7BEN3Hfhm76BmRiE94
 YffPD4wu5c5Px1InB6aQXrC6ber5l24leZ5KSyiCGQCmpT+w32PpCjQ5CcJzxp/iqRuM
 j8zIzWGFrXyNGfw7z7gTj4Tat9oAyHkaq8avyUzGonIvYJ/53M7qq7JbXqi6hzjLopNA
 DRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164534; x=1723769334;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j5mSbK38hTcwjtDq9YqD/jebYPtVMBgOCuwD99/r9IE=;
 b=rBxK3m6nOJm5mT2awenv0nx0uim02TC1nXr/GBq/ahEInZYdnOEcUecbXa33fcSH2d
 pc5albydawNDjx/pk3p5UXk5SrvH7L+iONXlWRF1pHoJpSA9bdIrJCihncRoMRg1g2yk
 +b9CQhZm8k9BU5dBkv4J1UqOFyMSmvkUa4AX9m4eFtUqOaJnG4liUZSTVWRqcEHc4wlb
 m3EEeL46x/cQxIF2203z/kB39J3k2uf5I0txebP6T4wy3V/69+HdUDoHhKf3LsUb8l/7
 Yf+XHwRWnOL5JPZwV7iBAnoJVqsyqgkCXTVouU315SQrOZwjEtzOaDOEcAYWx1s9olaP
 AcxA==
X-Gm-Message-State: AOJu0YzZ0DNXP7HxRp1Rx17/gPylbW3brB8vdDCtspysFTmW4qvWo2CX
 +/Qm2GFLSG5Z6LbuMySBPHSsZ8XnJIeliOvEv6tMCX3BrJOei2S0zH7uQLjpKTg=
X-Google-Smtp-Source: AGHT+IF8KxFujtrLjgiR+SahxMLZr85YbXqiZQVo8wB4Gn48/6RS05yNboLGsMPs11hcX3ceR+cvUw==
X-Received: by 2002:a17:906:d247:b0:a72:6375:5fc4 with SMTP id
 a640c23a62f3a-a80aa55409amr190466b.11.1723164534575; 
 Thu, 08 Aug 2024 17:48:54 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0c9f5sm789811466b.50.2024.08.08.17.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:48:53 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:48:47 +0200
Subject: [PATCH 4/7] iommu: qcom-smmu: add sc7280-smmu-500 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-rb3gen2-v1-4-7c73fe05b37a@linaro.org>
References: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
In-Reply-To: <20240809-b4-rb3gen2-v1-0-7c73fe05b37a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=678;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=w/ndae0/Zw/Sr1ZmaXrODAAmcNrtizRm8HsdLmW4Ghc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWdwHdK8JDHg4tU7p2dHuVDfZERi7bfH87KtX
 0jWIopzL9uJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVncAAKCRAFgzErGV9k
 tvadD/9O7k3BKxGmxLHyOPFITRV5TcFGbYWhj/N2nbH9f8QVTU43dHOZVvR+2RiUync8DEmihu6
 csuL4Z98nSVyjx6GVgOMpQWW9vJZpmVmKWI32YiJr8UoV5HfwCE0TjeqhYYP7BRwgBc7+QeUXfT
 ew5Gf8y+JTOO/aa6XRHf3XTO4h4gk5QvBj9RBWZM68uFCQyMul/+aVedrc9luaXgdpJqxSTA1pF
 8fXVXCUiRoSC7hAk9HH5DTiNXq2WjsJLZp6YC7AA1st9StLlwV8SsaXCySbCGgIc2AU4VkwCtOq
 Lunn8MONkpI3MNREV2p64xRXUJHHQqfgRQxLwTKD9LBuPRT1Xz+FF44qDr+QEHhEPNyiFS5I5Ri
 tEqpvAwhpOg7tGAPEwy38HtwUYX5IxMRqCj5bUEVdevfx+RVnOxpFmtmON5LyUbL9BjvhmFOa4q
 u4ZKc9tk6o54d2XySlpB1h2/vQWTMiFLBrGAYC9MHvcSvA6LcTi0XviPOenMQEZSPkMsxxx4uwW
 ui4Wt7/RjA42XTLWgoYoiiKXpXL8kNb1mPsK8H2DisQFYnsnWQi4pZKKYAJ3v1sbyFe4Z6IJtZQ
 wr30LXRvD+k4LMwbJrjWr+XSYevsj79QiwEjFKVfJYDAHhNw2xUmM8fbLwEgSTiwiBfgTf26Afx
 pCkWmFc6S73OeUw==
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


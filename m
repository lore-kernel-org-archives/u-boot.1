Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2594C54E60
	for <u-boot@archiver.kernel.org>; Tue, 19 Mar 2024 12:22:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D992687F95;
	Tue, 19 Mar 2024 13:22:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GBr/4hTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E37387F46; Tue, 19 Mar 2024 13:22:42 +0100 (CET)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com
 [IPv6:2a00:1450:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A0E387F64
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 13:22:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d4360ab3daso86880211fa.3
 for <u-boot@lists.denx.de>; Tue, 19 Mar 2024 05:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710850957; x=1711455757; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=GBr/4hThdpYvUwjPFhyVguDVDB7Cy8Arrxb+xDKN/peBp9829L6DqFMLgSayybHpGn
 cC4ee3WIxgLaxGStCG+o2jaGdQaXn+i+ySoI6No4JPT09uPySW/H2/nZmN15Hj7i8S9L
 J85/Hec/dcKjmz2M1QN1EpoiK7a+sria9IjGmIF1mJf5nn9tAq4g75xY5G1UL94v/B/P
 etElKFu8ISHOejY6K3nQJ+GTSzPjmnXdSDZGw/kmPoqvtz+18h7vCl5XXX5f3pB7MRTH
 28ILf4DbTlxXg52iGO0v9HBDcuV3lcdgelAK/p1Kfoy2unHTg1KYr62oLKDmmTtGd6OB
 9dbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710850957; x=1711455757;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJza8irKGD1LCWutbG2pawgU5HuytyqoLzmIGB2jhMo=;
 b=O5t9YJnG3aJPWTnkAK5uqLvj9oeGAsSfyrRBVLCaoNvdCugXT9T58XJgba2TyhhgCb
 9jPbIWi9LhPUDf2spJPYqubKxy+JybGemNOSgLfRaG0+uUotBrqGHn8yexxfxDVwJlmP
 Uelkn8R44V92Vz7nXOUwAZcXHDKoR475786N74mNawuA5pN8Er7vFt+7zR12nmn0OzE5
 iRzc1ybJeLbexN3G7cVzWQAHxGiXcw0DhpkTYrloY/BOs2j7rLuLyN/LyQjcCwmXNHtC
 TWZrJiJ5lj2knJ5c/4F9Rft+uJHa58JWVtl1GwWkEz8XuHRHTRgHcAtxqOQnoFQ2ngaF
 ffVA==
X-Gm-Message-State: AOJu0Yx4YbEUT6bL/pFRBAMRnNyL5J0YBNYLrhhFPPcvkPo7RKIR5Po7
 708qtT/WUqVue1NuFz8tWf9aWOUI4TvFNHR4B68DjNJdkGz+m2VwGVdi9M2GTQ0ynn7mV3N4VRD
 h
X-Google-Smtp-Source: AGHT+IFwnK43/kz3tcAa7q41V0Acb0HPJldfBdpPJzo8OljwmnIYd82CaAW8HP9WRbyl9ms8UQanjg==
X-Received: by 2002:a05:651c:228:b0:2d6:2b01:fe78 with SMTP id
 z8-20020a05651c022800b002d62b01fe78mr1051578ljn.27.1710850956719; 
 Tue, 19 Mar 2024 05:22:36 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 du18-20020a0560000d5200b0033b7ce8b496sm12170498wrb.108.2024.03.19.05.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 05:22:36 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Mar 2024 12:22:00 +0000
Subject: [PATCH v3 01/14] mailmap: update Bhupesh's email address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240319-b4-qcom-livetree-v3-1-e1b38d9b4fa4@linaro.org>
References: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
In-Reply-To: <20240319-b4-qcom-livetree-v3-0-e1b38d9b4fa4@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1165;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=XSvtB4NoCXg6pY1Nq/qGGGjasqOo57hNo8/eyKot594=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSfzZ3O0f8VFE79mFyx51dA2KmV6uI1zTY6yxlXXgm4w
 MkobdjQUcrCIMjBICumyCJ+Ypll09rL9hrbF1yAmcPKBDKEgYtTACaSW8nwPzOJKa+kn0noYKaQ
 e5XnsRtWPR0zXLPuZFoecJgbEylmwPCLyWNjzjV5667Z70tXBTS+jXH4fWtWTpdKheEyxXYu+/o
 VAA==
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

Update Bhupesh's email to his new one.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---

Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index d1f08f3eca8a..f6e0847b2168 100644
--- a/.mailmap
+++ b/.mailmap
@@ -29,8 +29,9 @@ Ashok Reddy Soma <ashok.reddy.soma@amd.com> <ashok.reddy.soma@xilinx.com>
 Atish Patra <atishp@atishpatra.org> <atish.patra@wdc.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharat.kumar.gogada@xilinx.com>
 Bharat Kumar Gogada <bharat.kumar.gogada@amd.com> <bharatku@xilinx.com>
 Bhargava Sreekantappa Gayathri <bhargava.sreekantappa-gayathri@amd.com> <bhargava.sreekantappa-gayathri@xilinx.com>
+Bhupesh Sharma <bhupesh.linux@gmail.com> <bhupesh.sharma@linaro.org>
 Bin Meng <bmeng.cn@gmail.com> <bin.meng@windriver.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
 Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
 Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>

-- 
2.44.0


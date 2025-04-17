Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC9FC369C2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 13:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA9E83082;
	Thu, 17 Apr 2025 15:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XkYPa8wW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B62A783095; Thu, 17 Apr 2025 15:49:49 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C487B82D32
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 15:49:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-acacb8743a7so139152866b.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 06:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744897787; x=1745502587; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OjMFUG/dXUsLD9YLMDtjOGm9BsRP8qBNGMDZS7S3GMU=;
 b=XkYPa8wWwYwuMjKPwfTmli3eA7eJ+SBbNydgcyAgnmIvlkVUpLhp2NR+dFILlh8NG0
 KAjp6kAP9A2m0Vqh4aL/d/KXXH/BfoZbd93pLEgaEMq2mVDrnLKtRXExoXU0Z7TvT0DD
 SQdoAXLF3v3Pp94Zb5Wu25CnX7jRGRz1t5hw8yIW4PLtYA6/5fKl0puljpY2nhy3Wkne
 lFtvuhMNDF2rKYW3GD0IlBjPselGmqQOvmE0Q2Hdv3MJyhjy2Cc02cC45+IVgBkkvDIr
 91jcibPWRn6gawzq4jeynKakGHTQq8EOkNT1fu3e/c+JQ3p9TKyWmHOPn8TEOwfIiHUT
 trrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744897787; x=1745502587;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjMFUG/dXUsLD9YLMDtjOGm9BsRP8qBNGMDZS7S3GMU=;
 b=L09DW4Ipskr8Kcu8UNqKmyIO/vzWlxCPDjrO+UoJqAZEmV/oGRRjqBHe6BW83nBFVF
 lVENbNOhMIxR+9UA/CFhL1Ey/dHzpPYBJ73pUzxS07qnJWAHVYiK7b8X/AmSRvgupjWT
 OPhneXZuT2NWpn6qmcGIiIRhsmua8dl59YckGmqYoae97hSaQPBibvu1Bn+n/Y50r4od
 HFrOdduSVcKxBS7qFsrEf4iKhB+gqJB82wy0O8EwDT8FrFYXAYgVwZgJtuvzAyGAbSPD
 seDjdRIqsji70TH1UpFuhvH6YlOH5VMzxsaaS0eVhrQVRtrLOEZGmQdVQpmBjCzevkJF
 bxsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOGM0f7mPG+1yY+F0sxJz6cozJUdPclXWz4XCLWvd9/icjAU3kTcktu/4BljCh5yx2CUowP60=@lists.denx.de
X-Gm-Message-State: AOJu0YwrLu5ivqi/vXbXutqj+FZzFYzwtvO3N/a2n9JSzm+ieQhK1apY
 L3tRdJgg6iqFEXUUHZgX+tsffe6gtU6hidQZv4oZbQHV5wGa5qWo/DSkOW/4Idc=
X-Gm-Gg: ASbGncu5JJPS4YOsXdfw9zyBIUNurLJw2rJM0PTI1bujgDCrsncCqSkZ5gE/s0NH02S
 nKCBNwvBAfP6bfO8acuW72ry+uiyESX5Q+W1du9eyq3yrtfshZLOpqkVStMTpj1lUmHcgTYJiBO
 QUUQ3EMR+YAvThMLRiZtmDruykclKpTbu+jkz0gZhpuhLSIloLuw6AAxs3H6iNALEr339B2EHgd
 bH+rg3Dqsm6yOsNpDPr1XwiBnYjnl59noUcHIS3dUX/lD8KeY1d3B9sKYAXrNLv2SJoAid/cAyY
 +5Kw4lkfzO/k+EofdaZQbZTZllx8v5zjwcImfBjYgSmIioBNC4YS
X-Google-Smtp-Source: AGHT+IEICFaO8qfTxxDXk7QvVgXQ4jNahP18vQrv1D+0jmVr1D5xppnKd7BHAUSjA4dz5A+HlNqHMg==
X-Received: by 2002:a17:907:7d9f:b0:aca:b45a:7c85 with SMTP id
 a640c23a62f3a-acb5b50ed16mr255188966b.19.1744897787212; 
 Thu, 17 Apr 2025 06:49:47 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:893:de18:edbc:9b79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-acb4d5bc6fesm171515066b.37.2025.04.17.06.49.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Apr 2025 06:49:46 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 17 Apr 2025 15:49:13 +0200
Subject: [PATCH 3/3] board: dragonboard410c: Enable support for KASLR in Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-db410c-fixes2-v1-3-76ad994da152@linaro.org>
References: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
In-Reply-To: <20250417-db410c-fixes2-v1-0-76ad994da152@linaro.org>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sam Day <me@samcday.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 u-boot-qcom@groups.io, u-boot@lists.denx.de
X-Mailer: b4 0.14.2
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

When booting Linux, there is currently the following warning in the console
when using the default dragonboard410c_defconfig:

  [    0.000000] KASLR disabled due to lack of seed

Fix this by enabling DM_RNG and RNG_MSM in the defconfig to generate the
KASLR seed:

  [    0.000000] KASLR enabled

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 configs/dragonboard410c_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/dragonboard410c_defconfig b/configs/dragonboard410c_defconfig
index 6feba70b943ecafdb96de28b4bddc36095f089c6..d267b6ed34dbb945cb3c5af8e323bdbdc294197e 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/dragonboard410c_defconfig
@@ -55,6 +55,8 @@ CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_DM_PMIC=y
 CONFIG_PMIC_QCOM=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_MSM=y
 CONFIG_MSM_SERIAL=y
 CONFIG_SPMI_MSM=y
 CONFIG_USB=y

-- 
2.47.2


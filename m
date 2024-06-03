Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579F9C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 12:50:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BD2788354;
	Mon,  3 Jun 2024 14:49:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VWKwKAjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D6D88381; Mon,  3 Jun 2024 14:49:28 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 070C08834B
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 14:49:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a68b334eb92so81489366b.0
 for <u-boot@lists.denx.de>; Mon, 03 Jun 2024 05:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717418966; x=1718023766; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YRws0KiWxU6E63HsFpROoSFxlC6P2ZzzbZQIBTC1JRk=;
 b=VWKwKAjdOzfo2W07f17IflGO0bgcvoGqD0gzt2cI8B9sS+XdH2rfU6Zjb/PB8Ibj/m
 2y/9ozMN0JPUKNeEm0fj/UZTHKVmq56YnmfYk4VDKuXCBqnuiNEgNqJR6p98ncuXsypc
 ZeQkp2oNF/2/qNdIq0JK7mWAKX6Nn9HQsDqZXNn0/upClYt9RAIgmox2WK/dUv183YnZ
 Jhf8QJJal9s+eMhMyIsOt6QNtntdONV6HoQW0sCOWqBXeHz6fRTJPoOIIU3q48EpNmN2
 ZmZILT1vL04UV31PZTstK/Ttr8hijYNLfwBlxz5H519vcF8UEUms9m5hZnHY+fZEL8BJ
 Ap5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717418966; x=1718023766;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YRws0KiWxU6E63HsFpROoSFxlC6P2ZzzbZQIBTC1JRk=;
 b=RTafvq30hCqrWplVnP65NS5EeBfKu1yByjNWOFkRf0ALI9lVXZWqP8AW8X6w1KGxNF
 kuiCEBQMJ//l0g3+8GD/ZgD/etPoTTFG8WldxYYTpwv1CVc1AuUWBWxUVP2akttG2B17
 7qD1R6jpLK17P8wjqT1DNBHIWEJdp0QdIpEET5wQ3wOThM5r6/Cl7Zt7mA09uZL3JWR9
 kWRQGpFKzPDYk6nUvHVbV56EZW8cU0DB9aKNgzDE1fD8MYU6kZYkVY95c4bLWfdTI2hD
 GVk7lLbY4X61x9vc7AfYd19sIvA+LiaLSLMSrAnkCmeWag/O3Yhr1z0PHkpsckjUPPio
 p+eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpvKtKIc6ojG/ZOBjHPBb0ViPvBBeNd0rkfkOmISuRDvNELx7UgfefQLNt4NDHTEcEtblMVG5FMbY8VjHnkattjuXklg==
X-Gm-Message-State: AOJu0Yw3LxgMCIMUkJplYKepo5gVc2+1QYpzoINVdDq2RD/gn71tOyq4
 vmHBhZhKGR4dp91fe4HsWoZQ6Ov5O4I70Lx1MN3BKv+YyEOdhsLLUD9n+zZBSZQ=
X-Google-Smtp-Source: AGHT+IHc3crmg7JTysv4XAYZXhxupC2apjJvJ7YvOv3EsrTOrqvgsuCwlfmvL7hxw9HEkwNrXg6Nxw==
X-Received: by 2002:a50:871d:0:b0:57a:228e:4331 with SMTP id
 4fb4d7f45d1cf-57a3634a940mr8174076a12.4.1717418966555; 
 Mon, 03 Jun 2024 05:49:26 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a691cd07c72sm98917066b.170.2024.06.03.05.49.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 05:49:26 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 03 Jun 2024 14:49:22 +0200
Subject: [PATCH v3 7/8] mach-snapdragon: bump up heap size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240603-b4-qcom-capsule-updates-v3-7-fe2e083289ec@linaro.org>
References: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
In-Reply-To: <20240603-b4-qcom-capsule-updates-v3-0-fe2e083289ec@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=925;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/AW++a5pXidkjplriFbZN3H78VQM/xJuDOmH212nb/0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmXbvNgUe1P5cZV2ylL577f2efUmeHEjoqBLw3r
 k8hq2GwQYuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZl27zQAKCRAFgzErGV9k
 tufLD/0Vba3v2O0T4vGX4KMnWElUX7H5y+2gMULxRxZHoGTQzOT9MLuZXAHLktV8Qa0PV78qUPE
 4xnekOkfcivWoYmzQXMeVtEUxc/TuAIkflVqAq/mB29El8HTroXs9iwmiaoMAivjDuuH2zfqOB4
 FebX2XENpVFvGwUwhVomKl3Mx1zhyObGYkxCBrMkBj9pzqMk69BrgXFjbSkjSNWwl0vZ0olJ03S
 wmgFmDz2oiq/FPuwYN7lcgVBAyrjszRK+y7mpO1kounoJXDBHh0I83n+qgp+Mh0uuYSyQJQrlIo
 pk6rJW7Hsb7vXMASl72K1mZGvrY423vQ3gFllidG52sWzLtjbcB1Cqtj0a4vg4mEKAHQxmcpAgQ
 q72JiMb31qFUEGoyQcFnwwVaG6eVgdmUPwgii5poJt95F0eQY7sFHV8twJblxi2q5zIK6yNRQrk
 HQvBjGQ9Ew9185xZ5qmmCjsPMjblNDqzomWIp8wvb/hT052arIfwIzglu1jmwC4p8anFI8pquJJ
 Pgunzs3baXCdSJiVcQwzhwxOXc/e/w/lPTks0bvjgl5IL1acVPHBq6HNrrr+bnSmh2kqU4zyOVH
 If8XRFZbc9rj4LdkcIcSobHVtTLgWcZjKoz6/xpgtU8XcHzkqmChHnKFHPtEk9gFN3tdpbc4riw
 2nLqXmxDKNqMmbQ==
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

For capsule updates we need more heap space for the DFU buffer. Give
ourselves a whole 8MiB!

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 536960b83c3b..5023c906bed8 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -10,8 +10,11 @@ config SYS_VENDOR
 	  Allows to specify vendor for the Snapdragon SoCs based boards.
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
 	  will be used as the custom board directory.
 
+config SYS_MALLOC_LEN
+	default 0x800000
+
 config SYS_MALLOC_F_LEN
 	default 0x2000
 
 config SPL_SYS_MALLOC_F

-- 
2.45.0


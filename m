Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF78CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 12:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA42388356;
	Wed,  3 Apr 2024 14:28:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OZbVhfW6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4636B8837E; Wed,  3 Apr 2024 14:28:50 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 590868822C
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 14:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a4e61accceaso502744266b.2
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 05:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712147328; x=1712752128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aC4dPCBggn11A2TSMTWqNqbptcFGnKCEubk7MzpXu44=;
 b=OZbVhfW6Uabwy3IZ3P9mzNFC7mTOgH2m35eDac5aA8vah9lu/kezFYCJwePGg8ypzx
 p+if3O2w6mKS4Uh917XE3yOV1SHkXTGx2kTTbGKD9b+s2OVJDpE4nuHlUn2fQ47JiqzH
 kNHQExdRYdFVEOfvAMIGKxuG6pVU2by+ecRr0dzrKcHM/WR/dZ5NCloSqQe08f3grUJT
 RTp2p2E5j4KgfB2EM+4X/N/4SpiR/wQv28i7GSDzLGy+Cc6/z8UuT3cAuoD8ss3YdFLr
 +J5qM5rnxVkBcqLVqGGD0Tl42aR56v7dEBYys4sHzHgMkTf8eA4IvKmyL7EATgwI3l+g
 XlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712147328; x=1712752128;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aC4dPCBggn11A2TSMTWqNqbptcFGnKCEubk7MzpXu44=;
 b=fqZf3DtirRZbGgmsYfpCifAN2Nq3tTsgJq+n/bYazFxB+8XAcBJty6DOxeST3k7/eO
 MmK9F3oZv33Fc3s3jKTWNrI5iRbMUassjJ5T0JzsCtHTO5tTlZexHZ5oGQ0QfghiuBIo
 wyaHJgwPrhFwJFFS186mjTuoGyWrTcq4dzoNIg4DHAgcYn7rt63v/vodG8iMdbSpluAc
 Fp6HJKPRznyMW5L2jzK2zFETjVMloCyu2673yoLm/wUBuH7K+ZaE2VtATzM2BPmol1jN
 CFzDsX/wrcRbXEvG4M3Akl7U+Yg4MNUUNRVDVeOLYoj+T4z86nkeArEM1KAZKRCqvoou
 s87w==
X-Gm-Message-State: AOJu0YyaJ3oUYdWZQyHbR3c9S9LOVrYZMnjJ7f5W9jUG900fuoaG0mNE
 oAWjbC1LE+tuJKJkz/JvwhaHsgVlmvxz4wxkE5dn9nxClSnhVPzHBgtXWbiIJXs=
X-Google-Smtp-Source: AGHT+IHuW6SurOayUMDH4bFVq6r/mudZOGIKX5mvpv1jXfw3g2dEB2kpJzk4uCuHUWtE2XP18k428g==
X-Received: by 2002:a17:907:9455:b0:a4e:7831:59b7 with SMTP id
 dl21-20020a170907945500b00a4e783159b7mr5728106ejc.61.1712147327822; 
 Wed, 03 Apr 2024 05:28:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::38e6])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a1709060f4900b00a472c4b9486sm7676567ejj.84.2024.04.03.05.28.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 05:28:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>
In-Reply-To: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
References: <20240403-b4-qcom-livetree-v6-0-130f8f50b538@linaro.org>
Subject: Re: [PATCH v6 00/16] Qualcomm platform USB support
Message-Id: <171214732697.1564919.12046706538302349051.b4-ty@linaro.org>
Date: Wed, 03 Apr 2024 14:28:46 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-4bd13
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


On Wed, 03 Apr 2024 14:07:35 +0200, Caleb Connolly wrote:
> This series enables USB on Qualcomm SDM845 platforms and lays the
> foundation for future SoCs as well.
> 
> It introduces two new high-speed PHY drivers, one for SDM845 and one for
> an upcoming platform. The SDM845 clock driver gains support for
> configuring the USB clocks, and the GPIO driver is updated to use .set_flags
> which fixes a strange bug where GPIOs would also be configured as input.
> 
> [...]

Applied, thanks!

[01/16] mailmap: update Bhupesh's email address
        commit: d78fd873e777be4dd5f3beec164bb60ced53a750
[02/16] phy: qcom: add Qualcomm QUSB2 USB PHY driver
        commit: 62a3eba5bfc89d292c774f88cc2afd8cad1b380b
[03/16] phy: qcom: Add SNPS femto v2 USB HS phy
        commit: 49cd93e882a3b6f6fa33dd343558b656ee29d881
[04/16] mach-snapdragon: disable power-domains for pre-reloc drivers
        commit: 1bfff467273804b7e47ec0ada189ba4312a5091d
[05/16] clk/qcom: use offsets for RCG registers
        commit: d057ada9c163cd4562528a0bfd19a647125a145f
[06/16] clk/qcom: sdm845: add gdscs
        commit: ce08f08cb11455729897d2bfe5d10e8d3e781f2a
[07/16] clk/qcom: sdm845: add USB clocks
        commit: 3d8546ed7ed27d0c0fd551cbf2c80e3dcdba589b
[08/16] gpio: msm_gpio: add .set_flags op
        commit: 4ef1c0566a581f368077fda69b24ce90756f368e
[09/16] serial: msm-geni: support livetree
        commit: def7e0f3ce16cba9f7bbead11d1256189b513a80
[10/16] mach-snapdragon: fixup USB nodes
        commit: de25b47241cc6bf83dc4db421f8eecc311e9424b
[11/16] mach-snapdragon: fixup power-domains
        commit: 2446ad0d1da8a82469186398ee63da7cb4439842
[12/16] mach-snapdragon: call regulators_enable_boot_on()
        commit: 57e4ccbd8c1ac7a415f8bff9d24dc2fc384cf583
[13/16] dts: sdm845-db845c: add u-boot fixups
        commit: f1ead8665ec10b6a972117a0842e294c48aca3e7
[14/16] qcom_defconfig: enable livetree
        commit: 9980bcbd3a0e874d7abbaafed373f1238c1f962f

Best regards,
-- 
Caleb Connolly <caleb.connolly@linaro.org>


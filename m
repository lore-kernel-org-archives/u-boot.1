Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FB7C5478C
	for <u-boot@archiver.kernel.org>; Fri,  1 Mar 2024 15:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5C0A88158;
	Fri,  1 Mar 2024 16:10:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RmA+++4D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE9D08814A; Fri,  1 Mar 2024 16:10:41 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D7F688156
 for <u-boot@lists.denx.de>; Fri,  1 Mar 2024 16:10:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412ce58c746so535735e9.2
 for <u-boot@lists.denx.de>; Fri, 01 Mar 2024 07:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709305838; x=1709910638; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XvHL6T0lBfTMGmnFqjnymJDbFZbrRouWgU7b5MkHlDs=;
 b=RmA+++4Djznm8vKcwvMbaqTIoC3Apylzf6RrGMd3AQNo9Sz0nlZvj74cc2LFPa2Rnh
 oFbq5pK3JF7gyyLO02mpBsyIpqDRtZCK6FrNqWma6/mtO5UPHXTW6/fWBYS5leWjeWL7
 tXw7T28XHaX3gCHJsAtdvvvbt+khONdxS30+2vAAus0lRZ6sKbzG8lKgFLEzyoJCG90b
 +4TxoYNF1VvwAJlFVIzvNdaLnTdS3j+IyQycVS2SghzBTV2oH+z/mU13eEJg3ElgNSeT
 3V+ht+E7NdvAcI9Vi3h5CSMdFO5iVuw5h1nNc0q1Qs3Gq+mTJBS5L2YDLvrJH4fGfRGj
 AkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709305838; x=1709910638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XvHL6T0lBfTMGmnFqjnymJDbFZbrRouWgU7b5MkHlDs=;
 b=UG/+Ua2//CMldZpLYNgUmKC7Ja8RkdyiQuNh2MbdIP84zv63OscMpyOFosvApN8Yre
 yRWw0oCBsQszd9+JU/QyaIIRnQcYCaC6CExVs8zoI08r65Xg1ufPxJhMEGqmOgwpYiWs
 6/JPrTBGNBgxSdUnrYYWgb/TY7wVGbCU+KKkxH2rAzrfPDH5F1Je0BvO3WI5EFnQ+OAd
 1m3odzV/u5eqT1yLSzC/RXcJ1lRvDCH6dfHRfgDuKEk+t9ETE7WhQRgVYRjksTNP+yUV
 7Y/4BphcOF51WFpVrgUswLX1b16poig9sO0gH6FCG999CrNHvONUNes4TIem9ttf8Po5
 9Gug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHChlDcQXUMfPyyDthKc/5Cc0sdhabWzAoS/H7mVJz+SLY9FQfaREI7tdlxUof0HALcykQ6z1bSXpkJ62IKEZgkq/aPg==
X-Gm-Message-State: AOJu0YyEznuk0uwbkvwTCepv4vUnb915+3U3ySt4qMkgihSLEQfLPuD+
 3mIbj0DNPGofCsMLY8F92Z9ppNHAeDQ4G7eZ3Gp1uKN584RJI5DaXGplQP9w6sY=
X-Google-Smtp-Source: AGHT+IG6bdBp2rFZEmtrLa1PIYKiSjaCQhg+LeK2zYxVMdFuFXcTdDKfRAjBN2dRftfuvXLVbVuV0w==
X-Received: by 2002:a05:600c:1d0a:b0:412:c8c9:c8d7 with SMTP id
 l10-20020a05600c1d0a00b00412c8c9c8d7mr1482321wms.26.1709305838447; 
 Fri, 01 Mar 2024 07:10:38 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech (host-92-17-96-232.as13285.net.
 [92.17.96.232]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c4ece00b00412b775e979sm5843614wmq.2.2024.03.01.07.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 07:10:37 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v5 00/39] Qualcomm generic board support
Date: Fri,  1 Mar 2024 15:10:27 +0000
Message-ID: <170930580024.4192355.3354974007593628856.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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


On Mon, 26 Feb 2024 17:26:04 +0000, Caleb Connolly wrote:
> Historically, Qualcomm boards in U-Boot have all had their own
> board/qualcomm/xyz directory, their own CONFIG_TARGET_XYZ option, their
> own hardcoded sysmap-xyz.c file, and their own U-Boot specific
> devicetree with little/no compatibility with upstream DT.
> 
> This series makes a few final prepatory changes, and then replaces
> almost all of the board specific code with generic alternatives. The end
> result is that all Qualcomm boards both current and future (with the
> exception of the db410c and db820c) can be supported by a single U-Boot
> binary by just providing the correct DT. New boards can be added without
> introducing any addition mach/ or board/ code or config options.
> 
> [...]

Applied, thanks!

[01/39] arm: init: export prev_bl_fdt_addr
        commit: ca84ba63858a607fe2dabf56ed593d7808d2689d
[02/39] usb: dwc3-generic: support external vbus regulator
        commit: de451d5d5b6f1913b7a7c270e7e5ff606342f126
[03/39] mmc: msm_sdhci: use modern clock handling
        commit: 5f3c4cca362b29fa60fd4fb5efeec60fe8f35af1
[04/39] dt-bindings: drop msm_sdhci binding
        commit: dae9614e1eb8fa5d4ae8051497a582940430e134
[05/39] clk/qcom: use upstream compatible properties
        commit: 7d96cca9e1d83ef307d7907e15d7a504ffc1ae69
[06/39] clock/qcom: qcs404: fix clk_set_rate
        commit: 641237bf99f701ffdf3748f5fe1e118eb2d7b781
[07/39] serial: msm: add debug UART
        commit: 90023bdfe979a5ea3806b73e73fabfc3e1a94a04
[08/39] serial: msm: fix clock handling and pinctrl
        commit: 92781cff6e7115b5a8957e6a9ded6cd7516d4fc7
[09/39] gpio: qcom_pmic: 1-based GPIOs
        commit: a2ce3aac46121e7ffa244540b62b439ddeed7a9c
[10/39] gpio: qcom_pmic: add a quirk to skip GPIO configuration
        commit: 19f000b72b2fa7e4540f7cdb91287aff594239bd
[11/39] gpio: qcom_pmic: add pinctrl driver
        commit: eb2393d7d5443750b8ab61912ead78eb54b42fb9
[12/39] sandbox: dts: fix qcom pmic gpio
        commit: cc18d5486b2cb520d50d2154fc2e9fe2566f480c
[13/39] pinctrl: qcom: stub support for special GPIOs
        commit: a245aece2acfbbaf01f41c595f9bfb02a9aedb70
[14/39] pinctrl: qcom: fix DT compatibility
        commit: 97487ac76de85d22653b12c7561e6c007a3b4eb5
[15/39] pinctrl: qcom: apq8016: init pre-reloaction
        commit: 8048976e9c9943b28aec8b7e4d998e128b39fe70
[16/39] board: dragonboard410c: add chainloaded config fragment
        commit: e9302ba6cc6bfdf8a3dc4e9f232767b9bc0b217d
[17/39] board: dragonboard410c: upstream DT compat
        commit: c744e6308951d47f597e5dac450cab5555698246
[18/39] board: dragonboard410c: import board code from mach-snapdragon
        commit: 14868845db54b4f64701977385dc9a6e951e4139
[19/39] board: dragonboard820c: use LINUX_KERNEL_IMAGE_HEADER
        commit: 9d5e434eb24d1bc73c8eb881bee95949a798f150
[20/39] mach-snapdragon: generalise board support
        commit: 059d526af3123935c1fb525d12953d570d392f7c
[21/39] mach-snapdragon: dynamic load addresses
        commit: a2364d97ffaef6b708b0e7098c5cb5de98f5b6e1
[22/39] mach-snapdragon: generate fdtfile automatically
        commit: 2bdc48f7fdcf412d9a67c07673bf7e7202628186
[23/39] mach-snapdragon: carve out no-map regions
        commit: c6f4985a04f50dead54fee43745fca87107bace7
[24/39] board: qcs404-evb: drop board code
        commit: 90744c1a14c54d08c9981869dec9262289da2d6b
[25/39] doc: board/qualcomm: document generic targets
        commit: d9252fcde1218902ed4805acd951da0405ba7d1b
[26/39] doc: board/qualcomm: link to APQ8016 TRM
        commit: d795efef8361e6406c08fd1551e1f1d98b1751ff
[27/39] dt-bindings: import headers for SDM845
        commit: c0297b30f1b576180c95dbc44b7647f20f3a4bd1
[28/39] dts: sdm845: import supporting dtsi files
        commit: e59755b0d688d0b5ff63b5034a1722d6c4c8ece7
[29/39] dts: sdm845: replace with upstream DTS
        commit: 99870a4c412b41893014eeb2d7ce8ba74d7b7d1a
[30/39] dt-bindings: import headers for MSM8916
        commit: 8a09bdceae5f1d295ced5feb19db3b883ed2dfd7
[31/39] dts: msm8916: import PMIC dtsi files
        commit: 89a013dbe8b5eca8f29c029bd60e7ca0c5f14da3
[32/39] dts: msm8916: replace with upstream DTS
        commit: ed8fbd2889fc072b12fe2437ac92e83676c93728
[33/39] dt-bindings: import headers for MSM8996
        commit: 7d5e9976f25149cace7fd9d6ebaf8b7b87dbf66f
[34/39] dts: msm8996: import PMIC dtsi files
        commit: 0d80f44c644aed766cc26fbb201e1c1a38bca924
[35/39] dts: dragonboard820c: use correct bindings for clocks
        commit: 5566bb447647bc155d06fad852db4ba3006d9329
[36/39] dts: msm8996: replace with upstream DTS
        commit: 93441fc3b527a3e5c60d687dc4cb01df03221759
[37/39] dt-bindings: import headers for qcs404
        commit: 4745c4d76cd463129d5f4a82ea4e4bbcc32dfd21
[38/39] dts: qcs404-evb: replace with upstream DT
        commit: 890207c6517d0d6dbd63d503c1fa8180c6022b98
[39/39] MAINTAINERS: Qualcomm: add some missing paths
        commit: f70ab46df3c2768002fdfc0fca9652af732cd619

Best regards,
-- 
// Caleb (they/them)


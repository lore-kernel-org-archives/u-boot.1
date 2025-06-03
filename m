Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFFFC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 16:25:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01E0482A76;
	Tue,  3 Jun 2025 18:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YObWiMtM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4909582AA7; Tue,  3 Jun 2025 18:25:28 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEE7803DF
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 18:25:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a363d15c64so4078083f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 09:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748967925; x=1749572725; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5hRt/RjB7GRkqQ+XHHtbd2Ug8yK5MWx+ahcN8suezMA=;
 b=YObWiMtMI3OCjdyZaqOXIMOXNwxBZHIKWXkDGVCiaxjUSN7soxe4VdmnFnm3KJSNc6
 SCy3SSmJDH+9xbgPNQgCEDSIj/79HEzbVxZk/jIpjxHtpNw/GruD/MZCs0wS0zwqfZNL
 Uc+nrPklCvNqt6aowpA45/lRmsC3S1aVdauEKW69hfElC999cUDkTXH8rW2qY+VtcnQn
 99l4CbkalsKUWUMuNuKdDs8UpGND+NJKyIgOVRn0LhTZWPk08KzrcYZTz5MduEdfOcyU
 6vCN9VNiKT+5uCsEZWyvwgRt1p4BEW5zOYUlidskAKCP3b1OnW+rtxABZOsBVNaLnSf+
 n9ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748967925; x=1749572725;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5hRt/RjB7GRkqQ+XHHtbd2Ug8yK5MWx+ahcN8suezMA=;
 b=UODJrVKJoORjak9nRhx6m5/r31dXfO3ebBwnmjVTRI+0OGnu+3/mV2/NBeL3FpUGj5
 cGSToDl4u5a89kbgBg+kh8O2NajawWToX4PCTX/e43jYp9iBoz2jLxUwFFSC2JY9gMFO
 z9jofshTo2YgH/8i5FjfqF4N7nioifneexDvoPDcozcItc5vTCwNaMM89oWItx/cGo+M
 s2fGPMpku9bfdBZtJEjXYLsriAMg/hQyM7mh6+qiTehSWYO1912eJwOVlkacO0n0jefo
 iNB4jgCxXqqpkgwI+B1EiiOTJVO3zH1DedBxBcidkMPRfErJpEjEmWA5GRkDiF93Zxcr
 IjSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPll4G4THGX+0uJdot8og+wd3Qtmw6ciKKaZObj2VFkpb+k7bInZ0b6NvfZV6RlKc42XldRgY=@lists.denx.de
X-Gm-Message-State: AOJu0Yzp7C1DjTqOhZDaS47byYJsWcWqwTzhkFqjFN9SFYTwDRS4SlSD
 QHrM2KfW3zldTZr7T4Bi0dpH1I8HRXvikuDRL9g45OpEy8TFrkQA7i6g37NeSqzH1YY=
X-Gm-Gg: ASbGncs3+bbmvIxNaLrjTHx1b2I6M5h4Dujcj2Z/XkDQM1VW4QAt/EtuwOdDpdKTmnw
 An8DNUBEy3m8hwP/bNeOOgkb6D8xpuvbPzbciYnz7LwUfg64qV6C2GvOh+tw7R28iwq1+j1Sdjv
 g//qRjqPOhU1dHedTHcBQ7RsCqlx97CzhaH+xuZCfFo6uXRZQF3ugiSNwXCengFImTo9zp2tws4
 q8GSyO0k/XEKUaGC4Gt4WkOfr2SVPnZv/g48olnm0wt/hSXPz7kjqg3GONlCWk9835TCmfZnqgv
 lx84aFVx7LQB8hFBAFlhjQq1f4NcHY+tKaRu7dlKQ8Oqm4xpTJGypx2GffQYVp88O7Aa1Wod38L
 z/nAjwaN7uuS+HK+kbwjToT7UXg==
X-Google-Smtp-Source: AGHT+IEiVb2Nj36H58mBUMEMpoWGf5Evgk8IaD6/SEmoAz1ueF1fwaO3dABCRLektPMcsvPzCxwn4w==
X-Received: by 2002:a05:6000:188b:b0:3a4:e393:11e2 with SMTP id
 ffacd0b85a97d-3a4f7a366bbmr15108172f8f.34.1748967924938; 
 Tue, 03 Jun 2025 09:25:24 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:e089:f4a9:4c4d:e359?
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4efe6c8b4sm19163360f8f.36.2025.06.03.09.25.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 09:25:24 -0700 (PDT)
Message-ID: <e6bd9135-3ab2-4eef-81c2-f08f1197247b@linaro.org>
Date: Tue, 3 Jun 2025 18:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Introduce support for QCS615 SoC based Platform
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, quic_varada@quicinc.com,
 trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org,
 me@samcday.com, christopher.obbard@linaro.org, sughosh.ganu@linaro.org,
 sjg@chromium.org, lehmanju@devpi.de, bhupesh.linux@gmail.com,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250521035324.1182833-1-aswin.murugan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Hi Aswin, Varadaraja,

Since we're expecting to do some more cleanup after adding all these 
dragonwing platforms, would you be up for adding MAINTAINERS entries for 
them? This way you'll actually get emails when there are changes 
affecting them.

My suggestion would be to add a MAINTAINERS file inside board/qualcomm 
with something like the following:

QUALCOMM DRAGONWING QCS615
M:	Aswin Murugan <aswin.murugan@oss.qualcomm.com>
R:	Varadarajan Narayanan <quic_varada@quicinc.com>
S:	Maintained
F:	arch/arm/dts/qcs615-ride-u-boot.dtsi
F:	configs/qcom_qcs615_defconfig
F:	drivers/clk/qcom/clock-qcs615.c

And repeat for each platform, set the maintainers and reviewers entries 
as you see fit.

I'll invite folks with an interest in other platforms to do the same.

Thanks and regards,

On 5/21/25 05:53, Aswin Murugan wrote:
> These patches introduce the initial support code needed
> for the Qualcomm QCS615 SoC IQ6 based Platform.
> 
> Please see [1] for SoC related details
> 
> Thanks
> Aswin
> 
> 1 - https://docs.qualcomm.com/bundle/publicresource/87-83838-1_REV_A_Qualcomm_IQ6_Series_Product_Brief.pdf
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Replaced the "1" with BIT(0) in drivers/clk/qcom/clock-qcs615.c
> - Link to v1: https://lore.kernel.org/u-boot/20250513110213.330495-1-aswin.murugan@oss.qualcomm.com/
> ---
> 
> Aswin Murugan (5):
>    dts: qcs615-ride-u-boot.dtsi: Add memory entry to bootup
>    phy: qcom: Enable QMP UFS PHY driver for QCS615
>    clk/qcom: qcs615: Add GCC clock driver for QCS615
>    qcom_defconfig: Enable QCS615 clock driver
>    configs: add qcs615_defconfig
> 
>   arch/arm/dts/qcs615-ride-u-boot.dtsi |  14 +++
>   configs/qcom_defconfig               |   1 +
>   configs/qcom_qcs615_defconfig        |  22 ++++
>   drivers/clk/qcom/Kconfig             |   8 ++
>   drivers/clk/qcom/Makefile            |   1 +
>   drivers/clk/qcom/clock-qcs615.c      | 163 +++++++++++++++++++++++++++
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c  | 127 +++++++++++++++++++++
>   7 files changed, 336 insertions(+)
>   create mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
>   create mode 100644 configs/qcom_qcs615_defconfig
>   create mode 100644 drivers/clk/qcom/clock-qcs615.c
> 

-- 
Casey (she/they)


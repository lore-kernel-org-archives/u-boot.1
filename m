Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852A7C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 15:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD36B828BC;
	Tue,  3 Jun 2025 17:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HX5tNxBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81B72829B2; Tue,  3 Jun 2025 17:16:10 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1643B81E25
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 17:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so11003395e9.1
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 08:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748963766; x=1749568566; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NDXb7box40TPxBld30A2OzilZcKP8MsuJtuyFcEdqFA=;
 b=HX5tNxBOYs5dGbzpSo85gIf6z6l0Oq6byCuxEK+iJU/4P7pbBAiffLEWX31a2lxcaP
 WssXbYQKRB9VfDAo/zLLHdpbDqk5GK/yh/AtWJgep4vJTvsSBEClxBGj1228k7s7kaiR
 Y87HnaBFh/iO7t/BKGD1JekqZQajVW4ZDGjbnVFj8KMrjSs8EKJ01ZOiCKYa8ZQiu5mX
 p3b2toM5Cg5JWW0cTtg+pif2VB7Y4NwtW4Ed525cimgOaFSyPlmPNo2S+IK91FMi/DmU
 GX9AmIKbiS0dPN+9A82mDBMY9D7yq/2/VKk4YXz6E8qLAzAtpWHGnpzI2rhFu5qm5OV/
 yF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748963766; x=1749568566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NDXb7box40TPxBld30A2OzilZcKP8MsuJtuyFcEdqFA=;
 b=UWUbSUZbLSpgEBx1sYdaufNS5Y5pwY23FmrZZ1cr66OixX4gqWhtBNMUA4lUfkbVCc
 ZWn9mhNlRF8qzr54HBMW8/ttvzXpjLAWgZVtsM4YjervNL/QVSNcfZrx0pWEh8GkwCux
 wGJHrbhF/YLJeilwHvLVak2gUDx2S1aUXUuVIV3Bl1RPqsZyp2iaV9B64pr7g6FJIAiO
 iHHlTy7rvWOAV2Cy9MSzOix4q8WEfYYw2mIZAkPdihDwpfcsvWRF2MdTHjXFo0b6pQBs
 k4XEabcOX15jUWbjsV0HH2RuQYGYPu3LWDL67uFhK1xoB7eeZx/oYHd2RuNSvQM/aAQ3
 wH9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1o/0L9gofhiIGmf0Z7Kxj/FlvSAS1MrL5Ck2Pj78TCOqNhUNXiTKZz/+fkIVu+Iayz6o3J64=@lists.denx.de
X-Gm-Message-State: AOJu0YzFqQrhrbbL/PMd8TBwhErXFLJ62uvBU8aZjqpCIF5EqwsVM/Iw
 NgiNv+xaD6e1UhPki04DSeTMxaarzNhPX3v1lBHToWqmoViXCOkPXaJj2uIKO4/vr+s=
X-Gm-Gg: ASbGncuF/mmHgHU87Qpm1UwToeVHaPt4/xNfKG25evqBzs31nN8nxlSu7wgjaz7p0Hd
 Mjn2jxsBewZ5U61tcN/Wg2pYhKWoEvduZiKqZ6GOIwKCT11vBpFJPB8NApJ2whUJVOfslDgY/Zt
 5ESdGysNttCDR8a8Ifue3M1273e2ZZb+AJd58ZoO4BEhOnduVU7+sFmV1TllpOAFco7/tPzXBig
 sz4QrPpgSapCmJ1/fhGvy5qMu9fF62CsGsJ3Ej3SggDYzA8zMzX4MLJOxTHWeeIAyhMX9LxZsdN
 abTt7rt+5eUedyvItL7NtjhKrJ1TVLc7/NqONwrDVRCxGZ3xIbDMuDtGpj4tpQpYud8pmahn+ct
 Xwg6+TS+hEiTa5M0i2DVJlRScjw==
X-Google-Smtp-Source: AGHT+IE1Oc8jxMq7gdQmnZbfh4rF7WuoI20Cbk/zBbNu9bo6Nrig7BJ5PgIae/QViEFbf3hMCWCM9g==
X-Received: by 2002:a05:600c:1e0d:b0:451:e260:353d with SMTP id
 5b1f17b1804b1-451e65ab8d5mr30536175e9.8.1748963766440; 
 Tue, 03 Jun 2025 08:16:06 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:e089:f4a9:4c4d:e359?
 ([2a01:170:117e:fc:e089:f4a9:4c4d:e359])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451e505d454sm20928755e9.0.2025.06.03.08.16.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Jun 2025 08:16:05 -0700 (PDT)
Message-ID: <28c9dbd5-9cf5-4b48-a46f-28e510347877@linaro.org>
Date: Tue, 3 Jun 2025 17:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/6] Add initial support for IPQ5424 based boards
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 caleb.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@linaro.org,
 lukma@denx.de, seanga2@gmail.com, Volodymyr_Babchuk@epam.com,
 lehmanju@devpi.de, sjg@chromium.org, robert.marko@sartura.hr,
 dmitry.baryshkov@linaro.org, andersson@kernel.org, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20250304110105.2762124-1-quic_varada@quicinc.com>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250304110105.2762124-1-quic_varada@quicinc.com>
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



On 3/4/25 12:00, Varadarajan Narayanan wrote:
> These patches introduce the initial support code needed
> for the QTI IPQ5424 SoC and RDP466 board.
> 
> Please see [1] for SoC related details

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

Thanks, apologies this took so long.>
> Thanks
> Varada
> 
> 1 - https://docs.qualcomm.com/bundle/publicresource/87-82994-1_REV_B_Qualcomm_Networking_Pro_A7_Elite_Platform_Product_Brief.pdf
> 
> Varadarajan Narayanan (6):
>    arm64: dts: qcom: ipq5424: Add USB controller and phy nodes
>    dts: ipq5424-rdp466-u-boot: add override dtsi
>    doc: board/qualcomm: Update RDP signing instructions
>    clk/qcom: add initial clock driver for ipq5424
>    pinctrl: qcom: Add ipq5424 pinctrl driver
>    configs: add qcom_ipq5424_mmc_defconfig
> 
>   arch/arm/dts/ipq5424-rdp466-u-boot.dtsi       |  37 ++
>   configs/qcom_ipq5424_mmc_defconfig            |  83 +++
>   doc/board/qualcomm/rdp.rst                    |  15 +-
>   drivers/clk/qcom/Kconfig                      |   8 +
>   drivers/clk/qcom/Makefile                     |   1 +
>   drivers/clk/qcom/clock-ipq5424.c              |  96 ++++
>   drivers/clk/qcom/clock-qcom.h                 |   1 +
>   drivers/pinctrl/qcom/Kconfig                  |   7 +
>   drivers/pinctrl/qcom/Makefile                 |   1 +
>   drivers/pinctrl/qcom/pinctrl-ipq5424.c        | 322 +++++++++++
>   .../src/arm64/qcom/ipq5424-rdp466.dts         | 169 ++++++
>   dts/upstream/src/arm64/qcom/ipq5424.dtsi      | 507 ++++++++++++++++++
>   12 files changed, 1241 insertions(+), 6 deletions(-)
>   create mode 100644 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi
>   create mode 100644 configs/qcom_ipq5424_mmc_defconfig
>   create mode 100644 drivers/clk/qcom/clock-ipq5424.c
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-ipq5424.c
>   create mode 100644 dts/upstream/src/arm64/qcom/ipq5424-rdp466.dts
>   create mode 100644 dts/upstream/src/arm64/qcom/ipq5424.dtsi
> 
> 
> base-commit: cf6354ab23bfc3337b1087d243e6be4af48abe84
> prerequisite-patch-id: f03d5ac6df1b3dd80a7f869a71989d584b0e32a5
> prerequisite-patch-id: f73e900ee3b01363b50870517eca030ee8324659
> prerequisite-patch-id: e73f86b2ae4c78c5b4fdb20ad15bbf05abd0320b
> prerequisite-patch-id: c671f3196f2397922c0f4b06806b4372ac60055d
> prerequisite-patch-id: 36f4133fb7451b536170f58b7519476351d4abae
> prerequisite-patch-id: ce26065654575ff2e49d6571225a52d194125c56
> prerequisite-patch-id: a8021af0c43a9a114a1e6e3dd43f3e665b3c3028

-- 
Casey (she/they)


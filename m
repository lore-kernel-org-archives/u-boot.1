Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB928C54E58
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 13:47:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B3F588061;
	Tue,  5 Mar 2024 14:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="e+RD3y1T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82D288065; Tue,  5 Mar 2024 14:47:30 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383F38803A
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 14:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4725acb539cso1580056137.3
 for <u-boot@lists.denx.de>; Tue, 05 Mar 2024 05:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646444; x=1710251244; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vXvI3WTyj/L7D9wtjfKJYF+UlrgbUouCWXu1Mfwyu2M=;
 b=e+RD3y1Tzj0aFFNLszvPQVmhYchFCrvwGqwl57HQHqlHwpWNxKtp80Gt63vLmC/HRy
 gX6QGFF3eVQQkH7lGQC5mzRr+56VJorw/bNRbbgO62DR/0IOCVjrsgs3rR2QJJtglvyd
 ZwGuUUGL/SSGzSkGYfNASPwJRfogEtiqqCSMqFv+OnnW4jv6d13pUjSHrAAhkvTiFegr
 mXcRsPQw7gVPcoSVjneIkIrnw2NiCzLFgRn9Jf2cV//B0UtLOVd0XNs6pH5fj03WMDm1
 EneUd2QVLTQiWjEG8fVFW8rltrosZap91qP4dJczGHKcH0h/izCcCVZy2CV5aWc6iXHS
 3ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646444; x=1710251244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vXvI3WTyj/L7D9wtjfKJYF+UlrgbUouCWXu1Mfwyu2M=;
 b=GAEDZ9INjkBFx1m5BITHmbtqv00oguoXzv3mmcNFb9IihBD3NU0p8ljV2vSqRIsAPE
 K/Y2/i+C4JwGmaBcZsZoBEZ6rY1BIXKyWmjj0M0YXAh8TnbMbSFil+uXoicOzVLPtlWR
 ePdgJE6D+eQQ2BeynuH7AmFF94PPBVUCxJ8WsiJ9GOr5jMqc3Dtn/Q5b09vBZ+VqAqmX
 qnEZGOG1Wo7x8l9HV+Gq9QZsnfgwGnGdDMKgQgnAl48dtHxIbl1ojURonYFBzXvhb6Lv
 YskyuEebiqfPCOU6qansPvg3V7TLWZgEMW6eBNUMAaggLJ95xkK8PHp0r1W3r8tcvMTR
 xiXg==
X-Gm-Message-State: AOJu0Yypz1L5lwGSrZEl5glJ0SREl0+4SVOA8Xi71Bjy6aISCd/NnX51
 cyrlpUJJbq827DbvkxcPDwepLknLkyKfj2iuvl78QoJnRuolYYUUYUyFeEvaHHdxO0tw3L5yy+p
 cE5JSakJ5ykCvauBQ3gQik6a1LXSPG62cbSCuwA==
X-Google-Smtp-Source: AGHT+IGFmWk2xYa2cyDlQrbqhHnTE6nziidu/PRHRbgbF3Tx1HOfREzMf1Hwmszo+PlIvG5MWefj2wZ7U0T9Adu2qy0=
X-Received: by 2002:a05:6102:3125:b0:472:9987:7150 with SMTP id
 f5-20020a056102312500b0047299877150mr1526308vsh.6.1709646443991; Tue, 05 Mar
 2024 05:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20240219084144.2881155-1-sumit.garg@linaro.org>
In-Reply-To: <20240219084144.2881155-1-sumit.garg@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 5 Mar 2024 19:17:13 +0530
Message-ID: <CAFA6WYMFiiX7DfmY02Rr5ECGa1znYptL9p0sA=p3Uxf3vJ3aQg@mail.gmail.com>
Subject: Re: [PATCH] qcom_defconfig: Enable ethernet and I2C support
To: caleb.connolly@linaro.org, neil.armstrong@linaro.org
Cc: u-boot@lists.denx.de, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
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

On Mon, 19 Feb 2024 at 14:11, Sumit Garg <sumit.garg@linaro.org> wrote:
>
> QCS404 supports Synopsys Designware Ethernet QOS IP and we already have
> the corresponding glue layer present upstream as:
> drivers/net/dwc_eth_qos_qcom.c. So enable corresponding support.
>
> Along with that it is possible for Qualcomm platforms to retrieve MAC
> address from I2C eeprom present on board. So enable corresponding
> support as well.
>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>
> This patch based upon Caleb's series [1].
>
> [1] https://lore.kernel.org/all/20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org/
>

Gentle ping.

-Sumit

>  configs/qcom_defconfig | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index 222db6448aba..cbc612b44bd9 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -26,7 +26,6 @@ CONFIG_CMD_USB=y
>  CONFIG_CMD_CAT=y
>  CONFIG_CMD_BMP=y
>  CONFIG_CMD_LOG=y
> -# CONFIG_NET is not set
>  CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
>  CONFIG_CLK_QCOM_QCS404=y
> @@ -65,3 +64,26 @@ CONFIG_VIDEO_SIMPLE=y
>  CONFIG_HEXDUMP=y
>  # CONFIG_GENERATE_SMBIOS_TABLE is not set
>  CONFIG_LMB_MAX_REGIONS=64
> +CONFIG_CMD_DHCP=y
> +CONFIG_CMD_EEPROM=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_PING=y
> +CONFIG_DM_ETH=y
> +CONFIG_DM_ETH_PHY=y
> +CONFIG_DM_MDIO=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_QCOM=y
> +CONFIG_RGMII=y
> +CONFIG_PHY_MICREL=y
> +CONFIG_PHY_MICREL_KSZ90X1=y
> +CONFIG_MISC=y
> +CONFIG_NVMEM=y
> +CONFIG_DM_I2C=y
> +CONFIG_I2C_SUPPORT=y
> +CONFIG_I2C_MUX=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SYS_I2C=y
> +CONFIG_SYS_I2C_QUP=y
> +CONFIG_SYS_I2C_EEPROM_BUS=2
> +CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
> +CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
> --
> 2.34.1
>

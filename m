Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC48C54798
	for <u-boot@archiver.kernel.org>; Tue,  5 Mar 2024 10:31:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A87088028;
	Tue,  5 Mar 2024 11:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1709634712;
	bh=GWjAHB3xnopmnzX7hQuAczidix28NsSThJx+DEGONo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w0l4/jjkQFQ/f2W5fUNmiGG/Zy/k/eCUl1lrawZcHuT5tLXAzCoNUobvWEGVk6JQ/
	 siUrlK3XB3llqcOF6wSU4NgbRmumEx+yrMceRXxyJSIHzpmbN/3LdTG03286CWh4YO
	 ngI/AHTYbW2REFlDMUEDl4STSyhK/3pd386XjfuNgjw2I//EIz/THvdCaPpYddbPoK
	 Vb6K9Z44E+vOKNREko6PG2KYaUpekKCfBzMmi604yf8HfTz/mmTl9TSPbJ5nKvXR0b
	 JFNg/958Xl66ITwkp0HiiDqabHw0SXJul3K/u4EWCmBrBZxQ6ZjLSHmC8K63T8xBpp
	 YIEOQNVf+YoKw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B0A78802D; Tue,  5 Mar 2024 11:31:51 +0100 (CET)
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [80.241.59.207])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5741188027
 for <u-boot@lists.denx.de>; Tue,  5 Mar 2024 11:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4TpsLQ5Q3Rz9sR5;
 Tue,  5 Mar 2024 11:31:42 +0100 (CET)
Message-ID: <f90c262d-1588-4410-936f-b601f87cec24@denx.de>
Date: Tue, 5 Mar 2024 11:31:42 +0100
MIME-Version: 1.0
Subject: Re: [PATCH u-boot-marvell] arm: mvebu: turris_omnia: Enable
 networking via ethernet switch
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
Cc: u-boot@lists.denx.de, =?UTF-8?Q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>
References: <20231219095555.31418-1-kabel@kernel.org>
From: Stefan Roese <sr@denx.de>
In-Reply-To: <20231219095555.31418-1-kabel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TpsLQ5Q3Rz9sR5
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

On 12/19/23 10:55, Marek Behún wrote:
> From: Marek Mojík <marek.mojik@nic.cz>
> 
> The Turris Omnia contains the Marvell 88E6176 ethernet switch. Add
> config options and device tree to enable the support.
> 
> Signed-off-by: Marek Mojík <marek.mojik@nic.cz>
> Signed-off-by: Marek Behún <kabel@kernel.org>

Applied to u-boot-marvell/master

Thanks,
Stefan

> ---
> Stefan, this patch depends on
>    [v2] net: mv88e6xxx: fix missing SMI address initialization
>    https://patchwork.ozlabs.org/project/uboot/patch/62eoapvurxkedw74vpzb55q3nuqgb4cef3bl2laayx57cpjzus@vlpx57cjc4ph/
> ---
>   .../dts/armada-385-turris-omnia-u-boot.dtsi   | 51 +++++++++++++++++++
>   configs/turris_omnia_defconfig                |  2 +
>   2 files changed, 53 insertions(+)
> 
> diff --git a/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi b/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi
> index 509d6ca69c..c63a331d69 100644
> --- a/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi
> +++ b/arch/arm/dts/armada-385-turris-omnia-u-boot.dtsi
> @@ -35,6 +35,57 @@
>   	};
>   };
>   
> +&mdio {
> +	switch@10 {
> +		mdio {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			sw_phy0: ethernet-phy@0 {
> +				reg = <0x0>;
> +			};
> +
> +			sw_phy1: ethernet-phy@1 {
> +				reg = <0x1>;
> +			};
> +
> +			sw_phy2: ethernet-phy@2 {
> +				reg = <0x2>;
> +			};
> +
> +			sw_phy3: ethernet-phy@3 {
> +				reg = <0x3>;
> +			};
> +
> +			sw_phy4: ethernet-phy@4 {
> +				reg = <0x4>;
> +			};
> +		};
> +		ports {
> +			ports@0 {
> +				phy-handle = <&sw_phy0>;
> +				phy-mode = "internal";
> +			};
> +			ports@1 {
> +				phy-handle = <&sw_phy1>;
> +				phy-mode = "internal";
> +			};
> +			ports@2 {
> +				phy-handle = <&sw_phy2>;
> +				phy-mode = "internal";
> +			};
> +			ports@3 {
> +				phy-handle = <&sw_phy3>;
> +				phy-mode = "internal";
> +			};
> +			ports@4 {
> +				phy-handle = <&sw_phy4>;
> +				phy-mode = "internal";
> +			};
> +		};
> +	};
> +};
> +
>   #ifdef CONFIG_ENV_IS_IN_SPI_FLASH
>   &spi0 {
>   	flash@0 {
> diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
> index 65d4a296e7..3aaee276ea 100644
> --- a/configs/turris_omnia_defconfig
> +++ b/configs/turris_omnia_defconfig
> @@ -96,7 +96,9 @@ CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_SPI_FLASH_MTD=y
>   CONFIG_PHY_MARVELL=y
>   CONFIG_PHY_FIXED=y
> +CONFIG_DM_DSA=y
>   CONFIG_PHY_GIGE=y
> +CONFIG_MV88E6XXX=y
>   CONFIG_MVNETA=y
>   CONFIG_MII=y
>   CONFIG_MVMDIO=y

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de

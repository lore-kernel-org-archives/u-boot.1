Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D9CCD1AB
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 11:17:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE2D9835B3;
	Fri, 24 Oct 2025 13:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id E289683623; Fri, 24 Oct 2025 13:17:44 +0200 (CEST)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8929582E34
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 13:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.255])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 7DC18B2200E3;
 Fri, 24 Oct 2025 13:17:40 +0200 (CEST)
Message-ID: <c6dbddb1-614f-46e2-9302-bc860e839382@freeshell.de>
Date: Fri, 24 Oct 2025 04:17:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
References: <20251024085932.83596-1-hal.feng@starfivetech.com>
 <20251024085932.83596-2-hal.feng@starfivetech.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <20251024085932.83596-2-hal.feng@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Hal, this is more complex change, I will have to think more about
what suggestion to make so this can avoid changes in dts subtree.
Anyways we know it is to be ignored in review as you said, and all the
information is very clear in meaning, thank you!

On 10/24/25 01:59, Hal Feng wrote:
> /****************************************************************/
> This patch picked from [1] is just for test and can be ignored.
> dts/upstream should be synced regularly with devicetree-rebasing.
> 
> [1] https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfivetech.com/
> /****************************************************************/
> 
> Some node in this file are not used by the upcoming VisionFive 2 Lite
> board. Move them to the board dts to prepare for adding the new
> VisionFive 2 Lite device tree.
> 
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../src/riscv/starfive/jh7110-common.dtsi     | 22 ---------
>  .../jh7110-deepcomputing-fml13v01.dts         | 49 +++++++++++++++++++
>  .../src/riscv/starfive/jh7110-milkv-mars.dts  | 49 +++++++++++++++++++
>  .../riscv/starfive/jh7110-pine64-star64.dts   | 49 +++++++++++++++++++
>  .../jh7110-starfive-visionfive-2.dtsi         | 46 +++++++++++++++++
>  dts/upstream/src/riscv/starfive/jh7110.dtsi   | 16 ------
>  6 files changed, 193 insertions(+), 38 deletions(-)
> 
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
> index 2eaf01775ef..8332622420c 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
> +++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
> @@ -281,15 +281,9 @@
...

I did send a series to cherry-pick into U-Boot from v6.18-rc1 which
should help with some of these overrides, particularly the no-sdio
no-mmc properties.

https://lore.kernel.org/u-boot/20251015102253.48276-1-e@freeshell.de/

Also there's a commit in riscv-dt-for-next for the mmc0 pins changes:

https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/commit/?h=riscv-dt-for-next&id=fa939a287224de705c825c093f3d9d34ae977b0b

>  	assigned-clock-rates = <50000000>;
>  	bus-width = <8>;
>  	bootph-pre-ram;
> -	cap-mmc-highspeed;
> -	mmc-ddr-1_8v;
> -	mmc-hs200-1_8v;
> -	cap-mmc-hw-reset;
>  	post-power-on-delay-ms = <200>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> -	vmmc-supply = <&vcc_3v3>;
> -	vqmmc-supply = <&emmc_vdd>;
>  	status = "okay";
>  };
>  
> @@ -299,12 +293,7 @@
>  	assigned-clock-rates = <50000000>;
>  	bus-width = <4>;
>  	bootph-pre-ram;
> -	no-sdio;
> -	no-mmc;
> -	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
> -	disable-wp;
>  	cap-sd-highspeed;
> -	post-power-on-delay-ms = <200>;
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins>;
>  	status = "okay";
> @@ -448,17 +437,6 @@
>  	};
>  
>  	mmc0_pins: mmc0-0 {
> -		 rst-pins {
> -			pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> -					      GPOEN_ENABLE,
> -					      GPI_NONE)>;
> -			bias-pull-up;
> -			drive-strength = <12>;
> -			input-disable;
> -			input-schmitt-disable;
> -			slew-rate = <0>;
> -		};
> -
>  		mmc-pins {
>  			pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
>  				 <PINMUX(PAD_SD0_CMD, 0)>,
> diff --git a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
> index f2857d021d6..5a2a41a7e8c 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
> +++ b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
> @@ -11,6 +11,55 @@
>  	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
...> diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
b/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
> index fdaf6b4557d..96f6b2f072d 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
> +++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
> @@ -11,6 +11,25 @@
>  	compatible = "milkv,mars", "starfive,jh7110";
...> diff --git
a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
> index 31e825be206..c9677aef9ff 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
> +++ b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
...> diff --git
a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
> index 5f14afb2c24..d1e4206f125 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
> +++ b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
> @@ -13,6 +13,25 @@
...> diff --git a/dts/upstream/src/riscv/starfive/jh7110.dtsi
b/dts/upstream/src/riscv/starfive/jh7110.dtsi
> index 0ba74ef0467..d2463399b95 100644
> --- a/dts/upstream/src/riscv/starfive/jh7110.dtsi
> +++ b/dts/upstream/src/riscv/starfive/jh7110.dtsi
> @@ -200,22 +200,6 @@
>  	cpu_opp: opp-table-0 {
>  			compatible = "operating-points-v2";
>  			opp-shared;
> -			opp-375000000 {
> -					opp-hz = /bits/ 64 <375000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-500000000 {
> -					opp-hz = /bits/ 64 <500000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-750000000 {
> -					opp-hz = /bits/ 64 <750000000>;
> -					opp-microvolt = <800000>;
> -			};
> -			opp-1500000000 {
> -					opp-hz = /bits/ 64 <1500000000>;
> -					opp-microvolt = <1040000>;
> -			};
>  	};
>  
>  	thermal-zones {

I've suggested (for you? and Emil?) the idea that we split out the OPP
tables from the common dtsi to a separate dtsi for JH7110 and JH7110S:

https://lore.kernel.org/lkml/7e31b240-2ffa-4946-af85-aaa45fe35199@freeshell.de/

Also to cut out the mmc0 mmc1 properties into a separate common dtsi.

FYI for anyone following along with this subject for discussion upstream
in Linux mailing list.

-E

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 387F4CA0FFE
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 16:17:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822EA832EB;
	Tue,  2 Sep 2025 18:17:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18E328331C; Tue,  2 Sep 2025 18:17:48 +0200 (CEST)
Received: from freeshell.de (freeshell.de [IPv6:2a01:4f8:231:482b::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A37083290
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 18:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [216.234.200.243])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 4C112B220079;
 Tue,  2 Sep 2025 18:17:43 +0200 (CEST)
Message-ID: <01a5ff2b-bc20-4670-93ce-2b66df408b96@freeshell.de>
Date: Tue, 2 Sep 2025 09:17:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 01/10] riscv: dts: starfive: jh7110-common: Move out some
 nodes to the board dts
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: u-boot@lists.denx.de, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Sumit Garg <sumit.garg@kernel.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
References: <20250829060931.79940-1-hal.feng@starfivetech.com>
 <20250829060931.79940-2-hal.feng@starfivetech.com>
 <f8ed3792-70ca-498f-9ce7-65040860db07@canonical.com>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <f8ed3792-70ca-498f-9ce7-65040860db07@canonical.com>
Content-Type: text/plain; charset=UTF-8
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

Hello Hal, and Heinrich,

On 8/29/25 00:19, Heinrich Schuchardt wrote:
> On 29.08.25 08:09, Hal Feng wrote:
>> Some node in this file are not used by the upcoming VisionFive 2 Lite
>> board. Move them to the board dts to prepare for adding the new
>> VisionFive 2 Lite device tree.
>>
>> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> 
> LGTM
> 
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> 

NAK

Better to drop jh7110-common-u-boot.dtsi from U-Boot [1]. Also we can
drop jh7110-u-boot.dtsi file but that does require some additional work:

- upstream dt-binding memory-controllers/starfive,jh7110-dmc.yaml [2]
- upstream devicetree changes adding memory controller [3]
- upstream bootph-pre-ram hints [4]
- implement cpufreq driver
- refactor drivers/ram/starfive/starfive_ddr.c to use common clock
framework and delete 'clock-frequency = <2133>' in dts

I am not interested in writing U-Boot drivers. Hal, can you make the
needed improvements in U-Boot for cpufreq and memory controller drivers?

1: https://lore.kernel.org/u-boot/20250815050315.62956-1-e@freeshell.de/
2: https://lore.kernel.org/lkml/20250823100159.203925-2-e@freeshell.de/
3: https://lore.kernel.org/lkml/20250823100159.203925-3-e@freeshell.de/
4: https://lore.kernel.org/lkml/20250823100159.203925-4-e@freeshell.de/

Thanks,  -E Shattow

>> ---
>>   .../src/riscv/starfive/jh7110-common.dtsi     | 22 ---------
>>   .../jh7110-deepcomputing-fml13v01.dts         | 49 +++++++++++++++++++
>>   .../src/riscv/starfive/jh7110-milkv-mars.dts  | 49 +++++++++++++++++++
>>   .../riscv/starfive/jh7110-pine64-star64.dts   | 49 +++++++++++++++++++
>>   .../jh7110-starfive-visionfive-2.dtsi         | 46 +++++++++++++++++
>>   dts/upstream/src/riscv/starfive/jh7110.dtsi   | 16 ------
>>   6 files changed, 193 insertions(+), 38 deletions(-)
>>
>> diff --git a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi b/dts/
>> upstream/src/riscv/starfive/jh7110-common.dtsi
>> index 4baeb981d4d..9d3d03ad2ed 100644
>> --- a/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
>> +++ b/dts/upstream/src/riscv/starfive/jh7110-common.dtsi
>> @@ -272,15 +272,9 @@
>>       assigned-clock-rates = <50000000>;
>>       bus-width = <8>;
>>       bootph-pre-ram;
>> -    cap-mmc-highspeed;
>> -    mmc-ddr-1_8v;
>> -    mmc-hs200-1_8v;
>> -    cap-mmc-hw-reset;
>>       post-power-on-delay-ms = <200>;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&mmc0_pins>;
>> -    vmmc-supply = <&vcc_3v3>;
>> -    vqmmc-supply = <&emmc_vdd>;
>>       status = "okay";
>>   };
>>   @@ -290,12 +284,7 @@
>>       assigned-clock-rates = <50000000>;
>>       bus-width = <4>;
>>       bootph-pre-ram;
>> -    no-sdio;
>> -    no-mmc;
>> -    cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
>> -    disable-wp;
>>       cap-sd-highspeed;
>> -    post-power-on-delay-ms = <200>;
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&mmc1_pins>;
>>       status = "okay";
>> @@ -439,17 +428,6 @@
>>       };
>>         mmc0_pins: mmc0-0 {
>> -         rst-pins {
>> -            pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
>> -                          GPOEN_ENABLE,
>> -                          GPI_NONE)>;
>> -            bias-pull-up;
>> -            drive-strength = <12>;
>> -            input-disable;
>> -            input-schmitt-disable;
>> -            slew-rate = <0>;
>> -        };
>> -
>>           mmc-pins {
>>               pinmux = <PINMUX(PAD_SD0_CLK, 0)>,
>>                    <PINMUX(PAD_SD0_CMD, 0)>,
>> diff --git a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-
>> fml13v01.dts b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-
>> fml13v01.dts
>> index f2857d021d6..5a2a41a7e8c 100644
>> --- a/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
>> +++ b/dts/upstream/src/riscv/starfive/jh7110-deepcomputing-fml13v01.dts
>> @@ -11,6 +11,55 @@
>>       compatible = "deepcomputing,fml13v01", "starfive,jh7110";
>>   };
>>   +&cpu_opp {
>> +    opp-375000000 {
>> +        opp-hz = /bits/ 64 <375000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-500000000 {
>> +        opp-hz = /bits/ 64 <500000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-750000000 {
>> +        opp-hz = /bits/ 64 <750000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-1500000000 {
>> +        opp-hz = /bits/ 64 <1500000000>;
>> +        opp-microvolt = <1040000>;
>> +    };
>> +};
>> +
>> +&mmc0 {
>> +    cap-mmc-highspeed;
>> +    cap-mmc-hw-reset;
>> +    mmc-ddr-1_8v;
>> +    mmc-hs200-1_8v;
>> +    vmmc-supply = <&vcc_3v3>;
>> +    vqmmc-supply = <&emmc_vdd>;
>> +};
>> +
>> +&mmc0_pins {
>> +    rst-pins {
>> +        pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
>> +                      GPOEN_ENABLE,
>> +                      GPI_NONE)>;
>> +        bias-pull-up;
>> +        drive-strength = <12>;
>> +        input-disable;
>> +        input-schmitt-disable;
>> +        slew-rate = <0>;
>> +    };
>> +};
>> +
>> +&mmc1 {
>> +    no-sdio;
>> +    no-mmc;
>> +    cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
>> +    disable-wp;
>> +    post-power-on-delay-ms = <200>;
>> +};
>> +
>>   &pcie1 {
>>       perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
>>       phys = <&pciephy1>;
>> diff --git a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts b/
>> dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
>> index 3bd62ab7852..0c90facc4ee 100644
>> --- a/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
>> +++ b/dts/upstream/src/riscv/starfive/jh7110-milkv-mars.dts
>> @@ -11,6 +11,25 @@
>>       compatible = "milkv,mars", "starfive,jh7110";
>>   };
>>   +&cpu_opp {
>> +    opp-375000000 {
>> +        opp-hz = /bits/ 64 <375000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-500000000 {
>> +        opp-hz = /bits/ 64 <500000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-750000000 {
>> +        opp-hz = /bits/ 64 <750000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-1500000000 {
>> +        opp-hz = /bits/ 64 <1500000000>;
>> +        opp-microvolt = <1040000>;
>> +    };
>> +};
>> +
>>   &gmac0 {
>>       starfive,tx-use-rgmii-clk;
>>       assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>> @@ -22,6 +41,36 @@
>>       status = "okay";
>>   };
>>   +&mmc0 {
>> +    cap-mmc-highspeed;
>> +    cap-mmc-hw-reset;
>> +    mmc-ddr-1_8v;
>> +    mmc-hs200-1_8v;
>> +    vmmc-supply = <&vcc_3v3>;
>> +    vqmmc-supply = <&emmc_vdd>;
>> +};
>> +
>> +&mmc0_pins {
>> +    rst-pins {
>> +        pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
>> +                      GPOEN_ENABLE,
>> +                      GPI_NONE)>;
>> +        bias-pull-up;
>> +        drive-strength = <12>;
>> +        input-disable;
>> +        input-schmitt-disable;
>> +        slew-rate = <0>;
>> +    };
>> +};
>> +
>> +&mmc1 {
>> +    no-sdio;
>> +    no-mmc;
>> +    cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
>> +    disable-wp;
>> +    post-power-on-delay-ms = <200>;
>> +};
>> +
>>   &pcie0 {
>>       status = "okay";
>>   };
>> diff --git a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
>> b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
>> index 31e825be206..c9677aef9ff 100644
>> --- a/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
>> +++ b/dts/upstream/src/riscv/starfive/jh7110-pine64-star64.dts
>> @@ -14,6 +14,25 @@
>>       };
>>   };
>>   +&cpu_opp {
>> +    opp-375000000 {
>> +        opp-hz = /bits/ 64 <375000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-500000000 {
>> +        opp-hz = /bits/ 64 <500000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-750000000 {
>> +        opp-hz = /bits/ 64 <750000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-1500000000 {
>> +        opp-hz = /bits/ 64 <1500000000>;
>> +        opp-microvolt = <1040000>;
>> +    };
>> +};
>> +
>>   &gmac0 {
>>       starfive,tx-use-rgmii-clk;
>>       assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
>> @@ -44,6 +63,36 @@
>>       status = "okay";
>>   };
>>   +&mmc0 {
>> +    cap-mmc-highspeed;
>> +    cap-mmc-hw-reset;
>> +    mmc-ddr-1_8v;
>> +    mmc-hs200-1_8v;
>> +    vmmc-supply = <&vcc_3v3>;
>> +    vqmmc-supply = <&emmc_vdd>;
>> +};
>> +
>> +&mmc0_pins {
>> +    rst-pins {
>> +        pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
>> +                      GPOEN_ENABLE,
>> +                      GPI_NONE)>;
>> +        bias-pull-up;
>> +        drive-strength = <12>;
>> +        input-disable;
>> +        input-schmitt-disable;
>> +        slew-rate = <0>;
>> +    };
>> +};
>> +
>> +&mmc1 {
>> +    no-sdio;
>> +    no-mmc;
>> +    cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
>> +    disable-wp;
>> +    post-power-on-delay-ms = <200>;
>> +};
>> +
>>   &pcie1 {
>>       status = "okay";
>>   };
>> diff --git a/dts/upstream/src/riscv/starfive/jh7110-starfive-
>> visionfive-2.dtsi b/dts/upstream/src/riscv/starfive/jh7110-starfive-
>> visionfive-2.dtsi
>> index 5f14afb2c24..d1e4206f125 100644
>> --- a/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
>> +++ b/dts/upstream/src/riscv/starfive/jh7110-starfive-visionfive-2.dtsi
>> @@ -13,6 +13,25 @@
>>       };
>>   };
>>   +&cpu_opp {
>> +    opp-375000000 {
>> +        opp-hz = /bits/ 64 <375000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-500000000 {
>> +        opp-hz = /bits/ 64 <500000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-750000000 {
>> +        opp-hz = /bits/ 64 <750000000>;
>> +        opp-microvolt = <800000>;
>> +    };
>> +    opp-1500000000 {
>> +        opp-hz = /bits/ 64 <1500000000>;
>> +        opp-microvolt = <1040000>;
>> +    };
>> +};
>> +
>>   &gmac0 {
>>       status = "okay";
>>   };
>> @@ -38,9 +57,36 @@
>>   };
>>     &mmc0 {
>> +    cap-mmc-highspeed;
>> +    cap-mmc-hw-reset;
>> +    mmc-ddr-1_8v;
>> +    mmc-hs200-1_8v;
>> +    vmmc-supply = <&vcc_3v3>;
>> +    vqmmc-supply = <&emmc_vdd>;
>>       non-removable;
>>   };
>>   +&mmc0_pins {
>> +    rst-pins {
>> +        pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
>> +                      GPOEN_ENABLE,
>> +                      GPI_NONE)>;
>> +        bias-pull-up;
>> +        drive-strength = <12>;
>> +        input-disable;
>> +        input-schmitt-disable;
>> +        slew-rate = <0>;
>> +    };
>> +};
>> +
>> +&mmc1 {
>> +    no-sdio;
>> +    no-mmc;
>> +    cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
>> +    disable-wp;
>> +    post-power-on-delay-ms = <200>;
>> +};
>> +
>>   &pcie0 {
>>       status = "okay";
>>   };
>> diff --git a/dts/upstream/src/riscv/starfive/jh7110.dtsi b/dts/
>> upstream/src/riscv/starfive/jh7110.dtsi
>> index 0ba74ef0467..d2463399b95 100644
>> --- a/dts/upstream/src/riscv/starfive/jh7110.dtsi
>> +++ b/dts/upstream/src/riscv/starfive/jh7110.dtsi
>> @@ -200,22 +200,6 @@
>>       cpu_opp: opp-table-0 {
>>               compatible = "operating-points-v2";
>>               opp-shared;
>> -            opp-375000000 {
>> -                    opp-hz = /bits/ 64 <375000000>;
>> -                    opp-microvolt = <800000>;
>> -            };
>> -            opp-500000000 {
>> -                    opp-hz = /bits/ 64 <500000000>;
>> -                    opp-microvolt = <800000>;
>> -            };
>> -            opp-750000000 {
>> -                    opp-hz = /bits/ 64 <750000000>;
>> -                    opp-microvolt = <800000>;
>> -            };
>> -            opp-1500000000 {
>> -                    opp-hz = /bits/ 64 <1500000000>;
>> -                    opp-microvolt = <1040000>;
>> -            };
>>       };
>>         thermal-zones {
> 


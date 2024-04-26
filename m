Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B735C4345F
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 08:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C20BB88EB1;
	Fri, 26 Apr 2024 10:51:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="I9b4UkVD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6E70886B1; Fri, 26 Apr 2024 10:51:16 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31C4A88F1C
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 10:51:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 78558100007;
 Fri, 26 Apr 2024 11:51:13 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 78558100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1714121473;
 bh=oQ1nW+/bZ7sHZAQQKY6zU9DJRlfti/PZLefeh8iiIHA=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=I9b4UkVDyrHuUQeQS8uWnx/w9P8odpecs1WomRAJ/jMRZUSmrmzP4iIH7By3KY4mx
 qXr31IvkNjB8KtJPSULnNNQkySj4qpkVmizXDplEzC6XaWZd1HA4lStuFRbFyVqvua
 JLjlbxW6jk3Hrf4147lZEBzkI47P/8CAwrlw1i9rXUx0PqPufuE5KRd/Jwkr2wpJVO
 FeMQpZRJCa9TPQrt49fs5d9r+mih+fg3zNBZVK2iU7jZZq8JWPrye3Ir1784nvSRVj
 C+I9PNPkB4o+c04D0ldPdQPvN6ll9BkFNXPWzeVOPwTojDZUoOU6lGGBdfZ3dKiPyh
 YHwUEaIUanDaw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Fri, 26 Apr 2024 11:51:13 +0300 (MSK)
Received: from [172.28.226.125] (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 26 Apr 2024 11:51:12 +0300
Message-ID: <21b14ae5-1f92-6c7b-2c65-20ef3cb5820d@salutedevices.com>
Date: Fri, 26 Apr 2024 11:40:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] arm: dts: meson-axg: add NAND controller node for AXG
Content-Language: en-US
To: <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20240425175052.2650301-1-avkrasnov@salutedevices.com>
 <d272b0f6-2f21-4601-b347-f83eac4f12d4@linaro.org>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <d272b0f6-2f21-4601-b347-f83eac4f12d4@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184945 [Apr 26 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 18 0.3.18
 b9d6ada76958f07c6a68617a7ac8df800bc4166c,
 {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/26 07:13:00 #24973180
X-KSMG-AntiVirus-Status: Clean, skipped
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

Hi,

On 26.04.2024 11:21, Neil Armstrong wrote:
> Hi,
> 
> On 25/04/2024 19:50, Arseniy Krasnov wrote:
>> nfc: Synced from Linux commit 7ca2ef33179f ("Linux 6.6-rc1")
>> nand_all_pins: Synced from Linux commit be18d53c32b2 ("Linux 6.7-rc3")
> 
> No need to sync DT anymore, this is handled by OF_UPSTREAM and for next release
> it's already aligned with v6.9 DT.
> 
> Please try your patches with master or next branch of U-Boot repo.

Ok, so I can remove "Synced from" from commit description, thus make it empty, and test that patch applies correctly
on uboot master/ next ?

Thanks

> 
> Neil
> 
>>
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>   arch/arm/dts/meson-axg.dtsi | 36 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
>> index 3f5254eeb4..4f6fdd5523 100644
>> --- a/arch/arm/dts/meson-axg.dtsi
>> +++ b/arch/arm/dts/meson-axg.dtsi
>> @@ -430,6 +430,27 @@
>>                       };
>>                   };
>>   +                nand_all_pins: nand_all_pins {
>> +                    mux {
>> +                        groups = "emmc_nand_d0",
>> +                             "emmc_nand_d1",
>> +                             "emmc_nand_d2",
>> +                             "emmc_nand_d3",
>> +                             "emmc_nand_d4",
>> +                             "emmc_nand_d5",
>> +                             "emmc_nand_d6",
>> +                             "emmc_nand_d7",
>> +                             "nand_ce0",
>> +                             "nand_ale",
>> +                             "nand_cle",
>> +                             "nand_wen_clk",
>> +                             "nand_ren_wr";
>> +                        function = "nand";
>> +                        input-enable;
>> +                        bias-pull-up;
>> +                    };
>> +                };
>> +
>>                   emmc_ds_pins: emmc_ds {
>>                       mux {
>>                           groups = "emmc_ds";
>> @@ -1906,6 +1927,21 @@
>>                   resets = <&reset RESET_SD_EMMC_C>;
>>               };
>>   +            nfc: nand-controller@7800 {
>> +                compatible = "amlogic,meson-axg-nfc";
>> +                reg = <0x0 0x7800 0x0 0x100>,
>> +                      <0x0 0x7000 0x0 0x800>;
>> +                reg-names = "nfc", "emmc";
>> +                pinctrl-0 = <&nand_all_pins>;
>> +                pinctrl-names = "default";
>> +                #address-cells = <1>;
>> +                #size-cells = <0>;
>> +                interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
>> +                clocks = <&clkc CLKID_SD_EMMC_C>,
>> +                     <&clkc CLKID_FCLK_DIV2>;
>> +                clock-names = "core", "device";
>> +            };
>> +
>>               usb2_phy1: phy@9020 {
>>                   compatible = "amlogic,meson-gxl-usb2-phy";
>>                   #phy-cells = <0>;
> 

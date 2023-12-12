Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B27C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 14:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707CE874DD;
	Tue, 12 Dec 2023 15:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="Ia4OZW42";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 800C7877BF; Tue, 12 Dec 2023 15:15:34 +0100 (CET)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A94186813
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 15:15:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avkrasnov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 3672612002B;
 Tue, 12 Dec 2023 17:15:30 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3672612002B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1702390530;
 bh=UDwwoHXgv6thGRGZl5LXSoFBi5VVlP3CRqXHXYagGLs=;
 h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type:From;
 b=Ia4OZW42/ButttE+d+esNEj+UC1gFsRfNywEHNxjF/0zvem58V5ANGXzVNoutWC0Q
 bSpRs56osLPUod4Cz7n9L2Es3Q+n86xRFMD9ed1y1XgF/qPE4ZciLas/IvsdY/eG5L
 YEFiKrx5qp3S2Uh2M6+ijvaIYSbd3xrhDes1Tzj/W92bl+ocb4VAA+ZhkeusrXSE5i
 yiqG3ra3xzrIeouZsYZI4khJ+9jV2aWvUbTLKWgo+e5YbDS3am7lv6E8mz/X8TgTsq
 yp6ED9GLgbY2yMHtA6q3SYE7dB8qr1kL98kHjQSevqeJHxDtfj7RcKkgXIEZ+epobC
 SQ2PkytslrUIA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Tue, 12 Dec 2023 17:15:29 +0300 (MSK)
Received: from [192.168.0.106] (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 17:15:28 +0300
Message-ID: <ebec07c3-cec3-bf14-c84d-91f69ca8c671@salutedevices.com>
Date: Tue, 12 Dec 2023 17:07:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] arm: dts: meson: add NAND controller node for AXG
Content-Language: en-US
To: <neil.armstrong@linaro.org>
CC: <u-boot@lists.denx.de>, <u-boot-amlogic@groups.io>,
 <kernel@sberdevices.ru>, <oxffffaa@gmail.com>
References: <20231130122712.189700-1-avkrasnov@salutedevices.com>
 <a5cbd4fe-dd24-40ae-a61c-c2af27d5e0ee@linaro.org>
From: Arseniy Krasnov <avkrasnov@salutedevices.com>
In-Reply-To: <a5cbd4fe-dd24-40ae-a61c-c2af27d5e0ee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182057 [Dec 12 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7
 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_uf_ne_domains},
 {Tracking_from_domain_doesnt_match_to}, salutedevices.com:7.1.1;
 100.64.160.123:7.1.2; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 127.0.0.199:7.1.2; smtp.sberdevices.ru:5.0.1,7.1.1;
 lore.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/12/12 08:32:00
X-KSMG-LinksScanning: Clean, bases: 2023/12/12 08:10:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2023/12/12 06:12:00 #22665285
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

On 12.12.2023 17:03, Neil Armstrong wrote:
> Hi,
> 
> On 30/11/2023 13:27, Arseniy Krasnov wrote:
> 
> Can you add a reference to the Linux patches that you submitted so
> we know it will be safe to sync the DT from Linux when they are merged ?

Sure:

https://lore.kernel.org/linux-amlogic/20230828133647.3712644-1-avkrasnov@salutedevices.com/
https://lore.kernel.org/linux-amlogic/170107314359.1083800.4264228970569502392.b4-ty@linaro.org/T/#m30d2fd46fca4f78098be19d7ec71097f98b60d29

Thanks, Arseniy

> 
> Thanks,
> Neil
> 
>> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>> ---
>>   arch/arm/dts/meson-axg.dtsi | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm/dts/meson-axg.dtsi b/arch/arm/dts/meson-axg.dtsi
>> index 3f5254eeb4..c01ace3ff1 100644
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
>> @@ -1906,6 +1927,20 @@
>>                   resets = <&reset RESET_SD_EMMC_C>;
>>               };
>>   +            nfc: nand-controller@7800 {
>> +                #address-cells = <2>;
>> +                #size-cells = <2>;
>> +                pinctrl-0 = <&nand_all_pins>;
>> +                pinctrl-names = "default";
>> +                compatible = "amlogic,meson-axg-nfc";
>> +                status = "okay";
>> +                reg = <0x0 0x7800 0x0 0x100>,
>> +                      <0x0 0x7000 0x0 0x800>;
>> +                clocks = <&clkc CLKID_SD_EMMC_C>,
>> +                     <&clkc CLKID_FCLK_DIV2>;
>> +                clock-names = "core", "device";
>> +            };
>> +
>>               usb2_phy1: phy@9020 {
>>                   compatible = "amlogic,meson-gxl-usb2-phy";
>>                   #phy-cells = <0>;
> 

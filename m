Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4677D11183
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 14:00:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28FE98437F;
	Thu, 27 Nov 2025 15:00:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="k2An57ri";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12DA9843C1; Thu, 27 Nov 2025 15:00:53 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DACB8437E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 15:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764252050; x=1764856850; i=xypron.glpk@gmx.de;
 bh=eCSfF08HEX1Qte60iNqzEBcbzaMbliaK3YHLpRTB0ws=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=k2An57riD5aQsBgqM+J988Hc1aR6Doh/YMM/HGsHXElZrM1A+/DLFvAxwZRF9cfD
 DIaYRqBclfyvasZ1r8IEumL2bQsddblvqCgq8qMly1Hkh1n23M0smVG1afq+T91Jr
 QivS58ngSvNKMqPfWC1LeFw3q9eI9lonFZoNY3US0JMs4Lo0zkGw+mX0zfO29A/5+
 Kgc/bxoP1zGWIeHKECUUjvCbdb3YuReYiTvkPXocbg93+bAdxeSWi9+R3MJjPPXEn
 AYMxmJyBeAkKh7BGQ1mNGOWKb7aJg9fYUkdsAONh3Lnjm2aU6OW+4oKlt/3fzoGqA
 ZPXGfZ47VVXZ2/i6lQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.120] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MeU0k-1vz3lV49pc-00d9po; Thu, 27
 Nov 2025 15:00:50 +0100
Message-ID: <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
Date: Thu, 27 Nov 2025 15:00:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Anand Moon <linux.amoon@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>, Quentin Schulz <quentin.schulz@cherry.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AolKMVQzaT/pIUUzYcP7mzODzn/+LvN5SSRQrPfKFYHeOL94guc
 Hi+XlLbmUFETS901mZfeMvCD32dBoGZhWdTL7xXMB4ecoaTzKq/k5QMWOv68v+9ySZeZ9D9
 MFJONIwR7awmeMd36RcFIlM+O+y7tNScoNbh7SY14cK7GpRByzrH2iBPz/FC1h8IFJBuGkW
 LvAogu8wHYSEasHWdETXA==
UI-OutboundReport: notjunk:1;M01:P0:0OtudFx+ZuA=;t1eMcALINcnHsFgyUu/JghuJ67W
 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
 4A+g72SHUR9esXtLL+nYDnDQyVA6A
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

On 11/27/25 14:01, Anand Moon wrote:
> Hi Quentin,
>=20
> On Thu, 27 Nov 2025 at 16:24, Quentin Schulz <quentin.schulz@cherry.de> =
wrote:
>>
>> On 11/27/25 11:35 AM, Quentin Schulz wrote:
>>> Hi Heinrich,
>>>
>>> On 11/26/25 5:46 PM, Heinrich Schuchardt wrote:
>>>> On 11/26/25 16:00, Quentin Schulz wrote:
>>>>> Hi Heinrich,
>>>>>
>>>>> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
>>>>>> Hello Jagan, hello Heiko,
>>>>>>
>>>>>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial
>>>>>> console output stops after "PMIC:  RK808". The same can be observed
>>>>>> with v2025.01.
>>>>>>
>>>>>> The serial console works as expected if I disable
>>>>>> CONFIG_ROCKCHIP_IODOMAIN.
>>>>>>
>>>>>
>>>>> It is I believe implied here but asking for confirmation. The board
>>>>> doesn't actually boot right? It's not that the serial console is
>>>>> gone, it's that the device is stuck?
>>>>
>>>> Hello Quentin,
>>>>
>>>> Thank you for looking into this.
>>>>
>>>> The device boots I. But the serial console output becomes mute and I
>>>> cannot send keystrokes via the serial console.
>>>>
>>>
>>> Uh. That is *weird*.
>>>
>>>>>
>>>>>> The problem seems to be specifically related to the bt656-supply.
>>>>>> Removing the line below also fixes serial console output:
>>>>>>
>>>>>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/
>>>>>> rockchip- io-domain.c
>>>>>> index a0573c52193..b0d78f2d4b4 100644
>>>>>> --- a/drivers/misc/rockchip-io-domain.c
>>>>>> +++ b/drivers/misc/rockchip-io-domain.c
>>>>>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data
>>>>>> soc_data_rk3328 =3D {
>>>>>>    static const struct rockchip_iodomain_soc_data soc_data_rk3399 =
=3D {
>>>>>>           .grf_offset =3D 0xe640,
>>>>>>           .supply_names =3D {
>>>>>> -               "bt656-supply",         /* APIO2_VDD */
>>>
>>> Reading the code and this diff again, this you shouldn't do at all. Th=
e
>>> offset in the array is the bit offset for the IO domain setting in the
>>> GRF at offset 0xe640. So by removing this line, you configured APIO2 I=
O
>>> domain with APIO5 settings (audio-supply).
>>>
>>> It would be better to write NULL instead, so that the others are tried
>>> and we can pinpoint the faulty one.
>>>
>>>>>>
>>>>>
>>>>> The UART2 (which I assume is the serial you're using for the console=
)
>>>>> isn't on that IO domain. And there doesn't seem to be anything
>>>>> important to booting on APIO2 domain according to Rock 4A schematics=
[1].
>>>>>
>>>>> bt656-supply also doesn't seem to be anything special. LDO5 (vcc_3v0=
)
>>>>> on RK808, which is using VCC10 (vcc10-supply) which is a fixed
>>>>> regulator whose parent supply is also a fixed regulator. So I am not
>>>>> sure what could be going wrong there.
>>>>
>>>> In the schema LD05 on the RK808 is connected to VCC_1V5.
>>>>
>>>
>>> Sorry, I meant to say LDO8.
>>>
>>>> With any of the following values I can enter commands via serial
>>>> console but still get no output. So none of the voltages seems to be
>>>> the correct one.
>>>>
>>>> diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi b/
>>>> dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> index 046dbe32901..f15b5b63815 100644
>>>> --- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> +++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
>>>> @@ -517,7 +517,7 @@
>>>>
>>>>    &io_domains {
>>>>           audio-supply =3D <&vcca1v8_codec>;
>>>> -       bt656-supply =3D <&vcc_3v0>;
>>>> +       bt656-supply =3D <&vcc_1v5>;
>>>> or
>>>> +       bt656-supply =3D <&vcc_0v9>;
>>>> or
>>>> +       bt656-supply =3D <&vcc_1v8>;
>>>>
>>>>>
>>>>> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa
>>>>> Rock 4A. Puma boots master reaches U-Boot CLI with the IO domain
>>>>> driver compiled in.
>>>>>
>>>>> Can you check the error paths (all the ones with a continue;) in
>>>>> rockchip_iodomain_probe()? Which ones do you enter for which supply?
>>>>>
>>>>> Not sure where to start debugging tbh.
>>>>
>>>> I found the driver by setting CONFIG_LOG=3Dy and log level 7.
>>>>
>>>> Here is how the console output ends. Do you have access to a board or
>>>> do you need further debug output?
>>>>
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index=
:
>>>> regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:
>>>> regulator-min-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:
>>>> regulator-max-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:
>>>> regulator-init-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:
>>>> regulator-min-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:
>>>> regulator-max-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:
>>>> regulator-ramp-delay: (not found)
>>>> ofnode_read_bool: regulator-force-boot-off: false
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index=
:
>>>> regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:
>>>> regulator-min-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:
>>>> regulator-max-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:
>>>> regulator-init-microvolt: (not found)
>>>> ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:
>>>> regulator-min-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:
>>>> regulator-max-microamp: (not found)
>>>> ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:
>>>> regulator-ramp-delay: (not found)
>>>> ofnode_read_bool: regulator-force-boot-off: false
>>>> ofnode_find_subnode: regulator-state-mem: regulator-state-mem:
>>>> regulator-state-mem
>>>> regulator-state-mem
>>>> ofnode_read_bool: regulator-off-in-suspend: true
>>>> ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index=
:
>>>> regulator-suspend-microvolt: (not found)
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_prop: assigned-clock-rates: <not found>
>>>> ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656-supply:
>>>> 0x7a (122)
>>>> rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at
>>>> 3000000 uV
>>>> ofnode_read_u32_index: audio-supply: of_read_u32_index: audio-supply:
>>>> 0x91 (145)
>>>> rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at
>>>> 1800000 uV
>>>> ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0 p0=
   $
>>>>
>>>
>>> This seems to highlight the issue is rather audio-supply.
>>>
>>> And indeed, audio-supply should be vcc_3v0 and not vcca1v8_codec.
>>>
>>
>> Mmmmmm, upstream kernel has 8240e87f16d1 ("arm64: dts: rockchip: fix
>> audio-supply for Rock Pi 4"). So it seems it "fixed" something.
>>
>> So before I send a revert to the kernel and start an endless thread, ca=
n
>> you test locally that the following indeed fixes it?
>>
>> diff --git a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> index 4861574636e..dccc469a507 100644
>> --- a/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> +++ b/arch/arm/dts/rk3399-rock-pi-4-u-boot.dtsi
>> @@ -14,6 +14,10 @@
>>          };
>>    };
>>
>> +&io_domains {
>> +       audio-supply =3D <&vcc_3v0>;
>> +};
>> +
>>    &sdhci {
>>          cap-mmc-highspeed;
>>          mmc-ddr-1_8v;
>>
> Thanks. I am having the same issue with my Radxa Rock Pi 4 B Plus.
>=20
> But I am booting from SPI flash, so I cannot stop this board in the
> U-Boot prompt.
>=20
> Is there any other way to flash the SPI flash u-boot-rockchip-spi.bin im=
age
> in the user space to spi flash? using dd coammnd
>=20
>  From the schematics, it has W25Q64FWZPIG
>=20
> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_2018111=
2.pdf
>=20
> I have tried to enable SPI flash, but it is not getting detected on
> the board in userspace.


https://wiki2.radxa.com/Rockpi4/dev/usb-install
has some guidance how to avoid booting from SPI NOR flash.

Set the jumper as shown in the picture to boot from SD-card.
Once booted remove the jumper to erase or update the SPI flash from U-Boot=
.

Best regards

Heinrich

>=20
> $ git diff arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> index 9c741d1a3047..d18b59ddaa1d 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4b-plus.dts
> @@ -42,6 +42,16 @@ &sound {
>          hp-det-gpios =3D <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
>   };
>=20
> +&spi1 {
> +       status =3D "okay";
> +
> +       flash@0 {
> +               compatible =3D "winbond,w25q64", "jedec,spi-nor";
> +               reg =3D <0>;
> +               spi-max-frequency =3D <108000000>;
> +       };
> +};
> +
>   &uart0 {
>          status =3D "okay";
>=20
> Can you share some input on how to resolve this issue?
>=20
>>
>> Cheers,
>> Quentin
>=20
> Thanks
> -Anand


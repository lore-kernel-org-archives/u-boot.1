Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D032D11186
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 16:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD76883B72;
	Wed, 26 Nov 2025 17:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="MC5gXz7z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE96583C53; Wed, 26 Nov 2025 17:46:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89DEC839DD
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 17:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1764175615; x=1764780415; i=xypron.glpk@gmx.de;
 bh=evsiJNlYCYoLyr00e95aUCiJUBX9pzfcFFfMTaRR8BQ=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=MC5gXz7zFHiQjMgn1dk2WfUAxyTRZqev/WhN5RGBJQHN4MuuwhlhrkhimiM36n7V
 wdG2U6eNoE4y+h1LoejjY9xIWcF0Hqw3NTMtmrnXVkcD3xfGpTacakBJjrSCIvVIO
 YcxBx4+l/DBKIALACctwSa905HxDlMKEvqC7FfixkMnWIENyGc4+ABIar2lu9XvFs
 z8f2LuUsWLi0623KUe8feR5mlViOSVe0CI7fXY0W7yTAR2HUQnzKkIWCAChLJywp4
 asBSn54ULRhVKyb94KhMPlWTR3km+T1yrn5AAnXe5SV8Hgm0lun6uC5YBxb5FP0hB
 gP+HTXE4dkUFbeYKIA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.120] ([5.147.80.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOREc-1vkv331Bsc-00PcrR; Wed, 26
 Nov 2025 17:46:55 +0100
Message-ID: <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
Date: Wed, 26 Nov 2025 17:46:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jonas Karlman <jonas@kwiboo.se>, Jagan Teki <jagan@amarulasolutions.com>,
 Heiko Stuebner <heiko@sntech.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HEfyZqOmre/M73niem4S5bMtn6aRSZGgMakOonsBCgXPfAAYVKv
 hqcWyCifLOjEroW7utvNITZqEvElRQFUsCrhuhxl1/uwkOZzJu7qIm8MLAbcb/8/k/BIO7O
 jGj8KVEW3hbFTCix0JNgBcZ7hpqUdlOhQuLzBTU4eI844kpsqovoI0Nn5tKKE+veHN0xytv
 mHjrU8D2+MdPbYJRmhPQw==
UI-OutboundReport: notjunk:1;M01:P0:BIJdsuX2R48=;5BAaIEGB5ymP2iOAH0tnG5evOqF
 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
 8xh1Epoca8nAe11d3Ku7d0TulgX2G
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

On 11/26/25 16:00, Quentin Schulz wrote:
> Hi Heinrich,
>=20
> On 11/25/25 7:02 PM, Heinrich Schuchardt wrote:
>> Hello Jagan, hello Heiko,
>>
>> When testing U-Boot origin/master on my Raxda Rock Pi 4A serial=20
>> console output stops after "PMIC:=C2=A0 RK808". The same can be observe=
d=20
>> with v2025.01.
>>
>> The serial console works as expected if I disable=20
>> CONFIG_ROCKCHIP_IODOMAIN.
>>
>=20
> It is I believe implied here but asking for confirmation. The board=20
> doesn't actually boot right? It's not that the serial console is gone,=
=20
> it's that the device is stuck?

Hello Quentin,

Thank you for looking into this.

The device boots I. But the serial console output becomes mute and I=20
cannot send keystrokes via the serial console.

>=20
>> The problem seems to be specifically related to the bt656-supply.=20
>> Removing the line below also fixes serial console output:
>>
>> diff --git a/drivers/misc/rockchip-io-domain.c b/drivers/misc/=20
>> rockchip- io-domain.c
>> index a0573c52193..b0d78f2d4b4 100644
>> --- a/drivers/misc/rockchip-io-domain.c
>> +++ b/drivers/misc/rockchip-io-domain.c
>> @@ -239,7 +239,7 @@ static const struct rockchip_iodomain_soc_data=20
>> soc_data_rk3328 =3D {
>> =C2=A0=C2=A0static const struct rockchip_iodomain_soc_data soc_data_rk3=
399 =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .grf_offset =3D 0xe640=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .supply_names =3D {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 "bt656-supply",=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* APIO2_VDD */
>>
>=20
> The UART2 (which I assume is the serial you're using for the console)=20
> isn't on that IO domain. And there doesn't seem to be anything important=
=20
> to booting on APIO2 domain according to Rock 4A schematics[1].
>=20
> bt656-supply also doesn't seem to be anything special. LDO5 (vcc_3v0) on=
=20
> RK808, which is using VCC10 (vcc10-supply) which is a fixed regulator=20
> whose parent supply is also a fixed regulator. So I am not sure what=20
> could be going wrong there.

In the schema LD05 on the RK808 is connected to VCC_1V5.

With any of the following values I can enter commands via serial console=
=20
but still get no output. So none of the voltages seems to be the correct=
=20
one.

diff --git a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi=20
b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
index 046dbe32901..f15b5b63815 100644
=2D-- a/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
+++ b/dts/upstream/src/arm64/rockchip/rk3399-rock-pi-4.dtsi
@@ -517,7 +517,7 @@

  &io_domains {
         audio-supply =3D <&vcca1v8_codec>;
-       bt656-supply =3D <&vcc_3v0>;
+       bt656-supply =3D <&vcc_1v5>;
or
+       bt656-supply =3D <&vcc_0v9>;
or
+       bt656-supply =3D <&vcc_1v8>;

>=20
> RK3399 Puma and RockPro64 have APIO2 set to 1.8V vs 3.0V for Radxa Rock=
=20
> 4A. Puma boots master reaches U-Boot CLI with the IO domain driver=20
> compiled in.
>=20
> Can you check the error paths (all the ones with a continue;) in=20
> rockchip_iodomain_probe()? Which ones do you enter for which supply?
>=20
> Not sure where to start debugging tbh.

I found the driver by setting CONFIG_LOG=3Dy and log level 7.

Here is how the console output ends. Do you have access to a board or do=
=20
you need further debug output?

ofnode_find_subnode: regulator-state-mem: regulator-state-mem:=20
regulator-state-mem
regulator-state-mem
ofnode_read_bool: regulator-off-in-suspend: true
ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:=20
regulator-suspend-microvolt: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:=20
regulator-min-microvolt: (not found)
ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:=20
regulator-max-microvolt: (not found)
ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:=20
regulator-init-microvolt: (not found)
ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:=20
regulator-min-microamp: (not found)
ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:=20
regulator-max-microamp: (not found)
ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:=20
regulator-ramp-delay: (not found)
ofnode_read_bool: regulator-force-boot-off: false
ofnode_find_subnode: regulator-state-mem: regulator-state-mem:=20
regulator-state-mem
regulator-state-mem
ofnode_read_bool: regulator-off-in-suspend: true
ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:=20
regulator-suspend-microvolt: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: regulator-min-microvolt: of_read_u32_index:=20
regulator-min-microvolt: (not found)
ofnode_read_u32_index: regulator-max-microvolt: of_read_u32_index:=20
regulator-max-microvolt: (not found)
ofnode_read_u32_index: regulator-init-microvolt: of_read_u32_index:=20
regulator-init-microvolt: (not found)
ofnode_read_u32_index: regulator-min-microamp: of_read_u32_index:=20
regulator-min-microamp: (not found)
ofnode_read_u32_index: regulator-max-microamp: of_read_u32_index:=20
regulator-max-microamp: (not found)
ofnode_read_u32_index: regulator-ramp-delay: of_read_u32_index:=20
regulator-ramp-delay: (not found)
ofnode_read_bool: regulator-force-boot-off: false
ofnode_find_subnode: regulator-state-mem: regulator-state-mem:=20
regulator-state-mem
regulator-state-mem
ofnode_read_bool: regulator-off-in-suspend: true
ofnode_read_u32_index: regulator-suspend-microvolt: of_read_u32_index:=20
regulator-suspend-microvolt: (not found)
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_prop: assigned-clock-rates: <not found>
ofnode_read_u32_index: bt656-supply: of_read_u32_index: bt656-supply:=20
0x7a (122)
rockchip_iodomain io-domains: bt656-supply: Regulator LDO_REG8 at 3000000 =
uV
ofnode_read_u32_index: audio-supply: of_read_u32_index: audio-supply:=20
0x91 (145)
rockchip_iodomain io-domains: audio-supply: Regulator LDO_REG1 at 1800000 =
uV
ofnode_read_u32_index: sdmmc-supply: of_read_u32_@L@@p0b@HHb```Hp0 p0   $

Best regards

Heinrich

>=20
> [1] https://dl.radxa.com/rockpi4/docs/hw/rockpi4/4a/ROCK_4A_V1.52_SCH.pd=
f
>=20
> Cheers,
> Quentin


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05959C282D0
	for <u-boot@archiver.kernel.org>; Fri,  7 Mar 2025 09:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45F458122F;
	Fri,  7 Mar 2025 10:30:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="vRceQ+o6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C06AF81276; Fri,  7 Mar 2025 10:30:07 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D8E811C1
 for <u-boot@lists.denx.de>; Fri,  7 Mar 2025 10:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1741339795; x=1741944595; i=smoch@web.de;
 bh=5KG7VKdbuADHS8O5bdU4PyKbCCUsTEqbvyOdniQjoA4=;
 h=X-UI-Sender-Class:Content-Type:Message-ID:Date:MIME-Version:
 Subject:To:Cc:References:From:In-Reply-To:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=vRceQ+o6b12q8im+kts06lolsuWMvaC8KTfzCSz3VhGxTr5hDCVLZjlgqOTogFsn
 YRvozBxdaqSfRbCegqyhy3zB5uFKmnuxtnoD/8P3axIiCTIk+LbzUA/GrgbMgqcxv
 nWsONGNwcE7rxaltL2PxtvmTAJOcT4NhzhDzfAxLaGQqepiQsdh7RF0H6HHwfXyll
 VYw7tockNkY8krq98qQWgjw8OxS7oHuR7e97qGqEkwTVZXCtBpFy/yyHZ/LRUyWN7
 ml02L7XL9j8+FBImuTp75jC01h4j7Gs5QAcS6Y0/Px/LjPJ17NbWjKNsh9/RZVYgb
 C0AEw1KJGVqI068PeQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1tQjjQ1BEV-00dSv8; Fri, 07
 Mar 2025 10:29:55 +0100
Message-ID: <0ed21fc1-6982-4c11-a913-bc03dbb541a1@web.de>
Date: Fri, 7 Mar 2025 10:29:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] USB-PD TCPM improvements
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Anand Moon <linux.amoon@gmail.com>, Peter Robinson
 <pbrobinson@gmail.com>, Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>, Tim Harvey <tharvey@gateworks.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Maxim Kiselev <bigunclemax@gmail.com>
References: <20250226184506.64114-1-sebastian.reichel@collabora.com>
 <CANAwSgSur2VawHniSEZBD3AO63YnvUGf9m1_8p-XMNxQF+yziQ@mail.gmail.com>
 <CALeDE9Nq_xbOc3W8hefPQuVBi_Xc_2r18cw6+jeEHeGKyHEa-g@mail.gmail.com>
 <CANAwSgTu3ixjQRLZRqx_+nHNinDJSdphHHELtiHLANs+LF9YCw@mail.gmail.com>
 <fbzod24w4kjhntzcnt36znqtyfykoao7u6g37wvzejtxxyljm4@w44tbipyhfkr>
 <CANAwSgTcDL8o_t90+aL0g0FnvoiJE-risKCJBFrYrp9DukmtVg@mail.gmail.com>
 <oxb7v5iwqjgyhsk2tc76oybmnmfvvnen67g32vpht3fgnagvif@t4enpaooabmv>
 <CANAwSgRL2fMzGWdywdzp2BrkYWE0bw3RHa6K-Xf7ByFgjY=a5g@mail.gmail.com>
 <CANAwSgQYPHyiFe9q+=+vWa9+pdrnEqz01L2fG8yXTaRqepubxA@mail.gmail.com>
Content-Language: en-US, de-DE
From: Soeren Moch <smoch@web.de>
In-Reply-To: <CANAwSgQYPHyiFe9q+=+vWa9+pdrnEqz01L2fG8yXTaRqepubxA@mail.gmail.com>
X-Provags-ID: V03:K1:kXxRnIht3csACW29cVbkdtKX0Uptq0Cb19KI4mGmOjzEf5UykzO
 ZWwBhvQ+y35m1lsbjgADGoENK9RiRdPQ7IE56mQMeK6L4esLdav9+pyPDRCfCwPKLfRbG5D
 buYhk33zisPsKX7Psx54ltPQVdOoW73fhdxhwjUTvGIWSUaA4whGLfw4WBCeu+hZy2P5fiM
 0mDW84zpxfghrOGnR7N1w==
UI-OutboundReport: notjunk:1;M01:P0:Oj6nPx/3iRw=;7F3XpNeccanSmdFVXuJm1ejg1WV
 ZWM5g7bxlxTv0NEDwg3Wl/5VTrpHDDY+9uDW2uxgfjI6gpqwRSt+KAwjKGOYNNj6JHc/HF0Eh
 dSPIlw51cvvk3tMBxbO384/E8us8zvoSDdP0cFylyjKwzDme6VVtGe1LRyOapQ8qASH7F91OT
 jHBT/+JV+yyouOb2HSuqZcoyUdEoTwQI0C6HwWq2D+iB+HXZQW/H2sB+YGBO956K6FB95g3rz
 xMC9zOK/WAzl2T8gg4wpTAW8YaQrn0LYZp+pU2aYZn53pqtJeRrFYT6WasodpnTvbp+U69rCn
 Rz/5v41ic7462e7XOypL/pKn20oNpG7z8tPL/B9A/zZ12PyjML9ZgmjWagvQ5bUCVzcI0AxQs
 ai7sLXYR+XfqKRRYYRlzdi14UOA28CeunjUhWnJDheuqcHopz04cGomR/fVTHU5Br6ST5f4vl
 G6nUBbEPJF3N3+RCavm2YRz810hJGjuNilY9MTT/5cwciduHQEkDEZEX3ArPOflCY56GsDhmW
 CsCti2rqFp4b3jDo22pqGEd3Ewy71aIA9/QhSYEFE5rqsO5Ig4KiV9hx0JqMnu0hiFBikTDk5
 34bMsWFp3svUUF79YHlBaLEs8B5CGhWHns4rt2mRCrOxgafJAbZFcvw9+9eRGRby18b36bB9r
 ypWjgozi/mOJp0rBsE3doK6NPwB9W3uKPO97XA4j8beU3ujDKufnEREECal0E3BjHHv+Srmxq
 DEf2PVsxjtrrLJnB77jER7EAHK8uaj92SgRGR5NSZMQUzfmnpGzf6MN4uWQuImmf4BxTCh5fu
 j7qAWrsChFdJsZchY04KOmBzNe8YrJU4R0XZMMXbKGl0K3BOS44P551MdQ1GgwKSQ5b7cY54d
 yOz187MpR7/ePw5sFBhZqGbdbBKg1cyQlWqSum4lHGkYQnww7V0uQDnDeOEHqZgBHqH0I9RQP
 s8uhotdkYiZoHlN+SoMNCAim2oR90EBCVFshPzg6Tp7XnCH2RLPPwJ5ryVqc+4atZQRgUQBB2
 jQXnwim6SWIh7VScQiyL+3lXlsWNDHM61xBQrTtl4AGr4uV4x7TnQOwWiPYLVhmJoLBKULIm7
 rYwHPgO8N1i0X/4ltGYsYhP3SotAuDypzYszEtROfMT4PlDLJZJjrFi7toM1BLDwk1qFtl1wD
 PGdkhW3yWbgVMWtoNoJ1ihBlf/tR1cAdpuP7kW9RYQ3quMzCWMsobQUD2WCNmvr7LyLQtKU5S
 WFByLTL/p99FjAKyQ6S09IxyF9zG2iV+XA2zy6a5EGXTHCvfX4ZgeaZms51QO+GFxEh/KOUNY
 pRV8VBojNvkqSTWeymqaL/v5FFCr9slKnENFHfkIqCRupde9oK3SZwqifrHZ5qaao1c8OyFFf
 buOKkmy2yR7ffcORJNJ80clOwrPGQtiMC6wQopcYhHs7tuvkF34WKM55Tu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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



On 06.03.25 20:00, Anand Moon wrote:
> Apologies, I had not applied the whole series of patches
>
> Please add my
> Reviewed-by: Anand Moon<linux.amoon@gmail.com>
> Tested-by: Anand Moon<linux.amoon@gmail.com>
>
> After applying enabling debug I am convinced this works on my Rock Pi 5b=
 Board.
>
> U-Boot 2025.04-rc3-00057-g671ac2d744b2 (Mar 06 2025 - 23:51:44 +0530)
>
> Model: Radxa ROCK 5B
> SoC:   RK3588
> DRAM:  8 GiB
> fusb302 usb-typec@22: probing Type-C port manager...fusb302
> usb-typec@22: fusb302 device ID: 0x91
> fusb302 usb-typec@22: TCPM: set voltage limit =3D 0 mV
> fusb302 usb-typec@22: TCPM: set current limit =3D 0 mA
> fusb302 usb-typec@22: fusb302 start drp toggling
> fusb302 usb-typec@22: TCPM: init finished
> fusb302 usb-typec@22: TCPM: CC connected in CC2 as UFP
> fusb302 usb-typec@22: TCPM: set voltage limit =3D 5000 mV
> fusb302 usb-typec@22: TCPM: set current limit =3D 3000 mA
> fusb302 usb-typec@22: CC activities detected, delay handling
> fusb302 usb-typec@22: CC activities detected, delay handling
> fusb302 usb-typec@22: Initiating hard-reset, which might result in
> machine power-loss.
> fusb302 usb-typec@22: TCPM: PD transmit data failed: -110
> fusb302 usb-typec@22: TCPM: set voltage limit =3D 5000 mV
> fusb302 usb-typec@22: TCPM: set current limit =3D 3000 mA
> fusb302 usb-typec@22: CC activities detected, delay handling
> fusb302 usb-typec@22: CC activities detected, delay handling
> fusb302 usb-typec@22: TCPM: PD chip enter low power mode
> Core:  362 devices, 34 uclasses, devicetree: separate
> MMC:   mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
>
I also tested this series on top of v2025.04-rc3 with my working USB-PD
power supply.
Of course I cannot check the improvements for problematic power
supplies, but I
can confirm that there are no regressions from this series in my setup.

For the series:
Tested-by: Soeren Moch <smoch@web.de>


U-Boot 2025.04-rc3-00004-g27c9bc97fafe (Mar 07 2025 - 09:39:42 +0100)

Model: Radxa ROCK 5B
SoC:=C2=A0=C2=A0 RK3588
DRAM:=C2=A0 8 GiB
Core:=C2=A0 362 devices, 34 uclasses, devicetree: separate
MMC:=C2=A0=C2=A0 mmc@fe2c0000: 1, mmc@fe2d0000: 2, mmc@fe2e0000: 0
Loading Environment from nowhere... OK
In:=C2=A0=C2=A0=C2=A0 serial@feb50000
Out:=C2=A0=C2=A0 serial@feb50000
Err:=C2=A0=C2=A0 serial@feb50000
Model: Radxa ROCK 5B
SoC:=C2=A0=C2=A0 RK3588
Net:=C2=A0=C2=A0 No ethernet found.
Hit any key to stop autoboot:=C2=A0 0
=3D> tcpm list
| ID | Name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | Parent name=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | Parent
uclass @ seq
|=C2=A0 0 | usb-typec@22=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c@f=
eac0000=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | i2c @ 4 |
status: 0
=3D> tcpm dev 0
dev: 0 @ usb-typec@22
=3D> tcpm info
Orientation: reverse
PD Revision: rev3
Power Role:=C2=A0 sink
Data Role:=C2=A0=C2=A0 device
Voltage:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.000 V
Current:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.000 A
=3D>

Thanks,
Soeren

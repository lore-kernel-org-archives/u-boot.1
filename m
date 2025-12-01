Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B684D116F3
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 17:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2CE783C96;
	Mon,  1 Dec 2025 18:21:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5807783C96; Mon,  1 Dec 2025 18:21:16 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31CEA83C01
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 18:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=radxa.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=naoki@radxa.com
X-QQ-mid: zesmtpip4t1764609617tc9313e83
X-QQ-Originating-IP: xzb1jBfznhuGJeoLCkVbUtYlrCQezB3OQPXOPCWrKbQ=
Received: from [IPV6:240f:10b:7440:1:e8aa:ab7: ( [localhost])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 02 Dec 2025 01:20:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14713128042619450623
Message-ID: <4D137134CA227A81+dba25938-64d5-4518-83a3-ee85e61eee60@radxa.com>
Date: Tue, 2 Dec 2025 02:20:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Raxda Rock Pi 4A serial console output stops prematurely
To: Anand Moon <linux.amoon@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Jagan Teki <jagan@amarulasolutions.com>, Heiko Stuebner <heiko@sntech.de>
References: <e7b7b905-4a6c-4342-b1a5-0ad32a5837cf@gmx.de>
 <94561b0d-8203-4210-b599-93070eb934cf@cherry.de>
 <89385ade-7d7d-4a8c-b929-f4eb47e254cc@gmx.de>
 <4fcde736-c5e1-4800-8b75-ab87c0dd8b0a@cherry.de>
 <53057b6b-12b2-498c-aea6-88f535c0b096@cherry.de>
 <CANAwSgQcFRYKW0+vG6TVj_-EYYQSdF=t3KYFF0FtOSkN5uLtvw@mail.gmail.com>
 <11d29eb3-bc21-46e1-842a-bb163995fe59@gmx.de>
 <CANAwSgS9+naVnyFv=+1BDHdH4DpHGSCzWWZHFxiDKmDUXu+zCg@mail.gmail.com>
 <0FB759C1BA7AEB85+a26afcc4-c5e8-4452-a6ce-e19736be395b@radxa.com>
 <CANAwSgRRYg-QLATDWcdf8nubv1+Hqn9r_R8D1bFYui3i1nYitw@mail.gmail.com>
 <53143B48341F9068+600cd801-8c7e-4407-a3e9-13c83ac5ca67@radxa.com>
 <CANAwSgQBwoUNYQkhbkmBZ3UMAO=+NUw6rK+=vT0=BCBRxAjD6w@mail.gmail.com>
 <99ACD06BACB0AD72+efbd4b3a-db5a-4a83-97c5-c1df635385ff@radxa.com>
 <CANAwSgSc1AgkXUkEWHqKgWbOa4djL051mLh4J23m+mkVopRQdQ@mail.gmail.com>
 <a9a4deea-4f53-4103-97f9-32d96177c6e1@cherry.de>
 <CANAwSgR0cX8nkUMx6ubHjsLgrV95MMHeqMaUqGGgXgUhd77VBA@mail.gmail.com>
Content-Language: en-US
From: FUKAUMI Naoki <naoki@radxa.com>
In-Reply-To: <CANAwSgR0cX8nkUMx6ubHjsLgrV95MMHeqMaUqGGgXgUhd77VBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NDd9MucL1yTJ1aq7LDQpWI3YrtkXFzl2lNPNikA07J5GfflWNFJW/4zW
 0GrOVS6ulT+vDxxjC2HQYwZjN5kyT9TdkWwTLWgr1wqHoGlmL4P6nAfrXHtriqdR9NzJv8U
 M2qfFft9pbPUp4YMp1ykzkO4J8ld5wOgTJuGic+zZjajKzjDyr8i9IbSQQkv9oBzXAmj23s
 luOh985MwbPZJhgDzXJbim7jAwgKfHjWgtpk1qsVav9J+2MaahsZ1i5vgo1vrau3gdxYUZp
 nXaQ4I50zTmXE3uV6h4WPhVVJphVxHPJaL1PYkypiCFfXATua9e3+t4rDgt7MbHkPuDptih
 IMe0ONLOVoLATN3Od0HZ94dnNKQzKXotX6KRvH8fj0gOSfUSt5526ItWIA+8h4PnFcX8qHj
 bhhEabZoMIuEW8RdU+BTlXbYgj0a+3mxeL4xd2BR7aAQEsSf+TET+6ypaVezXtY66blkFQA
 ULgEnTISJ03R1HvHwm5w7OOD87yFgJHEbh1HIWETEQrVhziUQcZb8KtCxVkabKTNRVqA1R6
 qumW3ASIx9aEY+gk4THUtwT61YO56EuQKC6orc/Uy585o/TS3YVynaM4HeYLkLpYKLYo+QV
 5qN8iWKONYsK5HLqENqsE3M6/y4/mA+0DigD5XNS8DOOFldjiA0JThHT6dKFymBFUawCWAe
 lB5saXfP+eqPgwoxRorEoPEfB2cYZ1GZ//Ti1Tg5ZoHVjmt1vej/J+PGZzG2sY/ngBGocz9
 DWp2xRx+kaqa9C0v8uj7YMhtN/tsWbxtd9GwnVTC/X71LQEk1zOWCi/Gb1uxFOaHtU1D8Rk
 rYrvDEFmCiZah6zF3ATAhkqBI9UpnHKysNtford/xGVLk9OfGiU5azUv7MOXDcOU9R+tZEt
 AdS9Msj+goZraswjugFwG9KlDLxu7RQLrXZR9NGttEz5aSncM1CBIiSNxmLC8ugRH2rZXhk
 wtad/QpFQ4c6m2A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0
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

Hi Anand,

On 12/2/25 02:09, Anand Moon wrote:
> Hi Quentin/ FUKAUMI,
> 
> On Mon, 1 Dec 2025 at 16:12, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>> U-Boot TPL 2025.10-1 (Oct 31 2025 - 11:12:15)
>>> lpddr4_set_rate: change freq to 400MHz 0, 1
>>> Channel 0: LPDDR4, 400MHz
>>> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
>>> Channel 1: LPDDR4, 400MHz
>>> BW=32 Col=10 Bk=8 CS0 Row=15 CS1 Row=15 CS=2 Die BW=16 Size=2048MB
>>> 256B stride
>>> lpddr4_set_rate: change freq to 800MHz 1, 0
>>> Trying to boot from BOOTROM
>>> Returning to boot ROM...
>>>
>>> U-Boot SPL 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
>>> Trying to boot from MMC1
>>
>> I believe this means you booted from eMMC. (MMC2 should be SD card as
>> far as I remember)
>>
>> When you boot from SPI flash, you should see "Trying to boot from SPI"
>> first, if it fails then it'll try to boot from eMMC and then SD card.
>> This is due to
>>
>> u-boot,spl-boot-order = "same-as-spl", &sdhci, &sdmmc;
>>
>> in arch/arm/dts/rk3399-u-boot.dtsi + SPL_SPI* symbols in your .config.
>>
>>> ## Checking hash(es) for config config-1 ... OK
>>> ## Checking hash(es) for Image atf-1 ... sha256+ OK
>>> ## Checking hash(es) for Image u-boot ... sha256+ OK
>>> ## Checking hash(es) for Image fdt-1 ... sha256+ OK
>>> ## Checking hash(es) for Image atf-2 ... sha256+ OK
>>> ## Checking hash(es) for Image atf-3 ... sha256+ OK
>>> ## Checking hash(es) for Image atf-4 ... sha256+ OK
>>> load_simple_fit: Skip load 'atf-5': image size is 0!
>>>
>>>
>>> U-Boot 2025.10-1 (Oct 31 2025 - 11:12:15 +0000)
>>>
>>> SoC: Rockchip rk3399
>>> Reset cause: POR
>>> Model: Radxa ROCK Pi 4A
>>> DRAM:  4 GiB (total 3.9 GiB)
>>> PMIC:  RK808
>>>
>>> You see, I could not control the UART with the key pressed.
>>
>> Because you don't have the audio-supply patch for this U-Boot maybe? Or
>> you didn't actually flash your newly compiled U-Boot on the device this
>> U-Boot loads from.
>>
> My board’s SPI flash is running an outdated firmware that lacks the
> auto-supply patch.
> which results in the UART console being locked

As Quentin said, your board is booted from eMMC. This is why "kill SPI 
flash" didn't work.

Please try to erase eMMC, e.g. `blkdiscard /dev/mmcblk0` on Linux.

Or, please make & insert bootable SD and press & hold maskrom button 
(i.e. kill eMMC) while power on.

Best regards,

--
FUKAUMI Naoki
Radxa Computer (Shenzhen) Co., Ltd.

> Thank you for your support and guidance. I understand that this
> process is tedious
> and challenging to resolve. I will continue debugging the kernel to
> enable erasing
> the SPI flash.
> 
> I have a working development board available for testing and development.
> regardless of the SPI flash status.
> 
> Please allow me some time to debug this issue.
> If I find a solution, I will share the details.
> 
>> Cheers,
>> Quentin
> 
> Thanks
> -Anand
> 



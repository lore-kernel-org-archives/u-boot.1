Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 199D6C47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 10:50:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D507E879CC;
	Sat, 20 Jan 2024 11:50:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ZI887BQo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB1F787D97; Sat, 20 Jan 2024 11:50:13 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 269A6879CB
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 11:50:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1705747810; x=1706352610; i=wahrenst@gmx.net;
 bh=gW7f/ZZuMF8sCm5WJ09TvgLMKCuUFtG5p2QAn+rlXgY=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ZI887BQo6uEXKWbfD7WlgKiMbCxQU3DQbbIhvQJG77rz0jvAi9igo6+jIR/Byi3Q
 z69BW2atkd/p6jkCRoKtOJ8xh1+qAdQvbeBYi9ajojxfaqwSOZ8iW7dLGw18VoX4U
 bTx+O1MGPspog85qkgD53m3oTUzU7zY/jq0z/aaai0Wc6JImDXBI93YH5T3U6Y5Br
 oZAWqye8DX0zzQS9eb52C3Hjaip0guzVhj6FtxoKGOHDU+3pa2zSEHtaPxF3b4i76
 gE5tooyxETwNWHBse8fD7mLi8f/VZj3dLwz30cN/MVaxVDKB6OnEZQKGK3l+v6D0C
 tVw9BkX2mWglyPGRNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1qwlzb3yNi-00fPza; Sat, 20
 Jan 2024 11:50:10 +0100
Message-ID: <ebffa598-6945-4a03-abe4-fe519df5fbfd@gmx.net>
Date: Sat, 20 Jan 2024 11:50:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] rpi5: initial support
To: Jens Maus <mail@jens-maus.de>
Cc: "Ivan T. Ivanov" <iivanov@suse.de>, u-boot@lists.denx.de
References: <03bbe9ad-7cc6-491d-8bd9-631f1cf04f39@gmx.net>
 <418F8AAE-136A-44A0-80C3-D01FFE00EC2E@jens-maus.de>
 <sjmi6dftbgx56isfyjtaryehzq2iollwxm2etlspiygehh3n6v@k4ws56nsbgfn>
 <6C9E5E0C-9C27-45A4-886F-8B8C641EF7A3@jens-maus.de>
 <ejituxf7ggiu2ciswrwoeqqjytb7mj2vn6gkxllywtnlm4aefi@br4zq7rfytlo>
 <3FB75D28-9BF9-4518-8BF1-519C884516F7@jens-maus.de>
 <fa7j66z5r7pul6zp5ljcntrb7xbazqxesz6wysrslrpxxhpafc@krztduo6pjm6>
 <25AB43C7-829F-4F62-AC8E-3284B22ACB03@jens-maus.de>
 <E7BFDAEE-00A9-463A-AF73-75101AFF2BC6@suse.de>
 <FB66DFF3-03B0-4DA5-8916-AB80CA6C6EB5@jens-maus.de>
 <dvpwizpui6a52dfmy57ghv4zmplvgqvow6oec7x5opwzh63zzl@jehyglofr6yh>
 <489FBAE5-501A-49F6-894D-58BE5C5429CC@jens-maus.de>
 <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
 <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
 <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <6E2D7E91-E869-48C6-8CE8-0B410A2B67B9@jens-maus.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+mnteJr0QeieAvsjKoAH+ahsk/x/+PJNL3ejd00nxk6HLqvwLVn
 uH+H/GHYvUA78ClrwtaWnC5v5UGuQrWprs3hAuuOwqMFEwhFFcxEoBJBtDZa3iPwGXebPiZ
 AIreyumKxIptd2bVlVLsH9DLB6qTRCoW/CszGbidvYnfdDPhQIi838/vJnKs8DV1cw9/s/c
 YuPjWJCmv8WG/O6OQUGjw==
UI-OutboundReport: notjunk:1;M01:P0:ZgJHNgqSrnI=;94fGdLpUbsKKZRsQmt1YCgZ+VMn
 eIC+XF+hQMzV/4br1XdH9e4hRYGm6MV/K3/CDNIM6aidJYEYxIZfSjz2l2O0OrtTcnZUrawJO
 mFVPcXHjATadAMJdoLvlWuAdqEWRPV1AItXWVVtUfrQ5Uk4YO1qxN1qGxfVRh1Y/Fe647XSfv
 LAbmXbIAqS6Xx77GRRbG574jznkRcrQwm5KVlPvHFvw5wszVZh5qCFUpbir0aMcy6qHSTw+QO
 BxT/m0ice3J+hJ+FXX4ARU5AdoQNUQWRZnBCg3sV6LkOoNrkvDTKjQUbF4IWihLc0Pa+p0lEG
 Ukn6MbtDAiYlr5BPK2505ex7zEvMz2qu+waEDMOwb/eW2wvATE0+Wxfy6K67itXCh9t3J2Fwp
 DX/LgfmxkWrzKVfFSbQtBZOoC5pzUxjPLCuH/Pkb0Ozc1vSPoew+b/q/yzE1QD5unza6ZRGIK
 x2NGPEGPEUacOzjbkhAvBoolvRupvOacEkDXk8AkPz3CSJxufAg2QZaQDfxotyFsdNDblrMDq
 h7zpHrQSpozcgqTVk8DE0TQxE7Y6uY3MUuPsrh86XOv6YVGs4B870z3bbzT+Li+MuBbiAld8j
 dxUxfkVZBO1tAcL7YSY13m3UfQ3R/pNpNuJAX2iJO7FstXTBfHKAKAynPbd1WjJfjFlfWzW5E
 hqDsvdsxM3Mh7RkhBqRyjmA0UxAbbE3/Jlv75XitkskLjFn8ESBSLTHezbuGWp3L2kc9jwmVb
 yDl+tiwZdPf5FI2scqR0XNE6tcvDNhGjgSa3av9UJSFFxojIk8LLQubS7rwHNKMHZ8z5urUSQ
 E0b6zyVftow/mpQSI2LKbjdHv1fqM7RPEybBMA5Tmh5hhDngtOo6QQhmhAwjrSxSyNfZvZzg6
 Cye0oaSCbMMWWeKUN+nGGKQm4lwVxc54N8tub6v0fCsmPsH+ZaB5mMx+cuIcq2FHL+pZh7MO3
 cZnBCg==
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

Am 20.01.24 um 10:48 schrieb Jens Maus:
> Hi,
>
>> Am 20.01.2024 um 10:22 schrieb Stefan Wahren <wahrenst@gmx.net>:
>>
>> Am 19.01.24 um 22:26 schrieb Jens Maus:
>>> I actually do have some good and bad news:
>>>
>>> 1. Good news: I got u-boot finally showing up with my RaspberryPi5 8GB=
 both on the HDMI and on the serial debug UART like you reported.
>>>
>>> 2. Bad news: I actually got it working by downgrading the rpi-eeprom t=
o the same 2023/10/30 (VERSION:30de0ba5) version like you have.
>>>
>>> So the issue I saw/reported seems to be somehow related/limited to new=
er rpi-eeprom versions. Looking at my previous diff on the rpi bootloader =
log output differences, the potentially relevant piece might be the "M.2 P=
CIe HAT not detected.=E2=80=9C line that is only present in newer rpi-eepr=
om version outputs.
>>>
>>> So hopefully you can reproduce that issue yourself when upgrading your=
 rpi-eeprom version to newer or also the latest version from 2024/01/15 av=
ailable [1] and potentially find the actual piece that prevent your patchs=
et from working on newer eeprom versions.
>> thanks for your work, but i think you are wasting your time. The
>> rpi-eeprom release 2024/01/15 seems to be broken [1]
>>
>> :-(
> Thanks for that info. However, I also tested older eeprom versions to id=
entify when the issue that u-boot cannot boot a rpi5 started to appear. An=
d I am afraid, it already starts with version 2023-11-20 right after the 2=
023-10-30 which currently seems to work fine with Ivan=E2=80=99s patches. =
Looking at the release notes of rpi-eeprom [1] one can see the following e=
ntries:
sorry, i got it wrong. I thought only 2024-01-15 is affected.
Unfortunately i'm not a U-Boot developer and i also don't have a RPi 5.
So i only can give some (hopefully) smart advices :-)

One idea would be to enable early debug in U-Boot (no idea how to
achieve this). I assume U-Boot crashes before it's able to print the
first line, but it's hard to believe it crashes at the very first
instruction of U-Boot. So with some luck we should be able to narrow
done the cause.

Another point would be to open an Github issue on rpi-eeprom and ask
them for advice, why 2023-11-20 stops to work in our case. Sure they
don't want to support U-Boot, but they are also interested in Linux
Mainline support.

Best regards
>
> =E2=80=94 cut here =E2=80=94
> 2023-11-20: Auto-detect support for PCIe expansion HAT (default + latest=
)
>
>      =E2=80=A2 Add autodetect support for PCIe expansion HATs
>      =E2=80=A2 Add PCIE_PROBE=3D1 to the EEPROM config for custom PCIe e=
xapansion designs that do not support the upcoming HAT spec. This gives si=
milar behaviour to CM4 where PCIe x1 is enumerated to discover NVMe device=
s.
>      =E2=80=A2 Fix loading of multiple initramfs images that are not 32-=
bit aligned sizes raspberrypi/firmware#1843
>      =E2=80=A2 Kernel load performance improvement - remove a memcpy
> =E2=80=94 cut here =E2=80=94
>
> So as I stated earlier, one probable catch for the u-boot patches here m=
ight be the mentioned PCIe changes with the rpi-eeprom 2023-11-20 version.=
 Or it might be related to the =E2=80=9Ekernel load performance improvemen=
ts=E2=80=9C mentioned?!?
>
> For now I am of course using the 2023-10-30 rpi-eeprom version and so fa=
r it works flawlessly with Ivan=E2=80=99s u-boot patches. Still I hope Iva=
n or someone else can have a closer look why with the 2023-11-20 version o=
f rpi-eeprom u-boot immediately stops working at all.
>
> best regards,
> jens
>
> [1] https://github.com/raspberrypi/rpi-eeprom/blob/master/firmware-2712/=
release-notes.md


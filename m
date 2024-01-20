Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 437DDC47258
	for <u-boot@archiver.kernel.org>; Sat, 20 Jan 2024 09:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00EE087D98;
	Sat, 20 Jan 2024 10:22:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.net header.i=wahrenst@gmx.net header.b="t3kkQ5ns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DF0487DA1; Sat, 20 Jan 2024 10:22:18 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBA787B6C
 for <u-boot@lists.denx.de>; Sat, 20 Jan 2024 10:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=wahrenst@gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=s31663417; t=1705742535; x=1706347335; i=wahrenst@gmx.net;
 bh=EXjL6LysO2bBM9cDhw+GEC8RA133pkh8pBpHTKRNqf8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=t3kkQ5nsQPpzpglPq4CGUM37WrWtpq6VFOF9c5m1/GTtlqJE4vIjRF1b1a7cuzMl
 h0M4lEOoiOU5qD/MvZyZRipX5v1RbWtfQFFxFKqk8bfHXmD4vN2qMQY0fgsLSyaNo
 DYQEOECUe8bU8WpMy1zu971Q5Dy3KEYchxt4UOCq6Ew3bMHN0PyOcL3D1aW/48hpa
 lG4pJe4aavH4VXL/f+Xp4TiwudnbEOFqImBEhx932QeSk3vvUrtwO/5JKmXRtZIAd
 BeYM6ZluseKpI5XXcR1K6hrut0Bycly3yOi8UvzIVPxp9stRzaJsBvRlMdY2+OEXC
 1QrtyHeE/J4znjPU9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNbkp-1rk9qW1cux-00P8Wi; Sat, 20
 Jan 2024 10:22:15 +0100
Message-ID: <246035ba-0090-4cc3-982e-1de837ec7340@gmx.net>
Date: Sat, 20 Jan 2024 10:22:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] rpi5: initial support
To: Jens Maus <mail@jens-maus.de>, "Ivan T. Ivanov" <iivanov@suse.de>
Cc: u-boot@lists.denx.de
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
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <A0746263-646C-40C6-A2A6-659C39385E8B@jens-maus.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ikyPtqBIiMJvr66vjwsA69xbBLfYbf0KM77TGRbCv4i3FS9ak4d
 sM7FrWUKCrri/e+QTbZEMJWJ0beIv924D61d9ANMgFb0S6A1wqL4wm7hpEaN2WXpZ3JTLUm
 8TfIEZIdd7KH2CVMYAsf426+vDCyv4ege5srj8oR1LLAFeHnc7ku60A1z+S7yLRVDmxd/Cr
 6fPI06vI30HZdHmatpzIA==
UI-OutboundReport: notjunk:1;M01:P0:GpWT9jOMt20=;bngsLICGVPU+VhtFIcLyjfZir6e
 mJRVTxmCbVmBcBeqD53Vg22vph1dv6jNUvdu0JU1YaVSFLuOGGeBLUGkZkUR9MYaCtEzy9eha
 Tzh6A3P1ATgKEZVc0REizwk9OA0egH6BNg67RBl/75ixzpcN/aBRlUFo+WmplrDL7/Nljwd51
 zQuRcoozUZvaC83M7GDyLWPhOkVU2w5G27Au5a0c8Y3hSJ9z/IiRJJjlKxFatL0E+JgbBIhfg
 zO0HCwjKTQdUxlf2pzV6CThWMtjz6oKJhdfEBjmtjF5gE9Nebx/4cZdAHhp1vXXmihM65xD7T
 Y6xvDp2gF5i67Wwak0N3YrB+N/xOJJh1xpOM/pG9Wd0FyVgPsBR1efT0iXrWJdykZPs4JfL9p
 Ds/atn0r2dXt79bphYrN3mX8xkEPJF7tgJlUFzhrZRKZzER3HqSQ+Z6sxTLCz2sbYVNrR17D0
 1iOmcXn7VgRucJyzNtK10hCyIO7e1rKl7lr+f8oIceCwtnV2cwG7dpiuChbdMtgXlTJE9qOPU
 YXnHy9cK4HuGoiNk/IxP6O851Y6db52Gvuxpp0B+jVkjWDsa8OrOv6lNbk7O7oad5Ec6I9Cfl
 +SGTPo9XPxZOiG3UFreQJWxB7yvPmgRS0lrl3DyVznM6/qb0sFYD9lTYlN0HqPXxCOWFCzxd+
 mR9DSFQWrsFWx7PJEIL+tG5ICzLZh5fxx0Bdgphwoa+PZApYemCWiBcphSRl6WnK6M7icIMa2
 1cB3LrkCckCrxzBkp4r9pgIUCzoPGkLGZVC7t2n3mxLA8ed5GotvPxmXewEFRSe3I8TmhU+V6
 4eSjD3v5KfCE/pf/pFXrho3WhIAi1MZt6nlJtcxiVf2LzDY8Uw7G/tDFmyHf9FoPbBOji3FUf
 liBvx+8paPsINMYZ/VUB1L6WnmTXChj/JmEtAPByo+1feef7GiPT9YsIHq+c/yt19BgimRwCw
 8pOo6A==
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

Hi Jens,

Am 19.01.24 um 22:26 schrieb Jens Maus:
> Hi,
>
>> Am 19.01.2024 um 17:53 schrieb Jens Maus <mail@jens-maus.de>:
>>
>>> Am 19.01.2024 um 17:29 schrieb Ivan T. Ivanov <iivanov@suse.de>:
>>>
>>>> So you say with your own u-boot.bin you see serial U-Boot output afte=
r that =E2=80=9ENOTICE: BL31: =E2=80=A6=E2=80=9C lines? On that special UA=
RT port on the rpi5 or on the UART on the GPIO header?
>>>>
>>> Yes :-) See attached log file.
>> Really strange that in your case U-Boot seems to come up nicely and out=
puts something on the debug UART. Here definitely not. And the only differ=
ence in the rpi boot loader log outputs I could spot between yours and min=
e is:
> Replying to myself after having analysed this a bit further this evening=
...
>
>> [=E2=80=A6]
>>
>> So lets see if after you updated to a more recent rpi eeprom U-boot is =
still able to boot=E2=80=A6
> I actually do have some good and bad news:
>
> 1. Good news: I got u-boot finally showing up with my RaspberryPi5 8GB b=
oth on the HDMI and on the serial debug UART like you reported.
>
> 2. Bad news: I actually got it working by downgrading the rpi-eeprom to =
the same 2023/10/30 (VERSION:30de0ba5) version like you have.
>
> So the issue I saw/reported seems to be somehow related/limited to newer=
 rpi-eeprom versions. Looking at my previous diff on the rpi bootloader lo=
g output differences, the potentially relevant piece might be the "M.2 PCI=
e HAT not detected.=E2=80=9C line that is only present in newer rpi-eeprom=
 version outputs.
>
> So hopefully you can reproduce that issue yourself when upgrading your r=
pi-eeprom version to newer or also the latest version from 2024/01/15 avai=
lable [1] and potentially find the actual piece that prevent your patchset=
 from working on newer eeprom versions.
thanks for your work, but i think you are wasting your time. The
rpi-eeprom release 2024/01/15 seems to be broken [1]

:-(

[1] - https://github.com/raspberrypi/rpi-eeprom/issues/523

>
> Best regards,
> jens
>
> [1] https://github.com/raspberrypi/rpi-eeprom/tree/master/firmware-2712/=
latest


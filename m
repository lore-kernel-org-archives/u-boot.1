Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 033AECD13D2
	for <u-boot@archiver.kernel.org>; Sat, 31 Aug 2024 13:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1019D88C5C;
	Sat, 31 Aug 2024 15:36:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="ndSYaeot";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 737E388D60; Sat, 31 Aug 2024 15:36:53 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5002F88A43
 for <u-boot@lists.denx.de>; Sat, 31 Aug 2024 15:36:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1725111399; x=1725716199; i=smoch@web.de;
 bh=VmBeoLI7H2LZ1xF5TQf37cpm1rIMc7Uuc2Im7S/7jqs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ndSYaeotmJm1xuBFK7R+9NU4ChWR3G1k1jQA/2LoRsE0XsFexp2xUcZ8nvaivZrj
 wT3ZJfLiCoO2SH3GEniEPTJcnQTU3JL58alwuijpBt3VDPhwdGIhXMBjDBZ//p4ZI
 SilM6ZhA6OP6JWOosI0e5dwkaVJYqCWkCoJppm++5l/lwhx6lwAwykHMF4nzgdiY4
 CG0NYbB1A2VPaC44ym0J2XimRtEUOFiIAfo5MFRXm0JWjYPdWzJVhWas+JMhIiuYw
 axV8GZzw2PixanBx55NMbXUYSfbpcDxi2h2vnGpRkPk5ZvS2daslg3KBhngnvLZ1R
 socZ9iNgpMHxLQLWpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.1.40] ([89.14.56.113]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MfKtN-1s8He93wFf-00jJn3; Sat, 31
 Aug 2024 15:36:39 +0200
Message-ID: <420b6d01-d081-4a6a-a9b7-219d8806099a@web.de>
Date: Sat, 31 Aug 2024 15:36:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] FUSB302 USB-C controller support
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Marek Vasut <marex@denx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Tim Harvey <tharvey@gateworks.com>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>
References: <20240830182330.49528-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Soeren Moch <smoch@web.de>
In-Reply-To: <20240830182330.49528-1-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g7RFQkkcLxQpO+Jlt4PyBkksJPKE5wJvYCUJX8otqKlsxovJouC
 UogX21vUaM8fM6fjJb7K7I4B3nmgkpIKBWCwgKocjPuLJzs3lEnoqmbQJP3oM5Jk+Ygm4XH
 bR1fAmfSjhip8YWIpVC8xItg9OfB/5OLmJNSxG/Bu+sThKkAZJGUY1ftF68Mymjc1rYKhVW
 9qqkJSS+cEgCnxTtyqWsg==
UI-OutboundReport: notjunk:1;M01:P0:azfOs1v/VmU=;xg4DilXy0oxBTzI99FAWjNpGWUS
 yzOp8yuaFzpW5VSltykElkg4JHVklITel2cE+zOm7Fvv0qrweHJwfb4TxKeO/b/hS3UzDRdxD
 dXks4vYprkKvWaeI5ijbXG6soOyfjtxPMu0o91kCJAzxTspqve7NZrPJYBfVdxosctnCY3bYU
 NZXOdaH2QZxjrP1hSrkc2dDiSmvlPLpe9HVOAXxFuLtcZTHTwFkuHf/GOGhCoYNREv/jE+ayV
 JJjOFzJDRqSBNxi/krAJ75mKxlkkaiYfQznxb65nEMKykiHqrcKJuVrAq16+3Wl+8n8R4VVNF
 vEmzlUYZJ4HB0l6aH0SbxsWE4f9y4vaMUkd057szKfx64S3nLGbM63a4i0Tus4CzltEGebDcU
 YCYVjKpBC2HvllzvO9hoprSg+86ikQOiH1h65ZCmN0HnL9g9bPXsuEUJwB8TqT2dOXHgL6rbr
 rcQZGowpszMvxYMJvW6+GJy9aF8yjPef4SkY8uhgK3uLfe8EbriWrn5p+wuOJVwYQbTRFKKtO
 9QqK7If20gZbdpvpgAnGLCYcXzeYalXtknPp/avp3LnLQzeTIAAcEWaJbaX3g4dxa3sjeB5tq
 CpfM3mZhhjma0wqcQfFcU0yLxkQguEN6s4VB/3hYxIkkkvJf3Sh71OvjrH7AOtTtzhmLcTUqI
 0CNIw4hNRLjxGRjYJDFeYX6Q+JjInr+lqSgXbwsOAT8H01HbNRXOYByS/AVT+rCR5Xe0xsV/2
 5yXze2S7XpUXcX+6HBQ4CiiDdzC+jGQB0tfG45b+GezUDjRZQF3mVqNKawP4VWVNOsKVr9uSc
 gwSJMwevc0orCjRULCRIpPKQ==
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

Hi Sebastian,

On 30.08.24 20:22, Sebastian Reichel wrote:
> Hi,
>
> On ROCK 5B power is usually supplied via it's USB-C port. This port has =
the
> data lines connected to RK3588, VBUS connected to the input regulator an=
d
> CC pins connected to FUSB302. FUSB302 is a USB-C controller, which can b=
e
> accessed via I2C from RK3588. The USB-C controller is needed to figure o=
ut
> the USB-C cable orientation, but also to do USB PD communication. Thus i=
t
> would be great to enable support for it in the operating system.
>
> But the USB-PD specification requires, that a device reacts to USB-PD me=
ssages
> send by the power-supply within around 5 seconds. If that does not happe=
n the
> power-supply assumes, that the device does not support USB-PD. If a devi=
ce
> later starts sending USB-PD messages it is considered an error, which is=
 solved
> by doing a hard reset. A USB-PD hard reset means, that all supply voltag=
es are
> removed for a short period of time. For boards, which are solely powered
> through their USB-C port, like the Radxa Rock 5B, this results in an mac=
hine
> reset. This is currently worked around by not describing the FUSB302 in =
the
> kernel DT, so nothing will ever speak USB-PD on the Rock 5B. This means
>
> 1. the USB-C port cannot be used at all
> 2. the board will be running via fallback supply, which provides limited
>     power capabilities
>
> In order to avoid the hard reset, this adds FUSB302 support to U-Boot, s=
o
> that we react to the power-supply's queries in time. The code, which is
> originally from the Linux kernel, consists of two parts:
>
> 1. the tcpm state machine, which implements the Type C port manager stat=
e
>     machine as described in the USB PD specification
> 2. the fusb302 driver, which knows about specific registers
>
> Especially the first part has been heavily modified compared to the
> kernel, which makes use of multiple delayed works and threads. For this
> I used a priorly ported version from Rockchip, removed their hacks and
> any states not necessary in U-Boot (e.g. audio accessory support).
>
> This version has been tested on Radxa Rock 5B using the open source TF-A
> (patches recently got merged into master branch) using the following pow=
er
> supplies:
>
>   * non PD capable (reports 5V 0A)
>   * RavPower 90W (ok)
>   * UGREEN 100W (ok)
>   * Anker 45W (ok)
>   * RavPower PB (hard resets in U-Boot, but succeeds at some point,
>     I still need to investigate)
>
> Changes since PATCHv3:
>   * Rebase to latest master (57949a99b7bd)
>   * Rework autoprobing; tcpm_post_bind tries to check if a probe is need=
ed
>     based on DT properties and then sets the DM_FLAG_PROBE_AFTER_BIND fl=
ag.
>     If this accidently increases boot time on some boards they are proba=
bly
>     missing a 'self-powered;' flag in their USB-C connector node.
>   * Rock 5B ft_board_setup(): check for CONFIG_TYPEC_FUSB302 instead of
>     CONFIG_MISC_INIT_R to reflect the above change
>   * Drop adding 'CONFIG_MISC_INIT_R' to rock5b-rk3588_defconfig because =
of
>     the reworked autoprobing
>   * Log an error message if tcpm_send_queued_message() exits early
>   * Add R-b for the rockchip specific changes from Kever Yang
>   * Increase the timeout in tcpm_pd_transmit(), which seems to be the is=
sue
>     S=C3=B6ren Moch ran into. I could not really reproduce it. Please te=
st if this
>     helps with your supply (and share the logs if it does not help). I n=
oticed
>     this version has issues with an old PD capable powerbank I own. I'm =
still
>     looking into that but wanted to share a new version so that the othe=
r
>     changes can get reviewed.
Unfortunately I see the same problem as in v3: boot loop when powering
the board from my notebook (ThinkPad X1 Nano running Ubuntu 24.04.1 LTS),
see boot log below.

Patch version v2 is still running totally fine in the exact same setup
(patch series on top of u-boot 2024.07, same board, same cabling).

Unfortunately I currently have no access to the miniPC (Zotac ZBOX CI620)
I used as additional test platform before.

The boot log is unfortunately not very helpful. If you provide an addition=
al
patch enabling more debug output, I'm happy to retest with that (v2
and/or v4).

Regards,
Soeren



Boot Log:

DDR 9fffbe1e78 cym 24/02/04-10:09:20,fwver: v1.16
LPDDR4X, 2112MHz
channel[0] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
channel[1] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
channel[2] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
channel[3] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
Manufacturer ID:0xff
CH0 RX Vref:26.7%, TX Vref:21.8%,0.0%
CH1 RX Vref:27.5%, TX Vref:19.8%,0.0%
CH2 RX Vref:28.5%, TX Vref:20.8%,0.0%
CH3 RX Vref:29.3%, TX Vref:20.8%,0.0%
change to F1: 528MHz
change to F2: 1068MHz
change to F3: 1560MHz
change to F0: 2112MHz
out

U-Boot SPL 2024.07-00006-g65a73892d9 (Aug 31 2024 - 13:45:46 +0200)
Trying to boot from MMC2
## Checking hash(es) for config config-1 ... OK
## Checking hash(es) for Image atf-1 ... sha256+ OK
## Checking hash(es) for Image u-boot ... sha256+ OK
## Checking hash(es) for Image fdt-1 ... sha256+ OK
## Checking hash(es) for Image atf-2 ... sha256+ OK
## Checking hash(es) for Image atf-3 ... sha256+ OK
INFO:=C2=A0=C2=A0=C2=A0 Preloader serial: 2
NOTICE:=C2=A0 BL31: v2.3():v2.3-682-g4ca8a8422:derrick.huang, fwver: v1.45
NOTICE:=C2=A0 BL31: Built : 10:11:21, Dec 27 2023
INFO:=C2=A0=C2=A0=C2=A0 spec: 0x1
INFO:=C2=A0=C2=A0=C2=A0 code: 0x88
INFO:=C2=A0=C2=A0=C2=A0 ext 32k is not valid
INFO:=C2=A0=C2=A0=C2=A0 ddr: stride-en 4CH
INFO:=C2=A0=C2=A0=C2=A0 GICv3 without legacy support detected.
INFO:=C2=A0=C2=A0=C2=A0 ARM GICv3 driver initialized in EL3
INFO:=C2=A0=C2=A0=C2=A0 valid_cpu_msk=3D0xff bcore0_rst =3D 0x0, bcore1_rs=
t =3D 0x0
INFO:=C2=A0=C2=A0=C2=A0 l3 cache partition cfg-0
INFO:=C2=A0=C2=A0=C2=A0 system boots from cpu-hwid-0
INFO:=C2=A0=C2=A0=C2=A0 disable memory repair
INFO:=C2=A0=C2=A0=C2=A0 idle_st=3D0x21fff, pd_st=3D0x11fff9, repair_st=3D0=
xfff70001
INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_params[0].freq_mhz=3D 2112MHz
INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_params[1].freq_mhz=3D 528MHz
INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_params[2].freq_mhz=3D 1068MHz
INFO:=C2=A0=C2=A0=C2=A0 dfs DDR fsp_params[3].freq_mhz=3D 1560MHz
INFO:=C2=A0=C2=A0=C2=A0 BL31: Initialising Exception Handling Framework
INFO:=C2=A0=C2=A0=C2=A0 BL31: Initializing runtime services
WARNING: No OPTEE provided by BL2 boot loader, Booting device without
OPTEE initialization. SMC`s destined for OPTEE will return SMC_UNK
ERROR:=C2=A0=C2=A0 Error initializing runtime service opteed_fast
INFO:=C2=A0=C2=A0=C2=A0 BL31: Preparing for EL3 exit to normal world
INFO:=C2=A0=C2=A0=C2=A0 Entry point address =3D 0xa00000
INFO:=C2=A0=C2=A0=C2=A0 SPSR =3D 0x3c9


U-Boot 2024.07-00006-g65a73892d9 (Aug 31 2024 - 13:45:46 +0200)

Model: Radxa ROCK 5 Model B
DRAM:=C2=A0 8 GiB
DDR 9fffbe1e78 cym 24/02/04-10:09:20,fwver: v1.16
LPDDR4X, 2112MHz
channel[0] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
channel[1] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
channel[2] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
channel[3] BW=3D16 Col=3D10 Bk=3D8 CS0 Row=3D17 CS=3D1 Die BW=3D16 Size=3D=
2048MB
Manufacturer ID:0xff
CH0 RX Vref:26.7%, TX Vref:21.8%,0.0%
CH1 RX Vref:27.5%, TX Vref:19.8%,0.0%
CH2 RX Vref:28.5%, TX Vref:20.8%,0.0%
CH3 RX Vref:30.1%, TX Vref:19.8%,0.0%
change to F1: 528MHz
change to F2: 1068MHz
change to F3: 1560MHz
change to F0: 2112MHz
out

U-Boot SPL 2024.07-00006-g65a73892d9 (Aug 31 2024 - 13:45:46 +0200)
Trying to boot from MMC2
...






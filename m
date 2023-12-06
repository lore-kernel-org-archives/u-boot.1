Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39B02C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 07:06:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C4B687032;
	Wed,  6 Dec 2023 08:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="eeTaRdS3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E432A87032; Wed,  6 Dec 2023 08:06:24 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0FE87015
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 08:06:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1701846380; x=1702451180; i=smoch@web.de;
 bh=kdVeGS5fEUjKRPc0ejh/Iu7SNeCwcZXh2XJ8HeAmzt8=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=eeTaRdS3Ts3j4jmwB3iyTaVfWWCJBgTUHINWh/QCfBL1ZNZm0XVry54DxGTpBnQ4
 kAL/ckDxuGF/PqjnPu00OMK0UIp2SewVaDmRoACi/Mdf0tkpIksZTA7H6oVYJuCzd
 c+T/acXFqs6+JTsMmoK349PbJTqISruFlNY/JEGsTU74jGeDF+ErSVJzy0fcvapgJ
 tbhGUBJmJpYQjhocEEcZp7htKKbOyiyPr4TV7iXMWXfb8fJ07UutYMvsAC6jz0QUE
 45oALZXPVpb7kBOSYKaE0S5j3nReAJ0S1+KcFiyAmYWbw07VlbJFedc/uxDALtCVZ
 vXJvCFWKPqzp9lfdgQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M604t-1r9ND62RiN-007TaW; Wed, 06
 Dec 2023 08:06:20 +0100
Message-ID: <5f54c9b0-921b-46c2-9e5c-eb657b4f1ef3@web.de>
Date: Wed, 6 Dec 2023 08:06:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATHv11 26/43] configs/tbs2910_defconfig inc limit
Content-Language: en-US
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org, goldsimon@gmx.de
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
 <20231127125726.3735-27-maxim.uvarov@linaro.org>
 <20231127131129.GD2513409@bill-the-cat>
 <c7022ef3-ad0c-4f89-ad47-a0f7df2a24c6@web.de>
 <CAD8XO3aVLzpqV=MDVO2mJBP=sLzSieXhrV8GUPYPpu76mRKjeQ@mail.gmail.com>
 <CAD8XO3Y4_=8wDQcFNJW1MT1yiyDmbQxP3UCRWWWPZzuJkZp88g@mail.gmail.com>
 <1402b942-9ce9-4bc3-9fac-0eb438b23e77@web.de>
 <CAD8XO3bYyfDVnVQdcqDji39Y=i1Q2jdG-SQ6KUWsBPo0umoZnQ@mail.gmail.com>
 <b47859ca-36d3-4eee-88fb-f7859e69ff2d@web.de>
 <CAD8XO3Zqt1SN6t4MWXozJ4R-FjQ1324Vn5=h6xCe13gwxb9qSA@mail.gmail.com>
From: Soeren Moch <smoch@web.de>
In-Reply-To: <CAD8XO3Zqt1SN6t4MWXozJ4R-FjQ1324Vn5=h6xCe13gwxb9qSA@mail.gmail.com>
X-Provags-ID: V03:K1:YNoKevQteu1w34q76uCG+wCJMspMwYCCMN/Ozbl04dfCdouYimJ
 nq+NWVMtEMgN752wl9TXb4zVPtz0cG0U00j8CV/r/cjn3pxK+lr1mqbXYxhNBpQG+b53Qxw
 S34OVVi7bkkP27cOkzRdl+XoJ6D8OnADFUFAQkM5nQ/ROPhfO4WBaS/EbOmeshS41uLm8kP
 3JRnVXewkefUEpCRWK0yA==
UI-OutboundReport: notjunk:1;M01:P0:LVZc9Q2SS/M=;jSAT+WynSmRhi88H0Tvrlhutl0Q
 MbadK2poChZiaHsg67bmYSMqz5uFnRjAmIFwkrX1v3C4SCldcDcWOpG1ZNvhr+zpy+GNgTd25
 7HZphpsRoDIK4ntVj2sdXLvaGUTDJsYo0Xq9at7HyAYb/GmJe+aXLy9p5MeJpCU0BK98UwUiw
 Wjyb0iq1lR3qp/tugRVO7qVj//kjXKtjffx14PaEVZnnE/7Bf+WLXS0Bo5JvFzeslyoq719IA
 E1ZdJlou/cBHI3gQGDIUUy0rlCtv9ZupSZHEm68vY1zB59KC4Z3+LjLoHRQ4OMu5E05gD27TN
 PzW0K5maexKthQwFwiUyrNNWCthZR1M8WKqPmML15TagWZ+9fl65scFSQccH9iRO5zJ72LKmv
 7OFqmz1StBZuu5KSRbebs8Fe4j2ytFHLX5+fgmZrvQJO0oOm+tSL8qRtVT1Ea54sk8dWva3Gn
 j4hDjWh8htJXbVwxrbobPVPCYXorGG1t4GpC5tu6Jp0RN3OXrPc9tbKQCeZ8QFlDpyJXzqrcA
 IsXM6p83lefQ3oXT+PkKigcOq7TQXVwPzklvtl2xvmnrNRJWTWfwtc/T0b12I+ph6YbVaNc5O
 TEW6WWPWQrTnK7ij4sW2VRfTASYUyM3DQEao6i9e2Gz0j6ADd8eYvSl+amgj2jJRguPcRiFTz
 gTaneFmCDwT1oXkawdqv/67USyQgJE5siMlaYRcR/YPwPvgXxU05OLiXGlr7wfuMnXwf0pjvb
 S4yrX2S2Qyb5k+hZBLEXc2ffK2V8MytHW1PVq8tOEdhMs1wuQ48NXpG5JpTgmKOdGuqkkXT1V
 UJpW3OiHZgB7PWMx0zmegVETT1kdlRTTB5sBmtX6t1VSrRE8IgYW9o6CTfNBT9Tycl4MffNko
 ACn6bTiL0H9vBjpd5DMAnyn/T4HC9KTCbTwj+dke67RAOKQ2yRmBi+wFEqjulAqPbsRn1u5eV
 JeTavBB5NZ6zufJHmin3pOCqTUA=
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

On 05.12.23 21:00, Maxim Uvarov wrote:
> On Wed, 6 Dec 2023 at 00:25, Soeren Moch <smoch@web.de> wrote:
>
>     On 05.12.23 17:25, Maxim Uvarov wrote:
>>     On Tue, 5 Dec 2023 at 21:49, Soeren Moch <smoch@web.de> wrote:
>>
>>         On 05.12.23 14:15, Maxim Uvarov wrote:
>>>         I think I solved the size issue on all the boards.
>>>
>>>         Key changes:
>>>         1. remove compilation of original ping.c and tftp.c (tftp
>>>         had also server code, so I will partially bring it back.)
>>         Interesting.
>>         @Tom: Is there other server code in u-boot, that is enabled
>>         by default (and can be used to reclaim code space)?
>>         Fur sure I do not need u-boot to act as server for tftp (maye
>>         nfs, others).
>>
>>
>>     Maybe I need to be more clear about this. reference to code from
>>     tftp.c and ping.c exist in net.c, test/image/spl_load_net.c,
>>     test.dm/dsa.c <http://test.dm/dsa.c>, test/dm/eth.c.
>>     And even if that code is not used (replaced with lwip calls to
>>     the same commands in my case) it adds additional size. Even
>>     enabled LTO does not see
>>     direct difference.
>     So 'server code' does not mean u-boot acting as network server,
>     you mean this code is referenced by something else? And things in
>     test do increase image size?
>
This was my question to understand possible options to save space.
>
>>
>>>         2. LTO=3Dy
>>>         3. CONFIG_LOGLEVEL=3D3 instead of 4.
>>>         4. CONFIG_CMD_DATE is not set
>>>         5. CONFIG_CMD_LICENSE is not set
>>>         6. CONFIG_CMD_PING (if 1-6 did not help).
>>>
>>>         And these changes were enough for CI tagrets to build.
>>>         I also tested that Raspberry PI 4B works fine (dhcp, ping).
>>>         Looking for other boards to test.
>>>
>>>         For example for this tbs2910 board changes are:
>>         Disabling CMD_DATE is unfortunate. This can help to debug RTC
>>         problems (already used it for this purpose).
>>         And, if we are that close to the size limit, than maybe we
>>         can get away for this series, but for sure will run into
>>         trouble for every other small change to u-boot core/driver code=
.
>>
>>         Regards,
>>         Soeren
>>
>>
>>     The problem is that for many targets the limit is 1MB.
>     For tbs2910 it is 383kBytes. And there was plenty of free space
>     when I introduced mainline u-boot support. But yes, space got
>     tighter over time.
>
>
> Hm,
> orig:
> -rw-r--r-- 1 uboot uboot 371K Dec =C2=A05 19:54 u-boot.bin
> lwip:
> -rw-r--r-- 1 uboot uboot 380K Dec =C2=A05 19:55 u-boot.bin
>
> Then if I just enable CMD_DATE:
> u-boot.imx exceeds file size limit:
> =C2=A0 limit: =C2=A00x5fc00 bytes
> =C2=A0 actual: 0x60c00 bytes
> =C2=A0 excess: 0x1000 bytes
> make: *** [Makefile:1240: u-boot.imx] Error 1
> make: *** Deleting file 'u-boot.imx'
> uboot@3eebd85985c8:~/uboot-size$ ls -lh u-boot.bin
> -rw-r--r-- 1 uboot uboot 382K Dec =C2=A05 19:58 u-boot.bin
>
> So limit for your board is:
> (gdb) p 0x5fc00/1024
> $1 =3D 383
>
> 383k. Where do you see the space?
Here I do not understand what you want to ask.

As I wrote earlier, yes, tbs2910 limit is 383k, for u-boot.imx, the
number you tried to change in this patch to 408k, but this change is not
possible.

Without your changes there is some space left (not as much as 2014 when
I introduced tbs2910 support in u-boot), but enough to make further
u-boot development with unavoidable small image size increases possible.
(size of v2024.01-rc4 u-boot.imx for tbs2910 is 375k).

Regards,
Soeren
>
> BR,
> Maxim.
>
>>     U-Boot in some minimal configuration is about 500kb. But U-boot
>>     with EFI, USB, Eth drivers, MMC, RTC, and all the commands is
>>     900+ kb and very close to 1MB. Most of the new features are
>>     enabled by default.
>     No. Tom does a very good job to ensure that there is no (not much)
>     additional space required for unrelated boards that do not need
>     new features.
>>     I.e. they do not exist in _defconfig and appear in the resulting
>>     .config automatically.=C2=A0 I would say that for some small target=
s
>>     things like EFI, Secure boot, TPM, Updates and many others are
>>     not needed. But if new features will appear by default very soon
>>     we will see limits.
>     New features will not be enabled for old space constrained boards.
>     In your series you did not offer to keep the old implementation
>     instead, this is different and the reason why we discuss image
>     size constraints.
>
>     Regards,
>     Soeren
>>
>>     BR,
>>     Maxim.
>>
>>>
>>>         --- a/configs/tbs2910_defconfig
>>>         +++ b/configs/tbs2910_defconfig
>>>         @@ -18,6 +18,7 @@ CONFIG_SYS_MEMTEST_END=3D0x2f400000
>>>         =C2=A0CONFIG_LTO=3Dy
>>>         =C2=A0CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
>>>         =C2=A0CONFIG_BOARD_SIZE_LIMIT=3D392192
>>>         +CONFIG_TIMESTAMP=3Dy (this was added by savedefconfig)
>>>         =C2=A0# CONFIG_BOOTSTD is not set
>>>         =C2=A0CONFIG_SUPPORT_RAW_INITRD=3Dy
>>>         =C2=A0CONFIG_BOOTDELAY=3D3
>>>         @@ -26,6 +27,7 @@ CONFIG_BOOTCOMMAND=3D"mmc rescan; if run
>>>         bootcmd_up1; then run bootcmd_up2; else r
>>>         =C2=A0CONFIG_USE_PREBOOT=3Dy
>>>         =C2=A0CONFIG_PREBOOT=3D"echo PCI:; pci enum; pci 1; usb start"
>>>         =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"imx6q-tbs2910.dtb"
>>>         +CONFIG_LOGLEVEL=3D3
>>>         =C2=A0CONFIG_PRE_CONSOLE_BUFFER=3Dy
>>>         =C2=A0CONFIG_HUSH_PARSER=3Dy
>>>         =C2=A0CONFIG_SYS_PROMPT=3D"Matrix U-Boot> "
>>>         @@ -52,7 +54,7 @@ CONFIG_CMD_DHCP=3Dy
>>>         =C2=A0CONFIG_CMD_MII=3Dy
>>>         =C2=A0CONFIG_CMD_PING=3Dy
>>>         =C2=A0CONFIG_CMD_CACHE=3Dy
>>>         -CONFIG_CMD_TIME=3Dy
>>>         +# CONFIG_CMD_DATE is not set
>>>         =C2=A0CONFIG_CMD_SYSBOOT=3Dy
>>>         =C2=A0# CONFIG_CMD_VIDCONSOLE is not set
>>>         =C2=A0CONFIG_CMD_EXT2=3Dy
>>>
>>>         BR,
>>>         Maxim.
>>>
>>>
>>>         On Tue, 28 Nov 2023 at 13:09, Maxim Uvarov
>>>         <maxim.uvarov@linaro.org> wrote:
>>>
>>>
>>>
>>>             On Tue, 28 Nov 2023 at 03:20, Soeren Moch <smoch@web.de>
>>>             wrote:
>>>
>>>                 On 27.11.23 14:11, Tom Rini wrote:
>>>                 > On Mon, Nov 27, 2023 at 06:57:09PM +0600, Maxim
>>>                 Uvarov wrote:
>>>                 >
>>>                 >> Increase allowed binary size to fit lwip code.
>>>                 >>
>>>                 >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.or=
g>
>>>                 >> ---
>>>                 >>=C2=A0 =C2=A0configs/tbs2910_defconfig | 2 +-
>>>                 >>=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 delet=
ion(-)
>>>                 >>
>>>                 >> diff --git a/configs/tbs2910_defconfig
>>>                 b/configs/tbs2910_defconfig
>>>                 >> index 8fbe84f1d2..ce40efa9ab 100644
>>>                 >> --- a/configs/tbs2910_defconfig
>>>                 >> +++ b/configs/tbs2910_defconfig
>>>                 >> @@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=3D0x1000=
0000
>>>                 >> =C2=A0CONFIG_SYS_MEMTEST_END=3D0x2f400000
>>>                 >>=C2=A0 =C2=A0CONFIG_LTO=3Dy
>>>                 >> =C2=A0CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
>>>                 >> -CONFIG_BOARD_SIZE_LIMIT=3D392192
>>>                 >> +CONFIG_BOARD_SIZE_LIMIT=3D417792
>>>                 >>=C2=A0 =C2=A0# CONFIG_BOOTSTD is not set
>>>                 >> =C2=A0CONFIG_SUPPORT_RAW_INITRD=3Dy
>>>                 >>=C2=A0 =C2=A0CONFIG_BOOTDELAY=3D3
>>>                 > This is another case where the binary size is a
>>>                 fairly hard limit. You
>>>                 > forgot to cc the board maintainer here (and I
>>>                 assume the rest of the
>>>                 > series too) for these config changes.
>>>                 ThanksTom for sending a notification to me.
>>>
>>>                 Yes, the CONFIG_BOARD_SIZE_LIMIT is a hard limit and
>>>                 this patch in its
>>>                 current form will break tbs2910 support and even
>>>                 brick the board for
>>>                 some configurations. So NAK for this patch.
>>>                 > I think on this platform it's not
>>>                 > impossible (like it is on am335x where I just
>>>                 replied) but really
>>>                 > difficult. I'll let Soeren comment on if switching
>>>                 the network stack to
>>>                 > lwip is the kind of feature enhancement that
>>>                 warrants the pain of
>>>                 > dealing with the size change here or not.
>>>                 Network boot is no important feature for this board
>>>                 and not used in
>>>                 the default boot configuration. But network support
>>>                 always was part
>>>                 of the config, may be used by some users, and is at
>>>                 least required
>>>                 to communicate the ethernet address to linux.
>>>
>>>                 So I'm not interested in a new network stack for
>>>                 this board, but
>>>                 also cannot disable network support completely. This
>>>                 seems to be a
>>>                 problem for this patch series, since networking
>>>                 support implies LWIP
>>>                 now.
>>>
>>>
>>>             Thanks Soeren for the explanation. Then yes, something
>>>             more advanced is needed
>>>             to be done here.
>>>
>>>                 The question for me is, why is the new network stack
>>>                 consuming so
>>>                 much space, with only a few enabled commands? Is the
>>>                 whole library
>>>                 linked in with some unused features (the cover
>>>                 letter mentions much
>>>                 more than what seems to be used in the converted
>>>                 commands). Or is
>>>                 the old network stack linked in in parallel to the
>>>                 new one? Can
>>>                 we save space here?
>>>
>>>
>>>             Yes, the old code is still there. I decided to not touch
>>>             it for the first integration (arp.o, bootp.o, ping.o and
>>>             mostly all from net/Makefile). Those files also have
>>>             reference code in net/net.c. Not compiling
>>>             and not linking this code will save some space, but It's
>>>             larger than the current version.
>>>             Like for EVM SPL code with usb+net+ext4 and etc have
>>>             very minimal space for network stack.
>>>             I will take a look at this more closely...
>>>
>>>
>>>                 NFS support in the old networking code is quite big,
>>>                 enabled by default,
>>>                 and probably still there in parallel to this new
>>>                 lwip library. If there
>>>                 is really no other option to save space, and lwip in
>>>                 general is agreed
>>>                 to be the way forward for U-Boot, and only tbs2910
>>>                 is blocking that,
>>>                 then from my point of view disabling NFS for tbs2910
>>>                 could be a way
>>>                 to stay within the size limit.
>>>
>>>             ok. I think that by default we need something very
>>>             minimal (dhcp, tftp),=C2=A0 probably ping is even not need=
ed.
>>>
>>>                 Regards,
>>>                 Soeren
>>>
>>
>

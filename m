Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B43C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 18:25:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A538C86DD1;
	Tue,  5 Dec 2023 19:25:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=web.de header.i=smoch@web.de header.b="HBsa1J6q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431D486E82; Tue,  5 Dec 2023 19:25:22 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B401286538
 for <u-boot@lists.denx.de>; Tue,  5 Dec 2023 19:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=smoch@web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1701800717; x=1702405517; i=smoch@web.de;
 bh=kWlRX08TQgrk+9BbNGcEnr3C8ipSctYzqUlQICJYwVc=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=HBsa1J6qHTY9F49AqUoUBRUzzUKceQPl5csot7mtidQ+DnW6sYHIVbnSuqxsF5yV
 ezJt2w08JaU5IGGBdQyuuTv1ixumqWAFyovhs4UQnpfJ+53SInb3RToFt1lMrLXBy
 W8fhsFM2fifkYzVK9fXKmZ/mShIoaMJKQembWvMu2keRzg/qiC2bTKZWdyTURtaJX
 i3bLvghOZIluDAFKHpQRZY9p6Ojl5B5x59nR5gkWJ2x4GmWwDL9FtG3vYYWQYncsW
 TFhXL7g874Wc2bECeSNOt37SiIux3us9+bZtdt591PNCYkoRBiMZnQMuf/Zi/XwOP
 s/qT4mjk24RDGq/APA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [10.9.8.2] ([93.241.254.39]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N6sG3-1rJhVi0b9z-017ugs; Tue, 05
 Dec 2023 19:25:17 +0100
Message-ID: <b47859ca-36d3-4eee-88fb-f7859e69ff2d@web.de>
Date: Tue, 5 Dec 2023 19:25:15 +0100
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
From: Soeren Moch <smoch@web.de>
In-Reply-To: <CAD8XO3bYyfDVnVQdcqDji39Y=i1Q2jdG-SQ6KUWsBPo0umoZnQ@mail.gmail.com>
X-Provags-ID: V03:K1:fcobb7fuBMj6TWO7OiIkwZWwlw2SLp5xv1XwsI4GQjdKpXrhgPK
 AfuYMYx4fX/wcxHqWuGaYMCmJP+sPJjnU7AIfZG9j28IDKdSyqKTUN3dFGZUB97Fs6GDp8Y
 aC7gQG6jLdR3EZ/aOTL30jtBes5gePo4Y4B7UJNkLP2qH67GSGExCvJyojXFfYxKhlApxpB
 WTzt3s6TB3MxC8RzikMag==
UI-OutboundReport: notjunk:1;M01:P0:Fz7FRqv2++8=;7wQzddkj9Urxll0XxkOL5Zfe1qm
 /TEPYzvvey+lF/yXUiDNzllW3BoTHWHK3aE+kCNs7MqbfxxlwwtDcJb8kGeTJZcYDefqybFDO
 QSfhofHa4wRKOqjWqzOFerzfdB3C4Cs/vmntSvSYptSzj7c2rA1ShiMYE0iAEc9F8DzgQ8eB1
 P3rP1xs9t6RdeJcgW/Adk7CWZxWq85e6C92Sd7TSKnELU/S3BoGU7sD9wnnr37kr5oo5YmgBp
 cRaVJ2h8hbQSXerdgVaNbT9+x2GRP6lxo16Lr5EW0HYJbqsYWO5DVhmF8KJkrC/n8GJmo7Mn0
 BV8XEwbaFlGlWqlbiHAEHEtkJ5FF0Wy9EP+zTL274ufhiPbFcipoYQNywA/Ef2mzej9DVVeeH
 3xconioR0QdUXWS1DHIIoGBGtRSa1V461FTfBcz+735hYqh1LxW/Ah27H5k5HhJ3uEiOH0rZD
 pBZcPkDdaQulEaBzgR0kVxPZcQDGuDEcMiZ6R6XNekwmYqGqVHAg8BaoWnXTDbJTLMfGxHBjx
 GenKQF5tCSRbQ4Hg1x4SlvCfDPWG69ugpJpJ7Mo++0koFYMlZF5AAkplsIb2sW00ZQ+TInvMg
 lflDgZ8jHxkUYa+VVMTng+2R9IluuuCtC0MzIfv0GqbCpjfouiAR97Wtu1g8Ig2c18QcZIQ2C
 AXeWyD1vLGtSp3jDQT+tEihfZod6LZXXEl7Vc74ZaQkQ0gNC6ct4vDI444akMtPct2LBFNhRv
 3ARHiDyUDhDdB1wHEjWXQ+9TS3Q7Wff7MSWXZ2rK6lCSL705iGXdVy4doVmtY8CU/87oa1ar0
 Cz0w+MzFj/D6N3PoI9dUHKZYPweJ6F734KoCFlj4PqHaDjcU+CwSMXhFmWBREcAFHaNhyK7aY
 cqueSjtAy7pRQP+8U6xZlawpRH6lRAXRuRC34PyRUEf8BRwy3Jtz2tZdEcahe0dHTvPNC8giP
 aqKTGgC5EObMZjLDYp76u80OR0Y=
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



On 05.12.23 17:25, Maxim Uvarov wrote:
>
>
> On Tue, 5 Dec 2023 at 21:49, Soeren Moch <smoch@web.de> wrote:
>
>     On 05.12.23 14:15, Maxim Uvarov wrote:
>>     I think I solved the size issue on all the boards.
>>
>>     Key changes:
>>     1. remove compilation of original ping.c and tftp.c (tftp had
>>     also server code, so I will partially bring it back.)
>     Interesting.
>     @Tom: Is there other server code in u-boot, that is enabled by
>     default (and can be used to reclaim code space)?
>     Fur sure I do not need u-boot to act as server for tftp (maye nfs,
>     others).
>
>
> Maybe I need to be more clear about this. reference to code from
> tftp.c and ping.c exist in net.c, test/image/spl_load_net.c,
> test.dm/dsa.c <http://test.dm/dsa.c>, test/dm/eth.c.
> And even if that code is not used (replaced with lwip calls to the
> same commands in my case) it adds additional size. Even enabled LTO
> does not see
> direct difference.
So 'server code' does not mean u-boot acting as network server, you mean
this code is referenced by something else? And things in test do
increase image size?
>
>>     2. LTO=3Dy
>>     3. CONFIG_LOGLEVEL=3D3 instead of 4.
>>     4. CONFIG_CMD_DATE is not set
>>     5. CONFIG_CMD_LICENSE is not set
>>     6. CONFIG_CMD_PING (if 1-6 did not help).
>>
>>     And these changes were enough for CI tagrets to build.
>>     I also tested that Raspberry PI 4B works fine (dhcp, ping).
>>     Looking for other boards to test.
>>
>>     For example for this tbs2910 board changes are:
>     Disabling CMD_DATE is unfortunate. This can help to debug RTC
>     problems (already used it for this purpose).
>     And, if we are that close to the size limit, than maybe we can get
>     away for this series, but for sure will run into trouble for every
>     other small change to u-boot core/driver code.
>
>     Regards,
>     Soeren
>
>
> The problem is that for many targets the limit is 1MB.
For tbs2910 it is 383kBytes. And there was plenty of free space when I
introduced mainline u-boot support. But yes, space got tighter over time.
> U-Boot in some minimal configuration is about 500kb. But U-boot with
> EFI, USB, Eth drivers,=C2=A0 MMC, RTC, and all the commands is 900+ kb a=
nd
> very close to 1MB. Most of the new features are enabled by default.
No. Tom does a very good job to ensure that there is no (not much)
additional space required for unrelated boards that do not need new
features.
> I.e. they do not exist in _defconfig and appear in the resulting
> .config automatically.=C2=A0 I would say that for some small targets thi=
ngs
> like EFI, Secure boot, TPM, Updates and many others are not needed.
> But if new features will appear by default very soon we will see limits.
New features will not be enabled for old space constrained boards. In
your series you did not offer to keep the old implementation instead,
this is different and the reason why we discuss image size constraints.

Regards,
Soeren
>
> BR,
> Maxim.
>
>>
>>     --- a/configs/tbs2910_defconfig
>>     +++ b/configs/tbs2910_defconfig
>>     @@ -18,6 +18,7 @@ CONFIG_SYS_MEMTEST_END=3D0x2f400000
>>     =C2=A0CONFIG_LTO=3Dy
>>     =C2=A0CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
>>     =C2=A0CONFIG_BOARD_SIZE_LIMIT=3D392192
>>     +CONFIG_TIMESTAMP=3Dy (this was added by savedefconfig)
>>     =C2=A0# CONFIG_BOOTSTD is not set
>>     =C2=A0CONFIG_SUPPORT_RAW_INITRD=3Dy
>>     =C2=A0CONFIG_BOOTDELAY=3D3
>>     @@ -26,6 +27,7 @@ CONFIG_BOOTCOMMAND=3D"mmc rescan; if run
>>     bootcmd_up1; then run bootcmd_up2; else r
>>     =C2=A0CONFIG_USE_PREBOOT=3Dy
>>     =C2=A0CONFIG_PREBOOT=3D"echo PCI:; pci enum; pci 1; usb start"
>>     =C2=A0CONFIG_DEFAULT_FDT_FILE=3D"imx6q-tbs2910.dtb"
>>     +CONFIG_LOGLEVEL=3D3
>>     =C2=A0CONFIG_PRE_CONSOLE_BUFFER=3Dy
>>     =C2=A0CONFIG_HUSH_PARSER=3Dy
>>     =C2=A0CONFIG_SYS_PROMPT=3D"Matrix U-Boot> "
>>     @@ -52,7 +54,7 @@ CONFIG_CMD_DHCP=3Dy
>>     =C2=A0CONFIG_CMD_MII=3Dy
>>     =C2=A0CONFIG_CMD_PING=3Dy
>>     =C2=A0CONFIG_CMD_CACHE=3Dy
>>     -CONFIG_CMD_TIME=3Dy
>>     +# CONFIG_CMD_DATE is not set
>>     =C2=A0CONFIG_CMD_SYSBOOT=3Dy
>>     =C2=A0# CONFIG_CMD_VIDCONSOLE is not set
>>     =C2=A0CONFIG_CMD_EXT2=3Dy
>>
>>     BR,
>>     Maxim.
>>
>>
>>     On Tue, 28 Nov 2023 at 13:09, Maxim Uvarov
>>     <maxim.uvarov@linaro.org> wrote:
>>
>>
>>
>>         On Tue, 28 Nov 2023 at 03:20, Soeren Moch <smoch@web.de> wrote:
>>
>>             On 27.11.23 14:11, Tom Rini wrote:
>>             > On Mon, Nov 27, 2023 at 06:57:09PM +0600, Maxim Uvarov
>>             wrote:
>>             >
>>             >> Increase allowed binary size to fit lwip code.
>>             >>
>>             >> Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>>             >> ---
>>             >>=C2=A0 =C2=A0configs/tbs2910_defconfig | 2 +-
>>             >>=C2=A0 =C2=A01 file changed, 1 insertion(+), 1 deletion(-=
)
>>             >>
>>             >> diff --git a/configs/tbs2910_defconfig
>>             b/configs/tbs2910_defconfig
>>             >> index 8fbe84f1d2..ce40efa9ab 100644
>>             >> --- a/configs/tbs2910_defconfig
>>             >> +++ b/configs/tbs2910_defconfig
>>             >> @@ -17,7 +17,7 @@ CONFIG_SYS_MEMTEST_START=3D0x10000000
>>             >>=C2=A0 =C2=A0CONFIG_SYS_MEMTEST_END=3D0x2f400000
>>             >>=C2=A0 =C2=A0CONFIG_LTO=3Dy
>>             >>=C2=A0 =C2=A0CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
>>             >> -CONFIG_BOARD_SIZE_LIMIT=3D392192
>>             >> +CONFIG_BOARD_SIZE_LIMIT=3D417792
>>             >>=C2=A0 =C2=A0# CONFIG_BOOTSTD is not set
>>             >>=C2=A0 =C2=A0CONFIG_SUPPORT_RAW_INITRD=3Dy
>>             >>=C2=A0 =C2=A0CONFIG_BOOTDELAY=3D3
>>             > This is another case where the binary size is a fairly
>>             hard limit. You
>>             > forgot to cc the board maintainer here (and I assume
>>             the rest of the
>>             > series too) for these config changes.
>>             ThanksTom for sending a notification to me.
>>
>>             Yes, the CONFIG_BOARD_SIZE_LIMIT is a hard limit and this
>>             patch in its
>>             current form will break tbs2910 support and even brick
>>             the board for
>>             some configurations. So NAK for this patch.
>>             > I think on this platform it's not
>>             > impossible (like it is on am335x where I just replied)
>>             but really
>>             > difficult. I'll let Soeren comment on if switching the
>>             network stack to
>>             > lwip is the kind of feature enhancement that warrants
>>             the pain of
>>             > dealing with the size change here or not.
>>             Network boot is no important feature for this board and
>>             not used in
>>             the default boot configuration. But network support
>>             always was part
>>             of the config, may be used by some users, and is at least
>>             required
>>             to communicate the ethernet address to linux.
>>
>>             So I'm not interested in a new network stack for this
>>             board, but
>>             also cannot disable network support completely. This
>>             seems to be a
>>             problem for this patch series, since networking support
>>             implies LWIP
>>             now.
>>
>>
>>         Thanks Soeren for the explanation. Then yes, something more
>>         advanced is needed
>>         to be done here.
>>
>>             The question for me is, why is the new network stack
>>             consuming so
>>             much space, with only a few enabled commands? Is the
>>             whole library
>>             linked in with some unused features (the cover letter
>>             mentions much
>>             more than what seems to be used in the converted
>>             commands). Or is
>>             the old network stack linked in in parallel to the new
>>             one? Can
>>             we save space here?
>>
>>
>>         Yes, the old code is still there. I decided to not touch it
>>         for the first integration (arp.o, bootp.o, ping.o and
>>         mostly all from net/Makefile).=C2=A0 Those files also have
>>         reference code in net/net.c. Not compiling
>>         and not linking this code will save some space, but It's
>>         larger than the current version.
>>         Like for EVM SPL code with usb+net+ext4 and etc have very
>>         minimal space for network stack.
>>         I will take a look at this more closely...
>>
>>
>>             NFS support in the old networking code is quite big,
>>             enabled by default,
>>             and probably still there in parallel to this new lwip
>>             library. If there
>>             is really no other option to save space, and lwip in
>>             general is agreed
>>             to be the way forward for U-Boot, and only tbs2910 is
>>             blocking that,
>>             then from my point of view disabling NFS for tbs2910
>>             could be a way
>>             to stay within the size limit.
>>
>>         ok. I think that by default we need something very minimal
>>         (dhcp, tftp),=C2=A0 probably ping is even not needed.
>>
>>             Regards,
>>             Soeren
>>
>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33DCFC36017
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 06:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BEF8144A;
	Mon, 31 Mar 2025 08:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eDH8DaLd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 359CA8171B; Mon, 31 Mar 2025 08:11:22 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0271812BC
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 08:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so62914f8f.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 23:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743401479; x=1744006279; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FEq+rqYxSTn2qZX4PVEEhjOlg6lB8lL4H5ofcbrk7Uc=;
 b=eDH8DaLdYQH2+/8nfSd+XrGFlLBx8vU5lqWEPSK9NliOYrmR6i3QtMVFV/VZd4OauK
 x1LXAEs7DS2uBP+w/ZwZRnQ1koeVRczWhkLp8KjpX3nZmnyRGEzf8zhGFVYvAesuK+XQ
 ZpGVxeLvh6Z1vgZ9tICl2FkU7ohwlzW/XPHkMaPu1MhMHEAw00voBzOGwlbM84cN+irM
 gnMHasUO4fraDVzA/z4MtNYjmHYl+OxoVjq1n3nQxV8XdZDd3b4J3qqbztWQKc2zVFYT
 /EtCh9u5Yc/STTPcsjFOtX8MMQ3fkkvTrNSRt6IGiLRqLgDkP1rEgQDKw5PZki0AYF8B
 VAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743401479; x=1744006279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FEq+rqYxSTn2qZX4PVEEhjOlg6lB8lL4H5ofcbrk7Uc=;
 b=UBaofc+LxM8uKemx7rJaCYOLylnUVuteP0cVGsWLQvO56T6XTF0Xwed/lVwDZJcDoL
 Z175fgHjlu4t7G45CyDoSlhAJeceq1bJLlNyt+965x2tCf50ujmsgN+9FzAgFiWzLy91
 7L94tbaHSwVHc1hZrTHX759YBL7yyFselBRhUTLsavzufliDJ5l9LcoftDE5a0gnTXzu
 RLCZkj5NNybeLbZ25Kxzw7XF1cAr9X1oy581c4XoWnJZtwKpFVPrP7RBLIS8DKcHt0r6
 6qcjuMRiLRlfCfI5L8tvQ4j6JntVs2zo5JQv3S4J9F7VWPTO4778M1v7s8nDdLNt0Mh2
 ZSJQ==
X-Gm-Message-State: AOJu0YzTjSwIeMzHolKo52MKtrDGUBzVR42HXL5TwKlS9m55lXptNSki
 wUd21coBB6AiMgagtMjmv+rRjUHe3G5Myy1Rgkr6jF9LkCzPthFGv95rYqNvCCZr+Wga9IADxBU
 uh3D26NNU0F0G123SP80s5HrApkiAe8UH
X-Gm-Gg: ASbGncuNFCF/sSuoVUIcid+aYDGZQOjRirU/CQk2dfeiNKyKfX9UJVr1vSTLGl3DY7o
 i45n8S2wsetPWYXLgBMtDKangTDy84tcbxbyRn0eLcN5s5228v/qD9ed7p4w2wnkR4Wjipgc5nj
 0yWtjW06n0XBapWxSY3rWF1RTfqv0=
X-Google-Smtp-Source: AGHT+IEAo/SdHn0d48X/YvO7IoggeeZxwpw027be+lkoxx1mXX2I84VSkkvphFt5J1E0dq7Ay0cax6s6T3n3hIdPBvw=
X-Received: by 2002:a05:6000:210d:b0:39c:1257:feba with SMTP id
 ffacd0b85a97d-39c1257fef3mr3721014f8f.58.1743401479061; Sun, 30 Mar 2025
 23:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20250318083103.63250-1-arturkow2000@gmail.com>
 <CAPVz0n3JF78RQYbckMcwN6JZC+adUG+oHNzof7Wkxd+EqeBkJA@mail.gmail.com>
 <af1c79f6-cfd1-45d2-8382-f68ad84276ea@gmail.com>
 <CAPVz0n3zveefuPCY8nvcqyeQ_NqZ=woq0ZqLja2AtfBLTVC-3w@mail.gmail.com>
 <b8601ae3-479f-46fc-aa55-304e44026442@gmail.com>
In-Reply-To: <b8601ae3-479f-46fc-aa55-304e44026442@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 31 Mar 2025 09:11:07 +0300
X-Gm-Features: AQ5f1Jo9wgGl0sx18dCyQ-O8M9SFQ1UBZYIkg1CHn1iRqvCHsJw-9lzNovyR8uw
Message-ID: <CAPVz0n0XMBMSkgr_SMiyUh6CoQDXZyuK2C+scP+pg_c9f_Y46Q@mail.gmail.com>
Subject: Re: [PATCH 0/4] Support UART over MicroSD slot on Transformer T20
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: u-boot@lists.denx.de, Francesco Dolcini <francesco.dolcini@toradex.com>, 
 =?UTF-8?Q?Jonas_Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stephen Warren <swarren@nvidia.com>, 
 Thierry Reding <treding@nvidia.com>, Tom Rini <trini@konsulko.com>,
 Tom Warren <twarren@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=D0=BD=D0=B4, 30 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:30 Artu=
r Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> W dniu 25.03.2025 o 08:14, Svyatoslav Ryhel pisze:
>
> =D0=BF=D0=BD, 24 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 22:01 Ar=
tur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hello
>
> Thanks for quick response. I know UARTD is the dedicated UART for
> debugging on TF101, but exposing UART over microSD
> is a handy trick useful for development. As I'm doing development on
>
> It is a handy trick indeed, but it is still just a trick and not smth
> that fits mainline. Maximum I can propose is picking funcmux change
> along with uart over sd section in transformer t20 documentation.
>
> this tablet (bringing U-Boot's UEFI support and latest
> Linux), and also still using the device on old OS I'd like to avoid
> disassembling and reassembling it over and over again.
>
> I am not sure what are you doing but TF101 has full support of U-Boot
> as primary bootloader along with full mainline support till 6.14
> including. It uses extlinux boot method and needs no intermediates or
> chainloading.
>
> If you wish to use U-Boot for tethered booting that is perfectly fine as =
well.
>
> Booting with UEFI didn't work, I have solved that problem locally by forc=
ing LMB allocator
> to not allocate at 0x0, any platform where RAM starts at 0x0 could be aff=
ected by it. Soon I
> will send patches. I want to use UEFI so that I can take advantage system=
d-boot features such
> as one-time boot for system updates, some other software I plan to use al=
so depends on UEFI.
> Also, with extlinux I can't use verified boot, but, eventually I plan to =
program PKC and have full
> secure boot with hardware RoT.
>
> When bringing UEFI support I also made some changes so that U-Boot works =
with
> CONFIG_OF_UPSTREAM, I also plan to upstream the patches soon.
>
> Linux lacks GPS support and possibly camera, also sorry for my mistake, I=
 meant a complete Linux
> distro rather than the kernel only, which is lacking GPU acceleration. Al=
so, when running preemptible
> kernel I can see multiple "scheduling while atomic" errors and random sys=
tem freezes under load.

PostmarketOS on Tegra group in Tg/Matrix. There you can find
assist/help regards there U-Boot unrelated stuff.

>
> Others too may find the feature useful e. g. to avoid having to solder
> which requires specialized equipment, skills and
> is potentially dangerous for the board. Also, there already seems to be
> support for that on Sunxi platforms through
> CONFIG_UART0_PORT_F.
>
> Apart from pinmux changes, would it be acceptable to include an option
> to allow switching UARTA mux to
> SDB/SDD (currently this has to be selected from board's Kconfig file).
> Doing so would allow to enable UART
> over microSD without patching U-Boot's source without changing any
> existing configuration. Then I would
> keep DTS overlays and config changes local.
>
> I am fine with any changes which may simplify debugging for you as
> long as they do not invade into completed device configuration without
> a valid reason. Device must expose a dedicated UART for debug, not a
> mux which breaks some device features just because you do not want to
> contain them locally.
>
> For example, patches which add UART-E support along with funcmux
> change which exposes uart-e over usd were accepted, but patch similar
> to yours which would reconfigure usd to uart for surface rt or p880
> would be rejected.
>
> I've sent v2, which besides few other fixes, adds dedicated Kconfig optio=
n for enabling UART. If disabled, the config is the same.
>
> Also, today, after running U-Boot with debug enabled, I discovered some
> failed assertions in pinmux code probably
> caused by my changes, I will get that fixed before sending v2.
>
> Turns out it was something else. I've sent a patch to fix that:
>
> https://patchwork.ozlabs.org/project/uboot/patch/20250330211153.RFC.1.Ieb=
f436d41ff5f52c0b11aaf9e8f98d6a2d4d56bc@changeid/
>
> Best regards
> Artur Kowalski
>
> W dniu 18.03.2025 o 09:54, Svyatoslav Ryhel pisze:
>
> =D0=B2=D1=82, 18 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:31 Ar=
tur Kowalski <arturkow2000@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> The first patch in the series brings general pinmux support for exposing
> UART over SDB/SDD pins on T20. The following patches bring support
> Transformer T20 allowing to enable UART over uSD by setting
>
> CONFIG_TEGRA_ENABLE_UARTA=3Dy
> CONFIG_DEVICE_TREE_INCLUDES=3D"tegra20-asus-transformer-uart-usd.dtsi"
>
> Similarily, support for UART over uSD could be brought to Ventana which
> has uSD on the same pins as TF101, and other Ventana-based boards.
>
> Hey there, thank you for looking into U-Boot for Tegra. If something I
> will say hurts or offends you, I am sorry it was not intentional.
>
> Anyway, apart funcmux changes, all other changes you propose are
> redundant. Asus dedicated uart for logging and console is UARTD any
> other uart configuration must not be added since it will disrupt
> existing configuration. If you need uart and cannot resolve an issue
> without it you can always solder to uart-d or locally mux sd to uart
> console fix your issue and remove it. Uart is not intended way to
> interact with Asus TF101 and doesn't need to be exposed, panel and
> fastboot console are and can be used to resolve most of issues.
>
> Best regards,
> Svyatoslav R.
>
> Artur Kowalski (4):
>    tegra: add funcmux for exposing UART over uSD slot on Tegra 20
>    tegra: respect CONFIG_TEGRA_ENABLE_UART* options on Transformer T20
>    ARM: tegra: expose UART-A over uSD on Transformer T20
>    board: asus: transformer: add DTSI file for enabling UART over uSD
>      slot
>
>   .../tegra20-asus-transformer-uart-usd.dtsi    | 31 +++++++++++++++++++
>   arch/arm/include/asm/arch-tegra20/funcmux.h   |  1 +
>   arch/arm/mach-tegra/board.c                   |  4 ++-
>   arch/arm/mach-tegra/tegra20/Kconfig           |  4 +++
>   drivers/pinctrl/tegra/funcmux-tegra20.c       |  9 +++++-
>   include/configs/transformer-t20.h             | 10 ++++++
>   6 files changed, 57 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/dts/tegra20-asus-transformer-uart-usd.dtsi
>
> --
> 2.48.1
>

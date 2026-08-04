Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF16BC55822
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 13:11:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99F3A80CF0;
	Tue,  4 Aug 2026 13:11:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5nvY-_VKyFff; Tue,  4 Aug 2026 13:11:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6DFDC80CE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785849082;
	bh=VbXtC2U8j1Y87D/oKM39XpIZWij7pGT8z79m8SGSeYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=q8/JLQsU+Q22SjkGKI2uY2fRKwTckOskTl/HMWgXBFobX033nsdI8BARkwo41P5n9
	 Mk4bpG/6jlDRWRGxYZXlygSXh+eV3ln5OHpdWlUX9cNqtxM7belUD2pnRLleByayn0
	 x+tRpdm4/1jh1d6FfTEddoPeQfFoyOiJzqGHU5oMTMIVo0waxp6F0s2iE7oLrzXLMY
	 geA+XT7vy31U0wJ2lCXYTEAzmmF08zH2AOyCKNAMv5CrrpFqzZXr2m4evyT3CzLejW
	 LwgXNnB/LA0iURA5LFoV/WSeHaG143H+xeZspxI0RsXxhHp6iPg8zm3S4sXublovc5
	 3SonCNABBd6MA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6DFDC80CE0;
	Tue,  4 Aug 2026 13:11:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 09335218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF26960715
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h4cn8kzR8IAw for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 13:03:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9BF06605E3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9BF06605E3
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9BF06605E3
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 13:03:54 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6a0cb6e96dcso4469366a12.0
 for <u-boot@lists.u-boot-project.org>; Tue, 04 Aug 2026 06:03:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785848632; cv=none;
 d=google.com; s=arc-20260327;
 b=qutfiAAvj98QIMqPObf2xSoXRbGIGSwN5tIRbg19idsgI4k9vJ+6rYtudRfsDe7J+p
 fpkxewBv34tPH8alLa8gO/pqH/4PeVnG5c8FSjiDrRnFIxG7vJxbzrIdpX0bPHLOJE4x
 IS2WR2TdfAWK2aMucOF0VdIEUFB172TSEXlYvKLW3SkM4mfGbR59TEQL8LlzT5EFLOPW
 N+WINs7U5M3UmrpqXNsEjzqQQIu95yw2PH5SVaXsaM+AR9GRAaJPPO+U9TE/H9MvYDa6
 lcjvZ9DW9H265327bmMtQTQjVEM7W3Ppx24ZIo7ROVXbhpPfxLNvBZUxWjUO0Qcr4Mdt
 Tpyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VbXtC2U8j1Y87D/oKM39XpIZWij7pGT8z79m8SGSeYA=;
 fh=hsQzq9IYCmZwK0E7cVW3p7RZJMnlUShWANxf+Zzt34k=;
 b=ar6++Qv9Ff0PhOJ92th6+hzPmKZiogvE/PPZOhht6/HLVaqXYISJiFlqBREzS78cyb
 J1u4k0YyL9ZmXvwJ04T/AaufxcCtn8LE4Q+34u9N+HmAmK4hC5dQoy3wk200g/1FkOo0
 FGg3A4qfY6iXXiZFkms7hCWxc11OqIGEu7mZiuWvnLmsi3rvTv/oQvKS/WIrPRLJ1/Md
 YVUWr0ojynbokFQH2avB+8f6sYuPSfwhMAA74yuNUV8ggXoJPQ4uXGdgYbRnJgPmiWHi
 HuYow8Y0EQtsNqRqSiXgNreM8Hzk4hcWd57Zco9+WwaV+vf2r4pBn3IPwwUmliaRRL/M
 roYg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848632; x=1786453432;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VbXtC2U8j1Y87D/oKM39XpIZWij7pGT8z79m8SGSeYA=;
 b=sVxRqOMZG1PCcGX6gwa04+H1U8WsZbMrUUl64nPOEAflsmG7VuR9m4/Rxj+Ey9sIHO
 UqPy5thhDJdOeRqIiLYHcTpIh7pqOkyHQQwx/AYLIYdGG7IWCRs+u4sVY1ZGqmyeyPfi
 O+LdM+6r38C7+z1MAinlfvRLIFYjFeEIunq7R8fHJX7iY0hS8Ltpo9ZruVwYo+NS/yot
 1ni2Jy5IMaB/aPgdznabb0SSiltBXmv0VD8yD/8W71cIlCifP0sqhFE+qErl1cCZnrNo
 X0SCW0DXwFLItMpkk4eCNnsKVZ6SHDcHlj6cOLQtdL6OztTtzBLjLVLpbnshPvmMHlCD
 BC9w==
X-Gm-Message-State: AOJu0Yymcac6DGXZMaPRyQuaY93+EsyChVaQ5yxamYrETTq2pl8MU3mS
 14A0quyEcQQGyz+ODTvnpqqhVz0Zr/ocMZn3aAQrP7STMoZXnSCujXksDd9ps9kc6CLokMGBE8I
 vS/gLsgSorJ0ee0IR7FuvnYXC1BLYgFUNHutYBQjD
X-Gm-Gg: AR+sD12eVYjuTv0f3tL/WkKPz9mYC5shdrTO6DYQubQfBhmVSfM0LACogXut3zoi5N6
 mv4vT6TeFnNKEW+gNGcuY9GZSDF0T5mhQIIQ7oLgUdItEVw+5uZ8kjJEamn5FqnqMmNGP4edIPA
 ORJvFttjcDVsHjYZVeTFaaeUP52FzkFsCt4eAmqOlpqIHaXMKbA4/jJAcxFfRqT7G3PXqE1qJqJ
 wCH/CZEpqMI7g2gUamGeXGl4xnc/xIMwgDJEae0Pq8eHjioKtDo+6S6mJKKy14TUZJ9t0Ds5hfD
 UrTl5J+9RaFdMVXMs5soGL7G/m84ySSyxIpRc8tFZLT3F/TjvdD8ag==
X-Received: by 2002:a05:6402:322a:b0:69a:a4bb:bfc0 with SMTP id
 4fb4d7f45d1cf-6a0a7c888f7mr12589733a12.11.1785848632222; Tue, 04 Aug 2026
 06:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-atf-falcon-v2-0-acb97c172993@flipper.net>
 <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
In-Reply-To: <20260731-atf-falcon-v2-9-acb97c172993@flipper.net>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 4 Aug 2026 07:03:38 -0600
X-Gm-Features: AUfX_mzv9eEZxpSWr4IThD287shZLQ-Xvqwm4QFDAy_TB95f8LOwQX4tY8eme6Y
Message-ID: <CAFLszTgXZxWP2KCweVgD27bGQiusRx6G3RDiG8BuQCe6Mdat4g@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] rockchip: binman: Add support for Falcon mode
 FIT images with TF-A+Linux
To: alchark@flipper.net
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ronald Wahl <ronald.wahl@legrand.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Tony Dinh <mibodhi@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Aug 2026 13:11:06 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785848632; x=1786453432;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VbXtC2U8j1Y87D/oKM39XpIZWij7pGT8z79m8SGSeYA=;
 b=RAik09YNRZvUeabi9Q0JM4CI2aET5drwUs1kNUjrhCUbiUWzi08s+fhdY1XMj+rcRF
 pEoxT5kQZ03JGBM0YVzcqnXjc//9BYg2+2xeYMxyZUn+nmF6JizRdoEOP/5/jzqpzFzW
 ppZXEKDp+j+70aT6BmRZkuhniFs8PwTPS8NcA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RAik09YN
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Alexey,

On 2026-07-31T17:10:44, Alexey Charkov <alchark@flipper.net> wrote:
> rockchip: binman: Add support for Falcon mode FIT images with TF-A+Linux
>
> Modern Rockchip SoCs such as RK3576 require TF-A to be running to provide
> firmware services to the OS. To enable booting Linux in Falcon mode on
> such SoCs, add a binman template for generation of FIT images containing
> appropriately split TF-A and TEE binaries (as is currently done by binman
> for U-boot proper images), externally provided Linux kernel and optionall=
y
> an initrd.
>
> Any FDTs provided to the generator will be pre-patched with a /chosen
> node containing an initrd load address and size (if an initrd is provided=
)
> and a bootargs property containing the kernel command line (if provided),
> so that the kernel can be booted directly without external preprocessing.
>
> A config fragment rockchip-falcon.config can be used to enable Falcon
> mode boot and the building of TF-A+Falcon with binman, e.g.:
>
>   make nanopi-m5-rk3576_defconfig \
>         rockchip-falcon.config
>
> [...]
>
> arch/arm/dts/rockchip-u-boot.dtsi     | 204 ++++++++++++++++++++++++++++-=
-----
>  arch/arm/mach-rockchip/Kconfig        |  49 ++++++++
>  board/rockchip/rockchip-falcon.config |   3 +
>  3 files changed, 225 insertions(+), 31 deletions(-)

> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-=
boot.dtsi
> @@ -260,6 +372,36 @@
> +             payload {
> +                     type =3D "section";
> +                     align =3D <CONFIG_SYS_CACHELINE_SIZE>;
> +                     /*
> +                      * Must be named 'u-boot-any', unlike the non-Falco=
n
> +                      * image which can call this 'fit': SPL declares
> +                      * binman_sym(u_boot_any, image_pos) unconditionall=
y, and
> +                      * binman resolves that symbol against an entry of =
that
> +                      * exact name or one called u-boot[-elf|-img|-nodtb=
].
> +                      * Those only exist here by way of a U-Boot image i=
nside
> +                      * the FIT, which a Falcon FIT does not carry, so w=
ithout
> +                      * this name the symbol cannot be resolved and binm=
an
> +                      * fails. The type property is what selects the ety=
pe.
> +                      */
> +                     u-boot-any {
> +                             type =3D "fit";
> +                             insert-template =3D <&fit_falcon_template>;
> +                     };

A node called u-boot-any whose type is fit - needing a nine-line
comment to explain why - is a strong hint that we are papering over
something. Patch 8 already adds binman_sym_declare_optional() for the
payload symbol on the RAM_DEVICE path; the cleaner fix is to make
u_boot_any similarly optional (or key off SPL_OS_BOOT/RAM_DEVICE) in
common/spl/spl.c so a Falcon-only image does not need this pretence.
Then this entry can simply be named fit like its sibling in
simple-bin-usb472 and the comment goes away. What do you think?

> diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-=
boot.dtsi
> @@ -161,6 +182,97 @@
> +                     ramdisk {
> +                             description =3D "ramdisk";
> +                             type =3D "ramdisk";
> +                             arch =3D FIT_ARCH;
> +                             compression =3D "none";
> +                             load =3D <FALCON_INITRD_LOAD>;
> +
> +                             linux-initrd {
> +                                     optional;
> +                             };

Just to check - when LINUX_INITRD is not provided, does the outer
ramdisk image node still land in the FIT as a zero-byte data blob, and
does SPL then try to load a zero-byte ramdisk loadable to
FALCON_INITRD_LOAD? _process_firmware_prop() skips missing entries
when populating firmware, but I couldn't convince myself the same
happens for the enclosing image node itself. If it does not, please
add a testcase (or drop the ramdisk node entirely when the inner entry
is absent).

> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kcon=
fig
> @@ -758,6 +758,55 @@ config ROCKCHIP_MASKROM_IMAGE
> +config ROCKCHIP_FALCON_KERNEL_LOAD
> +     hex "Falcon mode kernel load offset"
> +     depends on ROCKCHIP_FALCON_IMAGE
> +     default 0x10000000

These three offsets are per-SoC in practice (BL31 / OP-TEE carve-outs
differ between RK3568, RK3576, RK3588=E2=80=A6) yet the defaults are the sa=
me
for every Rockchip target. Please either narrow the default to the SoC
families you have validated, or add a note in the help text listing
which SoC the 0x10000000 / 0x1c000000 / 0x1e000000 layout matches, so
users of other Rockchip parts do not silently overlap BL31 and wonder
why the kernel never starts.

> diff --git a/board/rockchip/rockchip-falcon.config b/board/rockchip/rockc=
hip-falcon.config
> @@ -0,0 +1,3 @@
> +CONFIG_ROCKCHIP_FALCON_IMAGE=3Dy
> +CONFIG_SPL_OS_BOOT=3Dy
> +CONFIG_SYS_SPI_KERNEL_OFFS=3D0x0

CONFIG_SYS_SPI_KERNEL_OFFS depends on SPL_SPI_FLASH_SUPPORT &&
SPL_OS_BOOT and is only read by common/spl/spl_spi.c - none of the
boot paths added by this series use it. Please drop this line, or
explain in the commit message why it needs to be forced to 0 here.

Regards,
Simon

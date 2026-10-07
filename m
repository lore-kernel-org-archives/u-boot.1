Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88690CA6002
	for <u-boot@archiver.kernel.org>; Wed,  7 Oct 2026 20:11:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 999D640A8E;
	Wed,  7 Oct 2026 20:11:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njLQSMAbkVoh; Wed,  7 Oct 2026 20:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6427A40A71
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791403906;
	b=JS8QGrGBlr2ZrctowivKiWFdi/fD8kLkMY7TkYws1EAJI6F2V1DMVSZUwg2ymUBd+Fmc
	 Ba43MhWe4bAIoNMdkjLc/GIuLHOXPBEP9lLcBuQ1Tp2RZ5umVWIH0JzEmykU4My2Xw9lH
	 ZfVFiBYrmUXsS/JBioV2ZstFTTDerg1VYm/OWYxjxiTDxfQI1BqMFndh+rGN57rJWL1PJ
	 /O1kT3NUEM4eVugAva8zu5c87Yi2ZXVQF5ZHPrK2LJ2vfv0rx6CM7AUfT8YMukPd2dDq9
	 uORkV8pbsWNkWeuXroNg1mxtcaYvF6tV/D/WsDPq4m0CMbEMT3YoEmnfiw9qix2HD6Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791403906;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=fta4S1uM246NE3nUQCjJdnVTcAwbAhIKJnUL8q5m1fk=;
	b=lFnav8aH+2ITTDw+pYqiDqr2m8HUEQ0sWgy12hB2r0y+YCwB6oo4oURT1LUn2jhSXbWt
	 UWwH9hbuizY/P/ocFKkUDzQ/9FW1h5pwmDTeu4KMQWZmEprpKUISN2lzlCD3gAD5LNkEn
	 wAfMMbfMRos8/blNKbwJmnnjKAEov9JgkdPek7LTnQo5KJ340trAhYyxQ4mX7rhI3CXIJ
	 Jpumc4V8COgBG7hXlECr1dZa/Izv1EPHGFvy31gqb/kp2kxxcGoM2JXGqa95ToQF+zC1D
	 HWQSHgGtFLee79nuspW00h+UthLIfWMv+aOqqwoRNmh/ZPAOemgOJvX3SVb7C32q1Yg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=ZLgMQCKt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791403906;
	bh=fta4S1uM246NE3nUQCjJdnVTcAwbAhIKJnUL8q5m1fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IWGQHfuVD3niiJKJoX7lNBnfAfLgD6gSP/QnMC3h5gaggqg5qjPLiKKouIrWEJ8e/
	 NPA0JZyXpFsII+9n/ue0WNNZPxL5nRjXjMbaGG/u2zv3w1TyJxikvXxlKAnNPbSRsS
	 +V6Caj2eOQJs2AuE0O2RRxcRlAGZa1jmRxkKZijSSQ6ATUPX1GHhMkUDjAzzkkF17J
	 mn/g/u2AM3GuacJwPxXiBqLCPEz5rdylPnXj3HwTKfYcRzVrZf1/+Fn4kWmN+YR8kY
	 QRk/NZzBIKy3E6ejEq0gf96ge2cxvAMefAp0M0h4POG6Em3L+uo7y3NwXlVhixW8bZ
	 HLoAru48CtU9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6427A40A71;
	Wed,  7 Oct 2026 20:11:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12489338
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:13:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 046A540B23
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:13:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AX2Bdwr6TTls for <u-boot@lists.u-boot-project.org>;
 Wed,  7 Oct 2026 19:13:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B91B240B22
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791400397;
 b=iedYNdevkaOlK3pVw6mPLIW8pqgsvwJ8Au5KqCv3BIR66+JXy+70FUBNSvfx48oUtPEZ
 C1h+facoDyDPu7h0z/sXhky4JnpFg+W79GwX2wYRLNX83r3dxW/DC5hsYXizH9VMuZ5eP
 ZfhW/gTp1III3hROf0W2Q0yckpsya5RhfgZAxMZn2e00lmak1JcaAQcmPDJSnwJKdP0nK
 9Ruv3v8m+CFTYkAveSDscB4S6ljlDEWqJBeYENSIfEc/OfrFdt0DtayDC86GNDDxcwB7t
 z3M0TFYNuN+ukYMvgz033NqovdrXQriHTEKJtuZA9k9rj8kEfwLr3fsbml+7qHXEung==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791400397;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=fta4S1uM246NE3nUQCjJdnVTcAwbAhIKJnUL8q5m1fk=;
 b=bceH5cHoMcrCjMy08fyLgJVaDhkH7dy0y06KXssxEIsAdyXkim3WXFAvrPZXAeWDzI19
 A/cTalUpMp3T+6UCJSYgKkrkL4/FoZqfVBNmPMUAc/UmF2pAy4/Nzs7tayJGLX17B0J3a
 q+y/Xm756PfQqknvVd+1DhVpaf8Pvxji2g+wZSkQcdgw289PTEoLasMf2gzSl+FASCxIx
 bn9+rE32YBYBDVlC0/5o0U1PIioAfHfx0Gcwr8ZqaqcQG78ZwP12yMY2rp68HH1HIdsya
 enBDH0SnH1SrHyfHWFdKatllpPxPHdS1DmsBc+zwvn0dShSJ5GYRj+xG9YonlNhqQlw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZLgMQCKt; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::b"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::b;
 helo=mail-oo2-x0b.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=ZLgMQCKt
Received: from mail-oo2-x0b.google.com (mail-oo2-x0b.google.com
 [IPv6:2607:f8b0:4864:31::b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B91B240B22
 for <u-boot@lists.u-boot-project.org>; Wed,  7 Oct 2026 19:13:16 +0000 (UTC)
Received: by mail-oo2-x0b.google.com with SMTP id
 46e09a7af769-82890dea412so939897a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 07 Oct 2026 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1791400395; x=1792005195;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fta4S1uM246NE3nUQCjJdnVTcAwbAhIKJnUL8q5m1fk=;
 b=ZLgMQCKt3KCvk/hpxbeBlhNznBK/QFTAqvUrDfu0QQd+gDRREeujdlr00kqG5SD3/a
 kT1pLlSSCMncZBYbwsiz7SdUeGXjlX9y+a0ujnCvAuF9lsXvtjgK5KrpO0EwB4vuMP3B
 9rrjFAd0RSCEg6LcoE1mNAEoydP/l/6I8aEUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791400395; x=1792005195;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fta4S1uM246NE3nUQCjJdnVTcAwbAhIKJnUL8q5m1fk=;
 b=Tdr76MUsJcFibVDUm738i0EKGsWT748sAJxqTDiQAEc1EKxcTo0jXSkyYeBbUeNYYc
 FNhI48DPlmeeFIvnDaoQ100hcAScN5uthfMUH1Kt+6WYcCbWmQxq6xuBHyWH/x1A2vNS
 kCDeodiP3armXSlBjjVpyi6AMURfixBGX2n+rd/oPPGeIHTRawZcYB7ggPI1XkH78PGJ
 iTUmk35AGLBugtdfpKxQqPvGQxxIJ1CXqwFCrCwk5vKlOBJsKKJKb6TbrbN3kp0Ubqar
 WwNevuYmKW6ngO0gD9rjJUvte1JJ9JmBSYQIMhWlvydtt9Oiq+mStWtG8RdJtoFu2PTC
 NT5g==
X-Gm-Message-State: AFuF++nvc0rHy7Q4BKKPAHVXsQhMRTTC5wmVlfvL736Qhe51hqpBetUZ
 PVfyNZ+CZ7+Pt1ubtou0oxEY2/J+kf1HVGHHj80AP+GFklQJjb7nEOms54ZJeX34P58=
X-Gm-Gg: AYBFou0iMoimv3SOVOHs8/bvz06pWuVY7qvINqfFiMnNMJ84Y92IaPTK4RSvaN7jpUc
 RhaKlGOPqVhX9dl5WrTtKhtyRxf9C6N49WnW80ZNVBCzaJflAusryc93EI7tfs7pYe4dy4Ts58a
 9mVlY7E40u63omwNdJysl/y/ORMmIWhVfNbVf7ltTymBTUYbeHijHJmIWqJbggj2C3zfkZR66CD
 x0CaRXcsEPwTr6tHkQCIjr5KibuLOL8B+xsckYPtywmXkIGZ704wdnVIf+i1GZ4pAaSDEP53IxO
 GDmLzHja45j5C8IJsRtjEw8/FNBTmgHX1upB92qdOVq5KszK8/mrR92rGhngT3NMeZKkx51CYRJ
 aZeL6Gvt/lpVp34NZatUSR2Rx64xUIo/2oSpu4LcdRv7HdPUZqNDIIptG5xuGSnAym63smKYOzn
 yh3iPE8K2c75N2x+HH4nbunMg6hNoqaGsXqVTg88RiZNc3162a4kmuIIyJIG248ZyqLi12CHORL
 HgrUwHgzZiHLLR227USay8+ynHiN6TakLggqUMTJt+O//q9vEj+Ndd7ooOrhdrOSY1STBknGvC0
 Dc6w2+HMIS4yG5djpE4=
X-Received: by 2002:a05:6820:c2cb:10b0:6d9:4d1:5c3b with SMTP id
 006d021491bc7-6e7a825bfc3mr2245303eaf.40.1791400394860; 
 Wed, 07 Oct 2026 12:13:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6e793c6742fsm2889719eaf.7.2026.10.07.12.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 12:13:14 -0700 (PDT)
Date: Wed, 7 Oct 2026 13:13:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Vencislav Atanasov <user890104@freemyipod.org>
Cc: u-boot@lists.u-boot-project.org, Janne Grunau <j@jannau.net>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>
Subject: Re: [PATCH] New platform: Samsung S5L87xx
Message-ID: <20261007191312.GD3079290@bill-the-cat>
References: <010701a10b3e4582-979b6c8d-12c9-4819-ad7f-7ce925de5824-000000@eu-central-1.amazonses.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nLVM4iFN+rkmS7HG"
Content-Disposition: inline
In-Reply-To: <010701a10b3e4582-979b6c8d-12c9-4819-ad7f-7ce925de5824-000000@eu-central-1.amazonses.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--nLVM4iFN+rkmS7HG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 05, 2026 at 08:46:32AM +0000, Vencislav Atanasov wrote:

> Port U-Boot to the Samsung S5L87xx SoC family, which is used by the
> Apple iPod nano (2nd to 7th generation), iPod classic (6th generation)
> and iPod touch (2nd generation) digital audio players.
>=20
> ---
> As there is no official documentation or datasheets available from the
> manufacturer, all peripherals have been reverse-engineered in the span
> of more than 18 years, initially by the Linux4Nano project, which was
> later renamed to freemyipod.
>=20
> The current code can be built and booted on the iPod nano series,
> from 2nd to 7th generation inclusive, and on the iPod classic (6th
> generation). While the iPod touch (2nd generation) uses the same SoC
> as the iPod nano (4th generation), support for the former is not
> currently included.
>=20
> On those supported devices, U-Boot's console works over UART, using
> either the 30-pin connector's UART pins, or the UART pins on the
> Lightning connector for iPod nano (7th generation). USB 2.0 works
> in device mode, and U-Boot can successfully enumerate as a DFU device
> and launch a firmware image - either another copy of U-Boot, or a
> Linux FDT image.
>=20
> U-Boot can be chain loaded from Apple's bootloader or from Rockbox.
> Since Apple's bootloader verifies and decrypts all DFU images, an
> additional tool is needed to generate a suitable image from u-boot.bin.
>=20
> There are a couple issues, still being worked on:
> - The timer on iPod nano (2nd generation) is not exact, there's a
>   drift of about 5 seconds every 5 minutes.
> - The S5L8702 devices (iPod nano 3rd generation and iPod classic
>   6th generation) use a different UART baud rate - 57600. In addition,
>   the latter's UART interface is not stable when receiving data from
>   the computer.
> - The iPod classic (6th generation) is currently using a wrong clock
>   for keeping time in U-Boot, so the sleep command is slower.
> - The iPod nano (5th generation) build does not boot because of wrong
>   DTB alignment. The tool which launches U-Boot does not use a 8-byte
>   aligned address, which became a requirement since 0535e46d55d7.
>=20
> This patch is the combined work of several developers:
> iPod nano (2nd generation): Franz-Josef Haider <f_haider@gmx.at>
> iPod nano (3rd generation): Tucker Osman <osmiumusa@gmail.com>
> iPod nano (4th generation): Vencislav Atanasov
> 				<user890104@freemyipod.org>
> iPod nano (5th generation): Serge Bazanski <q3k@q3k.org>
> iPod nano (6th generation): Vencislav Atanasov
> 				<user890104@freemyipod.org>
> iPod nano (7th generation): Mart=ED Guasch <m-gsch@guas.ch>
> iPod classic (6th generation): Vencislav Atanasov
> 				<user890104@freemyipod.org>
>=20
> Links/resources:
> - https://freemyipod.org/ - main project wiki
> - https://github.com/freemyipod/u-boot - development repository
> - https://freemyipod.org/wiki/U-Boot - building/running instructions
> - https://freemyipod.org/wiki/Hardware - device and spec list
>=20
> Signed-off-by: Vencislav Atanasov <user890104@freemyipod.org>

It's very nice to see this. For the next iteration, please reword this
so there's more information, and also the attributions, above the first
"---" so git doesn't omit it.

[snip]
> diff --git a/arch/arm/cpu/arm1176/start.S b/arch/arm/cpu/arm1176/start.S
> index d3ab5928eee..3e82676456d 100644
> --- a/arch/arm/cpu/arm1176/start.S
> +++ b/arch/arm/cpu/arm1176/start.S
> @@ -37,6 +37,41 @@ reset:
>  	b	save_boot_params
>  .globl	save_boot_params_ret
>  save_boot_params_ret:
> +#ifdef CONFIG_POSITION_INDEPENDENT
> +    /*
> +     * Fix .rela.dyn relocations. This allows U-Boot to loaded to and
> +     * executed at a different address than it was linked at.
> +     */
> +pie_fixup:
> +    adr r0, reset   /* r0 <- Runtime value of reset label */

Globally, there are spacing issues where the changes don't match the
rest of the file, please fix those. Similarly, please run checkpatch.pl
and make sure there's not other fixes like that to do as well.

[snip]
> diff --git a/arch/arm/dts/s5l8701-n36.dts b/arch/arm/dts/s5l8701-n36.dts
> new file mode 100644
> index 00000000000..f8d6cdc8dba
> --- /dev/null
> +++ b/arch/arm/dts/s5l8701-n36.dts
> @@ -0,0 +1,26 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +/*
> + * Apple iPod nano (2nd generation)
> + *
> + * target-type: N36
> + *
> + * Copyright (C) 2026 The freemyipod team (freemyipod.org)
> + */
> +
> +/dts-v1/;
> +
> +#include "s5l8701.dtsi"
> +#include "s5l87xx-nxx.dtsi"

For all of these dts files, have you submitted them upstream?

[snip]
> diff --git a/arch/arm/include/asm/arch-s5l8701/uart.h b/arch/arm/include/=
asm/arch-s5l8701/uart.h
> new file mode 100644
> index 00000000000..da07b296b6d
> --- /dev/null
> +++ b/arch/arm/include/asm/arch-s5l8701/uart.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2009 Samsung Electronics
> + * Minkyu Kang <mk7.kang@samsung.com>
> + * Heungjun Kim <riverful.kim@samsung.com>
> + */
> +
> +#ifndef __ASM_ARCH_UART_H_
> +#define __ASM_ARCH_UART_H_
> +
> +#ifndef __ASSEMBLY__
> +
> +struct s5p_uart {
> +	unsigned int	ulcon;
> +	unsigned int	ucon;
> +	unsigned int	ufcon;
> +	unsigned int	umcon;
> +	unsigned int	utrstat;
> +	unsigned int	uerstat;
> +	unsigned int	ufstat;
> +	unsigned int	umstat;
> +	unsigned int	utxh;
> +	unsigned int	urxh;
> +	unsigned int	ubrdiv;
> +};
> +
> +#endif	/* __ASSEMBLY__ */
> +
> +#endif

Can we figure out a way to share includes? It seems like this one for
example is cp'd a few times. Maybe arch-s5l8xxx ?

[snip]
> diff --git a/arch/arm/mach-s5l87xx/Kconfig b/arch/arm/mach-s5l87xx/Kconfig
> new file mode 100644
> index 00000000000..81485943d00
> --- /dev/null
> +++ b/arch/arm/mach-s5l87xx/Kconfig
> @@ -0,0 +1,53 @@
> +if ARCH_S5L87XX
> +
> +config S5L8701
> +	bool "S5L8701"
> +	# Actually an ARM940T
> +	select CPU_ARM920T
> +	help
> +	  The Samsung S5L8701 is an ARM-based SoC with a single core ARM940T.
> +	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
> +
> +config S5L8702
> +	bool "S5L8702"
> +	select CPU_ARM926EJS
> +	help
> +	  The Samsung S5L8702 is an ARM-based SoC with a single core ARM926EJ-S.
> +	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
> +
> +config S5L8720
> +	bool "S5L8720"
> +	select CPU_ARM1176
> +	help
> +	  The Samsung S5L8720 is an ARM-based SoC with a single core ARM1176JZF=
-S.
> +	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
> +
> +config S5L8723
> +	bool "S5L8723"
> +	select CPU_ARM1176
> +	help
> +	  The Samsung S5L8723 is an ARM-based SoC with a single core ARM1176JZF=
-S.
> +	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
> +
> +config S5L8730
> +	bool "S5L8730"
> +	select CPU_ARM1176
> +	help
> +	  The Samsung S5L8730 is an ARM-based SoC with a single core ARM1176JZF=
-S.
> +	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.
> +
> +config S5L8740
> +	bool "S5L8740"
> +	select CPU_V7A
> +	help
> +	  The Samsung S5L8740 is an ARM-based SoC with a single core ARM Cortex=
 A5.
> +	  Peripherals include USB2 device, USB1.1 OTG, I2C, I2S, UART and SPI.

We should probably handle this as a "choice" statement

[snip]
> +#obj-$(CONFIG_S5L8730) +=3D s5l87xx-buscon.o

Commented out lines should be removed unless there's a very good reason
to keep them (and in code, it should probably become some debug
statement that'll be optimized out normally).

[snip]
> diff --git a/arch/arm/mach-s5l87xx/s5l8730.c b/arch/arm/mach-s5l87xx/s5l8=
730.c
> new file mode 100644
> index 00000000000..91e6abfb03d
> --- /dev/null
> +++ b/arch/arm/mach-s5l87xx/s5l8730.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2026 The freemyipod team (freemyipod.org)
> + */
> +
> +#include <init.h>
> +
> +int print_cpuinfo(void)
> +{
> +	printf("CPU:   Samsung S5L8730 (ARM1176JZF-S)\n");
> +	return 0;
> +}
> +
> +void lowlevel_init(void)
> +{
> +	// unused
> +}

Empty functions like this should mean we just need to turn off a Kconfig
symbol instead.

[snip]
> diff --git a/configs/apple_n20_defconfig b/configs/apple_n20_defconfig
> new file mode 100644
> index 00000000000..79ca75bb7b7
> --- /dev/null
> +++ b/configs/apple_n20_defconfig
> @@ -0,0 +1,35 @@
> +CONFIG_ARM=3Dy

I can see this (and presumably the rest) weren't done via "make
savedefconfig", so please do that for v2.

--=20
Tom

--nLVM4iFN+rkmS7HG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCasaZxAAKCRAr4qD1Cr/k
CgPFAP9YK6lzvyI7kKs6AX7H4XhbvqXNaAIztrRdrIo3IhhzjQD/QZvRltEawqFC
rg/ip/RuZrSyswkyPpXipny/VS/I6wg=
=/C4v
-----END PGP SIGNATURE-----

--nLVM4iFN+rkmS7HG--

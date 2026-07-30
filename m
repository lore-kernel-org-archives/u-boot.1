Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB645C5516D
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 22:12:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 113F981235;
	Thu, 30 Jul 2026 22:12:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QMcOB0U_aZJJ; Thu, 30 Jul 2026 22:12:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D57E2811C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785449542;
	bh=E/4K4uKQyiqRYqmUMN1ni5vMTYEfHsjOFYN8mXcrX1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qJqUDkCizZApMdACThMAx4s3IZkctNCObt3e1u6CK1r0R6WMR/jIMHiZjV68wgOMy
	 L95wQs5L7qQUt0rJ8cNIzfZ+4LXV6yRAyWqJk7Dbgein614DQ2PES9XMugqxHkGJpA
	 kgHikrsZ3xeePgX/MbV717s1yy3xX6K8n7k4ZOVuO7OV/sYdfK6BgBFwaNqewtHK/u
	 Jzlu1N3jJQnP/s5zXBbu3v0Jv0jJkAAIPET9xaqio3V4xWg5KVg0gxkbtLO47tooVM
	 fUOqIyZZQD70IVn3R3w6m/xzcLEHhVUsmSo3outHMDZKM4srQ9zFQBSwc12kr44KEM
	 yh8EgkjkWqqPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D57E2811C7;
	Thu, 30 Jul 2026 22:12:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CE3B197
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E8E6400D1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o85cuwhaCThK for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 22:12:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4DF5B40086
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4DF5B40086
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4DF5B40086
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 22:12:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id D427984A0A; Fri, 31 Jul 2026 00:12:15 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80ED9849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 00:12:13 +0200 (CEST)
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6acb51944d6so141836eaf.0
 for <u-boot@lists.denx.de>; Thu, 30 Jul 2026 15:12:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785449532; x=1786054332;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=E/4K4uKQyiqRYqmUMN1ni5vMTYEfHsjOFYN8mXcrX1M=;
 b=nTl/03kzQIdjxd3jKb0LZg+MMKW4hMaaXQtoKcuMk3pRuPtkqHuD39aid4LKQiZwTJ
 nOYFYmUACZBgBLgEUtuzzcZHFWP6fjHFh2PCZi8adjpNIu+EFk2pRm25q0jtMmUD5Sfj
 YfK5pPYg9qpLup9Ot40AUJu2JIs+MnFa5qm89+Vtq5+q9DNwf8EKq2H8yN8t3liWChgy
 G0EI5NnvLBuosMgqJfGj70GuFsVWpPdIxqJMJmo57IW4WvK1CUwF1d0RvJnUb1MGxGQY
 3aHXzON9YPIVeU0k1WsYMFQX2FKq5/MCZDULWGxMyTbFqDpuNLV57iDF5za+uGk9UoSH
 gNKg==
X-Gm-Message-State: AOJu0YylX6MLrRuHIiiRnlWdwj8u7hCtU3NSd5ZNLvjHW8DWXnEcO+xM
 3FzLhpQ70EnJWYS6L/NbPSP3kF/B920gu+wLfA31HIl1qER1Hqc9JQjq1MCJ4fG3ZIg=
X-Gm-Gg: AR+sD13OtUWrSiAlGZrCdAKsVGaf/f/CU6yBFHquHYde7/pYdUJkH8jNP/RDxmgBR3W
 5Fw8FE2FmgMAmCKGIM/T9H973qzqR4MyWq/+2OwoS3DUUCtAXciTeVPLYdI+WwNDGUMQlJeGxQ7
 +2zb6N32UkDlwnZfao48XyVc3QkuNQR8lXsoGsRA/pvGJlbDj/hcYZw5ZpSCUi58ruC+PO6mOeY
 wyeXWEAvZQNwCCUCOXiMFx819NqbqCEfLBuz82YCMzT1gRy3QMsmlhzEIj3q+IltM3KKGaKlTO9
 ykwhKYR0HRh5u82hdO8gMT70k1pRB1Q7LxD3kXjbOCbOF1Ml9aFnIZEmEL9m3HVp2k3Lh6OaEEp
 iJbQQ7Qq65YdubiDYybvaAd0LTYj4yJ4Td/QONTZt4yP2d0/vYSuJIGxYeabrYtQokXniHzFPA9
 rOnxhN8E0hukllkkYRvaYxcP8hVwNA43LlmHVDwAufjyDHVZKGXJbShYfofAkXCAUCP6GgNca6N
 uJC3LAbPikDWgbPj1Msl60k2Du4VFag6WGKOmHGQFzAbpZg4LM1BTn/uz18a7HvCdlmccETU/nb
 E2AJo5W8LQ==
X-Received: by 2002:a05:6820:4c84:b0:6ac:b59d:5d2b with SMTP id
 006d021491bc7-6acbc1ee586mr2934225eaf.61.1785449532034; 
 Thu, 30 Jul 2026 15:12:12 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6acbc2eeb2bsm2546262eaf.8.2026.07.30.15.12.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 15:12:11 -0700 (PDT)
Date: Thu, 30 Jul 2026 16:12:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Elliot Berman <elliotjb@elliotjb.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH 2/3] qemu-x86: Wire support for applying capsule updates
 to pflash
Message-ID: <20260730221208.GJ1773261@bill-the-cat>
References: <20260730-qemu-x86-pflash-v1-0-fb403348e29b@elliotjb.com>
 <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cZk5YSG40N9/vqcU"
Content-Disposition: inline
In-Reply-To: <20260730-qemu-x86-pflash-v1-2-fb403348e29b@elliotjb.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1785449532; x=1786054332; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=E/4K4uKQyiqRYqmUMN1ni5vMTYEfHsjOFYN8mXcrX1M=;
 b=TYK4JHp+YgoA2XJKcnn52jtg16L/4bk7mvsXM683j+BnRGV2fORnQfdRScvADk88z/
 uhsonQ+VeQljj140FobUTaUXpwoIWJSb7nAo2t62/vdzmD9sr67T9CEYio9HoiWjssWr
 r812eUOj7MMGPcHCGb+EI1l7gwOZv6o1WeWmY=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=TYK4JHp+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TYK4JHp+";
 dkim-atps=neutral
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


--cZk5YSG40N9/vqcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 12:37:46PM -0700, Elliot Berman wrote:

> Following the flow used for qemu-arm64, probe the pflash MTD device
> and set dfu_alt_info/mtdparts for qemu-x86 and qemu-x86_64 so EFI
> capsule updates can target the u-boot pflash partition.
>=20
> Signed-off-by: Elliot Berman <elliotjb@elliotjb.com>
[snip]
> diff --git a/board/emulation/common/qemu_dfu.c b/board/emulation/common/q=
emu_dfu.c
> index 8a59f5ade13..db7d8cbbb4e 100644
> --- a/board/emulation/common/qemu_dfu.c
> +++ b/board/emulation/common/qemu_dfu.c
> @@ -51,11 +51,13 @@ void set_dfu_alt_info(char *interface, char *devstr)
>  	memset(buf, 0, DFU_ALT_BUF_LEN);
> =20
>  	/*
> -	 * Currently dfu_alt_info is needed on Qemu ARM64 for
> +	 * Currently dfu_alt_info is needed on Qemu ARM64/X86/X86_64 for
>  	 * capsule updates

Here and later, we should stop enumerating the platforms because it'll
just get expanded when say RISC-V is added by someone else down the
line and just "on QEMU for capsule updates" is clear enough I think.

>  	*/
>  	if (IS_ENABLED(CONFIG_EFI_CAPSULE_FIRMWARE_MANAGEMENT) &&
> -	    IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT)) {
> +	    (IS_ENABLED(CONFIG_TARGET_QEMU_ARM_64BIT) ||
> +	     IS_ENABLED(CONFIG_TARGET_QEMU_X86) ||
> +	     IS_ENABLED(CONFIG_TARGET_QEMU_X86_64))) {

Can we reasonably be CONFIG_EFI_CAPSULE_FIRMWARE_MANAGEMENT=3Dy on a
platform that *can't* support it? Again thinking to when someone
supports this for say RISC-V it would I think make sense for it to then
show up as "Oh, I forgot to map the MTD device in" as a run-time thing,
rather than "Oh, I need to update a big conditional". And this too is a
"here and later" question. Thanks!

--=20
Tom

--cZk5YSG40N9/vqcU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCamvMOAAKCRAr4qD1Cr/k
CjqKAP9W4oCP85tTH3IxI8DwHxtRDmMnjhmim6VuGmsh4pOM+QEA0I2+dB7P0AYo
q/Mk4zhNmBWiVoZHajMqI/+44L5ugAQ=
=o/+h
-----END PGP SIGNATURE-----

--cZk5YSG40N9/vqcU--

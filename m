Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E17CC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 21:44:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2443868D0;
	Thu, 24 Aug 2023 23:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ULPtR/JB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7669886429; Thu, 24 Aug 2023 23:44:42 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9176868D0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 23:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d73c595b558so313641276.2
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 14:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692913477; x=1693518277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ri8yHb1i2DefegJtunAMs9X9mMDgAVcvUd0y+3Ze080=;
 b=ULPtR/JBoWYzYYAk7eMRjhd9+6e1skBRbRXwTUzMlX/Qey8boXR9wGINvY4uisYSTC
 vzlyQHsPNWS59W//az3bF55cIzGKQl7xr/e7vc8Aww3QO5CGUFvbm3wjIKuFTPYFwjVp
 yl1elv5EC07AioVSYM7hj3GxhGr8nVlZNd7Ho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692913477; x=1693518277;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ri8yHb1i2DefegJtunAMs9X9mMDgAVcvUd0y+3Ze080=;
 b=dr/R+JHcT6v4hkA8HCtQXobTncM2l8jaj59H+zaPFAQdSKfhMgBYTIoEkeDvl+LmQE
 Y0m+H4VRf0gcKAgVT0M7UJpSvQv7sSYnoz1PJJI3/BNkpkaSVl3cAfssugSUzXefMjXv
 sJisTnoa2JiC359LwaMwLBM1zUJ2qNbjgQVaQOtM43NscVO4WNwYhJCyaSq55y8bmhRh
 m9tcf/6J9H8vwRDBXUVmwcqg3YxEoBUOnFs2O/Hsl5EZY6mneaudheLGY20Qo459Xm9P
 MrNka5FBspnGm0GDSIjTpVPIllz8yzIhRGNN1bG1YPbLMZ+WsZRTrAYhTiPkZCFzfsEv
 YM+A==
X-Gm-Message-State: AOJu0YyQEU59qzdcMPrsi+PQguxQr/7FpKdNNhpR5CvVydNWyiWb5kmb
 0e3fFQobNjqu6LT0a2nasDpcDQ==
X-Google-Smtp-Source: AGHT+IH0YEXh51/odXWbN+qLoX6kM2WK2e6AYRGuIGRjbC1Ic94UWc7S7cRm5uuXxsmY9//fKjYldw==
X-Received: by 2002:a25:b110:0:b0:d78:179a:eb33 with SMTP id
 g16-20020a25b110000000b00d78179aeb33mr2162019ybj.17.1692913477327; 
 Thu, 24 Aug 2023 14:44:37 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 j191-20020a2523c8000000b00d4fc4132653sm77454ybj.11.2023.08.24.14.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 14:44:35 -0700 (PDT)
Date: Thu, 24 Aug 2023 17:44:33 -0400
From: Tom Rini <trini@konsulko.com>
To: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Bin Meng <bmeng@tinylab.org>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Bharat Gooty <bharat.gooty@broadcom.com>, Stefan Roese <sr@denx.de>,
 Qu Wenruo <wqu@suse.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 0/4] arm: qemu: Enable Bochs, console buffering, USB
 keyboard
Message-ID: <20230824214433.GA2754624@bill-the-cat>
References: <20230814173944.288356-1-alpernebiyasak@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xetbl9CR0Hqz+dwA"
Content-Disposition: inline
In-Reply-To: <20230814173944.288356-1-alpernebiyasak@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--Xetbl9CR0Hqz+dwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 08:39:40PM +0300, Alper Nebi Yasak wrote:

> Now that the driver for the Bochs VGA card emulated by QEMU is no longer
> limited to x86 architectures [1], this series enables it on arm and
> arm64 virtual machines to provide a graphical interface. In line with
> that series this also enables console buffering and USB keyboard.
>=20
> Tested with the Debian 12 installer using GRUB EFI:
>=20
>   $ tools/buildman/buildman -o build/qemu_arm64 --boards=3Dqemu_arm64 -w
>   $ cd build/qemu_arm64
>   $ curl -L -o debian.img \
>       https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12=
=2E0.0-arm64-netinst.iso
>   $ qemu-system-aarch64 \
>       -machine virt -cpu cortex-a53 -m 4G -smp 4 \
>       -bios u-boot.bin \
>       -serial stdio -device VGA \
>       -nic user,model=3Dvirtio-net-pci \
>       -device virtio-rng-pci \
>       -device qemu-xhci,id=3Dxhci -device usb-kbd -device usb-tablet \
>       -drive if=3Dvirtio,file=3Ddebian.img,format=3Draw,readonly=3Don,med=
ia=3Dcdrom
>=20
> And with one using extlinux.conf:
>=20
>     $ [...]
>     $ curl -L -o head.img.gz \
>         https://deb.debian.org/debian/dists/bookworm/main/installer-arm64=
/current/images/netboot/SD-card-images/gtk/firmware.none.img.gz
>     $ curl -L -o partition.img.gz \
>         https://deb.debian.org/debian/dists/bookworm/main/installer-arm64=
/current/images/netboot/SD-card-images/gtk/partition.img.gz
>     $ zcat head.img.gz partition.img.gz >debian.img
>     $ [...]
>=20
> Both can get to a graphical installer just fine, in addition to U-Boot
> video console showing up in a GTK window.
>=20
> [1] video: bochs: Remove the x86 limitation
> https://lore.kernel.org/u-boot/20230723044041.1089804-1-bmeng@tinylab.org/

For the series, applied to u-boot/next, thanks!

--=20
Tom

--Xetbl9CR0Hqz+dwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnzz4ACgkQFHw5/5Y0
tyy2rgv8DtoqKZ+l/OPykC7J3YZVVFt8H0gqSAdg1nSnkFklu141BcFZOvJHM3YI
ptjwWZ3VjyEnffHVvpf6XEMGFAhfMa3rurmAHVsfODSp05O8nqh+iyGXOpX5AEPw
z9FBebrUTvAle6CoTqFXHOzZy7bur/EZ9tZ5U2oH1kosOKPAeN33UJXcifO4kJsN
NkId/aVQc5MaHaxvOeKPj5qhFxFn1HEC96Gk3EbjOO6MY2GFjUS2bIT85I8vVEdc
XDU30B3bDZjMVjb7JeFHwXFCxhPvVO+lUf9qgVK7MER0U/AEWzE8goCcGiFsl1YP
i6NSjk8xERSkdcLgkvXX+k/EUHADsX7zfOzMDJPgAv9sTuDiJPzJctIFaZ3l33d+
wj9FI9BmeYjXssrBlZvLFLP2sY7kFIW70tXgX2YHvJLg0RnjZ3qO6kXaGkk4qNbM
8yK76OFy/8KhpEDhDaz1zCxT3o3cZH2aRahEd67yKt4S2KoYDpl3tV7uhlwierCR
qGTVpziy
=TjFY
-----END PGP SIGNATURE-----

--Xetbl9CR0Hqz+dwA--

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9801EC83F03
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 06:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A170F83390;
	Wed,  9 Jul 2025 08:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sigma-star.at header.i=@sigma-star.at header.b="iOXWxAGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2900C83394; Wed,  9 Jul 2025 08:24:26 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9699783371
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 08:24:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard@sigma-star.at
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d7b50815so42997745e9.2
 for <u-boot@lists.denx.de>; Tue, 08 Jul 2025 23:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sigma-star.at; s=google; t=1752042263; x=1752647063; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EnxWsBzswxAklH+7j0qYBiXKvhU/huUv9jbGNr5/QbQ=;
 b=iOXWxAGo7U/GLbuj3gYEIvEgIO8/JtoCyBxi6J46zK5p5r6yuBKpX4hlwWZ/uIzZoI
 UxIHoQRnrKgRQwL1D614/cggaSR95d9TJ1B2eC7cNxbAwrAG+UP6+FDsPinar1y2R4yN
 KLCQL78+xPpX7oTbsV/kUU/Cxzz6ttGNOhW8hmCSPM9ZKKktGuCQcuGiCsj02uPnHrl0
 abIeCI+UkV3AK9R1yR+ooQXBBROSBVa9lMBjubh87rglaolQalSAOli3J46w0PqGagxh
 iFC3lmliUa8u0aFliPQSCi00YPt9I5OcQeoLa9EI6WnIJOFOIJKJcScmmqeVd8o7MNqf
 NoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752042263; x=1752647063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EnxWsBzswxAklH+7j0qYBiXKvhU/huUv9jbGNr5/QbQ=;
 b=jMvtB8gRndfhrivIC2V35eAu1oFOOHf/9/vIkCeoA6dM7mRV82l5cL+UkcTtM6CsZl
 G36sn2eqYg+hwlvoUupV0e5ARm4xEOv68sXLxBk7isNDOlLNge1qYRIbmT2wxfmsfbfM
 YEFr/4Rt2PTYeBS4J/VORSa7bQzkuyGMyTWXS9r4wxABOlr8s58R+qDwbRUg2fJOtTXg
 9GPoL4H6FUvvDRqB1ip/eNtwH5npdRvPYwSlQ1ykw46/TVr0Fz3zVGIhM0u38b9rZl1l
 EJYRmyOjFJXakU2vqu1yMqtPMXnaoGRg8GS+pIBT4XXSG+jzWZYaprVgcWEzxHjvhvzt
 lnjA==
X-Gm-Message-State: AOJu0YyS/xkUpqByYFLvmpcF6SL1O0i6sk45M2y+8I8TIzhGQ/7s89ET
 jnbzdYJHIMQdDk/hUpZEDG945kPf4lhQLNQyH6dUyV1Nyyro0Rq7V5MUdpIhTyewVhs=
X-Gm-Gg: ASbGnctw9K+6//DZBIGgapScwaAxmQKu/afY/e3bi5i5kuPbIvD0K3Im/t1BwfRCJno
 9IEYUdKsxYKxuTbri7csXZxFoiksxUmaYamXYXp2aYSAfAheYaUtbNaL+zPUbnMjaiTiubKM3y4
 YqzNCm/f8OEVhcz+h1k9mxgDaL43dSdrDGi2g0ujM3Mep88WfUFzOS8BhZn9NqleEIeW8RJI+ij
 Ozm3Xp39A9iU16IrHbbwT7sjJj5bcnWloEo4+T9tBkWXjq6ND4MwTgT0BkHqNYgfgixrPMJ4x4e
 5InEvYT+HhYTB/PQd3Jlri+TPIbjiXI97LcIaOaF5SUqKhpAKZ4iJlJYDo1ez5gJ78he2FcERA=
 =
X-Google-Smtp-Source: AGHT+IEg/m2ltIV48r0z+RSrJ1NNcaH3GHTNjS7DUEt6uJvy0pEdf/bMJlZcTgFVo9IZdeFtaFkOqQ==
X-Received: by 2002:a05:600c:3585:b0:453:6ca:16a6 with SMTP id
 5b1f17b1804b1-454d83696e4mr291715e9.10.1752042262839; 
 Tue, 08 Jul 2025 23:24:22 -0700 (PDT)
Received: from somecomputer ([82.150.214.1]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47030c2e8sm14546655f8f.3.2025.07.08.23.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 23:24:22 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Tom Rini <trini@konsulko.com>, Richard Weinberger <richard@nod.at>,
 upstream@sigma-star.at
Cc: u-boot@lists.denx.de, ddrokosov@salutedevices.com, sjg@chromium.org,
 tharvey@gateworks.com, ilias.apalodimas@linaro.org,
 kojima.masahisa@socionext.com, upstream+uboot@sigma-star.at,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [RFC, PATCH] fdt: Make sure there is no stale initrd left
Date: Wed, 09 Jul 2025 08:24:20 +0200
Message-ID: <1752760284.mgMEAqHVhB@nailgun>
In-Reply-To: <CAPLW+4kSGfyhd_Bxr+cn=PJV1Zvi2Du5+jLSZSxhqBPZ=PvFow@mail.gmail.com>
References: <20250529150213.27149-1-richard@nod.at>
 <174976652550.365589.4489095631856636528.b4-ty@konsulko.com>
 <CAPLW+4kSGfyhd_Bxr+cn=PJV1Zvi2Du5+jLSZSxhqBPZ=PvFow@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Mittwoch, 9. Juli 2025 00:58 Sam Protsenko wrote:
> fdt_initrd() function (where initrd dts properties are removed) is
> called two times:
>=20
> 1. First it's called by EFI boot manager (e.g. as a part of U-Boot
> Standard Boot mechanism) when it's installing FDT:
>=20
>     fdt_initrd
>     image_setup_libfdt
>     efi_install_fdt
>     efi_bootmgr_run
>     efi_mgr_boot
>=20
> It's already enough for EFI app to malfunction. But then it's also
> called second time:
>=20
> 2. From the EFI app, via EFI DT fixup protocol:
>=20
>     fdt_initrd
>     image_setup_libfdt
>     efi_dt_fixup
>     struct efi_dt_fixup_protocol efi_dt_fixup_prot =3D {
>         .fixup =3D efi_dt_fixup
>     };
>=20
> See [2] for specific GBL code which sets those fdt properties and then
> runs DT fixup protocol callback.
>=20
> I don't see any way for U-Boot to know if those initrd properties are
> going to be set later by other EFI apps or not. So arguably this patch
> should be reverted. But I might be missing something and maybe there
> are better options to fix that?

I think we need to distinguish two cases:
1. The caller explicitly does not want to have an initramfs. e.g. you run  =
"bootm addr1 - addr3".
2. The caller does not care. Your case.

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



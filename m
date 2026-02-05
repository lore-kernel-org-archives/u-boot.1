Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8753ECD995
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 18:47:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28CE583B86;
	Thu,  5 Feb 2026 19:47:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qrn0+Jg2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0F1783B95; Thu,  5 Feb 2026 19:47:36 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 818F483AA4
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 19:47:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-56641b5a471so1177322e0c.2
 for <u-boot@lists.denx.de>; Thu, 05 Feb 2026 10:47:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770317253; cv=none;
 d=google.com; s=arc-20240605;
 b=KMfhJmJeacSizxB25mJ3r90WMiQob44+EB0qGjWNFdi3frza73TGu6GIjsGbiIidd7
 VktJobiWq60ku7rdJ+zQi9w2enZ2WCktstbxfvP6lGbn2xZWh5k/D8wUp98hyniUoTUi
 4lDAt0LVkV7pFJBgxkLqyP9+iHaI3Li9Z9v3l7RBnYurE1H459iV3kCiib8E/zGe69DJ
 7fQ8SmynyglcU9fJpgoPJJNk1fZJP0T1b/fdMkB2Xn2KMM4Bs1TmVqadBS7Y3mf4U9jZ
 1FQa34q/h2U02jEF8v3g1H44hCbMKyB/MJ2hP+tJgZNWeu2lEphzBbCOX81WS8pSNUHp
 NOfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Cke2GGdHaVg58zCHkrL/SbXIGYyxSDS75/PG34vCpzU=;
 fh=iit390IZF0FtlLZ6Vd/Qcvtyf/e85wpT2siuqJ1WOP4=;
 b=b6x9WYDwjz5dSRY/iFlUMISDhDjv+m1cvzKR2+9WiRNE8YM9NbnbwlvfMdVUbwwCY4
 cDLaXS2ELuG+JbquGGlpqckYoWGBlKB4Pj7IJNH5z/hXQ6LC4eqPVrnFeHcMzFFC3u5e
 QPJtq+8Hg2tKTW5noO/3ZF0+9qf1/ZJbdgy9nWlKBrLHiM8qPxAMhNdQyoSeg4osTy4u
 +/V8b8fA7D4dv3Ukg9fxzQpxOPsI0ep+oKTuGdoo2YBHogBpWW9i6ilOhyl9/CD0PK3m
 r61TuKem8T8bNgN9bRPpTSQiyIvBvt0AH/X1vm8dreLyNDceuhh7WA4r4KmtdIQfEfGY
 62dA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770317253; x=1770922053; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cke2GGdHaVg58zCHkrL/SbXIGYyxSDS75/PG34vCpzU=;
 b=Qrn0+Jg2ormzBIusVXJSMRXDB2vmv++YpQFWy+zHi2P2Cf6vDNzkgZlwpw4h+FRH1v
 9FoC3ze7OFiwjlg8kmfdB7dKL/+7DI91BJWI5zDYOEPfaLPiFHZUI0gjAYrncUzBt8FE
 4k4yw/8afljLp/lNMtzUHmcT0Axs7RKRVw8eb5DOjWzWQ2dsyC3qfO9TwHKcp4Y6nPn4
 P/mzk2ZsfaupzArVsLTDjt9fz9vR7epozLQ/iRz2Xn1zzPGZB+3Z3iqM6jq+dVdfiHz7
 E8DcBJRFGyP8IGoPvS9FMAW2etsrxJZa7+O/5hdS8hmz9jxW+nszJ8b14bGvbbhTFpRI
 r/Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770317253; x=1770922053;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cke2GGdHaVg58zCHkrL/SbXIGYyxSDS75/PG34vCpzU=;
 b=UrclTTNGKz17bHvc6p8t5xZhVqsOmbjJ2zqqniGabD68NsFNx23eoSjD7aRGfvig//
 W3opGO/uoaN8RC3B70kXemnwW8Ic3c6w7CSTKRHhcV/kQQvKk6tCgCBrhQ5AMt8PyVhI
 55nW8nAm4cQfAnglEN4TdQ3BrkhgweISKghrxqrVlMF8IMBqhBiJxNFBlu1jSrP5j2kK
 o5W0HcQ3A+R5A5HVdG05NTWxqm6x0jfk1SDAF4hWYrxGlMRylItFlcenR4a/QGw9og33
 bK+4PQdy3q/vwq2eo3KQ9vfYebf4Al324BpJRvyBqVKj+aY9NdrYBTVCCDi9Dq4+TXmS
 /LaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuRgW/o7MiuBAKAiQzXsxfbtpOVQjdK2BhMgmBW4DKzo5GaJDfDgb/Q5tFSvCyOgp5Jr77Jog=@lists.denx.de
X-Gm-Message-State: AOJu0YxLn1GGhPRej6rKoFrlZSWFBwgPLYq1Kzs8a2U8ok+I3E16+0Gv
 sbye8wOVx2J8yJW2AAORVm22xG5LgxWvVA8es2wpdKXPys941mamsv10QSjbvZpea2UonrCz+xN
 1wsrIheJWdVztREm/EII/JG6r+8HOepU=
X-Gm-Gg: AZuq6aLffi2Mr7r1Np+kJzf79U1nLwTzHRh51v5GSplq/RsDg3QgLoATReaFVrQ5aC+
 fl0ThbyD/6VdtIGWad3Z93qcjxxqIJozuGyLzm4ZPnRKhrTTy8JvzyPsFfRSUf0/4Zj68Mk2OZG
 2NxvCNH3pWZIKNqu7gw+3ehs2zJHusLLvX2Qp2t5kMN81LtT8+14H1LFEgVtiMP+AuCUhLe1i71
 IKrqAoKvgPHufMTuN0x/d4iWn3oA9vpNTiW3VLELeWlitUYkRlNu9kWec1D4HLUsLFqzs4Z
X-Received: by 2002:a05:6122:4003:b0:563:68c4:16fc with SMTP id
 71dfb90a1353d-567060adc96mr145318e0c.21.1770317253210; Thu, 05 Feb 2026
 10:47:33 -0800 (PST)
MIME-Version: 1.0
References: <20260202170307.217200-1-philippe.reynes@softathome.com>
 <aYOXxN-DBm_6LrSE@kehys.lan>
 <CAMDkj5y-GgnwgnuQKnDY5AJAL8XWmCXWsFdKtj93VjEyR=b0oA@mail.gmail.com>
 <aYTehXWL9mAJoMeh@kehys.lan>
In-Reply-To: <aYTehXWL9mAJoMeh@kehys.lan>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Thu, 5 Feb 2026 13:47:22 -0500
X-Gm-Features: AZwV_QiLGq8ybn93zYOd1PLJrgIe-iGTT8lYxRfmdgIMJe9rRqiXnVMShTfjQHs
Message-ID: <CAMDkj5wDbrsMJpy7LHKR9PBEN0vuVeDoVDjpMPanqbiO8hP_bQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] add software ecdsa support
To: =?UTF-8?B?TWFya28gTcOka2Vsw6Q=?= <marko.makela@iki.fi>
Cc: Philippe Reynes <philippe.reynes@softathome.com>,
 jonny.green@keytechinc.com, u-boot@lists.denx.de
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

Hi Marko,

On Thu, Feb 5, 2026 at 1:16=E2=80=AFPM Marko M=C3=A4kel=C3=A4 <marko.makela=
@iki.fi> wrote:
>
> Hi Raymond,
>
> Wed, Feb 04, 2026 at 02:28:53PM -0500, Raymond Mao wrote:
> >Hi Marko,
> [snip]
> >When EFI_SECURE_BOOT is enabled, all these dependent Kconfigs will be
> >selected automatically.
>
> Thank you for your help. I can confirm that the following will build the
> ECDSA_SW implementation:
>
> make sandbox_defconfig
> scripts/config -e ECDSA_SW
> make syncconfig && grep ASN1 .config
> make -j$(nproc)
>
> The redundant "grep" step above would output the following:
> CONFIG_ASN1_DECODER_MBEDTLS=3Dy
> CONFIG_ASN1_COMPILER=3Dy
> CONFIG_ASN1_DECODER=3Dy
>
> I still can't enable those in any rpi_4_defconfig based build attempt,
> such as this one:
>
> cat > configs/rpi_4a_defconfig << EOF
> #include <configs/rpi_4_defconfig>
> CONFIG_EFI_SECURE_BOOT=3Dy
> CONFIG_MBEDTLS_LIB=3Dy
> CONFIG_ECDSA_SW=3Dy
> CONFIG_ECDSA_MBEDTLS=3Dy
> CONFIG_ECDSA=3Dy
> CONFIG_ECDSA_VERIFY=3Dy
> EOF
> make rpi_4a_defconfig
> make -j$(nproc) CROSS_COMPILE=3Daarch64-linux-gnu-
>
> This build fails in the same way as yesterday because none of the ASN1
> options will be present in the .config file. Neither will
> CONFIG_EFI_SECURE_BOOT. Many EFI options were enabled, but not that one.
>
> On a positive note, CONFIG_LEGACY_HASHING_AND_CRYPTO was disabled
> automatically by the above, and MBEDTLS was enabled, unlike in my
> earlier attempt about a month ago, using an different u-boot revision.
>
> I also tried to enable several options that CONFIG_EFI_SECURE_BOOT would
> select in lib/efi_loader/Kconfig, but with no success.
>
> Is there a way to get some diagnostics that explains why Kconfig refuses
> to enable a particular option?
>

Can you take a reference on 'sandbox_defconfig', it enables:
```
CONFIG_EFI_SECURE_BOOT=3Dy
...
CONFIG_MBEDTLS_LIB=3Dy
```
Then all dependent Kconfigs are selected automatically when you do
`make sandbox_defconfig`.

Regards,
Raymond

> With best regards,
>
>         Marko

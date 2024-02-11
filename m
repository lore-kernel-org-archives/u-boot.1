Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5282C4829B
	for <u-boot@archiver.kernel.org>; Sun, 11 Feb 2024 17:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED2C987C69;
	Sun, 11 Feb 2024 18:27:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="FJAp+1S6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FF087C78; Sun, 11 Feb 2024 18:26:56 +0100 (CET)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A07A87775
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 18:26:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-511531f03f6so2906759e87.0
 for <u-boot@lists.denx.de>; Sun, 11 Feb 2024 09:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707672411; x=1708277211; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8NJ4F8VXlTKMUPN3zDIp1z7oatYTjV3AptYwEznNYO8=;
 b=FJAp+1S63fbeS0AxR78Ld8xYXhYb+olW8yJJoiQkuidyfPK8LHgAkOpvoDUdt96utk
 GlDSj5mGpj9wvpR3Zr5kt2zTzJx2LYZiDB4+shIZOH8ewulHS+FIfIXxY508leCvbqvO
 DhARFphOWn0Zzdla6DcTT1n1CkbKK6JjZ+a4zZUmMHF4o6EGe9kTYvgaFjEN9I8/drgx
 d9bi0GHmm7dxl3yDyW//j4e2vbJCwAieKE+BUKz6KLnFJPKl6ErHOcihOBZtcq/E6Yye
 fsGWC7c4Pbp9r9I0cZUdOX8scEny/clU2guUe0ix28I+uAAqPt9/+W4TfKQsPqLjOKVn
 0U5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707672411; x=1708277211;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8NJ4F8VXlTKMUPN3zDIp1z7oatYTjV3AptYwEznNYO8=;
 b=AA7BtzYEHmhuzAFs1cIS89Z3WEkBl9BemTbBoq6zu1ror9Fcf2dnMJfShvpGAauR/J
 UtTKLKpDcjZGUPIJsBfiJocgmz5wuKbIj7tsU4v14fwzpAmuO4aka197rNpvIsh8WgD1
 yI91qzU27/brv8pldMenePNOutD+4oVodw5ALHMAFqqpEMtL5KS4Dhkh5LkDfR7CzpRs
 xPlX6nzNpxE7H+4r/n6BgEfwoC2NFuFNyu1TkMuDnUBxvZS/SqkI1kHynqaPaUxUfzy5
 OrK1j+BlnNVtjdxRlAJF69aTwcpXyUwVpvL/C870FnDk72M6GUwh/UUZEA1jKQGgI0rJ
 XnDw==
X-Gm-Message-State: AOJu0Yz/mtFLQhtv9qS5ZcGA0lqVUrr2JNbs78G2QgfWzRgdCFPMDleg
 4v4SMWsQBWa09O54uRq8CPA6nrHPAIb9JDjIwMJGn34yuvbUCJV+Gkh4it8yhLu1VDsfQa8Tdbp
 OBSjBVzIL/fQd+4+z9/b1IYTP9MGhkFMHCigofsA6LYdJvj6/RiM=
X-Google-Smtp-Source: AGHT+IFOaiL8HI7sefDbGMm9A8Q6tLrekMIfM8lj4hXgKgUfNRQzElMgSxgUDuA8UirTNHZPxYqz20d5LewPDXzcJQA=
X-Received: by 2002:ac2:47e3:0:b0:511:19f4:e24f with SMTP id
 b3-20020ac247e3000000b0051119f4e24fmr2792168lfp.47.1707672411155; Sun, 11 Feb
 2024 09:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20240210120709.938286-1-igor.opaniuk@foundries.io>
 <20240211003712.GB3040305@bill-the-cat>
In-Reply-To: <20240211003712.GB3040305@bill-the-cat>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Sun, 11 Feb 2024 18:26:39 +0100
Message-ID: <CAL6CDMFVEUFqehatU=WJWRtyaDR+Wz0PGY6pRx=nMC9duoj+AQ@mail.gmail.com>
Subject: Re: [PATCH v1] armv8: crypto: SHA-512 using ARMv8 Crypto Extensions
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ard Biesheuvel <ardb@kernel.org>, 
 Loic Poulain <loic.poulain@linaro.org>, Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Marc Zyngier <maz@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Qu Wenruo <wqu@suse.com>, 
 Simon Glass <sjg@chromium.org>, "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
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

Hi Tom,

On Sun, Feb 11, 2024 at 1:37=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Sat, Feb 10, 2024 at 01:07:09PM +0100, Igor Opaniuk wrote:
>
> > From: Igor Opaniuk <igor.opaniuk@gmail.com>
> >
> > Add support for the SHA-512 Secure Hash Algorithm which uses ARMv8 Cryp=
to
> > Extensions. The CPU should support ARMv8.2 instruction set and implemen=
t
> > SHA512H, SHA512H2, SHA512SU0, and SHA512SU1 instructions.
> >
> > This information can be obtained from ID_AA64ISAR0_EL1 (AArch64 Instruc=
tion
> > Set Attribute Register 0), bits [15:12] should be 0b0010 [1], that
> > indicates support for SHA512* instructions in AArch64 state. As not all
> > ARMv8-base SoCs support that, ARMV8_CE_SHA512 is left disabled by
> > default for now.
> >
> > Tested in QEMU for ARMv8 with compiled-in SHA-2 support.
> > Even on emulated cpu the hashing speed increase was visible:
> >
> > With CE usage:
> > =3D> time hash sha512 0x40200000 0x2000000
> > Calculate hash
> > Calculate hash
> > sha512 for 40200000 ... 421fffff =3D=3D> 1aeae269f4eb7c37...
> >
> > time: 0.215 seconds
> >
> > Without CE usage:
> > =3D> time hash sha512 0x40200000 0x2000000
> > sha512 for 40200000 ... 421fffff =3D=3D> 1aeae269f4eb7c37...
> >
> > time: 0.356 seconds
> >
> > Real HW tests should provide much more improvement and objective result=
s
> > with 10x speed increase at least.
> >
> > The implementation is based on original implementation from Ard Biesheu=
vel in
> > Linux kernel [2]
> >
> > [1] https://developer.arm.com/documentation/ddi0601/2023-12/AArch64-Reg=
isters/ID-AA64ISAR0-EL1--AArch64-Instruction-Set-Attribute-Register-0
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/arch/arm/crypto/sha2-ce-core.S
> >
> > CC: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > CC: Loic Poulain <loic.poulain@linaro.org>
> > Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
> [snip]
> > diff --git a/arch/arm/cpu/armv8/Kconfig b/arch/arm/cpu/armv8/Kconfig
> > index 9f0fb369f7..fd5c26421b 100644
> > --- a/arch/arm/cpu/armv8/Kconfig
> > +++ b/arch/arm/cpu/armv8/Kconfig
> > @@ -204,6 +204,11 @@ config ARMV8_CE_SHA256
> >       bool "SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
> >       default y if SHA256
> >
> > +config ARMV8_CE_SHA512
> > +     bool "SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
> > +     depends on SHA512
> > +     default n
>
> Like the sha256 one, this should be default y I think, the performance
> improvement is likely worth the size increase.
That was done on purpose, as SHA512* instructions (comparing to SHA256*)
were introduced only in ARMv8.2-A, and most of the currently supported ARMv=
8
SoCs in U-Boot don't support it.
We probably would end up with most of them reporting Synchronous
Abort crashes.

As Marc suggested in the previous email, we should have
both versions compiled-in (sw and hw-accelerated) and dynamic selection of
proper version in runtime based on CPU capabilities, and I plan to
address that in future in a separate patch series.

>
> --
> Tom

Regards,
Igor

--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io

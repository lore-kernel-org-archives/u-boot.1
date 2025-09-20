Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03B3CCAC5A0
	for <u-boot@archiver.kernel.org>; Sat, 20 Sep 2025 05:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4CF24833E9;
	Sat, 20 Sep 2025 07:10:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LO3Bme80";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A1A982A9E; Sat, 20 Sep 2025 04:54:38 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCC4D8003E
 for <u-boot@lists.denx.de>; Sat, 20 Sep 2025 04:54:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chalianis1@gmail.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-32eb45ab7a0so2575301a91.0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 19:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758336874; x=1758941674; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1G+kmRkHQJfVQONBkVPyf3dGIeBs7Op9gRo3iaO1ncU=;
 b=LO3Bme80aPUNx49E9A1ntwz6JuuVGqqG7FuZ6zSbPh8prHFJ2M1wfwAgLJ/QqmoY8Y
 hj+7NILTHgrPuhDLUNaZ3gaAJXS79bXztXKVW8kSc4SuPV8hYFrhN8MdG8+a2AfuZEFi
 S/XKN/yvkrPmuYILiE3awjHG4HRRAwEHlUGzOZvZPpAumwr+I1YW4nf7FuYKdw0x8HB/
 87GO9NzbSzW6PwagSirxUhLP9V5CSJhWF+/n4yeqoLV8RJu3oKbTjvQ3kH93jVRugXch
 uPUJkPBEyIM/phFw2gmpcJEFWi89LJ1YUJaocOXzc7HFE1KL7Ebs+ckaacmk4ZbxZ6tY
 UWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758336874; x=1758941674;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1G+kmRkHQJfVQONBkVPyf3dGIeBs7Op9gRo3iaO1ncU=;
 b=KVqS3ABEd29ED3E6DLuzRuCY1uODjQ65NLLnwG2kSDOMNrcp3j5obRZ0mcMYiomae6
 yhOM7fOpUYmTEUlFsaXJFee3IHuCQDDTGNxEzPHcr63YDePmi49MZ5jwPgkOjFBlIfvj
 69WXHVCK6KLWrYGcpVcZ+5byylE0mz4wDhtgN1KZfnATMZNkB0zBzYN1EaYNkVN2qylb
 FaWu/dG3VTA9RGoAiq5rEAVlWLpJfZluCJjWO0qNsg1nuNEXR4BGXVOrOWS+V2BzNnnu
 lX3E8ZGVmJe4VxK0EHuMH5eHt9WGEkT0lBJJ4tNocF48/c8n/sy068UgnJe0ersb/pVh
 fcDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/5UOcuaGB0SVsEt0HXzd8uR9PtjTmtiHq5TeNEOeWRDutV0g8Abb/Cjxbr9H8DJ69nZJ/6ZQ=@lists.denx.de
X-Gm-Message-State: AOJu0YwnMTVMa4UBBPpfc6PtagmzkmVv5cz/pw+dKA6smfpsTw84xBDn
 ogCPlqMuZoS7A/OKi6tYQssloreQc/GOk5hml8r8kH7frIvgUgKNAqlxJFVZ99RWOEGP8VT6o+8
 j4Rar85l0BkPhgh3tvrkXCjFVz8OThzo=
X-Gm-Gg: ASbGncuPfCRg7VENq1rwDzmwqglDKD5Dx6ehPNEa4V6zOYTxPGnt8KUeIX0H9NbJP8g
 nWirW3BTF05rkHZWGd4Pidx0VcjVXA2W/gihvHtD9CGsGhvC5NzvWi+nnWruZKPg75SmV/i6Ssf
 YRnZJLJ7b87peSKVQvY/THt168EiXVIUITfp4Ex3bK5ZCg4xLFZ+NbtxhPdAUtcYqsIwP2hIREg
 W+OJqzV2ln/jCk59ZVEOj3rL5suZAvXNp5yTPqAwcxX9NvWE54stpP65wenZ7LslDC7JA==
X-Google-Smtp-Source: AGHT+IE8AeV/RwOwkpIITrsRfBJhfLBYgYNWsMPLAzFiV1jdmG4/ZofoLqLJ+2fXqoiXtHtluic9YCVJaHKLSrWWdHY=
X-Received: by 2002:a17:902:d50c:b0:26e:49e3:55f0 with SMTP id
 d9443c01a7336-26e49e38a46mr35626155ad.16.1758336874265; Fri, 19 Sep 2025
 19:54:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250919222424.95815-1-chalianis1@gmail.com>
 <CAEfUkUJmMh3dHJRhRxJZHe6b44b+59K6+H1UoruEZqXQDiL9iQ@mail.gmail.com>
In-Reply-To: <CAEfUkUJmMh3dHJRhRxJZHe6b44b+59K6+H1UoruEZqXQDiL9iQ@mail.gmail.com>
From: anis chali <chalianis1@gmail.com>
Date: Fri, 19 Sep 2025 22:54:22 -0400
X-Gm-Features: AS18NWAazTIZxJ65UWrzg2W1szElcy4iWLSdUVp9qK4QHA5RZYJHjFjIMtKGJts
Message-ID: <CAL+1fyDSaoLudm4_cqAzL+1AWp2D2pp5M2dNxcQNbwQ31s0wcQ@mail.gmail.com>
Subject: Re: [PATCH] arm: mach-qemu: add support for qemu booted from TF-A.
To: Raymond Mao <raymond.mao@linaro.org>
Cc: trini@konsulko.com, patrick.rudolph@9elements.com, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 20 Sep 2025 07:10:46 +0200
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

Okay thenk you for feedback. I will check this next week, I will
reformat the patch, concerning the second point for efi capsules
I didn't consider it, for me u-boot didn't support to run as an efi
application in arm64 systems but it is interesting to know that.

Regards.
Anis.


Le ven. 19 sept. 2025 =C3=A0 20:37, Raymond Mao <raymond.mao@linaro.org> a =
=C3=A9crit :
>
> Hi,
>
> On Fri, 19 Sept 2025 at 18:24, <chalianis1@gmail.com> wrote:
> >
> > From: Chali Anis <chalianis1@gmail.com>
> >
> > add the ability to be booted from Arm Trusted Firmware for qemu aarch64=
,
> > to do so we need to skip NOR flash partition setup.
> > U-boot launched as BL33 from TF-A is supported and Tested on arm64 with
> > qemu-system-aarch64 and the qemu ARM64 support ARCH_SUPPORT_TFABOOT.
> >
> Actually the patch is trying to skip part of the initialization when
> U-Boot is running as BL33, so the statement like "add the ability to
> be booted...", "U-boot launched as BL33 from TF-A is supported" won't
> help as U-Boot is working as BL33 already.
>
> > Signed-off-by: Chali Anis <chalianis1@gmail.com>
> > ---
> >  arch/arm/mach-qemu/Kconfig             | 1 +
> >  board/emulation/common/qemu_mtdparts.c | 2 ++
> >  2 files changed, 3 insertions(+)
> >
> > diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
> > index 9c06c6a3a5ce..316dde5145c0 100644
> > --- a/arch/arm/mach-qemu/Kconfig
> > +++ b/arch/arm/mach-qemu/Kconfig
> > @@ -18,6 +18,7 @@ config TARGET_QEMU_ARM_64BIT
> >         bool "ARMv8, 64bit"
> >         select ARM64
> >         select BOARD_LATE_INIT
> > +       select ARCH_SUPPORT_TFABOOT
> >
> >  config TARGET_QEMU_ARM_SBSA
> >         bool "SBSA Reference"
> > diff --git a/board/emulation/common/qemu_mtdparts.c b/board/emulation/c=
ommon/qemu_mtdparts.c
> > index c1501276789c..c3863d3b0479 100644
> > --- a/board/emulation/common/qemu_mtdparts.c
> > +++ b/board/emulation/common/qemu_mtdparts.c
> > @@ -59,6 +59,7 @@ void board_mtdparts_default(const char **mtdids, cons=
t char **mtdparts)
> >                         debug("mtd device =3D %s\n", dev->name);
> >                 }
> >
> > +#ifndef CONFIG_TFABOOT
> >                 mtd =3D get_mtd_device_nm("nor0");
> >                 if (!IS_ERR_OR_NULL(mtd)) {
> >                         mtd_partition =3D CONFIG_MTDPARTS_NOR0;
> > @@ -72,6 +73,7 @@ void board_mtdparts_default(const char **mtdids, cons=
t char **mtdparts)
> >                         board_get_mtdparts("nor1", mtd_partition, ids, =
parts);
> >                         put_mtd_device(mtd);
> >                 }
> > +#endif
> >
>
> Skipping the default NOR mtdparts when TFABOOT is selected looks fine.
> However, qemu_dfu.c still sets dfu_alt_info based on those NOR
> partitions (used by DFU/EFI capsule flows).
>
> This actually brings one concern related to capsule update: currently
> the QEMU ARM64 board depends on mtdparts to make EFI capsule update
> work.
> It raises a question: do we actually want to support capsule update
> when U-Boot is running as BL33?
> If yes, then the current patch breaks capsule update and more work is nee=
ded.
> If no, we should make it explicit (e.g. prevent
> EFI_CAPSULE_FIRMWARE_MANAGEMENT from being selected together with
> TFABOOT).
>
> BTW, can you please add a rev number in the subject line? E.g. [PATCH
> v2], [PATCH v3]... See the patterns from other patches.
>
> Regards,
> Raymond
>
> >         }
> >
> >         mtd_initialized =3D true;
> > --
> > 2.34.1
> >

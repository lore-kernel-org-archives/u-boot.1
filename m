Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E6CECD6EE
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 22:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B74E783A47;
	Wed, 11 Feb 2026 23:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TwIXQAIb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5294C83CB5; Wed, 11 Feb 2026 23:13:52 +0100 (CET)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE1378388D
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 23:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-567404384b7so1413009e0c.3
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 14:13:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770848029; cv=none;
 d=google.com; s=arc-20240605;
 b=Kh3+mHKwTrlwxXLdXxFXTQW4mJ4cUHNPsm4OLyD0V9o8RaUKtxYYZLtnRJU1q1hWxb
 AMbbRcOYwgoJFWqfZAadcUcrN4Vilo6vn0x1rfw+927vxRkotnJagJA45DG8YDnJtJ+3
 77i1RVVhZnDPdZM4Py/dpD4ufrJ3U7Idgqg5sw8ROzdHTsGaqIujwB6U4htEZ9ajGlcW
 edK6NY88B+yA4Dyju2ZB1HJfemgjsI7405aCKdQ5flkwcFT3yAzLZYoYZMshlcj93VDI
 963cjNoomOsK7UCGcIeCdE9gow7IR7E+0dIcLMivbYlTWV+pd1gp+qD3rYsvGT9ujmFp
 1IjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=StWof2beLbzRs03kyeqOfctlLThUd6iOWa0Dx9fQQ9Q=;
 fh=AHKfqmIW5Kp7yQpLzCHKDiaVP4X1t5uS9hW/XnOqTRk=;
 b=VAxe8h7xeZaSpzE0w4nMfJw9oYdff4sW/e+DHNMtRLsz2pzJPKPisuXQbhwD+Dhpym
 pEDjTApQZwUvBdS3gpu4TfoaFGixP0pVX7k1tI8pHJ/mB4C5SyrHAwQcjqJ2t1Tfr6K/
 cN86hkiq+yFNUmxHNcguv7vTmsA/j2yWDp+psebo380Zn+nJWvjJd3lhJ8BZBFRyYZ4j
 d3wbeUPweZ6FJPHWRpdMzEekgBy7DCsxvxKEK994q5U7WTrFFvmbnu2XcXNi6C9gIwdC
 T7QSckTbei0muHBGeU2TJikIN+TaPdWCTm/E4P4twEcuCh3ECo31sx/N5oHnc19syc0l
 P4uQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770848029; x=1771452829; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=StWof2beLbzRs03kyeqOfctlLThUd6iOWa0Dx9fQQ9Q=;
 b=TwIXQAIbI5Dc1d9joQXvStaEGuINI9wxFSIbYUlO7BHs29SReUMhm88bc2QxLnEXjw
 wmGQYXqyEeVQYXbPtySLHqs77Xngp5zFP3NMKrhpgxHiv9UD+6CRL1Ha4tBfPEwbHu3N
 VR3RS4fm5sZEtJ9uxB3L5XVH1r8I5u4Adjawh1G/olMRWrtIBfB9+K40+k9hLTAcTqKZ
 55AKSvH6rfLMtYDWZUOY0wlzku7YT5C8kZLa82Qw/aRIaiJPFagYibuCT/3tVfg0DDdU
 1suhGBboBOpwpk/0ETH3UMZrGzioXchqM2STOfj69YqMxm6rJUuw9EHJAv6ju9K2ta5X
 O+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848029; x=1771452829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=StWof2beLbzRs03kyeqOfctlLThUd6iOWa0Dx9fQQ9Q=;
 b=tpiNeDbBQ8nchSxwDwl34lEbTJgvnkeHZqelErEfodsH0hgQxOO62Fbzvyr+7/X/d3
 u7TLKQNviZlWUEb2VxeUtmLnopEltXqJI24HZsHPOGfDjRWcM0CTkNjHmo0ycdD72awV
 p4BB9Alnte2fkp7lNcFiTqgEZnjMNOH8mTwbXLzRgoFqW2jTmc1IqtGfY2BFXiwfhT25
 oZYBFMkSXV4H8P/xCZdc0hkV7hTcfZaEcgAXOj7O0WH68HgGEI89jaiNBO4tydCEQnLv
 XX0Iwod6Bo9SuU4dRRz2qBt0Pjk7fB4ZECXcn7QRkTvsaOvmknbGFk6YevgNHIwwDi3C
 XHKg==
X-Gm-Message-State: AOJu0YxWCfhSOGay3tiPjqgVEWo1TFlPGNrl43vytufo24BvoQ6m3Mwt
 eEyHQxMYGszkwSrsynwOoaFB6RFJhm/X3W4mD838boAN+MmIYVWcR2CMhOcRmnHZqsNU7VPAuno
 0+h0Cv4+BtEGDpAhULu35PAyfLdZSfLk=
X-Gm-Gg: AZuq6aIWHBkbfGacM/bxBy0KZpR6au8nJj9DZ5vEdf3zkeZKQt27rd7HMhfblzoegRs
 4LH80i8OV6Z7rG37I+Jm3dfIwc6cv1Zej60VsKixOmMeOOI2wMvY5AC2ua/gzaTqEfXyESgw7Y6
 8zvDIvDZqKyi9qdVJ3Bf47jkVoYMc83Euh0ALq77DYGfJZ0IvG6SXBa/0UxU68q7ESR5hkNAJ7a
 gkBQNBihlDtTvmPkTSIBSBI8lzfhbu8g9/f2mOhWa2/MNV2Ggjzjip6Lztuoq7M85WxXtKWyMZi
 zUeiWQPqGSQKVmGA54U2ELu4o3LIQRLh8xJFcKkmRPSg4zDzEiBoNYNzuKglpMxWAdYnYrGYZoY
 kweQ=
X-Received: by 2002:a05:6122:3382:b0:566:341b:4ddd with SMTP id
 71dfb90a1353d-56759bb3081mr228707e0c.0.1770848028689; Wed, 11 Feb 2026
 14:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20260211021351.2678571-1-james.hilliard1@gmail.com>
 <4fa526c355abda8ed5ad0c88f99d215a7615a977.camel@microchip.com>
In-Reply-To: <4fa526c355abda8ed5ad0c88f99d215a7615a977.camel@microchip.com>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Wed, 11 Feb 2026 15:13:37 -0700
X-Gm-Features: AZwV_QiGmJiArpQ_-Slczk-PGJ92PRb0JuNKwwSe-tuYaM_Iy6Zl0tWGCvXMYuA
Message-ID: <CADvTj4qVOgLXeO0w+MzpRukr-gafqys7t_UA5i-Y=ffEsc8Kfw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
To: Jamie.Gibbons@microchip.com
Cc: u-boot@lists.denx.de, quentin.schulz@cherry.de, trini@konsulko.com, 
 marek.vasut+renesas@mailbox.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 11 Feb 2026 23:21:15 +0100
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

On Wed, Feb 11, 2026 at 5:29=E2=80=AFAM <Jamie.Gibbons@microchip.com> wrote=
:
>
> Hi James,
>
> On Tue, 2026-02-10 at 19:13 -0700, James Hilliard wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > know the content is safe
> >
> > libfdt expects FDT/DTO blobs to be 8-byte aligned. When loading the
> > base FDT or overlays from a FIT, the mapped buffer may be unaligned,
> > which can break fdt_open_into() on strict-alignment architectures.
> >
> > boot_get_fdt_fit() relocates the base FDT with boot_relocate_fdt()
> > before applying overlays. That uses the bootm memory map and can
> > overlap with the FIT buffer when the FIT is loaded into RAM,
> > corrupting data needed to load the kernel and ramdisk.
> >
> > Allocate writable, 8-byte aligned copies of the base FDT and overlays
> > with memalign() and fdt_open_into(). Grow the base buffer as needed,
> > apply overlays to it and pack the final tree. Free each temporary
> > overlay copy after application and check fdt_pack() errors.
> >
> I am looking to test this patch but unfortunately it fails to apply at
> boot/image-fit.c:2465 for me. I have tried both master and next
> branches. What base are you working from?

Oh, it was a random slightly older commit I think, I went ahead
and rebased it on master here:
https://patchwork.ozlabs.org/project/uboot/patch/20260211180645.3313596-1-j=
ames.hilliard1@gmail.com/

>
> Thanks,
> Jamie.
> > Fixes: 8fbcc0e0e839 ("boot: Assure FDT is always 8-byte aligned")
> > Fixes: 881f0b77dc8c ("image: apply FDTOs on FDT image node")
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > Cc: Jamie Gibbons <Jamie.Gibbons@microchip.com>
> > ---
> > Changes v1 -> v2:
> >   - also fix alignment issues
> > Changes v2 -> v3:
> >   - do not print on -ENOMEM errors
> >   - let boot_get_fdt_fit_into_buffer() reuse buffers and handle
> > rounding
> > ---
> >  boot/image-fit.c | 161 ++++++++++++++++++++++++++++++++++++---------
> > --
> >  1 file changed, 124 insertions(+), 37 deletions(-)
> >
> > diff --git a/boot/image-fit.c b/boot/image-fit.c
> > index 41ab1f552b0..09a57bbb670 100644
> > --- a/boot/image-fit.c
> > +++ b/boot/image-fit.c

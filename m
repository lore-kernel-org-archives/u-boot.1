Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E39E6BF2A
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 16:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8589844F4;
	Fri, 30 Jan 2026 17:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gGN8OopV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99A688450D; Fri, 30 Jan 2026 17:50:35 +0100 (CET)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 618DE844F1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 17:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-45c819ca0f1so1411094b6e.0
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 08:50:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769791832; cv=none;
 d=google.com; s=arc-20240605;
 b=SvZWv4WkzQrpwazLhhjIcMd7m8ev7YlzrNAOZ8Ru4///FTD/7BQ4TzSdotlFH+bPEc
 A1qnHoQTpiPqp8fDmjKpfjxKHQQ4XpgO0T+imQg/vGqjvEesqf7VlGYk97ml79zYP9WU
 7vQ7KmHUcUMhXr8zv29FWv7GgPJNxx0b2mQYqKCLVTkrcc2NNEWVEg4YLSJSGP4uWdSR
 EZomncDoiKpF3j1dRlKGKj9AQaPMSgt7JcJCXBTQRUTyN4DcXvHiTJaIDbJeT9weQLAq
 o8HO3oqFDUB8xYAOWSagaSbIUvH9TIzkcQu1ACUnUhOdHJL8sDUsNux+7p+meS9ws8Kj
 hp0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SdKQcV12GEEzICx2+PbnzdKr3aeWqBiTLMZtDtPCBp0=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=T+FJhU9TSCP0uaLN+cvlX7xWzEHJzE5AvYkb4s41ZL+OsfgS8xeWBE4Wh06vuMJd53
 caZbQJxa2xIM3q/N0tcrGrS+JDeixCokFp+B3nLYel5UdMWyyA2oeXxoXfsZ7CiV17ar
 CVYLJvKHyM+IlpkIKa9iPNTYD0M0ZilDY4j/zc5VkbZC3SupbfBR9h6dAfkCzFPMJlA2
 w3vIPPlEieoblK3Xboqb5xMwIXxd7CD5gyqAxieULEPlviXuttygJwtcEjlL1VVj/IO6
 hQeAE8n7qi9TbuVvxg80peXkaY94hdzBFTigt8ozdiJ0m5F8Q+DHBQYz7xJpfCY65SGe
 m3fQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769791832; x=1770396632; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SdKQcV12GEEzICx2+PbnzdKr3aeWqBiTLMZtDtPCBp0=;
 b=gGN8OopV54vRb76mlEhw4VzHdBLOlVnSjc2GoP3t8Q2hC0ucwvhmA2dTEpIdzlrAJ3
 51YBhC2mbrJXEATAdNhYc/1lsm02s/4/KaM6cSh3b7YnJPNhiUsyLX8PY9bn1vNjVzhN
 st310Ye9GstiXUyn6gjg4S1YaPyrj+7VTyIE0frZhPpZk09C+Dkgn+drLFEFylVMZlm0
 c346ER5S6YfCkiX3/HiUaiRGyyu8qaXlY8De2z7xJE0lEkIL1Fnl+yVSWBl6WyC54myj
 rp70p1tMrHF/RxxoccUfYqrfwR46mPVk+95aMKLxEGY/B5xbFrri3OMNGtPW7y9RC2zU
 TUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769791832; x=1770396632;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SdKQcV12GEEzICx2+PbnzdKr3aeWqBiTLMZtDtPCBp0=;
 b=gXXferYYz4G6BotUACYyUSG6aZBaTxaEcNBqiNIU5N1KG6/Hi9QqtnV3W+sXaZJGt2
 b8YA0FF5xJW/9xFVZoOcDgh+pF6WqgSMUkdroRYzcsznTTbd+cjk85rRcqyox+Frad+7
 XHmLh4DvGEmUCSMaO0nMof2b8OCI9fvfN8ysKX6okG3XQsdQjVd0BPKgVvaVfsz1V1kC
 CkRwjuVAE7ViBriKsgXfgsr+SGRxvPK+ezd+Ze00twJRNF1qhcafuCd6cMp1QXlOUQd8
 bG4ncG5q8puqbT4prh6Rp+Ml9yKVQPNNrJarhmyo23bj7A3owoD7uyQvUGqOfyczD6rD
 VFHw==
X-Gm-Message-State: AOJu0YxjeQZIP08B4IXW7r/uLhljWr1hMHw6IVHXyV7kNssCozVKl4mJ
 xFMJnqP0uppAJxqFFl0XGBLpRxJHxOiULBBaUOz2eWSu6cUIgRLo25/M/ZdBTJo9h5W4ApHYpgK
 fEjVKPVXmJCspALXm0qym/Jnj4HJtmKM=
X-Gm-Gg: AZuq6aL6+jxW1SCy0XeRCeyCJ8sQ1a0o3EvRei5Ed0B9VaAVkHRb8M84kO6yQpZFaJp
 sd1NkqadxorZ0Z9l8BN2Zjzd/aiwfc6fzZAyb16VnvtCo+aoWkhf2E11xPj5dHvVzcwW0tsGmme
 47zZmjZ+FE+zMImJIPIBKu90e/V4CvgaGol7MzIs9nApRM/tdPWVCAIr46FhTspLAYBLYqkcBiF
 0IbGuyW91YcLQZG4AmUJ4tzAzxRnt5+FHcHeJPm6ZTeKzWHasRDnVjJRSDMTzB4ydGoMC1T
X-Received: by 2002:a05:6808:10d3:b0:45a:6e83:fbff with SMTP id
 5614622812f47-45f1e3c76acmr3451607b6e.20.1769791828499; Fri, 30 Jan 2026
 08:50:28 -0800 (PST)
MIME-Version: 1.0
References: <20260130031217.998002-1-briansune@gmail.com>
 <20260130145528.GA2421612@bill-the-cat>
In-Reply-To: <20260130145528.GA2421612@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 31 Jan 2026 00:50:17 +0800
X-Gm-Features: AZwV_Qin5nzIEIpV1YefyUGRtsWO7uBgmKkJ3u88nwGfStZVf5niIiV_3qSQoA0
Message-ID: <CAN7C2SCixc3Ug+MsfMj5wnJVVPQSa3QS7frkXvj90LsY09ehQg@mail.gmail.com>
Subject: Re: [PATCH v1] Fix unbootable ARMv7 devices
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, Jan 30, 2026 at 10:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 11:12:17AM +0800, Brian Sune wrote:
>
> > The linker script u-boot-spl.lds now
> > is no longer aligned and -nodtb.bin ending shows
> > the zeros are not 8 byte aligned. This result in
> > the Makefile.xpl simply think the previous file
> > is aligned and do not zero pad. simply fix the
> > data align to 8 can ensure the -nodtb.bin is aligned,
> > hence, the formation of u-boot-spl.bin properly align.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >  arch/arm/cpu/u-boot-spl.lds | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This fixes your problem in that it results in the device tree being
> aligned still, but doesn't solve the underlying problem of why there

No it is not 4 extra bytes but 4 bytes short on the latest master commits.

> were 4 extra bytes. Can you please try:
>
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index c578c3ebf821..5f807323f856 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -31,16 +31,16 @@ SECTIONS
>                 *(.data*)
>         }
>
> -       . =3D ALIGN(4);
> -       __u_boot_list : {
> -               KEEP(*(SORT(__u_boot_list*)));
> -       }
> -
>         . =3D ALIGN(4);
>         .binman_sym_table : {
>                 __binman_sym_start =3D .;
>                 KEEP(*(SORT(.binman_sym*)));
>                 __binman_sym_end =3D .;
> +       }
> +
> +       . =3D ALIGN(4);
> +       __u_boot_list : {
> +               KEEP(*(SORT(__u_boot_list*)));
>                 . =3D ALIGN(8);
>         }
>

This patch will create the same result but the actual problem
never caused by the -pad.bin.

The bss size is 8 byte aligned hence it will not be the issue from
first place at Makefile.xpl as it will not create any zero pad.

The issue here is that the nodtb size itself size is never 8 byte
aligned at the end result in short or long cases while the
Makefile.xpl only creates extra zero based on the bss size rather than
the nodtb size.

Then they simply join nodtb + pad + bss but from first place nodtb
is not sized correctly at the end aka 8 byte sized.

Any method that can make the end back to 8 byte size of the nodtb
should do the job.

> As the problem ends up being that when both of these are true:
> - .binman_sym_table is empty of actual .binman_sym* symbols
> - The inner '. =3D ALIGN(8);' increments the linker counter from the
>   previous '. =3D ALIGN(4);' (in other words we were not already 8b
>   aligned).

So what you are suggesting is that the section of  binman_sym_table
is empty so the ALIGN(8) just simply cannot do its 8 byte alignment job.

And reversing the order makes sure it will always ALIGN end with 8.
But does "__u_boot_list" result in an empty case? If not then this
indeed do what I also wanted to.

I intended not to change any ordering to fix the issue.

Brian

>
> The linker sets the type for this section to "NOBITS" which in turn
> means that when we later call objcopy to create u-boot-spl-nodtb.bin we
> get a mismatch between our expected size and actual size for creating
> the -pad.bin file.
>
> --
> Tom

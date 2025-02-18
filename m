Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC4E3C021AA
	for <u-boot@archiver.kernel.org>; Wed, 19 Feb 2025 02:07:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20CDB80EC0;
	Wed, 19 Feb 2025 03:07:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eRcdm+gQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBD980EC0; Wed, 19 Feb 2025 00:24:22 +0100 (CET)
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com
 [IPv6:2607:f8b0:4864:20::e2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51FA780BAE
 for <u-boot@lists.denx.de>; Wed, 19 Feb 2025 00:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jonathanbaror@gmail.com
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-4be707fffbcso525064137.0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 15:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739921059; x=1740525859; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BUcIIT81Q9EqNr26lF9JwrIC3STe9TheYmssfKk+hR8=;
 b=eRcdm+gQYGv/sodYNbvqCaowWmNjkhXV/BWdnOo2IOjDarcNkWWBZzTKE0x7c6Npxq
 2oy3cJioZVIcBp7QAlECtZxK/R2w6Mz8QhvqWGPQFIn3IjkGXVWSzTHc3EOu+xFkzaLP
 XeSb6tkC4zKQ4JDBVUgYleEjc0A3PH01GP5JpUmF+pRADWFiprvE4/wkbOt15D1YlEdl
 D6lyjgnKUg0yXrglRDt6sKP4RTfOqXicxUt2ceQpy+HmSsDG/5S0rVfFqKMix8xuchqt
 DmKBcezAwUnwdAfmXVWMDK9aJD09nW8AzQ50mI9+2FQUHk6edIwIdw7X9hapFa4XeoLS
 YHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739921059; x=1740525859;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUcIIT81Q9EqNr26lF9JwrIC3STe9TheYmssfKk+hR8=;
 b=J/rKe6OnAExTUHRqBwonuYPN4cwVTOhl0p6CTkwJ1qZanQj/p0Ko16w2suURT3SJIJ
 G9v08l0Dp1GxbObgLD2GnSNuqbNkdRAbV8p7XBFB4GAx3Oi/UvUMVmE+TaKaCgjKxbiX
 oMPBvi1DCrzGHaNPEPrWE/GVw4jAItq32cev1GIgeDJ9DTb6rQ8ziVXeut/G9H9KKguD
 EK64NKAAmyMp/h5s0CdHjkkKg6trGRWSI9lTO0mcF4Mu3Bc5fMBOd5t9oavPP9w6vTLf
 ewgQIAxmeJVOTPFMVg0xoHlynBu9jsrd9kNleMjdtgfS7twNykWhmZsJi1MHx/6+yVBj
 WBxw==
X-Gm-Message-State: AOJu0Yw08xYxhbXWSI/i84Megpf3LKrFFpT+O9ZjIKoU9nwcAHqFUhCF
 E06ljQ3h9P6+umDYgQwnCCoRGv72ib6QDP1YVNcnx4dXwx6TAyIfcdyZQCv6MGinGTkEnD0cD0g
 7YjR1ZcQ2IZlQuM6hKFoqZLTG/RY=
X-Gm-Gg: ASbGncvmALXb4v01EwobFxMPlj72VWXpyxkUCzotskrKjML6NMmCQZJArq8laT8BqlC
 JUWEYvlPnS7B1q65jaKlI2m75ysft4UuT/oUgnXLK5mfF/N2uM5flu7OGO86+DqfWesKQvcfop4
 dLkHr0MzdJIALILNWOuOxGlUfPLfGt
X-Google-Smtp-Source: AGHT+IHtYQsXFov1L2TbI+t5HjiY6Kp0e2zRm46BC+bquxNfvBXEnqKtGzza1mKZAFDkECZ4y9Qyf9dOcqVOTrkoc68=
X-Received: by 2002:a05:6102:5e91:b0:4bc:ad3:a697 with SMTP id
 ada2fe7eead31-4bd3febe5bbmr9960033137.23.1739921058993; Tue, 18 Feb 2025
 15:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20250213112847.1848317-1-hsiangkao@linux.alibaba.com>
 <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
In-Reply-To: <173990731183.1542939.8486402584511743095.b4-ty@konsulko.com>
From: Jonathan Bar Or <jonathanbaror@gmail.com>
Date: Tue, 18 Feb 2025 15:24:08 -0800
X-Gm-Features: AWEUYZmCHIgTo2Wf9BUm-soMSznhzMKrrldhFQufQNAq9KyqWClXGI9cvAOoA3c
Message-ID: <CABMsoEF3xcbpFXMAYW-ZzQUfZp3zVf8FsKmtxQ7wfVxu3zjOcA@mail.gmail.com>
Subject: Re: [PATCH v2] fs/erofs: fix an integer overflow in symlink resolution
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Gao Xiang <hsiangkao@linux.alibaba.com>, 
 linux-erofs@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Feb 2025 03:07:27 +0100
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

That's great! Thank you for your work!

Any expected fixes on the other issues I raised Tom?
I'm asking specifically because GRUB2 maintainers are working on
solving very similar issues in their repository for SquashFS (being
rolled out right now).
It'd be best to solve ASAP as people might realize the similarities
between GRUB2 and U-boot in that module.

Best regards,
           Jonathan

On Tue, Feb 18, 2025 at 11:35=E2=80=AFAM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Thu, 13 Feb 2025 19:28:47 +0800, Gao Xiang wrote:
>
> > See the original report [1], otherwise len + 1 will be overflowed.
> >
> > Note that EROFS archive can record arbitary symlink sizes in principle,
> > so we don't assume a short number like 4096.
> >
> > [1] https://lore.kernel.org/r/20250210164151.GN1233568@bill-the-cat
> >
> > [...]
>
> Applied to u-boot/master, thanks!
>
> --
> Tom
>
>

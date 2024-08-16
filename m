Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76682C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 16:49:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 982D088B6D;
	Fri, 16 Aug 2024 18:49:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jnd3e99v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B11DF88B83; Fri, 16 Aug 2024 18:49:20 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A144188A99
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 18:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-368440b073bso1202016f8f.0
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723826954; x=1724431754; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gjoTAoFnbfjcYETe2o7K9loyhEn2KZxwP78OP4cMS4c=;
 b=jnd3e99vHgdob5YiNsSIPTGbn05DRGSWiKmB1Gqf5OAu9PZVYivhdYQ2aIYsNqko9p
 sMNz/9LMkGgILDqLWD8qJhr3PgKGSjZnJ2uwxSv+pbUzlkP8mDYKjGQKseFqNrEeQ1DX
 +3DJY4pcr2yrA9eWoaTjVZcYv8d/cu8JYLT2iFhbta5ZERDRMjjlP1DeiMObE6QSv78K
 Y+M22gX2IshJsSsYi1J0TIjqQ6Q25stJjyrGZAVZxvE7nM6PNoBbpzppQBWCdlftAVpN
 4k3Pt3NnCQqGgJrXiwk++68Yh6qBPRIU+dtYwdnt8MUp2eOB7HJSOS/0+O9hz8fZ6FWN
 IZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723826954; x=1724431754;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gjoTAoFnbfjcYETe2o7K9loyhEn2KZxwP78OP4cMS4c=;
 b=WuJT/cyvPKip6c/G1IW2kGQz5vfEjnOSVSZKhdYK8YeOTWihWlno85M+u98/B1zXgT
 Y3seWnDmuf421P4kc0Xvu/8jxKWBRMK7FENJPfimRJPMpqzAgnGgaOLf4k7tv3v13TjM
 sPQFyR08Mr0ZfcdhiI6G9Fzr2dK6k3NbPbrRB+2UWC1YHbviqrCn4hsbEA/p27FqGd32
 6LF6ypvuGhnQigNbegUinCHGkAWSDghqnwemkTVjLYSltanfM3Eg/alOLkNZ0jPu4zTY
 GxVAkQGrJx0nrp/fqZa+gChMys9n6Wit+zdmE+V6M1986pNCzTaQbqD+6Vtl9VzaAjzQ
 CMmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaPf4R0ijsLYD7xuoFuOQvshaLznZD5SSm6WuJLa7SBb94ATOrD9zSOHIJQgZI+Dd2HpdYQlDlumluCFyfJmBEHs96Wg==
X-Gm-Message-State: AOJu0YxwvECbdX/f0WkUTdF7qtScos9KK1PlJRbioAPgxjWvMiqLJpkC
 Xq8Cuk0znzpaqmBJqiTXo3CPp7YAP+eLI0FL6L+3lqUw1+nKUBR9L2aRhGL5XV9xWlwtUKSRCbb
 V5P9UTMHnO/lhlChogBtpMqxQVes=
X-Google-Smtp-Source: AGHT+IHMHxrJIcFF4p3hw1M1tcTdma7wTzOq/qvaqYnwWaSOYc3J7ZY0nYuexfKomYKGEKqP2cKR4avUCzCDttZN5GE=
X-Received: by 2002:a05:6000:2a11:b0:371:938c:6f50 with SMTP id
 ffacd0b85a97d-371938c70e7mr3104263f8f.16.1723826954172; Fri, 16 Aug 2024
 09:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240807121024.11318-1-clamor95@gmail.com>
 <20240807121024.11318-2-clamor95@gmail.com>
 <0C2B63EE-A95F-424A-9143-6A0C2164F666@gmx.de>
 <CAPVz0n1CvhkCCNDPSrPvUweBTzTFEUDFHcAP5B7Wno8RefKpPA@mail.gmail.com>
 <20240809220244.GA1626301@bill-the-cat>
 <CAPVz0n3cw3_MrKjHWtrt1mKiDkD4LWcatBHqvKTMna9dKK6KXw@mail.gmail.com>
 <20240812184209.GH1626301@bill-the-cat>
In-Reply-To: <20240812184209.GH1626301@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 16 Aug 2024 19:49:03 +0300
Message-ID: <CAPVz0n1Y5w7K1SWX1y7H+JLcrbgEk90Xg8TiE_BrFYAV==c=uw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] disk: add TegraPT support
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anand Moon <linux.amoon@gmail.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Since there were no objections (apart help Kconfig expansion which I
will add) or improvement suggestions to this patch for over 2 weeks
(first patchset submitted on 01.08.24) I am picking it into Tegra
custodian tree.

=D0=BF=D0=BD, 12 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 21:4=
2 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Aug 10, 2024 at 08:29:57AM +0300, Svyatoslav Ryhel wrote:
>
> > =D1=81=D0=B1, 10 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE =
01:02 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Fri, Aug 09, 2024 at 08:57:03AM +0300, Svyatoslav Ryhel wrote:
> > > > =D0=BF=D1=82, 9 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=
=BE 08:49 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > > >
> > > > >
> > > > >
> > > > > Am 7. August 2024 14:10:24 MESZ schrieb Svyatoslav Ryhel <clamor9=
5@gmail.com>:
> > > > > >TegraPT is compatible with EFI part but it can't pass Protective=
 MBR check.
> > > > > >Skip this check if CONFIG_TEGRA_PARTITION is enabled, storage uc=
lass is MMC
> > > > > >and devnum is 0. Note, eMMC on supported devices MUST be aliased=
 to mmc0.
> > > > >
> > > > > Why wouldn't you use U-Boot's gpt command to fix the non-conforma=
nt partition table?
> > > > >
> > > >
> > > > I would love to, but I am forced to use TegraPT and DON'T modify it=
.
> > > > Tegra114 bootloader is RSA signed and there is no possible way to
> > > > replace it with open source one unless vendor allows this. SO I am
> > > > stuck with vendor bootloader to chainload from which enforces Tegra=
PT
> > > > as well. Modification of existing partition table can irreversibly
> > > > brick the device.
> > >
> > > Can we please incorporate some of this information to the help text, =
so
> > > it's clear what the use case is? Thanks.
> >
> > Sure, though usually those who know what they are dealing with will
> > understand. BTW, Tom, may I pick patchsets assigned to Thierry (tagr)
> > via Tegra custodian tree if they pass? Even if they, apart being
> > related to Tegra, belong to different subsystems (like this patch and,
> > for example, tegra gpio driver changes).
>
> Yes, that's fine.
>
> --
> Tom

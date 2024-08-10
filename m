Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E42BC3DA7F
	for <u-boot@archiver.kernel.org>; Sat, 10 Aug 2024 05:30:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C804F882F0;
	Sat, 10 Aug 2024 07:30:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UoFSN2iP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B37887F5; Sat, 10 Aug 2024 07:30:11 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80BF288113
 for <u-boot@lists.denx.de>; Sat, 10 Aug 2024 07:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso20037555e9.0
 for <u-boot@lists.denx.de>; Fri, 09 Aug 2024 22:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723267809; x=1723872609; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KEYbIQz6f27zTGJmcdMsYyvP+9LCfXGBlVPqoEs+j74=;
 b=UoFSN2iPjTI2LCjyIHHzgEm/R5pWG8Nc/Tcm1NE3AbeZTmU9C2uVkTdMOXDLxfvJwg
 OSkxm+/3KFHm7/7lY1r4vUjHjdiM+SnpfDb9xg8cKaVYWvlglA5+wVTp/KQfxxZJMMWc
 202KzT3a4bFJCnnWAtzcgw5zbZinl9Dhas8wiXQARj1XgqtQKt22v0RcKKjwWY/J2Ljl
 RfVSag4RWZzsCLoLuMHRe6uT9QuLHJZTxfCVEwSDg6hSKNL019aSP8o5RxI8BC12pw2G
 vMCDfi5nLcaf0mmgE3ijLNYHFYZuaJru4rJaH7ZeS8voI6KmKd280UthyzIE0uaU/AgD
 raxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723267809; x=1723872609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KEYbIQz6f27zTGJmcdMsYyvP+9LCfXGBlVPqoEs+j74=;
 b=GQv2lilvQLBZFGQPB7qHbSe4s0jDMUQofEjSMphZhh9rf6oU1Zsb0I9fJeuxb6O95/
 6Ovwek3q4xPUKdys05Y3/rXyZ+sV8tKizW3egfd826yn+8ISajKR++dyz9Q3lf0Lk01i
 4jhOmQKvTnNUwEYDlJhnctVpwJdEnlqedcMNEXuHlbKMFMBCNGF+PmfknVp7bQ6LawRI
 zT5JCuP28s61GwkL/TW+6VJiKOpZOwUMDGMUiQQR4/jC5lzJzm+rhvo8Dk5A8a3B2JKy
 IHoHYOT/N3U2zlPaETbzASEpXmrUmt/+qPRbz8YAxk6g7lwAqPtuKwlshRE5Hia9vxUZ
 KxSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHvWzCbR6gP3zE1BrhxWb/sQmEyaSlB+fA3u2E4Zb99BeefwcOkKMqiPsdNoRKd1X/+gEVqjh0lHptEYB637v9tBaGAg==
X-Gm-Message-State: AOJu0YzBaQx9lQUj532oeKxUQEOOpnBMLXImdwWrQ3IAqxJaVDlO2/Zp
 8Gvf7lUH5OcYCt+53oUQWsbVVsWUCMSdrCvIZq/QW8NA7ctR0RHS+QBISG59ZoxMgYocXyYRhjt
 XdYn65d1jtAXTk8ErKoNW9JHRud8=
X-Google-Smtp-Source: AGHT+IEVIbio5EbzoiQufJFCmFIm+mKDtdOHyzWVsET5+Ql1BsYZmljzU2VJAK8jtaYgyIIG1Qwz5uLmR8Q3CgJSiN8=
X-Received: by 2002:a05:6000:152:b0:36b:8f54:33ce with SMTP id
 ffacd0b85a97d-36d5e7fdf22mr2204930f8f.33.1723267808615; Fri, 09 Aug 2024
 22:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240807121024.11318-1-clamor95@gmail.com>
 <20240807121024.11318-2-clamor95@gmail.com>
 <0C2B63EE-A95F-424A-9143-6A0C2164F666@gmx.de>
 <CAPVz0n1CvhkCCNDPSrPvUweBTzTFEUDFHcAP5B7Wno8RefKpPA@mail.gmail.com>
 <20240809220244.GA1626301@bill-the-cat>
In-Reply-To: <20240809220244.GA1626301@bill-the-cat>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Sat, 10 Aug 2024 08:29:57 +0300
Message-ID: <CAPVz0n3cw3_MrKjHWtrt1mKiDkD4LWcatBHqvKTMna9dKK6KXw@mail.gmail.com>
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

=D1=81=D0=B1, 10 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 01:0=
2 Tom Rini <trini@konsulko.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Fri, Aug 09, 2024 at 08:57:03AM +0300, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 9 =D1=81=D0=B5=D1=80=D0=BF. 2024=E2=80=AF=D1=80. =D0=BE 0=
8:49 Heinrich Schuchardt <xypron.glpk@gmx.de> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > >
> > >
> > > Am 7. August 2024 14:10:24 MESZ schrieb Svyatoslav Ryhel <clamor95@gm=
ail.com>:
> > > >TegraPT is compatible with EFI part but it can't pass Protective MBR=
 check.
> > > >Skip this check if CONFIG_TEGRA_PARTITION is enabled, storage uclass=
 is MMC
> > > >and devnum is 0. Note, eMMC on supported devices MUST be aliased to =
mmc0.
> > >
> > > Why wouldn't you use U-Boot's gpt command to fix the non-conformant p=
artition table?
> > >
> >
> > I would love to, but I am forced to use TegraPT and DON'T modify it.
> > Tegra114 bootloader is RSA signed and there is no possible way to
> > replace it with open source one unless vendor allows this. SO I am
> > stuck with vendor bootloader to chainload from which enforces TegraPT
> > as well. Modification of existing partition table can irreversibly
> > brick the device.
>
> Can we please incorporate some of this information to the help text, so
> it's clear what the use case is? Thanks.

Sure, though usually those who know what they are dealing with will
understand. BTW, Tom, may I pick patchsets assigned to Thierry (tagr)
via Tegra custodian tree if they pass? Even if they, apart being
related to Tegra, belong to different subsystems (like this patch and,
for example, tegra gpio driver changes).

> --
> Tom

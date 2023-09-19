Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF94CD3447
	for <u-boot@archiver.kernel.org>; Tue, 19 Sep 2023 07:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F4C086A24;
	Tue, 19 Sep 2023 09:20:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RwuD4ENG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96D6486AB3; Tue, 19 Sep 2023 09:20:07 +0200 (CEST)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8FE586A21
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 09:20:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50300e9e75bso4578157e87.1
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 00:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695108005; x=1695712805; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+We61I/YLX8+XFY767ftciu3+b5XLCAs/zsxUUiOj/k=;
 b=RwuD4ENG3SgkKFG8tgyI183Clo6KYAm5Mw26zWFRBGPRZssIeGjSuB3yGVFa8Da5e4
 Db8SQJOGZJEPpPh99M9qTL0c2xbt4ecb6UpcyvRtX5SUlZzzHhYdsQEiy75tIab80kCE
 mN4SxfR/4HtHMYmQbuqgxPGMImT9sKYzH1G3YyYIc/kljyCoGwM9/CLK+BVeo77FhFDV
 culdsT2FcGUE95uDcCvE2fIkKtGQEkThUy5uzbZhT/5pzCtW7xnsv8FFF009m+nbykTs
 RK3Tu6Q8ypQDd7z/ZlkRd+PFiE4KT/hUSBe09Ls823HfCscV0QXUFpWHX2AxkijZt6MY
 7Gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695108005; x=1695712805;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+We61I/YLX8+XFY767ftciu3+b5XLCAs/zsxUUiOj/k=;
 b=Y+LP4hvG07F0nBp7/iGK4psepT51cLIKuvqlunpiLBw0NX/c+cv8JOHpTeKrNz7c6Z
 AbAxKs3a5wk4ppCHhagM4cpufZ3mkZKPqJafz1sLKmOIyRP8JS6pd/g1iXPVWVxB47VQ
 ZFmQVoA+nkesri2LPn7AlHoZjHbPaE+ZT4LieOOgS3rPHnVJ/e+2QStEJqyp4yYm0BRv
 b3aiyS2eepOWf5j5TD1N81cCEP/ON7qSXXSPnoXUBmnN7mtANpiPaU4sEV5z5ruMhkTA
 WyjPhwYvJWcBBdG+09hbAsUR1ejvE+ArkkwmrtHlpxJJzlRh2sHBXVUOy8f1DtVZfeVF
 LxZQ==
X-Gm-Message-State: AOJu0YxO+octH/MIAUjNycc2UMZC5vwvscNj0+SqZTepyJvjdK0eU6ZI
 K9LAKQqVN2QjDGQNuQOMW6MzX7KGPLdT+ETrHGA=
X-Google-Smtp-Source: AGHT+IEdcVPwYUE75HTuTIhB9p48Rp0wbb3MX+/8DfhsHVIBumQQqzmvZW8u83jOYSqWqLsDJHu9F6W2xMl8AYb8uu8=
X-Received: by 2002:a19:6d01:0:b0:500:8443:744a with SMTP id
 i1-20020a196d01000000b005008443744amr8026534lfc.7.1695108004956; Tue, 19 Sep
 2023 00:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230823211059.1235147-1-sjg@chromium.org>
 <20230823211059.1235147-13-sjg@chromium.org>
In-Reply-To: <20230823211059.1235147-13-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 19 Sep 2023 15:19:51 +0800
Message-ID: <CAEUhbmVbVYqVp4c1DSaqOOLD1gLNTWFrQ4htcfQ08xRYY5rSFg@mail.gmail.com>
Subject: Re: [PATCH v4 12/20] x86: smbios: Add a Kconfig indicating
 SMBIOS-table presence
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Thu, Aug 24, 2023 at 5:11=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> When booted from coreboot, U-Boot does not build the SMBIOS tables, but
> it should still pass them on to the OS. Add a new option which indicates
> whether SMBIOS tables are present, however they were built.
>
> Flip the ordering so that the dependency is listed first, which is less
> confusing.
>
> Adjust GENERATE_SMBIOS_TABLE to depend on this new symbol.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Allow SMBIOS if EFI_LOADER is enabled
> - Reword the help
>
> Changes in v2:
> - Add new patch
>
>  lib/Kconfig | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

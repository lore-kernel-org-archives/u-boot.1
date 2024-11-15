Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460DBD68BCD
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 19:27:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545838917E;
	Fri, 15 Nov 2024 20:27:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h8vXW/mk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07A4789185; Fri, 15 Nov 2024 20:27:41 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADAE389165
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 20:27:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-539f84907caso2410922e87.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 11:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731698858; x=1732303658; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YY5+IsK0ErvTPoC29HA14gWaEME6M4uQ7gIbt1mykEw=;
 b=h8vXW/mkgrSfT9nMbdoy1RTPNEGGiT9by6DIPCUVpyccE0SEmR8HWWQWKm7v+ZPugT
 kPHwoUpnP9xQ1ESZqIYQxmpGC9raE7vi9rS7ytfzoKKlfHRIusKWw0Yezt3tKeP0GH3o
 TTY3RTQgW5suLOUbNf3cnksrNQRGLn2MHMMlQqKv1ktwyBa9ao65IG6xIm2afWVIXZ87
 EsXaK1TtPgan4DXAzUoJj/3IFTHyaNoOIxA6BEzsKj+myw3q75zJvGpqzHhCCYMEfUjp
 FHu1fwRDG2GhkGkmnA+APNuwk/RKf4vfMF4GxuYNiAPnyaE4IlsDlwtJJ5tFProKjERn
 nchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731698858; x=1732303658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YY5+IsK0ErvTPoC29HA14gWaEME6M4uQ7gIbt1mykEw=;
 b=eVh/O+7qN4wdVa8k+BiOpdpioWw+kKqxnqeJk0k9xFcP26GgpYZ7mEQ/J1DQDOGS7k
 3QV++8C4CQgqYk20kFAttFiT8OEV8BUZCsSsAcjrTAxOVJ4FzRH4O9uoeIisMXrsPerf
 NRxmKQ8dzbcsBCAdte8m2SnD8EGhYvHpikbX9Cdj14Diw1E1tCm6sNEy0sqoVg6Aa+7T
 Izgb3z5QGiQTJ4XlZQC/WZopoLo9O/9BHcONmgkkShY3EBxn2nt62ixEj0kcYPM8qadU
 ZQqyMzk4EqDiMy1Upb1pUDfRezxCuqofOC53MlOxT4B4tY/M3yZY39lJZzWzvCcV0VgB
 3jsw==
X-Gm-Message-State: AOJu0YwrtmacEYiSx8nj9zmoXX7X+mh2wANzsskqmBltSlwMVmtQPwPi
 Hf5KOUjycFiNEuzXEcoWx4itKVbUpN1LWwJTf8SDtKsq25PPvHrTyrJl445bnuKlUsBIx15+XVe
 VkrhO1nLSFE/dhgiFphb7uW/939AfRpg/
X-Google-Smtp-Source: AGHT+IHCoav4V2Z/DQ7s6v7M5ElmBs8+GoZ7gkprE8fnLLRUTGiGuxOoTQ5Q/NOEnP39fk/QwjkySw3a6wkzwfbmCbM=
X-Received: by 2002:a05:6512:ba4:b0:539:f886:31d6 with SMTP id
 2adb3069b0e04-53dab291a5cmr2032631e87.2.1731698857496; Fri, 15 Nov 2024
 11:27:37 -0800 (PST)
MIME-Version: 1.0
References: <CAJaLiFwvFVOKYpAQLSNUqAfVHCsPcxo6g74JGunw8HSQTMCFLA@mail.gmail.com>
 <20241115141748.GS3600562@bill-the-cat>
In-Reply-To: <20241115141748.GS3600562@bill-the-cat>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 15 Nov 2024 11:27:26 -0800
Message-ID: <CAJaLiFx35Q8L-kR02GrA1PTd2nY699KMc2fy5fT381Khg5hgxg@mail.gmail.com>
Subject: Re: Git commit failed with mbedtls/framework
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, Nov 15, 2024 at 6:17=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Nov 14, 2024 at 08:26:33PM -0800, Tony Dinh wrote:
> > Hi Tom,
> >
> > I am on 2025.01-rc2, and I am trying to commit some files. The error
> > seems to indicate this framework directory might need some
> > modification. Did I miss something?
> >
> > error: 'lib/mbedtls/external/mbedtls/framework' does not have a commit
> > checked out
> > fatal: updating files failed
>
> That's odd. You didn't happen to try out some of the previous lwIP
> iterations on that tree did you?

No, I did not. The tree is clean with "make mrproper" and on the
master branch. I just did a git pull and worked on it.

I went and looked at https://github.com/Mbed-TLS/mbedtls.git. The
framework directory is pointing to a specific commit.
framework @ 3867faa

I'll stash and repeat it on another clean tree.

All the best,
Tony

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50247C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 17:44:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FFA87240;
	Thu, 26 Oct 2023 19:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qVUOO2D7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0A3C87468; Thu, 26 Oct 2023 19:44:20 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7670A86FC8
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 19:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53e2dc8fa02so2002367a12.2
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698342255; x=1698947055; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T7mKrOzIgWIVt4QZUEBgjjJ3ICHm687OaRaA7skUtrM=;
 b=qVUOO2D7Y/QJELTEKMkN/A0VyYiq5uF4whobpnl4lefQU/Mdp6adbr6uaGCBx7Pvvi
 de5HvOovFyXMReCSH8hYAVn0qQCU2KXs2r8iHjhcGHX4rHRJdzCMLY5P7yk08h6cSh+y
 h0smaS26u9hVHVjAohz1aMe1KX3sxOPnWGFXzWVbiLZUhdZ+6/Jio7hLUhunGbsAYW/C
 tMTxU/ddJYLnsPCpuanLJ7gHIPqjZhba5VMr+1i1dj2Thc9nOhlbmIemIdUlD03rbZnp
 v6aTfQBwxLO+TEUqqy/hNdpE6qDhxjbKogfeft8iWhsQOTp5/vYEsnIM32XQW/rOSfJG
 hXgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698342255; x=1698947055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T7mKrOzIgWIVt4QZUEBgjjJ3ICHm687OaRaA7skUtrM=;
 b=qwTpx92gibybromEdS0EEReUHJ00QCOqzzmqGtFfapYl/+HutbDXXdtNepi6EZdLNb
 qoVC6py/sSZ6L50QHi1EpnxgO2t6pMA8F15fjESjyMKLIHWyQ3Eo3Fzr/7eww0zzhf5R
 68Y7rNCvCHA0qkMhjMyZ5PAoUPUS85fyJRp7rIv6T1FuEumHuu4hWFDHRHUTZSj4kJGJ
 49Pjcpa33JJFpTssylxPHMMIQ+c6/yiYO8oCqMe+CqL8pi1fCqucZjde7WLlysU4UV/r
 WleZSy3N90U5pK4kP1xYN3alY/fjKjcSakCd58j3HZ2//ayKuwbdsO1Mf7A2XY+C00K3
 m8AA==
X-Gm-Message-State: AOJu0YwQxnYT00ZO603qc4zOydr0Zl0mAZNFYlHZ2Q7JvrdWwRjJnWaQ
 AWru0QhmVEZ6mamoOK2ikEFAXuPPLE7ojULTIQMQ6g==
X-Google-Smtp-Source: AGHT+IGT0Eq5mvn/HeB7mxd7Q+oKO5UjK7FamuaK57o2YoDILbr7emHKiysl7ijQj6THNmyGrTuZYK3M6ZHZhIBPkSA=
X-Received: by 2002:a50:d556:0:b0:53e:5f9:328b with SMTP id
 f22-20020a50d556000000b0053e05f9328bmr401710edj.2.1698342254700; Thu, 26 Oct
 2023 10:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ1A8vyEUx2wiXqOCb8Kf9zP96wqy4kXanfKRR-uN6yOmg@mail.gmail.com>
 <OS3P286MB1495889DF57AD742064FDB56F6DEA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ0Bb7zzVabU05hfg12tcrQbzT1iWQVdrui2GmsEZekZDA@mail.gmail.com>
 <TYYP286MB15006711E2339FD6BB432045F6DDA@TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYYP286MB15006711E2339FD6BB432045F6DDA@TYYP286MB1500.JPNP286.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@google.com>
Date: Thu, 26 Oct 2023 17:44:03 +0000
Message-ID: <CAPnjgZ0nrq5y-1eAfcaTCmPJ+xq49xS9DGUSjd5fn8rSFekO2g@mail.gmail.com>
Subject: Re: quick question about TPM
To: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

+Ilias Apalodimas as well

On Thu, 26 Oct 2023 at 02:22, niek.nooijens@omron.com
<niek.nooijens@omron.com> wrote:
>
> Hi Simon
>
> Yes that fixes it! Thanks!
> Maybe an Idea to add a dedicated TPM page to the docs with information li=
ke this?
> (https://u-boot.readthedocs.io/en/latest/index.html) Cause I wouldn't hav=
e thought I needed an option tugged away under Library routines.

Thank you for the feedback. I added Ilias to take a look.


- Simon

>
> Anyhow Thanks!
> Niek
>
>
>
> ________________________________
> =E5=B7=AE=E5=87=BA=E4=BA=BA: Simon Glass <sjg@google.com>
> =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: 2023=E5=B9=B410=E6=9C=8826=E6=97=A5=
 03:23
> =E5=AE=9B=E5=85=88: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooijens=
@omron.com>
> CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
> =E4=BB=B6=E5=90=8D: Re: quick question about TPM
>
> Hi Niek,
>
> On Tue, 24 Oct 2023 at 19:26, niek.nooijens@omron.com
> <niek.nooijens@omron.com> wrote:
> >
> > Hi Simon
> >
> > Driver model is enabled, so it's pretty weird it doesn't show up.
> > CONFIG_DM=3Dy
> > CONFIG_SPL_DM=3Dy
> > CONFIG_DM_WARN=3Dy
> >
> > The TPM menu is there, yet somehow empty.
> > This is just after "make socfpga_cyclone5_defconfig" and "make menuconf=
ig"
>
> Do you enable CONFIG_TPM here?:
>
> Library routines -> Security support -> Trusted Platform Module (TPM) Sup=
port
>
> then the drivers appear for me (under device drivers)
>
> > if I use "make snow_defconfig" the menu is usable like normal, so somet=
hing is disabling it, yet when grep-ping for TPM in socfpga there are no re=
sults.
> > Adding it to .config manually also doesn't seem to work. so I'm a bit c=
onfused about what's going on. Anyhow thanks for the help!
>
> You can edit the defconfig to add CONFIG_TPM and whatever driver you need=
.
>
> Regards,
> Simon
>
>
> >
> > Niek
> > ________________________________
> > =E5=B7=AE=E5=87=BA=E4=BA=BA: Simon Glass <sjg@google.com>
> > =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: 2023=E5=B9=B410=E6=9C=8825=E6=97=
=A5 03:03
> > =E5=AE=9B=E5=85=88: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooije=
ns@omron.com>
> > CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
> > =E4=BB=B6=E5=90=8D: Re: quick question about TPM
> >
> > Hi Niek,
> >
> > On Tue, 24 Oct 2023 at 04:51, niek.nooijens@omron.com
> > <niek.nooijens@omron.com> wrote:
> > >
> > > Hi
> > >
> > > Just a quick question. I'm developing a platform using the socfpga_cy=
clone5_defconfig
> > > everything is working, linux boots, but we decided to add a TPM to it=
's SPI bus.
> > > For some reason the TPM support menu in the menuconfig is disabled an=
d I can't seem to find out why, or which file disables it. can you point me=
 in the right direction?
> >
> > The only thing 'config TPM' depends on is DM (driver model). Is that
> > somehow disabled? Once you enable that, it should appear.
> >
> > Regards,
> > Simon

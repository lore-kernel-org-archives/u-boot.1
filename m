Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF74C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 18:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82BA3874CE;
	Wed, 25 Oct 2023 20:23:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="nRNDub4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C145D87240; Wed, 25 Oct 2023 20:23:49 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66E6B87A09
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 20:23:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507973f3b65so9400008e87.3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 11:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1698258223; x=1698863023; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rJZ36VBPGZA4WSrqJOIQCIu5LRsDYss9g53/3NmuOgs=;
 b=nRNDub4cDDMGxwyCtZDrUh+fLHmIELXPM2yM8VQvXskzGxN8iK5kh89kPdvN7+HebP
 PbDv+SIPyfy/jyeW7zJ15KnxGsd4uPxvS0t0IIshjdWYfMol0hBXV974xu2ivSAViuPb
 mqPqPDKZX1JQv83OS4n1ryFI36F0co0BmmwdVUJIqx5xwPBxhOOowOD66He+iRng8ufX
 kMM14w3kB35+BQ8VXw2mJRuKJ8rE5KNVPokfcPQr2LvJgpeI9zX5vcRu/NhVfZGAgqHg
 xhL7RJFyOC/pzxwUHDXRzwOfzdSJT7DJH4Mhpz9O37A797YJFFAb+GBiIv6CiBlrGexn
 MQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698258223; x=1698863023;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rJZ36VBPGZA4WSrqJOIQCIu5LRsDYss9g53/3NmuOgs=;
 b=NQ0HtdB7++n6hiQ5kjJ0ZW585a0NcLjh49lX16fr4jRtpO/fIphrjBmtvBTlMTIGmb
 55lAuAZWCVSZBDiwk5MIMt9BowZ83Z28tVFHjCE975sXLQWN3srEKLNLgkNPjF3We4Qy
 07b/ZjJaEeujcJA87IJrLPp2Wkyj1D7wh1yP+UGz3BqhAstQ2NLbg1RvLmPSZRPZL4wg
 dqDeSkSgZxKhcTLuNfn/EAKz+yPFv5mvYRBoNtls8xBOOvEH+GjPgcte1qNOzj56SMOi
 BKiJiOHH6eE9p+D8qnsDgmhgTovXutJjCwIzGZ2JHUlPNM7xg1NGzy46aGR1kLEICcF0
 PEhg==
X-Gm-Message-State: AOJu0YxhleByr7Sis4uxVPJX8CzmO2ewpKP67pb2KiawS9FSLQeM7Xkx
 q3GGhAoXTCl6bO5BNjD7/i5LdwUexWDaPQsJjpRI7Q==
X-Google-Smtp-Source: AGHT+IEXqEkxRxdipT0YemNeewtQhj5vxM+3SkRKqE80Yj7sTQvv4XKnZPdevNSKJ5p1LVcRMkvGt9ZvP7/qJEVSHGU=
X-Received: by 2002:ac2:4341:0:b0:500:9f7b:e6a4 with SMTP id
 o1-20020ac24341000000b005009f7be6a4mr10914789lfl.32.1698258223126; Wed, 25
 Oct 2023 11:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <OS3P286MB14955A84C3B71A32C4BBA352F6DFA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
 <CAPnjgZ1A8vyEUx2wiXqOCb8Kf9zP96wqy4kXanfKRR-uN6yOmg@mail.gmail.com>
 <OS3P286MB1495889DF57AD742064FDB56F6DEA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OS3P286MB1495889DF57AD742064FDB56F6DEA@OS3P286MB1495.JPNP286.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@google.com>
Date: Wed, 25 Oct 2023 18:23:30 +0000
Message-ID: <CAPnjgZ0Bb7zzVabU05hfg12tcrQbzT1iWQVdrui2GmsEZekZDA@mail.gmail.com>
Subject: Re: quick question about TPM
To: "niek.nooijens@omron.com" <niek.nooijens@omron.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
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

Hi Niek,

On Tue, 24 Oct 2023 at 19:26, niek.nooijens@omron.com
<niek.nooijens@omron.com> wrote:
>
> Hi Simon
>
> Driver model is enabled, so it's pretty weird it doesn't show up.
> CONFIG_DM=3Dy
> CONFIG_SPL_DM=3Dy
> CONFIG_DM_WARN=3Dy
>
> The TPM menu is there, yet somehow empty.
> This is just after "make socfpga_cyclone5_defconfig" and "make menuconfig=
"

Do you enable CONFIG_TPM here?:

Library routines -> Security support -> Trusted Platform Module (TPM) Suppo=
rt

then the drivers appear for me (under device drivers)

> if I use "make snow_defconfig" the menu is usable like normal, so somethi=
ng is disabling it, yet when grep-ping for TPM in socfpga there are no resu=
lts.
> Adding it to .config manually also doesn't seem to work. so I'm a bit con=
fused about what's going on. Anyhow thanks for the help!

You can edit the defconfig to add CONFIG_TPM and whatever driver you need.

Regards,
Simon


>
> Niek
> ________________________________
> =E5=B7=AE=E5=87=BA=E4=BA=BA: Simon Glass <sjg@google.com>
> =E9=80=81=E4=BF=A1=E6=97=A5=E6=99=82: 2023=E5=B9=B410=E6=9C=8825=E6=97=A5=
 03:03
> =E5=AE=9B=E5=85=88: Niek Nooijens / OC-IAB PBD-C DEVEL 1-1 <niek.nooijens=
@omron.com>
> CC: u-boot@lists.denx.de <u-boot@lists.denx.de>
> =E4=BB=B6=E5=90=8D: Re: quick question about TPM
>
> Hi Niek,
>
> On Tue, 24 Oct 2023 at 04:51, niek.nooijens@omron.com
> <niek.nooijens@omron.com> wrote:
> >
> > Hi
> >
> > Just a quick question. I'm developing a platform using the socfpga_cycl=
one5_defconfig
> > everything is working, linux boots, but we decided to add a TPM to it's=
 SPI bus.
> > For some reason the TPM support menu in the menuconfig is disabled and =
I can't seem to find out why, or which file disables it. can you point me i=
n the right direction?
>
> The only thing 'config TPM' depends on is DM (driver model). Is that
> somehow disabled? Once you enable that, it should appear.
>
> Regards,
> Simon

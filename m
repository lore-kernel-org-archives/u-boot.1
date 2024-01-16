Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E832C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 17:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47214879F8;
	Tue, 16 Jan 2024 18:20:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ouuElK2b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03DCD879F8; Tue, 16 Jan 2024 18:20:18 +0100 (CET)
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com
 [IPv6:2607:f8b0:4864:20::c42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E040587A05
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 18:20:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-oo1-xc42.google.com with SMTP id
 006d021491bc7-598699c0f1eso4429090eaf.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 09:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1705425611; x=1706030411;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hpfArJN/X/O5lYIaxRCgK7d/CugKmqeLxu6oPK0ah4E=;
 b=ouuElK2b/wjdkAxp6fZtEaVD9c5TTvQhBc0h3N5QtT6B4V4NE4d1PaFoUimlxUD1Lo
 Mb5VteQiRNRSC9iO1iuoCajEx/HAfEzI8lNQCMwhmrDJ8yNk0W+xY4jm31/+SwViWaQ7
 15VpQSxkorZfpOUBB3gs9tq5ExbG7lfsvbUDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705425611; x=1706030411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hpfArJN/X/O5lYIaxRCgK7d/CugKmqeLxu6oPK0ah4E=;
 b=smcgBI5TjsRUPajYVfH7xoLVelvaeB5kGswsUp0PRsz1DVHwupWUi/FwnFCQ354zeU
 ecsCo42q+P4VNvO7A+pYaK2NlogP1kI6rOYpMeuHM/uTKyx5x1ciXh1V6MVrpjukPWY1
 r7HF2iiQ1P6orqY/TMZRz/kBoM8+nncF6vCVCZjWUb7471w5jUOhOHiyQN35J2GYXEV2
 KPWR2LB8elv8a5FAN2fGeKEja7bA6GG+mUqIXgMICARtKZcYatFAISUbtUEk3qXGkVaQ
 nFO0QIjdFf1hDlg92Rfw09Xij8Nowd4Q7P8gi086d2Vqp80+c2qOp6SJnx/KB2Gvx2/I
 i+Fw==
X-Gm-Message-State: AOJu0YzUDlivToiLy/saHmSJUpsTQ+8dZE80wqaayRR5+CGS5tGGj1gu
 pb/K9b2HWBsCftIwYrhMHbxsa2VyUudexQ==
X-Google-Smtp-Source: AGHT+IG3ne6WvpNS4UGGgt8Idwj94U04d5VwzeAwj4xYdnEczS2W7Hv2t3OIbDdhDTjETxPueaRzuQ==
X-Received: by 2002:a05:6358:3d53:b0:175:4048:c590 with SMTP id
 b19-20020a0563583d5300b001754048c590mr8479531rwc.58.1705425611335; 
 Tue, 16 Jan 2024 09:20:11 -0800 (PST)
Received: from pwmachine.localnet ([171.4.233.91])
 by smtp.gmail.com with ESMTPSA id
 by41-20020a056a0205a900b00578b40a4903sm9076747pgb.22.2024.01.16.09.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 09:20:10 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v13 00/24] Modernize U-Boot shell
Date: Wed, 17 Jan 2024 00:20:06 +0700
Message-ID: <4890457.31r3eYUQgx@pwmachine>
In-Reply-To: <20240111170418.GA7220@francesco-nb>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
 <5740853.DvuYhMxLoT@pwmachine> <20240111170418.GA7220@francesco-nb>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Hi!


Le vendredi 12 janvier 2024, 00:04:18 +07 Francesco Dolcini a =E9crit :
> Hello Tom, Francis
>=20
> On Fri, Dec 29, 2023 at 07:55:37PM +0100, Francis Laniel wrote:
> > Le jeudi 28 d=E9cembre 2023, 21:58:59 CET Tom Rini a =E9crit :
> > > On Fri, 22 Dec 2023 22:02:20 +0100, Francis Laniel wrote:
> > > > During 2021 summer, Sean Anderson wrote a contribution to add a new
> > > > shell,
> > > > based on LIL, to U-Boot [1, 2].
> > > > While one of the goals of this contribution was to address the fact
> > > > actual
> > > > U-Boot shell, which is based on Busybox hush, is old there was a
> > > > discussion
> > > > about adding a new shell versus updating the actual one [3, 4].
> > > >=20
> > > > So, in this series, with Harald Seiler, we updated the actual U-Boot
> > > > shell
> > > > to reflect what is currently in Busybox source code.
> > > > Basically, this contribution is about taking a snapshot of Busybox
> > > > shell/hush.c file (as it exists in commit 37460f5da) and adapt it to
> > > > suit
> > > > U-Boot needs.
> > > >=20
> > > > [...]
> > >=20
> > > Applied to u-boot/next, thanks!
> >=20
> > Thank you for the merge!
> > If there is any problem, do not hesitate to mail me and I will take care
> > of
> > it!
>=20
> This change, specifically setting the modern hush shell as default, is
> breaking our boot script, just noticed since the current U-Boot master
> has a regression for us.
>=20
> We still need to figure out the exact details, here [1] you can find the
> boot script (that has some placeholder that is replaced during build).
>=20
> and the error is something like:
>=20
> ```
> ## Executing script at 90280000
> Loading DeviceTree: k3-am625-verdin-nonwifi-dev.dtb
> 69025 bytes read in 11 ms (6 MiB/s)
> 82 bytes read in 9 ms (8.8 KiB/s)
> Working FDT set to 90200000
> syntax error at 'done'HUSH died!
> resetting ...
> ```
>=20
> that I _assume_ comes from this line
>=20
>     env set set_apply_overlays 'env set apply_overlays "for overlay_file =
in
> \\${fdt_overlays}; do echo Applying Overlay: \\${overlay_file} &&
> ${load_cmd} \\${loadaddr} \\${overlays_prefix}\\${overlay_file} && fdt
> apply \\${loadaddr}; env set overlay_file; done; true"'

Sorry for the inconvenience, I tried to reproduce on my side and noticed so=
me=20
strange behavior.
=46or the moment, can you please try to only escape "$" with "\$ and not "\=
\$"?
I would like to confirm some insights I have.

> [1]
> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-bsp=
/u
> -boot/u-boot-distro-boot/boot.cmd.in
>=20
> Francesco

Best regards.



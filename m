Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE6DBD0C84D
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F24083045;
	Tue, 13 Jan 2026 11:46:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rvaxnO5s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A5AA8352B; Tue, 13 Jan 2026 11:46:22 +0100 (CET)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com
 [IPv6:2607:f8b0:4864:20::132d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F8F48004F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:46:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x132d.google.com with SMTP id
 5a478bee46e88-2ad70765db9so12330501eec.1
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 02:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1768301179; x=1768905979;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RqQ+I7Uk9pKR7gZWYVGYWJXyu9WWhRHlTx2Xp2beEI=;
 b=rvaxnO5sshdGzP5v3Z8uPRBXC138CNhZWfGFd1DmTeRcLm4+VhUAIA5vhknfzPnNQI
 FnvXCozm+B7O49kLwthieElZpwEYN6cZx/5z0dZqVKr87B2VV6ovH/z09dZgzDKE3TyT
 REx8VTKuPxaeQE9k1iKwutSS4DIPtcHnZGEiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768301179; x=1768905979;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0RqQ+I7Uk9pKR7gZWYVGYWJXyu9WWhRHlTx2Xp2beEI=;
 b=ggYjI116n9kAi9dqJR7OKfg9kTSwwNgKuWi0TTMYCQ8z8SkpprwQg6zt6IQAsVovyN
 Cn7Up3MAr/6K9KaEA0oDSxOLFD2B2488eBGgMQCuxAEVcYniCIHE2Qo/J8UK4tAY71YM
 IGLsA2zydcurnCpueYwer6xsKvB/vKL2dGziSYjspecyHgnL4y3fuLIf770k48MjKFPg
 I7gK0k2yOMmtPUrKkHSPc+czX9FoOPWOU5YBVAKuDZysuY5xcMOzt2d+3ziYr2E6THAV
 ZOv1vgJq2hgPTqHwg5WFCQ500NY0kgNBsMPXsMDk/8IkS+2nXdC4DRW5l00g77MHzrmr
 brBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlf+oPM5PNF8OArIL4D5hExz/mEQ0JEM20t+rRQ3V1lBDJQdKE8uPVDQ5fHPm5N+Gy2GhRRjA=@lists.denx.de
X-Gm-Message-State: AOJu0YwxAXx3ogCGbT6uKn/iP76Taw/WiBlNnRLQR6GBsdwdcK76gSrh
 qfbvDUtyvV6oLLe6V/A0yIpIBUh3CO8EcRiaOkpEN+QaUbMgKxLxWdLxCcHIRWRuLiZjjGaM88x
 T6IQwpCiRiyb/CyowKZMe2CLdmoo3DHNO+++2Ik8HKm0lSv8hOilODIk=
X-Gm-Gg: AY/fxX4lU04Mhz1MPkLdKUPoze0uoDdWePeb1f+PU3BTgIDr1Uli8yojpOcW+Kq13aB
 I2Z0tZ19lQUN3U16bBciBA5LhJR4j6VjxmEYEj8GKYQD9FZdrUgvGA6ufo5OEWIyOGaGHJwW+7B
 ZQzuyOoTL+3Q2JC6PJ+x1yKzVTFuNrpszJ1GnFYWesfqdazb/C0s5xwJtGDS/ri1GW3Nswlu60Q
 A8pFZl+0fsgBIP85Y6oQ/Z+l3CAym1vK6VG9+BWmgAZ/qX8H2nWfSDoovTe4FjXgu7tvPEosEjv
 2c/VpKPL5DzsdB/lvQ4t6Cx4CA==
X-Google-Smtp-Source: AGHT+IGfwDLbiG6/E7xqkvvGgbbupJ54mRzkXXs4bCQiJGB3uUGDaGauAbmshD8QbCqoYS3iHl7NPOJjTlkSA7Qrrv8=
X-Received: by 2002:a05:7300:ccb0:b0:2ae:56dc:eb18 with SMTP id
 5a478bee46e88-2b17d2eca58mr16744191eec.21.1768301178361; Tue, 13 Jan 2026
 02:46:18 -0800 (PST)
MIME-Version: 1.0
References: <20260111082347.1302003-1-michael@amarulasolutions.com>
 <aWYJKl90YEvhVZMV@nxa18884-linux.ap.freescale.net>
In-Reply-To: <aWYJKl90YEvhVZMV@nxa18884-linux.ap.freescale.net>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Tue, 13 Jan 2026 11:46:06 +0100
X-Gm-Features: AZwV_Qiy4KKwzIq3-Jcprodrg2MfQrPAzRWth_rNWNxBXoUiK1I5XeMUxgxPypA
Message-ID: <CAOf5uwmGjw5daQXRcqJzpTsH3xXTGODZRqf1qWhM7Xw2sEHQhQ@mail.gmail.com>
Subject: Re: [PATCH V2 0/2] power: regulator: pfuze100: Fix voltage
 calculation and support high-range
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Joy Zou <joy.zou@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de, 
 linux-amarula@amarulasolutions.com
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

Hi Peng

On Tue, Jan 13, 2026 at 8:44=E2=80=AFAM Peng Fan <peng.fan@oss.nxp.com> wro=
te:
>
> On Sun, Jan 11, 2026 at 09:23:45AM +0100, Michael Trimarchi wrote:
> >This series addresses two significant issues in the pfuze100 regulator d=
river
> >regarding voltage calculation accuracy.
> >
> >The first patch fixes the handling of the "high range" bit. PFUZE chips =
support
> >two voltage ranges (controlled by a register bit) with different step si=
zes
> >and base voltages. Previously, the driver assumed the low range, leading=
 to
> >incorrect voltage settings on boards configured for the high range.
> >
> >The second patch corrects the interpretation of min_uV. The driver was
> >incorrectly using the device tree's regulator-min-microvolt constraint a=
s the
> >mathematical base (zero-index) for voltage calculations. This caused off=
set
> >errors whenever the DTS constraint differed from the hardware's absolute=
 minimum.
> >The patch introduces physical minimums in the driver descriptors to ensu=
re
> >calculations are based on the datasheet specifications, treating the DTS=
 value
> >strictly as a safety constraint.
> >
> >Together, these changes align the U-Boot driver logic with the Linux ker=
nel
> >implementation and ensure correct voltage output.
> >
> >Michael Trimarchi (2):
> >  power: regulator: pfuze100: support high voltage range bit
> >  power: regulator: pfuze100: Decouple hardware base voltage from DTS
> >    constraints
> >
> Please do not submit three version in one day. That only shows patches
> are not developed in good shape.
>
> The changes looks good to me, but I would like to see which platforms
> are tested with the patchset before apply.
>

I have tested on a new imx6dl design but I can ask Dario to test on
some other imx6 board,
do I need to include it in the next release?
I will send some other patches end of this week

Michael

> Thanks,
> Peng



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com

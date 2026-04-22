Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58383F94CBB
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 02:43:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B917D842FD;
	Wed, 22 Apr 2026 04:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pUUrHK4s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8023284198; Wed, 22 Apr 2026 03:58:24 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97D2383FE9
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-38e7d983f50so54673561fa.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:58:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776823102; cv=none;
 d=google.com; s=arc-20240605;
 b=UMhP070nzzE/tpvnkOH95ZKaBiXL1nkMZaSVGZtYLlEdFpTUHqHmB8jjuyZ8BpeGHs
 WJgDhG+mgdq768jTPv91EPtaljMFHsoOYGD7GN2R1mlC4etATK1/3K7ehcSJ8P3YmOX7
 I8abT28ImGke6n4a6gdyMMH3I7qyHbd+vYnDxh/JM++y/wc99Xaz3eFqt/9WZ0Eai1Gh
 p7UvNmzWuFk3CXsbg9Zdkes8bmfnx1ibqYdeufC/5W00lU/Ejhb7TWDcKUMet+2ItOF2
 DwdVcsYBw1znBu4RwS+QB61kInMeefKHPA1Kym47fwJtX14u2XR+tZmIQeOqZtUd7jig
 XykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1/4+0rPh7UYv0v4cqeCggt/9Xz1OHaHWaVS02r1juVo=;
 fh=RSU8kAoIjsSTeUte6uEAaMOtPPoelySw+QtBhQPZ3GI=;
 b=Y6dPqI8kB8ffo7vvLd+NJouNqwgLw74aRMeDYqzA3V4ONR9JmF1+R/DoCnXKwKsrLI
 krcNH1/cpnEP7s/hufIwlJTqhDxTCOv1IIwUewkPDwSMyvhYP2sOpUGFfHoVRxfuf6hW
 ZMTzDrANVU7EoVzeYAF2QPyc7qIvIHIBJxoQ9fWZX6Uo+JJbH/l/kdVATG7PRvae+p0V
 AeQUMr/7YMYq6nG8k38+VYyKZGtmtG3mC/++pMI7QyDVP1XBoxL8I+RKaAcbj7RW4nqy
 NfB35s7cTg10+BAhzP11rPCiLrRSMUfJ4pG/1c2Ti7SFltdiSmzRXdhr9k3cu/uG3shx
 AJUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776823102; x=1777427902; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/4+0rPh7UYv0v4cqeCggt/9Xz1OHaHWaVS02r1juVo=;
 b=pUUrHK4syFmZIxhNyGF9mDTmhpmZedl6+phnvMo5w9YQwdGN7Rxgk3/jg3Ib7JEPWO
 yb1O/u0p8BSwvc7I/13/1eDq1mZGflfDGfpzZfXc18TR+O8dL5fgFXN8fhV62qdnqzOv
 NIDErOi4pPHNSlbLyga3Ji1VhUpcEidwzaWgxZs5Hic6YZDAzsiCRhztcIi7H+v8BpFM
 yItK72J2wOTKfzoU3Hr3VT1p9aRvo/ZMVnul3lChVqVTzpE4BzBHCWgL/Ubi1DOnXJ4J
 nUcZXpm3lSOgIDQoXusCHf/GGemiS4HAfAl7dEQ2L+3sWKk2luICVFQqS+xBkx9GOPGQ
 9UoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776823102; x=1777427902;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/4+0rPh7UYv0v4cqeCggt/9Xz1OHaHWaVS02r1juVo=;
 b=VUO/4tTG55faVAR/0ULcjhWSRG5THVYefCh1g7UJpBfPsTLcb3CMejwns4Jsg8g9xP
 nWiSsIv3SfBAvICeXAuqpogvb/FIOcsoNIxgzZnv+nRiATM5lGgTa7y7/WyWZUAUuDnb
 Rz0HpePrBWiMLKIexf6kM6xXCuTtYkf5E7wQUvho5CPH1WBsopk8jZjww2UQsPFlfudI
 6VyohUUZ2B0LuENhS2jeqOA35sDLKR9K11zlexwXpD3zCKCGwIZ7hg0u4cyYzHOnz9Wb
 k3GkSpTq1TDxe2mMYJ3+9COSyIFZKRkvxIJE2y4WOIybNNrd4eNXKHQRM5ZYPMrzOzpN
 cumQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+iPksNaVQqMaMbRN3CvISa+z9J+4d5YosydNSI+elN1bGoUG2y1JzB2ofE2cG4We8SVwvlKfk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7X6CxVAAUe9yNakT6MjSj0Z2BBM4QmJRWBzF0oPDRJALYRAtn
 r8yEXvTDLPJx1TLVu+XyJlkPl1mJg1CFZ7nAuBtuSV9JYeUGxVxlO9i6tY1W1/TQA+NtxR5FqEM
 fQeGrkrNVBw8Y5HJqw76Tll9XzWSORKk=
X-Gm-Gg: AeBDieswHwaW+Q6F4JYo7gepApQHifpmzHBXBOuNfp83X4gYxt/jP3wnwY+5WLpeT7b
 x79zwcapsZnTjkSlTENTdUjCk6BktAngyNvEZkFO0erF46N/jD0gqDUWNh47UGyEqE7win9U7pt
 kLVDlavhRShEcbKbFZw4kceo9GjS5b4ot/eLjcrmxxgCGQFY0O3NWpaXfHGm9YX9Zs2BTN4oqif
 giE+DQFmltBv8LeyVzX4ODuabXvSMYMbOvYTu6MuzbIimkfSX7K/JQVLoqJw9BT9m/5JntT9sMc
 n1frogvcHYsFs0jFVyxHsd6DXWtzVsMN4g2nYVQquk8qefgu9ds24XuWrO1RWRW4dVoQw88WBF1
 5ECgdVoM=
X-Received: by 2002:a05:651c:2556:20b0:38e:1da0:916c with SMTP id
 38308e7fff4ca-38ec783c502mr47672421fa.13.1776823101726; Tue, 21 Apr 2026
 18:58:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-wdt-v1-0-0bd01ec6a7c4@nxp.com>
 <20260421-wdt-v1-2-0bd01ec6a7c4@nxp.com>
 <aa7822a0-a114-4989-b23d-9e242bd2dcde@mailbox.org>
In-Reply-To: <aa7822a0-a114-4989-b23d-9e242bd2dcde@mailbox.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 21 Apr 2026 22:58:10 -0300
X-Gm-Features: AQROBzCTdPhRFkvaQJakcvus0RvZYmOYnIUIx2SoqMBTxLotnwcw8tRwnCq-gHQ
Message-ID: <CAOMZO5AkNAX6Rxq=hOve9x9oJeWE7AdrYEnuJU4vgD8nyTZDqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm: dts: imx: Update watchdog nodes for dynamic
 base address lookup
To: Stefan Roese <stefan.roese@mailbox.org>
Cc: alice.guo@oss.nxp.com, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de, 
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Simon Glass <sjg@chromium.org>,
 Fedor Ross <fedor.ross@ifm.com>, 
 =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Primoz Fiser <primoz.fiser@norik.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?UTF-8?Q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Jacky Bai <ping.bai@nxp.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Mathieu Othacehe <m.othacehe@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>,
 Wadim Egorov <w.egorov@phytec.de>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Tim Harvey <tharvey@gateworks.com>, 
 Anshul Dalal <anshuld@ti.com>, Franz Schnyder <franz.schnyder@toradex.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Joseph Guo <qijian.guo@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, 
 Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 22 Apr 2026 04:42:51 +0200
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

On Tue, Apr 21, 2026 at 11:10=E2=80=AFAM Stefan Roese <stefan.roese@mailbox=
.org> wrote:

> I understand why "bootph-all" is in the u-boot special file. But the
> other main properties defining the watchdog device should be in the
> common dts(i) file, no?
>
> Checking mainline kernel I see, that "bootph-all" is used there as well.
> It seems to be accepted. So why not move everything into the common
> dts/dtsi files instead?

I agree with Stefan.

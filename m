Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0D6C3DA61
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 19:47:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719E1882BE;
	Thu, 18 Jul 2024 21:47:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Oo3YCwIQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 411CB88AD4; Thu, 18 Jul 2024 21:47:44 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 308E087873
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 21:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5a2a90243c9so271924a12.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 12:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1721332061; x=1721936861;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xsERpho8TOr/sHpD54DCtNz79AzwpQpjEPL3CL+xyrI=;
 b=Oo3YCwIQlgfbwvB2OMBcH4yUkqcQF7M3cJjs7swkF3wEww6PhTGI1oVQ7P5JcKixd5
 UviG7ddN/lXbU6RvHcCD+p6LU8u/ROoEIhUOa/u9Ds1gwuCJ6wMFdBiYcCbJRhHjQsl3
 PTmcixtMNsMfQtm7Zdeo/EnCdHPK3dURtZfTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721332061; x=1721936861;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xsERpho8TOr/sHpD54DCtNz79AzwpQpjEPL3CL+xyrI=;
 b=U6r5lH+++TiCKj4sEj3o3zpPxbfwmB56tx0heFWvLYrGMu4dVMPKsJ+kmSbCKqPT28
 jFE/cQPbzIPMHxct/2Fmv39EfKIyJmcLkuz5km9HRsQ0qzUBR8WgZ1oJMxqrAIoJ51sR
 JFTGig6/USu8+3s/bOgFAEWM8/1O4TB1HVLoourxOv+eGI1rLLURQEIgNqzpGLZKPUSa
 jXqIMeciTptAk+CJh4Lk+YKkxpT853mJdk3vXIjsz15RLX+jiItvaScRqpDuXaKUT3k2
 UMD9ia40GZ7yHNGTde0IHiG15pWcp4KSHZLzIwv7/sKbUZmHEmHidMb8TH279ArZW3Bi
 aG+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4YJyHYPfZz5CX/CP2BlcZN1U3Pz322BJjQfdeTxUM9uQKx/PiRwlARwgC8+YLFemhSylL60U5hmQwvDqaMmqE9Jd/DA==
X-Gm-Message-State: AOJu0Yy8/ZDPQwbuBiyNrcPVwmAdKcIp0y7klycRFHCrmXipVz+hukh9
 g5TF7uvvt8rua44/krzlpAx7foQXVV6W3YHQt+XANKHJb4nTL3tVDrwLsZX9ZHnza7eaBMB9fMq
 nkex+Rv+s9KUpusgB6f1ne2sRVRoTSuPE7G0/zg==
X-Google-Smtp-Source: AGHT+IEyiHWFQ8OdfNp1MRMwIJ+7XM+nvngsgCSwa7Uu4YPSaeMKVXHPTOgdgmthyFk+EY5Mv1zQhI2cDg5Vx6VcbCQ=
X-Received: by 2002:a17:906:40cf:b0:a77:af07:b98a with SMTP id
 a640c23a62f3a-a7a013e90c6mr421722866b.73.1721332061475; Thu, 18 Jul 2024
 12:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <PAZP264MB2974E713F54A40AB9B17DB85B1DB2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
 <20240710-talcum-repent-307fd836d683@thorsis.com>
 <PAZP264MB29745BAD4E854E1884E5A9CDB1AC2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <PAZP264MB29745BAD4E854E1884E5A9CDB1AC2@PAZP264MB2974.FRAP264.PROD.OUTLOOK.COM>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 18 Jul 2024 21:47:29 +0200
Message-ID: <CAOf5uwmN5t5Mvg8GZe-F=B5ykmeuLfw69ctS5GZvOYZcZczsmA@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: Use ONFI ECC params if available
To: Zixun Li <zli@ogga.fr>
Cc: Alexander Dahl <ada@thorsis.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 open list <u-boot@lists.denx.de>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
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

Hi

On Thu, Jul 18, 2024 at 9:40=E2=80=AFPM Zixun Li <zli@ogga.fr> wrote:
>
> On 10/07/2024 09:28, Alexander Dahl wrote:
>
> > Despite the missing space between 'if' and the opening bracket (checkpa=
tch
> > should have told you?) this looks very much like what got into linux wi=
th v4.11
> > but was changed/reworked multiple times afterwards.  I wonder why this =
was
> > not ported to U-Boot when introducing this driver?  In 6a8dfd57220d ("n=
and:
> > atmel: Add DM based NAND driver") it was claimed the driver was ported
> > from linux-5.4-at91, so this feature was probably dropped intentionally=
?
> > Does anyone know why?
> >
>
> Hi,
>
> Sorry for the format issue. Is there any comment from maintainers ?
>
> I'll push a v2 if this patch is considered.

Looking on it. Anyway expand the commit message with original information o=
f it.
Like:

Upstream commit <short sha>

Try to report some original context from kernel

Micahel


> --
> Zixun LI
>
>


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

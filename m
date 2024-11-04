Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD669D132B5
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 11:57:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9118287FED;
	Mon,  4 Nov 2024 12:57:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h7NcwgmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA94588C9C; Mon,  4 Nov 2024 12:57:09 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48D4588A0A
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 12:57:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-539f72c913aso6608161e87.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 03:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730721426; x=1731326226; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PFpI6awB9/3vGtD7TvRvi1BdIDnNCUK5+5Dvod9V3Ek=;
 b=h7NcwgmLns7sH0x8HIqp0WP9h56uxxdkPiQve9nuvk6PH7bUEqtHLj4vpk/dEOeXMF
 zt5AfuY5vuXQG1a8nwrd8jq5ydr5rBK+xuu64ez3Qn+qISBivD8duVQKJ/9dre1uGMVz
 B2flRC4dMOnxGcdYrUJ3oFrwgjM6a18qWnv9q+wtqshTWrMf22imrbrTYwz8K8MWoSad
 rxulpm0veu5iYNR79TpQOjvRDgrrzDAb9r5FF1zdaw8z+1oSq3J65iclZ9UlmGSGJ+w7
 8T4DgRw/5YHdwozGWvuajl41fHNB3VVjE6+Bng/BxGMCHAgyS7VwxDood0m/ZAHKgKVc
 WrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730721426; x=1731326226;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PFpI6awB9/3vGtD7TvRvi1BdIDnNCUK5+5Dvod9V3Ek=;
 b=FNCp9plC8WzssbApQq2rwMn6jF0ttRYaocAFqy0CwB20jeW5yLwOu9CdsqRw7AZ25i
 0MuH8/UEbiR9sG5B2XAYTBCYphkOd/r1R13rCNixdkl0kl63Q2OozHf68vD4wCS4vYD4
 48B6F75lOPNPVnVaK05tV+C+AaNAuX57ogwC2IBOV7BQaq//ndrOgRlnp4RwZegGuOxb
 qAR6b9AOjhO79+jXrIgNCbuIzFOBbwjr1TggfBrMY91kThXK+aKuy+q/hTRufafBBS1r
 3huKB88nMmp5q3RkCYVfjheh+6ZfDUDAWSAanZ7SpmFioFaMn5DRAXkujkC+yU+QLnqL
 EZ8w==
X-Gm-Message-State: AOJu0Yy7vm+2CMTJlbIEtNLkbMQ/5PO9UlsldjHoUMGB1y8cVtp8Wp1J
 Nu3Vu1dBloAF+N8X+kyJTskKLQfdLDTxxEItJ2J2UI85/5VxrXdUJV7r/p5yK3nBv3JsEFDSYHb
 VmIclpO5ZVebrgkLunpnZAJJDFO0=
X-Google-Smtp-Source: AGHT+IHGQzNoxdR8BT4/05O8CHGH8CCrD193MR/+s6zXo8dnRhHVzlRvpTvB9yCmd33hex3iiuZmLXruOIclSbOVZ6Q=
X-Received: by 2002:a05:6512:3d94:b0:539:f754:ae15 with SMTP id
 2adb3069b0e04-53b34a1908emr18343968e87.41.1730721426167; Mon, 04 Nov 2024
 03:57:06 -0800 (PST)
MIME-Version: 1.0
References: <a0da63e8527876ed60cfce25700793600ea2304a.camel@opvolger.net>
In-Reply-To: <a0da63e8527876ed60cfce25700793600ea2304a.camel@opvolger.net>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Nov 2024 08:56:54 -0300
Message-ID: <CAOMZO5BFO_9xHiia-xYy+PU+FQdVnszSoBTXUscPUA+G4f=HpA@mail.gmail.com>
Subject: Re: Fedora 41 drops OpenSSL ENGINE support,
 u-boot can't compile anymore.
To: =?UTF-8?Q?Bas_Magr=C3=A9?= <bas@opvolger.net>, 
 george.mccollister@gmail.com, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

Adding George and Tom.

On Mon, Nov 4, 2024 at 12:30=E2=80=AFAM Bas Magr=C3=A9 <bas@opvolger.net> w=
rote:
>
> On compiling on Fedora 41 you will get the error:
>
> fatal error: openssl/engine.h: No such file or directory
>
> It was already legacy:
> https://docs.openssl.org/3.0/man7/migration_guide/#support-of-legacy-engi=
nes
>
> Fedora 41 has removed it:
> https://fedoraproject.org/wiki/Changes/OpensslDeprecateEngine
>
> So after updating to Fedora 41, I can't compile u-boot anymore. (I can
> compile it in a docker-container). But this will be a problem for more
> people.
>
> The code that gives the problem is here added:
> https://patchwork.ozlabs.org/project/uboot/patch/20170106191417.6115-1-ge=
orge.mccollister@gmail.com/
>
> On GitHub I have created a branch that can compile now. But this is my
> first c code in 20 years (only done this on my highschool for 3
> months).
>
> https://github.com/Opvolger/u-boot/tree/opensll-without-engine
>
> I think you can make a nicer/better solution.
>
> Greetings Bas.
>

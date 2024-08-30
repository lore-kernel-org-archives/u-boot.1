Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAEF3CA0EE6
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 07:05:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD52788D4D;
	Fri, 30 Aug 2024 09:05:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="PW7VfGov";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EF14885A5; Fri, 30 Aug 2024 09:05:43 +0200 (CEST)
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com
 [IPv6:2a00:1450:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2246388D5A
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 09:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-533496017f8so1940377e87.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 00:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1725001540; x=1725606340;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiX3uSFvcTS3H2qr+wo/tnI94ipNXptdvhjyn4Uo1EA=;
 b=PW7VfGov8oi2PpmziqjNCUAscOx5pwicCfzejzHKdkKFKSHd0hWKQlpwXFha0RWw5R
 3urIuU6raPHOaywwJPBKOjZ9eOD6ipNMsa+DqVhZRY6D9nf62Pd3PDH/0kIpEtjJZesK
 +xYGBaWJEjhL9a9tYKupZePIVCnT57itqLMew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725001540; x=1725606340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiX3uSFvcTS3H2qr+wo/tnI94ipNXptdvhjyn4Uo1EA=;
 b=pir6RoGBdD5m4TLuz3eNQ38vRT9IQOS4RjSvm5vLhAuUplxx1xwWDlUG/AHFV5aZcu
 8Dcude3VDmzrkoC4QyH4/THnzobfqcw1+VCW0iURwPhMHRaDnz6LDBsVd5fiiHqAa/fL
 FtLQUmsGOvO95z1Mkxejc5lIx4w0vHF2UUzqY2v91+mboYFx1f3/yKOKFkfLmS4u0rdM
 VyH3DFBVabT7t5KoMPhEXesnJqVFTdzHm66OMyaO0SEo3dNMwcWiWAGmI4zi8cPt+Mhr
 CVs06wHfQTi5BCGH47FIxAjptStNo4HFCo+AjGPLXfDR/HYnFXHL5zLeOJnJUWPKP/Km
 8Rfw==
X-Gm-Message-State: AOJu0YzN+fG9PBsUALuKM//G8mTO6QoyeN8qiWvrt0IDEvS5LD4H972a
 42F2rZxnMc6gxixWgje/x/HxPODGR2xC2fCNenoGbPLbsD7b7mVDT5E+fUEuRsyfDJvDvhvwfcA
 u5KTwW7WPe/zbBpbi7whGVU7TQgyyuaZMDNIe0w==
X-Google-Smtp-Source: AGHT+IHLC31xl2dtIhw4HNPOnH4616BJA0O7VwOoLGqxhRGEwDelmy24Uzm14WOQkfvYqPWLNWcrVS9TEepVw1HQRX0=
X-Received: by 2002:a05:6512:2206:b0:52e:7448:e137 with SMTP id
 2adb3069b0e04-53546af928amr824223e87.6.1725001539532; Fri, 30 Aug 2024
 00:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240809121556.3215132-1-marcus.folkesson@gmail.com>
 <ZtFt4rBOzF7Qgm-K@gmail.com>
In-Reply-To: <ZtFt4rBOzF7Qgm-K@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 30 Aug 2024 09:05:27 +0200
Message-ID: <CAOf5uwkhkCuW-st6ZnEVcQv6gDuRXSog_AQh_KQCUECFuyZ3sw@mail.gmail.com>
Subject: Re: [PATCH] mtd: nand: raw: atmel: remove unnecessary return value
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: u-boot@lists.denx.de, Alexander Dahl <ada@thorsis.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Eugen Hristev <eugen.hristev@collabora.com>,
 Igor Prusov <ivprusov@salutedevices.com>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>
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

Hi Marcus

On Fri, Aug 30, 2024 at 8:59=E2=80=AFAM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> On Fri, Aug 09, 2024 at 02:15:43PM +0200, Marcus Folkesson wrote:
> > The condition 'ret' is always true as it is never set to other than
> > -EIO.
> >
> > Remove 'ret' and the condition for copy.
> >
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
>
> Any more thoughts on this?

Reviewed-by: Michael Trimarchi <micheal@amarulasolutions.com>

It will be included in the next pull request.

Michael

>
> Thanks,
> Marcus Folkesson



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

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77694CCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 14:14:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F261183D90;
	Fri,  7 Nov 2025 15:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="K23bfMXQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2324883D17; Fri,  7 Nov 2025 13:53:22 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AAF883CB1
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 13:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-37a3340391cso7036961fa.3
 for <u-boot@lists.denx.de>; Fri, 07 Nov 2025 04:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1762519999; x=1763124799;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7NUwGClAeIrWSxDC2aZBhbXIS8Ppqo/In19gecpW8iw=;
 b=K23bfMXQTere3iAtyhhAiI3dASkEwpWytRM10WWVexFwxT6zPLt/EKw2uStFwIhwIP
 /hSM+ivjilQFjFERAZ38F925l/Dz14zhRLVbjQkDgAdG5XvPhz1CgAkshEXvUh2q79jZ
 614FTgY+EQA23JxTmEvNohpnV+Q6LGThtDKCWj8Zod+WUQYiMOdiAn3BAvP77V0vB5OE
 +0jcuXlrzry93PMr/t6Jn+1HH/C9AXczqZS1FetrqtBPTTr8tPIwazir76NB+mmA5kaC
 //vX3JonqGrKpNOeKlcQClsu+duk3vzRoVYU41Cm4AcS0kn+wr9pNhK5aX4OQVFvYmz8
 PGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762519999; x=1763124799;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7NUwGClAeIrWSxDC2aZBhbXIS8Ppqo/In19gecpW8iw=;
 b=nAMBE0K2uvLQcGBUycTlbhteidjG+A1f0C/RF9lgYBSnKdRyNyWbYJINvHPXil5H2d
 o2DAYjyFFqy5CXTsdwnHmGF+isesPGaVK0D8qBFKYJ5tvGNzKDm64pInh0LwBzHUpM95
 ow8ISVcV7ltvv3KGOhxA6Y7HfEuoR6LgRDljitsiBBJshFTyobfzrbMOuMb/MBwmHY02
 ZjDtLw2HI9AJH1fsyDKTtdNRdPK3la5F1hGLa0ErDh5Nr51dPiyqKdB2Mlw7sFvFC9L6
 +2XWDmnQsnpridj57KFaGOtG8gAevuLFp73XBdJZk22fcFfQSiO+9ywiEHZP7j+w8tX6
 JI+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUn2akKtx3S6Gln+kiK+A2OkQm1hEe413cWzbVd0/6WZ2ugO+8MneW52HWwp8qx8wojKCCxJbQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzNDUHbCdVuJNl55ceJYQDnrWVlD6jTB82pABIQIT0sInF6axh1
 8S/NihXjHRi/+8KLJMuKsUu9Um4dcSPZZv/84xvNa3xhJGVHOXjT1ag0LeKsoAY/JqV9TG//B3/
 QauWIb+5UrgC6icxwvTlBZN/2b9YQXbU7c7qxi6CgpnLZPixdGuQ1uOA=
X-Gm-Gg: ASbGncuac3dOZQU3n+ick+1ExKY6K+RHKF0FbvC8+XyE64REUHnfL+zQhVM+k9g5hA3
 zkYk5dvoAzw8Y/WpULPKloQrSQGFOeBRHg8CvS06EjgB+kKWfuJy7XdBgZ2wUI9l0HV6HnvIoiV
 xZkeqfOET25lnNYHjTv3F3qCi0GPBEPg7z0NQSjORwerJqnJgEboBBAOB1d9w8hK495M3yLZgNF
 xE7L5cIiLjz1/BElHp3q+U0hGg3a1Z+7JwIlBLr1glZ6r3fwNHw8RKO5gytLPRp2dhz
X-Google-Smtp-Source: AGHT+IEO2O++uOPnH0OfI/8s71YSbr+TS2D3esD+glgAauf1SByeop9WxiP/A/zCjyYg5JB6kKJK3LdtC6N1GIra/c0=
X-Received: by 2002:a2e:958f:0:b0:37a:2c7d:2d69 with SMTP id
 38308e7fff4ca-37a7332e1a1mr7107391fa.40.1762519998688; Fri, 07 Nov 2025
 04:53:18 -0800 (PST)
MIME-Version: 1.0
References: <20251106-pmecc-v1-0-a1f3cf430be9@hifiphile.com>
 <20251106-pmecc-v1-1-a1f3cf430be9@hifiphile.com>
 <e0a9b9af-330c-4504-8ef3-ba4c3433ce4f@linaro.org>
 <20251107-condone-percolate-51ec103f3ef4@thorsis.com>
In-Reply-To: <20251107-condone-percolate-51ec103f3ef4@thorsis.com>
From: Zixun LI <admin@hifiphile.com>
Date: Fri, 7 Nov 2025 13:53:08 +0100
X-Gm-Features: AWmQ_bmWWAZh1WwF3Qrb-ZtVGj97G6fO2PMNEDgHie84fDxUzstbQCZhx11VlXE
Message-ID: <CA+Gyqeaw_r=j+47Mc2tyrmcYQXy9L3GvAD+bHDTPAjcFp=OOPA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: rawnand: atmel: set pmecc data setup time
To: Eugen Hristev <eugen.hristev@linaro.org>, Zixun LI <admin@hifiphile.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de,
 Michael Trimarchi <michael@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>
Cc: Alexander Dahl <ada@thorsis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 07 Nov 2025 15:14:23 +0100
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

Hi Eugen, Alexander,

On Fri, Nov 7, 2025 at 12:01=E2=80=AFPM Alexander Dahl <ada@thorsis.com> wr=
ote:
>
> Hello Eugen,
>
> Am Fri, Nov 07, 2025 at 12:52:05PM +0200 schrieb Eugen Hristev:
> > Hello Zixun, Alexander,
> >
> > On 11/6/25 13:12, Zixun LI wrote:
> > > Setup the pmecc data setup time as 3 clock cycles for 133MHz as
> > > recommended by the datasheet.
> > >
> > > Backported from Linux: f552a7c7 ("mtd: rawnand: atmel: set pmecc data
> > > setup time")
> >
> > Maybe use 12 digits commit hash ? I cannot find this commit in Linux
>
> v6.16-rc4-10-gf552a7c7e0a14 aka
> f552a7c7e0a14215cb8a6fd89e60fa3932a74786 from July 2025.
>

I'll update the cover to include the issue and use a 12 digits hash.

Also remove timing_res_idx in atmel_pmecc_create.

Zixun

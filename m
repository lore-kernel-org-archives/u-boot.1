Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF3CCF6493
	for <u-boot@archiver.kernel.org>; Sat, 28 Sep 2024 15:16:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEBD988A9D;
	Sat, 28 Sep 2024 17:16:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KE5gNYoG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 170FA88AC2; Sat, 28 Sep 2024 17:16:25 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F9DD88A47
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 17:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5c5b9bf9d8bso1863783a12.1
 for <u-boot@lists.denx.de>; Sat, 28 Sep 2024 08:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727536582; x=1728141382; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=skRsvAmVgUP1xY0akFbyffT7DKT6wTS9YCHxZaMhdqQ=;
 b=KE5gNYoGlbmY5Lf6KDBjOTX7K0Eqfmg38TabnKDtUJN3scVUsMiSGF8rrr+4WeS4rE
 1d4QLZIFiYXA9S0pIyKaZQujcJkcd/H+8Y/r2A2JqTK90OuOdZcveQWcSpGafOAPw7op
 R72FxCI6WmiFp+mnVIbP1hxPbCbokKMDqxKgvePY+R69pDM2fKAEWTiCWqt3ubza3kFb
 Pa6iJ7+2mRqA0wFPjpZ5XcQ9pljFNj6CeTv99c6fdfrtpix3nCyKyPQB+zHy0HaPTstc
 A6kGBsp5cTLcgUXHOXT5uWMQUNQHQ1prKewkGyuyOOpZUGpOxk3lnZK+iAGBHSWiKzR9
 GJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727536582; x=1728141382;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=skRsvAmVgUP1xY0akFbyffT7DKT6wTS9YCHxZaMhdqQ=;
 b=bn1K70SBxPUD/47Q4mCEeSlC0eQc6MtPWg7ID1kF6ClvisMYTUFbXJCetVmIdeCfhp
 AlTHXNkblqpt/P2UPDmP1OUE/UAqHxxC3apUCGR6DqbpO6AqcNBI2ccI79GUC+x+kfJv
 5QloaAtCBBOtZZMIUkbK1LSgav7MLJxWcy7qMJFNNKOxFWtsZIXM9p7HtMtEZfclD/yE
 reGDUjSULBxWqO/1Ld3xYbkmfLg2BX6xZblXhyhMsHfWKAfc0XojU/SgT1BBn+nawG21
 IgbPFC+fFO4gNxNE+Ses+uwr2CKw9sLD2rg6H+sgnJHdqUMnlJZQ3cbZ6fvDmBbY28sI
 N7Ww==
X-Gm-Message-State: AOJu0YzGNstRGl/GpCL8LmikBIZ65wZykgPeFQrHZ7pj6vASZiztZVtU
 Toy6Dn35zkS6UHrvwsWytM2tYPwBqv5j2NaLSssfU/XMu8tULGFCorfDPdpeUVH62JFgvAW7MWH
 SQVpKsucHT0eEnR/caSh4v4FWpGc=
X-Google-Smtp-Source: AGHT+IGl5NRZNuFpctkrA7sz6cSVoMk9vYoL0jC2PpDPYNMKPO0lDl+v9Szk2g2m/ZP8nRH4r/sVHly9x6gf6RnelHs=
X-Received: by 2002:a05:6402:13cb:b0:5c8:8214:dcd4 with SMTP id
 4fb4d7f45d1cf-5c8824e7df9mr11535631a12.19.1727536582303; Sat, 28 Sep 2024
 08:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240926223009.1270197-1-sjg@chromium.org>
 <CALeDE9M4DrdsDrJEGehWuXyfNSd1K=sWE8RpSk6W5uySBoGUQQ@mail.gmail.com>
 <CAFLszTiqqiQD3S03y3_g8LDehJ3dE1stONUzm+MWHEDppZCMjw@mail.gmail.com>
In-Reply-To: <CAFLszTiqqiQD3S03y3_g8LDehJ3dE1stONUzm+MWHEDppZCMjw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sat, 28 Sep 2024 16:14:00 +0100
Message-ID: <CALeDE9M=AY=oeLywm46Eym91NwFjrJgysiuucd1EMejCnCNC3Q@mail.gmail.com>
Subject: Re: [PATCH 00/27] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>, 
 Alexander Gendin <agendin@matrox.com>, Alison Wang <alison.wang@nxp.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Doug Zobel <douglas.zobel@climate.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>, 
 Kamil Lulko <kamil.lulko@gmail.com>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Mario Six <mario.six@gdsys.cc>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Raymond Mao <raymond.mao@linaro.org>, 
 Sean Anderson <sean.anderson@seco.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Simon,

> > > There has been an LED framework in U-Boot which uses driver model for
> > > about 9 years now. Recent work is underway to improve it and provide
> > > more features. It is probably a good time to drop the old code, which
> > > is only used by 5 boards:
> > >
> > >    ./tools/qconfig.py -f LED_STATUS
> > >    5 matches
> > >    eb_cpu5282 eb_cpu5282_internal mx23_olinuxino pinephone
> > >    socfpga_vining_fpga
> >
> > Why aren't these boards being migrated to what ever the new frame work
> > is rather than dropping quite useful functionality on these devices?
>
> I don't have any of those boards, but perhaps their maintainers might
> like to weigh in?

So? I mean I can test the pinephone at least if you convert it, but I
don't think the functionality should be just dropped.

P

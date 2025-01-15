Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02F37C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 21:36:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00DB78033D;
	Wed, 15 Jan 2025 22:36:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dc0JD3bW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51110806D8; Wed, 15 Jan 2025 14:50:38 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF49680214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:50:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aaf900cc7fbso1155894466b.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736949035; x=1737553835; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n6GyjMMcZ5Ne7y3J6xECHIpnyZsqzOVOMePYqzx69Zs=;
 b=Dc0JD3bW6eojPf5nnBFzyLruRn5WEgRtONi4JcVsWk1fT6/7lTOMDMd6U1YHqevRbu
 91SYssAae/OX4HrxTZZ5kGIXcsIc7NWV9yi5GqhJPgSH0ZXiNTW6GDpZFuKEwzdZ9si6
 oZOa5rq4bzcR1tzjg1y9z6dg6QuJwQqTEloZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736949035; x=1737553835;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n6GyjMMcZ5Ne7y3J6xECHIpnyZsqzOVOMePYqzx69Zs=;
 b=GNB5apec+4VFsn/YLJc2YFSIN/KrkQBWnuVZUDUhscsLjmvTx8NoRIGElUoDJJ4q19
 KfavovMycmM07nDqS4O0IQIItRP2YATPK7a67iQpSWXoFMpAwKFf3/K+QlgwwAiH6GDU
 7twPbpIEUkdpx09xNH9rlajrK26PH7rvANqgULNWS6nuaqxlo8BV6BG2WRgqca+Ci+eh
 F62cQM/MoDJYK7CtKYBG3DEUGxYPywnIC+qiir43JKWtEvOynzApLL7YR1Bipf53Si8a
 T/fsc3KkYsPfe2LtKTO/cCwRmSRQrsdH7DiYbVwZeX/8Xw2tZ3ltJXaucO1+v4hxLoC0
 qdMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfNi9kM85YmGIZNiVfi8yf/caz97a0xB44VJsNT7mf69PueX4/e6LMz1vI5Wik/MU2WlyXwN4=@lists.denx.de
X-Gm-Message-State: AOJu0YwSgJNbZ4yO8eWDHYM3LQT1cP9khS9Kp8ijk5xy3WJWgFa4KYTD
 iumdLhE7QFH1nmDQ8e+OPg2atvVDnl5uQEsdZtif+9wwW3eooJdEmEX7dtqp7LYO5lV5vNT5nPw
 x28H0SSIMGXru/59e8vL69QvZNSTdsfqTw2FYKxrIz3/CEbm1ug==
X-Gm-Gg: ASbGnctN1zk1Syou+KbD7VHClX5XVAtVpPjrj6jt4m5Jh5Nsv7rm6eKPZ47a/UaMncC
 OqYTy9J/BQJMQCq7JSnMv3FKq63EhbpnBMAeiMxk=
X-Google-Smtp-Source: AGHT+IEb2hbG5qHr3THitJKxug3alTByYWPPct2dv43m3mCI9Q54NDBpCNN/bv5iqweoBRWKimF/X5nTTiPCJbX26tY=
X-Received: by 2002:a17:907:c0d:b0:aaf:1183:ec2c with SMTP id
 a640c23a62f3a-ab2ab6bfc89mr2383962366b.5.1736949035194; Wed, 15 Jan 2025
 05:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
 <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
 <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
 <20241203194847.GA4022002@bill-the-cat>
In-Reply-To: <20241203194847.GA4022002@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 06:50:23 -0700
X-Gm-Features: AbW1kvZD2TxAXPYqX4CIRQrWgitRqTpk9mnEuW2FFclGO2erZ9XAfOCKTdV-dyI
Message-ID: <CAFLszTj=x_ESLVmJ09zS8=7Nydu9Rw6u7CKJYb7G9nMykHe++w@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Alexander Gendin <agendin@matrox.com>, 
 Alison Wang <alison.wang@nxp.com>, Andre Przywara <andre.przywara@arm.com>, 
 Andy Fleming <afleming@gmail.com>, Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Charles Hardin <ckhardin@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Doug Zobel <douglas.zobel@climate.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hans de Goede <hdegoede@redhat.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Javier Martinez Canillas <javierm@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kamil Lulko <kamil.lulko@gmail.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Mario Six <mario.six@gdsys.cc>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Samuel Holland <samuel@sholland.org>, Sean Anderson <seanga2@gmail.com>, 
 Sean Edmond <seanedmond@microsoft.com>, Stefan Roese <sr@denx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tien Fong Chee <tien.fong.chee@intel.com>, 
 Wan Yee Lau <wan.yee.lau@intel.com>, Wolfgang Denk <wd@denx.de>, 
 uboot-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 15 Jan 2025 22:36:25 +0100
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

Hi Tom,

On Tue, 3 Dec 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Nov 07, 2024 at 07:33:51PM +0000, Peter Robinson wrote:
> > Hi Simon,
> >
> > > On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com> wrote:
> > > >
> > > > On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > There has been an LED framework in U-Boot which uses driver model for
> > > > > about 9 years now. Recent work is underway to improve it and provide
> > > > > more features. It is probably a good time to drop the old code, which
> > > > > is only used by 5 boards:
> > > >
> > > > I don't believe, from what I can tell, they are feature comparable, at
> > > > the very least I have not been able to get the Pinephone working with
> > > > this so as it stands I still don't think this patch set is ready yet.
> > >
> > > I don't have that hardware, nor the other 4, so cannot do anything
> > > with this feedback.
> >
> > Don't you have any HW that has a LED on it that you can substitute to
> > see what it does?
> >
> > > Can you please be clear what you are asking me to do?
> >
> > Either produce patches that work on the the pinephone, or docs I, or
> > other developers, can use to implement the functionality.
> >
> > Currently on the Pinephone the green LED lights up in the TPL/SPL
> > (very early before ATF) stage and is lit up right through the the
> > various FW stages, with your patch set I get no LED what so ever.
>
> Please note that needing to confirm that we have equivalent
> functionality between old and new frameworks (and
> https://lore.kernel.org/all/20241110115054.2555-1-ansuelsmth@gmail.com/
> might cover that) is why this series isn't ready for -next at this time.

Link to series:
https://patchwork.ozlabs.org/project/uboot/list/?series=431000&state=*

Current status: marked 'changed requested' in patchwork. Applied to sjg tree.

Peter, if you would like to retest this series now that [1] is in
-next, please do. Or if you can make time for some development with
your device, that would be welcome.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=432093&state=*

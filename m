Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C780E77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 11:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ED78895F2;
	Fri,  6 Dec 2024 12:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xs/OY4TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A941895AE; Fri,  6 Dec 2024 11:23:26 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BEA5F895D8
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 11:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cece886771so3520466a12.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 02:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733480602; x=1734085402; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pzkoXdzTAFB7OE/eqOBSKtd0968FePJFiEquSN7LfpQ=;
 b=Xs/OY4TOzJb6sPAPLxurKSY8qx/1fSDfVRR9d96w3DNV8Db3I9+6OXuyYO8G/B5ZQW
 jQwNkvRpdVd0fM4xmDsfR097AMt3JZ1w2m4cckbnpxJFSrlOB3erXNKK7JEh6pgDrcYq
 oH69MzziNOTCYgB22hFIP2QB/FbXq5eMjGDsq6RRcCjaxjB4IdZZ7hrS8UT8RJbPB/hH
 /n+JbmjtUbyz1cgP7XJhGHD42aCLd6N6jiZYA5rn+u8Y2Sv/PJN6QnP7Qvi7M2PSnE0B
 590sOePMaWHXH1hrnQVnD+utykTviCZGDmPc/4a5HmY4w+adQPozC4h42OAvSihN8UK3
 Y21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733480602; x=1734085402;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pzkoXdzTAFB7OE/eqOBSKtd0968FePJFiEquSN7LfpQ=;
 b=ByXCIB6d2W9AlWSQNY0YhgV8y172aTSNIV5tu9mAZpn6K7gpVv1PdgEq/PG45K0Zou
 2JjKlG+bkJROTQFexBLIyrGRJ3Lqj9ZP9sa0wjI6GtynjltXqI3oPYjYpKCAz7mncXTD
 WJqixaLZVKsGQvBnuuKOTX3os6jTnPjKv+XwV4Ww1bwZdemYzrflAco7NDkxI4AF7sPc
 BpN+jKTIPTQU3xFAeImM4wClE6AUgbQKiIYvaj86pfFfy3Sk5LgQmBFMN786VytBw84t
 rk7D6hWLc5EHG4jpnQlKmxMm70yUIvyD9vkxjC4dsbyHtgmyiBq/L6oB4tsLNUxGF+Ip
 AiBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCSZ/zBVHcJyxV040AwlUfNoYF5efE19bQ0WpwxCku+J8DRsUIDphqH7YpcnlWMs32Y9sDI1g=@lists.denx.de
X-Gm-Message-State: AOJu0YztkpVm9PRyuFQBaKmAUSAGWxVh6ENeBnQ7bt8aQLL/NBzL/3GM
 Y9+IXkKR367PBER81KREsuzv1MlaVfqxWEtYr9A0BeqVUCenq9oZzZgHJ53yx7V1EOW+9z3H5j+
 +ieIOMvLztN0ZjAoLmK1Yxeg0GQ4=
X-Gm-Gg: ASbGnct73sBwvK/9y3F/3ehCYn7nwikC9xPw2G/TtYRddWRH/4fDu4a/pVvKdugHozP
 +jCrL7U7hUDZXlgyMkAOXpNMPM3Cdp3Ek6Mk=
X-Google-Smtp-Source: AGHT+IEICA6knxGjNE8s9hiZCrkw9zC8tRpq44D7LCiqQSJdrBAYe2sw01lb39PW5frgrbBWKL0bEZi2IPDoBlz+kEE=
X-Received: by 2002:a05:6402:2708:b0:5d0:d0c5:f258 with SMTP id
 4fb4d7f45d1cf-5d12469949amr6118918a12.0.1733480601831; Fri, 06 Dec 2024
 02:23:21 -0800 (PST)
MIME-Version: 1.0
References: <20241103003322.626036-1-sjg@chromium.org>
 <CALeDE9MfWEAb91uzQPa6_jSo6beJv_GNHTY2TeKnSzFm6V97gw@mail.gmail.com>
 <CAFLszTito2+-qgOc=7bc3i9WmBZZCcAVWSY5hoH0neGjTg6zEQ@mail.gmail.com>
 <CALeDE9MORdUY440JAgHNXdoqWfJy5V9bC=TK5U242QG4Lc1Ptg@mail.gmail.com>
 <20241203194847.GA4022002@bill-the-cat>
 <CAFLszTgZiJuWMKZg6q--LEp+58Exgs8P+KaeCBgqmTd+B=SNSA@mail.gmail.com>
 <CALeDE9M1aZwVM40gbhMRWsvhKZXL=m1GOeLhDgzR5H2bTShFuw@mail.gmail.com>
 <CAFLszTja7=ku__b0+LUbjhVmhML9uPv2613VxSX1pBk1vt24OQ@mail.gmail.com>
In-Reply-To: <CAFLszTja7=ku__b0+LUbjhVmhML9uPv2613VxSX1pBk1vt24OQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 6 Dec 2024 10:23:10 +0000
Message-ID: <CALeDE9N_hN7MXiNDBF0NmSMitgw2ax=VePSavTJgzPZdTOY-uA@mail.gmail.com>
Subject: Re: [PATCH v3 00/25] led: Remove old status-LED code
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
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
X-Mailman-Approved-At: Fri, 06 Dec 2024 12:36:33 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Fri, 6 Dec 2024 at 00:01, Simon Glass <sjg@chromium.org> wrote:

> Hi Peter,
>
> On Thu, 5 Dec 2024 at 13:36, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> >
> >
> > On Tue, 3 Dec 2024 at 19:51, Simon Glass <sjg@chromium.org> wrote:
> >>
> >> Hi Tom,
> >>
> >> On Tue, 3 Dec 2024 at 12:48, Tom Rini <trini@konsulko.com> wrote:
> >> >
> >> > On Thu, Nov 07, 2024 at 07:33:51PM +0000, Peter Robinson wrote:
> >> > > Hi Simon,
> >> > >
> >> > > > On Tue, 5 Nov 2024 at 07:18, Peter Robinson <pbrobinson@gmail.com>
> wrote:
> >> > > > >
> >> > > > > On Sun, 3 Nov 2024 at 00:34, Simon Glass <sjg@chromium.org>
> wrote:
> >> > > > > >
> >> > > > > > There has been an LED framework in U-Boot which uses driver
> model for
> >> > > > > > about 9 years now. Recent work is underway to improve it and
> provide
> >> > > > > > more features. It is probably a good time to drop the old
> code, which
> >> > > > > > is only used by 5 boards:
> >> > > > >
> >> > > > > I don't believe, from what I can tell, they are feature
> comparable, at
> >> > > > > the very least I have not been able to get the Pinephone
> working with
> >> > > > > this so as it stands I still don't think this patch set is
> ready yet.
> >> > > >
> >> > > > I don't have that hardware, nor the other 4, so cannot do anything
> >> > > > with this feedback.
> >> > >
> >> > > Don't you have any HW that has a LED on it that you can substitute
> to
> >> > > see what it does?
> >> > >
> >> > > > Can you please be clear what you are asking me to do?
> >> > >
> >> > > Either produce patches that work on the the pinephone, or docs I, or
> >> > > other developers, can use to implement the functionality.
> >> > >
> >> > > Currently on the Pinephone the green LED lights up in the TPL/SPL
> >> > > (very early before ATF) stage and is lit up right through the the
> >> > > various FW stages, with your patch set I get no LED what so ever.
> >> >
> >> > Please note that needing to confirm that we have equivalent
> >> > functionality between old and new frameworks (and
> >> >
> https://lore.kernel.org/all/20241110115054.2555-1-ansuelsmth@gmail.com/
> >> > might cover that) is why this series isn't ready for -next at this
> time.
> >>
> >> Yes, I'm not sure if Peter saw that, so I sent him the link.
> >
> >
> > I have seen it, I have not had the chance to dig out my pinephone to
> test it again because I was traveling and had competing priorities on my
> time (and I do this as a hobby).
> >
> > But also I think we have a little time on this, the new functionality
> only landed recently and we've had a LOT of deprecated functionality hang
> around for a lot longer than that. I think we should get this right rather
> than jam it through.
>
> There's plenty of time for you to test. But we're really not losing
> anything by applying these patches (and also [1]). It is more likely
> to work for your board, but if it doesn't, we can focus efforts on
> what is wrong rather than trying to keep the old code around.
>

I'm sorry but I disagree, bulldozing patches in just because it's suitable
for you but breaks actual usecases is not the right way to do thing, at the
moment this works and it useful features for users. Actively breaking valid
UX Is hostile and not the right way to do things!


> One of the challenges I have, as someone who also does this as a
> hobby, is that few people are willing to take on deprecation efforts.
>

I do this as a hobby too, you are not unique here.


> This work is not very interesting, most of the time, and it is
> extremely hard to get things to actually land, since anyone can raise
> their hand and say that it doesn't solve a particular use case. I
> suppose most people do U-Boot things in their spare time and few have
> a lot of time to test or try things out. So there needs to be a
> balance struck, to encourage more people to help.
>

I'm sorry, I do feel for you, I have the same problem and I end up spending
most of my spare of late reading emails due to the deluge.

But actively breaking valid usecases by bulldozing things through, it NOT
the way to handle things, I'm sorry here what role you perceive you play
whether it be a full time employee, paid contractor or hobbyist isn't a
valid reason for forcing through patches, please do not use that as a
reason.

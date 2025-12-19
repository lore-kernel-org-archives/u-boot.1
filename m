Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E75EE6689C
	for <u-boot@archiver.kernel.org>; Fri, 19 Dec 2025 22:33:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB0D5803F5;
	Fri, 19 Dec 2025 23:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gxyDL7BV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F94C808AF; Fri, 19 Dec 2025 23:33:32 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A32680050
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 23:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-64b4f730a02so3512643a12.0
 for <u-boot@lists.denx.de>; Fri, 19 Dec 2025 14:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183609; x=1766788409; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eA1ohrZuomCupeHhFrED/T4jiiJrgso4MVJgdx3/kx8=;
 b=gxyDL7BVeeevUx/Cl7su7VvHJKlnyRHKrcj1p6ZcXoewFJnkV17nKSiuBSokJof1wh
 rQJbwhv80q7VWaZKzRNIOS+HNne9znCWoWaWuGDrcKgLpV4ktNQ6xVv4RmpT3HuMkwDM
 3R+fw4K4TDvYe/gigOYLUJmze+p5vl5tKFamo6proM4XU+tFoAHzLIbDEf3n2n2Eac7o
 Bt2EudzvFlKvGqs+qu1RHbE1spX1+r7J9dEU1thqtBQuCTA/8PzQ/R66bbphhKPk8r67
 8XJSIEBBldiEfjmL0xvy/1ujzaA6VeAuQHz41pRxxT5iLsaIDeMgU/B/J4S6TQuZIDHj
 bG6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183609; x=1766788409;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eA1ohrZuomCupeHhFrED/T4jiiJrgso4MVJgdx3/kx8=;
 b=bCUg4lf92ixqp8xxJOJvKTybnJXu3Um0LxqVc59ayrI4Q49iX1vOu59MJ+SqzB1Jt8
 nPHsLeqwZYNGk8RG0CVPg9/ZdmLzTn1U2r3/+uSnZQawDDMvQIX10U4+yJs9DlAFdf17
 f7eT/2ivJXGoD8gqNE06mTMhey84Pboebe0KBKRZPGqvWrS0bNCf84FwK4zZ/IxZczTT
 SDAvmKU02Spc8H78PteJaUJO56PRpVbItShDxwmwGq9feGDJuZwifP6H26lLY7ywlSc0
 wQtU+ESaCC/mdqXcqexeMhMk441VmtqZPOCukjLZa6IbdTTt86n7sQaatuM3IWcgFn5B
 qd9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3U0LENaCbcQ4rDAVdMU6n/CER2x7soI79rPY1KHxqtQGV4o7nK+TG4gemxI3PHp02EPLo4w4=@lists.denx.de
X-Gm-Message-State: AOJu0YwjyuqGcw0Ca2Xd0lEQ3F/V9mmNqDu+SNsoaeUTT3zbZnt2GMBW
 6Cd8Z1hkPO/99gT9dWKZ5X9q95pb9JU/xsUbUc/4R2a1M5MSVkjz/mzSyIlhxDWCJ9M38zbxYIW
 SoRM/H0NiAOWtJSMJIfBI/xRYT6zGQTc=
X-Gm-Gg: AY/fxX76B/XEq13Izzv+VyzDzM79AKCrGHQsitaWZ3xirPEjl6/miWk7pq/5fvOmKpl
 2IvuuQ0Lu2Ey51zJgddPZtbpq3iT0LdFtW5iy0PZJFrwegaXfyTtYlr/HkQZMCqkRqQ6XQkK7g7
 cmx1WCbSS/eLVacLr6V/EQiqpQTYCyorWWq+FOvL8Ge+wyiV33PSrZwmD96DB5z22s2zSOcP2FN
 1YbfNSpTXyUHhZTqXhkFPQjAizOasL4OMAOJnKm7Q5tBtkCszu6eutsChwX5/l4U44TF2/M
X-Google-Smtp-Source: AGHT+IG0WiUPIbpm6H9k5nhiwLCjg5asjGopBdvpwNFfGV4J1tM5j/WN5MjwA0xW0TL5Gzfxx11IA3LxIJ+x6QlylWg=
X-Received: by 2002:a05:6402:1d48:b0:64d:cf9:a79b with SMTP id
 4fb4d7f45d1cf-64d0cf9ab8dmr212897a12.26.1766183609319; Fri, 19 Dec 2025
 14:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20251209025634.14466-1-mibodhi@gmail.com>
 <20251212145056.GR303283@bill-the-cat>
 <20251216170641.GY303283@bill-the-cat>
 <4e912159-3b7d-4ba0-886c-d62ad1a3654e@oss.qualcomm.com>
 <20251219162939.GS303283@bill-the-cat>
 <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
In-Reply-To: <CAJaLiFw6if8r85LdAvus-QKhHixB9nMSLSKEnbPbESSY0zecAA@mail.gmail.com>
From: Tony Dinh <mibodhi@gmail.com>
Date: Fri, 19 Dec 2025 14:33:17 -0800
X-Gm-Features: AQt7F2oYiIKXsw-BgwOXsLTUz3g1blLL1vnGB7yfKAc7wqyR2psuSAg7jrSvBEQ
Message-ID: <CAJaLiFwyGy9aXD-6m8=Zj5ecdhuaKMtHDnhyz4YqzVHNW=ZDTw@mail.gmail.com>
Subject: Re: [PATCH] Revert "drivers: scsi: fix inaccurate block count
 reporting in scsi operations"
To: Tom Rini <trini@konsulko.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
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

Hi Balaji,

On Fri, Dec 19, 2025 at 1:17=E2=80=AFPM Tony Dinh <mibodhi@gmail.com> wrote=
:
>
> Hi Balaji,
>
> On Fri, Dec 19, 2025 at 8:29=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Fri, Dec 19, 2025 at 11:04:07AM +0530, Balaji Selvanathan wrote:
> > > Hi Tom,
> > >
> > > Apologies for late reply. Somehow missed the mail.
> > >
> > > Upon analysis, it seems the most likely root cause is Tony's 238GB di=
sk
> > > triggers the CONFIG_SYS_64BIT_LBA code path in scsi_read function. An=
y read
> > > beyond block 268,435,455 blocks enters this path.
> > >
> > > 'blks' is decremented both inside the 64-bit LBA block AND after succ=
essful
> > > scsi_exec(), causing incorrect block count tracking and (most likely)=
 the
> > > data abort observed.
> > >
> > > The fix is to remove 'blks -=3D blocks;' from inside the CONFIG_SYS_6=
4BIT_LBA
> > > block in scsi_read() function.
> > >
> > > Hi Tony, can you please check with this change?

Confirmed that the above fix works fine! I was able to boot the Linux
kernel from the 238GB HDD.

All the best,
Tony

> > >
> > > Tom, shall I raise a new patch for this now?
> >
> > Thanks for looking in to this now. Yes, please post a proper patch for
> > it so Tony can test and add a Tested-by if it works, that'll make
> > pulling to master before release easiest.
>
> FYI, I will be traveling a week from now. So it would be best if you
> can send the patch in the next couple days. Otherwise, someone else
> needs to do the test in time for the Jan 05 release.
>
> All the best,
> Tony
>
> >
> > --
> > Tom

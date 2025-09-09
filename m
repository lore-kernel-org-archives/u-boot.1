Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C38A7CAC587
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 13:00:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9243B83281;
	Tue,  9 Sep 2025 14:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="A3JgBOUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59C048312A; Tue,  9 Sep 2025 14:31:09 +0200 (CEST)
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F75C830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 14:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=miquel.raynal@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 83707C6B39C;
 Tue,  9 Sep 2025 12:30:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 26A2160630;
 Tue,  9 Sep 2025 12:31:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 10D78102F2584; 
 Tue,  9 Sep 2025 14:30:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1757421064; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5/jAsB29MXBmz/TVEmKVVIANML2jfhPxfNkxA543e7s=;
 b=A3JgBOUJHGfhBvUhbdgK2K/DVsvsydAjNTG34g8Gmp/b1fnk6HcwguQXhrVLsWP9Aq9yhh
 nvscm9EclOuvo2tkX47R6PUlGXc3jB9nAHCNpFstPpHjSlpUBKx6L8iutBhc72/U4ju1Z0
 pBXYtczDAimM7ayohytllr3Aura2afvGTdX3uAq5fKROLGpLJ9GGTjrnOB1LibLUfzBCS5
 hv2UNhFOM3mrVpt1RN79iQCNUyJ5FcScB1rx9jqOIMON83ZQvhnKBxEvNWPxHz/7Jmc5ge
 Wk3UXnWj4nYs8ALPOIfGTc0IjPUDIX/nIlgQp0U3GSvbO5XkzIaLxC0jXbHLWw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Tom Rini <trini@konsulko.com>,  Michael Nazzareno Trimarchi
 <michael@amarulasolutions.com>,  Vignesh R <vigneshr@ti.com>,  Steam Lin
 <stlin2@winbond.com>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH] mtd: spi-nor: winbond: Make sure w25q{01,02}jv behave
 correctly
In-Reply-To: <CAMty3ZDG=MtRbzNPaRs=dz9AUkcTA5cHX+0=wgqyEbMqPhyxrQ@mail.gmail.com>
 (Jagan Teki's message of "Tue, 9 Sep 2025 17:37:24 +0530")
References: <20250702092313.970234-1-miquel.raynal@bootlin.com>
 <87a534exwc.fsf@bootlin.com>
 <CAMty3ZDG=MtRbzNPaRs=dz9AUkcTA5cHX+0=wgqyEbMqPhyxrQ@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Tue, 09 Sep 2025 14:30:56 +0200
Message-ID: <874itbg64f.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Tue, 09 Sep 2025 14:59:55 +0200
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

Hello,

On 09/09/2025 at 17:37:24 +0530, Jagan Teki <jagan@amarulasolutions.com> wr=
ote:

> On Tue, Sep 9, 2025 at 3:43=E2=80=AFPM Miquel Raynal <miquel.raynal@bootl=
in.com> wrote:
>>
>> Hello,
>>
>> On 02/07/2025 at 11:23:13 +02, Miquel Raynal <miquel.raynal@bootlin.com>=
 wrote:
>>
>> > These chips are internally made of two/four dies with linear addressing
>> > capabilities to make it transparent to the user that two/four dies were
>> > used. There is one drawback however, the read status operation is racy
>> > as the status bit only gives the active die status and not the status =
of
>> > the other die. For commands affecting the two dies, it means if another
>> > command is sent too fast after the first die has returned a valid
>> > status (deviation can be up to 200us), the chip will get corrupted/in =
an
>> > unstable state.
>> >
>> > The solution adopted here is to iterate manually over all internal
>> > dies (which takes about 30us per die) until all are ready. This approa=
ch
>> > will always be faster than a blind delay which represents the maximum
>> > deviation, while also being totally safe.
>> >
>> > A flash-specific hook for the status register read had to be
>> > implemented. Testing with the flash_speed benchmark in Linux shown no
>> > difference with the existing performances (using the regular status re=
ad
>> > core function).
>> >
>> > As the presence of multiple dies is not filled in these chips SFDP
>> > tables (the table containing the crucial information is optional), we
>> > need to manually wire the hook.
>> >
>> > This change is adapted from Linux.
>> >
>> > Link: https://lore.kernel.org/all/20250110-winbond-6-12-rc1-nor-volati=
le-bit-v3-1-735363f8cc7d@bootlin.com/
>> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>
>> Same question for this one, no feedback for the past 2 months, I'm not
>> sure who's supposed to take these, Jagan and Vignesh you are marked M:
>> in maintainers, any chances this can get it?
>
> Unfortunately, I was off quite some-time. Need little bit of time.
> Vighnesh is off for years. In the meantime, Michael will help in
> review but need help on testing.

I didn't add Michael because he was not listed for this change, perhaps
he should be added to the MAINTAINERS file? (or maybe I used an old
version without noticing)

I don't know if testing each every change carefully makes sense in this
context. There have been many contributions probably worth the try (not
mine, Mikhail's) which are hard if not impossible to test by a single
person, while quite relevant. Reviewing seems quicker and more relevant?

Thanks,
Miqu=C3=A8l

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E862C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 13:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F4ED8107D;
	Sat,  5 Sep 2026 13:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pi4pvneukoym; Sat,  5 Sep 2026 13:02:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org D4325810C8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788613326;
	b=ssUsxpP/vN7iTmzKlIg7TaqLryz4hXApcsKRfeIjxBLmqCVB8xsd3EMTMBdRkOJN9rtz
	 BqVM2CXsCKAc7O5YRYUbXO1s8yfXuczxz5o1XoM1m5eOn5XJKhbNayJ37u4EbWCzsXiIC
	 AJogbmrFe3W3K2Aq5D4iyx5hPYuIrZY5Q4ra9h2ebEdSGEzjOfk2Flgvbcxd6jDnBw9Su
	 q0RCh3ORbNVhlUsHAGzm1107L0SbEKDNkzetOqLLePeLHaXQbIQMhXNfpRxGQnYqGELJQ
	 U74M3Wmulu0turK+DZF4z4vLr9ThRhy9nbzjwVEv63ELEQHCUXcTuCyFgwm5kWRjgqw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788613326;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Received:From:In-Reply-To:References:MIME-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=0s9+OhAXw9MjU8sTLz1cC3nsTUfCthVMhvZczN2lYRo=;
	b=NHOMzwYLWIq7dFyR8laTl+oMT0cEZZxRidbq83Ce9UXo3STfoBYxhvDi4uE2GkNMAyUq
	 w3oE+NYcbUEP5/dFF9fGpIuoXP7ous/+qHb+HBBRINXO3QEZwV5eySLbRqKeI9cmfesoh
	 zNZ3WB7Nnd+0RA+WG9v9RKm/ftm4o/iCM4h/l/zY+GElvuRT57lz61MEPIhtpTW3OD8ei
	 X4pGNWCKTYVqk13cM2STDVRSoDSwKpG43W0l0JGS7nfRUrl0YzDEHnc6QHMdYbYlWZiYa
	 oxjUl3lRB0xxr0CQUKeqbv1Dep/ra+YQ5l9+mrrEaHfxpE8/wTz9RT//itZJX8zwkgw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788613326;
	bh=0s9+OhAXw9MjU8sTLz1cC3nsTUfCthVMhvZczN2lYRo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BS0c9VnvH47w2nYcZYSAmmLfnK72u43RKsa+ELBe9kH3h1fXMFov9QbMKNe+hAKvW
	 sexOPPr2MUoz54L9Y3d8wFnvmDTIu/zWWhz5l6QW00ZQAwsbzxrKOgVY4xsTC0Apy8
	 aOBrq2MIylJqNzBBrgC9KUuzXxcvRZDuHkkU/c7OxzWZ/UzLh91Mv67Ks0VTVqOO+p
	 0QR4bTMOszZOJY9Km5iB5qjk7ResRIW657h4/KAPlkZBCgnkDy6HjbuDeEydNzjRoi
	 uDC6BTLUcvTaMOUmKcf4FY9J0BT3vdOO1jAaFPCWaH5+8851gNu9O8RxPMPz99NijB
	 plAPVuNg1aQEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D4325810C8;
	Sat,  5 Sep 2026 13:02:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7C855970
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:14:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 625AB40024
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NURO4RAKv2WA for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 10:14:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 4129540051
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788603278;
 b=hd0tagV9lswkLlKtpbrrdjM4tEZHfKobAe8P5WKYJgphfbxXH2TbH46AYROaCQebPgFK
 ZMW4QBn6BOSQguMfOP0f49bBG5lYHvBi1RA9cNzdpe51xJtclyvsaK7+1+Rz4Ak+SQb3/
 cUJMuU26sb+H6KSc50Fw341YXYWkZNNNHjUjOPkIvr/M1b6cpQsrvvBoPgwttemKY/Diw
 FhXLcrnWXeem8/OEal3TSj1g35QZKmFu+B4X32wUsgZpF48LfBZ6zN+7KAr7uZwZOYku/
 C8ax0UgUNki8DGp0nQ1evJn0Wu6qdRymAUT0EQT5fT5ybZm+FBsZrmGDXji/SEAy6BA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788603278;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:From:
 In-Reply-To:References:MIME-Version:Date:X-Gm-Features:Message-ID:
 Subject:To:Cc:Content-Type;
 bh=0s9+OhAXw9MjU8sTLz1cC3nsTUfCthVMhvZczN2lYRo=;
 b=qdS5HOCORc432oCaQTtjWT3AvdNsuSV+kipY7bzHnBF9To+GYdOSL4AVpNlhv9AzLklU
 sC8QfGPmisPBtJOoF+ApC9cYJCU3/b1b5fk26Km8N3ApWp5quTQV+Vc9JvApxzTJcO0y3
 ZLk5/LNKwvE/W7BsB2gnhqSnUoR3xlBN31n/g1Xazz9pgD+TBDSgfNlqU9xyb2cfNxQh5
 JPLtE4UNdCP43YKkkaTNyK5PVRjoqhSrBF/80JE+oMux9fGEgasjlz2Pkn15rAIcZbQg8
 cvmkjAW2HdCiUENFduQZ7V1qAjaMWrFOBhkqRq1GFdD7p5ySyslhUCNM7H1jstv2SPQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mcVJQMiF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::532"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com;
 envelope-from=joaofl@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=mcVJQMiF
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4129540051
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 10:14:37 +0000 (UTC)
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-cbe827e3cb4so1990252a12.3
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 03:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788603277; cv=none;
 d=google.com; s=arc-20260327;
 b=fPd0fqmvddKglPPPlthWYdOV511xznbzMbWU523zWL0cZilg3xBsTBwfJQ3dSDPzuv
 +HNdnykdVEtT/zz/JCvgU6nxHD5Q4dwNlFGWhVEEhgNBtTD9RBawh81n+i4aqtoRl5qN
 qIxb6orlYQQiCquIt+RsAySxezTPTF5n1svEMtuK76l8ZY76lQbK24MTSvGmXL9bm4tc
 e5zDi3qVRYbei8mJNP9srE7KT2zuAXfD+Tu1gbe/bI3F2ozMfzdxEhH5ENgNeiTXF9hL
 K+uUwKJcM3p6jsoByHYsogv6b9Mkb2zIIbvobkGal9R9GU4qKBFwDZq6nbihssIvyyPw
 5EGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
 :from:dkim-signature;
 bh=0s9+OhAXw9MjU8sTLz1cC3nsTUfCthVMhvZczN2lYRo=;
 fh=1okNdpvSDmZ40nm3aapBsX320K+aNROHLCirbnfD+i0=;
 b=KBOq14o/XkYBpReee364FTVYj9lMxvIeAFOrKbUW+WzSQpPCdRwf8RkoV5gT3b/h7O
 +fLqFZAYqxL0PgMXmLkmYS9iYHK/i11F2wIvV0zOTgpitDD+cWuf8yYYSz98dyFFli4z
 wvJJtqSksp96W1Rcdqg0Zeu2TGH6bqSOrc9Pv5WXWJj4ibSXeD3vqRUNVc6hCuvUbE0+
 KM0ZQPLXntxQCBCDyBWCxkWyhwVEFdVKD4GQlnUCFZSHYyZRJnU5QGjqBR5XmY2JtHpZ
 YP/GJxtIaTLNNtuNovf9D13zGnfpwWfn7VL+fDP9M+fVVjxHVkOWEzYfwc9x5Gm5htvu
 MJVw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788603277; x=1789208077;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=0s9+OhAXw9MjU8sTLz1cC3nsTUfCthVMhvZczN2lYRo=;
 b=mcVJQMiFj3ibCOdpTGpxLyOrMekQxcRJGDlxoK5XbkIzMHL/YnZ2C6xl83LLq29eZl
 X1voTCkAM0nLDpjALYoxWOpPs9hL6Y2oN94RwMoRYG4xWFZFmTJxGyybpeaDiP1z4XVm
 UPDjXXprwganpIL8bCq/u0WcIwk4dIv5Q6PeJamqvhLBMo0thmkDO845sIQvyLTkX02w
 tzGo8+Ob9iwMmBsw8CnvMYpoM3rTuVGs7UwErOsFT+YrYBHnVNTSdsIyglzPQDHOSj/C
 I9d6uKEw8Y4NMd/TqcbL4A6qvFXEdJ4fIcXqU4g3V+EM/6hz9d6eiZcMCcmWK4xIfSfa
 Kk1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788603277; x=1789208077;
 h=content-type:cc:to:subject:message-id:date:mime-version:references
 :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0s9+OhAXw9MjU8sTLz1cC3nsTUfCthVMhvZczN2lYRo=;
 b=G8dBbZvMCZRUXLwtx7MI09kp904eJtu74ObMKi+FNvQLGKCFoISrXM+n5OA4pwTXBH
 Q2TTlwEdK+egMXvMMKKZxwteYSWEF25nnkRh+0xg476+JjsSwJ6sqD3bnmmfZ0ObWvTh
 g3uojP7Ejr3eXc+RIyERaKrKUGCpi0F4xHMEikaYPerZiDAdaCeR8z/84SPma697Ilrq
 Xs2Fs+GM9TTeKVeV+NUZMXvea/j3amYuBUW/aMgJ60Om9/O32xQICzr0HsLky8l8DVtd
 r3zWATv/xAkAW7/rYOv+jwfxqsCUG7dFDiTMVq9GrVvhgyTONuriOb+nmeIlH7NVHMZu
 +iDw==
X-Gm-Message-State: AFuF++mCPQLaFvwq+PNToN2l0ekSv4642mKVSNokKnB3ND0KzLEkjpeH
 qbN4BSxD3ocUwZgC40huUyJXp2pS2cb08DxPyGVIvx2yO5WecYRaI3UjgEmAGohFZw12UU4Xs8c
 f2k5UY/U9OEMkJUIMr2zQasvU+teA4Sjj9w==
X-Gm-Gg: AYBFou0NFB+txZHC73Y9JhFZeT7MaM5kEHV8LOlRAhjV2tCA/EvhasOm+QD+zHlLNrF
 L//NhvTflt1XB6WR6NPlzGgolHCttEXAdbCxTcuXafb49mBuMWw/1Hi1Dxa1A8IQSNEsVtX+9pn
 4OowxqmpNEL/nfm8GptjOagutaDSc+IdNZ1fm4liijpNlheBZWaphzo/R7vMdaZKOZDjYSkbWyn
 1p1AdvCSZL4AQEDUOULn+X+RQlYoVBEnUEKnHZdH4q+cncpK1K/upJRCkH2Uir9xqs7akdXCzCn
 uQZvvxnBiSwLpotMIyhnXwXJaVgjAIxRgrGUk33xtha8iP/5JzCH6ic9VzXoDTSjtV9CiDMv15X
 lGTy+wICAH48KH+/6MFv9uDjX54pUPoilmSkwC55KOaiBUE/ru8RvJsRLRA==
X-Received: by 2002:a05:6a20:729e:b0:3d0:d1f1:6ec5 with SMTP id
 adf61e73a8af0-3da39bb5957mr16284518637.4.1788603276971; Sat, 05 Sep 2026
 03:14:36 -0700 (PDT)
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 5 Sep 2026 03:14:35 -0700
Received: from 101988054943 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 5 Sep 2026 03:14:35 -0700
From: =?UTF-8?Q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>
In-Reply-To: <CAFLszTiPQriMWYNzDtfvPyoctVjQLagXFQVp7kVixrv2_oAPcg@mail.gmail.com>
References: <CAFLszTiPQriMWYNzDtfvPyoctVjQLagXFQVp7kVixrv2_oAPcg@mail.gmail.com>
MIME-Version: 1.0
Date: Sat, 5 Sep 2026 03:14:35 -0700
X-Gm-Features: AcwNN1UANWlipeobIkXGQKQzGM94V6OeZdGLrLNizJGuq7oM5Vhwv1BlW3adYMo
Message-ID: <CAJMWnCgv6PZ0mbAXpRfHu=EmhFAo7ekMZPGQV9OYSkE+2t3yCw@mail.gmail.com>
Subject: Re: Re: [PATCH v4 1/2] spi: Introduce initial EEPROM driver mode
 support
To: sjg@chromium.org
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com
Content-Type: multipart/alternative; boundary="000000000000f7d3a2065ab9a64a"
X-Mailman-Approved-At: Sat, 05 Sep 2026 13:02:04 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

--000000000000f7d3a2065ab9a64a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

Thank you for the detailed review of v4 =E2=80=94 genuinely useful. I'll
address the points in v5. The hard-coded 16-bit address in particular
sent this somewhere better, and chasing your comment on the
non-standard 'size' and 'pagesize' properties turned up the
atmel,at25 binding already in tree, which now drives the whole
geometry.

Thanks,
Jo=C3=A3o

On Mon, Jul 13, 2026 03:04 PM, Simon Glass <sjg@chromium.org> wrote:

> Hi Jo=C3=A3o,
>
> On 2026-06-15T17:51:16, Jo=C3=A3o Loureiro <joaofl@gmail.com> wrote:
> > spi: Introduce initial EEPROM driver mode support
> >
> > This patch introduces the initial SPI EEPROM driver mode support
> > analogous to the I2C EEPROM driver mode support. The SPI EEPROM
> > driver mode support is enabled by default in the sandbox_defconfig.
> >
> > Signed-off-by: Jo=C3=A3o Loureiro <joaofl@gmail.com>
> >
> > MAINTAINERS               |   6 ++
> >  configs/sandbox_defconfig |   1 +
> >  drivers/misc/Kconfig      |   6 ++
> >  drivers/misc/Makefile     |   1 +
> >  drivers/misc/spi_eeprom.c | 185 ++++++++++++++++++++++++++++++
> ++++++++++++++++
> >  include/dm/uclass-id.h    |   1 +
> >  include/spi_eeprom.h      |  91 +++++++++++++++++++++++
> >  7 files changed, 291 insertions(+)
>
> Sorry I didn't notice the earlier versions of this patch, but I do
> have a few comments.
>
> > This patch introduces the initial SPI EEPROM driver mode support
> > analogous to the I2C EEPROM driver mode support. The SPI EEPROM
> > driver mode support is enabled by default in the sandbox_defconfig.
>
> 'driver model', not 'driver mode' - three times. Please also use the
> imperative: 'Introduce initial driver-model support for SPI EEPROMs,
> analogous to ...' matches the subject and U-Boot convention.
>
> Please explain the motivation briefly (why now, what will consume it)
> before your current commit msg.
>
> > diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> > @@ -567,6 +567,12 @@ config I2C_EEPROM
> > +config SPI_EEPROM
> > +     bool "SPI EEPROM support"
> > +     depends on MISC
> > +     help
> > +       Enable support for SPI EEPROM devices.
> > +       Currently with only read access.
>
> Please expand the help text - mention that this provides a uclass with
> a small AT25-style driver, that only 16-bit-addressed parts are
> handled, and that only read is implemented.
>
> Does this really need 'depends on MISC'? The driver does not use the
> misc uclass; it sits on its own UCLASS_SPI_EEPROM. i2c_eeprom does not
> depend on MISC either.
>
> > diff --git a/drivers/misc/spi_eeprom.c b/drivers/misc/spi_eeprom.c
> > @@ -0,0 +1,185 @@
> > +/* 1 command byte followed by a 16-bit address */
> > +#define SPI_EEPROM_CMD_SIZE  3
>
> This lives in the public header and hard-codes a 16-bit address, but
> the uclass is presented as generic. Anything larger than 64 KiB
> (AT25M02, AT25512, most 24-bit-addressed parts) will not work. Please
> either:
>
>   - move SPI_EEPROM_CMD_SIZE into spi_eeprom.c and derive the address
> length from driver-data (an addr_len field), so growing the compatible
> list later does not need an ABI change; or
>   - state explicitly in the commit message and Kconfig help that
> initial support is limited to 16-bit-addressed AT25-style parts.
>
> I'd prefer the first.
>
> > +     if (offset < 0 || size < 0 || offset + size > priv->size) {
> > +             log_err("Read out of bounds (offset %d, size %d, max
> %lu)\n",
> > +                     offset, size, priv->size);
> > +             return -EINVAL;
> > +     }
>
> offset + size is an int and can overflow before the comparison against
> the unsigned long priv->size. Please check the two ranges
> independently:
>
>     if (offset < 0 || size < 0 || offset >=3D priv->size ||
>         size > priv->size - offset)
>
> > +     cmd[0] =3D data->cmd_read_data;
> > +     cmd[1] =3D (offset >> 8) & 0xff;
> > +     cmd[2] =3D offset & 0xff;
>
> If you keep the 16-bit assumption, please reject offsets that don't
> fit in 16 bits rather than silently truncating. priv->size can be
> overridden from DT via the 'size' property with any value.
>
> > +static int spi_eeprom_std_of_to_plat(struct udevice *dev)
> > +{
> > +     const struct spi_eeprom_drv_data *data =3D
> > +             (const struct spi_eeprom_drv_data
> *)dev_get_driver_data(dev);
> > +     struct spi_eeprom *priv =3D dev_get_priv(dev);
> > +
> > +     priv->size =3D dev_read_u32_default(dev, 'size', data->size);
> > +     priv->pagesize =3D dev_read_u32_default(dev, 'pagesize',
> data->pagesize);
>
> Two things:
>
> 'size' and 'pagesize' don't seem to be standard bindings for SPI
> EEPROM nodes - the size is normally determined by the compatible.
> Please either drop these overrides or point at a binding that
> documents them.
>
> Also, this writes into priv from of_to_plat(). Per driver-model
> convention, of_to_plat() should populate plat data (auto_plat) and
> probe() should use plat or can put a few things in priv if it likes.
> Since there is no write path using pagesize yet, the simpler fix is to
> move this into spi_eeprom_std_probe()
>
> > +static const struct udevice_id spi_eeprom_std_ids[] =3D {
> > +     { .compatible =3D 'microchip,at25160bn', .data =3D
> (ulong)&atmel25_data },
> > +     { }
> > +};
>
> Only one compatible for a generic driver feels thin - any reason not
> to add the rest of the AT25 family that shares this command set
> (at25010b, at25020b, at25040b, at25080b, at2532b, at25640b etc)? Each
> just needs a drv_data entry.
>
> > diff --git a/include/spi_eeprom.h b/include/spi_eeprom.h
> > @@ -0,0 +1,91 @@
> > +/* AT25-style command set */
> > +#define AT25_CMD_READ_DATA   0x03    /* Read data from memory array */
> > +#define AT25_CMD_READ_STATUS 0x05    /* Read status register */
> > +
> > +/* 1 command byte followed by a 16-bit address */
> > +#define SPI_EEPROM_CMD_SIZE  3
>
> These are only used by drivers/misc/spi_eeprom.c and
> drivers/misc/spi_eeprom_emul.c - implementation details rather than
> uclass API. Please move them into a private header shared by the
> driver and emulator, or duplicate the two opcodes locally.
>
> > +#if CONFIG_IS_ENABLED(SPI_EEPROM)
> > +/*
> > + * spi_eeprom_read() - read bytes from an SPI EEPROM chip
>
> Please switch to kerneldoc (/** rather than /*) - new code should
> carry proper kerneldoc even where i2c_eeprom.h has not been updated.
>
> > +#endif /* SPI_EEPROM */
> > +
> > +#endif
>
> Please add /* __SPI_EEPROM */ after the outer #endif to match the inner
> one.
>
> Regards,
> Simon
>

--000000000000f7d3a2065ab9a64a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<html><body><div dir=3D"auto">Hi Simon,<br><br>Thank you for the detailed r=
eview of v4 =E2=80=94 genuinely useful. I&#39;ll<br>address the points in v=
5. The hard-coded 16-bit address in particular<br>sent this somewhere bette=
r, and chasing your comment on the<br>non-standard &#39;size&#39; and &#39;=
pagesize&#39; properties turned up the<br>atmel,at25 binding already in tre=
e, which now drives the whole<br>geometry.<br><br>Thanks,<br>Jo=C3=A3o<br><=
/div></body></html><br><div class=3D"gmail_extra"><div>On Mon, Jul 13, 2026=
 03:04 PM, Simon Glass &lt;<a href=3D"mailto:sjg@chromium.org">sjg@chromium=
.org</a>&gt; wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi Jo=C3=A3o,<br>
<br>
On 2026-06-15T17:51:16, Jo=C3=A3o Loureiro &lt;<a href=3D"mailto:joaofl@gma=
il.com" target=3D"_blank">joaofl@gmail.com</a>&gt; wrote:<br>
&gt; spi: Introduce initial EEPROM driver mode support<br>
&gt;<br>
&gt; This patch introduces the initial SPI EEPROM driver mode support<br>
&gt; analogous to the I2C EEPROM driver mode support. The SPI EEPROM<br>
&gt; driver mode support is enabled by default in the sandbox_defconfig.<br=
>
&gt;<br>
&gt; Signed-off-by: Jo=C3=A3o Loureiro &lt;<a href=3D"mailto:joaofl@gmail.c=
om" target=3D"_blank">joaofl@gmail.com</a>&gt;<br>
&gt;<br>
&gt; MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A06 ++<br>
&gt;=C2=A0 configs/sandbox_defconfig |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 ++<br>
&gt;=C2=A0 drivers/misc/Makefile=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 drivers/misc/spi_eeprom.c | 185 ++++++++++++++++++++++++++++++<w=
br>++++++++++++++++<br>
&gt;=C2=A0 include/dm/uclass-id.h=C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<br>
&gt;=C2=A0 include/spi_eeprom.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 91 ++++++++++++=
+++++++++++<br>
&gt;=C2=A0 7 files changed, 291 insertions(+)<br>
<br>
Sorry I didn&#39;t notice the earlier versions of this patch, but I do<br>
have a few comments.<br>
<br>
&gt; This patch introduces the initial SPI EEPROM driver mode support<br>
&gt; analogous to the I2C EEPROM driver mode support. The SPI EEPROM<br>
&gt; driver mode support is enabled by default in the sandbox_defconfig.<br=
>
<br>
&#39;driver model&#39;, not &#39;driver mode&#39; - three times. Please als=
o use the<br>
imperative: &#39;Introduce initial driver-model support for SPI EEPROMs,<br=
>
analogous to ...&#39; matches the subject and U-Boot convention.<br>
<br>
Please explain the motivation briefly (why now, what will consume it)<br>
before your current commit msg.<br>
<br>
&gt; diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig<br>
&gt; @@ -567,6 +567,12 @@ config I2C_EEPROM<br>
&gt; +config SPI_EEPROM<br>
&gt; +=C2=A0 =C2=A0 =C2=A0bool &quot;SPI EEPROM support&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0depends on MISC<br>
&gt; +=C2=A0 =C2=A0 =C2=A0help<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Enable support for SPI EEPROM devices.<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0Currently with only read access.<br>
<br>
Please expand the help text - mention that this provides a uclass with<br>
a small AT25-style driver, that only 16-bit-addressed parts are<br>
handled, and that only read is implemented.<br>
<br>
Does this really need &#39;depends on MISC&#39;? The driver does not use th=
e<br>
misc uclass; it sits on its own UCLASS_SPI_EEPROM. i2c_eeprom does not<br>
depend on MISC either.<br>
<br>
&gt; diff --git a/drivers/misc/spi_eeprom.c b/drivers/misc/spi_eeprom.c<br>
&gt; @@ -0,0 +1,185 @@<br>
&gt; +/* 1 command byte followed by a 16-bit address */<br>
&gt; +#define SPI_EEPROM_CMD_SIZE=C2=A0 3<br>
<br>
This lives in the public header and hard-codes a 16-bit address, but<br>
the uclass is presented as generic. Anything larger than 64 KiB<br>
(AT25M02, AT25512, most 24-bit-addressed parts) will not work. Please<br>
either:<br>
<br>
=C2=A0 - move SPI_EEPROM_CMD_SIZE into spi_eeprom.c and derive the address<=
br>
length from driver-data (an addr_len field), so growing the compatible<br>
list later does not need an ABI change; or<br>
=C2=A0 - state explicitly in the commit message and Kconfig help that<br>
initial support is limited to 16-bit-addressed AT25-style parts.<br>
<br>
I&#39;d prefer the first.<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (offset &lt; 0 || size &lt; 0 || offset + size=
 &gt; priv-&gt;size) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0log_err(&quot;Read ou=
t of bounds (offset %d, size %d, max %lu)\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0offset, size, priv-&gt;size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
offset + size is an int and can overflow before the comparison against<br>
the unsigned long priv-&gt;size. Please check the two ranges<br>
independently:<br>
<br>
=C2=A0 =C2=A0 if (offset &lt; 0 || size &lt; 0 || offset &gt;=3D priv-&gt;s=
ize ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 size &gt; priv-&gt;size - offset)<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[0] =3D data-&gt;cmd_read_data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[1] =3D (offset &gt;&gt; 8) &amp; 0xff;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0cmd[2] =3D offset &amp; 0xff;<br>
<br>
If you keep the 16-bit assumption, please reject offsets that don&#39;t<br>
fit in 16 bits rather than silently truncating. priv-&gt;size can be<br>
overridden from DT via the &#39;size&#39; property with any value.<br>
<br>
&gt; +static int spi_eeprom_std_of_to_plat(stru<wbr>ct udevice *dev)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0const struct spi_eeprom_drv_data *data =3D<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(const struct spi_eep=
rom_drv_data *)dev_get_driver_data(dev);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct spi_eeprom *priv =3D dev_get_priv(dev);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;size =3D dev_read_u32_default(dev, &#39;=
size&#39;, data-&gt;size);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0priv-&gt;pagesize =3D dev_read_u32_default(dev, &=
#39;pagesize&#39;, data-&gt;pagesize);<br>
<br>
Two things:<br>
<br>
&#39;size&#39; and &#39;pagesize&#39; don&#39;t seem to be standard binding=
s for SPI<br>
EEPROM nodes - the size is normally determined by the compatible.<br>
Please either drop these overrides or point at a binding that<br>
documents them.<br>
<br>
Also, this writes into priv from of_to_plat(). Per driver-model<br>
convention, of_to_plat() should populate plat data (auto_plat) and<br>
probe() should use plat or can put a few things in priv if it likes.<br>
Since there is no write path using pagesize yet, the simpler fix is to<br>
move this into spi_eeprom_std_probe()<br>
<br>
&gt; +static const struct udevice_id spi_eeprom_std_ids[] =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ .compatible =3D &#39;microchip,at25160bn&#39;, =
.data =3D (ulong)&amp;atmel25_data },<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{ }<br>
&gt; +};<br>
<br>
Only one compatible for a generic driver feels thin - any reason not<br>
to add the rest of the AT25 family that shares this command set<br>
(at25010b, at25020b, at25040b, at25080b, at2532b, at25640b etc)? Each<br>
just needs a drv_data entry.<br>
<br>
&gt; diff --git a/include/spi_eeprom.h b/include/spi_eeprom.h<br>
&gt; @@ -0,0 +1,91 @@<br>
&gt; +/* AT25-style command set */<br>
&gt; +#define AT25_CMD_READ_DATA=C2=A0 =C2=A00x03=C2=A0 =C2=A0 /* Read data=
 from memory array */<br>
&gt; +#define AT25_CMD_READ_STATUS 0x05=C2=A0 =C2=A0 /* Read status registe=
r */<br>
&gt; +<br>
&gt; +/* 1 command byte followed by a 16-bit address */<br>
&gt; +#define SPI_EEPROM_CMD_SIZE=C2=A0 3<br>
<br>
These are only used by drivers/misc/spi_eeprom.c and<br>
drivers/misc/spi_eeprom_emul.c - implementation details rather than<br>
uclass API. Please move them into a private header shared by the<br>
driver and emulator, or duplicate the two opcodes locally.<br>
<br>
&gt; +#if CONFIG_IS_ENABLED(SPI_EEPROM)<br>
&gt; +/*<br>
&gt; + * spi_eeprom_read() - read bytes from an SPI EEPROM chip<br>
<br>
Please switch to kerneldoc (/** rather than /*) - new code should<br>
carry proper kerneldoc even where i2c_eeprom.h has not been updated.<br>
<br>
&gt; +#endif /* SPI_EEPROM */<br>
&gt; +<br>
&gt; +#endif<br>
<br>
Please add /* __SPI_EEPROM */ after the outer #endif to match the inner one=
.<br>
<br>
Regards,<br>
Simon<br>
</blockquote></div></div>

--000000000000f7d3a2065ab9a64a--

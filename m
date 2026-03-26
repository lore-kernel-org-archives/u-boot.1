Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13190109E557
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 05:57:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D73981E18;
	Thu, 26 Mar 2026 06:57:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="nibJKHOu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1DEB83EAC; Thu, 26 Mar 2026 06:57:31 +0100 (CET)
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com
 [IPv6:2607:f8b0:4864:20::1329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B83480517
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 06:57:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-dy1-x1329.google.com with SMTP id
 5a478bee46e88-2c156c4a9efso676333eec.1
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 22:57:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774504647; cv=none;
 d=google.com; s=arc-20240605;
 b=QVRT2wjqP0cUmOOEw3L3T+NFAQPdFA0ygNnJe1YCPjU/0VjK5ZW3BFQuddTJ+pBn/t
 Eu6h0S4MvALKClSxq+tqRCezinqhLAQ0GgQhOpk6yx6U4exHf0QIp8NztjQBbCNcEwPo
 UF0NscoBz0Lu6CL1cunQwfcFCoES3wfDhc3ga1Phfwi3r0j2p2MvygFyyidyF4Plx6iR
 P0eMEsr9iJbYRhClkkK8Vc0qFRBqxv17AzV03GJsVFawYbvMj7QFIDsAJpTfZzHkyxjh
 B5q7h0QiR6+SlpTi1FRnQgpn1qhft7uuaHp7xQWELMjohkuvL5g+0jrpo70suQAjElmV
 ouAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0qMK1M1A4mwu2orA3unzwn4M6mG8Wyacu+ZnjL0L9DE=;
 fh=Bn44J1ZqmFY+A0JGrTgC/zOFUeblENCZ648oE/lWAM8=;
 b=Nb7ykU7aRuyk4O2dZHDCmicc1lFepcuDdjdRt4Vs13rClzWhQIOAfe1CrRpOcW2FMU
 4XU1LYCJbM1md85t7SRZKi1cJvi3VQd1qsUjBto2i3NvKcnYZ9/gg/AyGrV+srtQI5nx
 aWaTggxzCo7AIE2MtgcWmthF84UPwa3LGCNcNFv5CtYvScdmqEBofxz9qH+CERQRIQ+W
 Tt1qUKW6lLSBcEyFx3RrWe7IOPk8rgTAtPYwyHEDsqnjDSPhNH4PL3FHTorxBc/Tela9
 PK3MLwBuRNHqWnWjbuwXOq7Ao6qEEcet/dFp4sTqsdkzjFPtC7RxkYkGuGkevIvpY5aW
 zHnQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1774504647; x=1775109447;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0qMK1M1A4mwu2orA3unzwn4M6mG8Wyacu+ZnjL0L9DE=;
 b=nibJKHOur+RQNfgsQRddkB7JVZS8n4gNcP38mpnaCzIYC4BFKzkdy0h85lx1gwDOT7
 HdrO1qFHzuZl073tWGePVbolVdON1G50XKv0OpIQmTqJvaFd+UBj4Q4sky1XPq59zrVc
 qNDgPiF3KMj+/lbS6n0S6iyiU/w7fC7UCuHCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774504647; x=1775109447;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0qMK1M1A4mwu2orA3unzwn4M6mG8Wyacu+ZnjL0L9DE=;
 b=TjkB6iL2GySTYayypLJF0Z8V5uEpqLLDyAy+xJSqozoRUOhefJY5jQh88mRz7EiIkm
 BKjyGDWupMiUCoWrH0IwhgIizpOxHxLGc0sbW0WT0adN6Kkjcho+o+2j0E70a2N9N7WE
 PROmQoMyZsSQ0iCw61dp0HQyDfvHex4+CNtU+ObEmh3SR95/rAc4VxbzStV8Df+NUKzG
 tRjza4kSOn9npHnXN/MEpfMicvMTN2dJ61hyyUS+p/2X0BqbPea6OEZ+G8QjiFcOTf1h
 JZeeICDEQQH9W+dX4XPFJHeBYplC54ZscXtyr/i+uXSMzrNL7EcOoBBykKJIues2Wwhc
 lP1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXioD3CyOlfBlXS+VY1Jd/ZExwieRfuCrpdv58gS3M8wD2qOYWqVYqFbf8t7lXRm/y9Qury0+M=@lists.denx.de
X-Gm-Message-State: AOJu0YwxCWQXqXk6B+7g/J9HL1G9hqY1Id1EdvX66X+RsgAnMHoQkJLO
 bpAJCLXfq3A6/aFE3YB20BgR02bjDaIxGzEHKkQXWtOl8Kt+Z8ZYdjW4OEg7E+0XODXEDtOypuC
 Ltw6xIvKUALAo8aEHQSb4f05zTQRf3gwgaKJuB56c6A==
X-Gm-Gg: ATEYQzzIbQ9C0GC5Hc/pcgfz+mZFE7Xs0ehcpwjw7NfHiJwvDzKW3BCW8e51IlzpITz
 FSdzAQ9M/0VLAXZO8PZ/mntTHJRFErU416x83MKLrxcOYAz0mMjxVJYFrWq8IA+zpujeZ5n84Jv
 ZUkWAKB30ozIzoak/02HMs6hnNDvclRgfRh/wMjAD2AESDfsBXTL9d8beCZYzrfI+VP1PHXeq59
 vWH03SQ/S+piaaggipVqc60nMMtO9ti8PKKgl0MgOfOPcH9mSMeWKbg30AfbWGS2NomFSfsuhlE
 0HtG3DW68qd/ej+mjbF/kzVzJxyJ46DutuIx
X-Received: by 2002:a05:693c:4098:b0:2c1:71a8:3839 with SMTP id
 5a478bee46e88-2c171a897a6mr825679eec.9.1774504647520; Wed, 25 Mar 2026
 22:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260304032441.31558-1-dinesh.maniyam@altera.com>
 <20260304032441.31558-2-dinesh.maniyam@altera.com>
 <20260304143920.GT1388590@bill-the-cat>
 <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
In-Reply-To: <PH7PR03MB6942D3E727EC89DE074BC0EFF756A@PH7PR03MB6942.namprd03.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 26 Mar 2026 06:57:14 +0100
X-Gm-Features: AQROBzCXOkxQqzKUeE16NL7Ln0WemWxLowt2NhP5L5cqyiL7Jbv6OYUhA0ELscY
Message-ID: <CAOf5uwm9eEMKe=CVGbZavGgmv3SArnnLZNcJs1RZJW7H6vgw_Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence NAND
 dependencies
To: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, "Chee,
 Tien Fong" <tien.fong.chee@altera.com>, 
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "NG,
 BOON KHAI" <boon.khai.ng@altera.com>, 
 "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi

Yes I have two series on my queue, I I will work on them this week.

Michael

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

Il gio 26 mar 2026, 03:57 MANIYAM, DINESH <dinesh.maniyam@altera.com> ha
scritto:

> Hi Michael,
>
>
> ------------------------------
> *From:* Tom Rini
> *Sent:* Wednesday, March 4, 2026 10:39 PM
> *To:* MANIYAM, DINESH
> *Cc:* u-boot@lists.denx.de; Marek Vasut; Simon Goldschmidt; Dario
> Binacchi; Michael Trimarchi; Richard Genoud; James Hilliard; Miquel Rayna=
l;
> Chee, Tien Fong; Hea, Kok Kiang; NG, BOON KHAI; YUSLAIMI, ALIF ZAKUAN
> *Subject:* Re: [PATCH 1/2] mtd: nand: raw: Kconfig: clean up SPL Cadence
> NAND dependencies
>
> On Wed, Mar 04, 2026 at 11:24:40AM +0800, dinesh.maniyam@altera.com wrote=
:
>
> > From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> >
> > Fix and align Kconfig dependencies for Cadence NAND in SPL.
> > Move SPL-specific selects to SPL_NAND_CADENCE and remove them from the
> > non-SPL NAND_CADENCE option. This avoids incorrect symbol selection and
> > keeps SPL Cadence NAND support self-contained.
> >
> > Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> --
> Tom
>
> This patch has been reviewed by Tom Rini.
> When you have a chance, could you please take a look?
> If there are no further concerns, I=E2=80=99d appreciate your considerati=
on for
> merging.
> Thanks for your time.
>
>

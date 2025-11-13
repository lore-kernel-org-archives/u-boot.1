Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE6DCD6E71
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 14:36:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36B5583E86;
	Thu, 13 Nov 2025 15:36:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HSsTDph0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13B8683E86; Thu, 13 Nov 2025 15:36:17 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 641D68394E
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 15:36:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b98983bae8eso499651a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 06:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1763044573; x=1763649373;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lRkiR1VGtb+CJQ7EwAwY1IeFpfYP5dyzVZPfqTK2fIo=;
 b=HSsTDph0TONep+sUBBABxfCuMH9LeiRGkP88WfwQxFyEM9l823y8TE+/rBX9VhBGSq
 zOnZmFK1p/0Uv+AWlIjXAISX8EJKChDqHsYdqQqMickzsDtfFpT+BJM2JyuVQqPBlh3T
 P+TzDoSO/iYwVidA78WQl3NCUH4HArDHJwa4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763044573; x=1763649373;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRkiR1VGtb+CJQ7EwAwY1IeFpfYP5dyzVZPfqTK2fIo=;
 b=w/PbDoEFR5QI17WoL/jQrVrjo5J3NJZrJ1szSEYuHIXkG4gTzyxUZdQuzh9tCYENVe
 KGSEkhJvPDN43KipNZqAeri718sKtSOvzUCNgCRT3xsIZp26jwxuCkN9JuCMLupwClOG
 d7R9dEuNOmpCSjOditbVt66WOh+Gpjvn+JDxPVYL0H6MGJ0t+R/VWZ++J27ms/Kw9YJD
 p9KxnDrqEKVYrAfXia6mmG2ZAs7gxR4NAH/ExlMVBZCLkY5eFKjw6P/6xhCWD+GdZYcW
 QsWItebOCCbdAGkrdI8g6g5WV8MhdoETCZwfv6SG27hXofZGL5nbSf7jEuNJ4qRHnsJF
 a2Ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzfUwthw1aWNu1ua1jkEClThC3qngLZLyCrcQiPU8pXXQKqkcnGKImWux15xM2/SXeCRiovWA=@lists.denx.de
X-Gm-Message-State: AOJu0YzsqLSB009yi26G/RuR10VIf5za4FrkkjDKSdypr9+vEAC0BV4Z
 nBdPAaJ84jK+hgNGLEQGNiWAyfhzrrI0DJFIomBYj9qZlFJL8Tfayu3JbN+nlTXjyffbFr4kHfW
 CmNCy0KLyYYeBFd/sk9Vfg4EDX7W1pT8zFD9qev6W8Q==
X-Gm-Gg: ASbGncs/UeiS8iZo8S7NAjJf2d+vnnj7xpx8x0w/0VnpbDYrBU/uJHpPsNV3qUSV/OD
 MXqRbr0/GE45NQb111N4zWdxe7S8CbbdhcA83/O6E9p+1jcX1wmjBq9nJg1tUHry0NGy2VgleLB
 Id5rlYB7Hy+b7OdpguqC84TlyCfEI1YG4c8Sr9B9jtJ33xm2Iko0gEO9QizM9x7gU0W1VJbr1k+
 OewGJNsaAAUk4YjPHDgW6PgZ1Lw8AP2U47Jnsl6lsIw0XuiNGT0JW6HxU+i2ZTdpwa4VrzAOfsm
 cueerfekKfujMA==
X-Google-Smtp-Source: AGHT+IHt/cvO6YmIeQyHLAKTecKG74H0Elk5xO5qerZ1l2tDTkOaq58T3UyK6pNZ1nEJJllfEcyy5voB4U7cYH98wPY=
X-Received: by 2002:a05:693c:40d5:b0:2a4:3592:cf6e with SMTP id
 5a478bee46e88-2a48b5246f3mr1791eec.18.1763044572633; Thu, 13 Nov 2025
 06:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
 <20251113142745.GI6688@bill-the-cat>
In-Reply-To: <20251113142745.GI6688@bill-the-cat>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 13 Nov 2025 15:36:00 +0100
X-Gm-Features: AWmQ_bmc54yWh5FMC_CJ5JN6T0mhqj3UE_bMA-lxmuD4eRrLftb9SzVlBaEnN70
Message-ID: <CAOf5uwn_ggFp-KW6qDcKYn1kKA6+FabyQLCT1ecVoBdv9s3UqQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
To: Tom Rini <trini@konsulko.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh R <vigneshr@ti.com>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, U-Boot-Denx <u-boot@lists.denx.de>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Steam Lin <stlin2@winbond.com>
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

Hi

Conference. I will pick him up this weekend together with others. Sorry for
it

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

Il gio 13 nov 2025, 15:27 Tom Rini <trini@konsulko.com> ha scritto:

> On Thu, Nov 13, 2025 at 10:50:34AM +0100, Miquel Raynal wrote:
> > Hi,
> >
> > I am manually adding Michael, as apparently he was not listed
> > automatically.
> >
> > On 09/09/2025 at 12:12:26 +02, Miquel Raynal <miquel.raynal@bootlin.com>
> wrote:
> >
> > > Hello,
> > >
> > > On 03/07/2025 at 19:02:53 +02, Miquel Raynal <
> miquel.raynal@bootlin.com> wrote:
> > >
> > >> All these chips are dual and quad capable. They are also DTR capable,
> > >> but the core is not yet ready for that.
> > >>
> > >> Performances of all chips are comparable at 30MHz and are as follow:
> > >> Eraseblock single read speed: 938kiB/s
> > >> Eraseblock dual read speed:  1068kiB/s
> > >> Eraseblock quad read speed:  3751kiB/s
> > >>
> > >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > >
> > > I believe this patch has been out for more than 2 months and is simple
> > > enough, any plans for taking it soon?
> >
> > It's now been few more months and I haven't been notified this patch got
> > merged. It is also not visible in upstream U-Boot. Could we please speed
> > up the merging process, especially for such simple change?
>
> Jagan, Michael, Dario, do you need some help with the mtd/spi related
> patches? This hass been going on for some time. Thanks!
>
> --
> Tom
>

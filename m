Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60818D3B7DD
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 09:13:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8394183B0B;
	Mon,  8 Dec 2025 10:13:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QBVexTYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FA66838CE; Mon,  8 Dec 2025 10:08:02 +0100 (CET)
Received: from mail-yx1-xb12a.google.com (mail-yx1-xb12a.google.com
 [IPv6:2607:f8b0:4864:20::b12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E07D83B1E
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 10:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-640d4f2f13dso4102701d50.1
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 01:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765184879; x=1765789679; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j5S2W6wCJ17u07GVG2RlUJXk+B4kmwYuRXcHO9qMSlE=;
 b=QBVexTYa1Qaky4CdeWBzSdzu3Ia4DuomkIfxQdyCO5K9gExVJpHletcXFLJ4Evbtgm
 4L6uxkpicpJ3CKif47M1PxbxKfQQn4OBtJFHwE8wFEs+QoKx0YMLP1AiSC8R6TRyrGwL
 56IHVMuhuEe8bwgEYBTBC1bX3eNegOFzdwjeoz5xKzAVyj0LRfIvhEfdQva+igCSDlPX
 x3mmoAzAFP0V647gDLMxBjguQpEW6n9b2f8XEmLQJmbCtUqxK+kB9vJ6PHQFt/f6xFzS
 8LOa5981nqLAn/lTiBm+OeGADEMNCVXPWjqUYOxTEN9uFN/+zn3vRU5na4Q9Kq47A3JO
 /y4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765184879; x=1765789679;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5S2W6wCJ17u07GVG2RlUJXk+B4kmwYuRXcHO9qMSlE=;
 b=pkZPl9UbH3iXWdLzFny1kANKCDYvS8AyxnkcTX5xaf17NwzrCBzMctkPUlevyHSt6a
 rfcwjvdavklTT3pyOJ1Aonkn52KI60RkV9WDfqKwc1CsJ218VwVhfqgRXxld+Rqlz5EB
 E3RoAKxY8zYLmF7sL9Veal52wSxvB4ik/a7buQ9lo1HPgU89K7Wx32YSi8g/BOaAg+MD
 ZrXywYsYf9/hSnEYGX4bB5NiaGBq29hsWMbM3OKfrNgD7pf0eUnpMp/0O+naya0rESeA
 i3bW1nCAvVIGVsx1u6vpG2AlkVaQXVT8Rwk2yEi8P25WRS8rIh/97i+W6eZ3B0YrB02A
 Y/uQ==
X-Gm-Message-State: AOJu0Yxnbdyx0OJb58LCpymtfZVf+JBmtGthQQWFbhqIg8K3RGbxXGMf
 Pqw8Sb/rkhJdxY9y0hNScyBg0ESwENXr4/5yXFpLZtHh3j2utDy8YCV+rvlKjMjjKy2YmKFB5Xw
 1O/QTiyGG/dAIR+apFpHXE/YzR5z2nCW6u/UYBo+IgQ==
X-Gm-Gg: ASbGncu4BUqkUpz5EtE05yrmvi5JYVsb9y2HFBj4eOb363bqsVgDqnPm0qjtNZeHZuO
 lr8jljVZ2r3eLbkWMBRzxYaaCCvMWwIpSQXeqrDcSB5QJLch38oqImkiEq1pG2vhzVYnSH6Woe0
 ZXt1r2iRt/dIwtJHyPC+NmQOuDefGlS0sTQA8e0+79q8Ls/3dnMHOHC5lV8tOGFVwNKxzqMxlyU
 t0QxAFyJ/rGMZiHK3A+rGtyebCiLDI/tug6JDJnGovNOKrHmzEls+LX9EXzKJW4/mXb12z5EWq2
 KY7sH6h6ipIRaT5HOZ2R7BYg2QRGMX3u7oou/LfXsHwCpdr51Gfrrvg8vvX8vXYLi6SzhfXBPiC
 ne9X3VmQ=
X-Google-Smtp-Source: AGHT+IEiEzG1FwC+CA1JWfQOG2VgDKFNmvVft2cCLK1sEAinNSS0no0AAORdCP7qb+CM/BUGyZXKPYzdKkabw34h0hA=
X-Received: by 2002:a05:690e:4298:10b0:63f:b6a4:bd24 with SMTP id
 956f58d0204a3-6444e7b9987mr4674115d50.48.1765184879232; Mon, 08 Dec 2025
 01:07:59 -0800 (PST)
MIME-Version: 1.0
References: <20251118043042.27726-1-hs@nabladev.com>
 <176487670995.2050783.17410258029578449020.b4-ty@konsulko.com>
 <e2b4a1f7-d915-8e83-2f9b-7f48a56d8e2e@nabladev.com>
 <CAC_iWjJJEG2aUKhNLLY9KgqnROtTbCKd9Ex3-mhviado=r++Cg@mail.gmail.com>
 <6d29ed19-4fd5-afc9-56e2-f4c9df34ff70@nabladev.com>
 <20251205141116.GH303283@bill-the-cat>
In-Reply-To: <20251205141116.GH303283@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Dec 2025 11:07:23 +0200
X-Gm-Features: AQt7F2q7xwnayxOaRQwrO-zFTx4fAceHANrkLyuIpoj7SE3tF_UeAQxU9sIZtn0
Message-ID: <CAC_iWjK9zG3=x4n6n_kqJvp-SFKYqO6sFE-LcajC+h+0+Y-gNw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymondmaoca@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 08 Dec 2025 10:13:49 +0100
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

Heiko,

I had another look. Oberall the changes seem fine and I don't mind keeping them.
Any chance you tested this on actual hardware?

Cheers
/Ilias

On Fri, 5 Dec 2025 at 16:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Dec 05, 2025 at 09:02:28AM +0100, Heiko Schocher wrote:
> > Hello Ilias,
> >
> > On 05.12.25 08:24, Ilias Apalodimas wrote:
> > > On Fri, 5 Dec 2025 at 07:03, Heiko Schocher <hs@nabladev.com> wrote:
> > > >
> > > > Hello Tom,
> > > >
> > > > On 04.12.25 20:31, Tom Rini wrote:
> > > > > On Tue, 18 Nov 2025 05:30:36 +0100, Heiko Schocher wrote:
> > > > >
> > > > > > Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and described
> > > > > > at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> > > > > >
> > > > > > TPMv2 defines hash algo sm3_256, which is currently
> > > > > > not supported and prevented TPMv2 chip with newer
> > > > > > firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
> > > > > >
> > > > > > [...]
> > > > >
> > > > > Applied to u-boot/next, thanks!
> > > > >
> > > > > [1/6] lib: Import rol32 function from Linux
> > > > >         commit: 6a0c939b88fd42c6b0a374f7c87317f292df46a1
> > > > > [2/6] lib: import sm3 256 hash parts from linux
> > > > >         commit: 41c0131b950a16747929ab310588cf5db8e38123
> > > > > [3/6] lib: sm3: implement U-Boot parts
> > > > >         commit: c4ab316269debc321907acc4f8f02dfe5653aeaf
> > > > > [4/6] test: cmd: hash: add unit test for sm3_256
> > > > >         commit: 213601a600f1e8894cea76b0bfc131f038882407
> > > > > [5/6] tpm2: add sm3 256 hash support
> > > > >         commit: 7c3f05ad51e4bc23dd4f411f28968f1d8f43099c
> > > > > [6/6] test: cmd: fix a typo in md5 test
> > > > >         commit: b30557b3b46c5162cb88a57907c517ed95557239
> > > >
> > > > Oh, may a little to fast, as Ilias and Quentin had some comments
> > > > about tpm2 implementation/test (tpm2: add sm3 256 hash support
> > > > patch). But I can send changes on top of that patches (but
> > > > give me some time for it... end of year rally has started...)
> > > >
> > >
> > > Yea I pinged Tom yesterday.
> > > tbh, my main concern was testing the changes. I dont mind if we revert
> > > and reapply or send the changes on top.
> >
> > I am fine with sending updates on top.
>
> Sorry for getting ahead of everyone else here, since it sounds like
> everyone is OK with updates on top, we can move forward. Thanks!
>
> --
> Tom

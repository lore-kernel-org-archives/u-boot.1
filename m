Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454B5D2F7D1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 10:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89234841D2;
	Fri,  5 Dec 2025 11:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bHSAe78B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9381B84181; Fri,  5 Dec 2025 08:25:23 +0100 (CET)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F53983AC6
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 08:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-64107188baeso1587281d50.3
 for <u-boot@lists.denx.de>; Thu, 04 Dec 2025 23:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764919520; x=1765524320; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mf0r7UswpoFh8kJXcjkWqRTWg4RPfifnIh4+AmxYn90=;
 b=bHSAe78BNdNibDWFwbd862TqgD8a6l8MUWDDQPdhunXlJgv0X2rHE5l3w8wzykiWST
 KctBzhgRR1qHHxcjd99xBCkKmkWf+ZI5NnLgFOifYCUJiObqpYsIM4ZrTYvh5NeNb7/F
 51siQ4x5G8OL1lWa6K27YkPmwxUosVZgwYrlogJ9ygbcWh89KXqXIiXI7qJwjiriSG4u
 8fn7HF0T7Mtg1aDgvdwsc6k/pJfGph4e1oH+HvUBUHp3pnPYcB9iWPs4fkoMfZiibOX6
 gM/G35vOLuUOu/HjJOHsKwN/9RAyPzRc1NqMg6envcVkopGH8I1bN4Bd1DJy0UjdHGZQ
 TGQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764919520; x=1765524320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mf0r7UswpoFh8kJXcjkWqRTWg4RPfifnIh4+AmxYn90=;
 b=Nq6vhhimqf0YPrdVZtN44WQTzaEQhSCa4X+8QVVo8W53p1Cyh0ZtXDfPOLohowod0x
 4y6lcVLjfVYId/X1jM47xs7NUNRdI6KOGR7/zAta3D/Da4zLpZ1CDNVKlsktUBVgEJTd
 lleBsvZF+TzOQlu/thL0eRDgZ9ofq8rZxCl01ZF3egI462DAkiIcLaEUJDhuAwfmVLQ7
 SrGFgFIAVnYf/AqsLvDua3CPyPGok/EmMMw6bmr5yXYATOpKvdpuCzX2rZWKH4yASw+1
 KgV1NL+VqHxidikUEXMkEJvVEzlCrdIGslO6dTh4e01IH2BW4CKUoS2aDPWjaTUdn9aV
 kXHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUizJazAWEYI1RMMP6WxMNBGXE6EGkeJSHM6KnszkiUqRac0TZRfR0DiPm6Ii+6Xddb7mQ3vAw=@lists.denx.de
X-Gm-Message-State: AOJu0YyyNoF0HPuIImaKVNCru/ZO4vYxmVRxamKmB15oUC1xMCseoirW
 7nPoskgterN5CQIaNGC0p4kHHzCJGZNGbznGWvFsHRwI92OmoWBCtX8ZJ1Okl9/FjbCeXOploRF
 7DS1J4yO8mGlSFa9czAt0NjutlwIhos7cCFgdvLalGQ==
X-Gm-Gg: ASbGncttR5QSEUzcMj5ny/40by4AJ7XKbVtgNoLB2aWo0fTb9bmBEESfse+vzAmjg3W
 WQb60P4ZFhJbgIGSJqSnbamKjoPwIdGY6QZuVC7i0UW9URuL+WlfJZSS5NvTfA7LyXvUPXUYrRQ
 xVYBSAku23lIfBvi6kQtajC5uvugQKkCHymGxXK2RoUvL6pur3yzMzEWoEg7ti6CiUB7LQQbTFJ
 7F5cR52jz1K7fUrlcJIqmc7bZ+C+66aef1JRS6krcwmi7Nd81Y8aibztUN9T6Kuo/drv8geeYzd
 svGok/pEgmJszpwbZEzsvTqZu9P1zpRauhwy0B1uwFeKmbjmcS60ZLcsXgRRj9USktsNnMjiqMM
 2UlxV90C6khBz48rwVA==
X-Google-Smtp-Source: AGHT+IG7uDqRx12/ZwE/83u7TzoN8NLXfa2f1JqODJjTLgndF8xH1g5OdgdAX9CLX9dTE0wbI3DHKsf+MWLm86lJYqI=
X-Received: by 2002:a05:690e:d08:b0:63f:b1d4:f9e3 with SMTP id
 956f58d0204a3-64436fb0184mr6233817d50.9.1764919519734; Thu, 04 Dec 2025
 23:25:19 -0800 (PST)
MIME-Version: 1.0
References: <20251118043042.27726-1-hs@nabladev.com>
 <176487670995.2050783.17410258029578449020.b4-ty@konsulko.com>
 <e2b4a1f7-d915-8e83-2f9b-7f48a56d8e2e@nabladev.com>
In-Reply-To: <e2b4a1f7-d915-8e83-2f9b-7f48a56d8e2e@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 5 Dec 2025 09:24:43 +0200
X-Gm-Features: AWmQ_bkaZHbdN1FWrSGq-tbXCqU4SBXxXUWMCYEPLI6lvdyb3q0zJI9D3bEJQSQ
Message-ID: <CAC_iWjJJEG2aUKhNLLY9KgqnROtTbCKd9Ex3-mhviado=r++Cg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
To: Heiko Schocher <hs@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
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
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 05 Dec 2025 11:04:35 +0100
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

On Fri, 5 Dec 2025 at 07:03, Heiko Schocher <hs@nabladev.com> wrote:
>
> Hello Tom,
>
> On 04.12.25 20:31, Tom Rini wrote:
> > On Tue, 18 Nov 2025 05:30:36 +0100, Heiko Schocher wrote:
> >
> >> Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and desc=
ribed
> >> at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> >>
> >> TPMv2 defines hash algo sm3_256, which is currently
> >> not supported and prevented TPMv2 chip with newer
> >> firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
> >>
> >> [...]
> >
> > Applied to u-boot/next, thanks!
> >
> > [1/6] lib: Import rol32 function from Linux
> >        commit: 6a0c939b88fd42c6b0a374f7c87317f292df46a1
> > [2/6] lib: import sm3 256 hash parts from linux
> >        commit: 41c0131b950a16747929ab310588cf5db8e38123
> > [3/6] lib: sm3: implement U-Boot parts
> >        commit: c4ab316269debc321907acc4f8f02dfe5653aeaf
> > [4/6] test: cmd: hash: add unit test for sm3_256
> >        commit: 213601a600f1e8894cea76b0bfc131f038882407
> > [5/6] tpm2: add sm3 256 hash support
> >        commit: 7c3f05ad51e4bc23dd4f411f28968f1d8f43099c
> > [6/6] test: cmd: fix a typo in md5 test
> >        commit: b30557b3b46c5162cb88a57907c517ed95557239
>
> Oh, may a little to fast, as Ilias and Quentin had some comments
> about tpm2 implementation/test (tpm2: add sm3 256 hash support
> patch). But I can send changes on top of that patches (but
> give me some time for it... end of year rally has started...)
>

Yea I pinged Tom yesterday.
tbh, my main concern was testing the changes. I dont mind if we revert
and reapply or send the changes on top.

Cheers
/Ilias
> bye,
> Heiko
>
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76870C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 14:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F236980780;
	Thu, 23 Jan 2025 15:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nqzDaQDa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AF9380137; Thu, 23 Jan 2025 15:38:43 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0AF7807E5
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 15:38:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5d3e6f6cf69so1692716a12.1
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737643118; x=1738247918; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G0vigkmi68IBiZUCV1IGKf0vxOq6DUZkEobi1GJ2OpM=;
 b=nqzDaQDaRErFuLCD0SgkQGPcUuTPa7o4bfUONZuY0H/QzoCnNS1Qv9wRjUqrarVLPj
 kVfwDmMktgNUpMV9egfvnM6iq8wbCF38QKf0wByvbbZd0UerYeJiPaBm27PvFYB5b4vw
 1qcgh6fpfXVghjof1qIjxMe36NPUg/9w3WnpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737643118; x=1738247918;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G0vigkmi68IBiZUCV1IGKf0vxOq6DUZkEobi1GJ2OpM=;
 b=Vpr4t2UqOPK8hM4+himDcJTtEcTB/hydc+mRlIQSRP+X2kLUCVPGEtHAmA9sAGrBpR
 +Rpu9nfhbF5bd5dfteXyw8GhCsM4Mm4zfADEBDbQxmEEWHcbaqIVX5MlFR3yxKh6xOor
 Zmkw7AwaRzygeZnv2uUheW4x/nVTdR2KU3aiSInfYWAX6qdAkgNMM1PAqU99oP5+OtwY
 SWFQCRQfkK8nn7n867nt/07jPLc7PbkGFp6/vSvSZNSoZS+k/qXMnPBPEtYZQ40kNoWN
 YNYeqGCHz4SQJENR5Buki46mAeTZwCW7XJcarQ74No/R16NNlVVNQzGgzZF93asw8FyT
 eDBA==
X-Gm-Message-State: AOJu0YzUQ6IHPIPjdvYUoxVN0r8n9Cb03vef1OJav/LN/Gj5S8JLxGZQ
 7vHdNka0KQjygXeHwPye4yw8Uf3bptW3N/A62M7TXrOcSk3m176kMKp0EF/VS8BODnTby3ja0Jg
 4jdDmKcUeJZephhCFNZH7VUgGz0xMdFD4MgtQN/wmLAxFT6M=
X-Gm-Gg: ASbGncuqUwO1S0UOb5022G0NiVKxPjbYB6SgXo0ZkKUkOWGIGZTx49lJ4rOVoPfHQMF
 h3WrCdCFkp+RZ/hrA+7hT8ZRwhCSxvuiBGYsgkQYCmpsBMgYmdnNusTY5Z0Z0p20=
X-Google-Smtp-Source: AGHT+IEKzF7u/c/3+NKbFvsQt1NFsCkFn0wTdPeO/napAUTonpbziuUTy0Xnl+lh+hxDWHdb1SGhy3sRL1+cAesn7bQ=
X-Received: by 2002:a17:907:2d2a:b0:ab3:ed0:cda with SMTP id
 a640c23a62f3a-ab38b191674mr2495718866b.9.1737643118376; Thu, 23 Jan 2025
 06:38:38 -0800 (PST)
MIME-Version: 1.0
References: <20250120215340.617194-1-sjg@chromium.org>
 <20250122172449.GP3476@bill-the-cat>
In-Reply-To: <20250122172449.GP3476@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 23 Jan 2025 07:38:24 -0700
X-Gm-Features: AbW1kvaGvf6_W45Kj9ZGdWLyJpY8FsyYes2eTpcFzvz8q1M8f2wotufScmhc3Yk
Message-ID: <CAFLszTi0n45THjqvt9GfDfTJxr0aAB1+r0M8EzAhGdoV4eYr3w@mail.gmail.com>
Subject: Re: [PATCH 00/28] test: Complete the suite migration
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Gendin <agendin@matrox.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bryan Brattlof <bb@ti.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Julius Lehmann <lehmanju@devpi.de>, Linus Walleij <linus.walleij@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Massimiliano Minella <massimiliano.minella@se.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Rasmus Villemoes <ravi@prevas.dk>, Ravi Minnikanti <rminnikanti@marvell.com>, 
 Raymond Mao <raymond.mao@linaro.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
 Tim Harvey <tharvey@gateworks.com>
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

Hi Tom,

On Wed, 22 Jan 2025 at 10:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jan 20, 2025 at 02:53:00PM -0700, Simon Glass wrote:
>
> > This series completes the removal of test commands for suites. With this
> > it is possible to declare a suite (including init and uninit functions)
> > without needing to write a command.
> >
> > It also adds timing for test suites, so we can keep track of how long
> > things take.
>
> This causes ut_dm_dm_test_cmd_mux_list to fail now:
> https://source.denx.de/u-boot/u-boot/-/jobs/1001470

Yes, I saw that as well, but i figured it was unrelated. There's
definitely something odd going on in the tests :-( Have you seen any
other such random failures?

>
> There was a trivial rebase needed for one patch, but the rest of the
> series looks otherwise fine.

OK, ta.

Regards,
Simon

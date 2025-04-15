Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB670C369BA
	for <u-boot@archiver.kernel.org>; Tue, 15 Apr 2025 18:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 090448209C;
	Tue, 15 Apr 2025 20:45:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xJv5wFZR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BEA2182A27; Tue, 15 Apr 2025 20:45:51 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82B2B81F7E
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 20:45:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so4502794276.2
 for <u-boot@lists.denx.de>; Tue, 15 Apr 2025 11:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744742748; x=1745347548; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xa8Tevl7fuuXtePq2J+RMxSfDH3bIgwfORWYmZrhpnk=;
 b=xJv5wFZRhY4+8FE5FNOgaM5U/L1U/EbRL4Zdckdo7H5W72wnVTPywRkriXQjUqOrox
 2zkDDbvLA67MnXMDx8SYYofghCeu1NrsTF3aDwvy+PMP0+K1iP8LJBtMp3xbP0cELiZO
 +XaYZaqwlQRh8hDbQdqqz1gFb3r2G3Famx2TXwTJHnJVSAIqk9CGTwJNqI1uUbJ0KlIg
 mlCwNN+KoMthzo29qm0Stb2nMmOs2uVGRAqIA6mHL/3x/+rdO+ZMZoLOvghRRI/5jFaR
 TpodSt0CEzM2gi/8v+5qmBab+SNbB6v7KF7DoeNCKc14SWxxLgnm6lEIfdzyIf9Xs1wi
 +FpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744742748; x=1745347548;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xa8Tevl7fuuXtePq2J+RMxSfDH3bIgwfORWYmZrhpnk=;
 b=TQ41iTtgUGm5Xk/ylCui22frsVY8r+erwgV/huZzZySHei4bSg43eSBTMJxGLaCZGr
 oHLdtkeF+X1P9pGn7QKG38m0zxWXI1pZrO8ielTgoOiXZq+uuLblb55mCJTMIdhDbd0I
 mPKLXRBirZUsL65BLk0wmPXr+97/kl8qfNTuvY5OTPtWcWvqaF1luMyYaqvu6ul+l73t
 H2KfoIjMyInkYorHdswgco9xH9+KdOhxaOKE8PFAMUV8cbk//Q6k/P2X6R5br2tHerLO
 lBAM4E7fjpnfup3Fd9i+hQHl1tIIqd9o17oFq934eZvlE2F/+0SQkEX3qZhKz1kCZwqw
 fdaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8AQG7MjG0sUqsWBWzVrU66lmGWntbsX39jDFxSVWnJvjl1yucUkliF94QievXNH74jFmj+4g=@lists.denx.de
X-Gm-Message-State: AOJu0YxVZ04ajnMbiSpyvkeO4XPpzj5Jqm90HcOJDAh+TavKhdT/bcdG
 8dJShodhfrSGyfWhowXCF0En4bMYcuc0EG+6u6Y3T1xJjD+EDU30sK4lDEgPQBKeiTrdr9FycNw
 BXdDPnSU+W+SV2N1HDOKDTtl3rEzYiijs6Z2f9A==
X-Gm-Gg: ASbGncskgvE8tCK5F816XImaPvlIhpoEn7SLcBgt/LBpup46lvW9+HCdzTCFf144rNO
 XhWnDLz3kcuFnX4Aa3qN4vfeAU9842rFUhyj5SkmBJbEn53Bgx0SNZKbPrN8PGWSP9066ffXueQ
 srmaVX1FwRpAYU4RdZJtyKAfmOc6ZpmWtYXA==
X-Google-Smtp-Source: AGHT+IFaZG0v3tF/UWiSlXKSaHOsrHxw669nMrYGhBcgJpoLKwoMQauS3Jsob2ooxqLWYO014I9JEHZDDF7fStJcWB0=
X-Received: by 2002:a05:6902:2211:b0:e70:a3ae:4797 with SMTP id
 3f1490d57ef6-e726e7c60e2mr514729276.11.1744742748245; Tue, 15 Apr 2025
 11:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250405190711.365419-1-sjg@chromium.org>
 <20250414225307.GH5495@bill-the-cat>
 <CAC_iWjKUBp1dUkGVts7aCcJEFNrE95Lu9ApmpPR5itCaWanJRQ@mail.gmail.com>
 <20250415141226.GJ5495@bill-the-cat>
In-Reply-To: <20250415141226.GJ5495@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 15 Apr 2025 21:45:12 +0300
X-Gm-Features: ATxdqUEYXwsRujs_i_SAtBMKzEM7svKuFitzdukPrjtAOaBdU-tcLupo0ZKSKeM
Message-ID: <CAC_iWj+480bm2w5pgSOY6cA_R-BfeH3aUhQyUgwceOogkN0Gvw@mail.gmail.com>
Subject: Re: [PATCH v2] emulation: fdt: Allow using U-Boot's device tree with
 QEMU
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Phelps <andrew.phelps@canonical.com>, 
 Alexander Graf <agraf@csgraf.de>, Bin Meng <bmeng.cn@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Max Filippov <jcmvbkbc@gmail.com>, Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
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

On Tue, 15 Apr 2025 at 17:12, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Apr 15, 2025 at 10:22:50AM +0300, Ilias Apalodimas wrote:
> > Hi Tom
> >
> > Thanks for roping me in.
>
> You were cc'd on the original, FWIW.

I completely missed that and only noticed it with your reply. Thanks!

>
> >
> > On Tue, 15 Apr 2025 at 01:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Apr 06, 2025 at 07:07:04AM +1200, Simon Glass wrote:
> > >
> > > > At present it is impossible to change the qemu_arm64 defconfig to
> > > > obtain a devicetree from the U-Boot build.
> > > >
> > > > This is necessary for FIT validation, for example, where the signature
> > > > node must be compiled into U-Boot.
> >
> > I'll repeat once more, that using the DT to store whatever random data
> > you invent makes little sense.
> > No one is obliged to follow internal U-Boot ABIs. Instead, it would
> > make much more sense to store the data in the U-Boot binary somewhere
> > and retrieve them. On top of that we now have proper memory
> > permissions at least for arm64 and you can place certificates in
> > .rodata.
>
> I don't see the high level difference really between blob with a
> signature attached somewhere being good (signed EFI files where the
> signature isn't an external file) vs blob with a signature attached
> somewhere being bad (what Simon is doing with FIT here).

There really isn't a technical one. The only thing that makes our
lives a lot easier is that DT is governed by a spec and adding u-boot
signatures in there feels a bit weird. It also *requires* us to do
things like the current patchset, while using the binary itself
doesn't.

>  So as long as
> we can drop the antagonism (and don't break other use cases) I'm fine
> with letting this alternate way of securing a system proceed.
>

Thanks
/Ilias
> --
> Tom

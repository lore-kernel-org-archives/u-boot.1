Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CE8C4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 951688770F;
	Fri, 10 Nov 2023 12:50:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YeHelQ5F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A23AD874D3; Fri, 10 Nov 2023 12:50:46 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C4A187585
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9e4675c7a5fso312698166b.0
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 03:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699617043; x=1700221843; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lo2mXY4rRuzqobjjN2116GdAajCU/zn4UqBn3wCYtKc=;
 b=YeHelQ5F8N4uRoSIm9u/P1DM1dNrh4+uglJSJCkO+caIr+WYAyFdApCVybNJxhNzRt
 Bge5h8WyhkL38EZm/s+WiBt96IJN5/zGLHl/mlOdGLSoKwqGpbfz5Uf8qtzBe5Puz4k3
 zioPBi0zycDA0LfKG7ANoWhlByThRSLxHXdXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699617043; x=1700221843;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lo2mXY4rRuzqobjjN2116GdAajCU/zn4UqBn3wCYtKc=;
 b=WJmlIJWdTVKIFsRP34ZjlFZayi8UeCjvcYgK575K0W77EMY3ERDSNncIkciRyy8f3H
 1+WXpCIViAAbG+YiKbkInEqlB/fbXQon6yC2dImnc6Ajc4TARuikfJ7keXALMK7rFJn5
 uXIuIt6tAx+LNJ95+5N3kb4uWTCGtg4+0pJgfp31eVbsGIAIS0PqJzHfRgdD0fh/yboJ
 3nrs34eVAiQr9EhgLNZ8Q6DLzH00IfLpJh7AD2dCy7c8itqDsuMOM1E+bB1Q3t9sYJWN
 Y/BkfM7/vz+PUThH0JAfbshoNnR/kFE8lEls5as113IshnKYRn9JASqnDOwQIdrmqVYn
 yCPQ==
X-Gm-Message-State: AOJu0YyGlSZybkQqHiq4vZYYNnwFmgqkjf3UstuSpW5Nc1UxPH7zr0lr
 jwBAyIrDLcUXWBVW8fQzSb86/bQH/sXGmMxa4TYmzQ==
X-Google-Smtp-Source: AGHT+IFaxzv6KCbL9vAiHQNSsfjqa1bBAQDDD6lE62LNm2G39C23k/sAQ5WSMKRMc6ALrG6S1ukPSxrXqkjmQKCQrQQ=
X-Received: by 2002:a17:907:72c2:b0:9b2:6d09:847c with SMTP id
 du2-20020a17090772c200b009b26d09847cmr6773587ejc.10.1699617043248; Fri, 10
 Nov 2023 03:50:43 -0800 (PST)
MIME-Version: 1.0
References: <20230218122525.3815554-1-mchitale@ventanamicro.com>
 <20230503203441.GA824307@bill-the-cat>
 <CAN37VV5a2KV4R09SJC6TMcp=00wKQ9bmeTRi9rfKpjEqWcmmSg@mail.gmail.com>
 <20230508150808.GB2398826@bill-the-cat>
In-Reply-To: <20230508150808.GB2398826@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 04:50:31 -0700
Message-ID: <CAPnjgZ3b5DCr8yeRG=sTU5_QytWuXMoXR7okMZ6ekJS8ip7rVg@mail.gmail.com>
Subject: Re: [PATCH] pci: ecm generic: use dev_read_() interface
To: Tom Rini <trini@konsulko.com>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de
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

Hi,

On Mon, 8 May 2023 at 09:08, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 08, 2023 at 08:30:15PM +0530, Mayuresh Chitale wrote:
> > On Thu, May 4, 2023 at 2:04=E2=80=AFAM Tom Rini <trini@konsulko.com> wr=
ote:
> > >
> > > On Sat, Feb 18, 2023 at 05:55:25PM +0530, Mayuresh Chitale wrote:
> > >
> > > > Use dev_read_() api instead of the fdtdec API to fetch the host
> > > > controller's reg property value. This is similar to the other host
> > > > controller drivers such as Sifive, Rockchip etc. Without this chang=
e,
> > > > enabling CONFIG_OF_LIVE breaks the PCIe enumeration on Qemu Risc-V =
virt
> > > > machine. The issue is described in the link below:
> > > >
> > > > Link: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/1
> > > > Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >  drivers/pci/pcie_ecam_generic.c | 21 ++++++++-------------
> > > >  1 file changed, 8 insertions(+), 13 deletions(-)
> > >
> > > This breaks some platforms such as qemu_arm at a minimum.
> >
> > Ok. How do I reproduce the issue?
>
> Right, sorry.  So the failure log is:
> https://source.denx.de/u-boot/u-boot/-/jobs/622397
> And https://u-boot.readthedocs.io/en/latest/develop/py_testing.html
> talks about running the pytest suite outside of CI and
> https://u-boot.readthedocs.io/en/latest/develop/ci_testing.html about
> how to trigger CI yourself.  One thing that's not documented well enough
> is that you'll likely want
> https://source.denx.de/u-boot/u-boot-test-hooks as well as you can just
> use as-is the "travis-ci" directories (legacy name, used by both gitlab
> and azure as-is) as the configuration hooks for your system as well and
> then the network tests will run easily, locally.

Any update on this one? It is:

https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/1

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33A3C3DA59
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 13:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E01D88887;
	Mon, 15 Jul 2024 15:31:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ajrasNdD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09E5388886; Mon, 15 Jul 2024 15:31:26 +0200 (CEST)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94EC188856
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:31:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e03a17a50a9so4400410276.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 06:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721050282; x=1721655082; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UEkpkVOf+JZ0gmtZXpZUAlqmqxwy0ol33VaQqh0W2cg=;
 b=ajrasNdDph1zJzKdpr5neOIwh+2lFxFjozoEMGul5XpUQH2Eqem8wiw65YcwQ4x13m
 ynQ5V23n9nMEOVWcwooYXIwkrOeFfP3oLM65VfPB1g4mIou2D5yb89hdZOHAvvw6anE8
 G3TNC6Iv3NTFDg/nDBCohb5PNCX3cpF9dtnbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721050282; x=1721655082;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UEkpkVOf+JZ0gmtZXpZUAlqmqxwy0ol33VaQqh0W2cg=;
 b=Ip2X+QN2XuIqFXLEhe3CsBLkf0q44gfLU2wocO+f1UWyQ6hwD2fALa0h27uAKSPIvc
 yDCVqZFMXUtVKMQr3SPz+FD53o3yCUExdx+Xqp1X7ndjfGaeo1s5xiKIzVqWoqEtUXZ0
 t3U4MKAPR6ftkZJyKA0Q+mvfme3I8EblBbKkM0L6kk2C4qBUfTa5cqNVfymzzTcTV+8Y
 Rs83HB7QlEoMKuQML/ldvNkqNdywhGY/CnLcIoROXGdYx9vu4PRbR8qhVBmD6QdwsqBH
 wK4ZPgXOZ2MTQ2jCftC+wVApejAA1Qy56MlQQQjCYAzvRGA1F1ymtqAOnsWT8ve9B0cM
 U7mA==
X-Gm-Message-State: AOJu0YxHLqqkxB17+zUzpawwvsMfjgWdVj00cUJx7dkstMv0B4y2MdUV
 /eWhF5mbr6CUefJn3BdX2OI8R2bTnjiJkiNZvwVjjesl/jCQPhxXaWaguBLKo8X00R8E45Wl8LD
 YzBFyurCY6TjWfrd8MTIDDekvCOYdQgJcS3F8
X-Google-Smtp-Source: AGHT+IEBQ3qt/1BjVxV7GMGfrmM7k6zFYZUqGPJjqay+tqtt643LnAJ4kdB40/FTWBF3LDXt/YTqYZkg68UFLqdE7c4=
X-Received: by 2002:a25:c5d0:0:b0:e03:5f05:7566 with SMTP id
 3f1490d57ef6-e041b079cd3mr20610355276.34.1721050282453; Mon, 15 Jul 2024
 06:31:22 -0700 (PDT)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 15 Jul 2024 06:31:21 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <ZnvUoW85DxzAIDJP@toradex.com>
References: <ZnvUoW85DxzAIDJP@toradex.com>
 <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-5-sjg@chromium.org> <ZnoKCXS5+Z0tM7Wb@toradex.com>
 <CAFLszTgKvEUVEGOUnuiSzVD3TQE2UjwdFS9Dm8sBpwbw9guaww@mail.gmail.com>
 <ZnrfTOKroizhiPvY@toradex.com>
 <CAFLszTjTxRE03kX51L9cK_=LZXFPDWQLzyXM9swe=7aEYDmkKw@mail.gmail.com>
Date: Mon, 15 Jul 2024 06:31:21 -0700
X-Google-Sender-Auth: J9xuJ5cqVLITCK6evks7d9GNaPo
Message-ID: <CAFLszTiELZMfr=dxW6E4yRxwvA3P4R_Av=g+Zhrb1wgQ1ciW+w@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] buildman: Always use the full path in CROSS_COMPILE
To: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>
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

On Wed, Jun 26, 2024 at 09:00:43AM +0100, Simon Glass wrote:
> Hi Andrejs,
>
> On Tue, 25 Jun 2024 at 16:16, Andrejs Cainikovs
> <andrejs.cainikovs@toradex.com> wrote:
> >
> > On Tue, Jun 25, 2024 at 01:38:07PM +0100, Simon Glass wrote:
> > > Hi Andrejs,
> > >
> > > On Tue, 25 Jun 2024 at 01:06, Andrejs Cainikovs
> > > <andrejs.cainikovs@toradex.com> wrote:
> > > >
> > > > On Sun, Jun 23, 2024 at 11:56:20AM -0600, Simon Glass wrote:
> > > > > The feature to set the toolchain path does not seem to be needed. It
> > > > > causes problems with venv (see [1]). Let's remove it.
> > > > >
> > > > > Add some tests while we are here.
> > > > >
> > > > > It does not look like any docs changes are needed for this.
> > > > >
> > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240621131423.2363294-6-sjg@chromium.org/
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > Suggested-by: Tom Rini <trini@konsulko.com>
> > > > > ---
> > > > >
> > > > > Changes in v3:
> > > > > - Drop the PATH modification altogether
> > > > >
> > > > >  tools/buildman/bsettings.py     |  3 ++
> > > > >  tools/buildman/builder.py       |  5 +--
> > > > >  tools/buildman/builderthread.py |  4 +-
> > > > >  tools/buildman/cmdline.py       |  2 -
> > > > >  tools/buildman/control.py       |  6 +--
> > > > >  tools/buildman/test.py          | 75 +++++++++++++++++++++++++++++++++
> > > > >  tools/buildman/toolchain.py     | 20 ++++-----
> > > > >  7 files changed, 92 insertions(+), 23 deletions(-)
> > > > >
Applied to u-boot-dm, thanks!

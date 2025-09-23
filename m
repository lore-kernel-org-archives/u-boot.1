Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AAACAC5AC
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 20:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49101808AF;
	Tue, 23 Sep 2025 22:49:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BCRpJuam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1A2F82ADA; Tue, 23 Sep 2025 22:49:20 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1EE280107
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 22:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianocarvalho.pt@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-62fa0653cd1so7114031a12.0
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758660558; x=1759265358; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Uu/BuNAaDS0eYEUZZ/MQLBrkEP6VXFipbQO9HlOq6C0=;
 b=BCRpJuamo/DKw7LinU0g5TzJs6Z1GPvq7GnOUqqcHWG0gCDzoA4HnhnjFe/WdyUkGg
 WCbBZMwjKCCvtABNoJAK+zyRkvZf+330Zv0QSVoNs8iJ3KuB9eSqOFEhD7RT4yKKCtp8
 3gqdxBCjuMiJm3CSJtujwKNyc2RcOncjav4aGyGEpCWYa+qfPSzLzfGYyXPe8oK1UdhA
 H8NgDXQ3GJycwx6eFUXpTl6ORW7RUzULQtD9lRQmOdloTvzUDWB0o5vFlSy07vmEDUPv
 UZcxrfGW/xqna2SVvpliHPDk9t8TG/FTG+R+3cN2Bt7RMnmp7OK1FDu7cnGzoQIYXzbD
 Y1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758660558; x=1759265358;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uu/BuNAaDS0eYEUZZ/MQLBrkEP6VXFipbQO9HlOq6C0=;
 b=uX6IFxp82h+a5CcMpb2/4E0irkHGS/TXRDmgwV5GMZkwdoXgCIssJXizdSW1mOvtQ7
 hQvAt++rJptIC43L05Qks9KQVuc1j5ePxdCno0Nwq+QuD7q6JnBZB+RBPfHan9W48Aab
 SF6PzjblkcAfren1RH7pMKYtMRSUZfW9SPEsLVcV/0Ym5/1X0rD6jEFw4xTTPPRraTIh
 NEI39/P54IwzzocCGuOM/e651yb/K4HchsJe2H2gIcTqrAylXPiKeRGPfYPaaoPht3Vr
 Xu5TrpkRNMTh/eFU192XHw9ULS1WMwZjIIK06MrRmeqWLMXkmJOlXI1LiwHQMd7KAMgs
 ppCQ==
X-Gm-Message-State: AOJu0YzyZSD6jCAnQs8WyeKcoL5rCi2Vs5Y6oMwhxRGS3Y9/9Csm7LV9
 3TRSSg4nfAyIoXQ/DUM5lAKsRUfAOShq3D/nQwW6hQyZXrIoSEK6GG/PwhHzCtFx6WBgzsz/0CF
 dkRQC+a6x3/kYC6ofYzj9skvZwf9+MlU=
X-Gm-Gg: ASbGncvgC20HOyXK8R04poCNSi+mzjKGMqzVjog0Bwn1UXIxaLctjkjFBIP3jZagyNQ
 34ZVql8KlQ03Fb0DyFdtXzvzg3xJJZ3XLsgwF0xlYdXHnaArsPOKCuiuE5Wg5iN5Ag5O5zN6wCv
 Oi0LkRO+N5254IrryScS71+/vsCp5sqb8GaG/DbLQEEqgILKKdlaFMcuCFUY80+9P6sHgJBnWPt
 urG1eBkyexyBFi9/XTnX1Q+p3pW6k2pem/1HGw=
X-Google-Smtp-Source: AGHT+IGDqxXm9whgwb8Tj1VoI0zYKLcoLrrI9r+96lVp8vxl74MBqG60VT2bHwGTFrsSc8y27FmvHjt0buuEjt1UdkM=
X-Received: by 2002:a05:6402:1d24:b0:634:5722:cc3f with SMTP id
 4fb4d7f45d1cf-6346779876dmr2824564a12.16.1758660557970; Tue, 23 Sep 2025
 13:49:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250825224459.682403-1-adrianocarvalho.pt@gmail.com>
 <20250825224459.682403-5-adrianocarvalho.pt@gmail.com>
 <20250825230044.GB124814@bill-the-cat>
 <CACAHuLCyX_32AQozgt-Wf18b7ia5m3nRJZ7bA=M9oM1mwh-OXA@mail.gmail.com>
 <20250827002317.GF124814@bill-the-cat>
 <CACAHuLB0uwUjnR58qgeoOcHO-PC5geYFuBKF4Mw+=UFjT9urRQ@mail.gmail.com>
 <CACAHuLDZzgF1a7wG8fwNZ1YnUruPgyd9MifY2COS1kQFsqXsTw@mail.gmail.com>
 <CACAHuLDp5COeBue8jt8U3s59UsTnzjFH33ThXVFXk7-XLCF1BQ@mail.gmail.com>
 <20250905230929.GN124814@bill-the-cat>
In-Reply-To: <20250905230929.GN124814@bill-the-cat>
From: Adriano Carvalho <adrianocarvalho.pt@gmail.com>
Date: Tue, 23 Sep 2025 21:49:05 +0100
X-Gm-Features: AS18NWBLlHacz2gI2htO_28fD83J_oQLcV30iXOkz6M_GbT6na0uWlQjpIJ-GkQ
Message-ID: <CACAHuLBgL2h+XYysfwYSOBcwyjrJRk7Z4X5Axr6PDDF_Xq17Rw@mail.gmail.com>
Subject: Re: [PATCH 4/7] doc: make pdfdocs: Ensure SVG files are converted to
 PDF before the compilation of *.tex files
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>
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

Ping. Any update on this?

Com os melhores cumprimentos. / Best regards.
Adriano Carvalho

On Sat, 6 Sept 2025 at 00:09, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 04, 2025 at 02:24:57AM +0100, Adriano Carvalho wrote:
> > On Wed, 3 Sept 2025 at 02:14, Adriano Carvalho
> > <adrianocarvalho.pt@gmail.com> wrote:
> > > [...]
> > > So, in principle, we "only" need to replace all ".. image" with "..
> > > kernel-image" (65 occurrences / 17 files). However, I did that, and
> > > got:
> > >
> > > sphinx.errors.ExtensionError: Handler <bound method
> > > ImageCollector.process_doc of
> > > <sphinx.environment.collectors.asset.ImageCollector object at
> > > 0x79380051bbe0>> for event 'doctree-read' threw an exception
> > > (exception: 'uri')
> > > [...]
> >
> > Actually, the right approach is to use ".. kernel-figure" not "..
> > kernel-image". The latter is never used in the kernel.
> >
> > Using ".. kernel-figure" it works fine. The remaining patches are
> > still required though.
> >
> > So, if you intend to remain aligned with Linux in the way the
> > Documentation is built, instead of this patch a new one is required
> > that replaces all instances of ".. image" with ".. kernel-image" (65
> > ccurrences / 17 files).
> >
> > Please let me know how you'd like me to proceed.
>
> We should switch to "kernel-image" and update our checkpatch.pl to
> complain (and this might be acceptable to the linux kernel too, are
> there instances of ".. image" ? I assume they too should be
> kernel-image) so that we don't regress in easy to catch ways.
>
> And then yes, getting the correct non-zero SVG for the TI example needs
> to be done.
>
> > Moreover, the infrastructure to build the Documentation is a bit
> > behind that of Linux. Not a lot but quite a few changes. Should I try
> > to issue a patch series to place U-Boot as in sync as possible with
> > Linux?
>
> This is a question for Heinrich. Thanks again for digging here!
>
> --
> Tom

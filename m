Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694EDC3601A
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:54:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C65F8829A0;
	Fri,  4 Apr 2025 16:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ec90EWBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA66829C3; Fri,  4 Apr 2025 16:53:57 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBD38828AB
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 16:53:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3014ae35534so1816404a91.0
 for <u-boot@lists.denx.de>; Fri, 04 Apr 2025 07:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743778433; x=1744383233; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7UEObFS2K+BgtoGzOOOlEBiSsxlR2HfrqSMkm5nvy3E=;
 b=Ec90EWBKZ2+UIfLr7dlKhJlVc6hMsrCBFardBiL5ZLJSSByHJz5GVpwj8OfJGYWmbU
 ew2dQqyd8HY99PfZENkqqtFizrjn2hPsvs5zCpI6mf+hxlcWUzdbzyMVBcQdIH0Y9sgq
 cZxccuUurN4IU9Q7izcNxJaCh6iCNFBVeR+EYRryS/lJVpzmV/2KUtPPilfP4w+G3Epf
 MXIodDlXc2ozFLNvjOGH2PxB6rfWtTihjSsGN0qM314SoeeeA0ABHwNvTBwy7yjRQutL
 ahrQJ/L/NsE43GSB0EFX2+h2lDXp4NcV7fVdO6wxeEOxTOcfb4hbFAsvlG8cKmhaD7jj
 ytFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743778433; x=1744383233;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UEObFS2K+BgtoGzOOOlEBiSsxlR2HfrqSMkm5nvy3E=;
 b=lRCK0P3pVmccbJqbSzmFJ7kskGELL3VbRHDL4mr7UOcyitXLHv9R0GxQTByo3YGOCe
 plmMfDbWiSVcM8psm6FcDEWYW9sKsjK2sNRxn3nVkqsrwWlikI+r+xPVCmhCHiUld0Xy
 0uY5YCKiGjUImNXAKhAI7eMn3P9MAOaDZUh0l9z/m5QZEioKm3JEZx5EnOObQFuJTX/J
 u1uNXs1e4nAnVgd0+K8d88Yq1LR0K3zK1ncXfDBoiJP6UMaoCq54kpsfUCBs+/1fOG3n
 WXqT7WUt+gffevohJYcMarCg9g3m3RtbmMImFCLdxLFNMTv8I7FupFNS0D7EIkHNElNe
 0WZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXe/7QTIveVxajILFlQOva0rWMOGExRYNhNt0kQOvYxLtAAoxKfBDdK2HTty5E/0uvJL3P+qUY=@lists.denx.de
X-Gm-Message-State: AOJu0YwfrDm6rGVt1pDmh43xXnSEmEl+uiEskXB15pW1jYUl4IGUn+9n
 wPIxWzfoWi95/QxHdxmnj8XkR21CudnWsVbDi1PpaoM+2JvAsOONvvJe7HK+Yi0rXqhRczF2KQm
 XfDFwVqAj9zwtwttpr+WuO8rXPY4fLDnZZ6eCn2Y/Bmixa+it
X-Gm-Gg: ASbGncvK9smsU8TVC7Cn0I53zpw7S2NU5DK0ikLT+4LQd5ddUSPk8EibRJC2GK6F7Nc
 0F3DW78ljuPSNT6mxxCraHHnVo7uBYiEyguxsYizclg8hy+qIAAnJ6TspGmxEjb2kx0EPkDtQR6
 BcrEzct4xQdmL66lg65nURxSkw4Qg=
X-Google-Smtp-Source: AGHT+IGZP8rxwITx5I7ioYxB6+WOgcPlawGyiDHPaaRuGhCBMuN/uifDOGnck1ugizXmi7B9QwhO7cpLeNpckJ0ciwI=
X-Received: by 2002:a17:90b:5683:b0:301:98fc:9b51 with SMTP id
 98e67ed59e1d1-306a4821cf3mr5077081a91.5.1743778433159; Fri, 04 Apr 2025
 07:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
In-Reply-To: <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Fri, 4 Apr 2025 10:53:40 -0400
X-Gm-Features: AQ5f1JoTcuNCv67U-UrGU3HjLiZOiZKBShKxtwm0BSqEfQgMsA9pynsjZFExPVk
Message-ID: <CAEfUkUJG4+Tbzgy==JK_2pptLfuYvjDzu9txy8iZ+EAALEEKFQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
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

Hi Tom and Simon,

On Fri, 4 Apr 2025 at 10:48, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Tom and Simon,
>
> On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Hi Tom and Simon,
> >
> > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > >
> > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > so that it is simpler to understand and manage.
> > > > > >
> > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > >
> > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > be resurrected to give some coverage.
> > > > > >
> > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > >
> > > > > Based on how it's documented to be run in
> > > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > > that platforms using the handoff spec still work?
> > > >
> > > > I believe so, yes. I don't have that board to test it though. Raymond
> > > > may be able to test this series on QEMU?
> > >
> > > I was pointing you at the docs so that you would have access to testing
> > > it. That's part of the docs, running the emulator.
> > >
> >
> > I can help to test the firmware handoff on qemu.
> > I have all the necessary changes and unit tests for the OP-TEE repo
> > qemu v8 build to test this.
> > I will try to find some time early next week to review and test this
> > series before turning back to you.
> >
>
> Just a follow-up on the testing with TF-A and OP-TEE.
> Unfortunately, the patch series breaks the transfer list handoff to
> U-Boot completely and just end up with below error when U-Boot boots:
> ```
> No valid device tree binary found at 0000000000000000
> initcall failed at call 0000000060097bcc (err=-2)
> ### ERROR ### Please RESET the board ###
> ```
>
> U-Boot test version:
> 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.
>

Forgot to mention: with OF_BLOBLIST selected.

> [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/
>
> Regards,
> Raymond
>
> > Regards,
> > Raymond
> >
> > > --
> > > Tom

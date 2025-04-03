Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C525FC3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 17:58:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C74398215E;
	Thu,  3 Apr 2025 19:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="clVw6x12";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E440F82149; Thu,  3 Apr 2025 19:57:50 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478E68215B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 19:57:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-ac25d2b2354so207657566b.1
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743703068; x=1744307868; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9e5LWwxwhaPXcygWPIdXrvmCnlJCUbf+WM0nz3lF4U4=;
 b=clVw6x12r8xHL/r+Tq6KR6Qwg9rYk0/iv7mrVLuJcpjdcqb3ccqLn4MEO8C9+LyX5k
 vCM96UMotdl/6DvGdNO3JNyA+4FgqQyZkH1LNgh9I/nhUg6ofvvbTvC43Wg7NGVvu+qZ
 R8Owu0PShKhra6C9fnNWX44E0EQi5PLVBARIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743703068; x=1744307868;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9e5LWwxwhaPXcygWPIdXrvmCnlJCUbf+WM0nz3lF4U4=;
 b=G2DPzHJHxcDeXP/FcDpvZdj7GvxVunas36pmq5qIqvxf22rVlEYRfzzNRSxYckuy8m
 0bb7k88BYVMsVsdWBvC/ejubfO+MnvPXQx6FXQyqqSruG95E0f7twD805L2n5VpK6Glm
 R038cSFb4dY46DdyJxtw0h1nc8SiAtuONtd55Qpy/8a3JLd4diuHFpEL9mVdWCo/PLLJ
 O+WRufadx9lUWLGapVUqow48bKoD3LsToLkxIZYILLrqFsKm/ADXxfW0uQAE3JHqPpPB
 /397HiM3/mDpLEhfLRMYaASd4NGkqttDmQ3l+yOzLQsFiDruSeB9AXgtJarkdqZ4nBkO
 9q9w==
X-Gm-Message-State: AOJu0Yzixc2ZgmQbKgvS2/3UMdnP+7fS/Eg2V3I9f3Zmi+D0KlXSZK8o
 csM3x1Wnh3LFZhTt8jIZBOMKPgthhcv59+BtAM7+Dt5m3BdgMXpteB4ZUBIr+HLWdjrmhqkTwy/
 ohiMGonMDOC/JtPpkbLxeS80/vdhq6TFwdRXa
X-Gm-Gg: ASbGncvGWw3J5us5kW7V0xYd+YqdgsBpJ+5TnxSy+ffAIColHkN2e/6ACPYeW0rnWEt
 Pgo+x7EkOVWN83GbG+mLfoHdGRwt8CoV3TJK8Zq11PJ/Nks6gc2vtYUbWwWVV7+nkvjRHM7+k9A
 NAbAvZeTzYd2uhDpV2nIHCYZMTskq1
X-Google-Smtp-Source: AGHT+IFy78TXaXZ5c87A7YduUvFoUDQxB+rVzRArUQwUZOrIFJhRpMH9b5qTWgoFYSUAJ2loYmfVJxJfGOwItTqwVns=
X-Received: by 2002:a17:907:94cb:b0:ac7:391a:e2d6 with SMTP id
 a640c23a62f3a-ac7d1d2fe05mr34748266b.61.1743703067420; Thu, 03 Apr 2025
 10:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250401172948.1236000-1-sjg@chromium.org>
 <20250401214113.GP5495@bill-the-cat>
 <CAFLszTjJuY9pQDerNuFcmkRuZbJU+EfPSBTrDyhjFMZg+usPnA@mail.gmail.com>
 <20250402150024.GU5495@bill-the-cat>
 <CAFLszTh-N2PSKPV_OHa63mEi1ar6Y9+p+A4UTfTbf329wOiN9w@mail.gmail.com>
 <20250402211100.GD5495@bill-the-cat>
 <CAFLszThRQi2o5g5S+=eciOS8+XC8TV9AyBpYf9LQKmH-2kkmvw@mail.gmail.com>
 <20250403002754.GH5495@bill-the-cat>
In-Reply-To: <20250403002754.GH5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 4 Apr 2025 06:57:34 +1300
X-Gm-Features: AQ5f1JqkCmbOL3xw2ekljzvQhmN3T3EygP4bDrqQ0N5F6-tIk1bfQPlNJ-JV40Q
Message-ID: <CAFLszTj2kJhu3-5wJuKbJ0F+0AAcDqEdt7npOT2L=GzcjP4Zew@mail.gmail.com>
Subject: Re: [PATCH 00/13] video: Enhancements related to truetype and console
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Graf <agraf@csgraf.de>, 
 Alexander Sverdlin <alexander.sverdlin@siemens.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Anatolij Gustschin <agust@denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>, 
 Devarsh Thakkar <devarsht@ti.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Thu, 3 Apr 2025 at 13:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 03, 2025 at 12:54:55PM +1300, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 3 Apr 2025 at 10:11, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Apr 03, 2025 at 08:19:03AM +1300, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Thu, 3 Apr 2025 at 04:00, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Apr 02, 2025 at 01:08:56PM +1300, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 2 Apr 2025 at 10:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Apr 02, 2025 at 06:29:31AM +1300, Simon Glass wrote:
> > > > > > >
> > > > > > > > This series includes some precursor patches needed for forthcoming expo
> > > > > > > > enhancements.
> > > > > > > >
> > > > > > > > - truetype support for multiple lines
> > > > > > > > - make white-on-black a runtime option
> > > > > > > > - support drawing a rectangle
> > > > > > > >
> > > > > > > > This series was split out from schd2
> > > > > > > [snip]
> > > > > > > > base-commit: 3f76d803db9b500f43bc534465945a8d2836bb3e
> > > > > > > > branch: schg
> > > > > > >
> > > > > > > I get as far as patch 4 before it doesn't apply to -next.
> > > > > >
> > > > > > Your tree is missing the video-damage series which adds some more
> > > > > > tests. It is here if you want to pick it up:
> > > > > >
> > > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=369663&state=*
> > > > > >
> > > > > > I can rebase and send a PR if you prefer.
> > > > >
> > > > > Reading the cover letter again, that doesn't seem ready to merge either.
> > > >
> > > > It seems OK to me. What are your concerns?
> > >
> > > The cover letter read to me like it should be further reworked to
> > > address some of the problems it still has / exposed. That's likely why I
> > > marked it as Changes Requested a year and a half ago.
> >
> > Which bit of it? Are you talking about my conversation with Alex, or
> > the actual cover letter?
>
> Yes, I'm talking about the lengthy discussion in the cover letter which
> sounds to me as a summary of "changes requested".

Perhaps we should talk about this on a call sometime. I was trying to
understand why EFI has to sync the video after every character. I
still think we could sync only when there is an EFI event, e.g. by
hooking up cyclic, but in the end there wasn't really anything
actionable for the series. Any such work would need some serious
thought.

So if you are waiting on me to do something so that series can go in,
let me know.

Regards,
Simon

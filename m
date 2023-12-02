Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE8EC4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 16:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38EB787692;
	Sat,  2 Dec 2023 17:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vf5KvWmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 347F28768E; Sat,  2 Dec 2023 17:36:59 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF73587692
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 17:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5b383b4184fso35080627b3.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 08:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701535015; x=1702139815; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmq/cFT6Y6dC+ZGZHIOXRnqtNB/fT5Py3GIET4EXKuA=;
 b=Vf5KvWmCsq93feyB3fBw0R4YJqBmCLlMjnt+6df3xpepZnTrQaNd0cBCGMi9Q7bRMw
 qDlzIv01tMGBm72oJ3oKGZ6jcXFPI0OsM83J+lAA9Ur5cipY/a67kEmHilj2bE9CCsd9
 UldJLQf1E6D6FKUGHUiPaGNN7t9rmQF7oG8rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701535015; x=1702139815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fmq/cFT6Y6dC+ZGZHIOXRnqtNB/fT5Py3GIET4EXKuA=;
 b=s5/G4DEhX/eGVy5nov8oKHomz/ej2SmLS94AwcPYZnNMeVvpTmy2cH3iN71HBaPNwD
 8lYMPX6I50LPp8vItBFn2kY/mjSP1MBx/RG+7/SavqHd+BRtW4iQqE2bZS47pJ1s4WRK
 F3s5udOoIfGCxn+o+zKWyRtabBZwpXZUDxcHpnmAt1VsNWzOjP3jAap67/grYMj0hQg4
 OfUmt1qL/JzPWo79sS36xTe40sSHBtIaqAMNSGRFM0JLVayjUYnaOCVPlOgeIx4reMtw
 2A0acTd17linXHABNjh3VMX4qjbQ1QgkQHuQbQg0zYqz5nPwZFp0rQNMJVErLihCcN1h
 LEgw==
X-Gm-Message-State: AOJu0Yw7/eFMEGwo1cnumMwC1W3b7R3zjIphEMnIxpIDSMdhwB29y5Rv
 pMEDKP5zxoBfWooOTx/f1fubV7Yv+zNUqBNiv0yqNg==
X-Google-Smtp-Source: AGHT+IH/60peGhTt9y/eOb6F5Qv2MgIvlLVUHNwYYYShkzzfp7qqnH+PPUtOqXTU5FtOCPkYH/jLqHZEsFZXfccg9JQ=
X-Received: by 2002:a81:b61f:0:b0:5cd:fd7c:274f with SMTP id
 u31-20020a81b61f000000b005cdfd7c274fmr998750ywh.26.1701535015390; Sat, 02 Dec
 2023 08:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
 <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
 <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
 <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
 <5e8f42f8-2b03-4033-b6d2-9b3139f081d5@pengutronix.de>
In-Reply-To: <5e8f42f8-2b03-4033-b6d2-9b3139f081d5@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 09:36:43 -0700
Message-ID: <CAPnjgZ2RjNzqJTRZSWvuscQhs+f8CG=fDcEO=qKXNeQLP53LnQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Doug Anderson <dianders@chromium.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 lkml <linux-kernel@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, 
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi Ahmad,

On Thu, 30 Nov 2023 at 19:04, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 30.11.23 21:30, Simon Glass wrote:
> > On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >> On 29.11.23 20:44, Simon Glass wrote:
> >>> On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>>
> >>>> On 29.11.23 20:27, Simon Glass wrote:
> >>>>> On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>>>> On 29.11.23 20:02, Simon Glass wrote:
> >>>>>>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
> >>>>>>>> The specification says that this is the root U-Boot compatible,
> >>>>>>>> which I presume to mean the top-level compatible, which makes sense to me.
> >>>>>>>>
> >>>>>>>> The code here though adds all compatible strings from the device tree though,
> >>>>>>>> is this intended?
> >>>>>>>
> >>>>>>> Yes, since it saves needing to read in each DT just to get the
> >>>>>>> compatible stringlist.
> >>>>>>
> >>>>>> The spec reads as if only one string (root) is supposed to be in the list.
> >>>>>> The script adds all compatibles though. This is not really useful as a bootloader
> >>>>>> that's compatible with e.g. fsl,imx8mm would just take the first device tree
> >>>>>> with that SoC, which is most likely to be wrong. It would be better to just
> >>>>>> specify the top-level compatible, so the bootloader fails instead of taking
> >>>>>> the first DT it finds.
> >>>>>
> >>>>> We do need to have a list, since we have to support different board revs, etc.
> >>>>
> >>>> Can you give me an example? The way I see it, a bootloader with
> >>>> compatible "vendor,board" and a FIT with configuration with compatibles:
> >>>>
> >>>>   "vendor,board-rev-a", "vendor,board"
> >>>>   "vendor,board-rev-b", "vendor,board"
> >>>>
> >>>> would just result in the bootloader booting the first configuration, even if
> >>>> the device is actually rev-b.
> >>>
> >>> You need to find the best match, not just any match. This is
> >>> documented in the function comment for fit_conf_find_compat().
> >>
> >> In my above example, both configuration are equally good.
> >> Can you give me an example where it makes sense to have multiple
> >> compatibles automatically extracted from the device tree compatible?
> >>
> >> The way I see it having more than one compatible here just has
> >> downsides.
> >
> > I don't have an example to hand, but this is the required mechanism of
> > FIT. This feature has been in place for many years and is used by
> > ChromeOS, at least.
>
> I see the utility of a FIT configuration with
>
>     compatible = "vendor,board-rev-a", "vendor,board-rev-b";
>
> I fail to see a utility for a configuration with
>
>     compatible = "vendor,board", "vendor,SoM", "vendor,SoC";
>
> Any configuration that ends up being booted because "vendor,SoC" was matched is
> most likely doomed to fail. Therefore, I would suggest that only the top level
> configuration is written into the FIT configurations automatically.

Firstly, I am not an expert on this.

Say you have a board with variants. The compatible string in U-Boot
may be something like:

"google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
"rockchip,rk3288";

If you then have several FIT configurations, they may be something like:

"google,veyron-brain-rev0", "google,veyron-brain", "google,veyron",
"rockchip,rk3288";
"google,veyron-brain-rev1", "google,veyron-brain", "google,veyron",
"rockchip,rk3288";
"google,veyron-brain-rev2", "google,veyron-brain", "google,veyron",
"rockchip,rk3288";

You want to choose the second one, since it is a better match than the others.

+Doug Anderson who knows a lot more about this than me.

Regards,
Simon

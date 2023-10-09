Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C62E95A91
	for <u-boot@archiver.kernel.org>; Mon,  9 Oct 2023 15:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC69A8644E;
	Mon,  9 Oct 2023 17:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="OIIeUAEc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01D34864A0; Mon,  9 Oct 2023 17:32:30 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 820A885E44
 for <u-boot@lists.denx.de>; Mon,  9 Oct 2023 17:32:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a200028437so58117677b3.1
 for <u-boot@lists.denx.de>; Mon, 09 Oct 2023 08:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696865546; x=1697470346; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KdBuT8J2trRzh+4wKXs902aT2XGtjmPORBJBUS9rGp8=;
 b=OIIeUAEcUHS1pvMzknIVqqF2v5I8bc8aRcya/RgqU5Ml2kj6sJInb10+6/P0grT1EK
 YBm2kthJJUEAFAp/sp+ZtKA2RuiN7QTH1Ic6QmpdgVoUvJSBRcj1BZ4yUVWSB8BY3PeB
 gKHEjly1icGG720hxGZNi2eEV8apctbYrACEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696865546; x=1697470346;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KdBuT8J2trRzh+4wKXs902aT2XGtjmPORBJBUS9rGp8=;
 b=S/X6MytegKmPvo8v0NXKk/2DjtUINftOXv5Ph3lCpVtAHR1tP2IJ64lWHTJGLI2MRs
 jMF1dmYWqCtpwwyk8sFlS42wcQS3qc6bI3TE+5Jj0vOX5SFEXYGMqYBvlCGOH8q5ek1p
 qK56caTCNa03nYco8fJulcptXSaqly1h2a3YjoYytFmVCzwbGbSP5zcziLmGt9kVmrdb
 TN4T0eNY8yIsqguK3EkN5Fd3h79qbXGLCivGPKOG+kVbJ2mngqClWJX1TWRh7tLSIawe
 YOEEjtErczhokaIlk2xh6TG8bFgEvvzXx7TeYfNTzxqF25R1u59WpF5gvJwfrDBBYteB
 iGeg==
X-Gm-Message-State: AOJu0YwYbIIB/7WIxLh7sJJPI1qOz5dVfQgF4FROsf1PRRLARooXrHv+
 aaDKaES7krdBPOsVc4ANNdNT2tQzs3w1Sm7dF3Ptgg==
X-Google-Smtp-Source: AGHT+IE9jmP/nXb+h1WBmSW7Da+GkCuHCOKigZih30y54OBBPiEpcn3x+sfgJXH+lwFD153DdL5aKq8QMgUmkWO8FJc=
X-Received: by 2002:a81:a18b:0:b0:5a1:d4d4:a312 with SMTP id
 y133-20020a81a18b000000b005a1d4d4a312mr15806429ywg.5.1696865545869; Mon, 09
 Oct 2023 08:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230924203953.1829820-1-sjg@chromium.org>
 <20230924203953.1829820-8-sjg@chromium.org>
 <20230925004346.GP305624@bill-the-cat>
 <CAPnjgZ3ieXXhidSeqzMuPBCgy9UrvOt5zSMO671t1KG9zWAGxQ@mail.gmail.com>
 <cad8dcca-eaa5-872b-db9a-86f5438b120c@gmail.com>
In-Reply-To: <cad8dcca-eaa5-872b-db9a-86f5438b120c@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Oct 2023 09:32:06 -0600
Message-ID: <CAPnjgZ38gfWghmejpQFkJ9y9F8fdC-Wo-YSHT_4_cu8dW1UDGw@mail.gmail.com>
Subject: Re: [PATCH 07/25] tegra: Change #ifdef for nop
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>,
 Tom Warren <twarren@nvidia.com>
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

Hi Sean,

On Sat, 7 Oct 2023 at 17:21, Sean Anderson <seanga2@gmail.com> wrote:
>
> On 10/7/23 19:10, Simon Glass wrote:
> > Hi Tom.
> >
> > On Sun, 24 Sept 2023 at 18:43, Tom Rini <trini@konsulko.com> wrote:
> >>
> >> On Sun, Sep 24, 2023 at 02:39:25PM -0600, Simon Glass wrote:
> >>
> >>> This code is normally compiled for Tegra, but sandbox can also compile
> >>> it. We should not use UNIT_TEST as a synonym for SANDBOX, since it is
> >>> possible to disable UNIT_TEST for sandbox.
> >>>
> >>> Correct the condition.
> >>>
> >>> Signed-off-by: Simon Glass <sjg@chromium.org>
> >>> ---
> >>>
> >>>   include/k210/pll.h | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/k210/pll.h b/include/k210/pll.h
> >>> index fd16a89cb203..6dd60b2eb4fc 100644
> >>> --- a/include/k210/pll.h
> >>> +++ b/include/k210/pll.h
> >>> @@ -13,7 +13,7 @@ struct k210_pll_config {
> >>>        u8 od;
> >>>   };
> >>>
> >>> -#ifdef CONFIG_UNIT_TEST
> >>> +#ifdef CONFIG_SANDBOX
> >>>   TEST_STATIC int k210_pll_calc_config(u32 rate, u32 rate_in,
> >>>                                     struct k210_pll_config *best);
> >>>   #ifndef nop
> >>
> >> Tegra? Do you mean sifive?  That's where CLK_K210 stuff is... but it
> >
> > Oh yes, I got confused.
> >
> >> also seems wrong, you can run unit test on real hardware, and this is a
> >> test that could (should?) be run on that platform.
> >
> > Only if it enables UNIT_TEST. You cannot run unit tests without that.
> > The current tests are designed for sandbox.
>
> FWIW I have run this test on actual hardware. My intent here was to allow
> unit tests to access functions which would otherwise be declared static.

Er, with or without UNIT_TEST enabled? How can it even build if this
declaration is only for sandbox?

Regards,
Simon

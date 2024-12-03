Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB05E74AC8
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:45:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F234D89185;
	Tue,  3 Dec 2024 20:45:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BpY5N4R+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13A0E89662; Tue,  3 Dec 2024 20:45:28 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 839A888BFB
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2eeb2e749c5so2341305a91.0
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733255124; x=1733859924; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0laa+w5FqCgOb+WgLMS9tWeCcF23wUyTWYuzYEJUvYk=;
 b=BpY5N4R+uLgzG+Cv+c8boh+7QeoGXQYYbqVBV6saPir1XWHSm8Ty/DoapPtLSeYeRk
 8xtcxd/Xd5iyZ3K1fSy4NA5sCgNXuipUrutzRLvOT+ACktsEI6Jf9N2wdeOzqvOZfhyy
 RUURuj06Ij2TlqhJ106sXLBR091GUTb+iMA5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733255124; x=1733859924;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0laa+w5FqCgOb+WgLMS9tWeCcF23wUyTWYuzYEJUvYk=;
 b=ROyfJzyRChnnNHUCD0oM+dtIYV+XGtVD8458CCNLUgNNtopYJLLbXr+BOE2UX1rC0W
 36PfF/LDYmuvcS1Pr4zdByW1q7oDn7kcd5zQMXP4muruIWJ5I4ERjESvv8Y9Rd8taumv
 TS0TSC/xKAiPJ1weBczIjkSAFeLCCyChRcJlD5pW+I35pageMRtA4j6qmiLlaZIuj6b8
 zfT4viww1lGPDzdzBHIVyF3WgDTf5gGtYUInH0DqYR6ygjKGioEtir4Sl5iWBwkACpx3
 uhJ+/xEMmvf7bf6kQsY4gfzhPTrstPkqHQNvKuKQH6IICUCi6OrHzPuY6QazahvZusHC
 IH8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOXFgZXYq9lxNIJIqEtlgzXTF7Y7sAsGuROY/2lATBBQOxeMA8FEXaLZwMFUWi/46nAWdvrl8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz415RRX22eDV3tMvPfyk1BggtbQljidRJY/wvnqz3WPBtWH52d
 t7+ahQbwG9T2TsGOCHX++PIpfxde/TWMjw//ucCVNYmKFOhihMseuHc2DJsc2Yipcmqd8ySuuxI
 NmP43bNV4mPvVYVZroO/1ktCzTjmzxTqspOOp8TQgw2Yk4mY=
X-Gm-Gg: ASbGncvpd19msT08/qXEeDtaVyOGRP0hJ5S/Xl8o/av7eLGRms+OP2wwosApZweXoZp
 oLT8ho/ZPsjIu/m4f5XHs3qqF6QDKkxSX
X-Google-Smtp-Source: AGHT+IHpH2etjdocedtDpBNsoxSNgaqGUCccdzJ95O6Dl5u29JE0MnhesNUA7gt550tsRwaEa130jCN1kSzAVixhB9k=
X-Received: by 2002:a17:90b:3a85:b0:2ee:d024:e4fc with SMTP id
 98e67ed59e1d1-2ef012748a3mr5708655a91.33.1733255124098; Tue, 03 Dec 2024
 11:45:24 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-5-sjg@chromium.org>
 <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
 <20241202162239.GE2457179@bill-the-cat>
 <CAFLszTjvnyE4vFQ=Z=Ma1bOjH_Z4JEdUWM51Vc_nRmSUkRzF4Q@mail.gmail.com>
 <20241203005541.GP2457179@bill-the-cat>
 <CAFLszTi6koMMr0ggVLxKQK5LCBv+hCunewacBxDAZYH+rERGiw@mail.gmail.com>
 <20241203140133.GT2457179@bill-the-cat>
 <CAFLszThLAYQfMxE_fVuTYX57vNBfi0PyvBzuUGCw0_1EsXk7ag@mail.gmail.com>
 <20241203160131.GW2457179@bill-the-cat>
 <CAFLszTgx6BacGQyiMOoCzYDM3vsOBgfr2XbzBEsNOZ_Gzj3=ig@mail.gmail.com>
 <20241203165132.GY2457179@bill-the-cat>
In-Reply-To: <20241203165132.GY2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 12:45:02 -0700
Message-ID: <CAFLszTiEk64zKzVEK06diR8=expsWWqxjV_Jx8FQ+RwpiSBjsg@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
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

On Tue, 3 Dec 2024 at 09:51, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Dec 03, 2024 at 09:37:34AM -0700, Simon Glass wrote:
>
> > Hi Tom,
> >
> > If you like, you can apply the reverts first, since they break boards.
> > That should not be controversial, particularly as I explained at the
> > time that this was likely to cause problems.
> >
> > Then you can leave the discussion on OF_BLOBLIST open.
> >
> > Just a thought.
>
> Absolutely not. Again, 70fe23859437ffe4efe0793423937d8b78ebf9d6 says:
> "Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>
> Tests for this will be added as part of the Universal Payload work."
>
> And your new patch says exactly the same thing, but then:
> "Note: This is the correct way to deal with bloblist, since it allows
> boards to choose whether they want to use the devicetree from there, or
> not." and a large number of patchwork links. And after squashing the
> three commits together to see what's being changed, yes, you're
> rewriting a whole bunch of the logic without any explanation of why. It
> seems to fix 3 Chromebooks and isn't tested on anything else. This is
> why I'm saying it's unreviewable.
>
> So no, at the moment I'm inclined to wait for further reports of
> problems, and we're coming up on a year since 70fe23859437 was merged,
> before making any sort of last-minute change here.

OK, thanks for confirming that.

Regards,
Simon

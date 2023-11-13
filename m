Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7CFC4332F
	for <u-boot@archiver.kernel.org>; Mon, 13 Nov 2023 16:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83E65869CA;
	Mon, 13 Nov 2023 17:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b27cWWz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFF5D86F40; Mon, 13 Nov 2023 17:52:36 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD4786758
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 17:52:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so6201635e87.0
 for <u-boot@lists.denx.de>; Mon, 13 Nov 2023 08:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699894354; x=1700499154; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FO7HxkfWntPIfNXx1McYRLEaKU+05vDdgoZmgwipHyA=;
 b=b27cWWz0TeQb5LZt2rbM1y/KfPtP6FmTIemijoEqnkLYWE5clWBWCG1F118GkSQGSO
 CQiuIENJFkzSEkv1NEUHM1+RzPw+qC0eo+SMsCoo7kPaE9w9tHi4jgmgQrlShhSVkiaW
 fyyz6Vu/34lhi88Lqih8Cmx07bonWjBfCr7QIpV31vXt8WjkZ9Fb9aSQbGdG8VTFKGoI
 6eVISlnr+ZdHpCqrsP0IxF1Iaz6XfDKBPw/+4SCKMba226VNHqB1pP+0NNUMvE1ZuEbF
 XAU8US5kLeDQSJ6a34npUzxUIJGRWJQ1Pw9hZPjyqKnUQszyqrcgeVUyUUw1Y23+fAFm
 wRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699894354; x=1700499154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FO7HxkfWntPIfNXx1McYRLEaKU+05vDdgoZmgwipHyA=;
 b=xUT+3ReMOhT75sMWF7BLW4hDUj2JUD8DDq/SJEtA3jZ9E17/XSC3vnZlslRKdh39Xf
 h9CdV0FXqqqV1RrpoI+Kj6N4iISZyuYPoHwEbnPpYDdbDpQCJEeG05UD/JGIleE+Dm49
 Vs0ZtZ8YgTsyZCg0VVILlBoH+WmvL3gTWeYsM6w4T1+IALmYCMSOvHiyl6h0LT+B12xr
 gUJmrdjceF1toVbgBwfbhhY/Ca6uvoAXx43s6eG+WbAzqKC+tQ3TnC8VX9mqmOBUUAAO
 SnrMpQ98zFrOtb1f/ZfQzAyCKYDrxNesuPFVsXW1cJvfb/tTQDmmBtHPGkxVvJ+hut3Q
 WZBQ==
X-Gm-Message-State: AOJu0YzV5xyiX9VDq0HyVwIrACl91u75ie4wFu3JckUFVh990OO/gtST
 TdoECd0NvBQuRBzk5LKMnBvKTKlg+afOao4J5Xw=
X-Google-Smtp-Source: AGHT+IEkl+p++J8DQZBSplkloYGpasvCRGRZWdLv6ZZhYdUYwaIrJJVT2L/xOAFRVlj90BLooFEGWJCcSo+h/VXLZvw=
X-Received: by 2002:a05:6512:3d02:b0:509:31e6:1de5 with SMTP id
 d2-20020a0565123d0200b0050931e61de5mr6462374lfv.47.1699894353755; Mon, 13 Nov
 2023 08:52:33 -0800 (PST)
MIME-Version: 1.0
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
In-Reply-To: <20231106210407.GK496310@bill-the-cat>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 13 Nov 2023 16:52:22 +0000
Message-ID: <CALeDE9N=Sd0KzvajD3_hd782hAdKTn30esYcMYv5DoDsrW9+Vw@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
To: Tom Rini <trini@konsulko.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 u-boot@lists.denx.de
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

> > > > > > > Since the proposed PMIC patches have been accepted, I see the need
> > > > > > > to convert boards which I maintain to use DM drivers instead of board hacks.
> > > > > > >
> > > > > > > Svyatoslav Ryhel (5):
> > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM PMIC
> > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > > > >
> > > > > > Is there a reason why the two above devices don't appear to have their
> > > > > > .dts files in the upstream kernel?
> > > > > >
> > > > >
> > > > > Yes, there is a reason. Linux maintainers treat submitters as
> > > > > existential enemies or as dirt at least. I was trying to work with
> > > > > linux but I have no desire to spend any time to upstream endeavoru or
> > > > > lg_x3.
> > > >
> > > > The usual policy for acceptance into U-Boot is to have upstream review
> > > > in the kernel first.
> > > >
> > >
> > > May you point to a policy which clearly and explicitly states this as
> > > a mandatory condition?
> >
> > There have been a number of devices rejected in the past until their
> > DT are upstream but I'll leave Tom, who I've explicitly added on cc:,
> > to clarify the exact policy.
>
> Well, here is where it's tricky. I brought this up for one of the
> Broadcom MIPS platforms a week or two back, and Linus Walleij's point
> (and I'm paraphrasing) is there's not really an upstream for it to go.
>
> What we cannot have is device tree bindings[1] that aren't upstream or
> worse yet conflict with the official bindings.
>
> So the general way to resolve that is have device tree file be drop-in
> from the linux kernel, and what additions we must have be done via
> -u-boot.dtsi files. And in turn, some SoCs are better about keeping in
> sync with the kernel than other SoCs are.
>
> Now, upstream being actively hostile to dts files, especially for older
> platforms? That's unfortunate. So long as we aren't violating the rules
> about bindings, the intention is that we don't have device trees that
> are either (a) massively out of sync with the kernel[2] or (b) kept
> intentionally mismatched from the kernel.

I don't believe I've seen upstream Tegra maintainers being actively
hostile towards updates for older devices, I know they have certainly
defocused them, but I'm not sure that's what I'd consider hostile.

> [1]: There are both examples like binman that Simon is working on at
> least but this is more exception than intentional rule.
> [2]: Per our other conversions, I know the tegra ones are in this
> unfortunate state in general

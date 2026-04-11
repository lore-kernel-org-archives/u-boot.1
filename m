Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE35F3ED4C
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:03:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D26B284154;
	Sat, 11 Apr 2026 15:03:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RCgXho3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D338416F; Sat, 11 Apr 2026 15:03:50 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FDA084118
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:03:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b9b1df1a6b3so340235366b.0
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775912627; cv=none;
 d=google.com; s=arc-20240605;
 b=SwBbN3Z14Pz8I1oUUA0FoFBmZE2sxrFgnu3FztLV0qH14rzpjk4NWw0QLwKaCKeqF5
 x/vHWlO4D9sKtaG/VbbLoMAA0zuLjShpMk8UbOV80KwLXW+UjoGXi4jlCSUIE4EYevKh
 BijcGsirkG/xwhpQmiO883L2lAcSWrIH4UxTa87tYvMqhAo9ltc6O/1oQ1IWhf+qXTf6
 gbH9XhY83mXQJe35icdD5gkL2yFY3z94CWJ5l9/sr3S9fljnZ9XKweqQ8O+s7OXisrV/
 sPEnrhvBqwWWOtnyuPltMBwEdYPETbxxIFrL5UJuBPJ9c3/w47s7ytmf0paQCgtGlwgc
 OtoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TFXpsTNl2ZcRbM7yL9zc52LpMTmvacAv9LKocCeM4Qs=;
 fh=GA4qErqYl7KG2lEuOyu3WtbTdOjHCRexHqdv3eCP390=;
 b=MtFGWvnNxLxNjSyuebMvYc+gyIEy00pKSka188vV9khWoNbbaJktmqUg4eQHfvLRr4
 GiKWNy8DKmD1MsEMPcy9hC4v3/0Yp09Zl6G+Oo9/8FGX9Xp/EkzgmM5uaP22w+y+RaDE
 +rgxGnganTZLYUvBevU1/5d7UmgtsDw4p04HW0lxr6y1tzqNGacVb9Ubm2bkHIUSOM/f
 tlxK7Y9CQRNZ9XnZJrunSAxC0mGmrb2RHE8XniO6q7FIA5oi46ZXhakEWRfPzLXrgl5Z
 CgswuxSCj6oQhPlg3Nm1JcYep/wabTGEHU13nbH+UrVBC0z1+D1ZW9bwhS02U20QhsPE
 z6tQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775912627; x=1776517427; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TFXpsTNl2ZcRbM7yL9zc52LpMTmvacAv9LKocCeM4Qs=;
 b=RCgXho3Mn+VITqATjqnYT+uigtss2e81wdHKMY5oFNbf3tLpODh8K9X/5mgzST+qPg
 zh5inQTafDkdaeUMVJlgQEdKvVFoqUVF/rhq0WDVRyJyuIKyuQ8KNE7w7a9PPgviCtlQ
 0RBDnzrfPO+3o+XIFujNKSnelFwmfeNAjZTvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775912627; x=1776517427;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TFXpsTNl2ZcRbM7yL9zc52LpMTmvacAv9LKocCeM4Qs=;
 b=PiINCJPeHdjNstCxd28LJAKNOLJdiD2qABU8NRtOHYgUfQxzvOaGyzqJePbuFGIycn
 i+GpFEmCGsXQwXSx4ungwfDivqNEa3pXHsop6FOBomlWIDw+T1SHx4b08sYr3ABjLy+W
 nXfeGUn/8/QSwKjlRK98bR3Vz7jqrqUoGgwhimQtcWFwdvrOqPchSMG6XLg+rMGxNPLR
 f/3Q5SfWTCq04ZUflO7i7+1zwqgoWpvR9+aEAAiZElJEP/PtQ+qmiFFIbyIDhccMNwtq
 BPVVO8wr+l1qCFhyzEn9KzbiQHEU/+9ukGfupYUt905Y4OveZxKThx8tTy9TetSpEN9O
 97/g==
X-Gm-Message-State: AOJu0YzAJCAbFIX3df2bOdRtEEBFfWFsEnv5ATbRk3d4KYRp6ksa3KUT
 2iAbM80IPFdc0pgbJGVwhTeccHX3L8UhjusOactDSA/k017SIaYN71KAB0/oUPoqPDWS/QtLBi/
 YUcBcFMEkUioDF2Qe2gGD0ngiwcD9PgwU6AWdX+p6
X-Gm-Gg: AeBDiesDrkf5O4lDhJpNkdinOFaplTJy7tqoYTLXfIgmGCSfaWrBLEr7LIQDExAI7+/
 NvNai1+F2hVW8+CG3Zc6m5l0Vs88SgG1Tmuw3/GPy+NKpOqXwkadAXEMnrjF0ideHkreQXP6UFV
 kz/vtskDc8xzZMt1p4RCEAyOhpZaY+pCT+uDpTpx/cayFhml3A8dF66kkL5v/hD5nP1alHVVSBM
 /vSFU+6bWvABJ8VcsAAeJ09vZ5DfrBENt9w7HTtyHG7zZIB9+WnOZuDvPePod0Q48iyuG3Mi7NI
 TGTnfQ==
X-Received: by 2002:a17:907:788:b0:b9d:68ae:9461 with SMTP id
 a640c23a62f3a-b9d72969021mr397068966b.29.1775912627413; Sat, 11 Apr 2026
 06:03:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-2-sjg@chromium.org>
 <20260408162543.GD41863@bill-the-cat>
In-Reply-To: <20260408162543.GD41863@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:03:35 -0600
X-Gm-Features: AQROBzAvhx2kx1a8FnKvnKq-kEigU1vfi6p1qciRQrTln2BvvxG8I-rhPidbkAE
Message-ID: <CAFLszTjKBrUu9zFHyHXmSUMCrZjLB05ri9jdSaaTBOuJndKE0g@mail.gmail.com>
Subject: Re: [PATCH 01/13] boot: Split out the first part of fit_image_load()
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Wed, 8 Apr 2026 at 10:25, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 25, 2026 at 10:54:10AM -0600, Simon Glass wrote:
>
> > This function is over 250 lines long. Split out the image-selection
> > part into a new select_image() function which handles format checking,
> > configuration selection and image-node lookup.
> >
> > Take care to only call fit_get_name() when a valid node is found, since
> > libfdt does not handle negative offsets gracefully.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Function length isn't a problem in and of itself, especially when we
> aren't pulling out some 4 or 5 level deep nested logic to improve
> readability.

In my view the current code is very hard to maintain and change. I
know this because I have tried to do it:

1. By my count, fit_image_load() declares 20 locals. Even without deep
nesting, tracking which variables are live at which point in a
function of ~270 lines is extremely hard (see [1] for someone else
that had this problem). Just to take one example, pulling
select_image() out makes it explicit that cfg_noffset (for example) is
only relevant during image selection and doesn't leak into the
load/decompress path.

2. The function has distinct phases: format checking, configuration
selection, hash verification, and image-node lookup. So we have 'find
what to load' vs. 'load it'. These  are much easier to understand with
clean function boundaries, rather than an arbitrary split at a line
count.

3. Reviewability - when someone adds a feature to the loading path,
they currently have to read past 90 lines of selection logic to find
where their change fits. Smaller functions with clear contracts make
it easier to see where new code belongs.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com/

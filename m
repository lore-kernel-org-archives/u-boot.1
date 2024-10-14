Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AFFD1813D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 19:13:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62F6889117;
	Mon, 14 Oct 2024 21:13:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iWM8w+Np";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CACCC890F2; Mon, 14 Oct 2024 21:13:36 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D9C68907F
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 21:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6cbce8d830dso36398486d6.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728933213; x=1729538013; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8joM4eYLyLloLN7WXhRMSXHFglEnIer2wMvJ5DvhvE=;
 b=iWM8w+NpSY1Ugy5FkEfjIFIPX/gGLOcuNCHi+eEYra6kz2hxsW2S89mb5pfFGbvrsP
 b2mtrEKytJrV9xKV4Ytb1x2hCj4MMqgmDoPJCWJqK0hCbeVG85VUI6iKkJN3nny2UR9u
 Zj9pZeFDYJjK2brbPV7Gw7qon22GMAiCJ9Msg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728933213; x=1729538013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q8joM4eYLyLloLN7WXhRMSXHFglEnIer2wMvJ5DvhvE=;
 b=kpaTNpkjqWaqE/Ebu/sh9+drIokFSpPWhaMSjaBhMJ3BtVHkgtKS72cvv8zCzS8m7j
 4AdJkofsQ7bQo+dXV9QlPAa9r5mgnHhxB9rkkCabXBzwJDmFDOwmNVgFInyxlncjRd4n
 mkkQQGK4tLTmsvDWpXhO2Uq5nqct6KfCFgo6lCg19R1B8Rdc6nglG7MzWr17jnVhAO9h
 W61YymAaF7IOxc+hOp4qFJ5/iNNuBBCHU0q/DIYTQpCbYeVVeimIHu6tJqwQZM6L1Ofc
 TLTfN3p0JH0PmDdREUox288V/7hCQ9n6JK5rIgBG8WNb9Iu7w3IAqHtX+87AWD9KJclr
 D9ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqYrddd4NNdiDGLGlrBTqW9ZpCv7DG1jPbKYXGUVz1EAlAeI/isM7A6EzV/ta8AmXueZAHVXo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxe+358NuJpVPtDDks9DPCMZEfQsR9xH8XLnDAbjc19wZdgnWcw
 2eC5RypGbXDdMlrcM03fDqpAbUiQ85WahPMCqCC8wcklA7GHjqHk9Xnsq4Do2kEyPm07+7iainH
 J8dqbbIR76tkPFDU20p2xnh40rL2RExuBcuVJ+Eh/OYvp4Z4=
X-Google-Smtp-Source: AGHT+IFdROY67UfrzvKGqF+ZgDw0vOXlzRq9fS1Gt6GanmhicK+WjTHybYCR491bGLzL+FupW7r8fdWy1bKD/xDneGk=
X-Received: by 2002:a05:6214:53c1:b0:6cc:18b3:c66f with SMTP id
 6a1803df08f44-6cc18b3c7e6mr38913316d6.5.1728933213380; Mon, 14 Oct 2024
 12:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAP22eLHhOnBXh-E5BDxLN06T6W1EsdUq4x4hfB9+rC4pDiMwwg@mail.gmail.com>
 <79fd246b-f5d3-4d6b-b8cb-d109dd135988@seco.com>
In-Reply-To: <79fd246b-f5d3-4d6b-b8cb-d109dd135988@seco.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 13:13:22 -0600
Message-ID: <CAFLszThNJb2zwRW6c0FfhtrqmCPm3OvSapnQRPT=pSMXCjSrfA@mail.gmail.com>
Subject: Re: FIT signature security flay
To: Sean Anderson <sean.anderson@seco.com>
Cc: "Lev R. Oshvang" <levonshe@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Mon, 14 Oct 2024 at 08:24, Sean Anderson <sean.anderson@seco.com> wrote:
>
> Hi Lev,
>
> On 10/14/24 04:42, Lev R. Oshvang wrote:
> > Hi Sean,
> >
> > I am looking for help with Uboot FIT  signatures problem
> >
> >
> >
> > I  started to work with FIT image (u-boot 2024)  and managed to sign
> > kernel and load this image with Uboot using 'required' property in
> > signature as  :
> >
> > signature-1 {
> >
> >                                 algo = "sha1,rsa2048";
> >
> >                                 key-name-hint = "dev_key";
> >
> >                                 sign-images="kernel";
> >
> >                                 required="conf";
> >
> >                          {
> >
> > Iminfo reports"
> >
> > ## Checking hash(es) for FIT Image at 01000000 ...
> >
> >    Hash(es) for Image 0 (kernel-1): sha256+ sha256,rsa2048:dev_key-
> >
> >
> >
> > To test the procedure, I generated another private key and signed
> > another kernel with this new key on another Linux host.
> >
> >
> >
> >
> >
> > I expected bootm to fail, but it just happily loads this image!!!
> >
> > Even an image without a signature but with a valid hash is not
> > rejected against my expectations.
> >
> > In this case iminfo report only hash is OK
>
> Did you embed the public key into your U-Boot devicetree with `mkimage -K` ?

Also see the walkthrough at [1] which might help.

The 'required' field needs to be in the public-key information (i.e.
protected and separate from the image being loaded), not the signature
node, since anyone can change the signature node.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/usage/fit/beaglebone_vboot.html

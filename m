Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE02C369B2
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 16:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 143A382B26;
	Thu, 17 Apr 2025 18:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kitfoGjA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72CCC82B33; Thu, 17 Apr 2025 18:27:14 +0200 (CEST)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com
 [IPv6:2607:f8b0:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE9B82AAE
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 18:27:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso892282b3a.1
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 09:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744907230; x=1745512030; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I4jK8ABbnYsQgYzq2p2ihtjuHNbPOcfx5GSKW/xiSvY=;
 b=kitfoGjAcNdyaBUJt368rPVzlZs+o1VJ+Vy5PUuT5pfEOkIIrF3IZ4R/DIvZjvSlVc
 4bdoVVKsSzaLhbXJrjBImOGL7A539urtuymHtPcD7FOtk2cyQsvYBBHt86VPaZqk333p
 jnSea4m7DRFzYiaqN+GlI8MUn0VgDDg31Ac4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744907230; x=1745512030;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I4jK8ABbnYsQgYzq2p2ihtjuHNbPOcfx5GSKW/xiSvY=;
 b=aPNXT6dO4ZcWr6lMWuatdkYdZWcE3q1YENSGfB+F0LtK2ychD8xNV74UAHjhLcYFpL
 bz3EkH1q8yfn3BZfsLwLd2FPDASv8MPwqWpT3ghBI7ekoN+3avSzc6XVX9CTvGwg/Cfz
 eAlkFIaShrUsWqCDbyA1q3NrR803MFFLWwvBmZyKeRIZLD2JqZQDoHE5Dv2x7Z19/e7c
 MPnxTRd8zznw4psS717Ibj93WtkTbfBlxXXTXgJ5leflSHg2vBWEJpBtr/j56WCowTWZ
 qV1YfnGkEFyaiOoSpJv4YO2oXMwsu6QQ8BvRfWXNdw28YONbvPT7zMltLCQbdamWm4if
 Cq9g==
X-Gm-Message-State: AOJu0YwPHE1+F4GqHeqsbvm8rE57DkbJp7jWBHlhU9tr82ITfkoSiiKa
 y9lxAAZKwtU+qL9YAPqxyQoXvnAVCRaxfhLRwhbOLiigBEd73opdbHir8Iz4v9h3tzgT3Qqlv92
 40ShzANX5graqdoJfHvNv1OiKaa8dxw65REww
X-Gm-Gg: ASbGncsYJeEdmHJUzYBctX6u18riSmpAqV5p97Obco7CgAjs2ifpO5zH+mnmpIoEIRI
 8QGVtSRx4zO/VNb5WBNT+NLv+EHgBnyMsuegOozrGpusQYFO/imPL2M5JE+owW8mzBezKeKU7se
 R33ZBEEoK6C/5Mm0PMpp8KCa8=
X-Google-Smtp-Source: AGHT+IHah1yWJrZojKMk5207l8pot5L9w9fwkK098SgPhg+Gqn7MzKqhz76uIcwE2tONvZYcHdJcRz6/sSnRRNhkyt4=
X-Received: by 2002:a05:6a00:148e:b0:732:5875:eb95 with SMTP id
 d2e1a72fcca58-73dbe5201ddmr684353b3a.4.1744907230248; Thu, 17 Apr 2025
 09:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250101195817.995321-1-sjg@chromium.org>
 <CAFLszTj_JvCRNQw716CGD=i+eJm1YMb=WjOqpF0VFFiac3GmCg@mail.gmail.com>
 <20250417160423.GX5495@bill-the-cat>
In-Reply-To: <20250417160423.GX5495@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 17 Apr 2025 10:26:53 -0600
X-Gm-Features: ATxdqUFngNoA9RABur4WVPZh7c60TF88QNYAwjYfBR8_JPOeoPEOQBkyrO2Xa5w
Message-ID: <CAFLszTgWUNP6L6ZML639wz76CuuBoPDt447vjfz8MRZyLE5gFw@mail.gmail.com>
Subject: Re: [PATCH] bloblist: Drop BSD license
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Levi Yun <yeoreum.yun@arm.com>, Patrick Rudolph <patrick.rudolph@9elements.com>,
 Raymond Mao <raymond.mao@linaro.org>
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

On Thu, 17 Apr 2025 at 10:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Apr 17, 2025 at 09:58:42AM -0600, Simon Glass wrote:
> > On Wed, 1 Jan 2025 at 12:58, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Linaro has decided to write their own version of bloblist from scratch,
> > > so there is no point in having a non-GPL license on this file. Change
> > > it, to better fit with the U-Boot project.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > Link: https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/22215
> > >
> > > ---
> > >
> > >  common/bloblist.c  | 2 +-
> > >  include/bloblist.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > Applied to sjg/master, thanks!
> >
> > (Tom, this one seemed to get dropped but I'm not sure why)
>
> Because AFAICT you legally cannot unilaterally change the license as
> others have changed the code.

OK, let's put this on the list of things to discuss.

Regards,
Simon

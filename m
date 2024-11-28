Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EA7D70DEB
	for <u-boot@archiver.kernel.org>; Thu, 28 Nov 2024 19:11:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A2D89D06;
	Thu, 28 Nov 2024 20:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Njo2G2P8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF0389D15; Thu, 28 Nov 2024 20:11:24 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41FE389D0D
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 20:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa520699becso162784466b.1
 for <u-boot@lists.denx.de>; Thu, 28 Nov 2024 11:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732821082; x=1733425882; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P6B+V9ycX+LGTugw/meVc+YQ8b0P6v48vVUOHWK8bik=;
 b=Njo2G2P8eBMyBDhLMGB6tQAXjKpHPa/0Yi6yOnmxowvwvKzYj+KHR0sRny9HqL81fe
 txNKK6jHASQgzPnhey4haVqf01IYXiKiuTr2A7xHgpY5JEq7iBLIpgFvq66Z2K3jYNvM
 nXU5YSUsBLNtYF3daZLZLN33eH8dTPKvgLLmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732821082; x=1733425882;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P6B+V9ycX+LGTugw/meVc+YQ8b0P6v48vVUOHWK8bik=;
 b=IAqFWNUbAF1x2/91UeWZbFNs9vFI8M+bwtFolU3eftLL8HHQkKZKVwLGDu9YCY9Kg5
 7kTZ+iOpgkTive5+u0IeyBi/Saj9+E0SlGlTZblHhtFFi37pZsGlLfan+pHa4bD1/cGP
 DMP3kOACRGxsOOy0eq3AwqGj006S23rul2nkjCv335cgi5eCQfhycbGDSi/8idfMujol
 LYOM/zjb/ePJBT0G1asr9uTeBaUYSkPxpD4/nIioxzxRW3uzpfBnP2cG6ZlJ47x0JHKq
 Ozfqg/hBM6i8MNRZDyRuhUWp98z7GrhrYCCNv6faTJSDLF5Or05PpJB53XUNWJaw78iR
 ucPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtCSSLHZOz77qBDV7A/L+1Ql231dTBY4oeafSUrxvH2+y5n+yeUEUoYYcVxivXYjIbOMj/JiE=@lists.denx.de
X-Gm-Message-State: AOJu0Yydgc34rDFDmXbT4HSQHFTdxyY/13FVI6h7UgWIJsEVQAEKSksm
 WcATarwdVnNhXmigriWVFvwz1lcUy5A6l2rbG7W1+SQrizrnWcZhp8biAbAKIO+KhqjI5xuwbHH
 5IPX8qoF80hDMHXrhWAdAt6b47PEmp2rZ6WCN
X-Gm-Gg: ASbGnctzCnXghz/izAfyqpLKRUJTOxf1feltR9Y0M2GKuTPMCxFs/uc7PCL9PP7aFz1
 7Oh7iC6KtwgzUnpijGkgc2BvEjrp0hP4=
X-Google-Smtp-Source: AGHT+IGEnCZlJT1XReoDiAuJCF1W6+nfH9ZKBpVpcSgPxSECb9U1yKBodEk7Ku5wfClP27MRn8Ze4aeZsep37KVrIV0=
X-Received: by 2002:a17:907:7703:b0:aa5:39d0:845a with SMTP id
 a640c23a62f3a-aa580f01be6mr690463966b.15.1732821081771; Thu, 28 Nov 2024
 11:11:21 -0800 (PST)
MIME-Version: 1.0
References: <20241128154727.771871-1-sjg@chromium.org>
 <20241128154727.771871-11-sjg@chromium.org>
 <dec42d99-6eb4-4272-bf9a-79ecff3bde47@gmx.de>
In-Reply-To: <dec42d99-6eb4-4272-bf9a-79ecff3bde47@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Nov 2024 12:11:07 -0700
Message-ID: <CAFLszTh-FYi7AQG-8GX7Uibyubtjg-6Txo7XkiNUREW_cTpPcQ@mail.gmail.com>
Subject: Re: [PATCH v2 10/28] efi_loader: Use a separate struct for memory
 nodes
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Heinrich,

On Thu, 28 Nov 2024 at 10:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 28.11.24 16:47, Simon Glass wrote:
> > At present efi_memory uses struct efi_mem_desc for each node of its
> > memory list. This is convenient but is not ideal, since:
> >
> > - it means that the fields are under a 'desc' sub-structure
> > - it includes an unused 'reserved' field
> > - it includes virtual_start which is confusing as it is always the same
> >    as physical_start
> > - we must use u64 to store pointers, since that is how they are returned
> >    by calls to efi_get_memory_map()
> >
> > As a first step to tidying this up, create a new, private struct to hold
> > these fields.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>
> The EFI memory map should be generated from LMB.

I sort-of agree with that, although it needs to be augmented with
images too. But that will take 2-3 more series to get to.

>
> We should not waste our time on code which shall be removed and possibly
> introduce regressions in the meantime.

I consider it a valuable use of my time, as unfortunately the LMB
stuff is going in the wrong direction, as will become apparent in the
years ahead.

Regards,
Simon

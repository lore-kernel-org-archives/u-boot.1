Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C408FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 16:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBFE684109;
	Sat, 25 Apr 2026 18:17:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rwsv9Qcj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B79184099; Sat, 25 Apr 2026 18:17:24 +0200 (CEST)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A268840D8
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 18:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82d0b68837aso5504352b3a.2
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777133841; x=1777738641; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/w6ej0Lu+5SpaF/DGh5gzEOi01LjHD2LA06gqI8v/HQ=;
 b=rwsv9QcjjY04ivvKU+IWbs8IJ4EL4sU/dPGVG4F4s4eu7gG4j1e4VvuDEK1sLJ2wKU
 nqEQ3VKH8DO389ieZdamXP97C5SyDvdeLGD2OtUgkb9oW1UGUgBOOqATVwyYusc5Azve
 jlorHHTcqQGRASw9MzkemR14xFP7ecvpaEvlgVBss6p6QQysrLabsQkmGJwfo5aMn3bl
 ovMqvrYRWmXTFzlE6HFetW/Xw2dTwez6lXyFMbwPqT2dyPgRV9dViNzsjC3+TPgdxvwN
 JWBPqbLTqYnpkO2IVLFql6lVU0V1UUcD5rEF4UEQ4QqsVnTos7WYWhHNaHXNLaAe+0ko
 G9nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777133841; x=1777738641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/w6ej0Lu+5SpaF/DGh5gzEOi01LjHD2LA06gqI8v/HQ=;
 b=kWUkodNaVKbZAJZaQQV1i0V/sgrPELwstiRGE/4vGoL+pYr69VLIiRpmr8b0d0cZN7
 xuxJvg5TClLc5wfFcM7Ap+m7aW5/Wd12UcrK9Ndc2ZfjZ36UbrIsgg1IUHt1Ypw0yxci
 5gtLghYPFrAL3sL1BVsxisDnn6Ni4DXfank7p0Mr3RMDkx7I+3jGtSwMvn+hDtavvZBM
 azDI1kOm/yhbIarBKCorWpDYlfW8z0L+TJ3UFM3mW27xVgL+c01sFVvfarIJ+tii1wBC
 3da43vDWV5BMqX7fU5GrX07Yj13n0WBkiGKKV/i3wPq1xfF0KNQwqkHfRJxU3TVHasju
 mfgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ofDF1tY81x76QFUW9iiych2BhOlq27bYXRL7wgvg3FzSuMqBBBR/z38lXQWXiGzwRKEO0qrQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxqI2a6pyLWHCufnhQdILEq8B7UlXclF19nmFPeGBwGHsRtKZvf
 LMlSE9Zfk44I/peWRcWhEmfKVw1giXgpU+woelT3VRSrgovL1kaujtNY
X-Gm-Gg: AeBDiesy8PanvNDN2f5zZ1byKRIIFlYLUVwgz1Qr3p4dkXYlESJL/vypUlFRKS34H4n
 3jXQ6DMTvDa0xyWeyzV2bZIAhKfZ9QrSRmDbJLlZBuyEHHezHiqizxjbIe4DHiftIUh5pDNFgHW
 DC7bM37PPK65JooExD6Sp1l1FzDLwCyzQw4jJBRGV0GwKrnz/XqDSZt26hxK9hK7zJfEqss4gn6
 7SMx6D/Yq7Ojk1mxRqX7KZoPxJQcf3M00+2v+EnPRx7j6PChzrwWtnYllqTYDhbcGS9YW/d5AtB
 0CE/HpWue76CEgZV5jqXeJCgZgCAHEbQQxC+x7XobYdmElMukulIoV1vo4y6NgVqAVmlhC1S5hr
 +9hYHIgvDd7Va8/heF8/xC2RJp/FUKlNgoGLsru9+FeYA9Y7sJgJZt/djZH7ZHkib1xMO1Dm08s
 lRF7JyEzDgGLFkLgPsVX0sa2JU2xzv6Lk5+d+dwwVzx6Jkdak7rCZBDaNc7/8VoCclByHwuQ36C
 1NceK9Y2cFhNw==
X-Received: by 2002:a05:6a00:4c86:b0:829:8c08:d1f4 with SMTP id
 d2e1a72fcca58-82f8c90bba5mr39841012b3a.39.1777133840696; 
 Sat, 25 Apr 2026 09:17:20 -0700 (PDT)
Received: from google.com (61-230-36-6.dynamic-ip.hinet.net. [61.230.36.6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebe901csm33499880b3a.48.2026.04.25.09.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 09:17:20 -0700 (PDT)
Date: Sun, 26 Apr 2026 00:17:17 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@thingy.jp>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de
Subject: Re: [PATCH v5 0/8] Add virtio-mmio support to m68k virt machine
Message-ID: <aezpDb2CQdSH510z@google.com>
References: <20260416093927.602613-1-daniel@thingy.jp>
 <CAFr9PXnPnQhdn7-PwHM2E6pT3o4uuCXJqb8AkZ1mHQ_Ovgneqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXnPnQhdn7-PwHM2E6pT3o4uuCXJqb8AkZ1mHQ_Ovgneqw@mail.gmail.com>
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

Hi Daniel,

On Sun, Apr 19, 2026 at 10:33:09AM +0900, Daniel Palmer wrote:
> Hi all, but I think mainly Kuan-Wei
> 
> On Thu, 16 Apr 2026 at 18:39, Daniel Palmer <daniel@thingy.jp> wrote:
> >
> > Lets start making the m68k virt machine support useful.
> >
> 
> I now also have everything else needed to get linux to boot
> (relocation support for u-boot, passing the bootinfo onto linux and so
> on).
> I'll send a series after this gets merged. Heads up to avoid duplicate work. :)

Thanks for all the work!
Looking forward to seeing these patches. :)

Regards,
Kuan-Wei

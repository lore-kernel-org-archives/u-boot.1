Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C6AD1A42F
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 03:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8032C88CEA;
	Sat, 12 Oct 2024 05:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="R+kLGhd1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53B1388CF1; Sat, 12 Oct 2024 05:43:54 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E3E88B5D
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 05:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e06acff261so1792477a91.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 20:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1728704629; x=1729309429; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xT2Ag68PrNgRbSgkEkk8gNVGR6U/3SgwAQyX+RboN+4=;
 b=R+kLGhd1Y/SwE28cV6/wgncUyxwvkpJz6rBM1g4s0dQskShuycS/couM7q1PBu5RuU
 uEKl5oM8K+1NlV9OlpgN2k1nD7XSyilnKkPxoAyuYnwirfZCZUQV4/OgqE9uXbxE6pzm
 VqTu2G6he61L7qRrYuF61uMVyAJpdTSkUV6tk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728704629; x=1729309429;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xT2Ag68PrNgRbSgkEkk8gNVGR6U/3SgwAQyX+RboN+4=;
 b=hv4ap0cXdiNb583jLzOPn666Z3aji5zwUGclLEVJ7R83y5mHQ1XoF+1C1MHJUcqM87
 kt1TC1IksUHN/wWy6fBxv9182sry3MTKVgz5Jhd0OzuT4+jpmKdW+H/SWyJgeNdec1vP
 4+wKGRiHKycppRQeFphupGU2mXrSz0WrS3bzPOoY0maryG5mTU6OKrmKZO968iLyxPtx
 Ls0rWBFgbPzcC+eq6ST6wRf0PUEF4+INAVu9bTjCpoR6pNBe2vNqv7K1Udg7UILqdTes
 /llsXTzbZq44Z0D8yOAseMxrSGcboDwiIxVsNySi43+t29TOLGumrbVtV2vDfPcHDVUg
 Tf3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqlNP3/VGOgvxEe4me7xsAh3XjEV5hxsRMMrmuoS+stnBUldZlMdf35RnHEo5BFTBrLjmn1+Y=@lists.denx.de
X-Gm-Message-State: AOJu0YxaB9uUZcw3vBOqN+FQ5kZBj7evlbFVvR9kruADZ54qdkpGf+iT
 GORX4/7T5aGBpiVwAUdyy9awFAx0QVByacLaHArvsBhma7hM4nvF8cK5/J1EJA+yEA/k7I0j+pi
 ZfHqXpSajac0/3aspUohSjXRbP1Oz3viy6bFQpw==
X-Google-Smtp-Source: AGHT+IHUJv8uS6aEkUHJtDmhz1GVXF7sFBVwFow1mG7PdvgHvMY9qilGtTwa3XKYUvxUp9u/5gem/QCevuQLhHFeF74=
X-Received: by 2002:a17:90a:6845:b0:2e2:eba1:a1a1 with SMTP id
 98e67ed59e1d1-2e2f0d9d935mr6583838a91.36.1728704629375; Fri, 11 Oct 2024
 20:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240929092739.2513768-1-daniel@0x0f.com>
 <172839506989.112860.11166419458122902632.b4-ty@konsulko.com>
 <CAFLszTiY7=hcg=5t6w0RfXs=C3NUMQXJkVs8PZyE281NTK_D3A@mail.gmail.com>
 <20241009020957.GH14210@bill-the-cat>
In-Reply-To: <20241009020957.GH14210@bill-the-cat>
From: Daniel Palmer <daniel@0x0f.com>
Date: Sat, 12 Oct 2024 12:43:38 +0900
Message-ID: <CAFr9PXmOXxyXv+iAgRqUJ=3Z2izQnGKVJNFbvBPQ0r_b+t3jHw@mail.gmail.com>
Subject: Re: [PATCH] cmd: Make bootvx independent of bootelf
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

Hi Tom, Simon,

On Wed, 9 Oct 2024 at 11:10, Tom Rini <trini@konsulko.com> wrote:
> > > Applied to u-boot/master, thanks!
> >
> > It looks like my review here was missed?
>
> I guess you sent it in between when I b4'd it and then pushed it.
>
> --
> Tom

I'll make the changes requested by Simon and send a follow up patch
when I get a bit of time.

Thanks,

Daniel

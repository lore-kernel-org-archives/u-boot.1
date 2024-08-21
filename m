Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06A41C52D6F
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 01:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4490788C6F;
	Thu, 22 Aug 2024 03:16:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=hifiphile-com.20230601.gappssmtp.com header.i=@hifiphile-com.20230601.gappssmtp.com header.b="ThsGPA1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 467E988E77; Wed, 21 Aug 2024 23:58:43 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5554388AA7
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 23:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=hifiphile.com
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=admin@hifiphile.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-530e062217eso187146e87.1
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 14:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=hifiphile-com.20230601.gappssmtp.com; s=20230601; t=1724277520; x=1724882320;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDFtT4jA6S14NLYxdYQkkgl9bj/WXQxpRAVo4/PbbjI=;
 b=ThsGPA1wHnw2a23ujBDOVTFTARSXdXyUw6Mpo5rEw0R7yi3Losi9zj1v0S2DvzTnCO
 G7k1r+Nvni6yWNBT75nst0qTQoJCJYFcgDa634XA9tu/neA+P0Dlfg/NtAgAE0pJf915
 MuowN2Q8JMRjD+/fic7FpQ77heYxbc/W0qAmO2OZyV4tKKsHxCZM8f9q1Jw1mb0h5kxQ
 o3fVgOFz4oDhcgiVRPAuBgy8ZOH2xn13NI+VodjIwyWShfopzvSdqKz8r2Rysu7DoSth
 QmjjqEu8m+cnlDJGgcph9RlKJwscrLuo/1vjADxVl6B2Mz3XkLHb8QGAA6t4+hWnOe93
 702A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724277520; x=1724882320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RDFtT4jA6S14NLYxdYQkkgl9bj/WXQxpRAVo4/PbbjI=;
 b=oSA0Al07cachorArIj4uTzjkmxEeNYzSZu0nREP6KrN0JcPAXrOZh6pFlL8cZNVz3/
 BEfloRGd5DoWFe4MjGbctY56LzVQ2oUSlkfCS0fWA21b+zrOeNtMRLaocvdXdkgGzjHc
 3BGcqc+GcXClDuLJeBT5UGpO7rdnq9tyllt9xIjv1i73sP1MaRG937rdhPXnimcrhIxS
 +tfik+tTn6IFs3+MCJVishc9ZRhnehYFD1VljKz9lI9cILG+7M6O2PhikCgHZzCx5Xjb
 npMBDbteFTiMB9XBSuVKGOu4pKBHNnnuHBDQ6JH9mDZaB2sOVBoKLvXr9JmMBZc+ywIT
 jfBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOgEh1dXTMKQEmqJSP9udWI96VHhVLBjgfVFeQ8ySzuVGJ7Kz0MpNebZdrA+KJH1JOqsMqe2s=@lists.denx.de
X-Gm-Message-State: AOJu0YxOkWVhFA5nSXVt2KbWDFjk90TwdRbDREWmU7h2rJpXRnDWSPTl
 DJIZ+O0tM100rd0nsfJaXdtoRvhzsPa2o7bOcrda4rmkFCwzlSq3BXXMafekyT1MMD81lwUrjjD
 eMUponGY0+tlV2g5Lt8PfJAsdBDPvuWaS9TRn4w==
X-Google-Smtp-Source: AGHT+IHmMwd4NuuZ/nf+iNb+1cf2MbJ79YE3JjrgiQEkCi5tPDe9KSOSxF2ny2AlWtug3lIYHquVVPYTJoUf2pb5P/o=
X-Received: by 2002:a05:651c:2112:b0:2ef:3138:f19 with SMTP id
 38308e7fff4ca-2f3f894e1abmr27191451fa.43.1724277520466; Wed, 21 Aug 2024
 14:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240821212218.2092540-1-admin@hifiphile.com>
 <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
In-Reply-To: <5a1367d7-be94-4c75-9f40-891ca79f9c5b@denx.de>
From: Zixun LI <admin@hifiphile.com>
Date: Wed, 21 Aug 2024 23:58:28 +0200
Message-ID: <CA+GyqeYxig+5pyYaCjPmQodXGjCYK=819cNZx9XmvJOnoYne_w@mail.gmail.com>
Subject: Re: [PATCH 1/1] usb: gadget: ether: Disable USB pullup in eth probe
To: Marek Vasut <marex@denx.de>
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 22 Aug 2024 03:15:59 +0200
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

Hi Marek,

On Wed, Aug 21, 2024 at 11:43=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Wouldn't it be better if usb_gadget_register_driver() started in
> disconnected state right away ?

That's what I did initially. But since g_dnl doesn't do connection after
register (I explained in cover letter) doing so will keep g_dnl always in
disconnected state.

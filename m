Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7410C54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 15:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBFE482E34;
	Mon, 26 May 2025 17:51:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rwvfeqiv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35A4082E37; Mon, 26 May 2025 17:51:50 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4060782E17
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 17:51:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6045e69c9a8so2701502a12.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748274707; x=1748879507; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IW/x57WwFMsVgcnjmt+6uVNPPo5boICwgp1qrckv+JM=;
 b=RwvfeqivVZDxXNgfvRyinr13gCw5oT4Ga+dYDHENu0/6H1H7cmSa8WJcS4KOdmnFAR
 bvbDPBn+d3zTOpVFPckGV8CKrAYTYGyKwjD88TWF/M+sv87sA0Yoi1zS/fzZW/bz65p8
 jXS+nZnnmzXLxRh2aUOYb6NppKPe8QGcVQTPV2I/bYaTWYJBdyzsy6xMRQJC3B1kVPkE
 ZbEEAAmq1h6DQ4RARJo5R1n77U+ffqefU9XTAuqte6ioY1fXiLDJp0OPAHOjDE2eTNxi
 0gM04oyaDSjxuls6EdAfdvRwttY5GFSGrJdgLsgshcsn0LfkySbkAMZldb1TC1TMy5Xc
 RvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748274708; x=1748879508;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IW/x57WwFMsVgcnjmt+6uVNPPo5boICwgp1qrckv+JM=;
 b=LaiDqnZQoZbbrqWiZbHsx+wxE8VP1cNkmAdL9fDWhyz9S4jLBactTP+To7rOV1bZ/4
 I+dGAcqxBUnkNJwN6HwRW2xHDfft5iYatSvkNHvshYXJ3gbrPLiUdeRn02wWA2S5kwpE
 T5oucboQt5Fkxd5xSnIhDyKyjo1bh+WB9N7faQBFsSS6InoXUOB0JM7sd8AAPMqZDB6e
 EiLtVJPiL5yt5OVRvvRCFmJ4eO33posCAPZG1qZz5cbp6mbgXlb4Mzh0Igdf1PDZs03W
 R4WCZmXGgXIxgSHquL8VS8XpPxzOqbgXnHhrBja4OwhPl7BDg6KbDIX+qH3jDtv3clsF
 kRfQ==
X-Gm-Message-State: AOJu0YzWJP1eOm565jYg0kiL9mKK7upR8Jzj6Z675swfMeEt0ZdbkdZA
 /PSymNvJUmC+S2rSAZ4xacI9cceWFFYi+wqfNdbsaAm88KF7e2TKsikAA8sfkJK//ZYc1htiKdg
 XNct/7AfRlej/A7eyKQVvroC6PPQGMJM=
X-Gm-Gg: ASbGnctPxJRW77+sNnhZhDsiaiR2pH70ATxe3JvyAcnooRmPWiwYDu+Q4rvX80sEhsG
 OWBbnBs/Kuk25yvqxBTazn/Y549EA4n8zyqced35l42EgpEV5kxsPN38UGUz6YPtRpmU+CWlO6D
 lRitdVw5Zkca7r98aChph9p6RT2roncBrr1UKY7Ay3hQOl4DQBtkYk0JxinGJRQ1cCAA==
X-Google-Smtp-Source: AGHT+IGHGiw/NNyhIdSYOB1ddOJzs4KXr/zH6KPD5hMOny2wQdkXmKRY8zBy5sQ/CY4t8HWsUtYJOc+SpJ8FLSoJRhs=
X-Received: by 2002:a05:6402:5187:b0:604:e33f:e5c0 with SMTP id
 4fb4d7f45d1cf-604e33fe899mr1422543a12.30.1748274707443; Mon, 26 May 2025
 08:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThhKENznk_+7TpxjtSdcsHB=mosyS=ftqFMUbZAY7xuxQ@mail.gmail.com>
In-Reply-To: <CAFLszThhKENznk_+7TpxjtSdcsHB=mosyS=ftqFMUbZAY7xuxQ@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Mon, 26 May 2025 16:51:36 +0100
X-Gm-Features: AX0GCFvNFoIlfi_uD9opxFhOPSGSe12i3_QJusWyAwKOq3lP4WzTG7TlWN2mz_w
Message-ID: <CALeDE9PPvfmsfr6h3XHfhdW=RxYHkDFmygO1At41jZ99jJYwtg@mail.gmail.com>
Subject: Re: Bloblist request
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
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

On Sun, 25 May 2025 at 09:53, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Tom,
>
> Bloblist is IMO a bit of a mess, with 2-3 maintainers who don't agree
> on the direction.
>
> You have requested that I:
> - implement a handoff protocol for x86 in the spec
> - do the same in the code
> - convert x86 boards to use OF_BLOBLIST
> - remove BLOBLIST_FIXED
>
> I also want to enable VBE, which would require further work. I'm
> sending a v4 today.

VBE should be opt-in, not enabled by default.

> I am willing to do the above, but to do so, I want to make bloblist a
> first-class citizen, available on any arch, built into global_data,
> with no reliance on weak functions.
>
> Please can you allow me to maintain bloblist?

Maintaining something doesn't mean you can push what ever you like, it
means you need to actively work to come to a consensus with others for
the direction something should go.

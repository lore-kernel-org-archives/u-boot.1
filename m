Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47174105D9AD
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 09:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3C5683F98;
	Wed,  8 Apr 2026 11:39:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="la9u7phc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 238448404A; Wed,  8 Apr 2026 11:39:55 +0200 (CEST)
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com
 [IPv6:2607:f8b0:4864:20::122b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5F3F838BB
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 11:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-dl1-x122b.google.com with SMTP id
 a92af1059eb24-128e4d0cc48so6576897c88.1
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 02:39:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775641191; cv=none;
 d=google.com; s=arc-20240605;
 b=dk4isVfHD3ndPu+/cMMT20GIGy04NIQ5Zuia2cXMzuwv/3fwzeEFYkocaPH/mYqt2K
 lPWYpRfENNnhZ8pU6QJauv3jKyDHtlolWJPZf+VLNYGFL5MhAvzD4H5TZOlFDBX6JX0D
 w6IZmDdr2XNJ6VzO9om7vK+GEj80BaBBuJZKnHUWddQ06b6Yr0s563yZidQgUKenMMTW
 7WYPamsGnck4LynqURdJLgqSslb08Q7iIItz+bOuz8ELfN4PXe/kDBx7g0y+3Shts1J8
 nq9CRPOrRxOU7ChMX43L7uBesXg4RAiD41ih4e7kDWM55xLDJnJEbg90B5OHxczz73nV
 kfJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=cuxDY2X1EhFdD0PXQaFtAr+r4kjlhIVLOL3HCdoxzio=;
 fh=hK5BgmuCCBGXgzlOsO5CvczOmA/1aH2tCO3Fm25fkZo=;
 b=h2kwMvcInHIXWzCIAcHnxtaHljXlmcscCWyPsiTt8R+tS6AFjAxg1FDfn9Oi8uWofx
 X0oqbp+9O/mhcN8wtR02b7XLfx/VmpMxUejsh28AfTxPMybjXL+cyykdO6xVEyseoju1
 g6eQQdSS02oHyVk9+fQquNzuwGDRvRMejXFErUvTDOmNB207BRpsVqjAMIcIetavcjJX
 xIWSNhPWbqkMdE2te+ieGVhwPxBcH6NRUpk+5eUKy7Pm4w6pLCF4CqUP9/CmjiQs+72F
 ysMHeaqgj0HUaooyA79IfScmHyjNfEYTPuOsi6bYWKHBKMnRRlU2p91Yl0jIXFNDgf6i
 R/7g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1775641191; x=1776245991; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cuxDY2X1EhFdD0PXQaFtAr+r4kjlhIVLOL3HCdoxzio=;
 b=la9u7phciJeQyQCSWGc31q8VH0tizqoy7xCO8j8/HHxtsrNvvitSjhS1/tzasBrqe6
 pkjlu10Y6Bp53jFdRWpAHOqlWtoYGSlrpwKsuvnL7Lb31Jq6cLsztkAzd1Z8dvC6S1Ex
 bLY1ZErDs5/EzQ9yFF162Jgo7mOsr6FNmucIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775641191; x=1776245991;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cuxDY2X1EhFdD0PXQaFtAr+r4kjlhIVLOL3HCdoxzio=;
 b=SDvCXrBI6cYYUuD96GkGv5p2GZMHH2aQtcObnkBOOfeRp29SYhFGhAEbHHJ1tAGB0s
 NReUPKsh6sEW2zLqsGfpv5tBFw2HiRwpwJNsOLqsYTRisUnLOrOZzA4uzxUSS6JOsWpN
 MyBlXBqb51LFayH1ldIQFnRuGLUlXC/ZKqEPTCkgULRsG9S/xOpZApx8LkVfkoJFyrDL
 FhIy+QNSQKZ0tadP9rx+rkKM2einZ9mfzKl3OAo0FZFozrb05k35nrUik99rJhAJ5yHp
 EdYdIeMIPvDY7sWxfJ3hHUlgnvVSY001a5YzUQSIeQrkfHrxgbOGcdZ21VxBaXe/tqUz
 Ettg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF51XlsIleCHQyKwZhE/WZ9blAjYUyGZlAPqSBVjRAYC9ddnA8UYN58fy5FUZJZb7v8EpcB2A=@lists.denx.de
X-Gm-Message-State: AOJu0YyNUBctXlPhauso/ynuP1umUxvXy+eB1eltNh4DSInfK5/yhnKd
 G7IxIljGl8vhKxx957NjOR8y3SEPD6dIchC1GBOtd/jUnxkBMFik6q7Awlk3FiJsSChdt8+vjpY
 Sk/TBxXPWbWYdRx9Pms35UJ9aJoJ/ExJmkSDAZWQRcg==
X-Gm-Gg: AeBDiesv/pPh5eEYanQJWOZx1fK1IbesYIUP/l769gDLr+ZdTTnx+bewtZNSjFuWP9n
 wlW+cFm+xpu2GXSUx77tS19OMfLm7yxACHkeE6IuEc3EvPPfyjMeIRiVOwO6u1nrbtrng1QD5mb
 7kTglwJEy134hVwu0s/m92v/LCYDi8Ypzewfhg6DJok435Bzc1g6fWRdA4mEHFb7zkkNvGpoox8
 RySA6DQLLzMm/lndy7huom9hDWharRFQvxAxXN0mcNR3n2sXj3bE250en+hdRKqtmN89nBIziTr
 Mkc/dtbGhUAIFL3FqFzpd4w27VEP/++1X7dZaVPR
X-Received: by 2002:a05:7022:1005:b0:12a:6a64:81ef with SMTP id
 a92af1059eb24-12bfb6f3d90mr10506186c88.9.1775641190728; Wed, 08 Apr 2026
 02:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260406142411.2992618-1-daniel@thingy.jp>
 <20260406142411.2992618-5-daniel@thingy.jp>
 <adWztoaranObqP2s@google.com>
In-Reply-To: <adWztoaranObqP2s@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Wed, 8 Apr 2026 18:39:37 +0900
X-Gm-Features: AQROBzD3HXZl0YIddg5JYu3jtZEJT4-RZ-do_NrnZC5JhC1MDjR57gP6_W5g8IE
Message-ID: <CAFr9PXkr8cQebmfrQ7n=_1L=DqOC=j5AuTx2=pmt_FqV9iBViQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] virtio: mmio: Allow instantiation via platform data
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Wed, 8 Apr 2026 at 10:47, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> >  U_BOOT_DRIVER(virtio_mmio) = {
> > -     .name   = "virtio-mmio",
> > -     .id     = UCLASS_VIRTIO,
> > -     .of_match = virtio_mmio_ids,
> > -     .ops    = &virtio_mmio_ops,
> > -     .probe  = virtio_mmio_probe,
> > +     .name       = "virtio-mmio",
> > +     .id         = UCLASS_VIRTIO,
> > +     .of_match   = virtio_mmio_ids,
> > +     .ops        = &virtio_mmio_ops,
> > +     .probe      = virtio_mmio_probe,
>
> Just realized this didn't send earlier.
>
> The patch looks good overall.
> However, I noticed some changes involving tabs vs. spaces.
> Do we have a specific style rule requiring spaces instead of tabs here?

From memory, when I aligned it using tabs it didn't look very nice so
aligning with spaces worked out better.

Cheers,

Daniel

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B9BBCCA470
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 11:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A99C383A32;
	Wed,  8 Oct 2025 13:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="migcrCgv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F34DE83A32; Wed,  8 Oct 2025 13:09:41 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEA6E8393F
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 13:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7a8e7ece907so4150720a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Oct 2025 04:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759921778; x=1760526578; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJMdqeLsxpWGoZqa33NTGGX+LeLF6G6rEoy9bV4QM7M=;
 b=migcrCgvUVmMY2H9flOyRl/PzhHFnreCQ2NO6O+LrlhMSLhpeIReeA+8T+0i5dFmvH
 tqYdYlUNrza6aDqSWN17fMl/7teGFIC3lq6lbSwp9UbCT4dPFxklbz5Khl6mkDEtKXtK
 YOAucTxgM/HQ9gTVrTdrdVFkJh+ADMaJNbvv8ni8pyNk66BtDfUy5JfaBUbRtOy//J4r
 Fc5WUHbvkHtxn5Q8W/6aS26F3AladO/dkGWs/21Ea9OqFkmT84ab6dWwQ5PmrU9frKCn
 D/S94bZy0tB4RTVYtzg59cwvF68aTGnoSpKW0yrmpS61Dwx4yN5HfgD9C9lQLobq9Df0
 3SDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759921778; x=1760526578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJMdqeLsxpWGoZqa33NTGGX+LeLF6G6rEoy9bV4QM7M=;
 b=IHhLoykMnjACydX0aE3pnYKR15aWox/OVdafntotkRUdp4TuUX3yDw51UaigSqoqIg
 yLyVTlziXpt+lCs/I0pvf5c9DgltWOF43+2yQbofOGlcy7pGegtc3FtDLV4psW5xSKRG
 I8YEvEuG+8jTC0jx7OxB2Eoznbi3w1bQftUrMj5mMp5YQ6Ypzkiyr3mMj0XjLym9mROc
 o3XU5O2C87+0VaIil6+gUc3PEDAqrQuPvA7nXa5clv8lZmN5csAAJHOIuA2lXYQfYxn9
 g+H59iMYWUwwh3GCYKGDtxqX5Mke3JUh7II1LFfHsuJLQPCO3PVEnoFP0np6IWbFe2Jo
 OUuA==
X-Gm-Message-State: AOJu0Yzo15aWhFTThC3lJWNSzT4wtMUBav4e5iy96sJ2doQV5YcAYDZ3
 Ie2HlyUgmBweXouhMFN2YCOVMYLfj/hyMHuCkAdYEd1Z+l4gycPfOtFb01sLuVTVci3NYIW3Uj3
 mHy+GpUzTWHLMAq8QG/uC2o8AY+ZcfHw=
X-Gm-Gg: ASbGnctzoT4riQaejeHxYIXWvWzpTQpJaGqB0p19k1W+fad1umh7K9xtp/PbrfgIIML
 enjDRWeTfrSs3g52TxUaNsLYjmzbbRU343WxG6H/wX1r52zgY/pZFyQZ+eqLP/f7sxJZSgNQQ5q
 jyT+HyQMb45WnlpLyVz8o8JhL39ReZoWxYw65NW2T3TCSFnQChKzP7h5KbfiNUGrIu0uPU9lXia
 3rfRaMzVVDY9wg264LiER03NVZlJeE=
X-Google-Smtp-Source: AGHT+IGD+6hYUGXfJ/2fO5WiZvgYy1ovmWTCVx58CToIsaVYKIDO9Tpqipp8v5UuCwnpEOGtn7XLTDVOJKutYWXIKUU=
X-Received: by 2002:a05:6830:6609:b0:758:6e05:572b with SMTP id
 46e09a7af769-7c0df6c6842mr2661790a34.1.1759921778533; Wed, 08 Oct 2025
 04:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250913163913.395-1-briansune@gmail.com>
 <20250923181254.830-1-briansune@gmail.com>
 <175989732707.1794629.12743192393543638744.b4-ty@konsulko.com>
In-Reply-To: <175989732707.1794629.12743192393543638744.b4-ty@konsulko.com>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 8 Oct 2025 19:09:27 +0800
X-Gm-Features: AS18NWANF8KyjwODfJIAKgTG-h0sgpJeCJrzjlDwxq5crcdMTrEZDbWji443hF4
Message-ID: <CAN7C2SAz4K+cZ+JC7qiJ0N1ayy9WrkGH_db_P5myNawOLAxadw@mail.gmail.com>
Subject: Re: [PATCH v2] cmd/dma: implement dmareset command
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Tom Rini <trini@konsulko.com> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=A5 =
=E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:22=E5=AF=AB=E9=81=93=EF=BC=9A
> Applied to u-boot/master, thanks!
>
> [1/1] cmd/dma: implement dmareset command
>       commit: 92dcb3ad5d98f494b2448a7345e1cb7eefa50278
> --
> Tom

Welcome to help.
Brian

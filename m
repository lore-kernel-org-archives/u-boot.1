Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8470C3DA4A
	for <u-boot@archiver.kernel.org>; Fri, 16 Aug 2024 10:34:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51E5C889F8;
	Fri, 16 Aug 2024 12:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="H+T9zzId";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C192889A6; Fri, 16 Aug 2024 12:34:45 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21DA788A99
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 12:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5bed05c0a2fso428286a12.3
 for <u-boot@lists.denx.de>; Fri, 16 Aug 2024 03:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723804474; x=1724409274; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cRz/HT4WmWdpa16H7BXg5CV5rBVq48sr+VpGmL8cESg=;
 b=H+T9zzIdGsuzjkYISdMhrmNC+g497XuG5wybaZCBatsYTb5y0Ir6s6gySkCWQnRx2f
 Zo9aGtBZUJ+c3H5SlBZkrkEaKY2QB2LXhr8qGTws4bfx/Lheq3ERdEskva6fMojvbXxH
 Jal8mQIaNMU8pa1O9UJOUTHjuU+z/n/PtYbQDGHzCZ9ey/C8wq6t3kQRUhEKltJrbg0N
 w/L2SzY7ZRRZfMYzP7uLgrL1pPiZ5y4zqYll0FijTrCdZAN6zVBP7kPli3OnEkIfYaMy
 Wn0y6VfeQV3I+40urUPgKCsCmKCL+DlsvDRQ2hrjnFfX/6pFnX9YemXiuP5qc2gn9Y75
 Zw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723804474; x=1724409274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cRz/HT4WmWdpa16H7BXg5CV5rBVq48sr+VpGmL8cESg=;
 b=BVwPYIy9Pmyp828DM/RQ4UAua5C5u52SALnU/CgG0P6unYkRLj3NJObLwEGEjK0dHb
 BNqP2gG38luy/C65Ig6iBgrzOkRZMARPFlXt2FAPs+bj0h/j+ZKQq/X8c4jhJ71Ef4yo
 p0wVfwNvwX9KYDq9FClte4UUXnpMqMhAESZUhiZ1Bky5iMTMz799FytEyDCdJYzZ4A5E
 ncXEmGOlG2v3K//kN4wuqkaGUD6Md0fdvuwTVDyog2LSZvHj0Vs1s55s8Je9mkCknKAN
 LXfaUfsSCcNBVKHHG8oqYAVIjjGfcrIH2y0OrU/1ZBzYdumIUZy4HTMVb4IJpM/+YLny
 OceQ==
X-Gm-Message-State: AOJu0Yz7s68ie1JT5fVq5DOJhnbobt6zAWtv6DD+p0V17o7Tvb0FmUMv
 Tv5HDhtKN4jhZA0Tj2nUu8Oz6tWsjLOVuYsM4m3r0Ocs+1OVppBqFTSh5OjU8XdcI2Wrrc0j/eA
 ZQs0ZyOu4Krek9DXHFF4YwyJ+OOq7GCFlK48UzQ==
X-Google-Smtp-Source: AGHT+IHwNzYb5rV6yPnWlpfLO97zYC3+ePZ85+/3uolRGSzKgWMwXqfcytQz1c6M4dO0SSaJQZDS80tliIc9YKtGl04=
X-Received: by 2002:a05:6402:5c9:b0:587:86d8:8b54 with SMTP id
 4fb4d7f45d1cf-5beca4c3d12mr1835244a12.4.1723804473763; Fri, 16 Aug 2024
 03:34:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-28-sughosh.ganu@linaro.org>
 <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
In-Reply-To: <CAFLszTh-5c4_OdZs8F_e=giR+ZFjNB1oX8L8cV8hXi9Je6e+5w@mail.gmail.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Fri, 16 Aug 2024 16:04:22 +0530
Message-ID: <CADg8p954ZtuXpC_b_rfkpWuXBGFV40Kp=DJby_oRsTp2GYbcHw@mail.gmail.com>
Subject: Re: [PATCH v2 27/32] test: cedit: use allocated address for reading
 file
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

On Fri, 16 Aug 2024 at 02:02, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Sughosh,
>
> On Wed, 14 Aug 2024 at 05:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> >
> > Instead of a randomly selected address, use an LMB allocated one for
> > reading the file into memory. With the LMB map now being persistent
> > and global, the address used for reading the file might be already
> > allocated as non-overwritable, resulting in a failure. Get a valid
> > address from LMB and then read the file to that address.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> > Changes since V1:
> > * Don't use the API version with flags parameter.
> >
> >  test/boot/cedit.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
>
> No, this address needs to work fine without using lmb. Same with any
> other tests. Tests make use of the sandbox memory space memory
> addresses and it makes things easier to code and debug.

Like I had explained earlier [1], not using the LMB API for allocating
the address results in issues, since the load command internally
checks if the address can be used for reading the dtb. Without this
patch, the cmd_ut test fails. I am not sure why you do not like this
solution. But in any case, can you propose some other solution? I
believe I can tweak the address to some other value, but that would
not be a proper solution, but simply kicking the can down the road.
Thanks.

-sughosh

[1] - https://lists.denx.de/pipermail/u-boot/2024-July/560569.html

>
> Regards,
> SImon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F55C49EA1
	for <u-boot@archiver.kernel.org>; Tue,  6 Aug 2024 21:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D122D88AE8;
	Tue,  6 Aug 2024 23:51:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hND5Q0Ui";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0708A88AE3; Tue,  6 Aug 2024 23:51:24 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89D688B1B
 for <u-boot@lists.denx.de>; Tue,  6 Aug 2024 23:51:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-75a6c290528so757764a12.1
 for <u-boot@lists.denx.de>; Tue, 06 Aug 2024 14:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722981078; x=1723585878; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vv7CfJOS84SLXP/nn1jftC8ZZsEDxOWC17LeHeKdY40=;
 b=hND5Q0Ui9F48q6OIy/g5xb7rWUhhFR/3w6Qy5e9Mu+SF1X40cP7twj8CYAL3YwTjZP
 ikvsR654JuAKxQQTmGDCFeHVloDXHT39Gy72U4p9ix2dtj7V9lzzAO6HXY/biPlUrnmr
 y/s1nBuqukbSeJoHu7iD/7qHkCQ4Zv9CQDz0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722981078; x=1723585878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vv7CfJOS84SLXP/nn1jftC8ZZsEDxOWC17LeHeKdY40=;
 b=Wz5D5eoWMezKi9Leduysq4hONEU0CyzfxpCT2PFolzVmwgJ7BG7+d9SLACyyO/xs8D
 byorJToAogjQBDGXiPW4TARtkJErrusziqVi18O91m4+0OMvEMeYSo/AP0RG4rcLTSPG
 v9EGsqxbCtpsDblBip9VDm0PIMneQbYNPEGd21pg+OAi6JJwHuzGHEjGtxlVj+repypq
 qz+lWYis3OwX4mOvNJ7w3s1u08ufqognN3mqU82VWr/XZDu7T7/X1kWM9coHvBLf4qbt
 8RSk5pAMzJ/PPNVqgX7jRWWzyHUysN3nYvOXZf8fAKZD5phmYhnoSHWfMVKzL07cSVNW
 LvLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKLT9il0dgF+U3cpW0IYCMqtD72mUlDaWJqaFdjU8QCN8XfKIP/lnwLun1yYvj3/bZ2a9TByzpPLzaJbzh0XaB3KxXxQ==
X-Gm-Message-State: AOJu0YzV3m2I8uWUjmB+v1vLy9fN243cTs3ZQUGzKYffS8iLRitzn3Q/
 NHC/0HSpU3X3tBEdKGpO5zxGVoqTMlYHnou1AueFUatQxqASci28mtt9YjoxKwi+QHGUx1N0aI1
 dt2+CGei86no00IveZh1GmOtOLWdJxDcCbWus
X-Google-Smtp-Source: AGHT+IEzUwoT+RJaoK0Gyxye8byrdA7GKZe7ZnJ2s6BNso8MeTNH/W4fvyuPo+fl8aBQoYFLKXoltedFwUA1R3PEESc=
X-Received: by 2002:a17:90a:a38d:b0:2c8:f3b4:421 with SMTP id
 98e67ed59e1d1-2cff93d40d9mr16239954a91.4.1722981078304; Tue, 06 Aug 2024
 14:51:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240803124149.2916030-1-jonas@kwiboo.se>
 <20240803124149.2916030-2-jonas@kwiboo.se>
 <20240803141616.GT3794063@bill-the-cat>
In-Reply-To: <20240803141616.GT3794063@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 6 Aug 2024 15:50:48 -0600
Message-ID: <CAFLszThuH7iKoDn3o9pG1DPEBmq72qiYZkc0nu+S6M93dCwm_w@mail.gmail.com>
Subject: Re: [PATCH 1/2] bootstage: Fix unstash of records from SPL
To: Tom Rini <trini@konsulko.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
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

On Sat, 3 Aug 2024 at 08:16, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Aug 03, 2024 at 12:41:44PM +0000, Jonas Karlman wrote:
>
> > The commit b81e31a1e6c5 ("bootstash: Do not provide a default address
> > for all") changed a bootstage unstash call to bootstage stash, this
> > has resulted in bootstage records stashed in SPL no longer get unstaged
> > in U-Boot proper. Fix this by changing back to a unstage call.
> >
> > Fixes: b81e31a1e6c5 ("bootstash: Do not provide a default address for all")
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>
> Whoops, thanks!
>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thanks.

How about a test for sandbox_spl to check this? I see that
CONFIG_SPL_BOOTSTAGE is not enabled there.

There is a vaguely similar test in test/py/tests/test_handoff.py

Regards,
SImon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95588CA0EFA
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 23:59:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 194E680548;
	Fri, 22 Aug 2025 01:59:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IqbtcKZH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF1581FEE; Fri, 22 Aug 2025 01:59:09 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 954168006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 01:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-436011e8ed1so759157b6e.2
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 16:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755820746; x=1756425546; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E3QtfJYtJLyLvXkvAi+eVr1GyAm1glcs2Chklnk4xYA=;
 b=IqbtcKZHTCG0sxPhOjiItLRRxUKHbjXGDz4yMeh/ZEGIvG2Qu8aIYi1M0tTVTZ6wHQ
 63WtWhSxXGzdaxuh2AejBH3NvvuYs0QPvEUSQLeoIhjidJTQnhBXia+EuBedMMR1sTaU
 ezufXdlxlParUqbTkNLLiVTDrFn7vddsJ28+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755820746; x=1756425546;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E3QtfJYtJLyLvXkvAi+eVr1GyAm1glcs2Chklnk4xYA=;
 b=S6UoZ1gmYSAZB6goBucodQO4FmFUPWPelTJn98d1KoB7uLkRA8GFn1JnMM+6Lx9jc7
 47aRl78PeyKdZGtSMmJTeGxTJlHmywDZmkh+T4xv8EKK+cHuEkm6oKL3K5U66IxjsF48
 niGIsCcF3EpeVn4MtKdqFCE2uP8qduGt7LcKna7MVbxA0xJ4Sp4f/j5quApN8dALR/nB
 XhBG6KHkoJwuU7ZIFgmHvl1rLHHRg/dZjvpiALWdrHEWLb89/CrTQBB0feUTAdzW+dGj
 C9impvFb0Bcb7WVlYWonDUWxxK64vwu6vENL5WFlk0drxQiRRr721pcB8byFnCkIyST/
 kpbg==
X-Gm-Message-State: AOJu0YwfTXoIjAX0P29HXcVmpsgpo87uGD6DqCHRFZhpo2wOxjSRxs5Q
 4Y9RmtUGt2FDOV4gHne1NMaKI7VhNAv2uLm/qfscmQ7YJXEQxGByUPJEqlmExDO4vAVHV/Zp+wq
 WckFNG8Y=
X-Gm-Gg: ASbGncv+8YurjmKdXXd6NiZeEz+2/TUlBmeDkrIUfjPXpAZv0YpDK58hEOtDWlMKczy
 UQscuZ9vOvXUaVaKLZ3CzqLko3Zo7oZXujBI7UAuEgQHSdkKAg7jWiegEtL2DFOA01p5Lja/3bD
 oQ/UqPLkCofsKGiJnqctdaaGsGBJ40a1mq7OUhLPpmE98xUfKGIKYuAOLzMKAriEFyNcwT+4wkY
 65n2Ud18xe7uLfx3sod8NdmWypWqrR+KbzLuGvkja0BvhnOfbQxem9rRUuJvKo3MNcrL4qlc6Hh
 q1eKCEYT+i4PoIKkOdXaxJaoOddBnM0q9TzigXVBxUe1u3TlLQfHaR60M+vN4n6wR1sXAJrVu2m
 d5izVb6ZzCqVdBenH1PCj6h5mN/+RetviKYAyrGpA1FltGovX/enYnBk=
X-Google-Smtp-Source: AGHT+IG8okxrTAxK4vr5RrXCV5MEi3gLJBZhyHUHgddolu0udvzF8D82Hn2IDVPak1dh+Oggr159LQ==
X-Received: by 2002:a05:6808:350b:b0:437:79d2:cbad with SMTP id
 5614622812f47-437851cbf23mr805327b6e.14.1755820746314; 
 Thu, 21 Aug 2025 16:59:06 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61bec11cd94sm1892634eaf.21.2025.08.21.16.59.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 16:59:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Martin Schwan <m.schwan@phytec.de>
Cc: u-boot@lists.denx.de, Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
References: <20250813-wip-bootmeth-rauc-priv-free-v1-0-1ef928169469@phytec.de>
Subject: Re: [PATCH 0/4] bootstd: rauc: Fix segfault when scanning device
 with unsupported layout
Message-Id: <175582074503.947488.11788901318777484713.b4-ty@konsulko.com>
Date: Thu, 21 Aug 2025 17:59:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Wed, 13 Aug 2025 13:54:04 +0200, Martin Schwan wrote:

> This series fixes a segfault, that would occur at the end of scanning a
> device, which does not contain the required partition layout scheme for
> a RAUC system.
> 
> With this series, a "bootflow scan" should now correctly scan the
> specified devices with boot method "rauc" without crashing on invalid
> partition schemes.
> 
> [...]

Applied to u-boot/master, thanks!

[1/4] bootstd: rauc: Fix segfault when cleaning up slots
      commit: 074066790c7f726f149c1974e01b8b3f75738c73
[2/4] bootstd: rauc: Don't null bootflow->bootmeth_priv
      commit: b389967f9a624b35c163767c34919cbdcd4e0917
[3/4] bootstd: rauc: Move freeing private struct to its own function
      commit: 302830499d9f0ebec42fe62254429a4d8db6b36c
[4/4] bootstd: rauc: Free private data when booting
      commit: 498e423457a0360c01d976aa21a218995a1bdef8
-- 
Tom



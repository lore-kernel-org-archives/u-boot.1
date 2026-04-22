Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4262FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 19:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B55384255;
	Sat, 25 Apr 2026 21:08:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RGaM77Lk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74F71842CE; Sat, 25 Apr 2026 21:08:24 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BFB984150
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 21:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-68244d317e5so5283924eaf.0
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 12:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777144101; x=1777748901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMPf3+U8f90tQYhMovuuXQF5UK6bb/ObXQ2WJGysybU=;
 b=RGaM77Lk9Z59/qRSvoNYibNsTWcmZ3GgFSQ9ACajB/+PkHlsVlqlhNJZeOoJ2Tju9K
 1LMVbj/upXX9Jumq6RW/ehA10TLCY1SjczTH00XVIX/DmZjlSwys5yOphJ2jXUMYbWwF
 dcaF6bVTKU9i6Cbw42o5MaWFicVtCpvUuY3os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777144101; x=1777748901;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LMPf3+U8f90tQYhMovuuXQF5UK6bb/ObXQ2WJGysybU=;
 b=TW4bXLNxPnbfWSWKt2AiitqD2l3W34xj+vE0k8xfmAaaQjhgO9H9Z1HdsxWRo3irmn
 ddge6yf/3uazHUuYb4ojlz0hvbkqXhoAae7XudYHLmhSwrD/TGU8RaSslXNpRxlNRzjY
 lQGHTkBLVE4nTwiNpH8X6KpoAdU1Sf/qHu/lYebPEKQOlWs4mu0bC0jRI4rrQrfHsw4G
 9W8KXqjABqDfYRz5cE+kHrCdvonokJV//kNMS7sDRnye6P5NR8LcNKHpMp/uXL2h/0MK
 0wjjgXr/lcFH2wEAF0j2Yj9RK6wBkU9bx9DiDGGFsgXxp21Qbbm2N0fjjr7Kc6d2cJON
 x4ZA==
X-Gm-Message-State: AOJu0YzCsh7rKtQMldPhAC6wJDoubGbhSvpMZ0wjNvRiO6Cnl2Q4N97q
 s5Yw4dY7A0ahQSTsRtcM3cQfcr88t1U1xuPhJNh8lGkYbOI7Nt5XpmeHI5RiCitqRK2rr60Ny9A
 Dkk/LBhg6vQ==
X-Gm-Gg: AeBDies4nq/nh1xhlx/9Vez4rU+IDjfDnZSddlYGssCaPwzKcOhPXsvJUYouJHdzj5S
 fYVHeoUnbpVW7lTkDOk0NFFzksDKy0t5CLn8Mr9zVCVZHrIpwXTWwWBe2izaFF+H2/Af2l1C+Ld
 q5ZfzUwcgKoeOv/xN8VhMqvbmTd7B5yhwxFdsfJMBw9Gh7vFmUp3zEVbZL2W0Ev4CM32f0JSgKu
 TRPtKZLw+QfPelun4mvJnEgXwsOwqe5Tbcpa5SZKBxwfXL1QLc39bhB28a3kXCOYNA8G1NBf2JO
 B7uJkqdRMNIvyBmEnRbnRWCNAOr+4Ccpaho14Y9Fhci8pP5e9CQD831h+DB11lduYVBBuvSiPp8
 wKoSUsksnjZpIaMpvwsa3uKZxiS18ZNqBm+DTYvsAn3MR3oEQQMtLyse15U6bEII5ybBzPBCEXM
 xx/BApTJ50EYbseR3gyCoBboGjNa0i+ASl67l9GtxxxWfoKtXnd7PzCxfiUgKfkIorLtTzDXoYj
 la50MdbEtXcFeOV9pjQpUzyl4K8PzL2BU00sXYa9+UfosFQxykcVwMC08Wd
X-Received: by 2002:a05:6808:690b:b0:467:880:744a with SMTP id
 5614622812f47-4799c9fd09dmr13393560b6e.24.1776898137414; 
 Wed, 22 Apr 2026 15:48:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-479f3cf40d1sm3874175b6e.12.2026.04.22.15.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 15:48:57 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Alexander Graf <agraf@csgraf.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
References: <20260219003351.388722-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] gunzip: Implement chunked decompression
Message-Id: <177689813633.1956774.5235019498051032214.b4-ty@konsulko.com>
Date: Wed, 22 Apr 2026 16:48:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 19 Feb 2026 01:33:25 +0100, Marek Vasut wrote:

> The current gzwrite() implementation is limited to 4 GiB compressed
> input buffer size due to struct z_stream_s { uInt avail_in } member,
> which is of type unsigned int. Current gzwrite() implementation sets
> the entire input buffer size as avail_in and performs decompression
> of the whole compressed input buffer in one round, which limits the
> size of input buffer to 4 GiB.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] gunzip: Implement chunked decompression
      commit: 58e523fedf48a304b54c4e42e46fd88d072f8751
-- 
Tom



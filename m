Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 286F1C54743
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 23:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B5DF88A7B;
	Wed, 28 Aug 2024 01:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bFfW4H8y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E22ED88AB1; Wed, 28 Aug 2024 01:22:50 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF53788A74
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 01:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6bf75ed0e0eso32423416d6.1
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 16:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724800968; x=1725405768; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qz7vCuR8blFBMW+6wm8WY+ZQ27ZWtL99WKhtx94h/pI=;
 b=bFfW4H8yaZq9sUXmIbuX9E2qGlz8zPVzlG9G574rGg+PLGRquGCCo6tl/cG1TsRVEj
 FjHHYdWgDr1YpufZukxBAYB3Np9jFlBvd6E1NOZUy9JWFQ6rX5Ff8jnmIOSFnOTrRZXT
 sT8WanVUsFGjBI6o4G5wqg7feZuOdDe/xo5Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724800968; x=1725405768;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qz7vCuR8blFBMW+6wm8WY+ZQ27ZWtL99WKhtx94h/pI=;
 b=g0QdYhphRVxNVSik/T40zE1Pjg9JPft/GFvnrEiUcvwANixedSiFPB3B93awwsrF6S
 B3WzJj5rbbzatg2l+Chq1Bive7Nsx/DdAi/o5+C9A0Fj6b0hAJgmneQM9BfHZ7/A4u7I
 cB6HAQUv83tp+OuCR9Y24Uzs6vwVBSD+CxOWwNZphOqXABuIjIE5zO1aYuB98wHhAEyM
 ZsUBj52AuIPDk6B3qryNeZrrdgLO/ll3GbHAY9D3r6H7sMm9vze+eLJuGEqP4WHZ+mUA
 NNjE5QLAwmnbSEg4j5B6gBPb2QvVQlYyS77DxxfSA9LCAusWrcAVVqSHcq577A2/gQ8Q
 cYCA==
X-Gm-Message-State: AOJu0YyAN3m2JrbSoZlO0h7dDFnhu5SU2hYjiS4xU30i1uyJF6DNI+sZ
 F2OMaSsoiQrzAK+0h4u4pQW9Br9unXQpzAAtmP498L1b2TmaFFORRcjcYZZ8QLSAqX+tAag4277
 5ac0t5w==
X-Google-Smtp-Source: AGHT+IGFWt5cKvcNgWKJ77NdOwrsaRnhz8tqnfpf9JUUm+xCZtxCWvugOtrKg3+eZ9pa74rronc+8w==
X-Received: by 2002:a05:6214:3281:b0:6c1:57a8:d251 with SMTP id
 6a1803df08f44-6c16dcbd049mr183059836d6.36.1724800967740; 
 Tue, 27 Aug 2024 16:22:47 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.65.244]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm60486716d6.32.2024.08.27.16.22.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 16:22:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>, Zixun LI <admin@hifiphile.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240802092820.917450-2-admin@hifiphile.com>
References: <20240802092820.917450-1-admin@hifiphile.com>
 <20240802092820.917450-2-admin@hifiphile.com>
Subject: Re: [PATCH] dm: core: Show device sequence instead in dm_dump_tree()
Message-Id: <172480096643.2972894.5601496619344187333.b4-ty@konsulko.com>
Date: Tue, 27 Aug 2024 17:22:46 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Fri, 02 Aug 2024 11:28:12 +0200, Zixun LI wrote:

> Currently uclass index is shown in DM tree dump which ignores alias
> sequence numbering. The result could be confusing since these 2 numbers
> could be different. Show device sequence number instead as it's more
> meaningful.
> 
> Also update documentation to use sequence number.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



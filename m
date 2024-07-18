Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478B0C3DA63
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 13:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6784C88A8F;
	Thu, 18 Jul 2024 15:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kPCa3aMp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 061E788A28; Thu, 18 Jul 2024 15:41:39 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39888818B
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 15:41:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-70362cb061aso399401a34.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 06:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721310095; x=1721914895; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5D1LzpezfrOcJ+ijQY0LF9Vvs/bntoRiLizwJ73SiIA=;
 b=kPCa3aMpEHFTd1ppX0LTp/wyYbe3qAmr4MclgWLyuu11O6EIKtgS7ew96I0zc1TNPg
 5EYdnqUWdCuJHYYZMjYA2Svi7VsUa7pf+1rhSqpjklbo/GWGzCMkwTDH0KjLY+p+d+UK
 RcPlNmfM2HnBdv3CqNIjMrGu6y1Of5J8BDlU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721310095; x=1721914895;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5D1LzpezfrOcJ+ijQY0LF9Vvs/bntoRiLizwJ73SiIA=;
 b=bQc0b3Y8cqvrEMqF/4QQUlNEXlJ5aNq5I7IgNCnSnjjaI7XN1dWIEXxIbZfUd9/3dB
 PuYxDADFEH5Daz45lDQ7MV404gpt+UaWLmH4IfNi90MY4c8aPxtxs4HGr3Cq8Et5iz2I
 Hn51FH/a5CjjRljw1/n/0X8Qo6oZnPKQYpTUC9iOUoLAKJWSJub9Dhey4851OY5ku4sl
 q/ToLMXuIbJAZ04Kv3SZ+hflq+aRta5oGeF+fqQ4XAPchcc6VWGcmIExgUsrBc8+T81u
 TqZ6dMttjw02X1AxW1wZbzZCwF8BZBu4GvhTEpYipWlmqzST6Jgl9NNgpRE3/TTkwRSG
 0oow==
X-Gm-Message-State: AOJu0YwL3IcgTdg2Fdnp41eSS+b04NYVJp/jFc1isl8LB8H5cdkeljmn
 S8SLmnCGaFLV47mlVqMck+rxlb36khFhwwNui3w4rUBNekoRDZk+6Q1TvBggOVxk39b40pKHQHE
 0OyQ=
X-Google-Smtp-Source: AGHT+IHZd/zipXP8aUHwHNbZm4jdFm5qtMgKdVKri8ZM5InP9pdxCUYt5g2hdmU3PEu1/JrEpRdOng==
X-Received: by 2002:a05:6871:b0a:b0:260:e36f:ef50 with SMTP id
 586e51a60fabf-260e3700b8dmr3776858fac.2.1721310095510; 
 Thu, 18 Jul 2024 06:41:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-260ee947f82sm355303fac.50.2024.07.18.06.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 06:41:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>
Cc: aford@beaconembedded.com, woods.technical@gmail.com, 
 Simon Glass <sjg@chromium.org>, Sean Anderson <seanga2@gmail.com>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
In-Reply-To: <20240709023858.27747-1-aford173@gmail.com>
References: <20240709023858.27747-1-aford173@gmail.com>
Subject: Re: [PATCH] ti: omap: am3517evm: Move environment definition to
 env file
Message-Id: <172131009455.1834634.6154035705512093000.b4-ty@konsulko.com>
Date: Thu, 18 Jul 2024 07:41:34 -0600
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

On Mon, 08 Jul 2024 21:38:57 -0500, Adam Ford wrote:

> Instead of cluttering up a header file with a bunch of defines,
> move the default environmental variables to a file called
> am3517evm.env and reference it from the defconfig.  Also
> remove dead comments.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom



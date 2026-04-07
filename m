Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F9FFF5136
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 19:51:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD08B8405F;
	Tue,  7 Apr 2026 21:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IWvaB92O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9721B84199; Tue,  7 Apr 2026 21:50:18 +0200 (CEST)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80EA484105
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 21:50:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-684571567a8so1153695eaf.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 12:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775591415; x=1776196215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bFWqVtX9wqcBXKtATY+R3Env/sqJYg0U9xGEwbYW5Pg=;
 b=IWvaB92OFvl05/EphmgBCkZhfxmQ4pO9LVwGtKSfZFc7lJXJRvp6KQM3QOAzxjnAZ2
 EyNooK9TxoCWt2p1mj6TU1W4RxwA5fFIEHqwa8561dciQ4/awkqHFTirtI2QFPudqxpW
 aoz6d9Zq27saxYCzWo6vd7PAaoVvZfrqU/AXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591415; x=1776196215;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bFWqVtX9wqcBXKtATY+R3Env/sqJYg0U9xGEwbYW5Pg=;
 b=IgMUs7ZlwCsMTFRXErle03UNZlOBkCjDDkfOnsOMHNH9gFoKb4R+dVG52RLFNk4iSW
 lB/lBvtf2SVkhckhJR9+qOY92aHHbxNPGjz+Of2+9cv3v2RnbQRHV5zraMBiCoekSiwx
 8AI5kT+RssXCDv37ImFm4mBHVKXnQr1xe6qciYS8DQo7Q+1AercyyYz6Fn3Sc6JgFPP7
 Fzy38Q2ReykDdAASn0mpTEnEsg0GSDpSv9VgsFJ7TFr8sBmUEbF0GA+fNrlVfNqcGEgi
 vdqTU5rQ1BByv1/t1bdiQhkM2sUvmLjwRzjNM56O1tyMVdZ7k40fpOpEszLCuwGb6ogK
 EgcA==
X-Gm-Message-State: AOJu0YyuqUHEOlVHN8GZU5OiHRHYCTHVkrN5NA3aIyXkDh65P7EdXJ1o
 Irz5Qcwutm71sBB6O9dli6NrG7r9e9WZRkG0rngc05julmBQTPVQ64jHmWRcswu/Wp/F0nYWQnn
 hlrfW0Fw=
X-Gm-Gg: AeBDietJkJwffvPpBbEltTEhoqpW+niE90WBuThnbRnquyaukz4hXdzMEYkuvOlPw3y
 eUNLPj/57bjbm+uZoWrEuILEJuzIY9MKmqFlEBz8ZjMUnPZ8PmXhuXLvoJBqlVVQAlLfB26Y5Ys
 j52PmqSJ0/8uSMfoHF5ezj5LOQdHorNU3tEYgNvLhsEugTJJ6N7dSZFNlIr1uXx4B/D4Zvs+5x/
 pC4tDrffoMY2HxobB4MOjCpBeioBecXwW7OZrDe4Z/bLGa+ow6g1mZFcSFnbV8Q3DhHFYrKF6uo
 02fsFIAvHBIsnLu7zImZOoB/oi/w45YSYW9gkcZBDc9mfu1iR5ojeiqJmqrIFWP10e4Am4o+pd4
 zvUdqOYx62u5+LGP6QDzqcGaNbtVmTZ/oPtWvI6Io9seWrE3BmhW7C94Qdr3Fl1rIf1xQGrTLew
 R9mCdU8rMwquBdUexXJ3Kxuunlv705op+OHrs3tHhQkPHbeAWuHGi3X6iS14zVK5jfphlc3SvQX
 BK7xBSRmTv0g4keuuDgu45uiR58AFX4zeq6iIcrZ79hMXQ=
X-Received: by 2002:a05:6820:2d0c:b0:684:c2f9:7489 with SMTP id
 006d021491bc7-684c2f976ccmr6875654eaf.5.1775591415207; 
 Tue, 07 Apr 2026 12:50:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm9988782fac.7.2026.04.07.12.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:50:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20260323195255.2363499-1-trini@konsulko.com>
References: <20260323195255.2363499-1-trini@konsulko.com>
Subject: Re: [PATCH] spl: env: Correct dependencies for SPL_SAVEENV and MMC
Message-Id: <177559141460.2108693.5880305431467677864.b4-ty@konsulko.com>
Date: Tue, 07 Apr 2026 13:50:14 -0600
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

On Mon, 23 Mar 2026 13:52:55 -0600, Tom Rini wrote:

> The SPL_SAVEENV functionality, when working with an MMC device, can only
> work with SPL_MMC_WRITE enabled. This however only works with SPL_MMC
> also being enabled. Update the dependencies to show that if we have
> enabled SPL_ENV_IS_IN_MMC then we select SPL_MMC_WRITE and make
> SPL_ENV_IS_IN_MMC depends on SPL_MMC.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spl: env: Correct dependencies for SPL_SAVEENV and MMC
      commit: b25d864a97b986ef1038697c8f0dd73262d05220
-- 
Tom



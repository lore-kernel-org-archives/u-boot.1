Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED89C36008
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 19:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AB908192A;
	Tue, 25 Mar 2025 20:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZOtvLN2O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D5281951; Tue, 25 Mar 2025 20:31:19 +0100 (CET)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com
 [IPv6:2607:f8b0:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF19F8186D
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 20:31:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbellary@baylibre.com
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2243803b776so56647165ad.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 12:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742931071; x=1743535871;
 darn=lists.denx.de; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CzAkoyhuoOZ9FRpL80Dgk/bH1BUQLWlKIUbjUZfLmEQ=;
 b=ZOtvLN2O71CRM0AbyNV0o1Dq/XWOh2UHVYezcY7/KevoO8ODvxZWAjJujmTxoMJwao
 wdPtZRLozIc/wlxVD3BPx+afqpq4sGivWJQMf180ANLm2Omg6OzvgDhpc8LHnRu2lmoO
 tlnoMEfuhdY1koLEl2cTDfow6Wj+Ao3Lo8yysWXJwf+dft8otRBC1JW0EuzNflgcLtQB
 WxLB1+GTdyFPqavw6x6pcTancH9E5rh2VG57BVhvp6h0bmiP/9LeYWyJq1c65LzjRl+L
 GNfFbz7+YyUscsIikqVk4RlugUTWZ31AE6AHpy9cN3HsRTSnpKPpKz+Vt3ztir8Oousf
 FeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742931071; x=1743535871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CzAkoyhuoOZ9FRpL80Dgk/bH1BUQLWlKIUbjUZfLmEQ=;
 b=AfKvvMT/h1S+NLB71NjfuO5jJZivmgXAp6piJFQSu9c6FHyiKR+VLCTg/BYIYVvM2Z
 pxyFjKOOL0mc4VhgdXFff+CJF1gYcYWENEHZdhhls/n8gm88KsSp0SGNkNYt1xUJlXNd
 /uBBASQL7mwRTGXVTEX529Wz/Z1f+wQv+FaQniP0HhzZSCkKtX+h9eEfR1ACs56FWHMZ
 aR859ImP5Ul+conjLHTQwtyg7+wfqj4Bq4jKd7LFuoVkXfKyiu54B3QPZ1I7PD4D/mFV
 EQTKE9Xhr1njbGLLYA0LQnC4VUBFwDCjKoTEZ57TxR2EvselltrjxiO8nQ0B/fRBiiKr
 heMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpEPv49dtxHdqJiACbSAfHYErWQGPhcSqjJWwfJyQhgyACxGGF3u//ESMjKpbIq1Fb/GLISBY=@lists.denx.de
X-Gm-Message-State: AOJu0Yws146y7j192Ks9J/uJB7f17n93Ax2P/AG/98beyaTSWKItOj7W
 e0/vfreyCy7OgwdQakOsPCA97E3pVUqcECTskx0AlG6KbJiqacuMCF0lIRnM+L4=
X-Gm-Gg: ASbGncvP8eoo447Rsiw9QUj59u+U8m2qD12/lGMRzcE/mSePBWlhSM3EokhiSckx5Xy
 HRohhORypc2D3yTeRlVDFlXvcGCD82Fnbad1yf/kYxGSf6vWvMBkQBXuDPolzTzfo6tebOFPS8V
 2CcH93Ew1oDiUY3kiRwbcqvODogplS/+0SAOOKZchrW8uh7339gL/WDokSgglucTF4NPimdR15X
 JY/5EA/NcroGNgz6Fhs5uEjPiHd2djotK+vKZThDedBFnFYtVi3nJ7rm0KA3m2nlmReYlD9JDyY
 GcgPlt9HPkpwLj62hxUYJTEdZRZ0wGhMNPzO4vaKLciYwQlZRWgQkhcDvZ5E4HBDJ3kzPWZnVFq
 7nt1P
X-Google-Smtp-Source: AGHT+IFkVqfJ0583bJojZ8EUrPyG4TY8isCRest/xOE8kZADBcH3PWmXw9b+/zWzi5wfbMN6IieOLA==
X-Received: by 2002:a17:902:ecc3:b0:220:cd9a:a167 with SMTP id
 d9443c01a7336-22780c511c3mr306921925ad.4.1742931071098; 
 Tue, 25 Mar 2025 12:31:11 -0700 (PDT)
Received: from dev-linux (syn-076-088-115-008.res.spectrum.com. [76.88.115.8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811da2e3sm93865755ad.174.2025.03.25.12.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 12:31:10 -0700 (PDT)
Date: Tue, 25 Mar 2025 12:31:06 -0700
From: Sukrut Bellary <sbellary@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Kevin Hilman <khilman@baylibre.com>, Bajjuri Praneeth <praneeth@ti.com>,
 Raghavendra Vignesh <vigneshr@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/3] arm: dts: am335x: Add nodes for lcdc, panel and
 backlight
Message-ID: <Z+MEeuDZNr7z0mZh@dev-linux>
References: <20250319202516.3300444-1-sbellary@baylibre.com>
 <20250319202516.3300444-4-sbellary@baylibre.com>
 <20250324172009.GB93000@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324172009.GB93000@bill-the-cat>
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

On Mon, Mar 24, 2025 at 11:20:09AM -0600, Tom Rini wrote:
> On Wed, Mar 19, 2025 at 01:25:16PM -0700, Sukrut Bellary wrote:
> 
> > For AM335x EVM[1], enable nodes required to enable the support for LCD
> > and PWM backlight.
> > This is required for the splash screen support.
> > 
> > [1] AM335x EVM - https://www.ti.com/tool/TMDXEVM3358
> > 
> > Signed-off-by: Sukrut Bellary <sbellary@baylibre.com>
> > ---
> >  arch/arm/dts/am335x-evm.dts | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> Can you see how hard moving to OF_UPSTREAM here is first please? Thanks.
>

Sure, I will check.
Thanks.

> -- 
> Tom



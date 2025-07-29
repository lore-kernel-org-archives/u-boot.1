Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061DCC83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 17:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A2C82B07;
	Tue, 29 Jul 2025 19:32:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ps8km+6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F02D82B20; Tue, 29 Jul 2025 19:32:51 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAE5D82ADA
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 19:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-303058a8649so1967883fac.3
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753810367; x=1754415167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xASVcvtiiazCmljF7mGLSGtXjEn4JlPji37rfXRb7bw=;
 b=Ps8km+6tlGCe3Y1eCcJ4alcCQnc8l8vS7kpjqkmCz81cfoYQeWsY+sF95rqnJAgfLl
 lD+tWIRgGiusQeHAB17yHy2nH7HgVuB7lYzO9YuypMnUe/6Z1xDzsiIMyfXNyTvqhAGO
 KRzN0wtpniGC20ox4ZV3egR59mBnfY2gkbJZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753810367; x=1754415167;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xASVcvtiiazCmljF7mGLSGtXjEn4JlPji37rfXRb7bw=;
 b=osfq0pgVYxMvVQ2ZdjnX+R9C0oeH7p0kd98gdxeTS+YVcubLiBCjSA0V1IQPp1jdUN
 v2j1yam4nJA3TTiVJQhN0HieGS8B1DqTupN++aQfrPjgV79cw6bEk10IJDAu3n2AxGNK
 rt4oNYfpB7djV2TtkNlKQun6nGAmWDafSt5VfFuqlyvu490OZJx9ojloJ/ywEEsw9yhL
 j1Ov4wuMj9oU5ZWnkkFzjuOBvwJ/A1gC7/RXx2sxWCWfxQy9CRNcST1/j1XApdeLnMSA
 6y5Gth14O6Iq8yCxnuOaJPHF4wTGtpHNUGiTL+FupI3PfEDd7vYl8bT5xgyMTHak+bad
 Czrw==
X-Gm-Message-State: AOJu0Ywq6s1SViWHzEnUQ2WEBL0iZ1OtVZ7gB1hazUllVXhA2VEBTpL1
 tOgdVuZ1CJmq/Bl6rNzQTuLj+OR7PD/Ol/MXPVlK+qLw04uTS2balCD4L2gG7lvNFSuU5pgBC85
 3XWQCIjQ=
X-Gm-Gg: ASbGncv2iGu6WOGQZdXTfiMSsd8xwgPZLYtVoLeYIn9HSwWQxvW1hDUlltix+N6lBUg
 Ye4wmd65iRRRrj+dhrOqzxTBkf/d3H0ykAf+3BJmDSifAAdg6Azsyy1aLsFRV9ZdnflDFk8seY4
 hQ8tNcyYc6Y1PMnegfpkyFE9Ob4dWOUqT3XvWpidZj4h+VenC/f/Z1CajaGH9ju7AxZ2gz3cvJC
 pKz/BKSaNIzNIP30VMG0ZS6PEN6PIOXFyjjgK0uPt45SghcTVrh/GN3rijmYbKI5ma4Ik2K52nb
 Z1GnNjnQLc44VRGRQ7UuvWX/nWHRFFG1h47WXnTRhhx+ByunXeCsxrvkYGLBUm6G72sqAbNOdh/
 k7cbJ/LlEN9KNUVvL4cfINY8ZWcQvHV9+tuE260z7RzP3hrNMIN+ik3Y=
X-Google-Smtp-Source: AGHT+IHrBrGfYDQBcMnUo/OTWe7NbgglFhP6/cEOk04r8Fq6HNCKSiUk/dMl2tZLGB4GIM+ekHVCmg==
X-Received: by 2002:a05:6871:b21:b0:2f7:840d:fe9 with SMTP id
 586e51a60fabf-30785c4d4c9mr126967fac.22.1753810367459; 
 Tue, 29 Jul 2025 10:32:47 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071358e0e5sm2397135fac.23.2025.07.29.10.32.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 10:32:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <9a29d856-02b9-4a30-8691-d43b90b21fbf@mailbox.org>
References: <9a29d856-02b9-4a30-8691-d43b90b21fbf@mailbox.org>
Subject: Re: Please pull u-boot-marvell/master
Message-Id: <175381036683.1980872.15267900949098425601.b4-ty@konsulko.com>
Date: Tue, 29 Jul 2025 11:32:46 -0600
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

On Tue, 29 Jul 2025 15:27:58 +0200, Stefan Roese wrote:

> please pull this next batch of mostly Marvell related patches:
> 
> ----------------------------------------------------------------
> - cmd: tlv_eeprom: Minor improvements (Hugo)
> - kirkwood: Enable bootstd and other modernization for ib62x0 board (Tony)
> - spi: mvebu: Correct dependencies on MVEBU_A3700_SPI (Tom)
> - ddr: marvell: a38x: Fix unsigned issues detected by smatch (Andrew)
> ----------------------------------------------------------------
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom



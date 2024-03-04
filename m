Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E73C54E49
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 06:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D86C879F6;
	Mon,  4 Mar 2024 07:25:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="briTGwK6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B124F87E88; Mon,  4 Mar 2024 07:25:07 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B759887842
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 07:25:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412a9e9c776so29571865e9.0
 for <u-boot@lists.denx.de>; Sun, 03 Mar 2024 22:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709533504; x=1710138304; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pd2HqOOoy4NTDwYig0FtflIpnh2UtEFbiBYvEJETU6E=;
 b=briTGwK69srIhQAP4DD/jW9fKDLMm4qsntsIVg5qZpVz0gI4tVS/vKwErvS1uYQjjE
 adzDRAN21+DUkWFbQNGEQRFBtGJ/kZ/b9MHMVt8Qn3cfAgKOshZiFSf+rPaJi6y+eo7L
 z6dvrQf6T915xhH89o+rLlFrKBI8P5a/5MaV61Thmf+inlent+On5WYMTRhADE0COy7i
 d1Zu2+L543cSMkV+RaI2dKWzR9b78iA7Ysw3FACUqvTxCBOmzf98GF1FkSBOwhwbDJXV
 sdDj8jyBcWpwuT6EQzx7UNJ9hxtPWAv36ZlneE7SegxtdNU2iL9kPBDWM+vtP0jxKxMv
 DGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709533504; x=1710138304;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pd2HqOOoy4NTDwYig0FtflIpnh2UtEFbiBYvEJETU6E=;
 b=veJuqBGgN2h3ZI/CQ8BdFyv87jISvhJmf3BNDOUZkKEyn/hsdkK3tB9Q8LnsehA+KD
 +P/uP0zjk6wmxaBwkGP03IcQfriRXLBciOfiRlsWOmmLk3YyQt9oJGLsIbTZJdI5yQU4
 mY06Y1SxBG/DeZEMe6vZ778Cn1xH0WS+ICToVxqtBvOvweeN8mDbw5RAs3mrUJWoiUcJ
 DRzMuLloGL8hAJUyIlB7pvITSALEWVZql6pPU8fuwgvgYxr2G1WpJXtjoH5BBaa0Sa5k
 waf/1jZaCJJCkrbsYy0El7rK/7871BirTj1DRINFK5QgNo44vXcHAJw5fRE/ZxRiopF/
 UAZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV39hPNC2Qoc+V+a97J70gIsVsg8ZK4fBpjY/eNxN5lSCKx6jKJZAONyl5VYxlAl/m6C/JQKRK7OgN+ZQG0XgJRC4CWig==
X-Gm-Message-State: AOJu0YyCsXCwX1ERlWTEzEnro1NNfWs59IOuvfdoENWmHbPBj0Puzh0y
 Ulp8K48gB33MCmvUHd6X67dvbjgOSWlwvZ2EnlfmZpNxbcAMvqEiuVUJULR2uJQ=
X-Google-Smtp-Source: AGHT+IHI2Zvrq6nig5eWc8F08wKG7TtErM/GFkCK55Vh6/vQtEKBNzjN0VLLG6JN8rNY8pq6Xatm9g==
X-Received: by 2002:a05:600c:510e:b0:412:b02d:71f9 with SMTP id
 o14-20020a05600c510e00b00412b02d71f9mr7942786wms.2.1709533504182; 
 Sun, 03 Mar 2024 22:25:04 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 w13-20020a05600c474d00b00412c1d51a0dsm12115178wmo.45.2024.03.03.22.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 22:25:03 -0800 (PST)
Date: Mon, 4 Mar 2024 09:25:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: "joe.hershberger@ni.com" <joe.hershberger@ni.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "michal.simek@amd.com" <michal.simek@amd.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: =?utf-8?B?5Zue6KaG?= =?utf-8?Q?=3A?= [PATCH] net: phy: ncsi:
 Correct the endian of the checksum
Message-ID: <901d6849-2e8d-4876-95b6-afdb9696d862@moroto.mountain>
References: <20240205080228.140001-1-jacky_chou@aspeedtech.com>
 <da9231ac-1386-48fc-81b9-8e027cd5dff5@moroto.mountain>
 <SEYPR06MB513483FE06C897839C5E3E5E9D592@SEYPR06MB5134.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513483FE06C897839C5E3E5E9D592@SEYPR06MB5134.apcprd06.prod.outlook.com>
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

On Sun, Mar 03, 2024 at 02:14:43AM +0000, Jacky Chou wrote:
> Hi Dan Carpenter,
> 
> I have verified it on the little-endian platform, such as ASPEED AST2600.

Awesome.  Thanks for this.

> I think put_unaligned_be32() and htonl() functions have no effect on big-endian platforms.
> And keep put_unaligned_be32() to help access the unaligned memory, such as pchecksum variable.

Yes.  I know that.

What I'm just puzzled by is how we ever merged this code when it doesn't
work for little endian systems.  How was it tested originally?  How do
the errors look like?  Perhaps they're not as bad I assume from looking
at the code...

regards,
dan carpenter


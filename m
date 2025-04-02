Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64079C28B20
	for <u-boot@archiver.kernel.org>; Wed,  2 Apr 2025 15:21:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE69481703;
	Wed,  2 Apr 2025 17:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kDafCNae";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D0D981E1F; Wed,  2 Apr 2025 17:21:55 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D8758035B
 for <u-boot@lists.denx.de>; Wed,  2 Apr 2025 17:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-39c1efc4577so1548472f8f.0
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743607313; x=1744212113; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XQS83v0QolzKLIFx+Gaxlz/bqhqQqudAFMMrTb6X5Vk=;
 b=kDafCNae7tkyIf4k7uaYej3UGnQxC8GUFQpXWrdg4GQJ92qvEbmDdcwJVt1Zq8N7sR
 U7qR8In//N0Mo4DjfLHiuL7a37w7nRyL+Uge6nnhiyyUIhtsF73pcer0FWl+9/KNCRnY
 jKmpOmw1vtLS1gWjKou0dsnggM92Bk9d9Md7kTctKCCuNjMkZ4ukhOmHjIrsLSap0EyA
 RWjIb/hyk5GA0WHgk986Qx0foHtSEfj+DdWqDJw7ZUY0HR4VpUrNwoJnEQFuSj+/eewe
 mYWO0FrQ6EjjKLNwlJN1cuKivhbq276VjhV6oglk+0gG3r0ZfOlWAn267LB37VjM5u/Q
 Xj5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743607313; x=1744212113;
 h=in-reply-to:content-disposition:mime-version:references:subject:cc
 :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XQS83v0QolzKLIFx+Gaxlz/bqhqQqudAFMMrTb6X5Vk=;
 b=hcmQUHfmMp7y+wHgfeIaVba0sYXn9QPqRHQFSS4saSv2EHp+l+XZtHu5g4PmxMAkBj
 rwJtWliK/ClOx5Qa03Gw8yUaX5g7E+8JIK+0Ycrpz5ZaoLG8NRgkfARHKG1fszD7bZSq
 j+5nMxmQbdryRmwTp3pu8QUYWnRx2oeqV557Nm4cDbnEBiKWDaMXCUy6rAC0sZNBguV+
 /XXz9IUaTq8ZrL9OOi7vICr0ZIy4GP1wfEckraJzX7ZuwQEZ4yWSnV6LMaR+JmVWkA3T
 /1D3jM1NlSfWuueAUVj1iAtutbm6toXhbyCqQPsmoBsV0k/NmY4FfhbKG0a1kPyefhob
 bk6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD9WMl2n0gqEiNPDj6qPGkoPxwBDdsUURqZUVfnAZB4Pq3qnYye8lDQ7gfWeJoYi7DD+mlPMM=@lists.denx.de
X-Gm-Message-State: AOJu0YxdBvEbXdtGBGVZ+gFk/ERWl+PP4n6gi9chLe3VuoVSG/JsBeD3
 lLj3aFqxV9U68eyTmLwdnuFk/6ySRkxohQHgyGT+NiQDte3PBN15
X-Gm-Gg: ASbGnctxdz7wuIK6k5xWTRYMdQYZpEyWmB3v+LW0otHMnSZNG6H1kcWLrP7YkBP5lNl
 yYI4jurJKFjrHvTGo7Je8SBNawMp5W2QtthIwLZ7gm/JS7d7KPGsqbusFBNY6Pn0bu2QZ32tjLk
 LpZYjzSgD7ZB9SQPINEgGLe+2MmvfmanBaH7XPGEvh28XRL2sWig5gbG08hr3qwvHqgrg0wvjRi
 3z0lrBGN094oQvWSEKTQvhpb01ava5odXY150HIgZD0+9vjMJ9+wwimjBfz7QWpej2YGz/l50VK
 o31gARdL58QdOwTmAhPfQfXf2Tb65slc8tOyNTBV95LMj/7gZM5kxmRHMIxyCMI8kAQ5jdGh0N/
 C
X-Google-Smtp-Source: AGHT+IGYc7EbMJbWmRLCK7etibwiY6QNGU5T9QwdfGRpZAucLMoMfLAZzRPe1rguvgx4bx7+R6Ufqg==
X-Received: by 2002:a05:6000:420f:b0:39a:c9cb:819f with SMTP id
 ffacd0b85a97d-39c2366b034mr6404672f8f.37.1743607312600; 
 Wed, 02 Apr 2025 08:21:52 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-225.ip49.fastwebnet.it. [93.34.88.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eb60cd74dsm23867485e9.20.2025.04.02.08.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 08:21:52 -0700 (PDT)
Message-ID: <67ed5610.050a0220.1c650.ac73@mx.google.com>
X-Google-Original-Message-ID: <Z-1WDRM8nPogBMtF@Ansuel-XPS.>
Date: Wed, 2 Apr 2025 17:21:49 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Bruce Suen <bruce_suen@163.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 02/14] net: airoha: Add Airoha Ethernet driver
References: <20250401225156.25790-1-ansuelsmth@gmail.com>
 <20250401225156.25790-3-ansuelsmth@gmail.com>
 <20250402151951.GY5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402151951.GY5495@bill-the-cat>
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

On Wed, Apr 02, 2025 at 09:19:51AM -0600, Tom Rini wrote:
> On Wed, Apr 02, 2025 at 12:51:34AM +0200, Christian Marangi wrote:
> 
> > Add airoha Ethernet driver for Airoha AN7581 SoC. This is a majorly
> > rewritten and simplified version of the Linux airoha_eth.c driver.
> > 
> > It's has been modified to support a single RX/TX ring to reflect U-Boot
> > implementation with recv and send API.
> > 
> > The struct and the define are kept as similar as possible to upstream
> > one to not diverge too much.
> > 
> > The AN7581 SoC include an Ethernet Switch based on the Mediatek MT753x
> > but doesn't require any modification aside from setting the CPU port and
> > applying the Flood configuration hence it can be handled entirely in the
> > Ethernet driver.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/net/Kconfig      |    8 +
> >  drivers/net/Makefile     |    1 +
> >  drivers/net/airoha_eth.c | 1448 ++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1457 insertions(+)
> >  create mode 100644 drivers/net/airoha_eth.c
> 
> checkpatch.pl has some macro warnings and it looks like some
> inconsistent spacing around '#define FOO' vs '#define<tab>FOO' ? And are
> all of those defines needed?
> 

No they are not all needed, I defined them for consistency with the
original driver. Should I drop them?

For the checkpatch check, also comes from the original driver.

-- 
	Ansuel

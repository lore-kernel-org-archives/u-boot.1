Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 796AFC87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 22:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79E1783C65;
	Fri,  8 Aug 2025 00:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ges8Gxlz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D08D84690; Fri,  8 Aug 2025 00:34:31 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7F2C83C2B
 for <u-boot@lists.denx.de>; Fri,  8 Aug 2025 00:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-615ee07353bso1139292eaf.0
 for <u-boot@lists.denx.de>; Thu, 07 Aug 2025 15:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754606060; x=1755210860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TR170mU/r05FZarETZa0bcxVXOX0AZ1XMAPd8abbAB0=;
 b=Ges8GxlzwC7ZYpDVnhSeQshs24P5YJX0M74uNkf5ZW+XrKfV93hPu/GHE8oVOufv7J
 WNNdOTLu1BRbn7VpZvVOshfJ4nw8HOuJSGIw5iE+qD4qf828Z/KF/dAjqDiQ76jIzLCf
 66s13uxjysYYQLFNNbEUGdlRXaBL4jLK43HoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754606060; x=1755210860;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TR170mU/r05FZarETZa0bcxVXOX0AZ1XMAPd8abbAB0=;
 b=vipOEGSdpKfnhKK8iWD06xqc/DUg96s6foYqfIEPlyL5LmJDYHqfPE0HrG2XtwJlgE
 h8GU2/LUPKT8EpV83WSy5dNtVfRdIK/xU0HThJF1jHvmTot+Jt8aOE/rP6RBBGOpF4aM
 eJ1pp6D4xtVpQ3OGF4EgSAG4ChMeKzu2s45WLzxdZSxMA9db3f2N2Iol3Nhr56xzSE8s
 tLB6Ll7MhwBLAcV1j+R0hrQgumnLFaWzqwL6yfLNgoU1xThJPYy3oFXLeJIWkt4he17W
 n9MImuEbqT1Pnmla1coQYiEUFTsO6A0gmYvdH3n9Zrb57RMqb19jrFjJgAKwd5HrywY+
 rUeQ==
X-Gm-Message-State: AOJu0YwQx/wK1rSsoAsXaYEeag6jKZGXvZCVz+E6QDeErSToKzickc/n
 AhxdnWcjyZ7WrwFwXmtXd08lBcSvWqadAwHiyBCJFDziibndIx5DIhXfYJKyvS8o3PHXgcjqP38
 +FtBgW1w=
X-Gm-Gg: ASbGnctS7tYnO3cI/zmtWDGO2Q0Yc11AoHtlXd1LVmnYMcQrrGcUl1PpXEBGM0ll6p7
 8+HsDEocZWRyVo78IEA+lcKlPq+Ss7C2di9Grqg2/n1DPbmV+4rBQS1vFml39Ad6C2ZhaGFTRoM
 BckkMFNlAahG/NrpghRV31hMglngGO3EKvz792egFxTonIjz7cGCN7ZcdPhX+sIBIXBVqoRYOR/
 PyqVs77HXwmmOhppeT73b2zQXZ9Un4b7RXpDhPaASeavk1UCxHZbcmVc5c5EBEXi2YiZCszwKt5
 Fa3tu4KzEtXFIQmsnl8Qpw1j1xMzaZJ+Hg0Mn0wgSSVvlir1ZBKwbqv6lflhNvV1k080+ECiRuV
 2FQx7wfh0od4YJ0AuHC3qw/gm25elsFv37O8FF3bBQorvfXbGbNYUYtU=
X-Google-Smtp-Source: AGHT+IGOhQ2XLZ1lKT1685NMxuSZ0Pr8CHH/YPy9H/zOBZhpOFeB97PnIcsGBVFqqyK/Nj+HN8xxAw==
X-Received: by 2002:a05:6820:1c88:b0:61b:759b:710c with SMTP id
 006d021491bc7-61b7c4bcdd2mr410282eaf.7.1754606060566; 
 Thu, 07 Aug 2025 15:34:20 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61b7c6eaf6csm73309eaf.0.2025.08.07.15.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 15:34:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, tkuw584924@gmail.com
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org, 
 pratyush@kernel.org, Bacem.Daassi@infineon.com, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, 
 Hiroyuki Saito <Hiroyuki.Saito2@infineon.com>
In-Reply-To: <20250728011358.30034-1-Takahiro.Kuwano@infineon.com>
References: <20250728011358.30034-1-Takahiro.Kuwano@infineon.com>
Subject: Re: [PATCH] mtd: spi-nor: Fix return value of s25_s28_mdp_ready()
Message-Id: <175460605911.3039738.16303824499507429473.b4-ty@konsulko.com>
Date: Thu, 07 Aug 2025 16:34:19 -0600
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

On Mon, 28 Jul 2025 10:13:58 +0900, tkuw584924@gmail.com wrote:

> s25_s28_mdp_ready() returns 1 when spansion_sr_ready() returns negative
> value (error code). Fix this problem by following Linux implementation.
> 
> 

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: Fix return value of s25_s28_mdp_ready()
      commit: a0526d44daebeb39d058d8b274370c3070457727
-- 
Tom



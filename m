Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA95FC6165
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:24:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1294783BF1;
	Sat,  3 Jan 2026 00:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EQcO6ICc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF27B842BC; Sat,  3 Jan 2026 00:23:50 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE0D83C29
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3f9e592af58so7467949fac.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396227; x=1768001027; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKczN3ub7xl4gc96nBzSOBNYSY+cSbaIdfb9F0MuJ/A=;
 b=EQcO6ICcBeh/c/KkdSrrAe9USq2cpnlXC4PSa+gHwQU/jAmixPpLUlkykoOUaxdJ3I
 Mf8Ra/YlcUqPVVKYNmaPWYDRtOPncPmSgtoWHLkLJ7PHKZWb5ke0q7RundrIXOyeHgxS
 SKSNDlUZ4bnirezhq35o0WISzuFIAVsTfi4fw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396227; x=1768001027;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aKczN3ub7xl4gc96nBzSOBNYSY+cSbaIdfb9F0MuJ/A=;
 b=UMXciDzuhyPy+/Hq84VUG5WcvfvpZMhkr3nfxAZzuwUzY5TeTqpUKwn12ptwG44IR6
 4su4zoQxbPRs24ssneZiVG/oWEznzIHUsWb6qOLVF18XEvAEM/15c509q/q6C+V1ozyg
 r1Hqr5b+upOzgNQf0FlfhphaZ00q86Gx4m0jlWAlv6duIfQG2U0RNmyjSlwIw0/OoBzl
 yR1w+XC8T0US8kftt48Qn/aXtb8+AxoPqBenB9xPx16+CXLyT/pp3s6U1m4rlZCvnxNw
 +9sSk01ELk9B7fxB5SF/lCfi+hfDVfElIF8yvCrwN1Rudfvib/PjmJPoqhEufZkTmuZU
 TS6w==
X-Gm-Message-State: AOJu0Yx01/V1XlxON+dp5S/GgrmaZRZNXPJ3mWZUYQGcNOUod0sIOGKD
 /Mu+1CTRgIJoXmJIApkafDtZrNiG5qz+GX77b1eoBbJSNRPSy/Kw762dI74BNm0zKFc=
X-Gm-Gg: AY/fxX7365PPIB399ViEM50BIqdlEr+x5L78v44eiGF1BxkIY3zsExwGoXz8P62onqE
 J1hnDs2BnPDGw4boLgO/l8Irzan+G7yNcIgMLJUolXH3JqzX/4+bihUnh/FKhp7K4+SRXBm1QBT
 J+ctfUtse3bAc3Eu4BqQa7d/FsjbqZmuExYplulCG7pk+epvi6mBJNnT06axXDHcMy+gGYAYSIF
 Y/EAvu95MwGZKGL5MHrM2/xqUUQT6d5PHXO/a6r7aIt1se1sjuNdjtmWCCIS7DpthvWqQr/XDYO
 VKKBuNx3ebIxSCBVKUbHMqoEllMe8eqfwP6F4wt4wReKZGphPmHZGlkVo0rLrPpb/jahYrtd+dO
 FRS5l5hOKasecEOvbSg9tobJrnSi47dGNnH/8yagpcXuD+JnHO/gaX0oU83DnJiWenRF2yAkeEK
 06BBJwd6kRWXbzBA1mRb/I8BVkDRx20tZm5OXAMzXU4XGbCObcaL8RMSNqpZ0xSOeJqj4jjbBdU
 whM1ncEPKH96F0aRnWqDmOr1kF0OJcMHw+B2A==
X-Google-Smtp-Source: AGHT+IE4t7r5cfDtdoC1Uf9OpRk6OgcszEi4OnPK+c3MNgbRzst7ZPocD/KazS+UsN9Uxzq52nKGRQ==
X-Received: by 2002:a05:6870:46a6:b0:3c1:68a1:6b10 with SMTP id
 586e51a60fabf-3fda51f1632mr22047710fac.6.1767396227488; 
 Fri, 02 Jan 2026 15:23:47 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:47 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251216-pwm-aspeed-no-printf-pe-v1-1-fd7d1ca726b2@baylibre.com>
References: <20251216-pwm-aspeed-no-printf-pe-v1-1-fd7d1ca726b2@baylibre.com>
Subject: Re: [PATCH] pwm: aspeed: replace %pe in dev_err()
Message-Id: <176739622678.296893.1832797181870368357.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:46 -0600
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

On Tue, 16 Dec 2025 18:56:35 -0600, David Lechner wrote:

> Replace %pe with %d and adjust the argument accordingly in a dev_err()
> call in the pwm-aspeed driver. U-boot doesn't support the %pe format
> specifier. Likely it was copied from Linux.
> 
> 

Applied to u-boot/next, thanks!

[1/1] pwm: aspeed: replace %pe in dev_err()
      commit: 1f9e228c2fb739a000bab27d8e09312d425c2a3d
-- 
Tom



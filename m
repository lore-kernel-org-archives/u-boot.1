Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C5CCA0EDC
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A45B083A61;
	Thu, 14 Aug 2025 20:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hPzWva77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089EC83A5D; Thu, 14 Aug 2025 20:48:40 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA59A839C7
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3e56fc0f337so8224355ab.1
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197317; x=1755802117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bDfaVvv5t/tHhG/i2XFNx3+GHBR4ITU7suB0jR/V1xM=;
 b=hPzWva77ehyGNdRZsCBSplIHHii9vbI9mfDw99pBgF75ZY3b9nE39asNZ9zYyNPnr4
 7/+3/h/N6ffhhMXwQBWUcKursVOlFzb8CQXOp0KuKX8TVRayMo7Y0fSJArVXn209vNJu
 vTePqmsElVXHb3WRA3UcRrGj/wDUDfHJqTbwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197317; x=1755802117;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bDfaVvv5t/tHhG/i2XFNx3+GHBR4ITU7suB0jR/V1xM=;
 b=jEDeo8hPXjhiNFXQvdQXu1P6Xa/231Aw8aAfsG/6xsFY5seKnFOgU0/mldg5oWm5zp
 mOk4vGMTOFA/rfRALXT3IiK+PNQQj1Vo1X52RIlfmyRKSRDw5ylJaBpTBGfDOlT5YoXE
 /qihGSHJq/VT6RkZLvJq4Tm4RLRc4iUIPna7wToKOMe13x1Irdne0iuRvMhHVcNXzxWe
 oPFTo0PuhvZrSC6+9Iq3sKuaewVgnWxEAoSCC4yos2PGYbp+L+1vEsBgfsP+bVQA5sAq
 haGVsgUspQT83rk/EKHItAuD/TCkbp+mZng57pjMHN6iSHboofeCMzcNy404LB3toDVr
 DCeg==
X-Gm-Message-State: AOJu0Yw/C8ynY+h06AtM5PYAvgBDBAsDA1iH1IwY//UNOKzwiQSk84pn
 gFTXDUdfUgfNEN+OI6fv4zjtTD1J71t+djoZgF1kn4VHNAKllqv4N0Rdo7SK80tjpL67+/nQ/Wn
 tzOypPyc=
X-Gm-Gg: ASbGnctJkN+opYAdx+Rfchv2GT/XVjA7wroCTCMwWXDf+uUFutmMWWrZpu2JC2f/gqZ
 6XPv/oCeQzZVjZvEcOXVYS9Q1mb4GrVb5eBS7Zhc0kBCtoc8cRo7YmMIleSBNrQ4YRF7d+gm12Y
 G2YVLwEe0jgnxPJk8OpBBkKRAWJALSF+7OtJO8dg1kKUuMDZWbgPAchU5IZ9/g68D2v8FeVSlNh
 q5q22BvDxC/z26z6qhVcXzS/nE0wEajGa7gTNGpNiHF/gRzGIuM+VYPhIoMW0rLQR54MOPQWIbr
 y6Qcf+Fyg7RBEgSovj0B+4drN2toMBy2Vi4bph6gtdExkgleumaym9nemX/UDXW3BUxSW1u60Yy
 9RZHGwQTVq27vvZOdzPe02p7RcNvtbN96wDeLKL575w8vkRsuNYHL5zrLWIwRlso2Sg==
X-Google-Smtp-Source: AGHT+IFHtY7XNYB6OhF8OE1Yhz2vprgltn7KHe6woOYBS8r+K6ghh7JmJrLiHaqxNzk0jPJG3gJcdw==
X-Received: by 2002:a92:c0c3:0:b0:3e5:4326:d9cd with SMTP id
 e9e14a558f8ab-3e5718397camr63255145ab.3.1755197316662; 
 Thu, 14 Aug 2025 11:48:36 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250804215425.1412704-3-trini@konsulko.com>
References: <20250804215425.1412704-1-trini@konsulko.com>
 <20250804215425.1412704-3-trini@konsulko.com>
Subject: Re: [PATCH] reset: Tighten some reset driver dependencies
Message-Id: <175519731604.3600102.11956988757956404517.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:36 -0600
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

On Mon, 04 Aug 2025 15:54:25 -0600, Tom Rini wrote:

> A few reset drivers cannot build without access to some platform
> specific header files. Express those requirements in Kconfig as well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] reset: Tighten some reset driver dependencies
      commit: 0ae7725e874a65d86ccdc964048940a490185972
-- 
Tom



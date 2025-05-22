Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C669FC54E65
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 22:49:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D17B3831D3;
	Fri, 23 May 2025 00:48:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uSN4o+6e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 730F9831C6; Fri, 23 May 2025 00:48:40 +0200 (CEST)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 586EC83164
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 00:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2cc89c59cc0so240915fac.0
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 15:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747954117; x=1748558917; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Wq/bGq8ToDCRe+yltCakGYVxJyRckbJV6ch99dfQo4=;
 b=uSN4o+6e7cn5jXNhfHh/lgC4jsAjnIBEWwILJe4DyKEU0Sxn1iyW1zgPj+rMLj+eFi
 38XxHIGY2HADPSWBGTS9+cGwiQQco5knqGKXN84R451/XyAOA5CspeuCkgAKNEzTf8u6
 i9Mb4NCenclSRwA1LRDWNNDsp9qf8Aej5LUEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747954117; x=1748558917;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5Wq/bGq8ToDCRe+yltCakGYVxJyRckbJV6ch99dfQo4=;
 b=aC3/urWWXYKfiwl7TUEbv6KTg0gHzD+/9igVlQK4PGowUxidH2jLHOdNNoiegdYUfU
 rTvCEYMwq/0d6rBB5oHpF09LW5YlLJ7UsQmZ+zMaQuCbOHCdTrp1h7n6Dbnv9kshYpNZ
 4nU0HudcOc7ywFFB8rfH/uZH1XQS/FCnX8VY7dwyM1GnFXsSnLPHn4KLl9j+Y087osXB
 TDAIl0vn3P6zezVm7i3Y9dHIip8GUul7KUlGr8jOf6Qhvigzwif2gcjyNosTM6BcBZWL
 VrsG97T1vXA6e/pobKzGMtHRr41w66rH9KVcSaXPf1YQGXRlhxI8dVR05iSIZL9J0FEW
 WIjA==
X-Gm-Message-State: AOJu0YzX2P10GyTywNqKT7sN58ZfvR1WbdIP3tgq8lqH/mi8cRZLf6Ml
 wjqcGu/QDdLmzEQcfCLaAe9riFbX26GfAeDX5GVDS9JpSqwzebaiF72/TsOjYJ/j6ds=
X-Gm-Gg: ASbGncu8f9EZUfiDReobuyhXmUB11GYybvE9NK1cBpyzJZZelbk+JjgswMPL7aXn38z
 RjH/aIzuur1GVXcXjDyuE/Y6z/mxJvHrZ2/o8/MSB2wZfPXIe3grNrYJmfO+qHU4bJ1CrrO8pRZ
 gpRGCmVypwZBoEnpDl8Q6R917DZWCNEXwcZvgJQFSQua6GndCGqlR9US3tsLQiX0qChaBMydEY8
 xNXViEu1GfQQ8KAbeBPpYRM+ivNZLIghpFbKJK2020J/Y9n6/wAyfHaZ8CNJWsn6Ep91DTS2K3F
 WdMvMDellZ+0TY8UrsLc/TwBi6now3R71DOUXs6gTk29reM4Q/6zDJNjjWsalcsKrRVe8Om2h7T
 ITMu9qkKihaY=
X-Google-Smtp-Source: AGHT+IFDBNfRcYjXKfDxYbiUl2/Vy9kNY+Gn6qapMKDxMHeaCLupNZDudoJni6KI+LrVuDcyqAs2dA==
X-Received: by 2002:a05:6870:1710:b0:2d5:4e7:1cf0 with SMTP id
 586e51a60fabf-2e83e6960c4mr974411fac.13.1747954117125; 
 Thu, 22 May 2025 15:48:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c060af78sm3258534fac.5.2025.05.22.15.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 15:48:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, Sam Shih <sam.shih@mediatek.com>
In-Reply-To: <20250506081220.29918-1-weijie.gao@mediatek.com>
References: <20250506081220.29918-1-weijie.gao@mediatek.com>
Subject: Re: [PATCH] clk: mediatek: add dummy clk enable/disable ops for
 apmixedsys clocks
Message-Id: <174795411586.2210140.15049650979465735681.b4-ty@konsulko.com>
Date: Thu, 22 May 2025 16:48:35 -0600
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

On Tue, 06 May 2025 16:12:20 +0800, Weijie Gao wrote:

> Starting from commit ac30d90f336 (clk: Ensure the parent clocks are enabled
> while reparenting), MediaTek filogic platforms will crash on booting when
> initializing mmc devices.
> 
> The root cause is that to simplify the code, we reused the topckgen ops for
> apmixedsys clocks as they share the get_rate with topckgen clocks while the
> clk enable/disable ops are not available for apmixedsys clocks.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] clk: mediatek: add dummy clk enable/disable ops for apmixedsys clocks
      commit: 1bf212129768d65a47145209c65bf37b6082d718
-- 
Tom



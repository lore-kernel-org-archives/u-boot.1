Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EBAC02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 04:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9CB180815;
	Fri, 24 Jan 2025 05:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jhxO1tQ/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B205580780; Fri, 24 Jan 2025 05:36:21 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 948A5807F3
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 05:36:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-467838e75ffso23569911cf.3
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 20:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737693378; x=1738298178; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3g5lYNOIgyRTSqcpCEvBBK1GXxSF5TmS/LvlZ+Ar4zA=;
 b=jhxO1tQ/JFL6nuIALXBHCyaKkRphwJ1F9H2SxCFBFIfhj8/OwU2CCCXSbpN0/2NWk7
 nIwNsAyeM5keZr2xNzbKx8beZ98AjfrTX0ZI+xrd1P0TvR9Q3kMxyKQD5vmgOzOOXjvT
 pzZmlXDrbA68Vvzx4QVstmQag0cNV/Zq/Vmpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737693378; x=1738298178;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3g5lYNOIgyRTSqcpCEvBBK1GXxSF5TmS/LvlZ+Ar4zA=;
 b=iIxGOj6pqgYuuf9OYq3BdTpdukSv2Izu1RIo93LsEXr4ifxHFXsFgfzM0fSMf3BaXC
 0HPldxegbjCezQgTdtsLtNuTtemAjHoXPBDBXlbP4p6XQzWWiK/kgn4MhEyd2Ep9esOx
 ph7bpWI7kxNjzbs+b9P0VOkbbNdJFHTkVjflguu9qKyDj62SmP/dYhsiPzrtrZsJ5jPc
 TEK65xjgv0FbGBG10cDITa9d2vgzsAva9qqTQdVWB7nDQM1PG0axMQl6ZQDslMIxWkYF
 8oM/8YL6sQZwSyTyAEsYvfa/sZp5DLcMMZeD6kmuuAWTilLYM1XjatkVHcTGSIaHfg+F
 lqzA==
X-Gm-Message-State: AOJu0YwJi/dJkhCwUqfE5LkRdJ2JPvcjepvqWG00PmZc/uJZETRB1T7d
 IOjZWs7qvfF4oQinZdu4I8qIJTheZQtlYs8ElQ225D0i7tNbt8gU/GzfiKm4DCFhmJWHPFTXMAQ
 KaPU=
X-Gm-Gg: ASbGnctPFyiH4Rg+96SkfZMyU6cTVWGPWfUy4fz/hcs1tDixpru6cjJ81odbIAslEEE
 oKptJqGAM4lmLRFhVM2HQN58x8cpoNrCBWtPVrE66kxQ8KQ7TSwYh8EVCRX/1F34lAAM3ZXFwTE
 MqZt6nVTGibD2kgH1XAlgfO9CNJ13r8cLpQtyKQWGqon7687JBdXv0QQRvrJIM3SQIYJ/fqhS+V
 xefGm8Mk0RCSWNm1BPeRSYvV6tciHX2cgyLaO7M1YlUIhxLHyGCkTBgyR0k2BhxvkIfHh8Zl98o
 UbU=
X-Google-Smtp-Source: AGHT+IGN0IA+2yDKe3T0anPiwFZNGca/SmPfEqGJxXbpShWYxrpjcQeZVLe6Y8kUO3RQAAo3dvMeuA==
X-Received: by 2002:a05:622a:350:b0:467:525b:e540 with SMTP id
 d75a77b69052e-46e12a2c4f2mr410851461cf.8.1737693378479; 
 Thu, 23 Jan 2025 20:36:18 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e6689d9e1sm6142461cf.35.2025.01.23.20.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 20:36:17 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <cover.1736498083.git.weijie.gao@mediatek.com>
References: <cover.1736498083.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH 0/3] MediaTek ethernet driver refactor and updates
Message-Id: <173769337647.3052421.1020333338751038794.b4-ty@konsulko.com>
Date: Thu, 23 Jan 2025 22:36:16 -0600
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

On Fri, 10 Jan 2025 16:41:05 +0800, Weijie Gao wrote:

> This patch series will split the switch initialization code from mtk_eth
> driver into their own files and then add new SoC and switch support.
> 
> Weijie Gao (3):
>   net: mediatek: split ethernet switch code from mtk_eth.c
>   net: mediatek: add support for MediaTek MT7987 SoC
>   net: mediatek: add support for Airoha AN8855 ethernet switch
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom



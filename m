Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9969C02198
	for <u-boot@archiver.kernel.org>; Mon, 10 Feb 2025 20:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2B2480842;
	Mon, 10 Feb 2025 21:38:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kp2S/klY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BD83806FE; Mon, 10 Feb 2025 21:38:45 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DA37805D7
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 21:38:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so3732512276.2
 for <u-boot@lists.denx.de>; Mon, 10 Feb 2025 12:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739219922; x=1739824722; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3ulZot2cDR5/6vFVpPUWdB2quFJi/xlZGaO7T70wymw=;
 b=Kp2S/klYx+whOF+QalKBwl34Yb2/r6T9x0R0YJZNB/gBE0Pqpz7I6uHBK8VwYs1Dmp
 51mnT7zllaETJvdfmU/PgWmtmGdsu/0Nq28e6Q9QkaaQGnm8NynyK9qXBqTuQqlDEjLz
 8KWCuWakagUZD76x7pMuH710mMbSGgxkvKmIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739219922; x=1739824722;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3ulZot2cDR5/6vFVpPUWdB2quFJi/xlZGaO7T70wymw=;
 b=oo+S4YAc5XtZB6A77CGchbmAbkVe1/GgwaO17F199t8eu5tszTuzOv/2RtTdL94iwy
 sp/sXGDBio0/mF67I+IdGXbK8XGguJkra8ffWDzWVxbDR2o/EwXmRQJWDpA2TMbjs3sW
 IIShwap6R5Uj3jKSmTv4K/yXg5Qsa5OADODPcX1iImYit4cW3Mxfde4KvSaHmKoAUAEc
 TNHkMJvOPGI58W9RbOgc+qLF8+5sQal4366s1AEKROUTl9hxFUjF9+z3hxJzz7m0AASJ
 Yutv0vrSuv0z0x9Zwp0z9P1vWXNNYL0j6ly17Q3E6QM018WkJ1SdXtAdz0rz/rvdPkCz
 gZrQ==
X-Gm-Message-State: AOJu0YyjmrAxLMx74gRneNK3ztPNa4MNjsQ8lU4njcK/JBZV8Sb/lyM6
 hanRtOmEbY6vZs8/2+IL1hzMuai+ocnWjZx//GbDgobo9vwIvltV+MEXdzaXYYdNPUJ4o1Qi8zQ
 1
X-Gm-Gg: ASbGncsilZkQCGPUbU/NM1kpyMPw5tfJwAPIuoAa5CUWgqHa6AFsLeHLw6W9a/QTtd4
 o4gZNZzjS2tGKtUie1cBKAff24tGB06X1KRFl4eSBv901piAf2NnDX4vcPqbEwaHrVipTCmgZBO
 ZY94Xi+f/oeWYpQQtPPBqhSqnR98JXlLFrwAYW+XjzH7BVM/ejQYz8FNHjd+qIzFzOL9Od5hM1L
 GpLeprMUOb9M+VfkeRSIjn4pLwd7dDWc2VOk4tGP8VPhW5QxmJiQP9n7KBYsOdfwOBMC4MlUaB7
 gIXI0Y38lwWiKA==
X-Google-Smtp-Source: AGHT+IF4ptCjpOfYYG9MeaygA5p4FTRStnWbd/PgcYUgZWJ1+O8Kh3JP6MJTE4nQm6iKQzsBtiUf/A==
X-Received: by 2002:a05:690c:61c8:b0:6f9:447d:d1a2 with SMTP id
 00721157ae682-6f9b29e62dfmr157302947b3.29.1739219922365; 
 Mon, 10 Feb 2025 12:38:42 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99ff6a8d8sm18233207b3.79.2025.02.10.12.38.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 12:38:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Weijie Gao <weijie.gao@mediatek.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Christian Marangi <ansuelsmth@gmail.com>
In-Reply-To: <0c4eec2ca1691384863959e70f5451f76cbb963b.1738808158.git.weijie.gao@mediatek.com>
References: <0c4eec2ca1691384863959e70f5451f76cbb963b.1738808158.git.weijie.gao@mediatek.com>
Subject: Re: [PATCH 1/2] pinctrl: mediatek: mt7988: remove _base from reg-names
Message-Id: <173921992128.2921783.7241812335606682809.b4-ty@konsulko.com>
Date: Mon, 10 Feb 2025 14:38:41 -0600
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

On Thu, 06 Feb 2025 10:18:57 +0800, Weijie Gao wrote:

> The reg-names in mt7988.dtsi have no _base suffix. Remove the suffix
> will also make it match upstream linux format.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom



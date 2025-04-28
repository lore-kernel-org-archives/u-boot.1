Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4440DC369DC
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 21:34:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D168267E;
	Mon, 28 Apr 2025 23:34:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XNSOZUPc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88A2F8210E; Mon, 28 Apr 2025 23:34:02 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4914082132
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 23:34:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-72b0626c785so4568666a34.2
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745876039; x=1746480839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DI7pSMGW1DFFL+MmCXjjiVxykiHZ6RAucpo8YZxnfc8=;
 b=XNSOZUPcRYif7TLdIGSpAAGVS39wW4W6ebtG0gFuUQtBcQBh2ulKXR3XR7VWqcD1TI
 Emod8an/o1aBe/i7jnhgXxbeEKK5iYo0/gC2OhGxmb1IfwH2R6eWOpkbaWkQ9PR8x/y9
 rTqkenjMUEZQZIU6FFnF7Tapddj1hAZHUaMZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745876039; x=1746480839;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DI7pSMGW1DFFL+MmCXjjiVxykiHZ6RAucpo8YZxnfc8=;
 b=pArDrjr4LTxeuFfobobDbeKLm4pKqk+DCgjrER8PKZJP5KnnrNsMOgstBSanme6P+r
 7l/S2+Hoe9pp4uAqb9IqNBO4F7SJrPSJwUxJmQpkomnhajZGXEHI1YbAub11fa2egfWT
 JrccRc5AtwfcSLDLiOUX5LSUPP+MxUzZ9G6qIMVeFje6/FxHgHkiz/rEBRrphtXnDqwj
 lNk6ZQmx2U8nJIhdmcRB6XRde+FlBepa0wTfn1MnNNzyCEDZQ2ggKIkHfat2ex3hssmy
 T1FpUlKtHw7PJ/Iv+07Ya2N82UGayTvVPbT9JlB/OYjLarxqj12JqOcoVo4s4ERGK7cH
 tG+g==
X-Gm-Message-State: AOJu0Ywno7lJAGqSHS9U9QDP8i/DNEnzy5jLg+ygADMpVEiqEx5blxup
 gVdk3cXRc7a/zP98YXoxq/y9Idhl2P2sWN/8+VogldjrL+99HiT/aBzfStnGhvU=
X-Gm-Gg: ASbGncvFFgmBeTAxQJyV1LiTCsRIeVZ1h0OrA03rCmX6H0FD/zzfNwN7ODjpgoiDZ4G
 3/Yyrfv+9SYpQ+b0VmD8mw1JijyZwsWjr7h7JoS7kCibmcIPtQH/kc7rjIRff9lavFoddLEwRRO
 ota3Mv4oJ1lpBXqvv+sno5RXPQ+I+P6elh3sJ/n+CsbFdCKL8ErLvkcgnrgvCbf+bJhnR5aQCn+
 sPmlgp3rjbaabf65DOWk8RJ1CrBPSz9z2cs9WcR4pAVO30hFP3RqeLNxJLpmDWQBmHxuue7cWX5
 v5h2/awWP6RW4aQ9GfhHwXmRlR8nv5B1ph3cjKUMA2wMTpEyKxFUW5cafCDieFm0ScVBP0oYBdC
 V
X-Google-Smtp-Source: AGHT+IEEPOQ1jJ+jWbvbF4kkdQqYj0sfDmr7YrpUYiEUxuP4kJueuoMakfGMnrTZkP6owJsBcSTuzg==
X-Received: by 2002:a05:6830:43a1:b0:72c:10db:f210 with SMTP id
 46e09a7af769-73088b63ce8mr799181a34.13.1745876039058; 
 Mon, 28 Apr 2025 14:33:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b139000sm3108a34.40.2025.04.28.14.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Apr 2025 14:33:58 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: joe.hershberger@ni.com, rfried.dev@gmail.com, 
 matthias.schiffer@ew.tq-group.com, richard.genoud@bootlin.com, 
 c-vankar@ti.com, Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: u-boot@lists.denx.de, srk@ti.com
In-Reply-To: <20250416125643.2234165-1-s-vadapalli@ti.com>
References: <20250416125643.2234165-1-s-vadapalli@ti.com>
Subject: Re: [PATCH] net: ti: am65-cpsw-nuss: invoke phy_config() in
 driver's .start callback
Message-Id: <174587603805.1121500.2508933261479177479.b4-ty@konsulko.com>
Date: Mon, 28 Apr 2025 15:33:58 -0600
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

On Wed, 16 Apr 2025 18:26:43 +0530, Siddharth Vadapalli wrote:

> Currently, the phy_config() API is invoked by the driver only once since it
> has been probed. While this works in general, it doesn't allow the driver
> to bring the PHY back to its default reset state. As a result, the driver
> might not be able to recover the PHY from a bad state. To address this,
> move phy_config() into the driver's start callback (am65_cpsw_start()).
> 
> Apart from providing the means to recover the PHY in the event of failure,
> the implementation is in line with the idea of "reset and configure" that
> is already followed by am65_cpsw_start() when it comes to programming the
> CPSW MAC.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] net: ti: am65-cpsw-nuss: invoke phy_config() in driver's .start callback
      commit: 05dc050059d2759fde7134be06e5654ceab46127
-- 
Tom



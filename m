Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60F0DC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 10 Jul 2025 22:42:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B198836F0;
	Fri, 11 Jul 2025 00:42:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HfITiPnD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B1B5836EE; Fri, 11 Jul 2025 00:42:00 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC98835C9
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 00:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-611a7c617a7so447499eaf.1
 for <u-boot@lists.denx.de>; Thu, 10 Jul 2025 15:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752187316; x=1752792116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyMjIXJoAHmum+9Lcx6mjxZ56ipnAnMMfN5oCZ6HHEk=;
 b=HfITiPnDFaRDpNdDfFjjocMr3voRwjMOAEJSpP8JqnZx8KJfoKmxxtNtDJXYckfAY3
 raAFKZaGTSEqxo4pl6O9/8z2PvhOOr5GRZd63RkjO3QyXhFGVahdcObThUKNi8jUg5TA
 +lTItTGTTND/Hs8lOQjfwWOSBU5yduSYXa09k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752187316; x=1752792116;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyMjIXJoAHmum+9Lcx6mjxZ56ipnAnMMfN5oCZ6HHEk=;
 b=YzzLYfJ+LXtwxTFb+C9IupK66BqNCV3f1iaVyYlUmuVweIKHTHfoN/UYG8rB8lYCgN
 gJ99pQGPOeeDhJDjEktR736XJQ8gMEAkeChCtELroxe912pJ/f2sMj7/ZZF7W6BHhwRi
 GV+CcfAJfc+9zk6uP7c+UkE9rrDlQopvJYMWRC2gVxx1VVf2u5+lmKLeQYcEA5WehPi3
 1Eg0sAtpjvXWW/TvMwnI8sKHrBA/alfD6hEGrK19cPJuZJU/TwKCA0EAoMbmdcxizE4G
 jRajZF32nHU3UhXUwAioOxX5+xSlahVTV8rtGoefkrht4NsZ+azofjqXFa0QvJicOeat
 2DNg==
X-Gm-Message-State: AOJu0YxEAjPP1MkEBKsbYU3m4CXLzOUa4mfbiCDF8BxHrRL3TRl3aQzU
 eBq5rYGlE7ep5EP0le8ezBBDu0mmb7N8hLVjYJfyl+bCQYhD3BP45mXrY1Gj315+Ylo=
X-Gm-Gg: ASbGncvFFbU9wg7pFLSvCez4YU2gJil5bnTMrEz3UIb0WFz6DPPwn4JsnTJ9v3uZppw
 cetwAACmUe5g3Oxq/FWp89IpBM5FKXeeeGXbiCmnT68uDs8X+EpxfBzwwLDeM6FIsg5taB5DxXT
 X0F7Lc1kGt5+eah0klaEVQi2Fj9y6vJmcjMdf/MhIsrZL0rSJPVQJmJJowHt7zt+IxCm2Dd5wgZ
 Z5etcnjnRNuWOpL1lRJo/Lb/VQOCeeGwMgDs8D/4zdbXzILNR/SPs9DsYXbSu+gf93bs9gzXxKU
 anXI5T48EtY2GNmT8xUTZPpNhkw1HMZazvkA7MkW8DKS4ulg7ZlIqoCMPclj+JVQ4dI9/XVpuJ/
 l46hThUGEWMaYLMHf3iQl13TNgo+Bzgq6eu4R9tBChYfInTvxwKXb+GqZN5K9e4iVVw==
X-Google-Smtp-Source: AGHT+IFUM0c2GAsFrE89fFXchnHdz1P1zrok6g2Qe2GrecXQJu6Oi6a1W7XXi4IKy/qNFBGR/huDhw==
X-Received: by 2002:a05:6830:f85:b0:72b:9e3b:82bc with SMTP id
 46e09a7af769-73cf9ea0788mr984667a34.11.1752187316567; 
 Thu, 10 Jul 2025 15:41:56 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf12b745fsm357354a34.64.2025.07.10.15.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 15:41:55 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Cc: Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>
In-Reply-To: <20250701044923.7410-1-nareshkumar.ravulapalli@altera.com>
References: <20250701044923.7410-1-nareshkumar.ravulapalli@altera.com>
Subject: Re: [PATCH] drivers: net: phy: micrel: Try to get phy node from
 phy-handle
Message-Id: <175218731540.2073260.15188578213282869956.b4-ty@konsulko.com>
Date: Thu, 10 Jul 2025 16:41:55 -0600
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

On Mon, 30 Jun 2025 21:49:23 -0700, Naresh Kumar Ravulapalli wrote:

> If phy node isn't found in ethernet-phy subnode, try to get it from
> phy-handle. And when this fails, only then use Ethernet node. This
> fix results in getting correct phy handle properties for the
> phy node if defined.
> 
> 

Applied to u-boot/master, thanks!

[1/1] drivers: net: phy: micrel: Try to get phy node from phy-handle
      commit: acf964c4758e2a60656a385f27dea0250fbbe7e6
-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71CCBEEC2A8
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 22:48:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C4B983BC9;
	Mon, 23 Feb 2026 23:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iv8EPuBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8C483D8A; Mon, 23 Feb 2026 23:48:28 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B796D83BC9
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 23:48:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-4645dde00a7so1605981b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 14:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771886905; x=1772491705; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KO6awyEgikm+X1QVHLpR8Fu2J3C0kskOnPd+G6bvHv4=;
 b=iv8EPuBOMK50SUptgHaZlmnmjdoqSN+nsUSk2s4m3IPo0pUPmJfHU1OZk61uS8fpJl
 vs4sucCQ++gsMl+n7y3ScPGC0h2o0kNdTJzzOnpK1QTltO83D/scbCTrCVtAV38HW+wW
 gTPBs5ffpT4bS79LQaGiLMt1ScjEp0Gjvrl28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771886905; x=1772491705;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KO6awyEgikm+X1QVHLpR8Fu2J3C0kskOnPd+G6bvHv4=;
 b=KPL7cPEai7+f1AkL4S8KuKRkVd1OFlx7oKO/fiCJvnepbHZu3BkwRJnOK8Lnbr3Rwk
 MLucvI9jbrwVyCOS4XTXd0fEGrOL1JvhALxhE2KvmfHDXQp6ZSQxXXFIVeDoOwRl456k
 n0j1IJ0igwCYl7ZRUx7PRTcRMufrpa/72DqxCK6y4qaXkZ12xbukktfJEApLBAnK8dLB
 j14hXN4tD681PUGnM+Oqx5+r/AuV5ufjPByr+6my79e8UabRlJhjvXFU85/nLYieLWiJ
 W+i8rTCIQc9xMzmCF5E98vOemu0DviUNFjGvrTrR0ZXkGqRg4TKGkhrVph+xrQXLN9Un
 6/uw==
X-Gm-Message-State: AOJu0YwG22uRk+YuvLHGl71LGYRzV31n5NssN1hwyv155m+LFZIQhTRb
 0qOjh1SbMTWR6PIp7adA7Dx/ezqH8iTFgOIlBNMVsQdJHnBU3KkINpApe3xTWqrLUGw=
X-Gm-Gg: AZuq6aLr0GkkWuQW+rSNGY6qxmjj1lb/CrF4c7fLwUHrYf+a7HL6V3GrCgpYrwd8ABd
 rOSj6FSsTHNv6CPS9qyxyyCeRQ1C/7mqN1UgpRE61iCjrX4O4HJyQ+LED1hSZWkBo7IE14F2RcJ
 fD90GqD9WBW98LUeLRxcVGpj+E+iWol90N/AcxDplK0HuKJ3K91mRei+oZ0gvqu/UD2xEarY1Ep
 wKouPjnlVoQ+ciI5Ux/49qiDlwWY+YUceIgl2KYByb41gUBL06tND8o9i7aBo10P2GETiU/UpnV
 fSSvvDMG5JwGoE5fF/9XEfHh2b/e/SiknzVQzezKAHbic6kV5Ae2yqswQGq2zWqQEgQU7QyF2FD
 fC/piCMC6HbVBTIbNanimBjSdiVd1y2ME04ZtSXEe/Gdt6DVYryo/Elbd5FqiKJ3L3M/ay5lIoB
 04Y706UV8H7ch7ci3JAphJholhihEXrzcPS6fy4mhCkTmIJIqdEUSClaBu1uV7YdycIZXuyUlmK
 6frNJw3dGH0mEV+XLTRZ61DgoohkCqMhAS3mF6Z6VhfjZWsxQ==
X-Received: by 2002:a05:6808:170c:b0:45f:961:9f83 with SMTP id
 5614622812f47-46446ff248fmr5974737b6e.5.1771886905419; 
 Mon, 23 Feb 2026 14:48:25 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4644a17aea2sm5929413b6e.12.2026.02.23.14.48.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 14:48:25 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Christoph Stoidner <c.stoidner@phytec.de>, 
 Dominik Haller <d.haller@phytec.de>, Fabio Estevam <festevam@gmail.com>, 
 Garrett Giordano <ggiordano@phytec.com>, 
 Gilles Talis <gilles.talis@gmail.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>, Peng Fan <peng.fan@nxp.com>, 
 Stefano Babic <sbabic@nabladev.com>, Teresa Remmet <t.remmet@phytec.de>, 
 Wadim Egorov <w.egorov@phytec.de>, upstream@lists.phytec.de
In-Reply-To: <20260211221135.1738981-1-trini@konsulko.com>
References: <20260211221135.1738981-1-trini@konsulko.com>
Subject: Re: [PATCH] board: Correct usage of
 fdtfile=CONFIG_DEFAULT_FDT_FILE
Message-Id: <177188690418.4021327.13394786609588062571.b4-ty@konsulko.com>
Date: Mon, 23 Feb 2026 16:48:24 -0600
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

On Wed, 11 Feb 2026 16:11:35 -0600, Tom Rini wrote:

> As explained in commit 03d2d5fc003f ("board: sifive: unmatched: set
> fdtfile with unquoted variable.") using the syntax of
> 'fdtfile=CONFIG_DEFAULT_FDT_FILE' in the plain text environment files
> will lead to extraneous and problematic "s in the output. This is fixed
> by using fdtfile=DEFAULT_FDT_FILE which was introduced recently.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] board: Correct usage of fdtfile=CONFIG_DEFAULT_FDT_FILE
      commit: 8fd76675efbe7af785ccc1ba1ac8b9f7e10f6715
-- 
Tom



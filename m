Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EB8CD8CB2
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 22:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F597848D7;
	Wed, 10 Jun 2026 00:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l178AX97";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCB5984994; Wed, 10 Jun 2026 00:28:20 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AB258486D
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 00:28:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-48611862583so3079767b6e.0
 for <u-boot@lists.denx.de>; Tue, 09 Jun 2026 15:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781044097; x=1781648897; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TATR7A+Jf4Llfo8vRjlzu72RTl7oxpJmIgcmTOqtpXg=;
 b=l178AX97C5toJuVHx+NFmbkfr/449iEd25eKPLBmZPZ7kx8926nuDSsviUhxwayLhW
 fYCSdDH1j9YJfCb4sno4nsvyP8hfk18HYFIrPAtJF9NZcArSPou2ufk6/qD1wAsCAykC
 4hs0Idc7VRw8Ig95ShBkscnAdDvTY5wQ0vNwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781044097; x=1781648897;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TATR7A+Jf4Llfo8vRjlzu72RTl7oxpJmIgcmTOqtpXg=;
 b=IBuHjjlamsjbw2dayJxHQmre3waXzAk1wwSkKN2+k4ISxHdVPPr+lZQcxAmsYY1tS3
 cPUrQllG+hc+Xm/lvxnbDAdJhrO39QeCQJbumvG4AAII5hPC5k2AD8tK5RMid7WeBdiH
 VQdKdFrsi+RGUt901iEeI9mxsX9yGxqUyRHNnLlPt7oTGxpwMnf2fdE9AGVjnxUmUe2l
 iKg7baxvGIbhaxDDZcRYiPhTcslWbyieC+6TQ7S2Zz9Zxcs0BxAJ8D9Dw6t+7Q7zfzAu
 33u9308WjM5ZksSUuQ/I625uQW887MBVKsStHDXSL1knOyGe2Wht6M+qLrLINVSqnSRs
 WEsg==
X-Gm-Message-State: AOJu0YwR0/92lEDNO+C+e0UoW0scMESf+nS2HmSblgGRYrsMxi/vuuQ7
 oNbnbSZfQf9BM95+Lvf3P8CMX7VIiYg2d46sd4y2ewQVU2P8G3yjzH7KdNKTQGvlIow=
X-Gm-Gg: Acq92OEDrwEZ828otnyfBJA9rnDj1MFupFa0ZGEoGTl2KsZDyFHnbi4ROf0jbrd7rCJ
 S6qJaR8+OYoSW7JLOxv8dfv1iVlpbXgW9hxF49V/jeJQCRvL2FFwLDrDrFxE7HM2OIJ/otNO4F3
 PGttnNAqbLsqEMyyjp6sSM9pQQHRKNsVLjZDdwXYl1vfBcJ4lWphhjV5PmsJYmHy3B2tEji8lGm
 rIcOuV3klPUfXDI91ryeZWecWN+wKjYJhvVWJcMx1FlQoW/tXJ9oZiD2/xFJPLHf9NHXnbMvd7x
 fafBCnwy7WDDGQRgAg964Dl0oAVORazuuusYeuIt2DhchMysencOhQkGW+DRdQmoPUwp8HInQbY
 oqWR7u5igyu5evRxhqXA99EsOKitOJkRUMnlmus8PlNArQwpIY4JVG51ULgDr/IX3gpIZLHIKl3
 Cnj62sByNSKOUEnNyrx0I+DqJgPTbSbfAI60CoceuD1/K7W2KD8OGrEarrH08fumnuh969hihRv
 QhOd5jjaFxZhk855g72DgJgd1gnAekHE/tTR4MMMPtirskpRy3uXyrtjeSZ
X-Received: by 2002:a05:6808:2389:b0:486:447d:da86 with SMTP id
 5614622812f47-4868de9eb63mr13487755b6e.33.1781044096843; 
 Tue, 09 Jun 2026 15:28:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm16790962b6e.8.2026.06.09.15.28.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 15:28:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, uboot-snps-arc@synopsys.com, 
 "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Lukasz Majewski <lukma@denx.de>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Romain Sioen <romain.sioen@microchip.com>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
References: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
Subject: Re: [PATCH 0/5] clk: Use device API to replace devfdt_ helpers
Message-Id: <178104409400.79918.4465820132875469027.b4-ty@konsulko.com>
Date: Tue, 09 Jun 2026 16:28:14 -0600
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

On Mon, 25 May 2026 11:10:17 +0800, Peng Fan (OSS) wrote:

> The goal is to remove the direct usage of devfdt_ APIs in drivers. The
> device APIs supports both live device tree and flat DT backends,
> avoiding direct dependency on devfdt_* helpers.
> 
> 

Applied to u-boot/next, thanks!

[1/5] clk: at91: Use dev_read_addr_ptr()
      commit: 54ed5729a95bf53ceda7345e4e3839e2f4e85eab
[2/5] clk: altera: Use dev_read_addr_ptr()
      commit: 179022b8e1985b7fb1e0b454d86b779d29720d83
[3/5] clk: aspeed: Use dev_read_addr_ptr()
      commit: 48d74f433e4ff77bdb5a5500b141db07e609ca15
[4/5] clk: hsdk-cgu: Use dev_read_addr_index_ptr()
      commit: f683a457b65d4fd002f659ed0fb925d23252a346
[5/5] clk: sophgo: Use dev_read_addr_ptr()
      commit: 55550b429291b7c46a65a1864c49f25c2ed1a6a3
-- 
Tom



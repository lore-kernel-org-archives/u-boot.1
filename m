Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA0FCD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 17:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4217E848BB;
	Mon, 25 May 2026 19:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ol2Zo/uN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E68D848D2; Mon, 25 May 2026 19:01:25 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CFD3848D2
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 19:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-47c35be02fdso3541451b6e.3
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779728482; x=1780333282; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DjzOWkXG5yVhUUle5aaEMaJqeTqG3XB8ReAjcDNYIg=;
 b=Ol2Zo/uNX1pO+wIdCtly8WeqGZgN9DvE6Mg/wALawrcXgtMrNKR148ilLycSrXQPs3
 xuErRzumPNbjebsn11uZs4riZx0eFranETxYbsyBR9msHx6ewy979ozqt78HJy5ZSQpv
 /9oUGrAqSLCLtW3m6NHkNMG/IlYQgdcjder9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779728482; x=1780333282;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8DjzOWkXG5yVhUUle5aaEMaJqeTqG3XB8ReAjcDNYIg=;
 b=gbcoTcV5ZT0icqymH8ggCeDUZ/hLrX7IBSnUz8IR7ASA48+QHEymht3sNADQmfaDWR
 5lAwmyojp0Rb9Y0tsAy2ZZJbasAbg+3rZQ2lUrjTS8xVXxwvjqHfDCm+bCtWXaURS252
 1iytjN4HIKns3u/iqIXNpGxWn42dMbIvipm4XMEAfiyiNovT0ZWEg6HKes5BXpcbkI2Q
 Q57HqNo+DArM9qy6ezjPixBpKySxCwSgN+dI1CNHU7CiL4maWzRyBbLFvbNzw11yJqv/
 /vd4SvSQL1tIXUUfjQ8wuGDcjA0a/Jd86gA8cE/SzXhvKUvYYlPzjgI3IJW9WHo/uJ4N
 uvxQ==
X-Gm-Message-State: AOJu0YwHnGQL2AOl5HD2qurjSriuXwjvD4K3O5Vd1sf4wOIOaWXDkMN8
 TQQdLnUgK2ks6z2UuDBUdGExTU9EFt/+Mm9VD5SEO42LZJiZwQ/o86Y1IGCYwT6titl3Y5ecUeK
 ObelyFZ4=
X-Gm-Gg: Acq92OF4p7hd++6tf60AjEq07LJo/v8ZGK9wgjdxjYb9UdGdvzM8dXa6JU8EEOYIa38
 LhwvnmtGWvfl9J36D7I7CkAzY6B5knrxvN0l3f2G6u3stGzxBBLu7Bx8C3eFg1ChRSg+veSY9Dc
 eCeBkBEV8GI8HebLJ+/l6E/ZrxYTC+p8QyXHAvIeOxeT11ry3SNRJgpm0rvYSRyOHJiG3NSqWZp
 VKwXzoNHM0c8VdDaf6pSAttXhQzp3JidSWsobsvD1l6ju7Nc62RvPpaidn3iA6Bz/F/I52cHRg7
 F984MuafrxRg6ji2trHNEb1WHXkE/o4BDWsm52Sy+SoPLuLe9y9CvRYblmpOC6xO8DE9J1imv4o
 iTaKtHEYp0AevB3dO+aRLDnMD/ZTZ9IfOYDeodyFVTVJ5NYUMHpY6vkM31aRIQ+nodPWusDu/JD
 C2//ofx9U/i+VnJ+uBU7Wx9+PR32B/qnrljvWoX5nm5DUfQyiIbyedtTrD+DiGslUDPgTFaHcV5
 toL18a4EB5bvxvZ6Q4vB/tHlzD2uyozOJfi5ZCxXeoeONIF4X1Udec=
X-Received: by 2002:a05:6808:c1fb:b0:467:2652:b29d with SMTP id
 5614622812f47-48549d022dcmr10272048b6e.8.1779728481787; 
 Mon, 25 May 2026 10:01:21 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-485546edd14sm4993136b6e.10.2026.05.25.10.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:01:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mark Kettenis <kettenis@openbsd.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Moteen Shah <m-shah@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Wadim Egorov <w.egorov@phytec.de>, 
 Chintan Vankar <c-vankar@ti.com>, Suhaas Joshi <s-joshi@ti.com>
In-Reply-To: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
References: <20260520-am62_firewall_exception_fix-v3-0-9ca3dc40aea4@ti.com>
Subject: Re: [PATCH master v3 0/2] Fix speculative access to firewalled
 regions on AM62 SoCs
Message-Id: <177972848037.683406.6142292585524802797.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 11:01:20 -0600
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

On Wed, 20 May 2026 08:21:48 +0530, Anshul Dalal wrote:

> This patch series fixes firewall exceptions observed on AM62 family of
> devices due to speculative accesses made by the A53 core to secure DDR
> regions.
> 
> For testing, I had used an AM62p with the following diff to enable
> logging from TIFS:
> 
> [...]

Applied to u-boot/master, thanks!

[1/2] arm: armv8: mmu: move mmu enablement out of mmu_setup
      commit: b53128d5283d63d749525895b2a38b558d843ced
[2/2] mach-k3: enable mmu after reserved memory is unmapped
      commit: 37e6b640ef6177b79021190e3dfab13b465bebe4
-- 
Tom



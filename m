Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC8EAF436B7
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 15:52:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3521684246;
	Fri, 17 Apr 2026 17:52:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="V4Kl8uQ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE745842D2; Fri, 17 Apr 2026 17:52:31 +0200 (CEST)
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com
 [IPv6:2607:f8b0:4864:20::241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0563839D9
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 17:52:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x241.google.com with SMTP id
 5614622812f47-46808125c65so320723b6e.2
 for <u-boot@lists.denx.de>; Fri, 17 Apr 2026 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776441146; x=1777045946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zEHcK4uuvXhvsarHfY2kTyU2CQwLgHFaKhQiLdGVpgY=;
 b=V4Kl8uQ4WsOysEwas2i9buk3+JmRuufLWA3um+qx1+EVnMEtYQLWlPZJmNHgFfNRGi
 7ZsmeSIL/9iUfrtajJU3B1NkAMwcZaZqgL6Ebw/oJ+ENcGUuzF0BTkFInpSHVDXtJr1W
 7B3E2bNFfKIDT/hi1PP9Zl+sXhsItOpL9V4V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776441146; x=1777045946;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zEHcK4uuvXhvsarHfY2kTyU2CQwLgHFaKhQiLdGVpgY=;
 b=biJA3h9j2yyudM41Jjx6X4hXdJdFGfOK52VlSOrCGhhgV4QQncC1WtOjYrPS1oNNcT
 CLiHqbve1BgxLRot11VVYGQPTLzn2gtYWr1pGVob5EblIsj8odcl5ZZ8hnColTEuYd4+
 M2UUYuusKqbpHTAFMX7taKvgxuxT7nOivEPb3HkPSAJDPCbpe2uTWkfJiTPFVD/TAgDg
 EEbh1TalfJjQKjTQAn2VdG8eVY6CEnWCwCNkrMGuruxyRdjRTG+T2BhzTWA8yBMeExgl
 vTVOBSVeC7qkViso47+Uot/nC/0+kpmFmNHGBMx9x7PWzFkRmfFo+KIa/ccLQZ6DQRBa
 ALdw==
X-Gm-Message-State: AOJu0Ywg6CXHzCJGnQ1N8nzP4vMsKpNH+1JwynReqCC3eAOuGj2x4mTz
 g4sr9MCNXqukMk6+jjjuIxK/UfSNRoTo6pNyccL2k1JGx59Chlr+HXOV+SUF2/bzKJo=
X-Gm-Gg: AeBDieuPNFIzHHdmd2kqATk7BxpzERizajKy4YYS2I7qDfF7G1mWJN2RTum6uA5NaDl
 mT5OCjOJV6ZC67ULDYFMPny5igRtUsUmzs0JLuYaT40m2tKj2wD6ICIjpGVPC95CpP28mf2BxhX
 QSTzxooVk2TQlLlHj4dB1wBj7xSTTQzyINNZk7B2xceYsLsi7tD4gEGXsaUEOoqqyeLv+rIlLSZ
 oPJSM7pgLlRDPYk6so23rMLy7y6Wo29Q5RkGX6cakJmqSr5EPU7jvkIOhVTJNchdpPUXhTXYDCY
 LsqZRVhCA1oet6aTlGZNu43Xag3RLsldCPpF+5NM1PovPmnBi+LFt2M7tAu1QRpAPAcsEQWa3ub
 WpZ5pk5ne+KQGKpztsVgLaHBXNoLLlHm5iJpZbkdVVWyF3XvPP7+3BzSPAmR39fBvgoVwjyKR+7
 8o6Id1CbPydPFc97nB4wTTQLJu0ZS2ZPA8SJCzAMO+Jhvcimu20KvrDgta+83aK9lN94e0PX2Gp
 8qWseKpHdokM8Y7CSRpQ7iEqKoVW0munSB0lLqIYea4MAyJGmQWn7NWB8bq
X-Received: by 2002:a05:6808:1511:b0:45f:318:ada0 with SMTP id
 5614622812f47-4799ca8c451mr1431743b6e.22.1776441145860; 
 Fri, 17 Apr 2026 08:52:25 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b934a1a38sm1684214fac.11.2026.04.17.08.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 08:52:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>, Jagan Teki <jagan@amarulasolutions.com>, 
 Vignesh R <vigneshr@ti.com>, Ssunk <ssunkkan@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20260205152002.3384-1-ssunkkan@gmail.com>
References: <20260205152002.3384-1-ssunkkan@gmail.com>
Subject: Re: [PATCH v3] mtd: spi-nor: ids: Add support for Puyasemi flash chips
Message-Id: <177644114482.690930.9486251028702381048.b4-ty@konsulko.com>
Date: Fri, 17 Apr 2026 09:52:24 -0600
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

On Thu, 05 Feb 2026 23:20:02 +0800, Ssunk wrote:

> Add JEDEC IDs for Puyasemi PY25F512HB, PY25F01GHB, PY25F512LC,
> and PY25F01GLC flash parts.
> 
> Datasheets:
> PY25F512HB:
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash%20%E8%8A%AF%E7%89%87/PY25F512HB_Datasheet_V1.2.pdf
> PY25F01GHB:
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash/PY25F01GHB_Datasheet_V1.1.pdf
> PY25F512LC:
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash/PY25F512LC_Datasheet_V1.3.pdf
> PY25F01GLC:
> https://www.puyasemi.com/download_path/%E6%95%B0%E6%8D%AE%E6%89%8B%E5%86%8C/Flash%20%E8%8A%AF%E7%89%87/PY25F01GLC_Datasheet_V1.0.pdf
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] mtd: spi-nor: ids: Add support for Puyasemi flash chips
      commit: b6dbbfa71e4b47b759201cdc0c973b8cc0b5814e
-- 
Tom



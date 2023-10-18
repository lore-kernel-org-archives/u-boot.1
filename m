Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF34C46CA1
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 12:31:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8223386F86;
	Wed, 18 Oct 2023 14:31:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gLGftSHE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491C386F80; Wed, 18 Oct 2023 14:31:13 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD74986F8F
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 14:31:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9a64ca9cedso6901537276.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697632268; x=1698237068; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aaokkrAYrQJnlDtERNABpaJpUtiASdHdj3zc6vCjit8=;
 b=gLGftSHEXsYGeLazne/6gHYNfDibFjGrbfLx0WZibDOHvkPSLL2xr2P86rfRKThBkY
 QH+0NaIyCRZkIa0lyjtMKhTBmtzVxb/LmgbgF7eQCTi3qdXne4w4SbmUzSO5wo0odnl1
 /jw8lEqbyTQJBFTVte3SRlWB4gxHjfS8QYzYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697632268; x=1698237068;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aaokkrAYrQJnlDtERNABpaJpUtiASdHdj3zc6vCjit8=;
 b=VpBMuf11tnG7wf44JdzzOZI29qBlJ9kpXJSL9DTsIAh25hEjUqtSTpyKGmskqt9KWQ
 YF+D8wT9Fx91h/dxz2GTk+pV3L5ss1vTETwvN04P/OM0SBs1gy67PDzCTcdI50giHPZt
 eBUzbhPnIlgmEia5Keo11ajXP8RatYr79CdYubNxSKCEFpN2Jnh58e2U0yS2XRrtAMfz
 UJDK2INI6H1KCIXqhwh1t5D0TPa87csdBaeIi7IqMbF0UR5MccgdOMbp94RwgQQUmCaC
 t1KtiI0T+RbokA7NS0bSFoAOewh8Uivq77iU+bdqwViz5H9EY8z+tft7hjIZGjlvzc2x
 zzFw==
X-Gm-Message-State: AOJu0YzSp14xJ4e8tb+97R9sANEU1Sfs9JwEBG2NAgD08lwIBe1+2LjG
 o58XcYboQlFWxYsVaJTYMoqGzr2hT/rXAYfphgoUjw==
X-Google-Smtp-Source: AGHT+IG1AZY/+ftD4iwiNypNF5zQX1c1AZryFxDKhi2MQWp5kCBJalenEHXbejuXeYJ0bpGjrvgkhQ==
X-Received: by 2002:a25:860b:0:b0:d81:504f:f879 with SMTP id
 y11-20020a25860b000000b00d81504ff879mr4500737ybk.28.1697632268449; 
 Wed, 18 Oct 2023 05:31:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 a36-20020a25ae24000000b00babcd913630sm1266904ybj.3.2023.10.18.05.31.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 05:31:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Sean Anderson <seanga2@gmail.com>
Cc: Harald Seiler <hws@denx.de>
Subject: Re: [PATCH] spl: mmc: Fix subsequent calls to spl_mmc_load with
 CONFIG_BLK
Date: Wed, 18 Oct 2023 08:31:06 -0400
Message-Id: <169763217636.3660183.9341638694987120527.b4-ty@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231008014748.1987840-1-seanga2@gmail.com>
References: <20231008014748.1987840-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Sat, 07 Oct 2023 21:47:48 -0400, Sean Anderson wrote:

> MMC devices do not have uclass platdata containing blk_descs, only their
> child block devices do. Fortunately, we have a function just for this
> purpose. This fixes subsequent calls to spl_mmc_load.
> 
> 

Applied to u-boot/master, thanks!

-- 
Tom


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D102CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:36:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81770846F2;
	Tue, 19 May 2026 15:35:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aUv0aoP6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84487846F2; Tue, 19 May 2026 15:35:15 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74ADB846FD
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-47c918c62b4so2340052b6e.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197711; x=1779802511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2issYmjxjf6pB5xwwzP0MiTQ16oEaffB7r83a2L36Nc=;
 b=aUv0aoP6a9DaeNWZQOhg3iHdd1UMGKzXg2FM46EfzCriGqe8WXziUzB2XrXNaWUuvN
 zHcV/+WNrmE0BESnyVbQXGd2Dv22j3SelFHFxGhrJ+hYi6fh9rZtrQgAMqpfDnZV5H60
 IThWCJNI7wDJOaZYxOj7tauDGRHBFADHTrVes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197711; x=1779802511;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2issYmjxjf6pB5xwwzP0MiTQ16oEaffB7r83a2L36Nc=;
 b=P1g74e1i+Nv8CxVbQnbPqMgpDh39b+eJTnvGZDtnOUNogZkXZxY4wLlxezOzYtaxM9
 7ssaGR+/zWAmqNstxJaaqFLkOXWwVAtm8R0CnR2gsBabHJx+HKJZSgcJxsbHb9ugML08
 zZUpfKa+ed3vhL2X0Lq5hdall4Si6MeKsFihIDARAh2nBCTOk5PvfvyBA9khYxpt5iWk
 Elm9D5yWJbingSkYUr+e6yYOz1nZqvZFqJgHI0Dp30B3givrw8W+XpprAnsDI1tPp+Yb
 wBL8jueEH3uTqEWUuA4nvZL8RBiuIuOpGlciJkR8QXTLdJLmf1Yr66sNDHguLc/FcIhI
 OSCQ==
X-Gm-Message-State: AOJu0Yy4p1s85JZwy5fr4g9NnYCXNzuV+JJk0TaUWo5WclnKDRxlCtAD
 n7rL5UR3u8w/jo4NSbh7qZ/U+ZCtH8Z7sbco2Y4zLCn9AidMEa5U4alutWgOlyk4F90=
X-Gm-Gg: Acq92OHTPD4aVZOTq1DOCTSyEdWttN4UpQvjGHdAsqdAoFYPA8gCpJgspkt/c/xZhcT
 7dWnyRQE3PEDMBhEi47gDbA14+85snIjv/8QTWmAwrnQyVaZ6kdofxqJCxj4ZCzq02TUAidrozH
 dBZU4UdQyYGpP3CsjqOux4wHSqkxFAvFaoL8vRs5yQZx1Gy45wJmaE07bD0NP+KwzdDnkMH/DIl
 BvcCO6xYRmKfK7oN4wCLBJiyjSSxVDEoRKotHmfXhF0sAbYcbPRDNz16DLodvLLH/Zm94/1e0OS
 08epj4ffc18etvJIcBqrVfDEvE0pjE2CzBDhEaL2b3YGtwiNI30HN8/67RKQ6TSxEyXG/MtIYVF
 ZUa3/rG3iyEA0n5BqfzTczCURIRekQdmeFFsoxYY7Obvz1V6s3BvoqY4esadmf0fm8ZwOwPK3h3
 SBRgJ1Yad1davja5Dp4q+q7FtL1r5g6eXxSr11m5mFZsIle8dmWp/p/0GeMKIh2TEtHdxmYFmoL
 Nsg96we2lrjfIpJcu4iMKpMlw2mta9GDL+zcObxfeZNAXyYSg==
X-Received: by 2002:a54:4e8b:0:b0:482:49ed:9171 with SMTP id
 5614622812f47-482e57c999cmr9436265b6e.22.1779197711138; 
 Tue, 19 May 2026 06:35:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, 
 Ryan Chen <ryan_chen@aspeedtech.com>
In-Reply-To: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
References: <20260509151308.23067-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH 01/14] reset: ast2500: Staticize and constify driver
 ops
Message-Id: <177919771033.672258.10562373463087493323.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:10 -0600
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

On Sat, 09 May 2026 17:12:24 +0200, Marek Vasut wrote:

> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> 

Applied to u-boot/next, thanks!

[01/14] reset: ast2500: Staticize and constify driver ops
        commit: c2912fa76b663cc7621080f5dbdf134758c27de0
[02/14] reset: ast2600: Staticize and constify driver ops
        commit: cecdc51a4665705e9689b6780d9e0ff9dbd13421
[03/14] reset: at91: Staticize and constify driver ops
        commit: 432749b1a3f7be53cc8b3c6156b0c6cf6612634b
[04/14] reset: bcm6345: Staticize and constify driver ops
        commit: 6333bec332e87668a8a5b6b2745c81d958570e97
[05/14] reset: dra7: Staticize and constify driver ops
        commit: 1fe34ada73ae056b8260106618a6c217f38f6b44
[06/14] reset: mediatek: Staticize and constify driver ops
        commit: 85be3b92879a2b3e2707eff9eea05977a6bb4f05
[07/14] reset: meson: Staticize and constify driver ops
        commit: 4020549f9bbc00ba84af0dfc53ae9b859da67f4c
[08/14] reset: npcm: Staticize and constify driver ops
        commit: 35cd9d8636c25a7e9bc908db2fe8adcd87e6afc0
[09/14] reset: raspberrypi: Staticize and constify driver ops
        commit: 2a7e739c040bbeb34c39fb38d159609079109f51
[10/14] reset: sunxi: Staticize and constify driver ops
        commit: ce830106bf3b2d830e971ff622663a9c7516380b
[11/14] reset: sandbox: Staticize and constify driver ops
        commit: 1e38a363c2ae5db7f4a64fb10051ff2321891e3e
[12/14] reset: sti: Staticize and constify driver ops
        commit: 9c631c5dbb0758753fda452f3c5c8516f986e59a
[13/14] reset: tegra-car: Staticize and constify driver ops
        commit: 6f69da0d0fd7775f77df7ff64f761d07c901d39c
[14/14] reset: tegra186: Staticize and constify driver ops
        commit: c97fbda5fab8e42ce34d75b3a61800b9fe5162d0
-- 
Tom



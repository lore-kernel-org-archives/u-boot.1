Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BE62C5DF6A
	for <u-boot@archiver.kernel.org>; Sat, 15 Aug 2026 13:08:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5064B6066B;
	Sat, 15 Aug 2026 13:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H3wbYyxYyBeh; Sat, 15 Aug 2026 13:08:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54E1160661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786799291;
	bh=Jw7mm7hoaVXck2HcIUCvTswROQjnfwCyFtP1/t0B2EM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JwH19K0LUGm99ljEeyOnwQTtdFT+xuZLHtcWQFTTKwo9SUjTN09aw96psuzHEJ6r+
	 NIKYyZ8YyX4oXhQA6FRghu9rGLZFTT3bdlba+vIlGfNtUl8K6pOdqTnWfH6/hbrCQP
	 IxyrRH1VQ1euiWCA6vG70varBZhlyKM7/lpD+MM49jeZ9URLmDD9DI3GZtE/n8ASFf
	 jFxCu7sKRGDFnZVEnIIYa7NBl0cr0+5m2SLLF3iv4xKvk071EzFsmzEBYQ3LJzMxIs
	 jI+GTJGDiJy3Fs3m7udGIJ9yTsDFNPg2vSLry2ekzdTFT2fl1JGWzZs+quQHbLN4tM
	 8a6tImkNiDm9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54E1160661;
	Sat, 15 Aug 2026 13:08:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8416392
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:08:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CEF97400A6
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:08:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fUOcuZuYN0nw for <u-boot@lists.u-boot-project.org>;
 Sat, 15 Aug 2026 13:08:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=jbx6244@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1886D4008C
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1886D4008C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=jc3BECml
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1886D4008C
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 13:08:08 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-69fdfd98eb8so267321a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 15 Aug 2026 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786799287; x=1787404087;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jw7mm7hoaVXck2HcIUCvTswROQjnfwCyFtP1/t0B2EM=;
 b=jc3BECmlFY67LJ8oi888v5RzseVo+9Do+gke4q5RmTeM8AImMGn55tfmD0ierl9xat
 CNfHLlkFZFd/mVqzP7D3gUMdijBlORlUJ8KEK1TyQzpiCYqJJo5u2iaROde6aiCpMKN9
 yT4VkZnrZ2gfUEu7prc/m+IMaSGYYpb+EKSl1HfDSTCRiW7WLE4WE4ZMKCwhiQJRy/pF
 0qiiGhvVTDiY6pzjSKKg/PFQ22KZB34nSjG9xvPWJ5RZag74BGdvTjal62QUNsfCj4eu
 fA/xs4xnYBL2MDspi5S5ay7YtEL8acGbw/bMGJu5Z8eqlULWcB8mgOUIh2zV0/RC0FFL
 4HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786799287; x=1787404087;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:from:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jw7mm7hoaVXck2HcIUCvTswROQjnfwCyFtP1/t0B2EM=;
 b=UVyZvIlL/FCXkD3ioi2hBsl9KiPMM1DFeDp/3oXAAVotG3Q0J5c0rany0NWQ8nsic7
 eQo1s0uxfUitAhEVgnlh1TAhlL+dkn3CYWtMZnwBXoovKq06Wi5GCxi+/FEPF7OP8yED
 ZKmPwR9jrE68EUsnv1veGbcMt3YgVyhnRe2yHvS03oiiyYTZOPEK/EQo3efU62olY2cZ
 W+r7oSoE6gRMt8WvzEFrLPIDsLLazx3pX0ZkmF8qWK8YSx5CBLbBNOXIAYmWfxjX9rW4
 VqPMUsoEkMEJeqe/k3v8C8ZZi6nyn5MxlE0LGb+uU8Ny/ETTWoscOz9VLzCMPnKi75hF
 lzpw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpVfi2TzlNk/KaeN/YqxaOVgdP1mC5rceofsr8Hb8ZYIaIBmdKxHPuldT/g5Uq5HboAcgqROvs=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx7YxlBaZgVxApWvUv4Puh3CV7wnva2iNLi/E6PUUxrU5Irnobn
 7lBp9muTb4mX7Y8Wo10AUpPIcj5CacXBgBqsgdAmsKpMvFrUbjM0tLDB
X-Gm-Gg: AR+sD10E7xIF0DqcTyfmFgmlMMECbcnVXZl5FpjQ4wtg0kLmrAw+PxyyVbJ3cmaIFne
 lShWcafOOwdHyCqbLJkFhng9elG+3wliRaCO5BhAquKsy/kyc+ROUp4mR8Utu4yVqq+1B0q1A9F
 hS69JEsCra4bfcNOMtbQjYD26fI4rwcE/YiF010m7nIoJ2R1Q00seNzsAbg2YVZ4bodvVlAVy+j
 ck4P2QJKJ4HEhGBicudtSwYqksz3Uj5FZxAGP5CooFNeJZLGzu/4lK6xpOhoygo/UmIE/ECdYTs
 /Oqx/XWvRWd40+WSk8tgyPgACAb2cQ/RH2yOWSxwU4TqBd+241Bse4L168kWDVFTlXuetdCU3X2
 eJbjKu58SaMh5tEbZFZVZ/vXdqbgMs2hGyQTSqCTep1a8YUGbqr7gJeoi1PWSkfXUbD2fw8xeVC
 374rzvuC2WJ67HnuOxuIq5+C0i94rn9ccv/ZZunCUrdMUlO4dfT13aSD3qFYVOhuKgtPfA8r3tv
 qqYQzPHgWWZD7FYsJsrsmXMNol+e28v8/vytg==
X-Received: by 2002:a17:907:3c8a:b0:c15:ccda:26d5 with SMTP id
 a640c23a62f3a-c212a246110mr295384766b.4.1786799286608; 
 Sat, 15 Aug 2026 06:08:06 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c21237ecb18sm213514066b.47.2026.08.15.06.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 06:08:06 -0700 (PDT)
Message-ID: <3a69994f-9951-4c63-9e64-1e9414133b36@gmail.com>
Date: Sat, 15 Aug 2026 15:08:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v7 3/6] rockchip: doc: remove TODO
To: u-boot@0leil.net
Cc: kever.yang@rock-chips.com, sjg@chromium.org, trini@konsulko.com,
 u-boot@lists.u-boot-project.org, eddie.cai.linux@gmail.com
References: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <5e1799a6-68b3-4535-b56b-f115467e637e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Don't try to guess the future consensus. And don't add
a TODO if you don't have the intent to send an immediate
follow up. Remove the TODO in a constantly changing document.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 doc/board/rockchip/rockchip.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 7c911662b840..5e16e860bfd5 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -559,13 +559,6 @@ config-flash.ini:
         [OUTPUT]
         PATH=RK30xxLoader_uboot.bin
 
-TODO
-----
-
-- Add Rockchip idbloader image building
-- Add Rockchip TPL image building
-- Document SPI flash boot
-- Add missing SoC's with it boards list
 
 .. Jagan Teki <jagan@amarulasolutions.com>
 .. Wednesday 28 October 2020 06:47:26 PM IST
-- 
2.39.5


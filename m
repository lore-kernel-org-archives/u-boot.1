Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD818CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 13:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B82E847F6;
	Tue, 19 May 2026 15:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ewIWoVB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9900D846FA; Tue, 19 May 2026 15:35:13 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD6A846EC
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e568ab0bc5so4050592a34.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 06:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779197710; x=1779802510; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JMw0GfTxctY1pofUeEsjpeTnzSNEk0p+f/vC4y6qjoA=;
 b=ewIWoVB5wC/tCfoSp/iJNbRxyxNn7XLHspDMX7qhgt/ljOQtSqPDkI+5fiDChvlpte
 vzHIijcksUW5ThrQIjKHr2POYD/9lrwM7YcGlAxUEezl2N5TgKIS73w1+yWTCMd7Ajbq
 6vs7uAjb9Zq1Y7o6XQIRgTIcwtHGhVIeUVS2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197710; x=1779802510;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JMw0GfTxctY1pofUeEsjpeTnzSNEk0p+f/vC4y6qjoA=;
 b=hsc66AEywhm762JnZKrxS09Xm43icw3Bfs/Y8g1wdXC61v4towfupSrGCfx1ttEly6
 EH4mA3S2eVYlSGBrHxUyFjBDegFN25YwLsvEMGa2hNJGckFa969vX/9CoIDzdHG6f29B
 km4CnQhrzCwUEB89E9iIabXGJUsX6pxjQjjex01mYZcxsrm36knJ0uAQSkm+QgtbTenS
 p/Y4e8fI91Tc61IrrXYOPH2O8AXjDIM1gUWtJ94LdUkAjSeaP4eWTJeHONfIRrZGNb2q
 07FjXNr/INR7Uvoagw7DJWjyKvFVohyE15JHqoooLgvlcc/1MzD9kwZJNeCXIdFxfJlm
 f/KQ==
X-Gm-Message-State: AOJu0YwpAqp20pLx6n5nP85C/hVfyDTtp0lt8Gl6cdMKZl+8Fr+3n6k5
 4rtv7q/xc11HyhuZuUgujPC1+WxPDGMU78t0yWptSOyvfgSzF9YXufzvz30BCwzKRHFv14XFoga
 xhNXce4T5e4qY
X-Gm-Gg: Acq92OFDzgUye7KiOWQmg7q0V54gIR8QfailK2X/TvnSrCWnrawzes0CHhzkut1BqCM
 amtlwAXuA1fb3pXQNNJMMyAbqoaMmOrVnYRB1tDq7pfNooV4nNGb6Hn88EcKMuoUu+j6UrZNW2+
 yhHcZy2E7Cu3J3Tj5rpO6/n3xNwtc73UKnyH8YJeSLFoWupbc6K6sAvkAdimCEQorxpUUyTK3WF
 3Ofk7YIPQ+FpUhwSZcyu+XvyNcuXfq3rJCu+oDUB0n1ctAMTStNhiumMCyAVUJSEDWCpLxc0OfR
 IyN59Q1Noh31eAQVtGD8QAmcn4B6a8aC3olyy7HI2v4UVES15F+keqqkc3UeOKC4cYEt+w9TKZN
 QxuZ8XHBNfaygTLrSBhuIh+pJ1KlLfCR7aaFuRs1Hd9VHLoNsTJTeCUzINy/RYnhg+pgnTR2+Q/
 eIncAXX92BvHrXFX2xjt7iUqhTeCnby/Tv4tdk1ImoWbBpJ3lrhPclNKl/LbbF4e4SJvivc2DrV
 VGIwd95i3MHYH8ACNacB5CyKyOwE4U9Os4wAufoWAObUNLGR3S7kl9KLI4q
X-Received: by 2002:a05:6830:dc3:b0:7dc:e78b:158 with SMTP id
 46e09a7af769-7e49a913015mr10986502a34.4.1779197710195; 
 Tue, 19 May 2026 06:35:10 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7cd6c0sm10826569a34.4.2026.05.19.06.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260508135102.518693-1-marek.vasut+renesas@mailbox.org>
References: <20260508135102.518693-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2] cpu: armv8: Staticize driver ops
Message-Id: <177919770962.672258.8601332141982168697.b4-ty@konsulko.com>
Date: Tue, 19 May 2026 07:35:09 -0600
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

On Fri, 08 May 2026 15:50:53 +0200, Marek Vasut wrote:

> Set the ops structure as static. The structure is not accessible
> from outside of this driver.
> 
> 

Applied to u-boot/next, thanks!

[1/1] cpu: armv8: Staticize driver ops
      commit: 1f1ec618f2a9129714fdb30d8120d7b3808947a2
-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F91F531CE
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 23:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 159278352B;
	Tue, 14 Apr 2026 01:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YRdaNuCB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1195C841D5; Tue, 14 Apr 2026 01:35:58 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E91D883BC4
 for <u-boot@lists.denx.de>; Tue, 14 Apr 2026 01:35:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d4be94eeacso5333913a34.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776123354; x=1776728154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//sW8wCoQbernkZZMi5ODt09R8axZIs4lyQ3yaa3mOE=;
 b=YRdaNuCBR7cBVIK4JnsTM0nrRYpVMUD6dPtGLaPZguspOxdIh/AGr2SWyiwkgEt+vU
 LKwZBZ5VXTG6OZ4qh84VgT0A3YKMrSH04px9PoiEWiJw32QiIa4gZpLqZBK2W+H6Okrr
 cU4AwcfNqWeqjlPawt0GGS4znGk/CCcnszZZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776123354; x=1776728154;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=//sW8wCoQbernkZZMi5ODt09R8axZIs4lyQ3yaa3mOE=;
 b=MAvjHFL3J5zTU7gI1vAto/FhziTrWifNGpQFt1h0t/dRZ2nDWU2jZlgYbJDZsVpziN
 gP6LmIY3Zk87pP5EyMXQjHUbSe6a8NvsFsUGheJ5YjcDxLSvhPWk0UY/KWPyCzPj4cV+
 U1wA9UBCvYQ+vmVbvJDhigfWLm4KC7kV6d40PyxeZI1kDW0+Fb7r8a/p9k08zzhJRj5y
 A3clvOXhFw628zncMLCmzbwt1tSnOPAmDdrGO6aDr0lb0mVOu4VtoglAhGpxxz/NshJT
 9wXfJaX3JitLIAUGqoLNpWpo1ai3R5Oqm3XMuse4rdR7y5n1bb+0SW6EFuvsraQlRfK5
 +rDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PEkFjsxC5ul752bQNHbDKyx0Ms0SyrC60MYK8eVs4uq/MxVZF2jGfxkQ6/qj4BKPJkTedlRU=@lists.denx.de
X-Gm-Message-State: AOJu0YxVJk8ZZ9C0uIenn1aWWsLZ2GrLPnWSazN6x7YtdZlLFfU9Zf7G
 xNA3O/4XyR4X82zSREDvBJUjYkp33wVb/BsfdqoEws5PsqdkOHehCzsOPxecTfQQnQ/H0QN2s3k
 XTesJp18=
X-Gm-Gg: AeBDiespAoNdVEjmewDRrNXkGvu2gXuPHUO+hsSbJptoi7ZPs/h9TFw9NI8ycNVzdpj
 tXB1L2Gc9Wlhfo5z6XseKljrpOr3AsB8UL6inSGlqOtT3sionBhKtwkXajXG3a+jED1/+EHo8WM
 SaVsqt5vrl2I7GgkNImw6PtLsUgcbft3iUlIy4ycFy/HUTYDA4u1NyG0GxaoSDRqc+T+GkTXVDr
 5w0HvVEnHUEqIZ6zetCszYAOjq1e+DvNZMRZ+HSQrgBRwIcbQFE1pLPkp5n4ZeRBq/1b828hAnl
 yaH8WUDK/Zw2vr5cux7muJfw+6QmJZz3CHTd3/qK7mCkAkzBG2G9HXyUlI/xrBxr9bviXn96dL4
 67xiKjhxnhT9MnaaYWIX2pdrudfhw2TGkYTO3Fxpbut6rTowhSNnxMjTmeae5tAvSEVFFQtsH2x
 Bi6kMVGsnHcSHrmc5umfCRs5fPxUQSLxFDesSFo4KlGMDqC/OuxCexdROTboBYbQtd1kmLnJmzg
 zsE7Nm+ALmE/PAZd2QVJuOzXD/PBgtREaI7w8pOIwop6zzraw==
X-Received: by 2002:a05:6820:3088:b0:68c:373f:1835 with SMTP id
 006d021491bc7-68c373f1b1fmr7359616eaf.36.1776123354622; 
 Mon, 13 Apr 2026 16:35:54 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm10227910fac.2.2026.04.13.16.35.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 16:35:53 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
In-Reply-To: <20260327151612.2000964-1-hugo@hugovil.com>
References: <20260327151612.2000964-1-hugo@hugovil.com>
Subject: Re: [PATCH] config_distro_bootcmd: do not scan boot partitions if
 distro_bootpart is defined
Message-Id: <177612335349.2487918.13359859594236961157.b4-ty@konsulko.com>
Date: Mon, 13 Apr 2026 17:35:53 -0600
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

On Fri, 27 Mar 2026 11:16:07 -0400, Hugo Villeneuve wrote:

> For some projects, designing the active bootable partition is done by
> setting distro_bootpart in the environment instead of changing the bootable
> flag on the active partition.
> 
> This patch makes it possible to support both models by scanning boot
> partitions only if distro_bootpart is not defined in the environment.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] config_distro_bootcmd: do not scan boot partitions if distro_bootpart is defined
      commit: f7bef8f81f4f1b97b071b14a8c1f61df6285fc63
-- 
Tom



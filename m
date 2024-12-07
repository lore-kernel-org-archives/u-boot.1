Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41EFE7717B
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 01:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3391889170;
	Sat,  7 Dec 2024 02:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JWxSOW+w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3CCA89451; Sat,  7 Dec 2024 02:03:13 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D9489124
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 02:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4668e48963eso25337781cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 17:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733533390; x=1734138190; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZwzLO7JlnoMnOU1K63UBFmTgFrV2bgJfZobdbpwoj0g=;
 b=JWxSOW+wddUvmW48TP2fGPsN2TIJrY4C4VNFV09PiRdB97I9d7KxCVx/hRxpEqzmv5
 wZZ43vZlGPBCvGwDz9Z78bbx0FgUApfflGAJtZ2HppQwfqXtm3Pu7xap1978/H290anx
 YPu3jlgThixLhnVmzOr65f5RU0Hw63cWpqGw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733533390; x=1734138190;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZwzLO7JlnoMnOU1K63UBFmTgFrV2bgJfZobdbpwoj0g=;
 b=J8tzX8h0E+bsP5hc7/h3+9FiBXmLpQGDU89iPnozHyrIdG8HyjqkWYqnHLo8bjAVIh
 JvmBNM64S1u5gnsfWxWNr7xyvJcWX2B8bFqEgjN04O40+QlNDQg5/EZ/xg7WxaiPkoR/
 KfG1iReW/LYY7zdL1MCgJiwb7nq994M9ay4cFuG86CIsMYq4rNQza9nfnIS/wsLmVNIn
 X3aBTzH+j61t/2IGFeeJf9RSjOIH8AHJuArtdpAa92yEXQMh7MhPgpxaVVzIZAuP8QK9
 MuSbzxAdMvjVl0+g19J+MOIgXPOYAJvKn41eVCZoVBFy2guWBqJKNYjfLuivL+yAerp9
 xA6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhUSvUmQlunyzwmxpyk6C3kz2+aqp6A9+ojHFDEtTknDybBYiOZWk+GJwbFFmWte0KZ0NTEp4=@lists.denx.de
X-Gm-Message-State: AOJu0Ywfdr7R6yQvlcg+60Gg8YrijEvwdPtazVf8/ByVjlM4wDVflslB
 O4K9yXu9F0NEUdXojseuUAbLWr1N/iQpV1Sv1Sm+WSqlX1rSo4GMayqAcm5Gpnk=
X-Gm-Gg: ASbGnctyBg+XdWhmW102TDBfMUyKbQEFK0NhW9drNlD6qyh7SAvd/vjQXwJPcG1gsK1
 6YeqsQCz9/QpiRrn7PYFIMiBKl9pV908jtnn8Q25/p/FZaOngoeMJN66CAmDtd9VHeM4uaCknLv
 UWufyRHeVBxrpE8Z3XeCgS3xN4LGh4AHbM1+vidsWpTZ/gDj1uMsZbabkBK/u0AISSmSNwfDILg
 8+cZrbClQ1mbY9mRJF2aGLZ6/4Rtgq8MWDE9LC8xANSDyJzmg==
X-Google-Smtp-Source: AGHT+IGqgOXeyrCvcPlqNDoReSzm6kEUAaI+epCh8JDGNy1/yfORSrkub+jmrV0ean5loKI89+2wRQ==
X-Received: by 2002:a05:622a:d07:b0:467:4da0:d988 with SMTP id
 d75a77b69052e-4674da0db21mr5338821cf.19.1733533390338; 
 Fri, 06 Dec 2024 17:03:10 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297cd6a2sm26834331cf.84.2024.12.06.17.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 17:03:09 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Thomas Richard <thomas.richard@bootlin.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
In-Reply-To: <20241115-k3-debug-v1-1-5c1c130b4e2e@bootlin.com>
References: <20241115-k3-debug-v1-1-5c1c130b4e2e@bootlin.com>
Subject: Re: [PATCH] ram: k3-ddrss: drop debug() in timing-sensitive sequence
Message-Id: <173353338813.3658905.7996428053616582513.b4-ty@konsulko.com>
Date: Fri, 06 Dec 2024 19:03:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 15 Nov 2024 10:43:15 +0100, Théo Lebrun wrote:

> Those debug() calls might be useful, but beware. They can cause the DDR
> controller to hang if we do not run the sequence quickly enough.
> 
> They usually are not an issue with upstream U-Boot and the default DDR
> config, but they have become troublesome with custom DDR configs.
> 
> Drop those debug() statements that shouldn't be present in
> time-sensitive code, to avoid anyone else falling into the trap.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



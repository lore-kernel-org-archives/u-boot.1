Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68D69D609D3
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 17:29:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C754983106;
	Tue, 16 Dec 2025 18:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="icfCO3ZF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09DEB839A5; Tue, 16 Dec 2025 18:29:10 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE8388334F
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 18:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6598413b604so2665087eaf.0
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765906146; x=1766510946; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XLJugLqAvLFYkF/D/KbhUhoF37XExN0m0iHqQla6+qo=;
 b=icfCO3ZF2UA0F19J44jEsAfPoP8gtHOcm0TLGs1oPOU2oNPI80lESDQ+9EJQ3EmumH
 44muFfKy21jfcYasMLl4yjrllZlltup6MK/T5CQB5skD9me0kopYURcfxheN2CNu+dDB
 gei3PYbugR0foESMwGZ7/c+qQJ0iDW7KVWj18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765906146; x=1766510946;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XLJugLqAvLFYkF/D/KbhUhoF37XExN0m0iHqQla6+qo=;
 b=P8No/XwlfJCLCuBJA3Fn0wsG40MPMeYHdMHYP4dkVTIEzpywzDL6Z6vdoJaTuT/8SB
 P8mGnkPje4+kz0avtxr1fg3jHbY5T6u9sGmh/BtyZttLaHPRw7TVM5UOCT9/tABIXWso
 U4LhHzZVhrCZbhZjj7ObOmG72Jkc6gvIgmoNLhK8YC9jbdU1/xYRXdfR5aJdqrAOmZH0
 OQlmV1AMLoWtkLcrkztbCz7fsTCx8FGoBPMg98/aHZHh19hY/RFAB1r5+OhBQRSKadfZ
 PpMAkXrBgNpoGild+3VL+KeiaX6F77PagNWZhJd06tDfyrHfgidkEhxKKpvyrnu9/Adq
 4YLA==
X-Gm-Message-State: AOJu0YxeR2DVq2tQkA+NnoRaCDH8ZZKc2xwz43FJqsT00rKjh1Jp1hXy
 zvm5U8q5cxTwivp2tLMj9+V7a9aHQlrkIt8Ojd1usycRjq04IG4H4yi19z0g1iq5tUs=
X-Gm-Gg: AY/fxX6HEZxO1/mUiBeXEi157K+P3Ll7o9w6n58SblIddX8vu8cau/tw57uBOmveLjr
 uwcqT5hc5nH+H7nzB5PN/k1cq/T15q46Vy/GDlfDh1VzViUbg2dHY+Ebbd4Kl7+t4D9wyWFiYcV
 ZPSOiBBNINMmsiPOzZyj8PxzudFWEF85eHXO5RrQeu+rwxeBEx/cHttT+CT9m5JOAamgElg0TrR
 5KwxEgYN9urDnfVToRwlwjP+7ktTfFmZbQErK1/377Oi4KsP52Z7i447V5PN7xFbCrHGeDftb4x
 LNuZUbXx6ev1L4W1wEefhafOv7n2N/f61UWcycZT5lzA3Sfw2WtRzEnsvS5ZoSJpeqDSaW469e7
 Qos0cyix6dGX28GbrdZ8ZU1e60NswEkkfAqNGNrfiim4Ll7GK8ASvRB492RmJpu1olpDWTNOvlH
 FUzqESMfg6RPgi4umQOWspGB2OMERp+LKwVYL1r89oYg7uftZ13zYnWwUWW0M=
X-Google-Smtp-Source: AGHT+IFMwNJhdbYEm26TIZJTTHyt2ZkQeKnbdyAW9jMu8sSi5cb3W4KLxvmUKsdvobBu69BYyy1MzA==
X-Received: by 2002:a05:6820:61a:b0:65c:714e:efd8 with SMTP id
 006d021491bc7-65c714ef389mr77405eaf.58.1765906146445; 
 Tue, 16 Dec 2025 09:29:06 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b86c32d5dsm526682eaf.13.2025.12.16.09.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Dec 2025 09:29:06 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Roger Meier <roger@bufferoverflow.ch>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
Cc: u-boot@lists.denx.de, u-boot@ew.tq-group.com, 
 Masahiro Yamada <masahiroy@kernel.org>
In-Reply-To: <20250826063032.2642263-1-Max.Merchel@ew.tq-group.com>
References: <20250826063032.2642263-1-Max.Merchel@ew.tq-group.com>
Subject: Re: [PATCH v2] tools/libfdt/fdt_rw: fix SPDX-License-Identifier
Message-Id: <176590614572.2175876.13656596746862549865.b4-ty@konsulko.com>
Date: Tue, 16 Dec 2025 11:29:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Tue, 26 Aug 2025 08:30:29 +0200, Max Merchel wrote:

> Currently, the terms of both licenses (GPL 2.0 and BSD-2-Clause) must be
> met.
> However, before switching to the SPDX license identifier, the license
> information in the file begins with:
> 
> "libfdt is dual licensed: you can use it either under the terms of
> the GPL, or the BSD license, at your option."
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] tools/libfdt/fdt_rw: fix SPDX-License-Identifier
      commit: 798bef8e8322101a6add9a5797f6dfc748f44ed6
-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDCD8CA0EE4
	for <u-boot@archiver.kernel.org>; Thu, 14 Aug 2025 18:49:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFBBF83A71;
	Thu, 14 Aug 2025 20:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rGVb5xxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCA3A83A61; Thu, 14 Aug 2025 20:48:40 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB73883A43
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 20:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-88432efaf45so10975839f.3
 for <u-boot@lists.denx.de>; Thu, 14 Aug 2025 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1755197317; x=1755802117; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hZMWqho/Tyr4SaJ2MvkkCbZuBQ4ZWUhViPeHfd/PPOA=;
 b=rGVb5xxa9HOtte+wztjVfwmyqROc4pcutnVG1rRHXocXOnC0YV01ujXUBmDXAWpkf5
 qRBCN70PewI1JVfDRzApXPjkJugMHlldJQjGN9S2sCox2tFo88oT7Sd6bYxik5fFub/R
 ZGIl9tl7MVwth1lWTGI2w2JbqgN+RJiTR9ysY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755197317; x=1755802117;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hZMWqho/Tyr4SaJ2MvkkCbZuBQ4ZWUhViPeHfd/PPOA=;
 b=v97m/31ZP8B3FsKCkxqIBOr1z90Q2txTwuI9EyrKdUZxwLlbPLl2i8neF1ptsqUXW6
 PKQBgHCN4xGOg7ZJbNKz44u1xiOByErt8wqkamdBFbnGKKZcZtSefhb+N3MXwbikVJ5c
 Vi377v8NBvIRy7bWXf+ub/3tUlNEbjycdzdxXZuFcspR7ydGhYbLm0TH9FoKclYEw3oM
 T34dXOfnll63rGO6Q2zRhfqbrVRCvhZO+B2GjLPpYHXm9EPV+96P/x6fFFPvgg68VK/D
 DPdG4alOgYi6AxB/vZC7k/X43Rr/zZrLoP31g5v1KhayQVtIkaltLhE8yoTYWXQVAu11
 VO9A==
X-Gm-Message-State: AOJu0YxpY7aX7KDz08HRj8JxoGmSHJURuxhYy07AC4qmqs3Bu+5EAfXn
 u/JHgMqjsy9dPBZvA7dZDOctYR5Zz3CPSqsfCpYLvJa0pQ2PtTEPjKZkzLr+hwv637s=
X-Gm-Gg: ASbGncvKUbuo91VWJ8PFyFYOKeHvMPGttxy7LeGp5JrLhBqDc1lymBDyqIRIa3G11GK
 2Rh9f/0KwsJQdRpdvoE9KiiV44qUlhNgy2rs3oeyMC3cKrIJqfKKkaiwwYL6HjAKVPtaNB8Zhds
 4jFKzVrlJK/HAmtI66CAOikdHNpOLuFOCEgT4BPJjji3Yt2zegz/e4OFCuHQLRyr83FxLcBPQaN
 LBZD+s5D1GM+7kvhCXiXC5oznY2S0mvgXEffK4XkNEGvWY5vv4Gae87HnKM2Z+SHu3+wtjr9CxK
 VIaUbzYZc+u/YtWFX/S399WatgDkIdOPdMc4QeyZ6z5xJVLmNUg8bukrK7tELp+/6eYI1w1zdfG
 Wg2MP0I/p1J4inhIWJaxoy4gvR93Av2i70DV6qeewq3FAKO94pw46+s0=
X-Google-Smtp-Source: AGHT+IGIRnX0NRwV9mcKeiacqRiEUA+q0D7Q0DIae6jpAcdJDMbOWaQhu61X/h2fxQN0jHwOPnqdXg==
X-Received: by 2002:a05:6e02:148b:b0:3e5:4f4c:9f17 with SMTP id
 e9e14a558f8ab-3e5709962c8mr82533765ab.19.1755197317491; 
 Thu, 14 Aug 2025 11:48:37 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50b3d6ff137sm1219762173.41.2025.08.14.11.48.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 11:48:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250804215719.1413106-6-trini@konsulko.com>
References: <20250804215719.1413106-1-trini@konsulko.com>
 <20250804215719.1413106-6-trini@konsulko.com>
Subject: Re: [PATCH] soc: Tighten some soc driver dependencies
Message-Id: <175519731680.3600102.13680988237146318268.b4-ty@konsulko.com>
Date: Thu, 14 Aug 2025 12:48:36 -0600
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

On Mon, 04 Aug 2025 15:57:15 -0600, Tom Rini wrote:

> The Qualcomm Snapdragon "SoC" driver cannot build without access to some
> ARM64 specific functionality. Express that requirements in Kconfig as
> well.
> 
> 

Applied to u-boot/next, thanks!

[1/1] soc: Tighten some soc driver dependencies
      commit: 01bc65a0e9b2e0bac7af28bf102ee0df4f98b205
-- 
Tom



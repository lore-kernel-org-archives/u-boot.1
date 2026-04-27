Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69714FF886D
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 19:42:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996A384106;
	Mon, 27 Apr 2026 21:42:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X3NZtdJT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09ABD83C51; Mon, 27 Apr 2026 21:42:33 +0200 (CEST)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E163183693
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 21:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-6948ff6b006so4745867eaf.2
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 12:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777318949; x=1777923749; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pHhLXGYHf/HhcK5qPUXp6gFLH+EeshSlOFE9Tw8b4E4=;
 b=X3NZtdJTE4RK9izbB4vvHnbIxj2DnuoaXsXgGgRZbpafC5nCLx+F3HbDYtbrDZ0C8W
 bx2IBdRRYcR2gYZKHI6w155K2sAV2BHwV7MU6M0j0BBVE/l9C/b5kucdV46L1m9YulaG
 /M3PuGjBTuuIks4Pr+J9HO6XQRGBftYmWK2QU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777318949; x=1777923749;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pHhLXGYHf/HhcK5qPUXp6gFLH+EeshSlOFE9Tw8b4E4=;
 b=phI8lO0h/KRjpafkeIK6FgTXf3kUu3O8YNl7nIT/Oiz3NsEUSsc/7TjBwj1PHLQcLi
 3lrQEfxdEZQDRkGs0ukzs2UUFt4KEvuHiZCWCLOiUpqTSJsp1HH6ZtzrNwF5yeLjFMZk
 wbUPtJS6Nwpyh/LWxzaroFjBurPEbguAkWxQ+/6NX+wF5g3mv/AfakOxIGExDk5DyBeP
 L6AbFj7VXVPkStQEKO37tW0oGrvG2vHME6/Ww/VrSQIeszMvSstM1Auf/vstSlzzf4AA
 qOHF0GQPL0TmSmnoKEMQ3rrxvFBKAFxNW1v0RIHABCc4q4DDivBs19x1dazalrtBFTlE
 H2Aw==
X-Gm-Message-State: AOJu0YxmhRNg2sBxjUK+Gtng3mMfGuw/3AxqglhdMq9Ob46iD3U8USvg
 OWJcuKJE9liojAVO2N8oc8G9Y/L6Ez9Q82lR/AlqGaL+YBk0mhjU6SlN15icKFfhR59NugWZquO
 ei2xZ7bBUhg==
X-Gm-Gg: AeBDieuXVVQKkPNbOz+al0UQ9TV0dnxpb9vz4WbRc9LUqqx63QGexPEQ+S79aWzh0iO
 ovvgZyd8cixzC8xYeshSZrjU0vQLlN/Y6TEkRD29LYrhT3HrstqGaMKNJyFSpFYRjWDl4iWrZjV
 8aFUrvwa63jFiXiKCsYJb7+rJpwKZgAWPjKx0zdU+/di4WeLBcP4PbKv0/d+iqPzEcYLRTZjBLL
 mEY4J6jUCJmpumFMTd1kJYWOr8g1tL/JgnP4jxMxrUFvonkeiawOsp96EYDETxdzNj1qmNrStXd
 u2xOlwK8N5dRp725wUlBwCwXYeo1L5U1/6saab0wYq9fLF1aTSjalGEjt7DG0SklKo0vBmREfpZ
 fH2CxVq6FhctqNusWRsWc83f6s9oqmvxsS0yPicH4ztPT+lKgBbLXwy6/rhdEztcPmc702IPOAu
 g8P5SV3eFNNwjGjXACQ7mf8IPg9Lmri4hNxmrAZbPqWz6AaQWaq6Vb1BybB0l/EZcoNxgFgXWK3
 J+fYd9ey/6vS22dKXCG5x3vEbS9DECRB0mApV7F5wkIi7RuulJMOS4Ju0Hq
X-Received: by 2002:a05:6820:f008:b0:696:22dc:b4db with SMTP id
 006d021491bc7-6965ba35059mr227420eaf.41.1777318949326; 
 Mon, 27 Apr 2026 12:42:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6965b94aa0esm187247eaf.6.2026.04.27.12.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 12:42:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, 
 =?utf-8?q?Christian_P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Adam Lackorzynski <adam@l4re.org>
In-Reply-To: <20260417120319.573470-1-christian.poetzsch@kernkonzept.com>
References: <20260327081858.311591-1-christian.poetzsch@kernkonzept.com>
 <20260417120319.573470-1-christian.poetzsch@kernkonzept.com>
Subject: Re: [PATCH v2] virtio: add support for SIZE_MAX & SEG_MAX features
Message-Id: <177731894862.3526444.9446134173350850010.b4-ty@konsulko.com>
Date: Mon, 27 Apr 2026 13:42:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

On Fri, 17 Apr 2026 14:03:19 +0200, Christian Pötzsch wrote:

> Some virtio implementations may forward the virtio requests directly to
> the underlying hw. The hw may have some restrictions in how many and how
> big the requests can be. Therefore, the corresponding virtio device will
> announce this limitations with the SIZE_MAX & SEG_MAX feature.
> 
> Add support for those features. Split an io request into multiple virtio
> requests if more than seg_max segments would be used. Also split a
> single buffer request into multiple segments if the buffer is bigger
> then size_max.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] virtio: add support for SIZE_MAX & SEG_MAX features
      commit: bb4142af7ed8c94b3df3e75ca9ab3ef450e80885
-- 
Tom



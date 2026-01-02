Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CEEFA3751
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4076183B30;
	Sat,  3 Jan 2026 00:23:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F1xjXDJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D910583C30; Sat,  3 Jan 2026 00:23:48 +0100 (CET)
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com
 [IPv6:2607:f8b0:4864:20::c41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55ED83B7F
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc41.google.com with SMTP id
 006d021491bc7-6575e760f06so3206445eaf.0
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396225; x=1768001025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I/6k3BhwblmHZNNpaiO/wKKZbztmVVRqT31oO+/R8s0=;
 b=F1xjXDJQ0hkO2Mo5R1vrgMe3FlV75Md3nF5vQipVfNnUW+p0QiejppoD4Dwch3eRPN
 72x3mGZwVxN2Q9wYtJkFR2rLiXycjejwxq4ZldYfAP2dHfeqGxDeex4G1o4RRGAKbQ84
 q/EnDxEbBje3iIvdp4cX6/ExrlhL1jrhbL85w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396225; x=1768001025;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I/6k3BhwblmHZNNpaiO/wKKZbztmVVRqT31oO+/R8s0=;
 b=nDvbjpPx+pE87z6nHDpseYkRCzMekl2XLlp4UXfGdNNMlbyLAUatdogCwnzgAGc5Yo
 y6+nTZ4/UwM6mpaA3nWfYVC2ty/fy05DUOfA7dJUGYMN7/LAzL2GP7cygBfXeUZdio0b
 m4imtpoRNxprNypnmND2KPDHOXu3GDsVyV9Or5MY4ReyTeLI5hEg/TYlM4c8hNauYza0
 1cfsOKRf1GQx+ij8feCJfjnuCmnqQssA2fzKZ02tX6VtmgRevIL9nnxaISsxMsy0NDM2
 jALj6WFD5osHoatjzi6VG9YIDqXIDrRfKfQbPCe2KpMDornBu/buXkfbEXxEHYdJriMk
 n1Ng==
X-Gm-Message-State: AOJu0YzZHdDtECoUz6QVejML1GNV+l7GfNmuHfFXCkkk49RPuFUp221l
 l5ZVbkzcnZyoOsvIJxKU5xPSbUXxuqDlin84kPI8GW2RBZniUkkwPVEl89V0R4/sDY9jW0JkLCI
 iXrOFDM5Hog==
X-Gm-Gg: AY/fxX7KNxklimslKJfj8ZTjhGfh1KIKFZltvG42J74qA+Nzl5ddp9HtCfQmomNhGHp
 jvvVYuBkkUBxmJ3XC1gqTwIRmD65+YqktERycbwOqqNKfihOia9RCnbqmT0/TVRs+WqPOvYyxLv
 NISdTgO4BNfu0vMuzUpgrYj3hNUyNZx74dEgzvSGgSeqWq/S+E/mdyesX/FF2b4rmtoQoQORtHs
 95LPOI24uZKArXGup60isjcpWS5TK++jX3tw4pYEMk8NGQrzDmGPoExMYjN6Jdi7ekaartk/pzr
 RJ/V4XRfJp+kMqog9QRsZgD4i+ASGXR9q3yWQRuUyx2kBqy3ZxARJSvD+LEFUQ8cZWDoObfUnPU
 daAkVjVCoYqNAq7IKt5Dd/ab3XKkSGWFoSS1IRtH6ybQtxXJy7rb5LAuBMnubv9uviIBAq3R2Ox
 6O5nchCbtCCpY7vPCsgbexnirtW8tNRtkX5VsDzWKDpmK+qKl0p7UaXyWRLKlcNVycklK/0ky5S
 aysJk/geg88FrWJDOB5LO3qtvfWZh8f8Q6Z7g==
X-Google-Smtp-Source: AGHT+IFHaRAXeAM4yW3DQD//QXqDb2r/9YTDV3GH2ehWsUBbkOm4DoMWhhOQ6VVyHbvGkAfGyuG/Mg==
X-Received: by 2002:a05:6820:6283:b0:65b:3480:6454 with SMTP id
 006d021491bc7-65d0eaf27b9mr13036109eaf.65.1767396225555; 
 Fri, 02 Jan 2026 15:23:45 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:45 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Francois Berder <fberder@outlook.fr>
Cc: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <BESP194MB28051D632021995D4D572411DAADA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB28051D632021995D4D572411DAADA@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Subject: Re: [PATCH v2] fs: ext4fs: Free memory while handling errors
Message-Id: <176739622474.296893.1791035801115848440.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:44 -0600
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

On Mon, 15 Dec 2025 12:34:16 +0100, Francois Berder wrote:

> If zalloc fails, one needs to free memory previously
> allocated in the function. This commit makes sure that
> we do not leak any memory.
> 
> 

Applied to u-boot/next, thanks!

[1/1] fs: ext4fs: Free memory while handling errors
      commit: cec36b777a56b61c347447c12e61a9d1c425f396
-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672A0FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4525684859;
	Mon,  4 May 2026 22:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L8LZTd1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B9AC84855; Mon,  4 May 2026 22:36:21 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F03C08483A
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dcdaf06498so3267461a34.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777926978; x=1778531778; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMsHTYnseihNqEMHKtbS3f4Wb4mr4f8ll18oTUTKGgo=;
 b=L8LZTd1Zeb7i4DBbYNYJCIofuB9zc+aVuOnlAhTF8wumALHZWIDJhX0x7aOr6tt7ed
 yS04vkExWeZfsQTp0J+FoPYWGtQFpkGoSeFniF2DOan1h8eymB9rjNMP0gsmWdsFF7UK
 sw5iutXKXBVtrcrvIKWJ5aHXTHuCOljIoDq0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926978; x=1778531778;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gMsHTYnseihNqEMHKtbS3f4Wb4mr4f8ll18oTUTKGgo=;
 b=JyEO+rEFmTvThPbaewKO3tPzLhjTA3GqQ5ailCApXZRLrwNq7P97BMvHu6azim47DQ
 ciFUnEfZKtPYgxyxzS5sMiX8zgmbJyoYX8TvVc0czbvl4I1T3aEV9EQGroYhJcW99Xlz
 ewQjvZVCHZjIBeYPRJ2OqQrdTno94CK6jU4HIRhadf1LjDp21jts/68WNJ3gGOV1PaJ6
 H26M1NjDmoCALVC0V7glfqREYYdUP0ydTSatkM42Gm8AxYotPBOR9CO7nimaQfnPvA0G
 VgfNosiZSy3B2+Uys3aqDnYsRa213swd9ctaICx994CbZUpNvhIum/E1vT+zyvDYhNIn
 XIsw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+fIdSs/kc+uHLfjqVk+cjR7NOUpFK2YCRbqM6awBOrv6p/vqmJhJ4zxN31uSPgMV6XduHr9qo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzu00YbL8fl9r3TYLivDVPF5hIjCbkx+IwpHbC9/n+WxDbzuhL5
 h7bDX3hsyLYGHEwScKdrfdPt9TTajuBg3TPHe4bw4nsVX7dCEIwZyFsFBEU331/pb2U=
X-Gm-Gg: AeBDieuCPvtFgEfVaX6DHy9Z5wVMHsm25nHmA9HJiWeK3KFDBOohS9qNkWzJSgwaIBD
 rL5PPfxWaGkATBM6/VFu6i9v24Q5uR6r0c0p7aHkUZUekm6l9PDtNJgSGJEsz5v5U1wh89sIPJR
 8akev+rqZJclrNGgSdQcJ48jpKSuCvkF4QVVYL2d4pvbiSCCne6UStuFc0eZbSH74iKoVh8aXw3
 e3QtV2Yr/4APvaGK+N8omN1MYo1LVbFcB9DItro5zHJDI+l4s9FS1wqpkTMMiiVFdpErlKKWWDp
 zXmrLIhPWP3I9Xpr3CXPuGxRtQ6y6poUbt4RoePL9dFkFZgUeK0FG2Hb/dzvMpxMpgtjXb1uZhm
 6UzkC1d0xNTlT6gym02a75MXFY3Lsvv2zXtk+WQYzE8wG4xubItG6nC0sIOAGl3NvFOB2OBDYTI
 OGHUF06XeW8lVXmUlXGypLol6dDuZ1zeFTHwkO2tcbvXaHs7WOCo7YfYNy6YP7CKeqIevcEVF42
 vrEcWFFzQ10QOE/mpDljFjXU/Pi84X59CsMSlnaWK90vS/2nRirN9oBVpy1
X-Received: by 2002:a05:6830:2b1f:b0:7d7:faef:fa0 with SMTP id
 46e09a7af769-7e1749a5f15mr221586a34.3.1777926977773; 
 Mon, 04 May 2026 13:36:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac26330sm8464401a34.13.2026.05.04.13.36.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:36:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 Daniel Palmer <daniel@thingy.jp>, u-boot@lists.denx.de
In-Reply-To: <20260429155418.75429-1-heinrich.schuchardt@canonical.com>
References: <20260429155418.75429-1-heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH 1/1] fat: initialize ret in disk_rw()
Message-Id: <177792697690.2985766.12696077075553640217.b4-ty@konsulko.com>
Date: Mon, 04 May 2026 14:36:16 -0600
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

On Wed, 29 Apr 2026 17:54:18 +0200, Heinrich Schuchardt wrote:

> If fat_sect_size = 0 and nr_sect = 0, the value of ret is never intialized.
> A random return value is returned.
> 
> Initialize ret to 0.
> 
> 

Applied to u-boot/master, thanks!

[1/1] fat: initialize ret in disk_rw()
      commit: ba1209d7a756552677f07c207cdf7fac400a8b7c
-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9FBFD4F03
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:08:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EE4584101;
	Tue, 10 Mar 2026 17:08:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pZCeVwbU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3718409A; Tue, 10 Mar 2026 17:08:04 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01DA384090
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-40ef10ec84cso5623096fac.2
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773158880; x=1773763680; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=15mNqSyNrv0YyBxlJFrwHGP9HUKwEf5x7pF5PSNTlck=;
 b=pZCeVwbUPO1c38Ci5tRK1t+XgvUkCo1ZDz4kYQRMF0tfJhUrFP2FrSdPlfsQVQp62K
 775pon9pVxXy9IsmMrbyAcuQB+ZPUwOSfkBtcUvyvPoH9aigrc0fcQ+vnpamsAUMyu06
 ilQEJa2w3dfTPMnR7cFyOB5iMcaPRUUJlGiys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158880; x=1773763680;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=15mNqSyNrv0YyBxlJFrwHGP9HUKwEf5x7pF5PSNTlck=;
 b=f8hvag73Utn4GZdBulCIyzkNwoh2mrOUDPaf1zjL5c1/0ilc3hG1VYFkFnkFQgI4Du
 UmNcdvDT4wT4NYn6now5Ai5VtzYgncys/uAQI7w5/ynpkdlxGGRIVOsfS0nvixK2SHtF
 ym3yaROtirE8qAoy1HpPTXgajWZFI2QkYoCBMF1eq74O8i6OATk5/76yGcbiBWGBdjSr
 WQjiFZsx8J3aRDvPPWnhSruM05zlhskmZShl59VK6W0uMkOqYIwQA7Req2WYyy6hQPAO
 nw9UbngQPDP6qJXe93pKPZU3QIlZL01Fenwq6GBarB7UTe1l1W7GuWAnZN4czvrB5XvP
 iBIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0+AWZh86Vsa10AW7HMWbReNVy3lGKRAY8e6yByo0FSe8kBIEhq9pjuMQ1MMeRjdlYtF3FJEo=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt3Hub5smriUvn4S4HD5xjSn7qYLfZH5ERGgIILx/Ad2l6FO7b
 /HZqSU1Xz98la5+yUS2+V5l+eOYYhdiMaICyXWI5zAaqiW01O32cvXupf6ZK9qsbDzs=
X-Gm-Gg: ATEYQzwxXBra3g36BBrppkkICLb4zR2sPp1mKZ5vJR9qrCzmTvGUbxIE17AlctJIYOD
 2POF6fbFEiMlnyrSqICNo9lrJ8NmIVV4GtkHe3z3xYonxIs3xqLDSiMQRqR/fsJsovbUFNYN0t8
 YrnQu6BJcSrZbIUVYwjrvFZsHAsmDVOOxciVj7IS6vshit6eOAY60NSMF61LGTZP0PnrKaUqpUG
 YsuJb+SQyhx9sER5Pejt3TiqYjuH4xvetMY1DQjRY/FwdjV54cLjpRkp5x+7KfZZ8qh0RANV5YE
 jukh+ZnZuzIdmQP6ASMt0edKYGrcWT9QqEvdG44IOTT9yKudtxf7t/jxIvpz4XozxgeqcZ0xhfs
 rC2M8FdJ1wHiG+LyINnrhVw5vaGNkuF68aBJwt3GNmO5DxBKhwHGPCa0hDAFdrl3q8a4ehpVYV1
 F3+Gqww8Yc+XRtTl3VVd4BAwmXKROts1O5Kq2vdpKFhkqcQH9b27p6oycPsuOf1qKBnQ1G8ElMt
 K8Cz9FJ8XSvNTTeLOo0yKWFOLiWIQCYUbmxJdOarhzp9wFTfD2+NPU=
X-Received: by 2002:a05:6870:84ca:b0:3d2:6a9e:29ff with SMTP id
 586e51a60fabf-416e40070femr7788463fac.16.1773158879660; 
 Tue, 10 Mar 2026 09:07:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41756b47f0asm3501313fac.8.2026.03.10.09.07.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:07:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
In-Reply-To: <20260223-makefile-fix-duplicate-dtbs-recipe-v1-1-4132c3496f98@baylibre.com>
References: <20260223-makefile-fix-duplicate-dtbs-recipe-v1-1-4132c3496f98@baylibre.com>
Subject: Re: [PATCH] Makefile: fix duplicate dtbs recipe
Message-Id: <177315887902.1153104.11288483331764250379.b4-ty@konsulko.com>
Date: Tue, 10 Mar 2026 10:07:59 -0600
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

On Mon, 23 Feb 2026 14:44:38 -0600, David Lechner wrote:

> Convert a duplicate dtbs recipe into a dependency in the main Makefile.
> 
> Another recipe is already defined on line 2369, so we are getting
> spurious warnings like:
> 
>     Makefile:2369: warning: overriding recipe for target 'dtbs'
>     Makefile:1425: warning: ignoring old recipe for target 'dtbs'
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] Makefile: fix duplicate dtbs recipe
      commit: eb3042dc0d93095c1fb6dbea82dacc9bc7d6e809
-- 
Tom



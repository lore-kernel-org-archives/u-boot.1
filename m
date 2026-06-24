Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD4DCDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 19:21:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3CD084704;
	Wed, 24 Jun 2026 21:21:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kpC5RuSF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8086847C3; Wed, 24 Jun 2026 21:21:29 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA7C98460E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 21:21:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-4414d76270cso958575fac.1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 12:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782328886; x=1782933686; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zzD8qp+s1rJltnVMAuM4FzQhG/gCVEMsuCZDo5z2Utw=;
 b=kpC5RuSFxL5w7TYdZnEfCqOABnBOq8T1h+4Xm3rocWlzt4eloYbZjmCMul2ZODcAIv
 itTNvVQmmJCt7hweJSvPKfQwsD5U/zfB0RNrWjTPa5VRtP+6rMF0gySIwkLqQb157Bih
 fsXoEm8SUyiPnHF6hmzY4SwkNUmTbFIsaiq+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782328886; x=1782933686;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zzD8qp+s1rJltnVMAuM4FzQhG/gCVEMsuCZDo5z2Utw=;
 b=Yrje/KkddboHM3JFAX1JS6Mhd/wuvoik65dgdcgIdFFAMSfC/GqSFnjbr6qC9irf0H
 G+bD7PiW+fVzllSWUmZ/bS0TNrwYUZ8oKGIAduL84PTTzxLxREMZ9RBVZMq3xHz3qd/3
 W202/m3exRHn/esEqXY+ZTlpYSryfNLyETNhBPlTIS96Qb3Il0+e84QnBYTR2ksFJvqd
 bZZNi3eSkh2cpeyK84SpqFnwgX+kR+BAw/AKOJg3MjBY+No5+ZibdP/yZqnH5thvmy2s
 y70BIiJAlEeeOpdbRETa76melINFDkjQzt5uX2t6ljHksLePo9oywqHLq794NANjruA/
 7iqw==
X-Gm-Message-State: AOJu0YzPDjvwCfPk7IvmGas18QHRQgWJgLFA5y1XcKBdFF4z7ErVENdQ
 QBwZ04hLt+NkqVjUHWAQ5VdMx4i6cP87tC7yocjapYqHkphyu91njXrlBL4AcO7WAW9LypZqH05
 MEhESYd0=
X-Gm-Gg: AfdE7cmODOsjVCr2SwJQ+vHynlpVV+xbqUcUkucoATtgWqmCYm0fmV7r2miNYXEYaCo
 CT5UxWd/IRVjVHRpk6OCea4fHIFIcSTbtfGPerPjL97C4QmgLLtl7/OFuAyDCp5BN6e8/2eLXBg
 CILkdkC5OHyMzYXgNmdAcPCpibg3FIi3UFF55dNRbgXDxU9PwwcGvBnRIGOXiqIbsjYuLzARB37
 Urnhqj0M4ePxqDg9f5rlHCqkzyl2cUfcwpvE0BVFeU80+ggnDF0LHISp5+fmWIqiv00daXdDyhj
 RoT0I+J+M0RF2cRxcxBhwisEQQAKiX6WIzRn6FGKeTi5CWY0nIQwLz9ivQBS2zaRuUPf6bBb84M
 uVGByfct2Dhbm9ObsnXqaIIuQq1c6j4P12MG7KA++eD++O5ILy8rYRlScnY0LK1bskeHvoyxZ0m
 WTRm0Wp2D+XPho2JDP7t+o45p4Ykk0qzM4qcBVa+YyQRloZsEFgTnHefAsrhQ2xlegnJtuPCI=
X-Received: by 2002:a05:6870:8290:b0:447:2ca4:918 with SMTP id
 586e51a60fabf-447b5f5f507mr6612075fac.33.1782328886406; 
 Wed, 24 Jun 2026 12:21:26 -0700 (PDT)
Received: from [127.0.1.1] ([145.14.135.239]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472ecd3de2sm11613434fac.8.2026.06.24.12.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 12:21:26 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, Julien Stephan <jstephan@baylibre.com>
In-Reply-To: <20260624153501.313881-1-dlechner@baylibre.com>
References: <20260624153501.313881-1-dlechner@baylibre.com>
Subject: Re: [GIT PULL] Please pull mediatek-for-master-2026-06-24 into master
Message-Id: <178232888564.3646223.13161649065132905705.b4-ty@konsulko.com>
Date: Wed, 24 Jun 2026 13:21:25 -0600
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

On Wed, 24 Jun 2026 10:31:53 -0500, David Lechner wrote:

> A few late fixes. One that we've been waiting a long time to finally get into
> devicetree-rebasing so we could cherry-pick it and the rest is to fix a
> regression that was reported a few weeks ago.
> 
> The following changes since commit fcda974e36033ad5331a9b4a4a551af4e141ad7d:
> 
>   arm: aspeed: Fix AST2600 SPL external DTB alignment (2026-06-23 10:41:25 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom



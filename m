Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E0B5109E522
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 23:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5F4983E7A;
	Thu, 26 Mar 2026 00:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gNaJGEuM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3357C83F86; Thu, 26 Mar 2026 00:05:54 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1537883DA7
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 00:05:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46704177543so226977b6e.2
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774479951; x=1775084751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BtGOLqQnkdflwZdoioWN6ghjpnk2qiRiysdSOEXpw5c=;
 b=gNaJGEuMY8i5xGx3gj/ahRV+nW5rIfyZnJZk/6dHrsygClOowKXjlYvK7xz8nXtS0s
 GYONmVdxvsB8hs+ZdiUmlRJJyOU6ciAyxS/2VxVih/rEM3axdLOThrEGmGSxf1FFYfKl
 EdhhJAoQQqqt7uEULxZTmyUvl/XxBTFJiVSo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774479951; x=1775084751;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BtGOLqQnkdflwZdoioWN6ghjpnk2qiRiysdSOEXpw5c=;
 b=Y63hG1CMVuK0rNLTtavmJ5WbnvVLea37R3BPFFHjfVwrgdVOE1634j30uxzuRyf7e0
 q7OFtXKvZ3pPsUgGaO3iCpVFpjPtfqevHj269kH0D5T+VHpLC1Zg5Kjf6fgYVQKVlfJV
 jFUbRE4Sw7m9ZwpJFJywDtyQ4/vx6d9iQG8rLZrFrKOCWja/Hi3LRzYl9mG+9SDGVKA4
 YhQTIZhyURa6hOMWr4rfDVROpZEBJvxcKaPRIDa2mSt+q6ZiIHtymTT1/l9UX7A43W+Z
 C381a8fy5AY2v2LE9RJIjStOPC8ajoYOuejKQxhevgn5+uQJ4zSRinLqWjr/6tiGZnO/
 loNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWirNLKfG9WL0hRe7vDmFD5GZ47p8FrAI/StW9BfB/K0vNwkbchMqi410aoNPvUL9nTZWi/4Go=@lists.denx.de
X-Gm-Message-State: AOJu0YxGjTMLJV8JAouseeCOwJs1zwHZh08/bFrQ6p2VM8NHaTGugPrk
 CaIioTxjDWxOFRm/rC5IUFuK6du7S8Uag4ReMVvwWIPGaEiQqaseqqISAbrSS4WtpoN2vxP8ZS/
 iqLtujck=
X-Gm-Gg: ATEYQzwV8+6yqmFuVNJ5Sa5th9oVtd4PsehZul31lpymu+fGJgRAmrxg60Hme6Bbs4S
 1gsjp4T53oBbQh6PzVyUg56u5t07w+yQX2mgUJp2PBGwL4Z3SYsWghy8lTrWnhD1sEjQFQG4rNe
 0u2U0/diLxCaQ6/0SDb+qdLP/66kMeJV+GJlZtq1R4q7ZGt/e3rjZ1sbIIYSUTXebI2gFdWKjt7
 rTPPdEOa0gSqcmc1W7T5nslJiMd0rZqV4DwXgrhvxkAe5Cv1RlB1ZCK2zWCw5h5fL2PyzNw6QZg
 SN3JY+r6B018Lh0rC0TFniLAcafd/BIgSueBMaa8KKV976prK8pAQl5L4sFOrZV69ENB4MT2UCO
 VhDXmLWteg7426vYu77nvncpW5pog1aCnlo3I2x+oBkubAC+vE6rMfOPdc1l7dZKTvYNh6Xeon3
 QnxxcZfTVvUGNgwgDUr958fQpFdCCmnPpO16lqan/ntPGZQhyzKPK9hKTCc8v/9r0g1zofRehLD
 uGQNEbm8Wpu9FCTQCmySMTJ0XWfhOkKm8smV+RyQgOQwck=
X-Received: by 2002:a05:6808:6703:b0:467:5571:7f3c with SMTP id
 5614622812f47-46a5c63b053mr2328898b6e.6.1774479950666; 
 Wed, 25 Mar 2026 16:05:50 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46a7099df08sm581446b6e.15.2026.03.25.16.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 16:05:49 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: kavin.gunasekara@arm.com, Meet Patel <meet.patel2@arm.com>
Cc: andre.przywara@arm.com, bmeng.cn@gmail.com, sjg@chromium.org, 
 u-boot@lists.denx.de, xypron.glpk@gmx.de, 
 Sughosh Ganu <sughosh.ganu@arm.com>
In-Reply-To: <20260309165505.4001705-1-meet.patel2@arm.com>
References: <20260309165505.4001705-1-meet.patel2@arm.com>
Subject: Re: [PATCH v2 0/2] virtio: rng: Handle oversized return buffers
Message-Id: <177447994943.3508238.16817892343502278605.b4-ty@konsulko.com>
Date: Wed, 25 Mar 2026 17:05:49 -0600
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

On Mon, 09 Mar 2026 16:55:03 +0000, Meet Patel wrote:

> The virtio-rng test to verify effective handling of oversized return
> buffers checks that an (undocumented) error is raised, instead of the
> real concern, which is the surrounding buffer integrity following a rng
> function call.
> Update the test to check that the other contents of a buffer remain
> unchanged instead of looking for an error code.
> 
> [...]

Applied to u-boot/next, thanks!

[1/2] test: dm: virtio_rng: Update virtio-rng test
      commit: 8019e3b35df5e780a722fbcb1bf6b2f63eaccc9f
[2/2] virtio: rng: Handle oversized return buffers
      commit: e0eef12a1f46bf946e24050a1da0f067c3952b89
-- 
Tom



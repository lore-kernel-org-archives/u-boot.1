Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCF4EDEBE5
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 18:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A04EE83F63;
	Tue,  3 Mar 2026 19:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bohPBLg/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0299383F64; Tue,  3 Mar 2026 19:50:58 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E228683F2D
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 19:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-46398742245so2286923b6e.1
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 10:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772563854; x=1773168654; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dl3Nx7zdwR7MRBV/YngvMnoq8BcmyTZ4zSkzbsUroi4=;
 b=bohPBLg/BTxuOhJLUmehRGse3wuejWCBZ2nCL3ZWx1I8+JjoxXyl/yfBIrR8Giw6Hf
 dxjtG9l6ZcUha0Lr4VAipnWz8Q0+Pgdu6BBh0QSeZmn64TEbbi77AYUH3hk5NH3T+2U3
 ukdwyb66pHoEV1zCatkiOZ+RMLkPdYs1hIyPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772563854; x=1773168654;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dl3Nx7zdwR7MRBV/YngvMnoq8BcmyTZ4zSkzbsUroi4=;
 b=JjrPbNAxfJgvNSHUXBVIliSf1anQ3C/f3Eb0+ZPC8zLN/rcfUsn0FGEKArdGDTY00/
 7uy3oGFy7uEbEI3LyunptUbjru47BnpPhIHGq3jXsHbCc0btgSpzE0wGSxJlQKZuPEAL
 xzT7xEsS4PmWgRAfb9OX1jsMP4zZrQt6Td67IxpGTl4zxKhrJJb5B/K+I/Et9R0N21Uq
 iyyIm8mYhYNG7S1gv09jWUruOikfAM2v9brokm+jjENNVwl2Ukm7RYH7T49RCYIb8J7j
 XV5ONW7G9ZsVqeXVuhqldVC7Y0zlkAUA9J0PTE1zhCzMRNNrBQl4VRdKhaTpGhArdDt5
 Ofjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOp+fbw0qXTozchZxVTnpwG5RlopC6mkwczqUT5zAgoMxYShcfVsqWbSfxYZKVFWOGpYjwaM4=@lists.denx.de
X-Gm-Message-State: AOJu0YwzH99PWP/Y2jILwOOs79vFCCdRjy9jEyZRxcAU8tidbJrQlnJL
 UJllih865AOhApMZsJL6zb8F1RlxFZcVsgedZ/I0+ORRQd+AJHmjqdsJQlpwMJ66wN1jK3xE2Ro
 q7FP7rLQ=
X-Gm-Gg: ATEYQzyayi7qZiaWcwCoXk3x0LM+G/QnSk04FbPxnAUNuCxOL8aOYou5b10yV++bSYH
 IkxGLmlD2/Y490AaE5rypxVH6a3ZX3t9193AkZX36VOQVfhzpgdhpUREQBSVZPpDKOWWNZCe3mz
 W+0n+BkJIeN02kb5Yrq9gp+st6RDk5R482BP2ev9nuOg8foTAK35H20zCJViNBCWMk9fxB3hAUy
 h6oViaTX8erEeBfNz6Arf6M2p+gX8KFnTR6t9zlhk2WD76XJKYpuopdv2ykN8LI36AQlifZ8j0r
 ZNpcw8zGYUy5cjhYehgkMT6sMRLDjtFmOjSreKgSEp0Ca62iQuxUoxgYEW1KcKZvX1awf27IRhC
 Dw+NFfvQWiR2KEmABQbc8LZ/mDg1Z3B1G/1uCjwLxXb2XhyxT9C7VeDvYjfHT3AR000/XQmcGT8
 98Uzb8cTBQ1aNPfiyX6LCZ38ZzxXJiqbvEbLhwu1QbB4V9vsjzhjIbDeSuwU8SQ2ZFs58AbyHb7
 8CbXvOTWqzeozPMDDZUQuY6s9UqgMt0OHBN+fm8I9+T9SFFIw==
X-Received: by 2002:a05:6808:1988:b0:464:a06d:6037 with SMTP id
 5614622812f47-464bebe44c8mr10871469b6e.33.1772563854573; 
 Tue, 03 Mar 2026 10:50:54 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-464bb605f15sm10180475b6e.20.2026.03.03.10.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:50:54 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>, u-boot@lists.denx.de
In-Reply-To: <20260216172843.1102036-1-hugo@hugovil.com>
References: <20260216172843.1102036-1-hugo@hugovil.com>
Subject: Re: [PATCH] drivers: cpu: fix syntax error in Kconfig
 documentation
Message-Id: <177256385397.3975993.14233560987102098013.b4-ty@konsulko.com>
Date: Tue, 03 Mar 2026 12:50:53 -0600
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

On Mon, 16 Feb 2026 12:28:39 -0500, Hugo Villeneuve wrote:

> Replace then -> they so that the sentence makes sense.
> 
> 

Applied to u-boot/master, thanks!

[1/1] drivers: cpu: fix syntax error in Kconfig documentation
      commit: e15b78bcf72bae42c7d198dfac5317c1058b8c26
-- 
Tom



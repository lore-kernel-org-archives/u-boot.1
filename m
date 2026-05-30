Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203F6CD6E49
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 18:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2A8F8485F;
	Sat, 30 May 2026 20:37:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KUmiIDeh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DBC2846E6; Sat, 30 May 2026 20:37:03 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EABA884837
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 20:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-484cf882ce5so11321707b6e.1
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 11:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780166219; x=1780771019; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tjqyCTvoSRQNXgNQ1FvuOja+yrwoR438DQLWKrZBMAY=;
 b=KUmiIDehqwerj3AFDwBgUIA2rqnVt56SqfOyIDEvpe45m7I7fvjJ3NyphYBN1VSsME
 D8iGsvfzS2XNkpNUTA38aULE7Dmw2wOkgRptOYqq011lO3vuWkfylCuSXve7Kl890Ac6
 iCzL25FLW3oW6V2K5XOZZxopiCc+4wjObZghk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780166219; x=1780771019;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tjqyCTvoSRQNXgNQ1FvuOja+yrwoR438DQLWKrZBMAY=;
 b=S/pZTVEQGI6oLnLDdrQtlAEa2+cj4bceAGuvYk5izzSZuPP3tDyRKrpOOBEVW44bug
 kppNuB5WGTOw6Hcex6pUI3HLSzr3u5Vbks6UwlmyKvz8KP842HqfUOP0eeMWEhujpk74
 M3/7StcGhjCdfefUhdmv/Rka3a9W156EeeE0Cz7czfIg+p5S2LG9pHMxsBJ1rlLJ8l5j
 9fL/2esqEgq3/8F0hcg8sATiZJrw5c9KSHNn5Z7bjSfkb/eordHIsTq2izaLiYO0aJJz
 uz/ygE0TnvkgNaz8esQLHPZHv9oSlgpyIeqWjWp2ldus6WyIhMJoIqlEGeqeQSii80OZ
 KQCQ==
X-Gm-Message-State: AOJu0YwdtRVuEqfpdMv7CiQ9eQYghLUbVrmZmUVJ8AeLXchpbX7FS/lR
 VHXlwFwGXYi6umrLv+NVPNxR7UurfiaW9gbW1KFJnCGku667Mox0H8imwVSe6wp8j0BoXgKt59N
 YYhYA3UU=
X-Gm-Gg: Acq92OE0TnMuzrgYfQvcc9O4+Pp10ibZtmvid+gkNbHFXWN+rbEBTW6EqsqF6cYsEsD
 9P23//O8TN31MQ0ewZLp2CMQkh+rVjSXNEavv2aBJH7DB6r0m+dMEO4PXkNxdLonk8xhwW29dWJ
 X3tfum2+la8zZW0hDi/bVB1dBAmaAjM30PBu9SDi/w+felHD48Jf6Tb/tHMk4CCHVO0dTe4l3N2
 8vDTcDKRfDUCgzdBa9SiFOkLdsVIwJ3ok61ZP87my30a3NIS5gn7zRYdyNguEGAM9/Dsg2fNT6d
 EXjs5YvTfqQhp7HavQtdvTckthRLRwzEt2wQn7FMc/ai9BtGsOTCzRUlnx+uPh6CdTVc1fBYJXA
 zWQ1g0hxonVGgKJykrNkSnR/ud2qx8pgm2bqWMXJSkXyS99zInX+je80sMvCjQ6Zmwl73XMCOaG
 ZGai6JMW/Ve03JM82GWEhIuk0syrngwqsxLyMBoTHZvIxCuuqp79BPCb5jkRYo/FTOJvVMATopu
 cUdH/5OO9CqWMSWLILRkAJqirhOlkntNWXFAUXk/gR7//RPaIdZoPA=
X-Received: by 2002:a05:6808:3a05:b0:467:e7b:6fd5 with SMTP id
 5614622812f47-485fb4c5c1amr2189547b6e.41.1780166219585; 
 Sat, 30 May 2026 11:36:59 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695b8f662sm4245130a34.4.2026.05.30.11.36.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 11:36:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Aelin Reidel <aelin@mainlining.org>
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
In-Reply-To: <20260503-simplefb-memory-region-prop-v1-1-21828b8cf13a@mainlining.org>
References: <20260503-simplefb-memory-region-prop-v1-1-21828b8cf13a@mainlining.org>
Subject: Re: [PATCH] video: simplefb: Parse memory region from
 memory-region property
Message-Id: <178016621899.1038765.14300281888118067800.b4-ty@konsulko.com>
Date: Sat, 30 May 2026 12:36:58 -0600
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

On Sun, 03 May 2026 21:34:53 +0200, Aelin Reidel wrote:

> Linux' simplefb driver allows setting the memory-region property to a
> phandle to a node that describes the memory to be used for the
> framebuffer. If it is present, it will override the "reg" property.
> 
> This adds support for parsing the property and prefers it if present.
> 
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] video: simplefb: Parse memory region from memory-region property
      commit: 258310ab39ab740d302335237d0d7d782cbe9488
-- 
Tom



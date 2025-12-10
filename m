Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B12D3C92B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:13:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4EE83CE3;
	Wed, 10 Dec 2025 18:12:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="apwjJZK/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7211183B48; Wed, 10 Dec 2025 18:12:54 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C27C83869
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 18:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-6592f1f55a8so8380eaf.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 09:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765386771; x=1765991571; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXe1wIFL3Dj9s45L89z1gu8DdC8h7bMwsGd2c9ZfJKI=;
 b=apwjJZK/vhazruwteJweggUAUogssNzOWXTrqrsxelYrrJSsYvzXLQqYg1Uf5W5KtA
 oNIRnV3Qm0I2lTeqjjh/K6v2QpENPRbnGunBf7AHmtiFk6wTCcHreo/UugR6WyLNHwUu
 ri1nItVm5N7pkBKqWMuTOnVxAzVMoCEwh/kgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765386771; x=1765991571;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YXe1wIFL3Dj9s45L89z1gu8DdC8h7bMwsGd2c9ZfJKI=;
 b=BU1liOpOBAFKbqlhVwOa52les8qK0Gd4FZcP95z9beLh/+wwoJZLuHiD1ufF+7bxrX
 fc5GBjFgceUjXagxX+BAImqS06r10AX79I0IyOkD0P7r8QWD1cslv8W31bORUkRPc0Bd
 ZZ8xJDxEru17wDzRfg3Spv/FYFYLvUaxuakR7qnmdHlGjSb9U2leJcUBoi9HNpT+qTev
 YFKysYLmYv67eH4k2/KqMjGl0fj7dCFQMCkciP/6lp0y9CqkbuuvDFHkpFHZtR9hsa/S
 i3CGtxntqvXadh+YzsmlRvEjHp/lH9eQ7bSszkzB+/hR8yepcnSIa7txaKpFxjEzAMiF
 5DpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSS1dpSsZ4JhEM11qLVLgAW9sRwvVG/pQhhFCiOAWol2XOZJ2VabtTOxd22R0GJadwTyf0M08=@lists.denx.de
X-Gm-Message-State: AOJu0YzK9XWqMUX3RNbfnQf1ZU8hJ44VclRyZjwIbJn78DwcrIAA0ON9
 cES0MTxHjWJ1HeQPeNgF8sbzPddFvDOpPLluLHoWD0bFZMHbtibi/gkWQ0JxJTXp6EY=
X-Gm-Gg: ASbGncsRcy9/JgFdVxG6b4y9RAb2imZsPdgEBjYpPRuVwPDm94K/vjkFgvlHrsEhJ9o
 ZtpjFlfObSYgWmI7NMFEhiPLwZo1WOhDO3V6Bk22nAlS+aKTSnquGBrNI/5poXUBBtbsbiMYiFC
 ArSdN+rQWSNgGCxeKee1mXIFlkefOQ5MOg6oE8Pc9vhojyZugIW9a5T3nlCiVbN0YnWTH9daGET
 Clzdl6RE7kAWlfCrqNnohQ9hmYDv4hUq9zGAiuhklcKeVcAOLkoizdCp8tnT93bbnSmVcLNojeq
 6AoTFm2+rSuhTu7uREDSDScX0reowwmvVL+F+gysWuz9T+bJ/XxDk66YlqIC+EPiC3YevrLXYMx
 aB2O2EabrY+GoulHwI47njh7pwMsD5QRA3X1IzxX/SiKyqTsTdG1u36I7tHV7P0rw8WWWXBcuKW
 iS928NCYH+0GcxmtjLrJgVFZTmmgzsMzufkHmPsgEIVmq98Xtt
X-Google-Smtp-Source: AGHT+IHbSpehvdXXGWocLXq/j3ytw1BvkCWH/+Lo2+p4MIvGPsRLikYBPI1DHw/C1ZwHecW15p6fPA==
X-Received: by 2002:a05:6820:810c:b0:659:9a49:8e7f with SMTP id
 006d021491bc7-65b2ad1d1f0mr1691499eaf.79.1765386771070; 
 Wed, 10 Dec 2025 09:12:51 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b3480fb94sm34528eaf.11.2025.12.10.09.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 09:12:50 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Beleswar Padhi <b-padhi@ti.com>
Cc: afd@ti.com, jm@ti.com, nm@ti.com, n-francis@ti.com, u-kumar1@ti.com, 
 u-boot@lists.denx.de
In-Reply-To: <20251209055043.1410085-1-b-padhi@ti.com>
References: <20251209055043.1410085-1-b-padhi@ti.com>
Subject: Re: [PATCH] configs: am43xx: Migrate to CONFIG_SYS_MEM_TOP_HIDE
 from CFG_PRAM
Message-Id: <176538677026.3321367.5907731219633418173.b4-ty@konsulko.com>
Date: Wed, 10 Dec 2025 11:12:50 -0600
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

On Tue, 09 Dec 2025 11:20:43 +0530, Beleswar Padhi wrote:

> The TI AM43xx HS boards have been using CFG_PRAM to hide the top 64MB
> firewalled DRAM memory from U-Boot. However, CFG_PRAM only prevents
> U-Boot from relocating into that memory, but it is still open for access
> for any other usage.
> 
> Therefore, migrate into using CONFIG_SYS_MEM_TOP_HIDE which reduces the
> ram size itself ensuring that memory is not visible to U-Boot at all
> (either for reloc, or general usage).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] configs: am43xx: Migrate to CONFIG_SYS_MEM_TOP_HIDE from CFG_PRAM
      commit: da54deb1ac8ee65475c7dca556df751b7e31806e
-- 
Tom



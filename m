Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB423CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 15:18:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BF7D84704;
	Thu, 25 Jun 2026 17:18:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ekyvmvpQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DCA084894; Thu, 25 Jun 2026 17:18:34 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C9BF8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 17:18:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e9784666b3so1878302a34.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782400711; x=1783005511; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPX8lYU3dgjm590kJ6H3w+KmEA0ZALonGUEULAdLGYE=;
 b=ekyvmvpQpIAXNvw5VNcnHpDD4R3Pxp2uDLi0REbIXRvDTB+LvmHjudomV0hFwq4PbB
 co83q3V1MmzI6HiI3AKHBZ6nFmz89MKhfkcGr1tmlOiRJOxkymYE1CwkA+iFgtZeO4v1
 OdIjdbWqFouPwhXucNhjgx7N2vVJ/hsLlNT/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782400711; x=1783005511;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TPX8lYU3dgjm590kJ6H3w+KmEA0ZALonGUEULAdLGYE=;
 b=P/P1UVueP34kGZM6ACVYtBPAJJ67Hr7WY1bmLIjYpQvrw7WBnu+6Sl9Jw7PNk4AuBO
 owyJXzds8rE+w4/nr9S0/q5aJvH75fsXHypUDaYEgWpkk01EQVFF50Ix6H6h13Oy60xh
 lOmwyGIKBIRViwTZzJEHuA0pJe0+6TtPM6E9UizzOJW9yaqMb6e3iDz7X5UZ0WEaTAOr
 PK0+XvyqOhMsEgUIxyh/oosCsPWMlhYkdCkKajNDi3BvQGqmBij39ZjJv0jznfx46QzK
 B8xTRwTlfSD5AdQYfNffHrnjgNnuv03YHexXPiYDXTjbFzKx0LYRFKeC5rhynl0Q5g8t
 Hy4A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/mC1WYNf7qRdHSm5mBaTZQdtOdRfvgVp/CtpYJUcojnoQj0U5mZDA6JXNOAhMNsq0uAvyLQXU=@lists.denx.de
X-Gm-Message-State: AOJu0YyY+OodAjuHQUHBeRAYIeE3Bxw0axOHNjeVMKIiONmJsiCMcm7N
 k6u2zyW0iWoz8FVVSbkU2tQ4GqPioSOTS3xq/C5S6mfJhCskwulWSw4THUhK0DZqGfqmR8Joy1N
 gYb4VHvs=
X-Gm-Gg: AfdE7clOM/NbNpobhFo77ROqFsN4SXfTfeJ7agc6QW6AMk1RBYul3kPDOrlzy6irGuN
 JhU01p78v8OZs3F5QPkNPwTfAZCdJMKeyR0+G/TxFYoYmXLIwZWUK8SwZjZEwFuGeFucTbFs6lM
 1cnYERWnyyLcb4frgJaD+oovB6Yj6gaY7BPgqsoI83JskOpw8hY68FUqxv29Y9LOpEj6OOlpm5R
 vM/2nT07Fz9xt7ooGisC17scIYoJnP7dNuRsrbND3z7K397TqkkDMPeiuqZraVzG84aTXe0l2PI
 3bPMvnyOXho0r3ShP9774P6jienTrVm1ZG2ATwCdP05to4oI7JFLBnq19omd+/E6Tn3F8+Ue1pL
 wvn6I/Emf16xRTMrdNh6VyPwnixe3qDysi8QN2hsKNa10rvsur2zOqupeHK/QpI90JiQYryiTuQ
 xVSt/O4eA8Ob6ja7BstzntvQNPXmHsC3L1DvOl1LELHp8/DsfSTG4fiiEwUY7eEItbtJ/flyunh
 ztMVInTi4aj9q4DfhMdn65WJcurDb+XCasbE+8=
X-Received: by 2002:a05:6830:25c6:b0:7e6:ef2e:28a5 with SMTP id
 46e09a7af769-7e99c2050afmr2966431a34.15.1782400711083; 
 Thu, 25 Jun 2026 08:18:31 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e94429e0cesm14251742a34.21.2026.06.25.08.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 08:18:30 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, anshuld@ti.com, 
 sjg@chromium.org, christophe.leroy@csgroup.eu, u-boot@lists.denx.de
In-Reply-To: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
References: <20260617074846.84362-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v7 0/7] Relocate U-Boot in the last bank
Message-Id: <178240070996.3860609.12716856774955880596.b4-ty@konsulko.com>
Date: Thu, 25 Jun 2026 09:18:29 -0600
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

On Wed, 17 Jun 2026 10:48:18 +0300, Ilias Apalodimas wrote:

> There was a discussion recently on the mailing lists regarding our
> management of memory above ram_top [0]. The tl;dr is that we have two problems.
> 
> The first one is that U-Boot always relocates to the top of the first available
> bank unless there's special board code to sidestep that. The second is we don't
> successfully deal with devices that can only do 32-bit DMA.
> 
> [...]

Applied to u-boot/next, thanks!

[1/7] treewide: move bi_dram[] from bd to gd
      commit: 1174c99ab421168221be372bd83a4143bf5f167d
[2/7] common: move ram_base calculation to independent INITCALL()
      commit: 15b35e4289e11f1ab201701dfb6dc0232b30be48
[3/7] common: Clean up setup_dest_addr()
      commit: 0943f107ce4adb47d4b01c06e046dce130a1de50
[4/7] rpi: Add a local get_effective_memsize()
      commit: d19d9e1c064b6c782959d1da7bddf1e9da1c55d4
[5/7] common: Add an option to relocate on ram top
      commit: 55a34217698491cc0bb8d53d630644dc8756629c
[6/7] configs: Enable RELOC_ADDR_TOP on arm64 QEMU
      commit: aefd4a769bb6727978c408ff24b93ba9047d535d
[7/7] doc: Add a warning about using RELOC_ADDR_TOP
      commit: fb537c85bca0e3d29a62fe119181bf1744b8c91a
-- 
Tom



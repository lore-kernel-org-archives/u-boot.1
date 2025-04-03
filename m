Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037A3C36014
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 02:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60F5381F0B;
	Thu,  3 Apr 2025 04:00:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hLX4A96d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8763281F44; Thu,  3 Apr 2025 04:00:00 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B9FA8035B
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 03:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-6021d118877so220917eaf.2
 for <u-boot@lists.denx.de>; Wed, 02 Apr 2025 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743645597; x=1744250397; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kLwbSfLflw82++4V2hn3OSfXRdgidkypnfAIbbMT3U0=;
 b=hLX4A96dNmrgbSXudLNfOBGrwN8kFabKkF96iism1SfW0JFjshFlguf4Ld/D5alPDJ
 eaL/0JlPhMZ6Usfg0eCq5Y4TT74auEjqjt1/h33LWK6Xyss+D8yOi1cun1g64XhoL/4O
 VLVDVsidY2oHvS5PcJrlG9to3BcY0a9EsxSYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743645597; x=1744250397;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kLwbSfLflw82++4V2hn3OSfXRdgidkypnfAIbbMT3U0=;
 b=IF0m1R33mWzhTSLUnXCvbirFqaQhyGJNCt7lFb3jJj4+wHLt6/mS/lqoN53EaYaxcV
 gFXJ8g4YbOm1UKqCr0Jc2wyNPwc2apIZs4WjMFs7gyFAIFecerfvMA42lIRNEoDzssBc
 2CUcp4wH5krkYUsvm1Flf1KOU0KZiYCxXQTSwsrXQ5/imXCtjiNREPIlE1JwMa1wM3fr
 Ri6WnH+GWA6aZaYTZfwaAPeQzBM7mwJT5ib82dzp6d4FTTGntui626g1B7mGr0ztvfmz
 Q82tf58d8Onq76BdYf6GztPVbbKHGau/YCB4I9VXtnbxtBTvxd/bygdd6cNXFNfCy6SY
 AN/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX65DqSF8RDbyckiamW+wQcyvWCr4z/e9wA/sOutOW8GdYMQ28BGwV2wtfR+CMKkqBIrgcIuHc=@lists.denx.de
X-Gm-Message-State: AOJu0YzwCLWWDEUhUY5bCDysJU36qEfHTA+sxKdDkPexWntTYF/Hn3e/
 ZjOnCS2reOJD+iAnaSVzeqSIJxiFSAKL+6IJh4YXB252aAPtiUPcFZx7Nose/WE=
X-Gm-Gg: ASbGnctpJuAG90SQWLVuteRtHEwAfMbpGQI3wrTXAby/mDRJJbUia0TwOYvFGWRfTki
 7UXem82pPS6zA1KrF81E+3M1Csqiei2gH6pHeoaCMdxSdqE/hLsRobbQ4kWDSCXCutle8TD0BL6
 t2j1Hi9hk/XTZ+nAj1Kso16ca8l5GQ/yaM3PBquzVaRecOJnrHApUO9AUqxZrwx6fCKbEukJ0wS
 Mk2cWlJjDUUf6DzYkXgHjmAQ9OjRYFDqbj9/gb8DOMHdKMxAWaYCTHxD1LrwuNeVwyzlqsbDf3O
 ah2ZbmpQ4nUWi5R9ltdyl0HRGiG+GK02BaySNxOk6+ygl8f3iO1TiMNlLDcseY8KhPxywQdG/dV
 LLGy9
X-Google-Smtp-Source: AGHT+IHXNJyxdDEfo/6fuSG2A5tP4bpl7QCQ0bnmDqzGsypUevJnHgzTaIhNT8tQE+bx54prq4AupA==
X-Received: by 2002:a05:6870:c988:b0:2c2:5be4:c01e with SMTP id
 586e51a60fabf-2cbcf45a4bbmr11263293fac.1.1743645597007; 
 Wed, 02 Apr 2025 18:59:57 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2cc8463aad0sm71775fac.29.2025.04.02.18.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 18:59:56 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Sam Edwards <cfsworks@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>, u-boot@lists.denx.de, 
 Sam Edwards <CFSworks@gmail.com>, Sumit Garg <sumit.garg@kernel.org>
In-Reply-To: <20250315221813.1265193-1-CFSworks@gmail.com>
References: <20250315221813.1265193-1-CFSworks@gmail.com>
Subject: Re: [PATCH v2 00/15] Various toolchain compatibility
 fixes/improvements
Message-Id: <174364559512.1379294.15546160892706099529.b4-ty@konsulko.com>
Date: Wed, 02 Apr 2025 19:59:55 -0600
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

On Sat, 15 Mar 2025 15:17:58 -0700, Sam Edwards wrote:

> This is v2 of my "misc. fixes" series, sent to prepare the codebase for more
> direct LLVM support in the near future. This series contains several fixes that
> I found in the process of preparing that support and which address issues
> independent of any future feature or enhancement. I am sending these now, both
> so that their inclusion is not delayed by discussion on my upcoming series and
> to make the latter more manageable.
> 
> [...]

Applied to u-boot/next, thanks!

[01/15] arm: Remove stray .mmutable reference in linker script
        commit: 805377b1f5ae1834e2b1a07dbb6fed94672e0954
[02/15] arm: Exclude eabi_compat from LTO
        commit: 6ba839a0f5473aac8dc038f8601071234c810119
[03/15] arm: Add __aeabi_memclr in eabi_compat
        commit: 828484a7740d4ebfed8db85e4b4569cfbfe66cde
[04/15] arm: Add aligned-memory aliases to eabi_compat
        commit: deba40dd0ba452a3f15a359894e6b50494870d0e
[05/15] arm: Discard unwanted sections in linker script
        commit: 16448c443c8cacba7dacb3e919c0b414f70b8a7c
[06/15] arm: Replace 'adrl' in EFI crt0
        commit: d5734b183c3d578fff1c1e81e46a1d04342edffe
[07/15] x86: Fix call64's section flags
        commit: 8c39dc549b0de155c02a2b39f01dae19775f41a5
[08/15] makefile: Avoid objcopy --gap-fill for .hex/.srec
        commit: 86838a1ddc8a0e5b5f548a5051e5e68f90fb6660
[09/15] makefile: Add `norelro` linker option
        commit: 7a8121fe6d314b314531eee7487272601f469c1d
[10/15] makefile: Add READELF command variable
        commit: 586bb720e776396208df399874665ae8c6eb81e8
[11/15] arm: riscv: efi: Export _start symbol from crt0_*_efi stubs
        commit: f692540b24a7775e43f1d315d3e13a5d3ed21dd4
[12/15] efi_loader: Move .dynamic out of .text in EFI
        commit: 1755071db7d95fa0b95e9f9bedd3785e2abc10cf
[13/15] scripts/Makefile.lib: efi: Preserve the .dynstr section as well
        commit: 9ca475a6b5da06908a70d1eceb439d480137d69b
[14/15] spl: riscv: opensbi: Error on misaligned FDT
        commit: 17d830cb4b6cdbac56d41938d455820fd7a96a89
[15/15] spl: Align FDT load address
        commit: 358d1cc232c30091767ce192e74169e7861ae58a
-- 
Tom



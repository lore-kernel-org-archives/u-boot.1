Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8570AC83F09
	for <u-boot@archiver.kernel.org>; Wed,  9 Jul 2025 14:23:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14F4C8344C;
	Wed,  9 Jul 2025 16:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ykxki61/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 735F283577; Wed,  9 Jul 2025 16:22:07 +0200 (CEST)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6043F834EC
 for <u-boot@lists.denx.de>; Wed,  9 Jul 2025 16:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60bd30dd387so2796418eaf.3
 for <u-boot@lists.denx.de>; Wed, 09 Jul 2025 07:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752070924; x=1752675724; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=N6UswDVoNQmo000lVq/rpR0KZoRzXgw0ihbHLWcI7QQ=;
 b=Ykxki61/AuOApirGOc5H2J0jLk09XdGAzt/oHqosqyS9olHEDzGPQQXpkbpb/swLb2
 fZ6KX6b6KJAW6uBfLrqta+I/X/sL/UMgQbJ0cFfhAWjm0445fLX8BwlWnOhtd6BLsZNi
 7X7GFN6SLFPOoVAsh2rTQfsJKoIB7MK1OCmJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752070924; x=1752675724;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N6UswDVoNQmo000lVq/rpR0KZoRzXgw0ihbHLWcI7QQ=;
 b=bp28ddtVutephQd9jPfj3y/mEjGgEE3Plk7dKZMVVINFlXsCzagrCjPubpNWtD24xM
 86j08lIRHZE/g6sJ17FuiXqZm/Mku9lk9nTjoywfsj0BglDGhU/+0MypCU0d6+2397WM
 N+OtWDJ+wsk3rBMCLDlbiW2ph1gxDTfJX4mvMYFvgm5b2JBNcV0EziH56OjmMwdUOZJL
 AiFynoUhmMP71AqXYmEVwFGTYWJwk1APGbA+0ycu/ubSzHBTdT+VDWsh+gq1oH42Ov/A
 Qsf92qCP6mIv0RBSWw0JLOtwJ720nC6KPN6+/g3mbLL1des8YMD9JkY6X9oWJBP/cj/o
 r0oA==
X-Gm-Message-State: AOJu0YzzLopPRV51Ns1/HGQYoCzJr6mVaoV4NOipFoSXTFI9y8zErTRd
 fIKCQQasvj3UL3tlbVAA0xdqB5e5n5rHIYukne/QKcf5iLb00s+jeDxfJJ5hPTZRK0RJbk215tI
 JBJj7G1M=
X-Gm-Gg: ASbGnctRhUewITUxfKtL4ha+FezAjvSYkr+5BekHtFlb+Tl4qjMOW1GxEewcP3iJ3k/
 GaqbLhWnE+OyhM0b/lQGj5BvOo3CQ5R8zeL1Vs8fxfJHYzeV8Pixt0ox0n8TKLlsu6bWK1wOXCI
 RJ/zchGj//7D2hnVhX3yTZebGrwaa019idrb7+85H3KHih+dONI3148XSpYjXyUKCxbls+TKdgr
 XKhS58uR4Lfg4x+Wchp2Th7LEQ1Ij4XALDy8CfU0/EejE0d/8aJK8ImnMr634AZWDnRdlsKeFqI
 HTb7hO/Eez6qVoErmJPT8t5iJA9ZUDvKbzAruqarbCZH1OwBxX7aOvsgnOX0u/qpUr+fAGyCFij
 SbGiGA2dT6gEcP21z0ps=
X-Google-Smtp-Source: AGHT+IFK6Gw+fDTgWCOGAfDW8q2IP/PGVlnBfjEn+xWl2CkVKjId8YJ2l6+kHlTqBd083srjiU+eaA==
X-Received: by 2002:a05:6820:3090:b0:611:f241:b8f5 with SMTP id
 006d021491bc7-613cceb191emr1842902eaf.5.1752070924077; 
 Wed, 09 Jul 2025 07:22:04 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac83esm1919975eaf.27.2025.07.09.07.22.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 07:22:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
In-Reply-To: <20250627172947.3876739-1-trini@konsulko.com>
References: <20250627172947.3876739-1-trini@konsulko.com>
Subject: Re: [PATCH] fit-dtb.blob.gz: Pass "-n" to gzip
Message-Id: <175207092289.1813324.6005336372323440754.b4-ty@konsulko.com>
Date: Wed, 09 Jul 2025 08:22:02 -0600
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

On Fri, 27 Jun 2025 11:29:47 -0600, Tom Rini wrote:

> Sometimes when building a platform such as imx28_btt3 we can get an
> error such as:
> 
> gzip: fit-dtb.blob: warning: file timestamp out of range for gzip format
> make[1]: *** [Makefile:1219: fit-dtb.blob.gz] Error 2
> make[1]: *** Deleting file 'fit-dtb.blob.gz'
> make: *** [Makefile:186: sub-make] Error 2
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] fit-dtb.blob.gz: Pass "-n" to gzip
      commit: 1930a7df10b18f0f4b67d868632896233dded981
-- 
Tom



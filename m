Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5552FC6165
	for <u-boot@archiver.kernel.org>; Fri,  2 Jan 2026 23:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 317FC83B63;
	Sat,  3 Jan 2026 00:23:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ML12ISTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11A1F83AAD; Sat,  3 Jan 2026 00:23:45 +0100 (CET)
Received: from mail-oa1-x41.google.com (mail-oa1-x41.google.com
 [IPv6:2001:4860:4864:20::41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D96FD83AAD
 for <u-boot@lists.denx.de>; Sat,  3 Jan 2026 00:23:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x41.google.com with SMTP id
 586e51a60fabf-3f5ec7636e2so4391276fac.2
 for <u-boot@lists.denx.de>; Fri, 02 Jan 2026 15:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767396221; x=1768001021; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlOaW8uW/gf9uyKdciYGZ6+i8BRx9N30IYC5GWB6EaA=;
 b=ML12ISTcbjyJgcpw2/1IGqb6UmbKeI8Cfm9hwUkEpS2SbYcWUyNil3dY8ZWOu3T4UW
 cF+JWmzfairsBJGlRkkgK3m4b49HKJLMGPzwhuDmPokYnUCSyznOesdXya3KSmd9kXdp
 R0P9mrb92rTFh0Im4c++ub0h4BR+Z2y2xaZ0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767396221; x=1768001021;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KlOaW8uW/gf9uyKdciYGZ6+i8BRx9N30IYC5GWB6EaA=;
 b=PJuW543QUX2WVJBR4aEung874NJGbewEegsvMc5b2LdWPm/saF3oJEkMNsYq1+GYWx
 3zlLsO6I321PA1aEF8VHWZRIp+pTIn1SHguYhNAcoWiOFxHnUCchllW0HhVnj03gl9IR
 WxTLA8HaJUoCNA9o+Cpf6PL9uMKyqZM9keIVNY2vLkNkjqPeYsduxCtfUf/wJ21r+lNY
 I5+nvhht+eX0MdKYFifmIspRAj+TZazYKceajd8Fq1bdAxDhjv5D1RRNqznSIpN+r9cn
 u7Tq2SWcJ/RG27R1kw4ftwZAJV3htSAyC5Zajv9DfQoxwu5nicuh5GS9NsZQDm2j3QoN
 ygVw==
X-Gm-Message-State: AOJu0YxBnJxd+UPLCdvUurOAyae+AdVFghkdIynl3/8SvSMPVe8JKO4b
 W89/kX8BHB5UwwrHyOq0CNEbJ2L7YR7w2/NX9BLwXITrNZBuakIcjCpIWnvOihJUycE=
X-Gm-Gg: AY/fxX5Ci6Ew8NhTR+cgZYUVZozPWEj57J/sNfUl37j6yLvSGDouxgt5a7L1Dw15+gY
 FgTT621of69nKlOGhkazFgCc9iJGDZc3/OUDKxoPgcjbLR22vyPuX12P3XQK85CjfQIjVFRBybj
 tgFfyEpBGlowcCp1CSAe+EuQOvn3SBSt83rtU8Ur5ehL1VDXLyV0UU7OOwp4/2H1CiQ0ozSjo69
 PkxQXyr08djw/ODwbB7PKO0cAjYSe44H83NylfkTIiX3j0i1pTrv4OwNx1ZicbhmQUv4Op2mTNS
 DO2s5JdK8Lp24NrVH3WOCudPohe8K2/j8/pA5Q/I/z6u+ij0QpdJj3ht5ec0B8n3HBQWvARAJn9
 ka3ONZY299Rwh7p811AMmUmVGBKB5ihTgdX/zSvY6BsJ1LpL+piQOO9oyA1w3WKWYBd9Eyo0p9j
 QND3yvyPV0gIABqDAZXKlMrHX4Ime0tdP1BYEXksDR4SYvVnR7CNBTx2ZvEY2LJe4nmZdeRFV0Q
 ix/T4hx4OmTB9TveBKfi6z+WyRw5SuByv8aUtuxjjx4R3B1
X-Google-Smtp-Source: AGHT+IFUTvvM0OLRxN9qU+MStmnI14+BzRJQ38IiO7Sod4hX2CoBlXRzmnIRWaQX0Ann9zV7E3IJlg==
X-Received: by 2002:a05:6870:20e:b0:3e8:272b:effb with SMTP id
 586e51a60fabf-3fda5662a4amr18964584fac.13.1767396221373; 
 Fri, 02 Jan 2026 15:23:41 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaa4e0d18sm24711983fac.0.2026.01.02.15.23.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Jan 2026 15:23:41 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Angelo Dureghello <angelo@kernel-space.org>, 
 Huan Wang <alison.wang@nxp.com>
In-Reply-To: <20251228031753.662212-1-marek.vasut+renesas@mailbox.org>
References: <20251228031753.662212-1-marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] m68k: Assure end of U-Boot is at 8-byte aligned offset
Message-Id: <176739622039.296893.13854332929501751143.b4-ty@konsulko.com>
Date: Fri, 02 Jan 2026 17:23:40 -0600
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

On Sun, 28 Dec 2025 04:17:27 +0100, Marek Vasut wrote:

> Make sure the end of U-Boot is at 8-byte aligned offset, not 4-byte
> aligned offset. This allows safely appending DT at the end of U-Boot
> with the guarantee that the DT will be at 8-byte aligned offset. This
> 8-byte alignment is now checked by newer libfdt 1.7.2 .
> 
> 

Applied to u-boot/next, thanks!

[1/1] m68k: Assure end of U-Boot is at 8-byte aligned offset
      commit: 9ed99e2eeadb4127b8de2ecbc066de6180394355
-- 
Tom



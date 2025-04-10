Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C99BC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 20:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2A0C83AE9;
	Thu, 10 Apr 2025 22:14:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ny4rDLOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBE1483C01; Thu, 10 Apr 2025 22:14:20 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BECC283AAE
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 22:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2c6ed7ec0a5so544554fac.1
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744316057; x=1744920857; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjJhyl0/YVN8ZTfVq3HWLcoEfeIDBJruk3lwf0BQG30=;
 b=ny4rDLODlefsquA9LvmK3fL2StQLC5GyXHTheh+HuND2vr7jeB/AKm8Ty1w2tWYP9z
 m8oA18GuqiplVmzYRHe3+Ls9XcOvZ5oE6875ZwSCEUvr80Rm4kIVuUBZGzbj1eroX9MY
 5HYwa64j66au7Xy0arXHEr7mmBLG0uoOndzkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744316057; x=1744920857;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hjJhyl0/YVN8ZTfVq3HWLcoEfeIDBJruk3lwf0BQG30=;
 b=Mb5g8o3iA5xOiHx838YQ67AF72/dPNmMNB4DfHeKbLQfxtsFq/EUCocfF/R7b0eTgO
 myEoD2ZqgDGJ+lThpQ8MfPcwSvNeErkN5ZRgAXjjzx7BBhtWrH+NQN7e/h/QaedLcMyC
 wUNN1+cCDhOGjRxSaNk25sGW4qHNfmBgb2tQwhk68fojQaPNaMjcU2qkrLTbTYVJEuDE
 llik/b4pxddIQHKEO7IKONy9RB4MPkr2eKWtxea7E/GLmgrtqNTj4nD2v16XQAmGdP4w
 pywhaaJ0Jw8ys9GDRA4kslfdUxCrggyjwsgruH9hWnmcG42aJ0JXwZ2V24p1pb/UbKRB
 J7Dw==
X-Gm-Message-State: AOJu0YwzuVMJtsm8AkdnxHUYYLC90Ce9w7GMoBvzPT9jNi5yL9OUUBJZ
 zw21sqUNhhbfdOC43D8xv+xVDM1CwEVXPeEBZ3roG064Wp2I6XC+eON1x+WZrk4=
X-Gm-Gg: ASbGncu25gSYwXJYw703jDyiUcZfVci+83KrTYSN7enud4eCcJ/SP54Bpjca7WiBff1
 OcbPfSNfcWbosUGE5kM3ccm1M38LqhHdqTQF9+8MXUSpIEtN1dXmKrtzsIVPgeV0o8AOjormhdq
 zYX1C3dPfusTw4+pDSBQNsZZ8fRspn/zTy6EmD4hpFwksY2AimvbOVS0FuCGW8KaMo3RpzlUPHK
 sLYh51tInB42421iSz6GBoCUoEFnrczPIqphk748pG/Az0WEFNPaQJjInSGEawrmfIGjFWedDfS
 gW2ErlFl6HJ3twU5+JCo02bu23mOHASMHKbN+kcA7XDiT6GxS89JyfkWUg5NJOlUZBf2hVTOULB
 c
X-Google-Smtp-Source: AGHT+IHAfzr12+azO/lJ3/RwdrZ62l3vOy7bgfaJkm02b0mxXlYdLbvnb+Uj4RKIjcVQITV0E/TOKw==
X-Received: by 2002:a05:6870:17a2:b0:2c1:c10e:3230 with SMTP id
 586e51a60fabf-2d0d5d66e38mr12470fac.18.1744316057498; 
 Thu, 10 Apr 2025 13:14:17 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e73d8fcaasm685741a34.38.2025.04.10.13.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 13:14:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
In-Reply-To: <20250328130214.2607633-1-sjg@chromium.org>
References: <20250328130214.2607633-1-sjg@chromium.org>
Subject: Re: [PATCH] binman: Fix a typo in elf.py
Message-Id: <174431605636.2981499.18302835368466013688.b4-ty@konsulko.com>
Date: Thu, 10 Apr 2025 14:14:16 -0600
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

On Fri, 28 Mar 2025 07:02:08 -0600, Simon Glass wrote:

> Fix an 'EFL' typo. It should be 'ELF'.
> 
> 

Applied to u-boot/master, thanks!

[1/1] binman: Fix a typo in elf.py
      commit: 5a7ad313a12e9667001a926f55c9e4516f128638
-- 
Tom



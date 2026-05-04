Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D338CD3427
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:37:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 107E18483A;
	Mon,  4 May 2026 22:36:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BlKbTE3M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 256B08482F; Mon,  4 May 2026 22:36:20 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C77B84839
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dcd89701acso4289857a34.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777926977; x=1778531777; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=duoe3rvtlDregkSHnZWsCAKvda0bxIor6yRVovOWTAc=;
 b=BlKbTE3ML01tPkFQ3ccY1nmN+cUZfosI5ZEnPx98SHf5FqHDfXGanN/BXyXA+C8w4n
 2pzsLQPwQoh9MMJ7J1PEMQSo4PQ6JcCCBdmmCvm6dJQ1JR4O0/JmExYrsD5FGFt2Ka3d
 dVTTnb+zrTDiFMoEuvrEYzJ4g87NA2IOLfBk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926977; x=1778531777;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=duoe3rvtlDregkSHnZWsCAKvda0bxIor6yRVovOWTAc=;
 b=h17wHZ0ldbdn+IS74WdklPkhy8qYjkTrRj4BfkHAPp6UW1oISPRoRF3l1cc6WEf8lY
 67uE0UMj45PyS0H45yiVswQQUY96IxjizCgPJZIJntdTgmP7nO+zXA3NRQAfG4mWhOIh
 SxBp4ZLZLoflUIjeQwWz7DzsVWrkq4CfTFz2IZoKDbuqvftHFZVw1mt1jcSy4HxzhzKS
 Vw6Iy/AfrwZZF9GYtYQiEP5hDRlUvmLo5rJCNz6ftsPbKGlMLypQQXZ/II7+n6HmAD+j
 gvY/TB8W2gRECBsdvzAPxX5aA2oa3UMEqaz85t2y0Il3TEljbDzMZ2SsszluBSMZBmgu
 ZTuA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8FNXf4sDdXqMhKBmOZrDGx609TDFO4riVi0kjiNibFxyQv1GGxRoFWD/yepeyz3jJru+xXdK4=@lists.denx.de
X-Gm-Message-State: AOJu0YzLtzCCFWc6tS4u8Op8nxSAoSD0cMDWL4cH+6segocQMeozOeLk
 XKlRuFrXIsyMk1KO8j1d/fKsF3brXiuAkEvosltAbe2vI6n95c36GpokSXclDsus+lvxD0/xnN8
 rBE4yRWaFv3o1
X-Gm-Gg: AeBDiesQXD0trr3PZ2BpOr4uQ1cVDl6y6yoeCj49n9fSlF8AwE1lQjCrkAXLxFSbJYq
 1QFmeUSHNjihBvRruSSJnDjFgfN4RP1IX4EAL9ddf5C9hHNoVrK4YSJEk1zKgweXO5KtLexlwR+
 Z9NPzXi7jgXMWXUkT1vE3VIsBKR3MQpIycjWgecMiIVV89zzzsosd3L5q5zdJwrTCK4JM3WsiS7
 KUEdhg1l+Y2h1fI8dnGdlMU1Te73Nic0uu6rk12EZhDfZhZHeERJGttacyrugYATXzNBYSqykOu
 VqIOnoLVhqBoVmPvMWmIYY5055TqDny/j2PCrRdOtJSLL1WCEcr3duAHJgkj7LilIABNjJdZtS1
 nxuNJ+BTPHx9sEfYtq7CZQ76E2sLaZFosJyxxJI9gGKTmq2NCcaVv4M6zL+UlmbwxETD9KL3dRR
 Fkcb+pr/wM+Z3MGh6/kP1EefmDfyyfA6AkAKEDqa0l2th+iz3mkE0HKb+BVTkjcQfKXvm0CZ/60
 BvsPjdUCVmTc5z6X6BSCYSV9j2aytsMk8UhY1J1wH6TZlUOd6ZzFaXI3nBI6cz3B6lyfh8=
X-Received: by 2002:a05:6830:3688:b0:7dc:d601:a69 with SMTP id
 46e09a7af769-7dee14273b8mr6318394a34.20.1777926976778; 
 Mon, 04 May 2026 13:36:16 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7decac26330sm8464401a34.13.2026.05.04.13.36.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 13:36:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>
In-Reply-To: <20260429100400.2860345-1-ghidoliemanuele@gmail.com>
References: <20260429100400.2860345-1-ghidoliemanuele@gmail.com>
Subject: Re: [PATCH v1] common: memsize: fix occasionally failing alias probing
Message-Id: <177792697580.2985766.13954495997179203655.b4-ty@konsulko.com>
Date: Mon, 04 May 2026 14:36:15 -0600
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

On Wed, 29 Apr 2026 12:03:56 +0200, Emanuele Ghidoli wrote:

> probe_ram_size_by_alias() detects whether a probe address still aliases
> a lower address by writing through one address and reading through the
> other.
> 
> On i.MX95 this occasionally reported a false non-alias when the alias
> read happened immediately after the write.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] common: memsize: fix occasionally failing alias probing
      commit: 2c733e6c85576b86358885c0a9462a0337797653
-- 
Tom



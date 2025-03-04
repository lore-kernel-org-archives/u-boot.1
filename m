Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D89E2C282D2
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 16:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EF41805C3;
	Tue,  4 Mar 2025 17:57:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gN3/F8u+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83DB381273; Tue,  4 Mar 2025 17:57:38 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6663E8004F
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 17:57:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6f768e9be1aso65298637b3.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 08:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741107455; x=1741712255; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCa99cZh8u60et2AUCcte+UvJEL8MqQPFIuIBRQgTjI=;
 b=gN3/F8u+VYGAPLpix4n2LuDjTxjmQG/lVyVF1JJsI1KNdgRzPmmE7oNW2DXyyXhhjn
 YsNfACKkHvKmNdn1BUlbkDQqOtqSSD3pTN7hf0g+w3XnaLr0w0DgSxUa7wZCykX/7E6y
 yoPHcrI0ebad+6oaBw/rPfHO7k0X4CsAr1sv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741107455; x=1741712255;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XCa99cZh8u60et2AUCcte+UvJEL8MqQPFIuIBRQgTjI=;
 b=aOtjZkgt6q9+/zO+uF2fOdogvaE9bm+PxksaZ+3mucC4SAOyxYx3D/n5YokCW6SU6N
 Z3vCcGQuT5tmls2ZU3aZMpxB/YdF9rOFrEvH1tFadHYuFxw81lTkdQOh4UbZU6pX+TWb
 Q9fhn1TgDZ0tr/6sWzA+lLYxeSIibxcRWDxRrmw2Qc+6V+3TdiVSX+bgyEoPToQ3WcXA
 kttWJzDTJJYVtj1djLDt4Y1LtB52YHqCDzRgMvpx126C/Drr5ExpXfa+E34b9CDzCdAH
 sBfU7NQA3OmbbDHiWCdYM4bCY7WJEqkHmudxiUxxUA7YHiMApP8wmHb426A53Ns93IYO
 4K2A==
X-Gm-Message-State: AOJu0YyEueerl1E0Y3XTV0KcdZ7uEgEE7w/m4JRB6XYhgaZn1Bz2R3NO
 Ssm8bpoLkr7TNdBWG6K8N+EQaMIACIRGQxw0pXEVSGnLWWnU8+8bu5fjm50aefM=
X-Gm-Gg: ASbGncvEThTMyvay23yXJXZ374V5A2FxkQLI/yQx2eHRHpXhyNBcLc32CKwrCiGtBBo
 Tje9l1jRz5q3KdwYG0eTlY+W4RH74H3cZUvU+iIpOuTwXJ+pL4MWTDlLMaiYTm6PS4HJF38VEX2
 tL/m8RJzfbbuRMhin5PFgrRIEoSGYgPUHXGe4lbHImegKegwn4E0GMnRhc5LDOGtkXeNA727FlO
 J9rtIPZmKsXzQ6pShRjyPmyXT4NsQXZHtOtOXTUSugNy81WGljFoK2zJ1nGB9vqIAoplRfBAWO6
 wvsxh2+4xBJ0EFKQtVsx1oZ38dbumE7tRe6+6Q6fvg==
X-Google-Smtp-Source: AGHT+IFJv3kGhySAkMpW+gMRLMVMuIVrR5MUq9JkQYWHu2t/FAem18KPffic312b9JYfZFjZ+PuR8Q==
X-Received: by 2002:a05:690c:6105:b0:6f9:e4e1:a86 with SMTP id
 00721157ae682-6fd9422882fmr62871547b3.16.1741107455317; 
 Tue, 04 Mar 2025 08:57:35 -0800 (PST)
Received: from [127.0.1.1] ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-6fd3cb9f7casm25268957b3.108.2025.03.04.08.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 08:57:34 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Cc: Alexander Kochetkov <al.kochet@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Brandon Maier <brandon.maier@collins.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Janne Grunau <j@jannau.net>, 
 Jonas Karlman <jonas@kwiboo.se>, Lothar Rubusch <l.rubusch@gmail.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Minkyu Kang <mk7.kang@samsung.com>, Neha Malcom Francis <n-francis@ti.com>, 
 Paul HENRYS <paul.henrys_ext@softathome.com>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>, 
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, 
 This contributor prefers not to receive mails <noreply@example.com>
In-Reply-To: <20250226162621.2681677-1-sjg@chromium.org>
References: <20250226162621.2681677-1-sjg@chromium.org>
Subject: Re: [PATCH v2 0/5] Syncing up on skip-at-start
Message-Id: <174110745316.1812793.16245811237911940202.b4-ty@konsulko.com>
Date: Tue, 04 Mar 2025 10:57:33 -0600
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

On Wed, 26 Feb 2025 09:26:13 -0700, Simon Glass wrote:

> This series has the skip-at-start change and a few fixes.
> 
> Sadly it also includes a revert for the dm_probe_devices() patch, since
> it breaks jerry (RK3288). I will need to investigate way.
> 
> It is based on -next and I can send a PR if desired.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom



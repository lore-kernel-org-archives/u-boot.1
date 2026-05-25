Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE01CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 22:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 349C78490D;
	Tue, 26 May 2026 00:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UvkYYfrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BE184859; Tue, 26 May 2026 00:43:25 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C1E084859
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 00:43:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7e5fd39cf11so3366366a34.0
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 15:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779749002; x=1780353802; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fUx6GDN5d01LJWVCDbFgG3NRvOb5YNIC13oRwxCySU=;
 b=UvkYYfrOse5NsAmLAvwZht6VrnxKsaMlJbdsGPIH/bmDNWAw6oY6EleIFHnaLc8e5U
 qQ3J1JYGxpa5NSvoyFg1IcjcrTyaF8osSAIagFQOs1d/DUOMJkDJI/cGaTCei1vyleDu
 sAxOBgdnqHoOLdzdiHQJIZdEa3XGpF1LfOloA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779749002; x=1780353802;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8fUx6GDN5d01LJWVCDbFgG3NRvOb5YNIC13oRwxCySU=;
 b=ZEcpBu8QZ61GSG+8/NjjsR2EUMoThU2wEjYNvigx6ZvPrkF2X1I73tsPmP3BIr3w9D
 xF94fVw2KijMaQmLyKozaLjpj3MHnprx89WConZkvEkL9PXkwU7sSf7m93Bd16oruJDd
 LysVSJydPdyeQzonsRZSA5PgqTkaTYZwlCsmKC9an4htOAganPHSkf8vgmQVER3DlNG+
 UmBCxrTmlO+Xbw22gKrFcsfWCWNmQ5WOXrM9IrCk5UkA5zmx6GuOC2QmZ+Y96LDFilrD
 K1VJRT/XEbK0cFwrZpFKRLVDXGW5u/TwU9GJxd/C/lj2Tj/ayDc7beuewrQ1OoBELvnp
 1L4w==
X-Gm-Message-State: AOJu0YxY7WjeKEziZHzxvTCHsG2ATKiG/qQtqf4S+Wr7PDRVUaQhCOj0
 B2psJP0vA2rDXiQKDyS4xrVnTTdCiUor67tFgMr1EnBHBtNVVH/++B4ZAuyXSJ8nUz4=
X-Gm-Gg: Acq92OFSM68b7ZDE4LOrw64NG97NQbcz44lEQmVMdGDPwHrUHUzY2bVj7LAToiicLrp
 9HLJSuccKsf+xpySlx1eqCssHmIFXt+CmmdYX6O5KO3JC8sf7PKw+9m9TliWw3aE5JDr8kwiXH3
 ZdfZvdv3tjGmt7rtXQ9cd2BGW8+1YiWS3IAyzSA+Lu29d1R+YMuJAbQiW5TwyRUzUb/Di2IEtV0
 zQ9EgvfIxgVIzY9zuNQfAcLNDJY4L7DYjk6i/EhSBQ2gtFx5FkOcXkNN0Yfu5CqdgK75ZzLtmVx
 bNLrQW1vbDpd359Q107xmmYohA/7b8xnoKKuI86uoE/xgsUhQpsZPn5Gh0uNbqBNClN7GaajwGs
 u+zVKjWfW4QNjEwv7UPH8r96bANL6ZsxrMRUtGHEvgOU6HWf1SJf7ppYNmJiWEgd+alRN7ec2Xb
 pPEByYxNIhfuGlPqBXwAT+w73GIXffDc2JPwNFg433Cz/SqgX+sifKo5TpZxoepq7RezD4lDmGA
 zu2V4bgAFWjgvGuH46SiPxOSbdFNsY1tNHwnIpMQUHK
X-Received: by 2002:a05:6830:6d2c:b0:7dc:67:8c9b with SMTP id
 46e09a7af769-7e5fec1c053mr10554380a34.4.1779749002266; 
 Mon, 25 May 2026 15:43:22 -0700 (PDT)
Received: from [127.0.1.1] (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e606667796sm8076073a34.23.2026.05.25.15.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:43:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Bin Meng <bmeng.cn@gmail.com>
In-Reply-To: <20260508162259.2302319-1-sjg@chromium.org>
References: <20260508162259.2302319-1-sjg@chromium.org>
Subject: Re: [PATCH v2 0/1] cros_ec: Sync with upstream Chrome OS EC
Message-Id: <177974900152.3696278.7336978624133769624.b4-ty@konsulko.com>
Date: Mon, 25 May 2026 16:43:21 -0600
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

On Fri, 08 May 2026 10:22:31 -0600, Simon Glass wrote:

> U-Boot's include/ec_commands.h is significantly behind the upstream
> https://chromium.googlesource.com/a/chromiumos/platform/ec ChromeOS EC
> tree.
> 
> This series updates it and provides some fixes to resolve the resulting
> compilation errors and warnings.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] cros_ec: Sync ec_commands.h from upstream Chrome OS EC
      commit: a219f64c2794135b44ab9aa9b808c5c25d18262c
-- 
Tom



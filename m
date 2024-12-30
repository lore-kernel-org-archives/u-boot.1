Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763EAE77188
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 21:52:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9E48069D;
	Mon, 30 Dec 2024 22:52:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nUPNAIvc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04F5780634; Mon, 30 Dec 2024 22:52:44 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C931880383
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 22:52:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-46677ef6920so82522121cf.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 13:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735595561; x=1736200361; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zMYEdMvnw7+ZbQIFpzyUp8V5TJa92Hu4Z5smc2LZrGE=;
 b=nUPNAIvc5j/KQIL9VuoEKtndrEibuIXV7guKj4Gm9H4BZ8cnTD31L3nbj12D5K6l2a
 h7G1ek7BL897CVoTEuLmCKoO4gJzDtT11TB3WLOyEGF91M/tSH9coX6GUvtsdfkIlf8K
 N4VdOkg2LAhpttBxzY7XJCEaeq79rUl1S/0I0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735595561; x=1736200361;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zMYEdMvnw7+ZbQIFpzyUp8V5TJa92Hu4Z5smc2LZrGE=;
 b=n/AQ0rKbECltXtmGrpWl99IgBdN5y+DzqNsmNX7RvOs99wPCmtP1e16c4ZoI9sgh67
 1+aq9vv7vJJPYxcA/NvsVRlDEw+XSdMtu59QYbncAwFSjd1ZQ+qwY3K4SzltVj+qRk9v
 pEOdwIfOqFgJdL7tlyszXm1s/MLLpjs7i3JRAiinnncWH3fIt0vu4I0FMVuA2Yw3T1Ae
 jb/MsNxmuFb3jX73vjqjP/xkxthB2W/R78WqZxFGLrozqYFyvrz7P6NFB3wm85Bhj3YT
 yzpsizUKmsQr1oloLQTXsFsP/W3d7fK7RaxWlbGc+U0oL2Os+9FiX+xu3zCeuEOaLObu
 z/IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSlsgR4cn4uzxv4BXEcORW+JaAmg+18YsK1x+dRlSHdbtt/is3VjeFwCpX+f6QKl98g13yssg=@lists.denx.de
X-Gm-Message-State: AOJu0YydpAK4hX+LkUIdtaGKsKhKanE2jaBe2/zDGfLhzRmJ3zyX6xvX
 +R0CwqWCqJboJyRgwhtf9P1J3xuFSQgVHbjnCAP17tm4iaXSaJbdU67ssvgn0Tg=
X-Gm-Gg: ASbGncvo5GqxNm7o6oSi8F829XAQEyKZMxrDsEoCYkPOUtH2AbvjK/Nnw+bsDdO7VVm
 jrSg4ut5B5aJAF+WF2nZeBRdqvIfPRQQV9wUhrQtnA3E/0/gIezkKs9Zrlq92E8/J1I+twUKcGN
 cIfvOyEit84TcvOK6/jwB+jZ8jpS0CDlv0rMssQWriMUVyYglKsObKbnkDVLXkDxjttLKESae/3
 XQAb0+Copkz1VZnNMRZPwtIyXJDH81EopFxzexKprh6AxgGwCP3Bc0r
X-Google-Smtp-Source: AGHT+IHN4qv2dRTBvi20SEvRXusRoyBh8RQxRvWYYAYjfFUSCyMvO1uwizjQJ+IYV/MW8fDM2DarEA==
X-Received: by 2002:a05:622a:1a82:b0:466:91f3:12ca with SMTP id
 d75a77b69052e-46a3af9ea8bmr552851321cf.8.1735595560734; 
 Mon, 30 Dec 2024 13:52:40 -0800 (PST)
Received: from [127.0.1.1] ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb17e6asm109079101cf.69.2024.12.30.13.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 13:52:39 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: xypron.glpk@gmx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Roman Stratiienko <r.stratiienko@gmail.com>, 
 Michael Walle <mwalle@kernel.org>, Peter Korsgaard <peter@korsgaard.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Baruch Siach <baruch@tkos.co.il>, Nam Cao <namcao@linutronix.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Prasad Kummari <prasad.kummari@amd.com>, Janne Grunau <j@jannau.net>, 
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
In-Reply-To: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
References: <20241218070251.686383-1-ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 0/8] Cleanup the LMB subsystem
Message-Id: <173559555789.231403.16128624599163378474.b4-ty@konsulko.com>
Date: Mon, 30 Dec 2024 15:52:37 -0600
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

On Wed, 18 Dec 2024 09:02:29 +0200, Ilias Apalodimas wrote:

> This is v2 of the rfc [0]
> 
> The LMB subsystem was used opportunistically for a number of years.
> A while back Sughosh merged it with the EFI subsystem in order to have a
> common allocator and avoid subsystems overwriting memory they shouldn't.
> 
> This is an initial cleanup of all the crud we gathered over the years.
> There's no functional change expected from the patches as they just cleanup
> some abstraction functions and rename a few variables to make more
> sense.
> 
> [...]

Applied to u-boot/next, thanks!

-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288FDC3DA45
	for <u-boot@archiver.kernel.org>; Sat, 13 Jul 2024 16:42:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D90A8853E;
	Sat, 13 Jul 2024 18:42:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UWPH4EHw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2E7D88765; Sat, 13 Jul 2024 18:42:41 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD2E487D6B
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 18:42:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-70361c6fd50so1501017a34.0
 for <u-boot@lists.denx.de>; Sat, 13 Jul 2024 09:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720888958; x=1721493758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObTtuSkbgAo/eZb7/3IQWXPhubuzDhMntgjRaIEXDIc=;
 b=UWPH4EHw1LhfCFIqnGqkpzpLDxyklWjO2o3wzeOy4yWPYQXQXqh5TzWUKEm91UYzst
 k4RSFu5Zh8NUQG5zn5R8V6LiAAaYJ8oeZhoScOwJort5voTAGPmQ8cpVIdtzZLL264rT
 1Y5Y39DKuBHJESsrlSrtJ/AHmsUvfYlyxs2IE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720888958; x=1721493758;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObTtuSkbgAo/eZb7/3IQWXPhubuzDhMntgjRaIEXDIc=;
 b=FM7LEcB/STH3ZUuitKPQlpLtgJBW80Hq7UX1g5WbuQW8E3/VZgpOxYUGRX/MWlueIG
 fyCe1rCgI7iSII2UxHvfGpjrOoxQPUX9oXfmJU/ucHc2B/BT1klql7S+XarWdd5CsPAG
 OH6TvkXsktdirRBH6kC/+s/EuOTO+EQME37WN3SGBttDZID4QUjBrz0X6FGWrLZxjz6q
 GdN9Vx8lX5DdCZcwpBLwsKUcDI8oTRx91zB8szlYWlwazQesyDeowMZmGGgS7z1PD53E
 ILOW4/sbFpPoNAjmkr/FXTJjao/5g/ZmQ8Guo4b2bTOrsdgas0ylX49WbACZbRkAJKqN
 cB3g==
X-Gm-Message-State: AOJu0YyAA0lz8/8WzyUJNo8NeVI+zHwE0wBQ7ZqWrjNXxtdEHvUc6Hnv
 4/7jZq27PK1h0wDnnItXlIo1vFEa3N0917V75CVHMpMJxBq4uHMv3gAiFLtxQFg=
X-Google-Smtp-Source: AGHT+IGgTKK0X5qOPip0iK7Mpr9yCWw3C7W8T88FmphHwrLqg33+mAxihXyQ24xXVtpwv8pYzOR4NA==
X-Received: by 2002:a05:6870:40c3:b0:254:826f:a9d6 with SMTP id
 586e51a60fabf-25eae7bb6d4mr12225298fac.15.1720888958384; 
 Sat, 13 Jul 2024 09:42:38 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-708c0d020fasm311574a34.59.2024.07.13.09.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 09:42:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: =?utf-8?q?Marek_Moj=C3=ADk?= <marek.mojik@nic.cz>, 
 =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>
In-Reply-To: <20240713143838.3049800-1-trini@konsulko.com>
References: <20240713143838.3049800-1-trini@konsulko.com>
Subject: Re: [PATCH] turris_1x: Normalize Kconfig usage
Message-Id: <172088895758.3057766.6212701682558831932.b4-ty@konsulko.com>
Date: Sat, 13 Jul 2024 10:42:37 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Sat, 13 Jul 2024 08:38:38 -0600, Tom Rini wrote:

> We don't set many options in the board Kconfig entry file but instead
> use defconfigs, select in some cases on the target itself, or update the
> "default" options of the main entries when needed. In this case we can
> remove most of the board Kconfig entries and just add them to the
> defconfig like other platforms.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom



Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280FFD41D69
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7C6483A9A;
	Thu, 11 Dec 2025 17:54:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ANa3JZLe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57ECC83A28; Thu, 11 Dec 2025 17:54:02 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C79338367F
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c6d3676455so159480a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765472033; x=1766076833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jx7/mzDcTz2Qr3T8F5dr4ih1T08fQbQkuBKBH7Kjb4o=;
 b=ANa3JZLe7ZLXsLSiD5oCvRKeZa2nJi+61+pRuAeE39yfQY9pIpszLbkOsMC3MKOaJC
 oVTRgo5TTcmioQwPJyuRRDlZ6fEJ3XyK5lyfOYvCOxT5oMDntBxCRhjq0u5vSgXOgavH
 Ufa4a1TokhEe3UOEfhm9tYpUH+WGDRQGgO3vA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765472033; x=1766076833;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jx7/mzDcTz2Qr3T8F5dr4ih1T08fQbQkuBKBH7Kjb4o=;
 b=QP1YHJNPQkdWzJZXWIvM9wpLDYQZABmH5jM46ZNMgId8C2KHSXaf70Yg02m+dj2j1X
 +ZjIidJSsmk9mWE57Ro6hIXj0wMy5yHZ595+FtfAvtxYeUlGYCQLwhjpFuv52hknRTQ4
 0YplehNVAR4TBtMGPVrpGWwBU/ghgbsFC4R721KAIav2Uhl+F88kvA5szI8Abk3zQPkY
 wv6cMqBB5QZ5Gwb8bK9uhSTCkwmQ/RJNoD7jiGp465iBM6601mnbP8rMvQJ9ZI0KDu3i
 QO44/npizDO8rcsxzDU4BjN/kR3UcdKTii1a64m7VB8LDs4hWxWpmGRZZ55NihPks5A1
 8JDg==
X-Gm-Message-State: AOJu0YxlYhmTRLvEBFktEfQjEjycudoMqeo5F0tFn2jsD3MCShYsICaV
 j5J7a8YC28OOty2IAXk1la+oQxBWm/2ABKUKmdNqSq9w5iqGuTgB0KlRwOBOEAx9vdg=
X-Gm-Gg: AY/fxX7F7mY4ko5vJeHQnS1FGqmtwE7htVjFbWLQ0xkF3nDvN+ryholwZM6VyGjxn/Z
 Pns4xWh1ZAixVuOPoFnCWwthpmMR8Z6vstRX7fmiplyczApvJjGJSfjinWohyOGNxKPm013SEcC
 90lHMzlZ0lTplBNtptcGvuHmw1QPhzHzKCTdHKws299WnNcsLmHmJqpTqixGN+93mx/qtM8Y7Kw
 WgQ2gmqKWQeCgfoMWvcIX9e1FohBftDG6ZQcUpNIogAHg/pOaGvZhMgoo2+A9s06lD1eJaZ96vb
 +KnCi1IPAdez0/U+ucUwCSBV1CH+qomgpk8wrF3YTuGfiK9smLZtZBw+kbhhJSTOX5o+l20Acmp
 7btxMXNcEb+Nr+oOgLEvGPmido3zZGl/c0i81UST8LDvusIfaF/Vzrdo0Hzhqh39ZdlPxwLojqJ
 kWtmmE2gIEc9NFw2ohgPi4/g7ZaXs+umkcdloFreDZQT8fgM+w
X-Google-Smtp-Source: AGHT+IG0PQOhlOjuyTYqk2u6RUT861MsZnsyMLh/g6L/EWO6Wl7tPIAQgLlfv0ISP2ILAHjW5rmzQQ==
X-Received: by 2002:a05:6830:4411:b0:7c7:827f:872e with SMTP id
 46e09a7af769-7cacec39ae9mr4930597a34.38.1765472033456; 
 Thu, 11 Dec 2025 08:53:53 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cadb34577dsm1739686a34.30.2025.12.11.08.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:53:52 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <aTrAm8B3VY97yrYp@nxa18884-linux.ap.freescale.net>
References: <aTrAm8B3VY97yrYp@nxa18884-linux.ap.freescale.net>
Subject: Re: [GIT PULL] Please pull mmc-next-2025-12-11 for next
Message-Id: <176547203252.772226.12928205511755003428.b4-ty@konsulko.com>
Date: Thu, 11 Dec 2025 10:53:52 -0600
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

On Thu, 11 Dec 2025 21:01:15 +0800, Peng Fan wrote:

> Please pull mmc-next-2025-12-11 for next
> 
> -------------------------------------------------------------
> mmc: assign f_max to 0 when max-frequency property not exist
> Improvements and minor fixes for Cadence SDHCI driver
> ------------------------------------------------------------
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-mmc/-/pipelines/28729
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom



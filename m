Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21039CD8C89
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 18:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B7B483314;
	Sun,  7 Jun 2026 20:19:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D31TP6Pb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC97838BB; Sun,  7 Jun 2026 20:19:21 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52EDE801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 20:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-691b0090cc5so826500a12.1
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 11:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780856359; cv=none;
 d=google.com; s=arc-20240605;
 b=lMnBsY7UXhE/2NisWNag28LkS4Qv2YxWiUOcgyDh4DyjpABVAwxWoCo5N/2hxrcwyk
 jhkslcm6vYBGkqsdLbXx1zwz6+WJtFrX7IUJSM8Njqx3UYWOYvKhaUKvZf7afmnX4p0r
 gw6dQkx3ORBGokA2vWwBudmdsWUyVUvMIn4OVR4SxAcY4hSnucKlOKsVp6yBfqHL1ZGn
 kc/Uv4SBrDX/zi8/WMU6vV6l/71HER0jhJLkqJhvTe+kpoDe6FY+DOquYs4k9fxnxvRh
 0WcZ6n4FtH/r1yrUTVjt7KMWV2M81tiLggf1rWMc0iEAhTOAPxEONO8HKtpujDbr74uC
 JA3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Bq+7ziBb8AeJZZOQliduDvQltUa8Bz5czx9K04dfAGA=;
 fh=Tj9wSmd5bENjwEds0oNzc8b7XT1tMaDViFZAV0norAw=;
 b=e2G6eh91uAkGEgSYsFsBY5d151dokRETM5FaikW/NVoDQ7QB6hYuN7Yx/hFeisGB9G
 nIozZJPug5oBhw9X0dthrVHCPFyOMBlq+VyBu5aU06h3vrw0+al2AWRl925UjV5oUUUr
 aoE8qeAmq3cbH2EBX1cEfpZRZjMlgJoGtoS51J3H+RWAIcHsM/2jJgLtrCokcnJRmcQo
 wvA5yfW33ROpANkxshCzoNwN8S65a0O+lqNucrTSKc9RLCbGym8WG8CKtA3yLNRXgSuN
 wA0KnnDtps6VZoQiOff9PJuo6BtW/mI5rMSQuEH/S+c5qhQ0Ues/l8oWGbMcEAfBvb8V
 BGiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1780856359; x=1781461159; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bq+7ziBb8AeJZZOQliduDvQltUa8Bz5czx9K04dfAGA=;
 b=D31TP6Pb68TAwnTyh57FfT//6RQg9RP0c3pybHHoOWTl1Bfa2z7SlO/Crn39jO2+1K
 d73AFUEa3oZ6vJgRF/25QwHGeePlja7doOBNyjQ1AfjTrqwfZ2WyKWhe6L5pAUpCWv6P
 beDj9LyvFJ/zEHjNfexNZ3XM3AQhC3hIKuLmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780856359; x=1781461159;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bq+7ziBb8AeJZZOQliduDvQltUa8Bz5czx9K04dfAGA=;
 b=UdWU/RnbLl+TSAQoDVPVju7gX0HF+PXpp73R29Hyuqp6v9rXgrOsl8rs0zHT95yzeB
 KXLmL5wB0JoI/GD5Qf8jwjkfFKa1sXFNj30thRf0hSKtlpunqWZw/29kCl9k9pkm0dRR
 9dJo11vQxAgfnFsIKFED/PeHA5B6hmJRm6VtWtEcjjAKrtE/sj3YtEBFxAGNRs6DL0UZ
 XCSnNsID4f2AHQYfA6XcL2r9AMqn6jMyfRAsfqmL+/Hoj2cuUqmx69xCrpbGbO4bqhCW
 6H+PF5wV+qqSWw5XvFzOFlednFcr1zAf9pEz8BcSURHZ4Pp5TYfd7uTp3HGFvH3ik+is
 LCaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+sOzrJsmHCDmZDnl++2hngEZny/E07IORM8RZnjgmJaqlpr2YSjIRwHIjZ1hwgR56Fme6AgAs=@lists.denx.de
X-Gm-Message-State: AOJu0YwsaHEhP9WpPxpUypaKUAjLXn8RUIOmKbRTk4BZI80VDq3qc5V4
 W6QbAEgnmNddOJRkXVhMDwacN9XReVh9YUkUxE2LvdaWXvMnZhGmIuA8iYxLjiaB1HNMsBRr57P
 65wL6yjfPUDuWzF4vP8Va3aB8E6F6QjqBTgGyOS27
X-Gm-Gg: Acq92OGNxn4GmuHTALnb8dBh+Zxowa/DM6tV4bQ+V9NiuuC2grRLlIowYEeXD0lbj3P
 wU6wJHb7efr0WHVe+6f+/u018G7DnVeKkrz847QFuqJIQJuWbqRYRT6qIwaQt9yVVm3BFOY8j/K
 8kwAYDw+NtsQDBQlwc0TYN8tM2um9Bm1dOxz6U7nFLdf6im5SUiu9nsPRuH2Mzan2IXUbd2JVp3
 ywydiDMVwwFh75g6/+R3N6Gg4PU7TwLugfaK7tuPh8DE1cw4dsUm0WH7OiESizuuv2skpyJf5lK
 fPieh6swCGBrNhfM
X-Received: by 2002:a05:6402:3605:b0:691:ad29:ea27 with SMTP id
 4fb4d7f45d1cf-691ad29ecdemr1403591a12.14.1780856358809; Sun, 07 Jun 2026
 11:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-2-ilias.apalodimas@linaro.org>
In-Reply-To: <20260604073719.48723-2-ilias.apalodimas@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 7 Jun 2026 12:19:05 -0600
X-Gm-Features: AVVi8CfREIjPRSFMqh0DYPTU_uQJKIF7VWvwH-rtVpMSd2RrJaheZWtUF4zK8Uw
Message-ID: <CAFLszTghPBDc_pgWPuXXPaP7NSiqek+MVK-8nAk9ewp+cLfV7g@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] treewide: move bi_dram[] from bd to gd
To: ilias.apalodimas@linaro.org
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, sjg@chromium.org, Michal Simek <michal.simek@amd.com>, 
 u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
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

On 2026-06-04T07:37:05, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> treewide: move bi_dram[] from bd to gd
>
> Currently, the bi_dram[] information is stored in the board info
> structure (bd). Because bd is only valid after reserve_board(),
> dram_init_banksize() must be called late in the initialization process.
> This limitation is problematic, as it forces us to rely on a variety of
> bespoke functions to determine board RAM, bank memory sizes, and other
> early setup requirements.
>
> By moving bi_dram[] into the global data (gd), we can run it earlier.
> This is particularly convenient since boards define their own
> dram_init_banksize() routines, which do not always rely on parsing
> Device Tree (DT) memory nodes.
>
> Additionally, U-Boot defaults to relocating to the top of the first memory
> bank. While boards currently use custom functions to override this
> behavior, having the DRAM bank information available earlier in gd makes
> relocating to a different bank trivial and standardizes the process.
>
> Reviewed-by: Anshul Dalal <anshuld@ti.com>
> [...]

Reviewed-by: Simon Glass <sjg@chromium.org>

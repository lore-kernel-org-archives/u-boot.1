Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E37FC87FCF
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 01:30:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6119883DF3;
	Tue,  5 Aug 2025 03:29:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rwHOjmlt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84DDE83D77; Tue,  5 Aug 2025 03:29:35 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E31E83A48
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 03:29:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3e3d2ad9180so19129235ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Aug 2025 18:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754357372; x=1754962172; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YPEEh7Hk5dsTx44bLWL0QWcjmne15Bl6G3VtuqCgL3Y=;
 b=rwHOjmlt2BXidmjz0raAfo/RjKWqdhhkFbgk85Fnb0V1/BRsomTGgTyQff9ehlAT0N
 EwW0dL1rPSOpsrEeJ9CUsIZ8de4S8JpxzqtLeLG9Y1oMUQlLGfmd+kIWxmO+lzFOxpiF
 Q2qdnUNGDqC/gmqHmPfy1803tj34w9opZD4f8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754357372; x=1754962172;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YPEEh7Hk5dsTx44bLWL0QWcjmne15Bl6G3VtuqCgL3Y=;
 b=ZyoVz7FWOpkXwwFZk/om5YtlZ5CizsfHrwc1e4ciZLFZYdL0KsIaGEITmB97JH+GGF
 r6rNfv5qQ0EG5PmV/XaVWGjS89akIf7mh8fUgrxBzCFtPZVcoyyfRncE5DkSp45SKlAQ
 Lz3ne04b2I1EBnRQ/pdGuKB/3QGgp2IOjEC8UkddrdVeRj6MLLDZWSudooeCelx0FHc+
 zhjklieBdOp0u0G+jkBywgxBclXlHLDpubZbgrygamw8a3M/a88xBywer9ok2gtFqx8K
 zlvRo+TjWNXYWTpsQk+Y64u7AeaGr9BxrBGQmABAiZCJYbs0Tz+KV+9Bu0H3eRasHbFI
 LTvg==
X-Gm-Message-State: AOJu0Yzzsn7KRG0S+H2D6iJ8yQRDYwXxD4d9f7vnEzlsOF+aOuckQdo5
 G5jEhOHGXfV/XPs7I57IMqlZNpM8/plSnPhm2Mhf23BP3Ihe6ZY8codDlGX/w9vCGYI=
X-Gm-Gg: ASbGncsKDaKRRDGvTWYn1l2Vi11fk/bHce//zQ2i6T1niZQ+KI+n+vnM4DpCqeoFD7R
 mpbm7/k+OaYeZ2y/LolehOwB2SAGqJ3LjnByPnU8D1E2CzplQkzv2XGYURK5+Hv/s88TE89+GPf
 TICXgvV3bKfgvkEL8e9kkgYpbS+NBRGnFnh66e3W7oE4zbTmQK8tgV8z07GONXpkUn0sajRCio2
 wHyRu/P/fK2ChZaKVKhlKB+Scj64MXcOgy/WDZ9j2eNuNfz5u3uykBirVAQcNjyUHO2zwRfknHe
 YbezcmXpz+4iv/uveuVyZ9+M1K04a0YTYlCe+n/dZBqnCYAULZTU6+cdzNKWmnM3GFOz9Wf3g6a
 eO4vi8bqh3+Y8V4GEnQMf05Y8b3YcvzCKOzU/4FE4QjdCH5T5LbG7f/4=
X-Google-Smtp-Source: AGHT+IGfGaHDJaESmVpvMBeqQiiGAiRcwYujUoNw3HXqwD4aUAktYus+1xosKk0wGMzLFfP4iHKlng==
X-Received: by 2002:a05:6e02:b22:b0:3e4:ac3:ffd6 with SMTP id
 e9e14a558f8ab-3e41637ebf0mr202340645ab.20.1754357372101; 
 Mon, 04 Aug 2025 18:29:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-50aae78b8cbsm539506173.21.2025.08.04.18.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 18:29:31 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Philip Molloy <philip@philipmolloy.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, 
 Philip Molloy <philip.molloy@analog.com>, Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Peter Robinson <pbrobinson@gmail.com>
In-Reply-To: <20250728150333.1716886-2-philip@philipmolloy.com>
References: <20250728150333.1716886-1-philip@philipmolloy.com>
 <20250728150333.1716886-2-philip@philipmolloy.com>
Subject: Re: [PATCH 1/1] Makefile: Remove expansion of undefined variable
Message-Id: <175435737051.1435425.9290957077967514498.b4-ty@konsulko.com>
Date: Mon, 04 Aug 2025 19:29:30 -0600
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

On Mon, 28 Jul 2025 13:04:03 +0000, Philip Molloy wrote:

> The U-Boot environment was previously stored in the boot loader stream
> using ldr, but it has been replaced by the default environment built
> into the U-Boot executable or an environment on external storage
> 
> Fixes: ea3310e8aafa ("Blackfin: Remove")
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] Makefile: Remove expansion of undefined variable
      commit: 007610da2cca405ea7739fc120d90085be4b6ac2
-- 
Tom



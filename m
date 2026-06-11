Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BFDCD98CE
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 13:48:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD32483FF5;
	Thu, 11 Jun 2026 15:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZxVaN24i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89C588466E; Thu, 11 Jun 2026 15:48:31 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D63883FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 15:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7e6e2d54d3dso4310335a34.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781185708; x=1781790508; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QMjTYoV0EdwkfGLiNo9vksWo95l8Dbb0NRVCAoJJXwc=;
 b=ZxVaN24igeeVGpkEPJdIqqkYuke6deZjylOrsN/O/rVhqC3GidUYNhGDh+t9kpcEKg
 IBJAgDdVtcPPzmiw2EVHxuDXEyKBNec5P0ZrsjDKNZ/+v9x1+xWmEdnuEPS9C2p9LjLA
 ddb3E4Q80xtpmik+U2FuAhJPyU29g5R7yk2e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781185708; x=1781790508;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QMjTYoV0EdwkfGLiNo9vksWo95l8Dbb0NRVCAoJJXwc=;
 b=djAyzQkDklvtPEHFjUAbN3fWHm43hjW38ZGGFtqWsj2Uhx72Gfvy30Ba9rHJis+K0/
 BRlBxBwQj+ijGSEvURNSd5FT2kyBrZOqpn3Mm1fSiQO0eJ5PpRqUYKqOuafPXw1Huhmz
 t2cbvYTsAuWJ59S/lUjcf1doV8Eky6pVyhowPu7yWWdTF0hbgthTUDdw7bFHWMalT/UM
 iOGLDXAMFZyODhvp6ONL40GLGarVAEFDuNhZxHQs6iD1FaFkJVuh6ApNOZkVQr7Cifqt
 8Tlp4NlO48JggF9dIk2fiVXbDph/8zbqcLTayOD3TbgIIF9aDPPAazx9l1cjpNsDDk8/
 mg2g==
X-Gm-Message-State: AOJu0YzWj7LH0pe31NlS18/OzpmYnjIW7WY0ykajs05ADj5f4st5+HU9
 KPLbYWJ5mnh/0MUWHHZy4NSH6u9GU+hb+ZH5EvQzxRKjtjZDN03NrbOMrbGNIc/o2cw=
X-Gm-Gg: Acq92OHyu5xd0rtevYi/u0nCx7qN7Q25cWr9HtL6pNDC0JHR3iUh7NB8SNusl3bMrwm
 gt8uFVmSDAcdacMyAErCKYg8V1M1Re072aHlm1cbUzG5bWNNxaeWZabbTd0nJ0m9J6cDN3nJya0
 MIWCxnqypFaNAaUudjJ8euw/FYC5AtmN8NqNktx6OqBKJf8FKTtgSmlRE6YEoIUhZfyUbqcf9+o
 6UeAy7L9zQXe6JoWZf1TravvmnWyktlYnR/mOCOhVE+dFQQ/uzq1B5VLukpoKQzsw9jtKTc1yNA
 a5QVOP4x1WRFTliVb5zbEPjB3jXqj2lHh6HotaoRqL9BVYnWwsl9zaIg0DFYiGo1ecYV7szeNU7
 mjjd9rzdrX6FyUYrWmd9lGgWQF8KRCjaq75dhZc6mYbr5BkIgUxRIuoq0jSuUve7Y7LFciTyOvO
 nYbbLVcZ9WuiSibrXnq2QshcMr9RSohKrkwE6y5ziBWCFha7p3ePw21/w7q/yd+OlrMJHaA7rQf
 sWeraznagFt2vj2JRes02bOQGeoOus1/z6ppfYfrU6JCUxwGjxxGjWWGg==
X-Received: by 2002:a05:6830:916:b0:7e6:8593:3fe7 with SMTP id
 46e09a7af769-7e7735458a3mr2367707a34.17.1781185708174; 
 Thu, 11 Jun 2026 06:48:28 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e774988094sm1368249a34.1.2026.06.11.06.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 06:48:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Torsten Duwe <duwe@lst.de>
Cc: Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>, 
 Lukasz Majewski <lukma@denx.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, Simon Glass <sjg@chromium.org>, 
 Peter Korsgaard <peter@korsgaard.com>, Heiko Stuebner <heiko@sntech.de>
In-Reply-To: <20260528132206.2fe9f474@lst.de>
References: <20260528132206.2fe9f474@lst.de>
Subject: Re: [PATCH] clk: enhance clk-gpio to also handle gated-fixed-clock
Message-Id: <178118570728.472730.15075222884813417231.b4-ty@konsulko.com>
Date: Thu, 11 Jun 2026 07:48:27 -0600
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

On Thu, 28 May 2026 13:22:06 +0200, Torsten Duwe wrote:

> Devicetree commit a198185b9b5 introduced a new type of clock,
> "gated-fixed-clock", for which Das U-Boot does not have
> a driver yet. The required code is similar to gpio-gate-clock,
> and can be added using little extra text space.
> 
> Use this code e.g. to boot a Rock5 ITX from NVMe
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] clk: enhance clk-gpio to also handle gated-fixed-clock
      commit: 4e249b94af928aca29972fc22ef2b5ed0016eab9
-- 
Tom



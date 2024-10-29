Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06860D3A670
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:37:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45BC58918A;
	Tue, 29 Oct 2024 17:37:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J+Gqcy9o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1B68917E; Tue, 29 Oct 2024 17:37:15 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DBCA8857C
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:37:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-5ebc22e6362so2756000eaf.2
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730219832; x=1730824632; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haM+NSHaOwDwtIsmOux/Sj0SAd9oFona94d/m2Yg9Lw=;
 b=J+Gqcy9oBrrIiL/q5I5P1+UMrGJjFfswopHjLIQd4OtUcVBAvt1S4zbhAvjn02i4yi
 KCK/Ruc8+XYOZjm3Pc47S67BkQN5RoC3RqZ7RdAzWjxzgE8t6nUy5IJKwl3aBMvc3qRI
 0iXZVxUjVyBWFFreute0pOx0TA6Iv0XaeY1uE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730219832; x=1730824632;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haM+NSHaOwDwtIsmOux/Sj0SAd9oFona94d/m2Yg9Lw=;
 b=xCXZXPjXNgKVI5XQ9TZDYe8B4MP/8R5HC7wUMOSNe81wEu8DEaOozG/vYnTYi1IpmY
 ITu8RaD5ul2MQBbFA2MxhtKUwsbn1Fiujy0deAs9oLTgyONvdG5HmujGPOwq7EQPpOmc
 xgjEjuWqsJElcI2cm84YpvWd6o+c/qNxWX/u+R/LShEooU99ipzJNHvQeo4FRSy5DZ2X
 UYBO7KOi+hn1zRd9yetMEtAMUgKms5Nwr971/64xJ9XwmTym+puGuQ5bUSD5U/MXqqmH
 +XB+9xiCCQiFAgsK2S6QXIioMQoNtsIrK3zq3kgi/zFBN9MHCYOA7qjd9f4ovAlo//oB
 cL8g==
X-Gm-Message-State: AOJu0Yxd4Ay7fv9rij8kkuJO9gt/QhgN8QczM20e0WztnbEXGIDHDziF
 H8WP3ZvQd4pPfhmXrgZCfjgQmC1KN5tPi1s9ypJ5l/50Xd4843bZIup//Sh39AQ=
X-Google-Smtp-Source: AGHT+IEBFiL7kZky7aBMREo2bwWZ5QqVTf+y3iDjMjCGzZg44yNz1Nv7+VC9RZ4LbKerWRWCcHL39w==
X-Received: by 2002:a05:6358:7e41:b0:1ba:5118:ebee with SMTP id
 e5c5f4694b2df-1c3f9e431ebmr472376955d.8.1730219831877; 
 Tue, 29 Oct 2024 09:37:11 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798f1283sm43564906d6.57.2024.10.29.09.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:37:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: Bryan Brattlof <bb@ti.com>, Nishanth Menon <nm@ti.com>, 
 Baocheng Su <baocheng.su@siemens.com>, Li Hua Qian <huaqian.li@siemens.com>
In-Reply-To: <cover.1729577070.git.jan.kiszka@siemens.com>
References: <cover.1729577070.git.jan.kiszka@siemens.com>
Subject: Re: (subset) [PATCH v2 00/13] boards: siemens: iot2050: SM
 variant, sysinfo support, fixes & cleanups
Message-Id: <173021983074.2533263.869621308043684106.b4-ty@konsulko.com>
Date: Tue, 29 Oct 2024 10:37:10 -0600
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

On Tue, 22 Oct 2024 08:04:17 +0200, Jan Kiszka wrote:

> Changes in v2:
>  - rebased over master, adding the missing 6.12 cherry-picks from
>    devicetree-rebasing
> 
> This adds support for the new IOT2050 SM variant, introduces a sysinfo
> driver which also permits SMBIOS support and switches the board to
> OF_UPSTREAM. There are some further fixes for the boards included as well.
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom



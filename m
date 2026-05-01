Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D528DCD3427
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 23:51:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FB6842D7;
	Sat,  2 May 2026 01:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J3bKNXEG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35818464E; Sat,  2 May 2026 01:51:19 +0200 (CEST)
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3258466B
 for <u-boot@lists.denx.de>; Sat,  2 May 2026 01:51:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x242.google.com with SMTP id
 5614622812f47-47bfa080d93so1589177b6e.1
 for <u-boot@lists.denx.de>; Fri, 01 May 2026 16:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777679471; x=1778284271; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Qa59hOb5NB+JFBI7UhKCItTFnRxOGwe2LEQfqZP7z8=;
 b=J3bKNXEGRN32gfk1EhAyZAj6HCO52TLvMa6upp3tbvaNWIqEpCgXAOlTafzdcOe0R/
 oaf8ToSdhGjg9JzgN1NOcJ+NYkCl5AwXpuCU11kM0wjS9UkH5TQeAfAukEKLjiRnaFDS
 3sETVxe5V+RFZ2PcZySU4ACWXOQsb+uKJP19Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777679471; x=1778284271;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Qa59hOb5NB+JFBI7UhKCItTFnRxOGwe2LEQfqZP7z8=;
 b=da/bKRmBwVWZFkVsfFX0uO1ottUf/K42yXdM9thzRk1Obxs0UxO6qLns3dVvglaGKw
 h1BG+olvp79lljFdCHcxCSyuTSzvwMy1FePK0xWhYx78jSnIxwjFQu6oqKpJJr1RRBKZ
 QEBlBVB5IC+ggLyM7/BPTcKgf8vlu8AfAxrZFP1O/JwUx5yPs1hBxbIXxJ/lNKMG0kaE
 iHSt6cDRWpU82FxmnlBT7991Jzn9iEo0UV9sLwqTLRSVQ965lmyTu9FeKRAK8Wpf3hzW
 1/f5pV5WiWhNfgFYbRZNE+VP8p/96iJiqyijHFXsS7Lk+3Jef8bXiPcQ2iGo5dNBtABf
 NFLg==
X-Gm-Message-State: AOJu0YyQIFA0js3Q774kbkqkVxgJ5QAhw8VvTlaS3Ms91AR9rsfx/Ol4
 fkjDt3wShl+8bJ+euKPbtarU2ZRvx+nUpaU5VupKHNusXEqS6m4ykF7HxwqQBDFZwmcnT/cAUeU
 Z54K9AibzuUS6OEA=
X-Gm-Gg: AeBDiesY8UX9iBtiofa2pjibmZuNj9JtHtXtIa8IGLpB2kAXYPs9YaenEaRs7rt5NgW
 8wU0UVT+LwlmeCCOXcBF4YzWyD9Ll+i/E3daoBo6jGfCuzcVtDO+jcdEH8qDEEU4MOgbweC23Lc
 jyJZ4ryI0dewRSmJAuZos4RvIjCTW0GpfEOuy8WnhDJw8Jf/0A83QoOeSF+Axwwme0GMxH9pkva
 ssnT/IsV6FfycheISbndDTfGALC9wOPgO7589vQELpknsUGlqqQAgrKrmcVZ6DnQMHIGwyvhfpD
 2FZV2GAR/yWXnbhMRImhoaN1dup28XfOW93RXzV11iMLTTj80+2dGj7z39ObZ87V1kty4vjTbTb
 gs7W8xtUc/CqechRr41J7UvmjjIIliRNYnuu9qJzmkNgqO1W9nG+qdACgvdtjASHcoYNPMOp8Kt
 vrEKnRIVI0QxEJuOpFoWQoSJp29XJrG/ua8fcFm7JUdqZrxN1tD6oONigYMUHqxbEyIApdddKD7
 tJcc7ckkzfHVE8Qgah1p5zkhNstiw8qD3arEsiJ8xjT6kdtyXCs5OMgZyCn
X-Received: by 2002:a05:6808:4f0c:b0:479:646c:f701 with SMTP id
 5614622812f47-47c892e34damr824070b6e.41.1777679471233; 
 Fri, 01 May 2026 16:51:11 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded51a9612sm1967949a34.26.2026.05.01.16.51.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 16:51:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Johannes Krottmayer <krotti83@proton.me>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Shiva Tripathi <s-tripathi1@ti.com>
In-Reply-To: <0ef3c3d7-4255-470e-97e5-951e7351d7b9@gmx.de>
References: <0ef3c3d7-4255-470e-97e5-951e7351d7b9@gmx.de>
Subject: Re: Pull request efi-2026-07-rc2
Message-Id: <177767947038.2064724.11038096082995486582.b4-ty@konsulko.com>
Date: Fri, 01 May 2026 17:51:10 -0600
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

On Fri, 1 May 2026 13:46:01 +0200, Heinrich Schuchardt wrote:

> The following changes since commit b52670d37bc855f6c8da63eb51bf84bce4dad90b:
> 
>    gpio: 74x164: use dev_read_* APIs for live-tree compatibility
> (2026-04-30 13:57:49 -0600)
> 
> are available in the Git repository at:
> 
>    https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2026-07-rc2
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom



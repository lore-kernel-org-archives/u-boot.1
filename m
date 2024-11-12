Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E1BD42B81
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B0AD89383;
	Tue, 12 Nov 2024 14:45:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MuDlpDZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17E828942A; Tue, 12 Nov 2024 14:45:10 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20623891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:45:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a99fa009adcso383398566b.0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731419107; x=1732023907; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HvHxeZfCCrqoWJGKauSnL3eQx/wm4CODfxc9B6o/AZQ=;
 b=MuDlpDZcreo6As9cEKgVge9zZ4oKstHqvwMr6Wo6AHw6rdubp37ifX0Cr3C1/vZkMO
 UzGp0WeTLU2cn2CUUQ1vZ3uZrbmE0MJzXjD2AhN/ZLODiT2pP1jxvFD0FuVGL0EpX4FV
 NkvL7f8Ib2GLqE9UZVQLrXOloDqx0mL8EKkLzPSXcnSBAIpPbAfHwC2Ajjtf0mB2UE65
 WRHKyIx3o1RQ6eqwDaJydDPSpqRRaOPRw/XJfvuhbPVNhDcXJCrM/7bWp11zU6YyWuIG
 WVgnr3PqpzPUgajcxULvX6N37+h4e+zi9n9FstGElgc7olGnTe4LeWp/CQBwe68HAdrQ
 Y6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419107; x=1732023907;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HvHxeZfCCrqoWJGKauSnL3eQx/wm4CODfxc9B6o/AZQ=;
 b=miG68dtsRFtvaxFzGQXFjgZPb3rdJnnYe/Bs+baV53a151VtH2UcDxn0mcgzWPUIj7
 i1FL1F4bSXSHZ/phLTTsDkRh35sJFQ6sotr8nVWkcuncm5z7gzkL+vhHX9lEba2U9hd4
 g4a4Tf5AVmGcq4TdLN5Ago6ZC8by/8rJPEJXqfDNuXon/Yh4Y93OdCrFYIOBSN1n+dg5
 IY1zFpWQkwW0NCTeoFhi69c0aMeO+0BkkUQv5K5FWvvCrkBo0tqsWSytKG17yCQtyX1s
 Ahr4uNp5qa6xMUts0uPkOG/T82VGsrqxjVSkM3bi4g5eCqocZiNtEKx2quYET4+10Bqe
 9J1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8xRUshQUTVqzhQAoqN+fcYFSqja5flUFHq/W2o3GfH3avM8/ys1sLKiwM9jVdGQUhiPsddAU=@lists.denx.de
X-Gm-Message-State: AOJu0YxPZmIf2sLnmKmczg4OLSrHzzHQvP3es6j8xOLJsPmK2t8FjAl+
 WAjqLzwHEqOkmNKzL3sCsSVy9i/H2YPvbJVw7DzFb3Wpc6t27lMtfQW9Vvi/Rb8=
X-Google-Smtp-Source: AGHT+IGNS1edA1VPTy3B3Iwot2yNuDKmGwGY3gc9LysXtaLYaQ2SqyfTf/NgnVvWs0/brc8Spq2afw==
X-Received: by 2002:a05:6402:5192:b0:5cb:699c:30dd with SMTP id
 4fb4d7f45d1cf-5cf0a446b13mr18690109a12.32.1731419107467; 
 Tue, 12 Nov 2024 05:45:07 -0800 (PST)
Received: from [192.168.0.187] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03b5d7f1sm6298750a12.8.2024.11.12.05.45.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2024 05:45:06 -0800 (PST)
Message-ID: <0c9225d8-9cd2-407e-aea8-baf31efcac34@linaro.org>
Date: Tue, 12 Nov 2024 15:45:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] collected fallout of porting an ATSAMA5D2 based board
To: dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 Benedikt Spranger <b.spranger@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, u-boot@lists.denx.de
References: <20241018083006.10349-1-b.spranger@linutronix.de>
 <20241018083006.10349-2-b.spranger@linutronix.de>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241018083006.10349-2-b.spranger@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 10/18/24 11:30, Benedikt Spranger wrote:
> Hi,
> 
> while porting an ATSAMA5D2 based board (booting from NAND flash with UBI)
> I stumbled over generic, NAND- and UBI related asperity:
> 
> 1. tiny-printf does not handle NULL arguments to '%s' in a proper way
> 2. vtbl_check() has an useless debug output due to a typo
> 3. NAND: An informative output fails badly, if the NAND vendor is unknown
> 4. the nand_atmel driver lacks a vital initialisation
> 
> OK, you might say the nand_atmel NAND driver is obsolete, but it was the
> only solution to get booting from NAND running. The new DM based NAND driver
> refused to do anything usefull, so I dropped it after spending a couple of
> days debugging it:
> 
> <RANT>brilliant!</RANT>
> 
> regards
>     Benedikt Spranger
> 
> Benedikt Spranger (5):
>   tiny-printf: Handle NULL pointer argument to %s
>   drivers/mtd/ubispl/ubispl.c: Fix error message
>   mtd: nand: raw: Fix potential NULL pointer dereference
>   mtd: nand: Update NAND manufacturer Ids
>   mtd: nand: raw: atmel_nand: Add missing nand_scan_ident()
> 
>  drivers/mtd/nand/raw/atmel_nand.c |  4 ++++
>  drivers/mtd/nand/raw/nand_base.c  |  8 ++++----
>  drivers/mtd/nand/raw/nand_ids.c   | 22 ++++++++++++----------
>  drivers/mtd/ubispl/ubispl.c       |  2 +-
>  include/linux/mtd/rawnand.h       | 23 +++++++++++++----------
>  lib/tiny-printf.c                 |  2 +-
>  6 files changed, 35 insertions(+), 26 deletions(-)
> 

Coming back to these patches I had a look and except a typo , it looks good.
I can take these through at91 tree or maybe Michael you want to have a
look as they touch the MTD/NAND drivers ?

Thanks,
Eugen

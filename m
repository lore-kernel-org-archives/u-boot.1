Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1003BFF886F
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 22:56:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AE1B803C6;
	Fri,  1 May 2026 00:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dmB9TD2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3282684227; Fri,  1 May 2026 00:56:48 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16975803C6
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 00:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-479d68a9063so554993b6e.0
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 15:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1777589805; x=1778194605; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pUnyyey1eatiK+ojg7AgkvLw9A4FEltVUMdGrZz/eoc=;
 b=dmB9TD2JoIrb1sqb5cicgb3BpuwWM2V2xjdo3sEd7cTsI3g495gG1ovB2Ap9nASSd1
 Gw48lIy1loCb9C3tUE8i5ZG+DVYXlg4fJn+4Xj+n5k1AKXQpYmWj+wBs7JUOgQ551eoM
 pkb8dTU5U5ibBSzF7pfXCje3q4DJKrhDQ3wI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777589805; x=1778194605;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pUnyyey1eatiK+ojg7AgkvLw9A4FEltVUMdGrZz/eoc=;
 b=Tf9P1mE85EXTVHUIjHOiOf5qx/lXQwYHELT59h8DHyWiUaA7fD4rYdOJYEHHkCeNf9
 DyF3/N9sRdFRkVpgGwLDUrkXQcDPXN4HoQPXTmYeLVOhB9NgpzsQamt/ufbtC8n43sA0
 buhurXJoJTLnQZlnqx4oqxRdnDFyL24w3xEa4iTkzfa0O8FYdnE68qs8xT0eqF0xD7q1
 QqRdSQVZSMsVNUZ2rFFluUp8CmSt/zQlInw4TraeBP7+uqQ/ucD+OsKC1AQi1I1IBocA
 F0jY+g6NayZ6c8iMAEdqn4qX+71hfYBE3R4ewWuz2ynP0TjXWQk0lxuyqwAhuAyEfEjV
 MYcQ==
X-Gm-Message-State: AOJu0Yxlhq/ldicHsHzys4nt3pAWIDwp5PWdQSJsuLyJ1C9earJQ1lRJ
 1n/2rrzOAL1aNzpjcozshslgE8fpKCU4pM8d/DfDmd8BNnVi2FJ6mHRhD/Z30g/pzOZOKzWK/0O
 VMUTGYltRt9jh
X-Gm-Gg: AeBDiev6YHMfSnWbTSjATqI0sZQi6A4d3UNFslZdwKr2KddnWKkeSm2/L51XKmoGtjo
 RN+uydQJwMokwAPqufYEbulOgUXgKiAc7ZB1/mLPCT03DDHRrm2LN2EsEwYWBlJUrKIJ3xwu2Kv
 OzOoN2b99PNvhskZU6FgNR0w/yu7/KMpcZqJ5YkttuJCqJS+tFEM/XaQeyUtsKo3mBL2jqjBRij
 +zV0R730HuG0dqewAMWpj28t3R6DOFUb9T4vemq/R8pQcIrTAvi0Ts+9+ilZ3zpkuWdf258mHas
 g90uW+zzJnVhMszLLLnibcumeZhPsc3cZRfV3S9s0ioy58H/0V9wXAaRRUwyBfL3f2LZA00KUEJ
 XEmJD4onBMOUjsI8Sx8PeRHBwWWQcaRdf9f2yZywGbFy5nlmh7lXOqiUoy2Kd3z8t2mUXXjBFxY
 NRTLdgeuikKEVhx6+pcL4lhk6Fw8oiH4nLIfvhS90+h+YvgvIcuPJRJrd8koBK8YW2ZJgqbYVWp
 oobUCReSW9Xv3SU77OKnrlCibBuRY7wn3OB/wfIWC5iVKEbrGtvEhJsULAx
X-Received: by 2002:a05:6870:1589:b0:42f:d09d:1fc9 with SMTP id
 586e51a60fabf-4345c51cfc1mr308225fac.32.1777589804827; 
 Thu, 30 Apr 2026 15:56:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454966f3csm919444fac.8.2026.04.30.15.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 15:56:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Chanhong Jung <happycpu@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>
In-Reply-To: <20260422140538.1730608-1-happycpu@gmail.com>
References: <20260421080847.235789-1-happycpu@gmail.com>
 <20260422140538.1730608-1-happycpu@gmail.com>
Subject: Re: [PATCH v2] gpio: 74x164: use dev_read_* APIs for live-tree
 compatibility
Message-Id: <177758980396.1739800.2796729709260609314.b4-ty@konsulko.com>
Date: Thu, 30 Apr 2026 16:56:43 -0600
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

On Wed, 22 Apr 2026 23:05:38 +0900, Chanhong Jung wrote:

> With CONFIG_OF_LIVE=y, dev_of_offset(dev) does not return a valid
> flat-FDT offset, so fdtdec_get_int(gd->fdt_blob, offset, ...) inside
> gen_74x164_probe() fails to locate the "registers-number" property and
> always falls back to the default value of 1. This results in a 4-chip
> 74HC595 daisy chain being exposed as only 8 GPIOs instead of 32, and
> any consumer referencing offsets >= 8 fails to bind with -ENOENT
> ("GPIO ... not found" / Error -22).
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] gpio: 74x164: use dev_read_* APIs for live-tree compatibility
      commit: b52670d37bc855f6c8da63eb51bf84bce4dad90b
-- 
Tom



Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6080C4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 23:07:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 635D880E33;
	Tue, 21 Jul 2026 23:07:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-SUmIbwpbFf; Tue, 21 Jul 2026 23:07:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6004F80E53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784675263;
	bh=KISXzuASDsl7MXniLf/SzQbjAK9DMjqhdSJUxc4EFrI=;
	h=To:In-Reply-To:References:Subject:Date:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=mJSNCRpcApc/0XMQ+DUF6Xec8HDkW2MXxDYwJt7RAXnPP+06AAMIJl7Rb58iiz/Hm
	 4m6zmznW0GhvPZz3hAX5cjWia5f2R0u2sUCXNID0Ym3Z7yDyOYfivQ8b7RtUOlLcCc
	 R7b/gaDgVt7V+Ujhaqn0LBIRJZ6DQa2Sjblq9OcZ4+u5nUhxabERit8W2L1GNdBSR5
	 r6tpvSNs4qmrQSElsOM5pKQWfMsatje27cMzfUoTMH5eujaFiYgT/X9EBlMJ8aP/Zy
	 VIiIN551D35/nazfr4QMD9X4byhUC+547uf45UMpUpUJposuKeeEKGGiLnIVuMA9/i
	 siBmejhMyZreg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6004F80E53;
	Tue, 21 Jul 2026 23:07:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E3E2DF0
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9043A40162
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1qFOt3O6_7YE for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 23:07:41 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 61B7840089
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 61B7840089
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 61B7840089
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 23:07:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7198494B; Wed, 22 Jul 2026 01:07:39 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AA59803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 01:07:37 +0200 (CEST)
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-45171f2f608so4521980fac.1
 for <u-boot@lists.denx.de>; Tue, 21 Jul 2026 16:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784675256; x=1785280056;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KISXzuASDsl7MXniLf/SzQbjAK9DMjqhdSJUxc4EFrI=;
 b=PML+sUXLs7v6c61x8PswkyGdn4ezYLjrCyl8P1XVkg3MOQQo58nUNICTSc6DFjzdaU
 zx6Axg4k7x+HhcBxgzc+bV7vmkrY+pU0PBOpoNdBJ22iSmguxXwuw13cdq7DkUg6Z2zJ
 Su7al0yVvpgWH8gtsWzXn7WNfWID5wYFQW8UAO8jPIxhE5tSaUM6HRqpHRuVaULiQ7nn
 GGE+ZET/VJkKrppNtUQtAkIAlXYB+VwneGekUz+kP7gSETyUVjvgPW5pWDHyrftDJ8g5
 0LIMJpA97183Y8mV2Zg2MwrtCOS/UWNJsHh5vQTZLuH1GzOsOr5tqtNrEJGZNnFQ2fY6
 CbOw==
X-Gm-Message-State: AOJu0YwRnAj7+o0Wi/DSbMTAo/mf7Nh9SVWbefELvpP4Mw3AotOFFfbm
 lYAHmK2/VE38k+jVVgVZebEcdChCk/wW2DexjVcZlM7rOqBk5FFqN+fcABwKtFdRPnVcI4tiXO9
 in5mHxc0=
X-Gm-Gg: AfdE7cn7RF3PUZ0fu7msxYyB7lQWsuvwVu5gaUpIo+0yNOrTjYQ0W5fm6Z7F9N+bygc
 bf2fanR6DOVftlRPA89TsyC47JIeDRf6GENRbk68OvolqW7Rrf4fRzBaYZde67ydfvktX+Yt/vr
 BEXwhQAId4dls6AQiWwufnXh/1m5ZJ/8aGPX/y4R2z9oWeDiJ4PmC+tVwwb1KtOLBDTjhopxSQI
 O1xR/RPjWgPSSOYMGQFFO8NoqRu/FV4RLZEm4g/8YFbkEBUD7BSL/lWf+bzwR52t3195hTG3P+1
 FIkJfmXqROYZQ//r/lLW9gJPD35L/BnyInks/zy6bhmCDxmhotrUSWSd/50UpRDmPymcRrB2eFl
 Q7PQLtxi5eAWr1W1KA9Ttf0zde4KWm265+RwWOQEhSv8VeWldiCBDf4Snl7U3E70UWpUE1WE7sB
 DWSmT7ShvBrDuE1v/J/ZhC39J3Knezd85jxe/1ej9Wntp7gbW1JK1Tv2ZkqTyyexabMWcMmwQM6
 u8XRN7qDBuL9rvXdviNbRjgqA==
X-Received: by 2002:a05:6808:17a0:b0:4a4:a930:1f70 with SMTP id
 5614622812f47-4a4d03a2c7fmr13003661b6e.24.1784675255851; 
 Tue, 21 Jul 2026 16:07:35 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ab0e9af0afsm76138b6e.12.2026.07.21.16.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 16:07:35 -0700 (PDT)
To: u-boot@lists.denx.de, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260708103452.49277-1-aristo.chen@canonical.com>
References: <20260618154750.180675-1-aristo.chen@canonical.com>
 <20260708103452.49277-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/2] spl: fit: bound external data-size in
 load_simple_fit()
Message-Id: <178467525464.2724617.7724547743088556597.b4-ty@konsulko.com>
Date: Tue, 21 Jul 2026 17:07:34 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1784675256; x=1785280056; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KISXzuASDsl7MXniLf/SzQbjAK9DMjqhdSJUxc4EFrI=;
 b=FlpnTr6W/MQvJLiGqqXJ+Ba0FGjBvrIg3PxokexvSbmjFSD4nMdAnlh0GpJDQgeywV
 F6qimLioppx8BCcFdDbNIZFB5/3qzODz22Y9fajvedlPkwkWzOvNWcjF9m7OWr+VYLzy
 NoOquVtgKFkKJSOGXLlEDZ32F+Dkxe9HKceG0=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=FlpnTr6W
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=trini@konsulko.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FlpnTr6W";
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Tom Rini via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Tom Rini <trini@konsulko.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Wed, 08 Jul 2026 10:34:47 +0000, Aristo Chen wrote:

> Link to v1:
> https://lore.kernel.org/u-boot/20260618154750.180675-1-aristo.chen@canonical.com/
> 
> Changes from v1 (all from Simon's review of patch 1):
> 
> - Move the shared error label to the end of the function so no goto
>   jumps into an if-body. Both bound checks now goto too_big and the
>   printf/return sits after the final return 0.
> - Rewrite the comment on the early len > max_size check. The real
>   reason it exists is to keep get_aligned_image_size() from running
>   its int arithmetic on a hostile value; the block-aligned size
>   check further down is the mathematically binding one because size
>   is len rounded up.
> - Include the data-size value in the diagnostic printf so a real
>   failure is triageable from a board log.
> - Note in the fix commit message that CONFIG_SYS_BOOTM_LEN is a
>   conservative ceiling for the firmware/loadables/FDT/FPGA callers
>   rather than the exact capacity at the destination. The overlay
>   caller remains the one that is actually tight against its buffer.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] spl: fit: bound the external data size before reading it
      commit: 8f71d7170f5c3abadee45683e35ae6d925b6d417
[2/2] test: spl: check load_simple_fit() rejects an oversized data-size
      commit: 85667122fb5fa215315a633335efc27ecd195b21
-- 
Tom



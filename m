Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C01C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:50:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5300E83692;
	Tue,  5 Aug 2025 13:49:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754394599;
	bh=in7OCyFGk+QGPs0laO2KEqEjjgg/Wj/zAAOHXyZAzSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=bukF39BAPRC8gduXn7pIqK12uLhSbOjIs+50lcV9rmy9lZOLEyJjKJHYluSfXEmrh
	 hO7SH7sjQ1GIMiT6K3ejWRdUNDMH4tkWLOVyKRohqFU+KmGkUinRrFzn6UO3EjH5g3
	 tFFS+Ffp4qnqQITOnPsw9bCsHNU8TaZsYsUQKiwcD2HUW8tMxJEOC+XerL0LMpAXGb
	 YYvtLaADjAXWwaql/UR1kt2fZqtG6JaWmRKrZM4XN+Rx3T2KE1ZvfGXSDhXWTHzIpa
	 7mHm0GRzrxLfjmnF8kH2jEuZwbpH45G/QIWUhczx/kOKt03pE86fa2ks8lzSBFW4O/
	 QdIiIO3HU7rHQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECE1C836A6; Tue,  5 Aug 2025 13:49:57 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B80C6834BC
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:49:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="hk9rUIUt"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8A7591038C126; 
 Tue,  5 Aug 2025 13:49:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754394593;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=in7OCyFGk+QGPs0laO2KEqEjjgg/Wj/zAAOHXyZAzSo=;
 b=hk9rUIUt5lGwCw7A7XOw6k0lGaQQe/wvW5DnRMNqa2GRSAEXeptkpKjP093D2nF39A+uYd
 mrvyev688yWUCjLhclOZ9aVc+7LyzvHJ0gzYN2dotf6hh+XDVsUe5ZEbAjqZO4PjCZf2JX
 Ig36rWo1nOaAWkHDWsK0gR5QzEG0CAKjN6f7cTJ0zBOCq3Xju4L/P/Xz8QVkO7sNNwtQK4
 +4N3WE2CNQxOb8PstveXpwxEm2E0TaohnaV6eX78ynHIL1bLIuJBR/3aipOMZG24MeTxzV
 uFceg5HTnMJ6Vl+A1qqdfp9cJ5iO3jXZNRqITawG75utWkTeZgbhQKQivz16BA==
Message-ID: <ab1ee19d-4fcd-7247-9901-759db0ef8b08@denx.de>
Date: Tue, 5 Aug 2025 13:50:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 09/12] cmd: Add i3c command support.
Content-Language: en-US
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, Jonas Karlman
 <jonas@kwiboo.se>, Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250728065612.6039-1-dinesh.maniyam@altera.com>
 <20250728065612.6039-10-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-10-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Dinesh,

On 28.07.25 08:56, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Add i3c command file to support select, get i3c device
> target list, read and write operation.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   cmd/Kconfig                        |   6 +
>   cmd/Makefile                       |   1 +
>   cmd/i3c.c                          | 271 +++++++++++++++++++++++++++++
>   doc/usage/cmd/i3c.rst              | 146 ++++++++++++++++
>   doc/usage/index.rst                |   1 +
>   drivers/i3c/master/dw-i3c-master.c |  35 +++-
>   include/dw-i3c.h                   |   2 +
>   include/i3c.h                      |  28 ++-
>   8 files changed, 488 insertions(+), 2 deletions(-)
>   create mode 100644 cmd/i3c.c
>   create mode 100644 doc/usage/cmd/i3c.rst

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

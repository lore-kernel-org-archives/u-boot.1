Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB48C87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F155682F00;
	Tue,  5 Aug 2025 13:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754393434;
	bh=acUZ5uok5nFcgWUBQSCJeqPR9dnFEgUMXXOReMv/duA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nHU/5dV61VdCoy7XzyAX+m0V5SNQDkIVSd9Ir4XxOmyOXJVf4C6SpVPdmtI7cWXz1
	 7Kgvjkxd5skGbL7DUHLyHaj3CBWCA/blzgLOHVGEriDLNmNzTScdmw77Vh9VV5Tmi8
	 SdCTiWMUYmfjXL3Rg1C/QBWLoZRnm9iAGZwxEBPH/dBp+I6bDK+0WO3+ii+p1z25x/
	 GZ8C43dDmauoKg45VgLblbiumBi/EfFc8/fr47ItxJGE7U/i2SL++2wrI8DI2WZeuM
	 wicbV8AWXNU+ofTkyFnZpxhO3k25LhZHdTt115a4jC3m1Hx2jK432Bb9OCL1g7ZsJc
	 rveBSgdegNqvg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id C061E82F00; Tue,  5 Aug 2025 13:30:32 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAAA682E26
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:30:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="byWfQtGU"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4FE471038C126; 
 Tue,  5 Aug 2025 13:30:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754393424;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=acUZ5uok5nFcgWUBQSCJeqPR9dnFEgUMXXOReMv/duA=;
 b=byWfQtGUGsxEFuUoGRvGkhyYIuD13I4kFOPaxDeyOL8MLayWBoiVEgSXrp9RFaAKEmVW1P
 Xi6WDkr8cW/mLSDEZ6BkUL4cT55BScMq4GXoshx6aCcw6qTahCGyDXsFjyddok6tpMsg5F
 LCp4VjNy0kXUfzZhmDkIK8EAy/cTTa+YCOSjczpssxSnw7rB4llRlr+6RREyiKasxrMucx
 lCwN5mvMuFGs+DtnEFqWLUGME0OrW9q1HoF4st3vm7MKQ0E9XQwDwn/C7tTDso/HaAEIQ/
 upKXjrm9WsIaRxXP4WmuuCnm/ko5GiC2OXZLVC8NHFokMAQ7sCocEMeEI5gbpg==
Message-ID: <5549919a-a66d-1f32-a184-8d6687d860c3@denx.de>
Date: Tue, 5 Aug 2025 13:30:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 08/12] i3c: master: dw-i3c-master: Fix OD_TIMING for
 spike filter
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
 <20250728065612.6039-9-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-9-dinesh.maniyam@altera.com>
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
> Fix the I3C device with spike filter unable to detect issue by setting
> tHIGH_INIT to 200ns for first broadcast address.
> This is according to MIPI SPEC 1.1.1 for first broadcast address
> which is already part of linux upstreamed patch.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/i3c/master/dw-i3c-master.c | 23 +++++++++++++++++++++++
>   include/dw-i3c.h                   |  1 +
>   include/linux/i3c/master.h         |  1 +
>   3 files changed, 25 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

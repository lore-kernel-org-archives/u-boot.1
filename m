Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE2AC87FCB
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:16:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2577D8331C;
	Tue,  5 Aug 2025 13:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754392600;
	bh=3nOU90QQ0AEtT/UJGaoe7Ma+NsmB1/v7ahxwfteWgfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nHiNukPEYTW89QvkM2vaSrPog9IrZOwCSKrA0JmfaivtHxNGLNa+UNlhlLhFzjLjb
	 ifAG0kOkMdIPP78uOicbMOG5UgL6liFkopW+pDEn1/u2zn3lSnVrhXhMKOd35g7P27
	 egjlcXlDHsbELimIlhOSziHIO6B1Lh7P57YO1TQDdnkxgSpZ9IWPDXJT/uFkxcwRjg
	 2u1xezOGMX2CZPHg/6aN4yScyvSWEBflhTceg4eCHru8OvzoW/RwAIw2i7gQ7kJ2O5
	 kGTVA67JI1+uDiviqPC+OmN7eRR+ppKSVG8W192pzKbG9/J+kh1QY7/k968PJLvhL4
	 TBbGm6jZnX/Tg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02EFA83390; Tue,  5 Aug 2025 13:16:39 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97288327A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:16:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Mkwsgyph"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D45ED1038C126; 
 Tue,  5 Aug 2025 13:16:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754392590;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3nOU90QQ0AEtT/UJGaoe7Ma+NsmB1/v7ahxwfteWgfs=;
 b=MkwsgyphbfNbiK8LxJbXmsPvJRxV0Vv+I796Rfhdy1wWJlfePmrwZPSYiIGRBTdWsyoQ43
 V9kA+LjykIVb7sjPEZjgAAu1U0TdKoar2KbLjkfRLYqBsj9OLCPrnnLad7la6cXak0adjd
 qdqU6OxwWXp59qD8P1Hd2n5Mcxpcz27egwFnVOBUzJoObOTLxN7FltXm32XkpLxfka4ME2
 KXoUGshG8ZjzNlLRqxaJpeMsg4a1VGUqy4c3P04yW+mElgDxnr4BgAvYl5evbyUTrLbDsg
 v9lDCf91Tl2RQHY3C6w8wHogaeKKe9iIlEH4lUZni7M6hVDaNhhFF4E5flMNoA==
Message-ID: <1adcfec3-2601-7016-92ac-c6f256151263@denx.de>
Date: Tue, 5 Aug 2025 13:16:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 06/12] drivers: i3c: Add i3c sandbox simple test.
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
 <20250728065612.6039-7-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-7-dinesh.maniyam@altera.com>
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
> Add s simple test for the I3C uclass in sandbox.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   arch/sandbox/dts/test.dts |  8 ++++++
>   drivers/i3c/Kconfig       |  6 +++++
>   drivers/i3c/Makefile      |  1 +
>   drivers/i3c/sandbox_i3c.c | 56 +++++++++++++++++++++++++++++++++++++++
>   test/dm/Makefile          |  1 +
>   test/dm/i3c.c             | 34 ++++++++++++++++++++++++
>   6 files changed, 106 insertions(+)
>   create mode 100644 drivers/i3c/sandbox_i3c.c
>   create mode 100644 test/dm/i3c.c

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

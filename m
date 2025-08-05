Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF191C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:17:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D0A28331C;
	Tue,  5 Aug 2025 13:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754392624;
	bh=AQixj4neOWzYy28rO9bRi+xloePWj/yKc1BrlxPxW48=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=puAYW1uqwhkhwKCSKHzvpB5hc5DS3LP/j1MVt6QT7hLUuO7R0DpcWAbiXAC1vcDcB
	 H0xRZgGkiTsuCcl9Bc16S8uG4VT3q+dUv74MFu1biqT2Hu0XFGd9bRqUDarA2tje13
	 JXr/ZYqDQ6uYxL/VCAM3CP7pRhaVsV6p1pglSPgOhBcfQkjCfl0BHg7XvnG3e0xlxk
	 Wa8WmIacv4WSGiZGQymMlbDpzCs55FLUlTM4S8t98R5xKQkMv55c58u2VtpGgZm3Bz
	 Ml6IcxJsluRr1NwGZ4gb5QsGGlf/4k5o9UXyOJJ2Ksq/YkR9FzjWeLfSoXvInXg3fl
	 6SXfk9g+JjMzw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CBD383642; Tue,  5 Aug 2025 13:17:03 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03FA18327A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:16:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="Tf6tMm3O"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 86CDD1038C126; 
 Tue,  5 Aug 2025 13:16:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754392617;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=AQixj4neOWzYy28rO9bRi+xloePWj/yKc1BrlxPxW48=;
 b=Tf6tMm3OoAlXOyZWfe3b1YX/AWCXsgaM8Rs+pWWhxn/Otaj5LjTGXN2xdPx9xN/jnuDq8/
 w/On8wBwW62o0rIJdfMe478jicUwKbeY32TOaSUmet8KvvNZtAGtIBTx/D3XxntfnGCsTC
 sjcD4KBF/AKzHmbAYqUhIOWZ1fQ9PtGGEUq6e0UzLIoYISQqqgb2D4MayJl2ywN4/mI579
 9AvJhBBklSp7GxMvdN49xLI0KsWOX34MDxnRDRu8+4hMW6P2GbLj4sg8GYKOCNLkp1K43Y
 xTyg7JHX8AtX1x55DWJmXHJqgPysRHZkBEldddaUXawhrAxP8P/1ylBLPUeObg==
Message-ID: <a36f4c0a-9f3d-94b6-21ce-1454a6284406@denx.de>
Date: Tue, 5 Aug 2025 13:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 07/12] drivers: i3c: master: Enable probe i3c without
 slave device
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
 <20250728065612.6039-8-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-8-dinesh.maniyam@altera.com>
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
> Picked linux i3c driver upstraming patch to fix the issue to
> probe for i3c controller without slave device attached.
> With this fix, the ret check will be on command error and will success
> without slave device attached.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   drivers/i3c/master.c | 6 ++++++
>   1 file changed, 6 insertions(+)

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

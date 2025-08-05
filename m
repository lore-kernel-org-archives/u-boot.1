Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DB6FC87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 06:19:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF5A83253;
	Tue,  5 Aug 2025 08:19:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1754374778;
	bh=iV/3/Wpc1eaFtFQVxykCbzc8SbZhbx/WT1z2NJvILsg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=yqKsCJWkKK8VebCaTeDGjoaVAlvlEwr0MDpKs5f1rFOm9Zj7h4/e2DNIDc09Km+50
	 crJpK6monwDqF2YljK5/kzGSqztsE/r5GGzC7AUFbdkM18pVO5ZM/+biQkD7R5ieuK
	 BYTDIDEG7kXF858srLJtUGOP7VvWkNAQPuufx5e93ZifRV2niZ7mwh1cSJTPMP2ypk
	 zQVoKAaU+U/3BsGY5g+Irxs03GFvRFMlbZ0+Zr5hgezbgRDRpMt9H+GGJjhwdlXJSU
	 KaOlwme+vCntXVRKUhzOtXwwlO49dm01Zv2r08SXnVxQ+GD8W6716OhioZGR7WOkVO
	 aJsXg4ybVKUTA==
Received: by phobos.denx.de (Postfix, from userid 109)
 id F038684114; Tue,  5 Aug 2025 08:19:35 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E35883106
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 08:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="dslzJEbv"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0E0001038C126; 
 Tue,  5 Aug 2025 08:19:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1754374772;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=iV/3/Wpc1eaFtFQVxykCbzc8SbZhbx/WT1z2NJvILsg=;
 b=dslzJEbvugbukCH10WyYGwLnlAovLoTpCDvXNyHwieA0ymh1HuWyVV9xOf24Izkq3/k0pF
 fktHBK/TY3l2tP8T/oKxOtFosyQyOiZTyCU+JexX5d3PUldM2L4K0QwaBlN2Qi4V/MAD2w
 2Ixb2sGrGhWxKkmtq5T+oKaroPOQKexvEeduwRlA4YSoPcgftlrURUr63Ht4QWdLBpojoi
 t1NDdxXrCD0Vm2Da0alZSk/qI+mnOq/OljmZr1sflPzXneyYSatqvUVrNRqoKWqprIsH70
 vfEu1bX8yxy3xyrMeHwdnYstGm9EFo9TA9dQ2IHnqQ5JTDVgYv6oWdSgtTFm8A==
Message-ID: <971c099e-1561-a34e-4f6b-01b18eb1727e@denx.de>
Date: Tue, 5 Aug 2025 08:19:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v7 04/12] drivers: Enabled Kconfig and Makefile for i3c
 support
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
 <20250728065612.6039-5-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250728065612.6039-5-dinesh.maniyam@altera.com>
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
> Add new i3c driver to U-Boot drivers.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   MAINTAINERS          |  7 +++++++
>   drivers/Kconfig      |  2 ++
>   drivers/Makefile     |  1 +
>   drivers/i3c/Kconfig  | 16 ++++++++++++++++
>   drivers/i3c/Makefile |  3 +++
>   5 files changed, 29 insertions(+)
>   create mode 100644 drivers/i3c/Kconfig
>   create mode 100644 drivers/i3c/Makefile

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

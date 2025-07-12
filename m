Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4939DC83F1A
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 08:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 551A28006D;
	Sat, 12 Jul 2025 10:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1752308031;
	bh=d2MouUt5t7XjuCj9KdQ3jvcDXeTDYHwZ8b1h/Vfwg7Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=XIgRbgEEuyC5pVC4hVRyxPDbMdKKz8K4iatDOFfgrbUxTPwnCcQfF7bQLiCSggeDp
	 r/V5f4uCvA8VQpMLzoussE6e/wtOL7UrClknPlLCxeoy4emBRFAsr8N4p7ajw+eZrm
	 uwtjLUSSoEeCY0+ATvhb+leXUF8eb/OxmvN14R8TrojVqBSUtDH7iahIloKQeE7aLi
	 sWudgD5lGYpcJx9dLEcJ0sr1MpDWPwJpc2s3/3YCpRcrNPgwcno4bdwrCKnC7OGEe9
	 OjqxK0uIFWJ8To0ECkLmVAUfaxkp1EqUyfadSq8hYMMvbDbInfmW1zuzoXCFZVkNKs
	 /DW9foXfrZkOg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E28C3800D7; Sat, 12 Jul 2025 10:13:49 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CEC58003E
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 10:13:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="BiqUS+3x"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 8B41C10380104; 
 Sat, 12 Jul 2025 10:13:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1752308025;
 h=from:reply-to:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=d2MouUt5t7XjuCj9KdQ3jvcDXeTDYHwZ8b1h/Vfwg7Q=;
 b=BiqUS+3x7Sq46N/4KE7CYrO4atHYsp4+09Gae9PId8YxeXAZL+6s/ZND15PR+Y68oV8mDQ
 I6Y1oz+xyXzKtKXRgHuoz8NXivJWjnN9Df8Pia7ACladEjJzFm+xEkApyUDuptNUETA0Yx
 9bI7BnNzQaY4eLZQZAw+c8N3Nq77weVrSQolBqSmfjQq5ezk1V7jFbsxdGLELcO6VYBpjX
 ivsmr53Gggyr6jK5VQcEMU1wUI/wjpVuyImpWFVByLztPo8pBIhuuF5gSc7rDTOdC6hdzr
 BidFnUXU5GyzraNqEYnT5tkZX5uDFkp8e4SkGFkzPGUPVi1kWS1Xg6Q+mErc7A==
Message-ID: <d941d6c4-496b-e52b-6c98-3bed9137099a@denx.de>
Date: Sat, 12 Jul 2025 10:14:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 03/12] drivers: i3c: Add i3c uclass driver.
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
 <20250513101913.30880-4-dinesh.maniyam@altera.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20250513101913.30880-4-dinesh.maniyam@altera.com>
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

On 13.05.25 12:19, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
> 
> Enable i3c general uclass driver. This uclass driver will have
> genaral read and write api to call the specific i3c driver.
> 
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>   doc/api/i3c.rst          |  8 +++++
>   doc/api/index.rst        |  1 +
>   drivers/i3c/i3c-uclass.c | 38 +++++++++++++++++++++++
>   include/dw-i3c.h         |  1 +
>   include/i3c.h            | 67 ++++++++++++++++++++++++++++++++++++++++
>   5 files changed, 115 insertions(+)
>   create mode 100644 doc/api/i3c.rst
>   create mode 100644 drivers/i3c/i3c-uclass.c
>   create mode 100644 include/i3c.h

Patch drops error in CI:

https://dev.azure.com/hs0298/hs/_build/results?buildId=179&view=logs&j=8a06d10a-f6aa-5571-1476-f02da1a95f96&t=90bc975e-aa28-5566-cec3-344578c5a53d&l=146


./include/i3c.h:54: warning: Function parameter or member 'read' not described in 'dm_i3c_ops'
./include/i3c.h:54: warning: Function parameter or member 'write' not described in 'dm_i3c_ops'

Please fix this, beside of this, I tend to pic kup the series, just one nitpick
on another patch.

bye,
Heiko

-- 
DENX Software Engineering GmbH, Managing Director: Johanna Denk, Tabea Lutz
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de

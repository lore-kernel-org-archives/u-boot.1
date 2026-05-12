Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC1A2CD343F
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 23:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49AA4836AC;
	Wed, 13 May 2026 01:43:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="srITWfQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5B8283F14; Wed, 13 May 2026 01:43:20 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F0DE800AE
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 01:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dca5f64e86so4852895a34.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778629397; x=1779234197;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJ8uc8ltHU+O8wOGsq1NqDROKfY8Uaa34Nu/tq3oAe8=;
 b=srITWfQfIcvZCD6oEirraOEd3o018D7WVKqM+egRKBs1gpR/XzzLzxjvTruFKq9DWl
 m2Ry4OPIj9h9K9zFyOHFPAEoV/8tVlFzEXWJbxnr/Nl8AH5WWDriVzzIhaizI4xDz+Dl
 kZ5jhYqBh+2pyrAacjbHcd6wQEouNvv7lX4shFs3sgRlv11NeXL6gHjdZPEPkxpRukR1
 TdBYyEOzZsYUQNrI5HLhOh68jRGX/Ghp9dOOhDhTkFAvIY0xPEbeeoT3TgilXkuHYXYs
 L5S9qPpzZdoGRbdYSqnvPRVmWNwzkgssbaVM8jdNF27UrQFrjIviA7GFhFjjT9/szPpF
 GVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778629397; x=1779234197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IJ8uc8ltHU+O8wOGsq1NqDROKfY8Uaa34Nu/tq3oAe8=;
 b=VK/H81OmXEdQPNfd2kyOrsMFiMqYEXhdBhDEsO8Dz+Uk8XZ++F052IZ3txTj2679lD
 n8XQtmW0gf12Q8uYLv3ZcIShrKmEFJgv/KmXOBpRmu8zIFcL3abmm2zLlHwaYXL9gjzH
 m9YIt/ZOQ2E+YgSbc4j4T3K0yzagRORBaY7K4VJsqsqQZ8At+HTXn2Xqqi7XO9sr470j
 /AAHP4j9G6AralZW33HjtW28ZlFYzYOA86an7jzlWkl6IOEfp/U8EMvWlOXyCaIhYExt
 GQO7iNOhVRdb4Uo2zKiWK2BZhf89sE8tnJ9OhTKb2atOpNhDHIfToPuxRXmOw4m/OV6C
 U4lA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/pMaD4fkk+SiThgSZ2+Y0SM26FKy/BswcnqfQYbDBUkAzxxOJ4iqKZyGnRJzzd9gr1S4FUqig=@lists.denx.de
X-Gm-Message-State: AOJu0Yx6PHl0lgI4GctpcH8bPDKWAYuEJe4GcN8Qkph2BIivYWYk4fn1
 9vHRFBccbNH/mOl/6wfI9D31r1Ds9rxGvGRJC927al//dlA75xIycEG3HYTs4Q79Mp0=
X-Gm-Gg: Acq92OGfKAEDxr6/linbAeR8ffJqT39Ka3EwK521MzmHt8Ia9e0Qpdkfd3jtVYgh+6q
 ELw5oo5mSL5XTw2GvN3U3cKt2mUd3/0S33HwCaX1Vkj5Un5MGkwApgbUnv4Qs/UMwpXe9o8J48q
 nf/iSD0P4Xrvm+6opmqk7hSy+H5yXp8XdCkjmEo10IpGntjjVueYforTWyi8h/LRialtG2V8e/8
 A1Fy/oV5e1TDHtwoyUCaCRNZWHsrO5XiLMXR6CLTOHX6x1o4E2d05BDs0Q0Vn0qWgIdVbaKTCQ3
 5boTaReOJKlt7Kfvf4sVPulFFO1ULhfRAWjrQL+q3BclB2QskdwtMjWygX//CgK4AhlOgtsoSOa
 CpsP9IS174FcM7u4g08B2hz+qE2ihe0dmOc46kTpzk8f/tjD7yGkwrTD9UqBeEomxtWBc7U79y1
 dJRvCBxyaB5hdditUcUmQ5jEI5Q+WUzlEPzP/dXAOkG6Bcej4Ty8yh6i/h3oYt9yqsYXVydp9J6
 o587wFxWVHF
X-Received: by 2002:a05:6830:2b0c:b0:7d7:f13a:761c with SMTP id
 46e09a7af769-7e3dca74f4bmr245028a34.23.1778629397243; 
 Tue, 12 May 2026 16:43:17 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:7ca1:aac3:aee4:c93f?
 ([2600:8803:e7e4:500:7ca1:aac3:aee4:c93f])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367dfb66csm9859440a34.27.2026.05.12.16.43.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 16:43:15 -0700 (PDT)
Message-ID: <b1bb4499-f375-41c7-8f19-b189722d6ea9@baylibre.com>
Date: Tue, 12 May 2026 18:43:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/11] pinctrl: add support of Airoha SoCs
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Anis Chali <chalianis1@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Yao Zi <me@ziyao.cc>,
 Sean Anderson <sean.anderson@linux.dev>, Michal Simek
 <michal.simek@amd.com>, "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260509111157.4039434-1-mikhail.kshevetskiy@iopsys.eu>
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

On 5/9/26 6:11 AM, Mikhail Kshevetskiy wrote:
> This patch series add pin controller and gpio driver support for EN7523/
> AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
> gpio driver with Matheus Sampaio Queiroga changes.
> 
> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
> 
> Additionally in the EN7523 case the patches removes existing gpio dts nodes
> and replaces them with pinctrl node. It should not be very dangerous, because:
>  * No official EN7523 gpio support present in U-Boot
>  * Legacy Linux EN7523 GPIO driver is mostly abandoned
>  * The same driver is planned for upstream linux/openwrt
> 
> This patchset includes bitfield.h patches created for Linux kernel
> by Geert Uytterhoeven. It suits U-Boot fine. I preserve original author
> and original commit messages. It might be not a best strategy, because
> these patches refers to other linux kernel commits not added to U-Boot.
> Please note me, if there is a better way.
> 
> The patches were tested on EN7523/AN7581/AN7583 boards.
With patch 5 split as suggested:

Reviewed-by: David Lechner <dlechner@baylibre.com>


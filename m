Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7564CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 21:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7AEA8488A;
	Fri, 12 Jun 2026 23:30:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Nrf6sPow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF8C848B0; Fri, 12 Jun 2026 23:30:41 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CBA18056B
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 23:30:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e6b571750bso1283746a34.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781299838; x=1781904638; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g87Lmnz8Zl27RM5epPdz6pJ2o8tBaIx6p2jA/GVudAY=;
 b=Nrf6sPow529jue/rOBSaVow+CGq8wbW+ifV3LFpwbqLzTPIMQU8ib4IDF7zSFN9oxO
 vorY5wvTEMMm8A4TNm5lsLS4snFDyp/F3TDRWFsOdML9Jx3upxxlqoqSsdaAtGTY6Fb5
 hh1fhaK+C2umqJLTgdut3y8k7esDvAgUT5CWsQ72j1Gu6V0uA7ubgRGOzJrc+6cG51d/
 qJggDT1N6D6pOApVTdYWGQdYp7fuNe+DwjBEusnZ5d0It/ocK7QNj4989H/MV+aP/G7D
 QzAca2Jz9dE+FJKIIHEOTUQ2FIEslmQN1EiVxBG+D6OgkEk7z/0Mvl4Uf0McTXan+vWv
 212Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781299838; x=1781904638;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g87Lmnz8Zl27RM5epPdz6pJ2o8tBaIx6p2jA/GVudAY=;
 b=m5nRvIw33J4oP7R6Yc+yyaNW9I2OwG84nOx7O3kl2nAB6ukn9NLcOzoGwgR142BnQd
 kNVHUIbUvFORELWaZh366oZwkyZJgbROkBnQkDsq5yxn06dxCT4h9mCgPo5pwBuhR8em
 LGOBMcWEL2Sean0y3V6LUHwNCpO18hRhOcNPzrTfpnRvH+ux6tYnfR4htfrH700CIOnw
 cEJj33M/xb2RoQ7t4zEblwjmOCLzHojYyKBwSy8egq1muErcW3pqoL4Udh1h8N9EJkyy
 KojpQo+B1371Yqbq9UXi2FLblNOamJtH7iwqM6kzsoSR9KXJ9q5BGkOaC7AMnhAYA0CS
 nCug==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7r8V3W398rM+LWxQzGRUyVsOxs3UavNfG8SPXx7SFP8z7GIhlSjfTPy02omQfdjkIe8cNeWM=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1XMlGSq4/AZek11REA2KzOa5KzhacPP4EcoWTaeiWfwNHFruo
 md0DTdX7iR/P6QMuH8G8iwadik1y5nc2r/bjvXh3mUU7gocc4LblXtQNptjVP43rRe0=
X-Gm-Gg: Acq92OGlYwjFqMV/CxS0rNMIg7Xw7efM4nJw2skyr6IybRe65Cc/hgC9uSDS53APnhD
 yIvBpgkPySyoiU4IwrUckuz7ceg40Oizo6Ln6WZs8yW1tFp6/m5etDf6j/opudr0MJe92PfLfxj
 KuQSMOATA0wWSw3hQ8JD0xUr+1EYSP42I/WIRO0WIdecsOzP7xKhsF//lbIpuveAkKvrkjBhQyX
 COxIm+lrIUmwWqtcR5I+QM8lkhnQAqjEoYih/7HZ2ky1Hf/utlgZnU3smXkJy2qGdZgNgV+X8XK
 StrVNwCh+JmjPO4wIa4/xDuCuYgNlM3dP+1T24MCZ2bMdAC9uJ18nF4JOgJOFkKGg2GAxf3scq0
 SUf8iT0wxwEQTOqVxK926ybm3wTFpDV6DsCSkBmYHFBxpb0FwRK9BLxWulyCdMg46Ks+l/JEBK2
 1g0ZD0IZXJoWNxcvJx/ewWXICqdJhI41Cs8rzDdHZ2mz0YGGmQYRgpTRkIAFW29jRDAMD2rUf2B
 w==
X-Received: by 2002:a05:6830:2316:b0:7e6:d0ad:5254 with SMTP id
 46e09a7af769-7e7846db06dmr3193225a34.8.1781299837826; 
 Fri, 12 Jun 2026 14:30:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:cb9a:87cc:1314:fef5?
 ([2600:8803:e7e4:500:cb9a:87cc:1314:fef5])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e7816b3f4fsm2739508a34.14.2026.06.12.14.30.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 14:30:37 -0700 (PDT)
Message-ID: <249e2ffb-2ad1-4dd4-8d24-dce8053244e2@baylibre.com>
Date: Fri, 12 Jun 2026 16:30:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] lmb: default LMB_LIMIT_DMA_BELOW_RAM_TOP for 64-bit
 Mediatek SoCs
To: Sam Edwards <cfsworks@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Sam Shih <sam.shih@mediatek.com>, Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, Rudy Andram
 <rmandrad@gmail.com>, Julien Stephan <jstephan@baylibre.com>,
 u-boot@lists.denx.de
References: <20260611-mtk-fix-ram-size-v1-0-42ed330660ca@baylibre.com>
 <20260611-mtk-fix-ram-size-v1-1-42ed330660ca@baylibre.com>
 <CAH5Ym4i=fkGC_WvECVqzK=K-GL_fV8hyBH3qd30f02n9gnfq5A@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAH5Ym4i=fkGC_WvECVqzK=K-GL_fV8hyBH3qd30f02n9gnfq5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 6/12/26 12:52 PM, Sam Edwards wrote:
> On Fri, Jun 12, 2026 at 10:32 AM David Lechner <dlechner@baylibre.com> wrote:
>>
>> Add 64-bit Mediatek ARM SoCs to the default y setting of
>> LMB_LIMIT_DMA_BELOW_RAM_TOP. These platforms have a 4GiB DMA limit, e.g.
>> for the SD/MMC controller.
> 
> Hi David,
> 
> Is the 4GiB DMA limit due to the interconnect itself or are there
> merely a few blocks that can't speak 64-bit? If the latter, I think
> it'd be clearer to associate the setting with the culprit driver(s)
> rather than the whole platform, so that it can be removed if/when
> those drivers begin to use bounce buffers.
> 
For MediaTek, I think it is mostly specific IP blocks (e.g. MMC in the
mt8xxx targets in and NETSYS in mt79xx targets covered by this series are
the ones I am aware of).

Weijie Gao, maybe you have more information about this?



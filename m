Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B65C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 16:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C8E3E40789;
	Wed, 29 Jul 2026 16:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wrISDI6cilfW; Wed, 29 Jul 2026 16:29:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DDAD940763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785342564;
	bh=SmVLyD3hAz3ccMgxCwgLXLOW4LECUINQOp3DhHjaWpw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yDNWmDog/FVHhaNmQQKhu0mOl38Su3To30gekrqQlUhGfZBxudxFjs6QTUhJT/0Hp
	 nJekj8CMCmr3aINOuMbBlfs1sBVWoPwTjOybAd9agZbuwkmzB3PyCOJll8MHBdwbMp
	 lKPtXkhYmD4vGya/mLjSd+u5CmlpmxM/7dffuVsXRI6aqYSotOLBG4P2ibJMcVjhD/
	 p526xGVDjcMOpQJHlDCCZYkG41PWtn0JDsQacraN5P/uXM8YAjRVJ6yyiJuqXJgjXw
	 NOylnPhk+zp6b850A2yCaTVl6AynOPWofRVeuVE14MV3XCAZc7gQWzu4YA2xkfi4n4
	 IWWpuackfbjPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDAD940763;
	Wed, 29 Jul 2026 16:29:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2394A42A
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0A07E4014E
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:29:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ibx_wLE_VpMH for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 16:29:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32e; helo=mail-ot1-x32e.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org C647C4009F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C647C4009F
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C647C4009F
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 16:29:20 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7eb63dbd229so42290a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785342559; x=1785947359;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SmVLyD3hAz3ccMgxCwgLXLOW4LECUINQOp3DhHjaWpw=;
 b=dQpM3QahKX1wRz/b7DNWMYDPMw4KNSblV5viTBpOH6kpXGIdlj992Tk8FN/S98YgHz
 dkf1lo3+MLMTQhRi9f8ApncAywzKgs9gefbqATMgftCBqnK8IYTMzwRivH9Ofhr0GFrl
 7OSakQdYAr9gfZpitzyC7Y86LmOGglx83SbD/oTX97LeRs1Xj4HLBxV+MMUu6ygaUjTM
 5dZZC2CTxFu5oIW/hLazDOHY+X6wfa0ZvAHQgI703+77Tk53hvovt2IrC1tbzOV+ytOQ
 MhPJxyxdUTcKP5W8qhSkhIrI9Jybd+mt/wxIkKbwAkOms3koiWbcvU9TgD4k4PjCYaNf
 8I8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAI5zYw3J0iRI6mBiCa3UomZGoRRs4DzGWIOreeKaJBCN5+LwZNIdKZsa3KUG6VEX78NitQaI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyKKXisuul3ecOaNXQ4AEeFHcJW+5Hskllme1MWG8/TXN7pBMgp
 czcmoSdxAfhYhFbiPMNVGWa8EFsdABGWtWiJgFlD4lLvU7SBO4k12Q5p4cG8BxZKj1c=
X-Gm-Gg: AR+sD11VThFS+AyvIEjFI9JGaHOZROp/1iRwf2NiTAook0TZC3GS8/drzaEBang2U7t
 z+SM9lpEetfWuaXfN/S1CSHdk+QsN+e5M6HYPJs8J4Y9vJrkFzBnXDEpyCkdo9LdexpZgB89xtA
 pXx72S+skbMYRY4x5wZ48Mo0BO9IJHkrgobALPcE3uhChyPnKIB+gCDpV5XUCeRzYjTpIbQYu37
 TSqGXgFzS/6TJPzbp18ADE8JgpgWX+iVxrg1d0bVLVvhvJ542wBYl5dkYmBs94mMeiLrcvQF97U
 9JDPOfbx7LTPqsu3l4CFptr9jMitBvlgK5qm74Mu3VWT4HmI+vSh/J22Cq0gQ6s/XNCpmFTFuW5
 VOPDC6rLRGzHw1A5OyFwkmBMw6lNvo4kioYBN1hETA++HUDiPn1eajKFacLWAc1KTh0gm3Y1l7w
 0zYYLzX0KOhLshEcYojRyA/RQPh50Qr7jExh4yQkkqBN171N/vFCSwzdEBSyfa6wZH3lOLttHZu
 QB81fy++O7c1ZtxKFjeBE3ecv4/5yxf3pDL+BQ=
X-Received: by 2002:a05:6830:7082:20b0:7e9:ca12:37bf with SMTP id
 46e09a7af769-7f014155e9amr912955a34.7.1785342559373; 
 Wed, 29 Jul 2026 09:29:19 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3096:ee5f:6f57:afe1?
 ([2600:8803:e7e4:500:3096:ee5f:6f57:afe1])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f00d94d7desm2722520a34.22.2026.07.29.09.29.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2026 09:29:18 -0700 (PDT)
Message-ID: <afb92523-90a9-456d-b0c5-66042627854d@baylibre.com>
Date: Wed, 29 Jul 2026 11:29:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] i2c: mtk_mt8195_i2c_ddc: add new driver
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Heiko Schocher <hs@nabladev.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Pavlo Yadvychuk <pyadvychuk@baylibre.com>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Johan Jonker <jbx6244@gmail.com>
References: <20260727-mt8188-add-ddc-i2c-driver-v2-0-bf1c45fcd588@baylibre.com>
 <20260727-mt8188-add-ddc-i2c-driver-v2-2-bf1c45fcd588@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260727-mt8188-add-ddc-i2c-driver-v2-2-bf1c45fcd588@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785342559; x=1785947359;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SmVLyD3hAz3ccMgxCwgLXLOW4LECUINQOp3DhHjaWpw=;
 b=VbVAs2X6CkrqJiDv5/7ev78pbELwQyReyMdZoNx06aD1FR7jA3KGdJhp9Gd36reLtd
 6DkTTI10aMD0E+1WNxjeJpzLafWrhjsFDFZ2D10A9SKhYNsnirZVdFpbGgFKvny0ME5v
 iY/F1ST0OWXQMeq8nu9fdKrOPUw9AlATJ7s5YjzNv2R4u+P4B5jBUgMjRMFfdLw6aE+S
 7SsURsT9VogVkjp+N1Ep+f9FBXx+BXGPEA3CG63ByujOoUBvQzVr7xIBtAnTKmIaUWug
 0Et9D4rc0HL6Jgmo5ZorsOByYqvGmuLBk+XfmGlCXbozL5LwNa0QFQWDZHyvvbTm+vMg
 eOPA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=VbVAs2X6
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/27/26 3:43 AM, Julien Stephan wrote:
> Add a new driver for HDMI DDC channel reading for MT8195 based SoCs.
> The driver is based on the corresponding kernel driver.
> 

...

> +#define DDC2_CLOCK 572 /* BIM=208M/(v*4) = 90Khz */
> +#define DDC2_CLOCK_EDID 832 /* BIM=208M/(v*4) = 62.5Khz */
> +
Do we need to do anything about [1] here? (about math not adding
up for 90Khz comment.)

[1]: https://patchwork.ozlabs.org/project/uboot/patch/20260717-mt8188-add-ddc-i2c-driver-v1-2-e89ccd173567@baylibre.com/#3728771

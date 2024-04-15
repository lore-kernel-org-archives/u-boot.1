Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53DBC4345F
	for <u-boot@archiver.kernel.org>; Mon, 15 Apr 2024 10:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25CC287D40;
	Mon, 15 Apr 2024 12:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="np6E6f6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A711F87DE5; Mon, 15 Apr 2024 12:45:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A18A879AF
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 12:45:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4187731a547so2177485e9.0
 for <u-boot@lists.denx.de>; Mon, 15 Apr 2024 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713177931; x=1713782731; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LIuE51yLwVtoW4VbMxOihtWbarcd806H21Dc3pdfMxc=;
 b=np6E6f6Z9Kqf+92g0vZzSHEdxYhz7vg/PJ7KEV1wHAjurA1ZqKZvJajD4iNdpofuOC
 Na8Y0miamRi3xJ+mvvOJ5tQpqpW2NaF7hwLK4/aXH27d3FQ1rMpBx/X5gfgLIAlYBAJY
 EqUByqEJwH6Oa7b2vgOGE0fzv5gJYj8/yRELcU8ndySVme9Br7Fe1w0r87jB1/ZCtrOp
 esr8L8r0sfIU+Pj/VZOprjAldy5QboL6zyz4X3CQ9HG/WII+HmWhiJ1ZbJOd3INwl6r+
 rbD8mzcRYUYwqxTZV4a0+UsPYKX4T0x7iHNGaR/bbeqlTIeT3p5HYrvulO6SrxtOSJSv
 TiFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713177931; x=1713782731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LIuE51yLwVtoW4VbMxOihtWbarcd806H21Dc3pdfMxc=;
 b=PopttVA3s4WCdNYUIERIpJDW6B0l0TGBmtDuFO9TKSa/sKNB6vfDHjjcnO+xOSZ9kz
 Gh6ffsWiv3WTMURaLLCzJKMe5zHexYscH332GsdSHWoEXXfw9kiMm1UqHV3ut4VqB3NK
 3reFxZrtz2M1Qdw3pP6P03nFp76Jl7NTBywwYzlqItfNraxSBswSCwuFAOcf5E5f6Cmp
 EWR9pR1MbVLCch002KCGeUIwcfoiWQURMDmPKv7GrOGRwbRaRotRQqGCdv4zO3vJ4U+C
 UU0UxVYjwOFzh8zQiIGp8pvnpTS4sMoUKjgkDaW4IsycX3Y760ERW5swWIyuMMWs710l
 eqIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBR3V7UZu84fQXk4nPkPNnLLJy0rGTwxDnGn7E5VP0R4Sz3jbWWIrKJ+7/Ls/68Dk34bGH1ol1tkKnbnY6fukCiYTyPQ==
X-Gm-Message-State: AOJu0YyILyvhCMAbN7M1yIL9lUR2Zfx1Su0sYeeJZcHHoyus41c6t0/S
 ciBvqlk/z44xRLbafqYlp3dI8UVbrHGfo8gRYRV7OI555CsicF6qrhiR8seZMW8=
X-Google-Smtp-Source: AGHT+IH2+usphJFYfWv2XKA2Wsoq4ApUndtMBYHIjWN64zeCFiGGU+Ug3E6HPEyI/MpH/6eXp4DUnA==
X-Received: by 2002:a05:600c:358d:b0:417:4ff3:391a with SMTP id
 p13-20020a05600c358d00b004174ff3391amr7681356wmq.31.1713177931018; 
 Mon, 15 Apr 2024 03:45:31 -0700 (PDT)
Received: from [192.168.1.78] (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 m11-20020a05600c4f4b00b0041816c3049csm10045511wmq.11.2024.04.15.03.45.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Apr 2024 03:45:30 -0700 (PDT)
Message-ID: <ec590ee3-ee25-4a19-bfdf-606ca6fd55cf@linaro.org>
Date: Mon, 15 Apr 2024 11:45:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] event: add an event for livetree fixups
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
Cc: Artur Rojek <artur@conclusive.pl>, Bin Meng <bmeng.cn@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Shiji Yang <yangshiji66@outlook.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240412190542.1576801-1-caleb.connolly@linaro.org>
 <20240412194510.GY2493117@bill-the-cat>
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240412194510.GY2493117@bill-the-cat>
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



On 12/04/2024 20:45, Tom Rini wrote:
> On Fri, Apr 12, 2024 at 08:04:02PM +0100, Caleb Connolly wrote:
> 
>> Introduce a new EVT_OF_LIVE event to allow for the livetree to be
>> modified before dm_init_and_scan(). Boards can perform fixups here to
>> handle incompatibilities between U-Boot drivers and upstream DT.
>>
>> This will be used by Qualcomm platforms in future patches to enable
>> setting the dr_mode property if the board doesn't provide one. This has to be
>> set before dm_init_and_scan() is called as this property effects the binding of
>> drivers.
> 
> This doesn't quite explain why the answer isn't "fix the device tree
> source" and instead "perform a live fixup". Thanks.

Hi Tom,

I think the specifics here that make this difficult is that on some
Qualcomm boards there is only one USB controller, which can be muxed
either to a type-c port or to a USB hub via a DIP switch (the state of
which cannot easily be read out).

The DT should therefore either not set dr_mode or set it to OTG. This is
what Linux expects (and it can do proper role detection).

The dwc3 driver in U-Boot currently doesn't have the ability to
dynamically mode switch, this is something I'd like to add (as it would
let us easily flash these boards from U-Boot as well as boot from USB or
ethernet), but in the mean time the only way to get these boards into
host mode (which is the preferred default) is to modify the DT in a way
that breaks Linux.

Hence the proposal in this patch.

If this is ok for you then I'll re-send with this additional context in
the commit description.

Thanks and regards,

-- 
// Caleb (they/them)

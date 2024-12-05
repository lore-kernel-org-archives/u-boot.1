Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B53EE7716D
	for <u-boot@archiver.kernel.org>; Thu,  5 Dec 2024 13:08:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35D0889504;
	Thu,  5 Dec 2024 14:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I3aurjU7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9C1C88F6C; Thu,  5 Dec 2024 08:50:26 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CE2B88F2E
 for <u-boot@lists.denx.de>; Thu,  5 Dec 2024 08:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tudor.ambarus@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-434ab114753so3814595e9.0
 for <u-boot@lists.denx.de>; Wed, 04 Dec 2024 23:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733385023; x=1733989823; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wC8pTYmVODBrr99MFA/ff0yJPx+QUlaOTt3PT3eqPzU=;
 b=I3aurjU7/atlRBXIULNS7fGY1kCZ21FzAvfvbCW3gEPnjiOCNTVgacuYi+3celPQ9E
 T+JTQdfp9sPKe+ltoCRcxqCoNRw+quFrYpV+1jvtKbKM0fz7X3Awz7/BYsQigB80cpnD
 4jfltCyRxv3iVdy+Jyp6EQDqbps61rUHzlfaNlAFTv/dvV3nxO6dn7k5TooWkN8lqy+t
 AsVJ8LL8WKF627tpsoKUAoWUKOBSZS/NizSiG2UBZwWXi93xEU5bxYU+VqSQuaV5Dqwe
 FJ8RV5vI3jFG3LTEBMTC9WUDurJ1/XthCPozWFO8L6IDjuDjNokafSirlUXEqbng1dHO
 ablA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733385023; x=1733989823;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wC8pTYmVODBrr99MFA/ff0yJPx+QUlaOTt3PT3eqPzU=;
 b=w2k6UzegQiY7KWi0QE/pJKJkLkNQN7aQZVzDyGU11oSqisyQUAOMLoCM9dQ2fGgV0v
 wb+Yn4hrvAdoBapMWPnQZCfTmFeUkqXorpXw9zaOAI1fKYjuv4c8KlNOJ0w93LZOA3Jo
 vmn0Jki6ouX2Y43T+roo23B2mDmwb5/4LUxJKyId5HLB57VkDY3oTH/brlDNRgmU4guc
 pA/Hr+tm9klYiV1UpvcvZEx7+qBhiZI1JMvcytrR9XbgJ+pVeMWq7sH0x5Gd6d2gH3GT
 vb52jkjficU+pLZLpceV0roiaCIkGgsrDJ4e/iPDVfM3t5PmDyKSOYSnTniwvts+CK5q
 6NKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsTFpE8d9mJ/frSiy25PxF4KNZTWf7DQPPFUTcanF6dcVad67yW/k8lzwEy1WRYvhyUQeeRak=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx5bxyxQCEgPIqoMqhC2Y5ElaWaCLUygaPFY+yIBoIUaPvxPym
 5sbscxbnTRGlgVlgnB1M7IyGTx1Ac46mNwGu/15sU/jVjA4kLPRZLm7ckaUwljOwsRMRw6kbJS+
 3
X-Gm-Gg: ASbGnctkh671Rn4LOgIzttE7VdrDf6MBfVgBJnEtYi3O+KPeZ11gsgweUiMW8M7Ouxl
 sfWKLiP3DMnzmHaSwBozk3sX79Zmo20OjmAdcJOI+35br0Iw7hAu02fSWlx+rKNSE67F3Rc9R+w
 hu76QxKxTKsjnkQqF1J3hwKX7rOYqth4M30GvtXNIUVK2YixpSecT/XSUVDRT6j40zd/0RpPSqe
 4py0EqAyDWVL5fFS94gHOWtQWpWzunks/w2Rpxw3lPUR0ONTZaZTvc7PA==
X-Google-Smtp-Source: AGHT+IFP7jGQpRj9vmQuv6nTwQeY4hqFZ2GofIrN3A9Kk5VT2wF5/sieVDM4SWXndCVH3qKLQvXjcg==
X-Received: by 2002:a05:600c:3aca:b0:434:a10f:52fa with SMTP id
 5b1f17b1804b1-434d0a1d4b8mr71036945e9.32.1733385023609; 
 Wed, 04 Dec 2024 23:50:23 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d5273b1dsm51009855e9.15.2024.12.04.23.50.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 23:50:22 -0800 (PST)
Message-ID: <19873424-f054-45d5-ba3e-9fb484ceb6e1@linaro.org>
Date: Thu, 5 Dec 2024 07:50:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all
 mt35xx flashes
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 u-boot@lists.denx.de, j-humphreys@ti.com
Cc: michal.simek@amd.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 u-kumar1@ti.com, trini@konsulko.com, seanga2@gmail.com,
 caleb.connolly@linaro.org, sjg@chromium.org, william.zhang@broadcom.com,
 stefan_b@posteo.net, quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com,
 p-mantena@ti.com, git@amd.com
References: <20241205042919.297068-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20241205042919.297068-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 05 Dec 2024 14:07:50 +0100
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



On 12/5/24 4:29 AM, Venkatesh Yadav Abbarapu wrote:
> Add SPI_NOR_OCTAL_DTR_READ flags to micron flashes
> mt35xu01g and mt35xu02g. Also move them under
> CONFIG_SPI_FLASH_MT35XU config, so that in driver
> mt35xu512aba_fixups will be applied.

Why? What problem are you trying to solve? Should we have a fixes tag?
Why didn't you split these 2 changes in 2 dedicated patches?

Please read the following before submitting v3:
https://docs.u-boot.org/en/latest/develop/sending_patches.html
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

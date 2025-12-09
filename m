Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074CCD1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 15:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED7083C30;
	Tue,  9 Dec 2025 16:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="maHOTFCt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39BA583B48; Tue,  9 Dec 2025 16:03:13 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E99983C30
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 16:02:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7370698a8eso786978366b.0
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765292567; x=1765897367; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bZfX5QyDy5IZMmJBRjT6xZriXJ0bW6RaBk/CwI8wDik=;
 b=maHOTFCtcoPlYZkTcpNWpR26bbV1Y2MF3TEja8+Rc0I1+ByH0G58jzdUPsl1oY6PPh
 5APGxzSs9E/4RiqBa9FGrYi256ja4ge0km2O0vLr+MVxFhNG7nZDUHkOLbKOmOH0kPVI
 zAMXOqD1gho1Nc+HZWJtgbsqANqB3AkEXRMp0ZwzkgfbotIqnnpTTEuD1Bj4BFY0cD+2
 V+xHAtjRxMIXkVnEBgKLj7Qco2lRfslmaMu6qiHngXeKzXlzfYEp1II0/ivT9GJIhO41
 nlXwi8R0xoCPeNiRklNbcLdetx+1qYMZ12LZyXqCOCfoMfIF6qfFECvPUOKigV9Uqbiy
 mCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765292567; x=1765897367;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZfX5QyDy5IZMmJBRjT6xZriXJ0bW6RaBk/CwI8wDik=;
 b=D/U7l1/dJGGtHe1vJ7Ez6J7LsxFpOupIuPk6TLXsejRMDXPlB6P5K3ye2vRBhUDmbg
 b2CDK6utPkeymhpvhBlD2cOlurV7FvkuvjMxNA6qPBftIKnRi4NXjUPFuvtaqrACRomv
 J7DVT8WcrXvxiDAjdjjE6fKDh7cx3m4ap9SSHCqBt7FqAiEEqUfFFyNSOLYc7pzbL/QI
 U04peTCR0UObZIyhBuVSbnfVvmXWFcTnhvra/sBA/0bsdXOR1FxNwhQ2IzeKi1FlgCTM
 L59xQcgnKcLpnFT6DT6x5kq+f7Ysxe6XhAHjkZQmghynDP1anzcHeH8W6en8wT5v18Zb
 mY5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTLwy7G6n6gYfWy+Sr+mjdn4dqi33U+4zzgjxGRkp+AmSOLS35WqC+6zyLRyMsGVYLHedVjZA=@lists.denx.de
X-Gm-Message-State: AOJu0YwLauIdsGDlbDXovWAx4/km1x/xci9WnYj5PAyplOJZw61hn8GK
 MOps6PPAiBusfdLkRvV+egCg/iiy+VrCeL0abU7zs32/mooCfBz08+ekFiuI36itz28=
X-Gm-Gg: ASbGncu7TY3w4BnJE5/SyhKdnnTMdA6WsBrL45iNRaKihGaIeFxu/UZdNJQ8y74kAjl
 9/gvX+6/H7c5dIRy1T5C51VaVDAIhyZ2Fnk79EsVhl4m/k32rlQ/ODJW/ZQzLWzIxoZrXGmYRA3
 cm1TngKOsHzoWa10q5VECTN77h12+VmiJoqh03roukL7FewwXqUOr965L1DOtPtTLuS+vzlSRlG
 NJKXs2igkUBGylWCqRSKsGdqcDhVesUT8bnishp6kw3P5eny5BduZgm85VuXJkB7nHletlXFzNB
 3OQ0JeStcOPEQP4geaxlLRa3lTw7EcUe14MWqLggb5zYD1HAvnOJ0/JL16y4omXBdn0JANW74wY
 1e/VWCBDWqgBcA448eAevfTsQiCkWMgtFYi2QZoVbDfJ0mwaFGrCsIYC4i/g8mQqCpzD9vwPbkL
 Wf0fW6umHph9pFFOe57lGWPEhRIifh/roU
X-Google-Smtp-Source: AGHT+IHnHg+u7KdHdoVtGCtjqHgc6Tm+iV4P/VLSjnbcTP3Mu/NFtN/sQDZSWVHyy3sAXl4iZzRXWQ==
X-Received: by 2002:a17:907:3ea3:b0:b72:d9f1:75e5 with SMTP id
 a640c23a62f3a-b7a243043f3mr1330915466b.20.1765292567438; 
 Tue, 09 Dec 2025 07:02:47 -0800 (PST)
Received: from [10.100.0.2] ([194.15.111.143])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f44d3d9esm1371184366b.30.2025.12.09.07.02.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:02:47 -0800 (PST)
Message-ID: <9f26cb1f-1cea-41cc-b0de-76f1e9118502@linaro.org>
Date: Tue, 9 Dec 2025 16:02:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] net: nfs: Move most NFS code to common files
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Benjamin Hahn <B.Hahn@phytec.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Max Merchel <Max.Merchel@ew.tq-group.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Andre Przywara <andre.przywara@arm.com>, Tim Harvey <tharvey@gateworks.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Martyn Welch <martyn.welch@collabora.com>
References: <20251208-lwip_nfs-v1-0-1f5d31e15d00@linaro.org>
 <20251208-lwip_nfs-v1-4-1f5d31e15d00@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251208-lwip_nfs-v1-4-1f5d31e15d00@linaro.org>
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

Hi Andrew,

On 12/8/25 13:52, Andrew Goodbody wrote:
> Move most of the NFS code into common files so that it can be used by an
> LWIP port of NFS.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  net/Makefile     |   1 +
>  net/nfs-common.c | 861 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  net/nfs-common.h | 123 ++++++++
>  net/nfs.c        | 848 +-----------------------------------------------------
>  net/nfs.h        |  59 ----
>  5 files changed, 998 insertions(+), 894 deletions(-)
> 
[...]

Acked-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

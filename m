Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7B5D4922D
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 14:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7348C83106;
	Fri, 12 Dec 2025 15:41:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rq104VCr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 182CA83837; Fri, 12 Dec 2025 15:41:45 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A6707828A2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 15:41:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4779ce2a624so14704895e9.2
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 06:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765550493; x=1766155293; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oW0uBlzo477/xYDTIDqNQXW8MjVe25bdSNkPl/moL/4=;
 b=rq104VCrdO7nF2W7haDJnJO8iA2IIYP6NvB5WvtiE8BfHZ+QJKMESsJu67hO6tHgMP
 smuW0viMATpxXzg5oklHSF8Vv7rSKx2tpzVAxMwU6grN5W25nhGVTEHm1rBum6OdXj68
 rcBLdD8AIqP0k65fM8I3eSv9MaMqlL7QXLpsSVvYGoUNjMC613fr7QlVNt2QaVD+yQrJ
 an6/n+rXeIItSX+oTVHNHiYeZu4pVA0LEEc2chamtlYZMZSB1JNPeJCBhq8o0ZztEkf1
 CEhsyjFcDVHobp/fWBjrdaP99tYF6z7B8zTTN6NDrVmBejH4OdpRr4BhIRB0fAav70B0
 bNuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765550493; x=1766155293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oW0uBlzo477/xYDTIDqNQXW8MjVe25bdSNkPl/moL/4=;
 b=WdzYxdMYrbzt5bszWZmLvaxnwYYFH2tM1hjj41jaaPvGJ4a5cOe2cU7MgDpEVsQ/TS
 6PrIq8D8WUVG4VVWVw15bxp0yoTNjKBuYCFNRz7xCnlmX4lnotuZ+q494sQKHXCOs/fj
 0YnUtjrbdYH0pHvGwwt/UB9lPxmngWaB/KEjtyKFd7frm/rAih8/s1S1OAOKHS7OaREk
 05bvCpCDqzyEO8cXLDJTOGGBC7qEmHVkr55vLrc0ckF/v5FWj76OXrTa4fYgOnGVkXqw
 3Ya9hS2DBMdoiLqbI3MCwyfmESbiSwMSNFHViKFsQ/+g1lPyLRjlgHMv98aAaTGXzyOR
 fE+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYrt//BzApXkq3jhtgLYtbT0Z8ptvskhpsSdd67dZwDzVxPjtPbAfDOW1QXnEQxkwF6SIp7K8=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8GnCVIPKX/oSs+8tcFu4j6jkr/oAuzWDmR0iwaCe1daPR9Lm2
 J+AvORRpNu4JJJOuOiJ/zVfLjzGZStV9iY4TJC+WgrRegqAcKqoFJ657uy/OgfzOKBs=
X-Gm-Gg: AY/fxX68e7g0mwT1oTo0QH8o/GiQAk5Lpb+RdZgABxFneimuxk96SOYaEEXmcD9hFr7
 50G4QSAA7oXFX9tyLPYgkzfZThL7mTwgShF3nXaEvhtZMcuzB02531xvCyQwQUDrDYoV/1X9pmU
 Vnehdv71gfvQEX04O9DApLESGIdYLW7wWHJ0nm/62UTgyFMoJS8Xn418D1bMJRGL0KrrkoGNaTA
 Nye+0RHx1+wrpKTwhFu3qjMaAiVWCoWmiiZuWfJX3JbXRGhODqDMYzPxw+e6sM2ZDXBpPmi/v8B
 IDPKowsx+LE8tW/HP88cLAAGxq7gxaCVggifEs7bmQbE/6IyZ/bTJU++8ny2K2uxkppyOJkd/pv
 AVFwq/oYbfd8jHoLsdguunLLz9co+JX+vM0VvVZ2qictXNz7VmGZ53wmce/kp+ZNE8Z4MtjGAJ3
 ZEsqDVK9ZR4WmR9rk0sKXc3TDDa29dFJPZTQGxKhqHXayJHutCrquPsb7yD0YZZ534LA==
X-Google-Smtp-Source: AGHT+IHh2BS2dqjc65r8Wa0HBBoyf6DlGyfxYhoSFm6Q4ZsUlNg3zcMT5qlkcpY+DISMbzH83gtU7A==
X-Received: by 2002:a05:600c:45cb:b0:475:e007:bae0 with SMTP id
 5b1f17b1804b1-47a8f8d2537mr31762375e9.16.1765550493043; 
 Fri, 12 Dec 2025 06:41:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9?
 ([2a01:e0a:3cb:7bb0:6677:431e:31d2:9da9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a8f8d9c6fsm35247075e9.11.2025.12.12.06.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 06:41:32 -0800 (PST)
Message-ID: <70c1ad02-f2d3-48a7-a0f4-4d5e936bec4b@linaro.org>
Date: Fri, 12 Dec 2025 15:41:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] net: move net_state to net-common
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
 Martyn Welch <martyn.welch@collabora.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>
References: <20251212-lwip_nfs-v2-0-9cb5a60520d8@linaro.org>
 <20251212-lwip_nfs-v2-1-9cb5a60520d8@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20251212-lwip_nfs-v2-1-9cb5a60520d8@linaro.org>
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

On 12/12/25 12:32, Andrew Goodbody wrote:
> Move the net_state variable into common code so that it can be used by
> either the legacy network code or lwIP. This is needed for porting
> across the NFS support code for use with lwIP.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  include/net-common.h | 17 +++++++++++++++++
>  include/net-legacy.h | 17 -----------------
>  net/net-common.c     |  3 +++
>  net/net.c            |  2 --
>  4 files changed, 20 insertions(+), 19 deletions(-)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome

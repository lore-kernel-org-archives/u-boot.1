Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0435BCD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 12:51:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 636E683FF5;
	Wed,  3 Jun 2026 14:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a5yQdMWD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 809C3846F1; Wed,  3 Jun 2026 14:51:10 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 847FB83EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 14:51:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so434320f8f.1
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 05:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780491066; x=1781095866; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Lw2EoyyaEqz9EHb+CPQpDSjGqPgqv1zLmvpLrZDWuUs=;
 b=a5yQdMWDU2mh5V/Dha/Rdb5FJhLLobOh763aqY4Bh4bxGcGaYGj/6lP6WVR5545Q3e
 ikc3ABduTto2NHL02QskIrmt0FaZpV3aBRKkPGWk5LTFQrMqAsoAX5WR6rVJ88MU5Z64
 mck55FpnsAbzTyP3r4bivHa3UtWC6olP1tyVEFxc0hu23V+/MenWaH6MqDPJk2vJZd6H
 6Ei9g8Jtp3TBLI8pHvDvv+77BhIsKr0VnrVLHkCSuhkK0ln5X+CdqcUWy6cae7ZuK0ip
 PApU7lIuL1o7YADDOoKQGzAlw3p9pamZnbVSlO0ykzzKbO6Hb4fR2rztlSTl4DAJn63s
 U1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780491066; x=1781095866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lw2EoyyaEqz9EHb+CPQpDSjGqPgqv1zLmvpLrZDWuUs=;
 b=B+6Bmwzyeg6QGtGwmEUhDyFsrfmGyaaZmVDodCr3E864dyQeWelf25jboreLvvQs7Z
 hNYeCicavtZB8pdUiqLSVo8MuUDRNHf6YTRyhzDiJ+5ypeWP6k80WEIJsRzLGHJuR9h/
 tlBVEPPTzg5dPbBhrlpeLxve3098iiH9rGC4qtR9IATHj4Ty6LyYcBeTvr4Gos5GIEQ3
 f6+8rQhR5qObiiq+O81k6vl2at/W+XT4qdcZ4+BMUXDRMkRC5Xi7KyKPGnStDfwOJT+1
 fYWPKCawGJvxO0mz9/34tKTogBaZ/ks+XfoVJtirHvpxDbwLJGhZbNuC2wPCOnUX2szo
 9zkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jeSR3Uhu32CzhAQUo31gn80TQWeJCmCjznYSa6B49gkPzDsGLlrALIFDC9/q04dJ1j65NYXI=@lists.denx.de
X-Gm-Message-State: AOJu0Yxu1dMVCFtwSrEl81mRmoV5Id59dOsqE6vzVsiCyWBEJs1HMs8k
 JjBlndZgwF78P0UtAprPExdTWxRoq0+/qTDlWFRVsCtG3ma8laeBly80LH32yK/I3Ss=
X-Gm-Gg: Acq92OEMCuZ+Jf+2+fD5ZOSEubxLGj/YG2FIxWHfXjNiilqjYZX3kDzAfzyYyc2z8j7
 wVUamio78zLBaeeY2bMaEwa7LXyER7A2OCP0uCS8ueyFo7nrkDWlm31nr2BcD3gZGaQ4lqfKUPk
 L41jOyrICd3QxEhwme7G11MP8ISLXV4JwJICmEXDMm+zS7dd79NQT6ov5QNJcmZCNYW9VvadfjX
 2pUOiJt/rqygWYwMUOUfNAsWoDEhY2uRpvmfWM21Xqfct/1nsQnTTvlOw/0ipjqqczjQ0t7Q1Rj
 0SV8dYUpYO+DzgxPSCSSws+KySDolwl1qugwiOlpTjDrpswjK2LmcEsmXLA75mhEA8EUCnuFNrE
 C7n6zRTKEtkfEbpFUvk7dMGqnw4nY09E37PGt2iscMo7hU2OM8pxC6j0zhyV88nG5Rg6ddj0anA
 EiKt/Lh7s8v1fwXDleZtzqCJMwHSK8Y8Ort5Qqi5JCTn32tZk6AlQh4Y8uIXgs43k8zKqCs89lt
 Xk+0Am5v4r+
X-Received: by 2002:a05:6000:288a:b0:45e:f7ae:d599 with SMTP id
 ffacd0b85a97d-4602132a5fcmr5123304f8f.25.1780491066615; 
 Wed, 03 Jun 2026 05:51:06 -0700 (PDT)
Received: from [172.18.178.88] (ip-185-104-138-128.ptr.icomera.net.
 [185.104.138.128]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcad5sm7845536f8f.5.2026.06.03.05.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 05:51:05 -0700 (PDT)
Message-ID: <5422b049-b65f-48bb-904a-b9302544c700@linaro.org>
Date: Wed, 3 Jun 2026 14:51:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fastboot abort key support
To: me@samcday.com, u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Heiko Schocher <hs@nabladev.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
References: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260602-fastboot-abort-keyed-v1-0-414aac5a06b8@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 6/2/26 10:45, Sam Day via B4 Relay wrote:
> UMS already offers CONFIG_CMD_UMS_ABORT_KEYED, which makes it possible
> to bail out of that mode by pressing any button, rather than only
> responding to ctrl-c. This is particularly useful for phones, where it's
> not possible (yet... hmmmmm...) to send a ctrl-c command with the
> available phone buttons.
> 
> This simple patch series introduces equivalent behaviour for fastboot,
> and enables it in the qcom-phone.config fragment where it's most useful.
> 
> Signed-off-by: Sam Day <me@samcday.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
> Sam Day (2):
>        cmd: fastboot: Add keyed abort option
>        board: qualcomm: phone: enable CMD_FASTBOOT_ABORT_KEYED
> 
>   board/qualcomm/qcom-phone.config | 1 +
>   board/qualcomm/qcom-phone.env    | 2 +-
>   cmd/Kconfig                      | 6 ++++++
>   cmd/fastboot.c                   | 9 ++++++++-
>   4 files changed, 16 insertions(+), 2 deletions(-)
> ---
> base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
> change-id: 20260602-fastboot-abort-keyed-1064ecc677de
> 
> Best regards,


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A4AC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 12:26:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0654688997;
	Tue, 13 Aug 2024 14:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YKr026cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 030EF8899B; Tue, 13 Aug 2024 14:26:41 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E076D88986
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 14:26:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-369cb9f086aso3219570f8f.0
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 05:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1723551998; x=1724156798;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZDAzsdyE3J4Ph9y3b9oHSA18Ruh0NS0WTEGqcFCbMpM=;
 b=YKr026cj4+gF9ZT46U/DgE/POtVTkACgR0vR4SiXlTmesP7rqRDCMyZuyDVlDL0cGn
 XxWXX0PUxt6solWEeSvW1u66EyB+HOlpEEjauUEKybuxuyTCA7uihF8h6NIetrUeRt9F
 3WYPhJE6K/CuYKa6dHcLvG3fi7iiec1vR5T3DOhtBxMY1iQSH9NnQ4W1MUW5+CDxqVVh
 RYPODMPcWCKHQwJAORC+JldO7LLrR/JgiTSHBOViRdxyu9GxnCb9ljQWM2z7dBC7UA1z
 bQMV5HaRU8Y4UPDf+ZYv6ksHn9u7nPcE9skIKovMsY1y9HvMzsuMzoR27XKUyYe8Yg76
 d9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723551998; x=1724156798;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZDAzsdyE3J4Ph9y3b9oHSA18Ruh0NS0WTEGqcFCbMpM=;
 b=Eit7u+57ymoK8B9yFQRHhI7YFXe79fm0IMiK4LgVYhX/Hw6TRogzvYV7y2Qa5KGq/G
 86+ROkKoKvpcsRghbjJaoivvUkLcnyMJhL3+MIL4Xm2V7yPnsXLDhjdKFuHf75M7OUVw
 icBArVgz0cA5WnPVQt1SUb1oj85U9gt89EENYowSMZtBgnBnSopzxm1LtWgV1qVc03zW
 pWn7G3Rnj5P4jz+cpXwtib6cTNmUkVZ350UtoB7guWqmmdLOQ4G1R9+SL7E2BKsbMh53
 H3/m0TDU8vZIzba/F9PLmjRNccx4BH4G9vkInekWiT1+n2ty4tigQV8woQ4g9qvJYVO3
 nczQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5uLtmTefzBqY2q7h9uq5gzO3WhSZSX046dfCQswnMVmxJYlOg3cvEHh0RsO+sZCZXFk3JZIxHyKHoaBleGPsqyKE48Q==
X-Gm-Message-State: AOJu0YwqdeVfW1dqFGjIzOfyQp/OQjfT40FDs+wngeTcwrnWatdUNpJd
 esSCblFqc3q2zVmBAJnbpIAApScKFGTTc6JOkcRXbIH6bB5ovC6GhI0Zqa/65Z8=
X-Google-Smtp-Source: AGHT+IG6t9rbWvpfjYfmgDm+2m+57QyiqGbI4q7LZzRgy6YUYLcDePIIivlmGt971Tj78zwbzA+scw==
X-Received: by 2002:adf:a31e:0:b0:368:3b21:6643 with SMTP id
 ffacd0b85a97d-3716cd2e824mr2054087f8f.48.1723551997732; 
 Tue, 13 Aug 2024 05:26:37 -0700 (PDT)
Received: from localhost (lfbn-tou-1-402-59.w86-206.abo.wanadoo.fr.
 [86.206.229.59]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm10183736f8f.115.2024.08.13.05.26.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 05:26:37 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Prusov <ivprusov@salutedevices.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Stefan Bosch
 <stefan_b@posteo.net>, Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Eugen Hristev
 <eugen.hristev@collabora.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] usb: dwc3: support USB 3.1 controllers
In-Reply-To: <eb12b7f6-dba1-42ac-adb6-3c180d811130@denx.de>
References: <20240423141551.2410199-1-caleb.connolly@linaro.org>
 <eb12b7f6-dba1-42ac-adb6-3c180d811130@denx.de>
Date: Tue, 13 Aug 2024 14:26:34 +0200
Message-ID: <87ed6ssj5x.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On dim., ao=C3=BBt 11, 2024 at 19:37, Marek Vasut <marex@denx.de> wrote:

> On 4/23/24 4:15 PM, Caleb Connolly wrote:
>> The revision is different for these, add the additional check as in
>> xhci-dwc3 core_init code.
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>
> Thanks !

Marek, should I pick this up through u-boot-dfu or will you pick it up?

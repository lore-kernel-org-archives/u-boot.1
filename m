Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC42C4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 13:55:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA67E87AD7;
	Tue, 31 Oct 2023 14:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p9q7OlJw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDBA287CBC; Tue, 31 Oct 2023 14:55:27 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07B7B87B1E
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 14:55:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40839807e82so34045495e9.0
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1698760522; x=1699365322;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X9jZDa5ea2u7EDdlIVWnwa8vhfg6LaqkysbHhycsDYA=;
 b=p9q7OlJwfI0xbxF2U2RFYIQSLWBXu9bGJOWdzV9KtI04PWEdFydk/k28wB8kKfBaXs
 hIXgMm84QUBFHxu2+aNzct0bCpSlRPCTw5vUqjhuB9nw9lXP4pFAEds8PUFeJZqVEktZ
 HOO9NfWOaOCswGQ1pBzTZw7OzVknhJVrcpOsrAqFHTm2PRFe0mEURME9tmu9zHLyxkiz
 l0gGqqxoTwbAs3FeyZfrWRpofdGELqKTCvZsP0rBTXhXI5gCTt+NC+bq8UxvwUvSf4o4
 QDJULOBtmkyFRLiSLSgCez79ZtWsWT7GRWCbI2rPDk3BTKpmGH+KhIii0jGwr6y2YNV4
 ItGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698760522; x=1699365322;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9jZDa5ea2u7EDdlIVWnwa8vhfg6LaqkysbHhycsDYA=;
 b=dR1Cz457jvqeECnNwG8mQKOiGzx2HHOmXDC3AF/EG30iEFY7j9wOXZM4CkqM60Rt2C
 JVHKBD7x0z/BgKrUtcowG7hfTuJredRBPMrIFA8hWQTEkzDz+0E32xOvGT9XUbql0cIH
 PsrEfr8NR1z1sriGsx+KlXRSusYpqEka1YsGfGx0aDSONye0Hji95o9FPN7oTs9lzPvV
 WjpVLteyda9AdGZMtqcVL17VG5h86lKFXEuON5gRKCpH1wnRAHrUJf7EC8nuX4+1enUG
 KTFu28CYgfu/k4DncmdN/SgEQqH/A2GtJdt9eWz5OBzQZ0rdn/s9CmSD5AwKPLomAgkD
 JxZw==
X-Gm-Message-State: AOJu0YxmCnwemQ4cwMbXjiYriGRDfN0TEEq1zx3kv2lx3+NwOs0jwgBx
 JHbUSoJHV1TMYGn2T2g3F8luQ1u9dqcxpASDXZ8=
X-Google-Smtp-Source: AGHT+IEgZDIV78vr+kaQjJlOt4Bjh0w5FrN1k8yQSqoz+Flj0eML5nxme0PCnXZpnnQitvcbdc4ErQ==
X-Received: by 2002:a05:600c:3c91:b0:407:4126:f71c with SMTP id
 bg17-20020a05600c3c9100b004074126f71cmr2916272wmb.6.1698760521247; 
 Tue, 31 Oct 2023 06:55:21 -0700 (PDT)
Received: from [192.168.2.51] ([82.66.159.240])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a05600c511000b0040531f5c51asm1883683wms.5.2023.10.31.06.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 06:55:20 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>
In-Reply-To: <20231029223740.284149-1-marex@denx.de>
References: <20231029223740.284149-1-marex@denx.de>
Subject: Re: [PATCH] dfu: mmc: Add support for exposing whole mmc device
Message-Id: <169876052059.31394.10147642118410622044.b4-ty@baylibre.com>
Date: Tue, 31 Oct 2023 14:55:20 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4-dev-6aa5d
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

Hi,

On Sun, 29 Oct 2023 23:37:22 +0100, Marek Vasut wrote:
> Add support for exposing the whole mmc device by setting the 'size'
> parameter to 0. This can be useful in case it is not clear what the
> total device size is up front. Update the documentation accordingly.
> 
> 

Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu)

[1/1] dfu: mmc: Add support for exposing whole mmc device
      https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/60d904a494c6e89c323bc13fa9348869e07e86d3

-- 
Mattijs

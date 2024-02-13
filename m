Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF88C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 13:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AFCA87D72;
	Tue, 13 Feb 2024 14:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yXt1WI/f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99EC887D72; Tue, 13 Feb 2024 14:30:38 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C301887D64
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:30:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-337cc8e72f5so3091910f8f.1
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 05:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1707831034; x=1708435834;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VfwtiVFwgnRIlaEJWJ6NdexqYI5hxkeLBPXSHNcA/iE=;
 b=yXt1WI/fcUSjYZ/Pbgrbte46yIhXKVM7Q73kim8wSPONE+rF67cAU1vHnRygUmjH7i
 idZlUVgLdfYBJUrsf8MAkmF2h6lzSQD7mqjuUKQ38tQfOn1Hcb14jCt9cHxXp4Y3NLNw
 HE6B8wRQrYEZ3VF7sN7jEDsm8fLbP1sfjFbCsgcWQfduEKfqMmSAwmtxAVW0onbA29oq
 lI4nxBGRULQTY3MYbeNUcSFp94d1CGrExVMVv2ro48rmnSE4htjKzdLgO7Djr2IcU3y9
 HiaN87NM9OnIiExHNk+suCymb1u+hkJB5OYW7Zo1Op/n0KuoKWJekmpHBekY7Mtz9go1
 F+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707831034; x=1708435834;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfwtiVFwgnRIlaEJWJ6NdexqYI5hxkeLBPXSHNcA/iE=;
 b=FgFHMb4gZqUEpzvKazyyudPEpW2RmWTQsNB0GWkOHP2TmsfuzBW7vmWBGXqLXOwc+Q
 ebZIqb7du8UYZB5PIpN3BjuqZ7RyiFitA3URXjv0BykLIUI7yFRQWC1+3edvFl2HaMIB
 ytC48MXMJfgPUmKowSHRW3+Z+9lEtsZlWhsfhyh0D/ddMlIXF+01Yg6C3DojbsSNPooJ
 md/UY2vnxmKG0/FefOHgFaauP6kxrU047zOAsxvJ4Da9K+hhNgxce9NIqiZMXioxjckQ
 4gsQb6F6uMTvVsJ20J5cLDSKmKudr1KerR3X1M1rmNDH9Xx/QUcL7rB8Zu53GUB8Y2zZ
 GdOQ==
X-Gm-Message-State: AOJu0YxBPO3cdDAOToIjvO9mM3oA3jBlYVJNOPObS+4syI0V656T0dNQ
 0kk6E5UAoSKzJBBuijNT0e5EWH6mwkrMOmPqngH4ZTrP82rhAX3QBlcxd9btubQ=
X-Google-Smtp-Source: AGHT+IFIZYS6lIEjjnGHEcueVtt4hCVJdbe2T9ljeVoT2AdBXutjw/NnT4W5OnjB9FU3yLkgtpckNw==
X-Received: by 2002:a5d:514f:0:b0:33b:4b0f:b989 with SMTP id
 u15-20020a5d514f000000b0033b4b0fb989mr5984482wrt.0.1707831033759; 
 Tue, 13 Feb 2024 05:30:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWzRgWWEXQxOcwBA08RXnaKDeVnFTgK8p1xA6CxA9Vm3hiBgQUI2fhockhzCDvmi2N8r5wo/SoysvFTQ488Y+iCFMXSpWPlH2EPjh44a3BJiXXhGO20bxGLqe6Rh6tc7Q9ZoDjcMTK7a22iLgsZY8qHjx5vm/bIncfecaBLbnYMSgCw/L42c7UnnwHjyIUUFOUEw+XcZgX0FOZsFwInGOaL5CdLq82WBD89XQ75cEqRJbzJuj5M7Wp8048wpLL8mZFiR4r7PI3q0D6zaQXvyhHCRWEwOuEX/lk5SCR9zzV+L9aOWdor1TgAPxxcqPxvBlqBXk+uJl2NqasbGq/zQZgFR1TZMzcHuE5jCeA5jv+SfHsIa5munyxcStsEeNKLcUr1Zw==
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 bs25-20020a056000071900b0033b406bc689sm9634655wrb.75.2024.02.13.05.30.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 05:30:33 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Marek Vasut <marex@denx.de>, Igor Opaniuk <igor.opaniuk@foundries.io>,
 u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, Abdellatif El Khlifi
 <abdellatif.elkhlifi@arm.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Kever Yang <kever.yang@rock-chips.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1] MAINTAINERS: add custodian tree info for AV/AVB
In-Reply-To: <33577a00-d58a-4caa-ae87-30d70aab28a9@denx.de>
References: <20240213073256.1124630-1-igor.opaniuk@foundries.io>
 <33577a00-d58a-4caa-ae87-30d70aab28a9@denx.de>
Date: Tue, 13 Feb 2024 14:30:32 +0100
Message-ID: <8734twfq4n.fsf@baylibre.com>
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

Hi Marek,

Thank you for your review.

On mar., f=C3=A9vr. 13, 2024 at 12:55, Marek Vasut <marex@denx.de> wrote:

> On 2/13/24 08:32, Igor Opaniuk wrote:
>> From: Igor Opaniuk <igor.opaniuk@gmail.com>
>>=20
>> Add information about a custodian tree [1] for AVB/AB, which is
>> maintained by Mattijs Korpershoek.
>>=20
>> [1] https://source.denx.de/u-boot/custodians/u-boot-dfu
>> Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
>
> Reviewed-by: Marek Vasut <marex@denx.de>

As this patch has a typo in the title (AV->AB), I will instead apply your R=
-b to:
https://lore.kernel.org/r/all/20240213073638.1125429-1-igor.opaniuk@foundri=
es.io/

Thanks!
Mattijs



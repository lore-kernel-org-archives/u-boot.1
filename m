Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F638C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 08:04:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D55887CA;
	Thu, 25 Jul 2024 10:04:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JtAaQ62C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7BAF8866EE; Thu, 25 Jul 2024 10:04:39 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2E88889EF
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 10:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3685a5e7d3cso364524f8f.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721894675; x=1722499475;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=q4EYqNFyVVep5gDo7EsHKzVQNHBdsA07HYwhb0bXDhw=;
 b=JtAaQ62CWJ0X144k3X531fOmMyFIAzlSzOdudfdbLTqb0E0/vsUrHwXrbccEnbColx
 Tad3UE0TRkL04ER89UZquyoUvEH/+3s+7lELIHTnJmwAbyc0qhAe5M4BZKmQ1pPFliHB
 QmOaWc5FBgouMkHW7h//4uyAYmupJYgFMkeRaRKdGW+8km2M2171Wuyv7gA8qd96SM+P
 g8GRcik/PIN73l6DtQHlL8KtuuW/A3QtyDL1LbvjmchLnwykAdFJdPlhTjLFf+on7TtK
 IwwHColhOSuSTHbl1RgISkC4dEHfbwR+nu1lFVIuLsxUHrl45Glsa+KrFDL8tj8MNjTz
 fF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721894675; x=1722499475;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q4EYqNFyVVep5gDo7EsHKzVQNHBdsA07HYwhb0bXDhw=;
 b=o8K2UEkM/3cfPRSxaZtMdb5+96tVRPAlVZqtDHz5jV4IgiAEDSBuxWGEQL8OnsKmlL
 rpfrnrFj44VzgbtidIFIq3TLsFHru01o9e+z7PfEIdClZrCMW87QNF/LTKf5QvBgBcbT
 5mHCIcEHZsqJzaJ6ynYga2wGCD4MTAgBLLogfpixPW1FKjFLAXQ5oOhCY0gIg8Xb8zLV
 UntYNoqSiUEKvPPKaeiharucyUixen55eNdk0wpWnElMh6BsU/cWfm9eAiLv0dDKhGgV
 W78GrQOsHs79tu2rfzkKUm6gwfrcPZz1G5YIRDt3c7eGGX8RN0H3EsytXj/cIxKm3XKu
 yd4g==
X-Gm-Message-State: AOJu0YypR0r+QhM57bCsKtE6or9q1Zxr0Yz4m/T/kDum7WWk8wHbO7It
 aKRRjWIZS0aT+N4kQB+Iy3tLaOaLbSgLMC1Fx3MqPRjrPvc4XjIW3vOtwVYgj6Y=
X-Google-Smtp-Source: AGHT+IHp1/LaCrzLfj7TsH3sYtf9v0F54LanMjWevRAlTGLLAvkfjLxO3Qyv4sL9VvOMShWvYBsxxQ==
X-Received: by 2002:a5d:534b:0:b0:367:89fd:1e06 with SMTP id
 ffacd0b85a97d-36b31b08411mr1373177f8f.36.1721894674738; 
 Thu, 25 Jul 2024 01:04:34 -0700 (PDT)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367fc3d0sm1256389f8f.56.2024.07.25.01.04.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:04:34 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Dmitrii Merkurev
 <dimorinny@google.com>
Subject: Re: Fwd: New Defects reported by Coverity Scan for Das U-Boot
In-Reply-To: <20240724224027.GP989285@bill-the-cat>
References: <20240723141844.GF989285@bill-the-cat>
 <87ttgf5emw.fsf@baylibre.com>
 <5329b5b4-b54d-4c4d-aedc-c21c3da5f9ee@gmx.de>
 <87o76n5d1a.fsf@baylibre.com>
 <A6FA1C43-24E9-4738-9AE0-E0E67E71CA65@gmx.de>
 <20240724224027.GP989285@bill-the-cat>
Date: Thu, 25 Jul 2024 10:04:33 +0200
Message-ID: <87ikwt523y.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On mer., juil. 24, 2024 at 16:40, Tom Rini <trini@konsulko.com> wrote:

[...]

>> >
>> >Ok, so does that mean that you agree that this code is safe and we don't
>> >need any further action to fix it?
>> 
>> No fix needed.
>> 
>> Tom just needs to nark it in Coverity as "intended".
>
> Thanks. I'll copy/paste the explanation in and close it next time I'm
> over there.

I've done it already, added a lore link to this thread as justification.

>
> -- 
> Tom

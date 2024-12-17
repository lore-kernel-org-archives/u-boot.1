Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5677AE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 23:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C107F80214;
	Wed, 18 Dec 2024 00:44:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iadD4iBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1D08021A; Wed, 18 Dec 2024 00:44:48 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AFE4801FB
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 00:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so3379129a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 15:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734479086; x=1735083886; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M+anL2Wn6LJVlVIW4MGeykABILVfSiy/1h+qHZ2h2TI=;
 b=iadD4iBoaEgf476fG4dMeusy0sBQLRFzCknaUEXApZLpR0nSj4G/VzVLlYe1Ttlnje
 dIxt3jAFvSdFX1qq1Y6wZDh+7OTEtbC3OecqCGog/rM/Hjg8gfIh6ftK5a3lmW2jdfyw
 kI5fVSrlWA+Z9cuOW7A+QHDTC1lqlSv5rUcl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734479086; x=1735083886;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M+anL2Wn6LJVlVIW4MGeykABILVfSiy/1h+qHZ2h2TI=;
 b=GbTluYyxj+B7pRpTUBpe1UX976GrN4e9aC34YI7fQ3MfE/oda04+ecu1jsYuDDJWgn
 dojNnKi9Bz8Q74K85lb5edlzix97wqSgpJ2JFThyVOzYoZxB2rg/UKRWXPio0OGJb9rL
 yHGA6hIcGakCfcVZL0mlHMgv/VarzYbIs8/aQhm+zZ9cg68yB23UTnp26ZuYZr8RIPOt
 AHtmlcJs5kozMif/8XaXg/0jijAF62PQs9Kjp0oWu4eSfxE+CkoV/3L+MOEaw5ZujvwN
 xxJxCN7F0eTVD/ZFf55yWnPIbQTwr2LJGZ8KXJ1fkRiYmGb4RYoRCeh+WDJWGcy3k6so
 Ffag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVshumwSSDxpgqd8FmH0/Y2JVD7teUF2dGY8U1cEvJGQWu2M01FqTV5ynkJ4lyfmlfS/WdcapM=@lists.denx.de
X-Gm-Message-State: AOJu0YxCVJqdXu3qC2y2GQtH1C4YIV9ZUXF/zn5KPEfVCgs9j/bSnbs4
 YOKBL6nbjxGeDQyaKm1ly8ktIq6QLipiU/HVNhxAnyjDjRkTzBKHaxU4J9GIMZTO/cdShwHWivJ
 VPX3JJuelt3SkUtSsFlBOHlu21BBPEswIW4nh
X-Gm-Gg: ASbGncvVFIkqPwgDZg4QsM3GEifmvzuCYzc1ppGlNdw5KjWv19fp/Dcn5NnMybPpo7p
 LnAStcsT9ZTzFGyE+3UqddUfzicTdcCoaQXLovHI=
X-Google-Smtp-Source: AGHT+IGiG01uLq80023mc1JEEzc2kIB+P7OYAeqKmnUOzZGpaEW9Gepm4dmTcRLDxnOAifBbbuBB6iZBRht+OFWHaGQ=
X-Received: by 2002:a17:907:7717:b0:aa6:8fa5:f3e3 with SMTP id
 a640c23a62f3a-aabf46fafa6mr42825966b.8.1734479085667; Tue, 17 Dec 2024
 15:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20241211004503.3775922-2-sjg@chromium.org>
 <20241211004503.3775922-1-sjg@chromium.org>
 <CAFLszTjHyhwf0dV8THPDswXz58jRCW+ZX90Hr4_i7PjXsVHPBA@mail.gmail.com>
 <20241217142527.GL1505244@bill-the-cat>
 <CAFLszTg93ddp3r2Bmv+p-wKRBDxVYqz2mQ56etGqSWCGUjo6Jw@mail.gmail.com>
 <20241217195734.GR1505244@bill-the-cat>
 <CAFLszTidPRWQCeQ+fsyn_P420eK6obqtYu7=pHtxDHhxumVoLg@mail.gmail.com>
 <20241217202900.GT1505244@bill-the-cat>
In-Reply-To: <20241217202900.GT1505244@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 17 Dec 2024 16:44:34 -0700
Message-ID: <CAFLszTiaWSAVc4_zDvPfLO2srSMqko9BzauxHAs5x3MPvY6Rjw@mail.gmail.com>
Subject: Re: [PATCH 1/3] efi: Correct logic for OF_EMBED and OF_SEPARATE
 co-existing
To: Tom Rini <trini@konsulko.com>
Cc: Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>, 
 Matthew Garrett <mgarrett@aurora.tech>, Raymond Mao <raymond.mao@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <CFSworks@gmail.com>, 
 Sumit Garg <sumit.garg@linaro.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi Tom,

[snip]

I'm very happy with your leadership. The project is extremely lucky to
have you doing what you do and we all know it.

In my own way I will be able to contribute to the project more
effectively than I have done for the last year or two. So let's focus
on working together within the constraints that we each have. I'm
pretty sure that in a year you will be happy with the result.

No, I have not been paid for U-Boot work for more than 10 years and I
doubt that will change anytime soon. A little empathy on your part
could go a long way.

Regards,
SImon

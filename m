Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C13C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 13:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40B3B80ADF;
	Tue, 18 Feb 2025 14:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G9+rWYdC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EFB9809A4; Tue, 18 Feb 2025 14:30:19 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F3AF80BAE
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 14:30:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abba1b74586so301246966b.2
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 05:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739885417; x=1740490217; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U3iV0ZAZrs12L7RYcEwfWs1UWrwIJm/HyuduL59pOew=;
 b=G9+rWYdCYJ+kNiNc957juVgbs6M2CAUgV/60Thu+tfZSYxqiSPdrFveOq8NlPeycyx
 ZAfz6YV981AC0x+WiDrokQ/mRWXFyFmasWkic4HRBrfmJ0WyWLogeuudgL74mjnYgcqb
 +FXIjiGUSmwrJ0if7kBn4lA1QJCOYN8HYO2Rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739885417; x=1740490217;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U3iV0ZAZrs12L7RYcEwfWs1UWrwIJm/HyuduL59pOew=;
 b=uMCm8F/QrgHyALPNtca2f1En366GBxktp2mF3GAMOvZagbFBgxuzYN9NafIcOtmAzJ
 J+6zz1AYSMVKLhtpSRIg0LJR7UkfvggyrvxkjBKRrx1vQWUKH7J30ujy5qGJLWXKb7wm
 1HYSx6EWX8Q650m5DeJq9U8nwZpFXd4t8sEut3N/D5VRbeimg8CkZCUjbaHXF2UaORQI
 2hwklXoQb8445uByD9XiLcgbiYp23M9etAh6R/QBtqhUZ3O8eoN9Ow11LJumJChxTtVx
 qqt6RCdEiEX/iRDDQ2SJ5N91wMhuo1PtzuNvVG5Ov/W7FB7a1iG2b7UBFZZpHaSRh0CR
 SPcQ==
X-Gm-Message-State: AOJu0YzHIZ3AiuwhYCYbS6nS6UoHOJiFS3DdQ4H8oyj89OZspTskOT4O
 9vdXEkK4+EAOo55wovCi6NvcIxhurRR8pTXF4egvHKjkdP9AACcBpuR0EC339L06sNP2R6iprv3
 MmB+dAU4/Sjwe+EBRmK+juk9T7mJWhWICwdOT
X-Gm-Gg: ASbGncvlaqM38CgDvHDoT3B6kxwdcwJeG+un79/X3btUFak/siqL/KEKtdhcf53DvFJ
 5ZofVJb9XyERIAtN5+cgQx2SC6L+VvMlK27yb1Hh9WjDtMStrILV7ZjLCwl9aKfwKu/bvTnRKLw
 ==
X-Google-Smtp-Source: AGHT+IEQrE8Rbv+f2rnO0+ldVjV/YH7V0x/Y34iP6O8OF47nzfh3Gu8cs03Ip1pEgEgukU3Co5VEg0Bwx4ktn6Nwenc=
X-Received: by 2002:a17:907:d9e:b0:ab3:2b85:5d5 with SMTP id
 a640c23a62f3a-abb70df3417mr1508153266b.49.1739885416834; Tue, 18 Feb 2025
 05:30:16 -0800 (PST)
MIME-Version: 1.0
References: <20250218025705.50051-1-dinesh.maniyam@intel.com>
 <20250218025705.50051-10-dinesh.maniyam@intel.com>
In-Reply-To: <20250218025705.50051-10-dinesh.maniyam@intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Feb 2025 06:29:21 -0700
X-Gm-Features: AWEUYZkW7pgYymhFkiluzeJFWw2A88IZ6-qWVkvJExKKbolCvQ1FQIgOoxO99VM
Message-ID: <CAFLszThc6uiqNwYdrAgHEZ0gZyd8J-+xJJf0WCo-nrGw7VD9Rw@mail.gmail.com>
Subject: Re: [PATCH 09/10] cmd: Add i3c command support.
To: dinesh.maniyam@intel.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>, 
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Wang Jie <dave.wang@rock-chips.com>, Tingting Meng <tingting.meng@intel.com>, 
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Jit Loon Lim <jit.loon.lim@intel.com>, Sieu Mun Tang <sieu.mun.tang@intel.com>
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

Hi Dinesh,

On Mon, 17 Feb 2025 at 19:58, <dinesh.maniyam@intel.com> wrote:
>
> From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>
> Add i3c command file to support select, get i3c device
> target list, read and write operation.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
> ---
>  cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
>  drivers/i3c/master/dw-i3c-master.c |  35 +++++-
>  include/dw-i3c.h                   |   2 +
>  include/i3c.h                      |   4 +
>  4 files changed, 233 insertions(+), 1 deletion(-)
>  create mode 100644 cmd/i3c.c

Please can you add doc/usage/cmd in this patch?

Ideally there should be a simple test of the command too, like
test/dm/acpi.c or the things in test/cmd/

Regards,
SImon

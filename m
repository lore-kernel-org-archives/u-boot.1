Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E34D5806E
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 12:07:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 578F089A38;
	Mon, 25 Nov 2024 13:07:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oaCh7RiW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88F3789A3C; Mon, 25 Nov 2024 13:07:03 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B16D8906C
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 13:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4349cc45219so12058965e9.3
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 04:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732536419; x=1733141219;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=hLhU2KiGUOvvWpupFvS6VRkI1WD8foXri87SjJGbUjE=;
 b=oaCh7RiWANsrbkYLFn4vg+1GtR5ThdldhMFvmqoLuclViE1nw+vsoXjP9dCCePglt6
 ovSJ5dE2ET66jgH+xJMr6yZFne9128q5wsbeQG2PZZP1GWnTN+Bj67Yk9dkyVjlrPfQj
 NRJULXcuyFL8anfnvkcOQf06jMbzD+qGpvw5n8LQkOCR2I0v4J7UkTtTSl+zShcIFrIb
 VFRQWNUqF1EPBx80HQMDQtYTu8+eHyGivTPU/nmOp6rg7pi74SNUvtEnXvlj9tv3fX4R
 ZJLoV+lAtqVwhq3NMgixSHtfplCqzTen19TWxu8rBeWe/MBEEEL01syNYs7RvZ0g3cU5
 e64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732536419; x=1733141219;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLhU2KiGUOvvWpupFvS6VRkI1WD8foXri87SjJGbUjE=;
 b=ewJABB/InJXnZaHpydxE6AebDdajsn6GBl3h0Nn8AMqfg72MW4ny9CBMMo6WnZxwlP
 wOKVvdbVSe2Lmsjj6/ijxw4QbZ4bO1FUfUclPAjzqGXL0RFgjTobCYR+Kc6Koujtt7QR
 ZR9CiMxZB2XW/ki4oN/PLmgI8alQuBbajKi8jOpZfHNVzjky9M6TelvzFySkg/ylTFgW
 02c9WgwJdjF9AXITBlEdfI+GW/yCdZlikF7fhsbBvEYm9Cgzg/S932vILqHhvKJS95nX
 9KEgwLk+LBGApVMWPEg4/zAQYRlVEpptF57g6uh4Q7zwLXu2X7B7mdhxvLlUUCs4VD/F
 7y2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbwm+RBeYEuaQUXjKvGmqxingUF5mqi3k2EX5JV6rzpupjL8W0xitClUPuzaROkzL0RUy/kY0=@lists.denx.de
X-Gm-Message-State: AOJu0YwBKephKG106pWDLdhARrb3tD1XwwzATdkrP6jDAin23pZgvdtE
 5pvryJEA3hi03S0saHyXuWqR+dxABBZ+KpNz9PkRXC2X5jopHf/uLH4QHYGFRlk=
X-Gm-Gg: ASbGnctfjvHfa+3d4Ef9s8Uz3AghCZehDk/kzeSuev5j2z/CtIMwNPWR7hDXW2tQIS6
 ipR0qwwm/jzviebUz0fuLZhzfUxnR6w6g6KwAmobesbvfPJAIDmTMKUDn/GysGquJQPE9Kd9kED
 ZddnvJLvvL2lt2D0gfWXJRSsrD6rG51bIGpOf4Wv5ZsPvVpcTY1dRg5wa4xFZmRIxPT6CTDfJnn
 CMdn2Bmd1H3VrgW1MaQ+HHN7OCmtn207K+mO6M27b6iC/HyLBrtpN/VVb8=
X-Google-Smtp-Source: AGHT+IEZuJ+TgmE/DtvhAjyA52WsX860lJhabZYV2pyVwkKh273h0/TZB4pOpqu0Pcn/3ghWxC4Mxw==
X-Received: by 2002:a05:600c:19d0:b0:431:44f6:566f with SMTP id
 5b1f17b1804b1-433ce41ce2cmr118774455e9.13.1732536418835; 
 Mon, 25 Nov 2024 04:06:58 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434a0876a41sm24159955e9.11.2024.11.25.04.06.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 04:06:58 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: u-boot-amlogic@groups.io, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Guillaume La Roque <glaroque@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io
Subject: Re: [PATCH v3 0/5] Add support of Android Boot Image version 2 and
 non-AB image
In-Reply-To: <1809644DD9DF8FC7.18574@groups.io>
References: <20241119-adnroidv2-v3-0-45baa486fb31@baylibre.com>
 <1809644DD9DF8FC7.18574@groups.io>
Date: Mon, 25 Nov 2024 13:06:57 +0100
Message-ID: <87serfbjq6.fsf@baylibre.com>
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

Hello,

On mar., nov. 19, 2024 at 15:16, "Mattijs Korpershoek via groups.io" <mkorpershoek=baylibre.com@groups.io> wrote:

> Hi,
>
> On Tue, 19 Nov 2024 12:37:37 +0100, Guillaume La Roque wrote:
>> Actually bootmethod android only support android boot image version 4
>> and with AB image, some old platform wtill use android boot image
>> version 2 with AB or without AB slot.
>> 
>> This patchset add support of both version 2 and non-AB slot images.
>> It's fixed in same time a boot issue seen on khadas vim3{l} board with 16GB eMMC
>> 
>> [...]
>
> Thanks, Applied to https://source.denx.de/u-boot/custodians/u-boot-dfu (u-boot-dfu-next)
>
> [1/5] bootstd: android: add support of bootimage v2
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/dbe7eee992e90bbe84278db20d29159e3eedfe0d
> [2/5] bootstd: android: add non-A/B image support
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/a85f2e0e7bd3665366ca2704d1142d3f16f22c36
> [3/5] configs: khadas-vim3l_android{_ab}: move on bootmeth android
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/88547773b2df5e4cabbaec57a0f2e7f212dbf823
> [4/5] configs: khadas-vim3_android{_ab}: move on bootmeth android
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/4a2e58717f2f33ef0dbb422026ef71938f2265aa
> [5/5] bootstd: Add test for Android boot image v2
>       https://source.denx.de/u-boot/custodians/u-boot-dfu/-/commit/acaa7f35a33146f887948d34130229388280844a

Due to the test regressions discussed in this thread, I'm dropping this
series from the u-boot-dfu tree.

Please submit a v4 targetting next once [1] lands in next.

Thanks,
Mattijs

[1] https://lore.kernel.org/r/all/20241123024300.GY3600562@bill-the-cat/

>
> --
> Mattijs
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Groups.io Links: You receive all messages sent to this group.
> View/Reply Online (#2573): https://groups.io/g/u-boot-amlogic/message/2573
> Mute This Topic: https://groups.io/mt/109662676/1991006
> Group Owner: u-boot-amlogic+owner@groups.io
> Unsubscribe: https://groups.io/g/u-boot-amlogic/unsub [mkorpershoek@baylibre.com]
> -=-=-=-=-=-=-=-=-=-=-=-

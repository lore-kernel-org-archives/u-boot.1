Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13ECD30016
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 14:59:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF3A892B4;
	Fri, 18 Oct 2024 16:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L1kgkBup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D098923A; Fri, 18 Oct 2024 16:59:14 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DA7C89301
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 16:57:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6cbe9914487so13522726d6.1
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729263447; x=1729868247; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hEbLvGNbL50pvl4Wx4CuWbuW7OUaVHhan+3K3f/8qxA=;
 b=L1kgkBupy6EtX6k71WOE9SRPtSHQXsy6KUfzEd5NyYYr9hXLMe0f3txbAvNRbAMURz
 u14aE1OcBDwc+aTWSA2c+uVNitSd1zGl8lxTxWuvrtRZooTqAUrsbQxLgJjrRTzVRl8q
 joxUKJLvP0r7qDSqdJaYq/UHh5bcpn7ZLPCF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729263447; x=1729868247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hEbLvGNbL50pvl4Wx4CuWbuW7OUaVHhan+3K3f/8qxA=;
 b=dvrxUYd5+Kv8+wRlAoNa/jO6VWPxW4eNoIHcbg3mjDyFLo2QS6j/70ONA/Di2NwYEC
 qCtXJlIbzJwbLGTDI9hYYsGvFmRh9adWsAsUbLj7WqtVrPtu6ntHWdCu9GiLu9wsx+6D
 QLcujyF8fD9+DHlaRkP46VV57/iXrHf/fqhQCiLsxhZXnJEVWewwol9BZjkhGn2Xd1oA
 6IacxnARufTm9DQQSeFUoET0gvKYiBhWnp4bEwKy7DJ83e9pa3OCv8JTGXKdPTrDsl6U
 xzpNF90fmio4+X4j5/4+pAgw4icYeQE2J/27ARh38yK+avkoADdYbdL6FD2UhyrQmn3M
 +1ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRzE8nFsBWGtqtv4ifK8X+nyRmCu4pAXQRpnGcSlT4f8pl2YZeVhzLZkyZhgVRj8MSH9LWY7w=@lists.denx.de
X-Gm-Message-State: AOJu0YyqP3JREgIdGfHqtF59wPQajgkJHF+MVDiF2G+H8mJzLvvsTdzR
 q1ZxXO171J0+yb/sAmNz2s9Re8TerArgniw20AlUxUd5z7cEVOvgeQZc8sZxZsdeN0GDOSUZzsR
 QV13ipUH+j9wxVwLoHc3guwDYKydiWLlEEmD0
X-Google-Smtp-Source: AGHT+IEoKzO9yYizrEWQvUhAd26A/PLDhCjdAlPgb8/o7g5ebdRsghckgBkaAwdMNQoF2RKkeuOcPZOR9ba6XgqlBec=
X-Received: by 2002:ad4:410a:0:b0:6cc:2bff:59ef with SMTP id
 6a1803df08f44-6cde159f200mr25304096d6.32.1729263447149; Fri, 18 Oct 2024
 07:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241018013015.127620-1-heinrich.schuchardt@canonical.com>
 <20241018013015.127620-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241018013015.127620-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 18 Oct 2024 08:57:16 -0600
Message-ID: <CAFLszThz02k_vkpZT87kY0+1yanRK5euVFP9nj0U+F_DLZJWvw@mail.gmail.com>
Subject: Re: [PATCH 2/3] efi_driver: use blk_create_devicef()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Heiko Schocher <hs@denx.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, Johan Jonker <jbx6244@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Sean Anderson <seanga2@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
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

On Thu, 17 Oct 2024 at 19:30, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The EFI block device driver is the only user of blk_create_device() outside
> the block device uclass. Use blk_create_devicef() instead like other block
> device drivers.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_driver/efi_block_device.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

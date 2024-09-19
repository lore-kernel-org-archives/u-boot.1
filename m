Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF49FCF3941
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 14:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13FD891F8;
	Thu, 19 Sep 2024 16:10:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Przw8EXC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB3A891FE; Thu, 19 Sep 2024 16:10:41 +0200 (CEST)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EED89891FC
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 16:10:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-718e11e4186so829794b3a.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 07:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726755037; x=1727359837; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tqJyMHP0gZrJdtr1nBoPVHKriNmtGd5Yc2XGXSa0dxU=;
 b=Przw8EXCCmD+hYi9hF2/PwufD0q1sjaiUJt/5jqn8rJiomW/DDlBBu9ErDLkOAurKr
 VjaC3yFxeFKJuVCZPOKhW+wQXJw/fKGbEx1AXO13rcbRTLb2o1qMF+FClRqgMB3FW91U
 6Yx1ysbMQqLA/ZgDinRSfjgRfxP9fwiiYe834=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726755037; x=1727359837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tqJyMHP0gZrJdtr1nBoPVHKriNmtGd5Yc2XGXSa0dxU=;
 b=MkRJdAB7GSd8fcJucCI0N3Fe2dn9wnYWGHN0vs5Dnon14banPguIjFu3/GqTcBiMP0
 X6BweSAihAw9Pmdbhbdc4jDsVKvNwRmKrqHSOjheJYtITR+DM4KOMDFv+mCee/dUGJWX
 zWzA5/QrEUB5qj+FGDmnb+CmBlBac5upqgT25Sns8CxoDM7tPuxebW+jb6vollgUxHxl
 vGah4jmGSZQ9/TnmjOqMWHp5CMUCnEAr/wOmFkagHLnOvKDFF5DjI4HjBVnZDQqkTP5R
 T5wq6stirJRT27mW4ICthDA41Kp+klA1jFpwxFgIl9pzBfnvaxuwnyUTokG2NThRb41P
 vkwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyWBSXs29McU2ozuYwKLkcKWIOdgZ2VXSlf1FYIuMwK/zRl13sVi8VUQKJww3pH5P2s4kGYZU=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf+ZFf5xVutC2z7I1nXDubDDbj3vpBHc3G/wuCsklavWVww8Y6
 UfeZf+u3KsTJXeE+OOZBFRtE1eXH6u389mMJcw31YO6vfVM+eIoOK5rtSWO3rFV+JRv/rFpksja
 qMfwc/2LCCyGsTAbU2fzm08gFnb0vkP00HUqzjETQ0mxSG3nQdGMSTl4=
X-Google-Smtp-Source: AGHT+IF0mPzHUaK+/xnAXbJCQUHubywI8ZCj9XMfP4uJYCaYvr36opBCxJPWReJaYWlghS20JUvreuP+r2TkeBOKeLM=
X-Received: by 2002:a05:6a00:1990:b0:718:e276:eea8 with SMTP id
 d2e1a72fcca58-71926081229mr41216895b3a.10.1726755037448; Thu, 19 Sep 2024
 07:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 16:10:20 +0200
Message-ID: <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> For measured be boot we must avoid any volatile values in the device-tree.
> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.

Could you explain a bit why this is, and where this is checked?
>
> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/efi_loader.h          |  2 +-
>  lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
>  lib/efi_loader/efi_helper.c   |  2 +-
>  3 files changed, 12 insertions(+), 7 deletions(-)

[..]

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B28C3CD3425
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 16:55:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B6083CEE;
	Wed, 12 Nov 2025 17:55:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FGabkFl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EB8583959; Wed, 12 Nov 2025 17:55:20 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D2A883CD2
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 17:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7c707e11e01so920491a34.0
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 08:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762966517; x=1763571317; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iJlc0PJ1moKgqOm6UKgHy/d9sfcANwxOtYNpMmxdq/0=;
 b=FGabkFl2PJoI/8tISdLpYnmGo/FL+4cUWkE1I21SZ0Ueb0cu6dP5vIKx04Pz1shuJX
 LGrTAHklv0uKdkLzxv/Pg/SDWamOWx5s4P64rIWXECfuNwzNhaDQQjqlIdFMhH1izIsS
 Zkm9ekixNIC8AwJRjD8vH02BqwOXwAOwTH8+R6Llpy0zlpk1UO/QDs7/9B2oItgCFEaQ
 SZZx+GXZVqSuMrYHk8jp+icjIK7h5GeNJbnCwRSgD6V9OSRS0uTntexN1JlCIfCA/Kae
 yoWQN3QjOiBRF0XkOVJD13nF83T8lCnRJw3Svrqse+kg+Be3zsc5x6zHM6hVWHYcIVGC
 YlVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762966517; x=1763571317;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iJlc0PJ1moKgqOm6UKgHy/d9sfcANwxOtYNpMmxdq/0=;
 b=wtHp7SrckVmIEr0mvNqVc+Soqa+IaT3QbfVavFul7GNPVVX0yByY0JopWgAPWN7Tnz
 uUL9+S/fFSROIVa3Tjd7rZAfxNntZm/3ZPBVtY79EMqzYq91g48Z2mTdMXhgVE90aE51
 AFV7nBxd4UfD+63lSvxE+Trp9FZHRlkoVveS4f7BBu2h6UQKfOT9AfLBkzZZxWp2ug3w
 QfTbZbUK6e7VWgPhGYCHCi0f69e1FbZvgTZSzMEKB5L1Yd9Jw2NjEAVt5iKSLakDKwg+
 QOQa+bpmPBIpFznn90g82IYGq5WWwZsnaQeuD8yje1zts/i2u4fMjuFsozQt3lLg2wrn
 BwZg==
X-Gm-Message-State: AOJu0Yxfe4c6RAdu7EnX+AHKBMphLcRxDzxTABojpc8rNxrT8WzprKmT
 F5WoJWcvhENQJO+laZQ9OwIquFfIv1AXMauGSUUrmBzAxduP5QqfSdgZpImaqB9jpwZbKeUqqwd
 hHtH5pobpEoMd4JPViNqY08I2p4JxUBnXfg==
X-Gm-Gg: ASbGncu2y9fbpAttIE0yL1KJxEggI3Mf56YwTZh5wOxFTSaqcs2Io1nPwPQhGCOfVgE
 thm5dsdj0W9EpCy0SuU/CRdg7pgiAXPIpR1JsTYOQu1mMCyCUOGhjXpjdMtitnzh3yuZ1ik+tFs
 jpxyp4aQOWa7CilG11eOHwkw7mjswst+/sQ7Cgs3Zahv6V4rGbBiBfEItG2Kp1OyBkTXx4u3i1o
 IIWqrhJLktTITPsb2po/ek8KWHmQ3Km08s/mUUBEZ992Fm3NpQ+/q6po4XChw==
X-Google-Smtp-Source: AGHT+IFS4e65GwHGEMMOh/HDrM8jii0yKTC0GS1BgOKcVKfEffQEGzL3xQ4kTR/1UpyPTfbxuRb4vxM2m8QEdG8ZhkQ=
X-Received: by 2002:a05:6830:718c:b0:78d:a443:8c93 with SMTP id
 46e09a7af769-7c72e2616d8mr2087434a34.6.1762966516900; Wed, 12 Nov 2025
 08:55:16 -0800 (PST)
MIME-Version: 1.0
References: <20251110050040.183-1-briansune@gmail.com>
 <CAN7C2SDGh+PZaP2DNOhn3=D9Stw680-7k=Tus_+2r9UQYoAOyQ@mail.gmail.com>
 <20251112164118.GB6688@bill-the-cat>
In-Reply-To: <20251112164118.GB6688@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 13 Nov 2025 00:55:04 +0800
X-Gm-Features: AWmQ_bnSCbXhnMN90DrunT6zIqYsPAMCmO0snz6ElhbnPHJol7vkMpe2uSdDwzI
Message-ID: <CAN7C2SB25LPkVWMKYFS=DURg2GkarHqo=n0ogOJVn4Ra0+CnAQ@mail.gmail.com>
Subject: Re: [PATCH v1] sync socfpga common u-boot dts
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

> > Do TIENFONG still handles patches on SoCFPGA? Seems like there are
> > no action or response on all SoCFPGA related patches?
>
> Yes, he's Tien Fong is still active, it's just that most subsystems are
> fairly slow moving.

For patches that really affect normal boot should push back
to mainstream. Those patches really fixes the boot and w/o it
system completely stall.
For those that are more less critical can be handle in slower pace.

Brian

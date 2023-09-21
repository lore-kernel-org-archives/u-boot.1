Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A56CD494C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 05:06:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C66F86BF8;
	Thu, 21 Sep 2023 07:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SFX6b8WY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C82186BF8; Thu, 21 Sep 2023 07:06:15 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57776864C3
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 07:06:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-532e6f8125cso487217a12.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 22:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695272773; x=1695877573; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R7V3Jgis/xOsliY6xze0lstdxT+nYJ/UiaIRETeO0qI=;
 b=SFX6b8WYUZr4KO8AAWGpw1teWsjM5OZBJy/zwXiYIPXVtUjHetn9H0jh0Gay6RK3o5
 M6dMqE0jj8rXhSvWj3RR9HYmK71O5YJRJYxOlTnfWWsnpi2Mvy/NGYbqwq+/pbaXuCTJ
 TShV9fngkv067HI6vDcqXPkipYCcHwomL0p93XnVmVzKzKaXCL3VgHbtWPb/uICQa5bn
 GyFZaCe9/hjZJ3JwhhwMefdGHffNFFEDijvDxvazRqYn4S2ExtnHLrpiRmz0mEBsJv1N
 tvqFw1Anzp9nTGKr5F/5iJcyn8/Kl3sWspG0n9vKPX2QmuxN7eFF/KOnNu0BfqCB1Q4w
 1POA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695272773; x=1695877573;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R7V3Jgis/xOsliY6xze0lstdxT+nYJ/UiaIRETeO0qI=;
 b=IrOtvYheOPBWM9SZhrQreIagcUqzFdFILKpMiYB1S4AM4RqTG8kYasqNRQilJwDfj/
 kNYoFc7+uj0Uxv3yiUzBlro7RCbRU3hRLQPurPSJcwWmLh2USoUUfd12wZLt+Suqz+AH
 olssXwk+1x/s5flJWHwReDyAZF5F1u/cvoZ3c8rlAcV50Ah6WG0nAkRc9ASNuSVkS+Wp
 lTwxbhnE2XmnXzrdDR+Ui1fzLz1amFYVp3giaRUnuuTVlcc97TEzOJCwQt+O21ha3lEx
 bRJuxA9VaxCX2kWBTc1AAh1nA2EspdntTOtWpeLLSc3GKtZkydPaa9mS/63Mkw0raEc3
 fK5A==
X-Gm-Message-State: AOJu0YwQsh8cvlaHzsIsmoKHVvtoQclrrKYgRBqtcU6xuhrThmpKZK3N
 h6pYPHmnYaxhUCx/lXIKPl8IGYrpufzE5D/xw8o=
X-Google-Smtp-Source: AGHT+IFtoE0emJAN1J3r+r31uOS56YjvJDiaSwevGqUFWyt9JhxPQR6Uyh1/L2oNN6vEZMjGpbkS9yDnlvQa31okdQE=
X-Received: by 2002:a05:6402:2882:b0:533:39da:6ffb with SMTP id
 eg2-20020a056402288200b0053339da6ffbmr761243edb.14.1695272772595; Wed, 20 Sep
 2023 22:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230920030027.1385833-1-sjg@chromium.org>
 <20230920030027.1385833-8-sjg@chromium.org>
In-Reply-To: <20230920030027.1385833-8-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 21 Sep 2023 13:06:00 +0800
Message-ID: <CAEUhbmU_6MoxQ0cu1PmmLK6gmeq_co2g3WfvBeor2NBDUitC4w@mail.gmail.com>
Subject: Re: [PATCH v5 07/20] x86: coreboot: Enable CONFIG_SYS_NS16550_MEM32
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Sep 20, 2023 at 11:00=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> The debug UART on modern machines uses a 32-bit wide transfer. Without
> this, setting debug output causes a hang or no output. It is not obvious
> (when enabling CONFIG_DEBUG_UART) that this is needed.
>
> Enable 32-bit access to avoid this trap.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  configs/coreboot64_defconfig | 1 +
>  configs/coreboot_defconfig   | 1 +
>  2 files changed, 2 insertions(+)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

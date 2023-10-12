Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F4BCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:42:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CF5B86E17;
	Thu, 12 Oct 2023 05:41:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W/9bFMyq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41AE686DB5; Thu, 12 Oct 2023 05:41:36 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DD8586DEE
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:41:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-53d9b94731aso987321a12.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082091; x=1697686891; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g54ZpEpWmPuGkOqfV2OuEouL8FIeimntyx9vv0oe7Y8=;
 b=W/9bFMyqzp0CHdsPPcf5xtec9htuljJQuMlJnCLIz0T5mSdGp4MJaRq3yZPL/nsRXW
 48oJ0UZQPnJIz0jh7XwW8crxkBrmTRhUYDmtjXI+ifzPJtDUW6KcdcvKzjgBHbV75J0l
 XBLkbm+1OWcRJ3V9ELFjGNwM1u0V2AvidRNek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082091; x=1697686891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g54ZpEpWmPuGkOqfV2OuEouL8FIeimntyx9vv0oe7Y8=;
 b=fRZZLEV+Z20Tv4zZkhbDP84JlgiVGFpQ2WQJH0mkEKNAAWbIDrtKuuDwj5JRHdGwJ+
 RTbPF7yvHJPNEZGbB1ldbP3k4cdZmowv+Awewf75MfdaFuf8v2VKHl/nZfL0XyYcscQ4
 8ow3lk80Q5k0fFA5Yha84MJ+LxQ9wIyvJDE/i+M2AwBlWpfnhG20iXglMHXn1/1Geoxh
 yGoZ3GiWskqiQ5r8OlxzlUn0/b0SvL2CGmr0sPEwucxLInLY3trnYxCqh0au0Wy2MzsE
 0zH3Lva5Wf/I+4K/ig2xCiD+UHfw09dcU0bHlCxYMg1G1fQXjYW2OOQGCdUN4O5a5+92
 eilQ==
X-Gm-Message-State: AOJu0YzMpT2nDKDyc0wzrF+ZM+Ag2fJz1ZZ4UQJ6epafHsBlHjVcQP/a
 ytyFqBgdqeRq1JnAMuYUIUnlLWl/Qd4M8dI5XPV9wL8u+ksB8eE/wuU=
X-Google-Smtp-Source: AGHT+IEGjOJUiA94x6IeXYw2Ag6aPCakMpj3yCaJC6Xh1ZgRo9LepCeOqeaYppSUae4XQZVQKLnGQsCHopU95Mmf0S4=
X-Received: by 2002:a17:906:8465:b0:9b2:8b14:7a3d with SMTP id
 hx5-20020a170906846500b009b28b147a3dmr21478060ejc.4.1697082090717; Wed, 11
 Oct 2023 20:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-23-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-23-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:13 -0700
Message-ID: <CAPnjgZ2kwowhCJ=NKvVmPVd_Xt+WaLB=sEB2DUnFLtcv-e0tRg@mail.gmail.com>
Subject: Re: [PATCH 22/26] test: spl: Add a test for spl_blk_load_image
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>, 
 Mayuresh Chitale <mchitale@ventanamicro.com>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> Add a test for spl_blk_load_image, currently used only by NVMe. Because
> there is no sandbox NVMe driver, just use MMC instead. Avoid falling back
> to raw images to make failures more obvious.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  configs/sandbox_noinst_defconfig |  2 ++
>  test/image/Kconfig               |  3 +-
>  test/image/spl_load_fs.c         | 62 ++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49105C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:05:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7565487E6E;
	Mon, 18 Dec 2023 16:04:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V9hhiJKd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECFA887E44; Mon, 18 Dec 2023 16:04:03 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AEDB8700D
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:04:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a22f59c6aeaso378855766b.2
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702911840; x=1703516640; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BmCelzmTnq43QC2nOFna/kT1ZS8nlGwV2Y8KVdnPmbc=;
 b=V9hhiJKd5smKvfjXbX0B897kChbHyaTieg/uaN6MDPI0hMiOQUItpTnEAn54fWHZ2J
 L3U4LUhDLXKBlHeWjIFL4bqOpD5KL7QYyZaMlnGtL8au1os4qNRqpDz1bgInho0qQ7KF
 5i7a4CcAIEETabPdqF7gOgIdwTEGqlCpYopn+j1WhnznTBzPjLFt8Xk9ufJWYeScGWPS
 kXVxkpEJV3hc6R3m6e6DGi5UB+ziP94y37jt3BmdQJm/DeK8u+akJdqkP1PdaxP03Ooc
 PIypqyKgOaFxQnOgCUm2fW2aL3UTsyrRVgnItUDj2PD8eNzq28iBnwv7N2iLNxstnyHJ
 Ft0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911840; x=1703516640;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BmCelzmTnq43QC2nOFna/kT1ZS8nlGwV2Y8KVdnPmbc=;
 b=eT7TX8WEHweOqu9RkQrZ6NHFsdZNNlkAUBSafJmx5X1tZ3oQXzJt7bDM2iWkRUZGzS
 8taE/3y3AzwKCojpS3wvtsax6Kc9F2e3sl1tqUPo/qzbwCfto9a02Nmv90d19HevNGtI
 +WF4XK82AEuBGNjDRMVYGEUoEGksmxKpKR7rS9A3RUvUineKyXFuAMsBUDrXa27W9d//
 XhyPtoQtbrtCPrFaOeFz9Ty96tqhkTRFzeLp0aSZPj5jkqMTcIIGMDtQL/QA9R+AarB5
 Sy2Ak7MK7UYDM87GsQEja/uWLUFplOYHXSdvlFIi6COAT2Qi7O1v+FGJ6W7vO5vqTzFy
 mWpw==
X-Gm-Message-State: AOJu0Yx03Bbd3uW1SL7nom1THu/CKl3O9NZWQBVvf3UZslcZ4FMpPR2M
 sAWKM2wDQww/Z+0DTATWgYEEkPojmhx85Mm9FmhBlgALo4M3kQ17
X-Google-Smtp-Source: AGHT+IGy+gLcAN9KsXMPjYGKnj5SQ7hFt18joK3Ac4cDaacpeRV9rCjyLsPm0YD/3kQ+2kNPaFZQ8U6tTzoFr/2hn0Q=
X-Received: by 2002:a17:907:7ba8:b0:a1c:8b15:fc00 with SMTP id
 ne40-20020a1709077ba800b00a1c8b15fc00mr9830817ejc.64.1702911840568; Mon, 18
 Dec 2023 07:04:00 -0800 (PST)
MIME-Version: 1.0
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Mon, 18 Dec 2023 21:03:47 +0600
Message-ID: <CAD8XO3a0PF4hGhdLwTrAo5WYRZp+Z1Ve0BJmCYEUg0iTONcdsQ@mail.gmail.com>
Subject: Re: [PATHv1 0/9] net fixes prior lwip
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com, 
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com, 
 trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

Do I need to resend this patchset with small comment message correction or
it can be done on the apply?

Thank you,
Maxim.

On Mon, 4 Dec 2023 at 18:06, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:

> Add small net fixes prior lwip patch.
>
> CI for this patch set:
>
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=7460&view=results
>
> Maxim Uvarov (9):
>   test_net: print out net list
>   net: sandbox: fix NULL pointer derefences
>   net/smc911x: fix return from smc911x_send
>   sandbox: eth-raw-os: successful return code is 0
>   driver/net/rtl8139: remove debug print
>   mach-socfpga: do not overlap defines with lwip
>   bcm_ns3: fix overlap define with lwip
>   omap3: rename mem_init
>   Makefile: add dtbs to clean
>
>  Makefile                                           | 3 ++-
>  arch/arm/include/asm/arch-omap3/mem.h              | 2 +-
>  arch/arm/mach-omap2/omap3/board.c                  | 2 +-
>  arch/arm/mach-omap2/omap3/emif4.c                  | 4 ++--
>  arch/arm/mach-omap2/omap3/sdrc.c                   | 6 +++---
>  arch/arm/mach-socfpga/include/mach/handoff_soc64.h | 6 ------
>  arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 9 +++++++++
>  arch/sandbox/cpu/eth-raw-os.c                      | 2 +-
>  drivers/net/rtl8139.c                              | 2 +-
>  drivers/net/sandbox.c                              | 3 +++
>  drivers/net/smc911x.c                              | 2 +-
>  include/configs/bcm_ns3.h                          | 6 +++---
>  test/py/tests/test_net.py                          | 2 ++
>  13 files changed, 29 insertions(+), 20 deletions(-)
>
> --
> 2.30.2
>
>

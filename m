Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8251EEA719F
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 04:07:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26CA8842D7;
	Mon, 20 Apr 2026 06:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hkLu85bt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EAB583B99; Mon, 20 Apr 2026 06:07:33 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8457C80087
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 06:07:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6745a88eec7so2721595a12.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 21:07:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776658051; cv=none;
 d=google.com; s=arc-20240605;
 b=PQX1oPuHyPDRfnVY5Fhe2N57Q88a98Xn/wL/yXOXIMfrjjZVVVyh7Yqw2xzUlrz7Qo
 UPNzBHgvOwvIBx+zmQU0tCbBxPV/hmaJGzjM2Y9a6WHwF2ewwfWJZv/HlCTCU5QW0Hiu
 e0R8oV8vst8Vlc/qiijCVxEHLY0+SY3dhnzncYRUMp/Wm68oTo1a5fRxJ18nz8o33lTe
 xJoUPsE4TRWx7N/GhlRVo+VmF8n7y7m8E+V2UBj8IVlOu29YYkh1bhjAHdJ5SzLf34UO
 shdlrqrBQfK7xIasNSsrivp+uu1HiPH3YH7sHCbcfWjgUh8XTYDO/ejRAeJt0UUGZBl0
 P34g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gQpge1VenZjg9r24OaCXmAI+coeH8rjeCceXMNKooYI=;
 fh=iGfZZ08G6OXxn5V97DhRnYDMVwvryMqU0FIn7MZptoU=;
 b=E1wdinO78VI4bryYZ+yl9BYLmQVX49VNdxGYzrSeCAnzEhMkHHlgQUcPYz2dt1/0hr
 rTidaQqNTl0l/WV1KUMM/z4UenDQqnGfCq2EKE7ge3yl6atGzW5FLZVEx73Y/2TvC9/5
 bAX6IJ3TttXonNhDLBvbFwmm7I4L//94rqQ6BJN07A7IDA+2hFxpHBSQPlsCeb5sA1EV
 eoKabhLIzyfHK4r/DJUS1AoS2x4YfO6Urzf0WxCV9FKuk4jaPS723+JfLpq7oFDXKKf5
 64FZ0bYGiCQYnrBH8AX0teKh9VzQc9vdu0KUJ/fxim+ElczXntPTVceLJE3awNWl0aIC
 PBUQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776658051; x=1777262851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gQpge1VenZjg9r24OaCXmAI+coeH8rjeCceXMNKooYI=;
 b=hkLu85btR67fCGdrxp1VvwxnviXMoTTPIHCU0s2palnnFCMisMm2TojZ3f86/QoG38
 +koD8diOdvbnwnQK4DrtGJ2OFXbFDtZJB5bg840wGeE0o762+IhYp6+ILy8woZxQIEP6
 KgBBHbHqVu+1qLzRR1DpMW3JkW/DW1zdMfrEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776658051; x=1777262851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gQpge1VenZjg9r24OaCXmAI+coeH8rjeCceXMNKooYI=;
 b=X2Jtgj+e+K5+4vMyK+iMf+qCt6QmHPVEBIHeNcM9R0jPqFfjrsxZBQktrP1oQXo862
 7idJ/+1VlEjkGhi71jMIbBSwdvHVvI33Wvddn0BhbBBdeQ1WgyYjbYIkLvuAxbiVz5Nt
 QcVWK+AZHGGKJTvqZNG6/KKujZZKEirNNCLMVm1/7Hx0ALCLahY4PTNK6y6L1MQ4qJUj
 khLJYjLJ+jd+o1PFTxAHhZZL/V+jeUE9TQ59wVJbXZkSWo1YFI1ZeFtJsQSBlKNL5SB0
 P8wX2i1Aa9VF0gAoG+cHONLcVgz09lIXs/edagYZtMPCSwVvoL6ngNH3GO8a+1+nky/w
 obUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/etrJqWRRTi5Isq7/4jnUEpdONIl8Ez6WDIEWxeB3DDqXRC1Tw9o6GhNlxOAVI+hZlrN5FZfw=@lists.denx.de
X-Gm-Message-State: AOJu0YxCuBTKcsc5/KPQQaY6bdUwfWGtulxBHXYoJlSbN6dO8aBcGKJM
 5rsZ1T+1htn88hwZEpi+vjJ8gpWhKizgWe+MA2tGoMpEv7v8e1dSsEDDTObC4IjPGSanV3205lI
 wMdyMXOsWG/TDN22vvTjoWueaUtl3fvxX1VuUEBCs
X-Gm-Gg: AeBDieuQCAXnVEEq+DcidaxKVa26z1gq6i5UfpFESEjVSk55PvIxuT7qcubAasxBm9D
 +FnyG0AO2avg0qGuWDhcuBef7MH7vG4bzQb/hk/xy5Bxu6E+ICYs6BUI8sIku9fQdqrTxZ7OIYC
 5yh3KgMdEp+kpUjsbnVLWILRr0GjcFgRHXccBLGfiIC3rI7VIH7oicz1C/L/YD5Tg3FQ3/9qHab
 G79M5UlFpNAKpvm4gKPLA/qeG1uEhS8gtdHw2zz9XF582oqQIA+YwkfRXbqehd62dTI2P9Rb8Bq
 K44CzrT4jtTIHNc0+CuVawDMfynp9KM=
X-Received: by 2002:a17:907:6d2a:b0:ba7:9cf3:449d with SMTP id
 a640c23a62f3a-ba79cf34e34mr104720666b.22.1776658050865; Sun, 19 Apr 2026
 21:07:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260417120951.3454249-1-aswin.murugan@oss.qualcomm.com>
 <20260417120951.3454249-8-aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260417120951.3454249-8-aswin.murugan@oss.qualcomm.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 16:06:54 +1200
X-Gm-Features: AQROBzDDdHA5qxM8NyAFSATWO3SO9W___NQU_rmaHD9UZfAeCwTZSNGbH3qyYAQ
Message-ID: <CAFLszTjddu8eiTq0zAnneW-mNp3aO267VaDMzwgX=sPT4jhkPQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] mach-snapdragon: Reorder header includes
To: aswin.murugan@oss.qualcomm.com
Cc: trini@konsulko.com, casey.connolly@linaro.org, neil.armstrong@linaro.org, 
 sumit.garg@kernel.org, sughosh.ganu@arm.com, ilias.apalodimas@linaro.org, 
 gchan9527@gmail.com, mchitale@ventanamicro.com, maximmosk4@gmail.com, 
 jonas@kwiboo.se, marek.vasut@mailbox.org, quentin.schulz@cherry.de, 
 peng.fan@nxp.com, sajattack@postmarketos.org, 
 balaji.selvanathan@oss.qualcomm.com, wolfgang.wallner@at.abb.com, 
 e@freeshell.de, yangshiji66@outlook.com, jan.kiszka@siemens.com, 
 funderscore@postmarketos.org, hs@nabladev.com, kory.maincent@bootlin.com, 
 jj251510319013@gmail.com, carlos.lopezr4096@gmail.com, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
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

On 2026-04-17T12:09:44, Aswin Murugan <aswin.murugan@oss.qualcomm.com> wrote:
> mach-snapdragon: Reorder header includes
>
> Rearrange the header include order for better readability and consistency.
> No functional change intended.
>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>
> arch/arm/mach-snapdragon/board.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

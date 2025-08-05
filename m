Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79130C87FD1
	for <u-boot@archiver.kernel.org>; Tue,  5 Aug 2025 11:17:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C93E68363D;
	Tue,  5 Aug 2025 13:17:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ys3T7ObZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AF68365E; Tue,  5 Aug 2025 13:17:21 +0200 (CEST)
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com
 [IPv6:2607:f8b0:4864:20::732])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41B958327A
 for <u-boot@lists.denx.de>; Tue,  5 Aug 2025 13:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7e806613af8so167893685a.2
 for <u-boot@lists.denx.de>; Tue, 05 Aug 2025 04:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754392636; x=1754997436; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HEq3Kp6Ryq2GRcHwBVSFd21AXbjLrli3a46Ls6IVVQ8=;
 b=ys3T7ObZ18tgG5EU7UJbADfFVAjUBxcP3vJB02DBv0j3UdrwFyi+IBKmg+iq44jLjr
 jZNjR6P9ZH4arZFzNhPM09OvA3lDy/p7voo7kBuJRl4FOe8AXbRSQDOfV28mzTQj3qN0
 9X6ImMCzbJdjPPSg3u0k12atiunS5BgtrSgbDi/vkJ1vfbHcY2eS3sxRV67SqIuXuWgE
 9UErxTjffTv9mM99Wx6cug6jjBPCDrzyaQT1ULzQPPfCxAoUmoixBXtN9JROZk0dxAGT
 ODtksCY1yoT+y2bSWdhP3IBOpwwkRcApn1glU/A4im5G7T3Q+oxrKAv64tHZks9Ekuhc
 iozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754392636; x=1754997436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HEq3Kp6Ryq2GRcHwBVSFd21AXbjLrli3a46Ls6IVVQ8=;
 b=XW2bdU7pSEVMhxR5Xs8g5MWym7jXNA1yabYEu90mMVkMiXmzRCNYhsbB8JHzfEpI3t
 U9pAcFjv1LSESXA1M6EKEW3CwDqIOo84Z8dX/SQ47YF/ZxFaRFihvXbG3hUyQBJ8bIVC
 auznAZt4UWhXgZAhc2hJl+/riRTesde3GLdQOFIclwlSJoMEK94MRTzC0dNomqR62ByG
 OqVZeFJMiArrNjo4Q8AXRFGE5ltvR4KBlVGr6AQ89V26fl9wI7KZ6JLK4hX71A3C5tJn
 foD2t3nQUFj241+/nSDOxPSbi7BuYtxXafecFkSpHe9hi5odVUlDA6+UUdtc7Judi3Qt
 lxmg==
X-Gm-Message-State: AOJu0YxoRWtgM9UOSU593XysUGAg2e604ti5IRXomcFbW3zGBll4SWHT
 82z2hAn6p2mxoCV7fVfypcirTSgq/CA8O3bP3b/T8Et6TayTxs3lgDHwRpXsi2oM3FSht8NJD+a
 3SxotGAXf7wDroxyqzWePoP+WzuXL2YZXV5QvVZezEUIQ6WMExWKW
X-Gm-Gg: ASbGncvoLj6582699zK5YzZfwZs8uKj0oCLcGbfL7ATkLuV1ymr02or4r82XcPgnXmb
 PB9QqjYy0nWWJ8qfwSZJv8bZGQ/X+SR2zLaif9zOxXbaKTF4yog6h5whc0Syxrv85VvPiCNTtdC
 ZH27Unu6N3bb4g95ZfxnBgweKIJqUXcn8Dip+jyFhetISsmr3PEZSbxkdnuXR58shlGUCinv1yg
 sUBoNVs
X-Google-Smtp-Source: AGHT+IEEcyQpTVS4hq+J6KN6wUDkgtkO2LSik1aTBoM7xXXlJes+qkJGeOExoupGUpuXpNxFwuDaXWJi76EZvJhkmS4=
X-Received: by 2002:a05:620a:4151:b0:7e7:fe10:60ac with SMTP id
 af79cd13be357-7e7fe10610cmr976323285a.33.1754392635965; Tue, 05 Aug 2025
 04:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250805094012.2268436-1-tomas.alvarez-vanoli@hitachienergy.com>
 <CADg8p966M2Ym3L0ZPLMiuMMQq6=D2MrvFd0WdrZkTzUJVvUnRQ@mail.gmail.com>
 <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
In-Reply-To: <DB9PR06MB7849F1DFD6B6D9956A8FD66FC222A@DB9PR06MB7849.eurprd06.prod.outlook.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 5 Aug 2025 16:47:05 +0530
X-Gm-Features: Ac12FXwPvJG3vpPtP5EnyttRdnCGAfr5GNcWPjdXykOvqV95kS8ji2gN4rtIXhQ
Message-ID: <CADg8p940FJoAOWQ3L5nRCZDhaSp_C-PdQbuh1XoT9RjfrizyWw@mail.gmail.com>
Subject: Re: [RFC 0/1] use lmb to calculate ram left for the kernel
To: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "trini@konsulko.com" <trini@konsulko.com>
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

On Tue, 5 Aug 2025 at 16:34, Tomas Alvarez Vanoli
<tomas.alvarez-vanoli@hitachienergy.com> wrote:
>
> > Do you know what would be the size of memory that the kernel would be occupying?
>
> No, we don't.
>
> This code is common to many of our architectures and boards, and the root filesystem size depends on a lot of variables.
> The idea behind the mechanism is to assign as much memory as possible after the space for the rootfs is assigned.
> In other words, it calculates the address of where to load the rootfs depending on its size and then calculates how much ram is left over for the kernel.

I am confused here. You mention above that the address of the rootfs
is determined based on its size. So you do know the memory that would
be needed for the rootfs? Also, how does calculating the amount of RAM
left over for the kernel help. I mean, what if the kernel is bigger
than the amount of left over memory? Can that not happen if you don't
know the amount of memory that would be needed for the kernel as you
mention above.

-sughosh

>
> Tomas Alvarez Vanoli

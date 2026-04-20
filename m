Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C14EA71B1
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 00:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11086839D9;
	Mon, 20 Apr 2026 02:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X9jQ0GvJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4AB88419E; Mon, 20 Apr 2026 02:51:23 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79BDF836AC
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 02:51:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ba7a1cc0380so80261966b.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 17:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776646281; cv=none;
 d=google.com; s=arc-20240605;
 b=V0z0ugWeesHfPGgROfZSPGR6DUbilqGSf7qbrgKicu9tT9sJOa0skz5+6fheN3o9bb
 HsjaILvXV7asbnAk+FckD9Fd3xAQ/d1S8S5+tTYuKzxDHXSARO3HPyFRrHfF3IAcfvz7
 +7eyMs4ZQoCjbHfKZdANH1zoeFDry+SH3s5PK0FLHBKNd7uWNF+wHy7qL6gjGQPi2MbN
 bzSY+zEjBSfv2/yGmjRgWaN7AoJ61uG3GAeskrDh9pj87SDWs8sY26i7OLLyYCHluBs0
 7BYetCmE07Jtc7iMTJRudOD2k+xRAHgrmV+c1v4DuyTR9HGonVS6Ae4WQvDkB4tEDq7u
 T2SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=evArLm4q2DGvFXUgWM9ZVvYCI+pPsYZpXHsObssqVO4=;
 fh=hl+4EPCgakLOnk7XW3qrLoLdx2BF565tvPN7+O4zasE=;
 b=Vikt1LgwE3orR+t6t9ySZREYA6/KRa+3iGUPKth+kIayOpgnnsHc3AMnfdxyiFjnet
 nfApXSOqf0iyQSrtSl5LN66Lw7mANHubEiu/err2wTQhP+VUFIC27+7za0EpdzsjbcfB
 feFkzL9oTaDX5JcsjNbzvdbeceTC4udI71rj2SlC3LfaftbdhcCoQQ2ilMgXQPoTeQgX
 URMpe/48AHG8m+q5jFeTrhNvSsXKb6oKQeDQPknpp5DVc7D8AJ/OzVd4Iz/KVweSuNuZ
 WnOvMFYttYpioHe/T/l1xQoGOGnK69khMhW8YSxvC5gvplAMBBmXZBaT9GEYCzc1S9X+
 hBiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776646281; x=1777251081; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=evArLm4q2DGvFXUgWM9ZVvYCI+pPsYZpXHsObssqVO4=;
 b=X9jQ0GvJXGu1XU0H22yXaWYtPTe60FQKL0jESp2ZKj3sbM47AhtgS2Ay1QYbCuDy87
 tTjGIDzACUKMYYtCbxusgqjhDB6MLSHcVWT84U0h7Bq4sbD1fNzXWg/N2HIq+95JqN+q
 wPc9dIHI2/o0Aa6g0rHnC+Uh5Ys5aAWcvrEOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776646281; x=1777251081;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evArLm4q2DGvFXUgWM9ZVvYCI+pPsYZpXHsObssqVO4=;
 b=F7rky9Ru42CQIo1hsZA0bNYJLBIsgXiv6m2WpZViODs99AM5p6HQ4UiSGJKA1LkDxu
 CUaQ4F8Hvw8N41mG6x8nbyZGB4Qxi5HVX6KB0v4ShrxtGJbjy0T1/Ro30gSW9NQzmFt+
 1QUstDU/5tJF59LPmWD8fkNPhvIKnS4cHInGESws9XzqrrC74rQVm1sONxU4W5NIDYT4
 96vk0NBLvn4plmFcmNXlIM42Pta7w5/IkkQudtOPmoMnwfg6Y30BCeXKZuOi/KRSSaBF
 7w5wSoke2O8CS0WnwJDe19nUd9c2oTQQDodrewBAQbu+Fzl/oV1gPHc7ogq6+wCeV6Lf
 z1yg==
X-Gm-Message-State: AOJu0YzieYtd/zhG/qS3BiJRQDX9kusX6tB9r415S6zgxFN8M5zuLcBR
 JH0xX0YkOxmC05s2RTu/6b808VTYGBnRm3TfJ3rm/2LvVZX4abIXDeJ5zCm9SUrqc4gJvMweXlj
 VFEjjIFQKKJFb2Xilv5GvasBfHL5W0RteaqBRJjfQyT24gDmDotZAwzO4
X-Gm-Gg: AeBDieuSezAenQtWgxorihWNqT8r7b6CXw7zGBPHOLF8PdgkONr9SSJPc2Dnjrt5Jh/
 ar0RtsMO/MSztmgCXlGqYVU1K/v3J2+zg6AgcQ1q0DbsBCjd03eRcAhFadxVameZQ0JdSf1GR0B
 VTzWKBCcfXmpLyEczMMP7JJtRWDNf3iBhCd9hqIoN8QLn0dRswIi+o7jaot7a7W/xOFdBSo6e35
 l5rEaccBlFsXQlLHqwTXGiSJ3JJFGOy2rUsQFYSXh8H2XdBLpo2LUGDf8EY1LngxPiFut43UmTE
 79rrMh/JejOiwu6oKaI0
X-Received: by 2002:a17:907:94c7:b0:ba8:422:6015 with SMTP id
 a640c23a62f3a-ba804226350mr38043666b.1.1776646280854; Sun, 19 Apr 2026
 17:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
In-Reply-To: <034a4ae4-b579-42b0-b6b0-3a204737156f@proton.me>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 20 Apr 2026 12:51:09 +1200
X-Gm-Features: AQROBzB_ooP4-cZ6V_LXPEJFtFEHx3bqhR46FPAi_D4-18DVTIibAVaCxEpI6UQ
Message-ID: <CAFLszTgnGxLnEYdPyymLowq9jUTfRyneAPfBLu336MGQB__YDg@mail.gmail.com>
Subject: Re: How to build U-Boot with a custom out-of-tree device tree
To: Johannes Krottmayer <krotti83@proton.me>
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

Hi Johannes,

On Sun, 19 Apr 2026 at 02:40, Johannes Krottmayer <krotti83@proton.me> wrote:
>
> Hello,
>
> This question is generic and also valid for none RISC-V boards.
> I think it's maybe already asked, but didn't find any useful
> information this time. My question is, is it possible to pass
> a specific device tree blob to the build system from U-Boot?
>
> Example: RISC-V board Starfive VisionFive 2 8GiB variant
>
> The default in-source-tree device tree from the VisionFive 2 has
> only 4GiB RAM. I own the 8GiB (RAM-IC BiWin BMWZCX32H2A-64G-X)
> variant. So therefore can I pass the device tree blob directly
> to U-Boot's build system without modifying CONFIG_DEFAULT_DEVICE_TREE
> in the device configuration? Exists there an environment variable?
>
> Want to use U-Boot's EFI subsystem as loader for bare-metal
> environments. And I think when I want to get the memory map
> via EFI there will with the default device tree only <4GiB free
> usable memory shown, although there are 8GiB.

You can build with: make DEVICE_TREE=...

See dts/Makefile for the logic.

>
> Thanks in advance!
>
> Kind regards,
>
> Johannes K.

Regards,
Simon

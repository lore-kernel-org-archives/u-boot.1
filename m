Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E1CD42B80
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 13:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DE189383;
	Tue, 12 Nov 2024 14:47:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SUz4iJvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C6889448; Tue, 12 Nov 2024 14:47:29 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F5D8891B0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 14:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2e2eba31d3aso4286181a91.2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 05:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731419245; x=1732024045; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ShWcqDCcOJSRHzQkJiVpbjdhgjCH6jNImmzrTTLTKn8=;
 b=SUz4iJvh12YXwVymJKhI8YyOv2uoDOEe1ZZPE/CL6m6Pr18R9vZpft6Gxm1QaLt9oU
 GZuDwKplLB26y2qoZuR50eIQFiq2UvS6EBGbVRiiDi4HSlgcTAOAj6NFboXlDQ4vuHi7
 Y6mj+vPuE+6rurFx7e9PlDeMdrjU0UpZkmuVUYgw4qmqxu4incCs/gO3FQM5M+n49KIu
 DlfxE3SprOSQ7ZakKSnSn/bVoW7YyscOskyGr7bKDTT1igk3PBJcLSR+Rw3Y8wsIPmNG
 2ZqtV7KRr7eKglIybSNLyWecUwuaQ0yiAJ9Ywe6deg5p8A1uJxZRnkzHbKYLdMBScQwH
 GKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731419245; x=1732024045;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ShWcqDCcOJSRHzQkJiVpbjdhgjCH6jNImmzrTTLTKn8=;
 b=fS4BfufmTQk0ZOlJUObNHzJGHH0EX/XTU72A+2tRMb+Lf+XdoTciXxM3GvaMZ5DvEO
 K9FcAp+ybC1On2LiccEr2E/M72mb2CijIiWhF0U9TP9rOgMRVSWcuykHNEp+M8IoWRNp
 Lu8OtUCQbjo8xjzs3oyq1u2w9revU6gX9GmyOrbunQ1hdael6ux6VZN3TrAXWkx243CO
 JVem0678okb6tDvjl0Urk9HVdGtvXG7kUFIZcBwbceYCuZh/6BFflsw99DAd+tn1LdZ8
 zL4PQWqqP2SHGdxBNYk3ojveVF54M/IC34I5AQlRLo3bzBwl79zgLoIC/ld7NxHDj7vL
 6gvA==
X-Gm-Message-State: AOJu0YzcYGkw/MZaquX9SKLbuQft1MXGz8YnPS6tAFBL5N5k9raU1CCF
 UHw5hbXoxF6k7C8xB8v4kbevAFV+dPcU0heNv/HzKKS3XYGgHe+40ISVy8jSpbHa0y1wh4XZJsj
 WUu708Vft/3RKzgwBllDVjPo4W8lGjUKU6gbnXNtlvHzX8Hfz
X-Google-Smtp-Source: AGHT+IEwOeCv3RoQthZ2lRXc6BESpoUEeHMX4ZSdysvgZKQaIB1957VcXrxm00tEqvzDa4doFiKAkqxuvmww3+PFUCs=
X-Received: by 2002:a17:90b:3ec5:b0:2e9:5f95:54c1 with SMTP id
 98e67ed59e1d1-2e9b173c441mr23202542a91.17.1731419244979; Tue, 12 Nov 2024
 05:47:24 -0800 (PST)
MIME-Version: 1.0
References: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
In-Reply-To: <PA4PR03MB67848E8118A8AF7AC8AF3C1BFA592@PA4PR03MB6784.eurprd03.prod.outlook.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 12 Nov 2024 15:46:48 +0200
Message-ID: <CAC_iWj+2rBgsfNCjmW_Z8s9Zwu2NjzQFLUNAzehOgBszSYmCrQ@mail.gmail.com>
Subject: Re: EFI File renaming
To: Traut Manuel LCPF-CH <Manuel.Traut@mt.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Venzin Daniel LCPF-CH <Daniel.Venzin@mt.com>, 
 Gujan Armin LCPF-CH <Armin.Gujan@mt.com>, Manuel Traut <manut@mecka.net>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Burak Gerz <burak@gerz.io>
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

Hello Manuel,

On Tue, 12 Nov 2024 at 15:21, Traut Manuel LCPF-CH <Manuel.Traut@mt.com> wrote:
>
> Hi,
>
> systemd-boot counting logic requires [0] to be implemented.
>
> Is anybody already working on this?

I am not aware of any patches

>
> If not we plan to add the functionality in fs/fs.c and fs/fat - correct?

We don't have plans for it, but explaining any use cases you have might help

Cheers
/Ilias
>
> Cheers
> Manuel
>
> [0] https://elixir.bootlin.com/u-boot/v2025.01-rc1/source/lib/efi_loader/efi_file.c#L971

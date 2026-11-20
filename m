Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB25606A692
	for <u-boot@archiver.kernel.org>; Fri, 20 Nov 2026 21:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=R3tTGoJm;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MhnV50bA
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C03AD607D3;
	Fri, 20 Nov 2026 21:20:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ws4pVlV1PnYm; Fri, 20 Nov 2026 21:20:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D089D60748
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795209653;
	b=rzyliyP0WwwUwQNgggfV78A1CP9Gkb5QAoX6z4aOzwQjPPOtmC07+BJcLOLqYBWifiXx
	 +EfmEETcOwOBpU3b9DCGdg8DIARxKiedgZY4CKD9J6qdvjRrGfGjr+Hcetd4de/6ciYKJ
	 mcwwg0tBWrQPpDmJv4m3Z84k1zn1BqclwR5aMTCWHSTxnEOhWiBWzIIZyxpjTj5L5pgb0
	 bDKFEZY0FQCVnPX9+e0zrBpmBQOUlqBIckvHdCHR338i3UCED9vpjiZ/IpymaXerMzyns
	 8wDpyFSz5jvVailG8r0eL1yuyT7gTe6v0MUS22acX+Xf+yBS6bCcU8/ritlym8njcKg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795209653;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SjVWOkylskyZConARtvloTNnuzMTPrNN8EEDs7qATdw=;
	b=eXkAFVythbOOMNdA/xjIiHR75Wpr+nWDzxWP7vV3Rv6Cf5yO56DS0gxUfRTsp+jour7v
	 oXOTVbuLUaWyz16igUk5thmJN39cWSVkbLakaugVUcSx3X3u0Okj0fSFAX4WA8IZTBhJx
	 L11lGxYGX2gdRAP6YE1gkC8Wu2wBn7EnebjEB5wYQQXkble122bIKuyvyhZd0TsyQ2XXp
	 v3x4VHsbCQ3ayyfrOwrj7uFuPwuxIGerk7l8Bbw4JaArZoKZ/a29/8N+wzZUy76DrIEYW
	 QegidtmKxRwNaAkdl/KD8zsrWyH+kVbCA2u/XFMd690CngIadDm5PqmbVem0hVGjEzA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795209653;
	bh=SjVWOkylskyZConARtvloTNnuzMTPrNN8EEDs7qATdw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R3tTGoJmtwNxSSNpfOt12Yum/3cIZXQeO3Ii/d+u+kk5sL069eFT2QRlFvNud6yLA
	 wS0cWJhQ8MvUImHb/z4ifJ4yAXaeisybEk/qYtfEwJIXNFzhimiUl2euMtqQp0HA54
	 j0lM/UQJY5Zm5c2IPkrjYk2hoohbJylBtO4H5daFp02ACGHvfMqAeNpH1sD1k54G5e
	 WX1kcHPgRSp/yLvQvs8ESz6Lyf0qD3FMYJTq2iR9luudSyMp6tSZTipWwpBGrZ7giG
	 br4kiycxTkmib5tgQ1nldk/1Igh3TA7rSn8bm328B7LeSrgnzyziDLYZUyAGyyRtuZ
	 g17EQgjFAtSmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D089D60748;
	Fri, 20 Nov 2026 21:20:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 018129C1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:20:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E74FF816D5
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:20:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UHjGq9FDOVB0 for <u-boot@lists.u-boot-project.org>;
 Fri, 20 Nov 2026 21:20:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org BE863816D4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::b131"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b131; helo=mail-yx1-xb131.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=MhnV50bA
Received: from mail-yx1-xb131.google.com (mail-yx1-xb131.google.com
 [IPv6:2607:f8b0:4864:20::b131])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BE863816D4
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 21:20:49 +0000 (UTC)
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so1437599d50.1
 for <u-boot@lists.u-boot-project.org>; Fri, 20 Nov 2026 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795209648; x=1795814448;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=SjVWOkylskyZConARtvloTNnuzMTPrNN8EEDs7qATdw=;
 b=MhnV50bAwDylov8jHras2smj1eJAwA9pNO43Y7WemsxMhRdfCxdnkJcvYK427y9pRP
 69fFIGMVX+8yI7G5JW+MQG4WVRy1X1k0mj+cRze8dxdffI6iUCnaHYaPC4S9z0r3jaVM
 0cz1ofSuA7XhRSdfVEB0LytpxI82YcHuWE2HRMvmciYfLXYIZTs204yNzXOkWEQD/Lpj
 fFU/ez1ypFQqM7PzYpzmRt89d4NWFZAujNAbGzm5oPnFTHezdGz1SwxVXvwE52j5CVGs
 NiYyzrPgNzV7fYJ/e+VmvJ6A7u9anqu4qwhNwlp1oC2NFuRd1ANoonjxkLsmL9GV1Mlf
 aT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795209648; x=1795814448;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=SjVWOkylskyZConARtvloTNnuzMTPrNN8EEDs7qATdw=;
 b=asSwlloPbVpCigaR+wejPSIZXyuqbGNe7NcUcjx6lXNuIxj3zZJwY8mIsDRtiLDAnD
 Kal6HXgXej4k1uJJxuReLYENqYDPfCcOVXz7tDaP8Xj8ztsH5xaiiF7OlI+5slsSGYRm
 EPRXNKm/Px/5BuyxZ+th2mnM3CmJXt03M1XnuB9Uw3/lvW4zAwTcCe8vUzm78VbMmrHj
 4tRC2Np2xNTJYDz2THqF83CNf7tRv2pD9EvhdU+zv8vt4rBQ6kMA70UAJoSsyVXFnlCu
 ioFzTYLm3qmHO8rkWk6AaDz4FPRfPBQtEkbTzUDTTqY2HSxJG6B7uwsoWvS6x9m4W3no
 eKSQ==
X-Gm-Message-State: APuU4Z9Gd6NxK57ThDnzF1Z4g8+SH8DN7aYG3vNRDMyWbaWVN/pNumB9
 fE1xdvbEqILO1CHguxYyGp+2kX6hRRXUr34T27fAGcg5tV2cfer1segdfTslbu6cwynZvxBTKw6
 N7lIqR+MW7jy3L/MV9LXk3bUUXo6HDc1eL9+i559uaA==
X-Gm-Gg: AZFdTZedTyxrYJeEtrmauS2dSzROmq5yu5DVc4LUPex1U8VJ7MSOCsxyJN68yDYWuha
 dCOK5korUZsMwNkydRRA7mm1m+DDDpPD8DgXI8iyj8MDCoQCexwsBantVmfKjjPBjU+xLDmaeIP
 nb4aX8Fr0xcn3iCcBxRcJHMShZu5to8bnY8IaYJweD1cDwBg4bZfKXhbnLZTfbO4PZ0Gjvmhymw
 PS5ru/BUq7AYT8Aa8G06kGTElPo1cQYSlJwptNFpJAGy2nRD/7wDwPuf4UfepNSicewJ6wGJsoH
 BzT6WKs198Zl3hMyX4lMwvKLNsSzvPbBUyo7LVj5qFjlfXXeg/KU0NnSStGRutOAqzne8ktXBsQ
 JyWs86TAP4nRcRaA6vY42c8ukxWn8bBYHyUxgS4CO1+eFf+GW5Hf2vCpxL7IoY6nE8cacq0wImj
 kf3xCTgyvOWLchKUjqtyyWFY8eUMnNGTiQAbOCjA3EHNeFWjbxEFKHhWBGGMpQk3AgbwOcXRBYf
 iBQMAFoz3CeZS5v3jdD3pvWq9WvOcDQivwYCtk1prr8pcp0L3w4MEPm9hNMUZWrBjWeozc5mrHw
 Snu+xWtRcQNoVhMuJ/vrr7JnX9qvVRweDTMJV3hCDiQMS/hrzD4cmpUJgPWENUe4a0LF6A4Nwyy
 pnto+Sns6wb9t4tSrzJTiv8WXIaIkKlxPhL7RupJe6bGFa11GO6Mw+iwiybQgEJP87ZDTzXr5G5
 ENayUnICw10IlIWN01OdWkFKJLHW8vHTmABRLYmcUQlRPCF+IqifGDu4JOCZ0dVqGk3HeU
X-Received: by 2002:a05:690e:150b:b0:67d:a73e:2b61 with SMTP id
 956f58d0204a3-67df4515518mr1194716d50.99.1795209647900; Fri, 20 Nov 2026
 13:20:47 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261120-apple-t603x-support-v2-0-606b4f5fadc5@jannau.net>
 <20261120-apple-t603x-support-v2-3-606b4f5fadc5@jannau.net>
In-Reply-To: <20261120-apple-t603x-support-v2-3-606b4f5fadc5@jannau.net>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Nov 2026 23:20:12 +0200
X-Gm-Features: Aa3M54omDyIgLpDYf2f7bBEX_0eQ2ggkyDpMYq0SI8nPGagy7UVjdVv00cDjRXs
Message-ID: <CAC_iWjJQZNp=cmKdGBnO3Zf25s8DvU8Y=sChS-HUtPgJLP+YTQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] arm: apple: Add Apple M3 Pro and Max (t603[014])
 support
To: Janne Grunau <j@jannau.net>
Cc: u-boot@lists.u-boot-project.org, Mark Kettenis <kettenis@openbsd.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 asahi@lists.linux.dev, Anshul Dalal <anshuld@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 20 Nov 2026 at 20:53, Janne Grunau <j@jannau.net> wrote:
>
> Apple's M3 Pro (t6030) and Max (t6031 and t6034) SoCs are similar to
> their M1 and M2 predecessors. The MMIO blocks have been extended but
> M3 Pro and M3 Max still share the same overall layout although they
> aren't as similar as M1/M2 Pro and Max.
> Most of u-boot's existing drivers are compatible with the hardware and
> M3 Pro and Max device trees will carry "apple,t8103-*" as fallback
> compatible strings. Only apple-atcphy-reset will use a new compatible
> due to USB4 and DisplayPort changes relevant to the Linux driver.
>
> Acked-by: Mark Kettenis <kettenis@openbsd.org>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  arch/arm/mach-apple/board.c        |   5 ++
>  arch/arm/mach-apple/memmap/t6030.h | 104 +++++++++++++++++++++++++++++++++++++
>  doc/board/apple/m1.rst             |   6 +++
>  3 files changed, 115 insertions(+)
>
> diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> index 6b3a0225f9ad..c93c3bd56aa9 100644
> --- a/arch/arm/mach-apple/board.c
> +++ b/arch/arm/mach-apple/board.c
> @@ -20,6 +20,7 @@ DECLARE_GLOBAL_DATA_PTR;
>  #include "memmap/t6002.h"
>  #include "memmap/t6020.h"
>  #include "memmap/t6022.h"
> +#include "memmap/t6030.h"
>  #include "memmap/t8103.h"
>  #include "memmap/t8122.h"
>
> @@ -72,6 +73,10 @@ void build_mem_map(void)
>                 mem_map = t6022_mem_map;
>         else if (of_machine_is_compatible("apple,t8122"))
>                 mem_map = t8122_mem_map;
> +       else if (of_machine_is_compatible("apple,t6030") ||
> +                of_machine_is_compatible("apple,t6031") ||
> +                of_machine_is_compatible("apple,t6034"))
> +               mem_map = t6030_mem_map;
>         else
>                 panic("Unsupported SoC\n");
>
> diff --git a/arch/arm/mach-apple/memmap/t6030.h b/arch/arm/mach-apple/memmap/t6030.h
> new file mode 100644
> index 000000000000..5d2061a446c4
> --- /dev/null
> +++ b/arch/arm/mach-apple/memmap/t6030.h
> @@ -0,0 +1,104 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * (C) Copyright 2026 Janne Grunau <j@jannau.net>
> + */
> +
> +#ifndef APPLE_MEM_MAP_T6030_H
> +#define APPLE_MEM_MAP_T6030_H
> +
> +#include <asm/armv8/mmu.h>
> +#include <linux/sizes.h>
> +
> +/* Apple M3 Pro and Max */
> +static struct mm_region t6030_mem_map[] = {
> +       {
> +               /* I/O */
> +               .virt = 0x280000000,
> +               .phys = 0x280000000,
> +               .size = 2UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O */
> +               .virt = 0x300000000,
> +               .phys = 0x300000000,
> +               .size = 3UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* PCIE */
> +               .virt = 0x580000000,
> +               .phys = 0x580000000,
> +               .size = SZ_512M,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* PCIE */
> +               .virt = 0x5a0000000,
> +               .phys = 0x5a0000000,
> +               .size = SZ_512M,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +                        PTE_BLOCK_INNER_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* PCIE */
> +               .virt = 0x5c0000000,
> +               .phys = 0x5c0000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRE) |
> +                        PTE_BLOCK_INNER_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC0 */
> +               .virt = 0x700000000,
> +               .phys = 0x700000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC1 */
> +               .virt = 0xb00000000,
> +               .phys = 0xb00000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC2 */
> +               .virt = 0xf00000000,
> +               .phys = 0xf00000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* I/O ATC3 */
> +               .virt = 0x1300000000,
> +               .phys = 0x1300000000,
> +               .size = SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> +                        PTE_BLOCK_NON_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* RAM */
> +               .virt = 0x10000000000,
> +               .phys = 0x10000000000,
> +               .size = 16UL * SZ_1G,
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> +                        PTE_BLOCK_INNER_SHARE
> +       }, {
> +               /* Framebuffer */
> +               .attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL_NC) |
> +                        PTE_BLOCK_INNER_SHARE |
> +                        PTE_BLOCK_PXN | PTE_BLOCK_UXN
> +       }, {
> +               /* List terminator */
> +               0,
> +       }
> +};
> +
> +#endif /* APPLE_MEM_MAP_T6030_H */
> diff --git a/doc/board/apple/m1.rst b/doc/board/apple/m1.rst
> index 66ed247eca26..3b4fb2913981 100644
> --- a/doc/board/apple/m1.rst
> +++ b/doc/board/apple/m1.rst
> @@ -16,6 +16,8 @@ the following SoCs work:
>   - Apple M2 Pro SoC (t6020)
>   - Apple M2 Max SoC (t6021)
>   - Apple M2 Ultra SoC (t6022)
> + - Apple M3 Pro SoC (t6030)
> + - Apple M3 Max SoC (t6031 and t6034)
>
>  On these SoCs the following hardware is supported:
>
> @@ -87,3 +89,7 @@ supported SoCs.
>       - 0x2a1200000
>     * - M1 Pro/Max/Ultra (t6000/t6001/t6002) and M2 Pro/Max/Ultra (t6020/t6021/t6022)
>       - 0x39b200000
> +   * - M3 Pro (t6030)
> +     - 0x289200000
> +   * - M3 Max/Ultra (t6031/t6034/t6032)
> +     - 0x391200000
>
> --
> 2.56.1
>

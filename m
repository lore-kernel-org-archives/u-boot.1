Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09258C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:33:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAF9787778;
	Sat,  2 Dec 2023 19:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DW5Z8Q/k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8342A877BB; Sat,  2 Dec 2023 19:32:16 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3E4186E82
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:32:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a1a5772b8a5so129222966b.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701541934; x=1702146734; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=udcqkl1wM0OXqDYwaOI4kk/n2FTKa65yTHVT+vNnghc=;
 b=DW5Z8Q/kGygVHG4+GSVo3Kr4Ygoe+1MN5EKNyKNA4Z31wjNDHTDyw8tN4oDrgbi5Rm
 P7K61DPCzXdHL2UUOHh+Auga4tZObyrDyrzoQmfapTm+1umaHJqIU0qJ7X6dy2yn+hsG
 vE7CU8JVHaML+po4PVju28QNaPKAl+334deCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701541934; x=1702146734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=udcqkl1wM0OXqDYwaOI4kk/n2FTKa65yTHVT+vNnghc=;
 b=U0RzEXlMaxvanBk7vAaYdp6f4iPi/oazhOAhrEYguFIv732ipqAsO0KESrI0mgTG+W
 xII2LIXLwvhULBxGPjueuYD0qLwUCoC3UyLNTFv4vovY9s7LzW3MzhRtvMUA1Nbkx6zq
 BZ2QtjYO4gK0P0bxY1wJE4z7rWU9rnMpilNqDzUOV7kAbME0EyY8VvgzxwvqujaTuJGq
 s5sH8d4mHulgRCn78iuqaxASC9DyEaMsitE8ntJIV1ZYIAx4r3BOHsxzdAEt83KWuXWZ
 KS2pmiuqWzPs9l4AeHLuMYFWGw0hrvKemFpvHGY0k/3S1XS8S77+jYHd9IJZtBdYHyQg
 TiIg==
X-Gm-Message-State: AOJu0YycXA4R5Wj4Kz846yJbFlrS4oWRMmOCZR4xt5s4BeIEVOHlFAbU
 QSCprpJ2Z7jWLmcogaxXbaERTg8gf48vKT+TsJ7O3tMCcrZrUWi9WhehFw==
X-Google-Smtp-Source: AGHT+IFSFiyAlNLSEU+MGK385m8rR8uQJBWiWXqo3VvZlrsQAziTSagrGlOnGZxKXczlu9FVLaGm9Q9Dz1EKBJ86C1Y=
X-Received: by 2002:a17:906:29c:b0:a19:a19b:78b6 with SMTP id
 28-20020a170906029c00b00a19a19b78b6mr995840ejf.121.1701541934170; Sat, 02 Dec
 2023 10:32:14 -0800 (PST)
MIME-Version: 1.0
References: <20231127195029.90951-1-raymond.mao@linaro.org>
 <20231127195029.90951-16-raymond.mao@linaro.org>
In-Reply-To: <20231127195029.90951-16-raymond.mao@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:31:40 -0700
Message-ID: <CAPnjgZ3hMHtiH=f5ZKXNniOfV_-vFryq1Gn7QZ5hKU8Wjo8igw@mail.gmail.com>
Subject: Re: [PATCH v2 15/18] fdt: Allow the devicetree to come from a bloblist
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, ilias.apalodimas@linaro.org, 
 Bin Meng <bmeng.cn@gmail.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Nikhil M Jain <n-jain1@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, 
 Michal Simek <michal.simek@amd.com>, Sean Anderson <seanga2@gmail.com>
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

Hi Raymond,

On Mon, 27 Nov 2023 at 12:53, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> If CONFIG_OF_BOARD is defined, a board custom routine will provide a
> bloblist or a specified memory address to retrieve the devicetree at
> runtime.
> A devicetree from a bloblist is prioritized than the one from specified
> memory region.
>
> Tests for this will be added as part of the Universal Payload work.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - New patch file created for v2.
>   Amended from the original patch
>   "[v2,30/32] fdt: Allow the devicetree to come from a bloblist".
>   Remove CONFIG_OF_BLOBLIST and FDTSRC_BLOBLIST, a DTB from a previous
>   loader is defined by CONFIG_OF_BOARD. The DTB can be located either in the
>   bloblist or from a specified memory address.
>
>  doc/develop/devicetree/control.rst |  8 +++--
>  dts/Kconfig                        |  9 ++++--
>  include/fdtdec.h                   |  3 +-
>  lib/fdtdec.c                       | 52 +++++++++++++++++++++++-------
>  4 files changed, 53 insertions(+), 19 deletions(-)

This is a bit mangled. I spoke to Ilias about this as osfc and thought
we had it figured out, but it was a bit rushed so perhaps not.

OF_BOARD refers to a board-specific mechanism

We should have OF_BLOBLIST to reference to this, a standard mechanism
and not board-specific.

Ideally all boards should use a bloblist to send their DT to U-Boot.
E.g. Raspberry Pi.

So I believe my original patch was closer to what we want.

Regards,
SImon

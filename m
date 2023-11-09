Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F925C4332F
	for <u-boot@archiver.kernel.org>; Thu,  9 Nov 2023 01:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA9118723E;
	Thu,  9 Nov 2023 02:16:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GCPDrj48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A32087230; Thu,  9 Nov 2023 02:15:59 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F5D1870D2
 for <u-boot@lists.denx.de>; Thu,  9 Nov 2023 02:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-53dd3f169d8so393271a12.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 17:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699492548; x=1700097348; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IiV6rV6LzmLL7bIFmLLIXFEPynqeTiu39cMoLEDNTV0=;
 b=GCPDrj48B4h7NSmGOa2vo4wOq6o7xoiqf1WNdj2vzXhePBh38p+dcZUIY+B78x+FeA
 tXuMYi+Bh6cUUSyj3xkqwdQxeHOT9GlbxTum2hDm1KIzlIlODDtnGa0SKmkAOEzcFGEG
 v6RwCfVJXPyhpzYsG1IT7+aozaKJMcF20xJj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699492548; x=1700097348;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IiV6rV6LzmLL7bIFmLLIXFEPynqeTiu39cMoLEDNTV0=;
 b=PS1585sypgLz6YWw0QGHGGcuAfFrmyMR20pHKRILtBdur9kSEzc1yRhKrEeCdr/KCs
 dF4ZWlu+A3mVBSC2/Flg3bi/NQ9sF8vRICI0XhjunSz1h8pgMXtYEsSHMseVkBLNmv+A
 BUXFjq+YVvIJklXOYWGYhxU1ASFaZ9UuIGOJTl2p7gfV6AoQhUG6M6HCooxv/ZefWRrt
 Hi1dUvkfWHzwbE32XCc0toUu3/oGlJVfWsb520FukTiwO6L1T22LHhteD6+PSPtKDZCI
 X2g2Gu/Wv4QewM5MizUgdGwv8EhpoZ0NZNS+V8UzfgxNIkciZ+Ah1k8siKzB7Y+xgZvK
 t/ZQ==
X-Gm-Message-State: AOJu0YwOu65+ANBgT2G9DmYYEM/WTyP2zOydPZtQYcfZNwoI2YGks4S5
 iZssZFU4Jbjcy804xoX9q3HG9siOeZDSkBeIK0UCRg==
X-Google-Smtp-Source: AGHT+IEG2MCnniRDqG2PWeiBkwQwE8Ckav7oPpG+xumh7lO3I3djZr0W8wqPwok8p93l3cYS/bFX1s+J2OQffheeihs=
X-Received: by 2002:a50:c09a:0:b0:53e:3b8f:8a5a with SMTP id
 k26-20020a50c09a000000b0053e3b8f8a5amr2720171edf.39.1699492547769; Wed, 08
 Nov 2023 17:15:47 -0800 (PST)
MIME-Version: 1.0
References: <20231108164858.3497420-1-seanga2@gmail.com>
 <20231108164858.3497420-10-seanga2@gmail.com>
In-Reply-To: <20231108164858.3497420-10-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 8 Nov 2023 18:15:29 -0700
Message-ID: <CAPnjgZ2f4xtp-q4=EwFKo6FnvE_c1WJmduV5GfsSWn021u_7iA@mail.gmail.com>
Subject: Re: [PATCH v7 09/26] spl: Set FAT bl_len to ARCH_DMA_MINALIGN
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Stefan Roese <sr@denx.de>
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

On Wed, 8 Nov 2023 at 09:49, Sean Anderson <seanga2@gmail.com> wrote:
>
> Instead of relying on the presence of filename to determine whether we are
> dealing with a FAT filesystem (and should DMA-align the buffer), have FAT set
> bl_len to ARCH_DMA_MINALIGN instead. With this done, we can remove the
> special-case logic checking for the presence of filename.
>
> Because filesystems are not block-based, we may read less than the size passed
> to spl_load_info.read. This can happen if the file size is not DMA-aligned. This
> is fine as long as we read the amount we originally wanted to. Modify the
> conditions for callers of spl_load_info.read to check against the original,
> unaligned size to avoid failing spuriously.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> Changes in v7:
> - Split off from the removal of filename
>
>  common/spl/spl_blk_fs.c        |  3 ++-
>  common/spl/spl_fat.c           |  2 +-
>  common/spl/spl_fit.c           | 23 +----------------------
>  common/spl/spl_imx_container.c |  8 +++++---
>  4 files changed, 9 insertions(+), 27 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

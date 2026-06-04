Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580DBCD6E75
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 17:13:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC9848493A;
	Thu,  4 Jun 2026 19:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cyrWZBqS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2B584976; Thu,  4 Jun 2026 19:13:33 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CD11848DF
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 19:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-486539875c1so418295b6e.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780593210; x=1781198010; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByPLfJ1LR5y+2RgzERwpM1bwS3VtMl8NonmcTKDMYAc=;
 b=cyrWZBqSqvwy3Lt9NggP4KDRXAY8/RsM4Rwh2PsYT0eLboz2SIacDM3NIvoNP/xpAN
 NkYdJ5sZ57i/foO0ImNdmS88RsEUXrc88hjFFziiZYRhnwbsdtDJ4StWhhWe3BDCB7Pw
 5HUqk60/V6x0TMJSvJD4tCfqID2jKb0TfnV+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780593210; x=1781198010;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ByPLfJ1LR5y+2RgzERwpM1bwS3VtMl8NonmcTKDMYAc=;
 b=k00iNKnhLzSJK/Dadpsn+4JGNhPY05Bvnvpb2uPl+/8WDm9DyhFnDqxzsatD0/e1MF
 75r06/Hfo94YI+xBLYnRK/e93Gx7ZaDQmWQaBoqSOdVdAAoPvzfRlU3ZNXmGNAkey0bv
 riMzEktWKiQ00BRGXUPg1ZZoP/xpjeIzCBZv0ISVEGZqzq5rF/f2yVV5H2Hdk+ORTeRF
 e6WQ1el6LHimTbLD2Qdhf2o/GYtMk/XYbf4k8Id1ujrCxfcPCQ8Aucq/cGkNq2uaxhJW
 /8pL2C4KL0e36z5UiXh0vLNJQh0YAr9tAJwXdi70BVbEVPan0W8DobRB+Lu0ooGB/xEg
 Aovw==
X-Gm-Message-State: AOJu0Yz7VyMB1nEPrb+40lXXeSfdmkPbxBl/kriM+OUhrjxdA/kFQIjR
 JRueYwHL3fafFVpNipTkrkViIeOVBJi+e7lfHuMIKGhuBnmzE/JhGoBmb2qdH72lEak=
X-Gm-Gg: Acq92OH8OMuFl654YQagwOqg5DFZ6vx4YDyyoKUb2Bzq08kIA4AtR7D5H7TOGVSVQ3L
 HJlAwAonUA1iHRG9zEXXd9Vb0/zjio4ICjlbVIQ+nHd7+xnq8bu7ORcMjZAcTGju6wcDpNEH4Tx
 rwuHYJnp8AgXe6C/ucr40LuS2WJCGu8+wpSzRM6EZfeZSPXUoNNHloMlIFXmpDJhdbh4je+b0xt
 1bQ6gTONctaTA0tRcL4DWJm9C75cTqhu6BoAemFv/Wb6DtC7n5kYtLW8Zk5uj8yLTFi8PkGdzE1
 LB5ZygzKwRgxV8ihYxND/6Qb3CeG4Tmyc3OoLHwi2ysFTjuUaUanspMy1o2ALriPXspNHJ8r+Vl
 nDe356qiKgN1F47SDvdz4i1ZZQImPtKXU26oMjOzONhGrfk57Jy3VrSWxx4iIevBrUCemhG5GmI
 mqd7mVOAkNhCUzR53DAG0D/jBkoVHTGyAXB87ucUkmCEgmBBq50qdTemsTIlPjYdczhJi/IyEro
 LpdOR9xAN1PYnERhHJiErnyMx4rSrs0S9dHYYbywBeAFX6xpkoNqdFcvPnH
X-Received: by 2002:a05:6808:4f61:b0:485:43ed:bd4d with SMTP id
 5614622812f47-4865aad1ac7mr5288430b6e.33.1780593209695; 
 Thu, 04 Jun 2026 10:13:29 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4865b7ad946sm4700408b6e.8.2026.06.04.10.13.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:13:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Sam Day <me@samcday.com>
Cc: Dmitrii Sharshakov <d3dx12.xx@gmail.com>, 
 Brian Sune <briansune@gmail.com>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
In-Reply-To: <20260528-4k-page-alignment-v1-1-bf8859f6ff41@samcday.com>
References: <20260528-4k-page-alignment-v1-1-bf8859f6ff41@samcday.com>
Subject: Re: [PATCH] arch: arm: force 4K page alignment in linker
Message-Id: <178059320869.3942316.17073373581555379691.b4-ty@konsulko.com>
Date: Thu, 04 Jun 2026 11:13:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Thu, 28 May 2026 05:21:06 +0000, Sam Day wrote:

> Since 5c71f8110, the u-boot.elf produced by dragonboard410c_defconfig no
> longer fits in the 1MiB aboot partition it is intended for.
> 
> To be precise, this issue occurs on toolchains that have a linker with a
> COMMONPAGESIZE > 4K. Since u-boot is hardcoded for 4K granules, we
> ensure that the linker doesn't try to align to anything larger than
> that, otherwise we're just filling our ELFs with a bunch of useless
> zeros.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arch: arm: force 4K page alignment in linker
      commit: 31c2bb0cd1832f1030c42fbf588e7c4911e619dc
-- 
Tom



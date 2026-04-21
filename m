Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9867F94CB4
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 22:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D5578429E;
	Wed, 22 Apr 2026 00:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bKZ9mVCW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93E238429E; Wed, 22 Apr 2026 00:44:08 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 554BC8412A
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 00:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ba3115fe0d5so967218566b.1
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 15:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776811445; cv=none;
 d=google.com; s=arc-20240605;
 b=Jmo9I9cRMxze9wNzZfMIRvSQsZ2CzTHfQh0LxAw/6CJFS9cMiMCD/Wg2NdsyLq611K
 6VUt09BIpG4eu/KXoQLuNiqS78QwBB75AH6Mxp6eGdC+gDdy782K1cJ9zILMtBTbtElM
 8EdfEyeqzs8oFUBgOhYBSLn+BlJORngo61sr88lwK61tyj7Gf2MVYUCJ0jhDHimZl6M8
 ckRflywScdq1mVBiT2iia8UsLEZJAPOFhgwHSt+XoVWAyVnb17OdTfMvN3AKHOZeCwip
 AIHc7BCK2uSIjeFqIo3Tto5iZ9yx+O6Nb8aH03zf2EKCvW2pG02+EyVwmGGrXFMtBvI+
 MzFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ByCSWChsEh+5lX7F4nC3oFEu6ZaIU4RBLvXUsY4UezU=;
 fh=fJAGB8LvxCJalDRE+ziaXIW21+gD5jSCb0B1QEwHsvE=;
 b=NanG/UPN52VzSnLhZ1EUVgS33KC4xDSrOgfYN9Sy30ou6z0ssP/xGs6JOU/oLVGeBG
 DejGV8Q5U26VD5CNRNuZ7jllPUSrdJkbLrN2HLswfbuJqrB3OtbyFwET9um/O9Brg0Z6
 HvFsk4YpFhVF3hABx86WU4oMkmgh1rZH7LevBG+wDhj8kF9sDsPpAQQ0V4bXkG1ACmfF
 XM/2VsK4QYNT0tEhO+Bl1TLnzqI9MvPj8PhlLyS7QKTEk3zBawqMyGSoYrh9M3obU9BR
 IBsZYZeQaxZW39EyaJGgTlG4rZN5NcOlZuEJ8Vz+a515l6dD+CSB7AcwRpoBqE/Gp6Qu
 728w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776811445; x=1777416245; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ByCSWChsEh+5lX7F4nC3oFEu6ZaIU4RBLvXUsY4UezU=;
 b=bKZ9mVCWjBsvjhnmdDQOMdt1ZGSzutrUTksW3YIjqnSBRUAbhco3Jpq0kZp63hCgRw
 gozZuKf21Rdrldyd9cjhBYu8tqvckoHp4LePqaqaA0DXz36RbqF5JUVw67oICQlbPOUq
 t5YSVzgwXdHzm3Sl1BiHY2g0QjsgjsZO2NREI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776811445; x=1777416245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ByCSWChsEh+5lX7F4nC3oFEu6ZaIU4RBLvXUsY4UezU=;
 b=Zwj4ckMcSDlLwvq8hDtFY7cAfFba95YkDwE6nZakxCgf+CQj0Z/22qJi/AXac7uh13
 okLBSdlu/u8tZ7Scr51P6gRVUOhjWhZd0jxg6qriuBLHULDInKN9YA9+LsKUMVDdE7CI
 YaNwF1RfEC/Knk0pwyhDVUFW4dBT5CtaXvj02QwHMx+7jrXmHOrYSdhyP6wT4gASCqCG
 midZ422piXHz07mHMgzQV01jywt31BVpVu9QrZm0k30YmbfXBZJzdfHXUbNp1fGpf7Pp
 7LteC0foP7ww/1r+/aEMXpq5HqqAsGdJGSZj/6esRpNY2zX+GH33+wUetjg0M/BRaji0
 MG+A==
X-Gm-Message-State: AOJu0YygR3AHVwa6KTkIZFuyRnK3+OJIYGxdmrJY5eJ0XTM1s/bUULYh
 Nhz3sT+oEaEfqJKIRqoinHaFZqkJ1nZUvhtXN5Lwl5RrFxxpSehWZS1ALrJS4gX1ERptQ1/acMd
 LslS9hloJECUVngvhQhBrJ4U4tJPTrbo8THfnOtVE8QmLy+8Y386sqA==
X-Gm-Gg: AeBDieuSUe03+jSirttMZZ9lcRBKwVd0M+s6m8eqaazZMK5QbKCPuAw+vR8Bw4xzGMk
 hCrrgk+yLN/53aNUMmwmmQi7fDEVQpe6hBunWXuOChmsJ4PyALOKS3RpSHiws4Jd+zkCmpbvrYW
 1JQMjf83rkh+c+0+U6IaDDaJlDwLXDkVBs4mgt0xiLVRVUw3AWdc5NrpaqWzEeTBWdsTVa9TxSy
 8BRvNfNtOSipaCiInJl7KNFntLNA3ao9QGuNVgqLPswiQxfvu3z/W+xUSj1nEKfbWAc3OKDQ/3x
 q0kELHWbC3IQDFHi8qAp
X-Received: by 2002:a17:907:2d0f:b0:ba6:a05c:ac2f with SMTP id
 a640c23a62f3a-ba6a05cb512mr489803566b.22.1776811444807; Tue, 21 Apr 2026
 15:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776759754.git.weijie.gao@mediatek.com>
 <730a6370bd11b6897ef881e560a8687b893b7bdf.1776759754.git.weijie.gao@mediatek.com>
In-Reply-To: <730a6370bd11b6897ef881e560a8687b893b7bdf.1776759754.git.weijie.gao@mediatek.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 10:43:45 +1200
X-Gm-Features: AQROBzBFvWSFoRtTAc9G7dG-s5yYeGD_WKo0IU2hCZaBzam80JjUb9rGv3jrvbU
Message-ID: <CAFLszThjbMbM9CrFT0j8PaTao=BZFsWBSYaBkwJvhjZFucnz4g@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] cmd: ubifs: mark string parameters with const
To: weijie.gao@mediatek.com
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

On 2026-04-21T08:35:39, Weijie Gao <weijie.gao@mediatek.com> wrote:
> cmd: ubifs: mark string parameters with const
>
> File name and volume name should be const as they will not be modified in
> these functions.
>
> Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
>
> cmd/ubifs.c           | 2 +-
>  fs/ubifs/super.c      | 2 +-
>  fs/ubifs/ubifs.c      | 2 +-
>  include/ubi_uboot.h   | 2 +-
>  include/ubifs_uboot.h | 4 ++--
>  5 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

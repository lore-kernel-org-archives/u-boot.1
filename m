Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA4CC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 17:53:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 498B5877A2;
	Mon, 11 Dec 2023 18:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dfgLxqB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4219287796; Mon, 11 Dec 2023 18:53:08 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CC2D8779C
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 18:53:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-db548cd1c45so4298691276.2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 09:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702317185; x=1702921985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9n/CUrdHOl8mgs5i9SwPVHU/7jOML/cDsGOn2nRJ3aE=;
 b=dfgLxqB5D9iuxtrQaWr2SrJ4l4iLYvQ6tj76bbJvw7FhkMvyX4bFfeXlyvCqClR1ku
 Wq8JhFaFLA5VkssgQABuVbivcd8uk+I5tr4HCA6wqZ9kEslZLP1TB8P716w3Jf37j0pd
 hHiwIrwQVCyljIk586MJcQ5YLjyznbzyhejyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702317185; x=1702921985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9n/CUrdHOl8mgs5i9SwPVHU/7jOML/cDsGOn2nRJ3aE=;
 b=XyDB1za4Q0k+yH4g3aZfVOiGVyCTGlSmVD+Pz2VYplh1LCAg7OUMbp9sosEwspV6p3
 lEtgyqBdVPRcJrngnucblJ+azXeI5wUho/t/pDX1dT+j4RL7jg1iI5ohBOCuQ3/Eglvs
 XEHxKdzmvFMkaya1X9u0RhOfcannkkrB6eiVttQzBTfL5VX5xa9dEgnhl1PvM1Ou4bFy
 +TrNgCSpLUYRNkpjzzVjo0bg0//n8K5mz2B7x4aUzPHreRZ5I7//j/5+jsVPsKkzXa/4
 silRziXT2qeuNqdfH4fj0PzoeRcVk98C/DEBsEdsSBwJcbu9hH6cmZ5qKKNBQTO51/fr
 KoSg==
X-Gm-Message-State: AOJu0Yw3jRhahVYtNL4RjR+S4i4pZkU1Y9QnwC1ONGdveSNsWpqYjZh7
 KRwc6PaflsVxy9y5YVzQeoLaudlAqpzhQkZo8ZlLug==
X-Google-Smtp-Source: AGHT+IHj1NoDW1QbOs5paunsCt/zxQMvrJMT2o4aK9ZOV/BoZgzfxAAg8IJc8l8KKSbBs1HC9e5koLcs68pvbSu+Y7w=
X-Received: by 2002:a25:cb0d:0:b0:db5:4db0:218d with SMTP id
 b13-20020a25cb0d000000b00db54db0218dmr3454627ybg.16.1702317184771; Mon, 11
 Dec 2023 09:53:04 -0800 (PST)
MIME-Version: 1.0
References: <20231209185411.8212-1-heinrich.schuchardt@canonical.com>
 <20231209185411.8212-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231209185411.8212-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Dec 2023 10:52:18 -0700
Message-ID: <CAPnjgZ1ycQgEvd5jEDyEW77fgJMu9x4c3+_Ep5+oShz3SRZQVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] test: vboot: Using variable 'old_dtb' before
 assignment
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Roman Kopytin <Roman.Kopytin@kaspersky.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, u-boot@lists.denx.de
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

On Sat, 9 Dec 2023 at 11:54, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> old_dtb can only be assumed initialized in the finally block
> if it is assigned a value before the try statement.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_vboot.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

I suggest mentioning the motivation for the patch in your commit
message. E.g. does it cause a pylint failure?

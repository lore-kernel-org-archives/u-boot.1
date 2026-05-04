Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66AE5FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 12:16:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0365C84663;
	Mon,  4 May 2026 14:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fkOratnx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C8B684664; Mon,  4 May 2026 14:16:20 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD20C8394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 14:16:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3653cb9c6f8so915404a91.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 05:16:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777896976; cv=none;
 d=google.com; s=arc-20240605;
 b=Wpo1RXVhZAYU/E24sJ4xhVJc7fCvO01dsFYMitswQBgw5XuMzTS4r8WsXZJ+tBN9Su
 rvp+QPNU6R67QYI8oDAZbGVU3CrrUg9dxYtfcnnwa84q2ZYSdUjtVziAscakZMIamZ0K
 urLfTo9MeUxOQPir1NS7gShmCL886ueDTbP86WiuGt+rUqK2/XqFOhbl76a8sldPK8Nt
 SLwLp/Uc4YFghK6ZDAJ7r3kqWScuBvbIdoB5PyjPZnJcVzoWn8rcZhuAt4O3sZIlc9oK
 AQoabfs5GJjDLEgadM9H/9nFHj+XK5x88LkwuNJq5frUxgiTyn3covubUPQfyM51JKqe
 gGPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=8f5odf7BsX/5B386QBBkaWkQpt3oiALLgfTEMezMYiY=;
 fh=Y2mXGfE5lbF8eqzLCsA8h+FsR1RRnvWoeeAlud6xsDc=;
 b=h1hw9DXO0xoJRYNgBkE9BEtBqlAZras7vhu160T9Ae1kUo89+c2ghkkE7ji2TD0bIz
 4lZ86LLvEquc9yR1he6RACumGjnVO11oLaIJC62x83hXbTindGOINHhSWqGO2fP/SqqJ
 IDJjAK4X6YsDDi3Q7qPravhs0SBeMJDPyZ6HqlwYZwnGXbJiABNOWBvgAg92nKqVQc1G
 aE4E9zEtEqtEFWkyy2QTKkJH9GhfE/kXRz1NPxz68DOHmHvSPDA6A4braZCWuAwSv7oA
 YJ12dRSDts1eP6rdQsR+wY6L3l5tQAfemsODHjvYwk2hiD4Ls8taAEy6tM5P5G8qMIy9
 yW/A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777896976; x=1778501776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8f5odf7BsX/5B386QBBkaWkQpt3oiALLgfTEMezMYiY=;
 b=fkOratnx7frURNv2JEWaj0UF7yIcjtITEhmZjctMSMOKdZ4ZO21pSfv0rdiZgv3xo4
 +X/XVBq0r/VGMuMFpEK8ygO8ICF/OXyHuQmhRPnpdBG/dskyZx2Xr6HNiOmQ0WNfRe4I
 y5/KTx9cL5ndwbSH+vqG+YoajFI7ezg4774CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777896976; x=1778501776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8f5odf7BsX/5B386QBBkaWkQpt3oiALLgfTEMezMYiY=;
 b=qQrxQXw9gOFvvdV9r7mLN4Tgad0Ry2YdQTsLdAfiZyc11qz6+4mRxLczAbmlRE4O7k
 MX3EtVH+4vhBgVgpVMV4MFNpxe1E32bf08T4a27Dsb66rwq8SrvxW6hVWve01b2VyK+P
 TIhDELBIBg1EEnkqKEEnP3lzOsxTUMT8FO3Yf/PJvSODbTDC6ujkMQg7biZWb+V4CDXi
 HEB8wwS0GTCVFl6lrSwxDsQ34gngF4afN5pywDG7LrBCtGZVDthY0V5txdhg8zDHH0BM
 k7c6Y8UpwYsrNNC98p5XzM2Ar5nyclsdvaU2NtdrHJgeABRjku5aRKFBmd2YLkQBl/L+
 1Wxg==
X-Gm-Message-State: AOJu0YxxoEnaCrr21ldqIhROJfZ0QsRY94SZjtzKMZfYnN90U9E+z+gP
 LeG+jydtWXtkl2uiNP8u+OY0/WDfyx9+0+6dSetukQaKCwLBx55vrr6dgEmX5UHCsKvd8ffITEu
 Va4qTNK2IXB62+7/6j4QH0eLdJ7xDtb8vW/zYPxNt
X-Gm-Gg: AeBDiesa8EoNrAYA5SbTNgQkewyjoS+j8CQlyrtjdt/eES7ITQ5xLcGM+zWzUCfvd8x
 qc5Pj/ZqywxGPcE69OuE26G3nzNsu+QEVgP0xBx8PotQ4MoYfffiJ6gfeG7+xHMif0xJGYt+RD+
 4Q4HlVyaCK4gTmO9R+fJMilc80X26fkioZ0Qihxmw6WZlqQKsd30e1/hJNeXVFp9QsWi2+CIMK9
 /aLyQLHfQf2Wfiz26WQfH821VzI968/8hIg8kfby6jxhFm9D6sehBubc/GhBep4yondRAyQFM/w
 sjvYKrznY1WXkUAD
X-Received: by 2002:a17:90b:3f8d:b0:35d:95eb:879a with SMTP id
 98e67ed59e1d1-3650ce7e5eamr9514612a91.13.1777896976104; Mon, 04 May 2026
 05:16:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260504091023.v2.1.d2ced6516d3db067379940b538830e60968dbf6c@changeid>
In-Reply-To: <20260504091023.v2.1.d2ced6516d3db067379940b538830e60968dbf6c@changeid>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 06:15:22 -0600
X-Gm-Features: AVHnY4I1Ndn0MpAIA8n-0XjY7QLJcJfZ-MY-Y2iVjqrUf_FYPVdfNaVQqvc3ZVA
Message-ID: <CAFLszTiSJvS_K_qNxyWD5Lh7j6j4YCxvPsdUQKUz9kJFQ4HqOA@mail.gmail.com>
Subject: Re: [PATCH v2] virtio: fix boot device hunting in qemu with virtio
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>, 
 Daniel Palmer <daniel@thingy.jp>, Kuan-Wei Chiu <visitorckw@gmail.com>,
 Tom Rini <trini@konsulko.com>
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

On Mon, 4 May 2026 at 01:11, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> Commit 70101c3217ae ("virtio: mmio: Return error codes on probe
> failures") returns -ENODEV where it would return 0 before. That path is
> apparently hit in qemu and breaks boot device discovery
> (virtio_bootdev_hunt() expects only ENOENT). So return -ENOENT in
> that path instead.
> The remaining two error returns in the function are untouched as I
> don't know where they play a role.
>
> Signed-off-by: Ludwig Nussel <ludwig.nussel@siemens.com>
>
> ---
>
> Changes in v2:
>  - return ENOENT in probe()
>
>  drivers/virtio/virtio_mmio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

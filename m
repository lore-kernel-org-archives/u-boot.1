Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B61E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:41:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2A487253;
	Mon,  2 Oct 2023 03:22:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ax4UQlCS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770738748C; Mon,  2 Oct 2023 03:22:46 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34186871A2
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-9a9f139cd94so2109241466b.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209758; x=1696814558; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ubS1urcb1xSjyf/Hs50ji5uwlc1T9+ubI2qlk44ZYEI=;
 b=ax4UQlCSCIPIy/ZpJ8vurveTMpTBKNv0jy2vWVViuPwxbLwHEixNsUfsk3jVz2946b
 EfP60WCkusKkQKLhrtx9ahx/p6mnZZ9eFPyTbKiSiFWHr+zTfjG4o7whE12DhHjjM1Rr
 9Y6Sz0OlQexEJPPLLlCXrEaoor6E037LsPAfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209758; x=1696814558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ubS1urcb1xSjyf/Hs50ji5uwlc1T9+ubI2qlk44ZYEI=;
 b=R53v1XU0NqZoCc3UOLn4dn2YoUIaOGWm4xwWXEyqWkOIc/pAlsjIGASjxYW7lf/Xd0
 bfu9VkGSly9uTQVmxjM1nIYukre62xsc5vY1K8ijT6/F32HznzLDJLQZ4JLL9B4m1rFv
 E1JQORfjKmEQKg8brWV9q3L6QYtzHl4755le9jVSD41OpBq9c9pvPQ4EcmSHE/1Isc0V
 EmVxFM6nQ8QwzKHu1c3f3TnrzEWlhIZwgagd50Y53zWMvhL5MVb4sA+SJJq58acJuYjD
 7kPstOBTV6svGBeNcXql9ha3awdsswKkl1dg9bsjIx3qpssH4ZYjD/4jF4WhkERErfxM
 MD4g==
X-Gm-Message-State: AOJu0YypE9E3bykSBtLGaaBhfPrkGGQFE63BEI4OzZifHmIM/NA7+sUl
 1Uix6o+GLmapUrt8L6+Oj56wcsGGCfzjry1yxxmGF7fcqBxAo3i0qo4=
X-Google-Smtp-Source: AGHT+IEtFfan19ONWNzHoeHVNWWIYkgQAY1ASUBbx6+UduM8IzE7/ltv+8J3Hci33o6BcE3haJhNG1z46qg2lOPxKOo=
X-Received: by 2002:a17:906:8a43:b0:9a9:e525:8705 with SMTP id
 gx3-20020a1709068a4300b009a9e5258705mr8165234ejc.57.1696209758265; Sun, 01
 Oct 2023 18:22:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230926084346.2237483-1-bmeng@tinylab.org>
 <20230926084346.2237483-10-bmeng@tinylab.org>
In-Reply-To: <20230926084346.2237483-10-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:54 -0600
Message-ID: <CAPnjgZ0L0B3hDB-em1gXu4Yn7_YGZN5D6Prb5QwCO3PoaVuxdQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] blk: blkmap: Support mapping to device of any block
 size
To: Bin Meng <bmeng@tinylab.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>
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

On Tue, 26 Sept 2023 at 02:53, Bin Meng <bmeng@tinylab.org> wrote:
>
> At present if a device to map has a block size other than 512,
> the blkmap map process just fails. There is no reason why we
> can't just use the block size of the mapped device.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
>  drivers/block/blkmap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

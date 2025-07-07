Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC506C83F07
	for <u-boot@archiver.kernel.org>; Mon,  7 Jul 2025 11:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 533FE830E4;
	Mon,  7 Jul 2025 13:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iGuN3BsV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27AA83118; Mon,  7 Jul 2025 13:50:56 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F661830CA
 for <u-boot@lists.denx.de>; Mon,  7 Jul 2025 13:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4a5851764e1so72646591cf.2
 for <u-boot@lists.denx.de>; Mon, 07 Jul 2025 04:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751889053; x=1752493853; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cs4CBrKzcISqT7GSOLwBGbIgtJx0fJcygf4NyN1cqjs=;
 b=iGuN3BsVmvcAcoRo/ddh7xyoN7hTF/jM3p8XKSH1Y7NQoGHYYx1GCVIvotN6cP76zG
 qVpRYvRdp/GgrUUgVUaTCb9PwrM0/IALvDQjR3Kcq+wmMZrgtzWRbNmm8gL1Yu3hjC7G
 QikUciBj9Rt1p6zTJR9m05Oh77TlW8ewGvF6sOQP/YksYsswnCPvvPpnM3/cNanh1Kne
 7zTH2eE6FA+FCQhky1QvVuRZhXI6NAIootlmemJ++NsC8106tdpIxmice6LDENmgb+cs
 AmZoFbKolChaE3bAY5L15CQr2FRSjSY/p86cCoBShYrgXTt4BnO+yZeI/1VFNhJWgnDf
 0yyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751889053; x=1752493853;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cs4CBrKzcISqT7GSOLwBGbIgtJx0fJcygf4NyN1cqjs=;
 b=TZnhWkkNXVX1c4n9ArkPqJZ1DCtq+njYzlw5F2c2SmOMZD4Vpbmojjsz2Ph7gUCae5
 Wx9I0UDNhIT2rBbA8zb47vsIPPROIbYEwhuutUxQobmzTiJkk69PibcLtLhC3sovJu/s
 OGfVRtG0CPeyKX4qz5djGxfnDJkDOnuIRow+Oc0LwlJLlbkAlCdgR7TDwSHpqcuH28WI
 C2ixhk/eqJOUuP9OAW72Ar8rTlB5G04pljX3ROohZP5hnGpm4VLVNtLuH/oZ7lcVtvz9
 NyFBl4OY7K2Y58X9Ko10jdfjWAGMMe2TdpmQ6lA9wfKGc6SwI9PFxW4WlSYVUwwMzmD9
 KOoA==
X-Gm-Message-State: AOJu0YyqJuhdmIzvExRcTTLne98UhrBUihZe2Roc+dQPthqyibtSLND8
 bjCUdR24gQ55VhtEBa35YkBgUeOtBvXD5AcgLCAj1hb3oIZqb2ZsS9Jn8MavtWZT8cPRwTQZx5C
 /SlpFWeY8iH4sf4OpQn0BTjqcjiMfG+H67iBY1wKIhg==
X-Gm-Gg: ASbGnctka1r5LzHMcbb5mIsF90R4UzBRZko6O5iogID9/o/5WedT71jBu/hrjImlyFr
 u8QIGN6+gY0/BHil+8ySEj5/f3t+mipEtqGrTnSZV5aiAre44s1K6ou1oFN9Oqc7qwj5pxqAuyO
 SfatP1EsggdsGidLDyyNg7+TGsNt7nCT3gKRXutxr5W4ci
X-Google-Smtp-Source: AGHT+IHL041wvDOlNwNjc6Fm/7V8Gmp0yMkaFcQZfw6zUL0d7n6Q4Iip4hNrOhi9I0uxBecjwhRY491h7ziMe++a4Ok=
X-Received: by 2002:ac8:5a0c:0:b0:4a9:a2c4:a06f with SMTP id
 d75a77b69052e-4a9a69e90eemr121621181cf.36.1751889052926; Mon, 07 Jul 2025
 04:50:52 -0700 (PDT)
MIME-Version: 1.0
References: <20250707103918.4189148-1-padmarao.begari@amd.com>
 <20250707103918.4189148-3-padmarao.begari@amd.com>
In-Reply-To: <20250707103918.4189148-3-padmarao.begari@amd.com>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 7 Jul 2025 17:20:41 +0530
X-Gm-Features: Ac12FXwpxrCbEoOczqn_JxTt9290C6MTIDrD7kc-qfpRv8XyNz3CtVVu_QDdZL8
Message-ID: <CADg8p95jWh=NFEM_qZJKng4kY5iz2YGSd_+wjQ9FOMycHRws9Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] board: xilinx: update guid based on metadata
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, michal.simek@amd.com
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

On Mon, 7 Jul 2025 at 16:09, Padmarao Begari <padmarao.begari@amd.com> wrote:
>
> The generated GUID applies to all Xilinx platforms but is not
> specific to any individual board. For FWU multi bank update,
> use the image UUID (GUID) from the FWU metadata structure
> rather than embedding a generated GUID into the U-Boot build.
>
> Note: The FWU metadata is an unsecure piece of data, as
> highlighted by the spec, and there is no way to ascertain
> that it has not been tampered with in a malicious manner.
> U-Boot OTOH can be part of a trusted boot chain, where the
> U-Boot image has been verified before being booted. So,
> although this does remove issues that might crop up with
> manual mismatches, still need to consider the fact that
> the FWU mdata is not a secure piece of data.
>
> And this is a not real problem with Xilinx platforms because
> actually it is only providing reference stack.

Also mention the above note as a comment in the function. Not many are
going to read this commit message when reading the corresponding code.

-sughosh

>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>  board/xilinx/common/board.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 8ffe7429901..3d22149d429 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -712,3 +712,16 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
>  }
>
>  #endif
> +
> +#if defined(CONFIG_FWU_MULTI_BANK_UPDATE)
> +int fwu_mtd_platform_hook(struct udevice *dev, struct fwu_data *data)
> +{
> +       struct fwu_image_entry *img_entry = &data->fwu_images[0];
> +
> +       /* Copy image type GUID */
> +       memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
> +
> +       return 0;
> +}
> +
> +#endif
> --
> 2.25.1
>

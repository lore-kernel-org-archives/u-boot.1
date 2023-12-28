Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17CB4C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 07:29:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF4C87745;
	Thu, 28 Dec 2023 08:29:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ztPOywqA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F1F487763; Thu, 28 Dec 2023 08:29:30 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E95C874DD
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 08:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-50e7b9cca2fso2762012e87.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 23:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703748567; x=1704353367; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xiiEakbtETgWiL02R7Del0PdsZseVQLoXQDiijResps=;
 b=ztPOywqA0d07MG8oMnJuZC7aziCj7YC/NuLyPVblTNjeGu6JDNasP/tyGvWkfTcofR
 fKCTqE1QUv1dc42vEIVfeWiwKPc/l2F4IghF7r5xAVUuofSGpf27neAkR+caegC15FB6
 qnpre88boRo1QmL4HLcGUtZRm/YnETR/a8pfyfHsbf3F6bYT/ZzYmTZKasaiFcq5HCrq
 MUwU8hhS9RRBWlm67lSz91ZItDsOfXJGNU4vmMjDu/VxhnEo4BtkzWZW+KdR4XUH68rV
 3hmc3qkZcpoNbsAmMFXv3KH9isavpzar5eZR+e3vAVDiYOZny6oNtV5/C/d1ajS7qYH6
 4dtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703748567; x=1704353367;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xiiEakbtETgWiL02R7Del0PdsZseVQLoXQDiijResps=;
 b=hAQlndIwfUm5HJqoixLdWXV7LpZIsVIXpkeVcnxzpo6V8zkcQlSWqDatCm6ZHI1dF6
 50JN+l+pUATKEuH6sphdYM1h4dMo50na30ZY35cTdF22HdCTORf83E+7BoDb3h+FpImt
 2nu5T3um/EjlGFYEvB3ikYajr4JlKNadXlOmF5eClGp08V/riarmah0x6PAmC4Lb1zhe
 IX9w02azYve1CyWQ24DpnK6QRTg2z7M37feCpC9sOfhD4dIQx7y1hZjlfGyTGlv6ZVVV
 1Ff/dBDdjnK+L7sq7hrHylPKCId/8MFM59erkquSpG7Y/ESNQKicgLJai0FsRBxeLuMP
 Amrw==
X-Gm-Message-State: AOJu0YzZvtgWQJrfUZmbCgGAkUIJhLwCT2kPc4EqlY6pJA2kaCxX3h43
 r2PGBi6ZpiJWSwEVeujg4niv/d+PSPvJLZwVeqCVpuJbCH2QVg==
X-Google-Smtp-Source: AGHT+IEBHE/WeNzAPnmK4iOphxxNqwkT8a9AMnZIbfFUy0pmEoTEncbQtWtdFQyS8NZcDYCRp/V5Uu3t04cJjTUR548=
X-Received: by 2002:a05:6512:2186:b0:50a:10a6:1448 with SMTP id
 b6-20020a056512218600b0050a10a61448mr3556658lft.59.1703748567579; Wed, 27 Dec
 2023 23:29:27 -0800 (PST)
MIME-Version: 1.0
References: <20231227210712.712937-1-raymond.mao@linaro.org>
 <20231227210712.712937-7-raymond.mao@linaro.org>
In-Reply-To: <20231227210712.712937-7-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 09:28:51 +0200
Message-ID: <CAC_iWj+bo2gq6wuV1aQdWHybe2MhG_46DsMLBGpNbADEQnHHVQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/12] bloblist: Drop spare value from bloblist record
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, sjg@chromium.org, jwerner@chromium.org, 
 Bin Meng <bmeng.cn@gmail.com>, Nikhil M Jain <n-jain1@ti.com>
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

On Wed, 27 Dec 2023 at 23:08, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Drop spare value from bloblist record header.
>
> For now it is still present in the header, with an underscore, so that
> tests continue to pass.
>

Looking at it again, this commit makes no sense to me. Why is this
needed in the series? And why can't we just fold it into patch #10?

Thanks
/Ilias
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v3
> - Keep the spare value in the bloblist header to align to FW handoff spec up to commit 3592349.
>
>  common/bloblist.c  | 1 -
>  include/bloblist.h | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 168993e0a7..88e2a0f5c0 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -165,7 +165,6 @@ static int bloblist_addrec(uint tag, int size, int align_log2,
>         rec->tag = tag;
>         rec->hdr_size = data_start - hdr->alloced;
>         rec->size = size;
> -       rec->spare = 0;
>
>         /* Zero the record data */
>         memset((void *)rec + rec_hdr_size(rec), '\0', rec->size);
> diff --git a/include/bloblist.h b/include/bloblist.h
> index 7eff709ec8..68f97395b7 100644
> --- a/include/bloblist.h
> +++ b/include/bloblist.h
> @@ -205,13 +205,12 @@ struct bloblist_hdr {
>   *     record's data starts at this offset from the start of the record
>   * @size: Size of record in bytes, excluding the header size. This does not
>   *     need to be aligned (e.g. 3 is OK).
> - * @spare: Spare space for other things
>   */
>  struct bloblist_rec {
>         u32 tag;
>         u32 hdr_size;
>         u32 size;
> -       u32 spare;
> +       u32 _spare;
>  };
>
>  /**
> --
> 2.25.1
>

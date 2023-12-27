Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA26C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 27 Dec 2023 10:10:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 382BD87855;
	Wed, 27 Dec 2023 11:10:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="QYnzUHhk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CED4E8793E; Wed, 27 Dec 2023 11:10:02 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE3188771B
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 11:10:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2ccbc328744so23458371fa.3
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 02:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703671800; x=1704276600; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=793U0tNZawXEnwqqG4Vp5GKbArsjXGbeHuAbaWWMP2Q=;
 b=QYnzUHhktsAAgMP5nr0r2gwcq9jxNlAQj3GRAlX9MUfjgOS3DMJY+Auq4cuoaBdlR6
 iYHgwCeucgHRo4uZ6c+ollsyYdhqcmuecA4vl8RdZ3OgoF2zXGz2FCxW9VGQZTnby2iJ
 p4AYNl/N9aJtfhv6WMKDnvzICxNJo2emQQ4E7OIReNu7FPEQEZsDHmPgMe1nA6yx2EMr
 al+IQ2UFA0uV0JiFmiGLC3zldudyrbxeq2pnJcnVN0i3Uu8EylIw+nXMsS+PgCFbLOl/
 q/PIKGBu9hxioMivTcTEutiGDrzKkKhi+GhmYJEKVRlCVkHOIrp8hy8L2qmj2zuJUyVk
 wLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703671800; x=1704276600;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=793U0tNZawXEnwqqG4Vp5GKbArsjXGbeHuAbaWWMP2Q=;
 b=G7vrheigidrh+ZZesflQxfwXkBZe8wZBVbNFOcBm1Cw9djeriPoycTC1dFBDpncLrn
 /gTmLJvop6bgYRvadGahEI/LtS1sZz7ECE7kGnlKUPouvVdHcusyB2n+QK2T08Dud7W/
 uqklt6ug867s8kX+CHiGcr/MVhXoUX0kkUbe9UoTFPBEghPgeWGSoDjLeTVCC3Zf8PaK
 VFvxPomnfdU9q0l1ZbV6aGvk1p884AOxhnZwZZLOqwcVJgWwDp9Z6xG49hllrtWALabY
 9ds1XG4P7NPnVuc+qyLvbbwdOnXcyib1R5/4+zbxibYs4A/lKYap69RZvjHTcfi1V822
 8krg==
X-Gm-Message-State: AOJu0YwZaT9YG0mOUOBhdnMZd7iyiQ0SAUz7AZ0JuBZComklfkCWnxrM
 V93kL43CDM9N2vqoXAlDlXx1JIvMJY6GWXtTYuRMqqFllZO5EA==
X-Google-Smtp-Source: AGHT+IHT+78htIQaVj0yaIcbMwj843jIx3E/XL7/FR6zKwoP1IH5kGIp9fX/wm7Y0LqB4i2JtO+zAl6aTPKSyImq3ik=
X-Received: by 2002:a05:6512:21aa:b0:50e:5b95:948 with SMTP id
 c10-20020a05651221aa00b0050e5b950948mr2738021lft.103.1703671799976; Wed, 27
 Dec 2023 02:09:59 -0800 (PST)
MIME-Version: 1.0
References: <20231218181901.337515-1-raymond.mao@linaro.org>
 <20231218181901.337515-13-raymond.mao@linaro.org>
In-Reply-To: <20231218181901.337515-13-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 27 Dec 2023 12:09:24 +0200
Message-ID: <CAC_iWj+xY7-JioFgU5XG3+cPmhGTmGN2_jdigHELAOD+XL=yHQ@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] bloblist: Add alignment to bloblist_new()
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

On Mon, 18 Dec 2023 at 20:20, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> From: Simon Glass <sjg@chromium.org>
>
> Allow the alignment to be specified when creating a bloblist.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Co-developed-by: Raymond Mao <raymond.mao@linaro.org>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v3
> - Keep the flag argument to align to FW handoff spec up to commit 3592349.
>
>  common/bloblist.c  |  5 +++--
>  include/bloblist.h |  3 ++-
>  test/bloblist.c    | 40 ++++++++++++++++++++++------------------
>  3 files changed, 27 insertions(+), 21 deletions(-)
>
> diff --git a/common/bloblist.c b/common/bloblist.c
> index 1c97d61e4a..6d079c58f7 100644
> --- a/common/bloblist.c
> +++ b/common/bloblist.c
> @@ -349,7 +349,7 @@ static u32 bloblist_calc_chksum(struct bloblist_hdr *hdr)
>         return chksum;
>  }
>
> -int bloblist_new(ulong addr, uint size, uint flags)
> +int bloblist_new(ulong addr, uint size, uint flags, uint align_log2)
>  {
>         struct bloblist_hdr *hdr;
>
> @@ -365,6 +365,7 @@ int bloblist_new(ulong addr, uint size, uint flags)
>         hdr->magic = BLOBLIST_MAGIC;
>         hdr->size = size;
>         hdr->alloced = hdr->hdr_size;
> +       hdr->align_log2 = align_log2 ?: BLOBLIST_BLOB_ALIGN_LOG2;

nit, but can we write this as a full ternary operator in the next release.

[...]

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BE3CDB47E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:47:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A59C86EC4;
	Thu, 12 Oct 2023 05:44:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KTMBMuY/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E484986E29; Thu, 12 Oct 2023 05:44:33 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF5D586E9F
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7af20c488so6646177b3.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082264; x=1697687064; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zAZ4XmDSY4DXcpDjVlkdvpFTFUb2a1T/KMxAYQT9zt8=;
 b=KTMBMuY/J3GfyUYSebbhvjlYQ21idVRK5Ty7Pyf6F25+OciO/0fx6/5NmJLjDvHELB
 unGFgeLvH36pwCGqLl23iaWvCMoyHFyDg7HrsHLTgGe0CaH5rx6R4l1NXed/KOEJUv4/
 qsYSdogja3plbnSiA3CNVAj6rk/r/fQDVhd8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082264; x=1697687064;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAZ4XmDSY4DXcpDjVlkdvpFTFUb2a1T/KMxAYQT9zt8=;
 b=OHrd8dolttUoL/piJUab6DAEJCPLIMRi6fEDzE+9bDi6cC5Hog3HouZbKQRFxQcALb
 PuafZLiwzaWSJCfHhTOoEzIj1+7IAMp28ojB+MBLhHqSWgGZsFnRx0ply2z2AHiwExF0
 keDwPfO4zKphJpj72J8wvXVOu6gLqnMStu1cUrnwQDPR7felhvYFFPfoZWXeaSLFaUyi
 +V/lYTb3XPdiN3JvFFW2C7tPoaUcf31OIyGBK4Cq1ptorD+eYJcG5SXYMxVtRiQjRaS8
 vOGobvDCofkpRndgZ9LfyWRjOGlqhb7wEI4iTEAPQJirmVUlYinwuZ8NM3TJGVrbeReB
 NqVA==
X-Gm-Message-State: AOJu0YwgnTpSfYbK+4C9Gz+YMqbt9Un9V0vrE1jBif8enQKxeZMsHPoj
 R2et+TKfodoss2zszKN6pKtQim/6mdffQF7jSD0x6W5GzjF4tXtPOWQ=
X-Google-Smtp-Source: AGHT+IG0Sr5ToaBNX6H4/HZInUZemHJTrVZ4rgOy7+q+CRyan/Npi3kpIvB4AvB0lQFEY5tq5foQHC36sln/BqP91T4=
X-Received: by 2002:a81:b711:0:b0:5a7:af86:8d3b with SMTP id
 v17-20020a81b711000000b005a7af868d3bmr8181141ywh.37.1697082263683; Wed, 11
 Oct 2023 20:44:23 -0700 (PDT)
MIME-Version: 1.0
References: <20231011131552.14665-1-bmeng@tinylab.org>
 <20231011131552.14665-2-bmeng@tinylab.org>
In-Reply-To: <20231011131552.14665-2-bmeng@tinylab.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:36 -0700
Message-ID: <CAPnjgZ2RQne4vTkXi-M3M7cxac_CHwoOjn4eQg7M6ksL9rdvGg@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] ufs: Correct the UFS terminlogy
To: bmeng@tinylab.org
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, u-boot@lists.denx.de
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

On Wed, 11 Oct 2023 at 06:16, Bin Meng <bmeng@tinylab.org> wrote:
>
> UFS stands for Universal Flash Storage, not Subsytem.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>
> ---
>
> (no changes since v1)
>
>  cmd/Kconfig              | 2 +-
>  drivers/ufs/ufs-uclass.c | 2 +-
>  drivers/ufs/ufs.c        | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

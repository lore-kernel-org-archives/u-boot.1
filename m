Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82165CD4938
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 069AB86CDB;
	Thu, 21 Sep 2023 03:04:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CGmbFUwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D9A286CDB; Thu, 21 Sep 2023 03:04:14 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E1EF86C72
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:04:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-59be6605e1dso5247257b3.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695258251; x=1695863051; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9vS9GdfCXLSSLtFDE5dmkNlsdsLOQBws4gyTSAN9jnQ=;
 b=CGmbFUwSH3DvbTYfuJlI24IMVmzUozL8Dqi2i3aX8BvFEWm7dRi0iDbSTLSm0PuBpC
 exI/l+Tuz117dBtMRAdPK5JVRZMBsgZCP6MQOfND4xYMXMYCuDpFG5tbkIoslA7UqqhN
 OFfl2GsovOKfBbLFM6pLhGPnUPUS8VabP6iBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695258251; x=1695863051;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9vS9GdfCXLSSLtFDE5dmkNlsdsLOQBws4gyTSAN9jnQ=;
 b=XqitxHDcs8TC7wsugeCgB9xhDrkqgxNGIAv1dGwCOUS+cD3LMyD7R4/8FIE61pErlL
 IvW4RU7BkBsqJLIPDqGqjyvFnpzjZFJRpOJIzbspnrc1zrlr/ozJA8mwxPmKV+5IvSPX
 cv93Fdpi1Ap3qI4lycyCHpkTJyAxl4cHGfc3NShIvxldbsEO5XwvWNL9kT5coB84LbIX
 hE2tmMgoE7k1DCtvYvtwNXyXEm4PTSt1KdubbkC01J6FzmfXrT7qnDEIHDaodMavcpNT
 ZvLeL3CuwAkVce4p7yQona+Vpre8hGmiaEL0ssKjdDWHT3Y4XyMcvMglj8T1vO3XqSQ1
 h4xQ==
X-Gm-Message-State: AOJu0Yy2gFK+W8AQ9DHRSIDl1fPYQZnGi7u1NKtJ/d4mTFiaag1a87VO
 I/tfptVo73Tyfm2ZLGmR5SDUAxRMWYlrTYXfpA8eSyVjBb1nDaHks6A=
X-Google-Smtp-Source: AGHT+IElDsHel+yInDw48sfCqOGGkH8ZbEydUcb0p/oJ0cCltv2aE6CTq3LP1e/T8zVvlmqEb+mCmXBemLZ+od2u+Zc=
X-Received: by 2002:a0d:cc90:0:b0:56c:e70b:b752 with SMTP id
 o138-20020a0dcc90000000b0056ce70bb752mr3950547ywd.13.1695258250817; Wed, 20
 Sep 2023 18:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230920032725.21748-1-venkatesh.abbarapu@amd.com>
 <20230920032725.21748-2-venkatesh.abbarapu@amd.com>
In-Reply-To: <20230920032725.21748-2-venkatesh.abbarapu@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 20 Sep 2023 19:02:38 -0600
Message-ID: <CAPnjgZ1fZMwsJmVbHH7Gaf8HLwdc1GaGWyBZYNu8KkeCFB=33w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] configs: Add support in Kconfig and convert for
 armada boards
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com, 
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
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

Hi Venkatesh,

On Tue, 19 Sept 2023 at 21:28, Venkatesh Yadav Abbarapu
<venkatesh.abbarapu@amd.com> wrote:
>
> From: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
>
> The DEFAULT_ENV_IS_RW is moved to the Kconfig for easier configuration.

Please use imperative mood [1]

Move the DEFAULT_ENV_IS_RW to Kconfig for ...

> Hence, the CONFIG_DEFAULT_ENV_IS_RW config is added to the defconfig files
> to allow enabling them for armada boards.

Hence, add the ...

>
> Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>  configs/eDPU_defconfig                      | 1 +
>  configs/mvebu_db-88f3720_defconfig          | 1 +
>  configs/mvebu_espressobin-88f3720_defconfig | 1 +
>  configs/uDPU_defconfig                      | 1 +
>  drivers/serial/Kconfig                      | 6 ++++++
>  include/configs/mvebu_armada-37xx.h         | 1 -
>  include/env_default.h                       | 2 +-
>  include/env_internal.h                      | 2 +-
>  8 files changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html

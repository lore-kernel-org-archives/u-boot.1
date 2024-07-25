Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72DCC3DA49
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 23:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78EF5885E4;
	Fri, 26 Jul 2024 01:32:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KSJilhFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9173988453; Fri, 26 Jul 2024 01:32:40 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6F9F8851E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:32:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-6b796667348so933406d6.0
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721950357; x=1722555157; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FO9G7xBTi2jnTRygPSZnGQ1/dZxwnGfKobwPzg1FjYE=;
 b=KSJilhFU4iCnUBa28AMJnVMAF/c2RCNobaX2ZZimZkhq4ZWZn7fYZXgHeGGq6KfnFz
 2lnANtokVt9ag44rtKNb6ypIYoIalkYgXE0IKR+f/jruMxWaX0GeS2Ba6ccdzkIPsa2X
 TV8d4Xv9sjzrpuiwmxqzAmj9y/Y2U4Ot19ZhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721950357; x=1722555157;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FO9G7xBTi2jnTRygPSZnGQ1/dZxwnGfKobwPzg1FjYE=;
 b=Lwj/xb9ErYUX/5CyiaIXAOGFfg4sj3klCp2Aeo0y0oXH4YYuysJ+qe35l4qi8s/9Ba
 dM79OXeDMC4aoVTarHGPJzKloYGqesHgMZqYBFdSdlicI7Ryq2l6os6CmR/R1aBpAO6a
 vlYiBb13EBgNRJF5z22gCXL5acgszcGuAWh/bpM0gOF/MneQnfFi/4bo8j3e8c46S641
 fDOQn24Rw35pM5wumbPAOouNa1VMTlwzitIyl7KgXI7jnP2xuPPCHNkqpEgHI/NhK1TX
 orCKMEcn32nigqO0APmJU17aQw74EGaVQx20SPQSGMX15jm/x1T9WLW2d9+0QJpjAF1u
 NMpw==
X-Gm-Message-State: AOJu0Yzp33hGBXImWgwgdTgwlukXqXJrGOJqGddtxx2IP8G2YDGAyRnl
 +SZvvjktExBtsRkgsW4at4ZXUs1/sFdhY3LHdVfADW+YL3jYEVgr/p9m1nqFvvChDRQkD+bnoKK
 B3bi793AgOwOb+TTqsXB8JCDDawkkWdE/M9Sv
X-Google-Smtp-Source: AGHT+IHw5NmzS6eUNx5lu8VneAa6cfQVdr6KNG51Q9TKaTaVFWfJOgbheY+wlevAfy20qp6NPSVY+SQ2aYFcFCUZ/ds=
X-Received: by 2002:a05:6214:29c9:b0:6b5:81ac:6b84 with SMTP id
 6a1803df08f44-6bb3c8cd4e3mr82661036d6.14.1721950356792; Thu, 25 Jul 2024
 16:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240724060224.3071065-1-sughosh.ganu@linaro.org>
 <20240724060224.3071065-16-sughosh.ganu@linaro.org>
In-Reply-To: <20240724060224.3071065-16-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 17:32:26 -0600
Message-ID: <CAFLszTjocf-85dbHDXO25GdHfmXeVsavYmyEvRc8wOS2jq31Pw@mail.gmail.com>
Subject: Re: [PATCH 15/40] lmb: config: add lmb config symbols for SPL
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Michal Simek <michal.simek@amd.com>, 
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>, 
 Patrice CHOTARD <patrice.chotard@foss.st.com>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>, 
 Max Filippov <jcmvbkbc@gmail.com>
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

Hi Sughosh,

On Wed, 24 Jul 2024 at 00:04, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add separate config symbols for enabling the LMB module for the SPL
> phase. The LMB module implementation now relies on alloced list data
> structure which requires heap area to be present. Add specific config
> symbol for the SPL phase of U-Boot so that this can be enabled on
> platforms which support a heap in SPL.

Could you please add here why we need lmb in SPL? If I missed an
email, please can you point to it?

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since rfc: None
>
>  lib/Kconfig | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Regards,
SImon

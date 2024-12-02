Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03BD9D78321
	for <u-boot@archiver.kernel.org>; Mon,  2 Dec 2024 14:26:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E75F8914C;
	Mon,  2 Dec 2024 15:26:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xZf9EIfs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F0989183; Mon,  2 Dec 2024 15:26:57 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D158589100
 for <u-boot@lists.denx.de>; Mon,  2 Dec 2024 15:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee8e8e29f6so1429872a91.0
 for <u-boot@lists.denx.de>; Mon, 02 Dec 2024 06:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733149613; x=1733754413; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vAsHRbsV1c7RvpfMdeIWHkeXPm1nD2hcxo8i/6cE/OI=;
 b=xZf9EIfsQaBPTGOSCP4uIPD+f3xMkLxn+F/qkKxBl+6U4THcL0koq0wepvq+x2M7+t
 8DmI+fSUyH7ne5dIUGjiaDW+PtPJgJ/7UYdmRTmwkjsfT26UXWDPReVBxq5Z7Xb5DGfy
 38getKhmKgslJoC4B4PfVNuzXqqKfg+fE0akyhNLu1Fd+BsfDZkECx5uKVhoKqyJPfDD
 bHMKodvfEaQwmep357CtiuMWuxZLRl+PBcPWOqN90CEAJ90VhHhsCTA+QE55Gypk0DC0
 gEbi0+GjnSIxzw945IRe5dtZ4UolikY08LywH66vW48+CybRDVeK5cqblkNX2b7MVLMq
 kZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733149613; x=1733754413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vAsHRbsV1c7RvpfMdeIWHkeXPm1nD2hcxo8i/6cE/OI=;
 b=Ddh/Y56D0TFhAi2sdeGDTPDeCpDXXayhph4BVkpfQVYfLjK41S5I6NKlaFidrTodXV
 oaeqGqZkektNRHLms7r8txfyEYlKUva6A/URo46IUrRRkARFxemulNHfZKL3dVh0acVm
 pt672ymENTZtUAzYHemR0Q0a6OF7DNfgigzoQcgBs46PiGnAFWz/GgVFqkJ2JAOCuglG
 PmZUSrYBglBR70C0rOEXTKT+G+6uXhqHjqNxYrZrgiNQMWBfWw0OiqHLhndxI1c6hh4Y
 HsHc50hsovz5XxhqFrJwrmopk7GC5IFu9kuhOgtN+4fuJ+dxxHLnLdtRlSAyXWcHrTWZ
 l5Kw==
X-Gm-Message-State: AOJu0YwAQSqN2pDgncPHqzg8+eB2k99hwVhpR2wys5r9wpm+6ZsTXWjx
 JogT439cLPsl3DsQqPjMTws5AM9Kn99JwOfK3w6d2VRgN2Ezsb7/gkm8Z56wLLPbm7VeIOOMs9l
 WYs+/az+alAr2sipApG3QLUC6OQGhvhisSg9s/g==
X-Gm-Gg: ASbGnctJu81l6WJmyuIuae18jnr3bWJsJ9LT0v1rsxUp9GTy8Q3UT3vLH+VmsXHzYW+
 Ly35NWcl7PKuKiCFbMryFEPs0qmB3Aqi5wQSRX8hexrtFELvfryMBQ+EGs+GCmXU=
X-Google-Smtp-Source: AGHT+IE6E3ujR9Oh1mTFmNR3S12NeVAO+FpN9+erQn5Gvge6KT0snXWlILm6ytk0sL+ayEz/MMumTjbDrqc8RCYWC6s=
X-Received: by 2002:a17:90b:48c8:b0:2ee:90a1:5d42 with SMTP id
 98e67ed59e1d1-2ee90a1600cmr13075196a91.0.1733149613346; Mon, 02 Dec 2024
 06:26:53 -0800 (PST)
MIME-Version: 1.0
References: <20241201144240.1664398-1-sjg@chromium.org>
 <20241201144240.1664398-5-sjg@chromium.org>
In-Reply-To: <20241201144240.1664398-5-sjg@chromium.org>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Mon, 2 Dec 2024 09:26:42 -0500
Message-ID: <CAEfUkUKGKMb3rXS7sSDQnPTHs2iOcYFN8zbViajjDSp+aHzXZQ@mail.gmail.com>
Subject: Re: [PATCH 4/8] Revert "fdt: Allow the devicetree to come from a
 bloblist"
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@linaro.org>, mason1920 <mason1920@use.startmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Simon,

On Sun, 1 Dec 2024 at 09:43, Simon Glass <sjg@chromium.org> wrote:

> This stops coral, bob and kevin from booting.
>
> The correct way to do this was always to use a Kconfig option, so let's
> first revert this broken idea.
>
> OF_BOARD and BLOBLIST should be general and hardware agnostic,
do you have more information on why they don't work for a few boards?
Maybe the way to handle these logic within certain boards should be
changed other than to revert this?

[snip]

Regards,
Raymond

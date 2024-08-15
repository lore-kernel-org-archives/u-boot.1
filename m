Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63844C52D7F
	for <u-boot@archiver.kernel.org>; Thu, 15 Aug 2024 20:37:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8639688C7C;
	Thu, 15 Aug 2024 22:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eUWS1R2Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77ACF88C73; Thu, 15 Aug 2024 22:34:26 +0200 (CEST)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C0D88107
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 22:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70d199fb3dfso1121397b3a.3
 for <u-boot@lists.denx.de>; Thu, 15 Aug 2024 13:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723754060; x=1724358860; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MiVLnhSwObfZ0uf+4DqeUJKIAfA2lXoozhLhN3SYAD8=;
 b=eUWS1R2YNEYm0NolclutwDzEB40C0q3TnhXwPPtvUwEUAwNv2FA5gTWZJ+gEQ5GICM
 Vgm+y4k9m17axU+YCaDN5pwt4PBLYlpeGXOVTT6VzXdoa8iXvwpQAXOoazkfWbBDjzfl
 1RcMUDE2cJjUHW4ba2oYlJBpimC3MSkW8SN1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723754060; x=1724358860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MiVLnhSwObfZ0uf+4DqeUJKIAfA2lXoozhLhN3SYAD8=;
 b=hsZXHuD7kB35snUCSMBBkn0Nw2zhoMQffM3KJLpY+Qozap2AA726nyTaU5F6T9xRec
 UjWzC5mJHXqpgQz+F3cc8DKB04Pywp+V2GRLUuXZeaHjojIHoc2+sWiPpuPqCkqy59Xp
 +8FfVpK12lLvZPTw3T8+N8VkrW25DGt+06hndS7LsAfSGx8i2n4cj2vQywlH/uBFLHsm
 ADl2Z9PxLxhnBTJaCUEd8sfX2J2DO3GWV4UPu6bFJrd+3V87P89ckTFhlischhxl0/oe
 2nS/UV47rOT5mYfEPqhvfq6JTURiqASbO3gC1kGWLSosACAvzdwu7m3rJiwU6QMGI0Gl
 X5bQ==
X-Gm-Message-State: AOJu0YyJJ5NmHFATxMoXC46Pj/8852/lpReTbEdKNdBaxpULQhKjk4+g
 LMbXpIv3h99Rml1U6akCPEXbfezPjEkMdSuUlPZ8i0RFsTNbouGPE3FaVXU295G7b2lB+eWIPGd
 agmJ7JyyqDv4tG2E400tpcLsIOJfHIVZnCF32
X-Google-Smtp-Source: AGHT+IFdaeCta9l+gVW9mPm8jp4wxgHHmqH2GJfru4SgB399G/foYy+Mwi8eLive3Gq71oZfLMvTTmSu6vRpZoUf1Hk=
X-Received: by 2002:a05:6a20:9f0a:b0:1c6:fbc8:670d with SMTP id
 adf61e73a8af0-1c90501fabfmr1011311637.43.1723754060205; Thu, 15 Aug 2024
 13:34:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240814110009.45310-1-sughosh.ganu@linaro.org>
 <20240814110009.45310-22-sughosh.ganu@linaro.org>
In-Reply-To: <20240814110009.45310-22-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 15 Aug 2024 21:34:07 +0100
Message-ID: <CAFLszTg14c+eY9rFzSoLqEitsoNKBetfW4J+tHK1ZN7=u_-Nzw@mail.gmail.com>
Subject: Re: [PATCH v2 21/32] spl: sandbox: initialise the ram banksize in spl
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>, 
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

On Wed, 14 Aug 2024 at 12:02, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Initialise the ram bank information for sandbox in SPL. This is needed
> for adding available memory to the LMB memory map, which is done as
> part of the initialisation sequence.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1:
> * Update the commit message to explain why this change is being done.
>
>  arch/sandbox/cpu/spl.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Please can you mention where this new function is called from, or add
the call into this patch?

Regards,
Simon

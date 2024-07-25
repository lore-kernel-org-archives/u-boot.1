Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B4EC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 14:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B795F882E6;
	Thu, 25 Jul 2024 16:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="duHdP9Ge";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5671881C3; Thu, 25 Jul 2024 16:03:00 +0200 (CEST)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 896AE86463
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 16:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2cb682fb0cdso694606a91.3
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 07:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721916177; x=1722520977; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T3sTTb/xr7OBJfSL4hM05dwAfqEd0eGvLxIc/feU4oo=;
 b=duHdP9GeuBjQRBoofOODUQvGWGruorHK+3ig8PHpxFYjTp8XNI8NwI+mW2w3TLfg/Y
 slV4TcLLlNkWvNoMmOszpbOkuQfKqbtp1N3tuo5u4EDrfIcnyXms3nAAOEOzqtbRyIx9
 1U9NCMBCi7adR8zPM/FB5g4EiSO2qfdqdfroo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721916177; x=1722520977;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T3sTTb/xr7OBJfSL4hM05dwAfqEd0eGvLxIc/feU4oo=;
 b=pXRfnoN4fbSbsEri1OjFH5mCcKbX5y8A5OKEKoU6s9yJ6tR1BDeFqNsDTV5mIOJuTB
 dG5JEKUQqi1LQ/NpHVjGgC1OSI07G4L+Yvv6WwmCWFRrZzWntQJ5Qs4WxknAXSDAPN0T
 zdqeWVrULfP7Wh9vVpraSxFqRB7r8nldKHXn1cyBpJgkVS4KDF4Pq6vOZPU9U8j9Xgzm
 SzvfmzEchV7EC7RoI8hmQ9EEvS/Y8TG3Ut7FnSHIwIVxLltO/YIebZMzfdRfE3JBTqhF
 sa2DMU330eaKBUdMELIXs9mjR52HWiAOoIdNd1BolsEWxerNOw/2Cxf+yi3JgNFYpsCE
 NFzQ==
X-Gm-Message-State: AOJu0YxjpOgGys1u3fqGt7p/42F+YXyZ1KHpQaN9PT/Gk4jw/HXF86Pp
 HYCV6ah5y3haeed8zRnW2R43Y04aIfX+grebwrfPN92nkVhj/BHwEsk7Xwi6POXiiGE8I4kmvqo
 k7C2/d5JJMAZVVRhiHrCpeD/30HZRKwT6JHK9
X-Google-Smtp-Source: AGHT+IGnNNULqQsdjBFSubt2kXJeJoUqOj8RmYruHvRVD6kqikDMuvIOEn2LVDVgKoiaHD89i+JqNEa/hiCDyqCAChs=
X-Received: by 2002:a17:90a:8812:b0:2c9:3526:630b with SMTP id
 98e67ed59e1d1-2cf2379ffb2mr3615822a91.13.1721916177091; Thu, 25 Jul 2024
 07:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240725095331.14245-1-Zhiqiang.Hou@nxp.com>
 <20240725095331.14245-2-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240725095331.14245-2-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 25 Jul 2024 08:02:44 -0600
Message-ID: <CAFLszTjSb97i2NeVYyNAzgZnRGHBomhnk=vJWFDWRepr4785dg@mail.gmail.com>
Subject: Re: [PATCHv2 1/9] cpu: add release_core callback
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com
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

On Thu, 25 Jul 2024 at 03:32, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Add a new callback release_core to the cpu_ops, which is used to
> release a CPU core to run baremetal or RTOS application on a SoC
> with multiple CPU cores.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V2:
>  - No change.
>
>  drivers/cpu/cpu-uclass.c | 10 ++++++++++
>  include/cpu.h            | 15 +++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

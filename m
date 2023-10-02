Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 396FCE784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5EC4286DA2;
	Mon,  2 Oct 2023 03:23:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fq0qberd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 155CB874DF; Mon,  2 Oct 2023 03:23:14 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1ACC8721E
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b1ebc80d0aso1895827666b.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209779; x=1696814579; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bVjQpAcISCnU0h8LQKvTtiKRnenCjuV1AzSzwF5RJDM=;
 b=fq0qberd4IvQTAszyPlD2gC49bsNkwu2Tgq7LepLAzXuSFLIlyykMxqqzgRi0fPW8I
 RTvOzs5+YylaRD6jQxnYBFyBa9QiKnA1HjCv6skWl8beHfvh7S4OyT0GmVg15VLGf+8C
 zHBnS6zFjDusazyTg6pysa9rL3n0nDEZXQVC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209779; x=1696814579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bVjQpAcISCnU0h8LQKvTtiKRnenCjuV1AzSzwF5RJDM=;
 b=VyaplhN3ycvX9ucHaOpK/+dyfst9m/8Jl9mpwkxh1Ut/qsSZb2z3LvlE2H2XgB8zuO
 62uSt1poxyYCxPZ5D8MMo9D9kr7SWS1ugNdWJLP9o/s0zxQmmUK6n0JyjiJMRCIe9URg
 fmQOBFpJF8xr3g2XQVPmK8aGJ14C2RAICFcaF3y7TiLkwWeF9kEmPbTMjUk9DeUqB/WQ
 KdSA/FV4Vk2hbtkCdJ0YbReoICvHczFxZnoDfkRcTpnq9BynqXrcPNZhhuJxRh6OCsXn
 o3j3xZdVBmnJaYhD3+RERxHHndg2XyIrlZH6//ohSMkVL9oA9TLWoJakB2Fb2wnAaXgV
 gziw==
X-Gm-Message-State: AOJu0YwtrzdaCbUkcKoOdmdrsBfDT1x5VP423M/zAgulbXhVv0f/HEhB
 ak0OzILDODdVh3ZEscUhKUoHjIZuUST6Va22NuoP6NMnOVLJQfYWgVw=
X-Google-Smtp-Source: AGHT+IFAwZgTwgYOys6D7Xn2n95RBQ4zz3CbFi5BLLhD1yMZXwT5HibDF4rI0XsH44GROE/WzA04pVPVrBv+HOsWCiE=
X-Received: by 2002:a17:906:9c9:b0:9ae:4f9e:7813 with SMTP id
 r9-20020a17090609c900b009ae4f9e7813mr7470763eje.73.1696209779522; Sun, 01 Oct
 2023 18:22:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230926065750.734440-1-takahiro.akashi@linaro.org>
 <20230926065750.734440-4-takahiro.akashi@linaro.org>
In-Reply-To: <20230926065750.734440-4-takahiro.akashi@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:17:12 -0600
Message-ID: <CAPnjgZ1RZKqzbDf4DFAy6gtLpp9dW3PAYEVSyx6ZFrScktpyKA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] firmware: scmi: support dummy channels for
 sandbox agent
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: trini@konsulko.com, etienne.carriere@st.com, u-boot@lists.denx.de
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

On Tue, 26 Sept 2023 at 00:58, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
>
> In sandbox scmi agent, channels are not used at all. But in this patch,
> dummy channels are supported in order to test protocol-specific channels.
>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
> v5
> * new commit
> ---
>  arch/sandbox/include/asm/scmi_test.h       | 13 ++++
>  drivers/firmware/scmi/sandbox-scmi_agent.c | 90 ++++++++++++++++++++++
>  2 files changed, 103 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

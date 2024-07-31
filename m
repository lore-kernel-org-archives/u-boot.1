Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 171EBC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:39:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2C4C988A05;
	Wed, 31 Jul 2024 16:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KaX+FwMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E4088A2A; Wed, 31 Jul 2024 16:38:55 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69DDC889DB
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:38:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6b7a0ef0e75so33311246d6.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436732; x=1723041532; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qwnYb6i5jVIJHT+m/bzGw/cP7M9g5Pe6pLE1o65Sf2Y=;
 b=KaX+FwMqbb4Rwjw9yWpEwErEj1v+whYjk2jvdvsgFGqkNnJegeERJz21Skb9wn5xqp
 a37Sa1tECUntPIpLGraw77tSwKrQu5P2+ol2BdH+6YV8TNQZ9zPPVf3hSI0SDseVaVKZ
 BtQBGRy8na1/sqUjWw44YwEBaqEmkqWuY1G3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436732; x=1723041532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qwnYb6i5jVIJHT+m/bzGw/cP7M9g5Pe6pLE1o65Sf2Y=;
 b=G3TcZDfyxHa+RuuX8Q+wBNmNPbzAHEUoiyUBjZswT9hIORwc4t2lorlu4L9nr7f1Ha
 WWF/AsoP3ilACvxVQ+RjC1mwaKQ0IYlmbKvlCVW0w+xhG4QyuymNBVRYPb1mM7kjj39k
 TgeQCF8uOxXfsllRNv6ofQaesmz3erw7sEtmCn0Wblzt4sdmTu+0jA1qAhTXKJvY6J9N
 RtcPe0ZhCfGGHETtsHCpezH4lpnNFvwNrIyabFPHEdQwp7KmD3hYK/2YOSU2hyfjuYMw
 NlocqSUDFt7SJIfGhB1f8lbpiimnx1uyFHN2Lb5MyIIRsM2txzDLnCwdtCqn79AJakZj
 2OSg==
X-Gm-Message-State: AOJu0YwsJSSIjlujpda0GxxX2Spl1bGz9YyXHTIuMOE+To2WZUWrtAhA
 6PeJTkpDgSJeFIoSQI2yWBM0JCY/jqjH4gDQ2oiViH2/3A3Sg/OErcKRWRHUR4Mfm1B+NhshqPs
 LMfW3pmSyjbaMrg8L6/o+7fiD6oQ0eC+auTgC
X-Google-Smtp-Source: AGHT+IEtvhf7OJTu4jrLTG/8p/8hbS6CKA3fkZmrFWQNwuH1wLPdZ1JWnlLTn/c32dzop3LEMWahRxyjd6kcusExFts=
X-Received: by 2002:a05:6214:1c43:b0:6b0:71c0:cbaa with SMTP id
 6a1803df08f44-6bb55a658dfmr190348856d6.33.1722436732355; Wed, 31 Jul 2024
 07:38:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240730073003.28892-1-Zhiqiang.Hou@nxp.com>
 <20240730073003.28892-13-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20240730073003.28892-13-Zhiqiang.Hou@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Jul 2024 08:38:41 -0600
Message-ID: <CAFLszTjJHHd7=5cMvRL6JqDffRxAAfZOsJN2E1PrQRVqLbR7Lw@mail.gmail.com>
Subject: Re: [PATCHv4 12/14] MAINTAINERS: add entry for cpu command
To: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com, 
 festevam@gmail.com, marex@denx.de, lukma@denx.de, seanga2@gmail.com, 
 xypron.glpk@gmx.de
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

On Tue, 30 Jul 2024 at 01:09, Zhiqiang Hou <Zhiqiang.Hou@nxp.com> wrote:
>
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> Added the original author Simon and myself.
>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> V4:
>  - No change.
>
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>


> diff --git a/MAINTAINERS b/MAINTAINERS
> index a6e47e8a21..f1aa802758 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -996,6 +996,13 @@ F: arch/m68k/
>  F:     doc/arch/m68k.rst
>  F:     drivers/watchdog/mcf_wdt.c
>
> +CPU
> +M:     Simon Glass <sjg@chromium.org>
> +M:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> +S:     Maintained
> +F:     cmd/cpu.c
> +F:     doc/usage/cpu.rst
> +
>  CYCLIC
>  M:     Stefan Roese <sr@denx.de>
>  S:     Maintained
> --
> 2.17.1
>

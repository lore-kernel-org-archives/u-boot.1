Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42649CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 09:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F20D8482E;
	Sat, 23 May 2026 11:31:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VWlJfvBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDBF84849; Sat, 23 May 2026 11:31:55 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 330BE8482E
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 11:31:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bd2d8bb1068so1580271966b.1
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 02:31:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779528713; cv=none;
 d=google.com; s=arc-20240605;
 b=QNvWbnE5x7Guj14L8GNBtNpqIp+ESzztPCQR2SiDWUkTm3w/TuWoXXqP/jdJi3CwI8
 bpRVDfwhpc31oPDHB1FdEvzVtT9AgVK304+cndQpTgBklmO13fwC1sJNMaBA2XFYHKsG
 T+yqiqxIePtxO9eKXBSsDQzUADTVg+Am/xBlWKG95AcGCzc1YshblJwSZcauWHtFr73M
 4eL5k41ckk78F1hjgcluxSf1mXC8+NKGv5bhBEu2ZpHwDVKuG/WA62fFvcn18y8MEr+7
 2mCL8CaU1v/eOjhEnICahQ6fHW292dNc8Tat2tT5fyzC7T0M7advLbd0U5HhATbk/Gvk
 j3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i9o/rPi6QLciYokF6Qx+26biEgiAkW2nTM2IOSJgxdM=;
 fh=sIWgUzLaCEnfakr9YZiC7EQow5S8NWuzTkJzQgLwaqo=;
 b=V24jpwPPXks+px4YCffPRk2o6AxLAwJxlklZ+yiykohREC2DiImBdbp/RAVlTcDRSE
 qi3ByBvpvR8lfXPha51+Ni3EwZpfpOlr7gyURH2MJaDbUAf65AG4h84z4tiqOLxTBJTh
 +azrFnTjitd5dI0dfwKQed9M0OvnRPjA4LEKrValT088IyIodwdIPEQH2ZBmrskui1tY
 tud39UizPLUA1PuyTPDA/pVyWwx6eX7OpBKjKvUjemshu8Ip+1cL5hBCRCL5zrJGF7jP
 pgE+tpvc5MlU5kywZ9zrWESnj+u7CpnBE/tJ1A6RR52qoop/KDulLFFkP/5R5+GuR1LU
 60Yw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779528713; x=1780133513; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i9o/rPi6QLciYokF6Qx+26biEgiAkW2nTM2IOSJgxdM=;
 b=VWlJfvBwWaF6ZZQ8OSiV/VUCqDJv2093Lwg1cW4fv1GdPFjWN3+hJ3uWBCCcRYaFav
 YqUfv3OllhD8QknQgrW/rVVkk7wY8zxVwL0BSv1nLwq12m+tpCuoJohh5c+o1FIM+G/g
 gK7/ZMJZ1RqxVPdnog8DT9ckBbfWcd5zwVoBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779528713; x=1780133513;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i9o/rPi6QLciYokF6Qx+26biEgiAkW2nTM2IOSJgxdM=;
 b=mOpY6QF3HrGT4WQuX5rFi/YJ8IUUy/fpX8oGTvJOY1VOeV1KnxlGzPYVo2/PeCgE9Q
 MBf6nJ3O0Nts+sDbkDnv7OeeXo6n9KhUoTj8zZyPFTbftfka0L8UDIStw1BRbvKyEsOU
 9UE5aM9MCIgvItFG4u9645+2iKXfTuBL6yNAy96x8Guk0qLP0DYe86mGvOsZp5nAZzPY
 N1j6kgBm2gQbqU2FfqV2Z6N9P6el8sMHQCfh1WaE4GQKHS5v+6xE7g2j8ZGqepJh4q8j
 7aaaiSMgd5d3fKNRMrA0QkjtSKCjPH+In8GnTVwhX2gEhMY9JgFCCeaP/oXpJPypWY3m
 ZM5g==
X-Gm-Message-State: AOJu0YxIjw6KvSW8ZA+Xn0GT1zUoIPvc8OTHEp7KRN0YZxPy/a+R6iEc
 1mJ4vUgekUgKzrflCU+V4xRRIGx96wAmyViI5tL+rEH+KNlvVkx6d/a7TgxoPWOpU0hGNE6MW8w
 L0ZlSNvB0LDOpoBIe3og9lamhn0epP9bmmd+axo4OajtywkEwcNI=
X-Gm-Gg: Acq92OEobGJFc+VQ0jhtMNPDcXQhW+EEtFaetc/1N2qWUxGuBtqlRQpyeMgIdvDZgWb
 JmAvirLjWjO4ySI7Mo3kMrfOX7+7daOgMf/UP3bmGofJMeButL1CHHg4CdQqSCtcbprj7UrbgXU
 08OGTkaPgzssNdp1N02vI3LkKGsTT8Q1/fypBcLqz4jhN17+y+v54cYcDuG31OztI+fZjZoxnO2
 IqtfKi6QZVy1oM5Mqg2IV32TrWsCS+5SckYkh004WlEb6b2iWkUYecN9PRHMVEXvTSJKYhtPV84
 tu4eAg==
X-Received: by 2002:a17:907:761b:b0:bd9:a087:730d with SMTP id
 a640c23a62f3a-bdd25136a3amr320817666b.8.1779528712585; Sat, 23 May 2026
 02:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB280511C6E8C0E257362BD50ADA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB280511C6E8C0E257362BD50ADA0E2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 23 May 2026 03:31:39 -0600
X-Gm-Features: AVHnY4KEnaIIDu4JVtngE0sdFnK1BPr880eLr-ZWNhotrWRzAiuUQWXtH-jlI6s
Message-ID: <CAFLszTivbt4fAEWUMM01g5xckfgeJkYNUhMoAj02fyRfMEJ9EQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: gpio: Fix dev_read_addr error check
To: fberder@outlook.fr
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-21T17:50:48, Francois Berder <fberder@outlook.fr> wrote:
> drivers: gpio: Fix dev_read_addr error check
>
> dev_read_addr returns FDT_ADDR_T_NONE (-1) in case of error
> and not 0.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
>
> drivers/gpio/gpio-fxl6408.c | 2 +-
>  drivers/gpio/pca953x_gpio.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

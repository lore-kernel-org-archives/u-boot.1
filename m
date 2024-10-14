Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1B8D18129
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4934E89166;
	Mon, 14 Oct 2024 17:50:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kTMR58Sq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102B788936; Mon, 14 Oct 2024 17:50:57 +0200 (CEST)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFC2E89166
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b10e800ba9so449182085a.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921051; x=1729525851; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=t+xQ/s9CIoLPB9hzJq3G085nEes8EjnPYS8sb0pVusE=;
 b=kTMR58Sqp03xoT+CvcEqUAScTdR+GjQjETAnFehcbUUY6aeMfWmOch4rfAMA93HFcU
 YHxm6bbHuCofNoPWCkydbE2m2EvVL1XDGQxNb2RvDpOgn/m+W0sbyL6OvA/BkoWIAgpR
 I+ihSRWpQOOjgDzDpi25NJRxUzxUelE8Ur9F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921051; x=1729525851;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t+xQ/s9CIoLPB9hzJq3G085nEes8EjnPYS8sb0pVusE=;
 b=ABGViiFZGR4qSQNxoNwYC/9AFfPTD99sG9ErwfSvEWxSPBryAdmEgNCKXH7CVWrtdu
 oPc1NCDAn5rkaEW4YIMIYgNIEFIzeC6rqmK4U1NhPi9TLBsUlO/L+YaJnqtrGXH5yAfk
 HS04ar0AomoW5S00FOFKqwx5CFr5A91x4ca4S79+fjGApLgJP2GvIoIhA1EZVdtlTMJy
 7UDbR8Tgf9mVhcy8qQO0kbXr5IyzNlHVbBtQNUMuRXrapQwSKdmz0L7Mys4DkDiSNYGs
 bqH0mQwNnfUAGX5/s8luSaW18RfCGsx6TK4COrzW71uVBfhYPQX9ZFiYJ7ZP2wOphjFA
 M4tQ==
X-Gm-Message-State: AOJu0YwTsKH1vQHUr+hjpci0SoxALNlhU7vhnLWhHIFVRsfvTToU/8kq
 +h/oTspXkj1H68WQmpXZsXcju1wnlj6Mem7LNdBVJqCQmpmKOSTVDw+03CyR83pgD1t9xkZID7B
 htNf1kNLfNFazm6B7AJ2nPfAXeqW0cKhWu25d
X-Google-Smtp-Source: AGHT+IEmzNq5d2PzavBmKNvzP/1JQzp50p5rtPbiIH/1sJBOXyPmVHHCObjqwoV/qt0KUXLAtPKzT97Ru61Jmwg4o3k=
X-Received: by 2002:a05:6214:5d11:b0:6cb:c832:7f9b with SMTP id
 6a1803df08f44-6cbefb161e7mr216293036d6.17.1728921051212; Mon, 14 Oct 2024
 08:50:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-6-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-6-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:40 -0600
Message-ID: <CAFLszTiXfogDMQCkGiy-136ZSbdcefE0-HNNjqeowLjAnGMJvQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/15] add a function to check if an address is in RAM
 memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a function to check if a given address falls within the RAM
> address used by U-Boot. This will be used to notify other modules if
> the address gets allocated, so as to not get re-allocated by some
> other module.

Can you be a bit more specific about this one? Why is it a weak
function? Also, can you please add it to init.h with a full function
comment?

>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2: None
>
>  common/board_r.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/common/board_r.c b/common/board_r.c
> index 1acad069d9..4694f49a43 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -73,6 +73,11 @@ DECLARE_GLOBAL_DATA_PTR;
>
>  ulong monitor_flash_len;
>
> +__weak bool __maybe_unused is_addr_in_ram(uintptr_t addr)

ulong in U-Boot, please avoid uintptr_t as it is confusing for people
to see both

> +{
> +       return addr >= gd->ram_base && addr <= gd->ram_top;
> +}
> +
>  __weak int board_flash_wp_on(void)
>  {
>         /*
> --
> 2.34.1
>

Regards,
Simon

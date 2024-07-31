Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921DCC3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 07:26:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8DD8896A;
	Wed, 31 Jul 2024 09:26:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xZ8e0DhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3A488971; Wed, 31 Jul 2024 09:26:39 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF1BF88886
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 09:26:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-7a1843b4cdbso3185554a12.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722410796; x=1723015596; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=09VhW05DzH3WeGPvfKlQcWciTF7gJzwItl4+rk+HoOk=;
 b=xZ8e0DhXBues2DOOzRejBKF2eyuyAHFCz3SMzBHznvSVj10kCgWa1gBaEtxFrRxC+D
 dJI3GkzxBVgCb5n84tEgG5eHgIuHGXw3cT6PKncNMo+g6H0J5kimcvZY6tGUxrDh8I8O
 qqC+ry7bgqhJoGpmqc6NQAfl5Rfr2avs31VLJxDlM1lIqYFZ36h5Kg5JgAKGXsROi9pP
 Fat4OVFP0L0fABtiSDIAKnsyRdWQ37zfApTLFOZgbCm0viNcHA0MAWRMcyPh1zDPkz0Z
 KItqsgkrlFjg9An24NuJAiyNWRsLKLo7e1SBzRkFvu89+vG/att2Ssfs8a6CLloPF5uq
 ljhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722410796; x=1723015596;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09VhW05DzH3WeGPvfKlQcWciTF7gJzwItl4+rk+HoOk=;
 b=f5QYSIg/CwoUOYIEhb/6JgU7+dOMkgG9yd0yi75yk9EctJ7cLyahc/dZgAKkyjShOy
 jW3+8PW2dZOJQFPux7w22G0jT2p9aXCj8QYZudjLhEyRqEL2MrEpAtOVdd82n5CJ2s/z
 oUyBKtKzgcx+dzbhIlJX3FnlGJ2rSeb6kvsHTdXJZFYVixj7fYiPWoOhUAKJEBeb+aun
 gOzjWQllxQPXLeoS1G24Gxplo5XZ8jQ7+pyqYqz5OTsg3q472UcpqMc2JqLC5gQ5YGtZ
 SHFKXOSeiDr8wlsroQLC5sKVk0sSipLaQ7hNpkD6HcF2QbDsmNlomemJgiPLYMuasFd+
 OZ7g==
X-Gm-Message-State: AOJu0Yyh2fv1emZwsX39fbtaIMS8YrlYwnRUU4Xb3ASDM84s1+X72lBX
 1FQDfbXvYdb01S7j9CqGuRUPnTTDjuSgOb9sUFzJ8ISKQLv3Q4nOjyUMNzIRkcT8b44LYYEG/Gc
 p23tgsLD+SP0WtC/IjPt7kDNj91vhcYJHQfJflQ==
X-Google-Smtp-Source: AGHT+IGvW+a/6aX49reBJ3ckgNEqdg+W2MQdOodVhCGEH8fkzN6ldg9fH+D4+Hoy4veukc0UynrDBO/l91kWMnULvAE=
X-Received: by 2002:a05:6a20:729d:b0:1c4:7a11:9ef1 with SMTP id
 adf61e73a8af0-1c4a12c4321mr13061559637.15.1722410796186; Wed, 31 Jul 2024
 00:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
In-Reply-To: <20240730111132.1097315-1-sughosh.ganu@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 31 Jul 2024 10:25:59 +0300
Message-ID: <CAC_iWjJU2eq-O6Z+fJ4RK0KCbWP-DKo4gHjZSb0u9N0B1_3MKg@mail.gmail.com>
Subject: Re: [PATCH 1/5] linux: list: add a function to count list nodes
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>
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

On Tue, 30 Jul 2024 at 14:11, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Add a function to count the nodes of a list.
>
> Taken from linux 6.11-rc1 tag commit 8400291e289e.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
>  include/linux/list.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/linux/list.h b/include/linux/list.h
> index 6910721c00..0f9d939b05 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -547,6 +547,21 @@ static inline void list_splice_tail_init(struct list_head *list,
>              &pos->member != (head);                                    \
>              pos = n, n = list_entry(n->member.prev, typeof(*n), member))
>
> +/**
> + * list_count_nodes - count nodes in the list
> + * @head:      the head for your list.
> + */
> +static inline size_t list_count_nodes(struct list_head *head)
> +{
> +       struct list_head *pos;
> +       size_t count = 0;
> +
> +       list_for_each(pos, head)
> +               count++;
> +
> +       return count;
> +}
> +
>  /*
>   * Double linked lists with a single pointer list head.
>   * Mostly useful for hash tables where the two pointer list head is
> --
> 2.34.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

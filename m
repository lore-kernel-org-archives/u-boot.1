Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F1BD1AD59
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 13:34:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C01F88D8D;
	Wed, 16 Oct 2024 15:34:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lh2zHzzb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78FF888B70; Wed, 16 Oct 2024 15:34:45 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3115C88D82
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 15:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so53771045ad.0
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729085682; x=1729690482; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCKUE9Q8R+n25aTYS+L0lymNmknzm4czu0v8pkPSG2Y=;
 b=lh2zHzzbp8yEkM9+yDktsRjfzWEq/i9XFVHJTPlom6OAjGH7MJeu6bDGDOKHi7qcTz
 X4b0RaKC8Tenl6uedrrB9YUe9Bdsv1wlvCxdYRNnlWLXZInddFUYQPCRUl3m6hkb0pU4
 KcMJ1VAnik4PC0YHXunvDq+ZySnS+DDtli8ZL0e7vs5R4P4EmH8UyXThSqOwkNYcQHYt
 DLk0fbJ7pPTfYz+QyXpwl1qbGCNFjcJiFZXHilMixzb13CYtKnvlKijIo4wWU1vdKjC8
 SlcrjA9WRzAVwLCC4BJZFwy6+IP39CoHe600i7Y6dCYq4tXlJOQzZWpsvYQZR6GrgFKy
 qhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729085682; x=1729690482;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCKUE9Q8R+n25aTYS+L0lymNmknzm4czu0v8pkPSG2Y=;
 b=mwt6CjpB5OIr8LYDtVKQheniHiT+A+Tsm7ow5kdSRuAoRiE06+lq0k9PXCoz4hjCPR
 0Vp33G5IowpDO2UakeGwD3B1AWvx4GhEttIiRMAbv/u4jWu+6nVSMKj4AE61Z1N068SL
 KxR0EXSRx7CBBj3ZkXuqFo7i1AnLQj/7AWId/6j7b95gNr7RMbBczmu2lyfNIllJEzlM
 b1tn3kG5pwwDSyZPC/icGyYQV3pg47LAQMGKsZ7ZEJx8v+L3KG7o1QjWfP4zLvHXCoet
 /lCzCO50Rc95o5qWUKeaOcW9pfxfBviiq/otIiaNTTJix7ZMJT75OYX3FZEK0IYurhh2
 yhTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVggUJ7HI+kGzpIuos0gpF16S5Knl9u3OcAZXF4xN5svPw4CaKtA6OGmp3xIFOlw0ikVRO1geE=@lists.denx.de
X-Gm-Message-State: AOJu0YwZHJcDh3wpxgLXTzdwnUcyzDy+CoH83crWnNGNk1i1w1F+mLqV
 1BjiaJAGfY9HtnT1IwMwomaKVXCCTXS/JoZib+C3P2pC6Lxr1cgccseMqpBNv1HnfTDITGf8EUE
 ziGp5M5GESBpjRMNlBAH1x0W+AZhU72RHLUMCcQ==
X-Google-Smtp-Source: AGHT+IHAj0yjUXdap6+RJC8k5VpSzoOUWCzl34RbX12v5iAV0fXPhDog36PfKmydhNqN2z3Yp7UcJl4EyPmera1LW3I=
X-Received: by 2002:a17:902:f60a:b0:20c:8cc4:cf1b with SMTP id
 d9443c01a7336-20cbb230570mr244729625ad.43.1729085681693; Wed, 16 Oct 2024
 06:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20241016095039.43106-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241016095039.43106-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Oct 2024 16:34:05 +0300
Message-ID: <CAC_iWjJTee37GjDWaGZ-xxoUwG3MHS1RqnBFMPx2gcEXOQ4u8w@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: wget: CONFIG_CMD_WGET must depend on
 CONFIG_CMD_NET
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Wed, 16 Oct 2024 at 12:50, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> do_wget is defined in cmd/net.c.
> cmd/net.c is not compiled if CONFIG_CMD_NET=n.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  cmd/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 37894eb80d6..049a672100f 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2010,6 +2010,7 @@ config SYS_DISABLE_AUTOLOAD
>
>  config CMD_WGET
>         bool "wget"
> +       depends on CMD_NET
>         select PROT_TCP
>         default y if SANDBOX
>         help
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

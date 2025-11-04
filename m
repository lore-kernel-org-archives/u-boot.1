Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27223CCFA04
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 18:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71FB8004F;
	Tue,  4 Nov 2025 19:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNE+2dBw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130198389A; Tue,  4 Nov 2025 19:04:22 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 249188003E
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 19:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57bd04f2e84so6964281e87.1
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 10:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762279459; x=1762884259; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UJP7aHmBxASxUIo2QFWkutUin2dndx9QdMb1Ut7uLlw=;
 b=BNE+2dBwzA2m/fdRW7b26Z8ej5vaj1eIhuUHGtHfWQkmqIpZs6vuli8HCBBud1nlxd
 2X3W5UIFz5SmRg8fTu01You6fkTyl0di7SqjKuzwFSpJU0Yy0RLhCi/dsJpghCIvHkee
 saBBs+eYmCrmI9pEUjqCbVjsWXsjEU2nxfHQ7HbfA4aWNZURkWtDBrqxTw9Ww2LnX6j8
 qZD9fQ5KBJkc1FjWf0wK5pQe6kBTwdISgt8/MlsvtKLVEIlGK4pNjheZuW14jifpfWLA
 ftwOFCFvHxDwxTO2bdSlqfR3bA+d3NPpC9zgLFsWeQe4wIx0JwrYc/p620s/qGRzsX7n
 JaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762279459; x=1762884259;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJP7aHmBxASxUIo2QFWkutUin2dndx9QdMb1Ut7uLlw=;
 b=vEvAcHupYzyi+cXNDdmUBS84wX4lZyBkVzh3FNMqvu9QO2GsKAVYRCNgc8swodu8wq
 Shb4aJwEi0jXmaCZI8Z2vPSWrhICFchRMBTcMKILra89nSaYk6y6TTL8LZx+qwqwG02K
 EkT51v7Tmiu5VmTowt1REtR37T/1BsbIrrEMAVckF3NkdFn6maMJEBLw4Hh3wKjXsbxW
 WfWmjxwIK18Z7MUYD42Is180btnEwxZ9rMZ9hSizxRvYNsjNphnkjQVvISUHL4qk4LKS
 NU3daHTSwSQuy9neJT2IbI7DCcUm0gyK2PVTXU1Bwz31FjRJtbqvXNPvkpF3E6VcMzxO
 lnhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ/m7Hnfteywghc2i3I6RXKgCbWFr6Fqo+4JPBZ0vh58dcnBQ9t6Vk71IwlZ8tykkyhbzaGeg=@lists.denx.de
X-Gm-Message-State: AOJu0Yzq+yyxtWqNOPzF1AEuL/n7bh9ghV4GkWFMJHffUdNB9xsfAm7o
 Gx35GT3omsz3wzYa97VI9l8jpDt6zSKZqichbUdco9maGfVzOAHixgs3kWZzdM/MHF10usr5fKY
 +TTX67VgKJYXvuxPO41a24XRmT2vxTipTy7Jk
X-Gm-Gg: ASbGncvyLwn6ae9GZoxRq9/3jHeUwOBFcbLzGtbXO6OiZ4ktuwK/FF84wRs3cNsEgT+
 7LIulVe2i/SOX4ifDwJP0IdkagmoC0SB6gkRKQTcX7b7bvwt+HikLBjsUzvQcsuuRDku1pxNL6p
 5l7ztiSfEJRJ6z5HvQi4LLXhIP2DqVWRy2XE5LYcA1HQWTiJ5KWXcMQOJ1LKmuqPF9bGINmxDWT
 TjUSSHMw6tjlr8U4a2kmKWtGfeJIz58nQPMsGuc2IvTTUg7MBWJD5LqCmCO1NLluUylzeW9tAe2
 kjgbN5Uk5hdHwfAw
X-Google-Smtp-Source: AGHT+IFPNx79J55hKlB/k+yoTL46a5Asf8Sovn/bF7wNG3BaFeXeafdbpBrXgl0d4TJ9sB7NgKejm1QkAhi0M5pO7jg=
X-Received: by 2002:a05:6512:2248:b0:594:2b8f:3b4 with SMTP id
 2adb3069b0e04-5943d7c3817mr11545e87.30.1762279459221; Tue, 04 Nov 2025
 10:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20251031083904.34273-1-francesco@dolcini.it>
In-Reply-To: <20251031083904.34273-1-francesco@dolcini.it>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 4 Nov 2025 15:04:06 -0300
X-Gm-Features: AWmQ_bmO7sMGRyjHPwS-t1cKUcX1DyLWCNYAtvFa61Qs4SFX9r7e_k35K3Kdfgk
Message-ID: <CAOMZO5CFXOuRjRd0vhvqvzJCKq8n+Ggc2THG6AASRsodEZC5Wg@mail.gmail.com>
Subject: Re: [PATCH v1] configs: toradex-smarc-imx95: enable USB Gadget OS
 Descriptors for fastboot
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Oct 31, 2025 at 5:39=E2=80=AFAM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> USB OS Descriptors are used to install and configure the device without
> requiring any user interaction on OS which support them (e.g. Windows).
> Enable them in order to improve the user experience when fastboot is used=
.
>
> Fixes: ff0540fcfe49 ("board: toradex: add Toradex SMARC iMX95")
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Applied, thanks.

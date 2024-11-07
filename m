Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0271D5AE79
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:53:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 60D758922D;
	Thu,  7 Nov 2024 10:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KSEmX6sK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 522B889032; Thu,  7 Nov 2024 10:53:23 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2972A8922D
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-720d14c8dbfso571294b3a.0
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730973199; x=1731577999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cmsmz/Cst6CeFq9T9E/Gg0CrK7L5C25lm0armip4nwc=;
 b=KSEmX6sKmcUqLGXny/x3L+fcEN4vPYIrL7aGsoktEwSTf65LoAB+u/TZCWYtHKTFu/
 WU3qxKQn+60xCek2nYCTdObgOXAwiQnl8ex6HcLedVmTOVP72apuJ0RssAibED8Vrr5y
 NYkpvu5PGuPie+2dHB+dDGeoxqQzsuFUQ7lK983LrcmitKZA8zfI7LeWbOJt9cCO5Xz2
 C+njwvmN6HG1Bd0mWaXJcFodNBKbAbfs9JLyQBNYxPEOUb3xd/KB/3sWyZ3LUJngGgBU
 HTY/f3Nv5YYct2mm7oQQQx9diBJbVW6Wru8LgFmBPv7yQG7DpmUj4csBk4V6bt5EALhO
 rPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973199; x=1731577999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cmsmz/Cst6CeFq9T9E/Gg0CrK7L5C25lm0armip4nwc=;
 b=n7X2FFr5fdLvIsHcIq5xwq3Fd1OGlqLalxPD7wFfNevVZ/38GokKsaG/UqYAF17cRc
 9Dw47P5AsBH2AvOJrqsa8hC3sjThNEml1kFEhFLuot5nJz8rGdUAov68ZaF8i5Fr7I8a
 nQDxQfuw1CfuHe6L4vexa6quwgHsqih4MCRdSlP+ApGm5w6brUCt7bX/+z7Bo5nUm8T+
 iOA9QTZscYpQvJsAJuEC6OZlzCAfDxxiOyNPHOln6Jq8Nh9/pmkJpB89r0eP2+r77WKz
 T65pc2oqrZQ4T8nGeiRflZZAK+W1nXjN950hqgbw6RFuyEF4X4Q0emj9PtzV4xqUKWTV
 kULQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXa/1SS1Z74bo9KcdWnhy+OcPpHuuUAmsn8YvOURHJwRsDgvvV0z8RLPy7oMZqyHY1vi7IDH1I=@lists.denx.de
X-Gm-Message-State: AOJu0YyQy+cw61WK+W5QX6sfLR32tqxfN/R0tUvAeqITQWvG7svJXYbG
 E9+lvq1EpdM85QtwjzBdqlM8KY0nwSOj9MDeIusDuHi1O+TgEWXPzzrmpMhe/OMrLa0sG+J/Zf1
 n38ZwPgL3NqUrlsgOFPk1uNhHzvzwsXf+9uvXgw==
X-Google-Smtp-Source: AGHT+IFblGr0fVqKIPwdoqfACKw420bIOgXLJJ6UqvyTWBXsk1Y6Ik97JKtejCsuhS/oG1qF5Q9ddzuMJqbDKQPFwHU=
X-Received: by 2002:a05:6a20:ce44:b0:1d9:76a3:634 with SMTP id
 adf61e73a8af0-1dc17c4ee96mr675719637.42.1730973199630; Thu, 07 Nov 2024
 01:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20241103224223.195255-1-heinrich.schuchardt@canonical.com>
 <20241103224223.195255-5-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103224223.195255-5-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:52:43 +0000
Message-ID: <CAC_iWjL27pvqYPALD39RUd=HqsXE7q4+mxM8J5BrVAKLj=JFTg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] configs: enable UNIT_TEST on qemu_arm_defconfig
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
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

On Sun, 3 Nov 2024 at 22:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
> this in our CI because we never ran any of our C unit tests on 32-bit.
>
> Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         no change
> ---
>  configs/qemu_arm_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index d042aea49bb..cc4f4540fd5 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -67,3 +67,4 @@ CONFIG_TPM2_MMIO=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_PCI=y
>  CONFIG_TPM=y
> +CONFIG_UNIT_TEST=y
> --
> 2.45.2
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

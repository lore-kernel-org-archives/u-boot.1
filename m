Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70624C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 07:15:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331138070C;
	Tue, 10 Jun 2025 09:15:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CXLutmxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A2A80C83; Tue, 10 Jun 2025 09:15:04 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DF02805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 09:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7086dcab64bso42257067b3.1
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 00:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749539701; x=1750144501; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IGvaL8ODk4Zk6VDdVvCqjd4EBnhpEV+8NMGCW+qkbl4=;
 b=CXLutmxuO7GWMas456M5x6DCvKD7/8icHnAZWYz6tRLM/8Hw9Y3BN+wKC+Srdg4gaR
 RLViAW/1TonXNlJHzMxWbUXnzcghEdwv5WYTe8lCi2nu771turZiEMm4dQNDBgqEnuiE
 zIKxu+x9iMqLGcN2+VEjfQfTGyqyL5pCqxXCNI/gc9JS/JfEvnw7fC9QbW+3iCA4Emx0
 iuc0IKp1uJSKRnu8keL8kaehyBw6j0//DMGarERQhhKIC8q8jpT7QjW+5+okLVwyVHAm
 0aj5Pv0Rayv/bsvClVw7YfB6v+A16FHbDWzNksuie1+fd3Y0UL8aVZz7aUyPC1tnR1G/
 W4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749539701; x=1750144501;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IGvaL8ODk4Zk6VDdVvCqjd4EBnhpEV+8NMGCW+qkbl4=;
 b=dyN/wLOeFXDnpbpqaTWp+hGnxDjeON9IsL4ib0Cujq6J5tuzELbR1j48eCKmtETgjj
 BCSLOG7YEEMiWJrUQ+h2vGs9MxO8YFmSTr3makevqX/v5SBgQmZ9LJypnaKHvGdoybZy
 fjOEVo72bjnRstnHkIKwzxoRlg9EraYprlLAhh9BaliTMBBL7F4AxmAomQn0je8/o72H
 KRPFmwHM2FU0Eg7ZcJwPn3R6tF9xQZP/8E/o/LOsaMJHsghDpFcSMJU0Krp+L9M+0R+h
 AiI7Lv5wBHzqLhKE8MU6quLzBy48a/nE5lXvdw9cuaPDWKwLMfKO1iKPBRI6ejkPP8g8
 DwIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnWOesddo0HJ/bbvTkE6BEg7zfKcs507iKil+bv2CJpkf9ok4QZEMassDYRn5cdb6eodlPdCE=@lists.denx.de
X-Gm-Message-State: AOJu0YwpTRRvp3MpyPexpqfAFVRj9lkT0ojP9ePolI4jFgNo3kwVHqsI
 jMLX8DCxSVmzu3oAbSisyiIbEN0jUlbse5Ygm2xtb+DazEqaNV9jw5W/a516RsT1KjpAUHqd6l3
 +fBs/mbkmz9ilWlvDGBoGflTD1cn+kVp1IKplYJVKNA==
X-Gm-Gg: ASbGncusYCh1zWElI5RVbiKc3QHKEcCo4f06yzfKOEzfcPA8KSB1xmk3uR3yHYnr5Nd
 7q8IJnK3Ad00likUGeGyhfjxDAAE7X3u3yKsT2U1Pric04mRhpwTfTbri94wrCw+/0LX2zrmjn3
 LlCRQc/9JIDvhVwP3PpOfCp6BF1zM9QOIUlmQW47cxva1C
X-Google-Smtp-Source: AGHT+IHBBNPwPXQSDs9MKalZwtgXGdXR/q6qVV5o26C8bqxy6LU729SKyhoKRXwws0+iZ+IIRAXKqp6DIdW6XlIsRJI=
X-Received: by 2002:a05:690c:4911:b0:70d:ffaf:48df with SMTP id
 00721157ae682-710f7667ec1mr219090037b3.3.1749539700962; Tue, 10 Jun 2025
 00:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250608074228.12407-1-heinrich.schuchardt@canonical.com>
 <20250608074228.12407-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250608074228.12407-3-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 10 Jun 2025 10:14:25 +0300
X-Gm-Features: AX0GCFuQww2F4V0EYwGGfy2zNF12oP58y_s5Bsb_hnOQRrfk68YXHKP7-YMMhJc
Message-ID: <CAC_iWjKFRqgzmn4ubuRAqL7t+gj2T=TEazzAk6PXWTw+qsedEQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] cmd: remove duplicate DHCPv6 Kconfig definitions
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Michal Simek <michal.simek@amd.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, Sean Edmond <seanedmond@microsoft.com>,
 Casey Connolly <casey.connolly@linaro.org>, Bryan Brattlof <bb@ti.com>,
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

On Sun, 8 Jun 2025 at 10:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Remove duplicate definition of
>
> * DHCP6_PXE_CLIENTARCH
> * DHCP6_PXE_DHCP_OPTION
> * DHCP6_ENTERPRISE_ID
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  cmd/Kconfig | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index ed741d43cea..c335eceea63 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -2004,23 +2004,6 @@ config BOOTP_RANDOM_XID
>           Selecting this will allow for a random transaction ID to get
>           selected for each BOOTP/DHCPv4 exchange.
>
> -if CMD_DHCP6
> -
> -config DHCP6_PXE_CLIENTARCH
> -       hex
> -       default 0x16 if ARM64
> -       default 0x15 if ARM
> -       default 0xFF
> -
> -config DHCP6_PXE_DHCP_OPTION
> -       bool "Request & store 'pxe_configfile' from DHCP6 server"
> -
> -config DHCP6_ENTERPRISE_ID
> -       int "Enterprise ID to send in DHCPv6 Vendor Class Option"
> -       default 0
> -
> -endif
> -
>  config CMD_TFTPPUT
>         bool "tftp put"
>         depends on CMD_TFTPBOOT
> --
> 2.48.1
>

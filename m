Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6805EC282EC
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5BC78141D;
	Tue, 11 Mar 2025 14:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="imMURofs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5742B8164E; Tue, 11 Mar 2025 14:44:59 +0100 (CET)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F3F801BE
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 14:44:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-e5ad75ca787so4572581276.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 06:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741700696; x=1742305496; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MvL8C00WJcdLVpSZ/3Tn3CBzZAP5gZa4Hxjqv9GxczQ=;
 b=imMURofsQ7MorI2K+He6KnDH5qAp8ZnVGOCSFVq7su8oohL/f4Crkg3QdbGbnvpZB3
 uHaKJzHn6BQyyJb0NVuq9xNZlrkEgf7qNQ33eEXZyoGPPFdxVDQa9hN8nm2oP5zv2wJz
 XAjBX3M5SnHySyzenqKrNAquinbgE7lQpB9mai1CaGI/GhZ87zvwvntKUHRcCNDo7PSR
 P1ADDXOlp3OBk6L/lObUKKr9vf8Mfq8wk6OQARKw0igRevMe7ftuK8pwKn1x3epliZQg
 uImp5SPKCIcwbLZwPzTMUr3DmVFgNv6MAuU+4fos6rXwdmoIMEJYXl6FYsZ5lSc1ZfCO
 Ek7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741700696; x=1742305496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MvL8C00WJcdLVpSZ/3Tn3CBzZAP5gZa4Hxjqv9GxczQ=;
 b=fNkUbLhgNHlZrp6HDD9fUe97vZvpX51pvamQFALrPQ39LUO2luV8IynFOdC5rZsA5X
 QfI7rr8PAtWKNlf7uyTzAOiYETXJChOegK4/qcyib6IiHShn4txON3TXhNXZbiPWDhxW
 rz30t/2fO1Ztwdla9syvrYC0DomueUkZJ+rjBcBMND+N6paHdNp9QCkNNvuqUM/Fzka9
 zhPRxHZvBRouF9PjRY8PVd5QVbZwH1HmGE6WWXgSOE9GPp3kNlb902WsaK8YaKpbfGIj
 XEKSIM7jLDgYiX3UWcnKQ6Iut3pA5spDPOBu8GQekOZfRg2f4rIYn2SH3QJ+HAVc2B7s
 IdNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXceuE1mq5Ns3gIqQkd2hy6VQDhzk9MyR3ej71xh3gtV8k6JchS+giaGJ6bO/9CN6/hgqWKjFM=@lists.denx.de
X-Gm-Message-State: AOJu0YyVTN68jJLaGSeH1tejdUnB3syMk7ullG0ASKXLWN7t68IWpw+m
 fLx1GNF18i2eYEVNJ2M5o2m8xAV+SZYybpdjs/D+fbXP3x+SrhreUOUE32WJ3yX8XSm6xRAQAif
 NNJSG0f2HOBeq+XoOqGfIK3UvoAnw0TMrwYas6gzix9M53UISi3w=
X-Gm-Gg: ASbGncsDCCOsqvIFWOYu6q3YJSDths9ftrXKz6+qecsTn2Ritltnfn2eL79Qi0dD2/0
 1nKFOwzmWpiipAyTB5rljpzt4/at5LqOMHOqA0Zq8YfluZIq10t7O3ugSQ9uDbyo2XqS7pKV3Iw
 Wh3WR5V9OHbR4F0rfwNNZdMemVScJvCxeODRnJCg==
X-Google-Smtp-Source: AGHT+IFm8lT5AxMPy01VRKPwalwK0SQxOIzZZYPtC+7U5ATmBq1JRN8bOwJ+mjwedo2LTF9qRvh80alR+yEJw9J2qYI=
X-Received: by 2002:a05:6902:11c4:b0:e5d:f98f:6f33 with SMTP id
 3f1490d57ef6-e63b515218dmr4977378276.10.1741700695854; Tue, 11 Mar 2025
 06:44:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250310061343.26208-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250310061343.26208-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 11 Mar 2025 15:44:20 +0200
X-Gm-Features: AQ5f1JoTiQNnyJ8esBdqNNy0kBFlBRpcUfGvmEKej5xz_UxwqkM7WsPua8nsEsg
Message-ID: <CAC_iWj+brdTHCMrYUd9nMOymgOzm28XikYM3GuKT=ZyCQTXF-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] cmd: simplify eficonfig_init()
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>, Daniel Golle <daniel@makrotopia.org>,
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

On Mon, 10 Mar 2025 at 08:13, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> As the system table already has pointers to the Simple Text Input and
> Output Protocols we can directly use these instead of calling
> OpenProtocol.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         remove unused variable handler
> ---
>  cmd/eficonfig.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
>
> diff --git a/cmd/eficonfig.c b/cmd/eficonfig.c
> index e08b6ba4a5d..629bf1b82c7 100644
> --- a/cmd/eficonfig.c
> +++ b/cmd/eficonfig.c
> @@ -2283,26 +2283,11 @@ static efi_status_t eficonfig_init(void)
>  {
>         efi_status_t ret = EFI_SUCCESS;
>         static bool init;
> -       struct efi_handler *handler;
>         unsigned long columns, rows;
>
>         if (!init) {
> -               ret = efi_search_protocol(efi_root, &efi_guid_text_input_protocol, &handler);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> -
> -               ret = efi_protocol_open(handler, (void **)&cin, efi_root, NULL,
> -                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> -               ret = efi_search_protocol(efi_root, &efi_guid_text_output_protocol, &handler);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> -
> -               ret = efi_protocol_open(handler, (void **)&cout, efi_root, NULL,
> -                                       EFI_OPEN_PROTOCOL_GET_PROTOCOL);
> -               if (ret != EFI_SUCCESS)
> -                       return ret;
> +               cout = systab.con_out;
> +               cin = systab.con_in;
>
>                 cout->query_mode(cout, cout->mode->mode, &columns, &rows);
>                 avail_row = rows - (EFICONFIG_MENU_HEADER_ROW_NUM +
> --
> 2.48.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

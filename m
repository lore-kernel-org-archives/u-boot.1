Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E541C2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 05:35:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D0281F66;
	Mon, 19 May 2025 07:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tFriNYzD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A38E81FFC; Mon, 19 May 2025 07:35:15 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FA7A803DF
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 07:35:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7053f85f059so32488697b3.2
 for <u-boot@lists.denx.de>; Sun, 18 May 2025 22:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747632912; x=1748237712; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F1Fw+Vzj8ovZb3V20iOH4C3yqA2FSTifYSD+4Ytkf5E=;
 b=tFriNYzDyXYTJA7na2C5eBHjkGMz9dH3QpU6v6XTzYWEXg2G03z2sW6Ewh6rp30Uxt
 BzsEX/AftRLszZOjXYmnUy1/mqkr4bjAdCa3pIW6clfRxns6iugD3Pl4zq3Idhfyjpid
 nNsZGA2seiuRmxwPbV/o6Im7Wv3IO2nZ806DtPhqOwSOd9G5prQTxaFxOFhUMUwm5lyW
 wj7P2/iwgLZ0r2SK4trjfUYwnWT77qIjWHY5Z1V7xgczjhovCNEhTp4dBEiHBoo9URqp
 5hqwj9t+Z0R2VhpTcXnvdhWuD4RkbhThvOwUmFc9LJFqfuHrlE/j/MmVLtWYXrrt8ppR
 /Wcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747632912; x=1748237712;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1Fw+Vzj8ovZb3V20iOH4C3yqA2FSTifYSD+4Ytkf5E=;
 b=kKJJ++pymDj72M3jSmUtg3SkTzUOK1MYiKTie6QRbOOE/X79Jx9h5+hf/uXbYUSX8P
 8uZ0wgLQdzUUPTJysjwqxPp5vDLDDnFjVWghmu2FkLz1r53W/SZVwXeMpAEO61F8oFqZ
 mRUglRxPhZIbeELql59D6EPNZFPHcm2PTAQczXE0IkDAM9Owrw+1b8u2lp10Wk8WdIzx
 2NbMDed/KPrzRhXQCw+fnP44Vz+NMe/gdyVGOTXyqMM6WbNBt4CmgKsgqjonZw9ABpmR
 YoPdkPiAC/j7BmXRTa7RrbCK+MqIzUHuzfE69TN7TSdKGSLoXppD8k2TfZUfKqJoM/rq
 Vfww==
X-Gm-Message-State: AOJu0YzU0sG29vAGIfGWWv3cnf0gaipxGcNB30eyWxvF6fZzNLihgSQZ
 x1WQK3XJaDbMmsDeL9oXeQzNCYRxWxIsO5pjlg7f6Fi2+Jq+uVdbeYIxR4j7urt/kGL/tNf9BWB
 AS53imRYcz5+kX+R3HPTfXG8IL2nJefI5O85kA4iKC75dCUi5I153SJw=
X-Gm-Gg: ASbGncsOlUeA+bh4VtCxN+x0gGiUGuBdlaA3OM9Au83XPImunR/3pSnJtep4E0X7Lo+
 q9UldnAgEtbvitdY4hnhimZbfkm1YJuNsZW0robd6el1mHIlwK+XPbuDYspkn0fbv/Zo+RPnt0D
 3sJCMmGOD4P2Y8iBwwCZZ1B68jVAQKtdOxSg==
X-Google-Smtp-Source: AGHT+IH72QPbXeU1ukUGXA+W273ZFP+KgYctkmYey/4Cc8clPZd7Iyohn3P98xaCxofzvkz/s8RJs+kZIGll+s2GFPI=
X-Received: by 2002:a05:690c:4b8f:b0:709:171e:1321 with SMTP id
 00721157ae682-70ca7b8e205mr152154767b3.25.1747632911861; Sun, 18 May 2025
 22:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250518064344.14467-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20250518064344.14467-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 19 May 2025 08:34:36 +0300
X-Gm-Features: AX0GCFtHDYRZE4OrHZRJgzt1zYzvtNXKQIUlLsrLTfoGvw44NugJytbBQj_1I44
Message-ID: <CAC_iWjJVbc4pVJrh55bwvsP50U7=i8fc5xMeES_FxC6EE937mg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_loader: correct EFI_TCG2_PROTOCOL_MEASURE_DTB
 description
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de, Etienne Carriere <etienne.carriere@linaro.org>
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

On Sun, 18 May 2025 at 09:43, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> %s/data that change/data that changes/
> %s/cannot be used has/cannot be used as/
> %s/Otherwise/Otherwise,/
> %s/allows better measurement/allows for better measurement/
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  lib/efi_loader/Kconfig | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> index 7f02a83e2a2..95b51d4da1f 100644
> --- a/lib/efi_loader/Kconfig
> +++ b/lib/efi_loader/Kconfig
> @@ -443,10 +443,9 @@ config EFI_TCG2_PROTOCOL_MEASURE_DTB
>         help
>           When enabled, the DTB image passed to the booted EFI image is
>           measured using the EFI TCG2 protocol. Do not enable this feature if
> -         the passed DTB contains data that change across platform reboots
> -         and cannot be used has a predictable measurement. Otherwise
> -         this feature allows better measurement of the system boot
> -         sequence.
> +         the passed DTB contains data that changes across platform reboots
> +         and cannot be used as a predictable measurement. Otherwise, this
> +         feature allows for better measurement of the system boot sequence.
>
>  config EFI_LOAD_FILE2_INITRD
>         bool "EFI_FILE_LOAD2_PROTOCOL for Linux initial ramdisk"
> --
> 2.48.1
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

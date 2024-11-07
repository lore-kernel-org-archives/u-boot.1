Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92CDDD5AE79
	for <u-boot@archiver.kernel.org>; Thu,  7 Nov 2024 09:41:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDB36891FD;
	Thu,  7 Nov 2024 10:41:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mwSw3Tlx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C2989218; Thu,  7 Nov 2024 10:41:03 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 737C088B4B
 for <u-boot@lists.denx.de>; Thu,  7 Nov 2024 10:40:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2e2eba31d3aso560904a91.2
 for <u-boot@lists.denx.de>; Thu, 07 Nov 2024 01:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730972455; x=1731577255; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bu9q3+d235rXzZ+Nhc6JMrk0hcL/GLBjX1/lxszhXf8=;
 b=mwSw3TlxaR2KaCa+Dky+Oi1i8WEy8IAyh43pcts4aTtkxJ77XCi3LloO9eU24HepNm
 wM2GCwoeB8NBOKHXxtKFy09buwc/wsfBuK/uG8xYlu8fHy94obwurUxaSOvAYJxffYjp
 XbXfoOUKCNg6yck2FvQ3QNojoZh19I3P2pvJZl8pxfKERB1xanDxoyJTrFiI+QfcBjim
 7jW81ZZRbhPgvmpfXEPm9mmeK4CCpqPcsFO4dKXc+5vS4w5WmMtbC+SSqWUjdLwB39S9
 aHe8Tixt+VoBnpsigt5NMqZi6Z7kW9B7cMqFlsdK75S2aNSZfodxZQewY3qdl1ER1JnI
 gzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730972455; x=1731577255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bu9q3+d235rXzZ+Nhc6JMrk0hcL/GLBjX1/lxszhXf8=;
 b=wW0Vv2m8WL0M2J9Oh0WIvW8s8r6Hnn+wjYfiHbstLzQp50wa8RCCJ/3qmLFkxkfkgi
 zVTSduUdiGJOtJgd8DlsFx9ESeD5rki8XMsKO+svQkAVmIo3jWnA/E288O0sveppGQCa
 VPBZTzCnjuhZL9Jwh2ugPcwJ56ipjuMnBpivLvzbbtHgFs8e6lOV9AQu76GQBqPBZDVS
 xkorcMkfX1kBsEg7+5gi2pKIyM5E+6NAtWwz9+cnCMPeLqahnh0lfK/mU1wrp9VFxhqb
 K8a1JUErWWX9UgOZG41A/d6N3/n2HEf4jxeCiwD1ba/idIbfMqfT3fU4yJ2da6Lrh7zg
 Z+EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjVChBXJqbNtEtI8A/We0NS5HencM2qpce4qID6Efvd2K0cxrimoblBBDitS8RyfVvC7WxkHs=@lists.denx.de
X-Gm-Message-State: AOJu0Yx7HmQWwejijZGyZwkbT7yKeim/v6cJ47dFMkzeavTw6IQY34bp
 kUEBDsOI15s2QTSPzvaIwH9ZX0OYdMunfgPhZb6zkrJ7RlR57UuGSXVcgRUDwCV39bOXr5fTqoS
 oEzcebQY8Qlt7oLFFky0kp7oyyc8Og9c87QHqSA==
X-Google-Smtp-Source: AGHT+IGRiWFAJisjRKAtXtJ7TIBTYdvTmVGP+QhbncXqngGshj2yBCHMAsYFgrnULTN3vFPKm3pFhGmzMSksZMGYdpc=
X-Received: by 2002:a17:90a:ca83:b0:2e2:ad29:11a4 with SMTP id
 98e67ed59e1d1-2e8f11b894fmr44820674a91.25.1730972454964; Thu, 07 Nov 2024
 01:40:54 -0800 (PST)
MIME-Version: 1.0
References: <20241105193129.28582-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20241105193129.28582-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 7 Nov 2024 09:40:19 +0000
Message-ID: <CAC_iWj+xAGXbs3-Lbs6OErNnkdxu4TuAGvRLsax_L_a6QkjfXw@mail.gmail.com>
Subject: Re: [PATCH 1/1] board: qemu-arm: select
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Tue, 5 Nov 2024 at 19:31, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> qemu_arm64_defconfig with CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=n leads to a
> build error:
>
>     arch/arm/lib/crt0_64.S:85:
>     Error: constant expression expected at operand 2 --
>     `ldr x0,=((CFG_SYS_INIT_RAM_ADDR+CFG_SYS_INIT_RAM_SIZE-480))'
>
> We do not define CFG_SYS_INIT_RAM_ADDR and CFG_SYS_INIT_RAM_SIZE for QEMU.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  board/emulation/qemu-arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
> index e21c135e86f..80ab9d8e1c3 100644
> --- a/board/emulation/qemu-arm/Kconfig
> +++ b/board/emulation/qemu-arm/Kconfig
> @@ -5,6 +5,7 @@ config TEXT_BASE
>
>  config BOARD_SPECIFIC_OPTIONS # dummy
>         def_bool y
> +       select HAS_CUSTOM_SYS_INIT_SP_ADDR
>         select QFW if ACPI
>         select QFW_MMIO if CMD_QFW
>         imply VIRTIO_MMIO
> --
> 2.45.2
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

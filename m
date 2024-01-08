Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4881C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:19:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05FE287A89;
	Mon,  8 Jan 2024 01:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eigdupQg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E157B87A7F; Mon,  8 Jan 2024 01:16:36 +0100 (CET)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DDF387A8C
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3bbbc6e51d0so1203127b6e.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672988; x=1705277788; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gEUXFaUZS2mPqztpSEaFQrS+3j2zK4l4nLUxRMP4YJU=;
 b=eigdupQgcc/0OmLs5BbpBzB2bgw81dqwQP7d32rHVkPWEfGNeWIenBBCjJdotwgChu
 2rGkbtUxQx1P0apJXJoUnqpptpxeVnB29TUhw46IPj9tFMM/OUWDZTPZcS10DOIOcsXT
 teXrrtUMlGpBggwPv2HxXLkRWlwrVkPwvqMl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672988; x=1705277788;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gEUXFaUZS2mPqztpSEaFQrS+3j2zK4l4nLUxRMP4YJU=;
 b=OBckaFg0CCuta0KO3a67KiCvglVe2J1eRS9AxLTiYMhwGKRh8baZeNhyVkStuVTzkH
 UM5sSpQXmK1So5mM5h6TY7FgL9D/YAEy4GetIPuv/T9enJ/BjLeZ8h82OGccRniSFfT0
 VJTYP08nUDknkS6Tt5em+aW0X2XpYs/NyuykUGv+jvjd4Jb41Hh0rwz/71vUtgWmVXkY
 gWUNe6EEbCY1b3+REDaM/g9PgSmfBwagdMXmfur4HvGZjCaEXtHubZXsWcUyGHkMpUGu
 UMN6892ek1TP/hjQQAFJIsch7+SnLnMmOJX3wjaN3OCCLdxwKN4ydJrc7frqcke+piYV
 0v0w==
X-Gm-Message-State: AOJu0Yyrm6e7lMdI8Z/pvaj+95kx4LfIWnH0sQfco+4PJvM3ZGDcslvP
 9aSDb28ko5vYXexAB5/00VkB96Zbp1DAa7X1gyFyWEEBU+nG
X-Google-Smtp-Source: AGHT+IGwOh1A2MSf5ct6hWHhhP4ODbxRm7t9ieuQ/DItv7RL3Xz06Uxc6irOGbECsShTFlCQ+3OljMLM/Lapq1M24j8=
X-Received: by 2002:a05:6808:1281:b0:3bb:b700:e2e6 with SMTP id
 a1-20020a056808128100b003bbb700e2e6mr2579000oiw.114.1704672987928; Sun, 07
 Jan 2024 16:16:27 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:27 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ303PP1B0zwiybV=m72bu2A7eQokg5GvW4XCE3Jc_y34w@mail.gmail.com>
References: <CAPnjgZ303PP1B0zwiybV=m72bu2A7eQokg5GvW4XCE3Jc_y34w@mail.gmail.com>
 <20231219150408.10949-1-heinrich.schuchardt@canonical.com>
 <20231219150408.10949-4-heinrich.schuchardt@canonical.com>
Date: Sun, 7 Jan 2024 18:16:27 -0600
X-Google-Sender-Auth: fUJcsOK6CvT0nkdsvU9aHXB-yKM
Message-ID: <CAFLszTiY+e=RKCQp344Mhg6UZa=er6zEtyNxpDaegVYsD6iCjg@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] arm: add ACPI fields to global data
To: Simon Glass <sjg@chromium.org>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Tue, 19 Dec 2023 at 08:04, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add fields for the location of ACPI tables to the global data.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v4:
>         no change
> v3:
>         let tables in global data depend on CONFIG_(SPL_)ACPI
> v2:
>         new patch
> ---
>  arch/arm/include/asm/global_data.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm/next, thanks!

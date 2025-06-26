Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74384C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 26 Jun 2025 11:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C27C082AA4;
	Thu, 26 Jun 2025 13:07:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MyqNyM6U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2652E82C4C; Thu, 26 Jun 2025 13:07:52 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27A082977
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 13:07:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e81ec95d944so1759823276.1
 for <u-boot@lists.denx.de>; Thu, 26 Jun 2025 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750936065; x=1751540865; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d1IV2o0gyGg86JCqE+Lc90tDeHvV8BASTqg1CkMoBKk=;
 b=MyqNyM6UNENwbSq5JDoYFjgsXu219TL/K4r1Fj6KH8VlLpI/XPBO3I3ifTqaVrF/s7
 Xi4tzhjWdlv2aur9/GwHM0tbpJZEWNfSHlmQ1dZ/cozdUo3KgGNwAsHB48Nxu4tLXHV3
 hGXCn6RL0iYqHvKUaOauRXMQZrQ+OeklAAj97ht8zkNjX36wsoYGHGRuh3wuGIvYr4Fe
 ZQcEoKTdV+JMwBL/c3hYu4E35PQwbolfX1B+TtfzdxtevaIrpecTqtdQHtW6ONZd/IRE
 SXTDMHZCWt8mcVmWfVP+zYE8gLE5tLYUZg07QScqqdwq5gLb21K8TsH/I860MKQDbm/K
 GOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750936065; x=1751540865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d1IV2o0gyGg86JCqE+Lc90tDeHvV8BASTqg1CkMoBKk=;
 b=VIlO17bPIPR0FRCAYx1TZPwUIkutpbppg8Uidp/Q6oYGO7zKeookKGGzwfV7LzSpW8
 pD9DPWnXnsox2UvEDXOEwq6vg3r9d8aOmQX3dvo6eL0MC8+WaZQlPTna4jsb7ADBKxAp
 haur4dOcnGFK2gqL6mUAWbfMRUaPVEAv/E/V1Hn5VgJ8KZJWIfASm4J41lgdbeH+FJm9
 NpAuxmntNSkANQru56q2O1jxbFpI7TV44BNrsaCksH5RB+wAi/dyKq8MewmaA0V05kMT
 Oi4LVkhDYI9KLb3i6jB9G6MPeMyrUrThcUfjLf4iOdn9XE1/t7Lvy77eApN5yGMFpmPm
 Ferw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3b1oBNp36eru2F4mA//+WP0bpx7F2KDK1MzCskhvS9bvKtYeltFQDbISxC8ymfm3XC8zCE+g=@lists.denx.de
X-Gm-Message-State: AOJu0YxgakiTGapouR7w9RQc11ycXag3GUdQlzu2fnC0gTV5nzoBsZ8T
 GIflDmQZdO3/xWdDPXe6JzX4r5b5Y1ii+b3JcnH/K51ytplAzSGDcu+rpJ41pa/aoUVdtlbVr9Q
 HijQ6jAL0IVsnXet4hCZWnKvkktIgWi6xFN/BfbyaPg==
X-Gm-Gg: ASbGnct8sadYgMaiszfUfrkPtxffAfC0+rPkxh1776XWTxZnlYKJ38ma4q76n80/Gdr
 AiMdbgwYCb3pvlh4wI1rNtdUmOao3vWQbFeCinBGzmwXqVhM4L7oou+8DbvtRPOiyUBfA/KkEAm
 VdutX5EKkwqWsWhOP+0btNHXtQdXrQbBlTMcZA8ZNXWeTN
X-Google-Smtp-Source: AGHT+IFEgX88nNjVcvCB9oz+nugGbFCSnh2J585rLGrWVJq9xI3dqSadrvphWtdhC0M5IMxTjkKtgOqMgrJMYbW7yoM=
X-Received: by 2002:a05:690c:1e:b0:70e:61b:afed with SMTP id
 00721157ae682-715094a1bc3mr46158567b3.7.1750936065513; Thu, 26 Jun 2025
 04:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250625171528.1062540-1-ilias.apalodimas@linaro.org>
 <688f0e0c-7acd-452a-b941-188b76aa9c2f@gmx.de>
In-Reply-To: <688f0e0c-7acd-452a-b941-188b76aa9c2f@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Jun 2025 14:07:08 +0300
X-Gm-Features: Ac12FXynD20h-K2eK4wiUblLeAWxvwxidjDVEZ1BU8t59SPmHo77w6ZuOeC3aWE
Message-ID: <CAC_iWjJd8RXKG_oUBt-pE7seLOe3h9wS2NZkJDJAHrfarHy2Gw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: initialize 'total' variable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, u-boot@lists.denx.de
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

On Thu, 26 Jun 2025 at 11:05, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.06.25 19:15, Ilias Apalodimas wrote:
> > This variable might end up being uninitialized if we exit early.
> >
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >   lib/efi_loader/efi_bootmgr.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_bootmgr.c b/lib/efi_loader/efi_bootmgr.c
> > index b9437a81c642..662993fb8095 100644
> > --- a/lib/efi_loader/efi_bootmgr.c
> > +++ b/lib/efi_loader/efi_bootmgr.c
> > @@ -1134,7 +1134,7 @@ efi_status_t efi_bootmgr_update_media_device_boot_option(void)
> >   {
> >       u32 i;
> >       efi_status_t ret;
> > -     efi_uintn_t count, num, total;
> > +     efi_uintn_t count, num, total = 0;
>
> 'total' is a non-static local variable.
> The first line using it in origin/next initializes the variable:
>
>      total = num;
>
> If we exit early, local variables are discarded.
> Could you, please, explain your concern.
>
> Best regards
>

The out: tag uses it on a for loop to free allocated opts[] boot options

Cheers
/Ilias

> Heinrich
>
> >       efi_handle_t *handles = NULL;
> >       struct eficonfig_media_boot_option *opt = NULL;
> >
> > --
> > 2.49.0
> >
>

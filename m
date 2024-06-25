Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336BBC30653
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 12:30:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E070E884D2;
	Tue, 25 Jun 2024 14:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oyphqk/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA35884CD; Tue, 25 Jun 2024 14:30:29 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08F7884D2
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 14:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2c7b14bb4a5so3777244a91.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 05:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719318625; x=1719923425; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A/QA424BgjX5dtNWCtMNrbB84YwryUFYns5XAxwR1IA=;
 b=Oyphqk/83gbM73v37WYzIfA5KwFRBU+tKQV8iXlU2HBqdtF41MxJxHyUZXTiLckZjk
 24oIXW5WDZLTpah2KjUU7iTyLFcI6jRsV/H64TqGHeqe1B717bVzFiM//YkUuGhP6uj1
 LT+c6n6W4OAY8zFGnnlZB7Tw6jke5Y2cOmnm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719318625; x=1719923425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A/QA424BgjX5dtNWCtMNrbB84YwryUFYns5XAxwR1IA=;
 b=kajclxvpJ6LcgMXw2Z8NrmOcpixF9n0dsytxXfgCKCUSsqTTdTsWvYciTX5UHfeRmV
 J3xIJv193ox+hQYOr3XZpn/Dv+y+rUiAiQvIBI7Gkdt2+GP14EENDW9qqkPxazWCwSfi
 YEbkzKV3eoUG66e2PqamAQU4DuQmrvWt0sMvZ1Vs7TPmsxMniGPmojK4rWdGONSOlEwa
 TAK5pbFHmw8EX0oQRUpJFDs0uuXbbFLyld75sClWwIMUruIKHYJgbTgLhwCxdy1CyPx7
 hPwSa/hosIJ7ykGoqdOnOECPvkjP9tQm9uGYo3dedgv8LBjoLac95h6eEz5Phuu/dE+r
 K2YA==
X-Gm-Message-State: AOJu0Yz9yucmyryOebqjJSK59EQNrAGrlyg1x99rDcgwusADvePl5/55
 V7jm8OU5G52dhDXq73uUfg6MTujGAZu1oN2LPeDxf3VEKJTi4+rUcfq0DZN/ExZh2F0RUjvo6CT
 v3CUU1Us1rLKcw6PBMuZnv9vdALpZkbkCyRRb
X-Google-Smtp-Source: AGHT+IHKcMyYJlqS6VuoefZTZaHXmqps8Of4XEF9ZmRYGZEcUHXRZnFlql5GwYUd45CVx1N6wV8QbvbkiWFbpJGpwuc=
X-Received: by 2002:a17:90b:f02:b0:2c4:e2d6:8de6 with SMTP id
 98e67ed59e1d1-2c8a23bf31cmr5338688a91.21.1719318625323; Tue, 25 Jun 2024
 05:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-15-sjg@chromium.org>
 <8441D4BF-6E80-4518-B52F-2EAF47F05CE1@gmx.de>
In-Reply-To: <8441D4BF-6E80-4518-B52F-2EAF47F05CE1@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Jun 2024 13:30:13 +0100
Message-ID: <CAFLszTg8Re0ZV3F-ziqZJH7YMVvDX1aevxt6FOSGMovBDFS8nQ@mail.gmail.com>
Subject: Re: [PATCH 14/14] smbios: Correct error handling when writing tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Peter Robinson <pbrobinson@gmail.com>
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

Hi Heinrich,

On Sun, 23 Jun 2024 at 22:41, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 23. Juni 2024 22:30:33 MESZ schrieb Simon Glass <sjg@chromium.org>:
> >Since write_smbios_table() returns an address, we cannot use it to
> >return and error number. Also, failing on sysinfo_detect() breaks
>
> IS_ERR_VALUE() could serve as template for conveying errors in addresses.
>
>
>
> >existing boards, e.g. chromebook_link
> >
> >Correct this by logging and swallowing the error.
> >
> >Signed-off-by: Simon Glass <sjg@chromium.org>
> >Fixes: a5a57562856 ("lib: smbios: Detect system properties via...")
> >---
> >
> >(no changes since v1)
> >
> > lib/smbios.c | 10 ++++++++--
> > 1 file changed, 8 insertions(+), 2 deletions(-)
> >
> >diff --git a/lib/smbios.c b/lib/smbios.c
> >index fb6eaf1d5ca..4126466e34a 100644
> >--- a/lib/smbios.c
> >+++ b/lib/smbios.c
> >@@ -5,6 +5,8 @@
> >  * Adapted from coreboot src/arch/x86/smbios.c
> >  */
> >
> >+#define LOG_CATEGORY  LOGC_BOARD
> >+
> > #include <dm.h>
> > #include <env.h>
> > #include <linux/stringify.h>
> >@@ -596,8 +598,12 @@ ulong write_smbios_table(ulong addr)
> >
> >                       parent_node = dev_read_subnode(ctx.dev, "smbios");
> >                       ret = sysinfo_detect(ctx.dev);
> >-                      if (ret)
> >-                              return ret;
> >+
> >+                      /*
> >+                       * ignore the error since many boards don't implement
> >+                       * this and we can still use the info in the devicetree
> >+                       */
> >+                      ret = log_msg_ret("sys", ret);
>
> Can we make this a debug message?
> It is nothing an end user should worry about.

Yes, this is a debug message...it will only print if you have
CONFIG_LOG_ERROR_RETURN enabled.

Regards,
Simon

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11840C27C55
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 11:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E95888180;
	Mon, 10 Jun 2024 13:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C4+jddNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB749884C3; Mon, 10 Jun 2024 13:43:33 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70DC28811A
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 13:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70432d3406bso1008667b3a.1
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 04:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718019810; x=1718624610; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+SQqv04elaGuVNkaPg+8eORel6kob3YZFKITWk0lWqM=;
 b=C4+jddNCOUTjZ1fnfmYnkf26AnUa8wPinsVFe1HyfJcQbp5cp2od/UG99vSoJ8zYx8
 1F+ZqczQKCKrelnKfHH+CKd4NfeojtMLB3tnabcK2qcU0sCRQJV/ApUXkbDnnoW6PBRY
 HHglKDWkAADsv5WYGDtR16BWrEnctNL/rZjC9CpSov0YdOXsqJXIZ88HE6X1MQBNfwT6
 EHir/uYgOatFYcW4oolSXFN3x9u5QU3pWCZrEh65WPF9d7IhFESoojiCDLRG+TkeIZS+
 jjBydFRDdOScf7FL5OQ65Y5OqBEAeajUij5ls90GdB0IFvOGlSaK3AKgLzGj+63ACyLz
 5G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718019810; x=1718624610;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+SQqv04elaGuVNkaPg+8eORel6kob3YZFKITWk0lWqM=;
 b=Ujth6YnAsxQz4rOg4P4jC7mk7BbHI1stA/HwBRQQeMpzz0/UDgjSpmDnan2Z5H+q5c
 w3sSFfhmf3ELndiESEAqc1F9r/k0Wkm+5O/SRzG4qqnJZ3+cZLPVafp3HEKv6d2xiH0+
 exYDHlORxE0x1TUawMsJtdylrH0qAfp0QcKQ6SRWmjQjaykZ6k7E4bZIxH1IaN+q85Q/
 Tn3GXoB6iZ67uUg1O/X01AN7mDxQu3jDT8uigJlXH+O5dL1r31IEU9iO8RA9K70LGgiU
 Iza/XXBRp/t/uJcBkNP1SGbq2crMY+J8zOmrDAZt9Rf4EB+n+5jaqaethgxgHIckgvq/
 jCcQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq1kpfPn/73RxT4g7/9cICbOtFhcQFsANzOm7ccaefoc6/Cig6FHdOP9sErdMfxZYDlUVNxJInjxretH6W4DkFrUX9xw==
X-Gm-Message-State: AOJu0YwOaxSZNU/sgowT4UzjfzNK3tz3tDz/iPkWHljGwzXTtOEFAIeh
 eeTmYPiOk/l0Lok139GXmm1qPIudAfptUAje3gvcMlSmuBQizR+gL1pE63rGDsLSGsqZdU+gjy6
 WtxgKKElabPokBdCCUi2Rqyh+5c4WKRuMU+nxZA==
X-Google-Smtp-Source: AGHT+IG4OZNs/KoOMY4Mrs0ciUJxV13cNzQpn3m98SzIosHWfYDfEhJxXU9ByDBRoD5apekXmxVjzeSV1gLcJ/q4QKk=
X-Received: by 2002:a05:6a20:9143:b0:1b5:d172:91ef with SMTP id
 adf61e73a8af0-1b5d17296a1mr4770876637.5.1718019809956; Mon, 10 Jun 2024
 04:43:29 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-29-sughosh.ganu@linaro.org>
 <B9D72BA0-BB60-402C-885C-6457EC517973@gmx.de>
In-Reply-To: <B9D72BA0-BB60-402C-885C-6457EC517973@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 10 Jun 2024 14:42:53 +0300
Message-ID: <CAC_iWj+RAdL1WMWo808qHbHsHJJSErpL=16Djqk0HVjx2b++zA@mail.gmail.com>
Subject: Re: [RFC PATCH 28/31] cmd: bdinfo: only dump the current LMB memory
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
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

On Sat, 8 Jun 2024 at 06:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
>
>
> Am 7. Juni 2024 20:52:37 MESZ schrieb Sughosh Ganu <sughosh.ganu@linaro.org>:
> >The LMB memory map is now persistent and global. There is therefore no
> >need to add memory to the LMB memory map as part of the bdinfo
> >command. Only dump the current available and reserved memory as part
> >of the bdinfo command.
>
> Would it make sense to move printing lmb memory to a separate command instead?

Yes. Since are permanently reserving memory regions now we should have
a command to dump them.
Perhaps re-use cmd/mem.c?

Regards
/Ilias
>
> Best regards
>
> Heinrich
>
> >
> >Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> >---
> > cmd/bdinfo.c | 1 -
> > 1 file changed, 1 deletion(-)
> >
> >diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> >index fc408e9820..0f343203ef 100644
> >--- a/cmd/bdinfo.c
> >+++ b/cmd/bdinfo.c
> >@@ -163,7 +163,6 @@ static int bdinfo_print_all(struct bd_info *bd)
> >       bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
> > #endif
> >       if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
> >-              lmb_add_memory(gd->bd);
> >               lmb_dump_all_force();
> >               if (IS_ENABLED(CONFIG_OF_REAL))
> >                       printf("devicetree  = %s\n", fdtdec_get_srcname());

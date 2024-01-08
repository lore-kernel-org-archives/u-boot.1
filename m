Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FEFC47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:16:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5A0187A46;
	Mon,  8 Jan 2024 01:16:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aeTs9RWF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CC2487A21; Mon,  8 Jan 2024 01:16:12 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2FA787A36
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-4283cd9bd87so14290601cf.3
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672967; x=1705277767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YT4Bx/z75hfkzlM8tSmqfV6kZPiMCwKpeCAdzaUZmwo=;
 b=aeTs9RWFfYxc4/1sgizmI7h2aO8tgON40IUDt8ACEoC04pXlCDd8foEzfVsY2j2lib
 a4TzkslFA/ds584sLIcRJ8USs8wQJ6PvH8SXjJOwMvA2nG2OAtW+U2h1OKSEmEx+a5/5
 99FieWrxPR7Om9mf8s9EjHv1fQIM1+mt7nRtQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672967; x=1705277767;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YT4Bx/z75hfkzlM8tSmqfV6kZPiMCwKpeCAdzaUZmwo=;
 b=nEONL3sWIv1IxThSDEov8GO+dY8dkSiqwhtbBAIHt8Sgc18CyXMNO6FaoSYgLZnKB+
 A9jhBM76L8UT/QN8KpgzZi92HmJPwTgJ0wM2iDWEcKMqTqGy3gzuK2U/vRvdXu+FQPwL
 Inxhw3ldFG0NbE05r6S54fNVvHadAa9j/VwpduA5ZC6CpJZi9Ut4tFpp3gWU8EJjbbQf
 IAnK1QyeUuj03WT+iRvcnPoct1oD6MKzLUOFfYKhEc0du1CJAda9c33M/B19rFfKq4eG
 6T7O4RCCGuwKleKAZzeI3xbUWOdfMeZVs/Hl6HPQW+isyx5lRKcMx6FlrpG4w/IviwZ9
 rUtQ==
X-Gm-Message-State: AOJu0YwJXKVNUMF+nq4k2XFDKcgD0aE53kvCEYwTWxgfz5xen1F7TU01
 EOYUI6dWLXtRx3CZeyU7E3voQju4Y2evLoZUDzQaeQpX2r1V
X-Google-Smtp-Source: AGHT+IEhAyc6jMwAQzcDNYp1cGfZovIWhdLb/1nOqT8DFbURngDmS09RfDJivLtpPYGdABKq88fYDlfvtlsHf945Z/Q=
X-Received: by 2002:a05:6214:21e8:b0:681:100:ad02 with SMTP id
 p8-20020a05621421e800b006810100ad02mr2959345qvj.50.1704672967456; Sun, 07 Jan
 2024 16:16:07 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:07 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <29b33ebd-1f13-4233-9142-07ad08da75a8@gmx.de>
References: <29b33ebd-1f13-4233-9142-07ad08da75a8@gmx.de>
 <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-12-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:07 -0600
X-Google-Sender-Auth: Jz-C3tCa9k8mNDYu_6uZf3ZlqOc
Message-ID: <CAFLszTj1dzFftW1g-xhF7qRZui4ZTBd9MSgfuWfp2g+SSb80_Q@mail.gmail.com>
Subject: Re: [PATCH v5 11/12] acpi: Write pointers to tables instead of
 addresses
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bin Meng <bmeng.cn@gmail.com>, Igor Prusov <ivprusov@salutedevices.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
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

On 12/31/23 16:25, Simon Glass wrote:
> Sandbox uses an API to map between addresses and pointers. This allows
> it to have (emulated) memory at zero and avoid arch-specific addressing
> details. It also allows memory-mapped peripherals to work.
>
> As an example, on many machines sandbox maps address 100 to pointer
> value 10000000.
>
> However this is not correct for ACPI, if sandbox starts another program
> (e.g EFI app) and passes it the tables. That app has no knowledge of
> sandbox's address mapping. So to make this work we want to store
> 10000000 as the value in the table.
>
> Add two new 'nomap' functions which clearly make this exeption to how
> sandbox works.
>
> This should allow EFI apps to access ACPI tables with sandbox, e.g. for
> testing purposes.
>
> Signed-off-by: Simon Glass<sjg@chromium.org>
> Suggested-by: Heinrich Schuchardt<xypron.glpk@gmx.de>

Thanks a lot for making this change.

Best regards

Heinrich

Applied to u-boot-dm/next, thanks!

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA82C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:16:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 643E687A52;
	Mon,  8 Jan 2024 01:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KgTxtAuh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 100EC87A10; Mon,  8 Jan 2024 01:16:16 +0100 (CET)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5142387955
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-680adbf077dso14468256d6.1
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672972; x=1705277772; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUzQyMNEg0SJWZ5m7imKiP1TN22t0Df6TrZsYmeObCE=;
 b=KgTxtAuhz9okjVJMnfPdce0RIeMdr1jR4b8h3IzH9dizrXyUhNj/cq89POFJTyCmX2
 ITTuPQ/+YHJHxl4iDXwl1PqfdyNlPXqZXx2iPKVvskma3ezBi1HQgPUpczFuac/23a2M
 vi4ermgNe3P6bCc0JQI/C2ZIERtpl3MmX+eUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672972; x=1705277772;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZUzQyMNEg0SJWZ5m7imKiP1TN22t0Df6TrZsYmeObCE=;
 b=nGw0K6mKu3EJTJ4OmJV9mZl1bj92qiB7t+72JF/YekM5Y0WUBhuNtpHbpUzGZ3pWms
 JYzvHcP+stq4g619a5ozhJXc2Z0Q5yiWav0zHhmMTc/z2odTNWqLCLZkilhGTd0oEzR8
 ASURE85BQEfu9CYAsjI8T9WvCYtKHcWLGx60es2Hjqa3SSwk4VRmNn5Ata5bD8h8/164
 n4IqbcxLC4Dzy7YZkheVjqM9FbtqrM4qaIUc3f2hluDuVsjgMVQ8oP2Hxm/hB8/DGskC
 4YEtB5QcUAAo6/4McDQdNVDPRY4X1ty0CjpRFKngw5kEd+nPSK5SegHFE6q+GxFgiQZA
 4CIg==
X-Gm-Message-State: AOJu0Yw8kxz4l300QXSFkcU+3qbmNm65gW1Zg2IfmaEvd2pA7i0OILMo
 wgH+RGfo39N00suHjs3hNJjJIoMyOoN9+SNfBnqA3xmc7UkawQoXEqOyIrlgNw==
X-Google-Smtp-Source: AGHT+IGgyMPWajNtrhTQdIXj/IZr4vkt1Weo6P525lTNmdvuE5vVzjOJXYC3mp7wzrs3Oz+zlt164qNXe87qo1WjxyY=
X-Received: by 2002:a05:6214:f0a:b0:680:c842:1816 with SMTP id
 gw10-20020a0562140f0a00b00680c8421816mr4539317qvb.51.1704672972151; Sun, 07
 Jan 2024 16:16:12 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:11 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <71e8c2e3-00c3-40e2-9da6-bdf43ba9cc0d@gmx.de>
References: <71e8c2e3-00c3-40e2-9da6-bdf43ba9cc0d@gmx.de>
 <20231231152555.464874-1-sjg@chromium.org>
 <20231231152555.464874-10-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:11 -0600
X-Google-Sender-Auth: a5TZSTVYSyYlpP44P9B0fL_3cB8
Message-ID: <CAFLszTiBo_8dBF-3wZ-7HxujgpM9wvJQvvWq0Wz5TJXgwAYj-A@mail.gmail.com>
Subject: Re: [PATCH v5 09/12] efi: smbios: Drop support for SMBIOS2 tables
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
> Only the v3 table is supported now, so always use this when installing
> the EFI table.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>
> Changes in v5:
> - Add new patch to drop support for SMBIOS2 tables with EFI
>
>   lib/efi_loader/efi_smbios.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
Applied to u-boot-dm/next, thanks!

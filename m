Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F9DC47073
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:17:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C74A787A87;
	Mon,  8 Jan 2024 01:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G/oXAPmC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72DE987A4E; Mon,  8 Jan 2024 01:16:21 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC9EC87A10
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-680a13af19bso13789456d6.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672977; x=1705277777; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oP4HxBXDpgWu5mr4dBePOXXpseqkH1mFhCdAegLkHVI=;
 b=G/oXAPmCR8Kr3rnMsGxxnvJuyrgEWAxWiCXkd9sWTq257KDOXvIDSB9C1sO14kcz1v
 4KyaFY7CohR5KMivyQEQWawu6ZzMFIq0WCGZoVWx1Ubz6I9EIxPctbf3+ppSCz8/xfAf
 Iq3HYzyMx41CCxQWPSOgXvAF7+8Jsum20LkrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672977; x=1705277777;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oP4HxBXDpgWu5mr4dBePOXXpseqkH1mFhCdAegLkHVI=;
 b=RPCR+0SDQX87AD2S4Xi036tzbmSBx1QJ02gCAYrHUgo8QIyXn6IBId0t2Wv3In/Hk8
 gyrY7fe2vPpMnB2RHa24lGtPRUoCgl6mTFFDxGFv9kMRu32ib5LVx0Y6kzkEOgfMkcoD
 hYj6W/2key+21xX/gwcHhhOA9UITzFPnvs310ETCrBK3q+jEPWeP3nG+um9e0qdESd+E
 A2K9dBVMM5tgfaaTdB272l5BgAJt9PSfJeroR8pQt3VSoQp6TFaUndnufbWjfUQCS/6y
 eSpy7IELlY6+JrGYCOznaEQ+FcAN18ts1KJqtrPu+wThuVF8Lz7UKKWeVkteEYg098EM
 oT/g==
X-Gm-Message-State: AOJu0Yy9t8ayO7PRDdhkaK5RXgq1Yrnkx12hBI+4hI69r4VVzYfta3qX
 w5pUtXsgCZtmP3ii8CKzW/DcWfh3U4vRbaO4X9nkJzDCyw0V
X-Google-Smtp-Source: AGHT+IEfOOm+QvmtO3T6KaCFn75LfuaErhXQb2IQS+eyLn+js6q3+wGRVDeXARDzfvYQzdNVOvjXG9ieW9sIBO8wmvA=
X-Received: by 2002:a05:6214:921:b0:680:f975:c833 with SMTP id
 dk1-20020a056214092100b00680f975c833mr2562701qvb.33.1704672977607; Sun, 07
 Jan 2024 16:16:17 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:17 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231231152555.464874-6-sjg@chromium.org>
References: <20231231152555.464874-6-sjg@chromium.org>
 <20231231152555.464874-1-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:17 -0600
X-Google-Sender-Auth: sGyxf9thH8kfIIId3WhsLkv6Mg0
Message-ID: <CAFLszTgGdAqHGsX+bFBx4vaUVoG=jgvCfXOx1tAmtsimkNArBw@mail.gmail.com>
Subject: Re: [PATCH v5 05/12] smbios: Correct gd_smbios_start()
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Troy Kisky <troykiskyboundary@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This should access arch-specific properties. Fix it and update the
existing usage.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Add a new patch to correct gd_smbios_start()

 include/asm-generic/global_data.h | 2 +-
 lib/efi_loader/efi_smbios.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Applied to u-boot-dm/next, thanks!

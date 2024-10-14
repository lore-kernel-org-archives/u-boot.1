Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B0FD1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D4F589156;
	Mon, 14 Oct 2024 22:20:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ixwMngAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7049D8915C; Mon, 14 Oct 2024 22:20:15 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22F5989018
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:20:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbd1a4217dso49990706d6.2
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728937211; x=1729542011; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3ersSGHD37BbS8KymhmHA9LhTKLMjxGjVES//lbDPPE=;
 b=ixwMngAy8QxxI0DyTAR4lxMOLSxnmC3x9Wr53LStyTpdDOIrSxAFMxuS5XlmMiFtPJ
 5AnZIUkc/69EtGuOPkTMvxK/UiWiJSdhL926w7cn+WDznWvv9WGgAiyRxtgXIxnYhrUR
 5s/QKUFf8v1UVmJhj0DqXD6bg4F/RLe7YFU6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937211; x=1729542011;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ersSGHD37BbS8KymhmHA9LhTKLMjxGjVES//lbDPPE=;
 b=DGkNu8hmcp1n0LSFSUS7V16lvDIPhWG0iSkYCasNMbgEF7XHmGJqITjs+6EXUwQu/y
 GMR6qTE8JEqgSL0mB0/5N10A4Zm4Lj7y4W5PNMrF3+p2bYbg9O7Vg2c6u1sgwEb3Vpax
 izzWAfJ1k7AdxO/R0RJq8XQcxCVjLpAjEMIhwtWLWbzH4wbSa4eEk8LAoDTrn/W6zdGI
 ezcohJ9UMWKt9IHay4V79Cmc0cRM32KQ8S1L5QMvEDnzxO3n/ZFHOSlCn2s3315ZgeBy
 2W58tbkCedt8MHNeYfYGsaL9tzqwNjjHTa1ZByQbZhUzFP/RX6z1LfPVBPLFaCic+BQJ
 BynQ==
X-Gm-Message-State: AOJu0YwyCh3lu0e//9h7AwOam4BoMcaJyVf+UMLVi5wxz1cJTkrGBmTY
 YYQxdqsLZxYR0w14+aqmSO6gxSm9cSGf6L51SmrtcCIsIG/YNOcgctg3KL3IOk5hIeRzv9T5PvM
 ZywkeiJOB0f9rPg7lRUErPiaCB3M2TFgp0vihM9MnW/yj9Do=
X-Google-Smtp-Source: AGHT+IHKV+QFXgLgBmj200LuxsVFbrFoPDPBLu7U+AX+BUvZ7qUM5tr75E1JjkgdCqFSC843dNy8Z64ihxCGNifEMJI=
X-Received: by 2002:a05:6214:4981:b0:6cb:f853:9eca with SMTP id
 6a1803df08f44-6cbf9d10272mr168262096d6.25.1728937211115; Mon, 14 Oct 2024
 13:20:11 -0700 (PDT)
MIME-Version: 1.0
References: <20241012232231.5638-1-sjg@chromium.org>
 <20241012232231.5638-2-sjg@chromium.org>
 <20241013161520.GM14210@bill-the-cat>
In-Reply-To: <20241013161520.GM14210@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 14:20:00 -0600
Message-ID: <CAFLszTjijFBZar31k1QaLUKcFQyD+CGqyo5wH=7agFF1gr-CLQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] qconfig: Ignore defconfigs containing #include
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Sun, 13 Oct 2024 at 10:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Oct 12, 2024 at 05:22:30PM -0600, Simon Glass wrote:
>
> > Running "tools/qconfig.py -s" will re-sync files with #include in them
> > and so un-#include them.
> >
> > Ignore these and mark them as failures.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > Fixes: https://source.denx.de/u-boot/custodians/u-boot-dm/-/issues/28
>
> How about marking them as warnings? It may be good to re-sync
> configs/am62px_evm_a53_defconfig for example and then re-add the
> #include line, but configs/am62x_evm_a53_ethboot_defconfig on the other
> hand very much should not be resynced. Thanks for getting on this issue
> so quickly.

Do you mean still do the resync, but show a warning? It does
obliterate the old defconfig, but I suppose people can just not commit
the changes. Is that what you are thinking?

Regards,
SImon

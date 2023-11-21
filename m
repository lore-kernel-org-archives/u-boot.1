Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B744AC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 22:12:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F205187628;
	Tue, 21 Nov 2023 23:12:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I287C7/Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4666D8744F; Tue, 21 Nov 2023 23:12:18 +0100 (CET)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A088762A
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 23:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-5c9cdc78c37so27577547b3.3
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700604730; x=1701209530; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TfWEsN6pSBFeScOAJvAN1mCsk2ZuoLORIuYO6WDgd94=;
 b=I287C7/QkC5aaLsEsaSKWlK53S/voS4dopoD9EeciitP7HiF4uTEJzrHvCoLcmFNfv
 jj3DCMxSPILAgG5DZDdqo42ZL687LonHdP4sGEJ/l2m/TgQyrlT0T4r9Bfvfb7uXn8FX
 e2yBpLlF9Ut9YxBqRJ7eXcaGvEilbnYK3VAqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700604730; x=1701209530;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TfWEsN6pSBFeScOAJvAN1mCsk2ZuoLORIuYO6WDgd94=;
 b=klOZyvPrUMbU4KRWVbbWt0ipzTnwVboXjQ7YjHuOloq20J+QWMKNGR+1HyHGnOpm+q
 p0LsFRm7WHWi8Ybpbke1IUZno6oNPN58RTcmhvAKPLr2cPFyscdP6fwknc41q/+hj0/A
 u/l4wSwEz25xqnhE7ylf5HHyadfukNX4V8A6Wk+oSBKAAdW5DqAjk218c+L+Ae1/RqOk
 7e5+MxtQtoyOiH1BEkTj/4g+OE2eJCci9o+9qweMHTr0mJKog8N/Ewf43DHBf0t3TiEw
 DdAnMhbMXwD3XVOlvWi1+IiYWpRp7PUPbKD9Nlgh45bDiJlxHZzLa/8/P7clDXz4fqXo
 DQEA==
X-Gm-Message-State: AOJu0YxG3xYcXHUJLFKMPXmNZCIIiDYt0iGacIAgYOKvm6eqZgl0DL9G
 hEymNvQHN6zIWOLmmDDDY2s6F45hgHiPjaq6CERSHg==
X-Google-Smtp-Source: AGHT+IHf7b2DXViButomv8WdZHOVvkFxgHQGMxUR0/dCnE6a1w5Cyx8NU1zBAz0RuF573Sixn/mTdJejY/egVkLOGYQ=
X-Received: by 2002:a81:6dce:0:b0:5cc:475d:ce0a with SMTP id
 i197-20020a816dce000000b005cc475dce0amr428567ywc.9.1700604730464; Tue, 21 Nov
 2023 14:12:10 -0800 (PST)
MIME-Version: 1.0
References: <20231121152740.24783-1-heinrich.schuchardt@canonical.com>
 <20231121152740.24783-2-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231121152740.24783-2-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 21 Nov 2023 15:11:46 -0700
Message-ID: <CAPnjgZ3yfX-9pHKyXNDpNvbq37BuH86YQDiAkxx7qbmCF+-How@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] acpi: Kconfig symbol CONFIG_QFW_ACPI
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Leo <ycliang@andestech.com>, Rick Chen <rick@andestech.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Yu Chien Peter Lin <peterlin@andestech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Miao Yan <yanmiaobest@gmail.com>, 
 Asherah Connor <ashe@kivikakk.ee>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
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

On Tue, 21 Nov 2023 at 08:28, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> We have two implementations of write_acpi_tables(). One for writing ACPI
> tables based on ACPI_WRITER() entries another based on copying tables from
> QEMU.
>
> Create a symbol CONFIG_QFW_ACPI that signifies copying ACPI tables from
> QEMU and use it consistently.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
> v2:
>         new patch
> ---
>  drivers/misc/Kconfig   | 7 +++++++
>  drivers/misc/qfw.c     | 4 ++--
>  lib/acpi/Makefile      | 2 +-
>  lib/acpi/acpi_writer.c | 4 ++--
>  4 files changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

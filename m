Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E5BE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29C6E874B2;
	Mon,  2 Oct 2023 03:22:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UlZp80KG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92FA38744B; Mon,  2 Oct 2023 03:22:46 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33EFF870C4
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5333fb34be3so20960932a12.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209755; x=1696814555; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wJ277nWH2vu24DsCP6as7wwXUBmJngkFvk+Ir9f2hJw=;
 b=UlZp80KGvPht2PEhSCCicHZ4BnPBJl33h7hT+g6tgvXS4k4kJXkDDip4NtKCYD12tG
 tcMm9awTJAR9xISYGotZsASr1A2XaaXo36NB3Zjsv9Ia1gEzaCgFZI2Jp1goe/EVPXrF
 ELB+g/H9is5auiIqDI/2YmnpnA7hVtOZyEN5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209755; x=1696814555;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wJ277nWH2vu24DsCP6as7wwXUBmJngkFvk+Ir9f2hJw=;
 b=LVw1OeovHkYm9+uA8OKnQCsXmZ1yjhhNXBrhZuibpThSZchBPho1a2jHojzSMtdEKb
 gbF7JdbcdKLK6eyZTaZoYvWgj1SH20hioMZQVnW4qkonuSxovkdyYIXBH8fP/pHC/Z95
 iVTs0wJJY218RllF+qH4MjOibSk07s/x4QMYiJQ87nycABuJNPvuqscWNxNmuiD4dsIv
 TcJQnfQ0aVeWBpZaTjI8xvw+YSxP/qTqwdoI26y9Ytu7rFGSgkpWeniVTl7uJA9BrKJg
 hUi4/lkcTnSHbUIEXWCVDwH6iRnvWquybFmD3vDt5ywn9HzFwPkB/VOS0xUg/95qPg2W
 5Bbw==
X-Gm-Message-State: AOJu0YxvoMQLLWsxNbYI9QI+ZrfHFGiXUAM1NumjLo4eDNJvKrOtIXA+
 YBeguu1vKCyelNpuR7R2mfLwrFrc7bdvthUgduJF0Q==
X-Google-Smtp-Source: AGHT+IEZLYwzTji8ZWK8F7XhlVSb3I+aXqmnVNe4tF5LulQPT/x3BoP0MHs3mhYKQB+rjU01cDcPLrV6IyJEl+k0u5g=
X-Received: by 2002:a17:906:847a:b0:9ae:2438:d6d with SMTP id
 hx26-20020a170906847a00b009ae24380d6dmr7391194ejc.51.1696209755411; Sun, 01
 Oct 2023 18:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <fd0412ad51224c3afdf0a08870afa46127a42396.1695817360.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <fd0412ad51224c3afdf0a08870afa46127a42396.1695817360.git.matthias.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Oct 2023 19:16:51 -0600
Message-ID: <CAPnjgZ2uGWaPsoMFO8u698Lc0xuTaLkr=Obae2H4ZAex=uB6Xg@mail.gmail.com>
Subject: Re: [PATCH 2/5] core: return FDT_ADDR_T_NONE from
 devfdt_get_addr_[size_]name() on errors
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
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

On Wed, 27 Sept 2023 at 07:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> Checking for the error cast to fdt_addr_t is rather awkward - IS_ERR()
> can be used, but it's not really made to be used on fdt_addr_t, which
> may not even be the same size as a native pointer.
>
> Most places in U-Boot only check for FDT_ADDR_T_NONE; let's adjust the
> error return to match the expectation.
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/core/fdtaddr.c | 4 ++--
>  include/dm/fdtaddr.h   | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
Reviewed-by: Simon Glass <sjg@chromium.org>

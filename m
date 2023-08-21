Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F46EE49A5
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 19:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B098E8716E;
	Mon, 21 Aug 2023 21:13:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FZxQULM9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26A44871AE; Mon, 21 Aug 2023 21:13:32 +0200 (CEST)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F79087111
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 21:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-59209b12c50so18869507b3.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 12:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692645208; x=1693250008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KjE9GUAS0pXnBjD9bJuDqvODL2czVZpai+TU5MWlcHE=;
 b=FZxQULM9+jyx07M0lpoo+4d0JZoXpreWlGIv6moWCWiVdSlHWuxA8tceAwo+Hmn4qV
 r+KH6yCdUIDX99zFnCFjW0Akk5YUhBiMzfTE/o/Ye5w9LNDpj8KNAau7N3NnXJ0ErB0k
 TLHA0eM4PGCCwBDcku3xr1ZPJOeN9O6aZuQCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692645208; x=1693250008;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KjE9GUAS0pXnBjD9bJuDqvODL2czVZpai+TU5MWlcHE=;
 b=Dsk5QQd58ZeXRVHgF1cpIIIhVYpHzipEAu7ybtsR9fMbLPV2Qhn4Kb8gbcEPPZpO1q
 CyftB2ZZ5XE1n6osnkjoaJd67NURsz1/6wyhXG1718+r69kLnMaTdovV7x+GaiGOMTG7
 bIFJrA3D322fxDIqyXI3ZTxi9/8+/oSWgRyuqY9D7X//W/4bg71Lh8ETSvscTc1kpRyt
 esondG3C5E1r35ElrfSrFazCRvQFSXtaZUtxahGFFKRs7bGZ54Nt3UzvSHpOvP0S5PNv
 pSPzfPll1lY49cTVAU2zuT4LNyYTqHKRfIyQvi7eVwA6Ne2Sw/fVxI4ekak62Zz4lO6L
 RP9A==
X-Gm-Message-State: AOJu0YwwNCwqHFy6gZvQbQ4YkxGtFambLviNePwIN1nfwxYGPJ2MpFvJ
 nb8J9WYaHSXJAT8/8BjbWodEx/7JwxMGKBGeNnAopELkZY2yOPYQs7Y=
X-Google-Smtp-Source: AGHT+IFVcc5qtRloY/qf1M8U7ery5d+GPOfoVo1NcBnar+cCur/JoFTwuAmY5MmXVC1qHCSWT1nKarcD1JhoKXjZ1O8=
X-Received: by 2002:a25:40d6:0:b0:d71:8729:23b8 with SMTP id
 n205-20020a2540d6000000b00d71872923b8mr7220467yba.13.1692645208035; Mon, 21
 Aug 2023 12:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230821135910.55795-1-afd@ti.com>
 <20230821145317.GC3953269@bill-the-cat>
In-Reply-To: <20230821145317.GC3953269@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 21 Aug 2023 13:11:45 -0600
Message-ID: <CAPnjgZ0w56Y8H9_g2YnrUWPx9X9nXncO8zF1FN0Tqa=HdEb35A@mail.gmail.com>
Subject: Re: [PATCH] configs: Enable CONFIG_DM_SCSI in am57xx_hs_evm_usb
To: Tom Rini <trini@konsulko.com>
Cc: Andrew Davis <afd@ti.com>, u-boot@lists.denx.de
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

On Mon, 21 Aug 2023 at 08:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Aug 21, 2023 at 08:59:10AM -0500, Andrew Davis wrote:
>
> > This should have already been enabled but was missed when converting the
> > base platform defconfig, fix this here.
> >
> > Fixes: 3c5aa6caccab ("configs: Enable CONFIG_BLK in am57xx_evm and am57xx_hs_evm")
> > Signed-off-by: Andrew Davis <afd@ti.com>
>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Simon Glass <sjg@chromium.org>

Thank you

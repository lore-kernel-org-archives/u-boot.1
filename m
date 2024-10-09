Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67D5CF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 02:00:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F64B89170;
	Wed,  9 Oct 2024 03:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Cxni3nKX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D35F89156; Wed,  9 Oct 2024 03:57:39 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 55CA08914D
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cb2f272f8bso55057366d6.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439056; x=1729043856; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sEhQc3cQiJT5xvctmikPxeam7xx+bKN513P6/xcFIzI=;
 b=Cxni3nKXzRIbDjVQWQlJQ8hVV6/ClXplLYdlWvWJ5mZZ1DY9CodoDNgkfiGpQhD4Un
 ZjMzTjtqoT8mSZVuqowrymN+8mrSxarF80gTdpylz++5/wtQtM7W9f+q/nObVYQWTc/Y
 d/8MheER4qtJxchYtrq62+47D6T/kba1vHUdw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439056; x=1729043856;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sEhQc3cQiJT5xvctmikPxeam7xx+bKN513P6/xcFIzI=;
 b=Sz2NMN6mIhuNsTXpVmI0R0tVyiCe1fDQT+dNgNrNB0InOHQm3lxBNRV+kEn3kY9nfi
 acetN3B/c4gns+NmYA/fy188wmWKGofac0GeSECGOXSrePk1D2K3lQTm676oxssFROKO
 C0ktvfxu3EjMjPRkRdPHJkYXhy64P9/fo4kSVulSpSC71gS4jRnrT8v+L8Rqw1ptB9CC
 LBTI5caXdyqSvcA5CFBgeTiRAPcZ4LOrfnhqETol+p/qXoLd3a2yPP7XCqH/H43LDasm
 li1fBwOy4iQRjxeAsQNSZjQLcma4ifuF9Rho85pds3iRI3sXFYUukB0Y93nZVQ2qlpfr
 He+A==
X-Gm-Message-State: AOJu0Yxs3alRIv5cjINtHm94E/cxE5RiX10JdI1JqW5x3L4Uhu2Zux6G
 YOv2q0TX5tLrL4bGitXT3C3rd8hb4rIIVa/X6RY4pCADQEQyTywNLExQAqFQQ0L0MSC9KjWdBIL
 C1wuIweKAwrKOHX8rxQUV+wQc2YUahjHdFRxf
X-Google-Smtp-Source: AGHT+IG2c9xtqJ8Xc4XmvgP3Sz3VDuMPfQ3NyPCo/ugXlwCwtAFBwQkK0MVahGbT64pL2qMXD0VzPTo5ZKvCI2cYmaI=
X-Received: by 2002:a05:6214:2b9b:b0:6c3:5e7c:8613 with SMTP id
 6a1803df08f44-6cbc9304727mr15883236d6.16.1728439056294; Tue, 08 Oct 2024
 18:57:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240929092739.2513768-1-daniel@0x0f.com>
 <172839506989.112860.11166419458122902632.b4-ty@konsulko.com>
In-Reply-To: <172839506989.112860.11166419458122902632.b4-ty@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:25 -0600
Message-ID: <CAFLszTiY7=hcg=5t6w0RfXs=C3NUMQXJkVs8PZyE281NTK_D3A@mail.gmail.com>
Subject: Re: [PATCH] cmd: Make bootvx independent of bootelf
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Daniel Palmer <daniel@0x0f.com>
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

Hi,

On Tue, 8 Oct 2024 at 07:45, Tom Rini <trini@konsulko.com> wrote:
>
> On Sun, 29 Sep 2024 18:27:39 +0900, Daniel Palmer wrote:
>
> > There are lots of usecases for running baremetal ELF
> > binaries via bootelf but if you enable bootelf you
> > get bootvx as well and you probably don't want or need
> > it.
> >
> > Hide bootvx behind it's own configuration option.
> >
> > [...]
>
> Applied to u-boot/master, thanks!

It looks like my review here was missed?

Regards,
SImon

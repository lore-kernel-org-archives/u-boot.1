Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1BBCDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 17:01:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD80986F26;
	Fri, 13 Oct 2023 18:58:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UXgys9KA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B32E86F1D; Fri, 13 Oct 2023 18:58:22 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B6CE86F1C
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:58:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59f6492b415so20133377b3.0
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697216297; x=1697821097; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GE+QB1rKp7KviRbrkZrPVlWbdlMCxCfbsivQN8JcUB8=;
 b=UXgys9KAoHVyHnphFka915qnFUR4NzeRafrC9hMcVMX4MxBwtn+rHXBEacXlYfalr1
 yXEfo26gvJ2KUTPubxULXw/1wOE6l5+XYbt02ikG2/qVez6CsU4WsTiqeJbndrCO+Z3H
 +Xfb2z7HAkVH7qCRmsPpH4OuXRwiElpQvUy0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697216297; x=1697821097;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GE+QB1rKp7KviRbrkZrPVlWbdlMCxCfbsivQN8JcUB8=;
 b=U8qEtbEEv5xB6nk1XNBwWhhC6z885iT8Jo2/Yg9RTT3k52O7WLqFG2EDNbRSmInyOv
 AbxQ7adQhlxu9EFkLXWnI9ZSN1y5ogOWSdCrkFbEZZvoamKuNqxA5Wc2LzQc8Le3HGUl
 9lBJYM7MimfX86JWZguRPoOQkGXVe+xgu9fYLS0Yiw7N54n+o6uPPkq/1uzB4NW7Cj2b
 QJh/NMSU1J5covur4Zf/Aqt/tg9aJZ3C3AZR6wFII9GO9WOxlvozIoimlRzwj0x0O78M
 Is6OvV8B/8cakGpSiAFB3YldSWD4TUucZa6BZ92IPQXSuVuBxyWA5wstLbroZZWp43Ul
 bnLw==
X-Gm-Message-State: AOJu0YwDVNG3nMYslWeBsJktcpuiud7jl74tN7t1ArttZieuMdQmrTIr
 N7ciLJzfrTyRPdKFaYCR1jZ0fRjcC6NwsPy+PBQtSw==
X-Google-Smtp-Source: AGHT+IHD+GDnOuRrxXrahOij51GNwWDNlLDw/Bffkwg3yQaAak2bEvAOVvnlxn62TJSAs+lBo+atDrI4PhFlE7F0UQo=
X-Received: by 2002:a0d:ea95:0:b0:5a8:19bf:87db with SMTP id
 t143-20020a0dea95000000b005a819bf87dbmr366935ywe.25.1697216297150; Fri, 13
 Oct 2023 09:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <4ccdb1eaf4094120c496eaccba30cd2473a7b0fa.1695817360.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <4ccdb1eaf4094120c496eaccba30cd2473a7b0fa.1695817360.git.matthias.schiffer@ew.tq-group.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 09:57:41 -0700
Message-ID: <CAPnjgZ3fhkvg803VwkfoAMKqMGi4zNtRbft652HxbVEHjAs4XQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] core: introduce dev_read_addr_name[_size]_ptr()
 functions
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

On Wed, 27 Sept 2023 at 06:34, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> Same as dev_read_addr_name[_size](), but returns a pointer, cast
> through map_sysmem().
>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/core/fdtaddr.c | 21 +++++++++++++++++++++
>  drivers/core/read.c    | 21 +++++++++++++++++++++
>  include/dm/fdtaddr.h   | 31 +++++++++++++++++++++++++++++++
>  include/dm/read.h      | 41 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 114 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F183CDB482
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 22:29:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6806186F3D;
	Sat, 14 Oct 2023 00:05:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nubKDHu7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93F3186F5C; Sat, 14 Oct 2023 00:03:40 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA85386F8F
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so92361866b.3
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234448; x=1697839248; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2YKrHKupZoSiQQvRz4vq01zN4kH3pdrAhF0NKZeJH28=;
 b=nubKDHu7aWNcn+R1YUYgZMCihomMY4DuiUzX4/7m+Mwhcv82XnhLOqELCegu0JZXMp
 jzug3kK4YZOFEmZMChYYmfast18jGbAu2wdQIzBQrRiSzajcpiy9piEAuiEuTkEmXCpP
 2pDZrKNh+pTLmQlDmk0ah51Tkkx/xxpcyIc1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234448; x=1697839248;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2YKrHKupZoSiQQvRz4vq01zN4kH3pdrAhF0NKZeJH28=;
 b=wOSaxFv3Yxg16I3/9836U1ug+N0vP7VYpEpoFue2cY8MYq1v383K0fQILtzdFvGio2
 eQYSE/ZOOyfR6oVWWQme5qCdVuM6cvOBI0UT26hFQwlljx+ICr0tE6HUxYTu5j6tz/4G
 bzFXV695g5Gn5E5CmkxjK4BRhn2CSxcQxCNo4FjaSlDfQX8+CKZ8f7EdpgKBEuOZd3oQ
 H3WkX4U/q3KAaIWEE4PqbwYxd4J3FOV60YD5v0TlpcHf09clFZPMLfsHS7GcRKYOBLCg
 plVvTgOcjsKjxSq2ZG9vZqONSxxD84YwAelL1AaGn5agRD1de+0F9dbaKbu0JZUdSj0c
 2lJQ==
X-Gm-Message-State: AOJu0YzjGTf+p+dBSE/zkE+9ZetJtKznNU+RfP0L8Rs/IOmM0wgoumPv
 5mZEJspLKVXvI4i+iWZhtcHM00cWM/8Rx4G2BSAExD9UUoVz70URcNs=
X-Google-Smtp-Source: AGHT+IEDOVTZBCpBThI6n83CKtVb1UchAW5MlR79A4fJWpe8WeVvksF9nKOfR3lWaN7U9qTH7SQCupQHd0Z7WINCDrU=
X-Received: by 2002:a17:906:3cb2:b0:9ba:65e:7529 with SMTP id
 b18-20020a1709063cb200b009ba065e7529mr15476642ejh.68.1697234448325; Fri, 13
 Oct 2023 15:00:48 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:45 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ2uGWaPsoMFO8u698Lc0xuTaLkr=Obae2H4ZAex=uB6Xg@mail.gmail.com>
References: <CAPnjgZ2uGWaPsoMFO8u698Lc0xuTaLkr=Obae2H4ZAex=uB6Xg@mail.gmail.com>
 <78309a6288060d9883de9f1406a2d81c4ca3904f.1695817360.git.matthias.schiffer@ew.tq-group.com>
 <fd0412ad51224c3afdf0a08870afa46127a42396.1695817360.git.matthias.schiffer@ew.tq-group.com>
Date: Fri, 13 Oct 2023 15:00:45 -0700
X-Google-Sender-Auth: de95Q7bDpZjrSv6qbkgStMRxMvo
Message-ID: <CAPnjgZ0e_1PvPNNANCpdQzkcbYdXfS7b4=SAhdUXkEt+GSYm+A@mail.gmail.com>
Subject: Re: [PATCH 2/5] core: return FDT_ADDR_T_NONE from
 devfdt_get_addr_[size_]name() on errors
To: Simon Glass <sjg@chromium.org>
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
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

Applied to u-boot-dm, thanks!

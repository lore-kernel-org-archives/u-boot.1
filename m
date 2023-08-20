Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC6DEE4993
	for <u-boot@archiver.kernel.org>; Sun, 20 Aug 2023 17:49:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4123586B86;
	Sun, 20 Aug 2023 19:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hwmmyzrO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F17B685F9F; Sun, 20 Aug 2023 19:49:07 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C59286A0F
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 19:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-529fb2c6583so1318745a12.1
 for <u-boot@lists.denx.de>; Sun, 20 Aug 2023 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692553745; x=1693158545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I33ER+GSS+l4HgxEnfua7fpSk3HIfU9Btg3TjA2nHwo=;
 b=hwmmyzrOLdjxEC3lKMnRu37SjWSdra+YclVivLYj67+enQ53dn/LJWbSPmD61BlcRW
 wok6e1ibxEL6p0aNYUA4LOEpa3/jReZkyiOer2dKIn9TbJIZC+pNOAAzcJPTaNlk4JO+
 QoPgGYe9IjjvWJMiR5Pive9jAz4M8TMwWeNxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692553745; x=1693158545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I33ER+GSS+l4HgxEnfua7fpSk3HIfU9Btg3TjA2nHwo=;
 b=Utce+InWHVVwAEBECbmUt03eulR5mubhlSMlOugLpISrxZ1+FgjpYuf3XPe8R5XORD
 uDQXXpUqYa85s9lDfU/mmagXOq1F8o6BjY1ZmcB6htTg5CvQeYO8nbc2N+PMoV1z7HNz
 3He3tCWHopo8iUDugovXUBlGo8KA1f88zjCylnWrNQcZgCUeUoB6igUNR8pM7/+qF2Cf
 J1oVHWuNwYGgL/AXFgLZXmqdtDWKY1MS7s5h0PEOYQY/I290fD35UuUlKAcNzpRbquVA
 yomhqO2CON38VQwM/rFUPWnj85XTsIqKDm2I0psOL6H5BLJuPBtKEqOjKFRfWnzdDQhY
 2HVQ==
X-Gm-Message-State: AOJu0Yzg8m+KlHYPENd5OvtvYhSCYUGW4eTshKvmFlROmk1Rw1uXtOJV
 LpHvAu2zCpEgo75w83M0zV8vqqEmB2VU9AKBfvO+UA==
X-Google-Smtp-Source: AGHT+IFuTbO+mpHgTwQYhiVvViS6C5vRHc7oTns2r0xdYE9+FSq9j57p45NvETrIl6EhDZLsiBLfZvfm0oawcUAkSsQ=
X-Received: by 2002:a05:6402:505:b0:523:4922:c9c4 with SMTP id
 m5-20020a056402050500b005234922c9c4mr3578034edv.11.1692553744759; Sun, 20 Aug
 2023 10:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230819142407.49632-1-marex@denx.de>
 <20230819142407.49632-3-marex@denx.de>
In-Reply-To: <20230819142407.49632-3-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 20 Aug 2023 11:48:52 -0600
Message-ID: <CAPnjgZ3ZD1hcMx-hFvpZXKkR6tbvaSQw6Api-QBQA8YvLFXz2g@mail.gmail.com>
Subject: Re: [PATCH 03/17] configs: sandbox: Enable DM_USB_GADGET
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Angus Ainslie <angus@akkea.ca>, 
 Dmitrii Merkurev <dimorinny@google.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Stefan Roese <sr@denx.de>, kernel@puri.sm
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

On Sat, 19 Aug 2023 at 08:24, Marek Vasut <marex@denx.de> wrote:
>
> Switch sandbox to DM_USB_GADGET, DM is the future.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Angus Ainslie <angus@akkea.ca>
> Cc: Dmitrii Merkurev <dimorinny@google.com>
> Cc: Eddie Cai <eddie.cai.linux@gmail.com>
> Cc: Kever Yang <kever.yang@rock-chips.com>
> Cc: Lukasz Majewski <lukma@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Stefan Roese <sr@denx.de>
> Cc: kernel@puri.sm
> ---
>  configs/sandbox64_defconfig        | 1 +
>  configs/sandbox_defconfig          | 1 +
>  configs/sandbox_flattree_defconfig | 1 +
>  configs/sandbox_noinst_defconfig   | 1 +
>  configs/sandbox_spl_defconfig      | 1 +
>  configs/sandbox_vpl_defconfig      | 1 +
>  6 files changed, 6 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

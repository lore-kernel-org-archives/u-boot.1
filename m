Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88E7C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BB9E8753C;
	Wed, 20 Dec 2023 05:46:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Oa1z/Vx3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9804E8752B; Wed, 20 Dec 2023 05:46:25 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A41338751B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:46:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a268dd99597so49916266b.3
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703047583; x=1703652383; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/p+saRITCJ78lgcdsOEUPOpXKpFRfZEj9HKi8cBbheE=;
 b=Oa1z/Vx3fV7l6HeOG4bVh3dlKbUzI+mlvNP8ObLd1VNQ3lKInViT/YRUR/sPQDQq3N
 FXz7SEwXzakr8nrIOVya2PED7Xx47JagMQdpAL2QselZDsAD+qgecgqq5xDGVaa1jUMP
 tQm2P9UFeE/oibeKUah4g3A8R1UkjSyZV8Xmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047583; x=1703652383;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/p+saRITCJ78lgcdsOEUPOpXKpFRfZEj9HKi8cBbheE=;
 b=Tf0fj0Wkd25ubtAR6gmwjfOuHhyUO5ws78+raxWaTqE7GeINKTsf8vw8Q/aXcR76vO
 LmSzYefxD9JYpNuWLS+ZL15YvNnOSSkvjvu5OaOyyTNmwaWu/wsFGm+WgGN8uiw+OcX7
 auidIUTSnB7GTi5R2PtGDgiQq8qrW7WQo5S3wkKWJ725nBvLeQfgrcpdSe+uuf868JZx
 lEmF7cBXyDBlUyFCxUBY2rujq4qaCFUi5dQN6FLsjWgd6hSG82L+Oy9Q72hzi6Gq+F4t
 MFkYh6UGHaexUjG+IAIi27PRTJC9odeVDJgdHQMNUIvVqnzSGwWYTZ8S/m8xaXcDH9xn
 Slww==
X-Gm-Message-State: AOJu0Yw2UMGtaVt+2wgadqiIrCapn7MgtQVlN+2VlzJGvuWpJJgVbBWX
 psgwO7gDluXy6OvMpG3Kmoto1DqIxBJ/MgpLqO0zTw==
X-Google-Smtp-Source: AGHT+IHluhzXW9z8vK+4ynMTSjRZYzLa8HaDLIL8oxhYbHHoCtr9vC8Rp1vjanbNqnj+24W6lpgNLkafDsyjhex3HAE=
X-Received: by 2002:a17:906:2d4:b0:a1d:fed:38d0 with SMTP id
 20-20020a17090602d400b00a1d0fed38d0mr4498387ejk.174.1703047582740; Tue, 19
 Dec 2023 20:46:22 -0800 (PST)
MIME-Version: 1.0
References: <20231219101225.3443978-1-danishanwar@ti.com>
 <20231219101225.3443978-33-danishanwar@ti.com>
In-Reply-To: <20231219101225.3443978-33-danishanwar@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 19 Dec 2023 21:46:11 -0700
Message-ID: <CAPnjgZ18vCeBT9ykZdF1iV8ten1OJti1qXyU5BPKmcf5kMmiUA@mail.gmail.com>
Subject: Re: [RFC PATCH 16/16] Revert "dm: core: Report bootph-pre-ram/sram
 node as pre-reloc after relocation"
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Andrew Davis <afd@ti.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger <joe.hershberger@ni.com>, 
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, srk@ti.com,
 r-gunasekaran@ti.com
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

On Tue, 19 Dec 2023 at 03:13, MD Danish Anwar <danishanwar@ti.com> wrote:
>
> This reverts commit 9e644284ab812f2db23f6185af77c0e771b0be73.
> ---
>  drivers/core/ofnode.c | 2 +-
>  include/dm/ofnode.h   | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>

Can you please add some info more info about why this is needed?

Regards,
Simon


> diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
> index 21a233f90f..cc2029e62d 100644
> --- a/drivers/core/ofnode.c
> +++ b/drivers/core/ofnode.c
> @@ -1485,7 +1485,7 @@ bool ofnode_pre_reloc(ofnode node)
>          */
>         if (ofnode_read_bool(node, "bootph-pre-ram") ||
>             ofnode_read_bool(node, "bootph-pre-sram"))
> -               return gd->flags & GD_FLG_RELOC;
> +               return true;
>
>         if (IS_ENABLED(CONFIG_OF_TAG_MIGRATE)) {
>                 /* detect and handle old tags */
> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
> index 5795115c49..5f1c8c2787 100644
> --- a/include/dm/ofnode.h
> +++ b/include/dm/ofnode.h
> @@ -1254,15 +1254,15 @@ int ofnode_read_simple_size_cells(ofnode node);
>   * determine if a node was bound in one of SPL/TPL stages.
>   *
>   * There are 4 settings currently in use
> - * - bootph-some-ram: U-Boot proper pre-relocation phase
> + * - bootph-some-ram: U-Boot proper pre-relocation only
>   * - bootph-all: all phases
>   * Existing platforms only use it to indicate nodes needed in
>   * SPL. Should probably be replaced by bootph-pre-ram for new platforms.
> - * - bootph-pre-ram: SPL phase
> - * - bootph-pre-sram: TPL phase
> + * - bootph-pre-ram: SPL and U-Boot pre-relocation
> + * - bootph-pre-sram: TPL and U-Boot pre-relocation
>   *
>   * @node: node to check
> - * Return: true if node should be or was bound, false otherwise
> + * Return: true if node is needed in SPL/TL, false otherwise
>   */
>  bool ofnode_pre_reloc(ofnode node);
>
> --
> 2.34.1
>

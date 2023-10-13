Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9A2CDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 01:15:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53C1586EF4;
	Sat, 14 Oct 2023 02:55:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HPlWL0A7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CECAC86F52; Sat, 14 Oct 2023 00:06:55 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41E7D86F44
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 00:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so4460662a12.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697234441; x=1697839241; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1FOeXWuCITgPyrYLJVhrf/SWU01n0BXqtpwYatQ32Ck=;
 b=HPlWL0A7y3pH3EYkXogPOQEKtvG99TriSQOABJ3G2sMAqxOuUwjOgTIAACkNATazq1
 xNYarIoJaDdxoy4we1Pz/UFyi88L2XeJPZL/YD5peA5Ps9Zk+mP5CVtki6dhmhYjo4mi
 O1pfA5gQLWPFzxHAtvm+Z5DbIsw7Cq/gnIYyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697234441; x=1697839241;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1FOeXWuCITgPyrYLJVhrf/SWU01n0BXqtpwYatQ32Ck=;
 b=sVas+yLRaL6B8Fa+grqwkm6oaTVzFcBxTDC0PGjEXHqM2uTnrh0uwqlTTSSG3YEUIs
 s76ZK7FE6lFRp4/pJflzikhCkGU+kVdsdakz6qnWTOZQj629+fQ+Ih607farKHS8/Jz6
 UPf83jpu3dXg8eqIXRusexL6XseoRoMIjxskiH/6cTwpsY77c2FaaE81PcJngGp/xHYh
 4BomgioBu6XRip6q5A3bhpnOPg7UIQTbLWzMxANCiXoFYunTSKCUDVblqXS31/wmvwdJ
 4HRKPcnEFpFXDUAbHC1zCTosfUw1OhuolZTyiCsJGEPtUegat5O841z6sAdUQWpIA9C5
 ydeg==
X-Gm-Message-State: AOJu0YxhgUewzoFY12NsXMd3uC1uLfj3hbI7K0z1xJz8qQ356T67Ekpb
 4NqIrqK4b70GfeLp2IgBYliGgZzx2hhmCldjxEEChvG5K93hNndPPjI=
X-Google-Smtp-Source: AGHT+IH5F7A0xorPQgJOyeRXzVGWw0e/Kfx5G3z2OCtdwx0iv35Ki7zkvQ5bCamlBRG2aN5njTE5l+EK44ZoIIxaJxM=
X-Received: by 2002:a05:6402:27ca:b0:53e:1825:d547 with SMTP id
 c10-20020a05640227ca00b0053e1825d547mr5725482ede.24.1697234440665; Fri, 13
 Oct 2023 15:00:40 -0700 (PDT)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 13 Oct 2023 15:00:39 -0700
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAPnjgZ1G2nyXdKp7KLxvZeN1bQbCYGWae_mHb59sRRBU+M0smQ@mail.gmail.com>
References: <CAPnjgZ1G2nyXdKp7KLxvZeN1bQbCYGWae_mHb59sRRBU+M0smQ@mail.gmail.com>
 <20231003005946.97653-1-heinrich.schuchardt@canonical.com>
Date: Fri, 13 Oct 2023 15:00:39 -0700
X-Google-Sender-Auth: mh33VHzn5kwe5xPZLb10M8_b12E
Message-ID: <CAPnjgZ30Dp_DQFUu5v-vH=O+V0nsUJMY1oYgSnGGQeTGLU2GnQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] sandbox: fix spl_board_init
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

On Mon, 2 Oct 2023 at 19:00, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> sandbox_spl_defconfig with CONFIG_SPL_UNIT_TEST=n fails to build.
>
>     in function `spl_board_init':
>     arch/sandbox/cpu/spl.c:134:(.text.spl_board_init+0x4a):
>     undefined reference to `ut_run_list'
>
> Add the missing configuration check.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/sandbox/cpu/spl.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot-dm, thanks!

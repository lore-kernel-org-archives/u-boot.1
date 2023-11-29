Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A35CC4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 18:18:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DB438758F;
	Wed, 29 Nov 2023 19:18:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="duQ/iLO6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7D1D87550; Wed, 29 Nov 2023 19:18:37 +0100 (CET)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6242E8761C
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 19:18:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6cddc5a7b35so8790b3a.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 10:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701281914; x=1701886714; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JGGnlYiYfmmvRK+bcgkqo7ik5XtfDQ1wq5Gga3nIorQ=;
 b=duQ/iLO6REmJfKmNxzgGEh6aPjPp4jRRyglArplY9CaNTqdAlAQ3anidUE7PFQ5yUL
 4TCDv5KcJg7iOAcPjxMQlueGB+sttLyz9+51/LTULNHxX2EjD2SGtk5nZW4rW4qSLALb
 aPvkUl5xVFowb+6jNcGn03qVZYiKzdil1tzMsqRyygzRFpPO7YLm4uCM4o58GbN4ZHon
 EORV3qpWpM+NjFnfaVEiB/D3OdtL2yoKFc6tk1v4qGWyjDk9KsR711ON6GhJ1aC/6RM4
 q5NV4aZqcU/x4Cw/rOno0h8qKvFjvh6UbmFPgS3+lTFjBuF8vnkK8aynT1l5aWExzDkz
 pEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701281914; x=1701886714;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGGnlYiYfmmvRK+bcgkqo7ik5XtfDQ1wq5Gga3nIorQ=;
 b=GAU5WkqkKcyC0l6/cYCoX8csaS7zVA7Z/gJ8DY4zy2o/84sZ32ccH/5yHYLdqjzcMz
 Wage/3lv9W6WVeETFAYntgHOXRdOFglK+KKgxPXK7/jY5UX5kaGuBckds/FPtjsFwCh8
 +HDexoaiugYYNs8JF0HlVRqlhv86EI0FJhExZn837GfhQEUzKtuMlk2Rbe5OAr/ZF6lP
 riWM2fFD7IvaaYX3T4OidKJUTdMajvZtMP/Tc+etdClNvvjErCkli6VhaepX64BYtW/v
 GjokhKVH8fJ82U/4jnbgpCxk1X2fHdFYCyWWTVqycRQQCgh7+nkn2bfwL6YngvtsBvgb
 nxDw==
X-Gm-Message-State: AOJu0YwQfoI9mHTypGnEHnkBiTSVHSKSjplgT7pYq5RikKwo1FQwIS5W
 HohHwkPL8PpuesGkkSG0KTX/suHOqQSuwvD/cEU=
X-Google-Smtp-Source: AGHT+IGOpPZeGeWrRLgvfR87bebW2jdnTjSpxQL97qn437xHpJ5qbhfYWvQZN5MwZ5N0RY6JBVTV+HVZsXelgtBBC4k=
X-Received: by 2002:a05:6a21:7896:b0:188:67f:ff2c with SMTP id
 bf22-20020a056a21789600b00188067fff2cmr26059760pzc.0.1701281913776; Wed, 29
 Nov 2023 10:18:33 -0800 (PST)
MIME-Version: 1.0
References: <20231109162401.38941-1-hiago.franco@toradex.com>
 <20231109162401.38941-3-hiago.franco@toradex.com>
In-Reply-To: <20231109162401.38941-3-hiago.franco@toradex.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 29 Nov 2023 15:18:23 -0300
Message-ID: <CAOMZO5D7f-6dqd+PG1bhwFWxESD4Z0ZLTkzdVQJ4GrRpE3+ESQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] board: apalis/colibri imx6/imx6ull/imx7: Add fastboot
 bootcmd support
To: Hiago De Franco <hiagofranco@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>, u-boot@lists.denx.de, 
 Hiago De Franco <hiago.franco@toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Nov 9, 2023 at 1:44=E2=80=AFPM Hiago De Franco <hiagofranco@gmail.c=
om> wrote:
>
> This commit adds support for Fastboot boot commands by checking both

Just a nit: use imperative mood - "Add support for Fastboot....".

> CONFIG_CMD_USB_SDP and CONFIG_USB_FUNCTION_FASTBOOT. If either of these
> configurations is set, it indicates that the board is in recovery mode
> and can use either SDP or Fastboot.
>
> The default option remains the SDP command, but if
> CONFIG_CMD_FASTBOOT is set, it changes to 'fastboot usb 0' as
> the boot command.
>
> Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

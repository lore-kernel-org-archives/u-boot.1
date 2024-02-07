Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABE9C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 16:00:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D299987C8F;
	Wed,  7 Feb 2024 17:00:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="I8JCFTw2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 373B587CA3; Wed,  7 Feb 2024 16:59:59 +0100 (CET)
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com
 [IPv6:2a00:1450:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C8787C4C
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:59:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2d073b54359so10500351fa.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1707321596; x=1707926396; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SJHLsmyLsnpYTs8F7PX+NqDAOEwtxkarApSiQwuPiY=;
 b=I8JCFTw2hvKy1GTCHU+NJfgEFHKtYgUscY5plM567wyCIlss+YYzVYGDpKxfcnsVUU
 cdIBrpu4jOeFyT5SX1cwxEsYGaVEvzrEj9qITnyi/Pzhjkrbk0LLnMH2e/PQefbxMyrL
 eirsIfr20RVdFqgn+tuU8fM0BQMt28N74qtomT5ihHcQof7lrpTSq4+evkJMJ9zXYO7u
 si7iC37rcGCikKOctl2sBdSNzTurkp5XTjpTcIe9yvfGM9A636Bv0BuRPOZyQktgZmZw
 zqj0j7I6aQJCFkj2CNyVPqk3wYRFaXQ/aaYzMRsJSNJ2vxSa/yPJtyoFpA3jCEoqhrqS
 8ljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707321596; x=1707926396;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SJHLsmyLsnpYTs8F7PX+NqDAOEwtxkarApSiQwuPiY=;
 b=VJgBUIPvf/GpVIdyz1GBmlw7mDLSl85Soqvr6cvJU1KZRqpJmyu0oh6tby5qiV24x2
 OKF8bwWs8Bhy1GOpzDdvaI2oFYwOJzUGSIbRc43NX1t+cpfWibeRBdbNjl6YAM2lTYeM
 6GD9lHL+BHcQ0nVWtCcWP8aKGtIZuQ+/kjVbsNG6ZN3CaDXNrSFqqlMco/HBQqsvvd9T
 yx2g5wz4lQ4iqyZBQn1HP4uDdrxiQOAAFVO/+VSFfMGdwVSySvDx98GYbdJrOSVY8Qvw
 H7QWSBcIEcd7PnrH7fq5ZCIMgEJ/joAR/skAgxO+NIrJoUXlLRH71jZN8E9VkOUyvAAT
 LtWw==
X-Gm-Message-State: AOJu0YyNuK9ofVjNE1W8ImPalZQgYgzbp+zuNITSF6ysdI5l9FGiCnPk
 8Y6p/adB3gphc+JEHItfjmYTrh3leAJJq6EqzsTr+5uHnHowjKw0xcwzn3XiUd/nj/xpsgj2esR
 9QO4x/sonkNqHs2N0gipehb8erF8rDwFYZeR9PLHPvyLoYqcW6Oc=
X-Google-Smtp-Source: AGHT+IHq1aUkCSt4SaLiUsa1TfaGHfnY/2fgMDYUTRARt8scfSxnI9Wv0IXnZQNUnYAgIFXhFSvGTnK2rQXqyATChbY=
X-Received: by 2002:a2e:b60a:0:b0:2d0:a6ef:651d with SMTP id
 r10-20020a2eb60a000000b002d0a6ef651dmr3922782ljn.47.1707321596144; Wed, 07
 Feb 2024 07:59:56 -0800 (PST)
MIME-Version: 1.0
References: <20240207141154.1.If0aa2d32c2ffde32ed1d87ab8a088db67bc2d25c@changeid>
In-Reply-To: <20240207141154.1.If0aa2d32c2ffde32ed1d87ab8a088db67bc2d25c@changeid>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Wed, 7 Feb 2024 16:59:44 +0100
Message-ID: <CAL6CDMHrdnw1yZ6gB3ZQz-ivVERiMExnzfhPUjrLBC9-9dcFVg@mail.gmail.com>
Subject: Re: [PATCH] stm32mp: cmd_stm32prog: add dependencies with
 USB_GADGET_DOWNLOAD
To: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>, 
 Tom Rini <trini@konsulko.com>, 
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>
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

On Wed, Feb 7, 2024 at 2:12=E2=80=AFPM Patrick Delaunay
<patrick.delaunay@foss.st.com> wrote:
>
> This patch avoids compilation issue when CONFIG_USB_GADGET is deactivated
> in defconfig, with undefined reference to run_usb_dnl_gadget and to
> g_dnl_set_product.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> ---
>
>  arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig b/arch/arm/mach-=
stm32mp/cmd_stm32prog/Kconfig
> index 8f91db4b46b9..589276282e44 100644
> --- a/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> +++ b/arch/arm/mach-stm32mp/cmd_stm32prog/Kconfig
> @@ -17,6 +17,7 @@ config CMD_STM32PROG
>  config CMD_STM32PROG_USB
>         bool "support stm32prog over USB"
>         depends on CMD_STM32PROG
> +       depends on USB_GADGET_DOWNLOAD
>         default y
>         help
>                 activate the command "stm32prog usb" for STM32MP soc fami=
ly
> --
> 2.25.1
>

Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io

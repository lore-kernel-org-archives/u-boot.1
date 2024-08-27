Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEF5C5472F
	for <u-boot@archiver.kernel.org>; Tue, 27 Aug 2024 15:34:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DC58895E;
	Tue, 27 Aug 2024 17:34:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="qG8nouvD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C82288928; Tue, 27 Aug 2024 17:34:54 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34BC8895E
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 17:34:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a868b739cd9so679268366b.2
 for <u-boot@lists.denx.de>; Tue, 27 Aug 2024 08:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1724772891; x=1725377691; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klf1bGHqzvcaUQhxHhQC61YM7huPW846TUtrKh8teZY=;
 b=qG8nouvDJU13uUOLDyosHzW8PZyMUBkWWlVrO2zbDNJvLd6qCkauWML53MvVuUtRHP
 RYafOXg4DjbxKlJ5fbZUcIxz1YKQsfRdB6U0J8MqC2Uene1kNu6AYy1O1uUiMkAEVI2z
 pb/ZqHO3yGHMaLodB1qzJVkGTvSmyY+ZK6AAGHnU9BB6eAa6xDEobRWqxh3LJKFrmID9
 JNEN6q56Pvh3r/zpQ35H+CGuEM1yOIRnhrcW5rRe6IKlAo+OL7X7sX1UFIa+oEwXVDDI
 3oJGzwQk9AeOHYRiu6GlJxeIIX0K/sjq4iKJ97dDUAumYfmh2yvGca15Az8zXBgL+pAV
 TFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724772891; x=1725377691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klf1bGHqzvcaUQhxHhQC61YM7huPW846TUtrKh8teZY=;
 b=YFcOuCM92liswfGOh+TI9h6kae1EjTZPXgjWSquPcEFjgY2S/L2obig83QU2doMEOl
 IS5CvHKW38aAyWJ5QF+jFNXoakiSpcX50FKceF0mX/m3lIdowc6/9OXnGt2VrFLZEC9T
 SGd/BETKJRZ5BHPaw0Zy0rmQ9wloOny0RkPnD217Usmsdwg47JyksisTdqB+1wvO1ANB
 Vx/ijS+00EYbzBG/7GHmpDwDm9r134po9E/sTwIpolqMF5blUTpREX3m9roU1p8HutX8
 44XbAbrG7KYEhuISQjDSho3UA0DCb9wo7iKaJASFmDdr5Cqdvmt5fNeC6z3EKibPCakF
 MgvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgnfZiQv04yfoo4a51enopuGXt6OXhGIombquQYfY/K9SBepb6it2YNb2XwBBFzx9sKcq5FCE=@lists.denx.de
X-Gm-Message-State: AOJu0YzisSBGfEQQiArB87jZk+kyK3LKxQmfNBofuoXMdlsOh6wwkvoU
 EZ+ZHBVhLkQBxCXtyN3y5OS0Zz0qyrhy+X36qdJMZhLBknO5aXd6iDbkGUD1jIMpCK4MN24rx2k
 Vc9klU6CI7oRks90cdbCVuH7AF8bBXcizXkqCpQ==
X-Google-Smtp-Source: AGHT+IGuZz3rB7LZer54cYUmhDaew521FIqP8wTzDP9rdh9zapGFmVKqXsIwZ44WyR9T0dP8B/brZY9Mhddn3p+dcEY=
X-Received: by 2002:a17:907:948e:b0:a72:44d8:3051 with SMTP id
 a640c23a62f3a-a86e39c9e4amr267686566b.16.1724772890711; Tue, 27 Aug 2024
 08:34:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240827005826.2831478-1-festevam@gmail.com>
 <20240827005826.2831478-3-festevam@gmail.com>
In-Reply-To: <20240827005826.2831478-3-festevam@gmail.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 27 Aug 2024 08:34:38 -0700
Message-ID: <CAJ+vNU1N23jisUTtD3-BrLUoe3JkW4K7OOXAsA2gaEyPLCZmfw@mail.gmail.com>
Subject: Re: [PATCH 3/3] imx: Remove CFG_MXC_USB_PORTSC
To: Fabio Estevam <festevam@gmail.com>
Cc: peng.fan@nxp.com, marex@denx.de, u-boot@lists.denx.de, 
 Fabio Estevam <festevam@denx.de>
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

On Mon, Aug 26, 2024 at 5:58=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> From: Fabio Estevam <festevam@denx.de>
>
> '#define CFG_MXC_USB_PORTSC     (PORT_PTS_UTMI | PORT_PTS_PTW)' can
> be removed from mx5/mx6/mx7/mx8m board config files as it is the
> default in drivers/usb/host/ehci-mx5.c and drivers/usb/host/ehci-mx6.c.
>
> Suggested-by: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
<snip>
>  #ifdef CONFIG_CMD_NET
> diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
> index 1491c509820d..a668eb70fc73 100644
> --- a/include/configs/m53menlo.h
> +++ b/include/configs/m53menlo.h
> @@ -71,7 +71,6 @@
>   */
>  #ifdef CONFIG_CMD_USB
>  #define CFG_MXC_USB_PORT               1
> -#define CFG_MXC_USB_PORTSC             (PORT_PTS_UTMI | PORT_PTS_PTW)
>  #endif
>

Hi Fabio,

Thanks for doing this - we are at a point where the
include/configs/<board>.h files are almost empty.

It doesn't look like CFG_MXC_USB_PORT (defined in 6 mx51/mx53
includes) is not used anymore so it can be removed as well.

With all of these outdated USB defines removed you could also prune
out the enclosing '#ifdef CONFIG_CMD_USB' and the '/* USB configs */'
comments in the includes but that certainly would be a manual edit of
the files.

Best Regards,

Tim

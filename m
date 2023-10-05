Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37BF0E9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 12:30:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7D8486A4C;
	Thu,  5 Oct 2023 14:30:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oh2cZJDL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 189A786A4C; Thu,  5 Oct 2023 14:30:19 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3772186977
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 14:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3248aa5cf4eso940027f8f.1
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1696509014; x=1697113814;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=RoAWXJkeExRphLVgS++XuW7S+E0kZKIA5LQ7ZtsgSgw=;
 b=oh2cZJDLdJHuHGStrXxBGEWLSP/5yif1utUjRQCD+IOICF0UOLCIE+KFHHziMrIaFK
 No4520xXHfOHK7FrHy7pszRW0hP4CvDbGbNFD6YGhCueZMNyGamevE+Y3oGKghv0+KI7
 43UbRABZ/ieZq4zBReVcCPSgm6GJ0VEMPVRuTKuBfUWT5xYDOEWOnJqrwNvgcpaRt0Q3
 jXe16rRzyQ+IriYD2w6Vf17xE6qf9RQfvNMX7OzuOkqtMxchS+BRcJlCjeBDkSXwPbXf
 vhzfhemoT5bI1W7MWTX8AGDkGXWdA8tZqBQh4am52jZc11SAuu5flLXruoYQ2o0ThbJs
 k/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696509014; x=1697113814;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RoAWXJkeExRphLVgS++XuW7S+E0kZKIA5LQ7ZtsgSgw=;
 b=HoILMAvqRrHbiCjghQXwycPzlZsZVq/XArrOcAZvXbdqdfFdqYBbUixJmY5Wds8hyx
 vqKi5ycCLVdwBMXn6xWZ7LobUjmmMzK/okaMVuIbYUkBW9IkQg0y1d4V3uvZSFftlQxv
 wGQMleo88y/aBef7UHlit7hyeQr7wrKyXPvohMAKsZ2y8K3i11FQDQOZzO6F+hW+x5TQ
 /6Ceg3HlG5gajmTjci6prerxOzUpj/JqWxJ/ztMHjprGZkOMGyWXKORMoVe51pg/smBt
 p05VgyRJPhNBuAhz4bnP10ZeF/L2hJk/n1zzVJ9LnE7h9G23o9hLEtj7DM/p4KO4OuyC
 XqDg==
X-Gm-Message-State: AOJu0Ywd9OuNSu3EaXBVsdBMzpK9Noqmnb+8GXF+u5rRA03i46nMskwN
 O0yatoX5NYh7M2TrX7J/t11rxA==
X-Google-Smtp-Source: AGHT+IGOwUvYfxB3EvIm58hdMJT/rbGvCo7rjI5Ux9Y98wf3AlqoBmtWprpMQDvtwzQcxQDNM1QZ0Q==
X-Received: by 2002:a5d:4bc1:0:b0:317:1b08:b317 with SMTP id
 l1-20020a5d4bc1000000b003171b08b317mr4756981wrt.6.1696509013829; 
 Thu, 05 Oct 2023 05:30:13 -0700 (PDT)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 d7-20020adfe887000000b00326dd5486dcsm1701124wrm.107.2023.10.05.05.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 05:30:13 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>
Cc: u-boot@lists.denx.de, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH RESEND v2 1/2] cmd: bind: Try to improve the (un)bind help
In-Reply-To: <20231002134621.94786-1-miquel.raynal@bootlin.com>
References: <20231002134621.94786-1-miquel.raynal@bootlin.com>
Date: Thu, 05 Oct 2023 14:30:12 +0200
Message-ID: <87sf6pb6az.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
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

On lun., oct. 02, 2023 at 15:46, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> While it may sound totally obvious for the regular U-Boot developer to
> get the parameters of the bind/unbind commands from the output of 'dm
> tree', it did not felt straightforward to me until I was explicitly
> told to look there. And even when I knew the command, I did not make a
> direct link between the arguments of this command and the columns
> returned by 'dm tree'.
>
> Several of us lost a lot of time because of that, I would like to kindly
> help other users by slightly improving this textual line. Unfortunately,
> because of how this string is used (like within the 'help' command) I
> cannot detail much more, but at least the pointer is there.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
> Resend: no change.
>
> Changes in v2:
> * Moved the details in the long text section as suggested by Heinrich.
> * Rephrased the help text as well, not fully following Heinrich
>   suggestion, but taking inspiration from it.
> ---
>  cmd/bind.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/cmd/bind.c b/cmd/bind.c
> index 4d1b7885e60..be0d4d2a711 100644
> --- a/cmd/bind.c
> +++ b/cmd/bind.c
> @@ -246,6 +246,8 @@ U_BOOT_CMD(
>  	"Bind a device to a driver",
>  	"<node path> <driver>\n"
>  	"bind <class> <index> <driver>\n"
> +	"Use 'dm tree' to list all devices registered in the driver model,\n"
> +	"their path, class, index and current driver.\n"
>  );
>  
>  U_BOOT_CMD(
> @@ -254,4 +256,6 @@ U_BOOT_CMD(
>  	"<node path>\n"
>  	"unbind <class> <index>\n"
>  	"unbind <class> <index> <driver>\n"
> +	"Use 'dm tree' to list all devices registered in the driver model,\n"
> +	"their path, class, index and current driver.\n"
>  );
> -- 
> 2.34.1

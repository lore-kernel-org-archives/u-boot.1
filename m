Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6DFC36011
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 08:04:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E67081703;
	Mon, 31 Mar 2025 10:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1mNlW1TQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C3F1819D2; Mon, 31 Mar 2025 10:04:53 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35EC8144A
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 10:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so34537555e9.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 01:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743408288; x=1744013088;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zl+y5hE17B3Nv3xrmuB/nFgHiO6YcxeqD76iVIOPbC8=;
 b=1mNlW1TQvpzYafodpwj4Y47fejwfWz9aq7lWuQerLX57KYr59GbbTa8RT37m+P/ONr
 pD/LYXdeFvUBFn5HsUBShIUXH1J7QLbcwP24+ZDiq/W3vE+WDvlXd5iO+LnKCV4QzTuy
 ex4jwcS/XKrw8ACvHuLWjiZpwmPpKWWGGDM3fGe7yBeTsoRO41V4N+spY7jx1BWNSvPH
 DD+a/YDqfkJJgMeiv9i8rop9/acmDlbulbQeN9xXBnBrdooBOur53LIgq7cPiB9w5HVf
 hH/BKFjAoWwqKkmZCTVfGTk2NxuJnRl7x/UEh0/3wRhE+qaIVwcF/KicoJaDSh4C0T+X
 yfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743408288; x=1744013088;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zl+y5hE17B3Nv3xrmuB/nFgHiO6YcxeqD76iVIOPbC8=;
 b=C6AV04ZfW9v70q9fP2mDPFDs6DEbbi0Edo/cwWprIwtqehY5zayV5uYOu95DC285Se
 I5HEbbGZU5vgu1BVw2v60igS99UWUuTvvPdFTMi722Rnidii3kVE3T9vgOgEsIyz5Kw8
 WQo6b2LuF+du1jzTn0g6AomEfRw5x1uAOi/lcEzvXnmPmvWfCaG4Glnt3Bbxq559W2BX
 zcQzjTiryxAGJcFeHhj2UcbfYwzKmRY38nXcRf1cIeMFIQz9Z4Ao/Wsk9WSkqiCTDpz/
 vH5x+1qkM4KX724tbmxfNeYd1NzP3Qz0MhuxQom/MDtFdAJqhP+T3X4DfVPqUB74hBHA
 WBBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTs/NYcHn5IWpjTjVDzBYl4+uHM2HBZOa05UUo+7HpZOeQ8Z0QgCfxh2Hfk6ab8/En6svXSFA=@lists.denx.de
X-Gm-Message-State: AOJu0YxgTQssCr3FD/a/Z8YTsTHXXYTUJElb4E5im45Y5BmlY1RZ8hwq
 AWSeOURzsUvG8fsbObRJ2QotHujEco4InmdMevJWRaIBEgFQEuA1bWQF4krPLpUwbEEtXeeUNlG
 g
X-Gm-Gg: ASbGnctHF+GeE/j8C+egrlig3hduMM5kcVSZD4B9+uguQuxEHiqPsJw/w2ePYvHf7Rk
 vYzoXhUejInRcSnw1TV3ZUnACSMTTe+o1/6MIdoknt/l5biU5t2nKSLPi5POC2lMcuaUcwRe6G/
 JGu+ukgQKLy4sEyC2k+XPrMbcROpolO3+xRsnFNmfmuQolODoLD0n2IHCeuSLW/OptdzOqYBUj6
 uSBZC7gmfMawOOV7/f1l5TKr38SI8FM0kJmqWyI5wHCjdV1RbJgvRMlVl1lNwYgq7Q8T0yXfQL6
 P9fMqZJmmIeWlgqEIdVtsL2NGtZJsAhtlPjebs+sv+M4wbWygj/hQkP4m4nsYuogXIjSQpnPTtg
 jLksELemV3fRpy56tjg==
X-Google-Smtp-Source: AGHT+IEJ8464eWWoPx/TX8H/IV1r8/vPFc17gZsti4ODXg+wsmiXz4Ke3R5lyN955TR17U/A1LcojQ==
X-Received: by 2002:a05:600c:8718:b0:43d:b33:679c with SMTP id
 5b1f17b1804b1-43db62bd881mr71136435e9.14.1743408288295; 
 Mon, 31 Mar 2025 01:04:48 -0700 (PDT)
Received: from localhost (lfbn-tou-1-752-68.w86-250.abo.wanadoo.fr.
 [86.250.199.68]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82efe966sm161504625e9.21.2025.03.31.01.04.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 01:04:47 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 06/18] fastboot: annotate switch/case fallthrough case
In-Reply-To: <20250327153313.2105227-7-andre.przywara@arm.com>
References: <20250327153313.2105227-1-andre.przywara@arm.com>
 <20250327153313.2105227-7-andre.przywara@arm.com>
Date: Mon, 31 Mar 2025 10:04:46 +0200
Message-ID: <87h639pqw1.fsf@baylibre.com>
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

Hi Andre,

Thank you for the patch.

On jeu., mars 27, 2025 at 15:33, Andre Przywara <andre.przywara@arm.com> wrote:

> The fastboot command handling uses an implicit switch/case fallthrough
> when receiving the OEM_CONSOLE command, but when this command is not
> enabled in Kconfig, to report this command as unknown.
>
> Add our "fallthrough;" statement-like macro before the default branch in
> the fastboot code, to avoid a warning when GCC's -Wimplicit-fallthrough
> warning option is enabled.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

> ---
>  drivers/fastboot/fb_command.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fastboot/fb_command.c b/drivers/fastboot/fb_command.c
> index e4484d65aca..2cdbac50ac4 100644
> --- a/drivers/fastboot/fb_command.c
> +++ b/drivers/fastboot/fb_command.c
> @@ -186,6 +186,7 @@ void fastboot_multiresponse(int cmd, char *response)
>  			}
>  			break;
>  		}
> +		fallthrough;
>  	default:
>  		fastboot_fail("Unknown multiresponse command", response);
>  		break;
> -- 
> 2.25.1

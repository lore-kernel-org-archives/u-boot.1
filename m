Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10D5C7EE30
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 07:34:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47BA0889FF;
	Thu, 29 Aug 2024 09:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jTv3W9+r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E7888360; Thu, 29 Aug 2024 09:34:24 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6894C889FF
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 09:34:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-202146e93f6so3417095ad.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724916860; x=1725521660; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dquML++yrjxa48JN9rWMB5Mgqd78IzZK8uVI5fV3JbU=;
 b=jTv3W9+rkLzOnS99R4ivbLY3y5QI7Rk6NXtrzPQlQNda51GZLXh0RyICN7SQfqb/w5
 YupI4WkvN5o68A5Amv79RLNRTDqf+kzw7a+YcTPhikd75/kVmo8mf1WSCO24G5WxSKg2
 490Xr51QqVIzInTMjMx5pumpTed5OS7a6zJ4mMZlmcwtfU0CTra98k7zsgT0mG2CNPtt
 S92c6q/IF7Cv2gkWgphBQVwPSC9ed/4rQnYD0nS7GepDBYAnbF6u3aiFCffdZ3kPSjuE
 DsMWwNkTKvZ22gjAPg7rtbWF5T/+D/8UfQ6LrfdLXdg0lCPz7S7AzjaZP5Q5C0e3JNeZ
 39Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724916860; x=1725521660;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dquML++yrjxa48JN9rWMB5Mgqd78IzZK8uVI5fV3JbU=;
 b=KqL/dJyJJ3auC7y3FvFL0SSWlc79U9xRax74FY3lRWWi59Hx4/P6K51yg1swUGizyx
 LfztHS/edK5R+8XgTfQ4KtsMYpgGDKE8c5BOcs3m/awZIiQwiVW6CPpeNLHb8X1XyqBg
 SgllHi2s9tvOp0t78AuEn/VgwGf1t3RDo+Uh3+/szPTGM8c4TJ0Eiy/i7xdnUQKGIYyA
 0MW/DrIhfkwq6RTW9I0Sk/l0YFF9GJzWEi0jOHnNhSy6KXCQOKe1SJX/WOzrgn9AbumJ
 ECRw7uHbXE/rkuYvFg2Ifx1GfEHAAXTw3d1nMkPeoViY57Pk5AXJvdVDHo5Bql27wdRt
 xzfA==
X-Gm-Message-State: AOJu0YwfplmzetIsfswnm0U04vddwdkr40gCe7nhtO6ccyCi41dLxfDE
 f7myW3iL0Hu8qxV+i3aJWstIk2jAGiDnBEIGXWw4t9BSJBZ74CoGQbDm/q1UV7yvOjWCgn85w+N
 1f7KlbE6NTrvmsDFUOFbPGlnb38Ek7XzAj9EqgQ==
X-Google-Smtp-Source: AGHT+IH0ekor7KQ48rPh8bg6zyr/s2ReiPjj49mqa2FB8bHLiQLpcKTgnAtxvwjxjzN/7HHH+GKUEj6imJXCZ2cltsM=
X-Received: by 2002:a17:902:da91:b0:1ff:393d:5e56 with SMTP id
 d9443c01a7336-2050c3d2563mr24271505ad.36.1724916859688; Thu, 29 Aug 2024
 00:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1724846454.git.jerome.forissier@linaro.org>
 <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
In-Reply-To: <1a6084e845a0612546a1e86d142208af945c8f77.1724846454.git.jerome.forissier@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 29 Aug 2024 10:33:43 +0300
Message-ID: <CAC_iWjL9g0c8UHF3L44b8HEG-2=d57XsDXPpSogthWDPgzPcaw@mail.gmail.com>
Subject: Re: [PATCH 09/13] net: wget: allow EFI boot
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Masahisa Kojima <kojima.masahisa@socionext.com>,
 Simon Glass <sjg@chromium.org>, Yasuharu Shibata <yasuharu.shibata@gmail.com>, 
 Marek Vasut <marex@denx.de>
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

On Wed, 28 Aug 2024 at 15:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> wget followed by bootefi currently fails as follows:
>
>  U-Boot> wget 200000 192.168.0.30:helloworld.efi
>  Waiting for Ethernet connection... done.
>  HTTP/1.0 200 OK
>  Packets received 13, Transfer Successful
>  Bytes transferred = 12720 (31b0 hex)
>  U-Boot> bootefi 200000
>  No UEFI binary known at 200000
>  U-Boot>
>
> Fix the problem by adding the missing efi_set_bootdev() call.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  net/wget.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/wget.c b/net/wget.c
> index 0e4dc5159d..cf7681a4e7 100644
> --- a/net/wget.c
> +++ b/net/wget.c
> @@ -8,6 +8,7 @@
>  #include <command.h>
>  #include <display_options.h>
>  #include <env.h>
> +#include <efi_loader.h>
>  #include <image.h>
>  #include <lmb.h>
>  #include <mapmem.h>
> @@ -429,6 +430,9 @@ static void wget_handler(uchar *pkt, u16 dport,
>         case WGET_TRANSFERRED:
>                 printf("Packets received %d, Transfer Successful\n", packets);
>                 net_set_state(wget_loop_state);
> +               efi_set_bootdev("Net", "", image_url,
> +                               map_sysmem(image_load_addr, 0),
> +                               net_boot_file_size);
>                 break;
>         }
>  }
> --
> 2.40.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

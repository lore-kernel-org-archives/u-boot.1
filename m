Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70373C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 07:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB5D080104;
	Tue, 18 Feb 2025 08:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BZS5kOlU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7B8D8043C; Tue, 18 Feb 2025 08:43:46 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A563800B3
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 08:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e033c2f106so4246995a12.3
 for <u-boot@lists.denx.de>; Mon, 17 Feb 2025 23:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739864624; x=1740469424; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zprdRkiZKXnPMQqrhL0uDcfD79xnqYfdV3vzDs1e2PY=;
 b=BZS5kOlUXacFyJoBznuF04oRWKgyYflTaZ9bmLFm+f2GCHmspDiOQ9RlIsGyvQnJ7x
 w94caSFzUTY1NW434mHKAct/dBPK8rV2ikoDVqk6UNEH/UD2vcsUHr5TJMjJF9ZdGYl0
 OUfMa3ccqvPPaOkF+Bpb1kPwJ6+zWBgiCbgwpvyZKvvaK6MYzjMEgpSMA06gilv+GK8b
 dY0qy/DyvGCSpGUqFxkyLsoO7EFhNDh2X4dcH0xRzj4Bn+VPo0y+6N+ebpNW/d7sn+9+
 dSDP2xM4fDWtblF1iHKr2WtuNLGy2nVRJAnyKDXtrnOHqX1//S6CBr9MKNxzwKt1TC9J
 Ha4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739864624; x=1740469424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zprdRkiZKXnPMQqrhL0uDcfD79xnqYfdV3vzDs1e2PY=;
 b=qxxXvPWedhag1urp7zLvs/dfmrI5krOqeP8wpedmcA0hFpbJVkH2QEcYCXvoPvX2mT
 QoGXViZz0kD9arBNyfC+8UjHLfOSey4TreNTZIBTG5+tCSJfUYtCBC+UQfT6i/gzcx0Q
 hM1aSFVvQQ0uwEkEVaYAOiQMLCpnL2B7JGf/uMXiBNtRgnrxynzYuqcYk1I0qnJbVDhp
 vG+by2r/zkVcP+l7dcHJ+qSUjUadFhL2Hp4kiMni3SIrOWnKf1SymNkOiz8M9X9bOZlC
 QUuP3qTp2ndZeqwaRbuk34NviZnQCtA3SlnWUnlTFNjftnow01mkAg9nmXholf5ygA2t
 ELvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+ZubT5QJaa1+X1bDR0ffsE3ScJFwxJ8WmjuzWiivzL0Ni4wvqe9GQ4ta5HnwkIKZOPvHrA5g=@lists.denx.de
X-Gm-Message-State: AOJu0YwwP7SgG9wBCZb0vf0tyv3IcPITUDqmo8+VGySkKu0OcY61UBI1
 KZL/y4u7J7S1Sla3sLoK3AUXhIFaiVdkl6/iQoWMuNbvJPTbYGcpbm8R6Z0QSB8=
X-Gm-Gg: ASbGncvdy7xNZcE8wPG5XcDd4CeFD0yo3j18bXt6d7oN/TpY/CZ+DVETdZCAoTcQVk4
 BF5sAtPrL5XG4KB/s5s41yL6558Ui7F2GPOhan0apabwwPObwTlC7Sle0f4sODwuZ9GhR9hrwer
 2aA+QVAJVy665Dohj5/1S/qKW89/wyfSnlG/ngY3VHVAgBepxOr5B1M6hN3+WiFJFptC/XlfzP/
 SKWDzUaOW35ghUyRL9QB5nHOCRZ6fk7Pcf9uANwkn7l/vIaInw38cJ8znNBYCYeTRYBjabbGnSX
 CcOFglL4aw2QHVUTaKoNJt1oKAJ3pfRqccefVKX0QpOF/6k=
X-Google-Smtp-Source: AGHT+IG0Qp/vjBMmcTueB4639VWRAjufeQNqkV9su20hLcDbq7i40VRyM4o6Cz+9JBk6pMhy4y7FxA==
X-Received: by 2002:a05:6402:34cc:b0:5de:bcdf:bf3e with SMTP id
 4fb4d7f45d1cf-5e035f255e8mr36979475a12.0.1739864623861; 
 Mon, 17 Feb 2025 23:43:43 -0800 (PST)
Received: from hera (ppp176092155198.access.hol.gr. [176.92.155.198])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abbaae6cc86sm197881166b.143.2025.02.17.23.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 23:43:43 -0800 (PST)
Date: Tue, 18 Feb 2025 09:43:39 +0200
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Udit Kumar <u-kumar1@ti.com>,
 Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Hari Nagalla <hnagalla@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Santhosh Kumar K <s-k6@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Daniel Schultz <d.schultz@phytec.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aashvij Shenai <a-shenai@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Wadim Egorov <w.egorov@phytec.de>, Tom Rini <trini@konsulko.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Lukasz Majewski <lukma@denx.de>, s-vadapalli@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v3 1/3] xilinx: dfu: Fill directly update_info.dfu_string
Message-ID: <Z7Q6K74Y4iI6sxnd@hera>
References: <20250213195351.3518305-1-j-humphreys@ti.com>
 <20250213195351.3518305-2-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213195351.3518305-2-j-humphreys@ti.com>
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

On Thu, Feb 13, 2025 at 01:53:49PM -0600, Jonathan Humphreys wrote:
> From: Michal Simek <michal.simek@amd.com>
>
> Directly fill update_info.dfu_string to prepare platforms to switch
> from using dfu_alt_info variable to dfu_string which contains description
> for capsule update when switch is done.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>  board/xilinx/versal/board.c  | 3 +++
>  board/xilinx/zynq/board.c    | 3 +++
>  board/xilinx/zynqmp/zynqmp.c | 3 +++
>  3 files changed, 9 insertions(+)
>
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index b4483d00ad1..2c387630a61 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -8,6 +8,7 @@
>  #include <cpu_func.h>
>  #include <dfu.h>
>  #include <env.h>
> +#include <efi_loader.h>
>  #include <fdtdec.h>
>  #include <init.h>
>  #include <env_internal.h>
> @@ -438,5 +439,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>
>  	env_set("dfu_alt_info", buf);
>  	puts("DFU alt info setting: done\n");
> +	update_info.dfu_string = strdup(buf);
> +	debug("Capsule DFU: %s\n", update_info.dfu_string);
>  }
>  #endif
> diff --git a/board/xilinx/zynq/board.c b/board/xilinx/zynq/board.c
> index a852d5b8ed5..bd004b86a88 100644
> --- a/board/xilinx/zynq/board.c
> +++ b/board/xilinx/zynq/board.c
> @@ -7,6 +7,7 @@
>  #include <config.h>
>  #include <debug_uart.h>
>  #include <dfu.h>
> +#include <efi_loader.h>
>  #include <init.h>
>  #include <log.h>
>  #include <dm/uclass.h>
> @@ -199,5 +200,7 @@ void set_dfu_alt_info(char *interface, char *devstr)
>
>  	env_set("dfu_alt_info", buf);
>  	puts("DFU alt info setting: done\n");
> +	update_info.dfu_string = strdup(buf);
> +	debug("Capsule DFU: %s\n", update_info.dfu_string);
>  }
>  #endif
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 820fb252a3f..8060d54428d 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -11,6 +11,7 @@
>  #include <dfu.h>
>  #include <env.h>
>  #include <env_internal.h>
> +#include <efi_loader.h>
>  #include <init.h>
>  #include <log.h>
>  #include <net.h>
> @@ -734,6 +735,8 @@ void set_dfu_alt_info(char *interface, char *devstr)
>
>  	env_set("dfu_alt_info", buf);
>  	puts("DFU alt info setting: done\n");
> +	update_info.dfu_string = strdup(buf);
> +	debug("Capsule DFU: %s\n", update_info.dfu_string);
>  }
>  #endif
>
> --
> 2.34.1
>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


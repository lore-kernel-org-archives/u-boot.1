Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AF2C4706C
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 10:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E29BC876E5;
	Tue, 16 Jan 2024 11:57:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bTzSOxg1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E548798C; Tue, 16 Jan 2024 11:57:26 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DEF3684694
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 11:57:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3366ddd1eddso7913321f8f.0
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 02:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1705402644; x=1706007444;
 darn=lists.denx.de; 
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=1shlkjQ+sXfWEfVbIyNQhXFu9EsATVyig0jzpm1/0cc=;
 b=bTzSOxg1wYJ34qTGklVNkMCcMtrh1xjdU1MvY/wgN5icBjkCw39Q4oqyef2bWHSNsU
 VokrUIAswOB17dSkYVXxS0V5Mi0FuDm3E47mlqWGvcQnrDCYzhUJtuFU7PqPytg8H4jp
 P/2Kxer/Gv/dG0XVfs7zDCmNqu0QJO3Z/rjcSRGrgP/cisrSNejiJQ1hHPzkKvvAn9QB
 YTCrr6s+is3Uay3nnz5QKmQuK1B8KhERrrPebZ4KWDXWPB9N0z4ORXTnpUhfGqMpMGq1
 GOyYNKv+ArLzwg0fk9gJ0VMadFfoeLrnYc0dWTwiuh37lt0kQkBLcRTNixAQGaFhiYcG
 Z0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705402644; x=1706007444;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1shlkjQ+sXfWEfVbIyNQhXFu9EsATVyig0jzpm1/0cc=;
 b=ZUdDnZhg4r86LVt9GlKmrw6IKLnA1cTecxaTSYjFnToBwq4Pxyv3zsD6WXcUnOErUb
 hD8bJnaFSCHPZBImXwycMfbljBIRzaFqwSWdbcSgBIyOEOM3NoA3LqmC++nP7SIP3VLY
 lfkPCX2xEDAIdE1qo+tF2fKuXqarJGqDWRQPYOXt/5UlZW3P2zNu6HaWjofMsH+imQBx
 iZPG5bQJpPLMwVWJ2R6U0UeDEh4TJa97rAr8VeEKtuGromc69KbF5Utg2tf2JSZS3uzf
 aXjiF8DtoWi397PJIpHJU6K8/qWH3UywIOhXjl3GzoGQkHhb0oyOtYizSCwIlNegRXLM
 +YVw==
X-Gm-Message-State: AOJu0YxS1IcSeBoAPGW9TMq1E+mBWpSv7wAJffOFRhGTRddxzcMxXfpP
 OppQ7mSsbCBFODfvYCa/vdCO0j5QCXqjHg==
X-Google-Smtp-Source: AGHT+IGf46gXjs0QPdhqO3koQTyMRRc4kf/G2f6tKUuHHpOEeM0jHg2PWoul86niNfKF0XjWasPlmQ==
X-Received: by 2002:a5d:69cb:0:b0:336:9e8a:6fe2 with SMTP id
 s11-20020a5d69cb000000b003369e8a6fe2mr2316792wrw.90.1705402644360; 
 Tue, 16 Jan 2024 02:57:24 -0800 (PST)
Received: from localhost ([82.66.159.240]) by smtp.gmail.com with ESMTPSA id
 k13-20020a5d518d000000b0033672971fabsm14192688wrv.115.2024.01.16.02.57.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:57:24 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Sjoerd Simons <sjoerd@collabora.com>, u-boot@lists.denx.de
Cc: Martyn Welch <martyn.welch@collabora.com>, Roger Quadros
 <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>, Andrew Davis
 <afd@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>
Subject: Re: [PATCH v4 3/7] board: ti: am62x: am62x: include env for DFU
In-Reply-To: <20240112085317.1866449-4-sjoerd@collabora.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-4-sjoerd@collabora.com>
Date: Tue, 16 Jan 2024 11:57:22 +0100
Message-ID: <87h6jd4kbx.fsf@baylibre.com>
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

Hi Sjoerd,

Thank you for the patch.

On ven., janv. 12, 2024 at 09:52, Sjoerd Simons <sjoerd@collabora.com> wrote:

> Include standard TI K3 dfu environment
>
> Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add dfu via environment rather then config headers
>
> Changes in v2:
> - Minimize config changes to just DFU configuration
>
>  board/ti/am62x/am62x.env | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/board/ti/am62x/am62x.env b/board/ti/am62x/am62x.env
> index e53a55c38fb..0651b9cd7cb 100644
> --- a/board/ti/am62x/am62x.env
> +++ b/board/ti/am62x/am62x.env
> @@ -1,6 +1,7 @@
>  #include <env/ti/ti_common.env>
>  #include <env/ti/default_findfdt.env>
>  #include <env/ti/mmc.env>
> +#include <env/ti/k3_dfu.env>
>  
>  name_kern=Image
>  console=ttyS2,115200n8
> -- 
> 2.43.0

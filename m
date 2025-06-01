Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F56C5B549
	for <u-boot@archiver.kernel.org>; Sun,  1 Jun 2025 13:35:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C331382A36;
	Sun,  1 Jun 2025 15:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GpffvWi1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03C4182AAF; Sun,  1 Jun 2025 15:35:40 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0952282A0A
 for <u-boot@lists.denx.de>; Sun,  1 Jun 2025 15:35:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5533302b49bso4695396e87.2
 for <u-boot@lists.denx.de>; Sun, 01 Jun 2025 06:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748784937; x=1749389737; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/eG+gPu8tuigW1HoPT1lLe8uXJNzcCQOzaj2HNSvBE=;
 b=GpffvWi1T2PMf/7h80tmRSN3vLOwId3EO6x3Lu/eM/soxmW+50aapDzzgDYu9AKbpo
 X43mL2uCZpsZvhm6aLwjzr5TxwTYsfpX/T7nYfI7oFnNhkS7qMYhjqjkAvpLhRKmMkmV
 RMqO8el+c9Gf1UwihjKFcpCMMSaiXkxaSCZxpoPPovUXGXSEA7aj76uvZJ61VvT2ZsSI
 Dc+dA6MP26XKACOBBKXKb+tFRyzy9ZSAWkrM5+ymYdG8BU9r0KLTcEjPbaIvyXZUd04D
 tisBGP2/OQixoPeCPZQf6wBcPhrOKhUusep8L8nGV2llqcZiCMTm1V8TRoH6kfUTnRJT
 ilfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748784937; x=1749389737;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/eG+gPu8tuigW1HoPT1lLe8uXJNzcCQOzaj2HNSvBE=;
 b=AfvJ5DNqfel7GHBbDj1BJKUcW2ZbRIS4pm2FDA8NsyWJHytUPc1uF3kw4l1u7/Qu76
 +uILpJ6ZpwUbdHl9npnsAaYvPIEmji9sHbNCrARsvoUf6Aydct6z2NPeHhIRsWy7AglR
 fC/U2GdVokvs9FiUyCK8HrH8/osTlbZoal76L2VyfGGKET7Il02Pv1lH7LklgnGTK+I2
 fXmRYVLSv1YsIcx8WuU8KkgmaecRm2WNb3QAMEV5h0YBJgahRcJRvjEJM+4DP3cSqErp
 YVzPv7K8ZESg8mIxGNXuV/vOm+/ja1cYm+gNUJIdoJRh17bQRIbR6czAMyoPvKaD0H3V
 /GkA==
X-Gm-Message-State: AOJu0YzPHdDbwa6KmQr21kZXti8WFLob6R+/65D2qoExe9cMZgz+/Uzu
 xRbNSM+IxrN4jvhirLl34EFnN5jqZvywDSKoYxsyV4f2qSazv+PtrqYHlBNYpaT/K4y5iGreJxc
 c+KRxgXOFj342VeLmCow1U0GncZNZy0w=
X-Gm-Gg: ASbGncv8RY1OHrn3FuiJy0imVRnMIMJO26Y2Xdf0X8psQVZiY0IhvC2FmBNJCVb5g1T
 qSAnIcPC6pZCxNnQz/35k9oMPsNFUDhaUn2ZsJTv7ZX03ldcGlsvuZGGJr2U/RXhC8qOg4daCup
 Lz3Se2PsfhYinqtfhuSomchqeAe66f/V2AQsa6iZdnzRoaFIT1DBHkoUpqaTZsdS7H
X-Google-Smtp-Source: AGHT+IH0SX5ai1+69u11ie8O3UCkL3lJLjA8wgxaUh9lpn6EzmijlCS0MS2j5rHcmQOW9vrAc7FpMFOJIuukX8n9YrQ=
X-Received: by 2002:a05:6512:3a95:b0:552:1c1b:556 with SMTP id
 2adb3069b0e04-5533b8f5591mr3424657e87.24.1748784937146; Sun, 01 Jun 2025
 06:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250530151653.3695020-1-michael@amarulasolutions.com>
In-Reply-To: <20250530151653.3695020-1-michael@amarulasolutions.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 1 Jun 2025 10:35:25 -0300
X-Gm-Features: AX0GCFuHbaqO9gZzGFQ1fJ85Tge6VgibSRfdusRpx_ygotxK8u57WXr93rPVmsY
Message-ID: <CAOMZO5CmcLPXaxziHLjnVomJKZcP0U2rohah_i79ZsBSky04_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] clk: imx: add i.MX6UL clk driver
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: u-boot@lists.denx.de, linux-amarula@amarulasolutions.com, 
 cniedermaier@dh-electronics.com, Peng Fan <peng.fan@nxp.com>, 
 Adam Ford <aford173@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
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

On Fri, May 30, 2025 at 12:54=E2=80=AFPM Michael Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Add i.MX6UL clk driver for i.MX6UL CLK driver model usage
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Tested-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>
> ---
>
> Changes in v4:
> - Fix Kconfig typo
> - Fix IPG clock duplication
> - Add space for consistency in block
> - and other minor

Applied the series to u-boot-imx/next, thanks.

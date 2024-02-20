Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E39C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 17:20:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C77E87FD2;
	Tue, 20 Feb 2024 18:20:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QRVhUdDU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A2BA87FE3; Tue, 20 Feb 2024 18:20:43 +0100 (CET)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB12987DA2
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 18:20:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-55b5a37acb6so1689198a12.0
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 09:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708449635; x=1709054435; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6to8vzuihTvs6zgw2HzCG+EsnFxLppLdglwlQtaisQ=;
 b=QRVhUdDU3c6AUgwAqgXWnZ3gw9OfvAirTNcPa867rpVeZ3QK9kycwhbMBeqYWW42JC
 We0+VwzMOB+Hk2d3Qod0nqby5agAWO9I9xRu0Xl6cX+xe7Dl+hk+bcGfC5k4juZm67UW
 Bd/XvQ1MNrIvBcil52aW8Ld6BwCl0RWoAO2XSeT1yFp/YZuSa6FdKISkpugl8EnvXbh7
 SCWmHrvVUjk6/AKHm8m6FcVX2ifFOuGU8RXVzv6yfznnSR1e0AheBfmFyaXVH9c4hAVh
 4mVldI3JNmznL5Kpwnn2pB325iwWDx+hMFqdyZ7S9ZGNREboq+PGu1QYqNJr5wo4WgAx
 J7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708449635; x=1709054435;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n6to8vzuihTvs6zgw2HzCG+EsnFxLppLdglwlQtaisQ=;
 b=NbNGG9f5UtAitvIb5aO+lycqRh7brqRVpxtIs3Mkt3koKy/nGC5DAmRaDlrsiLlmX2
 PCIkcrfpSIuLMEGkfxRE7YnlyzMEyjwR6QrZ5tBJLjpLU41IMnHLk3FcuPzN0gqa7TU7
 U5/U6F2zgPxcvfNQn+/0KZrRoFwJDo4c440n7tvyS830TrGF7+YTCZYgvufUyar8DF4F
 rZEGa1p2+75pNK6iB0q3TuGIPk8E0SESUKtwixdlsgBK2mdPQOEqhTE9aQIIywo+tpyz
 6ge/1ISzpnepyEz76/vxO+BB2n3RJf38PUYb8vJPsLCpQbESsaAtAOYG/ykCGUv79Itf
 pBrw==
X-Gm-Message-State: AOJu0Yys7IPcRk4cBR0trE//Q3bqXHdpV31dyKFUalePwU6J+uM1Io90
 VWhYMsmzIrR7TxEdU8TeZT3sN5k6h7Thr1iSu0GcAkrZRhIL+UAQ3jgzTAyE0PHdYw9AQ7yrVTU
 3y7JKukwFx9IPtftlMj7M1MkE6eo=
X-Google-Smtp-Source: AGHT+IEMUvnQMFys6U5zh/5w3SiedvuQok2EhPB6BJKPYBsR/bcKWi5QjRJ3VYjutD1kWI9Lro8TZRR+WnlewXX6bQ0=
X-Received: by 2002:a05:6a20:2587:b0:1a0:b3b6:e2c9 with SMTP id
 k7-20020a056a20258700b001a0b3b6e2c9mr2913205pzd.5.1708449635075; Tue, 20 Feb
 2024 09:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20240219230100.2980309-1-Mr.Bossman075@gmail.com>
 <CAOMZO5B+eZhJOifRiux0n8VXLkQgwc8Q8215ybJgJ-LHE8RAAQ@mail.gmail.com>
 <CAJFTR8Tjk8b-DZGxu2f4-LBoZdSqE5oDvyTY-DDOJYUU=DSvcA@mail.gmail.com>
In-Reply-To: <CAJFTR8Tjk8b-DZGxu2f4-LBoZdSqE5oDvyTY-DDOJYUU=DSvcA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 20 Feb 2024 14:20:24 -0300
Message-ID: <CAOMZO5CAev9T_627gV88Rzcc7AE1jYpm0EyBJ-eSPcEJ=X4V-w@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] imx: imxrt1050-evk: Add support for SPI flash
 booting
To: Jesse T <mr.bossman075@gmail.com>
Cc: u-boot@lists.denx.de, 
 Giulio Benetti <giulio.benetti@benettiengineering.com>,
 Stefano Babic <sbabic@denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
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

On Mon, Feb 19, 2024 at 11:50=E2=80=AFPM Jesse T <mr.bossman075@gmail.com> =
wrote:

> Huh, this is very interesting and I haven't noticed before.
> When sending git send-email lowercases my email.
> It seems like all my commits are like this.
> Do you want this fixed?

Please fix both issues and submit a v5.

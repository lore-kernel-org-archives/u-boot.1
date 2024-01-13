Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64235C4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 19:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CDA987933;
	Sat, 13 Jan 2024 20:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wi30djuJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81BDD878D6; Sat, 13 Jan 2024 20:53:13 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C76AB87933
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 20:53:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1d5595997ffso11416475ad.1
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 11:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705175589; x=1705780389; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zc7Z8bsE0jLhkzu1fBZef7FDO9/F09T6N+QyqksLtQU=;
 b=Wi30djuJmeIQMK547Bm1QqcxfikyX35DrDIsU8T6dJSmBRdof8XwxQqp6nm0drMvX5
 RjCdvuwKlt/wZQx3oP1+QHCCU4qxdhQhZl7pm56yF0CrRN9Nil/avGPR5IelUD6ETm65
 qVX2n+FhZDeN13kdQmV+oZJc66ocm2TS4xitDfAHBc1MphHrNE1VLyRvKk0OhiYx3EVo
 fgpkT/koFNueMavePX09oQYPxrBtOv2a63JYfaOArVdYVpd9lzu2aJjTLwIJX6UYWXYP
 AV/HtuusfLm98uxXDL4j9R42JZjmKVAw/1lWXT5mvjBLyH2ZNHErrpQqU8x/o56XlOAP
 olPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705175589; x=1705780389;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zc7Z8bsE0jLhkzu1fBZef7FDO9/F09T6N+QyqksLtQU=;
 b=P/ALOEHOgnQ/R26DYwbUV1KXFNxtsCQ1Rt+n66VV9RjpkT5UwjAALRFyt4KwuXmtGk
 0gU4+esVQ0Ss1JCyQA5N8+79qsyAiIC9oqlxPKwyShwfYtDnZPfSq+90AJF4twBzgihC
 VQ+i92OPbTMFmULxFUystIFeigSFnPG7e1D6WDEdPosZKXw85750blRgRyWF2MX22Tck
 31cCAJB78Sf3acckPXy5lWUWb6W4neTnxwTLQ0Mm9eIsPZSMI7ozhg1vPbxrOieYrf5o
 V1nKfTUM0KA/AIfIPNLZTeXL9WrHSqZtbVw7spjuDBFM8Z7shpE7fkZm3qwko5Lfm4Nr
 AdKQ==
X-Gm-Message-State: AOJu0YxHLZeLEmU8D2xVYdm3VWvZFsnYldmY+WoFVBmdwksC1qpd2urU
 TwTxthQ4OOfPOztcVlMwFBZ+bz4qtFhAWABdgE0=
X-Google-Smtp-Source: AGHT+IEXffSMlyQAeIjDW1OrT6B/kduQqCGg14ZDHdY5wVcPzqgaKUdYsNsDsh9UwId71WnBchbzGHrInqj3oMJUBQc=
X-Received: by 2002:a17:902:d50e:b0:1d4:e2bc:891c with SMTP id
 b14-20020a170902d50e00b001d4e2bc891cmr6213389plg.5.1705175588822; Sat, 13 Jan
 2024 11:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20240113183350.176131-1-marex@denx.de>
In-Reply-To: <20240113183350.176131-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Jan 2024 16:52:57 -0300
Message-ID: <CAOMZO5APcHhdkvd40Pm+WzSAoxtHS0kcdVpkRTs8yqwXdUSaRQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>,
 Stefano Babic <sbabic@denx.de>
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

On Sat, Jan 13, 2024 at 3:34=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> The older i.MX8M Mini Verdin SoMs before rev. 1.1C came with 20 MHz SPI C=
AN
> controller oscillator, the newer SoMs use 40 MHz oscillator. Handle both =
by
> overriding the oscillator frequency just before booting the kernel.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F42DC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 18:12:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 988B087B0C;
	Thu, 14 Dec 2023 19:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="S6Fme6MF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A752687AB2; Thu, 14 Dec 2023 19:12:38 +0100 (CET)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E1F7987B40
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 19:12:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dbcdde08dc1so1437765276.1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 10:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702577553; x=1703182353;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9p5n3d6DyFwc5auxit0Zp3opBorIQ70mFl+UrIphf88=;
 b=S6Fme6MFr0Ch71/GPHhuL7dghlV7wmDWuWdB0VRIQolpa27Qv1RVr1OwjrxwZve6aC
 uZ3Woc2VCv7ejDOvsBLggWcQs+ZZNj/lggX9RXr35yKJjCcjSKkq0fHP6oLIk7KPJdTT
 7NAY9xZ9Xo/ZOXXGIHiwwCtsXiH//lubCNY8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702577553; x=1703182353;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9p5n3d6DyFwc5auxit0Zp3opBorIQ70mFl+UrIphf88=;
 b=M7r1a9oW+Ce/muG6s8t+WfSE8l+hagqIeS+OnZpN8mV7yJrLjp+0v7DMQ6iZeOe/qV
 YgG4mUiBgYQdjK/DwXkYlnUZEbpIODGS4uNXK1hiLV1YfXbgtfU7tV/sa2ayGyYZ+1HN
 fd4EDFxPCSBzcm4aHpqypTfU8mSLvvhLWT38QAyDNPY7qYpCqT96/xRNiqoqvxkKcHkC
 Wceg8rJIbO1nOWwBz3ojkGa/+F6nxdlAKlmQvOoRbW4E3GGhFPKHYNqgVva2FVHqzUyO
 rKg0xY2kAOKXuqRSUTaM32aSBanT7wiB++tyPRSIoIffXkufbOv0BRDqPXSKgRkWP7RI
 EhjQ==
X-Gm-Message-State: AOJu0Ywsp68TaXv3AmgfmYVdNhxXOMYbFWTJzf9eyHI5sB8nbPq3j2fD
 PvUykEtRCRggLA4T80Hr5LdRXDKZ8c0nXF8zeQvyfw==
X-Google-Smtp-Source: AGHT+IEX5oKpdjRMbgpvL2mOkq72Yz88DHNwKk3uxxhrpc5Z0aoZxS1ayz9y8t2rdJ1lDudcgOFZTB7iVE316eSv7Ig=
X-Received: by 2002:a25:d106:0:b0:dbc:eb28:b683 with SMTP id
 i6-20020a25d106000000b00dbceb28b683mr763289ybg.97.1702577553438; Thu, 14 Dec
 2023 10:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20230804022712.25915-1-jit.loon.lim@intel.com>
In-Reply-To: <20230804022712.25915-1-jit.loon.lim@intel.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Thu, 14 Dec 2023 23:42:22 +0530
Message-ID: <CAMty3ZBVNiMkcV96ZMgmYUZsSp-pZJ3pBUKLdm_+XC5k1ZxmJA@mail.gmail.com>
Subject: Re: [PATCH v1] drivers: spi: Add MT25U01G part number for SPI NOR
 Flash
To: Jit Loon Lim <jit.loon.lim@intel.com>
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>, 
 Simon <simon.k.r.goldschmidt@gmail.com>, Tien Fong <tien.fong.chee@intel.com>, 
 Kok Kiang <kok.kiang.hea@intel.com>, Dinesh <dinesh.maniyam@intel.com>, 
 Boon Khai <boon.khai.ng@intel.com>, Alif <alif.zakuan.yuslaimi@intel.com>, 
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>, 
 Sieu Mun Tang <sieu.mun.tang@intel.com>
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

On Fri, Aug 4, 2023 at 7:57=E2=80=AFAM Jit Loon Lim <jit.loon.lim@intel.com=
> wrote:
>
> MT25QU01 OPN with 4B OPCODE support is currently not supported in
> source code and the driver reuses the definition for "n25q00a"
> which has the same silicon ID but is a slower part.
>
> Adding mt25u01g definition to the source code to support a faster
> read response for MT25QU01 QSPI NOR Flash device.
>
> Signed-off-by: Jit Loon Lim <jit.loon.lim@intel.com>
> ---

Applied u-boot-spi/master

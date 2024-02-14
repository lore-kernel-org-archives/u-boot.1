Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2ACFC48BC3
	for <u-boot@archiver.kernel.org>; Wed, 14 Feb 2024 12:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D82687E0A;
	Wed, 14 Feb 2024 13:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I4B14cPv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64D3887CAB; Wed, 14 Feb 2024 13:08:19 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8555287E0A
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 13:08:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e0ace06556so118206b3a.1
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 04:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707912492; x=1708517292; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ic8e9Xv3keuK9z1RCSPK9Gd/HppyRao6U0Fr7g4DdLQ=;
 b=I4B14cPvJw3prdDnexRMCD+ytgoNSCba5L6voC81bOcsWAM3P/NQNz+XJNo+mXseRZ
 A5jtmHs9mqa2Tek2rC/JWPOU2Ajv/vSGn0XDCfnufkndq64hCuwUaypUjm54iy/hfIW2
 fz4JilxiVeXk7F92yMZwmlSwtLI/6ojFt6HRoaCXkvbb2R1XONOlXSYXI+aw2Jhaa5kG
 MWB+sVYWmA8Lx3cxa2/pxj4IWEJy+8MlvNRpl/NbUwgcoV3ueQkYyL09ygVrdDkUKfZ/
 gfdmx2l9gZivPG9vjW1Vw4Ox1Y/OQ60RgKz1Ve5OpyM//j624RxqJMJQGtcWrKeWFTTX
 OFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707912492; x=1708517292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ic8e9Xv3keuK9z1RCSPK9Gd/HppyRao6U0Fr7g4DdLQ=;
 b=OPOYOGqWUucgvHQHKsIxOUZ/GZrxmLZ0y1HyaC9fXp8Ewk0YQQ2mipbqwNGPvSb92I
 uA0E+7p2gqAqiviha9bTLGGHU1ViqLitSJ95cfZK7V2BemhwJtrg/ctUhjT+DJDMlq0t
 46TVXlbtZkJbLupt6lghKj+dwDV3qNC6G44c+FdmpvPErO62PQAuIPMkhHhxHFDi/PuQ
 6l3bvjO2f6wGVnl/AdEA9VB/+uh7k9mF5rIGtI0NO4nXVnOAGTvCa8qP+KOPuKAJln8o
 5BuEQlkx5G0b+P+LvWYtwN8LXuQTGpF0xRsWuZP3b6CupyT+Q6BkvH9QQuc1xsAxrhfH
 6LuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqL3pgyp4h9gP6dK55HXz7h13oKq5zdgBBcAA8lrDfOnPWnAMk3xz8klOU116nHwn1OsruGToiEGLZAxUgW+JkFTh/uQ==
X-Gm-Message-State: AOJu0YyWAiyXiXYvNN0FCSqyNWbA2HQptayUuEjtxDzZyxQ4OzbndkyK
 yb/uSA/31EMcPPTkxcGzTxa8koDL0S8hfsDlVFi4CweSoXenPeRAbRy4Iy/BruXnv0s5qpJuyVR
 iuN6xZ4BmPd6pQu5njad52f0ns+M=
X-Google-Smtp-Source: AGHT+IFfidogrzoTd8NMUGu7yweT4FvQl/Xyp3n2jKVKv6AIYf5BqEDkWcRcrXfQIxY5jU/o+Xq25d6+CxbtbFPPO88=
X-Received: by 2002:a05:6a21:9985:b0:1a0:679d:9516 with SMTP id
 ve5-20020a056a21998500b001a0679d9516mr2486033pzb.2.1707912491776; Wed, 14 Feb
 2024 04:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20240213172226.151181-1-frieder@fris.de>
 <20240213172226.151181-2-frieder@fris.de>
In-Reply-To: <20240213172226.151181-2-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 14 Feb 2024 09:07:59 -0300
Message-ID: <CAOMZO5AQTDoyQQFVzZkyyvka5mrvZ6i7auSXStaDQMxoS++NbQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] board: Add support for Sielaff i.MX6 Solo board
To: Frieder Schrempf <frieder@fris.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Christian Hewitt <christianshewitt@gmail.com>, 
 FUKAUMI Naoki <naoki@radxa.com>, Hai Pham <hai.pham.ud@renesas.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Marek Vasut <marex@denx.de>, 
 Martyn Welch <martyn.welch@collabora.com>, Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tianling Shen <cnsztl@gmail.com>
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

On Tue, Feb 13, 2024 at 2:22=E2=80=AFPM Frieder Schrempf <frieder@fris.de> =
wrote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The Sielaff i.MX6 Solo board is a control and HMI board for vending
> machines. Add support for this board.
>
> The devicetree files are taken from pending changes in the Linux
> kernel that are available from linux-next and will likely be
> part of Linux v6.9.
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

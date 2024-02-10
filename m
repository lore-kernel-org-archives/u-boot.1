Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F0C2C4829A
	for <u-boot@archiver.kernel.org>; Sat, 10 Feb 2024 18:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B5E887E52;
	Sat, 10 Feb 2024 19:13:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RtGFBkjW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9871F87E94; Sat, 10 Feb 2024 19:13:44 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0255B800D9
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 19:13:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5dc13b142ffso555979a12.1
 for <u-boot@lists.denx.de>; Sat, 10 Feb 2024 10:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707588820; x=1708193620; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/blDBs2aIqF+dER5WHUzm9Qp4diGMC4Ethw3y5uN1l4=;
 b=RtGFBkjW6MKV1zuQ4zXCq7jAQDDpZ2qw6U2PNBtJsDhFz9gqxYioKONPwnb4GuqbON
 Oz6k7g4eCtKLFzBuustO+ph3bMNM4BliN6fr5clBE2AEom2H7+/c6ocnPxriYJWWZI1L
 UcLFjPsbX0DAB0tn4Mw+DxXlLALXuloOXk9qyMDdke1OBKoAF3TnJZSHDORb8sJ8dyzP
 qIJG8hn0D7nNcqMX5O7NisktDQRJd5jNcmuRKyTuBhsuN3wQR5xsPrnJmh/YmWUYj0nz
 uAORfLcHw7rQkzFlTAebrFzbUZ6fLoXdrVxVLL/i2oF2f8ugcc4xXmgpM6ZPqk1P5vtM
 49aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707588820; x=1708193620;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/blDBs2aIqF+dER5WHUzm9Qp4diGMC4Ethw3y5uN1l4=;
 b=nBj0iYnoPV1AZsx1Qpy7zhX5Z/qva8tuKx3OixOwq6jKuwhEY9bNzcYUiDNTuQh+zg
 V/mOVM3+/QaBo4okp7E50RtoCjkDKtGgjlG84QKeFqxXOv6Rqj1BD2S+Oatl3ujJazB4
 qBviC0Mv0vjWuTkaAKwSbW8hNAosJwU8PIPE9ySUlnQIZsJ7vCGO/VMehVD4FSQoDd6C
 V2yDTesS2A6OQQ4uUs5/43X8/JwLDO2k34331UaL2ChVJWZnFJwMH+eYnEwYEA1hImk6
 8/MQi7osmccEFVaxYClDZyORLmfKWS6N2EiMYidHHa51tMrm2fhrP6yNSTMYsmCTuZnu
 1f3A==
X-Gm-Message-State: AOJu0Yza8Ac1bxpbcr6RXajA+tHQX4FQ8P+tai8y5/0FX3mB3wKk/U3i
 Ol1YzxX+LOrYXDo9dFGVcX9FeUAKWEZQZKIftS3xvglqogQgwQ0cdLGXsxntbXifuc5JeSQfTnz
 nc49Ty0B6FXKCY0ASMlqIXy1b+5qJ4o2Z
X-Google-Smtp-Source: AGHT+IGhEccsX/QvvVrznmMzK+XOMEJQU46hiFabCbeVfA/LepImXMGiOyEz5BTpCcD3WylgfelSg2bq/X42un+8yhs=
X-Received: by 2002:a05:6a20:12c1:b0:19e:5c91:1f64 with SMTP id
 v1-20020a056a2012c100b0019e5c911f64mr3744136pzg.1.1707588820342; Sat, 10 Feb
 2024 10:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20240208165849.104787-1-frieder@fris.de>
In-Reply-To: <20240208165849.104787-1-frieder@fris.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 10 Feb 2024 15:13:28 -0300
Message-ID: <CAOMZO5AvPvRd9nKWjFk-9pvRqwgJxQg75LBdgQsiykU8RbM7XQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mtd: spi-nor-ids: Add support for ESMT/EON EN25Q80B
To: Frieder Schrempf <frieder@fris.de>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, 
 Vignesh R <vigneshr@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Andre Przywara <andre.przywara@arm.com>, Bruce Suen <bruce_suen@163.com>, 
 Jim Liu <jim.t90615@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Kever Yang <kever.yang@rock-chips.com>, Nishanth Menon <nm@ti.com>, 
 Teik Heng Chong <teik.heng.chong@intel.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

On Thu, Feb 8, 2024 at 1:59=E2=80=AFPM Frieder Schrempf <frieder@fris.de> w=
rote:
>
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>
> The datasheet can be found here:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/EN25Q80B_Ver.E.pdf
>
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>

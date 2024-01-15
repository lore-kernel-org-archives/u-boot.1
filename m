Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB84C3DA79
	for <u-boot@archiver.kernel.org>; Mon, 15 Jan 2024 19:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDE6087559;
	Mon, 15 Jan 2024 20:54:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c1B2FaY1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C362D87707; Mon, 15 Jan 2024 20:54:18 +0100 (CET)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com
 [IPv6:2607:f8b0:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ECAF86D82
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 20:54:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d48a8ed85bso22564585ad.0
 for <u-boot@lists.denx.de>; Mon, 15 Jan 2024 11:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705348455; x=1705953255; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6XiJCxfi/YipWzfub5OATxaOv/YSwNeV9Hme8bknXaY=;
 b=c1B2FaY1+018fMiAWo8sl0a2XzgI1XeAL2uNVN9NzWInDU7OXMiDAwsTKOjdlvHx3H
 3t1Fq5G7/CGv0tCJhNsQZIDnVhXP7QRK4e6WFpAW9GaHvrOIi8QOlpj97GvMHFHsCbiH
 QQdKBlFvveeLQjbWNljHvSXmlAIfL/HmuU+yRTpv1csK9csnzQGUwrOLdDCoDnhZjUDN
 bTYf6cNyS+ucrL9BcwkIC9M/24SCLbjV48D9VYQ4VzV+rWeAy6BY9fa3SLa4edE8q77L
 smv58+uO57Lt7OYZx2aMPdNfvylCJODgF+M3FSaqc+mAUuCDhXKqL9KQhdXMy2eB6qS5
 HhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705348455; x=1705953255;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6XiJCxfi/YipWzfub5OATxaOv/YSwNeV9Hme8bknXaY=;
 b=IRZaOWfVZ2oAkFTPusbMvWS6tYMx8G/+HC+Ilh+pH2z9tXijb/nQHRPbpbWoVj8Pln
 WUVe8O5HohbkRxp5VSKVoDIIZvLh7edlXgmI9hUvMnfQEjSbowCZTMUsvIO8XuwtiAId
 a9neB92Dbvpre5epaabls2BOfUvZCsYsW+QhgbxAtRjtyBaSGlcZD5kUT+3UnSmnf6PD
 qEnLyMhxw7PRjyMQR7VqwnhRln94ye7D+srJ6I+igkA6W0BclGCtgaVah5DUvXvgoH9p
 z6R/sO/CWLR3dQiqX/TVPQdK+P4k4zAxzd3iOOeLojOkpBb5HDUgtfGy93gLIjG6l+3C
 Fhxg==
X-Gm-Message-State: AOJu0YzWd9eSrDFQZEkea/Ur0xMi+hWt9BiwLotZkbReIrV8mUN0ulRR
 nMtuPlXyh6p6xLh1GXV+8PfBbbOr0UVUzK85fZA=
X-Google-Smtp-Source: AGHT+IGNuQf0i8I7QNDQ6UyO0nX+//AKSZErsA9JYKKX3Is5pESsdpwET1PbUukk3ytZk7w8He5RVIElP/IyQO7791k=
X-Received: by 2002:a05:6a20:89a1:b0:199:501f:a08b with SMTP id
 h33-20020a056a2089a100b00199501fa08bmr9668876pzg.3.1705348454940; Mon, 15 Jan
 2024 11:54:14 -0800 (PST)
MIME-Version: 1.0
References: <20240115135130.2789123-1-lukma@denx.de>
In-Reply-To: <20240115135130.2789123-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 15 Jan 2024 16:54:03 -0300
Message-ID: <CAOMZO5AuWczsAQo_WQwo-7=D6MYN0RRRYd1ZgTJJ5OkoNfjj3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] arm: xea: Move XEA's environment variables from
 xea.h to xea.env
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, NXP u-boot <uboot-imx@nxp.com>
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

On Mon, Jan 15, 2024 at 10:52=E2=80=AFAM Lukasz Majewski <lukma@denx.de> wr=
ote:
>
> The default set of environment variables from CFG_EXTRA_ENV_SETTINGS
> has been moved to a separate file - board/liebherr/xea/xea.env
>
> Adjustments done:
> - fitImage support
> - SPI-NOR layout re-organization
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
>
> ---
>
> Changes in v3:
> - Remove customer's default IP settings for production (hardcoded
>   values)
> - Add missing dtbfile env variable

Applied all, thanks.

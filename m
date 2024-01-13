Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA26C4707B
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 18:03:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C616C8793C;
	Sat, 13 Jan 2024 19:03:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nOW8UJEv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7280C8796E; Sat, 13 Jan 2024 19:03:44 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5521B87134
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 19:03:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28e33bcefc5so82673a91.1
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 10:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705169020; x=1705773820; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zCq19zP8Z3OTfpbPXwgCEJLk+BcoLeeKbCnxuFPF9PQ=;
 b=nOW8UJEvjKKKitQBMLeT+wAOYJM0T2NptWa3mwXTsxmmnA2Y9tnpWkDm6r/TBZ0OwA
 D2cAahrB3u2XNHjTkKf5yZo/sR2xDR4GXQOAmnUIgeWtfyaSKJa79NFP2LCsfuKlAWmI
 ft0Po9aF269GAQSBr3QRW+dbx2cLwazf3k/6Qkv8yMfGRs3aR28XX+BVsi+dg7FXxRPX
 Bx6hAQ8Gj0cuLOsoBIOTXp8ZhSqwj82qXBIacvaAqQsaFNpoI8KgRcU02RDftdNCh8dY
 XFE72P16vJmnq5eryDt25iBRB5Cu5UyclGCqDLNbl1msBJ9ELromqjbjeCmdOgIqRTou
 4sBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705169020; x=1705773820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCq19zP8Z3OTfpbPXwgCEJLk+BcoLeeKbCnxuFPF9PQ=;
 b=Y0jyV9ALnywOlZJgctYkJWUTWjO/eyIBUHXwBOoP0Z5mYsi562hH3WNMUbADoG5xyr
 A1jRIvpi2nIlK1fvInhsThzLV8YpGtheg9YCDxJoLVxX6ViE5u/VaKyvzblDS5UmKh5d
 gRC2lidHHsl1veOaznceWDWiwvehGgPdjZJp+5pZSYgR88zb4Cx+GT+IhUpbdoAwhdeG
 WRAGLcsgyFAnrmjyyMQNG4L3pyhKyHvQLSLGXZ5KOZ5KmzD32DTzknDL+50KJhaqYVUi
 TTULNE3zLUGJav40DSk8a7W9KyQoX+WEzvAe1JY9ESI4BWTeWS5lM5MXWFVOgoCRjPHR
 xhHw==
X-Gm-Message-State: AOJu0YyG2Woi25WKTbMbseZjOLXN/03nI/RkUe+bER8iW//8pJKDL7oC
 2r+3num44QZ3iKg4uBa/8JMdbYCO1sBpwookQshJqK6T
X-Google-Smtp-Source: AGHT+IHvRIa6dYZTgrbewCfGvCEqd0wo+zNf6JifamONd9YEsPJEdd+yeQVMz4eOzYKS1XOFzqF4Mie0tVQl78t0tp8=
X-Received: by 2002:a17:90b:1c92:b0:28c:fe8c:aa93 with SMTP id
 oo18-20020a17090b1c9200b0028cfe8caa93mr6496278pjb.1.1705169020716; Sat, 13
 Jan 2024 10:03:40 -0800 (PST)
MIME-Version: 1.0
References: <20240113175856.157248-1-marex@denx.de>
In-Reply-To: <20240113175856.157248-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 13 Jan 2024 15:03:29 -0300
Message-ID: <CAOMZO5DEo8mALYQMTE11Y8COOhtcG6FJ7ZGPYjXfQEQdzLmkYQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: Set stdio to serial on DH i.MX8M Plus DHCOM
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@denx.de>, u-boot@dh-electronics.com
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

On Sat, Jan 13, 2024 at 2:59=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> In case CONSOLE_MUX and SYS_CONSOLE_IS_IN_ENV are enabled, the console
> stdin, stdout, stderr must be defined in environment. Define the default
> settings to fix the following warning on boot:
>
> "
> In:    No input devices available!
> Out:   No output devices available!
> Err:   No error devices available!
> "
>
> Sort the default environment as well.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.

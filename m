Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 302C6C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 11:32:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 769B387E11;
	Mon, 18 Dec 2023 12:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="p8Y3s6EH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5C087E13; Mon, 18 Dec 2023 12:32:33 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF2D87E0C
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 12:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jagan@amarulasolutions.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-dbcfd620827so2051017276.0
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 03:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702899150; x=1703503950;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ZQfXeCtYVQzsoHpoKTaQw3+9CbB8E4/puousqzcFs4=;
 b=p8Y3s6EHrSoFoXskGjt/H/Fm2Y69StYgBnKVWjPic/OUQNlIvjmwuABSTQntBX00Qz
 6KRilHwWf8bhxTuH5LMOSgr4DcEh8+k9LaT+W0rU9aJPxDnc5BWe7JDE91h2NbLaneZZ
 SWKRtmFFH3Hs/ZkrooYGL+82UY+RveE+i8DxY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702899150; x=1703503950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ZQfXeCtYVQzsoHpoKTaQw3+9CbB8E4/puousqzcFs4=;
 b=RRKTF7QXou/ZxIyEtb+luXXZ4r4K8QY/7Uc7JJkEJSaaK0RB5Sv/QlKrNJW4kYxc6l
 KhVpfbGGE135bft1eO4WscMkShv04GwPwj+XqOaBMWa8J3ikQhKqyyhWAkpUGTuUrbvs
 AODt0juIqqq01AKtQwf32ycdzygcSrRJR93iQYYdMbGlBDTAPtDiamxfvshNFH365T36
 mpfyCPGRlNb4+GNIdsjIyUs1rOLqA1ixEcE1wUrXRzN8yk/Lz7JWenH6OLIVWhKQVpIl
 TvjkXR/ZxVvseF+nPaCk9jk1FDq2SFv0KAc7c5AIKy00XMuuLZi+YtT7SbRXhnCuoJxf
 Fo2Q==
X-Gm-Message-State: AOJu0YzWsd1OPQLt0kXDQmLfh/aALAJu3LG/9HyPcm6Tu2ELrK1p+scp
 bEbXgD4f7YpAQCnjuNs/XoXuccF8rV0q0sTxzfC8am+Kuztjm7DjbmU=
X-Google-Smtp-Source: AGHT+IEGI9nqoOCr7PZT+6VZZnluOf1ISrNYVYxWGiGsoWElNpWM5jOLo+Weg6LXuXNeEdQ2IE6wKnOc0nLQpfsu+wg=
X-Received: by 2002:a0d:e805:0:b0:5e2:b2d5:f46f with SMTP id
 r5-20020a0de805000000b005e2b2d5f46fmr7260640ywe.83.1702899150150; Mon, 18 Dec
 2023 03:32:30 -0800 (PST)
MIME-Version: 1.0
References: <20231214163623.1924877-1-tejas.arvind.bhumkar@amd.com>
In-Reply-To: <20231214163623.1924877-1-tejas.arvind.bhumkar@amd.com>
From: Jagan Teki <jagan@amarulasolutions.com>
Date: Mon, 18 Dec 2023 17:02:19 +0530
Message-ID: <CAMty3ZA9TkeWDN3+t=uj=wikF_C5rQzUuCUwf00-cE024h28Yg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: Add support for Macronix flash part
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 michal.simek@amd.com, vigneshr@ti.com, git@xilinx.com
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

On Thu, Dec 14, 2023 at 10:06=E2=80=AFPM Tejas Bhumkar
<tejas.arvind.bhumkar@amd.com> wrote:
>
> Added support for Macronix OSPI flash parts MX25UM51345G
> and MX66UM2G45G, with initial testing conducted on the
> Tenzing-se1 board using STR mode for basic erase, write,
> and readback operations.
>
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---

Applied to u-boot-spi/master

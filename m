Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31648C4345F
	for <u-boot@archiver.kernel.org>; Mon, 29 Apr 2024 10:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A01DA88951;
	Mon, 29 Apr 2024 12:37:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TfnST/cg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 747528897D; Mon, 29 Apr 2024 12:37:06 +0200 (CEST)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 582EA880B5
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 12:37:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2abae23d682so1128792a91.3
 for <u-boot@lists.denx.de>; Mon, 29 Apr 2024 03:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714387023; x=1714991823; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSWRkZNbKPUUzk7wXbJuhDm2nm44SvB4sxKAMB7DHZ4=;
 b=TfnST/cgU/CMZPuVVVQLWNpjzs2K6YvVUnaKGRUDZQ+ztpO8OEZCtDaw2RSqVK5cuU
 c+m9p7xi3mWjA7JPTJgYNV3DrNYjQRT36Y3BA6EMgb4JV2GPCBSWPrC1bTyO61vKDrv1
 vXxYsXzohiPKzj8oav2o1W2/hXMKGLgnyQ2+SlxpjZiqiQMnXF0iuz1MGJG8qNyJ/WBB
 Bt0FH0w5G8bQ725n8gvzPjIDcUkuPmyiP+zDYItOzjVFLQdoQiskbG3IVV0Duo1Z7ALY
 OrSe6Q5V9TouG1GE0sIsR27z7XytqOLCAccayAaAmDRWqma0aa+MAMLBWI0UM1w3/gUF
 ymJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714387023; x=1714991823;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSWRkZNbKPUUzk7wXbJuhDm2nm44SvB4sxKAMB7DHZ4=;
 b=SXLN6Sws50+ChGRmVqJuIIjbDLTkziUhDwOH2Up3OPCmRA83iHpxZyNME3aCw9WAEU
 62POwcIW6x0c4NVX0GGYRc9XW4/aHGKYZQqprPWsFRkSh2XytevlmMmTAyKY9dTORCQc
 MStAd2cJbulNOl0Gb5NuBRIglewjbLyA3iTKkCGkF9X2OWpV8w6daEgqYpFIg9GMVX7J
 4rdG77L9aHBIdhBmq/4nAfNp+4iUALL9CsrSYO+W8EqkS4NDANIVJLxt+BNZQXW9QFle
 qyAEpSHEzyXE4uUbUWWcHnzRSt4LAGGFLFq+atVag/OlndlGu6XLSTQbo+kzbH1v4kdJ
 VX6A==
X-Gm-Message-State: AOJu0Yy1HC8Fgfac5sNmUImWAH/AJe9dA44ZtVTk7hRey4wLMM9Vn7gw
 ZC3FAd1/k9KyKGvRYaNRGUGUmR+38pSesDsdcdZV8FKCoQG3gJEwoh4JAWT+HkIo3YTB9xPMBfl
 3Uo8z0vKP3S43aXaA5e43a20pN5M=
X-Google-Smtp-Source: AGHT+IGWDz6FhwaE3I1Q067+wnvPmre1YaWCTA6plCZLZBSh85dpcJUvj/eCy3WohWUulKh94t6jaNvZBzMRdzviAEU=
X-Received: by 2002:a17:90a:fe0b:b0:2ab:be54:85ed with SMTP id
 ck11-20020a17090afe0b00b002abbe5485edmr9570862pjb.0.1714387022853; Mon, 29
 Apr 2024 03:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240423231526.536883-1-marex@denx.de>
In-Reply-To: <20240423231526.536883-1-marex@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 29 Apr 2024 07:36:51 -0300
Message-ID: <CAOMZO5CMfmick0dP50jF7HXVc7U0UeRD0vkX5OPep9vw=V6YXw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx: Enable PCIe and NVMe on DH i.MX8M Plus
 DHCOM PDK3
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Tom Rini <trini@konsulko.com>,
 u-boot@dh-electronics.com
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

On Tue, Apr 23, 2024 at 8:15=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> Enable PCIe/NVMe support on DH i.MX8M Plus DHCOM PDK3. Except for
> the configuration options which are enabled, add slight adjustment
> to board u-boot.dtsi, which is necessary as there is currently no
> driver for the I2C PCIe clock generator. Since the generator is
> strapped to be always on, it is possible to supplant the generator
> functionality by fixed-clock.
>
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied, thanks.

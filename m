Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B621CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 17:42:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD79D8876E;
	Mon,  2 Sep 2024 19:42:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BcQTljbc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A805988C01; Mon,  2 Sep 2024 19:42:39 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C40C9882EF
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 19:42:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2f3f90295a9so50184901fa.0
 for <u-boot@lists.denx.de>; Mon, 02 Sep 2024 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725298957; x=1725903757; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A+XXGs4MFX1BMHQ8fTEhKUrJfQY6c4NxbgPsqJQck8c=;
 b=BcQTljbcemPfW5pVRVxiReZzvhw5bH8r24glfJlMiAFa1Xo/eQlOGt1ZSLyiYTt8MR
 XBDprkAhmfR4mCi8xbuFJczgbB8i/ka0V2vnEJdWqDl0zr5wp8gv8BhBM5OzjCtVyDed
 46B5ToY13Y03BxFJcs9ja/JkROXVw2iirfHRRJVi39giUM8TzWuOKbidmVOuHyxTmNMT
 LItvgWuxBNCavC+6CacrDHy4uC/xHj56UBMRhRLH1jRiUTKYKdwiWRe+SE0VtQfY8bb/
 8TghGLm25Zig1yDaTmSHe1ZKZub/ryz/9CHnVy1g2FWxE3gqt9kXKzfwKojnrc8O+6YB
 atbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725298957; x=1725903757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A+XXGs4MFX1BMHQ8fTEhKUrJfQY6c4NxbgPsqJQck8c=;
 b=efEOmEzibaD4NYEaEwD+MR0Vv++/ZmpIkBDLAkAjeLEf6mKCZo5/cms/bwwX1dZvZX
 6scGOC7naa0AvNUzDRg25FYgePwTDV8H8A9POfWldwBIqfnpMS9Agnf8P8u9qOkQkq7A
 mNTAryhGjNu8XrwxD7NrG/euiGXT5nTYvhk4usl3H3ljYCUNu2sBySlb53bBWGdEiWMA
 QahfEqhNVhH/Y9ila+OpykVTsIBHbHnySYapLXdSE91nDWni2lbnNLUJKSL2XrNVyf/X
 gA6XjtSGN77nxJf5zkiVCNUmoYqV3MCh98WJ6YyTBlX+0dSOBN5GY//HmiYymbiIjI5j
 HJrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+3C/Kepgkwmxxma9Fp6rbg/gJG5HCDVbz7wTKvj2ViZ7XUQRhnzqz1OHY+gM2HPIYWZZF6uw=@lists.denx.de
X-Gm-Message-State: AOJu0YyA2akjzcRklQZOVZU2+G07QfbKYIFBpAOOD9ealB6kxLJke5eC
 h/TuwxZXyq1/RAV8l76iTZPd771nSod9231IbSQnFycVVxtcQDijwwfGBmDxG0RTT1HkCcxKC68
 hPRhBiB5bHRympHMOF3qR4sA10IhXYA==
X-Google-Smtp-Source: AGHT+IHJhpOu9Bs2t8svavEJVoJaCJECb4RioSAgMlLdGNBh0hCElYae/synPtlKsyWyYqrU6lEKIO/igpjgIp4x9zU=
X-Received: by 2002:a05:651c:4ca:b0:2f1:6821:d163 with SMTP id
 38308e7fff4ca-2f636a2a9ebmr33507681fa.21.1725298956555; Mon, 02 Sep 2024
 10:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240826-wip-bhahn-add_qspi_support-v1-0-0ea7840b940a@phytec.de>
In-Reply-To: <20240826-wip-bhahn-add_qspi_support-v1-0-0ea7840b940a@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 2 Sep 2024 14:42:25 -0300
Message-ID: <CAOMZO5BAawPFR+VZzs8a_Xb2Y5R9b1MqN9366NwWJiYy_Y4JwA@mail.gmail.com>
Subject: Re: [PATCH 0/2] phycore-imx8mp: Add support for SPI NOR flash
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, upstream@lists.phytec.de
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

On Mon, Aug 26, 2024 at 1:49=E2=80=AFPM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:
>
> Add support for flashing and booting from spi nor flash.
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
> Benjamin Hahn (2):
>       configs: phycore-imx8mp_defconfig: Enable SPI NOR flash support
>       board: phytec: phycore_imx8mp: Add mtd spi partitions

Applied both, thanks.

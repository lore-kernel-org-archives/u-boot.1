Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 967BBE7735F
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 09:20:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D2138701C;
	Sat, 30 Sep 2023 11:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=protonmail.com header.i=@protonmail.com header.b="u063TJR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41F9B8701D; Sat, 30 Sep 2023 11:20:49 +0200 (CEST)
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0805487019
 for <u-boot@lists.denx.de>; Sat, 30 Sep 2023 11:20:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=protonmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vitali64pmemail@protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1696065646; x=1696324846;
 bh=ZKfy1Hy2ZJB0m+/RWKySGhskY/jtuPNSdirfz9waW9Q=;
 h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=u063TJR4BEs5qfG55fi813tazZNTX0U+P93dAx6R3k5+OTJv7CEK/yza2wYlru9n1
 L1yN9bO2pxDq1qS+zH+ToNXV1zhFja4wbo6oJ594yiOxRmXMnz6CVeoUtJJBnY7Y7e
 FRfjad+FgdWICbmLCGHI6AFTkkIsCA3SCtSH+490dCZ7hfTTQlcaYesDbn10V+BMoS
 XUdmeWj19rDpl5ZEYX30h/fvgEcaxi8uBvTGRuWKJr6ItxcKMuHnh/pB+IdOu5U6AU
 balRa660QCOZ+eoxs1ahzNYRo+14/jr6imhk2V+KwzUwyhQD3NhGeNsaanyWybFuUg
 fDrcV/Mzvbaig==
Date: Sat, 30 Sep 2023 09:20:39 +0000
To: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
From: Ferass El Hafidi <vitali64pmemail@protonmail.com>
Subject: Re: [RFC] mmc: Remove alignment hole for cmdidx in struct mmc_cmd
Message-ID: <CVW52OHAPG82.L07OLNA7FN7A@flaptop>
In-Reply-To: <20230929230655.2932698-1-jonas@kwiboo.se>
References: <20230929230655.2932698-1-jonas@kwiboo.se>
Feedback-ID: 37421466:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

On Sat Sep 30, 2023 at 1:06 AM CEST, Jonas Karlman wrote:
> The alignment hole caused by cmdidx in struct mmc_cmd cause strange
> issues together with the peephole2 optimization on Amlogic SoCs.
> Following was observed while working on SPL support for Amlogic SoCs.
>
> sd_get_capabilities() normally issue a CMD55 followed by a CMD51.
> However, on at least Amlogic S905 (Cortex-A53) and S905X3 (Cortex-A55),
> CMD55 was instead followed by CMD8 (and a few reties) in SPL.
>
> Code from the call site:
>
>   cmd.cmdidx =3D SD_CMD_APP_SEND_SCR; // 51
>   ...
>   data.blocksize =3D 8;
>   ...
>   err =3D mmc_send_cmd_retry(mmc, &cmd, &data, 3);
>
> Running the code with MMC_TRACE enabled shows:
>
> CMD_SEND:55
>                 ARG                      0x50480000
>                 MMC_RSP_R1,5,6,7         0x00000920
> CMD_SEND:8
>                 ARG                      0x00000000
>                 RET                      -110
>
> Removing the alignment hole by changing cmdidx from ushort to uint or
> building with -fno-peephole2 flag seem to resolve this issue.
>
> CMD_SEND:55
>                 ARG                      0x50480000
>                 MMC_RSP_R1,5,6,7         0x00000920
> CMD_SEND:51
>                 ARG                      0x00000000
>                 MMC_RSP_R1,5,6,7         0x00000920
>
> Same issue was observed building U-Boot with gcc 8-13. Please advise on
> how to best work around this possible gcc optimization bug.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

I'll try reproducing this. I'm using this:
https://git.vitali64.duckdns.org/misc/u-boot-kii-pro.git (branch:
wip/spl, known to boot on S905/GXBB)

For reference, I'm using this version of aarch64 gcc (from the=20
Arch Linux repos):

=09$ aarch64-linux-gnu-gcc --version
=09aarch64-linux-gnu-gcc (GCC) 13.1.0
=09Copyright (C) 2023 Free Software Foundation, Inc.
=09This is free software; see the source for copying conditions.  There is =
NO
=09warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.

And this version of (host) gcc:

=09$ gcc --version
=09gcc (GCC) 13.1.1 20230429
=09Copyright (C) 2023 Free Software Foundation, Inc.
=09This is free software; see the source for copying conditions.  There is =
NO
=09warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE.

Cheers.


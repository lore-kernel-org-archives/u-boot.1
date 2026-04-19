Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9284AEA71AA
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 21:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2E23839D9;
	Sun, 19 Apr 2026 23:06:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ofTaySnX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 133DE8419E; Sun, 19 Apr 2026 16:05:18 +0200 (CEST)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com
 [IPv6:2a00:1450:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B17F683B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:05:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=itsrecursion@gmail.com
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-38e7d983f91so24097351fa.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:05:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776607515; cv=none;
 d=google.com; s=arc-20240605;
 b=eHwoV0ggyf5apAC/EgPmFSoCHo13tbX2ALbsr/CjQc5Y34KgdMC+SXWpTfiNdpVfnP
 mkxCHNptTO5aNX+SP/nS2MlGPerF98DJMKbU5sl+7on42m1T4CP1SkdGgK1ELB/oTDkl
 ZM/MCnBvTDRJZ8tTmGm6ewEx/1BLTHVxXxOGotknu7Z77AUIrjhsR1DqwQP+gVoyRbu/
 76H1Pjjeou8crUOMkaqmej0eCNnlTHBCe9K45ZD+Z/zLeBq6JHW3X7xUZnAeODNUrJFy
 1/JiZzCqTsuK+pzOhQ1az6LCIw3bKfDUNuoFMrwle5M6Rpfzpseb64VzWBho+fxdzrUl
 o3BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=cElTdoGd5IzTyO7NAhBgfmlwvaNHoRKZ5O6Wl9oSUik=;
 fh=ea3Lb1kmqTyoSSOGd3r79PdCdfQHXBjS15GzGXd6hwE=;
 b=OxZr/T1jYhUI6+zw3dY7YdToWw4nZmDtk6IT5NlyKcuIoKRK08Tkat/7WSVn6HkfRZ
 6bXc9JssOgpwRCOBzlZBAkHyRC+MjtHxZNUwcBO5/LU3DdOqaj6cGQqM6V4UZ/tlgEKf
 gFDfy+hJbd1nJr0+ZiPjNmKcsEVEbmA9LhsPngov1p8UVfqBTRfKAIi5JKVDLVej5ZgH
 fcZSMIPTi9HoCAA0hWPZGXV5YdRT5O7T1iousTHe93xgSAXPOg76owHhfQJulEGMkdn/
 uBmyVwed3hPesY/kiW/Ldyp2MPWTalmsm4wXcwM4Aoj6bFUCJIqYuliRHExfFL3uHDMV
 cAdQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776607515; x=1777212315; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cElTdoGd5IzTyO7NAhBgfmlwvaNHoRKZ5O6Wl9oSUik=;
 b=ofTaySnXLrL1M5Tn3huVI71bazMmJ1mYVxXh/9dyYCM9TcAeNU3pDhG1o0QY4WV0Tl
 nt7AWqrmg1iYof8epjr5f2Wp1fDVTPR38i4HQpoFCAUKusfkseRo3uJdJT0NorNtzE8o
 rNvIzUp4rzP3lIHXWJICzwgFQ/00vJnQ4pOetn/fWKooVolVxKi72bCY5kZ1Gd5zqnpx
 5eFuY/9v2w12ZrNtHWoJreJ5BD6H76qsO/h5rWVJCplyBuEhepWT5NXTE2stgCLtsGZf
 rFEizMOBS+BNSZ/l2kRFd/W8jkZbBkXz2tGjZs7dYR0OBjzlCtNe3gP/GPeHy4iC6PHY
 yH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776607515; x=1777212315;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cElTdoGd5IzTyO7NAhBgfmlwvaNHoRKZ5O6Wl9oSUik=;
 b=oeczzPLigopmJh60uLBNJ6xGF+RVmicQCcsbmM94CZITrxRWD4leCSKDFHAp/F8nWE
 m4gw6an2h4GDRYLK93WHgwvkeLFOkFKYDn0cwKkWkqs/AuCCI2hqXaxtC1vbA152lAXf
 FGkghEDZRyYcwVFJxQ8CUcg1fMmgf498H0PNS+j8uGCtx0fv7YO9Ug1Vugpws3AVnoIZ
 J0NfyIAXCib20jXT2WWqtDYy/KA5G7XBtoFAq7BZIPNplEtOeNbozNlFk+bV4uxwHi6S
 N+k1vgxEVwCLUw7/o0pSvMjKipPjOUon628Gy9/4Ia/9+BQq/nhjZrpZG6od/ZyQmOOV
 SG5Q==
X-Gm-Message-State: AOJu0Yzk+X8upSvqKG9JvdOh7kN6RE2kYkIr21JKbQypwQvm967vNyGg
 G+83iyW+P02S3zb6r2ZOfsxrt5ejEzoRZRurUTt8yjk8oOWelz/iiamBDQ9CVe38xTtGi/7LMRx
 yhQLz7w3FfIheJDJ1WJxDwaDvQSzDnj1qLG1X
X-Gm-Gg: AeBDievGd0wmrqXSVT3dqRqRB+USGVPLuLyNGlnU48PirGmm9Klu9wWnSDo17NrIRiV
 esJV90g0O5rKeC9TSU0oB3dZ8wXmNEjqIH1DZXiLMR47ZUe6f1d/UBSJu+1fVVE26o87FWyROf0
 9i2FOLb0otp5uu312SIWGJUiR5p0vYeu6cUbKRpb2CpoaeEYgvTtSH6XZQd23OsumaimNlx0luV
 eytH11i1RCNVWi2Tg5OywcszXchXtAY5yv/7wMfonVwbtRm58b4SnWWNpq8mY2/jSH3/DnZ0uNK
 PORbn7wYPQd66hzW
X-Received: by 2002:a2e:8a94:0:b0:38a:45d6:c246 with SMTP id
 38308e7fff4ca-38ec77fa93cmr26568811fa.8.1776607514314; Sun, 19 Apr 2026
 07:05:14 -0700 (PDT)
MIME-Version: 1.0
From: its recursion <itsrecursion@gmail.com>
Date: Sun, 19 Apr 2026 17:05:02 +0300
X-Gm-Features: AQROBzDO899-rxUO-Fe211PYBbUQ2F8h05_FLCUjbk8CHDXyvouN9qEyGdgzb14
Message-ID: <CA+TFwyyCkX73RUYBmPFTevFCiVFuS5WgqSdXhwu2e66hcdkNyQ@mail.gmail.com>
Subject: [Report] ns16550: possible missing workaround for NXP erratum
 A-008006 on T1040/T1042 (DUART in FIFO mode)
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Sun, 19 Apr 2026 23:06:41 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

  Hi,

  I would like to report a potential issue
in drivers/serial/ns16550.c concerning NXP QorIQ T1040/T1042  SoCs (e.g.
the T1042D4RDB board).

 * Erratum (public reference)*

  While browsing the NXP community forum, I came across a post discussing
erratum A-008006 =E2=80=94 "DUART may miss characters during transmission i=
n FIFO
mode" =E2=80=94 and its applicability to T1040/T1042:

  https://community.nxp.com/t5/QorIQ/errata-A-008006-for-T1040/m-p/557567

  The full erratum description is, to my knowledge, only available in NXP's
NDA-protected chip errata document, so I cannot quote or propose the
official workaround.

  *Observation in U-Boot*

  On T1042D4RDB (board/nxp/t104xrdb/, configs/T1042D4RDB_defconfig), the
console UART is driven by drivers/serial/ns16550.c. Relevant points:

  - include/ns16550.h:154 defines

  UART_FCR_DEFVAL =3D UART_FCR_FIFO_EN | UART_FCR_RXSR | UART_FCR_TXSR i.e.
the default FCR value enables the FIFO.

  - drivers/serial/ns16550.c:249 (ns16550_init) writes this default FCR
into the hardware on init.

  - drivers/serial/ns16550.c:275 (ns16550_putc) transmits through the FIFO
(polls THRE, writes THR).

  A grep of the tree for *A-008006 / A008006 / ERRATUM_A008006* returns no
matches, and no other

  FIFO-related workaround appears to be present in the driver or the
T104xRDB board code.

 * Conclusion*

  The preconditions of erratum A-008006 (FIFO mode enabled, transmission
through the DUART) appear to be met on T1042D4RDB under U-Boot, and no
corresponding workaround seems to be in-tree. This may result in

  occasional missed characters on the U-Boot console for T1040/T1042
platforms.

  I am reporting this for awareness only. I do not have access to the
errata document and cannot propose

  the official workaround. Someone with access to the NXP errata (or an NXP
maintainer) would be better

  placed to evaluate and, if appropriate, send a fix.

  Thanks,

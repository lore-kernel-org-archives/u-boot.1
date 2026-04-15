Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 639A2F43821
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 14:32:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6CCF84119;
	Wed, 15 Apr 2026 16:32:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kADb9L4Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3201684178; Wed, 15 Apr 2026 16:32:31 +0200 (CEST)
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com
 [IPv6:2607:f8b0:4864:20::935])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24EC483B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 16:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-94aaa5d3bfcso3808885241.3
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 07:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776263548; cv=none;
 d=google.com; s=arc-20240605;
 b=ch/DiFql8e2cUIwGobQzi0cWDMXBYdAYucM8zdxfeQtoFtgwCsoCw0Cz37TQlSxjqn
 4BIAOvDTODDgDgOnAd/50LF49q/7vDsfONq2oeZMeVmZBbk9jXFa/QHTT1JzAuUXcd0i
 YayBf+jNQSgfGvae+238WS8GfcxedP1fJbr8lxUYl2pQRVoqzemGhw1qpzbOVf3ZzJqV
 fphkZVNhfVfGicSRYI6r4mGYBBRCHzQoH1Y9sX/DnwvP4DeKK9ctpxDqnr6EUxh0bdJQ
 n5at0RwCn3zJUT/KXydxOC91bG2ba8glkAC/Uk6fTxwwuV1vSikuGEV8QGJIMBJCOPyD
 /dLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NbqnzNilsIQn4Rq8d5V7L0QNvpqn0tOGwLzoD7Z+vz4=;
 fh=LieQItRDdrseeqnkSnYbGqnH9zTYBnDdrJyz4vjdYPc=;
 b=i+I2k/HB7xcL18l87I2foaRa0DnEMomRbHA573LKtA6Smc80jpPMcfuePV8MIC/JKd
 EQU0CIoAk8hKgYDx31lKHRZrJvlSUnm1aeWiDZ0+9pdIoSXhCfZRew6OJwMoF3mMpDv4
 CA2MVD3PtbWSeEXPMga36x1xxzfwD1KDoLeDXzPwWDOyDKmEl2LsIfLkfnPpS5f91nb/
 Hx1AIDYW44MYojN8dhjVImmclmc3LYvyH6P9nlB5Lu22NXm//2tz3ddhG9uJwZIBy9mp
 FFwcCCuwNKLUGDV3vEraCBGVbZgdjMD1yNiLstZx+0E1aFMdLcKHu/7Wufv/9CjBhQoM
 2WRA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776263548; x=1776868348; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NbqnzNilsIQn4Rq8d5V7L0QNvpqn0tOGwLzoD7Z+vz4=;
 b=kADb9L4QZ9gYxORxfs4ULV2hqCwO4gj0FR2Nsj+mMWHAbMgTHAhWPt8a7keKWMM3TP
 Ek4h/72ueRNoUg1ssrxWUvI2MmJNRKs226H6F2GrU8qWN55go025NlAodKxMebFPNLQr
 RkcDcmw3cNrcBKmuMzg0YzqyYYFq4QNbhD0LlekuQuWS/8hfbO8iJQI7nOxExUdQ1w25
 i9+YItc9YKj3r2ZOUCEh89D73sumpBS/AK1K6X0oCr63PrYJm4pY1Qe373uwr0HewzjD
 kpoRJV2WcXDo7e8YZ9fgESV9u+Cd4w/HqYYO5wCbHWRZ4prv56qjmgO0k40lIxc+JwX4
 qjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776263548; x=1776868348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NbqnzNilsIQn4Rq8d5V7L0QNvpqn0tOGwLzoD7Z+vz4=;
 b=IMM0CLJRPzoQLFzrDaWTYfZChaYZwXRmec6IseOpNBdMsn9OXJHEtVEsgTeNP9e/Gv
 MI5WV73gDmlJsrsnJ9uLxnW4PhkGZD9ZOdVBnf7XQiZuONQChCHI7YufoeOfa5/SW5zr
 5GdOtyWVZ/6EY/URSk315TAKevFnBVBzeMLzOYpg0WdWQyY+2e7nCLQ7ZrKsz9dnHl0F
 KvIO1MPSWOW3d5OziEiTiknsA35tIM8KqfprCsY6E4dJ0xK6ZlOc2AQbqlCVGyOTXmVi
 BLDdtnZuFGpgND9V2r6HN4lNmDhnwspoVPrY3klhbW+gm4SOmU2NHlclyE2JTTYwg7mx
 nZbQ==
X-Gm-Message-State: AOJu0YzUHBOie1CWwXsHfEcK/8omOLNGyVYHMtZieCEPnA56uOkpQdH2
 xGuJZv4XtGmL7TziHUWrpMCv246jtaxzC+yMEWmNPW/z8pdelG1gZuo/84o1A7ynDXQCkfhxDeB
 ppbbwt8VHcHWR7zhdVMLXHDPQJHcX63E=
X-Gm-Gg: AeBDietlHdGsqkrltczABw8XQKz76kUg5tTOGmOYI4GkFrYO1liy4mV13PclNaLiIy9
 W366k5jyekl6ln3dAnZvCTaxpZCxOpzFFqOfMSxgvjHRRvrVIh/Iqsh+2prbt6cMz8kdqtUhIOB
 l0xOx3CuGc8NO9cgWbAQpCvVpwgaju/FLXr4zik5GJ1A32rK6UK1CeegFYKs7st/gufNPjfbPdt
 kjV/mub6ErH9zWLmkz+mWK1rJA9cK0LVkKe3uOOlQglJjCBsIaB79PrrfhWtIWF+2S+jMxm78Nh
 E1YALZI+zJtodGNfZCI=
X-Received: by 2002:a05:6102:3352:b0:607:4fe2:a64d with SMTP id
 ada2fe7eead31-609fe7a58cemr10895565137.6.1776263547875; Wed, 15 Apr 2026
 07:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <87d4cc89-e60a-4365-b6c0-efe5b20d0c7f@online.fr>
 <286a02e2-d026-48bd-977a-d8df3c9d98c5@online.fr>
 <fb7a128a-1408-4595-a09d-2f2fecb311b4@online.fr>
In-Reply-To: <fb7a128a-1408-4595-a09d-2f2fecb311b4@online.fr>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Wed, 15 Apr 2026 10:32:15 -0400
X-Gm-Features: AQROBzCkRSku5VB-3Fp_Ve9DyIxktQnTrTG6K-sh_7pBRQRQNAMFEVCnkf_UMz8
Message-ID: <CAMDkj5xG2s85GUc_dgbJ-Jp+qypXet1B73FCPVbYxAOj7HurMw@mail.gmail.com>
Subject: Re: [PATCH v3 00/16] Add board support for Spacemit K1 SoC in SPL
To: Vincent Legoll <legoll@online.fr>
Cc: u-boot@lists.denx.de, uboot@riscstar.com, u-boot-spacemit@groups.io, 
 raymond.mao@riscstar.com, rick@andestech.com, ycliang@andestech.com, 
 trini@konsulko.com, lukma@denx.de, hs@nabladev.com, jh80.chung@samsung.com, 
 peng.fan@nxp.com, xypron.glpk@gmx.de, randolph@andestech.com, dlan@gentoo.org, 
 junhui.liu@pigmoral.tech, neil.armstrong@linaro.org, quentin.schulz@cherry.de, 
 samuel@sholland.org
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

Hi Vincent,

On Wed, Apr 15, 2026 at 3:04=E2=80=AFAM Vincent Legoll <legoll@online.fr> w=
rote:
>
> Hello,
>
>
> Is there something we can do to help this series move forward ?
>
>
> What are the next steps ?
>
> How can we get a fully booting board after this is enabled ?
>

There are two upcoming pinmux and SPI patches that can support U-boot
proper, and eMMC support is on the way.
If you're using banana-pi, it may not boot fully since SPI NOR is
missing on the board.

Raymond

>
> Thanks for all the work !
>
>
> Best regards
>

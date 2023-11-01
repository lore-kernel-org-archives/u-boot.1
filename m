Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15456C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 17:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C0A387008;
	Wed,  1 Nov 2023 18:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XDVyJgO+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE26187C51; Wed,  1 Nov 2023 18:12:08 +0100 (CET)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AC0586E24
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 18:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mr.bossman075@gmail.com
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-28041176e77so73625a91.0
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698858722; x=1699463522; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PhCuB0RikpX08XFReaZkAu7p6quFkBri/8+PSHJP+94=;
 b=XDVyJgO+5GfX9GRFClJKifPgDzv14pWS63Z1eTwdxM5CQ40IVxGJeFGND+zi1M4Mk1
 QsUa93/iVRwy2d6gs8XKBhO2FyzcXDZOBIFez0hNdnRWseayDEYT41CLZE4JbjhN8ZUZ
 0tXeoO6KmsQyZKZMG7ARALNoAKDJP9OlpNOdwmEH6QKCLGdNgJg2aoXKr0Zm9tIvMHXL
 5JFSGU09kmwfyDJcY5UhQTgIQbnBdGPA1v95Fqfi5GHYSDwa4yYQel/MooD5BjW5MqJx
 RaQGa3FM2Ygj5+nq6MkbpCbL93MfTz8dX+zkI8srvxYA4/3ucXMfzj+x1VQI47VQBQ4O
 BKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698858722; x=1699463522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PhCuB0RikpX08XFReaZkAu7p6quFkBri/8+PSHJP+94=;
 b=ipEc3WHIXuGanPZu8LRteNDDh91U7yLsv+kUaSQm0GE1AbslFUdbTAkcn1PSUnhhxL
 DK1+pN6lgoVV0VKeKO+n1nCPBzW593vaKc5Q8rsVDeticaMRUMB26+EwKQkh7nAVAk1H
 zRn8/n9XnyrazVZ0ZE/ufDlDKwoDgQelydhJFN6XeTQPcL7lQJ5ccU9qPQmHPznW3rW8
 X63wKYMjYh7ESDtDHOoxalAl7gqxZbMBX/3h9zH+sWofKrwyu/6WuFBBPGXfYpNsZPWB
 z4YILLJQ38qgP0CH0b7mYLRT+14DSdTfD7obV7N9la5eB9MI7eZFWhtY838z9aZHIO85
 BEnQ==
X-Gm-Message-State: AOJu0YxiE0nDlYXUfd2giE4r97muLeYw/O7TeTm9xQU1kVcpRy19p1e/
 PL6xUSdDklslvBRT7qA6jWRG6W9ELFOnnMzISUM=
X-Google-Smtp-Source: AGHT+IF8tJQFGSuP50e1YTDmb4+7tkfs009Vs/Q2KvGgKBI3Aau5PhEyCJjD8y4HEHI4NJJs9vOWTb/P8HlkZ+wxag0=
X-Received: by 2002:a17:90b:1042:b0:27d:9b5:f28d with SMTP id
 gq2-20020a17090b104200b0027d09b5f28dmr13614947pjb.8.1698858722488; Wed, 01
 Nov 2023 10:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231031051805.62430-1-samuel@sholland.org>
In-Reply-To: <20231031051805.62430-1-samuel@sholland.org>
From: Jesse T <mr.bossman075@gmail.com>
Date: Wed, 1 Nov 2023 13:11:25 -0400
Message-ID: <CAJFTR8Rb0QdQMSx2pSr6_2y3QgoaJwJs6e_bFhng8LdqejB5fw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] sunxi: SPL FIT support for 32-bit sunxi SoCs
To: Samuel Holland <samuel@sholland.org>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 u-boot@lists.denx.de, Icenowy Zheng <icenowy@aosc.io>
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

On Tue, Oct 31, 2023 at 1:18=E2=80=AFAM Samuel Holland <samuel@sholland.org=
> wrote:
>
> This series makes the necessary changes so 32-bit sunxi SoCs can load
> additional device trees or firmware from SPL along with U-Boot proper.
> Crust (SCP firmware) has support for A33 and H3, and H3 also needs to
> load an eGon blob to support CPU 0 hotplug (a silicon bug workaround).
>
> FIT unlocks more features (signatures, multiple DTBs, etc.), so enable
> it by default. A10 (sun4i) only has 24 KiB of SRAM A1, so it needs
> SPL_FIT_IMAGE_TINY. For consistency, enable that option everywhere.
>
> After this series is applied, we can increase SPL_MAX_SIZE for H6 and
> newer SoCs, both 32-bit (e.g. A50, T113) and 64-bit. I did not do that
> yet because there is some discussion to be had about the correct value:
> it must be adjusted to guarantee return-to-FEL functionality, and the
> exact adjustment depends on the sunxi-fel tool implementation.
>
> Changes in v3:
>  - Rebased and collected tags
>
> Changes in v2:
>  - Disable padding from SPL_PAD_TO
>  - Rely on binman min-size instead of using explicit offsets
>  - Use Kconfig for firmware addresses instead of an #ifdef staircase
>
> Samuel Holland (4):
>   sunxi: spl: Disable padding from SPL_PAD_TO
>   sunxi: binman: Move BL31 and SCP firmware addresses to Kconfig
>   sunxi: binman: Support FIT generation for 32-bit SoCs
>   sunxi: Enable SPL FIT loading for 32-bit SoCs
>
>  arch/arm/Kconfig               |  1 +
>  arch/arm/dts/sunxi-u-boot.dtsi | 39 ++++++++++++++++++----------------
>  arch/arm/mach-sunxi/Kconfig    | 17 +++++++++++++++
>  common/spl/Kconfig             |  6 ++----
>  4 files changed, 41 insertions(+), 22 deletions(-)
>
> --
> 2.41.0
>

Acked-by: Jesse Taube <Mr.Bossman075@gmail.com>

Looks good!

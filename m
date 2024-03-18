Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3882C54E5D
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 19:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 352E588001;
	Mon, 18 Mar 2024 20:47:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eWDlae67";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0204788008; Mon, 18 Mar 2024 20:47:13 +0100 (CET)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C89CE87F41
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 20:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29f8ae4eae5so395456a91.0
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710791228; x=1711396028; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqr5Hy8cHPMGsKRziBoORXw8BousbvRVUnFMYlBD+i8=;
 b=eWDlae67wxGBHQFnJIhitRDSCHMIPlksBds13FEtBb41q4XsTQLa/ecQBdW74R/TB4
 bROoRFEy+ZgAFgQwCg/214QCsnvYUGOClIuCh91WoSY4PW+0V42AlnkXAzioxFoU6zi6
 JG2e61Vc79E6n/wByi68LBrXiZTSGHrr81Hcum3k/nvMTaVv8XkM6KCFT5f8zPQZQnW2
 8IEgFFRT8VhwjRUSb7fm7Smd9KX2XiSxw5Iia/+yMrd342xQD26ys6i+y5QXN0k0a50r
 2IX6Rjv7rR1JnImvWHrOOJuejtB0hGT0gggRNOStvbVaaoLNH2NfBiIU9nrGYjI0k8X+
 Qj2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710791228; x=1711396028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqr5Hy8cHPMGsKRziBoORXw8BousbvRVUnFMYlBD+i8=;
 b=wF6Be3GSDo8OTWmRmW8fmo2ygxL3jtIQuBgSiD4uQ4NvR5Skrpv7r1ZbISFt/ATMYN
 Qp5I2bTWdoy52uhdtMajU32bR83pQqOuBnvisbltOvqhFGXHy6we9nTwo76A2/wxKzsI
 6FXmsjbjGrDvA60IhAdEtPCLwWqVEooGCbHoN4kzt4q+N+2ebScYY4rhg/osAowQ1iQk
 +2E5rTAsb8ssNHLRJ4im4TWaqNaOnWlQi3BWJ2W2hspMeManTlAtYfqjRJAd8iCUgZaY
 JnXDh1cI12/x19ArrUQ5kHCyd8MSP9FmF3+/XCN/Xh/gembe1g1OY4VtnDUqiPAnDO6A
 cGog==
X-Gm-Message-State: AOJu0YwO6qkDxXOeJxHWhCF+imceMZ/EVlqNdpXwQZYpcNqc1L+MSerH
 Z20cSfp//4Te4LHUHoqnq2OmgXWA7S9PWxvDk2MiThIzlZ55vu2LGMkaWgFuMqGbMjozoOK+gsY
 26me5uMdNPQ1vbaEVogOA+e62aG8=
X-Google-Smtp-Source: AGHT+IH6Lu9ULLOS2jpkmOO65FxzZAEoiK3Vu7YjyTZ98vajrWtvoyKPYtpwFJ0ih15+od3q7hCD+WaNx1xCuFTNjAA=
X-Received: by 2002:a17:90a:b889:b0:29b:780c:c671 with SMTP id
 o9-20020a17090ab88900b0029b780cc671mr9952855pjr.0.1710791228189; Mon, 18 Mar
 2024 12:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
In-Reply-To: <43haokus4jdxguk4arig5tsqcgq2wbezwpbj7oti6pdkvrfual@wa7vz2iypcv5>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 18 Mar 2024 16:46:55 -0300
Message-ID: <CAOMZO5DXy8nuVPx-8uSpcVvyLFSb++S6ad64Gg0MWM3guxGZvw@mail.gmail.com>
Subject: Re: [PATCH] arm64: Fix map_range() not splitting mapped blocks
To: =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>
Cc: u-boot@lists.denx.de, Marc Zyngier <maz@kernel.org>,
 Tom Rini <trini@konsulko.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>
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

Hi Pierre,

On Mon, Mar 18, 2024 at 4:35=E2=80=AFPM Pierre-Cl=C3=A9ment Tosi <ptosi@goo=
gle.com> wrote:
>
> The implementation of map_range() creates the requested mapping by
> walking the page tables, iterating over multiple PTEs and/or descending
> into existing table mappings as needed. When doing so, it assumes any
> pre-existing valid PTE to be a table mapping. This assumption is wrong
> if the platform code attempts to successively map two overlapping ranges
> where the latter intersects a block mapping created for the former.
>
> As a result, map_range() treats the existing block mapping as a table
> mapping and descends into it i.e. starts interpreting the
> previously-mapped range as an array of PTEs, writing to them and
> potentially even descending further (extra fun with MMIO ranges!).
>
> Instead, pass any valid non-table mapping to split_block(), which
> ensures that it actually was a block mapping (calls panic() otherwise)
> before splitting it.
>
> Fixes: 41e2787f5ec4 ("arm64: Reduce add_map() complexity")
> Signed-off-by: Pierre-Cl=C3=A9ment Tosi <ptosi@google.com>

This fixes the boot regression on colibri-imx8x.

Thanks a lot for your fix!

Tested-by: Fabio Estevam <festevam@gmail.com>

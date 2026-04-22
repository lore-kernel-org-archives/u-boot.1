Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FE0F94CB7
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 01:15:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1212A83BC8;
	Wed, 22 Apr 2026 03:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Lo6/arec";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B72FE805D7; Wed, 22 Apr 2026 03:15:47 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AE3983BC8
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 03:15:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so834574266b.0
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:15:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776820544; cv=none;
 d=google.com; s=arc-20240605;
 b=j4Y9BuGw+GHPfxXmngzJaZ9vvm3Iwg4uV/iWnHIEJSIaLfaTk5qxNsujV5H5LyCrF0
 vXSAimkw9LRKJ6QpUu56LXpgT72dBQc1WiDbp2IR9D34vJ04tXMBIx6fpVdrfIrrlaDl
 LPcUL9Q3mLw/NioFm3Y1889JkUQ/X08zqovjY1iBRVemhk679U5N52tF7HDHCUuvPbwe
 eNYTVPQS3o0UL/Gn32gdkP4SXL1KvxDgHmip+7IPcJcPNvhFgTr9Ug4cgETVrrUvTaEg
 46omya5wez6pJxfSZIyUq7pj4X1a9fmiMLFNPDFXMsTbsToJpBvXBC6VzkBvummCa+c9
 m3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2TTUYi/LNvZuK2ybNRb6oFqNP1IJC7/qcSXvtj3TSl8=;
 fh=/JwL+QfgvEmDut/hkVyWKzX1JzK7x9jVmeWqOhVMhyA=;
 b=VQf67+SKHS5ySuezNLqAl2rUPcq7OBan1lCBtSIt08Kib7y+uMDxeLwAu5qhfNLi9F
 xjFRpAxzWWlyfdZTsIcH8OXIVsnOI0+zdwGXPkkIw85VRQDP4R9ig8sOjAUcLDohqGba
 iMAfmQwCCGJtMaAkLHs+CmOD2ER8qu8u9Vu2Gc6LNqYmnHKhdNao/ZR3Ih0Zlj7YuRwG
 jiHMTWkisXm2azLhCOh89N/VBFnHoaz0KkqJQr/KXDpEZqm6qmggUYkiaw0zsm2vUQS1
 3bRhduyzN35P1aIDGlHtrdzHPOr1SuyFKLNrnosES29WLcKD6UINr6eyCFgkXLd2a0f3
 Lhmg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776820544; x=1777425344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2TTUYi/LNvZuK2ybNRb6oFqNP1IJC7/qcSXvtj3TSl8=;
 b=Lo6/arecvXq063ZKGCMFKxlvcX+UwLttOOerxRufv7n8EC3OH2fztRVFTjGsK+a1pn
 31y2bb4QK+SF/TGAN4Uy3l1P5tUgL2dAWBLjKoOUEU4IRS2f23OfVHRgamjOVrVZWLm3
 2zujvb0OD7gKoo0El11ja96R6hORvDA0ZS1CY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776820544; x=1777425344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2TTUYi/LNvZuK2ybNRb6oFqNP1IJC7/qcSXvtj3TSl8=;
 b=k831uhbt8v7CF30R1ewXJ+039l29JyKNOzagOj0ZC3QB+xWclGlZkzMpLyy4gHX3C/
 IrWJ4AUMPWAUkTEotb0s5fUEr1F8dKRkObQ5Q0w0Ue17XQvK7YgmvwL+9knrAR1fKzN2
 HLoZdTK/HODLGQ8QqyZ9vanljakYT3F7DxJQp26hmq2XurPQSYKEpZC+bc7cGHkhfrrh
 TICjD1u9dyAzAdJWqiDC4vZncByB5Iz18i1IMxIjfWYyA8DVOfSYTfAQtOvHV6TA7flM
 q1HwSxxzSu+maahdcNXCP6WZPKJUTX3XdIhEUabAjYTiqJyhAvVY4k9V6xRPXresl94e
 gCNQ==
X-Gm-Message-State: AOJu0YyTVInDiwatpexPRcHePJfT3PZp3rBLct+ftpLhaqirdYT2vdz8
 w47gXV5Agf4pbtXaEmi5mCJOnQhGYV7jW/O6g2r/Td7rk3QqdQCGM6FaPvn/O73FXLD8gMpsdFG
 u5TsnxBbYBcDA0CXGfnDSYaCj3+o1kcyVTaJCfHJl
X-Gm-Gg: AeBDies86BlanZvMW7+pVznINTY9P0kPbQd2mWg70AZoShUF9d0yfEtGvFaluQZxL92
 of1kFZQ7Z9p/CPhz3tTmktSS6bKNUNTLBtkT4oFfPNLKxr/gkgfBp0b257fCqfutEiVr85kbqPx
 S2OVVYg2mPvarQQewW9ixttfIdNAvswxS//yq4fCQUR7TxYacWg/ipH9RzcWWMTtMnedZJ5PlM1
 BNixHDmj5gmKAwGchAbIg4XbZkFuTTTtX6yVM5yitmLxyI/YrgCBHo5KoYyM7i7gyRuxaRJCTmq
 3D03fZsENSz5Uh5T0+bz
X-Received: by 2002:a17:907:c30a:b0:b96:f863:deba with SMTP id
 a640c23a62f3a-ba41aa13734mr967061366b.32.1776820544340; Tue, 21 Apr 2026
 18:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <BESP194MB2805334513D25E51B925F959DA2F2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
In-Reply-To: <BESP194MB2805334513D25E51B925F959DA2F2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 22 Apr 2026 13:15:29 +1200
X-Gm-Features: AQROBzChjO6M5Clh94TeOiBLs7Y0HWSoQavX2UrEDdwp9936zQH_GzvjbozoEmk
Message-ID: <CAFLszTjA_isan-jNdFWRwcCAEv1qj1G9pu9cfVHP0MGcBk0x_g@mail.gmail.com>
Subject: Re: [PATCH] xen: Handle malloc failure in errmsg function
To: fberder@outlook.fr
Cc: u-boot@lists.denx.de, Anastasiia Lukianenko <vicooodin@gmail.com>, 
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Francois,

On 2026-04-20T19:15:24, Francois Berder <fberder@outlook.fr> wrote:
> xen: Handle malloc failure in errmsg function
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>
>
> drivers/xen/xenbus.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

> diff --git a/drivers/xen/xenbus.c b/drivers/xen/xenbus.c
> @@ -280,12 +280,18 @@ static char *errmsg(struct xsd_sockmsg *rep)
> +             if (!res)
> +                     return NULL;

Callers like xenbus_ls() check 'if (msg)' to detect an error, so NULL
indicates success. With this change, malloc failure returns NULL,
which callers will interpret as success and continue processing.

Maybe return a static string like "Out of memory" when malloc() fails?

Regards,
Simon

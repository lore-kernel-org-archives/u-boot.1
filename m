Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30A86E77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 11:52:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B37289515;
	Sun,  8 Dec 2024 12:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="fTwe9gtx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62F4E89525; Sun,  8 Dec 2024 12:52:30 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62476894E5
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 12:52:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733658742; x=1734263542; i=xypron.glpk@gmx.de;
 bh=JEIGrl15awYuN/c+2f6D5ESNsaBloMhjT4ozj4jbMkw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=fTwe9gtxj8QRpFJJx3Bl5zrqntN2ST2HLOmdzzqO/ur8SqsP2Vgxxylb5qKiZi8m
 QUSExeqNT6G6s2LnW/X3fTugZmEENwSdXx+8YBsbBplmuNdcN5LecN0QenGKtCl4e
 4bYN/BR9NjMw73eGQxeIRC5WE/BOyifIgTxvjZJJq+QR65nGzQYJUPuW4xsC5FCUj
 wWXJijrva6fwCdq5DzfxEG4/P3iAqBlFHqI7fXWMamMYipLWyvp1LpqgIF9+Gogu7
 pgfOj+6oC/YMugAc5D1dg2wVzsuJnBIX0mLaXpssaJ0nF0pDyfxLdVIkjeffKC8UA
 gmeJE5V380tTrUywyw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4z6k-1tjWTa1p4e-00r3ed; Sun, 08
 Dec 2024 12:52:22 +0100
Date: Sun, 08 Dec 2024 12:52:18 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
CC: =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, Mayuresh Chitale <mchitale@ventanamicro.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Janne Grunau <j@jannau.net>,
 Caleb Connolly <caleb.connolly@linaro.org>, u-boot@lists.denx.de
Subject: Re: [RFC PATCH 4/7] lmb: Remove lmb_add_region()
User-Agent: Thunderbird for Android
In-Reply-To: <20241208105223.2821049-5-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-5-ilias.apalodimas@linaro.org>
Message-ID: <39A5BEE3-1027-4F81-85E6-AC7ED7798DB0@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GaKAyqqVwUmIOAyt4+5kI9xtz60BuFbgMkom2eG5I5OwcyyYeUM
 ZzFSNdh+wTqklhsXeVw5ZWtAMno2KODxkagvl/CSS4/42t7YxFUoQHeZj3HW479ihu6sHfC
 sQd++0zOKEoqaFOMB0RYvQz3y1JALmo13R8dy7Ri7P0JAawGRL5XJRWKdZ3c0jQKZY+YFrP
 SLUn0bhC8SNuQdorpIo0g==
UI-OutboundReport: notjunk:1;M01:P0:bO6iZuPRbzE=;zM8GNvo3S/IYYsKt+0hgWk5LCGe
 U1MOdbW/FJ37BA5HVRKVnCpjY8FXXE5gDsWSO/jSs7KDV4MXzfeKeyjERNfPJoPW2xjxWfcUY
 +9sZCuXeNCXFwrlAK5q7ig1CromZNl5vo91OEi9PlzaWizwu6+2tpHWvD3b0IiB00GPCEjApt
 L2s1KN8q3i36IvqMr8arpVKhmberOlTuGJX/28fA0cXD6kK0B0lvXL1RGpPhWE1HH6+7ZJEYs
 0fsR91Wt7hVSI+ppROtaDmvQoccOQyxqk/yZgkXaaaeaG1UUG+D61WT57BEtrH38rX1r2QBkp
 RDlJN1SuWZ34mvu67ffoGb1XDX09OCOC/A2o+hBmI6u8eB+oR9FZ1g1U+W+WLCPDCYzmLHiuA
 rrc+XC6cHS6sdYN+LppSpwfvkQVLEe5Se7ouargt/C+LP4BRem+bCMKxg6V6paJ1y88W239Mr
 5Z6VudS6R7RM6KdVZl8Jbi94cM4eyhT09XGAGCDCKwLUePKRypVoBkqaROEYEKRg2L4fKIVas
 To3DTLP8UY/MEu0/vYPrl1ukSgKMjt0SPNig81xSMmegJHe7g4a1/22Yv98dWNoauXuxR/gtT
 6QrB9ExCx7RAYNZddtIU2WiiqpK8Cp2juYcwTwBUCk3/6WsbQ0PGNFq8v16eEa6IlJeJ5N98R
 lHm1yerckg1judrWZiWauH4lpWn9OR5KeCJdGvOAUa3T9L+6kckkRrwZK6BJKWTvSElL2WeUL
 rKFZ+jyS7mgrLL5zesCRuINMOKXWan3vl3JDu3vdZOJniGzXPXbAP1Pape+vE+2T5Y5JtTHmL
 EcXl5K0ZMaKM8NCdYytfQ+CKOT6UFKIt4TWdOdtSYnhYJjwH5ZJdtsG8c4HnAtLizxY1iTzlp
 3Xo+blZM7jKgD0iBc72JxEmNTGSXJWtKXRFiYkEcvjLtrOqq3XF1vqmPh1qAvsl3NPFFpqSr8
 w9C4UIvWn2JatufbpoYCgl1h4njE+foZ0DWlBvibjzF5j8bKgqIrVgSoAY/sOMdSsb/QSY/UC
 7q3jzv8tRcp8LKeY/funsYwo8n+29sFKGvpC+8HYK8y0hi9sLQktsiVFoYpf+DdEgxZdXqaFg
 7tnAfPvvypJvQWQQhY32yvXUVOG+qR
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

Am 8=2E Dezember 2024 11:52:07 MEZ schrieb Ilias Apalodimas <ilias=2Eapalod=
imas@linaro=2Eorg>:
>There's no point defining a function that's called only once just to
>avoid passing the flags=2E Remove the wrapper and just call
>lmb_add_region_flags()=2E
>
>Signed-off-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> lib/lmb=2Ec | 8 +-------
> 1 file changed, 1 insertion(+), 7 deletions(-)
>
>diff --git a/lib/lmb=2Ec b/lib/lmb=2Ec
>index ffdd23d87b9b=2E=2E56e005308dde 100644
>--- a/lib/lmb=2Ec
>+++ b/lib/lmb=2Ec
>@@ -640,19 +640,13 @@ void lmb_add_memory(void)
> 	}
> }
>=20
>-static long lmb_add_region(struct alist *lmb_rgn_lst, phys_addr_t base,
>-			   phys_size_t size)
>-{
>-	return lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
>-}
>-
> /* This routine may be called with relocation disabled=2E */

This comment should be moved to lmb=2Eh=2E

Reviewed-by: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>

> long lmb_add(phys_addr_t base, phys_size_t size)
> {
> 	long ret;
> 	struct alist *lmb_rgn_lst =3D &lmb=2Eavailable_mem;
>=20
>-	ret =3D lmb_add_region(lmb_rgn_lst, base, size);
>+	ret =3D lmb_add_region_flags(lmb_rgn_lst, base, size, LMB_NONE);
> 	if (ret)
> 		return ret;
>=20


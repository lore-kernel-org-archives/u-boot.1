Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B225FE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 11:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9ED989370;
	Sun,  8 Dec 2024 12:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="CT9aB+Lt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 159E9893B3; Sun,  8 Dec 2024 12:25:43 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D40C88F20
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 12:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1733657135; x=1734261935; i=xypron.glpk@gmx.de;
 bh=FQOAP6kjCwSJggqB6ryXEZDtY7TA+P2440t33XB7qjU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=CT9aB+LtZva1yDiE1+jgQDJQA7tJJOQZd++oaPsqi7VRLripyDwNz9qmCTvx6EKC
 iwbmgMD9dDeTO2VlFXHHFhllWqpsXsg3eUYn0nJRxFkNpM83Xge7BSxMcqiBs7v3K
 YWzDBMckrauuCS+CM+QYCUCrNfPnXFTkugicY2PL4Oqfmw52aPQQ7ANG86gQAAC+f
 2JLDkhlYCpFrNIub+P/jDuOut0jGlEIE1QqzBclMeyma9GJgeT6e0T8PmRrKoq4Sb
 M9FTGUV0NS4F3RAtLK0rTKFz4oRRdsJAlgAbQG1G0lmU7YunAtMVuYPFdch5nxi4k
 n3U0TLUsYmKRYW/TeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([5.147.80.91]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MybKp-1tYEd80bYD-016hBp; Sun, 08
 Dec 2024 12:25:35 +0100
Date: Sun, 08 Dec 2024 12:25:31 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, trini@konsulko.com
CC: =?ISO-8859-1?Q?Marek_Beh=FAn?= <kabel@kernel.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Korsgaard <peter@korsgaard.com>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Janne Grunau <j@jannau.net>, Caleb Connolly <caleb.connolly@linaro.org>,
 u-boot@lists.denx.de
Subject: Re: [RFC PATCH 2/7] lmb: Simplify lmb_addrs_overlap()
User-Agent: Thunderbird for Android
In-Reply-To: <20241208105223.2821049-3-ilias.apalodimas@linaro.org>
References: <20241208105223.2821049-1-ilias.apalodimas@linaro.org>
 <20241208105223.2821049-3-ilias.apalodimas@linaro.org>
Message-ID: <F4F7021A-F167-4180-96F5-A2679A183979@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Fp5Bu+rb1nM16MWDRwrBOVAe5PxAI+d7nsEzXKzzJdNGhw9PYst
 pxrbS+r7crK7eO7dHzwdOTjMqQv7ZJ18LZq8vYH90MBq/7cwqG2ZYrHPITbf8nLvvMT4PFw
 Cec89J/WUugtscwngSBBGD2IE0lzy5G0x4BaUBmImswylhtRkToQr04tgKGR/w05+c3L7xv
 vxjxDm2YljHeE2iQUvmew==
UI-OutboundReport: notjunk:1;M01:P0:D8zqgwdVE74=;4G3MctCzXgRVkAM6keJ++xHkb2c
 L0CDo+6X5GApZDxvqj/8s5U+jbYDTQGdBgWYmpzewBOiP0bK/1tLQfMHaYoyWUlvmwtgS0eb8
 uFR7MD0i1VDl4H95vg1lJnj5dGfYzNEuj/g07cAyjhfNxRVVb6y8JLnsaEUR+mu5zCqN4zAu1
 khbghbLcAKR17I+J/4P6BgG/O43OIdM0n49fhSA2L1pD+hmix0GqrNhJmVXbzd1WlV2qwTtRH
 c+8cZVZVjy4J4Cg8praiHoC7NV1EEyL6ADP6LTSmIdY89lMdWt43TZXGk4ue4uyFmEUryvJa4
 3ecoCTtHnfpUVg8kywm/KEg2gvYoIXmO/MeOf8yrZzezmSm1Ya5TWIqZl5CZYPl8x3a6s8lCI
 rqsght1ZUYJNmZYTYVD823FJSyh5Odbzfi/VEeDX2mANMCqcL5br6zjzhX3kmQ1KUBQ/OTfO0
 t0iE1gGCEQO5jedsVzjwddFPizIXtK3FluC0e/rmhOQybdoVRMzbHKXTaXTdz/mkpdQGgZ3rV
 pEYsrsRZVNtToDIqktumEacgJKbKtJn8XkkfKhoUXlJP+bei7/OmCM81diFPUfAlqjYNJ+cp5
 boHVCANPIr5KsL4D5QX5a3eivFhNiloQ3tUuKJm1YU1sxPcnPwoFSik7s1WQOkmNXPV1uXeg2
 AHv6SGZObcElKFFLlMVTAvew2MRlyMpTYKIbxr3bGlPj/6bMgI/Xk1AGBEZknp3jlgTBoq6Sv
 X0YSrv6aKb0Zxh4dISAddYXU3IeA4/D3hUqA7O12PEsiY3HsMRYZOPgdTBl1CxygUi0u7j5qC
 ae7kMeG/DjOlhgmOo2DUIFoUvCtBKTQJMrgp/KczSdK1ZgEWDva8PNmbXYPBb7bI8QE1gdI0l
 ggOpslMFnM4/9Z6YFOTeVULPTUy+zVGQZ1psq99IQI14A8H4gmgz29fC0gClnUdNbu0TJpwTc
 U133TeiDbl/1/D8ubki3arAY7b2XeU9OghNEMaD8+/tyGXoROtHes/UDKym9Aw0z0v79+B/LM
 13WB9twums5Ts51cTKr5DvaAeOJK4o/K1SVObcor02iCkovp2+RfJx6W3oeI7sQld1doxq08Q
 AZF46qop8nv4evEPy99rCYaQBvqtBc
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

Am 8=2E Dezember 2024 11:52:05 MEZ schrieb Ilias Apalodimas <ilias=2Eapalod=
imas@linaro=2Eorg>:
>There's no point subtracting -1 from the calculated addresses and then
>check for a <=3D b=2E Just remove the -1 and check for a < b=2E

I once thought that, too=2E But it makes a difference for end=3D U(L)LONG_=
MAX=2E

Best regards

Heinrich

>
>Signed-off-by: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>---
> lib/lmb=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/lib/lmb=2Ec b/lib/lmb=2Ec
>index a7ecbb58831f=2E=2Ec7bf5120696f 100644
>--- a/lib/lmb=2Ec
>+++ b/lib/lmb=2Ec
>@@ -36,10 +36,10 @@ DECLARE_GLOBAL_DATA_PTR;
> static long lmb_addrs_overlap(phys_addr_t base1, phys_size_t size1,
> 			      phys_addr_t base2, phys_size_t size2)
> {
>-	const phys_addr_t base1_end =3D base1 + size1 - 1;
>-	const phys_addr_t base2_end =3D base2 + size2 - 1;
>+	const phys_addr_t base1_end =3D base1 + size1;
>+	const phys_addr_t base2_end =3D base2 + size2;
>=20
>-	return ((base1 <=3D base2_end) && (base2 <=3D base1_end));
>+	return ((base1 < base2_end) && (base2 < base1_end));
> }
>=20
> static long lmb_addrs_adjacent(phys_addr_t base1, phys_size_t size1,


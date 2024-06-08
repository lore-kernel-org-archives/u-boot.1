Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE083C25B76
	for <u-boot@archiver.kernel.org>; Sat,  8 Jun 2024 03:59:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF43187F8D;
	Sat,  8 Jun 2024 05:59:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="aJy26Aqm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD0E1884C6; Sat,  8 Jun 2024 05:59:43 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B993187ED0
 for <u-boot@lists.denx.de>; Sat,  8 Jun 2024 05:59:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1717819179; x=1718423979; i=xypron.glpk@gmx.de;
 bh=viwxJhuKsJVtSh3qOFwl0X0jWqlTHA+OR3r9Ksevk9c=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=aJy26Aqm7AD5SImI4xDku5dKJSPH9JofsRp6hzidjvmSww8vsbKyQTf+6Y+I6j1d
 V5Zx5v3wdWZvfjlhCk3WRI3cAcDyqHNf40+41bSfb5N1aZk+/pzE0AVy9vWJR5d9M
 tEVZilP2spsGH9/t22sUWC98UcVCHUJlZ/4P1xdAV8WXq5BcqP/6taWtK8mavVCpW
 VGPmaN/yNDYlQh/aP9XaXTCetVxx1p4GFVILknY7SzcJPCB2G+9N2O84Ro7K56lG4
 Ygcp2e79kKzdobHUkPw4YYnfk1uKXRuhv8bUmOTrUSKsmRVBxYJyyVWTSyGe0BkV8
 hWPhrrQ4gjUSAUwCYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([109.42.178.114]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mel3n-1spfp81uuT-00qghd; Sat, 08
 Jun 2024 05:59:39 +0200
Date: Sat, 08 Jun 2024 05:59:37 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
CC: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 28/31] cmd: bdinfo: only dump the current LMB memory
User-Agent: K-9 Mail for Android
In-Reply-To: <20240607185240.1892031-29-sughosh.ganu@linaro.org>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-29-sughosh.ganu@linaro.org>
Message-ID: <B9D72BA0-BB60-402C-885C-6457EC517973@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GoOwgoQs8l5okpvCsq9YLoTHyLdluAdfrzjinZ+7vrVAGF6joBD
 09KriMTbgYW17sx5gMLNOg6aBHlNW1GD/Uxx910pCRsgSvWoP/6hpWgC1S3KGYBoYm2NJSF
 6z9Llc8U1Zs8j0JcieGUU76mbzvlPIsFvzRnztA9nMxsv8goIEZ+/pdgE0MkUcZavYUXiE7
 AdEcCvP+ak2cXMKf1BE8g==
UI-OutboundReport: notjunk:1;M01:P0:JlP5vbQCo7M=;37pBF9jnxakPRVNNIvBEI6/Ad4w
 7+6+1I42ZqQL5izZ+gTj5eedkxNNo0jSB4GN+sav330mvgp0JxCb+WhzI/Uze+MbbivQyGI0J
 IiB4hJu0knThk3MeJ4EIZMIaJOCHsKHkYeUMMBNIzlOCDqCwZlxSCErMurLWI0bzaZ3+LvRSu
 9aw34Z+Mz57hhMGhI68BAscpneQgB8IpI9Oi3hHsulKabMvvEE1hAeLSdCA9fiQdC4bqJoUtp
 CaB/p6IZF2VIVMWcjoYUdRnGLjCLvJVoGLyKiwRJkGTnioAbPSYk35naByeS2okdTgunNZj9Y
 XLR2TjNv8JVFOnzqYdJAQpF+SwnRMP/rtUTgXtVQ+GExBNA9vGeFIyYeRO3Cil6gpc71hM6iJ
 uZa4ordmmrfpydONfyy0SU9fFw8pVCLO2PahfxM59q4wvvnhPj/IV7gOMEjyiCDPDeX91zrsp
 +4WVCo3h/U/nORAXi3rtwSp+kwi8GGIHfpV9uNaS5nqMiwgA2IYvA/OTTlbChywCAXKvB+EXc
 GE2fg2d+No1Gc6JYVf36GO5xBOfSLZplJKqmrPIk40F0Gd1jqunu20LsaTSUGtzYEIgFnkfY1
 hmFz4FGP/T49IUgfD9FZcIJNOYCPdPPJSP+/wWW0ineAgGm2WwaWTwHRTAd1MwZd4CykTYzPp
 afWbIr5IBkKHaAq1UwkdDl6GZGn3Q8FbV0VdiX87n+oyZ7mQa0Xg60b4cnNte5r7Oc/5dwLZs
 FZ/5mp2vF7uiIiSfsmJN0aQ61KHkA7UBLslEN9e0BosHtB0ahPLf2B9nQzLg45r8HnEPTMcSB
 HZjz0gN7B3JjlTq3/uL5rZWO+4nJITqw6nfBbUCbB9LoY=
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



Am 7=2E Juni 2024 20:52:37 MESZ schrieb Sughosh Ganu <sughosh=2Eganu@linar=
o=2Eorg>:
>The LMB memory map is now persistent and global=2E There is therefore no
>need to add memory to the LMB memory map as part of the bdinfo
>command=2E Only dump the current available and reserved memory as part
>of the bdinfo command=2E

Would it make sense to move printing lmb memory to a separate command inst=
ead?

Best regards

Heinrich

>
>Signed-off-by: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>---
> cmd/bdinfo=2Ec | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/cmd/bdinfo=2Ec b/cmd/bdinfo=2Ec
>index fc408e9820=2E=2E0f343203ef 100644
>--- a/cmd/bdinfo=2Ec
>+++ b/cmd/bdinfo=2Ec
>@@ -163,7 +163,6 @@ static int bdinfo_print_all(struct bd_info *bd)
> 	bdinfo_print_num_l("multi_dtb_fit", (ulong)gd->multi_dtb_fit);
> #endif
> 	if (IS_ENABLED(CONFIG_LMB) && gd->fdt_blob) {
>-		lmb_add_memory(gd->bd);
> 		lmb_dump_all_force();
> 		if (IS_ENABLED(CONFIG_OF_REAL))
> 			printf("devicetree  =3D %s\n", fdtdec_get_srcname());

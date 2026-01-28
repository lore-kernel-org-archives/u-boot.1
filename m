Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF2CD35669
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 04:32:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E047841FF;
	Wed, 28 Jan 2026 05:32:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Vr9ziqdI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C9184213; Wed, 28 Jan 2026 05:32:51 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB3A6841E7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 05:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769574756; x=1770179556; i=xypron.glpk@gmx.de;
 bh=LUL6UbZmpMkCG5tTHpuYdnUIHcpZpV/3VDnugYglA8c=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Vr9ziqdIqZsJ/8jDTSNe1786lut1U68a5scd55BCs9m2JHaDEkJG82W8BPfECkIu
 ehclu7sIJRakXKSfYyS9cAjj+0VGaPavG5pNbggwOYYrZssgqMY8Fl/UTICQkFzyH
 x9rU12iWlt5+hOm2qbiB4ECSaZutjyznF06i7x5n2rqbFSiF3WEtfk4cMYbLK39vO
 /bVNmGQxvnVQo2eYiJr7oUHe5fgdUY/pSDHfn/3HzfZxk/AD35M3DzvHFuseY9Mky
 y+eKRMDPXgHuCJCxh89ym7AddGEG5GUvSPwtwsHb5DuyhwI3tDB1DoAJVVcAvpGpc
 rOpdXgt8JUN10gfM1A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26vB-1viUG51non-000A7x; Wed, 28
 Jan 2026 05:32:36 +0100
Date: Wed, 28 Jan 2026 05:32:32 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
CC: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Alexander Graf <agraf@csgraf.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] gunzip: Fix len parameter in function signature
User-Agent: Thunderbird for Android
In-Reply-To: <20260127235156.1503207-1-marek.vasut+renesas@mailbox.org>
References: <20260127235156.1503207-1-marek.vasut+renesas@mailbox.org>
Message-ID: <0F151B61-19A0-4F8E-925B-1EDFD7054E1B@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Osj91HRuxgTvkhfOCbjn0WTNFEkrX1u3UGoddBgbMZGJSdMFKpm
 FO5iKb4CUlZTiqBDkJSa1n0Ll0b7VLQ5jhADwN5Pf6AUzLPkwQQnU8T3C/joLFEhX3G0UO/
 UK0ya6GqFBcINIASWc6qIBBQtVpvhbI/iG62G/U6MrAiwZSsklwMxqJfjQuimwwAcdHBLbZ
 bFncXbxdG+fGgYw15LWHg==
UI-OutboundReport: notjunk:1;M01:P0:m2d8sqjxmp8=;CJmQCmSNlcGHPT0ToIlcFnhlpl+
 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
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

Am 28=2E Januar 2026 00:51:35 MEZ schrieb Marek Vasut <marek=2Evasut+renesa=
s@mailbox=2Eorg>:
>The only call site of gzwrite() is cmd/unzip=2Ec do_gzwrite(), where
>the 'len' parameter passed to gzwrite(=2E=2E=2E, len, =2E=2E=2E) function=
 is of
>type unsigned long=2E This usage is correct, the 'len' parameter is
>an unsigned integer, and the gzwrite() function currently supports
>input data 'len' of up to 4 GiB - 1 =2E
>
>The function signature of gzwrite() function in both include/gzip=2Eh
>and lib/gunzip=2Ec does however list 'len' as signed integer, which
>is not correct, and ultimatelly limits the implementation to only
>2 GiB input data 'len' =2E
>
>Fix this, update gzwrite() function parameter 'len' data type to
>unsigned long consistently in include/gzip=2Eh and lib/gunzip=2Ec =2E
>
>Furthermore, update gzwrite() function 'szwritebuf' parameter in
>lib/gunzip=2Ec from 'unsigned long' to 'ulong' to be synchronized
>with include/gzip=2Eh =2E
>
>Since the gzwrite() function currently surely only supports input
>data size of 4 GiB - 1, add input data size check=2E The limitation
>comes from the current use of zlib z_stream =2Eavail_in parameter,
>to which the gzwrite() function sets the entire input data size,
>and which is of unsigned int type, which cannot accept any number
>beyond 4 GiB - 1=2E This limitation will be removed in future commit=2E
>
>Reported-by: Yuya Hamamachi <yuya=2Ehamamachi=2Esx@renesas=2Ecom>
>Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>---
>Cc: Alexander Graf <agraf@csgraf=2Ede>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Jerome Forissier <jerome@forissier=2Eorg>
>Cc: Mattijs Korpershoek <mkorpershoek@kernel=2Eorg>
>Cc: Neil Armstrong <neil=2Earmstrong@linaro=2Eorg>
>Cc: Peng Fan <peng=2Efan@nxp=2Ecom>
>Cc: Quentin Schulz <quentin=2Eschulz@cherry=2Ede>
>Cc: Simon Glass <sjg@chromium=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: Yuya Hamamachi <yuya=2Ehamamachi=2Esx@renesas=2Ecom>
>Cc: u-boot@lists=2Edenx=2Ede
>---
> include/gzip=2Eh |  4 ++--
> lib/gunzip=2Ec   | 13 ++++++++-----
> 2 files changed, 10 insertions(+), 7 deletions(-)
>
>diff --git a/include/gzip=2Eh b/include/gzip=2Eh
>index 304002ffc42=2E=2E5396e3ffec7 100644
>--- a/include/gzip=2Eh
>+++ b/include/gzip=2Eh
>@@ -77,8 +77,8 @@ void gzwrite_progress_finish(int retcode, ulong totalwr=
itten, ulong totalsize,
>  *		for files under 4GiB
>  * Return: 0 if OK, -1 on error
> p */
>-int gzwrite(unsigned char *src, int len, struct blk_desc *dev, ulong szw=
ritebuf,
>-	    ulong startoffs, ulong szexpected);
>+int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>+	    ulong szwritebuf, ulong startoffs, ulong szexpected);

Ulong and unsigned long are essentially the same but using both in one fun=
ction signature looks weird=2E

I would prefer size_t for the size of objects in memory and off_t for file=
 sizes and positions in files=2E

Please, consider adjusting startoffs and szexpected, too=2E

>=20
> /**
>  * gzip()- Compress data into a buffer using the gzip algorithm
>diff --git a/lib/gunzip=2Ec b/lib/gunzip=2Ec
>index a05dcde9a75=2E=2E040450c0e79 100644
>--- a/lib/gunzip=2Ec
>+++ b/lib/gunzip=2Ec
>@@ -116,11 +116,8 @@ void gzwrite_progress_finish(int returnval,
> 	}
> }
>=20
>-int gzwrite(unsigned char *src, int len,
>-	    struct blk_desc *dev,
>-	    unsigned long szwritebuf,
>-	    ulong startoffs,
>-	    ulong szexpected)
>+int gzwrite(unsigned char *src, unsigned long len, struct blk_desc *dev,
>+	    ulong szwritebuf, ulong startoffs, ulong szexpected)

ditto

> {
> 	int i, flags;
> 	z_stream s;
>@@ -133,6 +130,12 @@ int gzwrite(unsigned char *src, int len,
> 	u32 payload_size;
> 	int iteration =3D 0;
>=20
>+	if (len > 0xffffffff) {
>+		printf("%s: input size over 4 GiB in size not supported\n",
>+		       __func__);

Please, use log_err() for error output=2E

Best regards

Heinrich

>+		return -1;
>+	}
>+
> 	if (!szwritebuf ||
> 	    (szwritebuf % dev->blksz) ||
> 	    (szwritebuf < dev->blksz)) {


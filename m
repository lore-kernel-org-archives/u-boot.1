Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFCDD35673
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 04:42:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E798D841E2;
	Wed, 28 Jan 2026 05:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="oWaZWtM3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0823A841E7; Wed, 28 Jan 2026 05:42:07 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1919841B9
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 05:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769575305; x=1770180105; i=xypron.glpk@gmx.de;
 bh=Mi9cRGVpGXulTdY1te8TCzbTIndUSoQFa+yQDW5egQw=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=oWaZWtM3cV8byDMmt9DuaLp+q4WXTDMpjHrmmXtxEVeos4BsDL4QGHYt7R68VVc/
 4rFl15qG+z5Ftfx46VwU5Bgx+faH7ATKCerYGTIipMv9pa7NvGIsmOlItWPnzr5ev
 H4MLF7nsi5npfj/Ft1ASZGNAc18t0r5/s7xIy30uLLjaWXRqEq4xinpCspTWrYYRD
 iwPnak8JOuQTsfxZdyWw1ZphAh95ZuZZF8IraH9E+quuQUHN0xrFrDUwO/2gDuXMX
 g8vRvp+WBdvm5p32kRMUPBEdsUlHwW4FtX0rzl+tIkVBEMYtqo3msS+zjcHDX+BCm
 22BALZZUrNNtjE9ZNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UV8-1vlVL02KW2-003BDk; Wed, 28
 Jan 2026 05:41:44 +0100
Date: Wed, 28 Jan 2026 05:41:42 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
CC: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
User-Agent: Thunderbird for Android
In-Reply-To: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
Message-ID: <A2BF7446-8270-486A-9239-8CBB2C52AC17@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hZoTlDeeZez5tXQfR+Tezf4wzKPveW6rsa0b7ayS4Rc1JUa+zgL
 hmmY2TjGz8I2HfliXh6K2jg/CV+btrXlq8C84AG0YglDAOMtsE24t4gH55uK1xOK17M+UIR
 HhNIkBIOHBo+awsaIAU5to9A5E9atGpasHOFJvGkOTWVQ1kaH03AOGFmiTKRJaIlrTAB1dc
 9gh2H8dZigykspy8hnEFA==
UI-OutboundReport: notjunk:1;M01:P0:0Fa9meR8Afo=;mWYlFNMNS3nGQZrLQGm/kSm9dAr
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

Am 28=2E Januar 2026 00:48:40 MEZ schrieb Marek Vasut <marek=2Evasut+renesa=
s@mailbox=2Eorg>:
>Revert commit eb052cbb896f ("lmb: add and reserve memory above ram_top")
>and commit 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even fr=
om
>same bank")=2E These are based on incorrect premise of the first commit, =
that
>"U-Boot does not use memory above ram_top"=2E While U-Boot itself indeed =
does
>not and should not use memory above ram_top, user can perfectly well use
>that memory from the U-Boot shell, for example to load content in there=
=2E
>
>Currently, attempt to use that memory to load large image using TFTP ends
>with "TFTP error: trying to overwrite reserved memory=2E=2E=2E"=2E With t=
his change
>in place, the memory can be used again=2E

IIRC there are drivers that have issues with memory above 4 GiB and boards=
 that artificially set ram_top to 4 GiB to work around these issues=2E We n=
eed to carefully consider why the reverted patch was introduced=2E

Why does your board use a 4GiB ram_top and not place ram_top at the physic=
al top?

Best regards

Heinrich

>
>Fixes: eb052cbb896f ("lmb: add and reserve memory above ram_top")
>Fixes: 1a48b0be93d4 ("lmb: prohibit allocations above ram_top even from s=
ame bank")
>Reported-by: Yuya Hamamachi <yuya=2Ehamamachi=2Esx@renesas=2Ecom>
>Signed-off-by: Marek Vasut <marek=2Evasut+renesas@mailbox=2Eorg>
>---
>Cc: Andrew Goodbody <andrew=2Egoodbody@linaro=2Eorg>
>Cc: Casey Connolly <casey=2Econnolly@linaro=2Eorg>
>Cc: Heinrich Schuchardt <xypron=2Eglpk@gmx=2Ede>
>Cc: Holger Brunck <holger=2Ebrunck@hitachienergy=2Ecom>
>Cc: Ilias Apalodimas <ilias=2Eapalodimas@linaro=2Eorg>
>Cc: Jonas Karlman <jonas@kwiboo=2Ese>,
>Cc: Mark Kettenis <kettenis@openbsd=2Eorg>
>Cc: Sam Protsenko <semen=2Eprotsenko@linaro=2Eorg>
>Cc: Sughosh Ganu <sughosh=2Eganu@linaro=2Eorg>
>Cc: Tom Rini <trini@konsulko=2Ecom>
>Cc: u-boot@lists=2Edenx=2Ede
>---
> lib/lmb=2Ec | 17 +----------------
> 1 file changed, 1 insertion(+), 16 deletions(-)
>
>diff --git a/lib/lmb=2Ec b/lib/lmb=2Ec
>index e2d9fe86c14=2E=2E8f12c6ad8e5 100644
>--- a/lib/lmb=2Ec
>+++ b/lib/lmb=2Ec
>@@ -611,7 +611,6 @@ static __maybe_unused void lmb_reserve_common_spl(voi=
d)
> static void lmb_add_memory(void)
> {
> 	int i;
>-	phys_addr_t bank_end;
> 	phys_size_t size;
> 	u64 ram_top =3D gd->ram_top;
> 	struct bd_info *bd =3D gd->bd;
>@@ -625,23 +624,9 @@ static void lmb_add_memory(void)
>=20
> 	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> 		size =3D bd->bi_dram[i]=2Esize;
>-		bank_end =3D bd->bi_dram[i]=2Estart + size;
>=20
>-		if (size) {
>+		if (size)
> 			lmb_add(bd->bi_dram[i]=2Estart, size);
>-
>-			/*
>-			 * Reserve memory above ram_top as
>-			 * no-overwrite so that it cannot be
>-			 * allocated
>-			 */
>-			if (bd->bi_dram[i]=2Estart >=3D ram_top)
>-				lmb_reserve(bd->bi_dram[i]=2Estart, size,
>-					    LMB_NOOVERWRITE);
>-			else if (bank_end > ram_top)
>-				lmb_reserve(ram_top, bank_end - ram_top,
>-					    LMB_NOOVERWRITE);
>-		}
> 	}
> }
>=20


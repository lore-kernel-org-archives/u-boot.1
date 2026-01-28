Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F132D35671
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 04:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E49C8841E2;
	Wed, 28 Jan 2026 05:53:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="XMYvrKey";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E04968422D; Wed, 28 Jan 2026 05:53:58 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C676D841D7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 05:53:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769576029; x=1770180829; i=xypron.glpk@gmx.de;
 bh=LxR4rhwRGsDTeZqHgc4cRekzG4lBcncb041WCS7rXWo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=XMYvrKeybxlVSOaPrRm89+151+rZIUOrn5FD1bwX9fLhT6E5vvNsi2afcX4DZM9j
 142t+HTJ59AaYB0CHHxlrWWn94FmKbd09umq6pjD0c7c0kieGoPgH6+5wK61rWuca
 GU3wG8iVZFWzKy0PucJUB29iua7KTqjga78SFTmhHA5x4jmCxAv1YGZlJ6YjZfrfW
 TXclwRznb0IGV+LCKqXCGl/1lfhBn1l/jN1sRrRuOpUAS3l6Vl1x94tSdap4owiZG
 BuqQP6r2sxApdfMUvyyj9zXaWEXTP7LIlXDIWmWuchCiDzN3SEsz/Wb/nU9hByOQm
 JLV9rwNrATO+ziXn3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVNB1-1vM2A72daZ-00UUqp; Wed, 28
 Jan 2026 05:53:48 +0100
Date: Wed, 28 Jan 2026 05:53:45 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
CC: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_cmd=3A_zip=3A_Use_map=5Fsysme?=
 =?US-ASCII?Q?m=28=29_with_buffers_in_the_zip_command?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260127235339.1503312-1-marek.vasut+renesas@mailbox.org>
References: <20260127235339.1503312-1-marek.vasut+renesas@mailbox.org>
Message-ID: <CE08F0E4-6577-4CC8-9512-76790D72830A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1mjV9RBunXT0xjGupEZTX2fZDl5DvtntfFT9VsnPeKmPR/U1HJ/
 FB+eVHe1q4w3cDt6kCQyhll3ai03SS/vD88teDwiYJ50A8XQ8Q27DYK7WLWU4VxJ8mJmGSy
 cFv0V7hdRssbK8xgM2oOBqdsSRjpws1A03/10Uk2jOh2QFSvZVeX1DJ6XJyV7DanKoqBeU8
 ++s0v/DT0q7uYvWZ/E1XA==
UI-OutboundReport: notjunk:1;M01:P0:sD0/qMrC81Y=;MAjfX/k7RW9Tf88XYqBKgo90c4j
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

Am 28=2E Januar 2026 00:53:23 MEZ schrieb Marek Vasut <marek=2Evasut+renesa=
s@mailbox=2Eorg>:
>The current implementation casts an address to a pointer=2E Make it more
>sandbox-friendly by using map_sysmem()=2E
>
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
> cmd/zip=2Ec | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/cmd/zip=2Ec b/cmd/zip=2Ec
>index 2d255428822=2E=2E1712434ba0a 100644
>--- a/cmd/zip=2Ec
>+++ b/cmd/zip=2Ec
>@@ -7,6 +7,7 @@
> #include <command=2Eh>
> #include <env=2Eh>
> #include <gzip=2Eh>
>+#include <mapmem=2Eh>
> #include <vsprintf=2Eh>
>=20
> static int do_zip(struct cmd_tbl *cmdtp, int flag, int argc, char *const=
 argv[])
>@@ -27,8 +28,10 @@ static int do_zip(struct cmd_tbl *cmdtp, int flag, int=
 argc, char *const argv[])
> 			return cmd_usage(cmdtp);
> 	}
>=20
>-	if (gzip((void *) dst, &dst_len, (void *) src, src_len) !=3D 0)
>+	if (gzip(map_sysmem(dst, dst_len), &dst_len,
>+		 map_sysmem(src, src_len), src_len) !=3D 0) {

Wasn't the idea of map_sysmem() with a non-zero length to have a matching =
unmap_sysmem()?

@Simon:

Does the sandbox really need the mappped areas or can we get rid of the le=
ngth parameter and of unmap_sysmem()?

Best regards

Heinrich


> 		return 1;
>+	}
>=20
> 	printf("Compressed size: %lu =3D 0x%lX\n", dst_len, dst_len);
> 	env_set_hex("filesize", dst_len);


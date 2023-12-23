Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F4FC46CD2
	for <u-boot@archiver.kernel.org>; Sat, 23 Dec 2023 00:45:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16EEE876BF;
	Sat, 23 Dec 2023 01:44:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Y+J2IegL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1AD7871CE; Sat, 23 Dec 2023 01:44:49 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D91ED874AC
 for <u-boot@lists.denx.de>; Sat, 23 Dec 2023 01:44:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1703292286; x=1703897086; i=xypron.glpk@gmx.de;
 bh=kVAfIZBf46G043JD7oJySFPmZFjX54+PEB3y0+1grwU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
 References;
 b=Y+J2IegL16ykSkP7dD4TI3Fa/mqaE1v6l8QfNuBPSZQe06p4LmlLclpvKl2i3BRf
 ckVP4359lAIBzuCcdsnkWGa1DGnJ5majO9PpTpHJ3qLGoA5YJXVKnxoc3bOU6O/bO
 9bsRKS4J4dfX+IS6WqHUC5PpK6nTZFuqhUJga3uSfVFv6dxzOZRZ7LACuIL5K5XVJ
 h28T4TlzDvAeaf5X8ZqC0WMWsTULP1T01SvuX6nNvNwo+h1Of266QBMlnLpehM3bt
 9GQu8xrvzWmPP8Loa77IG+FPnrQVZEFvvHLagvxTC4EOMjMIGX1aHf8DTfLeFJDwc
 KMmmrBKmd41UFjEtWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from x13s.fritz.box ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4b1o-1rFBhg2GaU-001l52; Sat, 23
 Dec 2023 01:44:46 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/5] smbios: correct definition of gd_smbios_start() macro
Date: Sat, 23 Dec 2023 01:44:25 +0100
Message-ID: <20231223004429.247301-2-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231223004429.247301-1-xypron.glpk@gmx.de>
References: <20231223004429.247301-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vL9YIXAspd4PE/MdYVP1T34wvqk4FuGdcqHTgXdKabiaK3DgbPQ
 XCskIzDkitFeOXBGHglux/PIEqXQ6cO6iCahWnQ9japfgNBqgN9AJwWJstv27BH1mXbjD3N
 wJssZf06NxDU3HzhHsP4aIQaMghF7EvApODBuTDhfWFH2l+lxDe/A8RLvZTJXz5IVzXNUAs
 169VJbmAJCLZZdR7eqblg==
UI-OutboundReport: notjunk:1;M01:P0:A+NSzR8rY+c=;Yctt3U/ZXjGzEhM7kfY/dAYBipl
 8qdqbU6DgOGlZKw8iVAG7ILfw9BqEOY+5ZyACpl8TE2Z/BugjPYIiZZyWqea0eE7M71B4lQbv
 Q2MNbyZ12rWIlZO5ZyznXhdLyMi1X0GP/Ke0ewSwkR+zrTmAz1FxosVrRawrN0KfYCjTQygZ2
 rbXn3d0r0fOKzP2XlW1BL+eOgGWguvg0SYO1jJjU9RtXPe8ia+VrX82dK/1FUT9zSpa3SMkMr
 XpbwJO6vcWtTnt1dq9Vd0vydsw6KiBhMea6buH5JLtpfgUIQQNioelmfVZZiov+laVktrW3Ch
 hIKUB+0y3bhto+52smBP99xXSPTpyB1j0PbmecSP3rAfCN3QoZexjIodE3kNkMhi+gBv7Fnbh
 YWEJELZS0K3ydALVUYwD6rIw/84Y9QUXcyB7zzK1lqlXQnOfuIq48KVVnEWiZ0DIFJg5RS0t7
 PgiBXi3gxaTAFCLlrEEJwmhrC//NPxRd/9R5YEmDY0F7QkMf1zdOm7pV/YngiGCXrQgEBMx1v
 MO9HtOzJVGRMbFIdGWl/oBrev2HId8SQEnhvL/I6zdlV+ElUzDvuGgTFfit9/5YMwNd8Fwq2/
 havK0tEpgDZnmilnbT1EJ7dTc5sTcUAL6Gi3+v7wnWsfzkvdXOJyQA1W+BGTWNhATtCnXI22/
 xMarbMmN8Fbv6izNA/ZfUclIT3lNmJreJ+GEWCmc91BWt+Beb3Ayspa+f16zCBvcZGZ2xv3R5
 dAnddt3oCYqOTC8drtgxjsnVSBtO5qcBAj4gXbryOzFrlt7CQIcLAgDKsLyldKmNco87MkBnc
 fVqrdcxIIym26b4rBxcByP1CdmWDJpyvLcZ/VlprOE04sShPI6thrbBPYwU3Gz71mIhk01LAv
 2ZOmAfkGjI2cLIinkkZea+t9x1W8CQ/LEgoCrTr/8tuhc/fRWabJLuMswuL15CKwvhBk2LKrZ
 gLB57CuprNN5mHPP7ir1aED9SdE=
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

gd_smbios_start() currently points to a non-existent field.
It should return the field written by gd_set_smbios_start().

Fixes: 50834884a815 ("Record the position of the SMBIOS tables")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 include/asm-generic/global_data.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/global_data.h b/include/asm-generic/globa=
l_data.h
index e8c6412e3f..c1f7818817 100644
=2D-- a/include/asm-generic/global_data.h
+++ b/include/asm-generic/global_data.h
@@ -553,7 +553,7 @@ static_assert(sizeof(struct global_data) =3D=3D GD_SIZ=
E);
 #endif

 #ifdef CONFIG_SMBIOS
-#define gd_smbios_start()	gd->smbios_start
+#define gd_smbios_start()	gd->arch.smbios_start
 #define gd_set_smbios_start(addr)	gd->arch.smbios_start =3D addr
 #else
 #define gd_smbios_start()	0UL
=2D-
2.43.0


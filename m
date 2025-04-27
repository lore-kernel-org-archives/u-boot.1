Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C596C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 15:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B81980FDE;
	Sun, 27 Apr 2025 17:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="LS4XxuSc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 78F4981E0F; Sun, 27 Apr 2025 17:19:33 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F68D80FDA
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 17:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1745767149; x=1746371949; i=xypron.glpk@gmx.de;
 bh=a8FzK71fslg+GfxY5KawX63+xDW2agG+VqDNyWJWROk=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=LS4XxuScYh0eCR875aP3kLOJG30CJKpaaMH1PNCK632q6l8pbCd4cdqTFD2QynCU
 w1TVJyfic7sycwJU1rxWG/AOoPwIRm5zYIwKk8Y/kN87E1ENSOoa0eIoiuwsskXvT
 sgCB7Cq0yfPRCPm8HBJAQfu6fTtTk7iHtGl0X7KDmpwoxxP7MisaJESIk5kO+QQMV
 5xCV2Fv1OCsQKnI90DuZQTgijNHiYHx2MupmR2B3gmROdX5siM9S7uJWSWotukVIu
 tB+k/B6XvQL53g/ZMLlHQ/8RQO/alTNAVlsWdKIQst7daoQZ3uHeCB1Q2P17dt/GB
 0UNNHO0gore0BEAdxQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([61.8.153.191]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4s4r-1u7gjr2fd1-00HTSP; Sun, 27
 Apr 2025 17:19:08 +0200
Date: Sun, 27 Apr 2025 17:19:04 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Yao Zi <ziyao@disroot.org>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
CC: u-boot@lists.denx.de, Nathaniel Hourt <I@nathaniel.land>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_Makefile=3A_Strip_leading_sp?=
 =?US-ASCII?Q?aces_when_preprocessing_generated=5Fdefconfig?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250427145011.17331-2-ziyao@disroot.org>
References: <20250427145011.17331-1-ziyao@disroot.org>
 <20250427145011.17331-2-ziyao@disroot.org>
Message-ID: <1526A781-5592-43DE-94F2-221DAA484192@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DlLoz8O1aGrO7wtu39PsBDAo3zqvmRuwoMYBjhyi1IYKZfjN7Wt
 CGUT66KSpvGNaps1rkVHH3jctHlLAr0kOS3k1bIxI2Znwp+wUQ4Cj6QRST7//wBgu7z89vZ
 FehIAqVs6rsxrBn2Ojj1L5WIhpy9CnHI44CU2ub/qEX0Js+vn2/Bc8oX3+HfwAVPlECv0UQ
 iSUcMs0i0CwDQhbMrGnsw==
UI-OutboundReport: notjunk:1;M01:P0:EYh95JySME0=;MslLqklPuP1gHh9vzHTl8PfIdqK
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

Am 27=2E April 2025 16:50:10 MESZ schrieb Yao Zi <ziyao@disroot=2Eorg>:
>Clang's preprocessor may emit extra spaces for lines starting with '#'=2E
>Lines with these extra characters cannot be handled by Kconfig and will
>be ignored with warnings like,
>


Do you have an example for reprocing the issue?
Is there an understanding why Clang behaves in this way?

Best regards=20

Heinrich=20

>        unexpected data:  # CONFIG_OF_BOARD_FIXUP is not set
>
>Those options that is expected to be assigned explicitly with N will be
>set to the default value, messing up board configurations=2E
>
>Let's sed these spaces away to ensure board configurations could be
>correctly generated with Clang=2E
>
>Fixes: 2027e99e61a ("Makefile: Run defconfig files through the C preproce=
ssor")
>Reported-by: Nathaniel Hourt <I@nathaniel=2Eland>
>Signed-off-by: Yao Zi <ziyao@disroot=2Eorg>
>---
> scripts/kconfig/Makefile | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
>index 079add4d5da=2E=2Eba30652f01a 100644
>--- a/scripts/kconfig/Makefile
>+++ b/scripts/kconfig/Makefile
>@@ -94,6 +94,7 @@ endif
>=20
> %_defconfig: $(obj)/conf
> 	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(sr=
ctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
>+	$(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
> 	$(Q)$< $(silent) --defconfig=3Dgenerated_defconfig $(Kconfig)
>=20
> # Added for U-Boot (backward compatibility)


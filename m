Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79180D35673
	for <u-boot@archiver.kernel.org>; Wed, 28 Jan 2026 04:55:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE0F841E2;
	Wed, 28 Jan 2026 05:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="gq7jCO5f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E8A384239; Wed, 28 Jan 2026 05:55:32 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45DB1841D7
 for <u-boot@lists.denx.de>; Wed, 28 Jan 2026 05:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1769576108; x=1770180908; i=xypron.glpk@gmx.de;
 bh=jJ4i3vHbWvBUoy5iwtwto+h00EVP8btUy4SH/6lqzLo=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=gq7jCO5fYWxTTbkmkeVqHp0pMjTqYi4J42y+E3tXlvwhHz3j54RiZkFvpjm4BKUq
 X1L+p5aQZpGQ+YCmlpmxQrg+TD8SgZXxbYCvA/Kl3hSIhoqaj42+Eo3zPprFjptLK
 R0F7hir+/2zrSjIylAk9fD+1U4zUpK+KhvtZ1nh4pKC9yrC+fTdYHZuAf4yhDlxn8
 nLlBjZdu7CGJoLxukGc5VjBaae/aibu32yg9Nq9qZ1E5SGKERYwDmSTTmrtn1yrN+
 XlrvDw9N9mOHbt1DkVy8F/JD0Mt6lPDDJOm232CLHKYFjvbtpsQdq34NRB4vW6kWr
 MQ8/+l7YPzp62CF86A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ehlo.thunderbird.net ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Md6R1-1wKIGW3kix-00bxZN; Wed, 28
 Jan 2026 05:55:08 +0100
Date: Wed, 28 Jan 2026 05:55:05 +0100
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
CC: Alexander Graf <agraf@csgraf.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_cmd=3A_unzip=3A_Use_map=5Fsysmem?=
 =?US-ASCII?Q?=28=29_with_buffers_in_the_gzwrite_command?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260127235310.1503239-1-marek.vasut+renesas@mailbox.org>
References: <20260127235310.1503239-1-marek.vasut+renesas@mailbox.org>
Message-ID: <15C875DB-52B1-4BFF-98EE-FB45F570898A@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:z3wJcE7L0DRh83caAF7L+Zck/AYPPmmz5mCNJ0nwonwQeGPBsxB
 2mfZ1Xbnh6LWdsspa52LpTh2H1qGr4s7R/oaTjyvnOT0lPMB9VZvF7pnPs6R0VkpVCE5wqw
 55x7nDqJPIsq9LiOCuk9+oxC4v4vgwEoQ8MmkhaeMPUrUnjkgj+TYvXZgTz3OsGY1XnJy+n
 96Ig82m7FNbMx/pBRkMow==
UI-OutboundReport: notjunk:1;M01:P0:lCVfZr0EmCg=;Jo88taxkU8XJA4Xrh0yseKElTZz
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

Am 28=2E Januar 2026 00:52:50 MEZ schrieb Marek Vasut <marek=2Evasut+renesa=
s@mailbox=2Eorg>:
>The current implementation casts an address to a pointer=2E Make it more
>sandbox-friendly by using map_sysmem()=2E
>
>Convert 'addr' variable to unsigned long, as that is the return type of
>hextoul() and address parameter type of map_sysmem()=2E
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
> cmd/unzip=2Ec | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/cmd/unzip=2Ec b/cmd/unzip=2Ec
>index e7a3f9808b2=2E=2Eb265f43f2ea 100644
>--- a/cmd/unzip=2Ec
>+++ b/cmd/unzip=2Ec
>@@ -50,7 +50,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
> {
> 	struct blk_desc *bdev;
> 	int ret;
>-	unsigned char *addr;
>+	unsigned long addr;
> 	unsigned long length;
> 	unsigned long writebuf =3D 1<<20;
> 	u64 startoffs =3D 0;
>@@ -62,7 +62,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
> 	if (ret < 0)
> 		return CMD_RET_FAILURE;
>=20
>-	addr =3D (unsigned char *)hextoul(argv[3], NULL);
>+	addr =3D hextoul(argv[3], NULL);
> 	length =3D hextoul(argv[4], NULL);
>=20
> 	if (5 < argc) {
>@@ -75,7 +75,7 @@ static int do_gzwrite(struct cmd_tbl *cmdtp, int flag,
> 		}
> 	}
>=20
>-	ret =3D gzwrite(addr, length, bdev, writebuf, startoffs, szexpected);
>+	ret =3D gzwrite(map_sysmem(addr, length), length, bdev, writebuf, start=
offs, szexpected);

unmap_sysmem() seems to be missing here=2E

Best regards

Heinrich

>=20
> 	return ret ? CMD_RET_FAILURE : CMD_RET_SUCCESS;
> }


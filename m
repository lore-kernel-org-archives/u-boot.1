Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D315EC2BA18
	for <u-boot@archiver.kernel.org>; Tue, 18 Jun 2024 17:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47A7388263;
	Tue, 18 Jun 2024 19:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="mSTlwGxe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF1FB882F9; Tue, 18 Jun 2024 19:02:31 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F136D87FFB
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 19:02:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1718730145; x=1719334945; i=xypron.glpk@gmx.de;
 bh=GOsMOZBPME0Cr97Jo27+GuMJ3LrcGs+kY60ZjZBmm4g=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=mSTlwGxeNH1dBvr6Ub8czyBRRZKlmWH7V1siBC3q/+DQ01e0JUAFG+a4/kZH1+mg
 vHQcFpi2uGKt94jAp2B/kiFZoMEB8JSyyH85t84cRMzw6lLuhM66KlEi6JV/r4gi/
 /Q7MrM6yn2frdJHY5+zCuoKzYsjM/rJ1MfBb00eAPlDk/J6hnCrUWuHpOz//oaNev
 XI5BQVrzFmMisiaZe8lSo/Zixu5xldbGHSr51BOksriuA/rBpsFkMtr2jpVDhoacl
 pOmuSJi8FCwfNON1w+cBU5BB9ImP1dAze6zBSMHGk2oeMJK6MGcOMx8+P2o4d1/8p
 x6FoQ3xxobXItoo8XA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([178.202.41.25]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAOJV-1sDFUo2oA7-004gn3; Tue, 18
 Jun 2024 19:02:25 +0200
Date: Tue, 18 Jun 2024 19:02:24 +0200
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
CC: u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: make 'booti -h' not crash the board
User-Agent: K-9 Mail for Android
In-Reply-To: <20240618145213.3284922-1-caleb.connolly@linaro.org>
References: <20240618145213.3284922-1-caleb.connolly@linaro.org>
Message-ID: <A266762D-8A1C-4D1D-8410-B483817A0515@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7pVj+Km4zYuLhFBXwP0pn6ssJ8byTDyG+4kFbHSLwp2vnjOjkD4
 f8i3hZ0Zv1fa1ik4aYEQiLvThqvFFXqpEAoyr6NefFduqBro03vLA3wOV1DysxvlOacISBo
 TCtPl+/3N2TwiGAWAftkM5pc53GtTZ75TTc31ekHAgmoFCUER4fY8Gwqxipcp0fCq86fCwO
 vxUL6QXe3jeTllE5UO1NA==
UI-OutboundReport: notjunk:1;M01:P0:SIfAGZAIPuo=;KFrfIraNqR9l3J9FKcTTwlbb1WW
 mHX2Ultcjqi29MmJwKgs9C9IWbc99AqMUc1NYyr6LntDkJzEP34X64jpO9R5YlDLrDW70v+v4
 qDJhl6lWwI6iLUm6ZmQETG85cmcJZtYcZQaU67gP6QZEBfM0qaVJhVzf0yZCzuna/FZFqq0nO
 +DTIKUPHl/WeMkl7Fgyvdz2qHxCgi9f4WkqsSNSz+bts4CvL/m47U4asKhm7cPH+cTKEO1G6v
 gBe85XO0MzYS3MUci+GSfxCPrmiKRUfhuYDKQQMc/g7VBH/pfLQGSAuSxXcZiKH4Q14zXs4qv
 02owAqXF5SZgjO8rNRO+vgK7eqlbeb8vLg6z34JIg0NIcyHnJ3SBtLF/LtHWIr+w6DJWehsqv
 rSZ7/af2JUE6hCJIJwH2S4ztllsc3/P6PeBln441rcusmzrJitEuaJ9QpAP9/ZF4nLR3ZWeTt
 Dd3mHrjuKZEkeI8ayLPvxiyeQ+pTcWhQ0nNo/v5sMA29Agdznvj3xwqaVFuxN2ZaQcePx3Yy9
 jhdLVJUGomTvH8H1ioEiAWWfZJJEBSaQPyyEwBKRZyc2IpFFVGXac0S/V7SDc4Kf7x1qJ/nq8
 J4IYKBAefYCDbVR44jAX9PYEriqJjTtiH8XgSBmpGf5xELUfitBRKC29C6sgY2ykUDimqBvKo
 R/yl+yFzeCkqAU//KJ/ezdhzZ5lE549KXaROarQfac1V+isDq3JsXWBNmc6sqq9jso/4ZZ2JM
 tF6G1LuBI6wMFIWBuzZfRF4boJK3OW6rCndOx62BiMWgfEmHXJHk6QUy2j4oYGVdzTDEQcoTT
 IEwT7DqG95F5dDG0k0cojB6qd1b09ZAtLQEeyypvHAl0U=
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



Am 18=2E Juni 2024 16:51:56 MESZ schrieb Caleb Connolly <caleb=2Econnolly@=
linaro=2Eorg>:
>Check the result of hextoul() when parsing the first argument to booti,
>and add specific handling for "-h" to print usage rather than causing a
>null pointer exception=2E
>
>Fixes: 5db28905c952 ("cmd: Split 'bootz' and 'booti' out from 'bootm'")
>Signed-off-by: Caleb Connolly <caleb=2Econnolly@linaro=2Eorg>
>---
> cmd/booti=2Ec | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/cmd/booti=2Ec b/cmd/booti=2Ec
>index 62b19e834366=2E=2Ec4029a84e7a7 100644
>--- a/cmd/booti=2Ec
>+++ b/cmd/booti=2Ec
>@@ -31,8 +31,9 @@ static int booti_start(struct bootm_info *bmi)
> 	ulong dest_end;
> 	unsigned long comp_len;
> 	unsigned long decomp_len;
> 	int ctype;
>+	char *endp;
>=20
> 	ret =3D bootm_run_states(bmi, BOOTM_STATE_START);
>=20
> 	/* Setup Linux kernel Image entry point */
>@@ -40,9 +41,14 @@ static int booti_start(struct bootm_info *bmi)
> 		ld =3D image_load_addr;
> 		debug("*  kernel: default image load address =3D 0x%08lx\n",
> 				image_load_addr);
> 	} else {
>-		ld =3D hextoul(bmi->addr_img, NULL);
>+		ld =3D hextoul(bmi->addr_img, &endp);
>+		if (*endp !=3D '\0') {
>+			printf("## Invalid kernel image address: %s\n",
>+			       bmi->addr_img);
>+			return CMD_RET_USAGE;
>+		}
> 		debug("*  kernel: cmdline image address =3D 0x%08lx\n", ld);
> 	}
>=20
> 	temp =3D map_sysmem(ld, 0);
>@@ -108,8 +114,11 @@ int do_booti(struct cmd_tbl *cmdtp, int flag, int ar=
gc, char *const argv[])
>=20
> 	/* Consume 'booti' */
> 	argc--; argv++;
>=20
>+	if (argc && strcmp(argv[0], "-h") =3D=3D 0)
>+		return CMD_RET_USAGE;

We have the help command which works on all commands=2E Please, avoid dupl=
icating this functionality=2E

Best regards

Heinrich


>+
> 	bootm_init(&bmi);
> 	if (argc)
> 		bmi=2Eaddr_img =3D argv[0];
> 	if (argc > 1)

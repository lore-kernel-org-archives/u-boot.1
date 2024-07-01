Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270FEC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 20:33:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C3BC8866B;
	Mon,  1 Jul 2024 22:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="uQ172I7K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59DAC886B5; Mon,  1 Jul 2024 22:33:08 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3272C884EA
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 22:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1719865984; x=1720470784; i=frank-w@public-files.de;
 bh=R1Rc3e+3S1VFBCDI1WuEd2J1dmje4IYw8U6P4u6JLXE=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=uQ172I7Kb4GpRXfy3UrUGAtphYYDtIFZod+5LlMo12KFhDWYvJv4zFDrO4Pwyifl
 bYb9rH0hJ6rJ4GDcSM5YF9x/cB4Qkn67GYNyB8Y3fXU1X5post/yA6QG/K/y8er2n
 yAoA6Ecxz6K/b/8iJ+fcB3kUhdF84caMb5xkJ4L9nc01BUh8I20lApDuPtcKX6TUT
 c2xRMutKqP5VbkPYJdtfN6ujYXfzYOKWRRK0xez2ZXYYAI+PE5/hmJ+++TzKMg/uK
 F/EJx17mnr4su4xiOL8nrgQwYw39hYUb7NUeZpCIisKHTLcV2gNqccq65lUIzkh5L
 fehUe19RTJvQ4PWMeQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.41] ([217.61.148.41]) by web-mail.gmx.net
 (3c-app-gmx-bap25.server.lan [172.19.172.95]) (via HTTP); Mon, 1 Jul 2024
 22:33:04 +0200
MIME-Version: 1.0
Message-ID: <trinity-a3dff4f2-a8c2-4212-9046-e7d70759bdd2-1719865984463@3c-app-gmx-bap25>
From: Frank Wunderlich <frank-w@public-files.de>
To: =?UTF-8?Q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Cc: u-boot@lists.denx.de, Daniel Golle <daniel@makrotopia.org>, John Crispin
 <john@phrozen.org>, "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Subject: Aw: Re:  uboot 2024.07 regression
Content-Type: text/plain; charset=UTF-8
Date: Mon, 1 Jul 2024 22:33:04 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <b4e9d236-f9b3-4fb8-837c-50c971eb56a3@armadeus.com>
References: <trinity-e357a9ad-a974-44b8-9efc-a236a499c673-1718440537556@3c-app-gmx-bap44>
 <trinity-d5e7efbf-06a7-4a02-ab82-c1738850841d-1719756653263@3c-app-gmx-bap39>
 <b4e9d236-f9b3-4fb8-837c-50c971eb56a3@armadeus.com>
Content-Transfer-Encoding: quoted-printable
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:zsyvN0DRGugQFX+Uw0lg4lALTm6CyBiCfX0nGBzEO/0CSDw5fEEUm+t/n3mFKMRbVUxuz
 CC8nH1BHlCe6MF3+X03GhhnrXI0l5zVV2ferckP/zaH2DtFEZQrY+cW2M5/50Kd8VBzDWnsNRlyE
 ayZMriO9FEM32LGNNgCGkBLgL+1rT1+DCTN8rSyItPXqV053ilFxSguf7kK7gXiGcG4zx2g4a88E
 MIXksQBtl6ir9KtqwZd6e5Dv4CHsZTbEXrpNKEICsGmNa8eVPBumCm/6zK1xUhJqANzeibbsIpl3
 SU=
UI-OutboundReport: notjunk:1;M01:P0:6kaR4anph+Y=;sOueALvCDldtA4qDOgAN0t/PMQ/
 k8HqUM//tDxnO0SpArX6muk9ApA+q/2VsJ4Nnffgi0T+QOmL1oz94cb2OJI3jOZIamJSpaHYs
 NHiX2Pz05duSo+/aav67xwHIUXWjFH+NeX7UdpxXWXGu6IRqH/E23It2dCud1GOWTuZcKtHxg
 VvYKmbRxLJS03GDMcDCs5J72GgNlDlr4EgofhwRsv9fspMP/dd9ZPQRrDHAzavSZLzWuiWLv0
 cIuScL2YQcZBvLU0XHCccd+N/zJQKS/pXRLqzY238rhMaRSlXmWyfC+UqUh9TyK73S1D435KG
 64OUEvGRmMbL3EcxwVhfILHGN8X51ROqU6IiilZ7aca/mdxCb2OSqo7JqcFUnPf00e/jbHAjH
 1XbLBJkEgOM/V9wa35N7UtargJVc9/PelFJJ+zaIH5+M4hUhZ03Z6uu1Iua2sDgr7nN6g+/CI
 szZpbWhlwDJm2d4tIkeC/FCyoSydhev3+wnZfnIyk/bxtCkAQUZx8FHhaIfoX/um7/VaLRgDP
 fjXbelRn34OR0te5d4wMaoC7a4gVyD+fJqRLye1Hca2AMCZQj3foxk0OG9gxL2fYd91Rrc0kA
 h65okWNMYX7x9D6OT+Y4FyHx5JONhLnZSikuvWdyzPvUntLA4pv4A3hWqUYtg2Q3yj7lCr+9U
 bwF9C4I9B6DKzdwyEbi570jQbOh/klnhi4ClAP2SZAD3lV65TyG8uHU65g2s9Xo=
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

retested with a newer tree (rc4-based) where i have not reverted the commit=
 and there it works again=2E=2E=2E
seems like it as somehow fixed=2E

sorry for the noise

regards Frank


> Gesendet: Montag, 01=2E Juli 2024 um 10:19 Uhr
> Von: "S=C3=A9bastien Szymanski" <sebastien=2Eszymanski@armadeus=2Ecom>
> An: "Frank Wunderlich" <frank-w@public-files=2Ede>
> Cc: u-boot@lists=2Edenx=2Ede, "Daniel Golle" <daniel@makrotopia=2Eorg>, =
"John Crispin" <john@phrozen=2Eorg>, "Christian Marangi (Ansuel)" <ansuelsm=
th@gmail=2Ecom>
> Betreff: Re: Aw: uboot 2024=2E07 regression
>
> Hello,
>=20
> On 6/30/24 16:10, Frank Wunderlich wrote:
> > Hi,
> >=20
> > any thoughts about this?
>=20
> Do you use an environment file ? If so, can you share it?
>=20
> Regards,
>=20
> >=20
> > Changes do not look like they would cause the ethernet-breakage, but r=
evert confirms=2E=2E=2Ebut i have no idea why this happens (maybe some opti=
mization is triggered)=2E
> >=20
> > regards Frank
> >=20
> >=20
> >> Gesendet: Samstag, 15=2E Juni 2024 um 10:35 Uhr
> >> Von: "Frank Wunderlich" <frank-w@public-files=2Ede>
> >> An: u-boot@lists=2Edenx=2Ede, "S=C3=A9bastien Szymanski" <sebastien=
=2Eszymanski@armadeus=2Ecom>
> >> Cc: "Daniel Golle" <daniel@makrotopia=2Eorg>, "John Crispin" <john@ph=
rozen=2Eorg>, "Christian Marangi (Ansuel)" <ansuelsmth@gmail=2Ecom>
> >> Betreff: uboot 2024=2E07 regression
> >>
> >> Hi,
> >>
> >> while testing clock-patches for mediatek as preparation for OF_upstre=
am i've noticed an issue on
> >> mt7623 based board (bananapi r2) with ethernet (no ping possible) in =
2024=2E07-rc1 where 2024=2E04 is good=2E
> >>
> >> i bisected it to this commit:
> >> ff3bcb17f436 2024-02-23 Makefile: pass -undef option to cmd_gen_envp
> >> and when reverting this commit in 2024=2E07 ethernet works
> >>
> >> it seems not yet reported or reverted (till 2024=2E07-rc4)=2E
> >>
> >> I'm not sure why this commit breaks network on this board, but revert=
 confirms it=2E=2E=2E
> >>
> >> regards Frank
> >>
> >>
>=20
> --=20
> S=C3=A9bastien Szymanski, Armadeus Systems
> Software engineer
>=20
>

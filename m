Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889F3C3DA41
	for <u-boot@archiver.kernel.org>; Thu, 11 Jul 2024 11:23:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAB81886D7;
	Thu, 11 Jul 2024 13:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="K/rw3Arn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C139D886DD; Thu, 11 Jul 2024 13:23:35 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77C4D88667
 for <u-boot@lists.denx.de>; Thu, 11 Jul 2024 13:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1720697012; x=1721301812; i=frank-w@public-files.de;
 bh=aUz93SA6cGrIbEWpJBjacZBtaR/+lA2mAlPZhrwJVqg=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:In-Reply-To:References:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=K/rw3Arnok9KzsF2AHvsQCx+fwHA1j0HXMVUe1DOLfV0GbP3iiFJ40Ar/f9iP+Li
 RxTVvI1vZ3YFG2FPntdx0moLmzgA4NeZA33fFnsyn91XzUvjRDMVMqYBRQxKEkxy4
 Tf2sEARZp08EWObKEB6RP5+qICp5/zfzSgeNCs+QXGEQ8LkJBfB2BQBHmMviK0hIf
 weEfsmr0bMOvudAxoRjYiJv3qYFz88BNjmuUhFAjvk6LiwqSRgogxTmlrlqQrWS6v
 OjI0WB9rkkUbJ6TlbY9BPG2phnokLGNl0kwLOVjySgu/Kb7ScB/DSIDrN5XsqDf15
 iajfhdjn6K3uIQMB6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [80.245.79.157] ([80.245.79.157]) by web-mail.gmx.net
 (3c-app-gmx-bap43.server.lan [172.19.172.113]) (via HTTP); Thu, 11 Jul 2024
 13:23:32 +0200
MIME-Version: 1.0
Message-ID: <trinity-43100c7e-7010-40e5-998f-5fcfe548d29f-1720697012080@3c-app-gmx-bap43>
From: Frank Wunderlich <frank-w@public-files.de>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: Aw: adding fdt-overlay function - help needed
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Jul 2024 13:23:32 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <trinity-a8e5b1d7-ca6f-4148-a618-95cfb529d919-1720625726767@3c-app-gmx-bs04>
References: <trinity-a8e5b1d7-ca6f-4148-a618-95cfb529d919-1720625726767@3c-app-gmx-bs04>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:xoHbjcbfW/a9UhmIRmo0TwoiDdiEHoo+tTq9HAVtFm2rE+x4QMOdNWS4Dn41YnpZPGWGd
 jkmkMbcBW9jp5cAZTJ/Z0aMHH4r0h8zcEE/fz9G0Bb8/Nt+xmzbIsR6jvu06OyVd2x57n2XQAPi6
 WTd/fIsMBq1sZHBwuMRHQmGVQweVK0gfp/B6YnDXC5RxUogprps7iOIMSMImXoi1qjp+d3TP11Xu
 EFkIMclrEghfUJ/ypNSRQrK+UKUjIi9mO9Z/IzsTchXRvnm5XZCR2Ssh8d3HbNnom6EWTJvxTrNC
 RM=
UI-OutboundReport: notjunk:1;M01:P0:OiTGD8vI+pQ=;Q31emYPPto5QLCtt9+E6EIG1fy4
 ikplaoBqX+bIjt+VDFi8wj6H2n5J4Pm3msleDASGHYsdm6Ol1OTL0G/6dgjrhPqNSQm0ro1H3
 tlj7NGOa5APzfdyKX1+mp06toBWk70agQnSvXA84qo+rET3VissfzxDcNfG/rwV8eAwkZf6Hw
 KJiCz94U/axe/RQ+kEB1hpjG78KO2oLuGSNtkxB4uQazW+RT8ypUJPdqtvVa29yXPAPblxtbJ
 GRbaTH9pJ8onQ4F/DeWcZqhvZwM8pSawOdIK6/WYdhLr5Mym7jShbLU9sd6r8q0lgTPKhWiW1
 DMtdLst3F3w2fmWTh4GBrbhm9tprvhwJwlFD15BQmNSXbD/uaf3qexT/OKluZlLa9vdGjnaW/
 4e86k7P3jUD2afAEceTdgXUzNFYzxPxe4fmmeETqydFUxk3E+xJUqOiIww/3YC0Tm60ycN1Vf
 xXBMOM0faQ+c2vq3AkEoRlEgUAJNkjiRTqeExeog7tejYBagrANBvTYnQ//JV2eibX0czpPZf
 xrLvgK4msRZKPUNtPHMwG8q0nnuE1VLcql3SDx96VZVp3NQ0eu+gyVqbHV6f2hIn1d7/6FXQr
 c/+KrrcoODq/rdkKJDV+39CowAJDlKjrDq8EQ5baawgFE5LUnrQQxW+qt1aq3OCb0sXuBzXxb
 IZQgEKeaBgxbYVPZsDCvu6GQXAodCfWbpNy08EL1yA==
Content-Transfer-Encoding: quoted-printable
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

Hi,

i got a bit further and noticed, that required command is not available in=
 uboot...this is normally part of the dtc package [1], so why is it missin=
g in u-boot?
I guess later added or dropped to reduce compile time/make porting easier.=
..

regards Frank

https://github.com/qemu/dtc/blob/master/fdtoverlay.c

> Gesendet: Mittwoch, 10. Juli 2024 um 17:35 Uhr
> Von: "Frank Wunderlich" <frank-w@public-files.de>
> An: u-boot@lists.denx.de, "Tom Rini" <trini@konsulko.com>
> Betreff: adding fdt-overlay function - help needed
>
> Hi,
>
> i try to get overlay-merging working in uboot (for OF_UPSTREAM conversio=
n), but failing on missing Makefile knowledge
>
> i have the state now, that upstream dtso get compiled to dtbo files (tha=
t needed further changes).
>
> now i added this from linux-tree:
>
> #merge CONFIG_DEFAULT_DEVICE_TREE + OF_OVERLAY_LIST_BASEDT to target DTB
> #manual:
> # dtc -I dtb -O dts dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi=
-r3-sd.dtbo
> # fdtoverlay -i dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3.=
dtb -o dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-sd.dtb dts/=
upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-sd.dtbo
> # dtc -I dtb -O dts dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi=
-r3-sd.dtb | less
>
> #currently linux-version
> quiet_cmd_fdtoverlay =3D DTOVL   $@
>       cmd_fdtoverlay =3D $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(re=
al-prereqs)
>
> $(multi-dtb-y): FORCE
> 	$(call if_changed,fdtoverlay)
> $(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)
>
> and created an config-option CONFIG_OF_OVERLAY_LIST_BASEDT which holds a=
 space separated list of the dtbo-files without path, in my test
>
> CONFIG_DEFAULT_DEVICE_TREE=3D"mediatek/mt7986a-bananapi-bpi-r3"
> CONFIG_OF_OVERLAY_LIST_BASEDT=3D"mt7986a-bananapi-bpi-r3-nand.dtbo mt798=
6a-bananapi-bpi-r3-nor.dtbo mt7986a-bananapi-bpi-r3-sd.dtbo"
>
> i now want the list passed to the quiet_cmd_fdtoverlay which should hand=
le each item and add the dtbo to a base-devicetree (like in comments above=
)....
>
> maybe anyone here can help getting this to work?
>
> if my source is needed: https://github.com/frank-w/u-boot/commits/2024-0=
7-bpi-ofupstream-all/
>
> regards Frank
>
>

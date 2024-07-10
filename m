Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0F1C3DA41
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 15:35:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0353C88680;
	Wed, 10 Jul 2024 17:35:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=public-files.de header.i=frank-w@public-files.de header.b="DokO0jyH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14C188709; Wed, 10 Jul 2024 17:35:29 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AED0287EBD
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 17:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=public-files.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frank-w@public-files.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
 s=s31663417; t=1720625726; x=1721230526; i=frank-w@public-files.de;
 bh=HdSQxfB88on1Vy/52Lc5ejSe4EuK9W1Mi8FChWaP1Ek=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
 from:message-id:mime-version:reply-to:subject:to;
 b=DokO0jyHRJcrQnWRcA0LhDvHCiHqoUEHBeNP17Y2nMv/BzhrvS6Tgl5/DYk5Nn7W
 hIRNKlT7CtLkGeqIW79BcyqNonsDENJgZA35Go3lHfaKzLu3blMZ8Rk2g5bxrt777
 zLWIANQlX3fVG6ih6Q4ldVvafVZSS/0IG0vPFIyy9E0D2ae7c5w5ckFC6RZo6SxZV
 K2RnWF/33ZwHsdIR0z9LlPDiQGcN81AgMczmeN7aX4bXv8XE3KntAafierf6U1ITx
 VsTtRAGbwn731YPH2KNGOI3NKySCGhR/fwFep3JRyaxVYw9PXjxMI0QIGhFxgniQR
 BkyM47iak3Ia+BmwtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.158.245] ([217.61.158.245]) by web-mail.gmx.net
 (3c-app-gmx-bs04.server.lan [172.19.170.53]) (via HTTP); Wed, 10 Jul 2024
 17:35:26 +0200
MIME-Version: 1.0
Message-ID: <trinity-a8e5b1d7-ca6f-4148-a618-95cfb529d919-1720625726767@3c-app-gmx-bs04>
From: Frank Wunderlich <frank-w@public-files.de>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Subject: adding fdt-overlay function - help needed
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jul 2024 17:35:26 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:HZRuha/pD30GZ/XS5y+VvF2Qk5xXhW8Kwzs6TfMvmJXWrf/LWltk5cXPZPiHVPOCLCtJS
 hgNd55L7ASH6SqjlLiz+8i14Y3xb0EOjzcVu43df+rxlt/8TTwzKI4U9gVJ6oAtptfTaOOQSq9J1
 wWCbhrke/Yiq76ubG4aI6rABioUYuvb9QOstUxfuYW7X71bthHPOqIg2zhQHOjqboTFtG7KzjwRO
 H/pUh4iGaKyHa+elCjXrzZ+wu+pmTs/f0ZtdwL0qUwUkocd4Oligrs1l4lYesVWD0iSGuXUFuuMT
 Hc=
UI-OutboundReport: notjunk:1;M01:P0:wh9Yk3vAzbs=;25YsN3zT62qP5h1hrqHXa5PCqoy
 JLuGFVWlzyQCIyN9Ji3RnoKbwiW6L4VWb1wMMyiJ/60vhw10WBSQEPAPvTe6PsVjGfR+pSge0
 lt774XD8X+kgyfZfTJgXtW/bbTetAoaVuUh237PK041OoPO6hnGNySaLDr9Vgtjx1u5MYshOU
 yoL/Z5FbanfM7siBaJCohY2sjbho60ZujOR2fVgU63S28VJvYJV/YiJup8k3KTwmm4bQ77Dmd
 qLrlXQrwTaJst01yFI4c4YNkPqTcU7KhHVmqrOppgx3gf1PX2utHZBat8zJV7PuOjbX58XbaW
 9bHx/DOR4FE/zOGdtFm7uSbGpzxgrIu1krS5txqRbFpCGB0pVtljuMUPRETzpo8SKKiH2092O
 nZIzlR9b1pzsjsZLJL1Wvf2alCxT+haBwIKW7ME5xYL2ValBTP0oXXV0ijI3mafolVwFUgk8U
 nEgf6A2RbFBgSWXWoRd6wPwkuBFiVb7Bi/dd2w+GcVhaA7Qv4h+m4JP/7So4Sv8MxVrhb/KeZ
 5Ux10dZg/rkyftHUUtw/YfW+UTFtcNeDYEM6rMSz0NyH8tUTE8NxT6cKTvpxGn+j3AohJrCG/
 HtNlCalnx7ReKqTqaOUdai854ti2agrDTCgdjhqFZDp/BkWY54YedoEaLaG7auGtfat2HQchx
 yjpptEqxeyx3ENyNRhQRohkz8JX2H4KduPbSmrox/A==
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

i try to get overlay-merging working in uboot (for OF_UPSTREAM conversion), but failing on missing Makefile knowledge

i have the state now, that upstream dtso get compiled to dtbo files (that needed further changes).

now i added this from linux-tree:

#merge CONFIG_DEFAULT_DEVICE_TREE + OF_OVERLAY_LIST_BASEDT to target DTB
#manual:
# dtc -I dtb -O dts dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-sd.dtbo
# fdtoverlay -i dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3.dtb -o dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-sd.dtb dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-sd.dtbo
# dtc -I dtb -O dts dts/upstream/src/arm64/mediatek/mt7986a-bananapi-bpi-r3-sd.dtb | less

#currently linux-version
quiet_cmd_fdtoverlay = DTOVL   $@
      cmd_fdtoverlay = $(objtree)/scripts/dtc/fdtoverlay -o $@ -i $(real-prereqs)

$(multi-dtb-y): FORCE
	$(call if_changed,fdtoverlay)
$(call multi_depend, $(multi-dtb-y), .dtb, -dtbs)

and created an config-option CONFIG_OF_OVERLAY_LIST_BASEDT which holds a space separated list of the dtbo-files without path, in my test

CONFIG_DEFAULT_DEVICE_TREE="mediatek/mt7986a-bananapi-bpi-r3"
CONFIG_OF_OVERLAY_LIST_BASEDT="mt7986a-bananapi-bpi-r3-nand.dtbo mt7986a-bananapi-bpi-r3-nor.dtbo mt7986a-bananapi-bpi-r3-sd.dtbo"

i now want the list passed to the quiet_cmd_fdtoverlay which should handle each item and add the dtbo to a base-devicetree (like in comments above)....

maybe anyone here can help getting this to work?

if my source is needed: https://github.com/frank-w/u-boot/commits/2024-07-bpi-ofupstream-all/

regards Frank


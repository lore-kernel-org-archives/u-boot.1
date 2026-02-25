Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094FAEFD204
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 07:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97DD483E13;
	Wed, 25 Feb 2026 08:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Hl7QDuuN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7493D83E36; Wed, 25 Feb 2026 08:52:43 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5DA282A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 08:52:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20260225075235epoutp013772166d876922cd236ef26a63af60b7~XbgdGp0vs2608126081epoutp01V
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 07:52:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20260225075235epoutp013772166d876922cd236ef26a63af60b7~XbgdGp0vs2608126081epoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1772005955;
 bh=AJpvZR22GH1HRYHIwkXRRTT9k0C3+ANlMGW+w/qE5UM=;
 h=From:To:Cc:Subject:Date:References:From;
 b=Hl7QDuuNaL4xbUm5FRWVGe3Hgsyhi243GG9YCf81jciNts+aTZ7KTseBpUfaL3Pt3
 mSV4II6g49Q5QDsugP8L6cwwzXnkT81OaTMb2VFzgcJ36ScKv25bdy4HpYP4JrGdvr
 J36SN+T6jDSDdYYemRJteqViAlZ5+4QgXqS5zd+o=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20260225075235epcas1p1b59c1b156c1e22d47b6711b6dce216f3~Xbgc5adRO1785217852epcas1p1p;
 Wed, 25 Feb 2026 07:52:35 +0000 (GMT)
Received: from epcas1p1.samsung.com (unknown [182.195.38.194]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4fLRdb0h11z3hhT7; Wed, 25 Feb
 2026 07:52:35 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20260225075234epcas1p4b0561d04c012cbe3574755cc475c34fe~Xbgb4PEFa1178811788epcas1p4j;
 Wed, 25 Feb 2026 07:52:34 +0000 (GMT)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20260225075234epsmtip26c1bc02c29caf63012423f35aace77c6~Xbgb2lHGN0084800848epsmtip2p;
 Wed, 25 Feb 2026 07:52:34 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>
Subject: please pull u-boot-samsung master
Date: Wed, 25 Feb 2026 16:52:34 +0900
Message-ID: <32d201dca62b$b3d99d20$1b8cd760$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adyl/NGkGOkDHKevQSiPc6JNg0KzMQ==
Content-Language: ko
X-CMS-MailID: 20260225075234epcas1p4b0561d04c012cbe3574755cc475c34fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260225075234epcas1p4b0561d04c012cbe3574755cc475c34fe
References: <CGME20260225075234epcas1p4b0561d04c012cbe3574755cc475c34fe@epcas1p4.samsung.com>
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

Dear Tom,

The following changes since commit eed514b11d04a2f8a949521ad3bffba3ec98bd2f:

  video: correct label for cyclic video_idle (2026-01-29 10:00:59 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 336dd39b956e5f7e078da1d2b689415a41484067:

  configs: exynos-mobile: add DEFAULT_DEVICE_TREE option (2026-02-25
10:47:03 +0900)

----------------------------------------------------------------
Andrew Goodbody (2):
      video: exynos: node variable should not be unsigned
      video: nexell: unsigned parameter cannot be negative

Kaustabh Chakraborty (19):
      ARM: dts: add dtsi for exynos7870-a2corelte (Samsung Galaxy A2 Core)
      ARM: dts: add dtsi for exynos7870-j6lte (Samsung Galaxy J6)
      ARM: dts: add dtsi for exynos7870-on7xelte (Samsung Galaxy J7 Prime)
      board: samsung: exynos-mobile: simplify parsing RAM banks from device
tree
      board: samsung: exynos-mobile: resolve env vars without board_info
data
      board: samsung: exynos-mobile: disable MULTI_DTB_FIT support
      board: samsung: exynos-mobile: enable OF_BOARD support
      configs: exynos-mobile: remove DEFAULT_DEVICE_TREE and add
OF_UPSTREAM_BUILD_VENDOR
      doc: board: samsung: exynos-mobile: add DEVICE_TREE make flag in build
      doc: board: samsung: exynos-mobile: use u-boot-nodtb.bin for packaging
process
      ARM: dts: exynos7870-a2corelte: add properties to make S-BOOT happy
      ARM: dts: exynos7870-j6lte: add properties to make S-BOOT happy
      ARM: dts: exynos7870-on7xelte: add properties to make S-BOOT happy
      doc: board: samsung: exynos-mobile: remove requirement of stub device
tree
      phy: samsung: add enum for variants based on SoCs
      phy: samsung: add support for exynos7870 USB PHY
      board: samsung: exynos-mobile: use blkmap for booting from userdata
subpartitions
      board: samsung: exynos-mobile: add EFI capsule update support
      configs: exynos-mobile: add DEFAULT_DEVICE_TREE option

 arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi  |  26 +++++++
 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi      |  46 ++++++++++++
 arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi   |  41 +++++++++++
 board/samsung/exynos-mobile/exynos-mobile.c    | 335
+++++++++++++++++++++++++++++++++++++++-------------------------------------
---------
 board/samsung/exynos-mobile/exynos-mobile.env  |   5 ++
 configs/exynos-mobile_defconfig                |  12 +++-
 doc/board/samsung/exynos-mobile.rst            |   5 +-
 doc/board/samsung/exynos-mobile/exynos7870.rst |  42 ++---------
 drivers/phy/phy-exynos-usbdrd.c                | 271
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/video/exynos/exynos_fb.c               |   2 +-
 drivers/video/nexell/soc/s5pxx18_soc_mlc.c     |   2 -
 11 files changed, 549 insertions(+), 238 deletions(-)
 create mode 100644 arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi
 create mode 100644 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi
 create mode 100644 arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi

Thanks,
Minkyu Kang.




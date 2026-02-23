Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594E5E98E13
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 10:38:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBE6A83BC9;
	Mon, 23 Feb 2026 11:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="LgN5s4TY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66B183D0F; Mon, 23 Feb 2026 11:38:03 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A161E83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 11:37:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260223103751epoutp02b7e07063ce090c90da2e8457617b3606~W2eLXFQBr0428904289epoutp024
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 10:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260223103751epoutp02b7e07063ce090c90da2e8457617b3606~W2eLXFQBr0428904289epoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1771843071;
 bh=MEk685Z2kGOEC7pws+0zvWiwm43OGfVBi55zw6jcv3E=;
 h=From:To:Cc:Subject:Date:References:From;
 b=LgN5s4TYHSbCPhTzrglpFaVtmwlTfUTgucGrmm2jyA5JlOs888r2O5XmrXaCMUgF9
 lLSAhkzjkD7A7jDZqJG+Zn6ykNpBGHjq4WRypOkKFBN6LfiFNLT9hmbXYrCiwtjG3z
 r9kt2WmkAlu26JnASIlP2sDPavXmDhF8r7RArsn4=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20260223103751epcas1p19a1da79de413963204fc9d17b5cee97b~W2eKxF0Md2905129051epcas1p12;
 Mon, 23 Feb 2026 10:37:51 +0000 (GMT)
Received: from epcas1p3.samsung.com (unknown [182.195.38.191]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4fKHPB3zqqz6B9mD; Mon, 23 Feb
 2026 10:37:50 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260223103749epcas1p2d9af2576eb9704b70a8572f7ccb8080f~W2eJJQEll1895618956epcas1p2K;
 Mon, 23 Feb 2026 10:37:49 +0000 (GMT)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20260223103749epsmtip2632781059ed99768013b9d9d98a259c9~W2eJHvv3h0345803458epsmtip2a;
 Mon, 23 Feb 2026 10:37:49 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: "'Tom Rini'" <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>
Subject: please pull u-boot-samsung master
Date: Mon, 23 Feb 2026 19:37:49 +0900
Message-ID: <2d9001dca4b0$74a82c10$5df88430$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdyksGa0XFquMb2HS42+DmUa2QkA6g==
Content-Language: ko
X-CMS-MailID: 20260223103749epcas1p2d9af2576eb9704b70a8572f7ccb8080f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260223103749epcas1p2d9af2576eb9704b70a8572f7ccb8080f
References: <CGME20260223103749epcas1p2d9af2576eb9704b70a8572f7ccb8080f@epcas1p2.samsung.com>
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

for you to fetch changes up to 11198fa347390eb449c2a0939f5f00cf510fe285:

  doc: board: samsung: exynos-mobile: remove requirement of stub device tree
(2026-02-23 15:35:33 +0900)

----------------------------------------------------------------
Andrew Goodbody (2):
      video: exynos: node variable should not be unsigned
      video: nexell: unsigned parameter cannot be negative

Kaustabh Chakraborty (14):
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

 arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi  |  26 ++++++++
 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi      |  46 +++++++++++++++
 arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi   |  41 +++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.c    | 276
+++++++++++++++++++++++++++-------------------------------------------------
---------
 configs/exynos-mobile_defconfig                |   5 +-
 doc/board/samsung/exynos-mobile.rst            |   5 +-
 doc/board/samsung/exynos-mobile/exynos7870.rst |  42 ++-----------
 drivers/video/exynos/exynos_fb.c               |   2 +-
 drivers/video/nexell/soc/s5pxx18_soc_mlc.c     |   2 -
 9 files changed, 211 insertions(+), 234 deletions(-)
 create mode 100644 arch/arm/dts/exynos7870-a2corelte-u-boot.dtsi
 create mode 100644 arch/arm/dts/exynos7870-j6lte-u-boot.dtsi
 create mode 100644 arch/arm/dts/exynos7870-on7xelte-u-boot.dtsi

Thanks,
Minkyu Kang.




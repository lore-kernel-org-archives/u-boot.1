Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D70C7C83F26
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 07:31:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 107B383918;
	Fri, 25 Jul 2025 09:31:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="RUPTS/uo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB9098391A; Fri, 25 Jul 2025 09:31:22 +0200 (CEST)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA721838FA
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 09:31:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20250725073113epoutp038141bd4abf068c7fc1a85e60c0f7b74a~Vbha8LqSU0181701817epoutp03I
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 07:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20250725073113epoutp038141bd4abf068c7fc1a85e60c0f7b74a~Vbha8LqSU0181701817epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1753428673;
 bh=FUnkRG7ecySVbabCRq5I6S81IzuqK4y8apZJUksYRZw=;
 h=From:To:Subject:Date:References:From;
 b=RUPTS/uoMVu7xMgJtmAiQtK5+cOKsHwuDyXIUejcDVdXQAVbn2Jk8e252VQuEPREt
 Yv+ziQjqrH5v6KufnjqQmRWQmQx61YkfFukxwgZz/L5Kxx4xKsHG9jsqvnSrlWBdes
 w3FWuLL2hjNLACjs0MENaDgKACYAbHYu8iBQgF5Q=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPS id
 20250725073113epcas1p10dabf283f765b296cb15616f564b4342~VbhaxGP1b0186301863epcas1p1-;
 Fri, 25 Jul 2025 07:31:13 +0000 (GMT)
Received: from epcas1p4.samsung.com (unknown [182.195.38.241]) by
 epsnrtp02.localdomain (Postfix) with ESMTP id 4bpKL84n8Kz2SSKg; Fri, 25 Jul
 2025 07:31:12 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
 20250725073112epcas1p364a18714ffddd807ea6c1fd1b8b373bd~VbhZYRMu93053830538epcas1p3L;
 Fri, 25 Jul 2025 07:31:12 +0000 (GMT)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20250725073112epsmtip14650a9fc310a0d722b4ce22ce0236485~VbhZWWjdD2461524615epsmtip19;
 Fri, 25 Jul 2025 07:31:12 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Please pull u-boot-samsung master
Date: Fri, 25 Jul 2025 16:31:11 +0900
Message-ID: <0c5201dbfd36$189bda10$49d38e30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adv9Nf5+ZcOT4mH5Q3+bsdVDcS0d0Q==
Content-Language: ko
X-CMS-MailID: 20250725073112epcas1p364a18714ffddd807ea6c1fd1b8b373bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
cpgsPolicy: CPGSC10-702,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250725073112epcas1p364a18714ffddd807ea6c1fd1b8b373bd
References: <CGME20250725073112epcas1p364a18714ffddd807ea6c1fd1b8b373bd@epcas1p3.samsung.com>
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

The following changes since commit 3532f1f5edfc97c9dcea723cdeb732eda44bc669:

  block: Remove blk_find_first/next (2025-07-23 17:37:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to f83f2397a1f3ebb3136618332e1549687eb8dd52:

  doc: samsung: Describe flashing process for E850-96 (2025-07-25 10:17:21
+0900)

----------------------------------------------------------------
Sam Protsenko (9):
      phy: samsung: Add Exynos USB DRD PHY driver
      usb: dwc3-generic: Add Exynos850 support
      board: samsung: e850-96: Setup serial# env var
      board: samsung: e850-96: Add dfu_alt_info
      board: samsung: e850-96: Add Android partitions
      configs: e850-96: Increase malloc() pool size
      configs: e850-96: Enable USB gadget and fastboot
      board: samsung: e850-96: Enable EFI Capsule Update mechanism
      doc: samsung: Describe flashing process for E850-96

 MAINTAINERS                       |   1 +
 board/samsung/e850-96/e850-96.c   |  77 ++++++++++++++++++++
 board/samsung/e850-96/e850-96.env |  44 ++++++++++++
 configs/e850-96_defconfig         |  25 ++++++-
 doc/board/samsung/e850-96.rst     |  85 +++++++++++++++++++---
 drivers/phy/Kconfig               |   9 +++
 drivers/phy/Makefile              |   1 +
 drivers/phy/phy-exynos-usbdrd.c   | 386
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
++++++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic.c   |   1 +
 include/configs/e850-96.h         |  21 ++++++
 10 files changed, 637 insertions(+), 13 deletions(-)
 create mode 100644 drivers/phy/phy-exynos-usbdrd.c

Thanks,
Minkyu Kang.



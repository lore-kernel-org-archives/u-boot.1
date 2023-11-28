Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB35C4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 03:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33272875C9;
	Tue, 28 Nov 2023 04:16:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="P1PEk4Vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8EED875E3; Tue, 28 Nov 2023 04:16:16 +0100 (CET)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0297B875C8
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 04:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20231128031608epoutp01c061f8e64df3117407e7ffaa2d79a569~bqw_yE4xq2949029490epoutp01W
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 03:16:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20231128031608epoutp01c061f8e64df3117407e7ffaa2d79a569~bqw_yE4xq2949029490epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1701141368;
 bh=RK4BkGKSYbCZ7U5N5u0ZZqhCApFIGzuCD4SDcegxsrY=;
 h=From:To:Cc:Subject:Date:References:From;
 b=P1PEk4Vq4wnlz1HoXLefAwUjDepOkDZcwRKDcyzEQLYxwUDzJsbkCO83fDzvGudoo
 5KKLjCd9RVXBgtRMnBRb4CRvko6na9lc3BNYHJZOZht65mPBCHI/vr8acg5UMxS66C
 PE5mUXvytynWLZaqNUwFJ75yqaMIs70P1k1jAeUI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTP id
 20231128031607epcas1p4861ae09c6d7be8f7b7734e4b25c4270c~bqw_kIz482625626256epcas1p4U;
 Tue, 28 Nov 2023 03:16:07 +0000 (GMT)
Received: from epsmgec1p1.samsung.com (unknown [182.195.36.223]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SfSK30LCXz4x9Q3; Tue, 28 Nov
 2023 03:16:07 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
 95.8E.08572.67B55656; Tue, 28 Nov 2023 12:16:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20231128031606epcas1p4a03b83245075b91119b523dda9899537~bqw9Q61Pz0471604716epcas1p4P;
 Tue, 28 Nov 2023 03:16:06 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231128031606epsmtrp2a9f4f4f6278396b3b86ef43d591c8f0b~bqw9QRGKm0724107241epsmtrp2C;
 Tue, 28 Nov 2023 03:16:06 +0000 (GMT)
X-AuditID: b6c32a33-cefff7000000217c-19-65655b76f301
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 2A.35.08817.67B55656; Tue, 28 Nov 2023 12:16:06 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip1.samsung.com
 (KnoxPortal) with ESMTPA id
 20231128031606epsmtip10289654174056ea921a81a11a3fa7cfe~bqw9EkWIh0775807758epsmtip1L;
 Tue, 28 Nov 2023 03:16:06 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Cc: <promsoft@gmail.com>
Subject: Please pull u-boot-samsung master
Date: Tue, 28 Nov 2023 12:16:06 +0900
Message-ID: <2c9801da21a9$39c76750$ad5635f0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdohqSAvuDa2Z9vvRyOum4ejaDeyyA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmnm5ZdGqqwfQFNhZTH5xjtJg6aTO7
 xdu9newOzB47Z91l93h1YBW7x9k7OxgDmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CswK9IoTc4tL89L18lJLrAwNDIxMgQoTsjM+v5vPVPCFr+LYyU+sDYzbubsYOTkkBEwkll64
 zNrFyMUhJLCDUeLX53lsEM4nRol/f9+wQzjfGCX6HjUyw7R8uH8Rqmovo8ThBTeZIZznjBLN
 i7exg1SxCWhJ/F14nhXEFhEwkNhycAeYzSwgIdHz4g4TiC0MVPPrwjM2EJtFQFXieeMFxi5G
 Dg5eAUuJnUcyQMK8AoISJ2c+YYFolZfY/nYO1BEKEj+fLoMaryfxYPIBZogaEYnZnW1g90gI
 nGOXWDS9AarBReLX0tOsELawxKvjW9ghbCmJz+/2skE0TGaUmLToGSOEsx7otVkfGCGqjCVu
 rt/ACnIds4CmxPpd+hBhRYmdv+cyQmzmk3j3tQesREKAV6KjTQiiREniwIUDUFMkJGZf3w51
 g4fEhwPbmCcwKs5C8ucsJH/OQvLPLITFCxhZVjGKpRYU56anJhsWGMKjOzk/dxMjOBlqGe9g
 vDz/n94hRiYOxkOMEhzMSiK8eh+TU4V4UxIrq1KL8uOLSnNSiw8xmgIDfiKzlGhyPjAd55XE
 G5pYGpiYGZlYGFsamymJ8ypOmJ0iJJCeWJKanZpakFoE08fEwSnVwLQ+VdDuk+lPvoUKXxWK
 Js0xU/IP39Zd43b9wv8QnbVXZy2sPHubL/ffl/PrFEr8K7dftEtv12Vk3iYzpfadj7nnFLbb
 m/dpBU+0ZZ/+UqHo+pN7PV8eewjPnVmZmRbw6trcO83rA48dqYhfvcMw5/29R+KfdBamaIeK
 c9mpyhodf3XPVXtRUaDDhmKP7U2Hs9KsJyxcX9BY6Mj2oa9g3aFMBZXWXXwWbWvCZu6znHx1
 R+oln83pG5d8Ym7SFfH6ID4zpzb38VVFyU0B2R/THIwX9Smu6JO/uaj4u91i5m5l2+PzVA6X
 aTQ/s+TXXPfcyNSb4fyNxPN2d+Q3bU8P4f/W8JnHp7LjymsZpgl3NyixFGckGmoxFxUnAgCV
 dFy+DwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsWy7bCSnG5ZdGqqQft8SYupD84xWkydtJnd
 4u3eTnYHZo+ds+6ye7w6sIrd4+ydHYwBzFFcNimpOZllqUX6dglcGZ/fzWcq+MJXcezkJ9YG
 xu3cXYycHBICJhIf7l9k62Lk4hAS2M0oce7HAmaIhITEpNkXmLoYOYBsYYnDh4shap4ySpyc
 f5QRpIZNQEvi78LzrCC2iICRROuGTiYQmxmot+fFHTBbGKjm14VnbCA2i4CqxPPGC4wgM3kF
 LCV2HskACfMKCEqcnPmEBSTMLKAn0baREWKKvMT2t3OgrlGQ+Pl0GdQmPYkHkw8wQ9SISMzu
 bGOewCg4C8mkWQiTZiGZNAtJxwJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMHB
 raW1g3HPqg96hxiZOBgPMUpwMCuJ8Op9TE4V4k1JrKxKLcqPLyrNSS0+xCjNwaIkzvvtdW+K
 kEB6YklqdmpqQWoRTJaJg1OqgemYalOCmJfh6Rs77p39f27bbrey2zVSto+YY+flHVJe9tis
 RMHF8P3sjRLyJzIc833t/nEX7UtOM6s52Ljpqr5LVI/aR2f7WQUbW1mOeaulz5eZFNkofG9X
 kri96fKHDlcmzBR+XvYhJ2Mbi9W+/RpHCvZIJtyRvOOU8WPjtZ+HDyc+7V7tm31JU2OW/STm
 A9MW3M/xPZfK0DFZMTt2VxarndVKZd3okFIBNUlZEfs7HR+e62xd3/Hh7kqVbYeTteZJuOoK
 pSWfqFPZuHv77lIt1pRrHPtT+lLjvbpOu4RarA349rEje+pv71JZ5uQT127ypL885/5674eV
 Zwz8sm/VldTPei5rPXsRl9/7CiWW4oxEQy3mouJEAEcJ+ubdAgAA
X-CMS-MailID: 20231128031606epcas1p4a03b83245075b91119b523dda9899537
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231128031606epcas1p4a03b83245075b91119b523dda9899537
References: <CGME20231128031606epcas1p4a03b83245075b91119b523dda9899537@epcas1p4.samsung.com>
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

The following changes since commit 17e9db18f17b6cad278694d4a61df95e96bdf4f5:

  Merge tag 'doc-2024-01-rc3' of
https://source.denx.de/u-boot/custodians/u-boot-efi (2023-11-11 09:22:54
-0500)

are available in the git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 470682ace1e03a6573d6eef9a00b524d608ddfa7:

  configs: Remove unneeded SYS_CONFIG_NAME from a*y17lte defconfigs
(2023-11-27 18:57:35 +0900)

----------------------------------------------------------------
Sam Protsenko (13):
      arm: exynos: Include missing CPU header in soc.c
      arm: exynos: Include missing CPU header in gpio.h
      watchdog: s5p_wdt: Include missing CPU header
      exynos: Avoid duplicate reset_cpu with SYSRESET enabled
      serial: s5p: Fix clk_get_by_index() error code check
      clk: exynos: Add header guard for clk-pll.h
      serial: s5p: Remove common.h inclusion
      serial: s5p: Use livetree API to get "id" property
      serial: s5p: Use named constants for register values
      serial: s5p: Improve coding style
      serial: s5p: Use dev_read_addr_ptr() to get base address
      board: samsung: Fix SYS_CONFIG_NAME configs in axy17lte Kconfig
      configs: Remove unneeded SYS_CONFIG_NAME from a*y17lte defconfigs

 arch/arm/mach-exynos/include/mach/gpio.h |  3 +++
 arch/arm/mach-exynos/soc.c               |  3 +++
 board/samsung/axy17lte/Kconfig           | 14 +++---------
 configs/a3y17lte_defconfig               |  1 -
 configs/a5y17lte_defconfig               |  1 -
 configs/a7y17lte_defconfig               |  1 -
 drivers/clk/exynos/clk-pll.h             |  5 +++++
 drivers/serial/serial_s5p.c              | 79
+++++++++++++++++++++++++++++++++++++-------------------------------
 drivers/watchdog/s5p_wdt.c               |  1 +

Thanks,
Minkyu Kang.




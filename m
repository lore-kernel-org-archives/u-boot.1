Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85DD6C3DA4A
	for <u-boot@archiver.kernel.org>; Thu, 22 Aug 2024 10:20:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7A5688D8B;
	Thu, 22 Aug 2024 12:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="AK9kk5+o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0494B88ABF; Thu, 22 Aug 2024 12:20:19 +0200 (CEST)
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31A1488C7B
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 12:20:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20240822102012epoutp01c39731034e0a09e8fc1aa05afe6be82e~uBbvw3VLH0480204802epoutp017
 for <u-boot@lists.denx.de>; Thu, 22 Aug 2024 10:20:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20240822102012epoutp01c39731034e0a09e8fc1aa05afe6be82e~uBbvw3VLH0480204802epoutp017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724322012;
 bh=TmLa35RDPqqi0PzNUulZS4HeZ+uHO6M74UOlxG4OX7I=;
 h=From:To:Subject:Date:References:From;
 b=AK9kk5+ogkIJk2ye+I9oCPwVU/ovV4JgMekNihzmEFwcZ05un7xJnpfzHc7uPKpJR
 iEyjZlQo2zYppyzPJmddx7UVPiWl2lB6JNXZxCR/Vm2pFHE+w9h5Tq3PEpls8BxQg+
 AHZhxqV/+u2paTxxirwYHMaVVhfXmnMCNT/7CCXA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240822102011epcas1p32021d8da68700a86b4764a89ff9603c0~uBbvmCtUJ1719517195epcas1p3s;
 Thu, 22 Aug 2024 10:20:11 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.38.248]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4WqK2f6Wkwz4x9Pp; Thu, 22 Aug
 2024 10:20:10 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 02.5C.09725.AD017C66; Thu, 22 Aug 2024 19:20:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240822102010epcas1p434e5a447b002e8bdea5423a034c2e444~uBbuUU-L-0782607826epcas1p4m;
 Thu, 22 Aug 2024 10:20:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240822102010epsmtrp2c8cabc103ed69bd7365d88cc630194b7~uBbuTvAo51260112601epsmtrp2R;
 Thu, 22 Aug 2024 10:20:10 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff700000025fd-5b-66c710dac004
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
 10.A2.19367.AD017C66; Thu, 22 Aug 2024 19:20:10 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240822102010epsmtip2e4bfdf096cccf85b74ced27be4c2e668~uBbuHSzaX2809328093epsmtip2H;
 Thu, 22 Aug 2024 10:20:10 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Please pull u-boot-samsung master
Date: Thu, 22 Aug 2024 19:20:10 +0900
Message-ID: <118b01daf47c$de3b9620$9ab2c260$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adr0bAoXu+pUYyUVS8yEzu62YnKdGg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCKsWRmVeSWpSXmKPExsWy7bCmru4tgeNpBr/36FhMnbSZ3eLt3k52
 ByaPVwdWsXucvbODMYApKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE3
 1VbJxSdA1y0zB2i+kkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafArECvODG3uDQv
 XS8vtcTK0MDAyBSoMCE7o23XXKaCwyoVb649YW5gnCHdxcjJISFgInH34jnGLkYuDiGBHYwS
 v55cY4VwPjFKfLpxmg3O2bDtE3MXIwdYy5vdVSDdQgI7gYrWh0DYzxkl2t+B2WwCWhJ/F55n
 BbFFBAwkthzcAWYLA8V/XXjGBmKzCKhKfLn7ih3E5hWwlHh7oYURwhaUODnzCQuIzSwgL7H9
 7RxmiEsVJH4+XQY1U0/i58apjBA1IhKzO9uYQe6UEFjHLvFl3XImiAYXiZ8N51kgbGGJV8e3
 sEPYUhKf3+1lg2iYzCgxadEzRghnPaPE4VkfGCGqjCVurt/ACvIxs4CmxPpd+hDb+CTefe1h
 hQQEr0RHmxBEtZLEgQsHoDolJGZf384KYXtIvP21mwkSQLESyz8uZ5zAKD8LyZ+zkPw5C8k/
 sxAWL2BkWcUollpQnJueWmxYYAyP4OT83E2M4OSmZb6DcdrbD3qHGJk4GA8xSnAwK4nwJt07
 mibEm5JYWZValB9fVJqTWnyI0RQY8hOZpUST84HpNa8k3tDE0sDEzMjEwtjS2ExJnPfMlbJU
 IYH0xJLU7NTUgtQimD4mDk6pBqYrS9i2+8pNe7XM411s1Yzck+uO8T97Pvd+zMl5R313nc2u
 7Dasynap++4XcO6DgEz7okPrNZeulZkumu1Vb63CZPa/7E901xoH3sq0bce3TmacWtVVxH0h
 23a7814XhwXzXsatYm2UO8DMF2iw55YVc722+8TtijzTX6xsM/hps9a98IY/a9MVO62Jy7kX
 7svtMdPe33JwsbN4X162wZUe4wCVjf1XThT5ThR8++Gy0rE9DJPWNDTntncZ/1mUm+hlGrf5
 XD+DZe/ylcwrHh/mjRNaaSAnckZcPN904upFP0X/nFfMuxZbvGnDzN0vTglEvFDc7TPPbhlb
 otv9FbtnH7nIVvT+3IRc7ZcsszuUWIozEg21mIuKEwGGKHSb9wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO4tgeNpBlu/i1tMnbSZ3eLt3k52
 ByaPVwdWsXucvbODMYApissmJTUnsyy1SN8ugSujbddcpoLDKhVvrj1hbmCcId3FyMEhIWAi
 8WZ3VRcjF4eQwHZGiaNrbrF1MXICxSUkJs2+wARRIyxx+HAxRM1TRolXz++xgNSwCWhJ/F14
 nhXEFhEwkmjd0MkEYgsDxX9deAY2h0VAVeLL3VfsIDavgKXE2wstjBC2oMTJmU9YQOYzC+hJ
 tG0ECzMLyEtsfzuHGeIEBYmfT5dBjdeT+LlxKlSNiMTszjbmCYwCs5BMmoUwaRaSSbOQdCxg
 ZFnFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJERyoWkE7GJet/6t3iJGJg/EQowQHs5IIb9K9
 o2lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZVzOlOEBNITS1KzU1MLUotgskwcnFINTMKCAZfU
 U5qf+pTHRv5I+nSkYduX2MCrQg0uq3pU9FeUmaTMN7Fp4H+1dHHzr+pyo6cHFszYP/291Dfh
 v4tu/83xClQx3m201+IS/+N0y73zBMMFTzxI2Pizev3FPOa5GSqH377elsVk8DaG9a7CQR7t
 5dq85dtk9ItPHtjmuqTkdO6D1S45Wb+nXOX/dHybv01PQ0Xvsa+nDrw5UiDB6d7F9kfexV/3
 bsJ13QU/dzAfXdBtsKPJyYO9Qn+1cirH6X9B75Wv8ZSuOcudse0+i/Dvm8/yedpmu50/5KZm
 xZA69eSaC3xZe+WunJgmffnL4RU/pykXiUc5Md0K1D/kqL+Tr+zPSZXW3NuTUqxtkpVYijMS
 DbWYi4oTATfnNanDAgAA
X-CMS-MailID: 20240822102010epcas1p434e5a447b002e8bdea5423a034c2e444
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240822102010epcas1p434e5a447b002e8bdea5423a034c2e444
References: <CGME20240822102010epcas1p434e5a447b002e8bdea5423a034c2e444@epcas1p4.samsung.com>
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

The following changes since commit d51764417dc37ead471a5597f7815ae455e84ea3:

  am335x_hs_evm_spi_defconfig: Add MAINTAINERS entry (2024-08-15 16:07:45
-0600)

are available in the git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 25a972368cf926b4d70c22a2de65d959774d5cc5:

  doc: samsung: Mention enabled eMMC in E850-96 board doc (2024-08-19
16:09:06 +0900)

----------------------------------------------------------------
Sam Protsenko (38):
      mmc: dw_mmc: Remove unused version field from struct dwmci_host
      mmc: dw_mmc: Move struct idmac to dw_mmc.c
      mmc: dw_mmc: Extract waiting for data busy into a separate routine
      mmc: dw_mmc: Extract FIFO init into a separate routine
      mmc: dw_mmc: Extract divider update to a separate function
      mmc: dw_mmc: Extract FIFO data transfer into a separate routine
      mmc: dw_mmc: Extract DMA transfer handling code into a separate
routine
      mmc: dw_mmc: Extract setting the DMA descriptor into a separate
routine
      mmc: dw_mmc: Improve 32-bit IDMAC descriptor namings
      mmc: dw_mmc: Add support for 64-bit IDMAC
      mmc: dw_mmc: Replace fifoth_val property with fifo-depth
      mmc: dw_mmc: Fix kernel-doc comments in dwmmc.h
      mmc: dw_mmc: Improve coding style
      arm: dts: exynos: Add upstream DW MMC properties to all Exynos dts
      dt-bindings: exynos: Update bindings doc for DW MMC controller
      arm: exynos: Add header guard for dwmmc.h
      mmc: exynos_dw_mmc: Fix obtaining the base address of controller
      mmc: exynos_dw_mmc: Fix getting private data in
exynos_dwmci_board_init()
      mmc: exynos_dw_mmc: Don't call pinmux functions on ARM64 chips
      mmc: exynos_dw_mmc: Obtain and use CIU clock via CCF API
      mmc: exynos_dw_mmc: Use .of_to_plat for device tree parsing
      mmc: exynos_dw_mmc: Convert to use livetree API
      mmc: exynos_dw_mmc: Read upstream SDR timing properties
      mmc: exynos_dw_mmc: Abstract CLKSEL register
      mmc: exynos_dw_mmc: Refactor fixed CIU clock divider
      mmc: exynos_dw_mmc: Read common bus-width property
      mmc: exynos_dw_mmc: Read common clock-frequency property
      mmc: exynos_dw_mmc: Move quirks from struct dwmci_host to chip data
      mmc: exynos_dw_mmc: Read and use DDR timing when available
      mmc: exynos_dw_mmc: Set requested freq in get_mmc_clk() callback
      mmc: exynos_dw_mmc: Add support for ARM64 Exynos chips
      mmc: exynos_dw_mmc: Pull all init code into probe function
      mmc: exynos_dw_mmc: Don't call dwmci_setup_cfg() after add_dwmci()
      mmc: exynos_dw_mmc: Use dev->name as driver's displayed name
      mmc: exynos_dw_mmc: Improve coding style
      arm: dts: exynos: Remove outdated DW MMC properties in all Exynos dts
      configs: e850-96: Enable MMC
      doc: samsung: Mention enabled eMMC in E850-96 board doc

 arch/arm/dts/exynos4210-origen.dts         |   3 +-
 arch/arm/dts/exynos4210-trats.dts          |   6 +-
 arch/arm/dts/exynos4210-universal_c210.dts |   6 +-
 arch/arm/dts/exynos4412-odroid.dts         |  15 +-
 arch/arm/dts/exynos4412-trats2.dts         |  20 ++-
 arch/arm/dts/exynos5250-arndale.dts        |  10 +-
 arch/arm/dts/exynos5250-smdk5250.dts       |  13 +-
 arch/arm/dts/exynos5250-snow.dts           |  13 +-
 arch/arm/dts/exynos5250-spring.dts         |   7 +-
 arch/arm/dts/exynos5420-smdk5420.dts       |  13 +-
 arch/arm/dts/exynos5422-odroidxu3.dts      |   4 +-
 arch/arm/dts/exynos54xx.dtsi               |  13 +-
 arch/arm/mach-exynos/include/mach/dwmmc.h  |  40 ++++--
 configs/e850-96_defconfig                  |  10 +-
 doc/board/samsung/e850-96.rst              |   5 +-
 doc/device-tree-bindings/exynos/dwmmc.txt  |  46 ++++---
 drivers/mmc/ca_dw_mmc.c                    |   2 +-
 drivers/mmc/dw_mmc.c                       | 547
+++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 drivers/mmc/exynos_dw_mmc.c                | 357
++++++++++++++++++++++++++++++++---------------
 drivers/mmc/ftsdc010_mci.h                 |   1 -
 drivers/mmc/hi6220_dw_mmc.c                |   7 +-
 drivers/mmc/nexell_dw_mmc.c                |   5 +-
 drivers/mmc/rockchip_dw_mmc.c              |   5 +-
 drivers/mmc/s5p_sdhci.c                    |   2 +-
 drivers/mmc/snps_dw_mmc.c                  |   6 +-
 drivers/mmc/socfpga_dw_mmc.c               |   4 +-
 include/dwmmc.h                            | 242
++++++++++++++++++--------------
 27 files changed, 869 insertions(+), 533 deletions(-)

Thanks,
Minkyu Kang.



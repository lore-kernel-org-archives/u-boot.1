Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29E8C48BC3
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 04:26:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 755EE87F64;
	Tue, 20 Feb 2024 05:26:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="Y0v1nKD8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ACC787F60; Tue, 20 Feb 2024 05:25:59 +0100 (CET)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50A2B87E02
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 05:25:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mk7.kang@samsung.com
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20240220042546epoutp03ba9a75dd95ac510d5ff8b4121ac7335c~1d5w5WSMI1696116961epoutp03L
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 04:25:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20240220042546epoutp03ba9a75dd95ac510d5ff8b4121ac7335c~1d5w5WSMI1696116961epoutp03L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1708403146;
 bh=WmUQ476fPxt6dRe7NOuMjuMFns5kHRvp9SL3rIcJT/o=;
 h=From:To:Subject:Date:References:From;
 b=Y0v1nKD8SYzJfGD/V0fclBfVndq0LL/no94HyhbbhEOaCVcC3O3YolQm4swB+zgvO
 AqFg2jEwBRLy+ZHpCnGL8Q8iIwlOVlSvGFsBd4nISiHtEtZEtSKIz3HVhucSuY2RRc
 puiDiXk510efNJWkNo0JiCQ+ad3UCURiTxgWcJec=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas1p3.samsung.com (KnoxPortal) with ESMTP id
 20240220042546epcas1p360e3bbcbce610b6f1a5a02ba5b95bb69~1d5wvNqPG3206632066epcas1p3k;
 Tue, 20 Feb 2024 04:25:46 +0000 (GMT)
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.38.248]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4Tf5td2jvfz4x9Pp; Tue, 20 Feb
 2024 04:25:45 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 84.5C.19104.8C924D56; Tue, 20 Feb 2024 13:25:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240220042544epcas1p1814450956381663117a9e274d775a952~1d5vQBlrJ0775307753epcas1p1C;
 Tue, 20 Feb 2024 04:25:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240220042544epsmtrp2f8c2823a90cc4797e0c2118b53ae4914~1d5vPfn0X2849728497epsmtrp2G;
 Tue, 20 Feb 2024 04:25:44 +0000 (GMT)
X-AuditID: b6c32a4c-80dff70000004aa0-71-65d429c840d0
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 9A.83.08817.8C924D56; Tue, 20 Feb 2024 13:25:44 +0900 (KST)
Received: from mk7kang01 (unknown [10.88.105.222]) by epsmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240220042544epsmtip2e7d213c1dd784b1d9b7bd1faf21a0c03~1d5vGeO-50798807988epsmtip2t;
 Tue, 20 Feb 2024 04:25:44 +0000 (GMT)
From: "Minkyu Kang" <mk7.kang@samsung.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
Subject: Please pull u-boot-samsung master
Date: Tue, 20 Feb 2024 13:25:44 +0900
Message-ID: <1ec901da63b4$dee1e420$9ca5ac60$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdpjCF7aw2zNsON3TkWIySGFyeVMBQ==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmru5JzSupBlcrLKZO2sxu8XZvJ7sD
 k8erA6vYPc7e2cEYwBSVbZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtq
 q+TiE6DrlpkDNF5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BWoFecmFtcmpeu
 l5daYmVoYGBkClSYkJ2x9PpVxoKLuhVzZ7exNDD+luti5OCQEDCROL+VqYuRi0NIYA+jROPl
 6VDOJ0aJK2u+MUM43xgl9v1cxdbFyAnWsap3JhtEYi+jxOHJ31kgnOeMEk9bv7CDVLEJaEn8
 XXieFcQWETCQODHzFVi3MFD814VnbCC7WQRUJWbflgYJ8wpYSlyfvY0RwhaUODnzCQuIzSwg
 L7H97RxmiMUKEj+fLoMaqSexdPZcJogaEYnZnW1gl0oI7GKXONXVwwTR4CJx+2Q7VLOwxKvj
 W9ghbCmJz+/2skE0TGaUmLToGSOEsx7onVkfGCGqjCVurt/ACnIps4CmxPpd+hDb+CTefe1h
 hQQer0RHmxBEtZLEgQsHoDolJGZf3w5V4iFxdIkjSFhIIFai6cIy5gmM8rOQvDkLyZuzkLwz
 C2HvAkaWVYxSqQXFuempyYYFhrp5qeXwSE7Oz93ECE5xWj47GL+v/6t3iJGJg/EQowQHs5II
 r3vThVQh3pTEyqrUovz4otKc1OJDjKbAsJ/ILCWanA9Msnkl8YYmlgYmZkYmFsaWxmZK4rxn
 rpSlCgmkJ5akZqemFqQWwfQxcXBKNTDVeO7eyn6Wlztnk6XsYq//G7yKFlmYLDx9N83Q0Gzy
 vjVHf6YXXMySOFbc8D7iRM71Va5Mq+uYK2eu2l1uf5f5cuLr5dtPGkxekG7R9i18VrmA4qr4
 eWtqV7cz+UicvTAr5kx1i0tcpMq8OW9tLiVXLOA0LQiOYxL5oOU36c3HvSU9jVJ/1vFk6r3v
 l8zbLNxkvezZ94d5npZfrzq6aMd6hO0KS3ae87SjYWqce5JMzN5pXDIGeXOmT5N69YZ7v/bs
 Wb97gnQ5Tn78PGELd9PZ1dsmKxwVFJ30o9bbZFuaxgn5Sn6TT9fDFjz82OyVdphLwn2Z5Keu
 zjylZs85rx1PN7FMcl0UrTB1fk6dSqwSS3FGoqEWc1FxIgDdLhH2+gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvO4JzSupBhfaNC2mTtrMbvF2bye7
 A5PHqwOr2D3O3tnBGMAUxWWTkpqTWZZapG+XwJWx9PpVxoKLuhVzZ7exNDD+luti5OSQEDCR
 WNU7k62LkYtDSGA3o8T5azPYIBISEpNmX2DqYuQAsoUlDh8uhqh5yijxoPkrI0gNm4CWxN+F
 51lBakQEjCQmvxUFCQsDhX9deMYGEmYRUJWYfVsaJMwrYClxffY2RghbUOLkzCcsICXMAnoS
 bRvBwswC8hLb385hhjhAQeLn02WsILYIUMnS2XOZIGpEJGZ3tjFPYBSYhWTSLIRJs5BMmoWk
 YwEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOBw1dLawbhn1Qe9Q4xMHIyHGCU4
 mJVEeN2bLqQK8aYkVlalFuXHF5XmpBYfYpTmYFES5/32ujdFSCA9sSQ1OzW1ILUIJsvEwSnV
 wOT3euJdzoc3Ag8K78w+vDA9e1dIw9cHLoHfdM+sjTSrd89/OENxi4StOU/5u1rLAhfLPfmt
 8hpWBczXnt1S7z9z5dcK7n5TDdMldzctvxG3sadq7b6V7QfLJ6y6EHMuo9r+8zPtJS9WxXR1
 1U47cmhD2Zt7czcbtW+NMo7XLsxynbf53oEOPkfHbx1FZr1vjk6qPb1DSV92S96p4I/JCzpX
 Trx85HVS/yo9ox2uajtWmjvzZfifX1BbpP/znMTh/24qnp9WxFRlpq/115ewDGXY7HfrRK62
 2Lu/a7/s3/LxycUZ/gqbPjeqHbz89vvRUwJ32y4K783vFteauStFVE+ixj3HaXLDg66A339+
 65opsRRnJBpqMRcVJwIAoR8ZA8YCAAA=
X-CMS-MailID: 20240220042544epcas1p1814450956381663117a9e274d775a952
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240220042544epcas1p1814450956381663117a9e274d775a952
References: <CGME20240220042544epcas1p1814450956381663117a9e274d775a952@epcas1p1.samsung.com>
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

The following changes since commit 15e7927b5a2d33666af19879577bf0c30ab088fe:

  Merge patch series "omap3: Make SPL_OMAP3_ID_NAND depend on
NAND_OMAP_GPMC" (2024-01-22 14:18:55 -0500)

are available in the git repository at:

  git@source.denx.de:u-boot/custodians/u-boot-samsung.git master

for you to fetch changes up to 1e81d12e34e874319e041652198a4ba561d751ab:

  MAINTAINERS: Add new Samsung subsystems (2024-01-24 11:23:20 +0900)

----------------------------------------------------------------
Sam Protsenko (13):
      dt-bindings: soc: samsung: Add Exynos USI
      dt-bindings: soc: samsung: Add Exynos PMU
      dt-bindings: clock: Add Exynos850 clock controller
      soc: samsung: Add Exynos USI driver
      soc: samsung: Add Exynos PMU driver
      clk: exynos: Move pll code into clk-exynos7420
      clk: exynos: Add Samsung clock framework
      clk: exynos: Add Exynos850 clock driver
      pinctrl: exynos: Add pinctrl support for Exynos850
      serial: s5p: Add Exynos850 compatible
      arm: exynos: Add Exynos850 SoC support
      board: samsung: Add support for E850-96 board
      MAINTAINERS: Add new Samsung subsystems

 MAINTAINERS                                                 |   25 +
 arch/arm/dts/Makefile                                       |    1 +
 arch/arm/dts/exynos-pinctrl.h                               |   79 +++
 arch/arm/dts/exynos850-e850-96-u-boot.dtsi                  |   37 ++
 arch/arm/dts/exynos850-e850-96.dts                          |  273
+++++++++
 arch/arm/dts/exynos850-pinctrl.dtsi                         |  663
++++++++++++++++++++++
 arch/arm/dts/exynos850.dtsi                                 |  809
++++++++++++++++++++++++++
 arch/arm/mach-exynos/Kconfig                                |   28 +-
 arch/arm/mach-exynos/mmu-arm64.c                            |   34 ++
 board/samsung/e850-96/Kconfig                               |   16 +
 board/samsung/e850-96/MAINTAINERS                           |    9 +
 board/samsung/e850-96/Makefile                              |    6 +
 board/samsung/e850-96/e850-96.c                             |   22 +
 configs/e850-96_defconfig                                   |   21 +
 doc/board/samsung/e850-96.rst                               |   87 +++
 doc/board/samsung/img/exynos850-boot-architecture.svg       | 1283
++++++++++++++++++++++++++++++++++++++++++
 doc/board/samsung/index.rst                                 |    1 +
 doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml |  307
++++++++++
 doc/device-tree-bindings/soc/samsung/exynos-pmu.yaml        |   85 +++
 doc/device-tree-bindings/soc/samsung/exynos-usi.yaml        |  162 ++++++
 drivers/clk/exynos/Kconfig                                  |    7 +
 drivers/clk/exynos/Makefile                                 |   11 +-
 drivers/clk/exynos/clk-exynos7420.c                         |   25 +-
 drivers/clk/exynos/clk-exynos850.c                          |  189 +++++++
 drivers/clk/exynos/clk-pll.c                                |  167 +++++-
 drivers/clk/exynos/clk-pll.h                                |   16 +-
 drivers/clk/exynos/clk.c                                    |  121 ++++
 drivers/clk/exynos/clk.h                                    |  228 ++++++++
 drivers/pinctrl/exynos/Kconfig                              |    8 +
 drivers/pinctrl/exynos/Makefile                             |    1 +
 drivers/pinctrl/exynos/pinctrl-exynos850.c                  |  125 ++++
 drivers/serial/serial_s5p.c                                 |    1 +
 drivers/soc/Kconfig                                         |    1 +
 drivers/soc/Makefile                                        |    1 +
 drivers/soc/samsung/Kconfig                                 |   33 ++
 drivers/soc/samsung/Makefile                                |    4 +
 drivers/soc/samsung/exynos-pmu.c                            |  102 ++++
 drivers/soc/samsung/exynos-usi.c                            |  208 +++++++
 include/configs/e850-96.h                                   |   12 +
 include/dt-bindings/clock/exynos850.h                       |  337
+++++++++++
 include/dt-bindings/soc/samsung,exynos-usi.h                |   17 +
 41 files changed, 5538 insertions(+), 24 deletions(-)
 create mode 100644 arch/arm/dts/exynos-pinctrl.h
 create mode 100644 arch/arm/dts/exynos850-e850-96-u-boot.dtsi
 create mode 100644 arch/arm/dts/exynos850-e850-96.dts
 create mode 100644 arch/arm/dts/exynos850-pinctrl.dtsi
 create mode 100644 arch/arm/dts/exynos850.dtsi
 create mode 100644 board/samsung/e850-96/Kconfig
 create mode 100644 board/samsung/e850-96/MAINTAINERS
 create mode 100644 board/samsung/e850-96/Makefile
 create mode 100644 board/samsung/e850-96/e850-96.c
 create mode 100644 configs/e850-96_defconfig
 create mode 100644 doc/board/samsung/e850-96.rst
 create mode 100644 doc/board/samsung/img/exynos850-boot-architecture.svg
 create mode 100644
doc/device-tree-bindings/clock/samsung,exynos850-clock.yaml
 create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-pmu.yaml
 create mode 100644 doc/device-tree-bindings/soc/samsung/exynos-usi.yaml
 create mode 100644 drivers/clk/exynos/clk-exynos850.c
 create mode 100644 drivers/clk/exynos/clk.c
 create mode 100644 drivers/clk/exynos/clk.h
 create mode 100644 drivers/pinctrl/exynos/pinctrl-exynos850.c
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-pmu.c
 create mode 100644 drivers/soc/samsung/exynos-usi.c
 create mode 100644 include/configs/e850-96.h
 create mode 100644 include/dt-bindings/clock/exynos850.h
 create mode 100644 include/dt-bindings/soc/samsung,exynos-usi.h

Thanks,
Minkyu Kang.



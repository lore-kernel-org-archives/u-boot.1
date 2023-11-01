Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962C0C4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 11:41:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BB3987C2A;
	Wed,  1 Nov 2023 12:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="AptK/NZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79F43876D3; Wed,  1 Nov 2023 12:40:55 +0100 (CET)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42663876FE
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 12:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231101114041epoutp02f2af55f42f025e904140d88e50c01aa0~TfOzZyjdr2843128431epoutp02X
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 11:40:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231101114041epoutp02f2af55f42f025e904140d88e50c01aa0~TfOzZyjdr2843128431epoutp02X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1698838841;
 bh=YhyujHc8sIO76QIU0amwY3MkTzbaW5ULTZPXV1Mqq7o=;
 h=From:To:Cc:Subject:Date:References:From;
 b=AptK/NZft+KjIDgYireuc5kXciKpJKSksQaY6hqs6/RierprsguzY9FPR8u41DoiE
 qp+o6W655n6LKvGAzOcw6rxWx8gMs3g1/XntaVt1tpRMWWXAyEQi2c6w5T7xCLXRuY
 wqW84GHIa2qiAjq0dmlDSGtkp0Wv4xi8ZBAYjM5M=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTP id
 20231101114040epcas2p12d97dc5ab113e97c0a3c52d353c28662~TfOyz16Ju1527415274epcas2p14;
 Wed,  1 Nov 2023 11:40:40 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.100]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 4SL4nh1R7Pz4x9Q0; Wed,  1 Nov
 2023 11:40:40 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
 6A.6D.09607.83932456; Wed,  1 Nov 2023 20:40:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epcas2p44be11b1fc5e3a93d1527bb86831d0043~TfOyJ-cTT1183611836epcas2p4O;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
 epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20231101114039epsmtrp26fd44e104edb23f07d6b3892c6ad4544~TfOyJX0-x0409304093epsmtrp25;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
X-AuditID: b6c32a48-bcdfd70000002587-14-65423938c3a5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C1.E4.08817.73932456; Wed,  1 Nov 2023 20:40:39 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231101114039epsmtip135e1ecafa731574e0ff6681711b9268a~TfOx5MC0_1771917719epsmtip1c;
 Wed,  1 Nov 2023 11:40:39 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Rick Chen <rick@andestech.com>, Leo
 <ycliang@andestech.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH v3 0/5] Add support for StarFive JH7110 TRNG driver
Date: Wed,  1 Nov 2023 20:40:12 +0900
Message-Id: <20231101114017.1845960-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNKsWRmVeSWpSXmKPExsWy7bCmua6FpVOqwZr9rBaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 VLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtARSgpl
 iTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwC8wK94sTc4tK8dL281BIrQwMDI1OgwoTs
 jBnz2Qt2clVsOfqNrYHxJ3sXIyeHhICJxIdPM1m7GLk4hAR2MEp8enkdyvnEKLFwx2w2COcb
 o8SLW3fZYFpmnb/NApHYyyhxf9IqKGcak8TrdSvBqtgEdCW2PH/FCJIQEbjKKPF+1htmkASz
 gLZE5+cpYNuFBZwlDr59wghiswioSuyYeJwFxOYVcJB4sfk10CAOoHXyEosfSECEBSVOznzC
 AjFGXqJ562xmkPkSAqfYJVZ8nc4CcZ6LxJH3F6FsYYlXx7dAfSol8fndXqiZ5RI7liVB9LYw
 SjS37WGGqLGX+HFzCitIDbOApsT6XfoQ5coSR25BreWT6Dj8lx0izCvR0SYE0agucWA7zAGy
 Et1zPrNClHhIHD1UCRIWEoiVOHr7LOsERvlZSH6ZheSXWQhrFzAyr2IUSy0ozk1PLTYqMIFH
 aXJ+7iZGcCrU8tjBOPvtB71DjEwcjIcYJTiYlUR4D5s6pArxpiRWVqUW5ccXleakFh9iNAUG
 7kRmKdHkfGAyziuJNzSxNDAxMzM0NzI1MFcS573XOjdFSCA9sSQ1OzW1ILUIpo+Jg1OqgSk9
 MuzmOfUbMY1//9iI1C1zZZB/9VLix8KS7TtEBFXvN1Xdcrjz31K2YFvTv17NiZtfPvsmHX1w
 I/PbrMkPf9g2O1d5Z/m+/CwU8F3sgNCbrfElCqcfMR98oZGmZS8tP+noU/1LNuZLbVPF9ytp
 z/c9+UEkKy2qVSxp0dN5F3c+ffyf+cHWa3dFLZe8MvkRmHymeJMXg2S5Qk7Ulol2ITxpzKUC
 KdIVKdkxx5YwyDSwfbX3jmn67sgaWd03U1ZF1+kQi8Zq/xa1dTFOn0sm7bPKjwz/9Tc+f+e7
 HZIfmhd/OHLOecPBJScK2fxzZz/e/aN+X3nws6fzHs7YH7U1gcngSvxmg5qkZKEqjUWm3Uos
 xRmJhlrMRcWJABcu7vkOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnK65pVOqwaoHGhaX92tb3PjVxmrx
 9sVZRot71+Qs3u7tZLc4PPUDo8XjQ6+ZHNg99pyexezx4WOcx51re9g8zt7ZwejRt2UVYwBr
 FJdNSmpOZllqkb5dAlfGjPnsBTu5KrYc/cbWwPiTvYuRk0NCwERi1vnbLF2MXBxCArsZJZYf
 /cwMkZCVePZuB1SRsMT9liOsEEWTmCSWPb7MCJJgE9CV2PL8FSNIQkTgJqPEwjlfWUASzALa
 Ep2fp4B1Cws4Sxx8+wSsgUVAVWLHxONgNbwCDhIvNr9m62LkANogL7H4gQREWFDi5MwnUGPk
 JZq3zmaewMg3C0lqFpLUAkamVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwQGqpbWD
 cc+qD3qHGJk4GA8xSnAwK4nwHjZ1SBXiTUmsrEotyo8vKs1JLT7EKM3BoiTO++11b4qQQHpi
 SWp2ampBahFMlomDU6qBiX+ZtYC0atv9yUdWy636NM2dyV7dfIZd+pQfXEYfZCV5ls5d5PDp
 UeWtrMKzq7JlF9lnfuPa4jjn1+OiU1nvEj65/2t9Y1mWIvy3T31lmYiglsRay6m+95/O/buo
 WuOP3TWHi6r/Ug55HD7u+fFsxd2dhzVNMsIMSp7uFP4RpXvuf+aE/d/L+YzX2922lS1fxNSw
 LdHjmSLn48yP63/vu7Tz3+3MYzGcvSff9nyLrTrbr/zKd6ufS6btrLjJeSwXpl5VVFpypSfe
 kb+ty96TTXqO77pJNxpmpNgHb9DLPN22flHWs3Du6seq298FnFWerZrfdUPGRE+RwdD1wXtm
 yYnPZrMwRh07mfs67IrDAiWW4oxEQy3mouJEAI9S166/AgAA
X-CMS-MailID: 20231101114039epcas2p44be11b1fc5e3a93d1527bb86831d0043
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231101114039epcas2p44be11b1fc5e3a93d1527bb86831d0043
References: <CGME20231101114039epcas2p44be11b1fc5e3a93d1527bb86831d0043@epcas2p4.samsung.com>
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

This patchset adds to support StarFive JH7110 TRNG driver. Due to lack
of readl_relaxed API, the first patch tries to import the
APIs(read/write_relaxed) from Linux kernel's implementation. The second
patch adds the missing security clocks which are required by the trng
IP.

This IP can support 128-bit and 256-bit random number generation but
this patch makes 256-bit default mode for convenience.

Changes from v2:
- Patch #3: Add error handling codes of probe() which are suggested by Jaehoon

Changes from v1:
- Patch #3: Apply Heinrich's reviews and his codes
- Patch #5: Add Heinrich's R-b tag

Chanho Park (5):
  riscv: import read/write_relaxed functions
  clk: starfive: jh7110: Add security clocks
  rng: Add StarFive JH7110 RNG driver
  riscv: dts: jh7110: Add rng device tree node
  configs: visionfive2: Enable JH7110 RNG driver

 arch/riscv/dts/jh7110.dtsi             |  10 +
 arch/riscv/include/asm/io.h            |  45 ++++
 configs/starfive_visionfive2_defconfig |   2 +
 drivers/clk/starfive/clk-jh7110.c      |  10 +
 drivers/rng/Kconfig                    |   6 +
 drivers/rng/Makefile                   |   1 +
 drivers/rng/jh7110_rng.c               | 271 +++++++++++++++++++++++++
 7 files changed, 345 insertions(+)
 create mode 100644 drivers/rng/jh7110_rng.c

-- 
2.39.2


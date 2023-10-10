Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D7ECD690B
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 08:49:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 675E886C67;
	Tue, 10 Oct 2023 10:49:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="vKrfa+pX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EE7D86C9B; Tue, 10 Oct 2023 10:49:51 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E978386489
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 10:49:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chanho61.park@samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20231010084940epoutp0280b614d9c124d814efc36c8e59159803~MstNy06Ts2326023260epoutp02H
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 08:49:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20231010084940epoutp0280b614d9c124d814efc36c8e59159803~MstNy06Ts2326023260epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1696927780;
 bh=dzF6dtZ0UMttrL5GHxu5vScz7nwcygr8gEQ1GjxhANI=;
 h=From:To:Cc:Subject:Date:References:From;
 b=vKrfa+pXWZaydwU4U+pTl66PSO/KzMwm/eJbf7+KKGJc+wE9GFtfncQk53cyHWM18
 ZfBHEi0iPowOyI0KEdWFNGl2j6ib9IPZ1AfgiRhuqusHB+p80DVDI+29UFLE9Nccci
 t9c/Ew9csz6DUYHDBzv8OkFo7fcUngyewfcNP6as=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTP id
 20231010084940epcas2p26ba989f54eba9a1ffa5fa78707aba673~MstNfKNOL2339723397epcas2p2C;
 Tue, 10 Oct 2023 08:49:40 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
 epsnrtp2.localdomain (Postfix) with ESMTP id 4S4V2X01P9z4x9Pw; Tue, 10 Oct
 2023 08:49:40 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
 epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 EC.8C.19471.32015256; Tue, 10 Oct 2023 17:49:39 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
 20231010084939epcas2p1aac03b2cfd5bb395cd4bd6f0faba86fb~MstMifro31422014220epcas2p1T;
 Tue, 10 Oct 2023 08:49:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20231010084939epsmtrp16feb23c58f79e7199042d50d1ca4c829~MstMh6mLN2672826728epsmtrp1N;
 Tue, 10 Oct 2023 08:49:39 +0000 (GMT)
X-AuditID: b6c32a4d-b07ff70000004c0f-97-652510234b39
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 C1.20.08649.32015256; Tue, 10 Oct 2023 17:49:39 +0900 (KST)
Received: from cometzero-ubuntu..
 (75-12-16-202.lightspeed.irvnca.sbcglobal.net [75.12.16.202]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20231010084939epsmtip10d992860617514196a76681a893b6c5e~MstMTnJPn1588315883epsmtip1b;
 Tue, 10 Oct 2023 08:49:39 +0000 (GMT)
From: Chanho Park <chanho61.park@samsung.com>
To: Yanhong Wang <yanhong.wang@starfivetech.com>, Leo
 <ycliang@andestech.com>, u-boot@lists.denx.de
Cc: Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH] configs: visionfive2: enable bootstage configs
Date: Tue, 10 Oct 2023 17:49:18 +0900
Message-Id: <20231010084918.2943894-1-chanho61.park@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmqa6ygGqqwdqvFhaX92tbvN3byW7x
 o+sRo8XjQ6+ZHFg89pyexexx9s4ORo++LasYPW6f5Q1gicq2yUhNTEktUkjNS85PycxLt1Xy
 Do53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAHaqKRQlphTChQKSCwuVtK3synKLy1JVcjI
 Ly6xVUotSMkpMC/QK07MLS7NS9fLSy2xMjQwMDIFKkzIztj04TlbwSXuio6lBxgbGOdydjFy
 ckgImEi8/L+MsYuRi0NIYA+jxN2Wj+wQzidGiV375rNBON8YJfqnXWaCaTm4dh8TRGIvo8St
 3vdQLdOYJF40nWIDqWIT0JXY8vwVI4gtIpAq0XD7I1icWUBbovPzFHYQW1jAXqL1bx8LiM0i
 oCoxa8c/sDivgIPEvUlLmbsYOYC2yUssfiABERaUODnzCQvEGHmJ5q2zmUH2SghsYpc4dXUV
 K8R1LhKzPl2EsoUlXh3fwg5hS0m87G9jh5hZLrFjWRJEbwujRHPbHmaIGnuJHzensILUMAto
 SqzfpQ9Rrixx5BbUWj6JjsN/oabwSnS0CUE0qksc2D6dBcKWleie8xnqAA+JUxdOgNlCArES
 j57sZZrAKD8LyTOzkDwzC2HvAkbmVYxSqQXFuempyUYFhrp5qeXweE3Oz93ECE53Wr47GF+v
 /6t3iJGJg/EQowQHs5II76NMlVQh3pTEyqrUovz4otKc1OJDjKbAEJ7ILCWanA9MuHkl8YYm
 lgYmZmaG5kamBuZK4rz3WuemCAmkJ5akZqemFqQWwfQxcXBKNTBZHFN0FNohyPbk3WnRWSet
 3BZObV7PVWUutHjp41wfJdUiR0mel7z1rGkWkhdWdcZUH1XlsFJT86x7tfHxmeD6QGcJqa+v
 bohu1Dl1X2Nai9DbKuGpK+ZcVWmYF/2aSVjU/FAtq63NVhNVHhfX63wStr6Gvx4s/r7ENqdr
 T2M464w6t+6Pc03C7i2TvF8uqJ646dS9eXof3XbJt84V1n/vpZb/YrpuA/PvzVu8Vnmr3WmK
 /hLzKyNxwsvbn4VePs2uP1Z7wWPxf0WlubPbNxwPvZzy5s/KybHP2CZ5TT6oqP7XjM3p48mJ
 J/xM2y5V6H5mNd+/0bHK/yfnswMJtv9PCf7asSAjNvJDp0fOfkclluKMREMt5qLiRAA0xz0t
 AAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJLMWRmVeSWpSXmKPExsWy7bCSnK6ygGqqwfz1ohaX92tbvN3byW7x
 o+sRo8XjQ6+ZHFg89pyexexx9s4ORo++LasYPW6f5Q1gieKySUnNySxLLdK3S+DK2PThOVvB
 Je6KjqUHGBsY53J2MXJySAiYSBxcu4+pi5GLQ0hgN6NE9/6FLBAJWYln73awQ9jCEvdbjrBC
 FE1iklgzbzErSIJNQFdiy/NXjCC2iEC6xKwbT5hBbGYBbYnOz1PAmoUF7CVa//aBDWURUJWY
 teMfWJxXwEHi3qSlQPUcQAvkJRY/kIAIC0qcnPmEBWKMvETz1tnMExj5ZiFJzUKSWsDItIpR
 MrWgODc9N9mwwDAvtVyvODG3uDQvXS85P3cTIzj0tDR2MN6b/0/vECMTB+MhRgkOZiUR3keZ
 KqlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1nzE4REkhPLEnNTk0tSC2CyTJxcEo1MO19YdHE
 8U80b4V4z2+nvdxfAkPv5M5ZucnN5YLoWafSj9kcbpvmLOYzvFYofUKyc+PzB9c/bK49vi5K
 eqmtSbmw3iXO9T+5Zs94Z3Fd3WDlMpvI+NUTdU5PfjXxgfzUTp8Qpc3hzy9fbMw8/SPosKFH
 x++Q+uOaTDJfZneKtVj6saqJmSbwny6Onhh99Km8+0/5LXxqe5MWO6zzm+F868C1oBktMfsu
 qWZxi4Qes9Da+OZz+OsnTl/vB8QVqqRUsP2aWfCsydHN1uCK8uHJX6e+v9F+j0eXf4vGzomv
 uOpSDFz2pOx4MEnQwaOpw2li0RmR33XNc1Y/uyBw/OHTd/cuFe7sNr1dfvt988u458eUWIoz
 Eg21mIuKEwE1L6gjrAIAAA==
X-CMS-MailID: 20231010084939epcas2p1aac03b2cfd5bb395cd4bd6f0faba86fb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231010084939epcas2p1aac03b2cfd5bb395cd4bd6f0faba86fb
References: <CGME20231010084939epcas2p1aac03b2cfd5bb395cd4bd6f0faba86fb@epcas2p1.samsung.com>
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

Enable BOOTSTAGE configuration and its command for visionfive2 board.
The feature can be useful for analyzing the elapsed time between boot
stages.

TODO: define / reserve memory region for boot stage stash

StarFive # bootstage report
Timer summary in microseconds (10 records):
       Mark    Elapsed  Stage
          0          0  reset
  3,139,338  3,139,338  board_init_f
  3,176,753     37,415  board_init_r
  4,036,111    859,358  eth_common_init
  4,101,599     65,488  eth_initialize
  4,105,799      4,200  main_loop
  4,145,207     39,408  usb_start
  5,440,963  1,295,756  cli_loop

Accumulated time:
                10,093  dm_f
                15,867  dm_r

Signed-off-by: Chanho Park <chanho61.park@samsung.com>
---
 configs/starfive_visionfive2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/starfive_visionfive2_defconfig b/configs/starfive_visionfive2_defconfig
index 6590727fe750..b21754feafce 100644
--- a/configs/starfive_visionfive2_defconfig
+++ b/configs/starfive_visionfive2_defconfig
@@ -31,6 +31,7 @@ CONFIG_RISCV_SMODE=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
 CONFIG_FIT=y
 CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTSTAGE=y
 CONFIG_QSPI_BOOT=y
 CONFIG_SD_BOOT=y
 CONFIG_OF_BOARD_SETUP=y
@@ -72,6 +73,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_TFTPPUT=y
+CONFIG_CMD_BOOTSTAGE=y
 CONFIG_OF_BOARD=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_NOWHERE=y
-- 
2.39.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6667C54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 11:44:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18BB588180;
	Thu, 28 Mar 2024 12:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="bP/j5Mq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8A418812B; Thu, 28 Mar 2024 10:59:17 +0100 (CET)
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B4687E75
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 10:59:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.stelmach@samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20240328095913euoutp025102fd1ace1d2418f2782487d345aa96~A5Udtdr5U0198101981euoutp02i
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:59:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20240328095913euoutp025102fd1ace1d2418f2782487d345aa96~A5Udtdr5U0198101981euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1711619953;
 bh=3NPAbxRHVPX0nCjD9emS1JQuXck9psCvKb59tV9tbU8=;
 h=From:To:Cc:Subject:Date:References:From;
 b=bP/j5Mq+teTZZCVoX58JXUGSR3u5EoNFQSDPpoHh5VYyz2lqgMNrj9WhGwGQatRew
 YnqcjVKYD+nkMHOlLwXyLnaNqu6KTSXG8ewmtl9BjkVuJXFxXVFqzuvmxNjTqGgPCp
 p+wC2695QHmPaPDRcScEfPi5QRn+i+MY950ChX6s=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240328095913eucas1p20222d7919396feb2c5a27cecf8c572c5~A5UdZx2ab1475314753eucas1p2D;
 Thu, 28 Mar 2024 09:59:13 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges3new.samsung.com (EUCPMTA) with SMTP id 20.27.09552.07F35066; Thu, 28
 Mar 2024 09:59:12 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20240328095912eucas1p1f064f0460cf71edcfd82ca1782906a44~A5Uc3lT_s3122331223eucas1p15;
 Thu, 28 Mar 2024 09:59:12 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20240328095912eusmtrp2b615c827327e4241884c64d032b2ba05~A5Uc2Lv9x1104711047eusmtrp2S;
 Thu, 28 Mar 2024 09:59:12 +0000 (GMT)
X-AuditID: cbfec7f5-83dff70000002550-91-66053f70371d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 18.D8.09146.07F35066; Thu, 28
 Mar 2024 09:59:12 +0000 (GMT)
Received: from localhost (unknown [106.120.51.111]) by eusmtip2.samsung.com
 (KnoxPortal) with ESMTPA id
 20240328095912eusmtip26b58b090d4e7b21901c1ac5c5d93dc75~A5UcsuJhP2982929829eusmtip2s;
 Thu, 28 Mar 2024 09:59:12 +0000 (GMT)
From: =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To: u-boot@lists.denx.de, Leo Liang <ycliang@andestech.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Seung-Woo Kim
 <sw0312.kim@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v2] riscv: Move virtio scan to board_late_init()
Date: Thu, 28 Mar 2024 10:58:24 +0100
Message-Id: <20240328095824.1179072-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZduznOd0Ce9Y0gxPLTC1u/Gpjtbh5aAWj
 xdojd9ktZkx+yWbxdm8nu8XjQ6+ZHNg89pyexexx9s4ORo++LasYA5ijuGxSUnMyy1KL9O0S
 uDKuH77IXLCIt2Ji9xKWBsZ7XF2MnBwSAiYS0860MXcxcnEICaxglLi5tB3K+cIocWHCFTYI
 5zOjxK+tPSwwLa1TZ7GB2EICyxklHp/JhbBfMErc7VQDsdkEHCX6l55gBbFFBKwlnm09ywoy
 iFngAKPEwcsfwQYJCzhIbJ64F6yIRUBV4vmmuWA2r4CtxPMzxxm7GDmAlslLLH4gAREWlDg5
 8wlYK7+AlsSaputgNjNQSfPW2WBXSwis5JBoWr+ODaLXRWL5OTeIm4UlXh3fwg5hy0j83zmf
 CaK+nVGi6cpCVghnAqPE544mJogqa4k7536BDWIW0JRYv0sfIuwocWnmDmaI+XwSN94KQtzA
 JzFp23SoMK9ER5sQRLWKxLr+PdBgk5LofbWCEcL2kFi86TvrBEbFWUg+m4Xkm1kIexcwMq9i
 FE8tLc5NTy02zkst1ytOzC0uzUvXS87P3cQITCan/x3/uoNxxauPeocYmTgYDzFKcDArifDu
 PMqSJsSbklhZlVqUH19UmpNafIhRmoNFSZxXNUU+VUggPbEkNTs1tSC1CCbLxMEp1cBkVPPr
 VvytjO1nN8W4iSze9+oWP/v2t2Vbv95Pe54rm3LetyveQ3Xdx5vBkUHRFy5eW1U3O+THPT3h
 /V+1985IkM0TFtzkwKiqd/vNvuPmJ+ruGvgUJRR6RkxhWV1+THSd/kHvs1Genq9fOwa7SJss
 7Ys+nLtyyqUtNickj2TusLI/ONu34N2c2/7LUiJ8azS5J6S3eYuqGHr+tGJ4JfNqaUGr/+d9
 gi9Ln965ctSMJflQRGr1kr/rbztbHI0wtVR/dtmoe2/pJD+frkuM5bahNTULP87b9fKZap+A
 6Z0r6SlXxEUuN7bY9b++4t0RfmGB6ZZ+3vtO51u54t7uVF+S9Dw5dz37FSch2ZhDe4WVWIoz
 Eg21mIuKEwFbgtgxlQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t/xe7oF9qxpBnc2iVnc+NXGanHz0ApG
 i7VH7rJbzJj8ks3i7d5OdovHh14zObB57Dk9i9nj7J0djB59W1YxBjBH6dkU5ZeWpCpk5BeX
 2CpFG1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GVcP3yRuWARb8XE7iUsDYz3
 uLoYOTkkBEwkWqfOYuti5OIQEljKKLF58VqmLkYOoISUxMq56RA1whJ/rnVB1TxjlPhy+gkj
 SIJNwFGif+kJVhBbRMBWYsnOM4wgRcwChxglWs59ZQJJCAs4SGyeuBesiEVAVeL5prlgNi9Q
 w/MzxxkhlslLLH4gAREWlDg58wkLSJhZQF1i/TwhkDC/gJbEmqbrLCA2M1B189bZzBMYBWYh
 6ZiF0DELSdUCRuZVjCKppcW56bnFhnrFibnFpXnpesn5uZsYgbGw7djPzTsY5736qHeIkYmD
 EehwDmYlEd6dR1nShHhTEiurUovy44tKc1KLDzGaAj0wkVlKNDkfGI15JfGGZgamhiZmlgam
 lmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MBvbVNVPkMy8EfbPYVvuicsF1tT13uhYa
 PiivEl6RwmvVPNvhxTN3ScnZ5aJ7b0wJYRfU/BRmNf+sfJK7zevkn0HTa8v0Lnc++SPuXM/t
 /PyM1HXle5FnfyucSEtelc1jej82wPS3NbfvHYv/6z7O+tf44sf/i79LU2R/7zSJk7h7w3zR
 0xCZ73NTcrcX9Rn9PeejcJGBQ8wu4KYDS/7etOa5hm8KjAx+Sv02n91Q/898c1Ea18GLMh+2
 OEn+eF4qLOhwLqZt2VXTz6VOj+eczmre4OKy7PAdEYaK4Hbf3R+zTzvkGcmdn2ai67988v7t
 dfdbd4vkKq1oOGQ2Z5qdiP1iqSOmrJZN9dH18/YrsRRnJBpqMRcVJwIAe95RRQ4DAAA=
X-CMS-MailID: 20240328095912eucas1p1f064f0460cf71edcfd82ca1782906a44
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240328095912eucas1p1f064f0460cf71edcfd82ca1782906a44
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240328095912eucas1p1f064f0460cf71edcfd82ca1782906a44
References: <CGME20240328095912eucas1p1f064f0460cf71edcfd82ca1782906a44@eucas1p1.samsung.com>
X-Mailman-Approved-At: Thu, 28 Mar 2024 12:43:31 +0100
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

When virtio_init() gets called from board_init() PCI isn't ready. Thus,
virtio-over-PCI (e.g. network interfaces) devices can't be detected and
used without additional `virtio scan` scan in the shell or a script.

Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
Changes since v1:
 - remove virtio_init() call from board_init()
 - select BOARD_LATE_INIT for TARGET_QEMU_VIRT

 arch/riscv/Kconfig                      |  1 +
 board/emulation/qemu-riscv/qemu-riscv.c | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ac52c5e6daf..c5c2e8a9c9d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -22,6 +22,7 @@ config TARGET_OPENPITON_RISCV64
 
 config TARGET_QEMU_VIRT
 	bool "Support QEMU Virt Board"
+	select BOARD_LATE_INIT
 
 config TARGET_SIFIVE_UNLEASHED
 	bool "Support SiFive Unleashed Board"
diff --git a/board/emulation/qemu-riscv/qemu-riscv.c b/board/emulation/qemu-riscv/qemu-riscv.c
index 181abbbf97d..173245b40e3 100644
--- a/board/emulation/qemu-riscv/qemu-riscv.c
+++ b/board/emulation/qemu-riscv/qemu-riscv.c
@@ -31,12 +31,6 @@ int is_flash_available(void)
 
 int board_init(void)
 {
-	/*
-	 * Make sure virtio bus is enumerated so that peripherals
-	 * on the virtio bus can be discovered by their drivers
-	 */
-	virtio_init();
-
 	return 0;
 }
 
@@ -46,6 +40,12 @@ int board_late_init(void)
 	if (CONFIG_IS_ENABLED(USB_KEYBOARD))
 		usb_init();
 
+	/*
+	 * Make sure virtio bus is enumerated so that peripherals
+	 * on the virtio bus can be discovered by their drivers
+	 */
+	virtio_init();
+
 	return 0;
 }
 
-- 
2.39.2


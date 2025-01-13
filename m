Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED32E7719E
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 10:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE514805DA;
	Mon, 13 Jan 2025 11:56:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="BiS06T57";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614F5805E7; Mon, 13 Jan 2025 11:56:33 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 by phobos.denx.de (Postfix) with ESMTP id 5DDCB801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 11:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=andyshrk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-ID:MIME-Version; bh=oSMUD
 sefJFLraAg0JSSNamFZ1ntPVM7L80000D2j7/s=; b=BiS06T57zH0V21ofhkKEI
 ajXRzTitwA+bm2UoLLNEyLsT+fcpDJNzYpjTtXDqfQx8sGm2yfQz6LRE08xRhBvn
 GiQdkl2N5dyAjqOEE0ox/oIU5ONTmfKq/C875A2liW+MkTcRQLLY7sKuSgllNFSN
 +I9Ssl9G5Lve0yXkJ9LqpA=
Received: from ProDesk.. (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PygvCgBH+QhS8YRnZeumEg--.46867S2;
 Mon, 13 Jan 2025 18:56:22 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: kever.yang@rock-chips.com
Cc: quentin.schulz@cherry.de, u-boot@lists.denx.de, Andy Yan <andyshrk@163.com>
Subject: [PATCH] doc: coolpi: Fix the defconfig name
Date: Mon, 13 Jan 2025 18:56:13 +0800
Message-ID: <20250113105617.2403788-1-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: PygvCgBH+QhS8YRnZeumEg--.46867S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XrW8tr48tFyfCr4xuFWUtwb_yoWfKrc_Kr
 9xJr48ua1YgrWUGr1kAay3WF1S9anavr1fZr1rXr1UAFy3twnF93Z5GFyqvF98XanrAa1x
 ua1kAr45Gr13KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRGoGQUUUUUU==
X-Originating-IP: [58.22.7.114]
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqQbTXmeE7AJteQAAs7
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

The defconfig name should be: coolpi-cm5-genbook-rk3588_defconfig

Signed-off-by: Andy Yan <andyshrk@163.com>
---

 doc/board/coolpi/genbook_cm5_rk3588.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/board/coolpi/genbook_cm5_rk3588.rst b/doc/board/coolpi/genbook_cm5_rk3588.rst
index cad2a28acbd..26cddac9207 100644
--- a/doc/board/coolpi/genbook_cm5_rk3588.rst
+++ b/doc/board/coolpi/genbook_cm5_rk3588.rst
@@ -28,7 +28,7 @@ Get the TF-A and DDR init (TPL) binaries
    cd u-boot
    export ROCKCHIP_TPL=../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.17.bin
    export BL31=../rkbin/bin/rk35/rk3588_bl31_v1.46.elf
-   make coolpi-genbook-cm5-rk3588_defconfig
+   make coolpi-cm5-genbook-rk3588_defconfig
    make CROSS_COMPILE=aarch64-linux-gnu-
 
 This will build ``u-boot-rockchip.bin`` for eMMC and ``u-boot-rockchip-spi.bin`` for SPI Nor.
-- 
2.43.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3E2C5B549
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 04:29:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F140781E25;
	Fri,  6 Jun 2025 06:29:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="kFy4kNdV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F97482A9E; Fri,  6 Jun 2025 06:29:31 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 353F2807B1
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 06:29:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 06BA7260A0;
 Fri,  6 Jun 2025 06:29:29 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NtawJD3dafy3; Fri,  6 Jun 2025 06:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1749184168; bh=zgQoyVVJLByIBt0/uIdwRvy4VYw8pvb89VB8dVbWMlE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kFy4kNdVCms2CVLfNVurrkJOSFR1PoaVLmSadDxKy/cHiGsNzJX/I17skNMiN1M3D
 5zKcs0vrjGpTNMwC43vxXMOGelYdsa2QqN9UDG8w88U1aWQQyIbiLxrhqz/AWMJk//
 4bWSUaOGkem5tJqYCj38Rt5DDb5/JXRm0z8VAMSUKx5ij7Rce3CTVct9uzBZWPFOYs
 jvkkjqZQn2bPIRaZ2ygBA8yzBXV+9+NlMsxVVrLxMYAnVqd2mgE36SGWdLEB/E++Pr
 nGbxA/8XtVx9I94D1mUCiqW/6tYE5heRUMYPz+xLFXjosuw8ZjDWcEqOt1Tot3jC4v
 QOmNTbYuH0GQQ==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Wei Fu <wefu@redhat.com>, Yixun Lan <dlan@gentoo.org>,
 Yao Zi <ziyao@disroot.org>, Maksim Kiselev <bigunclemax@gmail.com>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>
Subject: [PATCH 4/5] riscv: dts: th1520: Preserve CLINT node for SPL
Date: Fri,  6 Jun 2025 04:28:03 +0000
Message-ID: <20250606042804.64311-5-ziyao@disroot.org>
In-Reply-To: <20250606042804.64311-1-ziyao@disroot.org>
References: <20250606042804.64311-1-ziyao@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Preserve CLINT node for SPL, whose IPI functionality is essential for
operation of a multi-core system.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/th1520.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/dts/th1520.dtsi b/arch/riscv/dts/th1520.dtsi
index 28107a9f354..e773d2e6a80 100644
--- a/arch/riscv/dts/th1520.dtsi
+++ b/arch/riscv/dts/th1520.dtsi
@@ -151,6 +151,7 @@
 		clint: timer@ffdc000000 {
 			compatible = "thead,th1520-clint", "thead,c900-clint";
 			reg = <0xff 0xdc000000 0x0 0x00010000>;
+			bootph-pre-ram;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>,
 					      <&cpu1_intc 3>, <&cpu1_intc 7>,
 					      <&cpu2_intc 3>, <&cpu2_intc 7>,
-- 
2.49.0


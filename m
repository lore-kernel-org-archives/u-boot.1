Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18267C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 07:03:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F2680FDD;
	Tue,  4 Mar 2025 08:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=per1cycle.org header.i=@per1cycle.org header.b="dGPXFlGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CE0880FB6; Tue,  4 Mar 2025 08:03:34 +0100 (CET)
Received: from mail.per1cycle.org (unknown [IPv6:2a01:4f8:c013:8d4e::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68FBF80FB6
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 08:03:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=per1cycle.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@per1cycle.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 1E0BC3F9DB; Tue,  4 Mar 2025 07:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=per1cycle.org;
 s=dkim; t=1741071811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HHWH76euTi+gakDXBJom8f9sJ8BFIh9gcRV+HAgHSZU=;
 b=dGPXFlGsNx0+MIPkfr+VTxWs4MFUZ/dVNZUBLPuZSvLZEjTFe9CXXAbte2AR3M7ZVozRgc
 oXQJtdLTm3a/X7beD6mu6VBmK6z63x+M0N6oiKMBST0XeU7ziMMno0Aq1/39PIVYza3ioX
 5tH2gNlrZHAJU0gyArskyiD0dXBe1ba0jRDZAnTn+LtdJ9wONK/J3uHWCUxDVJcGXQTA/I
 8+xhoY/lChxZfVmKY+bPk+id0ieLEbMvSBngPFnO79w7R0j2giX6ujPUTrppziFa8xD7be
 BqhbTINnybpSzcNhzdDgJX8mkrbrILYZhv4gabmcteW+wdkXdg5Ka8147Lm9Pg==
From: Huan Zhou <me@per1cycle.org>
Subject: [PATCH 0/4] Add k1 reset driver for bananapi-bpif3 platform.
Date: Tue, 04 Mar 2025 15:03:26 +0800
Message-Id: <20250304-reset-k1-v1-0-dc9510ff1113@per1cycle.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL6lxmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDI0NT3aLU4tQS3WxDXXOTVHNzs2QLy1QjCyWg8oKi1LTMCrBR0bG1tQB
 ldLL+WgAAAA==
X-Change-ID: 20250215-reset-k1-74e776c89e28
To: u-boot <u-boot@lists.denx.de>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Tom Rini <trini@konsulko.com>, Yixun Lan <dlan@gentoo.org>, 
 Huan Zhou <me@per1cycle.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741071809; l=1053;
 i=me@per1cycle.org; s=20241231; h=from:subject:message-id;
 bh=BIl2p1KNdeSOtGDqdoVc5y+8EaFBNFj3PT7c9br3lTI=;
 b=AuT8zgei9w5enLpcLTKkXkRNuLUL7cmMM7p4ABR344VNlbHvbL/MrdmtaM2DlRjF8NkFd11lb
 i1MpHtiU2ivC3vdkIB3Ym065LY2ML5NWqxfk9YlAcMgEbG5cggXQGgF
X-Developer-Key: i=me@per1cycle.org; a=ed25519;
 pk=LfN2kXe1uCRoaEzAJ8quXuPIH4MiEnZHOCRZwGytJwE=
X-Last-TLS-Session-Version: TLSv1.3
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

Add device tree bindings and basic reset controller driver for the
BananaPi F3 board.This initial implementation supports the core reset 
functionality.

Signed-off-by: Huan Zhou <me@per1cycle.org>
---
Huan Zhou (4):
      riscv: dt-binding: k1: Add reset driver binding definition.
      riscv: reset: k1: Add reset driver
      riscv: dts: k1: add reset controller node in device tree
      Add reset config options for k1

 arch/riscv/cpu/k1/Kconfig                     |   1 +
 arch/riscv/dts/k1.dtsi                        |  15 +
 configs/bananapi-f3_defconfig                 |   1 +
 drivers/reset/Kconfig                         |   7 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-spacemit-k1.c             | 438 ++++++++++++++++++++++++++
 include/dt-bindings/reset/spacemit-k1-reset.h | 118 +++++++
 7 files changed, 581 insertions(+)
---
base-commit: cf6354ab23bfc3337b1087d243e6be4af48abe84
change-id: 20250215-reset-k1-74e776c89e28

Best regards,
-- 
Huan Zhou <me@per1cycle.org>


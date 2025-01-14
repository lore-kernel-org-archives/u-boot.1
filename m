Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26ACFE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 17:26:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44B2E8022E;
	Tue, 14 Jan 2025 18:26:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="lGtVhp4y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 738568060C; Tue, 14 Jan 2025 17:47:10 +0100 (CET)
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 646B48007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 17:47:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=junhui.liu@pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1736873221; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=DnqhZ1DgAYddKgF44eiNpFY/TLVwnvKqUAy/7sBvOVryZNx7JTwqaAe7OndFvPN2Ak3dwobA4KVdPnPVu7hRVVae/X6+NkD644qG8dwDo52enECvWZ+F4UId46g1kPgFH1ad8fEOVTSiT0EXTHdFfJ3X6RPX2swItdHzpfzqB3Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1736873221;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=Bpwno5cK5LP2oSZv1t/A2YzjCuM/wBFlQ6xtlFWrroI=; 
 b=EMSonVz3dIrTw0kbpmfRu66O5pPM3FgIjN0XAVK0X5wrD6uC26Eyj3VH0tG/j4SBtBqyueJnOIfp/8IIwMwuUvz3cvneJbwdM/nU0QZ8M/pERX5zBnD8fi2TuLNZjT1MSLKW+0k+6RHAV7SuPl2+qTe33tJxjK7kp2Hqt4JRJYE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=pigmoral.tech;
 spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
 dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1736873221; 
 s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
 bh=Bpwno5cK5LP2oSZv1t/A2YzjCuM/wBFlQ6xtlFWrroI=;
 b=lGtVhp4yRpqjLf9blyhlxrYO1C2DGvw34PULEpmHNPbW885/EQmGycxpmo39dZsT
 RJfZGRbR3gA2C2YxhwuXuz2djT9xB4TqvWd4GCBnhrAvfWVMRkXi6RSBvDzJhcNUi2o
 JgnBBXQjA8WE/2qpMb6j8hqsWQ9U+fz2BSIbqQAk=
Received: by mx.zohomail.com with SMTPS id 1736873220054328.8491266038652;
 Tue, 14 Jan 2025 08:47:00 -0800 (PST)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/5] riscv: canaan: Add support for K230-CanMV board
Date: Wed, 15 Jan 2025 00:46:36 +0800
Message-Id: <20250115-k230-dev-1-v1-0-f4b77259e34a@pigmoral.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO2UhmcC/z3Myw6CMBCF4Vchs3ZMLyBIjPE9DIvSTqFRLraIJ
 oR3t4HE5X+S8y0QyDsKUCYLeJpdcEMfgx8S0K3qG0JnYoNgImOcM3wIydDQjBwzaeuc6YykzCE
 eRk/WfTfsXu3t6fWO5rSP0FEIajPL5PInzUeLjZxTZHgucptac7JFLW6ja7rBq+dxIt1eoVrXH
 5jY0F2yAAAA
X-Change-ID: 20250110-k230-dev-1-53fb70c5e337
To: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Junhui Liu <junhui.liu@pigmoral.tech>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736873211; l=2535;
 i=junhui.liu@pigmoral.tech; s=20250109; h=from:subject:message-id;
 bh=qxRHxgo3rFbhhLM8SaOMzIoOdx/kUQO6Dkce7Fp2hPA=;
 b=YTQnYGb5QJLZy00S3aOn6MS6uT3Ro/uDqTcsjXXOKTqJe4vKj/MgNhNhx6Ib+k1+2BxiJahnI
 AybCHP1mUfQDw8XOrBktPfXuTkEnxIIbgfMKW431lsvyDzVCxQ+OR3G
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=68KnSr7PNU3x0/qPdqkmlkr3EChzKC0ewuARfy9ZNnc=
X-ZohoMailClient: External
X-Mailman-Approved-At: Tue, 14 Jan 2025 18:26:11 +0100
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

K230-CanMV [1] is a RISC-V development board with K230 SoC [2] from the
Kendryte series by Canaan Technology.

This patch series add initial support for u-boot on K230-CanMV and it can
boot via vendor's u-boot-spl and boot into Linux via tftp through the
onboard RTL8152 [3].

[1] https://developer.canaan-creative.com/k230/en/dev/CanMV_K230_Tutorial.html
[2] https://developer.canaan-creative.com/proDetail/230
[3] https://gist.github.com/Judehahh/c0ed94de3a0aeada2e2f1bc3a397fa2d

---
Junhui Liu (5):
      usb: dwc2: Add support for Canaan K230
      riscv: dts: canaan: Add basic device tree for K230 CanMV board
      riscv: cpu: k230: Add support for Canaan Kendryte K230 SoC
      riscv: canaan: k230_canmv: Add initial support
      doc: canaan: Add K230 CanMV board

 arch/riscv/Kconfig                    |   5 +
 arch/riscv/cpu/k230/Kconfig           |  14 +++
 arch/riscv/cpu/k230/Makefile          |   6 ++
 arch/riscv/cpu/k230/cpu.c             |   9 ++
 arch/riscv/cpu/k230/dram.c            |  21 ++++
 arch/riscv/dts/Makefile               |   1 +
 arch/riscv/dts/k230-canmv.dts         |  31 ++++++
 arch/riscv/dts/k230-u-boot.dtsi       |  25 +++++
 arch/riscv/dts/k230.dtsi              | 175 ++++++++++++++++++++++++++++++++++
 board/canaan/k230_canmv/Kconfig       |  19 ++++
 board/canaan/k230_canmv/MAINTAINERS   |   6 ++
 board/canaan/k230_canmv/Makefile      |   5 +
 board/canaan/k230_canmv/board.c       |   9 ++
 configs/k230_canmv_defconfig          |  19 ++++
 doc/board/canaan/index.rst            |   8 ++
 doc/board/canaan/k230_canmv.rst       |  88 +++++++++++++++++
 doc/board/index.rst                   |   1 +
 doc/device-tree-bindings/usb/dwc2.txt |   1 +
 18 files changed, 443 insertions(+)
---
base-commit: 6a0db9ee030f634731b792d864fc7a9df6cc6b80
change-id: 20250110-k230-dev-1-53fb70c5e337
prerequisite-message-id: <20250110-dwc2-dev-v4-0-987f4fd6f8b2@pigmoral.tech>
prerequisite-patch-id: f05fe7f02791b8f5f6e89e3768584622c49e2ed7
prerequisite-patch-id: ba89fc49fb08beb94bc5c69c4b82e198a27c334d
prerequisite-patch-id: bc3632796d0010d5711be9597c4222c23adbf9f7
prerequisite-patch-id: b30e9c649999f42bc5c659bde5650e8aa2a33acd
prerequisite-patch-id: d6623dbacae347c4c7e339a294c60402667a359b
prerequisite-patch-id: 64e64d31939ea7f69818883fbafb8c1906b53ecb
prerequisite-patch-id: 9de6c80cd2996924b8f94a33f3e2a3dd63f1f57b
prerequisite-patch-id: e1752a8f249752de133bda41a387b3d147d60453

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49B17C55ABF
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 13:05:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11AF960809;
	Thu,  6 Aug 2026 13:05:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMxlTdBSO6Xk; Thu,  6 Aug 2026 13:05:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29E5F60803
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786021503;
	bh=MQ+T8Qlyzy519WVcbmZzgdMbYUT/wnlFSlXzXMThW34=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=oLOzwPkiJW7WbECQxUteyU9zBofthZOLreO4XGXIuEeMSQVHQhfF8U1igPtYYazcY
	 Vz3Pdhmleu0iA+leThh0mXCNGO0TMpxjcld5/Ivizin97N45fDasn/y54a4q+fuD1J
	 u5lZu6iFM26YT53g6lL9U8Z6/sU5ApEqFXycrwC+hz+r5HZCy3NNAW9DlB+zeZieEZ
	 0k/NMHRpUL3pAX6N7+Rkun2MYQ1KzpQkBmez+Dr1dWte+fCqySyqrb4K0niLx1+N1K
	 sN8lYw7qaamrsDB7bbogCTJVmaOAZQUSPhjHbJh/8amDmaXhZlOmX5tdBq29yfHysx
	 JN5e5EdvqNBhQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29E5F60803;
	Thu,  6 Aug 2026 13:05:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 43F53194
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3581C60624
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:14:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8QlEcOgeJIlT for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 12:14:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 3021C60600
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3021C60600
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3021C60600
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 12:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1786018421; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PyqWVBebvvyqWczfR6kfJg7580WRtH4NIVA3qO1445s6UUCh1Sb/3kDRSuec/xMS3M5LiTzz6Bv799nzy8bXKYLg0SGKr8qV08bOBdusHcrIzpFtjQnegKgPfMAAJ16QzMvZUvwIjAVOvesBsYdvnIeHqCSuzsCA43ZR1wdSdgY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1786018421;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=MQ+T8Qlyzy519WVcbmZzgdMbYUT/wnlFSlXzXMThW34=; 
 b=W7vKep75xtD7kSyjWax822m9JBojcTM1Gu8y69OO0sEL/02H9iPL+3sQlg+UDUlBwJyGQLDq4s6HhXRQ2SZ8O9axEjbSMipM96zNlNJ723PYy7NNfWl86aux0IrJqDt6vlwQkxtuLm+aCjky8cs4g8szKZIeXMwe9hgJY9oqkYM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1786018417892451.73255306578255;
 Thu, 6 Aug 2026 05:13:37 -0700 (PDT)
Subject: [PATCH v3 0/7] riscv: sophgo: Use upstream devicetrees for CV18xx
 boards
Date: Thu, 06 Aug 2026 20:13:20 +0800
Message-Id: <20260806-milkv-duo-upstream-dts-v3-0-917cf70a2337@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OUQuCMBRG/4rs2cU2p7Oe+h/Rw9yuuUonm45K/
 O+pEYQg9Hjgu+fcAXlwBjw6RANyEIw3tpkgiSOkKtlcABs9MWKEZUQQhmtzvwWse4v71ncOZI1
 153GRcgma01JlFE3HrYPSPBbx6fxh3xdXUN1smxeV8Z11z6Uc6Lz7RrKtSKCY4FwTSrTWUih5f
 NnK1tLcd8rWaO4E9mNiYtPEJhMroRAyYWq/NsXRf4aU8jwreMr3Sqx+GcfxDUCBqo9dAQAA
X-Change-ID: 20260702-milkv-duo-upstream-dts-b54aed41fc61
To: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Zhuxu Ran <zhuxu_ran@zohomail.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Hiago De Franco <hfranco@baylibre.com>, 
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>, 
 Kongyang Liu <seashell11234455@gmail.com>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 Guodong Xu <guodong@riscstar.com>, Andreas Schwab <schwab@suse.de>, 
 Junhui Liu <junhui.liu@pigmoral.tech>
X-Mailer: b4 0.15.2
Feedback-ID: zu080112276c5d4155206836ae4843507b0000491043535a23daed673c9fe8a558df0f149f6e010cf88fb908:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Thu, 06 Aug 2026 13:05:01 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1786018421; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=MQ+T8Qlyzy519WVcbmZzgdMbYUT/wnlFSlXzXMThW34=;
 b=LMhRulG+GxPyvW6yMjSWPUajIl3/jWtd34e2R8qRLaZQekl25ZMTtlFV8hf8wINe
 5AlRhkpNXD6tzFa4I4e1U0AQEzM2b2V+r6wD2yf07SLpChJYbsG+UDoTAKV1Pl+IAYN
 htEQXWDtqj2RD/zR1iUjmJr5i6iMK33S/h4XTfXg=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=LMhRulG+
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Zhuxu Ran via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Zhuxu Ran <zhuxu_ran@zohomail.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Switch Milk-V Duo and LicheeRV Nano to the upstream CV1800B and
SG2002 devicetrees.

Add the SoC-specific clock compatible strings used by the upstream
devicetrees, and extend the existing SDHCI driver to support SG2002.
Enable hardware system reset on LicheeRV Nano. Keep Ethernet and SPI NOR
support enabled for Milk-V Duo through U-Boot-specific overrides.

Remove the unused local CV18xx devicetrees and the legacy
"sophgo,cv1800-clk" compatible string from the clock driver.

Tested on Milk-V Duo:
- U-Boot boots using the upstream control FDT
- serial console works
- MMC is detected and can read the SD card
- Ethernet is probed and DHCP/TFTP work
- SPI NOR is detected
- Linux boots via TFTP with Image, initramfs and DTB

Tested on Sipeed LicheeRV Nano B:
- U-Boot boots using the upstream control FDT
- serial console works
- MMC is detected and usable
- hardware system reset works

Build-tested with the riscv64-linux-gnu cross compiler:
- milkv_duo_defconfig
- sipeed_licheerv_nano_defconfig

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
Changes in v3:
- Restore the CV1800B SPIF node in the Milk-V Duo U-Boot override
- Link to v2: https://patch.msgid.link/20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com

Changes in v2:
- Expand the upstream devicetree conversion to LicheeRV Nano
- Add SG2002 clock and MMC compatible strings
- Enable hardware system reset on LicheeRV Nano
- Remove the legacy clock compatible string after converting all users
- Move the Milk-V Duo Ethernet description above the gmac0 node
- Link to v1: https://patch.msgid.link/20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com

To: u-boot@lists.u-boot-project.org
To: Yao Zi <me@ziyao.cc>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Tom Rini <trini@konsulko.com>
Cc: Zhuxu Ran <zhuxu_ran@zohomail.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Hiago De Franco <hfranco@baylibre.com>
Cc: Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Cc: Kongyang Liu <seashell11234455@gmail.com>
Cc: Tim Ouyang <tim609@andestech.com>
Cc: Leo Liang <leo.liang@sifive.com>
Cc: Andreas Schwab <schwab@suse.de>
Cc: Guodong Xu <guodong@riscstar.com>
Cc: Stefan Roese <stefan.roese@mailbox.org>

---
Zhuxu Ran (7):
      clk: sophgo: cv1800b: Add SoC-specific compatible strings
      mmc: cv1800b: Add SG2002 compatible string
      riscv: licheerv_nano: Enable hardware system reset
      riscv: milkv_duo: Use upstream devicetree
      riscv: licheerv_nano: Use upstream devicetree
      riscv: dts: sophgo: Drop local CV18xx devicetrees
      clk: sophgo: cv1800b: Drop legacy compatible string

 arch/riscv/dts/Makefile                      |   2 -
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi |  36 +++++
 arch/riscv/dts/cv1800b-milkv-duo.dts         |  64 --------
 arch/riscv/dts/cv1800b.dtsi                  |  22 ---
 arch/riscv/dts/cv18xx.dtsi                   | 232 ---------------------------
 arch/riscv/dts/sg2002-licheerv-nano-b.dts    |  45 ------
 arch/riscv/dts/sg2002.dtsi                   |  34 ----
 board/sophgo/licheerv_nano/board.c           |   9 ++
 board/sophgo/milkv_duo/MAINTAINERS           |   1 +
 configs/milkv_duo_defconfig                  |   3 +-
 configs/sipeed_licheerv_nano_defconfig       |   4 +-
 drivers/clk/sophgo/clk-cv1800b.c             |   3 +-
 drivers/mmc/cv1800b_sdhci.c                  |   1 +
 13 files changed, 53 insertions(+), 403 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61

Best regards,
--  
Zhuxu Ran <zhuxu_ran@zohomail.com>


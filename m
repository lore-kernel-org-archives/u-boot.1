Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FD2C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0D9680C49;
	Mon, 27 Jul 2026 09:09:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6Cvpm5g7Hpzy; Mon, 27 Jul 2026 09:09:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D749C80C36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143378;
	bh=F7lTtbr+WypNcRqUDLPM9JwVH5Pbn9snDt6A/rAL+yY=;
	h=Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=e49BgD79aTs4E/DHRhJBgbE2ALJVTUR+YWh2r/ZhFyYLftc3KLj4FnTgPx0tKpvKr
	 8xfX5cl3In7C8OOjGW20XiEFdKik19vLVesKx2aK1vdZBLbZlnW5rCGHCUPDuk1FYR
	 2/7DCbEl18IStIMSBFM7r4BHQ63zXQr4epnA95FnWyKf4Vl/haWcoD83LeivR1T4Jt
	 nOauRDBCO3drKApJHnVrujWPmdFGlEwSCcKFaTBsvBnkaSEVhsyssUGfctPF2/YFLf
	 gTAT5UnsRSpP5nvi1TzUDCFOkJBbzHrS+2kkhAPPZmI7m8E/bm98LFmewq3erTZLmT
	 H8Q7iNuCPQcmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D749C80C36;
	Mon, 27 Jul 2026 09:09:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04F51490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E263A80C93
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KYujDsxROCGI for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 07:08:32 +0000 (UTC)
X-Greylist: delayed 904 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 27 Jul 2026 07:08:31 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org EBD3780C88
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EBD3780C88
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.94;
 helo=sender4-pp-o94.zoho.com; envelope-from=zhuxu_ran@zohomail.com;
 receiver=<UNKNOWN> 
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com
 [136.143.188.94])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EBD3780C88
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 07:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785135171; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=BvZS7DNkkDUQF+5QjoNwNfEgvyVQ2sWRWQUvDPmUuxQSEWL1IDn/FYWqj7UQpkvID5t1hiIYNd2XqCxXoLziOpCvVP4x+K1De1MSyk9b5lshIrXxkJuUhqFrB9+1LNJZpwQ0WKtVyORd8s3LErIgUa1gOcjT10/C1uqEFzbiMnA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785135171;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=F7lTtbr+WypNcRqUDLPM9JwVH5Pbn9snDt6A/rAL+yY=; 
 b=Uc883xdPL3flkafi/nniC5NoWRdum9MS5rxxLTZ1MqSrRRGXx1bMMu+mc3FigGDT+zLKcfwB2L+G/YN8GBPgZpYsdM1jq5duY0e7wOOPA/a4uaiz8KgNCYThuw2Qigh0891G1nuba/SjyNsX7zDxp4OqSu19wgfOXRmQ3y839A8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=zohomail.com;
 spf=pass  smtp.mailfrom=zhuxu_ran@zohomail.com;
 dmarc=pass header.from=<zhuxu_ran@zohomail.com>
Received: by mx.zohomail.com with SMTPS id 1785135168532987.5686789871074;
 Sun, 26 Jul 2026 23:52:48 -0700 (PDT)
Subject: [PATCH RESEND v2 0/7] riscv: sophgo: Use upstream devicetrees for
 CV18xx boards
Date: Mon, 27 Jul 2026 14:50:09 +0800
Message-Id: <20260727-milkv-duo-upstream-dts-v2-0-51486b4549c7@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOsQ6CMBRFf8V0tqZ9IqiTg6wOOhqH0j6kCpS00
 KiEfxfQwcQw3pd7z3ktcWg1OrKdtcSi106bsg8wnxGZifKKVKs+E2AQsogBLXR+91Q1hjaVqy2
 Kgqra0WQVCFQBT2XIST+uLKb6MYLP5Bif4sOeXD531yQ3lPVAHZqZdrWxz/EDz8f+VxZOyTynj
 K4V40wpJSIpdi+TmULofCFNMXo8/JAgmiRBT4IUk0gsQW7+SF3XvQE0Luj7IwEAAA==
X-Change-ID: 20260702-milkv-duo-upstream-dts-b54aed41fc61
To: u-boot@lists.u-boot-project.org
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
Feedback-ID: zu0801122731334e8e1f86d0320864fdc100001d1b0e4f1ed8e3b4a5fa356d2b31929b2e9145fd8c6a4f0db8:ZohoMail
X-Zoho-CM-AccountID: 475a6e82b6074d1cdb8624e432e1257a5f0812bb6089f487c4846d9f660201e2
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 27 Jul 2026 09:09:33 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt;
 c=relaxed/relaxed; t=1785135171; 
 s=zm2022; d=zohomail.com; i=zhuxu_ran@zohomail.com;
 h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
 bh=F7lTtbr+WypNcRqUDLPM9JwVH5Pbn9snDt6A/rAL+yY=;
 b=KHPuzVWZh0lvfnrkabQ126EwmDr4FEulnN3Kmgtl1r9naTZYn7z2Hk7C3k+pKYGz
 SWtgsS4Ww4cToMwSJgkRTUZ8+LPt9OTzXJSBi3R73h09P61uPeqNcp9TGRql4jnMtrh
 fFKu1HRW/Wc57dROnl6vTvyvhkZxJ+0AYHh9LIcI=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=zohomail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=zohomail.com header.i=zhuxu_ran@zohomail.com
 header.a=rsa-sha256 header.s=zm2022 header.b=KHPuzVWZ
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

Resend v2 to the new U-Boot mailing list after the project moved from
u-boot@lists.denx.de to u-boot@lists.u-boot-project.org. The series has
also been rebased from the former master branch onto main. No functional
changes from v2.

Switch Milk-V Duo and LicheeRV Nano to the upstream CV1800B and
SG2002 devicetrees.

Add the SoC-specific clock compatibles used by the upstream
devicetrees and add SG2002 support to the existing SDHCI driver.
Enable hardware system reset on LicheeRV Nano. Keep Ethernet enabled
for Milk-V Duo through a U-Boot-specific override.

Remove the unused local CV18xx devicetrees and the legacy
"sophgo,cv1800-clk" driver compatible.

Tested on Milk-V Duo:
- U-Boot boots with the upstream control FDT
- serial console works
- MMC is detected and can read the SD card
- Ethernet is probed and DHCP/TFTP work
- Linux boots via TFTP with Image, initramfs and DTB

Tested on Sipeed LicheeRV Nano B:
- U-Boot boots with the upstream control FDT
- serial console works
- MMC is detected and usable
- hardware system reset works

Build-tested with the riscv64-linux-gnu cross compiler:
- milkv_duo_defconfig
- sipeed_licheerv_nano_defconfig

Signed-off-by: Zhuxu Ran <zhuxu_ran@zohomail.com>
---
Changes in v2:
- Expand the upstream devicetree conversion to LicheeRV Nano
- Add SG2002 clock and MMC compatibles
- Enable hardware system reset on LicheeRV Nano
- Remove the legacy clock compatible after converting all users
- Move the Milk-V Duo Ethernet description above the gmac0 node
- Rewrite the cover letter to describe the changes directly
- Link to v1: https://patch.msgid.link/20260706-milkv-duo-upstream-dts-v1-0-8d010ddda7ca@zohomail.com

---
Zhuxu Ran (7):
      clk: sophgo: cv1800b: Add SoC-specific compatibles
      mmc: cv1800b: Add SG2002 compatible
      riscv: licheerv_nano: Enable hardware system reset
      riscv: milkv_duo: Use upstream devicetree
      riscv: licheerv_nano: Use upstream devicetree
      riscv: dts: sophgo: Drop local CV18xx devicetrees
      clk: sophgo: cv1800b: Drop legacy compatible

 arch/riscv/dts/Makefile                      |   2 -
 arch/riscv/dts/cv1800b-milkv-duo-u-boot.dtsi |  14 ++
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
 13 files changed, 31 insertions(+), 403 deletions(-)
---
base-commit: b635d43bca429500cb8ef20aa151cb5773b9a8a5
change-id: 20260702-milkv-duo-upstream-dts-b54aed41fc61

Best regards,
--  
Zhuxu Ran <zhuxu_ran@zohomail.com>


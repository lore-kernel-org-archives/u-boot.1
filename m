Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D966C25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 04:50:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEF2E880A5;
	Fri, 10 May 2024 06:50:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OjAHKRtI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D9D3880A5; Fri, 10 May 2024 06:50:33 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96C4087DEA
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 06:50:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A4oRJ9090936;
 Thu, 9 May 2024 23:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715316627;
 bh=5At2pcIAFFSQjarHPchuu3sJ9FY04O4pD/u19OqX+M4=;
 h=From:Subject:Date:To:CC;
 b=OjAHKRtIjTJ36+4lS1eR4kvSh/1lWFYfPJJ0wH12RRbWN3rTddEQBRB/lfzQ4ZrSQ
 avyWYR/SYCuiTa4qV2fW3NwdTZPURnXK0oYsHA0UJsmGEr5MKUAYbPpj4/xV+nUzie
 JCT2Qxuc6QjOKfW2IYdXzUYgkQVxk2LftN+oiuzk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A4oRTC016399
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 9 May 2024 23:50:27 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 9
 May 2024 23:50:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 9 May 2024 23:50:26 -0500
Received: from [127.0.1.1] (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A4oMGJ126967;
 Thu, 9 May 2024 23:50:23 -0500
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v3 0/6] Enable OF_UPSTREAM for J721s2 and AM68
Date: Fri, 10 May 2024 10:20:19 +0530
Message-ID: <20240510-b4-upstream-j721s2-of-upstream-v3-0-43672b7134b7@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIunPWYC/4XNSw6CMBSF4a2Yjq3pvS0FHLkP4wD7kJpASYuNh
 rB3C4mPGcP/DL4zkWiCM5EcdxMJJrnofJ+D73dEtU1/M9Tp3AQZClYwSa+CPoY4BtN09F4iRKT
 e/iausLIWUEspSEaGYKx7rgfnS+7WxdGH1/qXYFk/dLVFJ6CMGs1qzqFEAew0uoPyHVnchP9Wv
 WlhtkDUheRKi5rB15rn+Q1BcP4+FQEAAA==
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, Alper Nebi
 Yasak <alpernebiyasak@gmail.com>
CC: <u-boot@lists.denx.de>, Neha Malcom Francis <n-francis@ti.com>, Nishanth
 Menon <nm@ti.com>, Andrew Davis <afd@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Aniket Limaye <a-limaye@ti.com>,
 Sumit Garg <sumit.garg@linaro.org>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715316623; l=2524;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=uu8JNY3dKnJ3u1Gq2YCxoTXIr08R4UAWignhDq4oBbc=;
 b=Gz659Pn0lKeNvXCyjg/q+t2Nl1ID5oW10JcjhVt6bfG+Rr1xqozscZr/LBTA9x/q6ShaQknWe
 I6aeyCJQQknDAbLrhYSJko5kQu+0sV8x8zNjGSe6eWQfKjA8dXhoV40
X-Developer-Key: i=m-chawdhry@ti.com; a=ed25519;
 pk=fsr6Tm39TvsTgfyfFQLk+nnqIz2sBA1PthfqqfiiYSs=
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Series splits AM68 and J721s2 support along with enabling OF_UPSTREAM
and adding stdboot support for both the platforms.

Boot logs: https://gist.github.com/manorit2001/6c669e4273933bc46c3b28a631a96ae3

Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
---
Changes in v3:
- Improve the commit message (Nishanth)
- Link to v2: https://lore.kernel.org/r/20240509-b4-upstream-j721s2-of-upstream-v2-0-149563cd4901@ti.com

---
Manorit Chawdhry (4):
      arch: arm: dts: k3-am68-sk-r5: Sync with J721s2 R5 file
      arch: arm: dts: k3-j721s2-r5: Introduce k3-j721s2-r5.dtsi
      configs: am68_sk: Move to separate defconfig for AM68 SK board
      arm: dts: k3-j721s2|am68: Migrate to OF_UPSTREAM

Neha Malcom Francis (2):
      board: ti: j721s2: j721s2.env: Add explicit boot_targets
      configs: j721s2_evm_a72_defconfig: Switch to bootstd

 arch/arm/dts/Makefile                              |    4 +-
 arch/arm/dts/k3-am68-sk-base-board-u-boot.dtsi     |   41 +-
 arch/arm/dts/k3-am68-sk-base-board.dts             |  611 -------
 arch/arm/dts/k3-am68-sk-r5-base-board.dts          |   75 +-
 arch/arm/dts/k3-am68-sk-som.dtsi                   |  259 ---
 arch/arm/dts/k3-j721s2-binman.dtsi                 |   91 +-
 .../dts/k3-j721s2-common-proc-board-u-boot.dtsi    |   18 +-
 arch/arm/dts/k3-j721s2-common-proc-board.dts       |  504 -----
 arch/arm/dts/k3-j721s2-main.dtsi                   | 1928 --------------------
 arch/arm/dts/k3-j721s2-mcu-wakeup.dtsi             |  738 --------
 arch/arm/dts/k3-j721s2-r5-common-proc-board.dts    |   78 +-
 arch/arm/dts/k3-j721s2-r5.dtsi                     |   81 +
 arch/arm/dts/k3-j721s2-som-p0.dtsi                 |  361 ----
 arch/arm/dts/k3-j721s2-thermal.dtsi                |  101 -
 arch/arm/dts/k3-j721s2.dtsi                        |  175 --
 board/ti/j721s2/MAINTAINERS                        |   11 +-
 board/ti/j721s2/j721s2.env                         |    1 +
 configs/am68_sk_a72_defconfig                      |   10 +
 configs/am68_sk_r5_defconfig                       |   10 +
 configs/j721s2_evm_a72_defconfig                   |   10 +-
 configs/j721s2_evm_r5_defconfig                    |    2 +-
 include/configs/j721s2_evm.h                       |    1 -
 22 files changed, 155 insertions(+), 4955 deletions(-)
---
base-commit: 2f1e76bcfee75b9f99ade63002c05ffaaec86afb
change-id: 20240506-b4-upstream-j721s2-of-upstream-3c28ff12d664

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


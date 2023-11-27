Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD5C0755A
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 10:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD35D8752F;
	Mon, 27 Nov 2023 11:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="n4m7Am17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5D1E87539; Mon, 27 Nov 2023 11:29:23 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8259F8752C
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 11:29:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATGc2002143;
 Mon, 27 Nov 2023 04:29:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701080956;
 bh=igcA4e2IBd1QjMnEMyWYK3ZrMhkTGl/Q/ugoaFu2d20=;
 h=From:Subject:Date:To:CC;
 b=n4m7Am177RCChIjTivAvuOpNjse+epKuB7VJilBEXM1AcEqLcMsrPLPAt7HSRCg6E
 DKOFNAqZwH0GB4X6HVIhlRCKEDDTnkaMuJe21NKwRQO0UcYdYN40HqeOE+UBdEdTG5
 OXb/vAOr5Dia1NG4eZH+33vbAN7sM0UdXtIQfj7w=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ARATGEm095342
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 27 Nov 2023 04:29:16 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 27
 Nov 2023 04:29:16 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 27 Nov 2023 04:29:16 -0600
Received: from [127.0.1.1] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ARATDla089434;
 Mon, 27 Nov 2023 04:29:14 -0600
From: Manorit Chawdhry <m-chawdhry@ti.com>
Subject: [PATCH v2 0/3] J721S2 Add remoteproc early boot support
Date: Mon, 27 Nov 2023 15:59:11 +0530
Message-ID: <20231127-b4-upstream-j721e-rproc-support-v2-0-22ee7c8ef53c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHdvZGUC/42NQQ6CMBAAv0J6dk23oE08+Q/DoZRF1gTabAvRE
 P5u5QUeZw4zm0okTEndqk0JrZw4zAXMqVJ+dPOTgPvCymhTIxoLXQNLTFnITfCyBgkkSvCQlhi
 DZMCLto3Fq2s0qlKJQgO/j8OjLTxyykE+x3DFn/2/vSJo0L0n3Tk9dKa+Zz77MKl23/cvz+b1C
 csAAAA=
To: Tom Rini <trini@konsulko.com>
CC: Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, <u-boot@lists.denx.de>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Hari Nagalla <hnagalla@ti.com>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701080953; l=1248;
 i=m-chawdhry@ti.com; s=20231127; h=from:subject:message-id;
 bh=AYc2GuXOer3bQ8IE9EAy3bSRMIOnTcWDmKpgjNLVZ54=;
 b=9sQZGH/a0VyieBR6Ovmj+02l1QVG5mbXkwOzGrNElCpfg9N0oitvp6DVHPk5idAOk2uihaj63
 3XbYdUEOE8cAT5VemK7oSTTottCVNw5cxiyjjMMEwHyp28RWBmHFnQm
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

The series adds the support to boot early remote cores from u-boot and
changes the rproc_fw_binaries to be compatible with Linux DT Syncs.

Logs: https://gist.github.com/manorit2001/2f2ef0699619e0b496367b400ff02d3c

Cc: Apurva Nandan <a-nandan@ti.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Andrew Davis <afd@ti.com>
Cc:  <u-boot@lists.denx.de>
To: Tom Rini <trini@konsulko.com>
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Changes in v2:
- Update the signoff

---
Hari Nagalla (2):
      remoteproc: k3-r5: Extend support for R5F clusters on J721S2 SoCs
      remoteproc: k3-dsp: Extend support for C71x DSPs on J721S2 SoCs

Manorit Chawdhry (1):
      env: ti: j721s2.env: Remove the processors that are in lockstep

 board/ti/j721s2/j721s2.env           | 2 +-
 drivers/remoteproc/ti_k3_dsp_rproc.c | 4 +++-
 drivers/remoteproc/ti_k3_r5f_rproc.c | 6 ++++--
 3 files changed, 8 insertions(+), 4 deletions(-)
---
base-commit: 054222eb68f6d7500e21dd1f01af8b9a59b89fd4
change-id: 20231127-b4-upstream-j721e-rproc-support-15074716a401

Best regards,
-- 
Manorit Chawdhry <m-chawdhry@ti.com>


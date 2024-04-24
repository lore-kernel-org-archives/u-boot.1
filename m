Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BCAC4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 12:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 084AD887B6;
	Wed, 24 Apr 2024 14:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="nZGyDKPV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E442388700; Wed, 24 Apr 2024 14:53:46 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6C4888700
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 14:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713963224; x=1716555224;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bnN/760GNO4tP85x5DRE58AJOCvdp0HB03Ng8uUYa2U=;
 b=nZGyDKPVPCH9/gzrPx6T7z41R8CdYT64Q5Va+KAmg8XK9xqN3TYKtMaejPgbcadC
 EFpA+m3uf+Y3ymQhQAZlnIvKvNcPRvN7m2BbRx4qJxHKjaa9KCq2/zv+TxqO4ON9
 9IK9Vdz9zY+Ahg8xaAfIdVJDsq42zYuoQeDK2gGldPw=;
X-AuditID: ac14000a-fbefe7000000290d-31-662900d8cb64
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 09.3A.10509.8D009266;
 Wed, 24 Apr 2024 14:53:44 +0200 (CEST)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 24 Apr
 2024 14:53:44 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <u-boot@lists.denx.de>
CC: <upstream@lists.phytec.de>
Subject: [PATCH 0/2] *** Commonize board code for K3 based SoMs  ***
Date: Wed, 24 Apr 2024 14:53:33 +0200
Message-ID: <20240424125335.2306132-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrILMWRmVeSWpSXmKPExsWyRpKBR/cGg2aawbFn6hZv93ayW3S/U3dg
 8jh7ZwejR393C2sAUxSXTUpqTmZZapG+XQJXRvuWO+wFG9gqtqzYy9TA2M3axcjJISFgIvHr
 5jImEFtIYAmTxNPdhV2MXED2Y0aJV9eOgBWxCahL3NnwDcwWEZCSeNm5kbmLkYODWUBOYll/
 EUhYWMBFYv7MTjYQm0VAVeLxhnPMIDavgKXEmUu/WSB2yUvMvPSdHSIuKHFy5hOwODNQvHnr
 bGYIW0Li4IsXzBD3yEu8uLQcrnfaudfMEHaoxNYv25kmMArMQjJqFpJRs5CMWsDIvIpRKDcz
 OTu1KDNbryCjsiQ1WS8ldRMjKBhFGLh2MPbN8TjEyMTBeIhRgoNZSYT35keNNCHelMTKqtSi
 /Pii0pzU4kOM0hwsSuK8qzuCU4UE0hNLUrNTUwtSi2CyTBycUg2MRa3zLsQsXW7cGWnD4P1M
 bqlNorZlQdPTxCf7up3VPsiISJRFeC23a4pf6zi9dIOM4PWS8NKL+y6H32WokPIyVfbZ6S1X
 +nNJU+InK5PlDN4T2v+b+J/Z371lQabWqpaA06lbbycrSf0ok+r/Y883R4jx5dI6y9aQ50wV
 1xX/tV245vSrqkeJpTgj0VCLuag4EQB8UP5BNAIAAA==
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

Factor out code that we can reuse across all our K3 based SoMs.
2nd patch of this series require patch [1] to be applied first.

[1] https://lists.denx.de/pipermail/u-boot/2024-April/552021.html

Wadim Egorov (2):
  board: phytec: Commonize board code for K3 based SoMs
  phycore_am64x_a53_defconfig: Enable CONFIG_BOARD_LATE_INIT

 board/phytec/common/Makefile               |  2 +
 board/phytec/common/k3/Makefile            |  2 +
 board/phytec/common/k3/board.c             | 73 ++++++++++++++++++++++
 board/phytec/phycore_am62x/phycore-am62x.c | 67 --------------------
 configs/phycore_am64x_a53_defconfig        |  1 +
 5 files changed, 78 insertions(+), 67 deletions(-)
 create mode 100644 board/phytec/common/k3/Makefile
 create mode 100644 board/phytec/common/k3/board.c

-- 
2.34.1


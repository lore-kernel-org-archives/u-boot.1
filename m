Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343BEE7E623
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 11:25:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EECF386BEB;
	Tue, 26 Sep 2023 13:25:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AusETYDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6117986C2C; Tue, 26 Sep 2023 13:25:30 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21C9D869BC
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 13:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-kumar1@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38QBP8l8125247;
 Tue, 26 Sep 2023 06:25:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695727508;
 bh=uc9J/PKHuERUbKzFASZau/oZbXZ0o2rrpj6XTTo8Mhw=;
 h=From:To:CC:Subject:Date;
 b=AusETYDVBP0fdfPpWUpAnPfxT5K4TTSZMoLupiE7EIqPntO0wWHONKvp3mEVSBEHO
 EeGc5hrxTQnrFzSeGqZzjp3KN4/3WF0/sTX1AQiXK0DMv4o8v0Ip6pP8ywuhuv3Yy5
 C9jLeWt6nav+RHC5zqSJ8hCn+TM26Y4Q4YPuqQKk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38QBP8FW059230
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 26 Sep 2023 06:25:08 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Sep 2023 06:25:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Sep 2023 06:25:08 -0500
Received: from udit-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38QBP3Ce013985;
 Tue, 26 Sep 2023 06:25:04 -0500
From: Udit Kumar <u-kumar1@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <patrick.delaunay@foss.st.com>,
 <sjoerd@collabora.com>, <sjg@google.com>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <xypron.glpk@gmx.de>, <michal.simek@amd.com>,
 <dsankouski@gmail.com>, <kettenis@openbsd.org>,
 <sumit.garg@linaro.org>, <sam.shih@mediatek.com>,
 <mark.kettenis@xs4all.nl>, <sjg@chromium.org>, Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH v2 0/2] lmb: remove overlapping region with next range
Date: Tue, 26 Sep 2023 16:54:41 +0530
Message-ID: <20230926112443.4190471-1-u-kumar1@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

In case, newly address range to be added is coalescing with some region
but also overlapping with next region.
In such, case overlapped region was getting created.
This patch series, detect such overlap and coalescing such region as one

Change logs:
test logs
https://gist.github.com/uditkumarti/7be37a662fabfcfefb74d1a67ccde2bd

Changes in v2:
Patch 1/2: Corrected typo
Patch 2/2 : Added test case as suggested by Simon
Link to v1:
https://lore.kernel.org/all/20230924111832.3741245-1-u-kumar1@ti.com/#t

Udit Kumar (2):
  lmb: remove overlapping region with next range
  test: lmb: Added test case for coaleacse with first and overlap with
    Second

 lib/lmb.c      | 37 +++++++++++++++++++++++++++++++++----
 test/lib/lmb.c | 13 ++++++++++++-
 2 files changed, 45 insertions(+), 5 deletions(-)

-- 
2.34.1


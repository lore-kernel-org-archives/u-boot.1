Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE31C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 15:00:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B7087E31;
	Tue, 30 Jan 2024 16:00:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LTW/I/VI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5E3F87E29; Tue, 30 Jan 2024 16:00:36 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39A5587D5A
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 16:00:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=d-gole@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40UF0UZq012181;
 Tue, 30 Jan 2024 09:00:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706626830;
 bh=8F6DY3NXbhJWKymjf1km9UrVLd4LVehhtbeXP0HSH6E=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=LTW/I/VIuO+/7aftSkrxXdsXPTsX3CWYJjBp0zxWFKsEfoiwLzt1BjKMb4kbDRUgD
 v9T84nAVDUZuIEtuU2CHK+UVht0PB3i+A6xW0GQjfn4R8U8KRH8f5ZWYbZjgwN72rV
 sxumtQaKHcR5/4cMqguutIOWYZFflmu3jbv0xLqc=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40UF0UQk013515
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 30 Jan 2024 09:00:30 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 Jan 2024 09:00:30 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 Jan 2024 09:00:30 -0600
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40UF04UU014959;
 Tue, 30 Jan 2024 09:00:28 -0600
From: Dhruva Gole <d-gole@ti.com>
To: <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Dhruva Gole <d-gole@ti.com>, Nishanth Menon
 <nm@ti.com>
Subject: [PATCH V5 2/2] firmware: ti_sci: Add comment explaining the is_secure
 code
Date: Tue, 30 Jan 2024 20:30:00 +0530
Message-ID: <20240130145959.879882-3-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130145959.879882-1-d-gole@ti.com>
References: <20240130145959.879882-1-d-gole@ti.com>
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

Add a comment to explain the code under is_secure condition of
ti_sci_do_xfer. This will help avoid confusion amongst people who may in
future touch upon this code.

Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/firmware/ti_sci.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index b77ac36af284..ee0921855881 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -239,6 +239,12 @@ static int ti_sci_do_xfer(struct ti_sci_info *info,
 	struct ti_sci_secure_msg_hdr *secure_hdr = (struct ti_sci_secure_msg_hdr *)secure_buf;
 	int ret;
 
+	/*
+	 * The reason why we need the is_secure code is because of boot R5.
+	 * boot R5 starts off in "secure mode" when it hands off from Boot
+	 * ROM over to the Secondary bootloader. The initial set of calls
+	 * we have to make need to be on a secure pipe.
+	 */
 	if (info->is_secure) {
 		/* ToDo: get checksum of the entire message */
 		secure_hdr->checksum = 0;
-- 
2.34.1


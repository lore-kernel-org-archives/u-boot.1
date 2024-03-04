Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6294CC5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 16:04:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CD9287FDC;
	Mon,  4 Mar 2024 17:04:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="h+EsJRzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9030C87FD7; Mon,  4 Mar 2024 17:04:32 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCCF887FCC
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 17:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709568266; x=1712160266;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AMo5SyEXxPfRMypYYH8XzbzshnvDBHxNqxnTRJrWnE0=;
 b=h+EsJRzLgAGLyczYaMWDKHKCjvHs1zgy4ExH+iSVC8mJX7qQ4XK/ABxmbpc7G+ll
 stL9VCQoRnJMEKZHLdIltd/W3lr0vJOGbtyW4AhBdq1QQoMkfmt6M9TPjyzK9/n9
 oZ6tDkpk2gyxnEGIMttwS1pgGp5KsKch0TIP+sdL2tQ=;
X-AuditID: ac14000a-fbefe7000000290d-c6-65e5f10a9df1
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 02.08.10509.A01F5E56;
 Mon,  4 Mar 2024 17:04:26 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 17:04:26 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 4 Mar 2024 17:04:20 +0100
Subject: [PATCH v2 2/2] board: phycore_imx8mp: Use 2GHz RAM timings for
 PCL-070 from pcb_rev 1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240304-pcl-070-patches-v2-2-c534960c4b8b@phytec.de>
References: <20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de>
In-Reply-To: <20240304-pcl-070-patches-v2-0-c534960c4b8b@phytec.de>
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709568265; l=1011;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=AMo5SyEXxPfRMypYYH8XzbzshnvDBHxNqxnTRJrWnE0=;
 b=nwuGw5DImfsZgZqIXDTnUzilB41owiqrhClFDUpTvKLeUcvXW9t+qpKkQ057+44PxkQ/OUXpO
 lhM4XWWB3dAAQ0Ps0l3rEnhbTpg0xsNwUgw2+IK7/m6Uk79H/DVxd1s
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWyRpKBR5fr49NUgykbdSweXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlXH7NX/CV
 vWLX701sDYwn2LoYOTkkBEwkpsx8xNzFyMUhJLCYSaK79QQThPOAUeL7p4+sIFVsAmoSu968
 BrNZBFQklrZuBrOFBRIkug8/ZQKxeQUEJU7OfMLSxcjBwSygKbF+lz5ImFlAXmL72znMIGFe
 ASeJLzfMQMJCQOadbx1gN3AKOEvcvPQDzBYRyJZ41rmFHWJKlMS7iUEgpoSAsMSmnVogh0kI
 7GaSuHi9kwkiniix87UcxERZiZvnt0B9JS8x7dxrZgg7VOLIptVMExhFZiE5cxbCmbOQnLmA
 kXkVo1BuZnJ2alFmtl5BRmVJarJeSuomRlAsiDBw7WDsm+NxiJGJg/EQowQHs5IIb82vJ6lC
 vCmJlVWpRfnxRaU5qcWHGKU5WJTEeVd3BKcKCaQnlqRmp6YWpBbBZJk4OKUaGNU360Qdqv16
 RySSdwOv9oRnExfsej+zSqwmZ2N4iV7RhknGGdddPk/du2/t/e0vVSZOsZu/6+P3F9Md7Sxv
 Cjv9umOln7WxRUqj9rHzSSehzpkGVxJbJX+F/RZeXXlY9AjTS54iraZDZ28E/DW7rGa60Ta9
 yEcu/Gth9FPXoztbSuefviZjmq/EUpyRaKjFXFScCAAFCsr9cwIAAA==
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

We need to differ between PCL-070 and PCM-070. PCL-070 supports 2GHz RAM
timings from pcb rev 1 or newer. PCM-070 supports 2GHz RAM timings from
pcb rev 3 or newer.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 board/phytec/phycore_imx8mp/spl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/spl.c b/board/phytec/phycore_imx8mp/spl.c
index d38f6368fe36..15a8c75e9982 100644
--- a/board/phytec/phycore_imx8mp/spl.c
+++ b/board/phytec/phycore_imx8mp/spl.c
@@ -46,8 +46,10 @@ void spl_dram_init(void)
 	if (!ret)
 		phytec_print_som_info(NULL);
 
-	ret = phytec_get_rev(NULL);
-	if (ret >= 3 && ret != PHYTEC_EEPROM_INVAL) {
+	u8 rev = phytec_get_rev(NULL);
+	u8 somtyp = phytec_get_som_type(NULL);
+
+	if (rev != PHYTEC_EEPROM_INVAL && (rev >= 3 || (somtyp == PCL && rev >= 1))) {
 		dram_timing.ddrc_cfg[3].val = 0x1323;
 		dram_timing.ddrc_cfg[4].val = 0x1e84800;
 		dram_timing.ddrc_cfg[5].val = 0x7a0118;

-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F72C369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 21:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC2D820E3;
	Tue,  8 Apr 2025 23:57:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FN7HtOAm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB14E82AA3; Tue,  8 Apr 2025 23:57:44 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57AE1820E2
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 23:57:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 538LvdY71299003
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 8 Apr 2025 16:57:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1744149459;
 bh=pAClCJDZqIgB5fw0BhLNNKV8aX3wSUV1jZyqhXh+tgM=;
 h=From:Date:Subject:To:CC;
 b=FN7HtOAmb+zBwphYDcxzva7qZkTSQEltGhv3ERYlX+aNXoCzRTSMYGR3Rw0sgo68W
 x/VwWUTj/NvGhfp0+5xFJxDC/H0rHB6nwW1ulMrEVWIBm46YYRK5raNcJChchZa7SM
 +66Er0HT6sxs0DVh66hmtELA2l6ht94YN7hfy4jA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 538LvdXI125943
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 8 Apr 2025 16:57:39 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Apr 2025 16:57:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Apr 2025 16:57:39 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 538LvdWu069860;
 Tue, 8 Apr 2025 16:57:39 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 8 Apr 2025 16:57:34 -0500
Subject: [PATCH] net: dhcpv6: remove excluded middle expression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250408-excluded-middle-fixes-v1-1-38233f18a554@ti.com>
X-B4-Tracking: v=1; b=H4sIAM2b9WcC/x3LQQqDMBBG4avIrDswSmpCryJdiPPHDlgrCUpAv
 Luhy4/HOykjGTK9mpMSDsv2WyvaR0PTZ1xnsGk1ddI9xUlglGnZFcpfU13A0Qoya/DOj71EL4H
 quyX8Q12H93XdWKdrbGcAAAA=
To: Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=bb@ti.com;
 h=from:subject:message-id; bh=n+qhMy3Q3JYF4ajSjjuh/DwszsojboC9VwGy+uBaFu0=;
 b=owNCWmg5MUFZJlNZ5JdaTgAAZ3////9/vzn7/83fppbsP5fvb39zw//9G3d/fuz99/pqj22wA
 RtqI7UDIaaBo9RoAAeoGhoAAAaNGg0NBtQAAMQAAANANNDE00DEMmjTBpNo1DkDIBkaA0NAGg0A
 G1NDQGhpoNAPUDI0aaGg0AGI9TEAyMgNGmagaAMQaaMm1Dpo0YI00BkwTQAaDTINMjQAGgyGjQN
 MJkyaGhiGIxAGhoA0AaAyA0NAMmQECbB8AZYHUoXBuwkTTCYv94G1BLBMzq2iAyE8oUbEAM0Re9
 oBwBW30lx2TgRRuRYepSlCwKdrofPxnkVBfLQMigy5vfAM0J+L7JiEr566skRwYUDITi5yjCtuy
 6WEq9NOWYo+UZe9HqFVXYHysJDGL7DcgdSQa8INHrVkZoFvJOuySKLXVZ7WPQK/0+1SjjxZRaNu
 n68juqtf1RFcsdaMQgBu9AEG9KuQZBNGW2sn2xA+rjcCw6ogFoVWnELwUyk5rkJBpd4VJb35e5b
 jjilojw3O9yFnN4CqEZNeaplsBIgMWxCnMAnxB94zIn2On1uy8ZkbLRTVS1NlEhHcwLBorlf2ZB
 GPBk1z0uRTTBLiGRwXGCAJPfgAQ078mRLI3adB5NCoRDAAjNezF3EAud/FQRWyjnOaQ46MEEMA4
 NzwgKBzbiZoH+LuSKcKEhyS60nA
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

 !A || (A && B) is equivalent to !A || B

Drop the middle expression from the statement

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 net/dhcpv6.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dhcpv6.c b/net/dhcpv6.c
index 54619ee698362..65ec48ef665e5 100644
--- a/net/dhcpv6.c
+++ b/net/dhcpv6.c
@@ -473,8 +473,7 @@ static int dhcp6_check_advertise_packet(uchar *rx_pkt, unsigned int len)
 		 * server UID, save the new server UID and preference
 		 */
 		if (!sm_params.server_uid.uid_ptr ||
-		    (sm_params.server_uid.uid_ptr &&
-		    sm_params.server_uid.preference < sm_params.rx_status.preference)) {
+		    sm_params.server_uid.preference < sm_params.rx_status.preference) {
 			rx_uid_size = sm_params.rx_status.server_uid_size;
 			if (sm_params.server_uid.uid_ptr)
 				free(sm_params.server_uid.uid_ptr);

---
base-commit: 9d9fbdab0e9664bff147109cc89ad2786f6ecd83
change-id: 20250408-excluded-middle-fixes-d8747a60f708

Best regards,
-- 
Bryan Brattlof <bb@ti.com>


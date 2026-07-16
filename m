Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DF1C44501
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 08:06:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE47B84D77;
	Thu, 16 Jul 2026 10:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZB9SHsDW";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rIea5zLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 043ED84D98; Thu, 16 Jul 2026 10:06:28 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53A9C84AC5
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 10:06:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66G7Fvx01639735;
 Thu, 16 Jul 2026 03:06:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ffLyGieYlQXF2N3LcTewv18JA79gK1PA2bTaRo4X0
 cs=; b=ZB9SHsDWPCyDQ222WW9XORqLIoxEFqq00cjIzwjJCi+f2l7+2x+mZLVlu
 3sEQWS6wE1HKwaX7WSpcgF75dswQSwWtBVNxanL1tpaj4o5WFbijlju5smJGi/8L
 9B39ZrLjFPwnQOQzLDyP76QcWf/kUoH+NZfCiANzGqgKAaJqtl0+C9hjumq7+JHH
 zXH+zYxbiJVl8JX2352fg6cdphjCVT/nc25GenCG5hYVAs2Ls4UOQS4Sf5pfJMAD
 nIytjbRUuV5OqxHYSryj3J2l1+qeNaKkkQxxQiWHVjTpKXxsDYTvpafwYzi7OHCK
 ElLfQJzg/vl2K20QObyT1xP4VOpcQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010057.outbound.protection.outlook.com [52.101.56.57])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fep5s9na3-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 03:06:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u2ByzbsAnnCyqzhf0LrbjiROBmIF/idnmnEzEYdO6NNVC5SWeIm+O2YY+sS73sEmA5EOTpdP1dYsJQZhcrv2RWt99reZrTJeM4oJg84fWQzaQZ3yLMBTBbyNQ+KI7oa+3mjRGodpCWv/yA/fBXD7D26UWH9j9PEpYTh0SQ5c6SlfHVNwsBxoNhGblrPu03ro5B+s1CfvVGoyiWpD5Wd+QUPhRWpk8gjcBDl6jEiIU/oDWMiBSvLKho3vRhzXM8NjV1fS/TA8ly+NTBoLeyJsLDGwCesqFs9xZMHVDB+u1Y9OdNj8NqvlKd6Q8qAO1Ou4OwyaSv22yH5bKztn/xVeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffLyGieYlQXF2N3LcTewv18JA79gK1PA2bTaRo4X0cs=;
 b=XVPZxnDF08gev0gk0pHQ0RF26JVoiOWv45ZXKIr7+U1zNwy0GLrfF+mQ0qna6fjQxsDVuuoGkvvdZdOyqRSRyR6ynGOGRfVqdjhTdD0iipd2P+qNNiWnD2IQSBc3d/j2ClbeOiIWGbIltyf9GbOjHHdGLkyB5ZaaKnTCpFV9Ezd+pJYpntBdv+qZzldMdUqXCm8sxEdM2NseG48/PXSa5e9dfURmFA9jreh3z9xobnEZfKrPchlcdvDfxDmPpeUVcEBxN6FtprClrQnrYXGkOys1c64PzFy1125KSSyfw0Evb1u8FW/y1ko6C1A+a2S4y4iDSvJFmrWpFJHtXDqiNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffLyGieYlQXF2N3LcTewv18JA79gK1PA2bTaRo4X0cs=;
 b=rIea5zLcWaO1pitj+RFmLvE4Df+7U+epnUS+uV+8BAOfo+z69V8hX+YyXGTW94PFtLuIQHaKEwsf4O8EIKfhT+iww86RkomFzVCAS3isU1HJ/Rd4PqBxwTy1QDWghqsyDca3G9EfnEKqt5L2ay4SB63zcQTR2dJM29b89Y8cYUs=
Received: from BN1PR13CA0027.namprd13.prod.outlook.com (2603:10b6:408:e2::32)
 by CY8PR10MB6731.namprd10.prod.outlook.com (2603:10b6:930:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.22; Thu, 16 Jul
 2026 08:06:18 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::60) by BN1PR13CA0027.outlook.office365.com
 (2603:10b6:408:e2::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Thu, 16
 Jul 2026 08:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Thu, 16 Jul 2026 08:06:15 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:06:03 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 16 Jul
 2026 03:06:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 16 Jul 2026 03:06:03 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66G862AU278705;
 Thu, 16 Jul 2026 03:06:03 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, "Wadim
 Egorov" <w.egorov@phytec.de>, Chintan Vankar <c-vankar@ti.com>, Bryan
 Brattlof <bb@ti.com>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>
Subject: [PATCH v3 4/4] doc: board: ti: am62ax_sk: Add document for Ethernet
 boot on AM62x SoC.
Date: Thu, 16 Jul 2026 13:35:53 +0530
Message-ID: <20260716080553.2664147-5-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716080553.2664147-1-c-vankar@ti.com>
References: <20260716080553.2664147-1-c-vankar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|CY8PR10MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: ac426a6a-c7a1-490f-329a-08dee3111c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|6133799003|13003099007|10067099003|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dwtLf1DmfwQFGoYzpFf3MUaaqpxeDLYPJ6uHdJkD5OU1WKMPZJUTYBn4qdR8dfHMy/byv6j+vaChnw+3PFZgPNZt4N8oJs7mRfUESqDGSyLJ0bnMR9C/i7P/n9hO525RT71ZqerY6bMm41hX+vhuisOeeHXH4tN+TGJZuZvUuM82Cl4DinwcpKIziOMAzpfC6mogKgWBuuCguW1A082nTvCPW/gV1PPHoVbonPbM2aAiO4nq6koXU2JaeJ9tH/JBgWseauo94gXp+O6LjrJt8mfp7hYJ5gnU/3CXCHz66rKDQ5McZ3MVV2v5T4RLItjVtXJAztlz94wnxUUguK+8Xbj6NPT78l6i8CEW8oi2E2waoxhacPZy/Gv09D+AqeWcVnE0Vf0xIKmkME4YQe1muVWte6lijIuQ0sLHecNQp1etrsnEhDZnF4yKDKnRWiCzUcNNUEqXOl26iX2G3i3ykpA1gFycRDyuKM7PZ9pmLjjNZuXolO85ftil1H3OSa4F8wqyI11womBhlmB2p6joYkdV9d9Nw7VuIMbBPuXvcHxM9KJsI/wmAh32+s78c4X7+ZUUSsnsKIV5j5qVLW09ACLr9aauhRZ20rpGM1mwT5ERJuDMiI6pBxyngM5qmv8YLLscsr0kbEN4jDSPlw+uVdyEVQRRD7dhHlzoijY8AuWjymfbYXYRh3jG4QURfZvvDTiDumh4HUUL1usBs4hMmw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(6133799003)(13003099007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 66lsukbXmd2EIMzRTTaHQl3v1T8YbWm7Yc+AQt63OjlHSO1AXvIVle3N+CPDI0BggC55RE8eJnUINQ3kwo1Dn9i5qOktQxqCtwPX3tT/rwVcO+sIJsQVb64BVq5SF7tYkkcAgz6BM3iijy1kK29OuK/1GYQKYhJc9pzzHDtkqe+Mkmg3uXGV/CUKb55EyohSyQAz6cNWBJ27muMHJ2eofz1lr4XFQsfpMPSrh0i5w5to5W07PCSJQHUttfnvGfCMAPb9rV96NFoP4KyTD0fWsRZYNz5teTW5YfJwU6xCHh9Y60oE7ij9hyfqRZYTOA0SuTZatIi1hSZs1aF0ssP5Z2R25vytFWwMnFbuzxsQccIhBjOOiEQyS3PLqw5nQjv6y0BLBljoab2MKoTL3MtOWxdJPk436WwE5ndSZvbwi0/wRc0uRpmrp+EFB9dZSNLw
X-Exchange-RoutingPolicyChecked: ZI6fE9OZhtOmrwjpxaTPCD+19K+N+slDPiXb5o47pOlICHqQNF9CvL3mZwuVtACGEMvOEtoW4Ld9l+SHKiFXsWU0U5Zi24WWXplPDI2HUSkSdAeh4yfm0IpSvUrnTBJ+Pn6tPgfUENUXgac1vpmokDaLSYtinf8Di79BwuavDCxbSK1N6W+GLzDaSIxh73kP7c/L+VYusftWAIJuvFbgl4sUolweEipmZBkutidW/6rgMA19r/w2gkxT5pasQhwus5nO9DciXkspMBD10CA3JLEpiJ96zmqB+MCamDI44J0wUabaMrMV2mkSTZ2BnXgS/cEPTVJjxJmAVmVWot6njQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 08:06:15.8936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac426a6a-c7a1-490f-329a-08dee3111c31
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6731
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX1TErtnM0a4RX
 l+0Ey2kdiYQyjWQpusCBd4oidLk2uyFIq4MvAHwow19tDFGHFqKpx+e/OjlTyOML4GUnoG75AGo
 GsV60Gnx6bxMvbdAwWr/RdvCCRMtcBI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA4MSBTYWx0ZWRfX6aHlUoq1zdIr
 zyXdC71iGGT0bzhwvNjyeFwczSucn7NaVsoTgvyUTbniuKfyK6JsNnPjuUmYm7PiNO59gaAqDPz
 2ONrvkjmZH2uc4WKMT6uGn2QO8A9jdtlkKJYKMiy+L1c2j9tv96HpicmhjJ4IoNGG9k+bXLnktZ
 5VqDEUjoosVS10qTaLXDLLEZbvdxKBU3IHWXoZaz1AAyFixbG8IVmKhNKgn00pfOCFgrmrldpDc
 nx1d1Zo3WxdNvGnIEivLIPSxEEG+lpa6WjVaMP7Vnr0B7XlFMbt2pQU36PwzC6mu9mvoSy77F/Q
 aMXDpHb63ndfZgxZleXY674LZ+8tGFesGYu0p/JPJ5w7/lkvPUbt5f2J/FrYh2OBO/psalaJXdo
 qXMpopIq7V+vpx8YLcfMFKlCkQeTbtatILbnaXjRkRuXONCg8yp4W4+ejrC8q5Md/La+0biHsM6
 NX2Yd0dcgG5ZQm+hEaQ==
X-Authority-Analysis: v=2.4 cv=Zrjd7d7G c=1 sm=1 tr=0 ts=6a5890fe cx=c_pps
 a=fyslLl4jtBSJ9QFfScbUNQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=sozttTNsAAAA:8 a=TdfuAo4oWobQuexNUIwA:9
X-Proofpoint-GUID: 10n5738j3q6NGDbMd2r0QvaYXFknZgr7
X-Proofpoint-ORIG-GUID: 10n5738j3q6NGDbMd2r0QvaYXFknZgr7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160081
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

Document the procedure to enable Ethernet Boot on SK-AM62A-LP.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

This patch is newly added to this series.

 doc/board/ti/am62ax_sk.rst | 197 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 1 deletion(-)

diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
index 6f3432f7895..3453ed339e7 100644
--- a/doc/board/ti/am62ax_sk.rst
+++ b/doc/board/ti/am62ax_sk.rst
@@ -185,7 +185,202 @@ https://www.ti.com/lit/pdf/spruj16 under the `Boot Mode Pins` section.
      - 00000000
      - 11001010
 
-For SW2 and SW1, the switch state in the "ON" position = 1.
+   * - Ethernet
+     - 00110000
+     - 11000100
+
+For SW3 and SW2, the switch state in the "ON" position = 1.
+
+Ethernet based boot
+-------------------
+
+To boot the board via Ethernet, configure the BOOT MODE pins for Ethernet boot.
+
+On powering on the device, ROM uses the Ethernet Port corresponding to CPSW3G's MAC
+Port 1 to transmit "TI K3 Bootp Boot".
+
+The TFTP server and DHCP server on the receiver device need to be configured such
+that VCI string "TI K3 Bootp Boot" maps to the file `tiboot3.bin` and the TFTP
+server should be capable of transferring it to the device.
+
+**Configuring DHCP server includes following steps:**
+
+* Install DHCP server:
+
+.. prompt:: bash $
+
+  sudo apt install isc-dhcp-server
+
+* Disable services before configuring:
+
+.. prompt:: bash $
+
+  sudo systemctl disable --now isc-dhcp-server.service isc-dhcp-server6.service
+
+* DHCP server setup
+
+Run the ip link or ifconfig command to find the name of your network interface:
+
+Example
+
+.. code-block::
+
+  eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
+        inet 10.0.0.5  netmask 255.255.255.0  broadcast 10.0.0.255
+        inet6 fe80::1a2b:3c4d:5e6f:7a8b  prefixlen 64  scopeid 0x20<link>
+        ether aa:bb:cc:dd:ee:ff  txqueuelen 1000  (Ethernet)
+        RX packets 100000  bytes 120000000 (120.0 MB)
+        RX errors 0  dropped 0  overruns 0  frame 0
+        TX packets 50000  bytes 6000000 (6.0 MB)
+        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
+
+  enx001122334455: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
+          ether 00:11:22:33:44:55  txqueuelen 1000  (Ethernet)
+          RX packets 200  bytes 64000 (64.0 KB)
+          RX errors 0  dropped 0  overruns 0  frame 0
+          TX packets 150  bytes 20000 (20.0 KB)
+          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
+
+  lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
+          inet 127.0.0.1  netmask 255.0.0.0
+          inet6 ::1  prefixlen 128  scopeid 0x10<host>
+          loop  txqueuelen 1000  (Local Loopback)
+          RX packets 10000  bytes 800000 (800.0 KB)
+          RX errors 0  dropped 0  overruns 0  frame 0
+          TX packets 10000  bytes 800000 (800.0 KB)
+          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
+
+Suppose we are using enx001122334455 interface, one end of it is connected to host PC
+and other to board.
+
+* Do the following changes in /etc/dhcp/dhcpd.conf in host PC.
+
+.. code-block::
+
+  subnet 192.168.0.0 netmask 255.255.254.0
+  {
+  range dynamic-bootp 192.168.0.2 192.168.0.5;
+  if substring (option vendor-class-identifier, 0, 16) = "TI K3 Bootp Boot"
+  {
+  filename "tiboot3.bin";
+  } elsif substring (option vendor-class-identifier, 0, 20) = "AM62AX U-Boot R5 SPL"
+  {
+  filename "tispl.bin";
+  } elsif substring (option vendor-class-identifier, 0, 21) = "AM62AX U-Boot A53 SPL"
+  {
+  filename "u-boot.img";
+  }
+  default-lease-time 60000;
+  max-lease-time 720000;
+  next-server 192.168.0.1;
+  }
+
+* Do following changes in /etc/default/isc-dhcp-server
+
+.. code-block::
+
+  DHCPDv4_CONF=/etc/dhcp/dhcpd.conf
+  INTERFACESv4="enx001122334455"
+  INTERFACESv6=""
+
+* For your interface change ip address and netmask to next-server and your netmask
+
+.. prompt:: bash $
+
+  sudo ifconfig enx001122334455 192.168.0.1 netmask 255.255.254.0
+
+* Enable DHCP
+
+.. prompt:: bash $
+
+  sudo systemctl enable --now isc-dhcp-server
+
+* To see if there is any configuration error or if dhcp is running run
+
+.. prompt:: bash $
+
+  sudo service isc-dhcp-server status
+  # If it shows error then something is wrong with configuration
+
+**For TFTP setup follow below steps:**
+
+* Install TFTP server:
+
+.. prompt:: bash $
+
+  sudo apt install tftpd-hpa
+
+tftpd-hpa package should be installed.
+
+Now, check whether the tftpd-hpa service is running with the following command:
+
+.. prompt:: bash $
+
+  sudo systemctl status tftpd-hpa
+
+* Configuring TFTP server:
+
+The default configuration file of tftpd-hpa server is /etc/default/tftpd-hpa.
+If you want to configure the TFTP server, then you have to modify this configuration
+file and restart the tftpd-hpa service afterword.
+
+To modify the /etc/default/tftpd-hpa configuration file, run the following command
+
+.. prompt:: bash $
+
+  sudo vim /etc/default/tftpd-hpa
+
+Configuration file may contain following configuration options by default:
+
+.. code-block::
+
+  # /etc/default/tftpd-hpa
+
+  TFTP_USERNAME="tftp"
+  TFTP_DIRECTORY="/var/lib/tftpboot"
+  TFTP_ADDRESS=":69"
+  TFTP_OPTIONS="--secure"
+
+Now change the **TFTP_DIRECTORY** to **/tftp** and add the **--create** option to the
+**TFTP_OPTIONS**. Without the **--create** option, you won't be able to create or upload
+new files to the TFTP server. You will only be able to update existing files.
+
+After above changes /etc/default/tftpd-hpa file would look like this:
+
+.. code-block::
+
+  # /etc/default/tftpd-hpa
+
+  TFTP_USERNAME="tftp"
+  TFTP_DIRECTORY="/tftp"
+  TFTP_ADDRESS=":69"
+  TFTP_OPTIONS="--secure --create"
+
+Since we have configured tftp directory as /tftp, put tiboot3.bin, tispl.bin
+and u-boot.img after building it using sdk or manually cloning all the repos.
+
+To build binaries use following defconfig files:
+
+.. code-block::
+
+  am62ax_evm_r5_ethboot_defconfig
+  am62ax_evm_a53_ethboot_defconfig
+
+`tiboot3.bin` is expected to be built from `am62ax_evm_r5_ethboot_defconfig` and
+`tispl.bin` and `u-boot.img` are expected to be built from
+`am62ax_evm_a53_ethboot_defconfig`.
+
+Images should get fetched in following sequence as a part of boot procedure:
+
+.. code-block::
+
+  tiboot3.bin => tispl.bin => u-boot.img
+
+ROM loads and executes `tiboot3.bin` provided by the TFTP server.
+
+Next, based on NET_VCI_STRING string mentioned in respective defconfig file `tiboot3.bin`
+fetches `tispl.bin` and then `tispl.bin` fetches `u-boot.img` from TFTP server which
+completes Ethernet boot on the device.
 
 Falcon Mode
 -----------
-- 
2.34.1


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A70CF2597
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 08:37:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAD5683AAD;
	Wed, 19 Nov 2025 09:37:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="FTNP1aB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55BB583B8B; Wed, 19 Nov 2025 09:37:27 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4646B8397D
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 09:37:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wevmqtsoxMZDqcp/u8ClpeMvYfnqEnIPa/Fw50HokoohukQdWlPEB2Ije9LEyFs9lFoSXNusOdJ7AlKoJr/NLX9GbvvRL7D9PMByxO+QV8Seah6DNZ6KoRa7DvWHIPjCry0po9G3UiYaC38Ks9zPnHFNUyDqnUQT1eafzU1f20I/RdQTuk+RTj7xXWtZ2C3s7zdNoptHsLV/ZwxkiEfgfDCy+B4tBYR5KlR3H6nFHczRBo8Xo+gTGshgoUyOg5c/ncHdSu9xD/jOmoaydAdgIvqO2uF8ffEqHJbAkNGKiKHBLGCNgS6Ownyya12zykB8qvqP9d7i+fN1NOJfCoQYwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=su841jsS2WHtjcouYu6lFDqXjYzh1+4RR0279Eu7Oug=;
 b=NAqvdCEo2I73J4VWJ1MKeNI8NiQIzcwu68I6CwO0VGEv+mEmdi54FHaBHRe8UvO4UWbxb9YoTMKurI1ldfoS/RSVPuNxlswbcJaFAqOI35jhYlnT1gdutQxrUn+2LJ5bGR06hB4OqhYEMMl3egdBk7pVjIrIeGUq14FC6aByhmYjq2MUBuEfbRn7A2WbZhVrW249IYLvqesnwgd57jZzJN4XekXRd3Qeqh1UrT7KD1TC3BIE1t4KIeksZx8BLXWEMiqgA2S3ToktXtzbm5fwoXxA27FS2p6IV8//vTJ+Vl1U78r71ltOdhSTlTlRLSoIqIkaDePN8mfUFF+ErC1YDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=su841jsS2WHtjcouYu6lFDqXjYzh1+4RR0279Eu7Oug=;
 b=FTNP1aB5BHZ9fZ9ywGLljoPGepr6lTFsUoux2jUEziBHQmPBXxB7+dO4+LbkYNLOOXDfo+oCEQ74q/85iuiUcXoUN7skyjnX/YU1j8LAWXEaqlk8ke9I44VLqHVZhpDGMp1qMMIr6RLhwJo6OodBQsLbjipfERA4QrIo2pNHKsapYja/Q9K7ceRRVLmqD21i4pg/13iqOYm+T0zBV4DRoNEr4iHSNkB+DQs55C/g1GbxDZEDf+T/WpRAwlRs9z+Uy5xlgXwQgZTAl4voSJNfwac2APaUCGvGGqRngtuAXFDYzo9pZZ//5dGD8jDCY6ln1jwhbjyr1bL6UyGrXNB5JA==
Received: from PA7P264CA0287.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:370::15)
 by AS2P195MB2083.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:553::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 08:37:20 +0000
Received: from AM4PEPF00025F9C.EURPRD83.prod.outlook.com
 (2603:10a6:102:370:cafe::51) by PA7P264CA0287.outlook.office365.com
 (2603:10a6:102:370::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 08:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AM4PEPF00025F9C.mail.protection.outlook.com (10.167.16.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.1 via Frontend Transport; Wed, 19 Nov 2025 08:37:20 +0000
Received: from llp-anderweit.phytec.de (172.25.32.82) by Postix.phytec.de
 (172.25.0.11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 19 Nov
 2025 09:37:19 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>,
 <jerome.forissier@linaro.org>
Subject: [PATCH] net: tftp: Remove tftp_init_load_addr error path
Date: Wed, 19 Nov 2025 09:37:09 +0100
Message-ID: <20251119083709.2000844-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.32.82]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F9C:EE_|AS2P195MB2083:EE_
X-MS-Office365-Filtering-Correlation-Id: ca3e947c-8e50-439e-6be2-08de2746daa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JpKg5RKWYcyO/Ef0EGmoJJARuFgSt7dUdkAn/M+MATlHUvZY77kerJf+2i+P?=
 =?us-ascii?Q?qxWbl/1TTAWcrbBm9QoEFjG2KHJcwxmGas9huXLWB+WC+LVRh37C4O37ubJA?=
 =?us-ascii?Q?Xf+feaRJTNWFq+zwh1CvfJLENeWecG1/Wynhja43ELjCL6yQ4K4fVWiCLXQW?=
 =?us-ascii?Q?XCGyxl96E1+tCMOF29dtZNXC8GcVEJ+pI2rldJGh6k62800A6CP5/mW5hLvk?=
 =?us-ascii?Q?Ifd+epnyBwh8cvEk8g+FVtvnQ4PHeJPKb0M87TX93e7bsoV0/0kbVb+7wWwm?=
 =?us-ascii?Q?cjHbUtG7St7wgoIc4bEtSO5G3PHC2XcrK3UPBE5g8U1PPavEfAQcZABi3Li7?=
 =?us-ascii?Q?Q5WsU293J+MQLcFe6TtQKykDl2+VWyYkmklveqh3Kdh2FU5awhLXg9oobUqo?=
 =?us-ascii?Q?o1C03h5eSmSjPY9m57rI1F498zhH7ckV82KWYW0Reg/oOmgjw5MaO82uaE1P?=
 =?us-ascii?Q?pCKz3RqBT8lqM7XRzdYgwZaHD7/hg0XoEzbb/HXK2XsBYY+xG0y/muWKAiyc?=
 =?us-ascii?Q?V3ff20bVFi2w29nWl35dK27kvbnFXc6epma0/bJrHZOIeXz2pHX11QZr1hZa?=
 =?us-ascii?Q?zHd/gOwMeZ9IifM1G9Vg6duSv8X5Fg2sM0EcG9CIfp90DKz054AzxaaRXGx9?=
 =?us-ascii?Q?1N/XcsIrjEyLqwJRwiiQk6JjcCWhfmxaaYH4K/5/j69PLJw3T26sbLIQnxEj?=
 =?us-ascii?Q?KasTM3aBCWdf0AWchoPcpFgnEEgGmU6aESY+tqzH5k2qrpu9X5xoUOr4CRZC?=
 =?us-ascii?Q?6BlqqlEsbDmNH/pd9HOBhHOvWTOZY7ydSQJpiij0HpCtTPajglWH02Bv63l1?=
 =?us-ascii?Q?3HKd1ISvw0b/MsThPIl22+esEhDCKBTwAPccBIeL7+1QkJX9VUt2snKabM19?=
 =?us-ascii?Q?AWlyU2CDZ4iT0ZT4TkDlLPfARb+2d0UYT12EzPXi6GSpNEZ6geSP2rYXafSN?=
 =?us-ascii?Q?XygYCLFe7KRLTpb1zptTuUagRNHLR7asNPpDQilrMay6PUbO5UacZHuJnqwm?=
 =?us-ascii?Q?UGaXDIW8HEbw/btv+855ufqyJie8VHMkSDd4lQQ7VJUlhBu8KXevwGkTlGLm?=
 =?us-ascii?Q?CpHaqjHNf9YpivM59NOP8m/OzkmfdzcLTBoOwXqZpjIRQ1tE/jMrJhhLXU1o?=
 =?us-ascii?Q?awUdjTYd1OzPNzUrcjN4x6xsEcrUXQlGmiF6tyHW64CdjATOK/v6uY4871Ah?=
 =?us-ascii?Q?bwoPIGsyKZwvF7bdcWI7LUT73qTEe2PnokjgaOBcPEoEAvFR5e8pe+wy3whw?=
 =?us-ascii?Q?X2ZtT6sSbll5r3yvoW7NkqbpKyhhme4gCqoOST9f4aHcXqn1OQ9aHr2SYoOA?=
 =?us-ascii?Q?YP8cR0WQNDt47OirikEjY7ZbHZ/Y3FOwRdJpJRU8Rjm6Yx66aKRj2jsBk2PJ?=
 =?us-ascii?Q?Jbpv0rk7XPrERHEJwP+UOEHJ5kbWBVJEObSg8f/XBHxPHMEUNfHv9J/JWfX3?=
 =?us-ascii?Q?L2h1L4w085HTyCMjVPYBrBkQtlf1Zd17yfrsnTmiTwav2mU6EkbFwlHopfxg?=
 =?us-ascii?Q?YfjGxW1bv8q2gDFjfl/OmXgM83fd9nflDd01ionmg2tKcPkJMxYRuXsxaq4h?=
 =?us-ascii?Q?XC/ecW6m4A1YThuc1z0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 08:37:20.2430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca3e947c-8e50-439e-6be2-08de2746daa8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F9C.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2P195MB2083
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

tftp_init_load_addr() always returns 0 since commit af45c84871e4 ("tftp:
rework the logic to validate the load address"), so we don't need to
check if it failed and can remove the error handling.

Signed-off-by: Leonard Anderweit <l.anderweit@phytec.de>
---
 net/tftp.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/tftp.c b/net/tftp.c
index 1760877107fa..18f72b6a74ac 100644
--- a/net/tftp.c
+++ b/net/tftp.c
@@ -901,13 +901,7 @@ void tftp_start(enum proto_t protocol)
 	} else
 #endif
 	{
-		if (tftp_init_load_addr()) {
-			eth_halt();
-			net_set_state(NETLOOP_FAIL);
-			puts("\nTFTP error: ");
-			puts("trying to overwrite reserved memory...\n");
-			return;
-		}
+		tftp_init_load_addr();
 		printf("Load address: 0x%lx\n", tftp_load_addr);
 		puts("Loading: *\b");
 		tftp_state = STATE_SEND_RRQ;
@@ -953,12 +947,7 @@ void tftp_start_server(void)
 {
 	tftp_filename[0] = 0;
 
-	if (tftp_init_load_addr()) {
-		eth_halt();
-		net_set_state(NETLOOP_FAIL);
-		puts("\nTFTP error: trying to overwrite reserved memory...\n");
-		return;
-	}
+	tftp_init_load_addr();
 	printf("Using %s device\n", eth_get_name());
 	printf("Listening for TFTP transfer on %pI4\n", &net_ip);
 	printf("Load address: 0x%lx\n", tftp_load_addr);
-- 
2.43.0


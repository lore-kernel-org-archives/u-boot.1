Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D44DC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B53F881FD2;
	Wed, 29 Jan 2025 11:30:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="GhWYyRsL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2579A80885; Wed, 29 Jan 2025 11:30:20 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20708.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::708])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 853EC81877
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdRj2SbEVlXHLhLXlRD4mp3taNexImVy06T2pSgCOUcvfIuiTtC+EU+PjQKxxAfE02FS/27M2tIFiSjVh4qYKaZa5jEJ1QIxTmyAIaIomForfaeSeJL/ezjzrGn6pPYzlBN9LlQWvO66mZNts+/VU5+qKpo+/yV33LS06Dl/OlH5SY+rWLPZW3YXUPv/tuplM03+V2sgRk4VmwYqnilRM7b7L4nDagjS8oC8uxqzR3x3rHodokFXN/l8CZrWI0hdVOC2FiUp+79bdeKquu2pPgfiSiDSk3SrBtrQmaVRQF1oFBYKocLRdcAabRC08JnbeWe0iBu2avltgo8dhSTKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJ2hpnzW9QgoFHE06Y1g15uKFrBlXCiLcXMMQk1EFfs=;
 b=qymuMzT19tfnPR9fNoQHnZupzOWhuU0WncmTvsVspSlqIqh+Qh1QuEd8ROlS1Q1N2SLj/WLJi7qHM7wAdK/tLESlJ/mxCNfIv2kd1PBn18Qflpgf/fQMHJu5byxbBKbK4UxbLSB/tjWDDy86CAv8eSa09gjBxBNpW74vpOl9/3TTkYoUz9CXrPVIRzYeA5+Kq1nv4zhcXDrgVbZ4vAsjmznkHcRaeKpAx0p8IZOdTi60fnXA/pilerNmuqWyvu9qfYb4WwlVu/Ym9tJDXL7wIYuoeTf70jO2OEBSj+2UTYG3arsGj1MOeeh50dVz5IoyzkoesAopAU2QuDUJ5ji0uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJ2hpnzW9QgoFHE06Y1g15uKFrBlXCiLcXMMQk1EFfs=;
 b=GhWYyRsLJ1LaE5e++GvoypbvEtJ2fidwrWjmHWgoa73D4KLRlW0V7HlNQrhSj1SrkfTZzkLwcRCq5aUhQbNHjXpZIciVLVFrBlcEc4+Av1RpLw0YN/H8auuWJUT7XkNgGV/yojw1bsxp18zpycMe/uSpqYHuR+XJXr2ouk+a4r6DnTad8FAF9Ojdn+g+XIduO+O78rboNoIEaSv448y1QdWBfDIfFbUrXdgrfjyMxfDBJyisKqkI2AHQ+gRKPtEobJE4pZVkyV5lbbGursvz7eDndoACO/rtI7SG9geN+00bJKybrIW/V1rBglwa/HQpaN+PkdyMdSnzXr7BVx8ntg==
Received: from AS9PR06CA0158.eurprd06.prod.outlook.com (2603:10a6:20b:45c::16)
 by DB9P195MB2061.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 10:30:14 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::25) by AS9PR06CA0158.outlook.office365.com
 (2603:10a6:20b:45c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 10:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:30:14 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:11 +0100
Received: from lws-moog.phytec.de (172.25.32.60) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 29 Jan 2025 11:29:51 +0100
Subject: [PATCH RFC 6/6] binman: doc: update Optional entries
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
In-Reply-To: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB9P195MB2061:EE_
X-MS-Office365-Filtering-Correlation-Id: f1509e70-9fc7-47bc-576f-08dd404feac8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnc2Y2pFR0xZano4WVlvNnFBQ3lqNWZNYUhaZTg1YlJtYldpUERRcTZaSHY1?=
 =?utf-8?B?NXA1NzhNY3FaVzRTUENVMnd4eUtiVXVzc2RUbzMwYVJDcmhoR2xqZUY0emRz?=
 =?utf-8?B?azJ6ZjFTRENxVlRZTDdlUXBHVDlxZUlmMm11OFVXUVdBZGpHaHVJbkgxK3Jh?=
 =?utf-8?B?bXlIc2VHcTdCVGRXZjE2YUR6bVpaeC95TEVFc3BkQ3diaUp3MFgrajI5VDcx?=
 =?utf-8?B?bUphRE16aXR5VWZLdXRLN1RWUmpLczB0SWVzQ3o2SElXMlBaTXlHRnBEd05u?=
 =?utf-8?B?NWZ1THZNcnlTcy9lU3BuNEZmVjRZUXppNi9EYVR4Y0UyNjJuNzFCcldLNW4x?=
 =?utf-8?B?RUovOGc3dlk3NG9QZmJaSGxjNVR5QzJQZ2V2OU9vK2dMWG05VU5yZG4vbkVZ?=
 =?utf-8?B?MTVSSXZvYnNFdkdWdW0ycWowMGxiNjlaenJOK1pzWXBpMS9sTW52VGR6NzJy?=
 =?utf-8?B?eTg3V2FwNE5qbDZCd2M2aUZweGdzYUVuWlBlSmdhK09SS0Y3VVR1NC9OL0My?=
 =?utf-8?B?bGxFaDNxb1FjU2xDTDZoMS9nRG5SbFJnY3cybW5KdC9ibm9Ld0dlQTFFOUhj?=
 =?utf-8?B?aU1pL0hydXFpUTgyN1ZTNENoaG1FVXA0eHJiYklJZ3BKMlV3R01HcXZGcjFN?=
 =?utf-8?B?M1VXSnl0aXg5K2ZuWlFITFJFajNpK1V2RHdSREdieGxoVEJoRHJKQ0lpOGNR?=
 =?utf-8?B?RWR6U0RjbFBqQlQySzJpejFkbmVnMlphYzNJcDVSRmU4TkVjUGZTS01yU1NK?=
 =?utf-8?B?ZXpJSXlxWWhOYUdUd3pWWjd3NWYvMmRUU0E0NGQ2dmpDQWZBZ21Falp1Z1Iy?=
 =?utf-8?B?MUlrTUNiTlduYWhKOFBpQ2lJU2luVzB4ajhRRElyQUdNbGpkSWo1UEQ2NFNX?=
 =?utf-8?B?OFJJLytsTjBLRUYzTUVqSUhpMEtEZkR0UWhQRGVGYXpBcnV6NmtPNC9Semtq?=
 =?utf-8?B?dXQwS2NLVGhMakJiZmxzaDJOaGhyMmwydWc0WjY5OCttVjR4dXNRR1J0S1A1?=
 =?utf-8?B?M1hwdUU5eWZuOGxITWN2MjVEdEJQYlFYdVBLUFFnRzhjdDBsNndvSk1oZUwy?=
 =?utf-8?B?ZHArQytFUmlFeGc1QXZkbU03dWlGNVAxV1VJK1ZRMWhuRnBDTlNCeDVzNW9n?=
 =?utf-8?B?TTZPL3kyY2NXOHExVVE3NHpBZWkvajNrZGNMVElNMTZxTm8vNGRNMGxKbmlj?=
 =?utf-8?B?Z01HdHJjOVhSd0NNeGpLSmpCblREZ3ZlOGdJR085RVJUSkNOemw2NE5WMHY0?=
 =?utf-8?B?UDNJbkJiOCtQbXBSM21qbng1MGIvUHFKc1U4Yzk0UlRqTFI5MStYQUFhTEwr?=
 =?utf-8?B?M0xMcStqUllpNnBjOUZQVHNMTlduWUszZGt0Vm51dWxaVFNRc3JKRFFZVFBV?=
 =?utf-8?B?dFJIL0xTSFRCVzlHZm9DSkZFc1hhTEZBUldHemZVRmxYQnk3SUw1MjllL2ZF?=
 =?utf-8?B?bFpoaEZPYnFKUmZTMTh3b1VvZHd6S29oYm15dWtWVndoM1FSY2NzQXV4bmp2?=
 =?utf-8?B?TVVhNm9YMDRTbGlrdTk5MSs0MUM4S1BETVRzTWY4WlREcDVORERJTWRZb01T?=
 =?utf-8?B?cVQ5S1FNL3V0VnZnOWVlSzRZMFlHQUx0VlgwMGNqVkFCWXJsMU1NRHYrOUpn?=
 =?utf-8?B?VGY1S3Ara1UrdVpOd0k0MVFPS2VqYnVocGZ1aExTL0ZnNkpOS1cwSzBadTE2?=
 =?utf-8?B?N3ZjQnRLUnN1ajBNdVpuTHlYamVCbEtGRy9VdVJrQ05FVmllWjVTT0kxc0RB?=
 =?utf-8?B?RWo3TVE2U2c2VTRFZTEzNTIwbHRjL0JJQjZ1SG4zMkJtQmVsNms0emYrd1Q0?=
 =?utf-8?B?ZXc5ZFRIUlhvaXptZzdaUW15eW9oRzVUdHF1VjdHUCtZQXdJeVg3RFNGUFc2?=
 =?utf-8?B?K0wwMUJNSndMUi9iSFE1SnU1K1B4WlRqWWVEcGwzKzdjNnNBN3lhZFp3SUg4?=
 =?utf-8?B?UllYMU1vR0J3N1pubVIzd1MrTHM5MnpQN29kcFV1NlR6VjNJTDJ0aURsQUxD?=
 =?utf-8?Q?kvCFiWw7zdxmk++B2RMrBvow2ZBXrI=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:30:14.1601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1509e70-9fc7-47bc-576f-08dd404feac8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2061
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

The binman documentation of Optional entries is not accurate in the
sense that it does not cover blobs entry type. As this is also the most
widely used type to have the optional entry, document the interaction
with faking blobs.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 tools/binman/binman.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
index 990fc295770..2bafa6ca408 100644
--- a/tools/binman/binman.rst
+++ b/tools/binman/binman.rst
@@ -1145,7 +1145,14 @@ called on all entries.
 It is not possible for an entry to mark itself absent at any other point in the
 processing. It must happen in the ObtainContents() method.
 
-The effect is as if the entry had never been present at all, since the image
+The effect depends on the type of entry.
+
+Blobs
+~~~~~
+For blobs, the effect depends on whether --fake-ext-blobs is passed
+to binman. (This is the case by default)
+In case --fake-ext-blobs is set, any missing entries will be faked.
+If not set, it is as if the entry had never been present at all, since the image
 is packed without it and it disappears from the list of entries.
 
 

-- 
2.43.0


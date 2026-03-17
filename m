Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D10AFD8766
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A42468428C;
	Tue, 17 Mar 2026 14:13:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="O3IaiU7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74C26842A7; Tue, 17 Mar 2026 14:13:46 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A220A84277
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOoO3qrehdHXFB/JWlWAoE7dXRiihtxVGoirHYwZ9LwbKM5XAIWWE7BBZYLewjICmE4KcraMv2V0EyGRtOQ9hgxyUtFdGBv51TA21kvmNo/l1bxq/as85tq3wUOrmIHYPTcOcai4xXRUhKBM4VKB3MJaxoz/fqyi4PfWdnvTA02fXLTYPMClHUM6H2dLlRKxE9FhitrgbsFid2wjZy+gT2yJXfYCpG6Qrh6wYlQ4Sht9w+T7q3GR7VTfel37CDccBvQWABvUp4fGJvgM6ZOakiYlJQ1Nw5R4OgMrf2HqqNVszkiRMEFFB/CWCawTv007rHxtztWroUq6OpbCxGajfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9N4M4Y728kUMRVe7wapanodHaGxnjLujBeniurga7TM=;
 b=JW0DgeF/3OsF8y4sY8KWlWdtD1cjkINs3TGCoYFsId7ag7mo9Svlft7SipaHSBgHLYxWw2GVFBavOYMeymxab3bdZF0lDf89Pu8i4zOCK1XNXC5Xf10zxdIQu34HSj4GUZlx3pBML9J+vrm99PJJhrpEULnYTXuQbuuyv5EchQGCUBPqVjRWzIEciFScs7MpcRHrS29FXZYSYV2QGf9tbuU/yDQsXd5v5RMHJ3FNqKcVTYKhPnIAnBQe0rJmiUVNt6aZFBGBZsqzAbqsDxXtymeBSUfNbnIVtRkGHlrkzLcRRZN7AqieE8QXPM+P+mHSjqZj04C26ko5pckw/GC/ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9N4M4Y728kUMRVe7wapanodHaGxnjLujBeniurga7TM=;
 b=O3IaiU7OlPLnrYEW8eRTmZqAdQFBd9G1VggMfjAHqwSjqiM2yjG1HKHwwFRb0F+p0ViPlmsWCrE6cc1z3FPrjcbPPr8Cftva0PgeD6kH+vrYHYDvSVVyl6fFFZeQ63MBJJLckw2GM2AQcfmnbynpLSkfgtzlZW277svS9Rr78bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by AS4PR10MB6134.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:585::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.27; Tue, 17 Mar
 2026 13:13:40 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e639:bdd4:4bb5:6361]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e639:bdd4:4bb5:6361%4]) with mapi id 15.20.9700.022; Tue, 17 Mar 2026
 13:13:39 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH] doc: overlay-fdt-boot: .dtbos do not need load addresses
Date: Tue, 17 Mar 2026 14:13:36 +0100
Message-ID: <20260317131336.673240-1-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPAP307CA0006.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:3::14) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|AS4PR10MB6134:EE_
X-MS-Office365-Filtering-Correlation-Id: ad28d057-3c87-4fb0-d448-08de84270159
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: K3umee6oJDmMtVQkdc7ocRlRaTcres5vDo1h/YC0FNkk5zp5cQ9g+26ECqnSYJFR4Y5StSOrTw2cOHVZv7woFs9OnBRmx/7tZ0Gw7OoIcWkcL72Aw2W3/x79cpRIu2p+Lw7zmDm1sigG8uhAbHuCdM/2pRd8KK0FKOW4p+53dwP2KXtwm2sNIxCJ6yrV5vV9pqvYHb3xAHN+w/rcC7t7A3K+iuhX2X0u+t5YpFH5+0ewhEQvV5g/Kceho5n9VhELy39H233lOgRLZ3xGdUrHOJZ5JUKklYtTrfJX1cnlVyZ/43p6fNqDDVBBR7nkkSKJUgsOuShDODxcbz21+2i8ozNtKLwVLwTyKX7BKCW4IltvlK88RrJZrA8NmT0eqNG+RAbOZrDwp4ZiaRqeXsUTMq3VN0/JB5cyM2ygr3EKiv8pHcnMF+JTQVO+8EIWHM4zeJfgheBpgH9YnKFoYl2nE1wNEkIxG5BlcOLnUoe4woy5jIsIXVxYg709SzRAp920cO68+w29vlLCUkTTHZ4IGI1GJ0dWkWaUVLL8enj11qUaS/uYT4t2P8mraKYu1P61e82bb5RT63bI25BfyhlQXRYQkfYC6pJ9+I2PerHe5q0YhOqFLGW8sBkEXzFkJ9BG7WDN0TXI16+WyWb6kZMeQ/nEkgFf0ja59g6IceVgjGJqNWz9al6HdrHDfh6k/yaLn07KComrG0/zDjDbhUXh3Gh0G/hpd3wb5pWLX9erIyWa+/dooIkOrNqk2pR97MEI5aGTKFNFK7oao5GwbBVOzRnccMU9UANt/Noq/kxSRRY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4nhKKeySGUrpbs/Q7kxnbhkymlX1AV+cwkIj2KGSUnDxeaioZX1BVfSuUrm?=
 =?us-ascii?Q?tPxl311NE2UdsldvIQb2jMFBBuHpcHBG9eSfCnzGZveqUGKVIUuqmb6JheBU?=
 =?us-ascii?Q?FB+depJcflF+Zr1Q4afRmm2AAAhDrI9gRXDrGVaN2WpximE67pnnDphOtoP6?=
 =?us-ascii?Q?V+p8pe623UhIMsxCNTV3FaO9AA4UPed1XjG5hoPT2CSk82Ska0r2vRRR5D5n?=
 =?us-ascii?Q?NFN4oQ2aGfrNRj2oqq7A94wB85HQ6Ir+/ZGcMRlZBBEsqEa4UuW6pp/afLK3?=
 =?us-ascii?Q?nvPjE9lFqYwPAuDtO/ga1PYe7KuY5ETBZz1LnXvUSZx4HyPRJDiOcZfEWbgL?=
 =?us-ascii?Q?tpqzDEqfRR6UKX9QZEElFXqlK4tC0iKitigASPkR2SWy823CICRyNlAd0A8m?=
 =?us-ascii?Q?A/0aU5votIHa3+2398EylfZC7/9mfgC9swuJQct1TNISTASP704aArtByUeC?=
 =?us-ascii?Q?oREG3Bwrws7O4gpgTkngjljv8IFSiyR2v94ju911x0P5onriqxeFtslphJhm?=
 =?us-ascii?Q?GfinyXtEXRRAs+gzhmpRwEVoHReSfBIEsPcc+CIjv8mMAQwDb8++WWKiWWCW?=
 =?us-ascii?Q?SL7o5CSO8x1J2sZlJQXoUvZiOyIRlYcpYMBBOIKZGiogL/6qlcIm4d6E4TuN?=
 =?us-ascii?Q?lXk9AL6K/sMx/dIUo423YzKP3HpL/dji/6P4LrklcMNJoaCSlGN3836g8eEe?=
 =?us-ascii?Q?V2BAeIcBfJojR6OX7kwFcv07wgncuZtYKZfTLea6JcVZHPHWHL9DSqNkDTjx?=
 =?us-ascii?Q?xTHmgT7Te02qGEd/cbwRdrvCLwQX0ipHHAkZDM7kg4jXM8jkRUAkhBcrOQIc?=
 =?us-ascii?Q?xKwGvYFYr8NCnRc8WD2O4MGFPIZyqoYmvBNkrQlw3cq9NqGOVNcwSnqjcMSZ?=
 =?us-ascii?Q?cpk+IhmRtXnM1n4IslOD9mg6MJWqg2HZC5yQ3Wz+qsataW6JALrnaQ1Xx5ou?=
 =?us-ascii?Q?P7j/vi3tq1i17QShrKupsbwqugUMlAk/Koa6RwLlt4mTEWAtzYS9zvgy+SV6?=
 =?us-ascii?Q?vdqxHdaZTCeLhgC3QKwdhknOkOVTikdXdvoYMmO264/L0MUN+eDgbPt58dHm?=
 =?us-ascii?Q?Zm0Zx8vgSouhisf3+BJOkEqzBG1H4YFLIXpgQGQvn88EOIQ+wDITyykWfcGm?=
 =?us-ascii?Q?u0+VSHo54KqLBi8SWbu7ap8n/kw2B/49VVoBcvZ79q+YJj5LB7tjnnieLzzT?=
 =?us-ascii?Q?ZxyDpWcfHFvCYMJCUItOqoiRuEoOY8n11jGddCq7tW8gLBQGlRYH+baFpeeF?=
 =?us-ascii?Q?vHSRMo5hBrwjDAOH/89Yfe6YJxPcMUZlUYxDWLW3U9WO+CO0I6YmvvaE5CNJ?=
 =?us-ascii?Q?uXmc/NhoXj9GGqMpKBei7Ir9DNeNBf2sggoOCTkhysjU5Ci4Yq0qREXanZ5d?=
 =?us-ascii?Q?AbPzuYu3H9ba8KvP+Id2TRRhXm/175y2/dzi+am0qpNtqHg0jqEkJrtG04SA?=
 =?us-ascii?Q?yrA/W3xDe34j7m4gngVWKuN6It8nnCeUp/K8FDejju45gMXoiVT84iv1ATmn?=
 =?us-ascii?Q?p+tTjhdiKjs4otOesPC7pK8sHEIeZ6hmVpCV2QoKXVhuZrXADGrFZvCrrUfO?=
 =?us-ascii?Q?HczJpZIkr9mjMkL1v8oxi50uFtUmwumVlL258KiHeLdKHI5DXEupUuwY4R+F?=
 =?us-ascii?Q?IDFy8/uIadcPccvAtF+pwLdST4sLe5rCFcbq5oV/QJDxN6STgfxkG35VfoeE?=
 =?us-ascii?Q?LmZsV8ceNaRBYFvVNyDRV74z6ZN0cQFK42dOo8JdwzdaxvQ2njYPt3o+YqxF?=
 =?us-ascii?Q?M/YjWidmsDn2+vKhrZu/o73xby90jv8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ad28d057-3c87-4fb0-d448-08de84270159
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:13:39.6527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4m7XLCnX12wCyurGIXyEoQDGQEZQWPiT006Mh/WZmDeKpZKNMPyC2VLjujGhl31BhYhndRAKKQL+uLz/CUOQCx5cKlvMzeJTWj/YatrPrr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6134
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

The requirement that .dtbos have load addresses in the FIT image
vanished five years ago with

  4c531d9f58b ("fit: Load DTO into temporary buffer and ignore load address")

Fix the documentation accordingly.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 doc/usage/fit/overlay-fdt-boot.rst | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/doc/usage/fit/overlay-fdt-boot.rst b/doc/usage/fit/overlay-fdt-boot.rst
index 0f012d6988a..5df304047c6 100644
--- a/doc/usage/fit/overlay-fdt-boot.rst
+++ b/doc/usage/fit/overlay-fdt-boot.rst
@@ -141,25 +141,21 @@ explosion problem::
                 data = /incbin/("./reva.dtbo");
                 type = "flat_dt";
                 arch = "arm";
-                load = <0x87fc0000>;
             };
             fdt-3 {
                 data = /incbin/("./revb.dtbo");
                 type = "flat_dt";
                 arch = "arm";
-                load = <0x87fc0000>;
             };
             fdt-4 {
                 data = /incbin/("./bar.dtbo");
                 type = "flat_dt";
                 arch = "arm";
-                load = <0x87fc0000>;
             };
             fdt-5 {
                 data = /incbin/("./baz.dtbo");
                 type = "flat_dt";
                 arch = "arm";
-                load = <0x87fc0000>;
             };
         };
 
@@ -202,9 +198,7 @@ Booting this image is exactly the same as the non-overlay example.
 u-boot will retrieve the base blob and apply the overlays in sequence as
 they are declared in the configuration.
 
-Note the minimum amount of different DT blobs, as well as the requirement for
-the DT blobs to have a load address; the overlay application requires the blobs
-to be writeable.
+Note the minimum amount of different DT blobs.
 
 Configuration using overlays and feature selection
 --------------------------------------------------
-- 
2.53.0


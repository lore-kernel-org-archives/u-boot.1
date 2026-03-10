Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8B0FD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:14:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65C5B8409B;
	Tue, 10 Mar 2026 14:12:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WXNqgKN7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D531083F9B; Tue, 10 Mar 2026 10:14:41 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89B783981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 10:14:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwPrlMh5wcnvqK9K+tGs1n52jBG/5+I5vfB2jBHH2NmIDbovqqXP5K0HlJdeTpHy6WkOKlB+6QzitA8SAVqNI7pMSfZ6dz2yjoOuRoFdLvE/0t7OAQvyKHahAwWvJPfA/iVq06UVi4DvZqqb58GTFOsz6xNENlJVNUZ/8jRFKNzhMYjNY6Bd1S4pSsxpRweaFOcGaSIhV58/vDkw/ps+3ZdJsaxXOVAqd3w1Dbjcm7a4GvdlHNfkwA6/gOFXYNPJefqpoJ+eEXD50493W2aWxt6Fltum5vBqMy62mxiG6PRrVoI/HH9QXSc6ML48T4AMYocrEmPbJ/74T2RyJmloDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddSbFWgnq9DIWcw+meMSYRlTCcGko2pgGd0XFcO7AdU=;
 b=EJjDGLLyK8beWljz15wqTnBc6z2BLP5U/so6OKbCpjeSAeppa1pAM3XCC7fgiU7UnBVVhEARm7uW6oI8wSMLa7E9jjIoa8mKXWBcHb9i9wHhlo5NpU+ZgyVQpssJ7+aQkHwxmn1LKRGDvM/TPTlX9ko0mFQgJiU7CiLRA6KlVj1CUOrs54RRDvpC1thYO5EuR7mJQ4GNvkYpw6TItbcDdJ1fBhMaNN6ldKfr/M3p3T6D6sPc9+eh/GOoLJxB/aG1JOGT8m4SgodMn50M+WCxRZLQU3Ljm+w45GolVuaqsLUpwcW1f6RTx4n1OIiBNRnciSaQrLqz/ElIy2McIo6RFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddSbFWgnq9DIWcw+meMSYRlTCcGko2pgGd0XFcO7AdU=;
 b=WXNqgKN7nhMny3PoFDJYVnShxzsApFbDdp1aClUqV9+nG3+4EVUhxmkVrhE/RhvfkWwar5Cfurm/pEfOfILDfDY+HEWxVUwSphywmqcSjbfHM2mecQY5nW+CM4E0/5zDeP+eYznigoLroUByNtarqjL6oISqLtSxCl2IQE05nQit3TF5neyK5WL8z9O9ciBGOQOfa3cuNe4RnjUvWJfDw137oV4c9DMgxK6IYF80dfqJ08vNzg24fnJg8hI6cLjAWIBciGi0OT2ii8yaoOw46iOqc9NgtQZgoCJjleqDq9auimnqcO9zmoDJ4AuJashrcsqDLFBJkWVwstw5bgh1uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV2PR04MB11192.eurprd04.prod.outlook.com (2603:10a6:150:279::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 09:14:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 09:14:36 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 10 Mar 2026 15:53:40 +0800
Subject: [PATCH v1 06/10] imx93: dtsi: Add wdog3/wdog4/wdog5 alias and
 bootph-all property
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-wdog-v1-6-2ee21e890634@nxp.com>
References: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
In-Reply-To: <20260310-wdog-v1-0-2ee21e890634@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Christoph Stoidner <c.stoidner@phytec.de>, upstream@lists.phytec.de
Cc: Joseph Guo <qijian.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Jacky Bai <ping.bai@nxp.com>, Stefan Roese <stefan.roese@mailbox.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 David Zang <davidzangcs@gmail.com>, Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Rasmus Villemoes <ravi@prevas.dk>, Primoz Fiser <primoz.fiser@norik.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 =?utf-8?q?J=C3=A9r=C3=A9mie_Dautheribes_=28Schneider_Electric=29?=
 <jeremie.dautheribes@bootlin.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Mathieu Othacehe <m.othacehe@gmail.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Jindong Yue <jindong.yue@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Max Krummenacher <max.krummenacher@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR02CA0071.apcprd02.prod.outlook.com
 (2603:1096:4:54::35) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV2PR04MB11192:EE_
X-MS-Office365-Filtering-Correlation-Id: d64e7f50-8b6d-4e30-aac9-08de7e857340
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|7416014|52116014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: owWkBLDMThWE7U/yXUhda126ocdaKoowEHlAKuzfpNbzf/IQjFJ5Gimug5xfQDXbXEikJ6HBRQBoxuUNjL6eI3RthE5M9Umoxogvy1g4prTOR1kUqvnz0is3iN7SqkbOLJh8gMWmdu8D+ILqtsd6gEqOLEB9sc7C2m6Ro1PmV9Ycwndn9AsHPvMESMuqQQLinfxr92v42rMKFIcd5NCJUdn3aKEW8sWSr9XBSU9TmwAsuHZqP1vfpANa3HnDPj1bvlcm43yQ/X6OKGJz5aGkuJvTYYyiJwDSYM40Nkl9ku2IyqTWsTg3Q0lFNlLxKodLrk1+bl2FhfDg2PED/sbZgYxL1EWNn3YJd77spu24dAHjCxd4Jxo1vVd9Kp/EfcEos3Wr/sR65GWzgyj032z5gG/wHYoVF4srd1ONtm4D+wldpXokvuzHDEfbuQKeM0DXZp73p1z6IrDSq+hV5lNycGKF4NfsQL0G0BpsiVNlqUAozjt7Ea4tyjbrla/aA09wyQF8aNxjejNQBTIWMs1g+EffFnGVadS8vLfPFkqoQgaG8+lcmXw81pn14iKoTdNmElWX/xztynqcu2VNYnPPqID2zYwoB2DzutNEZj2jAU17RP+53/4fCKMCVA1khPesm3SQ/KW5DC7vtsOxDL/gFBidXEE6Cs9rgUyKLoewyJwZPehnsX30Tl9w6eE6EsMnQbXQM9WqcS25Gzy+JAAG6pAlHxWWrIOccvE3S0i8lauMBfb8RwvCCuo53F31r2zogi3OG5+o/o/2+1N3sHotBBBdbUQPI/v5L9Z9qrQu9Rw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(7416014)(52116014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVdES0llSEdKUW5pNGQrS2FJWkRSRkJMeHhIRVBVSXAxTXk4elQ3bXlQMm9w?=
 =?utf-8?B?MVhhS2x5Zk54Z0xLKzNaWDgrdkJLQXZPUUxsRERjSW9UR3BBQm1HN2p0a0Jj?=
 =?utf-8?B?UW1BZW8rSWwrSUQzNHNGVVhsNU1hNGN4cU52b1RLN2xzNEdrbE5objRuZmlL?=
 =?utf-8?B?ekFROUVEenFUU21XdWpISkZ4MzgzUWhyTFdZd2JrVk1mN1Y3QnRocFJzSi9P?=
 =?utf-8?B?OTlmdnE4aElJRFl2d1J3ZFVnMVUwNlJld1IvWjdNdW5YUXpxdnVXZ2YzT1Ra?=
 =?utf-8?B?TnZsNU95dVZic2lvYlM2M3YvMC9hRzJTbnVTZHBBVThjdTZFSXpQQWg3bisv?=
 =?utf-8?B?emRpaXg5amFvVzRuL1RkQlhMVHJwYUhMMTdGWUwvdlB4eEo5NEMxSE9LOERB?=
 =?utf-8?B?QkszbUYvTXBlUXRINW1jV1gyMnNWdm93N1VKbGlPUDJVVUpsT3ZlTkcwcFMv?=
 =?utf-8?B?djBaREo3TDJZR1pTSFQzRkkxOSs0Wm5mMnQxVGJTbGhnWWY4dWhsS0Fvc25D?=
 =?utf-8?B?NXNLd01YZXA4bFdJQkcrSkdkUTNIRlNGNjZvN1dwdXNjYXdtMm9kUlpnd2JE?=
 =?utf-8?B?c0dkTGlxRVJCQi91RVB0WHRaRitWYlY2WEtNT3VoeklzV250ZFlhQXNiVlhP?=
 =?utf-8?B?UXNidDJoYUY4QkdETnhrZDBjQVJCeVVuQXAwOTFCU3BFd0U1TTFpS3NoQzlF?=
 =?utf-8?B?WkYvVXV6NWJKblkralZJVDFjRklCM3RHWDU2d0NGdU8xRk5jVEhGVEZKN0Mr?=
 =?utf-8?B?MTVZSDRhUkNyMVo4TTVjWVBoMHN4TWlPbzBoZllKdTlSMHJ1TUxod3VGYk95?=
 =?utf-8?B?UzNiSk9kb09ZU3Rpbno4VFh6ZTVZTFpwZjFWMjBsN0xxNndaMkVYdjY3d3ZG?=
 =?utf-8?B?d2lqQzBLelNleVpsTFFmUkMvM2pyc3hvVVovdTRsYXcwRzlaaUwzWjVxd25Y?=
 =?utf-8?B?NThmbU9rdlpQQkVyNXdIRUJYUUNTYmJTN0dCek5zdFR5WGU1M3lRa20yakds?=
 =?utf-8?B?eEhuR2pUN1ZzSHBIRElQLzY4c2NlUEllMVJLQUo0N1JmVGh5VmRvaGNtRWgz?=
 =?utf-8?B?WnB3NzRGcWxPRW9qOGozSWxPUEwrVGY4dXZ3ZW12VnR5TDdLYmpjWTRtSnN2?=
 =?utf-8?B?aHU4V1IwaldybVVzMzQzNDREQitzOUE1TU5DdDJLV3dvYlpEdGVQanFCYlk1?=
 =?utf-8?B?QlhSb2dWU05OWjlnUnRGMFJPejI3K3VLMVVqUURueVNmVm9kOWVnZDR3SUZ5?=
 =?utf-8?B?Ry8rbW5qMEQvbDFkdzBKZzloQ0hibXdidStmS3JmbCtNNUNpRHhXWWpNa1hP?=
 =?utf-8?B?ZjZmYXFLUnloSVArUXBLbmZiRGM4dmo4b3M5dHpLZ0JFcTBBYTl5LzM3ZFpn?=
 =?utf-8?B?VUVjNEFORUxyK2toN1h2K3NtMGFDZWpja1RDL2NqaHIxdXBMOEZucHFUNTVl?=
 =?utf-8?B?aFBpamcvQ3pUR2lTZHMvS2pQVGFlNVBNa0FMNGF5NWQwdFRGNVNzd3V3S0NP?=
 =?utf-8?B?UjlWcDZZQkQwUnJyQ2J3ZEY2R2lFZHFkZU1YWlJsNlhJVEw1byswejJRSjFa?=
 =?utf-8?B?VDFjZ29iWFJHZW1hM0p5OGExRjlpVGt3ZWRtclVGNDRqVzgrU1BTUlQxek5V?=
 =?utf-8?B?YjlBeTZMLzRYT251WnVHYWxIcXorVHR3dGhDTTNqVEtXYU94blVmem9ieWRG?=
 =?utf-8?B?WEVCQi9sN1JwSDROU3FXWk9wblNpVHZJQmd6c1UyYlQ4VXFJMXMyNGt3bm4x?=
 =?utf-8?B?dFBUOHplVzhGbUFXeGJlb1U0akppV091QVBvVlgxNlJwRm84TDhrdk9wZnV6?=
 =?utf-8?B?MG8zQmExZWNrZVFzS0NUMDdEbFMxNkJTRTNxQ2hXVTgzb1NPbmdOMXd5MG1j?=
 =?utf-8?B?Y1FoV1RGZlRMNVhwbnl2N3pwWi9KeGQ4QXNUU2llcldjV0tJRDB4Wmt6aHRY?=
 =?utf-8?B?TEJNV3czNERJTW9BTGZ1c09VZmJ4dkNRcEpJa3VUM295YlY3VzluNjVFdUJG?=
 =?utf-8?B?czlzdWxuelZPKzlhQkVMcklkb2V5ZVRWaXY3L2hieHFDdVEvUktrQWUzS0dZ?=
 =?utf-8?B?M215b0hYNzJBRTJFeEw5aVd1bVVCc2hNV3B6ck5CYnhGRXNZcVcyYXJVL20z?=
 =?utf-8?B?LzRlMVkrRGxtNGlITEx5MzhJbk9jSXdOTGE3WjRNK2F4VmZER09rdWljYVRJ?=
 =?utf-8?B?a25UeUJYUjVNRkdmQy9QRzdxT1gySzNSWjNMNjZscGFpU1gxYkpTdUpnSWJj?=
 =?utf-8?B?bmVjTHRBQ0Q2Q29TejRFeEg5SEFUWHBaRTdQRUVzeEFKOC9yNXBLMmcva2Q1?=
 =?utf-8?B?MzRtbVlvcFhOZnhTNWd5dGxNam4ra085MXFoMm5yMkpWRktVbW1JUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64e7f50-8b6d-4e30-aac9-08de7e857340
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 09:14:36.6270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3470UGgRt26CyvQ15Z3Pm++sW1KObqPQa/p31yRqXDjhQhUCPmtDaKv3HO1P4MPvfON0B4vNIX/6gNMSVpEZag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11192
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:11 +0100
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

From: Alice Guo <alice.guo@nxp.com>

Introduce wdog3, wdog4, and wdog5 aliases and mark the corresponding
nodes with bootph-all to enable imx_wdog_alias_to_addr() to resolve the
watchdog register base addresses via the device tree.

When CONFIG_OF_UPSTREAM is disabled, upstream device tree files are not
used. Therefore, wdog4 and wdog5 nodes need to be added directly to
arch/arm/dts/imx93.dtsi.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/dts/imx93-u-boot.dtsi | 18 ++++++++++++++++++
 arch/arm/dts/imx93.dtsi        | 21 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm/dts/imx93-u-boot.dtsi b/arch/arm/dts/imx93-u-boot.dtsi
index dc86746ac90..c946f45c7f0 100644
--- a/arch/arm/dts/imx93-u-boot.dtsi
+++ b/arch/arm/dts/imx93-u-boot.dtsi
@@ -4,6 +4,12 @@
  */
 
 / {
+	aliases {
+		wdog3 = &wdog3;
+		wdog4 = &wdog4;
+		wdog5 = &wdog5;
+	};
+
 	binman: binman {
 		multiple-images;
 
@@ -96,3 +102,15 @@
 			       0x000001b2 0x800001b6>;
 	#thermal-sensor-cells = <1>;
 };
+
+&wdog3 {
+	bootph-all;
+};
+
+&wdog4 {
+	bootph-all;
+};
+
+&wdog5 {
+	bootph-all;
+};
diff --git a/arch/arm/dts/imx93.dtsi b/arch/arm/dts/imx93.dtsi
index d6964714ea0..549a30fc9f0 100644
--- a/arch/arm/dts/imx93.dtsi
+++ b/arch/arm/dts/imx93.dtsi
@@ -41,6 +41,9 @@
 		serial5 = &lpuart6;
 		serial6 = &lpuart7;
 		serial7 = &lpuart8;
+		wdog3 = &wdog3;
+		wdog4 = &wdog4;
+		wdog5 = &wdog5;
 	};
 
 	cpus {
@@ -414,6 +417,24 @@
 				timeout-sec = <40>;
 			};
 
+			wdog4: watchdog@424a0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x424a0000 0x10000>;
+				interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG4_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
+			wdog5: watchdog@424b0000 {
+				compatible = "fsl,imx93-wdt";
+				reg = <0x424b0000 0x10000>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk IMX93_CLK_WDOG5_GATE>;
+				timeout-sec = <40>;
+				status = "disabled";
+			};
+
 			tpm3: pwm@424e0000 {
 				compatible = "fsl,imx7ulp-pwm";
 				reg = <0x424e0000 0x1000>;

-- 
2.43.0


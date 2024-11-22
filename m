Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 556A7D75E53
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 14:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA32A8984D;
	Fri, 22 Nov 2024 15:05:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=phytecmesstechnikgmbh.onmicrosoft.com header.i=@phytecmesstechnikgmbh.onmicrosoft.com header.b="Rni8ZB5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13666897E4; Fri, 22 Nov 2024 11:28:42 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5F2F897D6
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 11:28:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Bas@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRlVMMOpBQ4xSSGeFALTjSIvc3GpO5UZvDsRRUWnhaKOrdCuQl0T/QwObY8HeekF1xtO+IyN3KtYNTdDYb4yKAJTfo6rKjSaEi7+aIxeKdNhOYKj+cPpJyAN8KgTSOC0AZ9NcC/E0aiFHlSAb7HM5cNHcAGeJ2Ogc36OXMvJ+p+5yzGPqpO0kzAQnT5kjGs34gfv/vpqvCZe6/mQ576ZBU21h/LPpQdId5fgMbhp2wF724vfTnhFhMiucl1OxtLGh7xAdSvpyobumnh+liKuLjaZC3ErWwa+XIwqx2ju3bb3WxARaC9UZlHvH1iuoduo95W1Z6ZYzaN0laOYf77kMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oorg+DBPuASWLSTV8XmHf0LykiYQzSBvpj9pspp4o/0=;
 b=Um9zmLK1ZjCb1VFcb5Lrh/ohphbaAXS5aSPWc+W7VlLsl/HSnKhvsZku9uRQcH3Tc01zwjUzTzijvRsLUMk7fC3v10oJtiGwZBJXDGIwDF5yoXZJD7Uf7PxD1Uj0Qx6DOpUNeTjak1jqFfs9kp0nze7Si8Hig/j4eugA36LfpEFRmO7SIy8IzMwsOb8HAPESxW/rkz3CY0SNu5oNAAXb5nAi7FrZKBRsTdx/yiZDDXNTWdwjyXTOmQ7muNvifZUbIXHeTMCoh5Jwk7GFDOlVRDly3r3zV5fNSQhdOCFSER3S+bQDWSNTUBvs0RW4lS2qlpWhYx7nTA8NjWc1Mhv+qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=none action=none header.from=phytec.de; dkim=none (message not signed); 
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=phytecmesstechnikgmbh.onmicrosoft.com;
 s=selector1-phytecmesstechnikgmbh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oorg+DBPuASWLSTV8XmHf0LykiYQzSBvpj9pspp4o/0=;
 b=Rni8ZB5NVArZRG7/QfT8G6WYYkkkAsH3T0K8MFlxGiGqt3ZiHuSY08FTBmIEuCwfm1Bgqrk/DsMIE9iSKY1llwvs/vfPswyBjFUVnL8CONDjtPp8VqpA2pj7nZMRN0WwhgAprN1NQbyfuADDXk7/RFa6ExJK8iF3aHeKHaPH6D4=
Received: from DU2P251CA0009.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::22)
 by PR3P195MB0879.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 10:28:35 +0000
Received: from DB1PEPF000509F0.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::fd) by DU2P251CA0009.outlook.office365.com
 (2603:10a6:10:230::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend
 Transport; Fri, 22 Nov 2024 10:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB1PEPF000509F0.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 10:28:35 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 22 Nov
 2024 11:28:34 +0100
Received: from Diagnostix.phytec.de (172.25.0.14) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 22 Nov
 2024 11:28:34 +0100
Received: from idefix.phytec.de (172.25.0.20) by mailrelayint.phytec.de
 (172.25.0.14) with Microsoft SMTP Server id 15.1.2507.6 via Frontend
 Transport; Fri, 22 Nov 2024 11:28:34 +0100
Received: from augenblix2.phytec.de ([172.25.0.51])
 by idefix.phytec.de (IBM Domino Release 9.0.1FP7)
 with ESMTP id 2024112211283372-241 ; Fri, 22 Nov 2024 11:28:33 +0100 
From: Yunus Bas <y.bas@phytec.de>
To: <u-boot@lists.denx.de>
Subject: [PATCH 3/3] board: phytec: phycore_imx8mm: Add RAUC boot logic to
 environment
Date: Fri, 22 Nov 2024 11:28:33 +0100
Message-ID: <20241122102833.4061689-3-y.bas@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241122102833.4061689-1-y.bas@phytec.de>
References: <20241122102833.4061689-1-y.bas@phytec.de>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on Idefix/Phytec(Release 9.0.1FP7|August
 17, 2016) at 22.11.2024 11:28:33,
 Serialize by Router on Idefix/Phytec(Release 9.0.1FP7|August  17, 2016) at
 22.11.2024 11:28:34
X-TNEFEvaluated: 1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F0:EE_|PR3P195MB0879:EE_
X-MS-Office365-Filtering-Correlation-Id: 0973a8e6-2827-4e6c-4d29-08dd0ae06bcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nq+D7rotKP1UpyJp013tASrPAnSXgTt/p5zkH520sNG+VtZG9EMd4Pqdu0dn?=
 =?us-ascii?Q?UPMcXiMrN0+eexeqlhauXUyvlBJMIOYJFkk3y2udyujyUcToYoi2WaLFRR7/?=
 =?us-ascii?Q?8dYawtZs4+4ZtZ4/0Fm8s6EQzpXyE0nGKfvfr1AyQIqE5+UIXxPVzIdSXGKf?=
 =?us-ascii?Q?vUrylnGjuNO8Bq4k4isnxqsvP9ihCuDFJlR7WiDkJCAQAHwhfqfpgNhEUnfu?=
 =?us-ascii?Q?HwDXbC3ddVK3QdGJNBAW3lZ35dCj/wfVIrsFQARMxjrPKN9LRDHAtFj5EhcM?=
 =?us-ascii?Q?qEsTjzKKqRxgl1nG+gYuB9CGzh9opwYgLRlbNlCSyQJV7FNomODxJzwkMKdF?=
 =?us-ascii?Q?RqOkMwtvBRO9d212I9XBidOvQtqG9iHL5mETjMi4MyFJVIycJipYhCxfm+6y?=
 =?us-ascii?Q?5EGdEAkPrka7Wlyr6VfFkhImXsgOR0dVTkrMts5d/xmKxb2N2pKPQ5VFHEaU?=
 =?us-ascii?Q?w1uwQQwjz266FRg2+6RKv8kq5xBPsp0em4hIhAlsV+5eAi/mIAvVnU0WoFKc?=
 =?us-ascii?Q?j6vwL0DMLDOL5EckZ4PtJ7eN4hMIRuQ3+d/U6hm4uZkTgdGNjhZFP1GiZ6v+?=
 =?us-ascii?Q?LXJmcRkPqr5gPZiUx1pgDQ+dN8IcygjqSBKS7GbAjch/a13TxGhTsk1qa/ul?=
 =?us-ascii?Q?lB2BRsR1WhfMIm9oXvEUEuBU56OonFY/V0RfPFPCMQaxEorqlLGrgqccvvo8?=
 =?us-ascii?Q?p6KCztds/ow5yU6I9HcNgQ1GpzHOXKyLFp+dg9MbUs2MVZG0jXjhZqNfDY+Q?=
 =?us-ascii?Q?GEwraHm6xBO8KIoTE7VU1F2fqiCh6U4qQWunJ0Uhb2iG0nS9at2GAc5YbQ9V?=
 =?us-ascii?Q?cC7QbbVVj6QUn3GM+EQb1HMGykGPG0EpioNAKyLFwFIsJy1c9F71kPBWpS6q?=
 =?us-ascii?Q?/3w3a5E389KIg9lhkCG4kn5z8nvq/yqhZOIDOSEhLep07FieLpl/dkkpLScy?=
 =?us-ascii?Q?rBgrwOdGbWnUi7c4k23U21CdB/zWmR+d1LKBZCH8LUG+g9xpF10AGsrV4CqZ?=
 =?us-ascii?Q?7pc63BWfhoqaYTs9cCJJoLbbz+DfJXAgXpNI5/I8rcjzleZeJeOn34WF3aZn?=
 =?us-ascii?Q?dGGM97G+eTOZBbsD76ihf0lAwncxJToBGv95pI0yTYJQuC4BTNvwaWnF4TBA?=
 =?us-ascii?Q?TsjWwOj3P53PmlL0lgxk0UPbtTVaneXc56JtZd2DcoJ2YcYpODII6s3fwSOB?=
 =?us-ascii?Q?VdVSM8rF7GoIDBoJhB/Nlf6D082knY/3W4cduRGF5l9FmsRsM4bnQN0eoaf9?=
 =?us-ascii?Q?NKFtM8hb9RU9j4F6oT+XO+khEtV+ZhAi/1l//0H2BUh3knVpK5zRCi8PTKD8?=
 =?us-ascii?Q?XRdeLs85xHjUm/b/aClSGJ7KYBuvjwjIQk4GIoWA7/GvaJujsboFCcZ+cADe?=
 =?us-ascii?Q?puAmKe8B+QgZFZWTxWYVOBDJU0rtI9KHWQCn96s6gWCXfjZ65g=3D=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 10:28:35.3422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0973a8e6-2827-4e6c-4d29-08dd0ae06bcd
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F0.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0879
X-Mailman-Approved-At: Fri, 22 Nov 2024 15:05:24 +0100
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

Add RAUC boot logic to the environment.

Signed-off-by: Yunus Bas <y.bas@phytec.de>
---
 board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env b/board/phy=
tec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
index 2058bf59235..1073e1327e6 100644
--- a/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
+++ b/board/phytec/phycore=5Fimx8mm/phycore=5Fimx8mm.env
@@ -1,6 +1,11 @@
+#include <env/phytec/rauc.env>
+
 bootcmd=3D
 	mmc dev ${mmcdev};
 	if mmc rescan; then
+		if test ${doraucboot} =3D 1; then
+			run raucinit;
+		fi;
 		if run loadimage; then
 			run mmcboot;
 		else
@@ -17,7 +22,7 @@ loadimage=3Dfatload mmc ${mmcdev}:${mmcpart} ${loadaddr} =
${image}
 loadfdt=3Dfatload mmc ${mmcdev}:${mmcpart} ${fdt=5Faddr=5Fr} ${fdtfile}
 mmcargs=3D
 	setenv bootargs console=3D${console}
-	root=3D/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
+	root=3D/dev/mmcblk${mmcdev}p${mmcroot} ${raucargs} rootwait rw
 mmcautodetect=3Dyes
 mmcboot=3D
 	echo Booting from mmc ...;
--=20
2.25.1


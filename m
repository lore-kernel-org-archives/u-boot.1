Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9E5C3600B
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:11:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 152E281EC5;
	Mon, 24 Mar 2025 16:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="A/uLbrqQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3782081F28; Mon, 24 Mar 2025 09:41:21 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D859801CF
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 09:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZJL6yP8LDXxt9mIw5DQoNrBizHteWfXjnCxfFkCpyKGrm6am9EKB6lj1/SDUgh+S84cxrA3UvvApx+73DKlEKfiYzF3MwPDUB5eRe9iyzZAbLmV+B0k5q8mN51gzrOEQpYBkUR+k2qRcdGQdBCVw0wQCMS+Wfci8oMJ9zX2qXMLk8VSF8Ed7ZueSan+6EWgaJ7qXGoMr0UcvTQWH2DcXFZMgCUpHSgMLLyz9xgVp75NjLHtvs8jxDSAnWW2A7OR6CIIkvw+U5qgXv8YChN2mSmHrSa21d9+wU+EypKaz/pkMXFyZFdaGlC4BJJDfUuddgouVg7hVpodVmqxqI7rqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VokLj4ZjN/gDJYbelDCYsdHJvt3648tMWUIC3SZkrsw=;
 b=DDnWV83bmu2/2CFB5Yw2ZpPzrWYWos/S8PkL5c98eS/qLWI3rLqeatDAfQTJ3+bLbMPCygUDFLzTu975U4lT30W2jI7GCU1UCJ3k5LHsDDjFaEG//NMWySaePwWzYHvO8U1Y26ooQ4Hmrmka5LOp6D8X54HdUTUrUcTSc/dZ1Amrzngeq4gf5YqKQ65WnldNf6cImOtaLuVn47Mr3MfZEYU9VOLVcQziFgU5rVr+g22MyJETaOb8hceR/5ff2vwBMQ/+HAN+C7JMI9qOX5SzZyWIRQgdYT+7GEiGMw+BcoBJ68SxLfnJ5CYEGv4U8gb/ReWgfDFYOgIbPK3gyXyLZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VokLj4ZjN/gDJYbelDCYsdHJvt3648tMWUIC3SZkrsw=;
 b=A/uLbrqQHiTABT0f7jLxxoblAkvU3c4T2YHl3Zxhr10LeU9NefMjTlVLiiG7e8jiqp5cBOrBI+WGXZ8TjBs8aKJ5pvFScL8BKeEF3Wm6x4rz4mBEqZON++nXH0TmAcDuv3HCZwcWatj/1H387POQkv2gmZV6STPXtVf46Cp/vE02DpJh39xV0GjF1wOPaM5r1nVfGComtz4V0X6+tgTyBiHAHsPp2Ibgmf7T23oLnZ6KxK2woaCiPZIbPDWGR3P57+Wlml2mPxJ4iPW3tgtWmhd0TfnksVc6gfwWeZnmPrkvl9tK82b2FE+IAWGB/8r5pO8l8cFazzhi9l1xe8Qy7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by MW5PR03MB6958.namprd03.prod.outlook.com (2603:10b6:303:1a9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 08:41:14 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 08:41:14 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: [resend v3 12/12] configs: agilex5_defconfig: Enable i3c configs for
 agilex5
Date: Mon, 24 Mar 2025 16:37:04 +0800
Message-Id: <20250324083704.26259-13-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20250324083704.26259-1-dinesh.maniyam@altera.com>
References: <20250324083704.26259-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0106.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::47) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|MW5PR03MB6958:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a000b54-1edf-46cb-f099-08dd6aafa2ca
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1+/wG8Cq/nmlrxkGINK10DmLHQ0AUiMhQBN11mIwzPZzeRqM3tTWigfAtQ1g?=
 =?us-ascii?Q?UGXzfwzH2AcWvJB5Pcx0/vikp0CKs0xJoA8Ag65TSCG2RWC2JevClDjwAYgm?=
 =?us-ascii?Q?XuLhZjw6OOhNp29reubyNz3KPmTk6cEs9QKQWwIhNSFE5NJTWpJXzTDZySaf?=
 =?us-ascii?Q?m48sxhzpgbvWMpWt5n9f2O9ARrniKOLqt09hby3r+EkzYiOA+Jx5ZxKlTXyu?=
 =?us-ascii?Q?KXMF+l2ptcpXzzbmNqkDIKwzOh0TUWTSFcOmjqJ4yepUMIKQ8MZefVJUsGcP?=
 =?us-ascii?Q?lNMU2FmX79c7a5k5wUVdUnCb4ItwOpHwik0h8610KPnp444kmd/gq6U6TOBP?=
 =?us-ascii?Q?u1+Z9SrSl/2fj7GRA9FpvU+gkSgM3dYU2TowD1eXfcPk2+5WJqgt6cbhLXpM?=
 =?us-ascii?Q?HQIRDbF5UdaXoeaARkYd1qYGOrCZWDlpSsPeKhY4bq054hwFNrsABooIfKwV?=
 =?us-ascii?Q?mXW3TXjiRM35R1YOpU/Ah3ECpNL/H2LmsPfI4kPpLaudU+w56iRg64lRV10b?=
 =?us-ascii?Q?PcBThd8TSCz4M8bNsOkdwFiB22vfes17mlSHNZ36EV2r3fD9bdc813/Aw6Hl?=
 =?us-ascii?Q?jVgDzC0jx2fbX5cYri17qRiri8GCe7KD6lO3yUObatE6OJFmabz+MPXY9wPt?=
 =?us-ascii?Q?Aak6viXR1zEWEXlP7iL5t89tBoDv/ynxsQ9hMXv5Bf9E6FPk0ythGRYKxIlc?=
 =?us-ascii?Q?fj7j+zvZOPY6FMKsDi7M1mqGwf67oYqO7eh6M6x1t+SRMlHYfoFNn5lExSt+?=
 =?us-ascii?Q?c6PSUtPUCTU0Fr16K4Y1no2PHqis2X2KZhsTQ4snjzVa7MlU+fgT2IJ8H/Tv?=
 =?us-ascii?Q?EgDPu5jmR739fgXqO7vwP9sBqbZ1seuaKGWYFHePcKYO/cUTYCeOdURPC+C3?=
 =?us-ascii?Q?hrS7SY6J9xuAGcInOC1CDnKGhiMbzchKpYTK+aXitH+fqVpYlWUcqrID9nH6?=
 =?us-ascii?Q?VilmEgz+j8jFYCTETMHvTXgkMd8EWNxO8YcMGb5MwyBdl3fkaKNqWEKBG43w?=
 =?us-ascii?Q?xmvExVqD2aGCwUesYOWV1/ccrzGefwkyDoUbyw544jYeGpqfw2lnucTsS992?=
 =?us-ascii?Q?v1hl3pUPiLQm5LeXFOYwPumkTZGg+AsJdFL/+C8BmE/3iOWzX5Uhvugh7bxe?=
 =?us-ascii?Q?GEFTDWUS3mJ1vMkNDet4ki1ZDGSDCq2LDJgY01qvhessBtn4ejMnP2TVjdnI?=
 =?us-ascii?Q?fBjvZpTm+8KFGsxLQyYRulf2MmX0P4hlIzQc0dmD4LUtKWrH4RRrUX99PsMx?=
 =?us-ascii?Q?wvwFBekqNbOhEvbuJ6wtGp5AUHf3goQ9Grp5UWCBi59BhAb/8xbSy19QQQ2c?=
 =?us-ascii?Q?2/GKwB5OouXGdgkkRnhksX33bqTPybGPP9qDCuqODqARxTeHdTuTUmcMVLjP?=
 =?us-ascii?Q?oZ1nXFSXfKAnA5jxLmLxh1MMLxtH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ERq8EsLoh5jbCwVhzFZM4KaO5v1N0Zk/6VHFRZdvrpwaFDrNlltbT/4ZqVA5?=
 =?us-ascii?Q?1DS1bdDXYXrFeypI7Yp4e2miG8q4fSEf2+/k9IoYqViRkjfc3DmLBdZN05U7?=
 =?us-ascii?Q?4xADP7C44CEtpSCTTIDq9Q+GuxHAoKQpIKSNxAPPSBfKJELw9EoHYqs/kqhX?=
 =?us-ascii?Q?hnKKJxBRZKiQZCDaciywYzZ+t137LcJpNGeelbEeDAui33/Jke75XCHnns3U?=
 =?us-ascii?Q?+8jKQAHdMQLIptqIJ8gJ8itNnxFpDMABbNl4wNEx5SqEnITLfVYmduNQ160d?=
 =?us-ascii?Q?du/LrdqUZHUsZ5Kr5HFqVbXyFY6vmLHyN8xpBtKQoBxL29cT+L42KyKXF2aN?=
 =?us-ascii?Q?oIaUzoYZywetAKcgJ2wtf+nu7ItcAeekgcIAnEXYCItiEQ/z4QmyQF763jlR?=
 =?us-ascii?Q?tTdm42oEmIYDfgAhA/SAlBYxHV5ArJcV/DqxUQgQyUnmdG334Z3mE9xDXQh4?=
 =?us-ascii?Q?jVmJjI+gyCtDlZWFK1AVOzq0q8pp9h9deRBue+XR7U4aFBnhSRQQtYBYi7sp?=
 =?us-ascii?Q?RZF6TZ5Ins8rIwNfsvYOp0MTJ56UYMErIVvy4EmNuWIhqPJtlE44LhwL+IxV?=
 =?us-ascii?Q?S1kdKVrjBygeEUoGBrH2ziQHa369vsu8KOEWs2HEzxOzjB2HA5D2XrEuTLJh?=
 =?us-ascii?Q?g/Z3Vifw32j9qxZqlbxODf3yUQmli3peDiC8ybI1l/dzJr9TajUZuH38cuRz?=
 =?us-ascii?Q?KDGvc2z3aL/4CPDOpOqvi9jTiselH7PdpfdqANPf3MhoWzDHPsQtfEBauYSv?=
 =?us-ascii?Q?tXe/UTOQQDQy14MEY8tX7msEvuKjw3QhBeal00bqawdTqPQ/dVO74UzQdQx3?=
 =?us-ascii?Q?YCEXLK+tRHrGhfXVQVlLiO/FJnFzqhqGVBmUQZtknNUQZqgmhJkLlGGrkgsG?=
 =?us-ascii?Q?SgZNGq0pnjV6ujPtekO1fXOqQa1W93F6/EDP4aQwbSy1TmPc0r8us+QZwI4K?=
 =?us-ascii?Q?CWaT/ul5r+JWtSC4nIrK/cbv/JMBAq4czNo9QWFmtTW5AK98fmZ9x+UodnpU?=
 =?us-ascii?Q?rJs7XKJ1SyaFpUn5CgI3OLRjLs8zpqZsBWQOiwRv8cZpniRyan/Exay8jY3h?=
 =?us-ascii?Q?zgTmpXHXaHzz4gubwYyUkWiYbczJlWYl5+usEmCPTXpPkQj2HrAmYMZyrEn1?=
 =?us-ascii?Q?sm+nJT3sYXnCnyhn++Ex39oq6Of7FfVFwiMIdIhE1xFACf7j2NniFTLceEdT?=
 =?us-ascii?Q?4Hhvbf6AgQIZN/cv2NhbfgkanFbPTuhHpRteYCItgQ3FAZQpd3u5+h+Oc1fL?=
 =?us-ascii?Q?oNQ+zXzlAUQHil+i+vP9HNmfxdKq0HifE+mIuEN2IKae2U2kknNEO7G7OzmS?=
 =?us-ascii?Q?CkY8IsKjgCbHW7mWT3kCYI0qCXyiUqgiV9oCqFnfxi7vBn5pRhGK5Os/DDAb?=
 =?us-ascii?Q?8eGkE3fFuvLeY6UmLsOJLvHqeluwdaME7Yvrh2GPG9yok0NUL2t0StbOM5fX?=
 =?us-ascii?Q?cblCJyK/dgbsyCNk6DulR3lw0aufq60nUjI7V39YAarFfXC1UaTBpvxRPTxn?=
 =?us-ascii?Q?GzIAAu7uxapkYMWNd1bSshvchWN8NgmLuOGNduakmTRCALliXtvWtckvUACP?=
 =?us-ascii?Q?dKIQSyRv0ldx6ScFWFR/SPBxicif7rrEhGlf1AQaWt7itVgAc21cEtT8f9g2?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a000b54-1edf-46cb-f099-08dd6aafa2ca
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 08:41:14.2159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIyEo2e2MD7ucQKjb4fIYjVfziMA2ly2zqvGs69/IBpkZvFkhYlMoxh9D22irWHilCDPFsRzBG9FsEolBxnZgUDvZlZpbXTEScY6B0EumCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6958
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:09:48 +0100
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Enable configs for i3c in agilex5.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/socfpga_agilex5_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
index 8577ac610c2..87febc9f4ce 100644
--- a/configs/socfpga_agilex5_defconfig
+++ b/configs/socfpga_agilex5_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_NVEDIT_SELECT=y
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
@@ -66,6 +67,8 @@ CONFIG_SPL_ALTERA_SDRAM=y
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_DW=y
+CONFIG_I3C=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_MISC=y
 CONFIG_DM_MTD=y
 CONFIG_SPI_FLASH_SPANSION=y
-- 
2.26.2


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11ED5C369C7
	for <u-boot@archiver.kernel.org>; Thu, 17 Apr 2025 04:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A1C983039;
	Thu, 17 Apr 2025 06:57:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CU7AxgIK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CC5C82CBC; Thu, 17 Apr 2025 04:20:50 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 387EA82DB4
 for <u-boot@lists.denx.de>; Thu, 17 Apr 2025 04:20:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHc+tsX4Ik9CA3FkNXJeWQ9ZMASZZ16u72IeEvlz9brB0FcY4AUO7zVVgNiz15Nf39sO3j7l115MROR27XyRxdZFWogakodEKH9VROVU9PbxKnmNxEc/E4WJQ/whxWiGTgpX1+lQzijOWgMhbWuHnK01Dsdff8EDPb9Du+X7qFqQKHiMaHWEHsu6aVOaoOZpXbEsAcwiMj2V9bFBaIKXn64IDUhYe7ItEkxJxxLoQmQFEtMFhdk9FSB8StDzwgiF8JS0w7YQwCH7PQe884YI3n5En4lhLxnQl/bQXJDAi1K0d5tZWUkdsd28dAofdbZ1xFGXzkhJYc6cF62DXbjzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=C0q8x0PukZCseizKWgvLSfm7Ay2W5rZkYIBElvtL/XKWsEo5qBvQTZkXxeaTQ1AERnKucmvax10ykru1DGJxLkQzl6i0I+NNtsVpads6Eur50hvVB3aLeefWBTE+FRrOaHQSH+WXpHf2kkuFZHdvF1FxjhpEP/lkRbnTdPmoPZ6AUJT/7EWPS8DPIkG9mzbBhtKMJfw5T4gIUNrMxhNZ7CDVPY2wlHtkra9sHc+DiOstZNxhadkphnv5xMRcrzExcnYCTBNPgIQwpMAD382lCUpaSGalueOcAKVgLNiQUbASIwgO8N4/lyX8j1R/QybQWLL1HQgI/XWx803M7gPuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4MdOzS77KeHxgH0Ze0eKNU4Q3JDbr5hvMtjAZqwRXw4=;
 b=CU7AxgIKY/n4/cuUsyZDZX0AKbvIB4V8Canuf75/1581LyQRl8gD3v3UVb1yxUQKmDpsyXNIMtn8iafNCJDiyeudyXHSoqnSHEWdaF1kQOjB7tLsav/UXQSzsQQ4oTL+NoVEZBou6vV9rot3CVZ5uciCpaa87p0uAzTjtlfH9c1BlijY92u+gd6rROP6NvYw+tLrusrsJPj9J1WPR03OOnhEHZ93ea4ji3EAs0aSpY18acmjlZUTKfTYaeYK3YgnK+tTObNUjvcXEhaJ7Q1hQoq8hDvObidJWSMH+ushHH5zq5C72Jf9AgjYNddsH7dxT3ilOpqqOMOdDJYl6jBeHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA1PR03MB6370.namprd03.prod.outlook.com (2603:10b6:806:1b5::16)
 by PH7PR03MB7414.namprd03.prod.outlook.com (2603:10b6:510:2ef::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Thu, 17 Apr
 2025 02:20:45 +0000
Received: from SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03]) by SA1PR03MB6370.namprd03.prod.outlook.com
 ([fe80::94d:7001:3263:ab03%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 02:20:45 +0000
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
Subject: [resend v4 11/12] configs: sandbox_defconfig: Enable configs for
 sandbox i3c
Date: Thu, 17 Apr 2025 10:18:39 +0800
Message-Id: <20250417021840.6212-12-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250417021840.6212-1-dinesh.maniyam@altera.com>
References: <20250417021840.6212-1-dinesh.maniyam@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:217::24) To SA1PR03MB6370.namprd03.prod.outlook.com
 (2603:10b6:806:1b5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR03MB6370:EE_|PH7PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: db3bfe46-5e58-4eab-c029-08dd7d5675b8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9hF3Sk5d2CcWAC8wdpdK+TLHJ5N30apJzz+4AsbjriJ3TeuXYjg2H8AqfxV2?=
 =?us-ascii?Q?xCuYmiRGEcd4A/Z9yhSUZTFpoa7ICC+cLgBzIkZMqXgmi/tmnaqscMHGpijD?=
 =?us-ascii?Q?cxGTzx6w2L+Il8mSmWT7uuHBF03Mkt+PHywCLJ52qoZctHYqbSWjLDfMMG6J?=
 =?us-ascii?Q?3HSxLJ4hE+kucEFQwLg64/ffRBy8V9COEH2iQDtq0Cxzz4p85lCaGHER456L?=
 =?us-ascii?Q?N9Snwor4zXLG/OYVQ5pohF+fas8aU+4O5ZMiEVAxZir1MssmNZdUKh2tZWDS?=
 =?us-ascii?Q?ojHlktXJY3y5pPxF9LewXVeHR3mIDgtpJfWm6pGmDsstWX41KpV5eOaUlzLH?=
 =?us-ascii?Q?yJ3wMEHNJiHvAOgXbDMUbvMEuKiLB8YyL9cbRTnc/G2wwQmAfXIWxOsnbg0B?=
 =?us-ascii?Q?yAbqQRTqfPy7xko6kN2krRDKDJ181UpDC2AFGIvVcUX/tf4J5nlhnF51Ei0h?=
 =?us-ascii?Q?xF504p4Yl64efDkVa3nKecPgCoSqVa/5dFpomP0BpwhHkr1OH/HX0zMaMPQe?=
 =?us-ascii?Q?YdDA6cMJNOAwTbJXu9zavwCPAxg4OL6pgdUiZb3GruX8/Rc2viAdqa+7QPBD?=
 =?us-ascii?Q?17u0BunG5UXWipL4DyCvrjBVixXDauVTSGufZ4+YRCESxUbJ2HLqqrkuwN7c?=
 =?us-ascii?Q?in72DGq+CrYIMo3mdLx9Njjmyw7Caxfd6sfELD7ARjbQH0jzpGnG5W2137Kf?=
 =?us-ascii?Q?voZhFRPCawKUGa3KiapCweZyd665v2EGXneHui4P7zLUMunDT131pwC322Zk?=
 =?us-ascii?Q?owCw90Z1Y4tqloRESpFnUX0IvfPTPQYv/D4idHQX13A4KhHmBqOpCL1Qq5Dr?=
 =?us-ascii?Q?769tscazQ99XqMLLO/1v4MoCoz5PCDjNgtrJe9IEAr1WrWSmel/vrfW+XBbO?=
 =?us-ascii?Q?4swE9mLWJg8Yko7oBdvFc2gy2iWT4zjiDt0OKchNfCinrz/ujY29fqlDAf3b?=
 =?us-ascii?Q?AQ2oSjavnBFTldMWOvizR+g4Ay+d/oHAMSKQvOlCsPG60pkqOYhftRI6QgX9?=
 =?us-ascii?Q?ofeEQf3gDeqIiLxaeRx+Fke0st8XfbhazAwixZkCNM3eDpFM4IlpIjXoDpOv?=
 =?us-ascii?Q?RVeU/WFuf9ENJZlIoaqFGu5VaxA0KaHrxUq1LqV4NWVRKm03b15hEHF70R1C?=
 =?us-ascii?Q?ZIqvPw1B6MGJDPvScn0iX2qLed2p72m2kE90goqobeokyMQOPYdADrdtTv9U?=
 =?us-ascii?Q?C+8f+b345WScJV/EtYkI0cEhMNKx//ebJYIBfnVpf/XCdYGLyoml8y9hhEdA?=
 =?us-ascii?Q?BIn70n0jGI5j8N42Zv50OJ6ceOWxfZgDfUAa56I0zS8QR2evtcUMkEeWFulF?=
 =?us-ascii?Q?39+rg28djSww/X7oQvqK1FAuFK3/CJ3QNWngiL7FFWUWwOIdXv86wc7iORBX?=
 =?us-ascii?Q?I8BBBIGygTdckZFOTBufNLL8dQQa1K+HJ7eOdwM2KKFpQd0vvjBvS7zUVMnx?=
 =?us-ascii?Q?AIg2cPnadOA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR03MB6370.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NY6sQ2HbyvNRMoCsO68+ApgW00v0G4ZAnRnwlKNQml7jKVlvTcORMYpuiel5?=
 =?us-ascii?Q?fhN0jABIP5Lv5UNGjVvqOjlt3aNn8E0C2iyMHtyoKhCXrkm3pNt5X967pprL?=
 =?us-ascii?Q?3SOb2BT8lditj/387OvJbqDl0O2VBdHwgvScF7BvoPD2MxS7+rGmkPRjZc1l?=
 =?us-ascii?Q?tsdD6164pQjL2Nqx0ZZpsDOVC1q0TXUOVC99weXQOLXO066i7NCiwnsP+Uqw?=
 =?us-ascii?Q?id6ro+nq6IoHQ0dYJBYwy7t7qXkPVKPUgGDH2rkF+NMb4RUB9XgnYZ+p/siw?=
 =?us-ascii?Q?cktSqbi+MwsHoy4XdnTqa4TG635RtIrxBy+JU13BjMuEsegASgWMIJQiw0fZ?=
 =?us-ascii?Q?2a6e62lCM6bcx27ngBLurURGbAUHJzvp8LNzsHAOE4L5UhT9LIpG2nx4jugM?=
 =?us-ascii?Q?w2vtaCxomHmYTcKPPMAbq1pllPB4Uhy2k9DFFpEOx+e4c7U0llcP5FgoQfYu?=
 =?us-ascii?Q?Vc/Ace1MmzMeoDAYNOc85wH4KGlZlLHLc6mrD6CXSXaeErkWLiCYAuTxKXI3?=
 =?us-ascii?Q?T5glqh1aype08K1IsKvKFgXqvAdRBJgXR9I+jRl36KDg3P9ZW07I/OJdeglC?=
 =?us-ascii?Q?6j2WJ5QZW9mEgJTxgVL3YopFzFMw5SPOZEBDYg/gIJNKWUfz8+V15+3Z6xQe?=
 =?us-ascii?Q?VnomsvwNC3d5I07n5GsAlM78j3m+7uKO6LiJgdyRrXCat3HfrtDMyr635w9b?=
 =?us-ascii?Q?K6L2nzngDmWgHX19ZPgp6CHsdM0EHcSj4npl1GP19vDJqPxyDcQjGcH894vY?=
 =?us-ascii?Q?+9SgI2jj4hxUpIgENzEeBOBhP32nNkveMUw0IaCf8TQh75Xz8RHfibpuI0xm?=
 =?us-ascii?Q?fPgoG/147naBG0Ot3WT11o6d7HTWvO0qHlojjCvTZgRla54OjolcHKqIO8Ci?=
 =?us-ascii?Q?QZG8hyzRAA8PRaP78fQjLnp0itp1thvqq8JIq1sn4iDc7LZ/0xtI9jOHO1cd?=
 =?us-ascii?Q?nTHVP44SJQ0/9OOjTe+7ZEdOMxadZzKouAxZPOlBlJiS81m0ltTBd/RHUdCB?=
 =?us-ascii?Q?t0B4VbFHQHo716HdryNf/jUiqINgWd2YmEsVeP52hDfwm3NBB3RUClNhbycI?=
 =?us-ascii?Q?VoQnSYePhCz1iPylSDC7Z+ZqU9D7wg970WGbdKz5eo2tIjXAGN/dx2E1PMje?=
 =?us-ascii?Q?xwwWFFA66JcEJl4xbo9FffQOLQPcSoMssOT9l9i9+FmBpUl9DERyujZQilPd?=
 =?us-ascii?Q?Z7G7mOM/ulodUSiBxIq/++oURiSh/BGK17weWvU/Be3G6hDxYDhLIhCrpmDd?=
 =?us-ascii?Q?G0RbBKucOh2dqzuYwTH1Z01bLr17rlW2hPYG4KThTAAN973yXpYby8BxSBNc?=
 =?us-ascii?Q?0IMNEoL9jtlQWhNU2YsMVQe75Hy0hgIQfy8IqaaWXcduoEB5CWQy/qUBJxdE?=
 =?us-ascii?Q?6Job7ld1ZoCJDACG04CKVCKw9dO2HrOq02aAQO+MnV8pNz3Eg10OUCE/yO3Z?=
 =?us-ascii?Q?szFcCjf8zF+vD/2dIB41DIbNFfXb9Kim+c9vi6z5BwA12StoTheQgw1TSYva?=
 =?us-ascii?Q?THrtinUKJlXj6YMRrpZFCE3ugQxke43WACddxmx2CaKFqUdNnGE52cOMlrCv?=
 =?us-ascii?Q?4J5I6TJnenJBkN7uwi1fndL7WPbViXLeVXoRKWkrrHoIH1l6OaZ49lgQekDA?=
 =?us-ascii?Q?hA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3bfe46-5e58-4eab-c029-08dd7d5675b8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6370.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 02:20:45.4789 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9umc41F9fjJ0DFkZ9lFWW4tO0SvCOC9wFiKNMhlfRKnQ/0WFbrUu/daDcTy2Q0ZANmkIJxnE9f48M+4knXsGdy1CpuhGrP/hPPD26hwCpFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7414
X-Mailman-Approved-At: Thu, 17 Apr 2025 06:57:49 +0200
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

Enable configs for sandbox i3c.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 configs/sandbox_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 861a1f4cd90..ba98cb0ae99 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -85,6 +85,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
+CONFIG_CMD_I3C=y
 CONFIG_CMD_LOADM=y
 CONFIG_CMD_LSBLK=y
 CONFIG_CMD_MTD=y
@@ -206,6 +207,9 @@ CONFIG_I2C_CROS_EC_LDO=y
 CONFIG_DM_I2C_GPIO=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_ARB_GPIO_CHALLENGE=y
+CONFIG_I3C=y
+CONFIG_I3C_SANDBOX=y
+CONFIG_DW_I3C_MASTER=y
 CONFIG_CROS_EC_KEYB=y
 CONFIG_I8042_KEYB=y
 CONFIG_IOMMU=y
-- 
2.35.3


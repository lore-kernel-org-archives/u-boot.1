Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5C2CF9C6E
	for <u-boot@archiver.kernel.org>; Mon, 23 Sep 2024 12:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE2C088D1F;
	Mon, 23 Sep 2024 14:11:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="cAHqL5FV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 556DD88CBA; Mon, 23 Sep 2024 14:11:33 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640F688D27
 for <u-boot@lists.denx.de>; Mon, 23 Sep 2024 14:11:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MS02Xw91NizGZCAN8LU2r5ZCWVnLaIsNmAKNs1Ao3DGCLMVuank+g6mmktpASRuNUCWLEcaSY+JMNu5IgQ5bI5++HDfiFFVraxnxTFkRzS+49/86wX1mx6ZFT3SlNOg2hP6jGaYJso4V7BMsgH5TTb8c8FDelVr3BZvawek42+3sk3jLVxDMPrmjRIViCJ2V/3hOgFyJNe48s7WiOQOkuIsxYjBj1ymCx8ok8gL+ZsR3Ko9/bz5JuL9D/jkbwyvAdlD/Yh7VFYtp1IsXgBq2nhdboPqbXfOS7Lawg/Nz2sDNXlYR9grGqNZ15A+Mrr49WcbXjPzBQmwcXLBajwvdAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2A9IYio/qFt4zKPRyxmQ6OPvV3HvbTkt2kLBP0RsRw=;
 b=WafYoNY5RREKhysL7wdsDzknubEjAr6NmVvvqJbcdyJ9HF/0HSt+qZ0y1F4n7911xVf3zIW/JVpkC7N+6VENXs+Yj+higw+3DWS3m8kqebvuleaahyK2gjf3bDY+sGEbWef+ZAK9k43NFJm7K+I+14xXVPdZjOqlOZEVcjRdU/y16vodskZjbHZZryDmMXj0rTEBItYOA6lp5bI/IJgVssrT2u+TGtgsWRzPRuY+EosRB1GsSIfGJW3OoSRpyTAsY7uvQuE++npEvc15eaQ/5aLbIh3kJIdi4BCvpIO4tjNaxskarvv5EOi+uWLgP44qCh+xhliMu1ZiBUnsgD6fNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2A9IYio/qFt4zKPRyxmQ6OPvV3HvbTkt2kLBP0RsRw=;
 b=cAHqL5FVvlFmnD5cXPiDlb9SM1tPchcDln/rAz3DTq30KFaCBZ1j8Gl/99vO2QJ4ncfUFZT3q5zUySewrmw23Idd+6L/HojpkS769KUE3t5f7oICkFNvcYQYo13KYgWhADbhX/bSN9HKsaXbHXBAvVGBh4BhaBeIhc+u1UuYO/XTMQ04Vs7Mx+wchgtDMoynDnMswY9evC4RRanvDwfqv4RbDw4sxS584qFD46RTGtntUTDgp6GtWhqJn21SQ37l3nETTDhzR/n4Xa9QkL6l8AMdm01UJsUU8hZbm5RI1zPWPpeo1Qjw0uv+hDoI8V0RV+pz3qv/qgz7TzZRAeKJUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB9928.eurprd04.prod.outlook.com (2603:10a6:150:117::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 12:11:25 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 23 Sep 2024
 12:11:25 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, joe.hershberger@ni.com,
 rfried.dev@gmail.com, Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH 2/2] net: fec_mxc: Skip recv packet process when fec is halted
Date: Mon, 23 Sep 2024 21:14:39 +0800
Message-Id: <20240923131439.28572-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240923131439.28572-1-peng.fan@oss.nxp.com>
References: <20240923131439.28572-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GVXPR04MB9928:EE_
X-MS-Office365-Filtering-Correlation-Id: e5f49f92-74a4-4756-e9d5-08dcdbc8d829
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fXPY92030e500EXxW/CqZ0PWErI5kCIxBlNDK0VUw0MWGsVuVpsnbdKYcqJC?=
 =?us-ascii?Q?I/9rfIJNBBIFSR1p+CTV7ydyaL9gJ7hlE/zkfAp84Oq4pNE7DyxT2Br/hF85?=
 =?us-ascii?Q?Zw4KgNmoEn2+QTYIVfWVHi1VsLCs8QruTkZlT7axjVEvpVrg7V8J2CXP9bqi?=
 =?us-ascii?Q?FNX56rgNpetE2QOoxNbR8/yVpE8rLwhUYXALxUqoR/QmiVh2zYtgiK9Sq/I0?=
 =?us-ascii?Q?MhKLK4fdV3XeOPbsF2l/ipsGG8Hj514OpptGjBSMiEbzdLkT5fj1tA9uVRzt?=
 =?us-ascii?Q?DSmh6PV4G2YON+L1tOnrDWDxOGxgnIKEjkNJ+sZDUAnwDqOF6zLnZGFHkKfI?=
 =?us-ascii?Q?3f+tTKkWKWe98ReZNP3Llxm9MDpBBtpazdcZrEeCBiu6MhPGkybdmtpZPtPi?=
 =?us-ascii?Q?7oUPlyTc8a46HP+tkwCF6CTZv4trimCS7CJ6CMzzGSEm6gwav8Z/RxFNjj3Z?=
 =?us-ascii?Q?1HAHPOa3AR7B9YzPYuxixWk3V/T8auF7ehvXIP4v3c2FLuOt3OyPpwZ0YNxF?=
 =?us-ascii?Q?O6DKjWxRZc4TH6WyZg8UB0O3was3+4feWJJbeJ14vMV3Ig6bxLkUIdrzjs9V?=
 =?us-ascii?Q?42A7TT/670KA+n3aMBTNIfl1ayAITlQx4ngZCI29OYL+xdqfAgm31PQzhazV?=
 =?us-ascii?Q?nxlew3YWT+bqLQ6ex00gEUVBRa7qy1Ft0csb+uD41nNb3lTsgUMzLUTIVQaO?=
 =?us-ascii?Q?IJgfJmI60nGceNcINiXDfInWmPkv+p+6mNqfkVKPS9PmEa+OjIwRJuqivZdD?=
 =?us-ascii?Q?sz9gjk6UTBoY7DzY2N+ESsNJFj73knZWw4V+pP/khfxF1zdC6pHVLURj8xDg?=
 =?us-ascii?Q?HYgyal0zOy1TjqSd1YdwlTO+9LxMP2ZD5f6YVtdpAYuXEAUYXqHY6xyUbPzl?=
 =?us-ascii?Q?JmsDhNq3H/2zBpBlnlAYRDH2WZ/gLA2ecz3+IZCilCAc/L9Gvx6KyJ0e1E0j?=
 =?us-ascii?Q?wtNxbHc77kuEFWaGmC2NTPMjfRs/rtDNCgXV/Ga1mDgg/ZjO5u3U/xjA1Lyy?=
 =?us-ascii?Q?xfaUxCb9AiIaxquh3eIAv1+94X3jAxg3TGOL20n1C9Yxpk9AQ8zdV5kVEGvN?=
 =?us-ascii?Q?j+0SMXrVqHKOvJrc80trvQDK4q6PTKQove7Hhe2lVIZo9hH5RjSke5Vg4kVX?=
 =?us-ascii?Q?i8fqrQGONr8fwMvwSI5iNRQbUtmiRHIcGLcHfI1rQwqhOWjgCEEl+R9ADX1l?=
 =?us-ascii?Q?QM64k4t9i7OupdM8epfIgYJ97LUmEWyb17EYRZLd6UwiUPHbeOM/BcbaB/8A?=
 =?us-ascii?Q?k+X33QpQusUySUqbf1nbQFvB2+E56ueQr+iUxaJRMgNv/lol2dRuxkmnUgGV?=
 =?us-ascii?Q?vF1mstuF0neaqp/GvDP7w53W9W5WVgakvr7k//fTsgUfKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gmSxKgiecxSn4xD56QFnKPnNVHlGpuAS8wnMq98clPnHrrYWLifqqb6Z4pFH?=
 =?us-ascii?Q?jPXivfUU8XZTDrFC8Lc3zP7Y69fk1FtuVf9o0SLmFjn+OoJR4QKBpWXHSvvu?=
 =?us-ascii?Q?cKw7fN8iFlEvnJvKl2DYFAmiPnzJaH/W0W4t+mnvgONedNTHT9Rb/KWPLsKe?=
 =?us-ascii?Q?VSiX6suhJFTlnqmAQirekH3jgbJiBXcx7MGYLKUuc2+IZQQkb+ypxdxegIO/?=
 =?us-ascii?Q?MHACAR9fADlcQqbyU9Fjl3UoRKML7A+Mima15QeajreoLPZ0oCVPPJutI5l7?=
 =?us-ascii?Q?eD3mtPxUAst2wcN2eT5YmcjlpHQlaKYv9HFs6KF0mFpRWeBgS5wkq+nV0X3s?=
 =?us-ascii?Q?0iIDohSiz75g7t9nXHrNf6c8QJp8IBK/yLAk/j5mS+CAd0hlnOXyTHVvizlS?=
 =?us-ascii?Q?K9QcHJBSY79/mHjrdzEWIz4WPimOVRxEDGPa297VedruG5NmY52Q8/4X2K4t?=
 =?us-ascii?Q?NxVgVHh+jAMYr1GaH9/fe4PA7cxH0bnJRgeeM1lhZ9bLvIAjgGunaieYt24G?=
 =?us-ascii?Q?V5kxH/TnqfSGFy76xcW+8jZypZhXMkaYFmqZhUPOryOKE35uMgP087D8Uu5G?=
 =?us-ascii?Q?3ReovttdHz3+UjfN3Iww5q0oJ7UXlU1XjaAi4q9tf5Tej8/7X6l74RH0RmVi?=
 =?us-ascii?Q?1KE+2E37ev4G/4VMI1j6h2Wji1A9neZCdLU2ybzP4L+Pj3Bybj2KI6YzzGow?=
 =?us-ascii?Q?eYzh1KouLJ+so3oRT7ek0mQlVVB7h0TxLS6NDZWLCB77O1Hx9iza+vPRTToY?=
 =?us-ascii?Q?lrf1lTlMyjqTk0oYazDV83gALz74mgEGaOBeQbOI+6EtJrFyRcZx+q7uN0QN?=
 =?us-ascii?Q?4D/JovgDuozXGJiOdt6NDK+ZTZinoUJauITM4sg5v09uYyLzzpM8r/Jf4xW3?=
 =?us-ascii?Q?e3u4l2QHFr3vc5KRkahbakIh5NI9mHuWbmyHwkKJ5zz8W7MR2xFH6iOshO/R?=
 =?us-ascii?Q?RZdQsCpI+IXB5OmrAEoggtkxyC3ZFOTothD21qPzoYOIu/VJhV4aKkpHTKUi?=
 =?us-ascii?Q?w2fq1AhJO4fNs0/BeHSLq+KCgLgV5y3CB7YzXQhZtu0QFgYIrrSp/Fbb9Z/N?=
 =?us-ascii?Q?qAQYV4M+awdARbWz8b7n22QjFR8P2qBrXLMiGXJAl5LohZwopicygo89M7za?=
 =?us-ascii?Q?VX/T4lLu8t8Blfshkn8AB9b8HE82PkiX/Bg0gVJm9kLaQ3Dc2yN+913KxCwQ?=
 =?us-ascii?Q?9LYdIYjjnvkZf6YAfTaizeDw3lzmmiz2XhJVo6UzzSJTsM2Z9Ssjeik0v0Ky?=
 =?us-ascii?Q?pyHxPwlh5bBLj+Q3sgC4OL/SxhPqVQclKS+JpPMM3tPsJUmGJ0QAGvoEQmLu?=
 =?us-ascii?Q?m7GIjcbCzfg9px6psEVxzL1VowHafjYfe8KPps0sBDwrGeLcMkW/dSEG8swM?=
 =?us-ascii?Q?45wwEAZd2itg2VefcuCLhoOMZjlgYvX+1j9UFsaZQ+Gi3U8n1maZ0ZFDZNwJ?=
 =?us-ascii?Q?pp5WXpX2XzsdHusN476MXz5UjJmY5TTT8nUD3RooZmG30qeN9VD+U2K8lNqB?=
 =?us-ascii?Q?itFD6UWQ+/3KwmlUUFWuhap7T4WiDS5zs3ec8+OR2t+ZJ6otQUpyxHc0W78p?=
 =?us-ascii?Q?ZX9K3U6jk8x9j6C4+TfY74UTszU9BBIvWBjCU1lg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5f49f92-74a4-4756-e9d5-08dcdbc8d829
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 12:11:24.9871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWAs+IF9LpWzB1Y1a6+5J/nfARHQKvXGF4JAFt+H0mVThJm9M672JdLSTofj/CX1jlb5wzvRVNc1bVbJnlNRtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9928
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

From: Ye Li <ye.li@nxp.com>

After FEC is halted by calling fec_halt callback, we should not continue
receiving packet. Otherwise it will process previous pending interrupts
on EIR register and uses wrong rbd index as this has been reset to 0.

The GRA interrupt which is triggered by issuing graceful stop command to
FEC transmitter in fec_halt is processed in this case. It causes wrong
receive buffer descriptors be used by FEC in next time.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/net/fec_mxc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index e5d7f0f3e1e..14fea891f7d 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -818,6 +818,9 @@ static int fecmxc_recv(struct udevice *dev, int flags, uchar **packetp)
 		return -ENOMEM;
 	}
 
+	if (!(readl(&fec->eth->ecntrl) & FEC_ECNTRL_ETHER_EN))
+		return 0;
+
 	/* Check if any critical events have happened */
 	ievent = readl(&fec->eth->ievent);
 	writel(ievent, &fec->eth->ievent);
-- 
2.35.3


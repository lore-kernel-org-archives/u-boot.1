Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C39CD5BB1
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 13:49:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6101C8470E;
	Fri, 22 May 2026 15:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Yr+5jWmp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9105D846EC; Fri, 22 May 2026 15:49:37 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8023846EC
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 15:49:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kVnDSgW3IpYDNqXkG1TUYk/Ij1aU+tWgPGYMPLwhV1XOHP0CAwxFeZrZkQwZMUyInFMG7k9/bBlEYbzP4I/QbwNgp6ZMrjXRxlMZLyoIJMjMMUtvL8DGNkwaoi4pW4l68Z2vQ/Aa7v3iMbQQ4JUzSMveSNOyD/dEIpzxDJwhjz+etUkruN1Cxi70UxioSl1CvIqEnYpS3sRfei+FtSWNoazrhM6GF62DS0FMyNC8Phq1+uHu0HrtOcK9grFqVLzjUsk2KzAxLoVTcyAoUM2zMZiV7sKzmiTNWA6l4VvQ51QhLlUcRab2bwXHQueCLM/7gkafQvDf4c7zxzM1MDOJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfR9S2KqXn5rkYXfTNVpqbCn5B0yFzreTojGOseDfEc=;
 b=JOEgGVlJvXg1QhU20O2oi7cOE7qP2pXbtna4pS57mBsRjQBJW5HoSjzBw69ydLAwTJ7W5koSe1yt+aDPPW6hXx3pX5Yl+0neemr+PwnSxMtkS2gUa29Y27EfKaKwlIS8UhoR3pSs0rEPkoQqboG4QiMsedPpZXWlkK5PRyZrUJ2Jz8NpBCqn6USvhgJaBATlq/L3JxrzC/XFzjDtwtUqgr8HO5UwEcdH5IO0940alsyPZb7LT5sjCnsvbskrj3YLPYWJQkT2dHmZwb6v1Ot2EE6qUQnirf0QcZ+68pMP1tKw1PWXkKxUpOfMSoUKGpV1nO0l6WfO4RQQcETUyZjI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfR9S2KqXn5rkYXfTNVpqbCn5B0yFzreTojGOseDfEc=;
 b=Yr+5jWmpebYOj5y2FvYEku2pmDSVyq69PLQDPjwwhnLhfk0jrgiMe3vx4kk8dJc+uomEk5CP34IWp/U/Gq44MJD443u+7xaTksDNvDZW+4UIrMFsa0hHtgkOjNUakVbPQPb8LQcdK3HG7T0iRS33SNEq+47Mv3J7VMdojzJRSXMINHqYvSTh8jojP06Mp36AEzmEwtcO+o1N2uuvgP8ZhLQcvtWyD2cGvVragDTRxyKlODOKy7Ssy8AwaljMd5gbRs66Myuv+unTVm1WvuRgv42ilQNNtWBjOGe1nOnRUGlBzC6UgB41Pas0E6iGsmYWTXH4wD1u9OF/rEmoNnqbMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24) by DU0PR04MB9348.eurprd04.prod.outlook.com
 (2603:10a6:10:358::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.16; Fri, 22 May
 2026 13:49:33 +0000
Received: from AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029]) by AM0PR04MB12051.eurprd04.prod.outlook.com
 ([fe80::5839:856:e138:4029%7]) with mapi id 15.21.0048.013; Fri, 22 May 2026
 13:49:33 +0000
From: Ye Li <ye.li@nxp.com>
To: festevam@gmail.com,
	u-boot@lists.denx.de,
	peng.fan@nxp.com
Cc: uboot-imx@nxp.com,
	ye.li@oss.nxp.com
Subject: [PATCH 2/3] cpu: imx8_cpu: Add iMX8MP UltraLite Part cpu type
Date: Fri, 22 May 2026 21:51:43 +0800
Message-Id: <20260522135144.1643089-2-ye.li@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260522135144.1643089-1-ye.li@nxp.com>
References: <20260522135144.1643089-1-ye.li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0214.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::10) To AM0PR04MB12051.eurprd04.prod.outlook.com
 (2603:10a6:20b:743::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB12051:EE_|DU0PR04MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: f505d43b-c4a6-4c8c-5d63-08deb808f472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|42112799006|19092799006|18002099003|56012099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: Jk0Hgiy5g24g0ef7spCGr7qZWLrZvzN2MzZyMKWe+MvNlXKJQcbPcyutEHjZSxcq+pfOBKvFD7G94dwiJHm7/E6hKvYq3ILHog4pXyTCGHBppIlKDXnoEdjWgyjqmu8iA+9/4B+Axpwis+ze+4cj6Q2kNQrDkPcETe2hZVUVOn6fVdDJmFAi7h7LubSHa9hF1YlPZReyXRQlAznchR+rd47Pr5ZS6HlC95uZWfo7GGvPdBqzFCOPLZIHdc2FUAL++ko/+MCfqI0oR/OVyW/+D6x0KBnMIX9u6V+zXQPxwyZXNUKC+DsfWp+Ju7X3htGGaPEeA/bK9XJguTkUn+kFfgR7cCDoDeiAL/hLLYKVM1e1EubpMkr9KX8VjTx4ftPGdMu7i3KQhNJD3JJ0MsyehvmpN0qZpL08KX/EZnzP6dPKKBbNvY0cXWVMcSoZDIiTC+edN/BODrF1kXcUvXhu1S4ivv9sTugJXk/BYHLAU9+7F92OVxE1pp5L2pkVxndtHAR0nNUc60RX8X6gqAS/l6ajGSOUiJVDLPD96NWCzaj1uitKaM3AZEUVddqmJA0t7hVo6cHAtnk/COOKU9kI/yP9neNXZ9ROv7NsjKcNE9Uf6yUcpE/9m+LHhYxONsgWxGt62iLm/eWsDHVPxlY6wi3p4KS0yRg/bO+i/jO9LrUT2UpdjP9ChdZcHP9AIyJcfT6oP1nnmVvB/KJjdzh/fY6Ebc4ct2w5eNQX2iuqud2El5HzXR3nu0Y582xq0LfQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB12051.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(42112799006)(19092799006)(18002099003)(56012099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/Y+atyfSKWahJt3McTyKNiW330sLCBcB9EYULAbUh0kOhZCJBfDdW7zRPm1x?=
 =?us-ascii?Q?tveutGJrsdLc54MtOTmoe/el2rcu/EkVdfm9+n5JfYgii8n4syjzQAMCWfhJ?=
 =?us-ascii?Q?5Zfie0TCAZ+a8RzCa6KKm9da0AM81lt0PngNOLaZydrKDu3GDwZR1McqhAkd?=
 =?us-ascii?Q?U74wHnazlB/xXbUaQZEJxSYMkyCGwub1YtnvrUs1EDpZ9nSgr+CzRVqBUPoK?=
 =?us-ascii?Q?VFYLDlsrKnBu/MZqGRn+yWiBfrVHAteia25de2FaaxxtQEMlLF+r6RpGKLS0?=
 =?us-ascii?Q?I7yATOsqXwRXSzQBASi+SvMwvKbR33aT6W2ZloGKY78EGt/n2JsEwpthxZlk?=
 =?us-ascii?Q?kn466LhxWOPfi5NIIDn/t2YEQNWmSrNTZ9Tgc9FOZeLGE/fiCgwyzvmn3AuS?=
 =?us-ascii?Q?t+ndJLD5sAnOt8wfBIEUGbfugw1XE4W2AaIKAideLKIAxD2lESVyYLH5AjKc?=
 =?us-ascii?Q?1vK59IDuHwfws+HBhjiJOtkkaVb1E+t2yp7pbuXUlj0TZ5JZQS5qnpCBf2zV?=
 =?us-ascii?Q?TGw7Zj7WyjuD52Wl6zHgjaBS23L+WTSw1PYw/BB82kmkVaTX2gFLY0fePY3b?=
 =?us-ascii?Q?AYUFqTki8TLqEFVmdUi4NgGU73jIcIpzTdaCqDewAFPD3hq9ieLQAL+1fp6T?=
 =?us-ascii?Q?VTVDFkpquHGNNKA+O1ECOZs7ly/+NiO8dfIKg7Q41Gqmn3aEypYQ234RoIRN?=
 =?us-ascii?Q?zL1POYJg36//UsPcXd8q+kwGS7RHHNxegG/ZVvtIvjZ6P9y2Hhp+mz+cj8Z/?=
 =?us-ascii?Q?+4AOmV4cLlJ9esRXa3Cox3wga9QS7TeQ3LAb/oo/G1DItv0zim3qsFEhUApA?=
 =?us-ascii?Q?TI/X9zJYwnZ3sfZdDDpGtE6u+ENDtV81SGnH1tK/bheEvVfxzdfRln8N7Mau?=
 =?us-ascii?Q?mutKQyYi/criNOffh9CplLPbeCqZXWWux3EXBW86A7JyccmpjyWsppX6U6F3?=
 =?us-ascii?Q?25wH936A0bnwYXgqUsI5DFTZvo/8WbXKIxbuemc9mWdyJMvdBdp+H/trpAM5?=
 =?us-ascii?Q?K7Hly9GSPsN6F+H2TLyFd9FOJSnMp4IOBJgW9RVKpPp6GjvPJjcrieYR8hk9?=
 =?us-ascii?Q?Efn/4eLGOf4Sh7mtshSko2rM5pmy8AwWEfIUNhiG7HwcPhjYb3qZgI2wlzIN?=
 =?us-ascii?Q?Dp9RH+LWZ0D59IhN7A0fEFaO0yw0NYfniqV3N/1aRtXHDEKvk16QMfPlYgl4?=
 =?us-ascii?Q?ud2z8AX6lKIgJ5g5oYll72wPc28Umjv1TAft1RPDeKLRD+PY1voRrs8tJYL5?=
 =?us-ascii?Q?TOcsBlteEOJfGVfFCkTenhCt/Hiwm846SNyS8G+dedHvh5mej+HM3LCHJb9F?=
 =?us-ascii?Q?xupzd3Zok3RoXDzomMbaajPmGZJ1f2fvmSkmQLjEgkyWXF9KRpWDjb3BtJEg?=
 =?us-ascii?Q?0Lv9Avy0V0XJW17tV+WRMCn8epRUzQUv4fW6YaI8SkLdksnZLAMKHOYANNoA?=
 =?us-ascii?Q?dqtmh9i9dqB6HjcSPL2K8w7sT93lsIKRDsQydbwJA2lxAuwZn0yHe4H2tyN7?=
 =?us-ascii?Q?RZDDjkzFFtzrGDqE7qJYhFZtGU6d+/xeefBi7/WJ3HjpxR0gjQixh8hxM0DA?=
 =?us-ascii?Q?uB3YDgllVgEFIQ5BdeKkx8nFl+K55E1nOPix5WfIZa/GXdPkurrYUoVVoW3t?=
 =?us-ascii?Q?JAaU7LM+9nb24ou0OgAzgYu3GclHnKyrC43RQGhfaPIxN18tTqLzzlVQn3pO?=
 =?us-ascii?Q?2teCljap0P2H+SM7cqwlam1YA3UaIxsN+E8jlfH2RnHKnwUe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f505d43b-c4a6-4c8c-5d63-08deb808f472
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB12051.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 13:49:33.6188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmfAvOzd9OUIBTExE1l93BOTX55Ehih3i2ZG0mwkahuWoguDgc1fltx9ZUuYt93R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
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

iMX8MP UltraLite part is missed in the cpu type print

Signed-off-by: Ye Li <ye.li@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 0da5d88efb1..87c13c33ce8 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -73,6 +73,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "8MP[5]";        /* Quad-core version of the imx8mp, low cost industrial & HMI */
 	case MXC_CPU_IMX8MP6:
 		return "8MP[6]";	/* Quad-core version of the imx8mp, NPU fused */
+	case MXC_CPU_IMX8MPUL:
+		return "8MP UltraLite"; /* Quad-core UltraLite version of the imx8mp */
 	case MXC_CPU_IMX8MQ:
 		return "8MQ";	/* Quad-core version of the imx8mq */
 	case MXC_CPU_IMX8MQL:
-- 
2.37.1


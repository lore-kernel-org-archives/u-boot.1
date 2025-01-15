Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B61C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C34A80702;
	Wed, 15 Jan 2025 14:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ay+bISc3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 439348077D; Wed, 15 Jan 2025 14:30:09 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4586980703
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S9ysjVMK8X2dEaZTQcNjZc29nS6eKFseKgv9QCch2zfyH2wfLrco/Fuv53GoTZGZsm/Z+p1b35VMZfROrpWmvMxVaGV68c/SsKq+3jCev8sYRZEWayNB+532bsAXtT1n/PBSApIDm7sxwXU4LwCc797Bb+NYTWECgo2LUfQQPMYDLCJbBDgGiQhd7H4ZUrdSyPIIyRryjrKYD4BnWfSQqU5Io4y72WEbBZeVjqoHAIyLvOG1p1XHduxnPjiQLSfoF8ftPMGIU2bxs1B9jVd2lGT2v9PIwkbNtss52JxPtyFq+w2ytmWBk67/rtqV6ekomScI0FzfYvdVjsQ8VjXnsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B1c2nxcrN/fzaq1N9z5JdB6cp7J+OaG3tc2HcNK9H1E=;
 b=TGvWqQgk7+RHdRuSXRW+W11vN8yIhzA3JvYxzDooqOyHf5YiAXAn3oGa9QRAd/P9AAUlF+j/Iy52G7GKqDIJps5wGbOt3VHNVtpZkeg1Ib1H4yfoLn7LeN83ak2y2PXn2ZgsLqkw1uX4ETJ3/BBnaOAFlO6FS3KFh5sFVyQmeVJMs4CCAeC0p0fBDllhaR3QSMLEG38y95TJU+9mnZoevz3sst37jdPKfkY25EFH0d1Wc9JqexSrkUcPwThunB/cV2ZJ4wePd4Xsw5fN0Ek1NGWVj3EtdJiqrAhfMphiOuS84mIwr7lPzfxZuiW7rs+cASmq3PChtf3+E4hBuoDzBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B1c2nxcrN/fzaq1N9z5JdB6cp7J+OaG3tc2HcNK9H1E=;
 b=ay+bISc3eEr4QFvYDJB/GvOZ5/rhNV32dU/Ie8kOF8LPwPGY1fUAni9VCvveJ1iVzL4cejs1dHC6vYEvMzxV3bGKvCykh2SmjyF5+Alb3l6HtLx/EsTxZFRX9uY/UD557RNzN7dxJ2hg8BHYXmcwW2U4WEG8uOH120tvAEBKXEfSRI7CudfpuqYXCSkHoJywgLBowQxxk2oz8/WdLlKf5LoHxVXTsCCVAo10GElXK4QJWLiin6rKQ/clyeYdc/ySWjkCiDff1GjG7rGLPyfQOfTw4Wv0loDQ+du7zDypjiznIks5CwF8KBgew6Zx8ViTkHLEsWtqZdAgHa3+mgWgUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:06 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:01 +0800
Subject: [PATCH v4 14/20] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-14-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=1511;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=ISvE5KIh1EvVG/jRDCWQACxAx6aM2Mv8rwiD4N+HlQk=;
 b=Nm+qWpP9siOU2xwsi9TwChIRzQJ5/TlbFuzZd8wJUlpMEqsOSprYAeTEhnyZdhZ0bduKS+ZF6
 WExv1cfb9SpAWjWsPnnMueRHf297JIyxbPeAqeHfRoaFDblWhOSZlFC
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: ce21894d-5d2b-4782-0735-08dd3568b958
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MEg0SzhMTGtWbVgrNXV2ZmRZSzY5OU1GbzR5aGRzbkRzN2dCVmdmZ1c5Nkh1?=
 =?utf-8?B?UXhjZXJZQnpBamhvcmJVbWNUL1hiL0N1T3F6SjI2NDFjekFOUElZMWRBd05r?=
 =?utf-8?B?Zk5BaFpFcDdNSkJXclZ3cS8veVZMZWhpUTZ5QTZHNkNJSG5NcHAxK1JTWTZL?=
 =?utf-8?B?ZnZVSVNUekN1ejRwcFQyZjNtcjZXWGhjbWlQUDY1eCtzbk1rSkxRbXZzUUNp?=
 =?utf-8?B?eWM1UXh5Undpeml1SGlHTmlyVHNGWnAySkw1YkFkUThFeXYyc3RRR2k0UFdE?=
 =?utf-8?B?Tm10aCtmSHBuRFdab3VtTGhvSlNsZUV6SWt0NVIvWHBVWnVQK3g5Y2EzajMr?=
 =?utf-8?B?clc1WmJzb0hsWlFBN1BDNW9RaHhlYWlkcHZ2WklINmQ2U0R2N2xRa0dwUm9h?=
 =?utf-8?B?ZFErcENKTEIzSEFHZC8vQ2xkeG9aWWdKU2hJVlM1dC80UHp0YXF4cFR2RHhC?=
 =?utf-8?B?SXdubjNwRGh4WmZmT1dTUHZvMGl3NEVlZDdKSSt1VWZyQU9QODgzZndjdmRv?=
 =?utf-8?B?NGdvdDBDYjRTb0RPejZIV3ZsZnRLK3IwMTBBeDFHcnJBc1Jod0g0MUxxNkcx?=
 =?utf-8?B?a2dETjM2b3ZlUXNJWjhWNWlNS00vcDJBZTAwZis4ZUVSWkVtejVGbHYwajRh?=
 =?utf-8?B?eVlRcFFPYWh2MEFNcTBDSk9XcFU2dVI2Uk1DanB5QjJmeGgzNWxzOVdzU3FI?=
 =?utf-8?B?NmFtZnNUcG9CT2hmcy9CdEx4UHRPaGRoZHk3MWIxek9xQkNFanZ2YjFMU1A4?=
 =?utf-8?B?WWdjeWRTWjZwNEI2VU5HZjhTV0RPNlZ3aXhqMThkb3JpTTFKQy9YQ3ZHUDRP?=
 =?utf-8?B?SUJvUXZSR0VKVnkyQUpMZVRKaFlObnA2aU9pYVY3bis0UnRwemxIRkxPTEgv?=
 =?utf-8?B?Ylc3LzFTdmNpU0NHZjZvNEhSQVRvbXhpOG5xYVJmalBucG1XQWhYMVZFdTFY?=
 =?utf-8?B?bkJwTzlqL1YxSVl2VzRoc1g1N2RIazlDWXBLQzNwZVJjVnJveW5BdTdBYkhG?=
 =?utf-8?B?M1p5bXc0MVhMNGltUDJMdWNJYnhDSnAvVkxVUGlBSlZYMk1EUDN6eHZBTGw3?=
 =?utf-8?B?WHMwdWNWemZyVEhvR3NOZFRJVUJDeVBoeitIbjVQZXh3SURkanFqbXppVlQy?=
 =?utf-8?B?eTlzWjBwTmZYQ0I1L0V2dDFZZjc5YnB1ajBzOXdScmRiWnZXcXhoUGFjR0Vw?=
 =?utf-8?B?YWoreE44MVpKNkR3UHhNRWJCSGFnS0lib2RkckZFOUdtYXdnOGFUNG1uSHQ5?=
 =?utf-8?B?QURHWWlqUGJvckxzLzZnT3RiaHNuWXRUQ0xDTUp1bGx3empYVnpmYnVrVkVk?=
 =?utf-8?B?ejBHU2FFeFRkenlhL0V1eGNLVkZsclUwOEk2MGRZY0FpdHdrMjBydkE3ODQx?=
 =?utf-8?B?OHV5N2hMMDVBdnpNcE5mWGhGZEdQMFh4MlBwTlM1a2Y5UW8welRtalhRTVFB?=
 =?utf-8?B?NndvaUV6RDBtbEVGeTBaSE1aODAzdWNqcFdiNWN5YXFJVlNNRFNOOHNrZ3F5?=
 =?utf-8?B?aXc2QU1NZWV1b3ZzcDJNUTBwWFVEemY5T0ltUVVNZEYyNlJnZ2tsa3RsUW5o?=
 =?utf-8?B?MElGQzlJWGluaVllUkRIb0gxekZhZmJON1J4a1BjbnJidDFBRUVOQkhXVFVj?=
 =?utf-8?B?NUljSTVScm1QM3FCblFDL1BiNXhodWpCek5GbmNSVTFvNkVBNkFwRExKMHU4?=
 =?utf-8?B?cFdwdGVseVFyTzlCZkZVc3lmZUJ3dHRob09DK1Z1ZnlBRmVINjBzUVYraTF3?=
 =?utf-8?B?RWVUQ0VFUWRPYlc4eGdVcHZwTytYZDVBdFo0dFM3ZWRJYlU4S3c3MWF1d2VC?=
 =?utf-8?B?QlRKMGpYQ0lMYzByQ1QvaHJ2bDFCeHhQNUFVR2tmVnNVdlZUSXRBZzhLbXgz?=
 =?utf-8?B?aWMycFNUOHl6eHYxVHlINVhTblMxcWdlWWpobTExOFB3ZThRY0xUcU8vWXR1?=
 =?utf-8?Q?dTc7ypczNEFIETMoo5JaV3+fohq4NgF6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1JzV25XSE9zcFlWNTJIbmNyZCtVN3NwK21aME81aDg4dGVUT0J4YndINlBB?=
 =?utf-8?B?NEtGNlk0dzFXTEpPYVUzR3VnMGQ1NWh4ZWYwaGNPTm1TVTNrTndRS1JHd1dU?=
 =?utf-8?B?VWQ1TmR3aktSVDF4VFNOZjVzZTFLSTkxY29WZG5YdDRyZDIySCswQkhSaGdI?=
 =?utf-8?B?Nm1jTUZjY2l6bTZzUG1FcTRhQUtyNjFITW05TFNvakwyUllPaTd3TGpMaVJh?=
 =?utf-8?B?akxOS2UwU3NFSWNnTUJvSnh0Nm9pWno3OGorYjNCOHZyU1QySWV0c1N5a0Zm?=
 =?utf-8?B?U3c3MDF0Vy9na0FsdDFEUmliKzA2M0lEUzRqTnpJRmZhVE5INm9qZU9NWkZP?=
 =?utf-8?B?cXJPcXVOOGtyVmw1TXRIZ2JTbmMwRC9VaEZZOUhGblAzYklkQkxUdDNyL1cr?=
 =?utf-8?B?TUJKam1DandYekNEYjg0L2wrN2M1VHF0R3prWmIzN1UreFR6ejFOei9aMU5F?=
 =?utf-8?B?K2pUZWlldTRjdTJ1bGZkWVJVM25HdkJLUmw2and2eG80Z0VDOVZOSVBOTTl0?=
 =?utf-8?B?aEJ1aWd2MGxvNlZYcEoxaGhZejVYMG5TM3hvSlRqZXJ0S3NKdXRyU3JpT2hu?=
 =?utf-8?B?ZXc3WkFMY2lHWkhQUlEvdk1nV1hBdmRxK1dFaGtUQWRtM3M1VEt3R3VCWDdz?=
 =?utf-8?B?c1FuK0YyeEQvOVpyU28rUkJ6UGk3RnFrUzZ4OEFwSlVEZFRpRkFnVnZUdW9G?=
 =?utf-8?B?RUwzOWE4bDFnZTJrWllDQkFEYjlrT1l3VFNKck9EaGJMTC9tc0N0RjhvaFov?=
 =?utf-8?B?V3lyekh6TE16OUcxeE1kYVZHb3luckxDZXdhQSszcjZZelNaaVNOMFAvN1E1?=
 =?utf-8?B?KzZ2MDcrOEoxVi9ueDZsdWxyZU04WGFSaFBaVTdzWW1TQkV6ekhXVFJwdVk4?=
 =?utf-8?B?T04zZkpVdWdKZGhCMmFDdjN3QW9nelp1QXdKNjBsKzZUcFh0RXo3Qi9QNG0v?=
 =?utf-8?B?R1pGeDhGTEdlVzVMamlqdTVGTG1zNUhMUG1YM1B5SEhEWlAyNE4xQ1BhVzVK?=
 =?utf-8?B?RUpCdVUycnJDdFY3SXN2YVRWdVk5V1dFelYvUk0vU3JBSzFpYXZ6bDJ2WElL?=
 =?utf-8?B?cGVjWTArWGdaZGxNZGF0eGNnSHlkZFBXdFYvYWU4TVhBY1d3TktEWGNkWUZH?=
 =?utf-8?B?SmR3aHV4eStPSTZ5K296b05rMXJHUUhmZ3BPZ21PNjV1TTRZZjZ3cTNWbXdu?=
 =?utf-8?B?RmJmQzZIS3k0endQUURqOHo1cS8wc2RJeHd5Y05vaXBXbFlSbko5UmYrZUlx?=
 =?utf-8?B?RW9QbzFIUHoyaHllK1UrSG9KNXJybTN5a0xtenErQWJtKzREcmE5WmtOaEtY?=
 =?utf-8?B?Y1hiOU81bGY3b204WktHdTR3cllGUGlDZ1R1aGhvaVJ5M2d6aDRJUlFOamo4?=
 =?utf-8?B?WENDVnNPL1dEZHdnRC9OWUJhZDhsamljZ29HUEc5aGxPSytIWU8wUTJSdGQ1?=
 =?utf-8?B?VUxCQ0xTRWp5TmFpM0Ura056RHp5VUF0WHpobWFnRFdHT0NtSkhvSVZDZ2g2?=
 =?utf-8?B?SHlWQmlWYUpMdzIyRUh5ZHhOU1p3cnlQNGFPRmhGdC96MXhJUE1EOUovVVNW?=
 =?utf-8?B?bUZOYUhDSktTWGZUdTEwaFFNNXJGMllNcWZXQVY5bVJiVndqWUVyUmdxMW9I?=
 =?utf-8?B?RFpYUnh6aU83T0oweTZ1QmREYVRQek5WVTRvbHJHU1JYZHc4amNlOVQweE5z?=
 =?utf-8?B?MlpPSkZueVFDcHd5dUE2R3F6czFYWE1zZGNzSE56d2lvcXZ0SGFaWnM2anFo?=
 =?utf-8?B?NEh5c1UxaUd0SG4yLzRwajdPR1NMMmJrSkpWRHlhcGkzMlVTNFErRysxKzFv?=
 =?utf-8?B?TzZoZ1k3M0gvcW1FaEVTcWZTaFNkNDg1VkNqRXRkSVE5d1QyTE4rMjRITEZ5?=
 =?utf-8?B?cHR5Y1RyM0RacGxod1EwQ0MyVWdCNGp6bVY0a3djSmJBZUpHNlczMWZtZVk2?=
 =?utf-8?B?RktMYkVOcFM1ZVJ5amd0NWlOaFFPWm1RUDVNOWR1LzdvRGdrT0tvaGc5Zzhn?=
 =?utf-8?B?QXdtWVRDZHFQU0VBeGFKTnNsK1hJTTZia0N1aWRRY2dkUHBTYVpsQlh3RFh1?=
 =?utf-8?B?MHh3ZHFaVklrS1NxRE8xZDFoakwxWlYwd2EzMEdpNkZjeS83L05iNkU4THgy?=
 =?utf-8?Q?YFR406AzCnzbKlwg3AJC9C8Y+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce21894d-5d2b-4782-0735-08dd3568b958
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:05.9893 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rhQErVeOE5s8MsaKXXXUJIdp+hsutg4nshoDSROR95WjB5+nHOXmEF0Ys9AZHqAX2E4/mFh7046CQJZ26ceHYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 8 ++++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..660529555e9b3d38a6fb70c77858bd9de7473461 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -21,6 +21,14 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select IMX9
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select SCMI_FIRMWARE
+	select DM_MAILBOX
+	select SCMI_TRANSPORT_SMT_INTR
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75a558dada3c328ed0878050da2a41e1..53cc97c6b471f1bdc3f55b198788ca42e4ad9558 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.34.1


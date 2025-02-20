Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F9A4C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 15:55:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45D280077;
	Thu, 20 Feb 2025 16:55:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gqWRqK7h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E38380F42; Thu, 20 Feb 2025 16:55:04 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::60d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F6BB8001F
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 16:55:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoqmPmUBquAKVFa/3QtH+AiVd6r30JAs7Dwo85b1NSxrpjx/M652JBHtIhed0NFk7IbKscs9QFicleCVFGKpgHP3R1OLWxGqwpVPDfnL/HW6hUuxuKzgbw70VfrqWNBrPu9aR0TtDsUHlDNWzEl31zHSg9hFDd+Hm13jwK7rj+8Uicm0yw9tVq3PovxKrrAbVEHzxoyp0WZFmJBTW/S+Owgks5tbTEcUSNvSxZmowkBpR4f5RSpx22S+u0nddJYM3P4TaP0alH+tTqSu5wL1SnjTrr4TusNImBRgQWAop7+QkuXcYzTZXZ7Iz4SZKx0udnGuN+aDx4cYCfzp/swEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNizbLUbScexmr1zW9rYcxNDTVsmYvKodhuDJm/xVR4=;
 b=OFgk3sKuthyvz9DkccRM3Aoa9oWE1WBkaok2TjFn1g5VmC9soajgNAKLP7bbw6vV7Ks6TZVE9k0HJx5BCIm6Z1FMKL9TtcJlC/8CAi7YEOVAnGLufGRAYaGYX1G8TTpYH9AzpMlyZEieXCREXqW30OsFEFYqTsi1wXtZMveyYUtQtHVYlYSwbyfSMxggF+W6M+gg1A+FYsFO47iMn3Y8EJVKMnhWHNMo+/0ot/tKn+kRZNKi2AnIVms8/8jHh51g9yjd6eGyOTwD9J6UoszThPbO0kEjflJtNDJGSKQOTZpv0KBZXYOh8wbXrJXWbL1e/rJ+1LUQIruS2LMgBrfBRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNizbLUbScexmr1zW9rYcxNDTVsmYvKodhuDJm/xVR4=;
 b=gqWRqK7hGSgQMLKZpCf406p33h9IGfr+1iW7KCqaT4QC6h6KZd0iVVmxha1wFjyHYVvGc7ifyvF38hebRt7T5IsgcIMRB2XS5YBb5hi6PR8fZH+a8cHhC17fqDCd9b5Q6Dfn6GWsl9agHfLRldybUcwdk+M7Yhk9xT0CG9IRxS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10272.eurprd04.prod.outlook.com (2603:10a6:150:1bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 15:54:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 15:54:56 +0000
Message-ID: <6b6925ee-ba1a-46ed-88dd-87b3bc4b77a5@cherry.de>
Date: Thu, 20 Feb 2025 16:54:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add 'bootsource' /chosen property
To: Daniel Golle <daniel@makrotopia.org>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Quentin Schulz <foss+dt@0leil.net>, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Heiko Stuebner <heiko@sntech.de>, devicetree-spec@vger.kernel.org
References: <20250205-bootsource-v1-1-95f4ba69ac27@cherry.de>
 <CAFLszThr_vLbhU7A0_0VTLCGW03k6NmtxLVoW7OzrtxGFertZg@mail.gmail.com>
 <fb6792e8-97c5-4d0e-8ded-e73ea3a7513c@cherry.de>
 <CAFLszTg9-jMk0PBBSEVT=FonzRUNJOQ5NBMdDYUihWS8NkMhbQ@mail.gmail.com>
 <fc2c6f06-98d9-49d3-9ce5-46dd675e8846@cherry.de>
 <5E98D444-A005-42CD-8A6A-381791237A6E@makrotopia.org>
 <07eb10ff-2791-420d-a302-a2e8c308b468@cherry.de>
 <Z7dItf07omjuTm0U@makrotopia.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <Z7dItf07omjuTm0U@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10272:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c112274-77c8-461d-b749-08dd51c6ec00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXBQQ2hScFJCQW5xQTY4SHBOUnJXV2pHQUdqcWdtdzNGWFNnM1gzUld6T29N?=
 =?utf-8?B?UkNheWVzZ2J2ZXRlME05UE52UUNkWkJReWNVczM1MEZycnM4a1Q0UWVxclBU?=
 =?utf-8?B?elVYcGREbWd6TVlEaXBXMGJDU2JLSzVJUWtsL0JuUlpld21zZndHanBiTTBp?=
 =?utf-8?B?RXZiOGlaeE9tZ2FYUjVtV0MvRGlRRXk3OHkrOHVOTEtYVjY4L2tGODNSM3Z6?=
 =?utf-8?B?QTEvdzZ6alFTRk1HS0JwTk9jNVZLRUg5VFB1V0J2ck5ES2JpaGpocTd6RmlZ?=
 =?utf-8?B?dmJBUkVrZ0pNbGtmejdXLytDeUp5VUZDWE53MEFiLzZVRmgvTDNGdmZwS2Uv?=
 =?utf-8?B?eDNNNUEvWnBzQk1PL1M4VkxFVTBsMlJiNzRmRDArSGlwSkIzRTg5SndBeTVn?=
 =?utf-8?B?cTdwUU1YTDZzbFpxU0RYZnV1QTh1dVRiM01tZWUxeVdPQzVCa0FIbmhqQUJ4?=
 =?utf-8?B?ZGh3L1ZIenZjSDA1bjNHb29NMGgxbDdvajN5bStoYkRqV2xQRTZZRmV2bXhi?=
 =?utf-8?B?bXM2L2pQN3hhUTRGTm5rUmFseHI4Zk9ZbHdpTWpCclpCMDdvQVJKKzRtVzlR?=
 =?utf-8?B?bktaMzRQQVpnZjRDaVROY0dhR0sybk9EV1A1M2lEdVRpZUowYmJOeHYwYWcv?=
 =?utf-8?B?UU5ZWmRHaDU5L1dONlVhY0lIQ2svR1hJQnFicTBLT2xyT2FxSHMyemlzbnNQ?=
 =?utf-8?B?YktqaERvZWRTRFBxZ0NISVJjTmlWNU44ZXZDV0t1Q01wa0FRc3E4UUUvdUtw?=
 =?utf-8?B?eVlNMmtXTFdLMmg0aWdIVXNLbmlKTm5ZWGVxRGlSWHI4MmRGUGZ1OWtYamMw?=
 =?utf-8?B?bVZRbnNYclZtL2hPVUluSm9XMFBOeXFYV2xmNXNINFlaNkU4RmI0bzJjWWxx?=
 =?utf-8?B?ejBIb0EvTjBWVGJoaVpzRzFwVGdoQjZPdlFuejgrRXVWTmxsL3U0ekFTdGQ3?=
 =?utf-8?B?SDJ2dlhuMGJqblRJV1Irc2Y2Y3pwOTF6Q3RCNjAvTUJyZCs3ck5JVmh4N09U?=
 =?utf-8?B?RERtMG10ek1YUGFtd0pyRm1tbUh3S0Z3eXpaWDZzUElaSXdnd3BWR1VwZU10?=
 =?utf-8?B?eUF4bXNIWVloc3NVM2ZhaXFUcS9pTDNCcERYQ3ljbFc5aEpuY2I2T2xXemZk?=
 =?utf-8?B?QWY1TG5KRzJpQTdyNnNzOGZoR1Q0ZGFMOVlYcU9LUkhmODNyVFNYN3ViVnhl?=
 =?utf-8?B?ZDhGZTA5RjBFZVliRU5JWDBJRVJ6NDBEdDhTYWg2Qklad3lVY2NmbFg4R1dC?=
 =?utf-8?B?N1VQOURSekJpUHd4dkNURHE1dG8yV040cFhkR3pVYXM3NVUyMlRsaXM3OVpC?=
 =?utf-8?B?bm5iVVgyeXFHWjdXZERtcFZmUFltaFd0OW5SelRLNkM4NHU0OG01WWlXUE8w?=
 =?utf-8?B?cEtndXNQbjNuL2pEWEFSUnRTZTBNMS81eGF6WVJaWC9xd2FNVGZhaGhmblFu?=
 =?utf-8?B?dFNTMWNRTDdaSkgxMXFqMFUvTG5URnhOUlk2L2pibnFORVhkMzVkWVhsNzMv?=
 =?utf-8?B?ekhRd0l6d01qSDJXQ2hDaGNOSWZHN3VORWRWQTRxL09TVTkxTXpNYmpXejJ4?=
 =?utf-8?B?bG4vMS83YzEzMzBpNUZHenc4RkhYT05ZWjVXWjlycWw3bFRMZVBPYTVEMUsw?=
 =?utf-8?B?YUJBckI4bzNWU1p5bTkvd2R6TzdOaHAyc0k0aXBoNnNsMXBNMGVMVzJaWVV2?=
 =?utf-8?B?UkwrQndEa01KcVRxWldXWDRYVDMwanBmL29xcWx2VEJwQTZIRVdzUHhZM1Jm?=
 =?utf-8?B?b1lSVU96MzFIRCtZNXc5anV3MjBpNkE5WHFpQlBCc2dIeGc3cGpiWGd3UDVB?=
 =?utf-8?B?Mk1XNURBaC83Y0tXOEk0dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWxQWXJMTWZieWx3MlZLcHdBQXgxZGRFREJ6RjdkNUpQUHJHSVlDTlV6ek9x?=
 =?utf-8?B?enpvSDRxT2dWVTVOY3pmN2o3c1FnSHpaQ2hMR3dNcDJEZmtvNmdmVk0rYnJT?=
 =?utf-8?B?K3NtdXZZNFd5MTVrT3BDemo0NTdhbVJpWDdvbEhYb2w0WjM1T0FvZ1doa2VP?=
 =?utf-8?B?cTh5by9XcUZxRy9DVko3RlU2bHBnSWphdStIOVBIRG5zZ2RHc0UxT29JWkIx?=
 =?utf-8?B?SW1lalI0Q1JCREtIeW1yS2RPSTE2SC9vZWRHa3RVYkZxOHd5RkV0N2JVazFw?=
 =?utf-8?B?WU9HYVZVeFNhM2Zmdk1NQVQ4SFBNTUZBSjlNb3RoOXNieDNyM1plK2xaUzJL?=
 =?utf-8?B?b2VSeXEzRytPTkRBMjd6elluSWQrMm8zcXZSU1ZOR0xNS1FCUEJyMUl5L29Z?=
 =?utf-8?B?bFF2S0szZGJ2eUlEcmdVTjRBYVdPd2FUdi8wLzBoU3Y4Q3UzaXQ2Q3QvVDRq?=
 =?utf-8?B?aC9rcGxPOGtmSkRpaGxKTkQrZHRNRkFKSG9vVjdXOWJIRjV6VXpMUFpFazlT?=
 =?utf-8?B?U0w0V01BcEZGOTY0TnNRcUtYaGlRaUx1UzBVVjdGUGJldXRKMU5WS1RhWTRk?=
 =?utf-8?B?dGROTlk0b2IzUGJjSjZLWUEvRnNzb0doRTlRUVZubTJPbWxseHdPWUJ2UEFa?=
 =?utf-8?B?c0dkNk52UTFjNzVmNmlsSWhWbnBxVlgxUlZpMzZyU0JwZXdwRVNwT2FZTllJ?=
 =?utf-8?B?SnMrQmZyQkFOakx5cm1xa2lTRmYwVWlJN2ducW1WV04yOHYvN1ZmWW90QndZ?=
 =?utf-8?B?bFJWU2pHTGZuQTFVdEJPNHpVUlEwYW5wTG1sWWtLbG9uQ29HaUtrWmVwbjdj?=
 =?utf-8?B?WWJiOXNmblhwUTNvR0Mrd1FqTFFMK0xxNVYxVDNuWUZnRlg1RXJZVHcvTFN3?=
 =?utf-8?B?WS9MOW9scUgwWXV4eTloczhpNnJuUFFHOGpYTC9BSWNrWHFhbzRCc2ZPRW5I?=
 =?utf-8?B?VGRZaEJPWmlydlNIK3M0QlVmakRWRG9tem9WQmpmLzF6ODlvd0hWY2d1QlpG?=
 =?utf-8?B?dnJpTDk0cGVQL24xNGppeWlPY0cwVSswRmF2N0t6bmhqOE5vVVAvSCtZVXRI?=
 =?utf-8?B?b3BOZ2UzNmlCcWlmQ0w0L0dPSkYzUFJwdDF4Njl2SzBVOGQza1g0OXg1WnQv?=
 =?utf-8?B?L1FyK0tLTkVxd0ZBSXJDVTJQQ0dhdmpLNHM5c0VPaU9YOG1TVlMzN1RlNVpS?=
 =?utf-8?B?YXMzYk9CQUYvKzZmUmtkZTZ6LzE3VUxlNW1HK2JHdy9KaXZEOURQRUlQWHpG?=
 =?utf-8?B?S3NpRWs2RFNTU2pmYWorTDBGaEtlZWpYZVQ4cEs4T0lMU1N3SGhSMzZxSE93?=
 =?utf-8?B?NTNUNDA0NTdFK0tzUjg0V0JheEt4Nk9TeWRZSzAwN2xXd3g1N0RJNFo0NUI5?=
 =?utf-8?B?dUhqVzlCODlpWmQ0aFNKNGo3aWJwZ2FyRVZ2a0xxZmtsaTl0Szg3M1g1WEZN?=
 =?utf-8?B?bjJzRUxXcFBlYWQzZXNCbVFyRWZ6NWR0NXlPVmpGWmN6NXoxVko0ZWxkdDVV?=
 =?utf-8?B?SE1wSE1IMlRGNFFyMXBMcU1IcytiMHdTYVNsd0tvWHRsS2oyeHdBL1pYU3ZL?=
 =?utf-8?B?b3V2bW1FVm0yVDljRUdwNlhEUHYxbFF5K0p1MlZRQTNIMk9LeUJjVkVKemNh?=
 =?utf-8?B?TTJwV3dqeTk4ZDdmUjZjaTN6SUdKbzh4SUVnUTMvNnFIZVNsanVGU3ZnTVdX?=
 =?utf-8?B?ejVZYVgwUERJMVpYS0FTT29PWFhySHhIT3dFS3M1TzJPbjh1RjZ1SnVydDVu?=
 =?utf-8?B?bzhyeDI4WG1sUGtVWU9VZ3hvMXhkajZkaUtVa3ZSZm95OHY3WG9QU1dXRncv?=
 =?utf-8?B?OWV0emxrQk44NFhlVFpibDJDSUxzU2ZyNk0xSWtqN0VocnZkUkphcHMrNTBu?=
 =?utf-8?B?ajAyV2Y1QXdlVElQSDhPNUdiaU4rNjJzS0NEREVIZDVvWTJCZ1BwR2xsK2My?=
 =?utf-8?B?TWV4aDFyaWVyQVhqWGg4d01lc2kwL3N4TElEdTdLRkdtR0Z3NjJkRnZYbEhI?=
 =?utf-8?B?Y2RhdEdnckNFT2JWMVdxQjh2ODBpUkVaOXJ2SlRYV0FNaFVZSWVwa05mSE9p?=
 =?utf-8?B?RVZSTUM4RTJ4eXZucmFRRXNCcTQ4QkgvcjhOVzdBTlhGYitKNW1qVTFENUdP?=
 =?utf-8?B?V3h4bzFNUSthL1FjcmpsYk9veVVhdzNBTnhFRWRVNHRZanMveTRWKzA3MUlL?=
 =?utf-8?B?Z2c9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c112274-77c8-461d-b749-08dd51c6ec00
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:54:56.2547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4gdXD/wGCOq0Cbgg20yHejQUampj3socPlPiqmMEAy8d19M7Y+FU0ERGxKZfIZh0Jo6L9TPa/doXRefTXDQlEiXfw8vPpGWBeQQffGNG06Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10272
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

On 2/20/25 4:22 PM, Daniel Golle wrote:
> On Thu, Feb 20, 2025 at 04:04:27PM +0100, Quentin Schulz wrote:
>> Hi Daniel,
>>
>> On 2/15/25 4:13 PM, Daniel Golle wrote:
>>> Hi Quentin,
>>>
>>> On 10 February 2025 16:25:23 UTC, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>> [...]
>>>> What I can say from glancing at the code is that for Rockchip they do the following:
>>>>
>>>> Register a bootsource type (e.g. MMC, SPI, I2C, USB, etc...), a bootsource instance of that type (e.g. MMC0, SPI3, I2C7, ...). The mapping between what the ROM says the device is vs what it is in the DT is done in their Barebox-specific DT via this custom prop in /chosen:
>>>>
>>>> barebox,bootsource-<bootsourcetype><bootsourceinstance> = &label;  # à-la /aliases
>>>>
>>>> This gets read and resolved and then inserted as
>>>>
>>>> /chosen/bootsource = "/some/path"
>>>>
>>>> into the kernel DT.
>>>
>>> We are doing something quite similar downsream at openwrt.org for MediaTek router SoCs, see for example:
>>>
>>> https://github.com/openwrt/openwrt/blob/main/package/boot/uboot-mediatek/patches/310-mt7988-select-rootdisk.patch
>>>
>>> https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dtsi#L32
>>>
>>> https://github.com/openwrt/openwrt/blob/main/target/linux/mediatek/files-6.6/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4-emmc.dtso#L60
>>>
>>>
>>> Of course we could use the standard "bootsource" property instead, but having a way to reference the volume or partition used as rootfs instead of just passing a referencd to a physical device is advantagous...
>>>
>>
>> If I understood correctly, your prebuilt DT would have
>>
>> / {
>>      chosen {
>>          rootdisk-emmc = <&rootfs_in_emmc>;
>>          rootdisk-nor = <&rootfs_in_nor>;
>>          rootdisk-sd = <&rootfs_in_sd>;
>>          rootdisk-spim-nand = <&rootfs_in_ubi>;
>>      };
>> };
>>
>> and then at runtime you would populate /chosen/rootdisk property with the
>> "rootdisk-<medium>" string with <medium> matching whatever the BootROM
>> reports. I assume the goal is to somehow make sure that the rootfs is loaded
>> from the same storage medium as the one used by the BootROM to load the
>> first stage bootloader?
>>
>> Can you confirm I did get that right?
> 
> Yes, that's more or less correct. It's to point Linux to the device or
> partition of the uImage from which U-Boot has loaded the Linux kernel.
> 
> Note that for OpenWrt we prefer to store the uImage.FIT inside a raw
> block or flash partition, or UBI volume, rather than as a file inside a
> filesystem.
> 
> This information is then used for two things:
> 
>   - Mount the root filesystem
>     We use a read-only squashfs which is part of the uImage.FIT, it essentially
>     has the same purpose of an initramfs on other distributions, but mounting
>     squashfs is much faster then decompressing the whole initramfs at once, and
>     it doesn't need to remain in RAM permanently.
> 
>   - Know where an updated uImage.FIT should be written to.
> 

OK, so everything in a FIT image and you store the location and storage 
medium where it was loaded from so that you can update it. Makes sense.

I guess we could have bootstd/bootmeths populate another property that 
specifies which medium and partition was used to load the kernel/FDT and 
initramfs. I don't have much experience with that aside from 
extlinux.conf and that wouldn't be appropriate I believe especially if 
you used root=PARTLABEL= or a UUID in your kernel command line as there 
could be multiple ones with the same there (e.g. we have the exact same 
image you can flash on SD card and eMMC and the probe order isn't 
deterministic in the kernel I believe).

Don't want to get sidetracked too far though, I don't think it is 
incompatible with or related to /chosen/bootsource usage?

>>
>> I was specifically NOT aiming /chosen/bootsource to represent the storage
>> medium used to load the kernel or rootfs, but rather the medium that was
>> used by the BootROM to load the first stage of the bootloader that is
>> user-flashable/uploadable.
>>
>> You could very well decide to load/mount your rootfs from SD even if the
>> BootROM loaded the first stage bootloader from SPI-NOR. This property is
>> about representing the latter, not the former and not merging the meaning of
>> both into one.
> 
> Of course, especially for general purpose Linux which would not fit into
> NOR flash that's the only option.
> 
> In case of OpenWrt we usually do want to load kernel (and rootfs) from
> the same device also used by the BootROM for booting. OpenWrt can easily
> fit onto 16 MiB of NOR flash, including bootloader, EEPROM for MAC
> addresses and WiFi calibration as well as some megabytes for user data.
> 

We (Cherry/Theobroma) have some modified behavior for bootstd to favor 
booting from the same storage medium as U-Boot proper (so NOT 
necessarily what is reported by /chosen/bootsource) instead of 
defaulting to boot from SD card first and then eMMC. See 
https://elixir.bootlin.com/u-boot/v2025.01/source/board/theobroma-systems/common/common.c#L11. 
So I very much understand your usecase :)

FYI, U-Boot SPL favors for loading U-Boot proper the same storage medium 
as was used by the BootROM (so that would be the same as reported by 
/chosen/bootsource here!) and this is modeled with the "same-as-spl" 
string in /chosen/u-boot,spl-boot-order property. I was thinking of 
adding a "same-as-proper" boot target for bootstd so I can remove my 
custom setup_boottargets. This was also somehow asked by at least one 
person over IRC some months ago, so maybe I'm not the only one with this 
usecase :) Haven't spent time looking into it and I may never have time 
to do so, take this as a brain dump here :)


> To satisfy both needs, I reckon we would need to formally introduce an
> OpenWrt boot-method to U-Boot, and then U-Boot could leave a mark in
> /chosen where the uImage.FIT was loaded from, independently of the
> BootROM which may differ?
> 

Yes, I don't think both could or should be represented by the same property.

To sum up, specifically for U-Boot:

BootROM loading VPL/TPL/SPL -> /chosen/bootsource (what this patch is 
suggesting)
VPL loading SPL -> don't know, haven't checked the VBE series yet :( 
maybe Simon has something in mind?
SPL loading U-Boot proper -> /chosen/u-boot,spl-boot-device
U-Boot proper loading kernel/fit/... -> nothing at the moment

Forgot to thank you for sharing what OpenWRT does :)

Cheers,
Quentin

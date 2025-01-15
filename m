Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687CCC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:29:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7927F80735;
	Wed, 15 Jan 2025 14:29:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fzlNOxOP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E8E580713; Wed, 15 Jan 2025 14:29:25 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B9D180214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJHZfiosKqnNLp1wzUzNyUOy2ymJvSDMWDMqyrRIcd4xumD5a5WHsipO+h28pojLp/9GgjMWhQYBw+M9UMbGpSmpjKxuSavTdqMIxQiE8mLS9Xm6OQjCkgUWDBhwam3cnGbIH7BrgieCJal8BHjBbby+PgFlJsbyHp3gH6YsvJtSTRy6/NEgb8VU8qjtVMHdOKubAPyvKGR8O6TbjYzTNdnM8NNm2Mw01W7etgjNi1D11Z6u6auNesI93Ek1piACPD+NIhl/ZoIZHIAkCdRlyC/ws391cZqgNiaNVcXyGBuPUvGsY22V7ubgOzUOPy+YdQQntpDjW2l5c9MLQDfrcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q42fszEDdjmuwmXZau38NXZOMNBJ4Z/IX0qKZ3YNmDg=;
 b=NAwwvNiADShU72E5kCjvBwmkP/LyMnl/4zX5FUOYZuAjlHZjfEwQbY8fNNuQkQw/Gv/F+EGmGnF9FHhdeFIM6LmSdWXvhrnDQc7RBhXWxiu2FTizbpUzmhJXxLn42K3IV9nYGbVW6vFPwGE4KJNaBdeYXXvWD1eUy7IDRUUtwHrnjbHnCx1Q46VDAQXu8cZPnwIwbM38g7pA/sk+eY0d5wPGaQS2CIS1B0cbKPvCIThpB/b3StaUgwinzY26axPzRhompkpEg12oRJ5EpAiysj2OeRcUE/TMyCI64Qe/NgOJzGFn3pg6sWCgVBLyW9t+f4F2MQGyruVlVrRRw7YmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q42fszEDdjmuwmXZau38NXZOMNBJ4Z/IX0qKZ3YNmDg=;
 b=fzlNOxOP5QTQ/zBhz50Lx68mpwQSdoEeF1LqwQdcJz+bG4rjK3Xp0hKwY+GoBV1A6r8JUoGP4tULxx6/Djci97yCPB3hFRwzMdkiWtCmdhHN5Z5oZGqVs6TLnIcN5c257JqAahGMMjYBa2HqQ15TfYKrHJDVvAtUgfpcTjhmHEA/FT3jYvg+YtBgN90exKp51hbvKcr/wX8yIK2cBGOl0dd+A8obYcLjJYBGaH3Nhq9IxhYG1xJm8fX6iNCJSIlnbJGXD8XJTagx1B7vrhxaTaHjwnsVjIYvBsE+ePJ2YFw3dT6xJThPXwTAX5ZruEV4BfTdc/kZVlpeZDMUUl6coA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:29:20 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:29:20 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:28:50 +0800
Subject: [PATCH v4 03/20] pinctrl: nxp: add a pin controller driver based
 on SCMI pin control protocol
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-3-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, 
 Alice Guo <alice.guo@nxp.com>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=10003;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=+PlMA6rcLP2uX4SOBH6UvLshiPgoDdouffMbTFSFd/8=;
 b=l8fU5Hy5axkUL0Z8td8TTpjI7uiul7HkhC4llr/TQhqL+cmNn0AxivFljoTCCA9V/4BB8xrA7
 m1/Yo8050ysDvl95hsb6M9KhZ5OEL4g7/Rut2Dxuy/D5HF3DhKR43tK
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c95975a-8a40-49bc-6f11-08dd35689e50
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTIzLzFkZ3E4Zlg2SFVscG9mdkZkUVZjaWo4N2xpdEY2RENpd2JzWVpwUlZt?=
 =?utf-8?B?SlJFWnY1cms1VEw1UUlZamcvL3N1QnZ3QTBCVWUwVjFaZ2I5RU1sOVE3K254?=
 =?utf-8?B?SWRGUWdVU01rdXFyeURpcExVZ0N3Tyt2WldNSWIvc3p1cEQ2OVM0K0pBMjVN?=
 =?utf-8?B?VStkRk9LMnlzNDRaaDBNT2phNkltTkVkSWVXVXVnM1UyOGcyb3lNbFl2OUM1?=
 =?utf-8?B?VkhoZ2tveXdPR0wxdERjMXlkaFk4NTRvSUtpbjRmTGh6cTlBTHBrZmd2d0V5?=
 =?utf-8?B?T3l2VEFwQkRZYUJvdVM5QXVEMXdwR1VuWUtyTXVWTjljK3Q3Qi9MSkFrZU0v?=
 =?utf-8?B?dmRSZHRNNHh0V1BaaGRUL0ZuYnZMZnB1bFU2WlRxaTYwbGpsdS9ZMUZ6aFAw?=
 =?utf-8?B?cnFnYWh1b3pZNnZrNkQ4MWMvSXBIZ3Jmc3ZpWnE0OWpTL0Jjc0tTalNHTHJn?=
 =?utf-8?B?c1IzeDBwRkdqazczdTVXbWJQVTg2OXlTZnpjSUgxUW01cUVXak8zTFFTUFF5?=
 =?utf-8?B?b01xb2pDUUF2NkRlRXVoNlBjTnNrUEdGUUpsZVdSS3dSMXlBYWhSdGZqSnBE?=
 =?utf-8?B?ckxxRmN3QXVucy9ORDlJT1BPZytwdEJ5dTkyeVc4SmZkYk41UTAzZnNKNGZ0?=
 =?utf-8?B?YktTRjN1dER4a0xCb3lwRlNnZWZKMUNIb2F2R2dsUFRTcTZKdnpXMXo3WGVt?=
 =?utf-8?B?VEY2N2xQTE9iK0dxSFoxVTE2azYrN2w3WFdEN2hBMmNHV0VaU3hnRWkvZkU2?=
 =?utf-8?B?U3FVenl0aGdhdXVxNjhvbHZuVGdPMUhKM3I1dk1MVyswZXRVSU9CdVo0U2JU?=
 =?utf-8?B?U1BMZXNsdEl4b1VIRldSVHZ6L0VHRmthdUpXZ3JHZ0V5QU9PZ1hnNERpQUhG?=
 =?utf-8?B?VTM1d2tlSldvTlVjcDNsN3BRdEwzZ2JlQkZpZ09jSWE2Tjl0bWVJd2l1ejFy?=
 =?utf-8?B?MnNDZmxMUWNZd2JsQ0thOVNlVUhIVDQvUDh4enFUTXcrSk11L0JXbGJ5aFJE?=
 =?utf-8?B?eUQ0SndtM2ZjTFNsUjY5bU56U3BqTW1JMlJiUG8rMXJZM0lQWDA0aDlJTG9h?=
 =?utf-8?B?bDNLRlJVTDhDV20rU3FkVUNFQjA4bTYzYnlFcG1tL2dQSGZMUm04dGRTR2E2?=
 =?utf-8?B?K2FNb284TEFIWEJKSDlqMkFyemxwa2Y4cnhjRXJ1YXpWM1VaREFDelRzNHdQ?=
 =?utf-8?B?dmg1QitxTkRDODBEbngvSHIwTEg3SDdVZmFqUE51bGtjYy9pVGN6NDNXWkNi?=
 =?utf-8?B?djZJQlVMbG5vV1I4czhjUWdlUi9pVk1VNWJ0bzgySnZCMnA4ZjJCWnk4SmJr?=
 =?utf-8?B?UU1kODQvaHgrVldwemVocC9TK0lSeDdiQm9hRkY1NURLRGhMQ3hwWFlkQmFZ?=
 =?utf-8?B?LzRMTkZjRG5jYjZxbkVvWWFHRnVZOHJBalhRM1hjR04xRi9teTJlbU1pOXhQ?=
 =?utf-8?B?TTVxZjd5RGJvOWQyd0JMYnh6MXVZdWRweVJFQmpCVHhEQTJFN2cxcEZnQjA0?=
 =?utf-8?B?SU5tcjBHZkVrRVBxdHVlMmZrZk01K0lPN0hIdWQwL0l1d0FmLzN0bFdjTlZy?=
 =?utf-8?B?TXhzOW5ETG9zb2RJU09BUEFpbys2TC9GMWlYaHhua3JWSjVsZWpGV0d1RnIy?=
 =?utf-8?B?RWJxR0RLbXkxZ0xNUHhOejlMN3VBSHFSQ2Z1aHpYckJaSUg0d1daRWNrUElt?=
 =?utf-8?B?NmIrSmtpTm52WlFVK2hjVGtWdTZ5cE5WelFnbkJWbktWbG5iWU8waXNBMk9X?=
 =?utf-8?B?YS9zQ0ZWaVIyd3IrdlpvM1ZjaFhGMldETWczVnMzZ2lId0xNYWg5UUY2OCtW?=
 =?utf-8?B?RFpwSUhrbDhtRGJDUFVRRDhROGJ3Qkw5NGk2aWxuSDJCRk05M1FwM1RpRURH?=
 =?utf-8?B?RjZJZFVoNkJWMlhaRWZrTVJMNlN4SzZhMEl1Z3RJZHlmcVdJcktSN0w2WmZm?=
 =?utf-8?Q?nYM9+H49lKSdDvcP+eMohOz5KLeFHEcg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEVqeUp3N3BkcVYrb2d4TzkvS2ttZzhJMkNKZmIwUDMwbXVIUUlhVXZ6elRa?=
 =?utf-8?B?TkNwTi9ZS0xqVE5nOFBPMURjRXFhU1lDbW51ejJEK3BPV09xS2MyRDNTUnMz?=
 =?utf-8?B?d0dhTXdxUlhkUEpOM0kzWWNPejZGTkdCdVNmQmJhTjhJYzc1eFhuU0JVWEV3?=
 =?utf-8?B?cGo2K3cxaG1uZEdTMnp2MVJBYlRiMFgvMjFHSHIxNm9RTVlrTHUwTHRQaVd2?=
 =?utf-8?B?bXl3dnFwdkx4VUdWV3c5ODE1cVlGV0tXUUpDaFlxSmg3cHpjb1pOYTZJeEpI?=
 =?utf-8?B?dTArQmt2THVNKytUNUJNa3BOazJneUZuT2tJdm1BNkFBdEovaWtqYlZZWWVY?=
 =?utf-8?B?YW42bkxhWlNhUnRMT3orSDZmUTlnQU9NeDg1RHVPRG50US9jNUpMMHZXTDhp?=
 =?utf-8?B?QU5ZaWppV0Rhamx2cVJtb3BneTBLeE5vNGRzYkRNVkFERDM0RkhPSmVIQmtS?=
 =?utf-8?B?NEUwTzlUTFB6TjF0QXhVYnMrN3NYNmJweXIwOGFOUUxiM0RHellQOUZKRUFp?=
 =?utf-8?B?LzZ3aHFlSzVKQ2pzSUZlYXNTcEhJMUFiQXovRk5YSUVFbHoyVFJwMVBDODVG?=
 =?utf-8?B?ZTl5WnlZWWszZ0hSOGtIUUM2YU5tcGVXK2I3TDlBZzlHQzBab0tsdXF4Nm1B?=
 =?utf-8?B?VGU4KytLcU1DellWa01RMVJZVitlUjF4NW9UY0gyNkFmZzd1U2xzQlVrem41?=
 =?utf-8?B?NnBCaTNPUTFwS1pTYmROUCswT0tYUElFREJ4WXBqYitMYkxTdWU2TFpQY0hI?=
 =?utf-8?B?YXpWRC9HTVV5emhUMDlZRzJnSDYxcURZK045ZE9Oc2JYSzY5em9VQ3gwbVBN?=
 =?utf-8?B?Q3JHV1ZNd0p1c2p1VVhMN2M5d3RpQjZ1NVJCN1FSYkZTT1JPV0wyVlgvRWJR?=
 =?utf-8?B?OVdRTFYrbGQ2aEhzcjhCVHFrUTdoT0JHVW5NNk1HZUJNUEQ3Z2E5blQ4bnRr?=
 =?utf-8?B?Y2gxbHQxWnJnb1k4bE9naC8xSE5tYUtWOFd0Nm11UUxoQ3l5WkdIS1NkZWNz?=
 =?utf-8?B?SmFiTkp5cWltMFVGVlIvRW5HcEZxdmFZaFhSWmFPZEdPWFdjSDUxTnNIRnNz?=
 =?utf-8?B?akNHSVpSOWpMZ08ydkR6TzBPUm9QcjNDb2hPS0tCOC9ydTBteXV5eVlBeWs1?=
 =?utf-8?B?NHdDcy8wM3oxRlMwTE5sM0hyQWJlS2FURlJ2QlBXMUMyaVJ4cnVJcXJUQWk0?=
 =?utf-8?B?RG9XdkMyU0lENWlaMEVtbTFJaEtxb09kR28vdklRWGtZT1FMK3pDTTNnM3hG?=
 =?utf-8?B?RGxUdkV1d2xuU0N5OVFTTE1aZ3l2WUcvR2Z4WW5FemI5UnNMd1dMYVdrcUdJ?=
 =?utf-8?B?OHJLQ2NXbFNDdDhKR21nRUxoakVZM3Q2YzBkOERydmtIbHJMdmhMN0ZGaE05?=
 =?utf-8?B?S2h1cTVqUDQwS0VTMU85ZVZVSElHUUVDN1AzTGRVdFBXOENRVm5PNDhMNTNq?=
 =?utf-8?B?cC8yUUNMMkdOU01nN3dScnZpdkZrVHgrdFQxR3VITFY1UlNxV1JzcHBWWTNw?=
 =?utf-8?B?Y3p1d2FxL1RKR2JyZGYyTmlJOW1LVDk4V0NUOCtXaUcvUWlkVUt1YWh1Y1JI?=
 =?utf-8?B?WVE4MmVVWEV3aS9SQitZUnEvRnBrN1Q4dDJUQ0hwcHZQMjFwM3A2NDhIVUI5?=
 =?utf-8?B?M05VOHlIZldWbERFUVU1V1ZvM3N6MDh4NVM5RFNDVktjc2tyY1g0Q3ZCV3Ns?=
 =?utf-8?B?cHBKMS96RmxLY093a0x2NEQ0YTRPSWYwWElWZEIvam85QUkyUTVBN3czaHox?=
 =?utf-8?B?UExMZjFXb21DaWxYSm9QeWZ4Yi9jUjM1ZEcyN0FBNU1hVDhNRVc1UE1QbkhO?=
 =?utf-8?B?ZGxGcExFbUI2Uk8xd2RxTHc2T2d3MUZnbWhud1ZnTldndGl2RWpyVit2azJ1?=
 =?utf-8?B?aTVlTzFrZkhiaEFzS1J5MWQyQTV3YlN5VW5KNmNqcXJVdUIzempsMUtzSVEz?=
 =?utf-8?B?TmEzeDJtK3FlVENuVy80UDN5R1M4Q2Q1RGZGYS9aNWdTdmtsaXc3Z0tRM2Nj?=
 =?utf-8?B?SVlQRGx5TnczaFBqdHVZS0F5TXhGTzJKOXdGbUFKSEN3QVJoMk9NcTZQQnh1?=
 =?utf-8?B?OVRydXFXcFkrY0tZK0dCb24zWkRyUGppQWVCNFUyS1VCVmk0VCt5MENIcDly?=
 =?utf-8?Q?V4MaqQIA4j2T6wKzmStovTdiN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c95975a-8a40-49bc-6f11-08dd35689e50
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:29:20.6802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IXUmfdR3HsDgBBxL99ImsmrrgIVEDkxhtAtWpfyFO0bMGptFZUwLakGT3tGmdewwElYU6+awP5UBZ1gNfNvE+Q==
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

From: Alice Guo <alice.guo@nxp.com>

This patch provides a pinctrl driver based on SCMI pin control protocol.
Currently, only the PINCTRL_CONFIG_SET command is implemented.

Signed-off-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 drivers/pinctrl/nxp/Kconfig        |  13 ++++
 drivers/pinctrl/nxp/Makefile       |   1 +
 drivers/pinctrl/nxp/pinctrl-imx.c  |   7 +-
 drivers/pinctrl/nxp/pinctrl-imx.h  |  11 +++
 drivers/pinctrl/nxp/pinctrl-scmi.c | 136 +++++++++++++++++++++++++++++++++++++
 include/scmi_protocols.h           |  34 ++++++++++
 6 files changed, 200 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/nxp/Kconfig b/drivers/pinctrl/nxp/Kconfig
index 06c26f156f6c8f63204604d6065485629cfd9b61..ec63ab595650d0dfab7e3a7dc01d4af7814b6773 100644
--- a/drivers/pinctrl/nxp/Kconfig
+++ b/drivers/pinctrl/nxp/Kconfig
@@ -1,6 +1,19 @@
 config PINCTRL_IMX
 	bool
 
+config PINCTRL_IMX_SCMI
+	bool "IMX pinctrl SCMI driver"
+	depends on ARCH_IMX9 && PINCTRL_FULL
+	select PINCTRL_IMX
+	help
+	  Say Y here to enable the imx pinctrl SCMI driver
+
+	  This provides a simple pinctrl driver for i.MX SoC which supports
+	  SCMI. This feature depends on device tree configuration. This driver
+	  is different from the linux one, this is a simple implementation,
+	  only parses the 'fsl,pins' property and configure related
+	  registers.
+
 config PINCTRL_IMX_SCU
 	bool
 
diff --git a/drivers/pinctrl/nxp/Makefile b/drivers/pinctrl/nxp/Makefile
index f10aa6ef188e37583b181bdf9d70ac191e506d75..3ec3e2a9c6fdb875da4ae9bf151df5666256883b 100644
--- a/drivers/pinctrl/nxp/Makefile
+++ b/drivers/pinctrl/nxp/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_PINCTRL_IMX6)		+= pinctrl-imx6.o
 obj-$(CONFIG_PINCTRL_IMX7)		+= pinctrl-imx7.o
 obj-$(CONFIG_PINCTRL_IMX7ULP)		+= pinctrl-imx7ulp.o
 obj-$(CONFIG_PINCTRL_IMX8ULP)		+= pinctrl-imx8ulp.o
+obj-$(CONFIG_PINCTRL_IMX_SCMI)		+= pinctrl-scmi.o
 obj-$(CONFIG_PINCTRL_IMX_SCU)		+= pinctrl-scu.o
 obj-$(CONFIG_PINCTRL_IMX8)		+= pinctrl-imx8.o
 obj-$(CONFIG_PINCTRL_IMX8M)		+= pinctrl-imx8m.o
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.c b/drivers/pinctrl/nxp/pinctrl-imx.c
index b1960c56b512cc113a810304dc3ac3f99b237a7e..0026aae00afe2b0aff40c3288c231b3065ef656a 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2025 NXP
  */
 
 #include <malloc.h>
@@ -65,7 +66,9 @@ static int imx_pinctrl_set_state(struct udevice *dev, struct udevice *config)
 
 	npins = size / pin_size;
 
-	if (info->flags & IMX8_USE_SCU) {
+	if (info->flags & IMX_USE_SCMI) {
+		return imx_pinctrl_scmi_conf_pins(dev, pin_data, npins);
+	} else if (info->flags & IMX8_USE_SCU) {
 		imx_pinctrl_scu_conf_pins(info, pin_data, npins);
 	} else {
 		/*
@@ -216,7 +219,7 @@ int imx_pinctrl_probe(struct udevice *dev,
 	priv->dev = dev;
 	priv->info = info;
 
-	if (info->flags & IMX8_USE_SCU)
+	if (info->flags & (IMX8_USE_SCU | IMX_USE_SCMI))
 		return 0;
 
 	addr = ofnode_get_addr_size_index(dev_ofnode(dev), 0, &size);
diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index fa4c084e2fc067fcb4e92c33312d4f430081fffd..f120e32d9da678d6e9ce583f0ba3c6c17d050f36 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 /*
  * Copyright (C) 2016 Peng Fan <van.freenix@gmail.com>
+ * Copyright 2025 NXP
  */
 
 #ifndef __DRIVERS_PINCTRL_IMX_H
@@ -47,6 +48,7 @@ extern const struct pinctrl_ops imx_pinctrl_ops;
 #define ZERO_OFFSET_VALID	0x2
 #define CFG_IBE_OBE		0x4
 #define IMX8_USE_SCU		0x8
+#define IMX_USE_SCMI		0x10
 
 #define IOMUXC_CONFIG_SION	(0x1 << 4)
 
@@ -65,4 +67,13 @@ static inline int imx_pinctrl_scu_conf_pins(struct imx_pinctrl_soc_info *info,
 }
 #endif
 
+#if IS_ENABLED(CONFIG_PINCTRL_IMX_SCMI)
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins);
+#else
+static inline int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	return 0;
+}
+#endif
+
 #endif /* __DRIVERS_PINCTRL_IMX_H */
diff --git a/drivers/pinctrl/nxp/pinctrl-scmi.c b/drivers/pinctrl/nxp/pinctrl-scmi.c
new file mode 100644
index 0000000000000000000000000000000000000000..7d2ed6542dc5166ebb07ade6e931b83b370af386
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-scmi.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/io.h>
+#include <asm/mach-imx/iomux-v3.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <errno.h>
+#include <linux/bitops.h>
+#include <misc.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+
+#include "pinctrl-imx.h"
+
+#if IS_ENABLED(CONFIG_IMX93)
+#define DAISY_OFFSET	0x360
+#endif
+#if IS_ENABLED(CONFIG_IMX95)
+#define DAISY_OFFSET	0x408
+#endif
+
+/* SCMI pin control types */
+#define PINCTRL_TYPE_MUX        192
+#define PINCTRL_TYPE_CONFIG     193
+#define PINCTRL_TYPE_DAISY_ID   194
+#define PINCTRL_TYPE_DAISY_CFG  195
+#define PINCTRL_NUM_CFGS_SHIFT  2
+
+static int imx_pinconf_scmi_set(struct udevice *dev, u32 mux_ofs, u32 mux, u32 config_val,
+				u32 input_ofs, u32 input_val)
+{
+	int ret, num_cfgs = 0;
+
+	/* Call SCMI API to set the pin mux and configuration. */
+	struct scmi_pinctrl_config_set_out out;
+	struct scmi_pinctrl_config_set_in in = {
+		.identifier = mux_ofs / 4,
+		.function_id = 0xFFFFFFFF,
+		.attributes = 0,
+	};
+	if (mux_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_MUX;
+		in.configs[num_cfgs].val = mux;
+		num_cfgs++;
+	}
+	if (config_val != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_CONFIG;
+		in.configs[num_cfgs].val = config_val;
+		num_cfgs++;
+	}
+	if (input_ofs != 0) {
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_ID;
+		in.configs[num_cfgs].val = (input_ofs - DAISY_OFFSET) / 4;
+		num_cfgs++;
+		in.configs[num_cfgs].type = PINCTRL_TYPE_DAISY_CFG;
+		in.configs[num_cfgs].val = input_val;
+		num_cfgs++;
+	}
+	/* Update the number of configs sent in this call. */
+	in.attributes = num_cfgs << PINCTRL_NUM_CFGS_SHIFT;
+
+	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_PINCTRL,
+					  SCMI_MSG_PINCTRL_CONFIG_SET, in, out);
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret != 0 || out.status != 0)
+		dev_err(dev, "Failed to set PAD = %d, daisy = %d, scmi_err = %d, ret = %d\n", mux_ofs / 4, input_ofs / 4, out.status, ret);
+
+	return ret;
+}
+
+int imx_pinctrl_scmi_conf_pins(struct udevice *dev, u32 *pin_data, int npins)
+{
+	int mux_ofs, mux, config_val, input_reg, input_val;
+	int i, j = 0;
+	int ret;
+
+	/*
+	 * Refer to linux documentation for details:
+	 * Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
+	 */
+	for (i = 0; i < npins; i++) {
+		mux_ofs = pin_data[j++];
+		/* Skip config_reg */
+		j++;
+		input_reg = pin_data[j++];
+
+		mux = pin_data[j++];
+		input_val = pin_data[j++];
+		config_val = pin_data[j++];
+
+		if (config_val & IMX_PAD_SION)
+			mux |= IOMUXC_CONFIG_SION;
+
+		config_val &= ~IMX_PAD_SION;
+
+		ret = imx_pinconf_scmi_set(dev, mux_ofs, mux, config_val, input_reg, input_val);
+		if (ret && ret != -EPERM)
+			dev_err(dev, "Set pin %d, mux %d, val %d, error\n",
+				mux_ofs, mux, config_val);
+	}
+
+	return ret;
+}
+
+static struct imx_pinctrl_soc_info imx_pinctrl_scmi_soc_info __section(".data") = {
+	.flags = ZERO_OFFSET_VALID | IMX_USE_SCMI,
+};
+
+static int imx_scmi_pinctrl_probe(struct udevice *dev)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret) {
+		dev_err(dev, "get channel: %d\n", ret);
+		return ret;
+	}
+
+	debug("%s %p %s\n", __func__, priv, dev->name);
+	return imx_pinctrl_probe(dev, &imx_pinctrl_scmi_soc_info);
+}
+
+U_BOOT_DRIVER(scmi_pinctrl_imx) = {
+	.name = "scmi_pinctrl_imx",
+	.id = UCLASS_PINCTRL,
+	.probe = imx_scmi_pinctrl_probe,
+	.remove = imx_pinctrl_remove,
+	.priv_auto = sizeof(struct imx_pinctrl_priv),
+	.ops = &imx_pinctrl_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 7abb2a6f36ba53223bd9103fcc02f58506fbfc8d..2367467512a6b65253317e51bea71de396aa96f9 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -24,6 +24,7 @@ enum scmi_std_protocol {
 	SCMI_PROTOCOL_ID_SENSOR = 0x15,
 	SCMI_PROTOCOL_ID_RESET_DOMAIN = 0x16,
 	SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN = 0x17,
+	SCMI_PROTOCOL_ID_PINCTRL = 0x19,
 };
 
 enum scmi_status_code {
@@ -1005,4 +1006,37 @@ struct scmi_voltd_level_get_out {
 	s32 voltage_level;
 };
 
+/* SCMI Pinctrl Protocol */
+enum scmi_pinctrl_message_id {
+	SCMI_MSG_PINCTRL_CONFIG_SET = 0x6
+};
+
+struct scmi_pin_config {
+	u32 type;
+	u32 val;
+};
+
+/**
+ * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * @identifier:	Identifier for the pin or group.
+ * @function_id:	Identifier for the function selected to be enabled for the
+ * 					selected pin or group. This field is set to 0xFFFFFFFF if no
+ * 					function should be enabled by the pin or group.
+ * @attributes:	Bits[31:11] Reserved, must be zero.
+ * 				Bit[10] Function valid.
+ * 				Bits[9:2] Number of configurations to set.
+ * 				Bits[1:0] Selector: Whether the identifier field refers to a pin or a group.
+ * @configs:	Array of configurations.
+ */
+struct scmi_pinctrl_config_set_in {
+	u32 identifier;
+	u32 function_id;
+	u32 attributes;
+	struct scmi_pin_config configs[4];
+};
+
+struct scmi_pinctrl_config_set_out {
+	s32 status;
+};
+
 #endif /* _SCMI_PROTOCOLS_H */

-- 
2.34.1


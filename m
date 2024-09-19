Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039C6CDD562
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 00:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C911389042;
	Thu, 19 Sep 2024 02:14:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o5nPnKF6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C377588FD4; Thu, 19 Sep 2024 02:14:55 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB0768905A
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 02:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T62yWcNwZVl1Sae9zp3dbPGzk9D7f+4/vqJ8+kHsC/cVeJly/7lvsMwDzoWlcThQaLSVdPtPPrm6tHjR8mGGt/qjQ70MwV6qAklyCE+tMqrhfyG7sbOm3AMq4c87LjDW+4gtaqCyn3E1/FJQs0T50+c4qfabfX02azEKQ1XaXzPYIUCYMSMQcnB0L03QBWl39jnboGCluRMBBlj/V+kVDvaZ1uYOdYq7D53mD7EX/N+JkSXaTltXo8qLpbxJOnt5asdn6HbSDDafTljTL9pB9c/0omzLGosBmlhoMsle6p95WUbod2N5dFmb4It6ip5NpJ4dX909jundvalNxN84Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ca7coGzMkj9RKeDXERA1p06a3pAKcsazG3J2hTrfkk=;
 b=gBnSmtdP7pq3HqW0kGkb2ZewJdqtJKA/bm0RtbU1qZTe9YSTnc1DCDzrESpXBTq5LUTdt3xHqKumAsWnNq7cb0qUqzgZ7VzFIi+yJ17ZTuHSyGLR4LLsTBKpiVau1g4p6ALg0IUneFCe7ICAx/QlmYuLsZ8IfH7rFv0XO7Rh2ebsSrgVc64QA7C7wLH54pjh/uhMDrPYJViGkiL96Axg1ZCp890x0FsTwo/u8Jmqoeh8OzH9PKI0RpE5eHotp6MegzH794qYZTWPKvWEqa32jgP1DLE4McLWchWOLc8o5PHAVki8l3pP/bcT4MV7LmHVDdAi3QiSXR2+eWGd5wvY5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ca7coGzMkj9RKeDXERA1p06a3pAKcsazG3J2hTrfkk=;
 b=o5nPnKF6FGQXVu9n0w0KBo0qMF5GQFpoXdqppiy4dOCGbV3vzHsqK/BSAQ6sALYMhTj0LQ60+5GpMDEEUB32T7xW4b/NBHezOAGRmrB/2FSMo19AQLhyksfxWh5nWTG+faTvX/HW4Z3/whLXDR2I0VpC380vImuJYNVQET2I2TVNi9deP4iQt5Gj3Cu+9bI8bsgGisuxWp/i7o0uy50PpelVUsK4+/i7ty3Pw6Xucm6jNxDapsRldpCHLT6qrto5zHWsNMxfw1+Uq1sCJIjn5njDkH/zCfWBryWfvn+9tEqQYjxuQa/s/05HXw9rgkvFSsqIYxzmsa9FLApuYxNWQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB9066.eurprd04.prod.outlook.com (2603:10a6:10:2f1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 00:14:50 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Thu, 19 Sep 2024
 00:14:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 19 Sep 2024 09:18:03 +0800
Subject: [PATCH v2 04/21] imx9: soc: Print UID in big endian format for EL2GO
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-imx9-update-v2-4-0d798d9e08ad@nxp.com>
References: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
In-Reply-To: <20240919-imx9-update-v2-0-0d798d9e08ad@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SG2PR03CA0130.apcprd03.prod.outlook.com
 (2603:1096:4:91::34) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB9066:EE_
X-MS-Office365-Filtering-Correlation-Id: df145e9e-c1c2-4e6a-39f1-08dcd84013fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dWN6Y0t6ZjRxZGgxcm5iNnJCVWhva0U5cUo2VGc5T1dleUVEdWc4SkZad0tM?=
 =?utf-8?B?dWpCYUM5T2dFd1VyZEdtaURleGx1YUN0enBuZ2pSVElHSE9CcmEzWkxncitr?=
 =?utf-8?B?cXYyM2FPektCakFESG5iaG9ZVTN3QUFubnh2OXBSRHJRR01QUXByRm9uQXZY?=
 =?utf-8?B?MHhMNUpaU3JFb2w3ZmlrMjJ6RDZhaHRvZEFORHd0MDdWMGdBZjFRb2VrbUdZ?=
 =?utf-8?B?SktqYTcyQXEvVjJLNlpHbVcraTNyZENKd1phdGJHdWMxc1ZtOFlMeGQ4MVEy?=
 =?utf-8?B?VzBZM0l3bVZadFhCYmo0c3BZdXliOWs4cVorNHN4eGduVWtYZVpGZExrSDJO?=
 =?utf-8?B?eWYwQnNsc2VUVzk5dFFWb3ozRWI1dFEyRStaMUliS3k3UnlTOURqbytwaWpE?=
 =?utf-8?B?RzhNTFhpMWxqeGdrVzlXdFM1UFF2RG5sRGtVNyt3U21vRG1LcnBOcW80cCsz?=
 =?utf-8?B?QVJVWWNUZmNzWDhiUUJuMUlxVkNyU3ZnRC9DUlZnbWxxNy95YmEzeGJOaDBZ?=
 =?utf-8?B?MXUyVWY5MWlOcjJYeGZoeWJWbjNUbVBlYUsyOEk4MFRHYkFGZm5sU29kakFp?=
 =?utf-8?B?L01jdTZhWk92alF5MGx4UitYRjNYZUtWTnhneXN0Mk9DL0NNeUNBL2tGbXdn?=
 =?utf-8?B?Sk5aTjhvOUY3dWE1bTNlOTJIQ1BrYVFobWRqK0Vnek1TL3Nqbk1mUXhsSU82?=
 =?utf-8?B?UGEwVEttWUJ1Q0J2VHFmSHhUdWs4TjdMZ3JQUVo1MWt3T05PS2prZFNPZ1ov?=
 =?utf-8?B?NVJUUjRNcGc1Z00wSk1od0VyQUpESnA4VElUYnJaMmpvWmd5eFlLbnFLSFVN?=
 =?utf-8?B?U2RKdjMxMHAyRGFPaDhUUXpUNzRCc1VVaFBJTnR3dzRUTVdvTHRSS0xuSzFG?=
 =?utf-8?B?NzEveGkzOXF5V25sSE1yU3hvTjU4amZvRjR3UE0rWkJLN3Z2Ymw5NTFNeFFT?=
 =?utf-8?B?WS9iaWc3ZnFMU3hLRnVtMGFPalhkMEp1a0EwR0lFSDNzMDhZaS9ORUZhRWx3?=
 =?utf-8?B?UHFucXMwWm5JYWg1U1V5T1hkaTNXZkJRQnhBcUVMVi9SNVJjRW13eCtGZm9q?=
 =?utf-8?B?R3ZwbjdFUzg4L3ljeHd0ckt6ckczSHpReDQ2YXgrOGFkdFY2bjRiMHdiRXRn?=
 =?utf-8?B?Y0IxME5WUGNhVGNqSVVzRTUrYjllUERyZEl3KzVwbDh5YmlxZmlYeHk0OXhl?=
 =?utf-8?B?N2d3ZDV6VlRRVUlwRTJCM3ZPZHduRkwvbVZ0L21FWkdZN3dSaDlZd1BTUGZr?=
 =?utf-8?B?a0NTUjU5TlBDNnp6bVBxTUxyTGYzWDBtUE92bWRlMEo4RnFUQjBKTVFYRkcz?=
 =?utf-8?B?VjZXcmw3b3BRdS9rZHMrbkF4TFpucEdsVmFBVEhzd0lLTFFMV2FFcEJrZVBo?=
 =?utf-8?B?ZXRHVnJabDQyTUhrN1RJVDBDWXBaR3RtaGx2c0hHTnVocDVNVENkRWVleFVS?=
 =?utf-8?B?ZktmRmluNzdhZ2Q1a3hrREJ3RmhCNUs0M3hLSTY1L2QwMFo5ZXpWc1JYbFl6?=
 =?utf-8?B?MXhSY05sNkpEb21yczZyWnRUR1d6TDFPbVJYQmJaL2ptMnJpZEI2S3dLQTdH?=
 =?utf-8?B?ZGI5cFZjQlVYSG1aUTVRVUlGWU5DTDJ3ODJjN2hVcnZsSlVoRW8vVlp0VXdv?=
 =?utf-8?B?NmxYV2hvYUhyR0dMR2dPUGVBcmp3akN4TXVCSEE0QWtMZmtoVmZlRUxGdW9G?=
 =?utf-8?B?QkoxVWhnYUZRWHlreW1qNFlyR0NQbks5ZVhTUENkR2NZdyt1TmRFQm9GQk8x?=
 =?utf-8?B?dUtsamt5V0QyRXJPdlo3YThzNktVWGgwYzZxS3lJVncrdVVITDE1R2FYUHpG?=
 =?utf-8?B?akZYbTlZZEQwN0EzWEM1c2VYaFRnV01OVjlUY2cwL0FYWHorbmQ2cE96OW9w?=
 =?utf-8?B?RCtiM2xTd3d3QlpBeDJ6Zys3Q1AzekM5YkNkeWVpRXlQNVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxQd1hmemNZMExkTFo5VG8vU1lndnprK3NLRFl0YWV4Y2xTTTlzZm52OVJH?=
 =?utf-8?B?a0hzVDR2NTg5aHNYVHJ1K0JLb2d6blRPMDJTZE0rNXQ1S2Q4My9ZeDJTYisw?=
 =?utf-8?B?Q2pwMDNUNjFUZGxsSXpzODM1OHBJVVlKVTBGdHY3TnQ4M2IrbmUzNTRuN212?=
 =?utf-8?B?cWNVTGVWZ2tQaHZzdkVQUkJhY3FUWFJvNmoyVGhYVXAzRG1tZzZkZjk5ZzZV?=
 =?utf-8?B?SEczUDBHYzVGSlRmQ05WMkt6K1BhbEtodnhMZTFkWXorRDZISEJsbVhNKzlo?=
 =?utf-8?B?THNqWml2WHNuNktvNHZqcmNRQkRRQkxKdjRzK1ROM2FVNVhLdE9YOWtHWGFh?=
 =?utf-8?B?YTJLQ2IwalFDbGZUVmdQellEY3BOL3d3VEVRQzYwWjUrVnRjWWN2VlBkb21N?=
 =?utf-8?B?RWE2aVVIcURDd1ZyVHRyb2JxOStrWUVnT1hEb0czSEg1eFN5ZFFmbXljWUk5?=
 =?utf-8?B?MnZlNnVmcjYwWjZmMUVRaW1ySDJBZ0pJbGdGczFBcTc1MDkvaElyeFFmcXd4?=
 =?utf-8?B?cy9kTlF3OS9yWVZFd3kyTGtFRlFnYndYRHJpbGsxNnZUaG5kdGNvNk5CSXhB?=
 =?utf-8?B?Z3NWSGcwSFduSHJpWU16R0cvVHFhZm1xdW1UWUNEWTQ3aXJOZ1NFekRuUjZT?=
 =?utf-8?B?NHQxNCtsb2RrNFR4c1cyNXM1cytrdW5IR25OTjkrUWtwdTBZTnhMcjZBa2cx?=
 =?utf-8?B?WG5NWkpQVWY4eXE0OUNzN1lKcXJqZkpPblZ2RzQ1S29oZzAySDRXS21zVERw?=
 =?utf-8?B?YjBTMjZjWlNHS1FNdFRDdFl6azVMaGhRY1N0TTcxU05ONkxndG9KemNidi9K?=
 =?utf-8?B?Nlo2M1FxMU9vckpXYVVqNWNyV2p2V3lPS0tvTCtaTytkVjZTNmcxaTNvVWgx?=
 =?utf-8?B?dCtjdWtQMEJzSmIrVjZaaGgvZGNTS1NMVUJRT0YwWDNHaTNWbmttTTNpTVpX?=
 =?utf-8?B?c0dMVUJOdEtpU0FZWUNGNXBoRzFoWS9CcmVEVW9NZGx6K2RLRUZlYTBaZ1hC?=
 =?utf-8?B?WGlpTHZvOWtML1dGZUsyNDZOekNONEp5Z2FlTENNUXNsOVF1cnh4QitsYTRo?=
 =?utf-8?B?SXRhS1R2RStaUDg0L1orQXRjT0RlalVoeFVWT1d0OGRlbC91SjZTTHFlWUIv?=
 =?utf-8?B?ZTN3Nm05SzA2UnIzNnJSWWV0Z2hNQ0ltL0VOTWgwaE15RkpUNWF6dGQ1UG5r?=
 =?utf-8?B?bEg5a0ttTllWLzJQSForL3dqUHRUOEtveGNkaTlDcktCcEY5QnUzK2dVZ0ZV?=
 =?utf-8?B?NXlKczFKRXlGdnRFT29na3cxYXQ1NUNybFNLbHZGUWY1dndGanJmcmJXQWtX?=
 =?utf-8?B?cUt2aVRLMlFIMGRaUXBsdVprWVVEZElpMnZuWGx5SHhOdVVzUm9FOXlpVjlC?=
 =?utf-8?B?L21jRUpFRFhIQnlOKzJHQUROb3hJNHBVR01vc2FIU1NyNlRYWXFkSUtiZkt0?=
 =?utf-8?B?ZXVtVWpaVjBwajZwUlArN1RRYThBNWVzZmdSaGNGQjZZdW9BUjRVTXZEVTE1?=
 =?utf-8?B?TWhKRkFKS3hMTkU0STJFbjBoVWJiK3Bac1NVNWZkdm1mNVU4eHNhR2EwOC9s?=
 =?utf-8?B?RWhMMWxwYk0xQkV5K0NKM0dYSHRXY2tBWnBvdUpkdURtTWJKeGJOcXJlelZs?=
 =?utf-8?B?dzVWQlQ2NURVWDZ6dmkyWXRWMzIyekxBZ0QwSnlCR2JRajZ3OXBpcGpGTzFk?=
 =?utf-8?B?Zm9USnZJNXc3R0dLWTVyZDFJTUFRbmZGWTF3QnBrVzVqMk12bCtMUVBZZnNx?=
 =?utf-8?B?ZEpLb09naEVKNC9KN1Z1MzZBc2tDOGR3bXFzNjE5Z3U4aWJuTmpXRTlzYjcy?=
 =?utf-8?B?YTcvdGxCdkp2VXJMdngzUlhkUnVKaEdyeE8rQ2xpZkNVUnQ5YTAvdEpmMmUw?=
 =?utf-8?B?MHMrZDM1dUJITklJYVRtL2VnVzRyLzZnclN4aGpYSUV2VDVDeTB1VEQ5Ulov?=
 =?utf-8?B?UXh2Q0g5cm9HVEpneDNzMFJ0MG9WS0pVbHRhSm5ZQzJUSXdQMnhnKytLMUts?=
 =?utf-8?B?YmhQcHZpU3dXYUZRN1BTQkxMRkRrV0hBSUUwVTN1bHhieGVvM0l5VnJOYlBL?=
 =?utf-8?B?SS93a2JHUDYraXlFTFEyMFNSclROaE12WVJlRFFYTE4ybkU1UHlOdEkyaU1F?=
 =?utf-8?Q?3AYnqzjbjb4aNUjUK8zmqy6Gc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df145e9e-c1c2-4e6a-39f1-08dcd84013fe
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 00:14:50.5972 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrR0CiELiqfVRCp5Iq08NPzPgQL7oSF6i67780sximK5AF7PezFZMY3cgxie0gbVTVdn4p7rwPQLDPmXGodiqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9066
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

Print UID in big endian format and as one buffer of bytes, so customer
can directly use it for EdgeLock 2GO.

Before:
UID: 0xf6c8ae93 0x0f46b326 0x10d61eb3 0x0583c2d2

Become:
UID: 93aec8f626b3460fb31ed610d2c28305

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index f458fc0564e..7df3c686350 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -560,8 +560,9 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 #if defined(CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG)
 void get_board_serial(struct tag_serialnr *serialnr)
 {
-	printf("UID: 0x%x 0x%x 0x%x 0x%x\n",
-	       gd->arch.uid[0], gd->arch.uid[1], gd->arch.uid[2], gd->arch.uid[3]);
+	printf("UID: %08x%08x%08x%08x\n", __be32_to_cpu(gd->arch.uid[0]),
+	       __be32_to_cpu(gd->arch.uid[1]), __be32_to_cpu(gd->arch.uid[2]),
+	       __be32_to_cpu(gd->arch.uid[3]));
 
 	serialnr->low = __be32_to_cpu(gd->arch.uid[1]);
 	serialnr->high = __be32_to_cpu(gd->arch.uid[0]);

-- 
2.35.3


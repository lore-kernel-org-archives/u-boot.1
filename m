Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B250CCF9F8
	for <u-boot@archiver.kernel.org>; Wed, 12 Nov 2025 08:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B44AE83C14;
	Wed, 12 Nov 2025 09:16:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kpHD5Nrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F72283C23; Wed, 12 Nov 2025 09:16:46 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80C6483C08
 for <u-boot@lists.denx.de>; Wed, 12 Nov 2025 09:16:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHoJk/XiVKNZIHBYnumUIFVgWbPE8FYuHY1ZB6H2THzQ1BhaqkXt5Vl689eH6g667zqv21yjFWqFA9IStGDy7rhrYcck+uKAI2sVBxEQOeM/1Av+YWzRjayeUKKi5NQB0xvhdMUChKfDMUKiihKb/VT/zUR09qVZ8TE/0pw4hM217CKnclpjvhyPZexoLbPjVwOCVLWnc+5++JSvematWH7ZlXray/CilNiCIEgAb6BhzyZvGS0u+0Clxafqwfcnmv0ufz3iDz1AI8umZF6VQyl85D5epEt6xvSEcGV06wkuWoJ5Li3OL+KH75opUOaILSF6QyYvIRUbxZ1HKLJrQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bvrd9RMqN2EXBNhSbVpiR3l/hKKzJVhNmQgChEbP0sk=;
 b=ZlEMUVKk3r8iTb2GeqWNbMAbFEjhMLr0jGBatmbOafuM/0pej2vMJDwhi3VVYW65gHGMfKWKX6ke0U4wtxGEoirZivY3CloYr9tzW0dwA7m7EbAVYK8QaEsoXyjybP+RsSsojLaHVw/W2/qrqu6x7dEjLQeL/E2VjfDNNkN95ze9SW2MXYgZK4/vjtWHikWFg6kzpg6EKMPcPhZ8EpjgxG4nEOVEzByGLkIae9nH4k/RPH4s1yF2Ry3VQ3IoFUBFTvmJrd/LnMhLUtD9H2IaN6bTL+VPQn0JVBDhqahfi2/Bnrl/mAY31TxX+cdhifd5b/NXi+OMqlIODKd583rcDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bvrd9RMqN2EXBNhSbVpiR3l/hKKzJVhNmQgChEbP0sk=;
 b=kpHD5NrnIU2DdZM121bZssC4T7ZfiUoiu2y/eHDPOtLzivk2QyGD9fIqmOkbyVAwFjUYjHDEXZTIt1U3fdXSzKbA3Wtd+9x1nwv9IgTnJ/IhCoIC3pdq0WR2FZ8NCtpk1z1DFicq1qUaz7gtx3b2LmsXj69O6dfOZXQdqlvhI+YjhlNbQ/3CHg4IprtrtGiDgJbr9d1E3rY43hhby6qnibqnzWKxgaffb+PJrHADYApCNs5fyqwuah4WnkCHeEIVfPUVzbncs8gqPjKxx7V19BqBtitcJ21SM0N3b0m3d0F0Y52tvNzSP99tQOv1GVWyWgN2W86kLWkwAwRDABMkag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AM0PR04MB12049.eurprd04.prod.outlook.com (2603:10a6:20b:740::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 08:16:42 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 08:16:41 +0000
Message-ID: <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
Date: Wed, 12 Nov 2025 16:16:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: Fabio Estevam <festevam@gmail.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Cc: uboot-imx@nxp.com, trini@konsulko.com,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 u-boot@lists.denx.de, u-boot@schwermer.no,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Jacky Bai <ping.bai@nxp.com>
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
 <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0049.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::20) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AM0PR04MB12049:EE_
X-MS-Office365-Filtering-Correlation-Id: f677d5ba-54a7-43e6-c152-08de21c3cf21
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|42112799006|19092799006|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZlY1Y3YzRE1MV1Noa3dPUlVON2s1WS9rUzZMR1pFMExNTlo2TnZJYTBrcmtJ?=
 =?utf-8?B?K0Z0dFlhUVFVNUorT3RjeWdyVVVha1pYVHRtRTE0ZDRwbkF5RkFETHJwR1FM?=
 =?utf-8?B?YTlkVDdVY0JveVAxaFpndHNFc0JsbFdEUktrb3RIbUpWS05mTlArTzEwcm9X?=
 =?utf-8?B?MFBmNEZ1eE96M3Nza1VJU1dpRXFsdjREUTFncGpBNFlINTE0Y3ZxUlpOWFk4?=
 =?utf-8?B?a2Y1VFdMZVAyZXZBVTVxTWxvVkplZFZUeC9WSkFMZ3NTSDVuM3JnNmgwM0VT?=
 =?utf-8?B?emJWUEpneUJhZ0F1Z1NTbnhsc3ZZbXpXdStoUkFOMlFqZ0xnRks1T0RjSGJQ?=
 =?utf-8?B?aDJtRUFyN01FS3hTa1R1TERxSmdsZFFDMC9ic1lNOVJTWStJZm5oeVJtQm1u?=
 =?utf-8?B?cGY5UndYMThUWVZ1MW9pSU9OUjJ4NEVxZ3NDTWxWZnBEVGozVStlOHY1VGxz?=
 =?utf-8?B?TTNlLzNuOElhc2c3RVcvUEgzLzUrZk5oRDJ2NmF6UURmOEVkbW1TY2MzRk1Y?=
 =?utf-8?B?SHFFa2MvY3FtOGF4eVhmNTk3dnMveXRUK20wMkFwekhPZmFFZTdhaWhsR01R?=
 =?utf-8?B?SENnd3RON2dZamgvZ29rbHpIVndEK1F6OXZoMldkaG9lTHFkdzRtQWZwTGFK?=
 =?utf-8?B?WHpkSVlNNjhsUUlMNDNnM1RwU3BONUxyV1h6V3NrZGpCT0dWbHpXNnkxZVZP?=
 =?utf-8?B?a0k2UjJiUlBpZEphOExHTk9ZcGU0Q1ZjOWZTd3JMMkEvMFIrUXFsRDlOdERL?=
 =?utf-8?B?OG81OGF3aW9JOXRlV0JUVnd2R2laTWZBalVEMCs3V201VW9GeXYrcU5EbGtz?=
 =?utf-8?B?NTFoeTVETUdmdTNzRHVNL0NYSW1GOXF0cFJxWkdGOHZrbDI3aHlqbEY3R1Y1?=
 =?utf-8?B?eEluMmxHNW5DOXlZSVoxdHc2SHFaRi9TSngyc1JaQnpUZUE4Z2FWNXVTKzBo?=
 =?utf-8?B?amtUV0k4QWg3cmlZd2dFekhGZ0gxYkZTdTJ4SkZqUmpJRHVuSFQ2ZHlTUmFF?=
 =?utf-8?B?MC96NjA2TG81UlBVckw4TXRhN2VHeGU0NGNaVHRpQnNTSWE0ZDJTZVdYTldG?=
 =?utf-8?B?YkVyOXU5V0psWE1YY05HLzhJME94SlRwRm5qM3VSMklsb0pIZ1F2YmRyQUJR?=
 =?utf-8?B?c2dLV0RleGRWOG8rZ1RBWkVXdllZc3Z2NmZUeGZocUJYYVZJRm1oWTFOanRH?=
 =?utf-8?B?ZTZlVHVOR3pEL0FKR2FrODBGZjRybzl3cWluUW80OEIybDNFenExOHluTktD?=
 =?utf-8?B?bGlKWkkrN0dnazdwdE5NYUtGWTkycFVkODZSMUFOeG1zaGc4aHZUUlg2VmVw?=
 =?utf-8?B?UnZpem5vNDgwSzBSdGZHMGlGT0puZjVoeXA3bFVVZjRDd1phelQyaWFCTFRK?=
 =?utf-8?B?SU8wQ1lycUFKczJWNzZVMzJGS0VEMEFxMi8yQSs5MGhlV2RSRCtXS0ZaVWpk?=
 =?utf-8?B?THZHLy8vRVBOckxLajUzMUpkeHlwb29vMm1HRGhHZXRPdEtDWGZNOWo3VEhO?=
 =?utf-8?B?MnRxOGZBS0ZQcEVqUVdNSjFkeW9qY2VYMEhsN0VBem5hVWZscEtic3hqdHd4?=
 =?utf-8?B?SlpqL2VaZVB6QVh5RGRJR0M1NUFHQXhxdmN5cUh1RjdMZzlCSFlmWW5kbHN2?=
 =?utf-8?B?SVlQZHY0dzRtK1BCVVJObkFHank5MTYyN3I2cS9rcDVGK1JNdlkrRWhGbDNh?=
 =?utf-8?B?aFZsdmxvNjZhb2tPVlFCaTQ5NWp0MVR4c3c3R01yVUx3NzdOQVk3S0ovd21w?=
 =?utf-8?B?NXg0Q0NWUkIrTHVlWjB0ZDgzd3M2WlF0aHNoL29zK0M5eDI5UmRPbDd5Y1hz?=
 =?utf-8?B?UnduZnNzd3hzeWZEUGtKVjZPQlRTSHBVWDIzei92a2M5a3YzbUY0aDRiWk5Y?=
 =?utf-8?B?Q21lNk1PMmdFUG9SNlhJWVBUSllkc2I3WXRNWnBCQVNwNERmOWpGSTZEcE9J?=
 =?utf-8?Q?VUhFTH95k8M7Uxpmu8KP0KRevrvBM+ix?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(42112799006)(19092799006)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFAwbXZRZTdhODE1UE5GS083MVRhblVMWm5hd0NYcVVxUkpYN0dXT1NxQzNk?=
 =?utf-8?B?TUlQRmVWeWZORy9yeHF4eWtPbyt3UjZMSnJRcWxiWXZWRVg5dG9zM29SZjda?=
 =?utf-8?B?RStzek5sZTNOWU5lSWFNOFA2dEpyMCthd0xEcVRHSmIrOTJnUVFGRjYyRER4?=
 =?utf-8?B?S201enZiOGRJd3RzNlJnQ0F2VzZLUzhVa1RmaS9ibEp3c0NOeHllSWR0Vm1B?=
 =?utf-8?B?dGZZMmxBZTdhK29uZmR5N1pIcUVoMlQveDBuQmtkUWRET0g4TDJWMFdTaDAz?=
 =?utf-8?B?SmhzZWdsTndCVVFTZThodm9DenNnc1hFNmU3OEp4S2h6VWowSEc0aFNYLy9s?=
 =?utf-8?B?RFVhQnFFa2k3SHN2S09Kajc4S05VMVNiZDFrbGJqU2RabG5FQmdaRGNFVlgx?=
 =?utf-8?B?UWpad1E4UW1WWFlHcTJuRTQ3V1FNMnRvQjIxVktIZG95WktaMUV6dU9lb2RB?=
 =?utf-8?B?ZjJ0a01qa21rMmRlZnM5RFBER2ZwcEJhaUdzWEswRVRWbWhrTkFFa0FFeUtH?=
 =?utf-8?B?NGFGOFdaeUZkZWgwWWJvbTZwWWNGaWJNWDkvZ3BaZ1lKOEF0YWZJT0lkcXRM?=
 =?utf-8?B?VWpwWUxENk4rOXduZXl4eFJuQlNMTkxueXhjOG5VaDR0d3dxWSt5Tk93VHhR?=
 =?utf-8?B?TDc0WWhTRkNRcmdVVnVPYmpicXIwZUczV2t0YytoRkdheVFJdTFoK3dSdHp2?=
 =?utf-8?B?Q2l4a1AydlpZVEExZW5jalV0SUJsRWlsUHUzaUt1Yklnd1IzQ0t0V0NFS3dq?=
 =?utf-8?B?Q0FvWjBkcDVzcEhHZTlTSytoeFpkdHdndFBubEFodTk2R3dGS3UwTy92bTRT?=
 =?utf-8?B?My9KTlc3SU5sZE9EbEx1ZkZvdHBGNUFoL3NPR2RtalB5Y0ozR3A2ZzlyYTNM?=
 =?utf-8?B?bEVMbjA3dzNNTGdleDJwMU11U0FYNCt3c0ZyUE40SWluWm1zeXp1bW9ibHJR?=
 =?utf-8?B?ZzhzemNGMHVGdXIrZmhYSWxGMVcvcFBUS1ZQem12UThtQkN2eU5LdFlYTjkw?=
 =?utf-8?B?S2VKb1VjbFJvSFVNbjZuQ0Q1M2RwR0VtZzB1UG5SQUUveXRITHRzK3I3T1lX?=
 =?utf-8?B?Q1NybTlrY1pNMVV6NTdqcFFTT0MrY2ZwL0Z2enRpNUd1SlBDblZzUjJLRlhH?=
 =?utf-8?B?QjhSK2lVdllsdW11OSt1MzcvWFVkaWpnaExKUHB6UC9zRnd3U0JTcVNTQzdC?=
 =?utf-8?B?TkQzY09PODRIWWdDbnZiQ1pGVmdRendRSUt3NUVINUhTWFVyb0txOURzSlZE?=
 =?utf-8?B?T2ZtN3pNZUczMXorMmRyb1ZMdTRhN0ZjYmhocHBYOHJXaHFwcUt4ZEUwQnEx?=
 =?utf-8?B?MnM0eGZtNmlBcFlBcHViVU4xdmh4eXlnOEJ2ZEdJeFM2NC9JOTNFTXNZa1Qx?=
 =?utf-8?B?ekxPRXhmWlA0ZXloRjVoQm1YWE1wNFlEVkgyalBlSFpkdmNHL3N5Szhra09h?=
 =?utf-8?B?OTU0VlkyM0ppajB1T2VleHQyMytBaDBNVytqWUVCcldOL0RuMGZxbjNLOWN5?=
 =?utf-8?B?c2FWN0Y2TXRDL3JjRldRL2FTZ0hXdndQL1h1SU5KOUU4eFhQYW1TNzVQSmtT?=
 =?utf-8?B?NzVCYVB6Qk9rc0dFVWdYYTlKWEhLcGRxeU1ZV1liQmJFODFTMVY1bkg1YWh4?=
 =?utf-8?B?bEJjZ3RzVVNvK2tYaHA2MXV1dGlQRlRxWHpKMzdHWXloN1NEMjY1ZkJjZzBl?=
 =?utf-8?B?OEF0KzN1T3NtL2hOTzUxVHo4RFhGQkNGbjdCZUlocE54a1FORS84c2JEQm1i?=
 =?utf-8?B?WWZ0Mk1ENE80Qy9LQ2hCOVNOSER2dDJ1Qk04ODYrSExUQ1ZEVGpJSk91Qloy?=
 =?utf-8?B?TUtFTGJPVTRMOG54R1RDNmFacUdDMzlJeTJYbUJTRTZNRE9nbjlmYU9tdTdw?=
 =?utf-8?B?MTJnbkU5SmtJNzRwa3Jkc0xSaHNXaWx6bUxZNWZrTFl4TGFNaEc5MWdPUFB3?=
 =?utf-8?B?WjIxTTZGaDVJb1h3UGYxTDcveWhUTWh4NXU0aDI4dDVxeXdkcFFUVVBVYTFQ?=
 =?utf-8?B?UFUxUFlDR2ZNNmtsbU1hRitCRWxwWldlMnZNczUzMDZCbUdUbkxmTEh6b1F5?=
 =?utf-8?B?cGNTeUMrNlRhQ3Z3OVVRdTVtRlN3a0p5M1NzNjBka3ZCSlBQQUxUM2dHcE9i?=
 =?utf-8?Q?MZm6NBsDzgJDxeWRaEzWQT7FX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f677d5ba-54a7-43e6-c152-08de21c3cf21
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 08:16:41.4358 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWylt/GugiGdSfP6HQUPLZ5HteqpyWImDWBB905MB95l48zAMe4gf2wCc1rCjBDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12049
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



On 11/11/2025 9:47 PM, Fabio Estevam wrote:
> Hi Emanuele,
> 
> On Thu, Nov 6, 2025 at 7:22 AM Emanuele Ghidoli
> <ghidoliemanuele@gmail.com> wrote:
> 
>> Hi Fabio, Ye,
>>
>> At Toradex we have been struggling since quite some time (back to 2018) with
> 
> Does this problem only affect early i.MX6ULL silicon samples?
Hi Emanuele,

     I have same question as Fabio. Are these samples are early? Do you 
know the time of receiving these sample? And could you show the part 
number printed on the chip.

> 
>> the temperature readings and the thermal shutdown behavior on i.MX6ULL. The
>> issue we observed is that the thermal shutdown seems to trigger too early.
>>
>> I have investigated the history around this topic and verified some internal
>> notes in our bug tracker. With this revert applied, and on the devices we have
>> (all trimmed with value 0), the reported temperature increases by about 10 °C
>> compared to before the revert. The absolute accuracy of the readout is
>> questionable: for example, on a device kept at around 20 °C, the temperature
>> readout was ~19 °C before the revert, and ~31 °C after the revert.
>>
>> Consider that for devices with fuse value of 6, there is a -10 degrees offset
>> after this revert (so, the other way around).
>>
>> I understand that for Sven this revert improves stability during large XZ
>> decompression in userspace for few devices, but for us it means that the
>> thermal shutdown happens roughly 10 °C earlier, which is a serious issue in
>> our case.
>>
>> I would kindly ask NXP to double-check how these devices were trimmed. My gut
>> feeling is that there might be an inconsistency, either the trimming scheme is
>> not backward-compatible (e.g. old and new devices behave differently, and the
>> code should cope, I don't know how, with this), or this patch must be reverted
>> (because introduces a regression).
> 
> Peng/Ye Li,
> 
> How does NXP suggest we handle this? Were the early i.MX6ULL parts
> incorrectly fused?
I need to discuss it internally, will feedback you later.

> 
> Can the fuse be read and dynamically adjusted?
>
The fuse is locked by MEM_TRIM_LOCK. Emanuele, can you help to read it 
by "fuse read 0 0 1".

Best regards,
Ye Li
> Please advise, thanks.


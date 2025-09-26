Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B8FCAC5AE
	for <u-boot@archiver.kernel.org>; Fri, 26 Sep 2025 16:08:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9888483936;
	Fri, 26 Sep 2025 18:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wjquNf+t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C83183623; Fri, 26 Sep 2025 16:54:50 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9E17836AC
 for <u-boot@lists.denx.de>; Fri, 26 Sep 2025 16:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3mDm02yJ/soaK1gSVg77J51yqUMM0fTTvMfneCkhKwxP1/NaFWTDTq8RdpMjBpg3fZigWDY/skpwBdWaN0YITrDP+UiU0XPHqcFw+3SEx3vtxEQtkknKKCJtoNO+h1rb/2OS0EsdbYSqexEp/TZ77+TTULGhC9U/dT668D4r0y+lfcQuIJlyKYCp44nyl5nUdgmf5x23xYOnePpRoQrr5iaD4vkwnTi7wsyPV5Ttw7kJgD/DpMpnV4CrlCIHtj9OaBZ8NSCt2NnlHZvS4E4KuNb2JLipCXAc39flSBU0HG5TOYedHLXVCZjhS7bhgWAMhMtca0H+fG2pzXKc+ZlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eSqQwxjw0XApzUt4GoHe3QxhIiwZJM0qF02MqaoetYo=;
 b=IRyThNb3PqrQmOPPvjwjR337v+7tdUt0s2UIN3FUp/zcrkp47Gtqy1EJogSEfSgco6TvrnNQOXaegHhK58AnDFbVj52/VJEKttqJiD8Ewt9Eq8IoF2H9zMGoSNax9nHiRShqJgz5GVtA/k5vlJrjD+EPSFgPw08jsON6xadY/AyBJc8niZ4tPg8uqclypykQxuFu5ide027AyjiugXCbg5ZM12fJoZOseFBtN26pQzdtwzNWVIs52Slo7XQcIeoIw/iik0hvhqbV/hdi9v9EkF2R3D85r1pkIh2W6AesHCwYqYhhqRBpUJfWnrmNjXg2H7sEz7lDCExzyh/JM0qDbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eSqQwxjw0XApzUt4GoHe3QxhIiwZJM0qF02MqaoetYo=;
 b=wjquNf+tPtquGNPoPjgofj85ldgPSfvlgRSLtx8Vi3x1o0wI4o4eA6Qky7aI4J9ZAOW0kQUgUqY8rz2AXi8xBHodNNgN2mbTnMCS5k+0znLSnhnSMAU9HWFoSGLHLDdBHFPuqLUqitDRslY/XYpnEp5NmjbcomQG3l4OcUJpxvSbLSRg9NEVbqA4k9HpFGpHh25djze3DEXAaWoUYi8CLz7/cytE5paHD+ZWo039ydZhkKsU1kxF3t1izCH8ssT8PLzU2qasZgFHDz6eQTPOVHJKdlmrfXzcgDVYhlF/+ZD0PCFzwR4w1iwcitC+8YZgPxnEam8R6m/qnZPsOvtWjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB11845.eurprd04.prod.outlook.com (2603:10a6:10:621::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 14:54:47 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.010; Fri, 26 Sep 2025
 14:54:47 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 27 Sep 2025 00:06:23 +0800
Subject: [PATCH 10/10] MAINTAINERS: Add an entry for SCMI
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250927-scmi-v1-10-5e9354fb3bff@nxp.com>
References: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
In-Reply-To: <20250927-scmi-v1-0-5e9354fb3bff@nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB11845:EE_
X-MS-Office365-Filtering-Correlation-Id: a3d5aea3-52db-4e17-e477-08ddfd0ca2e4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDY4US9vSHhLOWFnd0dNOTRqWEl2WldvbFZJa0p1OEdFYXFFc3hYeUtkMFhV?=
 =?utf-8?B?eDhXeHJTNGVkZXNyamwwdzVqRi84TXJTRG5NUWhPa3BRU3hJWVdjZmhLaGxS?=
 =?utf-8?B?eVZ3WXdFQ0lrWUhOTmlZTmQ2MVF1aGI4UFZQUHI1ejJjWnNBMWg0TGRyNGRV?=
 =?utf-8?B?bVpWMDYvVWsrSzJCY2pLcjBwcGcxaHF1WEs5OHhaY3NtZ1JaUDFrL2syUmx0?=
 =?utf-8?B?YjJEQmMyaWpNWGliQTFJOG5Pdkd2am44MHlQQ05JMEdQQVRmN1owWlFud2ox?=
 =?utf-8?B?QTV0MHREOFh5QVFGRlNKMHJta3pJMElCN2RHUGpKRTVmczBXM3FzOGszK3ZK?=
 =?utf-8?B?L081QWJWMFNjdkxZT1k0NEpXYnFMbW5RaUh5UHErM1hiWEpmS3RVNlZVdUlS?=
 =?utf-8?B?OUdDVFFwZHI2REpHY0ViWEpvdm55aiszV2NJb1V3TmtIRzNwNk9JUXNFSkRV?=
 =?utf-8?B?aW9SZHFlenAvYWVGSExnTmZndzhEZ21mZFlXVHBqeDJHUnZ1cGF4c3JVeGt2?=
 =?utf-8?B?RTdmY29vSmFHeXh3ZFp6cXZWWkR5SmZNOVphMEd1VjdTemhUM2kxNkxaRXo3?=
 =?utf-8?B?STdsRjFzUGdUMFljampIeWIyMmc4alNUVTlzVTdxdnBUUEs0NEFjNW8rTFhn?=
 =?utf-8?B?RDRDQjFsM2ZGNVZodkRlVHI0VmloUnhYUmVBSytvY3BuTFl4RVJXRWZsU0V4?=
 =?utf-8?B?Vlc1MlZKZUk2SG54TGlWY0ZJc3c4YnhZSlczNENac1RScWZ0SWNwNCtxL2p4?=
 =?utf-8?B?SktZazVvc3NtNEJ4eFNXelVTZnJwRDlsMExWd3BFejFmMDBFaDljb3hGUmtu?=
 =?utf-8?B?ejM5eDlKbEl2M1JxOXBWMnFMcUNROWxKQkxucVNMSEVYaCtwK0VGR0tEUWtS?=
 =?utf-8?B?aHZZZDY1M2VkcGc1ZDhMOTd1ZGQ3aHNDam5uQnB5UWhqQVRCR3VtbVIxdFFl?=
 =?utf-8?B?ZEVVTWliVERnYXRqbXVUck41OHpVYWpOREpGYzlGQ3hBTXB1Wms1NnBOSlp3?=
 =?utf-8?B?ZmlBcHgwU1lnR2M4RlVMU0FkbzdSNmtlWW1XbVR2NVhhMmxlcGI4UTlrVDZH?=
 =?utf-8?B?S0s5Ukl1NktLUUkwNXFHelNKWndiY3RKUGJmUlRncFV1bzFLTE8zOEQxZEw2?=
 =?utf-8?B?dUNuOGJoeU9LN3FiSWZtVnlZZVJMRzA3YXQ3WDVrbFhBbjA0UTAzTVlISTZv?=
 =?utf-8?B?MzdjNTR6dzhNMFlvK1kvZGVKMXBWYmJwNTJKcnR4aXlteGw2TmVjSktjZE5X?=
 =?utf-8?B?Nk5oVG1sSkN2OEI3Y0lzcldqMHNXWmtpd2htUmRQWUZadGFwYlJoWWJ4RDRO?=
 =?utf-8?B?U2VYaTIwYnFDTjFxcVgwWUtxTkh3M3dlVVZicTNpRnZxVWVJTnJEUVlONDV5?=
 =?utf-8?B?eEdKREJkV2haa0ljVnRLYzhOUnRGSWhoblhXWGZkZUhRby9BRU52dXByNkxn?=
 =?utf-8?B?eWZYMFgwNlZvbENybUpEU0FtaHRBR0pZOHlheEw4Z1N6bk15anNzc3drV01W?=
 =?utf-8?B?RHFROFM2UUsyUTBNcEdQTkxkQ0poNk45OXUzQ2QrSktDUkhKQ1VZTWQvbEdF?=
 =?utf-8?B?NWhHMnpkR1RwcVUzMWFpam1wRWR0czg2RWJlVjNhN2RtUEF5dlFpKzQ5Z1dy?=
 =?utf-8?B?eUk2OFdEWU1ueS8rbWtKYWRSUXdLWjNxdndDTjVpNzNHVGJqKzdhUmlnMW96?=
 =?utf-8?B?dXZpNENtbkJkeG5rbExTazFzSk1yQnhCVDMrekJZaXpkbkRqUWpPTnc0RUtv?=
 =?utf-8?B?a1pTVjVVbmoxQ1RYcVVLWW93ZEovcUtBaDltSlpiV2FBMXl6U1pzVWZVVmZm?=
 =?utf-8?B?MEh3YVpyVW01Njc3QWRQd0JKcWcrdFNEbUtPOHFWcmc2bnNQNWd0cTM1OGM4?=
 =?utf-8?B?L2taQ2FpY1RYQ2E1SGpLUm5YbjZ0NFM1bGQ2cEpGTE0vS1BHaGhaSjBLRzF0?=
 =?utf-8?B?Z0Jlci9TZklUb2w5NzZkdnlMNlJMMWxYUXZudnJwbkErQ3BtalBMZFVob3Vw?=
 =?utf-8?B?MzVBUkpuNCtnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG1WbHRRWDRDMkRqc2RJYmVtcU9QRzNVUHBIUlkvS3B1ME8wdlZ0UUZDcDRk?=
 =?utf-8?B?aTAxazMwZTBOZ3o3bEkwRHBiaVZwUElSK0x5TWFQOXR3Um9NYTcwTEdsRTlZ?=
 =?utf-8?B?bU1UQkdxTUJaZXhwU281dXVGci9kc282R2ZSTEdjcDJGd2JhNHMyZFNLOUF1?=
 =?utf-8?B?TTRicGdRQkpYSWpVRGFmZTVvSUxOemhUTUhKSDd4NFpDZWd2V0t5UUk3VEcw?=
 =?utf-8?B?SWFLSWlDL2VvQlJGOVl1Qml0cDdtU01Nc2pwMjBjSjJjdmYyT3dhWExKTExj?=
 =?utf-8?B?dHM0aURzWkFkQWVuVnJIUUtKSG5JQ3dBQ0RrR1R0aWkySjhWSGgxbm5zaDhC?=
 =?utf-8?B?cEl3cjZuK0tSdDRYSVVYYkNoRzkvOE4rU3FvSjFlNzFkSXJRcmd5TkZlVERV?=
 =?utf-8?B?NW5oYUg1bkczWitLU0w4amNsNm5CTGFQVzFIWnRMdkNNK1NmM1Q1ZUdOWXNB?=
 =?utf-8?B?OHU0N3F1alluTWZkd0NYSy9qc01LMlRjTnpmdkd5VmxqbFZHWnZGQWROcTB4?=
 =?utf-8?B?Rkxya01JcFI1eGszT2RuNFAxUzY3aVoweXdCSmhWNkphUFFjL0FlOUhacks1?=
 =?utf-8?B?b0I0RCs1VjFNMTVCSjVWOHUySmRjUWcrR3JKeWxSVVhwWmQwais0ZkF4UDVC?=
 =?utf-8?B?b2p4Wk5zS21NWHBOOFJONnY0MTRYb0ltRUtOQWFnWHpGZ0hjZHhUNkxsU0s4?=
 =?utf-8?B?ckhIblM5YWJ0UHpUbzg3MVZIMUlGOFFBMWZyMHVRbk1jUDJVa1pVb3kxYzQ1?=
 =?utf-8?B?R3ZNNjV0ckdsUUFIZWpUNm5lSW5zT2xpTEZhSDZ2MFYyWXFud0dQQlVNaGZ6?=
 =?utf-8?B?K242amNSRUI3UlhReFVLcEI4VE5YelVUUkdHN0JYOXlONmo3TzM5T21mRkM5?=
 =?utf-8?B?TFQ4dU5mZXdNeHh0eDZiWmlxWXFreVhiR3I1YkgrWFB4M0t1em9ZdUVyUVV3?=
 =?utf-8?B?K3VlODFPRGR2TlI0SGU0NTlZTU1MTmJjUjN2YXVEOVF2a0wyTHhXT0ZPN2FX?=
 =?utf-8?B?eURRLzFXc0VoWkFXdVFZVHhNMUJkSXNtYlRHZGdYbkhid3FpUzBvNzZjWnBs?=
 =?utf-8?B?OHRWeVZ2WUErYTU4cXliaWlWRWEyQ2RueS9EVWNjR1daM29XWGlGdWdxUkFj?=
 =?utf-8?B?bWRDQURxazdWUUpham5EZXZwb3FEekswbGwwQlJ2S3JIVjcvVFRnaXduVUtn?=
 =?utf-8?B?V1pRS2RsdnhiY2l4emtUdFJKR1VGVENabXZHSTVxN2IyVzd4VFZsYjVUY05T?=
 =?utf-8?B?RzRmQnp2K05pY0o3bDNFQUVVS0hTaXI5QzEzd21KRzFKMHp3Z1kzVnZRVS9w?=
 =?utf-8?B?aVVXY2s4a0MzY3lFd1JweHZWbmNibWovZThZOGlaM3d0dkRQQXZuVW9SOG5V?=
 =?utf-8?B?SXRJN1RvejBTSnpoMlJjeEYwV2JUV2pJOVFKQ3NYdkRJdDhWUW1iOWJnRGpu?=
 =?utf-8?B?NlczWW5NTTUyL211WS9RZDZNeE4rMmRIRk85ZDMzcCsvMkxnZHpQMWk3bWpv?=
 =?utf-8?B?alVxL3Mxc3NvdnpZVGxXanNZd0RvTTlLNmM0clpETjU0dzAwUGkvZnFyRGZj?=
 =?utf-8?B?MDZsbmplV1FPMHNEeW1RazN6WlFyMlZFdldERjYxU3BZU3ZPeTUxZjJ1eGlj?=
 =?utf-8?B?YlFmTVd1Vk5WZWZUbkkydHUwZ3Z1NzhBcmZLZWxMR00yd2N1UmdsUlI5eW02?=
 =?utf-8?B?Tkw0MEVzb0o5clNlQzgzakwzVi9Yb29nckp5RDZiMHNjb0lQVmUyTTQ4NXBP?=
 =?utf-8?B?ODhxN2IyQ3BrejJEY2o2M3pPZXc3ZXpWeVUyQ2M4NUcvUmpidVF0L3VnQ0VH?=
 =?utf-8?B?Qmd6Y0UvZDZNYm9Kd2VCaUsyY01qYU15MG1mVkZJSklTVHFZMlFhM2E3eXJt?=
 =?utf-8?B?dW1DTU5IYkkxcjdYYmx2VEhqVjZ3aDhNL2tnSlNPcnpFZEc1clNVZmJGdVp0?=
 =?utf-8?B?ZGhVSTk4bG5sNjZ2TUIyQXBMOXdPbnRLYkJPT0tKVnNDUVJFVEtybHJjTGVi?=
 =?utf-8?B?R1E1NnhyQVJINnpFZkhNdzRCdk1JNGpFbHVSMTA0NG80MTRVU0Q4VlJKVlg3?=
 =?utf-8?B?VCtjVHAzZlZUcWJsR1lvMktBTUluVjhNWnpKSWl2NHlOSXB1Vmk5eGwxend6?=
 =?utf-8?Q?vrMx4/PXmdc3DQGSlX+JVjD3/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3d5aea3-52db-4e17-e477-08ddfd0ca2e4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 14:54:47.2339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: irRoxEQB+POUy+Nvw+WjKNAToNuILHvvUzj49kTQFo+atMnDYJOYFcw9Ua/KZH4Zhpl/jYgTqVRili6kiJ9t3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11845
X-Mailman-Approved-At: Fri, 26 Sep 2025 18:06:25 +0200
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

From: Peng Fan <peng.fan@nxp.com>

Add an entry for SCMI and add myself as maintainer

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b030242a2d894863e477c8fa0f4e83d640225569..b66543962189b358cb29f50186d722cad8740b4b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1618,6 +1618,13 @@ F:	drivers/*/*sandbox*.c
 F:	include/dt-bindings/*/sandbox*.h
 F:	include/os.h
 
+SCMI
+M:	Peng Fan <peng.fan@nxp.com>
+S:	Maintained
+F:	drivers/firmware/scmi/
+F:	include/scmi*
+N:	scmi
+
 SEAMA
 M:	Linus Walleij <linus.walleij@linaro.org>
 S:	Maintained

-- 
2.35.3


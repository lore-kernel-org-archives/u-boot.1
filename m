Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD91C3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B7788D71;
	Tue, 17 Sep 2024 04:31:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EvtWf8e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60CC188D71; Tue, 17 Sep 2024 04:31:00 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A44288E15
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LmvX21PCYlGOtsebCQQeNggRV/RU+ylvnJ+w5I0bDSS06n19K5QUi1aUfzaKjK0sx4WTtKb/o31lNQM8uQezyibEYcdOLvRqY1ww7+Ua4w4GmDUW9IEpRSHoSGbFoUsmNPiFAYgZgf7N2Xt9ln0jIyUcQuxFSHeUEucaY8qgoFc+uObFFvLK8n3Qihe2M0fCATc0k6q/qhpOo8DdfsMe1ZKGr6nrang2r+Q2SwSEVWoUlBOaGNM4XKQei6TiCdHphDbqf5QBOCmNuuvIkUymWZ3jrQej11K7ja+jBzlXBE8FPty466tVlUP81QG+XxiP792k/ZtGcrGjpRb7ANeGyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7qYQ4PUGTwPkgjs4DU856E6/IDRHbtUoCoFNerCPTU=;
 b=Q24hjpu5OGF36aeezI/xQ+wUlLfg/9ZcDl9i3f5Q5wRwHM6KvV90mcz8LR0FOamtWDHJMNSfgh77siDU52kcse2IW/cJFOO1HIS/if8QMZsGryN0n+jC1dHwAir38BrUJ9KJ7hPAUZL55avDPSlx7WrmzI3bHgy4WMtAKlqBRVHDlFRPqk33ELbugoK4cnCa95IJVNbxu/RmUiKsBqZ3LD0iMFTcSdlW08ZRMW6pwN0+Bm/4xiHgJuEm16lQvkttNbE3SdC4rOhKZGjGh9arXUpUnmJRYBPLfJ9tmsroUz8pa/NAviTflKaac6VTr5Y7xM+29FOA+9/w1e5RRASB9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7qYQ4PUGTwPkgjs4DU856E6/IDRHbtUoCoFNerCPTU=;
 b=EvtWf8e6rL0Z4PUn2f1Jp0GMG07osa9pH/+WO05Q08J/RMoegNxwgIyS6ZFLsVKo/7Muq+mhhtd1mzC9aeHOdrkM/ANXO79AhT8DURB8nsfGTOwiTqgP0ANXqYhgGyBMP8PgPKr6rlpp6S6wWmYByw0ZVw57lsQVOeO4Jpug8d8COoYu1HJeDIu3sohYpVxi85Ksm6DnOeEfDQQQFDx4Hft59oHKyUoDMHCyT6/Tfyc7wSTOgSsGeBYld71T61BNmMH9v0pwRk8QX/pmLvetnOg+Z4lY0R8C4NFhc5jGDNMrD8E5GaWeK+XRmdu6CcVwdGXexpDUUgITlsDpIJczIw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:30:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:00 +0800
Subject: [PATCH 08/21] imx9: clock: Update clock init function and sequence
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-8-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d6e8c0-95fb-485f-3767-08dcd6c0c1ce
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0E2SVNyQmVoNWFkT1A3dm1aQVFhbEFaQVlZZnJLVHVYaEJyd3VMQ3U0cXNZ?=
 =?utf-8?B?MThyNjJzSDRDekZMTC9TeWhscnFBM2Q5VHB2Y0pscFdobTZXTk43Zi9EOGE3?=
 =?utf-8?B?WSt2OWJkMDFCc2VseUUwTGxMRlYvdGZMQUd4M0V3MWNBbDF3U1pNZnJzRlIy?=
 =?utf-8?B?ZCtXRlEzYXpyTWRKVXlxYmdaUkFQdzBKdno3Y2M2VXQ3V21Ndmw3YzhQRFR0?=
 =?utf-8?B?cXBRdktFR3k5bEQ3UUdNaGgrR29nLzBCNnNZSnc3L1YwelcrZk9qQk42aXdi?=
 =?utf-8?B?UFJYdm5qU2gyYTNzdEZhMks1ZDBQNFUzMTBkbE1aMlpIcmlYaVhHS28zYU9a?=
 =?utf-8?B?ZUpjbHdXaXg2VzRYM0ttWkE1cHUyMWY0cUpqeG5lM3UyNE1LV2twWFpHUkln?=
 =?utf-8?B?VDZLeFdYb1V4ZG9XNUtiWFhzM1h2M0l2WTJmd1hJY2xPMTB0VVRWM0swc0l5?=
 =?utf-8?B?dzhtaE5rVDI1RVBsY3JiOTcwU3UzRURaTGQ3Z2NyZ21EQzlUdGszc0V0eUgx?=
 =?utf-8?B?QkpYWFRtc0V1bXFnSHV0ZFVVUU0wWDdzc3hxVTh0N1RCYTE4UldXNkdzQTho?=
 =?utf-8?B?QW8zb3VHTGxwcVNjNk5oOXpCVjg1TjZpcVQ1ek50MEt6WHV5a3NIZXdtTXB3?=
 =?utf-8?B?MWhlVHd4Ny9SbW9RM3JpNkNWdUw1aUtWZzJQNWRUeWFmRXNJQ1BKZ202b1Ni?=
 =?utf-8?B?QW9OT21hZlAxaTlZUlFkc0ZLVXY0Q0tnWlRJWDl6UXlXZDNoM1Z4N01QY1hB?=
 =?utf-8?B?RG51Ky9aK3RkbVkwYUtvUlYzeEpvTlZDem5jUUthR0hlMStEcUlneHRVSFBt?=
 =?utf-8?B?bkZEaGJUZWViaW5OZUdjZEJrZzROc1BMNXBVRU5xK3ppek53SzBVdmtOektK?=
 =?utf-8?B?TWp0T3lobnA5Z2lGSnowb1NUNjNhaGFjbmNXYkd3aU4yczUxbnZxditpUEpi?=
 =?utf-8?B?TmxqUVNVWGw4OW5SWUlDd0p1Vk5lZlRhNERtOXQySll5a3diWTB6Y01TclVy?=
 =?utf-8?B?SnhCSVhxSm4rOWJKMGFxcDRmcndPVjBFUGlaTjhtWSt0UEpzZG03SUtZaFdT?=
 =?utf-8?B?d292R1JIaGU5R3AwdGV1UktwMzNOdm4zNFFRYnliQ21lYUVCZW5XbUtLQU9S?=
 =?utf-8?B?UGtOTmJFWW82VWhrN0tSajFLL3RMa3prVDFzQ1ZVbFR3UHZWVXZ0QTIzaUNs?=
 =?utf-8?B?UHdUWnAxbW5DRFNCUTlGSGYvRnY0d2U0MUFiV1dnTHBMb0hoRWtMdjQ5a3Zt?=
 =?utf-8?B?MnJHM2dLaEZFdjh4Q01MZ0YyUUhsS3dIYldXYm1pVE1CRS9iL1VEM3FkMGZM?=
 =?utf-8?B?eVJYdms4YldUVnRwQkRHVm9keHl1MXpPSFVzZTMvbEVyQ1E0bWl2emlsWEhX?=
 =?utf-8?B?Zlp5YjdhYmVnb2c4Z3RFUlRJMVphSUxjcXdOeGJMTFdQemdjVkd5aXIzZmlW?=
 =?utf-8?B?a0FLZnZIejJlUDhDNGlzVmVCWTZGQlJhN2Zxd0R6bmJNdHlmVkg4VDJrNmZw?=
 =?utf-8?B?WmNPV05SRE1OZ2drR0E5cWQyNTVaS0lSQ09OVHdGOWhvUWZTZ3R3cTVmeFZ0?=
 =?utf-8?B?K3ROZHVKbU1tU0xSb01XV2ZiR2dGTUhnMU56UHJzdWJFWWxLaHV6NCtGUVFM?=
 =?utf-8?B?UlJJbno3T3RSdWFoS08yV3VYNmNjbzdlK3ZFV09YTWlxMEhFNXV4MTBueW53?=
 =?utf-8?B?WXYwbFZkTkJKb2liNFNHTm5hbi83ZjNQR1BpOWxmdWVPQkYxMGpuWW1FQlVV?=
 =?utf-8?B?SzJRTU9RaTBGMFFPYm94Y0wvazZJMlNWYkxTc29JeUVKaGVWeFlBd3EvUVNm?=
 =?utf-8?B?TFRYdjVzZjhZV1NoTTVES0ZTWnUxMW83REtuQ2Z1OFBLeVc0SlRhbnhsRCtK?=
 =?utf-8?B?M3JNS1BFY0NLaHRjTW9WSnRMdWdzYTFMZjJuMk8vcjU5bFE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUZrWkVkWUpUY05OWjlEYmV4TVV1WU5qcTFSaWMvZmw3NHRwWE1SU3hmeUJV?=
 =?utf-8?B?RGhsNVBLYi9iUWFzQkVQaFF3MWU5T0ZTVFJyRlljUUZ2ZE54UFVVb3NrT3BC?=
 =?utf-8?B?Qis4QzJtcEU0WVNOTFJNZkZUUXpuZHRhRFZRaFl0WjU0V0hEdHkzTjRqcll5?=
 =?utf-8?B?eVNBWWVYU2J6ZjdXemNjNzR2SXhQRFljL2JTWllmZjdmbEFKVmlyak9ubis1?=
 =?utf-8?B?S3JxdkFqdzIvMDRDLzFpSFE2bVMxWVhuUmY1QnRzOFlveDRObHl3MFRSMEo0?=
 =?utf-8?B?QjE2bGpnZStlMnphL3dkWG4yTXdwMDgxbHRvc3lNMCtMcm4wNlRPZk9FcmFo?=
 =?utf-8?B?WjF6a3MwNXB6MkoxTGZMWUNWcUhZY1RPQ3pLM2UyZVFSbm05bk9aVVV0SUJH?=
 =?utf-8?B?TWxoczFDRERYcmhaWFN4TTRLbFB3V0tSYXplWnNOZVYybmVwSXloUXhNaitW?=
 =?utf-8?B?UklIYTF6TXdQckFyWVJoWnB2SjIvSnpHVlMvVCtFMnR2ZjcrUi9TWkFLQjdo?=
 =?utf-8?B?OWtUcHZFczBQZ1pBN3l6Q2lsU1o0VE1SMWx5bDQ1MXhHV3VIWmM4VTYzaWU0?=
 =?utf-8?B?K1BwRnlnZEpRdStMbDJMY0VRaFVpWWlkZGpET29VVCtqVjgwU0ZLeURobHhG?=
 =?utf-8?B?WUdvZEt4Rm1LZys5cXZuTDFUZ0J3YUtxbEd6cStBbXlTQ2VHcnhISDVIdmZ2?=
 =?utf-8?B?d3l1THBlcTZmdVZQVTJBT2FRRXc2M2RVWkxWYlBGVDRJWlBRandZVkRRMDhF?=
 =?utf-8?B?a01hVVNEVVhtZEFTMEdVRWZJRHp4ZVBwajNaVXlpUHRPYWFiVWpuWnFHS1Bj?=
 =?utf-8?B?LzZpK0k1Mmk3UVV6ckVIMEZMYmxMUWR1bFBzaXdHWllnRlZ5bkp3eDE2ZGp4?=
 =?utf-8?B?WFBHdzMva1BKV09Yb1E3cFN4YVBmakxhaHorUWdjSHJHL05ja0ZxTG9UMnhK?=
 =?utf-8?B?cEcveFg1dU1jT1FLNFpuT3JmY2QzblJtMVRYYTJPMVlVK1hVNXVKYjJFSkdl?=
 =?utf-8?B?Y2N3eVc5UzdENDBBOXprdmpST0dkckY5VXFpcnBVUVFqQzVKaWRscFEzNUxC?=
 =?utf-8?B?K0ZBZmc4UjQzS0VIUkJFR3RKb1lPbXl1djVjNzBWZ29VaGpPU2ZDajlOeTBr?=
 =?utf-8?B?YzJNRUM4a2RORGZRaGN2VGVIblNuQ3l2K0J6TUMvRHNVWldTbTJLODdvRUY5?=
 =?utf-8?B?QWhTUWxwQzFrZUYxTnFFbkdrUGlieXZwdVZCQTVUVUQrMFN2eWQrZTlxdEpz?=
 =?utf-8?B?RmRvQnZZNDhyR0R1R3ZjWitEa1JmTEFDZ3pEemVvMjFBNnZNNVJkRVBQRlZE?=
 =?utf-8?B?TTRHMnlTRjYvM0ZGblI0UUJkUHpDdXhKNEZTT0c5bGsxZXMrNzNMQSsyK2ky?=
 =?utf-8?B?a0FiYWZmcTdRSUZMMXlPVGIwcldwWXNyYXV2d2FlTnZYSHd1enNMZnlWd2dI?=
 =?utf-8?B?aXFIM21QQTdvRDhWbXEwZVJCZnRDS1BuMXZZT0d6cFZjNjJhdGFHSW1DSHJt?=
 =?utf-8?B?d25OTzFVR0lJT2J1YUEzUC9JWXVIM0JKQlliMWFONm96Q2YzTXk5WHpiZHI2?=
 =?utf-8?B?NUh6enZhbkFaZlZaYi9UQUtFZ1NPeUVNWU1vdGsxSGhDZ1pVVnQvY3JSSEhl?=
 =?utf-8?B?VE9ZUFdmYXJWc1NueEdNbnJIWGV6aUwwZmRBZnNnNmw5TUhQTjBOajFxcnlh?=
 =?utf-8?B?RGhtc0h0anNmeDdVU2lIYktVVHVTbWtIMFJXM1RpanFuelBwQjQ5UEg0MU5U?=
 =?utf-8?B?RForRGs0MUV2eEhMVkxwUlhPRXFqdVNWcGxJd28ram9xc1ZpUnFSb2ptam5w?=
 =?utf-8?B?K0FnZ0ZocUx1aUJKOWU1em03UngrNnNZZkVyY0M0VEhiVnpxblNjRVF5SXRZ?=
 =?utf-8?B?WlVGTG9jRzBEQ3Budm9ST1VUSHMvOE1iUWdJUnZSbDdvK1RaZHA3WFNpN0xJ?=
 =?utf-8?B?aWtENmN4a243aVcvdXdEOVArekNYcERackdkMGloZXRvR202N3pQc1dmRXND?=
 =?utf-8?B?VE9ZY0xHZDBMczE0OUpqdEpvNmVUTXZ2MDV6S0h0SjJKenFqRHN4SUE1U29F?=
 =?utf-8?B?TWZXZnR2UzRDNytJcCsybmorNHN5VWc4VDd4SFVKV3gwTTJZTmthVW5lOTFP?=
 =?utf-8?Q?pQ+jK3KEpPa04/zNwZhtXF0tH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d6e8c0-95fb-485f-3767-08dcd6c0c1ce
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:55.6240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pk9iKND7Ds2L1QC6l3JPqJrQKL6E15HVWJC2/DE/KO6gyAhZ0yGFPhWfZr5YNMuqceOG50YE8Td1Yttrk5azXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739
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

Since we use SPEED GRADE fuse to set A55 frequency, remove the
set_arm_core_low_drive_clk function which has hard coded frequency.
And adjust clock_init called sequence and split it to early and late
functions.
Set the authen register in early function, because CCF driver checks
NS bit.
Set bus and core clock in late function, because the fuse read and
SoC type/rev depend on ELE.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/include/asm/arch-imx9/clock.h |  3 ++-
 arch/arm/mach-imx/imx9/clock.c         | 22 ++++++++++++++--------
 arch/arm/mach-imx/imx9/soc.c           |  2 +-
 board/freescale/imx93_evk/spl.c        |  4 +++-
 board/phytec/phycore_imx93/spl.c       |  2 +-
 5 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/arm/include/asm/arch-imx9/clock.h b/arch/arm/include/asm/arch-imx9/clock.h
index 1ce6ac4c3a8..76f12118592 100644
--- a/arch/arm/include/asm/arch-imx9/clock.h
+++ b/arch/arm/include/asm/arch-imx9/clock.h
@@ -211,7 +211,8 @@ struct imx_clk_setting {
 	u32 div;
 };
 
-int clock_init(void);
+int clock_init_early(void);
+int clock_init_late(void);
 u32 get_clk_src_rate(enum ccm_clk_src source);
 u32 get_lpuart_clk(void);
 void init_uart_clk(u32 index);
diff --git a/arch/arm/mach-imx/imx9/clock.c b/arch/arm/mach-imx/imx9/clock.c
index 1433e68874d..76d19f1cba3 100644
--- a/arch/arm/mach-imx/imx9/clock.c
+++ b/arch/arm/mach-imx/imx9/clock.c
@@ -782,17 +782,10 @@ void bus_clock_init(void)
 	}
 }
 
-int clock_init(void)
+int clock_init_early(void)
 {
 	int i;
 
-	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
-		bus_clock_init_low_drive();
-		set_arm_clk(MHZ(900));
-	} else {
-		bus_clock_init();
-	}
-
 	/* allow for non-secure access */
 	for (i = 0; i < OSCPLL_END; i++)
 		ccm_clk_src_tz_access(i, true, false, false);
@@ -809,6 +802,19 @@ int clock_init(void)
 	return 0;
 }
 
+/* Set bus and A55 core clock per voltage mode */
+int clock_init_late(void)
+{
+	if (is_voltage_mode(VOLT_LOW_DRIVE)) {
+		bus_clock_init_low_drive();
+		set_arm_core_max_clk();
+	} else {
+		bus_clock_init();
+	}
+
+	return 0;
+}
+
 int set_clk_eqos(enum enet_freq type)
 {
 	u32 eqos_post_div;
diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index a55863bf456..8a577b98255 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -733,7 +733,7 @@ int arch_cpu_init(void)
 		/* Disable wdog */
 		init_wdog();
 
-		clock_init();
+		clock_init_early();
 
 		trdc_early_init();
 
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index e4999baa95f..2ad7489ada7 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -123,9 +123,11 @@ void board_init_f(ulong dummy)
 		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
+	clock_init_late();
+
 	power_init_board();
 
-	if (!IS_ENABLED(CONFIG_IMX9_LOW_DRIVE_MODE))
+	if (!is_voltage_mode(VOLT_LOW_DRIVE))
 		set_arm_clk(get_cpu_speed_grade_hz());
 
 	/* Init power of mix */
diff --git a/board/phytec/phycore_imx93/spl.c b/board/phytec/phycore_imx93/spl.c
index 5efa38a1442..17a8736c73f 100644
--- a/board/phytec/phycore_imx93/spl.c
+++ b/board/phytec/phycore_imx93/spl.c
@@ -130,7 +130,7 @@ void board_init_f(ulong dummy)
 		debug("LC: 0x%x\n", gd->arch.lifecycle);
 	}
 
-	clock_init();
+	clock_init_late();
 
 	power_init_board();
 

-- 
2.35.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 184DEEDF17D
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 17:06:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C1A483AA9;
	Fri, 13 Feb 2026 18:06:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="PxEYZSE+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 144ED83C4B; Fri, 13 Feb 2026 18:06:29 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9165E83015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:06:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QI6Tdbimmlk5+Cmf/SuJDVhybo0uemMFamM20oUpZ8QS/eSs7pGI+nwasf1b3MkUy0W1XS+AOvV3rjn/2WYpNfkjV66TagDJF4kgpecOxv3UMLLozld2PliCiopoaXt/f/xdyd1qh5Z34L7q+vTaFN6+dYObmrYBM54A7R0tjgXt4wsX26dovrMpwkITAm+dH5GTLrnEaWHQZAYdhrMVmmi1GAwvME6HVI3Vq7UzJ4LSHmx2iDZ4dpoEU88uzRAHcgE//wtH2ZvKqRzzJgsOEUNNri5OGz8IqjhxHbefKQeIe3e+d1qJAaohUd2YlLgw1zIiuYQZCxGKQJqvMtaQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w68cBUXnMf/zDgpNgR05M3ae5p19fxnnOg0F05fb5zc=;
 b=vyo3d7G8bwTaYNqq9BJISZFBB354+8tFkmO87JOms/8qXOqzFa3pIK+kwi5/gCVmYn5ni0RdjlPIKBPLUgoh+zCogRCrFbYJzxIGvSNgFTS/MjVG7kifmSGhsWCE5FImtltrPubUVPkjWy3Qg0A01iYLP/wm1eVv6wj+B9s3nKe0oZA8dBhDZAUYaFjUk24Gze6fBQu8MwdNPnek5kI2i9p7L3SMva8Y28ysAxMTKh7P3uwHwWiO3UMDiP6kw3Pz7mGH9wNS8XvGW5nXOjNI6up3I0XZ7ZmeuopqCrL0SC0AMquQyCN84ScywuN2N6thvJFZaJeyy3LJUoBlQpImgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w68cBUXnMf/zDgpNgR05M3ae5p19fxnnOg0F05fb5zc=;
 b=PxEYZSE+y99fMIohbgItdqCfNhHsYsyGFViSpXlgfmyMne8oEEStTx44aO0Pb4OSX1WbXODc7ZICOcuMfX/E2fVL1PeZ5IOUmSxWBCZYm8FOV5mKGMi7yLKoZWdtRRZtY1eEcZW20Pwz9AXqC55bMyvDYXtFd07jvpoWHPwOGS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV2PR04MB12138.eurprd04.prod.outlook.com (2603:10a6:150:327::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 17:06:23 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 17:06:23 +0000
Message-ID: <537998b8-3b47-4771-8db2-75d810c33ce4@cherry.de>
Date: Fri, 13 Feb 2026 18:06:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] rockchip: board: qnap-tsx33: add support for
 Qnap TS233 devices
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-13-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-13-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::7) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV2PR04MB12138:EE_
X-MS-Office365-Filtering-Correlation-Id: fb626473-272c-41de-8b29-08de6b223724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y0VaZUFWV29FNGJvR3RWa2hiVWNPaDZJRTZvb21ZMFk4VEl3TE9GcE92T3R6?=
 =?utf-8?B?SndKcXM4UVBoZDdGeXJsWjVTSjdnVXRGNnNCaDBLQ1NRSHhaV0dMbjN6eEt6?=
 =?utf-8?B?K1Z6c0xFRXhEcFpXK2k4cWpUTE9xQkVnQTNkSzgvQlp6RERIQlkvVXJNOG9q?=
 =?utf-8?B?NUY4RmUrZyt2bER4NmVTZzd0ZW1DVE94dFp0RUlmNlBCWjI4Q1BMRXZzKzlP?=
 =?utf-8?B?eHJxUUpkOWZpWEJ2bHcwZzhUV3VTaWdqYnpqTWpIZkZxMUVxb2dLU084U2Vu?=
 =?utf-8?B?RkRtVmFqdlE1ZVpqanF6dnBFQnFGOERULzluRFZ2V0tvRUpnV09Sb3B3dTUr?=
 =?utf-8?B?NUJnYXovbWF2b2ErZkxkMTFCM040K29tRXh0akR4WGFNSDJWMktjQllqaWdr?=
 =?utf-8?B?aDFYSFlOMUNIRFU3RXdrUVhTam4zaklGN2RJWGRlbHA1RHNkanBZL2lxd3lL?=
 =?utf-8?B?Y2crZEZ5ZTJ4blg0Ni9FNzlSTWYySGkxc3RCMnJGTlVsb2l1cVpITVZvaGVh?=
 =?utf-8?B?VGZGeFFHREtqNFZCTWNCWmtWQ1VBSzhTeW5jQnFaUm1ucURKSG1tS2lFTHNH?=
 =?utf-8?B?SlZPbWxhQmJlVlk5UnlrQkhLckhJVDdJYnZ1cWNJS0JwcndBQndQaXhSMmMw?=
 =?utf-8?B?TGFQTVVrZlJwTDRjTzhaRTIzVjJvZWs3N3J5WisrRDlsTFRtMVoycWhKNXVG?=
 =?utf-8?B?cGhxTUVvOXcvSVhLb053ajUrMTNrZXA2MEI0K0U4OSs2YXY2alpXekRxNk43?=
 =?utf-8?B?eHBRZ010RlB5QUpkVW9OUmUwNXpEOXh4L1gwSGFBUGUxdm53VGhDK1ErNHhq?=
 =?utf-8?B?S0dIZnNueG9BZXMzN2pXWUhOMHM5Wm4zdG1ST25ibG94UVZQL0FTZm5LeDNz?=
 =?utf-8?B?SHdxVW04eUZ2Q2RRZXg3eUVCN3ZTcXRCa2NBVUp4Q0xtalNaQWVRL1dwKzJ0?=
 =?utf-8?B?RkhseDZiR2RBSmZ3N1RmQ28zNGU4cldpWGZlVmQwNjRENFdzMG9kNHowSjBN?=
 =?utf-8?B?ZDRJMWoxWWJsV1FFK0dGWGtvaGZ4RDVCUnM4OXNvM1BMZ3A5RjVQLzRQak9S?=
 =?utf-8?B?dDgzeTZLN3ZSVjdxcDFleVZhNEUxV1h4dEtsdzZBWWhmRXVZdWY0ZjhQZTZT?=
 =?utf-8?B?WkpUZS80WXdETkVWWWFMR29MM1JyR3BwQ3NQUFdVc21VZTh4V2RBTW1IZFhC?=
 =?utf-8?B?Q2NhckxGMUdEOWw3cUFLNENTL01wTnBKTFo1aE9ndnJBMWZja1ZkNXUxRk1S?=
 =?utf-8?B?NEF5aGIrRzlpN2JSS3lydU5jZFJic1JET1Nlb0o2S2czeDdBQUJmWU44ZTE2?=
 =?utf-8?B?bjFJT3hqeGVXbG4wRDdLalRXZGdjaE5QYWg1bmUyUzh5V2t4d1VOUDhhdy91?=
 =?utf-8?B?MkRNR0VMTnhVM2cyMFVqZC95Q2MvTW40ZW9SQTV1VkkwWU52K3paTThFQm13?=
 =?utf-8?B?UGZmeDFBY3BxbUhvNW0rWGU4TUZIZVFDTWRMb0hlcVA0WUVLUmRCcUJ6YUVs?=
 =?utf-8?B?M3VROGRlelVNc05MWXRtb0Ira2V3YklFYWtzd2ZuOGJLMEtLTjl3RzBoeDFh?=
 =?utf-8?B?alY2TUVFRXJ5dmxQV3JiQWNkR0NLaEFLUjlWZzhnUFB6SkZVSDJkemZ0cTVs?=
 =?utf-8?B?ZXpWZ2ZFZFZEK2s1emRBaXBlRmYrd1Y0NVltUHJMS2pSZEFSY3dLRjVtUWJG?=
 =?utf-8?B?S3VVYU4rTElEcVhDdmpqcWdUb09PNlRtTitTeXZBT3R5ZkFhbUpHR3JFQmc2?=
 =?utf-8?B?NUN6VkVoalpWSmdsU3haUW5oTUdtcXBZTUNZZ2dKbStKTDhSaDNwNGIrSHkx?=
 =?utf-8?B?bXBtMjBwUjhhVk9yMUNPblFiaVZibmY1a0dwN2l0eEFIaFg3RnZad01iS0Rl?=
 =?utf-8?B?Tkp0Y0U4QVdDd3Vlbk9kSFhJWmxON3E5QXBaZUJ0TXFoTzVXRy9ZbDZFak11?=
 =?utf-8?B?OTBLRWYxcHBSRDU1Z2Nqb05ZNDhGUEV0RnVQY2lpZSswTC84K25IeXA1VE5K?=
 =?utf-8?B?N1U5N3Y5UzJQMHNCMFhBNVVYbXlpOFNBZ0NsMjBlNEVqYXNBaU5ZQnpRWmFl?=
 =?utf-8?Q?JbDqO5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STZrTUFTVjZxbHd2Vyt1NHNFcXBPWHc5SjFuOGRDQWJQd0tQNUcyMXI4Sk1M?=
 =?utf-8?B?VGhiWGhDNzA4ZktoOUtFWDFITWJkQ2xkdWs0L04wa3RGL1djQ0p5OHFvS2F6?=
 =?utf-8?B?b0tDajRsdXlvN1FnaG5qb1V1aWVkd29DeTNhVGZwU2hKWUZGZVgwNmdPZU5m?=
 =?utf-8?B?eVlxYjk4ekxWdU11UGhnWjVZNGwrdStQZVBVRXFDUEFaTkZYT3Q4VVN0QmFU?=
 =?utf-8?B?dHBycEM3bDV1dGhkYkpNOWNJSFdxbW9FSkxzYk5zUEI3VVlta1QycnhlbTVm?=
 =?utf-8?B?Vy94aCtkT1FvUjNFbTlUZlJxVFZlRjF2SVBtZGFKbmNvQUg3VitmVXZSMzly?=
 =?utf-8?B?QStRUklyOU83c0Z3Q3daK1B1am0xbTdhZlBEUVR1VTNUcmdhUmw4azRvdmlY?=
 =?utf-8?B?L2FteVBhUmhlbmw3aTA0REZ2OFpFb3J0LzE2TEpyTkVPTitwU3VSUFJGM1Yy?=
 =?utf-8?B?cmdDdUVGeCtheW9LWWtXTTNMakNVTVhGNHdzODAxNGxuaTlzdGNUUHd2VHVG?=
 =?utf-8?B?ek5WOXFkSDcwRFltblloTDRRWmN6UEZuM2U4MTFtRWVjOEdIdnpNWllXY1Fj?=
 =?utf-8?B?eHRPV3UrSXloR2pNZXVCbXhnZ2pyOXdBenhZR3Y2U1Z0UmlZeFBCOTNvK0E0?=
 =?utf-8?B?YWd0VlJyRm1MOExESkVnZlJEczhzZG5LTHhSN3RGQndSZ3FXNGlKVkZmZGhR?=
 =?utf-8?B?alZyVFpBZUFwZ29zenVOeWp0N2NwdndpaDM5NEIyUk9XWHJSRjZkSjFvTjZY?=
 =?utf-8?B?a1h1QVdFY3FCMW9MSlNsQjhYc2UxSGd5M3NRN3JhUWZCK0tlUjkvZ0JhbGcv?=
 =?utf-8?B?WUtoSXc1OWk0bXh1RnZ0YWt0c3NxUUNDTldMU2cwMGpTcEw0Qy9pc1dpNTMz?=
 =?utf-8?B?cGJzdXpjemY4WUxWMThUR0xxQk1vWXgwcytvUktIazhLek1lKzhtdlc3bGRX?=
 =?utf-8?B?S25ieXJIcHhBQ3VaaE51WE5jN0xXSUZUdnhvSGxYNEJvQ2xqNGFadHIwZ2Va?=
 =?utf-8?B?RnlXZEhvcFRleFY1NnRETjhXd2tHYnRoSjNwWUgxOGdPY29wN1l3WlFyZ2gv?=
 =?utf-8?B?aHhwQWxiRFFzZXJhdTgrTnRCS05kYWJjVXh2VzZuR29QRVNhKy9FaHB2VWhC?=
 =?utf-8?B?OHdDbS9uTnZUdFlJcFZsL09PeTk5TVZ6K3R1RGJmZ0hqOFhFT3o3eFVOSnEr?=
 =?utf-8?B?S0RMZUU3WTVEU0pNaFYyOXdhQ0ZYeGZXODg5aEpBTUUrMUxhRW15RFpMWlBQ?=
 =?utf-8?B?Qk1acThMQzdoaHJtRHp3Nlc5a2ZWZ1BiMWV0YmhqbzY3cStMWXc2S2QyRUhG?=
 =?utf-8?B?WjZPcCtOR2hxQWF2Y2YxS29BejFHN0g3bkt5THZMTVhBbHdBd0d2WThtQ0Z2?=
 =?utf-8?B?TFpNaUxEY3BVS1dCSzdQK3A3ME8yQTZydEpBc1RMSmJ5K1JxMGVBRzBLU1J6?=
 =?utf-8?B?OTk1WEVabDNiWml0dXlkWHdWVU9VdVpSMVhlU21idkJ3bFM5QW9SQXM2SjUx?=
 =?utf-8?B?dFFJTkQzV1diQVdyK2FkZW5MY2M2QjRJVUVxY2NUK2NsdGhZT1FhSDFsY2p4?=
 =?utf-8?B?RW92UzRLUDB5VWxsWjJaM2hpenNZZGRlU3crYTRFdkFrM1dZVnRYdndlZWtk?=
 =?utf-8?B?cTlTcEFMUzAvaDl6MHRtSjRDYU9BZkxLaW9tMWFwSHBqTGNaN21JQ3RGN2xM?=
 =?utf-8?B?NGRhMWM4YXkxRzVNTXd4WVBSYmVSMm9ic0FHdGxZZmRnU0lweHQyRFZiMXpo?=
 =?utf-8?B?ZEhWZkRSVVd0QlV6VzRJVUYvN01ad0RjTDJrMnF2cWFWRE0xT0J3WnJES3Zo?=
 =?utf-8?B?Ulh0VWg5Qis4RllBSWM0QVd6dUZ2UlEwakFxT3h1NXhtemZoMnI0NDByUTlo?=
 =?utf-8?B?RWZicTVlMWxzMUI0U3JTSFBqclZ2ZmJoV3RDR2VxcmY0UnVYR1ZUYXFLUi96?=
 =?utf-8?B?TmYyYW5wa3JnRWR6aGJKY2FVcjNiL3p3MjFORFd1eDdLM2lKa2E0VWdpNTRY?=
 =?utf-8?B?REppMko3MDhWYkYzVjhHK1ZEQktoK2lhUzRCK0pLM29jRTlPVEkvMGI0Vk5a?=
 =?utf-8?B?b04xU2s2WnRUaDZIMXp2R3JlQlVYUU5Uazh6UjhPU3hYckJxeHRXN3hoV09I?=
 =?utf-8?B?MmNMcFNYWW9qWTlTaDNZcWNnQjNJNUtnTXgzZTZJQjEwZU9XMGF5TG13UjM5?=
 =?utf-8?B?S2liRFcwVG52bHI3T3M0eEs2UGNRYTFuT2RtdHMwWSsyV09zbWFGa21PSzQ5?=
 =?utf-8?B?WGJwM0ZMWnpMcjV2VDJXcTIzWmxmZXdKTC9TeXg1dFRPdVI2YVlwM0d4QXdD?=
 =?utf-8?B?M2ZwOHZWY0lmVS9rTHlRcm1lUVdtZkVmRG1FNmFGQ1ZmOCszRWd1SGNBOVI5?=
 =?utf-8?Q?SjuflyOJLqo6lQpTa+7SU57alQw+hMNJuvaOn?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb626473-272c-41de-8b29-08de6b223724
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 17:06:23.2361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfulg9rgoAQQzvLLM+WXDHV6u3uLRMeuoCAe47TcSW1lzuJSkWX/wZOz0kB649oZIJbTW6MI0K4es5zxHqGop+l0f+1ErTJK44ZtU/ZbAt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12138
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

Hi Heiko,

On 1/14/26 9:28 AM, Heiko Stuebner wrote:
> The TS233 shares the same basic peripheral setup for
> SoC, DDR, EMMC, 3 USB-ports, 1G network interface, SoC-SATA ports,
> serial and maskrom access.
> 
> It could just share the same U-Boot binary with the TS433, and the type-
> selection would take care of loading the right DTB for the operating
> system. But right now we can't select the correct DTB for inside U-Boot
> itself.
> 
> So for the time being, add separate defconfig and documentation for it.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi |  6 ++
>   board/qnap/tsx33_rk356x/MAINTAINERS        |  2 +
>   board/qnap/tsx33_rk356x/board.c            |  4 +-
>   configs/qnap-ts233-rk3568_defconfig        | 85 ++++++++++++++++++++++
>   doc/board/qnap/ts233.rst                   | 37 ++++++++++
>   5 files changed, 132 insertions(+), 2 deletions(-)
>   create mode 100644 arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
>   create mode 100644 configs/qnap-ts233-rk3568_defconfig
>   create mode 100644 doc/board/qnap/ts233.rst
> 
> diff --git a/arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi b/arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
> new file mode 100644
> index 00000000000..19acbceb468
> --- /dev/null
> +++ b/arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * (C) Copyright 2024 Heiko Stuebner <heiko@sntech.de>
> + */
> +
> +#include "rk356x-u-boot.dtsi"
> diff --git a/board/qnap/tsx33_rk356x/MAINTAINERS b/board/qnap/tsx33_rk356x/MAINTAINERS
> index b91274c7b43..af9bf9fe0c5 100644
> --- a/board/qnap/tsx33_rk356x/MAINTAINERS
> +++ b/board/qnap/tsx33_rk356x/MAINTAINERS
> @@ -4,5 +4,7 @@ S:	Maintained
>   F:	board/qnap/tsx33_rk356x/
>   F:	doc/board/qnap/
>   F:	include/configs/qnap_tsx33.h
> +F:	configs/qnap-ts233-rk3568_defconfig
>   F:	configs/qnap-ts433-rk3568_defconfig
> +F:	arch/arm/dts/rk3568-qnap-ts233-u-boot.dtsi
>   F:	arch/arm/dts/rk3568-qnap-ts433-u-boot.dtsi
> diff --git a/board/qnap/tsx33_rk356x/board.c b/board/qnap/tsx33_rk356x/board.c
> index 006add6fb30..7cfff372d8e 100644
> --- a/board/qnap/tsx33_rk356x/board.c
> +++ b/board/qnap/tsx33_rk356x/board.c
> @@ -85,7 +85,7 @@ static const struct tsx33_model tsx33_models[TSX33_MODELS] = {
>   		"Q0AM0",
>   		11,
>   		"TS233",
> -		NULL, /* not yet supported */
> +		DTB_DIR "rk3568-qnap-ts233.dtb",
>   	},
>   	[Q0AJ0_Q0AM0_11_10] = {
>   		"Q0AJ0",
> @@ -93,7 +93,7 @@ static const struct tsx33_model tsx33_models[TSX33_MODELS] = {
>   		"Q0AM0",
>   		10,
>   		"TS233",
> -		NULL, /* not yet supported */
> +		DTB_DIR "rk3568-qnap-ts233.dtb",
>   	},
>   	[Q0B20_Q0AW0_12_10] = {
>   		"Q0B20",
> diff --git a/configs/qnap-ts233-rk3568_defconfig b/configs/qnap-ts233-rk3568_defconfig
> new file mode 100644
> index 00000000000..53ac5b25bd0
> --- /dev/null
> +++ b/configs/qnap-ts233-rk3568_defconfig
> @@ -0,0 +1,85 @@
> +CONFIG_ARM=y
> +CONFIG_SKIP_LOWLEVEL_INIT=y
> +CONFIG_SYS_HAS_NONCACHED_MEMORY=y
> +CONFIG_COUNTER_FREQUENCY=24000000
> +CONFIG_ARCH_ROCKCHIP=y
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3568-qnap-ts233"
> +CONFIG_ROCKCHIP_RK3568=y
> +CONFIG_SPL_SERIAL=y
> +CONFIG_TARGET_QNAP_TSX33_RK356X=y
> +CONFIG_SYS_LOAD_ADDR=0xc00800
> +CONFIG_DEBUG_UART_BASE=0xFE660000
> +CONFIG_DEBUG_UART_CLOCK=24000000
> +CONFIG_PCI=y
> +CONFIG_DEBUG_UART=y
> +CONFIG_AHCI=y
> +CONFIG_FIT=y
> +CONFIG_FIT_VERBOSE=y
> +CONFIG_SPL_FIT_SIGNATURE=y
> +CONFIG_SPL_LOAD_FIT=y
> +CONFIG_LEGACY_IMAGE_FORMAT=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3568-qnap-ts233.dtb"
> +# CONFIG_DISPLAY_CPUINFO is not set
> +CONFIG_DISPLAY_BOARDINFO_LATE=y
> +CONFIG_SPL_MAX_SIZE=0x40000
> +# CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> +CONFIG_SPL_ATF=y
> +CONFIG_BOARD_TYPES=y
> +CONFIG_CMD_GPIO=y
> +CONFIG_CMD_GPT=y
> +CONFIG_CMD_I2C=y
> +CONFIG_CMD_MMC=y
> +CONFIG_CMD_PCI=y
> +CONFIG_CMD_SATA=y
> +CONFIG_CMD_USB=y
> +# CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
> +CONFIG_CMD_REGULATOR=y
> +# CONFIG_SPL_DOS_PARTITION is not set
> +CONFIG_SPL_OF_CONTROL=y
> +CONFIG_OF_LIVE=y
> +CONFIG_OF_SPL_REMOVE_PROPS="clock-names interrupt-parent assigned-clocks assigned-clock-rates assigned-clock-parents"
> +CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> +CONFIG_SPL_DM_SEQ_ALIAS=y
> +CONFIG_SPL_REGMAP=y
> +CONFIG_SPL_SYSCON=y
> +CONFIG_AHCI_PCI=y
> +CONFIG_DWC_AHCI=y
> +CONFIG_SPL_CLK=y
> +CONFIG_ROCKCHIP_GPIO=y
> +CONFIG_SYS_I2C_ROCKCHIP=y
> +CONFIG_LED=y
> +CONFIG_LED_GPIO=y
> +CONFIG_MISC=y
> +CONFIG_I2C_EEPROM=y
> +CONFIG_SUPPORT_EMMC_RPMB=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_SDMA=y
> +CONFIG_MMC_SDHCI_ROCKCHIP=y
> +CONFIG_DWC_ETH_QOS=y
> +CONFIG_DWC_ETH_QOS_ROCKCHIP=y
> +CONFIG_RTL8169=y
> +CONFIG_PHY_ROCKCHIP_INNO_USB2=y
> +CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
> +CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_DM_PMIC_FAN53555=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_REGULATOR_RK8XX=y
> +CONFIG_PWM_ROCKCHIP=y
> +CONFIG_SPL_RAM=y
> +CONFIG_SCSI=y
> +CONFIG_DEBUG_UART_SHIFT=2
> +CONFIG_SYS_NS16550_MEM32=y
> +CONFIG_SYSRESET=y
> +CONFIG_USB=y
> +CONFIG_USB_XHCI_HCD=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_USB_EHCI_GENERIC=y
> +CONFIG_USB_OHCI_HCD=y
> +CONFIG_USB_OHCI_GENERIC=y
> +CONFIG_USB_DWC3=y
> +CONFIG_USB_DWC3_GENERIC=y
> +CONFIG_ERRNO_STR=y
> +# CONFIG_SPL_ATF_NO_PLATFORM_PARAM is not set

NAK. This forces upstream TF-A to be used with this device and differs 
from the config used for TS433.

> +CONFIG_OPTEE_LIB=y
> diff --git a/doc/board/qnap/ts233.rst b/doc/board/qnap/ts233.rst
> new file mode 100644
> index 00000000000..b706d97afa0
> --- /dev/null
> +++ b/doc/board/qnap/ts233.rst

You need to add ts233.rst to doc/board/qnap/index.rst (or use :glob: 
with a pattern in the toctree, see 
https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-option-toctree-glob).

> @@ -0,0 +1,37 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +U-Boot for Qnap TS233 Devices
> +=============================
> +
> +This allows U-Boot to boot the Qnap TS233 NAS
> +
> +The device is similar to the TS433 in terms of its basic peripheral setup
> +of SoC, DDR, EMMC, 3 USB-ports, 1G network interface, SoC-SATA ports,
> +serial and maskrom access.
> +
> +Please follow the TS433 steps but with the following changes.

Please link to it, e.g. with :doc:`../ts433` (not tested).

Otherwise, I can suggest to make use of the include directive such that 
you have a file with the common content for TS233 and TS433 that you

.. include:: building-u-boot.rst

See https://docutils.sourceforge.io/docs/ref/rst/directives.html#include.

Maybe we should provide such a base file for Rockchip SoCs such that we 
don't need to duplicate this for all boards. And they won't be outdated. 
For another time :)

Cheers,
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36122C44503
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 10:57:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFA4683946;
	Wed, 21 Jan 2026 11:57:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jd+eywgd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B361483A2D; Wed, 21 Jan 2026 11:57:28 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB8A98341A
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 11:57:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNGBWDtCJw0Ai2PNdOOU6aHs0VQGMW9WkBaG6Qvfls9TkBVaj4ngQgrMrMRyIDtCuvreRJ/bvrm/DT5ep+Y/0rdGqyYoFdMr+OqX+ViFRripf57xrGwpHwADySVWoLR3z0HaUnKDqrBZvJFgDXBGIGomYzEWAZYotVht8Ww9x0Wu0gR2S8K7By6F9dRBFcoyiDp5tNw/KNUjgizkPQgrIRYnNxPgv/z5FbPr8wfVxoNIej8uat2JqBOuDaSkG01OGdUlEIXrX5joyoCfxnfMvyOfQQAjmYHgLUDAFnzNoFzd2lGjNvyzXDqCPdeQcG4Zt4zoX45INj84I4Ei/yF0Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULG5yhrI5VyN0uojEreTyux1SAsy/rQOf0aoRw6BNd8=;
 b=UTtJan1oSSIzuPZiFS8vYQtUPtVOzL/WqG2XP3mNRoNR9lyJUusy8XpX6AUJc6ORVpBmA2W6WhcXYxLayq7mlgRg38saSbgVKRI9b+fJcbj3S06cTzdFJ+3kvudl2tVLT01Gg2V/Ao6+G7nCl/w7b3u7KwlesS0mnJwyDrL4g04Jdt9INyuvxxK+bZg24E4ZnNM2ieXvUaHxVdWNt7AXLdHqU6DtooicVE0tT9rnA7XcOVeThVHoi8nCZQtWMr5Bf22aVhITB6Y7CTBv2uIdls/LDRDrzYfIaw1EhtJ8BwXsiUyaIsA5iW7yhgZdky51SHO4zwKQE2sSHthkbAuAbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULG5yhrI5VyN0uojEreTyux1SAsy/rQOf0aoRw6BNd8=;
 b=jd+eywgdDfBhzYSROm+jDh5E4V1yw4+nsJ+TemDQYCZSfWk1nIpRVt8+yjCjS/ss7tTZkXrzGHZpWPuptjO5cpdROdG54Cv+4OBElfrKy+FkcK8LBetOwBhW/CF4+KXlWfv8Uw381r53+FrvMI/g3FJxGR9OK5QwuUic0BdaGJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA6PR04MB11780.eurprd04.prod.outlook.com (2603:10a6:102:522::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:57:25 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 10:57:25 +0000
Message-ID: <a85dcdff-324b-480d-b194-6774e4048c2a@cherry.de>
Date: Wed, 21 Jan 2026 11:57:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] doc: develop: process: Make "Work flow of a
 Custodian" a subsection
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260120223405.469050-1-trini@konsulko.com>
 <20260120223405.469050-3-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260120223405.469050-3-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0118.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::19) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA6PR04MB11780:EE_
X-MS-Office365-Filtering-Correlation-Id: 0465b06f-682d-4c42-040b-08de58dbdc5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXhCM3BHS2RLcGhHTmw0VnpzdEExbWI3SStsRHRHTlRaamhsd0RwLzZ1NU1V?=
 =?utf-8?B?UVN2blJVN0EwK2p1MFBBSGhTYmVYYTJUQ1NyL08yTVlURlpva0RBeC9lK1My?=
 =?utf-8?B?NXAxRXJERGJTSFhHVnk4bXJ5cDV0WDZDem1hMEQwS3gvRHp3UkdTdkpuQnUy?=
 =?utf-8?B?WjlWZWF0Mk8wc2h0UFZ5OStkbTZORExFUUJ1MUgyanNkcXF4M0ZrL1J2Tzh0?=
 =?utf-8?B?SHcvQ2ZoYU1DM1lPSGY3cTBkdmVVai9MakYyeTcwL3U1ekZ0S2QzNHZpY0l3?=
 =?utf-8?B?akhpWGRBMjZ5SEN1UytwQVFpWU94TS9hSmUrT3cyekxXYXpQenIzQlNhWHBX?=
 =?utf-8?B?Uk44bEFBT3dHYVA3YmplREFrS0dtdys1ZzVGNUFLQ0pYeFJWSk8vTmQzMVFI?=
 =?utf-8?B?T2tPUEV4dTVTU2dXdllqSUZhejM3K0JjZmZsMXdCQWxBYnQwckV6eW9WOHN6?=
 =?utf-8?B?dmY4dHgwODFka2RJNjVlR2dBOFk1eEhlN281VDhiWG1UTGFoWHRzcGxZekoy?=
 =?utf-8?B?ZEJZZXRiTTBvbWJBb0FQN2szekVsZXRNYjM3U1JWQ0U4Nzh0cUJ1SVVWYVhX?=
 =?utf-8?B?STVnaTJSMUkyR0ZKZGVTZ3VVUHdtYWZ5aHdzSHh2NkRBS3VyWFFUa1VnUFk4?=
 =?utf-8?B?ZXhReVdZQXNGRHBjeTVOUFIrcVpFNzY0S1VnOHJUcHNCcUgxK3JTeW9GbG92?=
 =?utf-8?B?RGpscEF5R0dxVm9vSlgzV3Y2cFFWUi9OdktaUXFEMGlDTTJXdjhHb1plL1BU?=
 =?utf-8?B?MllURTArR2NFOC9qT3RiL1E1UlZDS0Z0Z2hyZjB2Q2lwL1ZKbDgxcDNJNERV?=
 =?utf-8?B?Rm9RdFVzUWZ3MEMrZmUwbEZ2citrVkhUNGNGdWRaWDYwQmRPdzc4U2VLbW50?=
 =?utf-8?B?YVRzQ0NqQzd6dG43azdDYlZURTlIWG9Yc3R6YnZ4R0dZRXdwNEppQ09Nb2VY?=
 =?utf-8?B?LzA2aktsd0VMWmdFaml1QkZ5QkhrVFlkZHpBb3MvaWprR3BtaUpoOTVkc2c5?=
 =?utf-8?B?R1pqU2cwQ2dpVU1KYTFLOXZJZ2gvSTFkUnpxUTRRT2kvYkRncWRpZFVZREdS?=
 =?utf-8?B?L3Z1UHdGaXpUbU1PZWZnREIxUVBpZmVqRGJuSmJwUUpVTHNCSW9WS0cxS1B1?=
 =?utf-8?B?dXFKT0Y2OWdJMnRxL2VqcXhBTmwzRFgxTDkvZ0VRMmxPcmxDYThEeUdOaCtu?=
 =?utf-8?B?QlZmTXJqcWVmSjJiMFg2eURHYjBQTkMzTVFQVE55bnZvS2VJcEFpc0dwTWN0?=
 =?utf-8?B?b2RwWDlPVXNwQXdNeXNsUGFZUEZkbC9GcE9YYTY5c1A3c2ZhdHhXU3dPVVZo?=
 =?utf-8?B?V3JlU0xCTkVHVzgrNjg3M2gyWEEvMUlBUkRSSlBLeGk2bDVXa0NjUWRmNGhJ?=
 =?utf-8?B?N1lzL0VxQmdXa1ZuNmpra1F6UVc1YnJuSXRBRTVBeEJQQ1hwaVVyRDNWQkZK?=
 =?utf-8?B?bXFTcnVCM1JKZjdJa0ZJOHNwL1ZoWFo0SnJDaThWZFlSM3pMKzEzODNFemEz?=
 =?utf-8?B?elB1bEp4cWdYWmJtUmh3Y2FoRzZHQW5JSmhYbU1DOWpaVks0ZXEvc1NPcG95?=
 =?utf-8?B?TjFoNVd0cU9iRE1wT0lWdGVzZ0RJRjRSWnlkY1FNdlphdkd2aWQyL1ZGVWgy?=
 =?utf-8?B?RXZ1YmRESHBkZjhCOVI5T25rV0xTR21FMWRrcHVLQzNpMzZzclZ0ajZ1ZVNU?=
 =?utf-8?B?QXI5TXZHVnZ6RTQ5WnhZWkN4UE54UEJZZzB6US9CbFFzUWdmQVhpRENiUmYv?=
 =?utf-8?B?UUxCdEU1WkxXc1dPbjRra0ZtMm8reWozY256eUJxREVKVFc3M3ZEUDFsTi9F?=
 =?utf-8?B?OWZmZzMvckJydFhuM09ERDZSa2RuREdNZTEzZG1hMnZjU3FUcXJvRXlyaTRB?=
 =?utf-8?B?UHVUdXB4YXU1M1h3dkRVZ1B6VEU5M3hjNis4VjY5Z2JXaVNBQ1o3OXF1YzIz?=
 =?utf-8?B?bGhPQlIrSER5U2tGcVZ4WGFmNExaVFNZL1VFZmFQR3YwTXMwZnJ1SHVvaUhC?=
 =?utf-8?B?SEpPSCtTNmRkZElla0Y5VnlOUnoxcElYVWxUR3RNS1ppNHBKYjdyTGY1RUtJ?=
 =?utf-8?B?dmlRRy80TEkzb1k3VmlTcVJiZWlIdXBjMmhyQkdZTEdSUU85NWNnRW41b21C?=
 =?utf-8?Q?/mBw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVdnY3dNaTAzRkNNeXRNdnJGYXpQb3pUamlpTjhJSm9QRzdRc0lZT20vSUlT?=
 =?utf-8?B?SFRDODcrT0huZXJlNk1Yc0tJT2NickI1T2NRakplR0FJVjMwaUgxVm9zNnNB?=
 =?utf-8?B?V2dRT3pMRHg1aDFaWkJ1enFrcUo4bndwdzhkd0VqM0hac2dncmpQK2pQbVgy?=
 =?utf-8?B?VUwxMmlIU3FZd1dKWlhqYkhxdzdsUkV2ZENSbnFwbHQ0RlhlMlNyVW45VEx6?=
 =?utf-8?B?VW5HS2IxS05XeFdleUlxNTlFYUFVQldoaTNidkQ2MG1ucHF6bk92Sk9rdlIw?=
 =?utf-8?B?VkJQNGtuTDJ0cG5IWGJ0aHRGSjFJcWdpeW5oVFNwRUJ5VDZ0WEFEQ2xCZXA0?=
 =?utf-8?B?K056RFNzRzZMZlNnYzhRSTFXSzFvWjh0N1hsRUsxOTd0MmNXam9EbkJIZ1Nx?=
 =?utf-8?B?Z0I3SWlSODVGQXhuS2ZvYVUyVnJ0L0IzU1VhN0F0TWJVN3pMN25OTU9CVDFu?=
 =?utf-8?B?OEh3SU1iZmVpTlF2N2w0R08xVXNqSkl0M2VyWHdNWXJkci9MOE5UZG1HMG1t?=
 =?utf-8?B?UnE5T2hUL2pBN01FZ00wRnNkNFdWUTl0Zlhtb0d2dG9mc1FGSEJ2bXFVcjlT?=
 =?utf-8?B?Qmh0UDhTbE9qeUtIdzhXNWVOTjFrOTBIYXdIUk8zbjEwd3IwL0VpNEg3QkI0?=
 =?utf-8?B?OHJ4eDcrZGVlNHp4bExwK2dhR0tVbUFJRjhYbEQ4S1BrcTRyYis2VmtMUDA2?=
 =?utf-8?B?VXBldTRKNVlJYXZtY3NQOVpmK29WdWE4R3Z0OXFrTnRFczFvUjZ1RGZEeDBR?=
 =?utf-8?B?MWM5K2dkb2VJQitTeUF5Rlk2eVV6L1lhV3J2aEpxbGowSUZpRm8veWRuZ3Rl?=
 =?utf-8?B?cHh0dmFYQUFvb2k4SXVCN0UvNk4yTHYraUNnam1lVUFQMnpncWdWcUF1UUN0?=
 =?utf-8?B?NFB2S1k1RE5uZTdxQTRFQzllWTNlNXVtUFpBK3h4SWlzdDNMWE14djhHVXJP?=
 =?utf-8?B?RHNiODlJR0prdW9WWGhrUlZFN0VxSkFsV0p6Q1NsQVRvYTNNUEVwSjBsWTR0?=
 =?utf-8?B?c3cwT3lkdk5KSVVwN2ZhK3VtTForaXQzTFlBNCtzQkxIdGJUSm9WZjZXZGRY?=
 =?utf-8?B?MlNSWnlXQmZrSGdqSDJaY0gxNFdpcTNIUncxdCtnc0h0YWhqbTZkWkVrOHR2?=
 =?utf-8?B?N1F4YVhON3lseEFlQzIwWFF0QTdSWHY0TGVVb3lUQWdNNDZXRWRUVmsrUGhS?=
 =?utf-8?B?SmhPeW1iSCt1RmF2Z0Yya3lvYzBnUXFNT0tDVjdJdUg3M1czRnZtaEhyQnFQ?=
 =?utf-8?B?UHhGclplRjBYQ0svU0JJazJRN0JIWnVGU3YwTnZuU0lnK2xIREV6WlllaFpu?=
 =?utf-8?B?YWUyMHFQTWJFOHA4SXVQMVg0K3RyRzJINjY5UzYwMnNPZnQwZ0dwYjl3SVNH?=
 =?utf-8?B?ZTFYYzE4Mmo3VDJJN1k2MGxsUzRIVmltTG43eGJ4NEQxa2RmaGsvQWFWb1lS?=
 =?utf-8?B?ZGlKZ2wvL1ZBY1FxMEFwZzV0dU9pNTczOEJtdDFOOGRKTUpycmJOOXo1YXFB?=
 =?utf-8?B?eFBRYXVhSjF2TTdhekV1aktVaDdhdlVGemozblVnbU5pdHN5VTVaekpva0N5?=
 =?utf-8?B?MnBONVN3a3hiWXludUw4SldjekxRalFyaUQvVVpTUWZJMEhjYjBuQ1FrcDRP?=
 =?utf-8?B?RGNXYlVPYjc3TGZjZ1pFRzl3V04yUnRzK1lPUzRJTnhhaXBpcXdRS0k2czlU?=
 =?utf-8?B?eUVObVo0ZUxMM2VZRm9oOEhlQ01NdlFxYXhSMXR0RHlSL2lSRHoxSlVSUEZJ?=
 =?utf-8?B?V2RONTVXTVNReFJ1KzA3NkFzL0hlZW5QMnBkY1ZPRVN2cDJBK3k1Tm9aM3Zr?=
 =?utf-8?B?cnVKMUhkUjc2VExyM3dlc3Zha3B0bDVVc2YwNWVDaFNCbGpXc04raFF0U2JX?=
 =?utf-8?B?blNiMTVWK21JWlhxMUVZbzF6UFBtUFAzbkI2UFBDellkYnU3RWlNakgwMk5V?=
 =?utf-8?B?enBUdUt6bDdac00yVzFCY2oyU2FHajluTTVocXZkV2ZTWDFURmVsWkJZMndH?=
 =?utf-8?B?bFhhajNpK0NHK2xoaWtzN3ZmQndFZ29KUkRVbFFoQ0xadDFNRDhQcVo2TDAy?=
 =?utf-8?B?YktZemt1dU1yOTgzSkJvcFU0ckFleEtZSjBwcm1KSGQ1cktFK3dwVDRjUFo3?=
 =?utf-8?B?N3R2Vmw2eHBiWTViUU5SdmdTRjhZbUI3dWxncllldEg5SnUrZTZEYTQyRnJ2?=
 =?utf-8?B?T01Ddm9OUGZudzJuMEZxNVdzVkFFSWV1ZGlvc0JtdE82WTRWMUg0WnMwWTYx?=
 =?utf-8?B?VHZYeHA2bmZzc2tFaXNtdHQ1NFUzQkpybTNpbnJ4UTV4NDdjdDR5WVdhRm1o?=
 =?utf-8?B?a2VtM2ZnSldQZDVNWDBxOTI4NDVtMkIzbU5sckpFSm5VMXdlS3h3WDl3Rk02?=
 =?utf-8?Q?zgtr2vWRrBYJmtywSvnZpJFFwtrDRr7ZRlp8T?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0465b06f-682d-4c42-040b-08de58dbdc5e
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:57:25.3080 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6V6V+p6VwjQD4CnujXk1OQGo12GMjXJHwSqvA0uzuREptRRqoqBhYScFztRZRf2ECdhfQZUu6FweG2ViTzUKWOohC/WoToZ+H6UnIVUQ3Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11780
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

Hi Tom,

On 1/20/26 11:31 PM, Tom Rini wrote:
> Make the "Work flow of a Custodian" section be a subsection of the
> Custodioans section.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814CFC44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 15:57:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD74D8341A;
	Wed, 21 Jan 2026 16:57:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mobileye.com header.i=@mobileye.com header.b="fG+HH17Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF14A83A6A; Wed, 21 Jan 2026 16:21:15 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DAD83015
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 16:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mobileye.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Vladimir.Kondratiev@mobileye.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecB4450TXgHyPPBWD5pLDce9BEoS/UM4e4aax56RdGb7LfFtxqT9sikYM629UXWGC8a3VqeMWr8flF9RqCmd5LVMhu0nxdw0CV9bCuEg3XlvMmYKTpIl7xfOwHl4jB52aq4pVYzBNP+KVTJ4UZ7LUiIar/BNtWUzdcfCDgzh8TgUfjnC6245Fz3MRQgTa3I6gjLw0Zi7GDbkC+uYdWvnWXE6wgBbXW2RRKFlpOzKknWKQ/e5/I1Yv+oOpw+bx6ropk3mRO79fROVRVpQTBC7I6r5gMg580JU3SD4sEI9QAJVVaKof7RojUE6IIEMPGoht87cew+b4qrQ9NPer3S3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfx5nIV2VELMhiAiddhvxOXxu5nNspXIaUgyqt3r5GQ=;
 b=CQ9C+yKf7BgKvdRSXpO4Ct5NVXmI/JySivejAoee6duwIAE7a7suwS37hjRibUyyefYzFLoA5vXArVtTV3cMdzh48tbz2Uh0psM0y6V2a8lS8Kj05OkLO5l98zOCb4kcjHD0V9ePPILAJRZK5fqvncYWSB8f5HWH2jF1m9AQJHPoBSZnXpdZFQUD/2IrTthatUsRXXnmPHQzht/7GbO/FwzBKhok39NYlmhQ8eAuiEsWIUuVEnii1Z2fyMQZArsbxJee8k6hFvx0XrEcC31to1TJIjBVAjurJQZANsunBA/GasfvUI/a5vjTXP2BWp9Ll6Kc55VMjO1jIAzq88qwtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mobileye.com; dmarc=pass action=none header.from=mobileye.com;
 dkim=pass header.d=mobileye.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mobileye.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfx5nIV2VELMhiAiddhvxOXxu5nNspXIaUgyqt3r5GQ=;
 b=fG+HH17ZS78HYEZS8gGFtXbnIHfcB/nMEkcGK2uAOVEB3q/JcEsAgTwYxbvcIoKUHccWr/KRlTQznAgp040sbFUfQHVePvd0yFQdIlZ7CqDqPZWAAUr/IK25xLAwFBSkjtAlUODQG2JcJlaCI/Ui9UMLgLveocMjpZZK02oKq4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mobileye.com;
Received: from AS2PR09MB6296.eurprd09.prod.outlook.com (2603:10a6:20b:578::5)
 by PAWPR09MB6200.eurprd09.prod.outlook.com (2603:10a6:102:33c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Wed, 21 Jan
 2026 15:21:10 +0000
Received: from AS2PR09MB6296.eurprd09.prod.outlook.com
 ([fe80::ef0b:e667:faa1:bae0]) by AS2PR09MB6296.eurprd09.prod.outlook.com
 ([fe80::ef0b:e667:faa1:bae0%5]) with mapi id 15.20.9520.003; Wed, 21 Jan 2026
 15:21:10 +0000
Message-ID: <f65aa26d-6c98-4b08-a94a-1e56f6871d1e@mobileye.com>
Date: Wed, 21 Jan 2026 17:21:00 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vladimir Kondratiev <Vladimir.Kondratiev@mobileye.com>
Subject: [RFC] opensbi options from FIT image?
To: nikita.shubin@maquefel.me
Cc: afd@ti.com, ycliang@andestech.com, alpernebiyasak@gmail.com,
 anup@brainfault.org, linux@yadro.com, mr.nuke.me@gmail.com,
 n.shubin@yadro.com, sjg@chromium.org, u-boot@lists.denx.de
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::20) To AS2PR09MB6296.eurprd09.prod.outlook.com
 (2603:10a6:20b:578::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR09MB6296:EE_|PAWPR09MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 02801ca5-ab67-41f9-09ce-08de5900b4f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnZESGlwai9qQkROKzhWZmFqRTJaL01OMXZJa3FtanBzZ0FkVDl6cHJiY0tM?=
 =?utf-8?B?SE5ubWRkenpkY01DVEw2TzNGcWJWT1FrWVZQRTdTRmlnK0JZeWxPZEpyKzE2?=
 =?utf-8?B?WEJUdDVQeEU1OS9HcS9ySW5RTDBqRnN6V29rUWhSbFc5aXU4UldhWWU4SjN3?=
 =?utf-8?B?MEdONWVWb0xjZURzMTFCYjdFQmpTQ0NFTmxicXcxM0FVWS9aVUgyMG9ObXRG?=
 =?utf-8?B?RDh5WXpyVjlwYXRyZjR4WkdPU2hyR2ZRSXRhdEpPV1NaK1RMaFpvVnF2Z2hL?=
 =?utf-8?B?dy9PVG9oMUN5QVliWmtWMFNhSSs1SURtZHRJdG9aWWUwQVRhOXBSZXRLYnk5?=
 =?utf-8?B?UGdQeW9ZNFZ0UWRiSVFBK2RCWHR6aWVHQVB1cjdTak4zODdza3BmeWZyaUV3?=
 =?utf-8?B?MGFYMkJkbFkzK1ZNN3F2QzlxNHhCQ2NGZnMydWswSXkxM0JaZUE0NDRNSGxo?=
 =?utf-8?B?dXgyRTB0akMyNlpNTWlXOWp2UnY2eU1FYkltaGs3VUdSMGtOMW5mVWd3TFJP?=
 =?utf-8?B?WEZMdTlyRVg0Y09HNmE4aTB1Vk9VREx6VkduZnN2dTFvUGhGcFh2aHBKQXhW?=
 =?utf-8?B?K3gxajBzcTQ3TmljQWxpeHkyVUQ4bEc4RE9sQ1FKeTFaRE1uQURESlJjR0Qv?=
 =?utf-8?B?eUh1U1duSGlpTkhGOVAyUzhPWVpRdEdvWVdVczl6UWR3UFRybVZsZHc0ZXph?=
 =?utf-8?B?amN6bHBLNE1laUh4dTNHVlU0dkg1bkdKMHZ1b3BrUHFpU3gybGtqNTdUN0l1?=
 =?utf-8?B?aWRiNldYNnRjSU1PTFF6UWVXaGJxZzgvSDF4cUhQbUo0V0ludmhaTXVEZWFq?=
 =?utf-8?B?MDNZWk1yZzNpVzVpdGNNVk9reDdVaWI0a1J3TFRMTGFpeE9YQysxWFAwZmZ1?=
 =?utf-8?B?ZFVGRnJJM2o1MFIwbzJnMHJ4VUxyYjd1VURJREdNZnZtQVpIYTRRMnQ0Wnly?=
 =?utf-8?B?QisvSmFIckZuVkJVdVJBREUzellNdVBnN2hIQzNJVU8vRFc3UEhaVmhYd3Y3?=
 =?utf-8?B?S0hsOXB2VDYxaGpZRUduM2dYQTdoRUlLdllxZk82RzN0Y0prRTBkb251djJq?=
 =?utf-8?B?YVl1ZDJ6ajRsTSs5NlVWMS9LU1FTYm9INmM2RDIxR2NNcSsrbDArOENDQ2ZP?=
 =?utf-8?B?WFcvVktzTmtGNzdwck9SWmVlNlV2SGFWT21qUXFGU25QRnJBUUR2SVZQbnRj?=
 =?utf-8?B?bS8yNkdFR3ZzemF5VGY2U21pZUtXNGRNem9obVZ6U1Vid1pDUnBXWkxiaUMz?=
 =?utf-8?B?UVpoaVNTUm1RMGxLNTRoSktsMktlK013ZHBsQldzL0hMdnE1bFhWYnpnVEQz?=
 =?utf-8?B?R05SUFBsa1g1NlU3R1MzZ2FNcWVaMHJYSWsvVUhSY0ZrU1RZZE5qK2dGT3Bl?=
 =?utf-8?B?WUd6ZkFHeHhkOGFqUW9teDE4ZUJPYU95MmVxcHd5MEtscktVK3Yxek96Wjlz?=
 =?utf-8?B?Vzg2YnloYllQT2gya1pYYm9leTBXQUhuVnl3bmhFYTR2RXdqSHMwTTNET1lz?=
 =?utf-8?B?NHZscGhKd1MrN1o4b0dSTTlrTDZLRW9ua0NGRk1SU3dtT3dUQVJPaUtrZjEw?=
 =?utf-8?B?c1RIbENJSWFhTC8xVTlSWmtnNW9hUms0N3pCa0ZFcTUzNzJQVG0yYlY1OGFx?=
 =?utf-8?B?d3ZyL2dLYlBlQzZLNHJuRVZwNGxTRUE5cVpwdEF1QlRYbjRrMmlhQk5OT0I1?=
 =?utf-8?B?cDlpWVB0a1RiaUFQT3U5VWJhcm1DQktqbzViME1TTURyZDYrK1pwWkw5UzhH?=
 =?utf-8?B?TWN2RTY2ZFRYL0Q4aWN6dXJzelptQUFXZGxET1FZSnF0THBSUkVyRGxxdlk5?=
 =?utf-8?B?SXIya0FNRDEydmpvZGdwR3FFU2NPVHpPV2R6YzhVSVJ2SUJLTnBQRElpMHNM?=
 =?utf-8?B?N2swdkNTS2NSK08wakkvUlRINENIY0RBRDlkYWg2MnozaU1HSElXMStUS04v?=
 =?utf-8?B?ejByRCs5SE5YNWJqUnpFdy91enc2OFZQU0h4anFWMFpiUGRJZ0RwcUhid3No?=
 =?utf-8?B?eXlZT3FmUHdKZGtGcmtXNnRQMWRRSVMwVEp1a3dHUE56TEdReW9mU2R3SlhP?=
 =?utf-8?B?YTRuNlg5S1lZUmJxM3dIMmtQR2ZScjFBaUpXcHRsOTVFQ3RxSzViNUJvWWVD?=
 =?utf-8?Q?F2q4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR09MB6296.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjZCUzdWNm1FbFNhdEc4aEtXOGVXS293bWlMQzdwaks5VjY3TWU1Y2M1MXVY?=
 =?utf-8?B?a1BwOUJnYnd6YjVsV3FiSlZnZ3RLVW5nakh2NTRoNWhZSW9UQ2hyOUYvZ01a?=
 =?utf-8?B?aXFwYmhTUTJGMVlER2Z0a2lsTTVmQmxONXlISXVLNlhHamhDNFFMV0IzdGox?=
 =?utf-8?B?UWJ5Ym9uSnViMVRZNjNSTUJJR0t2Nnl6WmJtUUhIVDhXT1dHdFNOcVpNaGdp?=
 =?utf-8?B?bTNRbU5Nc3BQT0l3OXZmU0tCRGNOeUpPb2ZlcmRIamQ1eVBHMFFhZExGQXZt?=
 =?utf-8?B?ZGJINWY3SG11WFZGOFpqMmxPN21oQTZtSloyd0hBTmw2dEs0b290dGh0QjNL?=
 =?utf-8?B?QzBiOGliUlRTNkVwQkRHSDFjOUQ5YWNjVUR2NUdjR0NSS1kzOW9mTTBBMDNF?=
 =?utf-8?B?bjRyQm5EcEZ1d0l3QVAzSGxKRkhxZGtRb3ZzTGtpa2ZiZVZLVGdVT0V2YjVa?=
 =?utf-8?B?M2M1bWRwNG12Smt0Zk9FSk5JalpQZHg5S3lDaERIbmpzN0xMSWFmTDVtUENJ?=
 =?utf-8?B?aFhrb204cUI1dEw3VER6UFRRMFJ1cVYvM01USFBUTngxN2hRSytnekE2MERF?=
 =?utf-8?B?UnZSa1JaMDQvdzFWdUJ0SWpnM085aHp6TnFRWjBVclhZUG9BYWk2K2Z2Y1Vs?=
 =?utf-8?B?SFVZRElIN0JGTzRNczArdkdRcnJyWXFaVUF6b2NjWWEzbTNqQXZWb0RZdE83?=
 =?utf-8?B?N2V2bnFEeTFaQVJtei9VcUZlWENiWEhXNjNPaWZZdUZQck9jazJ1MGFUK1Yw?=
 =?utf-8?B?dnlqdEcvWlBjemVkN0Q3WEFDNFNHSG9NOVQydU9aSDdzS3BLSE90cHI0TEYr?=
 =?utf-8?B?Z3pVdGduNW1mc0VUbGNiOWxQTkR5bjgyTDgrSExoSUtGMUxJZVcvd0dyeWlz?=
 =?utf-8?B?ZEIxQVRjQ2hKS1hlSFd1U1hobXZseTlRcTdkby9FbXB1SFZBV2s0WXdhVXBR?=
 =?utf-8?B?R2VqS2ZuS2s4RmxBZk1ObWVad09zb1QrZElkQ1BMWUc0NFhNYkZxc0JGWkNT?=
 =?utf-8?B?OGhwUGxvZGZNNG1pc3ErN2liREhtWnQzTjlSZ2NFMFdhTlN0TzMyM2M5VU1p?=
 =?utf-8?B?RGdNYTJRcGdYRjZpTEFYN3VRVmdVVlhxU0hWQ3VZWlN4SVpRdjh4eDA1V0I5?=
 =?utf-8?B?RDhlZVYwWnR4dGk5M05EOW9YbmgvaFpPUGl6MHFTajBuN1Q0NTZwUm5MM2J0?=
 =?utf-8?B?ZmxzaGNHOUdDdkhyZ1FleVNnLythaWpsWnA1RmtBeEZRSlpSdTVHTEpNSkxV?=
 =?utf-8?B?WVJMd1RkQXMvWkQ0ekpTcVgwRHZxZTBuQ295Rk1iQnV3L1RYSUswK0xoSFpJ?=
 =?utf-8?B?bHVjMExmbEVpMmJhaUR2amJtb1oyV3pPakV3aWtjSHNIS2lGQ2tRbWZYTzl4?=
 =?utf-8?B?WE5BckNlbHJBWUFFaTYyc2g3N3lNMlYxWjc0V1JYVWNZUGVoU29zWG8vVE5Q?=
 =?utf-8?B?d2JsemNmQUlCUEozZzRHRnN0eGdDYzFLbEpYS1dZZk5TRHNESFhwUlBKb1ZB?=
 =?utf-8?B?T3NyWTlPTW5hNDI1cUpUWHJkQmdycGZqeHJseUxPUjFaVTB2aGM5dWZjQ1Q2?=
 =?utf-8?B?VDcwc2QzU1VKd0VoV1hleGI5dWcvWGpYbjl2emNkOHVsMDhuVFplNWtKY3BB?=
 =?utf-8?B?VU1rRTBZeHlOZlNxTWVhMXBqbDFSeWZZc3FnaUNMY2JYTTROUHlYVVJFM0hF?=
 =?utf-8?B?dHZlUG1yOHlsalJxMjdvWkVuL0tPQUU2N0ZWWGc3OXdYN0QwSGIzTVZWNmhl?=
 =?utf-8?B?SldVVHhXV0VHV1lWb0czV3M1Sm5PR2FFTmIzd1lCRnlUTzhCRythZk1xU3g2?=
 =?utf-8?B?TWpiLzBRbjB6aG96b25SU2JQcU1uZ0EzZjVlSlh2cGQ5R1dvV0NkT2VBUWlv?=
 =?utf-8?B?MHA5NGMzVU1ISjU3blF0eGQ2TUVVbjhwUjJRS0RIckRCRm1rb1JKeXJaL0ls?=
 =?utf-8?B?RE9JcTh1ZWZOUWpFeFpQRkpaMVpzY24wMHVReGVCVzVnZHgvLzR1dUxzRk1y?=
 =?utf-8?B?MjNjcnptK3owQVBCdUFQeWk5Uk1OTmJ5cUZFYUVCWGFTRHM2UTVRN256TnZ1?=
 =?utf-8?B?WW5SdmpkaHk0cXdaaEM0UXZhdThQYXY2WHZRanViajV6YzBUdlU0OHNNU1Z4?=
 =?utf-8?B?aVVEdDVacGt2MERVQUxud2tQMks3WmsvbjFDLzh3S3VQVXJINHVyVlBsNzFK?=
 =?utf-8?B?ZXVzRzF1YlRmdnk1NHcyelVwVDZ2OSt5VmY3SkZFWDc3TlZYcXRRYlVMSEd6?=
 =?utf-8?B?cWlHZ1BaUGpUWnd0ZXc2c0Z4WE41dUN3ZGppOC9BQlc4OEVWTVZxZVc2RVda?=
 =?utf-8?B?TE5qNlA1SE1sSEZBdU80TVRITXVUQWdxWXRTT3Vhc0h2R2VnMEtndz09?=
X-OriginatorOrg: mobileye.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02801ca5-ab67-41f9-09ce-08de5900b4f2
X-MS-Exchange-CrossTenant-AuthSource: AS2PR09MB6296.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 15:21:10.5420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f85ba13-6953-46a6-9c5b-7599fd80e9aa
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWt+/NafNobz5jdePkMzme2lBy0myLj9pnzUaZA4hloiWTOaokA8Tj4nExmGgWaWO5O0ectRlb22PdimyJ6Htg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR09MB6200
X-Mailman-Approved-At: Wed, 21 Jan 2026 16:57:44 +0100
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
Reply-To: YvNmYpUNm9CmRIHP@ubuntu01
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi all,

After commit aa0eda17cf98 ("spl: opensbi: convert scratch options to config") it is possible
to specify options for the opensbi, as in struct fw_dynamic_info "options", in config file.
It is better than hard coded value but still, it is fixed at the compile time.

Can we have this options set at image load time? This would help to enable, for example,
opensbi debug prints at the runtime. I see an option to do so in FIT image, by adding
property like "opensbi_options" to the opensbi image node or to the configuration node.

While bootloader usually flashed on some raw partition and it is not that easy to
recompile and re-flash it for every run, OS FIT image can be stored on the partition
formatted with some filesystem so changing FIT image is easy. Also, if it is only
matter of changing .its file and re-run "mkimage", whole process of changing opensbi
options became easy.

I see even more value in this for u-boot proper, if we teach it to run in M-mode, so
for developer boot sequence can be

PBL -> u-boot SPL -> u-boot -> opensbi -> linux

where u-boot will enable network and load FIT image from TFTP; then changing opensbi flags
will be matter of seconds

Examples, proposed modification marked with "==>":

for opensbi image node:

opensbi {

       	description = "OpenSBI fw_dynamic Firmware";

       	data        = /incbin/("fw_dynamic.bin");

	type        = "firmware";

       	arch        = "riscv";

       	os          = "opensbi";
==>	opensbi_options = 
<2>; // SBI_SCRATCH_DEBUG_PRINTS
        compression = "none";

	load        = <0x8 0x00100000>;

       	entry       = <0x8 0x00100000>;

};


for configuration node:

config-1 {

	description = "config-description";

	kernel = "linux";

	firmware     = "opensbi";

==>	opensbi_options = <2>; // SBI_SCRATCH_DEBUG_PRINTS
	ramdisk     = "initrd";

	fdt = "fdt-1";

	loadables = "linux", "initrd";

};


Comments?

Thanks, Vladimir

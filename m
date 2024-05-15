Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC888C25B79
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:41:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6320188307;
	Wed, 15 May 2024 14:41:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="NOfYLDFS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19ED28826C; Wed, 15 May 2024 14:41:42 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2611::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 804C7882FE
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:41:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLejZWS05yM1Lql5byx4JLhHEWOtMU1DaynGk/SZK2F4TYECC3bLN/sbXdCPAeZkZuQjphYQIG8zKq1o/bX5xMdazs6yQaeXyr6+UGe+R6iPbtaZZK751n+xXofX4dTAgNtx6UiYR3CNEeQBr+9axBME2Y4+rlc4knK2cbG6XRC0XSmT9lbj0h95VBTKQzoiA6ZUTHV16kBzOqZMSLOJhqq8p7trAIRcZFeglubG7Nyto5LqKe0+STbF0R5tqnlSm7C/Qe8dWsFMFPKRIj/aUZWcnP5qqrMf1d151KL0XnsnB/6/qKPsMXRtmNLk/zMiqzyifGIspTOjSLVy3BuPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iydIl1uZsud8V92Ko0veGp3WkpOSxDo/CaRjcywzdVE=;
 b=Eal/g6yC43KrOMddsIAoWmA4ykjflLB6InzN5HengWLT972bO+8Npqq1Nys3x673X8b2XRKMKeTHI7iAGzRcUiLJ0OM7oaSb0TjqiO63bqJTa/4dvoVaI942FXZafQnnqlunp8+QIU1xe4kP4fuMPrLK5piuR7TiYE0y7Xjt/B2gTnc1Zjl2Bt9Se0bWyz0xqNvINYISKFbekgk4wXx/GVRpZixM/ETVsJohSlwU1s8SUPJralcCsGeHDVbh+Zl3iJnoBYZ3fw+C6X3aCbSb+A2ShDpy8t5UByJ3GaehjU8KSNYYQEvi77u2GIaN5CJLpsn4bqlrGOAxqdQdCUxg4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iydIl1uZsud8V92Ko0veGp3WkpOSxDo/CaRjcywzdVE=;
 b=NOfYLDFSWtUmMv9mV0oISsr51yJQUbch3tW3rOBxgirJ84Dwx2xPnC1G/Nf3kgLVNxwDNJq8KXYyIJKXYPSZN+Os/fkGmux2jF2Qaqz9wd+ylHbvYbwBJjCXKT34mWn6mtTn9y4Rg9xMdvtyM295dDL1fRdMP6mzPqHla9bgbR4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS4PR08MB8118.eurprd08.prod.outlook.com (2603:10a6:20b:58a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 12:41:37 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 12:41:37 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v2 2/2] drivers: misc: Add driver to access ZynqMP efuses
Date: Wed, 15 May 2024 14:41:25 +0200
Message-Id: <20240515124125.732487-3-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
References: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS4PR08MB8118:EE_
X-MS-Office365-Filtering-Correlation-Id: 45702f20-c696-4b78-ded0-08dc74dc5c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|7416005|52116005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MGhyRzNyekZmSkNlTE5MZ21CL3RmNFVjcDhFM3hJanhtSHlaYk8zTjJoRnJo?=
 =?utf-8?B?Y1JWN3ZPdEVOUjRWMm4xYk1sVEtDbzZkQ0NQQVlodllHa0hUNHc0RGMrbW5O?=
 =?utf-8?B?YXUxeUZJR2lNZExPaW91Q1V5MGZLTlNtcHhzY2VpTTZudWxxNmxIRjFFcHNE?=
 =?utf-8?B?aGFpbmJ4M2M4aGk3UmlNN0VhZ1pYS0Z3SElGcDhjalNYaDRJNnRxWXBmUkQ2?=
 =?utf-8?B?b09mdTUxSFF1dnJBcDFoN05ndXkzUitoTlZ2NlZzdnM4My9jdWMvQkxSRUI1?=
 =?utf-8?B?NEZtSlZ5M1BaT0ZuRHF1WllpcDFsdjhWV2xBWEk1cTF2OE5YOCsyVVN2ZTBu?=
 =?utf-8?B?a1ZRbW1rYzZ4bjREdm5rZWUvUHVGNVZXRVNRSlJmMDJIbk1namZRZFIxc2lZ?=
 =?utf-8?B?TjlWb090RDZXVmdOTndXUG9RVHNQcnhwYmJ1KzVyQWxia3UvWGl3V29BSjIr?=
 =?utf-8?B?YzRxTWJnSXpJZm03SnJyc3lxMU1hV29CcFltNTlSbjdPOU5mWXdvUFQ3ME9l?=
 =?utf-8?B?bG82bXFIQiswWTVSNnoydU9EOUt0b1VWdUtxa2UxbkJWWDJtMmxEVVo3MnZE?=
 =?utf-8?B?SUJjOFdqbEttS2FkZGZ6blNqLy8zUklsODd3NWRTR2pLckF1NmFqUGk5cVR3?=
 =?utf-8?B?VC9RNSt4RzBoNWlNaW5uMmJaVFcvTmozYkpxMTB1M2hiRC9OemNwYXF5V0VY?=
 =?utf-8?B?K3FVc2ZLTGpxMzlmQnFxUDVqVVFJOWtERC92TDVhRkI4Nlo2TmtxQ0NWcXJ5?=
 =?utf-8?B?cHRXNUw5d0NwYk1MQ3dsb1cvcU9xSjZlUXF6R3BydGp3aVdhOHo0ZEtJVmll?=
 =?utf-8?B?M1VxcndXT1UzZlc0eTRZOWxDemN6eS9CaFlsY3BTM055anFMMVoyZWVvT0RF?=
 =?utf-8?B?OG0reE1mdVJnVWkvaWFqU3RYQVROb3F0UkJtUUsvKzFhODlrVmtkZldvNnpu?=
 =?utf-8?B?OERCTExFRlRWRGxrNUlrd3V5SVh6TDNUWisxZ1Y2VkpsNlpqREVGRWtDYlBQ?=
 =?utf-8?B?OUl5aXc4ZUNhaVMzekV0cDloUTZkRU9CMjB1U1ZHRjVIR29xakVPNjk0SHIr?=
 =?utf-8?B?NG0zemc1SGhzQ0g3R3ZpRDZZWXBNTWd4bGxyVEtpaSsxSGtiNFByOHNJQ0hS?=
 =?utf-8?B?ZmQ4Nlg2MzdVUFExRDNhbFlLUFllT0MyV1piYk82ZTRtRC9XNVRXNG40Qmhq?=
 =?utf-8?B?WEx1Yy9ybW4vOThlUTEyYTNqOCtLc3ZPSlkyU05aUGFuQXYwUWVrdGFYbnhx?=
 =?utf-8?B?alR6Q2pxQW9KcUNCMWQxWm9oT0VkcXJETTBSRmkxaFJUZmcxMTZmdWxKS1A3?=
 =?utf-8?B?a1dtaXhVVzZ5bjZKaFpZdW1ObkI2UFlDaFJwczF0VHFLSklReHl2ekYrZlRy?=
 =?utf-8?B?aFNaYU9EOUkrM2hoQmwrNFRqQzVDNjhnR3ZvLzJSNmwrVGZ6UW5NQm9aVUxq?=
 =?utf-8?B?VThGRVE3d01kc25JNUtwcFRBVFVBbVIwdkJUbXZicUk5Z0lzdWZOWHkzQlhF?=
 =?utf-8?B?N0xBdWVrdTh3MHpWc0xxb0ZIVTMwcUJyVExXM25nUHJBU1RZaFEreDlGOGVV?=
 =?utf-8?B?QlB1MDk3eTFtYXJtMlJkcGlkQzFhWERIMmQyendVNGtJc3BMWVBoS09naU8r?=
 =?utf-8?B?NGdFVTJzSXVkQS9zSWEzaDdTMlAyR0JrUFBtRDFZNitEanJMOWNYeDJrM2dV?=
 =?utf-8?B?Vk5KcXQwK0pCQmQ2REdRclZNNkU2Yk1pTUxGN2krUm5rSit5N3E2SnhRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(7416005)(52116005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0pMRHV5MlRkcDVxS080aDNEa0pPWnUzRHhRM2RkTVkvUGlxbjlaZFRsTGhh?=
 =?utf-8?B?OUZ1OU8vYVB1bzNBN3U0aGZaajE0WVNsQUZkS1A5ZW91NExIek5STEluNGRs?=
 =?utf-8?B?QUZjQkM2SUFMbTVrVDNhcU9rbnFwR3M3TkNYaFlSeDcvajZtZ052WnFqcHZG?=
 =?utf-8?B?ZTVCQmpJNTZMeVZGVHJMdzRzdXRReitUTGFrTmxQRTFhNEM0NkVyaEphQk9o?=
 =?utf-8?B?MWg1ZEt2eThVRnFKOTJGcWpwM0pLVHNaRHhkT0ZidHZwd0R3SWgyS0ZnTFUr?=
 =?utf-8?B?T280WWp1ZUhpOW5HTDJIcG5HY2xDajQwblNNc3Fwalhuc1NMNDBBY1Vic2Qz?=
 =?utf-8?B?NEVacEhlaWtXWXlBRW13cmZPMlZYMXRTQ05xUWh2YVlwSzA5YnMzdGswRlBB?=
 =?utf-8?B?V2swUWdmK1BmQXVGVjBPU2V4VTQrMmV3Y2d4cFh6SkdyOG5Fb2JSRllGVmph?=
 =?utf-8?B?VE9UUFNiM0QrY090elFnU3QrektVK2dQY3M0d0pERFd3bzJwZ291YzZBZTR3?=
 =?utf-8?B?WVhtUmdvR0p4Um9sY1k0Qm1qdzZuWHFsM05KSzAyNE5zT3E3UlpkQS9XNllU?=
 =?utf-8?B?WW1JL1hXRTZvSmZPMzJPMm1hVmZFd1ZlSVhQNzdFZjMvZXM0UXEyUkE5d2pM?=
 =?utf-8?B?Vzk4aUFuaFBrb3Ixd0ZYTHcyS1QzOEVRY0FwaFdMeC9oSzQ0VHlvbHB6NFdT?=
 =?utf-8?B?Wlp0S1NmUlV6NDVKUjRQS2dzWWFzSGdwUkQyVitQWU9VNHNsTENoMVE2VGJ1?=
 =?utf-8?B?QVo1Ny9FWHlkdi92d1QzaGJubnJQbk9IYUhBaVVhSEk1YkwxdWhwS1c5UlJD?=
 =?utf-8?B?QjZKd2QvSFJLSUN5ZFMvbWxKUjh3aWtaOFozKzVsMzJlVWozN1lqWkdpRWtL?=
 =?utf-8?B?RTl4M2dCeE5zNXdtSVdKRDRkbE1VMDl3RERyQkRqMExoN2J3ZitiVzRGZ1BW?=
 =?utf-8?B?ZzJqdksxSGQyV1E0T3FsNGc3V2xEUnUzdzc2RHRkWXRlK2Q3WWZsTVlLTHNC?=
 =?utf-8?B?V3l2YVowYzR4YkRwWGU3VEJnMEFZbyt0djVwVjQ2SDYxMFFXakYwTjI4dGpB?=
 =?utf-8?B?S1BnTWw3UG1GcFVyZFZjeGVmZHFzbDFTNklWMy8xUlpYLzl0SzlJbUtINEdp?=
 =?utf-8?B?SXNPeGt0MHZ5K1hETTFBYzJQWWhxWlozdEFrSDhWM0ZJcllGMlVDYitROTNF?=
 =?utf-8?B?Z1lXWWduVDQ0OGJWQmUvc0RZRHVXYXpvZm9ORE43YTQ4bkxaTjJiTGpZbm1L?=
 =?utf-8?B?Slk1ZzMzYlZFZGhrS2UwRkRacS9zVHIrTFZUbEY0cCttZk5aUTVScE1JVGF4?=
 =?utf-8?B?VTd0WFd1RFY2SENPODNUYWVtQVFKMHk3SWVZY2VMU3hkVVJQUU9tZUUrQ1hL?=
 =?utf-8?B?bGtGK3J6cWx0QkJIZ2t4eGJwVmdvQTRTZ0l6VFhOS2R3WXNnYWFRV2dWRUov?=
 =?utf-8?B?TlNOaGVJblA1M2N1ZzRkUDRuam4vNXVxeCtJUXNqZlpnMmhLQm16NTBPN2Nt?=
 =?utf-8?B?ZW1TVVZJVUcyRG1tMW9lWnJxRXo4RldkWTdwN2hDY3AwckRKdEI0L0h4c1pL?=
 =?utf-8?B?ZEdza1NQOGdUSnVzWGt2c1JqYkxVd25sWUMzaEExdFU1c2l0MWxUUmVkWkV2?=
 =?utf-8?B?cXA5ZkVPbWFCN0dCczlBUU9xUzJZMTJWUitXTlMvWHJpOWdGcEtXbUx4bEN6?=
 =?utf-8?B?dmhnNWFzZnVCeGZyYlBmRjdNV2tPMEZQOXpMWjdIN05QazI4UGtpQmR4RW9q?=
 =?utf-8?B?a2FiVk5WZ2tyaWg4WjFDcDg2THlGZDErNldBeHFBR1dVS1o5bDZ2MmpoazFM?=
 =?utf-8?B?dGFSekVSa3REM3lEV1lGdVZKOEhqZllTOGlWK2t6cFVkNC93NGJ3bExQRmNS?=
 =?utf-8?B?bEs4SHE0Y0VuZjlUWFdnUmtxQWdIVzNMbWNFL21GbjR5UkJSSzgzTFVBVFVI?=
 =?utf-8?B?WEx1YTdCbmcrYlA1SUNUM0NEWndYSXphUWR3aWY3b1NpNXJVc3d5NXIxWU9m?=
 =?utf-8?B?VlA3KzdteVZja041OVFiS0tHYW91NEgxaVMxWllJYWE1OFA3Q1RSVTJ2SXJQ?=
 =?utf-8?B?SFlYNjk3RHpsVlA5czBuTTZDWVlUaFBjd3ZhaTJDbGwvdEFZREg5cW5rdHBL?=
 =?utf-8?B?a3VCbGZnU3lSbUJtT2ErMUMzWGEwOGtCclNINVRuWFpub2wxUE44NThoYVhV?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45702f20-c696-4b78-ded0-08dc74dc5c85
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 12:41:37.4955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epPqPTDKYzlpQhA1MOXRve035aJDv4VXUAAYXZRV2whgmZaDsCvmk8VxDBF6vBVHumy+zdHmhX+QTrrHR/D9EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8118
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add driver to access ZynqMP efuses. This is a u-boot port of [1].

[1] https://lore.kernel.org/all/20240224114516.86365-8-srinivas.kandagatla@linaro.org/

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

Changes in v2:
- Drop vendor specific fuse cmd, use existing fuse cmd
- Minor code refactoring (reverse x-mas tree)

 drivers/misc/Kconfig        |   8 +
 drivers/misc/Makefile       |   1 +
 drivers/misc/zynqmp_efuse.c | 324 ++++++++++++++++++++++++++++++++++++
 3 files changed, 333 insertions(+)
 create mode 100644 drivers/misc/zynqmp_efuse.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6009d55f400..c07f50c9a76 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -298,6 +298,14 @@ config FSL_SEC_MON
 	  Security Monitor can be transitioned on any security failures,
 	  like software violations or hardware security violations.
 
+config ZYNQMP_EFUSE
+	bool "Enable ZynqMP eFUSE Driver"
+	depends on ZYNQMP_FIRMWARE
+	help
+	  Enable access to Zynq UltraScale (ZynqMP) eFUSEs thought PMU firmware
+	  interface. ZnyqMP has 256 eFUSEs where some of them are security related
+	  and cannot be read back (i.e. AES key).
+
 choice
 	prompt "Security monitor interaction endianess"
 	depends on FSL_SEC_MON
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index e53d52c47b3..68ba5648eab 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -92,3 +92,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
 obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
+obj-$(CONFIG_ZYNQMP_EFUSE) += zynqmp_efuse.o
diff --git a/drivers/misc/zynqmp_efuse.c b/drivers/misc/zynqmp_efuse.c
new file mode 100644
index 00000000000..98a39c1ebdd
--- /dev/null
+++ b/drivers/misc/zynqmp_efuse.c
@@ -0,0 +1,324 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * (C) Copyright 2014 - 2015 Xilinx, Inc.
+ * Michal Simek <michal.simek@amd.com>
+ *
+ * (C) Copyright 2024 Weidmueller Interface GmbH
+ * Lukas Funke <lukas.funke@weidmueller.com>
+ */
+
+#include <compiler.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <zynqmp_firmware.h>
+#include <asm/dma-mapping.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <misc.h>
+
+#define SILICON_REVISION_MASK 0xF
+#define P_USER_0_64_UPPER_MASK	0x5FFF0000
+#define P_USER_127_LOWER_4_BIT_MASK 0xF
+#define WORD_INBYTES		(4)
+#define SOC_VER_SIZE		(0x4)
+#define SOC_VERSION_OFFSET	(0x0)
+#define EFUSE_START_OFFSET	(0xC)
+#define EFUSE_END_OFFSET	(0xFC)
+#define EFUSE_PUF_START_OFFSET	(0x100)
+#define EFUSE_PUF_MID_OFFSET	(0x140)
+#define EFUSE_PUF_END_OFFSET	(0x17F)
+#define EFUSE_NOT_ENABLED	(29)
+#define EFUSE_READ		(0)
+#define EFUSE_WRITE		(1)
+
+/**
+ * struct efuse_map_entry - offset and length of zynqmp fuses
+ * @offset:	offset of efuse to be read/write
+ * @length:	length of efuse
+ */
+struct efuse_map_entry {
+	u32 offset;
+	u32 length;
+};
+
+struct efuse_map_entry zynqmp_efuse_table[] = {
+	{0x000, 0x04}, /* soc revision */
+	{0x00c, 0x0c}, /* SoC DNA */
+	{0x020, 0x04}, /* efuse-usr0 */
+	{0x024, 0x04}, /* efuse-usr1 */
+	{0x028, 0x04}, /* efuse-usr2 */
+	{0x02c, 0x04}, /* efuse-usr3 */
+	{0x030, 0x04}, /* efuse-usr4 */
+	{0x034, 0x04}, /* efuse-usr5 */
+	{0x038, 0x04}, /* efuse-usr6 */
+	{0x03c, 0x04}, /* efuse-usr7 */
+	{0x040, 0x04}, /* efuse-miscusr */
+	{0x050, 0x04}, /* efuse-chash */
+	{0x054, 0x04}, /* efuse-pufmisc */
+	{0x058, 0x04}, /* efuse-sec */
+	{0x05c, 0x04}, /* efuse-spkid */
+	{0x060, 0x30}, /* efuse-aeskey */
+	{0x0a0, 0x30}, /* ppk0-hash */
+	{0x0d0, 0x30}, /* ppk1-hash */
+	{0x100, 0x7f}, /* pufuser */
+};
+
+/**
+ * struct xilinx_efuse - the basic structure
+ * @src:	address of the buffer to store the data to be write/read
+ * @size:	no of words to be read/write
+ * @offset:	offset to be read/write`
+ * @flag:	0 - represents efuse read and 1- represents efuse write
+ * @pufuserfuse:0 - represents non-puf efuses, offset is used for read/write
+ *		1 - represents puf user fuse row number.
+ *
+ * this structure stores all the required details to
+ * read/write efuse memory.
+ */
+struct xilinx_efuse {
+	u64 src;
+	u32 size;
+	u32 offset;
+	u32 flag;
+	u32 pufuserfuse;
+};
+
+static int zynqmp_efuse_get_length(u32 offset, u32 *base_offset, u32 *len)
+{
+	struct efuse_map_entry *fuse;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(zynqmp_efuse_table); ++i) {
+		fuse = &zynqmp_efuse_table[i];
+		if (offset >= fuse->offset &&
+		    offset < fuse->offset + fuse->length) {
+			*base_offset = fuse->offset;
+			*len = fuse->length;
+			return 0;
+			}
+	}
+
+	return -ENOENT;
+}
+
+static int zynqmp_efuse_access(struct udevice *dev, unsigned int offset,
+			       void *val, size_t bytes, unsigned int flag,
+			       unsigned int pufflag)
+{
+	size_t words = bytes / WORD_INBYTES;
+	struct xilinx_efuse *efuse;
+	ulong dma_addr, dma_buf;
+	int ret, value;
+	char *data;
+
+	if (bytes % WORD_INBYTES != 0) {
+		dev_err(dev, "Bytes requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 0 && offset % WORD_INBYTES) {
+		dev_err(dev, "Offset requested should be word aligned\n");
+		return -EOPNOTSUPP;
+	}
+
+	if (pufflag == 1 && flag == EFUSE_WRITE) {
+		memcpy(&value, val, bytes);
+		if ((offset == EFUSE_PUF_START_OFFSET ||
+		     offset == EFUSE_PUF_MID_OFFSET) &&
+		    value & P_USER_0_64_UPPER_MASK) {
+			dev_err(dev, "Only lower 4 bytes are allowed to be programmed in P_USER_0 & P_USER_64\n");
+			return -EOPNOTSUPP;
+		}
+
+		if (offset == EFUSE_PUF_END_OFFSET &&
+		    (value & P_USER_127_LOWER_4_BIT_MASK)) {
+			dev_err(dev, "Only MSB 28 bits are allowed to be programmed for P_USER_127\n");
+			return -EOPNOTSUPP;
+		}
+	}
+
+	efuse = dma_alloc_coherent(sizeof(struct xilinx_efuse), &dma_addr);
+	if (!efuse)
+		return -ENOMEM;
+
+	data = dma_alloc_coherent(bytes, &dma_buf);
+	if (!data) {
+		dma_free_coherent(efuse);
+		return -ENOMEM;
+	}
+
+	if (flag == EFUSE_WRITE) {
+		memcpy(data, val, bytes);
+		efuse->flag = EFUSE_WRITE;
+	} else {
+		efuse->flag = EFUSE_READ;
+	}
+
+	efuse->src = dma_buf;
+	efuse->size = words;
+	efuse->offset = offset;
+	efuse->pufuserfuse = pufflag;
+
+	flush_dcache_range((ulong)efuse, (ulong)efuse +
+				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
+	flush_dcache_range((ulong)data, (ulong)data +
+				   roundup(sizeof(struct xilinx_efuse), ARCH_DMA_MINALIGN));
+
+	zynqmp_pm_efuse_access(dma_addr, (u32 *)&ret);
+	if (ret != 0) {
+		if (ret == EFUSE_NOT_ENABLED) {
+			dev_err(dev, "efuse access is not enabled\n");
+			ret = -EOPNOTSUPP;
+			goto END;
+		}
+		dev_err(dev, "Error in efuse read %x\n", ret);
+		ret = -EPERM;
+		goto END;
+	}
+
+	if (flag == EFUSE_READ)
+		memcpy(val, data, bytes);
+END:
+
+	dma_free_coherent(efuse);
+	dma_free_coherent(data);
+
+	return ret;
+}
+
+static int zynqmp_nvmem_read(struct udevice *dev, int offset,
+			     void *val, int bytes)
+{
+	int ret, pufflag = 0;
+	int idcode, version;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	dev_dbg(dev, "reading from offset=0x%x, bytes=%d\n", offset, bytes);
+
+	switch (offset) {
+	/* Soc version offset is zero */
+	case SOC_VERSION_OFFSET:
+		if (bytes != SOC_VER_SIZE)
+			return -EOPNOTSUPP;
+
+		ret = zynqmp_pm_get_chipid((u32 *)&idcode, (u32 *)&version);
+		if (ret < 0)
+			return ret;
+
+		*(int *)val = version & SILICON_REVISION_MASK;
+		break;
+	/* Efuse offset starts from 0xc */
+	case EFUSE_START_OFFSET ... EFUSE_END_OFFSET:
+	case EFUSE_PUF_START_OFFSET ... EFUSE_PUF_END_OFFSET:
+		ret = zynqmp_efuse_access(dev, offset, val,
+					  bytes, EFUSE_READ, pufflag);
+		break;
+	default:
+		*(u32 *)val = 0xDEADBEEF;
+		ret = 0;
+		break;
+	}
+
+	return ret;
+}
+
+static int zynqmp_nvmem_write(struct udevice *dev, int offset, const void *val,
+			      int bytes)
+{
+	int pufflag = 0;
+
+	dev_dbg(dev, "writing to offset=0x%x, bytes=%d", offset, bytes);
+
+	if (offset < EFUSE_START_OFFSET || offset > EFUSE_PUF_END_OFFSET)
+		return -EOPNOTSUPP;
+
+	if (offset >= EFUSE_PUF_START_OFFSET && offset <= EFUSE_PUF_END_OFFSET)
+		pufflag = 1;
+
+	return zynqmp_efuse_access(dev, offset,
+				   (void *)val, bytes, EFUSE_WRITE, pufflag);
+}
+
+int fuse_read(u32 bank, u32 word, u32 *val)
+{
+	u32 base_offset, offset, len;
+	struct udevice *dev;
+	u8 buf[128];
+	int ret;
+
+	memset(buf, 0, sizeof(buf));
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(zynqmp_efuse), &dev);
+	if (ret)
+		return log_msg_ret("uclass_drv", ret);
+
+	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
+	if (ret)
+		return log_msg_ret("efuse_offset", ret);
+
+	ret = misc_read(dev, base_offset, (void *)buf, len);
+	if (ret)
+		return log_msg_ret("misc_read", ret);
+
+	offset = word - base_offset;
+	*val = ((u32 *)buf)[offset];
+
+	return 0;
+}
+
+int fuse_prog(u32 bank, u32 word, u32 val)
+{
+	u32 base_offset, len;
+	struct udevice *dev;
+	int ret;
+
+	ret = zynqmp_efuse_get_length(word, &base_offset, &len);
+	if (ret)
+		return log_msg_ret("efuse_offset", ret);
+
+	ret = uclass_get_device_by_driver(UCLASS_MISC,
+					  DM_DRIVER_GET(zynqmp_efuse), &dev);
+	if (ret)
+		return log_msg_ret("uclass_drv", ret);
+
+	if (word != base_offset || len != sizeof(val))
+		return -EINVAL;
+
+	ret = misc_write(dev, word, (void *)&val, sizeof(val));
+	if (ret)
+		return log_msg_ret("misc_write", ret);
+
+	return 0;
+}
+
+int fuse_sense(u32 bank, u32 word, u32 *val)
+{
+	/* We do not support sense */
+	return -ENOSYS;
+}
+
+int fuse_override(u32 bank, u32 word, u32 val)
+{
+	/* We do not support overriding */
+	return -ENOSYS;
+}
+
+static const struct udevice_id zynqmp_efuse_match[] = {
+	{ .compatible = "xlnx,zynqmp-nvmem-fw", },
+	{ /* sentinel */ },
+};
+
+static const struct misc_ops zynqmp_efuse_ops = {
+	.read = zynqmp_nvmem_read,
+	.write = zynqmp_nvmem_write,
+};
+
+U_BOOT_DRIVER(zynqmp_efuse) = {
+	.name = "zynqmp_efuse",
+	.id = UCLASS_MISC,
+	.of_match = zynqmp_efuse_match,
+	.ops = &zynqmp_efuse_ops,
+};
-- 
2.30.2


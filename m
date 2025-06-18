Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78624C71157
	for <u-boot@archiver.kernel.org>; Wed, 18 Jun 2025 02:20:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69B6E82B18;
	Wed, 18 Jun 2025 04:20:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JK1K1m0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1C8782B20; Wed, 18 Jun 2025 04:19:59 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C0682B0F
 for <u-boot@lists.denx.de>; Wed, 18 Jun 2025 04:19:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3VLdnnzDeTBlu1bkhj4W0HilZRrmk8VcKUfF4PM8251F6kQkg/5JQ8rJ3b+SKGnvWhxfyRcKOF6fMUC40tEi875e73LyRWwN+uhajFX7OhO1OQRRtuqyLp5Ahk8tlZEVXt0oQc29xwKWYKOGXOBSAfoZOCqsH+DmjOkCpBPJ5vNR6QeatO0M1kdMOdW6SjdvPYMT1oIM7iRA+ozO3iSp2zYgNYoyu5+B13lgD2E8W8GrYZWNKDADm9KBUs98XBa7v6v8iKrhvtS/BNyVgT+AAQZRripxPnDfniTXnaySmnqONrHyRWlsnkA2y5X+OEu+DFbq2d64IwmEI0Z2ldMrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOGIesYU+EYOfzCoYBRQKo+anVV/hKawMj+CbgfN2I0=;
 b=ZTNYdsD6jAKM9Pfp1pbwEA5yOrIL+T0Sj9i9rev4Ve/S4LoyLHwpbBi0VShUJ3+jpl401AUryObOFG+748czr7K3DGR+JknEMW2ZbBx7sTuW0LK6iOK1YL1oRBJF3GLyjFa+sarekI5Kh12BwtzocGBHCKM1rVN2AMT6I5FqPjdKNMmRHccpp1uiA/kGAES6LG5OG43u8H47WtIHJ8Ckm1zl/+yCwPB4RYrEakbe+jGiFx4RxxpBPxuojzl0N/hXfmSmZpNPTDYVLQePNZh4ompKOqOQXopBs4dDSH9m98EsaUnzuvt4nq6c66wh7Aw55R/s0nKvZta13/kEhWsJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOGIesYU+EYOfzCoYBRQKo+anVV/hKawMj+CbgfN2I0=;
 b=JK1K1m0jq/4Ngbxgfu2ZcQxHxLMFPvLKA6zAF8yUBb5nBSOoCLFVC79MUVT37svmcMe/kxHe1TvfpG5qTfUkerSJ8H2rVyeEk2bT4KXIGoPkNEmjeTkU6K0bPvCmV28ah7OJNMHSjyhNfB4Du2luN39Ka0GQulrQH3uSHE1e14gpaPgkajOHU5oTAjPGS8a80pGsMFFwUZdXekRkztwCRNrXC74m8Z/1+aqUmSxEIaMX/pv1LyBH0w19z3tTvKwzrG5pg7x+xy/F2ap/mlM699KMzQduVggKfwWtlxVRk0WJi11QTxIeJBahz4hMun3fcO/8yV4v0v8mXEuYJB5Ylg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10882.eurprd04.prod.outlook.com (2603:10a6:800:27a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 02:19:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8835.032; Wed, 18 Jun 2025
 02:19:55 +0000
Date: Wed, 18 Jun 2025 11:26:42 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: sbabic@nabladev.com, festevam@gmail.com, trini@konsulko.com,
 u-boot@lists.denx.de, uboot-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] imx91: Drop OF_UPSTREAM
Message-ID: <20250618032642.GA3745@nxa18884-linux>
References: <20250612021356.4228-1-peng.fan@oss.nxp.com>
 <aEqPqrQZAg-4ryju@sumit-X1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEqPqrQZAg-4ryju@sumit-X1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI2PR04MB10882:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c095d89-29cc-40c8-6396-08ddae0e9dbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gBAytK4vLimdQZX08NylCfH9MfxAiDhUBYm4NeqRSq+RLmLvBHnmH2Dh1Svt?=
 =?us-ascii?Q?nZZXmnXAFDSqoRmjaoqpFvJH2VQf9OWtXUDlqiB/DWivbZaZwTnKeNxBOVMc?=
 =?us-ascii?Q?WSnuawBkzlSW5B1KWsH4+GfwpYA0omCen0bonOYyu7CKI9yp/LrU5BML+ndN?=
 =?us-ascii?Q?TpGFJ6YIQ3/aWlNkA3MlCGF3PyqxISiNoP5sM6v5QjrgGp29F2d+nsm/9nc9?=
 =?us-ascii?Q?Czt7xe0CjKXcxhK6n9q9LVOuloKeKEoGGik+xOWoefK4SvqWpjAhpbYSanly?=
 =?us-ascii?Q?kwOhBvoG37BYiBnakhbgpt+V8VE2F0/fIO/vBPgaWh5HDNeA4M/SdLEcGdMs?=
 =?us-ascii?Q?EqKj3ah3jJCF7EVl8Im71azcAaExDeXNenpVvfHbNLznLQ6ciZjZcNOdmrsi?=
 =?us-ascii?Q?LgzYdMEDMofX94Z0VzSQ2keBbNU8i28dWl+RAlatds0YKeQX09NlXmf1ii6D?=
 =?us-ascii?Q?NuxBwoYBrpQnEOZxPNTLYyqwA5YVliwQ0AzADyZeAY7F6HDfkE15ArQtmL5O?=
 =?us-ascii?Q?Mp6tN1vbvE74GkrvdPO5WR7p+J8E7G+psjBGTZONkx2YrMzuugM1F5mIYg4R?=
 =?us-ascii?Q?EASrZQcNfV9b3gOwFttLwnjbZRtovXraeDpufvLA9xGoXeiT2NWyy/TGPsKR?=
 =?us-ascii?Q?jVsegrhDsUIb7RZakyplxyGgycm8hBt16GSWSoAKpQijGTMK9a49RRcEiKss?=
 =?us-ascii?Q?wNUO2jLLa8mRsfa83Jnejg462tDJd2klQFmgj33BGNAslmaGdo1AZPmTTs1I?=
 =?us-ascii?Q?dw/5Dl3Bktc1Q3X4FG4JN3/UPVwdOYeC+GUtIVXtwxkgWvA9o91DcO9pgRN0?=
 =?us-ascii?Q?bnJ/h+xPv7Y0QY9CYcmI9ofURHIwGJZRpz54BEB3PlvpYSbSiQrrWHL0s+v8?=
 =?us-ascii?Q?bCztwI6DT89Iw281VNqf5mOrCE1k+63ki43BjjHKMHA6XR5QS46noegsXnbb?=
 =?us-ascii?Q?xpxV9z52CXc9DPuJZkQG9vyztdJP3Fi9yov2iQRPpuanbqvE6kMJMUlkVMTd?=
 =?us-ascii?Q?MyFTBdSfSMp4tX2t7EnupMNzGAv0NcU3wKTD8JyfsS32IsjC68tlHHHcwuX/?=
 =?us-ascii?Q?q+xM5LylMqu0BrRBGL9LYpczE7H5OOt6BsD018/gAXJTZUlGMpS6JdvrtzCa?=
 =?us-ascii?Q?0pICp6X0auH5RVlPDnAvg8LWu2aQSQFdk5limlSi8Pet7RynISDa+w0QIPXT?=
 =?us-ascii?Q?yUwsYMUrbrO3SxgZBcV6H/Ejja+1PyfJDryffJGETkh1MOUhpjUW4yw3HaHA?=
 =?us-ascii?Q?GVho/k6vjVuUuHwSVtwlK02tlIIdIiYGt7w917kN0RtAPaxPz5W9xLALoa7O?=
 =?us-ascii?Q?1JF5GbOrHmP0ZRRzi0Jnc3akGN6qDo6S8IKzJsnalIEp6E608Pa2yT1j3Hu3?=
 =?us-ascii?Q?rl1mB2Q9d0OepsZVI8ALK+e2A2at+QrqipJI87SElbrXB9f1VKS5Mfaz/tZl?=
 =?us-ascii?Q?w2jZ5Z6XeKEmg306ey+0MZuZQvvQgtSKwqqvZg6YM2Hi5U+ugccflg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?56t+GD61W9Rja+zrERxE0hZE9clrDub3lr67i6tW2EAkB1B/aIiZG2ucJhDX?=
 =?us-ascii?Q?kIOVNbG9DZzuNNrqJcARh5UDQgwqqsmw8k5IZ4w/FCPn5/NIuwQwHl6T/Ons?=
 =?us-ascii?Q?U+dky7YGKRpDkZa+6fLTqU4BYvYltFwVaQNEK7UYXJTaMPK6mEPeq2TVIPIs?=
 =?us-ascii?Q?xS3gn8UxsNZWCSrZZIY4VasI+uzcCEagBdHzS3izljf4UUYEn1NSCeZ6aHNs?=
 =?us-ascii?Q?LwHIUy6CVp2bjKPKvkNdsJK1Ge6vpoZ1jkOsAMctRsk+c0biz0RIM2WSKS+N?=
 =?us-ascii?Q?SO4W0rsq6QQ1ldCR1szRr9Z2bZAF6VYE4fCyc5jaOUuUdwzC/Hih6qrCQlYa?=
 =?us-ascii?Q?AotTbWkClOXudCAi41xf9HB7LjsHdcq8j/u1jwvGKcTu62diGH1W0U3uLHhG?=
 =?us-ascii?Q?0kMPlU3Q3vQnECBPLmmYvrz2pxkt9/IJuZrsKR6ghJZPlqrQ1gQhs33+lxo0?=
 =?us-ascii?Q?E5U5t0T2LhH4R36LAgLAvRV4fgblMLDKQpiHDHeLnLdk4TEMDDRPU6Bc5B0D?=
 =?us-ascii?Q?k7SQQ1NVB/dYULhBwUEVIIkUpFQRP0vUDFYPUepzmMYp0hf2AEqlZtQd9g2f?=
 =?us-ascii?Q?hundscJNOqfRTWlhI9okOCPujS3VGKKCORDM5UP0JLpfw14bNuotZpG58W4M?=
 =?us-ascii?Q?XP4w0QCTxag5PK/6NMhnuREvqDMb5wQA6CkpsDBWj3WwSvGvx2xXfH5jltJL?=
 =?us-ascii?Q?tvOHwJ5LkEUcjuSL+GmXJC7kZ+P1V5uLgdHa92S5yTEGFx1izUcSpZCTqbj0?=
 =?us-ascii?Q?/OA/6zJfdYHYypR2ozCsEN/oyeqsl5HwLBKQCa8teXfl0GLgHUNKZwRce6nl?=
 =?us-ascii?Q?YCuUoGb+la8YnUPH1wcSO2Q8Iae+iUTcs6T5GetX4RLgReqFmBoF3IyFOW5X?=
 =?us-ascii?Q?l9c1JIcTZbVLQlFEesg9JdBMviWK4tSmneLHLAMvR5Bd1meiHMYibm6bmSfL?=
 =?us-ascii?Q?TquB+YCZoetcQ/r7jjIAL6Z628o4aeODZgmzSfWQ4D9WPx0rxV0k7v4/Ks2+?=
 =?us-ascii?Q?CawxxaG2tt4LKXEvjW8YuMWn6V4o9r1rCD+VKLFdxckPFv023C3jHpnRMrlG?=
 =?us-ascii?Q?Ii3RXhDG7k2M137mpBi0M/yUGrESywzgXpO9wYZy4kXIMlGAzmo9LppRW+56?=
 =?us-ascii?Q?oCzOXMFLX/6WQa5GxTNSh5FnmcjN8lKJF4pvJQYdP+avdarqN3fsNswDjcGG?=
 =?us-ascii?Q?o5QdG/5rpdV2/mv9Gg4XKiDJCJxEwoLpJD2A8qPloCmfmtKbnrGiUm6zrk0r?=
 =?us-ascii?Q?wloXWzeDQZpocugtejY4keZdpW8HWBgMQ0uwU0UutnskEUsmp9Ex+doUf/++?=
 =?us-ascii?Q?vtl6pFX6gzoKUgm4QWK5RGWiHY+ls/uoke8TrY+nZcb6NgXcjoEJN7IwntvJ?=
 =?us-ascii?Q?wv9v/owobKrpg/VIfmLvER0IXvPEbldYyv1uVaUONCstSrn2WYRZe05muNhe?=
 =?us-ascii?Q?WU/sHMDWnixh/P6+UgoygMP+7DC7vez+cUJkosf7xWoJQcfGGG6U4LWw7+6f?=
 =?us-ascii?Q?6vYQtU4Bsgl0K9dUyN0cP7iIsdTRMRMcqvJqIwomNRXTVmoUqo0CowxNQEZM?=
 =?us-ascii?Q?MTKgeaK+KGXAhR2I64eXQLqZwz0UAw4J4avYjVzx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c095d89-29cc-40c8-6396-08ddae0e9dbf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 02:19:55.7923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF89RKEpqS2bUcWF8V17SsdokneDlm7e4AWZ5wk0poNPRL1utskVNhrSK1y9ZsJckcfn1bLpTsxgBRTqaPJ95w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10882
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

On Thu, Jun 12, 2025 at 01:58:26PM +0530, Sumit Garg wrote:
>Hi Peng,
>
>It seems in all your previous postings touching dts/upstream, you never
>CCed me which is the case in this one too. Please run
>scripts/get_maintainer.pl for your further postings.

My bad. Will do.

>
>On Thu, Jun 12, 2025 at 10:13:56AM +0800, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>> 
>> i.MX91 device tree still not landed in linux kernel, so drop OF_UPSTREAM
>> and move the device tree files to arch/arm/dts
>> 
>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
>> ---
>>  .../arm/dts}/imx91-11x11-evk.dts                |  0
>>  .../freescale => arch/arm/dts}/imx91-pinfunc.h  |  0
>>  .../arm64/freescale => arch/arm/dts}/imx91.dtsi | 17 -----------------
>
>It is really unfortunate that this DT landed in dts/upstream without
>anything in upstream kernel. Direct patching of dts/upstream is not
>allowed but you should only be able to do cherry picking as described
>here [1].

I see, will follow the rule.

Thanks,
Peng

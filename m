Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F3BE87826
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 13:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04BF18410C;
	Tue,  3 Feb 2026 14:04:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="uukMo4c2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D582B8410B; Tue,  3 Feb 2026 14:04:25 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01FB683FF8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 14:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uXL+Lb+NzejoqxASlMUNTm+FE76jPOZzw1C6xUCMkHr4uZ/CdGW3sz/o47/MtatBK1FaBNvmXwqXMWnk93xbvmBkd5fdU4FgHhqOOeiswk/3xsTPbjMnz8bIWVcgt+DmnTr7h4o+0be5NXnhjK9AHDCc7OlDEAbnbVYrIeBUS4qNywba6KgmPqhAzApvP76UrmbzXnE/PQKypv3HNp75n//L8rZ0eRi2aMoo/v4z7+v8NrzwS6/GhFeP5VBHxzslNvDq02DJn9WNl/vqHWTmEi9gJFCpXJxVHuI/WVW3+Q/2mkxEc/2ifhxSzvRau81iCB3QQ7/l6sUBwT7cCLA+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LKpoIaO/ebo7ltwz9HyfBlp+7lXX6T4oOuYVvVc3nM=;
 b=d0gddlIoQNnVlokrDFpJkqtYFbpS+ViwwtRk63QC27G1KnyDJxzfbaSon3IZac9VayxGfpH58L3mZgPcvbZzw2Mkflo1tLcWNRgDcfC9HM8Z67L/hqkEIpbg8H54wsJktCVA5hfv0c8HgoZM7FesTf5eq4WggO+cAspV8smP19TuohpKCS228E9DxX9I6rDcKJtFfNK9tthGdoUYEv/b4K4vwBtF39Ynbj1Q4DKVrVZb41G6PNUir5pTY459mN+io1e72HlUsfFr1OfP+hNWFDW/2H+Xy2OCCQJVybTneZUtfcFnpjxdVvCf2O8G+vFow/D7mc5NKx4rfwOyFID+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LKpoIaO/ebo7ltwz9HyfBlp+7lXX6T4oOuYVvVc3nM=;
 b=uukMo4c2P3JuPczih0q91LDJB7aDsG2BAtFVWg+IohbOIWrOID7MMoLcXqZ3raStHkc6haDta4o0J+G/ieRO6Xf9AhCsZ21VTgoW6MRPlOWPRtYfU4MzG1f6tynx0hw9DQNhusMgFxu4G6pear9JffsSRuXl4v/gqaxhmzclwRKtsjX2WoP14QtueYgxyVnHMwTSbvJquUiB7ABR0RjiRPIe1UtvqN31sMO0HhnsNpoAPeRebAHB/QwQ1+ezvrFdzY6cN55L8qUQSVf/P+dU0BVLedUJ2eTZg56EgA6lJCUXyD/frZHKNduuovAZyNkflRfA33rNAT0IkNpAGYt87A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8813.eurprd04.prod.outlook.com (2603:10a6:102:20c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 13:04:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9564.006; Tue, 3 Feb 2026
 13:04:22 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jerome Forissier <jerome@forissier.org>, Yao Zi <me@ziyao.cc>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] Code improvements and argument checks for mmc dev
 subcommand
Date: Tue,  3 Feb 2026 22:18:57 +0800
Message-ID: <177012816735.3125891.1039991716404402082.b4-ty@nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260130180353.42205-1-me@ziyao.cc>
References: <20260130180353.42205-1-me@ziyao.cc>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 5370c6a4-e866-4422-3434-08de6324bfaf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|19092799006|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UzR4TTJrd1ZUWTZEQnZTeTNlYkN3WlNtc05CV2k4YzFtNEJiOFpZNlRPQTRJ?=
 =?utf-8?B?SGhuOUZuZlM2UG5TRFpXRjBIaldNaWNKb2cxMzludHBWVWQycGx6V1Y5RGVC?=
 =?utf-8?B?YTB0Rko4b2dSVTh5djd0MUlOdkZKY3FBbkZCSGxjMGpoZE1tSzFuL3oyMnVP?=
 =?utf-8?B?VkltQlhRWUxsbFdXUkp5MGQ0Y1ptVXFybm0zeXJwSVJ1ZE0wUlRaZTVzUCtT?=
 =?utf-8?B?ckJXK0xhai9nSC9RWXNFT2pFdGp1dHYxak1jOStsVlJaeFE0SFdZc1NYUmV2?=
 =?utf-8?B?NVVycGQ3TFhzYnc3ditLS3lnODJ2eDQvWUk4c0V5YisxbS9vT1EwbENuTzRx?=
 =?utf-8?B?VHc0cXd3RkdSdm9nYStjY2Nqc2dtaDdoc3BvVGdjQzdETUFpUmpIZkVyQkZz?=
 =?utf-8?B?MFg5RHFtaFcrVm5tcGlLMGFMYUZ3WkF3S2ZBN3V1R0Zpc3FLNUVPdzlDYmNt?=
 =?utf-8?B?QzcrbWRvNktJV3ZyeHFueSszQVlYeGJoY1RXZ0t6TWRWR0dYNjhHc25TS2pF?=
 =?utf-8?B?MnFiRWhIT2pkeWh3UHZRZWN2WnJTNFk1MWpjOTlOOVF3TTZYcENNWWwwbU1M?=
 =?utf-8?B?VFZvWEorKzk1VURXUUN2bGt3UDVheVFMenQvcmZpZWdKN2dtY1lMQW5HMkR2?=
 =?utf-8?B?c3l0eWduTFBzRlRTQ0REWDFITmE5WFhPZVMrQzVzaXVQb3Y2Y3Rhcit6VitV?=
 =?utf-8?B?MFhnNzExOXkreG4xdlBWcDdKWDJGazdTemw3UkgxUzlLeHI3S3BZRDhHOUsx?=
 =?utf-8?B?VjZWcGY2L1FWQjlsVFM2ZVVjSjNpb2taenIybjF3SU9hSi9CQ0piZWVxc3N3?=
 =?utf-8?B?RTJncktPS0RXdHlSR25VV2JDNkhCSFpQQ2IwUElmaWxIZS9MRFRUdTZXSElF?=
 =?utf-8?B?WDJINE4wWllmaVIzeDJFTlhvU21uRjVVaURpOEdTem5ZQWFtTzNMZ2o3SGFO?=
 =?utf-8?B?a2VYQUxON2RuUk1XRWNYQ2wzcGZXRG9LQ3JzRERrY3UrNGVlV3Baa1hiWFRj?=
 =?utf-8?B?SmV2ZUlTUU52RzB3bUxvbVRla2N0TTJEQ2RYS21yU3JUby9BT1IvTEMwV1pU?=
 =?utf-8?B?RnVFMHRwTCtWbGhOK2lBTkJqU0tETll0dVdYZHlwelBrUWVqRG5vNWJzWDFa?=
 =?utf-8?B?L214Y3dTM1BaR2JXN0tObVBDQlVOT05zWHNuc1hCb0hkVGxEL3RkcWZ5Vi9u?=
 =?utf-8?B?RnIyaTA5NkpUbzJES25raGRaY1dMelA1REVjdWdtcFcrVktvWGluVEFQeDN5?=
 =?utf-8?B?cVltdWRMTzJHWGVYTm5jY2JGbDh5S0o1ZW1NZGtNdEZrOVZDR0s3WTFqaGJE?=
 =?utf-8?B?TU1zVEtSanhMa0YyY2dCQUc3K205MU1BajQyYjZqa2JHbGg4dmttcXR5R044?=
 =?utf-8?B?MDVmQjNSVkxaRUtKdnQvVDNydm11MUt5Y2pKbkJoNVNIblRqYnNnSE8rV1d5?=
 =?utf-8?B?akN2cDJxUFVrSkF1cTZRSkppWjdYTGVSMzVlN0paR2dNazQ2TFd3Nkx0eFFO?=
 =?utf-8?B?aDVoc3RXQUlmK3JqRnhmWHBpRUE1bnh2WUNaai83Q1VJVktsYXQ3MWFhVDZP?=
 =?utf-8?B?a3FCeXh3d1RjdVFVRmduZGJ4L2Z4b2YxeVpDSTF3MFJDT3EyTE9venZpKzYy?=
 =?utf-8?B?TVlGbDZueHVzdGpEdXZLcnVoRmRaRTlFZHJiZmpNWGFsalUrRE9rUjZYcWtq?=
 =?utf-8?B?dXdKNW8yc1RrUkZMN0oxUGY4TjJmZzVLRm8rSitYdkZ3UmlLRnB5RDQzbHRP?=
 =?utf-8?B?MjNJVHp1RWVUSVQvc3RNK3k3bEhuUDNaaENxa0NKNkJETER1dTlBLzl5L0M4?=
 =?utf-8?B?MldPRzFVNW1qWVY4d1FNVXlsR1kwNkhhWk9GRXp1OXNOZHI0WmladHFpZzF2?=
 =?utf-8?B?UjE5MFFiczJnNkVLTE95MkZOazBsczhDTE93NForZWRxYktwOVljd3FwWUl0?=
 =?utf-8?B?SWRDaEp3YkVhdkwxcUk2RzBQcjZhQlhMWXBiTXlCcHlIcUpkRHFHUzdnZWg1?=
 =?utf-8?B?akRWc3BXaGhxOXNKaWhCNEdBZzdwaEhWUUlrUFlyRUZ0ZTVMRUxoc1NZUmJo?=
 =?utf-8?B?d3ZqM3JzMTJFYkdtSVRPd1F5Z2Q5N1E0SDZBYWZLZXgzMmZpKzFEYU5ZRWth?=
 =?utf-8?B?bkZ3QWI0ZFhNY1h6YVdTRUhoREtNZUQxZFZ1OUs0eXMyaS82WERTVWhQd0lH?=
 =?utf-8?Q?+vrtsf6k1sy4ENdi+Au/3SY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXF0eVN6R2JndHZqV0MxOUhOamtVVEx3aEdEK3VVa2lIMmlxNUVGYUxPaW1w?=
 =?utf-8?B?MTZPK2NzY1ZtckZMU3liSmpwaWpQSE5VRlNNUVorNnZTelljVUFjVUY3QXU0?=
 =?utf-8?B?SEwwTzlFem9OY1FVODBvME1BaUxUd205dG1Cb1lDOTdiSVdzNVZLQTRaQVND?=
 =?utf-8?B?Uk1GU3FQaDFEQXBGQnA1b1Ztc1g1WHh0MVIvMCs3QUpWWTZYZEYyRUpkelNa?=
 =?utf-8?B?MU50VE9QSkZnallIL1Z3VnRkdmxYbFdYaW8xaTVYSU96RjZYY2VCT3dFWDhN?=
 =?utf-8?B?Y1pHWEdvM21vUlBKUGZzOTBNcVM5SlFCVm9rSFdIT0hlQWdqalZ3Q1k5M3ZW?=
 =?utf-8?B?cVBIblIrVFhZRG14eTZadlJaUFZac09JS1ZIVU81Y0d1TU9NSVg4MGhlaDNI?=
 =?utf-8?B?SWNSK3RJaE9xdjl5RWtZLzFqbG5sY25Qa1hsOFArbU0vcUVWRWhpVzllcmJu?=
 =?utf-8?B?Q2l1SE54eUJ6SXNXL0lXbFM0dGVGNEQzWDg3WTh0YlJROHZ2VkZqbnZQc2hS?=
 =?utf-8?B?eGxkN29aMk1zN2xyZFdybUFOUGp0MlppaFlNeHM4a1kxNnVGK09mL1o4VU1S?=
 =?utf-8?B?eXprVkxsRkV6Z2FpNGF6dWllbjBsdHlBY0c0VjJQTkJaTUlmVHhtTm5vNW1u?=
 =?utf-8?B?SUZidDBpUXJpV0NCd0Rxa21tc2F0YmhzYjBKaVI1aWs0VDAwSFVKRzl1cnVo?=
 =?utf-8?B?MDRQUVdjejNXR0gxcUQrY0ZGK2E4WUxXU1hLVTdjZkdQTDJrNTI2N1k2ZWQy?=
 =?utf-8?B?SGg5S0UzSnNJaHJaRDkrOTVJTFltYUVsQXY1VDYrKytTSmkzVi9MSDhtRjhs?=
 =?utf-8?B?MmdmenZWakJpZ0JRMDUyUElzK2lYNWFtWkxLakMwRFd2eERFSHM0OE1qbkRJ?=
 =?utf-8?B?NjNqMFduV054YU94ZGZoS25YYStlcDJZTUhQeVVSMEdmaGhhSkpZalNxZjVh?=
 =?utf-8?B?ZUxTdWt4RGRHYTBGTXBjREJXTWE0ajZoNXlta0x6dU1GektFeDVhdUNPUFds?=
 =?utf-8?B?cm1GSkRDZDBwZE85TFA2VlgvYmRLVG5QWm1seWxmVVAvL2VNU00wdnYvemNU?=
 =?utf-8?B?akMzdHVVSVhOVmZzbHI1WElvU2cxZ2JZN1VtckxuRHowQmd6VEZxWmhScitG?=
 =?utf-8?B?SE9FbXVteDNLamhkRTdKempDeHBubkQ2UkJRK2JRbjZXQnhnY09ETzM1MVhs?=
 =?utf-8?B?MS9GazRXTVNFV1kwYW9XTVpmb1JsVDk3MFZWeXd5NGE4U2UwS2VDUGxiWEFS?=
 =?utf-8?B?anBaRVRmNzYydDhsTlNXODZ0WHRCeVBaZ2pkOG9DM2x2bFZ2L25weDhqWGht?=
 =?utf-8?B?WDg1U285UDJEajJQZ00zaGxMSWxFMy83SWJUa3FSSldoZVNyTjB1b2k2ejZQ?=
 =?utf-8?B?dGFhOUtqcE90di9XTWp4NTQ2MHNIVk55YWVXUk9OcFkxSnpHZ3ZNS2JodHRk?=
 =?utf-8?B?VVdyZEdCeWhPelp4K1ZIY21ZU0QvZUxWS29yd3BZbkxubGUxalFWVG5VNlVW?=
 =?utf-8?B?cU1mam5ETmxRSXlJZEQwOHZDKzJjVGpEVXRJNnViTUk0bjIzVFAwSnU4V3R6?=
 =?utf-8?B?aWI0QUovZko0WnkyQTVPRzYvc2NjMnVVRjlhS3VnSndFTUNHYTFKZ3J1SDVs?=
 =?utf-8?B?elM5MkF6M2llc1V4aHEzWWI3ZDNPVkgxcFhyb1dDeEVDRmpEZ2dqWnB2QzNi?=
 =?utf-8?B?Tnlqa3JQQ0JmdTJ0TlBIVVJEek1WVmdLMUs1TVVDcUhBd2FLWWM0MXhUdHV3?=
 =?utf-8?B?S211ajNlcldDOGV6RUNSU0tENXVIa0pNUm9zd2xjaHhsY1l3RWhPTk5LZk5K?=
 =?utf-8?B?aFRQNHRJSkpIRmxkOVphUWZXdGpyUFZmcSttS0RVTVdyUDZacVdGU2srSFdo?=
 =?utf-8?B?MXJOVWNtSm01Wit4MXJDUEdvZ0dTcldRRDJyZ0V1Rkk2M1doemNrTDFndCtJ?=
 =?utf-8?B?VlFVdUczTDdCQk1MS2lqKzBEZFJhanowdlM1ZzBReTB2U2FXRW5sV3o2YjRH?=
 =?utf-8?B?U1lDckwrcVUzcFFXUjJSL3E3cUNGd3c0TEtNVXNEcmhPQzNPdE54TmxEWU1F?=
 =?utf-8?B?QXpicEd3K29xaWdRUngwSjlSMWVlL0IyVzByY2xhWkJrSE9JSHpFaC9JTkhO?=
 =?utf-8?B?T1ZSTllGRWFUZXlycWpGQmFqVTVMZk84THI4VlFEenpIemhrN09RcnlXazVo?=
 =?utf-8?B?Rk5MdXRWRnM2RmFiYnprMmxKZUthaTlGd0g0UmdubzZYbFRScXRJRFdHTHF3?=
 =?utf-8?B?eVRycUFzQlFUY205TnZDbktNRW16Rmg4Sm5wcStOeTlOTDkvc3NaS0FseVF5?=
 =?utf-8?B?L2JLVWovTFMzOUlEd0pDd29FYnFVeU1vcExqT0NUbzdLUEtIaHQ5dz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5370c6a4-e866-4422-3434-08de6324bfaf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 13:04:22.2202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAObSxaFs0lD4g2Eswe+dhlkm7Q27DyrLu3MtS+/yVQdZ4JEZbSMnZ6Wf/9yrEHDtgBCKBvreaHKafBsXcnDBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8813
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


On Fri, 30 Jan 2026 18:03:50 +0000, Yao Zi wrote:
> This series reduces code duplication by utilizing fallthrough, then adds
> extra checks for arguments of mmc dev to ensure they're valid numbers,
> preventing unexpected behavior.
> 
> The last patch replaces an integer literal returned in do_mmc_dev() by
> its corresponding symbolic constant, CMD_RET_FAILURE to improve
> readability, no function change is involved.
> 
> [...]

Applied to mmc for 2026.04-rc2, thanks!

[1/3] cmd: mmc: Simplify dev subcommand handling
      commit: 97cc26f6b6a85312305e5b953ef44861891936bf
[2/3] cmd: mmc: Check whether arguments are valid numbers in dev subcommand
      commit: f955e00e42e9b7ef5a3adf1ba1947f46c05a3d36
[3/3] cmd: mmc: Return symbolic value when part switching fails in mmc dev
      commit: b4f0479e076014f403319fdce53c5c1ac278f8ae

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

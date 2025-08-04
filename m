Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6E9C87FCA
	for <u-boot@archiver.kernel.org>; Mon,  4 Aug 2025 01:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A37E83E92;
	Mon,  4 Aug 2025 03:25:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="X+8XdOTs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF05183E46; Mon,  4 Aug 2025 03:25:31 +0200 (CEST)
Received: from CY4PR02CU008.outbound.protection.outlook.com
 (mail-westcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5090983E19
 for <u-boot@lists.denx.de>; Mon,  4 Aug 2025 03:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SE383LYKiwetDi/gElc/37C+P6a+4+3RwOkdUy1dpOcYN7mxHCf2aRtlmmokBPGbuh973rqWGimmjmOopKl+k/XyVtbIVrZ+HViPPiEVjTlcXWjt0A/WnhpMfKIIBf++7vpt14UuLIRJtTXnzZxUTslTM9RYOtvTdVBGv2LjIVMXqSHpoFbL3RjVFP/BwyXGt4AOjHYLhzX04l+xcUMH9xLtCtD0ryQ1clc2jIMH3xRNHt3TxufNO1hsaoxNc34/ezZk9C9PCFwiNCmxWorCJFYvfJKm/ZtgHw4DGXGlSLoQZ9EcfrbAd4hX7qXeCuIki8P3DyaXNnZEaPYv0Qp4SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKEVwovd3jqkyLSzKZ0rcM18yYTZkcLfA/w7vRa2WOk=;
 b=vk2qz53OftrzgZnMpWCbS+JTpdhkzbpdXgleG3WU6WJlh0VLY3HHsGSNslw17oBqmAF7InanmP31jJmwmID2/U0OWBBkS83KcF6QUG1ad/ySZGdkRxxz6SXhjvA24NKEvvIybqIB4D744dm1oPw7cRxHJJr+4xSAonpLi7liYBl2VVUP4SAe0tUPlbeSuFjcWPjbu7O6HBDViZqh0q/3+TP/QlJoKdZIHfW8nM1RF/Byeof/2zqFUS5QXKv+IStn9Lk2QKifSp/WVF9psjR7S1HicHS8SmRxyiAJCCmxrTcoyHij97D9kser1hNgSdJMffCrETiH1ug1A3SRTbLGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKEVwovd3jqkyLSzKZ0rcM18yYTZkcLfA/w7vRa2WOk=;
 b=X+8XdOTsSqwZsDnw56v2HD87pyQNGxNoqWaSO76jqxFB3LgQ++3TGYZNV/g6C/TFW6Jz80PKqsZwEXzHZkBF1mO99/MGsTyyVxZJ2DvVhq1RxVAGDXT2GqQIrtQYNnev+eMQBHjRv99F6b9deYQLbrM0n2jDOU+aMQOIdqZfx5HYljDqU5V2ZkTyg6u3gHT/oToIHOowZufvaj3OJWF54nTU3fGvHwNDw0Vxsyuc+BDUFRUCaAMZf5DB42zN31zd1q/33xPTPfOwTAornIsyzidbxAmvLWOzSIFn37OaKD8D0U42msnUa0SPMisQ5Y7v83WHo1i1iDglI76br6bOgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA6PR03MB7973.namprd03.prod.outlook.com (2603:10b6:806:42c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Mon, 4 Aug
 2025 01:25:27 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::d020:3494:f031:fc29%3]) with mapi id 15.20.8989.018; Mon, 4 Aug 2025
 01:25:27 +0000
From: alif.zakuan.yuslaimi@altera.com
To: u-boot@lists.denx.de
Cc: Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Naresh Kumar Ravulapalli <naresh.kumar.ravulapalli@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [PATCH v1 18/34] arm: socfpga: soc64: Perform warm reset after L2
 reset in SPL
Date: Sun,  3 Aug 2025 18:24:45 -0700
Message-Id: <20250804012501.21811-19-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
References: <20250804012501.21811-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR20CA0035.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::48) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA6PR03MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 92195c54-9c8f-4fae-5235-08ddd2f5cac9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDBPajVHckVxRjEra2VPRnhyWklGd2tDUm5BN05mRk1MUWFtV01CakJBc3Y0?=
 =?utf-8?B?NEVIcjNYZGFZS204VUpjN2NmWSsxaTFqZE9SZ01tWUEwS1dmUUhySTJPMDJB?=
 =?utf-8?B?RzMweHIza29wWURNUHZWVmxzWXR5L0sySWVmb1B5amxFYmQxK2s5Yk5EWmZJ?=
 =?utf-8?B?ZHN0K3VWTWMzblBFcVE0SFZzUnV6VHY4QVhHdk5iYzdRTlFKaGk1UzlISWRJ?=
 =?utf-8?B?eTJJNEk1dXpabUdHU1ZNWXV5WXdMNUNnMjRyYnBvcUFrKy9YcitVdk5sUm11?=
 =?utf-8?B?MkpGeWwyMUVQSnVwZGpuemJxWVBHS0p4U2dOSW42c3o4MVFBK2FKYk1TaWtB?=
 =?utf-8?B?RXRUMTNOS0xxQUJXTWlLbkFCdUtnOXhuTUwzMUtwc3VKU2hVK2RHUVZJdkVS?=
 =?utf-8?B?SXAycXI5R3FsdjY1T2JNQTBCZExCNU5nWDFFM08zYWVqcFlrT1k4bTRJQXJB?=
 =?utf-8?B?SllWa3RZZ3g3VDFsRVNra1pWSFBHUUhnYUU4VVlya3hWNXovNDRZajRia1Np?=
 =?utf-8?B?TURVdHp2QWpVZ2VVY1p3TlFVUlVUU1hGRFJXbFM3WnFUaDZTZ3lRT0NldmU2?=
 =?utf-8?B?ekN2OERqVWFtSjQ2SSsvWGlOSVVzdnV2YlNGdWJ5Z1JxSHhqb0ljeVNDM25D?=
 =?utf-8?B?UVJWcUVxazVud1FMOXhtbDdFTS8xSUFwbmMyanhScHdEYWdoc1lITDdkZXpX?=
 =?utf-8?B?bGhMMTJqLzFrVk1rUFB1YWZaL2xHbXZMUElDZ0hiRTA2N0RTZmt1elJwUTRv?=
 =?utf-8?B?Qy9yMDhnMlpKdUxhOHlQK3laRkV1UUx6UDlqdzUwVzVpMTJ4c3pLOEpOMFlY?=
 =?utf-8?B?TmM0dVRxTlJjS0N5WlZmK0xpUU9XWDhwYTRpUnJaTDJrNzFZY3F5RFR3a255?=
 =?utf-8?B?U3dCTFd6SmFCL3RaM1dyWmNDeDdrSDN1TUViUFdzUVpPTEhEWnlHcVJlV21W?=
 =?utf-8?B?VnVvaWM3bGFoZCtxSVI0TFRJWDhvbVd6LzMrRHhlMTZLbW5aajlYeEc3TmZn?=
 =?utf-8?B?UE5hQk9ZOTFzYTk1QjJEUnpuV2hNYXFrdnEwTUdIcXBWVnJyYWpBL3duQWFq?=
 =?utf-8?B?UnFVZW1SUEQ2Z0dQQmJrSUlzaHNMOW15MHRiN1N4cWlSZWM4YndKVjZ3M2Zh?=
 =?utf-8?B?dUMzb3B1aDBjckN1QzlpbDZVRzRBN1pXcDB4VUhKcEd4aHRWb3NiZEpvK1Fu?=
 =?utf-8?B?bGFHQTVjOTZxYi9FaVRuREFQMERkL3pqZkxmL3Zrb1laNFpVcTBYeW5lL0V6?=
 =?utf-8?B?dFNTU3hvYmkydVJMV1F3QkZqQ1ViUVR2amxMS1JYZ2ZUSlF3RC9VSDZmRmow?=
 =?utf-8?B?eFh5bmFTWXN3MDNKb3h2QVVVMCs5NUloSUhiUU94YkhVZmlRNXNTMUJzUWs5?=
 =?utf-8?B?Y1VTYXJhayt0eitpaFBWSmlNMm0vUi9Pa1paeTFvR1VBTlcxNDBqQXBqYy9F?=
 =?utf-8?B?ZWs3SG0wd2tyQ0FnL3BneWhzVnp5bTdPQU9ZRHNnV3hXWlgyalVsam5SNE9N?=
 =?utf-8?B?eFB3eVJDZzJDRkIwejBoT1M5WG44QzY5Vkx0cWQwT0w1ZURnS2RwUU9SSHRp?=
 =?utf-8?B?dVV5UHJBMEVqRFROOGZCdVlOajJDYUkrWi81S3hQbkVUT05waVlXV2MvSGdX?=
 =?utf-8?B?ZXNEZWt0bzJvNWd3d1lVV0FsRmFyUmVDWTcxZHV1M0JoUmkvRFJ3eTd6cm52?=
 =?utf-8?B?MzhKdlRwSDhzQzBEcVluZnMvRitvZXNrV1lLSk12Rkk3Mm5oMEtDenBXRSs5?=
 =?utf-8?B?c1RIanN3b2g0ZWhlQTAvU3RjSWVsMFJPd0owZlJBTWdTWWNGY24wZ1NwSG9h?=
 =?utf-8?B?Q3MxcDQ5cmRpZzRPakN6ZUJEZHRPQUlvV3VOdUtjQWRPWjJMSC9WNm92ckpF?=
 =?utf-8?B?cGNScWc0cG5UeWdNWlV2YU5XS1RRcHI5amcxTU9ZQWttTEtjNEJZZE1XSVIr?=
 =?utf-8?Q?ydpP+TQ5yxU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmlpQWh4Sk1UUllFaGNpWkdiZE1mQnBZbVVEL3o0VjhuMzYzV1lyUjNtTmNy?=
 =?utf-8?B?SXBuV0VpL3dOWVhhYitDdURQNHAzYzMwa1BTbGw1b05GMmx5Ym43Lzd1VG5I?=
 =?utf-8?B?T1RrL0dBUkQxaDVUL1JxOXFPdnlLaGd0UzJVNEZwWXltOUQvVDhINTBCU1JM?=
 =?utf-8?B?dFBkSy9oaVJTaDRDZkMzdDJkMGpUUFpCRmR4MUlVdlNmNTBFQnM3dW5GNnd2?=
 =?utf-8?B?TnJrV0ZNQlI1VmM2KzlVWHJxeDJIc3Z2NzZIb0ZMR2ZUMW9lVG9ZK3hjWEk4?=
 =?utf-8?B?disxUmQyOXVZRWNSVThpVTd6c3hGMHZrVFJZbzJJRmxVT0FDQTF1Y0grMmVZ?=
 =?utf-8?B?RVltdWl2ZnpLRWx5NWIwdlVCWldITjdnVHlZbXhuLzFJWWJUMGhtZmhNbXJj?=
 =?utf-8?B?RUR0SmUvYXNCVjJORUF5ei9TeWRMT2dOQlFILzE5cURpQ3ZQbDFBN1R0N3Fy?=
 =?utf-8?B?QkhzenRhd3ZoVnlyYXlHTGJhM01ORGZoTXgvQTg2aFNrWjZJVi8vVHlDMGRt?=
 =?utf-8?B?NTlueGEwV0c1U3VmaUN4R2t4SVB5ejFsUGpKaTRPNXlpSWRrbUJTK3JaR0N6?=
 =?utf-8?B?ckl4dElaY1Nydldtd2VDaFA1OWJkMVNBR3Z1b1RRMSs3akxQckFjRFF6RERw?=
 =?utf-8?B?TjFhSlZQbDlvOWJncHRENTlaN0FBNEpZU0Y2NmVuYWM5Qm5TdW9VTDIrWTVm?=
 =?utf-8?B?MWltNWdSdnNPRDB4b3RtWUNnYkozUUprWGNNR0RVZkJVckd0NVhvM1VkQ0t3?=
 =?utf-8?B?ZmlHTElMWGZwVVE1ejBLWkRZRXNIeXN0cGlZMHBZVlpTVUZNVHI1cXlySVFo?=
 =?utf-8?B?ZG4yeHVtazAyOVlpRkhkUzBjOFRCTEViSWt2SjVXTXRWV3JQM3hkVVpraEQ1?=
 =?utf-8?B?eDhrN0VWZStXb3JCenlBYkxhVUg3cWVqSzZSWjl3N0Z4dUVjZnBHYjNxNzND?=
 =?utf-8?B?MTVqajV1bVZmWHRiQVh0bVFpVTlXOFE1bWdIRXZ6bm9Ea1BGQVpSRTB2RDNT?=
 =?utf-8?B?T3ZOT2ZyMGt6UTNBYWpKRnZRbHNtaGt4ckNTWU5ZV3VBTXk3bDVUSE9GRTJK?=
 =?utf-8?B?WVkyYk5pWUdkcGRkd1hLTGlNd2YrVjFvcnhKOXN5TGJyNmlWd2gyY1J2OWxC?=
 =?utf-8?B?VlpQR3RUZGk1Q2VCTVBScjRKaERiWXpkRU9VVWpwdEZjZXVPSnVwdzE2M3R6?=
 =?utf-8?B?UDRYVUF4M0twTzFQY0JmUzdFemZEZVYrWW1GU1pqR2NoS0tnWDFyM2JTV0gz?=
 =?utf-8?B?dmNhaUJoVGcyb2xJQitqZmFLckZzWlNQa1ArQWM2REVTQmo1K3FETlcwR3dL?=
 =?utf-8?B?Q2JHNDdkamNSRWxCL1IvUy9hZ3dJRnlVY1BjZGdqU2Nqdm1aTXlVWTFrVWRG?=
 =?utf-8?B?dmxwYnFxYlNwRjczVWRuMURadzFaWlFvMHV0WWNkOGZTczBiM3krUVpGQVdj?=
 =?utf-8?B?T1FpLzVHSjM0ZkZIUWkrOXhQTEUzVHNYd1haYjZCZFlGQUJFYnRVQmRIcmM0?=
 =?utf-8?B?T2d2ajl6U2M5T09oQU1nd3NLU3NLUEx1WkZLWUkrSmd2TTZkcmJoU0k0ZjdW?=
 =?utf-8?B?cWlvTC9zbUJKblZhS1lEeVpZcVgxKzN3djUrR0szUGw2TDhMMXNNek56N1Y1?=
 =?utf-8?B?VmV2ZVFYaERiUkF3UU9GSHNmUFFRVk52dkVwZ2xHT3J1Vm9GNUJpNjhRRXVl?=
 =?utf-8?B?UkwzRTI4dGgrbUs2TVRTRTVBV2ZHY0k1MWJhSzQ4a3hmMW1IOFpOSnVRTWZF?=
 =?utf-8?B?VWZDZFF3T3VQdDdFMU1sanNNTjUrME41VlVUZTlUQ3BXekU3WFUzRTByMkNi?=
 =?utf-8?B?M09hWHRGNHhxSUorMTNhd1djQTVVbXRIMHVBWkUvUmNlamFENHFUa2dlNGZW?=
 =?utf-8?B?UGEzNGlmQTN5b1poU2JaOFRUWmN2T1pwL2pkVEt1UFdwZEhzMUZJdEFXUThu?=
 =?utf-8?B?S0tCQ2NaV1poL1Q5OWw4R1E5Z2RVcmN2Snp1eVI0LzZjRElDZ0N4V1NqYklP?=
 =?utf-8?B?K2tKMU5oYVkyWGpaaVJrRHVjVWRVVjRIR1MxdWFlSnBidTNxRE1Idjl3OUZY?=
 =?utf-8?B?TmdLcmhIVC80YWRSb1UvMCtKeTdSY1F1cVlBdjF3RWlzZ0dEZEozczZpTngy?=
 =?utf-8?B?aHBEOUFQcFI2RU1wNVN3WXlBN2RyMjVWa0t3cGoyK1lodkYzemNFcE1VUXJR?=
 =?utf-8?Q?VXJ2Fs5GOpZ2cKTxW4LEJvI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92195c54-9c8f-4fae-5235-08ddd2f5cac9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 01:25:27.0873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxO/0CxF2QtMEYLJYPLuKPgmAczIcVgMhu9AfieqqJsqUNm/RN2abRPXTiTcac81NhdbxZdxf1ScTXGHa38iIEQVVQdGb8t2xQTUvtZcPpc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7973
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

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

SPL checks for a magic word in the system manager's scratch
register to determine if an L2 reset has occurred. If detected,
SPL places all slave CPUs (CPU1–3) into WFI mode. The master
CPU (CPU0) then initiates a warm reset by writing to the RMR_EL3
system register and also enters WFI mode.

This warm reset flow is handled entirely within the HPS. The
function `socfpga_sysreset_request()` triggers the warm
reset, and upon SPL re-entry, the updated `lowlevel_init_soc64.S`
handles the necessary initialization.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 .../include/mach/system_manager_soc64.h       |  2 +
 arch/arm/mach-socfpga/lowlevel_init_soc64.S   | 95 +++++++++++++++++++
 include/configs/socfpga_soc64_common.h        |  5 +
 3 files changed, 102 insertions(+)

diff --git a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
index 0871cf949e5..713fa2c517b 100644
--- a/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
+++ b/arch/arm/mach-socfpga/include/mach/system_manager_soc64.h
@@ -148,6 +148,8 @@ void populate_sysmgr_pinmux(void);
  * Bit[30] reserved for FSBL to update the DDR init progress
  * 1 - means in progress, 0 - haven't started / DDR is up running.
  *
+ * Bit[19] store ATF CPU0 ON OFF value.
+ *
  * Bit[18] reserved for SDM to configure ACF
  * Bit[17:1] - Setting by Linux EDAC.
  * Bit[1](ECC_OCRAM), Bit[16](ECC_DDR0), Bit[17](ECC_DDR1)
diff --git a/arch/arm/mach-socfpga/lowlevel_init_soc64.S b/arch/arm/mach-socfpga/lowlevel_init_soc64.S
index 8926c2d1d9c..b39565f591d 100644
--- a/arch/arm/mach-socfpga/lowlevel_init_soc64.S
+++ b/arch/arm/mach-socfpga/lowlevel_init_soc64.S
@@ -12,15 +12,110 @@
 ENTRY(lowlevel_init)
 	mov	x29, lr			/* Save LR */
 
+#ifdef CONFIG_XPL_BUILD
+	/* Check for L2 reset magic word */
+	ldr	x4, =L2_RESET_DONE_REG
+	ldr	x5, [x4]
+	ldr	x1, =L2_RESET_DONE_STATUS
+	cmp	x1, x5
+	/* No L2 reset, skip warm reset */
+	b.ne	skipwarmreset
+	/* Put all slaves CPUs into WFI mode */
+	branch_if_slave x0, put_cpu_in_wfi
+	/* L2 reset completed */
+	str	xzr, [x4]
+	/* Clear previous CPU release address */
+	ldr	x4, =CPU_RELEASE_ADDR
+	str	wzr, [x4]
+	/* Master CPU (CPU0) request for warm reset */
+	mrs	x1, rmr_el3
+	orr	x1, x1, #0x02
+	msr	rmr_el3, x1
+	isb
+	dsb	sy
+put_cpu_in_wfi:
+	wfi
+	b	put_cpu_in_wfi
+skipwarmreset:
+#endif
+
 #if defined(CONFIG_GICV2) || defined(CONFIG_GICV3)
 #if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_ATF)
+
+	/*
+	 * In ATF flow, need to clear the old CPU address when cold reset
+	 * being triggered, but shouldn't clear CPU address if it is reset
+	 * by CPU-ON, so that the core can correctly jump to ATF code after
+	 * reset by CPU-ON. CPU-ON trigger the reset via mpumodrst.
+	 *
+	 * Hardware will set 1 to core*_irq in mpurststat register in
+	 * reset manager if the core is reset by mpumodrst.
+	 *
+	 * The following code will check the mpurststat to identify if the
+	 * core is reset by mpumodrst, and it will skip CPU address clearing
+	 * if the core is reset by mpumodrst. At last, the code need to clear
+	 * the core*_irq by set it to 1. So that it can reflect the correct
+	 * and latest status in next reset.
+	 */
+
+	/* Check if it is a master core off/on from kernel using boot scratch
+	 * cold register 8 bit 19. This bit is set by ATF.
+	 */
+	ldr	x4, =BOOT_SCRATCH_COLD8
+	ldr	x5, [x4]
+	and	x6, x5, #0x80000
+	cbnz	x6, wait_for_atf_master
+
+	/* Retrieve mpurststat register in reset manager */
+	ldr	x4, =SOCFPGA_RSTMGR_ADDRESS
+	ldr	w5, [x4, #0x04]
+
+	/* Set mask based on current core id */
+	mrs	x0, mpidr_el1
+	and	x1, x0, #0xF
+	ldr	x2, =0x00000100
+	lsl	x2, x2, x1
+
+	/* Skip if core*_irq register is set */
+	and	x6, x5, x2
+	cbnz	x6, skip_clear_cpu_address
+
+	/*
+	 * Reach here means core*_irq is 0, means the core is
+	 * reset by cold, warm or watchdog reset.
+	 * Clear previous CPU release address
+	 */
+	ldr	x4, =CPU_RELEASE_ADDR
+	str	wzr, [x4]
+	b	skip_clear_core_irq
+
+skip_clear_cpu_address:
+	/* Clear core*_irq register by writing 1 */
+	ldr	x4, =SOCFPGA_RSTMGR_ADDRESS
+	str	w2, [x4, #0x04]
+
+skip_clear_core_irq:
+	/* Master CPU (CPU0) does not need to wait for atf */
+	branch_if_master x0, master_cpu
+
 wait_for_atf:
 	ldr	x4, =CPU_RELEASE_ADDR
 	ldr	x5, [x4]
 	cbz	x5, slave_wait_atf
 	br	x5
+
 slave_wait_atf:
 	branch_if_slave x0, wait_for_atf
+
+wait_for_atf_master:
+	ldr	x4, =CPU_RELEASE_ADDR
+	ldr	x5, [x4]
+	cbz	x5, master_wait_atf
+	br	x5
+master_wait_atf:
+	branch_if_master x0, wait_for_atf_master
+
+master_cpu:
 #else
 	branch_if_slave x0, 1f
 #endif
diff --git a/include/configs/socfpga_soc64_common.h b/include/configs/socfpga_soc64_common.h
index b8448ba6636..312c6fafc6c 100644
--- a/include/configs/socfpga_soc64_common.h
+++ b/include/configs/socfpga_soc64_common.h
@@ -24,6 +24,11 @@
  */
 #define L2_RESET_DONE_REG		0xFFD12218
 
+/* sysmgr.boot_scratch_cold8 bit 17 (1bit) will be used to check whether CPU0
+ * is being powered off/on from kernel
+ */
+#define BOOT_SCRATCH_COLD8		0xFFD12220
+
 /* Magic word to indicate L2 reset is completed */
 #define L2_RESET_DONE_STATUS		0x1228E5E7
 
-- 
2.35.3


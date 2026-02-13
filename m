Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C18EDF175
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 15:34:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BCA183015;
	Fri, 13 Feb 2026 16:34:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gfbamNOj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A2E83AA9; Fri, 13 Feb 2026 16:34:26 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5560D82A9E
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 16:34:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYl5gF9SKhQ8AmqtPCMH+o1v/J+XLkSGnOPgheHYL4B9vewD3I/zRk+OgoqfdZvIJLJyobaPgsjDqkn0pex7UUAF/HUKwuoKHUttK/lHp5lR3ch33jty9C+6SXNrk3fkb2HJqu7EWR2jwo+x23e5/yiHO2zi4OiSp/ft+n2puOxqlytswRGVutKxJUVO3nqsRp/FmfpSGe+Urt9g4p6swv+HcisVUvSZlDozFevf8b7gvdUp0phuRXBBBz6U1XnFNzIUWHe2W0b0wY53eQ67RDu3H8rdOFEd0bn4LsZ+BU73SIgI6gsLdgm4e92QmlQ/SZqPVFxi18TmTDBd2gd03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oAE8hY+hsl53d9wI6ST1B/kQVHUepNuV35U6mbi/3M=;
 b=iEjUEQxk5ieQM8ToO4ULkCFgRx89NLeNLtzDRA81RmSRRFFQ1VYLkzXcUSMs21vMr+L2oAFC9RBkJUId7BK0QIVorojboS1Foe2+SKPWK+kLTGE3laIkXmCRWNcJGsSwfK8DkJeHvdY+ZtEDkRAgAfv5n7tqSkao3M4stMLe6hS0DadCZLwjRh4vd6iDTwZitunqoHv/+dXhKgj+kvsjhrMeVqqbES1YYmONgFEvY7GsfJt1CvCuItn7CrpelyQfrGN7UQ1IdZN1OeFQFLI3yRo+IEuTQ0tC2IMHMLKP4mfhi/12pjoKuiswfwDF2tWeWx33C1nw8M1VupXKDraAGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oAE8hY+hsl53d9wI6ST1B/kQVHUepNuV35U6mbi/3M=;
 b=gfbamNOjF0EZOVQV0pXhm8KYVvPx73Ha3bINc0VjWB9kGY6k9lGnl31T1daqQZFkRWYxOR+4YW0PfXmcTDDyssvD3v+S39KPawbPAXGaqc5dXdrFRHGFoiWhXxj2B2KbquUdZv467bPdvy/N/ToD0vHuqqTyb9Jjvppiut0zAac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by DU2PR04MB8869.eurprd04.prod.outlook.com (2603:10a6:10:2e0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 15:34:21 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9611.012; Fri, 13 Feb 2026
 15:34:21 +0000
Message-ID: <5fd4f970-453e-4bcd-b2c1-8f5008c84572@cherry.de>
Date: Fri, 13 Feb 2026 16:34:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/12] rockchip: board: qnap-ts433: Fix dir naming to
 allow build-system to find it
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: trini@konsulko.com, u-boot@lists.denx.de
References: <20260114082822.4007128-1-heiko@sntech.de>
 <20260114082822.4007128-4-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260114082822.4007128-4-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|DU2PR04MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: b8643c50-21c1-4a74-7e8e-08de6b155bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|10070799003|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzUrZS82QWxUZUhYWDA0QytVZjJQckpPbGxEeGZmMnZ2QXNFU2NBYnNJbjJo?=
 =?utf-8?B?czVGWko4dVFURWkwa3ViaFlHQ3pQWlNnVFRCck9Rc2hhYkE3RWZrTytoTjN2?=
 =?utf-8?B?OGtDVXBycklFZFh6RFRvTnhNeXhSQU91MWtPODBQVmMxTERDdmJXWFBFWDJU?=
 =?utf-8?B?eEo4aU1iN1k5VGVkV0ZvM1FEVkVzMFJBT2wwdjNTSXdiRDlxc08zdHU5djkv?=
 =?utf-8?B?MGpvcTB1L1ZrNjdVYkZhdGMzNVlSblZ5NUJzNDlXeUpmRkk2YnNJWDBrWmhX?=
 =?utf-8?B?Y01sNEFvZHNBYVhETGxiblNaeWp5aFVzY2hyZmdtbTVFdjIvMC9wUUNscXlv?=
 =?utf-8?B?RmpPMmptb3dwcDJ1U1JpZjBobkk4WjE2TTZEYm5NM1NjWldQMUo4c1c0dFZH?=
 =?utf-8?B?SVhDUHd5bGJmdy84NzVOQmJMUGhDdTBnSW1jSFp6UDlxZDBGWXZUbTIwSDND?=
 =?utf-8?B?SGxjMDczU0VQMXhHTnVWNDBtaHVZcmdqYmJMUElGbDgrd3BFTzhiUWRsWUtQ?=
 =?utf-8?B?V1dvR0QvQ3dQNVIxWVU0ZjJDeDBXZldSemdVNTBxOXU3QThweHhqdDNDbm5B?=
 =?utf-8?B?MzBienhia05NbFp1cUh3QkZvZ0V3NXdPRy9mT3JQRU40ZUJxaGg4KzcwYklK?=
 =?utf-8?B?VGJ0ZW9BWXhWWVJXenB2TWhaa3RvM0Z3SGllTjZ6QTJxZTZTcUpVQ29MZ2ZO?=
 =?utf-8?B?QjFwZHBYbUpIS2tlbEJVcWwrYzVqMGtwRXpHMzJycmJoL2NVbXJONVpCZ251?=
 =?utf-8?B?NUh2U2RUWmliVnVXT1Y4Mm9rYXdMOVNrcThzSTdOSzNaSU81T05MNDdWMkRM?=
 =?utf-8?B?SXlWMzN1TTFnZ1VkS3VoMWNQVVdkM0hsM3pKZzliNGlYeUVaOVBFdWUwSUlq?=
 =?utf-8?B?aW4zQjdBT0ZMSy81WlNyNXN6cUpscEVaamRqRGJ0SStDV256QXVwampFZnc3?=
 =?utf-8?B?ZzNQZjdiNnpsQUowSTg4RXpSS1RFK0M4OXZNUTgzQWkrVm9jdEYvQlJRMHNm?=
 =?utf-8?B?b0N4azZBZU9NV2Vya29lZFcyTkEzU0RuNXZDdFFZeTBxQVBxVkE5Q0ZrdlE4?=
 =?utf-8?B?b0wzMzg4clhIWk14UUg5RnR3TThyZmNXV2NJMFdGb3JLV3hMVm5RS3crdXhI?=
 =?utf-8?B?Vkd2SEFUSDEvdFVHb0xRZ1huVmM5RkZrU0wzN1dTQXJRU2lndk8zWnFRZFpI?=
 =?utf-8?B?T0NNNmh2aWNnNzhUVDNMdi8wWVEvMjdycjlod2lORnhTVkRKcVMxRit5VUJk?=
 =?utf-8?B?aHBibjc3dFZmVW8ycDJkK0gya3RrN2pvQU9uRVZ1QWp4T1g5UERRMEpRK2Z1?=
 =?utf-8?B?SEhpdjAxTzVMWThRa0RFQ0crb2xlS3VHV2h3Wm5FZ1kwMUh2cnhIOUdta3VL?=
 =?utf-8?B?eGt0M1NDUXE2WUthUGkvNW1MbWtuem93S3MyQitSd1BwWGFFL3VIcXlQYmtm?=
 =?utf-8?B?M016ODc4aDZtVWlseU9IRm8xVzNMRVZCcUliL0NXMVBsd1RWZjRNOWZVRzJG?=
 =?utf-8?B?ZWVPR2pIMVJxU0drOE9lSGxYdFMvTDdtZzlGUzFOcXhJdVo4dExHNldRS2Rn?=
 =?utf-8?B?T09kcVZ3Ym1EZzFaT1Y1bGRlNHpqWnRGVTJnMXRHaDBDRVVnQTNMaGRIVndV?=
 =?utf-8?B?cHBnWDRYcEJWT1ZqN0ROdndiZHRKTXlrd0YxQlVVMW5oMUNacUxna3ZTdkJX?=
 =?utf-8?B?N04wbU5YbGE2Tmx2VFBxL01mMldrY24xTGsyaFNnY0EvaUl6NEFqRklTR2xu?=
 =?utf-8?B?d05MdXkyRE9ibFdwZ3l6dTM1b0FscUxYN0U0emQzVWU3NDF3YithRE9HWHV4?=
 =?utf-8?B?MlZtYjg1blBNdUk3QVMxNlM2UkpqdTh4dldnUlF5dmtMTWw0Zlo3ZllmY0t4?=
 =?utf-8?B?VFJBaXBEeThVTTNQOEY2cFlkVERzN1dsNkpwTmVpeU1tayt5dlNORHVNRU1H?=
 =?utf-8?B?cmVtSUdra2Z3elFNRHg0VEZtZFc5MFo1SXlZZUMzOGxaVzJlUlF2elF2SklN?=
 =?utf-8?B?UStuVXVseVUyUnVCQkZGWUZOcGdYRFN3NDB5MWhRNktoUE04a0dSOERteERE?=
 =?utf-8?B?SEFyZVkrbVJuWDlIUjZxR3Y3NmRxZ2FRYTVYaVhNbW5tLytuNkRodDN3STRZ?=
 =?utf-8?Q?QFR0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nncyd3l0bjUrVk9lVzVWR2VDQS9oS3h0dCtrWjcxK0RIWGsvMHozWVF0ZzNP?=
 =?utf-8?B?ajFxd0ZyTHlNWUk0M002VXlFbVBnc2NkYUxUVHFrTXF1bUtYUzNid1Yvclpw?=
 =?utf-8?B?a0hFVERCS21TK2xnelYxUWc0bVkwbkphM0VQZXAvSFg0UXB0NklWU3VtaW94?=
 =?utf-8?B?c1FlbTNta0dmQmV0S0pkWENQblZ0dXNwNVpOMlJqSit3dDJwMElKNUd4bENT?=
 =?utf-8?B?cE5laURkS0p2TW4vdGF6K3NHbnY4eHl6cmRLR2QwQXF6Y0lITHhlcDBlZUxi?=
 =?utf-8?B?NmlONmxmbE83WHNvSmwvbFdZS3BMK1dpV2pLbysxM3IvNUJKWVBCWm1sbndp?=
 =?utf-8?B?S0tBdVdLSllyeTZCNVJZeFJjQTkwU1ZNcHllQmk1RGhGR1EvZEoxT3h3QzJF?=
 =?utf-8?B?d3hxOE9rb2hETzNYUDJRVW1rUmVWWW1LaWV4MmRuTHlab3lqdHlwRUFNZUZV?=
 =?utf-8?B?K0VTWGN6NEV6ZjNHSVNxYmlnY0hUTGNJYmJ0NjNyT2UxMnRidEZZelFKaHBJ?=
 =?utf-8?B?Wk44YmEzZVJ3cCtiWndtN25aeC83Q1RvYXBubThobWxNTGgzeEFTMmNPMHpl?=
 =?utf-8?B?a0paZjBqVm1PQlJ5K1UvbzA1c3E0eXpad1hvK2h0Z04xaHp0cURuUWkwMUt6?=
 =?utf-8?B?MDlzTFZBZWVDODBjVmk0VXg3eGpMOXIrNlBpRy9JWnZxZ2t6TEJkYzNuZzhq?=
 =?utf-8?B?bG43N25RUkRDWEM0WHJuc2drdmV1WlVRZVFyNUhJeHJCOWNIVUdST2YraFFT?=
 =?utf-8?B?a28xYmYycXoyYkZUYUxwUC91TklCaGN5aUYwYUlCclZua21rOGxiV29uRzQx?=
 =?utf-8?B?azFsRWdyVXR4bUlQM0wyTE92NS8ycHJqcUhkcW1lSWdYa3pUM3JqTjJpZUxJ?=
 =?utf-8?B?QUg3MktLRHp6bitJV1pVSXRjRFZmdThMZ2lmaFM1OEFRS3dyKzVOenNBOGVR?=
 =?utf-8?B?SmdsMUR0YlV3TllmZUZzVThQV1NXRkdNS3RpdEhiQTZITy9OeE1BS3ZkVG5L?=
 =?utf-8?B?bGlvV09HYmxyblVFa2I0dWU0a3hSd2txNmlWRjVDSmlVLzhoWEZKTDcwZzJR?=
 =?utf-8?B?L0daZXBYT2FoVlJOSUFISnNxOG1ESUxaM2V5SFV3L2J5akZVSUJrYUVNcW1h?=
 =?utf-8?B?MmdBdkJpM3NtVTVOQURFbEZHM1c0N0pyelVrLzc0dTNFakhSa2ZnNmtNcitx?=
 =?utf-8?B?Q2E0VWFzTzJBOUNJMGtYVFFxVVRKTTZVOGRkOG5SZ1VWbnpML2VtY3VvSkJy?=
 =?utf-8?B?U1NnTmFFNTAxQXFZTE1jNjFRelZSUnlOV1hOZjJOVE1GUUhaTVJvc3ZwVDhO?=
 =?utf-8?B?YXoyTlA5bjV4K3kvcTlFWTYxR1dtQjVWQjMxVlVwbTBwRU9TV2VacDhSc053?=
 =?utf-8?B?cTk4LzZXNGhUS2EzUURYNkU5THQ2eC9XZ3BZSlFaaDBsb2dWZWQ5M2lZam9C?=
 =?utf-8?B?dnZIK29PV2d3Q2VkWXhSQXZQaHRab01QQWpuUTJyb3lKYUQ2WVVndHN6WGRu?=
 =?utf-8?B?NzNGRHM1YldBazIrR0hMRjlWeEdPcURyZ2RCT3BJSmFCbEM1a2VNcFlUMTlH?=
 =?utf-8?B?cTJOSWFrNysvZWVvMmwrQko1Y21lZWZEeDNxMk1IaVorYW01T2xlcDhaNGxI?=
 =?utf-8?B?TWEwWUJMTldFMzRZbDA4MjErQjVrdVJOdWJjRkNmdnRwTDd2SVcySlFvamxP?=
 =?utf-8?B?T3A3RWM4NWlsc3FjcUhGdHB0MEFCVm9PbkFkcFZvajYxanBpOG1hYy9TWFpq?=
 =?utf-8?B?MnRMOTJ6aHJWM1JRdmNoM1g4YlhzdVpJaDlrZFJBanQ1TEVpUFpOdEc5L0ox?=
 =?utf-8?B?RHM5MFIya0FJL2ZxTUx4dkQ3ZkNZNmpoUkEwSWk4RGtWT2VQaTBTU0p3WGJz?=
 =?utf-8?B?Z1NGV1ZTMkNlU3VXVHhIY200TEEyUDJ5QjJWK2F5b1daejBpRnRpS05WbWkv?=
 =?utf-8?B?eDdtaTJyL3NyWjVzZkRvV29NN1RLaXl4ZC9LTHNHTGVaRVR2Q2tDYjd2YnlQ?=
 =?utf-8?B?eXB2TnFNaDUrZGxjMGptOFdjVkZjNGR1V1NwUk5OUEtMVnpiUGpaeDcrSllO?=
 =?utf-8?B?QzVSWWx3TGVhNVM0UUI3TlpJRDF3ckFDK2lUUk9UY0xaYjlNOVNvd1JmenNu?=
 =?utf-8?B?eEk5eHhYMGJIM2hGR3B0YUpTS2JPTStGTG16VUFHY1pPK05WMWJlWlZrSTAz?=
 =?utf-8?B?WHZZT0tjQ3I1TFdaMi8yKytLT0pyMlplUjRKSHNLOGowU0NLYThSYlMwNmt1?=
 =?utf-8?B?cXRJYmYrakdNV0RsbHBRblRxY1FNQU40ZnI0LzFRWUNldDNtNGFqM0NGYjFm?=
 =?utf-8?B?ajF2TGkvQURwY1owZHpIWWY2a25aUGRkaTM0ZVJKdllXZm9QYVpQMmUzUCt2?=
 =?utf-8?Q?45JLQdAsciuj80PwAb44LREjJCL2MU4WIwvxB?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8643c50-21c1-4a74-7e8e-08de6b155bbf
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 15:34:21.1737 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTIY1b7Lqn9/ab/D9qbAhsxEABhr3q04aEp/gRzgs9G53dWz3lSuzDD6JpI9tbYcLVRrPHdWSGSKDzR9tTHELiqSHN0r80QiLN8uZXZUrNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8869
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
> Right now the board directory for the TS433 only contains its Kconfig
> which is linked to directly from the main RK3568 Kconfig.
> 
> But as the namings are currently set, the build system will never find
> the board directory to check if it contains something to build.
> 
> So adapt the board naming to a pattern similar to all the other boards
> (boardname_rkSoC).
> 
> Fixes: d3cacb79e706 ("board: rockchip: add support for Qnap TS433 devices")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-rockchip/rk3568/Kconfig            | 2 +-
>   board/qnap/{ts433 => ts433_rk3568}/Kconfig       | 4 ++--
>   board/qnap/{ts433 => ts433_rk3568}/MAINTAINERS   | 2 +-
>   include/configs/{qnap_ts433.h => ts433_rk3568.h} | 0
>   4 files changed, 4 insertions(+), 4 deletions(-)
>   rename board/qnap/{ts433 => ts433_rk3568}/Kconfig (70%)
>   rename board/qnap/{ts433 => ts433_rk3568}/MAINTAINERS (87%)
>   rename include/configs/{qnap_ts433.h => ts433_rk3568.h} (100%)
> 
> diff --git a/arch/arm/mach-rockchip/rk3568/Kconfig b/arch/arm/mach-rockchip/rk3568/Kconfig
> index 2730220a18e..16e14ee4fa7 100644
> --- a/arch/arm/mach-rockchip/rk3568/Kconfig
> +++ b/arch/arm/mach-rockchip/rk3568/Kconfig
> @@ -76,7 +76,7 @@ source "board/hardkernel/odroid_m1/Kconfig"
>   source "board/hardkernel/odroid_m1s/Kconfig"
>   source "board/pine64/quartz64_rk3566/Kconfig"
>   source "board/powkiddy/x55/Kconfig"
> -source "board/qnap/ts433/Kconfig"
> +source "board/qnap/ts433_rk3568/Kconfig"
>   source "board/radxa/zero3-rk3566/Kconfig"
>   source "board/xunlong/orangepi-3b-rk3566/Kconfig"
>   
> diff --git a/board/qnap/ts433/Kconfig b/board/qnap/ts433_rk3568/Kconfig
> similarity index 70%
> rename from board/qnap/ts433/Kconfig
> rename to board/qnap/ts433_rk3568/Kconfig
> index b00e1f9f2ef..c5f9db849f2 100644
> --- a/board/qnap/ts433/Kconfig
> +++ b/board/qnap/ts433_rk3568/Kconfig
> @@ -1,12 +1,12 @@
>   if TARGET_QNAP_TS433_RK3568
>   
>   config SYS_BOARD
> -	default "qnap_ts433"
> +	default "ts433_rk3568"

SYS_BOARD is used in the default environment so this would change it and 
not be backward compatible... Is this something we're ok with? I'm not 
sure it is worth it?

I also see you're modifying it again in a later patch in this series.

Another option is to make use of HAVE_VENDOR_COMMON_LIB mechanism such 
that you have board/qnap/common/ where you can put files in common 
without having to modify the existing layout?

You can also have a symlink if you reaaaally want board/qnap/qnap_ts433 
to be board/qnap/ts433_rk3568? Hopefully that works.

In essence, I'm conflicted about this change but hopefully nobody 
actually uses the "board" environment variable?

>   
>   config SYS_VENDOR
>   	default "qnap"
>   
>   config SYS_CONFIG_NAME
> -	default "qnap_ts433"
> +	default "ts433_rk3568"
>   
>   endif
> diff --git a/board/qnap/ts433/MAINTAINERS b/board/qnap/ts433_rk3568/MAINTAINERS
> similarity index 87%
> rename from board/qnap/ts433/MAINTAINERS
> rename to board/qnap/ts433_rk3568/MAINTAINERS
> index c2b31ad9794..02ce7ff383c 100644
> --- a/board/qnap/ts433/MAINTAINERS
> +++ b/board/qnap/ts433_rk3568/MAINTAINERS
> @@ -1,7 +1,7 @@
>   QNAP-TS433
>   M:	Heiko Stuebner <heiko@sntech.de>
>   S:	Maintained
> -F:	board/qnap/ts433/
> +F:	board/qnap/ts433_rk3568/
>   F:	doc/board/qnap/
>   F:	include/configs/qnap_ts433.h

Missing rename here...

>   F:	configs/qnap-ts433-rk3568_defconfig
> diff --git a/include/configs/qnap_ts433.h b/include/configs/ts433_rk3568.h
> similarity index 100%
> rename from include/configs/qnap_ts433.h
> rename to include/configs/ts433_rk3568.h

... since you rename it here.

Cheers,
Quentin

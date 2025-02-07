Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82CBC02194
	for <u-boot@archiver.kernel.org>; Fri,  7 Feb 2025 14:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1EF480836;
	Fri,  7 Feb 2025 15:27:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="rF6Z/GW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BEB0801DE; Fri,  7 Feb 2025 14:06:46 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F101801DE
 for <u-boot@lists.denx.de>; Fri,  7 Feb 2025 14:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Venzin@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apd8OcZJaImBI8P+aVRZSx+deSeDtb/qXc2Q0QcaCTX1W1ZWzqNx/ioCifQMIF9MnTEBtX2BMO/YFLoApHGcv3hdLxX0+o34xP8f33HF+b2GSeGozX6HMFpKmmNaVQ2xaGFvaVNhykuSIWVAO6JYBefoehMHexi++RVFBXJsOkYYXux3474UX0u94mZg5si2lzozKGQVI/49XI1pdUe0mTsUwtLbjMXbmTvrYg01Yp6bjPDdeRilBqzUe2mAIvdTUMgX0So+oXH9P5a6Ea4+MYdN3pWl5gN6CdUe5EX0UGtOHCJhSKCZ07bLWFOb4igeQMSJ2sTADEs10uPOxZFmPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qAZ8tfNfHsAlm5t2XbU6IlX/QKSo+H4LBf3NIaaZwTU=;
 b=I1MDKhkIZ3OeCoqAKBAhOI3k5AntvNyj9txpsMBPXJR12XC7oUMb0nDUnQk50ljstdjASACNgiEC6KF1cQt2qEDGW03ENmg6SFKekz/K/WDRwd/IA6tkfMuOgbV0oG3pNdETvO1duz3bdNNmbM9PEUET+YZXu/Eid3Mbzvw7hLhBZ3t+YH8L0aaI2et1K7NgXjn/dD1j+k/kI/NYro2rVuTbz6h/r0J7in5+mMZywr5xQGJ980spQcZgCdttBq5R6+YAAsigGhHr1C35WYGczqNXlqfoBi8PkJRMKcoEsJygoFmtO8Jg4fg1UwLKkQQRKkfP7YY/bCMrTjaMqCXXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qAZ8tfNfHsAlm5t2XbU6IlX/QKSo+H4LBf3NIaaZwTU=;
 b=rF6Z/GW1esyTJ+3CxGOuv98GBvswFyzHhmRuedEKXVFXRUSqS7EnxHhZGysgdE7iXTz5bhpb4OTI3X2A6BMoUEL4cZIkWh6GsS05ECwkYXa16WE5L6oLe6um1wlSz8Nu6KoVr3ijFMLEeYIgVCFxflNcCnps0d2LKwGk9IAXQ1qizuMAKyPfrOh+gkc4QEpyVt3J0jZZ545lGsbUnKbb8SRdmW6Y3yBLH6o+Jztoh0oIKuE6asATlYNuB4WgFue6QN75s8brB1/4ayVXJVBTwnipoYLtDgThoHAfxLPywc0Zdv6JzZU4K5MSR9zd+3XmKcem78e9k56j1aod8/cORw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com (2603:10a6:10:d6::15)
 by DU0PR03MB8462.eurprd03.prod.outlook.com (2603:10a6:10:3b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.13; Fri, 7 Feb
 2025 13:06:37 +0000
Received: from DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4]) by DBBPR03MB5352.eurprd03.prod.outlook.com
 ([fe80::dba2:ec74:d7ad:37f4%4]) with mapi id 15.20.8398.025; Fri, 7 Feb 2025
 13:06:37 +0000
From: Daniel Venzin <Daniel.Venzin@mt.com>
To: u-boot@lists.denx.de
Cc: burak@gerz.io, gabriel.dalimonte@gmail.com, Manuel.Traut@mt.com,
 Daniel Venzin <Daniel.Venzin@mt.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Richard Weinberger <richard@nod.at>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 0/6] FAT file renaming
Date: Fri,  7 Feb 2025 13:45:17 +0100
Message-Id: <20250207124523.85026-1-Daniel.Venzin@mt.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To DBBPR03MB5352.eurprd03.prod.outlook.com
 (2603:10a6:10:d6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR03MB5352:EE_|DU0PR03MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 4748cbb1-7222-43a5-34ec-08dd47784153
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|7416014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmU0cElCczdoS0tEVTdaSjdMZTNVd0NvWStxU2podGIweFVUL0RKa2VKWndQ?=
 =?utf-8?B?c0txeDJNZC9RdEVuUkxLUDMxNFAzdEJqbEFTYXExckxOQld1ZmpYRzZMZW4w?=
 =?utf-8?B?bUtXOU9rcWZMbm0yQVdUZktha2JaQ1c5U3pGRWU2N0JndnA1aEM2clJXUXhX?=
 =?utf-8?B?NVJjcVpucHEyRDVabnA2UUVWclhMMTc0Q3dDT0xZeEh0VndKVHBkRzhzT0RV?=
 =?utf-8?B?MmY5bVFsL2lXbklTMzN6b3A4SzlaajNMMmFSdFJlQzIxak4rUUxSNGhPZXFw?=
 =?utf-8?B?b2ZKL20zRWt6R3VMUThtc1RyRzMwamNjQlNLbVRYc0Iva0pUcElIbGhXeUVG?=
 =?utf-8?B?ZmpNdjh6akZPU0tSQjBSSFd5RnJsUTRrdHM2bjZ2U1puNnVqcmRiYVk1YWlL?=
 =?utf-8?B?aGx2SGtNNHB1SmZEOEh0dXpCRU4zclUyTUwzSkFvcHoxQmNQVmhGa2QxeThz?=
 =?utf-8?B?SXU4Z3lkZGZ2dzFVamdNbDgzZngyR0ZNRDZIQXc0djllcVdrU0hsNDVuZWkz?=
 =?utf-8?B?dFFiMnFsWld3NFdTNW5wSG5hYks1MWV4T3hFa3dKUUo0NFlHRkpjZTlKaHd3?=
 =?utf-8?B?bExMOVYrVWJ3cE5SNWY2ZnVNL3lNQWgyZGlZeGt3Y2trTlBuUXY1YWRPUWdu?=
 =?utf-8?B?UnlYekZUN0p2dnFta2theU9xS3ZiT1hCcTZLTW81R2MzZGRLN1BwaXUwS21k?=
 =?utf-8?B?SzUwQ1BBRXJtR0o2ek5ZNjVLTXhKQS9UbFpyVnl0TGp5UUY4dHM0OVdoUmxy?=
 =?utf-8?B?ZHZvallGeVZqTnkyZHUwVkxrUnkzREt2cTAyRUxoVjVKaGc4WVMvQ21ublNt?=
 =?utf-8?B?bkhwL05PLzRSV2dZSEpDVGVUMFdXclpKbXJrdWt6djlFT0U4cUxwVkFJb2Jr?=
 =?utf-8?B?ZC9OTzdyMmJpQnBFK3RrVlh4YjdZQ3lFSmhSTjlSYzdvMHhabUZ5U0Vld21B?=
 =?utf-8?B?NmMxTytWWmZodFdUa3pnNUJWb0NHYU5CNHpRUG1kRTFoRmhqNEMwYjhvcmVp?=
 =?utf-8?B?SnBjU0g0b1ZHWTUvQnVUKytZOU83TFNYeGQra3cwdTBoYVVzVDUvcVI3ZHZG?=
 =?utf-8?B?TSt4TFBEV1VhWHpRanRhUVZ6ZEt3YVppWkQ0ekYyZ1g4RkU5c2Y5eDZjZG9w?=
 =?utf-8?B?N0w5OXhNRkVBd0RVRlBkbEFhSW9KN3hzbVh0Y0RYRHU3YzFkT3dFSlBtRHNJ?=
 =?utf-8?B?VVlSd3FGTldvNysrN2dQcGxUUWFUOVRkQ0MzU1B1M1FjdFlrVVhJTitaMzMx?=
 =?utf-8?B?cFFFTytaOXltcjFkS1p3WjVSV3JsQzlOWkZpNWl4bWcrL3VXVWxLK24vbHl1?=
 =?utf-8?B?NU5Yd2t3aWF0amp0a3FZdnZDSXNCV3EyN0Q3a0RYdzVIejVjVG55cDBwUXJo?=
 =?utf-8?B?ZmRLMWdBUGQ3THpMU21nSDF0RUp5OUhBOGNoY3hkSkZUNzg4YkZjdXc2dXh4?=
 =?utf-8?B?cnAxNk1FcTVCMS9EUmc4UElCVkFWYXo1YjNqdWhLKyswcDVxWFgwWmMrWUFX?=
 =?utf-8?B?azJvM3ZrZ2xDTkczc1RJOGJNY0JVWGJwU3lUdmJKcEZicjU1T3RncnBvbUdr?=
 =?utf-8?B?Wit5U0d6YkcwOG5tM3RSYUttcUhHV2Y1ZVB2ZndpOWpDOWpSb1psNmRtZVhn?=
 =?utf-8?B?TU1TSWJHa1ZLdnNqd1cwR1B2ZFpuaGR0Y01Xc1hIdnYvTTF1aFN5UnBFSzdj?=
 =?utf-8?B?Qjc2eC82aEEydlJmLzl6bm12ZWpHMFQybmc4TTVtVWJxdkJGSjZGbGdCV2RM?=
 =?utf-8?B?VmZNcEcxR2hDL2t4SHd4eVpJQWJWQWRSbnE0MDFMQThrUC9PT0JXMlNlSEVn?=
 =?utf-8?B?SlNWaTI2WUhmdG82K1YxclA5SC95WWZrRmJiRWFxdUFCeHVyMVc4eEg0MTVw?=
 =?utf-8?B?Z1FvTTJZNk1yY0tiQ2tNeVQ2OVZSMmFlS1dlTDM5eGhVSFliN2ZLL3FTaWNQ?=
 =?utf-8?Q?b48IfLZ/7GMi52Sfm+nMTtjxRlB+8lTR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR03MB5352.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3YvLzB0OWIyMWo1WmJMR0Z3bHR5a0pHaE5BejhOWXkzR2Z3eFJ1YVN1NXVi?=
 =?utf-8?B?aTdwbmJtT1cydkhqM0F4V1dPZTN3ZE9iNjlWQTlINThtbDdZb1NmbkJqVUxG?=
 =?utf-8?B?UEFhWjZ2VUhKZ0YrQWcwd2ZMNFY2K3JwT2l1cFdvR25WUnlicmxTYTNrMzRC?=
 =?utf-8?B?bnAwTEJRN0NvaTIrYjMwWllWT1VjYk1IUjhDRHB0NFNWcUIveUtrNCt5ZjVk?=
 =?utf-8?B?OXc1c1ZyZGtUV1ZOZVlSMVAwUDQ4NEIyQ2tleGMwL3BlTEIrbDh3aTZNNUg0?=
 =?utf-8?B?NlZXaW5PYzFwV1NuWUIyM29MY0lTZHlGamFOYUcxL3dYZEM4bzBqc2loVHV4?=
 =?utf-8?B?eEtpM0k3ZUY4N0dsNXR0UHB0UVYxWkRWVVp4VitmUHF2VzFiWFlUd3k0d2cw?=
 =?utf-8?B?dGtiUnRJK1EzQjNQTjR4RU1XTUdhM0JBZzhuRmN1SlN5YW11Skp5TXlsWE1X?=
 =?utf-8?B?Y3N1REtoVmM3UVZYVm4rdSsxMzZDTmE5dFpmSE8wUkdqbVhrempURGVVYmdj?=
 =?utf-8?B?WVhVd1poamYxUmRnaE15L2hMSGRyMDl2aGV6aVVpK1g4d1pOZFdiWXhQZjJ2?=
 =?utf-8?B?SjZ4dXA3M0wvQVVycDZzOEtHcnJNWHZhZUxtcnlRcXdvQm1oZkpyb3dPZGNt?=
 =?utf-8?B?ODUxY1hHMlZpdUkvN2pHK1pUZCtaSm1aZ2NZNG8xOVo2a0d5dUNGZ1BWdHQr?=
 =?utf-8?B?VU4zUzd6RmlhVHNLTFNnMWFTRjUvMDZRNWhnNWRCQ3diMmdsK0E3T3hPaEE4?=
 =?utf-8?B?RkJKekZXL3BqT0J6SHk0WVVveklPUytDWmJ3dW8vdittTU9qTm5nNUVJQURp?=
 =?utf-8?B?T203VFVEcXVRWWNWOHcvdFE4U0dFYjhrdDZkRmdQWE9SZ2kxQm9FOWZzTGpK?=
 =?utf-8?B?U05kNCtvb3ZLeVRzSkpiVWxXejYvZVc2RVhaOU9HY0o3NkdUTmhtWVNkbUZi?=
 =?utf-8?B?VGpHdmRqU3NEcmxKN3Y0dXZtOXRoVFNhNzN2OVpzYkc2VzA3SEx2RURKb0hr?=
 =?utf-8?B?enRKcXZvSlRUaFIrd0pYL0xUQ3ZzMGJUd1I3TmVQVTV5SEg1KytYamFKaERO?=
 =?utf-8?B?OHB3UFdFRU9oWWZMekVudkxuS0hFS0hHVzRUMS9TK1ZWaEdCRXZRaThhVTE4?=
 =?utf-8?B?M1lmMFhsZWpvdFVUSXU5cFppV205Q1ZVdWd2TFIvT00yeDJJZUtiLzc5YjEw?=
 =?utf-8?B?MVN1R2dZcWFDcjJYMEZEMForWjZURkd1UHA5R3I4WEZBWGM2VktXdnN2NWlK?=
 =?utf-8?B?eWw4clYrMmtzMStpT0JHdzVZOFlWTnNiZjExZ3IxYVZhNmVReVhnSHovSmND?=
 =?utf-8?B?S1lOcXE1bzQ4dmFpSWVaeERVdzFBdm5mR3gzYmNXK01rUkVnaEI4Si9JdnV6?=
 =?utf-8?B?VDQ5M0cvb2t6dDFETDJnVHo1cEp4ZlB5ZEI1Zkg3Z3dENDN5clNMOXBMWHNp?=
 =?utf-8?B?bGNvS2RsUHE5YkRlU3l4SjRUZVk5TlNRaHo2alh1OUY1b1Z3eXF6c3FxSEZK?=
 =?utf-8?B?RUpsK2VZZUowbWRYc09yQlRuM3FvdVh5dHhZbnpaK2IzWk9NNVNjKzRIUjlS?=
 =?utf-8?B?QUJ3UzBUR05kK0s5OXE0NHlSWTlFc09tSlluV3UzOVVXVkN2cGVmQlkrMkM1?=
 =?utf-8?B?ajNpaWVpRUpSRkFCNGJVTGhXWm9CSXZpZzUxOUR6bWViSGhpa0ZZNW1iMTI5?=
 =?utf-8?B?Tm1tRWMxNm1OUnQ0QmFxdTdOUFUxTzdFbEVEeUZWMGUwK1JtbllVLzJTcG03?=
 =?utf-8?B?MzBhcFg0UGtNbkFaVjh0bFhnbFgxYzFwSlMycFdUTS9jVnlzTDNPNWN2TG5T?=
 =?utf-8?B?SDc4b3dNWVd3MjEvaXhJQmRlcG1wamdvcDdIakNYZUZBdFdhUktFZlhTSFl2?=
 =?utf-8?B?QlhHQnpFQmYrcWpOQXhiTDkvMzVJOS9pSTFHeCsxNEx2RjdtcllJMzg3ZG1E?=
 =?utf-8?B?a05DM3VWY0lJWnRsQzJ0YVoyRUxKMzdEQXdNMHVMa1ZnOUoxY0tiQjNhM3BV?=
 =?utf-8?B?OTdkb3JPWW0zQ3lFeVlnMXo4TC9rODJvRzVveEl1dy80OE1HOUxQWWV6aDY1?=
 =?utf-8?B?cmc5UGRrTUVEeWdTTHorN3cxNEdRTE9nM2VGMUJNalhnOXBOSWlKSnpRcXlZ?=
 =?utf-8?Q?oR+/KUrZ75Cyqupt7Eif2Lu43?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4748cbb1-7222-43a5-34ec-08dd47784153
X-MS-Exchange-CrossTenant-AuthSource: DBBPR03MB5352.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:06:37.5498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b4TClVis6dxA2scHW9qC/+ehyfdEql1EFTlkyGD0iT5+E64zglaNn/CWLD95IXymXdFXKTpPQ5p0xMpAWICc3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8462
X-Mailman-Approved-At: Fri, 07 Feb 2025 15:27:24 +0100
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


This patch series represents a continuation of version 2 [1],
incorporating tests and improvements.

[1] https://lore.kernel.org/u-boot/20250203211719.GX1233568@bill-the-cat/

Changes in v3:
- Abort the rename if the destination is a path instead of a file
- Add fatrnfile command for renaming files in a FAT file system
- Verify FAT file rename functionality with unit tests

Changes in v2:
- Adapt variable names for better consistency
- Add missing rename hooks
- Use EFI_ACCESS_DENIED for unsuccessful renames
- Avoid using of "== 0"
- Move the call to set_blk_dev earlier in the sequence
- Refactor delete_dentry_long for improved reusability
- Separate the rename implementation from changes in the filesystem layer
- Eliminate code duplication with delete_dentry_long(..)
- Ensure that the source file exists, but not the destination file
- Free the fatbuf if it has been reinitialized with fat_itr_root
- Delete orphaned FAT entry after copying file metadata

Daniel Venzin (6):
  fs: Add unimplemented rename hook to FS layer
  efi_loader: Support for file renaming
  fs: fat: Refactor delete_dentry_long interface
  ﻿fs: fat: Support basic file rename
  cmd: fat: Add fatrnfile command
  test/py: fs: Add fstest/rnfile test

 cmd/fat.c                            |  13 +++
 fs/fat/fat_write.c                   | 149 +++++++++++++++++++++++++--
 fs/fs.c                              |  50 +++++++++
 include/fat.h                        |   1 +
 include/fs.h                         |  11 ++
 lib/efi_loader/efi_file.c            |  11 +-
 test/py/tests/test_fs/conftest.py    |  75 ++++++++++++++
 test/py/tests/test_fs/test_rnfile.py |  93 +++++++++++++++++
 8 files changed, 392 insertions(+), 11 deletions(-)
 create mode 100644 test/py/tests/test_fs/test_rnfile.py

-- 
2.39.5


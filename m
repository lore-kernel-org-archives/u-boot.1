Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F6BCF258E
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 07:49:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B476F83968;
	Wed, 19 Nov 2025 08:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KrbauvHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCF578397A; Wed, 19 Nov 2025 08:49:43 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B810983936
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 08:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+CPe0hUE0oNW3ySp8f8oFpfHNd1VcSrhyWHPuEa/P3Qj9rv4EmBez5Dbh0Pno2PR44YQ7JchbjiR7614eiOHvWBXa6h/bGmTDa8VrbWaPthvNMiFVciGxgtLUgtNT306G02JmdNTBhpulPVABo3/srJqPXAYpH0q37/YE4y6ehdwV0UPGuKYCC6Z1RzJPxgqEFtfphNtwNV21o5GV0GdUes9dmodBm3O+6U19McdqwB9rYUgl4724K6PquYFsXN7Y4KMTV2ATh9OXZtiopO6f6hyvhr6bg7farT6MdOO3mhT9RxVgUwAJwR8gRfxivDUOZKhcU1IxRY6NmL/bbrqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NFUDyzcn/ofRBychcn1g54djqKlwsde9+YGZySgGxPk=;
 b=g9dAJYZATc0lG+KI58dEEeZzQTfBeniZPJCp1lNytKRVcSZ3hWJrb95qv0FJlVcMlBMoAdp0nb3nQ0oDAGBvdlRkKwg6xVWQHZ9n4SLbMHpkj4+6YXaLz1MaBTcRIei3NOPMGF+EpEZsDMb+S5oeRgxW/ZFFq3zBowmzugbzLT77BsPkzT6ptLDvvSPv+bUS7vcc5fKfB0DYEWhX4/JoBVdkOm13os3iQAWlSyZPwpfB0idO/vAMKTRCt6Vttvjs3Q7risdSjmRfIzIZNN7TfUI8c0UwgHHi24CAkw76GYykd10BjnGxstFuR1tL+Ic5EkhNwlSY7rpCBjhqqsE74A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFUDyzcn/ofRBychcn1g54djqKlwsde9+YGZySgGxPk=;
 b=KrbauvHHB0gQBkHO8ldV9XzDZHF4JzYH5Kn1grx6K21U0e9JQoADsxK4knSyj0fNAB/dFxN2erYcV2dPMECJCJiDZDPjhcQlFiTfPgJFO0ebiB4QCuOFL1wrnmrDGQOeMmKo/5ZLPPxBHAxp5hTmHfJ9F2bYigqWr0s7FkGa9xg/L04m4O/rFSLdDCpaa1ut35bJCwaLQWohge5kWDxeGjNRoLK1474aEjcl8rzu7OKRb8Q5WOTPFOHoMGierMgP8WfmmzgZUdZ+0OAutWY9gD//mEOTh/y1HjxJCmFM3VV76WbihswLtJAE/x9oB+Pouh+9C5SzUXJTJlc+WnHyGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by AS8PR04MB7621.eurprd04.prod.outlook.com (2603:10a6:20b:299::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 07:49:38 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 07:49:38 +0000
Message-ID: <92d98692-5fd7-456f-b831-0986e6d499a9@oss.nxp.com>
Date: Wed, 19 Nov 2025 15:49:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] imx: Revert "imx: mx6ull: fix REFTOP_VBGADJ setting" and
 fix comments
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Emanuele Ghidoli <ghidoliemanuele@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, uboot-imx@nxp.com, trini@konsulko.com,
 dario.binacchi@amarulasolutions.com, u-boot@lists.denx.de,
 u-boot@schwermer.no, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Jacky Bai <ping.bai@nxp.com>
References: <20251027115638.1186252-1-festevam@gmail.com>
 <CAOMZO5B1sxS8Vh1awupGZd8oqqLhZ55abME07Kf5AZ-w9jUKhQ@mail.gmail.com>
 <3ab1b3a6-b9ab-4571-a7c8-8288d4a8d290@gmail.com>
 <CAOMZO5BcMu_94qn4vhDgxmdWVx0N-mCD9wYTvAPbXaK45EUFBA@mail.gmail.com>
 <b6b82482-ec7d-4703-ad93-ccdd7a651b57@oss.nxp.com>
 <e9c56d66-b2b9-456c-856e-2ef01a009e16@gmail.com>
 <CAOf5uwktScqh0LrWTaz-MRA-tDoAVb9Mo8UhxDKz0dauO21QQg@mail.gmail.com>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <CAOf5uwktScqh0LrWTaz-MRA-tDoAVb9Mo8UhxDKz0dauO21QQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0052.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::14) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9436:EE_|AS8PR04MB7621:EE_
X-MS-Office365-Filtering-Correlation-Id: 8034a64f-4dac-450f-b8a8-08de274030c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|19092799006|1800799024|366016|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clhPVFdRZWxEZzJNN2poQ3V6eTV5Z0x4ZTA3MG9WbEVMdCtiOXNidmVnODJC?=
 =?utf-8?B?TllWSURkTUFROGs0eHlkdHNzMEt3QlV1UndXSFJ2bU5XUHppSnRaWWVUVE9R?=
 =?utf-8?B?QXo5RHpNRHVCTXhwWU92dWpwaWljNlEzdmU0TVUxVWhLT1ZmS2RjT2ViTWlu?=
 =?utf-8?B?aUhacmlxeG5aeVZCQjZOdmRxKytyOTZqSitRRG9veERxYlNabG1QcmVaK3A5?=
 =?utf-8?B?UU5qRlRvYk5IWkVPUkZBOXdqSjJ4Q1VOZk9DV1U2cnUyTkE2WTBKN040ODl0?=
 =?utf-8?B?TlBZMzJ0YzBWeXBwSlBXRXZZTGpUdlo5TnBNNUVQUmJXSkxaYjJEQ09FSHFi?=
 =?utf-8?B?U1JUdVhycGVKWXJPMUNDd2hZOGxISW83Ri84NmN2VWJ2QVl5RFVOZ3ZNeWhu?=
 =?utf-8?B?UXE5NUl2bng5dDBKV3JHcG56dW9aOW1yYzEzbDA4cmN2UDUzam5zTDRybVRk?=
 =?utf-8?B?WE9qVlQ4V3UzcmJST240ZHFmVDBRdFUyWUxncnJjaUhuWmF2aTF3d2ZvMG5Q?=
 =?utf-8?B?KzVRcHZpMWZXSjU3Q0ZxNzIwQkhrS0JpcWN6WFhXbWpPdUl0S0g5R0dOdFZD?=
 =?utf-8?B?SmtLeFNxaGdjVWVYTlNMa1FRTCtJeVJBcTNKU0lWYkcyOUJ6VHN4TWF5UDBB?=
 =?utf-8?B?cUF2T2dnQzI1eW9QZll3eWtISFZtZGR5YmJCb0d4VzJQKzY1OGI2V0pCVGI2?=
 =?utf-8?B?WmhnQkltaDZGeXYySVZRYVc2Nzg2d2xlMWxTMHFETmk4OUttODZXS0tpWXpt?=
 =?utf-8?B?SzVRcWp5QThMQmp3M3VwV0lUcTllWkQ2ZVU4NUl5ajRuaVpnNm0xc1d4NDNE?=
 =?utf-8?B?Zit6K3dQdm5vT0JodFlNK2NEV1RId3F2cFVyWFBkMFM3eVgrTlVmaUdydUor?=
 =?utf-8?B?RktFUGlNNmU4di9xc3VqSVc1R0IvcDhOQ2xjSzNKZUJYM1o0UW5QN2QrNHl4?=
 =?utf-8?B?cVQ2WUpyaVpOWDVTMTlkVkRmTnBvLzNMMGk5V0owb0NFcFd1R3EzL0MwNjlw?=
 =?utf-8?B?NmtBSVZGV09DRE1NVGNFbjJoMjRXVEVrNEtaUnk3aDlibldCQkVDb3FQcDZG?=
 =?utf-8?B?N2NMYVlDZGxWQzZvMEhjNlY4ZjZTMEl3ZUVkQy9YK2ZNYlppSGtuSktxSzl2?=
 =?utf-8?B?U3l3TXZzU1NLcFRsNW1mSllJY2FIMktTSitwTjdpRGpDQWV5R0E0SWdHNHMz?=
 =?utf-8?B?RzVQZGEyeFlzN1hocEJYWVVGUm9NYmN6VUZFY3B2cDR6ZytkOGg4ejFkbW9w?=
 =?utf-8?B?RGFNbVcrc2hCS3IvR2pwTTFLbU5qQTBSRGJYcnBRWlZubm1JWFBsdmNSbUtr?=
 =?utf-8?B?bGJQUDJXZ2NSRkQxU2FWaUJzRE10NERtc1JrZHpjeXF3a1lvY053cWsxbEpY?=
 =?utf-8?B?UVV6OWxRNkpSa2NLSy83dnVwTWkvb01JOUdwVUZwMVd1WUlWaHErRW1iVFJ1?=
 =?utf-8?B?TnJUWWRmQS9GOVVtckRLUnVrYnBsOHpsWHRXZFNEWHRYVjdwbktzaGZoVEkr?=
 =?utf-8?B?QlBCenNzSDl1MjVmWFI1VkU0eFZySXk0MEdNT3VjNFhzeDlqYzgyemhaakhL?=
 =?utf-8?B?cFJFajkxSE14OFBTVGxQSzZYK21vQWlwTGk0bzA2UnYrSkp5NjF0d0VZWkVo?=
 =?utf-8?B?U0JuaDlhSXdvZlBjVVhxNmJ4akVsSDJQM0ZPRDQrWUgzYkJLZTBIdHhmTlR2?=
 =?utf-8?B?YzAxNjJnOG8zYmNkUWdBUGtZUjF2RHdZR3RuTTh5Nzc3QytLRUZlK3AzeW5M?=
 =?utf-8?B?WlNlK1g4Z2MxOGlZb1NZb2loSi9lRllKMDFDN2JLYkhHYmpXWVJMa1lsSDF0?=
 =?utf-8?B?bnE1UjdCeUl0SW8zQzVKekVqcjVITENRSkRXYXhyYWQ0cFhoUnRlS0Vtazc0?=
 =?utf-8?B?WlIxTGVpQmNDbmErYTQzS2Fhb0plbHA2bjg3dEltUHBHZ0Q0UnA2MkFGOGhN?=
 =?utf-8?Q?7R0fWkbb7KMfV+lX3ly1ox1enzTnCk3Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(19092799006)(1800799024)(366016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGVVUGVucGZGZnZUb042OG9KME9hMitOK3ZCUVlhUFc3RjhiaVlkcEhTQ0VE?=
 =?utf-8?B?aGFYK3J0WWgwTWJUSVZaWHF4a01sQ3FOeGF3OXk4TDZydzh6Y2lRVVZzUGFI?=
 =?utf-8?B?eGRTYnNRSVNqaVJ6Vnh1U1JJMVFlT2RkOWJ6bzk4SW43U2VqNkQ4MlFZdmI3?=
 =?utf-8?B?b3dIVHppek1uTUtxUGJCQTM3U2llaGcvY2tyMnpDTTRpZnJOOGFFcHFWUTRK?=
 =?utf-8?B?THFOdkhkQUdpMFA2UlYrQ0xzcGRWOUFuRzFFcjc3VU05bWlnN3pGaW9IdEs0?=
 =?utf-8?B?R2w4bHNRaUM0VjkwZUdSK3B6cys3TVVvb0hsS3VuU0VWbHVINDFPU0tsTVhh?=
 =?utf-8?B?S3BsMzBjMzdGNVBibkg0TWViWFBqUGcyblQyRXhUNVJaZjVHcVBuVU94Um1u?=
 =?utf-8?B?TGh4SXpDSEtsVVRrU3E5TXliaEJXTitnY2xvUEp2NFl1QzRmTERxOHJjODhi?=
 =?utf-8?B?OVRsMTRRaWZDVmdyNGZ4NWxUeG94bGpoNkdsMzlEZjJjeW96U1JCWWkrNys2?=
 =?utf-8?B?c2VKdFJFU1pndGlXT3VIdzBYVE4vTjh4TUN5eVJGZUVQazRXR21xSkZ5cWcy?=
 =?utf-8?B?Q0plVjQ2Q0JRK2RMSXhSdDZSYjNtYlZ1K1JUcnJYTmpVTlY1MjhIcVRzeExH?=
 =?utf-8?B?UFpKb3Y2MTh3Y2c0c0NqcDBlbnNsREowOTNveEJlWDdBS0NtNUJzRjF2ejc5?=
 =?utf-8?B?dFczK1E1cDZIcnJzL2RiQzVGcVQzTHRKbGFNSCtCd2FNV2VFclI2clFXNDB2?=
 =?utf-8?B?di84cjhjQXlINmV5OUNrK2d2ek5temJQOWNRcVZYRTJkRHV2Wmx6ejZMQ3Fz?=
 =?utf-8?B?S056MEovbk5wOVRZQkx5ZXpxcjdqVmFLRWlKdk9DWkFvSFcyR2tHb1RSb2dT?=
 =?utf-8?B?amlLa3NlWkdXNFd2VlZ3cWprVy9qNjRaVUhiazRFbXBuVGtBSFAwYkoxYkRG?=
 =?utf-8?B?dlROWWx2UHhzbFJINkUra3hzUHMvT3phR1BXUDFTMVpBTkZ6MWFEcDVrR0NW?=
 =?utf-8?B?SU5TbjhNTVM5LzdEM2lFQWdOR05YVDI1QWpXWWt2eWJ0Qnl2M1B6U2hjdUor?=
 =?utf-8?B?NlA5U2ZrMGZXc2RMcmt4a0kzVEtkSXFlNlJ1M01HNzExS1JPbFZUR25XTGUy?=
 =?utf-8?B?Nk5jMUZiaGo0aVNEMVB4eHBHTS9oVDVQNFBtZFRqbUV6OE9aLzZCQnNGUEZw?=
 =?utf-8?B?ajJZY1FYbzhZUmJwcVRuZGczTmp2U2JVR0ZxY2dnODliSlZ6Rkh1RUZNVThR?=
 =?utf-8?B?VVMzVGlPVEFEZnovTmhHWEl3NkJIUUdzNE40S3lxSVR3amhodHRpTDJyU3c1?=
 =?utf-8?B?MzRwNmpxVk9wZmlzL3JYRHhLZEZKV3BHWUlqdzhLK3cwMmEwZWJmeWhGeHhB?=
 =?utf-8?B?SXpZeTJGTHhSeTRwd0xKVFExb2VsN25xOVRCRU1ZZ1oyUVFIeGlMRFBtclhH?=
 =?utf-8?B?L0syRDlmNzQ0WXRZclVnai9CYTlHYzltSGNpN3NYdTE0Zk16MFVkK2JwMEJ5?=
 =?utf-8?B?cm9DRjFyMG9pbjBNcFVvNncyV1o4NjhxVWtJYTI3cmVQSmpURkxjMFNIdFJ6?=
 =?utf-8?B?ZEw0alh4eGtaZTBCK3dHckdCWlBpMVNwOUQvR3BSZlR5K1dPZ2N5WlFIVWVa?=
 =?utf-8?B?cUlhQmN6YUJvMnlEYy9zOHhlT1FnVHFtUGhscnBKUGVFazlxTzE5WkJhbjBV?=
 =?utf-8?B?akorZndoOEVQenhnSFB0TE5scU5DNkUvMUVmN2ozNEloTEFreEpOY2Q0L2g2?=
 =?utf-8?B?UDR3QlcrdmRISEw3a0trTkd3c093Uk1VVzlOMjRHUnBJT2NjZXViVThiRytC?=
 =?utf-8?B?eE5KZTVZK3FGSDJ2dGNOZE5ocEpMRkhOK3dqL0NmRThXQkE1QlVQTUF5bzZJ?=
 =?utf-8?B?ZWJnWGJUbGdWaEJOK0pEZ0l1bUtiMmRVZlJCYmhKNjJROTdSV1hUSEFwMk5E?=
 =?utf-8?B?OVBCczhyRTRnaGVxR3RWczJ6RzhCNEhGRHJhVXVGTmg2RklTb3duUkFZTytw?=
 =?utf-8?B?Uyt2T1lPYlZVODVDcFljUTI0d0ljU2ZweUczOXFFaVp5UWN4Y1hWVjZuR1pE?=
 =?utf-8?B?RjJMN21Vd2ZFNU1vSW03a09OS3hYekMwbktSZGRsZUI5cVZxZkM2QU5oV3FF?=
 =?utf-8?Q?7n9h7I26p69o3RJzh/0sFA/VI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8034a64f-4dac-450f-b8a8-08de274030c3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 07:49:38.6990 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pI5Gh44mwokLRn3ReF3IfpDVPJPztL+rKAzep1dN0oQTXN9DyT0RouY7bAZvePX9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7621
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

Hi Michael, Emanuele,

On 11/12/2025 6:07 PM, Michael Nazzareno Trimarchi wrote:
> Hi all
> 
> On Wed, Nov 12, 2025 at 10:57 AM Emanuele Ghidoli
> <ghidoliemanuele@gmail.com> wrote:
>>
>>
>>
>> On 12/11/2025 09:16, Ye Li wrote:
>>>
>>>
>>> On 11/11/2025 9:47 PM, Fabio Estevam wrote:
>>>> Hi Emanuele,
>>>>
>>>> On Thu, Nov 6, 2025 at 7:22 AM Emanuele Ghidoli
>>>> <ghidoliemanuele@gmail.com> wrote:
>>>>
>>>>> Hi Fabio, Ye,
>>>>>
>>>>> At Toradex we have been struggling since quite some time (back to 2018) with
>>>>
>>>> Does this problem only affect early i.MX6ULL silicon samples?
>>> Hi Emanuele,
>>>
>>>      I have same question as Fabio. Are these samples are early? Do you know
>>> the time of receiving these sample? And could you show the part number printed
>>> on the chip.
>> It could take a little to answer to the first two question. I can say that the
>> SoM I'm using to validate the patch was assembled in September 2021. Let me
>> know if this information are needed giving that I can report the marking on
>> the chip:
>> MCIMX6Y2CVM08AB CTDQ2107 1N70S CHINA QGDQCTA
>>
>>
>>>
>>>>
>>>>> the temperature readings and the thermal shutdown behavior on i.MX6ULL. The
>>>>> issue we observed is that the thermal shutdown seems to trigger too early.
>>>>>
>>>>> I have investigated the history around this topic and verified some internal
>>>>> notes in our bug tracker. With this revert applied, and on the devices we have
>>>>> (all trimmed with value 0), the reported temperature increases by about 10 °C
>>>>> compared to before the revert. The absolute accuracy of the readout is
>>>>> questionable: for example, on a device kept at around 20 °C, the temperature
>>>>> readout was ~19 °C before the revert, and ~31 °C after the revert.
>>>>>
>>>>> Consider that for devices with fuse value of 6, there is a -10 degrees offset
>>>>> after this revert (so, the other way around).
>>>>>
>>>>> I understand that for Sven this revert improves stability during large XZ
>>>>> decompression in userspace for few devices, but for us it means that the
>>>>> thermal shutdown happens roughly 10 °C earlier, which is a serious issue in
>>>>> our case.
>>>>>
>>>>> I would kindly ask NXP to double-check how these devices were trimmed. My gut
>>>>> feeling is that there might be an inconsistency, either the trimming scheme is
>>>>> not backward-compatible (e.g. old and new devices behave differently, and the
>>>>> code should cope, I don't know how, with this), or this patch must be reverted
>>>>> (because introduces a regression).
>>>>
>>>> Peng/Ye Li,
>>>>
>>>> How does NXP suggest we handle this? Were the early i.MX6ULL parts
>>>> incorrectly fused?
>>> I need to discuss it internally, will feedback you later.
>>>
>>>>
>>>> Can the fuse be read and dynamically adjusted?
>>>>
>>> The fuse is locked by MEM_TRIM_LOCK. Emanuele, can you help to read it by
>>> "fuse read 0 0 1".
>> Colibri iMX6ULL # fuse read 0 0 1
>> Reading bank 0:
>>
>> Word 0x00000000: 00320003
>> Colibri iMX6ULL # fuse read 1 0 1
>> Reading bank 1:
>>
>> Word 0x00000000: 00000080
>>
> 
> As is clear this problem was the same we had some months ago, so we
> are on the same page
> with Emanuele
> 
> Michael
> 


Can you help to measure the VDD_ARM_CAP and VDD_SOC_CAP on your devices 
with high temperature read issue, when REFTOP_VBGADJ is set to 3'b000 
and 3'b110 respectively. Provide the measured voltage and target voltage.
And please read the Unique ID fuse of this device by "fuse read 0 1 2".


Best regards,
Ye Li

>> Kind regards,
>> Emanuele
>>
>>>
>>> Best regards,
>>> Ye Li
>>>> Please advise, thanks.
>>>
>>
> 
> 


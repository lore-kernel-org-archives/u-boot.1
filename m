Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE2FCFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 16:20:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 650438398D;
	Fri, 28 Nov 2025 17:20:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DcP6u1rB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D66183A26; Fri, 28 Nov 2025 17:20:42 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 203E0835C6
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 17:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdxOEgl2nJzDok+ELU2QSvHirFpszSRWscFb0KODkKC+4pj3HBdxa86qgU2B+azddz39gtKkrBZhKvEuBJwzeg5hL3tOTS4dsTDCWFMl2Z/ix/rfuFOCHFAfNNE/G1euBRzOIIzOyX6tAliz7ywXTiB3MPTcHpYlsM3JMmo/EnCzzTZzSgjtvP1D8FJBGb/b5XQjL8btBVjT0mFLiRv0CA5MZ9qXMyma0dpbjmX9JdZaFGAPchSLhATExKtBFqwAJ922rrsG4qzM+cwUlXuJXaDFgPHe5RwGQqu5F4RZud+LADpg3XGtrqikDEwEzBXIWiMRdRQSTNYnzM0q7piWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JWMMPeSMlb6vBHekqovZKyU9TNudhBj1zT4YIfVg0DM=;
 b=QSBhQt1hrbHYUP9qm5OxMLZ0f0k6jzR+dNDWcN+wp9THmPtLt5gFole3vBdfsKJYZtH4140ZAiW3g1tk1OAzQvcKTnS1eGL0PH7MIneOtEl5ZJJ55vBAfZcx9x6m6Aj15FbGIU6eKTREdeofpHAsKBM4Z0JHUfjypK3Bs2rLlQMjuID73JebyyFQuR1yGaKVCgtzu4M9KL9Q9rXSSxQhj/77LjbukHRbYYftmPr+QrFEMB3a0oS7zBeHdHRS5E6i+Asg5KYU34E7ouzhZZ0BtGMER5r6oTkhc1dBOLIhpzgQYZ+DXRY8djEwX//pAmap1m2tWgGB2gmEhUb1TLUE9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWMMPeSMlb6vBHekqovZKyU9TNudhBj1zT4YIfVg0DM=;
 b=DcP6u1rBhNV/QLjlDmedRD0KNEGpZZis7YT83EVV5YufGmvQAzwAYNzeSwdrH8Qzkku9LSzN7+sIX4Nu/BeQWGyVjxBP3KmkBrqoMzhKuzXasJP1PJFw0MkB2Qli0cIOAjXzMug8qN7D3/9zTX3MQT2cJ4JlNYj7NzstZhfEX3C/k0LSxqmwRLHrOGrou3eZHj+DInrjYgbqEn8v2qJ/tzB4lHDlP+rEYTeebBmlDibIpzbMmk6UrixQ5g5+scmAqb5n9FidwKZ27bOy8lYjNOqLtX1E9JYS1Pghpp9/2k1Ql3jCi9QmXrI0UwtWJCwpUpLYw9rRK7IAsnWfv3msXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21)
 by AS8PR04MB8312.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.16; Fri, 28 Nov
 2025 16:20:36 +0000
Received: from DB9PR04MB9427.eurprd04.prod.outlook.com
 ([fe80::34e6:ceed:e6d1:184e]) by DB9PR04MB9427.eurprd04.prod.outlook.com
 ([fe80::34e6:ceed:e6d1:184e%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 16:20:36 +0000
Message-ID: <dfb31725-489a-40f9-b75e-785eedb67dd8@oss.nxp.com>
Date: Sat, 29 Nov 2025 00:20:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx: container: Eliminate IMX_PQC_SUPPORT
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: fedor.ross@ifm.com, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <joao.goncalves@toradex.com>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, nitin.garg_3@nxp.com
References: <20251127192633.79935-1-marek.vasut@mailbox.org>
 <3da2565f-523d-47df-8202-0624bf0a445c@oss.nxp.com>
 <b44cb7cd-1c07-477c-8233-03d029266b7e@mailbox.org>
 <541c6616-224f-4b92-a980-a43ca159804d@oss.nxp.com>
 <34e3984c-f39c-4955-b6ae-045ce6cf38f2@mailbox.org>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <34e3984c-f39c-4955-b6ae-045ce6cf38f2@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0005.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::15) To AS4PR04MB9436.eurprd04.prod.outlook.com
 (2603:10a6:20b:4ec::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_|AS8PR04MB8312:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a16ec38-dc5b-4d88-6a8b-08de2e9a0f24
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|42112799006|366016|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?azFub2xHYkJOTEQxQTBscldTQW95S0JoTmxtVmpvQkp6Q2oxSzEwMTlsT3Ji?=
 =?utf-8?B?d2cybUVCUlpTMDBZV3VwWlVCNDcvKzhwRHN0VjVabGszK3Byb3dMSjNmYlF2?=
 =?utf-8?B?VFpZZEZXTEhLZmlXdUFkQXZTZTF2ZVR5SFZldWR3OEJMaGp3eUFBTXVueDF0?=
 =?utf-8?B?RVY2OXNrdzdtbkdTV1lUL0t3aHJWRjFuOGZrbXpHK0xwckQyUExiTko0bVJl?=
 =?utf-8?B?cDU1aWNQMlY2em9MblF6TFVET2c2eGNuMllsL21MSktlNmRQNjFYMlkxanRO?=
 =?utf-8?B?K0NyMGY5WVZWNS9zcFZqYk9aUUttOWY1a3J1enRYY2dNYzFoZDFKWFIwQnEx?=
 =?utf-8?B?bFJlSHJESzc1aFZZYTJoRmxnaEZ4VTRoQ0FyTzZEaXBIejlnZ1U5dG0vQjVP?=
 =?utf-8?B?ckoyRnVibXJpUy8xcFRZT1ZtVEFOWDBSNXl6UGRvM0k2T0NGazRHZld5WGdY?=
 =?utf-8?B?TWMxUUVLbERIYm9NWWRGRnp4Yyt4ZnE5ZktEZGZ6OTd0VVZFUE1pYlQ3aWxl?=
 =?utf-8?B?eks4clRqTGVrK2lhN3Y2Rm4ybzhtcGhNVHVoQnJ0QUJkQ0F1dkFIa1Y3cURx?=
 =?utf-8?B?SWVpMm9wKzJIOTBGdlgxdlg4OUhsZCtHUEpJRWFuTzYxalY0SytDUTY4ZkZS?=
 =?utf-8?B?TG5IdkdSdFhUOVUwNENibWMvc2hERGRDMEl3MzJIaG9ZVUJjREtYNUxtQnBt?=
 =?utf-8?B?RXpLZmUzd255NGllaElVZVFXOVkxMEhucXdINUZLdU1zalUwY0ZZSGhDbkhm?=
 =?utf-8?B?SC9CRlZJOCtMcFYxbFVSbk9MdHJLcmV3U3VRYVdwOThiQWN6TllTWVFSQ1d3?=
 =?utf-8?B?Vk9sU1FmZUFnYkVOSVlreHkzbkUwYWlLcFZicUJqOU1QOEd5alV3UGpFUDZa?=
 =?utf-8?B?Y0lnUkdCd0l6UGVUS09uNU8wUlAvQTBrRm8vTkFoa3NUbnFpWmxwV0FQa0xl?=
 =?utf-8?B?Nkdta1haZVdRU0tqQkkxMTFnZFZsZG1FQUY0L1VlK3hXdHFLSkVuRS81SmZJ?=
 =?utf-8?B?aUpMSFFzeTc2SExkV1k4NXdtaFRHeGl0bTRIN3ZGb0ZSMEdNRFh4TUhwYkVj?=
 =?utf-8?B?UDY2MjAyUkxZRm5XRU1nZEVLV2xEcEp4ektkSWxQVWRqMkUzeUo0TkNIcExw?=
 =?utf-8?B?WDdEZVFCL3czdU1NVS9ucVVUMmlTRXQxK2tFSmw3Q1Jnb1JCYXI2cGxCYzVi?=
 =?utf-8?B?WVF0MU1iZmI2Tk5ndnBOcVlsRWMzRG5VSnEzVTdHYnhFUnhIajhqNzJTb241?=
 =?utf-8?B?NEcyWEtLcTdmWXBMWVdhL1I1OFoxVE9Lc0NBbE00bmJRQmZTZTJqSHl0WjFJ?=
 =?utf-8?B?cXByNjB3V1JGZDkwTVJudkZmYVlZdjlwbXZ2dTh5MEErNkk1VWZabG9HTDdr?=
 =?utf-8?B?a09WNWR3OFJmL1hocTNZeWlkcnhxMDFjdXF5TS94c3Z5QWg2KzFtaWwydWZm?=
 =?utf-8?B?RW1WUnJ4dUtNV1BSY2ZTdmcxb0VhYzRzMEhlblpCcnpFaElLdmNHUWZQTW9s?=
 =?utf-8?B?SEV3ZjZVbE5KL1daUXFCVVRZSWVpVWZ3UDE0YzdQQzNLRTBqYTMyYWkybUtr?=
 =?utf-8?B?dnhkRFhURXRXalhDR2RXUWt5eE5PNzJEZTVSOTNPN28zanpQRlBGMjdkamZu?=
 =?utf-8?B?Y2lTeCs3dm0wWHlZdkZXdHpoeUlXaFFxbzVHVmdhWmVnZHpkdUZLbjlhY2Nl?=
 =?utf-8?B?dno2V0FYRW1rY3ljdDFLU1NlSFI4SXN2RXdrUWU4dURMcHlPa0hvYStuU2lC?=
 =?utf-8?B?RWdlcHRyNWFsNXVWNG1HYTNoQysxQ0RKYTZHYVVOUmUxam1zektUb2FsRnpH?=
 =?utf-8?B?U0xXZWlOZ1J0Q2ZPZU12VExPQXhEanhBSmMwS1drY2NSYkkzVUtSRFN2emlM?=
 =?utf-8?B?bGNDQ1ZlclpBWDB5YmxXc1BLR3dwcUtxY2RXV3YxZ1N5OUZ3WWwvcTZkL2RT?=
 =?utf-8?Q?mIisD6iaX/nDsUaOWX0bGFg7sjD/itl+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9427.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(42112799006)(366016)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEtLalNvUk5FRnpqTk93dGlpQTF2Yk10aVlERUp6T1FaQ2wyL05QbnBTN0Js?=
 =?utf-8?B?YXk4R0NBY1RNYm0rL0t0dWc1N2d3Z3JkYzAyeVMwNHdqTlV5UlFONFdaZEJG?=
 =?utf-8?B?N2hBWXVIemY4eWI1KzFWYzY5b210V05KbFNIVGdIUmdZdFAyTzdweDIvcHZ1?=
 =?utf-8?B?TitDUWh2U21ka1NMRUZNMGJRdkJVREQxQ2E1a040K1kwdUlKNE1CK2VtUXRu?=
 =?utf-8?B?ZThYYU0wRC9YOTB3bEVlQm1jTmliTExZemlVNnIzeGFsYVpnT0Rjbkk2YXhW?=
 =?utf-8?B?bkw0endYUitCMGhqVHJrdzNpUzJVMGZkQkNVdnd0SllpYmlBK0dCRWtxbDVl?=
 =?utf-8?B?NzFnV0tBcEJIQ0hnZTFIWWhDVlUzZzZoNi9vcEt2SUhLR2FuUVQrSGZnTlBY?=
 =?utf-8?B?cUtUNlR3Kzlpai9TdnJSMEhhZ2dKajdkdGsrRXU3OHlGY3B4c1RUaktMMGha?=
 =?utf-8?B?UVo1aUJTbGU2MzYxOEthZ0Y4TU8rVnI4YlBpTmVmR2MrSnUzYmxPMWcrRDBu?=
 =?utf-8?B?cnZTU2xqYnNWZ2hUaVBabVUzY014L1dhaGNndVlqT1hYM1pTSjlzSUdLa2Rz?=
 =?utf-8?B?cEVWTURKT0g1eFJTczN6UjZielJYNGdhNjNteU5QMkNMN0ovUmlBUjhYQkcz?=
 =?utf-8?B?UlROOTVUSEE4SGFjcS8zNm9PeUZ5ZzlId0NJQStwMWFBU2ZLL1lSd2d0UGVH?=
 =?utf-8?B?YStVNVRiSHZoczRENm9qOXFYbi85TnhkR0NsQ2c2NVdEdTE1THpRblZENmZr?=
 =?utf-8?B?RG5MbnYrSXRaZ3JOeGNJR0ZiMWlYTDlYS0J3blpHSTBNS2tCdDErZjFaeHJD?=
 =?utf-8?B?SHVMRkhKMmx1bXgzM08rbWRvSnI5TlkzMGg0QkpuNUJOZmRiQ0l1QUV6ZWtr?=
 =?utf-8?B?N2JnOGxJTmwyQ1Y4d01seDJwdUxETVU2ZUFZengwQUtlZWlxeE1UQlVKYW5i?=
 =?utf-8?B?WlQ3WXZ3dTRsMGF3VjVuTDEyMWxLeXc2elZCY1c2bGs4a1Z6Mk1uMGhxZmRG?=
 =?utf-8?B?MC9pdW5sOU1aSGlXZEdOeDgwbktaWjR4T0RXQU5VSXdUdDhkbE80UDRzVHNk?=
 =?utf-8?B?T0pMTmhtZW9qNmhVb0p6TUh5bmg0b2NUb3RvNHY4K1Q0WjBvRm5XQS9vVWYv?=
 =?utf-8?B?T1F5clZvVDZJZWsyVFBWSDcxa2V4ZUt3SVZnWTRqNVNGV0FodGdSbmRXNXFj?=
 =?utf-8?B?VUpPVEhYTjF4ODV2V2owakcxREIrVlFEMGJrRitzV3pTSDVQWU9rTUhJaUY0?=
 =?utf-8?B?TjZraFA0YkxWcWRiVFkxazFjRzFyZXdheFIyR2ZwcHdCYjU5YzFiSEJRU0Vi?=
 =?utf-8?B?cEFHVmxPcmdYZVlQSGNFNnc1TVFCNDAwRC85Vjh2MVVBMjcrQzAvTVA0UmUv?=
 =?utf-8?B?U2l4YjIxODlGKzdvNUpWbHI4Ui9CemxJT0tIcDIrV1B3VmtFdWlTYURiUmls?=
 =?utf-8?B?cWxqL052ZUNNeW45YlR3aUJBd3UrZGU0M3EzWnFkYzFFRUhBUFlSbnh3UlVt?=
 =?utf-8?B?WnZJM1ZLa3hDNTAyVFhyUVh4dXFDRjk5SzFQN3lWSFhrU3pZZytqR013UlJC?=
 =?utf-8?B?cG0xQkhYUlcxUFVLT0NHRDd6Z3J2OTVXSUxJMmsyK09LWnBWQVhqUXNtZ2Nq?=
 =?utf-8?B?MDFBbU5SNkk1dFh1Wlh0Zy9wOTl2SFBremJUZUtqOVNkOHZJOE13RUY3amJT?=
 =?utf-8?B?N1pQSzZFTUhxWVF3Q3ZaU0pGSW5ob2prU0FEY1MzQnhFUHk4ZDRMZ0toazEz?=
 =?utf-8?B?Y2l2UkE5ZlFSTjVIWjJ0cHNSclhjTnFsb1lNRzhJdHBSckttTlVXMVRZZWQr?=
 =?utf-8?B?NERzZTZFMHpsRTA0alJzNWM4alF0WkNML1pCcWpCOGxjd0ZWUUo4R0JHRmhm?=
 =?utf-8?B?cWZxcVVjeGptWkJmRTg5ZzNQMnd3VXZVQ2hzajg5UUs2Q1p5ZW5YYy9NRkRG?=
 =?utf-8?B?aVZnbXlBK3BMaGxyVkY1L0NhQ3JhUWIvWGdLV2RxV2g4d01DZlhkWkNFaXhO?=
 =?utf-8?B?dE5OdHlMTmVUZUhZTHJ4cE80NjhNK1ZwVGRqUjVrUHlzM1FPL3FHcWdKY0F4?=
 =?utf-8?B?TzUvQlpKSUphOXh3NGtmZzZvbVRzejlkQit2YklPbXJLdGpwdm9NOWJsRXRo?=
 =?utf-8?Q?upM+SobiXr62id0LnWotw0asU?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a16ec38-dc5b-4d88-6a8b-08de2e9a0f24
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 16:20:36.3329 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8c6DAmQw0XuvrddWJ6w6RnbufxRbE6/JoHUWAWZlA+KXcetgLha4J9C/V+ObZj7w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8312
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



On 11/28/2025 7:58 PM, Marek Vasut wrote:
> On 11/28/25 6:31 AM, Ye Li wrote:
>>
>>
>> On 11/28/2025 1:09 PM, Marek Vasut wrote:
>>> On 11/28/25 4:26 AM, Ye Li wrote:
>>>
>>> Hello everyone,
>>>
>>>>> +static inline int container_hdr_alignment(void)
>>>>> +{
>>>>> +    if (is_imx94())
>>>>> +        return 0x4000;    /* PQC */
>>>>> +
>>>>> +    if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>>>>> +        return 0x4000;    /* PQC on i.MX95 B0 and newer */
>>>>> +
>>>>> +    return 0x400;    /* Non-PQC on i.MX95 A1 and older */
>>>>
>>>>
>>>> I understand you want to use single uboot and spl image for A0 and 
>>>> B0. But A0 is not production. Only early customers get few A0 
>>>> samples. NXP marketing has notified these customers to replace A0 to 
>>>> B0. Are you still using A0 board? Is it necessary to do such change 
>>>> as we want to remove A0 to simplify the codes?
>>>
>>> I have both A0 and B0 device.
>>>
>>> I do not see why we need to have a Kconfig option for something we 
>>> can trivially auto-detect, hence this patch.
>>
>> Yes, it can auto-detect. The history is we dropped A0 when upstreaming 
>> B0 support. But someone from community complained A0 broken and 
>> requested to add back A0. Using static Kconfig is easy for removing A0 
>> in future.
> 
> Adding another Kconfig symbol and ifdeffery seems easy, but it also had 
> additional implications -- more code paths because of the ifdeffery, 
> more Kconfig symbols which the user has to understand, and another 
> machine config has to be built in the CI to cover this configuration.
> 
> The auto-detection avoids all these problems.
> 
I agree to remove IMX95_A0, but I don't suggest removing 
IMX_PQC_SUPPORT. For each SOC, supporting PQC container or not is 
definite. Adding runtime detect is just for iMX95. But iMX95 A1 is EOL, 
everyone must use B0. And A1 codes should be removed.
You said you have A1 board, could you share the board name?

>>>> Eliminate IMX_PQC_SUPPORT config is not a good way. When adding new 
>>>> SOC, developer has to update the container_hdr_alignment, then it 
>>>> will be a long list in this function. Actually only iMX95 is the 
>>>> exception. If you insist keeping A0, I prefer change like below and 
>>>> retain IMX_PQC_SUPPORT.
>>>>
>>>> #if IS_ENABLED(CONFIG_IMX95)
>>>> static inline u32 container_hdr_alignment(void)
>>>> {
>>>>      if (is_imx95() && (soc_rev() >= CHIP_REV_2_0))
>>>>          return 0x4000;
>>>>      else
>>>>          return 0x400;
>>>> }
>>>> #else
>>>> static inline u32 container_hdr_alignment(void)
>>>> {
>>>> #if IS_ENABLED(CONFIG_IMX_PQC_SUPPORT)
>>>>      return 0x4000;
>>>> #else
>>>>      return 0x400;
>>>> #endif
>>>> }
>>>> #endif
>>> This adds even more ifdeffery and makes the code even worse, so no.
>>>
>>> But if you are sure that every new SoC will have the PQC alignment, 
>>> then the condition in this patch can be inverted this way:
>>>
>>> static inline int container_hdr_alignment(void)
>>> {
>>>      if (is_imx95() && (soc_rev() < CHIP_REV_2_0))
>>>          return 0x400;    /* PQC on i.MX95 A1 and older */
>>>
>>>      return 0x4000;    /* PQC is the default */
>>> }
>>>
>>> Are you sure every new SoC (at least in the foreseeable future) will 
>>> be like that ?
>> No, it can't be guaranteed. And we have legacy SOC like 
>> 8QM/8QXP/8ULP/93/91 using this container without PQC support, above 
>> new change will break them. Please consider keeping the 
>> IMX_PQC_SUPPORT, so every soc can select it to work.
> See above why adding more and more Kconfig options is not a good solution.
> 
> I believe the original implementation in this patch does not break the 
> legacy SoCs ?
Your original implementation does not break legacy SoCs. I mean the new 
change break them.

> 
> If you are concerned about growing list of SoCs in this function, then 
> this function can list the five legacy SoCs + imx95a0 SoC with non-PQC 
> alignment and by default return PQC alignment ?

I can't ensure no new SoC with legacy container. From roadmap, there is 
still some iMX93 derivations planned. This way is just better than 
original implementation in this patch.

Best regards,
Ye Li

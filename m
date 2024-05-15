Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D18DC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 12:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97FFE88250;
	Wed, 15 May 2024 14:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="Hy2zk513";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A713388306; Wed, 15 May 2024 14:41:39 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E518880A5
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 14:41:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dHVHvjR9uxGH0wmdgp9zG73DpnQQ/gi6ReJDOBkF2xLeVS+0mgbbwlaVIO3sfH11eR4DJNqXSPIfxHCA/Me5JPhWR0r+R72JKY+QT2u749k3brg8vSshS60mGFm08INi0XnV35f/2Xegw8nxS+fBU0vYWkANffdp/yvh/ZJG3dpsqLrImE/u7zM10frbubGnWo5XmkaMaAJTIhjmLEbKEHMvBMFagiLkyM6z40hsQbntw/Ho95K5a1lKHyElkNg0scCsC9v5WAME7hQutGJHeRPVQ0DlbgpAFulJdKf1ZTBvZAOOFmA1jYvV4qlsKJDOfZV0b9sLpBvL10S67TykxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx0AFP95IkB8BK5AHq4Ef9Y/vrLPBm/B2UTsoRlhbls=;
 b=R4Z8IhWD674diCNMIYe0QYtldTJGknGyVY+LQ4k8OkHRC3zTslgKWKhzaXpiT2OjV18dw4IPMVfNNx8M1UAlVS6F3prljq7wJvBUuOfNwezlEXjb3Qt52cSJH1/6bzmz2lX9sYvylBJbWEDAcrcZDWokaDHBN4eVQkYRc73OQQwYzM2/bykfLPc5oOmbcdijIvAg+IKY5hjwOZqi1bPxt8dLaRN7Z468Vy36iuHHCYqnYA7RgRXFBAaAKd8MUBLRAKs8c3f+uv9N8XcVm44WIXjIiIyb+DSnCLzR9Fcro/MnnrCVR3g6xBSEtD6COKSuEB5+q6DYTZcjOI1ZVG5tIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx0AFP95IkB8BK5AHq4Ef9Y/vrLPBm/B2UTsoRlhbls=;
 b=Hy2zk513VKa93mThJDnRHqAIfBjymfdI3amVzfUUbET0fpaPBLL6n47BI1wUuu7ukxauyY5zQ+O7AuFKrkNcf25CzqEVayjEGFs5dGLI6Quasxt8Jm1eX13DZFK39re0TETmfR1vmQvMgvvbnk4/+zf4oeBS5xhDp9tX+kPJ9mQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by AS8PR08MB8900.eurprd08.prod.outlook.com (2603:10a6:20b:5b5::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 12:41:35 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::aeb:1738:d59a:cee6%7]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 12:41:35 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Stefan Roese <sr@denx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tanmay Shah <tanmay.shah@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Wan Yee Lau <wan.yee.lau@intel.com>
Subject: [PATCH v2 0/2] Add eFuse access for ZynqMP
Date: Wed, 15 May 2024 14:41:23 +0200
Message-Id: <20240515124125.732487-1-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|AS8PR08MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e0b797-8029-4494-df6f-08dc74dc5b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|366007|1800799015|52116005|7416005|38350700005; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlVac2YrRDI4NXVCb0VQYytDMnhTVkpuUHFtdUFRMzlIbXgvL0IwcEovNlZv?=
 =?utf-8?B?N2Y5ZXk5QlZRY2Q5YkttKzljRGFIRG41VG1UdG8wVWh1eDRKNVUrNkE4RUdM?=
 =?utf-8?B?Rm9FQzVHdUxrR1g1OWVYWFJMT1FlRC9ySXNYMGl5VVpNWjh3eWZGWU13Nm5S?=
 =?utf-8?B?cHdUVXJpTHhleW03ek1GY25Zb0lNVmZUNlZTWk0xR3VZa2kxUzJJeHNiMjlQ?=
 =?utf-8?B?VCtqZnRmaGpOc3huTG1wUjROU1h3ZmlDTU5qRDUxTEZwMWFVTDBIZVlNMkM4?=
 =?utf-8?B?VzVQdkYyaysyUG1id1Y0RVpNdU95eXg1dlJoYU5JeW50RjNMdFFWNGFBUHM3?=
 =?utf-8?B?TmlvZnMvMmhPSW52SXgveHd1N0lRN3ZtTjVwSmNYK3BmaHF1WkxDRG80VkhQ?=
 =?utf-8?B?ZXFDeVV6dVFnMy9oUkQzcUdRY25iQ2FJZE4vZlV2aGpqZ0xwc2l0S0dWSkRV?=
 =?utf-8?B?SlZVZVdWcjd5MXdGYTJzcHFhOFduc1I1dWZyV0NuaC9nQksvT1dMOEkrU2pS?=
 =?utf-8?B?d3AwL3ZvN3FKK21CQi8wcG5TcTh5TXhocVJLZHZ6T2pPeERKdlpldHVQTmEw?=
 =?utf-8?B?T1pWVkkvblBjVE1NNXpFOGVnK3ZyL3U0OFM3YWREU2xNNGJPUlB0Q0RSaEh0?=
 =?utf-8?B?a1BTU1IwWURwQTF2KzlqeVlpRHk4RkdoendGS2t1NGxkczU5eExJaEtvQ2k0?=
 =?utf-8?B?ZkFyellsSE5nUEVkdXJIN0Y0MjN3Z3I1RkNRWGVzM0xTeWo1WlN6TDYveUZJ?=
 =?utf-8?B?RzNhLzVucUxyWUEyZXNhQUl0MWpJaWxSaHV5NnBTNFh4WFJibUxreHVFZXBL?=
 =?utf-8?B?U1pSRXlERUtKRkcrR2ZHa3BNWVZFUUNTcWxaaFkwSlhRNEd2QlBGL1FTUHRZ?=
 =?utf-8?B?dVRPcDFQdC85Y0d6bkNqQmxCTDJVUHZOSHNGd0pxYlR1WkhsNU43YlVwOWFx?=
 =?utf-8?B?Zm1iTU9yb1BOUzZGZWhucWdha0tLRzc4ejJMVmFRUU1oKzI4bWZkVXpteHFZ?=
 =?utf-8?B?NWVzeFNLR1dRSHYwcVZTL2NrQUYxa3llYlROY3dXUG9vTTZma3JaZ2pOSm01?=
 =?utf-8?B?U3NLb28rMW51U0tMUnZ6dGJESlhpQVBpNGZvbXlidDdZRzVqVUpUdDNjMXJu?=
 =?utf-8?B?LytuS2Yvb1ZGZzhudkJyM1loUEd1WjJiSmFXZjFqdXZ0KzlnQ0FMWk1CSTg0?=
 =?utf-8?B?RG5QNy9VcFdNd1M3L3ZxbVdjM2Rkc0JkcEhRQ1ZpdlJSN1VNQjFGZjA0MlRI?=
 =?utf-8?B?YzBGMkFnaXlzVkVLMWExV0FGQzV2RENNclNKdVFPbmt0MDZZbDc3U3pTN2NN?=
 =?utf-8?B?bUVqRnVFSmliVklrdWlFKzBvTkp4eURSUUpWWEhhM0I1T3p5K1daZEo4U1ZS?=
 =?utf-8?B?RVI1cGs1MkphUEMxOHlzUlB2RVF0SitCSEd4R09UUUZMb2ZtWGVPZHJXL3JC?=
 =?utf-8?B?NFpXa0JsNE5HNXFsSnE3Z0pJTlZpYTBVTkdvVHMzVGViM2x5K3ZoRENSMUgr?=
 =?utf-8?B?eFRoWStudFZpMHF1anV5b3h0Y0M4MGhYMStmNmJ6cE5IQ1lRbllSSkJDTERQ?=
 =?utf-8?B?ak1DdzM0ZmZhMVJxbFVTZ25mWEpVbmRKUlMxTmdmdFoxcFlVNm9pNkZUUnE1?=
 =?utf-8?B?NVFXc3RoN3loZVNPQTFtOTFLUDFYS1hiL05ZOHdaRkM4eXlMOGt2Ynd1Nlg0?=
 =?utf-8?B?MHRDcFJXQ0VxYXFlMTFFelRLYVQ2U2I2dkd5NHV3ZjdFY2ZkUkw0QmNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(52116005)(7416005)(38350700005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0ZMdDVGSUZndjNUQ3JPT2JTWG1WZno2M0tTUTBDcFMyd2U0ajQ2ZVRFR1Iw?=
 =?utf-8?B?a3NnUEVUcm1aVktCajZLN3lDYkI1cnBJTlZkeTVSdlNqNXpVejltV3IvWmFI?=
 =?utf-8?B?RnBRLzM1cDJxTHFwNitVME8rUHFpY1VSb1V5czV5U2pBNWNFZHQ5Z1lxRG9W?=
 =?utf-8?B?Z05QUXFUTVpla1gxa0VvdFUyNXRickZlTSsybVA0Qm5kRU1tT3NJR1puZjMx?=
 =?utf-8?B?VmV5dEJqakhwS3ZjRGRvQU5YTTVOdEgwcmE5Q3NLd3k2cEV5YXE4b3ZLaXB1?=
 =?utf-8?B?SU5PMWd0amNTSC9WWGFiMlRqT1QwdXhpb3RJWFhrOFhmdTlERDZRTXlBS3cy?=
 =?utf-8?B?TmZPN1B1UDB2SHNuYk5Bd2RIeDc1TU8wNXpYSUYzUlErU2tzWENrcmsrNElB?=
 =?utf-8?B?MVBlWUhLWSs4TnRLZWFQYlZLd2t5U0JpME4xVlcwb0MzaW1iOTl2NGlidytK?=
 =?utf-8?B?TXZkRVliOCtqMlRvMTdWTlhzeWZBUnoxTGVVNkI1NjdZbFZFeVY3aDhxUXZH?=
 =?utf-8?B?Tit6UHRLL05tRzhjNTFSa0dEVjAzOEVDUTdQZThueWhZa2YwU1VjbDcwdVBZ?=
 =?utf-8?B?b1RVMy9kU2dUdzI4a1ZjV1AxdUMrU2ZobmdPZXNhTlQxRXVnWHlxL2FWVUZF?=
 =?utf-8?B?RE5DVG9YZkxOMmtsekNCMytGNlJJSGZqUWtoUFZQZ1hIN2FPUW9nbnpYcmFL?=
 =?utf-8?B?eTBMQkNlbk9hTXhSMVA0U1lDc3c2YkR1S08xZEF4R25WR3Q2UDY0cXRFMzYr?=
 =?utf-8?B?d0pFOHU2U3JNc29sOGkxWCtRRFhRRHJYRWhZUzQ1cXpiQUtBeVVTZ3BGR1Rs?=
 =?utf-8?B?NEViN3dtZWtjQ3ZNcU8wT0c2ZGpqN2JPbXM1Znp6VXdoS25zYjluMkVrQXps?=
 =?utf-8?B?ZzVxZ1IzL1EyVjN3TVVBTU5XMDJXZk44QTB3UzlLNlBmc0RwQUU3Y2ZzLytt?=
 =?utf-8?B?WUEyUXNMU09zTjNxYldlR0YwdnBwaHowWFVuWkNYempaT3lpbVQ3RlBwL0tJ?=
 =?utf-8?B?bmxEM0RkNjRxYnNyNDBMVDVQdWpMK3N6ZithV1lwbXFIYW5aV2RiTmJtMHgv?=
 =?utf-8?B?ZFdzUzkwUG5YVEhzRjBpZTAyZHJDWWpZdmtUcXlGc0wwdjdOTzQ0ZlJlMFBB?=
 =?utf-8?B?aVh1ODZQaGFNcm9pL3l6Mk5ndmhlVERFMit3MHUvcDFudUY3Mk8ycHl6ZlZw?=
 =?utf-8?B?eEJMYXhjY20yb2k0UkdyWmpmOHc0R3NqM0Z0b2ZNQ20ydW5uR0xXZnpDbWxr?=
 =?utf-8?B?VVVVeUFLcUI0ejlWMnpyRVdGd1BvbzcwNDU1bVFkSm9UdVEwdE1zMnF2dHRi?=
 =?utf-8?B?UkhibnZYbHBLZG5weVJ4UmlaM0d3clRsNnVYS01ZdFNzb04vRkV0U3FURXRT?=
 =?utf-8?B?RUhxc0hNRUZvWFRlRnNjOGxrWUVzc0F6TnhFdzdOSVpBODZDbUpGR20ySitS?=
 =?utf-8?B?YkE3eG00R2cvZ01Lb0FkUytvY29EN3FzYzMvSnE3Vk9GanlVZXozRU1hTk13?=
 =?utf-8?B?OE4xaHFFbXI0a1FtWXNiOWY2RTVOYmFCMExjR3VnZmVRUDdSamlLMGd6SlVI?=
 =?utf-8?B?VWZWcTVPMkpvV3pUclhrcm55SW9Cb3hoeXdQOGdOaEswcEtCY3oyZWVoQ1py?=
 =?utf-8?B?R1FWT0pac29ZK3BUREZLd3N0UWFDQlVZZUo4bDFDSzFSd2dFS2dGdEFLeGxF?=
 =?utf-8?B?YitpNjYvVmUxV3V3WnFmSlBkR3NZRUdrT3lROUkyT1NjekpZTTA1M3lKZjZ4?=
 =?utf-8?B?RkhCMXlHRytwaWpkVHBCVE5uZGN1dWUvMkhGek5USmphSEpQUGtqMjl2UTNZ?=
 =?utf-8?B?WnlBc3BNWDBIRTRXNm1VY3FSVmhaeG4yZXlvRXRLQlRxbkl1RjZuOXFuWitZ?=
 =?utf-8?B?NmlKZWtndFNmWTVLUVJlNjVoc3hhYzZBTmVuMVl2aHB5SENzZENPU0hlV3M4?=
 =?utf-8?B?NEtZaSs1QVNuWTU4NjIvcGtHa2RiM1poVmlsT3JmL21wckNnTHYzZis3Y2w1?=
 =?utf-8?B?dzIyTFBIbTRubUZBZHVZdVNEa2hUTEVQT1dpVDhEY2FZNXFwZW01UXgvQXdr?=
 =?utf-8?B?Kzd0MVRtUUsvbkg5QjJaSDZNNUNPZjl5bnNPVkVWbUtOMU81a3lpNm0vQUpw?=
 =?utf-8?B?Ung5TVZKQlppTm8xL2hpWWJWQ0N2Q1d5UGViK1hjdDlOQU53RVZiRTNjbExi?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e0b797-8029-4494-df6f-08dc74dc5b6b
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 12:41:35.6637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/qRORkzRIWNvmC4ZArTXiM6BNQ+ANtWxXdi+CmglwsFXjmFa7FTGEOCAPLjC2HTYshyjdT+0UuhJhxgCXKpXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8900
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


This series adds a driver to read and write ZynqMP eFuses [1]. The
driver can be accessed by the 'fuse read' and 'fuse write' commands

Example:

=> fuse read 0 0xc 3
Reading bank 0:

Word 0x0000000c: 3cb16685 013af244 40000000

Note: Accessing eFuses requires eFuse access to be enabled in the
underlying PMU firmware.

Use cases are:
 - Reading/writing user specific eFuses to enable device specific
   implementations
 - Revoking SPK IDs
 - Reading SoC version/DNA

[1] https://docs.amd.com/r/en-US/ug1085-zynq-ultrascale-trm/eFUSE


Changes in v2:
- Drop vendor specific fuse cmd, use existing fuse cmd
- Minor code refactoring (reverse x-mas tree)

Lukas Funke (2):
  firmware: zynqmp: Add support to access efuses
  drivers: misc: Add driver to access ZynqMP efuses

 drivers/firmware/firmware-zynqmp.c |  31 +++
 drivers/misc/Kconfig               |   8 +
 drivers/misc/Makefile              |   1 +
 drivers/misc/zynqmp_efuse.c        | 324 +++++++++++++++++++++++++++++
 include/zynqmp_firmware.h          |   2 +
 5 files changed, 366 insertions(+)
 create mode 100644 drivers/misc/zynqmp_efuse.c

-- 
2.30.2


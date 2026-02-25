Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF19F55434
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9713783EBA;
	Wed, 25 Feb 2026 01:14:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wcsi/mIE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B23A083C39; Wed, 25 Feb 2026 01:14:35 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9221783EB3
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLAjZoDeB2WWxKbTkdSKgqf11TboCZYuJtOUMGn1pCQIKeD/FGCIpkIa6mO9o0LTcmof54Wi7F6MbSeGRxZR8ldrsmO/QCKsSIIEty2aDhlTMi7BJ+KUtCK3rGpCHqlbu5M9wJdboXxg7ZS5yMkMRYx4USMYRNVGTCQsLF7r7eiskuU0IwDeuiKPS1o64+uWSOF+hS2Kx2CHB9dghHDzStfH6LeHU0iD6XWyBLypYDVvyFxKOaw1HWx4axIRx1wvGyMNs+03KwQ6QYwQxfI3c9sjY4HGtRjr5jYAVh0aE55rgyPH3B3KlUoZ0lh6oN9oOAVhp+aslwZCoDBBr7klsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjDxCv2asPWNB3vxIQwmmFNFpMe6uQtHHRbNlsTmJDY=;
 b=LHWpyLT3b+sPPuDRZ/Hxzn+zKXTbE6oQ6Cr3NqsLG6MCYb0SXf4+BkaAb8jwC+9F7RQTMv+KVSWHjLN2BrFV/qi15cq+qo7j8GTZrlffAzRA3N3kizT6AMrvBiN5ef9gdgqOPy3gWlbXpaA/HXLG0wA/fXGEOaUL1eGQPfnkkZJrAGAyfnLCIdqkalgMzwG725fdTDKe0bp2x0MAUO7cNeaG6odkNS7okPNvqnpDgq4GV9EJN5DA8zRfhJyWs3/5VEdGMLoOX/SuxR9aj4N9f04YOrtalFZvYtOkrdLqAf+XNyVZaiRJth7dVgZol1BwVGHlKuylx/D9Od7C2vXy0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjDxCv2asPWNB3vxIQwmmFNFpMe6uQtHHRbNlsTmJDY=;
 b=wcsi/mIEEOn+b6JWSlyT35ygrsxnbCDSuFDjmvNInVQDUO6H9Sg4KmIMuoXXExy6MDqhduthiDbzgK1Gn9K29HRgrH4KCoA8TDerY7BG4aEgj02wu8jXznBVfhnVlM+8DmTd4eaThu5QTqm9X7UQMTcTQ5lOTGw0BuprZVzK/6XEpTjAmg422qdWh34KrOn6emWbghA+Ua7yf8WUAXoj8OMx7UM+hzkw/1QJlAx6XcCVPtqX/+/WVOcaS+kJh/M7JQ61sA3ERWASOisbRTyUn/eS4uaiMLTOyfahc5yc+CMpqJ2habHGK709VKduCtWfNNBRl0VnjnkiYhoqolLWlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:32 +0800
Subject: [PATCH 06/10] pinctrl: nxp: imx8m: Guard pinctrl match table with
 CONFIG_IMX8M[X]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-6-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: a186ec1b-e196-4191-fe2c-08de7402d958
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aVZYYWROVVE3YmR3T0cyRk0zRjZ2NVhHNElCMFgwVS9QcVJWNWwxQmQ0RHF4?=
 =?utf-8?B?aENGbU8wc3VZSFRuMXNpQVN2WVpXVk5uOXZBRGN0QThzVXE3LzFwSzFDMU9a?=
 =?utf-8?B?eTV2Q3o2SW90clNKQ0dqOXAvRlVOVDlTc1dNakowK3E1ZFphYlVSR2NiSXo5?=
 =?utf-8?B?U1dsUkpiTzFaeWtwRXJucERXTmdCQlU2dXMvVVgyVnlpWFBqZWxvS2lEOEpV?=
 =?utf-8?B?bXEvTkI3QkMrNS94c0s4S2ZjNk9lNUJyb1YvYnczeGplUCtqRTRKdTllWkZI?=
 =?utf-8?B?RjluWGNTcDBndGMxNW55Zi9ZL0k0azNkV0hCTnlhTlVpUWlCejlpVUgyUloz?=
 =?utf-8?B?RlZUcGZhVmpQTWRtSER6TDhUQTBFZ01qY2wybzdJa2xoL3ZuRlRTSE1XSk9J?=
 =?utf-8?B?bTFGK000azZNUlZLUmRMZll4Z1M3blF3WFMzQkFjRU8zY21QZWVLQktUblJU?=
 =?utf-8?B?d0p1c2N4V1J6SWRINmIwY1R2VUFGMnVldDJNSEgzRVF2a2VXRmJvY2J6VlR2?=
 =?utf-8?B?MGhZWi96QlFwVmc4UEVQWDhPN3JkdkUvQ3g4TmxZWEFQR21peWszenlMUndj?=
 =?utf-8?B?S25qRnFWNEo2cW1QRmc2WFRUWFlNb0VXQVl1YmM3NDB1L1NKdXh4eFZLZjRO?=
 =?utf-8?B?YUoyZ08rQVNzTmttZmFmTnhyeUpDcWJtWnNyZnY0cHpEcXIwTnY0UVZyUFZa?=
 =?utf-8?B?c3VlSXRicnlPTmZocEFYVFRXRGgyRm0zMS82YkRZWFB4UWs3S2VkbE9kTFJy?=
 =?utf-8?B?enNzenJyYU1lT3duN0k5QWgzQ1pwOWU5T1dQNlFvVWlad0RUdlRXSGwveldY?=
 =?utf-8?B?Ry9JRGRCRm1IQkJuM0huMlphMm51U05XWHJ4QmwrUnZjaFZlMXZIMzdQdnFo?=
 =?utf-8?B?RE9aQS9TSHpsUis5N2xxK2ovdTY4UDVrMzhpTzJSVzNNTm9hWUFvSzNaWVlw?=
 =?utf-8?B?Mys2dVV6THhJTEs2b2Y3aEJyMXo4QnpHYTQ2N0ZYcHhjUWVVTGhlbVUxYnF5?=
 =?utf-8?B?YmNwSVZOazdwT29VcEZEMGRNU05vR0ZjV0xBUHZ0SVdpbHFFNkhteGFUL3NX?=
 =?utf-8?B?NDdiZDE5UEY5ZHJrOXNRUXBCTW5HSDl3T0NEbGFQT2RHTUVPODFyaDRNcFNi?=
 =?utf-8?B?TU1aMk1XZEo5UXlFZmlaS09mRmNMVXFLSVZ0bllGNGV6RWhTS3MvdFZRZ0tl?=
 =?utf-8?B?ZGxWNlhJSU12cDdrTVJEZXpMNXhLNkFtNTh4NjVFVWE1UXVwOHJ0cU85NzZ6?=
 =?utf-8?B?dkJjQjZyVGxrdTRFMklnUVZsZ0tCMUNUT2l3ektmZXZHajY3Y2c3ZEVVU1NT?=
 =?utf-8?B?ellqU2lyZlpOSzdNVHA1VEZ2QUpZZ2lXVGg0QklSVDRwNHoxcEcxb3VHSXZs?=
 =?utf-8?B?ME14NTdsRmMzQkQycFlsaHFIVUR6cXlBdEZhNzhLVXVQOXg5dEhRdkxZNG1o?=
 =?utf-8?B?THlWMUhDV0c0QXdmZ0tWR1RKUS9pS0FLNjNuSWtpYUlFd1hDY2RremYySVRC?=
 =?utf-8?B?bndFcTZRYzl0ZlJNTWlXclBUN3c1NVVjMG5BMGxmenFlTXFvbURmdUlVWkZ6?=
 =?utf-8?B?UkdCOEo5RVFZN2xldGlnc2dyLy9wdWtVQ3hpNG1hNXV0dXFsaUFWTmVpdXA1?=
 =?utf-8?B?bzFqZmZvSzNPbVB1UUxQMTcxWEkvNDYwS1h1eUllT2FwcS9rNUZSSjRCb2ZM?=
 =?utf-8?B?MlhTMU9rNWFRYXNaL0tNYU55blh0cHF5eThLL1BJNmZHYjQ1Zlp1R21PQURE?=
 =?utf-8?B?UHhENStjRWZaNXRpczdlNEMrUW5XS3kvV1pLS3NxT0RaM0J3dWVFUENRUEl3?=
 =?utf-8?B?L05PaGpPV3pOdkdNV2dJbitRWUFEQ3B4dlpJOW83dDBCcmRnM3ZKbjRvTlF1?=
 =?utf-8?B?Vm9DOGVhOWk1dVA5L1pKcjBVUGhNbG1NY1JyaTYyREpPU1Ywc1M1OWVQc2RM?=
 =?utf-8?B?OXVDS2NjRFpoTHh5ZDBMaDA3Q0RtZ05NVHA2VXNrV1AwSDNPVlZSUDdMVVRj?=
 =?utf-8?B?eFRtSlhKZ0RWaWJlQmFqSWZaalllaC9QR2h1cTVGUGdIbWJ6YkYxN3Z6VThH?=
 =?utf-8?B?a0NEZXNYUWdiMmVqS1JKL1I3VXhqNDhyMzJySkhhUzB0TkNaeXdWR3BkLzlU?=
 =?utf-8?B?NW5EbFROeDhHR3hUcWZndWRBZmlLZGRRZk5jU0pORTZxY1pRVjd2dnRHNXFy?=
 =?utf-8?Q?zbk6W4/SXkkB0P+Ta/FkWzY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm84S0QzN2k3Y0NuQ1dLN2FUMlBYWGNrR0hFaDc5T0VtNXlBRlpIckw3bCtM?=
 =?utf-8?B?Vm1EckpFUzZYTXdoWlFNc0kzVkpoQVBHSWw5S2dQeE9VYWYrb3NoSEk2ZWRQ?=
 =?utf-8?B?SnZQWGhmT3UvZmxMYm1BcWFBOHMwWndJNFhkSVVJU0RtQi9rQkNrM0x3Nkw2?=
 =?utf-8?B?akVZbXNGUEgrdXpnTWhiU0NUU2NjTG9jY29rUWZ6dFA0ZTRjRjhQRmJmQWtr?=
 =?utf-8?B?bFl0VW5ub0dnS0t4QkJsd2NHMTMyV1hTR05ZWVRMRkRoMU45d3BSMXI4QzJW?=
 =?utf-8?B?UlNkMzYvOStHblNGaGdjdXdjRWZNcXNiZmVDYU9KUXBEQlpOSVJ3d1RuS0xx?=
 =?utf-8?B?SmxZdjRHODRIMDJpMm5oT0o5SWVJZXZPNExTaEg4VkNFQVM1cDdpVjFHTStC?=
 =?utf-8?B?cllDTExqSGFMcUZjQ1BxNVovNWRtMFJLRTI5by9hZEh4dncyY3BXN1lWcHI2?=
 =?utf-8?B?M1ZCNGxianNCbUxqcUhkYmNyN2N3THgyZ3JYOEZ4TmN3d0JOZi85NHVLYXFu?=
 =?utf-8?B?ekVrRXdNd0I2M2VUbEJ6Q0E0Y3dkcEpqamxOcnZEZGxTa0hDQXVTZU9WRC93?=
 =?utf-8?B?cjVFa05tWGpTR0N5YnhKWXZyaVoxbWRvdzRhRnNveVFmdHJmT3Fib2dLbTc1?=
 =?utf-8?B?QTBPVWlhZVEwYjU3Z0N1M0lpWWVORUxpZ3Zmc2ZJZE1tZno0K2pZbk93NXhZ?=
 =?utf-8?B?T0dlcFFrM2ZZaXVuWHNtVmN6akRKdUx1cWFQeGsyaTh5V0dhN05MVExtcWpJ?=
 =?utf-8?B?OWQvYTdVNS9qZlFSenZWRmI0c1RMdTRGaVRuWW81R3cvWm9GNDdncDM4bnRo?=
 =?utf-8?B?MStuWmNvekNTcUJMeWpORlRraisvdTg4RUVrYXhheUQ0ZnF4VnNNYlFMQzBm?=
 =?utf-8?B?SndKcmxEWjV0aU5LVXY0am0vbXBYRFJIenJEMW9FMGZSUkUxSkhEakNkOU4w?=
 =?utf-8?B?b1lGdWdTa2VUbXVBNGVYWmpNU2lka2tNazgxeUlCMnErWG5PbVkyMTVhMUpL?=
 =?utf-8?B?cGdPdk52TE1vcFR2ci9yMmJTVmdpVGZxQ2RjN3Y2NTloWWoxN3NmYW9oY3BQ?=
 =?utf-8?B?NzQ3SW02NlhDbUpkOTdmNllFL1VrdVJBVTMrbVlRbC82RGtIV0lVNm1hQlYw?=
 =?utf-8?B?eGw5QnBLZnI5aVpaN0NDb2I1N0g2V2tZbHBNME1IS0RnV0pyR0VoNGJ1Z24z?=
 =?utf-8?B?YjFtbkhOb2Jxc20zc3MrcWt1Q2hUZHRoVTNmTmo0Rm5XU3FGVldLMUhvdzVS?=
 =?utf-8?B?aU5KSFBLajdKTEIrbW9LVnJyWHkxZk1XbUhNNHJPMnlpSnpZYVFpVSt0MTh6?=
 =?utf-8?B?OWhGUy93RE5jaWU5bW1RbGhsSkQyV1ZJQnJuV2d5dDZkVDNGUXRNejVpYVhS?=
 =?utf-8?B?bFlXY0h2OFhiUm1LTTBxRXY1SXJDYVVYbzBQTldIbFpmeE9CRENzYWZLU0V5?=
 =?utf-8?B?UithelNhV3VlQTBoOXdpaFdlS1ZBTDQ5VGlDdmRkYkdxNW1neVZaQTZreFlz?=
 =?utf-8?B?aG43QUVQR29WUGJZU3lJbjFIL3ErazhsSW5McVBSLzRldm5udzVmaW5yTUhG?=
 =?utf-8?B?YTN5WU9sdDEwS3RUVTdDdWRCN1dJZStUeXFvODZDaDlRYWZqOGVsdGd2VTVC?=
 =?utf-8?B?UFFrRHVSZE41UHRSWU8rVElDaGdxNGlsSk1DSTRIZ2ZLRGpzRjI2eXJ1VCtr?=
 =?utf-8?B?UG1aR2ZFUUlVUUlYcExTN0RkbjBDWVhYTWJhaUxXRFc5QjJRTGttTXI3LzZi?=
 =?utf-8?B?REVSM2VoclJXWUhxMTRsbENDWWZPckNydVZERXJPdlNUdGVjbFprMkVJZ0Zj?=
 =?utf-8?B?MHJMclQ4eDlMT3F6aVVlTllMRmtBMDNXVURIOTVUa3NKQm9LeEx2c29BdkE1?=
 =?utf-8?B?ZWhjbGxaNkJPcXBpbXhNc1RFa3JBblV4SE55WEZVWmxGdFZybXBRZm1qc1hX?=
 =?utf-8?B?ZzJtZC9ib0ltRk5DeUZYL1ZtYStFSzhEaE5mdnV3UkpQNnVqdXNNOGhOZEZl?=
 =?utf-8?B?eFY1MHF5VmxzUTFvZVZSR1ZqRnVZQTJoSzFyOG9hMG1uanYwRmVaaC9tWEpF?=
 =?utf-8?B?MEJBUy9HTWU1VFcyRzkvMENOUEVmOVg5VkJIVlZZRGZNdFFNdHhwVFBhVElB?=
 =?utf-8?B?ZXhlNzltUFNyOU9mWGJiVDJodkhZWnZvNHJFcVZvaWEzS0VxRmlPZWYvZnFs?=
 =?utf-8?B?MWdMTUsyZ0VxWHdmcG5qcjVER2VNR3ZvbnVmSzJHM01WV1UvTEhQejZ2OXd2?=
 =?utf-8?B?SkpMd3FHdVp3NC9pdkt3SWw2d0M0bzQzUnpUOUhUR3NmZzBYc1JiOW9zanlo?=
 =?utf-8?B?Z1piT2czQlQxdjNJZnpLWmRGQml5c01xOU9aRHJZQmJCNndVUlVkQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a186ec1b-e196-4191-fe2c-08de7402d958
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:31.9643 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTNaO72xktUnnxEMgsAbWvm9k95zQfaRAb39IRJRs7SLyK4vz4VARQ9vvO/1ZkXxYrH8RG1n6w0diQ3TZIL+8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

The i.MX8M pinctrl match table currently lists all SoC compatibles
unconditionally, which may lead to unused entries being included when
building for specific SoC variants. Guard each compatible entry with
the corresponding CONFIG_IMX8M[X] option so only the required SoC
entries are compiled in, which reduces unnecessary data.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx8m.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index f1cadb9f142..6eec1a277b3 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -15,10 +15,18 @@
 static struct imx_pinctrl_soc_info imx8mq_pinctrl_soc_info __section(".data");
 
 static const struct udevice_id imx8m_pinctrl_match[] = {
+#if IS_ENABLED(CONFIG_IMX8MQ)
 	{ .compatible = "fsl,imx8mq-iomuxc", .data = (ulong)&imx8mq_pinctrl_soc_info },
+#endif
+#if IS_ENABLED(CONFIG_IMX8MM)
 	{ .compatible = "fsl,imx8mm-iomuxc", .data = (ulong)&imx8mq_pinctrl_soc_info },
+#endif
+#if IS_ENABLED(CONFIG_IMX8MN)
 	{ .compatible = "fsl,imx8mn-iomuxc", .data = (ulong)&imx8mq_pinctrl_soc_info },
+#endif
+#if IS_ENABLED(CONFIG_IMX8MP)
 	{ .compatible = "fsl,imx8mp-iomuxc", .data = (ulong)&imx8mq_pinctrl_soc_info },
+#endif
 	{ /* sentinel */ }
 };
 

-- 
2.51.0


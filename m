Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD4EE9A03B
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 08:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8918B83936;
	Thu, 19 Feb 2026 09:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="ND+R/BA/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09BD483AA9; Thu, 19 Feb 2026 09:24:52 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BEB1802C1
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 09:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=walter.schweizer@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jidnhs8gB0wlKnuYVQKGetEfVveAmT1ryLICPyzTadLVu6UWAGsZWdgIvNPth2B1x0JyusFy/eAQ6S3wjAhRi6yDeLOzYFPDPe1SiYOc4QcIsuhfooSYhF8L+hbnawdlgxMgP7rNWhkKQ/cB5kLZmasbO2CfnQ43W10VsmUMhXff5VvfqVA6UeOUC+6x0zaw3rTP0hrNxqWjHse0fbYhSDPum6Yfgj0PygkFdIgpXfpc289JITo0Dgv1LKsHD+ohAQsCGL2ykwx9DRg7AeriyaSq0iR+7X4h7VWfc5i8HonUxQU4yI1+QI7sgxqgyzWGW4+a9EGh+8Fpe67HYK2nLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=le6qEcNIm/jeFxyhTBHZgn6VjVBrOda+XF1FVVKP/f0=;
 b=l0yrQvSOlKoIMu0uxJX1xrt9lRpqL7GCFYqYul00kPMgmnbgwXOHNRfquQqOeC235Ie2l2WvgaVOT9TQkNtmfjdqQGLwArWTwhKBZy4hqeDOS4q4PqezYyqbhXtLnS9DbCAYviotQbUoH9K1Me8GL7SIba/1+QX/KDjC55CNWSW9H79mWY7Xrb+htHlUtQC8yjIqWxl3tg2ztJW8kjTTdKp56Qs3pbNgaAseECELUHFTGTakq/oeqUkshTNbFiTYwafsUFUKIj2VmmCByPXfl+Vxk8qy7GJRQGBmfewRT/MADnZS3uZfEOIkThQQb0hUmO5GJRutgF0tk1uoxb0soQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=le6qEcNIm/jeFxyhTBHZgn6VjVBrOda+XF1FVVKP/f0=;
 b=ND+R/BA/gmXSBWczdTyY7Lt/r8TRLAbIDuV7uGdn4UGFr8nBeTjUgGj11bCGcLIUzppNhLHYq203G9UWgK+mutgXNAsg174I31eYifwVo2LvXMZEsQgrqow8XzDGwu3SZnvXwuutXIPDY8fioIskUOHjdupO5L6bXGq3yOWGGgogMJWmpjmpDcBYYeCAQKL4m2QQk4u5oR1DizT2rlWulW1rjOFJcbIcuJk7e/vHwqgMXZUdE+LR4kDktPbfUP7I4llUDwF+QCcHwq1AUwPVJEfTmb2VtG8W/b12O7I2nlEy3b8MEGUmarwV3GL6Ot22ztFS5EJMolJS+oQd3hLaMw==
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5af::15)
 by AS4PR10MB5669.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.14; Thu, 19 Feb
 2026 08:24:45 +0000
Received: from AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b61d:120c:39a3:9714]) by AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b61d:120c:39a3:9714%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 08:24:45 +0000
From: "Schweizer, Walter" <walter.schweizer@siemens.com>
To: "hs@nabladev.com" <hs@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "Freihofer, Adrian" <adrian.freihofer@siemens.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "peng.fan@oss.nxp.com"
 <peng.fan@oss.nxp.com>, "sjg@chromium.org" <sjg@chromium.org>, "Sverdlin,
 Alexander" <alexander.sverdlin@siemens.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v3 11/11] siemens: capricorn: protect environment
Thread-Topic: [PATCH v3 11/11] siemens: capricorn: protect environment
Thread-Index: AQHcoCv7htpI+h8KNUGx7IIaOJTTWLWIs8fQgAD+SYA=
Date: Thu, 19 Feb 2026 08:24:45 +0000
Message-ID: <451447b12fb92444b368fc4c7eeea1725d95ff0f.camel@siemens.com>
References: <20260217163911.31878-1-hs@nabladev.com>
 <20260217163911.31878-12-hs@nabladev.com>
 <AS8PR10MB75243E1247427727F02CB0E6866AA@AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AS8PR10MB75243E1247427727F02CB0E6866AA@AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US, de-CH, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2.1+intune 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB7524:EE_|AS4PR10MB5669:EE_
x-ms-office365-filtering-correlation-id: d731b44f-3c4a-43c0-6c42-08de6f9056d7
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?TXZ0YUswQkhJbTAzYXVENHhiOUcxYVhMeDRydmVzZE5CQVBJTzVrNFdFSFR0?=
 =?utf-8?B?blNKT2FEUStvOEpyUk9UeGNTYis3Y3pHSy8wNkdMaWVJK2Fid2VOczRHS2Vx?=
 =?utf-8?B?UVRSaHNzQkRJYlZla2UveGlIelNIRjkrSVowTi85cEhoQVVDUnAwK1RHZ0py?=
 =?utf-8?B?QStlOVczNTYzd3I4LzVBKzdMMFZqMzljQmJEaUQwU002RnNpckN6ZGpiakNL?=
 =?utf-8?B?S253ZlNNWVVNODNYS2x1MjY3cW1nSXBOaUNyQUt3bHo2THhWK0lOaGthOXNN?=
 =?utf-8?B?bGVHWXJNNmxPL3pOdGVveTJJdWowYzNacGNNU2c3dW9iTDgyK2VCVUJ0a3Zq?=
 =?utf-8?B?UFZlVGhlZUpIN3oya0l2MDlCQzcvQ053S3FTQUFTYTYrUXVQdDVNTGJwWFdm?=
 =?utf-8?B?TEJVdFNkcEhNRC9zMW5iMGJ6WWg4cFdmMlVDREwzNndOdWhxMU81YzhoQmtB?=
 =?utf-8?B?bFhBbFNkTjJqMDQ0UTF3TCsvRnNQUmpqbktNZGdHa3Y2RjJNKzFRMUFNZnNw?=
 =?utf-8?B?RmtkZEVhNEJDYS9rTUZXUG5NSk9OU3lFMHcwRm9RdkF0WFgzTUJRc1RvajBG?=
 =?utf-8?B?Q3IvQ3F1T0JNcUtacHBwb0E4M1Ryem5VRjVydXF1WmNWbkJOUm5KUmdCeDlZ?=
 =?utf-8?B?cnFvTnNwUXFtYkNDbi8zeTlZdENwNmo2NG1aTW9xdG9rM2FxRUhia2ZvSDdR?=
 =?utf-8?B?VTJJQ0hnbjBNcXE0Q2xGS3cvWXlaK0FkNzZsQUxoOUFRaThmT3BJSnRibElV?=
 =?utf-8?B?dzZvUUZIOGtmZmVuNHNqZmFLMU9LZGVxQUFET3NNRnM3RUxDL1l5OU84MUh1?=
 =?utf-8?B?cnZZKzhHZjFuLzI2R3NvdDdMM2lNZGxNS2xvYXRwSDdWNHZQdnBlQ1NkSmQw?=
 =?utf-8?B?TkhXMWFsSXIzVDk0bTdMQmYvaWkrZ1RocGkwemk1STl3ZnVTY1JpK1EvRXJu?=
 =?utf-8?B?ckdTT1VOOVE5N0doMGtqdlVlbHZNRk9OTUQvallLeVg3Sm0zdGIwWkFTS0xp?=
 =?utf-8?B?QkRoOFlrc041UjZyY09PaDZDalk1cnFURkhKZXFlaUs2ZE1sd3FUaHZTeVpB?=
 =?utf-8?B?aGdjQ0Nhc29DVlBEQVMzVmFaTmZkeS9TV1lzRldyZkwrWGxieG9sVGhUOTZX?=
 =?utf-8?B?SzRTQXZCUWJLUWY1TmpXNnlJVzZmcjRJUnZpMEVONXg5djhYN3BqWVV1RUtu?=
 =?utf-8?B?TFNhc0E1OFVOc05LOXVhK2t6aENiTzlOa1JuZEJxTzdidnNQRjU1czFhVHBR?=
 =?utf-8?B?VmoxV3E3ckdIRXpqdnRYSzQrVnVUNDdiZFJIYU1Da1JYWXRRTEZTN2tBNVpt?=
 =?utf-8?B?TnJpcFFXS21iMDg5NjZmTjRob0xiSm1ZTG5hRmJxN3FiOGdzVGZuSFJsRTQ1?=
 =?utf-8?B?TmxHNk45ckZuWmpvT05LUGg4RS9jSy9OSnBHRkRkYmVYVXFQd3dtcVRIS2I2?=
 =?utf-8?B?KzVjUERscHYrUnVxY1pxQmxaelFPNExSVWplT2V0OHlWLzNiTmpUMExZeTRG?=
 =?utf-8?B?ZkVqNk5vZ1ZQaHhkSGpQMDZiNTJrSWpickFrSHZVcXBwS0FkMmhaS21oV2Y3?=
 =?utf-8?B?R21vNU9RZjhvS3JBWkZoZ2pWSTNhdGZLMFJWVzhkUGFFNkk3QzVkVjJVc3pw?=
 =?utf-8?B?UitoRm5yUU5zdWVTYng3WXRBTGMrRGkxK0kvTy9RL21ETEJBTHhOekZxZlFr?=
 =?utf-8?B?ZUNtUWs5cEVIeEo5ZGcvdnhtNUU5UU45T1V5NVVPYXk5OC9QdjNITWUybDVm?=
 =?utf-8?B?eVNIcDVXbE8wM1llK1hJc2t4V25scHVWQUNKMlNyUXZvNHNoV3NQWG9EaEd6?=
 =?utf-8?B?blladmk0OWdIdjZiaFU0eFNtRnBoclNQdU9FT0Fzc2RnSXB5SkZpTGFJbnlh?=
 =?utf-8?B?RFR1WFEza2grdkRIT1ZkZXFSbGYwTDdCL1RadWNRa2hIRGJnUitJbnZLUTRE?=
 =?utf-8?B?dmNlbGtnK1dHTUFWNXFDNHZGblFEb3FtdEpGZlBQZlpMUjNNYk1NelExTi9P?=
 =?utf-8?B?dWhqU2VUYjJFUlZQT3R3RDdUbnFESjVIMXpIMzVBRTRsMHJpTS9tSVhZYVht?=
 =?utf-8?B?ODltRTBkaEhIcXZPekVzN2NSN01sdE0vYno2VlpMdnJhY0RnSStsY3lzaFpG?=
 =?utf-8?Q?gCXw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TG16SnlRaGpTNm1NQkg5V2NPNCtJMXFmbUZRWVRhT2pCQ0hkelpyVkY2UFRD?=
 =?utf-8?B?ejdOaXU0RGhLamJ5U3dUOExnRmhONkIzemtGcFBURjdTU3l1cCtvNGI5MjN0?=
 =?utf-8?B?bnB3N00vYUJaMm5WbUllS0VEMVNQZVJxd2k4cVFtUDNDV2ZQZ2ZpQnFySG1P?=
 =?utf-8?B?bDI2Q2YwU2RWbHhnNEQzb2RWcm9OemNmdjZzQTVsbC9uVHBRc2xDeUdESjFt?=
 =?utf-8?B?cml5aS9HUC9SYlBHY2JHK1FBTjdaUmlqdDRLS1hsM0J5QXlBRHJkd1NBb1pz?=
 =?utf-8?B?bnY3bFN1ejU2L2tjMlcrV0R6WE9nTTVOdUQwdVp2bmRpMjM4bHhteGRDaS9y?=
 =?utf-8?B?czBCSEVZL0ltOU1uNTBvSE85NGFuaGFuUGUxREMvSmpLWFFjM0s0NFExU3lT?=
 =?utf-8?B?RExMUStxdGNLZ3R3bUl0Y3IyTDVLK1ZhRG9lTE9UTXlWVFQyeHErTTVpZXdS?=
 =?utf-8?B?V2w4SkpFeDVrdDNvTXVUMGFBSTkzL1ZJcHZMYnlqK09DSWdyZmVsZ2dQTytF?=
 =?utf-8?B?OThkbjMybWZoY0o3ckxaZkZvZXdDaVJtL2xQTFk1aUNHaDdHMWtMNHljekdr?=
 =?utf-8?B?R0dMa3drL3RzWVRnaVBTSm42OTI2aHh1OUo2aWgxK0tKY2NYQWNjVVhpKytI?=
 =?utf-8?B?aWxzaVlzNjhWYkNtTTRpcENXTUU1ZU5heFFCd1FsaTRyQUxGU1BZb1IrY2JB?=
 =?utf-8?B?b3hwdG1pMktlRGNOdFdGWXQ2c3J0YllSWGxMZ2w4N0Jwa3dKMDNjZkpuVkVB?=
 =?utf-8?B?aXpRTmZkOWprWXl1OFVpRU5UeGp3cU5DbDZIeWZiVVArSEVSU3A5RG1YRXJv?=
 =?utf-8?B?T05ldGxtaWlxZWgrcEorQy9xYlU3N2JBWUxJc25jSWJqNUp2VXBlVEs4Z3NP?=
 =?utf-8?B?R242ZjVGcVA2LytBc1FRREthbFFWUUYyYWN5RWV0YUs5VFIzUVhwTnc0aGdw?=
 =?utf-8?B?cFUxVStrendiNThVUmhOeUpwaFFjYjJSTzRBN1ZSV1ZHTjlibTdSWkRXT2pO?=
 =?utf-8?B?UGtvdmV0S253d3lJNmVoMnAzcGozaStoQ0hSZHNzL2gzWUp3cmZGOVplMFNM?=
 =?utf-8?B?cFhZNnlKM0F6RGcweEJDaW90M2ZoYWJwcmFlUm1KVG9YcGh1OVBJVWhKQzBZ?=
 =?utf-8?B?Ri8xSWRWaFYvakJiZmM2a1lrc1BLUUMwY0ZJcXJWZUNhT1k3aGhTdlkydjNq?=
 =?utf-8?B?Ui95eUhkTTJNWGF0bGNyQXJkT3JTdXBBSVB0d1ZkTjVxZmZlc01aaENVTXl0?=
 =?utf-8?B?TXYxL1k2UnFoN0VEVGdwQUxVQWpHVDVnejhXZGVWVkx3VkowUjdQeExHcEh0?=
 =?utf-8?B?bjkxcjRWSkEzRndUUDdiQU0rU3JsdWNtQTFuOHh0ZlRRQ1NFa2FqeHg5SDJR?=
 =?utf-8?B?MkR2NkhRS1Q1VWZzVy9EZmhXeVI3WXdTU2xpekRXbTJNUXFCVVhRV0dteUZp?=
 =?utf-8?B?ejU4eDVvZEswYmZZSmgrSWdoUzM5T04vOVJvK1grb0pSTGIvRXViK2lYdG5y?=
 =?utf-8?B?bVdvSlJTUWVNOW5lSllmTmc4M1BNeS8yOXczNEc4N3FaamFXdEx6MDZ4L2py?=
 =?utf-8?B?dTZjTzRwaGhMNXN5M1hkK0NLZUVGTFV4dytTajVmRE90a3llUjJOOFR3Q3Rh?=
 =?utf-8?B?alJxSGF6bCtONWE2V1ZJc211V2p0NmlXcnljN1h4bUJJcFE3MmxkQjUrZFNS?=
 =?utf-8?B?MnQrais2aDQ0MXMrWjJ6d3JlS25nOUpYSTVDTmY4RzV3eVhQZXZSaHFJanhI?=
 =?utf-8?B?cEVGMGFYak5TU3NRVnFZcmcxazQwYlZHOFMwMlppM0s3SjNtc1NheXVkSWF2?=
 =?utf-8?B?T3Y3bzFndlA0N3BSYnRYTEwycktUMTZnVDdVRTJsSWpwalk5SC9pbXA1VUpC?=
 =?utf-8?B?N0xyNzYwVVMydU05TndIQ3R4Ri96cWN3VFRHQm8vVXVnS3lCenl6eFU3MEVp?=
 =?utf-8?B?UmM0Tk5WcjEvcmtBTVBnaE04bG9PaGNPYVhuKzVRd3h6dTgxM0pETDFDeDBF?=
 =?utf-8?B?aWtKWVg3TitpZVFackcxTm1xNE5jeEx2SkY2Q21HRDZZSnJYZGNMc2hVemFx?=
 =?utf-8?B?UTVvTUp6bm9wMHlxRGZkQm5tSUlzQmtwTzdqazJ2SHVDb1JqMGRPL2MrcEs1?=
 =?utf-8?B?UldWdWpuVkFoNS9RYWtLcUx6OXdneUVWWm5xbllxR2p3VWhsekszajZHVFll?=
 =?utf-8?B?bi84SFYxV0N0MGVFUkgrb0FUVUV0eThEcHdhYVBrOS9DQVJrTmhRN0ZGRWwz?=
 =?utf-8?B?YUdwN3IvZkdtemJwZjJVLzlibEhlYTJFMHNaK0czdWpzYUpCZXpZWmEzT0dj?=
 =?utf-8?B?Y3phQ1R1UDNWRDcrZC8yNS82WHVIRm9XOXFxS2U4K0ZqWDBjWVF2NFRTTXhQ?=
 =?utf-8?Q?LO3cTPQQhINyEnyDFQsXnke9YU+Xoxv6+vI9u?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <90E4F92AC19AC8458A4FA772BF3421FC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7524.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d731b44f-3c4a-43c0-6c42-08de6f9056d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2026 08:24:45.6077 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BoVgj/FbSdj3ohFk0uxjRvN7ldQgBmcu1cm2PiY/FKiKuU8tg9pqYSibAgzZOKtxFL86lXwdg3/6pAmvVuB+6iGRn1hgdAbZSzg4uo+5Fqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5669
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

SGVsbG8gSGVpa28NCg0KU29ycnkgZm9yIHRoZSBub2lzZSwgcGxlYXNlIGlnbm9yZSB0aGlzIGNv
bW1lbnQgLSBpdCBpcyBqdXN0IGZvciBpbnRlcm5hbA0KZGV2ZWxvcG1lbnQgdXNlLg0KDQpCZXN0
IFJlZ2FyZHMNCldhbHRlcg0KDQpPbiBXZWQsIDIwMjYtMDItMTggYXQgMTc6MTkgKzAwMDAsIFNj
aHdlaXplciwgV2FsdGVyIChTSSBCIFBSTyBUSSBFQUMgQ0NQKQ0Kd3JvdGU6DQo+IEhlbGxvIEhl
aWtvDQo+IA0KPiBSZWNlbnRseSB3ZSBkaXNjb3ZlcmVkIHRoYXQgd2UgbmVlZCB0byBhZGQgImJv
b3RjbWQ6c3ciIHRvIHRoZQ0KPiBDRkdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDIGxpc3QuDQo+IA0K
PiBCZXN0IFJlZ2FyZHMNCj4gV2FsdGVyDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiBGcm9tOiBIZWlrbyBTY2hvY2hlciA8aHNAbmFibGFkZXYuY29tPiANCj4gU2VudDogVHVl
c2RheSwgRmVicnVhcnkgMTcsIDIwMjYgNTozOSBQTQ0KPiBUbzogVS1Cb290IE1haWxpbmcgTGlz
dCA8dS1ib290QGxpc3RzLmRlbnguZGU+DQo+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBn
bWFpbC5jb20+OyBQZW5nIEZhbiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+Ow0KPiBGcmVpaG9mZXIs
IEFkcmlhbiAoU0kgQiBQUk8gVEkgRUFDIENDUCkgPGFkcmlhbi5mcmVpaG9mZXJAc2llbWVucy5j
b20+OyBIZWlrbw0KPiBTY2hvY2hlciA8aHNAbmFibGFkZXYuY29tPjsgUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+OyBTdmVyZGxpbiwgQWxleGFuZGVyDQo+IChTSSBCIFBSTyBUSSBFQUMgQ0NQ
KSA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPjsgTWFyZWsgVmFzdXQNCj4gPG1hcmVr
LnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+OyBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9y
Zz47IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxrby5jb20+OyBTY2h3ZWl6ZXIsIFdhbHRlciAo
U0kgQiBQUk8gVEkgRUFDIENDUCkNCj4gPHdhbHRlci5zY2h3ZWl6ZXJAc2llbWVucy5jb20+DQo+
IFN1YmplY3Q6IFtQQVRDSCB2MyAxMS8xMV0gc2llbWVuczogY2Fwcmljb3JuOiBwcm90ZWN0IGVu
dmlyb25tZW50DQo+IA0KPiBGcm9tOiBBZHJpYW4gRnJlaWhvZmVyIDxhZHJpYW4uZnJlaWhvZmVy
QHNpZW1lbnMuY29tPg0KPiANCj4gV2l0aCBFTlZfV1JJVEVBQkxFX0xJU1Qgb25seSBzcGVjaWZp
YyBlbnZpcm9ubWVudCB2YXJpYWJsZXMgbGlzZXRkIGluDQo+IENGR19FTlZfRkxBR1NfTElTVF9T
VEFUSUMgYXJlIHJlYWQgZnJvbSB0aGUgdS1ib290IGVudmlyb25tZW50IHN0b3JhZ2UuDQo+IEFs
bCBvdGhlciBlbnZpcm9ubWVudCB2YXJpYWJsZXMgYXJlIHNldCB0byBkZWZhdWx0IHZhbHVlcyBh
bmQgYXJlIG5vdCB3cml0dGVuDQo+IGJhY2sgdG8gdGhlIHN0b3JhZ2UuDQo+IA0KPiBUaGUgdS1i
b290IGVudmlyb25tZW50IHVzdWFsbHkgc3RheXMgZm9yIHRoZSBsaWZldGltZSBvZiB0aGUgcHJv
ZHVjdC4NCj4gVGhlcmUgaXMgbm8gQS9CIGNvcHkgbWVjaGFuaXNtIGFzIGZvciB0aGUgZmlybXdh
cmUgaXRzZWxmLiBUaGF0IG1lYW5zIHRoYXQNCj4gaW5jb21wYXRpYmxlIGNoYW5nZXMgdG8gZW52
aXJvbm1lbnQgdmFyaWFibGVzIGluIGZ1dHVyZSB1LWJvb3QgdmVyc2lvbnMgbWF5DQo+IGxlYWQg
dG8gc2VyaW91cyBpc3N1ZXMgaWYgdGhlIG9sZCBlbnZpcm9ubWVudCBpcyB1c2VkIHdpdGggYSBu
ZXcgdS1ib290DQo+IHZlcnNpb24gb3IgdmljZSB2ZXJzYS4NCj4gDQo+IEhhdmluZyB0aGlzIHBy
b3RlY3Rpb24gaW4gcGxhY2UgZW5zdXJlcyB0aGF0IG9ubHkgYSBsaW1pdGVkIHNldCBvZiBlbnZp
cm9ubWVudA0KPiB2YXJpYWJsZXMgYXJlIHBlcnNpc3RlZCBhY3Jvc3MgdS1ib290IHZlcnNpb25z
LiBBbGwgdGhlIG1hY3JvcyBub3QgbGlzdGVkIGluDQo+IENGR19FTlZfRkxBR1NfTElTVF9TVEFU
SUMgYXJlIG5vdyBwYXJ0IG9mIHRoZSB1LWJvb3QgYmluYXJ5IHdoaWNoIGlzIHJlZHVuZGFudA0K
PiBhbmQgaW1tdXRhYmxlLiBUaGlzIGd1YXJhbnRlZXMgdGhhdCB0aGUgdS1ib290IHZlcnNpb24g
YW5kIHRoZSBkZWZhdWx0IHZhbHVlcw0KPiBvZiB0aGVzZSBlbnZpcm9ubWVudCB2YXJpYWJsZXMg
YXJlIGFsd2F5cyBpbiBzeW5jIGFuZCBjYW5ub3QgYmUgY2hhbmdlZCBhdA0KPiBydW50aW1lLg0K
PiANCj4gdXN0YXRlIGFuZCByYXN0YXRlIGFyZSBub3QgcmVsZXZhbnQgZm9yIHUtYm9vdCBpdHNl
bGYuIHVzdGF0ZSBpcyB1c2VkIGJ5DQo+IHN3dXBkYXRlIHdoaWNoIHBlcnNpc3RzIHRoZSB0cmFu
c2FjdGlvbiBzdGF0ZSBpbiB0aGUgZW52aXJvbm1lbnQuDQo+IHJhc3RhdGUgaXMgYSBzaW1pbGFy
IHZhcmlhYmxlIHVzZWQgYnkgYW5vdGhlciB1c2VyIHNwYWNlIGFwcGxpY2F0aW9uLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQWRyaWFuIEZyZWlob2ZlciA8YWRyaWFuLmZyZWlob2ZlckBzaWVtZW5z
LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSGVpa28gU2Nob2NoZXIgPGhzQG5hYmxhZGV2LmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiANCj4gLS0tDQo+
IA0KPiAobm8gY2hhbmdlcyBzaW5jZSB2MikNCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IEFkZGVk
IFJldmlld2VkLWJ5IGZyb20gUGVuZw0KPiBSZXdvcmtlZCB3cml0ZWFibGUgdmFyaWFibGUgbGlz
dCwgYXMgd2UgZHJvcHBlZCBwYXRjaA0KPiAiZW52OiBhZGQgdyBmbGFncyBmb3IgbmV0IGNvbmZp
ZyBpbiBleHBsaWNpdCB3cml0ZSBtb2RlIg0KPiANCj4gwqBjb25maWdzL2lteDhxeHBfY2Fwcmlj
b3JuLmNvbmZpZ8KgwqAgfMKgIDEgKw0KPiDCoGluY2x1ZGUvY29uZmlncy9jYXByaWNvcm4tY29t
bW9uLmggfCAxMyArKysrKysrKysrKysrDQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRp
b25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy9pbXg4cXhwX2NhcHJpY29ybi5jb25m
aWcNCj4gYi9jb25maWdzL2lteDhxeHBfY2Fwcmljb3JuLmNvbmZpZw0KPiBpbmRleCA2MjY2MzRj
YjA5Yy4uMmJhZTViMWE4NjIgMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3MvaW14OHF4cF9jYXByaWNv
cm4uY29uZmlnDQo+ICsrKyBiL2NvbmZpZ3MvaW14OHF4cF9jYXByaWNvcm4uY29uZmlnDQo+IEBA
IC0xMiw2ICsxMiw3IEBAIENPTkZJR19DVVNUT01fU1lTX0lOSVRfU1BfQUREUj0weDgwMjAwMDAw
DQo+IMKgQ09ORklHX0VOVl9TSVpFPTB4MjAwMA0KPiDCoENPTkZJR19FTlZfUkVEVU5EQU5UPXkN
Cj4gwqBDT05GSUdfRU5WX01NQ19FTU1DX0hXX1BBUlRJVElPTj0yDQo+ICtDT05GSUdfRU5WX1dS
SVRFQUJMRV9MSVNUPXkNCj4gwqANCj4gwqBDT05GSUdfRE1fR1BJTz15DQo+IMKgQ09ORklHX0FI
QUJfQk9PVD15DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvY2Fwcmljb3JuLWNvbW1v
bi5oIGIvaW5jbHVkZS9jb25maWdzL2NhcHJpY29ybi0NCj4gY29tbW9uLmgNCj4gaW5kZXggNzEy
MGE0NGQxODYuLmVlMTNkMmFiOTUwIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3MvY2Fw
cmljb3JuLWNvbW1vbi5oDQo+ICsrKyBiL2luY2x1ZGUvY29uZmlncy9jYXByaWNvcm4tY29tbW9u
LmgNCj4gQEAgLTM4LDYgKzM4LDE5IEBADQo+IMKgI2RlZmluZSBDRkdfRVhUUkFfRU5WX1NFVFRJ
TkdTIFwNCj4gwqDCoMKgwqDCoMKgwqDCoEFIQUJfRU5WDQo+IMKgDQo+ICsjaWZkZWYgQ09ORklH
X0VOVl9XUklURUFCTEVfTElTVA0KPiArI2RlZmluZSBDRkdfRU5WX0ZMQUdTX0xJU1RfU1RBVElD
IFwNCj4gK8KgwqDCoMKgwqDCoMKgImJvb3Rjb3VudDpkdywiIFwNCj4gK8KgwqDCoMKgwqDCoMKg
ImJvb3RkZWxheTpzdywiIFwNCj4gK8KgwqDCoMKgwqDCoMKgImJvb3RsaW1pdDpkdywiIFwNCj4g
K8KgwqDCoMKgwqDCoMKgInBhcnRpdGlvbnNldF9hY3RpdmU6c3csIiBcDQo+ICvCoMKgwqDCoMKg
wqDCoCJyYXN0YXRlOmR3LCIgXA0KPiArwqDCoMKgwqDCoMKgwqAic2lnX2E6c3csc2lnX2I6c3cs
IiBcDQo+ICvCoMKgwqDCoMKgwqDCoCJ0YXJnZXRfZW52OnN3LCIgXA0KPiArwqDCoMKgwqDCoMKg
wqAidXBncmFkZV9hdmFpbGFibGU6ZHcsIiBcDQo+ICvCoMKgwqDCoMKgwqDCoCJ1c3RhdGU6ZHci
DQo+ICsjZW5kaWYNCj4gKw0KPiDCoC8qIERlZmF1bHQgbG9jYXRpb24gZm9yIHRmdHAgYW5kIGJv
b3RtICovDQo+IMKgDQo+IMKgLyogT24gQ0NQIGJvYXJkLCBVU0RIQzEgaXMgZm9yIGVNTUMgKi8N
Cj4gLS0NCj4gMi4yMC4xDQo+IA0KDQotLSANCldhbHRlciBTY2h3ZWl6ZXINClNpZW1lbnMgQUcN
Cnd3dy5zaWVtZW5zLmNvbQ0K

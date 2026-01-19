Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DE1CCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 10:51:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D944D80B98;
	Mon, 19 Jan 2026 11:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="jcET/tXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7349783956; Mon, 19 Jan 2026 11:51:28 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EE0800AE
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 11:51:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbLNMU40I9uTcSkmBDUDfA6XYO3o6b80ABRgTFrXt5QgD4oVhOUeX1TDGD26PHZLdk94jAeUJfoR7jQUmIU+PglD1Qi8v9texHDA8e0T6wAsfyQzhTa8DSrQ3TSitCM8O3/P1qTnRsMbGAl5nmprtGQYRVbWlSyEKPALDgTGiB/QIWXfU7q5TXkYjCXtMgw5e78XKYEOztTAlj/+q/CCFpQbV6YE3h1vxex6t8vyJlxuH2p6arC03DoYVLy+nFt+mVVP70cww688Qt2GmH1UMBN0WfmTRqw/awfDDL97PZ8NqsxPxAWQC6ZlMvCDRargd2cF4lnwbf3ny0F4BIQ63g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPUwdj3/6URBk0w0qrYIC6wBCbQ/IdcRK9vZoY0mX+U=;
 b=rpZu5d4QTWkgycL5I/qJrCndG1z21tdW+fRZWCmxsxOREPahRUKWomRlPfgtozWqj9OBIGyj4CmJMa+ztEPVFD3kO3rCIdxaMGhQRmrNChH/fBssbGOVtMlmo9CSjY1oz8809YbJKt3tHUkuDOVktwSA+xaAp3rEClDpWz1qAFomW8AZ5Zv3jGx8MVKE4RfbAIBxj+i9aqGpumfLPRZpZOY0AcQg/rzZVFoTaaW7UN8yyJAKVVcYzOEq6JsoUSPDJDu3m2KpaKyAD4t4WKNLvWlgAWsoHed3+w4eYF5fGV1IO8aAZZgjECbtkPLZsENqDtP7wFHqiFL9NSoCpkaPPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPUwdj3/6URBk0w0qrYIC6wBCbQ/IdcRK9vZoY0mX+U=;
 b=jcET/tXbP7HlO2nkhBsLNOlsPS2qc0riLJlGYFtlqwmnG3MLMesToOlcgJslC4hbuUe9CYdFqVIkjGC83onaB08QRaGEB+C26LSfMC5zD0UYdS+YkJBHR7azhD0uiZBJfpJjFUUGo1JLPr30tVbGkVZdg9+sUfwecIik51B/wbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV4PR04MB11971.eurprd04.prod.outlook.com (2603:10a6:150:2ec::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 10:51:18 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 10:51:18 +0000
Message-ID: <85ad8c56-c000-48bd-a0c8-7fff8103ec2c@cherry.de>
Date: Mon, 19 Jan 2026 11:50:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] disk: part: fix partition search boundaries
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119003606.748561-2-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119003606.748561-2-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV4PR04MB11971:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eaa5076-ac7f-4ff3-59f9-08de5748ad23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|366016|10070799003|376014|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vms2eVNqaXBFVE8wREpjeFAyQjJmWGZ0NHdsVXFxK2tYaGQ5dzdIV1FkT3RL?=
 =?utf-8?B?SjduOXExSlk4U2JjZnpUNkEwTHZXRU5UTFQ0RDQ3M0dyOTNocmxaTWFpZTlM?=
 =?utf-8?B?VXNtcGdoUjNzbTN2MmNBbE5mcnQ1ejdncTZmMTV2Zk85eFVsVkQ2c0xHK3Iz?=
 =?utf-8?B?VW84OHo5R3pCQ2RRRStOK0JYTU1uWk9jSTlaeEFQV2ZhVmxETm5yTlNoUVFG?=
 =?utf-8?B?WkJDTDBSZlZiazd1Mk1aK1FGMGFlN2JBK2Z2R3U2SnAvZWJjTERqZWxMNXpD?=
 =?utf-8?B?QkNBVEdEVWNDUHlaTDlIaTFNd0pPU1l6dUt4bzhHZ2dnZGdYbnVlUFY2VHpE?=
 =?utf-8?B?Nm1NYzVFMmY4TTBHb2NrNVhiTTFDUjB6bXpYUXg0dFZQNWJFZ3RKa1JuMG8x?=
 =?utf-8?B?bm5lSDU3UEJRU3dOTXBHUURyYzFZeUtDSTNZbkNnZys2STVoZ251bHJlM0Ex?=
 =?utf-8?B?Z2w3Zi94VDFZM3lyRWRLZnpvWDV1Z3J5Ky8vSHRPdXJ1SDZ6eTNQeXBYQlNi?=
 =?utf-8?B?ZkFpZHc5dHVuSjhwMjZTdndoclE4dFlCWXZLY2VqWWFnc1puM2tNaWFubCtZ?=
 =?utf-8?B?S3RzYXdabmpjNzVkbDZrQ1p6QWgwamlSMHBkNUNpVUxrL1pBQW5XYUUvQUNX?=
 =?utf-8?B?N0ZDdUQ3K0piT2VIUGpteGtTbjBtcXlNSkpMVFRScmhYblp1V3hldWp0MHBO?=
 =?utf-8?B?eHVwME1PQkhiVURZaEFRU2l0d2IvZnJpUFB5MUJad0pEZTZpanZ1M2UxYkk0?=
 =?utf-8?B?NFo2MlZyU3VSbEp1WWVqaE5XNUwvejQ0OGY4SnJ1N2N6OWN5NnZmaVFqRTQ4?=
 =?utf-8?B?blFTNEY0U29ESVVqQnA3L2tKZWhTWTluS0szZGMzUnFhd2dvTXlUTGU3NGpF?=
 =?utf-8?B?NVlWVUlYVWRjM3VSQy9qNVVnaCtZOGZwNnBENE1IN1JNcE9KMlRHN1ZOREk1?=
 =?utf-8?B?SmJmV2JGZjdTQ3dtWFlJZ0lNMG5DNTY4YUpKVDRUUDB1NUdwZmFUOXJwTElq?=
 =?utf-8?B?eHpCNUF3bFNzbEtMaE1mQnd2V2RmTXQyK05DODFaWWJNekd2cFdkdnJLN1ZJ?=
 =?utf-8?B?OEYvckUrWU5CZ3g2eEtQMlpucjJFVDk0bDNpRmF0Y3RwbW0vYkQ2ak9sK0ov?=
 =?utf-8?B?ZVNrT00xMk1qdjBaRmNrY2t4Vzh1M2RZQ0NEcmZHQUs2V0hWTS9GakFQa0Rj?=
 =?utf-8?B?dDBMcjFWOGtmeWVWckk0czllcW9ERkN0cWx4d09xYlRJQ2tTcGFkOUlBSkFz?=
 =?utf-8?B?ekpDbzBWMC9rRFZLZCtkY0l5bm1aVXkxMzRReUZmcnNrNnh5QmcrbUxaUGY3?=
 =?utf-8?B?TS9QazUxNWpDcVFXVXJoeEpmcjhtM1BEZElzZHVBTmg4Slp5SE0vYUEyN3dW?=
 =?utf-8?B?YlpNYXJDS0NwSnFzclgzMkM4M05XRnFHQjcyaFJNT3ZreTdQUHBMSmVMK0RU?=
 =?utf-8?B?cHRFWHgxNFdzZlZsRDVnbkwzY3VUOFlBL3ZzZVZzemdVZHk5cU53cFZWNjVS?=
 =?utf-8?B?clVVVnVUaXd6aCtJdmcvdzFka3I5SHUxNUJSbEtPR00vZ3FjbE83enhNeE16?=
 =?utf-8?B?S1hkeDNscnJ0Y0VndHNHeVArMThLS2IxWWxhdStRM3FSbzZ1dllObXFxLzRQ?=
 =?utf-8?B?WHBzU3pZZHRPdzBiVjdXT1NZaGVkaENKZ2ZoR0d2RStHa2NpVTlpaHpvbkN4?=
 =?utf-8?B?WWpOSkhCNFBIaE8zUVlvTERvK1ozWEVVNlBMRkJ4MUtKY3dWUUhubEt6Z2pU?=
 =?utf-8?B?SEFHQU1QamRsTnUyWDhOVlFjTmdRRW5ZV0p3MkhGNVFMSEtrNnNqUHFaTUhp?=
 =?utf-8?B?bnFEQlFrWHl0TEJja2p4bk00SDgwU01HYm10a09qRUw2Y2JMR2E0bC9UOWtD?=
 =?utf-8?B?NC9kdzNqdkRmOUtKT01WQ3RnQ0ZwaGtHeGkxTndjZW15SlJEeW1iRHVIV2U3?=
 =?utf-8?B?R0k2STZjeXJzMmpFMWFoSXhwQm5WSkZCT2FwRlh1MDNjZ2dSVGo3bll5bzNl?=
 =?utf-8?B?aXh4VlhETXZmUDdxSHNYUGNWV3NsRGp2V2xYanJVbVYrbGhPK0tQK3ZZTUV6?=
 =?utf-8?B?RnE5dEpldFNiQW8rT3A0a0QxelJVSmxZQ1JzRHVwREp2WW5Rekh2cytLQUJI?=
 =?utf-8?B?cFJpL00xYkFLblU5OWQxWHlxdjAyU0ZZN1dYT0JsV0YwNHpRVUVuM3ovZENy?=
 =?utf-8?B?OVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(10070799003)(376014)(921020)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWhQOFh5OE9DN3FKU1QyT2FxYVNWeHZReC9sM3FuQ1JLOFhXT2wvUWxYRzFy?=
 =?utf-8?B?SVAwQXFVU0MrbFoxYlFmZmVHeHpjWkxQV2RxcDltVjVwU2l6Y0VhNGVIK2lG?=
 =?utf-8?B?MDY4NW9ab0hPekRRbHEyS0pvUXVMcUh1dkRkeXFPamJwYlNpc010dzZFeEl1?=
 =?utf-8?B?YktZYndrNFBjMUNnYmtydkt5LzA0dDlsSFkwTE9lUUNicDAvYnNjendoRGJB?=
 =?utf-8?B?THRyY09EazF3L09ER0lYT0hIMVpCUWhVVEF0Y3hGeUJDbU1HUTgxSC9lMVND?=
 =?utf-8?B?TFFTUXZ5eWRlWHFhU0w4R2s0YmZFZ1VRaWZRUzU0V2EvbVpLNmRTS0s4ZUNT?=
 =?utf-8?B?eXUrc05EaGs1U2VCcjcwSHlLbnhHNlk4ajhOUHYxak9JVml5cVpvb2l1eGQ0?=
 =?utf-8?B?cTNQZzMzZFNmdzNRUnpSMmp0MENSVi9hUDRTcHBOZHczbG96UlNiTExqaDZL?=
 =?utf-8?B?dE5iV0JTMHZRMUlCWlBNR1AxbzJoWVdUV2dUaytock9rNUU0Zzg0VWVpaHh4?=
 =?utf-8?B?WERramhWU0ZwWTlLU0ViaENzdFBodUs2M0FOZFIwOXArcTIyUUdMVktFQlVu?=
 =?utf-8?B?MXM5V2k4a2p1Zlhpd0FIclVVMDN6RDhGRlYwSlVKSVRGdXlFdVZDY0ZOdVp1?=
 =?utf-8?B?aUNZaDVnWFVvSGlndnRBbEdNQlFycTlpOUI5aDBRNlo1dVBpZW5Vd2xLcmhW?=
 =?utf-8?B?dTUxNTJ1V3MxeS83TWZXSXAwUUFtdG1FN0hhNzNXc3FaZ0lKdzZoTW00NmpU?=
 =?utf-8?B?YS83MTVNcHh1dDZXc21wMXR0L01ScDQ3Vy81V1gzZk9sSGUrdlFoM2p6UTlj?=
 =?utf-8?B?SFVQWnZja1Ezd3pFMFhIRjhqdmc3M1RoMmh2aW10TlUzQlFWaHdpc3l4cERu?=
 =?utf-8?B?S25SY09Tdk0xZ3RpalBaWGhyUzZMbTN4UzdxL20wSlpWTTRJdzUzajcwVFZr?=
 =?utf-8?B?akswYkV4NHlnSUNPVGZsbDRiRTVtZ2VKa2lYOVlqNGZvU3RmcHZDSVlMbzY0?=
 =?utf-8?B?MXU2UFZhd2ZjdmZpUGtTNjdOaTQ4NHhmemE4YzZBMWpVYkVtSUIvYkd0aWZn?=
 =?utf-8?B?OXF4NHFxMXA2YlZhL0pxaFl5b1JWaXV4VzdqdnY0QVI0VDhqajhLUll4ZmpQ?=
 =?utf-8?B?YWUxcmNLbm5abFBGOEJRb2Y4eDVsb0Z6WFF5Y0Q5NE1ZOUZ1TnpIMGp2NTRW?=
 =?utf-8?B?eVV5WDFJSFU3Q01jQmNmNFF3cm5rMlRzd1B1Szlqalh4aEZhdFJ0TDdBc2xV?=
 =?utf-8?B?UTBCQXhPUHdvM0RpMlJheldpdnRqaTFqakd0czhTcDk5RU1USEt4UVF5bVNN?=
 =?utf-8?B?TzVaSTcyVy9DbngwUnh6UHdONTJVZG9VMTU2YTZTNmk1MDV3a1dzMUtFTXpS?=
 =?utf-8?B?Z0JxTnRlWmRxdHEyTEg5aXQybGo4cktnNE1GdUo1WlFZNzJ1S1Y3Y2lFNVAw?=
 =?utf-8?B?QzdGREhQVmYrc2Q4NnFJaVlXbk1nQzAwSWJmZ09GZUhjcDY1eDliL2IwOVJw?=
 =?utf-8?B?bXhTd0d1U3lNT2p2Rll3S3VUSlhDZXlrQmt4b1NFRXFpNWwvY1RETWFzY2NC?=
 =?utf-8?B?Nk92bDlqSUROcnlBbURDdVVNa3dzY3VQeG02clMwdVE5QVBjSXB2Q3F3RVhP?=
 =?utf-8?B?amFEYUxKOXMyK2UzTnlhM3hULzFhVVN3ZVhWSGlCcTdqZFpMV0FJVXBReGNv?=
 =?utf-8?B?UzJ4RVRPeHAyZUMvWXF3d2h4aFo4SzY2WGxjWmNhTERNaUl3VUJmZzM2VjMz?=
 =?utf-8?B?ckYxKzhlUTA0TGlxQ3I0R3o0MkxRKzZQQW9qcXMrRmdCekFGY0FQdXVuTVVt?=
 =?utf-8?B?cFJJTG5wTDl4eVNJRSsrWEV1QUFIUytLMk4zdDYvaG5NKzhKQ2VMaFFnekNS?=
 =?utf-8?B?YmNucFdELzF5ZTJEc0JWNmxsL3FMeFJIM1hxY1l5QStsczlaclljUW5ySno4?=
 =?utf-8?B?OTJWdXVWMlFxcC8xeTJpMU93U3NFZ0NSMXdLeDRKU0Z2anRPdXE1OUQwNmhC?=
 =?utf-8?B?NEpMaGxIQmkyaENrN29aSGJDU3Z2ZkNQUDdsZTdrT1IxQnFpRnpZa09sNDNz?=
 =?utf-8?B?eXBzWFFvbFZQQkNhYUQ5VFV2NXJyQTZzVnRLNU9mOXNOUVRRRFpTdnc0SEdD?=
 =?utf-8?B?YkN6eFBweFdPLzA0WWVNSWhiLzhOMVVSQ1JidldQY09BK3lKT2c1OEV2SGd4?=
 =?utf-8?B?Si92NmpEa2VIL1JlRTQwRG9iTFBSVnBKTDA4T0N6VThTWUpVcGNJV3U2cWtr?=
 =?utf-8?B?WUpMZkRyRFYrTDI2dmtMaVduYUxqN29sR3d5ZjMyY3BkOTZTRU8vZjBlMEdB?=
 =?utf-8?B?VHo2V1QwUnRyWjhiTFBxMkUxQVBpMjV4YmVvY3VCV3VXSkxidy93RGxzTUl1?=
 =?utf-8?Q?lwvgiaXlnYVgyYHKyfgY5zYr+06/yM/qG9NZu?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eaa5076-ac7f-4ff3-59f9-08de5748ad23
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 10:51:18.8472 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FTdUJ2ahHv8WaxY8BY2iXqc4If2MRTyc+UJsAxbQxxQRm/BR+c6idMcshAQdvkvY7vR/nyJmSZMCn4rdzI84Sa5GdvDuhpygMIX/pApstnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11971
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

Hi Mikhail,

On 1/19/26 1:36 AM, Mikhail Kshevetskiy wrote:
> GPT disk partition with max available number (ex: /dev/mmcblk128) can't
> be read/write from U-Boot using read/write command. Here is an example:
> 
>    => mmc part
> 
>    Partition Map for mmc device 0  --   Partition Type: EFI
> 
>    Part	Start LBA	End LBA		Name
> 	Attributes
> 	Type GUID
> 	Partition GUID
>    1	0x00001000	0x000013ff	"env1"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb02
>    2	0x00001400	0x000017ff	"env2"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb03
>    .................
>    8	0x00158000	0x0034bfff	"apps"
> 	attrs:	0x0000000000000000
> 	type:	0fc63daf-8483-4772-8e79-3d69d8477de4
> 	guid:	5452574f-2211-4433-5566-778899aabb09
>    128	0x00000420	0x00000fff	"fip"
> 	attrs:	0x0000000000000000
> 	type:	c12a7328-f81f-11d2-ba4b-00a0c93ec93b
> 	guid:	5452574f-2211-4433-5566-778899aabb01
> 
>    => read mmc 0#fip ${loadaddr} 0 4
>    Could not find "fip" partition
>    ** Bad device specification mmc 0#fip **
>    ** Bad device specification mmc 0#fip **
>    Couldn't find partition mmc 0#fip
> 
> The error is caused by invalid boundary checks. This patch fixes an
> issue.
> 
> Fixes: 43fd4bcefd4e ("disk: part: implement generic function part_get_info_by_uuid()")
> Fixes: 56670d6fb83f ("disk: part: use common api to lookup part driver")
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

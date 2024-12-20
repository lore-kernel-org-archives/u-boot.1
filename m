Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551B2E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 06:57:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD7F48007D;
	Fri, 20 Dec 2024 07:57:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="MT+UGG6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF0828021A; Fri, 20 Dec 2024 07:57:12 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2070b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::70b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 882898006D
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 07:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCPW2+J4xgawTh6/Kx1IXwYI418O+xC+bjXhtyOUSTcUNllRMwP+lnw2vnPSPqIwB+8ANiutJVl544Y/5ekGreZIKW+1MkdiMLyUgdVhYoiAEA5pm9dXChoOfClAXhdvgNoGklWaMASzAPGVkcZWoCoxPKilbfdLaDLaix4LIArj17d2A7+g06hga3HvyIYY8IeqCZf9Y0OYNTVkG59hIeuCCdN6dP2sPicqNGS6LbVVS2mD8RejDXmDtSnZbxwbwpLu3gK1wHO65SnSUACTEDjXp0Bq9yThL+AUoHPMQywDoFE072euJe073dKoi1hg24qRJ/dGgzvPfNZSMt5sjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzgF+4keesFtmFZu4dbSSPCv9qe/ccjf7yTtcnd+O5g=;
 b=sH3z4hvwUkjZrwkPSo7V6keGEPRQeMik8hyocLtvOzktyVaBdc469hKMDTFZ0owf2vSc7OHr61FG/ncCS/wTwh/8fTDPdQhcd6YEgIe0wWAOB3ti9FTnkpM5+ZuTaZsYc8FsZexM5e7GbjyU69PzV9HWLtymWQMpXwtBt4iJcUeVGYRKD43dVXdtQR+3wAcYOzVgYNGTZFsbl/GRqYCmbaGBfCBJHOPuw5IKv/Dm5D+Zv9/FuC/gp4ZuZV//UudlxAYk4AyXRO3JNKnISVQcG6aRbDklFcCyMzJ1HckBgvyc3juDuZ3fLUtOHbP7W2shdWaQXgMRe6YNwZGNt131mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzgF+4keesFtmFZu4dbSSPCv9qe/ccjf7yTtcnd+O5g=;
 b=MT+UGG6vfmgakwufTeDgQDzGQrDSv8bVkpwKvwPrFxyEgGuXj93+jxgnY7YdEXL24yjnVjLPaECHPAuJ4+lnFjyNnkW7E+se1B8mx+k+3m2Q0fHS7LjE84tgC21AAjv3dG37JwuGUtpP1FCgl9PVwUDWZMbJzx7a4lgyNrRM2zxgtpGNNke8jVAaW76g0Z/5gq+z6zBTNvdco1NN/XHHdRs2RLCJsmlJDfbERTY2YxW6rfyV0uqBcujuXpoKzhctUDy99Mm+USHMbEArswI5c48lLBiENo25d30Ra0oUgTslKz2n+Mi4LKfzch/qUdaXPX6VjxhTDjzbghZsptUzdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PAXP195MB1184.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:1a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 06:57:08 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8272.005; Fri, 20 Dec 2024
 06:57:08 +0000
Message-ID: <07382382-3e9a-427e-b33e-6510060c51fd@phytec.de>
Date: Fri, 20 Dec 2024 13:57:02 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/9] ram: k3-ddrss: Add
 k3_ddrss_ddr_bank_base_size_calc() to solve 'calculations restricted to 32
 bits' issue
To: Santhosh Kumar K <s-k6@ti.com>, trini@konsulko.com, nm@ti.com,
 vigneshr@ti.com, u-kumar1@ti.com, bb@ti.com, m-chawdhry@ti.com,
 vaishnav.a@ti.com, j-choudhary@ti.com
Cc: u-boot@lists.denx.de, n-francis@ti.com
References: <20241213103129.332246-1-s-k6@ti.com>
 <20241213103129.332246-4-s-k6@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20241213103129.332246-4-s-k6@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PAXP195MB1184:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c82bc5-f578-43aa-df70-08dd20c3855a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cTI5QSs4SXRUYm0zMEJrVmRNUFVFL1pCdjFpRENtVTlNbW9mWmJEQlRXUjZR?=
 =?utf-8?B?YUtBaXU0SUdNQVh0Snc0U0FrUGF3TlJmZUhMVGhRRVN4ZU1uY0hHTTQwbU9L?=
 =?utf-8?B?eWRRc3grdVBJdlBnL3ZJQ2lKR242K2IwZUdGMzRrT2FVYnh5Q0d0UUZYV0hI?=
 =?utf-8?B?S2ZYbGdaQ3p5TFRRZm5PaWh6V2h1NzBQMW04a21NVnU3MHFMYVF1STc3c2cy?=
 =?utf-8?B?N2xaMUJVbFo2R2tpWjZiVklGQ3V6VjJ1VlBNd0JGUEhiVEhudDB4WVJWc2ho?=
 =?utf-8?B?MXBnOWJlTmNTNlQrKytYaG5sMnNlbUk5ck1IUFRtNW15alo0VnhBUGlVS0hR?=
 =?utf-8?B?cXR4blVGMHZyUzA4S3gzd1VYNjlBa1VCRElFWExWN2NPYTc3aGlhTTMwT0hQ?=
 =?utf-8?B?ZUVvRmJ0aVFXbVVxdDJNMmlpNW0xWnZxWnM2OTl1MFJZSDQ2L3lXWjFrbmRQ?=
 =?utf-8?B?TDdpOVMxVFhxZWFPQVRhSGV0WHJ3WTZCWTc2eExhVVBTYmhUMWdGS2twWC9S?=
 =?utf-8?B?VE93NVcyY1VPNm9ZYjhoT2pxQjhFMndzcTdWSTJpMHhCZUFZN2JoUFFFQkdZ?=
 =?utf-8?B?QlFmN1NpaitGaUFMR1FLenc1N3MzRnY3U0l1UmpteE9DcUc2V0txK1M1UDIz?=
 =?utf-8?B?V2pJV2dFZDA1RW1ndkJVL2czeHAwcUNUU0QyTkdVNllJMitGTUZuNDI2OEZZ?=
 =?utf-8?B?dlV1MFlWMEFsVW1hcFlmMlZzLzAwTVpUcDBvVCt3MEFUSTYrYUlMb3dtZzg3?=
 =?utf-8?B?US9ML0JNWnorbk9vQWdvSjVrR1F2WUNGTGxDT0RRV2poU0YvWHFJYW0wQXZL?=
 =?utf-8?B?aUY5SFZQVExTRHBOYmpDdTJtTFRkSWNTZ1hvdy9QQldWK3NRTEYwd0gxYzhM?=
 =?utf-8?B?QndhbjBSNHZYVU0rdVlMeFZXbUNmUHA1V2k5Tm5CL1QwM1pEV2MvYWdLZHZB?=
 =?utf-8?B?TWFxZ04zUWxOQ1Y1d2lSc0Q1QTNZR2wrN0JPY2Y2R29neVNOZHlCSkdqYlAx?=
 =?utf-8?B?UWhxcHgwa2R2N2ZXVkhDaW5sQWwrQUxVRTVJc3UrMG9UWHFQeXk2S1MzSWRM?=
 =?utf-8?B?dXluT1A4VEYvQ2pvbHFXRGtLa0tOT01HNnN2UnBzbi9NTEh0ZmtFSzhINkJE?=
 =?utf-8?B?ekl1b3pYRkhyQXZrb3JzbW1SN2N2cUpnZ1FVbHZPTk9xQUIyQ044TDlubldv?=
 =?utf-8?B?MlU3c3FSd20ydUkrTDNMV2NGUXhDOGdxUGRvUEFuV0ZDeXRvaEY5L2dFSUcz?=
 =?utf-8?B?WUZtalFiNjFFb0VLaVRycHZlWEdsU1NCM04xY25vZk83RnlPVXo1akhWWHF5?=
 =?utf-8?B?aW9YNXZ1VFlLUzNxOHM3c1Y3aVQ4RkkyWmwxS0ZrYnZTUU43azVaR3pXWFhH?=
 =?utf-8?B?VXpvTWI1QXQ1UnFsUmsreWZuVk1uTVhWbDl2V2d2VEtKSE5uc3FOVW5rR1pK?=
 =?utf-8?B?RkRDeUFTcDhvM00xQlgvOEZWeGdhZWxGTkM4RnRGZlFKRE5FNk82dWlRcEc4?=
 =?utf-8?B?cGZEYmVnejFwUDdlOG4rSHdLU2JBQ2xPQXpuOHhoRWRHazVMMlJZZ3B2QWRV?=
 =?utf-8?B?TG9xb01LaCswVVBJMEJOQ3hUL0xzcitOOGIvd1BmbWpJUzBEYjBwdVAxWkU4?=
 =?utf-8?B?WURBbnFtUFhCamtiendDblBsTnNqUTF4cGRCa2dzUkpFblVNbmc4c203MTRz?=
 =?utf-8?B?dGVteEtBZFE1KzdhWWFQZzJaQWQrT2tKZG10ODlic1VKZWt0T3NoTC9qY0ND?=
 =?utf-8?B?ZFlPK1lJWXluNzB6MlNxRmF1S3dFaUtvd2E3WE9IRXZvTjd1dFhDMFJqYmk0?=
 =?utf-8?B?Zmg2ZnJ3QUZzS3E1NGJuSW93QXJ0VC9RNVh5WjY0NVBvbW0rcEVrdEZ4YlFY?=
 =?utf-8?Q?E8cuffFDwPXqt?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0h2U1k3UW9vMlNRLzNSK3hJandUQ2loU2Q2VXVPa2d1Q3ZkQ0pQU3VTcEh1?=
 =?utf-8?B?T21nVzU2U0RLRmZWa1dPSUJmQTNqZ3ArSFhROExueVo4aFlJTHREWklySG9B?=
 =?utf-8?B?RjYxR0V0VHFMM1gybHRSWjdHendQTVFhNzdaMG5RamxLTzlOTlNqTkNFRW1h?=
 =?utf-8?B?U1VUNkVqUnYzSXZ1SEZ3SllSUGZnaGxQclVEaE55WHlJc3ZwckxraWQwU1J5?=
 =?utf-8?B?aTJiSDE2Yy8zcVVZSU8ycDdGOEVyZU9QVFlXMEdvOStxZTBTWXVrN1RyczRS?=
 =?utf-8?B?K2VmWDFMdjVqNDBqM1ZGdXprQTU1amdlVGJMeHRnWVB3a3dnTTBzOUxTVWpJ?=
 =?utf-8?B?blB5MndUVmJJSnYrbVM0dmZSRCtseEg4cEJ2QVJ2Y1UvaFloeTRrWmY3L0ts?=
 =?utf-8?B?cDMxeE5KdFc2R2taMzM2NXVFTExFeG5LWEs2UEM4YncvRUdiNzlpR09GdGZZ?=
 =?utf-8?B?V255Qkt2UFd6TnUyRFZnSUtxYUplVGlvbU1vU1dUNUk5b1FDRFMzQlE0a3B0?=
 =?utf-8?B?UDh2aGxtR2dSYWtoRnRCODZyQVNuOGxhRktLRGVoeWNjZG5VUFNYRXZrek9I?=
 =?utf-8?B?S3Z4MXdWM0RoUjQ2VWNtRDB3V0ZjTVUrZUF0amZ0R2hMcktIZnZLVi96Tk45?=
 =?utf-8?B?M1BpeTVzV2tkZDZoTjlJNTd2U2hOS1p0cTBTR2hxdStFeitNcFAvMG5XWlM5?=
 =?utf-8?B?UXFrNy8wb3JHeG1kM29uRlFhZHV0eE5SaC9XNS8vVExVdzhROVVEZHJneWpT?=
 =?utf-8?B?RXlnTUR5d0V5Nm1xTVFkNmJYRFhMQlliTytxTFZkU2RnY2FydVY5d2pvcHh3?=
 =?utf-8?B?QkZyam9OTmhsSUpxalpuZkFOMysxaVV0K3IzaXI2YlhKMllVSWphRmt0Q2Yv?=
 =?utf-8?B?MElMMjA1MEl2YkxIN3RjdlFJdlVkcjMvak5ldGhITmEzUnBFNXowQW9WL3lB?=
 =?utf-8?B?UUlQaTk3UHlOQ2liWDltNTB4bVZScSsrL3RLUktsay9QUW81QnJSSGNrWDlQ?=
 =?utf-8?B?bDEyNGYyRDRlakNyaE1LRGRzenh3Q05aSFgyQkxSZ3ppM3hFQU1mWkdYQmlu?=
 =?utf-8?B?VGtGU1h1ZEJFcnF2UGJjOWJEbWZBSUwwK1dZQURWQk9iN3labE1XSkh6dWxH?=
 =?utf-8?B?dU9FdkNQYzVqaFdDcjBKN3h0YXhNOXF3c2phVDFoRWNUeXRiOFB6YjdqMENk?=
 =?utf-8?B?eHNyb21COUVUYjNOLzZaWGVuZm9XOGFqd0tuZnkxQWE3LzVPOWsxWHp4OGV0?=
 =?utf-8?B?eFRkajJFQzBBbElaT29FUHpaWkFRaVZ5WGNUWTNYR0NQTkNRVllnQUJQckdI?=
 =?utf-8?B?dTRlbTYwMytiRlFiTngzUVdLQ3hhaDl4VlVncFcrWkczNzlsYXkyS3NadDIr?=
 =?utf-8?B?c3FYRk8xNmFlTVN5RDh4T000dmdUNUJMTklwZ2FuT1Erc1ZaTjY4WVh4dGw3?=
 =?utf-8?B?YXQxZjB3R1B3czBzSEdqMUMwM2FKaXRYU0JQN2d1NzdJYkc3Q3d6MnptZ2I0?=
 =?utf-8?B?Z3c1Zk5sUTJNOEFtcmZjOFpqcXlKenlFUWFadU1KWDIxYzRSMUpNOVN6NnVu?=
 =?utf-8?B?RW9WWDA1TW1kcE12YnB0RGhudFo2T29Kb0cxSitNWWZTcUFzZjJoNmFtbGpU?=
 =?utf-8?B?MUxkcmpSVFZvb2o0MjFvMEtkd2F3VE1MRzlDUHFDSm5oZG5idzJYbHA2WC9j?=
 =?utf-8?B?NUZyN3d3Rm1QUGZmWkZIU1AzQVBBVW5tTXJFZ0lBRFd5aTQvZWdkTm1EN0t2?=
 =?utf-8?B?Kzh5UmNBNmpTYlJjelRKcnIzRkN1NkxpcDRGT1lzVXhUcmVUZFU3b1o2Mllx?=
 =?utf-8?B?VXRIOWhBa0k1dmdHalRhTHlZdG1TWWR1L0JiQVRVSTNhUEhCTUljU3M4VEZH?=
 =?utf-8?B?K2JsZmVkTkN0eGxCV2VGYzdFd2l4YUJkZmF2YTRENE0vZXdNT0RneFVSK3dU?=
 =?utf-8?B?Y0sxQ2VMM2dSSExoUHNVaGZza0gyTCtFWkJFVHZpVmVMU2hOeExHNTY2QnVv?=
 =?utf-8?B?a2pHUWRWOHRLc1k4aG4wbS9SSFhnSEU5N2g5U3FkU1JIUkc3R3dPUXVJZyta?=
 =?utf-8?B?cWtGYTNRcHdBMEVadjBHZGhnTlJIWXFiQ2dzR3hnWGkzRXBnQ3o2NXdiQk5O?=
 =?utf-8?Q?7FiY1gRbvQ0tldvoq8NnID0H/?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c82bc5-f578-43aa-df70-08dd20c3855a
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 06:57:08.5541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLZ1TgVMx3r6HUfcA+Rfqnpbg+1FQ5P6pRr8s9+UVmTE5aT1P6htSwr8tEZlm/qfAeQBmk3voTYOPE6cs/re/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP195MB1184
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

Am 13.12.24 um 17:31 schrieb Santhosh Kumar K:
> As R5 is a 32 bit processor, the RAM banks' base and size calculation
> is restricted to 32 bits, which results in wrong values if bank's base
> is greater than 32 bits or bank's size is greater than or equal to 4GB.
> 
> So, add k3_ddrss_ddr_bank_base_size_calc() to get the base address and
> size of RAM's banks from the device tree memory node, and store in a
> 64 bit device private data which can be used for ECC reserved memory
> calculation, Setting ECC range and Fixing up bank size in device tree
> when ECC is enabled.
> 
> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>

Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   drivers/ram/k3-ddrss/k3-ddrss.c | 72 ++++++++++++++++++++++++++-------
>   1 file changed, 57 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
> index c29eec62bd8f..29ce53453c1f 100644
> --- a/drivers/ram/k3-ddrss/k3-ddrss.c
> +++ b/drivers/ram/k3-ddrss/k3-ddrss.c
> @@ -147,6 +147,9 @@ struct k3_ddrss_desc {
>   	struct k3_ddrss_ecc_region ecc_regions[K3_DDRSS_MAX_ECC_REGIONS];
>   	u64 ecc_reserved_space;
>   	bool ti_ecc_enabled;
> +	u64 ddr_bank_base[CONFIG_NR_DRAM_BANKS];
> +	u64 ddr_bank_size[CONFIG_NR_DRAM_BANKS];
> +	u64 ddr_ram_size;
>   };
>   
>   struct reginitdata {
> @@ -663,11 +666,54 @@ static void k3_ddrss_lpddr4_preload_full_mem(struct k3_ddrss_desc *ddrss,
>   	printf("ECC: priming DDR completed in %lu msec\n", get_timer(done));
>   }
>   
> +static void k3_ddrss_ddr_bank_base_size_calc(struct k3_ddrss_desc *ddrss)
> +{
> +	int bank, na, ns, len, parent;
> +	const fdt32_t *ptr, *end;
> +
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		ddrss->ddr_bank_base[bank] = 0;
> +		ddrss->ddr_bank_size[bank] = 0;
> +	}
> +
> +	ofnode mem = ofnode_null();
> +
> +	do {
> +		mem = ofnode_by_prop_value(mem, "device_type", "memory", 7);
> +	} while (!ofnode_is_enabled(mem));
> +
> +	const void *fdt = ofnode_to_fdt(mem);
> +	int node = ofnode_to_offset(mem);
> +	const char *property = "reg";
> +
> +	parent = fdt_parent_offset(fdt, node);
> +	na = fdt_address_cells(fdt, parent);
> +	ns = fdt_size_cells(fdt, parent);
> +	ptr = fdt_getprop(fdt, node, property, &len);
> +	end = ptr + len / sizeof(*ptr);
> +
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> +		if (ptr + na + ns <= end) {
> +			if (CONFIG_IS_ENABLED(OF_TRANSLATE))
> +				ddrss->ddr_bank_base[bank] = fdt_translate_address(fdt, node, ptr);
> +			else
> +				ddrss->ddr_bank_base[bank] = fdtdec_get_number(ptr, na);
> +
> +			ddrss->ddr_bank_size[bank] = fdtdec_get_number(&ptr[na], ns);
> +		}
> +
> +		ptr += na + ns;
> +	}
> +
> +	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++)
> +		ddrss->ddr_ram_size += ddrss->ddr_bank_size[bank];
> +}
> +
>   static void k3_ddrss_lpddr4_ecc_calc_reserved_mem(struct k3_ddrss_desc *ddrss)
>   {
>   	fdtdec_setup_mem_size_base_lowest();
>   
> -	ddrss->ecc_reserved_space = gd->ram_size;
> +	ddrss->ecc_reserved_space = ddrss->ddr_ram_size;
>   	do_div(ddrss->ecc_reserved_space, 9);
>   
>   	/* Round to clean number */
> @@ -691,7 +737,7 @@ static void k3_ddrss_lpddr4_ecc_init(struct k3_ddrss_desc *ddrss)
>   	/* Preload the full memory with 0's using the BIST engine of
>   	 * the LPDDR4 controller.
>   	 */
> -	k3_ddrss_lpddr4_preload_full_mem(ddrss, gd->ram_size, 0);
> +	k3_ddrss_lpddr4_preload_full_mem(ddrss, ddrss->ddr_ram_size, 0);
>   
>   	/* Clear Error Count Register */
>   	writel(0x1, base + DDRSS_ECC_1B_ERR_CNT_REG);
> @@ -736,6 +782,8 @@ static int k3_ddrss_probe(struct udevice *dev)
>   
>   	k3_lpddr4_start(ddrss);
>   
> +	k3_ddrss_ddr_bank_base_size_calc(ddrss);
> +
>   	if (ddrss->ti_ecc_enabled) {
>   		if (!ddrss->ddrss_ss_cfg) {
>   			printf("%s: ss_cfg is required if ecc is enabled but not provided.",
> @@ -756,30 +804,24 @@ static int k3_ddrss_probe(struct udevice *dev)
>   
>   int k3_ddrss_ddr_fdt_fixup(struct udevice *dev, void *blob, struct bd_info *bd)
>   {
> -	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
> -	u64 start[CONFIG_NR_DRAM_BANKS];
> -	u64 size[CONFIG_NR_DRAM_BANKS];
>   	int bank;
> +	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
>   
>   	if (ddrss->ecc_reserved_space == 0)
>   		return 0;
>   
>   	for (bank = CONFIG_NR_DRAM_BANKS - 1; bank >= 0; bank--) {
> -		if (ddrss->ecc_reserved_space > bd->bi_dram[bank].size) {
> -			ddrss->ecc_reserved_space -= bd->bi_dram[bank].size;
> -			bd->bi_dram[bank].size = 0;
> +		if (ddrss->ecc_reserved_space > ddrss->ddr_bank_size[bank]) {
> +			ddrss->ecc_reserved_space -= ddrss->ddr_bank_size[bank];
> +			ddrss->ddr_bank_size[bank] = 0;
>   		} else {
> -			bd->bi_dram[bank].size -= ddrss->ecc_reserved_space;
> +			ddrss->ddr_bank_size[bank] -= ddrss->ecc_reserved_space;
>   			break;
>   		}
>   	}
>   
> -	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
> -		start[bank] =  bd->bi_dram[bank].start;
> -		size[bank] = bd->bi_dram[bank].size;
> -	}
> -
> -	return fdt_fixup_memory_banks(blob, start, size, CONFIG_NR_DRAM_BANKS);
> +	return fdt_fixup_memory_banks(blob, ddrss->ddr_bank_base,
> +				      ddrss->ddr_bank_size, CONFIG_NR_DRAM_BANKS);
>   }
>   
>   static int k3_ddrss_get_info(struct udevice *dev, struct ram_info *info)


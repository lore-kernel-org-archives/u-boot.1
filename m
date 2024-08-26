Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CE9C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 15:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70CEE8895B;
	Mon, 26 Aug 2024 17:56:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZGEyqN6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702F6888F0; Mon, 26 Aug 2024 17:56:50 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6BC889C5
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 17:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Idki93AduCnbOommLsVWsTlMTpttkJC03eut1LWkZWuRNnXW8NCLQ6/oH62WihW/krIofGn3j2AihbxlGyC1eNWXdtBBGaVWq2r36Gi8F2f+s3OY89rsHdvknw27JOZCfKeoqkgAVgHB7lgzANC2zvEVdDWyrH3KiOLvECPPt0W8MJlAVVwClfgmCjYt28g5ht8ZCwmaVSbXQ0zcqjUbLckW4PuSY5e02vEOwdfIq8HMKILkXmuEiVI37Dj1j4khg1h6+FsyP59jVj4D+DXJx9pEfWra5Dl0ceXLe5fiZasRJvuDXVv0frEKkba7rFwsAypogtyqfawrCjdDmlNQCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YW7KYKzJDYC0yVCbDVtJ5uHZV1fzcOQeGY13L1IUStY=;
 b=dvaB/gnLUL6l7gBD0nTWBp6/9H+bNwth4Ey92YVgmZ+86mCCGYvVnH/RCvZdyxE5P0tMyDj9iTOeBsmZpr3T5j4Km3UiCps3sNsZhxlryXdUamUpoB7B+8D7xWnd1p2UDTWR6m7ZYRjmfOwO5bqrmCuKwdQHvCBsPoz6foC3AFV3QF8xgntM/uR+DUyWqR9MHx0BtJM8RK5MoDSAczG4uE95WQSW9251ybq/DjSK9EksYepF0OKIStvZHFATT/hoNMKeoAm5ncK2mkDAB15QewN5+zkzBC71RN7Urfb8wLq1t1Y3dqwr+cILEtJrKOG0DX9AwMsre6seyqBqxAz5hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW7KYKzJDYC0yVCbDVtJ5uHZV1fzcOQeGY13L1IUStY=;
 b=ZGEyqN6XM5uwzA5cXTBoVyLJAbEOdHSOhvVBKweUgsJmFXHrblnWy2TXTVQc9qrKOmUQvpRrONIrpjHET8WAmoAuKU0ybQQ8WWACeSKUQFLWcm/Y7hABmRnCYfi+qHpvlLpQpsFFH2WBQ2kQKPoR161cQzZCHSqGMjCzaXX1mV8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10204.eurprd04.prod.outlook.com (2603:10a6:150:1bf::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:56:44 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Mon, 26 Aug 2024
 15:56:44 +0000
Message-ID: <da1bb893-a6f1-4dad-bacf-31e7b021d955@cherry.de>
Date: Mon, 26 Aug 2024 17:56:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] env: Provide a work-around for unquoting fdtfile
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>, Marek Vasut <marex@denx.de>,
 Michal Simek <michal.simek@amd.com>, Ramon Fried <rfried.dev@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sumit Garg <sumit.garg@linaro.org>
References: <20240823204824.443631-1-sjg@chromium.org>
 <20240823204824.443631-8-sjg@chromium.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240823204824.443631-8-sjg@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::15) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10204:EE_
X-MS-Office365-Filtering-Correlation-Id: e6400bf0-724f-4391-3d33-08dcc5e7aed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QzJSOUh0d3BYWFp2d3F4NjdGeWRkLzRiVXRKOTBOWmJwSUpqMTFZQWhVTjRz?=
 =?utf-8?B?VHl6MWNxVFpQdEZSU3R0MkMrVmJsenArRXl4WXJGUklTVTFIbHJKWXJibVpV?=
 =?utf-8?B?UDRqbDlncW9aVlBiK1ludmtIalJrd2RpZFNTQWN2NkRobVdFNXFmd1o3ZFdX?=
 =?utf-8?B?ekluS3IwR092bklua2lHaWNwWlA5VEI4WS93dU5rTFJmWW9TS3VsTDEyeWpF?=
 =?utf-8?B?YnhjaFJhaFJiNmw2bGdPSERuRVlUZjdDdTdWU2Z5bGk4cU1iVTVrQW9UdzRn?=
 =?utf-8?B?RVhXbyt0S3BEcDJHTWl3VFBSOHA4TjFQU3ZkSTdPUXJNYm1mR1F6bklQQlAz?=
 =?utf-8?B?QUtsemdYRmpyYXNVNTJNWTM2aEVLY09NcE40YmtJMFowSXZNS0R1K0Y1Wm83?=
 =?utf-8?B?Z3p6aGcreHZWVk5IKzBwdWIxcnN0Y29RdHlpRUdoRCtkMUlqTGo1QXpMeDZv?=
 =?utf-8?B?NER4T3IyZmtoZjVDSHpvenByQ2JPZVdGbzJTYS9oRVNPN2JMNlVDczZpcXhM?=
 =?utf-8?B?N1E2THQ3NUNuQ1hZRzNkSzllaHNXSVlaMGxDckpuU2U1emVCbDNMMzFnVVF2?=
 =?utf-8?B?bHNreXp2Q3pSaUc3UnVyUUZsZEp4dGNPU2pZR1gyV2E4cGdTcmhDSWFOZ2E4?=
 =?utf-8?B?T2g0b3dtYXRIWUY2clc2ZEt0L0NkZnd6TmxNWkY4dFN2blZZQndSN3hwNGN1?=
 =?utf-8?B?R2xxY29JYWhtY1NmSXB0TnZrbU5oRFdUUG1aYjlMcHVVNmpRZE5oV2xJbVdn?=
 =?utf-8?B?UytjQlZyWVBLMEt1NXRpb2V5MVNGaWFLREJjYzEzb2VneFBlaEs5bHBYSEdE?=
 =?utf-8?B?Z0JMeHVwYmErdVJ0R25XdTYvNTBtUXNvcXo0Rmk5ZUJ0b015a2srZ0pGVWlU?=
 =?utf-8?B?Q0hobkk5S2NQeGRWY1AwOEZ2bVY4MXVOUGlwMG1BdWZDa3hBV3hjZy91Wk9S?=
 =?utf-8?B?UG9TSFhZMHZqODNzZVRpc0dsQ0tidzdkbXE5dTNsZU41cndaVGIyd3ViZC9E?=
 =?utf-8?B?SVZuNXhFL3RldmI5c1ZGeU5HYkV6ZmtlTlBMZnJNTjJFUVVMZWNnNDJaT3cy?=
 =?utf-8?B?dGYyUUZrZExqNUVOblhZaFdaTndMekd6aFdaNS8zZ0tBcmZvVVVBMmxyV0Z5?=
 =?utf-8?B?VGhpMXpvWlBwM1lpQ3c4NzE3NzdIL05PazFqL2Jnd2JMOTUybCtieU5oaURY?=
 =?utf-8?B?RWN5YkM4WW9VdVFXREs0bzd0WXRvUkpvVldIUGg4NE5GT25VRTNHN29haVVq?=
 =?utf-8?B?NlFqNlRVK2dwVU5Wa1RhRk9wN01jMU9Cby9OVlkwb1Q3ZkVlczlXZ3dKeFlR?=
 =?utf-8?B?bEk5N0U5R0pMRFRFVE84OUJlVlNCR0tWTVNOY2h5enBkWSszVWVBL2RjdEtj?=
 =?utf-8?B?Mm1VdWUwUmpveS9oUDJxTGlkYUJlWFFJS2FBL3BhQ204KzlPbnRseGcwcSt5?=
 =?utf-8?B?T0UwbkM5L1p2L1VyOVpJSVBFNFZpMXpnNTQ2a2kwU0lrVjgxeU02RUNZdDNF?=
 =?utf-8?B?RXRLSTg4Ymp4ekJMUVhtTE5EaHY5emtPdG1iYnpZTmM4UTJWeWpOdEJOeHQ4?=
 =?utf-8?B?MWFtQUFZNG1kMytxeS9SOXZnVW1tTDA4WktEc3hOOVR5OFpPM0hjdEE4bXF3?=
 =?utf-8?B?S1VNTE9HY1VlT3h0a3MxcjFqOTZQdy9YdTVHemM4VmNXNDNXeC9lSkZHSGRX?=
 =?utf-8?B?SzkrL0YzK2lINVp0cXZMSzd4RFhkS3VtZGpIRGZiZTY1Q1pyakluc3E5Y1c2?=
 =?utf-8?B?V2EzRUQ0YXN1UytzOVZNWWE2Wk9NcnJIS0NXSlFzMDNJUXlubkRYQmtHT2w3?=
 =?utf-8?B?Tk0rUndDaXR5bFlpRElJdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1kxUWdyU0RZU3lYMU4rZ3Z2czhTUGlJVzZreUJyREl1b2ZHemFVN3QxT3dW?=
 =?utf-8?B?cUd5Q2U5MFR6WHBWenBSTVRVWjNCN1BidFBBanFGLzhVNVJ1RWErTUlZRk0z?=
 =?utf-8?B?aWkydXpCcFNicVVHVklYNnRhWGk4MFdiY3hYY1BSaG1mbjUxRVdUR212NEcz?=
 =?utf-8?B?QU53UTUwYTd6SVdKNHFWbFVwd1RlSFp0R2RnNmJEc1ZjcHVkWU5Gc2JTdVl0?=
 =?utf-8?B?aUJLeVVNdURnZi9vaWlxbDRhWXJNNTFESmI0Rjl4QzJEdXJjRkoyOUtOVVNt?=
 =?utf-8?B?ZXBrajkycmxMRlpNWkFZbGxFSEw5TDNyRXBvckJqREhkZFVYQ0F5V3FjZFFI?=
 =?utf-8?B?QytMZlNmRk5Vd2ltVGNqeVdraHcxc1dEUDRZY1U2RThwbUdmMnVRdG5QMXlU?=
 =?utf-8?B?Q0phWlRUQ3hjdmJHb0RMRXVhMWFzQ0JVMDR3a1J4RHMxZEJ6Wk5uQmFUcnNO?=
 =?utf-8?B?c0NLR0VuWWZnM3ZaR280UjdQZEprU3AxVTR4c29hZmVnejFYM2VWdmlTS0hR?=
 =?utf-8?B?SDRESnNtcW92NUpBRXFmdDU2RUNiWXVJOEY0aGRVaEwxYjB0NjB2OFVkQ1cw?=
 =?utf-8?B?RU1IWkZ6ZXd5WXNtcmtnNDVRNDUvL29EZ0J3RFEwY3gzaXlHY1IweEdvYWtv?=
 =?utf-8?B?ejJVeWpKVXAwdU56NURsbGE4cUl1Q3N0cHFXYkFCNkJhZ2pySzR1M0hxckJB?=
 =?utf-8?B?bXhJQi85alBjeXlvRlVKZE0vMms0Mk1WcFAyMXBBV1BTaWZTMXl5dTFzSElz?=
 =?utf-8?B?S0ErSFNoRW1uSllDODM2ellBSjN5djlVUFVWYzRsWWhpQkZJMEtXcUtaREFF?=
 =?utf-8?B?eDNJbW1qQ1FwLzFOZmFYbCtKRTYvQjN1bUZWc3lBTi9VR1FlQjAzcVI5NU5G?=
 =?utf-8?B?NkQwcnZjVUhFQUE5dkJHTG1SbDRSbE1iTi85TTMyTmRhakdWUXJ3anRpTHVw?=
 =?utf-8?B?bm1jMkRxUFNzaWRmdGxxRW9qb2twQ2hpaTltK1dNVzErMVZ1WC80bHRLZFV4?=
 =?utf-8?B?NkJIOXNzTExFMTh2ZU1rd0REQmVQOFJvWnhXSGtqZnJIM1k3aTNXQzRMTkl1?=
 =?utf-8?B?bjdDcmhvdzVUVDZMK1Z3OXVXRUZkTDhrN3J2Z01DQTRSamtCZVBKWnRZSWhG?=
 =?utf-8?B?RGlLSlovS0RXRU44T2xXcFVaKzVMdVJRSnY5bEUvTEU5OXRKWDNyR2FQSnVJ?=
 =?utf-8?B?UGN3M3h1NkFZWXVZZXhEV3dObW11Vng0WUZIemZaeUhLTUhtZmhacjNSSE9S?=
 =?utf-8?B?MUFCNUtLT21tU29Uc0oxNXZQVExQRGNzUmVRaWNsWnluMk9iaGFvWjNJVllo?=
 =?utf-8?B?bFlZWVYrcTg5OWEzWnJtK0kzdndsTEF1QS9zaXZNQzA0ajNkUjBrUkgvSnhu?=
 =?utf-8?B?aEVFaER4NzZMYTM5UmJJV0VXbG5SVHFhZ3l0MmovanlnbDA1ZGhmSW1pREtu?=
 =?utf-8?B?eGZqMzZQTjBwdEFmUWprVEp6eC80YWJDZFlZNmVTaEpWYnBnRHNLRkVqSnlL?=
 =?utf-8?B?ZXhNbTJMUC9lS3RCc0RPckc5Tk92b0ZXNFdOREloUkdOVXllNms4T0VlZVNJ?=
 =?utf-8?B?eUd6V24yRlFqTUttcGpOYlY5MC9WRjhEWlVoU3V0dE9DUFBpNndSK3orSzRJ?=
 =?utf-8?B?NjVBSGVoeFo1TVp4SXF0WGVkdWlVWCtyc0w4Sm5MbkdOZy9WWFZ2L2Nud1R3?=
 =?utf-8?B?dEFWTW15c2tGa1FZY1pEOVhoSTdZSTJsNHpqaUZVd05OR290RkFRN29nbEFn?=
 =?utf-8?B?TTBZR0NpMXROeGVNZGlreFNqa1M0dTRBL0RtTXliVzgwd3dwQXBsaDliZjRs?=
 =?utf-8?B?aitDVHovTEhrUG9CRU1PR0pUenI1WnQ5b2QzRDYybFR5VEwyUHRYYytPb3FJ?=
 =?utf-8?B?cHc3S0RSL0U4RGtUdDNad0xrNHROQ1RSWmhzaG9nd2Fza3dMdE1EaURWQWxR?=
 =?utf-8?B?ZHFoRlJZSnYzMUlnc1pHelB0TXBtRTN1MEdQRU4xb0c1UGZJYjBkSmVsY2Y4?=
 =?utf-8?B?UmtsNm9pbzB4dmJ3VHMxa2d4NDBpSXE3NFdLT3JkTVUxSk5NMkx4WHNMbEJm?=
 =?utf-8?B?d0pkWnhFMm9yWGpwOHAyaThNT1VDOXNYd3UzeTRYOFZDYUMzOUpLaUxKTDBN?=
 =?utf-8?B?UlIwZDI3cXRXSThzdmJBK05YNWI3SGlKNEg1T3g3TmxZaE55Z2NlRkRJckFK?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e6400bf0-724f-4391-3d33-08dcc5e7aed1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:56:44.3311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NeycMUesT4/UOvl+hKivNR/W1Iwl72k2f2ThKZ1wwy0cxzHzasQev9ggkxVFSQWqaZ2S+nGmRIBqSSBCCY3yP86M8ZTsWGqQR/w86H+bIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10204
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

Hi Simon,

On 8/23/24 10:48 PM, Simon Glass wrote:
> Some boards use a CONFIG option to specify the value of this variable.
> This is normally handled by efi_get_distro_fdt_name() but in the case
> of sunxi this does not work, since 'soc' is sunxi, but the files are
> in the allwinner directory.
> 
> Provide a work-around for this particular case.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   Makefile                  |  1 +
>   doc/usage/environment.rst | 12 ++++++++++++
>   2 files changed, 13 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 9a52cc8d0b4..2452a916244 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1844,6 +1844,7 @@ quiet_cmd_gen_envp = ENVP    $@
>   		$(CPP) -P $(cpp_flags) -x assembler-with-cpp -undef \
>   			-D__ASSEMBLY__ \
>   			-D__UBOOT_CONFIG__ \
> +			-DDEFAULT_DEVICE_TREE=$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE)) \
>   			-I . -I include -I $(srctree)/include \
>   			-include linux/kconfig.h -include include/config.h \
>   			-I$(srctree)/arch/$(ARCH)/include \
> diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
> index cc33d3ec0f2..eaebf61742a 100644
> --- a/doc/usage/environment.rst
> +++ b/doc/usage/environment.rst
> @@ -87,6 +87,18 @@ settings. For example::
>   
>      #include <env/ti/mmc.env>
>   
> +Quotes are not supressed, for example::

s/supressed/suppressed/

> +
> +    fdtfile=CONFIG_DEFAULT_DEVICE_TREE.dtb
> +    # produces: fdtfile="sun7i-a20-pcduino3.dtb"
> +

Is this not rather
fdtfile="sun7i-a20-pcduino3".dtb
? (i have no clue but I've this gut feeling this doesn't match what the 
subst command does above and why the .dtb extension would be inside the 
quotes)

> +For this particular issue you can use DEFAULT_DEVICE_TREE instead::

Maybe use double tickquotes to highlight this is a variable? i.e.

``DEFAULT_DEVICE_TREE``

?

Cheers,
Quentin

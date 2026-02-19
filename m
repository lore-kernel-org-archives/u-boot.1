Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC9EE9A048
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 10:31:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC54683A47;
	Thu, 19 Feb 2026 11:31:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LJOIFd+M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7067683D2E; Thu, 19 Feb 2026 11:31:14 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C02F983936
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 11:31:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nmuLyXXeQTSXfn0Yx3ve4bsuhhw6q009DUk16128l1FKk00TnJ22AUX4bZ1wwcVPmDghq46J6A81SmC9JYsMF/FRoe9fJVkbou5c+HOqphegX85WkNnwKhW3iqU8k/OEaw1SY8i6zYEDMoLoaPIXVLCAgrpxURapn+L95MNEBmI7/cXQLEg/bOZGz0SaxZWX3ZG+k/nNdvv2jbGvGGyy0EkSshtjm+WAqiMeV2nMfPKaeA5LsbcWCJNxBqhs8VWCOetbppstVg71JfbmDv+SfcLhGTL0P3XNjCrrL/i3MFBtteGpGT/DEyGN4Ey+IEJ7jStaqdb9OWtLGOUSB2uoBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDZUx2fVW8xuxA0Zd3jMRQJBOcvrZ/6q1IcD5XZTGEo=;
 b=y38M3Dfp9jxvWi3AnnZP6ogkUGQC1h12IUE7laplUPPhOXW1H78KFbarZ7E1k5RSzuzbtbkaPmli8yB2BziiqSRN6xRO5pIJHNFCceo5W63uRyrCO/n9hIESQ5mE4/DfmvLCDkMRfUTWR9NoGljTLWazwg0fUYW9gWG2yQgJnpd2L93FR+LtHC7vugZlkuge//K00mq26guIofMEy8YDmrh5vIpNr22piHNA1Jstmr61Yc4MNK5EcKTcng3UM3IplCxviUR6uH2zgIYxXcqLL0mLeqqjCOdZHpWcQxz0DM5UFNc32mHZhJx5w9ZTwT93ov2txh7jZaWYCih1qqBqEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDZUx2fVW8xuxA0Zd3jMRQJBOcvrZ/6q1IcD5XZTGEo=;
 b=LJOIFd+MBaVr+0E/glfvGjY8ebJQVB7LckgfBdFsXSb/XtYbqOYCj/Sl72rY8YJbOvpsPgZXT2j1jPyJT/fTZZC8bIzzXXGzCaN6j8Fz3CGBRNtzWawVw/yy5zykY1OOidGzTExi/jAps/q2gvrhCzBoJyMVEbGCtqnu1fh1hWJIiryn5AfHpWvO1D0F0C8MZbUrDjBWufntIZ0oQGbi8JqsQHCOE+llVFxYWNizgC1V1PqnttcbN1SVjOoIXdWVijwTLBgmBnA+TAHGVGij11g/VnCys3SUjEZB1Nxn6RbRKrjBySlLWUFDHpOS5fOky7U2L6YmBP3690Rn5oCtpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB2576.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.15; Thu, 19 Feb
 2026 10:31:08 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 10:31:07 +0000
Message-ID: <96e9ac86-b5bd-4018-a4d4-7ecd7fb0af1b@phytec.de>
Date: Thu, 19 Feb 2026 12:30:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
To: Bryan Brattlof <bb@ti.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: Suhaas Joshi <s-joshi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 u-boot@lists.denx.de, trini@konsulko.com, vigneshr@ti.com, n-francis@ti.com,
 s-tripathi1@ti.com, k-malarvizhi@ti.com, kamlesh@ti.com, vishalm@ti.com,
 d.schultz@phytec.de, ggiordano@phytec.com
References: <20260210092646.w5bugrscifmsh5px@ula0507357>
 <20260209202001.saeaf6l2kz57rufg@bryanbrattlof.com>
 <20260210105014.GB214446@francesco-nb> <20260211101113.GA176369@francesco-nb>
 <20260211112109.56e27kyy4coqpcbb@ula0507357>
 <20260213102015.GA10715@francesco-nb>
 <20260217132150.of5l5qirxkeizsne@ula0507357>
 <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
 <20260218145241.GA179991@francesco-nb>
 <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0266.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::33) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB2576:EE_
X-MS-Office365-Filtering-Correlation-Id: 19851f95-edff-45e1-b5e1-08de6fa1fe1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?emNITGdLZC9HMDVVOERRREpJZUdTbWFaNnBhNERuN2hubk1tSHFYb09meld6?=
 =?utf-8?B?Y2lIVGx1dm42QTYzZ2h3aGtLMFhXTjU4VU9NR1E0L1o4RlNvSzZrWFB3NEVp?=
 =?utf-8?B?SWc5cVAwdWU3TGxlVGRiRFJ4ellwdDM4a3ZOY3g0a2pkMU40MzN3WUhRZmZX?=
 =?utf-8?B?c1lvOGFWOC9UODU4K0hIQTBHdUcrc0RvY21YRlZ3dW1PVmQxQlNsRkpXeXFk?=
 =?utf-8?B?dGNoSkFpbGl2cUorVG94aUdiTEF2dXlFeGcwV2NsL0w4L3MwdlVvWXRUOVZG?=
 =?utf-8?B?STFnRzlJeWgxa3pZUi9jZkplbFJzWWI4NU5oaUdsVUFjOXZOZlNJQkd1SFBx?=
 =?utf-8?B?MEtkaTVBd1N6Tkx5TTBxaFYxOUhDUTY5aG1vVTkrd1VLK01tSkJDenN1dTN3?=
 =?utf-8?B?YWRNcVhhSXk3UFpJQ1FZY2ZsaVkrazFobkIxN1ZiZVBPUmhrU0l2dzhzQzhI?=
 =?utf-8?B?VTdNK20vdlN5NUxnNTFnWm5sZTgrRk9Sb0Y1eW50RGEwSjR6OGRVenpYaHRT?=
 =?utf-8?B?NWlDSktRNUpHTXJuNDdMOGU5RTAzaWlYZ1hmOGpGdnZsY2NDbm1kcVFWZ0hK?=
 =?utf-8?B?ZnFqTVVYSEJrSGgzeUpSalBsUGF6V2s1OWVvR2hjbXdLQmp4S2p5Y3A3eEpX?=
 =?utf-8?B?OWdkWUM0VWQ3NU9vSjdXUU1BMWtYTHlkZEpMUDVBcmVSdVI4NnE4VTBid2sz?=
 =?utf-8?B?WXNXUlNBYTRZdzRsTnhsV3Roa1lRT0xNcEh5VzBVOExtbEtDSWlaSm1VMWdG?=
 =?utf-8?B?ei8xR0VmSms2alB4c3BGNFJ5aFBDRHBaRnlIUjhBWjZmU0MvMDVtYUxNUmhs?=
 =?utf-8?B?Q0cyKzlxUms5RGRMSi92Vkt4RnlXOG13V0cvanpFY0FZdGtKREhUMm9oV0JY?=
 =?utf-8?B?NmlZVUY5aVhaNnZoRHk1M1o1NUJ2Tyt4Q2lTL0gvMkhrM2pRM0pwY2xUeUF2?=
 =?utf-8?B?L3hRQjZhOGE4VUtEOSt3UE1qbFBzbE94bHlHZmRxU1BYaEJKanc1ZW1CS0dU?=
 =?utf-8?B?ZjlZdytkTm5QdWNsVUVIRkxQTkR2T01TcTdyTk9wZ3lCdUpRSldXREVRWGkv?=
 =?utf-8?B?UUlXbnJTZm1jNGxvVFMwOGJKRXZRTU10OTAvbTBtZTg4ZHNhaFJuUHVYcEhM?=
 =?utf-8?B?UjBWclZWeWJDVWlXWDAvMzJnV0JuUDJjMnBpSCtKVlhwYmMxUnNKc0hmbTZz?=
 =?utf-8?B?SGZMMTNMZTVmWExPQUtKNll0Y3RvN0gvcGZzZ3lBb0o4ZG8vN0ZMdXZpemVC?=
 =?utf-8?B?ODg3SWxMOUxzK0tZZVF0bGhFVWNsNUlRMDkwWTJkMHJTK0FSMUdINUhHRG96?=
 =?utf-8?B?Umtoa1ArbnBMYUhyWGsxV0x0cWF6T2YrU2NwM3hLR3ZqOVoraEdIZzRPc3FE?=
 =?utf-8?B?cWJ0ZWQ5YlRaL3RrL0RjdTJNbkpWWVJWZW9XbXRFYjdna1RMMzJhMFRuZGtk?=
 =?utf-8?B?ZktrNnowVGJLRVRiNTRHVGI2ckxzVUJjTDd5N1I5Rkl3VHV6Tmo4bk1EWkp3?=
 =?utf-8?B?VmdaNWpEaURUTWUrckVhbHV4S1NobUN4RGNqcm9icXlOTjlWZGNDelZpSklp?=
 =?utf-8?B?YkZyVnhCL1VGM1R6NW1aWlVLZWZLZXVMOGwzTXFtSzAzdG4vSU4yblFtcGdW?=
 =?utf-8?B?eHJQZFE1RE1qbWVyQ3lrWVd2Y3JMMFBIS2RLVVdXWHBWK1BreXhHRnJqbXp3?=
 =?utf-8?B?TklaSDFzQTB0QmlJMkJnWDJVVnZzWHU5UE52UlNoZUl0elpHbU1EQ1ZNRVk2?=
 =?utf-8?B?SnRaN3RLTFFhSU5zOUV0b2xoZDRubEIzTzdIVDA4Qkx6U2xMdXdqM2gvUlBD?=
 =?utf-8?B?ZEhWZURhNVZQNERqZHg3MnpJalFjZTE1eWo1Q1FkajlmQW4vOU9FN0JYbis3?=
 =?utf-8?B?VkhjZytJRXpzU2I3cUJtS3dMSmFsdlErTFdoL2JobXdxUmhUUlo0YjU0ejNY?=
 =?utf-8?B?Z2E2eDNpY1VWbFdaQ2FKT1E3b2FvNXBuMnBENy91TW02RGhlaFRMRVgxY0Fn?=
 =?utf-8?B?MUJsOC81aFk5Y2pQSTFWeUhyUHdJUmZ5ZlN1SkpBOXNaZ1l6cmlmMkRiRk5q?=
 =?utf-8?Q?auSboq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3Y4d1VidWJ5eUVRNFNVZUYyR0VBUWw3ZWZEaUplR2VMRVhBMU4yUG5lSEdX?=
 =?utf-8?B?U0psTUg2UE9FYm1rekYwc1QxMGExNmFwbzlGdm5MTng0QWd2Tm03amYxSDZr?=
 =?utf-8?B?SmhBdEhQdHZXWno5b0JndW52YlMxbjdsVFVvSndHRjRKUHlidlNTdW1UbmNp?=
 =?utf-8?B?Y3FzK0tUY1R5eXVSQWszMTllRWoweERKWUYwZnhEc2hjdHVCM2NaQWlUWTB6?=
 =?utf-8?B?eGwwd2JSazZKYUZRRjlWSGpLbkVVK0VCV09KSXdFa2RrTnpXN1c0MWI0Q0Jq?=
 =?utf-8?B?VzBXM1R2SmtESjIzWmJjUFZCZ3RNc2JhL2NZK2hTNDI3MlZlU0pPRDBESjhM?=
 =?utf-8?B?VFh6dHhhY3BvcjEva0g5TlNscUZRbURGUnFtNW40R0pvME53OEJwcFJmUUFn?=
 =?utf-8?B?RkZMcDBEZG5POTJhV1JjeXVQbFJKNGxjaTRadjNKbHdQeE44VDlsU2c3QlE3?=
 =?utf-8?B?d1g1UDg2WXhvS0RWTG41N21pQ2lNUGFueURLNGxZSTdteVg4Rk9ueDNTV2Qx?=
 =?utf-8?B?akcrc0VBclhtR2ZFRkczZDRXN0pkZVZYeFhERXlrTkg4RmVKMzZ6TkZib1FB?=
 =?utf-8?B?WkRjRkpHMVMrUU9qRUsyMGN1dVQ5Vy8rY2FUbkJQTitoRkpwcGp4S2h0aDVL?=
 =?utf-8?B?cno2aklGRVpFRkJ0VVhQS3c5RG5kcHJpTzZIQnVKVjZZNEVoTXd4eXF0UFQx?=
 =?utf-8?B?b2VBRHFLY0taWXVwclJyU0Nvd0libm1wV1hKdXpnY3I1YXphWHhxY2taSnVM?=
 =?utf-8?B?NERsZnhsVlFnbGN3cDM1ZTZISlhIcGEvaU44V0hQZFF0SGNHN2IxcXA4aENJ?=
 =?utf-8?B?cC9UMnRIVzNLeHhMSldFRmRTYXduOXVIUDU2YTNPZ3VtTVErVHEzWkxNSDND?=
 =?utf-8?B?STdET09ScEgvZ2lJV1o5SnY1Z3NoQURmai9LNVYxOGpadXB5L1ZDN3lDbGJ6?=
 =?utf-8?B?TGgyTXptMnhQejlTT1d3OHBCV1UxZzdUWVdRTC82V0RMUXQ5Uk9KeTJhL0V6?=
 =?utf-8?B?Y3BYK3lXSS9QNEFaQ1p4aTdoSkIxVkZKMjI0dW5IMjQxRjZuVVlCcmpjYkN4?=
 =?utf-8?B?eEJrUmZ0d2lQb2FJZmkrSDV1S1Z1L3ZUc0Z4L2syYkMzR1VTY1Rqb0VYdk1z?=
 =?utf-8?B?S1ZoOXdXdTY5NWF4RHZ6RitsNkROclFSZm4xdGJxSE9iQU5HbWNWNGNYeitW?=
 =?utf-8?B?cnJVMnVrelBBakVBc0RveVE3T0hNUHlqOWpLU0hwTFpXSFZDSWlpWW1VZmVC?=
 =?utf-8?B?M0tIay9SQVdiZEY5SXVOZDhZWXlhVnJJbWo5U1RyVG9kaGNra0RiSWJuSUdH?=
 =?utf-8?B?RVJ5OE5USGFUZXk1dXlCbmNMdnVNWFJ2dXVKc0w4eGY5OFhBbExNUnBpbUlk?=
 =?utf-8?B?aFREWUFCOUtQdVAySGR0cE41d0Y4Y3dpV1o2OU41ZlRrSHNUR3h2ZzJoYnNt?=
 =?utf-8?B?MHVVMnlqVkRHaFg0NG5DZElOL1RydEhvbW9ZakxobXFWdWMrTWZNMTQ3MERL?=
 =?utf-8?B?MzNES3E4TlN1Qis2a1JBRXJ5eUd1bGJaclA1cEZPdnpOcEhuVUVkQnFXNXl3?=
 =?utf-8?B?UTI2M2U2bHZUTVpaOGQ3YXcwcFZDa0hVelFxbnJnTHJkNjIyZ1JweHpwd0Fm?=
 =?utf-8?B?Q3JITWh2a3B4a3FkeThzUUZrSnh3TVk3Tlk2LzF4RWFmczlTWWYycDFTbjA1?=
 =?utf-8?B?RWg0RjQvbVNJMTBRcE1WTmU3Y1g5NjE0WGxCSVVDa0N1YmVKZnJYNFNxNUJN?=
 =?utf-8?B?VFB3aXBGRVlONjBQUkZXVkl1R29KTE5pZzRnVEZpMzJzNlIreS8vdDYydktw?=
 =?utf-8?B?ZEVmMm96M0hRckNRZ29tLzdOdGUwaTd6OGo0RWd3b0ZlcDhJSlpSQnhqOFgy?=
 =?utf-8?B?cFV0ZGtaT2kzNU5CTk9DZ3BYajF2bGFIalVUYWlBUTgzUFgzd2drcm1FLy9o?=
 =?utf-8?B?UmsyeUZXZUgvTTFiU2dwKzM3RHM3UnpDV3N6U2liV29Vb25CYUJ5dTBIZVJt?=
 =?utf-8?B?YVFnYlpTTkI3bS9OeVQvRUNJaXRtcW96SUYrbG45ellNak1tbXVIVTJwRFZt?=
 =?utf-8?B?SUp6S0U3UDRJMWxsdUsxczFBMHYrR2RYTUUzSVJ4QWRGWWZEUitOUUJ1N3JP?=
 =?utf-8?B?R0I4SEFkU0hDczc3eVBySnRDaXRkZzhBZCtxYkk5WHVVWVZhb3llekh2YW4x?=
 =?utf-8?B?dWIzRXQ2bTZsSDFOdWFhRDZicmxYalN1bEthdXQrYXhJdGRkT0QwcVhFRTJV?=
 =?utf-8?B?bVFOVVR1SGJ5N2VOSXVwQkUrU28xWm1ndTJUeDhISjhtRWs1QXdkQlF2Mzdl?=
 =?utf-8?B?YlkvRzlxZ1dhS0RldjlxeE1PUGlvNHRKb0psaTZCalNGQngySUZpUT09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19851f95-edff-45e1-b5e1-08de6fa1fe1c
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 10:31:07.8719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0T37jCSGBagTP2LrWav1fpTFBTQSZxl/pvkS4HN7vhoA+EUmUf8o0V3qoTAmWvyvmDOgXmu8Zva1kUTPC/4O4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2576
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



On 2/19/26 3:46 AM, Bryan Brattlof wrote:
> On February 18, 2026 thus sayeth Francesco Dolcini:
>> Hello Suhaas,
>>
>> On Wed, Feb 18, 2026 at 07:59:20AM +0100, Francesco Dolcini wrote:
>>> On Tue, Feb 17, 2026 at 06:51:50PM +0530, Suhaas Joshi wrote:
>>>> On 11:20-20260213, Francesco Dolcini wrote:
>>>>> On Wed, Feb 11, 2026 at 04:51:09PM +0530, Suhaas Joshi wrote:
>>>>>> On 11:11-20260211, Francesco Dolcini wrote:
>>>>>>> On Tue, Feb 10, 2026 at 11:50:14AM +0100, Francesco Dolcini wrote:
>>>>>>>> On Mon, Feb 09, 2026 at 02:20:01PM -0600, Bryan Brattlof wrote:
>>>>>>>>> Do you mind copying a boot log to a pastebin for me? I thought I had one
>>>>>>>>> of these boards but I'm still digging around for it. 0x80000000 should
>>>>>>>>> be where we load TFA now days unless some boards have opted out of
>>>>>>>>> letting U-Boot move it to the bottom of DRAM
>>>>>>>>
>>>>>>>> Here some more logs
>>>>>>>>
>>>>>>>> https://gist.github.com/dolcini/aa4b669c6349cc6da1b9e7b19cf53fed
>>>>>>>>
>>>>>>>> The files are named with the commit sha that is tested.
>>>>>>>>
>>>>>>>> On Tue, Feb 10, 2026 at 02:56:46PM +0530, Suhaas Joshi wrote:
>>>>>>>>> Verdin boards are the only ones that are reporting this issue. Is it
>>>>>>>>> alright if we revert only the two Verdin-specific commits, and let the
>>>>>>>>> rest (TI and PhyCore ones) stay as they are? The patches are pretty
>>>>>>>>> un-connected to each other.
>>>>>>>>
>>>>>>>> Verdin AM62 should not have anything special, the code is all there for
>>>>>>>> everyone to see, including the defconfig, the DT and so on, and the changes
>>>>>>>> we are talking about to me are self contained withing the SoC. Something
>>>>>>>> is wrong, and we are not understanding what yet.
>>>>>>>>
>>>>>>>> I just retested once more 42b3ee7fa524 and it just hung, you never know
>>>>>>>> if I did something wrong. And for what matter this was spotted by our
>>>>>>>> CI.
>>>>>>>>
>>>>>>>>> We are working on figuring out why Verdin is seeing these issues, in the
>>>>>>>>> meantime.
>>>>>>>>
>>>>>>>> Anything I can do let me know.
>>>>>>>>
>>>>>>>> If it matter the board that I am currently testing has 1GiB DDR RAM, and
>>>>>>>> the SoC is a AM6252ATCGHAALW.
>>>>>>>
>>>>>>> I was able to trace the issue to the get_ram_size() in
>>>>>>> verdin-am62.c:dram_init().
>>>>>>>
>>>>>>> That function walks the addressable memory range to dynamically detect
>>>>>>> how much memory is available.
>>>>>>>
>>>>>>> Not sure on the proper way to fix it however, Bryan? Suhaas?
>>>>>>
>>>>>> Yes, this does seem to be the issue, even in my digging. I have sent a
>>>>>> patch to fix this. But since I don't have boards, I have not tested
>>>>>> this. Could you please test this and let us know if it works, or if
>>>>>> there are any other issues that pop up?
>>>>>
>>>>> With commit f9ffeec4bdcf ("board: toradex: Make A53 get RAM size from DT
>>>>> in K3 boards") merged we had our CI running on our whole board farm
>>>>> last night.
>>>>>
>>>>> Good news: the issue is confirmed to be fixed on Verdin AM62P and Verdin
>>>>> AM62 [Quad|Dual] with [1|2]GB RAM.
>>>>
>>>> That's great!
>>>>>
>>>>> Bad news: we we do still have a boot failure regression on Verdin AM62
>>>>> single core with 512MB RAM. I have no idea if this is the same issue or
>>>>> a different one, but from the logs it look different (despite that I
>>>>> decided to keep using this email thread and not start a new one).
>>>>>
>>>>> The failing board from the logs uses a AM6231ASGGHAALW SoC, maximum
>>>>> frequency 1GHz, we also have another device failing, single core again,
>>>>> with maximum frequency 800MHz, the working one have 1.4GHz max
>>>>> frequency.
>>>>>
>>>>> Worth noticing the errors
>>>>>    Failed to set clock rates
>>>>>
>>>>> These are new compared to the previous U-Boot release, it affects also
>>>>> other boards, and I have no idea if this is related to this issue or not.
>>>>>
>>>>> Logs of the failing device (U-Boot is commit f9ffeec4bdcf1da655a0ffea482062adde78fee8)
>>>>>
>>>>> U-Boot SPL 2026.04-rc2-0.0.0-devel+git.f9ffeec4bdcf (Feb 12 2026 - 14:12:09 +0000)
>>>>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.9--v11.02.09 (Fancy Rat)')
>>>>> Failed to set clock rates for '/a53@0': -22
>>>>> SPL initial stack usage: 13456 bytes
>>>>> Trying to boot from MMC1
>>>>> Authentication passed
>>>>> Authentication passed
>>>>> Authentication passed
>>>>> Loading Environment from nowhere... OK
>>>>> init_env from device 9 not supported!
>>>>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing(HS-SE) devices
>>>>>
>>>>
>>>> I don't think this one is related to the firewall series. Not really
>>>> sure what the issue is. Just to rule this series out -- could you drop
>>>> my patch(es) and check if this specific device boots?
>>>>
>>>> Was this device booting earlier? Could it be a build misconfig, since it
>>>> says that it can't detect an image signing certificate?
>>>
>>> This is a regression with 2026.04. 2026.04-rc never booted on this device, and
>>> before commit f9ffeec4bdcf1da655a0ffea482062adde78fee8 none of the verdin
>>> am62[p] variants were booting for multiple bugs that were present in the
>>> release.
>>>
>>> 2026.01 is booting fine on this device, with plain vanilla U-Boot.
>>
>> The issue is still there, and it seems again related with your changes.
>>
>> Can you help? Any test that I should do?
>>
>>
>>
>> v2026.01 booting fine
>> =====================
>>
>> U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:15 +0100)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
>> Changed A53 CPU frequency to 800000000Hz (K grade) in DT
>> SPL initial stack usage: 13512 bytes
>> Trying to boot from MMC1
>> Authentication passed
>> Authentication passed
>> Authentication passed
>> Loading Environment from nowhere... OK
>> init_env from device 9 not supported!
>> Authentication passed
>> Authentication passed
>> Starting ATF on ARM64 core...
>>
>> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
>> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
>>
>> U-Boot SPL 2026.01 (Feb 18 2026 - 12:12:38 +0100)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
>> SPL initial stack usage: 2048 bytes
>> Trying to boot from MMC1
>> Authentication passed
>> Authentication passed
>>
>>
>> U-Boot 2026.01 (Feb 18 2026 - 12:12:38 +0100)
>>
>> SoC:   AM62X SR1.0 HS-FS
>> Reset reason: POR
>> DRAM:  512 MiB
>> optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
>> Core:  159 devices, 34 uclasses, devicetree: separate
>> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
>> Loading Environment from MMC... Reading from MMC(0)... OK
>> In:    serial@2800000
>> Out:   serial@2800000
>>
>> 2026.04, commit 3243a73102c3 ("Merge branch 'master' of
>> https://source.denx.de/u-boot/custodians/u-boot-sh"), booting fine
>> =================================================================
>>
>>
>> U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:33 +0100)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
>> Failed to set clock rates for '/a53@0': -22
>> SPL initial stack usage: 13512 bytes
>> Trying to boot from MMC1
>> Authentication passed
>> Authentication passed
>> Authentication passed
>> Loading Environment from nowhere... OK
>> init_env from device 9 not supported!
>> Authentication passed
>> Authentication passed
>> Starting ATF on ARM64 core...
>>
>> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
>> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
>>
>> U-Boot SPL 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
>> SPL initial stack usage: 2048 bytes
>> Trying to boot from MMC1
>> Authentication passed
>> Authentication passed
>>
>>
>> U-Boot 2026.04-rc1-00199-g3243a73102c3 (Feb 18 2026 - 15:38:57 +0100)
>>
>> SoC:   AM62X SR1.0 HS-FS
>> Reset reason: POR
>> DRAM:  512 MiB
>> optee optee: OP-TEE: revision 4.7 (a9690ae39995af36)
>> Core:  160 devices, 35 uclasses, devicetree: separate
>> MMC:   mmc@fa10000: 0, mmc@fa00000: 1
>> Loading Environment from MMC... Reading from MMC(0)... OK
>> In:    serial@2800000
>> Out:   serial@2800000
>> Err:   serial@2800000
>> Model: Toradex 0071 Verdin AM62 Solo 512MB V1.2A
>>
>>
>> 2026.04, current master, commit 8666b16015d4, NOT working
>> =========================================================
>>
>>
>> U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:31 +0100)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
>> Failed to set clock rates for '/a53@0': -22
> 
> Hmm It's interesting to see this start to fail.


I have sent out a fix patch to drop the a53 clock overrides from the 
board files, 
https://lists.denx.de/pipermail/u-boot/2026-February/610466.html

With that fixed the boards will now show

   Set clock rates for '/a53@0', CPU: 1250MHz at Speed Grade 'T'


> 
>> SPL initial stack usage: 13464 bytes
>> Trying to boot from MMC1
>> Authentication passed
>> Authentication passed
>> Authentication passed
>> Loading Environment from nowhere... OK
>> init_env from device 9 not supported!
>> Authentication passed
>> Authentication passed
>> Starting ATF on ARM64 core...
>>
>> NOTICE:  BL31: v2.13.0(release):v2.13.0-259-ge0c4d3903b-dirty
>> NOTICE:  BL31: Built : 07:01:36, Jul  1 2025
>>
>> U-Boot SPL 2026.04-rc2-00033-g8666b16015d4 (Feb 18 2026 - 15:05:54 +0100)
>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
>>
> 
> I'm suspicious of the spl_enable_cache(). I've witnessed issues if we
> add MMU entries that are not backed by DRAM which can cause the MMU to
> crash the CPU.
> 
> I wonder (complete guess right now) if we're passing the correct DRAM
> density to the A53 SPL?
> 
> ~Bryan


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77C6D358F2
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 10:06:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2864583CBD;
	Thu, 29 Jan 2026 11:06:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Reb2hYap";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Reb2hYap";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8403A83D77; Thu, 29 Jan 2026 11:06:16 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B040183C8C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 11:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=T4KhsoAIj4FRjB5WDqOl3SILvUl8EE4aVU0lvKBS5G5bO8jhYCQP+xKEhuZdcKZRkaUxUQq/HF0OAucMQhrGiT8KOiEY2vd01YaUq1HTCyuSukDynIpxCRT9NuX+fcXildFxOIXhVjqt+vjLZWPH80BYtOqW12tWbnb7GbUUQPXmmeD1vTAk1QIxD5tGy4VOWGsLrkS/V2I4S8Hz0FWWQN0dCckRB+r/XORNVcWTwp3T9OdkFsF6A7XponQkbkDijN8xwpDZ4MS9B4Ef7SihM6x8TL4vH9Ikh1obkiAwiaO5F1KofJqZARwS0xNiA/9mUqtsIC6elzdsw4URHEBYhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9enp8ISl/gmAAerGDCjXQ0giifo+FsVNDnXsllssY+4=;
 b=kLsajHBdR8DAuHd5GRrXfzSrUjcgGcc9yvH0CXC9Bs2Jp9hvujuym3b51VpJ/K8ng3imMH2sMqWv2GWtYkMkVSdtU1zmN5VTl53G7dV6oS7hoDdbcq9ck8qg1HB/MApn90HnCGI3FK2JS1XIJYN8rn+5CpuElHs3Js68QZIecUeXTI3YZS8pDF5vbUxscddthWvADOwm57rYLMkNhhn47QaZP5DleQ0hw7SZY42iCNaivuK4Agak8ZaTLSiM4Ns8Lp8Bx2Mtc/LKAhPucC6M3KINXVoaNMvlBMbO0UOLLINds9z0u/2BGbsUPkTgCJAebcC+qnG02+nTU0GfsblLsg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mailbox.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9enp8ISl/gmAAerGDCjXQ0giifo+FsVNDnXsllssY+4=;
 b=Reb2hYapr0aGROjlTFWyUR1+RbIb9z9iqwNfgFYBKde327cHs3+RoXOVLghUPUAfwzzzOeBtJywJVWX2h2Ry+k0PRLYDVjzSd6GsFKrTv4+GmUqqs87PFKpgIHp6uL0TzYqGAtnOCj9+EOkvxuG65jTsu68vsb1Wy896/mkUW2o=
Received: from AS4P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d5::6)
 by PAWPR08MB11300.eurprd08.prod.outlook.com (2603:10a6:102:511::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:06:08 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d5:cafe::db) by AS4P191CA0002.outlook.office365.com
 (2603:10a6:20b:5d5::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.9 via Frontend Transport; Thu,
 29 Jan 2026 10:06:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Thu, 29 Jan 2026 10:06:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqkfUTFPTJZpMXNKK7s9440QnPoqmdxaAo3GsgRCyjLYElaabutJqrWGIktDLU/Gdla+/1WCBcUxsrkzyUZEaSXcnZ6bQTlItsGJ9suOAWgqLS43GOR0JHSlP9WHwnoYnFbd8QUAPxCCP9+Gld4do7mmh32MfipxXSDiJ8DcZi+I8YQERS4i6S+XuHqDa8bLNXU8wQYQ8H8P5Er5UPiskdzCdMaVEVlC/2mLdiMc/bvfFho1dWGtPnaZMlmQYziWxoM7GoXfNLikHq9JidWitxFAS0aHUWBuPlrlHxKahFE5QRoez25xEODCjv/6xWdZYPLsmNhK9JP0DQp5NZyfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9enp8ISl/gmAAerGDCjXQ0giifo+FsVNDnXsllssY+4=;
 b=VGgZzjZ0SMGm+xcQ5rWTMWVJSz//7a1GGO3psFM6ccZo5mUbbVWIubQwqz2b05NEBqGVzdKzpmGbfDieQO3qx/VXR5kS7AdeBnu6isQerr93Z/OBkWh6eRVlFNGmCM/TC46IzQFakzJ0v6gcC+RmeB6lt2h1e82bcJemGY9qRgkqcRe6kSis+Pd5u/3hsNkptmxp6nQFLQUrjjrlURwBcHfek1cXCztO6d+S2hfdT585ERHUcRSKXwHxoDmkKaM4ugbbNeJ/hyFvR8ozL02mpUNIOv/pXCqWk1LV0MRJ0o54FUPpTvtWdhmJuhcztt+uSjhD2f8VQJ6aPzS+EnrqFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9enp8ISl/gmAAerGDCjXQ0giifo+FsVNDnXsllssY+4=;
 b=Reb2hYapr0aGROjlTFWyUR1+RbIb9z9iqwNfgFYBKde327cHs3+RoXOVLghUPUAfwzzzOeBtJywJVWX2h2Ry+k0PRLYDVjzSd6GsFKrTv4+GmUqqs87PFKpgIHp6uL0TzYqGAtnOCj9+EOkvxuG65jTsu68vsb1Wy896/mkUW2o=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB9825.eurprd08.prod.outlook.com
 (2603:10a6:10:462::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Thu, 29 Jan
 2026 10:05:04 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:05:04 +0000
Message-ID: <51b1c31a-427e-400d-9692-14e4b90c0a2c@arm.com>
Date: Thu, 29 Jan 2026 11:04:16 +0100
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: lwip: tftp: add support of tsize option to client
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>, Wolfgang Wallner
 <wolfgang.wallner@at.abb.com>, nd@arm.com
References: <20260128234351.405945-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
In-Reply-To: <20260128234351.405945-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0194.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB9825:EE_|AM4PEPF00027A5D:EE_|PAWPR08MB11300:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c34df1c-4201-4f60-1da5-08de5f1e0549
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7142099003|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?aXUrL05TbnZOM3hUQjVrMTV1a2pYOGRzNy9GVmNOTEdueVNFeVhKRjNYS0Fi?=
 =?utf-8?B?aVQ5N0U2ZDJEM0ZCQzN3SitMb000OTZXeGRMZVFEeStDWXg2ZDZQOXplSlBt?=
 =?utf-8?B?alVDU0F0T0hqeWRHS21aTER4SG1EL0piLzBwd0xDK2JRZGxBZ1pSRGZQMm1T?=
 =?utf-8?B?OFhTdXJnNTZZWHoxZ21yeElkQXR0ZUJ4MGdBMlVhVlU0bUJaYXpETXhET3hJ?=
 =?utf-8?B?U3dkT1dkSjg2Wlp3NENVZHd4bmhiUVJvMGlEeEJLQXhLNGlpeWtHT1g3aldp?=
 =?utf-8?B?eHpSeEV5YVRmaW5PMTQxQWZYSlR5NG9YdUxPUHRzYkRwSjJ3ODdnUHRlUlZJ?=
 =?utf-8?B?Rlo4S0JMbFZuQmdkOVlhZHZ2MWJZNGFYNFl2ZmxzN0VvMVpOemltS2VvSzIx?=
 =?utf-8?B?SFhVUXQyRVdLVUovNGhlUHNLSEJYQlQ3V3k2MEZiUG9qQWdLSld4RmhDczZE?=
 =?utf-8?B?OVVMaVk0dkFrWStUM2M1Qk5PdU9NQm1teWRnSWVNaEFCQ1FKcmJGU2RJZ3Bl?=
 =?utf-8?B?TWNhZnpSUjlyN3o0SnV1S0VSNlIxSHp3VHBPM0VmUlRaaVFWN2Vqc0YwVVd0?=
 =?utf-8?B?bUlDeDlhaVQzMzlGUFBtb2lEOU56ZTl5NGZPU1Z4ZUlFR0doL2VKS0tEVU16?=
 =?utf-8?B?VHBSYXJZOXJXZE9mQzRYZTBpMDJVZktwL1dsRnYrR2cwNmtVdy9xUS9nam1K?=
 =?utf-8?B?ZWUrdTdRMDl1ZTc1WVVFd2hDYVRWOG1LRjdrWjliL2w0amwrYUwzZ25RcVBN?=
 =?utf-8?B?RWpaYzAvZ3Y4MllUYVZzbHUwRld5NFAyb1ZBU2VndjBMTXB1VzBqaGJXaEo0?=
 =?utf-8?B?bFY3RFRiRE9ENmNIMGg2SEgvOWZNRFAvVzVpeDJOVlU0QnEvT0wyY21lWHNI?=
 =?utf-8?B?STh3U0ZnNXQxamNwbUw0em8zYTFLSWZ5dWovZFFlK1JvUWQzNnl5WkJMOEd0?=
 =?utf-8?B?eEhBVjJmc2xlbG1kUGgzV0c5MFc2U0prZXJVMTl0aElMcEJpZHJGS0JZRDEv?=
 =?utf-8?B?V3VIbWdDMkpuS0tqUmxlTjZNZmFqMEpqLytwcUExV01PaWVqVEY2enNkQ2hm?=
 =?utf-8?B?bUxWS05ZdUVFN3JVYmxHL0ZVTWh4TXJqc2lmcHlJcjMrS1BJMFhUTjNrQ0hN?=
 =?utf-8?B?SjBQVUpBREhJK2I0OG5uRXVlOEd1akt6dkVIY21vdHFQM0hldWhBTzc0QXJU?=
 =?utf-8?B?QjEwcUhQaE95S3huSDVYWGpHTVY5N2s5SHZlajBPaExJaFI1bFo1Y1pxeUNi?=
 =?utf-8?B?U04wMDVoZ1g3by9aMTlGSy9jQTJFY2hTNWh6QlNSd0NWRHdGaUJSWE5UT2Y4?=
 =?utf-8?B?Q3cwS2VkYy9OWGl1YmxHZjNjYlUyR3dRU1g0OVZUR2g1eThYR0paWE5OaGh4?=
 =?utf-8?B?Z1VnUEtqNGxibFF5c0VKY1R6bHBLNHc2akJMM2NnSFpVMEVBd0ZnU0trZ0pY?=
 =?utf-8?B?RVgyZGJWZnVrcS82YWE4MjRGODU5cFp4Slh6ZVYzTnpmdEVqQ3krdWRQZVYv?=
 =?utf-8?B?bUcrYmt4TEtqdWRyOTczS1UxYVUxdkVtVDBZNGl3akllMG1qYWw1a3pFZ1VN?=
 =?utf-8?B?VFowQzBSZ3phS2VsSXkrbkpqbkxadnRNb21mRld0d0FsTGloTy9NNmltZk55?=
 =?utf-8?B?eWhLQ0UyT1NVb3VsN2R3QVhZcURVNzFLZHprWjY5NVZrL3NvdWhFb1p1aXJF?=
 =?utf-8?B?RE1leURyZGgwNytadVJUTVBGWXREK0ZZc0hiMmUrdnhEMGRNVVg5MXk0TDJW?=
 =?utf-8?B?eUxpVlRpK1lkNkNCd0JFbU1LOTZ5OHBZVlI3ais1c1BmU3Rpa0RRNjhnVUI0?=
 =?utf-8?B?Y1NOTVNKdUk2Tm1aSjI0Tm8vbjNJbHVkL09HS3lib0psOWVvL2k3cExGRnVj?=
 =?utf-8?B?SzJzYWJpTkFhVUtwd2lHU0lTSHd2dUU1dmhjd3grNk5tdnV2VDZUMDJoL2xN?=
 =?utf-8?B?Tk5aT2U1bmQrUFluK0p6d2d0akY3T0k3VCt4dEhqdmRhaTViTnhISXYyNDJi?=
 =?utf-8?B?ZnBoZWVyaE10MlFuaDE1UkpUemNYZlE5bnRxRFpjMS91NTF4ZCtIZ2NlbVBi?=
 =?utf-8?B?cXhNRUtQUUowd0E1dzVXQTlMU1I1M1ZoODVvR1VCbHJVTnZhbnowaHlxTDQ5?=
 =?utf-8?Q?YVfs=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7142099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9825
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 047c7f02-e907-4e03-6c2a-08de5f1ddfab
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|36860700013|376014|7416014|82310400026|14060799003|1800799024|13003099007|7142099003|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWprT00wT2dGcXF5QzBvcWRrYjBsVG5mbXJmTE9MVXhyRVZxemp2aXFEQlhZ?=
 =?utf-8?B?Y3NOWktOOGF2SUk5dHR1bFQxdTV5VzA0QnNjdE8rbXlqbnorQkpNK212UDM0?=
 =?utf-8?B?TnV3K0RsTDdMblJwTUNTRWV4bHZzZllBM21ZZUFBbkdIWkhRazlFQmw0RlA3?=
 =?utf-8?B?dmc1SlRvZTUveUJQc2xvT0xqMG9La3ZvN1VSeHJhOUJ5NzZjNkk2REJTZ3VQ?=
 =?utf-8?B?eDVkRlRyb2tXd283UnlRb1VtNjE4TFM1MkhWbXVBY0F5U3dWNW9rQXNrVG15?=
 =?utf-8?B?TTNXcStUQ3ZWbk43Ujd0M1hISkYyOEUyeEdMRUhnMUpWNkcxSnlkd2pvSHNI?=
 =?utf-8?B?VEgzN1BqMDRJVWZIU3JwZXoxUDBYcEc0SUNlRWZsNVI0MXh0TW9KUGhvRUo4?=
 =?utf-8?B?ZTdtQnlmYUN2V2dFVWRBV2dWYU9SREdxcEFrRFpNVEpKRHFOd2hOb3UwSGIy?=
 =?utf-8?B?QVZTbXA3UllEVFhoODJoaXk3N1ZqNmVGOWVuc040aVY4NlRQdGRBM2haeDAw?=
 =?utf-8?B?V2pEZGNjSzYwM2wzeXQzbERCY25tVXBITE90MlJCSTdSR1ZNMURTeWgrbTJK?=
 =?utf-8?B?Ym54TVpBVXUvRDgwYXRxUVVvS29reXdBYTd2M3I0RnY1VzhXSFNjdE1sUjhi?=
 =?utf-8?B?R05aUVRoWTVQTW9BazhVMEN0UnZmcFJkaEcxc1Mxeitpc0FmbWVqeTJvOGdF?=
 =?utf-8?B?eTFBU1Q1VGhTQjZGUlNtaDgyM0tCRW1hazVFelpjVy81eGtSOG1nSkhjMC8w?=
 =?utf-8?B?SjlsM01sVkVEdTZFZmRjVVRYdzRpbkxMTzQzakZGalBGN09qTGJsaDI2Y1JX?=
 =?utf-8?B?VDVmM0VwMWdFd3J1cDYwa2VNTTdDRjZqbEVNMVpsMm5FR3A4TzF6UXEwRVpK?=
 =?utf-8?B?VC8xc3FYNUxTdk5ONFpZeHAvdEdJK2FnSUplSjFoOURHamZnTk1tYXBzY3Uy?=
 =?utf-8?B?V1ppbUFsempjVHpHNXVabHl0ZGxoUi9OQVZFNWdvMUNvOFBjakZjWkVKNXlk?=
 =?utf-8?B?SzZLNzJUOFFxc1BSc1gvSTF4V09SazV1Ni9uRS85eUpkbFFKeWp1WFZRdGtn?=
 =?utf-8?B?Q1pJN3BEaHpnNmsrNzViSFhQK3cwZURzWnozNmNPNFk1M0hhYUhRK1QrWnhU?=
 =?utf-8?B?R2lTaHg5QnFHenYyNE1MWjI4R1lRVUpEWnAzb0R5cDFnNHJFcFV0L0dyMkRo?=
 =?utf-8?B?citENDJIdU1ESytNbWJteHNERVJ5WGZFQ0lCSVFJSE9jLzcveG82QTFrSlFj?=
 =?utf-8?B?L0lGOXFnVUVRaEhFTTNFR2hzRHB1cE84V3BPbHhRMkR3U28xS0ZnemU5eXhw?=
 =?utf-8?B?Qmx0aXgwNDhmY01GM1dQeTdocC9BNzZkOWtzS1BuRTNOM1RFcktvUXBiREhz?=
 =?utf-8?B?QlFOZm5PTWY3bUQwSFB5MW5STnBXR1VXRUpCRW5DVWxqRUpuYmx4ODg5a0tP?=
 =?utf-8?B?MVc0cFV4VFd1NkcxREVZTCsrdWpHdElQak5xdDJZbWZreGxuUGxtSS9Baitm?=
 =?utf-8?B?QWExNDNFZ0RWT0hoZmFhNlgwbFZNQWFETnpXV05ZMC9sS0JFNHJLb0twdDJI?=
 =?utf-8?B?aFBHMXQzVXdaZ0QwS0VOMFpZZ0Jha2ZJejdCRTJqSE1OU2xvY3Y2OXFHZWNm?=
 =?utf-8?B?Qlljb0hWYm5nd2haUnRzK3BRWFFieE51V0RNMnNZOXlMTDZpTEorbzM2cU8w?=
 =?utf-8?B?QWtUV0RiRDMreURjZklhME5neDQzdjNpZmx2R25ZcGRqMlIxRkE2UzV6NnVo?=
 =?utf-8?B?OWZ1RWRmWDdSZkZNOTh4VHBZVDJXOTE0djY0MVU5Qnc0dFN1RWFPVUV4VHZj?=
 =?utf-8?B?U3FrSWVLTjAyTE9jUDAzTS9JemtLZEhCaTdGZjRGVTQrbnh2YjdtTkg3K3ZV?=
 =?utf-8?B?ZUtHUkp0SStqc1RDcldyNW91YkRGUGgzcko3U25uQjdmV1p6L21VTmpWbGxV?=
 =?utf-8?B?MDNhTmRFRWhqdEY5dmh0MzRTQnhHYXhqTHFjaEdUd1R2WkVWZGFIM3ZmSkZZ?=
 =?utf-8?B?SzJZRG9Sa3o1NnhONmcyblE5SXBpMEVwQmI5cTZJMHBuRjh5ZmZ6d1dNdzJu?=
 =?utf-8?B?YmxYVDFpalBVWEs0cXdWTk10RkR6NUZKSWZLU0daL1A3M3kzd1FkZVl1d2FY?=
 =?utf-8?B?UzZzSld4ZkNURGhZbXAwUEdsZUcyc0Y2NWg1cHVYaks5VmlTajV4TE5PYk1Z?=
 =?utf-8?B?b0EzSkVzWEVyNENycGhnZkd3LzgrdlkrQWxNdjdxS3cySFVhNlp0MDVNdWFJ?=
 =?utf-8?B?Sks0akNDbUk1MVdObjRHQ0JEQXV3PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(36860700013)(376014)(7416014)(82310400026)(14060799003)(1800799024)(13003099007)(7142099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:06:07.4408 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c34df1c-4201-4f60-1da5-08de5f1e0549
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11300
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

Hi Marek,

On 29/01/2026 00:43, Marek Vasut wrote:
> The TFTP server can report the size of the entire file that is about to
> be received in the Transfer Size Option, this is described in RFC 2349.
> This functionality is optional and the server may not report tsize in
> case it is not supported.
> 
> Always send tsize request to the server to query the transfer size,
> and in case the server does respond, cache that information locally
> in tftp_state.tsize, otherwise cache size 0. Introduce new function
> tftp_client_get_tsize() which returns the cached tftp_state.tsize so
> clients can determine the transfer size and use it.
> 
> Update net/lwip/tftp.c to make use of tftp_client_get_tsize() and
> avoid excessive printing of '#' during TFTP transfers in case the
> transfer size is reported by the server.
> 
> Submitted upstream: https://savannah.nongnu.org/patch/index.php?item_id=10557
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Nice feature! One minor comment below.

Acked-by: Jerome Forissier <jerome.forissier@arm.com>

> ---
> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jerome Forissier <jerome@forissier.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Wolfgang Wallner <wolfgang.wallner@at.abb.com>
> Cc: u-boot@lists.denx.de
> ---
>  lib/lwip/lwip/src/apps/tftp/tftp.c            | 51 +++++++++++++++----
>  .../lwip/src/include/lwip/apps/tftp_client.h  |  1 +
>  net/lwip/tftp.c                               | 35 +++++++++++--
>  3 files changed, 74 insertions(+), 13 deletions(-)
> 
> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
> index ecb6c55ae11..5061446b1cf 100644
> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
> @@ -98,6 +98,7 @@ struct tftp_state {
>    int last_pkt;
>    u16_t blknum;
>    u16_t blksize;
> +  u32_t tsize;
>    u8_t retries;
>    u8_t mode_write;
>    u8_t tftp_mode;
> @@ -167,6 +168,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>  {
>    size_t fname_length = strlen(fname)+1;
>    size_t mode_length = strlen(mode)+1;
> +  size_t tsize_length = strlen("tsize")+3; /* "tsize\0\0\0" */
>    size_t blksize_length = 0;
>    int blksize = tftp_state.blksize;
>    struct pbuf* p;
> @@ -182,7 +184,7 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>      }
>    }
>  
> -  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length - 2);
> +  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length + tsize_length - 2);
>    if (p == NULL) {
>      return ERR_MEM;
>    }
> @@ -190,8 +192,9 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>    payload = (char*) p->payload;
>    MEMCPY(payload+2,              fname, fname_length);
>    MEMCPY(payload+2+fname_length, mode,  mode_length);
> +  sprintf(payload+2+fname_length+mode_length, "tsize%c%u%c", 0, 0, 0);
>    if (tftp_state.blksize)
> -    sprintf(payload+2+fname_length+mode_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
> +    sprintf(payload+2+fname_length+mode_length+tsize_length, "blksize%c%d%c", 0, tftp_state.blksize, 0);
>  
>    tftp_state.wait_oack = true;
>    ret = udp_sendto(tftp_state.upcb, p, addr, port);
> @@ -450,14 +453,24 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
>        }
>  
>        blknum = lwip_ntohs(sbuf[1]);
> -      if (tftp_state.blksize && tftp_state.wait_oack) {
> +      if (tftp_state.wait_oack) {
>          /*
> -         * Data received while we are expecting an OACK for our blksize option.
> +         * Data received while we are expecting an OACK for our tsize option.
>           * This means the server doesn't support it, let's switch back to the
>           * default block size.
>           */
> -       tftp_state.blksize = 0;
> -       tftp_state.wait_oack = false;
> +        tftp_state.tsize = 0;
> +        tftp_state.wait_oack = false;
> +
> +        if (tftp_state.blksize) {
> +          /*
> +           * Data received while we are expecting an OACK for our blksize option.
> +           * This means the server doesn't support it, let's switch back to the
> +           * default block size.
> +           */
> +          tftp_state.blksize = 0;
> +          tftp_state.wait_oack = false;
> +        }
>        }
>        if (blknum == tftp_state.blknum) {
>          pbuf_remove_header(p, TFTP_HEADER_LENGTH);
> @@ -527,21 +540,31 @@ tftp_recv(void *arg, struct udp_pcb *upcb, struct pbuf *p, const ip_addr_t *addr
>        }
>        break;
>      case PP_HTONS(TFTP_OACK): {
> -      const char *optval = find_option(p, "blksize");
> +      const char *blksizeoptval = find_option(p, "blksize");
> +      const char *tsizeoptval = find_option(p, "tsize");
>        u16_t srv_blksize = 0;
> +      u32_t srv_tsize = 0;
>        tftp_state.wait_oack = false;
> -      if (optval) {
> +      if (blksizeoptval) {
>  	if (!tftp_state.blksize) {
>  	  /* We did not request this option */
>            send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "blksize unexpected");
>  	}
> -	srv_blksize = atoi(optval);
> +	srv_blksize = atoi(blksizeoptval);
>  	if (srv_blksize <= 0 || srv_blksize > tftp_state.blksize) {
>  	  send_error(addr, port, TFTP_ERROR_ILLEGAL_OPERATION, "Invalid blksize");
>  	}
>  	LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: accepting blksize=%d\n", srv_blksize));
>  	tftp_state.blksize = srv_blksize;
>        }
> +      if (tsizeoptval) {
> +	srv_tsize = atoi(tsizeoptval);
> +	if (srv_tsize <= 0) {
> +	  srv_tsize = 0; /* tsize is optional */
> +	}
> +	LWIP_DEBUGF(TFTP_DEBUG | LWIP_DBG_STATE, ("tftp: accepting tsize=%d\n", srv_tsize));
> +	tftp_state.tsize = srv_tsize;
> +      }
>        send_ack(addr, port, 0);
>        break;
>      }
> @@ -655,6 +678,16 @@ tftp_init_client(const struct tftp_context *ctx)
>    return tftp_init_common(LWIP_TFTP_MODE_CLIENT, ctx);
>  }
>  
> +/** @ingroup tftp
> + * Get the transfer size used by the TFTP client. The server may
> + * report zero in case this is unsupported.
> + */
> +u32_t
> +tftp_client_get_tsize(void)
> +{
> +  return tftp_state.tsize;
> +}
> +
>  /** @ingroup tftp
>   * Set the block size to be used by the TFTP client. The server may choose to
>   * accept a lower value.
> diff --git a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
> index e1e21d06b67..78de50f4924 100644
> --- a/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
> +++ b/lib/lwip/lwip/src/include/lwip/apps/tftp_client.h
> @@ -45,6 +45,7 @@ enum tftp_transfer_mode {
>  
>  err_t tftp_init_client(const struct tftp_context* ctx);
>  void tftp_client_set_blksize(u16_t blksize);
> +u32_t tftp_client_get_tsize(void);
>  err_t tftp_get(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
>  err_t tftp_put(void* handle, const ip_addr_t *addr, u16_t port, const char* fname, enum tftp_transfer_mode mode);
>  
> diff --git a/net/lwip/tftp.c b/net/lwip/tftp.c
> index 6c7ffba661e..213c1292eb1 100644
> --- a/net/lwip/tftp.c
> +++ b/net/lwip/tftp.c
> @@ -31,6 +31,7 @@ struct tftp_ctx {
>  	ulong daddr;
>  	ulong size;
>  	ulong block_count;
> +	ulong hash_count;
>  	ulong start_time;
>  	enum done_state done;
>  };
> @@ -49,6 +50,8 @@ struct tftp_ctx {
>  static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
>  {
>  	ulong store_addr = ctx->daddr;
> +	ulong tftp_tsize;
> +	ulong pos;
>  	void *ptr;
>  
>  	if (CONFIG_IS_ENABLED(LMB)) {
> @@ -67,10 +70,21 @@ static int store_block(struct tftp_ctx *ctx, void *src, u16_t len)
>  	ctx->daddr += len;
>  	ctx->size += len;
>  	ctx->block_count++;
> -	if (ctx->block_count % 10 == 0) {
> -		putc('#');
> -		if (ctx->block_count % (65 * 10) == 0)
> -			puts("\n\t ");
> +
> +	tftp_tsize = tftp_client_get_tsize();
> +	if (tftp_tsize) {
> +		pos = clamp(ctx->size, 0UL, tftp_tsize);
> +
> +		while (ctx->hash_count < pos * 50 / tftp_tsize) {
> +			putc('#');
> +			ctx->hash_count++;
> +		}

Nit: with this format being the same as the non-tsize one, the user has no
way to know how many hashes to expect. How about printing percentages instead?

 0%....10%....20%.... etc.

(functional tests may need adjusting though)

> +	} else {
> +		if (ctx->block_count % 10 == 0) {
> +			putc('#');
> +			if (ctx->block_count % (65 * 10) == 0)
> +				puts("\n\t ");
> +		}
>  	}
>  
>  	return 0;
> @@ -84,6 +98,7 @@ static void *tftp_open(const char *fname, const char *mode, u8_t is_write)
>  static void tftp_close(void *handle)
>  {
>  	struct tftp_ctx *ctx = handle;
> +	ulong tftp_tsize;
>  	ulong elapsed;
>  
>  	if (ctx->done == FAILURE || ctx->done == ABORTED) {
> @@ -92,6 +107,17 @@ static void tftp_close(void *handle)
>  	}
>  	ctx->done = SUCCESS;
>  
> +	tftp_tsize = tftp_client_get_tsize();
> +	if (tftp_tsize) {
> +		/* Print hash marks for the last packet received */
> +		while (ctx->hash_count < 49) {
> +			putc('#');
> +			ctx->hash_count++;
> +		}
> +		puts("  ");
> +		print_size(tftp_tsize, "");
> +	}
> +
>  	elapsed = get_timer(ctx->start_time);
>  	if (elapsed > 0) {
>  		puts("\n\t ");	/* Line up with "Loading: " */
> @@ -176,6 +202,7 @@ static int tftp_loop(struct udevice *udev, ulong addr, char *fname,
>  	ctx.done = NOT_DONE;
>  	ctx.size = 0;
>  	ctx.block_count = 0;
> +	ctx.hash_count = 0;
>  	ctx.daddr = addr;
>  
>  	printf("Using %s device\n", udev->name);


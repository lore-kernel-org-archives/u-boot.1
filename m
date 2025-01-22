Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B00CC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 07:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38B37801B0;
	Wed, 22 Jan 2025 08:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=vaisala.com header.i=@vaisala.com header.b="UxS1UUAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AA3180586; Wed, 22 Jan 2025 08:32:05 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20714.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::714])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE33A801B0
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 08:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Tapio.Reijonen@vaisala.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNBTuTEn8o1ET63TiQfAqUUBlF2q3Uur+MYgPAVnksLgjiHDZWp6fBXylJUmYmaiqQc0hoi+7uz+6pcmiSOuE699RoEOcHTxe7ofMsH0E3eqMt17Q50Hruo0Qi7rITaa8Hc1vI6rUu645LCj6A2UwKJzXuDDPlWEdFbgzeI3GtPtuImW9ELVmt7rWyr/jY4sgMRjC3UQou6+a219rG2eryFhErNaDc5CwzKWPyOtqHdEerujUYY+c8ptBYze72jAFeu8kILb4NxYqxs+9lNZXN6LFbORiC9iBOEIYUs/tpjtZqdnCytpPUQDulM+HI5qnbyMg1YRmHPShJvZnbkTkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=827JcrPhfE3pU2ygEJ9ihh72tbiohPESebISfZXnnq0=;
 b=TbBLe0ybhvtb47X8hu3YxhPo3TNPqLN+LMbXQf/SHE2l+WGk6+bomPz2aJSl0dTYH71ZfXcFQwDKlvMia+LGu7NdXm8P08CrnrOJBzBdu+PoiygJSN2bxjZNaQ5t0aS4wugpYsGEQKzPX+QTBv+lhNcXjVt0XpJfucEs3yoUM9s38DNGLDuWGxpgY6ciTyQnYrgB2WBSigkbbTTF0kn/G4cunesjdy/XgAYXNFoTzDFegj3IPfOPEqI5CV0nQlQtRuyBMLE8Cv0dUUd/cjTIizK1En57GzgUvoM7/oqHYj0UMDVOlAtpAZwiOQ/wBFBRkNRVG1EfHj34dIxXB8o89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=827JcrPhfE3pU2ygEJ9ihh72tbiohPESebISfZXnnq0=;
 b=UxS1UUAIoskgUawxr3FpQUFShNXKtfb7nxupoQ+5R1fELuG/Dh1gY0OEelo4t91bOhkVLzhh/JMdpoRgDJTrPaGHGBenI4OTY8y6raLnNh8eUIBALiUkHUNhZWxZaND1V1HckJirqGXHIkxG4XdD+irLmt5TYLhNwzrGGwnMjUcNCGmK1fxEr2Cvy09xFQUP7HxHuK4vjvLESdel9GIdsMwq+YPfl40M9pBc93ACYtPVNCjbQVRkvI2IcRAsSFEfb/BCjM2k099yYC8eaRj/M6am860LGrWTyxcV3EVOD5o6V4XMO+kHmMewaVIlXMdKWL6/P8V8LX7W4Qfj+hgDhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com (2603:10a6:150:11f::17)
 by DB8PR06MB6457.eurprd06.prod.outlook.com (2603:10a6:10:128::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Wed, 22 Jan
 2025 07:31:57 +0000
Received: from GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7]) by GVXPR06MB9065.eurprd06.prod.outlook.com
 ([fe80::7675:1098:3208:53e7%5]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 07:31:57 +0000
Message-ID: <63c7d675-1db1-4613-88b0-0c2229a57867@vaisala.com>
Date: Wed, 22 Jan 2025 09:31:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] net: phy: Let gmiitorgmii converter create
 additional PHY
To: Michal Simek <monstr@monstr.eu>, Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Eugeniu Rosca <erosca@de.adit-jv.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jacky Chou <jacky_chou@aspeedtech.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250116054324.836712-1-tapio.reijonen@vaisala.com>
 <20250116054324.836712-2-tapio.reijonen@vaisala.com>
 <CAHTX3d+Gb+KHHLaDpuHsei+4aQVYk=+urG1u-MaxcaZGdeHmMg@mail.gmail.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <CAHTX3d+Gb+KHHLaDpuHsei+4aQVYk=+urG1u-MaxcaZGdeHmMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0048.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::29) To GVXPR06MB9065.eurprd06.prod.outlook.com
 (2603:10a6:150:11f::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR06MB9065:EE_|DB8PR06MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 360c3bbb-78c4-42aa-489d-08dd3ab6d9d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek5aNzFMbTdZR01KWS9LYzF4VVM0R3pJUjh3UXBuMi9LSXRlcmpab1VjclNh?=
 =?utf-8?B?RkZxeFdJS3p6cTBOOHJwVU5NVGdlR3ZHdWhCQkF5RmVWd1h3TFo1dkY2MjBY?=
 =?utf-8?B?dEFwZDU2S29aR2dZVmlhS3NkVllvVHptcVhJYWF4Rk5HcjhVRHpJZlNrWmE5?=
 =?utf-8?B?OWRDU0JnMXNPL01zRTIrNnRWY2QwRzlkZWhzWXQyY3h1ektJVVJUM0k4NzlM?=
 =?utf-8?B?enRxbm5UVW5pL2NvNXR2VDk5TUpscnRReE1hbEpXaHpDTUVkZEpKSHp6S0Y3?=
 =?utf-8?B?VG1rS1FOZ2thK0dydElvUTA5bmllK1NBbjYrNVdSYkNxbHhWVmEvRjM3LzBD?=
 =?utf-8?B?MnY1dGJhOWw2cnRJVkFValY0WnpGNEpLdlpRRHo4Y0VSZzRxVWsvMks1WCtH?=
 =?utf-8?B?Y0VQMHAvaUEvdW1IRk1JaG53aGt6SUxYS256NTlWTU1uSXJlanRjUjlyWWpE?=
 =?utf-8?B?QzJzSGtJcXQ2OWk0cTg1NHRseWV5SUJEaVFXNm51RE5uN0hZdEs0eDRMK3Av?=
 =?utf-8?B?emxuQktOM25yK0cvSy9EQ3lhQTVEUU9DTDh1cUpONDhWa1NhbDRtbmJybEhs?=
 =?utf-8?B?VEYwNHpHVWs3RXJZMVM2SnZlK2Y1YWxSWEM3UVM2SkZDVVdOZ1dsSzJsZWU1?=
 =?utf-8?B?ajY0WVdBOUpFK213ZDd6UjY5MHYrYlpFVk1WTmFiM2U3dmpWcmVJeXIxUjNW?=
 =?utf-8?B?clg5QTcyZldXQkdtT2txNE4xRTJESXU2UExENDFuVEMyenQrdk8vWFFram4w?=
 =?utf-8?B?a2txdkJFb21lMDQ0NGdSNml5dXNWY2Jud0ZlSGpYS3RDMEphUTVGV2JTWTFS?=
 =?utf-8?B?eWZmQ1ZSYmJKQWVMNVYxUmhkNmpiRlZZTWZ1dGs1VkJ5d2pnUmZFdWFmNWNv?=
 =?utf-8?B?YlFvRWIzMVJublZ2RGRVTTltMTQwdWZvQjFmT3JsbmxyaHA2Y25IaVpXTmZm?=
 =?utf-8?B?QWh4dkdWYy9LaHJ6Y1kvbjNKWjRVcWd5N25RWmFOK25GUitERXJaQmliRHhS?=
 =?utf-8?B?dTdFWlJYQ1B5Y3c4cVNFQmU1WnU3TUpJMzJFV281UWxDUS9uYUNmd3l0UWpC?=
 =?utf-8?B?MjlOcUUveXliUG9nY0NKaGpjZWxsUWhqQjJmTlp0eUkwMXpyZk15K0l3dnBS?=
 =?utf-8?B?TFNyOEJ2bkVFcEZBVlVuNVV5UGtwWWdIUmg2VytvbVEzZU9GTHV1RVFSdjg2?=
 =?utf-8?B?empncG40RTVHVmtzV0IzVzhpY29QMmdGL3hnMUtka0R3NHlWc0JFRElMaDNM?=
 =?utf-8?B?MTFWeUtOeS8xUWk3aFNZU1V3S2ErTkxHZWUwWndaMHZKdXpQdnBLUFJpQnFv?=
 =?utf-8?B?Mm9NZGRxWldBbUhFODhuTjI4TlYxaCt4UHduTlpVMFM1NW5WVGF6NGk3MVdL?=
 =?utf-8?B?S2Q5dGpxczdsMnM4djhCUng3QlNNL0FkblZLN09tdHNZS1NXTTNWMWwxeFBX?=
 =?utf-8?B?WXN6dGZSK1p2bWxDL2VKdW1UQlVKU1Q2d0Z4Y0VzaGZVOFVHZlJzU1oweGVj?=
 =?utf-8?B?Ni9Gc0NkOVkxVm4xWm8zNXBQR1IrSVZKaXk1NXhiUFh5TTMvNEkyZVpXQ045?=
 =?utf-8?B?Q3hJUy9NaGt4MHB0TC9HeDlKRm05MG5MWnBnaUd2Z285WlNneHgxamp1MUZ1?=
 =?utf-8?B?WFpkRUV0cTEwVEFzbmkyZjFKcTBmai96OEQrbEZmcExUN25xellEQkFlcWQ5?=
 =?utf-8?B?Y1JleFNST3JIeHdlYWVVQTVkbGFIVjU5ZVl4eEpFdjVVZytxNHVyMjNVODBw?=
 =?utf-8?Q?cCv/bQYL99ffmJ7m0KqL86VAjdJDZYnhsQzuJAX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR06MB9065.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkRBRG9jOEIwTWd2Vy84b1diSnRYazAxTVVKRFFsam1pKzFPLzhPQzdaUWhD?=
 =?utf-8?B?b01pYkdaWTlqbG9tS09iK2drSFJxN0hMeGlKWGlsNTZycHBRdEh1ajg2dlJL?=
 =?utf-8?B?akFXSGdDNHlNdEFYOVY2ZCtTKzVCTGJraUR1b1poR3h1cTIyekpKMWJidElG?=
 =?utf-8?B?VFEvVzNLNmZkSHlaMWZiUitVM29aSzUxL0l2TEgvNkpaSUNxU1FCdlcyY2xo?=
 =?utf-8?B?VUVZTThoZ3M4YzhiWjMzZVViZnlTRFlGT3NRNm1OOVZKL1ZZdkI5L2VrM3Ro?=
 =?utf-8?B?b0NnK2VMQ3pnNUNtdDM3TEF2c0ZpZ09XVHJYbFFMSVBCYWlnTG5UVG5YSmY3?=
 =?utf-8?B?Z0F2bnZVYzhJT3B1cUlCWThsSTE4RHFwVGxCUWpHR2tOR0dLd0UyY2pZR3Vh?=
 =?utf-8?B?NnVrMEJocHpzWUtGUzl4NVQybE5PbHN3bDcxU1Nic21CaDZKMjZpcjdodytK?=
 =?utf-8?B?YjVGb2ZvR0xzSFFDOXFFN0QzRDlPWXVIbFVPOGttRWR2MnBXa0dIOWp3V2Zr?=
 =?utf-8?B?UjZvRlNyOG9qRk0wWDJSOG1SaE42NVo4ZWRoYSswaHNORGpVVG8vWDRnczBF?=
 =?utf-8?B?M1pjdE9aT29QaHkvdm5aWDl4OGVqSzl3a2N2ditOb1pLcXhXSEhkbUtydzJ2?=
 =?utf-8?B?eUlOZ1VjOHhoQ3AvcnpGcUdTVXo0REhkWmRuaXRCZ21SMTUxNkljR01KdWJV?=
 =?utf-8?B?NW1Td3MxdzRDUE9jVmJOZzhVaGhsUW16cHlteEtZTmt0MzFySXBudnRHUG5M?=
 =?utf-8?B?V1ZUNkdUVUpveWxIK2RYSUFLeDFrT0VzNjQwTnU1Si9kZnZaQ1EyTVczR1JN?=
 =?utf-8?B?UUhpWFRmTy9wd0w1V1AyOC9XZ1c4KzBaWVUzaFRGeUUvOEh0Q25EMHV4VWJM?=
 =?utf-8?B?OU9yNnZLWVFLb1F2VXFhdmdQUTdLcmlBeE5qT2NSRGNiaGd3TFo2eks0ZGZL?=
 =?utf-8?B?NUxrT1FXQ2VZa1JESStzSlpCcVdlck5ldmcrM0VJSy8rRjVhSGZham1Rbndm?=
 =?utf-8?B?SFhrRzJFK2JOTjVDeUJuM25ZODBCdC9ONTZZMkJFUWR0T3VoWUJRQzJ6SHdi?=
 =?utf-8?B?dTJsZEJGcnA1YjdNV3JtYTh5Y3JVaE9VTU5YSEpCdFR2QUFVcWlBSUp2Z3hp?=
 =?utf-8?B?c1BvMGRNbytpbGxKSWkxOU9GbUhTTkRpU0xJUGxMMTV3YmNyamJRRUZTRlFv?=
 =?utf-8?B?ek5Mbm1zWTNsRnlidHFxMWx2UW83ZU8wM0xvQU1HdzhxcTVZY21vZGVkS0Ju?=
 =?utf-8?B?OVc3UUE4L0xtSlQvditjOXpKeml4K25wLy9iL3BTS0YxSTZ6SGt3UEJyZlNH?=
 =?utf-8?B?M29oaFlTSmJkejlwZ0JNOGlCRzE4SWd3a1RPSWxrR2NjbDNERnIvVWc2YXdU?=
 =?utf-8?B?MEtIa2g4WXpkNEExTE1WN05YTkt1RlVFV2swdHJ4dzVLR0RnVG40U1V6N1VG?=
 =?utf-8?B?UUwrVEdTVVV6eUg0dkZHSWVzRUx3MEk1RnByS3FtNE45T3l2VERHclQ4TkVP?=
 =?utf-8?B?d3lWVzZ6bUNIT2Q5Q1FhKzE1a2FaWGVNaGV0eXFtQjg1Z05yTW5xTjJEMEZp?=
 =?utf-8?B?Vy9ua0VuczcxQWNoTUlaWEd3M1hkdEk5d0EvL0dob0Q5U3pBVDVRcG1raFVM?=
 =?utf-8?B?YjJpekVVUkdXcWU5SVJtcVBwd1YzZTc4M1ZEYm1UbURlWjRXNWN4N2FuWU1q?=
 =?utf-8?B?b0dQQVFPYmxUK0YvdllITmsrM2lreXNBSis1WFFaUVNFdERaTHNwZnJWZ0FV?=
 =?utf-8?B?TGJ5RXR1WFRiTWxMVjZxZ0RTQThtSXI4dGJUWU1DN2dpMXFmV1dwcE5LK0Mx?=
 =?utf-8?B?MDVFS0Q4YzN2SkZieHdNaDdLYXVVdXhUeVAzZklFcVByTmFtL1dSR2NzTmFs?=
 =?utf-8?B?NCt0Ny9vMXFQQ3VHRnRDU0NiYmcxMTErcGt5eHdUaXZNWDhtc2dMaGUybjVN?=
 =?utf-8?B?eUJZNkM2NXhTSWsrK1MxWXhaRGU4NlA3V2NQdUNiRi91QXQzN2lJSTRpNTc5?=
 =?utf-8?B?SXJxeFdkcWxrMysySWlVQ05nQzBmOEd4RWpQKzhTUnRpWjh2SDZPaTJUelYw?=
 =?utf-8?B?OWVGeTBPbTNDbS9iNjBreUhnb0ZkeUVZVmh1bUtTZlNzQXhoOFZ3dkFiYmUw?=
 =?utf-8?B?T00rMDFSZ2tET2tsUjlHN25QNFhpeTlwZXZpcXY1WENQQVI1RytGRndMTW0x?=
 =?utf-8?B?M3c9PQ==?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c3bbb-78c4-42aa-489d-08dd3ab6d9d4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR06MB9065.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 07:31:57.1465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZ/9DDsymC1IMoiOXv/P6Kk6wQ/XqyXCuxiwl5ZrvcijHoVbg9XK/PDIz0/18inWZRBPBQ5U+VickMrwESfLJPYjCclDrig+u5vSgYjSckg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR06MB6457
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

Hi Michal,

On 2025-01-21 15:14, Michal Simek wrote:
> [You don't often get email from monstr@monstr.eu. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hi,
> 
> čt 16. 1. 2025 v 14:07 odesílatel Tapio Reijonen
> <tapio.reijonen@vaisala.com> napsal:
>>
>> Change the order to connect gmiitorgmii before PHY creation.
>> The gmiitorgmii create additional in DTS configured PHY during
>> it's configuration. This ensures, that converter sits between the
>> MAC and the external phy
>> MAC <==> GMII2RGMII <==> RGMII_PHY.
>>
>> Fixes: commit a744a284e354 ("net: phy: Add support for ethernet-phy-id with gpio reset")
> 
> From format. Look at link in 2/2.

Fixing format in next version.

> 
>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>> ---
>>
>>  drivers/net/phy/phy.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>> index 716a1d46111..740533adeca 100644
>> --- a/drivers/net/phy/phy.c
>> +++ b/drivers/net/phy/phy.c
>> @@ -939,14 +939,14 @@ struct phy_device *phy_connect(struct mii_dev *bus, int addr,
>>                 phydev = phy_device_create(bus, 0, PHY_NCSI_ID, false);
>>  #endif
>>
>> -#ifdef CONFIG_PHY_ETHERNET_ID
>> +#ifdef CONFIG_PHY_XILINX_GMII2RGMII
>>         if (!phydev)
>> -               phydev = phy_connect_phy_id(bus, dev, addr);
>> +               phydev = phy_connect_gmii2rgmii(bus, dev);
>>  #endif
>>
>> -#ifdef CONFIG_PHY_XILINX_GMII2RGMII
>> +#ifdef CONFIG_PHY_ETHERNET_ID
>>         if (!phydev)
>> -               phydev = phy_connect_gmii2rgmii(bus, dev);
>> +               phydev = phy_connect_phy_id(bus, dev, addr);
>>  #endif
>>
>>         if (!phydev)
>> --
>> 2.39.5
>>
> 
> I can't see any issue with this swap but I would like to check your DT
> description first.
> Can you please share your DT fragment which describes this?

Here is our board's DT fragment:
&gem1 {
	status = "okay";
	phy-handle = <&phy1>;
	phy-mode = "rgmii-id";

	mdio {
		#address-cells = <1>;
		#size-cells = <0>;
		phy1: ethernet-phy@1 {
			reg = <1>;
			#phy-cells = <1>;
			compatible = "ethernet-phy-id2000.a231";
			reset-assert-us = <10>;
			reset-deassert-us = <400>;
			reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
			ti,rx-internal-delay = <DP83867_RGMIIDCTL_2_00_NS>;
			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_50_NS>;
			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
		};

		gmii_to_rgmii_0: gmiitorgmii@8 {
			reg = <8>;
			compatible = "xlnx,gmii-to-rgmii-1.0";
			phy-handle = <&phy1>;
		};
	};
};

Thanks,
Tapio
> 
> Thanks,
> Michal
> 
> --
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: http://www.monstr.eu/ p: +42-0-721842854
> Maintainer of Linux kernel - Xilinx Microblaze
> Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
> U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

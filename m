Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C6C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 11:22:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5990A82F6F;
	Tue, 15 Jul 2025 13:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VlPN7xzp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56F3882F8F; Tue, 15 Jul 2025 13:22:09 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CEFF82BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 13:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhHvd+oj6W8G0Jxw2S6OJeolQMQh11+b9HJSzNG0mxudPAH7McrxkMDzWTTzOrs3NF3QigEXzLJM3po3JoCOCZm8Vr5YDzK9eng1VBkf2lpPKA32EqW8g7fDrmqZtyE4QaPj1KDgOcsLrb+zeZ74EpDnSYILO46iU++Mmn1nCibx5MYqGqhhQzgK3DPRELe0Ezn6bpsPchYstTjWU0b//XZZo72rdIz5SOjkNr8cEowrHpqoJ39pWb/cdu+JH6mYhBfwu1VHSfceKdvyvyXPnuPVPUHV1kiQF5SXzsJ20FmB9pvMky8HA2zVw/qhsZl+EN3wBMISc6WPeWBf0SZsPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q5IRglzUuUKQwRKMzhPTV6YW8XCaLtrBSsXi6ZqCM+A=;
 b=bXrcDofxtv/6zmZ1MD15KT0pNQ0s6O5TUgqg+CP9irLOE01WSw1B/PLrjw6mi8eaZ3Y53m9b6eop6oVBIpd6gsYf/qC/UGYNn6JUPsqNMALnINLwIfEoKC7yosg4Lkpp1BjH1OZusXF/Ybl2zBSlCn94sfDPkceASZ2gdZC+sGv3yapv2b8o1b/bd21j/5bkIga4+oQibe73MfGTKyFu1t8I9V+xyTIuDFNeXJKQ1ZnEuA9ov+uQ0ivvpCbwCdDFtClXx1OG4CoosqZmqV+JuE+PT+reE7NKbQEXbYum3eP3MxVxYGgeVUucQDMRHj3TKvfzpo3g74wETfOw3HO8wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q5IRglzUuUKQwRKMzhPTV6YW8XCaLtrBSsXi6ZqCM+A=;
 b=VlPN7xzpMm5WPlKVxo9MbBnnebSzfOJGflu4mtkaGH4u/BTHyT8/oZ7q8A59YzrCuEtDZpGjUvr/8nOuYVc2lPJQsU+HHf27KjUSWIdR5O7+tCrCCy2Ia2pCWlWd0xMuUvZbLqlqwhZJOftnpMdi9qgMrheLy0oJVZKpSEOOPa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 15 Jul
 2025 11:22:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 11:22:02 +0000
Message-ID: <174963a1-bf6e-4e54-9946-bf3c42a72960@amd.com>
Date: Tue, 15 Jul 2025 13:21:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: cadence_qspi: Fix odd byte write issue in STIG
 mode
To: Prasanth Mantena <p-mantena@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: u-boot@lists.denx.de, tudor.ambarus@linaro.org, j-humphreys@ti.com,
 marex@denx.de, jagan@amarulasolutions.com, vigneshr@ti.com, u-kumar1@ti.com,
 trini@konsulko.com, seanga2@gmail.com, caleb.connolly@linaro.org,
 sjg@chromium.org, william.zhang@broadcom.com, stefan_b@posteo.net,
 quentin.schulz@cherry.de, Takahiro.Kuwano@infineon.com, git@amd.com,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
References: <20250704040444.671604-1-venkatesh.abbarapu@amd.com>
 <20250709082136.aiq63w4br3cyjxao@prasanth-server>
 <20250715111942.hjk5vjapxa5yrf47@prasanth-server>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250715111942.hjk5vjapxa5yrf47@prasanth-server>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY1PR12MB9601:EE_
X-MS-Office365-Filtering-Correlation-Id: fafc9620-d036-4a0a-012d-08ddc391d1fe
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YUp1MmRrejFNUGJhTmlVMEJIK29YWWpXTDFhNXBHcnJWRVZFbThVMm9aOFFN?=
 =?utf-8?B?TjBybzgwUFJXTGliQ3VBUE9pZ3p5ajBOS20rY2FPWERDWTVQczZMWGlpTEdM?=
 =?utf-8?B?cHNmSzVZRlR5cmkyVXEveXRDcUJLdERzUHBsNkE0M3pIMW5uRzNxUytXR20y?=
 =?utf-8?B?blNLZERBZ01kdGJ6Z2VKcnlyd0F5UnRNQndUQUFvSTJYY3RXZmpTTW91eFlz?=
 =?utf-8?B?SWo2a2Q1RksrKy8vWE1SZVlKeG4xQlVlZVNrSXVKc2FSZmxqdmt5SHpQSU54?=
 =?utf-8?B?V0xXRzh5NHZuVTBoR213YW9yUEZzcjZyQXhiaFRlSlJHdzIxM1ZrbE1NU1Bl?=
 =?utf-8?B?R0xwaFZaQ2JBbWt3a3NRRjJaTDZYRXpseEkwVVR2UnJoSmh4MHM5VlozQktD?=
 =?utf-8?B?Q3B1RUl0MnMzS2U0MjRJcHhiV0FSR0tUUkF4aHZudmtkK1l0KzZPa3dhNWFZ?=
 =?utf-8?B?SzdINUx6dndUV1FEWkhWenMwUFJvbkxPVjUxNEFaa3lEYlVUcHZ3Z1RMVGhz?=
 =?utf-8?B?eldzV1g2Q2J5V3BTTllJazJwWFhyWVBTeUplNk1ldjJvV1dwb1NxUmIzTW5O?=
 =?utf-8?B?eC80cStBSEZmYldQdmlkeU1LNElIL2FsSVZ4eHRWV1UrZ0t0TjBYQU4wdnpw?=
 =?utf-8?B?MjgxeTFnRklLWlBKME5USUQ2eENNbUppeWp5N25NbEUza0pnOFQwYWlwZmhR?=
 =?utf-8?B?WXBzZTAxS2dUOGJITmRHZG9PcTE0dHNBNzNVcHZmK2NSSFFhMXJaYzNDamxa?=
 =?utf-8?B?V1k5NzIwbU04WExSeXd6Wm1TVGU4RU5CbExHZFU0Y0x3SHZYVGpuN2JvN0gv?=
 =?utf-8?B?RVNxVVUxWnBiUFRxNFA5aGhZN1g2SVlORFRqdXJhM09xdjRKQXpMZzU3alNP?=
 =?utf-8?B?Qmo0cjFEYlRPOFJiR045ZXplVkhSRkRhQWYweDltMjgvRTE3d0xod2p1YjUr?=
 =?utf-8?B?cFpsWG8rU2JBVjlGQUhtdG9Ib0diZGV6U1ZJWk9ZbHlBNnJyR3JyaURzWDM0?=
 =?utf-8?B?V015eTF4WGQxSVloQ3MxOHNvb0ZwbExrUTNpUldXOU9sMlJHcmtCK0xhYWxJ?=
 =?utf-8?B?RlpCYmdQWVpHcWZnZ2g1dnhnNC8wcHFIcXhHWFhWODBDZnJOWUpTU1NmU3V0?=
 =?utf-8?B?SDFhQkVQc1lPS21kTENEYStDbXk0ZjhnRCtDbkt5V1BtNm1WL3pnaDFDSUMv?=
 =?utf-8?B?NFhRRFRVYkJUS1F2dUVtVTFQMHh1eU83YXNkdWM3ZGwxL3g2NlVJRzFSUGRu?=
 =?utf-8?B?S3NJV05MT1V6eDhBQmdOU29JWFFmTnZUemJvcG9sMnRzMC9wNGVlZU96VFRr?=
 =?utf-8?B?QTI3MmFaZ0FTSFZzbDg4dXFDNHlTdkp3UnNXR20zSlZvU1RRT09EUUVCSHVn?=
 =?utf-8?B?K2c1MEhUTmtCQ1gxbDVrK1FBNE1qRDJGNHdrK3VEQ3QrZjdIUGZ0TlkzUHVu?=
 =?utf-8?B?c3dQbU9BVkUvNlBTNi9pM2h3SjNOeHhLNlprbUhmbDZsYytXWHd1N1A4aFhG?=
 =?utf-8?B?VHBibFdReXNIVlZqRGttaFFhNFgvZFVEazIwR1ptS3BqSDhrQnNPaHVzOGd5?=
 =?utf-8?B?ekxiZ3ZMdXBsTDkxbGo5YTJwMk1OelBEbmNGbFRYQVNSMForb01xN2ZlV0tV?=
 =?utf-8?B?VXk5NjlUblNsRWtiVU4vbmd1UEVtZmUyQ3BobVExY24ydElTaVI3Q2FXTVQx?=
 =?utf-8?B?N1pxK2p3NWhUdSs3SzZCU01wUXdDcHVia1g3dDRES0RWVm5zdmlkNCtWRHhC?=
 =?utf-8?B?VCtoMDlJZ3pUVlRsTkpMUGFMdWl4ZFF2bWZNN29DTlZoVGdLV0FaRGtrYUNz?=
 =?utf-8?B?Q3ltRXduenJNbUlGbmFxMUFvNGZXS1V3YlZ2dFArLzBaRDMvZ21NcmdwTnJK?=
 =?utf-8?B?Z1pHRXNMSHpCMzBnUVhHZS83RzNNTGQzN3BJSlhPNy9KZGdZeXozdkZudW0w?=
 =?utf-8?Q?KY30Izzga+8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGFBekMzcytqRDB6L2ZCZEdHUzdEOTRlSWQraGcvMGovM1dsOWV2dmdORkxC?=
 =?utf-8?B?QkNUY1lZV0hmZU9mV283eXVrUEdUM3VkaVRxRVVUM3lqTm0vVW5RS3dUZkVE?=
 =?utf-8?B?YWxIOWJxbjVJeHBHSTdheVRHcThJUDRjdHBLb3ZLYUI0dnhvazVXdm9uRTla?=
 =?utf-8?B?eUhwRW1WVVVkQnAyRWUxU253MnFhR1dpbWt1N2h0SFA3bXkxenkzdzVpOERv?=
 =?utf-8?B?TDRIYUEyc1JGS0tKRmpzaWJWeEFNSzJva0ptS0lyU0p4bjJMVEF2eEpNcjJp?=
 =?utf-8?B?WEorV0dIa2VXeWdDZ2xVUDkxOU4vNmsvQlVLc21HeTJvaUJQUUdZV1VFYlQ4?=
 =?utf-8?B?dkhBdnIyNVBSSFQzRC9oaVZPZGFCQU5WWk12cnpHZ3U3S3lRY0RrUE0xdnNK?=
 =?utf-8?B?MVk2bnYwRU01ZGdBYmpCbnBrOGJGMlBibVFWWXNxVFFjeVFjY25VU0NwMEEx?=
 =?utf-8?B?Z0d1Z2VBQ0ZITTB3NHJjcCtjUm96dXNGeEJWYlJNVzRHSVFMNVhpZmt0VGJW?=
 =?utf-8?B?cFQ2U1E1bmRSZW5uQjE3aGxjdmZ4Y2xySk5IK05LbmZmMnBTcjgzQW5za2lH?=
 =?utf-8?B?ZytLcE9qb0FxZGxuRENDL3VCMWg3cmdkdndKbnFvSDc3TDBzcTdnSnhyQ2RR?=
 =?utf-8?B?T295QjJqYmR2b1RwdVJ3MGlPd3lHZzBSMXFJWmhwVzdWRlphSXhSTXg3bkZC?=
 =?utf-8?B?RVhRTkdyUi9KdlNFcXc1bHFMVW9xdXFxclZ6aUE3azhtYmhpQWtDektrK0Y1?=
 =?utf-8?B?QkN0YTBhWmVDRXpnTC9mYmZZNzlhWkhUV2wyaDFqdGlPZllHb1hseVA4U0NU?=
 =?utf-8?B?MW4xQ3FvaXJKeTNrQmsvTWs5anQwVGt1dy9KVlIxZlEyNkx3SXpPOWtlcTZs?=
 =?utf-8?B?dDFPTHphMW13QW94SjZZUzI2V0E0WUV2R0IyTndRd2M5NldDYUc2ZXQ2TmdK?=
 =?utf-8?B?WUx4RHNJVTRnSVZ2RWordEQxZVlrM0pUa1ZyN2wyMm5hWTNQWUlxZnZSS2NJ?=
 =?utf-8?B?SjV0amVrRlRYc3JrQnhvL2xRK3BreG5QSWR1UjZGVWM2OUY1cFJCSE5wWGlz?=
 =?utf-8?B?Z1FSNis4QjhldlNYZG15cVh0WE1kQ05mY2ZPNWFhWHVkQldTL2dPSlhsaDdJ?=
 =?utf-8?B?Mk1Ob1RCanpHb0EzNmFaWkVwQy9oVUZtektLbTBhOU9lSUx6R0lkTmEwMlFj?=
 =?utf-8?B?WkJnY2JtV1lWUVdyYXRhUW9sRnpGS2cvV09qNTd2TXRTTk1mQk91WGRwdzls?=
 =?utf-8?B?UEdmTEJxNDBYRVlHaDQwZVVTUHczSXZSK0s0TXVFVXBPbzN3dlQ3REJVUTBG?=
 =?utf-8?B?eHdXSWJRZklMU2ltZnRRNHBSeklBcThZQlVVK0Y0R0FkOWpCclR1WUpITHdW?=
 =?utf-8?B?TVozUUdmQVV6ZUU1bnZibGF0V0pSN3FoaTZhL3hBTEtjM2NvT21FNzB5R1lU?=
 =?utf-8?B?ZnRnNzQ5Z0hWeGppYS9XdnBwMlU3NFh5bnljL05STThvaTlzNVcwSzR3STZj?=
 =?utf-8?B?U2VIeWUzalZsNWtsWHN0cGNnanZEQ1o3U0RFZGtsVnVVVzdnOXRBcitycVFU?=
 =?utf-8?B?cEUyQk4yM3ErWVp0WDExUXVGM2s2MUloT1l0dzlQbVVMWTV2ZVFiTG9JY24v?=
 =?utf-8?B?SVhnakY0TWhtSkZwY3pGOSt1UEVkLzIwQ2c3TE9oeXhrQXRoZUIrTVZoUW1W?=
 =?utf-8?B?L3pOb09sdm1DMEV5STBiSXo0TFZBaGNqNmwrcW92THljbGdmc2lKM0thUzNr?=
 =?utf-8?B?dHRoRjRYSjF1WmJkcnhTL05nQzhaSTdXUW5pcDE0c2dlbjZEMEQxRE1Denhr?=
 =?utf-8?B?aFh4K2pHRjlwbXg1ajdEZDNqSmt5b0lkSHdNM0lVYk1ZZXc0TzJLRHZUNU5j?=
 =?utf-8?B?ODV1Q3pjZDZaakczYUFuN2ZLTUVhbU0vUk5TTFczVUdWMGhTcnhub3RRVnhD?=
 =?utf-8?B?aFUzUlBacURIU0FwNlpmSzA5WW1ZaWdlUjVDa0cvdmRucVJJbWtUM0xMbVVC?=
 =?utf-8?B?NjA3QWFma2MzWWlOek9jYnFZZHhoOG5TaWhCMkNQZW1PSFBUOW00RTdmeDBJ?=
 =?utf-8?B?cy96WHpnWlpYZTNmL1RtbCtxZEIydzhNcHUzSzVRK0xJNXVxWU1hY3grMWNP?=
 =?utf-8?Q?nrY/yXo1thG1tiMd/ApJ1Dnwn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafc9620-d036-4a0a-012d-08ddc391d1fe
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 11:22:02.0536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d1y99wUrD7n1GY3A7HDt7w8gQHq4hrf2nscbirLESYjWtngrAt2aPUZJnVOjVVGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9601
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



On 7/15/25 13:19, Prasanth Mantena wrote:
> On 13:51, Prasanth Mantena wrote:
>> On 09:34, Venkatesh Yadav Abbarapu wrote:
>>> Starting from 'commit <8077d296adff> ("spi: cadence-quadspi: Use STIG
>>> mode for all ops with small payload") the utilization of STIG mode
>>> has been implemented for read and write operations involving less
>>> than 8 bytes of data.
>>>
>>> However, following this commit, encountering timeout issues occurs when
>>> writing odd bytes of data in DDR mode, as indicated below:
>>> "jedec_spi_nor flash@0: flash operation timed out
>>> SF: 3 bytes @ 0x0 Written: ERROR -110"
>>>
>>> To resolve this issue, the number of bytes to write has been updated
>>> specifically for DDR mode.
>>>
>>> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
>>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>>> ---
>>> Changes in v2:
>>> -Modified the logic from using modulus and changed to use "logical and"
>>> operator to check the odd bytes.
>>> ---
>>>   drivers/spi/cadence_qspi_apb.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
>>> index b579699d2eb..76569a8019b 100644
>>> --- a/drivers/spi/cadence_qspi_apb.c
>>> +++ b/drivers/spi/cadence_qspi_apb.c
>>> @@ -554,6 +554,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
>>>   	void *reg_base = priv->regbase;
>>>   	u8 opcode;
>>>   
>>> +	if (priv->dtr)
>>> +		txlen += txlen & 1;
>>> +
>>
>> Hi Venkatesh,
>>
>> 1> Is this not a generic problem, having a DTR write in stig mode. If so,
>> shouldn't this be handled at the spi-nor core level.
>>
>> 2> You are just increasing the number of bytes here, aren't we writing
>> an unwanted extra data ? Where did we pad the buffer ?
>>
> 
> NACK. Considering the issues that this can cause, referring the above comments.
> Michal Simek, my request is to please wait for some comment / review for
> the common code like this, considering this merge was quick.

I realized that this affects also other users late. Sorry about it. Feel free to 
send revert or fix.

Thanks,
Michal


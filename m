Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF81C3ABC0
	for <u-boot@archiver.kernel.org>; Thu,  8 May 2025 13:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2640482905;
	Thu,  8 May 2025 15:18:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="evdB3q/c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB8D82977; Thu,  8 May 2025 15:18:55 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::701])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E461C828BC
 for <u-boot@lists.denx.de>; Thu,  8 May 2025 15:18:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eStJkJx0gEiSPEcVS4qpkN77DRL3Y79DN4cakNXU2WDC2iUcw7nhLuCTU0Tz4kmCCbWTB+s5wXycAM0KT8QZ3Nn28XG1nn/agk6I5G+F67z85r2v99c++PVb3fCmHsscblA26KZkZIedbYUpzZpJpGQXJoFW8nmHFbcbwQtjyEltLYgWztk8QM9r293BbFabERdkGS8vgitzsUkRfna5Qhc4ciX5nVy9l8O0oYBdxlzjXoPIq0t2u7E9kwB0r02DQjP2E+SRtrc0zZmM7L8CXD3l+73yV27YG3y6pPbEZSDhhXbdl4THKazwIp3BguADOwKe1SqXxW0AKyaQegrCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRROX4T4BBM4qJwTr/JnzNMr1rj1rdHm5FI+ffWK988=;
 b=IpQFZKZF/BErRkuED1OZOWQ12wFPK86aOalR7uC5ff3SB86HUN+zhP/HJqvD3wVy/1GRtYh7wXaztM/bGbTXMU5SR2xGBDywApY03C/VcXk6L517L0rF6QaW6/N7VYUGP63R6a5iqz7EWw5E6chQFquta517zkdzrk2rShEuezo2CgOWvPqQSGnuyy3T70EvKP70UcITYWSJm/hzgplzVrUjzw7nifG2kqYqWq9z0B9+jY8rkBtkH/WG8KbD2op499iZzpKR2U4cpmkpbHHyw3n5j8gMz4qipxncmfUaIj/M1yClOzHyESVPQQLTGiRU4HhJzCkgS9HJZsp31mtGNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRROX4T4BBM4qJwTr/JnzNMr1rj1rdHm5FI+ffWK988=;
 b=evdB3q/c/IhnnwgP67HdfJgC+lZVPF8VpWpFI+xrD//aNAa9eCbfcKm060yaqYd+WZMcJI95XWpNs6GFKWAQEhsgpyHTsVkL6vB8BmSF7QnR3FM1EE48LdPXnI5CjvgJV5OhMxm59QFa6D3uU7oPtlMVa+2FJ2FKV9tkSwyGzpjVJmk0CECRTAI+68ddVvmXzd877QhmVu5LKfTbAjGK+bBczZqq02d+a6yZCACVX2MmkoEfPqzG94/HOzmDah2M5ehm+khiluOqGKCEvl/sXpZDUgL3b5uS5c/Q+W3KDQSJh8ewxqJLSTRO8A9ZBzvvnCMWiSWFIwaGAmQpOszKvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by AS4P195MB1986.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:586::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 13:18:52 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 13:18:52 +0000
Message-ID: <c58248b7-9624-4c18-9aab-8852f94cd447@phytec.de>
Date: Thu, 8 May 2025 16:18:50 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] [PATCH 0/2] *** boot: Add Kconfig options for
 script-based boot parameters ***
From: Wadim Egorov <w.egorov@phytec.de>
To: u-boot@lists.denx.de, upstream@lists.phytec.de
Cc: trini@konsulko.com, jagan@amarulasolutions.com, vigneshr@ti.com,
 tudor.ambarus@linaro.org, joe.hershberger@ni.com, sjg@chromium.org
References: <20250508131641.2561876-1-w.egorov@phytec.de>
Content-Language: en-US
In-Reply-To: <20250508131641.2561876-1-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0046.eurprd09.prod.outlook.com
 (2603:10a6:802:1::35) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|AS4P195MB1986:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f6f584-81a6-4fb1-50a9-08dd8e32e049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW82ZmZVdURvYlJFNmtHVXRxK0FVUWIzaTY0VGxWYk1IRkFjTlN0clZvYnc4?=
 =?utf-8?B?bHhSazQrSWVxelNQa1ljbnpRVFByOXhYaFlLTjlKYVp0VjlvSlRncXY5Zkgy?=
 =?utf-8?B?Rm5ZV0RQa1dGYVJmQm9Lak96WW9yU09ONER5b2ZDOTljY2MvYmc4VzV6L0g3?=
 =?utf-8?B?aTlKOGRBSkJUQzBIR3grTHBTWlFFY004QytrSWZUYkxiV2VlbmQ4K3NMZ00v?=
 =?utf-8?B?enZRTmpsbmFaV3ZvT0FvdnR3UnRqK3YvSXFJQzNTdUJnMTlwdVVHdEZpbnk1?=
 =?utf-8?B?QldGK2NUOERBNVpZV2hhako3WGVDYThHaUI3Zm5JUCt5QmpENENpVUlOT0pK?=
 =?utf-8?B?RStLTTNkQWhZd2RhYUFpQnhJZmNlQnBlbVRZL1ZTWG55cWZaRmdRTkJlQVh0?=
 =?utf-8?B?ZGRuY2hiOXgvUUd3MWFPbkFkR0M2M09UUXZtOGNsRHA1eTZQV2gwM0h5eU9w?=
 =?utf-8?B?dTdxb2lRTGdhQ24yWnFibXJPdmhEZDhoR3lZN2MzekpMajF0NlVQUVRINFh4?=
 =?utf-8?B?SlZydVpHbU5QdGRQQ1dKMUxIRkExbmVWQ0NMaEpyU1BCRHJ2dU56bXBHTmlZ?=
 =?utf-8?B?UGdxUmFrZWFOa242L2ZRczBCYy93NEFNU1hzVEEvekFpYXl2NlNGWFFyUW9Q?=
 =?utf-8?B?Y1VvYXgrZ3gzbklPcDZNcVBZdFJJYjQrWEJ4SVdqTkxtUXBiOW1RdUNKN0hk?=
 =?utf-8?B?UHlLTDNVb2R5VHdYRGZVZWx0RC9PeVQyZVV0Sjl6RGZROFZPdVM3a3J6Q3hr?=
 =?utf-8?B?VlppenlKYzhscncxWWpNUXloMnZZSHpXcTUrR203clNjMFdjZE1xZFhXY2hH?=
 =?utf-8?B?NG5sUDBSOUJJazhuUXljdWcxRW5iUWJVSjJyUlJzb3Y5dWpvNlRmaUwwc2ZZ?=
 =?utf-8?B?cmFSakIvQTJTRCs4YlByUnJxRGcxL0lGc2pXaEZlUTVTTUZ3elcrcXEyZTgv?=
 =?utf-8?B?VU5tVW43aTNmMHFXTVFoYk5VSDNpRnFBNjRYWlY3RTVLbTY1OU9xajhOZjZV?=
 =?utf-8?B?akZ4VW0ybisraGpLdUdRdnFLSEljOG1uRGVWeVVMbkorWFNGS2NtK1ZUR0kz?=
 =?utf-8?B?bGpnLzdSNnlReUNkZCtsYTVBQ25UUkNoVnE2ZDVjNjhYdzh1bGUrc1liazJU?=
 =?utf-8?B?Kzg4NkZkeXpYWVEvRjVmM1hRWlJ3MVAzU0pmaUplbXRaTzBKbUpGZURxZ2Rm?=
 =?utf-8?B?YUE4ZHQ2QWlHRU1ONFJ5OHlac05qcTl0Z1R1LzlQWDRocUFRamdYbHVRTFNm?=
 =?utf-8?B?QkhiR0hGM2dMRkpSUGVOWUhuMnJLSHREdXh4TnZtSmxDNEp1dGxYalh1cC9L?=
 =?utf-8?B?S1pJNzJQb1htTWl1WVNKYlpZSkhOV2hYWXUyNTJmOGdHbkpQV2s0anVncGlq?=
 =?utf-8?B?dTdXSHRpczJiSUFXMTgxOTg5WXQ3dWFpQ3ZBZWRERk1yTFFkekdGdldkdWlB?=
 =?utf-8?B?Q2dXWHJzUFJLbmxrbFIwTnExenhYSXRTQndLZDlHY2JaT3IybS8zem1VK2JK?=
 =?utf-8?B?OU1EcmdIeWQ1QndnWlBwM2RINzNMSG5rMW4zWXZVTnZYUFp3SUo5T0R3dGZr?=
 =?utf-8?B?OWFpZW95bHNhaHFMS1pzWTVrOElWT2MzenpjNmJPS0pzcURseDlSaVE2ZXhv?=
 =?utf-8?B?Zkc4ckZZQ3Nwb0lwUllTbUtzS0JldWlOU0dISVd4NUFzWnY0MDhqWUpDa2to?=
 =?utf-8?B?Wm1WVHRpNWJWL3RQR05sRk1keU0rcFZRMWNrSGQ4RjdEM3dEbVBad0RXQ3Bz?=
 =?utf-8?B?WTlFL1dab2xYaGtHS2dmQ1hLT3hFa3N5dWxPS1VsRUs5M0JNZkd6dXZmc3VO?=
 =?utf-8?B?WHYrNFJsT1ZFSjJIeFJYV3M4dGVTOVowOHBSWkE3NDRNV0lTMW82UU5PUE5B?=
 =?utf-8?B?MFRWQklSNEhQOGtKZHRoSHNsZUY2Qm5LNVJGRjRzTWhqL3c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVRNUnpraXBLU09sdzdjczhVSVIzcGlXZkJrTG95YzNCTFVtaGRtek5uVnQy?=
 =?utf-8?B?OTZwQzZybGYySUt6Q0oyZjcxN0c2MnFEMFRuemUxNEFOWlNWZzVsalFxdXZ3?=
 =?utf-8?B?QjAxSTNCMmY5MFhoWm9oQXhiNk5HQUROWHducEhtbVREcDVJR05jVEUvKytt?=
 =?utf-8?B?dGpNR01QbzZHdk5hL1BoRW43eHdSdUNNdGo1RmI3MHNxZTFsWFFWNm9TU1Zh?=
 =?utf-8?B?YzZJNDU1U2VzSHZ3bnl3amhjRlFYdFV5MU9TQVlGYjRHOGxVVi85N0dwRTBQ?=
 =?utf-8?B?ZWVCMllqem00QWdibkkzOVpZUmJhcVNNblF0Mk4xOU9QaXlhd056cXRXeC9m?=
 =?utf-8?B?ajFiclBBSEZXZ1d2QjhhMFhNQWRubUt1MHkxdElqdUxKblpsdlZiV3d3Z09M?=
 =?utf-8?B?Z0ErZ1h4ek5ha0RwYWZuWkU3SGtpQllaNUJVVU1IdmYwUlNFc21LUHU3MHpR?=
 =?utf-8?B?TzRBQzFZbG5ZUk52Q04vTHRZclhHdjB3Y2Q1WGNzYjFydzVpNjlkYXltVWVq?=
 =?utf-8?B?NWhTejFuWVVWWDZZSVUvZmt2TGZiVVhydDB2alF4S1BDWVlPRHcyM0VETVVL?=
 =?utf-8?B?QXVBb245MFdvM0tlMlo4NiszeXJqcWJwT1FuNkZuYWc5VDV5dUFTRnMyZFIy?=
 =?utf-8?B?VGkyMElFc3pYZy95eDVMN1gxSEVsSFF4MG5jWG1GdDcvQ2pMYkY5WUQ2YXE5?=
 =?utf-8?B?WU1UVFpJN216dThUQW0xK1l5UkVEOFJJYlZLcEdDc1VUMytiRWJibFk2RDIr?=
 =?utf-8?B?N0Zsck9xdytxbzhZRWp1YVRPVzVjbzZPd0QwMmlRVCtqa0lRbnQ0ZG8vdXhu?=
 =?utf-8?B?eWFFNXpkSTV0RFkxVTgxdElXa3doTXd3cUtSV1FxeGc4bkVKNFdWVHJqdllG?=
 =?utf-8?B?TVdOMG1zNlBUaTZtUUxITUEzYXNtRWdZZFBDbHNXRlpRU0p1YldJWGtXM2lM?=
 =?utf-8?B?Mk9NWlB2a3M2SU5BYmlXclZQYmU0cC9sL203eGxXQzFNcUV0Rm1VWERQZEJ3?=
 =?utf-8?B?bEk1d1VqdW9EL000RmZwN25oUjB4aCtYdWpYRHAyOUJBTFpPaVg2bWtIanhM?=
 =?utf-8?B?b1FTTHMyMlozUTVlL1Bub0FpbjVsZms1MllRVlVLSStYSkoydkRHWGVhaUdl?=
 =?utf-8?B?VEZJSG0zbUtiNEJ4aEl2UmZmQVVXT01YNXdPNlltSlF1Q1k0M2xPdEt2bFZq?=
 =?utf-8?B?ZFI4NDNGeENROXl5YjFPdFVTbnVmVFBBYnMrYkE5KzR3UHUzU3JwRGZ2bXJO?=
 =?utf-8?B?SUhtOHZDSmtWOUc2cFczN1pQaFVwdTlZT0U5dWhRZW1USTBtdzhlckFTcEV3?=
 =?utf-8?B?RFExM0E2bm1pU3ptQ3BZVEJ1dGZyaFpZRXdBeER2R0k5VkNjcGxYOUljVG4x?=
 =?utf-8?B?UDI3RnZOVDJLTVdrR21NS3g1NDhjNWNORkZBd29hRGNmYUM4OC9hc3l1SDFn?=
 =?utf-8?B?c3l6bFpBeVUycUxtcUxRZzYwampoWDJTQjIwOFQ3bE1hWldHT3NDYWJ0cmhW?=
 =?utf-8?B?S0huWXJ2Yk9Bc2ZuSzg4NVNtR01ma2tlSlBvQ01FMDk0MmpObHpVQnlwZ09Z?=
 =?utf-8?B?SStTeHFHQ2ZzdHV3UmQzRWZEc3pUVS9Wby9zTnMyM1JFdzFERWhpK0Y0eUth?=
 =?utf-8?B?MS9iM3ZYOUZYMEMyMlpmME1sd3pCMnFQT0x1NlhqUS9tMkRmbml1VzdLWTdD?=
 =?utf-8?B?Y1NnM015RXVPb3FWWHUvekJ1NXFDZ0dQallvbFpYbzNsUW5lME1vWGNURG52?=
 =?utf-8?B?aW1reEpha2RIa2hhcU9GN1NKL1Rabmx3WGRRQTBaT2F1OVc5WHNzNmxMSFF4?=
 =?utf-8?B?dlI0Myt3QysvUnRRTWh1TjB6ZzFjanFQemlNaUJBYkp6SEZPVmx0M1QxL29i?=
 =?utf-8?B?RjlNck5EZ0FkT0lGV1VhWWJlS0Vpd21iY2NUWGdZSmw5SzJaRG9qS2JPaVE2?=
 =?utf-8?B?YSsyajdyakQ1L28rNjUzRzVYdklvWnkxYnFGUU41ckFYUkV0VWtoT3UwMnBk?=
 =?utf-8?B?MG1ER3JTSGt6VTJJbkZ2QTFPTUpmVktwVUkxVnp3RGhMS2FIaE1qOG0yQVAx?=
 =?utf-8?B?bmtzaEk0R0Y1OU9BdUQrN09IbXhnSUZidFpVbXNPOFNzUFlLY3p2ZnpmYU9P?=
 =?utf-8?Q?FNxzxikZKTpCPIu99GO+m3WbQ?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f6f584-81a6-4fb1-50a9-08dd8e32e049
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 13:18:52.0393 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rOeGa8KHwJvu0I8W/ycaHZeN5eYejrc1CXz8RKR3FvYofGX87zPVkLZiCaWk0MwR0YqZ4/1TroR2uJdoGNePHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1986
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

Am 08.05.25 um 16:16 schrieb Wadim Egorov:
> This series introduces new Kconfig options to configure default environment
> variables used in script-based boot scenarios. Specifically, it allows
> setting the following standard boot environment variables:
> 
> - boot_script_dhcp via BOOTSCRIPT_DHCP
> - script_offset_f and script_size_f via USE_SPI_FLASH_SCRIPT and
>    related options
> 
> These changes make it possible to define standard boot environment variables
> directly via Kconfig, allowing higher-level build systems like Yocto to set
> them at build time. This avoids the need for post-build environment patches
> or runtime overrides, improving reproducibility and simplifying integration
> in automated firmware build workflows.
> 
> Wadim Egorov (2):
>    boot: Add BOOTSCRIPT_DHCP Kconfig option for boot_script_dhcp env
>    mtd: bootdev: Add Kconfig option for defining script parameters
> 
>   boot/Kconfig            | 18 ++++++++++++++++++
>   drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
>   include/env_default.h   |  7 +++++++
>   3 files changed, 51 insertions(+)
> 

Sorry for sending this twice, first time included a mailing list which 
should not be in the CC list.

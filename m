Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D9EC3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 15:22:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB4DA8006D;
	Fri, 16 May 2025 17:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="BQFOz/5a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AFBE80079; Fri, 16 May 2025 17:22:26 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE31680050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 17:22:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0gObny7WQJPQno2kC1RecYPkmKPqLH8WHmGQqrvJXly1Adtet+c1CLvcbCPiJB/tlQd7YmR1cz9cSDYPUYzmLpVDXIhb4EE8GzqiNs9hGpeVTuc9UabJnAzNwJCE1e1L4bK8mMz6JowoVpFIIgtU8SEHQi32AcHS+7/cc5YC/HHIXf5jLqxKi7ggE2cN7U5n9KpeZxTargWpfW6bZ6w2fqIaNAX90J8mV8vyY0VDRBKFf31qKW9chRugrnKZFBA4F4aKQoeDNWEUB4awal22E4sKy1iKp8Fn1iLU7eugLepfvKqCba8dQxzHvJ+T4UMgYWy17logsg9hukfl1NMug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DqWFtbYjm/hdwQbxorFkQktGD0HsnXS00m/6JZpHJn0=;
 b=jGdx/TeRXHLu4hMiyv7sVzmgaPIr1CO4vI3odTl8ZPaY2JqGLffPuMnWIK4AZ/BbFR9DbI/A58X4IvFI7HNZqTzPQloGVVbgEGo+ZNPGpWdl9OkFliiu35BNyYSK1sHdPK1ifTlmKIpXLiC5q9L78RwzYcmmgET4mJZwO0hdLBcnQwY7U0ME0zpMxTTLylubgBxC7Qru5pgA5LFHsOffBQsTBcRBfcgFgWQcL8afONGHpmMi6Vu6bKJnuYvY/uSYMUPXYlfRZEboEHuZkdmlapvBXm6dT6nowBEa8BEEUOZXI0VGU2sM3feQ+CcvBIZVjUdBUs/D+K1RihKZwbhU+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqWFtbYjm/hdwQbxorFkQktGD0HsnXS00m/6JZpHJn0=;
 b=BQFOz/5a0mB/TlEDhlpfh4Cx+GT9cKBOHrBc6/COIOI1SPsu6QVMV6N2Ov7RS1lcRomPNpKYi4AVLY/YfQ97IbFWM2B+XBMJcSCghRsgYOSHUC1gm3Mmmg3CeWycbZuUO/f4NeWmN+2R21Yusylt+5p5RbKbWcl8Woo8SR//ZXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Fri, 16 May
 2025 15:22:21 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 15:22:21 +0000
Message-ID: <045c14ca-084e-4006-a10b-46d76fc70c34@cherry.de>
Date: Fri, 16 May 2025 17:22:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] efi: stub: Define debug uart functions only if
 CONFIG_DEBUG_UART is enabled
To: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
 <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250515-silent_console-v4-1-dec6c8391f01@thaumatec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0119.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::48) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU0PR04MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6c9e2c-ccd3-4629-fc6a-08dd948d72a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFc0QzVuR0czRmY4V0FwOXQxMG9lcWszb3RMblJoQ3JxckVsQXdyOGdGc3BB?=
 =?utf-8?B?SlB2bTFUU1JsTjh1THZOT211UUhQUjBZSVE2U1BZZ2szMGJ6WjlkRzFPWWlU?=
 =?utf-8?B?SWtBTnVlMjBSQUpvSjJuZnZHdzJHVFMrY0RwcUdJT0R4UGFtdnExOU8yOUpH?=
 =?utf-8?B?RU04T3JzcER1SjdPMnowSmdwZTdsRHZRZy9zZVpiZitvN2pSUDMrSzRMNmZN?=
 =?utf-8?B?NW5rTzFnZWtaM3prMENIcWt2NExnQjJ6bVNmYVZQTVV3b0tGbGw3dWhpZklL?=
 =?utf-8?B?Z3dNZG1hblpod2lsWDM2WnZHeW9EZHlxUzVmNFUzWkhPMWtNRTFhN05aYTV5?=
 =?utf-8?B?TmJYZ1MxNVdlTit4d3U3OGNzOWdNa3FIdTVOLyt6bGFHaXdITjBnWS82WjQ3?=
 =?utf-8?B?V1orNm5pNGd4Ty9oWWR2Z09VT3lwc0RtK3dyRmQ5MXpXUTZVajZTTUE3cHA3?=
 =?utf-8?B?aWJ4NFlTZjNRRHZXNHJ5ZWpkY01TV2pKRDYwNGdaOUhmcjh5MFhrOXVZdTRU?=
 =?utf-8?B?T3BhWE51SU9PQUtNL1VXR0VkNXV0dUpHdjBOMWtrUlUzSzF0SGpsVnhZUkNT?=
 =?utf-8?B?SXNSNkRsM2d3bEYvdXA5cUxJb0NRQlhCUFZ2V052czBkd0puL1E3OVdzWWJM?=
 =?utf-8?B?V2ZtY3dhUUJKMnBJcUpSMnJqWGR1clpZVVBjRmxwS3Z0a0RHa3pXRmgydHF6?=
 =?utf-8?B?VzJNTjdUK1lnQlVjU1ViVE5LZ1J2ZldVTmR1OW9lbGJpbVQ4aGJuVmpydlli?=
 =?utf-8?B?WXBGKzNnRGpwb2VneEdidmtPU0xOT1hEL3VDU0V6elQ4Ym1LTjF0NWg0Vldm?=
 =?utf-8?B?SkR5RDNlNmRTUUVPMWhrZzNMSXFCQUJEeDJpU2kzdC91NCtKUUszNTJrcVFB?=
 =?utf-8?B?aldLQ2l3Wit3UlF0clZOcE5uQkFHcThqSHlIUzZvYldrcUcvbnRheXVqb2RH?=
 =?utf-8?B?VitSK0w5K1IxQWFvZS9STFpsVnQ3bGFEZjAzNFQwYXFCcmlLQmJMd09HSUZZ?=
 =?utf-8?B?UFd1Q081QmlSUFZ0T3VkRmttL2tucWpKU2xOTzBBOXBiRDNmTTVWcjNiWnVE?=
 =?utf-8?B?Y2pTVVkwNW1RUXhtUnZLZGxZU0FwT1dqQTVjUlA3MTMzazBpbURWejV1WEg3?=
 =?utf-8?B?dkJ3NWRiMmxTNkpUZFV6REZKVHdwMThuNTE2dVkvWEdHd3orSWN0d3YvNnk4?=
 =?utf-8?B?WWlOc1NoNWk1aGVMaHVQSUpSVnRiTVhPQnRMaHhkRkxneGJwc3J0NFkvZXBE?=
 =?utf-8?B?c3JCekxhT1hnTXBpK0pFQmRhU0dCWGpoWm5KVDJ3QWE3Q3Z3alhwY01mTlll?=
 =?utf-8?B?M29vTGt0RWRNbHlhbEZ5d0s2Y3dSb2RwaFA3Um9iT2hjWTk3a29wanlIUmVt?=
 =?utf-8?B?VnRsbE92U0tWQXg2YXlxTGVMZklwalpIWFNGQm1aVFhGOWZyQkxSUkkwWEJw?=
 =?utf-8?B?SXB3L3VxTVdGcy94VmwveDBzZjFKdUp6eWFwRGZib1UyRnFuNTczZXRrM0Nk?=
 =?utf-8?B?M0dycHhURWhKNmZsZjAwbkpqUlRzbklNd29HUHE5S1pOT1NzS0E0WGxvQW9y?=
 =?utf-8?B?SXE4SWZLUXViVk1VYXdjTURLdTBPUFEvYkIyUXU0bDhIRzArZlM1Wk80NFY3?=
 =?utf-8?B?aVgxZ3NWWWlxVDRKeUFqVFBEWEUycFpISXBCc21aL0l6Y1lzb2RtV3c1aUlF?=
 =?utf-8?B?SkdZSjNSR2k5S0NZZlR0aitER2FlK3R3dGF4b25WV3c0Y3FQbDkyekRDQUIv?=
 =?utf-8?B?YWc4anJ3K09WSitReEVmMGtXQ055QXMwWkhaaHU5b2RHalZZa1BsZjEyTzJw?=
 =?utf-8?B?VUJLT2taZnpEOUVMaGthMm5rekdVanpEUlpVUW04QXJ4UlIzRjAxenJpWVU3?=
 =?utf-8?B?eW5wRGEwcGlVRTVkY0VKOGR5a1pTeTRqVlJsekFwZmdEaWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFlwQk1oZWVJRytSTSthNXBYZ3hpdWdoczJjbmVpdmJ6d3pDd2ZNYmJnLzR2?=
 =?utf-8?B?RTFqUThXYmIrdjZXZm85UStzVlRoREErWjR0REt3UjJLdlVwZFI5OVIweS9B?=
 =?utf-8?B?V0hhNVV1ZlV3NDZpZG10aHNaUFNPNG91cDBEdGhqSEpyY09VczNtVGJXdDBq?=
 =?utf-8?B?eG1kdENhTWg4SXFML1pjaStFODRhWlBrL2NmcE1mNmhqZ2ZPamRaR0dRVm15?=
 =?utf-8?B?YnBpMHZmdXptVis0SlljQmErdmlNYkwwUDBTUDR0Sm9nS1orcnN4WDhZcXl1?=
 =?utf-8?B?NDNMdy9PVlU5TDE0YW53N3BEbmZkQ3pCV2hRMjVWMmpMWENibkp0TzRvZHdE?=
 =?utf-8?B?VWJBOXRDVXcvTGhQKzBCdE9weFYwMHRsK29DU1lTdUY2VU0vS09GZk1mSytC?=
 =?utf-8?B?ajZWSDU1bnRZdUdXUTcvUGdDdThlcUp4bTJHV2R4amhXM2R6VmpKdHRQK0p2?=
 =?utf-8?B?RzZzUHc3N1huVnd1Z0dnVVBFYkg4S0Mvby9xaGQ5VDYxZnR4QTBhN1lOcitr?=
 =?utf-8?B?aHNzb0xUYXpGMDB5SVJ1Ykp0T0VGUXVrRWhaWXdUT2hCbnhTQXp3WnBlMitq?=
 =?utf-8?B?eVJ3NS95U0tqOHdtV3ZuVTY2L0k1eWpMRHUxYzlycEc4WjVwcmYxbjF2WFdz?=
 =?utf-8?B?a0ZDMjVIZy94aWlTbFpXenhQWGdxaVlteHpHQTBDeDNMVWtQQXYyWGNOa3ZW?=
 =?utf-8?B?TnBwL1g5VStPQ2owSjVnajd3aGUyNzl1anRzZE9TcjFBYUJhbGNlUnZRcElv?=
 =?utf-8?B?MExreW55c3JsSHgrYjBhSC84VDU0UzVockdBeUxnWFFGVDQ4Z29XVjg0Z1lW?=
 =?utf-8?B?V2dVMXBPNlhiUkF1OXgySHpYQXlxZjYrb0lFRThSbkRTLzluamtkb2VjU0hz?=
 =?utf-8?B?UEdFTkUyRUhqOTNCa1JOVlh5VEVYZ0JXbVN2Q3RpOXo2SHlUai9WTnpmc3NV?=
 =?utf-8?B?ZGV0MDN5cmRacUptVTJrbXBtN0daeTBoelZ5S2NIcGF2MTJjcVVtanltUzhC?=
 =?utf-8?B?UTIwd2JCc0ZyNzF4bXE5cHBCRGZadUxxaDVBM2o0M004TkZkTm9SaWFqeHVh?=
 =?utf-8?B?MUtOVGpsR3VBb01pc05iWUdLN1R4S093VnhxRldkQXpCSEJNcnZSbjd4Y0lY?=
 =?utf-8?B?bmFJUi9WTEVTS1pyMjZyR25zdWRMckxvNHNncEhvZ1dtKzBmM0JSNWhsK29D?=
 =?utf-8?B?Y1NXQWovK3VNL0t0bWFZZmttblZvRXdWS0RYU3RTcFh4dU9lcEdCbHNrdUhv?=
 =?utf-8?B?bThvblh0eUlCVDRmSVlqdFFoaUlFUnpxemx1dnFia1lZK2p6S3IrRFBLbFcz?=
 =?utf-8?B?OFUyWHkwTnFwUG54a1RWYXk2M1FpRmQvYk90MXNwMjkwMXBnZVMvVTRKQU1G?=
 =?utf-8?B?R1I1c1hDOXlaYkI2NXUxZjB1L3FQa0crOTNGRnM2SFF3RGh5STJ2UzBJbmpn?=
 =?utf-8?B?cXpac1hId0RoVWU3SVdpODEyUGZ3R0tleDNCcC9wM1BNVWFOZnVONkpMVmxa?=
 =?utf-8?B?UUZVbytYaXpTV2ZlNDFla2duNW1RMUgxK09FY2twQlBxZExHM28yVmR2TkJL?=
 =?utf-8?B?MEpQRGNkaGh1dmZacU4yQVREcmhqY1IxU3IrVjJoZEg2YmxrMGU0eGpFTmJy?=
 =?utf-8?B?WG5wUS9HQ2xuZ1Jtai92NEJKWDI3TEpNMjlkeTU1UEwyUFhzV0N1U2RNRW90?=
 =?utf-8?B?dUZQRDliR0MvNTlTOVA2VnhidDRibzI1WWR6SFN3Um1saEFtNEJxd21mNStM?=
 =?utf-8?B?eW9nekJMSDRpeW4rY05PYzRhcERac2UxTUFPcnkrQ3oyUWIzSlB5M0xWOTY3?=
 =?utf-8?B?ZllrOXVZOVhpQW5xd3BkRjRJZEhyY3RMNnNyc2lFRU85TGwxVEFBUmdQMmQ4?=
 =?utf-8?B?cEYxeTFCUmQzTVh2M1Y5RHBxV21pblE2Z1pMZ2FSSENIWmlZQ24xUzQvc1dN?=
 =?utf-8?B?Z0p2cXpveDkyU01yUWRhcnJESms4SjhZbktqdzkxRW55YllDTUl3OVZJaTFw?=
 =?utf-8?B?SE1JSURVWlFCVGQ2WkNZaWQwM0grVkdNN1dKWGh5RUlmdVQxSmhFTjM1dFFs?=
 =?utf-8?B?ZmNCYndwNnR6R2cyVnhrRGJHRW9TZi96NFdUWTZaTW5GZWM1anVLeldveW81?=
 =?utf-8?B?QWY0bWNBdEprWE5GVXliMlM1WFpvQWJYdTF4QTV2MEM2UFd6TXQ3UVR5RHdO?=
 =?utf-8?B?RWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6c9e2c-ccd3-4629-fc6a-08dd948d72a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 15:22:21.1047 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5arcRRkv6aMIN7PjoFgcR+6sNJXY2UPAm3H0A1CL9K7+ZPD6fp1gS04ueXuiKgQE5QTun7omxR+FD1E3qhpjdR2ZvcRy+YbVx+Qw/1IUzr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496
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

Hi Lukasz,

On 5/15/25 5:55 PM, Lukasz Czechowski wrote:
> Initialize the debug uart only in case CONFIG_DEBUG_UART is
> enabled. The _debug_uart_putc is used internally by debug uart
> functions, so it must be also included inside #ifdef block,
> otherwise it will cause compilation warnings.
> 
> Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

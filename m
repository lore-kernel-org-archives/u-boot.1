Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3464E77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 07:29:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42CE580285;
	Tue, 14 Jan 2025 08:29:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KhZDi7px";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4E0280691; Tue, 14 Jan 2025 08:29:24 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::602])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2428007D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 08:29:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jaQ8NMToSBCcJ50fTgMCKtSSPNMgBwH6I4EWKuMbscy92hAwWgvosj/9uS7GdhwbEoaKgfEdp5ovVadLTnaNFkJ1kDZhtslMSHuDXGg5LeCuD8JYI5rOLGLxBEwgXeHkysIpLxXFH54Kq7YJYInKhPXq/pQgdtAUDfs3EmFxdm36kK0HT0X6qXTs3/jF+EajYrjOfzH37PQ7KREsJegjuHkbbCYrlzjqcrTMWwNl7siTi0fg4pUn3+SZzeBcvSPN3773SjXCvCAVfHreh4lsphwYTr0BufC/arVhPW+noemdhl/fCIo3ftmcim9c6sgQrexnakFP6LGu90HwPY05lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mfVHzRFeKbbGja1Aqb9utjfMBoMOpIpfKDiHMjdoup0=;
 b=GIUDiDoLNS319zvqUGkbgQZbJJqT+4b9NqbprEEs7d74Te00ykjNSDE3/QANTAC4KbUtXfBfavk5ReRQ6LDb4G5V3IMTsGcFszhiy6RHmJ296wLVzWcGo/0OALuvafBSchq7sntrC4ydHA9AvWxTPCztfPefIju6zvELv94UK91x0UWEv8mQXJ15ljmmXMjYLILxW88lMNsanxVu/9+tKDW9+/ndFqpdhkBkdTVlOBmDqGkx3TxLqhUeATLG+z+Wa1NpG4lpp6V+euKfzZFF8Wq+LQd+Jnu8UgACe8vPfDOlJ1vX+PTuqOwsqLTunCTAxKqy23QlGEFkPI06qCusEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mfVHzRFeKbbGja1Aqb9utjfMBoMOpIpfKDiHMjdoup0=;
 b=KhZDi7pxzanLrspzc75VcClvSp9/hCdIxwM/Orh/JRRgSpaY9RcjRG+JgaCXEGZPPRun+SIsVNXsj8j0R73pcE7gy6+zMdZW4HKJEzngLbtxr6LPcF+jNcJ8MK55VFtW7ANBWyN2CUkA9QOQzyVHCmbrvknk1R9x2YGlLOwo1/0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 07:29:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 07:29:19 +0000
Message-ID: <4dd1b56e-b9ef-4c16-8f8b-02739f80937b@amd.com>
Date: Tue, 14 Jan 2025 08:29:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal: RO multi_boot register in non JTAG bootmode
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <484b9cafc45e72308a1a29a3ab772020f96784cc.1736155238.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <484b9cafc45e72308a1a29a3ab772020f96784cc.1736155238.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0311.eurprd07.prod.outlook.com
 (2603:10a6:800:130::39) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ec83a66-7b95-457b-e0d2-08dd346d2894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzY1MklVM1NPRGZ2Rk1BbHByK1FLNnJDaHlJZE1IcWFHU1JwMVROQ0s4b0xB?=
 =?utf-8?B?WDlXZWk5K2JibWZ4MHZ4ODRLRlV0WFh5SDExeHdEdUI0ZzNsZStKSFJoKytE?=
 =?utf-8?B?QUpQNGludVNvc0pBTzY2SW9iQm8zM2hPbWg3b09wVFY2YUJSSWVoVE9Odk10?=
 =?utf-8?B?WEswTC9Fa3VwZ2FNcEpKeHEyOVBUV2JPRzdlVGYzVXV5ZEszQ0hRdldEUXNS?=
 =?utf-8?B?REFKWm9kam5HckRIMjVoUDFkS0NEUmFiM0YxZDZFYW1JMitFb0krUVR3aTZT?=
 =?utf-8?B?cXhGaitYenIyY2o0TFBXWmtZakszUytycXAzYXdDU0NCNGd2TVkzYVlrZ1Zn?=
 =?utf-8?B?WkpvZnN5Q2Y4d3FLTTBlQ3ZOejgxM3B0RHJEeXhXbFZ5U0FMbWJ5OGZtek50?=
 =?utf-8?B?ZmlDb29DYmdFWW5JMWg2Y09DS0RKVzJrcXdJUzBsVWRTQ0dtaEprOWJsQnR6?=
 =?utf-8?B?TlJKSDZFY0lHQU16Q2prSXdSNDU1T0dPTHkyNitEeE02UHdKMHV5TXFld3hG?=
 =?utf-8?B?eEoyZGFtZ1piMCtadElnZFFRM3ZoV3RqMTNvTXN6amdxRjRnZGI5R2hueE5S?=
 =?utf-8?B?UzN3a1lkcjFkNDFFUC9LbFVlMWErank5VG1WYmRUZ2RTRHJHVVRMcStaL08z?=
 =?utf-8?B?bEpkN2hWMm56dlhCY1BwOHBJU2hlZnJNNEQ5ekVZZmRQMjdZN1ZWRXVTbThx?=
 =?utf-8?B?bm80UkVPa09XQTVCeDY1eWNLMVd2RXdHbGNXajc4RlFXcjVsd25hVWNjUDZF?=
 =?utf-8?B?T3pQZTcrOEl1aXdUZC9uNmRYUFJHV2RlNkt1bHBCUFcxRTROdFJHZUZoRjV5?=
 =?utf-8?B?WlJRQlYvM09NZTBHUG5PbUoxMlpiSVgvUi82TUJZUHZqUGx6MUlnWW9TdEpG?=
 =?utf-8?B?Y05tRXFJb1BZOSsrR1lWTEJFa0JJbzF6WEdFNFVKdGZSeTlJTzQzV3ltZnRn?=
 =?utf-8?B?bVQ4am42T0FyRG03em95UTNvZGZ5TmNidmQzT3Eyem9oaHlLbTRGUEtxRDlW?=
 =?utf-8?B?bS91MG5SUXlTM1hVUExzWE81K0x5MXdHTlBiTW9GN3hRT1l5ejR5MDJrT0dh?=
 =?utf-8?B?WWU0WS9GcDJXbFNKU0VyRk15b0NTekZ5cGNmUGxrSVQxRVlCMzZOR1JvUm1z?=
 =?utf-8?B?L3cwZldLSnRodXV1bVRXSng1b0oycUd6TmZUTHAzWk1DY1RiM0RpTGkyVVh4?=
 =?utf-8?B?WWxobWRiQ3YrQjl5Zm9BTW1SOUdpOUNQaks4T3MwRm9WNnBzWHV4bEdQcnl1?=
 =?utf-8?B?WVJRanRGd01XZ0hBSWZ0a3B6N1ZKUFhGNm5LKzc1NDIxaWFyOUtqSGdvaXhU?=
 =?utf-8?B?ZzJFbWduakVibkdNM2t2MG9rajVnSU9yY2E4NWVwazNpcGE3YTlweHJxSklm?=
 =?utf-8?B?U3hLMm5PU29NelhIYXZOdUFRcGljUHppTXNJS0c5QjUzNHhqQlF6SGdGbTM2?=
 =?utf-8?B?dHpoc2REWmtUNGRpTUJPbllGencvMWc3VVJqcDAwU2VUelYxRzlBaENLTUlP?=
 =?utf-8?B?T3E3RU1iZEFTeE9Wb08yVjZRYitzZzFYY0k3UCtWM0Q1TnhzNXBZNDNEOGtm?=
 =?utf-8?B?NmRSM1JibXVMMU5JaEQ1MGtDZWJTME5KemdYN1RXNWk3cEcxbXdMbHFTdHFY?=
 =?utf-8?B?QUd0Qjd1Z0M0STBnWlBIb29DelBQVi9OV1hBRTcraFpWMzRHWHpOd2lERkx0?=
 =?utf-8?B?OGJNOVc0ZGhvaENvcW9zNjJ5b0JrUzVqYS9nUkI2K3R1YjRCVEZaeXdWTVZU?=
 =?utf-8?B?UXBXem83MUxhVHh0MHFsaGdQdytSOERXcWNKYTFKR3dDSWtDTkZzMGI5U3hH?=
 =?utf-8?B?dnNsbUZVN3hyejBFb1BJU0lLQitKTUljc21UQkZDTmVNS3ZCbmlvR3FsV1hu?=
 =?utf-8?Q?Woe9kl+ucEnUi?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWtRN1Zkd21SVWNVWVRFdzZuUUFCMjBRVHhGR2RoTE5aSE5ZbFY2TVZ0bmhl?=
 =?utf-8?B?a1h3WTljQnBYK1pkTkNBMXlKZzFLaEhTMy9FL1hTZzQ5Rk9NUjlpcWM5TWtO?=
 =?utf-8?B?RGRrWTBxTHEvaDNsbUlNc1pRai95bGJrSWl5TERxOUhhbFdjcXkxSmp4Vlk5?=
 =?utf-8?B?b1NsemdDOW9pSit4aXlMbm56enZkUXJJWmZvYmhEaFNITmJWdEhKM2R6TTBm?=
 =?utf-8?B?WE0vZ0U1RDUzM1pyalNPaE1rQXpCcGtNUTNyNG1mRXBRYUZtNm9qRDNicURR?=
 =?utf-8?B?S01wU2NSZXBWNzk3RnhzN3p5blg3TVcwTHQwNGh3ckNJWEE4WTdQRUdvbFFx?=
 =?utf-8?B?Zi9wS2hZWVNzV3hyTTY5emhLZ1pFT2JtOWpxUUNNbDkzTHFqUE43NlJNVXNE?=
 =?utf-8?B?eUVOeitjS2NxRW1iSW8vbDI3OG5HaGtQZEtZaGc5OVkxWm5uMjA2MVZSMGF1?=
 =?utf-8?B?UlNjV2Y1dDRSU2YvQkIzeGJCUG4wY1hENkZGQlpFSFZ5STlhVWVUZHlYL29x?=
 =?utf-8?B?bE9FRG1OUFBVSm00T3RtN1dGSGttUkc2bFI1Ujg0OVJ1dy8xMmljMUdqVGRn?=
 =?utf-8?B?Z29xYXhCeEc4MTM4UGJ1YVVxaW5ibE55aTZmWGFqSkQxZVlZZm42UXduQkNn?=
 =?utf-8?B?dXFVL1MyRW5iMlViWWM1NEZJSGtZbG02S0xyZGdBUkY0eVVTdG5ZRC9TOVVK?=
 =?utf-8?B?TlIxY0QrMXpvYkRjSFNwenhUM3FnTkI4Ri9aT3dvWGRqVEJsS1ZVeElDQ1R2?=
 =?utf-8?B?aVJyaXIrd3hSanVnalZBQ0hQWS9XbFUwalR2SkhzWUR0cjZSa1FLTmYrVHJL?=
 =?utf-8?B?YWQ2V29aZnNBTzMzWEpCQVZILzdvamxRSFcvMHpuRDREZzNuUlhVYXpsSmFD?=
 =?utf-8?B?Tk5hdEFnc3FTL29NcVZqbStobkFZejExblBrNk9sNUNscWhGbDY5Rk5ad2tP?=
 =?utf-8?B?aDJHbGxuUlhCaUhjeEwwb0svMlRXeks4R3dQUDYybkp2UmxkU2lLVUpEVzJz?=
 =?utf-8?B?bXhZYUs2UnpMUGZHMEp2UFZNNnpCazdOajFWQkJ0bDNpWTZ0U0pGN2ZMTjV4?=
 =?utf-8?B?cGtQd2loVzBRTW9aczU1Yi8vZG5OTWpKRzk4Z3VIcmxpRDNDcVpuU2d2aGty?=
 =?utf-8?B?N05mQWFVN2NLK3I0OUdjTE1nZng1OTJ1SlQ5YjFsdlorUmhlV0FVdVM1ajFM?=
 =?utf-8?B?b3hoaGJQY0pCMGxudE5Bbno3alR6Sjc1UDhlbEJnR3MwdGtVRkV1RXNiR3l0?=
 =?utf-8?B?K1hVYmx6SWVqSld0dm9ha2ZCVVBIVDZ0cjVCM0N1OGhtMDhneGZmRkd0N1Fm?=
 =?utf-8?B?U01FdGJodUVRK3BhR3ByMXB3WUpVcVRNMEZUMDVJSFQ5NFVVdE43MzVLazFa?=
 =?utf-8?B?RzlNbmZpUFVYcmttWkxhSVNnNkFYRzRLckU1Z2NxdXNuTGthalFESVRkVUV3?=
 =?utf-8?B?UW92bWNEcDJneGtuUzMxbnIwdUFRREhkR09nMjFsMHp6SVprNlo1cGo1V1VN?=
 =?utf-8?B?V0Fqbk5MbkE0TkRtQVlJUkx5czJvKzVidEgrMTVmcnlNWFBMUVVQc1c4WW4x?=
 =?utf-8?B?OXF4Y2h4U0luRVl6Nlh5WE1iOEpMaE5WcDJrRUJmUEpmMlYyWFV0SDdoWkd0?=
 =?utf-8?B?bVB0UjFwWGUrRUY0MDAxb05TUnppYkhPcHY2YldSbVRNbVlLYmppOHJ2UEVr?=
 =?utf-8?B?Y29VL3RnaVZWYmdXSksrcU1VTWxVR2xaWk1HZlFxOXRuMHVZWXRvZmZqSnlF?=
 =?utf-8?B?bm1Ka2JSdlZRcTNlOTN5VE1RMEFHWGZQL21uZHNQczMzKzkremlQakIrUlhP?=
 =?utf-8?B?TVIwTTZyWDdrSXhkWnJnbkpZazVxZW9tRE82TkUrL2hlYVpESDRjWXRBNllz?=
 =?utf-8?B?TEhzNDJTa2pSQTJ3NUVpTUowUTlZeUtCWTZkbFprTVI3T1hlYk5EclBuR29h?=
 =?utf-8?B?NHJ1WmhsekRwUU90dERCMlFXZWdQQXF1VExxQmF6OEZGLzZwUHBtRXI2a3Vo?=
 =?utf-8?B?OHZOZFQvZ3g2TTZYdG82Z0NKSDhSSXJlNXZtU25BcTV2RnBpRHBjY2Y4eFBW?=
 =?utf-8?B?T3ZpWVUyQlRhZVdES2V6NnVTWWRwN0pET3U2N0pVK1NLeTZ2TXJ3YWl0cGo3?=
 =?utf-8?Q?D1yVnQ4QM+cqdm3VODqnPFkKc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ec83a66-7b95-457b-e0d2-08dd346d2894
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 07:29:19.6053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kqtcJKaaDkecPJm99+nvrq0OG3KBkBrUulCYTj9UtiIWqSUjOgQdRtpJuCK0cXi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168
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



On 1/6/25 10:20, Michal Simek wrote:
> The main reason for this change is that upstream QEMU has no multiboot
> register implemented that's why access to it fails which ends up in CI
> failure for our target.
> That's why in JTAG bootmode returns 0 which is correct behaviour because
> multiboot register is not used in this mode and value should be ignored and
> as a side effect it is also fixing CI/Qemu issue.
> 
> Also move versal_get_bootmode() to avoid function declaration.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/versal/board.c | 36 +++++++++++++++++++++---------------
>   1 file changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index d05220f96ffd..cff810e02ad8 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -36,8 +36,29 @@ static xilinx_desc versalpl = {
>   };
>   #endif
>   
> +static u8 versal_get_bootmode(void)
> +{
> +	u8 bootmode;
> +	u32 reg = 0;
> +
> +	reg = readl(&crp_base->boot_mode_usr);
> +
> +	if (reg >> BOOT_MODE_ALT_SHIFT)
> +		reg >>= BOOT_MODE_ALT_SHIFT;
> +
> +	bootmode = reg & BOOT_MODES_MASK;
> +
> +	return bootmode;
> +}
> +
>   static u32 versal_multi_boot(void)
>   {
> +	u8 bootmode = versal_get_bootmode();
> +
> +	/* Mostly workaround for QEMU CI pipeline */
> +	if (bootmode == JTAG_MODE)
> +		return 0;
> +
>   	return readl(0xF1110004);
>   }
>   
> @@ -120,21 +141,6 @@ unsigned long do_go_exec(ulong (*entry)(int, char * const []), int argc,
>   	return ret;
>   }
>   
> -static u8 versal_get_bootmode(void)
> -{
> -	u8 bootmode;
> -	u32 reg = 0;
> -
> -	reg = readl(&crp_base->boot_mode_usr);
> -
> -	if (reg >> BOOT_MODE_ALT_SHIFT)
> -		reg >>= BOOT_MODE_ALT_SHIFT;
> -
> -	bootmode = reg & BOOT_MODES_MASK;
> -
> -	return bootmode;
> -}
> -
>   static int boot_targets_setup(void)
>   {
>   	u8 bootmode;

Applied.
M

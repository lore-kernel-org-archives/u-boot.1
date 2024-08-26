Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E91C5321D
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 09:52:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A41A9889C9;
	Mon, 26 Aug 2024 11:52:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BKVS8o/9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACCED88981; Mon, 26 Aug 2024 11:52:46 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C37A87B77
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 11:52:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iRKJbR5uMSI71FepAlxAn79WPPOBEOlLF2eXQ1JPR8cd5VM0H5+CIcKFvfSV9HpxH1DJ6NYEpdJvHBF7fTx5ukuOUpv4Geh3QSUP//w6KP0EjWOOc9+Y3OJqxYhLipMw0GisuJlpKt3auYTmGhiisgjrHjzw4GhIamyHh/5X1LX7nAh1i4x27V5SXo3t3Epy1amKo/9sxGaKMWsDrUCXLJbksZUQpp386/VbkBgeEI57OjHLjlgb3uguaYc4kCJaDSv2Bs0eYOHNyKKyNbW33kx8ULMRByTItyQlGmVMNlmC9tRoL68OqZsSGuPDB0n9AKeDCWnSJpmCCB3u0g2ryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItveR3BNb58UYygMvyDliqbfA/l9fZ3Wq9GE/UFhqtc=;
 b=jHnGljOeVuiNe+6grID/Lrt6I/dMeKFfCzroUEdaL6SgyfnthQ29QGw49uH9SN3FHF4H9uMwSitpXc0rhVcKj2+8An7W1FS8FwGGiqG1Bg2Qrg4zRZxvDlNgZ2Sa9MbfMTE70jB3zyd3NCoAZ5Uirnms/AOQPJB7dUqztDa03rgsOMWv3YaLFwJ80dhJtDj7BUHHHnPntZRUAC4mfZciT9JcvqhjKxKRDA1Zib3RjDnTVkk0w1G9HeAS65cw2PgS17h5WbDZIf1NswRIP+5HlPO9Ev3LWK9Sy1lU2B2t7gomMnPloQWdp3VK92ssGtMXPm2XiEAlCSz8LAC+jbNZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItveR3BNb58UYygMvyDliqbfA/l9fZ3Wq9GE/UFhqtc=;
 b=BKVS8o/9NuIIBwXyaGstoXPcT4PYRFsrQ1ec+M6TpTTjW3T0I5I3eMziQRVFE1TcX8XioPs3mparNLP6yLOJ1GE8CIKfqsSbI6L6oh2zNIXrzKRNocfYcRG4d/7S5LyMJ31DuIrDAHtkJomrknhOb2799t4Vb+cIrru2dYcwE/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB8204.namprd12.prod.outlook.com (2603:10b6:8:e1::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Mon, 26 Aug 2024 09:52:41 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 09:52:41 +0000
Message-ID: <ce1ebb18-0482-483a-ac4c-2250fde59f3a@amd.com>
Date: Mon, 26 Aug 2024 11:52:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] sysinfo: Add sysinfo driver and data structure for
 SMBIOS
To: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen
 <tuomas.tynkkynen@iki.fi>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Alexander Gendin
 <agendin@matrox.com>, Wan Yee Lau <wan.yee.lau@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Max Krummenacher <max.krummenacher@toradex.com>,
 Sean Anderson <seanga2@gmail.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Peter Robinson <pbrobinson@gmail.com>
References: <20240816154658.1866186-1-raymond.mao@linaro.org>
 <20240816154658.1866186-3-raymond.mao@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240816154658.1866186-3-raymond.mao@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0015.eurprd08.prod.outlook.com
 (2603:10a6:803:104::28) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB8204:EE_
X-MS-Office365-Filtering-Correlation-Id: 79b9e9a5-d5ee-444f-fc18-08dcc5b4d371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFQvWDc2RkdUUlJrQllQd0w2Y2Z0emhyWnRQbUJweUF2eUNJdS9HKzZ1elZO?=
 =?utf-8?B?aTVMMGpKVnMvanZLYkVGUTBVTDU1enQ4UW9RbHV3STBZUk02d3dhNkp3d2NQ?=
 =?utf-8?B?M0prRWw3N0ZrTEYxdS9VWTFWd242K00zZSt3Z3NlZUpXWjNkN1NkdlgzVGQx?=
 =?utf-8?B?aWxVUHVKOUs3ZkZESjQ5K1FaOGExNmtGMjRzWjgydHVxZmloZThZSTdaQnNK?=
 =?utf-8?B?Sk5IWlZ2S3RFNmwyLzFVU3lVRUszYnNWOGd1T3dZNDlibnYyMkRMbGFQdHJT?=
 =?utf-8?B?NllYSGMrUFdVVGs4U0NlckNYVkt6dDJOYnlkelNrdVQvT1cyK2ZFZVVQcHRt?=
 =?utf-8?B?R1I5ZnA1R1diWW0ydDBjMmh3dm43YnYwNThkcUczMHlHa05vekFRVUJsZTht?=
 =?utf-8?B?Q1Y5RVR4Z0VvZEMraWNYbHlTZnI5dlNtY0RNSWxXVWNrL2YvOWRsdGdrRlR4?=
 =?utf-8?B?MGg5eVI4dkVtTEFLK2dncnNYd2phaEMxTHR0Yk8wRmdDN21GbmFva3U3OE9O?=
 =?utf-8?B?bkdYZmd3ZDRoNnJyekFmc3dxYlNnS29hNWV1enI4aTlsemJ4cmpndkdoZ1V2?=
 =?utf-8?B?SG03OUxEcDk1OGJmVWU0cEUvQnZtTkxBRm1BVzRZVmlmRXNKTk5objNSQTVV?=
 =?utf-8?B?aGMvYkg5OVdXNEVuUU0wR2d5MkxDZXRlZ29LR0czcE5NUzd0aUJ3VE1Qa2xU?=
 =?utf-8?B?TXk0SUw2c2daKzg0eDYxOVJXQmI2S2Y3VXJlMmgyUEhvR21RNzBvS3FwUGl5?=
 =?utf-8?B?WmQrRlF4bnorNzBuZEduVzRHYkMwTmhvTVVTbFd6SkdFUlZTYm9rQnA1US9U?=
 =?utf-8?B?YzQyaUVkdHMzQy9CNGdGRWNHbHM3SEhQQnRzTTlOYzBKYU1FaldwSGtzU25p?=
 =?utf-8?B?VC81NjhaR2dCeFVPWmhxcVpjMVRUbHpxckNTVUx5K1ZJUisxRkdubEt2SFk1?=
 =?utf-8?B?MzBYYkFhMDA4MWdmVUZPUTV3TmE1T0t1NFFLT2ppVExMbFhVNERwQjNjZUxv?=
 =?utf-8?B?T0NYdkhQMWNPNjdsaHd6ekRkVjRKMU9xOGxLM1RoRVhBaVQyNXFtZy9MWjE1?=
 =?utf-8?B?Y2lFbkpMV2ZwQlZESnZqZ0JBSmdLNFp3dERiSURBMDBJclVSRmJaUndLb3RT?=
 =?utf-8?B?ZjJYZnlra0lrNElhU3Q2dE9tVWlKdnN2dTVaNjVIWjQ3VGl4bkpOcjZrMm4r?=
 =?utf-8?B?VFU3Yk4yMlI5MGQ4NlIxVmhGU3A0THBuNThidllkTWZicGEwaWN1ckVLQ0dr?=
 =?utf-8?B?MXBsaUJPMlJBM0V4VU51R3RUdE1aeTZCWVgydkpPN1R5TXBXQU4rRjd4Y29l?=
 =?utf-8?B?WmI3ZmYzNlBZU0duNi9hZ0lmQ1VTbUduNm9aNXlndVpLVzd0KzRmclZ1aUQ5?=
 =?utf-8?B?UklBck5xOTdnYi9OcGFFVWF5Q3VYSkdZK3JpbTdOWDhLM1p3QWFxbEVJeGlX?=
 =?utf-8?B?MWZEdVczVHhVN2RrRk5aWnFEVGRlemUvWU11RzNxb2tVSVNsVVBPYnViOFd3?=
 =?utf-8?B?alB1MDUyOVlBNDZhVzVQR1lNdTY1U1RQbXVpZS9tQjRyTzBvTXl0VEF5cFQr?=
 =?utf-8?B?VmRxT2NpT2pLK2sxNTdtZ1grUzZJQWJEd1pxY1gram95cHF3blpDdHdjV01S?=
 =?utf-8?B?S1BMSEhjaFFoRk5rZzNKR2VTZG1veEdybHlEcGd2eGVMbVFLOE5ScHZra1JH?=
 =?utf-8?B?WXgvQmxRYldKTnVGTnZYTTdWalk2ZzlZQ0ZVY3llWVhKSVo5ZDBpeUlPbkMw?=
 =?utf-8?B?NnM4L2p1b0V4amZVMkphUzJ0ODNsWlk5V1R4L3FqeHFFRlB1djcwLytlTFho?=
 =?utf-8?B?NkdjeUk5VVZCNmJDUXovZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGV6S0xBMGFrenVJSG9wVGIyR1BtcWYwK0pMSVBkckw4V1JWdmlMZWJDYjM1?=
 =?utf-8?B?blFLdis0c01VQ3lzQjByNTJyRS9zaGFQbWdOSTVRVTZXZEdOVWRlK3A5Uyt5?=
 =?utf-8?B?L0lmb290WTlqZ1NldnpnVzVIdkgzSUhkdlI0ZzVWaEVicVA4N2NMSnZvVG1S?=
 =?utf-8?B?dVRqejdlQ1MxeHMwLytvdWpoR0V2UkdzYWlWSjRKK3BoVW5iTDJsc0NxR3RQ?=
 =?utf-8?B?K0tXNXI2ek01alhEQWpyVlZjV2VINTJhc3pYWnNIVzE3WWJYdS9oV2ZMaEli?=
 =?utf-8?B?M3FTRUIxc3NaS0xOcFhiSUlSaFg4RXNlTVczemdoZWVOMktLWEVPQ2FRQUR1?=
 =?utf-8?B?cnIvcENwY1hIZCtBVzQybmhiZ1J1azlWYWVYbzhhQVdaWmhKSFpFTTY4NTRY?=
 =?utf-8?B?Z3EyRnBGUUl4bjhKc3dNTWpiTU5vVU03V21Ea21PekdLMDI4clRDS2VUTFNV?=
 =?utf-8?B?RHRKeU5pNUxqVDF0aXdYOGEySUExMFZtTXNxWmQ3Wm5lL3dCWFdpVGV3RDda?=
 =?utf-8?B?KzEwV3NSSytUcmxLRytLMHZmbkwwZ3VwcHAzTDRGbm1FYmFNbWQ3VWUrZUh1?=
 =?utf-8?B?RzBUcHh0ZFUrSWQ1aVM0eXJwalNVQkJTc0tRc2lJUWdnMWhiT0h3ZHp3Vzg5?=
 =?utf-8?B?NlVnTEJkTVBSMDIyRFpwa1dnZUNLRGltZHBLRzkyZytwTjhNeUY3QWFicmg0?=
 =?utf-8?B?M2ZkdEVHeHcvcHZncXVaTGxOcUpVcEtBZU5Za215NjdESzMrQzdMa2wzem0z?=
 =?utf-8?B?NGNONmU3a1lpR2NjUkFiMEZjSDh3cHBnZFRGSGx1NXNRU2s3cUw2dnBOb0xL?=
 =?utf-8?B?T3RDSVBYZTcxVjdoMFYxeWJMdkFCSGtpNnVwK3Y3QzJnd2RIUjMzQThRTDZM?=
 =?utf-8?B?RE1wdE5DTStEK29zRkNUcVRDMm12a0g3bVVmaTY1ZW9vbFNqZjlYZXRVVjlq?=
 =?utf-8?B?ckg5R3QzMkdaSndVR3VJaFJPUlc4MTN1T2x6R3NKc0ZJVUJSOVk2eERQdW9Z?=
 =?utf-8?B?TEJQa0FxbFRNVTBvUVpna2VsUVI3T0QwRUNUU2llcHNMKzU0MGg2TVNsNmxm?=
 =?utf-8?B?cU9NNFRLTWIxZlZaUXpXdWk3M2dZb3BMMjRmZXVwbUQyYVAwKy9zVC90SHda?=
 =?utf-8?B?WlFaNGp4c2xNMG1yc2VkVlNrZGtBRlRsY2FqRG9SWkxEMXhweHIrVy9wRC9T?=
 =?utf-8?B?a3RDMmNIZkgvbDU3QkM1ZzFXRnNQUkJnWHBPSXJWeFFLb09hR3V1SDNLV1NN?=
 =?utf-8?B?a2dsNGU0ZHdFbGxuTGdPT0NEV1RmdXBUcW5SZ2dYNHJtejViS0tZWXB0YzM4?=
 =?utf-8?B?MXE0bkZ0Z2M5SDZyWE5RUEdSMEpCdU5yQVZXYmEwN0o2RUEwYVFIM0VlSUlT?=
 =?utf-8?B?dHhUUjZTRm5JRnE5UElkZ1RlOWErZit4QWZmaXpYZzRvRTlPc2ZzQUxsMGs4?=
 =?utf-8?B?M2U2VGpIY2cxb1o5K0pKSVg5Vnd4OHh6VG9Vcmxua3dablF6OGZ6VmxwMnZE?=
 =?utf-8?B?MHV3UUxzNUFWL1ZYbmFWbWhwSExwQmNwRXRVTTVQVU8xWmk5TktTSDc5QUIy?=
 =?utf-8?B?aEZJcTNqV3pSZDBDL3pFSFJRb0xQbmtkWTk5WmpCelJaVWgwYXVqdGM4NExn?=
 =?utf-8?B?Ti8zQ2NmVmN6ZVdxMG5MeTJVVFhhTllrdlFZd3lZY2x5N00zbHJPeHhGOTB3?=
 =?utf-8?B?ZGVxT3Y3bHZPR0ttVFBiV2Y5NUNrbWZGOUI5OHVvbEdDS0lwZFFHSTlvVm5w?=
 =?utf-8?B?b0s4VVZvb2NJbDhLR2xUTCtRTkpNWVVva05ENEtoZ1F1STJMQTVTSklPMmVh?=
 =?utf-8?B?cFIzTkVKMmsvYTJCQ3FMT0NiU0NkNmE4c01waUV1ZS9YcTRPZ0c4TzJ1ejMz?=
 =?utf-8?B?QmN0Q3paSjZoWjA2VkR1VStmZmhxR3RFN0pCOTc5T2R6ODB4ZzBSVEI0MU5H?=
 =?utf-8?B?dE9rZjZlcUMwR3B5T1IwTkt1dVlFZHBXMlE4RHFIWmJ3YkUycXFVQlJsbGlU?=
 =?utf-8?B?WmhTZXBWOUR3cUNyQlZFNkRWeG5SUStFa1doeFVYampjY0JMbHJlMTIxK0N5?=
 =?utf-8?B?R010T2ZlNzFhODIwbzVCNkpNS09RSHlyS1RYUTFqVXhDK1pUSG5MNTY0d01u?=
 =?utf-8?Q?G1UNcZDnWsfW2yZZ+FknPHsKN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79b9e9a5-d5ee-444f-fc18-08dcc5b4d371
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 09:52:41.4365 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hG9TphpaL88IoVKIJhjB7nXc8Qd8Tz7AM3WJFZSN/kKlwkGU9Bg6wGjhHZ8Fez1T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8204
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



On 8/16/24 17:46, Raymond Mao wrote:
> Add sysinfo interface and definitions to support SMBIOS type 0 to
> type 4.
> 
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>   drivers/sysinfo/Makefile      |   1 +
>   drivers/sysinfo/smbios_plat.c | 270 ++++++++++++++++++++++++++++++++++
>   drivers/sysinfo/smbios_plat.h | 104 +++++++++++++
>   include/smbios.h              |  12 ++
>   include/sysinfo.h             |  58 +++++++-
>   lib/Makefile                  |   2 +
>   6 files changed, 446 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/sysinfo/smbios_plat.c
>   create mode 100644 drivers/sysinfo/smbios_plat.h
> 
> diff --git a/drivers/sysinfo/Makefile b/drivers/sysinfo/Makefile
> index 680dde77fe8..3e478f87c23 100644
> --- a/drivers/sysinfo/Makefile
> +++ b/drivers/sysinfo/Makefile
> @@ -8,3 +8,4 @@ obj-$(CONFIG_SYSINFO_GPIO) += gpio.o
>   obj-$(CONFIG_SYSINFO_RCAR3) += rcar3.o
>   obj-$(CONFIG_SYSINFO_SANDBOX) += sandbox.o
>   obj-$(CONFIG_SYSINFO_SMBIOS) += smbios.o
> +obj-$(CONFIG_SYSINFO_SMBIOS) += smbios_plat.o

One more thing. Does it make sense to have it under the same Kconfig entry?
I think separate symbol would make more sense and can be enabled but default but 
there should be an option to disable it and replaced by own implementation or 
use existing one.

Thanks,
Michal

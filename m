Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0140DF9B5F5
	for <u-boot@archiver.kernel.org>; Wed, 22 Apr 2026 09:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4C388421D;
	Wed, 22 Apr 2026 11:52:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="jY7zU9VR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A96983936; Wed, 22 Apr 2026 11:52:13 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C568421D
 for <u-boot@lists.denx.de>; Wed, 22 Apr 2026 11:52:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v4rK8ZfIBZFyDGPqjPlp2FQncJbAsqufsfDQBKsovnWm3QjJvj3SQjWwmXuJyzWLTlYdMxnt+JKtL9OGUni1NRbOoZeO2IhnfhkCPLudzGYnFnLvDoqVF8724FPAYj+1hyiKFEcFf8xGaDKY73QO1A8P5nzKWh/0LPYL7wFXDMnNRDIK+ATo4are2jLxRxp1YcRmzMCZtXBMh4HTJtZ6rxV5YDD9zP78FS5DukQt0Ve5kISPyoDgETFbc4qdk+ZLAGZwDcdpkRE0aIpJ28f3B8rWC/yU+g7CLwGUNpSc/urndX9Y00u68EVVBYihyx+FmDjMzf7SGUoc20vwVjmkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lhb+p58SQkeCFEueiu0xdWEnkrFItC0UZPfBhV/mcr8=;
 b=ufdwTR+A+eK8/T3NwWqXgudBGMX6dwKiTcRl/Nz4DA2DTo0BGuyZGJ4WDGN3o4mI9ADnG/LzAMfk5ZgtGdqKl4fTfNJyy8HDwnjZm6RKq9Id3CvOoFpL2uonuZNMNF1Hv7biZ0Xc78nW5leQVQ621gwjE2SzwWUWXeRBQ5m4Jc6C4DY4LFAh07yn9tP0M6/BFE5KNOsLxuSYGWco3w9+FsXKWk+BV16t7Vhtk2ctGF+DKueELEQseSGxvhgcaDucV75c/qDWyb8EGc99NpRJ+LjkUarJ0Vp9O5MKlxDRQbYsZsks3YjY+bl2gVhQkuRkYGI0WaZCL3uO/TN4YdWuAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lhb+p58SQkeCFEueiu0xdWEnkrFItC0UZPfBhV/mcr8=;
 b=jY7zU9VRirOXjhxWaHzABx4uLkYN0BTBmVK1K2HiXKHOuXgAMS3ORAfXa7bT2hrRIFWCljUPEZo7OMqHbAtdBk8Ipu8yLCDOP+hKu4nxg2PXKGqvhv56uMCSiJSgbcyW+dGIUAFbnHlCNHf4mgVDCC/HECb4IDVq5+sq/D19s1kSvKnMpLiaexRu7tkg9tRaq3OPBPG9ONSIhlxdyl8DiKZ1yKGTBNNeXdtGRvICZtCMTbOsyT5O6wXimo3oF+VQLeWlFmRkgqk2Sa/64roTK9lwfTstaFSwEuNVXdcf8WX0Y1fHL1jJyF1Idv7wAZ2Sb+H2u0UBrjOkIJu2vXzUIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB7842.namprd03.prod.outlook.com (2603:10b6:303:26d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Wed, 22 Apr
 2026 09:52:05 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 09:52:05 +0000
Message-ID: <6a1adf7e-e97d-44e5-8fc2-28fa8e4a9ba0@altera.com>
Date: Wed, 22 Apr 2026 17:51:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/8] arch: arm: dts: n5x : Switch to using upstream
 Linux DT config
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260318031708.9418-1-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260318031708.9418-1-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: c22ca4cb-5a86-465d-a0df-08dea054cf6d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: CF8kJ6BNrfLNlbWPmWpr4k+i1bug4wMMdzEBeB2E2QfT9YhQ2AHGpwyg3kDKiYYGv/gjewkVxYrAj0iTgJSMZcfiZt0d1WPiD+Pg/INCGia+rmihROixK0uZ0LG1hmfNlmIikUz4cIeTbEnwAH/tqE3btATnS5mfFpPFe50iBiWEYK7hgPA0eLK6ttwW9xdA/ZWevqskozbk/IBI0Mw6TiXQLgqkEgi8Ai8S7waYTXVw0pbJufAxV/xEdG606XIfgy19slCl4SbGBiO+Bd+aA3rB8U6CzXUUqUMIY5J6Ykjrs4/JzFXvSY5KaN08+ukdScsLur2QebZACyKauN9GC6vF8nRuYWP8yVna4avdv91NexoT3hEEjfBrexd0/GtXf6igTpyHINxiUE5AxhdZCbgCaKPTSzmbePhmdXCfULShAOyKXxmTrTxvkIN0oF6tk3gsFpey+hjysyPFU2HXtyEG/ZXqw7p64u8irrCixqsaw5TTZjw2TBQ89UuQzXcW0lJCP3aonPLVH7NOnW9sQwQqLzliFp0zP+uc5C1ulLSbTMzDfUMDjx41EVswUSDm9SiNeHuj+wtncWv+yW3eyVpZAXaO+o7UTFHqkHhClaxe4r86p7jPwVNo3hwF/TsFOYPvYayq3HL/RU9RgmrIq5njFxII4mhy6pId6yZuXH9bdgnz5bTEZQaZ5eD4sdgf2ASRED4HoG7bTX8gtWWLCaZQpTxE2p0ZxVoUz8/vcHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0ttOEl6MldoMFo1aXR4bGZOMG9XaFluNHY0UFZtNi8rd1duZU5HbzExbkxG?=
 =?utf-8?B?anJtVE9vQUMvRGFuVkV0Ylk3VWpvSmV1cG82ck1mWHduMmlGTkhHaVk4cFR4?=
 =?utf-8?B?eWVtUEtNS093ajluOE1TV3RWYU5nYWpBY2MyM3owNWc3dk5DbkdXNWpvbXhk?=
 =?utf-8?B?ZVpLeWVUU0w4Znp4eDA2RmRTa1B6YUhWMGV1bDZXUFVPN0lzOTBab3o2RHpp?=
 =?utf-8?B?M0F3OW9DY0pQNzBhdlFNS25RNGtsZDdickdXRG5mRkpPdDg2QVhnUVhJTVdl?=
 =?utf-8?B?WlZ4ZTd2ckgwb0dueTA2OTZhUndkR3lJN08yVldGdEVRY0wydDRmRlB6cVBl?=
 =?utf-8?B?NGFGNklUdDVjNVAwL2QyMTA0eU9zUXluR0IrYjI3eVZ0WlpTK2o1bTVraXJC?=
 =?utf-8?B?ckpQSmFNKzVCb0ZEdGVlMEVtcGRJY1EzeHFUVnpNSHNRL1laVzFMQ1liWVFW?=
 =?utf-8?B?YXBJNm5DcWdpU1FUVkpWbWt0NzdGdEd3ZEJEZXdydS9OZE1ha3ZBWGpCcUdB?=
 =?utf-8?B?MnN4L08zSUJtVS81U1g3WTlyRVZHVktQaGs2cEFNcGdXTG9MUHhiMmludm01?=
 =?utf-8?B?eldxOVdXS3lyOFJ0VXBTWFpzVmlxdE9DQml2eEJQdzF1NURrc3ZlVU80Ylg2?=
 =?utf-8?B?aS9QRFN5bDZrUnlwcDFwU3loNFdtM1pXK0YxNU5ncTg4SzdkOFlRYnhEUzU5?=
 =?utf-8?B?ZVFRNmVXWERicEZXWlRBalhBZTZyN1REa2lQam42WkcrOHRRVXRWdHBCeEdu?=
 =?utf-8?B?QWU0VnNWdHhOUFUrdHZJQmZtSDNZbjNMMnhpVVU4NUkreS9vQ1RSc2JBUUgx?=
 =?utf-8?B?SVY4R0gwc2VLSWg2QTNyTWs5TUpxWS80b05lTWVMNnJscE1BYzJscHY1WHpV?=
 =?utf-8?B?eUE4YkRlR2hQcWJrMlJiOG5vRWxLcXdKNlFISXVwUm11SS9yaUROOGhCM3Za?=
 =?utf-8?B?THhLSE04d1gwdU1KcUVFY1MycmFaS2t0bkNLUU5ma1kyZUF2NmdXTWhyOFU5?=
 =?utf-8?B?QTdOOHF6UkxvbnFnNDY1a0wzTHRLVTFJcCt3QTVPNHBVMElhKzh0bURsR2dn?=
 =?utf-8?B?dmJzdllsazNXQVliMGNKL2pwTHdBRGN0YjR1NXVEcTVtY2g4L1hrckN2emNy?=
 =?utf-8?B?eW1mL0RCa3RHKzFsaGZHR1lkUlM5LzRYb2EvUytHaGNielBOQTFQV2NscGVN?=
 =?utf-8?B?cno4b1dreDVGMzJ3UlJ5OHpQZjZtUFdiTnZLY0c0L1JrL3RwRHp5aFVvbC93?=
 =?utf-8?B?cVRERTlZZjN1c202aHg4V3BGdTRZQVVZY21YbG1BMzAxMDRxOTZBd1BuV1A3?=
 =?utf-8?B?ZURBZ2tpakZJc1lDSndkQ1Rpc2RIM3o5Z29uQk9CWHRGcWkvZXRLbFlrd09t?=
 =?utf-8?B?WjdTbDlGVU52WlFNY2E3RUN3dlpHSkh1MHZlOE9vZWlkckN3SURKQTdYVUlz?=
 =?utf-8?B?bW9ka3hGcjlNNlpXOEpWa0w0S1Noeis5S0JGODl6cFMrMVRRL3pWaksvS25C?=
 =?utf-8?B?NklUWFRUOGlCN1RMbXBrTEp6SU9pNWhDQUJhdTcweXNFTmxodytNQ0NQeUlR?=
 =?utf-8?B?eHlvSDhETnRRNm1ZbHV6V3VSNmtlZnl4Ti9Xbm9qMXFLNWFDVW5KWUpTSThn?=
 =?utf-8?B?U0JXejZ0dXhUVGRUTnBqUVdCa085V1NDZHpyYTdnMTBnUmJ1c3VMQXNYa1U4?=
 =?utf-8?B?bUhQR1h3VUhCcDdaaEpLbjY4elVwSjdmZnphcVl6Q3lLYVdzUVY0RlBWWjRI?=
 =?utf-8?B?QklDOFBCNnQ3SkdrMENjOVpxVjFXNU54bEs0Ylp1dFdnTlh2bm5vSzZOTW02?=
 =?utf-8?B?d0pRSE8yY09EZ0FqbHNWalU1VnBva3JMZ1RsYXBOTWxXcXFDOUdtcnpiTzFo?=
 =?utf-8?B?S1hFaWs1Y29YTjVhNi9FQmpoaXJOM0F0K0ZrVVhHeUp2YU9KTFZOQ1ltUUdR?=
 =?utf-8?B?SDBmQkpjV2VBUW85NFEvblJOUVhNWTY0WUprSkNacVk4RlZzSGVCVHVUZ0Ru?=
 =?utf-8?B?QkRXcHBXbDNGT0NTbFczU0FEV0xSbGNhWVlYaUFDUU1CM2g3c214VlNiVENh?=
 =?utf-8?B?TkcweEdyT29jL3dadnAxYVJGRTNEVnRSWjYxN2ozT1UyL01ReXdmdWZkejlZ?=
 =?utf-8?B?VDYzKzlwRWgrNUxWeDNaNjZRYWFTcmtOMGZYREFNOFJ2RGhEZjk3ejNsMTZL?=
 =?utf-8?B?YVAzMGh1SFc3eG9JZWQvVEFXeVhKQU11SnhXYkc5ckhld2QrZjhHbEZ5MGl5?=
 =?utf-8?B?eWc5R0dQdVRYaWNHS2g0N2VwWXVlL3JaTlRXODEwNWY2bEZuR0Q5VHhuQWcz?=
 =?utf-8?B?NHlRcWZUcU5LVm1xVUlUMi9ERk5Ub0k5ZUl5NGtVUnBtZ2RZdkl2eXYrbUFN?=
 =?utf-8?Q?+l/WjIECZ1FBG7ys=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22ca4cb-5a86-465d-a0df-08dea054cf6d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 09:52:05.5608 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TBqiTpltIsYdOwE4aDsvCXt2XYs6Fj09k1HFssyTa0V0Ie6i+KA6imCxbDNBqK0hpz/tnfprjt9GPoqK90E9rYJyhJT/1tJtJLbYz/Fhidc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7842
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

Hi Lok,

There is an extra space before the colon: n5x : should be n5x: at Subject

Best regards,

Tien Fong



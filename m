Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DDEC71135
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 07:20:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36C2781E18;
	Mon, 16 Jun 2025 09:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EX23O5cJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2268E82063; Mon, 16 Jun 2025 09:20:45 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E85CA81E06
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:20:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iykQIo8H5aBGFCi13LsYaXbpQ73ZXtdPCwkaHdWQHNymngsFRxHD+e6DjD1jt0q5p2PNgYtHU7XrXqdm1v2sie8SOXfyi+BAZEJSPaAKr7n604rNHYzsAnvpMoxgF454sX976tt7oyxk1muvINlXns4OhCkzxC9LoN855scVpuhuf7JIZWVdX+N+rFgSDAMbAU0htlTpEjCGo3XTxQylA7/RXr5bF9O2bYfb7CoPnja6fl6wggZcXtSrkpEQ80yoGX+c1AJvFy1c+HIARDoSJuL/mmHgf2wsFC7dd5uOn1lGBfq/WS8zqV3z6+3vMsBaBEm1WoWYhiOHiw6jyII9CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3F6PPy/0n+kF2LPnmu1vUt3HfdfXsODSYVp+oMamGw=;
 b=XuFtpGvWJ6zSQMqUMR1LkWrBJzjgZs3geW3PJ0zpSaQE3saenclKCQUHP0CVSJuZg08tCPUWqR9ab6SG2v9iRZ0OvucJxUad0HI0AsshUQ6UpiXk1+T46lWJn/y2MClw3O/Xd1reKM06300caOaYh2C6BwbcdcoVqds9+c7Immd3xFeD7OCU1BIgdYq84f/OLJEmRuwB3B/Wq/0dBFuZ8kh9NC8MfPT7mVVqiHaLeYWHdaEi/QDqRWFJfLl0MHH41uVfM/ark7VnwIHxxRKV8Whm8TcV6qp17LBE0o1CURCfFbRm3RNh85ix6lZYMsP9bfxJqaTqQD6HiCKzmz4Kwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3F6PPy/0n+kF2LPnmu1vUt3HfdfXsODSYVp+oMamGw=;
 b=EX23O5cJuq7NF00uEweDfVsBZmNgP/HayGGi8pfMmntfoufd8rm0GQCMYPUPXpnusPMLMmzjhx/IO3EuzR0calf+p1aV26HUEJ366POeE0xvSdpIAaf0myWCkbCPR2mfC7xFjUKYXVrgXjHJIF7hSWn4yWeCLGjNzOcR9qv+TBY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB8195.namprd12.prod.outlook.com (2603:10b6:930:77::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 07:20:40 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 07:20:40 +0000
Message-ID: <54db9dbb-b415-42aa-9c98-cfe528770d9f@amd.com>
Date: Mon, 16 Jun 2025 09:20:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: versal: Fix clock driver dependency
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Sean Anderson <seanga2@gmail.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Yao Zi <ziyao@disroot.org>
References: <bd18a4ce3e65411bb956636d4a2ef4b5fbe8b9e1.1749104235.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <bd18a4ce3e65411bb956636d4a2ef4b5fbe8b9e1.1749104235.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0312.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 5414260e-5e16-4a58-4b38-08ddaca64c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVdIVFpqUUlPbVl4aG5SSGV2a2ZsSnpzNzcyZ0tET2lyeTdPeG1nblpWNFNG?=
 =?utf-8?B?Y2k5OHJGcUFjUWx1WWU1aVFJdjhuOWtxMUl2K0lCNnFVQXR1eUgvNnR1U0wy?=
 =?utf-8?B?R0U4dEVmMkUrUTI5dm56V2NWcFpLcm5RQjEwUzFmK2lQclRxN1lDVmV1aWxk?=
 =?utf-8?B?MHdqNUl0djkyT01OcTNzclpUcHVLdnNxY2lkYlZoL2d4NEZjSlVTbkswUWZQ?=
 =?utf-8?B?RDljQTB3ejhrUks2Si9rSHUwc09CNjA1dWNmNEFlUmlsWEdlc2lHUlJVZERu?=
 =?utf-8?B?aGh5cFVDUGRyUG44QmxNUlVjNDFLT2k0WmozRENlMGcvQVYvOVBOL1BYTnpW?=
 =?utf-8?B?LzQ0TENFeGNyZTBqQkJwWWVoQnIraEEyVzZZUkk1eVNheGZMQkNFUHA4ZjNE?=
 =?utf-8?B?V1UraXN0U3RqUFBhNVRwcG5zbSsxVHl4YWhKazZsSGFReEZhWEd3M2l3NUsz?=
 =?utf-8?B?OU5HMUQwSnVpMXZrS3FvNjhmay8xT1hUNVNvMmZ2d0lqTXJHSVFXSkg4NkhP?=
 =?utf-8?B?bHVpUFB2allpcHFvWFp4Z2ZJbkpsZmJPM3JQOU81KzlnOHlwVjgxc2lSRmpC?=
 =?utf-8?B?aDcveTNFamMrSjExS1IyLzJrNWJFYnlFRUJ0NmpJM1JEZHVqN3k0ZzJlVGRP?=
 =?utf-8?B?Zityc3ZScVhoWEY5QmlZanF1T1VHdnpCRytXUWxwOEdBa1ZrYTdOM1VaUjd1?=
 =?utf-8?B?QS9KTjZzRzlTdTZCVlhpNGhLeFY1TUpFOVh6SjB4T210R0FISXB1TXNrVkF5?=
 =?utf-8?B?NmpHOUJqRXBNd214TEJIRE0rcktMbGVtRUwrdDg2bmFxTlZtU2hLOXpSVFdH?=
 =?utf-8?B?V1ppcEhpRmVhbWxQTmptYW9zeHRrbmdkRjUvbjRrUG5nY3VBZ0ZZNktiMGVE?=
 =?utf-8?B?MVU4elYyelRDNlY4Ym81TTNMTlNZa3ZLKzdIRzM1NDd3Y0czVElDU2NXTDNQ?=
 =?utf-8?B?YkVTL2NKZzhwU2xZZmFVbnhqRXNBcTE4Y09oM2IzRktDY2U2UGlUQVJzZkpo?=
 =?utf-8?B?cEpHNk5xWEhMbm9TWEJCdlBtSXBPMkVYMWlPSGtWd25nN2w3NW1sbUlsMnBj?=
 =?utf-8?B?SVVFQU9mL09IUTdGdVZUVWdXL3dncEQ1bFh6WnNONFBVZllIUWtKbVRuZFhP?=
 =?utf-8?B?b004RTZ0bG9sN3ZIQW5hLzlLM3VCM1M0VUo3MWh1ZFUyTHM3a2VpeHcvYUFP?=
 =?utf-8?B?WU9aankyYytJTm9lOWkxeEt2VVpPa1owOTJYNWhkRVRQdk5ialZsSVlIbDBq?=
 =?utf-8?B?M3BvQmk3UnhWd3JyamNiM1MvZEcybUh1YWFzSXFnTWM4a29RWU1HRXdnWUhK?=
 =?utf-8?B?VVg4YjNuTnczV1h5bys0WGZoQ1MwY1B1Zy9uazRqaEcraGFsT2crVGsrekdp?=
 =?utf-8?B?YnN1aU1nS0s5c1FMVWF3MmVQNm9sQlF4Umc2RHBoUDkvaXVSTWJCSWNwYjBN?=
 =?utf-8?B?YmE4TkZnVFpkeGM3MmNrSDNXcXhtN0hCc1UybGdwWFJYMld6YUNjaWM4b0RI?=
 =?utf-8?B?Vjh3WHpkZ0N2YXNGU2U3d0tuYUdCUGI0L0YrNjhwcFlKcHpFRXlxWGRGZktk?=
 =?utf-8?B?aXE0N1lmVjZMbmF6NCt4ZnVUREY3cSttYUhzb01XWkhGRHNVYkxBak1QYmhj?=
 =?utf-8?B?TzhRUmYwbUZ0ME16b3Fkc25NV3dnQkVDUHlsVjRleE5MOGtiVUQxYU1sWUhv?=
 =?utf-8?B?TjVBNW9Gdk03THp4VDd1bnkwOHdjUS9BMzNybDdqTmVnT2cvOEM2SFp2TVBi?=
 =?utf-8?B?K0I2R1JMR2hvVWM3YldKa0JpTDFnSHZYb21uUEhreFA0WjBLUmU4b0gyWFcv?=
 =?utf-8?B?U0Z1YVhRdktHWUhocHpoc2VPVVA3NEtkQzM2cGpnNmUyVnBlaW5CY3JHZy9m?=
 =?utf-8?B?L1cvRDdDNW9RRms3STY2ckR5MlgvcWY4aStmUW9pU2pIcTZaSkM1cDZBSjB0?=
 =?utf-8?Q?Ua0naWMPBd4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDFuNXB2MXcrcHRZRGtZaDBtcHYybmdVbzZqYS9KK2NBS2JQZWk2WENKK3o2?=
 =?utf-8?B?V2pIWHBWeDRZQjI1QVJySHFBNTE5V1BYMHFDOWJ6c0FwS0pKYnU1d1ZKRTFE?=
 =?utf-8?B?Z3VZNllzOWg1RUxwM1B6NjRabjhCa1plczdaNEwvclIvSlVoQU9kYWpKZmkr?=
 =?utf-8?B?ZFlxY1FRTWdHSytENHFSZC85Q3JOTGh1cDFQcFp0SE9OdzFMenBiTElJOW9Z?=
 =?utf-8?B?Z3dkbnBJYmt6b2JEUEw2U0d6SmNZRGVlY2lEcTdrbm5jd1FHZXNWbDZRMFZX?=
 =?utf-8?B?eTh3VkxoS1FiTktoUksvUmJaczlYNmRhQVl1b3VteDFRL1V1R0lETDZuUGla?=
 =?utf-8?B?WCs1OUJ1ckZsYXBoeDBROHpWdy8zRU1TTDdTZk5WTGtxK1p6azZTZ09mMytD?=
 =?utf-8?B?b01XdVFvcmtGVEJwdlVkYTJzS29yY0V0ODVWWlBPOEdPVnF3UE5WeWF3cWJa?=
 =?utf-8?B?ek1COXpXUzlxMm4vb05SQmZoZWRueFZUVjJob0tNdE1hNktkd1dZMWM2MUdT?=
 =?utf-8?B?ai9HRkJzYmtFZWJCMkVCS2JvMkJlS3Q2RkdVdmx4bjhJdUx4TTg3N1haRzRT?=
 =?utf-8?B?elIzOE9GQ1JQQ2Q4RmNVRkVRTTNPS1RyYS8ydS9jbDU1RkkwRjhQU2hKZTBQ?=
 =?utf-8?B?alJMNmtXNTZ0UThuMCt5UEd0TVR2QjNFanEwWUtEaTRkYjdvZWh3VDRodUN1?=
 =?utf-8?B?VWJrSHJSWXhFcEpUUEN4QXBOOHZhUFlMR3kyRTZhQVN3SmFEQUZWdkV1dFZ2?=
 =?utf-8?B?MmRLL0pUYnk5bkFLRHNqZGc0UzZ1VG1EeXd4UWVZY2NjanFaTDEyNHB1Y0k4?=
 =?utf-8?B?SGtTcUE5RU9QQ1EyWCtLeWNJK2M0bSsyM2VLRGo3WU9KbEpuaVpZNjJCZGp6?=
 =?utf-8?B?dm1ITFA3Mmt0TVNiMGltWk1wcFVUanFINWNvalJGVENoUVJOMzNmOWNUdTRh?=
 =?utf-8?B?RVVkd2FYbjZlMzRXUHpEanJkUlBteHlQdEFGeFIxNzQ1dWk3Ni93RUl6aWYw?=
 =?utf-8?B?LzZUT3I3WXlhV2RLU2RiWHBjZ1NCbjYxWEhvamk2TlAwb0F2akRLdzFTYjM2?=
 =?utf-8?B?UG12T0szOFYrTERISjdiTWo3UncxdWdSL2hlVzYvNVJDK0FCZHpLb1lZUU43?=
 =?utf-8?B?OCtxT05nMENwYm5seUZTNU5kZkJCZFJBMkw3dzJ4QnUzSjQyazVOcHFydlcr?=
 =?utf-8?B?UjhtYUMvZFdtclFVeGJ1Z2c3SWRkWHowZ2xXLzF5b2NwV1RSNWExanZhRWx4?=
 =?utf-8?B?d3BOWlF6YnlVTTRSWkVWUWRDL1prc0VCVXY0b1dJdGowcjBDU1hrMGRJNWpW?=
 =?utf-8?B?eXI0bldTOURqcVZPN2xYV3IvZStRYkRyOEdzMk9udE9GOFhsd0UzRFJubFlE?=
 =?utf-8?B?eWNxWWdOd3FzQmRZZUZPWVU3a3ZwaXN2ZG4weTF3MVBpRTNOUWxoMEQ0MnVG?=
 =?utf-8?B?V1RyeVZSdlU1SlBWNmFNSk1wY2Z2SS9YckxKek1Dd2taRUk1RnhWZGVKejRH?=
 =?utf-8?B?SnBvcGRqeTRPUzdOMWZOQjFKUTZ3YVdQOC9OZjcyRFk3UEFuM2VZYUVHKzdN?=
 =?utf-8?B?eEFvajJrT01vR2ZQSU5tQ1FqWXJaaWE5YkVmb2M2RTI5aHF2L2RHM2hkdmZr?=
 =?utf-8?B?UUhxYlprNlFRM1IrL2diZmIvUy9WcmdMOVI4STZWODdWS0ZxRXVZSENpRVdB?=
 =?utf-8?B?ZDF0YnZvZWw2N0JMWG1acHBabDlQa002ZS9BbHlGenpFdGRvclo1VUdUeVJv?=
 =?utf-8?B?Y01pR0hoak9nb0JoQVh6cGN2Y3BBUmNlTkpzL2hCYnBRaDFGdGdZM2hvWXJS?=
 =?utf-8?B?U0RNZGZIajZ4U3BxcGYzNUZSNnVLdyt6KzZEekFGZkc4US9YQVp1Y25IaFJN?=
 =?utf-8?B?RkgyandjVG5kaExpZzlBSlFCYWNjaGtycmkxZ3FIc2FzV3JHZHhndENURXdy?=
 =?utf-8?B?dUFEK1g3Qmh0OVhmZHYrWjBocE5VdmFVM2xOQlpGQ2lXQ1JvN281U1BXZ0xL?=
 =?utf-8?B?QytwR01XeEh5NkhUcVFzb3gvSDQwQThibTljTmdtQ1gwTFZKUGdyYXk4SEE2?=
 =?utf-8?B?a0FtdHdLWlIreTdTYW53MW9aTWV5RmR6OUYvSCswc2FYU1prbmUwWUkwQ1Nv?=
 =?utf-8?Q?sfCkxseMWwfO6TbvxAU1kDcJ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5414260e-5e16-4a58-4b38-08ddaca64c1e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 07:20:40.0364 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/pDs4r/kqOyrrO1nuZoGNR5vAdhO/Mn9eAKB1wEUA5+CAE53H4c6rPprxU0Va5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8195
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



On 6/5/25 08:17, Michal Simek wrote:
> Driver fully depends on firmware driver to be present that's why change
> imply to depends on to cover it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - Also enable firmware node for versal platforms
> 
>   configs/xilinx_versal_net_virt_defconfig | 1 +
>   configs/xilinx_versal_virt_defconfig     | 1 +
>   drivers/clk/Kconfig                      | 2 +-
>   3 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/xilinx_versal_net_virt_defconfig b/configs/xilinx_versal_net_virt_defconfig
> index a82ccdc9a0c6..3f2bcd954d24 100644
> --- a/configs/xilinx_versal_net_virt_defconfig
> +++ b/configs/xilinx_versal_net_virt_defconfig
> @@ -73,6 +73,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
>   CONFIG_SIMPLE_PM_BUS=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_RAM=y
> +CONFIG_ZYNQMP_FIRMWARE=y
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_VERSALPL=y
> diff --git a/configs/xilinx_versal_virt_defconfig b/configs/xilinx_versal_virt_defconfig
> index ba4519ce3037..1c44e4010beb 100644
> --- a/configs/xilinx_versal_virt_defconfig
> +++ b/configs/xilinx_versal_virt_defconfig
> @@ -81,6 +81,7 @@ CONFIG_DFU_MMC=y
>   CONFIG_DFU_RAM=y
>   CONFIG_DFU_SF=y
>   CONFIG_SYS_DFU_DATA_BUF_SIZE=0x1800000
> +CONFIG_ZYNQMP_FIRMWARE=y
>   CONFIG_ARM_FFA_TRANSPORT=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_VERSALPL=y
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 19aa2ffa5396..d4dff571412e 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -214,7 +214,7 @@ config CLK_VERSACLOCK
>   config CLK_VERSAL
>   	bool "Enable clock driver support for Versal"
>   	depends on (ARCH_VERSAL || ARCH_VERSAL_NET)
> -	imply ZYNQMP_FIRMWARE
> +	depends on ZYNQMP_FIRMWARE
>   	help
>   	  This clock driver adds support for clock realted settings for
>   	  Versal platform.

Applied.
M

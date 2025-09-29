Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9A8CAC5B5
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 05:50:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C71682A9E;
	Mon, 29 Sep 2025 07:50:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I/7RiOtl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46F6782A9E; Mon, 29 Sep 2025 07:50:14 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A7168144A
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 07:50:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEyrRbundLn3Ah4r/d5NNdvkii121NFukq3fpVdsJ9Hy9b5qdIpDGo+5uemyQFCZ/SNYqI+42s7IvD2/+Umljin5Tem2u8h3GbZjHt8z1oJP1Njq4d4erE6fzZkatCxTbs5T4WoTpVKTOPs9I9bq1BeU9veKb1tZRYIymvlmWG5VFYNpPLbiJjWjo+S/Ut48yRSlMB4XuipeW1jNV3hdrpkgYbRf4tmPFiK+uSCaayIDsoUogIU3MH+nxTYaHkzITfxSNNqllIYQb/V0k8lld//R4YMiRtnOgmqlCullxp0ZM6DQP0XbgQX4j3xtOsON90QsyqQv+uueZ/9RM2M3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tTNV81G8bUpeSTiHCQXD/DjnGbKnN2UheRtslGXVp1M=;
 b=W4wqQ54XEYh+H0ry+9mxChMWIqUaPA2aPClMpDfd52WZTv645rkR2e1a5cy7ioE6WzXmc7NT9L5Y1J/0iTZQ06z2wLKpiZfZ8yoCPsvr5uf4kZxrF2FQAFN559zGMTG7782S+E/c3Ehk0Lr6Mzaw0mPXGRFeh2u7UnoQNQohs23xD/86geeqj+TxhC2uJ0LtzOo4bQ4TjWJH0yjpGENvpPDUPqbsLnhAowaMqTMGXFPsmS7xYwc+zqeQDsDZL9ng+zbOYtw54UsZ5+MaobR/592IjR8nmawv/8MHjP25JX6q9JXxQbTUDMxjP+1zBtioa74sHZRazpRvVDyCYtamwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTNV81G8bUpeSTiHCQXD/DjnGbKnN2UheRtslGXVp1M=;
 b=I/7RiOtl6+HtiAEn2sKOhYDmG2EETWY7MzDRbBc+2ICOQb8zuzpVyh6RlCSmjbBoM1ClQzTKby/FWjslu62XmXmRLGxeW62eeIjolFq02xPpV+el8vzm3aueua1vBCNMQt6PA0Z345vthET1Bj6r5ZsEw6ywuOLOCQKnANq6hRo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8125.namprd12.prod.outlook.com (2603:10b6:510:293::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 05:50:07 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9160.008; Mon, 29 Sep 2025
 05:50:07 +0000
Message-ID: <824a8132-aa50-441e-979c-86ac93475180@amd.com>
Date: Mon, 29 Sep 2025 07:49:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] lwIP fixes (SNTP with DHCP)
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Joe Hershberger
 <joe.hershberger@ni.com>, Martyn Welch <martyn.welch@collabora.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20250922093629.2547703-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250922093629.2547703-1-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8125:EE_
X-MS-Office365-Filtering-Correlation-Id: ec27d029-fc04-4e82-d209-08ddff1c0b4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?akorbU5pWUZTcUc3eE5iSGk5NEVjUm9EWXdZOGlWbjFkWnVleFUrUkxzNEY4?=
 =?utf-8?B?a1hWbU5MTVVCRmd4d1ZzWHM4MW9OcVI5NURvU3hxVDkxZ1o1cWxWdTlvenZv?=
 =?utf-8?B?WW1CSDErS3VhaXRERTY5UXFmZFROVncrSVNBb3d0YVo1alVRS3BrbmxhMEFt?=
 =?utf-8?B?aTN3NWtJZWE4Q1NheUxsSUpsQit0b0NWRThzaFM3c2xKRW92ZVJZK2MxWllW?=
 =?utf-8?B?cExBVVNqNEkxMFc5bDRlcjZCWHFiQ2xueDJsbVlkdllFbm9EM0dsVnF4U0Y4?=
 =?utf-8?B?Ni9kUXl0dVN0V0wyVHMxY0doZFZWRUZlUmdDSjU3aFY1bWxvSm4wWjlyaXR1?=
 =?utf-8?B?Skc3UlI4MmxUZXphUEswVFZud09JbDE3T3Q3WUxRcldQaFhOVEIxcytnc3Jy?=
 =?utf-8?B?ZDU1VVNuMkVEeW5CRlZOTzkxK1dhWnJTeCszWDUxQi9ESjd1enFSaG1ITzBw?=
 =?utf-8?B?SGZBN1k2Qy9HeTljb1h3eUlZaEhjODJHQ3lvM0NtdElmQUxCbXpyZ3p5RXB1?=
 =?utf-8?B?bndlQnhYZXFYUmQ3Z1RvZHU0MEpudnhXcXZXd2REOTh2elIwdmd0cStWdlFO?=
 =?utf-8?B?cVRSWG1MU3V4bW5ReHkxM2JUV1RmUVFxMkUzSE5aZWZwY3dYQ3o1K1NVVFBK?=
 =?utf-8?B?VE5MNkNNbU5JbHpTYnozQk1BajJhUDJXckErYlhpTXd6UkZ3dkxqWVBxNDlB?=
 =?utf-8?B?Ykh3bzNBbXFEY2F6Qk9ER2hpZStRZU5SMlJ2UHRDZTlMVTJITmhrTGFlN2Vy?=
 =?utf-8?B?ZEtrVjZhalBkOGNDWGJsRmpLUGRNVVNqd1EwdEY1OTdxWWZWTWFSbXFoVC9p?=
 =?utf-8?B?eVJsSG1HRVVmQ2RuY3MvVmY3aktBdzUrcG1CTVhrS3ZiekZoYnovRWtYemhi?=
 =?utf-8?B?a0RUeXlNdUtySGt2UXhlOC9WZkhmbExFN291WEVPajhuYjQ5OUZHOVJjeTN5?=
 =?utf-8?B?b29HRXV4MUphRk1iZ2Q2b1k1ME5TUEVsa1ZCVzlsNmR4bWtqRk4yaC8ycmpi?=
 =?utf-8?B?Q0o1akczQzdUdVRGQXNKdXIrMno2bGVjLzlTUmx2NGpZMnJ3TXIrYzkvVjF0?=
 =?utf-8?B?L1VzcmZJdWdZN0xGdXdmSE5GSVF1bldhUW9BbU1BMi9mcEI4Z3d5dEYyLzJB?=
 =?utf-8?B?N1BrTFVxTU5JeFJzVE52RHNVUExDcDFxK1V1MVdOQzZ5QXhEMVlJYkt5d2Vt?=
 =?utf-8?B?UGRSQm9NeXB2NDNwZkptMTh2c3p5dDREaEU3MGRBWkpBK0RVOXB3V2hRMmtQ?=
 =?utf-8?B?OUg1bEdUTUVHSStCRXg0UzJPdUI5MWVIdVVXdTl6WTQ3aUFOcEFLNWFTMnFv?=
 =?utf-8?B?WFo2RHlPZENzc3BBc1RGbElJZ0JxSTgyVkg5S1ZtNys3WTlzWjVvSHVFQzJv?=
 =?utf-8?B?TzlQdEkxK2RTVWZ1SXpYOXh4UW5KWmJXYUEwTjdoN0x3aUg0VzFXbVlYNWtC?=
 =?utf-8?B?SDN2WDNuK0ZCSmhsbmVBZEpLQnV0NkJUTGtWTUZNa1RMbC9iRE1hbWgxbGNU?=
 =?utf-8?B?Q2pGZGxONzZlU1ROQ252MDI3SFZzeW5MV25tNGJBaXVjSERxZUxxT0k4QkVK?=
 =?utf-8?B?MFVsM2g5eTJMQjhNK3VpNm43VHF5Z1Z5czJVM3A5dmxqUVc1YVRaZXNoaGVO?=
 =?utf-8?B?MkxPQ2ljOVJ1SmVmeFFhUEM5YlhrSUhidFpLeTNSOTFXNGZ6K0Y5NWNSWEdn?=
 =?utf-8?B?OXFXOS9aM01TazJDZVZGeFRFRE9VdXdoNURML2VDUi9yN01xMkxhUFlJbExw?=
 =?utf-8?B?SzR1b3NmenMvU1VZTmlzSUNUUHNzWnpOSFlRamIzNnRmNHNkTno0aU9jUnp4?=
 =?utf-8?B?MFlwWXJjWmdWcGNrNm44WUJmSDZ0d3RRL0daY0tSbUN6MDRWYjNKSUQ4aXB0?=
 =?utf-8?B?WExQTkdmdFhkQ0pDcW1iQmRJdTZ6dE9QMjdvMWMrZ3NOaGk4bU5DWlF6QS9v?=
 =?utf-8?Q?G84bkfzgkhDoiW3FrzZ/Ni0cE0EjZk7P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC9wUlVQT20rZkM5NS9WeC9OZkFaT1V2VGRsMjZIU3Mra3g3bUxzQ1NnMUU4?=
 =?utf-8?B?L2xKV0hEVXAyZnlJNHFyNGRzbmNSc0xMd0UyOEdUZ2xEaXVMbmNreDF0Skd6?=
 =?utf-8?B?L1pXRGRFL0hWUmZLSTltQWw5djlwOWwxeFoxZXdlNWpPNDlpRXVscEFpUmpa?=
 =?utf-8?B?VVNrNzZ3dlVzYk81bHFxYlJtTjVwQk55NTBld3g2QWlYaExsU2VEL0VhL1Bi?=
 =?utf-8?B?RVlobDB3dXhmZFgvYU1JVkJEUVM4T3dlcGJMVXcyWmtacWJDdEQxVzFrOFBm?=
 =?utf-8?B?L2pxdEF4WkVLVkFZVExpajRjblVNS1VXdHh2K2U4N1g4OGV0RWc2ZkVVWHRs?=
 =?utf-8?B?UkEyVjh2NjAvSCtrSkJwQld5UHU4WW1ZQmNvcHVBY09TcXgwZXVNMjE1ZU1j?=
 =?utf-8?B?eEJaeDBRZnduKzM2WVhBS1Vwd2hBU21GNFhKQjV4bnY1RVhsTUhLUHp4YkdE?=
 =?utf-8?B?K0lyVnhHeVQ3alk0L0phSmVxb0Z4LzRRb1pURVhwSEZlWlpGTElXcTFaaGhW?=
 =?utf-8?B?cG1yZHE5cS9RQmF6NVdLZE5KbTZKYVZyRU10QnBnVnhaZlZJcklZL3dzZ2pP?=
 =?utf-8?B?UVl3di9yZFpQOEgydEJwN0NHT2VEMFBKb0psYmdXRTRHOHJzS0cxMkEzbzUv?=
 =?utf-8?B?NGpKaFlaUVhWRXBTam1ITGtXK2oyVXdCSERoeVd5K2hKMXlrRGVQelhya0lR?=
 =?utf-8?B?VCtMeGJpVFpHRktYNnNKS0R0TG9qZDZ1SXBLN3RUUWVsd1lPWVVoTk9TKzZP?=
 =?utf-8?B?U1ZSTXVQKzZVTUZIWU9wVUg2aVRLSExBRnJPSWN4cUZKdU5INDF0SlBTL3VQ?=
 =?utf-8?B?K2NvS1NIejlhVnBuK05uQS9xZ3UvYWJ2YWNGL0hVMFMvZEpBSEN2cGJIUzlP?=
 =?utf-8?B?SFdlVTJLN051RnI0dGNFR1BteGJUQlpGS3JHRlQ5NkE5VmE5SXNEMGNoYmtE?=
 =?utf-8?B?amd0YTlLMXViRDZxeFZRTmpLTEhRdm95S21aNEJzMytmVmxhUTc4R0llY3BH?=
 =?utf-8?B?V2dFdVJ1OFd3ckNiOW5KazY1ZzNiMW9ZenVEa1Y5cm1EckQrV3k5Uy9Va2dx?=
 =?utf-8?B?N3lKUWlZSnRLZEJhMjVCUEpkUEx5SHRxNzFhOXc0M25PdUdEd3NJaW5wNXFo?=
 =?utf-8?B?azUwOHFhYTdSSVFXOWNVMWVNNnVhc0pnNnpZVWdiVGpFcjRMTmVGVjhCcVBJ?=
 =?utf-8?B?WW1rb2lwWDBsRzFmUFZuc3RXRWNpZTYybFp0RjJEWVB6RDZiQmgwTWZEWTF1?=
 =?utf-8?B?cFVEMzlIZEVNbDhPYnk3ak8xNFpmUC81U056aWdVQWtlbHAvWktLV2kydnpD?=
 =?utf-8?B?c3d4ZnNmODJWdXRrUUwyVi9MNGVmUElua0pCTGN3Ry90QVQxMy9aQVczd0Jn?=
 =?utf-8?B?RkIyZG5IakZieW1WaFp6eUtkUkY2UVR2TjlCeUk4VVdFMGIrbUpybmxYVEd2?=
 =?utf-8?B?Um9ZSCtVYmg4b3F4dC9pSFU0d09aVFlEZ04yWFRidkcyeXlLWjAycmFhUkJv?=
 =?utf-8?B?LzdqelhjSEVmSkhTbmV3elduSGpvWVFXTUFCVVZWZVVMYUkwWVA0ak5pd0Iz?=
 =?utf-8?B?R0dXN0hvVTcybDhjeW03VzFMdDdKcVNXbkkrL0hKd3BvcHFKb2IzVFpiQkFy?=
 =?utf-8?B?RmFQRThnYitTZjNiaG9QNGkxaTk5REkvUmF1M0trUHl5T1dpS0dic1dSMmVW?=
 =?utf-8?B?WVRoakFFOTROcFZxR2YzYWkzcVE0bVdMUGFCeHVnaXZTdHBvUWora1NlMVB2?=
 =?utf-8?B?V2YwcFdDT0xJeVlhQWwyREdITU9abDVNVHg3cTdja1RnZngxNXJXd1dzTVlL?=
 =?utf-8?B?SUJPalA2d01HWnVuaUx1cmFBbnNtOHVGR3NsQjdaS0lZNUg5Snd6L0NmZWhS?=
 =?utf-8?B?WWJTVkV6OVp3a2VlZHBwRkNCbTYyVXdDMUhHejJHdU81SEp5Q3dUN3djSENr?=
 =?utf-8?B?Mm1tS1JRUHNzZU1nc1prem96L0FJVS9Xd1lISEVFcC9zTzZJeHhSK1d2VFpC?=
 =?utf-8?B?TUQ2UXdxenVMVFltREhHNTF0d3ovVkUwa2FBNzRzSWJXQUdLODUwQVlZSFUy?=
 =?utf-8?B?WVBLQXRua1ZXYU4zLzVrNlhiWG1WVVhsL3VTQ1ZFdktBS0Z4RnduY0F3aTdl?=
 =?utf-8?Q?M4uhF7DqGr+LdDVMOB7kI9pL+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec27d029-fc04-4e82-d209-08ddff1c0b4a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 05:50:07.3627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXtHiLHpDZDNs9aLAa+OXHPvz8OZL7A4W+jHyDPwTEsfMbOu+g5fu9SVEE5kCxeB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8125
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



On 9/22/25 11:35, Jerome Forissier wrote:
> Michal S. has reported (privately) an issue with NET_LWIP when both
> CMD_DHCP and CMD_SNTP are enabled. In such a case, one would expect the
> sntp command to be able to use the NTP server(s) advertised during the
> DHCP exchange, but this does not work. This series fixes the problem,
> improves LWIP_DEBUG by also tracing NTP-related actions, and sets the
> ntpserverip variable to be in line with the legacy NET stack.
> 
> 
> Jerome Forissier (3):
>    net: lwip: enable debug traces for SNTP when CONFIG_LWIP_DEBUG is set
>    net: lwip: dhcp: make NTP servers usable by the sntp command
>    net: lwip: dhcp: set ntpserverip environment variable
> 
>   lib/lwip/u-boot/lwipopts.h |  1 +
>   net/lwip/dhcp.c            | 14 ++++++++++++++
>   2 files changed, 15 insertions(+)
> 

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

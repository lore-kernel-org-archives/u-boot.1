Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD008D68BF4
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F02E83CAA;
	Thu, 18 Dec 2025 09:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d2yijMHZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B1883CE3; Thu, 18 Dec 2025 09:49:20 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25C4C83C2B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:49:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q879DIBZzLMej8jR0hGT7CbV64hSpTRnzsxFimq7abIjRb2gZegDyvxyUtjc4fM+Wr1qS++J3fVf86T4qYE2tFdxQUTPi2H6l673uzxocdE2ZFsWbdcrami3LpursURVlpnKXeYxOkgSHSIgoA/TlVS8uh8QAXeapSQf1DPGjRtvNS/Pauu8oxUwGYCnrJUtJUD2ACC7dFj9F3bRTauAnKOyDddyXn/XNFdWVli7ncVpul6/TDxmEaxcFMo5CGSryv6rCfZ/yrMGL/S0zrdfOe85HrHd2mAkV6FQD9ZM7eZX2Mbz2JwyvGy/XwaozZyRMDwiYoYK7fOlUsg1Yq7DiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlCZBjuAQ7BWbSLZn1RvfvntGPp2ADWdWVTGVi8QGgo=;
 b=BHsdjSkDNjwl3bgRigjbF+W7xPKUZb57dCqiN3Mq1c1Z+Se4x0W6ffyPkP8dAdyicSbartXQ3WjbhOCbC6vKW3bn5EAGL5bLBqdF/XtuHO+IBcGn5fe+8sufXwlAmrtWXCqtvV2P7OOtu5cW/4QeNnTyYvIhrL2lseOmcAuP1bpaO39qfNZsvW8Q9qT400O0M0Q0QrnmbMnQyRh7jbi1zF3oZDdxjkiwFR2dl7LAflLGejiQpMiJI0qa3oEs8SyLblkH4vlQxfTCcXrLQxZGvSOfZgXyh9zHu6CQrw9LAAbHjU0C2ReU7/c1BkkrrP4Ja53s5NKXumzysmy4YaN5YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlCZBjuAQ7BWbSLZn1RvfvntGPp2ADWdWVTGVi8QGgo=;
 b=d2yijMHZ84/xJ0t17If/5nMveAXo0SUud/juKU8YlHUVuFGJL6gg+OLQtQneORhikRCfTc8apvZxYW4kwvXRYllgCIGS58UzYI/+VXf3ZBUHj/RmecH3a+zx+Zuc5FjOgx72eGJZIriCjqJ11tHbDvikKTrVDGtEvnKeiQvPml0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:49:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:49:08 +0000
Message-ID: <062d1a2c-b8f7-4b64-9f18-0cc166b14555@amd.com>
Date: Thu, 18 Dec 2025 09:48:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: bdinfo: provide long help with all options
To: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20251217-b4-bdinfo-doc-v1-0-83bf7fdb1691@cherry.de>
 <20251217-b4-bdinfo-doc-v1-1-83bf7fdb1691@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251217-b4-bdinfo-doc-v1-1-83bf7fdb1691@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0217.eurprd08.prod.outlook.com
 (2603:10a6:802:15::26) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: 140ee2ee-81b3-480e-8fa1-08de3e124eb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dk4ydnhOaDRaa3YrQ0ZUMFUxbDRLZjlIaHRHbkV4RnpwZGpaamdvUklyWEtJ?=
 =?utf-8?B?WTFYVEcwQzFaSi9KQkVXK2N1S2dScDlmVnR0L3R6bjNBcGpoRVppWEJtbXFa?=
 =?utf-8?B?aXNQbUkwckZXTERTMmdScGNjMS9RVFFlSUJLWHpqbjg2YWo1ODVRUklTYkxy?=
 =?utf-8?B?N3BiWUE2MDJ0dWt5VFV2MmtkVTZ5ejM3TzdyUVk0WDkyZmR5RlFWWGxRWnFv?=
 =?utf-8?B?bllSMTZmS1dOYnRjTngxTUlqWmQwdnhqTGs0ZGc0YUlBc2tHTjU2NjJsWjBr?=
 =?utf-8?B?RTRmNVBRNU9kNGZZa1U2bjVXb0pVRmlubkREdmdrZnNZaGRUSVVlcEgvakhC?=
 =?utf-8?B?cTI5RTR4MFNJeld4OTFmQXlSTUhIaERZcVNiUEFwb3JZREFEN3lXRnFzUGR4?=
 =?utf-8?B?WDZveDFERjA2aVR4dmZNZEtPQXF6aEZkeUVRRng5ejdHOTZsdDk0Tnl1MmJV?=
 =?utf-8?B?SDk0di9IK3Z3QXRHTTZxT0RZYUh6c2NxVnU0YndPYmlCeWlNSytkdU15RTgr?=
 =?utf-8?B?VXRuYkZuWmluMDQwNXVsOFpNRnhoamhQSG83YzNqOWk4L1hwSGZUaGRPR1R1?=
 =?utf-8?B?OS9WaDNLTTZCQ3JGc1ppc1k4c1NXNXQydEd6YVRjbmFLUE11V1dlQkUzY2E4?=
 =?utf-8?B?NXYwSUZwVzllM2RXdjhqc2JRMmJYb3dLdEU2dkMwWTFoVnBoR0xGWmlzQ09r?=
 =?utf-8?B?dTBQcVQ5eldRMmtzVXJ3UU5YSTZodUx1NHdGZmRHMFlid0l4M3BFQjZGVENa?=
 =?utf-8?B?QlBKSW53TFpSY3dIWlB0eExVVkdUZGVNWmdoM1FMVmFBQWJuSEVlK3RaaWdT?=
 =?utf-8?B?c3JoU25ob3NBZmtydkRFcVRVNndXaE9Rb3gzV0MwSGpDVWw0WjJoTzVyMi9x?=
 =?utf-8?B?V3FjbkVzemRCd1dsbDNwK0MrYjIvYURMRlJjbDVQSCs5QXRLNGN1TDRVd3Ew?=
 =?utf-8?B?bTU5ako2dExZNmZTdHdIeFd3R2RRL0NraXhwY2lIc3ZkcGcyOExvblR3TW5q?=
 =?utf-8?B?VnQybGloc1h0OXFBMFdTWnBadjl0L3BkTFAyZWxCUHFvSEZubVpYYTZRcksr?=
 =?utf-8?B?SGNHRlU0RHVKV1c1bEp3QzV3cUNkUS90V2pJTnR0TXpka1RaL3J6N21kcG11?=
 =?utf-8?B?WmhBY2k5UGw1dWdDdmNBSGRuNGJKakZyWVhwYVRkRU5veVlkRWxhODVuRVF3?=
 =?utf-8?B?MUFqTEFXR1J0N094LzNHMkVnVHFYZms2aUQ3VHZVRlFQWWQvKzduc2trYnJU?=
 =?utf-8?B?Wm1qMThZZjlFeTJVeXFZempwb3hKMmx2L2NSUVZLUncwcnA2Z1pobnRxbVBm?=
 =?utf-8?B?MnR4WmRxVjJLZk4zNmFXd21rOWFucXFHdWJSUjlzd0YvTG9RNS9yTjFvbkxz?=
 =?utf-8?B?TFJrYzhoUFAwTmp6TkpoamRoVnQ0d0UvZGl0aUY4cCtLZ0dHcG50amVHcHFO?=
 =?utf-8?B?eWFzWkNKbGhOY0xmRzhVajBYb01zNE1qeGVWUVdHbzVtQ1Y2Ykp1RGxGLzJl?=
 =?utf-8?B?OXNHc0YrVnd6bFV4Mm9TZzNMbWlDVlpBUEF2YVEyU1I0SUVndXVudkxaL2ho?=
 =?utf-8?B?Z1ozWVVPbElwMzFVUEgwWWtXRjQwMlZlY2hDdjlFbUxtdjR5RVJMY1cra0s3?=
 =?utf-8?B?WUh6RWtTaklmeVVQc0tLOTJENUFxc1dPME96M0tDa2Zma3VqV1FmL2JqYjlZ?=
 =?utf-8?B?MExKRVh1Wk1ENzl2T3A3aUJYNk1KUzVJcUJ0U2R2Q2tERjBUVFRMVlpMTllG?=
 =?utf-8?B?NzlTZGdoTUhhVkR3WHh3eG8zVFlmOEwzZDhWSWxjRStENGQxbHNaYVVpeDZP?=
 =?utf-8?B?d3VnY0kyWGNFd2RyV0JDeVdUUUE1UmU0T2FERTVJWEdrTVFTL0RqcExoZzlW?=
 =?utf-8?B?VTZ0UG9jQ2kvRURrVGVVUDlPcGRDbEFGcmZwQ1ZpRGtxMGZ4UkNCbW9pbWtl?=
 =?utf-8?Q?LJpFUN7XzjUvny1GCoduoqee28hIkPPz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHNzeFVLcGM0WVRaTEdyZlpKb1FONFNLOWp5T1BqL25uZkcycTlQTWEyZDhp?=
 =?utf-8?B?MDRxazhVY1F2UTFYNUl0MkJOYlRPZ3kzWEpqMTI2SEhGa0ZGTU1xamVpREJQ?=
 =?utf-8?B?TFdQVUZvREVUKzJaUEc1c2NXbU0rRk9XMS9YRXRMSjhPYjVaWDhUaWNXaU5s?=
 =?utf-8?B?VWsvUHdxdzAzNC9kUnF3VnhCVG5pQzFTYTdzUk9WM1JHc29mUGRueGdpanNx?=
 =?utf-8?B?T3dwNEp6Ly93USsxZVFMWkZmT2R3emRmQ2hjNWRjZXpxYVQvNXN6UGh0R2dK?=
 =?utf-8?B?Rlo0UGdaeXYxNnNJRjRybW56M3BKajkwaDVIMXFZTFdiODd4NURqRkV6Nldy?=
 =?utf-8?B?ZFF4S05CQWhzanVYcHVNSldObEMyREJ0LzFDQlc2SXBMRHRNTDZVR1dvWGJh?=
 =?utf-8?B?YXRLaFYyaFdDNmRHOHhRRFpOSzBsN0VsRGZFZjhGa3VXbG9CeC9nRkxMeGpF?=
 =?utf-8?B?OE9OeWN0RkhmWnlZK0Y2azB4a2k3QVR4aE1YQWd4eDM1NWh5VjZ5VU9iSThM?=
 =?utf-8?B?cFZicHM5T2RoNnZhQ1VXbFlNbXFBVzdVY2ZVU0RBdkRuNkF1RkNHelU3aTRM?=
 =?utf-8?B?K2Z3RW45b3lvdnFDU3ozVmlLSkNoRVRsNkFMYjE4SzNubTVjanQ0b0VVSjd0?=
 =?utf-8?B?ME4zNUZaVEtLdDNiVkl0clZ5RkIyWldOZkxsWlVRckNyNzFHa1JhdnhCa0s4?=
 =?utf-8?B?R3J5U2crMVJBRFFRa0lKNmM5QWRESGI5ekl6eVo3bjZKcjJGMmZqbWFDRElt?=
 =?utf-8?B?YnFCcVFZZmd0SXRVcm51blg1M3ExWEI3Y1VmU09XSy80dTY4Q01IdTYzV3Fk?=
 =?utf-8?B?bmxzY1FJc3dTUi9pS1RMYU0xVkF5REo2SlF6YUZUemJOUzRQVGQrd3JlL3ZJ?=
 =?utf-8?B?RWNsc1BZbUwxR2ZsVUljeCt1UnRVZVBrSUFlUkxWNXcyQnErdE1QOWZ3NXND?=
 =?utf-8?B?QTlyVytxQmVERzFITEpYY0VKRmhYRjBHSExaaXE5VTlYMStVdEFQWjFud0dN?=
 =?utf-8?B?NXUyRk9ZN28zcGNmSm40cU5SNTg4dGdJMDdPNk5xZms3bzR0NFdEY2FIQ0hU?=
 =?utf-8?B?akpEL1Z0eUNvYzh0ZEcyWVZVVUR4QXhuMFFXbTA3dDZhTjZxaHdyTWdTWHdt?=
 =?utf-8?B?L1NGbHYra25kbjZDMmdCVlBjaGdNQnBKaUt4cUNlMFFRb3hwbDdlc09vRm9v?=
 =?utf-8?B?Mml1Nm5pSDBRenlvdEtJaGpuS3U3aHdhVXpENWN2MHFsUjZtSmhNc2toYU9U?=
 =?utf-8?B?TEtHRGxoWkZ3cEZpTmhBS0p4LzdjNEViQ1dUT3RNUXpZUHVIa2tBVTVaM0NH?=
 =?utf-8?B?a1BqWlNWZWhCMkorR3dnT2xZMHB4TVZmNFQwc3I0aGh6U011bFlveXBmWFlL?=
 =?utf-8?B?UkNHL0hpVWRwbmRLMDRJWGRpbC9GWGUxUHZsK0x2eVVtRFhzaXlnVTBJdzZY?=
 =?utf-8?B?SzBxOFNiZCtnbWFyR1ZHTmhhQ3F2NmRsNVFheXlWMUhoQVB2MEoxTGpib1FX?=
 =?utf-8?B?Yk5LTTh1dk9zSVhpbXM5Mi9WdGIxZUpHZisrd3UwVjQ1YzdtYlMyRjA1dDdX?=
 =?utf-8?B?RDkzbExqSVdCc2hqbkw1RUZ4OEhsWkJrdzJPS0xPeDFZQU92S2UxcTJYL3VD?=
 =?utf-8?B?YkJQbVZZSnk5RE5HMUhXZEdTM0ZYNElzSlYyRVNWdG5LL0xsQjVPanFldHc3?=
 =?utf-8?B?NUpYN1UyRkVuLzF3NldqN011d1VTbW4xSE9SakpQcW9PV2lJMm9VdlFjbU1D?=
 =?utf-8?B?ZEtNT21ucWVXcjdRaEo3aUpiMGNBYTBuYkxSSkZFK2NQWjE1bzk3RXZ3Tk0w?=
 =?utf-8?B?S05BSWZDOE9BbGlZY0tMOFkycXNkaHZ6d2xMdXlPQXJhV1c2cHRVaUNESEND?=
 =?utf-8?B?NG9IRFVHemJ4Ny83bFd4dDVrcVNpdCtiWmpVZ1BZNXZKZURhZFJGK29oa1Ft?=
 =?utf-8?B?SkpNak1xcjdBeERhOURDSXo1dWJncmFJV3E4dm14djhONlVZRTRLSVRBcUlZ?=
 =?utf-8?B?OC9SR1NJWnJaZGcvaEhWZzk0MzJDTzlWeEZIZzZHU0tyVW5pem9EVDJEclVH?=
 =?utf-8?B?YVl3QjNtaHV2UEF4WWE3K2xEdUdpT0x5RU0vampjekFwazk4bTRkUDVkckF5?=
 =?utf-8?Q?mpo2i2AhNuOArTnZc49tn+Que?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140ee2ee-81b3-480e-8fa1-08de3e124eb3
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:49:08.6466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fqAitDRl8nS+dE/UUC9s8WwQmS2mXWXZmo0VaBEo3npqp4kbSBciuVUlVMRMCHl6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689
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



On 12/17/25 17:23, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@cherry.de>
> 
> Document the bdinfo -a, -e and -m options in the long help, but only
> when they can be used. The string concatenation is a bit odd with two
> newlines, but it does render properly once in U-Boot CLI.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---
>   cmd/bdinfo.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/cmd/bdinfo.c b/cmd/bdinfo.c
> index 09fe8067642..f36c6123ca7 100644
> --- a/cmd/bdinfo.c
> +++ b/cmd/bdinfo.c
> @@ -212,5 +212,19 @@ int do_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   U_BOOT_CMD(
>   	bdinfo,	2,	1,	do_bdinfo,
>   	"print Board Info structure",
> -	""
> +// Long help prepended with command's name, and `bdinfo` is a valid command
> +	"\n"
> +#if CONFIG_IS_ENABLED(GETOPT)
> +	"bdinfo -a\n"
> +#endif
> +	"  - print all Board Info structure"
> +#if CONFIG_IS_ENABLED(GETOPT)
> +	"\n"
> +#if IS_ENABLED(CONFIG_NET) || IS_ENABLED(CONFIG_NET_LWIP)
> +	"bdinfo -e\n"
> +	"  - print Board Info related to network\n"
> +#endif
> +	"bdinfo -m\n"
> +	"  - print Board Info related to DRAM"
> +#endif
>   );
> 

Tested-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75468CD4F39
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 11:50:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F369D8407D;
	Thu, 14 May 2026 13:50:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A1eB7m7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A010845E3; Thu, 14 May 2026 13:50:11 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FADF83AA9
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 13:50:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JzAZAJNOiu8VADl3FYLBAwY4s1IhVnM+GTqqpfzwO5QzVkFmoF6RT8shAEfmf/3ZwM/61NHgrEqMocBTsm1E0GN2vcecmDc4gWveC0v56TVT7FYfudlpHuFzNmrzNTYIDOREQMveS/3BzDm5oS/f4wAz+IjUGsMitJidIguU/d4DisJ7d03NX6QnfeMh3re/npRz7x28panQLGYSo/Htu6E2Ps8tTJ9eIp/o1B4PvQrGEnmeyPzpG36CojoW0kLQ4ShR1EY7eEhXKkHOrYeR0B3iPJ0OFqPIH7PNu/e5dThfftSYFqrwXiPuexTr0PZZpTO2XFC7BQnhE6LF5hrZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lh8QL+vzVMfkhdhBwzDKdMhWjFxMsfd2heo//8IgGbo=;
 b=OyhgYJLx6gejHYZrgSupuIE+SgYy4tLMxvNKRyoIDbPtZ+vtvwC3CJlgNUEHAGGFOc7m3Q1OVG0qts5m7EwVnTGlU8D36T3rCM0OjW0ibFAucp36gBmcmK5cbqIclJAn9cWod6S8AVfXj6uQBIclDmTGAfXt6wx10Stij+gAGXYrlUvLYLYsQlcv8uIZk+E3mkugLKEwQUFjDDZ3vIscMKHcFB+V3OiC37hWcGOp66oL4dlcwiBAWfxGVaatvBtSGyWUBxRtlbvyNYmqMJfI3k6YPUcp9UN9wpFuBcIofNub8yTY6BY+JJlZlfhakZ1vLsejdxqvt4iZFt+YHKKnIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lh8QL+vzVMfkhdhBwzDKdMhWjFxMsfd2heo//8IgGbo=;
 b=A1eB7m7gRY1dRYjJnS1Fqg9y/yabcP9w8EL+lvdBWBFklwLEVPPLqRrxWMy6oCwsbKoVQJDkbFsZt04uyEVLgkPz59/QvbpVqmQwrgndS/A9fiE0qDSVvtH8vdiishOv3PkduFWtqAdk1E6fB4uRN6IsA9D/Qlcta9XGxVhizTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SJ2PR12MB9115.namprd12.prod.outlook.com (2603:10b6:a03:55c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 11:50:03 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 11:50:03 +0000
Message-ID: <05c071fb-2615-4f6e-8143-818108643b27@amd.com>
Date: Thu, 14 May 2026 13:49:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
To: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>,
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes
 <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, Stephan Gerhold
 <stephan.gerhold@linaro.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0215.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::10) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SJ2PR12MB9115:EE_
X-MS-Office365-Filtering-Correlation-Id: fac59ddf-d89f-4c17-4f63-08deb1aeef66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|11063799003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: G9pkL/JsXDe6lRF4opU03zu0JW1ssNvZMvRcN0XuDTxDKT2xFYoAOqFbrfdpHS7x8uy52vz2QxzgTgcsvnM0Hvhj/lTyClXns+BxiHwz7RdK8g5rZSwMqipi3ccl0IFR32x/E9PIT6t/8FGiOx4f9jLE7y1jcS0hHEY9NyQAevPRQC+Tk/cPS6n2N1Lx1BdV2+wGMjA6WU02i1gxZYtDhD5d2iT4igiBD+jQMLRAotogU1+X83H+nlY5Vpuy0UXU46ApvQf8eztpzQS7gxyWwFpkeG69DpxVPq9EUoH4eE345J7ilsyT5ZRn8ipnzKsf7+AebN9yN3reEqT38Dd18a3Jg2aPXXUTIuZ7sIiL9+ZRS4OMRyFHJPSSmu1+ro8dE1GVf+EpQKzk8NXPJ607Srhset6BihJSkldivkO+BWCyI49JuTVMkTfrCH3AhqqWTknd7mBqFMhYmvSzF3UfH6CBqqxHqxz1zS2tbrY41iZTAsNyVmXcT/mJfN/k0KVZ33Bocz80LQt3dSkmuY1Xc8Xdn/cG1iitbFdtStX+P0IQRnzIZ/EcDkBAcYTbqqzE88olu+fwa13W6xEoKDsv30Uszvb/qtxlEnrFhop2+dTE9I9dK9YKixVJ6FcwtnXSwBqWlClZbUSPDPMcHPIqqg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVhqcmNvYVpIalg0UVk5ZDhBK1NkN3hCYTJTM2ZDNFp3ZnNVSmM1UWU0UWVO?=
 =?utf-8?B?a2RHSDUvekJTYkx4NzdCZkJCb2pRdDdjWjMrd2VhOFRPZGwwR1Z0MDlsd1ZH?=
 =?utf-8?B?VHNsaVQ1WXVxMkxTdXBvYXY2cVlEYUZHRm1KZGtYbWsvZEt0eWZpSGE5WTND?=
 =?utf-8?B?YXRFRytZeHFHUHp5L2VQKzhyQWZ1SnJjcjBDVVdOcDdxTTgwbEh3Y081UHpT?=
 =?utf-8?B?ZlgwV3VrY3Rrd2I1NjBycTNVWWRHazhxcUZpR2xYTjA4Q1NDOFE5VUhUYkVB?=
 =?utf-8?B?ek1YSy9zWk1hRlhGVlNDQTZCZjdKc2h0ZllKc2JLVHRsWC90RUo5OENobDgv?=
 =?utf-8?B?cGNCWElkMCtqVUhaaXZkSE9hdXpRc3VhRHJCQ2x5L2pGZ2ZHN1ZrUlAvRXc4?=
 =?utf-8?B?aGVQSk1TT2JTMkx6WWp6aVZEV2I3K1pmbDZrcnpFZEM1TjgzMmFFbDdnYTND?=
 =?utf-8?B?aHJqL25vUElUOXJobzd3a3VnN0syUmxCTnNmVDhEM2M1VWNjOFNuTldxZW1G?=
 =?utf-8?B?Y1l3bURGQ1dYUVNDNDRvTk40eTRDb04zb2EwVCszZ1REK3pJK1NHdERJWWNN?=
 =?utf-8?B?SCtqUzFwRkNMTmZVekR2bTFDbzdhOEYzOHdsNXhYSG9GT0hIY2xDNTV5anYz?=
 =?utf-8?B?UFY1MW16d3dsM0xnQVVsTnp6NFhrcG9JMjZoRnZCcGxMYlZ6SGRVd1RCZUx1?=
 =?utf-8?B?bldFdHZHUng3YmYvWFk2Mm5rcEc3NFdYSHFENXZ6VG5LbmNRdkJIYWFvdFY1?=
 =?utf-8?B?MWZzQmkvTVBHS0MxbHFreHFyd2hjQjNKM2tQZkNWQ1hTZkhkSzlYLzJycDRV?=
 =?utf-8?B?c0JWaFpqTExFWUxMbzFvcUd0aHYwYzV3NzVRL2llaWtraG9KdjYxeG9raHNP?=
 =?utf-8?B?R2VKcWNEdTZwVjVaQnRZS1RlSldkYXB6NTlvNmZoaFVVVWtpZFNFZmFQNHNs?=
 =?utf-8?B?QmErbUk5ay9odjVEYlo2TEtzNUk5MlRJdE56VjJqUlhmTC9qbGU4bmlBOFNC?=
 =?utf-8?B?S1Y0bkhCcFpraFN3NENmOWt1YURtcXE2bVh2Z2ljMTFYKzU2VjZTdzJuSUFU?=
 =?utf-8?B?L2pzRXBIZHBaTitDSWRSaG1oYzBCbUUvdDBJbzBDY1YrN1lGSlN5SEFINHZq?=
 =?utf-8?B?VmorUHJSNUl6UXdPUlBEQ05Sa3RQcmwvVHBqeHErKzZISjFJbE9QT3Ewek5C?=
 =?utf-8?B?SHVNRXdBMnQ1YkVVRVU4RzZNd0F6blpIRjlxNlBFcm45clJLSVhvSDBMM0l5?=
 =?utf-8?B?NFVnTEl2ZXEzaG80Zk53bFZOSDd2M0I4N0QrQXpBaVJJK0dzTUxxeVFDdUUz?=
 =?utf-8?B?SkVmd0JjTmJSODVBZE5XOGwraGRpQjViMFdVeHI3TnMrYUlWSmpIZEV1RUxj?=
 =?utf-8?B?Rm5lQXN3SmQveDllaW9WN0UyOVgvaW9IV2R2dVV5Qm1Zd1hodTdJbkdzc2Zt?=
 =?utf-8?B?ckNkSlRJU2tSbUZUNng1U0djbUhlODFQYXh3TzRlMTgxYzlMa3ppUDFuT0JS?=
 =?utf-8?B?MXIvS2h0WE04SE41WGFBb0NvNkJTRHd5QWp5cWtURi9MMXpTTlp4QUo0R1py?=
 =?utf-8?B?ZDNOZjllZGZTNlNWOEI2dkVMSENDN1ZpWVFqWStrQkE4eERVV1owMVp0TlVs?=
 =?utf-8?B?a2E4bU5zdXRvMklHQ2tudDkzOG9RcDh4aUZWL09GWC9KUVB5V3FTUGlEYVZO?=
 =?utf-8?B?QWw4OGlhZEp3OXlKRTdNZ21hZUpjQUZZT3VPWkErV1AvVkFxdlJCOG00Q0pP?=
 =?utf-8?B?ekl3OWxSSllXOWRFaVpBM3Iza3Rid2tOS1Jtbnp6bEQ3YjlJZHZUdDZoWlh3?=
 =?utf-8?B?elhSOEF4cG85cnJYZjZ6bkZLcEszeFJnZjRkTTdIVGlQcVZtRFVsSUV3ZlN4?=
 =?utf-8?B?SHp5aVFuRFVKL1Zod1Y3Rmx4a1dPS2g1U2ZmMWFiSUgzVGQ0OXJSTXk5S1hL?=
 =?utf-8?B?NUhTN2N0ejdwY3VkMkV4aENHSTNQNUNvTUhyZytqNUFldEpHTHJJVUVWbzkv?=
 =?utf-8?B?ME01Z0o1TDJEYzJBdlZVSWJjRzlqcnJIUXl3Q0Vod0c2cE5aYjgvbjZFVGo4?=
 =?utf-8?B?Q0YzU3Q4cEs4ZmlkNWV3RkgrVUpJRHAwV1VRb0UxbFpwOGJyQkdpclc3UmNr?=
 =?utf-8?B?cndIbWZrSmpPaWR2MExReTYzZ1pNSEsrUGhxTjkyMVI1M3dwVDZnL3QxZ254?=
 =?utf-8?B?L2dKOWFYM3hQdURXQUJWeklrQU9jMG1mZWt1VW10aG8vV2R5SGllYmdQMTVQ?=
 =?utf-8?B?Nm9IaWZBamx4b0lQN3l2REdzUU00blNOcG53NGptNFEzSnBmVTZkWW1taUo1?=
 =?utf-8?B?K1EvY3lYQVhPcFFhZFcrSUcvcjhNWUY0ZGhMMXE1T05iNzJiRTNsQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac59ddf-d89f-4c17-4f63-08deb1aeef66
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 11:50:03.2885 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TELJKVbWf0LPf2dyrlpwD3CrbCdWtKPWEHv/rET1qXcBx7ttL0UrhfaiODznU5kj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9115
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



On 5/7/26 11:27, Jens Wiklander wrote:
> Hi,
> 
> This is a follow-up to Jerome's patchset [1], addressing previous feedback
> regarding the monolithic nature of the driver update.
> 
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back into
> U-Boot.
> 
> This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide
> a clear audit trail and maintain bisectability, I have structured the
> series as follows:
> 
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>     to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>     a "snapshot" import of the drivers/usb/dwc3 directory for every major
>     kernel version (v3.19 through v6.16-rc7).
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work)
>     re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>     required for U-Boot integration.
> 
> The final diff is identical to [1]. I decided to stick with that for now to
> focus on the method of how we import or update the code.
> 
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [2].
> 
> The previous patchset was tested on xilinx_zynqmp_kria_defconfig and since
> this diff is identical to the previous, it should still work on that
> platform. With the help of a custom build script [3] and with an additional
> patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
> plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> platforms using the DWC3 driver are still OK, but at least there is some
> hope. If this breaks your platform I'd like to know, and if you can send a
> fix it's even better.
> 
> I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. There
> were a few conflicts, even when backing out the original U-Boot patches on
> top of the original v3.19-rc1 import. However, the resulting state still
> diverged significantly from [1].
> 
> Instead, I've imported each new kernel in a separate commit. That way it's
> very clear which kernel patches are included. Since there aren't too many
> patches for each kernel I'm listing the relevant commits in the U-Boot
> commit message for easier reference. I did this with a script so it's easy
> to make changes, if the approach is OK but we need to tune it. With this
> approach it should be easy to tell if a Fixes patch for the kernel might
> also be needed here.
> 
> Thanks,
> Jens
> 
> [1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30004
> [3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jforissier/zynqmp_kv260_build.sh
> [4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/meta-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260-fix-usb.patch
> 
> RFC v1 -> RFC v2:
> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
>    dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
>    from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
> 
> Jens Wiklander (60):
>    usb: dwc3: restore to original v3.19-rc1 kernel import
>    usb: dwc3: import from kernel v3.19
>    usb: dwc3: import from kernel v4.0
>    usb: dwc3: import from kernel v4.1
>    usb: dwc3: import from kernel v4.2
>    usb: dwc3: import from kernel v4.3
>    usb: dwc3: import from kernel v4.4
>    usb: dwc3: import from kernel v4.5
>    usb: dwc3: import from kernel v4.6
>    usb: dwc3: import from kernel v4.7
>    usb: dwc3: import from kernel v4.8
>    usb: dwc3: import from kernel v4.9
>    usb: dwc3: import from kernel v4.10
>    usb: dwc3: import from kernel v4.11
>    usb: dwc3: import from kernel v4.12
>    usb: dwc3: import from kernel v4.13
>    usb: dwc3: import from kernel v4.14
>    usb: dwc3: import from kernel v4.15
>    usb: dwc3: import from kernel v4.16
>    usb: dwc3: import from kernel v4.17
>    usb: dwc3: import from kernel v4.18
>    usb: dwc3: import from kernel v4.19
>    usb: dwc3: import from kernel v4.20
>    usb: dwc3: import from kernel v5.0
>    usb: dwc3: import from kernel v5.1
>    usb: dwc3: import from kernel v5.2
>    usb: dwc3: import from kernel v5.3
>    usb: dwc3: import from kernel v5.4
>    usb: dwc3: import from kernel v5.5
>    usb: dwc3: import from kernel v5.6
>    usb: dwc3: import from kernel v5.7
>    usb: dwc3: import from kernel v5.8
>    usb: dwc3: import from kernel v5.9
>    usb: dwc3: import from kernel v5.10
>    usb: dwc3: import from kernel v5.11
>    usb: dwc3: import from kernel v5.12
>    usb: dwc3: import from kernel v5.13
>    usb: dwc3: import from kernel v5.14
>    usb: dwc3: import from kernel v5.15
>    usb: dwc3: import from kernel v5.16
>    usb: dwc3: import from kernel v5.17
>    usb: dwc3: import from kernel v5.18
>    usb: dwc3: import from kernel v5.19
>    usb: dwc3: import from kernel v6.0
>    usb: dwc3: import from kernel v6.1
>    usb: dwc3: import from kernel v6.2
>    usb: dwc3: import from kernel v6.3
>    usb: dwc3: import from kernel v6.4
>    usb: dwc3: import from kernel v6.5
>    usb: dwc3: import from kernel v6.6
>    usb: dwc3: import from kernel v6.7
>    usb: dwc3: import from kernel v6.8
>    usb: dwc3: import from kernel v6.9
>    usb: dwc3: import from kernel v6.10
>    usb: dwc3: import from kernel v6.11
>    usb: dwc3: import from kernel v6.12
>    usb: dwc3: import from kernel v6.13
>    usb: dwc3: import from kernel v6.14
>    usb: dwc3: import from kernel v6.15
>    usb: dwc3: import from kernel v6.16-rc7
> 
> Jerome Forissier (4):
>    usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
>    usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
>    usb: udc: re-import udc-core.c from kernel v6.16-rc7
>    usb: fix build after resync of DWC3 with kernel v6.16-rc7
> 
>   drivers/usb/cdns3/ep0.c                |    8 +-
>   drivers/usb/common/common.c            |   23 +
>   drivers/usb/dwc3/Makefile              |   57 +-
>   drivers/usb/dwc3/core.c                | 1780 ++++++----
>   drivers/usb/dwc3/core.h                | 1120 +++++--
>   drivers/usb/dwc3/debug.h               |  432 +++
>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
>   drivers/usb/dwc3/ep0.c                 |  737 +++--
>   drivers/usb/dwc3/gadget.c              | 4152 ++++++++++++++++--------
>   drivers/usb/dwc3/gadget.h              |  124 +-
>   drivers/usb/dwc3/glue.h                |   36 +
>   drivers/usb/dwc3/io.h                  |   29 +-
>   drivers/usb/dwc3/linux-compat.h        |   16 -
>   drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>   drivers/usb/gadget/at91_udc.c          |   46 -
>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>   drivers/usb/gadget/ci_udc.c            |  419 ---
>   drivers/usb/gadget/composite.c         |    2 +-
>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
>   drivers/usb/gadget/epautoconf.c        |  289 +-
>   drivers/usb/gadget/ether.c             |   21 +-
>   drivers/usb/gadget/f_acm.c             |   20 +-
>   drivers/usb/gadget/f_fastboot.c        |   10 +-
>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
>   drivers/usb/gadget/f_rockusb.c         |   11 +-
>   drivers/usb/gadget/f_sdp.c             |   12 +-
>   drivers/usb/gadget/f_thor.c            |   19 +-
>   drivers/usb/gadget/udc/Makefile        |    1 +
>   drivers/usb/gadget/udc/udc-core.c      | 1096 ++++++-
>   drivers/usb/host/xhci-dwc3.c           |    4 +-
>   drivers/usb/host/xhci-ext-caps.h       |  158 +
>   drivers/usb/host/xhci-exynos5.c        |    2 +-
>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>   drivers/usb/musb-new/musb_uboot.c      |   39 -
>   include/dm/device_compat.h             |   13 +
>   include/dm/read.h                      |   46 +
>   include/linux/compat.h                 |   15 +
>   include/linux/usb/ch9.h                |   25 +-
>   include/linux/usb/gadget.h             |  520 +--
>   include/linux/usb/otg.h                |   10 +
>   include/linux/usb/phy.h                |   56 +
>   43 files changed, 7659 insertions(+), 4091 deletions(-)
>   create mode 100644 drivers/usb/dwc3/debug.h
>   create mode 100644 drivers/usb/dwc3/glue.h
>   delete mode 100644 drivers/usb/dwc3/linux-compat.h
>   delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
>   create mode 100644 drivers/usb/host/xhci-ext-caps.h
> 
> 
> base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1

We have run usb tests and we can't see any issue with this series.
We will retest when this approach is approved and rebase on the latest/greatest.

Thanks,
Michal


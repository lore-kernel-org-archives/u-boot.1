Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7D3FD8741
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 11:47:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99AED841BC;
	Tue, 17 Mar 2026 12:47:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FZPt4S+T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13BE0841E2; Tue, 17 Mar 2026 12:47:16 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F6183F2D
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 12:47:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXWWydqwerf7eY7FZhBsztLHhZCEOHk3S+uzR931FiJJSRetQ5zxDKFUquvdOy6xgOM8GMDdIZ5MzryMmij8z/FSac4jMONnoWThdpsp8smOtKWXxQlHcItumM0MCXlhNdNAYQaHM3L6SCSBwykjGFvp81AJUz2XIPjmxn4fjoUdhbkeNM/9DgjD5m5xQfQlRI2M8iiJB0nFUHeUF5ytN6cuWtVzMvlUfRDEjy8Q+ehAtB+1bQdQwnahVuldGam3E49ydGocR1qZDwwffKITPHBfXJVyF/A0lXTrERxVU32Xa5UlSSBhIHyZV5tiz5N+k9qpj/jEv1Y/ZESNxUUCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQYX8VgbReiiZw6odMttvTosZMck0sMzo6GQ8qhA3rE=;
 b=K5/ziCaNwZ/neIhz59Aswn87pbyb99UPiHn2PXxk6y++6JDiKTuo8NygYRcXGiVKZJkomk1iz5snVQrYGYFlbO2bSEcPeBmA2isJdIHBpJNwu+FC2cJ4YGMEbwYSTPdeWtT8B6FTVYiyA8RywczUvM5CzeLEYh6jMk12L1ovuf5JCqUX4q4w+j5/8FFidZt4suktWRkATPaMzDBWVRbVLE09RLVu622ksNaQcPaONoicwwD8mc9ZK0CLz5aRrekCyMsnINVYiQIRCjicfskzJjfzMPp4OWMay0SKwCm67TMd2+dZ217BdaJQKLjw06jcMXbAEShZt3lDUxvvhJ9plw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQYX8VgbReiiZw6odMttvTosZMck0sMzo6GQ8qhA3rE=;
 b=FZPt4S+TC9CsofUDFd2+NHXJQZCtb6NZ7pFgelHOfQdSVRPbLmKey/3bJvSKRKb5Bj3w4NOpyGEqW/ACJ9x8+yCqPZEj347WPrC18IhJaLa/3mmAXGZ5W59ZiTlJJqin0ATAoZskIYfjALQ47tX3rM8alQZQ+TK++k05McuYEDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 11:47:09 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 11:47:09 +0000
Message-ID: <3eaa18a4-1a82-4775-9453-43653d0eb0f7@amd.com>
Date: Tue, 17 Mar 2026 12:47:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scmi: Rework SCMI_FIRMWARE implementation
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 uboot-stm32@st-md-mailman.stormreply.com
References: <20260317012414.4162304-1-trini@konsulko.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260317012414.4162304-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b9e191-86c4-4273-9f75-08de841aeb8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: xiz1sAvZviNtq5PY6Gh38jt89j1OsWe3mpD8xtUF1TaQVyxtcfTnoFsYhfLMsytiE1mayrW5wt8p2CQD3NYnvWaszyEV3z0Km8qTO4dsbayz0MYKOCpW2CN/Bg7HQbO9j37T3SREIYNZHPsX4Hj6LS9eMnPqSUJr4ZzYqm2sx8FtWkUXVEM1gN2QU5L0RcKtjeEBNj+j3oDmihjieP1yJwjPkdElOKVFu9iRGkzJyVwmOk/1gFIEzCqTwFFdFuiKquAEQkZMDb+p+RxfYPjWgXoZx1Kn7XX6TUdMBX5YBRAw0H3+mGltUVwwvY8obUJcWy1uDCwxgBC4Jz0zOb3oJ5cXYeqnVRrYE3F5lhVziYOJ3N5wxNfwVit8n2fd4biA9qvNUHv90PZByydO3+0v9vjDNgaLe6rsg68FiG6HlDkiisOYcLyZur1hFOU5LscSglYUkiF2kkwPp/bpQ820/OQdMFozWLVDnx6yYdZweTl8/A+H7IBBpX+Fu3NCgVYAKzJGs6GDzQdBEhD/AzkjEe8NrY7+RYfec945jQy1TbNQm9yX2acpaYBimmDFDUZoqCNIEqJ2xcukukiIqlow7cBIWHRLPzVzkWuVyauYluQ2EekiIXiUeR1LEDYFJ3WzlCgzMA8YqPPVTOHH9sAVhnkXGQm4yyvKqMs4GtZB0ehuJ2R2ZPNX6CAovWoeyZ6hcKpdTglicoHvjIXIiBqnbw47UfnQ4ECh3rxZL0JW/1A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDRpaUp6ZHNMT1FDQis0bEgwUWhYODhPRVhTcU5mMDVsZC9YOHRGU1hKVXMr?=
 =?utf-8?B?N3dXU3NBeDhpUVY5Mi9oMXJ6TDlTR0hCN1Y5VFQ4TGh6eUJzVnBHSHJ6alQ1?=
 =?utf-8?B?eGJNL3hDUFAzdUlNTEEyMThocDJRNkJNZGZaV1g5d3Zoa2p5NGgvaVhTYXd0?=
 =?utf-8?B?SnNnV0pMWFJwaVFqWVBEWkdkd2lqdWJ3Z0szK1RRaVpGZjFGSGVEZ3VvK2x6?=
 =?utf-8?B?V3ZRQlhTSmFmamc4UHFoUnhEOXlIdkE1dFZvbjh1R1VoZXNUdmpUUEUrWFVr?=
 =?utf-8?B?Mms2a1dpQ1EyWE5weGRLa1BEZFl2UVZITkFmd2NweHQvYXRkcURxWGd4RFUz?=
 =?utf-8?B?Zk0yU2U4TGJHSndkcGc5YWhEQVZJM2prOUdUWjJMRlV0bjkyZ1hLWGFYZy9G?=
 =?utf-8?B?Tmg4QzZLQ1NMM0kySHg0Q2lBWWJMNEtwYW1wOU5hcmx4NkJqN0g5anVJYnZI?=
 =?utf-8?B?Mko2ZDVwM2ZDd2NhZENqWTlUOHdabkt5dG55WHMrUTNrMUFNOFBqeDVCcnUz?=
 =?utf-8?B?azlabk1yMUdWdXFQR3FKUDdnRGxReDMraFJqSzNaTTNjVXNWeXpXbHpWZ2xB?=
 =?utf-8?B?MkdyaURxUFNEOWE2WDlwWFVBUG1acGNlbEExbHdIazU5eGRKNWg2K0dNSmYy?=
 =?utf-8?B?dC80L1VQa292cEZ4RXVTb0d1ZUlHUmtBYnFwMWYyQWZMaEJTYTVoLzZxUyto?=
 =?utf-8?B?VmpQWms2YVlBRVhPVDQ2ZlhlNnpaVU1iL09DOXhkSVo5eHk5NlBBRzAwZXJ5?=
 =?utf-8?B?blVWQWtHb3d0ZWFaU0ZvaTIzTjZXQnptRmkvcktNVUNpSjk0Vmw0YitXRkFj?=
 =?utf-8?B?anVXTmFVSjdRMkVvcE05dERDa241WlhxN2VRenM0a3QzU2pIOWoyS040SU1m?=
 =?utf-8?B?UkdkWlhwSDF4SjFzdmJmNFVhZy9DbkNQNDVmRXJkSm1NWmY0dmlUS1VQeG9p?=
 =?utf-8?B?ek14RDRidGQ0Z25aRyt4bG5iZ0VLRkY3NWJ5M1VTS0N1K20zZFlSUmJQdzRp?=
 =?utf-8?B?RnM2cEZ0YzRiSUw5N0pvVkF4RWloQWp2VnVwODVIbkx4dEZJNDRNWEVBOXEr?=
 =?utf-8?B?eGloSFhUeFdTaWZQS1NVV21jUEpJY1hrTDVzTkVyb2tKSnhrYXpsNFBXb25z?=
 =?utf-8?B?K3VjRm9iV3pVQ3c4dktZemxnaEtLL0MzRzF3TjlMUHZqMUE1eThDVjB6Z0pq?=
 =?utf-8?B?YnNsV2U0YTB2akRBRFFibCtZRWxTYUh1K0J3bURlUTF1eXk2ZHRUTWVyUHh1?=
 =?utf-8?B?NUpmOW1zREdLMng0VjFqcHgxUHp4K051NUUzQVN6NWlHZDFGcHV0TGZEYnZl?=
 =?utf-8?B?Z29HUWt5dzhNOGhGbVY3YUd2TzV0akp4VVZrak05RXl3YW8rcEdveCszc2la?=
 =?utf-8?B?aWNxaUZMTmdmaUV2d1FQQXlveTg5alpZWXQ3Nyt0Vjl4cEtEN3lWVWhwR3pS?=
 =?utf-8?B?N25UNytRS1Y0TEZmRmY5OHJVM3ZpeWJ1VlhTMlJtSlhvWG5IbXVTWnhab2Vu?=
 =?utf-8?B?T1hUWVFueU5KSXJxa2kzS2p2bndvZEwyQ3JUaGFQTXgxbFJqVnJCNGZVQ1dX?=
 =?utf-8?B?dzZvQ3VHMnJuenNHcmcxSldpQWkzdUsxdDI3TUIzMVYvR0FWSVZpa21EYTlL?=
 =?utf-8?B?WThYTXhIemd1aUVjQ0tmRlVIQU9xb3dYYXZOTE00eGx6VzQxNmU5SmdISDQ4?=
 =?utf-8?B?YWowdm5hTHp4dm5OQ3ZLWngvclJXNHlQTHVadmxZbDZOT1lmUjZoOXNUM3BH?=
 =?utf-8?B?T1pmaS9YM0w1a01qbmp1cWl6QTFvNzJMWFBnTnVJMjcvWTJtbW5VcHZwdFZj?=
 =?utf-8?B?R25Pem5yZ3FHeHhvbWVyTWliY1k5d0ZYbkNuM01CSDFkck04Ni85ZkZaL2tq?=
 =?utf-8?B?ZXY1WUJydmpYYlpLdXlNVzR1YzZyUHROUEpieWtWR2ZoZVBYUmp6ZWM0QzRm?=
 =?utf-8?B?QVQ5dkxSS211UTVsMWE4NFhHUVE2SHkvMDFuMkxZTVhLSFZPY2lPS3NqS3o4?=
 =?utf-8?B?WVVMQ253QUV5OXJOVGU2eDErM2ZFNVZmcCtYN0czd3l2Q2NGdjJ6LzhjR0Vu?=
 =?utf-8?B?bTdYdzZ2QUdOeDVjZjB3WnpkVTdWSzRaeGVPbHpqc0VJMk1VRDJHRGR6c3JX?=
 =?utf-8?B?eG9paHYzTFJ5ZnZ3cHJTZm01bWV2UzJsdWw3RGFjQkgxQkhjYnJMNHVOSlJh?=
 =?utf-8?B?cVhoSW9KSHNMblJqQ2pzVlcwRmlKajN2aVhLOHJHR2VSdzZzN29oWUkyTEI0?=
 =?utf-8?B?M3lpbTRWR3VlUlY0bEZUY0FVaEhxd3o1SWkvYWlDNDZXSlN3RW0zOHZUdThX?=
 =?utf-8?B?UjRsQU1ZcC95dWFOaG9lVnZIQjg3b2ZTUXFQVlEycGZERkUxQittZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9e191-86c4-4273-9f75-08de841aeb8a
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:47:09.0361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AYP2CYJb5170oCAZfh3r7q0s/NCMzLPTtjZL5O4UNY+51MJrPl9yupoMuy+JbAIQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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



On 3/17/26 02:24, Tom Rini wrote:
> As exposed by "make randconfig", how we have SCMI_FIRMWARE today is
> incomplete, and in one case, used incorrectly. First, SCMI_FIRMWARE has
> a build-time dependency on OF_CONTROL being enabled, so add that.
> Second, RESET_SCMI depends on SCMI_FIRMWARE being enabled, it should not
> select that symbol. In turn, a number of platforms need to now enable
> SCMI_FIRMWARE explicitly and not rely on RESET_SCMI to enable it for
> them.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   configs/amd_versal2_virt_defconfig  | 1 +
>   configs/r8a78000_ironhide_defconfig | 1 +
>   configs/sandbox_defconfig           | 1 +
>   configs/stm32mp13_defconfig         | 1 +
>   configs/stm32mp15-odyssey_defconfig | 1 +
>   configs/stm32mp15_defconfig         | 1 +
>   configs/stm32mp15_trusted_defconfig | 1 +
>   configs/stm32mp21_defconfig         | 1 +
>   configs/stm32mp23_defconfig         | 1 +
>   configs/stm32mp25_defconfig         | 1 +
>   drivers/firmware/scmi/Kconfig       | 1 +
>   drivers/reset/Kconfig               | 2 +-
>   12 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index 94dce5c191c4..8cc210946539 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -80,6 +80,7 @@ CONFIG_CLK_SCMI=y
>   CONFIG_CLK_VERSAL=y
>   CONFIG_DFU_RAM=y
>   CONFIG_ARM_FFA_TRANSPORT=y
> +CONFIG_SCMI_FIRMWARE=y
>   CONFIG_FPGA_XILINX=y
>   CONFIG_FPGA_VERSALPL=y
>   CONFIG_DM_I2C=y

Acked-by: Michal Simek <michal.simek@amd.com> # Versal Gen 2

M

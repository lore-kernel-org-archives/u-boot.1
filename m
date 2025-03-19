Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 960F8C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:33:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 327DA81E8C;
	Wed, 19 Mar 2025 16:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wf9B2Klb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2C6081F7B; Wed, 19 Mar 2025 16:33:10 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9729E8141E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wj1bDgvLkBNBNVNNFpu55vH6R9L3q8/obUTwdMhB4MG+6yODt7hDLEP+020jT+aXdNk+U/k6BqyPxz2//37bYsc+/iU5tHmbJMGU9/G3XX2EJZuxDWJaSvuDQ2rJTNEEccaGYE18IfsUd1P8MarzyZDk45mObtZdBJmRzze9yC1jNs5EfZp1dwNXvG9CZIfzFeUiK9WJMI3OychPRPicA7RMvOUnaMtbIbGgHyAYVNgBwztNe30ONZYPvoaOXC1Z59aScCM01YgHXcXxngns/BnJYHErKCwPcT6MqIcrAAPY3pZU6DXDce2UU5vSCOZcZAf0t4za23scGdCXamUdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8WNFB+wsb+U6481Mm2tr/Mae9g+8lMc7Qm+kFpoQII=;
 b=Aq+OLHhjPO1qLxEAVwtY76q8gEZ1B7kWwf6f4Jwb4Jqgae6NaFKdL0bDjbg0xksZS6VwQN94xZv0Gb0+afuU4Aog/l16mURAsvWSHXDWpfM1/Fa7Gc7AnaGLy9PG/WkUsAsVmppxywsaTgQx62uyEzMyXRzTR2cTHDAJfpbBHXJygS4QH6gQS1fno4dNSyKkRI2Z3w92PlFEVx5NOwtfOo8kATXN+4S9J16i3IUBvlyKgQnlWyE/Z/eY76634i3Ypyhf5ivXCJcynHCyL3Vd04hJysXWSbcG+n7xhgUyHlocjCaZM2Z/HWFhi3TZj6LlhiQtjO6HxmAAXLh0h9a5nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8WNFB+wsb+U6481Mm2tr/Mae9g+8lMc7Qm+kFpoQII=;
 b=wf9B2KlbfFD9b4ApAka+FSElFN+2B7y1wznp59xaQhZ87B1M1GPxmiHhgI954HAj2+FRK8wl1IeEItRN+KtokIj5O2fKcL7+snfv41OBjAcxAPBiYbwVlveaBeWElDtjHGHXeMnEc/eVOIzXXpX1wla11fZmexuOxJ+dHhOJlyY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 15:33:05 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 15:33:05 +0000
Message-ID: <b72549fc-eca8-4847-b222-746d8817d46e@amd.com>
Date: Wed, 19 Mar 2025 16:33:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: Setup default base and frequency for Versal
 platforms
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Caleb Connolly <caleb.connolly@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Robert Marko <robert.marko@sartura.hr>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <86edf3dbb6de16337aac36f5121f306f83149fc0.1741868624.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <86edf3dbb6de16337aac36f5121f306f83149fc0.1741868624.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:208:32f::35) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d63ea2-2c6d-40bf-6332-08dd66fb57ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dEkvRG9EajUzMnZaSWRrWGx5TGMrZ21mR3RuOUplRDEyeTRaY1VoalhMRk5q?=
 =?utf-8?B?TkJEdWc4QXlnOTZMQU0ydXVQbi9HYTNXeEMrZE0zM3oyT280UC9LSE8yZGZC?=
 =?utf-8?B?dUNlaEcrcHRRL1ZHQmQxRnVYT0xEUk9mM1g2Tkg3YTFjeU9VcDd4cEtpdkRD?=
 =?utf-8?B?TXZEUGI3Z3ZpK2ZiMnNkNFJteXBKZEk3S1JSdXliOEtSbHVwZWd5QXE0T2dl?=
 =?utf-8?B?OVRsamRodFY3d2lNYU5nQnFKSHNaTENsdERJSUN2Y3hTUDNEcVpOUmoyQkkr?=
 =?utf-8?B?OXE5Smp0ZXVkOVg5NGtUN1JaTXpVanI3OTllRm9wcDJrcG85elkzVHVCeVJh?=
 =?utf-8?B?c3FPemw0TXluRy8vSmNtKzFCK2ZBU3NGMlVLc0pZSDlQaXBrenliVTkxZ2l3?=
 =?utf-8?B?R2t4aVpKZkVaYUxjN0pWRkJpRkE3M2c5WFlpUHkzU0JNUVRxMlF3ZzBQL0ZU?=
 =?utf-8?B?cDVkdVlJV05EZkQ2ZFhMNmkyUktFV0JhSzFYS2MvTzRnNFRmWFo1MWZ3SldI?=
 =?utf-8?B?KytJODhTTkR2UFpPR0xKOXZRVEt4QllaNGxZcGNxTzRYTFlRS3dqa28yRnVH?=
 =?utf-8?B?Qlk3YXNKRkVRZmExWmhLWkhLM1h1cGpqTE1lS1ZDTmNaclRacUFkTHdteWNw?=
 =?utf-8?B?Q1p3c1cvYXBmaHhzNktLd0Q2azEzNGloSm1VRGZleTVGeEJoK3dXbkFDVlJ2?=
 =?utf-8?B?RlZhNVE4UW9mRDlnVmRSakN1VC9oTkNVZlNKSWRrQUVtZFJIUjZvcUxqU0d6?=
 =?utf-8?B?YmVOTnc5Q2E0SjV4d2VVUVM2WlNxWTU1bUhwSEdmMVZ6aU9uSGg3cjAyRGEw?=
 =?utf-8?B?dWpuZ3ZGdmtiZ3JXRFh0WjJMd25vL3MyeVhOMUV2UE9nUkVlZlZTYUMwY2xP?=
 =?utf-8?B?SnBNOHVuYjVsV2dPWUx2TlIrNWxOZlBkamtvQWduUXc5K2lDZHM0NFd4N2FM?=
 =?utf-8?B?Uk5TMkhLeXV5TTZISXkrcGNJazlNb3lyazdad1pPTjJaZ3BLOFo3ZzlPWEl0?=
 =?utf-8?B?MThGTHBveG9YVnN3bHZlc1krSmp0SVdaNm1CN0dUQmYvQVRjQmN6bjFSbnhY?=
 =?utf-8?B?U2M2QlQ3OU04UFZIZUp0dWpNcExDb3E2bDJ2aFlpdGpKYkQremdDYXNoVDRq?=
 =?utf-8?B?bEFJcGJsV29BaDlPQjBEM2tzVTBlYTFTOUdGM0hveG9CeXcwbEVrTE83WU90?=
 =?utf-8?B?emJiTjBmckswUEY3VlZvbS9wNDdDdVJKaTM3dVdTWWlibGJIeVFBNnRjWkt5?=
 =?utf-8?B?a0hSbExqMUQ3S3JpQU1UdjVTZzNaSUNqZXh1UmRBM0wwVEU0bmpRZEMzV3E5?=
 =?utf-8?B?S0FJRW53UHFkSnllRlpTc05hNy9VMzVjUEM3Zzloa2I3VW9NS21KN2xSMzFP?=
 =?utf-8?B?VThFWXhONmRZWi84T1BycmRDMm5qTmtpMG1BQlBnUmU3ZVRuZHVlQkZGKzVF?=
 =?utf-8?B?UW11cG1QdjQ3dGFCTnRObTBXRGtKblpUVXhRRGd4QWgwM3Vidlc2Q2xiMlhI?=
 =?utf-8?B?RWVJNFJMUDIrMmpFU1FVZU02em9yNy9IWmphL2FIZE9EZ3dialF4NzE3amVm?=
 =?utf-8?B?azdiWG93MmxZVmdiV214TnBhWHJxQ3cvN0Z0VUhNcmhuZlFCNUwxcHF0S0FB?=
 =?utf-8?B?OUV3bXJwSVBZQ3h5UGdZK1lWMnJSVTUzTjFBVTNmVUdXa2VzT2txclEzUnQ0?=
 =?utf-8?B?bCswNTlaYjNTZ0JoTjRxWmxmZS94MUNLdlJBcVFRVHpXOTdnbFI3Y01GTDY2?=
 =?utf-8?B?ZUh6eHZGK1JJQjBCOVB5bFRHRWE1aWpjbUpzN0xmejRtY1dTdUZBZ0VPMklQ?=
 =?utf-8?B?NllxNjM4VTNxNHRieDF5VGZvYkd0NzcvSVBaaHpobDJoRXZOcjRNL2JDQk9k?=
 =?utf-8?Q?UGJDKIoBL4pFH?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDdtVy92MVp3MzVZQTlVTFdXSWdCU29KWkFIbHYzK0FSaXB6WUFRRU94aVNr?=
 =?utf-8?B?VVVNTElsL0twUWZ1L1hyUEZJUnV0UnJha0pnUXF5ZTR1djhjbnpKdGQya05M?=
 =?utf-8?B?M1B0ZUdnYzM2ZWpiUmo0SlN2cnBTYVF4c2lxMzgxaHYvUVN1cmdhbWdPLzgx?=
 =?utf-8?B?VTRLVWhCRzMxRGU3T2tQYk0zbzJDVnR4dzlKYkVKOEw1TTJDT1ZnL1dUakxY?=
 =?utf-8?B?OVQ5cnFlck54RHF0QlUxWjJzZkdLUnRQcmhBaG9xcFNxQnNhdEVRaVRreDg1?=
 =?utf-8?B?MWJ5NlZwWXFBVlpnTG9wYnd6bHBxUSt0NjFjdzVnb01aL1Q1QU53czhYTmNK?=
 =?utf-8?B?aWxzNVN0d3dGRjlvZnRIalVNUWoxeXZOY2NWR0pMSENoelpzM2pzcVNJdFNC?=
 =?utf-8?B?MkV2NmpmWHR5U3JkQkVOMGFEQklSNXVtcUtybW9QSllXdmVvOTJlc2d2VnlU?=
 =?utf-8?B?ajd0ZHowcDJ4VlBrTG1zTFIyanpHT0czMHJMUUh3byt2d3MyZ1dwODRTWnFP?=
 =?utf-8?B?K290eU1Eb0NWNk9IT1M2Mk1XYU5KU2R0ekg3TjlLenRWUE4zRFR0OXBVTzFl?=
 =?utf-8?B?Z2VBZ1BmQTc4WWR0NUNsNWRTZjdUSkIvSzJDdjI5Yk9zM1NtQ2FiOVYwN29j?=
 =?utf-8?B?WDBqaXAyenVzalZRK0ZJakVjbmh6UW9VZERxT0xSbXN2R2pZRDh2N1oxMHpM?=
 =?utf-8?B?ZGlQbUltOFJMTUUzUFNIcWhkemlmbTIvOEd4ZzR4TDBQUXZsUUVpYktqZ1Vz?=
 =?utf-8?B?Q0VYQ2ZmbUVSV3kxNldJSXN2SWZ6VXE3MlNWQkYzYlFCdk53R1hsSUR6OEN6?=
 =?utf-8?B?MG1jMmdSbnFBbDhlUXFTQTFOMG85RmxlWHBRSWgyMzN5Q045K2g1Qm00N1RC?=
 =?utf-8?B?QlN1TTBsakIxRVJCVGZ3a1JLbDZEREowa3JuTzgwMEJRbHBkU3JwV29FdGFh?=
 =?utf-8?B?SVR2TDE3OTJUU2s3OTZHYnEvWWVGRE1ra2luNFZoNm1JVXV2REs2RXhRbDV6?=
 =?utf-8?B?cUg3eGxJUFliRmNOK1BkSTdmRDRnRFBaOXQ0S2s3cFBRMmEzblBkZEcrbXdD?=
 =?utf-8?B?cmQ3NlppODhLc3cwWDRlbk56YW1XNWp0WjJqK0tMclFDR2RNdXpLYk80dTg2?=
 =?utf-8?B?cHlwYkFqNXg1NFJxNldqYXplSjVBQkt1YnZEc0FGU0VXWHQxVkVMZktUeEJJ?=
 =?utf-8?B?dGlJMWtyNDk1TmxyeXpscEVHTkgzUGROQU5lNTcwdDBnK0cwbUxWWnhFd2Zz?=
 =?utf-8?B?TnA3QUk1cGZCbWgreGJOQ3BaN0tSYU5lenkzRWgzUUtkajZRVm5YWXpra3Rx?=
 =?utf-8?B?NTVINzdBSlVGQmZNeGc4SXl0Q2E5YnBoYkhHdERXRzh0V0tNMkI4b296RFRX?=
 =?utf-8?B?UlBHV0R0dHJQTktUR1gvdk9zcmJHcEM2WFpkWFI1YVJXZHczTy9jRUZ5ZUhR?=
 =?utf-8?B?RjRPMWQwRGpVbGIxUUdYUXo5Z1ptVS8vOEZuUnZSS1BIQ1dydjRXNytTOXlM?=
 =?utf-8?B?UWVrTFJBelAwckhYQkR1TmNBcEJrRU9IaWgyYXFMcytVQnpQQVNMQk92Rk5X?=
 =?utf-8?B?T0g3Vlcwa3M0amhKeWVoRTBTa2pYRWlFYUNTejJGMWN1WGRLQVM2eVlISnBJ?=
 =?utf-8?B?d2hOd3FnVFhSTVhXenNtdW1XaGpkeG9pUjFjcEdxajluRXVmdjRQSFpTaFRp?=
 =?utf-8?B?akJqVlIxYlZFay9neUxxR085Q3VlYTdramVLVytURTY1SktqdmloZEdZMXBX?=
 =?utf-8?B?Z08rdmJlWSs1UXFMdFN2bXRNaU02Qk5XTnlINVFzTGFGcm94YWNCTHVEMTg0?=
 =?utf-8?B?KzBNYzlvdUk2WTdxVkVVdUpHeG8xT2NUWTgyYU96OFRXRjFNYS81N3FMU3pF?=
 =?utf-8?B?ZXgwZG1YUDNMem9CUjJZbTNUWlczMXVpNnY0N0RaOVhZRVQwOWpRdXhTVi9o?=
 =?utf-8?B?SExvODd3QjVsSVUyV09zWTVtbUcrdms3cWo2YU9jRzhCdGZQaCt1eG9HSWdn?=
 =?utf-8?B?cjJwY1pXS2s1Qk5tdHhGTmhjOUV1UU43Q1F2NmlFNEtkbDZxM2p3ZnAxVUlG?=
 =?utf-8?B?KzBSZ0NzUE1DSEYxVlp1RDVCbDd0Zk1yOVZEK09YQ0hMVmtNYTRsa08zZnUr?=
 =?utf-8?Q?ECRP/uhTE9SYsrzoY6vGy7Ybq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d63ea2-2c6d-40bf-6332-08dd66fb57ea
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 15:33:05.6099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ez2/M4MHGuGroZCFABLwDng/oS7bS7IPEDwjK8ISOhEGG5770dlr6USQTlBNB2t7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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



On 3/13/25 13:23, Michal Simek wrote:
> Add useful default debug uart values for all Versal platforms to simplify
> and speed up debug uart enabling.
> The similar change has been done for Zynq/ZynqMP by commit ad55d99e3cc3
> ("serial: Setup serial base and freq for zynq/zynqmp").
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   drivers/serial/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index c4f4a8d78df1..cb5fdc8711d0 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -519,6 +519,8 @@ config DEBUG_UART_BASE
>   	default 0x0 if DEBUG_UART_SANDBOX
>   	default 0xff000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQMP
>   	default 0xe0000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
> +	default 0xff000000 if DEBUG_UART_PL011 && ARCH_VERSAL
> +	default 0xf1920000 if DEBUG_UART_PL011 && (ARCH_VERSAL_NET || ARCH_VERSAL2)
>   	help
>   	  This is the base address of your UART for memory-mapped UARTs.
>   
> @@ -554,6 +556,7 @@ config DEBUG_UART_CLOCK
>   	default 0 if DEBUG_MVEBU_A3700_UART
>   	default 100000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQMP
>   	default 50000000 if DEBUG_UART_ZYNQ && ARCH_ZYNQ
> +	default 100000000 if DEBUG_UART_PL011 && (ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2)
>   	help
>   	  The UART input clock determines the speed of the internal UART
>   	  circuitry. The baud rate is derived from this by dividing the input

Applied.
M

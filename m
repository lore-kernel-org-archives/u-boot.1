Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCCAC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 05:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2EE2B60750;
	Wed, 22 Jul 2026 05:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OqDBnlcsw4U6; Wed, 22 Jul 2026 05:31:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 10EFA60724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784698261;
	bh=8K5cHizTmxDSjdzf4zcaWtzgCCvbcbdLoVp+c/4/FCc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=RELEsYAZU/odT9IGccpC6M8q4B+33/6hm9O4EX/pO+sA6BpWZjtpbVyeTsdgQmGyu
	 s9l3vw98oeaPmhJ2TStqWwN3PUcL223JuhdWK2Ih1aaTT+fb7OcCMHzxz1OPQWvsDi
	 8qiJwY7FHSfqNdZY7B8mST1j+qXvIjcIGnBDxAz+uw6ywvRX7z+3FbFPRtQgB9BqfE
	 UaJt9exkqbKsfYty2TV7ti7MSP/VFgRrMKRtq1IPXhhbcfOGt4NgsXdDnc2OQ8DuSu
	 qJHfAbcLXZQd60PsaJrByUWzqICK1DmYCL8uIZsW34xqV/TmpZKoLlFisrHOmoel/C
	 3ylTEmBY0OBOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 10EFA60724;
	Wed, 22 Jul 2026 05:31:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0C1AB109C
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E5DF580C59
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id osMqCaj77n73 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 05:30:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B556180C31
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B556180C31
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B556180C31
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:30:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkvEeuClR/J4TIfDKPldW9/G6mpZRbQgLHtPlmjeCDW8nc3CNtnxlR5XHW5fc9s2WhqgxG7TOQ+Z7Z0lAseA0E03kL1eFMEHqa6VuFnF299ZaXsgWMU2KEbIEMEu7nlyicenP9jwJbdgk5raCrtqticCdN7ITEDyDVW1pymo053/9TUNLYAGpuGvs5oB+tEtj/v6iGxC3c357IOZ8seuQr6HxrbV9mWrt20QPxoGvr4/LvHbkPNWLOTM+IE4MhVTi9L0QHajNol53ugn1rXY9E2v8pewgCDIQ1JLnqV90/GjIZUETs7M2Oqd0zcA0kPSNVMfUWOZ+KgyFsy7WV9NFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8K5cHizTmxDSjdzf4zcaWtzgCCvbcbdLoVp+c/4/FCc=;
 b=rmVKzI4c0/8C0QeSX41loyHvEvkZ1NtT5mQ9LLsSH6DcxC3DrMNpQ3iwcqIWUtNOnqITXCg7mCs79sAIM7koXEYy0Awbu4S5yWBok/t/o3RFgl5qk4gQg0ngVH/J099wFnCYiX8YKeJa7d8DGcjlcb+MXoqNf63s9f6ERLrQiziaDilq8wxPOfIiATM+3xzh2eSUL0SA+G8SEY7fLXqKcG7U9iDGDbU8di9J1KzX2GRuYh+0Nvp+Sw+9GRXyZz6b9V8Sr0A3LwfoM0fokCB7qQC3TjqM5u6hnMP7GPkbsrHtDEop9eWan2GHGCnYNx0sO7bO6boyp+e/Qs3k7W19GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 05:30:51 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 05:30:50 +0000
Message-ID: <853abbc7-4f45-44f4-a935-64cebb4479e2@amd.com>
Date: Wed, 22 Jul 2026 07:30:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] i3c: dw: fix slave device setup and probe issues
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: git@amd.com, padmarao.begari@amd.com, u-boot@lists.u-boot-project.org
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
 <5c6ba716-263c-4a79-aaaf-ccf714050b75@amd.com>
 <d0788bac-8527-4236-91d0-476479a92fb3@altera.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <d0788bac-8527-4236-91d0-476479a92fb3@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0012.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::17) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b605b29-e995-4fe9-7320-08dee7b263c6
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Z8qu3FUgy3GiOaHY7oLKui/x4Lb7e4AOlNijkBxehb9LXtsbTjvE8I+22MoX1Ff7yzZoQmAzWhzZtHwl3BW/6+SNDZrjIHoC+CFOREYjin9jlilJTz1FVhbT5Zfy4zMMrzm5n1D4CC/hVQstpwJQIZDv74/mYMOQ5KZu6kTi7W5pV2JYLHx7WW92TGtmbPwJGL9aiwyt/2lya++pzQ0RUDEfFy2bNqbKnTn1/FfI9so6cy3J5nN+75YFQ1Iq+B1cVm7J0zQrGKTp05bWt/zU+xylGmkMzs9q38XCkGj0s6CofBYWCVW9ANOLianpKygRhDH3X5X5mAgPN5/Xh7V4bUOkdBGAO5uNpAgQMXe6sT//hIHN6m2mMRU9wuj0wB0r9vZAeFm7uSQ1ewovIp4r4ij7CyU40pWz9xSggtK6TMwoMaV0TNiIxPO4V9cWlfuSiS6vG78QNhB1c2QzL9dq0NMJzO3S+zHArwOC2BWEMlLkuPCPFRZxECgvh7k9i/yAzqVPL1EywoA0WptLr3bI60PDb/X5s2znlNnh6ja/WBavieLr61x+WKibk/bQpY6cJryBAi8GDL1uEc1oHtzw6W3Xp13H/PN2ulv28L09cwzA3KvhVo1cphoZyaiz0N1/RbcB38BBpyhhRh5CrEov4bZaFYTjKktyCCUx0pOKoCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGdxRUJnVjdvSE9mbHNVVEZneU42RGhKQ0dIR1NLTUY3WnE5SXlaNlA5OFFO?=
 =?utf-8?B?NTk0NXVxM0lSTEpuUGZpNDdPb294OS9rNHUyT2N1TjBlRkhmcnUvMTlIL1lG?=
 =?utf-8?B?alkzbmhmcFZuSStVeTRPTEFXZ3dIeVJNeFlzSDVMa3BML3RnQ3I2Q2FCREZo?=
 =?utf-8?B?eUFCcndXS0R2TzFiblJDVmtmS2ZJRk9vQmFuQ0hpc2pYZ1R1bi91eDgzbUw3?=
 =?utf-8?B?eUF2Y1EyQnJQQzVvWTNLQmV5dnlYKzN5aG9nQ1lTQktvVjlyYmNWTlVpdGNV?=
 =?utf-8?B?alBhc0JjUXY4NUVFQXVaU3NZOUF3cnQ5Z1UyUENveHF1L21ZVmpJK3FXSjIz?=
 =?utf-8?B?VzN5aTRkR1Q2N0NsSDFDM0hjS0RXV2QvYnk0MnNsT0trd2tDVERRdm1URG5C?=
 =?utf-8?B?Zk5NK0NOUHpxUWFhSnlpbFdpOWlrYVJwWWNucy9xY3cxWEZuRXVkWk55N3Y3?=
 =?utf-8?B?MVV1bTZOa3ZOOEFEUitPRkNRa1lnWk1zN1ZHODU2VEdtbXNsNzFuNGErMDg3?=
 =?utf-8?B?WmcrWWhORUJGTFV4WEtIKzZZNk05emkzcDMvbWF0TlFCS0xiZUFVaXNMZGVy?=
 =?utf-8?B?dFM0RE4vOFRZeDdjaGdaZDlDQjhwLytaNzkxVzNJRGtPb2xkSlhWaDZRSVVD?=
 =?utf-8?B?THkxTXd1U2ZoSUZUdjdVTTlrNHlKTk5odWhlanpQT1k0RGtmS3FjWHM5RG81?=
 =?utf-8?B?aUJxT05RZ3ZqS1FveHZUUkJNelV3amxqdmhBRjZZM25tdXBTMlFuWUJNRWhE?=
 =?utf-8?B?YUt5eWZCb0w3eHdwa3paV3AzMXp2UlhUQ29NbVI1S1AyaWVoVWFkYm0vUUNi?=
 =?utf-8?B?eXFuRFNnTUMyTXFYRGswVGdCS0l5L1l3T3pTTkNjU2Nxd0dKdmhHRVQyNHZx?=
 =?utf-8?B?aFQ4ejZraVI4Z1hZU3lXZnQ2UnVOVVZJSVBRZVArdnVNdlk1WERtSHlQeGFr?=
 =?utf-8?B?K2M0bTFJNjRDczV0d1VBNEpHMkR0NGJlSHZVRWZUaldWUVF4eUZ4Mm45aG14?=
 =?utf-8?B?ZURmRnZnOUhMblp0Qll4b3NtQW5TYU5WdVF0MXFSM09QN3NscjRNY2NvUWZq?=
 =?utf-8?B?M3NSNEplTS91bnBFOXlhdmQ1Z3JvUzFnblVpVVVpRFM5aFhqOHF3SXhvREk0?=
 =?utf-8?B?S3FacUhyRjlpTzA0cEVxemV2dm9aUmVtNVFOWTlHcE90TGxrNEI2dm1YVHR6?=
 =?utf-8?B?VVU0c2Vva2s5YjY0OVFsMmNRMHB6dVM4bnRqbzFSZG1iN2d1YkkzUnU4UmhV?=
 =?utf-8?B?STdoZVdKREJvbksrWkVnbzR2RWNNYXhDQjVSV3B2dm9xK0trWm91VVdnc2Rv?=
 =?utf-8?B?QVQrSFVFL0JpTWthMjZVUElPQi80MVk2bFlkTW1jQytHcENxTG9NelRNQXE3?=
 =?utf-8?B?V05sMEFtejZYMUh4VEtVdnhrSkhZYVFGdUVnVmNHSmQyaEhXenE3VGtLTllF?=
 =?utf-8?B?WXZFR25KRURNdS91eUVYcDRlRHNaSENkYUZZWGdJbWdQN05iZzQwWWUzOWFz?=
 =?utf-8?B?d2pkdkV0dkdYQ29URUwycDBmUUZ2UktXUldodnd0SDgzTGRDbTFZTzlVRlZi?=
 =?utf-8?B?Q1dxWmxZWCtOVXNZYW5Ec09CTU5RdzYrODBmZUlZRmNVcjdZK2I2RG91M1Jt?=
 =?utf-8?B?V2h2VGRlZWIzUU5WQ0F3TmNxbmFPSVg1blpoSDdFZGpOZG9sTDdTemsxZ2ll?=
 =?utf-8?B?MXdOWVNZVUNZV3cwbXdiM29hMWNoRGRQWFhKUnU5WFg2a1ZLc2tZK3lPU3FI?=
 =?utf-8?B?Q043MWVWeTBkRWxXOHFrcW91TTg2M0YwTzNySkUza2g0Z2t4QjRBQklvOG5D?=
 =?utf-8?B?dVRPOUpxUXMxVWFNc1lqMmt3REZWVlQrMCtCOHVCd1dLNS9GNk5uQ2syVHNu?=
 =?utf-8?B?MW5uNnM2bXJ1NEt1Z05vMVNDV0k2QUJUb29ZRDZ4Tk0rajliYXFieEM2SE1D?=
 =?utf-8?B?bGIzMGdpUlNtT3ZHYkYzZUFJUEdzTnBscm93OVhMSW9tYTN6NCs1RW00M2lE?=
 =?utf-8?B?aW9WUVlKZmVodzRqQWx2R2NqbC8rZ3BtNmo4T1hCNThwT2hCc2NwS01JdTNk?=
 =?utf-8?B?a1BVZ0N3YkUxbTlob00vSzVPVXZHbEcwWmJxMHdZOWU2SnFaRkVOZVZNRDVn?=
 =?utf-8?B?MGhiaUdEQTZ0a2l3ZFFZT0ZzMytCUkorRUk3aXhKakp3ZjRzclRKMHhPNEd0?=
 =?utf-8?B?Umc0cCtHc2wrNFRFRlZoUU5URmdQU2lGM3pOWGw3NkVuQUVBaU9nYWhhK2xs?=
 =?utf-8?B?THJ6b0dvdEhTTnQwRDQyTmkyblB5NTB1bkludDZzNzhxek5zM3phdUlsZFpE?=
 =?utf-8?B?c2J4MDhCZzdsT3VTK1pHS2FOdzEvdHhTL09RaG9Hc1ZMRWpvaEtWdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b605b29-e995-4fe9-7320-08dee7b263c6
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 05:30:49.9037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAKHRG4qRUgKT/RXXcmsePj5FqfAVwY+6GbStyu6FtlFSuYBT7fTM0J4aAs0LlbD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8K5cHizTmxDSjdzf4zcaWtzgCCvbcbdLoVp+c/4/FCc=;
 b=VaVPFa8aK5kOTJCWOqU6Iw+WrBs3ezmXkyEbuPQLRkjnoTP07XMj/etxqYvfuZuXBS2SU9mrx1nvanRATdJHzPMg0dhjbjlFVtdSmUn2b/2j9aZfTHNAyBdWqcJ+A5DrGlLXl4K2dr5wu6XnnL7KZCgj9lINNog4T1JZtzhIIVY=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=VaVPFa8a
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Michal Simek via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Michal Simek <michal.simek@amd.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi,

On 7/22/26 05:56, Maniyam, Dinesh wrote:
> Hi Michal Simek,
> 
> On 21/7/2026 4:07 pm, Michal Simek wrote:
>> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>>
>> Hi Dinesh,
>>
>> On 7/9/26 11:12, Pranav Tilak wrote:
>>> This series fixes several issues in the DW I3C master driver and
>>> related infrastructure that prevented I3C read/write operations,
>>> and enables I3C support for Versal Gen 2.
>>>
>>> Changes in v2:
>>> - Use -ENOTSUPP instead of -EOPNOTSUPP as the reset stub in
>>>     include/reset.h returns -ENOTSUPP when CONFIG_DM_RESET=n
>>>
>>> Pranav Tilak (4):
>>>     i3c: dw: make resets optional in probe
>>>     cmd: i3c: fix list and current needing pre-selected controller
>>>     configs: versal2: enable I3C support
>>>     i3c: dw: fix slave device setup after DAA
>>>
>>>    cmd/i3c.c                          | 11 ++++++-----
>>>    configs/amd_versal2_virt_defconfig |  3 +++
>>>    drivers/i3c/master.c               |  1 -
>>>    drivers/i3c/master/dw-i3c-master.c |  7 ++++---
>>>    4 files changed, 13 insertions(+), 9 deletions(-)
>>>
>>
>> Dinesh: Can you please look at 1/4 and 4/4 patches?
>>
>> Thanks,
>> Michal
> 
> Reviewed. Thanks!

Thanks.

Tom: Are you going to take it directly? Or do you want me to collect it?
In patchwork it is assigned to you.

Thanks,
Michal

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B411BC3DA4A
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 05:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 841618811A;
	Thu,  8 Aug 2024 07:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NxXXNCOI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169D3880A5; Thu,  8 Aug 2024 07:50:31 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC308811A
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 07:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqadvnG9v30I/rr+gCCvtmcQlKxfVQSzkwL5XCzy9FODsJd22Glhspwl1KgLbxg4CGr7/IN/Sfk9kbXjK8zkrm+bwIRjTNjdyKWRMiYyuiqasq4RpsWbIzI5qx2ZM2ku+wJyTsCSUmSpeRnk+rdPoDhwhUDrWqh1a1S9ORKvaiUvc4B9RY7hmQ4QYlr6jxFdPS8BdHtlfskuNjIzcHGK6UvFEoTIkMpNXTo2EelfBDGoaw31Kk68uRtTLGSYo8yjCIrJsuqH62kiV+Y0FaApa6rA/+7U3FsskgbMrExA9vmWeC7iS9VkFik+DfeANj4DeuJWz6/aIx5P5/waTTOnlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gilTfjs+3qtFKIow19PHci0IXghngkZcY6CD9OG6HMo=;
 b=xFwwNkwMO+1dcIk2ycoeFqgh9UdxwxfDVxkUKj+QibySKBOqn4fy3+mwbqSFZO1bAQz9HzXvpThRJjwgEtl4Vw/c6BetFNyujNt8UWrx2/m3ol2IsvvhbJOqYMtvf1XPqtyXJenfxcBSlE7rl3KtHEURVF/GDrn0wtHv2elwchF4sWdSgdlv2d456NQUivb+4I7/BIVvttr8dgAaoKf4k4RHjf4UpatO/QTyCKP8+ZbMy0R6U21l2zJxCaAk3SbXoS4vhxl3lrBHKALWJt4qOl+ZLM9ItPFFC2gRV5s8QRqPd+X1MoUFT/ycmkPvdoIxX1c5/nUiJnYbf/rbaX/uiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gilTfjs+3qtFKIow19PHci0IXghngkZcY6CD9OG6HMo=;
 b=NxXXNCOItntjfI1QBJabd3IXcDGTdThOGbzIqLP5vDfPyBCzoIyMVRbf8p6FAqouBO1Dq8YuudRRIJ06pBim8DXNEepw7qOcPZ2rlMyIHAF7aLGIIWWIiEqPsPR9WLDWoXEQifi4u3ISJCsioR5xGm1RHTTpwnrwnkgUqFjOpGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MW4PR12MB7483.namprd12.prod.outlook.com (2603:10b6:303:212::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Thu, 8 Aug
 2024 05:35:38 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Thu, 8 Aug 2024
 05:35:38 +0000
Message-ID: <e62e3c69-e9c4-4a0a-bf65-c21082ce7e27@amd.com>
Date: Thu, 8 Aug 2024 07:35:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: sf: prevent overwriting the reserved memory
To: Tom Rini <trini@konsulko.com>, Prasad Kummari <prasad.kummari@amd.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, git@amd.com, venkatesh.abbarapu@amd.com,
 git@xilinx.com, jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com,
 Simon Glass <sjg@chromium.org>
References: <20240806120659.686073-1-prasad.kummari@amd.com>
 <20240807211221.GK1626301@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240807211221.GK1626301@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:802:2::41) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MW4PR12MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: 87513374-a874-4cd9-e51d-08dcb76beeed
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?czN1SXY1VnY0bGk2OG04aXVVZXA5MklTS2ZSRVRhNFNxRkMyeHN0NmJzUFo5?=
 =?utf-8?B?ZndXWHByaGZ6M3hPVlRCUUNibWk1eHFQYnowaVc4MlZ2THRxaDgvUklHalJN?=
 =?utf-8?B?SER6S3YyS3hvVFdwS0kwMk1iRm5leUV0dUwvbWhyUmtQZWZiZzBMTCt5alRz?=
 =?utf-8?B?MzVkalg4cERURi8vVEc2bERRN1lUR29xcmpWNWpYdEwyYjNsZ2E2amZrVTV1?=
 =?utf-8?B?a2FoVFJXK0huZmVKWmlNR3h0Vyt1SWk4ZlFkOXZJa2hiMGJZUi9nNkRlYW1Q?=
 =?utf-8?B?bFdjNlNLVW81RTNUZnNlZFhCV0xHdVF1dmRkNHEzQm1sWmhncEZRRkVZUGRU?=
 =?utf-8?B?cVVIazZIQVJJQTB1TkpkK1p2MzRzTFJPWkVKME1tZkg2eExGTUd3U2pJSnpB?=
 =?utf-8?B?Si9FYTQyMGhYQmJlTmVGU3V1NzdXdWdwRTY1bTRFZ0RsQmdRUlNPZzYrd0gx?=
 =?utf-8?B?VjFuUFZoSHkzNDhvSDY2cW1JNndVOEZSbjFUMG9waXF5b29JTWY4NHIrZWVJ?=
 =?utf-8?B?M0tvekJaOFdFV1ZIL0NqL0lBdEs1RXZLeGhKRjJhYWVjTWJhbmxaaFJLd1Qy?=
 =?utf-8?B?NTZia25FODdtL0taZWN5cGV4c3FvaUhzUlJrcVRlbXVrbnh2Q0RZTnZUb0VT?=
 =?utf-8?B?TFF4d1lkeHRWS1pXRUpkUE9YckVZS2pHeTRNOUNNUjlZOTl6RldXSUc5VHJs?=
 =?utf-8?B?bHU3b2dZWHNHM0pQa2RCZGRkRUJsLzZ5bU1oaG96RVBYN3ZWQjQxSXZoVkpv?=
 =?utf-8?B?UWV0b0hPME91TFlJdVN3YnlXMXhnNzBTREJlbEdySHNzdGk4clZtbGw4T3Y1?=
 =?utf-8?B?cDdXMXRVeXpKOWRZc2xCeTRsY2hQalNiSkJBRGwrbmkvUk9IRHRuUFBaOG1r?=
 =?utf-8?B?U0NPRDJYbXRzbHBSM0VPU2JjNXRMWDd5b0F1b0RrQzh6YTN2YWg2YzA3MFdX?=
 =?utf-8?B?S1pjS21vRzNOeXhxdzJMUHcxUHBYZUlhTFJMNldSdmxMVHNsc1RFVndhMGQ2?=
 =?utf-8?B?dEdBSThxNzlSTlJPOCtFT2VWbTcrajRVVU04c3BpRTFSczJrMEFKWlkzL3lW?=
 =?utf-8?B?dzBOcUdEZmJSdWlWeE9MZzg4NzIvOU9ZZzRrb2MrZ1BSQ2lidnkxVWNoYXh1?=
 =?utf-8?B?L09qejJBQ0pUUW9yREIvOGlZc0t1dTVMenFYQW9tWHNzbFVOT05ZWldxUEYy?=
 =?utf-8?B?OTQrYkN4YWxrSzIzUExiY1J6MmpZbTBUMDNMUHVZRmFqcklWTXY0QVVCaHZl?=
 =?utf-8?B?R081UmxuLytubC9JYVJVRWM1TnlRenEzSWZXWW16ZzhOdlJRNGZCU2lYK2xQ?=
 =?utf-8?B?b2psNWRacnlGbWl2R2s1VTMyMGxuOFpiQjNKRXFBTU9ydjdLclN5NXJmU2Ru?=
 =?utf-8?B?MUdVN0s4RHIvSGk1ellYRnhVM2QwUDR5bmYwVkRPNkxvQnNXSWlqb0RGb0U5?=
 =?utf-8?B?UG1PMkhzYUpmWUNTN09KcDR0ZXB0YVFWUTRpa1lIYnY4eWd6TU9qeGIvcjRG?=
 =?utf-8?B?aVZJWHhQakd0NUduNHV0aXRjcE1IM3o5OVJkQSt2V2pXMkd1WG1paThuVGZN?=
 =?utf-8?B?THpDUk1qQ3VKRFdMOGdsY3Uwd2oyRFQ5SThINWxrMFI4UWJ3a3RIZGNkMjFt?=
 =?utf-8?B?UkRXMVZ1MnVhK2I3RGM1Y1ZxQjQyNzV5VUJUTmpHQmsybjliQ1ppRmRUQlNl?=
 =?utf-8?B?b1F1bWp6TmZGZ2dOdmt5a213UzByZTZRK213bFkrclhabk1nYkllUTdCalBK?=
 =?utf-8?B?K0pZTmI0a3g3UWZqYTFXL3NjY3dVWTVhTy83cDdZQ2lrMmtwQzJneEE0T2lH?=
 =?utf-8?B?bm9SVWg1UWtTTGdhZGd3dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZYdVpjZ0R2UVRTOHZib3dNajB3ZDBUMEljVmV1MkFvVk1FYm51dmNCbUxx?=
 =?utf-8?B?ejBPclFTRzVsdERLbDNUbVZKL2s4dGpDc1c1Rm9UWlF5NFFqcllaRkE1ZzNh?=
 =?utf-8?B?S1JQOVhmNlJFNDhxUFRUZnJzdTg1aTVqR0VVOGlhZWZUMnl1cmdGSFFqVVdT?=
 =?utf-8?B?Vkpybm5GWEVVK2MxOW50SEFGR1VocEpweCtTVVg3bi80U3FtYzJoYXR6YjFH?=
 =?utf-8?B?L3VncVovelFyaVgvaGh1VC9Wb2luUDBXV0lDanNnVFVSaHo4U3Y1TEZpOGhl?=
 =?utf-8?B?TlpQdTB3bDZqZklEekxxTnNORWhTTnNOVi9ZODhRSytRbHRWaDZNb3ZMNVE3?=
 =?utf-8?B?bklLSWpSYlJNYnAyTndtYSs5YkxZc1AycEdyV1VRRUtlQVlkN1dUbWhjTTBC?=
 =?utf-8?B?YWZsN3orc2dQdWRteU9HdEdFeXBIZzFEME91MEpDMU1GRkhnVXlia2tOYVVh?=
 =?utf-8?B?bG1SRU1SUm42VDNvVmZYcTJxWk9DQkZPZThKTEVxaUZsbE1nUHRkQnV5enA1?=
 =?utf-8?B?emszOUFWNnZuVWMzS2hwQldhbHc4UjVSWmJnajVETmZJZHh4b2s3aHpmT1Jh?=
 =?utf-8?B?bGN3N29TdGxTMlFUckRodkZGSVA0TStycHhiS2Qrdyt6VUNEZjMySU9MdEVn?=
 =?utf-8?B?WVY2OWNGUEF5MEhxS0tNeDVtMkQweWw4ZWpYTFA5Sjg2SEhoT3lzcXZTeEx1?=
 =?utf-8?B?REp0ekVmMm5Mejg4T0trcE8xVXRZQVNXSDV5cnpYUkFZSzkrNGZPL3c5YnJ0?=
 =?utf-8?B?SmZCWk1yRXIrWjJOQmpWdlpmM1IrYjN2RTdHR1FBRFVrcm01UEVxaGFiY0pT?=
 =?utf-8?B?Y0pwVWcyT2JYaC9EZVJTVkVvTGt4Q0d1MEV3M2Y3RWY1ZkVCYmY1U2dDdXNp?=
 =?utf-8?B?VDNyV3c0Zlc0amg2am9rZGJmSm5lMlR6aTE0STcrbzJIQ1JGK09pbnVFQjVD?=
 =?utf-8?B?RVZzQU83QTVzd3poN01iUUwraHdsbHlEYW1FMlBPaGlTcWt0MndEVjl1Rk9t?=
 =?utf-8?B?Q0xuYllORk1iNmtWeU1XNnB3MWx0bEFIbFhsWGhYQ0dVWHhaWE1tOFg2SGFr?=
 =?utf-8?B?ZEF6OWFTRzREWXJCaGo1WENJN3E3dGp0b1hIN01LcEQvQWF5U0RXa0ZDVFlh?=
 =?utf-8?B?NGttTm5wYjJnYlRTdjl2RzR5TzFYZ0N4L3lPcXNxZUZsUnBnbllCd2FvdzFs?=
 =?utf-8?B?dXBhMmF3V0x4Rk9KRXpGY2xzejZ6UUpkL2lTc2hHRW1jUDRzdGpJcEMwRVp3?=
 =?utf-8?B?N2FPaG0rL1hEdjVYWXFHRFVsMGJ1YXIwZEhDdmhxcENHYUlPN3hOWS9kVGdH?=
 =?utf-8?B?Q1ZpQUt5bFpQeE84eVFMMnErOVhDRGx3aWFpL2VMUlJaWkZsV1VjeGV2amdI?=
 =?utf-8?B?YzlmZUhwaTIxQXR3L20yR0FQZDZFQ0IyQ2RtcjlwcmZRRGJISEdiem5zY3ll?=
 =?utf-8?B?L2hVYXowRCtuRUZvQjZMUFhKRngyR0tjN21QOXBJNlE4K2xkT2ErVzhUTFJr?=
 =?utf-8?B?VlZhN3VEemxZOUJ2d1RHWm9CNGhyR3YwVEJ6d212dGZSeUdHRWt1VFpWa1Ur?=
 =?utf-8?B?Sld3dmp0VFoyM1N0WjQybnd4RFQ4a0hjRW9KalBZbkFONVdGUU5zZkJIeTVI?=
 =?utf-8?B?cWd3eE4wT3ptWmt4VmtJSWFYYnJRQ1NPK2dPRlFoN3RRRHZTeWRFV3c1VDVT?=
 =?utf-8?B?eFFwYVZaNk0zZWhEbWdWb3ErQjhyMDRxNFB1WUJPallvL3p2RmMwSkN3SXd3?=
 =?utf-8?B?R2lLWm5MQ254d3lsUElBekgrNk9FUzhnbW5pM1F4WUtpelJHdEF2RzJ3cDZx?=
 =?utf-8?B?STZWWjVTeXk1ZEtoQ3I3UzZCRlppdk9paGJMcC9qaFIwVlhQWW9QNlpBdjFH?=
 =?utf-8?B?aEIxd3hMR1ByN2k2Y3J6T0N1L05xQVI0L05vNGhoRWlPSmNtK25YQ1FIVWRo?=
 =?utf-8?B?RmpuVEFXamNjckJaN0JuMlpISTQ4TE94T1pxWnhEcjU2M2wyd0lDc2g2N25J?=
 =?utf-8?B?b01QSWtGU043RXdMNi9HcXNYVGRFdEo5djd1WlhSM1BQNE4wb0hGZ0FuOFVz?=
 =?utf-8?B?WFRWWU1XYmpqcVNLVzVtN2hGTkFiOURZcUwxMnprbUw1TTc3TWg2Z3VmZFM0?=
 =?utf-8?Q?6GIDQtznDIcVoDg4MrWiLRYtq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87513374-a874-4cd9-e51d-08dcb76beeed
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 05:35:38.0065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiFg+ISbpZNBoyB9Ldxop0EogL42dWUxQ7Jd5pn5nk7QtlrfoWrJwQ+6JHimCdNw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7483
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



On 8/7/24 23:12, Tom Rini wrote:
> On Tue, Aug 06, 2024 at 05:37:00PM +0530, Prasad Kummari wrote:
> 
>> Added LMB API to prevent SF command from overwriting reserved
>> memory areas. The current SPI code does not use LMB APIs for
>> loading data into memory addresses. To resolve this, LMB APIs
>> were added to check the load address of an SF command and ensure it
>> does not overwrite reserved memory addresses. Similar checks are
>> used in TFTP, serial load, and boot code to prevent overwriting
>> reserved memory.
>>
>> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> 
> This is a much more generic issue that should be looked in to with the
> LMB rewrite that Sughosh is working on.

yes. And is it going to be the part of his series?
I expect that if he accepts this will be done on the top of it and there is 
likely no reason to wait.
We find the issue out on system which has more dynamic behavior that spi pytest 
read the whole memory and rewrite TF-A.

And currently we are in situation where some commands are checking reserved 
location and some of them not.

Thanks,
Michal

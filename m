Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A685FC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 15:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 70B9D80C85;
	Tue,  4 Aug 2026 15:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 02Shm-PEVmm8; Tue,  4 Aug 2026 15:14:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 743E780C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785856452;
	bh=yu9J0E13FG4FIQSxTPxTScK0z84JRGws+pyQUb1/EaY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Kjb3jOtN9Ax6/ziV19zPZZFpyesq1gQCKKYsZJiATkiKDZZQbi2fGeM3H4L83dbnz
	 KWgU8CSxBHU98eNX8S5EZFTpH874/AIOsbPdf2vhcRSr4OVI8xX6GLPULMt3aro0bw
	 sSoTg0OuQAbjINujm9L9YbpGQJSBgR75OoDdOmG5F5XJ95dNeQnKUiiq5EAK8C6Qyt
	 itlFI9CMp1xm8ZrSd1JiPf3rhKCNmBBZ7mfxHdTVJHSk/tWqNy+yo+1I5rf/79EExz
	 At774SrsNsijvasPqn1PAM4Bmve6lWq3ECAjDsIsEYVYDQPWf5MG3OBQr7sSPpzuux
	 z2txxov0cnV5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 743E780C81;
	Tue,  4 Aug 2026 15:14:12 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A597218
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:14:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 50B5080C81
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:14:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 80nCHJAGZ_m8 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 15:14:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 344A3807D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 344A3807D8
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 344A3807D8
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 15:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBTaAcB69oY9L6XWgVETij92WSyCTkpCZEvWkAvOo7nyFBsw9yhiWvVIvCyNmMRPfLzFSzm9FtpoLAv2L6zbTGYoIID+UyhTxr2cVWUeBeXXrDKN9MmUHRSoJWntk4vNzCYTqEQRe2bpU3gTaWH7h6ALDEnmD0xDqmdqlnlzZbqh1VGRJg4yfUL1RaHqc5GyA63ld0ST8z8szaiy4Y7fBH8Yfx472gvheSujWmdlDWCWkZeUA6oPfL9SMpyRtsd32VpOidcj8EEqPiVnRfgoCFJsf6d8P4awR28q5dAPg6SbbW2+thLkZ3dpNKidhmsQZa6Qrw/G2SO5ney3HGVF6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yu9J0E13FG4FIQSxTPxTScK0z84JRGws+pyQUb1/EaY=;
 b=QCOkGOO0di/I39oYPj2COk7WeJu2qUhOIc0a1wpk9IrCBBMezYb/jubPnNq9NsbcVxEe3eWuhQVT+vrzgpvO4Rh7VcqObOWyVaWCDpqKHTOXtSa94W/1b4jQiLv6BxHz5N5oCznkh3YDg1X1BM/a4ZppGObR+5T0oKzHQEGG9KxNiFGN/sa5iZqn6k8l09lNopEQPse3hI1KsPeVz4KOjU4GZqCdSm21KkBzOpMqvlEyYmRrNAUJJ7MSjhhyyux6yEqFjr6CwcNZFbS7QkDCazLTYvJCIqVuASqlhpFUa8Y5oKffjFcrOoKbqdbXGzOm7VOrBISWYE2mX84cfWmPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CY1PR12MB9557.namprd12.prod.outlook.com (2603:10b6:930:fe::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.16; Tue, 4 Aug
 2026 15:14:03 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 15:14:02 +0000
Message-ID: <36176920-82e0-482f-9dd1-03cf7c2a8c80@amd.com>
Date: Tue, 4 Aug 2026 17:13:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xilinx: versal2: Add PM UFS firmware interface
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Pranav Sanwal <pranav.sanwal@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>,
 Sean Anderson <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
References: <6419fe4f6f1f451aee624c7762b7aa690d50e498.1784870711.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <6419fe4f6f1f451aee624c7762b7aa690d50e498.1784870711.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::11) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CY1PR12MB9557:EE_
X-MS-Office365-Filtering-Correlation-Id: 3994e587-8996-405c-cadb-08def23b0460
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: lzsYvIT23J+xWXjpfuEpUavbqq7tBRMl8IsW/qAUoi2VGNX1Bp/CzW22nLLlb7Q+pspUbq/ezZ+RrOjg5nT9B9hqinpDU2OAo6BebWGB4mn12IXXOhj7IxSTKroCZc5LxZX7CDiXbQmFrXDpz/wNaqVOOpD/mXM69CQgxATMLM0o6fV/Fw1v5qr4Qew5F7x8PDvEMFhXgkbauwJA8owl0YNbEFROBNIEBADIqRe2FH1ZIKAd4VJYysw6nS3Blt9lWL7B/Zg+mTn8NjUH1EjqufvtQKcMGmOSaczFoGjayH/X427CbQq9vDXTrKMOXuCLtABQTsqj+ARg4dR71DrHIgYP+dPCabj/osM+ttjG3MANoKkvFqdula4qBM0bS5J7u4uMu5YZgzBksRvUOvn/gRooRd1HivxdNEOR82OxYtjsFZ3d690vB8z9jKXzmDkaM+G2vGFcjzhs+NOilCjubFYrDsT4xWTGTD8khLPUXAFbYbCH8y8Cz4wRrtj/aVO0RXuVJsBZ74o06suQEr6oX6BpaQfTeKZ+MQ9xAxcwWsbXx0ztBO4a0V4Ych9A2pLrxC+lZ4wLUsqWN6BpX/BggMTDUI/45+6KA69qW2rkm2tY1rQoKwcL7Bh+GYXD/Xy884z7zvaMuwFczrkPI2fnWOeTGDCckbZSyfRzanUWeLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVpFS1A2bkd1TlM1d2pWV05oZXAxeXEvc0dScTZINFMxY0tLVHhienMreEhU?=
 =?utf-8?B?SkY3cHF6dVJOVEZ3NE5hZ3BJZW50ZmUzRVNpUkRXamJBT28rdnViSjVhbEh3?=
 =?utf-8?B?VE1yVysxT2tiN3RZMGYySWl1ZGhZeXRGTkVUaW5GZi9CeSs3cHJFTWdObUda?=
 =?utf-8?B?Q2FkK3B1ZHVxM0xZbkVOUmw5RmR3RTRiSmpDVzU5SXJZOHQ4QnBPNWRjWTd0?=
 =?utf-8?B?MTU5TU54NUc5UzAycnFUdElicVZHRERYMW50Y1ZybVNwbXlNUGgxYlhVYVM4?=
 =?utf-8?B?K29NMmJ4bCtxMW9VUnBLRkJNWHFGQXZJYmtSY2NLRUg1RjQ3YThQTDVBWDQ1?=
 =?utf-8?B?VHJyL21xL3FOZy9KRkFhRUp1WXlvVUlmZUdmY0RXb0paUlRTelE3dlhuN2RV?=
 =?utf-8?B?K0prUWdUNXYxVU9NNHNJUlFXY00vUnd1U3QyT2lVUTFzTStrTEhhRTlQUUFT?=
 =?utf-8?B?Q1AzR2haUTRVQ1NtRkR6UVg4cGNlVlNWS2JobzlZT2U5ZWJLU1JCNVdlOHJ5?=
 =?utf-8?B?WFVzZWM1RUJGVmttd0oyMmRQUi9FYlFBRWwxdFdTN3ZpN3BqdjhxMjJzZEll?=
 =?utf-8?B?dTJJU2tYZG91WTdIcEFISTRjYXVOaVA0d3Y1TWJZakZvWXBoMEswWStUdmY0?=
 =?utf-8?B?NEdPR2hxd3pIeW1KdW5qcEZtYUNkd0EzZEVQVmZKTzA1bFNXUmludGlJME4x?=
 =?utf-8?B?OEowNEdBTUd6SlgxQ1ZCUXcxZWxmZWt6QVpKa2pTY0svd3FKdk1uMTF0MTZt?=
 =?utf-8?B?SEowTDlXaXRueWtCOVNhMFpsTWxyZUNoallGMS9BdjNVSHRIZngrMDNVQWpL?=
 =?utf-8?B?UmVRMU0xeW5GaHNiU0hsamlvWkM2ZkZFdDI2WFhHbUVDTXIrV0tqWmVaLzhu?=
 =?utf-8?B?RkdERHJmdUZsaW53M1R0Sm94OHBINFE1MmViMHFOaGFzYkQzOXIvZENBUVJY?=
 =?utf-8?B?a3d0R1Q5azI4YTl5L1I0bVI4Mjd1YUVWTFJVLzBra0haZFh6U0pzVzJqY1N6?=
 =?utf-8?B?R2Nxa1hhcWh4d0J3YlV5TE9uRExNTjVXbEJkWU45NE5mNGhQWTh3YmNrdVBs?=
 =?utf-8?B?RkNWbWpEVi9HS2dLMFJTMnBUSUVacFhOWmc2UlVHMDBZUmV1bHprYTNLVzlp?=
 =?utf-8?B?UFlvS2RMUEZJUm9YVktROFQxSWJBNmxOMk1nZDB5NzJXRDE3a2RoTUZQbzhj?=
 =?utf-8?B?ZEx2Z1VveHp0TU5KeXhrSFYxT294Nmo1L3B6akI0dVJSOTgrKzFSWk5Xelhj?=
 =?utf-8?B?dlU4MUNOcGlEUzVWSlVBV0xEUWF1SXJLZTVwNkRvTE9sVkdDQVZYRTBsenpw?=
 =?utf-8?B?SEFsRmNQWkUrNmV0ekVmWW5GT3pNUDNzVXlFeHBuakljMkpSSnVkVUpYdFMx?=
 =?utf-8?B?S1hBQm1Nb2xTV0NZdGhCZDRYMm9kUWFSVkdqTVBaTDJvU2tOYk5FbXNkNXVo?=
 =?utf-8?B?TVdVVVI0dGdCbEJKNW1kTENjR3hUa3JuMm4wRkYraGlVb0V5dG5vdlhyclBh?=
 =?utf-8?B?ZWFyVzVXaGxnQ1hiRkZwdm5wN2E1MW5kWXZOb3NybC9YU3NDejFoN1A3RVlu?=
 =?utf-8?B?U3c5TEdDZWJXRDMzMEV0V0JnWUN1cU04NkQ1S1l1NjBYU3FOdmNNWGRsblFO?=
 =?utf-8?B?QU0xMDRCUExRTFBJV2xtK05FeHAyYXo4azQ0U2JSdmV1cFdUMGltQlpOajF1?=
 =?utf-8?B?TjAzVTFVZWlydzE2ZVZBRFhyWk4xeC9VanpoMlRFeGNCbEtSQjMrTkRGNUhV?=
 =?utf-8?B?eVJSblhncFUzTFFTSUFWQ1FEMjJFSFFGeDJtWWlWdnFQVTNCc1dBcXluaEt1?=
 =?utf-8?B?Q2xzb29WUWN5MHVETkU1Ni9ScjEwU2QyZ2F6WVBiL3BHK2JDWDNTSWhZYzQw?=
 =?utf-8?B?Y3Q0QmdJR0VxS0V5bTc1d3NrNTdXS1ZwcEpTUlNuMkpxYlZ1T2VCTGcrVHJM?=
 =?utf-8?B?Y2VpWDJyNitPK2hvN2hMMXY5ZnFHTnQyc2ZGaVlWTkRqWXp1VS9Zc05OallW?=
 =?utf-8?B?UVdNcmdpMm1nRnhqNmhHWTAwaW02Q1AzWnljd0V5YWRHcVRLOVBHbzBPa3FE?=
 =?utf-8?B?dVRrVnVyUEo4ZFhpZEV3bEZqdTI4NmRSa0p2WWl3dlJlMmxLMS9rZjI5VnVz?=
 =?utf-8?B?NnRuRU41bjljUHVoa0xadEw4bGxlMnhTcXRXa1QvZFBzTVVKbTVGRUdiMGI5?=
 =?utf-8?B?cG5NdE5lOEI3TldidklsSU1raUxZaElvNEJST1gvZlRsMzYrVkRrRWlob2RR?=
 =?utf-8?B?WHpMVHcraDdycVdGTEZUbnppM1p1bFFqVmlsQlhmNW91OW5seW9MM2oxMURD?=
 =?utf-8?B?V3FQaFZrN1U2OFpNZ0svdkJYZm51VEJRemhTc0JCUW5WbG9vQkRlZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3994e587-8996-405c-cadb-08def23b0460
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 15:14:02.4952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5gpsHFa1QMwHnmuzVHihdeuKuJ+XsSWlr7U1J9+ajOT99sFjs2QcSlHINzKrqRwf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9557
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yu9J0E13FG4FIQSxTPxTScK0z84JRGws+pyQUb1/EaY=;
 b=h3w8q8ccFASjZgZt9ZCb/3bXFN0WFbUt3zCkpIFtxBJeThnY6xHLFaUlbsPVCRxW+H9Gx2OCNCsNVnT/Zh+tFtKCi7MRhquch4lfJMTsUvSthUNTebclfwsTl4UFJqDQNvgJYLObWF5G4l1ZqkyXnxoCQZUEo/kbyL1aUcpB8JQ=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=h3w8q8cc
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/24/26 07:25, Michal Simek wrote:
> Add firmware interface for UFS access but also keep IO interface when
> firmware is not enabled.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Changes in v2:
> - also move prototypes to generic header
> 
>   arch/arm/mach-versal2/cpu.c                   | 24 ++++++
>   .../arm/mach-versal2/include/mach/sys_proto.h |  7 +-
>   drivers/firmware/firmware-zynqmp.c            | 79 +++++++++++++++++--
>   drivers/ufs/ufs-amd-versal2.c                 |  4 +-
>   include/zynqmp_firmware.h                     | 13 +--
>   5 files changed, 112 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
> index 6cc6592b0fc1..01efa7b79282 100644
> --- a/arch/arm/mach-versal2/cpu.c
> +++ b/arch/arm/mach-versal2/cpu.c
> @@ -160,6 +160,30 @@ u8 __weak versal2_get_bootmode(void)
>   	return bootmode;
>   }
>   
> +int __weak zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
> +{
> +	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_TX_RX_CFG_RDY);
> +	return 0;
> +}
> +
> +int __weak zynqmp_pm_ufs_sram_csr_read(u32 *value)
> +{
> +	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
> +	return 0;
> +}
> +
> +int __weak zynqmp_pm_ufs_sram_csr_write(u32 *value)
> +{
> +	writel(*value, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
> +	return 0;
> +}
> +
> +int __weak zynqmp_pm_ufs_cal_reg(u32 *value)
> +{
> +	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
> +	return 0;
> +}
> +
>   void versal2_timer_setup(void)
>   {
>   	u32 val;
> diff --git a/arch/arm/mach-versal2/include/mach/sys_proto.h b/arch/arm/mach-versal2/include/mach/sys_proto.h
> index b8d12d1dd3bb..c1dfd184d865 100644
> --- a/arch/arm/mach-versal2/include/mach/sys_proto.h
> +++ b/arch/arm/mach-versal2/include/mach/sys_proto.h
> @@ -1,7 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0 */
>   /*
>    * Copyright (C) 2021 - 2022, Xilinx, Inc.
> - * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
>    */
>   
>   #ifndef _ASM_ARCH_SYS_PROTO_H
> @@ -22,4 +22,9 @@ u8 versal2_get_bootmode(void);
>   /* EL3 clock/timer register setup, called from board_early_init_r() */
>   void versal2_timer_setup(void);
>   
> +int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value);
> +int zynqmp_pm_ufs_sram_csr_read(u32 *value);
> +int zynqmp_pm_ufs_sram_csr_write(u32 *value);
> +int zynqmp_pm_ufs_cal_reg(u32 *value);
> +
>   #endif /* _ASM_ARCH_SYS_PROTO_H */
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 0783aa9a8ab7..2bdb1c4d9f89 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -177,26 +177,89 @@ unsigned int zynqmp_firmware_version(void)
>   #if defined(CONFIG_ARCH_VERSAL2)
>   int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
>   {
> -	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_TX_RX_CFG_RDY);
> -	return 0;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
> +				IOCTL_READ_REG, TXRX_CFGRDY_OFFSET, 0, 0,
> +				0, ret_payload);
> +	if (ret)
> +		return ret;
> +
> +	*value = ret_payload[1];
> +
> +	return ret;
>   }
>   
>   int zynqmp_pm_ufs_sram_csr_read(u32 *value)
>   {
> -	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
> -	return 0;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
> +				IOCTL_READ_REG, SRAM_CSR_OFFSET, 0, 0,
> +				0, ret_payload);
> +	if (ret)
> +		return ret;
> +
> +	*value = ret_payload[1];
> +
> +	return ret;
>   }
>   
>   int zynqmp_pm_ufs_sram_csr_write(u32 *value)
>   {
> -	writel(*value, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
> -	return 0;
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_MASK_WRITE_REG);
> +	if (ret) {
> +		printf("%s: IOCTL_MASK_WRITE_REG is not supported : %d\n"
> +			, __func__, ret);
> +		return 0;
> +	}
> +
> +	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_PMC_IOU_SLCR,
> +				IOCTL_MASK_WRITE_REG, SRAM_CSR_OFFSET,
> +				GENMASK(2, 1), *value, 0, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return ret;
>   }
>   
>   int zynqmp_pm_ufs_cal_reg(u32 *value)
>   {
> -	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
> -	return 0;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +	int ret;
> +
> +	if (!value)
> +		return -EINVAL;
> +
> +	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_REG);
> +	if (ret) {
> +		printf("%s: IOCTL_READ_REG is not supported : %d\n"
> +			, __func__, ret);
> +		return 0;
> +	}
> +
> +	ret = xilinx_pm_request(PM_IOCTL, PM_REGNODE_EFUSE_CACHE,
> +				IOCTL_READ_REG, UFS_CAL_1_OFFSET, 0, 0,
> +				0, ret_payload);
> +	if (ret)
> +		return ret;
> +
> +	*value = ret_payload[1];
> +
> +	return ret;
>   }
>   #endif /* CONFIG_ARCH_VERSAL2 */
>   
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index 3369d32d924c..25af9dd63cca 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
> - * Copyright (C) 2024-2025 Advanced Micro Devices, Inc.
> + * Copyright (C) 2024-2026 Advanced Micro Devices, Inc.
>    */
>   
>   #include <clk.h>
> @@ -14,6 +14,8 @@
>   #include <linux/time.h>
>   #include <reset.h>
>   
> +#include <asm/arch/sys_proto.h>
> +
>   #include "ufs.h"
>   #include "ufshcd-dwc.h"
>   #include "ufshci-dwc.h"
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 0e545e3db1be..f753a67ac276 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -465,10 +465,6 @@ int zynqmp_mmio_read(const u32 address, u32 *value);
>   int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
>   int zynqmp_pm_feature(const u32 api_id);
>   u32 zynqmp_pm_get_bootmode_reg(void);
> -int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value);
> -int zynqmp_pm_ufs_sram_csr_read(u32 *value);
> -int zynqmp_pm_ufs_sram_csr_write(u32 *value);
> -int zynqmp_pm_ufs_cal_reg(u32 *value);
>   u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
>   u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
>   
> @@ -535,7 +531,14 @@ extern smc_call_handler_t __data smc_call_handler;
>   
>   #define PM_DEV_OSPI		(0x1822402aU)
>   
> -#define PM_REG_PGGS3	0x30004003
> +#define PM_REGNODE_PMC_IOU_SLCR		0x30000002
> +#define PM_REGNODE_EFUSE_CACHE		0x30000003
> +#define PM_REG_PGGS3			0x30004003
> +
> +#define SRAM_CSR_OFFSET			0x104C
> +#define TXRX_CFGRDY_OFFSET		0x1054
> +#define UFS_CAL_1_OFFSET		0xBE8
> +
>   #define PMC_GLOBAL_PGGS3_REG_NODE	0x1824C005
>   
>   #endif /* _ZYNQMP_FIRMWARE_H_ */
> ---
> base-commit: 3a500867bf0b8527ee7e94c325ce876562fba6c8
> branch: debian-sent3
> 

Applied.
M

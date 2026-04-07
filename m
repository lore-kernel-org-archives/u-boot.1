Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB37EDB7FD
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 11:10:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8745E83A41;
	Tue,  7 Apr 2026 13:10:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kcBxZEJY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D74228405F; Tue,  7 Apr 2026 13:10:49 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1BE08352B
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 13:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3+ngliz+brUXutjWcLEBHI/HDQVJLpTAQlw5rV9X7Etyw2OTa5KyXq+2hx0yX3JIc7qlv8Z6aYwLXY87bUT/1dmZsdcPzj3W9v7yy4Z5mSmAG3cMLP075w64885VegdTpZREHaU4LEHzbBrHFukIIKO5n59Prfdk8QLBz+sz2CALcPhDeggH43QxDCY2MORhey4KDimIVXuSBp2Xw5kk3BLZNa0ue95EGKRX8IGaaJ9VuVeZfof4MzbHqED6jpfVJDuSlDNsYGuQLqRTVaKZPNrfgCvqTodfbCzA93NfHg8dT/exA4tEZqWNvTdJdufU98y5BqsHS9UoGJu4rKlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjwi7pWBHjxj6TxrqOyvIAaqfNWeasRhGOHhJSPr4kc=;
 b=WEzsonPzB0aHL31D/N316CkHY9AHrnLpUgA2qo5rKKWrgykYUoqFDRh5k98dUwIxHZOIkE5oxoNl9layXWB53E3n3z1OnaH+oUX6HIsqZNn2fJcrlZUgWMpEjpdcYydDNJK9y0wPKS0o1TtDbXQmT5yFFpmgMRsqoBmbm9IW4q6eITEQh1hk0rZxyqYBRhKKYA0mew2H94Extap7S8JAwqCjxtVd1I/rRoVjKJgxKGcWQxF1W7N6l6Ls7eATBkVbETq1OuJM4eOSXAZ++oG8g1hi44PpvWFRWMKMKHslFJLB6fN6TH/P3pZnRK1pXw3noNN/htkyAojo9MLIxEoCLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjwi7pWBHjxj6TxrqOyvIAaqfNWeasRhGOHhJSPr4kc=;
 b=kcBxZEJYFM506UjbNkvhDVdarH8nP6ZmKTT4qHzJvSU4n8G2rPx5/MTMxvBGl11dxfCOwYp5s12iUOsXTBLVe8uYq92hxwAzByG35tjBIuEmPf5a5SIzqpUVdr2RfpG3gMNQ4j/3Z5U7h5rf2UDgk1bahR6pIoWzqCqotGjavBQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8e5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 11:10:43 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:10:43 +0000
Message-ID: <2de3343d-d8a3-4b10-a1fe-a60525418b09@amd.com>
Date: Tue, 7 Apr 2026 13:10:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: versal: Fix out-of-bounds parent id for DUMMY_PARENT
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Lukasz Majewski <lukma@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
References: <20260327101053.900154-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260327101053.900154-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0124.eurprd09.prod.outlook.com
 (2603:10a6:803:78::47) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 655c7329-2e2a-4043-240c-08de94964f66
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003; 
X-Microsoft-Antispam-Message-Info: Ag8tS8UcM1E07dK6Bt96oq76EMZmXpYNroy06/MDxCHtEB7rEy2PnaQxOnUP36jX6NOaaOFs7cE8aCUwpIo5ssFS8DlxIYhiSWtQAd3WeinazJQ4eTQySm7mPqgsN/KdSccAmosvsZ3ixJTK09ylC/sPtxFUI4so1WfIJauwG16v/4EsVUOt9dzfUYL78QFvdJ44IvdNT81BxCHKa1kHYTiCduOtgr/XhX1cvy/qTnOyZeAYlAek6qhySPDEyoHYXkWjrqz3JMYacRwcrgfyBzJZ9F13E1ec35aKnrY726UziqNKY+3AdvWAimu0NA/BmEMT1otDCZ4PuMhnRiDcydkskDiOqOLJftWsv0uFxHLsNaYGJkqUzTLm90849kH02AIzUbvafD6OmPfiFYxGV7HdByOkZkwaa7CQzQGbY4Kbbar7r4yEM/nneP5CRB6NSaUktPi0qpMQQD+vAyOeXlH9LtHtYTNnqREqMzRyqJ8vvTbtz5NcZin8TFRPZhrdNENJB8rG411UWPsvMjBKBIda9J5soTPv2rBGCNWuoECfBmhvPS41kxy0GRZ0HzUbG4MZtsfLyAlL3kK4YDRfXF0OAcRfQafW39bFSyGgtWr7EA1v10A8ZuGfj1LXrW2Bre1Q1tz2Z3OC9j9FRTg2DrdqATVuhoUYjFmk/PFWDMY9BU/OILnKfctp6gdX8iyCfIoBPXm3y/WznS5PDFge9YaUsRcXWzJ7Qsb2k/H0UPE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1l6aGRkdWpoWnBNTW5sSEdUSzY1SjJCT0VSYm8wMkwrMGdNR0lnRE5KRzFH?=
 =?utf-8?B?UGNOQnNUaWk2cWtFQXhwOHE0WnA5V1UwT0pjSVkxbm1WdXd6UGxkRnU3d2FO?=
 =?utf-8?B?anJWSEhSb0dGM2dlaGZZZS9keXVFWEM0aXdaeXRJeHFPV0ZZK3NFd1VRL1lO?=
 =?utf-8?B?YkR2d2dTcThlT3cyejI5dndpWFR3SzJNQ1VSOERGY0ppVDRLZkN6UmY1b3Jz?=
 =?utf-8?B?M2UrR2ZWNUNoQ3pFekxuTlNVeUl4NnVIMUJFWCtTMEwvZS9sQk1SSm1tRDAz?=
 =?utf-8?B?Z1o0WHllejlQT21EWWVuc0NGdGMyM2lCOG9DN1JISDdUR1JQcGR4alJGS01M?=
 =?utf-8?B?a0hsU3N4TFBPbitVdVJ3d1gyWEUyRG5GT2ZMbFVuWGVMd005b3c2VzlxUWNy?=
 =?utf-8?B?L0RTS3R4aEtuUzV3Z3htUXJJcVpTVlhtd0xTZFM5NmNzSlRPMkl3YVBJZUJ0?=
 =?utf-8?B?amttWUdVK1ZjRG5ydFloQ0lHbjZRVTNhYXlESy9rWTN1RGllakVuM1ROK08y?=
 =?utf-8?B?UmJxQXdKZ3o3MFFoZmwwczNXMVlibFI1bnFDRDJObncwallKS0NVdDFTRjla?=
 =?utf-8?B?YkVoeUNXdTZQTFlVWHpBUTBpR0lWUDBxVWlxYk1yUG5PSG9wVkdLYkVrUGc1?=
 =?utf-8?B?SlBybmFIcXZ1R1NUSDJCQ0RxMTlvSzV2RzBUM1QzUUQxclloRnlMNjlPRDd5?=
 =?utf-8?B?aGJZbmpZK3crZjFoazlTSFhDYjFvOUIzN2dISkN0ZnNXRVpOTFQ2ZnpJYksy?=
 =?utf-8?B?c2dzY2pNSURhWXpDUUZNVWw5RWJocUNnLzVDWW0rRytTY1ZjTUx2eEpWMURX?=
 =?utf-8?B?T0luZyt3YU9jczF2VEM4NjlSeDE1RlM1THJheHRuT0VVR2cvUDR6aUdJU2NP?=
 =?utf-8?B?Q3lqdjc4aWtNNlZLWmJKZjloaDg1OTB4QnM3NlBjNlNjR1Foam1PemhjamVk?=
 =?utf-8?B?OGtBWFJTM2g1K0dzSjZyS1pzbmU1OGt4VmN4bWdJd2dMTms2b0xHNGlEbmZB?=
 =?utf-8?B?bmN5cER5VWs2aTAzeE93ckZ2REZqcVdjNzFyamRvalB5U0F3RjAzd3c2TU1z?=
 =?utf-8?B?VVdpVWNwWGhCQnp6YzBMRCtUYmpsQXByOXlIdTVKd2dORzJZd1JnR3RZQzlN?=
 =?utf-8?B?YkYrN1IwTURWRVF4Nlp5Vm9tcWk0NFRmbS8zLytpTVR5TUt6MzdjdHg2RmpJ?=
 =?utf-8?B?aXVZd04wdVUwalJyaG1UNVdEMGpGcVFVQU1xbFNwTGhPN1JxVlRveGNwT20r?=
 =?utf-8?B?cXNBK3BBUVJJTnk2Q3lxbUU0aUJUR1dyMWovdks5WVZNTEhVNjdQekVFR3ZH?=
 =?utf-8?B?Lys3QVNFdUVZRkVNdytWUGd0MzEvWDBBdERENU1pQ0llUVZGRkhnaFlqOE5T?=
 =?utf-8?B?Qkd1UDl2YksrSE1GRysvaFVNdEdLRGRmMDhVcDNZOURJV1lXK3p0ejFSTFky?=
 =?utf-8?B?blpwUUpvK0FjTUlPK3psanlJbjBFWkNENzJqL3BQZjhsMG1wMEVHMTM2a21a?=
 =?utf-8?B?RngvN2FXMWwyYjlsT0RDZmg0WE9kSUQwVGpvQjEwRWJOaHFDakhqdlZiaVNN?=
 =?utf-8?B?dDZvU0N4OGNqM3VQYVJodHYzRzhESFNjbGpzTVlHaVFsQVdPRVRKTTNWYmJL?=
 =?utf-8?B?RXpSRTZjVHAwajdLS3ZzT1p1VU1VWlhOZlFUNGVMRlpKdjJBd1U3MUpSczB4?=
 =?utf-8?B?TExOUUYyTlhEaGNnVU9RVkxMTjVkNzBxeHRSUnU2bG8yNDkyN24xQk10M2t0?=
 =?utf-8?B?ZjlRQUlHNi9taklZdmI2VlhwdDdXWEVwVjJEcDNZZDV1SlVqNzZ1Rkk3aW5t?=
 =?utf-8?B?SzBXRkQrZklKd1pRSGVpUmV3dng3QURFbzZia0VtYThReXRLdEVvbTU0dEJu?=
 =?utf-8?B?Tk1YSVRRTlBkOWRIdzZkM3J6ZU5OR2E4dkRQVFZGWE1zN1JVVjlGS25aQW4x?=
 =?utf-8?B?NkdlWXBTQU9acDltNnRhVDRFYXJxaXRhWWl3UlEwYkg2eVcwb3pzZVlUVjAw?=
 =?utf-8?B?bGd1eWpURDlDcUliaU53MHhRcUx3djl6SllBNkx4VHhBb1J3NS9aSWNyN3Nq?=
 =?utf-8?B?M0tRZ3dnMENSVGFPcGNyZjQzbVNxOG9nVjJWbWZCZStkQ01XZzZncEMrS0k0?=
 =?utf-8?B?cTNSamppOUxFcWxhUEZIaWVSbjlwOWhoN1Vuekw3b0NFVDJUd1BsSSt0NFZ4?=
 =?utf-8?B?Y0JTMEtsMjBjak11bHNzbVQrdE9mZHR0OUViOTJKUE1STzNIbDJGK0E4SWE3?=
 =?utf-8?B?WnpaeTRkbFRVTFRpeFBpRGt0WC96WlVvWUtOZXpUcVkxSVdiQ0hHem5qSG83?=
 =?utf-8?B?N3hnMkRMSTQ0SXZnQjhRenB2dzRTaXFEa21vZ2swZjFTK1FZRVpydz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 655c7329-2e2a-4043-240c-08de94964f66
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:10:43.2932 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyTeeBkgYFnls6etu0fr9TG0PP5heFnbhrJUUv/ZqCkkQE5KP2JbO7quQC1VSVxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4
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



On 3/27/26 11:10, Padmarao Begari wrote:
> When a clock parent entry is DUMMY_PARENT (0xFFFFFFFE), masking it
> with CLK_PARENTS_ID_MASK (0xFFFF) produces the value 0xFFFE (65534).
> This value is stored in parent->id and later used as a clock array
> index in versal_clock_get_parentid(). Since clock_max_idx is
> typically 228, accessing clock[65534] is out-of-bounds, and the
> garbage value read is used as a clock ID in subsequent clock rate
> calculations, eventually causing U-Boot to crash. This is observed
> as a crash during "clk dump" on AMD Versal Gen 2.
> 
> Fix this by setting parent->id = 0 for DUMMY_PARENT entries.
> 
> Fixes: 95105089afe2 ("clk: versal: Add clock driver support")
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/clk/clk_versal.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk_versal.c b/drivers/clk/clk_versal.c
> index 78a2410ca21..2e0c382ef30 100644
> --- a/drivers/clk/clk_versal.c
> +++ b/drivers/clk/clk_versal.c
> @@ -326,6 +326,7 @@ static int __versal_clock_get_parents(struct clock_parent *parents, u32 *data,
>   		parent = &parents[i];
>   		parent->id = data[i] & CLK_PARENTS_ID_MASK;
>   		if (data[i] == DUMMY_PARENT) {
> +			parent->id = 0;
>   			strcpy(parent->name, "dummy_name");
>   			parent->flag = 0;
>   		} else {

Applied.
M

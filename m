Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B53E9B265
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A54D83E83;
	Tue, 24 Feb 2026 14:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VZbcB/f7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2EFAB82BF2; Tue, 24 Feb 2026 14:54:05 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C4383981
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:54:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JPqJIAtI2olg8DGFMBt2Ks+ILQBI2hqCHuWDEYDAtmR9LZGsmE0FtaV/PmBEjVU3MWrq9+jJxNyxreYzO0MZhAQd2FUasC/4ItYArw6y4V7QoMVPIrnpjpSePTnKZ98NFFOg9QRa0GS3zZvlH3S+pkl/aAEEXHHfw78ntUH/Z6H+/VRbCGmfjK2/C11g28wKWv82GeAJY7mC1iHli6XPPManD4ehWHZ5FB/dSfjPol2q77tI98rUXsRu2WNkz2kr64a9U21BOf/rrk8n7SPq1riNOz5aW1QpJrIHc7/k4x6+YTYYUBtZpXRAtCe7B3T6yOgiLKdnt7x7ZeQAbjluHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnwqIpz+bcAK7pAnBOSzEMZjMOuzN4yKqRFjdVhoBYM=;
 b=W2RfwaAVagacGbBg/OxRW5HuB822SbUChUMqIyHJsnHaXzxVpurOcCHWLxDTPDY6U1axuAyeLY4W5ez1rcNosj57DXpYd+zLgZn2FhtwjdK76t63psFWxqPAgGzQVpBKPRDgtSfv7o2Jg44gywCYFtqY/Tx0jxX7S69X/fPeYnSWY7dL7Jv3I6sQ9iLPCKz9BGVG17ChJB3wLkvlFK5OhScrMz8e/pG4E+xhxBIrQcvcl86Wn0yw4HKnepIwru7hskSzLAGNg/U27kOR0NS3e7x7icfDhOOWYuuDu6begaDsGeXk8WemlT1GzrBpQRbGAR/JnbQofeCIzxWq0g7nBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnwqIpz+bcAK7pAnBOSzEMZjMOuzN4yKqRFjdVhoBYM=;
 b=VZbcB/f7puK29xgwPkCX5ww6oOp6hhDiWk9eztnPvrzzWLvcIpEa0K1ssfdP0enmBMmis4VuCiEtcMf/8OfdAXdXRBKTp+a3loKpTSRgI9H2rsiE5rJRcjkJibxpRuCJ3m49iTAg7Th7Z6Yqvv6YkxHBEMyHv8+eopZCJCtb6Kc=
Received: from DS7PR03CA0220.namprd03.prod.outlook.com (2603:10b6:5:3ba::15)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 13:53:58 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:3ba:cafe::f4) by DS7PR03CA0220.outlook.office365.com
 (2603:10b6:5:3ba::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Tue,
 24 Feb 2026 13:53:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 24 Feb 2026 13:53:58 +0000
Received: from DLEE210.ent.ti.com (157.170.170.112) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 07:53:57 -0600
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 07:53:57 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 07:53:57 -0600
Received: from [10.249.145.16] ([10.249.145.16])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61ODrqUJ2828233;
 Tue, 24 Feb 2026 07:53:52 -0600
Message-ID: <a500eeef-f0f2-4cb6-bbf0-2517a1cb5342@ti.com>
Date: Tue, 24 Feb 2026 19:23:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Verdin AM62/62P not booting with 42b3ee7fa524
To: Francesco Dolcini <francesco@dolcini.it>, Bryan Brattlof <bb@ti.com>,
 Anshul Dalal <anshuld@ti.com>
CC: Suhaas Joshi <s-joshi@ti.com>, <u-boot@lists.denx.de>,
 <trini@konsulko.com>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <ggiordano@phytec.com>
References: <20260217132150.of5l5qirxkeizsne@ula0507357>
 <aZVjSOzCH6ZP3CjW@gaggiata.pivistrello.it>
 <20260218145241.GA179991@francesco-nb>
 <20260219014606.x5sg43kuc7fbq5cr@bryanbrattlof.com>
 <20260219104020.4gzvbit3b7qqcoqk@ula0507357>
 <20260219193044.GA203975@francesco-nb>
 <20260220010527.mpji63idcn7vj74w@bryanbrattlof.com>
 <20260220104621.GA15099@francesco-nb>
 <20260220132342.did3zsxh63tlw3hd@bryanbrattlof.com>
 <20260223155816.GA172267@francesco-nb> <20260224102121.GB340942@francesco-nb>
Content-Language: en-US
From: devarsh <devarsht@ti.com>
In-Reply-To: <20260224102121.GB340942@francesco-nb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 71b6978b-ea5c-4aae-65be-08de73ac284f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXZOd21ldmd0WHJ3ZGJsYnVoYktSVGpTQVEwdldqTEsxY0JvZGNGMEp4UlJI?=
 =?utf-8?B?Zm5uNmdjMzNwb3BuQ0kwa1V3cVFqd2ZUbEJ1ODBtMWxBMWw2aGVkZVFMTnBI?=
 =?utf-8?B?Rjc5YTYxYVBMMmFob09iQU9HRjZMUVpMNlBoQ3V3dTFVbExodEpYWFFBODFG?=
 =?utf-8?B?cGlsWVFGOVlVbEJzLzRCRmVqZnhJdlV5ai9saG1KOXhyUDNxYUJQdDBLeHJu?=
 =?utf-8?B?RFV5UGdUWFVORmRiem96bVllL1haTzJ1dUdvTGlrT1E3a2VISTRzc0lDVFF2?=
 =?utf-8?B?dDFhbU1NWmRjdXp6Q3ZqdWF3ZVdaWDRXWWIzTjVrMjdHMVI3UFZRTTFhUzFP?=
 =?utf-8?B?OUdxWnhQNTA3WktZYlFHY20xTm5KajFSS3RyNGtTdkVSSkpHUy83RmF2UHZk?=
 =?utf-8?B?VnZYODdqQzJyOUtJVkNKSUQxQVNTSEVlOXdCNjgyRGxzSXpPREo0RWVhTTZj?=
 =?utf-8?B?QURVU3UwMHltZ2I2RzYvQ1hmRnlXZFVEWWs5bEk5QTd1YjJCaEZYN2JDZ3du?=
 =?utf-8?B?SVRlNmYzWUlwTDNuckMzZ0puVFFBZk5mL3pSUlV2SmFsM0Q3N0JXN0h5MXZ0?=
 =?utf-8?B?Z3lkbm5pYk53c2NWOGFrWG83VUtTWWdFYU15cWJQaUVQN250NmdzZEdwbExP?=
 =?utf-8?B?ZzJJcXlYZkJWd3pabzNRQTJxN013bk1FY0FXT3hOc3BvYUFXdDJQd25oOVZC?=
 =?utf-8?B?VllFZjk2STJjUzFrelhOYUdKQmhMdG9QMGRpQnhUQmRYL2h0YnZyeTArZGdq?=
 =?utf-8?B?anNzSFdWUnlSanRkZ0ozSDczaHVIWWtxZTJPa2FHTTgzSENFN3lGcFplUEZS?=
 =?utf-8?B?VjBWbEZlZExoUTlSNmg0UXFxUDMwZndjVURkVmkvQlprdjRtTTY4SVVPQnQ1?=
 =?utf-8?B?a0llNHpiWVVTOVdmYVA0Sm9QQWZzYm42TUFOMitEdU0xWk5lcll2TllxdENi?=
 =?utf-8?B?cUpaSlg1VEJLalJQcW5PMDNGa3cySytFOWdlR3VzRGh0Sy9RTlZkc3FCYlZi?=
 =?utf-8?B?bTNSbkE0bFQ0NDFyWTRsako5SEI4Z1pyVzhKeUoyUWQ0VmRKYUNtSEk4OER2?=
 =?utf-8?B?a3RyTE9vQTlHN21KTXFVSlMwRHUwQlFnb3MraW1EUFBpdytQemdsYTdPMzFn?=
 =?utf-8?B?V2JLNWphN3lBQUJvSitWVlFNS0NRMU5uOU1qdHNtUUs0bXJzNFZLZ2R3bHBW?=
 =?utf-8?B?anhUTFVLSHJ0RkRoSW52ZGpsdm8vK0hKRmVDRjh2WHhzS3VqM2EzdzN4OW5U?=
 =?utf-8?B?emtXOUUxWncxSWxMR3VkZllmZFJobTFuOFVGRjdsK3c0VG1ubTNhWFV5Mzdk?=
 =?utf-8?B?WWVMcXJ5RlBDbW5Cazh2QlhFMzR3N2J6bjdZNUE3Wmk2WkhGeXBvVld6NmVN?=
 =?utf-8?B?SitqVlBTNG8yNkxJUTBjTnpVZTQ4MklMTTUwL1V6ajdCOWxIMkUrSU9IRGVS?=
 =?utf-8?B?K2lEdDNBYlcxYW95Y2VhTlN1YVI2Y3dsRFhIdFpmcUpzQTN4MHlnVUcvbXM3?=
 =?utf-8?B?dkVrM21aYndyU1ZGcWhKTXBuQTNqWkFPNUdqOWs2K0M0aVZoMHlLNklFZzlx?=
 =?utf-8?B?UFhsMUJqc0x0ckpudW1UYnRYYzJoMnFScmkzYVNjUi94cUJ1emFOamNsakcx?=
 =?utf-8?B?a2tVbmVvMGt4bi9rLytMMTZseUpaSmpBRWdUMW1ncWE3dXNoNFJNcFZyZlhM?=
 =?utf-8?B?aDd3aHFPUEVlb3pocmxwQ01xMDRDRUlhUUJEdExrNXdlWVhkR2NHUEhSMUNE?=
 =?utf-8?B?TkFyNnkvNEVEUW5IUFIyOUsxSlNsQTIxVHhtaUdBeW9SejNmbnoxTGJQTWs3?=
 =?utf-8?B?cnNCZW9HZ2p6K254eEdmdVdFN05naXI1bFpRWEJ5VVBPTnR2NVpPMUw3dE1B?=
 =?utf-8?B?SXZmRDRPOU1za2hZeEluTWduZzVJZEZUbUY2T3FVbkR0N0tIeFBkYmZjS2xP?=
 =?utf-8?B?cmt1WFJuTkhIc2JyQVhVQVJJa25CcytTRTd3c0V0Mld3YmMvbkprNkNrK3BU?=
 =?utf-8?B?TXRzRWJ2QTA3clorK1AwbkhmTjdnelh6K1RiTEpjUFRrNHQxYVhheWRQM3hv?=
 =?utf-8?B?UVRKcGc0cVAzZzkrSE5QcmQ4M3UvRnp3TW1iam1KU1MxSXNuU3dGaGIrWnMv?=
 =?utf-8?B?NlBONjR5TkprVXVYV1FkbGQ0TWpTanp3ZnYzeDF2cW9Ka0t3bWZoQzQ0THhz?=
 =?utf-8?B?SEh5OVBmbG5Bd0RhQ3AzRVB3aUVmWnMyaVVmenhOYlFCdTg5c0pyY2JuazBT?=
 =?utf-8?B?eEx0L2hZQzc2Ums2NjhLaXMyOGFBPT0=?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cf3vtUdCwYnwMDxyvadxy1D8F4v/9q6hFSGGhbpTj6E0w8Ya+Ec/gxWNNtOhInBKDI4zZ4yFGTuD3ViDIrr8Ee1nqJHd+kc7FL/5VczQC1c/UXBhRak8eP4rU5WNvJckB2Mld7degU60Fw936wUHFcOcjrfZdkoLjCB5jbm4IPzQwyMS9fmHUgnAZ4MGwrRVavgfYYmEHbVxQtzxUgjsDXMo/UShzBJxN6XYNIx4bNYVc7uGDW/sc8OBQ2DJ/LMTPCrrr7yTcFf7RevdTpnE38PlQXt+JR9f1dkN7aZKP9l+wlVUjN5DVuC0nAycKbz0VgcZFL9l53B7aGnV9J1H/3AtfpDvwIqBQz3YuGsJI2cFZixBahL9ri6deLS+K9Mz+yMvQt8GIXk0rliHd4Pf6F+Y6t+6jE9b9arsP6P5o2lwqZLoWBIridcgbu6QP75s
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:53:58.0063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b6978b-ea5c-4aae-65be-08de73ac284f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
X-Mailman-Approved-At: Tue, 24 Feb 2026 14:56:26 +0100
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

Hi Francesco,

On 24/02/26 15:51, Francesco Dolcini wrote:
<snip>
>>>> U-Boot SPL 2026.04-rc2-00038-g2d83c0fbbfed-dirty (Feb 20 2026 - 11:23:36 +0100)
>>>> SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
>>>> Set clock rates for '/a53@0', CPU: 800MHz at Speed Grade 'K'
>>>> SPL initial stack usage: 13464 bytes
>>>> Trying to boot from MMC1
>>>> Authentication passed
>>>> Authentication passed
>>>> Authentication passed
>>>> Loading Environment from nowhere... OK
>>>> init_env from device 9 not supported!
>>>> Warning: Did not detect image signing certificate. Skipping authentication to prevent boot failure. This will fail on Security Enforcing
>>>> (HS-SE) devices
>>>
>>> How strange. It's odd U-Boot on some boots finds a certificate with the 
>>> binaries and on others attempts it does not. If the image inside the 
>>> tispl.bin was corrupted I would expect the SPL to reject the image.
>>
>> Some more updates ...
>>
>> I was not able to verify this yet, but it seems that since commit
>> ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from end of
>> the RAM") the ram top is overwritten and our
>> verdin-am62.c:board_get_usable_ram_top() is ignored :-(
>>
>> So, the change from devarsh broke it, but before the addition of the
>> memory firewall the memory corruption was not leading to a crash ...
> 
> Some small progress.
> 
> I can confirm that the issue is around the board_init_f() that is
> overridden on the k3 architecture and spl_enable_cache(). It messes up
> with gd->*ram* variables ignoring various config options, including
> verdin-am62.c:board_get_usable_ram_top(). Any comment on this?
> 

Thanks for sharing this information, maybe I missed out handling the
board_get_usable_ram_top scenario in my original patch.

For this particular problem, could you please try with  "[PATCH] arm:
mach-k3: common: Clamp RAM end address to board-usable region in
spl_enable_cache()"

that I sent over the list/email and let us know if it helps solve above
problem ?

Regards
Devarsh

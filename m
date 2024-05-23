Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34C9C25B75
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 14:36:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05DDF884C6;
	Thu, 23 May 2024 16:36:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="F1G2oXGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B15AD884C9; Thu, 23 May 2024 16:36:42 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25EB3885A2
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 16:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLPlCYrfiW2AJ/nZY4G6hLHjFVKEdUtqkLA8eztWbejBJRN0CWHkIBLiXzFk5mYvOSMsUunqr7DkvZEeWSUuLk96CerrwNisdvP+4Dg2v9pHK/IGyDevq5gYrnVjo9LQOuhjTVd6GLjLsGaRm3VxXaG34Pi6UpoEe7BdoK/0OY6ypbG2H3/ki0pzQJbhLbrtuRtTV4ML5jHKgjHJ+xj+diLaod+V4plVnuqQJKRmMyb0hgtbU1fmhvfGTRtk8hfSJbh2cNQAosi4zba1DSnL6XvwoBdWCC6e+FxOjRIQPLphaYNFZgvPLj/pBZoDz1fVapI58z4ntZOKXklpuCOcKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5P4Jkvhtw9JBXdI4HOT9Ky/iI5e93bDoW4fX3j4cAo=;
 b=atJ+SP2zNmS+ZDEeY7a2gCrVESG53brTPzYdYjIBkQecK6pBGIfJBJv0oDGtWvLNz5IARNAvVr7aqYDdJAx7wEASdsUfgxw83OEwfkxhCxpXnlduOX7Q0pWmoJyaVtPRhXBM+1YOp3F1FGl51zQYghPdHOq9jkKRPnPZrkjvzTN/y3otqNEp9lJ+BCXMj1WBt2NHJ8N2evmtweAFGHL+ULugTw+VwwYLfTvPgWSKHJwsjYFGtUNsaCG9MzNELefWtULbDj+L9VZzQU4I4dP1TjuMa+MIAuov41FqhdxLSa97WP1dWSpKIsBa/EANBOIT40hJ5aRpvwrV9LvRPtMTkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5P4Jkvhtw9JBXdI4HOT9Ky/iI5e93bDoW4fX3j4cAo=;
 b=F1G2oXGjCP49wdEWOkhCXDzZMWvGN2JABGzO/r6vx3CJta9uWYnuJ94lQzXuGp0EfrcS3xxdYHt+LVKQj0TSnk0w6SNM/bKqOsWgZwHiolBC0bfoWJBSmnflMoLSK2n/g6eyrvowJ6TAST9zx4p9iutDFglqFes/X05CS7/kWUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com (2603:10a6:208:16e::11)
 by AM8PR04MB7202.eurprd04.prod.outlook.com (2603:10a6:20b:1da::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 14:36:38 +0000
Received: from AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd]) by AM0PR04MB6578.eurprd04.prod.outlook.com
 ([fe80::b0f9:e7f8:2613:eefd%3]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 14:36:38 +0000
Message-ID: <475aea46-a255-4a55-9e1f-29ee028996f5@cherry.de>
Date: Thu, 23 May 2024 16:36:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/42] mmc: dw_mmc: Extract clock on/off code into a
 separate routine
To: Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini
 <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Simon Glass <sjg@chromium.org>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Peter Robinson <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Yang Xiwen <forbidden405@outlook.com>,
 Ferass El Hafidi <vitali64pmemail@protonmail.com>,
 Sean Anderson <seanga2@gmail.com>, u-boot@lists.denx.de,
 uboot-snps-arc@synopsys.com
References: <20240522233135.26835-1-semen.protsenko@linaro.org>
 <20240522233135.26835-7-semen.protsenko@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240522233135.26835-7-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To AM0PR04MB6578.eurprd04.prod.outlook.com
 (2603:10a6:208:16e::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6578:EE_|AM8PR04MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2b9d40-3b43-4cf4-e494-08dc7b35c0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1hUREUvYnQ2bG50Z1JHWDdKZElFWEV4Rkt5ZDRISlpUNkl2bW5tQzhvTlQr?=
 =?utf-8?B?UkhpTUJNeUtzZDgwbW9ydys0SEJGNnR5YUNwQnRvZnc3Vk9OSVh1NjZWV3RY?=
 =?utf-8?B?MHQ1ak5KUDJ5bUR3VkRqamRNTFk1MlVqMzYwQ0UzYW40N0YzV2pkNmhpTnc0?=
 =?utf-8?B?aTFPaE5yRVU2WU84Q2ZvYzNmSk5aUzd2WWtKM29GS3grYkVtWTJqZVduMFZx?=
 =?utf-8?B?NEdLTklnMzU4cmhSR1BGelhBL0Q4dW5CaTZEQ0VpRTNRY2FkNnp5TUMwM0Ny?=
 =?utf-8?B?R1FmNDZSaWpibnZkdW9yN0JjSVpDT2ZBSTIzQzRtd3FLZU5lNjFiYXcrK3Q0?=
 =?utf-8?B?bUxPenlGQ1owQlVqODZwYU5CaE4ybTYzNmFsRXZIZXlKRWtQZS9uMHJuNDFO?=
 =?utf-8?B?V3ZFUUdGWG5qZFhRZFl5RmZ5Y0t4bEtKTUpsUmZZVkJXdS9WbDVFNGxDZ05r?=
 =?utf-8?B?OEZWWXZRNC80K0Q5WndhTDJhR1BTT1oyTzU4bVdnOFQxQmZLNkVqbGNFelJQ?=
 =?utf-8?B?VVc0OUQrbi9LM1drRk9ESVhoWGlUL3UyOUI3UUdudXRBRVBJOFhKQVlMUjFS?=
 =?utf-8?B?Qy9QR0p0WWxUUGlzcTZWTXNEek9oSjh3SUtYNEJJc09aak9UMWRIUndad1RY?=
 =?utf-8?B?Q1FLVzZ2L1J2dXltNHdvVndNc05Ec05uSU1vZTVPY3owSlFjbU93bEVpT0o5?=
 =?utf-8?B?MkVBMGtFQ2F3bkpSdmJIL1hGTTI4TGF1UmlZSCttMDhQYmYxWGV1UDZGbHoz?=
 =?utf-8?B?ZktMT3lvNHMxLzZYU3Mwa3dlc1NXZWcvN3I0WllPdTc5cjlqWUJIZmFsQkRs?=
 =?utf-8?B?c3VWekxaWldDU2ZWL1RRaVpuVG9KWXJGTGhMa2JldUhQUXVNUkNlVjdBTGVV?=
 =?utf-8?B?MWFyQlRNeFlDemZRdmgxWUo3WGlxOWxFSWZIM0I1WmExMWtMM3VNSmJ5eTdR?=
 =?utf-8?B?SWU0MWI4YUpxMk12b3BXL1ZVMUh1L3phTm5VdDVoSWhlK21Cb3J5L1hYSzhH?=
 =?utf-8?B?YjR5UmtYb0hTT3F2amFvS1gwTlNIUWpHNjZ0RGRlMHpITGJZZUc0Y2pWMU5t?=
 =?utf-8?B?b3NTWXdiTlVUSnNxL2tISHkxWjkzaGJxMWw0TUtFN1ZYS25vUk5kRFJJeGh3?=
 =?utf-8?B?Z0F4R0NzR2JoZDdvVWV1M3NndEgrc3ZFTnlUOE5SV1Z3elcxNStsVkxjNU9o?=
 =?utf-8?B?Ui9ZYW9BQk9ZYXZlekhoZDZ0TDA0T3VlR3ZhT1ZBTDRBZEd5VFJjSWVaaFoy?=
 =?utf-8?B?NEE3NnBURTluSjFqVVRuQytDWkV2b25jc0JTWHY0TUZFeHUzdm5hMlRzemhJ?=
 =?utf-8?B?cnpwMmN6N21pV1k3QS9FRTZ3aTlDRVdtNFE1ejFDYzN2UHJ2ejJyUkUzMEZX?=
 =?utf-8?B?em13RzZ5Um14UFNIa3ZZc3plNkJOTkYxd2RldW5HK2VqUzlvZ1pCL1VMeFdR?=
 =?utf-8?B?K1VqMmpBbnlVNmh5ZzdrbllITkdvZGFva2YxZHZFNjMwb25VM3J2eGFBOFhK?=
 =?utf-8?B?NTl3dlRzNzc1UEhzYWJDUWxHREFEeGxRSkJBNkhNTC9RQkJCMDN1OXZ1RGhI?=
 =?utf-8?B?d1FlT1V1STNuVkpYN3ZLa0ZHWk5McnloaGFHWW0yMnZseEE4ZU80SW04aUpT?=
 =?utf-8?B?bDZmSWplb2lkbTVzMUJiZ1I3OWJFQlhRQ1Q4SGw2Q29Ld1Nmc3hhbkJxWlgx?=
 =?utf-8?B?Kys3YWwyRURMR0lZY3RWUVZsb0NTbE93N28ySVA2YTdsRW8ybi9wRHhBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6578.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlJBOXZKSGw3KzdFR3NSOFpMS2RjaVVKVTZXb25GaktEMVBPVjZncVVnSkhx?=
 =?utf-8?B?MmZtOFg3R3FzY3BadWdGWHlzbmNvaitxZWZuT2l3V3NVbVBIUWg3U2wvTm1k?=
 =?utf-8?B?Z0VzNVBESGNhS0dNd2J3YktLdkdGcldOWDNtQ2NrQ1h1NTBma2w2WEdpQnRM?=
 =?utf-8?B?cGsza1BTQ2M1SVJ0Ymp3VkRCNmVkbVh6NThsREhabEZmaHdIUGlxYWxXeFdP?=
 =?utf-8?B?N1FFNjFvbm5wZDkzTzFmN3RTK0NrZUZFblk1K1FkbDBqUDRqTVJtZi9WL3lY?=
 =?utf-8?B?QWU2V1RVeEZRdkdFaTNBMEsyMzZMMVBMbDZ6bzVQUE83L2tWYW5UT2pkcGw5?=
 =?utf-8?B?R3NrSUJZK2IxWWRrRS9VcG5DMktaZTJMZWRhMzNkSm5BUFE3TjVvdXJPblRm?=
 =?utf-8?B?L084UGMzcHFVeGxKYkowZ1hIZyt0Tkg1enFGRHNEY3pHaFFLTmdjeUFHYkpC?=
 =?utf-8?B?V2w4VjMxUURvVDlPbEIvalhFV0RlcXIxN0xrdzFjbjVSbTBFWHQ5MnRUVW1F?=
 =?utf-8?B?MmxrczBhenduWGhIU1BNOXBKSHdHZGJQWDFpb3J4Vk1BdE85SEMwK1I5RDBG?=
 =?utf-8?B?eHBqMEk3eXpXQlNmNmo2ZXJpRTM4L1g2YnVLU21YTEVOT2dnbTI2THFacjdQ?=
 =?utf-8?B?a2ZlbDNTNWRPZU8rWW93NEZ3RE5kc2JwNkZhZWdTRGtMSGJnN0RZUzFOK01X?=
 =?utf-8?B?OE41eU5uWUdhNDB6UlRWL2FsR2lTWnZWZEVlMVgzMkNlampKMFN0Nmxid0ZF?=
 =?utf-8?B?ZkpBMXRuSWZXUGlmWmVsNkdFZHZrTG8zVkh6ZUN3QjFqVEdJY0lYbE8ybXE4?=
 =?utf-8?B?QVMrbnJyWmZqTk1yRDR1YXZrdThPRmw4RkluUGdNL2NJaFFGcEtzZG1OL3ZR?=
 =?utf-8?B?VUUxYmtZL2hWYUdZUjJ0SnVjbndFRCtaNWtkUWE1TExVQlZkZTNjNWwxQnVn?=
 =?utf-8?B?OE1pQzE3MlRjaVkwcFZiSTRwZHNtWlcwQTJuWjVnZU9tREE3Z0RIWTcvTmZt?=
 =?utf-8?B?RzZRbnRZMEE0RWN4Tm9YRTBOMjRjTG1SRUxMRys4SVJIREM1K1ZpUll3dkd2?=
 =?utf-8?B?a3Z0TTFlMXZocVJPVHFvVzlqMVJINEM2dlV2clNVUTZzenN0eUgxTW1XQ3NG?=
 =?utf-8?B?dU80VnQ5alZDS1ZhSmVOVzViZFlET1BPZjlIbmFKK2dESTl3OFk5dFV3MjNW?=
 =?utf-8?B?b0NYV2tneS9OYlY0dFZqZk5uK2dFc2NCUGJvMVJJU0hoWXE5MmNhUlFyQ1Jv?=
 =?utf-8?B?NG5yWVVBMGhna0dNdWdDZ0ZGT2VmS1g3Zzd2cmpOcElsVWs5VnVDNDFTZFlQ?=
 =?utf-8?B?MkdKVDdwZnAwSXZNZ2kyTXZOMWd0d2o3UEg0MDZNTVI0OWM4RHJhNVhTdzlz?=
 =?utf-8?B?OExwUnRyY0hUN2RSVDc0ZDE2SXZXTVliZ21iYUhrN0h0dkxWeFp6RjJFYUZF?=
 =?utf-8?B?RlJQaDBvUnRHTXFRNUpsQ21Qeis2aG5rWTR0K0JwNnNTTWtMeXB3dGxiL3A0?=
 =?utf-8?B?NWk4YnBZUjNTRDhxSFppL1BhSGFqWHRXWWtGV2FMdm9TSmF3L01VZGtMalBR?=
 =?utf-8?B?K2NZZXY2Z1lDQU5kT2hucU5JY1NGRW9meDh4MGhCeHlpOUMvb3VVbVVYZWhn?=
 =?utf-8?B?R3FDVzFoNTJ3ZU9VNEZORndyMTM4TElOYzh3eHJJR1Rtb2ZtYk16TVJHVVhl?=
 =?utf-8?B?Wmc0S2NMd1kzMXpsZXNDKytISW0wQUtOQ2tVb2ZETTBwV2dsMTQ5eXBzVjNk?=
 =?utf-8?B?WFFPWGpEWUJoYm1KUXdLMU9Kakg5bS8wQmNTaGJRenFWRkVjTXJWSW5hOXlq?=
 =?utf-8?B?QzlxTm1FdytSR3JMc0JMdzBpanFON1ZpckxXaVVkU1p4YmxpVG5aNmZHUS9D?=
 =?utf-8?B?L0hLMFpkR2dVVit0aGp3VHlsd1EzTkdiQWY5Sm9xZU91aU51dUJYRWgzZXo4?=
 =?utf-8?B?Tnl5aUt4TDkzb3RyUWQza0NWMEx0bmJKNTdkOFZQZnZBNGpTMG9rUy9HUXFu?=
 =?utf-8?B?QTA2T3NVSzcrR3ZFU1B1ZnhRKzRaQUlaZUtJaHRwbGYwdDA0NVd3NFJXUWho?=
 =?utf-8?B?bDM4ZGFReWozQnVYcjZ4RGN1WEVYNGt4b2R0aGtlcENkUFBFWkJxL3EvenBW?=
 =?utf-8?B?SzBJRHV0QUt5SmJhMFA0cEhCUjVPQXY5VUgyeU1iYXNEaGU3NzJuY3NNbWJa?=
 =?utf-8?Q?jCPnG9VN29XNbEv0BEoPnAE=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2b9d40-3b43-4cf4-e494-08dc7b35c0e5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6578.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 14:36:38.0618 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOd0FiJB4guFIMF7FQ5nNFjKFflcC6gKAgyBS36gOh9HO3GScYLSoRjrLDe1/vt657GwKTU5qpiNmIv5d2t5zQlWn4V6E05o/6HQnL/luOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7202
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

Hi Sam,

On 5/23/24 1:30 AM, Sam Protsenko wrote:
> Extract clock control code into a separate routine to avoid code
> duplication in dwmci_setup_bus().
> 
> No functional change.
> 

There are some differences though.

> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>   drivers/mmc/dw_mmc.c | 60 ++++++++++++++++++++++++--------------------
>   1 file changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/mmc/dw_mmc.c b/drivers/mmc/dw_mmc.c
> index cbfb8d3b8683..40b9b034f793 100644
> --- a/drivers/mmc/dw_mmc.c
> +++ b/drivers/mmc/dw_mmc.c
> @@ -412,11 +412,33 @@ static int dwmci_send_cmd(struct mmc *mmc, struct mmc_cmd *cmd,
>   	return ret;
>   }
>   
> -static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
> +static int dwmci_control_clken(struct dwmci_host *host, bool on)
>   {
> -	u32 div, status;
> +	const u32 val = on ? DWMCI_CLKEN_ENABLE | DWMCI_CLKEN_LOW_PWR : 0;
> +	const u32 cmd_only_clk = DWMCI_CMD_PRV_DAT_WAIT | DWMCI_CMD_UPD_CLK;
>   	int timeout = 10000;
> +	u32 status;
> +
> +	dwmci_writel(host, DWMCI_CLKENA, val);
> +
> +	/* Inform CIU */
> +	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_START | cmd_only_clk);
> +	do {
> +		status = dwmci_readl(host, DWMCI_CMD);
> +		if (timeout-- < 0) {
> +			debug("%s: Timeout!\n", __func__);
> +			return -ETIMEDOUT;
> +		}
> +	} while (status & DWMCI_CMD_START);
> +
> +	return 0;
> +}
> +
> +static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
> +{
> +	u32 div;
>   	unsigned long sclk;
> +	int ret;
>   
>   	if ((freq == host->clock) || (freq == 0))
>   		return 0;
> @@ -439,35 +461,19 @@ static int dwmci_setup_bus(struct dwmci_host *host, u32 freq)
>   	else
>   		div = DIV_ROUND_UP(sclk, 2 * freq);
>   
> -	dwmci_writel(host, DWMCI_CLKENA, 0);
> +	/* Disable clock */
>   	dwmci_writel(host, DWMCI_CLKSRC, 0);
> +	ret = dwmci_control_clken(host, false);

Here, CLKENA and CLKSRC are swapped. The kernel still calls CLKENA 
before CLKSRC, is this really safe? (I have no documentation so cannot 
tell). E.g., we could have CLKSRC register be a way to select the clock 
parent/source, 0 could be 24MHz crystal for example, so switching to 
this new parent before disabling the clock output would likely result in 
glitches?

> +	if (ret)
> +		return ret;
>   
> +	/* Set clock to desired speed */
>   	dwmci_writel(host, DWMCI_CLKDIV, div);

Same here, CLKDIV is set now after the CIU is informed, is this an 
issue? We may want to set the clock speed before we enable the clock 
again. Right now it's setting the desired speed while disabled, inform 
the CIU, enable the clock, inform the CIU. This now does, disable the 
clock, inform the CIU, set the desired speed, enable the clock, inform 
the CIU. We may need to wait for the clock to stabilize before enabling 
it? Again, just making guesses, no documentation for me here :/

> -	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_PRV_DAT_WAIT |
> -			DWMCI_CMD_UPD_CLK | DWMCI_CMD_START);
>   
> -	do {
> -		status = dwmci_readl(host, DWMCI_CMD);
> -		if (timeout-- < 0) {
> -			debug("%s: Timeout!\n", __func__);
> -			return -ETIMEDOUT;
> -		}
> -	} while (status & DWMCI_CMD_START);
> -
> -	dwmci_writel(host, DWMCI_CLKENA, DWMCI_CLKEN_ENABLE |
> -			DWMCI_CLKEN_LOW_PWR);
> -
> -	dwmci_writel(host, DWMCI_CMD, DWMCI_CMD_PRV_DAT_WAIT |
> -			DWMCI_CMD_UPD_CLK | DWMCI_CMD_START);
> -
> -	timeout = 10000;
> -	do {
> -		status = dwmci_readl(host, DWMCI_CMD);
> -		if (timeout-- < 0) {
> -			debug("%s: Timeout!\n", __func__);
> -			return -ETIMEDOUT;
> -		}
> -	} while (status & DWMCI_CMD_START);
> +	/* Enable clock */
> +	ret = dwmci_control_clken(host, true);
> +	if (ret)
> +		return ret;
>   
>   	host->clock = freq;
>   
Cheers,
Quentin

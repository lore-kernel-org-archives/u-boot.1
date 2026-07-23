Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC88C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 10:50:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40128408F4;
	Thu, 23 Jul 2026 10:50:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l421w69wRxZg; Thu, 23 Jul 2026 10:50:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4D8D3408ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784803833;
	bh=vR17tD48q9zPLoYp12HrMLjk2YahNgZiBtf9U6qQBKM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=t4n5kb0F6eVFwWzRn0Ojr3V8i5pSoVs3r/1LREsKsgnQpAlAUYa10Vm/D7AyPsv22
	 Sn59B1yheZlujaBfjhk3nbVrRzwGmttElbwIkhmYd00Q3UDEx7pym8aZDhAxUc+552
	 A2gAb+O/UB+Orn98AmvRlyoxO6+EWrQ9X7krWbkdqL3y9eHWhbj10qeI7L4zKHCzUE
	 aCrj4vGYFUxMAcm8SScFV8DmI5gcar3AML4UERAVjJTNY3Zpf3X9KoJ/RGS7TJPTa+
	 qd9frBxwIMlfFlyBSDM4I1C9E27OJQU8WfA/PP8NFLTvjJIhmawV2mWIO9SJEeYCGC
	 tUO6omP0PK7WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D8D3408ED;
	Thu, 23 Jul 2026 10:50:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 91AA51B8
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:50:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6500080F8C
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:50:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0ofRJsrWMHAh for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 10:50:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 97D7580F87
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 97D7580F87
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 97D7580F87
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 10:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jYXfnMSJlvRzv0f/v8Rt1vhtCpK4mgmYhR/VOBJoZ6eyz1iSuCb2B+nGe+IRtcaVJLzFbJO3cleL13SLbRGtuZLRE3Z/azuis9+qLj7ujg4xwnFWb6YWR9NftkhOE+rLGYpO2EZYj9bYyRr7j9V2gy4ABjpZ6lEZoJK11n7b/lhzIuyIxwNZjq9nK5c2+YK0hkHlknANeekuThsmq6L7IlhtsQz41Pwaj6zLULtRlAE7UQN5oSMeKLcsS1gzGKzT34nghetd7YBiUK1zBL1cW2k0C1BxhcQuKdIIvP5Do/lKLzS1iii6M50EwHupq5fw3celrrMkYbogcCtVMsXRpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vR17tD48q9zPLoYp12HrMLjk2YahNgZiBtf9U6qQBKM=;
 b=YInRZwrGy9ngUF+DBLBZbWmqlx/1zFB2KtKQDeSldetpZOUKGdKoJKKIdA2gQ19gsYHKlCEkHueY+Txf3Bj2M2fRYomUNfwMi3R/AlbCJnx1XyIK7YYh9Py7j1LOhYTGEfO/vyX97w1GLcNtUhjPSev46VeYFBbrxqlROIs6s5QIinnWVxJGhAfnIqi6RiHFYh/QHexxAOvo1fQnykQNzPcSbMeX0+lnqIRHbY1Wh90KJCSxo9K5zoXg+0HlQ3M4YhyWE8WtMuaQ3XBW4bNUPV88spCiz3I6TAUzMqBsl/QHBnu75CiIqr5vM9mFTs7pGxqdkIWQTsdnf8O8jDXbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PA4PR04MB7920.eurprd04.prod.outlook.com (2603:10a6:102:c4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:50:27 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.017; Thu, 23 Jul 2026
 10:50:27 +0000
Message-ID: <26b79a65-369f-4478-ab1a-8a913e1b8aea@cherry.de>
Date: Thu, 23 Jul 2026 12:50:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] rockchip: roc-pc-rk3399: Enable redundant
 environment
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, sjg@chromium.org, kever.yang@rock-chips.com,
 u-boot@lists.u-boot-project.org, Fabio Estevam <festevam@nabladev.com>
References: <20260722194638.1285159-1-festevam@gmail.com>
 <20260722194638.1285159-4-festevam@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260722194638.1285159-4-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0001.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::19) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PA4PR04MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 20f325f3-5450-4695-9884-08dee8a834d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fM/r4ksiHkq7+LjDq9iSWaXhHBcCnwxJN2srjS4BY7PHp5lUCJr5RC5MUhKmkrN3zmNAkFp01Vy6N0kA7BcSbKxHxXqELUUh80Rh0XXL71bW8WylxI6ePLdA+EasDWHEQbafCgKTMlnK1h5N8Aj/0Q2kwApsWQbWiPelaITzfhRIMorALYd55wbKywNbEAiqn2AlL05qKqcuwOcAzzoFTlA1EDV1mj51XV7AYapO8H02Q1oDvDt8rGGdNHcrEOTTckyrXIDmJ81oVvrjo9wH6upjlJVDBQCEe2y+RihMyWj8mjIqd3I1TBjZgZVzljc/pQQI2wAOXB1jXtzoEjCJsBlZICYR/n1xKBUp1dkD6tV7y9eIqmMtNPEHwYqCRLpj9D9qIlsNJzy1TO5WXZn88Pe73qjYVlkOjsd0tP1Baq+JqLw92GCjDGM2Fl+xI+976TmSjHUzFa8Ikct6uz2/lTa2MKB3XaZIBkO0zRNNqrEb39vguml/vGTApPIHab6wi6ld24dKCqOYrNzzr7Fz20yS7vKONGDciK/dHr5691k1lS6G6JQMELK7hj+vLaLCc0g9G/NZMz4ZPOJFRc1blbJfTrOjFAs9ANuzH8DBk06HiMFRol1Us+nhcJArPCFnzGRkiGyQNBu7pccmDUeQX4k3MTbTfJzCPKTY7OS3zTo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2MxUzJPamxNU0ZtQzlpZk5tUVJDeXRSbkJzZEJIRnpQU3pNRXIrRjY5c1pI?=
 =?utf-8?B?bW52d1paS3M2WVF0a3Z2TFJLS1h0MHNYRjJsdy9TWGdxQVZYVEhJRXFTem9M?=
 =?utf-8?B?cXF4eVQ0NnNjVkVJVTE1cjdFbjdPNldJV3JxM1RNUG52UmYwdUgwa3liMW9q?=
 =?utf-8?B?amNGWGtIb3lDcXlwSXcwS2srYnRhYndyYkw4NmFiaklnQ2FiUXQ5ei8wWkN2?=
 =?utf-8?B?NXNsdElUcytncDV2MzVJdm1FdU85clBNektpSC9HeG84N1VFaTlwaTJ6RXo4?=
 =?utf-8?B?b2p6UTNYekZmTC9uTmdjWm1Nd1BxUVlkMTFIdVhEWk5pQnhqUnNYL2lWZ1lh?=
 =?utf-8?B?STBpUmdOV0Q1dXJTa2I0dUNzOTdYQUNzZWFTUE9NNDllSGdUdzVMTG1sYVRP?=
 =?utf-8?B?SHBlL2c1cVBwWW9nT0Z0VW5TN3Nlb3BFZXZYaCtUK01ZMCtML3hmR3ZXdzc4?=
 =?utf-8?B?THRQOFZITnpTT0NSR2tFVWJDbnZkU2lJMzJ5dVBWR21NdmFDbTBmVzBCRnli?=
 =?utf-8?B?Y3RQYXRpTEdYWHdMVWRDU0FJUUx4a2RJTStFZkw2b2xRTCs0Zmc0RWxTb1l6?=
 =?utf-8?B?ZDV5UHA1UUN1Skc2NEZ2akRnYlIvdkFkVCtlc3VFMHVhalpGT2owdTRNZXBG?=
 =?utf-8?B?N0doWHhqb2VIdGtCZWJreGU5NjRiTzQxUFdjYTU4bTNCeWZPdS8yL0o1aXpU?=
 =?utf-8?B?MVpDdUlMNkJ3dGZDeisyTjJoUWhkRjVHNE5iNTVWanRsTllhbVMvWVRDaDV4?=
 =?utf-8?B?a3pXZEpldFhmclZlK2t2b1hJSDNxWWZqMXc1REVyNERsUmE5ak5Ucm5XYmtw?=
 =?utf-8?B?VHZOOXdnamZ1VlBSWnJYdVFQOUtUb044V3R4WGoxRzcxc0xvOW9oT1dwSG1I?=
 =?utf-8?B?U2ZTU0R6aVJtbFFFV0VvQXYwQUk2aTg4TlNQRHN1VCtyQ2IzNFNreUZ4ZVQw?=
 =?utf-8?B?QUdZankzaHpXQmhRT0hOR1daNmU2R3RYWHR4R012a0l3aHE4K0ZTN1hOMVV6?=
 =?utf-8?B?LzBKajJvRnlUcFVLKzNpZ0xETERtNDlTalMxeTRhWEgveWNWNXdFQW5QQVRV?=
 =?utf-8?B?cTI2bTVLRm5hTitSVENRT0pBcCtvTURIWTJVWWUyT25YNUpCTlQvQnBtejhU?=
 =?utf-8?B?cjNQeGd3ODlGMFBnNzdOTEhDR3V0ZHlNMWhvYXhrRzV2Wlp4ZWFsazJQczJV?=
 =?utf-8?B?Tm0yaTQxeTVEby9LTStJdHNZbHVkbmpwcWZqeTZBRXJ6NnlGYW9pOEg3YUZl?=
 =?utf-8?B?R01Mai9iNVZmSzFsUDNib3FRWDF5d0Q5c2w0QkJtMCtKbjIzY0w1aGg5OFQ5?=
 =?utf-8?B?emtWbzRweC9VUDErR1B2SzJlbWtzcjZaWFNtaVFRR1hvQjJQZWlnd0JQdDZU?=
 =?utf-8?B?OTV0UUVpTHBRNEcwbURqaWZaNms2cEdqYVBDd2g2WG5GZjhDOHFGb0E5UC9n?=
 =?utf-8?B?clp3QzlnMzVwVm9oUmJnTERUNmlHMWljWktNUE1MNzVMMTNLK3VRcEpRbW1V?=
 =?utf-8?B?eTlHVDU0Z2taTTUzN1lZbTJKSlY4c3JTb2g2Mzk0RzU0SUpWYzg0U25JaUtW?=
 =?utf-8?B?dzFITkwzRjlLM1g1Wm8zMVMva0o3a3hrc1RlaVJSYUxBbFcxdi9ycXJMbW4x?=
 =?utf-8?B?WmpMVUkwZlRZQ1J0d0RCRTdaQkx2b0p6WmRKcHhGUXZOcE54V2srSlBpU2lC?=
 =?utf-8?B?T0VpdWZhNEhzcXVqVFdpUmY4QXpFK0p3c0EwRHFzYTdzZWQwZXN0UnRLSGpw?=
 =?utf-8?B?anhGbHhGMUlPTVNCTURmcEVhS1QydFpQRlZta2VES3VOQ1JBSzBab1RTNU1T?=
 =?utf-8?B?bFFQYTNuVk4yVWdJMmlxN3A3dG9jL2FqMWEzZjk4Smx0QXF3VWl0YWplK3ZD?=
 =?utf-8?B?eDRkZGtUSnFHa0V6TGo3aldPdk1TL1hUV0hXNEFscHlRamxaS1RIMmJNemY1?=
 =?utf-8?B?NlI2UzIxWHJFRC9tMG5NcnVINWlRUlJRMWJRRVArVmF5UlhEa29CaDdSQVA1?=
 =?utf-8?B?ZkdEVzI2WDFOWDYxdDgwcFBLUnl3WFRseE96LytJZENVMUNBaTh0cnZXRTJH?=
 =?utf-8?B?QnYvbUFob1Z4TUJCMXFCb3NhQlFWSGFhNjhweERJR28vcG9aSkRhV3YwSnhV?=
 =?utf-8?B?MlpMaENWV01LN3N5Y3JlTC9VM3RmTEczNm16ZkIzZWZHbUhQNktNSTNCSHN6?=
 =?utf-8?B?cU43WVg2WnQ1MzY3RXQ5NTJNZkRTZllFSW1oTDVMTGN5aGZvN3p3b0pUUTRZ?=
 =?utf-8?B?b090dEdPai9sZWROMzVyc1BiR2JEdEl0WFdSV3FlRGJKWm0rU0RNczJSQ21H?=
 =?utf-8?B?bXFQODNISFhXd3JhQnVYNWZidjAwV3ZpRldqSGxyTkFwb3lwdjZWZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f325f3-5450-4695-9884-08dee8a834d1
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:50:27.3009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFZXZO8FE9ypuCkaNV5TsBc8Mcg0hduPLvut+hGEcS8aS25fwIYFO1mdqe3MbcNFz2xclmd35VkloYdgrDwCrBp0t/GFST23cyF/CmnEAtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7920
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vR17tD48q9zPLoYp12HrMLjk2YahNgZiBtf9U6qQBKM=;
 b=F2/dyvp9lyPkYxV3//Wu8cgKxVANE2Txeork4fLnfRAf091voZDYulVUjVNhXorum6VOUtLGI6k71LNdYrdFg2r3qnKgftTDL9w1tDJ/QW9z9uENhM+hsfgf4NtDldQrgvyLxHxLQhU5cWWC7POAXt2uWd+1S2M1dQ59Nocb79Q=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=F2/dyvp9
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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

Hi Fabio,

On 7/22/26 9:46 PM, Fabio Estevam via U-Boot wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> Keep the primary U-Boot environment at its existing 0x3f8000 offset and
> use the preceding 32 KiB region at 0x3f0000 for the redundant copy.
> 
> Both copies are aligned to the 4 KiB erase size and together occupy
> 0x3f0000 through 0x3fffff. Redundancy protects the environment against
> power loss or an interrupted update.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

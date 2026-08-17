Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966D8C5DF66
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 18:18:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 411AC8113A;
	Mon, 17 Aug 2026 18:18:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZZ4sOiVmhVA; Mon, 17 Aug 2026 18:18:03 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2BE408113D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786990674;
	bh=ipdrXAqXYhoX9Enb+DNliQsSZuyPo3OBHTmPLbXngHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RrPcHZNcqHzYlJqI4OeyVihF5n14tirIRyME/HUB7Q4L0G5LvP1YRCuueeNRwkCyq
	 PfjpCPVuSdXxmhoW74Ii6N9RQLDbxMnWKdKtQX1ZgkRijDpicobY7eejbuVviHzeQE
	 sZpBsx+v5qwHeqU/ZvOQbYa8caLSWCRWRuE6KlQFyAWHaNQqnBUtcTCtrENX9ZOAsd
	 y0hBKuWhWgRiSL6LNkGIXH9wdYqLa5xvNIQCuK0sN5EPNp3lH8bAEw7FIEksC3GV8u
	 KHeoLFKMq6gnY/xFOQe+IB+EQmim91rP2Hj6/+zxaofvRv+KkyaGN2PBBpyNiQCdhD
	 MWTVxhlr3Oecw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BE408113D;
	Mon, 17 Aug 2026 18:17:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0FFA123F
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 01A1280D8A
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ErVKhILEUKMR for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 17:34:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:d100::1;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=macromorgan@hotmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 31CC980D83
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=hotmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 31CC980D83
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hotmail.com header.i=@hotmail.com header.a=rsa-sha256
 header.s=selector1 header.b=hQH+XTtR
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazolkn190120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d100::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 31CC980D83
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 17:34:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcKcQj6/0YrjG9UfdGQ1zv6TyqLFXrlDSdjBxg2otExKxifRmdQNaqhTCfP11cQIX0OHv/qiy7WkUBX8Thv82ey/uMzzRFZGV597rNHGCNyVbq8bOVKNgK9xz7Ox3N/DZdzC4AM+y/6duYjAI0k38/CBhKL7Q1k795vPsUL+y9+k6qt1cuwFehzL9rQLh4cA57VfvOxt05ql7Uz1pIn2Btw8wrXLFCFyTKix4mOhmnMYMp/XBojVNf5v9n62+U6v3NhSOEjRGUHfMw4XezXXjpJtGf+myQGxEHLuvVde4wu8c4LRsiQbRO7JMFpfVBvpgUyHENhgC2oQAuybecgJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ipdrXAqXYhoX9Enb+DNliQsSZuyPo3OBHTmPLbXngHk=;
 b=FNekCsJWd7F5mALLt2kNJOOeBg7sOJRAXCBJlxhqzzJMl3q0iGAr/qr1+RHIXZzlEZXB62BGhZCx0YpTvflcDRgrjnys1Nb/HXUocJyK9u9004+wLtqdKYDrJUIY+sbzOL30i/g2MEs6vNHw6SQ0KVy9T8TMZqywb/GkRWOeY+eqWqYneYzU5E+9Ijvz/CAVUg7XlAUfv+kPFwxMI5ac61Y9/S6IyZES8a5eRubTtX/ADI3967KUUT4uwvkzgLSrG67C8pEDw37rJW7oaPqLwk6zlg+uzScT3Tw3tCYY+VYAz+3Z1XESZa1tirQJezfGwi4fz2MhpWEwg/wZPSNtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ipdrXAqXYhoX9Enb+DNliQsSZuyPo3OBHTmPLbXngHk=;
 b=hQH+XTtRo7ufyUOSRuLvphsI1fXVzlrxAFO0Nm8V4e/VJuPb6VESdhryVv61NEbtWystNXs8l7mH8/HztYBNScaA0ZZZ2anl4igd7ujTzInDgXMHIrQVRHhQZYQ5xjimhRqpfLOZbokhn5qSmlHEuIfzSwYuHnLXgObLrr2F82dQ3v6iD7v0kHgVy6wcyXEYmQuuSwN9HVYNVYdeJos58BUe+sUv/ZglMWzii/DIGGOlQwg8QtZ82HDWoYFQtZWrA/d7WcOU2b9TSZdJX2waY4SamDo7WJ8/MgpKbCcejlVeT81su7cTaHnjfCfeFaDnBeIW9qYCnhfE9u3Ox8yZdA==
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18) by DSVPR19MB997406.namprd19.prod.outlook.com
 (2603:10b6:8:45a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 17:34:52 +0000
Received: from PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172]) by PH0PR19MB997338.namprd19.prod.outlook.com
 ([fe80::fd22:ee23:3e25:3172%4]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 17:34:52 +0000
Date: Mon, 17 Aug 2026 12:34:49 -0500
From: Chris Morgan <macromorgan@hotmail.com>
To: Daniel Martin <dmanlfc@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
Message-ID: <PH0PR19MB9973381C3D06EF7593AE50C56DA5A72@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <CAOyTmd13R7_fan-iB8qK55AFZoba+RCi4VT-GOa5ot+OZD__Rg@mail.gmail.com>
 <38c0d683-46bc-42b1-86a1-345b2070084b@cherry.de>
 <PH0PR19MB997338FA72B2980A64B4194127A5DA2@PH0PR19MB997338.namprd19.prod.outlook.com>
 <CAOyTmd1JvBqRiuBPcLxkhF+x6yws6uOQ7z6vZqq3jrZkgj7+tg@mail.gmail.com>
 <an_Wqkp09sxijfxv@wintermute.localhost.fail>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an_Wqkp09sxijfxv@wintermute.localhost.fail>
X-ClientProxiedBy: SA0PR11CA0078.namprd11.prod.outlook.com
 (2603:10b6:806:d2::23) To PH0PR19MB997338.namprd19.prod.outlook.com
 (2603:10b6:510:3b1::18)
X-Microsoft-Original-Message-ID: <aoNGOZd8wEA29mHx@wintermute.localhost.fail>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR19MB997338:EE_|DSVPR19MB997406:EE_
X-MS-Office365-Filtering-Correlation-Id: 86950374-e119-4212-c601-08defc85d7ef
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|51005399006|24021099003|55001999006|8060799015|19110799012|37011999003|12121999013|23021999003|25031999004|6090799003|25010399006|5072599009|40105399003|2607281247196008|440099028|3412199025;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DOVYbHIiTzauPBSKzhg/7cOPGpT/yUk3nt46niHTuMmCIFw4tZTdN2ZBGlYP?=
 =?us-ascii?Q?OoiASRTCFZVrwVxIm6e2P9GljGCV9ORNk+P+R6QlOghFVPNtr8M7TMfqkAdW?=
 =?us-ascii?Q?obHX8GyNpgDYcQG/S43sPRs6iaBPrgHfX5rmL49znFLJKGUZTee3PGp/nlOz?=
 =?us-ascii?Q?a0x43DL8WT2hc3cclXNwji0gJAzYYFU92yZx6lc4JFTOmXSBqXjcn0/XVIyc?=
 =?us-ascii?Q?0hLzE36wD4oJ/Z+IwF3U0wNvpDzV+mncNVqoGIVTm8mrKq6BPX1Lw3dP/wQm?=
 =?us-ascii?Q?kw7BvCcumSdWk30LsZORaTFd9bw67KVY5lcNSyjg1vyDr+IrRkJwRzkP+YRz?=
 =?us-ascii?Q?7bou6Qlt9RQwXpxELSPI8rpXQOkY3R+w5gwGBGmPNZT03tJcBt+iKphEl9X7?=
 =?us-ascii?Q?nDljmPfarPOaar/T2dl2hqF3mNK6AHp0BHnqE6ZjaKwM4vkiW+g1YL6Y6azB?=
 =?us-ascii?Q?M5so5u6cJlBq6aOwyEWP+IgT9faaIkNA8AOBaBwQpExIFWui1qpXJRYf632b?=
 =?us-ascii?Q?BUJlTDOZCi3qQPZMCBOuYb0RRopY+RD3FismXjVNjf9HrSPWZJQ5duMBnjuV?=
 =?us-ascii?Q?TxSBasoLnTvu7jJGBgMUprO7rOPNF8vfRgR2SHLmIQpXbKAaSjkcLAleh8/N?=
 =?us-ascii?Q?5DGEtd030bDGQyHsFLPxuNWmMiTCEfJLxrlP9pBqWqRGBMUR1+d9mtXH5X/E?=
 =?us-ascii?Q?c/mCtGTswjPjNQSq/5PWLbxxud0RXVur+A1MqUVVFWeyZtpZuh9H/bpNEnfe?=
 =?us-ascii?Q?2ZCYgXpStXnw5rbIGZ3uQ2u62ErJFHFiHWvr4RoOprYrRTYxxNznA/GvayKw?=
 =?us-ascii?Q?ROZ0Ba9a/2YqDocdWtgVzEj3xZLil3gwc86j8fvjN7W35hCd5G0QIFhQodNR?=
 =?us-ascii?Q?Cxiwj08JlpHBWr5Nu6ib8OJUsGPlr1X+Aq4TAyG/5MN9zfTRbag/0BFPq6CI?=
 =?us-ascii?Q?5oM5F2Ar5ujeFvgMoRwshD9gRfqiml2DWJcHX870KpzRWk2LtYE+KSVuLyQ0?=
 =?us-ascii?Q?IDV7itFb3NpXXhczW844HpFYEf9PONollrq9J07vT2U2vupi+HL0gyE4+1nf?=
 =?us-ascii?Q?T0fir8r/p1jS0D4aA1xCcZkM07usQQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I2rInJsT4DXJwJXi9+v8y5e0ZHV6MUDRvGV4VF98K7nfa+K5eOkYZv7c4bkP?=
 =?us-ascii?Q?RO3kX/9A0782+RZcVjTzxkKvI89DFUMzJue8A38ONFZRxq5U6EK8jwaDCHjs?=
 =?us-ascii?Q?IfYLjk5qgXWe6ns5hyECIw3t8D7x2Zj6sA+5wMP3Ekj3cISxw7bKLM/YufAG?=
 =?us-ascii?Q?yPhs+J7UL/+lT0ehy4nza5A36S8lyxAlctkuqZtoCfZUZLQcggxdPZZ9cb5P?=
 =?us-ascii?Q?8r7ekKf32rIEO9Vtp2r4DM6VHKY1A2puJkt1Dgl76tN3hi4N9cDuGBOTwrjt?=
 =?us-ascii?Q?46Jyark6ZNeIVQegQM34UzSL+jmCi47uh3+YUmlONHX9547X7weJLXmiz/+M?=
 =?us-ascii?Q?UWujvWWF7nmoTdg17SK0oish9ZWWKEDr6+QiVNuLEu2tiMT4OCjlGxBjcBPM?=
 =?us-ascii?Q?p1xOXSsedniu/sfOV64IhncWmBNP/g+wF+lm1e0mjrCMIXFg84vWXZObRetN?=
 =?us-ascii?Q?aRCK9JTP5/4eeLsmqVgyzWxHdhaTda8sRCuZgsKUkv8D9xS4JPkBn7svV/1k?=
 =?us-ascii?Q?GepR5dh9ahQqyWWqrhT5SHXabF6piwcRqa/Cx7AiydhaoPTBVbfJ6PQxZdJ4?=
 =?us-ascii?Q?3Y5zRf4Ywu6355gNZnjxPzlaSYncW8eka/uxY810Qz3D9LBQp5UaE/AZbP+B?=
 =?us-ascii?Q?07/plp58+l0BV7jOWpg1NvFsID6/vWSsLFCfVYtSumyTfqoB/K1z6yY4C6/6?=
 =?us-ascii?Q?awFZqQWqugmCqty3pM8ypX/BIeZfYmG/cqJGfdbKPfGaGjKwfTzJGyuRbK4W?=
 =?us-ascii?Q?wmFkAzVw4JkRDTiLIkivVLxWkM4jSTGPXgINT5NNO7HDG0BpA9TfcYTU5yOj?=
 =?us-ascii?Q?xCr/AC5qlodnEusEJORGUm3wX2Xg3Rv7BU/8N+tupPXcL2qENhkaAEBThCkH?=
 =?us-ascii?Q?Y8QU3x9qUtfg7hGvTOqNuiXNo6fQnQM04WFJ0akuEZAX6PThg+VxqmDMdj68?=
 =?us-ascii?Q?2fw8gh7fUiDnB5RBS8tnRCCqDLWzrWUDXzBvRzotQYlaQzvpvPV68N/7pLlh?=
 =?us-ascii?Q?AvGmLysM7TxjZbmE2chwq89pdxTvzVX5dtvajXSbE/pQwVXHbsYy9HARgyXd?=
 =?us-ascii?Q?65YI5RBj/BQZJxUQUg1X9iQbsbDp35tjUlIXaoYSdR9tIWJiuWIhKcOwM1c3?=
 =?us-ascii?Q?BxAxIdzbGc2pjT/CmgCOWiaceFM4MDuKGTWe4/yF8v6/nX+AsokyLHrqsLZH?=
 =?us-ascii?Q?l0QKeCOj7KutPhFs6HzMcN6VzCnc91m3CqnBBOG6JwkvpVm9WKluouhmMUAR?=
 =?us-ascii?Q?1fEkRPzFoe3mmkANDXZBsltGM93a4Ei2GUX8j4ivllSW4/Bst6bKY3pTB8dq?=
 =?us-ascii?Q?+qgjz/62UfjkwAnPJJ12+o51WmggH+ci4CSnl0evluZWrB4D2KVHy495JSoD?=
 =?us-ascii?Q?mvKAkYRxtxBnAhX3X1M2hHhJOIHle7kLjs1CMnO1q4bNQhfYOYT4ePTnvIHE?=
 =?us-ascii?Q?ATARlVQOTONgTTlq4CvrbLVKmQ4eH4Iw?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-990eb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 86950374-e119-4212-c601-08defc85d7ef
X-MS-Exchange-CrossTenant-AuthSource: PH0PR19MB997338.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 17:34:52.1573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR19MB997406
X-Mailman-Approved-At: Mon, 17 Aug 2026 18:17:15 +0000
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

On Fri, Aug 14, 2026 at 10:02:05PM -0500, Chris Morgan wrote:
> On Sat, Aug 15, 2026 at 10:06:23AM +1000, Daniel Martin wrote:
> > Thanks for the further details Chris,
> > 
> > It would indeed be great if we could move this device to mainline end-to-end.
> > Let me know how you get on with v2026.07 and if possible, test your
> > DTS with the stable kernel (7.1.8 or similar).
> > When I reverted uboot, I encountered inconsistent I/O issues with the
> > latest stable kernel, therefore I ended up going back to the BSP.
> > 
> > Thanks for all your work, we appreciate the effort.
> > 
> > Dan
> 
> I've just tested booting the device with a completely unmodified
> version of Arm Trusted Firmware (checked out at tag v2.15.0), U-Boot
> (checked out at tag v2026.07 and changing nothing from the
> gameforce-ace-rk3588s_defconfig), loading Linux 7.2 (tag v7.2-rc7) via
> extlinux boot method and it seems to be working. I do note that it
> seems to be slower to boot since I upgraded A-TF and U-Boot to the most
> recent releases, so I'll troubleshoot that some more next week as I try
> to install a fully up to date Ubuntu 26.04 on it.
> 
> I know you said it's hard to get a serial port on it, but if you
> continue to have problems booting it that might be required to
> troubleshoot it further. Otherwise I can send you my binaries if
> need be.
> 
> Thank you,
> Chris

I'm afraid I cannot seem to recreate the problem, and I'm going to need
a serial dump of the kernel logs. I'm sorry to ask that of you, but it
will help further debug what the issue may be on your end. So far I've
tested using a mainline kernel (v7.2 checked out this morning), U-Boot
v2026.07, Arm Trusted Firmware (mainline master, checked out this
morning OR the rkbin version, rk3588_bl31_v1.54.elf), optionally with
Optee (master, checked out this morning). In each case the device boots
successfully for me running Debian 13 (Forky) with my own mainline
kernel.

I'm going to test installing Ubuntu 26.04 and fusing some OTP keys
later today, I'll let you know if I encounter further issues.

Thank you,
Chris

> 
> > 
> > 
> > On Sat, 15 Aug 2026 at 07:40, Christopher Morgan
> > <macromorgan@hotmail.com> wrote:
> > >
> > > I'm having trouble with my usual email client, so I'm sorry if this message is formatted weird.
> > >
> > > I have tested the device most recently with 2026.04 with the default defconfig options. I am using mainline Arm Trusted Firmware though, not the Rockchip versions. Using Rockchip's A-TF should work, but again it's not something I've tested. I can note that if you're using mainline A-TF along with mainline Optee, you need to pass CONFIG_SPL_ATF_NO_PLATFORM_PARAM=N, otherwise the device will fail to boot because it won't protect the Optee regions. (For mainline A-TF CONFIG_SPL_ATF_NO_PLATFORM_PARAM is optional unless you use Optee, for Rockchip's BL31 you need CONFIG_SPL_ATF_NO_PLATFORM_PARAM=Y).
> > >
> > > I'm going to test the device next week and see if I encounter any issues with it. I'll report back if I find out anything weird.
> > >
> > > Thank you,
> > > Chris
> > > ________________________________
> > > From: Quentin Schulz <quentin.schulz@cherry.de>
> > > Sent: Wednesday, August 12, 2026 10:22 AM
> > > To: u-boot@lists.u-boot-project.org <u-boot@lists.u-boot-project.org>; dmanlfc@gmail.com <dmanlfc@gmail.com>
> > > Cc: Chris Morgan <macromorgan@hotmail.com>
> > > Subject: Re: [BUG] rockchip: v2026.07 fails to boot on GameForce Ace (RK3588S)
> > >
> > > +Cc Chris who maintains this board and may be able to help.
> > >
> > > I somehow didn't receive this mail in my inbox, here's my attempt at
> > > quoting text from a mail I didn't receive (and it's also not available
> > > on lore.kernel.org...).
> > >
> > >  > Hello,
> > >  >
> > >  > I am experiencing a total boot failure on the GameForce Ace handheld
> > >  > console (Rockchip RK3588S) when trying to run mainline U-Boot
> > >  > v2026.07.
> > >  > The device fails to initialize or display any output during the
> > >  > initial handshake.
> > >  > Unfortunately, due to the tightly integrated form factor of this
> > >  > handheld device, it is exceptionally difficult to break open the
> > >  > casing and wire up a UART serial console to capture early boot logs.
> > >  > The target operating system (Batocera Linux) environment is running
> > >  > the mainline Linux 7.1.5 kernel.
> > >  > Given the complete lack of visible console output, I wanted to check:
> > >  >
> > >  > 1. Has the GameForce Ace board target been actively tested with the
> > >  > v2026.07 release?
> > >  > 2. Are there any specific or updated build instructions, BL31/TPL/SPL
> > >  > combinations, or proprietary Rockchip firmware binary requirements
> > >  > (rkbin) needed for this release that may differ from previous
> > >  > versions?
> > >  >
> > >  > For reference, the build configuration used was: gameforce-ace->
> > > rk3588s_defconfig
> > >  > TF-A / BL31 version: rk3588_ddr_lp4_2112MHz_lp5_2400MHz_v1.21.bin /
> > >  > rk3588_bl31_v1.54.elf
> > >  > Compiler: GCC 14.3
> > >  > Linux 7.1.5 uses the rk3588s-gameforce-ace.dts
> > >  >
> > >  > Any guidance on known regressions regarding this target, or
> > >  > recommendations on how to isolate the stage where it hangs without a
> > >  > hardware UART, would be greatly appreciated.
> > >  >
> > >
> > > If you have a known working version of U-Boot, maybe start a bisect with
> > > that commit as good and 2026.07 as bad to isolate a commit that broke
> > > the board.
> > >
> > > Cheers,
> > > Quentin
> > 
> > 
> > 
> > -- 
> > 
> > Kind Regards,
> > 
> > Daniel

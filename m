Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2AE0C44520
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 18:10:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B38660810;
	Mon, 20 Jul 2026 18:10:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YeTWcmTzlV6f; Mon, 20 Jul 2026 18:10:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFF7C607C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784571050;
	bh=Asescz/WOhGtft895CqNoAXmqHLVWM4pVle3KPARDeo=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=FT+oV8M8ulFRplUPw1T6sqhOrVxVSDqwTShzaYsDXHOSsDvK1AkQx7nAmdCWoXZ0Q
	 NEOyRz5ErzZlfKTgAJA8JrwrXwz8amuJAlObpxVg3+zUEAV/gX7BHi7cLRkawlxGrX
	 sN4Eozm0BEn2hK5TT06jTZalrGkypMHYjELIVRYCZUWWTMwjVfx+qtjBdn5s+RXU3X
	 CQ0W2pB0eyG/kwPb4ySYjgWJyL/UX1PlKi5QND6H9U9cwhpm8djGi/TJGPF1i8qT2R
	 CGtY9zvllKa1LFX5cxTuMNv7yt94lkDaAiPru2hIPXDvfxDui6N46DtJw5ZAQZD7RE
	 hqOHaIyDhc/yA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFF7C607C8;
	Mon, 20 Jul 2026 18:10:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id D0E9D313
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:10:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B67FC40015
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:10:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9iGXqMQfmbN3 for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 18:10:47 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 7117A40081
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7117A40081
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7117A40081
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 18:10:47 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 453EE844F6; Mon, 20 Jul 2026 20:10:45 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18C7480433
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 20:10:43 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c2ObOY+1VyiXUP0EWvTtnHZoCgZvRI++mCSPAjKRSUkrIjp0ALXpMdSiPTQOht/53qC3PDaAexq8zSTLY0EcisvosxpgRh6fgBJMiSWl7TPBFkzF+R27fL7Ql9Km9l9/eGJq+XbmYYAUS3qjwKeF1p122z3bQanHhBVtXN3CGouoKVhM6Soiu9tvJc24x6B+A7N7LaXeQECvLv8d8rqQ3DAsJ2gzsF7nU7C1YJRAsG+BBAZqudUJu9sGMK3C/NmMkt9G8YYRbXVn9jIvQqqqG8sa+xwPQlqJkZMXt80gkYK7TtY/zfTBvErvjnExMLbOd0NcBpv5afh1k5A6QGql8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Asescz/WOhGtft895CqNoAXmqHLVWM4pVle3KPARDeo=;
 b=cDaSF37ZHO2I97VLP1tkmltm/clhOYuSVa5CEZV9/RjGA1sWSxB+1wLLPZijJnsqahnViddIBHzwwauAfoTKB1/iYtlRyMws9RqswOcdsJvMSqsBfd/IUHeiBRfifWtrm4MiYgddXxd+00OHnpxA/wZD2p9+/ogUms4Ga57LKUUFE2XlbrRWGZz03E6SA2q/moihRzoTjnNVt9uMuAmDW02bQlAJtW+OI9N/6YEJuxa9oeLHA3ULnLe3+89vcf4CS5VWGpsZRXDG64kd8VZE78Jk+YulWgpHIkO9OYeV8sDUIuTcqknfBdKJ0U9u9hCyO5iAIN74MxWyvmoU7tDZiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by AM8PR04MB7297.eurprd04.prod.outlook.com (2603:10a6:20b:1c5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:10:40 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0223.012; Mon, 20 Jul 2026
 18:10:40 +0000
Message-ID: <5c3e2b3a-31ae-42b2-aa88-a2878c47f526@cherry.de>
Date: Mon, 20 Jul 2026 20:10:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] roc-pc-plus-rk3399: Introduce new variant
To: Fabio Estevam <festevam@gmail.com>, kever.yang@rock-chips.com
Cc: djw@t-chip.com.cn, u-boot@lists.denx.de,
 Fabio Estevam <festevam@nabladev.com>
References: <20260701175800.40141-1-festevam@gmail.com>
 <20260701175800.40141-4-festevam@gmail.com>
Content-Language: en-US
In-Reply-To: <20260701175800.40141-4-festevam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|AM8PR04MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f796c9-54cb-43cf-ec2e-08dee68a34d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: D/oDcy7iUv3+ONIA83pFZw781dAupWBYB5WV+W8COvGH6RmBgyikOr+HC6kkTSfKGCbXvTrqLf2en8ttCIQ9SJFg89GVxNUaZAAa3wuH50uh4Np7AbaeFPFicaboay4pyLE+OZcT3DO4oL2DM50KrtO88JqtabGVaj3lDV20YTKULc5mWOKVnqk7hUtC9k/zlfoFm1NAruxU1CW4Rs4+byiuc5apBYZoV94vosbSiQdTyEuChUmaEa/0VTDt28wL4nMV+3B31RqP6OuPhMT4iuKJG/G04E0UeerFXX15wNJ98R6RQKSYKaNYqUgO3LW3cUSBTc/YMH81TSBe7Ij344mDQ3X1NDi4qaPhdLCLyE4MoUJEdyLo/e8lK/ypUmKLSaOOz5oE0ZwcsdyjxcV0L/1ju7wlVIBZtqVYfRCinzz2kQaxqju51qxGFZh1L3LxZ48Kv5l8hVsj4pTr4ZQ7I6tWh3WtPW7OPHy03t2/gZCF3QWOLfg5ry+eI54/4vZpEJ5RPOOYkPE/lZmqvutDVi74Big7nH+hjRwv7Sua1pTFxsUukGi2QQSPwN1WaS310WREgZyaC8YbgQrf49+IdzXborCYLb7OBIFq5Oeb1NpMjfDmrsVqg2h/HDo4xNjnJu/WvfHIFOp+UfvMfnGoYbDsNTxVi0+i7e55WVJpdvo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QW5jZjhnOUEyRks4c0thUUJDN3BLdForWWNkRG1CZ3hUUFdqRXpQSUVEajBM?=
 =?utf-8?B?N1VNSmIwaUl5L0J6QVBKdXdSdFlwYjhhWHFnWXlpbGxGemswVnMxYXp6ZFFG?=
 =?utf-8?B?ZUZ6alJhSTAxRlRWeUJ2ODJ5M0VYM0tDajA3cnp0QzRUc2NoUVp3TWUrcHl2?=
 =?utf-8?B?WjVscHo0bThEd2FKUFZtTjV3dllvc0R3KzJ1d2ZVb0I0L1ZOc0RsMUdWMGhW?=
 =?utf-8?B?SDFIemhsTkpGTlJpK1BEYnZTK2twTXlnZmhYZWJ5dm5za0d6RUtRZUxuM0do?=
 =?utf-8?B?OEtTL2xmd1NQbEh0OTVRYjZ3QmYxelJHWVVoWllrS3JSNG5Db2xtb21hdVF0?=
 =?utf-8?B?ZFZwYmxITmcxaVgyTTZ2UitSVWRMUHdXQ2JYL0h5NUw5NENoRDd1em1ETUhr?=
 =?utf-8?B?ZXd1OGpJU3psZWhuQmM1L3QxOWpSSFhHbVRSYnU4Y0xHUnFOZjRvcE1NY0xz?=
 =?utf-8?B?b3dtUlA3bXAwbkM4anNib1AxZkNEMHJPM0p0bE1yS3VRcGNvbk5ZYTV3SUdI?=
 =?utf-8?B?TkdtbWVPTnhjSHNITHo5VVNMM3lUZzg1anlYYnZzanpibkJrTWNCaS9MQTZE?=
 =?utf-8?B?MDcyaXpvT2o5dGNpWlRkakdxQjJZN3BnQUpPLzI5ekw2cWoyS1p5b0djWnAr?=
 =?utf-8?B?RE5oQzdKZEdNbTVmV2I4WFZFdXZtK3o4OVVXQXA3ek9NQTlYa2crdzJxN0FM?=
 =?utf-8?B?b29zL2Mxc0l6WEJETk1VUlhHUW9xSnBhRVI5bzNBRXhIQVZhZUlsYm1Vcmlt?=
 =?utf-8?B?MHJPaHJwV00yaFJxd2M3NUpKYTl3RGZjU0UwUmgxV243bXVTNktORDRLTEdE?=
 =?utf-8?B?bWVsZVNIM2hHcnVNbE0vcjgxei8zUW5mRnFhYTZVTEtWRnlDb21yalhPeGty?=
 =?utf-8?B?WGhlUlEzOGNaNC9Kdm9xNzBnOWNVK0hFbHk5Q3NlRG1Ec3o1ZlRSeHUyWXFG?=
 =?utf-8?B?VmhxYVJXVmtvNENsQXpwQm5GZGRDWDBKQktUck5DVUU3bnd0d1lVU1dLVHl5?=
 =?utf-8?B?cnFPWVBTUVJIRFBDd2dlZklaWHpEK1Y0OXlxYWMxSmVpM3MrYkl0dXpCZURF?=
 =?utf-8?B?WnUyZ29FRy9ubGExMy9HeStSWVRycE5NeVJ5N2tqTTRXdC9IT1ltR3ZyWWV0?=
 =?utf-8?B?L2EvaFMyNFU2YWRkNWZnNnRsWk9wMFBmZ2pUVTAzb2lrVWhvcTNhSXowcnky?=
 =?utf-8?B?QXN1WjVFVzlIMGRiWDVyblM4alFtZHVqdEU2ZWFhMHV6bFluMjR4UGFrZkdr?=
 =?utf-8?B?c0IzN1d4dG1ldmxlem5kVGFWaU12NXV3V0FOQjBEVXlQMEJkYUZ2VEcrZktE?=
 =?utf-8?B?ZjV3UWtZSm4rZVlJMWIxZkJJbTFmbnFJN0R4YjlqL1BINWtMeHBndFdCZkZ4?=
 =?utf-8?B?Ty84RkJtdUNTZ2c1RmlnZXkxYkhUSms3UTE4aW5SQ2JIdHNabXVSS2RSSzUr?=
 =?utf-8?B?bjhmQk1tbzZBdDBvRFB6cmRHK1AzT08wNDVGdXlpRmdPb1BXUzR1VG55a1Jv?=
 =?utf-8?B?Snh1d2NDQmdKQlExbi9LMHk1SWt6TjhpVVlHa3hGV3hvRC9TWDlZNm9BN3NR?=
 =?utf-8?B?bm8yMmhWVnhVNUoyeEN2Y01xTTF1dXM2SGJKbllDL2hiRm53WDRFOE50VDNU?=
 =?utf-8?B?ZW0xNHpBK3Zua1NFbndWVzlEQUNZN0pKcXY2R2dGcjk1NW9DUmZpMmZYS3d3?=
 =?utf-8?B?SGNqcjczdW5HLytWdjdsc2NKd01DODBHL0tGb3VraitINzlUWHh2K1JJcFhM?=
 =?utf-8?B?dUJtU212RURHNlZWVmI4QUhLUmJmUFhXQzllVW1BR1o3dndudDhaSjZ2T1lv?=
 =?utf-8?B?dDFReXVNOCtZZ1pTMkltUEtJREFqTnZuTysrOVBMMTJzKy9jT2ZMRUJPUXRH?=
 =?utf-8?B?ZXBVQnNPMTQxcHpKMXVwdVRjcDY0RlBlUkRydjZpTGs2QWFZRlpGVmg3YW44?=
 =?utf-8?B?UmcySVR2aGY3bmtEb053bFVka3lrN3RWU0lmUENwdmNGczNIRzl5S09nZzhG?=
 =?utf-8?B?cG0xQXBSdUticmltQ1NZUzF3d2VsTmpyMlNmQ2RoUms3dWZhdjcyM1dkRVZI?=
 =?utf-8?B?WHdRczBWMWg2cjM4UVVyN3dHeVZsTHZ0ZVRHbm92Z0NnbGRZamE1by9SZ0RM?=
 =?utf-8?B?OGpiZnlVRTdCbnlORWJNZWJRMzlJUkl0eHE2RlRkVkNhTG9NNlNvYit4WlFR?=
 =?utf-8?B?dnI3bGhxbDUzejM0ZzBNS3VNdkdTYjlKbWRrNG91bDR2UjV1WWJYKzRVbVdq?=
 =?utf-8?B?RWE1UVdDd0krRmNvSUlVVmlwSXZiTzN4SENxQXVLZ29pS0pXUEQ5enRqREdG?=
 =?utf-8?B?QXFzbTJUdzkwbHhCNVhBTE0yTWxOQzFYYmdobjJUek1NUXAwbU92Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f796c9-54cb-43cf-ec2e-08dee68a34d5
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 18:10:40.0632 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bAgegtO6jascYR6RIAVx3qDKcfnWPVNKPAZLT9VHZ0+x2uTmdfBFqt1XiEwaSRsBZD0ZnrFnRMcJmw/YdhAwwhm5PINIO3iUCkNj6jt98Xk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7297
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Asescz/WOhGtft895CqNoAXmqHLVWM4pVle3KPARDeo=;
 b=B7WYD+6nOeWraKLjhTZu9uPlgvsaI1xpxq82YuoH7cbqgWqRzIvXy5nYJ7CHkVXWnRGvGmCLKwPbj0lCKZzakRUJa3ppuQ5T2BgXVVtOwnnMARVMxL4isF8h98O31b1ilV7EVYasaQJh8A81NqJzurgLTLqeYvRl0sQcXTEEwL4=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=B7WYD+6n
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="B7WYD+6n"; 
 dkim-atps=neutral
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
From: Quentin Schulz via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Quentin Schulz <quentin.schulz@cherry.de>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Fabio,

On 7/1/26 7:57 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@nabladev.com>
> 
> The roc-pc-plus-rk3399 board shares a lot of features with the
> existing supported roc-pc-rk3399 board.
> 
> Its devicetree is also supported in the upstream kernel.
> 
> The plus variant has only a 12V supply. It contains a XMC XM25QH128C
> SPI NOR flash.
> 
> Add support for the plus variant.
> 
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>
> ---
> Changes since v1:
> - None.
> 
>   arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi | 9 +++++++++
>   board/firefly/roc-pc-rk3399/MAINTAINERS     | 1 +
>   configs/roc-pc-plus-rk3399_defconfig        | 4 ++++
>   doc/board/rockchip/rockchip.rst             | 3 ++-
>   4 files changed, 16 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
>   create mode 100644 configs/roc-pc-plus-rk3399_defconfig
> 
> diff --git a/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> new file mode 100644
> index 000000000000..7d5af3e234da
> --- /dev/null
> +++ b/arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +#include "rk3399-roc-pc-u-boot.dtsi"
> +
> +/delete-node/ &vcc_hub_en;
> +
> +&dc_12v {
> +	/delete-property/ vin-supply;
> +};

Mmmmmm... I'm wondering if we cannot remove &dc_12v and 
/vcc_hub_en-regulator from arch/arm/dts/rk3399-roc-pc-u-boot.dtsi 
instead? dc_12v is already an mps,mp8859 in the upstream DTS so I'm not 
sure the override does anything (I don't think the compatible property 
would be actually used). For /vcc_hub_en-regulator, the upstream DTS 
seems to be using something.... questionable (a pinconf with forced GPIO 
output high via &hub_rst that is then used in /regulator-vcc5v0-host). 
So I **think** we should be able to remove this and not have to care 
about deleting properties or nodes in 
arch/arm/dts/rk3399-roc-pc-plus-u-boot.dtsi.

> diff --git a/board/firefly/roc-pc-rk3399/MAINTAINERS b/board/firefly/roc-pc-rk3399/MAINTAINERS
> index 2c0de4432fa8..d32b078431ab 100644
> --- a/board/firefly/roc-pc-rk3399/MAINTAINERS
> +++ b/board/firefly/roc-pc-rk3399/MAINTAINERS
> @@ -5,5 +5,6 @@ S:	Maintained
>   F:	board/firefly/roc-pc-rk3399
>   F:	include/configs/roc-pc-rk3399.h
>   F:	configs/roc-pc-rk3399_defconfig
> +F:	configs/roc-pc-plus-rk3399_defconfig
>   F:	configs/roc-pc-mezzanine-rk3399_defconfig
>   F:	arch/arm/dts/rk3399-roc-pc*
> diff --git a/configs/roc-pc-plus-rk3399_defconfig b/configs/roc-pc-plus-rk3399_defconfig
> new file mode 100644
> index 000000000000..4ec2f7d44b5f
> --- /dev/null
> +++ b/configs/roc-pc-plus-rk3399_defconfig
> @@ -0,0 +1,4 @@
> +#include <configs/roc-pc-rk3399_common.config>
> +CONFIG_DEFAULT_DEVICE_TREE="rockchip/rk3399-roc-pc-plus"
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-roc-pc-plus.dtb"
> +CONFIG_SPI_FLASH_XMC=y

Is there any way to detect which of ROC-PC-RK3399 or ROC-PC-PLUS-RK3399 
is currently running U-Boot? I'm thinking it'd be nice to NOT have a 
second defconfig for just essentially using a different device tree (and 
SPI_FLASH_XMC but this could be enabled for ROC-PC-RK3399 as well). See 
board/radxa/rock5b-rk3588/rock5b-rk3588.c how we handle both Rock 
5B/5B+/5T with the same defconfig (configs/rock5b-rk3588_defconfig, 
specifically CONFIG_OF_LIST).

Cheers,
Quentin

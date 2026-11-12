Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B10606A32A
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 07:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vWOrioHp;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=NJB9NiIp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB96881698;
	Thu, 12 Nov 2026 07:52:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PtQjJjRqfhja; Thu, 12 Nov 2026 07:52:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00FD181684
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794469921;
	b=N91H+cntr7VQhr7oRo08W5D52SYCVe0ejKfgAOpNTzaqgHUtBt4LLJUpVOcWhsl9Dngc
	 ZS3kShW/XGaq29BsctpKuCGf0h0YDszz4ryYdo4maQfdEwlblDB0o72+iojWyk9ZG+ZKl
	 vVVBa2CPI0isZX70nrQvykd6NTby/yYyZ519LPuHNKoHD/sm8Jk/pPzgxORazb4GhgftI
	 VtJaVQlgl0NeomJFaGUz7fOKCXXlaCa2kGZ2c81Y7Ir+MG9ZqS7/FCbX8e72mWX1P/QxI
	 bzLY6V2p0ehUm+0xWFzQpnuTfMjZA3fmRAFFmX3Nbn9ph1fQoGl3m5LR62ZhoL++f+Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794469921;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Sduta7cj+HYdCuqvvA9JulCFQdgu65jaST9YhI2DThE=;
	b=A5f+c+QGWEE7AxWF0NbnuMN12imOJ90Dxk1FZGeTQfQu0H4SMqPAMqeqN2wFYda9v47m
	 stfzp2Hx914hWn5RJ4BXAyHxTmEZOCP7FykpWlT8+Pt3+DuZxA6yxyJVL0q7Tu+8lk/T+
	 l6Hh1HqJqo+qArzbfiV9Nwh8TNTQkOs/99FwGnq6o06F0ZCDWvxHm1NKD0zkE2Ua9Ic0c
	 OFaCozbyDUtiUil7IBwRxQ2lM+JPCkdfB7pvQ3kn+Rx3KVFydLVoVByxDEkH2AMDuaxsx
	 75R7FTYIy8Sgm245bxHG/muF5aWIk9qtBzRQIN/5uMO4LElV0d1QnlfdwSUnAl313Cg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794469921;
	bh=Sduta7cj+HYdCuqvvA9JulCFQdgu65jaST9YhI2DThE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vWOrioHp5x8VxovQSY2oG4VFWj7PucgJqMvc42pV7ptDNj0WRu033Slre1P96VY9V
	 Gv05reIgvUQKknHTHj/OQTDHmLvr1Kc+yAKHkBdwxoAPnvxbSSW5iT8z1f86eY3hGj
	 MWfRRhxpAKC8x5IAhwSUrK9LgQLICBWgc75D+xk7XA/iu1BTwoOmhqnISzHWhJAufm
	 D/5rZ4KbmSrak5EmQPjvVeXg1mebYv3m2pDDwv+HH/YFS+zXGtLGuwUHjKy737mdCe
	 L+YOJ/LH/mXgant2X48lfkd7eikD/lS5lZnBMsgOJ0wOugyi6CiyFa7Jx7DHicXpOK
	 g3PCeA5V6TyKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00FD181684;
	Thu, 12 Nov 2026 07:52:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 726AA1399
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:51:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 583B640416
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:51:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iiIGP_C0YtiA for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 07:51:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9F8F7400F3
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=NJB9NiIp
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9F8F7400F3
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 07:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sduta7cj+HYdCuqvvA9JulCFQdgu65jaST9YhI2DThE=;
 b=NJB9NiIpAep3uFxedLEWTXQ8oNSeWWln8lFqgTRrBJOCJyavUl73omnhXkwMhkXCBmYGeShyjXvrBWbxOiHq5RgogMW4wcrjLJi2fCZBZMgbpVkNrl05UPIMFHsOX5g45ApWfzbAFf66NkoXxhsGWyf9XZWl0eLvRpzzg7y7/BV9seafZaArUxibnWjTR82UVoCT/02bJ12k9Ejt0GDRtltOq7P3BuCVCbAxWB1lTB3gMx05jmau4g2S1vMPlcLAKObf1lcxlAheDK+QDjdDFFvJorZgjwsD0gjt5PcsZYFdVQAM2FIuTaKrqBnq/H12oR3uIMgezDNglyOehr9KdQ==
Received: from DU2PR04CA0194.eurprd04.prod.outlook.com (2603:10a6:10:28d::19)
 by AS2PR10MB6797.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 07:51:51 +0000
Received: from MAD0EPF000008BA.eurprd04.prod.outlook.com
 (2603:10a6:10:28d:cafe::d) by DU2PR04CA0194.outlook.office365.com
 (2603:10a6:10:28d::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 07:51:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MAD0EPF000008BA.mail.protection.outlook.com (10.167.241.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 07:51:50 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 08:52:47 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 12 Nov
 2026 08:51:49 +0100
Message-ID: <476bb430-5bdc-47ae-9bbc-b38a165da43b@foss.st.com>
Date: Thu, 12 Nov 2026 08:51:47 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: mmc: Add mmc_set_part_conf() parameters sanity
 check
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Tom
 Rini" <trini@konsulko.com>, Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, Torsten Rupp
 <torsten.rupp@8tronix.de>, Eric Chung <eric.chung@riscstar.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
 <20261105-upstream_partconf_fixes-v1-1-6abda284aacf@foss.st.com>
 <bb7041c3-89ed-475b-92af-dc455bfeb789@altera.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <bb7041c3-89ed-475b-92af-dc455bfeb789@altera.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008BA:EE_|AS2PR10MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4ea3cf-8747-4d41-4bbb-08df4091cf8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|18002099003|22082099003|10067099003|4143699003|56012099006|261021123027099003|11063799006|261102123227099003|261022105027099003|261028144727099003|261026121527099003|261021121427099003|261026140227099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: WDNT/5YiGlhZkhAL462Q8cDiD9x4uDw9eh0ohH/o4kik6XEY5W1117+JxsQMi4dh4AJWEIM2xBUi7hG2MzB+t6KVkGlGfqdGqt8dzY15wO1VMQJX/i83VTAB7Q9w3ImCefRx0J4LzzY2egZ5f0VEc3Rg0vlIMT1F+dAVVA6fIisLdjHc1DE98xf1fuz6ZYTCCxDPxihQFWjY1UDqDjmtoor7RSpduLz6vnda/Nq/bfkdfgyqgvP4FfjHMKgFaE94m9Mst06cD4cNCWXR9vTajuIJRDAo+ZzpU/JEZ6Yv4yuQM2i5sneJRzcxTBwnDeEHvghXrcV90hI+E3q473J7H95wOtwf5uH1kyOXeto+ULGYwEpyO7i7QdLTCTQ0NRwGu2GUMOa3zLiQnB46WjpGtHzRkkgHtshcqnEn1/TnE0JoAjL68pdPVe8qsounducc3lxPVwRJ0BZaCyUzhummWZF3kqJ/E9jOXxbu8/h7AOJrnbVCKQ6LyUOfbk55jvuU+F6l/RBt4lJQe3la9DsrkioKSr5OXu8mdVfiFcuzyODGsT84ZC8hV7Q0DYH+TdOGg2p5iVm1bwbPlrSKszwnT2JOJ2nxLp5ci6FGmiFwuvsdn++oUwJv4WjgVUcVA7kGznyPia3sDYj96oG56gAf666b1jz7cMWBpDQsXZe3LK4UYSb8NEt1mhgo6IskuRyPTN0Qslb+920Hzn/aifWwIQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(10067099003)(4143699003)(56012099006)(261021123027099003)(11063799006)(261102123227099003)(261022105027099003)(261028144727099003)(261026121527099003)(261021121427099003)(261026140227099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +RRRb8aWjaXfHV3p7up9e3QbdEwq0J1p4cv3fdCecZ52d/Q1i5V45TpBdEtcOSnYS7DsowLca0IMeTHoTsGtSBJOEx+HDdBt/VXcDlddXgY2oI5QkCD0+dFo4alMOW8TEFpMQg8Ak75TwxH4lEooDoTkQWpa3s3zROZjUBH21xtSbmC7C4dJKKZoGHw0B3sVvsOS5ncswr5RXhNAoR4V4QD2mOxqYL86YuTsQoOTW+kLoRvYRlnRelQXiK2Zn+6Pc63cY3tSebmxMIy5bCarrxj8688+RML6hJJ2WN1YnFNT4bWEXSD98LjVCuzsQcg7w3mvYYkZ51CrCBX7CCO4/uTnY/xQzmJfOOh+k9QFRPyuGrydoQd5ef5UOr4jvlNuAz2UsWl5k2AW7aRY2tqRF/NHCmnd7g+R5XkBgRcwcHAMVMUbu7h3s2orzLlmTdma
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 07:51:50.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4ea3cf-8747-4d41-4bbb-08df4091cf8a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008BA.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6797
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/9/26 12:48, Kathpalia, Tanmay wrote:
> 
> On 05-11-2026 14:33, Patrice Chotard wrote:
>> do_mmc_partconf() accepts numeric inputs without checking their
>> bitfield ranges.
>> Update ack, num and access type from u8 to ulong to avoid truncation
>> before range value checks. For example, mmc partconf 1 0 0 257
>> previously passed, last parameter became 1.
>>
>> Add sanity check before mmc_set_part_conf() call.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>   cmd/mmc.c     | 17 ++++++++++++++++-
>>   include/mmc.h |  8 +++++---
>>   2 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/cmd/mmc.c b/cmd/mmc.c
>> index 8bf3bf794ff..173e3cc7140 100644
>> --- a/cmd/mmc.c
>> +++ b/cmd/mmc.c
>> @@ -989,7 +989,7 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
>>   {
>>       int ret, dev;
>>       struct mmc *mmc;
>> -    u8 ack, part_num, access;
>> +    ulong ack, part_num, access;
>>         if (argc != 2 && argc != 3 && argc != 5)
>>           return CMD_RET_USAGE;
>> @@ -1029,6 +1029,21 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
>>           access = dectoul(argv[4], NULL);
>>       }
>>   +    if (access > PART_ACCESS_MASK) {
>> +        log_err("Invalid partition_access value '%lu'\n", access);
> 
> Nit: This file reports errors with printf()/puts() everywhere else. Please
> use printf() here for consistency.

Hi Tamnay

Right, i will replace all introduced log_err().

> 
>> +        return CMD_RET_FAILURE;
>> +    }
>> +
>> +    if (part_num > BOOT_PART_MASK) {
>> +        log_err("Invalid boot_partition value '%lu'\n", part_num);
>> +        return CMD_RET_FAILURE;
>> +    }
> 
> part_num > BOOT_PART_MASK still accepts 3..6, which JEDEC reserves for
> BOOT_PARTITION_ENABLE and the name table marks those entries "", so
> better to reject them:
>     if (part_num > BOOT_PART_MASK || !*emmc_boot_part_names[part_num])

ok

> 
>> +
>> +    if (ack > BOOT_ACK_MASK) {
>> +        log_err("Invalid boot_ack value '%lu'\n", ack);
>> +        return CMD_RET_FAILURE;
>> +    }
>> +
> 
> Nit: Check in argument order (ack, part_num, access). The first error
> reported is the last bad argument.

ok

Thanks
Patrice

> 
> Nevertheless:
> 
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>


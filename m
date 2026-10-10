Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E86CA9EC0
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 19:02:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 70C914078C;
	Sat, 10 Oct 2026 19:02:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvrJToihPZuO; Sat, 10 Oct 2026 19:02:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 534DB4070C
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791658957;
	b=EkieBQpg6ek2C/UA8IMCvhRzy1wtnuqVV/LRq7ibeUIXXbRlzvJOwiYN1NlWdNF0AriM
	 8B8nfgE/hwfH8FmaokuUB2Kv46p/Xsva4MPAMMFEjtuDyeePZyTqbfKkTxJdHHtlA25xm
	 GDNe2DinIzIF4d8q/Z94FmbywW4gTWaauvHb6TUjGeYIK5U3x8IbPAGROvkO+cGJk/Tza
	 fmbM3UX02Jgmi/KcJqOOxA+fMURMS12yekB1pggW8gTKAyiMY5P3Z1bFyIEUEuXTG76eP
	 XRhBLIOMh9W8w5u+ufDEoyeJhJURUehePXjYQUqU9rLU78rILcAdRZ258qGkvkIlt2Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791658957;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dp/aVFGivhpHmCsVfINwkEufPYperyA2h8jzkF5RPZ8=;
	b=QUx4RcEoZ6ow1kFnnXGF9HtxcWTMuyW5e84aDPbTR7iFJMpJ3zmfKZ8/giHgQqIUNly8
	 76FQC/7EvmNMT1qUhqzuAwRGoxlbWs7wtwzAFG3P7V/+ujOV3xYvcxV71oeRuoSN76KTp
	 LYuFuDzibmD+QBQkympclTKlSIzCbN9evCKO4MUiyB+jp88KYPfa11JX/P/2mHrvgusPb
	 nDKkLJUPYlN2vPpBC0rUnCMHkcY1VBaiCZOnlzKFXBpNVnO20uYS2HHhff+MQOtuumX1W
	 agrgBYNMETaeL1Z5QbPPyyPOwEUpVokCaS5erx0jOWuSLJ/IVrh5b2qWoaF70gGctqg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791658957;
	bh=dp/aVFGivhpHmCsVfINwkEufPYperyA2h8jzkF5RPZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zy8xkKcY2xd/+vkVZ4trDgfMQHsXJp/7PO4lGhrdIM1iNqrbqjkNApTP173CHtAn7
	 JOsyo+q76gptK6ngoM01aw+olro2HJPGyL4GqHWDCH5ic0t4gd62Nolp7dVmFS7PcE
	 OftxU889TTUUWLKbINmWBQXaIG7K5bH10L9RQnYU6NeJkYONlNC9x43MRGKXIds7op
	 uDmFVo5IqkaHqe0kq9Vl7UiVlzZUOehWKqR6ju3K3KbRoyzRF+0g+/QQd9Vea+c+p/
	 A+fJuIBVdsgZhYg2yg7ZGWbDj9K5wLOmlCuxXJF6f/yzYNWzBQet7ZJMw0hakPjDHQ
	 6ASUGLEoflSUw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 534DB4070C;
	Sat, 10 Oct 2026 19:02:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B8822B
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:02:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7207360641
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:02:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id im236WvseCUY for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 19:02:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 65D8E6062D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791658954;
 b=CcNac4A4BRLplCYWTri77GPf/uE+/gjStaijRUYQmTBLo3+KluL/e4oPBQ3DA1e2dDg3
 j/cXr8vadzxNgMoHsX5zNJsG0i+hf8eRA6bB30lRRG/ZR0/r5vGIhCxQOrC9lrTfH+v8m
 udvVN8G+qKBpX0RzKAp+BN3ISZq1rUJqqX/ymMWTAvc7mL0sLFUG1uvKAxYw40DdGVgAR
 /V174IhS3LjRX7T0nB2Ijfbzgiau/DEEdDluSebmXcU8ZRxioqOz39CkU37pZZJ24qgb2
 Uo5nWPdIEisjVDCz5ZjjxmZxVxZKECoPDYtGm8uUHbjXvWuhH6uKs9BdGZUYm1aeDPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791658954;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dp/aVFGivhpHmCsVfINwkEufPYperyA2h8jzkF5RPZ8=;
 b=fjG0RTHaSY2o1v6QOWeWhS548jSRcvl41ROIV2/9My8Uame/qph25jF36L1NQsphmFIR
 XRJpLi4RtWl1XAK/8US1EqRRtqAMFBdaUfPEVCVCbkHktMmIVAF5rLCtdI+KbHxG5QdxT
 t8JyslIsHrWtObE69unupg7aqmpgzyzVLXLtc5seq8iJz5uVRJPShRFCi9YWImNQ9k8NN
 iK0t1CBzsJM7EDJLEvbJK0BgCc3Bsa+PifrFlcctfi9QYKwZSOvHNt39vUCkU4Lt74mNy
 nKz28zZFI1YyYMaGJAHKmWZq49GRSCDMerIDiWp7JbVle2GzvY1qkfkVY4vRqmQHFmA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=A+5DfFHn; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=A+5DfFHn
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65D8E6062D
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 19:02:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ehQXLqM/Im7CAVAlTStrz+dip845eFBjeFACPNXEjyO1fdEouydbgmwmt6erP2agvFrUnOWreYxqSP69iC90xvOKqdvKyIKMZmD7ztIEiiAOccS0DAJce47T8TuD9+UbwdRqUVkvcBPhet6xg+EvJFgz6BOGqGgNtTGhd4VU3AUxXdQHw1HgoFE7PBu9nm9K7tb0NXyX+euVgFhF5ezxkm7k47nh74eBB36CGnp4yqC7bn4aMjcTM6m6usOysca0EnlLcp+JVwCT33cB68GF++qDQH5xU+v5IKBr+MsK2Jhp0fu/ICgzKTjyqfPJTacm6cfR7TY4PEkLjUm6yAiw3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dp/aVFGivhpHmCsVfINwkEufPYperyA2h8jzkF5RPZ8=;
 b=e6gB3+vFPSZlQYoxLJVC0pVLATxe9M4uw5pA09Fwf/u0cnn0hVfoMcB3eICr0vidaB4cjlPM6XZpmy1fTOEMQMF1H+jbuRH5/9KroIniOLlFlPngZ5VKYkyaXzjzJmZ8LTy627IgPEZJ4/Id+ONz98AG6CLeSNFYOsvVrfwmKJmbWyQpRGj1G/XSOv9moEI4mwkEeiSObwVMLiOMWI60V6vmAjbRkeGtZDzNI3YLZnhLCz5IK+Pu2x8/jORsO9O3NKNDRa2UCSh2PrTt7itx8cdVi+DnalcByMh5CKUuc+r4Hby/5hB5c764ucVdxwINTd25Csh9JDmS1dFUQXBXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dp/aVFGivhpHmCsVfINwkEufPYperyA2h8jzkF5RPZ8=;
 b=A+5DfFHnhQJ2q01cAXvm6hfNRLAmpBcT/jzsufm/6Eln+7rXwOFXDJ+CcMceUhtc0fgLrBtqdNPFWwfLCshZmJ/KEqnJGft6H8CeJp+DQoBkvZOMRvJLHlLvoTyCc4Lqbt/1HuTXdfEM/sEVGcWkqt285UZbjrBUuhXFipMCYyxM3pi57SBaP9V240de7ctxn1sxkkGVGNZikvj3eyIqj+aMgXGAvpNa0Cww63s77fir9eHX6mpc0okODOQ9We0XoE+M4SJa4GpTu249u3DbH19NxK/gFoUOwR2PWocAgTUi6uIsl71QrKjuFdWIXIU02fp9ospd2ngk5oRPbe9yEw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV1PR03MB989657.namprd03.prod.outlook.com (2603:10b6:408:3f4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Sat, 10 Oct
 2026 19:02:29 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0496.015; Sat, 10 Oct 2026
 19:02:28 +0000
Message-ID: <2ef42a4d-ee32-4650-819b-ea6d042bdad5@altera.com>
Date: Sun, 11 Oct 2026 00:32:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] mmc: k1: let the SPL read SD cards more than one
 block at a time
To: Zixian Zeng <sycamoremoon376@gmail.com>,
 Dave Klotz <DaveWK225@protonmail.com>, Yixun Lan <dlan@kernel.org>,
 Eric Chung <eric.chung@riscstar.com>, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.u-boot-project.org, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, u-boot-spacemit@groups.io
References: <cover.1790975596.git.DaveWK225@protonmail.com>
 <20261005T134748-0400.mmc-v2-cover.DaveWK225@protonmail.com>
 <20261005T135733-0400.mmc-v2-0002.DaveWK225@protonmail.com>
 <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <a57e47d3-fe8c-44dc-8afe-2c256ed49d71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::6) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV1PR03MB989657:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d49896c-8eff-4811-606b-08df2701076c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|22082099003|10067099003|18002099003|55112099003|3023799007|261009223027099003|4143699003|260925022911599003|260925021911599003|260925021311599003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 98IMCYck2I6SZ/dVvXSgY693eJ0f0WDDunmLgWZIuOV9mZxztjbVJTMXbpG/HqMUaQQo4O5qqm+Gp757vnauZs0lFro3m59djuw2RGVwT/CszA9DSGknaG8fP90Z5oUQLMUbrT5bF+s773g1p94d/FL/ScTykbFbEkb1L/wkJEqZR+8yiMv3f6XhMumRQSFdHYAdfSraZENcf3aC+15LlZSbLD/oy32NnXXFSEDdAbgXqP5jhbdL1gtR6yTO64MSD0ykACf8TqmX51lbLTtI02SOvRIsdm9iyaFDZ/HUYxioOl0zPwHftkjrmBi0PEkW5MKOy2smlCSROy3/BOe5iSLT1qcKm19hEJ7b/T/vZFKNpFXTRDo40hHDBYvY9v9xDCL9C82KnKLTOI/NvzPqwAIstjJQkIWBbaZgop8wcmwnBLpajtSyfb3Kjm4OsY8dJ3RdpOI80yZN4sK5zoRcDy2+LLz54OUSyrbo7GnR2tOJs0wSQJLG6Y6+qdAi/YuaR3WmLsWIzjM0oIN7hQlFcd6MMPCTKnyG7NAHQBcztGxB93ZCsKIyJ6cawAf01EB8HqpKK549Mmn/hVnbVvm+g5ib8JgiZVOsqhCc9bQf3qbFmajfikGEHp5QOLvCw8DY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(22082099003)(10067099003)(18002099003)(55112099003)(3023799007)(261009223027099003)(4143699003)(260925022911599003)(260925021911599003)(260925021311599003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXE4UzBsQTRLVWRWbVpLVWdvQ1p3dUR2Mmw5Si9JbTFRa0xpV1VsdGYvTS9Y?=
 =?utf-8?B?eTZaWEc4VmRnSlc2VzNkSzVYWTlFN2VKSGxFeFhoa1d2UlNBRS9oYlBaVEdP?=
 =?utf-8?B?S3dkTkJCZmZUSGRERDBmN1ZWTEY3eUZ0Vm5Ic0d6UjNnZHRBRlBzWXZqMEEy?=
 =?utf-8?B?dFN3RW92MDg4TkJwdk0wS2V0bVVRTW8vMjhrYVF5U3IyTVZLTjFiQnB5allY?=
 =?utf-8?B?dURETU9uWVNBL1pQZDZYVlI1UnlQUU1sc2g2eEJJT1FCTDlQa3Nib0h0MHZU?=
 =?utf-8?B?MmN1TXUzL240cWRsRGFxMXVSRjRmemlvc1dRdm4zaDRlakxRNEhLR2dwUEo0?=
 =?utf-8?B?eUFnRGU0S0hDcmhHQ3R1VVpaeCswYzJiaEVJZFZNNXNyaXJsSVlqR1FoN05T?=
 =?utf-8?B?R3JpdUlLT1JFY3Fic3VTZmRoOTBiZFpURkFRRGw5VktDMHQ0bE03T3NXdTUv?=
 =?utf-8?B?N3RkYzdIdlFlVmEvYzdNVWJmN0QzamI0dEh2MzNPK21RNEtWQmYwZ1hYYitM?=
 =?utf-8?B?cnJwSGlxRFdiSXh5dTBOSWpBN2QrTmZqbGZKdk5YMTVxNXhEMWVGalozM1Jx?=
 =?utf-8?B?VUFMdFEyTGY5MGpvMGhzMmtwMkJaaGFJNVhFVVJ4K3VDMnVXMng3SUZnUFlq?=
 =?utf-8?B?NW1SdVVzTHBhQnRRMThvRXB6YTVEVlgzbzdIUFE1QWVSNE9KYXVRbDBFaVU2?=
 =?utf-8?B?N2MxRmUwcWo4eVNhSk4vV3l6QmlYSldFVWI3cEhnVVkyWDNDWmg4Rnd0UldG?=
 =?utf-8?B?ZUhFWlhwNitUUjhqWlVrTG1OT3VETzRtd2lheDVxZ2o0ZXJVL3pZM2lXTHRO?=
 =?utf-8?B?WkFNU0ttOGxqc3QrQ3RIZEFlSDRWVFFCc3FuOEd3ZG5TQVU0SDlYQWdkL1cy?=
 =?utf-8?B?WVYySnV2Mk5JTkp1YUowY01TVFF4Qldoa2dvbXQ1a1JWSHZsYmdTbVlDMWpY?=
 =?utf-8?B?VGp3TFBjWDUxbnJIakdxTnJycFk3UXNuR3JVTGl0TTN3VTdseW5GaVNiTS80?=
 =?utf-8?B?d0xxQml4NzVaVTh1YWpQZDNnRjdqYUlJTXNrMTQ1T2ZCRGRnNWFLdTM4YURX?=
 =?utf-8?B?NTFOczRGRnlYNXFZVWpCTHlYcDNNL0htZVNiVVhwNmFWSllrRFN0RDdEQm9k?=
 =?utf-8?B?RmgrQTJBamZ0eVhQa1lsYWQvUjdHNUNoM05YbEY0ZkdLdFRIdDI0NC9MV1Ew?=
 =?utf-8?B?dHVVVEJKWVFxd0N5UlprdXdPak1VWGwwa0tKQ1VPWkdNSUJvbytqblRKdUwx?=
 =?utf-8?B?NUFEbWNqaVZwU2pxUE1Yb0JDbDVJK1hOcndxY0Fqc000T2NFVzRKelBtS3hB?=
 =?utf-8?B?c1phNWpvdzYyWXJyOFBRd0c4SElVWVJVQjlpd0NuUzliZy9DSGVGdU0rTzVX?=
 =?utf-8?B?YVZXbzZ4dWVHUTRyQytSNVdwS2s0Rm8vcFZPbXpYQUcvMVpYS2F0SjdaQUdP?=
 =?utf-8?B?TTVUN3RBUUtqaW1TUzZMQWtGd2pwVUtyV3I3akQ4anNWVDZ6T1VKSWt5SWlO?=
 =?utf-8?B?bkhaZkREUVpKejRsTFZxQk00TFJEcmhBTGFiSGwvWitBc1pFd1l0S2tyNHc3?=
 =?utf-8?B?c0J5VmQ3STI5MmZKNDNiYnhhUjBrcTZaMW5PSkp3L3p4YktmNUVnSXNPVVNY?=
 =?utf-8?B?Q3lWNUY3L1hwWXl3S29YUmc3WTJyZGlFMHNUbWZjRkVtaHVwUFJaSUlqMEpO?=
 =?utf-8?B?eEExVEY5aHZnZlREOXpkYStKT3loZ2dTQklyQWVuRDQ5eEpPRSs1VUtUYktE?=
 =?utf-8?B?bmY5REFhVkF0QVJ5UUU1NGR2TkNpT1o2cW1HWXBReXJIMmxodGtJNU5zaS95?=
 =?utf-8?B?ZWtwZElNeVNvWVlXTkZZNkhuMEI0cGgxVVpSd0piQUQzcnR0ZUNrZEF6TkZq?=
 =?utf-8?B?a21VRTZzY0NYSTJFMlRGWStrTWRCcGZ4L0JEK3YwUDhNSjVYOWJiQ2JPM2h6?=
 =?utf-8?B?ZElGSmNUMWRSd1NJeUExelg1c3h3M1ZyV0l0RUtsRWpSeng5UDdzRnZIblQz?=
 =?utf-8?B?WWV2U21sRXhhaEZ4cTlxVEo5Y1JGYkdPU1E1ZTdJODVpSDJHZjFFTVRLaTd4?=
 =?utf-8?B?bWxISFlnTTZFSHA5TlZqYmYyU3cxOGlUOU5RYm1NYUZ0NVRCTDdTLzdkTnY2?=
 =?utf-8?B?U3F1cWpHeWNtVjQySGR3Sm9GVEk2RFZYZXlHWm45VXFzWDloOVBNbi8wSUJV?=
 =?utf-8?B?REtucy9jK3JRYTVVNVVxYlFCNVBYUEV2UFR3T0hqZjJWOVdKYlRxMWdmckh1?=
 =?utf-8?B?WnhraVUyS2lQcmErMlFZay9hUlQyL01zMUVQaVEzZmMvd1NGTmpiRTMxNWVq?=
 =?utf-8?B?VWExZXkxZ1oyVEJHbXNqd3Y1LytMNUpnaWgwNzlmL1pDV1ROTXIrSHRObE0v?=
 =?utf-8?Q?NYPJqiqrDKd/JO+g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d49896c-8eff-4811-606b-08df2701076c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2026 19:02:28.6520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ES1vmprEsNAGNMDsDpX/v8GYIFI9F6SZj7BkZv0b6weFFq+1Xf0bmbvZt6MQF1UiUifZsHMSW9oXL4+TG72kUHXiZKELMC2Y1eLvWLB9VHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR03MB989657
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


On 10-10-2026 11:47, Zixian Zeng wrote:
> Hi, Dave:
>
> On 2026/10/6 02:01, Dave Klotz wrote:
>> spacemit_sdhci_get_b_max() limits every SD read in the SPL to a single
>> block, so loading a ~1 MiB u-boot.itb from a card takes about 2000
>> separate commands. The controller handles multi-block PIO reads in the
>> SPL: the OrangePi RV2 has loaded U-Boot from microSD with them through
>> the v2026.07 and v2026.10 trees.
>>
>> Drop the limit and use the host's b_max.
>>
>> The merged v13 cover retains the v9 changelog entry choosing single-
>> block SD reads in SPL. This reverses that deliberate policy for the
>> recorded RV2 SPL boot use case; no general multi-card reliability claim
>> is made. K1 does not advertise MMC_CAP_CMD23, so the MMC core sends
>> CMD12 after a multi-block read rather than requiring CMD23. Additional
>> card models, cold boots and transfer-error recovery remain required.
>>
>> Signed-off-by: Dave Klotz <DaveWK225@protonmail.com>
>> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>> Validation: unchanged executable change from v1; exact-base source
>> replay and checkpatch pass. The corrected combined integration, with
>> separate clock/MMC and DDR relocation fixes, passed SD SPL/FIT and
>> automatic NVMe EFI boot on the 4 GiB RV2 in a warm-boot trial. This is
>> an integration result, not an isolated test of this patch.
>>
>>   drivers/mmc/spacemit_sdhci.c | 11 -----------
>>   1 file changed, 0 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.c
>> index 6488ae0fdb..4284553177 100644
>> --- a/drivers/mmc/spacemit_sdhci.c
>> +++ b/drivers/mmc/spacemit_sdhci.c
>> @@ -324,16 +324,6 @@
>>       return 0;
>>   }
>>   -static int spacemit_sdhci_get_b_max(struct udevice *dev, void *dst,
>> -                    lbaint_t blkcnt)
>> -{
>> -    struct mmc *mmc = mmc_get_mmc_dev(dev);
>> -
>> -    if (IS_ENABLED(CONFIG_SPL_BUILD) && mmc && IS_SD(mmc))
>> -        return 1;
>> -    return mmc->cfg->b_max;
>> -}
>> -
>>   static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
>>   {
>>       struct mmc *mmc = host->mmc;
>> @@ -574,7 +564,6 @@
>>         spacemit_mmc_ops = sdhci_ops;
>>       spacemit_mmc_ops.wait_dat0 = spacemit_sdhci_wait_dat0;
>> -    spacemit_mmc_ops.get_b_max = spacemit_sdhci_get_b_max;
>>         ret = clk_get_bulk(dev, &plat->clks);
>>       if (ret) {
> Using the current version of the next branch u-boot (ed869863c7),
> with your MMC patch series applied.
> Since the SPI controller is not enabled by default on the BananaPi-F3,
> I also applied another patch series:
> Link: 
> https://lore.kernel.org/u-boot/cover.1790976767.git.DaveWK225@protonmail.com/ 
>
>
> I tested u-boot SPL with three SD cards on a BananaPi-F3 and found
> a reproducible issue, the specific error I encountered is spl: 
> partition error (Error: -38)
> At the meantime, when i was revert the commit:
> mmc: k1: let the SPL read SD cards more than one block at a time
> the error has gone. Same SD card, same operation steps.
> Maybe BananaPi-F3 do not support read SD cards more than one block at 
> a time?
>
>

Hi Zixian,

Thanks for testing this on the BananaPi-F3 and reporting this. The
same cards and steps failing only with this patch shows that
multi-block SD reads in the SPL are not reliable yet.

I would request to try one more experiment before dropping it.
Please add MMC_CAP_CMD23 to host->host_caps and boot the same cards
again. CMD23 (SET_BLOCK_COUNT) tells the card how many blocks to
transfer. mmc_read_blocks() then uses CMD23 plus CMD18, and it does
not send CMD12 afterwards. The current driver does not set
MMC_CAP_CMD23, so a multi-block read is CMD18 followed by CMD12.

After the SCR is read, the MMC core clears MMC_CAP_CMD23 when the card
does not advertise SD_SCR_CMD23_SUPPORT. Those cards stay on CMD18
plus CMD12.

This also matches Eric's earlier note that on K1 ADMA depends on CMD23:
https://patchwork.ozlabs.org/project/uboot/patch/20260707-m4-v4-3-dbd01185f911@riscstar.com/

If the CMD23 test also fails, I agree that this patch should be
dropped.

Regards,
Tanmay

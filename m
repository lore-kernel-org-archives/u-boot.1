Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAC8AC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:26:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 14C70608C1;
	Thu, 17 Sep 2026 13:26:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CExgczaCL__a; Thu, 17 Sep 2026 13:26:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5F13A608A8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789651598;
	b=PIR9EVRUjWfc4l83tVWZP+Ob4qgkyaZdPMNwauAZepshJDw/rsxcgo0yTCXAYI3/5vd0
	 NRnENQtMJLnZhV3OVLnK9OCY8EXOaYzYw3IlIRnyNx5ulk+PdR1fBAnmx27I9s84DwbDT
	 1Q2qLdliR1WvC3JoRAqU+frje6kf64ClasGkVFglOSSqzWwMTrQNoiIwx8GdES4OWrNHM
	 CqGfsyzutF/xlbzYKAshpM2tAHPCqJb41+S/k2EbHM6Hj6SoKVXPyxebIWrUk9ueBCmax
	 zBmAYybl5Zbhh9I3vzYBPSQlDpSsvUSGOt3H7BclI1naFoheNM9t7a7FxqXVNmli8Ag==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789651598;
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
	bh=5Qc455UfsN7Tymyr20oMW8nFboH46cLTEnlFb5ij7tc=;
	b=DrV7XoA1faNoCMxLKQYREt4+9hX0Gf8Yne0yqUunUW33LI1hu3WkAqf5TOJD4Ji0mcnN
	 j4BMxVT6BlCbS8VejB8xY5QfFFzTbZG61Ogrj5nSZ9Eo3vFn0O/ATB0xUv1rOTig5Vtr3
	 Go2qbSYA2Hnrk7RI1voC3WZ5dqRliH3OrPIkp8UNTi03XXZ40s+f/ZJr163LjW1rFeXve
	 JwcArFFxXrsAmeM81kQnjEF0H8l57/OJel5pPJbPSoGalaUNdRX/M9eMsY8biHL2tmHCh
	 pvTmPesDJvHH4K7UsIBy7Jo1/VMHQzqR0R5AcaEdAgS+Xx0J6OEQbl9AMxdVzJCCWqw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789651598;
	bh=5Qc455UfsN7Tymyr20oMW8nFboH46cLTEnlFb5ij7tc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EFsETDONDYqjX+hVJZRDmEtqzBRwMt+sO52sikx7wLIhaOOS+db16QRff3SlD5VGM
	 cF7oZh2zMkgrllGX3QOtz9Aw4IUxbxRrkV404HGcQuFFkJ0rrvHaQ+bB74io4bhNAw
	 9HpeLs0583cziY7sqJKKqSe+la5JNneEn6DnJvEcwyLwo8WhGD5Ta/xS+kN693gdnd
	 NG9T6hJONMZtqB/EllmxIy23nRe0iBjakOwFx6lOIWoPlHOIAS0QSoZVwGd187E0KK
	 J8V4BR4fMHwFjBr/zHoX/UWB2IHhiWwc1NsPS/FwwEBufAH7dv/sUCUvpFiZsjg3Cb
	 rnxVi4iHjpN9A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F13A608A8;
	Thu, 17 Sep 2026 13:26:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B1B02465
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A2E3480F81
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jZgMMqf0Wdh9 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 13:26:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7EC5580906
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789651596;
 b=dmQOa/GljvdpjZwjZVH1oQmW5VzOvKhw/T7vmPV+IhtHIoC6O9w5UIMQddqcW5YkOFrJ
 cb5Zyw4MlHJuJZ5jHaKJFVkKaGa7AmgkEHslOTGyUvLw+NbcEY3ufgX5ZLvAol/XnD20l
 GVpNfhlSZZ90wZHIO3UZFSQoEC5haKIhk2YtT7QEhBIEcMklHf6AP0yE93ve5Y5iWMkL7
 XikT+fxHDtAOMFBVr5iQlaFywn1ZWwEIWZ7JWiDojzTAzGgugS7DNtv1RCNViQ5v6KJta
 rL43ZJJsIqKFHpF/cEl4Mzh5JXtAZhJQqs+kXBUOLEeCOPg3Qp7fzRLcazyZbZgl+eA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789651596;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=5Qc455UfsN7Tymyr20oMW8nFboH46cLTEnlFb5ij7tc=;
 b=I3F4SG3Op3MiL/w4mU85+x/0xCXgiNCDPIdF+a6y/nfwscetzwW8tmnCheO+jE+STDHp
 1nqGqE6XT5eT3l/KxF+8VMe5I27pBCTiB17+1TdYkKGX1J9Y2cbOlyXPzyCRhUPz4N2rt
 zW3lsTLtXn9LSYxvkAVXcMgnDkR8u8qsdOHTvieFkg1kluVMmr74kG72tWkZ5AeB+yjUb
 SEtJAenEIelY0DnZycDyPbewJkak4IB6Cir3bACArov0gottlgfVqVfCX5cb3Ne6d6uTr
 1o9j3aDra3bQkXQJjyBk+xNSMTSjmGl0hjyIpOhg+9uPKWw4f546Vh0eaOennjw8JVA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Z3UMPGWV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=Z3UMPGWV
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7EC5580906
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:26:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Umpj9rmVJ2/Mmxep7AKoRyUeep9wcGtONkpZuxsfGvJfv5oJTV1FV+AZN1lnSv7aha0ct3oDm82oczvVrdVKy6je5PXXKTnWPeqm0MJ6q7z8yX7HRJcMPgYzgMloyZHov7SwxJaaTBzIt38mbeRy3qleQqSM/PeuNo4ewRN90712F1RNdpPatmb84xBlxShbhMnxSScXG5H0U/WQSu9XPzSZ0ciVpygO53MGT6L7qZLaqBhyOPJeMWoVhR5Slk8fs+XLfTlSHPJryZxvamI9j9AlrymNh4Y7RlgFg/iJ37Tg+ZW4t4ribdRmHnbKvtab/K9S1d4NZ7KW8DibGPvucA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Qc455UfsN7Tymyr20oMW8nFboH46cLTEnlFb5ij7tc=;
 b=aygCnhMWC6lL/2HyRgxIiDXvMhJ+dVXbbFkX7Gv5fUenajYWkpZ3AKOu2uf+MBblHtO2sIkT4RWYgFBKIQBt5WHhEupsunAXqh7avqq6UDz0RlDV3Lns9uTGI5ZIZumxWCgz4Tme1J69uP2XFSaHqzMvNv1EyFF1dpUYtDvhHAZv45B80TWjWf8vi87YydegzVm0gPIDh5TitlMP2N2pOSsZpyOvs4uwk+tyfTWjkXoT2cx9t0KIJUD0sDvCVCRqdpBUEoYE/SAaBV56Z9Ft8Zxru1uEOprXOgb7M88VW5TgSwG40DLj7WzIqGKb6Hvhu5C1B9hu8xk4wUSq4MWwgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Qc455UfsN7Tymyr20oMW8nFboH46cLTEnlFb5ij7tc=;
 b=Z3UMPGWVTzxIrjohTfsnsXqQB/DoNpndRsBVCwU/PSFg77q8ysiYL3yO2sySiInq4KCsLSNxPNnumSPKiUqNIsdfWzPNRlF0WMe1N82TUWWgzwUkLEzjuL2aDpWcqMjXDoYqHNMIPAnIRq1zfE1oO9bTKkXXmy3g6VX84er3yniw5C7KYNEXntULq+nAS/lF7maPjIy6roQmaRRuu6myVVKbgTvSxfd6Z8qofONtH31iT+aT18w8uG5gKPChwnnVwozf9E8m+4Fx7enl+nWaagHNvpPpD4QyLSQ4xp2npb8dL4RUdMJcNbSjWJBtCHDQmCZbQOuXpwhws1ScT2LxoA==
Received: from DU2PR04CA0277.eurprd04.prod.outlook.com (2603:10a6:10:28c::12)
 by PAVPR10MB7308.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:31f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:26:25 +0000
Received: from DB5PEPF00014B9A.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::a2) by DU2PR04CA0277.outlook.office365.com
 (2603:10a6:10:28c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 13:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B9A.mail.protection.outlook.com (10.167.8.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 13:26:25 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 15:32:30 +0200
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 15:26:24 +0200
Message-ID: <2ea16a30-504d-4fc9-9425-87568aee2290@foss.st.com>
Date: Thu, 17 Sep 2026 15:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: stm32mp23: Sync config with STM32MP25 one
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
References: <20260904-upstream_update_mp2_defconfig-v1-0-695c0abaac73@foss.st.com>
 <20260904-upstream_update_mp2_defconfig-v1-3-695c0abaac73@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260904-upstream_update_mp2_defconfig-v1-3-695c0abaac73@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.100]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9A:EE_|PAVPR10MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e89648b-8b34-4b63-2b3f-08df14bf4607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: EY+tmthLkVxF06d1ZM+4AiDmF1z4K4iRwKzTus0LR0SvQisqz1s/IfNvzzInQhU0TFDWVU227Xku3z43irVNifMrjEnND6J6WAWxuhqrCd1qsjD0hX84KeNiczcLi6uamblaVcB9cDNcUm7CXuUX81+OfkIAK5pBAgReZGMBzgy6ljR7ZtfwDtjBo9066IX+XpxdppPbCUUDlQuRe5zNrZ/civ9zJPHpimlOXr9D1zA4akGAjflq4txlAGzjaJeI7OvSdoPQ4Jdo+pd5WnDCKvFqXeR1jirr0itWWdBrJMnEv3UyFcwo8ENcvhS+vpYqTB7170FdiBlJeLtGyZ8HLySrVqEy5ds/972ddvr/04moo5bXGuRMd/DbcBmYEEf/BuRZfd2xXVLDxsIHYFCW0VAHCBTOBy1XM+XuseX577VYappSvl8rVaz3g8u67SKQ2rHk9jSWnJr+LgcONhB2rQgiZlcV6UmGzW/zQOYrjvXioU/Efj8SqhjjjFxOG8Gd+KV8hqafvtK8kCTjwJ8L7tzHHb4WLtmP46u54p9MtJkhyRHhUSR4jPYNKJuReQW6ZIGSroDh8MuRMhmMBCZB2WSRrCMWfyi0tV4gh1RX9In2S1d/+n/Yf78pzyCosp/HXasQJUpADnqg/EG00v+PtuELECX9TYhgeDPKUbQXkYP1snv1AQ+ulQndf+pSvYXdnykD8DzEBSj68LGKUtJePA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qGm3YjIVqk+ZoWsg1Dj3MOe+GegLM1B4dmg/fKusJXEnNgfwYMTMxl7w1TJsYngzD8N6b9VtsFQh/EKAbGqWqWol1TINt49bfzUosMBjpxRsokZV57otYjGTQIn0fFqmfS1KpF+iWWPoD4SdSRLbJ+N58t0McmKC11Y3gIalbeFUL+b7cUSdszCqZkzovW1aUx1iKqoNJDSyP5JFu+qTtUtCZ2HGpM+Jxn4rD5Dyy8+uF1jkvmNEycPflnUl2MdxAAdp0/zN7ka0v3X7Zv6LhB+KjBLRhu4KQU8v6IVb5qFEO+DTTXn/k6Y1XJYTe7Mp4EPgY3J/QZGUh+dZK0x2hRw/DQBxiP+++fYr1XtmcgD15ggMKGttABP2aMTKNqCAet0VOyXY3Q7xXcOIa1UbSRbUIUAq+CaoQJ0B4XoWtuny6zndG5RTKiGrdFv2/iOL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:26:25.4924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e89648b-8b34-4b63-2b3f-08df14bf4607
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7308
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

Hi,

On 9/4/26 12:18, Patrice Chotard wrote:
> Synchronize STM32MP23 config with STM32MP25 one.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   configs/stm32mp23_defconfig | 28 ++++++++++++++++++++++++++--
>   1 file changed, 26 insertions(+), 2 deletions(-)

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


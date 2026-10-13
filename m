Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB8BCA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:38:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CFE54040E;
	Tue, 13 Oct 2026 11:38:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g45vLGzykLp0; Tue, 13 Oct 2026 11:38:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FE6F403BD
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791891501;
	b=Z/RJ/aTIfT+wbIDFPZf2sdcr9vfv4VsvbcDERdcz24DV6pcbsZy2kK1GLINylCdQAhDO
	 06MYTnOkOROOkhd55EIo4OQ3cKG+rgXnaypLQ+3phr4LW8nW9Wy2W184y1Ff/V+ge+9KA
	 keT/EXAhMlvFxk3/Tzdk/qffOY3Ybau5HSc+Lri+mHiNDV1rTIojNW6fd8kKissW97o/v
	 RA2l0UDR3WD/UP9cgweR3PTXTGMW/Z2MKN6S5WSLdqOFWrLIQXcidsx4oQH2swW4ovWag
	 +xzDcdL109OsFgWow/QajOoto41s62Hijbrj9IGe3SsrtR2oTLs+wUUGWXJjQ/PzxFQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791891501;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 Content-Language:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=P6IwzhC6aat2vWpGbZh2NO7anMPHjXkTAoQnZOfaYec=;
	b=sKToJ1Xd/cnqa0medzSBb5+RXc9HGbkFa1HCIdJeWcc87QYxt6F+KKw6sG2775I9Jv23
	 RQHMO05OYKlJGEsndvFm6DTC6jcUmEh8ILQrR0F4Z+4VOb/q+U2Sb66oghrHT2ScyvJtm
	 W7+s7dn6o4qIc5PEaL+AyZBZlUZ+ctWdAX2J+u22raqVHBqeX6ia2UT7Eh93uDzKrT7Uh
	 XJvM9sazqHeBO+zCjr85T1jLrn8BKodJYs1k2lSgh3LUu3mysqZhYoO8xlUxXIxVn3d1a
	 ky25Np0wk8FPY58YeVhKSRUZ0KozdwhU95i7iVaubV2K9iAEPtPtgQKERMyC62x+Lrw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791891501;
	bh=P6IwzhC6aat2vWpGbZh2NO7anMPHjXkTAoQnZOfaYec=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WVZfaVWgUA0Xl2XA2eg186OGuNkFeqcY7z0hEiRAWnZwRY/JC5F2mNvWVvSYOiezs
	 zPqc3zJswka24Kuy2a3uL01mp/nn5ItXNG8P+rzoNaWJwTRRqbNBow2b49wHj8hACv
	 mVVMBHIWIbbYB2wD7BbH7QMO/faGXg7FjMF6iXAKsaYqRuxCQYGPL84Q+afNo9tqF8
	 Sof1/iqmu5axlIbMDNDIyv+t63plL52Gfkq+B9qkZw+f1xnOzfYLuNJrKzC2lHHeb7
	 XxbIVBS/PDG9toV9Tzxc+/MxqoHaHP4/LgVpR7JCBBE7Y8mk4L7vcLlv4+ZtFt7EXW
	 NTq9zVFIaKMFA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FE6F403BD;
	Tue, 13 Oct 2026 11:38:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DA2E4362
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:38:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C991D809CF
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:38:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DFo-2G7HksAT for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:38:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 44A1180962
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791891498;
 b=ixwgJfmsbOnYnS9b6cAN8/Mvo89XcLbHYKtdBOx5HHJZU/NVnAkSxPJf5d5G/hP+ZnGU
 LIJzHJW8CpFOt6h+TTAIqDTHBMzzQU3kGc8nsctQ8DKe8Yns+yCY4DDca3hmW4xJaYNcD
 MSIcvPPjO/8OdllJ8ADi7+g3CdpL2C1j1UvQshnEMw52qXTka+08QKDQcuwl5gde7K6hi
 HbPbrjIinkPugjxNmv2t6psnQITpCxqiizQbS+rRA4gtpabi7l8vIRkafZui2DNuBQM6Q
 HomDveDNNuMFczJkf59FbK3tjuDcCVUF28pn9m+jWWKOc62wt6u0hCrPmnZAcCyw1Ng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791891498;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:Content-Language:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 bh=P6IwzhC6aat2vWpGbZh2NO7anMPHjXkTAoQnZOfaYec=;
 b=T716CkIBnBBeg8Nz3uvIB2YMLxqC1aOEtYB84X+2+co4mFeb9wi9e1Oqg5ooJQbkjRpk
 KEldKPFR96QS/yeTFZRKtmBDU4fS3i3xsH6fXz7OT4vIDSipmbretWWvrxuBhx61M+Foi
 eNZFgZrLBCAsCBreZVSzsoLy0jHc3SIvbQKF9pLejxfpWoCw1cFUs8wsoao84yU5QXs1A
 cMXAQ9SugaOrHggRrp1a/EeeVIZnALSyWhzTAJdLB1IPMu0vs+nhswuqqh4QEBHH0wRvm
 sfZef2CxfshRZ5MO+xYhmcZdOc2YhSVJ2cCBKMGjozY8EEENDE7FOv8gF+HqvmA5dww==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=TBYjwTse; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=TBYjwTse; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=TBYjwTse; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=TBYjwTse
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 44A1180962
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:38:17 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=cJZq9xh/21femMghALWDJIJydnREzyfjx6VWDPMVW5qPhV3YTB7b8k4pzVmSqGD+GgsZp/Y4MYSa4VX0qI1YKQL/4HjZsC1O+33IBEVD72cp592pVBY9m/8uOMmuSbtN6NjuJXTHEU1f8o5BtUZ70IVMzDq9S36eMAFn3Z2kcBpDTwfnCUBHEAnNLelqJPdfWUClD6hHXRyXU1WiVFh1iQYG2gp9A/QdbGQlaZorkQTvqUHLuMiX+Hy898/uCTZaylJ2hH9g87iYj+H78QQSMPmXP9tORZba43RH9w1udjYl2+qVy7kAGNVBB/X8T0VChhdKQZLUL4VTbZ6LdcMX6Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6IwzhC6aat2vWpGbZh2NO7anMPHjXkTAoQnZOfaYec=;
 b=izjVvZtDeceiMti6OLPsgTrYPljojod2OkWYs54M+NWB9Ru7PHJDWQeNNEE0RNn7wLmWJOlBNjH9zIJKukLaZKg7kG1GA/J6pc9gSWoUgqySuPBj63qbJH4hze23JjEkrkSHMNYnM2atckLUaxaS3NjWvBYJPzXLzaxVYjckW8wCfutVSq/wdiX5a5f7a/vHoSmSFuPPP3WBACpm+htpLLoq6laReOG7w1kYUiuN0jOQJFPC1kANMGlHwuqjiq/9hd5DaxwxNkuAlnbjNHJiBlvqn32NXwyDwVWRUXTKK7Kr8jyJ62SnHSj42AmBABQ3wppvjCHC4u/vSSZUwUanrQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6IwzhC6aat2vWpGbZh2NO7anMPHjXkTAoQnZOfaYec=;
 b=TBYjwTseuV9B30sqnTGm9t1Q9M1eB9AVafOalhD+K5z4dolWMg2+pmTUsRpFUu7OCKexCRlUBiQGQEuKNkyNmU3910w9mN/H5orfXWAICO7PqMh49+VI820mxE56j620nCt9FwuWuQczfi3IrsdSGIrSTboIyNCuy8Blt6Ko/pY=
Received: from DU2P251CA0023.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::35)
 by AMBPR08MB11592.eurprd08.prod.outlook.com (2603:10a6:20b:6f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:38:09 +0000
Received: from DU2PEPF00028D08.eurprd03.prod.outlook.com
 (2603:10a6:10:230:cafe::5a) by DU2P251CA0023.outlook.office365.com
 (2603:10a6:10:230::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:38:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D08.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 11:38:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AM+L+9kCXEDE6nDQ20sfJ+uKyE6vWHb7JRfDmgt23pCi8/g9Qe6n5hFNVkFLlDsgbkdS5MPVWP0P7OW7wnUVuNQdY0Gcn1cN6MrstiauK+waMsT6wz5aj1BIffnfDoGHwyxZxLtXjywGfmmMdiX2FiUl0sVQxYdH6SFx5ZSzBDZdDE1VyFrTtWwnm3sdedJa/iljO/Ot9T4LtBTvFMHkZ07AMtpbpmoBmInBIZf4ixCJ0MJdrEodsaA3+WiXfLjNI+VhzNGxSJIdYGhwfrzinvlKk+LwElR+UoXpOrleR0EI6c98HQ042wpCgX2gU3Ai/wfffOJ8bzY4ZpAnU98XZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6IwzhC6aat2vWpGbZh2NO7anMPHjXkTAoQnZOfaYec=;
 b=EDFwsWCKxLvH7zGPp0NO0bn+PdoR6JCVCqpglmqvpmL5nJ9l+11ZEIh46LIFOW+5lWgKYGF8XryYe06WeFfajLZ9lSfUh8hnWweaQ6t6rY92173smh0r1hNsLaEdkpWl75ZM8aXwH9gtQcbHRzCEpx4bYIXotXNpo6adLYKSS47CCXtpigdqpx7gi7Ev+wYD69jjwJ3Vgot3vUs0phqtndjoZwQvvtOVl4j2L0R57Ke1LMvU3HOp3EsjtUMUcQPV8BWCGJZUlp3qi+nA0uFey0KP663lTX1XEjQBrHMUmCXriKHQeAc/ioyblQ3KVg0j8OE4etI5UVrAkX24Jg3rdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6IwzhC6aat2vWpGbZh2NO7anMPHjXkTAoQnZOfaYec=;
 b=TBYjwTseuV9B30sqnTGm9t1Q9M1eB9AVafOalhD+K5z4dolWMg2+pmTUsRpFUu7OCKexCRlUBiQGQEuKNkyNmU3910w9mN/H5orfXWAICO7PqMh49+VI820mxE56j620nCt9FwuWuQczfi3IrsdSGIrSTboIyNCuy8Blt6Ko/pY=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU0PR08MB7568.eurprd08.prod.outlook.com
 (2603:10a6:10:31d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:37:35 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 11:37:34 +0000
Message-ID: <f21a86c4-9a2e-4eaf-9e77-3224fb6b54b9@arm.com>
Date: Tue, 13 Oct 2026 13:37:27 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Please pull net-20261013
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 nd <nd@arm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0541.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU0PR08MB7568:EE_|DU2PEPF00028D08:EE_|AMBPR08MB11592:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c6d0295-e07b-4929-1291-08df291e73b1
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|261009223027099003|18002099003|10067099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: UMF6zsh5XxJ/pW2eUHwGbY/ruCAekZHqhyunmmUvzt7loVRF2mQG1P4lJnLCgKunodAFMlxoVQLlYiLTGudnug/7RThTLQl/SRLX9Fmz+ewhIIe9kV44l5p1ZpzU4ZJd+qS3kCZ+HFdkjEwVL9vj8oH3XRGl9R/pG9rn403zJpL+E2ynBCaVAn2N0dXyDdpKZMbz09UBH+ilr55eTP/b6L8Ga7icy8SKYwxKq+abYswtk6D1lQHFsR5r01jShq5y32aATq7HMe2YzhrbOvS1zlP7/RpeFZ6qQZ4kOPW86FMgqMPdAAwwaqVKHEwiPcKdqR2Y6sXaoXwqC3AONO5H9Qm5QC3FJ1kFbE/qgErratOK1HVHzStjnpOsSFESDVLDVnwPETjtqeoRYdYW6M6YdZP0MsbbPnWSf32xrdMhK+5v+t1SsV+DDn0IpkQZRcYDCl7ObUw7axGdxFcAtWnb//veATPdcyT2HAnTSV8ROWKQj6XJ1Vlg8Q4I84Am35Z5z4BoGVupZPHokb4FVrGAa9a3eX7TJzP/w6FjbGjNKH/AMHTpqCs0NfOrSIgBGtzAomGzHpq7dwdxFH3dvXbFahwoCZhHglamk0gwnmBIdbJL1Nc4MwTypGqosPJAt/ko
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: avfXkgdZfLF6OgCP92oQQiR19L8uYp5ELNtA7qKYjI6byKyu1dsWAKAXrU3cd5tMjFfVsXCq5YFmbHfztqTZ0XRwDoyW4UfO5yOIS4iBStXBv7A9/SOmjA/Yr+TukT7Ktvle+U7Xr9NfWofkptXA1RMS+MLUJpbnEaLuZR2G3rPn0HNJVVSNQ+U/bZHCsums1FQukXgXATp/T4TU+rEQuaNdi6PqEmFizuOm75XjGAnMTaY80rKAksmk6YZBwFeX9nQW2h6s0A4IhA2W/j6YXUTmTXVDV/RGRQexdNZBlKG+udJofs8ykzSrQTbLAPLhPEPs67VgKDnDVxEF++dr6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7568
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ede008bd-22c6-40c5-bc23-08df291e6026
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|376014|82310400026|1800799024|14060799003|36860700016|23010399003|6133799003|10067099003|18002099003|13003099007|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: kZvZxaC9HEmOEQorNJTFdnjM1BSkSQES8cjE6NZ3LsWugTsdBX+zVmL678zlKaOQSEEG79eqxgBq8hCiAwlta1Bl9QP04gWfVFs2vkkLY4Js5vszNM9ZG3+ES/jPpgxMhxZfnmuF2CCXu4Yx2aJ8CtWmliZd8/C53JsoUsBPmWp3GpC729ohr9tw6FpsLJdfMHMEcURV37fqnG1cAHv67EKFuJ3JrYvjPBIY8fmHwrOr0vpZAABbFU3LSwLKUQMM+3f1BZgZ+jf0x9xbHDQp1IEHwEfelJDblJsJkET0RLgJoAnWupvVjiRgkOxW4CqMPZHZSqyuLjB91ZGW1yOW4T0XD6qSSjiGwxZD4TI/theanKLKjY0VL0oYvihBbvlvAxDZvhd8kZ9gNESVPMTT+/91mlSyIA/fZGd+D4zXsBPuHyOWoqWst9UFPT4ZTtzmofzP1M2uKBBbUAxwm5l7RndBB8W2ZyfMBr3pbLpewEJq61k8OeO+RUTt5brUduZ35oWgfI3z7bjiIF6J3iL0+n93bWoIM4WQSF0rzY6PSDonlcxZfqkRp9KRwZVyLpBCLd0mMBjt3eFJOmKAuGCo4vwtn0sahxVO1bCgOzigJgC9R3x2vEMzGJ+zOyuQUgFEX0TxGx0bWu424lZZElpdng==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(376014)(82310400026)(1800799024)(14060799003)(36860700016)(23010399003)(6133799003)(10067099003)(18002099003)(13003099007)(3023799007)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rIKrqK0MJpWAbFtL4dD0mw/86Weipbd1Gdiw5C7qajWWEJBICC871BIh1Uc9x05VnYUiJ51W/tkfkxhDv64X50QXsf7VwgojFOH76Ho58JJ6rzvX4HD91ZAu/tt1dFdpIqI1SLxkb3ovdL3hQMMopInwm0554+ouOG0ok4c7z4odH7qrE6v8NC59eFX0mv65+oa9HqJfb5+Oyxk9A0+YIpP/sATpXC62KzaO6YxFfU8Q64iO8R/trKTwfRpHGMEAodwI53tItl4d8xaXYdOmjQHR52DNnHuEkkrqotFW07qA5dkl8zfUA08CvmFGfkoJNuSPjfnhnV54qS6hCDSSm9dzDdPVPvmOWx7wpjuOq6OyQlQ929fFYx3GXxztmFaw8vzQVxowEMmccpokD36F5bPYyc2zE1AtUxk3uLzcF0kp2OT5YTunKJwRFDGphhu4
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:38:07.6179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6d0295-e07b-4929-1291-08df291e73b1
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D08.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB11592
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

Hi Tom,

The following changes since commit fed92546960a92177d67c0b8d7b22385f50fed29:

  Gitlab CI: sage: Update for labgrid 26.0 behavior (2026-10-12 11:13:40 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-net.git/ tags/net-20261013

for you to fetch changes up to acbb408dcd592dbd61592f96c812946d5af2424e:

  net: dwc_eth_qos: spacemit: add support for K3 SoC (2026-10-13 11:37:40 +0200)

----------------------------------------------------------------
Pull request net-20261013.

net-legacy:
- dhcp6 use link local address
- fix UDP checksum check for odd-length packets

net:
- e1000: use all RX descriptors
- net: fsl_ls_mdio: add match fsl,fman-memac-mdio
- phy: prioritize GMII2RGMII bridge over DM-bound PHY lookup
- dwc_eth_qos: bring PHY up before triggering DMA soft reset
- pxe_utils: Fix buffer overflow in pxe_label.num
- pxe_utils: Fix leak and double free when using fallback
- phy: dp83867: fix register number for extended read/write
- designware: Fix MDIO bus getting bound multiple times
- mdio-mux: Recover gracefully from bad parents
- dwc_eth_qos_rockchip: Fix use of mii/mdio commands
- eth-phy: Add reset control support
- dwc_eth_qos: spacemit: add support for K3 SoC

----------------------------------------------------------------
Jerome Forissier (1):
      qemu-xtensa: Increase the U-Boot memory reservation

Jonas Karlman (4):
      net: dwc_eth_qos_rockchip: Relax dependency on reset controls
      net: dwc_eth_qos_rockchip: Do not keep reset controls asserted
      net: eth-phy: Refactor DM_GPIO guard
      net: eth-phy: Add reset control support

Mingtian Li (1):
      net: fix UDP checksum check for odd-length packets

Nora Schiffer (1):
      net: phy: dp83867: fix register number for extended read/write

Pranav Tilak (1):
      net: phy: prioritize GMII2RGMII bridge over DM-bound PHY lookup

Sean Anderson (4):
      net: designware: Use if instead of #if for DM_MDIO
      net: designware: Fix MDIO bus getting bound multiple times
      net: mdio-mux: Don't crash if our parent never shows up
      net: mdio-mux: Remove ourselves when our parent is removed

Suraj Kakade (2):
      boot: pxe_utils: Fix buffer overflow in pxe_label.num
      boot: pxe_utils: Fix leak and double free when using fallback

Vincent Jardin (1):
      net: fsl_ls_mdio: add match fsl,fman-memac-mdio

Vitaliy Sochnev (1):
      net: e1000: use all RX descriptors

Yixun Lan (1):
      net: dwc_eth_qos: spacemit: add support for K3 SoC

Yuxiao Zhang (1):
      net: dhcp6 use link local address

kongchen (2):
      net: dwc_eth_qos: bring PHY up before triggering DMA soft reset
      net: phy: add support for Maxio MAE0621A Ethernet PHYs

 boot/pxe_utils.c                     |   4 +-
 configs/qemu-xtensa-dc233c_defconfig |   2 +-
 drivers/net/Kconfig                  |   9 +
 drivers/net/Makefile                 |   1 +
 drivers/net/designware.c             |  71 ++++----
 drivers/net/designware.h             |   1 +
 drivers/net/dwc_eth_qos.c            |  57 ++++---
 drivers/net/dwc_eth_qos.h            |   1 +
 drivers/net/dwc_eth_qos_rockchip.c   |  21 +--
 drivers/net/dwc_eth_qos_spacemit.c   | 313 +++++++++++++++++++++++++++++++++++
 drivers/net/dwmac_meson8b.c          |   3 +
 drivers/net/dwmac_s700.c             |   3 +
 drivers/net/dwmac_socfpga.c          |   3 +
 drivers/net/dwmac_thead.c            |   3 +
 drivers/net/e1000.c                  |  87 ++++++----
 drivers/net/eth-phy-uclass.c         |  38 +++--
 drivers/net/fsl_ls_mdio.c            |   2 +
 drivers/net/gmac_rockchip.c          |   3 +
 drivers/net/phy/Kconfig              |   8 +
 drivers/net/phy/Makefile             |   1 +
 drivers/net/phy/dp83867.c            |   4 +-
 drivers/net/phy/maxio.c              | 228 +++++++++++++++++++++++++
 drivers/net/phy/phy.c                |  12 +-
 include/pxe_utils.h                  |   2 +-
 net/mdio-mux-uclass.c                |  39 +++++
 net/net.c                            |   3 +-
 net/net6.c                           |  25 ++-
 27 files changed, 814 insertions(+), 130 deletions(-)
 create mode 100644 drivers/net/dwc_eth_qos_spacemit.c
 create mode 100644 drivers/net/phy/maxio.c

CI link: https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1571

Thanks,
-- 
Jerome

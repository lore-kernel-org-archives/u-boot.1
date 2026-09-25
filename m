Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CA62C9830D
	for <u-boot@archiver.kernel.org>; Fri, 25 Sep 2026 14:06:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 09B4760D7A;
	Fri, 25 Sep 2026 14:06:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Exprjtd4pYX2; Fri, 25 Sep 2026 14:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E398760D6D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790345205;
	b=eAL1Ga44qzpEqvl2j7PXTi/7MX5lnmyiQEx/7v/m35Db1cB13uI6A6sKqADvFA2M9QLV
	 n/jMcSkbs5iP27wYBZBkypK/vhyf0hmnzGOg9clJ4lkSY0FoX6NDfa3vfaxMDuZk+Lo1Z
	 Kl6JldD6cTha4xjZq0MifWVboYoZa0wJ1CoVdf8fnHj9G9qlQrB1QxzJxeInOLHGom54m
	 p2oPKHLUzRV+8asUe5t09hkWZrBgDqZfzdM/jMDtbgOaIEKjaY5uoVfLe6JCPIhQ3sehb
	 UM/REzgsLpXBpzYWsPTzIiSYgolsRoG9oLBN/uPlBodShtGDzz8GMdn4alOOjh17AUg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790345205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=IBWkxZw21HkVMkaiBbII6GoGMog34QgMJwCAqJFGdgk=;
	b=DZi3b6MrToVgOOLuo0HshPwCGIHyCc5adke9CzrUlEvpkzkWEVuqfCUd/MTUMAi8A/ff
	 zvJjIV/4viY0huzxNen3+UZnDbtnR9KHPAFYhJeE0K1ssiJxemWSvCM3QTCisdT0HomEC
	 m230Xf1c94LcWjryEhL2Y60q0c6WtzKndat1Mj6cLpUq3ssQ0s4NfyXZnYnZHmgFkUgR5
	 Hb1Lyjj4IEfB/jlKZd+klsEQEl7mqb9VPvByRak01qSztyubVsMTsgBFtBM/xKOqbjwlK
	 BjdRrOjFxBTMfIEnou/JrUxVKVAa43U7V69T8svnFl8WC5M/znNzjypEUbRvyMaPjww==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790345205;
	bh=IBWkxZw21HkVMkaiBbII6GoGMog34QgMJwCAqJFGdgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zNMTSeucg5nH0o0xlrutI4ZXQOIYIBAIx8sSbZRFSvHck50Hq5zttihWo8cy32Trx
	 xIkwBRNTup+8qNdVCDg0pHHOJ0GFxhxQGgle/YuHjHCGF+Hb8ZvsEBKcuf3XYhhLQM
	 TcCgxCFbz7/UqYEh8HF/oZw6Cik5s6PWpwBwV6Ah46huiVrr3E0zUbi/b2S6yFVQ+h
	 EwhO3LhtxotpeX/+3mm/Z1cXobJl7XPb143cSPnabzxXm+DhQunA0MFvRhu0g7Aajr
	 10CC8p6Eq7LUqbDwjQRDY7UxdTTUYpvTmG6MGjIzH/rtn/iWuXcNmwr0ocoiRzKQgh
	 08jHHtymR0iVQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E398760D6D;
	Fri, 25 Sep 2026 14:06:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 708E735A
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5672240475
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S6JRTxRoyj-t for <u-boot@lists.u-boot-project.org>;
 Fri, 25 Sep 2026 14:06:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CDA134005E
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790345202;
 b=CufShYUHJH+yNzSt+3+IAQEwJkmeR6OeBShgBHYBCsbBEgsdEg19X0QytGZFIsWCjAd2
 eKs4ubLcNgY7bmyOirid1G3AqwihKSooj93KkjjA8GcVY+lpS4wqZygsJc2B0i7FATwyH
 t+kMWFvuWRi6vZu/B0+qJQwP0jWOS0PcTCGIrGPW43wkjh6tH1beTFgSo8Civ7R17yYxB
 g1HSUbU98l+Q7gUmX1Vnsz6DmXUIaoYKqAGU8YhuO0RW99jjfw2VJRLHacN68JgJhu1BT
 wyqzhTb9VSiyGpqsUaShnU3LnNLqFtrTbz1hco2tPpfHJZYYfjJHdZpv6JwSzP5H6Tg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790345202;
 h=Received-SPF:DKIM-Signature:Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:Content-Type:Content-Disposition:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:
 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=IBWkxZw21HkVMkaiBbII6GoGMog34QgMJwCAqJFGdgk=;
 b=KJrw791gFFwAcbKUsJKBb+ZkNBQ1RkXHwOiAoQNlwryLLUoi0NrrmT55RpLwHF7vc1Ox
 uAqTu7Uur6OZ98wzzeVsn/FummIyi6xBF3aH54dD7S9trNroze3nlqp+uS3sA2ZAWfHdN
 fZvDD4HhsKSQC/odx8QfwNhWIUCWKsJ8ktZwTkwQQzII7Ea5DehjDPwSGoH1O9lWHluSi
 X45D082w8HlHSBFgBLBy9WkmCPbWCsTrudf8B0v1PFNRJ7kY2F2IzM5tc3n4kKroH7HSo
 yK9/K3DM9HPZGuPXUsFYwltxfvOZnI2KzPPcQITkk/eE8/IYuGFmiUqDntwnB+lBceA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=k5Kl6HI5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=k5Kl6HI5
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CDA134005E
 for <u-boot@lists.u-boot-project.org>; Fri, 25 Sep 2026 14:06:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdlou7mBTjK/JCLEqdewtPBsEAd9eXkvY3pkutA9wgv6ZyjAWneuYLKO4+cpSZXp5WfLVM5GXfaWA/G8Eh01INc9ejRTDfEqQ1M0Yrzb5KwZVVy47WHjEo08WGU51R03mh92v17I2t/IOiaOLGa59vyJ/O8Hs4+PzfBGY3k/qizAxynqPpF8sTbbD9GHlsRUg9FPmwzKt1L/Jha/FHLGFT9vhxL2w+URrN+EtwR4g14KO2iLwHeloeyt70LameqXqSgbxNSlxsVevcbHwp0xC+HZGBekEKoat/P5OHMZPdVVVH/XOGc0AtMLEU1podSxOc5Uhjd3Esw0Unh4SdNuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBWkxZw21HkVMkaiBbII6GoGMog34QgMJwCAqJFGdgk=;
 b=X0ufxmoDwqtFUUIP4V8N/euJNrseZqbNplFo+LcG0GXd1iVZKUWGBA1w5cIYbfc9ARAh38bLiLgrx27Bc0Sr5+QlG8NA7pxBOzSFUgE8DTMhRlV2LcRcr8CHwb2aAjSNoJ6TrhOnQTOE5++9c9UlwJN3uQWCEOym+lwkGVKp6hoI6QAbfoAC4MxZNufCAhvffBGw6c1dWi8JHDVAKdFF/2pESk2hAoX/X3TB6Rm3Ym/J0cg+/UYLzBPZzR1I5N5V9EtapexSbCqQ/fMuZLDmOqDLxseu+x4uyUmT8/0q5kIC7jPnpJ8t1Xu9ili6/a7gRTuMT2JGlJ/oIr+yq52MpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBWkxZw21HkVMkaiBbII6GoGMog34QgMJwCAqJFGdgk=;
 b=k5Kl6HI5yk47BC9WbQvF8K/Io14T97BNmOTkYoQGktNiYGoirASv4viQwecDqXUk1IcL+2LfM+/Snk/xDk5hWkpEtC6yAj70aRaSfvrxtkXikGytlltB0EvSNeVX6L23bSs+dEFGDf3qqAQ6s1mtiSGx6ptzGacQLxZW6Oac5Cy4wTnFJfk/NMXeDMJvDNyj5GB+m1xbIdi5EzRhRn7Bdh/R9hvaCCz4cjGfeiZMNMKt5AKMM5JjJdbIrlFcsSdROmLUgh56391eoHi/pHZoB/F9Ne/sFjJxEMiUoX/KaXR9PYYRuO/H5SL2JsiDTyZlRxS5TwNejJ129SZZtLNxHA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by GV2PR04MB11565.eurprd04.prod.outlook.com (2603:10a6:150:2a7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:06:36 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:06:36 +0000
Date: Fri, 25 Sep 2026 17:06:33 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Tom Rini <trini@konsulko.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: Re: [PATCH v3 3/5] board: lx2160a: split SD1's second 40GE port into
 4x 10G
Message-ID: <20260925140633.ucykvjztmrerumhl@skbuf>
References: <20260916211549.3432913-1-vjardin@free.fr>
 <20260916211549.3432913-4-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916211549.3432913-4-vjardin@free.fr>
X-ClientProxiedBy: VI1PR06CA0136.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::29) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|GV2PR04MB11565:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e053173-81ea-44fe-d420-08df1b0e35e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|10070799003|1800799024|376014|366016|23010399003|4143699003|6133799003|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: KOto4O2cf6LJSfqNiJxL2yCpZOXUM8Edgb4FSwS+wrbikda4Hie4QLBp/NadvrcCbqOiyz9n5sqT80uRMNW72grbZhNx+MHKYwqsJRamwt6u5SJFpTJkyaE3KGVf1sGcfP/g55vGWO55lD8Vd215DTVxPW5XrmFYUbpmpYjwVQrgutyNfCmUc7YEE+kH2m6xikJgHpP/bvAXXNhYaGPT2nDAcFi7sa1haQhXSJGegwTKvIjzeTT7e5ZLKRdrC65ei60YBmmZCSG/TUmAAc39q21w28Hry/ZU28Cey8jYPaQ5BJdPYGYwQJPBdkxlqr3UsJT1TlTnDZkax7CqOBGG1gEm7g0//U1rMWffw74ayOTqI0m0m0fwNybvQX9va5l/zx8XdxZn9awNAoBgEDyKOyYFyTtbl5aNEk5Ie2R9uQ8mpuZONu91YeITnhYYEDW7zf1dnpANtdD8sqcc01cKjx15ieNAtcD9ls3mPY/3oO9CEIu7AY85+x6e9+sYjHoWrXKOpC9F+puzmc0ewM1S4zUoZySQIydS+INETJuKS34WcVCgKwbPOgmT9+K0cCA+qX71rHKRGDwZQwnOjmGDpkQC0L6fO1BG+0Mvfqh7q1SblGw8In3A+fo5rzoEiD5UCCJyUuulQbc9nsUBX8VXJfPP2hhVjwduI2yvaNDP0D/+wG5fniGN7g4B0+t3dFZKuiTIGt/QcKyCEvCt4Z3yeyuCfGQNPuKBUfVwskv5f25Ve/udCyhGQVJYFUx299tq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(10070799003)(1800799024)(376014)(366016)(23010399003)(4143699003)(6133799003)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S0THRrnYu54fmjHO9dZioDT+3Ex39ALSibC/E8miHXUswXss2qbXbbPa1ywt?=
 =?us-ascii?Q?C5+yzKvlNMYd9Zmsc/lZHfHeytHuM1N1wTW8J6CcwXArubXetndy+shY71id?=
 =?us-ascii?Q?OMNq+v7dgcn1z1C0GcaWZgI576vl8Nq0AQesqTV0ZjOEAK1aRjlCB30hIQCd?=
 =?us-ascii?Q?+jh6TXd/h0QXBksItcHjIkG4xmAZ2zrZ/GPJOWi+tKlvLrpTOSjijBAGeufd?=
 =?us-ascii?Q?EIq4RRMC76LEBisai3XhR68fzHvbFU9A7UQmbwECr+SPXcc8U5qFTZMBggO8?=
 =?us-ascii?Q?Gw6vHdMDa9LWaVHu9e6Kr8wiKLDLx+JwjcnqCrn5z/OaVdbPX6Q61FYI+WQ1?=
 =?us-ascii?Q?FQRymVZM07+3363oYgnim1Cnubjeb2l7emg7AjBC0foFwZbEifhbbHb6Jq3g?=
 =?us-ascii?Q?tgoeim3+/oVSPk6cJdopaacdQlc2MLIi6OQvj2xqVxEFyCZBdO1pFPzAoUxd?=
 =?us-ascii?Q?3rqHyoGHW8tVVsLGvam8jpSV0Tz2/EvlX7MifNsCr51gQG+xPSBPngv/a4s1?=
 =?us-ascii?Q?b4FkTDw5U+JKG+G2TYXKsGEgdZhv/sr0EhrcJuTmRlFoeQI6O9zJTalrNfSA?=
 =?us-ascii?Q?0SIpG+oVG7IzUr3JOYUzPJMLry80bJ52g2QEkeqp4VlutaCcSx1mFfxMUBpq?=
 =?us-ascii?Q?YiJNqmjStWh5Q+Sj/Aj+4ZsdGX5ILz+FnPBjGoMnUc7mPwoZfXeBp3Xvc9nd?=
 =?us-ascii?Q?hncOA5CUNK4NwbSH+lCesInqt+0Gm2p7SMmh2NQqJCBBzj1jlVSRHTUVieY9?=
 =?us-ascii?Q?Uu5puVm/sz1piqzpteB5MhNe8oaLeO/i1krZr6bojoN1/ZBY0+FlK2ctHiwi?=
 =?us-ascii?Q?4J8x9IqJCFZIu9qxegLa1vWfOe8LtqHhJLR8fIqzTZkPjz76DfghohxMYgrx?=
 =?us-ascii?Q?7c6hOmMMk12TICz6ewwfVJNK2J79JJ5VcwJaEr2MtVRRZkqSZwQ3q4rd+zXL?=
 =?us-ascii?Q?amRjHPPV7X43F9X8w9GwIUyfyoyw20Tka6vFtOWcoYhMOu/oACjNb54DhdyK?=
 =?us-ascii?Q?THPY+l65NbX141DRVGY8by+DxvjHTIlbAowdEM5Wn9NMBKbLBdATZU2rG4rF?=
 =?us-ascii?Q?xofCeADikI3aG+IkR30XVy3m9HmkxWb255ULfFh1kDvZMROEPMLe3Zj9wFNN?=
 =?us-ascii?Q?rrSvtg6mea9xUZzCio+FDjjhxgmSA1Zjj4lbA9DuQxrLHjVpUO3bvCE6j6+m?=
 =?us-ascii?Q?nkmnKZSvZ3kbtLYuieJauknOYFgp47hUjuP/TRnhMbBrAI4tMPyeucR/7Le6?=
 =?us-ascii?Q?seweI1d3vO6Q0Dz4MXVUXt9yPdrTng33VTR8JgJj9gGBvemUaLapGWXMQ2H/?=
 =?us-ascii?Q?n0NAc9Q4aT5BElORSSmGN9eNo30X19xxUOf1GRy1xx/XqCdhhkPKHnZ8RyDu?=
 =?us-ascii?Q?3TEbNVNDYUOrkmcEmcLH8WDhT7NN1K3Q4PkkOLOaBJz2FFOnipfdsdnWDBA0?=
 =?us-ascii?Q?86RcClhP2/Q3UP87IPyKUyichEj9DHSE4nHA2SJW5VtM062Wb1DgcNc2vdlj?=
 =?us-ascii?Q?RFfFG+t9fhosUTx6yPzseTGgBRemUHLGGFkiH9aImf0Plx50Wl6uwYm7KmFU?=
 =?us-ascii?Q?e4lHQnkZa0p//gk7GDQUAc3oUEtNOQsg4t+8cLMaCn8VAGpQGtQzAD+2G/Lj?=
 =?us-ascii?Q?LKX0J4NSm2z+xOzHTTbHplNRUGF2T2+uzrUp9jb88waiarmcGCm6aX3RTByV?=
 =?us-ascii?Q?VQ9NXDNFEPvMuZsiJALP1qn75h5gcdR4nx7eytPnWxQAFgbTWDxY+5XrAhk1?=
 =?us-ascii?Q?6e3QX6u353WDgOeNLxT4FOHK0TSyM3DF2D3MAlhQhVVCcMRrrjVV574Nc19H?=
X-MS-Exchange-AntiSpam-MessageData-1: H++pZa+JamsFxg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e053173-81ea-44fe-d420-08df1b0e35e4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:06:35.9764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OVbNzvSHp1YqosUyaIMcD6yAyxvJjkClGE9oJ36mtk8IquRTStAIfKSOKdAqKuVigj9F/I6wiiJm8ugVOqvwew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11565
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

On Wed, Sep 16, 2026 at 11:15:47PM +0200, Vincent Jardin wrote:
> lx2160_sd1 40g4x10g, hwconfig=serdes1:40g4x10g.
> 
>   XFI   LNmGCR0 = 0x00000052   LNmTGCR0 = 0x10000000
>   40GE  LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000
>                        ^ PORT_LN0_B
> 
> same PROTO_SEL (0x0a spans XFI and 40GBase-R), same 20-bit width, same
> USE_SLOW_PLL, same BY_N_RATE_SEL.
> 
> It is inspired from the 100G+4x25G split, but using PLLS.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> ---
> 
> (no changes since v1)
> 
>  board/nxp/lx2160a/serdes_split.c | 191 ++++++++++++++++++++++++++++++-
>  board/nxp/lx2160a/serdes_split.h |  11 ++
>  2 files changed, 199 insertions(+), 3 deletions(-)
> 
> diff --git a/board/nxp/lx2160a/serdes_split.c b/board/nxp/lx2160a/serdes_split.c
> index 0f30019e20a..f48c882aa22 100644
> --- a/board/nxp/lx2160a/serdes_split.c
> +++ b/board/nxp/lx2160a/serdes_split.c
> @@ -585,6 +585,154 @@ int lx2160a_serdes1_to_40g(void)
>  	return ret;
>  }
>  
> +/*
> + * 2x 40GE -> 1x 40GE + 4x XFI (10G), keeping the QSFP group intact.
> + *
> + *   XFI  lane   LNmGCR0 = 0x00000052   LNmTGCR0 = 0x10000000
> + *   40GE lane   LNmGCR0 = 0x00010052   LNmTGCR0 = 0x10000000
> + *                            ^ PORT_LN0_B
> + */
> +#define X10G_FIRST_LANE		4
> +#define X10G_LAST_LANE		7
> +#define X10G_GCR0		0x00000052	/* as 40GE, but own port master */
> +#define X10G_PCCE		0x01000000	/* E40Gb kept (lanes 0-3) */
> +#define X10G_PCCC		0x88889999	/* XFI converters for lanes 4-7   */
> +
> +static bool srds1_is_40g_4x10g(unsigned long base)
> +{
> +	u32 pccc = in_le32((void __iomem *)SRDS_PCCC(base));
> +	u32 pcce = in_le32((void __iomem *)SRDS_PCCE(base));
> +
> +	return PCCE_E40GB_CFG(pcce) != 0 &&
> +	       PCCE_E40GA_CFG(pcce) == 0 &&
> +	       (pccc & 0xffff) == 0x9999;
> +}
> +
> +bool lx2160a_serdes1_is_40g_4x10g(void)
> +{
> +	return srds1_is_40g_4x10g(srds_base(FSL_SRDS_1));
> +}
> +
> +int lx2160a_serdes1_40g_4x10g(void)
> +{
> +	unsigned long base = srds_base(FSL_SRDS_1);
> +	int m, master = -1, keep_master = -1, ret = 0;
> +
> +	if (srds1_is_40g_4x10g(base)) {
> +		debug("lx2160a serdes: SD1 already 1x 40GE + 4x 10G\n");
> +		return 0;
> +	}
> +
> +	if (!srds1_is_40g(base)) {
> +		printf("lx2160a serdes: SD1 is not in the 2x 40GE state (PCCC=%08x PCCE=%08x), refusing\n",
> +		       in_le32((void __iomem *)SRDS_PCCC(base)),
> +		       in_le32((void __iomem *)SRDS_PCCE(base)));
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Halt. As in the 25G split, only the port master's request can
> +	 * clear, so issue all four and wait on that one.
> +	 */
> +	/* The kept group's master, recorded before anything is halted. */
> +	for (m = 0; m < SRDS_LANES; m++) {
> +		if (m >= X10G_FIRST_LANE && m <= X10G_LAST_LANE)
> +			continue;
> +		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
> +		      GCR0_PORT_LN0_B))
> +			keep_master = m;
> +	}
> +
> +	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++) {
> +		if (!(in_le32((void __iomem *)SRDS_LNmGCR0(base, m)) &
> +		      GCR0_PORT_LN0_B))
> +			master = m;
> +		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
> +			 RSTCTL_HLT_REQ);
> +		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
> +			 RSTCTL_HLT_REQ);
> +	}
> +
> +	if (master < 0) {
> +		printf("lx2160a serdes: no master lane in the dpmac.1 group, refusing\n");
> +		return -EINVAL;
> +	}
> +
> +	if (poll_clear(SRDS_LNmTRSTCTL(base, master), RSTCTL_HLT_REQ) ||
> +	    poll_clear(SRDS_LNmRRSTCTL(base, master), RSTCTL_HLT_REQ)) {
> +		printf("lx2160a serdes: lane %d did not halt within %d us, continuing\n",
> +		       master, SPLIT_POLL_US);
> +		ret = -ETIMEDOUT;
> +	}
> +
> +	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++)
> +		out_le32((void __iomem *)SRDS_LNmGCR0(base, m), X10G_GCR0);
> +
> +	out_le32((void __iomem *)SRDS_PCCE(base), X10G_PCCE);
> +	out_le32((void __iomem *)SRDS_PCCC(base), X10G_PCCC);
> +
> +	/* Reset BOTH halves, not just the four lanes whose GCR0 changed */
> +	for (m = X10G_FIRST_LANE; m <= X10G_LAST_LANE; m++) {
> +		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
> +			 RSTCTL_RST_REQ);
> +		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
> +			 RSTCTL_RST_REQ);
> +	}
> +
> +	for (m = 0; m < SRDS_LANES; m++) {
> +		if (m >= X10G_FIRST_LANE && m <= X10G_LAST_LANE)
> +			continue;
> +		if (m == keep_master)
> +			continue;
> +		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m),
> +			 RSTCTL_RST_REQ);
> +		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m),
> +			 RSTCTL_RST_REQ);
> +	}
> +
> +	if (keep_master >= 0) {
> +		out_le32((void __iomem *)SRDS_LNmTRSTCTL(base, keep_master),
> +			 RSTCTL_RST_REQ);
> +		out_le32((void __iomem *)SRDS_LNmRRSTCTL(base, keep_master),
> +			 RSTCTL_RST_REQ);
> +	} else {
> +		printf("lx2160a serdes: no master lane in the kept 40GE group, it was not reset\n");
> +		ret = -EINVAL;
> +	}
> +
> +	for (m = 0; m < SRDS_LANES; m++) {
> +		u32 t, r;
> +
> +		if (poll_clear(SRDS_LNmTRSTCTL(base, m), RSTCTL_RST_REQ) ||
> +		    poll_clear(SRDS_LNmRRSTCTL(base, m), RSTCTL_RST_REQ)) {
> +			printf("lx2160a serdes: lane %d reset did not complete within %d us\n",
> +			       m, SPLIT_POLL_US);
> +			ret = -ETIMEDOUT;
> +			continue;
> +		}
> +
> +		t = in_le32((void __iomem *)SRDS_LNmTRSTCTL(base, m));
> +		r = in_le32((void __iomem *)SRDS_LNmRRSTCTL(base, m));
> +		if (!(t & RSTCTL_RST_DONE) || !(r & RSTCTL_RST_DONE)) {
> +			printf("lx2160a serdes: lane %d reset finished without RST_DONE (TRSTCTL=%08x RRSTCTL=%08x)\n",
> +			       m, t, r);
> +			ret = -EIO;
> +		}
> +	}
> +
> +	if (!srds1_is_40g_4x10g(base)) {
> +		printf("lx2160a serdes: 4x 10G split did not take (PCCC=%08x PCCE=%08x)\n",
> +		       in_le32((void __iomem *)SRDS_PCCC(base)),
> +		       in_le32((void __iomem *)SRDS_PCCE(base)));
> +		return -EIO;
> +	}
> +
> +	printf("lx2160a serdes: SD1 now 1x 40GE (dpmac.2) + 4x 10G (dpmac.3-6)%s\n",
> +	       ret ? " (with warnings above)" : "");
> +
> +	return ret;
> +}
> +
>  /*
>   *   setenv hwconfig serdes1:100g4x25g
>   *   setenv hwconfig serdes1:2x40g
> @@ -598,8 +746,9 @@ int lx2160a_serdes1_to_40g(void)
>  void lx2160a_serdes_apply_hwconfig(void)
>  {
>  	if (hwconfig_sub("serdes1", "100g4x25g")) {
> -		if (hwconfig_sub("serdes1", "2x40g"))
> -			printf("lx2160a serdes: hwconfig asks for both serdes1:100g4x25g and serdes1:2x40g, doing the split only\n");
> +		if (hwconfig_sub("serdes1", "2x40g") ||
> +		    hwconfig_sub("serdes1", "40g4x10g"))
> +			printf("lx2160a serdes: hwconfig asks for serdes1:100g4x25g alongside a 40GE mode, doing the split only\n");
>  		if (lx2160a_serdes1_is_split())
>  			return;
>  
> @@ -607,6 +756,23 @@ void lx2160a_serdes_apply_hwconfig(void)
>  		return;
>  	}
>  
> +	/*
> +	 * serdes1:40g4x10g is a target MODE, not a second step the user has
> +	 * to sequence by hand: it implies the 40GE conversion first,
> +	 * because 1x 40GE + 4x 10G is reached by splitting one of the two
> +	 * 40GE ports.
> +	 */
> +	if (hwconfig_sub("serdes1", "40g4x10g")) {
> +		if (lx2160a_serdes1_is_40g_4x10g())
> +			return;
> +
> +		if (!lx2160a_serdes1_is_40g() && lx2160a_serdes1_to_40g())
> +			return;
> +
> +		lx2160a_serdes1_40g_4x10g();
> +		return;
> +	}
> +
>  	if (!hwconfig_sub("serdes1", "2x40g"))
>  		return;
>  
> @@ -671,6 +837,22 @@ static int do_lx2160_sd1(struct cmd_tbl *cmdtp, int flag,
>  		return CMD_RET_SUCCESS;
>  	}
>  
> +	if (!strcmp(argv[1], "40g4x10g")) {
> +		if (!IS_ENABLED(CONFIG_ARCH_LX2160A)) {
> +			printf("no 40GE on SerDes 1 to split on this SoC\n");
> +			return CMD_RET_FAILURE;
> +		}
> +		if (argc != 2)
> +			return CMD_RET_USAGE;
> +		if (lx2160a_serdes1_is_40g_4x10g()) {
> +			printf("SD1 is already 1x 40GE + 4x 10G, nothing to do\n");
> +			return CMD_RET_SUCCESS;
> +		}
> +		if (lx2160a_serdes1_40g_4x10g())
> +			return CMD_RET_FAILURE;
> +		return CMD_RET_SUCCESS;
> +	}
> +
>  	return CMD_RET_USAGE;
>  }
>  
> @@ -714,7 +896,10 @@ static int do_lx2160_serdes(struct cmd_tbl *cmdtp, int flag,
>  	"    - convert SD1 2x 100GE into 2x 40GE without touching the RCW.\n"	\
>  	"      Must run before the MC starts, and the DPC must carry\n"		\
>  	"      board_info/serdes/follow_hw_pssr: RCWSR still reads 13.\n"	\
> -	"      Undo with `reset`. Permanent: setenv hwconfig serdes1:2x40g"
> +	"      Undo with `reset`. Permanent: setenv hwconfig serdes1:2x40g\n"	\
> +	"lx2160_sd1 40g4x10g\n"							\
> +	"    - split SD1's dpmac.1 40GE port into 4x 10G,\n"			\
> +	"      Permanent: setenv hwconfig serdes1:40g4x10g (implies 2x40g)"

I'll add here a comment that applies to the entire lx2160_sd1 command,
not specific to this hunk.

I see it as a huge foot gun. If the MC firmware has already booted, you
don't want to allow any further SerDes lane splitting/unsplitting,
because as you say, the follow_hw_pssr logic in the MC has already run.

Combined with the fact that the mcinitcmd env variable is executed by
mc_env_boot() before the shell even loads, and by default it boots the
MC firmware already, I think this is just asking for problems. You never
warn the user that the MC firmware was already loaded.

I don't really see a practical use case for the lx2160_sd1 command.
Would it work for your board to just reset the system after you
setenv hwconfig && saveenv?

>  #else
>  #define SD1_CMD_HELP							\
>  	"    - no SerDes 1 Ethernet modes on this SoC"
> diff --git a/board/nxp/lx2160a/serdes_split.h b/board/nxp/lx2160a/serdes_split.h
> index 36d486d7301..1b65848db2f 100644
> --- a/board/nxp/lx2160a/serdes_split.h
> +++ b/board/nxp/lx2160a/serdes_split.h
> @@ -34,6 +34,17 @@ bool lx2160a_serdes1_is_40g(void);
>   */
>  int lx2160a_serdes1_to_40g(void);
>  
> +/* Is SerDes 1 already 1x 40GE + 4x 10G? */
> +bool lx2160a_serdes1_is_40g_4x10g(void);
> +
> +/*
> + * Split SerDes 1's dpmac.1 40GE port into 4x 10G (dpmac.3-6),
> + * keeping dpmac.2 as one 40GE port.
> + *
> + * Refuses unless SD1 is in the 2x 40GE state.
> + */
> +int lx2160a_serdes1_40g_4x10g(void);
> +

You don't need to export to serdes_split.h functions which are called
exclusively from serdes_split.c. This applies to the vast majority of
the functions which are already present here.

Also, a general comment regarding code organization: have you
considered a structured approach with SerDes configurations
(aka array of structures with function pointers), carrying their
- name
- detection method
- method to verify whether the initial conditions are fulfilled
- method to switch to it
?

As an alternative to this ad-hoc lx2160a_serdes1_is_CONFIG_X() and
lx2160a_serdes1_CONFIG_X() organization scheme.

>  void lx2160a_serdes_apply_hwconfig(void);
>  
>  #endif /* __LX2160A_SERDES_SPLIT_H */
> -- 
> 2.43.0
>

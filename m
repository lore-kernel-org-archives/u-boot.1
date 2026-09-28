Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AB8FCA5FA5
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 15:05:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 812C980E25;
	Mon, 28 Sep 2026 15:05:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dCjKHD3pT0xr; Mon, 28 Sep 2026 15:05:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 931F480DEC
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790607930;
	b=A51QUcnXFGxzXF4nvzp7p/tfIjvuZFEqzLZcZOvKnKKijN9SKYuafTslrW2sQYlPspYq
	 zEt7OdHE3ymMhVhQXs00o5Ewumg1ome9luKS+nfbLnSt831BV6ZYrHB5DvbwqrX/uH/fP
	 WxV1hY0pAL9IRQxwbbFVCUS5YC3ErHg2i5mShvXRL2aeX8wEWHdXnpI+9ZtrHTzByEGx+
	 UN5/w9vUI58epE0Le6cZBNTcCs+1eUfMCXuSij0CQXi+7Wx2ECughGouOezPMYkHgi9yZ
	 arF4G43jyA/Ggz37oRCuizC/+gYm21/KMxnayRR5PQTfputSgGLbFqEniEc78FVCfcg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790607930;
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
	bh=ArMwXjOEoEhqDjU0snk8cVVEEkTneFf0kpjbgeFuOZo=;
	b=nAHLVgVjC/qM1CpjoKDlYJKsUG7eKS6pNDKxO4OefTLHJxWGMiffd15WJcd+C+2dVDaC
	 B4+wMHNHiBEm92NE/wm+L8EPJZ1mc912FparwRYINxx+Tan2O7T3YagkJad2Na71E5QlZ
	 KumhlbocWbPMqJjj9DrxEnXKovFR2OeaKQZI0cHCEDRR0Rbi9Y+JJXW2Z4V3xL7Wp0dgw
	 d0kwFBnmOL8fQhPOiYZl4pKTb8Ue7eB0Ox5ubif1mJweDzllkS34/pWRWJV8EHN1jtB0N
	 qsxWXgY/jAw9ZhjPJoDtlRjeaSFdarBRzLIEoJTS7xCX0RJZLGkSAdOL168usCFFXrQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790607930;
	bh=ArMwXjOEoEhqDjU0snk8cVVEEkTneFf0kpjbgeFuOZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rx1fXGRuV5+my7YwBnYxdAW9HtaGTgU+qkhEbIDhNIdittSymP360PzDbLahInvJb
	 0ltvXb/P7JMFRTgfpzb0Hn8UtvwZZIiOmZSY1anEKGRbHjBAcICO7gBiF9W0rR+ZF+
	 BQaFFFp1viloUzOzCEjLTI4E95aIzvGd7IZfNwi3AaC8ANQbZxKF+Biu/4hRmX8zfp
	 NfeaMlNtjyQ3MOZwCZ06haSPKpdHaNpi6CmTpd7kIG12UYNSeQtGfinWIKfqFEEAe8
	 H2z6ZYZ7MTPWh3weJFXZIuFBu3VqFM8mczT3eKsw+LR2OpZFmPAMDr3/bm4UT/NTPe
	 CxTy/Hu6Cizew==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 931F480DEC;
	Mon, 28 Sep 2026 15:05:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1420724E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 112C1401ED
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fx3J150zqu9G for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 15:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D33B440076
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790607928;
 b=gAmlLXdNTQNLaapSrXbgkFDbIfGVciHWc931mHHccoZdKHi75RFYTSA9wCfd6bs8Nn5+
 DrHoXDyPoXQd9Ok3yStJmwByKFeSoIl02xuU3BROopO0T26GWhQRpOUEdY1IFdoePK4kl
 lk/Z+O4zxmhEtv1KLAmGQLjaH7T+aG4V8xgposlTp5z/EX7EQR6G0i2eZ+p/zvxDIT2Tf
 1d69T7vlZ93ysebwBAJjmnweOYukB+Qja/tixvGR2XPczaDVs8YZKldsBZnfXomksMBmt
 eTIc27Hk6Obk8b4C93ajj4SxAu4+YaO1CYLCqW028X6WTBxRHiR3KgaU/+9zLVrtQqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790607928;
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
 bh=ArMwXjOEoEhqDjU0snk8cVVEEkTneFf0kpjbgeFuOZo=;
 b=RY+38K0opDAaMJ8Rs3T89XQvy/Ya2eMJA5BnAU8OPJGcUye+Ad+zmXJ44W3qRyo+MlER
 1+TP+r1kVAXkQ9fz7Bj65XzsPR5AOEBfrYB+vShWK4EGgolzClQYUuXLRyV/mMPSwV4VN
 mWw0NqZBUlwVgJDXusd8V864fkMGpHbJaA+iHmXcbBZzngMhA4QUDHaCPBV92V3UFVWdS
 HHqm9L3gKsX1+zb4nF+dlxawZLBwBLTKbJ7rw2g6gm7UOvSHC87BPWq2cKEBRhk+YQlZB
 jauQLS/2zLddnZ5eKH+XYHu162RV7Z1sVOpW0DTfUHxuL08nFy4RDHWHQIzIPvc9llA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=nxp.com; 
 dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=M9FEWWP3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=vladimir.oltean@nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256
 header.s=selector1 header.b=M9FEWWP3
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D33B440076
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 15:05:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbV8gnvqwphkqtJmwh9MfqYjcupifqtxplz+kPslcqTajtDYNNs785lVhkz9/Cu4aKoNNmOysYFqJ/GJ8/uNyUBSD5eH2MuwwERbzMuOkj6CitcZYpxaxwLhwfbzSJxRLGJpPJQQ5t07lWVqGtjCSxZ6H1gurXGIh5ac7oeHyeXaVwiDGqiWnnj+2F0od1ergxrivAtrRs8FhpXHI2Y9LfpJFvbLHEyaYMaAgHWXQ/xD9zeGPouSmrhyTHRoXW5PtzUewUfuKne2CARWBGwDDd3jOV/ka7Dhm9ZZdB49WAW0QgjByN0WlEcqHybnf4SUR57WS89s6aPRSTbys5dPcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArMwXjOEoEhqDjU0snk8cVVEEkTneFf0kpjbgeFuOZo=;
 b=To1gJklKDgcHYtVZ9BS5jYHxHvv+mWPOxQU//CkaurPuAJdgd5dxG5vc8ltMU2x5CkBqT32ROWqsRcYB2LVwwZuJAh6DHzY8BQ/GCZswia+xvegBqYMAFkiE5h3qhLgkaNm+H+cIOb68zgYpHi6+0evIg2Au+ziNbB+7CYZ64a8QNneKJ865yhgo9GTQ6XMC+t0mQ8hPOLxKJETRsrd50Fb80vijxS83MCW9H9WVFMjHU0neIwxwDEqmXwfDav1glp3O+m+M10pDbfbSzAU2J1gvw19DOZ2LPbJEipaqhiHbj6sRhsQVP8yfbpcB1xEaJQta0bFYqx2p3yeBuLpUPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArMwXjOEoEhqDjU0snk8cVVEEkTneFf0kpjbgeFuOZo=;
 b=M9FEWWP3MsLqJRXoxWkjUs4JJnEiRGw6Q6T6HDkHulYOyY9dbdNuz5nPGSD9UYk0hj5zwS6RLLmljrqn4VM7lLOGardZE/ABtKc+WV5IDzVSZsM/JAtLJARyzN7QC3QUAvFSgiZZM0sYl/5zjDO9zqI8BIu+vYvq3OoIA2SPCQejo3agOLXzufH4nq6atW+bWCzjCUhe1w+2NfnsMvtNNMyqIo0SE1hqH5d8z7OXQFdG0lKTS9s6gVa2a+xHOCl4evwEqvpqBMVv8aGVRiVzYY3LzITq0snX9KSyaOuf7PIKVE50J/rlwHn1QwuQzdpc9CjrDC9eqJIW8CuCtwskIw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by PA4PR04MB7806.eurprd04.prod.outlook.com (2603:10a6:102:c9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 15:05:23 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 15:05:23 +0000
Date: Mon, 28 Sep 2026 18:05:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Vincent Jardin <vjardin@free.fr>
Cc: u-boot@lists.u-boot-project.org, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: Re: [PATCH v4 09/10] doc: lx2160a: document the sd1 hwconfig option
Message-ID: <20260928150520.mgsfjftht7l7pgvy@skbuf>
References: <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-1-vjardin@free.fr>
 <20260928101330.881662-10-vjardin@free.fr>
 <20260928101330.881662-10-vjardin@free.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928101330.881662-10-vjardin@free.fr>
 <20260928101330.881662-10-vjardin@free.fr>
X-ClientProxiedBy: VI1PR07CA0264.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::31) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|PA4PR04MB7806:EE_
X-MS-Office365-Filtering-Correlation-Id: d67c9876-3353-4f60-06dd-08df1d71eba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|10070799003|1800799024|376014|19092799006|4143699003|5023799004|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|3023799007|15866825006|41080700001;
X-Microsoft-Antispam-Message-Info: /z63ubPqXmboe4Pv/PG4Cb/cMZqEa051joqeJud7pkD1y4zQ7HeHP7n1c/wYeDoDdmEH9PnB+ThB88XKnxgixBRa0U1L/L7sidC5zSj4gQfMvPZU2Vhl3Vw5uR06rT+YPgEAcPAv44FQqY3VTNQA3IBnJSDdOVN5SUNGgg45gflFQBIK/Iu51luv+zGFguyveWLhTHQ3DYFhiBu5jQ+FM3I2jCW+HaubNJ2KFw2Ixfg8c5UKJvfo1I4bBKiDSQbWiVn4sY3myViWnehDouZ9wn0xrEdxlbzLeA8tZCHKMxzW3L1u7PiwXKcBw6HFrBF9/HJ8h3YOJCCo6nj3HuiQneb/GyZojBkTYHk8kKy11hgK6BLU/nlDXEa50qEjlDaXwzPw8OuuntFdfVHXocZKdsJhoILRwIQTeEmM63mjfu6YLQG/FitqgyXpEwGISHxq/Gk4BWIte1S9JqvpFkLQN3UAAl/1jCITri/ER/8i7IUTcnPkDEsY6SiKChlUj2YS/IuEWt8T5bwmhas4qcFqgMnRwN2U6JDy+mkHja1k3CiVqzR9emY5eMeq2F/hrxINsxFFX8PzJOjggW1ExNdYA9uw+4yHv8pS5T76LqZp4q6mWKtdqle23rcapoxvb5MF+cZgVtDcWgpSHWdPBr6zbIE42l3GjDZtnzzC6IHyKQgBcpIxrMxSY4CawRaWrvPEmzpqxMnzQpjNrj46Jcp3FcrOCBwchkfIXI3O9odp97tTXyl+fakl/1nNbRcN5CVy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB6900.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(10070799003)(1800799024)(376014)(19092799006)(4143699003)(5023799004)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007)(15866825006)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hvx6MWn+4BefzN3M+/LfE0rhTmIt/Qf1t6LL60BWLVzQ0p+X204Hr/zm7ENk?=
 =?us-ascii?Q?rwvqwh/fI4G+VgX+BdNkj87TRfqBrHQyLxifFDzoHDfrIMthOCvfPuH1/hee?=
 =?us-ascii?Q?A8cGHF18c1aHfUW4JNM4ApFsBwR50YJkp+x1Koe30Ps0VNTVchOeqpi0qfoF?=
 =?us-ascii?Q?q8ybvFcODFbEYcWwlHqVvs6Pzack4SviK5TzsvKDdaTCPxPuGdXIwo+HW0w5?=
 =?us-ascii?Q?IfWnw5eElqXc5hxoRJRYYc504b+wBYXPdl+oAmFFYkm0lrHc2bW/BqFIxpfw?=
 =?us-ascii?Q?YGjVfaFCfBZO7x+oAevQ+/5vhhrSmlRoBuK32VPefvgOE8mctys+iN6qSb/G?=
 =?us-ascii?Q?xCwKS4euifot1fAELjFgDPJ4f7JBH7cnNy3+ErwRLcvF8Ja3K49SNOdpheAt?=
 =?us-ascii?Q?kpv1GAATAHMJ+XvJTh+Dmb/Ebt0lOH3MkcXQ5BIggYgESBN62hGoHqtHHsC0?=
 =?us-ascii?Q?IzBGPgsKeL6Kd1E/GrbmEQ3p57+Y4Ak4w62/gnWIF0pOfU1cjADXh058bQaR?=
 =?us-ascii?Q?O/XmMwlyQM1VTCofKiOjTHeQlzYo0kkXRJLxvRIW3IwWfb1l5XF7cjKoUXuE?=
 =?us-ascii?Q?MFPzmPm3Hw0/H7F/UvvP+zTFssBKl1bLcv8H0YF01YNgtjFwDcNOq0lmoDCw?=
 =?us-ascii?Q?pRR0ipz5r0hxYxACTHc/l/kv6Lo7jdUR0B2tCQPDA8QyQets8beylWNGblrq?=
 =?us-ascii?Q?Qt614w4yJRKFHZ+g1e9p1CZ3JmITR25nXTME9PkDDoi6lmH+ULNYJqdSQIG0?=
 =?us-ascii?Q?tEK0Wk+DYghHX4AsckpjmyKXai+SOeALvszFX47re+AcAkEHyvrMLEv3gzEg?=
 =?us-ascii?Q?OMrCGSzpSCd8mfg8zpfDZQ1Y5wDDH5bC3CUn4GJcKpes/jMp9vFcCyXx3R+g?=
 =?us-ascii?Q?I/SXr+G74j86Pz7gZ/BqhULcWmIcOEIWn+zdiE7AocPBOn+N4etTaCgGTeWj?=
 =?us-ascii?Q?TJ+Ck6fdDONwv9zqrrKbBjH9B2Kh/boKJGtbBuYBNle8FiuHDepPr/kiO9no?=
 =?us-ascii?Q?4EJ1KJlE7gD/INE+hsAEBC6nNxB/iAjZcenCHQPFwKB3RjvWnynGFX0IZDpZ?=
 =?us-ascii?Q?apSn0ZmTPU1TBiE/rUGmeyIoEupR2bKYmFBJZEdMlC5AbI5xSSOQml/P5P3m?=
 =?us-ascii?Q?mpApYuUsOxBWpUWG1QDnZl/WFXe4witgSPhvmPKvu3MUc3r9ploOSqmQ46i6?=
 =?us-ascii?Q?zZzroZVoNFeDsOKL2UBLG4F54CAbn0oXYYOVPn1cM1G9FfVUNENI7HA/72KI?=
 =?us-ascii?Q?q+4CUSsvGnLHE6DUigA1wDV37hfohK/My1K/COUu++T3Q1Vmct+pRV5Wl6GV?=
 =?us-ascii?Q?7CBPQDyMHkyD76f6OelyZWSdbwqq/C9PEL6eeCxr4LqkFH7W+9/8m4FUWk3D?=
 =?us-ascii?Q?5FcRO8D0nw98WG/mJbGaOf4se3FCrejnCygWgUtVrXL1s52VUsK7mOSOizfo?=
 =?us-ascii?Q?fLnnbpesi+f0t/hn1SFNi0bN8LDWDe5Vk24cGtp8N3dHTqr9HgPl4OWJaJRI?=
 =?us-ascii?Q?59soZ1BpP01TVWLCC4R5byeTE/CFpD/40Q/NwPoTb8lrhBuc8czlsgOdSK1F?=
 =?us-ascii?Q?C7hLCQrqM2dCZNW8WbICPhsYfstXBbgIbNZw4dyrqrEoENZG3X9hTehecS+n?=
 =?us-ascii?Q?gB6D6bCqlqxznILuFbE2Ch+SZ0tVEdYX86jFCs2+wDCz2ilyc90+i/+iBXNL?=
 =?us-ascii?Q?qylOgiTVfHCZlsmdx39qBtO2RNEP5OhjzTE5rkPONP4SqX+Joa4fBScxpW8y?=
 =?us-ascii?Q?BCmq5UW15PlGf65rlK3nRjZOmhRWYlMQiUfYVj80NhNWhk0P0dDzrRh7BUpS?=
X-MS-Exchange-AntiSpam-MessageData-1: u21daZQS2bk/RWfkhEsy/j2jlNq5aoLT62k=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67c9876-3353-4f60-06dd-08df1d71eba8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 15:05:23.3249 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H1hz6s8geGuCwgi4o8q9gDhDTiUKKDv7pKE9gA0L9uUdgEmdSg2UXjmaSw5ldWk4AgYsmMnwTdIzrOdsTRftYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7806
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

On Mon, Sep 28, 2026 at 12:13:28PM +0200, Vincent Jardin wrote:
> Enrich README.fsl-hwconfig with this sd1 reconfiguration scenarios.
> Add a reference to the Layerscape README.soc.
> 
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> 
> ---
> 
> Changes in v4:
> - was v3 5/5, rewritten using a table
> 
>  .../cpu/armv8/fsl-layerscape/doc/README.soc   |  7 +++
>  doc/README.fsl-hwconfig                       | 60 +++++++++++++++++++
>  2 files changed, 67 insertions(+)
> 
> diff --git a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> index f2efd4cc1d7..a641e4978aa 100644
> --- a/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> +++ b/arch/arm/cpu/armv8/fsl-layerscape/doc/README.soc
> @@ -331,6 +331,13 @@ LX2160A SoC has 2 more similar SoC personalities
>  2)LX2080A, few difference w.r.t. LX2160A:
>         a) Eight 64-bit ARM v8 Cortex-A72 CPUs
>  
> +SerDes 1 lane grouping
> +  SRDS_PRTCL_S1 is latched at reset. U-Boot can still configure SD1 before
> +  the MC starts:
> +  1x100GE + 4x25G, 2x40GE, 1x40GE + 4x10G or 1x100GE + 4x10G.
> +  See 'serdes1' in doc/README.fsl-hwconfig, and the 'lx2160_serdes status'
> +  command.
> +
>  
>  LS1028A
>  --------
> diff --git a/doc/README.fsl-hwconfig b/doc/README.fsl-hwconfig
> index e752505da49..3f9d2ddad75 100644
> --- a/doc/README.fsl-hwconfig
> +++ b/doc/README.fsl-hwconfig
> @@ -44,3 +44,63 @@ usb
>  		usb1:dr_mode=host;usb2:dr_mode=peripheral'
>  
>  		usb1:dr_mode=host,phy_type=utmi;usb2:dr_mode=host'
> +
> +serdes1
> +	Specific to the LX2160A boards whose reset_phy() calls
> +	lx2160a_serdes_apply_hwconfig() before mc_env_boot(): lx2160aqds.
> +
> +	SRDS_PRTCL_S1 is latched at reset, but the eight SD1 (SerDes) lanes
> +	can still be configured before the DPAA2 management complex (MC) starts.
> +	This option picks the grouping. The RCW, and RCWSR29, keep the
> +	protocol number.

I feel the last 2 sentences do not have a sharply defined meaning. Maybe
say "This option alters the Ethernet MAC-to-lane grouping after the fact
(RCWSR29 will continue reporting the initial protocol)"?

> +
> +	'serdes1:2x100g'
> +		2x 100GE (CAUI-4), what protocol 13 builds: nothing to do
> +
> +	'serdes1:100g4x25g'
> +		1x 100GE + 4x 25G
> +
> +	'serdes1:2x40g'
> +		2x 40GE (XLAUI-4)
> +
> +	'serdes1:40g4x10g'
> +		1x 40GE + 4x 10G (XFI)
> +
> +	'serdes1:100g4x10g'
> +		1x 100GE + 4x 10G (XFI)
> +
> +	Each mode starts from the one in the 'from' column, which is
> +	entered first when SD1 is not in it yet, and so on down to what
> +	SRDS_PRTCL_S1 built:
> +
> +		mode        from      SRDS_PRTCL_S1   lanes run on
> +		2x100g      -         13              PLLF
> +		100g4x25g   2x100g    13              PLLF
> +		2x40g       2x100g    13              PLLS
> +		40g4x10g    2x40g     13 or 20        PLLS
> +		100g4x10g   2x100g    13              PLLF and PLLS
> +
> +	What each mode makes of the two four-lane ports of protocol 13:
> +
> +		mode        dpmac.2 port   dpmac.1 port
> +		2x100g      100GE          100GE
> +		100g4x25g   100GE          4x 25G: dpmac.3 to dpmac.6
> +		2x40g       40GE           40GE
> +		40g4x10g    40GE           4x XFI: dpmac.3 to dpmac.6
> +		100g4x10g   100GE          4x XFI: dpmac.3 to dpmac.6
> +
> +	Initial conditions:
> +
> +	- The MC must not be running yet. Otherwise the mode is refused and
> +	  SD1 is left as it is.

What is actionable for the reader with this information? Assuming the
reader is a board user, and not a developer.

BTW, the first paragraph already says "Specific to the LX2160A boards
whose reset_phy() calls lx2160a_serdes_apply_hwconfig() before mc_env_boot()".

> +	- The MC DPC must set follow_hw_pssr in board_info/serdes, for the
> +	  MC to read the lanes rather than look at protocol, and the DPL
> +	  must use the dpmacs of the new grouping.

- PLLS must be provisioned with a refclk frequency from which the 10.3125 GHz
  clock net can be derived. This is kind of important, because this requirement
  does not exist on the native SRDS_PRTCL_S1=13 boot, because there, PLLS is
  simply powered down. You just _assume_ you can power it up and it will lock
  at the frequency you want.

> +
> +	'lx2160_serdes status 1' shows the resulting lane grouping and
> +	protocol converters.
> +
> +	Example:
> +		setenv hwconfig serdes1:100g4x25g
> +		saveenv
> +		reset
> -- 
> 2.43.0
>

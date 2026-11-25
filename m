Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4345606A321
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 07:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UIoZIIyD;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=cALLueSo
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A11A48087B;
	Wed, 25 Nov 2026 07:28:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G52WsOaH_497; Wed, 25 Nov 2026 07:28:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ED1818097A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795591737;
	b=eSKL5q25IIKQNh6Ms6uGDgBPxakC+rdaLwCRx0eN7W0T0aj86Tx3I89bdW3PVX8ERc55
	 CYwOouGn7ZAVo3iO7vE01Ab0jByRkBryhTwd+7XyeGxV4lJouxICN9/zX/k5MuH5ygWNS
	 cLH1So2c/Dwplyuf45V8Z2gsBmzRAXHOiFIs8fq2MJuR/uGXKRFRZkCO2XXJFHyRuYy4N
	 Tjt8id8MzdnyDUAhgieprfzhjZg3O9kswDKVeUIDTzFyghBZc2+PtfLImP4fCgJTiyjCt
	 gvWnJR9NUdTMi6HCDBX+vyCYviX5QQ6qTlnEyDP1FnLgS39snQCSKKCkjHeb8CRVltQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795591737;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=Xfw/L6s1w7bNP09/ZOf3zh4v4jNb7x1BOPMczP1zrgQ=;
	b=RPG51cmiyOXV1Q9icvM7o3RKdB9N6ZRAaoUM/3PxmK5eWpBYz+CyODqzYLQHBknEaDeS
	 WFahMM1edb3TXVzEMdVR04LwMfPZvLGlWEW1+IBgXtI70SjlsYBGb7p7hCMxHeDuWph9j
	 +E58qa6aMMelZIX4WdjuLJNagqZa/NTNb9DdSBIKTZdMmK7MjAgomyOLNynSetUUbL2q5
	 JSgqsht03YEm0ObYfdyGsz4z13s4JM7dAlkYYBGrmx20H/ful7AO8dA8BRfvBnQccW8NE
	 r9plvz/jdu1pP09c03Rjk9ckoqP7EdVi2Z4zAih63kPDkwtauBL0wAreAeUBK4JoIew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795591737;
	bh=Xfw/L6s1w7bNP09/ZOf3zh4v4jNb7x1BOPMczP1zrgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UIoZIIyDbSTDyj4bjSAvj0Ae22YFeMRJAtuPEeC/EraWNj/IDcDkKhGbAg/uKpL5p
	 4hO1qv2aZuzxp6BWAgXZDFrjK34LCYLXWq7jqikyN+OJ4a4kdk570Efso709dsLKa/
	 JSCJwpB7KzwtNHGKnJPQGoyzKr37TQXGFuVJH0hAy6lMZjLQwyHlDLZJLuzmNFlb+s
	 JRrPMi4C62nHW0z00I3fizpfJxnJn8L8d2pVJt8ILWvFgvnH9srb9VO2yF+qpPpzNG
	 GmXoRSJadoWZVaRelSnq/YD2R9ug5fLlLa0OS+DfQLGukFYSgvOZlvgqxVJ75Lkmht
	 +AcoEtUq0jMNQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED1818097A;
	Wed, 25 Nov 2026 07:28:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 414CA10B
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:28:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3279B40603
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:28:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LWWe5bz7tzPu for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 07:28:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 798504033D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=cALLueSo
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 798504033D
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 07:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xfw/L6s1w7bNP09/ZOf3zh4v4jNb7x1BOPMczP1zrgQ=;
 b=cALLueSoeK3UhKa4E0jKmgzO1AsToruKuEpw/aRDMVZga8kuo3LSeyj3MlqIWRmC/Lh7IiN12S11Ngp8EtpPAkt0DIpxRnOmQhHhnTQuPN6UvrzABzR9atCP6yG69Ck8y68y1nAdLbdSNff6BNqdv7KSs6l3KtGTkBCu4Cqn5rFYheq2dUjUti2VAt6ZzmzToE8EQHdxehkIQ2cvQJVD143S6L6/8mvBkint7KPfMD6G5kWOW/XgsVMPFfHU2EQNAT4uXZfGjiUQrD8qc8UmnY5SaZ4zUa+XktkadQ71jEvgicsdkUNdJCOPOlkpllPL7TNZp4lQ3kywybJYOLOeHQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 07:28:50 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%5]) with mapi id 15.21.0639.012; Wed, 25 Nov 2026
 07:28:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Peng Fan <peng.fan@oss.nxp.com>, Fabio Estevam <festevam@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 dl-uboot-imx <uboot-imx@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 krzysztof <krzysztof@kd-solutions.pl>, Joy Zou <joy.zou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Ye Li <ye.li@nxp.com>,
 Joseph Guo <qijian.guo@nxp.com>, Johan Jonker <jbx6244@gmail.com>,
 Vincent Jardin <vjardin@free.fr>
Subject: =?UTF-8?q?Re=3A=20=E5=9B=9E=E5=A4=8D=3A=20=5BEXT=5D=20Re=3A=20=5BPATCH=20v2=202/3=5D=20arm=3A=20dts=3A=20imx91-9x9-qsb=3A=20add=20U-Boot=20specific=20dtsi?=
Date: Wed, 25 Nov 2026 15:25:50 +0800
Message-ID: <20261125072552.27318-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <AS8PR04MB8721F0020B024C6608C35ACAE2452@AS8PR04MB8721.eurprd04.prod.outlook.com>
References: 
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:194::7) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: 55f34a48-8da6-4ced-09da-08df4ac5c02b
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|19092799006|56012099006|10067099003|11063799006|261022105027099003|261028144727099003|261026140227099003|18002099003|22082099003|41080700001;
X-Microsoft-Antispam-Message-Info: 4+cjjJyeZj5H/ez4VG2X331ToKGqT1xh6pn4DTiEmY+O1cJ+/Y1RniWv9p400TDql2yY6qQgjlZuxBLT6Ru842SRxiZd0qsuWiERQaz7X78kG56ppGMhTjA5tF02610I7LBBDS5Edk7arAnjgTMTY+8yFDSSLOXOVXt0a0Y5wI2AZXx8jQGE0PNp4k58tfy1lViLq++L2i0rGHakmmUMuWENfKqPIHdD9Mg7BzMwauk51NIAIHKdmgVbNQ2LD09T8WqV7DEsgoKYy7xoa8t9gNwot+ldS2zSlKhb48iYJTwRQ7gSjC3NpWOcFQtS5h2xxj0v6ehjbX/YR7osa1YPwfrk2co6RibpDN3BODEYHqNOqxe+dVBfUvq6K/YUVbvsRatPThUNMHClv7FNPINz9T9bqaVUIBBWPE6X7YnEnNM0MrhUCOULjpdfMj9Fi6at4IJdgbsN+wiiP0pv/XzXNbpzzxZEe8VReyGTUlSbTE6CDGkpOjz/3+ONuiupvDzvJ0f+rrPSvR+8F8GvyoJKDyCVN4tmRBETw7Q1nbdmbJZDf+N2Dq1qXKCShXSA0F2RihezrJubQAfmpl+aCFggaw0HnoRJiiXxw2XAH+t1hTYXELaFxXRBWPi8VfKiWOGRaTf5PATnUCxhr8SfoAHiLDU47Dh68C+crVKnxHwGWCEFvaLGjWjRCQIwm3WMz+6nNz91aTeJvkdeE4e9oPbFissfAe5l2QFOjHycM6KYXc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(56012099006)(10067099003)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(18002099003)(22082099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Yko1cEZkYlhZME1meUZKR2wyb3dLYWtrRnFrYTc3N05GQVJjc1pMNThOWTg1?=
 =?utf-8?B?MGJFcWgvMlU0bEV1U3A5bkxMVEdGdEdCUlh0RUJWeXBuTzBuWG9hK21zUXVv?=
 =?utf-8?B?QXp3NjZXRS9hLzFkK09LcXhiVmV1dU9HbjJYbmE1aFhRU0dXTnU5OUNPb05a?=
 =?utf-8?B?YklqV3F1UTRvZzVnRnBDTlJheFNGZjJHaFAwMFJLVkprc2FnSzhlU2JPZ2RH?=
 =?utf-8?B?bFBUbmppWC9qVnBoRE9JYkYyUEdrblUzK0dYd3FycEtEaHhRVkJMUGxNYmtN?=
 =?utf-8?B?VXhHak9EcW9lNVFaaDdIdDhhcm9wM0RHUXJhUHdxSTAwbjVYYlM1Y3M2R21G?=
 =?utf-8?B?RzNRWkFZSzFpcXpKQnJSc0hSNFFyZ3lReENZVndNbTNJQWcxdEhKUFpCNjJQ?=
 =?utf-8?B?V2wxTDZNNWFFS0hOYldybXkyaXpvS1cyNk84OFFqNFMxZ1ZFdnlaM1B3UFYr?=
 =?utf-8?B?b1Y2ZTZQMlpSSDR3ZWhoWm5EbUR3UFNDdTF0UmVoTTlzY3E4elgya0NVZ2VE?=
 =?utf-8?B?YlV4TFVFN0dqTmhWb0J4Zm9LKzJ2ZmhseUowa1B5TXVBRVVXbytQMW44Z0I1?=
 =?utf-8?B?YTVNL2IxK2VKTXdxdHIzazFhd2JJTi83QmNFMjZRbWE4Umppd1Z4NUdFUFl3?=
 =?utf-8?B?UWRkUW5pb2ZnaTV6MU9rNUI0ekZHbzhibDluTG1kdXlmMGJSeUtqcjd4c0Zi?=
 =?utf-8?B?cjBtZ1ZIQWVXbXJheXh2MW4yL25yWFpYYjcrd2cyaHh0WURsYXN3KzhrbHho?=
 =?utf-8?B?MFU2UGlTWlAyeDlEMlFFUURGVkplUGxiOFc5Rk9qc2JCTEdmeDJwbThUS2xC?=
 =?utf-8?B?Z1VCc0JPZ3ByZ2lYLzNZM2pTSnBaYmJtOWg3U0p0SDdEUEFvYVYyKzZ5N2pz?=
 =?utf-8?B?K1haYTA0NU5aL0pCQ3NjdlVhdzY2Ky9lT3VETFFLV1dHSDEvM25ObmtZNThn?=
 =?utf-8?B?WWlIQktBK2lid2pVREE0NldQOFA2QnJtWVlTR0lTQm9xYWNVNU00WERodVAw?=
 =?utf-8?B?UkdqVVVXbHQreXEyWVVrTmdsbWJxOU53QXh0RSsyRE5PQ2VDOUtMTFRwSUpG?=
 =?utf-8?B?SXBlVUpxRnp5UGExOE9oUUJyODRVRFg0bEtCSG8xdm5iZ0FlbWZvaE83a01K?=
 =?utf-8?B?azR2ZkNnYTFodCtodG5oRlUzMUk0U1FqaXhEWFNwS1lnd3Q1NWlxeDhrUUgr?=
 =?utf-8?B?bDRqMjh4RnVNZE9nbkNROTZ5bDR5WFJoa29lRVNBUHpPaWN5VW8yNW5EVUZT?=
 =?utf-8?B?aWxJV2cwTm1KV0NVamtmUG9XSVZpejB2cnJpdklubGQrS2J4bzJMUHptbzly?=
 =?utf-8?B?UE5MZGpMRVR4YUR3ZHVGR1dpQkUrSUVFNUxXZWxkbW5SbUJqc2VhckJrQXM0?=
 =?utf-8?B?aW1neWkzOG1hd2xtQWxLcUx2b1pOeXFyTGdwTnZnUnNsL2UzQVJ5bHNIbEVa?=
 =?utf-8?B?YklnejlGM1UydkVvdjV4SDZwRnpkeVA4Ty9UN0dncXYwclV6U1VUclFQa09k?=
 =?utf-8?B?TXRPRWlaVlN4cHloZHlVWTFrYjM5ZVNLVGhPWEdnaTg2cDRtZHFwMVRXS21L?=
 =?utf-8?B?dkJpVjR3WTZtTmhldTlZd2lhd3o2dmFhL0JHSkpFT0k1a1BzQy9Db25Rc0ZN?=
 =?utf-8?B?YlRKY1NCczFFNTUvYndhbC9IaE9ZQWpzVzNEb0JmZXYvN3phSmZNMUkzMmJC?=
 =?utf-8?B?aExHOUVPY043WGQyRWNiYUgyTzJhR2krdU4rbVIxSUlXTHZyaXFucUhUb1FC?=
 =?utf-8?B?bEMya3E1K2poL3FpdjFrbnc0TkVjbUJXbWhCSGJHd1VKQktDTmdsWlVjQmpI?=
 =?utf-8?B?cTdZejdQNnRQalljL2RjK0twMXZidk9LUTdlYnAxOVlUeE5uMlFFY2JNWGs3?=
 =?utf-8?B?RktMTWhTdWtFWWR6VjZ3K1ZNcjBrRndwU2h0MklvY2J2Y3B1VUd4ajRiUFA0?=
 =?utf-8?B?MjhzVDJOcHVxL2trUmNZTTlKVVhFSncvZjVOUnV5UklKcU9oNW16T21wdFNF?=
 =?utf-8?B?bGtIdnBxelRSRHN3WlZ4ZXZZcGZFajFtbGsxa0RhbjM5Qzcxckd0SEtvcE9s?=
 =?utf-8?B?U28veEU0Q0o0ZkU1RWM2Umc4MGwzVWNZWUtxcDdDekpRM0hVYjlIblVHRE9l?=
 =?utf-8?B?MXJYbmNZTTBieWR1MGVabW9Uc3E1OENkR3ZWeUpVWWl1Y09yK21VOTVUU0hp?=
 =?utf-8?B?eGw0a09ZOG9KcUxUbUdyK01uM1ZYRk4xZ2VVKzZKYXJvSFBDVkVYK090bkEw?=
 =?utf-8?B?a2NXU1BpYndKbmJWeXdST0hJSnZDeWRBSGlxZFp3NE5DNE1wRE04VUVHVWZo?=
 =?utf-8?B?ZmNYLzkzQjNBUlplcU84eko4OThYdmErNG5pSHpUUVRpOXM2aDhiYVZHYmVK?=
 =?utf-8?Q?Z2JK6aKeWqhSpOVPJ1AYNO5etKax3J3GIBOBO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f34a48-8da6-4ced-09da-08df4ac5c02b
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 07:28:50.4125 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JbZOcxg+eDbUFCuuGWSPVHygMrxQeIY5tjouAyq3RiXytawstvKoR6FzNuh9WwsyzlyNIKJ7Zbnd3Wvull66QyCS9pU0+TQjzSt7HuJe81I3vt6uGe+erf3kZg1vc1xq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 09:21:37 +0000 "Alice Guo (OSS)" <alice.guo@oss.nxp.com> wrote:

> 
> NXP Confidential

Update your mail client to remove this.

Regards
Peng

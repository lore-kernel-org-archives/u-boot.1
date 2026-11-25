Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CBC606A32A
	for <u-boot@archiver.kernel.org>; Wed, 25 Nov 2026 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=T2r6QiVg;
	dkim=pass (2048-bit key, unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256 header.s=selector2 header.b=g/xhGcgW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 611AE80E5E;
	Wed, 25 Nov 2026 16:50:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aloBlOKGsgyI; Wed, 25 Nov 2026 16:50:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9521680E36
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795625439;
	b=b1ELqdjZQyCz1PUrlaxZUD9JXHNOHkF0D73cN7l+20SPCp1sbe2WpyEVpZv8XNPiZ1B2
	 UJo7CtD0DmSThLBromDwzLwExK7+p+R6YPfl9ykqi/+jyztYyzrBmwf5t0HyD+qlpiDa3
	 eInt5aYQkfjO5NJUG+N5rsCVCPg9Ttlvn25vUK/7XoHhCGdc1Sk0R6VW+JVGcUezbJM5T
	 15i7i5Aikh9XYzQgFg0UIMEU36lEWStXYySA8+GKey4J56xtIc0j0CcXtsIruZifmTwqX
	 LwtkIV7BKjVe4kSke1iB94/Pql6WLh+Svp3QmKAiz2GycPiCd2JTFZz/1pJv+Nwdm4Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795625439;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
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
	bh=pUBnHYZwJ/dzsI+n3f9xx/7ZV9SOAa23BdmRcftsozc=;
	b=EBQn38Lf2awL0C2gXF3oJM63p4QJv5zrLd/gnLEM98tA8oXwzzisquN6VUS3u9v6I2dQ
	 kiP5Usa3D4qum84CGnwK9PcrBazlFQB/okAi9buTTxFxBfR00+WIVD17B47VP2G9vXIjQ
	 1y05RTZGgAdqL05pjNe4n3mfL4H4uCRh9RnsJiV8CNk4wEnxAEdSQU6gK86tNLhXfa6px
	 DLV+iTOkt8Vw9ay1tu4C1ecckDwjRu1r7auyrOC4he7LdZYwfZzORKC7Iewo2h9D0w7Jc
	 1aW2F0BztFvLzJwTlnc/O9K+xQoiDAqGa1qGuPJTDVWvcLcAt3gXQyNSCb5n1oAK+7g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795625439;
	bh=pUBnHYZwJ/dzsI+n3f9xx/7ZV9SOAa23BdmRcftsozc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=T2r6QiVgt6RyWTYbl6Fw3V+0WGaBolxbVYaMTQ6sPTwJvj7WxvrKfwNpcEPkCSIBN
	 R9ath0oPJcQNjnKcqvjZFkR+ZNsAiTpPcQMzcYuTriMQUAye+MuLJ5Uh1u7QaEMUNN
	 PwhSDouPu16VeynQo9gNUaJB0rgoNrck3Xbd/TVl+9rbP8rTdBui8Jjyt4/COAtg2g
	 lVQ/gOpXLhmGCPyYnb9w8rvqECRfQgHy+241cH9pJDEudcFgqUIS3BaJ9bgtpin2pz
	 rBg2RsazNQUAh3NVKSA170HK6HB7zy6w60cYAHu2JkAT+4rpBoA1e2xavpGVSrw4Ap
	 z2ZOfXQvPu2jA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9521680E36;
	Wed, 25 Nov 2026 16:50:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C7F241C9
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:50:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B8B43407FE
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:50:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dD8QwhwLebzN for <u-boot@lists.u-boot-project.org>;
 Wed, 25 Nov 2026 16:50:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CFDE24050C
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=b.hahn@phytec.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=phytec.de header.i=@phytec.de header.a=rsa-sha256
 header.s=selector2 header.b=g/xhGcgW
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CFDE24050C
 for <u-boot@lists.u-boot-project.org>; Wed, 25 Nov 2026 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUBnHYZwJ/dzsI+n3f9xx/7ZV9SOAa23BdmRcftsozc=;
 b=g/xhGcgWKQKU6LTpS/4wroz/eZJGtHbHxH10oZx+tuo2zaydOfhQnH2bTsOcLythk+EuHmQ2JEM8Mkk3VPbQGauYWjFl6RKinpvGBgxIZIA1SCqS8yZe+/f1nvH6PxXNscpNZh0ts7Cs3PdBgprqxkwSJum8tCX/v6KaQ1NuVytIvrtptMMQMaA2zH5NH1ByYzKfkiN1hy1uswaFNC7cFkKLNzUrVDyNibq2d4Eo1wR+CqV7nrQVTUhqLQOIozdCQ/RcbFDA26Xt9Cz+wLiVwfdOmqXpTXCrolsyflRs7/lKzkn5A6A4+Fg5SfGpCVLbKqwPvTShYRTtmyRAldRytg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:159::10)
 by AS8P195MB2096.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:56d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 16:50:28 +0000
Received: from VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894]) by VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 ([fe80::2f8:67bc:a785:6894%7]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:50:28 +0000
Message-ID: <413d5576-b844-4432-88dd-e86cf80db28b@phytec.de>
Date: Wed, 25 Nov 2026 17:50:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] configs: phycore-imx8mm: Add support for loading via
 UUU tool
To: Thorsten Schmelzer <t.schmelzer@phytec.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, upstream@lists.phytec.de,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Benedikt Spranger <b.spranger@linutronix.de>,
 INgo Rah <ingo.rah@linutronix.de>
References: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-0-dd6db9e5edfd@phytec.de>
 <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-2-dd6db9e5edfd@phytec.de>
Content-Language: en-US
From: Benjamin Hahn <B.Hahn@phytec.de>
In-Reply-To: <20261119-wip-t-schmelzer-phytec-de-usb-uuu-support-imx8mm-v1-2-dd6db9e5edfd@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::14) To VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:800:159::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P195MB0623:EE_|AS8P195MB2096:EE_
X-MS-Office365-Filtering-Correlation-Id: fc338168-afc1-404e-1d2a-08df4b143556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|1800799024|366016|18002099003|22082099003|56012099006|4143699003|11063799006|261009223027099003|261102123227099003|261021121427099003|261021123027099003|10067099003|261022115727099003|261022075727099003|261026121527099003|3023799007|6133799003;
X-Microsoft-Antispam-Message-Info: 2fdSeY38GHmp7lcygQOLbivc9ivwVWnU+NBX0Mo0Ln5NooqHi+nxaLKFyzkoWNgOR/j3XmbtsjixylfObyJ/YEgt6coxfp/t1aBO+X6/Oz0DNIq+xcZxQ59Xs2TdbepfxIwFOBjrafJbyBzlSlaylmq7ONxAR/TZwvauqhDuGcBEN5DQ685YManV+sOrOpSDkCIShbWZTmYm5whSfv19+vLi2FgEfa0el3vlNMpW5bdN+xHACM16r2s87d6cBeMKAY9JG/yh5MkIx2SlrmIpTR9qRJsmntbF1yLzUXvGhZkLN6/awclHtpASbMUA0HAtzrxSeoA/0kRTFOB4w1B3JqDshiiiWmqnNJGdF3nbNvd5RIGB0n/7h2QQQ3HTwP4bEbyC+Mc6YSRHsfUgUvV1cpllNaQQHAgXeYkkcb5A3cUb2KCUHsLuJDPTiLkHJB6OnFAT3XgJaY8mW8A61c3sKc9m8QhXEkgDpSQA8kH3bu5383Xo4YNtclfI/mej1PUcl//qPbos0lykXdBaLAFrECqnf9g/miK9YJG86BKnwwTmy25TuwMC4A/uJas20hp2HD2bH/06hCpV/OMC0nWYBmfAZmBTticZeqOIIiQFfdBpTABy9Cf5xOVVc+yRWYQn3rQSLtF3N0f/bNseg2rHY6X7TCfMykbaGtG+/blYxOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1P195MB0623.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(261009223027099003)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003)(261022115727099003)(261022075727099003)(261026121527099003)(3023799007)(6133799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjFqSkZXWTNQNXphQXZQVVVHWmZRSFk4UklZem85dW8vS1JCaFV2c2UrcCty?=
 =?utf-8?B?T3N5cExkeW1zd29wOXEyOVR3ZmxhMkVDTnpvVW5UcStTaXN5TTFYdFVTQUlZ?=
 =?utf-8?B?RWdhdlJHNG1kVGU3RWNSVWd5UHlQdkhNTXVsUFZuU2tBVGgzRTdJSm04WGs4?=
 =?utf-8?B?UGV2VTNPblB5L1dtd1AwQVJqWDFHTklkbWoxUXZyOW5LM0lScVErQ1p4UnFX?=
 =?utf-8?B?MEFtaXpQZll4T09mRWlUdlUvVk55OW42bGJhcTdNRmNZSlNXL254Y3V3eWhz?=
 =?utf-8?B?Z2RHQUMybXlYZWJzdlRncmlucUVHTmx2YXVwQ0hoNXFEY1RITWNSK2VNOU45?=
 =?utf-8?B?RHFRQmdmQ0x4Sng2YjFDNC95WVV4VEdiUGdnMFRXOE10RUx6cFJVTXlFanZT?=
 =?utf-8?B?cTBlR2tvM09TeEtQQjkvQ0xyVHVkby9namN2TnZCa2xBWEJGZmE2bVorYm5M?=
 =?utf-8?B?cmlmVTdoeUdHV21JNVBIWjBsTmc5UWhKUmkydUpaclBqUndkbVJIMXZlUkNp?=
 =?utf-8?B?UTNKWVRQUjRxdm5XZitnK3EwY203bEh2S0w5OXdPbDVrOHQ0K3RVWVJVMTla?=
 =?utf-8?B?RFRhaUV4Vm44NC9HKzREODdJMUhSNXpubWh4dFpvOHdpNkdJUnhSejJ5cmwy?=
 =?utf-8?B?eWFXQU96VU9aZCtSdGNmWlhmN29adEdVV1BPZWVlKzZsSE1LU2g5SzhKTFRV?=
 =?utf-8?B?SG5hWkR5SWdoWU1EVXN1TXM5aEtnbWx6bWgwOHVQcEJ2VUZqRzNjWUJocytQ?=
 =?utf-8?B?QWhDZW9sTDhPb1NiMWNUL3UvdkM3VUlmb1poQVlkRnBORmYzd3p2eU9PekYr?=
 =?utf-8?B?NThiZnNHeFJqeGZyWkVYdDBzMDRBMTVvSmpXK01PZHpmcjBHWDg0NUwydklT?=
 =?utf-8?B?SmtsbDBFNHVtaFhaUlpGVkltRGNJQnNqellqanlmYjVIcmlXeUg2eHhWaWpP?=
 =?utf-8?B?cWZZRWVJRTRwWmo4eW1SOFM5cEhhOTF3d0Qxc2VRVXZVcVFpMVJjbjFBc1Yz?=
 =?utf-8?B?RDFLYzlXd0lGdDJJS3N1SWxIZS9MdFJ2ZWlHSFF3WE5zZUpOd3hPd21GMGpm?=
 =?utf-8?B?Tnh3elFjR2dlcllueWVTTEtlNnFYSjQ2UHdFU2xBNjBuZlcvYUs5NkIxdHRq?=
 =?utf-8?B?eUc2TnY4bjR0MzdOaHpBMGlrYWdwbGZBbmRaUC9IUXEzV3ZUZURSWlRUVlk1?=
 =?utf-8?B?cEVDNGFtVmVDOWRqNFpaMGJaZDVNa1dHSTdwT3BNVU5mRDVXRW9GVHJJYXdv?=
 =?utf-8?B?aGhkMzErQzR6NUMvVkhOampuZndrUFlPTjhuUHh4RG5hVytXdWFjTXV6RkNF?=
 =?utf-8?B?ZSsrZG11Zjc2RGYvVFllSkM5ZUIyWkM3NFEvS2tSVk8yZ3BqRUdXZTJkWUo2?=
 =?utf-8?B?NmZBUmFkRWdoUEFHT29VRlJOWHNxeTVwdnp5WE5WSjhnVU84ZllFMHE3VVN4?=
 =?utf-8?B?ZVFtSmp1bEhoRmdCU3BNWDQyZE9lQzY5Uk5YSnBWMkNUVGpvZGtOS01FYmVs?=
 =?utf-8?B?bWlqZVZkMkVSM0p2NHpEQmpadnlpL3pKcndiVkhQM1FrT2NTTW1kR1ZtSkdo?=
 =?utf-8?B?MlczMnF5bElmNHBpaUdVcUFDWlJUMWZ2N2E3WFA3NFpPYm9NMDZIQWx5NU5R?=
 =?utf-8?B?RS9YdE01elZOUUxkZWtNeTA5dHF4cGRuTDhtcXdKcjhyZ2JCLzBZYXh2eEU2?=
 =?utf-8?B?bFRXQkFXZC83S0dRVUhJVTNyZk5uOWl1d1BzU3ptQUk4TjRhMnc4WWxpMXJt?=
 =?utf-8?B?NEcvNDVIZGovb3FxYmxIUDdBd3g1aXEyRG83NUJXMVlYWmtKUE9ESkhMUzBx?=
 =?utf-8?B?ZThMQmF5NGRRODVzZWRzTTJhUkRCVEJMTjQxZTR5UHpyWXVyeCtwZUROVkVJ?=
 =?utf-8?B?YW45eFhlV2xmWGduZkkzOC8xRGhiMmtualdJWDd3K0ZCbFhjK0VVb0RzeHRw?=
 =?utf-8?B?OVFndEhRL0ZJcHllSXgzbEs5aHl4a2RyUlZhbkFLeVJUVHd6cnRRVFF3aTI5?=
 =?utf-8?B?MkY3bjgydERrWml2aDhNa1JraWFZamtiemsxRUtUSmhvaU4xUkg5WnhmaWJx?=
 =?utf-8?B?OE9hSDE5YTJWeHpDQll6STllQzRDYnN4a2J1b3Z4NVd0cHdoMnNyYWJEOXJQ?=
 =?utf-8?B?d2ZFa3ZRT25xcEM2eTJKeTRtMmdpMWw5RzM4a2RLN1RnY1dkOEZiYzR0bEZQ?=
 =?utf-8?B?cGgzNkhmK0NsUk94bVdMRWdIZmVORXFGRml0RkdKc0JhSE1sd3V3VzRHS3d0?=
 =?utf-8?B?aGxvRWYzSVVPTTFUVWtTOXhna0wyV05HVDRhSGk2Z2tYdEFvNGR0bWV4LzFF?=
 =?utf-8?Q?Fb3lyKAEN32+XPeoAD?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fc338168-afc1-404e-1d2a-08df4b143556
X-MS-Exchange-CrossTenant-AuthSource: VI1P195MB0623.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:50:27.7450 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h339h1Enac8YWKKSl3NUgi2HVwz8mzO3p90uIsnly9FouJ0mLPRhDRWuxP5RwpTiYNyQcAdMdRZs5AQ6nuwhLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P195MB2096
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Am 19.11.26 um 15:12 schrieb Thorsten Schmelzer:
> Enable all options, which are required to load and run u-boot through
> the USB serial download mode and to do basic flash operations with the
> NXP UUU tool. This includes:
>
> - generic USB support for imx8mm
> - USB gadget support including gadget configuration
> - SDP protocol support
> - fastboot support including fastboot configuration
> - fastboot UUU support
>
> Signed-off-by: Thorsten Schmelzer <t.schmelzer@phytec.de>
Reviewed-by: Benjamin Hahn <B.Hahn@phytec.de>
> ---
>   configs/phycore-imx8mm_defconfig | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
> index 2be57246addd..7d4f6005dbaa 100644
> --- a/configs/phycore-imx8mm_defconfig
> +++ b/configs/phycore-imx8mm_defconfig
> @@ -29,6 +29,7 @@ CONFIG_SPL_HAVE_INIT_STACK=y
>   CONFIG_SPL=y
>   CONFIG_ENV_OFFSET_REDUND=0x3E0000
>   CONFIG_PCI=y
> +# CONFIG_ANDROID_BOOT_IMAGE is not set
>   CONFIG_FIT=y
>   CONFIG_FIT_EXTERNAL_OFFSET=0x3000
>   CONFIG_SPL_LOAD_FIT=y
> @@ -58,6 +59,7 @@ CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
>   CONFIG_SYS_EEPROM_SIZE=4096
>   CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
>   CONFIG_SYS_EEPROM_PAGE_WRITE_DELAY_MS=5
> +# CONFIG_CMD_BIND is not set
>   CONFIG_CMD_CLK=y
>   CONFIG_CMD_FUSE=y
>   CONFIG_CMD_GPIO=y
> @@ -65,6 +67,9 @@ CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_PCI=y
>   CONFIG_CMD_SF_TEST=y
> +CONFIG_CMD_USB=y
> +CONFIG_CMD_USB_SDP=y
> +CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_REGULATOR=y
>   CONFIG_CMD_EXT4_WRITE=y
> @@ -82,6 +87,17 @@ CONFIG_CLK_COMPOSITE_CCF=y
>   CONFIG_SPL_CLK_IMX8MM=y
>   CONFIG_CLK_IMX8MM=y
>   CONFIG_FSL_CAAM=y
> +CONFIG_USB_FUNCTION_FASTBOOT=y
> +CONFIG_FASTBOOT_BUF_ADDR=0x44200000
> +CONFIG_FASTBOOT_BUF_SIZE=0x13000000
> +CONFIG_FASTBOOT_FLASH=y
> +CONFIG_FASTBOOT_UUU_SUPPORT=y
> +CONFIG_FASTBOOT_FLASH_MMC_DEV=2
> +CONFIG_FASTBOOT_MMC_BOOT_SUPPORT=y
> +CONFIG_FASTBOOT_MMC_BOOT1_NAME="mmc2boot0"
> +CONFIG_FASTBOOT_MMC_BOOT2_NAME="mmc2boot1"
> +CONFIG_FASTBOOT_MMC_USER_SUPPORT=y
> +CONFIG_FASTBOOT_MMC_USER_NAME="mmc2"
>   CONFIG_MXC_GPIO=y
>   CONFIG_DM_I2C=y
>   CONFIG_I2C_EEPROM=y
> @@ -131,4 +147,16 @@ CONFIG_SYSRESET_PSCI=y
>   CONFIG_SYSRESET_WATCHDOG=y
>   CONFIG_TEE=y
>   CONFIG_OPTEE=y
> +CONFIG_USB=y
> +CONFIG_SPL_USB_HOST=y
> +CONFIG_USB_EHCI_HCD=y
> +CONFIG_MXC_USB_OTG_HACTIVE=y
> +CONFIG_USB_GADGET=y
> +CONFIG_SPL_USB_GADGET=y
> +CONFIG_USB_GADGET_MANUFACTURER="PHYTEC"
> +CONFIG_USB_GADGET_VENDOR_NUM=0x0525
> +CONFIG_USB_GADGET_PRODUCT_NUM=0xa4a5
> +CONFIG_CI_UDC=y
> +CONFIG_SDP_LOADADDR=0x40400000
> +CONFIG_SPL_USB_SDP_SUPPORT=y
>   CONFIG_IMX_WATCHDOG=y
>

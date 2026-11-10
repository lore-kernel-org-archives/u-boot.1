Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE212606A9A6
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=h1qEhpJq;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=UVwceeNa
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F9CD81321;
	Tue, 10 Nov 2026 14:25:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x-1YQPHOJ26Y; Tue, 10 Nov 2026 14:25:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D9C2E81327
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794320724;
	b=Kgs8hHQK6QyUDHWmaQFYpapu7ii7af1yQB2W73JQZL4PiKvh5uGDA6bqG9aV5eFlHBOW
	 VSb00/vnE6+ZMLSJOdAQFf9RPRPMPLtz/9oCbmPYSg2/kxjYwtQNYHg2SjgX3WspLScYk
	 wkH2b6AUg1ZDhGOFD3+ICT7i22Ii7JVrI7squcwlXGjrWju1tuNn72owSeZntVOxsL2mX
	 14e6IPK+92yk1EZa/SUd8tIjZX0dDLghVBbwLJFpsNBgJL1hBy1KuhOULpSOMqaMUPLYC
	 NLuxA9Pz6P9yivp3L+N8yQdP97Xd60F9BH27r0T0OGAkHD4TIj1+lcrDgDgWqbcRyVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794320724;
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
	bh=ioNupt2uEMhF1xTYwkjouwlD5+6Px3u753MnItW+S4w=;
	b=Dsuic+Q3+fyTA5dB1B0faXMu72TImEB16YNARFQBcOCfJQ+QW3/pCrA5/D/2S7NDF8Y8
	 lbFtuU/9YODjrqR1yE/V21HRP8qfeFtYxpnXLV/FtUo/hAtRjDJO6ClJbXAkOrvjIBwke
	 wlLJrBeo5+qhDOqJhjrAUY18sbtmBtOUmfXpyjBR4h+PSml++FbXTy6E3m88rpYIb1mgN
	 KxhCO5l6TuGLho1cbg6WP9n+WPLz2aDcafecqPD5J+w8ocrKK86fg6vLExwMprwg8xiF3
	 JlYdttD95dsH2QhL32zD0s/uR2vbXCy4i0NjdDke9t64Z4XYgRtsrFcOULUDNZomIYg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794320724;
	bh=ioNupt2uEMhF1xTYwkjouwlD5+6Px3u753MnItW+S4w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=h1qEhpJqQtuQQYT/md0B5vFPiyqEAYfF9zRLOGlpw7jYMJmxs24gJPfjMgk1Efgio
	 3lZiH4uxJLUUT58HLFVIcf4GA2vD93PDfC25ZIqJVftHece/ZRjhPYTlvmhNGOgOQX
	 WPUsJzvcY1dTA0xp3NIQh+w1WwDVWaUgzqS/QPEEdrasCliog8LXwf5jtngUSl8hJk
	 0sVZUGBT9AtN6AWDn+Lu6TxzMpIvRjOn9ayWBNtzwUDQ3JeMnm+GoKkx0c8coY1Xhb
	 qlSO2hGHnf3hbrg9YnFcd9Uef9mhe8v5/3q7LMChKTZn4g9GI6GEws8NIsXLdwN5LR
	 QpbFsmI3F0C6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D9C2E81327;
	Tue, 10 Nov 2026 14:25:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DAD0A388
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:25:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CB8E140897
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:25:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tuxsrsss9p1x for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 14:25:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 78C3240862
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=UVwceeNa
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 78C3240862
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioNupt2uEMhF1xTYwkjouwlD5+6Px3u753MnItW+S4w=;
 b=UVwceeNaLg9enr7ZNYxnfKvTqtnCvUi4pAHaDFO0wXPnf7xDM+pxX5+LQs8dvtAaOByd/8sZknp+M+FEZARx4N5fH8sV97kuHQV5KcvpAqRINX+w31M72g2HsHLJER6TtThjerkK9SHC563aStWH+JFCMk9ScYZ9QSnqcjoixoc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 14:25:15 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 14:25:14 +0000
Message-ID: <8b5a84d7-47ad-4c3b-90e7-74399d9d258c@cherry.de>
Date: Tue, 10 Nov 2026 15:25:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] dtoc: test: Fix coverage by adding test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-5-1c76e0b68f29@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261110-qcheck_fix-v2-5-1c76e0b68f29@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIVP296CA0126.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 739eaa28-f7a8-4000-5bc0-08df3f366fe1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|6133799003|10067099003|3023799007|4143699003|11063799006|261102123227099003|261022105027099003|261022115727099003|261026140227099003|261026121527099003|261022075727099003|261021121427099003|261009223027099003|56012099006|261028144727099003;
X-Microsoft-Antispam-Message-Info: 1G9Yoh3381OPRtCT+NCWsEc95wA7hng6osN6VcJrVTi7vmkYcB2lAvBOY9IOW8VV2PaI7UtteYebbjJthC4kkSI66GWACR+FcFWmlyRv/dLnmJ15UIZtLIWjLxYDK3cZgkDwxEWDHnzDQldE8QYxANCCacytsuYWHZNdGv91OXO2rpyLpdCHyBJmk3SJxvLoo6szcB2ZNcx66wO40PHQWBECGAb6/jgOLlGimQRCiXSKweBAwPmg9NgXIb3LH09q8THrk9WKlPeXTNe3D2OQkpCKQBTDEQvk82Jsxjrct/FjBeZkqUPIWpz209r/YU5aSHOlvCF/Dq2jXCZ+YzlG+LnK9qyG+XcgulmOL5PA004BboGC5Jy/7yyhkQrEn24D6TqfSHybnsLBQaNszh3YoukKPSUa72TqsWfkPSX6qKUQ9r4H/GUlpMYXZzFhptAcwx/g7KwTkYcZdTgPQuE1k1HJE6QYGDYjPoiUCMZ6Q26001baygkvxcymyVSeQadPr8z01d0MUxynYB/nTY44I4ukNBUzaUi5zr06/AvXPks1wlqHPDAi/6SITAJO4RbbxcEd49K02n6aQRq+V0SXOGsq1F54plVTOL/+pJnbpbF3C6plpLtTvSAZyG0tJTelb/aBM7ZU/1WbyG09/WqrWck4JsU0ISzwlZvblap6ynQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(4143699003)(11063799006)(261102123227099003)(261022105027099003)(261022115727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021121427099003)(261009223027099003)(56012099006)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUhESGVxTWZsRnRVUDd0TjlXSm0wc0tQKzZJc3lCQis2bExsV1VjVjBwVDQy?=
 =?utf-8?B?VUU3UjhnWjhsR0Rhbm1DSjlvbFhLcmFFVXEwNEdBU1IvUEFpQ080cCt4UjRm?=
 =?utf-8?B?ZkJxblFrOERYQlpwMDYwaTluZERrZFk2eHRGRkZLYitBMklWdFZqTnNFclBX?=
 =?utf-8?B?cko2SFlQajlhNGttdGZZbjZnaHUveHVxdFVmU2c3NGlLbzlPd2Z6QlhHQlpJ?=
 =?utf-8?B?cHZ5bVdVY0pzaXk2Z1gvb3NoYWxiNHI2MHVSNWtrQ21FcVdmbmwvcnZ2bUFl?=
 =?utf-8?B?dXAyNmM5Ym9VTnNab09IblFkc2VXdWQrOHQ5cTViR2VQRlYzeDZmZ213S1Nn?=
 =?utf-8?B?dWxpcC95MnB2aFEvVDFWSW5kMExwTDRxLzkxaTJxd2VUN1RPSTI2cEpoMEZI?=
 =?utf-8?B?VkpUZkc3NWZ3OFJjblZHUjh2M2hqL0dqOHNaRlJGUjhqSTNKRVVldU5RU2JD?=
 =?utf-8?B?ZS9WSHdlbkVWbEtrYjVaVUsyVDl0NFRmRnVnV1FEek9RcVFxbS8vcjVxLzFC?=
 =?utf-8?B?TTAxWVFJeDFNSWk1eDJCZnMwTmVWSkNsVFc3cmZ0S0czWitYWG1oR3BQV3VT?=
 =?utf-8?B?bG1ZWkp2YUFDV2FJNnN4TkYyNVdKZ3RxVTJ1NzhmL24wU2pxWWtkZVAzVkJN?=
 =?utf-8?B?NlB3MGw5TTg4QURXeWNoUkNSems2Ti9vbGtZOE5YaTgwTktvWHRvZTM5eTNY?=
 =?utf-8?B?TWtpNGJFQ0ZoRUx4Z0dtMWZiTk9PVDhtaktqNDNWZmtjQlFacHk4QnlwWGNr?=
 =?utf-8?B?cmZ4Rml2cExVY0JNd2tOSGR2TFhWY1FIQTFCOTd2WWczYkRnR0pRNHRMVU5r?=
 =?utf-8?B?bWIvUEVmcWd5RFJqNWc5RXgwZmZ3WE0vRXl4VkJLdXJBMmdqQitYMmRtSGtx?=
 =?utf-8?B?dnlkTUM2Q1VIN1Fva0NYMUloUUx5YTIwVmFwb3VPZDZ6ZkZlNVR2RkhkeDdQ?=
 =?utf-8?B?NUlKakpTNGlzcnNSRDV0WW5MQ2cvWXJZcUlQd29EcFpYK3FmVWxRYzUvRkpU?=
 =?utf-8?B?cXRmemhYMjhVQjk0UkhZZVY2VVRZcDk3OS9TMDdjSjk4cDcycWJlNUxwaDdm?=
 =?utf-8?B?RC93ZlIrTHNYckR4TmFyQ3FpdDE2YnJhTlI4eGNtUW00NFVheEw5Vmd2Y3Vw?=
 =?utf-8?B?b05DZzhZMVJrUjhlQ3FiYjFFeWZiSHhSRnByb3dYd0MzeFU5TnlBd0VzM2Ev?=
 =?utf-8?B?SEx3WEpFblI0dTFqY3FQVC9pU013dHBCRGM3alpyRU0zd2g3cFVtZTljQWhj?=
 =?utf-8?B?RG9tM2xON0JmSW5vUFFQUFc2ZTZ0YnVVZFY5VFNQejIvTkFmUmRFa2h3MFRW?=
 =?utf-8?B?UXhLbG4wOTNtcU1uaUZZWGU1U3FlQmJkY1FNOCtqa3VWMjk4Tk5IakFCQlQ1?=
 =?utf-8?B?UUpzL0FFUVNWejJld2VHempaM3FRdkhaSTZBOTZ6TGlkZTBSOWpGQWVhNzdV?=
 =?utf-8?B?REFqTXBGenFhNGtURWY1a0JldW9Tbm4zbTdzbVJacEhrSmE3WktGVll3MjhN?=
 =?utf-8?B?U0h4bXZsWnFNK2dpaWlMNWxlUjRZdlRMbk5ZUnBzQmlnUWRTeG1WcDNITHh5?=
 =?utf-8?B?Q2FtbUt3RUd1dkJEQmVkTDNyTFpYeTMrdjhqN3hhWFpBVkF2NExUaHZ3Q3Nr?=
 =?utf-8?B?ZlRMdnJ3Ui9EZVdsSnR5cHNrQ3ZaYjJCUHlZaHhkczl0RUdDZGZuejg1QTVz?=
 =?utf-8?B?Z0xpbFNkZU1tK0w0aW5scVFENzYvU0xmRDlqZ3pXRW8xWTIvSmIyalNTaUw4?=
 =?utf-8?B?TTRWNWhUN3kxNXhSRjBBdTUxb1V3T00vSWlsSHF1bW9qWE9UVGlDUjZsaVh6?=
 =?utf-8?B?WFk4bE10N3gweDVDaUZNVGFROGlIbmhvNEo0b3NnNUgxZEJ1c0k2bjZuNlV2?=
 =?utf-8?B?US9WU0tDdHBzc2xTVEJnWmtzRUNiN1duMDJYTGtjeUJJUENHS3E3Vlc5dm9s?=
 =?utf-8?B?SWQvTU1YK3Y0VXdYUUJCUGZQZVVoMnRiT2xyVVdOeXVjSzl6NXZMZ2dYSWd1?=
 =?utf-8?B?NnlkQlNPamt4Qm5BMzdJeXo5dWM5S3BpSzZyQ0tydTBqRzRJeFJzTWtuTWJl?=
 =?utf-8?B?TFh4OWtMZFVSRzRReVdFZGd6c09OVmtFQ0V4WENjL1NTUCt1L3lYaHZ4T21a?=
 =?utf-8?B?aEhXYmdSTEJpWFJJR0R1M0JSYVROQVRSQmdUVDhCdW5tb2w0V1hJZ0xVdENL?=
 =?utf-8?B?N0x4SnRkYUNuTzJTd3BiTytac3ZET2YySVFzMm1XcFRQSVN1UU81bkxMZ0pp?=
 =?utf-8?B?M1BKazhiNElpUWdaSllOakxhZ2dlK0oyc0ZlOXJwNkJyYmo1OVo3UldHN3R2?=
 =?utf-8?B?WE0yaVdDRzluUTdXd251RU5QaTM3MHhhNWJZdzU2WjhEZGQyTFEvZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 739eaa28-f7a8-4000-5bc0-08df3f366fe1
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 14:25:14.9150 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +nlZHDrdnf3pBjjxOhZW+aL1UT8Imd+Ogal57KelgWiUTtbyqTVb4JfNJyKetEbvrWDNtLIKyE3p0h4qkek06NLqkPCgUTBLXfcXvpdfGmo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
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

Hi Andrew,

On 11/10/26 1:24 PM, Andrew Goodbody wrote:
> Use of 'indir' in EnsureCompiled() was not being tested and resulted in
> less than 100% code coverage. Add a test and supporting files that
> depends on the use of 'indir' by placing an included file in a new
> directory. The dts file will fail to compile if the new directory is not
> added to the search path with the use of 'indir'.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   tools/dtoc/test/dtoc_test_include.dts                  | 13 +++++++++++++
>   tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi |  7 +++++++
>   tools/dtoc/test_fdt.py                                 |  7 +++++++
>   3 files changed, 27 insertions(+)
> 
> diff --git a/tools/dtoc/test/dtoc_test_include.dts b/tools/dtoc/test/dtoc_test_include.dts
> new file mode 100644
> index 00000000000..b5ef647c1b6
> --- /dev/null
> +++ b/tools/dtoc/test/dtoc_test_include.dts
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Test device tree file for dtoc
> + *
> + * Copyright 2017 Google, Inc
> + */
> +
> +/dts-v1/;
> +
> +/ {
> +};
> +
> +#include "dtoc_test_include_file.dtsi"

suggestion: move this line close to /dts-v1/

I was about to dig deep into fdt_util.EnsureCompiled() to see what kind 
of magic it does to automatically include a file because I had 
completely missed this line. In DTS, we usually have the #include follow 
the /dts-v1/; line, can you please move this up so it more closely matches?

> diff --git a/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi b/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi
> new file mode 100644
> index 00000000000..f975005d023
> --- /dev/null
> +++ b/tools/dtoc/test/newinclude/dtoc_test_include_file.dtsi
> @@ -0,0 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/ {
> +	new_node {
> +		intval = <2>;
> +	};
> +};
> diff --git a/tools/dtoc/test_fdt.py b/tools/dtoc/test_fdt.py
> index 66d346b1272..a63c860eae1 100755
> --- a/tools/dtoc/test_fdt.py
> +++ b/tools/dtoc/test_fdt.py
> @@ -1105,6 +1105,13 @@ class TestFdtUtil(unittest.TestCase):
>           finally:
>               tools.outdir = old_outdir
>   
> +    def test_ensure_compiled_indir(self):
> +        """Test providing directory as indir"""
> +        indir = os.path.dirname(find_dtb_file('dtoc_test_include.dts'))
> +        indir = os.path.join(indir, 'newinclude')
> +        dtb = fdt_util.EnsureCompiled(find_dtb_file('dtoc_test_include.dts'), indir=[indir])
> +        self.assertEqual(dtb, fdt_util.EnsureCompiled(dtb))
> +

question: do we want to check the content of the DTB?

Checking for the node that comes from the included file, to make sure 
the included directive actually works? At the same time, that would 
essentially mean checking cc+dtc works as expected, so maybe checking 
too much in the wrong place?

Looks ok to me:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A886606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 04:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rwPE6k00;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XX2Dy3vp
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CAC90606EA;
	Sat, 14 Nov 2026 04:36:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8Gn0KjvGFqiw; Sat, 14 Nov 2026 04:36:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D654360896
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794630988;
	b=i4g1VM0CLTnz8sXbKmVLoFSiQwaFHBVaJ2uD/i7HzvXndKmvahJIMCmHbM5uyyeLM5Oj
	 LYObgibjujVR9jcP8EJOnWo5Nrd6IDx13ri8UfhVTyXerLPqhSY7KDjTu15k+NIB2ynE4
	 sw4z8xNpSuqm6XtD3bdbIbb02FgeXkT4ZmDdsDQjeMtwlwaZtDJoo5MuO3rx/t+L1RrAq
	 VHB839MPT/a2bT/567rIuiYwu+ayC/GxP6IOxHEj88PfxAj+GaOgflESak1p3tre54lvB
	 Ub3pOYH055aOSjdDS1Ii1Z2WxgOAINNF/KyqnmVpgXH7HcYHc3/TcqAb83MOBaG1cMg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794630988;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Subject:Date:Message-Id:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
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
	bh=I7L9uTzXlqsUX8Tcfxmvc5odC7IQPQbStq+Jr3gnHig=;
	b=PbypX50dKsYCewiq5QRkZzfGhYYmEO6KzjNs4XBrvGn896+0TBXGwXv792tSviK21qm3
	 iGrCJj4M1av0h/7UVbodW9xZzrb0IZc1hxoeQIpc/kYNNiur2B+i30nzoMGbxktTOlZBL
	 xfHMYEdacYl33RAs//DJpgK8lAH6FYWCQ2Pb5pHQzEfl5OZuC/hb0zaLK/o1hdtY+V/ol
	 LXrkyRrF5yU3g0sNHkOvDIKIFFRInUF7+jSBKdDnx0z/6k2scrGJcwUb/fqgmKJiOBzqn
	 NFPfrmR6ydcZ/oBNFi+fxftSr6qpTlgHL7+E4VR+e3lKbFL5YYEZx+M3hG9jwzAG23w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794630988;
	bh=I7L9uTzXlqsUX8Tcfxmvc5odC7IQPQbStq+Jr3gnHig=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=rwPE6k00IY0TZHrAB1w85SkINNC8mQ7LrTTJNsGC7r02fEOrUz6+ERhKSqP+5avhx
	 DTa/pr7pJqYkqDICNkZABoSa2OGNIIkSALHnzyFyEb9DiWGANYli0cWtwXmdjBt+Df
	 tQtDYBlBQNgQr6jvf1704f2uv37ei1wlj3Wr3dN+TwQXIWekvDTV0zeE2Fo1stBZ+e
	 WqF/JtNC9meOGaSkn1Xa9HAc0oBSXBxn+JLk8ke08q051bPJopXW7+D31KUTjIICor
	 8PdiN9+Grurx1+IlEcdG91lBVATjsGHLb5zm9DI8Ik2BmGMcjuP0aghtBYqM1V/otG
	 sHdJQD7kz4pUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D654360896;
	Sat, 14 Nov 2026 04:36:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E69C1A6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0BEC40E89
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1UlVKN18oYjn for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 04:36:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6A74040EBA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=XX2Dy3vp
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6A74040EBA
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 04:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7L9uTzXlqsUX8Tcfxmvc5odC7IQPQbStq+Jr3gnHig=;
 b=XX2Dy3vpj7YPKX3Ow68D8aoYKH8gzgYBB8fohtCUyUI+xWT2NO2ynbmrnK+sVGLyk4sH0XpBn1ICOwrcokWF01o/1gBRPzOPoYATtBOVN/xR6wZ2F24uz2BMMUDmD/dY8di4nbTNndv+ZkZP4J+IaFVjMpD9nmOe3U6CDG6fj1w0/MYe1esQ7YRWAksLWBCMzQkiv3/OIxYeOEW6aYbFAXWer8XLPUe9vhhUhpOOxDsN+9ppbU8i+Gsuq1rDrRNO5oYGVHmxbB/xCKhmitk6Js51axM5bvwbk/M/7cfmu92Qd4bkqOIOvGQBvEH5Cb0skTpOwXIB6/wZyQ6glPnAIg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by PA1PR04MB11082.eurprd04.prod.outlook.com (2603:10a6:102:487::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Sat, 14 Nov
 2026 04:36:20 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0615.009; Sat, 14 Nov 2026
 04:36:19 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v2 0/3] Add i.MX91 9x9 QSB support
Date: Sat, 14 Nov 2026 12:41:15 +0800
Message-Id: <20261114-91qsb-v1-0-046293559467@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGvm92oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MjXUvDwuIk3WRDyzQDU+PERMtEcyWg2oKi1LTMCrA50UplRkqxELH
 i0qSs1OQSkAFKtbUAw8kNbW0AAAA=
X-Change-ID: 20261112-91qsb-c19f053aa9a7
To: u-boot@lists.u-boot-project.org, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?Krzysztof_Drobi=C5=84ski?= <krzysztof@kd-solutions.pl>, 
 Joy Zou <joy.zou@nxp.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Ye Li <ye.li@nxp.com>, Joseph Guo <qijian.guo@nxp.com>, 
 Johan Jonker <jbx6244@gmail.com>, Vincent Jardin <vjardin@free.fr>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|PA1PR04MB11082:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a0595e1-9c13-4b7c-f324-08df4208d41f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|366016|23010399003|18002099003|6133799003|261009223027099003|11063799006|56012099006|261026140227099003|261102123227099003|10067099003|261022115727099003|261021121427099003|261022105027099003|261028144727099003|261022075727099003|261026121527099003|41080700001;
X-Microsoft-Antispam-Message-Info: XztZY4WqqEbwatj7nOLFxAcEkyl20ZZcwaiZ4NXkuAzj6l7YjgV8WDR9ICtMK1jsEpIPS5YLeSMvBMyRHoUcoB+0dV9FgpeiGuJXhcgAlrIG8wCszOoXYO/Ryp4mWAHc59TQ9XrftCzGp48kbuRhMVvg8p8mCVsGn3zQa97vY9XEBZS1Af6BfGutrUomZgj1rYUPvw1MfSklKHdBxbABpDM7RDLzgpmHpyScY/mnHn7nIRuynTZ1G6smrwcB8A6yRea37SBR5an66SGJsAMt7fCekbqV61+d5trYYpLGq3pdlRr0agi3JiYumALRNHwTSJg+XZJv7dHVj6RGigUb+utOTnnlWzbuQ0gkDM/je4TETdbOTLxtZLKaTly5t+NW8n+asuKt1joH2Nj97pK30x9JQmfpu3PUoEvKtP+RCUx4Kw+xs3p9vIcwSIgN0P9gQxJe3NUQjbPbkSbsforPfXM+r2dXSxNTDuqWTGhpAFRpdcf+d9b46Xel1gaue2aZ8INvG9IiNPtPxufmxuV+Qt2Hlk8DZd3dNnnKO2rQ+wkCAItgHS6+fsJtdmHzF1rs12n0tC2/a0Uk7TkcsWthhOtTeljt17ttPyJ8+ambMXdgDmrIR5r4ZmpEikPDZYgwohF7bHe/lYn6mZxyvHAFQlJfmgkJQdyOXpu0foMuBMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(23010399003)(18002099003)(6133799003)(261009223027099003)(11063799006)(56012099006)(261026140227099003)(261102123227099003)(10067099003)(261022115727099003)(261021121427099003)(261022105027099003)(261028144727099003)(261022075727099003)(261026121527099003)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1uVWM5dHNPbytOTkRLVDJ6ZVhLNE9telc1ekM0bm50Q0hwQTNhTloxbU1O?=
 =?utf-8?B?cU5nQlJEd0JCQyt1Q05ubitLRWR4bk1TTkdRVkN1N3Q2ZlN0Y2tqRmU2ZXFT?=
 =?utf-8?B?SXZXb0Ewb0t6OTl3Smo3MVRWRTg5ZElJNDN0dnpTM3gyZkx3d28wVEhmTC8z?=
 =?utf-8?B?clcxQTZUMkhGTTduS1BRNG5FUHVqNXZXMUpqeEozSk01UFI5bTUwUHFZejEx?=
 =?utf-8?B?cHFjb3JBNVJFcGdWMFJQMW5tRTBrZGlTWHpqMllJUWZGMXZqbnF2emtjMmJq?=
 =?utf-8?B?Ty90VEZXdXp1MG9PZzkxbHVCUkJGN3Q1eUM1dXRDeHhFME9LUG1xd2d0WWMr?=
 =?utf-8?B?Y2VWVDFPbDVqMjFBQ0RtTHh6UFdJVktxdmRTcFU1QTE4Z1kwTzZXa3d6d1Bl?=
 =?utf-8?B?L05yZ3JQdWZTZlFKWUVMaW9rdjMwUzFuVU5HWDlWOWNWR0U3WWNhS1UxUVpE?=
 =?utf-8?B?a1EyaytyOEdYY2dKZkxaZEsyUUIyZUM4eTI0dHNQQzlaN2MzZnlhS0JXbzNI?=
 =?utf-8?B?THJQSkdXMVNuelUxazBhM3VmVmZBMm40OTBwbmtOTmFEVThtaGZrbkN1VXl6?=
 =?utf-8?B?SGtvN3NOM0UycDVLMytidVhZNTFVM3lQUTY4bFhrdXk3TE8ySmZDeitXczJ3?=
 =?utf-8?B?YVFha1AvcU9Fb2JGVVlUT2EzRGoxYW5Wb01jYm1NUFZxUzdSeWsvcjd4Si9k?=
 =?utf-8?B?K0VRVGc1ZTRQaXBGbDB3TUhseTc1d2s2SUhaeFB2QVVuaTdzRE9leTNPSXND?=
 =?utf-8?B?MkpOcDNXQUVPbi8vNnFSWTBFSC9aZ3M4ZEJIeGR2TkFUclZjTURaK29CdDZ4?=
 =?utf-8?B?MnJzTEkwTlVhTUVsakF5Tm01ZHZXSGZNOUJMb3N1bG1yRGwzRXVzc1didUFj?=
 =?utf-8?B?eFliT3BVZkUxK1ZFNCtucUxEaDI4QnpLUkNLZndwbjVPam8vVTJ1S2J3dU9n?=
 =?utf-8?B?MnRDRzV0c21xWm5JdWlKMHhwNjF4NTVSK25GQlBycjB6Si9adnZFNFNTUmtz?=
 =?utf-8?B?Zzg1V2N3M3RMWnMyT3FjVlJ5SHMrVlp4M3pyU3doSEVDeS9abEpOTkN1NkF1?=
 =?utf-8?B?Y0Q4NjlKU3Z6NHdNZnZCS012aG9SczhTVllnUUovZFplVmdyOGR2WmNoUzFK?=
 =?utf-8?B?bUtaN2FwZWo2a0RJVkF6VncwOVVvcjl4ODUwZWZCZHZhdkFkZmQrUStZMjly?=
 =?utf-8?B?NW03a05KTWpNWmdMQ0NTcTVvNlhCcWZpVDhTS0hwSDJId1Yvb05BN2RCSEI3?=
 =?utf-8?B?QU9zWWVvY2s1V1VMMFhYekFTc0FrWnVIeFl0QVduYzJ1YnhyZ2ZlZkxzTHFV?=
 =?utf-8?B?OUdBbUorZFgwbCtjNjBRc3RoWm1wNEl6VEdOSUV2VUVPbTY3Q3ZKNkxpd3Fl?=
 =?utf-8?B?K1o0K3JmRzhMUGpvVXR4ZXFyMC9zMkNtR2RoZWg2WE5BdEJLUkVRNmlSNHZz?=
 =?utf-8?B?bVV3N3VHWjlKZXJJcFBneC9aOWRWN1YvODlVQW1hd2U4VlptZGRpcGNSUEFj?=
 =?utf-8?B?RFZ2TGNOZm1SS2VTNlVURXhFaWRwZHZVanArTWlnSGJqUVdqa1h2UGVvcEE2?=
 =?utf-8?B?ZWVoL3RiNmNrOWwrOUpVVTR2Zm1JQzB2N0hnNVN1YlRocHlzWXMzeUlkWTlk?=
 =?utf-8?B?bDA0UmdOQURNanVSWVpwcVhMcG9HYVZNQnpVUnE0eFZGenVXWE9pM2tBS0E2?=
 =?utf-8?B?dzVXc24zanNyTXlBU3hxSGpIMm1WaG9BaHhNZm82M0pic0RDcVF2NHpqZFBm?=
 =?utf-8?B?bi9zcGdkQ0FRdGJIbkcvTkZ2UHo0aXBqYzNJdExYZUQ1R2x1MlhNbzIzR0xP?=
 =?utf-8?B?T3pBUFlNSmtKSVJ2YnlGdnRQUWxRTlVvbTM1M1dTNjZtNklFVTh5VW9PRE4w?=
 =?utf-8?B?dWZWSm05S1dnNkF6SmZpSFQ2K0t4UjlUYTJzblZZQVdyaDg5TUdHeG10bkJH?=
 =?utf-8?B?ZDdINUwrcGRtcGtJaHFnSjY4elhMaS9tbzBUTXp3MHh2OHhxUzZaUXpMU3BY?=
 =?utf-8?B?c0VLTDA1K2RoWExIZWVzdVFwV3p5N1hpbStac0w5SXk0ZmQ3cmt2VEtOdmwy?=
 =?utf-8?B?bXF2UUJjOXlhL2xDTUtrUytVZjZvTEVUL0srcGVUNnh0YTN0ZlNQMWU2Zlh6?=
 =?utf-8?B?SHNKc1pJNEt6VEYyVGFKaXlEdWtGK2RoYy9laXduYW43a2RaTTBSeFlsRS9Z?=
 =?utf-8?B?R2FGeUltL1d4UGNnajJybWNrbEp4NXVJMWpXb3BlOGlEbk50L3d3TC9UZ0Q3?=
 =?utf-8?B?RjRha2FkWlhoZnhYdlg5VDBEZHFIa0daUE9pVmdGemJwaWNRM2tBVkVpZTU0?=
 =?utf-8?B?ckVIUUhXYjRaeXphN1FVcmVUUmFNVEtaSWQ0NDdCRmFXcllKUjdHc1FiUnhT?=
 =?utf-8?Q?7fmk8N8xA8kk/6ybIxFdt9GMl1eO7xe/o3oSw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0595e1-9c13-4b7c-f324-08df4208d41f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2026 04:36:19.8582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oCFDCxzziw7BB05+g4TTWd+hg6trwU8mOo9PR1XXQHHWK+S76iUSDuOUSdw4Xg3YWAU5+f+II1qzNFqcNq7mfTiyjNKWpcOaRazuiSxaKFxd2IEWkGhCJuo+t8bEcJWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11082
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,T_SPF_PERMERROR,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds U-Boot support for the NXP i.MX91 9x9 Quick Start
Board (QSB), including board initialization, DDR timing data,
configurations with and without inline ECC, and build and boot
documentation.
 
The series first introduces common PF9453 voltage selector definitions
and a reset key timer mask. It then adds the U-Boot-specific device
tree and board support.
 
Changes in v2:
 - Replace board-level GPIO initialization with device tree GPIO hogs
   and enable CONFIG_GPIO_HOG.
 - Replace PMIC voltage magic numbers with named macros.
 - Correct voltage unit notation and clarify the LPDDR4 supply comment.
 - Fix the RESETKEY timer comment formatting.
 - Correct Trusted Firmware capitalization and flash offset wording.
 - Remove the unused linux/stringify.h include.
 - Remove the obsolete WDOG_BASE_ADDR definition.
 - Move common PF9453 definitions into a separate preparatory patch.

CI: https://github.com/u-boot/u-boot/pull/1078/checks

The required bootph properties for i.MX91 QSB DT have been posted
separately: https://lore.kernel.org/all/20261030145149.921308-1-alice.guo@oss.nxp.com/

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (1):
      power: pf9453: define configuration value macros

Joy Zou (2):
      arm: dts: imx91-9x9-qsb: add U-Boot specific dtsi
      board: imx91_qsb: add i.MX91 9x9 QSB support

 arch/arm/dts/imx91-9x9-qsb-u-boot.dtsi          |   72 +
 arch/arm/mach-imx/imx9/Kconfig                  |   10 +
 board/nxp/imx91_qsb/Kconfig                     |   12 +
 board/nxp/imx91_qsb/MAINTAINERS                 |    7 +
 board/nxp/imx91_qsb/Makefile                    |   16 +
 board/nxp/imx91_qsb/imx91_qsb.c                 |   50 +
 board/nxp/imx91_qsb/imx91_qsb.env               |   98 ++
 board/nxp/imx91_qsb/lpddr4_timing.c             | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/lpddr4_timing_1600mts.c     | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/lpddr4_timing_1600mts_ecc.c | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/lpddr4_timing_ecc.c         | 1998 +++++++++++++++++++++++
 board/nxp/imx91_qsb/spl.c                       |  140 ++
 configs/imx91_9x9_qsb_defconfig                 |  154 ++
 configs/imx91_9x9_qsb_inline_ecc_defconfig      |    3 +
 doc/board/nxp/imx91_9x9_qsb.rst                 |   69 +
 doc/board/nxp/index.rst                         |    1 +
 include/configs/imx91_qsb.h                     |   24 +
 include/power/pf9453.h                          |    8 +
 18 files changed, 8656 insertions(+)
---
base-commit: 3cb2cbbc75aa7fe2391f662607d6b2f46c1292a7
change-id: 20261112-91qsb-c19f053aa9a7

Best regards,
--  
Alice Guo <alice.guo@nxp.com>


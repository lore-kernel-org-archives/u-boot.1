Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E68606A335
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ereVRbCV;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=WH58syTx
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C208B40A9E;
	Thu, 12 Nov 2026 08:36:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id upGDcUv5xB94; Thu, 12 Nov 2026 08:36:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 08EAB40ACA
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794472619;
	b=dx7hxaKsgm/TMsVzzIpASm/iHmqVeVQKH2LVzpGYKuE5PDaKURsj1BPyH5fFpc3ZsB9m
	 cDDY+kHvczoEOvmyzsV4vVroq/cCpYxo9kXtZIn4L3ZXhVopewuWPvwbjdpMa6s4/7vH4
	 S88jHnwkcm9hXVbrPQoW69rTCVuvxi0KMKAI+OS4Mg3QVTDRx5gCqHFV5OhN/2vtMQdFE
	 6KatijHetQK8CztPTmST5JKsU+JTn18dzgLHrSQCkD1pmcYO4cSxU9gajhCD97w2C8eY+
	 dE9XQmzWXD+zT80P8aTvNZW8ES6hzb/kl45wY2Odafi/9SCSz4a34vot/6UgC1T/5iA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794472619;
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
	bh=IOpmUi9siH2qJOGErIsT1oF06BOFeuRYXer0uitk3ic=;
	b=ZUZjl7Dgk5q46YJUpicrtJJwtM2KmECVZ21gj8IaUMS+ZGHMaektL+8br1g4L0GCVAZO
	 p3mFlOs6v5njv6EYL4crd/9IqbIWcJeIUAOx3qrnszCdLRT6YIdYqHuhEWnhNoo2rxfHj
	 26MePOubu/80p1XJh62H0Vkn90XAUbwee+S22vGygI3tgmwwQJQdSU6Xt8gfPJ3uGWExY
	 zzqDz5oh6q6OV1uQ09AgSUUOAimR+O9D8xKkUTTAzMG6ashUnTrTQaOacbZvRhq5X76GL
	 KAqaL/cFbg6UwwklI7iENOTjdT3diy5TClKzUyKDFDQZ2HhHhmhrRjdyZKY955Fmeog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794472619;
	bh=IOpmUi9siH2qJOGErIsT1oF06BOFeuRYXer0uitk3ic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ereVRbCVpEo0AdTv5BLOzvM71HjaECZ/g3pDeXewUJjygVMTAbO6R3n2PCYAODgnb
	 atnkasqhKrfdNak3NTrEZi5VG8fVTqziBIr1YrJBHVU1nt0kUtDxS8zB2Axx86SwX9
	 YMGqOQ1qvq1YD7TP7EXdlUoye8b/YNGUQw5znP2JRTAv0XIDrCtnohBmLQr/fTOjYg
	 35OjmGpCacM6eQGLBtbWT5sUkHt7yt+FaANveqjtui+ZliIgkirVuO818LkdwTeY6K
	 DjXweLUl9Z9pdYrFtl5XM27w4dVEjdVbXAzUS/7zLZ/qOK+50OyeCJgLkoUjuCwG7i
	 8XC1m5Yz6QBiw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 08EAB40ACA;
	Thu, 12 Nov 2026 08:36:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4BA98335
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:36:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 311C98146E
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:36:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QVhpNyh4G2oK for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 08:36:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1864181429
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=WH58syTx
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1864181429
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOpmUi9siH2qJOGErIsT1oF06BOFeuRYXer0uitk3ic=;
 b=WH58syTxKFxPUpeXED3gtljEF5mT+Dp+5tnfScOH+PMnpZyeaHayQ0pt+raBYBDYGTAkgJy1v3OLIX3UNCG3ZozcOJjg2JeyJeJ5ijKX6XTkkQrapRRoROAhhbLSZmdD2GV51w6yXUUKb/MThwi1HBYwrsFASVfAAgBuyVG40J4Ac8YLBSyptQomzqZKcFuJjdB2v81OX28Rb9IgA38BJVgT9qz5uDUfISxOSSKbWEi98qA5p22fexHWAA84rzA8wMIalZOTN7B6mTTqUqmeWAW0hglQufOFWvuJ8hLGwA0eay3v1DPlckf8WsCbXK/Nx1dRpOMzF1zPx/wIn7tGhg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CO1PR03MB5874.namprd03.prod.outlook.com (2603:10b6:303:9c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Thu, 12 Nov
 2026 08:36:49 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 08:36:49 +0000
Message-ID: <dd34a0ec-4303-4d67-a4d3-a79b7d1c4722@altera.com>
Date: Thu, 12 Nov 2026 14:06:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] cmd: mmc: Add mmc_set_part_conf() parameters
 sanity check
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20261112-upstream_partconf_fixes-v2-0-5eba1cf22b1a@foss.st.com>
 <20261112-upstream_partconf_fixes-v2-1-5eba1cf22b1a@foss.st.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261112-upstream_partconf_fixes-v2-1-5eba1cf22b1a@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0105.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CO1PR03MB5874:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3263f1-d65a-43d5-3645-08df409817bb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|366016|1800799024|261028144727099003|10067099003|11063799006|4143699003|56012099006|261026140227099003|261022113327099003|261026121527099003|261022115727099003|261021135927099003|261021130227099003|261021133027099003|261022075727099003|261026135527099003|261021121427099003|261026130827099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nQILEaK+/QUaWVYeXHwkTvcVta58TI1nQPsCO1JRkaqDJ9/uxn/AEGLwqmLAAb7EHl2/yCOyHpgh7zMz/4G1LQPIVuQReQmsUHoOehAPnTmXRlBsolI3rWHh4K6q2ev8PnnhhjP+BX0hchn3nzkHp+xA6YrEMd8l6Y7uk9PBsAgDivSfa4SZh71lUlId4/K8wqaoaeJIEEg/i7INaKHuD5ivAhtXNCK+9+9bXsVh7xmT9UWtKN/fdmBb1Qd+T6Z+3vzQoxjhDX7ikVKtdha6YwrKZ9n3SbCCDONH0DIZC8lwD04+ikgf7nfwtqkKv54kpT7C1dO2ZWbwdCc6wi7gXAAL1qubaGQssbECsbQcCmEP8e7Mh1FoKRv/ncGlY85dQ5c4QMzpi/QPCsotDldTS/hTLNj/HFxAkfJx/ZLiS221E//ojD0e5+jAp2xVPXEMyUzUzaCZ6FiVfKG4Ugpig+JlKL2ADjy98iKHwFCdmnSkGPJRNTYakdo4EF7r1Fl7U8A3jhDAumWVgNJ8NVD3VsA3oQvzWykxRjk877am/cqB06diBPp180n48NwV0ZAlfgXmgwwJM8vEo4VvuWP7QirdQjTHUiVVXyv8n0L9Tr8YuKvNNieUHTWWMhDwyuzzwyFzrxR6lT0vBDuHaGujXRBWYdds6D58WqyosxKdtyQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(261028144727099003)(10067099003)(11063799006)(4143699003)(56012099006)(261026140227099003)(261022113327099003)(261026121527099003)(261022115727099003)(261021135927099003)(261021130227099003)(261021133027099003)(261022075727099003)(261026135527099003)(261021121427099003)(261026130827099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNlWjBpTnhhREZmeTNLMkVwZU5SKzBhTkhyWWZCNm0rSnFSTS9LeTJ0dE1I?=
 =?utf-8?B?djhhK2Q5aDNwcTNDL3BlUWJoTnJaN09RZklDQ3NSN1VEVmcwd3U4RTlQWXJP?=
 =?utf-8?B?VnF6d3FSeGpWalB1VkF2SEpERjFVYjdpeFdMa1ZWNWcxZThrek4ybEQzZmR1?=
 =?utf-8?B?OGZTL2tud1ZUVlFsZkROdVgrNDZ0RXY0TGNYZEl1dXd4V05DS3FqSy9KQ2Fx?=
 =?utf-8?B?elJnSTJUQkpTQTdkUEVhWHVaVE56czViQklEZVNaNjdIRWJ4WlpHOHJTcFRi?=
 =?utf-8?B?SVYxRFJZRHc0dmZVUGVrOUlnSE8xeU5LTHJoeW9IOGxkYXpURUhnQ09mV3l2?=
 =?utf-8?B?VktuT293T0R0amdPdWMraXh1MHk4MWtqYXpGZEhMUEowZVlwTXhvUzlRUHBI?=
 =?utf-8?B?OFRLR0U1b2gxbUJrc0RhaW9RMjdCdU8zdFYreUQ4bTN2U2hqZW52WXZmMlUy?=
 =?utf-8?B?MEZsTHBtaUV5QVBYTVVFdGIzcjNkVFZDTEZ2V0l0U2RzZUd0aHVWSjhDcDRx?=
 =?utf-8?B?Y3dlekZuWU5vWTd1b3p5bDdxVUxEblJhVmtKRUllcGdNRzU2dXZCVWhGTHg0?=
 =?utf-8?B?cUVXd3lIa2JrdllGUEptYW42SnhvcFJsNGVYYU5HQ1ZCK1ZJdXJXWTBuUTJY?=
 =?utf-8?B?cDBjMC85VnBXcWN2dmEzQURIbllXMkdoYkd1NFA1OE9ISXlPWmpkUStsVUxo?=
 =?utf-8?B?QUZIMThyYUk5T2FXV3FXTjVSTlh3WEM4QnJCT1Bjb0JWSDFoR3hrenE2ZkpZ?=
 =?utf-8?B?Sjl4MGgwMGladVVmNnpxZ3pxb1d2dWcxVlVSUGJ2K3YzSXBtTDQraERJWVFu?=
 =?utf-8?B?bWFRZUxKYlArQ2VOVGp5YzlJNXprQkROUXJYQkVaMVljTmxmOEJ4cFdneDlG?=
 =?utf-8?B?UUs0bnBOUUVwL2pMZWdwRm5JKzZhN2VVeHM0MkdlYU8xWTh3dEFZVXVPTUNl?=
 =?utf-8?B?OXF2MGZWT2RHdGkydDVtOFlHc3owTGNHcGIyUEtrUzNvbWI3VTZXS2NvZDhP?=
 =?utf-8?B?Y2ZMcTN1OC9oU0s4SUZmT1NIaVVEUm1OdzEwSU9FMklnTlhqN1VXQlg3Q3k3?=
 =?utf-8?B?VVNXdjdUV0V1dnFYWWhydjRibnkrazZyaDNia2xwZkF1dmIvQkowOEo3YVhG?=
 =?utf-8?B?endLakt5WHVqbUpSeVlsQXVmV0xCQ0RhUENVRlZJSzVnZXpXbmhPRXVvbkFV?=
 =?utf-8?B?OXltdHluK2JHWlNCZDZvaGlvdngwZC9FckNwSlVYZFlxU0d2azJWamRONGx6?=
 =?utf-8?B?TWJqRCtjcklJSTFsa0oxbmhZQTYrUVNTdFRsakJYZXFNL1JYNzI5NHR3czJl?=
 =?utf-8?B?RnJOMjlPcGdrOENwemR1WWNMcXFiNjE2aGJaVGUzajErNy9wVnBEVWpORHdF?=
 =?utf-8?B?b1E3cnRNdGR5cWd6QkQ5VzRvd0M2aWZCVmtaZ0ZpL1BtTDU2ZVNVbHhZM0FO?=
 =?utf-8?B?WFo4OU85ZTBTY0JmQXpOR05iYXV2YjUyakd0VStBSkdpMHY3N25jUUxlZEo2?=
 =?utf-8?B?aEhEM2xDbjJkd3hrV3N2STFlajNrdFRCZndxUEF5aWpCMXBuaXdKS1RTd1pI?=
 =?utf-8?B?UFhMbzlJVzYxYWt5L2NvZjdQMjl6NmdLR0UvTXU5K1FDM2R5SXpwUWc3c0p4?=
 =?utf-8?B?RWJ6diswT2lIUXBtSG52dXY0REZSOWpQR3MxSmhkb1liS0hlSUZ4VVduZ0t1?=
 =?utf-8?B?TmVmNzEvcUs0MTVVUnVkTHRRUVA1ZmlFNHhjYVhKR0FjQjl5cERmbGNUUjB5?=
 =?utf-8?B?OENBdThDbTVnY09TSS9iTkRxY0hpRUo0UDRFK0ROelFHZkNSdy9pNXloOFFE?=
 =?utf-8?B?TjdKZ1hFUno0aUttQU1ScW5WVDB5UjdWN3JpcmVVTUExWG9DNXhXbXdDa2V3?=
 =?utf-8?B?emR2TjEySEJsd282dGxOOXJ3emxET08vK2lJSUsyeFVzQXlZOFFSb2Rtbmoz?=
 =?utf-8?B?Z3A4NEZpZUw1QjZkSHZWaGlEVUhvNDM0TDBMWWlEKytZUkVjekpJamQ4WW9w?=
 =?utf-8?B?cWVEMFJSbFArNjZ0VGJRVUJ5Z0QzZVlxQjRCRkxnM1ROZ2xneFE5bG1uTVNI?=
 =?utf-8?B?UFRDVTcyTHpJR2JJZGZPc2lrRjZyUWRpaWo2d0FWVjYrVExLK3NmeWE5OG8z?=
 =?utf-8?B?ckR2MFpZd2xocEpsclFEUEEwRFJXZW51VE4yL3JRM0JjTTNmZE1XT3Vmcmhh?=
 =?utf-8?B?bU00M01taUsvc0xkZllEb05FbDlGZ285UmFEQ25FemVudy8wcmZBbUFrM05x?=
 =?utf-8?B?K3lUZTVkeUd2dGxiZ3VDdExEaDJtL0o3NkdYY0MzL1ZhbXl1Z1c0ZDBUNHRT?=
 =?utf-8?B?RWNaYks1NldSS01oRy9uSGpiUjdKVjZTZE9qZVVSa0k0OXhnMVlNa0Jld1lZ?=
 =?utf-8?Q?6G8LyaS2/4V0sQXA=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3263f1-d65a-43d5-3645-08df409817bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 08:36:48.9187 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZS+veGzD44y5/KI6KHDmEVyqHadjMU6OPX0J7TdZeVVj5RkDXNbi0rgN++9m5mXx0dqJj0di79GpaqryxeuL6nARjo6JYw6TGZ/B7eF4sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5874
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

Hi Patrice,

Thanks for incorporating the feedback.

On 12-11-2026 13:56, Patrice Chotard wrote:
> do_mmc_partconf() accepts numeric inputs without checking their
> bitfield ranges.
> Update ack, num and access type from u8 to ulong to avoid truncation
> before range value checks. For example, mmc partconf 1 0 0 257
> previously passed, last parameter became 1.
>
> Add sanity check before mmc_set_part_conf() call.
>
> Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/mmc.c     | 17 ++++++++++++++++-
>   include/mmc.h |  8 +++++---
>   2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 8bf3bf794ff..59cd9f9ea64 100644
> --- a/cmd/mmc.c
> +++ b/cmd/mmc.c
> @@ -989,7 +989,7 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
>   {
>   	int ret, dev;
>   	struct mmc *mmc;
> -	u8 ack, part_num, access;
> +	ulong ack, part_num, access;
>   
>   	if (argc != 2 && argc != 3 && argc != 5)
>   		return CMD_RET_USAGE;
> @@ -1029,6 +1029,21 @@ static int do_mmc_partconf(struct cmd_tbl *cmdtp, int flag,
>   		access = dectoul(argv[4], NULL);
>   	}
>   
> +	if (ack > BOOT_ACK_MASK) {
> +		printf("Invalid boot_ack value '%lu'\n", ack);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (part_num > BOOT_PART_MASK || !*emmc_boot_part_names[part_num]) {
> +		printf("Invalid boot_partition value '%lu'\n", part_num);
> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (access > PART_ACCESS_MASK) {
> +		printf("Invalid partition_access value '%lu'\n", access);
> +		return CMD_RET_FAILURE;
> +	}
> +
>   	/* acknowledge to be sent during boot operation */
>   	ret = mmc_set_part_conf(mmc, ack, part_num, access);
>   	if (ret != 0)
> diff --git a/include/mmc.h b/include/mmc.h
> index bf685a06a50..17edbe4742f 100644
> --- a/include/mmc.h
> +++ b/include/mmc.h
> @@ -297,9 +297,9 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
>   #define EXT_CSD_BOOT_PART_NUM(x)	(x << 3)
>   #define EXT_CSD_PARTITION_ACCESS(x)	(x << 0)
>   
> -#define EXT_CSD_EXTRACT_BOOT_ACK(x)		(((x) >> 6) & 0x1)
> -#define EXT_CSD_EXTRACT_BOOT_PART(x)		(((x) >> 3) & 0x7)
> -#define EXT_CSD_EXTRACT_PARTITION_ACCESS(x)	((x) & 0x7)
> +#define EXT_CSD_EXTRACT_BOOT_ACK(x)		(((x) >> 6) & BOOT_ACK_MASK)
> +#define EXT_CSD_EXTRACT_BOOT_PART(x)		(((x) >> 3) & BOOT_PART_MASK)
> +#define EXT_CSD_EXTRACT_PARTITION_ACCESS(x)	((x) & PART_ACCESS_MASK)
>   
>   #define EXT_CSD_BOOT_BUS_WIDTH_MODE(x)	(x << 3)
>   #define EXT_CSD_BOOT_BUS_WIDTH_RESET(x)	(x << 2)
> @@ -343,6 +343,8 @@ static inline bool mmc_is_tuning_cmd(uint cmdidx)
>   
>   #define MMCPART_NOAVAILABLE	(0xff)
>   #define PART_ACCESS_MASK	(0x7)
> +#define BOOT_PART_MASK		(0x7)
> +#define BOOT_ACK_MASK		(0x1)
>   #define PART_SUPPORT		(0x1)
>   #define ENHNCD_SUPPORT		(0x2)
>   #define PART_ENH_ATTRIB		(0x1f)
>

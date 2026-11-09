Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB79606A331
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 11:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LyYJJaOI;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=QVdSXvR5
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 337A560741;
	Mon,  9 Nov 2026 11:49:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 80hCIGrvKwfU; Mon,  9 Nov 2026 11:49:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 723E560710
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794224956;
	b=CJDWC3DZzh6t4OrM+U9F0jdceXFWXOgGCNmAOSH4DAGq0vHO8N+yqh56M2LV7XnRhtQM
	 kmluIkeSxAlWsbu9IUf0YVdvJMbl3aeakUz1PkElHMMpy/LHUz330uF4udszZoOsSvgob
	 cznepyHxAGID4hamUs1G9s+FZ+RueTCN9dlBicf23WQ1iSWItDLeEnDOPYU9AJXCslRDe
	 ocQSspjyGvCQEg/0DCvT8zr+UrIrY+24Y81U2nzkH6H9FgzZtcjVObaOnJKdHBgKEIr8G
	 3ImhBxUose5HUPYiTUJU8wYwP+ElZi2KbjnZRVPHQC/htqWMVpTXK8PxUB27I/2XI3w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794224956;
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
	bh=XfPVBO+NTtSq3lDkTxbjOTGC1DvQaH19JmU9jJ2pCb0=;
	b=mlYZSuYFi/ndxm4oOwZH8bKMi7uC1kprp1GQEcVtFngLk+RfUEtiEJqiyAiXXmcR9hWd
	 e0rGPzmkSWGGW4xH+jgvwWnahOVSTwl58Bd90HsNsRL3TQ10X/myqccHGipZoJE1n+fCz
	 4O2r0Ia1JWxe8sqEFIlNwWzOphkFKU60JJpAGXruAB6hLl3SDNgdr0qhw5Rmb3KWx2Aaq
	 x4+R8xheO5GZiT3KJMH3IVMtkjhfGCrtdW+XLW9Dk8ZivX6fl0yZBDkQ/YKDcLJwTEzby
	 PumxnZG86fH9RwgFIY8sW7wZlW1217jIzBjVAbguY5BRXEC1UIy7D6TGSjKAnyq/i7w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=QVdSXvR5;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794224956;
	bh=XfPVBO+NTtSq3lDkTxbjOTGC1DvQaH19JmU9jJ2pCb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LyYJJaOI8D/rFCAHvIuyQesqZo+hsxG7AWT/tib0bXn8hYBhyG3RT6kDgTJN4c2Ex
	 NWNKOArfbMikT8qLqQ/fpPJ6gfRemAmXPCrB1nsgwe0BW5JV0Q2FfO7d5NRFrqpyLt
	 x9rq9V6BVawggzCB6fi8G6Pe+wYVlEVJBrp0ygPWI4wO6xc991n1JEw3H0JNRtczI7
	 jKhFvJdl/n7pZOYmbIKhgyGlX4j4XphRdxwsBvasiIm1dyAAs/8tDBcRWWhJKoBq43
	 UeR94YzSMwdc1z+2Xap4lgtNpz+0dkb9yPjdDsZxoNwMxG6AXGQ3QqZZ6BLZ4TkBIm
	 txBxDpSnnECqg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 723E560710;
	Mon,  9 Nov 2026 11:49:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0423D4B8
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 11:49:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E9BD460710
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 11:49:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ckmt7bMIP8YR for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 11:49:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3877260703
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=QVdSXvR5
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3877260703
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 11:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfPVBO+NTtSq3lDkTxbjOTGC1DvQaH19JmU9jJ2pCb0=;
 b=QVdSXvR5pln9BGzTvvZw9/HUvJfYoQF952PFaFg6Sb7z+7Kz1Gy6o2ayLi8JrfOfB/R0TP5bhEeK4EVCW/trGCGXdjS1QfnEP/Vz5ZUPRwJ7Ydqa3mmAP0SQfOaeNb2J4gXoGW3MxtAooXHfkPEKjPIwORFZhSy3Z5coz4l7kWACbU+ZidLw+5O0GnAm7Te4rciSywfia19s0NXgUsYGMs33+Cj+qUTlMEwGDhPY8b2WoIA1yrDM7QZSx4vLqeoEFoCF6Bd7EKPkipWCztdvDMpK9W7J8SyVFhw7MzNI12HmMsl+lBimfR9mPOojB/TsnlKcxAgPYR+WThGd1FpT9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by BLAPR03MB5443.namprd03.prod.outlook.com (2603:10b6:208:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:49:08 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.011; Mon, 9 Nov 2026
 11:49:08 +0000
Message-ID: <bb7041c3-89ed-475b-92af-dc455bfeb789@altera.com>
Date: Mon, 9 Nov 2026 17:18:56 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cmd: mmc: Add mmc_set_part_conf() parameters sanity
 check
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
 <20261105-upstream_partconf_fixes-v1-1-6abda284aacf@foss.st.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261105-upstream_partconf_fixes-v1-1-6abda284aacf@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9a::9) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|BLAPR03MB5443:EE_
X-MS-Office365-Filtering-Correlation-Id: b60e3f27-5e5a-4afd-a875-08df3e577665
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|10067099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /dcZsm5Nvd/palg23VIO0LiS9N2qYb8DG3JQpcYxtU4wyepwCA80dX9oql4isZifMWPspEmZVumQWSKQOJi6KdPAnOltwUm38UQcecfaUI6sQSbJsz4uWdzLjoceDe5zYIADuNpLREq3DPZafzoy8+Wz5pB0ASFU+x0HCF+QityEMgzoeyc2sTaYKHoFFPxOCtki9A5mRUsXeJdF3dufLSYr0EPHoErRU588VlBu5roGeHdB9Iqtk4yIUa8c1HzyFXgOIVfxSHmUEdffoNFfDf9b+s6U2I3Jz8AEZTbh3t35GYpdj/TOHBDugESTuRZ+7zW38a077bQ7V+XztyU8WRKp9uWMbkVA77PFHxeD6HXkZ7M1JiQ2KfBlMH1H7auPRoS7kOtryt0OVWMEZXi+owIH7SpVS7v4mh3+J4yN+3AGjH6EkNXInAVHfZquMH39QxBpaHvX606mKyRkZIU0QouMw1h6pFypRFk58vXkcRK8eQKfMThZ4+8IY57VkTVkrl8OWjwOf5zwsCxQcItTEYQEGPY6LRDNZP0V8seEKMuO/7bqhdMYUpUhZkz45l/qVI/mCotW4A8PiOgaDB3ayPF7bUC7GrYymqP6ldqbaT4yM5BvNEGQfGctizqsbM0/VtHTIh1ucx7rryxuxy9sQcjQz1JS66hHgRhUeF7eRYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzI0WTYrUHlyR0JXbG9kQTNuZFVwVEQrWHVMcXQ0TzVYTmYzcitUd0FtT2di?=
 =?utf-8?B?bWsyV3hXNUUvdU5KNFEzWSs4MUQvalA2UkRDVnd2UDI2d3BLNmpCSFFjTVBm?=
 =?utf-8?B?SXRRUitsenBuWm5iS0ZacjNkZWk1ZlFoYkd4V2hSdWFVQURJUkNRa0dZZ3hy?=
 =?utf-8?B?T3hOL2Rsck5CUTZqSy96RFk4M1FGeUFYeUxDOXFTSTUySDBTOVd1QVl0cnNM?=
 =?utf-8?B?WlNtWWVPdzNCSXhDWTUvdFUrbmg5L2NoRUFXQkpWSVVMMXVxc1E0UU9zL2Q3?=
 =?utf-8?B?TllZaG5pR3RXREFrSDNVc1NFakNzQkI3ZytHMWUrMUJCeGk2ZDYyQ3N2YWlY?=
 =?utf-8?B?YUpOQm16K0RnOHQ2WHoyeDBiOEZHVWF6aU4raHgrVTN6U0Mzc1QzY2VtT0Jl?=
 =?utf-8?B?YU91TWtpVnN2Q2JGMWtwdGJmYU03aG4ybSt2L0lRUjNGVlNwSjNvc1ZrWmFT?=
 =?utf-8?B?TGdlb25WdThzM2UreUhOcC83b0FQNWp6NXZ3L280eHNGMFhyOHUzajFobXlw?=
 =?utf-8?B?L0JFOVI5QXY3bjc5a2oyazBjRldqKzVieUowQ1o1TlNjSDJwMkFxdzl3a0Zp?=
 =?utf-8?B?dmh4N2xUamJCU3lVYVlPcTZmOVQ2SGlVcUF4U1grUXE5TVBVd1c1Rk1wdjdv?=
 =?utf-8?B?ZW1rNFFyUXg3c2thVis5OFRQYS9ST1pENHV0dWpJMThKNi9kRmh2OVNHQzh3?=
 =?utf-8?B?N3N4aFdmYVBsdEt2N05SU29naEwySi9PaXNhUWM5UnFpMnFHbytDbzdpc0ww?=
 =?utf-8?B?S3FwS1FVbEhnSWQvWkFQcHRnQ1ZacjVtQmZ5Qm14K0JZSlVOSkpiQ3lWME9r?=
 =?utf-8?B?NEJhZVJCUGk3K2kzNWdmL1RWWW1tVU1oVnQ1M0hVM0ZNaGd6by9WRmZxREw0?=
 =?utf-8?B?c0Uxdit2Z2JFNHMrRmhoWkJKbDJ6Qms4aTNjQVdnRzAybWh4R0ZRSUk1ZldC?=
 =?utf-8?B?VmV3OGd2dTFHaG5KVDhaMW01ZkxIbEJodnFlaXlYRUJvOHlNbzB3c01XMzNQ?=
 =?utf-8?B?K3dlZlU1SXQwVldCNnNNbW12ODIwbXR5L1A5eE9IenlnUkZHNGhlcFl0VDlK?=
 =?utf-8?B?WEkwRUY2MUI5RkVJMU5HaVJndWN1NmowQXNOdGhyZ2RsMURRS0lQdVFyRWFM?=
 =?utf-8?B?RmU2b2FNOE1SaUFiYktVNmlFUGRHQ09RUk1yY1ovOUZDMmVKcm1MMXYrVUVV?=
 =?utf-8?B?d1RUaUVDTmlVZFpMV1lsTm1NaU13M3NPRldpRjA4dStGRTJxeFBjZUpJSUNr?=
 =?utf-8?B?MnJlTG9aaFN2SldBalZvZy9NTTdEc1o1bENobG1INXNHSEhtL1ZydVdRNy9E?=
 =?utf-8?B?Mlc3TFBJbmp5aWd0cG9UaElIc3R0U1c2MTJPVzN6VDhjNDMyYitTNi84TGpZ?=
 =?utf-8?B?SG9ZTkViZnFrTXVBd3hpUDJRNkYzd3pRWHpIU2xESnVKUkZCSXdJOXVaNGZn?=
 =?utf-8?B?UE9QSjh6QWZEYTNZVVFON21ybnFoMGo4OWQ2RFVuTm5wRS9YSHdjbjFFS3hZ?=
 =?utf-8?B?cmtFN2FVeGkzUEhPN0lINDQyYmNPQkpXd3JVZUt6dFlkZWRZdDBkS2ZkcGMr?=
 =?utf-8?B?ang4SW9MM00wV3lXZWs3U3ZZbDJpbUdiOTczeTJPRkxZWDVqeXlFMGJ3TWhv?=
 =?utf-8?B?TmdGa2VQOGNFOElnOEdtd1FmRS9ydzhJYVZkUVdXK3JiZEd2RG5LaVhvbnNC?=
 =?utf-8?B?dk5KUkkyNlQzOTZ2VUE5cXM4eFhpbityVFZnbkhObnBBbDdycWZUampDTUFW?=
 =?utf-8?B?dGVpNFgxSlRwSHNjOTRPck1QNmpJa1I0STJZUm1hdjVGcWR2cWNvUmJwNTdW?=
 =?utf-8?B?VWhPaWVwb2hPWlllV01zNlRYL3NPaDhJTkp5NkwyU2NLN3ZKUFJ4U21Wdncr?=
 =?utf-8?B?MGJDL2pnZDRXc1R2a0RvaEhEVVF6NktpT3FVbCtwekR3UGh1dzhROU9SaUdL?=
 =?utf-8?B?R3FubXBpdFoyamdUd0VBV3FZbXhaWTM5QzZVRjkzTCtwQndvaWdHWUI2dFE2?=
 =?utf-8?B?Nmw3K2NDM3JBQjJ4eEV1ellLcmFoOVNNdFNsQ2YvT0tjN1hxa0xZSXNXWENh?=
 =?utf-8?B?RDlST21QQ293K1FSczQzaVpKcnJBVEtPaHJPb0ZiRDhxUUFXRzZqbllHRjJU?=
 =?utf-8?B?OFhnWCsrZWlQZURZclgvR2haR3JEUmlmamRITXBCUFI4UURQckFwMTBuUVNz?=
 =?utf-8?B?QUpJUi9oNXpmVEpzeE9HT1hYdGp1OFlkdURNamE3S3hHUjBQSkRDYmZLcTRQ?=
 =?utf-8?B?WGZHYWxzT2M5Mm5LTUp4TEZMRERaZ3NSajJUSFVxZmtra08ydnhZR3l3Qzhh?=
 =?utf-8?B?RWNVRlB1MkdGZW1LZTRoeUo3WUdwTGtQbkJyZkVGVjBLMnVPb0VWRlllUHhT?=
 =?utf-8?Q?IBiwtwtnDlzqK9CU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b60e3f27-5e5a-4afd-a875-08df3e577665
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:49:08.0940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3YBMp34r1yvjYuYWJqQyVUthxARGvaI331wJWVJXIe5sabk6jY6AqniufATijcqPf3farr31UeS9jLbAMgXTNl7RKznGmMBfELc3kSeDps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5443
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 05-11-2026 14:33, Patrice Chotard wrote:
> do_mmc_partconf() accepts numeric inputs without checking their
> bitfield ranges.
> Update ack, num and access type from u8 to ulong to avoid truncation
> before range value checks. For example, mmc partconf 1 0 0 257
> previously passed, last parameter became 1.
>
> Add sanity check before mmc_set_part_conf() call.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   cmd/mmc.c     | 17 ++++++++++++++++-
>   include/mmc.h |  8 +++++---
>   2 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/cmd/mmc.c b/cmd/mmc.c
> index 8bf3bf794ff..173e3cc7140 100644
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
> +	if (access > PART_ACCESS_MASK) {
> +		log_err("Invalid partition_access value '%lu'\n", access);

Nit: This file reports errors with printf()/puts() everywhere else. Please
use printf() here for consistency.

> +		return CMD_RET_FAILURE;
> +	}
> +
> +	if (part_num > BOOT_PART_MASK) {
> +		log_err("Invalid boot_partition value '%lu'\n", part_num);
> +		return CMD_RET_FAILURE;
> +	}

part_num > BOOT_PART_MASK still accepts 3..6, which JEDEC reserves for
BOOT_PARTITION_ENABLE and the name table marks those entries "", so
better to reject them:
     if (part_num > BOOT_PART_MASK || !*emmc_boot_part_names[part_num])

> +
> +	if (ack > BOOT_ACK_MASK) {
> +		log_err("Invalid boot_ack value '%lu'\n", ack);
> +		return CMD_RET_FAILURE;
> +	}
> +

Nit: Check in argument order (ack, part_num, access). The first error
reported is the last bad argument.

Nevertheless:

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

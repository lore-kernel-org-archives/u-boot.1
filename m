Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0584D606A31C
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 19:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=o9l+uDPd;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=HmtSNr8j
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 612AC60774;
	Mon, 16 Nov 2026 19:04:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZpX_EC5GZoeZ; Mon, 16 Nov 2026 19:04:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8CE5B60601
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794855854;
	b=NHW1R0KjHUFzQMilhI87vTIMBGUNj0K/E8xwcfRWW8fbV6PSpbkLpjQG7oL4fqYmBLCm
	 IQhC7gsagSxUIiCyx6dnNi6+rgZNsvEVCnDbBv6C9t8Nnkaq9lS2zl9xzsdLg3KL0Y98I
	 YU0J9bObo/F5/sWQwjm3ubLeP79zEwCIeP+4IYtvIDX+ZFDuvSg3smOTL7X/QWpulmfLH
	 rAdEFZmjY1uMevbIrrjqgs8zrdg4kKAr9ZqPWJz1pQN1KrbsP6YK3YXYoeVTvmYbpWxVM
	 MMLSTJB0v9KAOPC4Kcu0e4pdR/ObUlDCv2AJWq2ibdqyNFfsVl/uhH38CJKAmBXTbEA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794855854;
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
	bh=tND0EpKdiIZT/ZKg9hkH1SRf9nu553DDZYPDe4v1Roc=;
	b=R9qr/vy+Sj3LkkCt9MNdasw78xkKsI8qZR2Xe8ciyCejhSdF6eFZsxmoYwLAACyJdfT6
	 jb0WaPB8YTRTHAuiHkX7ow4c/NrQl5wP2fz2UHnvZAsYrVpfaXhBOfWQR/croKQtfkIUM
	 qSaXuYzKX0jDsciZ68PIXryjwZRBBLp5Clgknq0teh3VcXcRukDy1+ffb1WMyFZzRnk4N
	 XzYfEMR4bctIsYLeWJFCpDGoEjBt7BHb1eu7gEN17tcqDlClrIWP0pQSf9sefk72Q9tnb
	 t88rLFrLnCBtg1qnOcz9JPkc2waOwwcCbkwexbHI2OmTKICMaKwvwc5hAB3ajgYy/pA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=HmtSNr8j;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794855854;
	bh=tND0EpKdiIZT/ZKg9hkH1SRf9nu553DDZYPDe4v1Roc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o9l+uDPd/qmlOJAtwiY8nkCFu27dRPA7l1WDWRxtmZXMiMm62ZRadV70Yzm0xt1xj
	 sU7iivd12vKotZpG4dST7Xyf+OL8fFh598o3LHu+aNbF5ZekS0z5mT+DT/1ikZdge8
	 iZ4VWm8YUa+eIUwXGq6lHrQxgy5EDio5qG9Gwk1AebKEqwppBFJcg4DE9dSC4v0lNb
	 xzMpc1P0b3nD2wrYh4tOC5d5khOriJww+RLjBiOpBG1xMHuTy2AFU1xsdbArs8A0vm
	 XnrcbYqOeCDikjDqLxLOAu5cs7ylV6V9yNebULFT2XTlX5kRB26iNR5tmXrrsCXRvo
	 gc0r6qBID3SyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8CE5B60601;
	Mon, 16 Nov 2026 19:04:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C40FD28C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 19:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4367060601
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 19:04:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o1009aPWA5bT for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 19:04:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D55F0605D6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=HmtSNr8j
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D55F0605D6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tND0EpKdiIZT/ZKg9hkH1SRf9nu553DDZYPDe4v1Roc=;
 b=HmtSNr8jGLSVH6agXzSsT4mRbjHHn2DqKVlyfvxDHYzllemNMKqbV9wXvYns+7dph5vxT2ZRHzaVUpPofj2GQOu0Tb13+GSNHiJQaO9X7WSNb+/Zu35FfVspxe5VxRbGx7NTyqYpOBvxpY0RkErOX+bcXpY39sgjItZ02gSjD5s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by BESPR04MB296854.eurprd04.prod.outlook.com (2603:10a6:b10:131::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 19:04:05 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 19:04:05 +0000
Message-ID: <483d923c-2675-4e61-a21f-af1e47951d54@cherry.de>
Date: Mon, 16 Nov 2026 20:04:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/8] disk: Add partition lookup by type GUID
 functionality
To: Tom Rini <trini@konsulko.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.u-boot-project.org, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, David Lechner <dlechner@baylibre.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Christian Marangi <ansuelsmth@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20260428-type-v4-0-b7051dc45a88@oss.qualcomm.com>
 <20260428-type-v4-1-b7051dc45a88@oss.qualcomm.com>
 <a5c42652-7346-4775-a13e-e9d74c393ee6@cherry.de>
 <20261116183151.GB554944@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116183151.GB554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0200.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::21) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|BESPR04MB296854:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b2342e-312a-4f7a-e63a-08df44146250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|11063799006|56012099006|4143699003|261026121527099003|261026140227099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: VRfIL0jcFh1eXcwDy8gjXMWM1bs0yPsFP7xs8607T+L8OoMjCuMgwz1n2rVm0VNzVy4PjWl6uaqSA0g9KwjRt6GEcbCcuRrGJN4mEpmpKOYbOQvXABVU6PbU0/27Cg10ZooZ4gs2x4eiAj5g/H3MHAwDCCORgmoqDUaL7J9i9QmGJju0URoaAQ48VPCX4UAR7dMmqQr0gUi4nIHHydHEwjk3Sp/Mn/OpiSVZ1zCprVNnBcK7AsMMOluBNmIHKoN2RHxA5DomQPU7aCQW7IwaCwgS0bivDQXyEE8uQHdCOu+531tXv21tXKGCMKdf3t0UHsZJ3xz9ce1PQmozBa2uMceqdxsW4Fxb9/AjeioRqFmQdaSJtdjGK3KKqTVQ1Wfs3rHXCiSQQgF0Sr3VOGQAqX5yYKv1gKpOILtMArlkyGhyDHL1K7HRRaqv0LlUr4hVwv/zXMpR/Z7oFCCYPTmR2UCIcm66JaOtL/ScpN8qaYxLDaP3LLZSXv2BzanCBPrpVs78nSH80p0wVC3VXmmLkL1FWKdgr3r6nbnf6plmsOe+2ip6KwFpkrOiIRGHlWihPRWutc32VkKudJSWjOVCRKgY5LRd5kfwrWiLsfKcBB6kztEy1jYGKOPXm3kSbaELxWWoDqY3cRnyS0aqijNK74AKAv+x26mXr5k/ciLPa8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(11063799006)(56012099006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpUUDdoOEZKU2h5TFlFMmRxZ2IyMlg5Z28rM3JabWdaT1ovTnpVd3BHQXVT?=
 =?utf-8?B?RlI5ZHdnekVyNElISk9FanVMa1RJenRnenMvZlhxSzA1SHU5TEN5SzFQSHJM?=
 =?utf-8?B?OWpMdFJzNk96Qy9GdUVRTml3Z1I5bUR1dEtPOTNLQytzZVNFRm5nNXRSL0ZK?=
 =?utf-8?B?Y3FSVTdGZ3RRU3ZhZkFVMFFkSHFUTmJ2dnROVTZZYVlXakhvRjVVUTE2S3I3?=
 =?utf-8?B?UDNXMStQcSs2dDVNSTJMc3ZYdVUwRm96VjU3dE1MN0NMMnJWYmo3Wkc5MmVs?=
 =?utf-8?B?MlJPWnZHVldMRUNSWXpBRUpUWDczMldoRzFybzBZMGI4d0RLUUNHWUpBNlRL?=
 =?utf-8?B?ci8wZ3JLamdJNlFNUVhwUVBLc0tWV04vbUVrWThtb3VnbUdPZTdFQ2N6bXNH?=
 =?utf-8?B?UnUwcVVUQlZOS0VmUnBPQk9FYzY3K2hBNUUxbE5wK2l4UTY3T3NQK0NqTStK?=
 =?utf-8?B?eUpSRVA4eU9jQ01UeER0WmxrSDhOQ25wWFdPTXZ1YStzRGNHRGtvQ3V1cnZy?=
 =?utf-8?B?blRpMTR2QjlPQS91cGJnNU41bG1QTlFRYTR1N2JaV0E3Y1JKTE15Qm1HQnU1?=
 =?utf-8?B?eGhZV3N4SzRHNDhSeDhDVFp1cklRcjV5SkhMUVVIWCtnOEZUUVB2SlFaSmI4?=
 =?utf-8?B?L3pDdG5SRXY4d2ZwbU90Rmh5VVdxV0FacncyaWw1NlJ3SUpCUXZmUWM4T2x3?=
 =?utf-8?B?QmE4R0hZL00yTnp1M05xejB1K1dnL0lETEY0OEdSMTMwRVVkb1c3dXcyTjhi?=
 =?utf-8?B?QzBOL0N0aE1HdFVaZmV1OXFWeCtlSktOV1JERDhhWitFU2xxT09qNHFMSmNz?=
 =?utf-8?B?MkhqaVlKSXg3eDQ1VnI3SVRJVVc4OS9TTDZQK25JZ2VKQ09oUmJTWGxDUW16?=
 =?utf-8?B?SnpleGhvRGRLZms2b2sraytSd1YydjRhV0RuOVAwcFB3eFIyczdwNGJBcmcv?=
 =?utf-8?B?ZHU3WHBFQzN6eW1udlZxV1dKSlJtdCtrT3RZdHExR0dVdWFyQVNuM1Z2eTds?=
 =?utf-8?B?amJWUkluS3dtYVo0TGIxWmdUOCtpZWhQZmp1ckMwL0lqSnF5YXd2Rzh3T2lH?=
 =?utf-8?B?YVdONGRIaU81R3F2SzNEMmpqazQ3TUZ4Vzc0OEtOTjNZUStvRm5ydW91MEh3?=
 =?utf-8?B?ZForTEE1dldFQ3JRWUFCRkg3d1BCTzZMdTM2eG10OE5lQ2V6czRnWGNWWlZF?=
 =?utf-8?B?ZmdxazZid05ZZFZKOUYrMUdCRTRpV3Z6Y2JpQVJiYmVYbm02Yzd4RkdTWTdv?=
 =?utf-8?B?U2hCeWRjSDlHS3M2NFJWY2RaWXhlWUgzb3QyWUNqek5KeHJGYXUyYkdhT3Ra?=
 =?utf-8?B?VFpBU1FmT1Q4RStyZnRhbzZFRFNIS3B3ZVpWc01kejNIR0lHSUhML1V5WnBv?=
 =?utf-8?B?VWFMME1nNmxJRDlKTXVVeTZQbHlzUHJMUG5rMGkvMDdPSW9sbmNORTRqKzlC?=
 =?utf-8?B?RHBvRzdJQ2p3ZGR3aUFzTmJmWDBjZGZQcmZzbkJmMzJRV3RHa0JGa1dsbkJZ?=
 =?utf-8?B?MTIwa1NwZnlMN1o5bmQ5RlAyck90NmoxQ2tqNnVxQVhwVXU0SU5SdTBjM2dp?=
 =?utf-8?B?OG9wWjZ6UVpqck9ROGdMSmdTSkdNNktJUXNwZUlVVVRRKzdhRmg2Rk9meVJ0?=
 =?utf-8?B?RjQrT0NkdnZGNSsvTXRhWDVWaEg1Z0lBYS90U3VBTVVUaGt4cFNKVnFPcGZN?=
 =?utf-8?B?eWlZYmpSdDJ3ZS9hVmJZblFnL0FsQkRxL0drZCtvSjl2R1lBbUZWZHVyb0RP?=
 =?utf-8?B?aEJ2akFnK3lhVTVQU3E0Q0prL0o4VkFoUEdTWW5lZTlaUHoxOVd4MTRkSHRu?=
 =?utf-8?B?NUlPbm9MendCclIyMlorWHJadUUyUlFUWmRrRS9uVU8rM2RnWmlrRTF2SzY3?=
 =?utf-8?B?T3hDcUlIN0MrR3l5ZmpyeGlRVGVIdXdTdXRRR0dhMW41d2prTnpodDhpOENm?=
 =?utf-8?B?aXMvWUpoZnpKTXp1YXc4ZmxDTHg0ekNsV3VhcnNkbnhUMzd6eVg4ckFZYTZk?=
 =?utf-8?B?VXY2ZTRSZVhPOGVKa0Y0OGJNeG1aTjBQQ1E1TXI5NTVNUjhPVm1lQjJ0dml4?=
 =?utf-8?B?akJBc3R1S0Q1V3M0R1UySXk2Yi9hdGFRNE9OY2doVkIrWisvZmVWL1Y5MmhS?=
 =?utf-8?B?OE5ndWpZdUlIZEttSUVoZzNYZGRYOUpYclc3K2JKN2s4MFNqVG1vcmQvUmo1?=
 =?utf-8?B?M0ZRcysvbVV4Q2huTG1pZ01VNWU5TktVa3A5Ums3a1B1T29lcEpIdDFwbitL?=
 =?utf-8?B?clQvSGIyVmlWQ0dlVU4xUFhFQ2l3cmR6VlV2c2hEMEhnMDE3eVJYeWdpczZD?=
 =?utf-8?B?WC9TMlpDRlAxZm53TmF6cHBQUStUNG1FWkd2ZldNckIrcW9EYWtIZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b2342e-312a-4f7a-e63a-08df44146250
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 19:04:05.0522 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U9eM6AyUEKKs8HAK25q2KDEosgqd6PExQYmdO4AnrkbYuP5AvzX2J71pQU6YRnbbpCU6Z04tDnHbsdZGTqunN9NNofuuw+vWSpUJZpt7kII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB296854
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

Hi Tom, Balaji,

On 11/16/26 7:31 PM, Tom Rini wrote:
> On Thu, May 07, 2026 at 03:42:14PM +0200, Quentin Schulz wrote:
>> Hi Balaji,
>>
>> On 4/28/26 9:31 AM, Balaji Selvanathan wrote:
>>> Introduce part_get_info_by_type_guid() function to enable partition
>>> lookup using partition type GUID. This complements the existing UUID
>>> lookup functionality and provides more flexible partition discovery
>>> mechanisms.
>>>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> ---
>>> Changes in v4:
>>> - No changes
>>>
>>> Changes in v3:
>>> - Addressed minor corrections in part_get_info_by_type_guid function
>>>
>>> Changes in v2:
>>> - No changes
>>> ---
>>> ---
>>>    disk/part.c    | 37 +++++++++++++++++++++++++++++++++++++
>>>    include/part.h | 21 +++++++++++++++++++++
>>>    2 files changed, 58 insertions(+)
>>>
>>> diff --git a/disk/part.c b/disk/part.c
>>> index 4923dc44593..4cb3204ac6e 100644
>>> --- a/disk/part.c
>>> +++ b/disk/part.c
>>> @@ -731,6 +731,43 @@ int part_get_info_by_uuid(struct blk_desc *desc, const char *uuid,
>>>    	return -ENOENT;
>>>    }
>>> +int part_get_info_by_type_guid(struct blk_desc *desc, const char *type_guid,
>>> +			       struct disk_partition *info)
>>> +{
>>> +	struct part_driver *part_drv;
>>> +	int ret;
>>> +	int i;
>>> +
>>> +	if (!CONFIG_IS_ENABLED(PARTITION_TYPE_GUID))
>>
>> We don't have an xPL symbols for PARTITION_TYPE_GUID so you need to use
>> IS_ENABLED(CONFIG_...) here otherwise it won't work in xPL stages.
>>
>> Or you need to add an xPL symbol for that (see PARTITION_UUIDS and
>> SPL_PARTITION_UUIDS).
> 
> Jumping back here as I see in v5 it was switched to IS_ENABLED(...). I
> believe the correct approach is CONFIG_IS_ENABLED(...) and introducing
> if needed, or just waiting for the need otherwise, the xPL variant. This
> is because I can see for size reasons xPL and full U-Boot not having the
> same environment notion (perhaps NOWHERE being set) and so we instead
> run in to the other type of compile problem here. Generally speaking
> using CONFIG_IS_ENABLED(FOO) and later adding the xPL symbols, for shared code,
> is better than IS_ENABLED(CONFIG_FOO) because we want/need that
> flexibility (there are counter examples, but they are the exception, ie
> we *must* be consistent from phase to phase or know what a previous
> phase has done/next will do).
> 

I keep getting confused by symbols that currently do not have an xPL 
variant as to whether that's on purpose (it should apply to all phases) 
or whether it should be gated by another (xPL) variant to apply to 
specific phases.

Here, the fact we only build disk/part.c in xPL if we have 
CONFIG_$(PHASE)_PARTITIONS=y means I was wrong and we should indeed use 
CONFIG_IS_ENABLED() as suggested by Tom. My apologies.

Cheers,
Quentin

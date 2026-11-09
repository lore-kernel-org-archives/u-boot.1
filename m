Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B23606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 12:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=UudFGX34;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=X9ke8SuY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3947560741;
	Mon,  9 Nov 2026 12:19:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WquXaiNFb2ST; Mon,  9 Nov 2026 12:19:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 79F3260710
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794226757;
	b=TC9edkW/nM5X5XOPlMD8tt2RkMh6zobtIXD2lrEUSDToeBIhmCDFxDinXASEjCoMycQt
	 AWw+RLbeDqFCxsQ0Fq3+PuJ8OM+nCaV0n8GNfedjj69qXgf+GfP4HiCb8wbCXhwGXyxvw
	 /CcbApRWAN9dvPaHPfq/LdM9asj0rFSO8APDU9snrVmHVrMW8+X9GO8Bs0ToVGIh2wzU6
	 kJdiQ65300L66L3SnCuhMA/fwZpBKifOR0C3Ge7X/kNCByVNrLaPKmZ/vGEmzkaVhjGDF
	 YF2/2tESOiMvN7Pkjge6nBMobLwQo8uOjDrUXfVVB2MhVZY+0eV7Wq4by5Gdwh3V9rQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794226757;
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
	bh=Ghj2aUok2dWJnsNqiG8xmhmJhiiOLTyKWo0UAXevQuo=;
	b=rsXSkYGi7hGCfy0VEj/kUOiG5cjW9Fxcr80P0G9S9rYrfkwyOerqrjEBn886X+k5pZsI
	 JjgxlMXAo8BeOX3tXGBZ+XCjKvjtXUn+2uf6aO81cAHXUKDsTzmYS9ZKxCgD0VhxAyeL7
	 IPii2063kau4bp62W6WpIyG+Jv8vqOs49RuTon26+n3WskiwjW4I3PfUiJEPWdkCLSGrn
	 OQPqzO+sfkvh7bx6phJ680YtC3h49ViYuQtxmE3QTXCmJF9pIp4rsnRVb6/GjNFhMsGzN
	 fiP1nCVh8+lg8IXNmETfJWLYbp3GnvQKAuCo6P7QrubNGUt03Hlnxg8Od/ydOP9gyOw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794226757;
	bh=Ghj2aUok2dWJnsNqiG8xmhmJhiiOLTyKWo0UAXevQuo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UudFGX34v0sAYKPufkHP54v2RLKN2HYxEJk6xFea3CCcEVgfztb5VPqvl6uh2fiTG
	 VsEiAcyh72DleEe6XbNY2n237Grt6kzi2+akfAUvzW7fCe1HvATwYvikbjs6f56nOg
	 BGjv6+u7CMgS7k2GBMXmIsZ17XmdBdTQLS7j5GRMqITTWJhiRaTF1kq2A7xAEt4FHC
	 RVhb+j6g340wmCsQ3hymXDMjD6veL6MRfwwJ0Tgu7qbgiulDWVhQnJWft/UPA6/QHJ
	 ORZWhArv80BjR9/MsIV0qv1PSnSmSqEas1Vso7i9au4kzOYSsbnXg8+HgenDsEMW0Y
	 2u0r5DHsfs14w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 79F3260710;
	Mon,  9 Nov 2026 12:19:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 327E23AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:19:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23EE680E9C
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6orLavTCu4VL for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 12:19:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1BE7580E31
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=X9ke8SuY
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1BE7580E31
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 12:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ghj2aUok2dWJnsNqiG8xmhmJhiiOLTyKWo0UAXevQuo=;
 b=X9ke8SuYlj16B85IvazBkO1ia67zpKciw9R9YbHXblZTOsA4sIAUIKRMQzwdirPlDUHaTxyuXQry0JN4nhT0qxgtnOB6ZoHbtubgMtlFv+1Hn1aJJhpdZnRF7VXTiCZwAzeF9lm6q64Cf5bpsOT22UomXWyh6tgxper6stg7kwi3SWwevBDZt6vw7BXMuvksmrCiILs3dHVpWxerTO3SBxWbP0wcGOSyUHME3s/kPJJSJcDU6wyO2Yitzr/PjoWR3iHD5s0RyNGpVfJPPayjWUviQHJnlyTcwc5Rm0rSDo+iFB7dRar72OwzULgUq2NYZRJc+1qxECPCqw+okB4+0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB6472.namprd03.prod.outlook.com (2603:10b6:a03:397::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:19:07 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0569.011; Mon, 9 Nov 2026
 12:19:07 +0000
Message-ID: <825179ce-4c25-41ee-bebf-db90bba27a5f@altera.com>
Date: Mon, 9 Nov 2026 17:48:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] mmc: export mmc_set_capacity()
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Markus Niebel
 <Markus.Niebel@ew.tq-group.com>, =?UTF-8?Q?Marek_Beh=C3=BAn?=
 <kabel@kernel.org>, Torsten Rupp <torsten.rupp@8tronix.de>,
 Eric Chung <eric.chung@riscstar.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20261105-upstream_partconf_fixes-v1-0-6abda284aacf@foss.st.com>
 <20261105-upstream_partconf_fixes-v1-2-6abda284aacf@foss.st.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261105-upstream_partconf_fixes-v1-2-6abda284aacf@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PEPF00000187.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::4d) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB6472:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e8ec8a4-136b-4238-9792-08df3e5ba6d4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|261021123027099003|261021121427099003|261022075727099003|261009223027099003|261026121527099003|261102130727099003|261102123227099003|10067099003|55112099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: HCWvb/lc61/twQdEsDbOiQ2TO1dgjYVzXUFNpZCxlpm06xor5qV4i6XvLxFiQffedEoZ0vcZXvXwM90HOlUYD+8RjsC/fajeN/oaDgzwIWfyMs03M/1z8jvJY9nWY8D5bQN4UKP6pdH5GRcJAgyvHR8bFMimN/bTzKl6wO6V2RL/pftu1gc8dVnAj7KW7u0h4ccoJ7ZeJQjzHp7dJGt3BRWHi3mmAIsTLVbTS6C74ZaMvW6JqGL9MJc3hGusxEWeespYRlV02d0/qY+Fix2ud1R5xFuNWsmWajii8B1TncFDGHzDXLYWX9ngRpODDyYVIZYPubqjOTaoPT1H4TfUwL5rVcbC8D2AdZXOcXWED6sylubAzjVUjKmfJZmnNHHS9dyTLSPrshgMPdWr8TYVVxKsxJw7q9pBgA3oNiXxjcDtwfKsUCP2YTh59gM9d6omjjF3XCEUHSXaIxGxCppRIcyrGNW6f5NOo6027uqSl0n33pts/2HTwX6hcbZmrn+BLQWLp/oEFKmvbgmt1a9UNKnm2egGE9pYFYq8KAucmO4hYcS+oVPlgQe49v96K7zSJqp4YTQbPwKr80u2XBajqFuK2CRehQkV8XnOWXlGi3+pLOK+XVmJDG6CYi8vdSnsUOyH0ycUTeA9Z+PuSZS84TKhOrdg6ByT4mEMNUIy2Ck=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(261026121527099003)(261102130727099003)(261102123227099003)(10067099003)(55112099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2NIbTB1M3hvNDE2Z1VnMGUrWld5N21aM05manY3L0szWW5EMFpFOHNJWnl0?=
 =?utf-8?B?SlZCM1ZrWGNpdGRJV0tEUnpYa28yNFZySDhhQjUxSUwrYnB1RjBvcjg0Sk5s?=
 =?utf-8?B?eEhvdGdjMnlybFlNcTc1bnRSSnZqQktBeGEvS3FXLzRDZkI4VGphOSt0SVl3?=
 =?utf-8?B?RURqTFFtQWpGQUttL0Iydk8xV2QrN25Fcm1OTkFkek1ibTVMZlVMUDFRZzFk?=
 =?utf-8?B?QUo0aENFQ0E4SXVickxKdkYxd05YSFc0WTZiNm9JNlpwMjVacmJ6NElwelRL?=
 =?utf-8?B?ZjRNUzFZMUhHNUs5MWM5RFVPd1JXdnNjbEpZLzFGa2tOOTM5RElQa1VyVTcy?=
 =?utf-8?B?UDByQ3M1RGVPT25zVFdlNkZyNTNiSXQ1RlZaOWF1ZG5tdTR5VVFVdllXR2RW?=
 =?utf-8?B?Wk9LYzBDZGg2WmkzZDBIUisrK1dxTVp1S0hxSVY5TGlXeUxpcG9VUjZwbjVp?=
 =?utf-8?B?ajhsbStKWEFxRkhWcVhtZGVUWnNFL0ZkS1MyWXR2RlBZL1p0Yll2VVFHZWR3?=
 =?utf-8?B?VndaOE9lWmpST3ZNYVIvellVeERuYVEyTjEzakxkZGdhRldLREVQSzZnQWd3?=
 =?utf-8?B?MHZsc2ZWd2xtVVhIOUI5OFgvZEU5dkE5Ulo2ZUc0MzFJMmpLbWtOc0VxRkQx?=
 =?utf-8?B?WHdUNXVMYjE3RkM4TXA3WEVVWE5lR0lXeUVmUkZneWp3bEtscU5SaUMrUGg0?=
 =?utf-8?B?YkU4cjE3K2dUMHNqLytwMlpXeWhLeVBOVXFjUzc0SEkvWUo2cjIwRVM2VllL?=
 =?utf-8?B?aEhaVTJPc3hlUzVOUzJEbml1czF5cDBFcUxWcmRqMUJZbEMzVmpNc2duUGpx?=
 =?utf-8?B?QlUwd3ZmWlF5ZlpuNGc4SFdrNFJ5L3dNeEcrTnEwYXJRNGc0SnZacjF5RHJh?=
 =?utf-8?B?eU9ia2pYbVVVRGpzbVY0clFkUk16dTlibzdYVkpRalNDSVloeUhRVWxSaU1V?=
 =?utf-8?B?Yklud1RKZVB5T3pMTUhkWlpvc1ZjdzRJYTExVHAxVW1WUDdyRDZFdUcxZTNo?=
 =?utf-8?B?a29VdUhsMTZ4QlV1bTZoSDV0blhjclF5bXo1TkFBV2FRTjdHM0RaSjBma09s?=
 =?utf-8?B?eFZEYVpuNlI2TjhMVFU2Zmt5YlFrM3dqUDg3alNkQkwxZHphOHZ0bGVvNk9s?=
 =?utf-8?B?TEVZZjd3UUVmY0gveUhSdUFFNW1HQkszQ0FrVmlwR1FHSnEza3VJZ211M0JM?=
 =?utf-8?B?anhtSkRuSDRNYXJwZFBHNHBBTDYwYW5CWE9FVjBQM2RES05OV0R3bTRRQjFa?=
 =?utf-8?B?blhjSnRWWVAvem56cjMvRFhudHArL3lPaytaS3JkdjFuQVVkelFhYXdYNjNw?=
 =?utf-8?B?Qjd5alVaN1JicTBkcGg4NkNmNEtWVjlSZjQvRFJGaDA0SCtLNTZWZ2pMYWxW?=
 =?utf-8?B?N1BYdnpNalgwT1RUb1RXK1ZXM1BEdFJFZ3BiMXB5a0RhWVkvVmZRSHFNeDk1?=
 =?utf-8?B?WW1TbW53YjNWeGNkTSt5OFVoSDRPWTFTYytjYVMxUjA2b1MzT3o0QUNlQmF0?=
 =?utf-8?B?L1lteC9FVFBuSExJdmxVZEs3V1FnSE9iWW1ZSWJwUlZFVUJXNndmZjlaekhE?=
 =?utf-8?B?c3BpdGZNZElvbXRtRHNKZ3daNGdxa0o5RDNrMUJMRkpzRlZhNVI4bGhmdXk5?=
 =?utf-8?B?dGh5WnBqT2NrYkxKUVpqM1IzRjlWMnlpVmYvU2tLY2J1dDJZVDVGUTJqaUlC?=
 =?utf-8?B?S0hzVjIvY29vd3lZbjVicFBYWnY1VU1RQ0tFYUNFdXd0VUhjYmxwVm96QytR?=
 =?utf-8?B?UmJPVWlsMjk3Nkk2anBFaWx4V2s0b2FQRXhFMDR2N2pQN3BGd0RkQ1orYnVT?=
 =?utf-8?B?N3p1Z3Y0NGFtU0VGMk1FZEhjcnZnV3pzVG9Lamg0dVh0ajA5RjJOU3gwQ3Zj?=
 =?utf-8?B?dmFaZTVWN1p5L1dMMy8rL0REWnJtUlZGTGNSaVdzbUgwWU9sb3VodjdZSVFG?=
 =?utf-8?B?QnV5SDJBRHdrb0ZnZG03UzRhT3FibXY3ZGJHbDYwTXZtdHVxaDlOSTJzcU84?=
 =?utf-8?B?am9TcUFYbmt6MXh3VFRMaGkvQ1hFUXI4bGduRHVMYXl5cVo5U1FJL3JCbThF?=
 =?utf-8?B?WVJLZDJwV1d4Q0xlTXF4WEZSREFqM2ppNUJnRlVkall1bFJwUEtiRndzUUpK?=
 =?utf-8?B?WGdIMHpIaUZOQm1ZZ2taWllsa1RjRkVhY1JOdVJqNEd6eE5XWnF2QTg1YThy?=
 =?utf-8?B?clYrcW5OeWY5L2I0RlBBVmRwdXdORVJWMW1jaHhlenZmbTh6a2FZMEdRN0Vl?=
 =?utf-8?B?QWxrMUxkVlFUWUZYdlJyZVRIQ2xsSjh2YkdMczJMUVVqZkY2ZDhScWlkM0tZ?=
 =?utf-8?B?V1RaUlM0Q2k4bVAvTGN5QkxzQUxvL3NUSVI4WFgxUlZSWG4yTkhsOGlmdExC?=
 =?utf-8?Q?0Gdu1kFemhh2qgDs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e8ec8a4-136b-4238-9792-08df3e5ba6d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:19:07.2928 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jQXPa8pqxVCxkhfMQIL+mzGZZWDdhW8LAHTA/RQ4e9F5CTSeALRPEKnLAbrdOZF78MUlAbPnZFO0OtMIVGENyXLAPTd6CvAJESBmHuZQgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6472
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
> From: Patrick Delaunay <patrick.delaunay@foss.st.com>
>
> Export the function mmc_set_capacity to be used after change of
> hardware partition manually requested by 'mmc partconf'.
>
> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   drivers/mmc/mmc.c         | 2 +-
>   drivers/mmc/mmc_private.h | 9 +++++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 4835ce0c64b..f9110c365fb 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -1096,7 +1096,7 @@ static int mmc_get_capabilities(struct mmc *mmc)
>   }
>   #endif
>   
> -static int mmc_set_capacity(struct mmc *mmc, int part_num)
> +int mmc_set_capacity(struct mmc *mmc, int part_num)
>   {
>   	switch (part_num) {
>   	case 0:
> diff --git a/drivers/mmc/mmc_private.h b/drivers/mmc/mmc_private.h
> index 24e68ceb5e6..a0d4dab9af9 100644
> --- a/drivers/mmc/mmc_private.h
> +++ b/drivers/mmc/mmc_private.h
> @@ -116,6 +116,15 @@ void mmc_list_init(void);
>    */
>   void mmc_list_add(struct mmc *mmc);
>   
> +/**
> + * mmc_set_capacity() - Update capacity for a new MMC hardware partition
> + *
> + * @mmc:	MMC device
> + * @part_num:	Hardware partition number
> + * @return 0 if OK, -ve on error

The neighbouring entries in the same header use Return:, refer
mmc_switch. The @return line is rendered as part of the @part_num
description and no Return section is produced.

> + */
> +int mmc_set_capacity(struct mmc *mmc, int part_num);
> +
>   /**
>    * mmc_switch_part() - Switch to a new MMC hardware partition
>    *
>

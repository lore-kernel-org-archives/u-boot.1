Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A067606A328
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 05:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yeU+kUE6;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=azsn/H6t
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CB05D606D3;
	Thu,  5 Nov 2026 05:42:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FH4-83lqDHaH; Thu,  5 Nov 2026 05:42:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DFD53606E1
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793857327;
	b=CHsN49mrLYB6omkZkPcJ9fXG8e5T2pQLVq0ZGxdpikxKiQ+9zhv/P7nVci3oXGouQy1/
	 6V/aIG3nRS7zYSt7VkN+40THiO7OvkN7uAa6sMRxMH5VdS+BmZ326vMickLzwfsmAMtAF
	 RpSeT0Sealax3HYOFMhL4bZrR1Wb8qTt0us9A8ahZmI0J0/0U9ETpSGDwtqaHrFDw0bhO
	 Nk8+mlqbjLJFDQ+7WoIWwLkewcmTfx1R8/mSUuCcRzUL9a9U+FAN+NtmnUjp8ZUzfKcfV
	 mF6a9J/sIV2DdEi2449xNcKToNMSDT8LYvgOqlwZ8zRnkhMVjQw9rE2KdfuQk2vVdCA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793857327;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=qwfRtE4x7oWtw6jV/cFrXjOiOQTAny3/4yhoUssB8cE=;
	b=b+1h9bjaO/OMAWK465thl02BlEZOE9S9v/Fh1trWanIolPKmpzu31IfYfzlgAc9g/pyZ
	 tmOt0ntLNYoJZzyhSsb4r2Kli5PBVepZTK4n1ZMf3rLpx3PbSe2I0haSC4ceNwTELnc7x
	 SHidVQbShud0pG+bWyb2vf7Fg7cH7JDNQiom3ivP5od92WipphrDPJJAYJd/CWTwQqeFh
	 PUIbSbFoqq6b7rvbiatnWVwMOWkp6grcaZ9pMCuXSP7m26mBCiMkVjGk/DJmAVMi7zVSQ
	 CrddqeH0TuuEj/Bnm/8qfm28IcgyK61gxfHLw1VPWOOmtgLhOFw2WU0Rj6/9bP5hB+Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="azsn/H6t";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793857327;
	bh=qwfRtE4x7oWtw6jV/cFrXjOiOQTAny3/4yhoUssB8cE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yeU+kUE65ul9g5rwIv5mALo+D0NXoiPACon0w1PkTuEN9E4eJcKIRxPy3axpLe943
	 4BIoyLQzEnlhSz0uBApK7CgUdOlMEA+Crg+IDgDvV39ojxp6ngs3Js/5frznB3UCfL
	 m5yzTsgVFrTTifRMgyWR8aZ5ki1hD0eUzebB1wd/+UsPzu8RWHQIl9FHiDOo78/JL/
	 jH5PuZPP65w+KGouxK0H1dC7vJBx0Aol7R8KKx7pycEvnDbjImEgitE8n7H1Nvktg6
	 UlHTL1BG7FaCAMdaVkXYDMWmZ6v4veI2U1ZdtCLvAs/lQqIKQO2JSSCLXEyNdo8hSg
	 CoEACbIUUMWKQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DFD53606E1;
	Thu,  5 Nov 2026 05:42:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D23CB31F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 03:25:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B7EAD606CB
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 03:25:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1yQi2ZR79_kZ for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 03:25:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D489C606E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=tze.yee.ng@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=azsn/H6t
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D489C606E8
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 03:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwfRtE4x7oWtw6jV/cFrXjOiOQTAny3/4yhoUssB8cE=;
 b=azsn/H6t3lJtkE5O9OOJbscQdIo70LDYGrNdKs8JQML0OMyvvSm4Z73Ffz5MTzIHvP18b6ffRXXiiIRBjnmkYriYRerai8ZI30iGPyNY5s8JmIW6DsYP9gcgRMpSiM+0Nb/9b7x+Gr0KgNgXbOsMJ2Ymuv5rK60DTw9CzNJXanwZqGr+CVUjj+/cq1wrj4GZ0OefOvFh72zVypgsYwYHs2Cg8tdVjUdI/FQvenO2TT+T6T7hge4uvadadQBiqVJmZq46SVijEX576uqqbs90WVDMIfnXcirfai6/n//dVVxi269nzNIAnnNlkMtsoaCf1T1qrt+8Jx30nuPAv7Ai4g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com (2603:10b6:a03:2d3::20)
 by DS0PR03MB7290.namprd03.prod.outlook.com (2603:10b6:8:12a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 03:25:48 +0000
Received: from SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01]) by SJ0PR03MB5950.namprd03.prod.outlook.com
 ([fe80::53a0:bf93:6b6b:de01%3]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 03:25:48 +0000
Message-ID: <caf40e0d-4d3f-4d08-9e42-4204258a866d@altera.com>
Date: Thu, 5 Nov 2026 11:25:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mmc: sdhci-cadence6: configure PHY control register
 per speed mode
To: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+socfpga@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, Chen Huei Lok <chen.huei.lok@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <cover.1787710268.git.tze.yee.ng@altera.com>
 <15e724cc7260e5f280ccced5b453b2978490df79.1787710268.git.tze.yee.ng@altera.com>
 <ec129b92-3fb2-4f1b-bc9d-2a901163fd76@altera.com>
 <c97dd7b2-4375-4352-86ab-8870a1dfea4d@altera.com>
 <081f83da-8d7c-4cdf-8c6c-151e0372a5a1@altera.com>
 <5a6c71d7-e7a2-488e-920d-0f1bce3a8d6c@altera.com>
 <b1c80ed0-7c02-4c83-ac31-4861dab64e9a@altera.com>
Content-Language: en-US
From: "NG, TZE YEE" <tze.yee.ng@altera.com>
In-Reply-To: <b1c80ed0-7c02-4c83-ac31-4861dab64e9a@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI3PR01CA0012.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::11) To SJ0PR03MB5950.namprd03.prod.outlook.com
 (2603:10b6:a03:2d3::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5950:EE_|DS0PR03MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c86866-de7d-4fae-f01d-08df3aec7be9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261026121527099003|261022075727099003|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|261022105027099003|10067099003|6133799003|55112099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: no0YbuVAvsB5GtKds5FOkSAKl36nHn+rFAj3VUiiB+05T2boapdd+lh52sxT9Ptw7h3jwrmjUJvPMS5qhbN5d9cJlLweyr/p+KjgrMEG22h3qHmFoDCjh5MBZyjAmpfl507xkioXJ5Xc2vkm4jDIREKjj2qPGH1NsmhWe6OixkbbGGv5kt79jYdk2K7NjApfDNEp2Tv5tVyxJ5u6183YPf+1/zwmRYuEbkjanTy9NCCbAyVtRrU5L7U2sxxIEzcf9s9FBI6aruut1amcS8EC1Xg3Vp6hEhXWl7Rt0FnDSwGkfi0jINLwObE2f9P2GEj2GmjLhiHpzn44FTNtQZKOzn/igHeb9K5O2RchzJM3PqWDiv82/gspGUYsc1mnxAHK3rx2kTF04k1HkUoTMY68V7rsLm95MhxW8Hkm6VyCdSMzNIoqhhmzuJ0UAiDU63vNL2R+ZVPmv3qOOlR8Ae95aAzBMcHYtFlesbFlpwmp9+8XZdMs6A8o17MsEMUrnUwblbnPm1y0nlDCFWqqcsiTAyurS/KOCKhGS6Jk6KHFs8r3NdOMSV9Yq3TyDKXQB89Y4vZDQxdhI8Sd6YBRdJvHRT6kV5FP+X++r/MHUpz9yKEDRQkHrAqqRDfBa+W6hnCMnKu3cTm972xJKnwEuBjnuLA+zEKNswktHuD+CA7LSt4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR03MB5950.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261026121527099003)(261022075727099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(261022105027099003)(10067099003)(6133799003)(55112099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHFWcWg3RzJVY0FDMnB4dzZ0WDBSRXdReFpNUU9pNWtUeWErdEIvSitPbFRw?=
 =?utf-8?B?cEU4M09jekRQL1dBdWhmRndVWnlLeEEwMU5zeXptcHgvT0Npbk9VaXlVaE9o?=
 =?utf-8?B?d2tBckFVWGdTR1YzWkd2UUlDcnRCN1hSTGJkRHhrTXoyYURPWWErb3d1YmFk?=
 =?utf-8?B?ZmsrMDg0VXY3U3NJbFFHZTFKRVhTTHV5Z2krMWRJb1hOVElVbjFNM1FsM1VQ?=
 =?utf-8?B?ZHZMUmFpYUNQaDFsODhGNFVsMGxITUYyWjQ0WDB0cmlheGdDRk14SndCbHNq?=
 =?utf-8?B?aWd3bWNacVNKaDJYSndPczhCdkJjZmF1eUhvV2ZFOFBuR0RsUC9MV3ZHeElN?=
 =?utf-8?B?ejlQTm1wZm16V2NaSzRxak1yaEVieVV1eHdxdkw1dlNBN3EvME9taExpNE9C?=
 =?utf-8?B?UWdVcU9nT25aRFA4ZTh5U3RYMTFpTndIUmt6NkVCMFM4aFU3aUVxQXdXa0pT?=
 =?utf-8?B?T1NBV2hHWUhVYTIxWTY5Rlg1cjQ3ZEN4UHd0RWRKU05QUVdWd1FOL21XUG12?=
 =?utf-8?B?M2RNRy82SXEzZ2F5MEI2UW1VN1h5alNtd016czltRDFkc2ZzeThkOWNWU3NQ?=
 =?utf-8?B?UE90aUZkSEtCYldPSWJlUEI3RER5anBkY2J0MmR6b05OWVFONmpFL1dDYVhy?=
 =?utf-8?B?ck9OQnhvWERiVkJiVlBKdnFlbGhrcnNQUURZZkQvODZiUUExT1NKZWR1bVFN?=
 =?utf-8?B?RWhrUzI5TWs1M0RYeE9Ra2pEVXhadCtVcitZNnhLNFdBQytBV3M0L0kyYkdR?=
 =?utf-8?B?Qk5RL1A2bVh3UE1rNzdDT2tVS3NvZyt4KzRWNkZnNWdDQ0NsUTJHeXB0SzM0?=
 =?utf-8?B?b0djb0VMamN6cnRycTB3UHhBMFc0elVuYjVaMjdzVC9ZcXBHdkgxVExuRDhk?=
 =?utf-8?B?eW9iR0ljeGlFcHRhWFZBc1FvL1hZb2MwbTIrLzBBb2RLYzk2VWpxeUlFZHRw?=
 =?utf-8?B?aEk5TE5zckc2NU82UndyOG1UQlBNamtwUnI2eG9FS25LeGNRNkhLb1dKR3NS?=
 =?utf-8?B?dkZQYUZoNHJjSEFhSXBEYnVmWGZTUmRtZG03eHdEdWJBQ05rdVZ5Q1VxVUZL?=
 =?utf-8?B?SjZEMkRrZGNBZE83Y2lzMGhWVVVrbmxWTkZud1hHY09RMlBFNlcvTmorcGpj?=
 =?utf-8?B?L3dwdC9RUUU1ZVlNb0RVWTJad1h5R3F5SzZteHVLVFdmdXRvWHAvZTc1TjVL?=
 =?utf-8?B?SFZhRmNISmU3M25oalppUVE4L3pSUGdCbGVZNGwxcExzOFVITmlDMTRrTVh6?=
 =?utf-8?B?UWVzZ3p6Q0tWNXZwMXJOVzV3ZHI3WGdtKzNIbjcxalFyMjNNK0N2WXljOWE0?=
 =?utf-8?B?VStGVE9iMWszejBCcVluWkFJZW1OOWlEalpUMzZDMytHQ3pxQnlDRmNuR2V2?=
 =?utf-8?B?Y0NIaTlrdFRuODdLdmdzL05tdWxaTWU0L2NXOGh6bmh5UlJJTkh5QjVKT2lj?=
 =?utf-8?B?ZW9MUHVCOFhDYTlKNGY1aGZTcjVYZm9admxkTFBhVE5TanVLL3FVN0VYZ1pL?=
 =?utf-8?B?K2Fuc1hYbHFuTkhFWVhzVWFCb2cxOEJSUDgwa0pvL3BwYUtvbVFIV2xmQ0tM?=
 =?utf-8?B?UGV3WFBzNitiTDVuV0xGb3E5NUd6MXdBWWVCeDFLaHI1Y2hlaG15NXRsNXY4?=
 =?utf-8?B?VFJyUmM0cHplOW03NXRGZEtFZmZGQTlNKzIzcjBzTkNDU2pUZ0tpTUo1MDNF?=
 =?utf-8?B?Q2JMQWFnWVJmZ3dqRlhNejJWRHdsd21PZHhseHlZbWpxdVhwSGMrdThzOWhW?=
 =?utf-8?B?cW92b0xrNnhQQ1RWVzEzb0RlWHF3dmRrOXJEMXpNTGtQMVl2T244WTlBUDRI?=
 =?utf-8?B?aEFiZmdLT3lMRTdKaXN6ekRpRzh0VjZqaUx0WURRMTFmWUJIOXk0V1pTc3ph?=
 =?utf-8?B?bGJEUEd3ZktvYXFaTzRjQXJGRG5DVEZtOHZuTVBFTzRWRW1WbTliOGZpdzBv?=
 =?utf-8?B?N2ZET0VUSTlTMlFLRy9mWEpBM1RvQXJSZlBjb1BETkJlR21ra0dVbUYyemEy?=
 =?utf-8?B?NkFaaS8rVkJOc1JjZGp4L2lwcW5pZXdvbEpXNk52anVxa1NFYnBvbmVJVE9N?=
 =?utf-8?B?cklIV1RBMXlJNkF1eGJPUmx3MVNpc2QwU2ZSd1hDUm00NzQ0S1ZhTXVRc1J2?=
 =?utf-8?B?NGR2MHVEMGpDb005MUE0YXZwRVhXd3N4YUhjRThXU1FBaFJHTUxkWitCbXZk?=
 =?utf-8?B?L1VVU29EM0cxNm1yUWR3QzFJam1tQkFEUDdzVEtpdUl1eFIwdXlBNXdMc2JU?=
 =?utf-8?B?ZnRSMDJSajB6WnRGUzd4aHNGZDh3cXhKOHFDMFRpTkQvZ21pSHBjUkNZYzN1?=
 =?utf-8?B?ZERNZExNQkJSSDVNTjljeno0TUw1MDE4YmcrUzVVZ0E5M3BLR1hLQT09?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c86866-de7d-4fae-f01d-08df3aec7be9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5950.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 03:25:48.0102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbuniJa96usxLXKXTbtPGzTqENob/xK4ZkOdssFpbLGOJpdpajYBdefHLeu73TRxm/znE7RIN2gXNBNv7lpTrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7290
X-Mailman-Approved-At: Thu, 05 Nov 2026 05:42:01 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tanmay,

Thanks for the review. You are right on all three points.

On 19/10/2026 3:52 am, Kathpalia, Tanmay wrote:
> Hi Tze,
> 
> Thanks for your patience. It took me a while to go through the Cadence
> PHY and host-controller documentation to brush up the register
> semantics before replying.
> 
> On 05-10-2026 13:36, NG, TZE YEE wrote:
>>
>>
>> On 4/10/2026 2:53 am, Kathpalia, Tanmay wrote:
>>>
>>> On 21-09-2026 09:20, NG, TZE YEE wrote:
>>>>
>>>>
>>>> On 13/9/2026 5:06 am, Kathpalia, Tanmay wrote:
>>>>> Hi Tze,
>>>>>
>>>>> On 26-08-2026 08:23, tze.yee.ng@altera.com wrote:
>>>>>> From: Tze Yee Ng <tze.yee.ng@altera.com>
>>>>>>
>>>>>> The PHY control register (0x2080) holds phony_dqs_timing (bits 
>>>>>> [9:4]),
>>>>>> which shifts the read-capture strobe relative to the data slices.
>>>>>>
>>>>>> Extend the per-mode PHY configuration arrays with a "cdns,phy-ctrl-*"
>>>>>> entry (default 0x41F0) and program register 0x2080 during PHY
>>>>>> adjustment. This lets each speed mode - and each board via device 
>>>>>> tree -
>>>>>> select an appropriate value.
>>>>>>
>>>>>> Signed-off-by: Tze Yee Ng <tze.yee.ng@altera.com>
>>>>>> ---
>>>>>
>>>>> The PHY_CTRL default needs to be corrected. All six tables also use 
>>>>> the
>>>>> same 0x41F0, so this is not actually per-mode.
>>>>>
>>>>> Please fix the defaults.
>>>>>
>>>>> Regards,
>>>>> Tanmay
>>>>
>>>> Hi Tanmay,
>>>>
>>>> 0x41F0 is the PHY_CTRL (0x2080) reset value from the PHY spec. The 
>>>> driver never wrote this register before, so the PHY already ran at 
>>>> 0x41F0 in every mode. Using it as the default in all six tables just 
>>>> preserves that (the write is a no-op unless overridden), while 
>>>> making the register tunable per mode/board via cdns,phy-ctrl-<mode> 
>>>> in DT, e.g. on Agilex5:
>>>>
>>>>   013b:    cdns,phy-ctrl-emmc-ddr = <0x4010>; (phony_dqs_timing = 1)
>>>>   modular: cdns,phy-ctrl-emmc-ddr = <0x4000>; (phony_dqs_timing = 0)
>>>>
>>>>
>>>> So the defaults match only because the reset value is mode-independent;
>>>> the real tuning lives in DT. You're right that six bare 0x41F0 
>>>> literals are misleading. For v3 I'll add a named constant 
>>>> (SDHCI_CDNS6_PHY_CTRL_REG_DEFAULT = 0x000041F0) for the default and 
>>>> reword the commit to say the register is made programmable with the 
>>>> reset value as default (no functional change), overridable per mode/ 
>>>> board via DT.
>>>>
>>>> Does that work for you, or did you expect distinct per-mode defaults? I
>>>> don't have validated per-mode values, that tuning is meant to live 
>>>> in DT.
>>>>
>>>>
>>>
>>> I expect mode-specific, validated defaults, consistent with the other
>>> PHY configuration values in each mode table.
>>> Please determine the appropriate default for each speed mode rather
>>> than using 0x41F0 universally. Board-specific DT values may still
>>> override those defaults where required.
>>
>> Hi Tanmay,
>>
>> For v3, I'll drop the universal 0x41F0 and the per-mode cdns,phy-ctrl 
>> table entirely. The PHY_CTRL reset value already works for the SD/eMMC
>> SDR and HS modes, so there are no per-mode defaults to validate there,
>> the driver simply leaves PHY_CTRL untouched in those modes.
>>
> 
> I think the per-mode programming should remain, with corrected and
> validated defaults. PHY_CTRL is not reset on each timing-mode
> transition, so leaving it untouched can carry the previous mode’s
> phony_dqs_timing into the next mode. Section 9.1 also requires
> programming this field during every speed-mode update.
> 

Agreed. v2 programs PHY_CTRL on every speed-mode update, not just for
DDR.

>> Only the DDR read path is sensitive to phony_dqs_timing, so the driver
>> programs it just for DDR50/DDR52 via a single mode-neutral property,
>> cdns,ddr-phony-dqs-timing (shared by SD DDR50 and eMMC DDR52). It
>> defaults to 0 (the neutral assertion timing) 
> 
> I do not see this supported by the PHY guide. It defines the value
> from extended_read_mode: zero when disabled, and RE# pulse width in
> PHY-clock cycles minus one when enabled. DDR50/DDR52 enable
> extended read, so zero is not documented as a neutral default.
> Please provide the documented RE# pulse width before selecting a
> default.
> 

You're right that 0 isn't documented. The documented rebar (RE#) pulse
width is 2 clk_phy cycles (Cadence SD/eMMC DFI spec, extended-clock 
DDR), so by the guide's formula phony_dqs_timing = rebar_width - 1 is 1 
in extended-read mode and 0 otherwise.

v2 will derives it from the per-mode EXTENDED_RD_MODE bit 
REBAR_PULSE_CYCLES = 2) instead of hardcoding; the value 1 matches our 
DDR50 hardware and the Linux change. Only DDR50/DDR52 actually observe 
it (the other modes sample on the loopback DQS path). This also fixes 
the current 0x41F0, which programs phony_dqs_timing = 0x1F (31) -- 
either the reset nor a documented value.

>> and a board whose DDR read
>> path needs tuning sets it explicitly: SoCDK, eMMC and 013B use 1, while
>> the modular SoM's longer SD path uses the default 0.
> 
> The guide does not define this field from PCB path length; board
> delay is handled by the IO timing parameters.


Agreed, I'll drop the path-length wording. With the derived default
every board gets phony_dqs_timing = 1 in extended-read DDR, so no board
needs a phony value for flight time, that is handled by read_dqs_delay
and the IO timing parameters. I'll keep cdns,ddr-phony-dqs-timing only
as an optional override for the exceptional case where a board's rebar
pulse genuinely differs from the design intent, not tied to trace length.

I will send v2 with these changes.

Thanks,
Tze Yee

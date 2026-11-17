Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E37D606A330
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=srq3HUKN;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ui0KhcBd
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1BDE66079A;
	Tue, 17 Nov 2026 18:35:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DR1GaJY7kw8J; Tue, 17 Nov 2026 18:35:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A52F608D2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794940529;
	b=WLGu/F/dpTJLEf8l0usvMOm7KwWBQeGQB2Kcl6IJ9Zs9Ox1Itn4RmAppeJCCP8T3GJAH
	 0ym5rwdHyrFNbNNSjLjso7TMgHWiFfz9x+7zxVagX+VeRzbEotwTw+3Ai0Isbun9COpEA
	 w/wBQ877XNpvPxqP5EMGR+YhPf09+7Zck5pBJ/5POsit1En0wEVHa5VqFS0jLmNQvpuaL
	 2Gs0Ikgw/E8Qmmqni3CJ3F0ZEQhDsP5F6iW0p75knnNr6AeQb/C0yvxoHJKoFCqq4yOC0
	 51Xn5fR5mN5Vr8VXR4ZCbyhzTCkN+/COzRTs+8ibpbXZmQJDBYTq0oZBNMInf07oBBQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794940529;
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
	bh=DICvCnEevMDzKWW8VXVLNQZe2/8SeCScJyZAjnSLtP0=;
	b=VVTS5oMWX3l/5pFDMb/mlz2u3vmjTcO9yuts+ydlQO+4tN5xozek2sjbNoxmsY+ctHUe
	 YxMEQf2XHQtlOOCICGzhQx8wicVo+BOTxktHhqmbkVBE3KA61ve+0e40RSCTFbXRWhGdS
	 dgDDr+fn8oCghtKVpx5kFD9Osd+JNdYA2EiK4vQA4Ta4yOd7rCDp5QcEyFA+JILr3EQc9
	 upREWSKpppziGii8Wnv+ny7EIevKw1a4kF8RAAkBHOakiGakYX7jRKdUHZmaZ+W4v8KTn
	 iJr2lVYSgwMiGkyKCwN6hsz7XjcaNFF+M542AM0EauBeUBGfEVtLY08ur2HE/gkrGPQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794940529;
	bh=DICvCnEevMDzKWW8VXVLNQZe2/8SeCScJyZAjnSLtP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=srq3HUKNfPfIc3CnfTqzMqJjBJlvunOBq7XqMy7/5H+tjuqnVbNY2/B33x7tA66X+
	 VctvN4e9RnL2H90jjLjY9PhK/39HaT748+YDm/TiRu1PghuwOEDKklyunzYn0x79Xy
	 sOsiY7mkVybONHV+nOScsGE/viwgkkqf76MoUqxok8gcgDUt/eMCsUuG9Er3fS55Oj
	 dsfsgEfONTvW3hhlvCDN+HsiXtHB5TCx5pqsIPmV0PUMTBAWVxW6Kml4AliRPfSjXQ
	 HUZ1u7Hh0aCgquLYdjPvnpmLQ1/RqtFcn3xpi2to07HTo8MhgHUmA4hQ9OcCdXmKZq
	 WmzKEBrK9IsMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A52F608D2;
	Tue, 17 Nov 2026 18:35:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 79F649F8
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:35:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5F7E580C26
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:35:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ssl2u5dFWQVZ for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 18:35:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1285780BF7
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::5;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ui0KhcBd
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1285780BF7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 18:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DICvCnEevMDzKWW8VXVLNQZe2/8SeCScJyZAjnSLtP0=;
 b=ui0KhcBd3Cv9jiRDpTrgToGd8bejVtVm1WKfKFBUYqY9vq7keCtA7jzL6CxxmyAziGip5d29TnRd3Ix9gB6AApQbiw65J6k/v90Sf1Kodn4fn3VzLUJzPe6lvBsxKpaIXS4PzPhYWnCPnMKEZZzNNqHXBByc9++Yx1heWV7C1MKLGeKrKw4pVh+xE8VIvApxD9220J+10nLu5Ye1VXeu0mLsBrMraIr+d86vJXQPAapXhdRyan+Q+RjrjLL1QSGCtBLWAY0OpB0s807cbcb3FHGKYOStuQlvwBtWaOICrPahBvho5vT2EsUpJF6CtIcm38cTEfGH8DfehGSuWdGv9A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by LV3PR03MB7684.namprd03.prod.outlook.com (2603:10b6:408:288::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 18:35:19 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0615.009; Tue, 17 Nov 2026
 18:35:19 +0000
Message-ID: <1b644ea5-0318-48fe-b80e-f1afe3890a38@altera.com>
Date: Wed, 18 Nov 2026 00:05:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: snps_sdhci: Add missing sentinel
To: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Tom Rini <trini@konsulko.com>, Maksim Kiselev <bigunclemax@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 u-boot@lists.u-boot-project.org, Terry Zhou <terryzhou05@gmail.com>
References: <20261117142747.219005-1-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20261117142747.219005-1-richard.genoud@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0111.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b3::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|LV3PR03MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ae36d28-3946-4503-3d7d-08df44d98836
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|261009223027099003|55112099003|56012099006|11063799006|261102123227099003|261021121427099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: vrjzEZACbTWyIwyfef9zbC6QwhJm3TD1GBVxZ7Bk3xrqz4k+eLnlq1d673TFWXCPBAa7rjdFjJwcFG5JFB+AWg8pttPSMcWd+M07vx8G/Ak45KVW112BXWKyDlu9KrmBjr79wEfVl5Wjx3y2OpElWgxu1K8decGQ+X0eiHl+N9CJ0gpHEUYV+i8u/t6s1blu28iI8vNFRM0xYW+VAlW69baT+KynJcCig9UcKTAHooa3qzZ5t9m8b5LtfAyQad1XYtDygX0WfzUQl855k5sNycoI3tHg6r96sKIQF+fvy8+CVsV4pqnZOfcS43aWckk+58RqR0x3M9gr1eoQGT1udYTEYh2dAWgcCDp7lZ+2CydjAhKPUIJ8dJhpxyRmHTJvhKSuP8PUWGdXzBMP+viXJIA2NNLdIXT/MDLvOwvZx7v9sszcoez+4cTYnXycp112/tUkXdYgs3SxwAypJPFcCwC6oRrMnfRvCdgkhrTyxRDaQkDzvUyiM8qigKO4b8d716zjBppADViYOeHWfrwjFTfHtmrjlqC+z6L2xYmWk8G3ANHtMrQWeSRRZ0r3aga91lWJi+O1Ayz4EdXB6ORkL0pbGsHTdI0VBknndjUwl3BJ1BbPuJCfb0oozwIRKl64U76ehWPjetOjxqECDsoWnPlxmoYUbg2LgZRAW8MIvek=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(261009223027099003)(55112099003)(56012099006)(11063799006)(261102123227099003)(261021121427099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUc0N2NXWjBONnljckNNeVlUSTdXQjlHMldmRFBUQmhTU1dsUk5yZ0VoeEdC?=
 =?utf-8?B?V1AzT01KN1N4ZlBrR29uKzBoOFJCTnBBMnh1b3ltcG4yeFdmaGhDQUl4WU02?=
 =?utf-8?B?UjZaRnRSVi9GM3ZRelB3K3d0b09qRkNXLy80NGtrT0NQRzBSYUxGWUFIZnor?=
 =?utf-8?B?dmlKL3lpcUNmb2RYWk0wN3loV1NZMnF3S2hGTmpBeVpqN0FlckN1VG4rc1lO?=
 =?utf-8?B?N2VCQnpmUlloY3MzcXRhN2V2RDJFcm5nK2RkZ0lUWWh1dkNZM3BPMEJpUVJz?=
 =?utf-8?B?cFZTRmhjVlRVTnp3eVYxb3NrNUFPSGRCV3R4Q1V4THloWGRLd2R4VE9vaERH?=
 =?utf-8?B?dXZtS0VRSnIzRWt0bFhZQVROVVlEbDNXRWw5MTZreS9HRFlidDRmN3JqWmNT?=
 =?utf-8?B?b3Q3R2FDeXBub0pudFVvcCs1ZGEvRFFraUI3NXBRdlVwbll4ZDZJUTRSd3B0?=
 =?utf-8?B?OEgxZHcvNGVySnR3Z0JwNmVXUDhsQkh4YjJ3VkoxWnVTQlpjWXdNSmdELy91?=
 =?utf-8?B?cHZocjF2YlNXZU1sdzkxREhFVHJ4ZXliKy95ZmFBYXZuMU9aaGE0UWRwd1BZ?=
 =?utf-8?B?SDRQRjRTaWk4VWJGZU1CQjBjNHVDWlhuQTRieEVqWDdPWWlobmdsc3VFU3ZS?=
 =?utf-8?B?MitKV0lDTXEyN1lRWm9XM1lJM0xFeFVBUXZhQmhwYVVqQjdvS0Rmb3RCS0ht?=
 =?utf-8?B?RGRDdWtwSkppWXNaSkY0KzVXNnp3aDU4L1RyTU10YkNYdWhybG8xcXNCQzJh?=
 =?utf-8?B?M2F1Mjh4U2Vnd0dhQnRiQWdONXdSSWFSRGo5SmEyMmVSZWV3dzVSNllVOENm?=
 =?utf-8?B?VVpPTDE4T1VIMnNXd3U3WFNUL0E1dGpBVWtHL240Tk1FKytFOXp6OHQzeTlE?=
 =?utf-8?B?c1EzQzM4aTNVSDBOWVE2Yy9IMkFRR0pyeFJpbDN1eCthZ0htbWxxZTgycUR4?=
 =?utf-8?B?Yk9xUjdFaFFoT1dwM28vWE1QRkJoamVLSnY2T2QvUVhFZm4xV3VXaVZtWUVI?=
 =?utf-8?B?cC9xT05CbzlXMTlkMzJTRjRGZmNkbVNFOVZvekZIUWJZMkVsN1RMSHJxb01W?=
 =?utf-8?B?Uk10ZFhpTkk1Ukc5QkZITThONEFXdjlDenFWdzZsNjFFTjhINHU3ZzdLVXZZ?=
 =?utf-8?B?eVJMeXJveENJbGFqU3htMkg1UktvbnR2b09GenNZK1hlSnFCSnkwTXpuVEJG?=
 =?utf-8?B?RldIc1NmUlE2Wi9JMmFEOGNYazhXdTV2cWlQYTJrR0JKTlpTUXdhSzhObHRw?=
 =?utf-8?B?aDc3ZE51ZDU4WlQybmVQRmViczN4MWdUZDBGNnlxbFNkSy9hWU9aMjRUQ0w3?=
 =?utf-8?B?U056YURHVHNtYXZpSHpmSTBJeXgzcGlxa3dDVkhlMDVtcE16OG1XbnVHMzJm?=
 =?utf-8?B?V1FmUzJlcy9JcFp4aVQxMFZPdjFwMERkeXVheG12NGtxZnFWNFRzSUhxWDRy?=
 =?utf-8?B?Z3Iza243S2ZvTm9xcTJ2ZkVuQWtVYlk1Vlk3R1I0dm1jUVVZbGZVOWx3cGhp?=
 =?utf-8?B?UDNDSHhHMHFUVXRVQ3hNMENRT0wvM2xUWlBKVWhsb01aSDBWTWI2Y0VTYWtl?=
 =?utf-8?B?SEFtK2dQL0FiOFp2SzlUcjRNTjNJdnpFZmZCK0pycElmV1pRR3ZIQWpVNW1r?=
 =?utf-8?B?ams2YlFMa0hGSUtobDdhU1NaZ3Z0TjdJV1pjbHJxcjgwSXdxWlRGUkNJL2pZ?=
 =?utf-8?B?SUQrUWdkQ3I5M2RIakFpbjZ3bmhTWVZvMi92a3NjTjFGbzlBcnJQYUg3Y2lB?=
 =?utf-8?B?dnZldUtCaXk4TGxHcXFra05LQld2U0JlRGFINm53TitLT2laV2tyTVNhdEhx?=
 =?utf-8?B?cUJqYThwR3NYRlVxTk1XL1lMU291VFlEMmdoS0VGZ05zTHc3ZlUrNTZZZG5M?=
 =?utf-8?B?eHdnRVA5TCtuYVc5NDRiWlBPYVo4NHc3akRsWE1KTDdwMGVnZzR0R3MvVTRn?=
 =?utf-8?B?SmY3T2kvdmQrcXdRR1Z1NHNKaEtxbTN1VkVHaVdncTJMVllJTUszZW42UVJl?=
 =?utf-8?B?M2tmM0l1K25aOGdyZlRISmxLYnFTM010ZlVudHhEcStjcEZNcXpuM1JvRlBt?=
 =?utf-8?B?dmZnTEVXOHRVOXplKzRZQ1JBR0FPY3pQOHpySW1rZzFUUUZPTFl3NnBUK00x?=
 =?utf-8?B?VURMZVZ6ZEtiV0x1NUx6WmN2Z3F1OWtOVUYvTk9hUWVUMFlQUjVmY2xxaDVY?=
 =?utf-8?B?dEIwYXNSejdpUjV3bmN0UlhvbkdmUWxZakY3V05LMzRmQmRpZ2RuckNDbmZl?=
 =?utf-8?B?SDlYZjFDZDVDVUIzSmhFa2c0ajhlSTgrU2xRZ3pkdGUxYkhuaUFESDlWYm9a?=
 =?utf-8?B?aWYzUkxPWDQxUHRuM2ZBdHZqeWVCcWd0ZStWUGN5ays5MlBVT1dwTmFRTUhN?=
 =?utf-8?Q?aQ4p9OLRp7PegQM8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ae36d28-3946-4503-3d7d-08df44d98836
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 18:35:19.7102 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8Bniz7B8lGxqJv4UM+fmOFo+nQM/BghR40YdtDR/Q6tkRdNBaTTXBjnm3glzWEHbQZtCHlLITg4MTgyzDDhGxXVs4sDdRFXh0JqHEiIJBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7684
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


On 17-11-2026 19:57, Richard Genoud (Synaptics) wrote:
> Add the missing sentinel in snps_sdhci_ids array.
>
> The struct udevice_id should end with a sentinel to prevent an
> out-of-bound access.
>
> Fixes: 1cf3e900affa ("mmc: snps_sdhci: Add sdhci driver support for TH1520 SoC")
> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
> ---
>   drivers/mmc/snps_sdhci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/snps_sdhci.c b/drivers/mmc/snps_sdhci.c
> index fe834ec29692..4c1a7f1892aa 100644
> --- a/drivers/mmc/snps_sdhci.c
> +++ b/drivers/mmc/snps_sdhci.c
> @@ -429,7 +429,8 @@ static int snps_sdhci_bind(struct udevice *dev)
>   }
>   
>   static const struct udevice_id snps_sdhci_ids[] = {
> -	{ .compatible = "thead,th1520-dwcmshc" }
> +	{ .compatible = "thead,th1520-dwcmshc" },
> +	{ /* sentinel */ }
>   };
>   
>   U_BOOT_DRIVER(snps_sdhci_drv) = {

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>


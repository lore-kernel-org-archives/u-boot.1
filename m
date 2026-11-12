Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94F1606A332
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Lp2OWzU6;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ZmGUliU8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8CC2E80D16;
	Thu, 12 Nov 2026 14:23:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8wopGNfp5s5J; Thu, 12 Nov 2026 14:23:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA2D380D62
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794493390;
	b=mU/A7TJH+g7Pif19gekXhSY2pPfWqlefqsTdXzjbT9hda7tL+NOfBp4h+s4ud/ibNLSq
	 JVh+whGDAizdNgMTbJ7FnJobuEC6X+AJW0yIKThRDX2YIreUHqyK7p5G2HoyrlQhqpbBG
	 5+SlK+pOHUGY+5+96GBCXhX+U04elPXFQkrZgMSBI+6orMQN5238UhfpdCF++DM3xOwI0
	 SO4VErKf/0tcL8f1P2Gqwh169vDmhJUVC0ydK2Eb9eOQRJlXDXEk33PBZsKmI3N4uZF4j
	 WbuRhC9XBz+sbE3uA9fe+029xasB53lS5mKaanTqqvEvZh5V/lFsgs//SmvafFMjFPA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794493390;
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
	bh=LTkl+ozVQBV8KUO89OHuIFfyV3lkRQZXeHpG/uQj/Bc=;
	b=NTZOejjtd7wGkr/n4RK1x1S4vywha4PbGOhlNaFRoPtV0D6XSxeC5DA+hFHC3Qprthxe
	 yxLr3t6vI4rpkiybqotAPVwLj3yikK1BGEBplReyTWD1baPkmwLJmC0sv+KtqvhjkXibN
	 3pcdNn9/lt0fwFcN+/h7lHHqD7h/bJfoZ0He7lC/dXHbOgzz9kdx5FiYFh/Mq4NWTD+6G
	 YriIsbcPhLVexlvo5h5syLKD3RwICT3z2MvUSBdoPCkcjcT6YxmNj1S1KYzqVVO22NjEN
	 ZW8bhbJ/W/mNjiOY7BBX4xqYqajGXWRNJeJUkHRNsBAuA8jnQPJTG29WxOzh9mlbVVg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ZmGUliU8;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794493390;
	bh=LTkl+ozVQBV8KUO89OHuIFfyV3lkRQZXeHpG/uQj/Bc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Lp2OWzU6Hc5jFoBPDVGclpLQD0JlqdK4oT0bUaJe5WNk8yLi56Bo8+s5lMzjagzWU
	 JWiy5BI3MQE0MjKIT3tp1l3AGsXfhEv04nHzWliJIbRHA72vNxMF0XzU2oQo/2+NNW
	 UJ6VDxfPqsjr60wxDplAdmb5Xa/3UR6D76aDic8Dlbf7zMJysMmU9+CC7BkyarW30b
	 xNZOTywuXG6NA1Ha7wseVOxbTajoGLtuPcPas9TJg7bbsnHm5JhxD2LlEq7qxm9N6R
	 ePrvFeEmpMK+jaORHIdfOVj+STq3pUvJR2oDsUsbzDP2NGpipuaEGO/bF+TnjD9n20
	 REvVoMQqONaTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA2D380D62;
	Thu, 12 Nov 2026 14:23:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A167235
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:23:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F99980D62
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:23:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FhzsBwAtZs6o for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 14:23:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5CBBA80D16
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ZmGUliU8
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5CBBA80D16
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 14:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTkl+ozVQBV8KUO89OHuIFfyV3lkRQZXeHpG/uQj/Bc=;
 b=ZmGUliU8ETBc8Qd0K3hXRv33JjTw6bx6ZXvQY/vHWj/KuoMEFzECFCvmfFGieJLC94DhMZHH7nf1U6R+Qs1deO8oHGzPLHp/Q3ZgFuPLqm4bvbYarv7wCVpcEktuKEQ3pAvhzwVraIYhkSruOU6MbXSV0tC+NBIGiDbtumwOIWs=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 14:22:59 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Thu, 12 Nov 2026
 14:22:58 +0000
Message-ID: <45f6a190-79ca-4eae-9291-8522307780ba@cherry.de>
Date: Thu, 12 Nov 2026 15:22:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Update maintainers and get_maintainer.ignore
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org
References: <20261112115842.39126-1-pbrobinson@gmail.com>
 <20261112115842.39126-2-pbrobinson@gmail.com>
 <06aa5a02-0f60-476a-abab-aa3de9ad6019@cherry.de>
 <20261112141428.GB554944@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261112141428.GB554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS6P279CA0067.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:3f::20) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI1PR04MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 109addb2-8cbe-4a5b-b380-08df40c873a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|4143699003|56012099006|11063799006|261028144727099003|261026121527099003|261026140227099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: asL4guEtQLI/a6wwLA4xjVrNyBDGVaMJBzI0aLJX4TFgI5PxYhc7rwF2oqsAIkdErra1WENbe3hUUtJXUv+F/jWCXa8XEnk/NTpj3trbetChAYR0kOB8daDF69bwsC6PxzgPpp5k6QOyOuGbDrehe5aO5nZKGU4IAgTRDQBZXzfj0zTsaAhFTT6VM9xmKVWStRICBdyfhpESGBOkodH4gOZuZyRzT9lkr43P62qiNTo3KZSF5CEQQ2/KJvcniDk6iM5USwvMSrdi2Qad108t2VkODLwKcYtIO7W50uZ7kOf6P5n0iqO2iQbVk1SPaVm6jYcR6bNw3YIK/3+fSfxtVlKW4VndpNUvLrw5gcv8UeuorFE7QNRL/hzrTVb3hlq4DihsZaG4UTeCDAo5uZAHOrVVDPYPlaYeVECNUpkeQIQ5iwbPE6YO0nmx/JZX+ititKyUsxDhZCYZjn8Gl7I+6vD4Fll7JDlKGaT7FlKnt7lPfaubtwANbax3I+uzckGslDkebrqFUb9DeqTIb4Z1MBbFVK4LtcqYWnKKng7gS2oTPDy0Baz7608HIiTVDJZP/V/77Jp4OIbvsoTnMvnGK2Oae6U2Qu4iTMq6gRIDDS04r63Ef/BFjJlJ3Igeu4mul/GZF5em02I62vImlisG6sB4l+yGPGQiZh6U/kb3iY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDVjcnNQY1I3Z3dmQkVrUlQwM2VIOHQvZ092Z0l3ZGFmKzBjaDl6bXBaL0Ix?=
 =?utf-8?B?SDB2c3lKeVZONFNKQzhGUk5ObzNldjFxUUNURVc5bGJHbDhmMXl6dG1oV2RH?=
 =?utf-8?B?d01ldklUaHpiRXd2Z3J0Y2NPNlFqckxiS1ROaFIvUTNEcVZDNXFReExKT2pp?=
 =?utf-8?B?NWRDWUpMWkJzc3BKME1ISzBLTDFCVjdoVkIxay9vNFcyb1dKaW9GbGtTd3Ar?=
 =?utf-8?B?aEg0VHp0QTJOb0k4cFI2TkZYTisxcjBNZFgzRHlCRGx0MGZ0MDNlb2VWbmxL?=
 =?utf-8?B?SS9RaEIvT0JQYUtXanRVbHpXeUYwVEQwZnFjdm1BSE42ZjlNSUxvdHY1MTVS?=
 =?utf-8?B?ZjIrVGkwMVJ0M00rK0U2OTBzM1hocjNtUlhGTlp3MS9XMXdaV0pkVEFTb0tx?=
 =?utf-8?B?UHprdENBays2UUp5c0xYVnphS0F0OXRydUowQldwdUU5SXlzMWR6WUZiallt?=
 =?utf-8?B?NGx0YnM4Mm1KYVV4K1k3bmQ1SE5tQ3d4T3pua2RYVW9qcVdDNzZyQ28yblkx?=
 =?utf-8?B?RTJNcE05c2U4UjRvVTF1YWVieEh1UXU0THViajVSMDgxV1RTRDdLNlgxVzZY?=
 =?utf-8?B?YlNZR3B6bWRONjVGSkxid2ZyYUh0VTU3cGpaN0ZKbk1PMXNOdWFZQStpNmhR?=
 =?utf-8?B?Q0NTNUVPdlIwbTJ6OWhGa2tERDYrVWcwdWVnZ0RnMi9vLytqU2xUZGtuRjh2?=
 =?utf-8?B?Y2VURUs0OXA3U0Rpem55NWltanNmcmQ0L2xNSXhXZ3BBNFE2VkpPVzVTWUh4?=
 =?utf-8?B?THZubU5mWndJMWpVckRtdG1TandiVHdWc0NESEh6QVNUeHl6eS9XV2d6MVY5?=
 =?utf-8?B?QmV1UGFhR2kwdm9ZYVFrbzg5eS82a0doZlc2UU5peUlBb25ianNxSExlaElr?=
 =?utf-8?B?clNiVnhwOSt1ei93bUhrWHNkVjdFVnFSUTg1K091aUdaY01YQUU3cDBXZFY1?=
 =?utf-8?B?ZHVnRDhWRGdQSWZ6ZmNrSUZPN29hRVFYWFVWV3NIK0dkMFYyaEJ2Q3JTMTBF?=
 =?utf-8?B?TXNyaTVRQ3Y3dllhYWtEdkdXWWZ6c1pLUDFURmtMNFE2QVJndTRrQVRISFZr?=
 =?utf-8?B?c2F1ZWY5VmpNVVJZZ0ZaNndFamJIcVAvYXliS3VIRXFoeVpqMlNUUFdQVTFT?=
 =?utf-8?B?V1NuZkI1L0t1WlBnSG9YMno1eUcxV1poZkI3MG8zSjJFYlhvZ09sZ1NvRWdQ?=
 =?utf-8?B?VTl2NFRMTzFSZy9PU3pVazIwYUYxNEdRc3VxQk1mMzdBSUQ2bnB2ZkZYT3cz?=
 =?utf-8?B?eUp4MVlUL01ackF1Y3d4Qnk2ekFITHIzSGJYYWNmc0dtSDZEcVVEelB6SDNt?=
 =?utf-8?B?UUlaQjcydnU3VU55UVNDaERMQXNiZEV3ZDdTVEdmZmdEcDV4SHpzSXZDTjlo?=
 =?utf-8?B?K2syUWN3WmF6aTg5YS9uNDYwVmphYjRtaXdLaHJZY1BoL1pZV0QwR2hCS2dv?=
 =?utf-8?B?TitDeW5vNVhLcGpmNGJFaEhHK1UyaG1Wa3lQQzdGZmIwZjFTS2ZLVjFBdjJM?=
 =?utf-8?B?dVQ3cmwrMlRiUU0vbVdIckx3c3phQ1IrMXJuUmV3RDVjN1RQdk5UYXJkR2Np?=
 =?utf-8?B?eVhTY3hvbXdTbUFuQ1JtSi85cFdXa0lpelZ5cjRGYWg2R3NLVzV0MmVHN3cz?=
 =?utf-8?B?MHZUU0hVL05LTmVUS3ZuS3RzRUxYOE1sSGpERmtBYjkxRjRpRlMwNzlVU3FD?=
 =?utf-8?B?bGw4QTA3V3c3TngySDZCSm52RFJqd3ZPVkJsWEt4SkJrd0hwOFltZjQ2RzUx?=
 =?utf-8?B?WU14YWhGMFR3U1JFRlh5ZVpFVVAyU0ljcEpJejhJaXI1d1NCQzRXanZZVm9E?=
 =?utf-8?B?K1c4OWM4YS85dWptYXdWa24zVkdkZUNwN1BKMGEwSFRRcFcyV3NpOXFPNEFz?=
 =?utf-8?B?cW0vNk5mTEVCdzlmOExXbit4ZEdrNitMZUtpZ3lWVkdOaHBVcTY5N2JCK2J1?=
 =?utf-8?B?ajNUQzZITVdrd0JiY3VRbzY2VFBic0RhcVRkQ3cvTWtLWHl6Tk5YK3piZnFa?=
 =?utf-8?B?NTdsaHpWNXZrM1Z6WEpDU3o0N2VDWnNQMk1NQ3hhZ0Q1eUtRYnhLM3o2YThp?=
 =?utf-8?B?R0h0MWFJeHNRT20yUEtpQWFFZmtsR0h4Q2pPQ3F6eHAxNnQ3dXFQT1ExOEx4?=
 =?utf-8?B?QUVBRWtUMnNYZW5iZnRtMVIycEtRUVZtdzRway9tcnE0NG1kTGJuMnVidUI2?=
 =?utf-8?B?ekRQb3RXaEE1bERIUXhMTDFMcTQxRVBEM25uaHNGbUN5aE5QdGZqS1Zncmoy?=
 =?utf-8?B?NlFvdDU3aE04cG5qK1BNTVFFQmMwNVZ5M1R6K2t2RDNzK1NpeStMM2paY2FO?=
 =?utf-8?B?dEF5cTg2U0xIYVdyQnN2QlRJdmRUVmJoOWwyODQxdzRBWlZSSjUxdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 109addb2-8cbe-4a5b-b380-08df40c873a3
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 14:22:58.9178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YlYnRz5mxgFCVshQzzekitN2xCwck4QlUbRXKy4peE/nJANDelml44Am07buiXUZQKkNn4Gn4a5j4b8efNqwbiORO8nZwgQT5xjeOxvqkiY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/12/26 3:14 PM, Tom Rini wrote:
> On Thu, Nov 12, 2026 at 02:59:35PM +0100, Quentin Schulz wrote:
>> Hi Peter,
>>
>> On 11/12/26 12:58 PM, Peter Robinson wrote:
>>> With the departure of Simon update the MAINTAINERS file
>>> to reflect the current situation of various subsystems.
>>>
>>
>> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> I see we're updating patman MAINTAINERS entry to Orphan... weren't we
>> supposed to remove it recently? I see it's been moved to Simon's tree
>> (https://github.com/deinde-dev/patman) so I guess the "find it a new home"
>> part has been done already. Is there anything missing maybe or can we start
>> cleaning things up?
> 
> It looks like the MAINTAINER entry was missed, and yes, should be
> dropped in a follow-up.
> 

I see we kept a few files because of buildman it seems? At least that's 
what's claimed by 91b94aff149d ("patman: Remove the patch-management 
code"). So maybe there's still more to do.

Cheers,
Quentin

Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63964606A324
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=b8KR47Tz;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=SAHRA+BA
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EC0781366;
	Thu, 19 Nov 2026 16:21:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2lTAxnBUrjfp; Thu, 19 Nov 2026 16:21:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F136B80E26
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795105260;
	b=DGTWKQVzFRB2qGAIggSZO3x7vGzDMsW1eVrSmyewRyYzaV7bfhB85W4uYHcsWuK2dQwg
	 j6V//IeDaMICf4jS/SW4Kv8XoXdwL91gkDqTu0vm4hLF2B620hTQXw3SUEukSmWzSkUKp
	 JBFXQ5BM+FhXJfaYxYbyWJBlSG9UkleorbWqVYjiejvTQMv92k1gyVbq/z2/Q2iXarEqI
	 M2bXlV1lFrovrkvenj48DeGroNqzcCW+/b2rw41do2t9y44JNvMx0WtX84dWItg9CKQQm
	 PJAj4OvV81EmuO526jFBDmPBt3J8h+LWe/X68HD6XqyEBE4h1YzgUNlvyIEP0AbVRhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795105260;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eENlN6LlHwFP7GLLy7YEVxesoJXjzGxVlDPuj4ks2QY=;
	b=UAigR+Ir4/ZCDamMs3AQhRqMTsVyQFoUoiPPR1/xeMp6oRLR5AKbhlJPGFI41lmFQhDO
	 +typs6QMp+vUEBcKbyCBz8WfuxPjQ//7BAtQUP/OHVwoI9Ou+F+/ZjQG1xKOXYzF4e5Kn
	 NvSZ6JlG5jrNP3d+0haaYOMzqJospetFh9ZtLwbCxHR/KcYOGA4U1l30rwbhNON9p+NVV
	 WloUnV/Nld/IyQMLD0kwqiDeP6+fAu1AUQcGSq9snN7VKKMLw9whnS5j3WsbPnhIuwunM
	 /kdMoEMdbUdzhqzFkQfqfF49/SIMJblUzWdHMVHtS2+NP8AvjHn1LgmvcTWP7ILiWTQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=SAHRA+BA;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795105260;
	bh=eENlN6LlHwFP7GLLy7YEVxesoJXjzGxVlDPuj4ks2QY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b8KR47TzmSMqTl4S1T0wt6iD342iitgroamiQw9dcuVsSpqO5v6+W0sZOzBOdsZ4V
	 PQgAOkwfz4YdbhbFBNIxFJJ0cyRe1dcKPwrgsPW0p68u52sbKrzfi/HkRhyGLqFSyJ
	 xv3IU4KEed6jVL+zSrZbvpoXkeAAeN3ui/WUQwHousxhU/r8i8b1RBToEx4ND+mDxz
	 FIJAa/7QIqGajfGUWHAi5zydo418SrKQvQFWnTNNGzncR8gjE4uFEIr/xk7gmeZw/7
	 qtzpNkOKCXZQz6cJlQddiKkWKNEcUP3jrAhODMspikmzG7UgDjhwJYoVQ5U74kSszY
	 HycDRsh8nLnKA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F136B80E26;
	Thu, 19 Nov 2026 16:20:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ECCC91E7
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DDB6D80E26
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:20:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UAlu1BhFE_L0 for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:20:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AFA7280C94
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=SAHRA+BA
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id AFA7280C94
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eENlN6LlHwFP7GLLy7YEVxesoJXjzGxVlDPuj4ks2QY=;
 b=SAHRA+BApwLfU+OCCTvCiQB7afCnK1kaVYa18VD/XQNiA0c9HM5xVBFdky2vfoiwMgHo1TkMVs/KHmlX7IIdCbGdZSApw4tnMg1Gc7h+dLNOE/YHEGJApvoILmA9oRGnP35AT+KKEPGlYcXRiyfqJXAhyqQX9RaN5rgz0jRCU/Y=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV2PR04MB12339.eurprd04.prod.outlook.com (2603:10a6:150:309::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:20:47 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:20:47 +0000
Message-ID: <7a7df675-96bd-4483-bb29-6a4d67b97a07@cherry.de>
Date: Thu, 19 Nov 2026 17:20:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] binman: x509_cert: support PKCS11_PIN environment
 variable
To: Sergio Prado <sergio.prado@e-labworks.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: trini@konsulko.com, alpernebiyasak@gmail.com,
 marek.vasut+renesas@mailbox.org, ilias.apalodimas@linaro.org,
 pbrobinson@gmail.com, sughosh.ganu@arm.com, wolfgang.wallner@at.abb.com,
 xypron.glpk@gmx.de, jj251510319013@gmail.com, Wojciech.Dubowik@mt.com
References: <20260728113535.128601-1-sergio.prado@e-labworks.com>
 <20260728113535.128601-5-sergio.prado@e-labworks.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260728113535.128601-5-sergio.prado@e-labworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0902CA0033.eurprd09.prod.outlook.com
 (2603:10a6:802:1::22) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV2PR04MB12339:EE_
X-MS-Office365-Filtering-Correlation-Id: fa3c4a98-0545-41b8-69cb-08df4659116e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|10070799003|376014|1800799024|23010399003|10067099003|4143699003|11063799006|261022113327099003|56012099006|261021130227099003|261022105027099003|261022075727099003|261009221227099003|261021135927099003|261021133027099003|261021121427099003|261102123227099003|261009223027099003|261021123027099003|261022115727099003|261026135527099003|261026140227099003|261026121527099003|261026130827099003|261028144727099003|22082099003|18002099003|6133799003|3023799007|4133799003;
X-Microsoft-Antispam-Message-Info: GvvUC59ur5f0nOGjOCfhhJAhv1XswpFUp0LkNnYOKcAMROXDoImoA8KwwWIOmRZX+MDeqPbejJUCPYLnCVHmkus7iFxI3Fen4UM+gDNx+VNX5yDFEF/k2DfXHL0Gv1WhqJ2cr4q5rFuItA1uUi+GWozV0ZbHiMDZ09M1+c/McPxZRbRLet0gZDjJKsSTpsHLiXtncWb+0H48uIIn3la0LBM9fFnyPien6P7Ne2Av5f5pR9b0e1t+wuDbL57VwA0vq8hO29sgOiOBd8ByuulV7VFXqxXlkr3dRnZH+m9lrV0Zm2lfVjS93x3SX7Z9slaHzjeqNziW++7it6FE34QQfdxW/Ocb1YyfSDidQUSjgWuUWpbbhOVHPDyB7W1+Q8ipEsO8OJcDyHqdPBhULj4zQXBYNMuzyLbgGubAxQR05z/5EoSlYy6NWlQAlIsbaCg/rBsVOD0Ie8ulRe7HNXXwfj47a6cTzjLD4WNzcPGzo7+anAyvJYNqkotD7ysTIP3yRxRg5yubi6l4vNg+bjKQBbrZcrt2DD+G5g+JC+3rruXREf3KjKuDrwJRXQw5HKPE/E0DHWNz19RjKv+fc4UVnB3YRwLUsef0rfsjlt/AMD8bzz8j+RYmAY4Q4Ya9wbTVQ/5iNEwDBg3dLDvASu/GlU8toSEVinmwJbYFxKQtQMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(10070799003)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(261022113327099003)(56012099006)(261021130227099003)(261022105027099003)(261022075727099003)(261009221227099003)(261021135927099003)(261021133027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261021123027099003)(261022115727099003)(261026135527099003)(261026140227099003)(261026121527099003)(261026130827099003)(261028144727099003)(22082099003)(18002099003)(6133799003)(3023799007)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VJWThENEEzYUxsNS9iMjZGVkJJcWQ4M3ZRZG0wUVRzUnJzblNNMXg5VFJH?=
 =?utf-8?B?TjBSbTA2cDVkcTR3Ni80Z2syaFUxZUFLSnFrOWZKcHA0OXY1WFl0YUdMS3dY?=
 =?utf-8?B?bHZkL1N1K0JRaE1DMUlRbE5IUWZROHdEU29vZnNINCtkRW9pWVI1Szl4c2RO?=
 =?utf-8?B?TE5weUE3UjJKc3RMdFE5cUpxN0FhaTNVS0lmSVFuL09yV1VpNDFadGIyQ1Bi?=
 =?utf-8?B?Qkg2bVBOLzBPeHMxa1N3YitLakJLQmQwSWV5SlZLK3B1MytGaHVVL2tVNTlq?=
 =?utf-8?B?NXRGa3ZjYjRqQ2FlQ2lmNzVyaDZTeWQ5clRsdjZ2cFR3Y1hlcm5OVC9pUGNI?=
 =?utf-8?B?Ky96QStSUm9sL281YlRpc3pmcVlNZ2dzMkxwMG5VZGRCWHNvV2NNejllSHhK?=
 =?utf-8?B?eVpJblpWVmUrbmJueVFQS3ZLUVRRbHVTcUpQN2RJUG9TV1F0bm9HQkxBSFRT?=
 =?utf-8?B?REF0ZDFlbUwxRllGRkV6T2JiVlo1TkpBeHpiRWxWWEJTMVpzaDZSVGdDejNL?=
 =?utf-8?B?WDFyYmwvQmR1SEtzQUtWQmVkZk9NbUY5SVNqK0RBOGpmR3dTbkR5em91QWN1?=
 =?utf-8?B?WWNETm9RaUVPamY3UkllaDJaZTBrbXBMRER4ZmwwT3lWREdiTm5PTUk1a2U4?=
 =?utf-8?B?SGM5emRHcDRrVytuS2ltcTRRbnUySXo5NTRXYnVCb3k1bERHZTk4bmZyRE9p?=
 =?utf-8?B?NnMrYXFIZHR5dTJ5dVdjZzNiaDJxOE5zM01UZFlsaWxIN1gxdm5kVW12SURJ?=
 =?utf-8?B?WkVvQklybkFPcnBidng3eU9TTnRxRnU3bFcrZEtZNUxUZ2R1UGFGWDZkVDVp?=
 =?utf-8?B?UGtYMURnZEUwNFVrZC9RYzdxdnNuRmZnU0VxSFVyK2R2QytUQjRIbVRub0dD?=
 =?utf-8?B?NGM1Z0ZZMFYzY2NhRHVITXZ1eThSRkxUZ2Y2UlMrVkRpRWI3cGZ3cTJ0T1li?=
 =?utf-8?B?d3dvQ1JhbjRFamIraEVheVQ5dG1weHc1N1gzVHJVd0RwbTQxVjhkOWFXZzJB?=
 =?utf-8?B?OEQxd1ZrZ3NlQ2NjdVlBcHZkQU1KZVNDS014YXhBYlJqYjV0N0c1cXMxR1ZV?=
 =?utf-8?B?QnoyaW5yTDJRZGxpdHhRamJOdkNoYS9WNjZCNGJoYWxGamFIWWxNd1Q2ZVJF?=
 =?utf-8?B?SDhqU245eDBndFJXTktCUXVBSGxwMGYvRUU0K2NNOGFlK1ZTMXZtSk0rd3Iv?=
 =?utf-8?B?QWNIUWMrQTY5QjJqR2oxR0laMGNYMTRUdlNha3h2TE15MGNJdDEyd1NpSGIv?=
 =?utf-8?B?K1h5Z3ZEdDVDaTViVEY2Q2xFSlBqVXQyVkxrT3h0T09tL1lrR3Bmb1ZuMmVs?=
 =?utf-8?B?OFY0N2hSTWcwM0Z1T0hHUll4UXQwQWxyRk1KY1NhS0t5Njd1dW44enB4a0tq?=
 =?utf-8?B?UmxTbGxONnUzcFdiM2w1OGNtVldzSm56aHV1K2E4SExPMEdLMUhhcEVBbnNQ?=
 =?utf-8?B?RjFhQWlSK3ZtaWFiZXM0OStHL2JlSnZCZmh5d29FMWxmalVBV0RzemNRVWNC?=
 =?utf-8?B?ZUc1QnNleUkzbENrU1VOdVdad0hoOTVyTG9sTUhoWTMxYmlram9nS0huS0di?=
 =?utf-8?B?Q3JmRHBPelV6NVcrOVpRTk12YmJxbi9CNnZhbkFES1M4TnVZU0ZQWFBhU3M5?=
 =?utf-8?B?ZVlCeEpDOWdSclI2ZVRHdkNJVE5EWStRZjNzNlVndUtXb2RYMUl4YU8yMnVq?=
 =?utf-8?B?NXJreFZ0WkZPcCswTmlTM0YySExEUXlVR3pmd0lydHE3bWU2eDl5NUZlNGhL?=
 =?utf-8?B?ZHZxdlBwcjljT21JSzR6bXhLemhjWEV2cXhhMlBzdHZLTzVzeFJnSHVkYmRt?=
 =?utf-8?B?bFowdGU3UTdtVndLWW9nUDV2Q2dRTG1ETVFCTzR5Ylp4WEhITXBDV3p0eDdp?=
 =?utf-8?B?N205cUR4UUZWQlV2cWRabWtlMEFWYU5zZ1pWUlpCdXhxWWROTjR4TzNQR3hS?=
 =?utf-8?B?SFJvNlZqQmRpb0g3SXBpYkdRUFgwY01ZVVk2WFhGRVdwQ1poTjRJNTJBVWFo?=
 =?utf-8?B?YU5CTWV4T0FwZDNWT0dLZnhPcG8wUGU5TEZ6MjEyb2w4V1BTRmhKQlRpbEQr?=
 =?utf-8?B?Z3FoQzcxc2RjNmgrYkFkU1NiMmdhMWhhSTFnRjBUaTFjb3BEaEtCbHZPeWl4?=
 =?utf-8?B?eW1meFJUOEtxZ05EZmRseVV3T1JNYWc2OVBmdXRTdzBZVVhBdDF0U3ZYdDEv?=
 =?utf-8?B?MjNteXpFK3pWRjhyNy8rUy9taFZna1R5NnQ1VFpzU0cvS0Y5amlJWEx1Nyth?=
 =?utf-8?B?YXRhR01mUGJhMTd6K3c1REFMeTNGdlBPdXlQZUtKNVFudUxHVm1xaHlRbkM1?=
 =?utf-8?B?RDZBMVpFakRMUVNtQ1F0Ny8yZGZWN1Z4T3FXSS9LVE1BOWJtUEJDVkVWR3NT?=
 =?utf-8?Q?reqthW6hyBZN9Wx1BNEpy1t6jtXeMyMYCfOZTQ4goXhhD?=
X-MS-Exchange-AntiSpam-MessageData-1: 6vQ3QipbgbeUa9EM8b9a9lwYF+rRC5grOhc=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fa3c4a98-0545-41b8-69cb-08df4659116e
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:20:47.0020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZnVelSmw9RD+9IIw24ivJPeKl7jUga9h4CNBr1jW5HgCh5L+vdWxevZNJc4BBZTYtAweo6UQPXR4TFDM+RbUeymuH6r1k25Iyfvl/8GtZSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB12339
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

Hi Sergio,

On 7/28/26 1:35 PM, Sergio Prado wrote:
> Signing an x509 certificate entry with a key held in an HSM needs the
> token PIN. It can be put in openssl.cnf via pkcs11-module-token-pin, or
> in the PKCS#11 URI itself as a pin-value attribute, but both mean writing
> the PIN into a file which is part of the build. That is not
> user-friendly in CI, where the PIN typically arrives as a secret in the
> environment.
> 
> Read the PIN from the PKCS11_PIN environment variable and append it to
> the URI as a percent-encoded pin-value attribute, as described by RFC
> 7512. The rewritten URI, not the original, is what reaches
> 'openssl -key'.
> 
> PKCS11_PIN is a fallback. A URI which already has a pin-value or a
> pin-source attribute is passed through untouched, since the PIN named by
> the URI is the one OpenSSL uses; appending a second pin-value would
> silently override it, as the last occurrence wins.
> 
> Note that PKCS11_PIN keeps the PIN out of the build files but not off the
> openssl command line, where it is visible via 'ps' and may be recorded in
> build logs. Configuring the PIN in openssl.cnf remains the option which
> avoids that, and this is documented alongside the variable.
> 
> Signed-off-by: Sergio Prado <sergio.prado@e-labworks.com>
> ---
>   tools/binman/binman.rst         |  11 ++++
>   tools/binman/etype/x509_cert.py |  31 ++++++++++
>   tools/binman/ftest.py           | 105 ++++++++++++++++++++++++++++++++
>   3 files changed, 147 insertions(+)
> 
> diff --git a/tools/binman/binman.rst b/tools/binman/binman.rst
> index 86e15741fa35..106c34efb76c 100644
> --- a/tools/binman/binman.rst
> +++ b/tools/binman/binman.rst
> @@ -1595,6 +1595,17 @@ If both are given, the ``pin-value`` in the URI wins. Note that a PIN placed in
>   ``ps`` and may be recorded in build logs; keeping the PIN in ``openssl.cnf``
>   avoids that.
>   
> +As a third option, binman reads the PIN from the ``PKCS11_PIN`` environment
> +variable and appends it to the URI as a ``pin-value`` attribute, so that the
> +PIN does not have to be written into either file::
> +
> +    PKCS11_PIN=1234 binman build ...
> +
> +``PKCS11_PIN`` is a fallback only: a URI which already has a ``pin-value`` or
> +``pin-source`` attribute is passed through untouched. It keeps the PIN out of
> +the build files, but not off the ``openssl`` command line - for that, use
> +``openssl.cnf``.
> +
>   .. _`BinmanLogging`:
>   
>   Logging
> diff --git a/tools/binman/etype/x509_cert.py b/tools/binman/etype/x509_cert.py
> index 6d7883af58ef..66c9987976c2 100644
> --- a/tools/binman/etype/x509_cert.py
> +++ b/tools/binman/etype/x509_cert.py
> @@ -7,6 +7,7 @@
>   
>   from collections import OrderedDict
>   import os
> +import urllib.parse
>   
>   from binman.entry import EntryArg
>   from binman.etype.collection import Entry_collection
> @@ -70,6 +71,9 @@ class Entry_x509_cert(Entry_collection):
>           self._cert_rev = fdt_util.GetInt(self._node, 'cert-revision-int', 0)
>           self.key_fname = self.GetEntryArgsOrProps([
>               EntryArg('keyfile', str)], required=True)[0]
> +        if self.key_fname.startswith(('pkcs11:', 'org.openssl.engine:pkcs11:')):
> +            self.key_fname = self._add_pkcs11_pin(self.key_fname,
> +                                                  os.environ.get('PKCS11_PIN'))
>           self.sw_rev = fdt_util.GetInt(self._node, 'sw-rev', 1)
>   
>       def GetCertificate(self, required, type='generic'):
> @@ -178,3 +182,30 @@ class Entry_x509_cert(Entry_collection):
>       def AddBintools(self, btools):
>           super().AddBintools(btools)
>           self.openssl = self.AddBintool(btools, 'openssl')
> +
> +    @staticmethod
> +    def _add_pkcs11_pin(uri, pin):
> +        """Add a PIN to a PKCS#11 URI, so that signing runs unattended
> +
> +        Appends a 'pin-value' attribute holding the PIN, percent-encoded as
> +        required by RFC 7512. A URI which already says where its PIN comes
> +        from is left alone, since that takes precedence over the PIN passed
> +        here.
> +
> +        Args:
> +            uri (str): PKCS#11 URI naming the signing key
> +            pin (str): PIN to add, or None if there is none
> +
> +        Returns:
> +            str: Value to pass to 'openssl -key'
> +        """
> +        if not pin:
> +            return uri
> +
> +        # Only the query component can hold pin-value / pin-source
> +        query = uri.partition('?')[2]
> +        if 'pin-value=' in query or 'pin-source=' in query:
> +            return uri
> +
> +        sep = '&' if query else '?'
> +        return f'{uri}{sep}pin-value={urllib.parse.quote(pin, safe="")}'
> diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
> index 10373a2fa899..e91768c52fe9 100644
> --- a/tools/binman/ftest.py
> +++ b/tools/binman/ftest.py
> @@ -35,6 +35,7 @@ from dtoc import fdt
>   from dtoc import fdt_util
>   from binman.etype import fdtmap
>   from binman.etype import image_header
> +from binman.etype.x509_cert import Entry_x509_cert
>   from binman.image import Image
>   from u_boot_pylib import command
>   from u_boot_pylib import terminal
> @@ -7001,6 +7002,110 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
>                                          entry_args=entry_args)[0]
>           self.assertEqual(U_BOOT_DATA, data[-4:])
>   
> +    def testX509CertPkcs11Pin(self):
> +        """Test signing with a key in an HSM, with the PIN from PKCS11_PIN"""
> +        self._CheckPkcs11Provider()
> +
> +        token = 'x509-test-pin'
> +        key_label = 'testkey'
> +        pin = '1234'

question: should we use different key label and pin?

They are already used in testX509CertPkcs11.

> +        env = self._SetupPkcs11Token('testX509CertPkcs11Pin.', token,
> +                                     key_label, pin)
> +        env['PKCS11_PIN'] = pin
> +
> +        # This time the URI carries no PIN, so binman appends the one from
> +        # PKCS11_PIN before handing the URI to openssl
> +        entry_args = {
> +            'keyfile': f'pkcs11:token={token};object={key_label};type=private',
> +        }
> +        with unittest.mock.patch.dict('os.environ', env):
> +            data = self._DoReadFileDtb('security/x509_cert.dts',
> +                                       entry_args=entry_args)[0]
> +        self.assertEqual(U_BOOT_DATA, data[-4:])
> +

issue: same remark as in patch 2

This remark applies to the whole series, please apply to all occurrences 
in the series I don't think it makes sense I highlight everywhere the 
issue occurs.

question: should we have a test for pkcs11 engine?

> +    def testX509CertPkcs11PinEngine(self):
> +        """Test PKCS11_PIN with an engine-prefixed PKCS#11 URI"""
> +        uri = ('org.openssl.engine:pkcs11:pkcs11:token=mytoken;'
> +               'object=mykey;type=private')
> +        entry_args = {
> +            'keyfile': uri,
> +        }
> +
> +        # openssl is forced missing so that this needs no pkcs11 engine to be
> +        # installed; what matters is the keyfile it would have been given
> +        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
> +            with terminal.capture():
> +                self._DoTestFile('security/x509_cert.dts',
> +                                 force_missing_bintools='openssl',
> +                                 entry_args=entry_args)
> +        entry = control.images['image'].GetEntries()['x509-cert']
> +        self.assertEqual(f'{uri}?pin-value=1234', entry.key_fname)
> +
> +    def testX509CertPkcs11PinNotUri(self):
> +        """Test PKCS11_PIN is ignored when keyfile is not a PKCS#11 URI"""
> +        # A path which merely contains 'pkcs11:' is not a URI, so it must
> +        # reach openssl untouched
> +        keyfile = '/keys/pkcs11:key'
> +        entry_args = {
> +            'keyfile': keyfile,
> +        }
> +        with unittest.mock.patch.dict('os.environ', {'PKCS11_PIN': '1234'}):
> +            with terminal.capture():
> +                self._DoTestFile('security/x509_cert.dts',
> +                                 force_missing_bintools='openssl',
> +                                 entry_args=entry_args)
> +        entry = control.images['image'].GetEntries()['x509-cert']
> +        self.assertEqual(keyfile, entry.key_fname)
> +
> +    def testX509CertPkcs11PinSubclass(self):
> +        """Test PKCS11_PIN reaches the TI K3 x509 certificate subclasses"""
> +        uri = 'pkcs11:token=mytoken;object=mykey;type=private'
> +        entry_args = {
> +            'keyfile': uri,
> +        }
> +
> +        # These read 'keyfile' through Entry_x509_cert.ReadNode(), so the PIN
> +        # must survive into the entry they build
> +        for dts, name in [('vendor/ti_secure.dts', 'ti-secure'),
> +                          ('vendor/ti_secure_rom.dts', 'ti-secure-rom')]:
> +            with unittest.mock.patch.dict('os.environ',
> +                                          {'PKCS11_PIN': '1234'}):
> +                with terminal.capture():
> +                    self._DoTestFile(dts, force_missing_bintools='openssl',
> +                                     entry_args=entry_args)
> +            entry = control.images['image'].GetEntries()[name]
> +            self.assertEqual(f'{uri}?pin-value=1234', entry.key_fname)
> +
> +    def testX509CertAddPkcs11Pin(self):
> +        """Test adding a PIN to a PKCS#11 URI"""
> +        add = Entry_x509_cert._add_pkcs11_pin

nitpick: do not use a variable for a function

I find it makes it harder to know what's happening by quickly looking at 
the code. You can keep it if you want, I just don't like it :)

> +        uri = 'pkcs11:token=t;object=o;type=private'
> +
> +        # No PIN to add, so the keyfile is unchanged
> +        self.assertEqual(uri, add(uri, None))
> +        self.assertEqual(uri, add(uri, ''))
> +
> +        # PKCS#11 URI, in both the provider and the engine form
> +        self.assertEqual(f'{uri}?pin-value=1234', add(uri, '1234'))
> +        engine_uri = f'org.openssl.engine:pkcs11:{uri}'

question: is it really supposed to be 
org.openssl.engine:pkcs11:pkcs11:token... ?

See the duplicated pkcs11: in the URI.

> +        self.assertEqual(f'{engine_uri}?pin-value=1234',
> +                         add(engine_uri, '1234'))
> +
> +        # URI which already has a query component, so '&' separates the PIN
> +        self.assertEqual(f'{uri}?module-name=softhsm2&pin-value=1234',
> +                         add(f'{uri}?module-name=softhsm2', '1234'))
> +
> +        # URI which already says where its PIN comes from, so it takes
> +        # precedence and the keyfile is unchanged
> +        self.assertEqual(f'{uri}?pin-value=5678',
> +                         add(f'{uri}?pin-value=5678', '1234'))
> +        self.assertEqual(f'{uri}?pin-source=file:/etc/pin',
> +                         add(f'{uri}?pin-source=file:/etc/pin', '1234'))
> +
> +        # PIN percent-encoded as required by RFC 7512
> +        self.assertEqual(f'{uri}?pin-value=a%26b%3Fc%3Dd', add(uri, 'a&b?c=d'))
> +        self.assertEqual(f'{uri}?pin-value=a%20b%2Bc', add(uri, 'a b+c'))
> +

question: should we have a test with / in the pin?

Since we're calling urllib.parse.quote(x, safe="") which means / is also 
quoted.

Cheers,
Quentin

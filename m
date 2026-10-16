Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E135CCA46C
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 13:05:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 05F2760662;
	Fri, 16 Oct 2026 13:05:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0Yi_AMCeTwAG; Fri, 16 Oct 2026 13:05:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3D792607CE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792155928;
	b=RCoGK0fIXHPSaEv8pkWvij1HXc6amJs+C31uXMmGbXdyPhK8D+Oc6XtYlYmeo07hWlXv
	 JdPj56DrJQLHjT9pYImJb8bx1GDK3EwPBl1X+HvqjfFwfPlaSjAKbIFszBHmXhiFL1MpB
	 O4EZkS/H3ldtKj/HAfPlEXt15lVEIXfKw+L63Vkrk/nueEG6gRnnAwd1TqUCZnZhwl2cA
	 AdY1KceEQ12MB37XZg+cufC6lfXmrsT2TCxgifyYQfPxqJacm3oakh0fjvSqGE/UNVM2R
	 SX6sRIn2DEfKbGoFtYKY2NIo3ItZcJkNaIPvY6//H6C2xO+gTnwhXmoejYft4Mj8HLg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792155928;
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
	bh=j/AC3iJv2p/7X2bMpXIhp6UAs4HMPojT0Qy7prr9qBY=;
	b=iseqcPXYW3joozwua/FeQS/3rSG9/smCmlrEJEZULuYZu80HyfRc/Sa8/GblJPwztJ7v
	 yntheaM2FuKk20KpZPZWmDn9BdOucQv27owoTG2zIZ3IawQagrO0K00aWeQIq2LXl8KNW
	 esgBMHCX26cPeEXISoR5JOM70zSIujLpR8KTR2Ue2iuY6CICM+ObRCXYVXL1n6lga0ck9
	 fGr1tnz6p1cplGfxaXBGE1Z6jFVDkip4xX+Rw+EZJTJtjClxM87HIpV4DX+qRyw2EImj5
	 o9kCw7rgga3wyUoq8b9RQPgYDTdH1LLjJ0wi2E/wz89+F257lfEios8itwn86gI5+VQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=gcD5so7b;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792155928;
	bh=j/AC3iJv2p/7X2bMpXIhp6UAs4HMPojT0Qy7prr9qBY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=evHSDvwdanYC/f/oS6Or3pe+E/LwS1y6T7Golpgv57qVrbEqIU64ubhTqsjURLSgP
	 eqmIdlq98f1WqJk19Bv/W1VH+oGUPSdT4Niy5PEdEuu5N74tycPMX1sigPtaVUQXk5
	 PQ8A3ExWkh+3f/cwp1leJEJj3AfrXs+lW5d0HWx/y2SwNSgJtEqTVpsvkPf4tzM7Na
	 Lq9uzrj6FpO/9I55IQYqfWUZZuFvHCcIupeUrTkuic1mFgvLaxMXSEaIUt/5xlke1w
	 SP7eFcY97vDdKwo2eW8RHOsDXn2qqdPe85KsKyA901Qqe44X9p53tCMV7dKX3qX9ek
	 D4el9/Hn+RiyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3D792607CE;
	Fri, 16 Oct 2026 13:05:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 733E9362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:05:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 64AEC607CE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:05:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sk_ul2bTlVkD for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 13:05:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D8B1060662
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792155925;
 b=FpRnx/ohj2YOXovP9lAZINBhOMUn9egcCYHs3bNPSPY56Cbs0phmQFGW8kHq18RyFMAT
 wZu6tBgjGH3YdxO7hyJ6AocA+4+bi1vxRskQatWb09wxf88oUeU1uyViN/j1PY8jP5E/D
 7qFXVRkgoLhMSsJYPyvtrkExHqFGzUImfc6b4z+bPlgmS1YguEdiYnNXZ+raBxpfLuZd8
 xqiiH6WNQTZ+UdqgKRegujdh2M4AR4JGkam/Wq1GY4DkQ4XRkVt7evGvrnc0k3JOAxTfq
 mrlaF55kr9MFYWuJJ3pr/aI097cPz4DpXdCnKfZrziP/y6Z1nUEozFlM4uT1ef77pOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792155925;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=j/AC3iJv2p/7X2bMpXIhp6UAs4HMPojT0Qy7prr9qBY=;
 b=UM/21RdRldNgL63XkWhcFyJzwxBQ6REAGPGGh8y0c1ljuNIMoGj+uEitBtF25dF/U4wG
 KSu/mjZFUMplOHUiebQD+495jDMPyrAuawthXDsMAmLucrU/GZPX8Xr3fQ4ZEtPjaAJJk
 Z+ClNrKcH+H1pxj/FDVq1prhWPV2P03w/zsskqLvJ0M24ASEUnIWlP5oBT+l0JdaCSp8T
 N4E6Quz4B+zc5tVfz/zktD4iQ5UHBpdLEM/chPlZCmTc6J670Fhr0oT6EYEoyxCxC511p
 xGLDtFC+RHxRLDQnYzI1oHuaYzu7e0PiVVN1xK6WEpDXbqa2/071aEgl+46zEt3IUSg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gcD5so7b; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gcD5so7b
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D8B1060662
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 13:05:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AJCP5lTHbMYxK9EwbbJDLS/WP6aVe4axv2ibJ5dOzDP8zXapUFzMZsiU3DFBbbIDXBl49J8BJWeL6sFahgRsF/RTNhOfkwANF79vG8noOznyG5uhFni9LAignsJuKkoH0mPLfJ2+s+w736NZ1KY9NTrOCNLOdNpP8XN0cCX1g6AS1ZFmDgOnL7oChVclYvqV6yduaN46LpsDANJpJlA5rdN91Qm/Rk9HAZbzBRsdlsCR3R8XRPdO1ynXhuw8fxXcHKXu5QMc3HQyHSH9ZUjq+3N9QFQSlhVH7bWOAyV4R1wjtTRg6MO2njt1MEfpQmt0E9P2DZV4ssMTCBLbB1mh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/AC3iJv2p/7X2bMpXIhp6UAs4HMPojT0Qy7prr9qBY=;
 b=iIqEMd4WlEXUeSiMXjQqo8T3IooBLz5rcxdx1QU4EvcOff2Z3ZfdiIoddnV5xqO4ZfZAgkNQSs6peLTiwCiZcH9B3xwUjZkJ1JL5cVAuCEsCKZ/kfmS0+K8aRg3fkbLZyul2suJ2Ti8a6A11JLA3AjsJTmaxIg1J4pkJQMfomS1+mrA6qdEASfOuVXN26Tm/lqp1Mpc9bTJMC3vQGSbj9dTbNeaTJKS0l1HpGkPpW7wyqQ5bs9DF1DRwHewBMhT6tMB/VQcbzqDgGoaKe6aO0yaYqngzC37Kf+XjH2Q0k1uXyvI/FvTjujihroWBpLPBe0xPQP6drMYYAxs0pU7BkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/AC3iJv2p/7X2bMpXIhp6UAs4HMPojT0Qy7prr9qBY=;
 b=gcD5so7bt4CB8a2+qMUVAeARLAHGWPA233SOLxPz0rMlpJXtWUIWGfzSwC0sMYvI2IV0Dh5RD3+GT04mBHvxcNSFBxbtO23uoqCOIUQRPI6LhI8fhv+kd/S90SEZTUYqhd7kRbCWUYRMKrmKhcITakI4gjmg01D2x/Nf2VNhiVI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 13:05:16 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 13:05:16 +0000
Message-ID: <b4abae45-635e-421d-bb8d-e4699b0f05b2@cherry.de>
Date: Fri, 16 Oct 2026 15:05:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: regulator: rk8xx: add RK818 LDO9 support
To: Shigeaki Asai <y-asai.0816@docomonet.jp>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, neil.armstrong@linaro.org,
 jh80.chung@samsung.com, peng.fan@nxp.com, kever.yang@rock-chips.com,
 sjg@chromium.org, trini@konsulko.com, ilias.apalodimas@linaro.org
References: <20261010013237.2269021-1-y-asai.0816@docomonet.jp>
 <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261010013237.2269021-2-y-asai.0816@docomonet.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0025.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 5623f523-1239-4de8-3896-08df2b861f26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|1800799024|376014|366016|56012099006|4143699003|5023799004|261009223027099003|11063799006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: p5MYBwwkjlp+kPfFLHny2PpTqH77swnygr7kivY+wfr8Rig5RoTT5/+RPXqgkf6Zsc81wM545nMYO7UddvEjAGNlUcv9agiUPw6EPHoM0ARHHgJ3ENm60mzMCxVb1ZNQcNCymjYDgzyDK0UAW3ehCEyRsm8Qw6Qe/FFKVencfYa1wMcDL4WVFj523eCsobaw6xX+QeYIownlPCplPPIqexcoP4f6DzC/fEId0KUg4/TFsjnbwKUvlFhkYzofA22Ee7Y/nfXGpSgShtxU0i7k34tXqflx0O/oCOU5i7Kgm2c4M8IECCFkICQVSlbNJRnkURaY4AzWLRWWov2DfPnhZqa5Dy2tqaX4diH6N6qfecyn28jAwcl+w5fPeASE4DpARI/Fo1hfKjSZhp6xQ7MMcjCfdRPwdSTvt8XA6M9Vo0IfAkeCMESdlnUbGKnwHwG5fQKVFzcbuo8ftXRboXOn1guZaKI9BxCovRvOyAklAkuUsj0vaglM5Q10w2hGESV7Hg5TSEhB2Mie33tRzdIq7j/aiU8ZiBPO0g2CTZpkCWcCsW0LkoLHUQp5ZUDOUpmgqvRJ003fOlno6DlwK9ojRTo2gPN0ZtmbVdGcMu3is4Rjvd8W3V0+ffnKR6nR4wKgwNo1yjNldej1UQdCJLCEnoUA5Zx/F/WGD3v4iskhB18=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(56012099006)(4143699003)(5023799004)(261009223027099003)(11063799006)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0gwY0h1Qnp1aUxMaWdhdUh1NUpyRWp3MVJHUUh3NFdXdG51M04wYzMyQTRS?=
 =?utf-8?B?TXQva2poSjFGeWxzQklxdHI3N01FMXprZEpNaXhKU1JLemhhVFJ1RDE5bUNX?=
 =?utf-8?B?L2kvV0FpcFRRd3JjVmhNSWowM1NGL0hBWno2ZGRkQ25mWnlNa2hHYVlrcXNS?=
 =?utf-8?B?RVhxaXNaSDBoRzVSekFXQUtnREw1TXpDbnpIRjR5UU9WeXdJVlMrQ3dKdGc4?=
 =?utf-8?B?NTNMbXVXTmZ0NW4xRHU4ai91RFdvWXFSaHNBcGRXd3FUVklmakNJNnFGbzRC?=
 =?utf-8?B?VzZYYmtjT0xLVjRWdXNGdmd5bUVhSGRTZnVtUm5xWGc1SmllSjVLcGVseXdl?=
 =?utf-8?B?ajlxU2ZQN1V3QVRIWmdmQUlsaktTdHRjODRNZ2Z4SjBTUG1LbGF6bjJqOEtU?=
 =?utf-8?B?MndvWWNSSzdzSWdNeEhGYzk2YXRrT2RFUUVNNmFCTndzQ3VZdEdjajhNZ3Vl?=
 =?utf-8?B?U3Npa2M1NnNhQUtjZGZNandRSzhuWE41ekhZMEdGOE9MWEdaYVZ1OWh5UE1L?=
 =?utf-8?B?NEMrRGUyTmlPQVBGU0o0ZlluN01XTzhUM21SY2E0ekxEYUpsWnJXQzNwRGk5?=
 =?utf-8?B?ZWhtenB3cVp4czZMbHJjZlRTWlNSd043QUMxL0xTbjdDNkZDVTQyWG9EVVdk?=
 =?utf-8?B?MXVXbEtPRVZXdUM5b3oyYkFWRmIwVmxkblJrSEdEZit4dFNqZVhBYksvM0R1?=
 =?utf-8?B?MEZTMjJRUllUeW9HRWMrNlBLbDJ3cHBZQy85OTVucm5BR2k0SU5uS0ZEKzVV?=
 =?utf-8?B?T2FCY0Q4dFg1TGVLaWMyaWgvN3k5eTVqR3AreUt5YUpuU0htWFNQMWZxU3JZ?=
 =?utf-8?B?dkNXelJLVXhsblE3ZHpEVjNoUlZka0xKeTlaOVljbUJuNW1yVWdqWUJrVWxN?=
 =?utf-8?B?ZzZZNmNPeVhONVlGbDg1WEtRNEdEUGlQTC9tR0hoT1RWdHVib1QydGVnY2xr?=
 =?utf-8?B?NUowMk1uS3p2U3pkc09CZnJGT2lxOVZhUVZQN2swczcvbHBWR2dJL1dFQkhz?=
 =?utf-8?B?VTJsbzNFVWllVExlRHdJR2pKRzREZSszd0I1ditGaWI2UTB3bm5NQlRHYmNW?=
 =?utf-8?B?Nk5qSUN2RE9kY0d2NDQ3Z09WSE1qRFRBVGdMQkJHTnpDUTFRbVE0dktEckEr?=
 =?utf-8?B?RkNSMGd5STZjNWtvWVZVd0luUVYzY25Ibmdya05rMzE1RXU2aHQ0blZRR052?=
 =?utf-8?B?aHpzMGIvc3JOQ1NRaEI0RlFCU1RDUytwSkpzdTZiK1pYRjhxWlFSNEtxQWVS?=
 =?utf-8?B?b2JhRzFMc2hDeUVXUUkwNXJhUHFsbTExUFhxK0ZZOVlsc0tnVVoxQmZUM2pG?=
 =?utf-8?B?YUhoeHcvTUd4UFJ4UlBNZExaMUpGbG9nT0FXUEhJb2JiMFNHR3dEKy9FcEcw?=
 =?utf-8?B?emlOdGplVkxTVFBmWVNhaHV4MUJBM25uV1NKZGl6RGZuem1WK0JGQVlWNlhr?=
 =?utf-8?B?eHBhVzM5QzN1enp2WXlGNml3bDBvRVU3TU5idEdTSUdqekZmdTNuTGkyVUxk?=
 =?utf-8?B?dEkraXUxd0RubzA0NnJ6ZHBjZE8xRkthTUVPYjU2YU5QZCt5dXJKbWp1eUZK?=
 =?utf-8?B?c1VZWk9rY25yeEp3SVYyUklkMThicENvb1d5SzdHMlpKL3lqUzUxV3VsOThL?=
 =?utf-8?B?YjZPampraEM1SkNzaG0yUWxsUTZaT0diRkE1NFhsbGMrTi9pYTQ4b1pmbDVF?=
 =?utf-8?B?TFI3U2Y3WGtMeW0zQ09SMDdhRnJnWkduMit1eTY4eWdsMjk1WWxFY0hlRkU5?=
 =?utf-8?B?Ly9TZ1VIeHhKQzZPNTdJQUlXNU9wQnlHd1pqclZUanV4c2EyYXlLclhCRXgr?=
 =?utf-8?B?bWJPNHBiQU1VeW5tNVhJTDhNeXJDc3hJa2RBbElsc0JZUHpPVGh2WG5RYnFR?=
 =?utf-8?B?dkNSL1o5NFUwT1RqWXcvdDQwUlFNT1phSXViay8wTUlpS2FxWE9kSE5QUmUz?=
 =?utf-8?B?cnVvZjh4MUd3SkdMSjlCb2ZTdDBEd3BrSzdSWUJHTzFGbUZVbTlya1FBQmFU?=
 =?utf-8?B?dzBhdGtkc0RGRTU3VGt1djVyZ3Y3Sk1LYmJXb3JsY1BuOXJRSUNHcUlUZllU?=
 =?utf-8?B?VmFDS3ZjWFJjTlFhNDRubGwvNUErWHM2NDhTSHhOUExqQllTUy9tRGRkcFVQ?=
 =?utf-8?B?TjdkaUl1b0VaSzBhdU0wR3N4QkQvdHNpRS96RXYrNGlFdzlNQUh4RG1RMHR5?=
 =?utf-8?B?b015TVFYdlZWTVA2eVJpVndsNlY1aDZubEV6S0loUW8zSzVqWUNrTy96WGhl?=
 =?utf-8?B?SVlLenk4WU9Sclg0cEltTmExcXgzM0RlVWlVdzBvdlNPeUtldHhNa1lKMXBR?=
 =?utf-8?B?V2JuQ2JvSXFUVnJWREFrQ3ROSVFBK0hpODhrcDZDckxhMzMvbFZvdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5623f523-1239-4de8-3896-08df2b861f26
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:05:15.9881 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjoVOPyLUe4IqbFEtaQtGqDIl1SkNiR/A6J1SZoRaAcU/5WWKBvbOgG5+lJgeLbPxTjYVYO2EhEih6jZWJuaqzlP2LRquaCcpMHwTfVLwao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Shigeaki Asai,

On 10/10/26 3:32 AM, Shigeaki Asai wrote:
> The RK818 has nine LDOs, but rk818_ldo[] only describes eight, so
> LDO_REG9 indexes past the end of the table. Its voltage reads back as
> garbage and it cannot be enabled or set.
> 
> Unlike LDO1-8, LDO9 is switched from the DCDC enable and sleep
> registers (bit 5), and its voltage selector lives in
> BOOST_LDO9_ON_VSEL/SLP_VSEL with the usual 1.8-3.4V, 100mV range.
> 
> Add the table entry and handle LDO9 in the enable and suspend enable
> helpers.
> 
> This patch was written with the help of Claude (claude-opus-5-5).
> 
> Signed-off-by: Shigeaki Asai <y-asai.0816@docomonet.jp>
> ---
>   drivers/power/regulator/rk8xx.c | 46 ++++++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/power/regulator/rk8xx.c b/drivers/power/regulator/rk8xx.c
> index 88453bb7bdb..cb402c96ec8 100644
> --- a/drivers/power/regulator/rk8xx.c
> +++ b/drivers/power/regulator/rk8xx.c
> @@ -60,6 +60,8 @@
>   #define RK818_BUCK4_VSEL_MASK		0x1f
>   #define RK818_LDO_VSEL_MASK		0x1f
>   #define RK818_LDO3_ON_VSEL_MASK	0xf
> +/* LDO9 is switched from REG_DCDC_EN and REG_SLEEP_SET_OFF1 */
> +#define RK818_LDO9_EN_MASK		BIT(5)
>   #define RK818_BOOST_ON_VSEL_MASK	0xe0
>   #define RK818_USB_ILIM_SEL_MASK		0x0f
>   #define RK818_USB_CHG_SD_VSEL_MASK	0x70
> @@ -297,6 +299,8 @@ static const struct rk8xx_reg_info rk818_ldo[] = {
>   	{  800000, 100000, REG_LDO6_ON_VSEL, REG_LDO6_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
>   	{  800000, 100000, REG_LDO7_ON_VSEL, REG_LDO7_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
>   	{ 1800000, 100000, REG_LDO8_ON_VSEL, REG_LDO8_SLP_VSEL, NA, RK818_LDO_VSEL_MASK, },
> +	{ 1800000, 100000, REG_BOOST_LDO9_ON_VSEL, REG_BOOST_LDO9_SLP_VSEL, NA,
> +	  RK818_LDO_VSEL_MASK, },

Please stay consistent with the rest of the file where we have 
everything on the same line.

>   };
>   #endif
>   
> @@ -695,8 +699,13 @@ static int _ldo_get_enable(struct udevice *pmic, int ldo)
>   		break;
>   	case RK808_ID:
>   	case RK818_ID:
> -		mask = 1 << ldo;
> -		ret = pmic_reg_read(pmic, REG_LDO_EN);
> +		if (priv->variant == RK818_ID && ldo == 8) {
> +			mask = RK818_LDO9_EN_MASK;
> +			ret = pmic_reg_read(pmic, REG_DCDC_EN);
> +		} else {
> +			mask = 1 << ldo;
> +			ret = pmic_reg_read(pmic, REG_LDO_EN);
> +		}

This is not great, I would prefer to have some additional configuration 
in rk8xx_reg_info instead, but since we do it for many other cases 
already, nothing for you to do on this issue in this patch.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

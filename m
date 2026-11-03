Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D443606A324
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W1Y8AkKr;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mmWUGXEr
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38D0080E21;
	Tue,  3 Nov 2026 07:02:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Fn5eYCxfBIQx; Tue,  3 Nov 2026 07:02:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6CDDC80E0B
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793689372;
	b=XRMlTlEy8LoLelFGFqYY6JMX0fQX6VGRmvWS61NsBZF9qFGPkrQcmzwQQipzSqnSYlrq
	 f+hZWPDBuBGXD1iw1Co+T16UQI6RFmOF4uyEMbscqGT3Qbtw8MtlM8p0XDjIEjHDfgSSj
	 6EcoeotII0JhajLZxdko/lrDyhZPX1lrEGmKmuKP1BMQILThrdoW03Mt1O/nb8k/K0NaC
	 8xRc8ylE3ImatJm80QOwqFlvz7vk4Gr0K7KKQdwZ7hiovPhSssrt2wa1xerFZeY+zydrj
	 1IkyQlyfkgRvD/7k72wnlGOzxi4RNolu0PbyjjhH0oD9iNF9GMM/n1JPqkLo0BeZjVw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793689372;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 From:To:Cc:References:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=q9c6LYUUKtZMas7JwAKsCy9RcfLH3wFL1CCKjC5tHqs=;
	b=LH4dUxbFVMUHLxBzwCSRrNGF8DsCEVOmC5pspTYajfHHkco3aCrN+/GnnD6I1sYUs9Nl
	 7DgvNFPECtG/ONaG2tebjEVSr/q5/JLGg2pR8eg1IPVdOVciDEEEo8oUlj9AoP4u6AP7W
	 qsLJ19crQN2x40lrGc7ZQOZUx4frMklPWUpZIS2ea1Ry5zwnhwTdrxtYPYxNi2uXF+Myd
	 KmK5bKIpxICAKYznqzvazedCsEL/55qBjmE5VjWwcLVtNqdCF65Zx+fcqUCboSfg0fxLD
	 67F6WyAZlPi23L7ADs1Ws2DlknusPOd4PKtD80vGU8RBVk4robpUN+qrfEyoUMtxn8g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793689372;
	bh=q9c6LYUUKtZMas7JwAKsCy9RcfLH3wFL1CCKjC5tHqs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W1Y8AkKrDki9/iqQ0oEigV/xHwiwATkTsuUkXUbTiGfxcnhZxyYqlFlQBsUT9fqAP
	 Uj6AZ4OplZ7c20sRUtOJAHvUfOxfe/L7jhrCHio4gTJp72Fkzz6ehyQ/nj4pvPQz6l
	 4EM3ZrJjRhXHLrntKRXoYst2OvvVRCYA65pCEy5lvseB2c7H6yky9y/ALD2tdOQZCb
	 QINgmpCPz7zL2cgtKL7gRuIPxSJslLAbfE1KQXfCaHtsv6dL/0Z3TW7X+AXUaHsLMN
	 Dn6jFOnICaR/9f5CX2Pe0bxKSj9GvMhzVDC3ykUw5wJyR4tgU+ZO+gxjn9rm/+g6hP
	 qn6ZracPVDcjw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CDDC80E0B;
	Tue,  3 Nov 2026 07:02:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C8C82411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B896A40589
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bWJYXR3lAFYd for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 07:02:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DC0EE4054A
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793689370;
 b=Vnf277QVs+9XvQnY8+MwIe5N0xQUtFwVC1THVd5eLRtEQO7NE1hSL9X273MgYpUfohP3
 zPwuQbBIN9udtKFrkR/gNfEOOXizTprVggtllXL2GO6oYWW3H54wlLg9/IR4EeSw2GfJ9
 Aw3TY9b2B9afQJ/8i6f404qnnmUEp5OnEw1OHlvCWSnEbO3DliBKV0m6ZoaL079tr6agg
 YYMe3O1xpPUIdSohj/24fefVBP01Fiisw3URV68p/veIGvSjNI+o8TvbInTgFGcmn5mVA
 hxAn/dssmsZTSqRVhj8m/9Ny+JEzKX1MICGeiMHmakNyAcmsyCIvdgGnCTOI0/o66Xw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793689370;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:From:To:Cc:References:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=q9c6LYUUKtZMas7JwAKsCy9RcfLH3wFL1CCKjC5tHqs=;
 b=oalYNqWk1FolaKWC56rYYYPY0LbxNCwtUCT+0QLvoJLii0vMvjmt9T4N4em52ZsKIIYc
 5477XUw61/5vCDhp0oYsKBjrRR2+u8GIFRbqifyBMvVrHVgcw55kN9AaYKBYuunjOxx0G
 DVyyTAlP9DS+T7qXeFYF4Q3yes3W0x8qnA1SobFGUifn30/BQoXrqMuaRCvP1iGZdQUzL
 GaLN4AJPCUK1NPi7qfZiqSe2Yca7nXmax3dAI58dx7t23cZ7i099pOSQ9OwuLSS50RR+5
 rr6K57dfQDKBVRzW12I4BB1tWGcwLZmkNG9dwjUkWiMzjTHec9uHg/QXUmRASZ4dQhA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mmWUGXEr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mmWUGXEr
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DC0EE4054A
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 07:02:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OX55wyBwDPDyTPGIGzlW+bW3oKxXSMpUL7Z1zqXINA2IYFgI97mIa76bMx/NJK4oqMPGkqUAXsATRemAnLYnx4kGJCvixCtp4aBpdvIH6tvfVdFArsfp84YyQNOCtfuYbpgpUf7jdhXMyZ+zlS3XA0OW93696odiWz+5f9nmZafPfRJqXMCjJOXCZUriPscBSQZifhFrBxypxUAxDjjXwQs1olcUrPyKnFvQ2y9s2ru8pdKf2fyGJd672FvCov+ipq35H8MEnovw1lDeS7FIVjDi8TTKbwKQV0lhLOHB5KiUrJiGrkBHsQJxRcIw65UN/3iL0Rttt47WVmyDWCDJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9c6LYUUKtZMas7JwAKsCy9RcfLH3wFL1CCKjC5tHqs=;
 b=cinf3gLhgA+ANJtVdB897dknzIRdGCSsE49l1KQxsCnEWb3l2zk7SFh57mUCM7FGbv7uhTxzfJqMR860wI8Xw4LFC9mVBC3hUs9kdF4C4/YunJRBj6WE03TdD+elyo60MOaTp9XzOgyaD9uJFL37XKTd79An+P3FezxUrmR4Ft1g+70XMsUGPYkciLYYgxgHqiqzfMC0Snagm0LXYqh8hc3FLhfcZt4zghNDzxrfXrPX8sNKadmY9TrHZGXRmyZ0zwcn8UeGFkMmp6DA1nnX2PJVmzSDTPx3BsBiwGD9f5TN2ZOjT4OT7CoXPoJ9kxTiNyC8j0pbvSaNduwL6NyxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9c6LYUUKtZMas7JwAKsCy9RcfLH3wFL1CCKjC5tHqs=;
 b=mmWUGXEr4LXgHo82Ee8t0tYQFcm7CR9Kg50u9kuMl2+QSrJBcYYw/4kWn1EegCbdaLPuhOg1P3CysB7VaGk4ozXemlmtw8zuF7VRKp/HgYCYCCck6AVHMvsCbXbD0fxT8StIJ94eom0T11PjQIh88+aeolX+5QF8EF98bAY6S60=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by CH3PR12MB347562.namprd12.prod.outlook.com (2603:10b6:610:367::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 07:02:46 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 07:02:46 +0000
Message-ID: <804a386d-1fb7-4055-828f-84514cfa3a6a@amd.com>
Date: Tue, 3 Nov 2026 08:02:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: zynqmp: Add post-init provider for USB424
 USB3 hub
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.u-boot-project.org, git@amd.com
Cc: Shaikh Mohammed Suhan <suhan.sm@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Tom Rini <trini@konsulko.com>
References: <336b15141bb982a7db19721b81b95a4a9bb7513a.1792507199.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <336b15141bb982a7db19721b81b95a4a9bb7513a.1792507199.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0169.namprd03.prod.outlook.com
 (2603:10b6:a03:338::24) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|CH3PR12MB347562:EE_
X-MS-Office365-Filtering-Correlation-Id: f0d48f4c-952a-4354-267a-08df397876a2
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261102123227099003|11063799006|261009223027099003|261028144727099003|261026140227099003|261021123027099003|56012099006|261021121427099003|261022075727099003|261022105027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jE2IdxoNjugPplwNw8AMz4UhymAcz8w6wA9O5uH2nBXqNg2RK8udPUb4nw+uUHsB3yssk5sih2WUPDi4nr/th5YkgrkiB5l3pF7W1RLrPAZw3Bbuv3ZM9Asx4VT4KEa2714cG5V2UlNRu+K6hLBnZq/08QENXrbxRRuzFNUupUaFpPiZL+174/EsQBfUn0QWn2HA6A10Uz6z+yuv4UtjMA3y+nwD8aQierAoWc6iXv53jBSKF00RFti2SGI0jnI2bv68rE7YCkVLpWDI6y68DxCrwFkkLp+qB9JSYn/VKfmGeQw5+WXFgGS8qSK7wSNEdqgnCe15OGc94luHZJLcidExWFcVJoesrVFr09M7iqKXI5rRTV/4RR/Cd5yufW/fMYSGcESKX7S2au0p4Ns5fbKIqWPYHpPGSQb29r6F9MskGtpIdJEE1L8zXsy9+Eu4hJ8Mo7VI4cU/sOeUDhlhbZpXrMg2coDl/cbzHhBftIx+1m3PfYQN0ZmqY1bPupXnKM/E/IfQaG5nyiDunyNyJs5tyk94jIIcDEVc/dPEkPXIvL8NoTDWZJs/APNJl3BKXlY0/wOXcA5F5f65IFTfO5bnYoaH4GXDyVh3PcIWim2PprG5JeOEpdUcHnAI+w1Zama4yGccC9atLWjx+hUGJeTh+TUiec2geyfi2EEiNwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261102123227099003)(11063799006)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(56012099006)(261021121427099003)(261022075727099003)(261022105027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bktXNUJwRFBGWENCM0ljSWYrVlFjMXRpSmxMNm13RHhkSHJraUZyWkFMYTQr?=
 =?utf-8?B?Tm56UVZHcVB6UWtYdXkrTlF4bEt6LzdZaTlVc3Zya2NzcVNxZmZ1dWcrOVEx?=
 =?utf-8?B?UlJma3dWYmRJaTFvWXZ2Tm1qRyswYlBUbGxaNTMvNit3SEVTQ0xCT1dLS2Ex?=
 =?utf-8?B?amZFWWdIbE1RM3VlV1JsWDhXVnRySTVqVUQ3eHczTktrbU1TTDFLdmsyVmhG?=
 =?utf-8?B?cXY3SWczRGNRMVpzTXNIYW1IUkZKN21aUDBtSmEvOS9zL0ZOemhsb05tL2U4?=
 =?utf-8?B?QUltVjc1QzlWaG1TN1pJa2lGeWFsL1VSSFpFZ2djT0JsV3BnY0wyK1RYVGdm?=
 =?utf-8?B?dzBaOURxZy9YbFNQV2paekJQVVZJdks4Rk5LNldUZmZnTHdkdjlCNWJEWXhZ?=
 =?utf-8?B?T1QwT21HTkZDZXI4M2t2SzFiaWJaZnRjaWdjNVp3a3lsOUQ5dDJxY2RGUFZ0?=
 =?utf-8?B?QmdhY0pXTzNUTEIvNUNoOTFqNGpxY28wSVlCVU9IYVBxdGlzSTd5YUkycnE5?=
 =?utf-8?B?Y1VBN3BEQTZNV2RPSTNjYkVEaWRpSXVGOXgyQ0haMmdCam5VdENxd0d3UGNk?=
 =?utf-8?B?RjlVYytTQ1RFdGREV0dSOGtMc1ZWbEFqLzEzN2prSDZxVm14c3c5RHQyekJW?=
 =?utf-8?B?czlKbk54cmt0ZlBwMFVhRnAxRGZCcE54Tm91cGJsaFJXL0NmVEo1UUNuZE5n?=
 =?utf-8?B?azRNZ2V4dHMrdXFHUTZYTmN1YzlDYnh6UU81cnNVdkZwYUx6R0xzc0ZxcEdk?=
 =?utf-8?B?a2VMaXNsVEVsRFhvWVRQNjFPWHJVZUJmZGhkMUJRQmJnNjZ6aGRYRUNjeDVE?=
 =?utf-8?B?WGZQMklhY0o3YlZKWGhjWmRuWHE1UXZXN0FkOUtKNU1raVJTbWhrSXoxT2tM?=
 =?utf-8?B?TjRJZXpValZybWl1aGl3VE1pOEtBOE1hWDZud1JtY1NtNHJtUis4TWdMOHg0?=
 =?utf-8?B?Yld0SjFoeWtxa01KNE93eWM5aGY1amIwZmRoV1VPd1p0V0JyZGx1eEFxUzk2?=
 =?utf-8?B?Z2t1SWtsWEI5b21VcHhrOVpTOU04NE1SQWVqVzVtWU1WN3k1WnVIREdTT1E3?=
 =?utf-8?B?U2kxS2dlUWg5K1ZUM0pLRmcwbHBzU3RUMm5zVVRxNVpvRzZTejF3Mkc0d04v?=
 =?utf-8?B?NVo4ZVBtaktrbGRqRTNET0VQd1lZb3diNWhRRlpzaDJGMWtld3duRVdiV0R3?=
 =?utf-8?B?Vmd2NDFlZktsd01sNXZ1LzZ1S3g4by9RMDE2SGpDSXFHZjZRdXBYdHNEZ2Uv?=
 =?utf-8?B?VVdvMk1iNUpKdzZNdFZUYzlEZTZ4bGRud29rbFpaeHpqekhWT2xuWkJvcFBT?=
 =?utf-8?B?b0Mrck9XTEhyb2ZPZHRoYzJBRk9DWVlvYjVDaXpoaVRHOHF6NUtEdlg2NjVW?=
 =?utf-8?B?dTRObGNyYUJjazBFem5rQ0ZaYkZ1elhQbC9MSGlUdExPOUlSbzFuWk1HM3pl?=
 =?utf-8?B?azQ2ZnIybWc4RFRyMTVoNEI4OWlmVjJjSFY3WUFHRXQ2TlB2Q2Y0L01vQTVG?=
 =?utf-8?B?a1VJbHJBYjRodS81N2w4cERIYmVQNE0xTkh2ajduZy9PM1VTNTFtR0N1Zmlr?=
 =?utf-8?B?dmF1MmlSbXRQVHpGV3BVOTFzcGUxNWtOcmlVUm1IdHg4c1NZcUZmcSt0VVBP?=
 =?utf-8?B?WnFwNzZzTXJ2VE5HcmFoRlNVcEs1UjBod0JlOWo1OTRlOTBuU1RQcFUxa2JY?=
 =?utf-8?B?TVl3OEI1cFFmcGJsVnhRNmVEQ1lFc2I2amhaanY4OWIwODV2R1c4cUJQcGM4?=
 =?utf-8?B?UmdyRFNRQnBaWEtpakxMcmRNZmdGRE9UblBCeFB5cG1MQ3NScitNd0RTa1dw?=
 =?utf-8?B?L1lQM2R0UFBqbHQzaXBWaHZ4dzZPbldFalB5dXJBdDRWZHQzTitxMWE3NnRI?=
 =?utf-8?B?TFVWaGY2cngxZEVydUhCZXpXSmYwbFBMTjNVZEEwdmJoTFVsM3pmYmY3WUVh?=
 =?utf-8?B?OHBzekcyYmVkaURJRkRPODZNYlNKWlZGUWg3VCt4K1BLSzJraUZIWXdqYXdH?=
 =?utf-8?B?eTNIWW9CbktGYXNQV0RzQi9YUWI0aXA5TzhjdjFZS04wcGFMd2NLUkVzeFl6?=
 =?utf-8?B?V2NUeEJqZEtFdWZRR09SYk9qNlVlR2V5dDNCdjEyaCtKbWdxZGZOUEorUE5v?=
 =?utf-8?B?Uk5naWh4OEE5d0YwQVZTWG9QOEFsWnFDUG80RktoaGJyYmN3ZGNRK1pGV1lM?=
 =?utf-8?B?dXF0ZndLRzlQMkJiM2VJd3BCRDRmOGIybzNrZUxaUHVza1hLbXJvOUtUa2Zm?=
 =?utf-8?B?R3BmS0lkNDZZU1hwM0xxdWFaVE1XTXlnRHAzczJIcCtVRHBsNTAxcU1JdGVz?=
 =?utf-8?B?ZG1QYWdoVWpoRkQxY04vS3VOZjRqMUxvb1h6V0QzQzFzaGI3V0hOQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d48f4c-952a-4354-267a-08df397876a2
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 07:02:46.0366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1p31ns8yd7JPw0txHw+w6fcZsgSHzD0boSgP6GOO43uRPBA6hzYppinBuJxAXKEM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB347562
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/20/26 16:40, Michal Simek wrote:
> From: Shaikh Mohammed Suhan <suhan.sm@amd.com>
> 
> The Microchip USB424 hub is represented by two peer DT nodes corresponding to
> its USB 2.0 and USB 3.0 interfaces.
> 
> Both interfaces share a common reset provider through the enable-delay
> device. During fw_devlink dependency resolution, the USB 3.0 hub peer
> may not establish the supplier relationship correctly, resulting in a
> device-link creation warning.
> 
> Retain the reset dependency on the USB 3.0 hub node and add enable-delay
> as a post-init provider so that the shared reset dependency is explicitly
> represented for both peer hub nodes.
> 
> Signed-off-by: Shaikh Mohammed Suhan <suhan.sm@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 1 +
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 1 +
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 1 +
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 1 +
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 1 +
>   5 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index a32073fa0404..ba5d761805a7 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -152,6 +152,7 @@
>   		peer-hub = <&hub_2_0>;
>   		i2c-bus = <&hub>;
>   		reset-gpios = <&slg_delay 0 10000 10000>;
> +		post-init-providers = <&slg_delay>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 31b3c3582c27..3a47beb9f995 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -225,6 +225,7 @@
>   		peer-hub = <&hub_2_0>;
>   		i2c-bus = <&hub_1>;
>   		reset-gpios = <&slg_delay 0 10000 10000>;
> +		post-init-providers = <&slg_delay>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index f1114a35aaef..ddcee42ffbfd 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -225,6 +225,7 @@
>   		peer-hub = <&hub_2_0>;
>   		i2c-bus = <&hub_1>;
>   		reset-gpios = <&slg_delay 0 10000 10000>;
> +		post-init-providers = <&slg_delay>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index 967548744d5e..45396e420433 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -197,6 +197,7 @@
>   		reg = <2>;
>   		peer-hub = <&hub_2_0>;
>   		reset-gpios = <&slg_delay 0 10000 10000>;
> +		post-init-providers = <&slg_delay>;
>   	};
>   };
>   
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 0fa5a990adc8..22faec35f793 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -185,6 +185,7 @@
>   		peer-hub = <&hub_2_0>;
>   		i2c-bus = <&hub>;
>   		reset-gpios = <&slg_delay 0 10000 10000>;
> +		post-init-providers = <&slg_delay>;
>   	};
>   };
>   
> ---
> 

Applied.
M

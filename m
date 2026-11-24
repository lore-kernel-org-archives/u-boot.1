Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E7606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Z8ZOXRHm;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KD4WKtIS
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C4D580BD2;
	Tue, 24 Nov 2026 07:03:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nN44vPQxEyk1; Tue, 24 Nov 2026 07:03:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org AA23C80BB2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795503830;
	b=LMDeP1ujvoYVxhGBWRNUgiFNPR6BTZCwEc4vMZmJ2d9xFSKXFnjm8hpVHsSoeXtsaIIG
	 8EZAJQi672mu65AR4MheJnKjUm0l2CU81cy+5q20vEYqC2hw1f4MGay6B1QbB5x8qXrB3
	 pawhaoUjkP/oitJ2BBQKcBt5vGShbsU3+yV8EGWe6KVvegRvrHH55eGQ5kKmNbW2xKXpi
	 QJ+2jjlo+QRznAyT8c7c/Ohjyb9F77q6BbqVdA2BBnBddugKuTpv7L8tT+bRBmItcaOWK
	 VZb92PzQ4KvFpRodk7W2Bo+IIxJLk/cymq1Tw5HEW/Jl7Govyj1cnoaYI1DSCDPqlLg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795503830;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:Autocrypt:In-Reply-To:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qyG0VilaYPeeeZjIwzD5MUqtV3J8bG9JomaR9Ih85rk=;
	b=k3TTI2xVvBTuBD0gT0cFUVAfXJuYvUjC1gpGzVMAWfLMBptdX5VLrbTOwCkaWPPIZqpS
	 7m82jFuDAyhUzqv2xQHbrwQ0Z+hd/MJzjQV/gWYwrHSOtaXBPTUC2lUZdpOmEY9f2Rbz5
	 /xac98YvyXKdAzJd+RXqCabVif3E+8uUahRZFEey59QvETp1wt8mZqTyUT8SKCpzArgq9
	 8CwEGKk2WCU/VVIwndPUxUqiFJIlv9PSKNWOSBA1g0j82+K9m1dl2nGe2G0ARIEQBdSTT
	 IJs8weVO/u+T+umFF3xohTo5lFaMhlawegTT0/oX0i/qNBvYaaevZ3io+41xcLi2SKg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=KD4WKtIS;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795503830;
	bh=qyG0VilaYPeeeZjIwzD5MUqtV3J8bG9JomaR9Ih85rk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8ZOXRHmWDwGnjB+603IfPGf8+zO9WS7YqkHhnMyZNwejLC0MYHzzzjFjRPqT7HSo
	 7Zg3Db0mkIeYTCUaos0Fmi6gkTNKbrlo+AJipz6FOZ4MbiREL6s9xvuF1wfAdV2hEP
	 ZI3hSJ+1YvvMpi+W+zL+x9RDB6bDykaJzauIvcl63YPlND9MNQYlqVWnhCnbJ2kC6q
	 tbgCvvAxeZ0uMgmJ2EMx2C2uan9BTjNx4hG5pIJqngyHSUUAlu6k2xBfp7s8TMSeaj
	 eIh0iYP5v2yBWZfXe185gGkrRk8MANDgcaCd1FACtzSmgX74Jb33ylPfQ97Ovfsbd1
	 S1tEsdKJG4KJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AA23C80BB2;
	Tue, 24 Nov 2026 07:03:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id DF8E6260
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:03:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B010C80B9D
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:03:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pQnGhTYPF8_N for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 07:03:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9633880BB2
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c112::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=KD4WKtIS
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9633880BB2
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qyG0VilaYPeeeZjIwzD5MUqtV3J8bG9JomaR9Ih85rk=;
 b=KD4WKtISX9liHhNsdRflqGKZFCs62gNImgqVUrcp4Hi+ZZpE0t4GbPVb1yidxLWe/kG5Ekhm3p2VaGngEpUnJrVj1w8zgHDqWrnAOXQ9alY5aLgOPECSRVTFYByVZ/1QrCAKus+Gp0vd5yjJg4wsMo2AU4ZimwNgSbcWVwcrJFg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PR12MB052986.namprd12.prod.outlook.com (2603:10b6:8:47e::11)
 by CH2PR12MB4151.namprd12.prod.outlook.com (2603:10b6:610:78::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Tue, 24 Nov
 2026 07:03:44 +0000
Received: from DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48]) by DS5PR12MB052986.namprd12.prod.outlook.com
 ([fe80::4e51:5777:a687:af48%3]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 07:03:44 +0000
Message-ID: <6a8fc6bf-c382-41f0-b913-05337581d5c6@amd.com>
Date: Tue, 24 Nov 2026 08:03:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: onboard-hub: add vdda support for Microchip
 USB2514
To: Marek Vasut <marek.vasut@mailbox.org>,
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Alexey Charkov <alchark@flipper.net>
References: <20261119-usb-onboard-hub-v1-0-22aa6ef1d9c8@foss.st.com>
 <20261119-usb-onboard-hub-v1-2-22aa6ef1d9c8@foss.st.com>
 <6aeb57ac-6b63-4593-ab3f-c927fb3c51f8@mailbox.org>
 <562c2c54-d943-477f-b9ab-2cbe6f1b34b3@foss.st.com>
 <afce74bd-8bdb-457a-b2a8-31f5211b0a7e@mailbox.org>
 <913b5977-84e8-47a6-96a5-1508b47bd393@foss.st.com>
 <74452141-55e8-4cde-9e0d-0a3128ad48c6@mailbox.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <74452141-55e8-4cde-9e0d-0a3128ad48c6@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::33) To DS5PR12MB052986.namprd12.prod.outlook.com
 (2603:10b6:8:47e::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PR12MB052986:EE_|CH2PR12MB4151:EE_
X-MS-Office365-Filtering-Correlation-Id: 5801cfc3-4d11-4ee3-9a6b-08df49f9140a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|18002099003|22082099003|261028144727099003|11063799006|56012099006|4143699003|261022105027099003|261026121527099003|261026140227099003|261021121427099003|261009223027099003|261021123027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: tv79c8G5TcFHW5CSQzldAW+uvimnNV5J5hgBBnQs9MFHnIBv2ygMzqifPo4l5xfNcx2dBJTWTb6bAP/h3Yt2rXHX6fF/YXZpqDAE+W8tpPoHW0zvUnlK43STJII0BjTX4qgycoLjga+PrXLe4D5axt/Jbv1LzptxgHsRkaWFgy2hwqWxzSSL5bjor+BqBwV4EEpbC/GIS66K6KF7pWS+ereFSyipDq1KEvRoHHUjrLOpvsO+9+ejvHz0oR1IxrSzMf7SWEIUKDcUDCTgU8PJlE/jGKfEkxrukC8MeYDtcjX2lsH/q4NZ7fs+u1EbriYjmx/CmSToekzl/QMYCxyhvgh0ea/mhefag7doqhp2v5DwmmuhKeaH1yNsxwVy53uFJpob0NYq4ZM00WMq/N7mWvIQCaN0U3wyYTWgaWHWXsUClKdNk8r34c1HyAGPqawTL3TQpIUR2e4baEF6ypAu/zrY8pRnkj5x47lL87ETy0AIC1e6oIunKtfPM8lQBdCaIBaebMCyuoxH9ShQ45fFmPqwO65NMNt1xsB6FZC9cG97EX0ntc6GpS94UxfsMyXKa4fAQ1N8V0g2k1nfNDdOcVcIVjPoY5coYLxfSvm/Khg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PR12MB052986.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(18002099003)(22082099003)(261028144727099003)(11063799006)(56012099006)(4143699003)(261022105027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmFRYlE2VXlpV1RiUEVYVy9YZ2hrYVIxdHVzZ2Qzb28zVGpzV3A5U0FnYUNh?=
 =?utf-8?B?ajhQM3c4amZwclE1MU42Y2tDQ2FIRVBTbGhxaTRDRDlhcmtBL2hBSG9tYXZ0?=
 =?utf-8?B?Q051NlBwblJpdFZ3eVh5blM1TGwvZFA5Z1I5Q0Z5UmhOaExjVE9YU2ZPaWdt?=
 =?utf-8?B?ZEl3bnlZQ1hhVGFUR0tCbFJNbWVOWW13dFZ6MmF2Z1hHTTB3T21TeUJubEtz?=
 =?utf-8?B?Zys3MUp2VkRwcjgzTjNEK0xVQ3NTSWxKSEtNUGZQV3dKaDhBdVQ5NFBaeUR0?=
 =?utf-8?B?dzBJM0NsaTk4OEI3WXNUMjVlSnZSQ2ZaUGhCMUk1czNDK0V3WFFxOGlXYVRz?=
 =?utf-8?B?UU5STDV0dUhod3BHMyszK2Erb0o5UG1CbkN3UXJjbTlWaFBEOFpxYXYxTk9w?=
 =?utf-8?B?dkZCSllPMXhXSzc0NnVmU1loOURCRmNyblZ3cUpReG5zMk1JNzJPbzN4MmIv?=
 =?utf-8?B?SmdYbFFwREJKb1hETldqai9LdFQvbWRLdUROV3RNZjk5WG9NcjRiOGx3a3N3?=
 =?utf-8?B?Slg0UGxMRzRDaHcwSE1nTlF3MU13UDB3WG9kZURSWGVaN3g1eHU5QmRNcy9a?=
 =?utf-8?B?TzQycmM3R3hYcVpKZ2E2Qy8zTlB5bnRvS09KUFZwWFhYYjJST2IvdVhsQzJH?=
 =?utf-8?B?UTJnM3dwWEs3YnAxYUM3dEs5NU1DVmxWU2RDMDRiMkpzQytSRTRXUy9neHQw?=
 =?utf-8?B?RDJWSW1ySUZIcW5RU2swaU5rQ0dBS3Q2bVBIQVJtTGt2REhiUlRqWXFaSXpT?=
 =?utf-8?B?VmNjVEEwSTIrd0JiUkF5NXJxV0VMOENnemFSTUJINW1KbUJNVHczNG52OUhN?=
 =?utf-8?B?bmk5Z3ozOWQ2OFh1RlNUSC92LzhML2YvenZNVWxEdFNTbVBETlU4MC9vdFVK?=
 =?utf-8?B?SGhtNG5udlp0TTdLMitoQWgyaElMVzU5dVRyNFMxQUk3UFhHZXA5dkE5RU1x?=
 =?utf-8?B?RzFrdS9BMWVsdVMzZ1FIMndNWTlabEo4SFNFa2RxdXc2d2svaFNxMTdkQW9Z?=
 =?utf-8?B?VVdlcFZ3QzFTaEhVTFV1bWsyVW1qL2Fvams5WTRZd0ozKy81dGFLRXRNUEVl?=
 =?utf-8?B?T3dmeXpyczhVUXA4RjRjRmhmZEFXaUxGaDcyYjM2WG9QNFJqT2hyN3hmMkI0?=
 =?utf-8?B?MVpkRExQeUZ4TmdNSFM0WFVIRk91OStZcFdBR1IvMUR0Qm9qM3RrbjFUVFZv?=
 =?utf-8?B?WkV2dVIyNEhVTzZreTFuWFRqZ2VJOC9XWGZ2N3plRWYxZXRyS3NrRUNVWjM4?=
 =?utf-8?B?Z1ZWVHR3Um8rb2dBWE9ZTUZjN2g0WlExMVgxbUZIVjI0QXo1MHQyTG9obkZX?=
 =?utf-8?B?cCtGRm9XYStkZXZUY1F5MmV0dm1wQzNteng1cnVlWmdFSUl0VDNzRGowaTFL?=
 =?utf-8?B?MFBOMlFBMVVOV091MjAraHlLT01KUUZxZnY3c0pWNGtrSXpza3pMSTN0aTNX?=
 =?utf-8?B?UDdCMlRseXlYb0plVW83YlcwczJyeERJTjN0VmR1blVIR0QvcFBDMUplQXoz?=
 =?utf-8?B?cTIrUVovdHlTdXNrU1c3ZFcvM0syeG9wUzZRZXlqQS9SWmZMckorTndpQ2dj?=
 =?utf-8?B?Rms5Y3NHcm9XdUcwbDZDbWRqbWJ4U0grVnFHUTJsbmNEQ1NLNjNVVVZJSUxm?=
 =?utf-8?B?UWhGMVd4RnY1NnREN3pvVDRFZlpua1pPaTBTNVNaeXY1ZFZPRXAvSUZJbnpo?=
 =?utf-8?B?YWJ2TnRIOU5XMUlYZjFxb0tiTDBFRlhvZmtLc2FNeGl1Y1R1YTZUTHgrOUxU?=
 =?utf-8?B?Y3lvWVZTYjRNZjRsVzYrcmh2SWFDajZNcXplUDRmZHMraVZ0dGs0clAvd3Ex?=
 =?utf-8?B?RVp6TVZSM1VEVGZoaFhaNHQ1aU05d2FoUTR0NE4zNmpBb3lHbk1yZlhxOWVI?=
 =?utf-8?B?VHl6aXF6eFpaVnhzYk9GcmRrek9qaWRvR0orSE9tUTJVcFo4aWU3QUNrcWVJ?=
 =?utf-8?B?REpJSDFGOVM4ZXBIb3JMWHhGOFJXZDBGMlFERVhWd1hFcnhkeG5ZN2sxRUxH?=
 =?utf-8?B?WTU0SnA2bW5oaC9zZmdhVFFldENDUXczMU8yTUxaT2JRQmdjZTRzYmgvZGds?=
 =?utf-8?B?ZEFseGlITVl6QWwrNXRleWVJNXRudHBTRlZvTm5lRWs3SHV3RU9rZ1J1bTVV?=
 =?utf-8?B?Y2NmcjcybjBLYmtuc0pJN0E4ZkkzcHBhdVFabXJORlV5cE03bEYyZUVIbDRV?=
 =?utf-8?B?UDcrZVJDUzNKSjkwRUsyUW9SUnBib3paZGJGS1BGbTZDWW1uRmsrbkFieU1O?=
 =?utf-8?B?NzFYdlJhWStYNU5KOHU4aFhRSmkwVC92TnlBTm1lVS8yNWQzUDFnOUJMWlhB?=
 =?utf-8?B?RUVRUW5pT2g1dzVXeGNxUmlPaHZtalVBeXRMbmlJZlBIdkNXQUlLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5801cfc3-4d11-4ee3-9a6b-08df49f9140a
X-MS-Exchange-CrossTenant-AuthSource: DS5PR12MB052986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 07:03:44.2838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tc8YzKjaCmJR+Li+caH5CXvfbFqlapqGp3L8HAlp03qEife4wXncKdJG2NpaCSg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/23/26 17:17, Marek Vasut wrote:
> On 11/23/26 10:23 AM, Fabrice Gasnier wrote:
>> On 11/20/26 12:02, Marek Vasut wrote:
>>> On 11/20/26 9:24 AM, Fabrice Gasnier wrote:
>>>> On 11/19/26 13:14, Marek Vasut wrote:
>>>>> On 11/19/26 11:59 AM, Fabrice Gasnier wrote:
>>>>>> This hub is powered by digital and analog 3V3 power rails, so provide
>>>>>> the possibility to use different regulators for digital (vdd) and analog
>>>>>> (vdda) power rails.
>>>>>> This is inspired by the Linux driver [1]
>>>>>>
>>>>>> [1] https://lore.kernel.org/r/20250213094338.1611389-3- 
>>>>>> catalin.popescu@leica-geosystems.com
>>>>>>
>>>>>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>>>>> ---
>>>>>>     drivers/usb/common/usb_onboard_hub.c | 4 ++--
>>>>>>     1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/usb/common/usb_onboard_hub.c b/drivers/usb/common/ 
>>>>>> usb_onboard_hub.c
>>>>>> index 0c84c1fede03..4b96defc2d93 100644
>>>>>> --- a/drivers/usb/common/usb_onboard_hub.c
>>>>>> +++ b/drivers/usb/common/usb_onboard_hub.c
>>>>>> @@ -278,8 +278,8 @@ static const struct onboard_hub_data usb424_data = {
>>>>>>     static const struct onboard_hub_data usb2514_data = {
>>>>>>         .power_on_delay_us = 500,
>>>>>>         .reset_us = 1,
>>>>>> -    .num_supplies = 1,
>>>>>> -    .supply_names = { "vdd-supply" },
>>>>>> +    .num_supplies = 2,
>>>>>> +    .supply_names = { "vdd-supply", "vdda-supply" },
>>>>> Is this an ABI change and does this break existing users ?
>>>>
>>>> Hi Marek,
>>>>
>>>> I've tested with and without on stm32mp157c-ev1. There's no breakage on 
>>>> exiting DT.
>>> What about other DTs that are in U-Boot and possibly not OF_UPSTREAM ?
>>
>> Hi Marek,
>>
>> It looks like there are no users in U-Boot DTs that aren't OF_UPSTREAM, e.g. 
>> users seems to be in
>> dts/upstream. Some of the dts don't use supplies at all, some just define just 
>> vdd, some define both
>> vdd and vdda.
>>
>> 'vdda' regulator has been added to the dt-bindings, as optional. U-Boot 
>> usb_onboard_hub driver get
>> regulators as optional (e.g. check for ret != -ENOENT). So there should be no 
>> breakage here. Please
>> clarify if you see some case I could have missed here ?
> 
> All right. Can you please make sure this applies to usb/main ?
> 
> +CC Xilinx in case they want to chime in, else I'll pick this up.

No concern from my side.

Thanks,
Michal

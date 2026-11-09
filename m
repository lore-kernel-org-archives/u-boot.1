Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114D3606A332
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sOjEetMU;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=RSkjIsTP
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC59480DEE;
	Mon,  9 Nov 2026 17:02:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BhlBVDqTcF3n; Mon,  9 Nov 2026 17:02:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D55B81063
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794243722;
	b=mYgAuuP6CfXEDjV/1oaP3HWEi4oD8p9xaGpDk/YkGtypymg2ZfiBZOkrnOsTipKCXwdh
	 jT76qoMHFbq5aM1LxfAn8FzKH2+03ir5dlzAfUZa+R1dxaddu5HZbIyKm0izefDl87UB2
	 68Gu/bpadiQ4k+Z8116YuebOu1nZ4wP3pk8lXmfDmmRbR1SGXNt6vnZPgs4M71w810XdF
	 97vVQkaspOW9tHouVzTRVv/3GYDcg8lyGiuZwKvq5n53lOyhUNXk468MXnwe0F2i7RjS1
	 bOimmUtZKewtdPSqzMKqmRQLpZyxl2nqGxKZYrtE82CKFMKK82/HkX1xysh3l89axOg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794243722;
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
	bh=eitTm4fI21blq27Wkhxqz2oMvtdkSrJHGXf6CISPfU4=;
	b=jUiBKIkOePkyigtuJGAdIE4CI3+EELOCMh+wInPic5qV3ADyav1MoqPa4BXhxTGQ860o
	 vJxX2Da+ADifEmcwnenaB62QkP8KoR6ajfVrxX/sip6D36WWXj+x0UV6DOklupG4SadxX
	 l0+EgbsvqznxiCsNzaZ+R34O9tti214s+DdWLqykPkNyqMz4oV9jS4GG70X/4Kw0wsP2f
	 EBZMvDtcuAEpDqrE39vAI1OmkFj8HfTmPXitkVVIFNOy3qgA1fSjxLB4Wj+38joWmgzI9
	 W6Jkkh/GYYsKuJ/764cd1UiGnJrfj9MlbkbdoOCo3Tey7XZerDhJC+dSm6u6IfTfRmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794243722;
	bh=eitTm4fI21blq27Wkhxqz2oMvtdkSrJHGXf6CISPfU4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sOjEetMUlM/i3XFYVtOTA6QGmulFgssXlY138TPVCkRgnR2qzwxr8uJIQFejNjaW5
	 VfVV2jPzhIHlznsm1xFlPkJ80aNcKgtuK8B4zu7E4i1NprrALv8AWsu2RSRJEnyQyJ
	 7U9qhBTzI4PLcddobhgA7aSRZ02tN+lP4Jznt/go2QuqT1cc09skgp1hq4uusYAi8D
	 NNi0pDGUORVeNL0CxqpXhUb5hVjropfYjBlJtnmHQ9gXKHLLKSH0L96NLXcpikeqyF
	 Bl9sN/5KP7WRfnP6xZitPtqNsTnHM3rqCglgkFrCRpVo9PSVeifhe5W/DU5aFAbb0X
	 bSfqmtGmy/FJA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1D55B81063;
	Mon,  9 Nov 2026 17:02:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80F4F3AD
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 663C740721
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:02:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6P2BvGeufgkf for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 17:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3EE9D406E1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=RSkjIsTP
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3EE9D406E1
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 17:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eitTm4fI21blq27Wkhxqz2oMvtdkSrJHGXf6CISPfU4=;
 b=RSkjIsTP2oc6CWR29uz7FEgBYHC1WQ1Q6BDJzraoX1x0mCj5j8Qk7PW4cBorGLlTUpnpIPM/AEbWIK2btVirUL5k1CacMZomlYtSdIcvW/7wusqHClIMwQk5cn3JcdMFZFnTJ8mvukK82czUHXMgH3B673d7jRJ0ow6b8ZelCRg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 17:01:53 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 17:01:53 +0000
Message-ID: <9d8d0908-53b0-4b00-b9db-14e097e07833@cherry.de>
Date: Mon, 9 Nov 2026 18:01:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] rockchip: Use the generic /chosen/bootsource fixup
To: Wadim Egorov <w.egorov@phytec.de>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, sjg@chromium.org, quentin.schulz@cherry.de
Cc: kever.yang@rock-chips.com, anshuld@ti.com, aristo.chen@canonical.com,
 alchark@flipper.net, u-boot@lists.u-boot-project.org,
 upstream@lists.phytec.de
References: <20261014143328.3135006-1-w.egorov@phytec.de>
 <20261014143328.3135006-4-w.egorov@phytec.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261014143328.3135006-4-w.egorov@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0031.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34d::16) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM0PR04MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e17152-38e4-474d-1a24-08df3e832767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|11063799006|4143699003|56012099006|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: YPg9aX2qO67fgFHiZ4jtfEQMM1lpeD6P+L12EacgUgIEtA11c+oe1cSQ0HEmlVuE3UoTtYzErMgdrU1zJjjs/PewavU9SLoQ9XsnLbKVs+ZGal7VTX5gvfdIe4hMIvbtq2AQXKeFsF34kfSqjDQDpnxRKAWaf1q0niPQzKEq7/paTuoknwvYcXjL2nkUl4HmCoTb98K2dksYGWDmw0d9MdBMrsAygCaUC3lgVJ4exEBsTAfpspYio2G5lxP+mGegalvxuN+FsI6WXPZjrc+e46LRfEjxuwWcT+GWDuuOEOTayBnj2agGGQqBk1XgpOh98GyxNa3taGXe1z4SvwUzVLU9DlVkEdFI+SuB6ziqW0bZ/J+Lg02c17E7d6N0NPFyMgGyd1LuNDqnWWOl1sL83qFpjGDbL/52vDeWAydJ4veysIw9GVhnOt6vWlQfFfdrW/KkY0xn3nzHIeY+7pJoCHwkFRXH6Bk/7+jN58V3k4va4TeydfB166pD+CMO4IQvtTJhN4nNDjbyJUlthRTfNQhzdv4Gq0xtMlI07VWGZzfJvkfHiBcCY7mfzlQcuSz0okQtHA4HTS2qH/beX9MGM/s/mHFpYUXtZhFdccCydJYBuJblbuofIVgLCrj//oKVVIHXWT/flX1GMEOSR9zQoQr5fjZA9CJ4+O7ss9rujP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXRTV0JmU2dmL1R3Q0xNMDdkRDlQZkFmemV0U3pqMkxFcFA2L1ZxdnVxVXdV?=
 =?utf-8?B?RXdSV0hEQXVWZW0rdFBYOWhhQ0w0N25FZ3FiVFRaSTBuNzZJSFJueFVVT1hW?=
 =?utf-8?B?Zmg4Rkxia2dqaDYrNk9hMFhHVU94RnVPMmRZL2hWM0szNVN0Zi9nNDlBcGR6?=
 =?utf-8?B?ako5TSt5clNkWmNTR0V0WURLTnRjMTJBcmVmeDY2RmRqSmlyTXdQVXFoNlBv?=
 =?utf-8?B?TGJWbC91SzZSMEpaU0NONlhjYUthWkp1emkvT2xMdWRrbUc3dkNCRXZ5SmZ6?=
 =?utf-8?B?WWlRWGtDZWVJZFZ1KzIxOW9SajN3NklGaTZGcXhvOU54SG5jTXRvTThheGpB?=
 =?utf-8?B?OUJDamIweWpaWEN6MGpRanJkdzBaaTBOQWpOWmo2NStrRVRkNGh6VkVJVmFn?=
 =?utf-8?B?d0xmYndNVlhIaDVDQlRQSTJVR2VMUjFzOXg5Q1h6aG5ublFuWTVKZklkVGQ0?=
 =?utf-8?B?OG9mR1NSZUx4alk5dVZNYU82TkVjbXdKM1VLa05KUExEN1lKU2pUM0F4YVRJ?=
 =?utf-8?B?RjZaeG0yZndvQXN6VUxyZGRmd011bkhGTHhSTm4wNVNtWFdxT0JKTVZiRHpL?=
 =?utf-8?B?VFRWdkFiNVNYTE1JM0ZqU1JFclhPcm5XcVVVMmNNQXV4Y08yVDh2c1A1NVRP?=
 =?utf-8?B?aTJMZzcrd2lqbTdLak1yY0pLWlFzZmxjcnNyMDBSUGhVOGlMeUxvcEtmQzFG?=
 =?utf-8?B?dlJSdWgxMFkzdlpjcHVIZnN6eFM2OHdNak4yZm9tczk2RzA3Nzh5b0dmeGZv?=
 =?utf-8?B?NTRjdStjSUZxaDFkZVBCZnk1cFBFN050ZUJwYnJ4Y2FZUldURDNIK043MG1n?=
 =?utf-8?B?WG5wVmNRZmY3WFFCOG1aUHl4NjFxZTZlMUI5dnEyelI2b1dLSTJUVTNkcUpZ?=
 =?utf-8?B?OGY2OWRGWFVLSURUa2xRZm0xRExMalREOVRGaW1SZTdQbndJUURkTUViTXlE?=
 =?utf-8?B?UUs5L3FDdERIdDV2eUEvYnoxS09KRWNMNmY3Z2NWeWJaTS9xem9wc0RyZlNh?=
 =?utf-8?B?Nk5HQkt3OVVCaEkvcFRwOG44ZjJoRzAvOEZsbWEwNUxhT0ZNQlJwTCs1NC83?=
 =?utf-8?B?WFVqK2twVDh1ZE9ENnJ6MFMxekNDbGJ1dkJzdlA3SzlvenJWMll2aHl2WFJo?=
 =?utf-8?B?bm1LcjFWc0owa3luZy8zT05ZYjhzRnpyRkN4eWh1UHMvMzU1bmk5VlpHQUNr?=
 =?utf-8?B?SUJHbmhyUXptRm1TeDY3UXVDTUkramVZb3VydzcxQWdMaUlFemJjRGI1b0l3?=
 =?utf-8?B?V2NpOFd0UU1KcytsLzIyRTV2OFBFU1Axa1NOSm1XTU9rR0ZES0hablFZcVRE?=
 =?utf-8?B?NGg0UUFaRFRzbklpaVNraXljQUh4QkZCWDNCVWI3WVhVWWpvYWtYNkZPME02?=
 =?utf-8?B?Rk9wWStIQzNXU3VwamJUNkZtWEhTdlVsa1hsc3ZQTy8zcmk3ZTJpR2Y2Y3hY?=
 =?utf-8?B?Y3gzSkRhamNod0NMWVJwMGZpUFVpWTNHTkVFd3hjTms0RGdpWTRnOTlHV09P?=
 =?utf-8?B?anUzaEZsM3ptM3lNb2FrWTFLVUw5bm9MNVNDZFpCV0dURW5rTDUrdGlkVUtq?=
 =?utf-8?B?S0J4MkRWZncvU1dpQy92UWpzWGNXdFVFRGZSUE9iWFVwL3JrdVNad2hwMnF1?=
 =?utf-8?B?Qy9HeTQ2ejhRb2Z3WHlzWi9ra0k3eGlwZElhSGV4YUZKaXZoMWNZQzNXYnMv?=
 =?utf-8?B?NjVVVU1oNHJ1cEM3YUZiY2tmK1EwSkdwMTkvYzVuQWRZL2thbXFsdlU2b2FN?=
 =?utf-8?B?WnBIb2pCQ1RkaEtwd2g0RWlyVU0yb1VxeFgxRWR3R2hBblpoVmpXQnBZZWR0?=
 =?utf-8?B?cW5VR0Z0ZjRxL21HMUcwT0xVbXZCVHN0aEtjbzgzYm5hMHFDYVM1dkRKZThB?=
 =?utf-8?B?RGlDR04zK2lDSDllVDJUVmNKcWEwUXdZTUVaNkFFeXN4VmRlaWkraXl1SlFz?=
 =?utf-8?B?RzlyQ0lmVSt5MGZLdktLeHQyTDVwNXo2bEJIWkVubkJicXhUdVpDY1ZMVkNN?=
 =?utf-8?B?T3ZQZGhCVWZReEt6NHBBZVBPTkYxVURwR0srUHBlZkRUUVFLeFhkeEorRUVz?=
 =?utf-8?B?d2NMbE5NZFVCQXJiQ2x4aTUrZWoySWN5MjlxU2svaWx0TWM3UkNBbVU5dWgx?=
 =?utf-8?B?dFVwdlRCYkxiZDRHb0dOR0xvTFpFUmJXelZHZGJqWG0rM3pvejY4Y1UxREg4?=
 =?utf-8?B?OE92UDFSWFk1UVhFcng0N0YwVGRZS1dOUTVWbGl2MWpLUXFBNzZPM3ozT2Vx?=
 =?utf-8?B?US9kTFhudmpocG5yd1E5Q0I4SU50RzVwT3czeWlkRWpoSmwvNERMWGZNUm5D?=
 =?utf-8?B?dDR6RmZuV25qV2E3UTRURnZYREQ4MnBHSy9RekZibWJRZ1RVRW12Zz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e17152-38e4-474d-1a24-08df3e832767
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 17:01:53.4001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+lNHRlsX40NNy4Sxon2q3B24qpiJBS+toQZZjk3Wup8PBE9Dklj/OdYs1uxJf2eEc9OgCjlzAM8oNE7GEpcNG2r39RZ9xv0l403n9GJ/ao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Wadim,

On 10/14/26 4:33 PM, Wadim Egorov wrote:
> Implement bootsource_get_ofpath() on top of board_spl_was_booted_from()
> and use fdt_fixup_bootsource() in spl_perform_arch_fixups(). With this
> U-Boot proper also passes the path on to the OS.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Tested-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

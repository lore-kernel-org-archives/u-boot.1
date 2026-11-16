Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD08606A329
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=uugQF/rH;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=Rs0OOtx4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E6A4280D7B;
	Mon, 16 Nov 2026 13:41:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0fsv-O1hyIgb; Mon, 16 Nov 2026 13:41:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2747780E31
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794836486;
	b=SNdsO2mYV2hxVV/mzmIC6WsX7qDwcdW7jannw8sjxZYO5NjHvXno5JdStIk4kG6u/rWr
	 0aW45DefCthDTPqm8Ni08tYP93VKU/m1LSUr89jtSeRGeSabnK70kpzXHszZYbG/xP2RP
	 Zvec9pknJfjDPSeC2AVSbq7Eq6Rw+Xav2+nyYsXn94hyJ2Si0vasTZBRx8Yfa9pC2moo+
	 F9gtdhHeWhEMP2pf+BMrFb6wppT46XY2HGjMO2VuDlu8IePG/1TrxxEUZehzCOeQJUu3c
	 bSTYWDk71XEG1s+yJ/6uPhgf54GA0KJNKuMo88DK+mmNiPGBma94PwXcTF4cPEzxk4g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794836486;
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
	bh=Z/uH8LF6dLCvo76Le7FwBgwVQDmFxLcHl3tngXmyr8c=;
	b=i37dNDNrnvKXWjpXfxKt1KuJ0iViuQhQ/RNEO8SEkq7gD3Bwy4shciMG1v6gz0qxZ6EK
	 WQYluPlgaF5Ek35jdRpWPzWffe7sUyOyYQQGbQgI4zvSDYS+Cd2lWdPIg/2nWhHK9SOl7
	 acVsTfM2416RoFYvPHj1xRY+rRGCNZ216uEImCwnKRRloGtQF/G7j5s5VIE6s/1zzNdRC
	 mgxXeB4dI+VRiFv8PRBuTwpHVQz7lyCUNjOIe9IcvNAMDZsEU/Sy61hz5qSreLn592bU/
	 ylyAg8qofFGj/Q4uUtqMorSWhwwG97a91lu1+0OUJvGoJSx0kv5Ifsko0KraZBfqeoA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794836486;
	bh=Z/uH8LF6dLCvo76Le7FwBgwVQDmFxLcHl3tngXmyr8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uugQF/rH2B4nYUYzqe0WAcZPqJaAckxQVp/KtW5gOrLkIzHYkRG8cB+ErZR7hPakZ
	 SJaFMK2Nhh1pBXjIYA0Wpr5BSyXodLtQX69Oq80bLHzNuJh2KkpLC6sZPyC4RLEjru
	 AHYlNfX7f5M/QkrRpAFqL0EJ8GuDer3eg+mb8xnhyUAjaYPkK75EmqkV5nqr8Pzn8j
	 5cFDRFEnA4hkf+wrnATviRGI0n756/IkBwR5bowwhg8Pwh1zx4ARiNW1/Lln5CixbJ
	 lS3ISwz9pgvfhbWrn9JYuMR6MMVuClW59sTHATGi4I/8DZUDR8vUYX9f6Pe79NAak5
	 lUiOY6WrlSPFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2747780E31;
	Mon, 16 Nov 2026 13:41:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 34DF34DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:41:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2646560777
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:41:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qamgbJ_0bkUV for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 13:41:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org F340360635
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=Rs0OOtx4
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F340360635
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/uH8LF6dLCvo76Le7FwBgwVQDmFxLcHl3tngXmyr8c=;
 b=Rs0OOtx4veNKAVjZD08uZq7b9GOyCPV0fsrbqVSEDigbcTl6pFmYWPgMNz/KX18Hv2GbROU8M4tplYvW2FwAnvfxyaznALU+lqvJTGTkHilm/DwCf/AWB5gyilFj4nB6kEXqyijEDAnFaAORAmUul5sazR9QWqOitCxmOWCmxx0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by DBBPR04MB7930.eurprd04.prod.outlook.com (2603:10a6:10:1ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 13:41:18 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 13:41:18 +0000
Message-ID: <1e6b2652-e234-424b-9665-9b3b1e21ccd2@cherry.de>
Date: Mon, 16 Nov 2026 14:41:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] video: rockchip: Set return code
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Tom Rini <trini@konsulko.com>
References: <20251001-video_rockchip-v1-1-4933bdb56990@linaro.org>
 <cdb45ea7-40e0-4112-9544-c0eb1bc96523@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <cdb45ea7-40e0-4112-9544-c0eb1bc96523@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|DBBPR04MB7930:EE_
X-MS-Office365-Filtering-Correlation-Id: 70228853-3033-4dbe-6b1b-08df43e74afe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|4143699003|261026121527099003|261026140227099003|261028144727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HTlqOFcQM2vwEk6J5qmcTrq+k96wOmdLPk1edQ4DF1vIEAhESV6djlfJwjCwab2/pflqcCoGAnG/LG0DUM2xK0geCV3y1S9UUuCzZSADlHjjMIywj47jPSz4bITrnB8MvW2fqJW1etqtQ4dsKbo8PNtlhWTnezsEf1tVTlJTrksUzq/xdScl/SqlQtHgJlHWyExRagBAgxgXl1nLsIa1yzYVOrPvWdt0I//ipWX0zrbpWmtwXsvd1yOYZ+sc7h7E/C7MwYe602Bs89YT37Xjen8cye1Os+vpdt+tPR6pCLZl0PVJ1CIFuIzGrwQsyPyzEb+jOwFcTj4IMiaZQ8Cd4+qK39FvrbKk34HLay3HQgPowLY+8eQpKJuS21+W0aoRzt0w0VbDQ3taPXEc08Z0fWH/s6L5W2PpBhfAMuJXcB4RMb8tgdDDtSva50Ql7cTUc+CadM9fbwGXQHOaG6Qm8WzLFTQPr6AmRMKwtapWvbIWlP1RKBIwSBwnjWt72uKnkgPujkcnjLs3GuBI6syJR/AgxjteKOtxynpZvK2cCQPJm029Y2g0MkrJC/uomAtrsQ5StJUR0L8x6L5dZdAGrKcNaw44U92O19b6Wvk+R2Haay9RDCeBgSXHMxbH2vuIf/oBDML7U0UMVu5jM+bAHkMz6idybS+a1vPUuUvcuWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(4143699003)(261026121527099003)(261026140227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWIxWHNMQzZZTFJpMnB0dzBPR0VYalM0RjdNd0pSWUgvdWtKTnhNU0NyUXcr?=
 =?utf-8?B?VTFOMjVwWDRLR1pZZmhJUU5sekp4ckJQL05UVlJ2UUtnOXEyRWhMQWs5cHhI?=
 =?utf-8?B?ZGtLWnMyUWU1UXR4emJvaG8rRXdzcnNTYVhQYXBoY0xvODZRSk5zS3dGeGRu?=
 =?utf-8?B?eFpyaXZVOE9zUHRDNEZ6dVk5R214bnBYMGlETTdkSWZRejkwWXlGNUl4cStL?=
 =?utf-8?B?Zi8yYWh5ZmMreU5pSWtOYWluQnBLdzE3dmduL2pWVitqZDVBTUNwRHhDaW9K?=
 =?utf-8?B?RFp2eXR5TG5LMm80Wm9ibUtMWkQwYW1oN0ZPWGt5Y28zRzRSbSsvZEtPVktW?=
 =?utf-8?B?bmtZd2xiVlQ0SmhhbUpzdFJ4R3Q2U1owZW54QTM0Y0RSVW9NSnVjQ3UwVDNv?=
 =?utf-8?B?amdRdU1pN0pHNEpPY2h4K3pqZWZTaXdvb3hVcG94VnRmR1lZdjdCcU5jWjFJ?=
 =?utf-8?B?anppZTQ1WG1mQUF3V2Z2WW90dkFWWEFNc281TDhTWGprVFlUcWRvNk90QWw0?=
 =?utf-8?B?RE1LZkpySVRINzY2TStiNHVXOFRJY3pIa0g0eGY5UGxhcjB6K1gxeWZDdk9o?=
 =?utf-8?B?REFWRkdaYmoxL2hUOEhtOXROeXVScWl4U0tvaEYwcWQ1YStRZDFjd2hGdG9M?=
 =?utf-8?B?VkdPSHNzMGNQTXlTT1lKd0djSU1Md1dJU3l1S0JJeG5uU21xLzQ1cVBOL3pL?=
 =?utf-8?B?MVhvUXlFZWdRa1pZRUd6cHVBTGdKdWY5aGVTdHQ5ZmxBV1R3VExEWGRQbVpq?=
 =?utf-8?B?WDMvZTJmVjRudUd6Q2JNenkrTzFQekRqRlh0THc1bFhCZWM5RjVuUVRBRmJ3?=
 =?utf-8?B?cWtDc01kYlE4UGZGOWdDclZNbFljdmIxZDhDTHBYeERwUXFtMnhSNWRQQUNq?=
 =?utf-8?B?UlV4VkdNWksrbU9HNzRxdVBqMVlHQ2xKMXBzUDQzYllLTDFWUHhnZWtuY0Fi?=
 =?utf-8?B?OVE2OFRya01IU0plZDhydUd2YmVBTldZRm5qWUVMYnJxVy84QU11SXd5a3Mx?=
 =?utf-8?B?WFhPR2haR0JETzlBSnpYTkhsSC8xNVRWWTRlV1ZNWkJYa1VKcW1teHhHaGkz?=
 =?utf-8?B?aTRqY2hxWTEvdGU5Tnk1c0VmT3dmSFhKeE5aSjl1RC81elhtZWsvWGpyVjlu?=
 =?utf-8?B?eHdmNGJpcXBmYjJlaWFLYlpkNXB3L0RLRW9pUVpyZEZnblBEMlRJdm1kSDV3?=
 =?utf-8?B?dXRHWE1KS1lZaFg5aGQySENHcFIzYWsrWGZTaGN0bklnaE8yWE5hZzR4OEtZ?=
 =?utf-8?B?MUVzL2ptbGVjYm5jekxGTnE3MXBiOFo0V2o0bEJBZngvKzdyM0ZxalJXb0ZZ?=
 =?utf-8?B?VkJ2QTMyNU5EZ3MzSjZUaUw0SFRtZ2JqRHZwVHZoeUdvTFhjQTNvSEQrbjY4?=
 =?utf-8?B?SE93a3YrRzJocXVmdituVFhnUFRjZU96dEwwRWIzQjFscWZGdE9vSzBVZUUy?=
 =?utf-8?B?eERjdkhiU0FwSVFNTmMzWGNDelZVMEhSZWJlSHo5YXUzUTIrRGQ1dmdMT1lv?=
 =?utf-8?B?UCsxSkNtd0dUMFRqYlVGd2M0WlpWSzlUOWx0cWpQV28wK3M2R3ZhSjFrTTVn?=
 =?utf-8?B?cEllRGwyV2czUVlwVmlPQXd3S2hsWHRCQ3hyek9ZN1M2NTZNQXc0VnRXZnM3?=
 =?utf-8?B?ZzNxNEV4d2RpSmwrbkRhRjZDQXVqNGpqaDRkSmpHVlFCZFl4YWZKQW5LK2J2?=
 =?utf-8?B?aGJLOS9weTBoR1lFTXVqV29LVVFvMmJxRHlkY2NCOUltWDFOSHVneUpLOUFN?=
 =?utf-8?B?bWtLVEhVa1pJVkVCNFRQUngxN2Y4Ly9LQTlUbFB5T1BUWHR0eGd5UmJpSjcz?=
 =?utf-8?B?R0pHSzRhQ0YvUDJvV1JFd09GOE5vK0hnblRuWEJMWU9remlSUVNkeG9zL0E0?=
 =?utf-8?B?WlVtQWx3aGkyZU9lR3dsUFd2Z1VYOGlrZVV2K2tDbTcxMGtHenhYYjRGdmZ2?=
 =?utf-8?B?R3piRUw3RG5CQzNzUjZMelZzVEhMMHN1LzViNjFQUlVtRFV3KzBMaEJRbnJm?=
 =?utf-8?B?UUJtNkMwR3J0TCtibDJvbkJoUlhKK3h1a1o1YVo2U29rR0F0SW1UYUxRRzk5?=
 =?utf-8?B?bGFiU0sydklHdm53M3A5SmtXSUNSR2FrdGZidlZYYkZnQmVsQlBzTXNZV0hS?=
 =?utf-8?B?cytDOUVHRUZMZVhvUGs4eG9waExUY0FwYTdWOCtQcWpiZ1NLNERRaENSeER1?=
 =?utf-8?B?K0RMUzlHdUErT1B5TGRYWnV4RUZrNTEvWlgxVWgrdmI4V0VVUGZSREhBaSt5?=
 =?utf-8?B?SWxBbkUyeFNmSUtuQnppRlRtY2tLOWx3VnBPby9mUDBJTHJ1dDgyNkJBSURu?=
 =?utf-8?B?OVVlMDl0OEVBRVpNWlUzQ0lVZERFR1JRc0cyUjc1dHVSaHk3NzhvUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 70228853-3033-4dbe-6b1b-08df43e74afe
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 13:41:18.6379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0XQh5fQn6tPt3OQ1UmMJ82lVkl2X4Pmq1HA94Ts8W6NiBNABrekMKcMqpdLVT6YyuMJoVkW29GA7GU5mFXr1/+TJbGFBDzsMo5r+TIi7Eak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7930
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

Hi Andrew,

On 11/16/26 12:18 PM, Andrew Goodbody wrote:
> On 01/10/2025 11:37, Andrew Goodbody wrote:
>> In rk_edp_start_aux_transaction the check for "AUX CH command reply
>> received" returns ret as the error code but it has not been assigned a
>> value so this could lead to the calling code silently ignoring the
>> error. Instead return -EIO.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>> ---
>>   drivers/video/rockchip/rk_edp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/video/rockchip/rk_edp.c b/drivers/video/rockchip/ 
>> rk_edp.c
>> index 
>> 0ba68dbce3d126f8a3230435ffa0f780c1e08d61..7186abc9c6c93d05e774e61efa136bf98ff727df 100644
>> --- a/drivers/video/rockchip/rk_edp.c
>> +++ b/drivers/video/rockchip/rk_edp.c
>> @@ -216,7 +216,7 @@ static int rk_edp_start_aux_transaction(struct 
>> rk3288_edp *regs)
>>       /* Is AUX CH command reply received? */
>>       if (rk_edp_is_aux_reply(regs)) {
>>           debug("AUX CH command reply failed!\n");
>> -        return ret;
>> +        return -EIO;
>>       }
>>       /* Clear interrupt source for AUX CH access error */
>>
>> ---
>> base-commit: b2d5e46c67002e46ac339ef549ea18cf5adfcd87
>> change-id: 20251001-video_rockchip-a480d9178ae6
>>
>> Best regards,
> 
> This patch has been outstanding for more than a year now. The existing 

Sorry, anything Rockchip was pretty inactive last year, I'm trying to 
pick things up but I mainly look at recent patches now, and only when I 
have gone through that pile will I look at older patches (which I 
suspect may never happen as my inbox doesn't seem to get smaller over 
time :) ).

> code is clearly wrong. Is there anything that can be done to get this 
> accepted?
> 
Can you please resend?

I would like to go for:

ret = rk_edp_is_aux_reply(regs);
if (ret) {
     debug();
     return ret;
}

instead if that's fine with you, it makes the pattern in this function 
more consistent.

I'm also thinking maybe we could save a variable by reusing ret instead 
of val for the two readl's after that but as a separate patch, and not 
required.

Cheers,
Quentin

Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56907606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=D7jkRBlg;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=lS3c3DGV
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABDF380A98;
	Thu, 26 Nov 2026 07:43:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t3ROe9H6Y-iD; Thu, 26 Nov 2026 07:43:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1F1D80931
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795678998;
	b=U+gr27K83dqE1utvSzKHTfYBKi1EUwJmbaBhom+pRJOUizWBH+KJvEQu91buQMgH/bJ1
	 DVer9M60EpFDZSwuvFvt1GE3wp0lGGO+0huFm0Szv/v4ABGwu2p8wO/L8HxDgHdjkQsL1
	 AjZB8JWbR4Cl/OdnVquys/I/zkAQ1lsOASQyfJt3iQFlz39W1jMi9a3XG3iToA/SWyHEc
	 OEDuHh2m75plebFEODjfezaLLKizEQ3nniYSCKysoVD+ixHioEDxC0KvA4DbKdURJREy3
	 I225AiCtS79w01zPf+2mwDmbo/QMGaw6UIg0vw0i4CN0MREKSKVLaZsebhe8OAkhEqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795678998;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=39OYJoEyKr+wWdE3+89l3b683GjOnNQO+FpmqxhMXwo=;
	b=EIDg3AVa6nPnmelV9UWzxCSZOSvuTowRKT+Uhdg2l7ORgVAXxZVIUz9G92brzuye9/fO
	 ozXlzhcT0bCZUHVpcIJbZb1FZwIaNrTffUZN1MzLX3HWDzNTCleRf7/k1AU8Rw7QmJ1Ze
	 yHsjMHzLc6umV0wDhH5PSecLoM35yBtnvj3kQl6H04kOKKt+4vkjFE3O7O8N6wP5HrnNL
	 fWEV9W+XijSzGWU0dEvXyOx2ojtz+esZnGVdYJkQV0256gnuFrUtx7gcqXQEBvy052T0e
	 55azD0+XIYGlGHbBAmerngf4Q00C8tqmNoYEEzJu1ng5UvCjwUkB1T2+nAbUZW0+Z+g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795678998;
	bh=39OYJoEyKr+wWdE3+89l3b683GjOnNQO+FpmqxhMXwo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D7jkRBlgdW0KKulCISAfydViwtQ6cZRf6VdyPCHAOHiTbNgFa4Omp0BuAl3+O58d4
	 pZ+iWgUD63VSaKR9e4aTue5NWafX9751azNZUD1+7Di+//Fw/K7eWa/zzRDAQ8KMD4
	 3hIsRhS7sl5Qq2zOa546eGfpiZjoDLHllW4EZLFUxmAgCvQYYGOCwCUDLjvbB5DRZG
	 UuIFHWv/XDIBaMgnPUiT3AGF0jQEux8r1C3iwbckM2y0yZmfMLJYUKj/i1PoSHwJnx
	 /llRJ/p9EQaRMlQLeTJVx1NIitN92mSBQeDGCCrGWymwLHZPkiusdn1BmZpywk9hMZ
	 kfjX8fcBvkw5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1F1D80931;
	Thu, 26 Nov 2026 07:43:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 774CA22B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:43:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5DEAB608B0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:43:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8xYlc34SwcCE for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:43:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2A1EA606A0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=lS3c3DGV
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A1EA606A0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=39OYJoEyKr+wWdE3+89l3b683GjOnNQO+FpmqxhMXwo=;
 b=lS3c3DGVCoLpFWxdXzPSgyFf5gyDYFRzTq+F3cWCHBaUf8Zm0nfqjIroCOoq7l3miMimHllsLSl223v3xDut/BalzenCPwNtQyudR5AM2vMuoRxEfJeLyCeBemADUgPbxr8VUkW8KVtsvlZaC5XEmoEhuzl+BZBvJyxLiwYJf/c2bmE6tLtiZ1CdhQJ9F+y9I8oxtiA3vewUj7WSv4PWPUQoJRPF3dGiSAGTE6/WHvegd2sk5TXP0Z0QRuTHJTbAswLIx0LGy6pxxoDf8ldores1dyHaPm/XvnvuLgMSJc8+i37agQv+ePIUjP6nw4OqNP6LwJcA3FJc3qxTO+ZyRg==
Received: from AS9PR05CA0312.eurprd05.prod.outlook.com (2603:10a6:20b:491::16)
 by AS4PR10MB6158.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:586::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 07:43:06 +0000
Received: from AMS1EPF00000091.eurprd05.prod.outlook.com
 (2603:10a6:20b:491:cafe::7e) by AS9PR05CA0312.outlook.office365.com
 (2603:10a6:20b:491::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Thu, 26
 Nov 2026 07:43:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000091.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Thu, 26 Nov 2026 07:43:05 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:43:58 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:42:51 +0100
Message-ID: <b59cf261-ed86-4a14-b9f4-a84262ccdf6c@foss.st.com>
Date: Thu, 26 Nov 2026 08:42:50 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] i2c: stm32f7: Fix zero-length transfers used by i2c probe
To: Heiko Schocher <hs@nabladev.com>, Frieder Schrempf <frieder@fris.de>,
 <u-boot@lists.u-boot-project.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
CC: Petar Krstov <petar.krstov@kontron.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Alain Volmat <alain.volmat@foss.st.com>
References: <20261117093726.582644-1-frieder@fris.de>
 <dbe6b314-bba3-df1b-caff-349f1baf3237@nabladev.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <dbe6b314-bba3-df1b-caff-349f1baf3237@nabladev.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000091:EE_|AS4PR10MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fe9de3-bf49-445b-69b5-08df4b90e88c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|18002099003|22082099003|261102123227099003|56012099006|4143699003|261021121427099003|261028144727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 50MO5p5MUyXtVSqSCwp6SUCoJI8N07OtQi+pV/yk2JOLqIvR0m2rDcE5oYsI403hZwVwutUK22FCSM+ztLFvMuM/JDAbQ4aSRDVu4mn8aIIlGzk3LrQhpZdk+zExfkr1mfnVt+VXq9Sxd/T8ea7lCTugIztDUSD3fb/3dDxYLTz0f0tD22saHLaJ86tM4F+BdvV4fLwWckKhuToo6uGNWXQR8tcHRku2zIrUSGBgRcbm3ZCoZhEjazeK1b7AQD9ZEYyWunX4b1fZzgJDUvO6e1ToSuswhW+sGSGInI7bD+2N32ZvkEEW3NArzt6sU5uRqRfQXgETSUQx+im+OZpDzYxvIjLx2x8xHzXRT9Ckn7v2HBa2CDBhR/GHvdoTIWomDOuNKtAOh0twek48oT/htmCFzrLstjt6xrq2bOrKmLPC1RxeLfEYgc3ifj23brGoqZV42y0m+n4Mwljs1/2Um59vJlw4tjiwsra3asW3PaVWLLyAm30Mj1hBH4RnpQryibnQ8eBa57isdlw7/zQPTR07isZkH0KgdzzB1b6W5d4CDEnixKyRr9A9bz163pbuca7jm7xnltcvAxFcUvzpohncK0P/X+7HhLAcjvh13fPD8Jly75X8R3RgkU3IqdRVRL6YNpwvUYeRiggdjnhS+Ox4py4HSxiN9dctpR7dMrMMPbfYKf59u60yPLr1cDwZOqpTTAIpcoauEVWKom91Bg==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(261102123227099003)(56012099006)(4143699003)(261021121427099003)(261028144727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9ZhACD3lifpMeMuQZdTJOsQvI6JdAYAIxv7fWI3hS0qStz4hIX7lCSckFOv3GDnYjtxtQlXyydeEj3Vpuu0lgbPicOPtkBPOeDT6mShNwALp/2sCHAiaKo8W8lALM450ns2OZ/GwqyfMWOG08OYJSsnTLQnpvvkk/2IrvnunTGMWJUBcZV2gm53jky0fICLfHHIK4NF4AT9ZmM+BnO1ErE2OJS+gqwxmzSxqlocraGG0sOHrYEgjBKkKcS3h0cHQWP9fDyMdPsdi41zbxmLxFMHUIAL3UC4FJvcgdMrCZmELtHjR52pBnKPSsCEo9nZTT0LkJAuSIoPspLsArZr2BKNZc86oNpUdS3fDTEbCrjNTveUOWoRqF5GhqQcon8cEwHmadvhIIldH1Ct+j+G5qP0nu917695C1lprG5aUCkw+Y5aJ2Q1z/wHWh2W+YEcs
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:43:05.7985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fe9de3-bf49-445b-69b5-08df4b90e88c
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000091.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6158
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



On 11/18/26 09:08, Heiko Schocher wrote:
> Hello Frieder,
> 
> On 17.11.26 10:37, Frieder Schrempf wrote:
>> From: Petar Krstov <petar.krstov@kontron.com>
>>
>> Zero-length messages (e.g. i2c probe) skip the data loop entirely,
>> so the driver never waits for the address phase to complete before
>> handling STOP/NACK. Add an explicit wait for TC/NACKF/errors in
>> the zero-length case and initialize status to avoid using it
>> uninitialized.
>>
>> Fixes: 3bf699f7a8c6 ("i2c: stm32: do not set the STOP condition on error")
>> Signed-off-by: Petar Krstov <petar.krstov@kontron.com>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>> Cc: Heiko Schocher <hs@nabladev.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> Cc: u-boot@lists.u-boot-project.org
>> ---
>>   drivers/i2c/stm32f7_i2c.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> 
> bye,
> Heiko

Hi Petar

Applied to u-boot-stm32/main

Thanks
Patrice

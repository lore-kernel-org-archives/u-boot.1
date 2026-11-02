Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3685D6085568
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=STlAnMfd;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=r12kdRJM
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F076405BA;
	Mon,  2 Nov 2026 14:30:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NsYvLFmzDz9j; Mon,  2 Nov 2026 14:30:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4DDF3405C4
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793629809;
	b=IbXTOGP90K9jCvXczZcE7Z8+SHIRSrmZ6sOJ8u5UUhQ1WSlR90h10gXWARrzbifMxrYz
	 Jm5IXASJqEUMa5g1NQ/fBwrtARkm8mpRePMRxwZB4YF3Onjl8n+dUsUH206eYQEBXkuhu
	 m4nL/nyc1tjB67Xq8zd+EoeaNbMbJrlahI8GMdYDPAspG6ii9RicocQt6BZ5DnDxGVcoZ
	 834mVMGbIn3ZQwNN6QFpdxHLG8lZ1bH1onevZPRouh/dUoEtICwGxsDrQ3ut7BvQ100DQ
	 HnCCUFdcWbN3amOQLLr3h1X5ImWEn7MbiGBjruozC986H/JxzqJ4pkgZQFXloTQwDBw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793629809;
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
	bh=xc4nhHAv8kHqAJUTpqcxwSJtujmqfj1xhegBnvxBBCY=;
	b=iLG7qr/MDRo2XBz6LRXRSx8vPs69uZ+S8zo8K/jKvmKd+4VQcHYeRSXtJiKcFpCJz4Vi
	 4I/fLQ10vlSyICnGup9rbLkQwIsfcwYBv7ho3Ya1s8o5eYYU+PdZg8O5b097IUyF0T4dt
	 BcZYx8H130aB5WL5e1RZXMyk+I+6eTOFDxp5BdIyex4iKthMgslBF/TuVMKar/un4KdM1
	 k2WG/MBaqQ8Po15ZQKskVV8khSLfjXngyu/zPymk1v9rqfwclflYeAe4nDXstyYTOw7B3
	 o0JT26jEN+eMJ5Y0eQR6mYhvHbFlKH4AkW/Vr6qVfKui4f4/kClQNCISRmDePN6+Bxw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793629809;
	bh=xc4nhHAv8kHqAJUTpqcxwSJtujmqfj1xhegBnvxBBCY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=STlAnMfdA/xLjecj7fZPHN95GWk6gkNaMIyqhTnPPWwBB3RtArbRcqkY5W00mbvi3
	 p4V7jllRBH//zQuRCg56Ve2rBDQ6Ei6tqCsClXStOEQQcnyo1tVFi48EkrjXv/42BZ
	 luGvJ69rlfPcL3lb6qRf1TTtjYZqePUkPcf1c+V+MfTMfqPnCxk0oNNtt5MhjHMw/3
	 XS8myJIdJVu0MW5TdEjXddS3GM2SqQQbgQzHqc3DpQ+c1BvrLnvixvpqoF2K+p6c/E
	 a0qW+iHphaVPJtsZ/qrN7luJdnRznNp9kHJ7FYqnpMwP09PiTsGPZmhAFQDpqnHfla
	 upFwbu1YKSNvA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DDF3405C4;
	Mon,  2 Nov 2026 14:30:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E0984D3A
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:30:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C9238400D7
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:30:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJRHvzTCM6c7 for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:30:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org EEB27400D6
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793629807;
 b=Etc0L5rnEytWXt0VtKTUxd2CxJd+wflUsrzue/v1/MGnAyFY1Sz9fEhMyAh+qHmAPUaa
 ntH7kJYEe/h3Iqcikl0f4lb+wbl1OPn3LZtLmgMAduouK65/FeQdMAd857aEcRpnUwlo8
 RsmDJf4IdRYIwr+y6zY6H4ranX9Wge7mX5poM05RJVb9QgEx8Jm2BpHNaWk77U6x9IWtR
 xQSjqxMYIffg5AXK4bJvW5NuZS3xCUrZ1Oy/2aSdn8+311v2W2VuJf3x+yB+7/IJBPaCY
 koe/hFpjr5+HlyjPuJ2ALyOJ+Z6KYzLAKaU6s2weThOyNxCe7qDtfGqJx5yPp88beKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793629807;
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
 bh=xc4nhHAv8kHqAJUTpqcxwSJtujmqfj1xhegBnvxBBCY=;
 b=DX9Cf1E3g1aDiyK+Tck5rqQtvJHASmu5e189egddMuYg1RtAb1Jm13Kzr3hN60mD6FoU
 xEkzsKCIVAEJk8GfhkmVlmILG01FIeS1K3y0WYw7QRfUjQlngNsD8EVkhzfcuoDBvNTNr
 bky6TcdkjP6w047P15qDqkDZuO/w4qB8RNdCU1syWqj66PV62FNH6tASvbW20vLX9xYR5
 G0dahcsyVpKnAHkeu41dK7Mv+OgcWfeluX05KeY/pjPW7+E0XiAa7O1uCY7p2OFLe6+fp
 JC8FsWmCc3UAWcSHnYO5PYcJ8c3RNxvO7lZHQ+C07T7kyrbK/WmRehaw4oQFFtNfxlQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=r12kdRJM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=r12kdRJM
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEB27400D6
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:30:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VTtUXavNmW93KcjQt/UPviBpk7+NRijcum0LXybb7w+Q6eIRPfrMwws4XjHlNOPkVCRKjh7wsb+3iwVQXIqXkcpZyxgYDKyR77RCqjm+DkyNsW9xipTWI8Uy36u/YAHqzVMKtR7ygKeGU7V5OIunNEZW5QTHagDFwE+1G5LF/oYw4/cdnus3ZUurK4Ue5UFxrfQ0k/NFAQC5whfCzBXaJyv8bhNf0DHdepvzFWfdSBB/Xq/e/N6vxGwBXbkYWKn/EOCz55/nzd6MazubtRmzt9/Nd6kqb9WaX6hLIzJ7HhKkS9BVqL7FzI8waCkxQjknWuEYuPJMF93QhCTvltNjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xc4nhHAv8kHqAJUTpqcxwSJtujmqfj1xhegBnvxBBCY=;
 b=VpVwIg7vUcfp0viFkxjGXB7dW/3KI4Q7bsft1M6W+/o0+O7FHktXZNXZ1MiO1/E51QrLZonpVDFtcK5u5NqNKkkSEsOQ28Re7EUms2gFu3S1reWCg6lseFB/Horih8pjfRKXYNUTw1hqtepFKiYktYeg9uMJuYTQN/ZyAElm3n4hirq117RjeVBPfQrSZ0aJ/8/eHkHUkicFNVpsEeV+Qj8+cru4YJk8P9+RgvX5m7QNWIQiETg9WTuLZeqJG2etZyl4Rasttg4bgPlhq0wooT5fr1iGeUfIxYa7ICVBvrd3RvNHECC49pzLzEvS/lZE5GeS/SU8nfATAmV97Tz3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xc4nhHAv8kHqAJUTpqcxwSJtujmqfj1xhegBnvxBBCY=;
 b=r12kdRJMefpYcLBRNoiEVFVEG1G4obnFN3qqJRrIOjyOydUSXkcdOB/W6DaMyFWZg8PucA2YrNR6VyNMwM1Ouk+l+Nglz8/1jlew0Ytuw4gq02+6Zi8gpktIau5/MbNgJhDmNoj7kpMzyx3uLamMv3Kdd4GRJVutWu6j05Sxfp8k7dS4uCd57H+WAvmfVr+Y0a7gTbjrKkPLMFWVyz+rUe36pkGc3w0XYnsMhs6E3qtwStfxia/7mjYDIjdNBybRtF2kZvtpQi8dvB3T0b8s1pomScWBQNPlJfbLZ5Nt2M90BY95in2QZERot6D5i/aWCe9UHU5F+x43gaPfLMjPqg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GV2PR10MB9675.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:357::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 14:29:58 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 14:29:58 +0000
Message-ID: <28d506a4-15e6-46fe-af19-12e9e813d50d@kontron.de>
Date: Mon, 2 Nov 2026 15:29:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] bootstd: rauc: Fixes, partition name check and
 built-in boot command
To: Simon Glass <sjg@chromium.org>, frieder@fris.de
Cc: Martin Schwan <m.schwan@phytec.de>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Aristo Chen <aristo.chen@canonical.com>,
 Alexey Charkov <alchark@flipper.net>, Daniel Golle <daniel@makrotopia.org>,
 Johan Jonker <jbx6244@gmail.com>, Francesco Valla <francesco@valla.it>,
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
References: <20261029-main-v1-0-b5a878627107@kontron.de>
 <CAFLszTi4Yq+=pnrJ-th0BMZQ_RwsZ34JSef6NQL2Wa4uLbtK7g@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAFLszTi4Yq+=pnrJ-th0BMZQ_RwsZ34JSef6NQL2Wa4uLbtK7g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::13)
 To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GV2PR10MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: c1c38d1f-1469-46d2-7885-08df38edc5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|3023799007|6133799003|10067099003|18002099003|22082099003|56012099006|5023799004|4143699003|11063799006|261021121427099003|261026121527099003|261022075727099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: vbuKzdWIVt0l7JakHN+rTvrl+yYnFwfXsP8q4ByOfu8popkNKH1m0myUfuhWmz2SwvMGDt2eOa5DUfL1mBsHtfq+LamGDrTOQcdgZaHQHN8WxxC70xOa//Bx7rIqr8rdJSyD6N9NFapy2ZgqMrmFlNZXn9Wg4h9etJiRXzYUzyXQOO1aCHvhA3C5zYGGDllucyrD9FoYAXNjb37qYaQgFknC38hHHOt7xEKjLF4TfXMsTuCgTmf8mQlLlULlAI9EhMUDGOhsIzwTqiQYXwREq5kY3YTqW1lqJX1gSuqyqQuZ+mt8BgLMv0mIU7lX2CGgb3OZTLWU7kMZTxEcYMF6q+TCY3sk8l2thXkZ8eANTuP09kSik1gLdTd1ZxfQi2TA2Kbvm2gGTmiSiXitxDh4PcyUiELxxRMSEJGTPVdFIRcxSeL28TdBMiJJLh4YTnTVH8ThF7brH/dd5OFvRiIrw6eCxom/3h1cDctv7NWXT+BPQiW3EfYAwKmmSlnANGQpXgf+TSiV2xoasl7xr03pTgVQEy2hl47fuVH/Qod9OS1luFi1ZBYvx7AmcFqd9getJyqwPz77BiWhOEaJmC4hwYWU59uJCoj8cTmlF4wNXRzWCL+mLIPFWNKRaU/Xxk/5en+JXtBpCFHM8B8a21i4dN49Z2AeS27ladxWNQCocqs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(3023799007)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(4143699003)(11063799006)(261021121427099003)(261026121527099003)(261022075727099003)(261022115727099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWFpSmJLVGhUZ1dvbnErb3VsV3RyQWRuNU9IcVJhWEhzYkJsTlY5ZjI3cmk5?=
 =?utf-8?B?Rkd2QVk1L29qdmtPWFYrZzhCSFVSVnB1Z2ZWbnQ5L3ZocVp6bFRXVkVwdC91?=
 =?utf-8?B?cVQzaGNEL0NqOUphTHF6c3drVEJjd0UyY3R4YnBnMnNnVGU3dENHTmpuY0t0?=
 =?utf-8?B?N0E3T3lFOHVZbG43OGV4MHc1TzBaQUtOYjErSjZ3RVp0Yk5DUUZzU0dSdTN0?=
 =?utf-8?B?WFBNeGdnZVk4V1hkR1ZPbnlyR2FST21LQ2VXczk3L1VhVjl1dkQwNHlGd005?=
 =?utf-8?B?N0xCdGVYakVPaEkxVVJDWnlQdHBQcFRvbTlQRW1veHhYdVRudmJ6NzdJdmRK?=
 =?utf-8?B?MUZmVFlNcjRaNzlwNHdqNDhabWJVVmU2VnRQcEhtUHJtcEQ0M1dIN1JXMVlo?=
 =?utf-8?B?L3U5RE1hWUdZbmJockxRK0hMdEw5N2tlNHlCUU5ITmxUMmlPQndzUnQvN1k3?=
 =?utf-8?B?RTZNb1Y2U3IyVkIvam9reUtIK3hvekQxeUZid3hveUdIdGhhcUtNaHJYN1VS?=
 =?utf-8?B?M1dTeHY3RHBrZktybmNHdWgvclJIZjN2L3ozTG9qUzV5d01CZkJTVnZ4cEpU?=
 =?utf-8?B?Y0RINWN4YXBnbFZ4YW9LR3ZkQzRRVE8xMG1Dd3R5V29wb3E2L2FENXFxVytT?=
 =?utf-8?B?S0VuZDlHcktjdzNsZ2crdGg1UzM5NWdKOTRtUGUzcE9NaktnVkRGOWpVQ1Vw?=
 =?utf-8?B?WlpvUXYrSUN2ak9Zak9BVUQrSWdNbG5jUGZxVjVZUnI5bUJFSzE5Um1GNHU1?=
 =?utf-8?B?OE40NVVpUnRvMHJEYWNEY2pZdHlnVC9ZN1psYlNPbFRvRy9UYXFHWXVqeUVm?=
 =?utf-8?B?eWQvYWdUN0VKU3JobUZNbGhubFNVQ0lRekZXN0p2VjBxU0g5cEJpVTVEcTJY?=
 =?utf-8?B?R0I3NVFITDUwQzVqT0dFc3AzSGlZSnAvV2JWM0ZHZ1VwRzcyeW51Q3ZZalZj?=
 =?utf-8?B?dkZaVVcxL0ZWR0thOXF4UHRaVi9ic1dQdCtRS3ZEcC9pUURMZlNoMk9UMXJR?=
 =?utf-8?B?bC85NE44RVRuQndZTGVlVjBxSW5LeE5JNVhHcEpONDV6SkVvMTc3czJtVkY5?=
 =?utf-8?B?K0p1allnVURVUUJ3M2k5bWVOSTJUQmw2eGVya1JoY2dYbVVFYk9CNjlBQjVX?=
 =?utf-8?B?dnYxODZMQXZwcUJHQjFrT1lkVGI1bmxGMHFFUFNSU0ZwOFdCbUpaa0tFTFFB?=
 =?utf-8?B?L3BsczVWZldjekd1azhyK2hEME1ncDdUZkRYRmYrMGM5TE9rUUR6UmlRQXJR?=
 =?utf-8?B?d1JTcW1EQkMzSUZ1SnlsSTVvSS9iamUyLzNYK01pcGo3c2x3TDgwYnd3QXI2?=
 =?utf-8?B?QU4vN29pQmV4TFBjNHhrZ0pmRHNVNXVBNHIvVWhOcS9MT2syWnNXWEY2Q3Fj?=
 =?utf-8?B?WEJXaFdDdDlib09rYkhUSVJtWVpRWkk5V2x5V3hTOThzMW94WjJ5VnJDNTNv?=
 =?utf-8?B?NWxocFFlV3JpTmRlL3MzUFJWamEvc0N0WW03WmpCamExT3BBYkhtYURyT1pO?=
 =?utf-8?B?RW1SbVFCU1RNMUZ2b1g2RkhGNnZUMExTS1FuQSs1eTZEK1BHV1I4Z2JtS2R4?=
 =?utf-8?B?NU9NczY1N2JyRXFFN2FvR3NHV09sbk1TMU9ITFgrck1JMmRVUmNzbXg2T0pD?=
 =?utf-8?B?VTBOdVFodi9RSVhmVENZd1U5RHk2Y1IyVTN4THVxRTV6NUd3cmxybDZIamtR?=
 =?utf-8?B?MkxISkU2Z0NhbTdZL1ljWTJoeEwxK0VJK2FtOHF6bUpwREM3dmRaa2NwMTRl?=
 =?utf-8?B?SnM0ZDJ1QzJxSStvM3hMblhvK0doSzB5bURmUkpXZXdkcFRxaEtSZVhGalhR?=
 =?utf-8?B?TVF0bE1YcEdrdE9RUXhpL2tuQ2M4TkIySTNnaVdlcjlHWnlmYkpFaStRZXNn?=
 =?utf-8?B?S1gwNERhbzRuK3FrQThrclIzckI4SGFUUk5ISXFkMGhDL01VbGhwUDFlSWFB?=
 =?utf-8?B?ZnlMdStJamRpR1k4aklSRnlpenpNMDl5UXlHWU1ZVDc5Z29HVUNWUjRyTXI1?=
 =?utf-8?B?MkhOZ25odDVGTUlZZ1ZYUk5kbURZSHloTlp0YUFkOEcySDczZHpZbUIwMUpY?=
 =?utf-8?B?RnE0M0diQWl6aDVvMVNjY3d6VWxFaUx6VFJKVEFNVy9ERkVkNWQ3VzdvbG9j?=
 =?utf-8?B?YTg5RGZvNEQ4dlNCdUkrSEtPRGp2MVprQjY3emJsZlY0N0RnaHRPb1hsMXc1?=
 =?utf-8?B?NDhHbTVTbkU3WWd5bmYvL2YxbTZJZUtXaDlYUE1mY3lEWVNRaXEzd3Y0eGlB?=
 =?utf-8?B?YVV2d1c2S1NjS3pkMkxNZExLakVhaXZoeFc5WnV0UzRYUzlzNXRJMUExMGhn?=
 =?utf-8?B?M2RMeDdEZTZTeHYyVVgxR0FDL1dZSmg3czJlelJVNFRqTVd4UVVDOVoyaFZl?=
 =?utf-8?Q?e5aP+4x6FkZrD/3U=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c38d1f-1469-46d2-7885-08df38edc5d7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:29:58.8441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKsfqo5yOXAO7sLh6nw7ARBya0O2qEv7GJPxk+tjzkRD8XICyvvxwvjJrChgReSxIAoK+4Qj/i/JyexbB8t82S+dTXI2ydqPc2SBUvs+VoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9675
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 31.10.26 15:05, Simon Glass wrote:
> Hi Frieder,
> 
> On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
> 
>> Patches 8-10 add sandbox tests for both options. As partition names
>> need GPT, patch 8 adds GPT support to DiskHelper in fs_helper.py, which
>> the RAUC test image now uses.
> 
> One thing I'd like to check here. sandbox_defconfig is the only CI
> build that enables BOOTMETH_RAUC, and after patches 9 and 10 it sets
> both new options, so the default behaviour (no name check, MBR image,
> boot script) is no longer built or tested anywhere. Patch 7 drops the
> script-loading code from the build when BOOTCMD is set, so the fix in
> patch 4 is not even compiled in CI, and the 'boot.scr' in the test
> image is now unused. The cover letter says the options are empty by
> default so that existing users see no change, so I think the default
> path is the one that most needs coverage.
> 
> Also, the new tests only run if the defconfig string exactly matches
> what the test expects, which is fragile. Please can you find a way to
> cover both configurations? For example the test could override the
> options at runtime (e.g. through a field in the bootmeth's private
> data, defaulting to the Kconfig value), or you could keep a second
> image that stays on MBR with a boot script. What do you think?
Thanks for mentioning this. I think I will try to rewrite this to keep
the options in the code so they can be overridden at runtime for testing.

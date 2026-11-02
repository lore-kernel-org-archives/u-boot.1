Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED5606A326
	for <u-boot@archiver.kernel.org>; Mon,  2 Nov 2026 14:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tvgvqEth;
	dkim=pass (2048-bit key, unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256 header.s=selector1 header.b=a3JKcG/V
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2BC636062B;
	Mon,  2 Nov 2026 14:12:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VLnoRor62TOj; Mon,  2 Nov 2026 14:12:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5399C60658
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793628724;
	b=K4rfX3dIVNr49/clWqCuSS+SI9Eny6Q9Yffg9jzrqh/JjRuZAmq4qrBUs3t1Owe4jN0H
	 F1IuBSt3tPc/eKgvPUfYLOGC/QmnuvpGHQm38uCQN6Hek/X5XEVibOPxNfZUpY4JPSZh3
	 jNFccAfJ/bPBKj92YsknAVDxS8PQWnnwKz7iakaxAhMXQhDEsnEIcbF3AV8IQQFLkyG32
	 85s+PgK0dsk7Jiq2HVCqexjFKYJ+LTj4P17ZsxNCV+AjGvSkzeLXkC8SGAu964yHz5rzE
	 k/xIB1mL8z8rrgfwYBfbCzXN5zb0XL5OQR7fo0fd2w3Vjh6kqHOH8aVcYthhsjwVtFA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793628724;
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
	bh=MbWBDdDg7bw4JSaYnaOgNwx5sEgR7mAgsTKcQRRMiNI=;
	b=bHfWWnX69o+N/EYbbMPN3afe9PCGdnxgETb2VvkePKon8zJHLm+E4NW8U8+hsHV1sBUr
	 aTPdrDLb8kBDJP7NgU2dkeXjE5wWEZgZZ51RMFl7p65+JeBezBgJ5GRl0YEUTJG/vQ+CB
	 G8l5/o8Y7AbzBLAr9r+NUimSQl0dejCz+XIqPfGLK7TjmotazHYNQIiMhchHDg7Km6aTP
	 gONzUPjv8aakxP79ajhJnV+2RFfd0uxY7eqFNONQjgiSFf37h/h2FpcSwC83tkm+v6Btn
	 PvvGs1oXfF5mYrnC7CC9JAhZwGHMUbkzdgikJ3oecOn2e5wzxVOy3JQ67PCjeY1sNCw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793628724;
	bh=MbWBDdDg7bw4JSaYnaOgNwx5sEgR7mAgsTKcQRRMiNI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tvgvqEthK3QVCoXsw9U4hMkPFi763mZ2PtOFfIHuMgpCluI85VdTHN/hSw6ozxx9E
	 PFh8et7WG3RftLjBzWrE5pq+5SX/YUoy+zZxvMy9UzE9SPKtX3S+fEMowpMkvEACSo
	 oufxH48ENB0zbPuBVlSDO24dWevI40NqL9cYRp+tOGBwy7rpmzK6O7NiDe9OLqe8hu
	 40Xjn1u+486tbV5WXgSM14usAGIkvMhLmkNcsVMRmpFIeD2mH2ts92KDO1QqWyjKGF
	 RSwWVNMuCHWq+fcqbn+v6ak1v+idfspAjja01HVTGs0wixd4jjf7Nw1uDvfNzf9EJw
	 oR+godxjbktXw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5399C60658;
	Mon,  2 Nov 2026 14:12:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 75ED42A8
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:12:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5BA4840687
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:12:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bZMVqOFj-JrI for <u-boot@lists.u-boot-project.org>;
 Mon,  2 Nov 2026 14:12:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 921494069F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793628721;
 b=TPjD2UUGUUbvdBd1Rj+wZVWWoZPnviazaH2uuthHKExqyrKNGONand4xNALx40GH/g5T
 x0Ik9nYgD8/cpChVEo7lRvVtk4iiysokuw2Tvq1LhMCTqcVrj/FtZk3SlL2vJJMnKjEwv
 /i8c5XQLYP8rcqIt0rZDCaTfq6tpSuQtUUq0vODSN9OoSi55vi1Ibb5CHSQ1Ujd54xCQu
 iWGBZwbVZ/iYjh8SUcYF560sR3GJceZTTBIWRuNjhzixBYn6GUBOO5qG2t3XBQ5ifQavg
 RjO7CS6mEhWt/EIBKKoOUrOiN5jBbsPZGe8q4OlDlCBaBCnvRmrlozDTVFhTR8jcjcA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793628721;
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
 bh=MbWBDdDg7bw4JSaYnaOgNwx5sEgR7mAgsTKcQRRMiNI=;
 b=seV3ee5KLKXHHw1KggEXfnJ6nC/9/gXY2QnFifevQ0dE1Ojckzsn9kQyIqtl8M/GmJrO
 l6cCBcpwL9ZOyM/PLY5QNR4wfMauDuqsSwFy5WIRqEjx8mBwMQYC/WU6bg2dCmhqet1QZ
 hO2fZMGvRkVtjQrKIwZ//n80tM8ktJVwpOU0m2Mmu+qg9HxMeHm01B/JOOXQvgfVSqoHs
 bTotOY0qnY1N2X/IVGiBIbuJym6W7oecZdWe4WdmZ27Sc/xR77f97KZPG0OwwfnR3Z23r
 im+TO6iFTBkr5QRVNliTLYl6z3CNPFfSKfPyIL95SQGXRFOpNGTewo7BTA9i7T6kyog==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=kontron.de;
 dkim=pass header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b="a3JKcG/V"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=a3JKcG/V
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 921494069F
 for <u-boot@lists.u-boot-project.org>; Mon,  2 Nov 2026 14:12:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fDzR8O9XWIsz484v6dGHBqCuwBFEOaG5W4yHZkg/DTJbjATcGdfeTveG/3i27CDLOXrz55LdHgGKBQ6e0Nz3j57k0zPYirSUGO13uDTUTVQJJPiJeyN8oKLBVhvMAnDoAxZb0uSMeGfv5rnA0ofR6S8p705N9OAsMA/OKvxAYC7RE0NV9HkWhOC6uvYgLNAk8OBvO5VDaRHcL0WHum4rkN1+ZALfteAIlon0E0fYiJnoXgrVL3s8sWyt0olFRrQOIZ4IwxgqXklhCFGhc73Rn82EQ2FpBDCfGauh8ZdFYCudeqxZ+udDl7vbJB6Rkl1gU82eHe2hfJzbm+W7l80POw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbWBDdDg7bw4JSaYnaOgNwx5sEgR7mAgsTKcQRRMiNI=;
 b=VktxqeRiGW5YD9LUnudf2ryNUdWjDhVrri12i6hpbCBbAFhhtfzs61H7EdukT6pCrEYfMpLJJ4eMv/B0nmOwH/sIONS6RH4H6obmcKdyJDJjGy9SAQwMfKf9MKDmqDi5fz3UTFKhAR4D2QmPcScInkBvOjHFPHFI4/HL5yuh7vef9qNfNfBIttqngirI+0ngiuXgcrDv3GFTZihk3BBjTEIYMQUWLj4r08aMJjsSFwcNs5J/1S73JuSUsqJasxOgASO0P2uDVGOWVwxqhX+fBRlq7TQOQtKBRmp/ZMzoMHGIN2TAgm/UNdWb0M6pvU3NXMEuuP8ls6ErTSI2bi5/BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbWBDdDg7bw4JSaYnaOgNwx5sEgR7mAgsTKcQRRMiNI=;
 b=a3JKcG/V8gb6xhuUtHiOzDiwrHTJ6M4mb/lQ2LOEbItXM38wz1tgQlM2qN6T+yMSWkSwqfjeGrAGGd5qsvZo0FsABERljWEPeHCUcQGeeJ3vaTPBzMV6VqK8NUNv64CGNZPPCz2l4CmHnWdelPGEWkGNyt23dw6aDWRQn1DO9kKhYok1KEpmCiozLV2RmkKqaROGBTKwDjFKZVCqd+R+9Oz64BSsTP6TNvDM/eCQkN30RoMK+68AUjC/WEha5p0b0kAMY89Yx8u2/P/YQ748ayTrgZqroC84rVEBt0nj+zutWzIWRN8VE29leDJALFWMq/msaRrOgyxxKX8YGW7HGg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by DB8PR10MB3292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Mon, 2 Nov 2026
 14:11:53 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%3]) with mapi id 15.21.0592.007; Mon, 2 Nov 2026
 14:11:53 +0000
Message-ID: <4d9994c1-b48e-40fd-b75c-1127986dd31b@kontron.de>
Date: Mon, 2 Nov 2026 15:11:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] bootstd: rauc: Fix overflow of the BOOT_x_LEFT name
 buffer
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
 <20261029-main-v1-3-b5a878627107@kontron.de>
 <CAFLszTgDO26qJUY+3cw1J+mPaofueYyEGUe=BVWmDH30RgA5ow@mail.gmail.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <CAFLszTgDO26qJUY+3cw1J+mPaofueYyEGUe=BVWmDH30RgA5ow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::9) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|DB8PR10MB3292:EE_
X-MS-Office365-Filtering-Correlation-Id: bcb658d0-9258-445d-f375-08df38eb3f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|23010399003|6133799003|3023799007|22082099003|18002099003|10067099003|56012099006|261009223027099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|261022075727099003|11063799006|4143699003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: uyaGGxS+GAwXnDfmzFjt1Hski1zJKqblG8mIkLNWUKaRQM6gMBtsVGZ30OdyesYZCGTMkRT9Mly9AFxHRZgftWuPKS/wBAA31l5ZOsf7/XNWqS5MQ69lQKEQaMv/zF5zaiXxxI59C/vVhzoCxj8bwgfHH0Ghjg917lVudc4/Xw+Cmcz33fBSr+2W9f2PjIe0TuntKzz4DJrTTtNAi7waGAaWgFwZ+ekmX2DsDCCm291AFu9d9qQq60aId1bQEe0gjC0m8M11tPU4K8NZf/iiUHqJTRPiOa+1C3BxKL8IR0LCiPjNiyJIf9y6/Vcj+Pj+oqzkP4HMmxSBffaKECFzafF4rT15ERNiQeyykm9HliOZBoFOeeC+OUkCVhwJaBTrpyV0P3QXvH6wHFie052Z3/exlxLjEy9cnWFuhciHJoGVbTevaLk+WmWnPEDSN1qGJlRAOaLT5GAzEiblFyfWoWF2MYEdBy09Ica4cVPafYCKM6OoxIJumhSe5z5YB0F9Bi3YPRk9efg8t2cpQg5Hx7DVHpjZY9VG1YZKlsva5+aYgjfVkvCRpIB+0obM5AcQ5EW3r5WO0/KGJdGiprgzD/yf7WS7SNZlKCGvspuOCh3/KzMMxOr9ngEht3d4tqxmvVXwdJQlE8l7ThcnFU4a7UjdhQ7FuEVcz3WKBsuzrxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(6133799003)(3023799007)(22082099003)(18002099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022075727099003)(11063799006)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amNvc0NiMUZEZjB1dVQxK01KNC92aitPWjJzeEJSZnBVVCs3RmV5UnByeVgv?=
 =?utf-8?B?TExHQUdqQjVWZFMwVVBOdlRxbXo1bkVwNnpvcXVZL0RqZlRrZWJJVG1vaHpR?=
 =?utf-8?B?OFFWRHBjMk9KUDN5azlGWFU1R3UvWVNNQ01FaG9FZDFQK2lRRmxGVWc0dUdo?=
 =?utf-8?B?cVhkUmdyRGorcmdVSmRvRTYzcDRFRXFXWkh2ajlYVThmZjUxMlUwZGM5TzRC?=
 =?utf-8?B?ZVQ0OGVCQS9ManIzZ2hLU3BRS0ZiNXJtT3dma3hnclQ3S2VEalY4ekNwWTkx?=
 =?utf-8?B?cWZqVVpjRkJHaWtFMk1xbTlEUGU5MytjNTNDYWdVN1EwWWZ0ZlZjL3RLOWtC?=
 =?utf-8?B?aE5sTEptVTNPSUkrUDV0ekxkaS9EeXBmMjNPL3lPeUQ1RnF4MjlJbjNYbHZ2?=
 =?utf-8?B?M2U4WHdxVlJLV2dtQVBHelpPajhsT0oyc0FSL3J3Q3UwUVpiS3VKaWpzNzht?=
 =?utf-8?B?d1YxVmltbS9XalIvZ3hwc1VBc0JKbXNVaUIrcGdjenFhRmNPaGsyaWVsb3kr?=
 =?utf-8?B?YnpqanRSRG5hdHVyY1dDNFdKaEMvSHNxZUFUbG5XVzI1cTRuNFhubnhjcU9O?=
 =?utf-8?B?K05NL2k1TmtYY2NBR3l1eHo0YTZBTmVsUjFwWEhhZklUMVhSWjROWHpVOEhx?=
 =?utf-8?B?MVBBV2YwWU5pQ0IrR2ZrQkFJekp3ejYyTi8yMHRqckEyY2lpNHFoOUMydytW?=
 =?utf-8?B?T3JnRWFLajU0bC9Pc0VZcDJvcWlYTU5sb1FURGx2c2NpZnp1Z08wYXYrVlE3?=
 =?utf-8?B?R3dWUlBmV0pUTGxkMnJ0cm03N1dtUER1SWN6VlRORm1TWlIvb3Y0bXhEY3lS?=
 =?utf-8?B?Znpsamh5RHNHbWUybFFETFB6NmxCTEdmTmwwMkNEZjJkMlRZVjFaSlJUYWVh?=
 =?utf-8?B?OWMyRUNmUlF1YzFxODhLWE0xNURqYjBPOW4wdWpYckt2ZXlrZVUxYjB3eFVQ?=
 =?utf-8?B?WU5YZjI4K2MwclVmYWNlallzalM2bnJNVFoyeERBenJEODlnYTZLcWg4MitT?=
 =?utf-8?B?MUY4SkxNcmo3ZS83cVlKRkRWRE5VL1NTUHprdEFnV3RWSHcxNE0rV0FydC9O?=
 =?utf-8?B?YlpNelVqY0M2akVrQlZTSUpvTkVESFJOemN0eE1hWEhkcVoyaU5ORjBtbnJa?=
 =?utf-8?B?dmRVRnNiMGc1LzFFUEdRdGZGV2dzSDFNUHBTQUswbU1kRnNFRGpNejdIL284?=
 =?utf-8?B?eHkvZUxKT0NXTTNsTFNJUUxiRzA5Zmh4a2NkeCt4Z203ZkxLRWJ4bk9EbldR?=
 =?utf-8?B?bXZFcTN3dldJaDl1a1hJN1pnWFBibkxlOFN4OEFpdmJOcFBCUGtqbGRmajdL?=
 =?utf-8?B?MWNjNXVidlJiSHBnNHFTOVVjTlMrTzhjb0N4VHhKNksvM0tLeVlFd1FqdEdU?=
 =?utf-8?B?L3QzbUFtS21VZkxaZ29xSVJiVGRCM0hDaEVTTW50T1JTNURxVmdTL2RiOUNQ?=
 =?utf-8?B?Vm1HVGlCNURlV0lpQzFjUlFFQkVWUkFZUWdkMHRXOTljN0Z4MVhNN0h6aFZ6?=
 =?utf-8?B?Y084SFhEeXJSS210K0E2cXBsR3MwOVV0WVowQVpNWHlmY1BnNU9BRnJSZjlR?=
 =?utf-8?B?RlgxNUg2cUxZMWc4VXRwcXVWMExLU0JMR2wyekIvVEVCOEVOVEJFNzFBZFJx?=
 =?utf-8?B?SHFuY1RNaGc4V0Zpd0RGdk4zVWdiUEdkc0dpdjFGZlB5UGVpVEVReWROanlr?=
 =?utf-8?B?MzFudzcyZ1hMKytHTjFwTm9vUUdMV3BuRXVrSXRPVTVBS01lOVFKQlRTcU83?=
 =?utf-8?B?TFFzeE5qNHcvYzl2MnBCdGc4M2VGbWhLYTJKT0tsZG1yY1pKY3lvbE1Ybk4r?=
 =?utf-8?B?b2UrcEFLTW1nS2x5OTFpTGd1Z1RHNFFWMjMybUxKa1drNjdPSEtuNHdCeWgz?=
 =?utf-8?B?UXBwcEZwbmcvTmhjYlBTNG9pMkpxc0RPR3pMZ1R1OVNUZnE5aXRpT3VZUVo1?=
 =?utf-8?B?akg3dHc3NmU1VElwUEtJVHhZdnBwOWNkdHl5MVBvSjVTN0FaKzFPYVRmY0cy?=
 =?utf-8?B?dlg3UytpUkhaM0lNZVVIS2JYRmpzSzZya1Q5U1BrUHBwenRPc29sWWFyaDF5?=
 =?utf-8?B?d09zbG9XZDd4NEpua3NrWTlhTHVXd1l1SUEwKzB0eU8zOUJhV05sU3hHVGpS?=
 =?utf-8?B?NzJOb3lUWDl3ZUlkRjVhK0llK2lOL0lhQmxobG82enRoZlR0LzNOSlF3cEpN?=
 =?utf-8?B?S2VydlZ0cFRPSlpCSmd6WUxZdFZyVWdDVk10aHpxRVhPSTZVVVh0eTFLOW13?=
 =?utf-8?B?Q25PWkkweE44ZGh4VXN2T281MVhYcm5PL01kWmd4YWVqd2hodXdLNENySnBq?=
 =?utf-8?B?cjUreGcvQU55ZkJWaUZCYzBNM3FXOXptMlUyWjdoRldnM01yOGR0SUl0Y3BM?=
 =?utf-8?Q?HtdekaiuL0rg1tT8=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb658d0-9258-445d-f375-08df38eb3f16
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 14:11:53.7810 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZcswYq14w9DxpLIQhyCF2I1jlIqzw+XJfF9YjqIfRgy4bvGeN8AWfuQHKRRV82tCgDz+ojqo3mgCX+Gvxep4oTBfWRjsCT9Yjsb957wR24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3292
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
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 31.10.26 15:05, Simon Glass wrote:
> Hi Frieder,
> 
> On 2026-10-29T16:23:07+11:00, Frieder Schrempf <frieder@fris.de> wrote:
>> bootstd: rauc: Fix overflow of the BOOT_x_LEFT name buffer
>>
>> The name of the BOOT_x_LEFT variable of a slot is written into a stack
>> buffer of BOOT_LEFT_LEN bytes with sprintf(). BOOT_LEFT_LEN leaves room
>> for a slot name of 32 characters, but not for the terminating NUL, and
>> longer names are not limited at all.
>>
>> When booting, the slot names come from BOOT_ORDER in the environment,
>> which is only checked against the configured slots when the bootflow is
>> read. Setting BOOT_ORDER to a long name between 'bootflow scan' and
>> 'bootflow boot' therefore overflows the buffer in find_active_slot().
>>
>> Make room for the NUL, and write the name with snprintf() in a helper
>> that fails with -E2BIG if it does not fit.
>>
>> Fixes: 7e5c2c782fb9 ("bootstd: Add implementation for bootmeth rauc")
>> Assisted-by: LLM
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>>  boot/bootmeth_rauc.c | 34 +++++++++++++++++++++++++++-------
>>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
>> diff --git a/boot/bootmeth_rauc.c b/boot/bootmeth_rauc.c
>> @@ -167,7 +176,10 @@ static int distro_rauc_read_bootflow(struct udevice *dev, struct bootflow *bflow
>> -		sprintf(boot_left, "BOOT_%s_LEFT", default_boot_order_list[i]);
>> +		if (boot_left_name(boot_left, default_boot_order_list[i])) {
>> +			str_free_list(default_boot_order_list);
>> +			return log_msg_ret("env", -E2BIG);
>> +		}
> 
> This is a build-time configuration error: a slot name longer than 32
> characters in CONFIG_BOOTMETH_RAUC_BOOT_ORDER now quietly produces no
> bootflow, and the log_msg_ret() output only appears with
> CONFIG_LOG_ERROR_RETURN enabled. Please can you add a log_err() here,
> as you do for the missing partition names in patch 6, and mention the
> 32-character limit in the BOOTMETH_RAUC_BOOT_ORDER help? Also, the
> other callers pass on the helper's return value, so it would be worth
> returning 'ret' rather than repeating -E2BIG here.
Ok, I will fix this accordingly.

Thanks!

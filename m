Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C799A606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=v6p1Rrug;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=C2foqAHb
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9903B81B71;
	Fri, 30 Oct 2026 16:04:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f9fYecsWQyxS; Fri, 30 Oct 2026 16:04:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C475816F8
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793376240;
	b=ai6ssXh/fs16CWpy4F2fwz1O+G6gYUX5TsWSN4pd4pXzY4eKh+ZaqxVXO48J8BTsqGVu
	 sWoVCX7iYmGdXrEHxawMnfGnQjZZWB5yA5rIcQOZ0Wovd+/mnrkfMI2bP1GSrQZ/893Zw
	 EhiaCOM0jTmqofpb+uMicVBSnQ3y+T9/DJZ/bQFBAULxroX2Lq5ZwZLo/AsngOQXSMdC5
	 O8gTkWziMQIVGSKbtRrTA2lUTcFUIHIkvh2i1I88NycSTG/ywRcQMGr26UK6aQSK1FJIu
	 axwZVZL/O8XmGY8n4anBN/lZ8WSTAA/peRLaAgUKcbofKRKYLWQktAdmG9owTyYFkGQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793376240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=a+THJCTN4W512mv/UlzE8U2XeBfutO933yCqu1mMGZY=;
	b=jqlMXsJ6+PSAJJIL7Nt/Z7RClCymriMBBxFw/Zs9V9toZyXm2NeAWaDbo2BFEK03M+Mf
	 RfV8YFd36bvs885ob3GS1+hiGlk5Ey2rYFfMQIADxYhTDHg0MjJExoPRT8FJjEdEYMHRt
	 gT90QP3EhONYcu+K8hhprQOJpow4xuR56ojTn3lZL0PKak5ZoQPpbRkgtMZwgssVYDHTd
	 5UP6VH8SHowfwXMOiMuecnKKrlWZUt0nEp/tk1au5sPbPJc//illUS/HqWYR1bph3ZP06
	 i9F4B7LPrHzaFG1FxUFLNMOQgcDgZF6j92BW8Roywa90NhtsW+VXfklqoaj2WqZfEew==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793376240;
	bh=a+THJCTN4W512mv/UlzE8U2XeBfutO933yCqu1mMGZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=v6p1RrugDYPjiXAjPO9VqU0ZavWw98jH59EVZ1L0Fd2yRrEZku/SLwaLSqaXYrerv
	 1ZsUfK/KXaIrGiR65Ub6gTpSLd1tsr5FBtrL/Ac8PvoL6DZsIopT821tBMM1JoH1Et
	 onZUGmfYoWI0IKSaVcOVLJQTavq0GJ2x8/CskXJoWzAcr5PEIgVI8RGpCozXgGy5hj
	 FwZuJFmuidy3b7o2ZlY3IAXV6vk1ISprLrF2HrCBMhZbkfEJJMe49Jcuok8btOCMOd
	 TYkg1NvQ8XkThrxUOH+WklwLssv2oEt/Jt3KMcCUZD6nHmJrYWzKmbhi22++aGDJh5
	 Nev2FuFCSNwrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7C475816F8;
	Fri, 30 Oct 2026 16:04:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id F2C2ED38
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:03:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E420A60A99
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:03:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qCyB9QTpruxi for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 16:03:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4EF28605D2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793376237;
 b=hIENiqviaMBN2REma0oIKeeqZAoKXomtmzmxor+fAKkW8H+OMIXaFl12HjD2oU23ue75
 GPDAmdcccx19Z1mxR4mepjHMmPloG46+jmPqafrMllPV6dhR+s9dooEm6+quHFORY5Qit
 QFeA7NB3reJOBclJweL0wehag3Hr062UCthjZ45Efaqm9IpMF8Y4ZmB5M7wGE5ynldht7
 HZYCNz/yxqsYyxVocooyVAqZmKCHMJ0mGBzkrqD2DNj7fT33UW+rMAQ5GhoDiDAz27hoA
 GVxElo1zgoDkxWLnx4NCvs2aQc8FdEc0inKDps9pVlPMNBRuw/yt52bdqAZ0Rm6A/Rw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793376237;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
 bh=a+THJCTN4W512mv/UlzE8U2XeBfutO933yCqu1mMGZY=;
 b=dVQ3bPJpI0/YfyDp26ZtkvGp3mfJs+IfOLRy3f0NuMIvR/nHzPhnTbeX5bfRQ8oGZma1
 o2Nl4iORh3GfrQNYnfy4PVwRPzhyF/zRAJdC8eASMR0bC2fWNdd3DWMH3f3erE6o7Mgyo
 Cw0jQf6ZphsjLpUaadhfaTYu3rsAnbHcrhNiOoHDK4+C40l/bZl+LjQbs6D9FbrTguzkz
 4vTOFxqZwHMv7o0RxgDM+SVO4iDp1kYS3Ml4vVAEl8kNQPIvuYzenEW2QIApq89nrHqn8
 JI8cYl9XQm5kdqAuq/KoXk+dO21GWuCEkHgpxzj7nP26kh/T1qcy0EdYC9YXIOYtSww==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=cherry.de;
 dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=C2foqAHb; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=C2foqAHb
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4EF28605D2
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 16:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcBXgvgg6odmGvdpafwPzc9EA1G733W//nD6d9ei67lzxFd/W4zgFctyEQHCmko2ztsOQxJovGLVEbx3Q7L0Q1qgn57ViLYzuQ+g4UIL4Ibdfy2J3SZUZWQu2WIKB89JVeWdj08Z4XhVAC9gyRK84WvoRdPsJhpaohKMhMc/8t1FZQnsChkU1/OY0QwX+rea1sA4Q5kXVbAqyWacMq0i8gyKr8KsKS2AVyLfuogFnbOYi438rE0Swjyl3hBvA0JpaideKKSwhrThnMgG58YJzUXFQocl/qHEaMeO6Ep1AG+ohqdIzaDl+VSZEaLqxwgf5LkpObA2X2UFgfd0sLNBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+THJCTN4W512mv/UlzE8U2XeBfutO933yCqu1mMGZY=;
 b=ubHbciBu4Dl97XtbFIc2IS2pnw661oGxkV/Batkeg+amMhN+0LheKrEos0Wm901r3xQs96BILZmWHKIoNopWTeBOq78fe+ghwRcuWcf/BnKPDDHg4plNQr7OEJSk+2v1/s55IQRz4Jg1+D/amKJVq0F+oH5S8uMhrLcXavTm87AAonltBlNYIOQ0Slp8DcvdyaCA87b2thIQ6c21BepxLZu6wrkDHWLspH9PSMkd/me8HiXLQjfN4+LT7Bhprpe8DtqEu3RtzXQixBTPlRe3Vrx05e4Lu+Q9ZilJKakZUY7bUKJoZhSv2ihAKTf5NWkzyjcOwXuWqoGXELFhX6D39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+THJCTN4W512mv/UlzE8U2XeBfutO933yCqu1mMGZY=;
 b=C2foqAHbu3r9dgvSYDKsWFYX0t/W+mqaXvgPe/fymp1WuGd/0Opco3nN2Bi6s2OGAVrquwJWr+oK72BJzxaLGQajN4E0ODAyMv4O4YwMDmcNvgpf2NkqtCn7ffBv5BkGQjSMw5QXmJrcfBnwt656yzzlI9sbU3vWf6kWsYxp/pE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 16:03:36 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 16:03:36 +0000
Message-ID: <3e11589e-bf81-4172-9bda-e079a1ada057@cherry.de>
Date: Fri, 30 Oct 2026 17:03:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
To: Bradley Morgan <brads@mainlining.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261030020832.26572-1-brads@mainlining.org>
 <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
 <20261030142436.GK3011578@bill-the-cat>
 <17235E63-E2CD-4B0C-873C-79418E350EE9@mainlining.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <17235E63-E2CD-4B0C-873C-79418E350EE9@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: VIUP296CA0051.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:34b::6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 7526abc3-89da-489d-a852-08df369f5ad8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|4143699003|5023799004|11063799006|56012099006|261009223027099003|261026135527099003|261026130827099003|261026140227099003|261022113327099003|261028144727099003|261026121527099003|261022115727099003|261022105027099003|261021133027099003|261022075727099003|261021130227099003|261021121427099003|261021135927099003|261021123027099003|10067099003|18002099003|22082099003|4133799003;
X-Microsoft-Antispam-Message-Info: qOTv9EKIx0vJn7kgYuswfVDELvnCQRZuodfsQTI3YUkzU/515Yg56/GKtWl4S5rMBqFajnlHYjCba60uS636L67ikM6eABKKkjf9hbBJYYrMoK+0Qm5AJK8U6JmNuK4c+JHTEXbQO8BbyT1hpyx4VBFceisL+i57u8qrAwY/nd1e4mxaq/jrehLDGLg6aOEDv0FJmV4Lhf3D/+uM8k7rNILdApcc7ImJE86JRexqKmtznQQPnqN34qdVuItHv1YePQaeAdvvOP1ZCTFk3VUsToZBIdRmTlqBdcLPtgL/db/4sSFSuJn41r1Gfy5fBXAuQnK1KldeWk+fi/unO1A/44FNf+QDCS7/3IzYLA+h3HgdC9RHj/ADyYsw6sIfoEuM85kDwq3igNzOxZrA99cwA49FelmOXfj68Kwaf+HgKMp/QoGoz1dL8HF1K0TAjiBLXKF/NXFaTFnnVQOrpPPlR6i41GjRs37uUc5tKIVJbvrc1uZ4xrJbvF8GM2mwvAExEFHsUx+I1MFVpFGeAZHEbA/8iK3X7HZdWyiEiQeiDxroLc15AkMYVfKYMKAPufTqCRx3k7doNkl2K81lQhdFOEp1YKotJYs3zm78t1sDeKZ4Ru55p6WciUmKCbPMDUnu
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(4143699003)(5023799004)(11063799006)(56012099006)(261009223027099003)(261026135527099003)(261026130827099003)(261026140227099003)(261022113327099003)(261028144727099003)(261026121527099003)(261022115727099003)(261022105027099003)(261021133027099003)(261022075727099003)(261021130227099003)(261021121427099003)(261021135927099003)(261021123027099003)(10067099003)(18002099003)(22082099003)(4133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEdLTXd4aHgxZnVGTDJtTXZuV3JHaVNrQTVjZWtIUS85bnFiam40a0ZBYi9G?=
 =?utf-8?B?bmo5UEd3Y2FLcEVvMmlqaXVTK2xUTTJSNXBMZjhmd2JKYWNBcE1QYUxlY3BW?=
 =?utf-8?B?OWUrQ1R0VS8yaGZzb3ZIaWc5TzBkbGt5K3kxNEZVazJBRjNzeG42Y25vbVN0?=
 =?utf-8?B?Z1M3azNnUEI5b2dqNnU2NlJwdlYraHduaUh4QnNwZFFSQmFmR3dCam9TalQ2?=
 =?utf-8?B?c0JqV0NKd0JyelNYVTR1SDZVU2Z4Z2RPaitPL1ZUMm5IMGp6dUNxaUtMeGxZ?=
 =?utf-8?B?SEhjWDhvRW5OSFBXYTZuVCtNUzZ3SksySERUamdhRllKamc4K1RtVHRZNTN4?=
 =?utf-8?B?akxFL3RvS2hXUmZ5NGUxdnN2MnZ4OElhMk11bmUxWXJlRjFGeWRwOG8raGpL?=
 =?utf-8?B?S0trUjFCNy9vU0FYekhNenpnMWZpc1lrSWlWZlc1Wm5sM0J3RmdXSmJhT1Yv?=
 =?utf-8?B?bEVMdHd6N1piTmhxRzJtK1hWTC9maWlMUHZQazZWZlJiMThlay95YW1sRDc5?=
 =?utf-8?B?bXRaa2lkZUVPT1BOaThmZTZvVTE1MnNlRG5HNUZyMWpPSXA4Q2M2czc3N2VF?=
 =?utf-8?B?cmE4S1NVRllUMU0vZXNacjNCUXI4Qkk4TVRnOHVlR05mcHhVdHpLUVZldmFT?=
 =?utf-8?B?SEl2YmxxT1U1cVlDdEJic21lTHhPU29GamFCcEJXcXZublVMZ2VhN05FdEpI?=
 =?utf-8?B?emlhSlc0bUZEcy9ZSUtUckxhZVhWU2ZyWnI1dWYya0tkajhnN1Znb3U0enNF?=
 =?utf-8?B?Mk9oR3NydnNyR2FtTXh3d3g4c0Iwc1dYK3YrcUxPdnlaY2RVeW5SVjR4aDRM?=
 =?utf-8?B?WFU3aEtHSlZ6VGtZaVZnajdNZ3FhSGtreDUxU1ZuTFZ4bWZmUWhmUTlscVZv?=
 =?utf-8?B?K0dheUppR0hWc1p2c3RYaFduS2lWYTFZRVZNZVpEc2FBd1J5Y2tvUmJmWlBR?=
 =?utf-8?B?V245SE5EbzJSRVl0ZjBGRFRpMnMzRThYNitGa0NZeDRaTmJaNlljOGpBaHdj?=
 =?utf-8?B?WjN2WjFZb2lmUU5oQVJPZmtXdzByTzVWeXVLZnNuUlRmRU1WZHFySmtkVDQ2?=
 =?utf-8?B?V1lXaEFyS3FsbzFlOGJwSVBrU1J6T0p3a3FGQVBsbXk0dlhEVXNzQkhRWWZT?=
 =?utf-8?B?OG9ac1lKU1RpVWRvR0VOMWk1TzJ0MGxYaEJmOTQ3VHF3akYvcWxjMjJyYnV6?=
 =?utf-8?B?ckFIQU96dFk5R3pFdHBlQmdVa1JjRXFPNFJvNkEwWkpRVGtvTnQ3eDBvSjBs?=
 =?utf-8?B?bTllMDQxNnZocVpNZm9SMlkyRjc1TXEvTWRnZVRkU1o0emt0S293WmMrL1Nr?=
 =?utf-8?B?Sjg4cTJsWnJRTGR3UUNmZmwxWHhQdjN2MHRuaHJmanhPMm12bVVjT3hKQmVU?=
 =?utf-8?B?bGgwWWpVWEJNeTRFLzAwNEtrUnduOGxCSUlRb2duQmE3NStUVXhLclVzY0FR?=
 =?utf-8?B?QmRpYmJPT0JUOXNXMGw0VFdPb1JXeEtLdmZSS29qTDQ5dHRLbTdSR0ZqeFlD?=
 =?utf-8?B?bElWTFVtak83cDZLa2EwT21hNDdxV0ZRVlJaWXZ6UFdSWkNyak1sK0xwRmxl?=
 =?utf-8?B?eExJY2lIYnFIQ3pIeEZZQklxT1JtRklya2ZOdXU4VUlIM3VRUUllMGlSZmk1?=
 =?utf-8?B?Q1pJODdzRy85UWlBczV5NTQ0YXNBd0ZkSjRkcy9haDU2NjRMWkFlUVhCakM5?=
 =?utf-8?B?cW1oVHhrQVZheXgwWFg2VVVveUFwTWs0bm91eml4dlRnOHg2ZDVsRzh1Z01a?=
 =?utf-8?B?N0g0Mk9PdkVqMWpnYURRNXVOZEdITWpQTHlpUGFKalFjdVVWaWFMUCtyWVQ0?=
 =?utf-8?B?K212OFR2N1FqU1ZqaS9FWkF6Qk45aTgzWkI2L3ZwRUVYTVQ1TnczcVZHRlE2?=
 =?utf-8?B?b3RKRXhmSHNwdEVSNFdxSStTRFdhQW9hWTZhU0hSSnQwdW5qRUhKUk5WVno1?=
 =?utf-8?B?R1hWSFgzVHdMRVJLOXlhdEVZUDE4dlg5UVMzKzBWTFFyVEJFQ2FrZVVvSHp0?=
 =?utf-8?B?bGwzNWlIZmx0aW5sQWZmRndPdWJGYzZQUFJ4Um5QSEJWbFpPZmMvZ1JQOUVN?=
 =?utf-8?B?dC9YUk1LS3dDdW14YVdHbGFBenVydjNHRkxsTUVnVkthcnp0SDhLbGVkQ0ly?=
 =?utf-8?B?Sndwdm5oK3JYM1ZMb0doTE1SYXhjb3VLdUhYclRoYmpOODFHaFQ4NWtTbk1C?=
 =?utf-8?B?am1XWWRxTmN0YVB1ZllDWUhoVU9vTk5wL1BMT3VGSDlGM2JxS1VJMDZiNmlr?=
 =?utf-8?B?YmdFMUhZQ3dqcGJVaDJjRy9pTGFVaHFGaC9rYnU2M3hFZjIxZ2lyZ2t6eG1v?=
 =?utf-8?B?UWNUVWx6TmFCanFsS2ZPdjk5enV3L3RNZitaUjgzUVlpOHV6K2RaQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7526abc3-89da-489d-a852-08df369f5ad8
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 16:03:36.2798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV17iSKvDatRl3mbrkcNfbD1r+O4/OMLqdvKgpdJvfyOgLf73teosfG+Ic07PmYnEJp7kHTe1QxBpK3PfifmdQWlnBBJoNbHP6y+atKGGHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104
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
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Bradley,

On 10/30/26 3:40 PM, Bradley Morgan wrote:
> On 30 October 2026 14:24:36 GMT, Tom Rini <trini@konsulko.com> wrote:
>> On Fri, Oct 30, 2026 at 02:14:08AM +0000, Bradley Morgan wrote:
>>> On Fri, 30 Oct 2026 02:08:27 +0000, Bradley Morgan wrote:
>>>> There is almost nothing in doc/arch/ for powerpc, so this adds a
>> folder
>>>> like the x86 one, with four pages:
>>>>
>>>> - an overview: what the port is, the cpu families, the boards, how to
>>>>    build it, the config options people ask about
>>>>
>>>> - the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
>>>>    CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs
>>>>
>>>> [...]
>>>
>>> Applied to next at u-boot-ppc, Thanks!
>>>
>>> [1/4] doc: arch/powerpc: add an overview
>>>       
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e6a37f4dfeea
>>> [2/4] doc: arch/powerpc: document the mpc85xx boot images
>>>       
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/3287ff140823
>>> [3/4] doc: arch/powerpc: add a PBL guide
>>>       
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b74d2c1efaac
>>> [4/4] doc: arch/powerpc: add a booting and porting guide
>>>       
>> https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/0851db824add
>>
>> For non-critical changes, please wait at least a few days. I'm hoping
>> that for the documentation stuff you're doing that Heinrich will have a
>> chance to look at them, for example.
> 
> Hi, don't panic, I'll drop them if there is issues.
> 

I do not review patches that were already merged, so you guarantee 
yourself at least one fewer pair of eyes on your patches. Dropping 
commits you've said you've merged should really be last resort, and 
should be explicitly and publicly communicated, with changes made to 
their state in patchwork as well, otherwise we are going to lose patches 
and people think some patches they found on the mailing list were merged.

There is almost nothing that requires merging that fast, *especially 
without reviews*. And if something requires merging that fast, a lot of 
eyes should be on it. We've had a case like that a few months ago with 
the critical vulnerability for FIT image verification for example and we 
still didn't merge that fast.

Merging without reviews could be seen as a way to introduce 
vulnerabilities in the project. The contributor rules still apply when 
sending patches even if you are a custodian. There's some grey area when 
you're contributing to some area where nobody reviews or maintains, but 
usually Tom eventually gets to those I believe. PPC is one of those grey 
areas because there are so few contributors and until now no active 
custodian as far as I understood, so I'm not sure what we are expecting 
as a workflow here to be honest. We'll figure something out on the way I 
guess.

You also sent a v1 at 1:49pm UTC today, then a v2 about an hour later, 
and merged a few minutes after. Please wait a few days between versions 
so people can review the latest version and the ML doesn't get spammed. 
If you found issues in your v1 and don't want people to waste time on 
some parts you're going to modify anyway in a v2, you can answer to your 
own mail and specify what you're going to replace (i.e. doing a review 
of your own code).

> Also, remind me, is Heinrich the Hitachi guy? I don't remember.
> 

$ grep Heinrich MAINTAINERS
M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
R:	Heinrich Schuchardt <xypron.glpk@gmx.de>

Cheers,
Quentin

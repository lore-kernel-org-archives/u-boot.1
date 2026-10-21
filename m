Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E6606A319
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 07:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=SNnQZjSh;
	dkim=pass (1024-bit key, unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256 header.s=selector1 header.b=Lj5Xh2Gj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BF1FE80CEA;
	Wed, 21 Oct 2026 07:28:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HyvtLr32JfFf; Wed, 21 Oct 2026 07:28:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org E829180D34
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792567732;
	b=JUjscSLHQUqqJpJ4fafo7HH0z22KcjzOmEBylvpsbd1F1DIyS4C6dCpzdcaBrC7OPikF
	 YM7ZTL2/usmiZ7yQSr9o27WITp80ukdV6rS0WWK2oRna012hlLz055jR8ZiA/sVN7xnL8
	 IbIMPakgX1fypI3xfKeVehq3woSAceHTpMzRJaUUQSXVzRIrXdxAYo7yedlmKJPq/F0ZK
	 Grb0a4wUTfjjhnHW63Gui4CCBP3qkVSb4adsR0HEGAsxQA9dYMgJ6UquuDV6ZZzeI8nuC
	 NICJQ7iU5OWZCm7eY/i9VctM/8eFfYiNM2GHJlsk9xXgtnIvR1KSuzx53y7tWlCOIqQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792567732;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:In-Reply-To:
	 Organization:References:Date:Message-ID:User-Agent:Content-Type:
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
	bh=9GGgOV1TfWf1Om5A15s4rPYEf5ORFegxMGeQGq+jROY=;
	b=j2w75Ra38CeagyZSsgiWJ6fBUeo3yNHeVAORhzUdpG8qP085kGlX1BK0DAxFgxgFzs0F
	 688Pzs3ENTN290eksgLuIGVJKlQkwJl9qpnmywuwPFvcuj1TVUbv16UbMgziHDL3hv9Tc
	 I3PmxMYQlzDqq6ZornCbGtK74EhsECZ9SQ9V6idkafZLUOJuWD+6hf+MPdKw7IQ6GF0zw
	 e6AuB22vGSWHdiumDwtGaPgm2zoLd4mPkf9xNtvJeI32mglGZFH8+C5wJICmEPixaWSjh
	 LohTL29JceNQ694q9iCsnP+hys7FJDCdcG6LdOVXqPfilvOPrypZnfeEpKGBS9vKG/A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792567732;
	bh=9GGgOV1TfWf1Om5A15s4rPYEf5ORFegxMGeQGq+jROY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SNnQZjShfNTzG+ZJi6tUJZpWr4ItzEvqrZ3NqnPAwXz5WuaYEh8hnbDVmeKauvbWl
	 JNEzWHP34YjMJ2gDZS/D7ogLPkT71H37sViphGEej9y1m6ipQz3QVVcZpCtg1aWHQi
	 sR16SfnMpRzZ3HTdr7awS9U6LZ67ESsqnxr0T4rjtLpdl7BorBYPDeaxLqh3gH+M42
	 mDusOS91HusBzoivVNFjeTU8+Jg+ct7SiVLts4nQd39TZOpcrhJ5i9QMDO4cZDlD3O
	 uWcuDkiL03wK64tKa8sefzavpH+5QvFNrXxpt3gLzOm6TsMPxTsqHWS1HsGRtR9d3i
	 kSAOG0SiugW5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E829180D34;
	Wed, 21 Oct 2026 07:28:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 89C9E3A8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7B3FA6068B
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:28:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2SpRuAyz7QJm for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 07:28:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 324FE60653
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792567729;
 b=oJZ0+j1nxKa3/kHjiewgRMNfT090MXLS7EI3poc4hBrR3H7tOkunWAzRaHrGCQaSKsGN
 G7Vbm3e3nlXAqeFGxaR0lV/pAbRXsnAWnrfFAVRu0D7igiykFZA7vqjbr9awsB3uLRB78
 GBwz1uGFCng1tz9CrLElfNER5TpIQuQjEpf5T4kVM2MiYtMcyJtIQTLgwjM6piDrxfJct
 1ZppYoMu0kgLdLZpb/bD/n2aHFlTR5Guso/YmDOouTAASmEOnklDK+Ewu9Hjra2seb4+D
 WAfKeoPrwMcyFP7/ZNSS/wus+cv8SZlKRzJxeh04RwZNDJLzT3OKWGoqK9k/I0t3Sog==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792567729;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 In-Reply-To:Organization:References:Date:Message-ID:User-Agent:
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
 bh=9GGgOV1TfWf1Om5A15s4rPYEf5ORFegxMGeQGq+jROY=;
 b=Jw5cRf3Fg/iqdr4JPtBQ6J/wnJ/RF9i4Y80kWZ8VCeu6Ek/KbiUa5cNHU3Xlu9VXJj8Y
 bael+Ih3d3wVptq6PuexxKp6EFHdnlttrZl4H7XPDjOsJKNnpIindHyso7y1s1uzGiiES
 iCPkvseVgjODqtcoskwl7Weld4QEiuCGU6YgjWKm7jiv2OxHylhRzsG58rKBDjKfa7nlx
 Ic4lYlrya4stHk8M5Msp6q0SbMWNlHtUiNvwucgkbq4L2HAFUAOxDMKIT9oqAnbXgIQt2
 nXeBTSA68Btf+3byqcohgD7CfkjLT4W9O4ciRuSTLhXxO2iiboREfyl6pkQ9tV0qMUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=prevas.dk;
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=Lj5Xh2Gj; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=Lj5Xh2Gj
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 324FE60653
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 07:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yg26QCogVGh4VQ/V+9EgMef3CJnz1RguNhh+5BQtBYKJ69NZ7cHWssN9JRWmknVfNnGK2Rmu0YXBjgB6ASSgG233FlBJ5erX5BYOvLZ8iFbkqRkKRjQU8c7YIT5xJbKyevERlwN0VKrzWGxKmgZdJ95BPReoYgfrgmYFvhUAJi01JwrU3B6Lt9kLdR5le0jtnIHb899AEi5ozOaw95XDbRMEXec86zyV7AuHBXBshyfn1VzkRpKH11xE4jvqmbvg01SQtrdFkKy71btX7OcIdQbBHH33mkHDJGb5aJGtwXrcUBQe/61fIFMnXCb2LzC9q52NRAUevXRbWw2iAgb/OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GGgOV1TfWf1Om5A15s4rPYEf5ORFegxMGeQGq+jROY=;
 b=e0JOcX+DReH7Cbp41HTxKnqB5yNmll83WhYzUHA/E1sB96svMK+/D0/iWhAxxz7T2xroeoWHQZaC9PxOrjH1U8ZOqZeKNk8nBpz1uCh+bl4h7yygxhgYoF9tDmFFQ0sc2T9571tddZOaCZh0BT03ffL+g6PPUCFZgeEMMIJjlXvNHNaCqSxKKUkeIdW78DiXA5v5mp+1gNNkwFLOOYHXS+LgtUHKJvBkKkPUoHhBKw8rkcVruSpKfSw39e9UuyD2nKJnwbpfHz6IKDhEHKFHmRg8wN+j2rGjUNHoT/pWXJvTo9GWbuuevO5tFgeLZYFJRHTpUiMwmW5KO1hJWKSYNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GGgOV1TfWf1Om5A15s4rPYEf5ORFegxMGeQGq+jROY=;
 b=Lj5Xh2GjQXCefi7GHYnNpyuhBAx42WR6IzLfL7JWlRCguNxVuM7N1/zk7OW8jwUQ/1xS6cmtPuIEw9FrVI2IrrLO1e+6BTUCD2/n/uOr+oPZySkTiap7+G0ycqfElyBG3Ivm+GJ4L3Y77bm0db+kackeM6vm3zGXDvddiDCDhWQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GVXPR10MB9663.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Wed, 21 Oct
 2026 07:28:36 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 07:28:36 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Richard Weinberger <richard@sigma-star.at>
Cc: Tom Rini <trini@konsulko.com>,  u-boot@lists.u-boot-project.org,  Marek
 Vasut <marex@nabladev.com>,  Fiona Klute <fiona.klute@gmx.de>,
 upstream+uboot@sigma-star.at
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
In-Reply-To: <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
Organization: Prevas
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <kmHpEJEOTD24XAfa7fSobw@sigma-star.at>
 <a7a3ddfd-e7de-4cd7-8231-be5391c88c4c@nabladev.com>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
Date: Wed, 21 Oct 2026 09:28:34 +0200
Message-ID: <87cxt31pi5.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: OL1P279CA0054.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::23) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GVXPR10MB9663:EE_
X-MS-Office365-Filtering-Correlation-Id: fe23db0c-5584-43d9-8389-08df2f44eb6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|20046099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: gi2aVSWba2f2sQTHiNAFiMoUb2C/XWr+NGME3uM3qtgN4CifFMFjMQEwtxp0CjLiOoh+pkamFl8r2WNWFU+zncif8TNXiRrL0cAmGK1ngQeAnzgkk44+Y0PWTIHKndMzpgAtUayvSJ6tZyiZ/SJfwcB8CxC78x+Pv9JJxxeexoIniWFlPx/RKDf6O9Fh0LSS1FO3ryfc9kyRNZBzB5Woa6UDaakgffnHqHaEqEbyJfxnR195GMyS0nl4KOwmdFS0vAQkwq+dbwBUH4BWJDVOD2gjRZyx6TACTa/Qcp5C2aa7XS3Dw/EVAGaBEXEw2pyIxcaELiZYZ9uQ83AScotnZ2AdUST13ONfmvuC8zZ25c5rdKyoYkgYTwythTypvqQUtSsgS5cCPiQ5Pj889kbPkcLa5skl6GeyvBTQ74GLbTH6WFrLdK/jLG1n33dwG939oiKiNGsNnqiQtxgXGNasAw+5oECkhJE0I4N/ZExHza8Oth5E+mJh3/kDPcSQRAe992J/uH0y1ZkimLDMnK8Hu671K/O9tIWqZzMTiSYgg6aruElqRqywkuJtPiJMT7v2nImY/potBe+lYKCzwF9wXr6sMfOSSHr27F1tpdMC1aT5/Exjzf5jRxW5XR/hbGlfcuZzh1Mx93qEZ7G6dfHn+tgcd/mi5rbOXLQDU7stFp4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(20046099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xRBVV5iJ7r9cdvhwPHNa67rn7/H2ILEOFFkfH/FoLgN1ntjubunGOADuJVKF?=
 =?us-ascii?Q?u6ts/xnQxtBm9AFjiLghH06fdZ+xSD+Q1C/GEYyoMxwF7bcDBAYCxToy1GW/?=
 =?us-ascii?Q?jIh7JwRrKIgntUGEmI1787OYMgMshQlBuNZQTJGmpD+YmPDizN3e7r/to9S0?=
 =?us-ascii?Q?K2XoP+lWaZE+RGIl1JY9Vjt/ylfjl9ZdR1sjHYQ4Hc9HJgsy0Fb2xlSeh0ns?=
 =?us-ascii?Q?xT4JWt4OAGcWok9YmaLv8RPSMr9m7ZP36P3trZaYliLxknQAfPaAF8ESiGwh?=
 =?us-ascii?Q?PewAUvZ709XAMcDsEh0dLKOM0/INKvulwsSIOF6OEUPJiGpfQDz5tFyD2PAj?=
 =?us-ascii?Q?c8F5T4b5gb6ZATd0vseA3D7pZABuDygkHsYNpQQ2tIx4UAuz4EmWlr4fbEv5?=
 =?us-ascii?Q?bXd0kdztzxJvI5Mn7ljkr8JKk5iDsHz70h4wnvqSu7yA6wWq5CQxQBxHDzQX?=
 =?us-ascii?Q?90PXdvGPicgvbLvxlE1NsFkDpQemWsZuV47CdSvF5gIReK/7inSKqyqUyfze?=
 =?us-ascii?Q?sh302DCHJmvKgGWMeWjK9zLs4n5z1ppJ7XgUIW9/k0SReXUcb0UzBaU73JTK?=
 =?us-ascii?Q?9uQB/U/7EdssiLjSwsJBwpss6qb6G5fntfc0dFZkfzb/avduoar+WkkMUzmS?=
 =?us-ascii?Q?vAJw8EvxR1A0epQG7Y/BxzCPpAiPbrhHXOKdW3+jsC55a7NjpNHLlMtkf1Db?=
 =?us-ascii?Q?yuubJI4PiJNOXpfLBmwWrIXVqQFxM2AFkpM2EwZEPPBr57PZVCNWHiz6wjq+?=
 =?us-ascii?Q?MchLY2J0zuQpA3xgwndOFaFZWFVNBu6pFNqdTX/0cipul2vQiO/1fCMdF/Qa?=
 =?us-ascii?Q?GzwE2Glkwt6P0aetdhAlPKW3MQIWqRzr94yJpGwIzVL4PEUgp2qqfb9TAVm4?=
 =?us-ascii?Q?jFqs13jh0BVY2x6qOG7+tdBgZsiR0xUD64cqeMhkAHEpQ4hpFUp4PtamXWGk?=
 =?us-ascii?Q?t7h/EVqK8O5gj9EL8h1UNN4RsOQpfWNWTlFarume9y5LJ+oFo8qk2t44Ztsp?=
 =?us-ascii?Q?E9mGGZmmN9giPcjQm6j939ki/QZQAelMx3kiXI2kbyodfi82AxmpdFD88ON7?=
 =?us-ascii?Q?Xb7bBXzTH5umC3iV76MxuHufqx7fFq+xL5gHbbpHMNwaxJdNHheY+klksbO9?=
 =?us-ascii?Q?EAZzZvBrtCogZRW/fNmDQKiafzOjB4W+cVZs/8ObXSbZZ3CcYE3Un1Y1rgXt?=
 =?us-ascii?Q?+23jJQdgS4KckQ+2BxAHS4iuyhEJCvh70MarnmG9Y2KSigyIF1c9PLYKjv1k?=
 =?us-ascii?Q?KOG5HhDJKPalGp4bUIErDMj0l7jS2jcX8yT/1aG2oOQeuuMbNEvsQmGgkTFh?=
 =?us-ascii?Q?UYPTZrbIpAJ/pE3iXBuXtGTZsDSl/cieAP3+CHo9htrV4mW0zdYO7iSX8bjL?=
 =?us-ascii?Q?cdXM1VUsIFIeSO4UJLAeZSdiNkbcZMxT3N2ws2BbC6JgQCu+oz2sWH2I75Va?=
 =?us-ascii?Q?gOsu9WPZExu1LKrE0iEfaBsVTOmgLsabNjkuKrRF0ZGgcmJGFVV1z9qbAa9+?=
 =?us-ascii?Q?gr+/piM83FrIPpNxoND5UyjwxDwl/vDAgrC+uMdvdn0CDxK2t5JZcbbJ0s6I?=
 =?us-ascii?Q?62ZsVjuF70TdpfUGfUDDW//LmW2lRUr7Vkmn+hd1sSTXLRtJZpqqi4Fj80/H?=
 =?us-ascii?Q?zZzteHfl8v6ISrj0Y21BtgAblbDJzorYBLVFNS0zUoGZIpMAeqmz2C3pCB5I?=
 =?us-ascii?Q?izhg5EdawS51QaWeEwJs6kuAAekXcO3ogUIFeB60Wmda7YLIVSxLvCW2rJRl?=
 =?us-ascii?Q?6iXTOPk+5ElZsLHwZZPw+dMh4Af7OM8=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: fe23db0c-5584-43d9-8389-08df2f44eb6a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 07:28:36.6377 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZUtGXL43FezqzRIyjppCR8EqMGfD+V/11/2Dhx/oZ/kuiIcd/JBUZpHAOZH+7J5fMpqlE1MtxJ1gntsgBpYzSUmDb7+z4biKwUjAmyqZtfQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9663
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

On Tue, Oct 20 2026, Richard Weinberger <richard@sigma-star.at> wrote:

> On Dienstag, 20. Oktober 2026 12:22 Marek Vasut wrote:
>> >> -	  writeable flag can be written and modified at runtime. No variables
>> >> -	  can be otherwise created, written or imported into the environment.
>> >> +	  writeable flag can be written from stored environment. This
>> >> +	  restricts only environment loading, not runtime modification using
>> >> +	  "env set", etc.
>> > 
>> > Wow, just wow.
>> > I always assumed that the protection applies also to "env import ..." too
>> > since the documentation explicitly said "written or imported into the environment".
>> > 
>> > Instead of fixing the documentation, are we sure that this isn't a serve (security)
>> > bug which needs addressing?
>> If the attacker has access to U-Boot shell, then they have unrestricted 
>> access to the system and it is over (the attacker can e.g. modify memory 
>> which can be used to circumvent other protections). For the writeable 
>> list to have any meaningful effect, U-Boot shell access must be disabled 
>> (e.g. bootdelay set to -2 or similar). The writeable list protects 
>> U-Boot from importing undesired data from the external environment.
>
> Well, I have a different use case in mind.
>
> What if you have something like this in your bootcmd: "env import -t ${loadaddr} ${filesize}"
> to import variables form a file like /boot/extraEnv.txt?
> I like this a lot because it allows applications to set various u-boot variables.
> And to make sure to allow only a trusted set of variables, CONFIG_ENV_WRITEABLE_LIST
> is configured to that set.

You can do this today, but not through ENV_WRITEABLE_LIST. If you give
'env import' extra arguments, those are treated as names of the (only)
variable settings in the imported env block to honour. So you can do

  env import -t ${loadaddr} ${filesize} ${safe_vars}

That can for example be used to have a completely static environment
(i.e. never store/load it to/from permanent storage), yet import the
metadata necessary for doing A/B slot selection from somewhere that
userspace can update when installing new firmware. Obviously, one should
also sanity check those imported variables, but the point is that one
doesn't risk the above command overwriting/setting $bootcmd or $verify
or similar. And if an attacker has had sufficient access to manipulate
whatever mechanism is used for communicating A/B metadata between
userspace and the bootloader, he could just as well have bricked the
device there and then.

Rasmus

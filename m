Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F58F606A31D
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=w+Z66XWG;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=ku0D/Jvt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DB22B811A5;
	Wed, 21 Oct 2026 15:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fpBMpEL8f5Rg; Wed, 21 Oct 2026 15:00:22 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CF57E81182
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792594822;
	b=JYUCwlt/XNrEV+9hkgk86dpCecQSH9amZyU2qnesqGWB/1SQn9UxX/JchXRb5sAHR2yi
	 Kks39VZ+vK+6tvqEBgWL0vM+Iuilm9qjOSstGZsk6hdzUHW+SIaj2mKxuo8iNG0f2P4Gs
	 c4y4Vtl/FMaUHtNck47YIyJVhjt2G58WWbF6vuJcxyx7CiXHYGR5I6qzAIdaCPt0bUU38
	 HbnS/gXzz3bZ2LAlFVJezyV2p628W18DQ6vVDx1Zati5jq3lGtIILZ2pwTEYV/PE92zRe
	 8sS5jtndlbam/crNuj/vbu8zHHQ9HL2fQWI9v+28sBXDQREU3mgkrEO0zjHdpCT0klg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792594822;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=MeTZmSHEqGGoJNulhMQSrNyGfWu4JNeY7uEKsRbhnuY=;
	b=J3mrgKcttJx4n4YWYQhrSZyHfWm7L8dHmocDJUlUEQryOO5Bm8T+ZvEwvN96c1rLWFVO
	 873O/EKzEtn/B8dvdlnuqcnlwflRZgWfgkOa9UzWz+FGSOybBRRQkGS78RGgZlR5OSYDO
	 BdRuPUdBsauf0bNbja8vK8h8mSQvPdtJsm5Y8vvfBjMZND/i2y3kOy4AVkrdWOF5RmrLS
	 JBL75hZ4sg3ofODVGqg07JENTUym8blsjIH4mV9QiyToecFIQyMoEK4TO/L4UICGFyWRU
	 rodS9zex/h1YcLf5dyMD6tFWHqQ/QnZgCy1N1RFyLmqqlpdof5H69fsmNUBwUEgZYUg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792594821;
	bh=MeTZmSHEqGGoJNulhMQSrNyGfWu4JNeY7uEKsRbhnuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=w+Z66XWGyEhvSTcxUibJlP1lDc/nQNIq+ZxDEdVZY3SI+g6V60qau8Bgd0MuAr5p3
	 SOUjuWRF5Em/Z133QMG7aLRF72oz6GNGv8Eiq+dhKA8sPb4AJXwT6r+M+MKyrNsOJj
	 YtbqbuRfElICYkMEWX+EygQ2hYKGjny7mfgXrjQ+Ax2FEl4VEcYDuWkBkp3W7PTOn0
	 zx4V9Oj+UQnD61JbzfGAZkPZw5Voi5+aernXEGM+BCvXXSc2kJUlqYE7sNmye0ujQv
	 pvBzM6aI0xkbmSOlS5B2dlsmdDRh1RBQ1oNZwBVtKxZy81MnHiELnGvjcyCRYMKKRr
	 kG3zIpR/feSYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF57E81182;
	Wed, 21 Oct 2026 15:00:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F258F995
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:00:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D79E4407F8
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:00:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKHI-A4CsCTz for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 15:00:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 454A8406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792594818;
 b=WxoLNkI9rmrJwhk15DEhQVpndL92BZptb2Xnm5WLPxFYdS7aS8bGuay9HAhsWo6YpCKO
 CXUFfs6T3w8iRts1gf/YDmMsdMO34lJ3czARsxMfELnLFCAHgi1u8kNK2IdfVVxRRgBXz
 YjBEPQMy+CVZrVDheX1lZL+ooWUg1gSxQyRIBsysye6RMgIyLx4h9HbR4/A1E3Q15jnH+
 Mp6vR2uScNa0nQ9JMo/lIC0Jhn0w7TQKCZRT8NDbxRS3RXswTbPq1rz2YuSVXof9diLXH
 mpiRCs7CTvgTwcBWJuJIdqNEIrAZvjYRjJeo4HGyxCbvTcs5zbMU83QnXxDWlbVbiQQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792594818;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:From:Content-Language:Autocrypt:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 bh=MeTZmSHEqGGoJNulhMQSrNyGfWu4JNeY7uEKsRbhnuY=;
 b=qSrknjm+gej0PFsC6K/E2dzqec+u0uWiMKkLr/lIwXh2rW/XzfrXM21gvIxb3fuhCL5K
 CAp0uIQA/L4Ky8NHcETI88uurqPG5hQhx4p9U4GTq6SVd+tfKd3agMUBTgEe3Agg48iM8
 X6Mr4G/1d3tPFUA+ve14KHirfZYW6/QoQNTMvqauof6iRphSQkd/OuaBHMif9Dd70OoE0
 1ocoIxvI4cXHnvp5zzyJwQWGgQnFm291Jua96YvnQPAkqkYBXkV7Dx+8w6hhFJk3bC3TU
 Qe9Bvj/v7tQpxKlOvMofTvQMIv6l/jWLJnmc9zgREaUt9vgvul1UBDuAlvzDsiN0oUQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b="ku0D/Jvt"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jan.kiszka@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=ku0D/Jvt
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 454A8406CF
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 15:00:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEyewsUpTTvuC/vK+z+I0SORmtYeIB/7AlGeFz6IidWxP7fQexrELg65o3hN/v4J1yJe/eJct6SPZ0xUTqK3mmwnPtqauUXpyPBxzIagO2pwH9lVuhfUnPST8puvbmlW/f10tqTzU7ELbeMvxJ2TlkRjRYgc1e9AB60UonRaGxlf3atjITGCshwoZrvK/9/tPg4q+An8FxMzMjyGEMXGTjdBKkrc9jAPQ9nTKXdSxRn9gY+FDXpBf6IcIUh5WefKdTFn6jDqpqZxPbBQg/IzfVLf8WFpLYHd3czW7sd29XP6lWyxZKWQY/ih+F+eXnhRD/daDGybv+iSPyjMIUp4ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeTZmSHEqGGoJNulhMQSrNyGfWu4JNeY7uEKsRbhnuY=;
 b=pP70LSaY3tRvumAxGjFKP2Q8fifJ4RDSEEBaV0Nkywkm//7obZXjrd9MXfe8920SfF4GFoigep/5Xb8FL/mWAVFUuGGDxWsQkd2KwlaHgADnm18dWLWuNtIGLvRtGwcsWPblcnYeJGTy3nzzr3qXL1AqOzZrTzHfdwRfcnUWu/B8DuXTmJUCBLtXARa7oVA0WPaqSvmC1iCihg6vWA69/2MFBGOuYU/aSsPxQZb9RNsyhenqUrNIxgCzzrkgdtl7wzdVSFDpEP1tAIgghaYwhOC3FNUrWFbv79TevZpKphSYJXA/zjQo9/YF/OotHeCWXPuK5Ebzokr3kj6nmEn3Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeTZmSHEqGGoJNulhMQSrNyGfWu4JNeY7uEKsRbhnuY=;
 b=ku0D/JvtDX9FpdH597u8u0E8N0bwYzmmu5/61q8/fDmnRaNp6jsVQIA6do5nhd2+dY0LJynNXt57qZASUoQe9Xk+taSiJXKjLNCwtAhHAPE4lIc8y7pdugNVL79iXY50xd/nJmNdzn5aRsQ/itEgVu6yFr/AufYFgNASp0ZcmZnM097rqTZx9nTsn2+J3cE0zO95+ZI/kcw5iTJkc6ngAwkZTvIXWoXAjJIOW9MW/1qPfbA89oGItlMLRdOhtRa6VI14kK391NHBbrzGlJrV4OFJR3VgVng/OYHz8j6ofvdsaOkp1klpoYTa4NGE9lXD7fJOqA0O+7Gt/kIA6BjlLA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by AMDPR10MB992317.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:70c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Wed, 21 Oct
 2026 15:00:12 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:00:12 +0000
Message-ID: <d82a5bca-7ac5-443a-bcf8-68a21ac06224@siemens.com>
Date: Wed, 21 Oct 2026 23:00:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix description of CONFIG_ENV_WRITEABLE_LIST
To: Marek Vasut <marex@nabladev.com>,
 Richard Weinberger <richard@sigma-star.at>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
Cc: Fiona Klute <fiona.klute@gmx.de>, upstream+uboot@sigma-star.at
References: <20261020092137.242656-1-fiona.klute@gmx.de>
 <maJhRK5WQ1CTiNrAorY2gw@sigma-star.at>
 <87500fbd-8f56-4d40-bc22-9aa68635f1c1@nabladev.com>
 <qUM3V7UPQe-RED8ASvU1mA@sigma-star.at>
 <c9e9eff7-fcaf-4c98-80d4-b0eb4aa93bb2@nabladev.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <c9e9eff7-fcaf-4c98-80d4-b0eb4aa93bb2@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|AMDPR10MB992317:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e9a717-458b-4d00-ea9c-08df2f8401a2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|55112099003|6133799003|18002099003|10067099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mO2gb9I3wWcF6Tntf52IlOrqPXJEl5Z2ljyoy6C5c/CrUCxPafPE+ZbjDtXzzG0syomIroMWSZMtBNhRmkaaExBSPxsITYJwkGcNPkTr+tuqHSxzQERKPIAEqkMeGFC3tFHb9UfD/VgNmBaOCMKYdKehVNDER0TyxO8X5KktfgHrTkmIKXCanO3ETaw1nyLv84nWrWKE2aInDt41Rq7e061sI6TT8kfqMGJEzMPntBz6o7I4fDpBp4oIUitFr9W4yecbEpzq2UA/YK0GgS3NvfN8g3hY5PNdmvmLjrz0Z0iqVx8czGISsKN2/ptk8uHxJlAv9yfqSXbhU2IfTLWW9caJdjHjOL49R3jDe13hwpW5DNIjZMoC6naMYwLSwE3qwzhdgiV3erQ6gM25weK3cKX73dTsI9apKFrHnRuLXNO8KWjJ5y0kQroLl7VxLYj1xheSVEbHInOUqVHMK8FgAvgBf77U7Xvydo9sQYmZKqOAy21jD3NngXGvuna3EGU2+KPDyMs+FXLt7pm5BpFqnTmn81Pi+0NHsSzhkkbvmuuhGIYYZvUhlIrg8gfLj3QjXxQ1ts1lKxIelIYG5l0nHRCPclf2jm1Iji1Pv6i9eMP+PCzEZXsgvxmhmItzZ2HbURO5ogT0+8fmKUU8LJPAtBA6/tCNG5IIcQezeSc6Fx8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(55112099003)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T042RUlVbFMrcVVKTkZERDJ4aDZBeXFKLy9sWUgvVExSeGFpcXdtSGE3Nmk5?=
 =?utf-8?B?RldyTDVoZEU5U25DTlJtT0RmU1Q2SHVpb0ZyQTl4OXhhMzFkSlJFUFJtdjZ2?=
 =?utf-8?B?TWIvdTB4VklxUFFOVzZGQnlOc2NVZjdnamRLcjB1akRPRStrRUpSZDdIM1RF?=
 =?utf-8?B?MWlodDJkcWFKbi9BU2lFTWErUmVSMFY5aUdKNHRIWmdWSnlOcHZPUllURThi?=
 =?utf-8?B?NkxDY3RULytJcjQwMHM5THRpUDkzMjg3d1ljYnorcmVNWXk0Y0E4M0pERHY4?=
 =?utf-8?B?ZDlIUEVGUXNabkNEYXBxdTB2UUNkU24rWWZTZFJ4UEc2RWt1R0NWbzR0U2hr?=
 =?utf-8?B?WUV1MnNtbGxvWEx0Y2ZPb0hhdzhnMkdBVmZjNmpKMlRWM25TTENlNG8rTkF6?=
 =?utf-8?B?WVZvbGUvT28xTTJOMlp5NDQ1N203Uks1NGQvNUFna1hISXhJVEhzZE9RTWQy?=
 =?utf-8?B?bFhSMDFZNWorcmp3YnZqeVY1L3AzNnVQcy95dFJGcmxYTm1VU2RybXBFMzVq?=
 =?utf-8?B?RWdvYjQ0aXUrZ01FMzdxRjk3M0FkU0ErUnY2ZnZvMUN1YkRhV0pjcVN3RGcv?=
 =?utf-8?B?c1VqdXhzSUlmbWswalRDN2dzM05PSTRQdFd4VW1TbTQ4OC9tbVh4L2tINzVU?=
 =?utf-8?B?bVhtUnhydys1MUw5TXdVdUNZb01YNDl2ejJnK3FCQnQvUzZvWlpBOHJoQUNY?=
 =?utf-8?B?d3o5cGMySWwxRmZoWVp0V0o1eTRMY1NEWWhiODhqbldvRzQ2eUxYQW1LZ08v?=
 =?utf-8?B?dkNhYjdnMVo2RnR2eXdyakJlSkNYeDRSMzdLVkZ5dExQTnNjbWtJSnlEQ2dX?=
 =?utf-8?B?MzJXT3NobTRTYnkwaTUzeHp4ZDZkV0hFZFNJYWdaa2UyRUxlaUFCVGJmRmNn?=
 =?utf-8?B?bmVid2dWV1crUUJrdTE2LzJNZzVOZEhhV3NaT0Noa1YydkNVTkFZYThzY0ZM?=
 =?utf-8?B?VzNXZWFGZzFVdk9yM0Irc1JnTDd3WGMwSHlEQzJpaGgwQ0hQcjVzWWI4Sk92?=
 =?utf-8?B?WlBJanB5dC9NTlZaMHRxSEdJWjdHL1lUNG15VEpZZTBweVphYkRKcjcvbnU5?=
 =?utf-8?B?WDA3M3phTHFaM3U0Rk9HUDE4OU94YXprRzZSeXUxMmFUVFpjd1JhOEFnK1lo?=
 =?utf-8?B?UjFxeFlSUjhQaVI0bXRsNXJibzh3Yzc5R04wSWNTRUI2Z1V6ajR5dTFWbGpP?=
 =?utf-8?B?cE56YmFHSjBQMlp6d2NBQnJHeEdRa1Y4RENFNHNHOE4vUDN2RGM2YVFNbGdC?=
 =?utf-8?B?RGYxUjZBMlJnemltK1JmWGN0bTYrN3psaUhQMThZbnBMWU9nQ2dDWWt1bUJq?=
 =?utf-8?B?RU96by9sT2IzMjV6anJEcU8zTXZiY0dDdXRSejlPV3RqR0ZrVVJsS0NxcWNI?=
 =?utf-8?B?dFgyVVhMWUdCQzhpOUY5WkxucGVNUzh6bmo3ek9CNFZobWk2UEpqM0ZXUFNn?=
 =?utf-8?B?MjR0dkoxTzg1SGE3MFFDM0pqOGhpbVdxWUJMUENDTlp2NDNQakVqT2FLYlVw?=
 =?utf-8?B?VlNvWlAwTS9abDJrK2FOWVVWSng5c2RiY2lIdlRoVFVnTm9BQ21rdWxJQlQ2?=
 =?utf-8?B?L2VDbEhUaU9kcVF0eWNOZW92cVFlakIvb1phd1pMNG84L0tFQjhnMUM2STFR?=
 =?utf-8?B?VnBsQ3lYVFBzOVVYRVBTSFcvMkgxcWl3RTM0a3VrR1ZJRUc2YitGN2FoTE53?=
 =?utf-8?B?UVNsTWJPTzhLNmtwMlVrUkZkdi9nQ3IxZHNGM0piRy85V3dka3hxNmR1QjBX?=
 =?utf-8?B?cGZ2SmhKL0R2NXBFVjBVb3FhbEcwcUhNdmJTVlNRS1Q1VzNBYUhkTFoxYzNY?=
 =?utf-8?B?R0FNanpRdXQ1Q0lrRGRrUnNTbWh1L2tnRlVKbjh1akk1eWhyR2wzdGN6bnJ5?=
 =?utf-8?B?eUVjWjd6QkFjd2VxcGsxSFRubER5elprSEpiN2pvY20zcHRYOFJmR1lxdlVW?=
 =?utf-8?B?S2JPbWdicTVuNVNVdFMxUkpVMVJWTGVhYXJYRU5DM01nWmoyLzVQKzZMNnlz?=
 =?utf-8?B?THhkUmtkWUpLcHFncEhzNTlNSE01NldyZnl6bmxJUzZaTWUzSkxROFFkb1FC?=
 =?utf-8?B?QXY4RlZENW1yaU1jVEVsNjVJVkQxMHozT1ZTY2trQUY4aGNoUTJVbWU4U1VX?=
 =?utf-8?B?RXRYUEFCMWxuQnFMUFhRTmdmM2xFYVlWK2RwbGNkcDFMbGVGOGVKL2oxZkIy?=
 =?utf-8?B?cXJUb1BjMVI5cnRWYU5EbUlhdHdSaVlnYk9XQmhlcHhiVWRZQjNDeENvb01v?=
 =?utf-8?B?Y0dzN3YxVU1EUnI5eTZiZFQ5MHhRVEU2R1EyenFaL2ZoWWExZmdXYS9PUTUx?=
 =?utf-8?B?dFJ4SkpXNlBJam9CK3REVkozWEJsL0s0WG1XdDB4dDlLZGthSTJaZz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e9a717-458b-4d00-ea9c-08df2f8401a2
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:00:12.0363 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ykXnyO75pg6vLqHZMr0EFoI8uAhZ8I69ihY6M44m/ydvRa7lrxjZdzQS0P1gKCQg/JWLzj1LQNlNyzVeT4dOTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR10MB992317
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20.10.26 20:16, Marek Vasut wrote:
> On 10/20/26 2:55 PM, Richard Weinberger wrote:
>> On Dienstag, 20. Oktober 2026 14:53 Marek Vasut wrote:
>>>> What if you have something like this in your bootcmd: "env import -t
>>>> ${loadaddr} ${filesize}"
>>>> to import variables form a file like /boot/extraEnv.txt?
>>>
>>> How do you authenticate extraEnv.txt in this case ?
>>>
>>> If you do not authenticate the file, then it is game over.
>>
>> Well, since I allow only very few variables who's content can't harm,
>> it's okay.
> 
> I think there is a bit more to this -- what about "env set" usage in U-
> Boot scripts, should that "env set" invocation be able to set non-
> writeable variables or not ?
> 
> If I recall the discussion around the addition of the writeable list
> right, it did originally filter even import of variables into live env
> (what env set / env import does), but that was removed in one of the
> follow up versions, because if attacker has ability to modify the env at
> runtime, it is all lost.
> 

The primary purpose of that list is to allow importing env setting from
unauthenticated sources but then only permitting a certain list of
variables to adjust their states accordingly. Variables no in the list
will stay with their hard-coded, typically image-authenticated values.
Env storages may then still carry value for those protected vars, but
those will be ignored.

> But please don't get me wrong, I see the issue and the wording of the
> ENV_WRITEABLE_LIST symbol is not good. But I am not yet convinced that
> it is not up to the user to secure the U-Boot shell. What would you
> suggest we do to improve the situation here ?
> 
>> Of course you need to be very careful, but that's a different story.
> Right.

Configuring U-Boot into some secure lock-down remains a challenge, that
is true. Long ago, I was dreaming of some "lock me down" meta switch
that generic features could consult to flip their default behavior if
set and that board support could also take into account when there are
specialties. Would still start with a convention, would still need
engineering and may still not prevent all bugs, but at least in bug-free
setups, users would have to invest much more to get things wrong by chance.

For UEFI secure boot, we use in isar-cip-core now such a config snippet [1]:

### Secure boot config
# CONFIG_BOOTSTD_DEFAULTS is not set
# CONFIG_BOOTMETH_CROS is not set
# CONFIG_BOOTMETH_EXTLINUX is not set
# CONFIG_BOOTMETH_EXTLINUX_PXE is not set
# CONFIG_BOOTMETH_VBE is not set
# CONFIG_BOOTMETH_SCRIPT is not set
CONFIG_BOOTDELAY=-2
CONFIG_USE_BOOTCOMMAND=y
CONFIG_BOOTCOMMAND="bootflow scan -lb; echo 'EFI Boot failed!'; sleep
1000; reset"
CONFIG_HUSH_PARSER=y
CONFIG_EFI_PARTITION=y
CONFIG_FS_FAT=y
CONFIG_EFI_SECURE_BOOT=y
# overruled by CONFIG_EFI_MM_COMM_TEE where available
CONFIG_EFI_VARIABLES_PRESEED=y

Not fully generic, just considering the few boards we have in scope
there so far and their defconfigs.

Jan

[1]
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes-bsp/u-boot/files/secure-boot.cfg?ref_type=heads

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

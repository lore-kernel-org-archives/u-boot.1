Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A21606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=XW/gqdhH;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=L/bTrCmH
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E5D524083E;
	Thu, 26 Nov 2026 07:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ch-3I5twD8h4; Thu, 26 Nov 2026 07:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3FC4040852
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795679191;
	b=m3oKLyNNl1DiXm3uTMukHtloQQM+fNhP8iX6ANNuMwRDYZdf8t+qOsLXEqQuuON36Lzc
	 7z8vxSvnH2lJAnYmpTxNbbg/SrFf2u7V4GGN6/JpnK2/vlEiRVsbf2Q5834+e8jGL6q1z
	 maND8NVwP5ESn0EBbjm/JZeNisBfUxQa/68JzkzYp8N06Rz37QhHTg5hqI66QNtNOldlT
	 QZ2lcKKvsc4uZIQTA5lp3Ur79C6/RT3gMmZDfLM7B/QYwyYFnB7Dsom6n9V03LKXrlzbp
	 xSwIi+fvcW/eYiIKMa0T8LxyKi9kLHh2azbxJNEfszrTxA9J6bbS/1nh36XON4TnnFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795679191;
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
	bh=rJmmZwYEPifw6Z3bJjKBCxXZ7L8Vs+P2fyKnMN7lPEU=;
	b=W2w2c6EWMDrObTWC02i/OXbEa6NehajEorMd2jvHCdiwiGJGylnlh5aw2etSZr4j0Eg6
	 ZR80kC269rakD8AfwHHAZf7OkBBvDuNURKyB5oJVgTyUr2zHZmtX+Wf0VIKhlBIxPJGuY
	 IXSvFd6PC/ypGMTFKdMBVlKwPserZM8zc9MZk7Y75A/sbD7YkEdcHVuYQM6PpWDQgY9Y/
	 eUkzwTS4gUgsBFd1KW8YzGndd1F2aYLaBp7V+i8X7vtGgQ5RExzfj+ozfKpExXiCK7zO6
	 rhIIb5uwT4kBMJRipP066N/5oeGhBNrMzLdOI9wy+2kVbRsyEUILQNacJ8p1m7inxrw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795679191;
	bh=rJmmZwYEPifw6Z3bJjKBCxXZ7L8Vs+P2fyKnMN7lPEU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XW/gqdhHbac1UVfYLIUQCEuPPrppaRlpylGizozFBRLFgwaYk8PfTWQKp8Re7v+QZ
	 dCtrhVrCXBetv8NNHawDtaHowlgLwTeg5qrnrCedIrJvmoCifPETFMADhwX4+RYFOl
	 FttW0hlbRhCE8h74RKK/+7J4dbFSVhMy1c2qh1XUOtOndlQ8N3gXJyXLZZPq9iPzW7
	 i0spDB5MTOqh1YY8G9HCuy8WQc7rnUUgduNxwMxX+cG1ttOdnd02uZB9Y56hGly+Do
	 fTJg/PhxqH1JrWF1OuUs+3sHJOiuo6vgeNnJU7Zy8mdYa4BOz3hubld0uL1j0riEy1
	 6hOvQnuNnHWQQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3FC4040852;
	Thu, 26 Nov 2026 07:46:31 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4D4D9260
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3DD7680B88
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id On92tTMpU3PG for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 07:46:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 6131381053
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=L/bTrCmH
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6131381053
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rJmmZwYEPifw6Z3bJjKBCxXZ7L8Vs+P2fyKnMN7lPEU=;
 b=L/bTrCmHQOomIAkoZB9NP4OsVT57ngCg0lrSbJipkmItIwV1Jhedn3y9o0q7+/Jpst287TpKgSvFmCI5NBhs2NKbzlOl4PbytmKLYbNzCPtqFdl0Z00Nb3pqlEaaR/SESH1K+tBlU/pPl4eDK5EuE0ITk/PT39QA6RXp7VKDh6gzTMKPfxy23fkrI/7NmwguQcGtL843FcC9J9JwL7IB6gXhl4AyRfIPpElze3Lo60wIvWRD9wD0m5XKA8nN+XP9233poBdFezENDhFe+Nn+v0JztW2w6Dr0Fw0I/O0MpToA2vhnlxXtWxyY0UU6cVnvDl75j9gw1mwkk81TDQdLLA==
Received: from DB9PR01CA0003.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::8) by GV2PR10MB6575.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:b1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 07:46:17 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::a5) by DB9PR01CA0003.outlook.office365.com
 (2603:10a6:10:1d8::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Thu, 26
 Nov 2026 07:46:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 07:46:16 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:47:22 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 26 Nov
 2026 08:46:15 +0100
Message-ID: <aa5f701a-1777-4de4-9566-7f69068adfe8@foss.st.com>
Date: Thu, 26 Nov 2026 08:46:14 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/35] video: stm32: lvds: fix NULL pointer dereference
 on missing data-mapping
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>
CC: <michael@amarulasolutions.com>, <linux-amarula@amarulasolutions.com>,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Yannick Fertre <yannick.fertre@foss.st.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261107143241.2236511-1-dario.binacchi@amarulasolutions.com>
 <20261107143241.2236511-20-dario.binacchi@amarulasolutions.com>
 <c0732d45-1f34-4d59-9677-32e8967ca65d@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <c0732d45-1f34-4d59-9677-32e8967ca65d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F7:EE_|GV2PR10MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf9ad43-d567-4c1c-d0be-08df4b915a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|22082099003|261026140227099003|261022105027099003|261028144727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: d+2dTDPgRgZsLNxG+yipV6CLlpAZAqcpTXyyuRSrWmisxNAC8s3xErTni4S56WUuRWlLrW80/GrX4GX7lIgjZTMoPrLZDgkfQcBkpqbkja/Dt99qf+YZsMZDKLRKUZqQb03JuNNEa4iCRJsL+RtmI0hWwS2rXfoI5Sum3E9Gfxl73Q5HYV+MT0pi3mUOqHF3fFjQQx2Cm/090bn7XNacmOmDBgfF2+Pda3Bsbz+tb4ZNDdQA6+uAUGoHo9c2VSIqvtkY4ISpFslwnXgHN/NcN4uSwtB7ugMUMPeX2bh5Yukers0Um1jlw2Km2fpPuwvdn0/rYcK14bts9Vxbo6UyMXY8rRzeMpNW2S5zklxGakAdGAWqYjYM0MD0nsOY96ZySiA0uKMIhCjsoVfUj9DEYkogCNkS6WkhDXsfCpQ4s4yBg1L4/vTxButWR9ITTwJS5507xyB08W3JGePtjirjAXnK/v68Sk4KlQ2sleak/bdQVvFbF/zuuNu99JrIBuOzcEqOeer5b83fqYoSKWYNadp/jeN+ILvAFX/CpcdMvZZ5Jd2IlcqZBFRlSFIEHFpGyIxkRI/ET4Ik8U8uKlkq5Ipw7jmh2pDcum+Z2Id1g6lTMdc4m3wLdHLy2XV9duLpiALFnX3+EW5nNKtfHV1BoqLku50s2FMMGkSST9cyaiz0jWsMo/nvJecuhlA12FDVJ9BcvSErIYiVf2fFMgG+ig==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(22082099003)(261026140227099003)(261022105027099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PGAWACaaX0529TcazaEclarUZMROo0VqMopjhInzYKbQ0mep9wCyYJvbLrYKE/MFJuRx9hVey/DWmHikKrEEzuIVNoioyO5JAP36pKhEPhEeP8EEmVcvM31cCRgGRIzYhZuFru9FgmiTYbYA/Gk096Ek5r7fCv2QZz50vuPn/wcg+d59kX6Av/9Uffaz0qhxLmmZ8u/LaU5yd4TBCx6YtYTHqHDMCaYPnZuAUk/1ecyb3ylB5nbFomiGe9J3NYqWarub+HGZ5LUxHmpqJRy+KvXdjrfgD7fQHdIjZNLCjyJNB7eI3/GjCfokoOIUYDV8apSOton6oP30vI8paYVKLVjRjJjMAbbdJmCV2TI6rfXpWQLAQQi8uRESt0xlXH41PBT9CKuYe2TL3SrsfaphzFfHCvQhv+f9yEMXge8ATyeuKsn1/B5JiGi3zeelxT31
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 07:46:16.4454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf9ad43-d567-4c1c-d0be-08df4b915a35
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6575
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



On 11/16/26 15:57, Raphael Gallais-Pou wrote:
> 
> 
> On 11/7/26 15:32, Dario Binacchi wrote:
>> The "data-mapping" property is only required by the panel-lvds binding,
>> so ofnode_read_string() may return NULL. Avoid a NULL pointer
>> dereference in this case by falling back to the VESA mapping, as for any
>> value other than "jeida-24".
>>
>> Fixes: 16cfbbbe2b51 ("video: stm32: STM32 driver support for LVDS")
>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>> ---
>>
>>
> 
> Hi Dario, 
> 
> Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>
> 
> Thanks,
> Best regards,
> Raphaël
Applied to u-boot-stm32/main

Thanks
Patrice

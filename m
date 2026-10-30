Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32B606A321
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=mB6YSunK;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ivW/46Go;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jxtvvBaY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1D9760AF3;
	Fri, 30 Oct 2026 14:01:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wB7pWVgCh9Tg; Fri, 30 Oct 2026 14:01:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 048A0607AC
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793368908;
	b=TX2LCBCIQc0fzXExuaz8DozrjfsSgzrvJTGfSJGpeN5BWC4PzjJpbyCAU92wF8/sFqUF
	 VBvAb7TeNaHh43hAKOj3UR7AqdzeOTwqviF9EOsNLZLN/Ef2htQ8hAa4HLQOgwt5n1mbO
	 cz2yuBBE+cElYyS5CBYtB2u3BXG58JahIJ6ajR/pX6G7oyv5PMpkMhJzxieScTbojrd3o
	 elr3TdjQ8PKn8FlJQJj7DNfYN1d9g0cFXyL2w1Wp7vjI7SSREs2h/4V4gIl5f1pvFCReB
	 +MgKfDYaCfXhESRl3aIRrSiB5o7POGMeAsR+P8mi+rtA/kJLv8CLnFGm/QG9flr1a7A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793368908;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y4DCjdzrV1lanxSDDI85inD5xNnB64v7Z4nQ0dxJqZo=;
	b=FhXG2rnS5TJgdCbK1050Sg1pCWE3HynRa1rJsy2sEGebjnUBHy82+56/+jR9T1bYcAHD
	 f70M12ERCCFsh3nUz/B/4fB0u4ul4Ex359CME43wfLBanWPi0ayEeFQAF+/F28dNGBGGg
	 SpaZ1hJZlwAioalB5ucg+wEazBavIw/bLO73Vjbgk8+dIqgV8tH8PXUVij2bt1YOUKIVf
	 AJvVsfgtCP2U/3O+Nv/6pcfSwFH/Vnov+ywo+mkJreyCjvwtovNq56GnHcH7HHpFL2RS/
	 +VCMl5GCbLk94BAbWMd9CEqcknEvZpWVYiFliyVzlh8tV+IkIFlO3sAQncoc7MLjIMQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793368908;
	bh=y4DCjdzrV1lanxSDDI85inD5xNnB64v7Z4nQ0dxJqZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mB6YSunKAH4VFjfhW1PsRI4xTu4Kyuss73/9IxpV38vr3cs5AtcIN834/A2AowA5X
	 LwLj91dFiO1H8THah74h2hnpEl8lq1qriDR51gcxNF7kk4DNbjc5EOIrVlSeFcotqv
	 ayi2/jpwKL79PEHCntfANqp1P+1DoJM5j2KoM22aj6GrVQaJrCJ5Rt68QtWUFkuHdf
	 +YTzSj7P+cPVIJ0F9FC9IMBMjqasugPyA/LtQwbUyeOZs4eMGpeKD2/9YRZSFN38R+
	 fEtvEECDfQImsfARagvQGnAR3vs2GvPOOR4chG5g3zY3ulnoOgJMC7E+ffhzqKmUow
	 DmSS7Lq5xq7QQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 048A0607AC;
	Fri, 30 Oct 2026 14:01:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id C159C362
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BEFE781167
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yD0ZXZcWFZQU for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9B2638110A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793368900;
 b=WJvJN0skI1qyBIe4UJCQKctZETuoMz7/zQ7i199m2AVl9ZdDeGYZ5SUk0HeV9YuWf0wE
 oRtOOnxpCaPr8PQFw+VB2VdhbrLPsKyBtNI4AsUNtcRmIdBwOwZ4fT8SegnWag5CDaOa/
 RS2g/cVdtf8eQWXNl+DAgtgjlrDIgwHTGxnxhnnwMLmUw2llU3y3jnWXUH0mP5PsSdgMJ
 wkMDpA5fMgWaha5ENxSqPypMr4OZzTnkucLpgaUZCd8x0m+M2t8m06zViyaRlPLls8Nl7
 GWWTx1JchZIz1Jy3Q3g2q/elTBBK7bgwtwxrlf0GfUP6h/bFWcGsOkPgiXvlPhSogrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793368900;
 h=Received-SPF:Received:DKIM-Signature:DKIM-Signature:Received:
 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=y4DCjdzrV1lanxSDDI85inD5xNnB64v7Z4nQ0dxJqZo=;
 b=L2AgCbwpavoCSSmIy36nKI2Z2tuixyvi3ieZXLSI7dYPsH7SCLsiK5BjtxC6y9kHhCW3
 INVrOeppLnv4qlB8s9G/0/oFVpxy627+vtPJjL5Tui0hYWvooYO0/SrNTb4bn29UOP6gH
 0zeo5S7uLyvFxDfVB7xhSU2JdYA1jPo/WLcRNnMin9a1KNEuoUcFr7y47lUKIp5lpLoT3
 QzJyPEZG1X2lTxUHEII7RNYUp2pUyA5aRJP6J0PceNjKaHWZ3wbjk25Ch8zcHxAKn9N7q
 j3fD5sReKPWPmJsb+D/rbLj6j2MzXi3KFKJ3SRZHkmsk1M7DbqQDVf90w2bHXzT9YKw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=analog.com;
 dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256
 header.s=DKIM header.b="ivW/46Go"; 
 dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=jxtvvBaY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com
 header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ivW/46Go; 
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=jxtvvBaY
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9B2638110A
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:01:38 +0000 (UTC)
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UBGmeW3932094; Fri, 30 Oct 2026 10:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 DKIM; bh=y4DCjdzrV1lanxSDDI85inD5xNnB64v7Z4nQ0dxJqZo=; b=ivW/46G
 ot3ll6k8K0m5+IOewAY29cG92vShGdoC1mJHJY2ATA7QSB/Wm0Gum/VpETbt5DPe
 /w47Ey13l0PLU0H54qZ0lmBvX+olwQT4BLVe6fraHXUtMHLSHAV2GNOltEF2N4wy
 5RLjlnuKf0+hT481JMkKHot8ZSomPSkm2stWPF7XceNM0D1kxZ4mx85C6tOS3nIk
 G1F+Y3ElTQ7C0ifECdthzqUC7QFqluNub6isxlYreheEHnDuKGIsIsx9SckghPyV
 /lucr5vSJyodc3pdkhmlodVP0I0ujZ6yku0VquObMhWE58M8TQ+fMpYaAen2+u3D
 xzBPXKxwYMvOxNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=y4DCj
 dzrV1lanxSDDI85inD5xNnB64v7Z4nQ0dxJqZo=; b=jxtvvBaYOgODLiOs5D4Qy
 x0bRXuRgQjmJVfEe5rJT9reQRKmphSFPsjAvQm1ArbDIbQ9wBYZPIq5HEUm7NFLu
 bBVqyV7RM9hQ7+aE6u62zwrDB8iUOlR/k/lSEg0C8Nl6VINXtK7RpNFKzTcqT59n
 XIzyBc31Qax1NjKYdUhQ6LIMSEkLYZCCfL38tj/63IbH1WozKeGfjB1XrBpjhvzK
 HDqTpgc3c505hMqt7SZBiBXsoa7lmspv0kAnSiaC+jaYWrp6Civ5wS66UFIfSz8b
 6MpOcRvyLB6H8a6zpFi6WLGArgyP4yUfuWvMaMndDogeho6BIwwEseva8T20fwRT
 A==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012017.outbound.protection.outlook.com
 [40.93.195.17])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b4c22-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 30 Oct 2026 10:01:35 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMAe4WyJrA+YV6NTuQeP92jbAdSnEvgpByYIc9sEVtn8vM2aAroladPYHksF+pqpPj/KD5o9SwW2cRjEt3GjHq67AW0N29Caf60HE8B2jCxf/L5D2/pYnKjkBGW6oe8oKrLK/0j+e63KrCBHj72Pv7Xq2uCsNCOpUDZftJMaBL5PvuBLFtoGXJA7WcAZ99a/J/zJ3O+SKDX+CaWCgGLQ9LxUTHnfjfWis/5u55ApYLGX1j7FIVtl0KFYxgMe/1Di0RJebff/R06OQaC0OUOwS7x0FcJcZ4tgCKd9Nc5ZC0Kmq9qIVOMTQYLtvPk0u3pU8jFRWmpEg0qRAIeRDBKzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4DCjdzrV1lanxSDDI85inD5xNnB64v7Z4nQ0dxJqZo=;
 b=SC9LTU1+BNYpEghnYscICZ4WnF1/6ramLzhoAsdCX7/a7UVSHZzqgO9xRPhCoT6757FVFQeZ1D/dSRZPbTmJoIozxWCMe7Fv4g0/jJga2eTVzpv0bxpAEynva5ivtNIlIv0UcCAmnMDXmwFFPmK1axqi4QzkOatzaMv6D6JzX1nQwhe6PAAVSRH4/4HGOFfDIeLVbQwJEOR0okfSNd8VWlxd4iopHCsOtl0mP7ndspo7HCSQ6zpbF0weK9sd1QgLPjfTgUb6/yGsMamZ3Q+rmgZAQFHmtf2U3lvfjzB2nLLg49AlPm70LqDRxxKSEwib5s0BZd0VNiaEzxqRZogBpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by PH8PR03MB989600.namprd03.prod.outlook.com
 (2603:10b6:510:408::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:01:33 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:01:33 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 2/3] arm: mach-sc5xx: Make the SC5xx board target select the
 carrier board
Date: Fri, 30 Oct 2026 10:01:21 -0400
Message-ID: <9ce0eccae52e49483c445210eccd3e3abc398cb3.1793368074.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1793368074.git.caleb.ethridge@analog.com>
References: <cover.1793368074.git.caleb.ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0190.namprd03.prod.outlook.com
 (2603:10b6:610:e4::15) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|PH8PR03MB989600:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d49278d-ddc8-47a3-9107-08df368e4dec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|18002099003|22082099003|56012099006|11063799006|261026140227099003|261028144727099003|10067099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: r7F0CAXPJaDFj8auVOQsS2TAVNIpvGmwLK4/0x7+Fk5GawCIq5OpGouyKn5XS21PtfkWmwn/HJrvVsa4VdWbXtJrwzLBofaovQia2fUg7LmpI+C1G559rWxNDFUmvKVKSz44S2pf4cj8FOHLeXad2HOCdcy5uFvQkZZgzS6IzwbTPQHMMdTymUjkSPMpwPlCb3TwDRPbTe0uwqEgLk1oDkRU1ZKNwiqNSks3xidyoYsACqz1NqeTogadVreWoOBaN6SQiZRdW3aTyydCcVGE3M7WA82MTYYKUzfxdD3UWLyyFk/AjhXzVS/jmFVwOAW5C28QINXOUQpxSW1+lZzfQS5Q5jxDXonkrNRJywqs0dUOF4BBtFo237+6WIg9I4Lt29xFocXoCfBMQmrmnGQnb8Gc+M/M/d0ZUleuC66DTzhFVOWovw3tWKxmA1ZxrjOCFAq2+b8A6VvJ5GZcix0vvO2VQ7p/htpxALc/6df/g7avw+O8hc9vtNdC5CxfyXmm2w1sAi9XPPna/M/Pgz52bo5TszX8HT0cohIYpPTlw4Aw7WORwUMh/sM9+BfvDN/dfdjIPU6rQ2XHikH2vlwZCjTwfbW1vsOUV/Bdb9gUfq0M4L+BZnq8WL+Pwi+ykp3XJBX3MfF45ggRbS9rVG/dFNYytu3MWpSH/abhj4c0jyo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(261026140227099003)(261028144727099003)(10067099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WTHLJOJ8A5sLHEoeaeleCASXkH6Cce5ixJnYeOEbsr204l7ye9Du1uOVhkMg?=
 =?us-ascii?Q?GNuNkOUrFrFpmDVmD9WOAXZZe70RZVqC/Op6mZee8M/BcTbGGOsPRUpH83rP?=
 =?us-ascii?Q?AJjB6ZZPKfcMUoO3UWR0NakhYf0x+XVJE14NNgM1X69mFfTE1KDKdOfOudyY?=
 =?us-ascii?Q?7cmOz03kynehDo8/7+LNapf1Ejlwvg1nOMo0CVDpGe0T5oz/duxHJdwwr3vw?=
 =?us-ascii?Q?oXali5Ctf3P5kZmwiS19MF6MzQhgLYUs81c0Z9uPcOVSo0I6Hn1YuIu6QqIX?=
 =?us-ascii?Q?MsEGJI9tX04cdyiKZ5w2FZxRHkRCMh3rT4Sby8bPubhxomFsU3FvEDNqitU5?=
 =?us-ascii?Q?x01Mf2jt01yzJxjkzRlxqula1XIg/ygstE7BU9ysS8/19pbqMe+/aL9he1B1?=
 =?us-ascii?Q?rWuZAtmKKMChOqBmAcRXTLN3BZ/S8TpMcsLIPXZksozOLyNSIKKo24Ww4gHq?=
 =?us-ascii?Q?nNuuEK8aj3Yx/HxY4c0PKIADIcsvDY0d9hiD3Odsi9zXQOmTZRzuyYizguZO?=
 =?us-ascii?Q?mRfzvMubPDxq7j7kVbn8sAIN5QL+4/cvuJFPnhIuCsqF7l1bHLquE+3ZPHM6?=
 =?us-ascii?Q?YmV0y5FwY2gC263VXwZdYiKO8wghQ6ftZz+2JdoGtAvO1fT/cIxlOk4LgnhA?=
 =?us-ascii?Q?TRXn09SYVxCVR8o+/zYOaR1EWQekPVvo33B/Z/cJ3sWZrZ4kVuFMOJoQ/oZr?=
 =?us-ascii?Q?bE9Q554lSy89UJJOicb62/Kpp5RWxHlBlcK2WivOGxyGcL0mq8aYIbMYALz3?=
 =?us-ascii?Q?CECtf8J2OKm1WXKqEX5kEuz9CjYd1x6YyDe4KT+K1NLWFHT4O1Bxst5yW1R7?=
 =?us-ascii?Q?Q/teiIYNfp8F+ybIrcwrk2nxn9Tp6ngSMpappSG7My/jxBBvKq4LRHhrW3cZ?=
 =?us-ascii?Q?sSlsSLIm3zHdVA/SZC9+RiFr4esRHEfWH87xHiZjUx7UViWihwj1RUQfxlte?=
 =?us-ascii?Q?d77IrF8vLBq9DknDvlo6FavHEew8J/6vhRtCFDgGaZnVeR/focXwn9Dj8pDB?=
 =?us-ascii?Q?RyfSzhvn7TMl4Sz0/kVbUqcDH6csNlwuyKNBo9on1LdZMghjwCLUVfFVdOeJ?=
 =?us-ascii?Q?tn8m95GsORc27mLtn1BiowFj73FMPEjo4TmsuEQof3qexeXkM3GXV7nK67VX?=
 =?us-ascii?Q?uXi6tDo7iOazyE1gtxIJFK1/dvSsv0UJZzffI7kr7fr9i2MAtFb4BAw/picA?=
 =?us-ascii?Q?k5J/1UXARpFWBYXu8ex8aQlxnxJqZC7KuCgpj98CfsofZHyp8pk+H2I1IwVq?=
 =?us-ascii?Q?ODsSQaLbbLUY23Q/wfLQn3qgwmFxvcQ38uMaKTvpRQxzazIadM/VWxhg/F0i?=
 =?us-ascii?Q?/dgWx7U0uAbNOi6zKF7J5r6M6sJAH2I+YgQ12CNpqp2ZdNynZjHlUFsCJhMc?=
 =?us-ascii?Q?JLPH4Nol8lcQAcqJHzul5Q3OWetbzB8MpXPEHZOujW9wMI2YEZdfM4i9m/a1?=
 =?us-ascii?Q?5Bnnrvy193cue4OZ0rQizbTr1CDnlXKRHAWXbRSmlyi64/8NIfdJGL249HDB?=
 =?us-ascii?Q?KGU1NXwO3oohIx9Vtml5NEvkFvhOQ0XNYZCyvAw6acbfr0HoWQ5yt3+WY7Ym?=
 =?us-ascii?Q?iL0KEu5EOZNYFUDNxehDIbAOLaHm8cPmkjNF9y2kTS7DgQ/r4vtMuCOw5/SD?=
 =?us-ascii?Q?+9KgiIRM2muEYQ95WfzJeZAU3ffLhpzziJa25T0voIoR9d/GDcq9rj9bALms?=
 =?us-ascii?Q?jeZDq2/nynMgG4zr5x+NAF+M4m1WlAUQ4jMHbJa9OdkqdkHelcbcJYoOGxHm?=
 =?us-ascii?Q?v0bn9Y48XJLXMueys/wi2EK12OIEYDI=3D?=
X-Exchange-RoutingPolicyChecked: a+5QmCRpv83Hw2bG7sbCnrW6ZUXb1oKgeEKRipIsdZ81J66iqiDsQJKXbRE64ZFP5P7jC27PpQ/x6aM/HY66INreedP3V1Isqe6Vqoeu8RHaP7ngmNVr9/fw1sLuHJqAEKqUgLabbkcddvFNLnyIbg2wN7qenCX8vUyRBUdbSe2/IrFX0we3RRK7x/pAix2SBIiK0BYLGvsyZwYlAnhQ1hi4KVMczANbjqSsyf0Pb/tfG/V4DyswnJ4dTjqoJHd58Vj6mz0QbRrM9OeOOe1wW5kv2XlBCItYgWLat+i/V+AgK4M0xTx2/fIOqhUmWN7sPtJRR69qXyz0dS4bGYdwvg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d49278d-ddc8-47a3-9107-08df368e4dec
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:01:33.1459 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLUzqEGRYvQUdy5xIIXbO/9F9mol3RwGkSUiNJtWQ4UGhwXDTrVwmx2w5lUbIsuAIjRNpnhK4kpTtHDXXlrfEaoUudqnChR3/Nr0lQbsj8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR03MB989600
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfX0waTdcigpbLE
 okvfdRCtHEXcg+34q52LcBp9LCzB520cxUekbTD6WiNdt0K6dhW7WdXG/6XbZYBRJGGnO2WL2D1
 yARfcPN19/yInqHOG1x8d0+HaOHUoiJSX/v+KRkhRN6Rrb8VvYHGa6Mi14Zi1fOm7slrdOFAeZZ
 c+fCFhObL9AXRI9r4j97eFaGJNXjPpYXYYJt1cW/4fqze++ucEwx9dJF6WCfklcpoLHzMZ/LnMz
 OdCBoqGXFhpc+E+wc2HwEqKfN+0jjKNLc+wJ2Yonr6mea7eVNRlJOlCmqUyZKOTNJ3JtxNQX3sC
 yoqYoALpTcUVpZ0QpGRkb7oKVqoMZf8a30RzUB5ITUF6B5a3R5dpd6BT2dln5/5++LTXCNDeYLa
 c93AN7EU6hHwb2/G1sG6rQNhed54hUabNPtSH5s6SF3hvtodsflDjnw2C0XLKzLg6FGUN8KKSRN
 ikYxjiqXvSTsql0VHgQ==
X-Authority-Analysis: v=2.4 cv=Od8NnRTY c=1 sm=1 tr=0 ts=6ae4a33f cx=c_pps
 a=mbkJAKHg+hX/fqCzz7NXWQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=gAnH3GRIAAAA:8
 a=JlTKLJCl-SbSzw_gSloA:9
X-Proofpoint-ORIG-GUID: ImcJANwkprZZaNQuVq7m-OlhnUf97Swq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NSBTYWx0ZWRfXx2stNINoD9rT
 YNUu9MnHF3Uxv6MEv387dwoigBL1APZREOCSxsoeUWn1l8F7REflojMzomod6a/stBQ3eboaeHD
 Fslo+jkxgb7i2Mj3ytqwJyPOcwFB6KRiTbU/we/1nFQZRI4SzD5n
X-Proofpoint-GUID: ImcJANwkprZZaNQuVq7m-OlhnUf97Swq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300055
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Caleb Ethridge <caleb.ethridge@analog.com>

The TARGET_SC5xx_SOM_* board options pick their carrier board with
"select ADI_CARRIER_SOMCRR_*", but the carrier options are members of a
choice and Kconfig ignores select on choice values. The carrier always
fell back to the choice default instead, so the sc594-som-ezlite was built
with the EZKIT carrier code.

Turn the carrier options into plain bool symbols so that we can
leverage the existing selects in the board targets.

Fixes: 9e24d9a61560 ("arm: SC594-SOM-EZLITE initial support")
Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 arch/arm/mach-sc5xx/Kconfig | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index cf154c221eb..fe19eb5ff66 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -216,29 +216,19 @@ config ADI_CARRIER_SOMCRR_COMMON
 	  Common code shared by the EV-SOMCRR carrier board support.
 	  Selected by the carrier board options.
 
-choice
-	prompt "Analog Devices SOM Carrier Board Variant"
-	depends on (SC59X || SC59X_64)
-	default ADI_CARRIER_SOMCRR_EZKIT
-	help
-	  Select the specific EV-SOMCRR carrier board that you are using.
-	  Using a SOM without a carrier board is not supported.
-
 config ADI_CARRIER_SOMCRR_EZKIT
-	bool "Support the EV-SOMCRR-EZKIT"
+	bool
 	select ADI_CARRIER_SOMCRR_COMMON
 	help
-	  Say y to include support for the EV-SOMCRR-EZKIT carrier board,
-	  which is compatible with the SC594 and SC598 SOMs.
+	  Support for the EV-SOMCRR-EZKIT carrier board, which is compatible
+	  with the SC594 and SC598 SOMs. Selected by the board target.
 
 config ADI_CARRIER_SOMCRR_EZLITE
-	bool "Support the EV-SOMCRR-EZLITE"
+	bool
 	select ADI_CARRIER_SOMCRR_COMMON
 	help
-	  Say y to include support for the EV-SOMCRR-EZLITE carrier board,
-	  which is compatible with the SC594 and SC598 SOMs.
-
-endchoice
+	  Support for the EV-SOMCRR-EZLITE carrier board, which is compatible
+	  with the SC594 and SC598 SOMs. Selected by the board target.
 
 config ADI_SPL_FORCE_BMODE
 	int "Force the SPL to use this BMODE device during next boot stage"
-- 
2.43.0


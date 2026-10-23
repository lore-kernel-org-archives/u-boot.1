Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2166606A31B
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 09:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=EL72qtuA;
	dkim=pass (2048-bit key, unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=I8Y2nAt4
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 74E2060664;
	Fri, 23 Oct 2026 09:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fTQq0o1wxeFO; Fri, 23 Oct 2026 09:06:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1E6B160669
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792746397;
	b=muwdPE6e0DMACrOERG2hqBpTkAQSRShukE9nh0sKzOh2XuirzEFzGwjZRvG4cQDwGtL4
	 qnDh5tMUtsyVUI8M8IKOSlRPMEaOrtAG5zajbbiimMXZ5RmWzvuZMMOKyD/EQMSZKP4/f
	 pbYPlcBXBAqkHiE3YMsEz69UpSd4HatkXgzhRse1ft5QGkYk4jIBZGO6o4F1UzxMZc0B/
	 181nsvDDSlu8fal6zHHi7WlhdjJ3B0y2hPoqfZslXXTP4ljWAoepDLFjyShZ+dulN9kFa
	 +jOA9tds2BW7xMUcSaj5AfcEvvqfM1UHvZI50keDPiBM0CXDE5uXGFDr2a6tj7xGW5A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792746397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=72m68sVz53Bi0eqJC81vdiKJSvCSi/JKSppG0dXWykc=;
	b=VhnoTkoVDtGFHVbelrn5Xtrwkzswa8wDfvhlwUACKoC3iX6QE6lxWHEHUXR6uSLjwVtK
	 kNR3RwB2afZLO15ZMjfQqr5JfG4CH3Y0TaR4NR7dXC6PLkhTR4Imev/UfKH0wcg6R1Oe2
	 f4zEgj+11GWq++JXcnG8sy7XDR6/max45eh7lPxbJV1QDNw2nsx2A0EjzNiZKaOQRvpH+
	 +A2dmMNR8dYdpUHmgm2f/lNWVJDNWCI18yA/QWAOmY9u81wllKPuo2QOIj6Ibn1P6Z3lF
	 mCDnAVwVgxq8hHP41EBUCyI+qbmveJq13/zLVvDm+hp0lMvbBY7i745SmNkZ7EW9aIw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792746397;
	bh=72m68sVz53Bi0eqJC81vdiKJSvCSi/JKSppG0dXWykc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EL72qtuAMzR4lxxtq9YzBF1EVVVV+zc5d7MJQppQ/SyOopqy2A23MTG3n60Oyaxkx
	 OUK51oxKWhtCt0Gniwxx27qBtxAW6dQ1HvovQGKeaFI/QxHp/2I5MzjZm94D/dB2gQ
	 cJFOggQzbZaDUvRbBYB/8aVyl7B6M9y1nR8xZV6vGaPn3Mjk64XQ1dypJGgrL9y7Lf
	 COd7FLgMf+WGQ55HoIZp9V0l8wkCqY6mok8EHvz1ztbNVxJSp+54DsbyUVkgD2rcMm
	 Mdntu9go22RRFk83xT+ulkM9Gjt0T0jDLYDjt2+gX+Dz+PYtiAM7cIh1nfHedK6bw7
	 +c30Ca8SJAeog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1E6B160669;
	Fri, 23 Oct 2026 09:06:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 47408380
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3851640844
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpf493jAO8w9 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 09:06:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A65EE406CF
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792746393;
 b=sUQDl0w1VuDpNo3+IRo4PrZ37j4/QeBtQWYI4cPR3BP2i7etBKy3z5/O5skVycgA1y2N
 iC8165bBNdlqZRIjNww5D/KGzpiG1Lh3uLM3j0AV5/iHm+aSWg7UCzfuq42tQVRBjGYqb
 EI2hlX4+y+OJ7kuJF070RGJRuUojXXIaRm0rYWFmGy5V5pg1QdjQr0ExEvJFXn4cufgI8
 +hpZSKzB6pZtMrz/Gubddq7KGNfkIPuNcKr79G516WBp1bxVpfKAwMbz68tvjHZTQn2xe
 503iUKu3pzRwGt0LN8WqIJoPEqBDcTOdm5iHu9ukSCxABJnknZhDzBuM37IPKQFws9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792746393;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=72m68sVz53Bi0eqJC81vdiKJSvCSi/JKSppG0dXWykc=;
 b=YKO5+o8F7iiZxjxlPOM7hmdsWpngC5Ere3U8ywUJiZAoNHYoBhEqvbSea4OmC391sCyq
 11kv3z8Ubtp/mSxhttmiaFhXZ2e1pZ7lGGi1U0vrX76de0+rnbXVqO2Dwa0cp3yoCBdWy
 PEgqqMmmRsZoRZTOUCZI6kudBpZt+eay+B7PrGrsd0/sqqOFUNY7Bn+Qp9FKp9rUWCIS/
 zp2tjoVDZ/5ukqRhtJHBVCvuEfbZnuKuG1O3Zt1s2Fe2DU1zbsInlJ0rWmNjm6g8V8lFx
 c+szcN/FDtc5WerwNQdeHfdmsHzNLjPUsmWh2/AtZFUG1LtsPut8AbgoPNPobn9rMyQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=none header.from=softathome.com;
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=I8Y2nAt4; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::1;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=yan.wang@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=I8Y2nAt4
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A65EE406CF
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 09:06:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZnH4WMKGJE1u6bExxnDoaS2bE0LxDV5Cp9y4BkRnGUtaiST1lDJnOyneFG8qS+4EFvvkbkoDE7n+5rTUdsQ0T1e3KZPejQR2eoN646h9Va2+zlOMf0Ps+yBHnxCNmOWR9ie9QRM8q3ycRqIaOzBd/S9rNP/gTBuTMK+qD0tzE0ZYmzlAyPsmNuofFywNbwiejkgL/QoPH3Cn3cuetAHxn8KjofwF2omcNiTfoW6XbgDXdbvVPspu/XkpOiUbAbswSK55y1yCbFfCUR2cUW306P2XdCSo0Hs/uyuDHJayIPqOAyU8RmmuwrDCbFfEdU18xVLQgezexI17ULEWUnzvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72m68sVz53Bi0eqJC81vdiKJSvCSi/JKSppG0dXWykc=;
 b=fy9zUQ+PdkA2JsaFIkKaRpGPLYulb2dqEn6wK33QJ/VIY/DVCDzoHaO6CjAcC+s9rKosWP5qbFZyUMNasCPGk1U9VAFDH9dYSB4d8Rbh73K85FLgfTcLz78iJjPxsit1pzCsjXyUKmEI064Gn1ppUaRX/forMgHa2XPaBaHDOfsd/P5xsjj6mlp+TN1yGEHY+0VAOjILGplykY0NLKoAB1RtBRLKdP8pZdPCBqJihEhlwvS6Z62ca5V8PAf2jSpcJtw8vE8XodNfQ/xOIJ3+Bh1f8OU+uTdIg2RCRxZYMQ1fkuYaBwf9l0OGWoxbVnmTGU2JdVT6K8FAQzAGivswsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=chromium.org smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72m68sVz53Bi0eqJC81vdiKJSvCSi/JKSppG0dXWykc=;
 b=I8Y2nAt4j2NhhqT9uROz0AJON0uxAShMgy6lzSG/ZSRw7Oh7xtws18TsmKGuR4bZtiOf67rl97tqAUsADsFzHPA6G6+1y2tvaA9ZvvRFkkCWBxONQwYJR+rfY+k9LXPm8Ll/41ifGNlYVgavWOkhsHt2vcN3CeB4/KgrUPrWe1U5ihocHhdNejQ87fACCwSaHr3PoEYsdMfrUqUYFx7eVDcYptcvXNWfayW4JtIm3GzYfho7IR9hcAgZVoODM0vALBn7IYRNNV6+k4lioxLQZsgmF7oW6iDkUGzYDGF6g2mbS+Hw7KSjb0tYKFZSknZL+6TeiukMx/xSyy3wJHag9A==
Received: from PA7P264CA0109.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:34c::10)
 by MR1PPFE977920DA.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2dc)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 09:06:27 +0000
Received: from PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c:cafe::56) by PA7P264CA0109.outlook.office365.com
 (2603:10a6:102:34c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.19 via Frontend Transport; Fri,
 23 Oct 2026 09:06:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not
 signed) header.d=none;dmarc=bestguesspass action=none
 header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3F9.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Fri, 23 Oct 2026 09:06:26 +0000
Received: from localhost.localdomain (unknown [192.168.72.34])
 by proxy.softathome.com (Postfix) with ESMTPSA id 8C6EE2024F;
 Fri, 23 Oct 2026 11:06:26 +0200 (CEST)
From: yan wang <yan.wang@softathome.com>
To: sjg@chromium.org, alpernebiyasak@gmail.com, trini@konsulko.com,
 alchark@flipper.net, paul.henrys_ext@softathome.com,
 philippe.reynes@softathome.com, marex@nabladev.com, raymondmaoca@gmail.com
Cc: u-boot@lists.u-boot-project.org,
	yan wang <yan.wang@softathome.com>
Subject: [PATCH v2 3/4] binman: pre_load: Add HSM signing support to pre-load
 entry type
Date: Fri, 23 Oct 2026 11:06:09 +0200
Message-ID: <20261023090611.778581-4-yan.wang@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023090611.778581-1-yan.wang@softathome.com>
References: <CAFLszTjVm0ApA=N-9ATAVd-ZvUu-NgCGJ3iUyOUP25h-ivNHRQ@mail.gmail.com>
 <20261023090611.778581-1-yan.wang@softathome.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3F9:EE_|MR1PPFE977920DA:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 814e7027-49ba-45e2-6978-08df30e4eb44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|56012099006|5023799004|4143699003|261022105027099003|261022075727099003|261021130227099003|261022113327099003|261021121427099003|261021133027099003|261021135927099003|261021123027099003|261009223027099003|261022115727099003|22082099003|17002099007|18002099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: og2u56eOYqrgJYvXZgTLv/uv/pLoSM0ipZ349NQYI78JOdLB+UrB3f2Kq+ap1lzPqMKL5Cbi+xBTERzsZTtqF6UYMID+qji0UnFLLNedUKw1bbHT8lMS8ouH3euVfZ7X0rXXr2GDKXVJAG1U8m0btV1zHOMie+qOLxA6iBamU9u/rn1O1NSIYIVIdDNrez6kmJrJ8+7cKIkpuRT2oyHqAFQ37yeXdXw70vR4DLq9jY/8LyltbCPdFaV+IAfQpiVdAA/6iFEsrybDxItZmJ2t2ppJWrMg0VqV/76tdEnsa6yYWGoiqHOme+VWOSrLGM3KlANsVuW1uNBx6lpxihgyjyQxLXHa9+S/E+mh0J492R8yyx7DFNbWA4YyEpF4dwfgxzEZQPOXtwpcOIBxZKrBDAlVUkyG1M92L48S5BZOGSgUW68eQWvkppqHV/A3VYQkSu5qBzduuYF/saWrrjfX1rUGSHtRSZ89H3bBoYEj0JgToqOgyF1GuiEDCt+aw7CybPXDerbRf6m7QoMty0C48ege+art5Yebxk3WXN/Lov/Mya+XFaX7/uFS6M1EHl7UH7rVEIwNtFnASVm0e+WOCSVDRJK2Fr8jJqx8ob7jlZxftFhvUwOezRDB7VLn1oycxTWcdTrbIsi2uUhrSkOP4DSKf9yEjWjBwT6j3uYjM+HF3LNv9rETp4hCbjPCONUaOuVKZ4P7WC9J2vTTqrG1Cw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(5023799004)(4143699003)(261022105027099003)(261022075727099003)(261021130227099003)(261022113327099003)(261021121427099003)(261021133027099003)(261021135927099003)(261021123027099003)(261009223027099003)(261022115727099003)(22082099003)(17002099007)(18002099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8SHnmlFDKQdSK29x27c6Om7qsXksd+SN8U820I+4QPvkQVHeqVzI0oilX/XvSa5cIH2RvWXppnxMT11NlxejfHQxgEb26ybI0gxcOf5AjQN+uBC3559vQLIUdyMVOq/2VSU5xKblAvHv4kc2F+yv+v1qNTw41QK/37J51yMfldCOfzTyHN4dSPPpBOHjUDWSrrtEDCzwsRtZ8NZpTrLSHx1vQb6ZVCT1zm3+rz7uIdMnzFklsPLN11p1cnGU4eKeBjNS8YPQhHoZv3cKPy8NB5Yri6BIFZ5M1fbyav6tkaHUq9z6Xb6T64wWmGAPsP8sUF99u+6+p/8ELldEKF2N8Gcvh3rn9w9auqMgDzVbNVEQqvYSCytKvTJnWuCoTGCzLq+lDhMPek/A5Mk3DU4Q2To3oUWyPsLSu2L3Fm5mkJ4dgYRoNjXayM3qALlb8Y9J
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 09:06:26.7175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 814e7027-49ba-45e2-6978-08df30e4eb44
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3F9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFE977920DA
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Extend the pre-load entry type to support signing via hardware
security modules (HSM) using PKCS#11. The implementation integrates
with the pkcs11_tool btool to perform signing operations.

Signed-off-by: yan wang <yan.wang@softathome.com>
---
Changes in v2:
- Replace the hsm-support, hsm-library, hsm-token-label, hsm-token-serial,
  hsm-slot-index, hsm-key-label, hsm-key-id and hsm-pin properties with a
  single hsm-key PKCS#11 URI (RFC 7512), in line with FIT signing
- Do not store the PIN in the devicetree: use -a pre-load-hsm-pin or the
  PKCS11_SIGN_PIN environment variable
- Take the library path from -a pre-load-hsm-library, the hsm-library
  property or the module-path attribute of the URI
- Drop the _SignData() refactoring of v1; keep the file-based code
  unchanged and add a separate _SignHsmData() helper to reduce the diff
- Write the data to a file in the output directory, as sign() now takes a
  file
- Add ECDSA support
- Validate the HSM configuration early in ReadNode(), before the tool is
  looked up
- Check the length of the returned signature
- If pkcs11-tool is missing, record it as a missing bintool and emit a
  dummy header instead of raising an error

 tools/binman/etype/pre_load.py | 222 ++++++++++++++++++++++++++++++++-
 1 file changed, 221 insertions(+), 1 deletion(-)

diff --git a/tools/binman/etype/pre_load.py b/tools/binman/etype/pre_load.py
index 49a63ecaafa..14bfb23afb5 100644
--- a/tools/binman/etype/pre_load.py
+++ b/tools/binman/etype/pre_load.py
@@ -7,6 +7,7 @@
 
 import os
 import struct
+from urllib.parse import unquote
 from dtoc import fdt_util
 from u_boot_pylib import tools
 
@@ -21,6 +22,34 @@ from Cryptodome.Signature import pkcs1_15
 from Cryptodome.Signature import pss
 from Cryptodome.Signature import DSS
 
+def _parse_pkcs11_uri(uri):
+    """Parse a PKCS#11 URI (RFC 7512) into a dict of path and query attributes.
+
+    Path attributes (e.g. token=, object=, serial=, slot-id=) are separated by
+    semicolons. Query attributes (e.g. module-path=) follow '?' and are
+    separated by ampersands.
+
+    Args:
+        uri (str): PKCS#11 URI string starting with 'pkcs11:'
+
+    Returns:
+        dict: Mapping of attribute name to percent-decoded value
+
+    Raises:
+        ValueError: If the string does not start with 'pkcs11:'
+    """
+    if not uri.startswith('pkcs11:'):
+        raise ValueError(f'Not a PKCS#11 URI: {uri!r}')
+    rest = uri[7:]
+    path_part, _, query_part = rest.partition('?')
+    attrs = {}
+    for part in (path_part.split(';') + (query_part.split('&') if query_part else [])):
+        if '=' in part:
+            k, v = part.split('=', 1)
+            attrs[k.strip()] = unquote(v.strip())
+    return attrs
+
+
 PRE_LOAD_MAGIC = b'UBSH'
 
 RSAS = {
@@ -53,6 +82,37 @@ class Entry_pre_load(Entry_collection):
         - key-name: Filename of the private key to sign
         - header-size: Total size of the header
         - version: Version of the header
+        - pre-load-hsm-library: Path to the PKCS#11 module (.so). This is a
+          host-specific detail that varies by distribution and should not be
+          committed to the board DTS. Pass it at build time with
+          -a pre-load-hsm-library=... . It may also be set via the hsm-library
+          DT property when the build host is always the same, or embedded in
+          the hsm-key URI as the module-path= query attribute.
+        - pre-load-hsm-pin: PIN/passphrase to unlock the PKCS#11 token. Must
+          NOT be stored in the DT. May also be read from the PKCS11_SIGN_PIN
+          environment variable, mirroring how mkimage reads MKIMAGE_SIGN_PIN
+          for FIT signing.
+
+    HSM Signing Properties (optional):
+        When hsm-key is present, signing is done via a PKCS#11 token instead
+        of a key file, following the same convention as FIT signing.
+
+        - hsm-key: PKCS#11 URI (RFC 7512) identifying the token and private
+          key. Supported path attributes: token=, serial=, slot-id=, object=,
+          id=. The module-path= query attribute may embed the library path in
+          the URI as an alternative to the pre-load-hsm-library entry arg.
+          Examples::
+
+              hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+              hsm-key = "pkcs11:serial=abc123;object=uboot-key";
+              hsm-key = "pkcs11:slot-id=0;object=uboot-key";
+
+    This entry creates a pre-load header that contains a global image
+    signature. The signature can be created using either a traditional RSA
+    key file (key-name) or a Hardware Security Module (HSM) via PKCS#11
+    (hsm-key), enabling production keys to remain on the HSM and never touch
+    the build machine's filesystem.
+
 
     This entry creates a pre-load header that contains a global
     image signature.
@@ -77,6 +137,28 @@ class Entry_pre_load(Entry_collection):
                 };
             };
         };
+
+    Example with HSM signing::
+
+        binman {
+            pre-load {
+                content = <&image>;
+                algo-name = "sha256,rsa2048";
+                padding-name = "pss";
+                header-size = <4096>;
+                version = <1>;
+                hsm-key = "pkcs11:token=uboot-hsm;object=uboot-key";
+            };
+
+            image: blob-ext {
+                filename = "sandbox.itb";
+            };
+        };
+
+    Invoke binman with::
+
+        binman ... -a pre-load-hsm-library=/usr/lib/softhsm/libsofthsm2.so \\
+                   -a pre-load-hsm-pin=1234
     """
 
     def __init__(self, section, etype, node):
@@ -87,6 +169,18 @@ class Entry_pre_load(Entry_collection):
         self.header_size = fdt_util.GetInt(self._node, 'header-size')
         self.version = fdt_util.GetInt(self._node, 'version')
 
+        # HSM properties (optional); populated from hsm-key URI in ReadNode()
+        self.hsm_key_uri = fdt_util.GetString(self._node, 'hsm-key')
+        self.hsm_library = fdt_util.GetString(self._node, 'hsm-library')
+        self.hsm_token_label = None
+        self.hsm_token_serial = None
+        self.hsm_slot_index = None
+        self.hsm_key_label = None
+        self.hsm_key_id = None
+        self.hsm_pin = None
+
+        self.pkcs11_tool = None
+
     def ReadNode(self):
         super().ReadNode()
         self.key_path, = self.GetEntryArgsOrProps(
@@ -94,6 +188,50 @@ class Entry_pre_load(Entry_collection):
         if self.key_path is None:
             self.key_path = ''
 
+        # hsm-library may be supplied as an entry arg so the host-specific
+        # library path is not committed to the board DTS.
+        hsm_lib_arg, = self.GetEntryArgsOrProps(
+            [EntryArg('pre-load-hsm-library', str)])
+        if hsm_lib_arg:
+            self.hsm_library = hsm_lib_arg
+
+        # PIN from entry arg or environment variable, NOT from the DT.
+        pin_arg, = self.GetEntryArgsOrProps([EntryArg('pre-load-hsm-pin', str)])
+        self.hsm_pin = pin_arg or os.environ.get('PKCS11_SIGN_PIN')
+
+        # Validate HSM config early, before any tool is loaded, so a bad DT
+        # fails immediately regardless of whether pkcs11-tool is installed.
+        if self.hsm_key_uri:
+            try:
+                uri_attrs = _parse_pkcs11_uri(self.hsm_key_uri)
+            except ValueError as e:
+                self.Raise(str(e))
+            self.hsm_token_label = uri_attrs.get('token')
+            self.hsm_token_serial = uri_attrs.get('serial')
+            self.hsm_slot_index = uri_attrs.get('slot-id')
+            self.hsm_key_label = uri_attrs.get('object')
+            self.hsm_key_id = uri_attrs.get('id')
+            # module-path query attribute may carry the library path; the
+            # pre-load-hsm-library entry arg (already applied above) takes
+            # priority since it is more explicit.
+            if 'module-path' in uri_attrs and not self.hsm_library:
+                self.hsm_library = uri_attrs['module-path']
+
+            hash_name, sign_name = self.algo_name.split(',')
+            if hash_name not in SHAS:
+                self.Raise(f'{hash_name} is not supported')
+            if sign_name not in RSAS and sign_name not in ECDSAS:
+                self.Raise(f'{sign_name} is not supported')
+            padding_name = self.padding_name or 'pkcs-1.5'
+            if padding_name not in ('pss', 'pkcs-1.5'):
+                self.Raise(f'Unsupported padding scheme: {padding_name}')
+
+    def AddBintools(self, btools):
+        """Register pkcs11-tool if HSM signing is requested"""
+        super().AddBintools(btools)
+        if self.hsm_key_uri:
+            self.pkcs11_tool = self.AddBintool(btools, 'pkcs11_tool')
+
     def _CreateHeaderRsa(self, hash_name, sign_name, padding_name, key_name):
         # Check hash and signature name/type
         if hash_name not in SHAS:
@@ -197,8 +335,90 @@ class Entry_pre_load(Entry_collection):
 
         return data + pad
 
+    def _SignHsmData(self, data):
+        """Sign data with the configured HSM via PKCS#11."""
+        hash_name, sign_name = self.algo_name.split(',')
+        padding_name = self.padding_name or 'pkcs-1.5'
+
+        if hash_name not in SHAS:
+            self.Raise(f'{hash_name} is not supported')
+        if sign_name not in RSAS and sign_name not in ECDSAS:
+            self.Raise(f'{sign_name} is not supported')
+
+        padding = {'pss': 'pss', 'pkcs-1.5': 'pkcs1v15'}.get(padding_name)
+        if padding is None:
+            self.Raise(f'Unsupported padding scheme: {padding_name}')
+
+        if not self.pkcs11_tool.is_present():
+            self.record_missing_bintool(self.pkcs11_tool)
+            return None
+
+        input_fname = tools.get_output_filename(
+            f'{self.GetUniqueName()}_hsm_input.bin')
+        tools.write_file(input_fname, data)
+
+        try:
+            signature = self.pkcs11_tool.sign(
+                input_file=input_fname,
+                module=self.hsm_library,
+                token_label=self.hsm_token_label,
+                token_serial=self.hsm_token_serial,
+                slot_index=self.hsm_slot_index,
+                key_label=self.hsm_key_label,
+                key_id=self.hsm_key_id,
+                pin=self.hsm_pin,
+                hash_algo=hash_name,
+                sign_algo=sign_name,
+                padding=padding)
+        except (ValueError, RuntimeError) as e:
+            self.Raise(f'HSM signing failed: {e}')
+
+        expected = (RSAS[sign_name] if sign_name in RSAS
+                    else ECDSAS[sign_name])
+        if len(signature) != expected:
+            self.Raise(
+                f'HSM returned {len(signature)}-byte signature but '
+                f'{sign_name} requires {expected} bytes')
+        return signature
+
     def _CreateHeader(self):
-        """Create a pre load header"""
+        """Create a pre-load header.
+
+        When HSM signing is active the pkcs11-tool btool is called twice per
+        _CreateHeader() invocation (once for the image signature and once for
+        the header signature). Binman may call ProcessContents() several times
+        as entries settle, so consider caching the slot and mechanism results
+        in a real deployment against a rate-limited HSM.
+        """
+        if self.hsm_key_uri:
+            # HSM path: use the HSM signing helper
+            img_sig = self._SignHsmData(self.image)
+            if img_sig is None:
+                # pkcs11-tool is missing; return a dummy header
+                return tools.get_bytes(0, self.header_size)
+
+            hash_sig = SHA256.new(img_sig)
+
+            version = self.version
+            header_size = self.header_size
+            image_size = len(self.image)
+            ofs_img_sig = 64 + len(img_sig)
+            flags = 0
+            reserved0 = 0
+            reserved1 = 0
+
+            first_header = struct.pack('>4sIIIIIII32s', PRE_LOAD_MAGIC,
+                                       version, header_size, image_size,
+                                       ofs_img_sig, flags, reserved0,
+                                       reserved1, hash_sig.digest())
+
+            hdr_sig = self._SignHsmData(first_header)
+            if hdr_sig is None:
+                return tools.get_bytes(0, self.header_size)
+
+            data = first_header + hdr_sig + img_sig
+            pad = bytearray(self.header_size - len(data))
+            return data + pad
 
         # File-based path: dispatch on signing algorithm
         if not self.key_name:
-- 
2.43.0


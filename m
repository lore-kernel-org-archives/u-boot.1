Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1182606A31B
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=NCT3Dz59;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=F+p0C+KL
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7419340620;
	Mon, 26 Oct 2026 09:56:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sekoImCsOSX6; Mon, 26 Oct 2026 09:56:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 92CE3405EE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793008576;
	b=phzvwSXCG27d7lx0uyVQJlciUL/+NSI9GAlDl8a2p+khxfUf7lcSuVN7epJJ2CopcdJL
	 Ld3EKlXzH9vX64J+huuiZU17q14uJx8+4t0VxssvTt6X6q/iCCbB4Zd5DhS6OVGtXxRFN
	 sTU0LwKiyELNVJ4ETsLJQG1MJeoNfChJsvGauZ2jQW8CHVf4ssmSFj1lMMQMTugRjbb1u
	 MQgVxKYTHYBuyk5HE6slOsqRy0wyP+DRShqaYH3Rptk1ElqLO3ebyM5z+Hfaw6uq0wQ6a
	 UkZoV5kFrzDg2bohjQz7i0aldpV7r5iqOdFpO50fQwxOJ/FK8xHiKp7t/xQ/dmsaA1Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793008576;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g8kLYPuPrke/WKjMHa6De7Pb08dpelCkvw0Dm1qY5PU=;
	b=j0cogiUW+a/m3wTZ0rPQrwXrll/yKCU4jystLkkTkgyhiuI/XtjreySuYR5zHm/cWiyt
	 HaofKd1e4f/jx0K7TL1cz8Bw4fV21koA76Ohe3GOg7SETmOoK39GzcvsnewL5LePTY27m
	 hrIypLwzuMQTJOzdjpXvJX3Pa2/iRlDu9u+jknAk9jMPh8GRq75vYn5+b7M8OaHzEDmpo
	 2CwBAFRhtYEBp2pxGUdz4z6mGPwcnQ2ILth3WZfPHfR55jGISoBbZ+vJ3e0SqTY0ZMLX8
	 TNMElhUPQJiuBhn9VN3nojGmHbmLKG4tIhCCqnHiHSCI0JQcNH2WoxEEWOMmEpurDLA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793008576;
	bh=g8kLYPuPrke/WKjMHa6De7Pb08dpelCkvw0Dm1qY5PU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NCT3Dz59Nc8LrY4yA33Rp9Ga3N/cBGFDjPP6HrG1NinV6GfTAKU/H3uhshx41y1U0
	 PJG/ay6qZcQVnt/AxV1yk1s72CGhSjlddz45VWLP0PPiFoLen6w1UisnCLFEaf1ZSR
	 rDAgmoFnQCwneHKydQeOJhe+cMxG4zOu+PAIUFWSbPOmRuiz9KalWh5DkMgBXV7xMF
	 xvZIvUz7u6kskJ87PHYtvTE5scN3kedu28O4uweyJnZtgWutwTqW9x66HUBKQF+lbd
	 uiKgl5zdLfZZ1FXaydEFt+/tKPQVlbbmU6+KdFj3uBGvBFbmdPTFK0YkZe7H/VpMwa
	 XRtNHpQ9prQEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 92CE3405EE;
	Mon, 26 Oct 2026 09:56:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7CA193D9
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6294C40049
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:08:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KgYWEblu3ZCs for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 09:08:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 04D3C40072
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793005721;
 b=TAaQfxI4lkcLmUjrZ5zUy7FrLT8SrcnbBuDBJnOEJxh1yljW6IgjJit+lrIoQTKCE1WV
 bYnh7zC1gKd5GZCK8QK8y+fq+VJCTbfKDqc+8zDg6MOeWbAEE7fKM824LTpiBmb1Q+WaD
 NC7WgAzGI5+z7OrEu4JBgNz6l7g+iNq++kBdyXXTBbbtwXUfXEWRXtR2P+ZzS4TpnjkgF
 aDIwBn78vOT98tfKXc3NjoVuNLN0vDdbcReMNiFZs0iqA0kXl/OHxR6HL7+HsRl5DHw/3
 t/YzN8WSG1pvTgJiwNwBvtHAtBL77tgaHFDZnHb+b/7KCUy/QnevKMCYN75gU5akfgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793005721;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=g8kLYPuPrke/WKjMHa6De7Pb08dpelCkvw0Dm1qY5PU=;
 b=nKK5pixFV5NPi8W8woI8TrZjZPTqma3+3V0Kzvaed2YlXFzusdVFGvh5ztUxTibSfdTy
 kKGs6VZGyGui1gLlbj/GIctLo7ZBW32MDisSnD8CxGYHgnCodKbUzqR9XmicDK0szF3T/
 mw0V35bFcmxHPRwoFFbIynxwyDAlY/4/1H3taPVu5NLy/na4gOYg1uFYmGcxCUrewmbTE
 oQWdqEnLhrthjtBkSkmb8992aqhXYEh+QLw2CaQCIfPb8H5X56n7S5mdpJFaibOD49YLf
 1wWDIVtVDTMlUHCdJ6/VZ8TbIHirjHZI0y1qks0LXGl0yyciipU7ylRKmx1Xq/r3M+Q==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=foss.st.com;
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=F+p0C+KL; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=F+p0C+KL
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 04D3C40072
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 09:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z8+pq95sBsRFGQllqqmhDH+x8oqa9s3Xi+r2+2rhUwDvS6QLOFmbpEyqkunRFM3fVSBDJVIxrCQaXh7BgNCUU9jS8CcEJlOXLsiOPiWuQ0U1GE9EVHewx5Tb57/MoyUzyAhkbTqTt0FVMoaGPVBbb+1erDgGcUPhD+5CD4xzl7BzeeZ36giwghw3ic7utbMFs0aM7pkt1YQao3e9VzNqF7Ma1rNz5FnV2Lq5uzOv+W++UMZ0MnD7KipsxdpmWFfBrlJohmu2+y1sfuqdX+McvyVJx8oE8HhpwBP3IF81cXUc2Koy4ohD3w/se5/YUFVk7AAtFpuVW8IldhLkCYZ/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8kLYPuPrke/WKjMHa6De7Pb08dpelCkvw0Dm1qY5PU=;
 b=k2xs22dWaptMTVZMAkEXC4ZphD3IB5k45cGJO8tKvtzMYy10og3UIfJp8xjAsTILulEPVQU97mFMCzXpiN6BExvJVBxwzqqp5tiA+woEgmP6HImfUoftNGUGtE9eMvDVtAln5FfanPcw0FCFcZ8rTuI2FDiMa2S6g3xil6Ifg1z0BVPA93OxgvtzWhiIvk8hyD4sJEFSD6mm+t6nXvJ/k3XCNwztx4Pqsdtmz2iGiqxXpiwZPpWocSCKsWbOHwCiFyYLdo5JZ3RBP90m+wvfh3X4yvSQXM1oL0n83C39KMuM16BH9tBoOnt+DnuZC+WtmqGeJ1JoKY7iVG+Q1DoyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8kLYPuPrke/WKjMHa6De7Pb08dpelCkvw0Dm1qY5PU=;
 b=F+p0C+KLimWlLk9CoLWUiK38O4N9fW5/qdCBk3vkBW4Sc0LqevTl6tUXMUaXACJCCfJWtH/KwxeX53Zsw+CI7hLh3Vwuj+l4xNh0ElbsISg/DFv48NlAZKyKmMLqCWbnONHQCZdEk4f4/79ImebhmhN2XHPLH5BB5nXK2+WiizbPqBcqfGRLETGmpEN8O68AZ5NnKCqYqzsAbOjzz2m/+2birpuzNqeAXcwyPN1stmf+Vjwx+Vwb5dMQw3Sj7tC01GibjjKlX59l/N9Ai5RpHrcnV4NirjHPqTQk0YaePNXtOLYrFqNB16y4nEm5b90SvbZ/n+PJfuO4oZdL+rV00w==
Received: from AS8PR07CA0002.eurprd07.prod.outlook.com (2603:10a6:20b:451::31)
 by VI0PR10MB8835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.6; Mon, 26 Oct
 2026 09:08:36 +0000
Received: from ZR1PEPF0000E460.eurprd04.prod.outlook.com
 (2603:10a6:20b:451:cafe::37) by AS8PR07CA0002.outlook.office365.com
 (2603:10a6:20b:451::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.6 via Frontend Transport; Mon, 26
 Oct 2026 09:08:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E460.mail.protection.outlook.com (10.167.241.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 09:08:35 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 26 Oct
 2026 10:08:54 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 26 Oct
 2026 10:08:30 +0100
Message-ID: <a6d15664-2c7c-4d35-afc9-f717b33fab67@foss.st.com>
Date: Mon, 26 Oct 2026 10:08:30 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: dwc2_udc_otg: wait for mode when digital
 filter is active
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, <u-boot@lists.u-boot-project.org>, "Kongyang
 Liu" <seashell11234455@gmail.com>
CC: Lukasz Majewski <lukma@nabladev.com>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>, Patrice CHOTARD
 <patrice.chotard@foss.st.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
 <20261008-dwc2-iddig-fixes-v1-2-24c302b8953f@foss.st.com>
 <xhkdbecdk4s97.fsf@mkorpers-koolstof.csb>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <xhkdbecdk4s97.fsf@mkorpers-koolstof.csb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E460:EE_|VI0PR10MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e028806-239a-49c6-103e-08df3340b753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|18002099003|22082099003|56012099006|11063799006|4143699003|261021123027099003|10067099003|261009223027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: AaZhDnzaySS2auNuirP4P5y8L0lmLauDXPTKVmkufCDHE/gKqGRPuXw71z8dJbg20587IR5ysfNQxOisqppxc50tVN5nY0QP5h+wEKYa6q9p3Al59vcUKlA7fEGsvBCaewKWOPeC9TbrXSE3GbAz/p4Z7YEbbgmN85l5V+vxrIsHs7LUDbxva7MUqE9MsTCyOGbgRqoBUBlBMn8u1NAvAsjfSM9p29p2OkzMXRamr9uvd6ntzXw6dPpqYAz0O4gtWmQPVcPb09JhJ2SObJAQ4+cYc+PE5qHVtDADZupf7uEfKr6qKlWOb1a0jAIMu3H9cTU2Vv/eXsB85WAwFF2tZ+wmDn09VOglx/fXTxU5l/8H1ApRZ5Jp2cBSNdeXYni/njiYjuKXvgJYdEoSjT107JKh0nmh10Tx0FauOnLQn8IpEpLyTxHGeu6JaJnvSxNTOL/KT2FR/8M/Qf31CDuEuwelywEowHi+O0o6st124z/TT0oPxDQMDJIe3wGSJHhIb5yuWj9GRRzjCx+AU6+km91bdgaPE65bYodrXhFgLFzGwDX9DLac94JMG1T1zxRqRectzTsa8pg1SvGpCFU3UjhFU3LRov0LhXu5bgBk69ZpeF4eunzdUa2ug/nDbkRpPe7FgXhZuEvKDgY5olnF9woFQ982h36ru3xwIh9QLQCPk2FqHTQ0VWqGMUyoh5FqopyD/0CoB+Cb1/H7UlEpQA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003)(261021123027099003)(10067099003)(261009223027099003)(261022105027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uMlvCkedEK4qaI1zD+ltTBEmhbknX8KgHCq8ZEiNQ68aDyeMdn+HuyXRc6fWEi8wA9pcsQjaKiyzvZTA0DvbOU1Xy8Sgo/SV6YbcZg90q7QLrOkW0SDDkQns5sDr+c2iy1KG3ayipwnR0UD7afMZ7NOYpdQkbXbbH2siuAPGmoKkYQ4vNSTxuD40cV3U3aYdnHkva5+sXNzHo5fl4qScvHC4WGxjVXpB3+65CyU1MgXmn0g+w9zsSeZJjxcVs97+gA8Wy0qY3OFj/OnQfNaySOIIAj9h+eES8LDAFvacK3/f6NNkgwEAFrb1A8rSPYUzAaKspEUYt2l522RBTE3mwupCi7yAdfMbXiOCxvC6tKUOUXh250WBY2xe7pC5ibtpG4q7/1Qvho4NjETRvL9z7msUEgOdm5jhE0fn5fXlD7NM+Xbokax1A3ADOy/H0BOb
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 09:08:35.6276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e028806-239a-49c6-103e-08df3340b753
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E460.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8835
X-Mailman-Approved-At: Mon, 26 Oct 2026 09:56:09 +0000
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

On 10/20/26 11:48, Mattijs Korpershoek wrote:
> Hi Fabrice,
> 
> Thank you for the patch.
> 
> On Thu, Oct 08, 2026 at 17:37, Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:
> 
>> When starting the dwc2 core, it may not be seen in the correct mode,
>> when the dwc2_core_reset() gets called. This is seen on stm32mp1 upon
>> first call to reconfig_usbd(), a warning can be seen:
>> - "Waiting for GINTSTS_CURMODE_HOST timeout"
>>
>> When the core gets initialized, wait for the debounce filters, so the
>> correct mode gets read and polled later in dwc2_core_reset().
>>
>> The routines are added to dwc2_core.c, and inspired by the linux dwc2
>> driver.
> 
> It looks like this patch is based on linux commit
> 2938fc63e0c2 ("usb: dwc2: Properly account for the force mode delays")

Hi Mattijs,

Yes Indeed, and also...

> 
> Can we add it to the commit message? Or please add which linux kernel
> version this change is based on.
> 
> If you wish, I can edit the commit message when applying. Please let me know.

... there are routines picked e.g. dwc2_iddig_filter_enabled() and helpers.

This has been inspired by Linux v6.18. It looks like still the same on latest v7.3.

Yes please feel free to fix that up while applying!

Thanks,
Best regards,
Fabrice

> 
>>
>> Fixes: c5d685b8993c ("usb: dwc2: Unify flush and reset logic with v4.20a support")
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 
> The code looks good, so, with the additional details requested in the
> commit message:
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> 


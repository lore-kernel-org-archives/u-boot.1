Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272E6C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:37:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 405B460840;
	Thu, 17 Sep 2026 09:37:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ifhAcM7u4mqR; Thu, 17 Sep 2026 09:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 86D4C607CE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789637852;
	b=NzFMGsTts7z/bcAhbr0fF9OYd76piUjPDq9DrEiyNYu0Pl43/Mt857z/iuyBAphC5RZR
	 jTqbVNKMYALJXpzUiXhgqQl+Rluc/ZNZ0tK+DMHIhLW4Ns2PjL1L/OxJm0tT0JnWaw1OL
	 BVVmPc4I6I9T1sq6mbys/nz89UOivSd16kXgdiiyv8lR8kGtce0q2sExLP3TfnK6L52v1
	 m0nkF5BHD+jK62AM0Ce1cKVO9Srk1QqiXInauEgIXGeaoRcYoUUNjla3oyfkWN51nvNnN
	 tWjG9TqVU3u1RCBj+fubyTherNiVxsKJR+HmndjZ2dZe0FuUydVMXqrUgLfyyfWT6HQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789637852;
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
	bh=0plsDxbH0d71S8QmJHo+SnyZ/hTG5HpW4XYfP8eYbWk=;
	b=YaTHmHkH9HxvoYCZ5+6BGlgfu2VbUjIxv22wDlbLKsVVsOqQ9UbqGyAhM4Ez/IFqkFVT
	 vO/QhjsTHkhXgTDuejk5dPFXFKCuSgALDXiJK9Tl/pXBNr3K8ZcZnw0fWPtPTmNnhRQG6
	 XjWxb575tkyerblK9sOOU0DCJqyT+DXKmRp9W6Mfj/h80s45J7Ylld94fbNIqqyvP+kCx
	 pYJqcsSp5QNaf8g8/U/qb0nSZUT77KO2r31C//NVP3+Fu7CVxwQN5Yl9cJSKBdDo7kYLy
	 m6CJi8Qjpt1vzbVC4VAWvSbxZKIoMRRFL7Ry4742jsRrmluZVtpUwVSNqS3NNjE6a5g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="PMPLG/u8";
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789637852;
	bh=0plsDxbH0d71S8QmJHo+SnyZ/hTG5HpW4XYfP8eYbWk=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sCjC7Bn/k+fAzqGc4HvR8V3BHw+/BvkLOVktW4issDw7PGNVA6XNfAJrY6dqYlPS1
	 f1H7ki7TE+RyZytpmGLM940K9luQBKd3GG9akTYjI5bINT8zqMVEj1HUYnhjUpxeL0
	 Zu5OmYRj78J25GDAJ7kqXNTPRMQOuHrBmvqupSIzlxIddiyZHPMhM/B4+aYpzOl+uA
	 fsTyohmHJScR9hwa+speHPZ8mcfRpjvZrKH3MaJ0FDXicIx4FLlCFcf7Q+1woIWuSj
	 J1/luw9llX7soCLieBWiZOztNhFKLf3mXyKS+oFi7SPvFVT7FH/By8yA4YkAoPYGqC
	 BWAKq/vDWBN3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 86D4C607CE;
	Thu, 17 Sep 2026 09:37:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F15F362
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 54F74607CE
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 580NhVz-8e6R for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 34E0560629
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789637849;
 b=QFE3RxbKmeyQwJpls8IgmNB4ULeEjgyV2fCa4jcVfaYEwDgioR4sLAQEk55ALhiK9fNE
 SiYu3iFt+Kt2dEIyaHhCpxp8t4u/OvOBicivpI/jGSfGVHVXXjJzkOwa1jN9Te5hlPnTJ
 w/HqQhxEXOBdQBCimU24iQzy3R8OqabN5llUJDuC6R8xYaPaC+WpIFCqLLiN+aQfTl/ZJ
 x688kas7EM2HLAnj7mbOCyFXI+XL/tkZUR84v9AKHvirontJihOPshII6Aj7zp2oRUMXc
 9MVw1P7RQetyVkIrWR4PT1YMI0wK6fyMJUaSF4VhWCkuWFS3B9KQ6rsfB30ZRjsXcAw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789637849;
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
 bh=0plsDxbH0d71S8QmJHo+SnyZ/hTG5HpW4XYfP8eYbWk=;
 b=n5Xt9poURoE9EfpbyeSe1UR7uM/btn4zcrLXDfY4ulamCSOCXN5b+0czAxYr4hqLXw9g
 K6Vh0oOg+0nXcTK5UNm6CA8YTsZp/jbh+7nXGwZPqlHqKgqj/KAkzNR+vCeX76n8Ar1D0
 cuv9azrnzb9awibnGUFl7WFzAw2B+LLENb5W1u6CNpTMFiExe5NtHU5dNgMzo+InI1O1W
 gSq9O6gD/r2XSv9K5A/QAHTB27Z7OWZrCRHVGg1KllYefNwt3hh6se3XZ7JnJSKogUam+
 942FfqaKiJwLcZWlos1YJJYD50AExvRPkB1Od8RE2Z+xG/4N4ELwE35R81b1RLTWC7w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b="PMPLG/u8"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=PMPLG/u8
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 34E0560629
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AkX+CmCxKY/hjfsJTN5u3EnUvA0M1gDDFoDl+ifTAUY97CZUOHu++EOyBKbpE8qDTtTKuFzg6T/5Ep32qIasHGlx4AyC7myBWjovNywLzSzdjpUyS68uZewTmfFYG8Z2hCl9Ohya2Qv509tE2ZheWI/BwYU7M1Cyoyxn0HvvTcc4KAHhGBOggeaw0UsVb9EUUXolZ60agFx9lFyYOfbeMLsu1KQuqnTKWqESMiGaYpa56n5zQuPxXCL7eKbXd9tUJhyxskEktrtY8GBe8WrmaC1v/RjfjU/VcSdDWb+h8aWv+bCLaE9EazmIOHlHZmifnAIhnwd2z2MRHd5T1iOrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0plsDxbH0d71S8QmJHo+SnyZ/hTG5HpW4XYfP8eYbWk=;
 b=Zlucr0meXLWafSPGfGB2IBpobw2t/mwfUpv7alI5Q511jBPbmsbbw+ljCWOAEg5QfwV31VZkC23b/OAMKQA7W7M0BawlJnS2wJ8zbBRzRAnx5wAlthCo4sndA6NzlKTmPPBqBODkXBen+UxW5LSGHJrHiDyoXzi16t/zZcnapCsFssrUENfNog9hGYlg8PyDkzi8dhNikCt0mMXa5SL5dERXK0RzreHkuG7Z8ERkXbFM5sIAm6hPe39JMGYSB2zhmsIUXmNtzvE7b3qJFcGmjmuSBESt75IMVAuuV7rCpY5mWRUW5O9zzGw2IcSYSN+v59MUG3uhIaa1MUXqqd/QRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0plsDxbH0d71S8QmJHo+SnyZ/hTG5HpW4XYfP8eYbWk=;
 b=PMPLG/u8Rt2L/86f8kJtpZoqbV323Eiui00hMJ3J7rJR6KRjSBOGhAZLqifCjJjuIYP36mXRtrwBP+dDZ/PGtL+cgKozDPaG6MxiE2vUSXZmi7BHQgHpk9Ch1X5EykvCSip5uR1iwsNDigHTD7ghB2oloObBU+uU7qtYi7EC26zM8ZcXpckYG2QIKYRNELYZFkTGGslIMuf/TjWfCIeWQ+IfqVKxJlTfqJ/ej9I2CJY5J2oxBrGpFdPpzw8uVxZK/CZ5KekbnTJIMK0in1l9yWwZvfRmutMnIKsx7lTfFHCi5D+lZuwOxGGm6YMYWO9pWpwgxgLxpIOS+gGB4j2rcA==
Received: from AS4P195CA0003.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::9)
 by VI1PR10MB8256.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 09:37:23 +0000
Received: from DB5PEPF00014B95.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::18) by AS4P195CA0003.outlook.office365.com
 (2603:10a6:20b:5e2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B95.mail.protection.outlook.com (10.167.8.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Thu, 17 Sep 2026 09:37:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:42:46 +0200
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:37:14 +0200
Message-ID: <0f2b58cb-3467-4f11-9621-5fda4e5d2d5e@foss.st.com>
Date: Thu, 17 Sep 2026 11:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: dts: Add bootph-all in ltdc node for
 stm32mp257f-dk-u-boot
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
References: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
 <20260904-upstream_fixes_for_v2026-10-v1-1-f8b96c35004d@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260904-upstream_fixes_for_v2026-10-v1-1-f8b96c35004d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.100]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B95:EE_|VI1PR10MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b66f995-71e7-47b4-b260-08df149f46b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|4143699003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: IbL1q19fhlljBygpOXXTPgSKJOw+q3xdpnvZMXJXdnmlqVcuaj18pcMjLNBbO/8ycWBvZdZfVRg048VIHiDzI8T+FZdQ8h9sMD0QE4+Yl7NRhrur34B1l8bTEIAZ9ic6ciEW2I75uNzFSQWKBv1mQKPCzdvEfxyKQjGlNhgpFN4HdGYSe6EaeeMDpW9sJeP25Xz5u1FDviVFZDmbowWde0OTyVRknLZPAu9gVKRjNPuJo451UgIAl1gkRzR5poRCSbK4d1lOmgh1psiUTY3HYIDihsX5OAkvf0anTGiEROmHH7gKkE6IXPgovLeV/yaZp+cbICIwiwvS5u7cm1fe01YktM+C3fOAGDuNYTUk0NtgBvDcn6Js+1tyRJoyQIt1b2tncABotVo5obx1IlZrErJCn/BaSwBjVHTRrBqUPwzyCF1uueSzkZj5FsKzihk/bHZkf/1o8uHxoQlBp/TQnDevcsCqcAVuOAeA9UyJhUF+cVCzM8f236C/kYWNA10ukiKyvQIyrFXpujWPzqcoprtll1Qzp06LUbV911nXxqlDNBgnbgvuzPQhttq4MYtUpmy9Ird2M60Uv+JgRIYxaJT06ayBsuCZXn73GLdV0FXA8lhWzWoYF9LsUOWXPf44DEqxFEV07m5IZzNRfOmsmdVGLXqTRWBMKb5sqFv877ueuj8n2edsRS3n+GecSeyziShjBxt40GxHsXS2elZb6Q==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(4143699003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xlu0RfQJgLch0zsIxar5Fw0HavGpU7gUeyr3bIs84LSwREuYrHJwJPxIe2or14ffx7FHdfb3Gl/AmNe+gmopwPam4B5Qp2o1xmbCNgUQ4/ndr5bOj+BI9G493VTHgYasM164afq5hlBKmYzqgspDaG5n0C2UUlCR0x3v2xr5e6WvyGl6CeO3Uuv1aIME4vFLmj41u3K8nKt2FzKsNju1WWbpvjJs7lRzrARS0XiCYkLT45HkQr48MgS8qPNEvNbznQD3VWgj+4IGsMPkZ92wmanuSEvx9Teahc8A4AEUr7HYKpjkTH45e80wyvSdx5xjdjYr8KT9y9oH7Xuz3Z7LEl02TKOEmPEQ3aHft3W8xJnRJjDImPtmjN/V6wXl8Mde+dUuKtICRO8RTHRagXeqxPo4Gb0rr7rgFYH49XLfQSnHkdiE520ln/Wr+LiCmnOp
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:37:22.7587 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b66f995-71e7-47b4-b260-08df149f46b8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B95.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8256
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi,

On 9/4/26 12:09, Patrice Chotard wrote:
> Add bootph-all property in ltdc node to fix the following issue:
>
> ...
> Video device 'display-controller@48010000' cannot allocate frame buffer memory - ensure the device is set up before relocation
> stm32_rifsc bus@42080000: display-controller@48010000 failed to bind on bus (-28)
> stm32_rifsc bus@42080000: Some child failed to bind (-28)
> initcall_run_r(): initcall initr_dm() failed
>
> Fixes: d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1] into dts/upstream")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/dts/stm32mp257f-dk-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
> index fe3fe9c5166..29039f6f860 100644
> --- a/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp257f-dk-u-boot.dtsi
> @@ -11,6 +11,10 @@
>   	};
>   };
>   
> +&ltdc {
> +	bootph-all;
> +};
> +
>   &usart2 {
>   	bootph-all;
>   };
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick



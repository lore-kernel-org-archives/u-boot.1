Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F1CCCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 09:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5B0281479;
	Fri, 16 Oct 2026 09:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUB1g-9h3ze5; Fri, 16 Oct 2026 09:13:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B6C0581467
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792142007;
	b=bTy1f/E+v4kKYWlFuWIt5zqxvNj2iivvAaOAMvfc89mIW2Dv/OvOCI0nfEX9Pp90tPve
	 YgSWsKQ5WFs51wVIvCNVpv8qkl+3i9BzELpGf7frs6MGLymGEx7GRjx83cfgwQeHHIl7B
	 g93LWqG3WyMFqExL6YlbIuR3aN2aqoqTqvSmnzTCD8ehdoEgB6P2Q3Mn7XtqjBm1w+IF7
	 Nkq+F0utsDfWvIw/70srUk/wZ7tY/2S6Kbigxu3WeSvVPbl4hBlMTOuYxVHWOVshbHWXX
	 I1E+rbrOTVtEvCqdN5qPzXJf4X5ci6n5Ruf12wGwhjvGx6huo6QocLdErtL1E/KcdmQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792142007;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:From:Subject:To:CC:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=WGo3y35O/CQHi5oYC5BUfeHFu1mvUsYDLgpoefNGz1o=;
	b=VLtsDijVWB9jVRtJZisASurdbH1p89bBj/ZBJ+vc46UEGjU3PHVvdv3UgPBtJKmDzGSi
	 tSYNMV2NeZiUyCW6dkB0AnwJBujKANnt9GkzrsmOoziHGnVt5bGblnO/3X5BPDJWqtUO7
	 JiERuwLlvhk8wh9M1R1my/YH09Eojvvwcg2YNU7RuIYMLGh6qWm9yyFZwbrP6zpxuQrPU
	 F1pmxFpA7ciFLYiiEuOxR7+FFMt6/CjD/5hr0UvYQ6vMTuZtuo37wDDmR4ZTunzKt0yue
	 ZXRPc3Vr30gMTDTYGCydOklnbs4q1R94gI02zAckDAmC0p1+gS6i49+oO7jOyiGVoGg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792142007;
	bh=WGo3y35O/CQHi5oYC5BUfeHFu1mvUsYDLgpoefNGz1o=;
	h=Date:From:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nRi/+YLFZFgD9GbfuPi8EkdB8AMgak98otpq4/j3YntlHb6yOkCdz8jmm/nMYisDN
	 cXUMMkUiGOEqt7zlns16hTALPxJ+xYCy6Pd1ZkHXsaToQeHzvAdC5wlsQcHMhI+jNF
	 +nkoBP0ihaFmq/6JosDfHQbh0ceoZ93Q4uQToE/s0cRG55fLAOzo3FapXOsrhzclVY
	 +RQy6oCLB0VWt/0lpjgNKydwAHNvxe9E2vfFOSji0y4EeYitQPt73JfHo8yQuQoPj7
	 M7mV4X+TZrqrc2iL+NnQ8V3L/kC/7/2utZ4tC3lSRi6TVKGWva3XQtwN1MkDT6R8au
	 XkFfS6ciZX+DQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6C0581467;
	Fri, 16 Oct 2026 09:13:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C12D5362
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:13:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A7F394022A
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:13:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eMybFeWe6tgu for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 09:13:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 01BB040100
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792142005;
 b=jxMjgk1Z7FucP85UwTD8oHd16PeamKWCKD24VB346lYwgCy3xGrPjgVxCFN6oTPjYvr/
 wakxy0ODanBNQloW4JJqiWY1FrL20jJCg7zjlLjMUQrH3MMHYALufAZLjqkj1xDE2skZ9
 5mXm8i23oPdL+vDQBS9ge2vwfFm35d8NY1UPhqvvQ3YI1+8oXmBivzctvIe8DIMhQUT7a
 3CCD0tl4VLJ30wQ3n0QzRt4URWqV24Z9ZTzWppvDimYWqrTOrtvYgjZ4SM6rG8iaJiXcL
 T3+AiYrhOuzGla6IL2dM10b6EcmY3XoggaOoepC74/fWkTRj/WlXdfHY+WEFD0SRDKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792142005;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:
 From:Subject:To:CC:Content-Type:Content-Transfer-Encoding:
 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=WGo3y35O/CQHi5oYC5BUfeHFu1mvUsYDLgpoefNGz1o=;
 b=jMpYWnQclPJVLWA55LH3w52yDrPr10uBuzkRJxh/6FvNSUx2vLQGEOJyo4U7IHDzPeu2
 J8QVVo3U74Cl80mXMBnAFwfJghr5pK80uCqj2Fdg8lvX7cTkRJcI4lPXCWXiR05Y9vMKf
 rhvt0wrjtvD5pFakgPZyztNfb2Dh1WesHyQitmSBHrNSZ798ceBuPjpWlNCyKqoVyn44I
 yLuVsdptOsAm3mAmDaK683Z0C+6rbpgV2QGGuutsya05QvDbxoKWcKSPozSat5aKkmnm4
 oDxin5J1gt8cWY56MKxDBfWPxFPzYA3SycpyEX7w9/qd26e+FW+mMQ6ETn5MLwuPgqA==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=foss.st.com;
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=LHwfyduC; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=LHwfyduC
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 01BB040100
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 09:13:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HLK/Frz/Jv9PGuz/C/hB78dwDQ4L6cHCVu4ITkpaXGaK3il31oauFeshYsEGFnZBQfGWkQY0Mn4NUvucS4A4R1QYELsXts+8jaAHysLejVJajCt2wr8flZWAyvbUgkFWdKDNFqUWKCM8G/lAYutBWE7dVzY6CRZEpm6V/3w+dcvAikscQY2fGih/Ax5CMEDR4G744ct5EIeCy0a7pfOFcgIvd3P8jpcFlKauXXJvx+HJ73/dkgBg8y2OQENCTR6Z7RhxmLex+FHPW/jjTj1VBcGBI1/c+7HEmCmxx0dxgVRvVNX+jo6H+5NRIEH5MosjPOXg9Fzq0HkUWkAHPcYQEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WGo3y35O/CQHi5oYC5BUfeHFu1mvUsYDLgpoefNGz1o=;
 b=rnnpgr9xYnic2iYrdiGWO17ak8KrcODB1KvQirOHiK+BUuGSQEkJcXBLv1SYlA5ZuZlEA6baAWvEgMQPHcQs75dDG0uvQUEnGkh1JykqVmbtXpESNitp5C+uz0fNbgOLcwuxN1aooJCbxe9LU/1Atkr3KgasQbfLvKsseFp6DNIThJXgrKEF8fOFvHZ9garQfT7jT957fjzE/ovmMQ/ds0EDp9KTZYyDw2p4cWt89MBk2b96WOv7u3DFFavDFq+Tg16ewyXbPpQiTxgIn5emuMuOWP/E3GFunPoDZ7O/rf9XScTGNpqBm63+Yhr4IuLWgUVAt/F8dZwnvE5tzJ2cWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WGo3y35O/CQHi5oYC5BUfeHFu1mvUsYDLgpoefNGz1o=;
 b=LHwfyduCVca/g2GOD1cRu/EWUM0lBqjEZNN3Q+wEgJ4wXTcezu/j+gIMwSTj8OfxCI5u8dDA/jIGlCAW9hnPSebcvIxbU7COXpWtG6fVGtz1Iyzfa/B2PUdnB4P+60AQunz8uJCSMREKOPpBJZk/Po+qT2qMC9a6+c9QG1B30Uexs2AJKye200hzYRIP6N2MJ65OucKRYjFUNaq95vgQ6i15se45JAjCsMfD77+cnVOV3uRJHipSi4NUrqeMNXCJ6IXSPDpSDXrEFk1Rk5KHMN1zlnrQW1NO4At0i8da3g/cYv9WpbHU22Hwa3W80ahl8uUIsQci/gWuf9cqh/iZ/Q==
Received: from GVZP280CA0039.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:26f::7)
 by DU6PR10MB440394.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:50d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:13:07 +0000
Received: from WA1PEPF000099D1.eurprd04.prod.outlook.com
 (2603:10a6:150:26f:cafe::46) by GVZP280CA0039.outlook.office365.com
 (2603:10a6:150:26f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:13:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099D1.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:13:06 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 16 Oct
 2026 11:13:21 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 16 Oct
 2026 11:13:05 +0200
Message-ID: <bafae7bb-0ef9-491e-b284-81631b175783@foss.st.com>
Date: Fri, 16 Oct 2026 11:13:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot main / v2027.01 = u-boot-stm32-20261016
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: Antonio Borneo <antonio.borneo@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>, Patrice Chotard <patrice.chotard@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099D1:EE_|DU6PR10MB440394:EE_
X-MS-Office365-Filtering-Correlation-Id: ce1e7aae-97bf-4c9c-65a1-08df2b65b087
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|34020700016|23010399003|376014|36860700016|1800799024|10067099003|18002099003|260925021911599003|260925022911599003|260925021311599003|13003099007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: F7NF4Nher2wtmgmvWtpZ4BAKuHMcWRYS5hbsXmNRWLBrfLr+Cdf08TJ9k/TIGxawAi5EwaGEyXj9ZlsbUXa3LfMI5f8PfKYT2cA5paY35d5y238xUoZJAuMAceOYLHCREZFyZ5IMElnHMqNwGBjKjFCgehRtx1s1NM+ztkuGevq1pbMhLv8J6HCje/6kTFY++KOIJdW6oAXZ9vFQ5PH+LetgokPHZgyjJUqyTnufC76EpTkyzTH6UKBD0cQ0PqtpUMPLJrVLsMdiTE26VA/KGPymXPV5qrcPFeKhW6bKI9mhT3pgUl2finE3angpn/ZbSabt6Big6IKPcFYcaRVdTmfPNGbnCbKDXr4g89NDE9yMIwm5PncwwFZQxwLRo2zoVxhGqcKTtRJqpKoAis/OwaIGp8nnsv8jIUMiHwPhuR1v5G68q42DyFN7OYHM8vGC0l2GqSDZk2vHevNHNccXb/Nkl3V5D/bakCvF4hQf++Erj3Tld11bpkaJgfy/aYbElSkJxK8+TR4h/yzI5EmiD1IvQhPrcWT3u3KOnPKonvIVCR6dDSq4BHYGJc3fPafRb8O/Ow8JL0r2xdjvESz24KdGuuW+cHXaQ+EBVB47A6FOijEAXBlCifk3PZikiZd90f1Yr2aSH3nkTtjb+ewHQw==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(34020700016)(23010399003)(376014)(36860700016)(1800799024)(10067099003)(18002099003)(260925021911599003)(260925022911599003)(260925021311599003)(13003099007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3phdbWh2FCfLkGla4HARnON7i8Vj8wSI05qQQxCnHx+ujU4mDlbiNzxVXPy5ciBiCvEaTvB7cWvQ2VH8EYkSpWUzFrEwviFExOHvu5hg8cRHnrSoTPak4haaQCrqlYsGNcYzOz61YZNr/pPHhsnFi2rFGMXrbZdH5X5Sm67be+CSVzO7a50R0V3CUvWhNu3CPMpXDrXxKBHJpfi9jt+nPrfFiv1vB/IvnwtHf+2T6qdIgdAE4oOQQYPFrYqbkC2HCdWfFOmDtFNG1WGzW+PIbo20AWRadYpgFfZqPoki5EbswMvb96C8aNxe1jtk7wSB24/nrQ2gMEifSTVr6oicLqVip2Tra0RK3g0kIKRq3MSB9ccCR4o6uIcGTeY9qPN49WY6sypXR/nrwD6vAYZGCeMunkI+PSa2CFaYhBg/rovFDEVd6U0weeygib55vFpU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:13:06.2158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce1e7aae-97bf-4c9c-65a1-08df2b65b087
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR10MB440394
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


Hi Tom

Please pull the STM32 related fixes for u-boot/main, v2027.01: u-boot-stm32_20261016

CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1600

Thanks

The following changes since commit 65a7532545336e4b73e049a69436e255da7df961:

  Merge tag 'mbedtls-2027-01-rc1-101426' of https://git.u-boot-project.org/u-boot/custodians/raymo200915/u-boot-mbedtls (2026-10-14 13:54:12 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20261016

for you to fetch changes up to 534370fcd4acf77caf31e634bfae319523a9e0b4:

  watchdog: stm32mp: fix watchdog status detection on STM32MP15 (2026-10-16 09:36:55 +0200)

----------------------------------------------------------------
 - Fix watchdog status detection on STM32MP15

----------------------------------------------------------------
Patrick Delaunay (1):
      watchdog: stm32mp: fix watchdog status detection on STM32MP15

 drivers/watchdog/stm32mp_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

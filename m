Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF9CCA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88E3460680;
	Fri,  9 Oct 2026 17:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MLrNvLgp4nLm; Fri,  9 Oct 2026 17:06:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D731C607B2
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565603;
	b=oonOeQfr8k2KEDBMFKTf10Ivhz0H6As5QsRDMCCsrqHd/2ElfkdWyslJGTyj++BSrjMN
	 eNRz+tC4wVJa3t2IWGA7HcJtJeY833bPQClAvauRvLUfRo7mhYq74Ps1fgb4TMPc2SjuS
	 jHnnna4SX05VWm/PeI1ZCcXYiYScWIcO3eZDSBhYVMvmYPszIqBZDfEtrCuwoHCgh8wgx
	 CYZDzE1T3CtJgdDOYurhCCRVMQC9/qJTrF5PLG87EJxG20Q4Xtbjinl+uzOxlZ+kZ3WZj
	 qtGF9AR52z8AMVrRx70gFLQLoHq2iPnL2VSaXdnCi6ul8gM9BscnYuPQ1Ud36GtBRvQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565603;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=QOSY3SoVZmTUeWiSvjUfVmEaMmSSadRZ3sceDMPkjJU=;
	b=QFHkoWNay3ZSFRSsDQFLcLzNuYAhxevEYJua7qXuiOsWUrNlr3nI/GbByqBOangjjoKt
	 4Ffn08A1nRlgre1Fp1aaG/+VN06BYgZMSjsi52+WNfkTVCsttFBSNgMqeu39fZBAS30r/
	 LJ8P9eaoVABcmbhmI2cvsjPgh8TJRNwK0nB6nKt882RR3+5tWdw12TjE7218HXvrphtVd
	 n/XaviXgMQMmEx4w//qRDlnf+Gnoh+riXTU3PTO5ZXntemCREgKRQs3m8hbO5SRORVYXp
	 03Ky/74w5XYPQv5VPuzLAjG0D3CCCDJNys6i3R8Yy1+dJUcxZE7mA2kNoZAxS+tb3hQ==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565603;
	bh=QOSY3SoVZmTUeWiSvjUfVmEaMmSSadRZ3sceDMPkjJU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0crNlOhr/KDZcpJNwZCiepRntAcX8Jh4ec5dfAuk5AT0DqpxflRE+NAqwnbvipmY5
	 y7yPN3N3TVQq0xr+jd8t7U+d6YRMjO06KbeeQAguczXhA4E1dsH5sEN0LzVfTMquHb
	 qVyWOpZmfviMlqcoxl7W6Ndu6e937Y2nkc3kJx4D9qGROf2Snz/zDjlN02/MtutHVP
	 NZ3yovCZjqk68yGNvSzcI63/CIkXBSPFy/mJ9NWtprNwtWbaWs3dx07THyvZ1y3SYU
	 +68qF1u2HG9YWD7T8Hrm1nyBmeZSBiTI86ZcAFmxlBMVeASt9ouub3/XRU48L6JClv
	 FDEyO8fome6Xw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D731C607B2;
	Fri,  9 Oct 2026 17:06:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1594B94E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0701D81412
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O774r3NRCpq7 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:06:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3794E812EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565600;
 b=ljfwWmDZuetHyFooTXp8mobKcs5ocODACpWvFuFNL1cviH+M7sq0g7FTLEjKxWix6v9o
 PPgt720L7qFLMOV2JeBrwQPQcIFfDBKTwTmvqc801P5Fw/1RIlzdirpu9q648Vxtpnn99
 yhq4wmjlwiL+nFMhMEv4IHcLNGk/U3v2xTJ12rq+RNQJDcW6xs8oQ0FvhpuvkAUDSdLTr
 89KlRI0Tp/Nr0z1IA34FzonS5x0zVBMgw6pkIo6sjg3sq66K1lgI622XFiPnWJLFvD8Rk
 j0VeV4hA+fQEu/fAjc2evNzVoQsdIusw6j/ZSSwnhZWVvByQ6VjW+wMSe50UasJugsg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565600;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 bh=QOSY3SoVZmTUeWiSvjUfVmEaMmSSadRZ3sceDMPkjJU=;
 b=WyovFBOw996+7LXpyoOpBZ4puUXAmhPCF88CHdrly1t+J6OWIZfISUrzJTLkCjZ3nLf1
 q5DLK8hXQ+DOy4LnDD10/6h0bmnu/BLW7rniecyk4gU1t2r0RTgSHnLlgE7Ri7Ui6xbbP
 sVLpX3/VEPCua315koJaasPowC4LJ7rD/bI83MiDnhdUsvNFIYIiXAhL+1mcANtmbgbPL
 y3HG/Id7oBZ6ryJ/A0nOi0ysNCZ6GGJUfDUVo7jz0+fA3b1+IRsShECK9GnNkrIDjSo4M
 XprJKPFZg6mQAi0Y0ykTkPvg/a/6uZ3n6fYDV0tZmeVE7/O+tMspYIluqUp8Sh7szVQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=VJWyjeFg; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=VJWyjeFg; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=VJWyjeFg; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=VJWyjeFg
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3794E812EE
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:06:39 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=O7tkHZpH0yPt/5odcjN5CMGyhYn+FCsVi8kbhTtYqN0Uv/1JI/LivRjwwu+6gmg855gBSwC5oMWAlSHGosnxPynccPCgjzgljiF9hTpOFBj9nQhLYFu4Gpa2CjFpA/VrsgeOQyjmITzlw2BNl3uN+IHD1xqszEC8LnTpFjzYwXP+gX2VLNg5yWyDhWSX5rFLFIvf1ZSqrBBnOyF77TuxRKu6jurq3DGale2yVOJfgfmvhBQIDuCM2B69HtU630qO9KKwaCptf/dsjyqDW7Gryj3ohSvhbhhE/9WpwjRNKS/sM5IRZOoL/bc1kZxsHOQX70s0NjF6dFJEwurLMpO43w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOSY3SoVZmTUeWiSvjUfVmEaMmSSadRZ3sceDMPkjJU=;
 b=bAY+RyFcGvrsomrvHSJQSQgJsLo9O3sJ0My8BFYnIcdehIKH9ZS+ujZhJImGmSfmH19NsIXU7QaKnVsqX+OTjS1eLPSxC0pvdx0BMNVJr7JDN2VFTtwovRPi11P1g53J4Qz67SOoO/qAW6XGbSCdjqa20A/aN03DsLL/gaoPss7UcWxvKvuJYn1MyitbwUS/tdD+JEUcF0S2zsa7wgw1/IDNGrsgdrFk7ocZLeIOx3X+n2zVsJ/5rA9MWcASSR5Yw5RhIMbx8N52+WvkPAFNxnIaOdeEVRVXpHkEcQw/sKhHmB+hqZ2A6dhuVVvPw5FEHlpowWpnx+WJVL453XvMaw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOSY3SoVZmTUeWiSvjUfVmEaMmSSadRZ3sceDMPkjJU=;
 b=VJWyjeFgzChbBbB4no+LGUefxEgwWnMXDWL7d6/L1FjiIuG0bHwl8K4F/ECfPo8FEAfMsAzvjCO0uyVvgY9afiMlceq7e82jyciqvRv64V7knpXD9MzZSDCvH7Qgmtn56+ES6fBKUtZDVVnLwJhTYFoB2bwVOdpMmLYl1FYwPzA=
Received: from GV3P280CA0076.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:a::35) by
 PAWPR08MB10091.eurprd08.prod.outlook.com (2603:10a6:102:366::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 17:06:30 +0000
Received: from WA1PEPF000099CE.eurprd04.prod.outlook.com
 (2603:10a6:150:a:cafe::34) by GV3P280CA0076.outlook.office365.com
 (2603:10a6:150:a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 17:06:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099CE.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:06:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+lrxE0QnwaF+fsQ8WOgYTPkE5iYydPmQBCQiruoCXlnzsYsm7pnDQXjf+I6yyiy2yL40qvIcFV4Fy2zP3fWDG8mS7w9Psvl3/mDGuxBqHz12U675ga7sjmMVm2xj8p6xbAJsIKtjNwEUcdxg4IHDZlhcTid4mXxnkdsQRAGk1nfJGdnVcnEKSXT8nNVlprUEmA4Mdq37ed5ALyDy636HSC19pDNHd6DBN5DEPmNgAOUy8TfrmaF0CeIMoAp+yUaBlswUMY881lZxPwGcz1OicFTtXKYrZQnLkT0/4HBAuU/cDR5NfZC+ULZyzV1/FGmK2EWLXvcWe1c+TVWYs8kqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOSY3SoVZmTUeWiSvjUfVmEaMmSSadRZ3sceDMPkjJU=;
 b=v2BzMqhNijIxdRVLOaWazopZMNlhthnlPox9PK244l5G5guoxEXbd9T9PrMeQiRq4a3LpKBOgnMzslRHLm+6eMkCcO0G5+enl6mOqhGS1RHvSbhbUHAp+U2FFLRz6jgjRjbXU+nWNLI8pVHJF0kzmgMO1zUufU+K9sqBFmNdDmByndDBEyh7fhzzv2DKxvM0LbtTF4XRUviB7Zm5rWuPuD73yxgacKJE71L8w6U6r1srzAIFoan7rVqI+ZhckLslOnwUcX8BbR6z1QS+H9X1MsZNuUck6I4UhFEJU9H+LVCq9jV2UKWJMTorMSeJ0PyROgZAkZx8GelKTVX9dU4TEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOSY3SoVZmTUeWiSvjUfVmEaMmSSadRZ3sceDMPkjJU=;
 b=VJWyjeFgzChbBbB4no+LGUefxEgwWnMXDWL7d6/L1FjiIuG0bHwl8K4F/ECfPo8FEAfMsAzvjCO0uyVvgY9afiMlceq7e82jyciqvRv64V7knpXD9MzZSDCvH7Qgmtn56+ES6fBKUtZDVVnLwJhTYFoB2bwVOdpMmLYl1FYwPzA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VE1PR08MB5822.eurprd08.prod.outlook.com
 (2603:10a6:800:1a7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:05:56 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:05:56 +0000
Message-ID: <c72e396f-7c4c-4f55-a413-a0653d21f8c3@arm.com>
Date: Fri, 9 Oct 2026 19:05:55 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 1/2] net: dwc_eth_qos: spacemit: add support for K3 SoC
To: u-boot@lists.u-boot-project.org, Yixun Lan <dlan@kernel.org>
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Peter Robinson <pbrobinson@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, David Lechner
 <dlechner@baylibre.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 fanyi zhang <fanyi.zhang@mediatek.com>, spacemit@lists.linux.dev,
 nd <nd@arm.com>
References: <20260924-02-k3-ethernet-support-v1-0-b8e1fafc9249@kernel.org>
 <20260924-02-k3-ethernet-support-v1-1-b8e1fafc9249@kernel.org>
Content-Language: en-US
In-Reply-To: <20260924-02-k3-ethernet-support-v1-1-b8e1fafc9249@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VE1PR08MB5822:EE_|WA1PEPF000099CE:EE_|PAWPR08MB10091:EE_
X-MS-Office365-Filtering-Correlation-Id: ef899f0d-24af-4f63-4cea-08df2627a8e5
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|18002099003|22082099003|10067099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: NbUlAju1WvscnimFC9sFOhOX+wZY4ehxmNFSFGr96iR3CWbs3r327kmchLLD02cbbz7IOlqZ8HsL0LoluhzJmgmcHcZlYvYA6UFz9X1Jr6TDMwORx7nnADM+6xj+/gehB1o0W/pfDqjjJV2lXkTco4zOHdg8XguHvDoC2JkAP4KuT0Eja0iGl6Wz3C/GZ5sD96k+BI2UgxwJqV+LItELZ4+6sSJvDBW+Vl1J5dd8gjVFwAWiyPE3xK2MTTGjgAhcoRwBmMwZF7Bgh9ngG94klxnwdjtWOWCx0Rg048oYnyo3Z0LfJ6OYVzUeDfGDPCI0WTM62c77H7tVTVZbYck2j1599SQ4UYGhq+OnasFzq0YiLdGkw29DzN4xTU7BIrnzWHm+44Nud8SLmZyKgoEKzBBkj7hKxzG/2AYp8s3SdK3Co+4fLN+pT2+kIyoXQuXlhCXg+wu9GA4TnfCWQ+ENW+iQ+vZLm91DEDLTMTP3MOZfNVNZV2omdJRMt5eOXd9Sy1QlfvC68pjHUsu67pMd7JR6WNtTrn6kjrC3U8K8tO3oOcmQ4RF0omk2jyXl09tCIZF4lTz8TnlwDN279LSW82rCEdrlJjVn4HZz53bzmrua6jB0xCf8/oX9R9xCqkn5+7V+Yg/WfinknSVqK08C1MG6Ovd2six71mpgxgZT+NA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Bs9ZYob/ZZA8vCeekKXB6EiO5cTXZ51hh9BEP/tRj8Fxxh/UqyOGCz6ikTmGWMpMuy+W2mk+Y9oqX4ysGFSguyPsNfHjU6jmS33YVHd6qbhfUkI2YP6neN3b17nohMlNjFEILSP4e4nkdEU4FIgEUTUnG5bQaK2ylDbzniYYLwCLPVFv4sT4oc763SmG/vdG/mjEeYa3oPQz2EHoY6PGRJPQNoWk93K+JTlwRmqcr0OEqYsOIZeTqD9SfA39MSmAZSl+G9Pr6D892tSNh8vvNoul+Trv3hi+MPybwZ6if5x3Zwqi6YQFKU//5LlSKNbehZru7LL47dUDNmTFEofS2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5822
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f45f900b-4b6a-4b2f-3058-08df26279571
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|14060799003|35042699022|23010399003|36860700016|1800799024|6133799003|10067099003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: RtmAbgHHQp1tDChm5Ew+OIhU5V2LmBUJ4jCNdv00Apks1ZgAsovI4JlovKNN6qjpftRacVvgS81NstDmJh2Etyu5NmCVFNltdeRFHjDodLOvIbg6ECTAPs03To4locXlbW7cOdlL1dSVILR/sKsrGJWmWfzLrq1trjPL/Q3UCM6INNrk7LLyD/I6BcH76Ao6tYVRT8CTq54VNnto32XjwxofcE9iWCGjJwI/oZAxJ6YlJeCcPGvxXiCsV1WAITNkdChGNofkuIRkxkD993m4B5wUsV/ZWXaE2twSW/25czNeNY1XOHPKYedisW5e/I0hq8NTi8Wc1ZQeyd2TOUFy+1iwiY7kROrw5IlqVmp/dyt1CycEK2EjejDUtILEa2GAStXEhyLgjApM1fidfZ1iTpV16A1E9rTLGZ9Y8YyLKFdL4Yrt8x30K7U7GMdiWmQrh+4bhWG1F10VUop7Obm+xOOZ2xqVJR3iGSPU96zuASULTa0C/pQwzQQ6m+YspL3hZX1tLa6KHboc2dl5phtM+NDP1py+QS2fkWrZmqousdlOOckxqFNrA/X1YsJmZlurLLlXhF5HeLGUSt8DmIiQAxR4h+GbgA5lrqEdlBF0Gy3wspycaDtPd4EUoeHj7wH4LhZpPauZZ2feeP/8fMYrr0g6GNsh+3lvy5YRpRhAb2ZUr8hRo3YUSlGd2LWN90KYjLZ1xPY2Y+wL46kvJHZ/jQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(14060799003)(35042699022)(23010399003)(36860700016)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ULrD4I1HWz95ORpHECqiuNDoCnLlNxiK92TNsYbLhSpyGb3RtZ0EUEauehjLGdGCf/nj3iGKTvcoNhB+EYlRuKILx8uIb+5aVnGi3owkSRZ02LXxsub73OII9eLwmcQ/20lvoQNnjCB8fAitiYzbe5GtpOo6PVhU+2qhgz3Fo3nTKfEreodWiwsSVnGMJwXwW9Y+YqbcQri3fBxu1mMLtPf2b0f6Nv1ZvrrVR2KLmMymlDqDtNzAw75wJJJJ8RC1PqkDGEuKLixxZAadEnxCxOfdSil9NRYX1+p7llSErGg95k0DzCRUde0WRBC03Eq+5krvpr6ic+x8Nz0NYw4RDitMLF+J7Gluw/7EuGFrWmN4Lo4M7WHEjv0mh7zi/DhWhq0zhWlaDh6dln9YqUNOMWCL/MgLkMGl0A8yqAdUGlp2oBWIKDs8z3cJFtAxybgZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:06:28.7286 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef899f0d-24af-4f63-4cea-08df2627a8e5
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099CE.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10091
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

On Thu, 24 Sep 2026 01:53:29 +0000, Yixun Lan wrote:
> The SpacemiT K3 integrates a Synopsys DWMAC 5.40a Ethernet controller.
> Add the platform glue for selecting the MII, RMII or RGMII interface,
> configuring the internal RGMII delay lines through the APMU, and
> managing the controller clocks and reset.
> 
> 

Applied to u-boot-net branch for-next, thanks!

[1/2] net: dwc_eth_qos: spacemit: add support for K3 SoC
      commit: 28ddd369e2f7199539cdefe22ce014c592b890bd

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>


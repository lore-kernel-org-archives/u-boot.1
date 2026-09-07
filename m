Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622B7C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 08:11:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22C2660653;
	Mon,  7 Sep 2026 08:11:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EZVXdXyvY-7k; Mon,  7 Sep 2026 08:11:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 5AB4660634
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788768718;
	b=Es8sDw39T1AsFBM6ML+yq8Ff7dHaXYB1V/a1Hvm6vHFLULRwupY53TvGan3rWTxW+Vh2
	 Wo5bgFgqRyX/Fi5lRi3iu0+3KuxSEo8uVuFY10eE/V9i0UroUShu+U8/LlaPkseLZV7JO
	 wStvLUym1EjIkZ8p+g6idO2I+2SlFamt4en8fF+7E6goxkI62iGvXlqJDareMfWA++3rf
	 xkM0Yfn+VoPkFm6rnkiY8uXCtdpbcaSlCRIaEJmsvgAWrH8oqec294PqX7PIUVkFROs/v
	 gWMIDvQf1qIraC9QOU25YBIm5vGDILvxWsJ9EqZXV91Ndl48ggaQ4jL8KyZvutONr0Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788768718;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y1Pt4NskI1xuv08NDITpAs4NEL7oddARuZVd+ui71U0=;
	b=BW/L7em/TZglFWU/K9mhPMV4S0mFRUv+sReWk71Lv6DOAAU6UTKAf5wGd4Uphlw8eYCQ
	 lVG9HOGm3IDeIhhp5qtChMWQxEB0rQILN31RyYe4EGffVUkkEcT+ZUjMjqHBgw5nTDEG/
	 Bb+ApaUXjXero+oxg3tv29K0e25j1U6Ncx0QINT8pyWjUd1IQzNiohK0Xta4jHRBR6Yjt
	 CbXPfsCCkYEfOT5mPvslaR1HNIr++Gert+2+UH1nikf3+ijK+EcbpegorPTiYuePCvxYM
	 fphxW03vz0HKZaRFdK/Gt86yZjs0cJ2rYtSZS6HZJcLYzDoJdna/+bqzXSvT+pPXF+Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788768718;
	bh=y1Pt4NskI1xuv08NDITpAs4NEL7oddARuZVd+ui71U0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DQJU6QjBD3mj9AhWSlUYxVIiLnCg74OVmUeSL+CQmx8I47d4gSeYVzLaaUYQpH6K1
	 Grt4I4b82AnMfIE9FXO9DEYZiKr1aJIzBnxzOuJpOWQlNDVkIetgkC86SdK36EK5yl
	 NrJ0iRO2EfMESokwdMXubFDczypFqQ9yCJgPzhyhoVEHtvLSrFX9GXZAt+f+bZbqaS
	 CBG1xv9BRDGE+jvZcSzZOzAYmf7fJ6kZafDYTpLDhAa5CUJOqAlEx4kBshzXOIAbPz
	 bYrwu/Q3A1qJAZgAATgyRsTsBr29rMyNgilTuKcgCMiGFTYAJRdgydZM29cRnlSyq8
	 pQDBsZ9+mu8tw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5AB4660634;
	Mon,  7 Sep 2026 08:11:58 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EC4E9AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:11:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D231540553
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:11:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OGkOEyBjorjl for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 08:11:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0247B40550
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788768716;
 b=hA2Mv80anqQadDViK8WFeThl7yOrhPDtHrm93olxartwpaaWTShZMdFmyeUsUT24DaWi
 Ya2Hd0moEqPpvxwKQcmlpkzOIzH3PHgdIVYbVu+vVCuusVIppGp/fvHA3RZVVid9bODjG
 sVdrRMgPSplz77VHYjlxs/GsYIWYCIcQeRPPl7KwVj8ldcJvlbPrnhpamjYfZq+pskTPt
 2dKFzuz+BI8jZ23USyLQhJ5EKh9zq3l3+LiUoE0u5WGgi5jlXKYQ0u5HtF2CFXIpd/SLY
 2f7kVfjBbRfZ8+d9gCzowTEIVi/zjRBLiDRNQPOyQ35XiU3i5dkZJv2xnG3KojUIRyQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788768716;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=y1Pt4NskI1xuv08NDITpAs4NEL7oddARuZVd+ui71U0=;
 b=oU0DtVSN6eIJN+iX6tVJb9bcw6t7eYKh1iBAyB9X4J07/swCCLkGveLxOc6gEQ+UgBZu
 sQnBSu2Yj6MJpGag2YgLCLYuK/z12h3h+zOFLF2k241trcW0cF1iVNRE0TaPd77w3IrWb
 LFwtQArooS6Tp/mMWU9QxQtloAazzmf48Yp1zSWiJQw+NnRNeNw/H3nfIIpWPsju/fvcq
 XWaV5k2YVlT+ey7nErWf4J77NFXsYUq9J+tpgSnLZZpnhURLgs7gNRZGT7Veu8SYyqAMK
 1i73xjQKo4ECfOcEcM6gf2X3IZDaAmUpbdhsJzhTu3C+wUOHbehd3VTxIMeOvJ6ITTw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mH0vTRjh; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=hELHkFE+; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=mH0vTRjh; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=hELHkFE+
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0247B40550
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 08:11:55 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 687766d22795816; Mon, 7 Sep 2026 03:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=y1Pt4NskI1xuv08NDITpAs4NEL7oddARuZVd+ui71
 U0=; b=mH0vTRjhd4vamxMYalA9jGwRUrHQHEAA1gmEYZGXR4NDiUdUVrpgrSFfV
 MNTFq3Hl0SIaZzqWmeiYLmDCVoS/egmgG/gW6VLTem8IRRrzHpTnMknNZmx18aFK
 MHRlkoz+uiYjVxGcrqbzt4fZTEeaBQsPCkwM64Q95TjkQ7zvmJGF9eWeRz1OrXf3
 vjBotATbbOlHswweUVFazz8gP3NP731dFOq3/em5OKqQN1kktYU8y8ElMZB2XcQw
 v6mlXlGa2bcW2pTILqvf5+hKFqwnk7e+ulEI46rN8dDUAY+AboUzp8wdXAfw/x8F
 TWXExfwotznYACDPbDExEcGA7xoYw==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010037.outbound.protection.outlook.com
 [40.93.198.37])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gh2f6crv9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 07 Sep 2026 03:11:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zLYLhTesTxHX9Is/Bj4DYmGKAstzqphAQVq/qAUDqQtQ/kOPZQe4vGqFcbQnvl5jTUPBCDCM1tSzwBYH6h3V7hin3wfheVxqyAndQEiWD3U16kvLr3lYu7xfd0UZEu7errr9kb3u3fLlUJ4BQReyLqSTx6FHk7gvZ2RjbsWD8Pog783ajWr8FFJt1esTDukz/m1643DKRTc0MD9+vuXTn9UPRlT+xv1N7vktyRxoGX7D0A3OT5b/0v2ymexduk50ZnThXpujGlmFQSdDSvx0U5m5DyQ9wvAVzf0MUBFRZC3VZQcsGx+t97UjvP5rj39IXQxwROr1obPRUrw1U9ijGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1Pt4NskI1xuv08NDITpAs4NEL7oddARuZVd+ui71U0=;
 b=tTsy34DA6eLp1jW2RUuoxJj3Cm7f/mLArjdX1IG9L41zRV6tQkOIOJuh2NWYH3pUTGtYM7x1jGfCk2sgSXsVEy97hUHqfjRs/Kh+8/7QW/kVi9JDSaA0jBImULkQqe6yU1ScjLvwms6e+U5EDGYJEhLAReYJ6g9DZ8egYCXWhaMIWoFKiTrTw0XuBI/h2ZT/+pp1pzkZQosQ5aGbwsJbht95vOg7tljrU6gQkzkoxb0rgNR/tkTwqWfdGB61hUic8BVgwzIspK6PyiCvrYJzy8BhxF90PhlTQ4P/Z+gRk6xHUuqU9exaffEM968qF0w9FQ/5rfKEkldC/o2ONjkImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1Pt4NskI1xuv08NDITpAs4NEL7oddARuZVd+ui71U0=;
 b=hELHkFE+TUS1XUyvia7XG8Ue1SOivZplk3WkshIVANZ8K1ic8uZcrCCZM6iWU+KLQAt7WU948liUHwWtiAKLGPOtXKXrcTB8ptLR8tIlH8kbSuk1na5DQUpfRrAkKz3gzo9X7vrdgu2ztNhApVEMc+Dj4qCitxWx+D/SASoZDlU=
Received: from CYZPR05CA0040.namprd05.prod.outlook.com (2603:10b6:930:a3::17)
 by DS4PR10MB603080.namprd10.prod.outlook.com (2603:10b6:8:53d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Mon, 7 Sep 2026
 08:11:49 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::3f) by CYZPR05CA0040.outlook.office365.com
 (2603:10b6:930:a3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Mon, 7
 Sep 2026 08:11:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Mon, 7 Sep 2026 08:11:47 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:11:09 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 7 Sep
 2026 03:11:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 7 Sep 2026 03:11:09 -0500
Received: from [172.24.21.163] (lt5cg60819vj.dhcp.ti.com [172.24.21.163])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6878B4qY133398;
 Mon, 7 Sep 2026 03:11:05 -0500
Message-ID: <020a2163-2492-4673-a0e2-026273bec8a9@ti.com>
Date: Mon, 7 Sep 2026 13:41:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/21] board: mach-k3: r5: common: Store wakeup reason
 on scratchpad memory
To: "Richard Genoud (TI)" <richard.genoud@bootlin.com>, Tom Rini
 <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>, "Andrew F .
 Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof
 <bb@ti.com>, Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>
CC: Markus Schneider-Pargmann <msp@baylibre.com>, Kendall Willis
 <k-willis@ti.com>, Abhash Kumar <a-kumar2@ti.com>, Thomas Richard
 <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 <u-boot@lists.u-boot-project.org>, <u-kumar1@ti.com>
References: <20260828135730.1565643-1-richard.genoud@bootlin.com>
 <20260828135730.1565643-11-richard.genoud@bootlin.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260828135730.1565643-11-richard.genoud@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|DS4PR10MB603080:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fd69b5-8a9f-4efe-4175-08df0cb7a9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|36860700016|82310400026|376014|10067099003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: ZaVbTZyIxO+TUhqRk5mUmZa5NqT8pmF7f7rkIi4QNSggTYfqC4XXVg55tqn8mZeq0JZbg0kFhyzZGjZ+6ur4m+lNNg66PdiaiAnaZRoh3fOssxmta9fShxs4uD3pxgCoPEIGws6KR74bQ6Q9SX2vyokQvso1ErzCtrQMEm+SwSUhMr6l7ErpQ3Gn2i8DpkCmQIFT1EWkQ/LRu+cUPG6gokLlwajaKZ/CVXwSQCQWlD+6KuFz2WOKn+u3eyFWosI2eFxcLXGxoOUHFq2InRThynyYY0zDvdqPqpywYP7hKNPcYiFPmcts7AqxMKQD/Q47Ieu9t8cN0CiTGziRkIhs8er4x1TEZX/TMMosnm6+HlCOHyI58IICbe9wIfAaUSE2ASg4WtaqMHYeV2A1md8HLwC86G6OBDFGgVDCNv6XI7DSubmh8E/lrQFzxP8SRS+qZ7FFOmr9+dcgqMhz4YVFCXRDnS1Vjsm3Fb/p4jWzWhwLz9+sosBM5LcHIbK28ZSszEmt7grWP1b0qumPnxtQm5gXbheJdWZWPybr5FBaTMAQdUfplGkIYTUaR/PpU+cxoE12/cPIiygRnLuIwo0du686yieral6+n7LFGeWGYwBj5BRBOtcpXVl8H3bGkSp+JFDAFsz0iMPsN57u5telk/sKX/peaFQuCxOm4sbC5kN71is3jVd6oqSronYt277lvlRcOzKYUjncEgdMnUvnOQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(36860700016)(82310400026)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AN4647Phv6vQwM/uQ1RzuTm2MK7YXTypGo+sev4AJ4GBhQnQDA4R3xCZZhNEoZFeSHFqCLEvM7DMD3NOkqmM7AEju/IRCaTAI+nOKYHxc/yrnVhlCsPAIsMXSoFXjRXYHmlYvQjBoy5O5UqIJVqY/hn67lGpADAwmP56e2nr1sUSvGpnGBcmrNjjEvnqHcI1nZKsGu99bg+xTIJmiUH86Quu+eshVjVFWyVw2ANj/S0Bzd/RFPnX4DV823Y6iCcSgXqfotfDt9yTT8jzGB2KSErs7/8eqAvc578I1GqE/sufb91cSEZP8u1yMA0ltrBblHbv0JDlFUZ9887N+Q3q6EAQdcjG4X3pEPLY8mwZsb3Kddv85NPUyCYys2zMCZDNztqyG3ighBdBcdHiMQ60Zz+P8d3zuKRMsl9j5Oy4vrKixjZBrh4JlZq8rGj4JIw2
X-Exchange-RoutingPolicyChecked: yQJAdhimbb/nls3+bDY7ekGaK8lM9nvOo/WlbCnmbwtnhIt85u/i6O/cndCsYGeq0xRzjZwe9yJT4DioyxYRd0PEY9O8k+Um1XCrFwspA+UE7Q0zN4JluqK/peCli+PwUq/DjtroPMPodlE9FLNvR1HvmNSAqlXLuMoXtr7MnaRyYfQOdOT7VEfJe922ILo3ZlHfuMg0HOYot5x2TPLLDdDabxoQGiYLoJFnhVKczG4DEfv4WYVtLbh6VC/NYhjrrtz+iud7ZCN5HN5WigC1vSNiRbavA1kCd6hXGFCKR3k704ncUvtrnTQyGq0gUM9LTkBAlsFwFvEThNhGChaq+w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 08:11:47.4112 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fd69b5-8a9f-4efe-4175-08df0cb7a9a9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB603080
X-Proofpoint-GUID: JjILgh4JT6o699BnOwurILOicZtdLy6u
X-Authority-Analysis: v=2.4 cv=Wqkb99fv c=1 sm=1 tr=0 ts=6a9e71c6 cx=c_pps
 a=HozCXiP24e1PxqS5ATOdRg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=P-IC7800AAAA:8
 a=RQiu4ma3W1PXrqZqs2IA:9 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: JjILgh4JT6o699BnOwurILOicZtdLy6u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4OCBTYWx0ZWRfX+CffIUqjvOFH
 mYwBwk+1a3rTPoy0QR63YTJyS7QrN0eIBV5rmN0RHEjGRztAHK6zVoilTkdLUdFcGP+gUm3YXr2
 i/zVAUJxhsmOGOgFggLMb4NNvMcZ38xVWyVf42IHvDqFRr7ldgJngh8ioyJh699xhIq1uKDcPTG
 2dGgZNAnHkgNvd98clD9LraFwBxVDNF7eMrUBgt9ID42X5C9gLEEmxky08Bdq6hBpHpODp1o7bu
 1dmKRRUeSVdX1Vh1WKgTcxt1YuNqSpiuuGjXLEaHCzYJTCFqGuOA6OheLn3YewVs1+QdzfhR401
 WRH8QRpurc4YGR1Moo2uhpVcCnr5PBiEjE7fGPD2vnofWY8wrgzVnRHAbN/8K42FzHKj+Vy9XQA
 /OGJ75VMPlCnuNBk8avg19rb6KZqermsSaUaMZX8mGp1l5N3pUixP6a+NAd/ZrBw3mkdPPkwRcT
 i85hRdzqgVxRqy3ukDw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4OCBTYWx0ZWRfX0ka1z9nODhqK
 B/tpx0SQ1POBm7FNMqaHWu2WbltHzdmlc0Xt6OjB+xVsboKpn2asfZFkV94xYCRf3HqtWhDN4Qi
 2krtzovNeM5T6Enr4tkgyaFo8PLSeMU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070088
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



On 8/28/2026 7:27 PM, Richard Genoud (TI) wrote:
> From: Abhash Kumar Jha <a-kumar2@ti.com>
> 
> While resuming from suspend, the wakeup reason need to be stored
> and this will be used by the Linux kernel once its up.
> 
> Use the 32 bytes of MCU_PSRAM0_RAM area (addr = 0x40280000) to
> store the wakeup reason.
> 
> Read the value as soon as it starts and store it internally.
> 
> Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
> Co-developed-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
> ---
>  arch/arm/mach-k3/Kconfig         | 10 ++++++++++
>  arch/arm/mach-k3/r5/lpm-common.c | 24 ++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
> 
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index a32ed3a9683f..bbb62fa617fc 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -101,6 +101,16 @@ config SYS_K3_BOOT_CORE_ID
>  	int
>  	default 16
>  
> +config SYS_K3_SCRATCH_LPM_ADDR
> +	hex
> +	default 0x40280000 if SOC_K3_J721E || SOC_K3_J7200 || SOC_K3_J784S4
> +	default 0x0

J721E does not support LPM, please correct through series

> +	help
> +	  Address where the wake-up reason is stored at resume (32 bits).
> +	  It will be read by the Linux kernel once its up.
> +	  On J7200/J784s4 the MCU_PSRAM0_RAM is used by default.
>[..]

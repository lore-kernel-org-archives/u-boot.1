Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ECB3CA9EC5
	for <u-boot@archiver.kernel.org>; Mon, 12 Oct 2026 23:48:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA46060720;
	Mon, 12 Oct 2026 23:48:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Cg6W1qrRGppm; Mon, 12 Oct 2026 23:48:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11E2D606F0
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791848894;
	b=V2kU5nWg7gFD0KV72nPb3muv7v8jm5AmgJO5Xf42d2qv6r4+iJKBmYKbisdMZ3phjprO
	 vSZbgzJ2aRdTaPpekqx7GxO6xr//pfxkvQ4HErqaeeKWNvuMBr/2d+3zDZKUG1JL8TjUU
	 TIM/BvM38Mm8qCllvUmJe0uOoNidBXRH8tKEAJEg9RFxBx7t/Mb7VCPOEs4DpnXTzga6m
	 Beaecjx+qGyKFJgbVsX+qdo0Q6wFNiu++0z1X0UEayJDB7gktzKZILjxd6+dXsYxFEZix
	 EkNY/ey2BYX8p9Ipm37bC1FDypFcgWpc2A+aSuL7jv5d9NlsOIWCg+dg8X+lvrMiqCA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791848894;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 CC:X-Mailer:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fh2kzJRLFKdAybSEH0Hm485VX4YtbPmS0XGkfrktdew=;
	b=WIDMUbaM/X5SizcV+r5Hb2nfkc1eNAiCBHTUXzwCzt7sMtrwqejzXx7cIKI4jrdMvJQf
	 c5WWJIf0QgpcBpd8/8hBbO3+lbuHUMXZa4JdFcyZNmHrfVAig8/w2QlYaf1KFR4XKP2MD
	 aHzC5zLeoePAVUpkmd/PYeu8wVS3zcQOgDYvKF8oX9aD3uZMVY42U4twac+K9c1qj7m2x
	 37CuohzHCvhwKFofC6CB7vTX2lLsoLPiyihVukQu6MFLW0FLdwiqB6nRbsQBOIzOYLAs7
	 8PoZyaxHK5w+gDSCHl+k1M3e1uc2iXrsy+Pqe3jVvztWqJ/lIII9RjP5WRw1Q3GsH+g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791848894;
	bh=Fh2kzJRLFKdAybSEH0Hm485VX4YtbPmS0XGkfrktdew=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j6SpqYZX6kD6VPyOkrNFl9KYN/VBH9ue4zRAgk1Uc8E66eQK49d4Oy0W9o6t9IbQ5
	 jEQjIqBKF9ri5j4Iyrm5AjK3hx5bJmb971rC3+4LpzUa/iOUN8UFgauOraMXmngp8w
	 qxSgfYxDRyY+HTBaznOE2Lx1hge4lIN8jjozmyus8Fx0XNE0k49gw7ly5bCgQLIYBx
	 154mnD3a7qYRVhrtGdZp25A2fFYCJHmIyoQ26H1tuvxLve48DrRH+RTqogcv3EHYCr
	 l679QJGMj7gQVQey+kzWtb094EsRg5TcpPLXXbB4EjeqiVB2P+jF1n3NlNJTEU8PsQ
	 g1GKjwn/PzXOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 11E2D606F0;
	Mon, 12 Oct 2026 23:48:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2CB71E9
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:48:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A90F340411
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:48:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5VlKL6Ey6ppa for <u-boot@lists.u-boot-project.org>;
 Mon, 12 Oct 2026 23:48:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7058B403C5
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791848892;
 b=JqyWuwjPVkRuQfj+kQ4e1ZcBfDJoantrXRllGrJHFTK/gW3qOKAAw79NIPdkPZmWlZdR
 zcifDJopS69ZS8oen7FlqQ7LbMOkLEAo7gY7GddSDeT90lZDgD8Rz9uzImCjPiJ6Wo0uz
 yRHJMGcu1uCxLmOHhI/Ryy6l9mc76qneHRHKks09mr7iCY2WoGzqy/QhTy2Zk/IKafF95
 eAiHgH+bTwNSWOPkhagyhZ06DQLs3qVXT9wnXMomiCRMG9sz+jgw+7O0ROcLC+V3GTUid
 QFx+p7fbCvTIX9USd9WYFmZgfoh1r59y7cqRthoRPRtldxPodGioVXQegyOdcUaX3JA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791848892;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:Subject:Date:
 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
 X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:X-EOPAttributedMessage:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=Fh2kzJRLFKdAybSEH0Hm485VX4YtbPmS0XGkfrktdew=;
 b=Qb8x9x9+S7qrPTpvrkHKAuYixSt/pqEaim6/vFycpwSVQnJz1SHOtUOpB77KsFk6HC6E
 8oXmXWo4xsdKiuu+ypsRLpd8U0wa5SRCpriCIbEv+rumWh+waXTdvZk7JsROfo5KoGST3
 Kaby0dYfplgPoDfxGkqk+oguIqTfL43OESFX4YC5dn9+g0o2uJFjpda/7yarYFDir9eIo
 NcJawa9nM4XDU7ze5apx4yKK2N+ovcjnRPCLr9OibzIRRibmZ5mimb3kqOx/g0jXj4HNr
 XL5XaV7C/gz7te1CGyhUSFkJFke06QjMK7l1G7H/qX2xliOOGF6Iko5mcMGACtFJf8A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=bQO1EiCx; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=VCWvyqeX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=bQO1EiCx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=VCWvyqeX
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7058B403C5
 for <u-boot@lists.u-boot-project.org>; Mon, 12 Oct 2026 23:48:10 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69CKKMNP2420369;
 Mon, 12 Oct 2026 18:48:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=Fh2kzJRLFKdAy
 bSEH0Hm485VX4YtbPmS0XGkfrktdew=; b=bQO1EiCxWhhXRmIxbatwj6IfPFjFR
 RDHkC1ABJ8i63p5UlXgWue8hxGRg2abMp4LfOM1clxzw+SBXiIiGdwNpVmOSkGve
 YO/PBP9sf63uRtN22KYWW0Ui8iEVE/w5Kp8r3mbvW0fYlCthcbflpsubyMoJwj9c
 naE+eyC56egI+YyzwICKbPccc+BAX2NFnv2vImCOl58dseEtHtjuBkUrdX8NFZEX
 MDsijJoo2Z4zS6R9JFw7XsfFSNlPclLU2Qen5XOThwlQN8Jnz8eXLIHYSj+TW8Pp
 t7+uvY+Cc7Ynxifw9lrugJz61iav8dVFPg9w4qa5pNhGv2H91pMThL1cg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012015.outbound.protection.outlook.com
 [40.107.200.15])
 by m0384305.ppops.net (PPS) with ESMTPS id 4h87an9m5s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 12 Oct 2026 18:48:08 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gvxFc8B5eUw4uWE0pnh8uAp4HQYGDGebhcJgX72YEh8pUtfF1PU/2HdHAn5ncraJZ7hcFNBiwGfVjF2ri8P3G88mKBZg5q9hat6/188K287RohHkKSNb9AWNj0ma2Y9Iw/an3OjnlOyUv24Stuto6phzKV+NuPc1f0YgTe/fBin2nG7ZoyrdI/ZiQSBI7HCAFGcaqSFRRzq7VbvinnTILJ37fQRArEyEiNnv64lum+f5se1IKdQ6/4bN7BwKsyu8EqLlAwx1O4OIDSLcK33DOC6EW/xdZFIrUH3B/Uc4BsiW515/p92assYSGnKMrLnZd9a9BfHUKOfo3qN6DJNr2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fh2kzJRLFKdAybSEH0Hm485VX4YtbPmS0XGkfrktdew=;
 b=Jbny0dTMpGyrKaPZ7lITXBPK+yqMSpu2jsEvp5MtNTIkm7mahIZqr8Rejovj3HmNHOpan1w6Rd20fPKm7Pe99khlqduE4s+w/gJtgeL+gvQCTJXr4oRSIQGZwFcsu7USAYFgv99Qibku3VSmXCqFT1+ppXGaDtINzPeCEmXnzy5ghKZV38iWJOf1npuhCabvgHaNWI/3OfdvkVA6FFToTmnNzD9LhrgWPaezb0LVFMnTjSvt+3dsOulHROLI5EOfAz4R4m8iRYwP3YHw9imxMbausHKTxrx3n+SpDRUcxDFaXaCIPW+PM3Ite8D8HPrjuQLqFIhUVX3HNNxh27diEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fh2kzJRLFKdAybSEH0Hm485VX4YtbPmS0XGkfrktdew=;
 b=VCWvyqeXzvqmUGWvJ9RWII/7bvWGUpniyrao21iiNpoSaL/NPIBRr1axyt8dV2Oihd9hE7GOneEQoZmTUWZwjwEXHpHfedTlGH2HIlZaPse47YP1DD3hCmTR//1d2XaLkj9aZVVSjV0Zg6VSftt9ybSL2Fdt2ZtQTbMKoPxMIn4=
Received: from BN0PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:ee::20)
 by CH4PR10MB8003.namprd10.prod.outlook.com (2603:10b6:610:240::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.11; Mon, 12 Oct
 2026 23:48:05 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:408:ee:cafe::60) by BN0PR04CA0015.outlook.office365.com
 (2603:10b6:408:ee::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 23:48:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 23:48:03 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 12 Oct
 2026 18:47:12 -0500
Received: from DFLE209.ent.ti.com (10.64.6.67) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 12 Oct
 2026 18:47:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 12 Oct 2026 18:47:12 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.75.137])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69CNlCaD2388641;
 Mon, 12 Oct 2026 18:47:12 -0500
From: Bryan Brattlof <bb@ti.com>
Subject: [PATCH 0/2] arm: mach-k3: intoduce system dt fixups
Date: Mon, 12 Oct 2026 18:47:02 -0500
Message-ID: <20261012-cutdowns-v1-0-ce9e745eb857@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHZxzWoC/yXMywqAIBCF4VeJWSeoYVCvEi3KxpoWFk43kN49q
 +UH/zkRGAMhQ51FCHgQ0+ITVJ6BnTo/oqAhGbTUpZJSCbtvw3J6FsoZV+miNJU2kPI1oKPru2r
 a37z3M9rt3cN9P6/WWJ5sAAAA
X-Change-ID: 20261001-cutdowns-1f5f92365925
To: <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.15.2
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CH4PR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eefff81-4736-4025-7c56-08df28bb41dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|6133799003|10067099003|18002099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: dMgeE7MQrM8QqFSLMBdmwAHdcjKz1pK/8eoEOeQ0SXziIpyucUHn3o7EBDSXQAOXXfQgXmcSWyWnnKlv2g2EkeFlX+rTg8XokaD+wf2HWr/8VVIIHe4PID1QVTwG+yR17w/kRr/hngjEp1HO6mYLvYRxx2aifiWnDar+8a6WV/YqUbG50tdGdchVidkbf9HUhcCwOzuv9vlmQZAnrTlxdfZaTpQ5NPla9AvtsysKfWBqx3ZUwOHqQFEEKB1YbR4/1ipbW/jnEMzZV/UQLj2G5P8MDiO4bBG4GrTEtoWWG4raZGzcaQAUGKfykltCvPCVDDs4Tx4fxSdoLtmMY23C4PR/gbkPhvyr+4IZzbFszdlWR+avVuC7lHYg/XRq3tdUIQQRioFoSjtQ1YeLDfDxcLown9Uh8L2pymg9Pg57QrLhlSjUrSEA3qgp4QHP/SLg+P/lvaOIJVH7i5W45H8qUwfTy0vYlISjWlraURdYB9MiVlzi5HfTNx0MFN01oBLxNpUjXaggiJDVfjxjshLRqc+uhJLv/Htla39WCG2QkSY1sbcHamgRn4ESxiJnSnIFFvBjsK83aEbSmBOvdw6vmP0esrnv/keqqdWfD2byucgwTAoyP6ZlF2QpOlxvh+wmaFqK0x7eY/P0U99X9nkW0lB5cuqzE0tTGRLhbVZeYrmffx8LYRwTlw12qseR/fgx5lRzzHoPbYPSBXOjDCIGgg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s5I/WNkQjp5Ls8ygRNPuToUg5FptzytU+2Qe+dp2D51r6gEoybbufQgv7qA9sI3b8QGgy6xAVGxm7iUbdADTggiQ7QShV50kim+6SN472EVV91bC/NglnJOYRhc2ylOldEoLbn1NaIJB6QlYCWE0y8+64YhNq7VYKfAU/B1Bu2f9RfhCegR1r04kiI4RCCFt2JHJJH1ufl3/o8yfc+au4IqRJdRYWsgUotIaxcDQLzD4o84WD4R69GlJ498zlofL8ZFF9Qg32eD5Re1tg3IdQ+8HAvhsF40loBSTdJRsNeyZr5syFd90slw0fitf9jxYWEQgN/jJWoI300+AiIzCmQFjT6pZHJK8c/TRrvvWbNyzhgHbb6P0AxPF4vxsPhOOnYQkxAENZrbQoKR1/cj6zWxpaplFMK/6DNFszrxDGbpCt+/3M6xqTSptvmWZ7ZZG
X-Exchange-RoutingPolicyChecked: VGeKIwH88JfU3QQ+XNVkVKl6RIqEpVaZKEPydgt6Unp3ag9lacRuxIPjCW4uYd8y/zh5YEQSFvB0I4Wfyt/4gFWe/R4QeYGnBZJIjMEID8sIoc7AtrWvGs1p9C+2jLLsgtatCmK2sMUR/Xn3VkV8zPcKZdjIWUaauCsUmoXIXvGokCUUc+jv3QM2eQHh29vW9coP1emeJxTf4wClqJyrpE4WinGxECxFJUMGkmVyMmACmkHxUJxLwmu+LnbE9UX4n6aI/zTa5QikcK/l2p8yzira1Ib26qeH4TJKApeen2Qnk6TWYILyuS/f07PoK0hBXgGrTDnDq2Oj3/QpjQmzXQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 23:48:03.7736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eefff81-4736-4025-7c56-08df28bb41dc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8003
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA5NCBTYWx0ZWRfXwJzDh4OF3Shi
 Py1D93uJfCzZn7o7kHoc1EZL7+tXU59LHUrdhVzv3IpmmsSodkr7e3zqxC4jcUfas+3F8bWG3mz
 8q2EEG2G49zUlER4aLAJetwGXovTy6Y=
X-Authority-Analysis: v=2.4 cv=bPWDs/+Z c=1 sm=1 tr=0 ts=6acd71b8 cx=c_pps
 a=CD2IJdD5qp8L8UJuiUkm2w==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=0flfmn3syPU-ntEoRIQA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fQjKr0UsPUMWU0pC49mIM5pucLmumMlz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA5NCBTYWx0ZWRfX4A7Fy/SwAj33
 3gjLpjK+8ofJYz1q/IP+ci6yMquM3jmkRB7wdnbMZiuyOfd6OSQql+yZb7uU8jHdixQmCMOmMUl
 fqKjTZxkR1f8zH/ZcwViisJcm27gsNGBKpPQI5NjJP+10uXC4RRmab7CwcNKE3N8i6rAqbbzuQC
 9FHW46vWHW4x+HWZJSMOin4k3SheCF93oJMgne6Y3cAK6q5erOT9pD6roKJnOELpRwFOhcVKhcv
 l89ENFF90qBU1ek3mSAXezT61tjJf6QA8wjOxpEGlpnO3Jk82TODdaXonLws+SK+j6FRpaeuQ5b
 pxaezAbRN2yGwxxJO5bA2q2mL7WXtCEEOk4IDNgW9lMpEM5/AhQp0uUTM8NKHwH5bhmyYn3SY/w
 gw+o/P5l5wv4EZUpF72EjAkxLms6Bta97Q/JYHdXqj8b5y0is0JOe1M7URypRzmH8rVVWwo/dVR
 LN9y5iety0tmtYClKUQ==
X-Proofpoint-ORIG-GUID: fQjKr0UsPUMWU0pC49mIM5pucLmumMlz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120094
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

Hello Everyone,

The AM6* family of processors come in a number of flavors (62, 62A, 62P) 
to fit effecently in a varaty of markets. Inside these processor 
families there can be a number of configurations like number CPU and DSP 
core counts to fit even closer to the power or cost their usecase needs.

To avoid the explotion of the number DTs for the different combinations 
of processor flavors and configurations needed in Linux, use 
OF_SYSTEM_SETUP to remove nodes in DT which are missing from the 
processor's configuration.

Happy Hacking
~Bryan

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Bryan Brattlof (2):
      arm: mach-k3: am62a: remove dt nodes not backed by hardware
      arm: mach-k3: am64: remove dt nodes not backed by hardware

 arch/arm/mach-k3/am62ax/am62a7_fdt.c           | 23 ++++++++++++++++
 arch/arm/mach-k3/am64x/Kconfig                 |  1 +
 arch/arm/mach-k3/am64x/Makefile                |  1 +
 arch/arm/mach-k3/am64x/am642_fdt.c             | 36 ++++++++++++++++++++++++++
 arch/arm/mach-k3/include/mach/am62a_hardware.h | 10 +++++++
 arch/arm/mach-k3/include/mach/am64_hardware.h  |  9 +++++++
 6 files changed, 80 insertions(+)
---
base-commit: fed92546960a92177d67c0b8d7b22385f50fed29
change-id: 20261001-cutdowns-1f5f92365925

Best regards,
--  
Bryan Brattlof <bb@ti.com>


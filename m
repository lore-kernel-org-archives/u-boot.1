Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3B1CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 09:33:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B3CB60818;
	Wed, 14 Oct 2026 09:33:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fs_3LQrV62rG; Wed, 14 Oct 2026 09:33:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4989B607ED
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791970426;
	b=afjBfZNcXSEShPfs99gL/XTdLux/A8HQ1DQtAYDiNa+r0312EWsiICtI29iRsv9JNfRP
	 be3hYPl9zbFxnKrffLsHfTiR7ybWquz/n9PTIZnNDxf5ks112NzlBbuksen+17QCzhmed
	 DFsh0Xzn82nnEVvxwH+icetk/M5Y8GOedtFggtzp+PQS3vixF5IgQQ8jKlboLuUFBoOy6
	 K5f5vvh2cpiiHgH10O2Nx1EOqXpoCs5y60c/xKhUFnzPTtLVwBrQcZiomDRkoZ66qhfoE
	 FRg0TZXoLCS0mBwrpWTYLhFblzCyIykK/mY75u7seO8lGnxDdiQGiqTCr+hMvlnZTaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791970426;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To:
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
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=djOz298cx05WIB1k9gvlGiZlhoKLrrMYGw7TVdRXem4=;
	b=LgHVg3zHc1gkavcGgJJ8Yq41dT/luC24jNb2Jr7Ef8D/4zbnSjCXbXLeRvttYy43T/K6
	 DfEKrsIQ/ocjYPnIUFtVNizetGfE0AGgZjKijrFcRjfo5tXX4rOpdg4nZCXYEhMcY+9sC
	 9Nt7X6XosRK8JszHJT+DbXZA3tFeIyb4DFcql3eq5Qvw95AeV0wq/Zn2xb/K6cZxvD7le
	 yJVKiIzzoMMnBF+8u/G2gIzC7h0oRAlb3jcD1p3IqPt71jHRgtr8mr1OxMbSvK/zIvoKl
	 A0f4f40UHrjNjENC1SI0nsC0WPAs53fiETY6ZgbpYOprDyzfqOORm2W0gcZHIjSKwTw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=toradex.com;
	dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256 header.s=toradex-com header.b=HDrujD2z;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791970426;
	bh=djOz298cx05WIB1k9gvlGiZlhoKLrrMYGw7TVdRXem4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fJQSC9x1AbgDuUDGVW+YhZ3Gop9HE8ktUmJo1zHMXl8UdLaArtlAhWLt+V5LbDQzo
	 14UxgOT/+QlHaWwfIc/OHTAswMf9y9bcZUtbN5IgNNQmSW/MDsbi2FQXQXBV4+giqK
	 /rJTDkUm9AJmaq2sXf0IcoevrfCHeNqUSVeuzKlOUbPhe7mc9U1qo4cqlYU26oEIPi
	 YiWqpzHV3QKeS1wloKhI3dB93r1+rJ3fTjOUY55n0X4pDyBlQPvXJ8tELlAVS0UVZ7
	 4T49YYpvoPi4smt7OqGcu1b97PaprO+bE5bf4DWqN/cGPRMkoFFBDw33slT8rEm1BO
	 oHbyzxHwTZQrA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4989B607ED;
	Wed, 14 Oct 2026 09:33:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 431622AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28A7C607ED
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:33:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kq5oHJ6vaGpK for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 09:33:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E7B49607C2
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=194.104.111.113
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791970424;
 b=iVVkUn3upNmXNXb58An7AocMXTbJBMPhsfTrkEnReTHakuKnjfd2WOAyWgc6XpiACEsi
 QvvftDdpg6/1OD812OPQ+nCOCAbJU2UR+XDnDGW2ooFtB3LFPN3eLPmVJkvxhqGvmdeE+
 inAgz8d1zM2ytcudeahbWQkqxlKIDyiH2QMOnU0GGQvHE1pWPzVZ8nbM8jeBN1XxBe0CI
 VjiKbrmS4w3v13/Ont5v9q2kQZlqveOGjeolXQsFe8KG9SXQuElNc2CRPw4Nn9EOxZ2h7
 A8p5NU+3F0lqWh+q9tX11RL+pUs97WzaPkOk2d07leQdi1vgP2FOJupZpXUaBXFwhgw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791970424;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
 Message-ID:References:In-Reply-To:X-ClientProxiedBy:MIME-Version:
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
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Type:Content-Disposition:Content-Transfer-Encoding;
 bh=djOz298cx05WIB1k9gvlGiZlhoKLrrMYGw7TVdRXem4=;
 b=FBkwZTHNjeSSOTcn4Em3rY0yuAQf4TvEwTgBmVwTo8uMbfpTlcX+g6VyssxN2/qrE6oQ
 Mr2AwfYCNo8Vgnr3tF0ahV5ORiu//GMZQIFd048Kul7Gl+9+YqIrrtbkdJ8/LS+gdw4QQ
 SGZf22407p1RZEYVZ5Jy/wj2JcX+NpNvbZW56eyeZf6F4d6nXPje8TPDmYa+k8sqOcwCi
 FIni8kYwAaSIxIS2S5o742i/ttD16spLXkbIMnY/xOijLKt5PjkYP16YzfoGc0xMhWQTy
 YNyTeOPuezjltvtUImvwJ76HxDs4UjH4IsPhHL6UE3igfAgK82vGMHlMPfJ+YUuT0dA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=toradex.com;
 dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=HDrujD2z; 
 arc=none smtp.remote-ip=194.104.111.113
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.111.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=HDrujD2z
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 by smtp3.osuosl.org (Postfix) with ESMTP id E7B49607C2
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 09:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1791970420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=djOz298cx05WIB1k9gvlGiZlhoKLrrMYGw7TVdRXem4=;
 b=HDrujD2zaH9f9A5TyUWUcN6ytd7tRudHNIZZ1GIjxWbL9e+UsYLqClCI3DI7PX81FVkWPL
 wMjaxnjhIMYlVYQStHA+iDMMVyBeiwkdvSWWl3pHonPuRXX/e7W3Y3wAJlwaGA2Cwa2ANt
 hzOqghb00qdMhp15dJf9l8Fdtoy2qS8=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11020073.outbound.protection.outlook.com
 [52.101.186.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-90-sV0jhz62NxKoocCegzQ83A-1; Wed, 14 Oct 2026 09:33:38 +0000
X-MC-Unique: sV0jhz62NxKoocCegzQ83A-1
X-Mimecast-MFC-AGG-ID: sV0jhz62NxKoocCegzQ83A_1791970417
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 GV0P278MB0949.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:54::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 09:33:32 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 09:33:32 +0000
Date: Wed, 14 Oct 2026 11:33:29 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] lmb: enable LMB_LIMIT_DMA_BELOW_RAM_TOP for ARCH_IMX8M
Message-ID: <as9MaWwEpGTAEFzj@francesco-nb>
References: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
In-Reply-To: <6hnbarafo7qy56l23qwzcbzfm7v5liabgpnd6t5i5sbinmxqhs@6aggwhpwx5cy>
X-ClientProxiedBy: MR1P264CA0117.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::10) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|GV0P278MB0949:EE_
X-MS-Office365-Filtering-Correlation-Id: 140be00b-5629-4de4-8ce2-08df29d63657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|18002099003|22082099003|10067099003|261009223027099003|56012099006
X-Microsoft-Antispam-Message-Info: /8uoXkneFAbbRB3vxRvHHdrNHCuPabZlMoBJnvDZsz7WJy6WFqQ0w8iU+VP+F9bAqF9Ou2bHnRwlGB/s87QEopOvju4A/17TKx9Vj/BQT3jR7/aUep9BAiGOOEiB3uRmcYhmdI+ot1xwcAN0CF6vSDFP15S96gcYfpnM+/xQ2jK4+ckKri/7wkBodYJmL5MxEvzirJTE499qcOn1Z4MvjfFQRxGypfUNLqi7cF07z6095qTHpb9T7EvPu39zyAlfeDk6FmO5O4hIHJMzQ7nZHce9Wh2jYn1PJgphFVj5On9em32Z8Ub8hQuoRUTBCNw3GnRQSRft7MlSD9381wSTCXXrRlBnX5VLwkaliHjAjYeXM1JaT17hEMcq6IkguKuVofTbN9sT5SyvYNTM7cgqpQis0GTq8tQEqMSu7A5/Rroql0N98qZptvw2umXvgpg9d8/8rmlJLNO5oGgBlru+KK3EVwkzArpmnl8FbGDHWt7hV6ChtwaH/DiLl9VEALpp+GT4JkImOXWLaUgVJoJ5le+S7hoRy3ddlwzu/hwHqjsF5v3zPt6fZX7fBXM6VoyVM9620zPnpQ/Fej67YGfrfItthMxeB/CroAKYpMxISadaX5VxS38zQd3SKJklK409SyVORBuFGIIPID4EswS26XGiSqcNH5TkjlHSQEbx8NE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pnTL9cHarC7LfofprJguhlcHENaLB+Fr2PGW0P4SEy9ERfPmcWro2sttCXQl?=
 =?us-ascii?Q?CTw6XoDNd0XUX9eoTWFWF/qjLa3ngDLlEabe1TgmG2vDB3wjzyzz1IJC8L/k?=
 =?us-ascii?Q?h5lNHgBBjehWua/aw7VuZNOVH7E+FO/5Ig++Zenvf7lZxphsm/qFGGQgAXeh?=
 =?us-ascii?Q?cAg8vlp/u3Gl2mdeB7c0Gpf7Pwz6AKauJ0BPZfBDNtZRSO7epmQcNVxnHlgJ?=
 =?us-ascii?Q?iMFwGn8iHiPUtotIJ3GcyFvaHraevHgfcIuqZN4yng+HJCBixSlbS7g1Ds/k?=
 =?us-ascii?Q?cCXUQ4PP4/bCDKeWo088RYnOm7o9ZuUgmLbl+7Fw9T7T6UZuqf7Q4qD/FxIP?=
 =?us-ascii?Q?uONOQxGZlaTae9QlO1as2rgcqmbGZM099ZKqumTVaKXANkHWKqI79GORWIb4?=
 =?us-ascii?Q?059P8uulXJ0ezl4KMT2zneO3nDMuVTezWM0hZ3EwB72RuG6h5sH272VZ5naC?=
 =?us-ascii?Q?JdsxtWw7IpGaV2CA0UjwFoLIMLXF0amKoLQ2mWCUUL0hOrrRce+fRYLbClSm?=
 =?us-ascii?Q?5Bgb0ss8aXXHd+gqMFbKym30V6fbxSYtZmmTZGrIynrax3vB6TNdUYWPJAWO?=
 =?us-ascii?Q?f0ltir4HgooikiaAHFmTmun63/e0SjCWwmZBHExDEqZ1fqCWEiuo2bJFt9Kc?=
 =?us-ascii?Q?ERve1ZUXEB5+y6xmpwWHgE1cjH5LQSEhNGwxISmubo/WhpUYBfrn5vT41V5l?=
 =?us-ascii?Q?+6LDXWhuyyWtpDkriFQl9++SQs+UuvtBfMX+JooChgFWRzfXnAehT3+xbyWH?=
 =?us-ascii?Q?BJwmLjGA+AaPujLLNsKRmZOZTLsI963vKIV5ktXdcFHH9yhRZuNq4krKcYtw?=
 =?us-ascii?Q?GJSwBP6IcIjNRVBkY7mjJ3iMFK5wLZKQElrzyqp3dZqS8wwEcp6A/rMLIRvd?=
 =?us-ascii?Q?i0XHgbF7IcdZ1jyjb9zOnq1IuiGDYJnBID/EWfvyJ9GOPFg2IdBM/glVmQNQ?=
 =?us-ascii?Q?i9k85OsZK+NXSJ0MKS0m2cI6qBKjNhVdjUPjNSsGUMEEIHp+DzTUXiGrytK4?=
 =?us-ascii?Q?pnUDI96LkFM3pZHRK63AMN0X2BO//HlxDVkwQtkUa60NRtrC1z8xXtcXzfeN?=
 =?us-ascii?Q?eT/1rv6YLLcQpFr+XTYmWYM2TVypjRta7g17h6ol0ciPP/v6/GOb1PeG5pwD?=
 =?us-ascii?Q?zaPRe6MmqEFRY1v5p/Od2xSyhsF+ocMq83OYzBCcKbu899XJST4E6gDHC5q0?=
 =?us-ascii?Q?pkV0ffkNviNpmevaeuprNvfAkUfqXJBHP8YgArJqaujiBc9TNVNVy8jdAIdF?=
 =?us-ascii?Q?f6ZU3uU1c/Ts+J5hoZSeBtrKy3N9UytFzwdUbq+tmiNIBd+hLWvqrhHu8S2f?=
 =?us-ascii?Q?jg6CSvtLYoKFmLYt06RR0parFMYllvU2ZoQXY2k4U9oKlqIUa9eyeXd+2B19?=
 =?us-ascii?Q?RHqpLAPdCfAx6hYS11H2H9iJ858/TVoebBaCZvfenn9KT2s+KCXY9FBSJXQ+?=
 =?us-ascii?Q?JrhBQlbAMwoQ368t0WKt7XBIwPqS/y0H1UGZWZFVlPKFk9qRYiik6zNqxKEG?=
 =?us-ascii?Q?R25pztXwMW02rbGGQC1mApCZbpElkux/5pntYxaaXDIQHY3SgiSvm0FSCvKU?=
 =?us-ascii?Q?lvKDVrNL+0DlQhvlMYHrwiPAapeMBTXqpqQY+6tRR0EP1vihJhFmwbF1S/+N?=
 =?us-ascii?Q?yUtLc9nDpK4piyKqYCV0CydgA7ChnkC8XrrjgW3X9JY9uhm1+aY5qHO/L+sf?=
 =?us-ascii?Q?mgu3j7dA03UYbRWAcd5IvmONWkt5oAtdNHku/Yyc7sSkBfQ0la9BUXizYwtX?=
 =?us-ascii?Q?8vJRukJjVRgN8xw4tlYb+Yzv0Y09XtI=3D?=
X-Exchange-RoutingPolicyChecked: OKbBYJTWOpF7xEBbk51lW1e4NQCXCCu391QiMGRGS1s7Y0yDLsPPj2xpwAVbtfNPl75jX1+mV8ZJkabvraGP+82h3E0uXeNGOjZ3cNm+rVkOaeqHSSp4ZffSh57J+e/9BzbAWW1tQo/zeYmsf8QFq5CUfTd0/kvpGi5BKfv6Ze4WXWXTT1IrwCNNY4NWNNaOskusiYEhTnH7oKzarn37wMcsCIAisO84T6JO2BEdQksK9JFoENmbSkPNkHQwknNbn1KH2YofMU1K7Jf4ur+VhvG+DY0K2MSB8ktNFV3bFkb81uSFyNAADqecMeYebMvKlBC4dRR9g65prnLKMGFVSg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140be00b-5629-4de4-8ce2-08df29d63657
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:33:32.2983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPPt4FseWD7cio1y+uu7QBjDrN2VNDfuSa6/ikveGCTZrOnAdSuAr4GxKQ7SRjsquc3myK5EC36rot9BYyJywzh8tfsayVUJLSAVvwteKEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0949
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l-E1TTQQyyp8bteVMd9ogmzOUrLM5gYS5z5iFUZxvFU_1791970417
X-Mimecast-Originator: toradex.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
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

Hello Andreas,

On Wed, Oct 14, 2026 at 09:46:44AM +0200, Andreas Henriksson wrote:
> On boards with >3GiB ram, we can end up with transfers above 4GiB
> which is not allowed by SDHC driver.
>=20
> fsl_esdhc_imx.c: esdhc_setup_dma():
> =09if (upper_32_bits(priv->dma_addr))
> =09=09printf("Cannot use 64 bit addresses with SDMA\n");

[...]

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 021a82d4709..a5f2e3e1058 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -1371,7 +1371,7 @@ config SPL_LMB_ARCH_MEM_MAP
>  config LMB_LIMIT_DMA_BELOW_RAM_TOP
>  =09bool
>  =09depends on LMB
> -=09default y if ARCH_BCM283X || ARCH_MVEBU || ARCH_ROCKCHIP || STARFIVE_=
JH7110
> +=09default y if ARCH_BCM283X || ARCH_IMX8M || ARCH_MVEBU || ARCH_ROCKCHI=
P || STARFIVE_JH7110
>  =09help
>  =09  Some architectures can not DMA above ram_top boundary,
>  =09  which is after 4 GiB or 32-bit boundary too. Limit the

Is this specific of imx8m? This driver is likely used by other i.MX
platforms.

Francesco


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D7BC79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 11:10:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D0F3606E7;
	Tue,  8 Sep 2026 11:10:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSvTs4TS9yhf; Tue,  8 Sep 2026 11:10:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 20456605CE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788865800;
	b=KhFQuXsjih2z5cQkcJtVdAFkBL09ZMxfmkraJo4MzsK+zz19qZ+m5i8IQwnCSFIPuOk5
	 ImX3ZysdNCV45yO3lZq9a2g77bC9j85Bfp7K7ELu7E5DAA9MFq6I1cKB8nQ365X6Rcbqe
	 FzcB3VeVhp+X3/Z+vLhLgXDyDCN5ajTTNIhuBBnnYqXQQ1eixBeWi+xMxYdDDt65rPYU0
	 V5GOSQQuHZo/KxIQDe4PX9NtsjHkjpoxYaH1/2hRQRFeRSOjBwx/UfinNX3+fwZP8/acZ
	 8a8H8NsAYMBuZ08qm6VTTYTtQWmnlT622VH7gPSYQU8qarSzrg1dKWD38K+A6msmArg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788865800;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
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
	bh=VtG5sA2GmGxJb+FkCe6ecrIqQd0YBYFf2WbPb2X3rXc=;
	b=gyyjtFBJzWArBmgkTRB6QyuKK5F3BHF/HbfKDvobH9nP1L4ZsQqvYkEOtd6WFdcZ54Gz
	 yDJbHqKuuV6CDQvi9ASWX8oSHAfr7jTpqCaVKrdh9ANWZZB29Ur2Vb1OK0/z6eWC5u8Np
	 1kKuT/dg81whiJSDZXZ8GzmjVwAMRt3vKAB7qcz3S7tivBeBCCwTPgoaliqri0kmA1kCa
	 3dySiRN8jsnWIfvPm7g34SCZKDfdApVliREf08Ydq/HcZE9lHy4dMwQ22tJ7XdjMT4/2K
	 yd8dR235UmAuLiRT2vr9q3gU56gZWzZDSa6As8nPoDfGA2y/D9Kqj7BvQ5itsaycryQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788865800;
	bh=VtG5sA2GmGxJb+FkCe6ecrIqQd0YBYFf2WbPb2X3rXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYTTW+35EnMB2+ET2f/JdoUKM7ECZHetIZlDdNLtOKfWGwhCjBBeo5F4qpTDCBUUx
	 CZBb1Ji653I/IEZe5lvScWxnZAVVX1p/iJjmJZpuN/gX53OGym6X31LiOmFx4Xcgr+
	 5TXfHzfr51Ws+WNFZaWhox/efuHLgOTFsYOKendjvJCcl85VQJc3D4/UBMc7gnMjEg
	 QWMkk0TdudWo3T8tlk9qmRv9Lp3Uq5/pe0ZPZC35czb1wmyG6fPVuyazJ4Sq8YraNx
	 9s8WGN+hcoMZ0H7O/Y5q2VRZbdLdc3BY9xd7bAMq1lDyozTpPArgUPbOu7p+nmdRT6
	 f0+8kkMhxOT0A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20456605CE;
	Tue,  8 Sep 2026 11:10:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 32F14D90
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:09:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1989E40159
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:09:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kGtTCyVk9M7g for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 11:09:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A222F40151
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=194.104.111.113
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788865798;
 b=UM8cRnRMfo7yzv5Idf5NZFBUf2fUyq1MomxOQQVyYJiPRKZIRxoRJuD5R/5RfR9Cg9QM
 v51eYtrNUZHKusFn1a6epRuu51HUtCtoC8ARo1jAi2AJsUGEB6Ttz7I+8ciRWuyIoeApM
 X8zALAfjqSB3o+VInZqoh2OCIXzfKOxQHodu1znLRP4EYULxT1NdNTcOHVqplOUGUl+Ru
 5hsm54fnrWB3Db/tYNJwRA2bXYzkoEgGZiEcXthJnI7XOPiraaCrqdLABsIg5zx3JSLl2
 TopFbhkGaxxawM/8f+u2whC7PmQVqiynDCKpoJnzUOoovTlhz9EOZlWyA0gQj+IwBhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788865798;
 h=X-Greylist:Received-SPF:DKIM-Signature:Received:X-MC-Unique:
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
 bh=VtG5sA2GmGxJb+FkCe6ecrIqQd0YBYFf2WbPb2X3rXc=;
 b=Gr3sx8/zWPhl+a2M4A7WQNJC/yRZ19CUYLmexp3UxR+kaAtt7AkjDYBwO59IXE/nIy7v
 cpLWENTYblwQfuHfdznM94UygOVndQJfifLjp+kMdbDFaeD2ZfJ4lWE/3+h13qDosm0jl
 dLMpVzDGTqgrXWtucRiA/wkyrPULm0WqiEaXh/3wPtoPyOIauucmzNQsWgkubtdasbWrM
 PvXyuFLm6x2ExoXuWcQA3kxFueSebqVD4biD0jmgvrc4JxzpMIpZ0cveZyqwv3AxdlndJ
 CEniclsw03CVkhtexBKvooyAaZ/qAVDUOxKdTsgXljhi4iVqyb2Bg2JujWaNTVPEmwQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=toradex.com; 
 dkim=pass header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=Obwf5jjV; 
 arc=none smtp.remote-ip=194.104.111.113
X-Greylist: delayed 75 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 08 Sep 2026 11:09:57 UTC
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=toradex.com header.i=@toradex.com header.a=rsa-sha256
 header.s=toradex-com header.b=Obwf5jjV
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=194.104.111.113;
 helo=de-smtp-delivery-113.mimecast.com;
 envelope-from=francesco.dolcini@toradex.com; receiver=<UNKNOWN> 
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 by smtp2.osuosl.org (Postfix) with ESMTP id A222F40151
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 11:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1788865794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VtG5sA2GmGxJb+FkCe6ecrIqQd0YBYFf2WbPb2X3rXc=;
 b=Obwf5jjVsDqxTCVVZGcVWGgAPUaprRx9Rnxto7K0/MVCelTkb2j05SwLA2M0I0eAZZZ4GB
 +XLG707YgHoS6yWLu8+1ddf2E+k05WuMFePQZiqLk9rnZedOPJfUu9bjHbshZN436ADWr8
 yZuV0SqNSPMLwZReJBUsG6iput2X2Ds=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazon11020073.outbound.protection.outlook.com
 [52.101.186.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 de-mta-80-QbVTkxdnOGyOkND6qrBA0g-1; Tue, 08 Sep 2026 13:08:34 +0200
X-MC-Unique: QbVTkxdnOGyOkND6qrBA0g-1
X-Mimecast-MFC-AGG-ID: QbVTkxdnOGyOkND6qrBA0g_1788865714
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:2e::8) by
 ZR0P278MB1061.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:56::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.15; Tue, 8 Sep 2026 11:08:31 +0000
Received: from ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2]) by ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 ([fe80::88:6821:13f5:a5b2%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 11:08:30 +0000
Date: Tue, 8 Sep 2026 13:08:29 +0200
From: Francesco Dolcini <francesco.dolcini@toradex.com>
To: Rafael Beims <rafael@beims.me>
Cc: Fabio Estevam <festevam@gmail.com>, uboot-imx@nxp.com,
 u-boot@lists.u-boot-project.org, Rafael Beims <rafael.beims@toradex.com>
Subject: Re: [PATCH] arm: dts: imx95-verdin: migrate to OF_UPSTREAM
Message-ID: <ap_srQBVsRiuTBUi@francesco-nb>
References: <20260908095900.1842496-1-rafael@beims.me>
In-Reply-To: <20260908095900.1842496-1-rafael@beims.me>
X-ClientProxiedBy: ZR0P278CA0118.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::15) To ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:2e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZRAP278MB0495:EE_|ZR0P278MB1061:EE_
X-MS-Office365-Filtering-Correlation-Id: b17bd882-a5cd-49b1-07b5-08df0d99840a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|56012099006|10067099003|22082099003|18002099003
X-Microsoft-Antispam-Message-Info: r3SIn6cMuS3CmfRHezIf3VhiqQcVFPnK6LhLAq69cHGFyTPGh1cS1c0HgiM7Y/FvCTMpOV3JHYcyrBlfQRHeqkFtNSv4vNWcRYH/VsRMqlSrOa+tL9Gjy3a4FHoU8bjOkUL6mWDMpkUPhit//FQEmkGOuspr3AQ5VM/Vw6VaPFxIHUgNHWr0aHzM6lVQV4Vaga9JQ+3RybysIwt6gG7VPaGV1ilxyKEwJ+w299meqcRxyALJENQQD7KDHaKK1R/SWFlAsyDgRqpxbl2gIyag3H4kdI7ofikYYyQ8BANhNiAKJzluBMDsQbTnCb3e4ApLJW/6nHTCZYoUqwYCywd+uKaMhP3JB7px4ZMlji3fgB8gWyOrxPptT6bj/VJ1j2TiP/PqqnaqqOgeDVVuYMdP3vo1W0G9CDyCRoG+mC/1P3VOjc6UwdjEnTeDowXBS5BCBmHYrYDwO1lLjc8ICEz42HLkYuTk2H6vGYAHZowDq2MlkFrK3aLMWYbrhF4lU2OckfeKKgOiu7mLj7NZpFQLUluxQOzB6DvV1I53OGBidjloWCXkr7NOc6ITSLkLre4JZDeZ8/+VHRs/ghLWZHH4uLgvxovx002pbFygQMZi0LG9CrEpSOzFIO0YQiIWox39FDm7e+vHFMMZBSNt5DhxMWDD3RAf75r8Tv7rhUCTtL0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fq4Jbea14JQ7m+tXMaruCTKxZhsEUuwfkfGqvWRnJdWHAwXchx+gE/qNOb1H?=
 =?us-ascii?Q?B8yw0Ep1UTcZvaEJ0FzQ+tgUELvyL34RrboM2w3oCDIOrIKNkPWXoVKPFXz2?=
 =?us-ascii?Q?rluxlaG986DTW0o5GNWi/km4c/3j3C3u+Y7KNt8g5/nVPg9qC7YGL+r+pUPq?=
 =?us-ascii?Q?J2rcHqJNwjtrktnLk5OIoiA3HkEdXzmMXh91n2S8cWHaeoAjFwd4eg3un2ZN?=
 =?us-ascii?Q?CXubrNxi4bwUuhSWd5TDLsSbibTIySf06mda6Ns79X6xF14CAFLV8MFVEOga?=
 =?us-ascii?Q?px6F6XAV604tB/tiSw1MZ3PPtmqce6P/5k86Jz55zIrYmYrVN0m7MUXFq/+l?=
 =?us-ascii?Q?XC904EAk31IqsiLMtG2f9LQNoTc3GUK+Qg7CXdCWMjbG/pyyUyV6SbvjIMRt?=
 =?us-ascii?Q?XZ+kf1CArz/atZ9nFpnavHuAs+cLjUwZ8XduZ2mDB0a7AChfvo05hbhv9zOu?=
 =?us-ascii?Q?RI+1UHbcExVepp+dOM6mqqQmD/xaebVMa7jyujQHzBzZzyqVqJYdYV7Og2TB?=
 =?us-ascii?Q?CSCdvC0Orm8jrEEx7zmpeUoJdRuJsfXffd1s0qhVZAQ0FBbx/f9bbi7HwaNH?=
 =?us-ascii?Q?gZkMCtcyMR+UX4YY8HR9vB3HOTpC0IvPx6vDZnHAm1y/QyetL2bUJmg1ta1w?=
 =?us-ascii?Q?FR4mmb3G1nNoom8pO0pAvEEKzXPRJtwVtEyKrdKoV7ws/sZt8Of9ywj9Zqd7?=
 =?us-ascii?Q?H3nRAOFIZUAPdkt1hY/XscxKit8IG1ZirxKKpuve9z4UmLmVZaBTzqeoYWzd?=
 =?us-ascii?Q?FduRJrvbQ4eVu8MR4eTBpD1I6lONolF36ncLhRwOwObAElkrmHKZpo0+snPR?=
 =?us-ascii?Q?6DD6dJseCBFcui4u2ulRtoQ7r/8cGiviTtxGQVMd5cmnCqBWNnGRNsbHAsqx?=
 =?us-ascii?Q?ZAxBNBCGIiaJxsq3hAITfc0i0uGvCkQcg6Ws3zAV4JVURc+PJ+DmwNNwnzx1?=
 =?us-ascii?Q?6IuHSImWyURMppCTQONcqyFgME3SeEE4oEpDARSy/fi7dZ0dAqIt3XX1p44O?=
 =?us-ascii?Q?MDWUS6Mig4zIsnRQIzGUAJo9y6vSEti3qV6jMvBVJxRwNGRYvmKJwMxtU0cH?=
 =?us-ascii?Q?pHoZ8RYPU/xnWUmArNqS9fm7eewmtQDbdN2ErjYFjmDjfzZ0gT6QM8HGuuW0?=
 =?us-ascii?Q?PeL+zDNtAx1IxsAcw1Rm44z0EMR/Hspg0cfHI+LRbn6X5lpTYph3gENv8xSW?=
 =?us-ascii?Q?PZNAXlxeDVpNxHRTuKCsKcflhaB+UMilFogTnDNROFUId01M4UcOxlGqEtie?=
 =?us-ascii?Q?zJnHiNhynIu4EMA3jk7vJMr+OkiVyNJybWu4GnQ7cvyLrd4UGPwAdNCQsS6X?=
 =?us-ascii?Q?PbMot61VxlrcFEtksLLNN2dJmbsZUTE3jl8u9M/x0hfAQU5XyklOE2Ndbq0Y?=
 =?us-ascii?Q?4+Hf9LSUKf/3/8gOHNtdn75BMYG2g/4J8fLvcN8p51Zt80t4t/mNX5POcpw4?=
 =?us-ascii?Q?4HY3T6qh5FGVBNw6Dh0h6i1qrmU05Xe3QKk/1nQeJiSwfGKxsXlJmKdBqLyH?=
 =?us-ascii?Q?0bVzC8SS9Ztye4hd2AorZhGDUL2uDGQVJk397MXhyd4AMr3kAAJtqg5i86tL?=
 =?us-ascii?Q?1PteFma2K3uF2CSKJoOCHvQmi6XsDPB8UG9OiuM89utRJgDRl589m7EH2MUr?=
 =?us-ascii?Q?ozqD4nQccWmtd3zjDWrcWVTCtFH+leLaTzeOLsIxjp3IqxqOwq/+0rb/TaCu?=
 =?us-ascii?Q?0K4M+O4UFI4x5lBlPcUkfo3tZ8zA5h35CQ43oHWtKHvG5kQy+5Wh722+5ZyN?=
 =?us-ascii?Q?rvdCpX+pa4PwtR91FTpfs9RxXbSm+R4=3D?=
X-Exchange-RoutingPolicyChecked: WD+qEJtdot0fa6b1OiJ+iIP9Z7fOjDohANdFf2AN9CnsAEAOxROO9Q9LyqzEHO/awuIReyZrmkiZFHmzLY/vb9c7qj1QHOu+NGdUV/u5NQ3xtX1MwsEiimibXxmy8UiGSjpy5rXnDsQui/y3yqlmW2NDDRGRWGQh+I6PA/uLT7jC47wdChrIdKXKfk1zSw/fH0Ru0e6ElcGUTeXXAc/A2f5dot8Jf2Ud8bGJiaYO2AjakbJrxSEPPdqWgADuyJ+quDS5D+ksWdccvVGD77Wif/Z6XveNxvav6K+VM7EB+KBKKlN/1aWYdNzaEdTBJQ42hPtVv/8KxeistqHJx+B8Ig==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17bd882-a5cd-49b1-07b5-08df0d99840a
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0495.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:08:30.8353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3/zDubNFs2L6BcNvl4HHnInjaRZLtjP0PZPN2qx1BqJ5hYIPcPZlGjPBJpAUyU4InKXEriZM7+lh0KG3M4f8a/lToBuQHeaitxuQwGAlYMQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1061
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gxs66pAI3OOvpUJIaL0bsTo2_k2Mw9y3kGhykX6RU_o_1788865714
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

On Tue, Sep 08, 2026 at 06:58:59AM -0300, Rafael Beims wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
>=20
> Allow CONFIG_OF_UPSTREAM to receive automatic device tree updates for
> the Toradex Verdin iMX95.
>=20
> Remove the now obsolete device tree files:
> - imx95-verdin.dtsi
> - imx95-verdin-dev.dtsi
> - imx95-verdin-wifi.dtsi
> - imx95-verdin-wifi-dev.dts
>=20
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>

Acked-by: Francesco Dolcini <francesco.dolcini@toradex.com>


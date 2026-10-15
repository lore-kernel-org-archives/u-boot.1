Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65025CC6B3A
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 14:47:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F160181218;
	Thu, 15 Oct 2026 14:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id om5rLBpb7Hb3; Thu, 15 Oct 2026 14:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D95E081053
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792075632;
	b=a5f4TkO3mtaStuGZjyAA4nDX4V1/o2AKaZhB4w1L1Mgg3TJk8wRYrpm2/Sq5pbrOImxx
	 wtG5M6aWGuxX7vRpYpv1kzAf23ZMKhcrtgMQ5EXTGZBEPLWfQ4mK0as/9/8xdPEWE6vTb
	 anrj9k5ADvq0dOqrZ/doARzBR9fJAgBi71aZlazonJGnLdl5XzXPGgnSF7Rqy7FGdgmHU
	 Ci8SaQbuGa4xJbE4qLI59j/mg61acktv/YttyXUmCc3aZAjOnPKe0fQ2wlwlfzWWP4Ce+
	 IemSL33cvQyO5tFtdPMuDG/2akCeqKck+JBfK8kmbvAEK2SHdSf7Im1/wjlLUe+ZbBQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792075632;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:DKIM-Signature:Received:Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=eV1yrV1swy7ZdVrEZp5/1ugtp6aoUW63c+sh9F3uX5Q=;
	b=iOQ6SNJpNVqPC8K1j617VcqRsmF7U9eAHySy2/4Sbyae4pX7ZM5iSPAUUYmnGyxXyvXw
	 hkZWIZTV7RFCPKcbxeICbiNU9cH+HZeQRZi4+A3ay4Bswt+PIi3NDw1iVJu/QD7pkCSxU
	 4phFlQuNIcsC02o89QX0wO2kSFC1HM8MKA1Zc/cg224n6MIpaHeEhAaklmG2ur28AY7pH
	 qG6whFYc1CaYCEcoVZ0ZkQaywCEdCPddI5ghtlofYJOjARQEDy1t5VzXzB4Y4oWI+zqae
	 M7TN4HcSQr/BDrLZ4FR7XbQWB7AWqTzHL862QSwXDIawMispxSEGA/nxEROu8ctPagg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792075632;
	bh=eV1yrV1swy7ZdVrEZp5/1ugtp6aoUW63c+sh9F3uX5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lHAhJQIyhSMQsrDOb22zGZX+ZN4Zx+l37GbX4PH6+fIgJO049Lk97GNXjN66pSVVA
	 kiA1uG+7aof2xGtLuxrAThZSaAMs3oePdXfQ1AHH4y1IoyimY1azvV6wZCB0JvG/Eq
	 GZC4c3PuUaaUB7cc03qF52YLDoaoa+sY2W0JHQBr0wIvTU3GDsRlo+ccSeMtVSZkyl
	 FEEM5pVbTmPQ51t6wFyCf4E9w0f9e7JHf8BhH+KdCg5ux3sf2wZ6PI/qn1DvOsITKM
	 6se7x3CMgBroF+CkrlsFvmQrmXfI5jyDyEd2yc1g9qTBOOvB0UcPdzMUTWmuDcLybU
	 1i635MPxeeggg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id D95E081053;
	Thu, 15 Oct 2026 14:47:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BCD81105
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:20:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A335A60821
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:20:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wS8IK3u38cPk for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 14:20:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6948D606CB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792074017;
 b=eO3exnd5KjZrTpxo+/nYtxK1w9jHvycFiyh/XufY7BfI94fb+wn+4xrcs+wSSfZH64Y7
 tSCmWt3nMgmV2HDLAZGtirXchV7fIXAAUfL1y/Q8dFqL967XVGt59tpAEYvi3OFOxc8Ad
 A3/2jhp/JxibvejBDUTzbKnk8zK1ockVpj8Vklxng5dLtXjjI+kyNfalkZv5FdOQ2DL3m
 9pypTwxf6FTx3ZJaMqy8E1rkbLaL9raQo5sa311f0dr5VPKT1X8yh9bXFeQxZ9nF4d0BZ
 7iuAO83prGqsI3bxAXan/+jhw4eFJXWiAU0T+TGFE5e742wRrSeEsD7aE+hGdeNxY8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792074017;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:DKIM-Signature:
 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=eV1yrV1swy7ZdVrEZp5/1ugtp6aoUW63c+sh9F3uX5Q=;
 b=KXVLAnKBObTh7peQMQZURuFEW9m3VwmlAtuaN9YkYYnviWMLENongZJIvbxq8OisCJLb
 TNxjPTtS2IFetGos9V9YEHFu2Zw44MbnqyAZVsjApp1KUTRnpcXsRTemRpN3UQ396VBve
 AMSNaz8FeCkYGhBcYbv8Yc/KYmsnuaaoEt7ALdlLhdmEcvl+S9N1SSmSD1HjBlSd8Qjto
 XlNlcAYPbyHs/s1jjQoibz0ky5RU1T1COpTK8WLkoINZVaatxL9c3lOULbsLstW560TnP
 StKyFi+8N8dEEvdkGYCIGFC3BuLS+0Ew22qEOpnibrvNpXV8EPF9FwDOjlQTdeODf5Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=analog.com;
 dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256
 header.s=DKIM header.b=lJpiPB6b; 
 dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=Mmacc2jN; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
X-Greylist: delayed 3156 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 15 Oct 2026 14:20:16 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com
 header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=lJpiPB6b; 
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=Mmacc2jN
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.139.77;
 helo=mx0b-00128a01.pphosted.com; envelope-from=nuno.sa@analog.com;
 receiver=<UNKNOWN> 
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com
 [148.163.139.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6948D606CB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 14:20:15 +0000 (UTC)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
 by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FD5naM2520129; Thu, 15 Oct 2026 09:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
 h=cc:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 DKIM; bh=eV1yrV1swy7ZdVrEZp5/1ugtp6aoUW63c+sh9F3uX5Q=; b=lJpiPB6
 b3pl8b6f3oHzpmku7EwlxcFuclhheFKHd+qlhyhbEuX8X5QL7RTGwF3VPFT9+LqP
 5x1CULZHbe8rFQ1qLxNVIvB09x7KVeD62+AuNvP7q/huuf7XH0Pt/twTOOzNv5l7
 lY3TB9AgJ386iMvlrfXslpKIawkl1+c5iy+3OTM5nmBnoxMqZ3P6wUQ4JenYAoBB
 KTLfNkXHutI/9s46AgG1rxuVjLC84pQBiyFb/l9Mxpi1nW9mtHSGZIGw8tFLDXB6
 ua9Y3qkPd72bZassTWBL7YcCQi6PIQJJE3ZneATb3ofpLkm8FuHx7LydGVjU+GaA
 IrswzA/U4ru7m5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=eV1yr
 V1swy7ZdVrEZp5/1ugtp6aoUW63c+sh9F3uX5Q=; b=Mmacc2jNL8LtcocaOIC30
 gRqmOoGGv8t68Fq/+TKXOXXvabQy8RSyAnDdz2Po+Cn5O32YD4qn75JVNO4CxUnQ
 E1oaQvfElCNuWe6gqF+nhHUqfcUInZV9iJl8XLauWFLgrDrlu1tX/6cZZ9cBsZwl
 PRnTjmW7K7YICuxRfnAK9/ukT5QikHPkW68473Ikm9+kRy4PznkaC9GD7vQ9xY68
 9w9yMzNLgYRGfPF06ml+YHFxqfRhNGI+OjFFm+rcksJgvwUai4tQSm7obr2GCkC3
 1oOWIPJAyPUsSgm+4tTZMDRM3TzOnhKXWaDvcVLY3/Z/mG6+MePX3INxGac6m96c
 g==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
 by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4haydtr573-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 15 Oct 2026 09:27:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jJ+z32PoMn66euEebsMCYC5WlZW7NXaztEhth5FVEfg7pDGJ8/iy+zb7VJfE9nGzkIErXWkHdRqsHnkXwpNjR4P2sFJj3JcxIrHXR3EgnENNB58CbNWz0K9s5EyMY5y+33tGPoenLvqL72PmX3DMv91+MKItHp2rtvi0cpZ3QOwLRWuoz5l3mFMLAsio1k/8Cooj9DVseNpyVUtr3XGP/GQUCo+JcSXENfIk1Sav/Ah7/uYqayQp9eCevEX8XAzThzPpwIZoNqAHUTEdVrsHMxwZYMRgeIvgjZ9rEd2zUIHVxqE88YLPsbWkoX2/TKgK+bRwAkKtRN49iOvaJ1dlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV1yrV1swy7ZdVrEZp5/1ugtp6aoUW63c+sh9F3uX5Q=;
 b=p1B6yKbmotgxznfFqRSlHc6QqklwXxlkWSOUmFy1uwim5yJiP/yFxIGMPq8GYKuq2F34w2lbD8vm1ggHXdDfvEdaknoCGAUe6+daeGA8MlXf6eOJMhNqmUo6uGYGJnyK2L/8v5/a6kTAdLCTpRzR/ATTENp7oN5eBKS0phbaA5zs/o82HosIDGX6hkrCVq7WmkBxD9XioigYhp857iJJz7V3HkIPxGmr4b6fHbhVQpv1i/vPiFEuPVhxZdpVYM1xoj5mhGHx3WjEmRX74ZYPaamgIq+9mIwcXHbCrOVrAu+2k25ZKDFg0pRtsIQ4n1LpKMKzjmncJSfuTRb7xC4e/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from BLAPR03MB5458.namprd03.prod.outlook.com (2603:10b6:208:29d::17)
 by PH0PR03MB6431.namprd03.prod.outlook.com (2603:10b6:510:a9::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Thu, 15 Oct
 2026 13:27:33 +0000
Received: from BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656]) by BLAPR03MB5458.namprd03.prod.outlook.com
 ([fe80::7eda:fa34:15f9:e656%3]) with mapi id 15.21.0496.021; Thu, 15 Oct 2026
 13:27:33 +0000
Date: Thu, 15 Oct 2026 14:28:54 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Qasim Ijaz <Qasim.Ijaz@analog.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] cmd: clk: Don't truncate "clk dump" clock rates to u32
Message-ID: <atDVBKlKfTWKlT01@nsa>
References: <dcc2d705-eef9-4346-a2da-ad42e53e973e@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcc2d705-eef9-4346-a2da-ad42e53e973e@analog.com>
X-ClientProxiedBy: MR1P264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::16) To BLAPR03MB5458.namprd03.prod.outlook.com
 (2603:10b6:208:29d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR03MB5458:EE_|PH0PR03MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 76cf1784-eae6-4b0e-0d5b-08df2ac01186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|260925022911599003|11063799006|260925021911599003|260925021311599003|56012099006|22082099003|18002099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 7lIQAWyLxPCNEguQuU0Nk5Sg26+gawYbpHtdtP2LKn2btaSBLF/6g8h7NJSJqquQWsDICZxB/I33eC6sJUhjy4TajzFGFqVjNQdyMmF3YwUoIwgqJs1WU50XKoiQdV46OcAn31mVTN3PAwDqBLU0B4Q4eIVIvnfVrJWkIf4lehBcHRk6kDavUEkiM5nqufkRBWhW/cFnOkX/f8mrL9iXsE/mB4mb6N/zOPBbygVpVvezPYSFZhdJSZajXDQ/7mbyiZyvMehEOf3q4l1g/Bm0vVuvO+4oW2UuBga64E1C74REQJQO0WiB+ckQ87vUnpBmcykAriZVPeGdX8mwt1ZrZvWAEvFDuUTvDzuSkZIsZIeAwdhjIwESGBOLQk8rq2QQDfuA6zWP8d04VTI4bf4eSPunq8Q3Ow5Zbc2bzpI8mBUpIB4IqxK8Itj2fAeLTqzYZIX+KCx3k38Fre4rQjl+mydJX6StiAB8cTh2VE50sPVdkEmGox11l1sszz3Iqm5wreYr0NzF9n3BTe7Y9/J29cG/RlgfigC28UPafyh6baC8ae3ObgXrakaQKFvgCDm53467WisFPbuS1q6ffDLy5I0e3jUFdo43WbRkmf80r2DSFGo6s3nxaotaFsyhIURlKP0RXaat+IwEIVfcq3B+5j9rGtLRzAm0XGH6nEwLYKg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BLAPR03MB5458.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(260925022911599003)(11063799006)(260925021911599003)(260925021311599003)(56012099006)(22082099003)(18002099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmhqdXJzbitoekJ4cVBCd2trYkl4NDFqanJoc1h1cEFObFBuTEhWejY1R1JG?=
 =?utf-8?B?cHpDNjVRdS9RZFptZGNteFpQcUh2MTQxanl2Nk53eFF5WHl2Tkc3SUpURUhu?=
 =?utf-8?B?K1c0V1QwdGhwRDUzc2ZNNjU0a2dkVHl5aXZLWDJsazRiV1pXdi8ybjBjVHRQ?=
 =?utf-8?B?VGJDYjZjS0RzYkdnb3JyZmh4MWRQZE1keUtSQkpwaFpNVjFkRVVHdnlKWVMw?=
 =?utf-8?B?dWpPSzRpZnZFb1REWVlxTmZQUWR5dHVTeVVRYTJVVVptTjNmRTV6T2FlL28v?=
 =?utf-8?B?N0xvaS9FdEtndFhrejIvQlRic01MYU5yaDlxcnJjSW9PZE1jNjY3ZERtNjhG?=
 =?utf-8?B?OCtlaFhaN2xkV1A0N2NrZFdUM2h1czMybjhOcmg4RWYyM3hUd3BuUWoyN1ZF?=
 =?utf-8?B?Q081RXRYWXZWdi9DWEJYcFJLQlBHdHFNTTJtMmhmSlNEOS9ROW8zdzVRWUkv?=
 =?utf-8?B?TUJMZmJzcExOLyszNEpPTjZrSWdSWmR5TWNEb2pKa1FGc2dLQ3hlcWJLNVNZ?=
 =?utf-8?B?WVJFc1dRNXVqNE84NCtyT2FoeEtaMlhZWTZXcTFGZDAxVHZvekNZZW4zRnhy?=
 =?utf-8?B?RHVFaG5ORXJVdEhoaHp6NWk0ekViRXhVNUFLWitDZnhEdllORW5lSm5KZTl3?=
 =?utf-8?B?QUJIVkJ2SnpHUXg4QWo1ZnhIbGdrZ0ZGN1dHOHdHVXlHUkJ4emdJRWtzbWd3?=
 =?utf-8?B?ejJZODgvb3JTdDRHeG5wbmYzZVNocXFSdTVRM1dVTGhYUThrWTltcFlMY2R5?=
 =?utf-8?B?LzR6Sm1GR0lCSEJVaEpOUUtDU0pCTzZBeUhYekM5UmFKeURXMUtVNHRZcE9p?=
 =?utf-8?B?b0FrWFd5VENnNVhIOWdtcVdGZXdSYm9yOXVlVTk2MjRaM0gyTGUydGFiKzFk?=
 =?utf-8?B?di8vampTTmlESld1aVFjK0Evd3paWWtSL2paZEt5cEN3N0twL2NWcGdZT0Fz?=
 =?utf-8?B?Sk1zSVhTVUl4eXY2OXZUQzhQS095NFZ1VGNqU3dlRTVnNEl2MDZHTEdvd3Vv?=
 =?utf-8?B?cWM3Qisvc2xUSWlwalVuTU0waExmUjBvQ0lUVVhCZ01WOWJxbEovUlZva0wx?=
 =?utf-8?B?NmNBbEhiQ0lYZFVBVnV5WFl0NkpON0hvTmJOa1ZrNUZzcGVJMXhqTEp6cFRP?=
 =?utf-8?B?M21zUHNiY3k1RnlzUk84ZktmQklaU0pTVEMvVDdHTWFTUUpvbUtacDA5b3RD?=
 =?utf-8?B?cmwxS2hIcTlQd0tLdE9GUE5SbmxmdXdkemRQKzliNGhQa2VRVkI2UnBEdTVx?=
 =?utf-8?B?RWxqb3lrdkQ3SlAxYkV3czdsZkEvYlhsT1NTVjlESDRGSDZYR3hna2JyUCti?=
 =?utf-8?B?dHp6blg3R1NCQVU3THFGY21WV0dZaUNFZHlDR1RGbHJrRTVnb09MckFVRUdZ?=
 =?utf-8?B?MktiTjRzNFhYSW1hSnBmbjYxM2RuSkdULzM3anhjRS9UWERBd1B6TmN1dGhi?=
 =?utf-8?B?WEtPNHp0NW5ZTlpLY0xUWVQ4T1dhOGxRODlZcWdEUGJIeTgvQkdIVFgrbnI2?=
 =?utf-8?B?SU5pTjV1OUcxcFo2Sm9hQkdGM0pqQmxnU3lMZncxMWhEVll6TFk0RUxYbVRN?=
 =?utf-8?B?VmQrSXErN04wZ3JobWdaV3FrSmNITk1wQ0U1bjlWYTljT0lxOE5LWkhsdDFL?=
 =?utf-8?B?dHBza05rTE9VRk9wYUZCdEdkTmg5U3NJWktuOEtkWFN5NEZlclZlMUE2Wmwy?=
 =?utf-8?B?Zktqcm9IQS84MFRQMHlueGd5Q1VpVmFsTDZoaVpGOXJiMVhIajMxOFVTa1I5?=
 =?utf-8?B?T3UxVXJSbko1U2lYUW9qR0MyOFMvSmNyNWRHaXp3TGdnSWVPSzI1bHNXQ2Vo?=
 =?utf-8?B?Wkl2a1I5WUVjNzBINVkwbjFmRGd5NEdYcjZGM1U3RUJwMi92TXdSelhhcjZ3?=
 =?utf-8?B?VXgya2tSZXlBVDhCRG9BQ2Z1Rmg5VllyNUtpKy92bUpZbWZmLy9abkZBczVo?=
 =?utf-8?B?cncwNDFwL1IzSE5zM290UnVnNHNNTkMxQmgwRkdGend5UTlPTi9MaFBTaDEr?=
 =?utf-8?B?MXI2RHA0K0VOWUtESFV2ZGR4TDR4aXZ0emMzVS9jQ0tRY2Ftd3VHbWpFTzI1?=
 =?utf-8?B?SWJkVXMraDJBN1VlNTFXbG9TalFkeSsrcjgxT2dleUY4cTgxaGhLb3cvQ1Ay?=
 =?utf-8?B?MkJ1QktjTVNRTGhFK0ttU285REV3TS8rbnl2Y0dTT1BnQ3pOWCtXSnZ4bkl2?=
 =?utf-8?B?c3o4bHloaHNRRzRuRklpRHJVaG9vOVZrUjVyd21PSHJ0dndYd1JBT21aanpU?=
 =?utf-8?B?akNxZ1dXWkE4WENoSVh3NnJYT21Dd1ZwRzRNRis1eHdOOGxJOHhsa0VjSFN5?=
 =?utf-8?B?dFBhYjVEZmFwT0FVMmdOUXdmZ0JaUUQ0VFVtQm42NWtZMDVNZ0RjZz09?=
X-Exchange-RoutingPolicyChecked: pyXccasJq3kiOrBHpa0jXSk2D55Roo7jemk0VXIRVW1j53n/yBALOs70a/C4cjT0GhZUjpcsAhTFHofey+3e9H+DfjGq9VPftFRvDjfbl7H0LJuGfsClS5a9JkilorxNtorm9KU+DRaP0j2CDnIdkJeAJNy5es92p1KI7CjfC+UwXetCogf7Eg+SIr/O1ihOA6qMbKj8lTMBQSQJoLUKbIY5QAYprp5HD4jp8iYMVBDePiDBfDP0UEtYD3diYSHiMm6E92wFesIluyIZeGeBrSDKkOI7xFdJLm6hFK8jX1XbcAoUtYAZojIwUXAXzgO1CXWOku7OAmgTJYoNCmdKwQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cf1784-eae6-4b0e-0d5b-08df2ac01186
X-MS-Exchange-CrossTenant-AuthSource: BLAPR03MB5458.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 13:27:33.5659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jPcKD3vozvZPqPlQ8c7Iws0Bi21ETDVAxUeONkrXn4e8PN8dRW5GVriLHgDtgsex5VJEi0ToWi+/gZ5ZdJ74Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6431
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX5zhryQU8U8dn
 XocFJDTNncv6wjVoHodIayN9YrNj4RVvjivOIfd0XlcTFbHJ/K0JBsC+p7bFe2t+Vhak28MepiI
 mJgbSzGzYwGcPft755CLs59X2rJw7Ssv8i0Gb7vx9y1WUR5MDg6/g/4UkEj7bTAEALyt/RE3uhc
 MTCjpjohtzN7sb6riTjHJdMJh7kNkymJzwVT6PfvjA2AqUhYD2Ber/ofzlWDa4d0VBEd/4aFdrd
 QtidNxGc3U4SKpmIMW6PqDNTCA5GMpFZ8/upf60DUlG2HF8ED3sJXWU1ndlxWqtG//9SbYVdC2w
 qqkT/2/FpCkngBJhXoexHAUkbNhmlioJNwLqeu8saphx/O5WXv1nMSOde5kQKqCIH7jcl8H3fZk
 tL7zBcb3gvxzFgrWkfMWjfCoNDAeqEieeUGIMnMfB6LsLhlY2rJZNYWc5D7SZKlnj8LOQkt+dNv
 8GkquFeCrwoTUN3iwQA==
X-Authority-Analysis: v=2.4 cv=S+VMU4sP c=1 sm=1 tr=0 ts=6ad0d4ca cx=c_pps
 a=hqbemJ87bpGpMWfnijcotQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=dvKpv4D0etuPJnhZW60A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA1MyBTYWx0ZWRfX4x+DXGcy5E4A
 kGMcb7Jk56ZeZR4y8vSwzvKlBYh4DY0EKmogONYNjJHlnyi80esQwxXRy1LrFCCuaCA1OfbSNPG
 adntBvnI5qSmycX23ITgq1RxwQwAkd1CkSgFHF/vpDZrHW2Dn+25
X-Proofpoint-GUID: ctt8qFOP9lV550XvfT-sJrCBrzAJGhXg
X-Proofpoint-ORIG-GUID: ctt8qFOP9lV550XvfT-sJrCBrzAJGhXg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 suspectscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150053
X-Mailman-Approved-At: Thu, 15 Oct 2026 14:47:08 +0000
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

On Sat, Oct 03, 2026 at 05:55:07PM +0100, Qasim Ijaz wrote:
> show_clks() prints information about the clock tree such as the rates of
> various clocks. While doing this it gets the rate via clk_get_rate() and
> stores it in an unsigned 32 bit integer variable. This limits the clock
> rate to 4294967295 (or around 4.2GHz). If a clock rate exceeds this then
> "clk dump" will print a rate which has wrapped around the unsigned 32
> bit integer.
> 
> This was observed in the clock tree of an SoC ADI is currently bringing
> up (the ADSP-SC846):
> 
> 	=> clk dump
> 		...
> 		cgu1_vco       505032704
> 		cgu1_pllclk   2400000000
> 		cclk2_1       1600000000
> 		dclk1_1        960000000
> 		...
> 
> In the above the VCO clock should have a rate of 4.8GHz via:
> VCO = SYS_CLKIN * MSEL * 2 = 25MHz * 96 * 2 = 4,800,000,000 Hz. However,
> 4,800,000,000 truncated to 32 bits is 505032704, which is the value
> reported above.
> 
> To fix this issue change the type of "rate" to ulong to match the
> return value of clk_get_rate() also change the format specifier to
> %lu to accommodate the type change.
> 
> Fixes: aeeb2e6d9c67 ("clk: support clk tree dump")
> Signed-off-by: Qasim Ijaz <Qasim.Ijaz@analog.com>
> ---

Acked-by: Nuno Sá <nuno.sa@analog.com>

>  cmd/clk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/cmd/clk.c b/cmd/clk.c
> index 2fc834e5549..3c816a41730 100644
> --- a/cmd/clk.c
> +++ b/cmd/clk.c
> @@ -15,7 +15,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>  	int i, is_last;
>  	struct udevice *child;
>  	struct clk *clkp, *parent;
> -	u32 rate;
> +	ulong rate;
>  
>  	clkp = dev_get_clk_ptr(dev);
>  	if (clkp) {
> @@ -25,7 +25,7 @@ static void show_clks(struct udevice *dev, int depth, int last_flag)
>  		depth++;
>  		rate = clk_get_rate(clkp);
>  
> -		printf(" %-12u  %8d        ", rate, clkp->enable_count);
> +		printf(" %-12lu  %8d        ", rate, clkp->enable_count);
>  
>  		for (i = depth; i >= 0; i--) {
>  			is_last = (last_flag >> i) & 1;
> -- 
> 2.43.0

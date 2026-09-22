Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95AFC982FF
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 08:46:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06C5B40775;
	Tue, 22 Sep 2026 08:46:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qtNz2yF3IQF2; Tue, 22 Sep 2026 08:46:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org BCF3D40766
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790066793;
	b=qpRLQLYAAebhtVGgJPUpEoQYcsYnJxevlOLSvxjTSlYGSPBhkweWOGDWrWVNTuF2tYL/
	 LzcLYbKgaij+NmsQCt1SPwctkPH24tGRue3oFUMhgMeLAht8lx3r8ZgmlTC+4Au1g40dO
	 3M8O7BGwfAu4jhRuWtCxu+EhB6U4giZ4amD6HHef614PgIVl/FCLvrUFZrruMzUdkpDnQ
	 ylaPJZd7qZfxC72btKaNlQBGw5KR4EhBUhdoscOC5vxoIWnhSZB8Bsu+y4W9Zw22Vz6l/
	 f/XaClyqsnsSv0xzPdQBriQXCRojtXZlwQ/hjMCnXlkCMbUGb0If5HMh/BkomXsZgRw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790066793;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=qsZDGN7bn2cBqZgQvSIlBawDM7Jqd1W/v5KFP5xr9oo=;
	b=I9WilT2lCFgOMzkASc5dTau+z2NxPd93h2oO6hbg16UzBlfiQoc4LtaUtD6mVUS9W9YY
	 z4XgTTwgfNoTbd5TNJbdYaDaWxiFltjM3vFJ+lW65BDbbXunmQtu9FQTYPVzJhNIPKFkL
	 lXfdE6VTzayoeLBhwlomf3WYd6plS0ItRqifhvfOi7RkGPgm6IhDtLHklfJ09OMvaq3Ru
	 DLh4n6FFGR6qom7Z7clbUM73iAVVygxNTAtKmkI2zJGJ9uB7waqljOdETYAHTAsa2B3rf
	 sr3D+LtxEG2xCddJ1QT/l4AB2XyMEWQF+DDG2ST3braFmm+ZO1UGowi7LGbMkbpswDw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790066793;
	bh=qsZDGN7bn2cBqZgQvSIlBawDM7Jqd1W/v5KFP5xr9oo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=iSk/Fb2/YNCBXQ9dtNTKc3H9J8FBi2wvEnQX6l7G+aBTMRf7YxX9LvUz9vC3ECkat
	 7P03ht1WMojhSdnP7pZqaHxHTOiVdtFngIEsQ1UdOC0KVi7IJXOpSVi6iIfpoKjF+t
	 wdtIZ0tlquf/S6jpnXQReojW0k8lV7wywvH9wYqBnSB51rB1RZBw5ncQNKvp1w4lU5
	 86Z51BMF4IWCxVL60rhY9IuOOvggUBOjIpZorAYlsQEnBWQK26AS6ixniMHPW3H4yv
	 gl5XdGiwp2ON7mwdAitwRY0XPJ6PKTMRhbLOt4ZDVkDbXAmsBGfeUPMprXG9PiCj7T
	 +nBpgFwdH2Iww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCF3D40766;
	Tue, 22 Sep 2026 08:46:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 87904194
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7F8C580DE8
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dLUE3-U486jx for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 08:46:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5442980DE6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790066791;
 b=egub8yqwgHmKzoPyTJNMsFQQyWrw7kfr18A59LqcHfcIkOF24fVMVqNlvBlxGaUprjSO
 7YoscMy2PJqT8BUSdrnhirU8Z7/azCUKj7BDiCkFr75fWjwDow7TDwfOT2b8vwVJJ5Mtx
 6JW0Vie+fbSRi12wOOBNiQBVFHLZY9kwaHtrYmDHlg4dM8xSdWOj7qZVcU5P4L1x4T4e7
 3YWHXt5dPd1bTHDJxfY5DzBFe5nzUSAK5e5kOg9zAECZvcyPbi8oHeXt5XmOKu+22qXIJ
 NLrOdML+DmY/zlu2BfK1x6Gn/L318ojHfIEg+QsY0CH3MjQpy8ePsKNdc/SwaR07Ipw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790066791;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
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
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=qsZDGN7bn2cBqZgQvSIlBawDM7Jqd1W/v5KFP5xr9oo=;
 b=kk7MsumOhlTNbB5eIIXCNJukfNAKJRoCFfwhzEAlpta0jMXusO8YdPGIoSDRIIp57rC9
 b92YZIXwrVmyKIHiH4nQttQ5Uvc8oOnXHpt+4a98h8ZIvOrrtXMlEXL/uvfnJ4vWP5d6I
 XmLTG4kw1ZPVN0XXe8GY5qXas0Iyfs2kcGP/3l8VSUGo5rZQK6qjQFFWf35dhFXWqeGoK
 NfaMsJgbO/LnlnORGMOjeMONkWKekQecaprYlKRppTZVVooNIBXGvNHzGPtTo2H7SZQvj
 U8lFZ+NzthCr9FbZc4jP5RDpIvg83oPa9xMqd+CvhJHXUhTAkhgyP0Wcu9VDDskOt6w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=oDm25iLk; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=FPcikJCF; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=oDm25iLk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=FPcikJCF
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5442980DE6
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:46:31 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68M8inFt3143516;
 Tue, 22 Sep 2026 03:46:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=qsZDGN7bn2cBqZgQvSIlBawDM7Jqd1W/v5KFP5xr9
 oo=; b=oDm25iLk5Omci8e3XUJgGhOiGXH7Eh6/FyvEWvoq41W/5UzUM7MnK2owa
 OpYflNtSGxUni9wA0VEZBTOOuvXDeqpMTysgwOq002Pl48rFZhJrQljW5Dw9X01w
 xP/TeG+wl2liESW9EI2SXzk9FyLJ5DZ1XB1ZI0+YuLaGX6VcKzOBMUqSswv9ti0Q
 EKjhnuMeJ7Iwaz8SUgVkhXC2wsM943aoXylFCOJE65JwZZ189WiNlniSLjXa1EjL
 Lwwhm8a47fRzLr4oQ8ZLtyoJoaYyQMQJXRNIi+/bd5rt+w0Jeyk++ah9zBUChB+t
 uyKfYZe7lYaqgmMGygkSyAGJh+Ijg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gupea008v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 22 Sep 2026 03:46:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=go7bXx5qFcxyi/T8ifkCjCUtenzKiVJOx7kTmgEshpZu0LQy4cyhaREao+ysuhZjtd/93lberTF5HArmK7QKqyK1t9su+JPH9AVEc/qWmQTuj6xyQ9VtfkPBN3SUGAUsHM+jHtXuPyRSwdjlr/PPxJYFMuGIQrree/rAnk8MRORSpuDMg8smyrBeT+T1WqmChWRGGX2WE+u5PqZj8rxYC8ZB7l83dmLyh8ZGzsu2jod9JT068o3XGqPBoRlUnxDuGMh2xD2pCCKW6r0YnIhCeiPvFBqQ1nXXJWjrbHX6Wu2oYCn2VBv5LkpPMo1pJjNJX4R/9fzRRZC+c3tqR8oBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsZDGN7bn2cBqZgQvSIlBawDM7Jqd1W/v5KFP5xr9oo=;
 b=X8s80iEWEW2zV0n33svQXO3mPrl0QpM1U3Ar3zBMXBlWcCiBEquAiJE9mA9jwFJW/HgHN0TDhFG6pGPU+KrAk6NG4T0VdIRRYo+0A+XK3YlfKWPOUKyTcNJFhbBvQdtXvsXQkYXztOZvvOh9PjZtNmAi+XenE3uqVw07sT6DzUVeBgnqJRFotS5iMoEbkuGfdzJMDQxfqeioEl0jWZUU6KZn40FAYwk54iYaUfUvZUwurRa1TMkFPWm0gecSXMY9hV3f7QDVq69MmtIX5EnUfFE3qD+ggEdiY61krcsow7ap9Gg0atOf1QzVlRH6/DEt+gdjKprUqoHVPEGJYdb4Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsZDGN7bn2cBqZgQvSIlBawDM7Jqd1W/v5KFP5xr9oo=;
 b=FPcikJCFNuFygcXQrRjrSV9GKH3f7k2Xvmy5lbqChU0X0MMjI0+B/GZEgXTGeacmy0MImGwNtYaYlIv2i8xq474NeKgg/ssOoNpfFXLIlzoBaGS5gTk0/dZiRehIwYGvwheAXLQc47CCLb05pARcXciBsbqKW+3jkEbdl1BGLUk=
Received: from BN9PR03CA0869.namprd03.prod.outlook.com (2603:10b6:408:13d::34)
 by SA0PR10MB6426.namprd10.prod.outlook.com (2603:10b6:806:2c0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 08:46:24 +0000
Received: from BL02EPF00029927.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::a8) by BN9PR03CA0869.outlook.office365.com
 (2603:10b6:408:13d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 08:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF00029927.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 08:46:22 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:48 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 22 Sep
 2026 03:45:48 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 22 Sep 2026 03:45:48 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 68M8jaFL3813357; Tue, 22 Sep 2026 03:45:45 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v7 2/7] arm: dts: k3-{j721s2/j722s/j784s4}-binman: Add
 template for packing HSM firmware
Date: Tue, 22 Sep 2026 14:15:31 +0530
Message-ID: <20260922084536.2477291-3-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260922084536.2477291-1-b-padhi@ti.com>
References: <20260922084536.2477291-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029927:EE_|SA0PR10MB6426:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e9769d-d1f6-457a-09a4-08df1885fb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|13003099007|6133799003|10067099003|56012099006|10063799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rXGnJySmlRtpQ/nUcQ+uirNV3PxVQGsm/KPpplcZYDFOxRJ3o+jWkQbmp4qh8ZG3pNarrRcnAVdNaDy9XPNtas4VhaL1NC3ec69kVxyT+cgCeCvbx9E5bVURu1Ln9wsbqkSSNRN0w96uru2DIApNMM/4r+6LGx8QKEfWyS5wLyHhjQUVO1u8EZYSpl0h13KX6kAVMkCvV9F4ydEP/KKvYTBz6flcqZisdgSHEw7eOo1nbUPNHavlVaOrHRGok76cAcBcNAbg4csWj3W8f1OykIqKiVR/qOx8aiCaNtxFcSvCyOZCsS03KsNFIW5VUMOZ5nXTdHjWXMvDBS5FlETOPdSxvKZVKZXwLZKw+hJCH+U/J5dmKk7ZoV2a86QvM9fmoJQ3OF6HTbJwRQ/V+W3yUV4uA1qTQLEdZh/R28KAk2huZSoRr/TnvENFrdNdOOu9ayc4tg6Zs08DDzhCf93A+XDvotBTti2KOg+cPASAdt7dV3xbOrADI8orJbM3q4KBGUia+PGROLmNoF9KtB9qxiJLIuGQqNr4aNcnewFy8q6VwYnbVXSHXxh+00E32z8F8+XphFfK+O1N/qi59KBRMTgsR9dyTxcbUDaER0qt2B0VJa57tLhvncZyML1F4pgP1LquFgiiczYzg2xvQu0SkFy7hG/BrvyXs7e5pGJlm6I=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(13003099007)(6133799003)(10067099003)(56012099006)(10063799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3qNDV1PYwWJnMDUFYxCmAtKWcUjzZQP3zW+OXpcLKE0aLgQuybtdq5sj013Tr1e0j9PV/RrQfEorC0IgJYsTgD6Cpttx+DYHz7kF/Mx+BbJtkiTau0Q764krYQmMMBBcJP98PNp7H3gqrY0DRErIRn4DbCFLK3RsNzmbHtLCJQQ8IV4ldRL/sSLaQUvAI8JDE53+Px5HoyUAzKMsSGPpBWooEB8Sr6AZttAeVcBfy92Ru5ongfBRo9W9IkEFlAzYSeep917okIca3YLj469X846EyXGAUcLsWxCjF4UKyWGrY4SZBL+APh5EWn8MeX5kQr9ZZgrS2AioxR3xxOCvSgUd9E7ULFUY0VqGgylrvCZzLT65b7MJnheoZUih6d6RHoURlZOCAJ3EQx2IM2eb5VRyck2xRUJtd1D7PnvgKiQi3egyOds3MUu8lAw2SRBp
X-Exchange-RoutingPolicyChecked: 0Zb9gwdbGtPqsddQ4aSBwaPGgile1LLretmVVTKc5bojJXj/qW1aZKztF2OeCjBmSMoy4g1yRC5H9Dr3vE+ZXTIWyfSkrGScW8wiW5Gd7obaWHokc3bO4UbF1+4inknOUaRSl4KdTHv0NvwXIinZOQ/qVXQ9CTjcG70LfjPKslAUL7yF8/X4FRTEZtvBricI9U7y9wvwAql7U2YS2WIdmJGrFTYHyr+ugXN2bH7FX2mP1xGMyyQpuPNN1sr3CmuNk9Lx/mQv85QxInXFNsgoYa0I77OzhFqJNkoQhYJyELrBP1O4jo3FIr727z/r9IiXnW4wz5RabLbcSNVpUFvH9Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:46:22.9874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e9769d-d1f6-457a-09a4-08df1885fb05
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029927.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR10MB6426
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfXxHUKxDJReXRi
 I29+XdLEU9QjpZS4kqMVj1LHjpBNqjEhWoZHvaG5EOKMXnfiWYDATlT4CoaR9F1gjlc5e+QhZ7f
 SL6OhGdIKes5pXOU2TI5dQ+v3J4jKpu2F3gTNGfvlbrgjJ9Mqxt6xfSTGh6tM4J+dhJboNcIkoc
 AnYkleY3d4kbPkPD93ftAJDzT1qaNflaiq9FsX/xg7s7VhyP8GS1vvV8YjsPWBYMnHZLS/cJXXq
 2TYzFrkzG39gZpAwkG0Zup7mXhsy8ciBw7cBIPPso/uwM+pWOPNzDN63fA342VdcvZZ/HmlVo9N
 olKaf1VNt/P4CBwI6VE0Xqg0a5l/bCN5RqprBV7iyoaJ7kzCOhPQGFRkeT1jlzylFnj1z4FDKXc
 wlQkQ2pqzW8y2hlRuGRuTFbgabVU3GH1j5a1otZIQU19iq7QIqMoktfP157I4uWhVM3KfFjTPq3
 /5YvInKgvPWQG4KAvOg==
X-Proofpoint-ORIG-GUID: CqCV7LBC3ZsdGyeloKBpsXongN6QNDh6
X-Proofpoint-GUID: CqCV7LBC3ZsdGyeloKBpsXongN6QNDh6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyNCBTYWx0ZWRfX/lROEkIm4SL4
 NaA4MGlH7T8YS117OfHFNPdB/CYU3U6YjGtGOTMJStrOJHBhD5+T6slAotL8YMoFjo1gN8Z1FOe
 rtY3jV92MfB+J+pZya4A4I/5IN4+EjU=
X-Authority-Analysis: v=2.4 cv=Mdz5KJ/f c=1 sm=1 tr=0 ts=6ab24064 cx=c_pps
 a=lexSm1xfraBw67q2grWtcw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=voM4FWlXAAAA:8 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8
 a=FXiWu2nYAaGsj2XNjoMA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220124
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

The HSM M4 core needs to be booted at R5 SPL stage so that it can be
used for further Authentication and security services. Therefore, the
firmware for the HSM core needs to be packed in tispl.bin fit image so
that it can be used by R5 SPL to boot the HSM core. By default, point to
the firmware for HS-SE device type. This needs to be changed to point to
appropriate firmware when using a different device type.

Add a template for packing the HSM firmware in tispl.bin. The template
also contains necessary fields which will be populated in the boot
extension and load extension in the x509 certificate for HSM firmware.
This is required as the HSM firmware needs to be signed before invoking
TIFS to authenticate and load the blob to HSM core.

Note: The os = "hsm" property is matched against
image_os_match[IMAGE_ID_HSM] in arch/arm/mach-k3/r5/common.c during
post-processing. This string must be kept consistent between the device
tree and code, as changing it will break the image identification logic.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v7: Changelog:
1. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-3-b-padhi@ti.com/

v6: Changelog:
1. None

Link to v5:
https://lore.kernel.org/all/20260720080114.775206-4-b-padhi@ti.com/

v5: Changelog:
1. Squash [PATCH v4 05/11] and [PATCH v4 06/11] into [PATCH v5 3/7] for
bisectability.
2. Use hyphens in DT property names.
3. Update commit message to call out os = "hsm" matching criteria.
4. Add comments explaining DT property values and add link to ti-sci
documentation.
5. Use whitespaces consistently.
6. Add R/B tags.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-6-b-padhi@ti.com/

v4: Changelog:
1. Changed phandle from hsm to hsm_fw in 'content' field to match with
   node label.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-6-b-padhi@ti.com/

v3: Changelog:
1. Added ti-secure node for signing hsm firmware image in U-Boot.

Link to v2:
https://lore.kernel.org/all/20250506104202.16741-4-b-padhi@ti.com/

v2: Changelog:
1. Got rid of 'load' and 'entry' properties. Rely on U-Boot to set it.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-3-b-padhi@ti.com/

 arch/arm/dts/k3-binman.dtsi        | 26 ++++++++++++++++++++++++++
 arch/arm/dts/k3-j721s2-binman.dtsi | 12 ++++++++++++
 arch/arm/dts/k3-j722s-binman.dtsi  | 12 ++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi | 12 ++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..af752619255 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -297,6 +297,32 @@
 					};
 				};
 
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					description = "HSM binary";
+					type = "standalone";
+					compression = "none";
+					os = "hsm";
+					load = <CONFIG_K3_HSM_LOAD_ADDR>;
+
+					ti-secure {
+						/*
+						 * HSM (Hardware Security Module) core boot configuration.
+						 * Refer to TIFS Boot Extension format specification:
+						 * https://software-dl.ti.com/tisci/esd/latest/2_tisci_msgs/security/sec_cert_format.html#sysfw-boot-ext
+						 */
+						content = <&hsm_fw>;
+						keyfile = "custMpk.pem";
+						proc-id = <0x80>;      /* HSM core processor ID */
+						flags-set = <0x04>;    /* Bit 2: Release processor from reset */
+						flags-clr = <0x00>;    /* No flags to clear */
+						reset-vector = <0x00>; /* HSM starts execution from address 0x0 */
+						dest-addr = <0x43c00000>; /* Load address: HSM SRAM base */
+						auth-type = <0xfd00>;  /* Upper byte 0xfd: HSM host ID, lower byte 0x00: Copy to dest-addr */
+					};
+				};
+#endif
+
 				dm {
 					description = "DM binary";
 					type = "firmware";
diff --git a/arch/arm/dts/k3-j721s2-binman.dtsi b/arch/arm/dts/k3-j721s2-binman.dtsi
index f79b3e543ae..2b36b04965e 100644
--- a/arch/arm/dts/k3-j721s2-binman.dtsi
+++ b/arch/arm/dts/k3-j721s2-binman.dtsi
@@ -268,6 +268,14 @@
 
 					};
 				};
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j721s2-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -300,7 +308,11 @@
 				conf-0 {
 					description = "k3-j721s2-common-proc-board";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j722s-binman.dtsi b/arch/arm/dts/k3-j722s-binman.dtsi
index 278b7bfac7f..3834d081c30 100644
--- a/arch/arm/dts/k3-j722s-binman.dtsi
+++ b/arch/arm/dts/k3-j722s-binman.dtsi
@@ -117,6 +117,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j722s-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -153,7 +161,11 @@
 				conf-0 {
 					description = "k3-j722s-evm";
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..ac12335a84c 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -154,6 +154,14 @@
 
 		fit {
 			images {
+#ifdef CONFIG_K3_HSM_FW
+				hsm {
+					hsm_fw: blob-ext {
+						filename = "ti-hsm/hsm-demo-firmware-j784s4-hs.bin";
+					};
+				};
+#endif
+
 				dm {
 					ti-secure {
 						content = <&dm>;
@@ -188,7 +196,11 @@
 				conf-0 {
 					description = BOARD_DESCRIPTION;
 					firmware = "atf";
+#ifdef CONFIG_K3_HSM_FW
+					loadables = "hsm", "tee", "dm", "spl";
+#else
 					loadables = "tee", "dm", "spl";
+#endif
 					fdt = "fdt-0";
 				};
 			};
-- 
2.34.1


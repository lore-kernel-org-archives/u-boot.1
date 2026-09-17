Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48060C88E72
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 12:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 115D480FA3;
	Thu, 17 Sep 2026 12:38:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a1E8ph0yquVN; Thu, 17 Sep 2026 12:38:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 647F180FA9
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789648714;
	b=sIKXrKvVXsjzy1RLoQLmZy1bBYYzz3GnkpKAm2ltFE86xHAO7YrRHjEjRUMH5oXEKdqc
	 EGiNcTzY5V0cBVaFM9VdJMEH/gWTez87Vov6c4LAKeb/wEx6Vje9N0e5zIdioLkH/kf+9
	 mClMo6IuulqZC4xbzZuq2zzI9vOC9UVvGFainjq9h9OiCCmvdDpymx3R93GCjSS9zJx3u
	 TjIKkLirjqmdiQHDzYdbTnCZFG0KrEK+dTC53oUBjJqXRdfZWrNLiRqtUVh3gsIDiI9JK
	 GlHDGa2LBfHqMBOvgoXSgbtg5opquxjSDtA/OFQXiH/hu5S5+CMWr4UbId1DYXM3xNg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789648714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8OwEBLiLKGgOvOrZY1pQgtiWHGIMdfivFVQbhReurKY=;
	b=dSD37i0pIemW8ThbotCggdOrJjSxYhcqfsa2q6PwqhmHdXCYQ0yQae4KgQd2NRYcI70r
	 zwsoSLk692RfYVsFOjwfa4tF+x0/vNk3kfxSOer1FGi0s7GEHwDeXkzwj6LX8hvBkvkef
	 1cHkYqgGHeeEhHCrOIFDIJEn2Tu+nxAMaIOYNNDi/DmiHWa7GHTTmY2p7ez/UawwGbI6n
	 VdDIiiA44DU5dWCETa7tk93WMrG5aANrB+sK8qf2x6QdRird/dXXAjBsJrd24sO52XwVM
	 SNXv5HH+xEHdaiDU+X4rpmSVDqeOG6E5Oqa8o8vFe9NjnOiT4pHByZwuNOq6GCJi6vw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789648714;
	bh=8OwEBLiLKGgOvOrZY1pQgtiWHGIMdfivFVQbhReurKY=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vvpRPKSzag+Mkf0ZNqCDtL3qJ/L+J4olyIPgP/3pZV/xFpioO4KSJpN0YZXW7AuDy
	 tbasseLXXm2ZZ9QPaKKXr0B+pSESa5Eegjb250ipg4tC8VfaeKMoDZ2C4Ts70CQuPi
	 PxI9MBNEFB8xjKOfOtgelKLrTmHu06X1LLQRAJvLSjRY+nu6f40zJwCI/Kijg90haQ
	 a/+aZSe0+GQMkKyuliGlHveYeoZbpTm61bxCWvN4ieFgRRVmaAbK38UnYdEz4gkWWX
	 9nDhS+xUCMee3ieTKBxVRgMQNUX4AkSFiJvd+XQaTgBzBXzThxzDYqMQLIh5Hqj0CH
	 qHP4QjaLpKXOg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 647F180FA9;
	Thu, 17 Sep 2026 12:38:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1349929B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EE725407C8
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:38:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dSgxgHKvpVP8 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 12:38:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A4C4B407C6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789648712;
 b=ETU+BxlLCAviYw+TLEd8NRReLzkroy5Nm0iv4QKV2zvxmD+onNAhz05rYn9VQ1INvgeA
 hUKtpZNV355bBDcY/vicZOG2Ym7dnsOcQAAWzJcox06LLz52Z6bczfMoyECMc0Fu7vptY
 IQ8XzrsPYOplfF1fwfbt0pWeKbkcWJJdCRO++PryRAtrLwQwZe6HjbhMxvG/JN5m/oKjc
 QZkOKFgpnpCsWIhgJHi4GWVcUbfgoztnvURJ8DPBvf7t/vcyaGC0fO2QvAT+EhLMFq+3d
 QeocHN5+C3rGKk01/w94L/j22XPGZ5+UoDrp3RTLauUx7Cbpx3ZDSbU0SecyGdbdPvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789648712;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=8OwEBLiLKGgOvOrZY1pQgtiWHGIMdfivFVQbhReurKY=;
 b=JfTFQeSy61yRBFJjCbtGK3FeZQytDafMq7lXXiSLeqi8fqgdMKgKejr2sPTnU59iSXsQ
 8xJbstFM5XLyhr+wsdUKoop2rxcClKO/ABVG51nrG+UWLhWxmQkdbezHiGLWqNqdkBPBn
 Ubl4I5vUB6wNr08a7Om+Yiz5KiS+CdrgsFVwD6JCfYiL010PAyH/uPMj3kp+FtGx0sGz1
 YjNg3RV8+lnxmpmgLaXUZBY5NDEJveb6hAHqc0LtfHfiXAxNWbi60j8gl/MW5gOMgl5ol
 PmPHXPvLeO+kSdRHO3zBs0G4+EywhMcpplmCIpkZxJwahnQ05zvMtmlOHIqZV4VshlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=hC9uhZIt; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="Bx/VeRYw"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hC9uhZIt; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Bx/VeRYw
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A4C4B407C6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 12:38:30 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68H9amv72703955;
 Thu, 17 Sep 2026 07:38:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=8OwEBLiLKGgOvOrZY1pQgtiWHGIMdfivFVQbhReur
 KY=; b=hC9uhZItroZWxnJYGCuxXTki5zWOTJZyrVmcg3SSwrIKywe2v2VU7I/SI
 oNTtJtp9SqM54puA7qAzj1HuHqzAGp1MpgFMByeOJ8zwFwl00bAFolh4d/YQkzwb
 Di3l4kNIM2RzH5od+Oq/gY9wAeb0T02kLk7hR0BEv5ZR6uEBpD2B6FdBbzdmZ+0B
 1z3vSzQgRuHAw9ZD8DZKPPAMhg1yQa7AHF/j92dGFz5WcQx0BjOLOoHmsyuaZiag
 XJgQ6RNOzyncbwwIsXQ7bJwp+wrbCbpz4b7JsI3DsiarfmK90h2OVI+vgwDyYmTt
 02CIPUIf/iy8L+oj63/vw4iT2pMTA==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010069.outbound.protection.outlook.com [52.101.85.69])
 by m0384305.ppops.net (PPS) with ESMTPS id 4gqxfpey9y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 17 Sep 2026 07:38:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oF/KcjWXEAz5gr1LSg44Vf5N3qksW+DxHuw39Libc02GzLWwt3bkBsiWWf5hfGih5nXaF4LJ4PmI2kIJ0/S0VZ6R9k8hAIQiJ+ABBJ6mToC0woCPgYPUJ3N1BRfF3tkJPA/tBevAmK0NQkeNKIOID0Aaz4qZUmUhxqbtrugAaru9uDgC9hn1zX+mBfV/d/Np1RFHpwdiNv1W4yqwnBIQ4tj/f6N7kh/ZXBZ5UbhZDf6wTLh6L+8MJphtLYNT1hsC6Zy3ywqweuN6opOJLiLC+j8MYZVIOEVtNyOzemSyzbxdTgVtMQcOx65ZXZvacwu/JC1MV2tYvE4FF+FdUJ/pTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OwEBLiLKGgOvOrZY1pQgtiWHGIMdfivFVQbhReurKY=;
 b=PBy0i3UM37fr4z9Oz2unt8gbNzcpa9yfx2vCMF87Se26EMJXpc0tMIipNSRzEgPqgE9g5unAHlLuaMQbygQAqqB5BXt+fFhXnQhIpPHhirqC2bR8c5kJ+gJ1aFfii0J2+LsgKmLxHmg61LNqGV+2bJmPCvD6/bvnqgga7zv5sGzYD5+VYymT56x6I4FnsxmZWzbPa5Tm6Fu0HtlJGLi40/EmGri/q6D/g/Sp8aW9hy6aZnfHB02xCPt6CSpxytHImzLPnPDI0DnF5vevHBxalyxvJouXge4Dhc/uBlvdvlFGiQl3T0dgF+uKSaiCHK6njs97vIbVUyogGcG6TSAqYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=amd.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OwEBLiLKGgOvOrZY1pQgtiWHGIMdfivFVQbhReurKY=;
 b=Bx/VeRYw77Epuh7BRR4T96W4neIHPxE+wkhIjPnCLqdYZM4DOlMpkwFjfV8UH6+l3KyP0Ksuv5W4lp8dzwbqsae1k9TDqhbt26YDYFvP5MSbyuP/ini6RCGaK4CJCkONLDjlav6WAqe1t8v8dlqA3IEfY+mYNmc0wfdRkkF2DlM=
Received: from PH8P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::12)
 by DM4PR10MB6087.namprd10.prod.outlook.com (2603:10b6:8:bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 12:38:10 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:510:345:cafe::38) by PH8P220CA0020.outlook.office365.com
 (2603:10b6:510:345::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 12:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 12:38:07 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 07:37:36 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 17 Sep
 2026 07:37:36 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 17 Sep 2026 07:37:35 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68HCbYAH2994784;
 Thu, 17 Sep 2026 07:37:35 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v7 00/63] usb: dwc3: part 1, reset and import from
 Linux v6.16
From: Anshul Dalal <anshuld@ti.com>
To: Anders Roxell <anders.roxell@linaro.org>
CC: <u-boot@lists.u-boot-project.org>, <marek.vasut@mailbox.org>,
 <trini@konsulko.com>, <ilias.apalodimas@linaro.org>,
 <michal.simek@amd.com>, <lukma@denx.de>, <alchark@flipper.net>,
 <jerome.forissier@arm.com>
In-Reply-To: <20260824152734.159794-1-anders.roxell@linaro.org>
References: <20260824152734.159794-1-anders.roxell@linaro.org>
Date: Thu, 17 Sep 2026 18:07:32 +0530
Message-ID: <178964865295.1260567.14405867032760835467.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789648654; l=675;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=jcRZvIjdd9oRY8gk8CTAO0l+NepCA4HSXZ/wzr8THqY=;
 b=MiIfnrkH+XsUfsFjfdnTPcbndWG/PnDDXXQpripyCpaWQG7tWau61t2guSceturrbqdVJk14F
 GBKJvrIPD8QDmoBVNBKBYWcgcCPrkXMCBINJhwYkSgPAalbSUhR4nCp
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 11b6e6cc-825f-4ff6-c685-08df14b886a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 5hzowrK2BuEBXZ8VlbNkqz1mRte2YyvWUgcRAxi4Z+Tz37KdRGu2LGQEK7lS229+3WJik+GhEf1Y5hwZCV7x2xRU/fP/S4h9VtJsaQxHpjD6cpB6C5hW743dPNn+aKujGa2IqaXK3uVdhHxjeKwh0/FCJ++1Bzx3ky0W+bZHoKU7TLO6RxX5P00CnCzp0m5QGx9vsr5RY6CzheOT9hukICIGhk9RXTrLza8K679myBwVcVKUyZhTIpBtmWZhWM1DrNkLUvfUmwhBxPzrAP4S8ksEYLGGxGLAAG/c8nMrrnfsYY6oUtyuw9PQAZwLyMTgbEFhY5MwVQiDns/C9Qj1CHaOuhQbJmLsb5ULlt5csQYmtVWUJF5FkdU+1XAh5uYZhpnxYbTekhSLAG2Y/NJBYqHAOXQZxYs2DVkZ5NCEUobs8N7XSwMdSuBRCVsfAo/ycOuIlMlK8pK3kmVJDQHT+ThEE0sWM6w7lX/+dinmCkfRvxgeKIrn7gsgXZ8HJQUd6xCWRHuZG+jaHeHOFkoXto6MoxIFr/PiRWEqUPcju2RbvcmzV6suteip69/d+WQzW4/3IY6llpfomLe0/lFU+91RB+0G7Bk6HM38AxlCo/Agy0OVxb+plvJfcVhJCsXY8SKpa4/dHaJIcCclAYh1XEEQJtBuv7fHcanxwZHVxqjTXYknKQW5n8zKBPeRgXHx2F3Nx5jdCsGWDwj5toctyw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: SIoCTH+lVfe12qz3mBypiWvPPLFKWFsUKCvxAFHFHu6zJsXOp1Zl280f+tHaXODCD6umRz3JSFZj6eqdpjhyCwurs9PUgm0jCkIlfDg4lw+pcFKWxYMMwl/p5xwaYlQNeamy69ewHnBD6D3/3gYe7bSQeQ56552/13ayR/AVwcb53GeGzNmameI7Sbbvbk5iCCBo3dcExasoRrCOxbBWj8vjdTKAID9Ip2VPyvwFpm91LHRNkpqAopJRW892Z+Id9aDw17kcN6t8IiuG0nC8szYxQQvTg1G7fsoK1SeAvc1vhIjbjURMq2zQQHk28i0ct2iQH883tNm/+J6pDWGgO4FahF6fwsKzH2+RFrxa7ggMX6koZ293PwA93eheAZ0jxQXJsLsdTdfVcQWz8mBaP96r/S59LAryRH/NJyNkxZ4kybPux79f9VurdZn93xxR
X-Exchange-RoutingPolicyChecked: qgcaBgC+eWCIzGevqeoc6WYnfMMPyfsYxBNGiWGBaSAnzgNZwSh1EIilG6SK37MKED7QiAsa5oPHDL71ooluSbW1aAJPYj4XD1VNjTnaZ5FCEDV19jkQaOrwmx8ywWUla5TxA0vKEVPNAPZpQIZJUvPrRkq0k7I9WxR1sEP+i8wzfhNGTeta9xYfCb/k4JGhzb3Sq2CE0IY+J3vlmx6X5WsNa3YQkGVGlvx4r6Uq7V7fPlcTeyHgf8vF4JuLeA1NbAVckS5mAJ+PDqg/PzQJj78DTZFgIPPKsF5UqzpPruil5UoGDfEUqLMET9xuphlL4O7NOV5kO0kQs/q86mUEmw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 12:38:07.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11b6e6cc-825f-4ff6-c685-08df14b886a4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDE3NiBTYWx0ZWRfX9LpBMWpNny6k
 Y4SFpCdrnjXQgcUFWT+drPZ0hWnWaTIi6Z+hg57gJwEO2rpOOor0w/eB87M7n/tjNsX6E4W2LsN
 IXHetSVgVHq+QKF9ktKnZcz2wl8tjeE=
X-Authority-Analysis: v=2.4 cv=HaWB3SE8 c=1 sm=1 tr=0 ts=6aabdf36 cx=c_pps
 a=uhkaN0mRh0u8fl/99TXUBg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=KKAkSRfTAAAA:8 a=sozttTNsAAAA:8
 a=sv02Pls26bu8p2ibXnAA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: N3OA6N1QOV_KrC6eHL8fvys2V7FOpYtQ
X-Proofpoint-ORIG-GUID: N3OA6N1QOV_KrC6eHL8fvys2V7FOpYtQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDE3NiBTYWx0ZWRfX9BiscC1e5RFQ
 mzSjL46mnATqRLnaJY5RTECH0uJWTBnUyiRCjL9InZUsYJQ/k1X6jhSSJZf1YSyzKq1ri7EEFeD
 qubBodA3ZJE1f/M3DFKp0NnchqFOMJ6d7vWiXTmaBLVKgJZL3EDz7MolDZzxef1p3nluQqErZ74
 GwmlBlSFK6Ece64coJabujGXkx1ZXsPND6VWNIkvzEyfPJiOf9h6TAROaJuNRaIsavwzgi7zKcO
 ag8EMNjnc2UbaIDVhmIhPPvhNQiR66H22IlG74xn2rdbVlhEcAJ5gM/RC6KsajHWMUzM2aIoCiI
 jvjQmB8pe8T9xNb1NKnL5RBH+9ZukPBQJZbRSlTcP7TQPSL52+nioazW+imWMBjrKu+HGxF7ABm
 CXmon1LzJcdXrNMaaD5rbbdiEkbpuQGqSLXZZa4geaw8KswXGaqJMPvEgiMi25qYBBs3H3ZlBlc
 v2m4szFFSfcwz8WDKbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609170176
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

On Mon, 24 Aug 2026 17:26:31 +0200, Anders Roxell <anders.roxell@linaro.org> wrote:
> [...]
> The import commits are raw kernel snapshots. This is on purpose. It
> makes it easy to see what comes from which kernel version, and to
> compare each import with the matching kernel release. The commit
> messages say this too.
> 
> The branch has both parts [2].

Thanks for the work Anders, I have verfieid this series to be functional on TI's
AM62p-EVM. Although it doesn't apply cleanly on next, so I instead tested on main.

Could you send the series rebased on next? I'd be happy to give my Tested-by :)

Regards,
Anshul

-- 
Anshul Dalal <anshuld@ti.com>

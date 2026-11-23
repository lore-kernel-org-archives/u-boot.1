Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE27606A31E
	for <u-boot@archiver.kernel.org>; Mon, 23 Nov 2026 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kA7GShI/;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Df/sOZEx;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=dqsxytle
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8709680AED;
	Mon, 23 Nov 2026 23:53:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5w-uy-lPObM; Mon, 23 Nov 2026 23:53:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5E613809F6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795478018;
	b=LSMJHPHpq0oBVo+wmROtmO3rgB7zeifktv4KpwGoNs3ATf2cguvpd8wNZeoRjur4C6yY
	 hW/43T8iBYhKROJ7yop04kMxja1FFXhtbAmgnGluZh1IjKRWJRU1357XmFZnwCSaGyr8c
	 OXVYgcjWb+d0TZFNx8PDv2YsAiq+Lf0eWhCsOrakjma//rN8C4lHxlGvrZDAqLnG+DM8W
	 h/rdJ17ZO8Er2JguDYAK456wLa0cGHLbB2ld7FfN3EQ7emPXOQUgD7zkZWCdJF4XIGLCf
	 azB5EwwZpAhk/gQYIC4V8w+7S/o+c5vU+pKNXaVcaIsfAjKgnlh6B757vJOSdZYqlfw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795478018;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eTnYnwHmrJj7+ajXVwfD/3Z7BUoem+wzqr37ZLxcoEw=;
	b=SJ9ox5zOq88thEnQ0M/KHF+IelPb9GVum3mNWaQPItzbX/5cFt7kKzCQDl7WN/Lk10nO
	 a/lhg/IXuI0Z0l3Fjl0YsBp2IoV/e1PeN6ZdG/sEWVM9+AxkQoSjH5JuNjdAInTpXcQ7T
	 y697aspZEShQSgVu8kEOGrhGByzMOc0h0xcMto5d4vIJcDZ4gJY8OKFcMtoxV/oM12dXJ
	 8tOaUoB8mKgrTT0WPA90kLUsOe6P6B/9hyJVc50FTQmBF8RwBlG9npVypU8Jl84E3mAC4
	 zzRSODCaJGzuWaBrYxwjlVpuBtLvVG+7lmu5PapisJs58i7y9s9BDvo7DWpQUm8KgAA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795478018;
	bh=eTnYnwHmrJj7+ajXVwfD/3Z7BUoem+wzqr37ZLxcoEw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kA7GShI/Bdz/uLu+6xolxJFsPkjxVzY+9X14vikw/6ODUMfvFjXv+l4PuYfp9eAng
	 edRzWbdRDGaSxmqTWfDyhx7qUm71dygFPcL2sCu9UrrkJBBxU5iENEVvkG/PxdH2m/
	 Ec8YiLDdSUDwlqXQBbTv+CqY4t4qeqRcLmyA/NjyMAGsED6qJYdvONYfBhFcZryrIH
	 9kliZ6uadSqg2NnAFloM1Sjzx3jM2DyewBlzNhG6v4/QvRUVRTT1WbiXfllTDXsPQi
	 uKR5dA9SmCz1Edu4ctpnYBJFIpcQBuwRhYRehZCMeNhU8ewtLMHuprAzekH42KztdA
	 XUzO8H0TDn9EQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E613809F6;
	Mon, 23 Nov 2026 23:53:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 24C5F22B
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:53:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0D0A8405B6
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:53:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id he3DIq4rWWw1 for <u-boot@lists.u-boot-project.org>;
 Mon, 23 Nov 2026 23:53:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 57782405AC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Df/sOZEx; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=dqsxytle
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 57782405AC
 for <u-boot@lists.u-boot-project.org>; Mon, 23 Nov 2026 23:53:33 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6ANNSAFx929791;
 Mon, 23 Nov 2026 17:53:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=eTnYnwHmrJj7+ajXVwfD/3Z7BUoem+wzqr37ZLxco
 Ew=; b=Df/sOZExs4eZkB26VXBLgTsLJ31mCdMPpCCWIqX2JR54CBBcapFYQRRS4
 dSsI8ad+jZtRC3UADtf+3k+zaR5ZSZ9/RWZGfTVuypKY7SWS4M/uMN9lE6xtYOlZ
 s5Kbht2k8oMM9BqD9tiPjb6uHM9MssqrfCAxq88qKWmXBLBmxsYSOyEz6MXreXAi
 mgnhhb3V3Z/hfHEF76g/vyb0Ev9LyU+0UjtWLxJCq06M4S4Oxz+rXRfNE1C/NvcF
 FfU0ihZB9VmpPEVgidT516eRuGbT113BEAyjBqfAu6Gkj72w1NOBiMUPd3fzCWPN
 BIcTCvkVPacqglaQROLykss61Bitg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
 by m0384305.ppops.net (PPS) with ESMTPS id 4j3x4sherj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 17:53:30 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTnYnwHmrJj7+ajXVwfD/3Z7BUoem+wzqr37ZLxcoEw=;
 b=dqsxytleJuV3m0syd0AfBfxVgTKtscQhgeUV1KL3AhvrX6Jj0qfnU8/YOYYWuX4RUQs889A7kyF7si7VmR/iLj4xgcrzWDLsqBl3mS2MbQeyK1BeyALiB00LrzCokgM4+iMoaXHS9AG1Cf6R8AMXeElMxOa2jJuGUEnzXV/9ycM=
Received: from CY8PR12CA0048.namprd12.prod.outlook.com (2603:10b6:930:49::11)
 by PH8PR10MB6526.namprd10.prod.outlook.com (2603:10b6:510:22a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 23:53:26 +0000
Received: from CY5PEPF00000E88.namprd05.prod.outlook.com
 (2603:10b6:930:49:cafe::59) by CY8PR12CA0048.outlook.office365.com
 (2603:10b6:930:49::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 23:53:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 CY5PEPF00000E88.mail.protection.outlook.com (10.167.247.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Mon, 23 Nov 2026 23:53:26 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 17:53:24 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 17:53:23 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 17:53:23 -0600
Received: from [10.249.33.32] ([10.249.33.32])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6ANNrNBe441654;
 Mon, 23 Nov 2026 17:53:23 -0600
Message-ID: <393d5623-1e67-493c-9af6-dc9f1056e660@ti.com>
Date: Mon, 23 Nov 2026 17:53:23 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm: dts: k3-am67a-r5-beagley-ai: Switch to
 k3-j722s-r5.dtsi
To: Francesco Valla <francesco@valla.it>, Nishanth Menon <nm@ti.com>, "Robert
 Nelson" <robertcnelson@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Vaishnav Achath <vaishnav.a@ti.com>, "Jayesh
 Choudhary" <j-choudhary@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Beleswar Padhi <b-padhi@ti.com>, Anshul Dalal <anshuld@ti.com>,
 Chintan Vankar <c-vankar@ti.com>
References: <20261124-am67a-j722s-unify-v1-0-19a83f16d38a@valla.it>
 <20261124-am67a-j722s-unify-v1-1-19a83f16d38a@valla.it>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261124-am67a-j722s-unify-v1-1-19a83f16d38a@valla.it>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E88:EE_|PH8PR10MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d59b701-e507-438f-42a1-08df49bcf790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|18002099003|22082099003|3023799007|13003099007|260925021311599003|260925022911599003|56012099006|260925021911599003|4143699003|261026121527099003|261028144727099003|261009223027099003|261022113327099003|261021123027099003|261022105027099003|261026140227099003|261021121427099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: pQJfHPNduNrKOXc6pFsgSK9PHKLgu0opt7r0L3qNUOrrGaUz+0V2zgpYcVUbbFLpHhcZkn33q4MOxK1ZAHOB61Bk1tYsXyi1C1KV/xcdCw9bggLQsPM+l43FML+VOva7ztvkAXVn5uQ7YFcDchxqX7uDL10CdgGMa5tfsJfZaODEiK1LXlc2ANUuN5v0UKlapRKuZv9YIQrvIuXR7lYbVXSRTYuSleF+nUWszPBrmOxGvEpMCK08fpzxvo80vVKOt3pILc+hoiS3VImjbtLDzuVSXvIEsdg5J5Pa5RK2hVWu3JLl4Sdb3iR6SbiOTq4c1Meecr5DsmDA2VZD2HMVwIg8n2NxI7WDoAqXJfpPmJmuLhpiQ6d+8vnXov06dpLS5RJKkcOcNeNnwwp1+aCgz00iTrzch8bc5+vesPfoJcjuBoVa0f5c0ja1FbkZZPBUdHenxvgjR21zynmmWMCU/eTqc1cZrVhYoo1XIev3LNmkNgk6Fqe/j4LXxFCxx9Km2eCk8VbYvHQD9ntlsKXfupkxjSb5PkGEeYGfQQwTzqyDAA1CRHNHQ/SrueJa7qYuDZaqesJJabJayXZ6Ql0ZciPHuFCyVUC/dX+HKYU+AAl58PMSNUCVjxtEYzipujti5KwnrF7WSQcWlZ6wEDWqiA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(3023799007)(13003099007)(260925021311599003)(260925022911599003)(56012099006)(260925021911599003)(4143699003)(261026121527099003)(261028144727099003)(261009223027099003)(261022113327099003)(261021123027099003)(261022105027099003)(261026140227099003)(261021121427099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7OK609lCC6tP6voGg8xjO/p9R9eHVpKY0a+v6cMRjs5tWa/sPGjn5EwmfPF0ah69zxf6plFVR8KVYt0MxAXNVjws1HX6mefaPZQvfZazM6ZcgZDrJ4sJkV0Y7xPEApX3NNZOeahgFA//I9iC99UU3Uye73lh2HuYRM7o5aODMY6CtHxFuc/QxgDwrJVl8MlO3xX/Qwx/jmJ92dIUbtQw9IGaScsFsuKUPsgQB55YUJ57OtfIsce4ZTCEA1MKkfAS7Uf/3bF4Ldt201Dh4C+/zL+XWL2+rUzCPdDbzR8IC5YafShVuISlILBjdp07CAnPClRBJEeBDXrUQ7BvoRheiUSOUXfQlVKIdiexGLDcvAYqVeL/BC6wqu8ZJLPiY4OBDiHpN5eI/eHmloWFsErg/rl6T4E4iCsxyfEqEbXx6E8fjevFXn3Vto3xfhth9lon
X-Exchange-RoutingPolicyChecked: JUU9PSHL3Dd1LNQdCx1R3oR3lQioYdXNfovChxI5G88p+ANp+FfbdoMdi2iDdrTTPOjOjUpahrjABaLt3/8rBJLABKXiEjsF1JSCBwiNzAqp5Vwr2G//Ob44DlEt5OysO/dfwHHzPgOGsv55lLafUYqXMTPphLlsfsWXVJnCIRN8wk5aK14/5zxiH/dwBmFzICnvs7NPM72jqSYlyZceQKpuTEToHHFR1swdJRycJl9DWoNDF4Vqj2Fhhgu1LkI+7T6JF+v7XVbCAmxGWhOkMluNO9+l3FMZWq61McOF6LBnJYqFsO9FZm9ypnlB3g26oIMQPYktITUE3WAhqt7yvA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 23:53:26.5165 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d59b701-e507-438f-42a1-08df49bcf790
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY5PEPF00000E88.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6526
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA5NSBTYWx0ZWRfX/yNEDVfzwTXV
 h8Q7pTYI2Deb2LbmaqqE7rmeCpVKNTRQbqkhiHAB0JRoZPk0Dj7NZlrd6VHy/S3kCcHChWLEPHc
 Vjmk7OF61MxOQonsvAFwCCunAPBNDmw=
X-Proofpoint-GUID: 9pYlsrij1eTji8CUtt21nV7_TLgyocVK
X-Authority-Analysis: v=2.4 cv=d8pgWhjE c=1 sm=1 tr=0 ts=6b04d1fa cx=c_pps
 a=Jpon84a9jUr9T0N/wBB0/Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=SsRTln4uDLc-c8XzFTAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9pYlsrij1eTji8CUtt21nV7_TLgyocVK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA5NSBTYWx0ZWRfXxVvVuPU/IrXo
 ibdE8iJPf9c2RQL1FKF3AWpMfDPBL6Q+tVX6eqZWWUnC0uqIbnPyMsK8jZ5rr0oQSg3ncKX+gZL
 v8aXdZCf+APOPOkuk95NP26vldg0CwNqUkQv9JDEI7isJ9C+c0cxua1dMRagOpgZu8pRcTtJ74D
 9d+bRsSIT71+WAb2OO2t+twowf7jCiZg3vXZCPj+FBTQ51C7mB8zLuuqrevDVLaKyru8dA1O6jF
 UiRc7iN3vPC9OmyTNMxvJycr2qSCyr+FcwSMQXIBzykIJUqiXzmxYIWTC4EUwDVacFW8qbmv2Wg
 owPE5OrmZZA4k1nZGoLxURuDmrkJf0O6XjeCIiDXu3jF2xcUmzazLfu2dD/6Kl3PKGpzTixNwmj
 ARbOnOQyDETbb/ijsAb0Hu5pGxag+c1112Qu0+w58GOM7vwFl7Z0iwEswyWA/K7dW4TLSdXI5H9
 S+uCiyPYeteG4UWnyGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230095
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/23/26 5:44 PM, Francesco Valla wrote:
> The AM67A and the J722S are the same processor; their name differs only
> for commercial / market segment reasons. Drop the AM67A dtsi file for
> the R5 and use the one for the J722S instead; all the differences (MPU
> clock rate, main timer clock, OSPI and HSM) were part of previous fixes
> done on the J722S and therefore also apply to the AM67A.
> 
> This fixes also the DM2TIFS secure proxy threads, which were incorrectly
> declared as 22/23 instead of 28/29 in the AM67A specific dtsi.
> 
> Fixes: b27c94958b97 ("board: beagle: Add support for BeagleY-AI")
> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---

Acked-by: Andrew Davis <afd@ti.com>

>   arch/arm/dts/k3-am67a-r5-beagley-ai.dts |  2 +-
>   arch/arm/dts/k3-am67a-r5.dtsi           | 70 ---------------------------------
>   2 files changed, 1 insertion(+), 71 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> index 61ee75b74323..d3da07e470d3 100644
> --- a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> +++ b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> @@ -11,7 +11,7 @@
>   
>   #include "k3-am67a-beagley-ddr-lp4.dtsi"
>   #include "k3-am62a-ddr.dtsi"
> -#include "k3-am67a-r5.dtsi"
> +#include "k3-j722s-r5.dtsi"
>   
>   /* WKUP UART0 is used for DM firmware logs */
>   &wkup_uart0 {
> diff --git a/arch/arm/dts/k3-am67a-r5.dtsi b/arch/arm/dts/k3-am67a-r5.dtsi
> deleted file mode 100644
> index 48bd15f480fc..000000000000
> --- a/arch/arm/dts/k3-am67a-r5.dtsi
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> - */
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -		serial0 = &wkup_uart0;
> -		serial2 = &main_uart0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>;
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-all;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-all;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&cbass_main {
> -	sa3_secproxy: secproxy@44880000 {
> -		compatible = "ti,am654-secure-proxy";
> -		#mbox-cells = <1>;
> -		reg = <0x00 0x44880000 0x00 0x20000>,
> -		      <0x00 0x44860000 0x00 0x20000>,
> -		      <0x00 0x43600000 0x00 0x10000>;
> -		reg-names = "rt", "scfg", "target_data";
> -		bootph-all;
> -	};
> -
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&sa3_secproxy 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-all;
> -	};
> -};
> 


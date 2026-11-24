Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EAA606A321
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 04:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P5Gg1Xj5;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FjuwFa1d;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=n5d3XoUQ
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1D1CA607BA;
	Tue, 24 Nov 2026 04:47:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z1U2yfAL2IHu; Tue, 24 Nov 2026 04:47:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5044860689
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795495634;
	b=s6cmX1cViCGSFv77smv9t5lF/ZzNY4o2Znm6DOExB+74XBmDaDjO+cApTmbJmBe4OhnM
	 V2LqmSStTHb9nKoUwfHKB1HrOCeWvIbScRGGgNzCRmWyLHFBxh4P24I+dhdbEIkH73Z9Q
	 YUN4C2R/1tZlpexDtTU2xRqw20xS3WPtp2mg5B7adUTThXstlT7DOmX9yN9ZyVI3v1gdp
	 4HUo72/v1aVF+PxXTJdxEW22wPLcKDLJMUDAqsGde3HKsBPyiUE0Fz35cflDr/UXSWSY2
	 6tzAmqcsPoLOTykNkseCeIeP33nZKRxHKvTWHLuReXE/gZlIDQOhN6NDm5LGT2dR++A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795495634;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=XUtXzAkkSAf0xOGIW8Tq+2TP1UfKjA/jak6iR0VXicM=;
	b=J1E20fEnp9lMJuXc3a+DvlHTHHvwwCaAwJUAbFEYSw//diljdCanSj2i4eVyCllnaEcs
	 x9Gk70r4CDuGFWIt4pY4ZUIWPKRVfufIqY29r5FbJ1e4mzsp4ut/acGhQ9WpjAA3jaMcS
	 JAE8GriIs3SVZb4SqMv3AaTyEzFbideWuCU9cABhM3VxRo3CwuND4gcYIrnUIAMjLyxLv
	 Jm9mHqwQ2I3Se4T5V6b2iZPb5ghhw+y4sqf4fa9heu2TUjCp5ckFL2Fnk7EAVrL2CfQq2
	 rX/04r8cXuywCOw8mB18EvQe2QD9REeTjrJWn4AEeutTB/5YV+8VtwuH6czdwSg3O5A==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795495634;
	bh=XUtXzAkkSAf0xOGIW8Tq+2TP1UfKjA/jak6iR0VXicM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P5Gg1Xj5NmwqgAaD+wdtgbE6Y4hp37HQNLwmlsvXm5nrdTpElVM/dPH9+xzKAs5IZ
	 hi/DxpDMSta/EhB0zLf/y4wVFk5qwVWp8TWWdEORjvLaDaD46iq3qzndlE0a1ZoFrq
	 G9Y1cNLGhDtGTwQWTtbOYbq/ryXVr5vooJfv0UUZxrMEmw0J6B0xxFKt2zMOvsmwSg
	 T9GL+NioV/dHsadbXcp2Ug5Gi30p5tyLtOtByI4bdYIvGqIKxlZtQYNftwi6Nv+POv
	 3y0nTuQOuGWb+Sx7eWM/BAvDY3i22nLfdFkDPGrNpxkMGNjRhGJSApdWtdKy0k32xi
	 Uove90/7IN7Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5044860689;
	Tue, 24 Nov 2026 04:47:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 01AC622B
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F31ED4006F
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:47:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GXf5UbmjruA1 for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 04:47:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3123C40068
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=FjuwFa1d; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=n5d3XoUQ
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3123C40068
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 04:47:10 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AO2jjfS1488125; Mon, 23 Nov 2026 22:47:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XUtXzAkkSAf0xOGIW8Tq+2TP1UfKjA/jak6iR0VXi
 cM=; b=FjuwFa1dIE2ksZzHT//itxn56ghArf8XYX0T6RKqjyuujA2cZm+HFC0LA
 KfVm61bmNHltyMpfQR4TlG9rVNv2i7M5JSAmDoinqdnwzbb2+TzCs09XhutnITYr
 8L33nALLbz5HJMgIcutdRJA1qh2Cm6j8Qz6CSA4RfkBQtLaPvXD+0yWQvpBBESqk
 Qvm6taU4yEuEf6dOJ3ken2k6y6ZuybAWJoMXI6fnDZFJIxtUTNrlYDfYD+iCH5xE
 ykzTPxxhIkhJmyJrJxmIYsoOwvZU74MQO1grlRx5YOPTEyqEoRcIDT/v+qEen1GI
 N2aebpd3TAzhl6hLMQE/1TASlB9Qw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013055.outbound.protection.outlook.com
 [40.93.201.55])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4j4v922b49-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 22:47:04 -0600 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUtXzAkkSAf0xOGIW8Tq+2TP1UfKjA/jak6iR0VXicM=;
 b=n5d3XoUQ0oXTUEW2J8ArVCXjVNdEfdFfaD4EHsq2C8gc5EUYxzHO2THn2+BbkNl9vSj/JySHzKn4nfv5pH1JTA+mALNASQi8DMAIkjr7zcJSkBhBunpbQbWLKD9o217DgTzvLGMRpn1DqlaCsUwjEKI8Wa4eDBEpfUr8B//nI6k=
Received: from SJ0PR03CA0108.namprd03.prod.outlook.com (2603:10b6:a03:333::23)
 by MW4PR10MB6323.namprd10.prod.outlook.com (2603:10b6:303:1e2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 04:47:01 +0000
Received: from SJ5PEPF000001F5.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::9d) by SJ0PR03CA0108.outlook.office365.com
 (2603:10b6:a03:333::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 24
 Nov 2026 04:46:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F5.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Tue, 24 Nov 2026 04:46:58 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 22:46:25 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 23 Nov
 2026 22:46:25 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 23 Nov 2026 22:46:25 -0600
Received: from [172.24.21.188] (lt5cg60819vj.dhcp.ti.com [172.24.21.188])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AO4kKHL4066546;
 Mon, 23 Nov 2026 22:46:21 -0600
Message-ID: <1921b2a1-0a43-459f-bbad-8ea72a2088fc@ti.com>
Date: Tue, 24 Nov 2026 10:16:20 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drivers: power: add SPL_ config options for TPS65219
 and its regulators
To: Francesco Valla <francesco@valla.it>, Anshul Dalal <anshuld@ti.com>, "Peng
 Fan" <peng.fan@nxp.com>, Kumara Bhimeswararao Matsa
 <bhimesh.matsa@gmail.com>, <u-boot@lists.u-boot-project.org>
CC: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Johan Jonker <jbx6244@gmail.com>, Joy Zou <joy.zou@nxp.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Vincent Jardin <vjardin@free.fr>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>,
 Nishanth Menon <nm@ti.com>, "Robert Nelson" <robertcnelson@gmail.com>,
 <u-kumar1@ti.com>
References: <20261122-tsp65219-spl-configs-v1-0-20492ba3f1e9@valla.it>
 <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20261122-tsp65219-spl-configs-v1-1-20492ba3f1e9@valla.it>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F5:EE_|MW4PR10MB6323:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b92ed8e-8876-4a45-0afb-08df49e5f8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700016|82310400026|23010399003|10067099003|56012099006|4143699003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|6133799003|18002099003|3023799007|41080700001;
X-Microsoft-Antispam-Message-Info: YlboMITfsUypqnS+IcR65EX3xE1g144QXTAIVNkPC4RYLaHgeEa4GTfAH2iKPpurJr4C5aLAvDhmK7syi80bze8E4XGvG0vG6/cfTfihkhEF3UU9qaFftlxWJreobxOHxcbVFS/1AQge3f3PdKyuZbaUBH6z5J7iTCrYLBBkuwCb6rFiBTgRKAgCk1QvorqPgyGXYxefkP6uLdm+2tk/0tDhuS0ooODxop7eI7d7ZlzIoz4BG9TC774VjfYvM79FEJGL3H76vl8mibyzz4kLxNnt+QkWZoS6EHbfVbjJHr46nQ3r9Qa8m9qu1BYeeXu89/7dwPNJGR+VJFMzKsXw/abFYG01bFHqHSO47xZyOHpZvoc3xlbFxlK32IJRgyw172byXble4AaRjYvrtR/JVq0mwsoX9f/eKbeFvI87YyrNIamcNznKtTmADivlvNMNrUhEoQNaqKjsn2O1J4iwMQhDzNq4L6kenxEBvY1ohboB0ncccq2v2F8Zu+xUIk7E4fyz2ftiQ7KNr0rx3dEhHcY6l/NuLdm3GPd7mprl7i8zWCNz8PpsPyeQ998Z8qqrGcKIHJ0VC5RtpRRLTfSnxB4GjgQ0rbaThKGXz62yKYmEgD7qfFV3Wm75qdfYlSNWGaOL9Fl/Uwbgry7yrp78NPfR862GQk0G2bEyx0JL6HcmVMDMfj0/GSE7fMXwWyYV4BsquHpaF+lFp7dDqt2gy8Ljw2cD5SSPKBiprXPzXpRoWLIsgvYn5XBBBIx8GxLb
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700016)(82310400026)(23010399003)(10067099003)(56012099006)(4143699003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(6133799003)(18002099003)(3023799007)(41080700001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /SwmWmtpuMqVIO7woXBfyYwhGc0vSh2bNvd+xgYWfPy5F1LLG/PwcgSkLVY5pTddE8ZtDh4OjB1AzcCbhpzLJmwZKoGxvAnjyo43tQM4QnueP+OOHvQAoG+U6MZcgauPxnmB2eMjXHhdWaDFaUs/8IAb3/JG2ENV4Nq5NBkaQ6Y+hcMXQqoa6zI01haagZVFg+ljPAJniZQ0bKhxJDuHpbw/YeKBSCJEZhoGj2G1zE6LDUSUDGGngcalUZbnGc5pBmA5E4d+o+0pgCzUhEKFRzZrgIqBcqIJmMQKOFV8ugiGQATQOhU9/V5/Gp+zS1zLvD3Nya7X8fOSGpvkgGx/nrMjwMP6cHtr5bxe73ZehCAqR2h3Y8igEGFoVlNe4gsdaHP0SIb9kqV7FefuvG6ggk20QH94TUChWbcG3GkTzAzIxj+U7rMQ/5aIvgA3H+pB
X-Exchange-RoutingPolicyChecked: E3XFuzePECsUk1CvpnPqrgp0O7z/rJz5IfLHwFB+52+n4KVIAXR++6AlvMwjCgYPvATRUPcZ7B+9yHpzOST/uPb6yqGwZHMYxqmimbvP4aKgHMWUba+PN8E02GeCR+SZrvnDzduskXUiLVfeT7Xd30AH8KNbooFjolu5I1MWQIYyJTSw33MgW6FocyUSN/QeDiiul+dYIqMgEQMkzgER32CG0WyzdsvUE2oHja8yrymL9MCmn6AoUItV3cljmdZFCrJQL+BfxGJK289Q67WMHthLremrlzgGPz+nObbtWDVxVc/AKWMBGEJmYvyPTloOr2wfMzF2gvBFlaDEYq1aTg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 04:46:58.0712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b92ed8e-8876-4a45-0afb-08df49e5f8e6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6323
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxOCBTYWx0ZWRfXw0oy0IiI6FUU
 Ag+KgmvbL8pcWBrPSUQoOJQsJkSg4JwSrjckRdzAaP0cagZvPahZ7Y6myOEAXSbC89IUw8cj3yu
 EFTg9mXvQ1hvT8OwvdTM5f9Q7ClRr9iZNHNVmhh0fQBrdDhSBCabF4EqUrdXpLxUEIV1BX4Te7W
 gW/yy0pK2K9sNaAAH5+zomup3NReY8Xm80jZ6InjDUevB2LFW49GBA5OFSz5Oy6n+apz5ASZKgM
 TYxopbytDW8h3GIdlc4938jU9ARVSUh4KsSWkthdniGrjC7g6oUksClBx0jeU7n3m1jUjeYbGxP
 qmQfmdNZMuBAQVjaQg/THQct0Sjjho4lVEKPP5FZMlIvZsv5+cqCAxMpF0PE7EKeSDAzW+6XPw1
 T3PT/HuiQFv/heo+O+qul6QdnElc+emxKODVAtLh95Ak1J0S6sZF7ooaaaAqB9UQ728yHtIhG70
 D5Lnpkv0yx1P7gkX/Tg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxOCBTYWx0ZWRfXyocwzwhYx28g
 GXQVX+yqwhi0LEmysDSyCnhe23VEBCx3HKNUYYwtq3QqfvTJR57qEnWri9s1YgU0QNpDXacFp8O
 tbdqwV+iT71ORi6ZOSAh9yiduqf9VpM=
X-Proofpoint-GUID: 57HSN-4iUiBwZDWLT2GbkB33vZSuCio-
X-Proofpoint-ORIG-GUID: 57HSN-4iUiBwZDWLT2GbkB33vZSuCio-
X-Authority-Analysis: v=2.4 cv=QND91QLL c=1 sm=1 tr=0 ts=6b0516c8 cx=c_pps
 a=lT9N4OFqmOca6tf2P0aJdw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=5JDIudzTH5Zh4A_L9AIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240018
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Francesco,

On 11/23/2026 3:41 AM, Francesco Valla wrote:
> The TPS65219 is a family of fixed-function PMICs for which the output
> configuration is determined by the part number. For this reason, usage
> during the SPL phase is unlikely.
> 
> Add a SPL-specific option for the drivers of the TPS65219 itself and its
> regulators, to allow its exclusion during the SPL build. Since none of
> the supported platforms that have this PMIC onboard modifies its
> configuration during SPL, default it to N.
> 
> This fixes boot hangs on the boards compiling this driver but that don't
> have the regulators sub-node marked as bootph-all; since commit
> 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")
> this absence was leading to a silent boot failure.
> 
> Tested on a BeagleY-AI; the PocketBeagle 2 has the same DT layout and
> the same configs, so it's affected as well.
> 
> Fixes: 607d45d1e3b3 ("power: pmic: tps65219: fail if regulators node is missing")

Thanks for update,

I see this PMIC is enabled for below boards,

configs/am62_pocketbeagle2_a53_defconfig:CONFIG_PMIC_TPS65219=y
configs/am62x_beagleplay_a53_defconfig:CONFIG_PMIC_TPS65219=y
configs/am64x_evm_a53_defconfig:CONFIG_PMIC_TPS65219=y
configs/am67a_beagley_ai_a53_defconfig:CONFIG_PMIC_TPS65219=y
configs/verdin-am62_a53_defconfig:CONFIG_PMIC_TPS65219=y
configs/verdin-am62p_a53_defconfig:CONFIG_PMIC_TPS65219=y


I am wondering, if PMIC is really needed here,
Do you see possibility to mark PMIC as N in respective board ?


If you look at other boards from TI/K3 using PMIC at R5 stage not at A
core stage

configs/j7200_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
configs/j721e_beagleboneai64_r5_defconfig:CONFIG_PMIC_TPS65941=y
configs/j721e_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
configs/j721s2_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
configs/j722s_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y
configs/j784s4_evm_r5_defconfig:CONFIG_PMIC_TPS65941=y



> Signed-off-by: Francesco Valla <francesco@valla.it>
> ---
>  drivers/power/pmic/Kconfig       | 7 +++++++
>  drivers/power/pmic/Makefile      | 2 +-
>  drivers/power/regulator/Kconfig  | 9 +++++++++
>  drivers/power/regulator/Makefile | 2 +-
>  4 files changed, 18 insertions(+), 2 deletions(-)
> 
> [..]

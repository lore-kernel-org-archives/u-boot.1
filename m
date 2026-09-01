Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A81C624D3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 16:52:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B370A40759;
	Tue,  1 Sep 2026 16:52:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EC5o1gfSprxA; Tue,  1 Sep 2026 16:52:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788281553;
	bh=hiLY825Uk7vv6IzCEA6UdBQDjHGBUGLt2tbNTFMvcCM=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bETLvwn9frUjhxlkBNHeUpwJ5WE6vAYpF3+ZVyJuVnYtEyU+FaN71v830I0r7bWMK
	 bHXfNFSfs9KvI7y/OD7kSovx8w6ceavfymRG7UmPOQ2//YS0gVhILTAcV4f1EBfuUj
	 260Yr/EozSE/dbOf+k1Fkke8XTht2DiTfVGeubPf0CxgdRkF61+Rullg+zrbgJgWxW
	 PLWZlVfv2ouABAKqbhAnZPyYHDBVvtwuR3ibZcNfaP4h+bDXXoQd9VG6rkZno/yQyl
	 atyX99XUA+jZUUhx8y6AHky1xUnQggmQExtKdrbOZpG4sBYnDVmlikkyO2RGknTbZ+
	 9tj4uPuUv6BRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B1F28406F1;
	Tue,  1 Sep 2026 16:52:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2CD632FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:52:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0EFC980D86
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lJgfk-bBHCqo for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 16:52:32 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=VdmlniDY; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ZW5w7bGv
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 325CB80D36
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:52:31 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681E8Qmg4092420; Tue, 1 Sep 2026 11:52:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=hiLY825Uk7vv6IzCEA6UdBQDjHGBUGLt2tbNTFMvc
 CM=; b=VdmlniDYSjqn7ZA16d+RbdqJimINSz//NleS1xkkA5t+H4jvPnwzIfsSC
 KURvkQqAX2wW30suuOXVUf0pKOmSaLIDye6q2x+L42yYIiIS0o8nLVb6jrqzaNiG
 vjV+fj930GAh3CGQgyhcPSFBz+6HD6kmxyuhi58dnZyLwheK+WwophaVeVu8L8lj
 Uz32BGEzJG0GPyNRq0j/jzb6DgZszlJX2u0vxZyiXgAQOilR+1mjFSax1Q5zYjiB
 GlHreH3vvqg9eCegUgrFA/RnnnaF+ZGsiOgtU9dIKTID+zoEpO7qBtHdfmnVSwX2
 bhFkMZjvYRr9hMHNMZvpkzMbuqjVQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013064.outbound.protection.outlook.com
 [40.107.201.64])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gdngv52e9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 01 Sep 2026 11:52:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AUPmWSITm32njeXm4adWjJ7DOAFMjCHOScNKZv6Z8PYKcqrumErOPKCLElgRfqjFckQ0ObB3S6XAko8qUSb4DhCtHfvkGwCGezq22XLz5wgAbbwDUWCGWIjQEM5JDme+NoeEEKVWIkGvKhAf40Mpj0o/81Pd9YmUxVMwbum3DxpeYiDV30Qf0sFmOHpG5i7DQhFYmm9DuCIVYiujLwWIx4zD+9MOXluzXgQf0Al+85AQrAkN6O7TetP9dayZ0sH9PVYB1FY9JoNbLtpQoznkuo7kl2A8pSdrqmR5qiBLfVmV7epCTnLWxCbbFDHTcbScRV09lHaTLCFvlZ9Lf5WC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hiLY825Uk7vv6IzCEA6UdBQDjHGBUGLt2tbNTFMvcCM=;
 b=l2baCdgELW5Jx2p+SANRJk3NduVatc8ebJvPooCZL/qqNYub/7zgQVc3K1OB13dDkrN9eD/ZMTJj1mV+wx6meDq473zQjAbXMf8toFU1Kog3KZe4Guk6MORBQG6CFMUj6s2HCn0G8KUA+DTnQxOH8FyJ2Ww8uLpxcRJ9lCmyia4bZlColDkSdpANTBeSRRleACOe5fBhNF8saalxLsahjl7nN++NZ5S1juuJLXJ730ZIHwBwoy8ShMQFTBzqx3m6yqcmo4zdJCIMTfj1cYoX5CQZzHlLLKv5xaFlhzp2zE9Qblk53/H8iOeG/4RWqgKMGaXVOCxBA+lG6P7tLN8Rmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hiLY825Uk7vv6IzCEA6UdBQDjHGBUGLt2tbNTFMvcCM=;
 b=ZW5w7bGvyaQ9yYdZkijKkUbvXbg6+VOjUxzRy+iBnwN5FEW6s6stRZUTFR4Dv7DKt3p4N+AaagruxtQO2veZavd1Ro+vd5e2byS7zyx/Io9Z7GP9V0Hzq+l/ahKLCply8MsucjWXKNo5jE81aF2sSvvCeEvX7n5y8CfD3tm2q2c=
Received: from CH0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:610:b1::11)
 by LV0PR10MB997589.namprd10.prod.outlook.com (2603:10b6:408:340::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 1 Sep
 2026 16:52:24 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:610:b1:cafe::5d) by CH0PR13CA0006.outlook.office365.com
 (2603:10b6:610:b1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 16:52:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.0 via Frontend Transport; Tue, 1 Sep 2026 16:52:23 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 11:52:06 -0500
Received: from DLEE201.ent.ti.com (157.170.170.76) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 1 Sep
 2026 11:52:06 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 1 Sep 2026 11:52:06 -0500
Received: from [10.249.32.71] ([10.249.32.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 681Gq6YL2140673;
 Tue, 1 Sep 2026 11:52:06 -0500
Message-ID: <52a53ab8-1e28-43e5-a95a-c157c5ba11cc@ti.com>
Date: Tue, 1 Sep 2026 11:52:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] configs: add A-core no-SPL mode fragment for k3
 devices
To: Gokul Praveen <g-praveen@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <a-nandan@ti.com>, <u-boot@lists.u-boot-project.org>
References: <20260819101910.39192-1-g-praveen@ti.com>
 <20260819101910.39192-2-g-praveen@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20260819101910.39192-2-g-praveen@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|LV0PR10MB997589:EE_
X-MS-Office365-Filtering-Correlation-Id: 534e3dcd-c70d-40bc-03b2-08df08496567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: d8lTAp84f9e4XdoZ0XEj5/XtBVYAEtuXaKgLFDZLHgsrPYoinQbPHdWndNZYTZfoeHJgnsnIOjTndURM53Ryb4ofUvZoLcXRR9W0JRDhqD86uGB4ceBemjphD3S069rzBlK+miZyJtHwxXArcZqfzc+lGtujX4VTP/0ZZ6g39d9X9zuDjbdbSUXsn2Gfno5QWW7oOp3q2Elj0ywdga2qkANxwIa7yGJ6O63q9zqV2ufHdppFOPC+tbilQJBgh5CHROyZFzrqHOMRgdlF+TMwRHyspPXyLdT1WuhBBq/R7bsOwV057cxzTi9P8yR5iFz1OS99tlYvMnPr+b/lT1T+9v/DWdj0uNVK3eQHfg0QMqCIWGL6Tx/j/p4P/LxEW/dVJEd3sTF5HorPkOr5CoMUPjGwJofaoSbgjXXENi3lythjtUSDw4QJ1/q9n/zFzmLkrs14NpofTl/kYXJ++JXEAVg6BtJbfm4xTYNvWGROzL9yw6kB7CG+1vqEbT9qH1PL4Kht23pf748M2pyGDd3U4LhAwmPooRMxBdEMXuYSpHHJoJXTnVB8kP7rUZJQK7HQaM13TcqHw69Q8Ud/w7zh/zZyo0ojsLToWoRwXncruTS6Tg9cmG0CzggcOJ/M9jdCLRNoPzwuyJrlsmGNOKBZMj5mzFtUV9zW2bTnv+n3qGG0i9DzFyDd/X7SWzBaHfIfgX2Pv2jGj3v5TINY22ZTtQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4jerZEYx2hHrgudgke9duBOoDeS/iwx6ergCz9xzUybEUD2HVNJUZNUiS/n0lMMOcXFraZTL8A2ZHNqRPuUCY8ePmuAWn45WiMR7qMbcMIiVdyR4pD4O4VAiMgH+Jqwj24/GWzND2rkVOd2suktX3WSWWiaJCjxoYPklS05MZNR1nnBbPqKxrMJsoFnX6P4X64/ILzSV5eKmtk4sqfY2uWST/7jCV5e0mpIRzNE+aBqCKjG6JN83riIHzem2rGcbufKy1oC6Z784BU3HFD+n1YMln7NPUOcDS2HmZmwFwA8Uh0OmGaAxEZaYS0FrT8GvyBlAYDjesqWP8EIeU4GI+wxCzU56St3nnJjsCLKF2Xlm1vWRIXPXv3jFdJWBHOycboqba8ZkPl+M6gESPmvvprfctjg5PVvDeruUsRxEUDFHX1uvP6ZRAMkCX10o2KqT
X-Exchange-RoutingPolicyChecked: Saagjfn+1JU8vMmO4k+RhTjI3kFL6V4nKma5opMTxUVRLYTjB1vONKWMlz9rX3/JraMGzY8vZmPMAzTZviwoIGM/fA9vVRrJ5OD4HkQLj8unLsuTGq+ou+OjENa1NOB4YzTKdqDmgFElPzvJwtnKcxAf562zlPTmHjKT5pxSMshX53XAHG7nN0u1Y1uRkZygh7jckyMHrNSB+H9KU6NIJSiBl4E3UYrm7L3ZdMc3z1RS9zlVLuaxU6Gpe4P83VJXWTdAovPMNfiD9RkL4PdP7LKHRycgziB1OtatEo0na8hD/T6vHzOD2FIVc4r/tuoG1o7PwuDTS+VikfxE4505rQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 16:52:23.5617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 534e3dcd-c70d-40bc-03b2-08df08496567
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997589
X-Proofpoint-GUID: CaXVnhLN--j_LRbtQFfC9ZfpNK7iloc5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE0OSBTYWx0ZWRfXwqpV0A9W49Ud
 r0+vfiAo5iQKHs/qU9vzvKL8exIyWkA8Em5HyPDz4rZbO8aiz3Jucxx+yWJsAbU1/kRn3zbXeJo
 uou9cwfMkcUtkXb4DyqDV9trECwoU/ecVpPQy25UKOp3NreT0vw8McB8uWzySOiOIR3SeSrMbrk
 JDeVOYpPPi93AYZ6CVMAasNNE3ix6Hd48ECZgTZqwRmZRn5sah8xmf0CnrHyAIhjZKA62v/Td53
 Vltjiu3w7q2nYGmHfsh7/uX8JtJoKIBhqas4FCCNUHIychXPdL/WKS3EmH+YfMC1BEUpNK6RF++
 cXzQoOwhPZAOrDW0RLZSflmTIWjzpf+UyX4Pv0W2q8btDUDhFCa28JUbRezgr8bVzVujYYSF2Cq
 Bo17Pu6RVO8H2UU6iT2tv71yyjbw3shwGrskTKT3wBeFVmsMAzI8FpcXLsIb08A2uRzUm1/N9dQ
 dwPkcodl/IaDk6YzyCQ==
X-Proofpoint-ORIG-GUID: CaXVnhLN--j_LRbtQFfC9ZfpNK7iloc5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE0OSBTYWx0ZWRfX/U3EAqCOUew/
 Pl9J1kAuJZoS4sMqsGUvlX+8vPnCV14iTd/L67Qajb2lziuk4+I8E/KQGqnBDDpo/9WbASJq0Ox
 f/0uGVvQ0yx45VnuXENCouYhdhkWMXY=
X-Authority-Analysis: v=2.4 cv=I9JVgtgg c=1 sm=1 tr=0 ts=6a9702cd cx=c_pps
 a=Y7Q6ByIND0QZLGHO7LoGYQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=H8Maa1MgwCC3Zv_iYpQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010149
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

On 8/19/26 5:19 AM, Gokul Praveen wrote:
> This fragment enables a boot mode for K3 platforms where the R5 SPL
> directly loads U-Boot proper, bypassing the A Core SPL stage
> 
> The R5 config modifies the payload filename to load tinospl.bin
> instead of tispl.bin. The A Core config updates the U-Boot load
> address to match the A Core SPL load address, allowing R5 SPL to
> load U-Boot directly from that location since A Core SPL is not
> present in this boot flow.
> 
> This reduces boot time by eliminating the A Core SPL stage.
> 

Is there any downside to this approach to look out for? If this
is strictly better, then why not make this the default and not
add yet another boot flow combination (to the already long list
of combinations..)?

Andrew

> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> Reviewed-by Neha Malcom Francis <n-francis@ti.com>
> ---
>   configs/k3_a72_nospl.config | 1 +
>   configs/k3_r5_nospl.config  | 1 +
>   2 files changed, 2 insertions(+)
>   create mode 100644 configs/k3_a72_nospl.config
>   create mode 100644 configs/k3_r5_nospl.config
> 
> diff --git a/configs/k3_a72_nospl.config b/configs/k3_a72_nospl.config
> new file mode 100644
> index 00000000000..7522acab950
> --- /dev/null
> +++ b/configs/k3_a72_nospl.config
> @@ -0,0 +1 @@
> +CONFIG_TEXT_BASE=0x80080000
> diff --git a/configs/k3_r5_nospl.config b/configs/k3_r5_nospl.config
> new file mode 100644
> index 00000000000..94931bf8798
> --- /dev/null
> +++ b/configs/k3_r5_nospl.config
> @@ -0,0 +1 @@
> +CONFIG_SPL_FS_LOAD_PAYLOAD_NAME="tinospl.bin"


Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F82C55173
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 12:41:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE08C4080D;
	Sat,  1 Aug 2026 12:41:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ln56yDcJoFik; Sat,  1 Aug 2026 12:41:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2B674063E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785588089;
	bh=lHKbMZIg/jI3km007nYoyPvDvqKWpJ9Og+I2ILvalLM=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RP5srFlB8+w8heNpScJx02PAJ9D5OQIscaKsXI5lISKWEs8f5kgW7g8OydEgEutyP
	 tLAT95dmMXI6eD01KLRZhLcav07KNvfG/k4P4nv/oh7Ey2E3dIVWWsxTplikg8BLQ4
	 edOrAEQyGpyKycjTih/dnrgM8f3UfH5LCpXOMMtWqswAgKbtWcP7DM78fsWc1AzR5U
	 mZGCB0IRKp0tk55R7iMWVHMny5yiPB8Fd9egadiJwGnuC9seKKq4t5CpWt3AcyoBLd
	 RWfCOOn3zJDGnW490Fg3U60qS3ahVIYNwmkhkIKbP2EU6uXSiI/PwwpZBRABJxyJhR
	 HchbdwImbtI6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2B674063E;
	Sat,  1 Aug 2026 12:41:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 20B5E2CE
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 07:24:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0AE25400A5
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 07:24:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a4QnuzxRQhKQ for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 07:24:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=u-kumar1@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org BB1434004E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BB1434004E
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BB1434004E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 07:24:43 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6713CPga2971156;
 Sat, 1 Aug 2026 02:24:05 -0500
Received: from dm1pr04cu001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fs8pf8ntn-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Sat, 01 Aug 2026 02:24:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RqgMGpqM5rlK8LSlHV+jTI8PLfItlG3Wer8SWLE79WO+9p24IQWhcsDJ9YOkEqYOF6e978MkiOnn6yEKOkC3N7M9ikG+8FLjNB0EDVJRan5zBaeErnnyVXcdRESQq2cxEFOhXtEciihfUQaiTBe0pCo7PwKRSWG7c6QlUUOuyZcTcWSav18CkMvQkMaVfIup1MWGBsDTjA+ULkP2c0QUqE4znw+/KRKgoGVYZvmG+g8nYDtegf1JoPqu8O6v4X9NmM4V506qIi8211gJMPLLshouroBUuYvUVKT8aQRXLL7z+Lle2F87GNsGNQZjIyz5SFy1Tqtn1KVBCRSg0JqVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHKbMZIg/jI3km007nYoyPvDvqKWpJ9Og+I2ILvalLM=;
 b=rL4AW61782tsXLnokS9fA6Mn1SEcKD7pAxN2iDG8LykLtThLtWwFwfZsDme+wh+ULeXmHkBTrmbZj/uTtzryIVmHQfxAGGd9678LLUnUqLhjNptWTIGe5tc/nQM6AnLGSiY7PHc14yPvelyenU+maTQYvkgEe0hUW9s69i/ZVXjBxM1eZj4xrauSnlLSMLWzdHVLXDtUWjwLH6gPAM9BkIdh/BR9641JVQmU7G9BTibM27mCXvrbCMMdkA+aZl3A0CKrQ2fRS5CdnOZV+ILMVO4J1ElAwSa3cBqvXUKx5Pzc1/l5nHj5IDewgL5IjVyqWD3teQyMlDEKqMd/m6IU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=bootlin.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from CH0PR04CA0076.namprd04.prod.outlook.com (2603:10b6:610:74::21)
 by MN0PR10MB5959.namprd10.prod.outlook.com (2603:10b6:208:3cd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Sat, 1 Aug
 2026 07:23:55 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::89) by CH0PR04CA0076.outlook.office365.com
 (2603:10b6:610:74::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Sat, 1
 Aug 2026 07:23:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Sat, 1 Aug 2026 07:23:54 +0000
Received: from DLEE208.ent.ti.com (157.170.170.97) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 1 Aug
 2026 02:23:54 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 1 Aug
 2026 02:23:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Sat, 1 Aug 2026 02:23:53 -0500
Received: from [10.249.135.178] ([10.249.135.178])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6717NdEx2067886;
 Sat, 1 Aug 2026 02:23:40 -0500
Message-ID: <800f6c85-7854-4b7e-9509-3006c3ca8b42@ti.com>
Date: Sat, 1 Aug 2026 12:53:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/17] spi: cadence_qspi: Use APB write protection
To: Ralph Siemsen <ralph.siemsen@linaro.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Senthil Nathan Thangaraj
 <senthilnathan.thangaraj@amd.com>, Abbarapu Venkatesh Yadav
 <venkyada@qti.qualcomm.com>, Padmarao Begari <padmarao.begari@amd.com>,
 "Naman Trivedi" <naman.trivedimanojbhai@amd.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Sean Anderson <sean.anderson@linux.dev>,
 "Boon Khai Ng" <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>, Alice Guo
 <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>, "Jerome
 Forissier" <jerome.forissier@arm.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Peter Robinson <pbrobinson@gmail.com>, "Mikhail
 Kshevetskiy" <mikhail.kshevetskiy@iopsys.eu>, Robert Marko
 <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>, Ben Wolsieffer
 <ben.wolsieffer@hefring.com>, Stanley Chu <yschu@nuvoton.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Anshul Dalal <anshuld@ti.com>, David Lechner <dlechner@baylibre.com>,
 Daniel Palmer <daniel@thingy.jp>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Michael Trimarchi
 <michael@amarulasolutions.com>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>, James Hilliard
 <james.hilliard1@gmail.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>,
 "Phil Edworthy" <phil.edworthy@renesas.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Hai Pham <hai.pham.ud@renesas.com>, "Johan
 Jonker" <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>, Julien Stephan
 <jstephan@baylibre.com>, Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20260731-rzn1-2026-07-v1-3-af2ce80db9d8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|MN0PR10MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fedb50-913c-4c39-e7aa-08deef9dd7ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|30052699003|23010399003|7416014|376014|82310400026|4143699003|56012099006|10067099003|18002099003|22082099003|13003099007|6133799003;
X-Microsoft-Antispam-Message-Info: TJlJJo7g3TMTpiXX4hsqFCQ+WG6Jmjtr0xwcX99aPiGMXqsxEFJIWMJJj64YK4RJwz7/3t7lj8D+kBPzmshrgtJcnUJCg39IX71zIFqEqwHNf1ZwoiMkbg4vp0VVLZn0+Fho0vr+h1EAwm6u70laaAgJOAxxQoBk5pZJbkbi9whuDlVzOG1BF0qYPCeiKU7k2Qa4GZ4trIE9/Rf+4n4qjcYSZSP2QbMqS69PPqLblqm1qy/6ui/3xORxM10hccWaZ/XXK2nSYY5cWvZ8Lfvfo1Vw7feG11Ep0K1PyCi959W4uolryD/uQlqnsdw+0xGBo2aYfZV9RRtPhDXtrwx2RTKispJIE90Y0mCdFmVgSDDPzQeLmTe6LBOeN7ybzV+hTMX5soEQxVqj8nA+ury7rp0pM0z48cIt4hrDE3YXCBrOa7335sLJeUAYTUtrb+waM/DF1G2gsLcLr8JK67fx6Ev1M06Okz3KmtJQftIHvD51DVjaLmBkEq09/kTf9Ep/FMBked5RnI3zj+P1smt3M30OOI7eCT0OP6EwhwNhFNmWeDTj5FqD4yJv2szy6MKbb6NhZwXycqsniDhV5cfPNuCg18Tmlp1Aq+ytXPVqTjQS3OpZ39YjBF9iVX9WVKYAHiTtF979HQQfPNf19e5ySa8FLQumC8ZxqnUAjn3a6WslHY4CTLw8xFnm5lQ2Q+aaU3Sum/ZCmqq60l2JqH4t7A==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(30052699003)(23010399003)(7416014)(376014)(82310400026)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(13003099007)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /wypHVYJt7v076Amr60+vi3nH9kKdPvkLYnUBaCvXABU2uyL8KL8Udtun4PW6rcFqiaJUgIPgbl5gY77V0LIMLI/0mbHu8zaFTjUwBaqkvRHY5tVoumysqy7iw+bLMWSPmG+sc1kVgbaABUty6CJnpd5LbxzloU7dpzKtODR4II08AGUG7NYpeXyHCPA+0l41GFkA5YcJFIxEB97i7u57mXmrx4aJM44XQf8HgD9eTfbllemG8tbk+Ct9to6ThmWZbGG96Wofe79/POaYmngS4M7/gaL/dISwmWTsb1npwVDm9M0iPPnSw5uJduFC1oeQEpt6YyqRw8D3CQ1MBQC44nC5HdI06Fmyn8dYtgZYXtYNrpLE5JxtFLYLL4SvapUsHpLyVVxFaeM67Pcj+SpTpijLQQcan9SKfZK4EACPYrxjO42PFz3KNk9/7qliNSt
X-Exchange-RoutingPolicyChecked: dzaBe+2JnFKYJ7+RqcmhvEE3vbI2Z0lzsrQP74ZC9lPFr8neShHTCgj3hPgMuUyMIU1uYPjie3jZmA3EOJGlO1WGjbz8rcA7pF445kF5LNjHhIDKwAiZ/OJAJsklOqoR5/kDo1EilThM9j9diIzIQs8bFBFis5jD142jNHKPlLuoEVaYTm7wxlNhsz/sq7R/yArVSLqYX/Nohm5H6gdlRW34Ifw96tuQqG/cM5x5TK1mOp6acxWStInuA4QUyt4zMjNk+ygRQYo4vl7SR6RSIJNEkE7Fc04LiskPUOaE1nEGqLF6WG+w2l7UzyBrElGh6Re0ffKbU9m7Q4YoniWWXA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 07:23:54.4001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fedb50-913c-4c39-e7aa-08deef9dd7ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5959
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA1MiBTYWx0ZWRfX8XQrefMA/iGH
 f6YZUWJTx02hggKvXgR4LU44lY8OIDO4ENOYdNoa8qTI1L28jnJrXgfSCqALBcWDFmZhdIKS4uq
 M7aiwvRNaBTMNzS9qftIz5VXZE5tCfTKb83eJVJz0cYcVa5XOT29dOUQI3om5rj1A/XvqK856gG
 uh/tuoNFWDnkV9d7jXpsE3xozBFZ8xX6f35doBYMXTSRrdM/1w4PcH+CNG9yb+2THG1mvnE/t+0
 g21NbO0HXcQm9dsmOHMh8JmhLW7cEjZXfEdnaBhb/R1tmCxY02dKzU65cijJLyfg5V6cS+JboLR
 +Epp6EqIz574vSnJOerJJ6CIEDX2ePjNQiXcTHxmjOe39ynBOMOTEYqdPI9UILfGcdQdOhln5/S
 jkKG0sKa7H+soSi7Q3ovqVr8HbCOdv+z7Edc9lxaAZ6/LnFKlgIXYAWEj28yXtGffkhAQIKYPtr
 K/UTFXlXMzbQd0GafQA==
X-Authority-Analysis: v=2.4 cv=EqLiaycA c=1 sm=1 tr=0 ts=6a6d9f14 cx=c_pps
 a=Vharl4M+XVTaKge5CdhMZQ==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=yC-0_ovQAAAA:8
 a=KKAkSRfTAAAA:8 a=-QlX00N9vkwLyMF4qsMA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 9HDK4p9DfjfLENiaefsOBH-NzQ5xkmz-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA1MiBTYWx0ZWRfX7uNtV4OTuk7W
 dEKJ22tACrCbgVNVTN6HKxwCV+SZoi8HL4pNvnBVMrJ3OFDMQsmggE7Azgny7nwMXh/f6NYxiau
 0tu2+S9cq+WVVfyHkEEBa9R6ycDkIDI=
X-Proofpoint-GUID: 9HDK4p9DfjfLENiaefsOBH-NzQ5xkmz-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010052
X-Mailman-Approved-At: Sat, 01 Aug 2026 12:41:25 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=lHKbMZIg/jI3km007nYoyPvDvqKWpJ9Og+I2ILval
 LM=; b=PbXXprEc8RcXa5tkOABrCHk5TbKpjU0ktCAGP+yD904x1So71yVlQGLFm
 fPg7cjAdJLEP2LClEnWecKr9hcfsld2+m/yfymv8qg5Nk20jgBDIsjonqoLQZblG
 0B1qi/WPiRGCcaf32zgE8GjLLbk5b3xyF/ZNzv2jk2OL+b7seH+j9fW4KgkvRzta
 G8+b1z+fMCXeFrRuMCdbg9fZ3GFC+9YFQkc4uriS2qImIiM8qbdOFLdQTk7bCUwY
 vu88hkOP84jcZJ3XQnKvkhCiaOPm7sdrXwCvYB3t0zx7x/cudmIQo9H2ZVpfbEzh
 pFHDzesVC6D04Di1q9EOluYLuL42A==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHKbMZIg/jI3km007nYoyPvDvqKWpJ9Og+I2ILvalLM=;
 b=w8ueIIEJnxr4Z9XSVYMAwQCxGd2QpDCzUXpyrrh0pgQwAq1RBJefsDdxUdZpBDsNGfDbtXyhkCxOCl9/km5fvEnbPIhHyp/fooJBrDshhT6R2TkW1kAhHmGRdw92v7pOwYGS3iGfHtw9PUS1eYvPzJ9wNzWEqtsJk2A5PR4dZfM=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PbXXprEc; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=w8ueIIEJ
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/31/2026 10:03 PM, Ralph Siemsen wrote:
> Prevent random memory writes from corrupting flash memory.
> 
> When using the Direct Access Controller (DAC), the QSPI flash appears as
> a memory-mapped device. A stray write within the DAC region can corrupt
> flash contents.
>

my suggestion will be check first, why stray write are happening

> To prevent this, enable the hardware write protection feature. Due to
> known errata [1] of the QSPI controller, the entire address range is
> protected, and only gets unlocked during intentional QSPI writes.
> 



> [1] https://www.renesas.com/en/document/tcu/qspi-contoller-issue
> 
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  drivers/spi/Kconfig            | 11 +++++++++++
>  drivers/spi/cadence_qspi.h     |  6 ++++++
>  drivers/spi/cadence_qspi_apb.c | 27 +++++++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 007ad5e7733..19f8d48507b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -168,6 +168,17 @@ config CADENCE_QSPI
>  	  used to access the SPI NOR flash on platforms embedding this
>  	  Cadence IP core.
>  
> +config CADENCE_QSPI_WRITE_PROTECT
> +	bool "Cadence QSPI write protection"
> +	depends on CADENCE_QSPI
> +	help
> +	  Enable hardware write protection in the QSPI controller. Helps avoid
> +	  flash corruption due to stray writes. The direct access region is kept
> +	  locked by default, and only gets unlocked during "sf write".
> +
> +	  This is similar to SYS_FLASH_PROTECTION however blocking is done by
> +	  the controller, rather than by the flash device.
> +
>  config HAS_CQSPI_REF_CLK
>  	bool "Cadence QSPI static reference clock"
>  	depends on CADENCE_QSPI
> diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
> index 1e9081c2d17..6b3ed46977a 100644
> --- a/drivers/spi/cadence_qspi.h
> +++ b/drivers/spi/cadence_qspi.h
> @@ -119,6 +119,12 @@
>  #define CQSPI_REG_IRQSTATUS                     0x40
>  #define CQSPI_REG_IRQMASK                       0x44
>  
> +#define CQSPI_REG_LOWER_WRITE_PROTECT           0x50
> +#define CQSPI_REG_UPPER_WRITE_PROTECT           0x54
> +
> +#define CQSPI_REG_WRITE_PROTECT_CTRL            0x58
> +#define CQSPI_REG_WRPROT_ENABLE                 BIT(1)
> +
>  #define CQSPI_REG_INDIRECTRD                    0x60
>  #define CQSPI_REG_INDIRECTRD_START              BIT(0)
>  #define CQSPI_REG_INDIRECTRD_CANCEL             BIT(1)
> diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
> index 0d4bc685f5d..353b57a46af 100644
> --- a/drivers/spi/cadence_qspi_apb.c
> +++ b/drivers/spi/cadence_qspi_apb.c
> @@ -325,6 +325,17 @@ void cadence_qspi_apb_delay(void *reg_base,
>  	cadence_qspi_apb_controller_enable(reg_base);
>  }
>  
> +static void cadence_qspi_apb_write_protect_enable(void *reg_base)
> +{
> +	writel(CQSPI_REG_WRPROT_ENABLE,
> +	       reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
> +}
> +

I expect compilation warning on platform, which does not define
CONFIG_CADENCE_QSPI_WRITE_PROTECT

> +static void cadence_qspi_apb_write_protect_disable(void *reg_base)
> +{
> +	writel(0, reg_base + CQSPI_REG_WRITE_PROTECT_CTRL);
> +}
> +
>  void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
>  {
>  	unsigned reg;
> @@ -346,6 +357,18 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
>  	/* Indirect mode configurations */
>  	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
>  
> +	if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT)) {
> +		/*
> +		 * Enable AHB write protection, to reduce the chance of corrupting
> +		 * flash memory due to a stray write within the DAC region.
> +		 * Protect the entire address range, regardless of the flash size.
> +		 * During "sf write" the protection will be temporarily disabled.
> +		 */
> +		writel(0, priv->regbase + CQSPI_REG_LOWER_WRITE_PROTECT);
> +		writel(~0, priv->regbase + CQSPI_REG_UPPER_WRITE_PROTECT);
> +		cadence_qspi_apb_write_protect_enable(priv->regbase);
> +	}
> +
>  	/* Disable all interrupts */
>  	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
>  
> @@ -955,7 +978,11 @@ int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
>  	 */
>  	cadence_qspi_apb_enable_linear_mode(true);
>  	if (!priv->dtr && priv->use_dac_mode && (to + len < priv->ahbsize)) {
> +		if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT))
> +			cadence_qspi_apb_write_protect_disable(priv->regbase);
>  		memcpy_toio(priv->ahbbase + to, buf, len);
> +		if (IS_ENABLED(CONFIG_CADENCE_QSPI_WRITE_PROTECT))
> +			cadence_qspi_apb_write_protect_enable(priv->regbase);
>  		if (!cadence_qspi_wait_idle(priv->regbase))
>  			return -EIO;
>  		return 0;
> 


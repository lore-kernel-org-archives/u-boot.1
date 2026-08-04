Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FE8C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:56:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C40EE80DEA;
	Tue,  4 Aug 2026 21:56:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gt66K70tta8W; Tue,  4 Aug 2026 21:55:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6DB180DC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880549;
	bh=g1qV5hCpCZk0uDTEsk1FbybunAYkRfovAyXpiRu7dEI=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ffnu6wYyAqBeh3JWut+eHYC0h1Ca/5bX5evCJ+9Nc+U4vyTNACk0k9FFcBd8fmzL6
	 PKfxY5by5/ld5qgxWSRWue9QiTeznJNQtDToDtpCNFTOneFLaB+Di0Y01Gsz0sBVF0
	 J28Vpmi956OQxVd/NsEZg6o/1KE5amJkH5BcGM+Zx7sdTXgnBQOA2NoohrhUrcJLO0
	 jCl7WKceOdrLQFiNI+neeu22SRIHaVddz2hPLD713Hfyau1p6u4InoTgaVhdqR396w
	 GIrx6NKExUrzMNWMzRFpsOwU6LQy+Gd7XLehg1xziRRVq2dbuMbqEc+WdYeinTCGHP
	 hEGHfsKXxK8aQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6DB180DC3;
	Tue,  4 Aug 2026 21:55:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 10C57270
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EB2F140608
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YDXA4FCOKKjX for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 73C0C405D0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 73C0C405D0
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 73C0C405D0
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:40 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JoZJd3708031; Tue, 4 Aug 2026 16:55:36 -0500
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fufckce93-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:35 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GeFgBCUpAfd3jrQf/BvsCsP69UnAQlR9DdxUNKuiu2oadrELNeY3KnUitE2Z6XbHskJ8N8rsEavPmn0xKfyC36tTLe1U+zcNsNAD3hv3DK3kaCx04kTC8VyGZPS76b/nqQ8MgdrkOsNQOT6w4KT38CBCVWLsNu7SV/w9RvxzMNUa8huoNfd92K8fDPSFa9enU/h9BIS0q55SLr3zz34cFSPTCsrbWhcGMC2F51ABsmH+9JzEJpSW+sGnBnJiAHjhe4ATqRsKzhSdScLeOt/dPXk3baO0iL1o0/Gs9d+R+/AZrPs4spi8HeSWSQkx9EbjRhrYGSIWpA6YRqtI41k96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1qV5hCpCZk0uDTEsk1FbybunAYkRfovAyXpiRu7dEI=;
 b=aZqipaX1RP/nseL/ziukVmq23q+q3pNdXcNlWvVqKk5tne+bb/CoYlvQyOt2WVjJkBxuyyZ071SWHXStKmj8+4etDzjVTw8DMGtkT+DXUX4wEZne9ECkIpZ4riU8f0tQl9Vig0paoWyLo04LzeTfbLnH+cboD66m3bvWcgQS99W8zE0DiPwNswUKjok3d3KWguPtHkEMy9eCz77LJV+FwGkmgZTCJ0iw+j2vo5EiWDlT1+tAiuPiTLqfKC30ayD2DX2ZdEoTKfg5cBzKgVpI2DyxYb6Yg5g3iAD0JyeV9Z0PJBMgBAmcLUPbxmsqmPZaf28/URMoh4UvPeLpLc/AYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BYAPR21CA0026.namprd21.prod.outlook.com (2603:10b6:a03:114::36)
 by CO1PR10MB4644.namprd10.prod.outlook.com (2603:10b6:303:99::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:55:29 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::91) by BYAPR21CA0026.outlook.office365.com
 (2603:10b6:a03:114::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.4 via Frontend Transport; Tue, 4
 Aug 2026 21:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:27 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:19 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIuL968778;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:10 -0500
Subject: [PATCH v4 11/11] doc: board: ti: am62lx_evm: add initial docs for
 the AM62L-EVM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20260804-am62lx-v4-11-01746157643d@ti.com>
References: <20260804-am62lx-v4-0-01746157643d@ti.com>
In-Reply-To: <20260804-am62lx-v4-0-01746157643d@ti.com>
To: <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Anshul Dalal <anshuld@ti.com>, Simon Glass
 <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, "Bryan
 Brattlof" <bb@ti.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Aristo Chen" <aristo.chen@canonical.com>,
 Udit Kumar <u-kumar1@ti.com>, Andrew Davis <afd@ti.com>,
 Daniel Golle <daniel@makrotopia.org>, Johan Jonker <jbx6244@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=76242; i=bb@ti.com;
 h=from:subject:message-id; bh=WMjjM9PQCvzQo0r4rvW+izEmMzyXdi5MDW0HqYvC/i4=;
 b=owNCWmg5MUFZJlNZOabQRAAAZX///v/7Jqs9///2Ir6+8/77bt8/9h/9bf8Vdn+d/jPn5++wA
 RmYIekDQAAGgaAABoBo0NGgAAPUNAABo0AA9QGQaNPUGgAZAxG1NlNDJ41Q5NBpoAZGhpppo0GQ
 ABoaBiABphABoA0A00A0yAaMjTQ0A09IZNPSPRG1A9QYZQeo0aNGgAaDJo00xAA0AGjR6gxA0ZA
 NDQ0AyMgAGjNTTJpgTQxDI0MQAABBViQhL6fwHyDgRcu3zvcaI7AHRGAUxAsAFJE9QA950cj6/f
 JWZix3rfm15+kcvDafCx4wOhPMIIUlStUnhy8ALUPmJhimJvVkyikiWrss9tEjD8NJSoT/hZi5Y
 Gh0t0T5unCsIujrbMOuJEgP1EULAQ+4hu98VvFia9h/GU5Sfdn/MwPzBq27BsmAV/HpkpkjjkFZ
 RsOE79MRyk1gucEmCgrAVlGoxvtOHYzwQi1bxa+Lx+1yD1nVZ0eZGvmFDCFh8nakfVq/VSr2pEs
 f6VSOlRgVDB/CuXjDQTkgTmCjR9GqUBiQq+fOAxzKip8vcNEn2iPDxKvWY/I0ZwtwGF0RWF0hKd
 lSYKoNrhEISwtcYF/BR3QaQwMSUY5YRmmILWmyGSRuzAesQxZLrsHnspmBLSSJAyQAvlrDhkBdc
 B1ASBT/i7kinChIHNNoIgA=
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CO1PR10MB4644:EE_
X-MS-Office365-Filtering-Correlation-Id: f335bcdc-c884-4ada-398a-08def2731846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|23010399003|22082099003|18002099003|56012099006|3023799007|13003099007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: sgYFznCc7HR4Iqmm20lVZHsvfj2RBDA5nRg4ArgAzAvTtETPsfFTwFV0mCxN44rx25LrnMQmsDrtUwC8lbAxvBNwziGbzP4wGCbRuTg+b/Bl96zJ+/O7b7yfnnuSfdTt6QX0LMj7ztxul9dsLOQnDqc/3qUcNhB+V+bG85kfGnCmgsQZ53Y4aGTwA6P+ktg6NZZ85nGy3tKx/WtYW0o3dUjDvJyaqhA5b//kyOnF9kGpJPG045Fj9VjXDA8/PdtXj4NyeYWlFn6YWklv3mFxEWixOxqoI2gZXUWOUvTubi22OIjpwxNy6q5ZHbhPMV3Uam0LLZ3ZauczUjhTRNkYBTsglBCPJzGnDlUZc5JNVaYAMCuRPTuu4ERE6qqnq2VG4/moWi7p4Ks9PNVZRHQowxHN+GX9aqxpcXWTsV4vABFAnwNXByYgL8YaA+EzrDb85RcHV6E6z/S/Kb32b7bc/8ZAvkfaI8q/tKpDqLEqt2XkLwjNqhb4UUwbxti4QH+dYgp1/Wqk4P7rg4oBU52TgASPxeOQPiG5Em3ROlGoNLdrQioZ4f/6H9eVbVAssAdHt8HSybycb3D+xjA1dewOgDTS8/A9OIE8Uu5bq5OvlnGJcejpRreIGiuQKq19zs8w75ZUxHjARHJz52n4RFgy+A==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(56012099006)(3023799007)(13003099007)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yPqAo6PsdzReon0OBo/gOcR4syPaNfS8k0HkgOXfdqOWcnnyfBsQcqS2NcTtaRwr84xzQP72UJOshhx37xDBzX0Hxa72rpWsRlnqM/yAONl3xqmOh7CkSwaZZjvIQ3glo2J1JpKz+yYedU4Fi298nBv+gjy5vLLSBYWIzPJqpItnewIZ6ndm9ynBlA8wfMrRFRuGEG+72MUVKHz4T3W2dN+jDkNcAvHq510Hef1cuF1M5224t3fDvNphqQVQ8BFUps8KmduyAl7Yh0C6bs6N35Ea7VyPQEd+5CnfgT7+IXLG2UBXTo+DKZ7A+BwN6hNrAMmZtAw7gUsHnkasQ14pkIJF/zm1ZlWFjFzgkqU8zEyEk8mw0UN0j16SjPHr2VujCGTLW3PFyWM3RyTn3WOjKX9xSnnuiHC3ts5gNfvZok4dQA1g6xWfcdkjQT8gknFP
X-Exchange-RoutingPolicyChecked: N+xaIcfrlfAymEQtcXNSDIoUumgwptvjv9IzvNxNtpZD0LRLiaIw22RAZcCMU3dv9b9VBJNDjK4yf8L8BNlqWFTBDNasE/KJbzHr584i1F85jsfG8aUzDsKf31zL+OXA4m8D2mpR4TtYjgZ3CV5z3Ja0Ak4oFKSfkM62MEERvCB5mCzK0Vlx/JGiWZnxw8cMiIc/NwcgEpOto1SRltt3HJW/hVDI3IS7plAGdu9WQJn65NwqHf7DD5qglIhDxR/OlDhCCOU+NTDU04KNVWjrxcxOCuhWi3b5G/wpbK5qh7dTeOx+cTi5wG3UvCYdco/KRWZktn+UnXAuqC/Ge/KFug==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:27.4272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f335bcdc-c884-4ada-398a-08def2731846
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4644
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX/Jx8p18aQOdI
 LVNUV2jNHStPNaCzG23h8PwgguEzC9XrUGyu6Jw4LuAJzl9NACUfx1EFdOX32pkqvsfsI+pjsm4
 0ktsXi5PFR1oc6z+51niIVwtblimwrvMl6nYqZVIq42QR/rl/taC+m6wmjRRZdypM/GEmdl7gUb
 v30eilOCvHXuUgNVM5Hw3vS4Xi/yKZKftEPA/I7pwioX08/Cptsv6QA5rE9SgqTckmmodAzaIYR
 IZ5QEp+/7XSevtL0i1ONUo+eFq79vkki9kGQwKEJ4QkIu12efVAIgFDVk+feeS/wAwhOVyLAJ1Y
 PTYb8kv3H6spGSGLfiAoEaLR9Ft0G41aOe7sIuUYVGMNJ/Sf3sXXyG3BzYzXUJDYsfRhwmHoHBC
 e6YFLE0zgc10ifFt/zeNjXKTx6sUQP8QIEB9YIIIMv1tbdK36D6EjERaHhPp65MGYrszmoJTicT
 CCwSjmdsvtSQOMCqlJQ==
X-Proofpoint-GUID: poZSWyzIfev4ehbZntC53NXJCmN7Wja7
X-Proofpoint-ORIG-GUID: poZSWyzIfev4ehbZntC53NXJCmN7Wja7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX+3P4YHtux4tx
 O+FBl4P230BpZN9RxGI/2QpJATqeTohdFZPKXtwU0R28Cf+wtJGgNsaR5bscF2OOj3W5uXhzD98
 QBDHPuVObVXNAfkN9AAb5l/rUa9Pf/k=
X-Authority-Analysis: v=2.4 cv=GNA41ONK c=1 sm=1 tr=0 ts=6a725fd7 cx=c_pps
 a=VZSJMqPseUw/+4g/T0Awdw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=UXIAUNObAAAA:8
 a=VQ9ene8lAAAA:8 a=SSmOFEACAAAA:8 a=-sroTuYGUVUSb1OqqHcA:9
 a=3xtlNZgm3yEXo+T05C31pup2r18=:19 a=AxTp5yq5_KvQ3e5F:21 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a1s67YnXd6TbAZZNj1wK:22 a=5kMfGx23w8a0v5ansn-_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=g1qV5hCpCZk0uDTEsk1FbybunAYkRfovAyXpiRu7d
 EI=; b=owidTk3hKprMsd+xeABaBVfrltlH+vDBxk3pOUYL02QIzRpoP6O+L4gYE
 4ij4ar2NZsFVxv6ExX7XJyasdnc+3m2DRrdn6AvLgaV4DS37hwcsuJF7cveB792B
 bsqf5R+1gkXukVHny+iRQ3PkKWCPVjzYfa30mlOwQsVSwOCUlUmgWVCoy/m4WSLs
 n9SGGiyTT9OfIRf2PjZjp/qdvhy4jUMUF+3CJvlKGpE5Lxku1u9m6E4d5yk0jdsd
 yc/H9pr24BAiBx8i3pqA8NAOF6l3Tav/8F2KaAo0zmTf3PHjyDtu9cF4eMmRIHmL
 eSTx1x26N8VjwnT61cjWPuJCHSkNA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1qV5hCpCZk0uDTEsk1FbybunAYkRfovAyXpiRu7dEI=;
 b=u2wQvirEzwJLHzaqL+GL+VlxwFAslZXLVxq3DRdOsZSqfNaS5Z7OwwT4HVyGm2zZ3k/Zk1q8F7k4cX87Qlfm6pTjw3RuTXELL8sKJGGw5EqCw1biIRI0Zt2AcVm8qN2I7QfWATN1HIA74vVAjR4/LCdShfe/0Z2v2X1FLBr20ew=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=owidTk3h; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=u2wQvirE
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

Add the initial documentation on the bootflow, build, and deubgging
procedures along with the relevant links to more information about the
AM62Lx processor and the reference board.

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
Changes in v3:
- Used CROSS_COMPILE=$CC64 to align with other board docs
- Link to v2: https://lore.kernel.org/r/20260721-am62lx-v2-0-33ff580c267d@ti.com
---
 doc/board/ti/am62lx_evm.rst                     | 222 ++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase1.svg | 450 ++++++++++++++++++++
 doc/board/ti/img/am62lx_boot_diagram_phase2.svg | 525 ++++++++++++++++++++++++
 doc/board/ti/img/am62lx_tiboot3.bin.svg         | 170 ++++++++
 doc/board/ti/img/am62lx_tispl.bin.svg           | 222 ++++++++++
 doc/board/ti/img/am62lx_u-boot.img.svg          | 143 +++++++
 doc/board/ti/k3.rst                             |   1 +
 7 files changed, 1733 insertions(+)

diff --git a/doc/board/ti/am62lx_evm.rst b/doc/board/ti/am62lx_evm.rst
new file mode 100644
index 000000000000..84fdc1e710e1
--- /dev/null
+++ b/doc/board/ti/am62lx_evm.rst
@@ -0,0 +1,222 @@
+.. SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause
+.. sectionauthor:: Bryan Brattlof <bb@ti.com>
+
+AM62Lx Platforms
+================
+
+The AM62L is a lite, low power and performance optimized family
+of application processors that are built for Linux application
+development. The AM62L is well suited for a wide range of
+general-purpose applications with scalable ARM Cortex-A53 core
+performance and embedded features such as: Multimedia DSI/DPI support,
+integrated ADC on chip, advanced lower power management modes, and
+extensive security options for IP protection with the built-in security
+features.
+
+The AM62L is a general purpose processor, however some of the
+applications well suited for it include: Human Machine Interfaces (HMI),
+Medical patient monitoring , Building automation, Smart secure gateways,
+Smart Thermostats, EV charging stations, Smart Metering, Solar energy
+and more.
+
+Some highlights of AM62L SoC are:
+
+- Single to Dual 64-bit Arm® Cortex®-A53 microprocessor subsystem up to
+  1.25GHz Integrated Giga-bit Ethernet switch supporting up to a total
+  of two external ports
+
+- 16-bit DDR Subsystem that supports LPDDR4, DDR4 memory types.
+
+- Display support: 1x display support over MIPI DSI (4 lanes DPHY) or
+  DPI (24-bit RGB LVCMOS)
+
+- Multiple low power modes support, ex: Deep sleep and Standby
+
+- Support for secure boot, Trusted Execution Environment (TEE) &
+  Cryptographic Acceleration
+
+For more information check out our `Technical Reference Manual (TRM)`_.
+
+.. _Technical Reference Manual (TRM): https://www.ti.com/lit/ug/sprujb4/sprujb4.pdf
+
+
+Boot Flow:
+----------
+
+The AM62Lx SoCs deviate significantly from the typical boot-flow of the
+other Sitara or Jacinto class of SoCs.
+
+The first CPU released on power on will be the Security Management
+Subsystem (SMS) MCU to first secure the device like all other K3 SoCs.
+However because the lack of any MCU cores the boot ROM is located on one
+of the A53 cores which is responsible for loading TI's root-of-trust
+firmware (TIFS) along with a BL1 image generated from the
+ARM-Trusted-Firmware repository. The BL1 image is responsible for
+initializing the debug console, the DDR controller, and speeding up the
+A53 to it's maximum allowable.
+
+Once the BL1 is done, it will send a message back to the SMS core to
+reset and begin the second boot phase.
+
+.. image:: img/am62lx_boot_diagram_phase1.svg
+   :alt: First phase of the AM62L boot flow
+
+For the second boot phase, with DDR active ROM can now load the larger
+images contained in the tispl.bin (or whatever filename or offset was
+configured during the BL1 boot phase) which contains TI's root-of-trust
+firmware (TIFS) along with OP-TEE, TF-A's BL31 and U-Boot SPL images to
+initialize the root-of-trust, and the TrustZone and normal world for the
+A53s.
+
+From there the U-Boot SPL will load and authenticate U-Boot proper.
+
+.. image:: img/am62lx_boot_diagram_phase2.svg
+   :alt: Second phase of the AM62L boot flow
+
+Sources:
+--------
+
+.. include::  ../ti/k3.rst
+    :start-after: .. k3_rst_include_start_boot_sources
+    :end-before: .. k3_rst_include_end_boot_sources
+
+Build procedure:
+----------------
+
+0. Setup the environment variables:
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_common_env_vars_desc
+       :end-before: .. k3_rst_include_end_common_env_vars_desc
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_board_env_vars_desc
+       :end-before: .. k3_rst_include_end_board_env_vars_desc
+
+   Set the variables corresponding to this platform:
+
+   .. include::  ../ti/k3.rst
+       :start-after: .. k3_rst_include_start_common_env_vars_defn
+       :end-before: .. k3_rst_include_end_common_env_vars_defn
+
+   .. prompt:: bash $
+
+      export UBOOT_CFG_CORTEXA=am62lx_evm_defconfig
+      export TFA_BOARD=am62lx-evm
+      export OPTEE_PLATFORM=k3-am62lx
+
+1. Build Trusted Firmware-A:
+
+   More detailed porting and build guide can be found in the `TF-A
+   documentation`_ for all AM62L based platforms. For the AM62L-EVM the
+   build command will be:
+
+   .. prompt:: bash $
+
+      make CROSS_COMPILE=$CC64 \
+            ARCH=aarch64 \
+            PLAT=k3low \
+            TARGET_BOARD=$TFA_BOARD
+
+.. _TF-A documentation: https://trustedfirmware-a.readthedocs.io/en/latest/plat/ti-k3low-am62lx.html
+
+#. Build OP-TEE:
+
+   Depending on the application more build arguments may be needed. The
+   `OP-TEE documentation`_ has more information on this. The basic build
+   commands for the AM62L-EVM are:
+
+   .. prompt:: bash $
+
+      make CROSS_COMPILE=$CC32 \
+            CROSS_COMPILE64=$CC64 \
+            CFG_ARM64_core=y \
+            $OPTEE_EXTRA_ARGS \
+            PLATFORM=$OPTEE_PLATFORM
+
+.. _OP-TEE documentation: https://optee.readthedocs.io/en/latest/
+
+#. Build U-Boot:
+
+   .. prompt:: bash $
+
+      make $UBOOT_CFG_CORTEXA
+      make CROSS_COMPILE=$CC64 \
+            BINMAN_INDIRS="$LNX_FW_PATH" \
+            TEE="$OPTEE_PATH/out/arm-plat-k3/core/tee-raw.bin" \
+            BL1="$TFA_PATH/build/k3low/$TFA_BOARD/release/bl1.bin" \
+            BL31="$TFA_PATH/build/k3low/$TFA_BOARD/release/bl31.bin"
+
+Image formats:
+--------------
+
+The final images generated and needed for booting the AM62L are:
+
+- tiboot3.bin
+
+.. image:: img/am62lx_tiboot3.bin.svg
+   :alt: tiboot3.bin image format
+
+- tispl.bin
+
+.. image:: img/am62lx_tispl.bin.svg
+   :alt: tispl.bin image format
+
+- u-boot.img
+
+.. image:: img/am62lx_u-boot.img.svg
+   :alt: u-boot.img image format
+
+Switch Setting for Boot Mode
+----------------------------
+
+Boot Mode pins provide means to select the boot mode and options before the
+device is powered up. After every POR, they are the main source to populate
+the Boot Parameter Tables.
+
+The following table shows some common boot modes used on AM62L-EVM
+
+.. list-table::
+   :widths: 16 16 8 8
+   :header-rows: 1
+
+   * - Switch Label
+     - SW4: 12345678
+     - SW2: 1234
+     - SW3: 1234
+
+   * - EMMC
+     - 11010010
+     - 0000
+     - 0000
+
+   * - SD
+     - 11000010
+     - 0100
+     - 0000
+
+   * - UART
+     - 11011100
+     - 0000
+     - 0000
+
+   * - USB DFU
+     - 11001010
+     - 0000
+     - 0000
+
+Debugging U-Boot
+----------------
+
+See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
+detailed setup information.
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
+    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
+
+To start OpenOCD and connect to the board
+
+.. prompt:: bash
+
+   openocd -f board/ti/am62levm.cfg
diff --git a/doc/board/ti/img/am62lx_boot_diagram_phase1.svg b/doc/board/ti/img/am62lx_boot_diagram_phase1.svg
new file mode 100644
index 000000000000..fe10d1a253d8
--- /dev/null
+++ b/doc/board/ti/img/am62lx_boot_diagram_phase1.svg
@@ -0,0 +1,450 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="123.04372mm"
+   height="102.41046mm"
+   viewBox="0 0 123.04372 102.41046"
+   version="1.1"
+   id="svg1"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs1">
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="82.705078"
+       height="34.694588"
+       id="rect9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9" />
+  </defs>
+  <g
+     id="layer1"
+     transform="translate(-3.2156586,-61.395067)"
+     style="display:inline">
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9"
+       width="1.9329573"
+       height="85.898857"
+       x="41.939594"
+       y="77.774384" />
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9-2"
+       width="1.9329573"
+       height="25.09384"
+       x="84.430481"
+       y="86.003517" />
+    <rect
+       style="fill:none;stroke:#000000;stroke-width:0.264583"
+       id="rect1-9-2-7"
+       width="1.9329573"
+       height="38.677994"
+       x="84.382317"
+       y="124.9362" />
+    <path
+       d="M 14.252899,77.754344 H 41.775385"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 42.840209,71.544151 0.04093,6.233026"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 85.45604,71.406464 0.0087,14.680898"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 85.443487,111.04287 0.0036,13.97812"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6-8"
+       style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+    <path
+       d="m 122.1225,64.792094 0.056,98.568876"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       stroke-dasharray="3.175, 3.175"
+       pointer-events="stroke"
+       id="path272-4-6-4"
+       style="display:inline;fill:#d40000;stroke-width:0.264584;stroke-dasharray:0.264584, 0.529165;stroke-dashoffset:0" />
+    <g
+       id="g17"
+       transform="translate(-0.20732502,0.70490506)">
+      <rect
+         style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1"
+         width="16.069794"
+         height="8.8927412"
+         x="26.988451"
+         y="78.507072" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261"
+         id="text1"><tspan
+           id="tspan1"
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="34.991573"
+           y="84.456261">ROM</tspan></text>
+    </g>
+    <g
+       id="g17-1"
+       transform="translate(58.456195,8.5590037)">
+      <rect
+         style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1"
+         width="16.069794"
+         height="8.8927412"
+         x="26.988451"
+         y="78.507072" />
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261"
+         id="text1-5"><tspan
+           id="tspan1-98"
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="34.991573"
+           y="84.456261">ROM</tspan></text>
+    </g>
+    <g
+       id="g21"
+       transform="translate(0.30297529,12.998616)">
+      <g
+         id="g20"
+         transform="translate(-13.448192,1.681024)">
+        <rect
+           style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+           id="rect1-1-0"
+           width="16.069794"
+           height="8.8927412"
+           x="98.597946"
+           y="111.78242" />
+      </g>
+      <text
+         xml:space="preserve"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="text1-5-4"><tspan
+           style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+           x="93.599792"
+           y="119.41312"
+           id="tspan19">BL1</tspan></text>
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="20.957556"
+       y="76.900803"
+       id="text1-8"><tspan
+         id="tspan1-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="20.957556"
+         y="76.900803">H/W Reset Release</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="64.100334"
+       y="85.26165"
+       id="text1-8-2"><tspan
+         id="tspan1-9-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.100334"
+         y="85.26165">Release A53 ROM</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="64.140884"
+       y="104.34003"
+       id="text1-8-2-6"><tspan
+         id="tspan1-9-9-9"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.140884"
+         y="104.34003">Authenticate</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="64.140884"
+         y="108.15002"
+         id="tspan10">tiboot3.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="63.962883"
+       y="119.40052"
+       id="text1-8-2-6-0"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.962883"
+         y="119.40052"
+         id="tspan10-1">Reset A53 to</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.962883"
+         y="123.21052"
+         id="tspan16">BL1 Entry</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="63.822987"
+       y="155.86008"
+       id="text1-8-2-6-0-9"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.822987"
+         y="155.86008"
+         id="tspan10-1-6">BL1 Done</tspan><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="63.822987"
+         y="159.67007"
+         id="tspan15">Message</tspan></text>
+    <path
+       d="M 43.79186,86.012678 H 84.529679"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292"
+       style="stroke-width:0.264582" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8"
+       width="29.836563"
+       height="9.8913136"
+       x="88.656013"
+       y="97.899971"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-7"
+       width="29.836563"
+       height="9.8913136"
+       x="70.63903"
+       y="61.527359"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-7-9"
+       width="29.836563"
+       height="9.8913136"
+       x="27.875254"
+       y="61.689301"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-31"
+       width="29.836563"
+       height="9.8913136"
+       x="88.697792"
+       y="137.6286"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+       id="rect8-3"
+       width="29.756132"
+       height="9.9170303"
+       x="10.461226"
+       y="112.1797"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,55.945023,75.710672)"
+       id="text8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+       x="0"
+       y="0"><tspan
+         x="162.65117"
+         y="101.24414"
+         id="tspan3">Load </tspan><tspan
+         x="143.97914"
+         y="115.64414"
+         id="tspan4">tiboot3.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-22.357201,90.009926)"
+       id="text8-6"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+       x="0"
+       y="0"><tspan
+         x="152.34912"
+         y="101.24414"
+         id="tspan5">Validate </tspan><tspan
+         x="144.39711"
+         y="115.64414"
+         id="tspan6">tiboot3.bin</tspan></text>
+    <path
+       d="m 41.982847,77.762613 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 84.45369,86.024357 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-4"
+       style="stroke-width:0.264583" />
+    <g
+       id="g18"
+       transform="matrix(1.3039736,0,0,1,-13.367223,6.910834)"
+       style="stroke-width:0.875721">
+      <path
+         d="m 43.895114,102.59059 h 31.14238"
+         fill="none"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="stroke"
+         id="path292-5"
+         style="stroke-width:0.231701" />
+      <path
+         d="m 44.052705,102.59467 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+         fill="#000000"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="all"
+         id="path294-8"
+         style="stroke-width:0.231701" />
+    </g>
+    <path
+       d="M 43.737375,124.94556 H 83.348064"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292-5-4"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 84.175686,124.95576 -2.115358,0.92604 0.52884,-0.92604 -0.52884,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8-8"
+       style="stroke-width:0.264583" />
+    <path
+       d="m 122.19619,163.47482 -0.92604,-2.11535 0.92604,0.52884 0.92604,-0.52884 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8-8-9"
+       style="display:inline;stroke-width:0.264583" />
+    <g
+       id="g25"
+       transform="translate(0,-5.2916669)">
+      <path
+         d="M 43.847715,167.18481 H 84.499402"
+         fill="none"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="stroke"
+         id="path292-5-4-1"
+         style="stroke-width:0.264583" />
+      <path
+         d="m 44.02991,167.15364 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+         fill="#000000"
+         stroke="#000000"
+         stroke-miterlimit="10"
+         pointer-events="all"
+         id="path294-8-8-0"
+         style="stroke-width:0.264583" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="103.49282"
+       y="142.27876"
+       id="text12"><tspan
+         id="tspan12"
+         style="font-size:4.23333px;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="103.49282"
+         y="142.27876">Debug Console</tspan><tspan
+         style="font-size:4.23333px;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="103.49282"
+         y="146.08876"
+         id="tspan13">Init</tspan></text>
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+       id="rect8-2"
+       width="29.836563"
+       height="9.8913136"
+       x="88.51506"
+       y="149.61092"
+       ry="1.8797468"
+       rx="1.8797469" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="103.45767"
+       y="156.1178"
+       id="text14"><tspan
+         id="tspan14"
+         style="font-size:4.23333px;stroke-width:0.264583"
+         x="103.45767"
+         y="156.1178">DRAM Init</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="85.482224"
+       y="68.033394"
+       id="text26"><tspan
+         id="tspan26"
+         style="fill:#000000;stroke:none;stroke-width:0.264583"
+         x="85.482224"
+         y="68.033394">Cortex A53</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+       x="42.888348"
+       y="67.920227"
+       id="text26-8"><tspan
+         id="tspan26-3"
+         style="fill:#000000;stroke:none;stroke-width:0.264583"
+         x="42.888348"
+         y="67.920227">SMS M4</tspan></text>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:vertical-lr;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529167;stroke-dashoffset:0;stroke-opacity:1"
+       x="124.44329"
+       y="115.65893"
+       id="text28"><tspan
+         id="tspan28"
+         style="writing-mode:vertical-lr;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="124.44329"
+         y="115.65893">Time</tspan></text>
+  </g>
+</svg>
diff --git a/doc/board/ti/img/am62lx_boot_diagram_phase2.svg b/doc/board/ti/img/am62lx_boot_diagram_phase2.svg
new file mode 100644
index 000000000000..bac900ebd3eb
--- /dev/null
+++ b/doc/board/ti/img/am62lx_boot_diagram_phase2.svg
@@ -0,0 +1,525 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="115.94852mm"
+   height="145.69476mm"
+   viewBox="0 0 115.94853 145.69477"
+   version="1.1"
+   id="svg1"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs1">
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="82.705078"
+       height="34.694588"
+       id="rect9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9" />
+    <rect
+       x="138.88995"
+       y="89.244179"
+       width="83.540909"
+       height="29.679607"
+       id="rect9-9-6" />
+  </defs>
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9"
+     width="1.9329573"
+     height="60.20092"
+     x="31.628733"
+     y="16.379316" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-6"
+     width="1.9329573"
+     height="64.373627"
+     x="31.569685"
+     y="81.187851" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2"
+     width="1.9329573"
+     height="25.09384"
+     x="74.106453"
+     y="24.60845" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7"
+     width="1.9329573"
+     height="24.820444"
+     x="74.071457"
+     y="63.541138" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6"
+     width="1.9329573"
+     height="14.440828"
+     x="74.120178"
+     y="93.028458" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6-2"
+     width="1.9329573"
+     height="14.440828"
+     x="74.067307"
+     y="112.07141" />
+  <path
+     d="m 32.529347,10.149084 0.04093,6.233026"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.145178,10.011397 0.0087,14.680898"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.04042,49.654389 0.0036,13.97812"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 32.555322,76.438013 0.0036,4.872016"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.042581,88.228681 0.0036,4.872016"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 75.031791,107.33222 0.0036,4.87201"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4-5"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <rect
+     style="fill:none;stroke:#000000;stroke-width:0.264583"
+     id="rect1-9-2-7-6-2-7"
+     width="1.9329573"
+     height="14.440828"
+     x="74.062813"
+     y="131.12164" />
+  <path
+     d="m 75.027294,126.38245 0.0036,4.87201"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-8-9-4-5-0"
+     style="display:inline;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529166;stroke-dashoffset:0" />
+  <path
+     d="m 111.81164,3.3957745 0.056,138.2673655"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     stroke-dasharray="3.175, 3.175"
+     pointer-events="stroke"
+     id="path272-4-6-4"
+     style="display:inline;fill:#d40000;stroke-width:0.264584;stroke-dasharray:0.264584, 0.529166;stroke-dashoffset:0" />
+  <g
+     id="g17"
+     transform="translate(-10.518186,-60.69016)">
+    <rect
+       style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+       id="rect1"
+       width="16.069794"
+       height="8.8927412"
+       x="26.988451"
+       y="78.507072" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="34.991573"
+       y="84.456261"
+       id="text1"><tspan
+         id="tspan1"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261">ROM</tspan></text>
+  </g>
+  <g
+     id="g17-1"
+     transform="translate(48.145333,-52.83606)">
+    <rect
+       style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.264582;stroke-opacity:1"
+       id="rect1-1"
+       width="16.069794"
+       height="8.8927412"
+       x="26.988451"
+       y="78.507072" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="34.991573"
+       y="84.456261"
+       id="text1-5"><tspan
+         id="tspan1-98"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="34.991573"
+         y="84.456261">ROM</tspan></text>
+  </g>
+  <g
+     id="g21"
+     transform="translate(-10.007886,-48.39645)">
+    <g
+       id="g20"
+       transform="translate(-13.448192,1.681024)">
+      <rect
+         style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1-0"
+         width="16.069794"
+         height="8.8927412"
+         x="98.597946"
+         y="111.78242" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="93.599792"
+       y="119.41312"
+       id="text1-5-4"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="tspan19">BL31</tspan></text>
+  </g>
+  <rect
+     style="fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2"
+     width="16.069794"
+     height="8.8927412"
+     x="74.944"
+     y="94.379715" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="82.984222"
+     y="100.36663"
+     id="text1-5-4-28"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="82.984222"
+       y="100.36663"
+       id="tspan19-9">TEE</tspan></text>
+  <rect
+     style="fill:#f8cecc;fill-opacity:1;stroke:#b85450;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2-9"
+     width="16.069794"
+     height="8.8927412"
+     x="75.009903"
+     y="113.30912" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="83.459938"
+     y="119.2588"
+     id="text1-5-4-28-3"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="83.459938"
+       y="119.2588"
+       id="tspan19-9-1">SPL</tspan></text>
+  <rect
+     style="fill:#f8cecc;fill-opacity:1;stroke:#b85450;stroke-width:0.264582;stroke-opacity:1"
+     id="rect1-1-0-2-9-5"
+     width="16.069794"
+     height="8.8927412"
+     x="75.03476"
+     y="132.62766" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="82.852531"
+     y="138.55098"
+     id="text1-5-4-28-3-0"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="82.852531"
+       y="138.55098"
+       id="tspan19-9-1-3">U-Boot</tspan></text>
+  <g
+     id="g21-8"
+     transform="translate(-68.661248,-30.96516)">
+    <g
+       id="g20-7"
+       transform="translate(-13.448192,1.681024)">
+      <rect
+         style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.264582;stroke-opacity:1"
+         id="rect1-1-0-9"
+         width="16.069794"
+         height="8.8927412"
+         x="98.597946"
+         y="111.78242" />
+    </g>
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="93.599792"
+       y="119.41312"
+       id="text1-5-4-2"><tspan
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+         x="93.599792"
+         y="119.41312"
+         id="tspan19-0">TI-FS</tspan></text>
+  </g>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.789471"
+     y="23.866583"
+     id="text1-8-2"><tspan
+       id="tspan1-9-9"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.789471"
+       y="23.866583">Release A53 ROM</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.830021"
+     y="42.944962"
+     id="text1-8-2-6"><tspan
+       id="tspan1-9-9-9"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.830021"
+       y="42.944962">Authenticate</tspan><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.830021"
+       y="46.754951"
+       id="tspan10">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;stroke:none;stroke-width:0.264583"
+     x="53.65202"
+     y="58.005455"
+     id="text1-8-2-6-0"><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.65202"
+       y="58.005455"
+       id="tspan10-1">Reset A53 to</tspan><tspan
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;font-family:sans-serif;-inkscape-font-specification:sans-serif;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="53.65202"
+       y="61.815453"
+       id="tspan16">BL31 Entry</tspan></text>
+  <path
+     d="M 33.480998,24.617611 H 74.218817"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="stroke"
+     id="path292"
+     style="stroke-width:0.264582" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8"
+     width="29.836563"
+     height="9.8913136"
+     x="78.345154"
+     y="36.504906"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-7"
+     width="29.836563"
+     height="9.8913136"
+     x="60.328167"
+     y="0.132292"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="display:inline;fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-7-9"
+     width="29.836563"
+     height="9.8913136"
+     x="17.564394"
+     y="0.29423353"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264584;stroke-opacity:1"
+     id="rect8-31"
+     width="29.836563"
+     height="9.8913136"
+     x="78.386932"
+     y="76.233536"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+     id="rect8-3"
+     width="29.756132"
+     height="9.9170303"
+     x="0.15036553"
+     y="50.784637"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.264583;stroke-opacity:1"
+     id="rect8-3-5"
+     width="29.756132"
+     height="9.9170303"
+     x="0.1322915"
+     y="65.710831"
+     ry="1.8797468"
+     rx="1.8797469" />
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,45.634161,14.315605)"
+     id="text8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="162.65117"
+       y="101.24414"
+       id="tspan3">Load </tspan><tspan
+       x="153.55515"
+       y="115.64414"
+       id="tspan4">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-32.668058,28.614859)"
+     id="text8-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="152.34912"
+       y="101.24414"
+       id="tspan5">Validate </tspan><tspan
+       x="153.97311"
+       y="115.64414"
+       id="tspan6">tispl.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-34.238568,43.502747)"
+     id="text8-6-9"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;white-space:pre;shape-inside:url(#rect9-9-6);display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-opacity:1"
+     x="0"
+     y="0"><tspan
+       x="145.15712"
+       y="101.24414"
+       id="tspan7">Boot TIFS </tspan><tspan
+       x="147.90111"
+       y="115.64414"
+       id="tspan8">Firmware</tspan></text>
+  <path
+     d="m 74.142828,24.62929 -1.85208,0.92604 0.46302,-0.92604 -0.46302,-0.92604 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-4"
+     style="stroke-width:0.264583" />
+  <g
+     id="g18"
+     transform="matrix(1.3039736,0,0,1,-23.678085,-54.48423)"
+     style="stroke-width:0.875721">
+    <path
+       d="m 43.895114,102.59059 h 31.14238"
+       fill="none"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="stroke"
+       id="path292-5"
+       style="stroke-width:0.231701" />
+    <path
+       d="m 44.052705,102.59467 1.85208,0.92604 -0.46302,-0.92604 0.46302,-0.92604 z"
+       fill="#000000"
+       stroke="#000000"
+       stroke-miterlimit="10"
+       pointer-events="all"
+       id="path294-8"
+       style="stroke-width:0.231701" />
+  </g>
+  <path
+     d="M 33.426513,63.550493 H 73.037202"
+     fill="none"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="stroke"
+     id="path292-5-4"
+     style="stroke-width:0.264583" />
+  <path
+     d="m 73.864824,63.560693 -2.115358,0.92604 0.52884,-0.92604 -0.52884,-0.92604 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-8-8"
+     style="stroke-width:0.264583" />
+  <path
+     d="m 111.88533,142.46714 -0.92604,-2.11535 0.92604,0.52884 0.92604,-0.52884 z"
+     fill="#000000"
+     stroke="#000000"
+     stroke-miterlimit="10"
+     pointer-events="all"
+     id="path294-8-8-9"
+     style="display:inline;stroke-width:0.264583" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="93.181946"
+     y="82.699966"
+     id="text12">SCMI Init</text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="75.171364"
+     y="6.6383266"
+     id="text26"><tspan
+       id="tspan26"
+       style="fill:#000000;stroke:none;stroke-width:0.264583"
+       x="75.171364"
+       y="6.6383266">Cortex A53</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:lr-tb;direction:ltr;text-anchor:middle;display:inline;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-opacity:1"
+     x="32.577484"
+     y="6.5251598"
+     id="text26-8"><tspan
+       id="tspan26-3"
+       style="fill:#000000;stroke:none;stroke-width:0.264583"
+       x="32.577484"
+       y="6.5251598">SMS M4</tspan></text>
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.23333px;line-height:0.9;font-family:sans-serif;-inkscape-font-specification:sans-serif;font-variant-ligatures:none;text-align:center;writing-mode:vertical-lr;direction:ltr;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;stroke-width:0.264583;stroke-dasharray:0.264583, 0.529167;stroke-dashoffset:0;stroke-opacity:1"
+     x="114.13243"
+     y="68.022209"
+     id="text28"><tspan
+       id="tspan28"
+       style="writing-mode:vertical-lr;fill:#000000;stroke:none;stroke-width:0.264583"
+       x="114.13243"
+       y="68.022209">Time</tspan></text>
+</svg>
diff --git a/doc/board/ti/img/am62lx_tiboot3.bin.svg b/doc/board/ti/img/am62lx_tiboot3.bin.svg
new file mode 100644
index 000000000000..17b9a8538881
--- /dev/null
+++ b/doc/board/ti/img/am62lx_tiboot3.bin.svg
@@ -0,0 +1,170 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236633mm"
+   height="85.065804mm"
+   viewBox="0 0 62.236632 85.065803"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+  </defs>
+  <rect
+     style="fill:#ffe6cc;fill-opacity:1;stroke:#d79b00;stroke-width:0.22289;stroke-opacity:1"
+     id="rect51238"
+     width="62.013744"
+     height="84.842911"
+     x="0.11144508"
+     y="0.11144508"
+     ry="9.4566326" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406042"
+     y="25.645016"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-8"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406042"
+     y="12.612378"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="38.677654"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9-1"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="51.705704"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9-1-2"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406042"
+     y="64.733757"
+     ry="0" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+     x="20.600019"
+     y="7.8484602"
+     id="text53682"><tspan
+       id="tspan53680"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+       x="20.600019"
+       y="7.8484602">tiboot3.bin</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.52916667,17.991672)"
+     id="text79829"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831)"
+     x="56.255871"
+     y="0"><tspan
+       x="83.140137"
+       y="60.311719"
+       id="tspan1">TF-A BL1</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.17044751,5.285958)"
+     id="text79829-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6)"
+     x="56.255871"
+     y="0"><tspan
+       x="43.948105"
+       y="60.311719"
+       id="tspan2">x509 User Certificate</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.0933935,30.897375)"
+     id="text79829-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2)"
+     x="56.255871"
+     y="0"><tspan
+       x="38.292099"
+       y="60.311719"
+       id="tspan3">Encrypted TIFS Binary</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.06460892,41.158058)"
+     id="text79829-6-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2)"
+     x="56.255871"
+     y="0"><tspan
+       x="35.4673"
+       y="60.311719"
+       id="tspan4">TIFS Board &amp; Security
+</tspan><tspan
+       x="52.220093"
+       y="80.311719"
+       id="tspan5">Configuration Files</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.08028719,57.131985)"
+     id="text79829-6-8-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8)"
+     x="56.255871"
+     y="0"><tspan
+       x="35.196075"
+       y="60.311719"
+       id="tspan6">TIFS Vendor Certificate</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.98430343,17.372352)"
+     id="text79829-2"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4)"
+     x="56.255871"
+     y="0" />
+</svg>
diff --git a/doc/board/ti/img/am62lx_tispl.bin.svg b/doc/board/ti/img/am62lx_tispl.bin.svg
new file mode 100644
index 000000000000..d2c9d7d56951
--- /dev/null
+++ b/doc/board/ti/img/am62lx_tispl.bin.svg
@@ -0,0 +1,222 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236744mm"
+   height="111.84308mm"
+   viewBox="0 0 62.236743 111.84308"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3-9" />
+  </defs>
+  <g
+     id="layer1"
+     transform="translate(5.4851174e-5,5.4851174e-5)">
+    <rect
+       style="fill:#d5e8d4;fill-opacity:1;stroke:#82b366;stroke-width:0.255676;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51238"
+       width="61.981068"
+       height="111.5874"
+       x="0.12778315"
+       y="0.12778315"
+       ry="8.4550943" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478"
+       width="48.173313"
+       height="13.032638"
+       x="6.9406042"
+       y="25.645016"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-8"
+       width="48.173313"
+       height="13.032638"
+       x="6.9406042"
+       y="12.612378"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="38.677654"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="51.705704"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="64.733757"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2-3"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="77.76181"
+       ry="0" />
+    <rect
+       style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+       id="rect51478-9-1-2-3-7"
+       width="48.161327"
+       height="13.02805"
+       x="6.9406042"
+       y="90.789864"
+       ry="0" />
+    <text
+       xml:space="preserve"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+       x="23.345928"
+       y="7.5099988"
+       id="text53682"><tspan
+         id="tspan53680"
+         style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+         x="23.345928"
+         y="7.5099988">tispl.bin</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.52916667,17.991672)"
+       id="text79829"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831)"
+       x="56.255871"
+       y="0"><tspan
+         x="78.844223"
+         y="59.175719"
+         id="tspan129104">TF-A BL31</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.17044751,5.285958)"
+       id="text79829-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6)"
+       x="56.255871"
+       y="0"><tspan
+         x="42.572357"
+         y="59.175719"
+         id="tspan129106">x509 User Certificate</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.0933935,30.897375)"
+       id="text79829-6"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2)"
+       x="56.255871"
+       y="0"><tspan
+         x="36.972336"
+         y="59.175719"
+         id="tspan129108">Encrypted TIFS Binary</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.06460892,41.158058)"
+       id="text79829-6-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2)"
+       x="56.255871"
+       y="0"><tspan
+         x="37.980316"
+         y="59.175719"
+         id="tspan129110">TIFS Board &amp; Security
+</tspan><tspan
+         x="50.868347"
+         y="79.175719"
+         id="tspan129112">Configuration Files</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.08028719,57.131985)"
+       id="text79829-6-8-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8)"
+       x="56.255871"
+       y="0"><tspan
+         x="34.524368"
+         y="59.175719"
+         id="tspan129114">TIFS Vendor Certificate</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,0.12491591,70.050492)"
+       id="text79829-6-8-8-8"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8-3)"
+       x="56.255871"
+       y="0"><tspan
+         x="88.596207"
+         y="59.175719"
+         id="tspan129116">OP-TEE</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.31574226,83.33275)"
+       id="text79829-6-8-8-8-3"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2-2-8-3-9)"
+       x="56.255871"
+       y="0"><tspan
+         x="75.300201"
+         y="59.175719"
+         id="tspan129118">U-Boot SPL</tspan></text>
+    <text
+       xml:space="preserve"
+       transform="matrix(0.26458333,0,0,0.26458333,-0.98430343,17.372352)"
+       id="text79829-2"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4)"
+       x="56.255871"
+       y="0" />
+  </g>
+</svg>
diff --git a/doc/board/ti/img/am62lx_u-boot.img.svg b/doc/board/ti/img/am62lx_u-boot.img.svg
new file mode 100644
index 000000000000..b20ab1a491ed
--- /dev/null
+++ b/doc/board/ti/img/am62lx_u-boot.img.svg
@@ -0,0 +1,143 @@
+<?xml version="1.0" encoding="UTF-8" standalone="no"?>
+<!-- Created with Inkscape (http://www.inkscape.org/) -->
+
+<svg
+   width="62.236744mm"
+   height="59.627434mm"
+   viewBox="0 0 62.236744 59.627435"
+   version="1.1"
+   id="svg51133"
+   xmlns="http://www.w3.org/2000/svg"
+   xmlns:svg="http://www.w3.org/2000/svg">
+  <defs
+     id="defs51130">
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-4" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-6" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3" />
+    <rect
+       x="20.016691"
+       y="45.512157"
+       width="194.45363"
+       height="67.070183"
+       id="rect79831-2-2-8-3-9" />
+  </defs>
+  <rect
+     style="fill:#dbe4f4;fill-opacity:1;stroke:#8166b3;stroke-width:0.255676;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51238"
+     width="61.981068"
+     height="59.371758"
+     x="0.127838"
+     y="0.127838"
+     ry="8.4550943"
+     rx="8.4550943" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406586"
+     y="25.645071"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195943;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-8"
+     width="48.173313"
+     height="13.032638"
+     x="6.9406586"
+     y="12.612433"
+     ry="0" />
+  <rect
+     style="fill:none;fill-opacity:1;stroke:#000000;stroke-width:0.195884;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
+     id="rect51478-9"
+     width="48.161327"
+     height="13.02805"
+     x="6.9406586"
+     y="38.677708"
+     ry="0" />
+  <text
+     xml:space="preserve"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;stroke-width:0.264583"
+     x="20.700148"
+     y="8.0392199"
+     id="text53682"><tspan
+       id="tspan53680"
+       style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:4.58611px;font-family:Helvetica;-inkscape-font-specification:Helvetica;stroke-width:0.264583"
+       x="20.700148"
+       y="8.0392199">u-boot.img</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.52922115,17.991727)"
+     id="text79829"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="92.724136"
+       y="60.311719"
+       id="tspan1">U-Boot</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,0.17050215,5.2860127)"
+     id="text79829-8"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-6);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="77.404114"
+       y="60.311719"
+       id="tspan2">FIT Header</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.09333885,30.89743)"
+     id="text79829-6"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-2);display:inline"
+     x="56.255871"
+     y="0"><tspan
+       x="74.772141"
+       y="60.311719"
+       id="tspan3">U-Boot DTB</tspan></text>
+  <text
+     xml:space="preserve"
+     transform="matrix(0.26458333,0,0,0.26458333,-0.98424885,17.372407)"
+     id="text79829-2"
+     style="font-style:normal;font-variant:normal;font-weight:normal;font-stretch:normal;font-size:16px;line-height:1.25;font-family:Helvetica;-inkscape-font-specification:Helvetica;font-variant-ligatures:none;text-align:center;white-space:pre;shape-inside:url(#rect79831-4);display:inline"
+     x="56.255871"
+     y="0" />
+</svg>
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index b7b69949af16..56df72b656bd 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -33,6 +33,7 @@ K3 Based SoCs
    am62ax_sk
    am62dx_evm
    am62x_sk
+   am62lx_evm
    am62px_sk
    am6254atl_sk
    am64x_evm

-- 
2.54.0


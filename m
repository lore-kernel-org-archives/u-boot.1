Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637F7C55ABA
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 21:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 034B280BB6;
	Tue,  4 Aug 2026 21:55:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ruCLR-PUDuVi; Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3D8B880C8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785880534;
	bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR2M=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rfD8IePo2K6GORHMlk8iRAP2JU7bWRCFoSt5AwWIYLrMPLO0tfQOFCoKz/FFWC+3X
	 5eXFdv7UUJF+b6P5RrPkeySnZ3S+8X+jquCl85lZ5Z4dr+r6LOfdS0M+ITj7YrJH0w
	 VmC4DNfjmKcnYpZI8OW9gmPfiFNcKNwcJfpW9QAPtqeGtPkA1FOOdJ54eEEIG6Y2h8
	 MIpb5fjdeNUE2UPucvnpiwLTsEPax6GmjXhV9VqJZL8Y5ZKR9tX1UNBJ+hJnO7RyzT
	 BLJyf7AQGfXTzwTV1CBRfefnr3q5tkYqCwU8zUUsj49PEMVfwNBPtwK8oNTGQBYU4M
	 aAZVYYBEtt02Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3D8B880C8D;
	Tue,  4 Aug 2026 21:55:34 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD1E3270
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BACCD80BB6
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LZ2N1zS4DyJv for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 21:55:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=bb@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9CBD080B9C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CBD080B9C
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CBD080B9C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 21:55:30 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JoQIA3359177; Tue, 4 Aug 2026 16:55:26 -0500
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fufc6vc7h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 16:55:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hbUL+2l+SLKzTFOI0D4KT0h8rdokion2uRRF402W6JJU/qDngVMUlPjmAryQOmIiNdKOtk1y7hx7XJxNJdpGJbjh+blpMLZNoZVksZGHe2eJTJqLzb0QPtW+wnQK0ASeqJBOtwuudHUhJECBVZRygjct+gWVpfPUE5xzEZNinnoqndyV2UuH5qaL273BarVNs2Ze1FbzydyEK+v9xlbNr/BjpDFEY3mgtcg3E56Z5I3YQR0hfUNatixog1mAfe/+/wn+9LNQHzIs4VJV/2hA5aphGtp/MT/Q2JD5SUJG1mHxFKJHv7XwbakxZHW5pnKhmGcpfzDG1q9ICiDtumQHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR2M=;
 b=wrtZp27+641YDK6gzaHVXfPJ7inLmJZ1Idb/Dcz9ibvVIC32kVedNLW4vDiP/2aZGBX44fxi16zAqnoaGOTzkelbjiLTZtRCnGlHDMemTnzj3eHVIVuxCJnesoDDYMFMfRUuR4QC57GlswTfwTreK5DjbLcfXOMleTqahsERQn9xps/18tC7KecRLVpYgpLkF7xmK9cAaOrRqT7ngHMcHf2CR8VYyl8JdvLhEnO+NhaxvrOvOFEdOpre8wfeJtGgcBD6YvivBj5n4Vb66DmyOOijkZAlH83XZiuhZ9RpiDjjYCOUYD+pQjTflztGa/8wI6lB35RoNRGggnZrCbJihQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BYAPR21CA0017.namprd21.prod.outlook.com (2603:10b6:a03:114::27)
 by DSVPR10MB997913.namprd10.prod.outlook.com (2603:10b6:8:3bc::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 21:55:23 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::4c) by BYAPR21CA0017.outlook.office365.com
 (2603:10b6:a03:114::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.4 via Frontend Transport; Tue, 4
 Aug 2026 21:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 21:55:21 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 16:55:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 16:55:18 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674LtIEJ968760;
 Tue, 4 Aug 2026 16:55:18 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Tue, 4 Aug 2026 16:55:00 -0500
Subject: [PATCH v4 01/11] firmware: scmi: switch to dev_ofnode during bind
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260804-am62lx-v4-1-01746157643d@ti.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=bb@ti.com;
 h=from:subject:message-id; bh=IOghikEu84fmeGzPxMKke7PQOWnvLutUaeS9Qt2bCUk=;
 b=owNCWmg5MUFZJlNZG08GPAAAY////775/v2zWP+f4rfx37i/9+D69b+kz/et8V7//Lf/+uewA
 RmsDtQaAAZANAAAAA0NAAAADQGmmhoAB6jR6hoNNBo00epk0eo0A0NNGTIfo1RBgTTCGgZNMjQ0
 GgZAwCDQGQBoGhhNGmCYg0ZDQAAGmjTTI0aAAGgDQw5PU0aDGo9T1GQGgHqADTQBiZANNBoADRo
 ANqDI9JoAAA2oGhkyB6gAaGnqACxbXFdUt7nuV4ocQlwIZIp4QufRsWY+MaewiiHKaFcQZPgH4b
 RAv+oqnlaycg+9vCOkgc6WwRy53hRM2Si629gE02Y7QcXYjakUP2PtDGMB2tqvOCuCxN+VtQYRz
 VY+e4uhUN9mlo0CnTD8fF2MstE/ikVs+YMgzDWAN7vXgnWH4PencWOjGoswaojulBAJJeUISEMC
 7SQGAm0yJAr9Z1DTHq9XCNmukuWCfMiGyIOE+KBIDrb7kHrSOiaRMbxpb5D4M0LGKgLdfsTqFyg
 8MOzLHEZdMgEQCobBWh6A4BSw2QA9Rn+f61CJuI8C3svt7uk+KWVhlhvig2IzJzYBKYLy/AuMz4
 jPQejvuvZJRDvq+NDYZwkW+3JchWISilmJgf5BtHCgBvP5GpU+IO4k0qtE4ud+1JOYQApIMI1hK
 CfzXX/F3JFOFCQG08GPAA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DSVPR10MB997913:EE_
X-MS-Office365-Filtering-Correlation-Id: dc13776e-5fec-44ba-26d9-08def2731503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|36860700016|1800799024|82310400026|3023799007|22082099003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 6J+dG9l2RBmNBesJfRJZy5E7IoxC0if+kWn9nd/1UhjsHwmv/fzryti0Gt3vzU1axbrPcHHq+rp9qFWtwp/weaaAVfWJL/pYiPUt40gRljfpLHvb7MlYSFANvEIgE8kOqpiOJr3rFWdb5miilW7S61aGl9SyLEF7WvdVvoSYNtjoeoWY6hkBJHJzP7E0S4tn8cNZHGTY5TY+KkFn7jAk41mQUuRSVmQ2+UnsOFvP/6E6HaIhUA+jjXE98+n8uAwJPQcpnWeTj7/fl5A6n5CX6Oux6YFGeQXJkPRHi2kB4XegbXdyctnuD3KMQWnph99AwSSPZ8NkHMoee0ez1YA7DAo3RJ+xy3vRLNfw+ZGEkSxycm5Z6LUustEBeJZUmXqWdvy9TEkLXoryhCyO04L6oag7xqAxRBlqogL+ngYftYVN5qsyyC247wNiF+mfoVZmEHwaT1nJaME8ro18EVcaHKlgQs0rotQbRg6IWS+DsUKkJg6L9iwvAZwF54CYwIDNu3J368aq3r2i3c/PkIxvPP0AXfi07OtyM6jowvmMx+k6Jy5HerAAIM9588nks+kkPtQFaNraJ8h19jGryXMHYFtCcMtFW28B4QlViHw0gZe4l7Xgn+Fy2MYHx7GFR1cyfEnhRe0xasnW1cSA702mazatZ1UkjNPtfU/iTeeZ9X5zkekgQUULLko1GMyF865a0MLRWIsGvyU16x+asUI5xA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(3023799007)(22082099003)(18002099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cXvoF34JBMZZMd9kOzNsp4rgm2aXWyNCILzcFTmwCOlfn0cEsGDto+asKJqI+br1B5xqra6iNMfsTOh9vi+2Iz6a+FytnS/RZ8EPFEB79fj8WpEwbTwAIdjKAnSgbLPj2/sCH8iVo8MNmEpMYAqdixrXt6cvhqVQwqVhDquxg/zdLgeI5sBaPUAUo3FH1I3TMBvhNKS17jS6j0lWaFXvbuYjXl7ytuZIrFvBdGlqM3BRmlF/he5RnHrtg1CKveuaq87pmZm5OTkg2fklHfvFinkxzkf3So/Kvl1CW8atOBEo0JxwZI3t+MMhFPh04Ce/f440DYb1vaoy3rjk1FjNzhcK8rMOL30PxZGneQGxDEy4i1Dij17KC6kqY4AwpLXVU2eunD6w78z3cRtBo4fwyYtw4ZM9L+AyfwlrubMAMVl5HXnyCbLzOVUa70uUhpyi
X-Exchange-RoutingPolicyChecked: Nv4ob+fzkD/ugjkJyUFJvwr1EIm1SsDouxj0i9hMDEY7DNo+CTh0+ySpeyMQAsG9YF4c3eGSlSYzmU1NvSxwagmJY6UR5AkuSTgsXLvy2SPSIP4X4z2krfJY6YGi1pKN0CHKydUERNRLsWecloMenhcnw9TN6nHmXSGXpGxex78vZws3WcGs5G0iXWs0W/f2gmcxSCXCg8EbHZmScpg7mBbkik/r+jbF2SChLebtFuvQ8TjGcluxxSGtgacfQFX46n9kYdPC+jEiRgertJ+R9yOwFTluOFR5ff1hLRC/FI4BmdVQg6YxtN/PFw6RsYASnvecgegQ1wpXzPrs4eDyBQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 21:55:21.9572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc13776e-5fec-44ba-26d9-08def2731503
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR10MB997913
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfXz5jFCjKQIUd2
 WdDRnGef/vKiDhnJspTdvrPJyNHgoIj8YgpRB9JG5u2KqJXajHmqIq7KTDk/qji8T98hFRqpZ2E
 cMX0LMnA41bE/NBTFNoP9yMQpR9iBHsFX33LNnr9HB4ap5YrQvNXXowM3ffnwXkbr1QOy7iXxuo
 eDoH6RmWIQkQGofVlQtsQ0trBWcMUgKpA+HBpa7oyGoLY8MD/6eSDXig8EoHdrbdX/cDNkVRzN8
 InTJEDCTqfQuCWC1v6jjvW0gg/P2+nUwxVMPaBsDH6iX8ezblptsSXMYIyFGquuSagyYjtj+11m
 eIUSErov+hpUzj0uAAeohzz+Y2Sag8bXGt5q9KweQ3WYd4qZX66cgEDtP+j+XjOro3eqB4Uq3yR
 /ZD0swfdq2sV3gF/1iPyKpT+HPAywudxy8SgNsqVFAt1bcgori38MlV8EDAJCwT76PgJPZZcO9N
 Hb0GNcOhcuf+Kl5Khiw==
X-Proofpoint-GUID: ICuaTfLjAocS8AHkrbNh-nbkUX0E3FNP
X-Proofpoint-ORIG-GUID: ICuaTfLjAocS8AHkrbNh-nbkUX0E3FNP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NyBTYWx0ZWRfX1nSUgu3B5cQD
 sSzEEdMO/SWogaOVmL1fiNBfQRN28Jl96JfCpP0LHe+G7tYGZay1VR7/j9J6RxECVLzFkWwIzSc
 yf30s6XXi8wy2ipJEXQl90M7XFuoWNE=
X-Authority-Analysis: v=2.4 cv=Va3H+lp9 c=1 sm=1 tr=0 ts=6a725fce cx=c_pps
 a=Zi+2/POLpdgQ9anv5Nu4tw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=TV3iowGqRpE46p_suTMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040177
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR
 2M=; b=HIkuD0LTEQeykWyYfFHu9VIsIyVcUWslXm5LKyQgDpzCYUrvtsDpBiFNz
 YfXhPo8rFULhsCBEbx5SBikOJ85HA0QRLybV3LpcSdyl63AVdyR0J46pUWlUhWMl
 zqBcnMF9fo6uF2pBOpYXTQwE5JBfwLWtRSH+VQpE12Nt87Ep9X9p70XIeqvT4NRf
 w17xjOw7LrC6973QdNcWLjLo/oFdfx20Rbsq1PSCQTMViJsraEgoVnVErGt0NWy8
 gtV3JRIY4Li4du9CsfiwkHLA8bpkDLNhDZU0dFhHUivW6RnzSBHo9G7l//PzjLpG
 J4y+u5zTlQLnr4Xz/ZY8kN56n8Imw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=keQ38pwlEtk8UnZcEsv5W4C/FJX+ZzQzAkevFEQkR2M=;
 b=ufCxb7kbwr0YnXc076QIurlh0FJzpxP853ZTgLco7Bbg65mOUqRLyVZElS6GBmox5s7B3hzIuoiS8LGQi1ZXZKuhKug93DGYOWJs9b8otW3VFGYasFbt6rGhrgtiSLB86vPOkdYp/bXMUglXWiLwxLdor/ndGLoyYbdISfJHa9I=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HIkuD0LT; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=ufCxb7kb
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

From: Anshul Dalal <anshuld@ti.com>

When using ofnode_null() the node offset passed to the FDT API will be
-1 which is invalid and breaks probe. Switch to dev_ofnode()

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cd458a7f4588..65c1ddad2b57 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -437,7 +437,7 @@ static int scmi_bind_protocols(struct udevice *dev)
 	/* initialize the device from device tree */
 	drv = DM_DRIVER_GET(scmi_base_drv);
 	name = "scmi-base.0";
-	ret = device_bind(dev, drv, name, NULL, ofnode_null(), &proto);
+	ret = device_bind(dev, drv, name, NULL, dev_ofnode(dev), &proto);
 	if (ret) {
 		dev_err(dev, "failed to bind base protocol\n");
 		return ret;

-- 
2.54.0


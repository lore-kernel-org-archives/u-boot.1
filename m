Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B34CFC4452B
	for <u-boot@archiver.kernel.org>; Tue, 21 Jul 2026 18:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 624BA605D8;
	Tue, 21 Jul 2026 18:09:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id E6DTQlpOAF9r; Tue, 21 Jul 2026 18:09:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 01BA86085A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784657346;
	bh=0gDY2XcHq00LXMIE4NutuxSOfiJqA61Uw02aFD3+tB0=;
	h=Date:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=evPCFa6WBru4Pe7/VkTPquCqNaSkZDUmII1B2hEj06pzODG7VtgJ08owaDJIRhnK/
	 JBapkOIF6Ew7Ff4uDl9NoPGvHn6OEti7wWRVqmBR2cXCEz4T+oEP9yiW9g7Ke6HuiX
	 w3TE7ZJQK6/nahMdXhhpg4E7FJUtpURxPYeEIMdmC7Lt3kD9sQQyfP4tKn/eAdOFfa
	 XDrD7ZXvoVuwYO/caDjLA1e0EupoPuWPUVUHvzVP0k/lpyzrIcsW1pHpePl2v4YGv0
	 Ci3LCqyAtyu3J42dOqGtRgrqAm84bn0hWYvz51vGaRpFTQWn5nGAuPvh/ZAlSyPn0/
	 7VgT3AWgkh01w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 01BA86085A;
	Tue, 21 Jul 2026 18:09:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C6F7C313
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:10:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C3EF24007F
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PodA3XNqvr_0 for <u-boot@lists.u-boot-project.org>;
 Tue, 21 Jul 2026 17:10:07 +0000 (UTC)
X-Greylist: delayed 680 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 21 Jul 2026 17:10:07 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 2524D40051
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2524D40051
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=afd@ti.com; receiver=<UNKNOWN> 
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2524D40051
 for <u-boot@lists.u-boot-project.org>; Tue, 21 Jul 2026 17:10:06 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH62jA1403752; Tue, 21 Jul 2026 12:09:51 -0500
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fj7q92a69-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 12:09:50 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjkfOLQYkMEY6VOp1PEkXMick0+XpOjuUyOs4M+gowheUjE48Z05WOcCj9grvWjdFHmMlRxrw7+XAwnDzlR0R20U2e5ShabO0Wy7oUqDplY6AtKbvcs2e/E8TB5aDA7V8IfTJshO71G2Pt2kJ6LhtX4zT8o02zwqT7DTj6OgFJ0IteeqlPmnW4sKZkJFsNckaH7z0sdbSi9esPNf1rBhIenhRT8saJv/TBTti5yWNFRV7lK+2ehv5QKoPvsuynKVZGrBEsVd6xAUtrbj+obMQD7U9jw+2RGoNgLb7lQlr0gIdhRafvprAcWLFLh75XoTZGEsOwU2TLLk4qKgHAAXvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0gDY2XcHq00LXMIE4NutuxSOfiJqA61Uw02aFD3+tB0=;
 b=JDCti8DSvFiNrRN9BbNuqC7u0Qk9bGGe5ijkhJccPdFr4JVJBM35xX1KTLYTZb6/YAZF913Dbtbr0+SOtxncpM0NKH/4BIhrykdVaOmVaRg3dME6/qj+u3xAciivneAM+FtA9mNHyfcOSrT0xtTbSpc1vQvJt4Si/i9glpIEd4NnudzFnAE0c0T8kWlNiiHuk1kvujp9Gq0qn8q/HGvlQXqxQ3cy0gCvq78Fv1qwVdJDKYWVHX0LLx7HqsQHkj76MZmPfAROfnoFfZeglBryO6E4CDqJG23L0tQdrYEP+w/Zr2p8Mye9PToKLpvR+pOgnWZxwxr7SpatHypSJVSqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from SA0PR11CA0010.namprd11.prod.outlook.com (2603:10b6:806:d3::15)
 by PH7PR10MB5880.namprd10.prod.outlook.com (2603:10b6:510:127::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Tue, 21 Jul
 2026 17:09:43 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:d3:cafe::35) by SA0PR11CA0010.outlook.office365.com
 (2603:10b6:806:d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 17:09:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 17:09:43 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 12:09:41 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 12:09:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 12:09:41 -0500
Received: from [10.249.42.149] ([10.249.42.149])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66LH9dtS1835903;
 Tue, 21 Jul 2026 12:09:40 -0500
Message-ID: <7f65e636-f2f6-4604-81d4-09e27ed6264e@ti.com>
Date: Tue, 21 Jul 2026 12:09:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] doc: board: ti: correct path to tcl scripts
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.denx.de>,
 <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent (TI.com)"
 <kory.maincent@bootlin.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Daniel Golle <daniel@makrotopia.org>, Rasmus Villemoes
 <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>
References: <20260721-am62lx-v2-0-33ff580c267d@ti.com>
 <20260721-am62lx-v2-10-33ff580c267d@ti.com>
Content-Language: en-US
In-Reply-To: <20260721-am62lx-v2-10-33ff580c267d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH7PR10MB5880:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef87e25-65f6-4b0a-3f90-08dee74adbc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|13003099007|18002099003|22082099003|6133799003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: aWrRap2FxVOrIDf08nLCiBqp/UptrZFBARyLhPtyL2DigKnywosqI4MWZTojEI9fUmOi2zfdmQe+Tq9Ahvdw1OB18e03MxCm9BnrgKI/gzsOWEHZtn+lrVsiz3kxs/BNJKP+ik0Q/zsvvbUyT6617ReeFfhEryYAXZBNotpbKhNzSUiXMplJh5ndlqmpCcYcfiu/BnbO+snhvE1KcJNGJUfvhwcOb/Yu5w34kDBExyfIKp/SqXAphhF4ge6IKNSzGBLJB9BuonYKRpbWbEXYzgDlI2n8KJz2Dn1w5H+m0axFZLjmTuLF7eHySLKGMrr+5hfv47LD8KqeRBccJEzLBvEycxRGTFCucmczZa6t525PW4Y4osEBuHi7QkrFFW7MuWls3BMYm65Pzlamzgk341cszy58FimbYliwlI0mk/ZqoLta/3d8XNxrOu+dAClhhc2HTT345FRZQoqVCxNJO68xzXJj7PE0YsWU0SrBklZRQZGCkBRTUk1ZqJ5HlOAlxngyiMGC2ZAgmZ00YLVXRtxVv7Ao4FLfQuc1CDlVU/JLtj7Cp2eJNoQAH0n20miKbRAA7qg+kE3QwXt0LYNMdfk7+1Jcmkvo6REKRfUTQ/OXqAdcCC8uKai9DLeIxQwJL98jn3kvLLl1oTg+MWlm6UVRLdZi3G6FPHFWMQLdJMVN0eT1G20FzqIg3/DCJAHW51U9PW2qspHAyLXhj3fBjw==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(13003099007)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 312rVR19OmaH3BNSelcF7kYxlVBKDxSgWMAUJOeBjnMC1ZeVybJlK9Tpz68T8hJVNExt10TgIVAQS51Ton+//foMdvV3E4JX60ugNLNhIHNCnL3HcVmaDbyH8M9siZ5+67rUUiRzxIZRGYziHfFBBlpsgdJy9f680v5CJAdSojJl2MLBBeP44I1osFNNUQ+727H52nIV0ROfCQYXNSXvkr0stLB7TbKODbbCJZpcI78SFPcLpNojpdrYBb+oDRjoaby+YaCGomAeoxT4Z1vzwveSh7uLFa5uxAavUkk8F5AouPJLwcH4Xt2sETy1NPcLiXy1RYlZu2wyUGIP6XIR0EP/4pSMb/m0Q8sf+XRTtqgYgcWE1BGpvv3pwAC+sWREpUa/CZkVptESWn+wHLxo4Qf9RH7WfuXXJLZe24P8qcmAKnb5OfKrj7UwdngE1uhJ
X-Exchange-RoutingPolicyChecked: TlILkgaxYv+LhrqPkci3+4aATntSN/KTzGgW54YnC88p4+febqlTUquqr8LU7qxWxeupAvese/kcdEU5PQHC2bFtqdKnXTVCpBkhW9NtS8m9zop97+hDj45PFdVZ3TCTrl4GdqtPMFZ7PvnaoxH8J1J+iLIU3AgVLwp63s7AJHJA8NdEaeuDVdeLUR3rzuvEA6IgHN9H0uRQLp3C1kUsoJn9vYOX7TNNJkORFqFxA/vuhyJlfXznakTJ8++Xa+dYE271cXa5DaZ3a5R1IIdtS9pxL6R9Z3fqz0tcVBQmpak2TxaGoOTN9EVpmCRP79y4d9ZrHc6AK7R9gwpuSDZxrA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 17:09:43.3399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef87e25-65f6-4b0a-3f90-08dee74adbc9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5880
X-Proofpoint-GUID: iIgzFK2UqAKQWuN2UCr0ScrKVV9hsgWu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE4MSBTYWx0ZWRfX8ZoKqln1Fpdk
 yVZoSmO+U+zDt7Ce9Rjf3n2JdBoZr688L8avPPO83NOvIVKYrChjf10P+bK/R46rZe0VzjfBfFz
 jHZ+/uISFLGfIMxz9BW44teaDkoyLtE=
X-Authority-Analysis: v=2.4 cv=CsmPtH4D c=1 sm=1 tr=0 ts=6a5fa7de cx=c_pps
 a=FTqHLmxhk7TnHmysD/QBZQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=NEAV23lmAAAA:8
 a=sozttTNsAAAA:8 a=SkW4hyKvUGof_Kt9jCIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iIgzFK2UqAKQWuN2UCr0ScrKVV9hsgWu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE4MSBTYWx0ZWRfXxWwMnZf1kFa7
 71+/0uk3tTnQWO6HFjG1x7kSHBU8VSjasjhgy0mjXlZY0NQmxfwQieHYS6YagUEIrblRW1KcoWy
 mVdnHF4jUBNhv+THV4PcBfoTVymLyFOal7ixJm2F+50OlppKfdlprCoReR/TbDz4mfcsEAfAMKK
 Q+IK0EXfpforDGqWy6bQymUoMTFAx3/QwxwrmDhgvw3+dSEvHW9ZKchaitwhjuwIkVT4r7fsyRq
 jw60uUqQ2ikaJF9zBlGFAMe8zm7xlJNFs5HkM4LuFCIEK89D2kh4foMPEqDv4AarZlDpJ27K+f7
 NAiysaBeuny7d420g9DpqFXet/mIp214aff7fCvNZwyGZ3+V1+/uQJv6SZH0Wv8WU6W4Obbujst
 U5RUNIY91KsWzxHYkxzlfzvOGuh70UIZsoEnZQ3enQg4NOOwfvn4g2RYP204TlOCOZsPixmSM3+
 UenV8Aaoz6vCOgjMxYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1011
 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210181
X-Mailman-Approved-At: Tue, 21 Jul 2026 18:09:05 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=0gDY2XcHq00LXMIE4NutuxSOfiJqA61Uw02aFD3+t
 B0=; b=cZ+LFRSkksutnfFur+gdhHLrMK3JRR2DJt92DVz2rsNw8CgDQWnAgRKhB
 DNwaN8iSamyXm1mvoWuZW3jnI1uAk96m+Vc4insvwS0AEo/HNTIWnds/DVh8mz1y
 am8zq7IM3kS6XLUwWkjdAagLUYe+1Q4iyfUT/MeCgPRd6QQ3UDfSTHX5cg+cPHj5
 YEWMSvccGFVYSTnM1Yk03ZoRYKZReqf9nJf6WyrOvVDHTpO+EoXpEakOiXDWkXyG
 L5wu23b7rKNyvBGb4d8YUT0ntJHlgg3wTV8YgHiRaQIfNYKaho86CHQDkPYYKPFp
 ELRuBU2O1PXNqW+KyxH6AaL+fgkig==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0gDY2XcHq00LXMIE4NutuxSOfiJqA61Uw02aFD3+tB0=;
 b=Qhwvay2sg2NKZjoF6R9nln5/qXv35d9VAuj683FNHjSbIh/Ck3O2V5pb2xDMjBDimAkiyLJh+o8hxCT65RCrYsDBm2POwpo6MqrUsg6oWfg3LPCuNu5mPcpZ8KqKRD5N6KY0bpBxLfGJv5BuNlPQufutqUSf4cSYut0/L0zHqEU=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=cZ+LFRSk; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=Qhwvay2s
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
From: Andrew Davis via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Andrew Davis <afd@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/21/26 10:30 AM, Bryan Brattlof wrote:
> OpenOCD has moved where it has placed the tcl scripts for TI's reference
> boards. Update their paths to the new locations
> 
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>   doc/board/ti/am6254atl_sk.rst | 10 +---------
>   doc/board/ti/am62ax_sk.rst    | 10 +---------
>   doc/board/ti/am62dx_evm.rst   | 17 ++++++-----------
>   doc/board/ti/am62px_sk.rst    | 12 +-----------
>   doc/board/ti/am62x_sk.rst     |  9 +--------
>   doc/board/ti/am64x_evm.rst    | 17 +++++++++++++++++
>   doc/board/ti/am65x_evm.rst    | 10 +---------
>   doc/board/ti/j7200_evm.rst    | 10 +---------
>   doc/board/ti/j721e_evm.rst    | 10 +---------
>   doc/board/ti/j722s_evm.rst    | 12 +-----------
>   doc/board/ti/j784s4_evm.rst   | 10 +---------
>   11 files changed, 32 insertions(+), 95 deletions(-)
> 
> diff --git a/doc/board/ti/am6254atl_sk.rst b/doc/board/ti/am6254atl_sk.rst
> index 18a3520b39c7..7f919b10a8d7 100644
> --- a/doc/board/ti/am6254atl_sk.rst
> +++ b/doc/board/ti/am6254atl_sk.rst
> @@ -289,14 +289,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support since**: v0.12.0

This info might still be useful for folks on older distros still shipping
an older OpenOCD (e.g. Ubuntu 22.04 is still on OpenOCD 0.11.0). Probably
doesn't need to be a "warning" though at this point, maybe just a "note".

Andrew

> -
> -  If the default package version of OpenOCD in your development
> -  environment's distribution needs to be updated, it might be necessary to
> -  build OpenOCD from the source.
> -
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -305,4 +297,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_am625evm.cfg
> +   openocd -f board/ti/am625evm.cfg
> diff --git a/doc/board/ti/am62ax_sk.rst b/doc/board/ti/am62ax_sk.rst
> index 6f3432f7895c..2b338569aad6 100644
> --- a/doc/board/ti/am62ax_sk.rst
> +++ b/doc/board/ti/am62ax_sk.rst
> @@ -224,14 +224,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support since**: August 2023 (git master)
> -
> -  Until the next stable release of OpenOCD is available in your development
> -  environment's distribution, it might be necessary to build OpenOCD `from the
> -  source <https://github.com/openocd-org/openocd>`_.
> -
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -240,4 +232,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_am62a7evm.cfg
> +   openocd -f board/ti/am62a7evm.cfg
> diff --git a/doc/board/ti/am62dx_evm.rst b/doc/board/ti/am62dx_evm.rst
> index 0d12e3ec1476..28f62914b3bc 100644
> --- a/doc/board/ti/am62dx_evm.rst
> +++ b/doc/board/ti/am62dx_evm.rst
> @@ -235,16 +235,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **AM62A**: OpenOCD support since August 2023 (git master)
> -
> -  **AM62D**: Uses AM62A configuration (compatible due to same core architecture)
> -
> -  Until the next stable release of OpenOCD is available in your development
> -  environment's distribution, it might be necessary to build OpenOCD `from the
> -  source <https://github.com/openocd-org/openocd>`_.
> -
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -253,4 +243,9 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti/am62a7evm.cfg
> +   openocd -f board/ti/am62a7evm.cfg
> +
> +.. note::
> +
> +   The AM62D-EVM uses the same tcl configuration as the AM62A-SK due to
> +   same core architecture.
> diff --git a/doc/board/ti/am62px_sk.rst b/doc/board/ti/am62px_sk.rst
> index 44dae4afc870..d2696282033c 100644
> --- a/doc/board/ti/am62px_sk.rst
> +++ b/doc/board/ti/am62px_sk.rst
> @@ -329,16 +329,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support after**: v0.12.0
> -
> -  While support for the entire K3 generation including the am62xxx
> -  extended family was added before v0.12.0, the tcl scripts for the
> -  am62px have been accepted and will be available in the next release of
> -  OpenOCD. It may be necessary to build OpenOCD from source depending on
> -  the version your distribution has packaged.
> -
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -347,4 +337,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_am62pevm.cfg
> +   openocd -f board/ti/am62pevm.cfg
> diff --git a/doc/board/ti/am62x_sk.rst b/doc/board/ti/am62x_sk.rst
> index ef9425035cb8..ab5dee1ac775 100644
> --- a/doc/board/ti/am62x_sk.rst
> +++ b/doc/board/ti/am62x_sk.rst
> @@ -851,13 +851,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support since**: v0.12.0
> -
> -  If the default package version of OpenOCD in your development
> -  environment's distribution needs to be updated, it might be necessary to
> -  build OpenOCD from the source.
>   
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> @@ -867,4 +860,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_am625evm.cfg
> +   openocd -f board/ti/am625evm.cfg
> diff --git a/doc/board/ti/am64x_evm.rst b/doc/board/ti/am64x_evm.rst
> index 65c4c456528c..dbbdfe0e8036 100644
> --- a/doc/board/ti/am64x_evm.rst
> +++ b/doc/board/ti/am64x_evm.rst
> @@ -227,3 +227,20 @@ https://www.ti.com/lit/pdf/spruim2 under the `Boot Mode Pins` section.
>   
>     For SW2 and SW3, the switch state in the "ON" position = 1.
>     Boot bits on SK is reversed bits to the bootmode signals
> +
> +
> +Debugging U-Boot
> +----------------
> +
> +See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
> +detailed setup information.
> +
> +.. include::  k3.rst
> +    :start-after: .. k3_rst_include_start_openocd_connect_XDS110
> +    :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> +
> +To start OpenOCD and connect to the board
> +
> +.. prompt:: bash
> +
> +   openocd -f board/ti/am642evm.cfg
> diff --git a/doc/board/ti/am65x_evm.rst b/doc/board/ti/am65x_evm.rst
> index 60b08ceebf0f..12fa955d2bf5 100644
> --- a/doc/board/ti/am65x_evm.rst
> +++ b/doc/board/ti/am65x_evm.rst
> @@ -305,14 +305,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support since**: v0.12.0
> -
> -  If the default package version of OpenOCD in your development
> -  environment's distribution needs to be updated, it might be necessary to
> -  build OpenOCD from the source.
> -
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -321,4 +313,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_am654evm.cfg
> +   openocd -f board/ti/am654evm.cfg
> diff --git a/doc/board/ti/j7200_evm.rst b/doc/board/ti/j7200_evm.rst
> index 4fd2aff83547..74bce4b465d7 100644
> --- a/doc/board/ti/j7200_evm.rst
> +++ b/doc/board/ti/j7200_evm.rst
> @@ -216,14 +216,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support since**: v0.12.0
> -
> -  If the default package version of OpenOCD in your development
> -  environment's distribution needs to be updated, it might be necessary to
> -  build OpenOCD from the source.
> -
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -232,4 +224,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_j7200evm.cfg
> +  openocd -f board/ti/j7200evm.cfg
> diff --git a/doc/board/ti/j721e_evm.rst b/doc/board/ti/j721e_evm.rst
> index 41c8d4c72a8d..1302e080d8a8 100644
> --- a/doc/board/ti/j721e_evm.rst
> +++ b/doc/board/ti/j721e_evm.rst
> @@ -245,14 +245,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support since**: v0.12.0
> -
> -  If the default package version of OpenOCD in your development
> -  environment's distribution needs to be updated, it might be necessary to
> -  build OpenOCD from the source.
> -
>   .. include::  ../ti/k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -261,4 +253,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash $
>   
> -  openocd -f board/ti_j721eevm.cfg
> +   openocd -f board/ti/j721evm.cfg
> diff --git a/doc/board/ti/j722s_evm.rst b/doc/board/ti/j722s_evm.rst
> index 4b5cf0275940..5a4ae11a2eb6 100644
> --- a/doc/board/ti/j722s_evm.rst
> +++ b/doc/board/ti/j722s_evm.rst
> @@ -237,16 +237,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support after**: v0.12.0
> -
> -  While support for the entire K3 generation including the am62xxx
> -  extended family was added before v0.12.0, the tcl scripts for the
> -  am62px have been accepted and will be available in the next release of
> -  OpenOCD. It may be necessary to build OpenOCD from source depending on
> -  the version your distribution has packaged.
> -
>   .. include::  k3.rst
>       :start-after: .. k3_rst_include_start_openocd_connect_XDS110
>       :end-before: .. k3_rst_include_end_openocd_connect_XDS110
> @@ -255,4 +245,4 @@ To start OpenOCD and connect to the board
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_j722sevm.cfg
> +   openocd -f board/ti/j722sevm.cfg
> diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
> index ec82228ab908..48decd8d3d64 100644
> --- a/doc/board/ti/j784s4_evm.rst
> +++ b/doc/board/ti/j784s4_evm.rst
> @@ -643,14 +643,6 @@ Debugging U-Boot
>   See :ref:`Common Debugging environment - OpenOCD<k3_rst_refer_openocd>`: for
>   detailed setup information.
>   
> -.. warning::
> -
> -  **OpenOCD support since**: September 2023 (git master)
> -
> -  Until the next stable release of OpenOCD is available in your development
> -  environment's distribution, it might be necessary to build OpenOCD `from the
> -  source <https://github.com/openocd-org/openocd>`_.
> -
>   Debugging U-Boot on J784S4-EVM and AM69-SK
>   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>   
> @@ -663,4 +655,4 @@ following.
>   
>   .. prompt:: bash
>   
> -  openocd -f board/ti_j784s4evm.cfg
> +  openocd -f board/ti/j784s4evm.cfg
> 


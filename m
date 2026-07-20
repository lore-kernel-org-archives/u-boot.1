Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48772C4451B
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 08:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A63C48488B;
	Mon, 20 Jul 2026 10:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="AGhU6e3G";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZYRso0fc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A708488B; Mon, 20 Jul 2026 10:09:31 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3B8A82991
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 10:09:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=b-padhi@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66K6Tvjs1455411;
 Mon, 20 Jul 2026 03:09:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=eXrAFHuL5x3fN
 6sLxhpib+l07VPJKE1v0PyUCXcNgTw=; b=AGhU6e3GFlQ1brtTTm8iJ6y2vcH3K
 Kp+KLEyTQ6wh1wKqGh4zet8JcmOMWmSt+tQKMpV0XN5V2W6tvtJDNXrhA7pkD7BL
 y13jcdKorwHWpLBUOt68NYjO6uqA5g2ACcXY7BOu9XgMw8oOq5QQYaJ3dJAF3HTI
 rDkh0cWWz4VAtc8PJoHNldGgB+29MU1UDBVZSW4mmySaX+yJhOcBJXCyC3yRxK3T
 r3Da4Hgip11RYbskADdQAlG1D+zjmNPRJLrH1YYSLQpFvhN8aI7/SXK74o8nZ8p6
 MIpeitlFjuksllcYEdMKgzDb7t1z9uVvBWbnGD8RykzWbfE4R2oAJ0R4A==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fgtgh4nnq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 03:09:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJjjBljhVJpgRNCSw+Q0jGrBVJXIu5CNJCF0WqdRck83AYSUCk6BZGWoKKNR/5JfKA6ocdfHV6e8WXpExVl0m6ftCo59hH+bvzYknb28cOlpxD/ya3Jf0SA/Eu7onZ00mZZH/L7UB0MF3AFxnZotMLdh7dWF9LivhjjuH4Mt2gOaFjVm8X7ZkYSl9msHBETcB8AKi5c8q4s0CMcXGfrIKuotlghM02SgUq6m9RpQojFYyr1BIr6z81eo6WE9z2pLOZsdtMk0htvejGxMhSRkNoaR+PC2pi14B1+FblXkAi89zec2mSGdMP4IaFdNL3VjRSBdqhe3L8HW6HcHyGU3fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXrAFHuL5x3fN6sLxhpib+l07VPJKE1v0PyUCXcNgTw=;
 b=LoRCvKwUu3T765wjp/LbRjD9tupTuv7UcHg2n+gMTzXDsLR3nPqfyqUWcgp/iRrY34URJjNOiXQlfon8FTOL24c7kDd2CrdGPkspNk9VrGNGGQ616PC79YTEDw8APItGyY+QMnOLcsPTtqEFixzZseSm/AqGlfRBjfdgSNdGgg2XMZIaCHjpTbUVDTTMhbU9Os/uiJqFct/se+L5/uOw4h5sx1UkHjXkIaqWghL1nmkhkbEBllqXVIijmD3IeuY0qD2KgY3icyT1y7FPxIhxiYGKPAqLgbp72Kfv1X3nxs9MqT8XT6wlgY/OAXg9Gyf5lVAM5f6A47+xb0sMlhpVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXrAFHuL5x3fN6sLxhpib+l07VPJKE1v0PyUCXcNgTw=;
 b=ZYRso0fcw8o1sM6bbXx/2peu5ti03x0EaGagrkOG8KHjbOsnxVe+wLHJn9G+i0K6LmrVna3vWhp8vYa/glO/myJi35aDr4r8+9fD61MO3KSmBUBRWkuEaSAm0mxlS0onFnCuVozNp0msbYc7oL+F/2kigP+Z03upTKIlICZBvmA=
Received: from SJ0PR03CA0101.namprd03.prod.outlook.com (2603:10b6:a03:333::16)
 by SJ5PPFC322FD87E.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.16; Mon, 20 Jul
 2026 08:09:21 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:333:cafe::97) by SJ0PR03CA0101.outlook.office365.com
 (2603:10b6:a03:333::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 08:09:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 08:09:20 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:08:54 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 03:08:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 03:08:54 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 66K81FFl2478591; Mon, 20 Jul 2026 03:01:16 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.denx.de>
Subject: [PATCH v5 0/7] Add support to boot TI K3 HSM M4 core
Date: Mon, 20 Jul 2026 13:31:07 +0530
Message-ID: <20260720080114.775206-1-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SJ5PPFC322FD87E:EE_
X-MS-Office365-Filtering-Correlation-Id: ba680501-0aa1-41e9-8c09-08dee63633d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|13003099007|18002099003|56012099006|5023799004|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: dF8yLcqfCf2ecr/uonl5+BQgu4ZrvFSWxxDM37E6PqEodsx96AAPjWwuIsAKQyI+uUzOHSTG6MqCo2trMbqhtPRd1EU124hJYLo36yscdzJwxRoXTvHYpbAp0xnahaZl7sue5bvyBWjAL7RRthd8B1eRHwIfzpuoVHZmuSHgSIQQtN9Xl3dWnZ6Re6jP0Q90NVCEHFRnrZYGypcDgy4g9IummR5m5o4p8SFKwolzlorIVXJmCyi8LKOweGBN+sCOjmMpD/Kpt6OAkuMNkMWZu6OhmpWnSNWQicPiwyELgt7VILA/jNrFs1qnAJIHfVSCBi8NHh4KYr9+TWwXBE1y9idhPCHG2SLXpEAOCcBTyHoYrDRxwleN7MOK90IlPuFhpTH1whI5bcsoiUpfEOmlJK78KdYkk7AJqramsdpeMcEw9cSX76393sbdSzg+oyWGot1zvtdxp9FqxmeZ29jOiSOitbctG1Y6XrVmjWPPpDpq55niTvyQAN+KSsOPQ6IVMnh8BWiN+nTpfouisEJjI4Kn37O5FhmGaO2ExU6+z3fncmJ3EbsLoco0jq27KSXUdZPjsoiDyxgGtPFCmxlukRMwEvdHzz0as1z+enbv/poqNHM7o4wvYIyrAy8Cf7RSPb0uEVtM6yBR9IjKfmH5+YhUliQlU6/erRpF29i/UaGXYv1fF5KsYHcLYRH3Yf0ri/fFr6kPaGRuVQI21p+kXw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(13003099007)(18002099003)(56012099006)(5023799004)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9iXGA5RR0gvcxJHc19HFdqJzbIJjBr0BJKK3RlC9OS0myhxsodaK6ELqO3XhfZgVSsZTskhcQ+MLtBdtJLGLbrwO1VpIepvhdWuJ164ysJh9H3cvi3L4R9ku8CtWVvzZkqcyJjw7/t4fDzB/XqChgDpw6gbve3pWZIVMt4bvYlkBvzuVFfL8rSNKfkdP6jI1dgIIVjuEyX6uR4hre8ZCKen59NRMPYL7NgyDz93P8vBDrWvadZg2cXhTUQ01MGsWTP7N2N4cRYN2vWgRfbqJt/q22aP2SGMxyYuJkm2bxGyNLVuzW/2fX5Fzngeaybq+2WlgUgD1xMjqI2cKOcbN2q+pDZemGYWHGbbT/CRc92lTtmXDeT6CKPzPr31I0bWjjaDmtVGsseo7D4IjkWkYw0PR2rEs92dmnd0ufG0/RYsGcSpCH9ojRu81c5PC3mcl
X-Exchange-RoutingPolicyChecked: pfdEx33eJloQnZ51Q3Sxv+WJIlPCppMIQhSrxGSyIayW2N+SeVavfPDTo2D6mydaENw12Xznf4uymy+3jfhqSY7zM+WrupmF416rHsfO7FWFn+nBagoDSHoA1h7SdcNz/UHV5whx9ubHEx2RlBiqvtfliAjji8PNJja5tVplfAtTKWkbmgGaB15tPS9+nnbT5nVf5FmTIcYgea2HK/3KGUNqO6lNVM2ECmVQvTqkRrV6FFq6CkLa77JlUKimGYj7qbJLzxanFqKY7iiQ+ZfAgTqHoBnbUK18ArdrxMdljVhKVoCbq5VyuM9KCkAjXrX7v1M7PGZUcQemIR5hg1sLoQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 08:09:20.4059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba680501-0aa1-41e9-8c09-08dee63633d4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC322FD87E
X-Proofpoint-GUID: S2GGImnzCUbYaJsHz4l9BDd6rS3bRCE7
X-Authority-Analysis: v=2.4 cv=LtiiDHdc c=1 sm=1 tr=0 ts=6a5dd7b5 cx=c_pps
 a=aTIAhetxxWeNPRurEgqQXA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=dpLPJb8wM8soDziOgqwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX2NrAqvkFBi0D
 8dIQgHSamijo4MJprouh5jW5ZuOub47/cm19VrpYSLT1PjHPQTJi+kPb8aZ+nE+qZmGf8dRissr
 qU81VthWcGYCXuPBcVjEG2Bi/8bwQYchwRABYnVqPCIk1EamIDaM2Mh/mUwmmwtGwPc/7EPoDD/
 huDhMolcq9UUDTntB5Za+aY4YV2HeiY/cREy9mjHcUfWoHfmy7O5yG6UC55EhIFUnKFK4t+Y657
 8xIDu7ugJdfRSibqKsYugdA/odz06FrEeExqD2OqXqGXAgaooH1rfTwVet7Xi6pfyqE2Dbb97h2
 pB5zIDiaOUxkHmjShPV7v4WZdJy98tW5kjClkgy44vHZ1XMxQ7eBcP/dghP4kqbRF2CivijtpdH
 LoylG6mFhkzUQHyDeixGbpmESp1FCUyatG4GHvgzr2OBMUAUSwMxZUnvHbZXGOqzwy1ddrTiMcv
 xGXGgHUc0fm2R/X1qmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA5MCBTYWx0ZWRfX/LSkz5jel5md
 oketdZAnG/fQ4lCxQeJ6SR5ZlJQBNU/CHu7qvC2+DkPo9HF/3Ppy++2lYG6lJgcfpbtOYFtvm9U
 XfXY6tnWybTHS+1i1Ar47BpPasI7tTg=
X-Proofpoint-ORIG-GUID: S2GGImnzCUbYaJsHz4l9BDd6rS3bRCE7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200090
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
Module) M4F core in the Wakeup Voltage Domain which could be used to
run secure services like Authentication. Boot flow for HSM M4 core is
different than the general purpose M4F cores, and is as below:

1. Request control of HSM M4F remote processor.
2. Assert Reset on the HSM M4F remote processor.
3. Request Secure Entity to Authenticate and Load HSM firmware into
   core's internal SRAM memory region. For GP device, load the firmware
   manually into core's SRAM region.
4. Deassert Reset on the HSM M4F remote processor.
5. Release control of HSM M4F remote processor.

This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
firmware is packed inside the tispl.bin fit image. The firmware is
unpacked into a temporary DDR address which is then used to load HSM
core. The configs to boot HSM M4 core are disabled by default.

Additional documentation on HSM M4 core usage:
https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-j784s4/latest/exports/docs/linux/Foundational_Components/U-Boot/UG-HSM.html

v5: Changelog:
[Simon]:
 1. Add 'depends on SOC_K3_J721S2 || SOC_K3_J784S4 || SOC_K3_J722S' for
    KConfig options.
 2. Use hyphens in DT property names and underscores in python code.
 3. Add comments to explain DT property values and link to ti-sci
    documentation
 4. Use lower-case hex for DT property values.
 5. Use consistent whitespaces.
 6. Add property documentation in function docstring.
 7. Log missing properties for boot and load extension groups.
 8. Update tests to check the load and boot sections contain the
    expected values from test DTS. Add negative tests to check it raises
    an error when some of the properties are missing.
 9. Driver improvements: Size check before memcpy(), type-casting, and
    checking device type via get_device_type().
 10. Invoke ti_secure_image_post_process() only once for HSM images.
[General]:
 1. Explicitly mention the load address of the HSM image in the FIT.
    Don't rely on U-Boot to assign a fallback load address. Use a
    Kconfig option to specify the HSM load address.
 2. Pick up R/B tags from Neha and Simon.
 3. Squash various patches together as they are atomic.

Link to v4:
https://lore.kernel.org/all/20260425033742.1519298-1-b-padhi@ti.com/

v4: Changelog:
Re-spinning after Device Tree Syncup happened from Linux to U-Boot.
[Andrew]:
  1. Reworded commit message on [PATCH v4 03/11].
[Simon]:
  1. Add a binman test for the boot & load extensions in certificate in
     [PATCH v4 08/11].
General:
  1. Drop J722S defconfig changes out of this series. Will be
     posted/discussed separately.

Link to v3:
https://lore.kernel.org/all/20251231173621.1069988-1-b-padhi@ti.com/

v3: Changelog:
[Andrew]:
 1. Added dedicated remoteproc driver for booting HSM core.
 2. Added support for signing HSM firmware images in U-Boot. [Anshul]
General:
 1. Add support for booting HSM on J722S SoC as well.

Link to v2:
http://lore.kernel.org/all/20250506104202.16741-1-b-padhi@ti.com/

v2: Changelog:
[Andrew]:
 1. Added support in SPL to load FIT images with no 'load' property.
 2. Removed 'default = n' in CONFIG option.
 3. Used __maybe_unused to decrease preprocessing.
 4. Better error messages with error code. 
[Udit]:
 1. Added 'HSM' entries in enum at the last.
 2. Added error condition in if-elseif-else ladder.
 3. Hang System boot when HSM failed to boot properly.

Link to v1:
https://lore.kernel.org/all/20250422095430.363792-1-b-padhi@ti.com/

Testing done:
1. Tested HSM boot across GP, HS-FS, HS-SE device types for J721S2,
J784S4 and J722S SoCs.

Logs after enabling HSM boot configs:
https://gist.github.com/3V3RYONE/ad33683652c8c49e4fedab49f0493e79

Beleswar Padhi (7):
  arm: mach-k3: Explicitly identify TIFSSTUB images when discarding
    buffers
  arm: mach-k3: Add config options for packaging HSM firmware
  arm: dts: k3-{j721s2/j722s/j784s4}-binman: Add template for packing
    HSM firmware
  binman: openssl: Add boot and load extensions to x509 cert
  arm: dts: k3-{j721s2/j722s/j784s4}-r5.dtsi: Enable HSM core
  remoteproc: k3-hsm: Introduce a remoteproc driver for K3 HSM core
  arm: mach-k3: r5: common: Invoke boot of HSM M4 core

 MAINTAINERS                                   |   1 +
 arch/arm/dts/k3-binman.dtsi                   |  26 ++
 arch/arm/dts/k3-j721s2-binman.dtsi            |  12 +
 arch/arm/dts/k3-j721s2-r5.dtsi                |  10 +
 arch/arm/dts/k3-j722s-binman.dtsi             |  12 +
 arch/arm/dts/k3-j722s-r5.dtsi                 |  10 +
 arch/arm/dts/k3-j784s4-binman.dtsi            |  12 +
 arch/arm/dts/k3-j784s4-r5.dtsi                |   9 +
 arch/arm/mach-k3/Kconfig                      |  16 ++
 arch/arm/mach-k3/r5/common.c                  |  32 ++-
 drivers/remoteproc/Kconfig                    |  10 +
 drivers/remoteproc/Makefile                   |   1 +
 drivers/remoteproc/ti_k3_hsm_rproc.c          | 267 ++++++++++++++++++
 tools/binman/btool/openssl.py                 |  49 +++-
 tools/binman/etype/ti_secure.py               |  65 +++++
 tools/binman/etype/x509_cert.py               |   4 +-
 tools/binman/ftest.py                         |  45 +++
 .../test/vendor/ti_secure_boot_load_ext.dts   |  23 ++
 .../ti_secure_boot_load_ext_partial.dts       |  20 ++
 19 files changed, 614 insertions(+), 10 deletions(-)
 create mode 100644 drivers/remoteproc/ti_k3_hsm_rproc.c
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext.dts
 create mode 100644 tools/binman/test/vendor/ti_secure_boot_load_ext_partial.dts

-- 
2.34.1


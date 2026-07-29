Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B99DEC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 11:19:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5346340AE0;
	Wed, 29 Jul 2026 11:19:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EzvBVdvgUyQy; Wed, 29 Jul 2026 11:19:04 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7B55B40AE4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785323944;
	bh=JYG5KDAaVLNCFJO5PD0UctURK2OaxQuELzNq4T5cc+o=;
	h=From:Date:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fIcZwGqDdvWlcnf/yD0tf6yDpd0ZCAHvn4019sQzbAITsTsGahPFuqr1fZy6ITmEu
	 T8PgUKThusWvh0HOtHcogGzeuIqeLd8wiA2KssA8pgNFuVnhU54uZnwVxttpU9m5iF
	 PN7DRplkSB4lgHhahrLkCdIpfyAUR2EX6hq6w3ZP5aA5a55Wr+lfOdYubR4YpcYIpp
	 O7e2cE4nsWGUEhjl8bSYRPiNi+iJPWidEgaJqVFdsB6T8RERgxux4SmvOjj6J6meDc
	 Gtqnetko29igaeA6sgt00jNVFiB71qUD2OH0fTfHwS8xcQuXwEgdoapjC2zqdQ9IQN
	 Jr9n/Cq6XjLJw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7B55B40AE4;
	Wed, 29 Jul 2026 11:19:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 80B3F3B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:19:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6686A8119C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:19:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77KxylJ5HCGA for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 11:19:02 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9AD6681197
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AD6681197
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AD6681197
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 11:19:02 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TBAcss2591036; Wed, 29 Jul 2026 06:19:00 -0500
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fqgdd011m-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 06:19:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnLhQtcrHpOoZhkHa8ICori8ky5TnZB6TDvpsbxKZ3mCgUua/hKNtVIJ1im5Lu0oHapsiTNfbtmrbKnLGqQ5ULDJyePRrCmLTriSnNLQ4GEtT/lX4IEMqBNUL8mdwqGgEnEZ10cxH+1HV7186urKXUO4UqX71BINKb6fbcbujwJ9bMdurFGiWtAgHGSitFKUSvk3nU/64sWCCy2DzC9/bc2RHcxzOS6HdZ+33paBIJKWZnWR+ROHikEFeJTAOoW2pAsntYLYRAZ/Q9D+MiSStVQEjnpu3n7FfGxZHDVbs46KGNQwACQLFJs7S3XMzbfPhsYdRFCVxn00GbPVUw74PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYG5KDAaVLNCFJO5PD0UctURK2OaxQuELzNq4T5cc+o=;
 b=nmWBW47tIfqoLLjofkhdNppI+H0NFxraMo8iZZaF3FfmHm2ZdcdLHqX6iserfS8gsZOJd1FDj9usbIsFoVf+G4JBSpgF4o1VqTBo9kraBpkaj6ZE/+4jNnF5nc4hEaThJp00RWQwVdes9kvmbhQNG2Pi9OtTVoaKzC4s83A0UYgfkXzRL58v+f14Gwd9lDDRR85pp1SATp3Q6bHDRhvXnihycAeeSG+xiATiiPU1PzF+Q/VmlP6oSghmZlQ59/FCVJTR30/1tlikIqxO4HbbwguCVY1h+vNVgA+EGLoHiQWXTGh+XY4G7yy151hILaduXuvRihiNWA1UpIL13bDcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from CH0PR03CA0344.namprd03.prod.outlook.com (2603:10b6:610:11a::35)
 by PH8PR10MB997928.namprd10.prod.outlook.com (2603:10b6:510:3d1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 11:18:58 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::a1) by CH0PR03CA0344.outlook.office365.com
 (2603:10b6:610:11a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 11:18:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 11:18:57 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 06:18:56 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 06:18:56 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 06:18:56 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TBIt9K528152;
 Wed, 29 Jul 2026 06:18:55 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 29 Jul 2026 16:48:55 +0530
Subject: [PATCH RFC] env: ti: fdt_high: set no DTB relocation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-am62_sip_fdt_fix-v1-1-b0d814983d28@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNL3cRcM6P44syC+LSUkvi0zArdZONE0zQTMzNjc8NUJaC2gqJUoDD
 YyGilIDdnpViIYHFpUlZqcgnIMKXaWgAcg/42eQAAAA==
X-Change-ID: 20260729-am62_sip_fdt_fix-c3a5f466371e
To: <u-boot@lists.u-boot-project.org>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, Hari Nagalla
 <hnagalla@ti.com>, Anshul Dalal <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785323934; l=2309;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=joZoh9XiQjroP72rhBmkARhvG+NK52lQ9cBa7KbCZdc=;
 b=lLcVmtyegby2+4EgKQ9ow/6Hb5bj9VufLfcJ11KcEW1a0NbDS8W8YybXXWjobEoAsUyiWGyiY
 b+g+6/Hi1YlDJVJwOMJE82QFiJ+b4zz3MiNhFnAb1vGH6f0d+7Y16Up
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|PH8PR10MB997928:EE_
X-MS-Office365-Filtering-Correlation-Id: a044f9a2-43cd-4eb8-03c9-08deed632e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: hc/+bTNkKdAJ7WU6K3AO1axszpsmcNSclYExu6nt02coa+DMuTiAhNZVXXTtjh2HJThryl1ujPXomCRsCUERlozrWNXerihrAy101WhjzGOHcuDxDsZTYOGoqtIW4CkJdYxkoo9kcLPo2cWGiR4W9heprZAjoWQoR+joqrkuwspwjSlnWfQeyt1WzLA2bTTR3o14lyH42XEc/DOcXHcyuulMd0f5GTwh1PPYzGfII1BQ/qiKBfsBtNwRTypZVwSbLwtKdft5eJznMMjd/VaOy9NxC3csi8MtPe8bSxF3lSGYoRkQ6wxB8ZQRPZSgF+QBp7s1uNpKOS6Jh8G14OLFwlU59NLjnkQj28XWrwSjqC8/OelgOHUrGU+WiUx46C8lkz/Q8e4ePfYB94EugW/Vmki+O0t/mKXGgbcf+IuMl5Z81KUPw8refXYEDlw3tPH1iXHx6ukN2YlLIAOTOB1/7Nv2f+oaUfMhZzd04xI4upICE1+sGS73jVYjGSI8zRo78UbouOlqx+IrNlIMkuz6bCbvP/quTSwOeZnA075be3AXhMq/P6vW9TOzLSMyE+7bX6lfD9T+bRUNx9mK93Tgz+Be8WdKHU9FKu7T35oAl+ntdggeuAnuUpQgo2uHl11PEPxZ5F/O3cxUphg/9Ks6EH3/Q8GhbWRp9twAPisbkytmTaZSI5FpCKKt2fVSP6iibpij47PovOrVxmXBR7phnA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ye/qoBZbahoqtAVBEUxAOt9IwkUvds/8Ny9DOjTBuY6X4rTy1hsgbIJ8bM2pS21T/0dBbj3lk5Kg/Ehjq7QwT8tFu4ih80VStcX3X6wX/RU2YCn6LgFw/dIdg91C4kaxCJW+88EwcWJGg63NO/STp8tq20vf+jTCvZqNsTSIMVFZRWkVveRB/DK8mlC76/hqlrnJfeHV2kYf5ch0m9EDZ/W9h28LTrPeqrOJUveLe2lUQ1clZ4yqw7WqYQOi8u14hThyxLAalYaZTJuq7FstcNCsJzybLFkQi3Ja+4682XLlYo0QyJWuTnE5Alx4kECuA6gcuZXYLpinwQ/1pO5/SM6vy+6+jnUUU5O40KVUn7VR27sl8vzxrE0dAEe/X2L3eB0faKKfnTsT3BLuj0Da7VzaWO6kjkRQRhxD3tfL4tjtPAqwbJEme9bD0W8yw+gn
X-Exchange-RoutingPolicyChecked: oOe3qLcUDFs21/SCn9wafm5m7bk6w/SCBicXCJwgPhBKgThQANtldmDJ3zNdWWYCMbzqhBDKciZYjPUBwj7N38gbCImlKnNf6i/SXYILgdyKtdUsLLvh7pPhKbEshn43Y8Wx2/1lrY64wJIr9m8j6/xWnAN5vMSvUk+Lb4CwvyG641pXUUFP5kILcYqI/Y0f9MLgDZsdX0Of6vWaeP/usd/U7uka8PfQo2mBtXXl1Qa0/1F9RcrS42mqcFY0yC+STK7lg4KV09VM16sM73f3yXNEAyQLAalbn740j9DENRGaN2mmhBUIjrpvTQSf0sQb/1i4q2TwM3LNLptNhurumQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 11:18:57.0871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a044f9a2-43cd-4eb8-03c9-08deed632e8f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB997928
X-Authority-Analysis: v=2.4 cv=RZCgzVtv c=1 sm=1 tr=0 ts=6a69e1a4 cx=c_pps
 a=MB7q27p+LIGhC+3RxemCqA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=Jfbps5itsKi2yBLXAWIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX03PBjGv5jBBh
 Z7jhC9ldPMotJfy8YsTh6M7pFB50bHCIqXWe86SbdFnGZjzQNk0CSOA2tHPAQHVzgwOZ54ZCbAm
 1Pepo8zyyv0BHrezJQUmwjbGTd4eZTk=
X-Proofpoint-GUID: GHhdSzMGYGUgVIwgHJBU306ykzxoNGkB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MyBTYWx0ZWRfX9EuTzGrPA2R6
 qHwoQnu20rai23Z6uEZYonhWZl3z4qCTAFDyYdmiFcjXxg9/Req2uY1sGDZT2K3FKvlzbI8LEEN
 l4MNvyFivu1fshYeEgNiROOPVLR1DgWknao8AJbFPeF0NL0rnIVw8KwHXsdyPT/jJRsS/Q4D4F5
 lqSQI6ebZKKTHFwtir6JIRDj4qL+6eQRo8XKRh7pGPLSOq5GnsSAEUnBXixtGjSOsEgrtxxJz8j
 yvyGDCJITBUodDkUPS1QVeD31cOVLtQT6JTecoHzblh/FUy5Aj9iGM8XimB7VSYbonXoTCg6PDQ
 oaavzPRW1fRBEgcpFRCop+KnyGXe5lA1UFnflS6xcTPuQAsWgDDgwIOieiqdA/STFT8AG66fBnl
 RvzJnQk9fvGaNJjjdV8OizBw4ZyLd6oGAlv78QSShRsXZlyXFtJj74rxZ6FNmDiohddI3j+V/oe
 DogdbrDrbxgLZI/PSOw==
X-Proofpoint-ORIG-GUID: GHhdSzMGYGUgVIwgHJBU306ykzxoNGkB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_04,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290093
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=JYG5KDAaVLNCF
 JO5PD0UctURK2OaxQuELzNq4T5cc+o=; b=TNeaWsIIZoP7xAWhhrABeFjVviZiy
 FR4hDpv3E5tZ7AuWfX4D87AIQi18YTCuxakCqBLkuUdtOIBObrfINn1eVBbcHIgG
 zeNUrCYQfdBse0MzGV5QsqSBQIQcQcBhW0GXKAIDx0NcVwn1/25JGQONJzhYMpc6
 BSRRqVi3KI+wzTtflMteaeyXVfBPF0o6HoiUDZJFJZIueCDxRfLiOLwVwFFkIAmv
 h7ZmcCtNTWdgAxeBg0z2tmLGVFdEs0PgwniCm5KbIxooRxblDP13XMtlyPuSn3jW
 tx9MXEEywyXZE6d2+/yqouOJbD4UKbBCl+u+C7SVFXpO+Uhp+KfzEdcHQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JYG5KDAaVLNCFJO5PD0UctURK2OaxQuELzNq4T5cc+o=;
 b=pd6nlgyKYr3WjrW2eAMPC4KvcYDdezVQjMAyZ1pOQWgp72YfliZrt/Mz4hpauR/5TnNWtPxYsstWaxDI3HOvM7ldA0L/oHlQsGvoJ2IUj6MMVc2q/3Z/xCpgEwrQUHMEKaUry3ZgOIu4Aqt19cVa1G4rspyBHc81RG+r58cWBiE=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TNeaWsII; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=pd6nlgyK
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

From: Hari Nagalla <hnagalla@ti.com>

AM62-SIP SK boards have only 512 MB SDRAM. u-boot relocates the kernel
DTB to upper SDRAM region before starting Linux kernel. This region is
overlapping with the Firmware IPC carveouts. To avoid the overlap, set
'fdt_high' environment variable in u-boot to prevent relocation of DT
blob.

without this patch:
Booting using the fdt blob at 0x88000000
Working FDT set to 88000000
Loading Device Tree to 000000009ce49000, end 000000009ce5b8f9 ... OK
Working FDT set to 9ce49000
...
and subsequently during Linux boot carveout reserve memory fails:

Starting kernel ...
...
[    0.000000] printk: legacy bootconsole [ns16550a0] enabled
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: Reserved memory: failed to reserve
memory for node 'memory@9cc00000': base 0x000000009cc00000, size 14 MiB
[    0.000000] Reserved memory: created CMA memory pool at
0x0000000094600000, size 128 MiB

with the patch:
   Booting using the fdt blob at 0x88000000
Working FDT set to 88000000
 Using Device Tree in place at 0000000088000000, end 0000000088013375
Working FDT set to 88000000
...
and subsequent Linux boot
[    0.000000] efi: UEFI not found.
[    0.000000] OF: reserved mem: Reserved memory: reserved region for
node 'memory@9cc00000': base 0x000000009cc00000, size 14 MiB

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
During linux boot on AM62x SIP board, U-Boot relocates the fdt to
reserved-memory regions for IPC. This causes the kernel to fail when
trying to reserve said memory regions.

I'm not sure on what's the correct fix here but this RFC addresses the
problem by disabling relocation to begin with.
---
 board/ti/am62x/am6254atl.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/ti/am62x/am6254atl.env b/board/ti/am62x/am6254atl.env
index a9187c2b1aa9..d2e263b6fd5d 100644
--- a/board/ti/am62x/am6254atl.env
+++ b/board/ti/am62x/am6254atl.env
@@ -8,6 +8,7 @@
 #endif
 
 rproc_fw_binaries= 0 /lib/firmware/am62-mcu-m4f0_0-fw
+fdt_high=0xffffffffffffffff
 
 name_kern=Image
 console=ttyS2,115200n8

---
base-commit: 616c3d79f01cf9204e38738857c4647a730dcb3b
change-id: 20260729-am62_sip_fdt_fix-c3a5f466371e

Best regards,
--  
Anshul Dalal <anshuld@ti.com>


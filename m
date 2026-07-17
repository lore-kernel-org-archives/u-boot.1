Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2C1C44507
	for <u-boot@archiver.kernel.org>; Fri, 17 Jul 2026 06:41:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF6EF84D78;
	Fri, 17 Jul 2026 08:41:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SLMpxwy9";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BitucwCV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AE8D84D85; Fri, 17 Jul 2026 08:41:39 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3E4E84D16
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 08:41:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66H6aY0P1797922;
 Fri, 17 Jul 2026 01:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=+6nDFjUOnKBwIB3lRJ4apRAX0mnXr8w21EA6FRBy1
 ME=; b=SLMpxwy9tB9XVIVMNYvMTHeuu05Ex4J3TlODd72VNDAnufVovby6cwWNU
 zMrTgcyRbkBpsf+u9h4VXZdd78151di2m2XjteRvTz9zoE5K8QjhN26kBLlMAxNu
 GCkk3LtFCTS82il7dm5sR6kM8cRecs6hc2jkcSCP9FgBHFcj/BIN+oRoQL3xfGbe
 VYGpr6yCyPjC6L9qPW2p+FaTYW1LIw04pyixFILIR2Imw0yMD9lMbx9EYMBnPq5y
 Z9TY9tz5ZeAXyXqlo00Ve8b7/uvYgET2cf0dhWwP7g6iSkWoYli8dqFU001nI7ne
 n44SPY90236gJNIuE7R8VTRrsYYoA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011048.outbound.protection.outlook.com [40.107.208.48])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fex78dg9e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 01:41:31 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aowdgm51ir//wcY9lh5EdWNw5d/wndaeWzvu0bI22XSUo1pyLA+zyYmt9FWIxRVXks84tKr5kj4ZpWafgFSY7i7L5++qg0LgINbwxEEzayqui1PIkok5ZRjh3MVYwcbjOG8jLAUbYMn7BX2yJCZLhciUOueGiuL8DiX9PgsN88PLzsX4JxdbyNpa03URLqHVGpaawkTPl6Sc23ZD+Io6hi+ss0up6JepAHgUrjLwNUOn9zdrGMp0wDconjwxRQC8FtLwZiWKEiUledDsX9GAT2LjA6N9d8RI9sb0D+j3B/9MJNYpQrsrVuASJR3it2KkMwl4l65HjujMTX5BKlQolg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+6nDFjUOnKBwIB3lRJ4apRAX0mnXr8w21EA6FRBy1ME=;
 b=g2MzH3HBIIDPAGtSo9F4mhrIQziYIv0NsURzYKAi7MOTL22/FCTYDsIsSJ1IkkyhBlkNjHnsgDXQyo+K8BxLUoVxZ4NMzVGX0wZ1UH5wVDcd8tajcwaQiqPF6vUs6Be7JlwMm981A1d0D1Qo2NEIk7SY+YRinMy2ExZhq1OqcINXxHQYZSLS/rAUgUeclcLNvqpujTpS6YvBdRFWnf7UtnIgPe99bGrsQhVFoOvc2EMyTA0m+aHBtUmtXPKg0pTypDOB/N2xNM8zuockGuqhOwvhk9eLKMTNLqfhIfsaNybJlD2nv7aS1O+szpekGSWuS1lOxntWujn6cQbW2ZPP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6nDFjUOnKBwIB3lRJ4apRAX0mnXr8w21EA6FRBy1ME=;
 b=BitucwCVnmUebCzYdfopaLu37Dx1C/Z/fXaKlmB7HaHNkKW/j1waP9wN8j0a06vQLDUqG5vhzGtmF/sTTBdzy3CHirrMoj93HajTMb8cC8iFfdFFZ+i+Ha5AlRE6315dChJbDsPsQ1wbs1nzIUfVXkS5L0UezJmC3vuNXbKVYPk=
Received: from BL1PR13CA0007.namprd13.prod.outlook.com (2603:10b6:208:256::12)
 by DS3PR10MB997727.namprd10.prod.outlook.com (2603:10b6:8:348::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Fri, 17 Jul
 2026 06:41:28 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::ab) by BL1PR13CA0007.outlook.office365.com
 (2603:10b6:208:256::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Fri, 17
 Jul 2026 06:41:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 06:41:28 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 01:41:26 -0500
Received: from DLEE200.ent.ti.com (157.170.170.75) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 01:41:26 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 01:41:26 -0500
Received: from [10.24.52.241] (ula0502350.dhcp.ti.com [10.24.52.241])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66H6fLvY2595313;
 Fri, 17 Jul 2026 01:41:22 -0500
Message-ID: <d14d9e3a-2969-41da-8ed5-4c9ec465bc15@ti.com>
Date: Fri, 17 Jul 2026 12:11:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add DM firmware reserved memory support
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
CC: <praneeth@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <msp@baylibre.com>, <v-singh1@ti.com>, <anshuld@ti.com>, <afd@ti.com>,
 <m-chawdhry@ti.com>, <joao.goncalves@toradex.com>, <bb@ti.com>,
 <n-francis@ti.com>, <sebin.francis@ti.com>
References: <20260701075021.3626094-1-p-bhagat@ti.com>
 <178424431179.1470194.2877717920905276533.b4-ty@konsulko.com>
Content-Language: en-US
From: Paresh Bhagat <p-bhagat@ti.com>
In-Reply-To: <178424431179.1470194.2877717920905276533.b4-ty@konsulko.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|DS3PR10MB997727:EE_
X-MS-Office365-Filtering-Correlation-Id: 36783b79-698f-42ed-bf9a-08dee3ce6e2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|4143699003|56012099006|18002099003|22082099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: tUn3kkCWGIyLvAxZj7yqRim3IasHirolJFdMZkq6fSghFiwdGjZF8FvDXGdjh6giEntZiNOvehh9d92qyul1DuOP3Y01bfM2BHYbDMp62A9czTBn9biITzdP6EsHLI/bQQfQLxhrJOciKqwsk2eiN4Ose4gWzT1Nli9kno10Ux0EwHgdOnlEnYNLX9QuMokbz299itb+q8YKpRTYI4ij8E/tez6RZMT3E0tuKJOcpMo6itmGOkVhRQ7RsYYVms8bU7uyYVaQAiFMbDf9IELVZOTXucQbOQTjMzgMaCnKCnkTG70Kpyxve9GNOunYD8xhggfJKuIXMKe3KwSM+8BnFTY1XErc60/d8HNA4+weD9nPgomqDpAiSun7yIz3itDRueW3hLsosv8y2sbzaDN3PZdX17i/UgnmK4gaGZ6OVjEqPHpGppW+bO5wR7xnj5V/7MTVk3FFlYJr5kVDO/Z9CH23i5WEgnFEDuo8Px5CkH5pk/vS54eQXAo+J3WzolOsK8Y1X87HX182BqReRYFmdLKqs9OKbkp972On0/vgied09U9+BgMTQvX1pKiH6Hovu8Ac2OquoLowkO5oREZxJzvmLHF8SRLnLdtYBnoM8JCZVfoBqGEdP6smoXQXYfehgPV0+q4vfxBbOj76xvu/HsgQVbxhNTEsXwFy3QX8Uc0b/NJ4U+scRkvOotGNgPW2LcIsY94Ja/YQE3grZAh3+A==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(4143699003)(56012099006)(18002099003)(22082099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: h+bPW7g6GneyZFthWW9ytd8Q7Lx0Zs4ZoaP/DDxteecDskbEa2vwpKYiB+bpAULNPZ7sNHV2Gayv4TxO6UZAOaM0mPNNQanGyQvH1ICHL4uKqJKWp8H2JykG5M9glnGzFKHll74QKiHcG5K7+LWIyE7ca3njt/7KgWpr5vIICVuiLV/fCZQph6i8OKJ6RhywqElx4+hQspWBmyUqXwxDO3c2nyn6X2oMBJeY/mwT3q2Pz0+xXAuxH+wqwXlvk4m4IcLNRHcK/1UMVpJjiVZ634ZT0HYQ6E9EGaLe1h49sezDQLDXDWO9bFgJoWnND4SrUHKZAN+vvuLLAi0mMKDHc4FpbRFFYImm8yXRELwdpdUb7hDiZjcJHr/nXwcwl82yAQ9ajB4RhfBzDZteP5EbJq981OuR2/ILcvlrHuyZWA+0m6NHUgLRIwQLX+3WRCPF
X-Exchange-RoutingPolicyChecked: e9Khs54THOlMpUjQ3TUJE9JgMvsbMK4KyNH+feZYXs3J3X9QfPWTF44MUdbSn5eZl9l3NXLin1jvoZmoB0jKyZd+bnCqLBmT/WJA/jMDQF5CIlaGb61Nf6AP1JkqQR2auH66Bou/Wn8yvYubCGYpKZ3BToFqeatFgNg8Z2ViS207tKcY/GxjER8I+2pg3MopeDAZUn0xQyvfUr7f7NBnRF0uiH0whdCgmnHnJwNkT3hWa6nPNJp2lR5iCFvOqu5DoMZzqST/+WISSf5RmZupsEX7Yjudx3PHTc0nvAJelRIzHCAiIyoHKt60zvLwXwbyzAXvJjY3goTwe/s20FxnTw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 06:41:28.3045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36783b79-698f-42ed-bf9a-08dee3ce6e2a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR10MB997727
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA2NCBTYWx0ZWRfXyNXRiQ/wpElu
 g7/3AAqV3mp/5q8D7weBtdaWiO9RxyFwVnZOsjvg2N9me6QXy0a7ZQ15dw38FoSwn/16FHuqkOI
 1+9K7dRGKbTYnx0NGP4BPl7KkWYn2cigI/NBCBPZtAa3f8ZUYfrqYHF3ykH2R8SejfSHZret8qw
 zIbQ8fRWCXtyuSghEb7EbEOURm1M3E7VevTYOG/WcZrP76reQbrTSyPlKRqqJH71OrunITTFxt3
 xqJzCsBImP/F/mmvyD2OZZ+UFN4TeV0gH3kieN42LYA88tkd/8upuwaEgc4tyTHSpbFIW7Y1u0+
 39zFxaBhai+8j9897jkIEwaxu1CswzN2zItU1MjSWaQERRML53W9MIXJ4GU+1FUxu4EglAXR8/h
 6vN6PEpBAns+a564fPCRiLNOnaCUq1YDCyZ5WoqMkGV1uYl/E4D4+SpRQVHcfORiGSPWEnGVDP5
 j5/5KJlCfs3rlL60/5A==
X-Proofpoint-GUID: wpZsGouLvrr17nUbCf7XXfxweJfx3MeQ
X-Authority-Analysis: v=2.4 cv=TeamcxQh c=1 sm=1 tr=0 ts=6a59ce9b cx=c_pps
 a=9FihqjIFmhICW6KbYStfAA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=sozttTNsAAAA:8 a=UDI-7MaNYJl1XrY1UjoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wpZsGouLvrr17nUbCf7XXfxweJfx3MeQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA2NCBTYWx0ZWRfX2vnDNEMDy11i
 1TKwqhpCANRP240xkld8pdKKBtwBCs2HSgfS+qqiXajWV1tKud/q9luUBVwswL/bJOvypV+2uyv
 jcn65Y4Kks2RvOmAHBF1/LB9AzmvKy4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170064
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

Hi Tom,

On 17/07/26 04:55, Tom Rini wrote:
> On Wed, 01 Jul 2026 13:20:17 +0530, Paresh Bhagat wrote:
>
>> This series adds support for DM firmware reserved memory fixup in device
>> tree for K3 SoCs that use separate DM firmware (K3_DM_FW enabled).
>>
>> The series includes:
>> 1. Fix for phandle corruption in FDT reserved memory fixup
>> 2. Enable OF_SYSTEM_SETUP for AM62D2 to allow device tree fixups
>> 3. Add Kconfig options for DM firmware reserved memory for other K3 SoCs
>> 4. Add DM reserved memory fixup implementation
>>
>> [...]
> Applied to u-boot/main, thanks!


If possible could we revert this patch?
This series conflicts from one other series and needs changes in 
approach how to fixup the DM reserved memory region.
If this is merged without the corresponding device tree changes to 
include "dm", there will be a new node with same region causing memory 
overlap.
Please refer to this:
https://lore.kernel.org/all/20260706064104.138000-1-p-bhagat@ti.com/

Thanks,
Paresh


>
> [1/4] arm: mach-k3: Fix phandle corruption in fdt fixup
>        commit: d3e287405f0a0f9683f9c6c49e84495ea18d9f01
> [2/4] arm: mach-k3: am62ax: Enable OF_SYSTEM_SETUP for AM62D2
>        commit: f16e4c80040c2d5186ad3cfa83c469b26adbd46f
> [3/4] arm: mack-k3: Kconfig: Add DM firmware reserved memory configs
>        commit: 5e2be9f5ccc4ca3c9cd326d4671a853b783adcae
> [4/4] arm: mach-k3: Add DM reserved memory fixup
>        commit: 0cceea6e449888f4422e674e7157696d382eb686

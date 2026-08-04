Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0B5C55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:20:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 94B7780C8F;
	Tue,  4 Aug 2026 11:20:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KoWIYWJ5hW1u; Tue,  4 Aug 2026 11:20:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6BCB480C7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785842430;
	bh=DyZ5n9P1v1OdCyDNOI+cGEQK3a3JgTz0TB4BwQSFp88=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bYfVT1xiY2TFwUQ2MK5Ww6W7ZXm3ldt6U3s1KBq+zziWBYUZHVK7sSyCzy7c8nI5g
	 e6rBtTbdSw4EGZZ4BaR0i9QzYGOJq5Sg1llzmLZajaKRIr5GjUWdxVzYOQoBDxSdNa
	 FxbxrB8UVuJdkPkCNSAqXWU0/i3kthkYJiOsWUuTbarp8lVp83vZv9GYzZqleEQn41
	 6t3KJ4E93xct7kO30tqG+JZO6XxNTyjAEcrZ4oY0ByviClpoikxFneGEaq8WgHvjCm
	 b5cy3oHDcfbz0BG2hdVhlx8xJks8aPi9e/m+aNpu379nZOCbhi1hzHCkzuZVCyX0OE
	 bxqMUp2XjUYyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6BCB480C7E;
	Tue,  4 Aug 2026 11:20:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CE2426C
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:20:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3289F406EC
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:20:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zJ9gT8ZQTFz4 for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 11:20:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 67B9540589
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 67B9540589
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 67B9540589
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:20:28 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 67493Z4I2193169;
 Tue, 4 Aug 2026 06:20:22 -0500
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fud498p6q-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 06:20:22 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfKxvK94gViWvEtEHejRXytsQPG9th5itK5Ohtbbj+yhvmlC4po36Z0COWaiCHngBX2NVAiqSR9bvt3H/NTtQ/ihAh6gsg6Zp/4yOJpHddOqJhFpHipYfmRNfPrmbNsnW584YHpc55pjvFujAM9BzBwxbPnA+m9RgZjI/lLGiTHXIAVEk/TFYsZ/J+ux7hihpcLjh2ka7o2j/kUbSbrAQLlM9xRKGpOioRDrR05yTaj6UJTXOskGDxbQS4hX8gnoYIbLY1oZye1C2OZJ8/XHyTKTCxJs0BBNkhqA+LTZYbyLFDKMA0S9wupMSmN4/XknBbyF/xcFCwApAZFpFRc+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyZ5n9P1v1OdCyDNOI+cGEQK3a3JgTz0TB4BwQSFp88=;
 b=JOr1GvRy0gGXPCo5N8LODLtpEgKolG28YUpAUcLggVadKPsDkHnxQEBuojTZ6zIJ865lQtlrksncmAL6PRbUXtO3y2h9c7aw8c6YX7YaV0zvPSTQO2WezS7HmYD50a83iRBJYUS99cWqTawkzWbInJHSrlxAIgDBnrSWcmS2c5Vv7tQRu11vuGCdt1jkmZUM2hYYtlb93V18207VfSJYvs6UWxQeGip9LdEBJ2484VNPd4q+3biaYV5pm+31oTK/a4pznclZu4/ME42PhX3/BsPlXsTzxAy5dHzP4ZjoMeqTvYPnWev/JyXP1RxA16zWD7J5glyDE8GMKm/2NN1r4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from BN1PR14CA0028.namprd14.prod.outlook.com (2603:10b6:408:e3::33)
 by CO1PR10MB4611.namprd10.prod.outlook.com (2603:10b6:303:92::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 11:20:19 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e3:cafe::ae) by BN1PR14CA0028.outlook.office365.com
 (2603:10b6:408:e3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 11:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.0 via Frontend Transport; Tue, 4 Aug 2026 11:20:17 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:20:16 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:20:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 06:20:15 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674BKFuO131152;
 Tue, 4 Aug 2026 06:20:15 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 4 Aug 2026 16:50:14 +0530
Message-ID: <DKG4AVJNCKK7.3DX62HWVKGV0Z@ti.com>
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Aristo Chen
 <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>, Andrew Davis
 <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>, Johan Jonker
 <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH v3 07/11] arm: dts: k3-am62lx: Add binman support
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-7-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-7-b4f4302b09b4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|CO1PR10MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fd3c829-b3af-447e-4ddd-08def21a5cd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|7416014|36860700016|376014|23010399003|22082099003|18002099003|4143699003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: QDPIzcWaoJu9gpUo0KTcK2K7a7AmhjTDsMOnUSGYmhuqBq7LSd3N/WcK90cbetHdq05rHJLbTNyDbHzYwuHlxlpzBKVjfCQFh8xnWKy+SnReEhWzzY+lfdiK7q0FDWue14c+lukag76So4fDnjtcItEEOStGcqXnGhoSpTihnBMHXyAW0ZBkfvZPqqlLUnA2w2VZ22aqE83deWbQiTfXtSYUM+KBBTivKGoaPnb37RlXoRDO34ICFwCdv8bNFZmSIE1jvNxfjuIXPsVtzljjEtWCYTCXkzgVOu3iyvaemHhscX+Aol4RRyk/kr2+6KAwQQlPzyl25ULenzvUVKwUFOVaFhuNwi3i2/nW7aQwRq0zqan71FIQ3rJgLcW4icWoIibmg+WKRRNi1s+5TKAcmQRSOxxmdPYDU+9DfpGHtOXL+WDQqyz7HuorrOJffNV3+rl9fUpMAkrO+w460SQC65/A9FHrpuKMC6w4dzKB7Baf17nrRSxLIYirQ3ZoGR8JevEZTMmt5CEEY0iY1NX0U3N0ugKzwEYmqZ7DMFA7+t4wG2tArXC776nm8qSlHf0MbvXPQQ1FYlav5lenYGZ+dztxjt29B1/p/v4BgtNUXDkXMh5tavWVu8ehr7abZSvhKuw6R6N7ON+/KV31pIemL156J8EwmgMfVypkYRjs1xEkFZEr0O9q5hCGofMq0B/pd4bpOvg5tR8oWrLhv+4OEw==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(7416014)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bgb5AUFh/WSpd5ZYprphdEj3A+YsaTxNC+szVVaekgkeV+Ys2E1KrSOyYgzn6eXARAStrtX6Dv/Ph5mnZtAPkLW/y7O7RGmDXmltGqfYG/nDGQy0WETMER1IJlakKtQw7wblBK0BymgTIQusBZTGpb3GylNmuReK9AXZjLH0CvWZsgpTYW0u14qoLFV6djCHh789G+VLwjEwDDzlremEdEcnBtNfDJqanPNvjgPXWMUHUxOPLoSioF7qbxSJC2wijOYe0cSyrElV7a173F9N83xhnOXz8dzPKnbEE6pA6BFwwhrr43p1A49V/nbCT35T+nJyeaeCqo4UL5Hdl1/nd2qeM4KAnm+a74MAhGn4WsMZh41ML0HVYWdU0EWXpBOfhJxTsNxMchBWkhVx7iMoSq0Uhi08lCY2bkROP5nURBcwkLxMhez8bWzZ6hrnD/oV
X-Exchange-RoutingPolicyChecked: LSsMobD54Ev9Vz1n3RRs4d7g1IjXDLnoYQ/vfx1/ZImoQd5Iz6UZlGnJ3zfPDrTq6UwG8TBp3sFXx23Fl2mPjDtE/1VmM7oqCUOvAPBnIuB4GbavRSUP9SSiZ6ag5/YIXf/AoYYJZL/m6mDgsGZfInPsVzt/3Q8oD61Q9HWe0LFyv0o1UJHEpywn8HiJI3Mrw8Ugq11lRfdG3u9DBZfaJqRTLpTkJzEX0s1ykUK1uV30Hi0AvmQuolyXUsaTBM+OMzN11KlxVZBgPGItQ69OLXh/WJSyMmLkz8HzZ8KZ1wquw1E5yo7BnnUwTUO/BnvX7cT3bAjNMl0n1fJG9zO5og==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:20:17.2483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd3c829-b3af-447e-4ddd-08def21a5cd3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-GUID: ThnWxCA21h3iiMxdrEJRuCRYAvzxtN5g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5MCBTYWx0ZWRfX2nqQG8KDki4S
 8dQcFfWDKDY8bVyAhg/iJFkuKUtSlN/rI02LyjPZQodIStGsDsMoRGMFhcOHrZcVfDc8J3VJOqM
 4i7M2CYvY7ZnxtKExXMioqvpu0cTSy65APR1uVif4qhl6dzPYvmUMTlMwTevguyNsYt4PVYwN1R
 yMxJkJyZDMiEq0jm+E/Ukw/pim7tLpgMZMbZpDuUHB93T6KYAQala8Y+RLBPRN1NZaBzFD3uh1N
 qVgfc9lnDv40YOCYQuevUCoXCZ78/YNNR01CVzht6hWCqXuFf2f46ZAQHjGJq1cvSlPd9azVpWx
 lqVanjxic5tgYy1OY0mbv9TpsxROBURvyvk4c26JrXoy0Wd3r+RanjEvTlozd1Uf9BgwJzJEppg
 p1rb2ZNMBGZtKnyiFdr54CfbBP/yjYrh4GH8/81mhkC/CqIa3NhTiaRUKF+6MI7ZjiHk4bh5Z8V
 0i/7FQrJO8WBu4wX9Mw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5MCBTYWx0ZWRfX9vlW3VV1xJB+
 pTUqRYB8LidyQG9U1BxbdHUVUjgepUmhiMqHmu3wI/B0X+PYe6T5bPuAUZoyY2o7aXFmZ6HPXEC
 vZjOS+z7pGtpRggNwySzmi0LunItoxs=
X-Authority-Analysis: v=2.4 cv=XKMAjwhE c=1 sm=1 tr=0 ts=6a71caf6 cx=c_pps
 a=9KM80f3Gg1/mZdPsmiBtBA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=r8MjDn74YYsdZacoAtcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ThnWxCA21h3iiMxdrEJRuCRYAvzxtN5g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040090
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=DyZ5n9P1v1OdCyDNOI+cGEQK3a3JgTz0TB4BwQSFp
 88=; b=Vkl/SGwAdvqVhKGkVme0qkNjugHLMeVu68GHk4nUTqlZqR9pdom6NV3kN
 6UsNaw6bemTZqYqDC5Q6IU9XRzBM4lMez6rQQnJV7xlp+3ME/R9eYRu0rr45qjer
 OkD8blnyKptvlKua7pvGs8bh4akHyHbqh62K3O2pNqU2L59EXII91BF7F2qxCSL0
 7ui0WBAShPHkzw4q9/Y4BWz9h5x9Pmt4XeThJK2qW9s7u7PkiJ4E4WVfdI6Jy866
 g1L6NuFovilfcm9Jr1DdukPeuaFj6OwyD4B9jjlsKJMFmBTaAL+MFtcb7BX2YBEG
 8NMuF2emzZXViVxv2Uwl8ZFqdI5+g==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DyZ5n9P1v1OdCyDNOI+cGEQK3a3JgTz0TB4BwQSFp88=;
 b=D5tAFEsPfbIqaWaal9k2NO5kmcpMSEyESqwTMnKTR5NNkk9JvJ+PgTYirK/mxooHkW4AD1kGbQRWyg1M45Zs9FlWlKQFAlEvbzgJnIvihgwZxyg98KeCq3Fl4cbccbjdHYXEM2sVgXR4P8mJZKQzND9yqUWqfMZYUasZI0Uh/l8=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=Vkl/SGwA; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=D5tAFEsP
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

On Tue Aug 4, 2026 at 5:39 AM IST, Bryan Brattlof wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
>
> Add the initial configuration to build the boot binaries for the AM62L
> family of devices
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF395CD98F0
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 04:59:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F65849C5;
	Tue, 23 Jun 2026 06:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XlAmmW8O";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="DZgecKSM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69A0F849E4; Tue, 23 Jun 2026 06:59:04 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E348C848DC
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N0hw54068977;
 Mon, 22 Jun 2026 23:58:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=7IZ84Gtwoyiv87ePNbGmZFT7RgYpBPnDFqK0hHAdh
 Fg=; b=XlAmmW8O6UNCbgNgXLEF7Di02ARg+iIZDuWlG5ECMytJ1+yu8qz1qy18L
 xIasPZZpGelaDg/tr3YouOp6fkpGdJs0FZLqDfhRcQwz6NLiSA1kvzjS1nZX3aGV
 ZveHlOoSocUGsn7DP3FojT3If62uLxt3PXLtQ2IzshpwiLLnj6abREBIOaZ1uTeQ
 vdA92gO9G3CXBHPkhuZZgGDivqwF0Y/jbuTXxU0i8xYohEaBlVFSKzeSPRJDfQHr
 R2cN+zhaeR/4UzNjTz+agZHnyfYupgy7e+kJeX15L57hXdFZ/YRu+cSkxF/I9lPk
 4ggy8URtbtLAW8RTDnhwvaiuiVSJg==
Received: from dm5pr21cu001.outbound.protection.outlook.com
 (mail-centralusazon11011060.outbound.protection.outlook.com [52.101.62.60])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ey04eehcs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 23:58:58 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tQPEYl+ebz312YXJKIhuBhQLJKj8whAAbIpiTXiv6fFhbOhlTIry4uH2GtjX2IotfqZHpe8Ww6mhdeeT3/urgipZAybESBnpYxkoNC0PZy1M66AHELHyfffM814xv/AOySIT93Mc0lqMakjxh4WKYbe5W9ZkFmVgdsFavht7rsNHww2gn7v+pels2gVTpwIHpee2Bh59k9qGeXLLQdApD9mGrtVbjJAu+RRuizIpsgXzw74o/9L2IDbh1cuc4hbSU5hSD5kjki2dqVc3LiQyJuMUSBcMaI+r07TD5vvdGLgJHCKOEKGxp+3rt31m/STy4GjR53kalc5IhDltvzDctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IZ84Gtwoyiv87ePNbGmZFT7RgYpBPnDFqK0hHAdhFg=;
 b=rxWFBOhKamA/gYR+MxhjqT2UopXBGv7v6G4y+N5bSPbY4JMdQwHF0EFBcHnrhx/L8Kd+8MTfulQSo3NBPPtqil/sPjn84pT2hHxUlX70VZFNLQ6N2I8fnFgf+WzMiuvgpPTZ4XZI2YYEfBVzWDXmeEpAtxu8nGFTpXFEV+m7PGF2QWmQFBdU4+G9TXx9uNvREWgBfgf8tLBqQ6xfoyTleh+8nTPuEKaJcXtQUAhj4EsbOxBDOzqaCAwMjtYv9bT7fcgJ0VGMsMP2RfE1MhEIJV7wKfbQSju8trkis9Eahi3VJCG7plOTUg1ON4v5HmRk4oEoz2B/26VoGtqFYKmk3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IZ84Gtwoyiv87ePNbGmZFT7RgYpBPnDFqK0hHAdhFg=;
 b=DZgecKSMtMBi1X6P5/0NhplizsD2CCzEgZIwCeEDEwVkllqAgQiHP7mUezOnUdSYgoZ2MtRA7PnuzbUM7qZz5K0Q5oxmsA8DqLEtBAYUTnEd+rnsXvojcnk5L88JmNHPvAcblpsBosArFj+SwYLRuBAPpDSEmmm96q+kfeRof4E=
Received: from CH0PR04CA0092.namprd04.prod.outlook.com (2603:10b6:610:75::7)
 by IA3PR10MB8637.namprd10.prod.outlook.com (2603:10b6:208:577::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 04:58:55 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::46) by CH0PR04CA0092.outlook.office365.com
 (2603:10b6:610:75::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 04:58:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 04:58:53 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:53 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:53 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 22 Jun 2026 23:58:53 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N4wqo41490728;
 Mon, 22 Jun 2026 23:58:52 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] arm: mach-k3: Add DM firmware memory fixup
From: Anshul Dalal <anshuld@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>
In-Reply-To: <20260609181006.460401-1-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
Date: Tue, 23 Jun 2026 10:28:49 +0530
Message-ID: <178219072988.1099376.16053199642199625548.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782190731; l=567;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=GwQYgYn7/bbDUOBpbany1ps5BbrO7fuXW/7I0PCMzTo=;
 b=nH73ZlOYaJZfWTd40kA10WiHGZhylzAFcAmMXEgKw3rZS2vxjJTVeVO/YyiUdLe6L7nBpW+w4
 DZQu/hYlRggA0MX8YVOOkcc8foyj0zsXi/80oX/dDydcBhF/4OmVyMx
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|IA3PR10MB8637:EE_
X-MS-Office365-Filtering-Correlation-Id: 144f0b77-c9ec-4b50-5c6d-08ded0e41ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: S00BwwmCDqq0BfHIVyVSwqr5r2QFWgd7eWn14ztqL6956FLm2d9wuzDU5MA+MJFUL1qSgTvb1CiZeXigOxBcnoBtUsw36auCA59w2pkRpXwX263GKQBQAQpLs34BorZ+5QVQnNjCKEWKfSqoBdgk8Nmscmg7TFEZgRshb2qg61iSyS2Uyan9NsV5GxFmvUN7yK16e+hkI7rYrqEw/pwJAlw92pAQH11V6mmrie8QkAfwKn3Yk9gdb/rcttz+ZbjNLxBJCjZkltSacFEDVbVQH6GartMVCCwqCOa/F4WH5R0XpYrj0HloUOMtNw/Z1HTifIHJQALuXcI5tX04gY44yqBkjTpoqWG7pRCq1PcZsUw1wCTmbQVi+oMJ5kuGOMOWoUUvpxegHtX8MNAck5CCYqoV/HIgddJNil6xFU6nlttp7+HmtZEYpoeAFvmhIlXyCDIy4BeR3dfAUt2PjtTnLQFAuEuMqKF9jng6YC71bJTOi0QANcqL3heFn1v5fvCjiPrJVp01qFV67X19LAhyYMr5EGexD+k7Mbtem9WPQtJrxXEDomLy+fuFnA+T9Dl7VetyAin0dv4OQSapvPa0YzxNnlDKBmbrBBRNndnh4S0Sd0/3TieYY/zASjR0mDMll6KoK/FbuIivJzh2SCKzUmfjYvO/M2jPP8f1TuUMtIwL93ssru5uQQWd+zUYPHoD1I1sPdCsQsFN14hLmr+vZQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zEvcn0lCelcnGLNpYUbwTkjSQo8hqpis9nTFBwjGOiwqDQkemNp3x0eZJuFZd6RnDcNfrGe/E7gnD7mtUuw55WvM7bqBe9OvvsSna4BmwmBuBYgbMs33ctmHkrqufA5bUZ1Z/mANcplnFIKkddLTpBAvmAX9UW7roBHTcOsEI4l+zANtVi32/1DqR/pAe8u5tPaabraKPxDsBHObm1NfGkrjuimUqDji3vQlaR3CvU7RmvbHuhcaZ0UQWsEK4Nv0rDUkqld3dLEAMKegIhIub9qW4UmH2o42VKcZ41gYLFaoeLQYeiMqebmJ1yTWCcsL78LWbrG5Dx3YNU45YYpmAX9TlYgZIZiujI0Kgi2I+qYm3oBs7yJS06Q4EqInQkHvlCawLFpQWqZBhtjguIRscKs2HDUTmUgAdYLq9HR0z51GpsUwpGW/riU2CeSWCb4k
X-Exchange-RoutingPolicyChecked: Xi27odxPQcKTanzohbPhrfxi6DIEnM5pyKlbedQ4dB/iAwE0ifS1ra8dodo7QHgN9LB5JmLGbKm+jlsgjW96VW6BdSoT7A7cprlduOOSL+qQdW6oTx/SPYrft7LlYLBs5lICllfy+g3j1k9ZuAXOAXsXVY2opwCt3/eA+lBOq0z8nRWzODs8vhw3i/GZ6qy1ZkzXRRDZA/fSPzYcnVOHs6y3c6W8HRlGK7olIVWzAXToyrntCDA7bxeEn+zGMjiSov+5kvrnuman9kW/ReA5L2ffqzmqPaTd0orFLFmqdAGtyHnQRWxT4aLfwBVd8lWuIYMan3LY/vqq7nwbPCs9LA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:58:53.9266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144f0b77-c9ec-4b50-5c6d-08ded0e41ff2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8637
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX83UdbhyKJutT
 PtXd80l4iJ7m+xkGf/xDSZsqsLkQB1C1h82No9tjcBACPzhghNWZlk+0EWmIo2/dbrGXk0OUwRB
 IuSlC/T/7F/i1D7H1gae2TrhWa32op4=
X-Authority-Analysis: v=2.4 cv=X/Fi7mTe c=1 sm=1 tr=0 ts=6a3a1292 cx=c_pps
 a=VmiGRewH7mEIsprpaxNw0Q==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=arMagJQu8HB6QIYtAjIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfXzzx0hN1eQclV
 x6Pl81wgy+5dTjadnnXhgrSF462x0XrBWjTCKgd/mhCForRwtP/tnGjr2PpOio0+mYvlDUWOjCM
 A3hJx/MTZWW/iHxSiMGBcyJn82cJoHOuDtMat6QlHAJx0fPEm2czSluJafXfIiYsgjGJPFm+c28
 GEyhk0sqD158H//5Ej6K+7NgfvWBrRgKz31lRC/oou5GY7CSRnIHl2nXWJh3jFdCCEYp7EpZ2lE
 uj7pShETf9bd4KFKGrW0IVlL9keMxDzfUTdCnWruOcq758iqmq51rfjbgEwR19f1ye57JcJDzPJ
 wM+Qu8j5QmWAgGz9HoHDyW9bn1bkAtr6gd79Eiv4OyOrEWSwnxyMAnLZE/v983MRSHqvZuu7y+A
 nSREMKXtl1je0usTnVgNxpcOMGuLLsLWrtyQdNI17SXzfaSccSuzIdWBksL6SEreu8IspxRp5kP
 SNTYwq7UxxhRW/90eVw==
X-Proofpoint-ORIG-GUID: -SGYUn9177OwdRk6VLgt868MkYJlhUb4
X-Proofpoint-GUID: -SGYUn9177OwdRk6VLgt868MkYJlhUb4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230037
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

On Tue, 09 Jun 2026 23:40:02 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
> [...]
>    initialization failures. Fixed it by updating nodes in-place using
>    fdt_setprop() to preserve original phandles.
> 
> This patch will need the dts to be updated for both AM62a and AM62d i.e.
> rename wkup_r5fss0_core0_memory_region node from "memory@9c900000" to
> "dm@9c900000".

Have the patches for that been posted to linux-devicetree yet? I presume the
test logs below had the respective changes applied to the DT right?

-- 
Anshul Dalal <anshuld@ti.com>

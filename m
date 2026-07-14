Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBDE7C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 11:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22FF84CF4;
	Tue, 14 Jul 2026 13:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fTkkmsFH";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Jxv2KfMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8270E84CD7; Tue, 14 Jul 2026 13:05:32 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4EB84CF3
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:05:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66E6UaoF1524718;
 Tue, 14 Jul 2026 06:05:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=eh284abUVjMQEMWT/18JcjY2zkq0qaL55zoqivVOv
 3s=; b=fTkkmsFHJ7TJIYBOQ48eEcf9L7iljPngNMsV12kNDBU/+FKMNfdQNoG8W
 2dw4jlf5/CUO9jvilM9Xk5cG78cN/YaoW+P4DivckEdev6g3IBNKgCHt+btUF/q7
 DlWYB63ajASYfdmu5cohD5J7LErHxuuG8cBhgoRRR/Wx4AqELUIHjj7BP8oM0RMq
 qo9yHjKlahrQtZYRNMZlC0ukaZciQ7fmmZvpiSyCHT7PUMhcDz3WmEafqH+PChkp
 JCxorilzodvcM6HyAZFNyr9rBCKeMoQvBnH4EUHBPseP1l5yjIF0i/fSMw357r0J
 VrqoiRdXiitQmtb9AxPkf7E052P6Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013011.outbound.protection.outlook.com
 [40.107.201.11])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fdcw5a2c1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 06:05:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7yyeb0DiFymo1DHJnIWFpRP5BKsjh4P38kHZ3gkhZCwk6kQwl79kF62Fk+/ZbYAeFp89d3L8XGcFqnq+TPnGV5uWczJSEDbruHRRojON91TNRbYHTuJWYMGPA+B/c1Y1hy3EWIBE6jKkTpTFLTAvmdVQXq1sWPnNhIKidWx9G4AvDkCAZQagJejpgrxD5ZmV1XSEnVkKfwbm9LnBIgloeyXILcXxewVhJ0FgCUu0QNLElK5ru1N08IstHaZ+lqHXal5rqLDIWEuPj+oPJ8I2uZFboDPM0+fq5cSEpKKdNyXdJknLUgsnPKRDonms2CRzSy5/D+4PoXDyMEYpS5P7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh284abUVjMQEMWT/18JcjY2zkq0qaL55zoqivVOv3s=;
 b=T6RcnroGDV+GheKlE56ITRgIQnMu3tPO+87WQ51gFd1eIaADdC6FdIiDKTzXoC4ZbDwtVmBm7QjXCMmykIF1HbQeI+ihxpNZEzMCyeeAFYrRdodX5ejlVX+/Q+VKWOY9BjLeVT4qNzj7bkYkVmoQ5biwp/nP3cN18mZGnlR00KPiEMuWZsnUZj6yv51h394BYg4gAetawi+eAF1ergcp/ktMbfRnsKwH+/9FJH2YQqvWqZ4thGFyAIkiF6zPsKK/sgyddS0hi6w81AE61fIHPvlEyYi4HWIe5K4o6v/lPSO0BFWmMsNifJlppIUvA6JG+qTjs/KkrZr3mY9nWWg25g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh284abUVjMQEMWT/18JcjY2zkq0qaL55zoqivVOv3s=;
 b=Jxv2KfMoFhUr82/GBxEb8uzKEOFVGrRc8TFpekmi/ZykT+2Fdt8RrNUlyCH/FEtMwGlkE8ROu+tOHm9iggzrto56KbVZPMsXetYNCVV4tol3qQZakGeP2jXrlSuJBUZFGe3d3CfpSHK+99E1xlv2DS7cBVRWpT238pH6ZU2lDXA=
Received: from MN0PR04CA0003.namprd04.prod.outlook.com (2603:10b6:208:52d::15)
 by CO1PR10MB4804.namprd10.prod.outlook.com (2603:10b6:303:90::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Tue, 14 Jul
 2026 11:05:22 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:52d:cafe::75) by MN0PR04CA0003.outlook.office365.com
 (2603:10b6:208:52d::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Tue,
 14 Jul 2026 11:05:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 11:05:20 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:17 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 06:05:17 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66EB5Ftb3983929;
 Tue, 14 Jul 2026 06:05:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 3/3] arm: dts: k3-am62a7-sk-u-boot: Enable DM
 services for main_pktdma
From: Anshul Dalal <anshuld@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260710102229.2980029-4-c-vankar@ti.com>
References: <20260710102229.2980029-1-c-vankar@ti.com>
 <20260710102229.2980029-4-c-vankar@ti.com>
Date: Tue, 14 Jul 2026 16:35:08 +0530
Message-ID: <178402710826.246195.6210593528035580821.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784027109; l=613;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=NHM0SU+03UM7NjTKd1HCUjEEF32g9m+QWefpyfI7W2g=;
 b=UgIxBTZopAfvSKcCV7oSFHmP8PCRbgKRTMhcnfKZhlQJIZ6Rmmny7hLJTUuXWCzfnKJ/b4uTr
 2OeCJUby45QAqncVCxbLPyyLQ0UX649hpDQgwdebXtPnv+HkGWIgpaO
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CO1PR10MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: 41de68fb-7795-453d-5ad3-08dee197cba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GXrqVNujsIwFAC/GgCEDOWtHfLeGLNps4bmsExPg+k4UM7Pjjmb9Rd04GQgxnWHm2kPpQpCPY4tZ51JvOHbvqRby2lsk7J6qaMQ8Mu1U6KXuoJk0br1DHuFhg/WjGA8WrmPpMtzrhoA8Ox08ZIxMuo3O/W7+JdVi/0f9afHJW/5gMhTdtcNYrg8bNnhfMLFhYfqrwjOU+Fr+cH0j6KEzO1XMHLY8TDxLg6zm2v0zQTn4MirCQnqxk/zjsDJxhqyvgVvjhP7TjT2nBZJNqvHIk7VimZbNH7QuseyqvOJzYJKtEkQrvgexK/+xVse6WvFp7tE8+RazKSmSwAborJlrcAKVfZmFTzEg1sxWYQJzd45k2qgZLS2w1hbXjM0YjGyJsJTieOmtRfJ8J0VG9nVmX975OSbNgLxtXYuKS9dtb3iet+Rxek30HBHrgX/vspDb3z95O65gZzYTgpsP3TDdu8GVIInFbdrexY/VT3sUeRbLTj/aIQSbGZrWf6fR0yKIDOYQfbG9lCbCV+fu9JyKSarOyeJin44fi+nQbLlPreljN7tawVNV2av9r3qbrB3GKdahPdBbSW57QEMm+nA8lksqzrWQPZz++cHg4vB8YgPAK8+qN6jM+MSGQ9XIohKJe5odxhP9SJoiJ/k5pWjUC1eAjf/fGyCx96QHz7gKzyAh60Oz8eED49vHlIzGX8DirUImFaGRLFWABtdDbfSicg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gzbALooFA4XAhoW4G5QTXLbOS0tOqaJ3RUDaZCCT8ehWDDMTmHfdiIdkHzx9l9lKygLvhGzybhCfH0cyJGkMs8qW3UikagOTudGpmSVF5jLq3y9mzxzNqhSfiLKkXmAMgDPgYX2IXKBi5x0kwh7JFJOIkCaQs1PEB4ywF9uyjiq3ef/UZ8FLn8ZUpuCQs0tBorMZWGHzA4xnLTX0Mro8lX5G1LHyhJjFS2T33pWXCYf8jP9Gqjzp694I86Mc6ACztON66hpYRrnvGa2AKz2u4K5iRQxeof8qzm/eA5g1PgyF/RciCOH7TqE5OqfVlKv7AN2oZtwPQjs6r9EuRe0IxGK2hi47Fyt4kT3VY6krW4nJ3f8sY2XyQx1e9N0V5/G3MgvkKwCCKyqhV3HX7GGnNupIUPkzFDWuuWMcY8cgEOp7WEHiBCxaftkHdEgapqn3
X-Exchange-RoutingPolicyChecked: YCRLZ4Ci6EmKzNgbn0d/HoanXkFciyE/ibYru+JUJw1kE2dp1NMDzIkgfduN874PvbJgZsvUuRDwqYiS5CFUeUj3+3DPJBGuL3GPPo+5jWjUOmwdskq7hKoWGYOiAGr36kFWJ54dMB64E9eUYvIB9BqSFk9syY5WZTDpQEZyBheh1vpD0l0eyUvqGvQjNNHUEfiL3scxMH6ljbfIdEeABsInK9IIJgXx9B51AX9y9KzXlyy5LvhFVTlLF2gqMPOoIchKNv/Tsby8WK5FzhU4NDHTz6b+uLSP98XgGu1+Vnvxfs+Y0DWBA39v/C8e5T2kgt3Kf8yA/OzYcH48rLz+YA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:05:20.4945 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41de68fb-7795-453d-5ad3-08dee197cba4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4804
X-Proofpoint-GUID: j-lVLdfr8beVOGNpX41M2GiTIPTmq6sx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfX+BCiIcwTs9PR
 kaRG/UjTglvXzwGMEg/NJke8EOGmF7V3Tmqv69t+TK/CguHKY4m5At5BObBL5e9qbvq1eakLXfY
 UUy1z6TNW8niDw1IjrA7X1Y98r0A3Q4=
X-Proofpoint-ORIG-GUID: j-lVLdfr8beVOGNpX41M2GiTIPTmq6sx
X-Authority-Analysis: v=2.4 cv=Ir8utr/g c=1 sm=1 tr=0 ts=6a5617f6 cx=c_pps
 a=+Z8LngAnY8uKoQL+MiJmWw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=DcNxIdUtCaseABbGkWwA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfXyvKsCLKXlF4Z
 C+CZVwXfEb4OvpLS7NqfnjourJ3fikjGCUbppvkQRSOwpnHxxgv54E6dEE7gkMJ7qZX8peQv8rD
 d1nKqDgvmkOUCdVXLpsS+vmM8RvQPx/bVtvIRjss0Cir/YesvFfDYPsZ5reoCUFq0SFShR+bYn9
 ttQUpJQrGc3DngYJbqEkukJiOD/IskmyPmvZgeRCQYfdrKW7XTGDT2WlMZSzFGjkIrdZjgRHF3r
 LoTebiAhWbj584g3VIbxAJ5ue5tDVlkh/3thrHydBlK9P9nCDThRBiGP27huRMpvdkOeVcI4VcP
 ACpe2HS0yFvkOHfVvg9q99QevBg1Q1JsVPaMKMJs71XeNGK/3U5EuOzXV1Ht5mXiLqlfZ1TLVe8
 ShLBGuPcaQUwyqfYh/2BJ0u5GgtN1kG111fCTcCDrYgSuB4aWZ0shfmELfH6csyv+fyCXkeMOTn
 7lcnzVUf0L+/tMxjULg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140115
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

On Fri, 10 Jul 2026 15:52:29 +0530, Chintan Vankar <c-vankar@ti.com> wrote:
> diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
> index 4570ff6edbf7..9c2a6bf89a92 100644
> --- a/arch/arm/dts/k3-am62a7-r5-sk.dts
> +++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
> @@ -42,3 +42,8 @@
>  	status = "okay";
>  	bootph-pre-ram;
>  };
> +
> +&main_pktdma {
> +	ti,sci = <&dm_tifs>;
> +	bootph-all;
> +};

We should have this as part of 'k3-am62a7-r5.dtsi' so that other boards can
also get OOB ethernet boot by just modifying their defconfig.

-- 
Anshul Dalal <anshuld@ti.com>

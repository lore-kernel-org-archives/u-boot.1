Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00C3C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 10:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7667C84AFF;
	Thu,  9 Jul 2026 12:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="FempLI3b";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l/kTrv9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B8C884B01; Thu,  9 Jul 2026 12:24:24 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38A484994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 12:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669ALEuZ776561; Thu, 9 Jul 2026 05:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=proofpoint-05-2026; bh=mmONq2MaCBnaM
 z5GvOFH6O2oB1xWBpyCExUqEwScRuo=; b=FempLI3b4jRgK3nbkvNPy98KEyyRN
 BFeYsK1il1SYw4fEYFR/Xt2NAP0Lg3e6L9loj5QLQaEYU+Qi/BRFWVl5fH42SkZY
 DDgpbSoSh06B73Mjy9+SDGmj0C70Xre7poUljQsxEC6Ofb4Q4wRSWRk7SzlRvoCJ
 NQfoU1Pb7KR7F0Ery9eMlMd8gFx5EpBDt7bIZPNyLWOuwXF2DfymaitGc+DXD+h/
 K/ErVwyzDlbmPkBKEKq2WthBDn0jotRPNiXDl5dPiGg4Ahyfpw8aTM4H9I3SpgnY
 lqLH/I+cgS1RePEqFUCIJhAHziipfQVgRIG50VgQj6k9RHM1s9k6p7Uqg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fa8v9rb0y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 05:24:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feWNbdGqae86iLtMY68SRcDFH3sGRZP8Alsc4GF6BSU8aYUaMxRG6lzLhN/3k7oJpc0BcxOveYV1iwzn+fuwvj8G/jN1X+H6Lh5uXzqBVpy/h27TDz5xAUXRXmwVoD1X3ueJ2vZT7qqQMYfnhwKhRJFM49poesNq+tUWejcRcqT4fiuIMv6O6gcguRYf1pwv8HLs7BsVNp8NzPOTrNjTzSJxtACc8oBkNgl97KIKqUIVhsJFqCKXg2haWIMQvmd8+ofVzhb6twDVYvTIQ6uYz2OZyEXkXjvNfsRjDI0BP3K1WIsgbgd0u7+9wkz6m7aaNhYd/LCA5JdE2F3YQuz5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmONq2MaCBnaMz5GvOFH6O2oB1xWBpyCExUqEwScRuo=;
 b=vCbJNKc1taBmXf5hxxJ9rKx9hHBhjAcVowWdKsTgNgz6bvCETm8xcZkOD1dEnpguNYF5figmA7FTnThW2yJxOR5cw9leRWOX8ImsmrHgUh8m6I5uKQVxvECnPueFZEL7m4AWouzVCJR5PVhI0FEicvl2SLoQKYhWpBH3jbH41Lbw3YCVe/r5S91wJvAUz5hF0SwS2a2lPapJIzBztm7nK4mVyBTxujDotId15OXqabzH/nRKPWhc2cwREKfNJITxgU/Usi8mOFM3mQa1Rh6Q8pLBiMVlzGivAJa1vBoaaD36O15VVvQrXVkPOG+cx+bX8bj8bAMnUHsqkCd+BdKxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=chromium.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmONq2MaCBnaMz5GvOFH6O2oB1xWBpyCExUqEwScRuo=;
 b=l/kTrv9TrHGnLtX06PyO+HEzhxFohX4XnIaXhUbQvsK28AwkLSCH5QJMozLSrT+PcgZraJb3Tu5L0DZW3bXseifeKhgKGu0Wxjzmr1qe0f+NcYac4QKadftyLxL5P+57hI52jdUx3cmJoGBfci5tMjyXYjG8rIQbZe/UXTgbHSQ=
Received: from BN9PR03CA0448.namprd03.prod.outlook.com (2603:10b6:408:113::33)
 by MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:24:14 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:113:cafe::24) by BN9PR03CA0448.outlook.office365.com
 (2603:10b6:408:113::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 10:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Thu, 9 Jul 2026 10:24:11 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 05:24:11 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 05:24:10 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 9 Jul 2026 05:24:10 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 669AO9sc1010644;
 Thu, 9 Jul 2026 05:24:10 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Thu, 9 Jul 2026 15:54:07 +0530
Subject: [PATCH v2] fdt: fix phandles not copying when using templates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260709-binman_template_phandle_copy_fix-v2-1-6c4017eec04d@ti.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/5WOQQ6DIBBFr2JYl0axEunKezSGII51GgUC1NQY7
 160J2hm9X5e/p+NBPAIgdyzjXhYMKA1CdglI3pU5gkU+8SE5YznnAnaoZmVkRFmN6kI0iWrn0B
 q61Y54IeKine61HCre05SjfOQ4nPi0f44vLsX6Hj0HsaIIVq/nj8sxeH9MbcUNJ3gg6hUUZZ13
 US8ajuTdt/3L/bLbYHfAAAA
X-Change-ID: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6
To: <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, "Anshul
 Dalal" <anshuld@ti.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783592649; l=3658;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=wi5fLkrM9RRcnWeZ95WbnQ3y+7BSyhH6/XjGYAD3uJU=;
 b=/wQywkjPF72ZynjBDJ/RhuocmuW0cvdXkIakRRhNbK4ODHhmaOiBwQmyCuniQpsLO+TGwPltC
 8W46T4GShsAAR/75VeenWFowiDJNd7rmUIFSTg4ZTpzCRDZ9lSEkgsW
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|MW6PR10MB7640:EE_
X-MS-Office365-Filtering-Correlation-Id: e75cdefa-362b-4fdd-fc56-08dedda437ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|13003099007|3023799007|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: zamLDFZIPMX7ivgWDI3DbRTVte+VEznTwnOHVWnxHiw4w78nMScebQTXeAm0QeCRkPLJqzBBCe//tsWFInMzP8Ls5ro2kV4pLXoBT33Htj4Eiw/sm6r63/h/LuXU2B22j2uMqTqJ5KabBab/dWYdQIx1Uk97FzRtcBf01RGMbkk0qJ3lA2AFr/masIgHMThdyZmBe1xO+h2f6D3p0tM/E8DKbslQB9ftQy28ItO9FnM5BKf/qXQIV/Ui8iYHSmSPOZ6MH3VQmYn90+rJhzVScOJ4xYnXvlIvIcnl6TGvwbUwGK7/UFN+8aIX73sarXgEk08ReA64DiAJzR7jPQVPbZNzXwc3Am8oo3prwE11NZm7HiAdKzjATcctFxGYlu/H+E2xwsPrHVdU1gYgeddhy546vrNJeN8bnWM93POGOuOXOH7eF1GCuH4w12FWIIhnFjpaY1bNgrsN69BkZUGA7XbcW1gYVmuMR2CK0qERv4rPpaCEz5J9+Jb+uYuyp/5ieZO5AzNMbtSiO7ERiccM1C0JsFOCJ7AOxl927k3HeZtL1f5n5TwUpWeJKmRaXAB5RijiMXzrCwuWiDqP1YDYC6Hu2UqJY/DhKHxPqDFYqDJoE0N8ojUTP3NSYOPTKV//IUhHak5yKW7tjtLsC6uoqX4rcsuIO6pBvnvARCSIJr8=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(13003099007)(3023799007)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s5jaaiy2V/fXQN9PsRX9GlnpfD+Gf2+Z+ZH4iw5GwZ+F6io5tmnK4m/oqP12+Dx9wB19DhOV9V8D+qS9JfG4qmVCE0xVINTrDLkjjitmCc6hP94ctZ9Ekfwp3sthFhowlcg+PCFKeHvPwgq9w1TmYkvbAdm5QCoIrf5REJg316l9jDhryAkBtv3dkvWt5hVVDB8onosgfVUffnKWbvXCwbM0SEbIBSEQayXgHHfy9mkQ/SjNE0NF10bGauabiPi5N8jYhwZfNQkn8qxfqNP1DiMMIfqM40O4idYmPlAKbMROSlxA/UeTld70a5hdW3A7GoyN+JizFMDXlwxOp4O1y+ijymV5N+yhjLMVTfxq2JNZDYwEZHATBNTmWDKfy5R9bnFY8vdzUdW71ZtWd+CAul5RRzInxkGEDZHGdaIaWdt0IPwqgBpYcNUl8mSWlZUh
X-Exchange-RoutingPolicyChecked: QEj0OaAzo8RnJ7cfLa+R0W43Vmd8OpO5xeZdx1NPGtt994GjM8jkd44KkzAmCd5V939MUB5ae+/yk60CfTFlZ3nGSXm9o5Y/bk2C7tLcXMfDDfEZukq9I7XgDlnB/9miUKr1qpLvjtfbrZgK0zJ97fbLvEIdF/fxO+5gzwqJoLTM1CVzOHeDs1Zd6vKc2bqr7/5j+UCgefSA4G/Ix/HEbldVWXAAamvgUjKfqm4I+xGfKAboWdIuAM613bVuJvKVZzq0DgUmD+vLmGqFKSJ3uiiwRqnDjilDnE0ykoMiBH0APZuQ4oEn6XvHDFRXebQpFwRcrfT+UZEeLaemzMedig==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:24:11.4951 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e75cdefa-362b-4fdd-fc56-08dedda437ef
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7640
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfXxIT2SXh6bLih
 /SWxu6xVGJ2A4dZuHUZhCPNqGill6Ha2Kw9LjyLXruC1V92+f2emT50cTYj37bIQgCBcBpFL6S+
 eSJQO2BMgizMf7TH3h/KaRbnHXMXUA/2HH2GldipY4aOamIl04nOLg1hI9Z23ERj92U5V7gcVUF
 UV0SdpK4crHVOFOkYly5q+YejdM03ckI3tj02bZqLLk1TKwN4EPiJiCvZsjRk9Hw6xMmCv1ry1r
 MLbuJenW6Uwqh9LNkJeVAxongY+U0vMoRlNfy19uFaLx1bJ7gZD/6AM5COJuFsyAB71GD6knEhP
 p6VO0yiMr+SPU8oYmrArXQtZEaiTeSO5EGyCUTpMxP/3vcjaFK/8H0NBCQXRd1M+wGIwTfeoMxP
 +PksMZcNMVYTfT4MwIPTS8A7IeN7t5kyezLOpFziqZSFnB7z5FvwU2lYk2J8UVTP1PoWR3dzRk8
 93PUTVFpAVktxmCfA4g==
X-Proofpoint-ORIG-GUID: ciNdDEQO697j8apjsY5RqjYQkm9mwS72
X-Proofpoint-GUID: ciNdDEQO697j8apjsY5RqjYQkm9mwS72
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a4f76d3 cx=c_pps
 a=9ZCHOKVckkl3mlSiZqIMSA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=bC-a23v3AAAA:8
 a=sozttTNsAAAA:8 a=vNd5UedqpktBE-O_desA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfXyY+wrQLULuMC
 preJn6IzuPDT10GI4iZENMuwEFLiJbED/379mmoL9bD+FzpUFC12LbgbmwCbp1KKN2gND/11eEW
 II126Hf2pqs7uBL0DSxPGyT8/6v/RD0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090099
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

The phandles used inside a template were not being copied to the node
inserting the template, leading to a missing phandle error.

The following example can be used to reproduce the issue:

&binman {
  some_template: template-0 {
    ti-secure-rom {
      content = <&some_data>;
      keyfile = "some_key";
    };
    some_data: blob-ext {
      optional;
    };
  };
  output-bin {
    insert-template = <&some_template>;
  };
};

With the error 'binman: Node '/binman/output-bin/ti-secure-rom': Cannot
find node for phandle 103' observed.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
Changes in v2:
- Add 'testTemplatePhandleCopy' binman test
- Change assignment in fdt.py from unused 'dst' to _
- Link to v1: https://patch.msgid.link/20260629-binman_template_phandle_copy_fix-v1-1-196f95a13388@ti.com
---
 tools/binman/ftest.py                           | 17 +++++++++++++++++
 tools/binman/test/fdt/template_phandle_copy.dts | 22 ++++++++++++++++++++++
 tools/dtoc/fdt.py                               |  2 +-
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index bf98b268ac15..04459aca7530 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -8552,5 +8552,22 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         self.assertEqual(len(subnode4.props), 0,
                         "subnode shouldn't have any properties")
 
+    def testTemplatePhandleCopy(self):
+        """Test if phandles are copied properly when inserting template"""
+        _, _, _, out_dtb_fname = self._DoReadFileDtb("fdt/template_phandle_copy.dts")
+        dtb = fdt.Fdt(out_dtb_fname)
+        dtb.Scan()
+        parent = dtb.GetNode("/binman/section@0/section@1")
+        child = parent.FindNode("section@2")
+        parent_phandle = child.props["parent"]
+        child_phandle = parent.props["child"]
+        self.assertEqual(
+            parent, dtb.LookupPhandle(fdt_util.fdt32_to_cpu(parent_phandle.value))
+        )
+        self.assertEqual(
+            child, dtb.LookupPhandle(fdt_util.fdt32_to_cpu(child_phandle.value))
+        )
+
+
 if __name__ == "__main__":
     unittest.main()
diff --git a/tools/binman/test/fdt/template_phandle_copy.dts b/tools/binman/test/fdt/template_phandle_copy.dts
new file mode 100644
index 000000000000..5c6782372a48
--- /dev/null
+++ b/tools/binman/test/fdt/template_phandle_copy.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman: binman {
+		some_template: template {
+			parent: section@1 {
+				child = <&child>;
+				child: section@2 {
+					parent = <&parent>;
+				};
+			};
+		};
+
+		section@0 {
+			insert-template = <&some_template>;
+		};
+	};
+};
diff --git a/tools/dtoc/fdt.py b/tools/dtoc/fdt.py
index 991a36b98796..cd687f2eaf2e 100644
--- a/tools/dtoc/fdt.py
+++ b/tools/dtoc/fdt.py
@@ -780,7 +780,7 @@ class Node:
             parent = self.GetFdt().LookupPhandle(phandle)
             tout.debug(f'adding template {parent.path} to node {self.path}')
             for node in parent.subnodes.__reversed__():
-                dst = self.copy_node(node)
+                _ = self.copy_node(node, True)
 
             tout.debug(f'merge props from {parent.path} to {self.path}')
             self.merge_props(parent, False)

---
base-commit: 63f6cc8ba618396cb9c0161bb5c6d217604ae1d0
change-id: 20260629-binman_template_phandle_copy_fix-956bc3ce48d6

Best regards,
--  
Anshul Dalal <anshuld@ti.com>


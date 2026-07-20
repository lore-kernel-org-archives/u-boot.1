Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA67BC4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 12:58:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0432838D7;
	Mon, 20 Jul 2026 14:58:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SpVfdQAR";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="uZkpr0k4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C83783E76; Mon, 20 Jul 2026 14:58:01 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A61F880517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 14:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66KBep3b198109;
 Mon, 20 Jul 2026 07:57:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=RVAeV1L1Y096Ims
 9KjDKxuGnNkIvWi/XSKKv+hPtFxs=; b=SpVfdQARMpvotdvBBNmtBWzNVbh+M1W
 1C4OJs/7ANICyJ2aSjZJRIWuyEyNWWHUEXkDtM14VvV8wHEPqMIsPx3i2UF6MLCE
 pI6Yirw+/NTQImSQPsNZXjk8t+pgWNAuTWNE1RGN7Lg03LrBOZzzNJXbKTN/Xd8n
 bg3ihQHZ0gv3DaGiKXLL0hhy64tRrCHuBAuRY0INI6EWW/YbchAotlI6JRdlfzL6
 04VSCFO5Ah3TlkvIYkbA5nzACqqgsi/r0zoxeQZ9kjRSvCyNgVo8JSBt3QPjTWuo
 +aGNNkCvOQtaws4zc5EI+ICtt3UyO1unTm4TzogKrt2uJH3ctZDOMiQ==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fhk0y0c77-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 07:57:53 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFHTZ6mBFzbZ3B8Jml2ATWQwxKV72/VwD13ZRVWaDmhhky4/ByYEdy6wfoe849IKQqJeHWZDsSLclHCVeRVI511JV1t8BxV/NqS6U+fpLozS2Vdz71kLsjQZcIKhdQG84ISfk9rVGoCBLUWDgpk4dYhH8S+plPwGalB4bCzxvWdypeD7JN01x8sTxtPizl2cLKT+oAqg0h6Nmy78nrQjZFCavYgbKaWpxAlaGkvaSSDRLrRYuJx8RNZHhYlnUa4lmeBXuNmgbTYcc7naeweRaujMutuxLZJu1aWcdo65K8X5hZkmD6QMOI6xhIYWASKTzzeg0zpcQ/VdubPcYfDTuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVAeV1L1Y096Ims9KjDKxuGnNkIvWi/XSKKv+hPtFxs=;
 b=yVpUFAeT5/YiACKInAt8axEZMidnK4IzmRWVGGWpw2fRl8Q9v1eLxhqzv4C3X5X6a8fKqORCKOuT6KC1TrdmiWVlwIjt8ox8XPVM6kxTM5Iw4dRUtMTEbej1bFGSfXYYOAZgnOdBsmssKb+nuaLU+X20KClNWzkjMV1T6MYhNfwNNmc9W1Xra38FMi5lTU/4oeIe77dm/KhvVUmnn4lGgLzREoGgJj4XwhKl8ZhXQaIvqL99X/z+v4Hx7Az98ejgSiUFEbAhwOgp/W6Nq/nxhrxujBJrtcs82bPlaoxYXBGwrwhJrk90rU5k2wzeZ/f+qD0bXHaJ6PP+ba9+0ejw4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVAeV1L1Y096Ims9KjDKxuGnNkIvWi/XSKKv+hPtFxs=;
 b=uZkpr0k4PpYFA0OEqgvYIFJSWTznw8CLevLv9qC1qMgFVzWsK/q6BXTJAV5N8Zm8dx+OEZAa63/a7X8ljCJhrQuRxhB7tIZrcPP5UBbsZmqGeB+wH6Wtj3wJCqGo+OaDy5eKtO+27zdUqvu4GLkvfMSkKLmz6nwpcgAgJN48toY=
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by SN4PR10MB5605.namprd10.prod.outlook.com (2603:10b6:806:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 12:57:46 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:2c1:cafe::1) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Mon,
 20 Jul 2026 12:57:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.0 via Frontend Transport; Mon, 20 Jul 2026 12:57:45 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 07:57:45 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 07:57:44 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 07:57:44 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66KCvis83016587;
 Mon, 20 Jul 2026 07:57:44 -0500
Date: Mon, 20 Jul 2026 07:57:44 -0500
From: Bryan Brattlof <bb@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <anshuld@ti.com>, 
 <hnagalla@ti.com>, <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 0/7] Add support to boot TI K3 HSM M4 core
Message-ID: <20260720125744.kwh5tvb6kkoxgsvg@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260720080114.775206-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260720080114.775206-1-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SN4PR10MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 685c7a5e-8169-420c-eb56-08dee65e7e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EEuwPK5GwmhuglDhzzvMkumRWYFtFaVKGZIe8XkpyBwP0nCW+qxtZfAAeWId5aOGVJP0232x8VikpMq7/8DEcbMpJHlXYB6mXoP9jYlqgkgY4YwPGAtR9ZmbEnegiOtAFyvyEAu8hOxoizyyE/9/ZpyuWLQAMrZqRCD+yxNlcmusfTp1FGcLM4RXxH66yoXEksuGRx7UAFBF5w/5Z4z+0qrDpjQU2nqj4ZXURhq6dHwh6Z3yA3o1JzIhxsXLxD47CaRyNd79pQbl5JhI+Z6ToPr9K8f0XNT6jU3ybGubG2wAxDVd1I1Eopr+zgRTQeOG4Sjnc+fXccCCIKLHhFr0dRdvYJmIbJq+VnKEGgZLp3TI7tfwRHqGZstp8hEcNMA2rQM9GK2YoiwCiywogR/0s/nZkKBUUOlygrDD51mkl/a6XL8siOKsAm9GpUlPF0LgDlEhgGrfTA7pdL8jOPMSgRf63p42ROjR7SlC9YojVxHpZ2nMPUuW3R8YL5QK7Cu/6voEN93yzqkg9WOPaXnua0agOzwSqHqYiAUimwGdipX3LI7XRHzHf4/ER4Ou5YI0oNB3z3ydKTd1EJIcZdPY4elL0fUHzkqUd2CgOKKgS+NlUpeGssJj+9n3T2FJLGVyKO3IFn87Bt2odA1PfqledmQ5bT0EgiFjKEOlh/FYl00dKbIiGagggN9c7w3rGg4RgDrnNXEqCRBDkEdaGWMNEg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VOlcg+8QcG8o/S/sW4bC7EdO55MV1mh1MZYa2G/iFgybglh2x7DhMkIqdcmJCE2PEuMJ4wM06mhWlYJ85KCWEFIgwUsO+MLa8rkLsOyV2gkd3LProEOyVRo67B13w5JqX1o8sZ+svjKKCixdtwz8iOWC0W7tuUCTA+q/Dem+23Getsx0NhYQ9uE1qFRT6DS93hD+s7C+z0FxTUf5/EdEG1fnD/p6LZZkJFSsAK5EC6DXDSRpeSWR6ExfUQMiTngLRMKCYkOwZ+SwwehL1hRpeM7tiZeFn5rzVAtqVc2PMQgUk2RbPB32TB+kqpgdqOoOxgePocSNKvcZydwRk6uz7lbS3REUB9c2ugLEaAXLeeJDuSq0vnefg/Pm0/iR79UC3NM+iCBO45/ffz5oauQr+c1XIsWRmhQXmCkpWg3rqtIMqBUSxHqjbV+lgCGbEpRr
X-Exchange-RoutingPolicyChecked: Dtu/6iSam1MHGR0Il4OB/+BiZ+o9VFlQTevXtLAwh2GfMeUx8bpYFcBAj7XskGYSyd9n5EcPtIWKe1K19Cw9FM2FSBx6GUN4wiCCcNTwEw4IgycencacT7kNPg2N5wXTIjslQ+mD6/QYwKLFpMPLdK1IgGIqJgYsEF1Xs48tgV5LoufS9zccM+aOxPYwAd/ZScQ2GCRYjjMpd8fUl4xs060/G5gLjhjTzgg775UB+fWNeiBAzF65/1daB5KO3LP3dIOZ4vfCdXvJiYZcySWm1Lq7t11gJFar1eQGNJoRzBQqb9oJ4K7jBrGZnnwK7R7ZefyO4kBlML18+dNNFGmDQg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 12:57:45.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685c7a5e-8169-420c-eb56-08dee65e7e85
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5605
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0NCBTYWx0ZWRfXyY5wq/qFAwjk
 dShtcXL6M+x4mPzQ532kH9X8Amk04AS8fzQ8IJtVZSnF6byz6Qvq0GxkgFMsYCZGxUQuZ8XksdF
 Uw8V3cBdmKq89JVYP54aPOafxvKkQA3UZwVgKPU4fS4hEpJ2ym+Umlfeuzyy5nmlndlm5Rtd72i
 9Y8sI9eX20FF7wmbdnLbBEe7ByDNHVYd2Wedrmm/HaZCXei1/JVXBpXL0Ju7jV2T8lTqG71L+/K
 q9u1zQox26zaqAy8SYgAKbxQvRBSNg8Mg200IqfktA6iL8lcW7a3ipr0ap2cNwbQrgEPB0DvFla
 32AZnAqZQ/l74joPJKeqweUvi2+KMUDcDz0cWmNKS56f/d/Qc9DvkwyuQDeBRjzYO1M2Jl8qY5O
 7mWyqh41iC4M8xYDjaZQ2sSBjdONmC73j5cOkNJoPLTjLpqPHy/y5ZebAGBViVtHgDjfTNWlG9F
 E2APwxebxBVpOnSUbJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0NCBTYWx0ZWRfX2GHSRop6nO91
 MSCj/eNPneHnzpREaM2KeUWfZFKFwqBgytNZSSnwJ90/m21h1rSLXSmjMarWh8r9gvxmOsrQuQ2
 vwWFuOptCK5gNUFmftPY+j5oUwrn6k4=
X-Proofpoint-ORIG-GUID: NuR0919ExYoD5AJZBGhqnb-26RmXfx4b
X-Proofpoint-GUID: NuR0919ExYoD5AJZBGhqnb-26RmXfx4b
X-Authority-Analysis: v=2.4 cv=J8KaKgnS c=1 sm=1 tr=0 ts=6a5e1b51 cx=c_pps
 a=m+Y8nsmXU8Fd5URmI4pqsQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=mlZohJkcvn9f0iUFKX8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200144
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

On July 20, 2026 thus sayeth Beleswar Padhi:
> Some TI K3 SoCs like J721S2, J784S4, and J722S have a HSM (High Security
> Module) M4F core in the Wakeup Voltage Domain which could be used to
> run secure services like Authentication. Boot flow for HSM M4 core is
> different than the general purpose M4F cores, and is as below:
> 
> 1. Request control of HSM M4F remote processor.
> 2. Assert Reset on the HSM M4F remote processor.
> 3. Request Secure Entity to Authenticate and Load HSM firmware into
>    core's internal SRAM memory region. For GP device, load the firmware
>    manually into core's SRAM region.
> 4. Deassert Reset on the HSM M4F remote processor.
> 5. Release control of HSM M4F remote processor.
> 
> This series adds support to boot HSM M4 core from R5 SPL stage. The HSM
> firmware is packed inside the tispl.bin fit image. The firmware is
> unpacked into a temporary DDR address which is then used to load HSM
> core. The configs to boot HSM M4 core are disabled by default.
> 
> Additional documentation on HSM M4 core usage:
> https://software-dl.ti.com/jacinto7/esd/processor-sdk-linux-j784s4/latest/exports/docs/linux/Foundational_Components/U-Boot/UG-HSM.html

This information should be included in the docs here to avoid issues 
when the evil vendor tree gets out of sync tree every year.

~Bryan

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E387C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 10:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C3384942;
	Tue,  7 Jul 2026 12:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YtN8tcYO";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ny2LTPoj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77EE184979; Tue,  7 Jul 2026 12:02:31 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A0F3846B4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 12:02:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6679X4163276732;
 Tue, 7 Jul 2026 05:02:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=SRB0kR4S1ItIvKREpr8zpA4aXZj/+UtaVgpAawoQR
 7s=; b=YtN8tcYO2s9/eCFNlsO68yoQsVwZ8u13hs+jRni6/O9udxxvI8G52iZDo
 1AumlQUnuTXCwS90lZehHpjUu2OO/9qJL9+pJDb/aHKUV2TnjwQv1GGVPqWpPauL
 K3lONslVTctgyMfGEjuVV+rKjsR62yuyhHipfZtl5ENctpxbMrnoI5uhyO88JW0I
 nVym1rvWHSIIflfv6KEYQbTrRQOHVSUVGYxsGCtC3dsY6A80Oq2Hhp5zhBSU7yid
 6hHeSR5gfSDVQrNlFMUaT9s2FKUoE22ZSAPdnnjQ8QkqndZdLHS+ACY9nfphZtth
 yffD8x8mziQBbuqfSc3Y8sodnH4iQ==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012062.outbound.protection.outlook.com [52.101.53.62])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f8xx2g4je-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 05:02:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zL/91GQ97mVhpGcZuos5ALvTLeNM4g9UuGUipg8c+nyGMXFd54hOwFdJCMNcdzOVoa6zAzrXK0DYBtbacC6agkgbpJLJvHqWF+fN6HA49UFXKG7h/GlpldJJbed6v7TEJn7HxUl1Ij7JvqhnU5FCzgvIr22I0ipAa5DXBSDL/QNRs1puyIpOx5deg7tztRk3/4MoBBYrjXsqLIl13cmejRUXP+jw/3/68+kjkyt/K4b5FbfJqboEfK0y9lm76DUOa0KoltYHa7oVo3HdA8YZjvG4IHRkQl1Fv1WGG3AxeQcqBy7mUIh93i6VcdcTSknCNKv04kUEqkc+F8k18KQGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRB0kR4S1ItIvKREpr8zpA4aXZj/+UtaVgpAawoQR7s=;
 b=FIokgCzVndLYrN2pURjNox6/1I44nCK5x1lyAWLqnVuabFkIJzGBoXkpJrhdRc6J1Oq838OK+UHyt7i+a+rkNOKFXxclFJed8/+3T9pfjSg1e+sKA4BRAjJTNJ+CKqfwNVJ2DYPRzMFgEZGJf7WYUGG3Yx+/kcEl5qCAzUktDVrJ52vRomyxBdtKRh69AA7sUy9n4gfBIiNTkvlZbNM2wGcSHSOe17fGGoh7qchTrFDMIFUiSr+1RZBqL/FAhJPa+Lg0BxXwF8YBRhiodtsmkqZUJefTGdIaZJpwB8aNkcMNWcFyq8PpuH74HNjRb9947oEP0pJwQbeZ72bhnUDNxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=gmail.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRB0kR4S1ItIvKREpr8zpA4aXZj/+UtaVgpAawoQR7s=;
 b=ny2LTPojKqrwE4cyZRd2meAYyN2zVwY8BEgtZfYYXGnRuZo8eY01zfXZVmD0H5FtDL3WTEXuUP2vE9hG2rZIVdR0ANEDR/pR+wJxxeRc7a0JsDPnT3zt8uBI+8PrBJM6pvOvnDS9TiKS+PSAT+vWoZP0UNjR5U+7H9sln9DIQwU=
Received: from CH2PR20CA0010.namprd20.prod.outlook.com (2603:10b6:610:58::20)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 10:02:16 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::62) by CH2PR20CA0010.outlook.office365.com
 (2603:10b6:610:58::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 10:02:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 10:02:14 +0000
Received: from DFLE203.ent.ti.com (10.64.6.61) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 05:01:32 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 05:01:32 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 05:01:32 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 667A1RaZ4144717;
 Tue, 7 Jul 2026 05:01:28 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] binman: Add an entry type for the Intel OSIP header
From: Neha Malcom Francis <n-francis@ti.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>,
 Aristo Chen <jj251510319013@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Neha Malcom Francis
 <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>, Philippe Reynes
 <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, Tom Rini
 <trini@konsulko.com>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>
In-Reply-To: <20260705104231.3846672-2-sjg@chromium.org>
References: <20260705104231.3846672-1-sjg@chromium.org>
 <20260705104231.3846672-2-sjg@chromium.org>
Date: Tue, 7 Jul 2026 15:31:24 +0530
Message-ID: <178341848410.422455.3507166516183624933.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783418487; l=689;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=fgtD2/9AJHaVA76ePePHXrhuPOGK9ag2s/hDepo7TQ0=;
 b=9fx2CT3Nvb+szdjOmm201h5/ikrcxuNCFOSqzZHJoEr7xIwcadCIdJqNSHqKfyBAip9ZjJ7SU
 H3VacmhaFEUCTvsXlnx/s9oheM3UuS3y1ruwLs++ufFO77dxMjUF2RC
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c4dc61-55ab-4a6b-6445-08dedc0ed254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|6133799003|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7ZjmALs+Nqylq5QUExLxj8f3lZbAHwrLZ8v7CGeAXufemGtcPzh2xUVRmHzDTmJjaIGQQakOb5fSI3YQkXxYk1nQrbOPl8GvZsyXtUrIEFO/0egyVEqKw8KYPzAIj/PyeU2QoxpsRczoMZNgoCU4hEH7mzACNDURqdza65VIjx5zMhnURK+Hmy+2AVvDIWZSh0foisBl6SwVmF0DaDPWQbXqA6j/UbxJnGGhKmmIW0qO+kgttHB8WuARwouLj9KJ13aE82d77jwYCVyRD3ZlaRGuT5MSxMT4WhQ9A9A700sUTrAVajwPmgp1IG2ML1kfZZBAput6+UltxG2CqanuWS4M5kPWVa9nOJ1MhIVYiL3HCa10mimUcXKSfXZ1GBv35v3I4Ye1b7Mym5o7ixIyetEg0hXDeoxOv0bKBY+Syf2nyDDdjuRsoGj1QYzOIP/x6shWpbmLqC26rhqGoS5Kau9OAO7uh4ssi04PZpJgXWQmAzcjM7VH7VbkxvKoanxb0yRMC+kbA6JYFLFW4Ip17S8h6I9gtaxHCj246/KyScVMCjXNfMa5StlUGgrbQLM1rdlsSkg+3KoZauwWD+Mtr6770J5nxATAFikv9sh0FgsSeYxXOvsOCy0ODDXEP3tQME5jkzuTd6tM7bqMSo4d4lrpi/nZIbVLxaPXa+t0hPhqjrKijPghfJvyTl5rmHCC3vfmIIkXAFHPRaA8qalK/A==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(6133799003)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EvzeCVA/5qHN4lsnflLsHHzAz2yeKD0CC+sRO86QrKfhNtMU81kiLhgCVBnofgKqdhiobZZodKXyXTrXudTuKOMajBQawjs6zSI7MnZRtnDCZpp1R2NEeN4va2nCk/BNa7ZkVTfRc6+fu168vEiw6/WYEs8fRsf+6qRDycP32Diz3dP5S1POFdbpquldjruVWiDPaZJG2dY5mqChznExVx2tNmU0qFrEV5hWt7Wf0kRecAgbugxh/Hcw2vDABbNZW9x2b8KDqovSxIZVqiOwhmIfhN83YKedViixcXazPrKwAX7antLuyg1m8M/W5YxFnhhJjQiIHpQOJxd6+qQarf53+YgcGQ4ZqkJAlQ9kyyUSBHhXLPhjUkpyN6WDBs/Huo0usyr25U7HTC3bCpjrFOxPGAN7ON3/ewXziqeu+2kOO58vW+C5yz2N8uXtkLMV
X-Exchange-RoutingPolicyChecked: U0y55AeNOh0q36nEEd/upMTru/PIdsgJMAu2JqhSVFstqT3931QGkdP3rD6FHeu9M8P1SnzP4Js8k5uEPmYFcX/tX9/PH5CmNNr+bhlltOHuooRahlMpFN5Sd0Svez1Cgn8q5vrAmrx+csHjhXm0z7qK+oWwUxR/WJiKekc30PK0ronJc1AXWneT0v3Qae+plxLX2KkjRhHZoVPs6+/MB6aOiBx8U0IrKAlrpixjAHICZWaEtK4lCcIyuZ3G3zBYo+MXaxzG3MVgKqmNfimAondnyzwcMbXHyjhlBK9valN6HOy7YblHYkNI/4xgtjeVOz+0e1gElPbfCNugHbPUyQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 10:02:14.8669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c4dc61-55ab-4a6b-6445-08dedc0ed254
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDA5NyBTYWx0ZWRfXwDzY+rmWxImo
 9JQqfj6GD0u/YmhOBGqHYNkfnGz+G9ntL2W//4ZoK8rhTxKlAFrElpIPfzLg5zJGVBe3Cn8u6ns
 AD/9voPdaUV8xJdtJPN4a6QuwzIWLtI=
X-Proofpoint-GUID: -7zzEg-iCOgyG6J9r01jD0poTeGLcNYy
X-Authority-Analysis: v=2.4 cv=aLnAb79m c=1 sm=1 tr=0 ts=6a4cceab cx=c_pps
 a=cj6+QZNyov9unU3rCXIAQA==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=cm27Pg_UAAAA:8 a=sozttTNsAAAA:8
 a=GpPby3QKp1Ez1Xz5fxwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDA5NyBTYWx0ZWRfXyKa3j7PZj1PT
 ZCz61iakz4Ouv3KS+Jo0vHaxMO3wYIn3y5DXTWMdWSOZZs+e3G8iD04Ux22xudHhftdVv2FA7zr
 xnyIay+vrPl1/ujthXKMac6DCle/x0DeGPqsS28gyfCnMZt66EyihJL2/+2MDjWhRGH1H0X8tqT
 stqFdUoGL6x2XsO/tt+uts0I7SGFuFbfId27nGXGlEfjFhK1BPAzqwvtlKlOyliPuiFuIT1d46D
 //hPWHBwqzKV7ArW3zUMeG9cvhIPakQLYIl324EAEDG2w7oWNtP9NlufHRAS9z3pAIS91bYMISd
 yErRQ5yQRCyYsyEfc5u4WFjdbbqAUvTuFdgc0vsCMCdGGm2a5afLFpIw7oYzl0QFdPqYYMBQQYh
 rYagj29glHMOkaTcfFJqCpJlm51bIYcZSsIY2Of6+YeUvTrfOSMNRDIlAZkOsoXHad0Q72vJ2i7
 8ZtN0lKP+eGH/uvuA0w==
X-Proofpoint-ORIG-GUID: -7zzEg-iCOgyG6J9r01jD0poTeGLcNYy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 clxscore=1011 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070097
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

On Sun, 05 Jul 2026 04:42:12 -0600, Simon Glass <sjg@chromium.org> wrote:
> Intel Atom SoCs (Medfield, Clovertrail, Merrifield and Moorefield) boot
> via an 'OS Image Profile' (OSIP): a 512-byte '$OS$' header which tells
> the boot ROM where the OS image lives, where to load it and where to
> start executing. On the Intel Edison (Merrifield) the OS image is
> U-Boot.
> 
> The Edison image embeds this header as the static blob
> board/intel/edison/edison-osip.dat which is an empty stub in the tree,
> so a fresh build emits an all-zero, non-functional header.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>

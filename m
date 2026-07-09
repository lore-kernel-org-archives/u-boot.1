Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45147C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 06:31:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 943E784A51;
	Thu,  9 Jul 2026 08:31:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LpGM/e8Z";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="HIOF09gR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66E1984AA0; Thu,  9 Jul 2026 08:31:21 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 200BC84A48
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 08:31:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6696UV8C293343; Thu, 9 Jul 2026 01:31:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=cE68RcYtPY+1dBLj3ziqdoPfeVTUrPJI5TtG2EYYx
 AE=; b=LpGM/e8ZWLsL7KZGPlZ4w1vdNHIUdclBGK6ETReVWu/kSv/tb6uir4PmK
 xMWkPMKGZ5VkBjHNb4JOqb7MgDd54KDOx6V1ma/n5YkyhJNNS/BMcNtqvytwlG8r
 fTOWdPpdsE5b7jFFWzm/aRQmfn6j4NG7zvj0tcv5MZ5I4YhNqdE04tAtGwKEUH11
 7PzEP+Rb4mHi+EbWOH+ug51zKDHmF9BVjtrlgtwb82e4eGD5eMRDjy87hCj5h2v3
 iIuQICZUlvMFoUDfe4+5deaYfRfHHckCpQhLBdF4Y4shSYv5/r4WGVA7iu0l9vta
 NRDYzpt8JHL0180kDjg58WctjBJfg==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f9kuay5xp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 01:31:14 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FT8l9SKxH3FIchgk4tuHa/2go2YISSIkTcaFU3FNvXoE/4lcLsOp/9o7PY7y8eYHyAotCpswXBDu/1x09Ig76UlCECPPUsEyS0KlWJqCZocIoJvsG2sftXJpLFPNBXobpaKNCZsyy9iSPIM5Bdm/W92+jp7DCfOElcky+7eOnB5iBseb7lPqhpmsll46RC4x9LL92qwNzzUERug7Roo5gcR753mue9Bf9ahEWcfz5zuR9DsLOXdy51fos2JYTiRzXuijaqnOUEvP9/Mm1eWKifcYr0Df9jVZGJoTm8+MtRMLjuEbdDUOnu2rsH3u7cDLjSE7V8hPodLuAUzCVc5oHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE68RcYtPY+1dBLj3ziqdoPfeVTUrPJI5TtG2EYYxAE=;
 b=jm4HJaamosBpsAq2y3S4snx/tsO6ckEldPPdt0dASVZEO0IDf5Z2SIVD39bmt7DAF/65+4t9fzJjWzNBTJj47eXb2jG6MWv+5AVjno/GPUVt41YnIUBCCV6tSTFU/5Dg6Ni6JhBFzpeg9fwYeNGSpcTAJ+vulfhlKf8AkUf88zNnzdVhMEATcedduvehSDduHcXR1HB7SjLp7vdN/VP5yWXArtKlreFMCOaKwDSkm0CRTnw3nA7UY61pwX4SwxwTqv/6c7n/yqvZ00FwvR3UQsntsMPcnwizIwZJ4CRjFh61+qaLDVsM7ybYDbaNG+JluA0l8Y4PU4tcnzRqBSX0mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE68RcYtPY+1dBLj3ziqdoPfeVTUrPJI5TtG2EYYxAE=;
 b=HIOF09gRlZeK4qOQmxQMP3GV0xgTZ8Mnsp0uFmy3fwcDtWbUJLTtv7bSgcPgg34+qOBLXMnyOLma2UtIHOAz1q8PsP7cM374A5OPIpPG8wLYIIB/Cw0zkjIGCTQygi1/Iysw29WB31WAWu1NxCFRl1HzGpXlABJNwNkSFLLoa3U=
Received: from PH8P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::19)
 by PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:31:11 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::90) by PH8P220CA0012.outlook.office365.com
 (2603:10b6:510:345::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 06:31:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:31:08 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 01:31:08 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 01:31:08 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 9 Jul 2026 01:31:08 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6696V6M2605363;
 Thu, 9 Jul 2026 01:31:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] pinctrl: single: parse gpio-range as a raw array
 (O(N^2) -> O(N))
From: Anshul Dalal <anshuld@ti.com>
To: Jordi Trepat Mur <yordy1902@gmail.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <sjg@chromium.org>,
 <vigneshr@ti.com>, <nm@ti.com>, <anshuld@ti.com>
In-Reply-To: <20260625174121.3633162-1-yordy1902@gmail.com>
References: <20260614103232.3586246-1-yordy1902@gmail.com>
 <20260625174121.3633162-1-yordy1902@gmail.com>
Date: Thu, 9 Jul 2026 12:01:02 +0530
Message-ID: <178357866278.2041875.18356206259737251875.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783578664; l=1589;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=Qimlc7Y0x4WDpWaOPXYnNxzqPJ+MKx6X51grcMFrZYk=;
 b=+A2cP+XLv3BHxbzYXXl/KFdmc6cX5F+IxXiJ4FNv9SZsCcZi50SHkYEzT8MGpwCk8YBWIcEjQ
 tSFUu1G6I9QCgYhOTaAKs3kCrjMT/l+hCVn78ey8ydBQDCGxhJgjVOq
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|PH0PR10MB4759:EE_
X-MS-Office365-Filtering-Correlation-Id: fb52a6eb-c837-45d8-d84e-08dedd83a9a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: MNHA898Cm8UQCE4lhEN9KkG+grm1RJ7SGSzwKmxhjfKM99XPzjBfqAK36/Tio6LjTHvZmA79N8X1QT1Em4HmUTz8jIVaxzFHktje3fYDKlTD7SWvzwmqrWpBp5zlA2Atpy/0EAYPRb8l7GQTuMxxxexoTDo4Y9G0M3pgmb79mJrkXP6EUfcHhsffIsTfuWcbtAksQyLAQBakkd147XZEXFPXcuyZ1hxYIU3sDdiuXeTh8slifIfJZBXNMJIZzXIddsw/y82oD1gDRuaQYL3GGAeWk6bHfzFKxUGT/rf2g9UOX7coFHsZvLb6ZVtKc59NRzvKojgcb1u7fhPzGJOWB4X5cIXi80t/LTHIaNxrvsQHqD2P9tkLddgPactEfaPFX+dA9BArJd691XUO3ZPhZ8OOzNt+HSTtCpjqkvYhagTLuhjXIVbIEC/F82GCzAPJwnUz78S1CgGj0BnjvWL7vYCEtxo/BVEptZQyOgpIzdZ2MG7MXdc1muAKU3aid0IuTwrnvdF3PF8mFeQgNqMQSRP4XxOogaYQ3FhgyVc8nTGTLpf+KzygFpNHnbYIV9x4tDI7NaLxHg4lrU67Q13+WNzKjz2eKtWrgM3v7KXb/oKwnPqdB3XIk8kx0ja3eJCtf8523+HiJtrLQV0i4Kdzy0wCAFStn4GYC+Nk31y9D2tj7nGmZS67bm/sqvgvXqTi0t2vDxcFm6Wb+OeV/BRyqg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(22082099003)(18002099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OR6zGTuyRJipJ8YwUbKVqRzaKJmccrCDsy0QXADyOwa52UibVhKnZNVDrGhF1qVtcXYREJ1AfIdMOQiBCxbk7L8ljgRm+VNvpfM24QvAk5Xi/t2xFtca/QBWhLahHWDeJBv8jqBaZ6+tUGu+YpXnNN81iL3USj3y0ngoaA31FsyEp3KB8A6elDXf3LQlPNH4BjpYF13Ot8bUnOuYcyv+HhK3ppXyUUiCIid7LPHgo3LxTRzDhnhl4Eq6/NxgdOqdA9JrQmu283eFzx2ikMWHVohVhi+d7uIyddYnO7HSn5/uB4OaMMsX+9EgCXLkKlNJkvXyoL5t2mFlVB/6UOYIlOP/jfjkDaaoNMlk+if+fLV/N6efGEf3fuOk0jx/g5pBjYcAMhojdeIxmQKKxDwCnX/BLekBPbcAOPUJe/kh388vbnWjEjUxwPH6AkmkuuNQ
X-Exchange-RoutingPolicyChecked: h9HSef/aXKRfgTu4bcc1dOOOJr/kATETzJHDuprhuCxRxJ5NDICfZ8qRhKQBN/DApYm5NmNegvrNuKMZ1vEsAQX6gTekfvDQdnyt74jPdAjxirtFca3f6C9fSl31Egn52TRtuTr8qKaYj8kMd2Q2ns4UlCu2jjZ4GHd4QdL7+4ZQ7uUZGWG/ygfIp4VmQP0+AunRThvupH2CYvk+QcRmUv864AEpMCsja/srDuqjF8SkIJRRNeJxPFYv+zFvQOyYENbcU9Wwx0xcGwprNXW0+kSNvavm8ag/XjDTpuoeWkDwbzTyATLEg2qGEPMKusNMv6pO4bCK6OgSY42fqibD5w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:31:08.9359 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb52a6eb-c837-45d8-d84e-08dedd83a9a9
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4759
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfXw8Ahw5jzX1jR
 33fxAnPSv2wo3h/rmBzNtISkGL7v6uIbpxhBb0wiM50XcRvooHgbRqlh+h4zKpmbOWIPWvPV1n3
 hI3MeMBKE7QNp7rTc6bcDxR+sLgXUuo=
X-Proofpoint-ORIG-GUID: LUpk0bUMzR0OWd0H_J-5XAaLWZpHIvdB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA1OSBTYWx0ZWRfXwuFcmQUHXmBy
 8uiiFPcuPuwR6a/2BJgGl9gHCGcM+Z2KSZAZSryGt2bCgKr4XSkdUt8eDkbbATZrbnpwTtNcAXq
 HOxREY9/KwrxVhljHgNBzs6jQApfARudwbZoXIVD2kzDwUzEDdOQubVVj2Q/QTIWou0EVSHX/AL
 AsPgoXlzJvCbnykSSmoxKcT1BSzB8QBeuwkBB7BSgVem6Uj4KV6oVCjmGM8aloHxfBEfcgivwTF
 3RhfT/peMptwU/eHRo2p8jaxlCbCUMGxhdNI51Md9a+9oo+AdfF5U2vFKCJzMKDW9iahj7qvw0h
 MCuIZ22X9SMEO3lq5P7qntKZhAEbES+z+aoxo4inBBRkvivl1NbJWfe1GIa6u/x9qMTDOad0dih
 5vhzLLXLPElyJWTN6LXkP/6GJ4pcpSStUaw7cDvWoPHO48pyAWX6w4q2W0k5rtjt/qu5TpUh7at
 /vVDQXm5Bla8ecTDPFw==
X-Proofpoint-GUID: LUpk0bUMzR0OWd0H_J-5XAaLWZpHIvdB
X-Authority-Analysis: v=2.4 cv=GtJyPE1C c=1 sm=1 tr=0 ts=6a4f4032 cx=c_pps
 a=51LUNg6eRAGyxmNGkw1ZTQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=9oGcN9MZG_EtenG17M0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090059
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

On Thu, 25 Jun 2026 19:41:21 +0200, Jordi Trepat Mur <yordy1902@gmail.com> wrote:
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 42980e097e0d..0029a7e1a279 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -509,29 +509,74 @@ static int single_add_gpio_func(struct udevice *dev)
> [ ... skip 17 lines ... ]
> +	 * The original loop called ofnode_parse_phandle_with_args() once per
> +	 * entry. On a flat DT each call resolves the phandle, which scans the
> +	 * whole tree, so the repeated parse is quadratic in the number of
> +	 * entries and proportional to the tree size. This is very slow
> +	 * pre-relocation with caches off.
> +	 *

Nit- Why reference the prior code in the comment, it would just be confusing for
people reading it in the future.

> +	 * The phandle target is not used here (only the argument cells are
> +	 * stored), so resolve it only for the first entry to learn the
> +	 * per-entry cell count, then read the argument cells directly. This
> +	 * follows the existing pinctrl-single,gpio-range usage observed in
> +	 * current DTs, where entries use the same provider and therefore a
> +	 * uniform per-entry cell count.
> +	 */
> +	ret = ofnode_parse_phandle_with_args(node, propname, cellname, 0, 0,
> +					     &gpiospec);
> +	if (ret)
> +		return 0;
> +	if (gpiospec.args_count != 3)
> +		return 0;

This could just be if (ret || gpiospec.args_count != 3)

Otherwise the patch looks good to me.

-- 
Anshul Dalal <anshuld@ti.com>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53425CD5BD2
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 03:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B40C484671;
	Fri, 29 May 2026 05:48:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="BRNb1O6S";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="IdwACl8T";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="MVRWzHqV";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="JkC/r0Ac";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9FC846F8; Fri, 29 May 2026 05:48:56 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53C5383FF5
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 05:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SKUYVL614389
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=ThAEWmzYGndtLNeW7X0F1v8wK
 rZ8xUTlN6o9P0nH8oA=; b=BRNb1O6SzUC0a5X2/H5ab9XWlvzLGeMg01Gjjx2nJ
 EKZ6tfkILvDT1G2ESKzB2L3q36wVCjjoItPAAIUb+oLv5fsRoJ8TgyXBmot8NdFY
 5wssB2uoa89Gvgrh0kXUmJNaq9twEw9pf/znv+GY5BZcZpizQS4EIRGarnZc8hZH
 /cPyKNPhgtqkCmDdsGDW+cJyc4c0qkwa1mIu3DSQxDyDpBp8TvpeeknGAI1CwVT2
 PDJzYtmFzBjgaeVaK+2Q2I9qy386ormsTJFNdra6B/tjB66WgoG9F9n4NDdrAxmb
 3t5DnZwWKUedY4oSzWbUit/w8sr6+m0PtWl0qHbeNEoiQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010042.outbound.protection.outlook.com [52.101.85.42])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4eevta26nu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 03:48:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pySSInuw1A018DTA8Ts2TNmYukgWJouQMXhXBGFKRgQ1Ld3g6iZaVZIGYTjRizF7utgUmqcvtzwa4HVof4yb3aDbUq1UB+U+uZEHc7HBqKkmj0gHDoxS38EhxOGLjrdBTQ1Rjjg5P1m6tXPMso/J8rC4fqFd0PVa5EQ5TqqPGqUqBmGWPQ33SA4x8lvdfs9g6TuJCQNrAGGpyGmdvLYAepm2iCa3vNrqsjj428Krzd+UjTH+tLKQtcz3WkzsF5lPEgzwFhOR9N+VJpoXzvLnxaYRURb2EeZus+u62nRf+Kg/zDHmS/fepl54XjBO+ZsMxNuLXH5NnT2tOtJAtwPE6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThAEWmzYGndtLNeW7X0F1v8wKrZ8xUTlN6o9P0nH8oA=;
 b=eYkIG4eR8pICUMKJHpIR6ft2XKJ8C5XFENZI30qGdHDwe2a0mP0J1dnQVQOKq17+z2Z0I5HXyJL76fv8zwOue3AlzHAjldeoZu38FeLrQV+x62AHO6G+RDELaYYFGD3Vqhht7K1b3kZN3hgASMiETEL7V4FjfVxtoSuE8EB+La3zhHhkArxUdiQu/MH9sgaeQHTq7oQNRxMGYLPSNBcrJeb8dq0XOP8wwk4Zt1YmcUdN2JkXecKqAXByYf7Aeq76gDLQI//6DzUmUHlLwACODS++HiVEzWzWd6Bt8lrUZH0aIqg+1VzgLHPpWZi7OiqoCQRJ9dBA3KoRPIyNmunakw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThAEWmzYGndtLNeW7X0F1v8wKrZ8xUTlN6o9P0nH8oA=;
 b=IdwACl8TbfDqoCWBdOyW/1RpQMI7xvRRM5KXXENk7GaGVPWCAUgWvsEyuBTjR4l3gndWvTIkZOyKup3D/T/0Y5NEQaZRLLBASLA+LKOslrHqybg+ZMqKzsGyrEcfIRZUrlk2rojoP/CBmmKfhNyhZAn8o/dzpNLDYKmmCKMRRcw=
Received: from SA0PR11CA0181.namprd11.prod.outlook.com (2603:10b6:806:1bc::6)
 by IA0PPF33BCDABBB.namprd16.prod.outlook.com
 (2603:10b6:20f:fc04::fcf) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 03:48:48 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:1bc:cafe::1f) by SA0PR11CA0181.outlook.office365.com
 (2603:10b6:806:1bc::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 03:48:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 29 May 2026 03:48:47 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T0FFb42743679
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=ThAEWmz
 YGndtLNeW7X0F1v8wKrZ8xUTlN6o9P0nH8oA=; b=MVRWzHqVKe1tD4ss47PpPUB
 ybPPn+kICzGs5yMMvEkMw0AjQiL4Sq2zwpouDSGV1qTcu3MiT3bzzUxNcP+wcNrt
 cesOqeFrK4GCd/EemVgf/yWdCjY5rF8sS6kRsErCw9ZwjdsuVnck7scrCILnAw2o
 tYezjXnvGjDrtBfzNvZ3Kn+YiGVW7pqfUGGER3VsW9v3gZCzu587DNp7p/u1AGZh
 ARey7gLbYwFyLV1/BpA+GHaHQoQiKzScZWnS8RQ6u7d6Hsd0RK4wu7Qo09+bTH4I
 gCkIUnm69NJgD/xs4AmC6Ky3JL/Dqrg6gar+j+FSxESNbds9djil46ORCt6COaw=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=ThAEWmzYGndtLNeW7X0F1v8wKrZ8xUT
 lN6o9P0nH8oA=; b=JkC/r0AcZE9ie7BKL6X5gnIf2Hrrs1UHZQW7xS5T1Gwhqak
 IUejXvB0PUhp5pQzNnHDm/ENLE6Cjl6JkGmMNZJABxhoicPxLIRoqDo1hg/68job
 lHouc+ZTZoZXUYXhDHZaa8OgHtMy4LWlzFghbN8Rqb5N7bDXCHwaLgqpl0M1qEC6
 tzLdz67j55jHO2/AeC0sqToeUM/DohG6S4dj35sHSMw+8ptmxXOIVFX4ZcablT0Z
 OmFYkz4eRYOHx1t5Uq7+w8uaydGURhZTp5CdQB2+Bojp+Wzm5qFuOFbgtWRLPLeb
 wXUJe3HxSTakG0zKdPmwDgzMDew47kHrVoIrpfA==
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5su17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 23:48:47 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SoDEwZS7k5kHRSoDFwEdHu; Fri, 29 May 2026 03:48:46 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SoDEwZS7k5kHRSoDFwEdHu
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 0/6] reset: add board reset type
Date: Thu, 28 May 2026 20:48:33 -0700
Message-ID: <20260529034839.2075806-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290033
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|IA0PPF33BCDABBB:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3d149d3c-db0f-44d3-6b9b-08debd3530ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|18002099003|6133799003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: BXN+dWCNPTUzXwPXRxsYVuuGaeTfjj1ymd7lIiahwrU5fBTC6uSrkrROp5oRnQrCZ6Oocw6ZkSfv5XV5x9dqHqrOfmyD+TgKeZ1sF4wKtG4PayOMVQ0Bl4lg7tzluf7qQ7BqE3Qicl4J+wPhBpe8Yxde7DCx8jgzQg1SvSrebfhhgxqlFzynvrEwACo2DYfvIpTYvSyodXMj2AzS2flD5AIMOW6NAloTZZSre42qPbdEquefdBXFNG3A7rnfuyNqBnFd7E3fT8Z1yy3YMlxyo7sfWDnnczQBFrCbkJBAuewvlYzKxOXnu1N4IsJqSYxBTjPMrN1goiU0LuNDtQadfJc8IBV96JQHtvdUJWEXGeehIZE+mu9QVE4gOcXunRKORfYW3+e9PFhKey2AraR+6JtohVxcTJubTVITvEBpk4hs6gHkierbEY14TXZ1TCh+pIK5fn+AzkRhpVJuX4602S8rYD1ZGS/34KuF1DRyhiyk/3NQb5jHGbC0xYpbVF1umcvKLDhD9KhMtLbHaNtzTE1+NbukkUuE79FjAagyIMOM6HE6hmvIWa6bCitMLlWh3lFDpZtJ7RG2AXenMUWbzbN5QlFoaYKpVdH5u+mFbLqjq3ZuB52xczLWdWxXyJ51/qWv35G0Tb7Y3aPQOMCp0NHliVsk8eVuGnNORItRor5MnM9hCrZqFoNAaYAU5PJDi2Aada3rIHr0p4gA/TTS4gmwoHk6fFJUPvRp/oydn8A=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(18002099003)(6133799003)(11063799006)(3023799007)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gtikSwDRrPzMd7xs0TUBex0bLzDUvHslD7nxoWyODI5H5SQdktLIrZcRrYcIztTmErWxfS0OiiIP2i1wNbEpaLk88wRRz76FlfsAnlQyHJ3khRvnGDcFunEc/MoW9T+rs20bzldo5rFaONdCqNjNTUYwHu8f9NeFJHFNKW9yiFzt6xxj1AYaNd9SPh41sLS9lFw2h8FwRVtTY7uk53on2hJfzPifz8nK2FhjSBdOyEV7XrtJQjzuqdCLtTtW/J6DgrFEHA7QjCUTLISBgdzf1sY6b6L+H5StYnyOulVctDmJcvSh3vzkjdT8WbxzkF2kOWRlnr0xIkSYb20gfHcEHe8rVXgK7elK2UIhNhBdEswedg9v5mkLHifLTqG78I/13RNYrzhiMAsLqpbAv/NYWKeDZ6UIRnx600231+GXJRi5KZ9VCE3E/zZiRm8qGjZx
X-Exchange-RoutingPolicyChecked: JoJTwAVneB5jLAaFVi/kVEoKAUDXBlOVzakKbOMQwPH8sHBTy22hTNGDSsCGePZ7ROJGQE3Fk0OUEHJkEwguqL/Qgr/MshcbdJrRqdmX4SQcCJ1OWeatfAskW0i/e9jRMKmdgZXSc+HIoQYxgHEHSHMRDM2wTzGCh5P5cND3UQXOXjnyXPMmy2slXBiNoKWl8rfIjDA5A1ab1bu1meuoJUO2SYWzB7CJjvzaHGCf0+XGmrQok0iokvtV1640o8QiZrWTm84Lu0JsNNPwRMP7eaZgoB73gCfgk6GWow4quwBascw35u8S0S1FAaJ0eWhov+pHuVDfuUFp8cmB/T7yxQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: J+/AoEBJKqpvlgEqi4tlfoRw+jOaq6vZey4fDwX2s1K+QBpDwwJPdxi2iDi90lkG3+a2lp2L0QA811dqKvYe5+e6HVKCw6FjuNuHehClJDlIk/gdo6PnLsOJS3ewmEeRXmjJCCRpkXMxwI21paK1oNnOCiPB8QqXowePz21wKgSD0AvolSAP/+Q6dDowNc9UqD5ioJWisKmgJQEj83dJr864w96oKcAqbpcPuw10anx729csmOtweZLwcgNORuHmwTKU2duMlipiegNNKCkgeLiaFxOQZfwxylqW1tnogOCS0g84PFMfNtOcLma5Mi9ZQTKs09G6T3Ee10F2iX040fp/B5M2hy8o9ktdABD8RvrcFFKbHaZoA+z/0kBcE4JrzCA7E2kSVU9XyIn63xa6Fn00EIOWK9K3d8RgYTlitIhucKPNjTpPXhi0L4oVqbCn5LtudRRrUGJgYjTNvySSYorzPC+SsFsnE/G91Qd9hem0soXQZwcMPAuVaRgeqLlwzcNTgRnlBXtHPWDGMvVAFtqDBqckQGYW6VrDtmvCL2IGA8eHZUMSlyhE/Me9fr3coFimRdG4t4Dkut6WlATFlDdqvGMo5dcM9RYe6mOthZ6kcXtAY5KKlrOZ2G/IH6fKEiO0QZJWH20yNV7us56GlQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 03:48:47.9058 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d149d3c-db0f-44d3-6b9b-08debd3530ac
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF33BCDABBB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDAzMyBTYWx0ZWRfX4ZGnJ6A9F4Hd
 as/yzXdKKMxZL2Ggjaue72Wtr8eZ1VraIiuxtOIPAvU+w7NH0b6HOvn52kHdU9jeA3lBLbTDv+U
 yAsm4sy2j8iW5OLw5TbpVHn3zWCsNisnRX6iJsZFsILkqf1X9Idil3rK37ibp3t2QXovlCCFyCh
 pJoNqW1eSpUMoux8r0pQIJ6m5IJEZuq4Y88U84NR7+BWyx5neT93o7tGseUTiGAqYuG/xMfbi9w
 gpOhcojpfAEJfmfTzH6pj3XfzzXaNUDuLuwMxead6+T1whTNGvAWil1I5WVLKObguKfxW6nU1kl
 Dx6IEVHpramHeaQxxOi3YH38mXtu+k81bGefYo9oPQAhopNntio1jm6xEJmHZ3U/zQ72o6IxkHs
 XIE+GUy9UDa5Mgx6Beq1n24xjLt4ElOK3LAGgYoCr5J5pmsIW5FMy9NfYSBISUByFkTkV2vD9Ab
 NVN4LZMw7fWlhxj5PHA==
X-Authority-Analysis: v=2.4 cv=VJHtWdPX c=1 sm=1 tr=0 ts=6a190ca4 cx=c_pps
 a=fkezOHFRVmK1Ww34+/XMiQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=cDgjz93Zxb66Xb_dg04A:9
 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-GUID: Z3rMeqhm-S5kcVcuo3iEjaFv1U67G3OR
X-Proofpoint-ORIG-GUID: Z3rMeqhm-S5kcVcuo3iEjaFv1U67G3OR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290033
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

This series introduces convenience functionality for prototype boards
where reset is not fully working - for example, where only warm reset is
functional, but cold reset must still be enabled for the production
variant.

Patch 1 allows per-board default reset override.
Patch 2 adds `reset -c` support to explicitly trigger cold reset.
Patch 3 adds reset type printout on the console.
Patch 4 introduces a small fixup for the x86 reset driver.
Patch 5 updates documentation for reset command.
Patch 6 updates reset command tests.

Denis Mukhin (6):
  reset: Allow per-board reset type
  reset: Add explicit cold reset support
  reset: Print reset type on diagnostic console
  reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
  docs: reset: document cold reset option
  tests: reset: add cold/warm reset types

 cmd/boot.c                         |  3 +-
 doc/usage/cmd/reset.rst            |  8 +++++
 drivers/sysreset/Kconfig           | 31 ++++++++++++++++++
 drivers/sysreset/sysreset-uclass.c | 50 +++++++++++++++++++++++++++---
 drivers/sysreset/sysreset_x86.c    |  5 +--
 test/py/tests/test_reset.py        |  8 ++---
 6 files changed, 94 insertions(+), 11 deletions(-)

-- 
2.54.0


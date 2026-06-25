Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45204CDB47F
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 06:00:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A2528460E;
	Thu, 25 Jun 2026 08:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="a9+mn8NC";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ZQFQqKWK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0046684704; Thu, 25 Jun 2026 08:00:29 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAA3D80287
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 08:00:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65P3dxYH1958001;
 Thu, 25 Jun 2026 01:00:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=FD8i4ceWU6XH+u9fDtnu//kTYZWS0N+erdmCbj6NM
 To=; b=a9+mn8NCFFtkUIKoglh6NA89L6IT9FQ6etMR1rGqfylxG2CEkVg7+kbeQ
 pYdLxCNINOoPdnRHGbIxMbsojkBLRFs5QUIyYkYVSS1N/S5/iT2I7ngzoUY+CNYy
 5xbecBbg/WiHS8l0Nl1C5KL0fi0OJUYIqEyMkVWU+3INPpgW9UEVkMBHBK7XtJS2
 VHHnXw++jP0RKFiTgFwMWfNAhh5lCI7RNM84YlfhhUMzYAW1299YpYhpVLlke3Xm
 zfPNFTJO6XFzsJbMaQHfQ7zvRbeFS5P8goBKVHeyRuv9XVb8rVRITjfLekMDmUtX
 wJu7orLh+uqTPFX6ytJ/mhpKaKgyQ==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010033.outbound.protection.outlook.com [52.101.201.33])
 by m0380145.ppops.net (PPS) with ESMTPS id 4f0e5ye2a0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 01:00:17 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsxpkNXlh6+tC4XdlO76B1Zn9VrRRXtSO+ZAJASD89jFO1kWX08Gulj65pcJcizHb9agbmOy8VlzUlUesWxIZRxuSrji+Z7EJo6gJBlcY02gqtOja3x5xHYlbp5ZY9tFAp9aCnbxflK2r0/gHqgQfKFJmkq6R5M1qYlmKrBqCBq48bVlryqivduQdEKMc3bJesor9anrKvh2lGEwpkJCFVwTRikaCKP7zX5pPEw17x5jKbalmwnYXWdr8TJznPv4otwjff1fJgmP1FpskVwug/h7Q68MGTdiSFxAeIbhb81vu8UoZkRgKcLNwsNLp1pt9VMYmEM4HE3TLZYU/fAMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FD8i4ceWU6XH+u9fDtnu//kTYZWS0N+erdmCbj6NMTo=;
 b=uinAb4lxnHpKmx8bEqHMuIBX2vOfF/7ugDuUU5qeUKCf0X6Q933qOu7EEsxxsegjXazer0zOokIuRwmP1qBdLxu51xhVNz8KvpdIkTnoDF3R9peVDNpOzSLhi7lMI3sfks+kfNadZY8Vvp82ZN/774fDXloxYx0g2xgQxvV+jHqclaQ8Xk6F51lX+FCzGLCEHIfjIYEAxNzDrZz1o93avmueBaaJbkwQC5Nd3ioIIy51IXkxRXwM1ANB/jWxNAUyqYSGO8trLlGu3WVDMBndHbwq0O7TVUemcwu54lHPelNripmC4FZFOlky+7PrOIl4YgM4ai4uNHcksduiTUBmqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FD8i4ceWU6XH+u9fDtnu//kTYZWS0N+erdmCbj6NMTo=;
 b=ZQFQqKWK0vlZg8Q5hUVOZTcNFe5ISw9wwKC3yAU4RSxSHhAk97SiQ1uaBh9Pu81l6EKfQmBjmP/SL+AG36JM0I+7nT+t7GRPEuhMkQUsWA3QWIT6s/FIhT+mCgulJ1bOFQzRvbouT3Nf0mn4UAx+o63SUT9E+QIOfZKJQtA99gg=
Received: from PH7PR17CA0049.namprd17.prod.outlook.com (2603:10b6:510:325::26)
 by IA4PR10MB8446.namprd10.prod.outlook.com (2603:10b6:208:566::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 06:00:12 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:510:325:cafe::4b) by PH7PR17CA0049.outlook.office365.com
 (2603:10b6:510:325::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 06:00:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 06:00:10 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 00:59:56 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 00:59:56 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 25 Jun 2026 00:59:56 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65P5xtnt2650538;
 Thu, 25 Jun 2026 00:59:56 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] arm: k3: select tifsstub via
 board_fit_config_name_match
From: Anshul Dalal <anshuld@ti.com>
To: Aristo Chen <aristo.chen@canonical.com>
CC: <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Sparsh Kumar <sparsh-kumar@ti.com>, Anshul Dalal
 <anshuld@ti.com>, Suhaas Joshi <s-joshi@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Dhruva Gole <d-gole@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Aniket Limaye <a-limaye@ti.com>, "Devarsh
 Thakkar" <devarsht@ti.com>, Chintan Vankar <c-vankar@ti.com>, Udit Kumar
 <u-kumar1@ti.com>, Peng Fan <peng.fan@nxp.com>, Sam Protsenko
 <semen.protsenko@linaro.org>, Vishal Mahaveer <vishalm@ti.com>, "Alexander
 Sverdlin" <alexander.sverdlin@siemens.com>, Andreas Dannenberg
 <dannenberg@ti.com>, "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>,
 Yao Zi <me@ziyao.cc>
In-Reply-To: <20260623141540.618272-2-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
 <20260623141540.618272-1-aristo.chen@canonical.com>
 <20260623141540.618272-2-aristo.chen@canonical.com>
Date: Thu, 25 Jun 2026 11:29:53 +0530
Message-ID: <178236719345.116382.11990025652000068953.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782367194; l=652;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=muVMJou56eGhowkTNAg1URbYQGNeyCnR9BgPGJm5CbA=;
 b=FO0a+C4aWBmc45BQjrKgAXR9WYLfT6+6kWzhLLOOU7o8pA8XX1STFHtJqzYyPLUxqqQHEggbF
 uDYSZafiMUSBivhDweP+XiqLf06NmPMFv3YoZNlMoiFZdUtrhXh7iXZ
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA4PR10MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: d68ababc-0036-4b0a-2d9d-08ded27f0419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|56012099006|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: aEaDHbMQwlm2O1hxt6b8IEiDwU6YcFLiq6gIdgFxDnxRPMulWd4lvi4s8ny7nvwEm+wLjIe65uD66aTnJSqLp/M2Eavr9BAy+7OpRzRj8loYy+7cA8OpDp3pzXokxwVUWY+tWGRIQJb+Gqb6k4lQsK69xRXJsI49knXidE9z2rf2AcrUTY2rneVyMV4barHzRY1EZZVUQuy8bz1Rcb++J0Neo/KtHe6F8HfRvPY9vTTKua5Gl2USf6vYEUa/ju83UljC6j8wPY8kKL2pHafCAVnxjU+BAxs88/vCEzwosZeKYBzDmgTWt4hht/yhD3yskKNcaT6HVF2fnhLDxVBY+iAs4ZplUtnVTyJJEMeQCxh4UBu0DiMgBne8rCFm4BMAPnPqTURo9nmB7b4bwr3buLGJwxt0PBNY+UKSNQpXgBkvUqVmYNv0ySHJVX/VfquuEJcsfkUSyz3/0dNAse+tzeDLWl3UWXz1RqZwjYHjJ13zNWuO8/CnKtD8zEA3Gr+zyu+hsnt/BNbI1HTgEfD0cGSPce3ko2SYvQiuZtrtwRUb+aN33tHOgfQw/vNnVHutm1sTXAt9naVfNxXRuQ68kkKZJqf7yKy2XKleLP3WKxuynmlEs+zAmOr57E6uWq60c0mbWBI171nPdznCnJgt4L52xYirqH/2zZAgP9G2uAlyieJpiVwohaeF+Mvvkcc7KUWhXi/z1N2cUdSLccXdPA==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(56012099006)(4143699003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Z4QKO/UaimTQJJEtzLynS34fnp7EJeXac5PveT9ebxUb3XjJAS3jOK/UWscxvmUgme3hOAvpXrHl4ZNbyEn2JwpqJXknuI8QNbiPeJjpGTg6Wl0xipQG0Ij51azVDnoTpNmNaMPEKTk2WhytbEQjxqgn7TmXmxzbPkK8i9yu4UxMeiMpwv24dr6FGOvRj7QWUzO1ypQ/3uoclnbOPwKMrP+Er16yYjx/xPB5HryS1meudvLbhShBf1AdsqyHc0by+d7Y1J7FbhtGFzn5dNhIWXankKogesIgJhn1O4t3oIWq9T5iuFYT1jT6ws1hcXM2rm2R9CtX2/FuoYaMU25Hp2l7bfKVHZoK61pnGpLF4lk9Lt6Z69qomaaZUIoxzTktt7JwINWX4+Y86r35dB3PLNN0DumW1RWS9O+cKd6yiN7jez55t3c8sb3lgjgu1glK
X-Exchange-RoutingPolicyChecked: cknjMQx534EorDKXGfJeRPZ7erao4akvLsaXYXveyX49Popoqy+Rrw7mBkJFljrbWqtA4DHS+P2HZlywzR3cYXvP3aID6yZs3t1m5cJ9ThYb/jNDlqMa9q9FTaCjEqnxPxCkVynz5Tpusv2KTg+O026Z6qkp9pPTnfUG2P3AtxdccJYZKSMLi44JJMIoYR07XzZPOdOtAIdM0TbJsyVmsDfhn5eHDfoyYD8Nx6DcfBzWoAvsEgFZkPSl/1mXjB8ouP9srChlPoQKjJvK2uWI89dIY0U9lcZCZPHlQNuJn/9YgCEYAnad3XZSorE+bu5ACsyNhdN1TWJdOr0rfmTQcw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 06:00:10.3852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d68ababc-0036-4b0a-2d9d-08ded27f0419
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8446
X-Authority-Analysis: v=2.4 cv=R6cz39RX c=1 sm=1 tr=0 ts=6a3cc3f1 cx=c_pps
 a=EZwmcie8zcfNvCQIxZ7BwQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=DfNHnWVPAAAA:8 a=sozttTNsAAAA:8
 a=6xG64V90VE9-Fy8W5c4A:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-ORIG-GUID: tlZgyXiPfggXvV83NXAlKJ6ZQ3aNxj4t
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA1MCBTYWx0ZWRfXy494FUuHfvQW
 h9X9TdIP+OewGDAYBYnvC7iTJn7Q4fSOZv8QOgW3bQOM2+oR6euuHoHFUREuXgUrrIwfRbeo/cl
 wxyVLz8tv+AEAVzpNlYAKipaQXHpBPo=
X-Proofpoint-GUID: tlZgyXiPfggXvV83NXAlKJ6ZQ3aNxj4t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA1MCBTYWx0ZWRfX0czp9zefKYKT
 PkXVaMrWjckmbpEqlwvQ1nHwDS7S3vqYmdFJGBw9+j9yCEQg90v6UtXio6jdVQsJXJIcUx3FSSe
 a+GiIvp7m/HHwRT9lYnKPckbfq9SGnRD14YIhTjq0nIPHyZIrGy42JUQVDvbZGbmMF65aTT3PPh
 pKPMREAegW02ON06j512Pu+n+WFNNBTO8OJaU2q15DsoxbV9Ddrai6qJooMXT4PSPgM6PbZntox
 SbAbh5su202ckcJ3pXXjgLfOfX6VISaohdKGBr/GoyAYrJ0ntxoV/dcNuOe93BnMS5QiDqxQRMB
 ztCarmikkq6ZSkQXWelCQVXwEztve/PyQLM02snUJMkSmyJ/LPbbbO2UvTsmsrjKnwgehvR0Ycj
 5eBAcTWkeg6E+LmT+R89AKmP8X8x84pXlDpy96c6hEhCO6H/fINS24SuRjGSspJbtLU3Z+hGPOi
 JWCz3jzzED42bPXtmjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250050
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

On Tue, 23 Jun 2026 14:15:15 +0000, Aristo Chen <aristo.chen@canonical.com> wrote:
> TI K3 AM62x/AM62Ax/AM62Px boards carry two or three mutually-exclusive
> tifsstub variants in their tispl.bin FIT images, all at the same load
> address. The existing approach loads every variant and then discards
> the wrong ones at runtime via a *p_size = 0 hack in
> board_fit_image_post_process(). Switch to selecting the appropriate
> FIT configuration up front via board_fit_config_name_match() so only
> the correct tifsstub is loaded in the first place.
> 
> [...]

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>

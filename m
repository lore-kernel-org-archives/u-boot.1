Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59379C4451C
	for <u-boot@archiver.kernel.org>; Sat, 18 Jul 2026 15:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42FEE847AF;
	Sat, 18 Jul 2026 17:03:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nVlAevNW";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ITEPY4tw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1392180398; Sat, 18 Jul 2026 01:23:59 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39E3883314
 for <u-boot@lists.denx.de>; Sat, 18 Jul 2026 01:23:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HNG8Fc3731311; Fri, 17 Jul 2026 18:23:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=X8/RliubH5aInu3ytR0ECGMek6ri/wDbcJf6DEZVk
 Qc=; b=nVlAevNW2+HpG26q8BBjYwSbTV2MfeemjdMwoBCOMuxiaZM0oiUlRO81c
 HtO0fRNOngwYllSNMoOqenV/BxwZGxx5tQ346ZpecaVZRnSPBvIR+RPMvPkkspOi
 KB+tBCpd0QhiJn+EUvgndj2aafoNh+j5T25V0pB1KOQ//i5VlzUqHp0O8KBstD4b
 r5dT0knbCKnCi+JI+QnAnruB8r03L8ccRgO2vlfo1eTgVOBp1a2ridRPY5s8NuLe
 /JVlxPHvPLyuxuFW9OppuPrfYaA1gmkcogAS6eMDiDVY1LXMIn1eMEtgkLU5V8vn
 36BEb7MUOH97clAmOrvlqMC5BABeQ==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4ffkc3m349-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 17 Jul 2026 18:23:39 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+CZZen4KZ2DXePztYRoZI24XYL6VWQnNLK7tkASkh8sAZQGRYvMuk9s8dIamfWjSArlvAw8qU9EL5AUDVFIYfEX7F+yLsbTLpubpiyMhV4pYczA7UnlwPaoexU1pibQrXGYCWKP5klSez5d8A7BSWMt9x6kpOGea2f2TM3EPwLwdfLmBVhtDHvO55qLEpNR225YKrd0hQTHrMAn++aIeY7a7dYDiG4FushcF32ODwW8LegOp1gKD9IA/lvtxRnoehJUJmkJXQTRvobH2IgrcC406rdhLr/OxiI2YbpMZrWMBpInARJVGVYmpEuyZFijw8LRfkVpjODcHd/lt7Bztw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8/RliubH5aInu3ytR0ECGMek6ri/wDbcJf6DEZVkQc=;
 b=wbtllEQVF1SQCxBxZx3l3Zhf1BlwGZxRzScIj2kbS8ejtDCqOeMEeDvWaVJGzqF8mN91HiPw6ft/41Jg38iU1jBOj2GydAu2FpkTMIoPKaar7E76e8uGxRA/Sb7HyDWAg2m3tHuF9IRC3OGelpkv++tgEZ+z5ltwFhTQcpK79E0d7DdnqH3WiyKpq6LCaJJnViOcwE9eJF07tO7O7aeAKEJJhuGJKXUz1fIbISDn8ofg2T/YGk4psTMO+yUKR5BgmqXbZkx3EKnk/sm7PLbFLgU5h3MrPzzR6/kiMFAvtWRj0R3tMC46R3ieCCE3yzcQU0hs4Ijtr+Y/qXP15ilQWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8/RliubH5aInu3ytR0ECGMek6ri/wDbcJf6DEZVkQc=;
 b=ITEPY4twin5VS4gSaF6v8PHa5+W2ZBhHf0wOqXLgcz8GD8GrcFUCvyot3uHJBgkKLOHzKoxjQ8Nh85ir0iaGM04RIH3oqmcKr+xFg+fsG40tEz7mtDcI4CD00kesCRKKHCfKqzHfqeyUC/cT1bZXpNdrY275+xqUSSZpdQEKCuw=
Received: from DS7PR03CA0002.namprd03.prod.outlook.com (2603:10b6:5:3b8::7) by
 DS0PR10MB997600.namprd10.prod.outlook.com (2603:10b6:8:314::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.10; Fri, 17 Jul 2026 23:23:37 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::ac) by DS7PR03CA0002.outlook.office365.com
 (2603:10b6:5:3b8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.13 via Frontend Transport; Fri,
 17 Jul 2026 23:23:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Fri, 17 Jul 2026 23:23:36 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 17 Jul
 2026 18:23:33 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Fri, 17 Jul 2026 18:23:33 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66HNNX8C150102;
 Fri, 17 Jul 2026 18:23:33 -0500
From: Bryan Brattlof <bb@ti.com>
Date: Fri, 17 Jul 2026 18:23:33 -0500
Subject: [PATCH 03/11] soc: add data to identify the am62lx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260717-am62lx-v1-3-b9830633afb8@ti.com>
References: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
In-Reply-To: <20260717-am62lx-v1-0-b9830633afb8@ti.com>
To: <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>, Anshul Dalal <anshuld@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Andrew Davis <afd@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, "Kory Maincent
 (TI.com)" <kory.maincent@bootlin.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Daniel Golle <daniel@makrotopia.org>, "Rasmus
 Villemoes" <rv@rasmusvillemoes.dk>, Vignesh Raghavendra <vigneshr@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Dhruva Gole <d-gole@ti.com>,
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Paresh Bhagat <p-bhagat@ti.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 George McCollister <george.mccollister@konsulko.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 "Swamil Jain" <s-jain1@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, "Aristo Chen" <aristo.chen@canonical.com>,
 Johan Jonker <jbx6244@gmail.com>, "Apurva Nandan" <a-nandan@ti.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>, Hrushikesh Salunke
 <h-salunke@ti.com>, Bryan Brattlof <bb@ti.com>
X-Mailer: b4 0.16-dev-d5d98
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|DS0PR10MB997600:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c1ee364-998d-4f90-3952-08dee45a6d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: dcyguRrP0OjNgpwVIF1IfzWMljPoFoLD9K4zaVSKtSctAv5afgIIPo4kn+Rg7gO3jc+WXDw159BPTjyGq9BFbqdn/9bjWVxgMJZkJnD2lJrj6srVrqWaW9DmlTK3ckU/62wotv/10eeaGZIyT5oX89mkzx2KqOsRL2lNS82vjm+YR7JN0oFreLJ3MZQgdAPXWWou37IumhQezhJvM4/kdgABzI4HjRjX4xCSEnaUOetw175jAVndvmyp0WpYPnWH1YOogKBgVSYS3VD4O4Ti5i2qLba/P/H01h6FPxpwiB4Ztrq80PyeYe/9WJR1l0/if2HmbYazfVlUepN5/9mY96a5LYIwIS0ZT9+oqf6vGbRbgl8Wspz8Wu+94w/C7b8V056pxm0thMY7ueoS+uX6GSGkhHSfHmNhfpWV6/xPx6Vyv05YdpYDVi3FDrfpg6sPncHgHWpyW5ovtLVRFFw/SdVzl5e+TsyUkjKtLZQCx8BZDDdETHiZjns4QSr4GJOygPpv83yUxv32qlogoPIeSSmDrRd8KALVTYQVYx4CkizfHhjawDLFV1sBVzxVERureSsU+gxJw5RLSAQuYKXwA0wE9dI5gAANr8K5hmL+NXXQj/5l+p48MVSy60rlPomVVcvoimr/7CWnkTe14Q5a7aPRchWzvVWbop5RkbyN3SgYElpEDWJwTzBljVklHRfuWb2cjHSDMQo7rKmRFwr2bg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zk4qzBk2tvTDL4ioD91KN5oWBA/jdSxVKvfo0DuhoiVJpTADfuJa9cckPMRhrZEmGmPSV30EUzfKaI3l3UaFKvZ8Z7NIJiKrWyBAsScxmay7WgpTFc5Q5YbO+tXMOjYdl1B6BcPHvV5ap0j2yT1oSrcFUWHL+fS409hp2zY4MTwG6+sFKHKpqL9AZIS5THR+MoS195ujHUq6HB/l5KNqCKFIeXhu8BLyyRByXLtDIJ0V7j0MxPGWVdqg9dPCQbZpvJW12JWDWgchQ2jfTyeLucbqLegvrxKHOgoFz6cOOMjxi3CNvg+36jMDkozn4ytlUzaKCy6gu7VYyqG6H7GYT4Ok+8LYygVWsU9MPj+JhAaSyFApjrcVwIM32jvqISFfOURNYwm0i2/V28uWDFlAR2ZOo1WFmAyzkwhDKt97oAcYYqJKOYfxWsI9h2myO3w4
X-Exchange-RoutingPolicyChecked: ARh0ku6h814SdrsHW44MVZf1ZVr9UlmSPloFQFLeczSuMcpkq9esUg2y2RBmAJoteCFp6Y/2Bh1se2wIoNDvVcQ9nWnbTeorcM17XKtWWqi/KaFDbLVVFbfxUSCIKlCcU8q+uX8Uklw6fvLi+6oZmflSokdJewRH6PJxlU6oWtDXzmUwxRg0RSXeQbaO3PAdpsxLPO5Z9j0FF6yCXVOp7l4Iz9eiGq+NkYAkYTJt4zG9nfNEKgFz2ra+/oPlJ33xGao9mF9+ADXYmRKQRESh4qwqPSzi4S7t1zLnrV+j6Dasp08u0QlFEhlQdKb2t4agPJIfibe0rK1VOPUXiYBajw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 23:23:36.5099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c1ee364-998d-4f90-3952-08dee45a6d5b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB997600
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfX4evuQYwHCUw4
 Ni+UXy5bubOLpcPsZqeeoHxtp3nVswLq/aNqmLntFK46mZYjiYZJgdqBUsMewLbphX+IVFhJPX5
 e6DgVePBf7y7v7QKBHlOlzhuUauQw60=
X-Proofpoint-GUID: FMv3_m0b5zjEIE14xOTSCJeowrGaKWrJ
X-Authority-Analysis: v=2.4 cv=M7F97Sws c=1 sm=1 tr=0 ts=6a5ab97b cx=c_pps
 a=gX+0JOXwNCEsWCXnQOdOsg==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=CgQoTPMYTAfA8Ut1j2AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FMv3_m0b5zjEIE14xOTSCJeowrGaKWrJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDI0MSBTYWx0ZWRfXyKQEzYA9xuOn
 7dZZ59qHL0rmyEQyynOU1itziW52aut7CARbW68xCRH0bwlfp1VJULDAbgImYzg8pwZcaYSjIxI
 GD0/bxzrMjc7HPUoZWH9YjsQXQ9z8KMtxhIb5Ey+q84CzldNf/d0M1+L53WmE3B1aFzaZ9m0kw0
 vaYaTceM+e2vQ3MSvOUy+UiqYxZ1vbevlZ9XfkljKIPPqc3X9mQli5RRfHnIHP+MY1YhR6ALQQY
 olIlShPVhdlrBQi7RUYzCS1W4pqYCOLThicA9PfvljtVUZQgfVC9iWLN8pal4NiboBjm5qTwlUR
 ZEPEv2IxWfAhhGvyGOWK7hd4EzSTmumCFTdZZQyNnaVyQRk18F4zauj0tCLuQwKrWmNRGjy3hl7
 3yNqiHnMEmkBjVl+eCB+mNuoK81F10xR5wSmZhYbDp85m/5kYimpJ7pZtlzFbsQ9/5xzSL66XrA
 sAcApqyb3mYWmQMbHJA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_07,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170241
X-Mailman-Approved-At: Sat, 18 Jul 2026 17:03:16 +0200
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

include the part number for TI's am62lx family of SoCs so we can
properly identify it during boot

Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 arch/arm/mach-k3/include/mach/hardware.h |  2 ++
 drivers/soc/soc_ti_k3.c                  | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/arm/mach-k3/include/mach/hardware.h b/arch/arm/mach-k3/include/mach/hardware.h
index 2c771a1195f5..6b86f6ed12e6 100644
--- a/arch/arm/mach-k3/include/mach/hardware.h
+++ b/arch/arm/mach-k3/include/mach/hardware.h
@@ -56,6 +56,7 @@
 #define JTAG_ID_PARTNO_SHIFT	12
 #define JTAG_ID_PARTNO_MASK	(0xffff << 12)
 #define JTAG_ID_PARTNO_AM62AX   0xbb8d
+#define JTAG_ID_PARTNO_AM62LX	0xbba7
 #define JTAG_ID_PARTNO_AM62PX	0xbb9d
 #define JTAG_ID_PARTNO_AM62X	0xbb7e
 #define JTAG_ID_PARTNO_AM64X	0xbb38
@@ -81,6 +82,7 @@ static inline bool soc_is_##id(void) \
 }
 K3_SOC_ID(am62x, AM62X)
 K3_SOC_ID(am62ax, AM62AX)
+K3_SOC_ID(am62lx, AM62LX)
 K3_SOC_ID(am62px, AM62PX)
 K3_SOC_ID(am64x, AM64X)
 K3_SOC_ID(am65x, AM65X)
diff --git a/drivers/soc/soc_ti_k3.c b/drivers/soc/soc_ti_k3.c
index b34cbd08e073..6ffd88f22c09 100644
--- a/drivers/soc/soc_ti_k3.c
+++ b/drivers/soc/soc_ti_k3.c
@@ -36,6 +36,9 @@ static const char *get_family_string(u32 idreg)
 	case JTAG_ID_PARTNO_AM62PX:
 		family = "AM62PX";
 		break;
+	case JTAG_ID_PARTNO_AM62LX:
+		family = "AM62LX";
+		break;
 	case JTAG_ID_PARTNO_AM64X:
 		family = "AM64X";
 		break;
@@ -72,6 +75,10 @@ static const char *get_family_string(u32 idreg)
 	return family;
 }
 
+static char *am62lx_rev_string_map[] = {
+	"1.0", "1.1",
+};
+
 static char *j721e_rev_string_map[] = {
 	"1.0", "1.1", "2.0",
 };
@@ -89,6 +96,10 @@ static const char *get_rev_string(u32 idreg)
 	soc = (idreg & JTAG_ID_PARTNO_MASK) >> JTAG_ID_PARTNO_SHIFT;
 
 	switch (soc) {
+	case JTAG_ID_PARTNO_AM62LX:
+		if (rev >= ARRAY_SIZE(am62lx_rev_string_map))
+			goto bail;
+		return am62lx_rev_string_map[rev];
 	case JTAG_ID_PARTNO_J721E:
 		if (rev >= ARRAY_SIZE(j721e_rev_string_map))
 			goto bail;

-- 
2.54.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31365C44501
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 10:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82E4284A51;
	Thu,  9 Jul 2026 12:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lPFKgWL7";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="N445tR6b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9471884ADD; Thu,  9 Jul 2026 12:17:26 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93AD684994
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 12:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=c-vankar@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6699GQFC642769; Thu, 9 Jul 2026 05:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=3XUk0/3rRn9iRNq54F8vEH6oKxGWUj7UAoBFPiciW
 oc=; b=lPFKgWL723nTqm8wV4qqoZuVr8UItdQDUC+WqRQHwzhEdsE/5ESaYYux3
 HHqDNVjpu6sucN3a3wXhdAhrgPHP4NT/+ohWaqrObib7BRRec8z7Jb9rJa0yD+39
 A9PBAgrMNEjHLb4CS4DYfOTvmOWdMekG53T9hMIooAR32ClUEQt21/DMNoe5+5PE
 QCQ8lFoBp5llT7nD9T23FTCbQcHbpNdsnqhHC5J5nDUfY0QAGh9uOEFbv6yx0tQh
 vGY3GwfYejc/G8dnaeLHypKGodsKpoYKqiq9B/5JWw813KRz0iwFiukmH8CR5HmN
 opOrrprUgRMVSteoyF7eyVhM0QYkA==
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010047.outbound.protection.outlook.com
 [52.101.193.47])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fa8v9r9x2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 05:17:20 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqqKTpG0/qXjVT76/BDLN/L7ptcbRw4xnUuQPa8ScykS55tECDXxbgtYGi2mw5ZHgCDRIgbD5fctosGeH+/TyzldPAaOz5WwSqaGKvgltb/TtZQJcuAecRVoXjlxrXosEXDfs9qksog6gk/MqQapW5MZCE+ylic8UwqSPJiI5/cBaGj58D3qXTC5mpmb8d/CJ1u8F9Fx2W24GjflbzgU4FR03kaDaO9pm3laRzEXQW2+0XRc78Y21PPLZoxm5qUh8/s09XLlhWx/VN50XXolOaV6oVZNxYP/b64ax1ZMObfFV5MlKSUNq4j3uKzNAhCsIqvEf1QuzjcSFLB/HmGYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3XUk0/3rRn9iRNq54F8vEH6oKxGWUj7UAoBFPiciWoc=;
 b=wmlpBeoQgLpBGIsmigmeg+SMgj0ud6IOCnWcC9kjdmo95WryVXg8SEVLTsDAnVo2ZH5MPmF/8jxnk96DThUQJCypmcPpfM/XVgLWlqDc4qoWBR+3d1+KVz3KfO+EQSsF6UBONaHAhBON3MTgHaD5vLiKbEHTTttgPHOAlopKxuNH7hXgXj3cYZ9CshArSG1Hhq1Oq9hmH7uwKewoBm8HHV/FkBk4T0DFzkb7N3unL6JiXYxpLYw0utGxoQegpWwQHubv+aFhnUZNAAOBPqkBzYZ6sJ0XqNKKPPjbUKK9NFPYt/zS/oi7UrK3b3sycplOo9OU5cC4+HjsPShzIDElFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3XUk0/3rRn9iRNq54F8vEH6oKxGWUj7UAoBFPiciWoc=;
 b=N445tR6brIKWZoruuyGmQJw7CAyE2MyslQfznDwZiIKQN+4m4S/2PvinHi7reP8mcmZ4B1WOt3wwZyjkphuodi3PK1fXKBx/Yo3RQ/HjZOyTpKKvOVAiDprHMWoQKolVjGUm3qGUa0c0Om8y7NnzyQc4QMdjq0Dnw+2ujtfMTUo=
Received: from BN0PR04CA0074.namprd04.prod.outlook.com (2603:10b6:408:ea::19)
 by IA6PR10MB997560.namprd10.prod.outlook.com (2603:10b6:208:5e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 10:17:18 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::42) by BN0PR04CA0074.outlook.office365.com
 (2603:10b6:408:ea::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 10:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 10:17:18 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 05:17:16 -0500
Received: from DLEE212.ent.ti.com (157.170.170.114) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 9 Jul
 2026 05:17:16 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 9 Jul 2026 05:17:16 -0500
Received: from [172.24.231.164] (chintan-thinkstation-p360-tower.dhcp.ti.com
 [172.24.231.164])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 669AHDx0401511;
 Thu, 9 Jul 2026 05:17:14 -0500
Message-ID: <1c0c513f-a8ce-4ddd-9af4-b79cdd31b89b@ti.com>
Date: Thu, 9 Jul 2026 15:47:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] configs: am62ax_evm_a53_ethboot: Enable config
 options required to enable Ethernet boot
To: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Tom Rini
 <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>
CC: <u-boot@lists.denx.de>
References: <20260702081251.2691159-1-c-vankar@ti.com>
 <20260702081251.2691159-3-c-vankar@ti.com>
Content-Language: en-US
From: Chintan Vankar <c-vankar@ti.com>
In-Reply-To: <20260702081251.2691159-3-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|IA6PR10MB997560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1545eae7-33bd-4693-4047-08dedda341b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|18002099003|22082099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: o6OefjePoKUg7sLISrE/ctJr4vX1MFOu33+gOrEEH+vTw8Oq13xqYi/2OuqPcquwycFD8SjD45Xvg0G5GVhT+qg2o9H/NrT30N/ApV5w21PVTGuKSf9Tte9rQcPWbm3VGzRyx1/kPaguB4f3MHldHU9frDiqHplRN/H39bv6dffO3FbqC8IAip/8iM4qGioajpJFvwcna6tR8ZCc6ps3tbLrqtjpEuIhj6QUPXARzqxHznzLGQtLbCXmiCYypH8kvKf5IjRAyG7zKLkbT8Vm7ITq3mK3P87xIRTKDRj5GDkxjrh2bOCn4pNaiYl3JTCq9a6bzdHAUfLrty9mtKaIOox1fWVfqpx1dRskTE/XrhdWmPOoq/CRrI67o0AolM5yYfyRITbuc5MaRCXlIGXAdXchxSva5WhKdUxFGSi2INijDqbu2dfDFrygA7X61SkTUYOr3AifAjtHHP16e8IYOID11nvW40Xdi8GHfSHz9CaRxZa3agBMKRB1+KPCFPm5HeBocdqM2/fZrQSutQm44pkrj35DWMhn+pShi1JYHOFSGIGNSst4UUSepnyfUDckqzwTdzGRXvyEZZdnUGA2WYpVifrr7hR8DFLNYgevJZIjgQHmS+T3nYa9tX0bsCtbrGqgH/K8cd9dUn/EHQpfWt534fgMNj3dKqbk5TCLQSJHmHqwiTRDsa7TAL2EHrxY3A5cxGvKQruMSUAr0eYExw==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3XVwHqn5cWAQ43RNaVoQSH3f5xBieIfRXlvZanvL1qhrtEwUmi+mXKkK2XGWKLgWTlG6B0eN7BYNEC+ctvwciIhepYQssuRg9ii8uZMmleLXBUzVQl4zNYxrxNc6ebOhDwlJ8d5Qhz0kVsxqF1opudKK08nAcp3BSysa7qAbVTJRL3SHOWkNpXjg2TBC+5OmBQL5rHVmTKy/VkslYGZ4ZqzK2hlbQ3qiUEwaAYVjay74Cy9GU9/qUwMRPMRqsPtn5rpvytHiQi0T+mlhSIWZXl9nAoqOjLy5815iTFiDrBGXNaTNU2uPfiZwBrkhSGBpxutgYj+e5oYX29/T6rlkw4I38O0bi3gIVQXeD1Jb3PD6q3LABGiEHbk4VDPO3EWjCHV26Brv9MzwYxtEsjZh5Y33ox0+edrZReY5ytwQn4yIJa141SMfT58icCJfzqgR
X-Exchange-RoutingPolicyChecked: rBE3WJypRIcSPsKqVbkSV3oK/8J8pS+98j62DJS9pTnX8RM3Dz5qVTSs7QQVoG/4c/Sufk3oE/VnAXnzoHlh69EsdiqcLVzFT4m8gO9TK9iDlcJhkRnh8xLrTzypOg2+dDauSC0DDB8LHoBUnIcRRN5Pgm9pZTcucE8Vn10fMSvg3H9bSGfaPkjPFkqItBNXTzF5nog89nT7n/g2c1JK04S8kB8gE0oCUPKRNaWEkcwhwSZjBOLA+yotAM3APKUx7D80fnaoJqk6xO2C5DIacPvYsol8/HlQJmc6LwMeu9KpAdljhJJ+1nD87iQrDTjj3muykeN1utg5JFLhW5zWtA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 10:17:18.3975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1545eae7-33bd-4693-4047-08dedda341b8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997560
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfX1JONtETnJs4w
 bmSE97yyGetpGfF3ZqDvGsbyyXHaH1aAw/4CDrmJ7jBcM8F+MjS40tT6RITITXueWZjYFdr+NAK
 Efhqvzxp1NSVYi33/laTwxmoDikGqU1zGs6n+3SgocrasT52AuSd++0SMCIKbAd6/lOI8qaywfA
 hnfkUl2FRTmvNaph7GpeG9Sd5BtI+MT2uThMZTcPQBYkCAnEpEO3N0kwJlNY0cMrqLtnI1RoOQs
 D+e2iuPeUmRH078vA6NBV+lJ/N0+DbQbsuQM4xHEZ14myMmqXW5fn9QQd/RBeiFOr0DMQ0P1ozA
 KpR6aZ7SDzO0NEutDC137L+0nXKzGPmOSJt5Ec5U7mMgyQwHf+52zW0HHNPZVyYO6m0GYFa3VBS
 6G0RwTcutUC4gxULdzjgnfCDJTxoUJk9hHeEBoj8PhoqDW0fsT5zyyDWBISmowxetZGqpPvZ+UA
 yp/7axMqHZo80xmpbcw==
X-Proofpoint-ORIG-GUID: 3TdPbj4eV0lE2CK5Vg_4kh9NfVyRH1Mj
X-Proofpoint-GUID: 3TdPbj4eV0lE2CK5Vg_4kh9NfVyRH1Mj
X-Authority-Analysis: v=2.4 cv=SNVykuvH c=1 sm=1 tr=0 ts=6a4f7530 cx=c_pps
 a=vP0OKLXe+mBq485nSWAwQg==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=nNkGm8gUE1MmL8Ipz_MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA5OSBTYWx0ZWRfX4SI92vRvvl4L
 /07zenmnourz+uAUSftBiiYSpQjS/BpOPGgnS8Ag6mdVGFfQocL26U6OfC8aQSOLLb7JgK22hcT
 DDWZYKdWUbuuEDSv/w0YU1zWgp6CXfo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
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

Hello Andrew, Vignesh,

Let me know if I can enable config options required for A53 stage in the
base file since A53 SPL size is more than R5 SPL stage.

Regards,
Chintan.

On 02/07/26 13:42, Chintan Vankar wrote:
> Enable config options required to enable Ethernet boot on SK-AM62A-LP.
> 
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
> ---
>   configs/am62ax_evm_a53_ethboot_defconfig | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>   create mode 100644 configs/am62ax_evm_a53_ethboot_defconfig
> 
> diff --git a/configs/am62ax_evm_a53_ethboot_defconfig b/configs/am62ax_evm_a53_ethboot_defconfig
> new file mode 100644
> index 00000000000..a64542315fe
> --- /dev/null
> +++ b/configs/am62ax_evm_a53_ethboot_defconfig
> @@ -0,0 +1,16 @@
> +#include <configs/am62ax_evm_a53_defconfig>
> +
> +CONFIG_ARM=y
> +CONFIG_ARCH_K3=y
> +CONFIG_SOC_K3_AM62A7=y
> +CONFIG_TARGET_AM62A7_A53_EVM=y
> +CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am62a7-sk"
> +CONFIG_SPL_STACK_R_ADDR=0x82000000
> +CONFIG_SPL_DRIVERS_MISC=y
> +CONFIG_SPL_BOARD_INIT=y
> +CONFIG_SPL_DMA=y
> +CONFIG_SPL_ENV_SUPPORT=y
> +CONFIG_SPL_ETH=y
> +CONFIG_SPL_NET=y
> +CONFIG_SPL_NET_VCI_STRING="AM62AX U-Boot A53 SPL"
> +CONFIG_SPL_SYSCON=y


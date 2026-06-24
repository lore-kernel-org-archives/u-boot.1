Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7B0CDE000
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 23:30:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3376C8460E;
	Thu, 25 Jun 2026 01:30:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Nm8j+nnV";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fNQOBkn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEE3084704; Thu, 25 Jun 2026 01:30:05 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECD1380287
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 01:30:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OJsOiq1271525; Wed, 24 Jun 2026 18:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=bT1+dSjw1kYCy6dmRRdvtFzZU+4epfZDiuS9898Q5
 I4=; b=Nm8j+nnVtFuguKuwP6bT73xTDJ0J/FOObGBqT+j2THT1gR2aXL1NqtvaV
 n1qZY3vKI7E0ylDfPC0MQIqrM+ez1llBd1ly5+oacW0OrD9x6HgwYWELpfWl7Zs3
 xUQsy0L7EtdB9UdY7Xa7L15tRrhr8O5xkRVmZdHyhYCa0Sm4z74CYXWC8fot1oz0
 eiprpEBTA1ggbJQDXkUfhajaxZYcRdGfgMhKRW9NvOTsCDpwyLeW+BbZMeEcFYXg
 ohgs/pTIcCq4vQ8O8PoY73P8VZQbGu3PcAVbMQBWTekoLQP5wNqsP49Fiuf9lcj+
 IdC1SZsLvVrZRwHZHseEX8ezwJ8mA==
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010005.outbound.protection.outlook.com
 [40.93.198.5])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f0e5m49hs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 24 Jun 2026 18:29:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STD9BWHlaz5MNCI9zNv0bRZDsr8FNmuA6k9Yy3Xp4xLbqUFKUIowBNa/Whd/Mzfjng3vmtlrguew6iyjabPZIy4Mi0WqO6kjXovRb8qqNlf06uZsk5Hd1SIMj1HbA8WfANKyaSmbkUdHxqC5pt8jC9BVsXRdhdB4VbXZgeOIqV/WIDPteZlnN+U7B1iqhRcikpATdtlJhyYUNmRHrWpFIJzuC4JFXxlcnndFcdd2LJGMndd+LfP0y9KnvJqhIRRCrm4qBrT6xd3E2ZYaMLfPWiUewZcAlRT+gp/e4I/hH1oaczkuLd9ISBHBhR6A5grXMYion4KY/SP502SePxZLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bT1+dSjw1kYCy6dmRRdvtFzZU+4epfZDiuS9898Q5I4=;
 b=JRzjrNT8gXXX2ZaudZuZJPhsEI4N9zOlAtF6Ev0UXjWiGlEXt4Ayx1U/p6FNAU7zQDOiODHc0nSzn34X8o3iyy8iGlLh5CfOjJxeyXdCdLtUl2JRGagBYMhoNr4BdECV6Kq/KB5/myAGX1Mh4g6+XOBfqSCYwBEOyNLA7JlkUhDAUuyfTk6YmgDlsV1Z0Tx+9XzLCQy9LCCxzqAMK6s7e/M2APofsD2zRC5aczMOF9vL+cK+aDrRSGajA/lz+iWhzu5ZPzg+/SHBQXq6TYHZt+XSTiKnXZqsPlsZPYhYQ0cudqjZcQ7hiBOAo6QJJpH3nYvbZwQ/P0SLzeOh2odVOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bT1+dSjw1kYCy6dmRRdvtFzZU+4epfZDiuS9898Q5I4=;
 b=fNQOBkn8/NXnhdNqUyiat++h6uk+MwDzKbkTHYhuixNAZ/73nky7uzE3zgEdc7yINk+yMoDwz86wv6OSZ+CA6CTBgyiIUKWC7qJ4kU625FGMtdJPgtvNALNd+rd++2VShTdZ1a3RJqu2L3+x2zCWAlLW9BtWjTZR/EqGfmU+bUw=
Received: from CH0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:610:77::35)
 by LV0PR10MB997684.namprd10.prod.outlook.com (2603:10b6:408:33f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Wed, 24 Jun
 2026 23:29:50 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::9c) by CH0PR04CA0060.outlook.office365.com
 (2603:10b6:610:77::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.13 via Frontend Transport; Wed,
 24 Jun 2026 23:29:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 24 Jun 2026 23:29:49 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 18:29:48 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 18:29:47 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 18:29:47 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65ONTlpB1454000;
 Wed, 24 Jun 2026 18:29:47 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Jun 2026 18:29:47 -0500
Message-ID: <DJHO54H0KY54.3SIYX4G0BFWCL@ti.com>
Subject: Re: [PATCHv3 3/4] k3-am62-pocketbeagle2: add support for 1GB variant
From: Randolph Sapp <rs@ti.com>
To: <rs@ti.com>, <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260624211949.327905-1-rs@ti.com>
 <20260624211949.327905-4-rs@ti.com>
In-Reply-To: <20260624211949.327905-4-rs@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|LV0PR10MB997684:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5ab7f9-e5ea-4ac0-5837-08ded2487bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|921020|6133799003|4143699003|56012099006|18002099003|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info: IOHBh1M9xT0HeqARa4z3fV1c1sdni7hJkPREdi1g97JVXM9AJde1QNVi2pAoRrL4sCtNndCMObyP1S566SSWbPXgAGsgVxVsaIWDtR5Vnlu8+sFiR/Elok59UbHChv8DxT4l5GJOqfAE0ypmL1ZknnOMj6zPJxfk3Ob6e708wamXf4oaO1hpocPdGqK8kIz8mJMPNbKbhUl2Jm0xB20j3RURqmCD9BjBuhAYLp2AfRh6sr3V4G3aUFC96C3wB9+ZbJ4n6NO2JnQkJdA0a4zkNu4+N20MuuAEZADPgdpVFUVJNFG1FHGfvlQXGAitz96fZ9dKFbccpZeOTV9fZi/QBTcuWvZ2VwH9JC/VZ+TnAWm8xwwOF2+zEBWstYOmXwCKSqAzbC4ZgEDrSuJEgkgtAACO9ma2QBJjjJvHJV7o8Fe+7NDcrENPeuaCcbLgieDSv91OVPEKIADbTb75DAHaO/jb1KwvdVTZIVWn6owNEgCe2f/T3DtI+emPUiM/OWV0vmGhCDb7I+plH5qLdHRMtlfN7r+ehs3SS+2tmYcCp7dih7ne4bABrV6LgPk4KhDUsQ9tHi0wD5bBqpQZImrmusM7fJU+abfBqeu1k4fY9oPnObq8xNtHsUWGoCwHTWEqT6B+fFXgEuXi4RwQAEheF8JmO4Th1wLGIqg0DQx77R2fq18/UqV3ouKWGovRHgaYETTFzLLaU8YlrArHWbtw/g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(921020)(6133799003)(4143699003)(56012099006)(18002099003)(13003099007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4jjUA80y4H8Dra6d5yXFWYFnM2k3600EF7lCGPwwdBz1yvUgqriXsaF+NbjeODDtbgvrBNYAIei2ZMUH4RqCtvBl7Xzv+IABdnn/m9/6hyzgffCciXbzBCOKX+peBJPe950MGGEnq/8yX7dAOA2Du+2BGUj37YUSJdbFkNz0+X1fPNwBQqZv/Ui6ja/Md0NEMhdWhzac4GADfutOy/NY0afJXmBfeCcdWn4fMDXJQWntT7ChNxAIza5gQUUH+KUWlY4SKjpwfV/tKfWp4odMXSbjpTrbDjDR8WAjBhSxp7m1xQWjeNJgtwPBSI/Igdp5mTqA0z6YRmDpWwn2zYiuJfBm1tTG51r/zv1/erI0c3laz7Puvc9+1hp3suThH53ogqixV+O44rHmVyXUGgxVFFfVWlMudsCr8r53RYdhp/Fjhar9S1Inb0reWXeq0XLJ
X-Exchange-RoutingPolicyChecked: D/Z+2l+6Z9KTnGzcJLk6kbWqHzqsrGRU3pyLivxvQtL4V+p8gUzOvoF1l5l8OIIt5Mv95r1/54EWT5iJGtfzXzzuJ3QOS9Cey20flLG8P8QW8MBInDellWtU1+osDZGNI2zXzEldqrRZl1TdzeQp3akAu/58U9/y8ZBNQAgA4HGiSvVmidP9PtUEXiE04KC6qVRcB6pPv0k5Y57KtTR0qQFgQ54DJYsu9h7uVbU45hmQSLds24Ao8gk41FMKc8NT5AAyrpDh3EEQPUO3UPZgQxY3jESZZiTBUJsKbOT+r2wgquxJWzGuGABhvFsi4I8uMsho0WgqHP4j7uzTeNI5GA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 23:29:49.1516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5ab7f9-e5ea-4ac0-5837-08ded2487bf7
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR10MB997684
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a3c6872 cx=c_pps
 a=bt8r0o3PvT4lvF5YbTRm1A==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=lLZmtIKjAAAA:8 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8
 a=gTV8AD8VYnOeZog60_MA:9 a=QEXdDO2ut3YA:10 a=q5Nj8NTjyn2D8kUwajRn:22
X-Proofpoint-GUID: jbfUX_Mr_c50oTNQR3Vq9z5Tezs6oncS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE5NyBTYWx0ZWRfX1+VMV97BrAEr
 gZgt8/9oeqhRUbfXYCWSZpOBoTS52yun/ld6c9U5SKM+MOmo302rhZXgTV121H7nPs8L3f2ewEm
 n6R1SCzkdHF2xc7Vmq0dayFCuqRN9KP9rFTKzURDLhcJC6gKFyCy1IO1QdV6kzs92yaBv6gHkaf
 a+5SniaP+HwgOjNgxJdzr9N7ueXuID9MggKiPsLq12I/6jZuLR2elD0Ik/MJxEHm/2qVmFrpkOe
 99QyiFGUk8/LCJ8bflOreGW1yZhTbINnVMLF7cz487QaKH6xWLH8l6BSJIeL9vDfq90KCyC0Amu
 6W6VCz2aP/Rx93eUmLPtn0yVcZeRfQotL9pE32qryS8lX/R9QiO1jp3+ojObv7niZOCrT7WJgtH
 WarsJxpQ1KEkpDnvdUTJzx6KGRa+uhKhgm35w5hI5x5MWy72C8L5/r1V8gOnALJ4cE/5w6r+SPB
 LnY2eefDDOKXXcohn2A==
X-Proofpoint-ORIG-GUID: jbfUX_Mr_c50oTNQR3Vq9z5Tezs6oncS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE5NyBTYWx0ZWRfX7J5/egSWww/M
 ST6Be6Mdno1NTPC2kQDmSu+FCCx9gDeTA3Toge4zylJHKOLal5WvXfGQV16KlEJa/YR9qvvTR2b
 IcujCKqyXTFkSXCorOxYWjcbFrQkU4U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_04,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240197
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

On Wed Jun 24, 2026 at 4:19 PM CDT, rs wrote:
> From: Randolph Sapp <rs@ti.com>
>
> Take Phytec's current DDR fixup functions and utilize them to
> dynamically adjust for variants in the pocketbeagle2. There are
> currently 3 skews, two of which are both 512MB with the same memory
> configuration, and one which is 1GB using the same CWL and CL settings
> but a modified density [1].
>
> Based off of Bryan Brattlof's patch [2].
>
> [1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8G%=
20Bits%20DDR4%20SDRAM.pdf
> [2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e990d=
7a33fd001ffb571e13cfc3
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  board/beagle/pocketbeagle2/Kconfig            |  26 +++++
>  board/beagle/pocketbeagle2/Makefile           |   2 +
>  board/beagle/pocketbeagle2/pocketbeagle2.c    | 103 +++++++++++++++++-
>  .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++++++++
>  configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
>  5 files changed, 184 insertions(+), 2 deletions(-)
>  create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
>
> [snip]

Just thinking out loud here, but maybe we shouldn't take this patch. The
industrial version, on top of having more memory, also has eMMC. That alrea=
dy
mandates a new device tree and configuration if people are going to use it =
as a
boot method.

Then again, maybe it's convenient for the users who don't care about eMMC? =
I
dunno. Seems odd either way.

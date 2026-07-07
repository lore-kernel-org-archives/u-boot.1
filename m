Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D0EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 11:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA9678494B;
	Tue,  7 Jul 2026 13:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R7aEVXh3";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lsLUFz4K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48C5E846B4; Tue,  7 Jul 2026 13:19:44 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB4B84852
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 13:19:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 667BCWlD2614521;
 Tue, 7 Jul 2026 06:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=LprSxx6Ec748YtBwFhSta9/27fS3zwtnHjEAU2g/Z
 D8=; b=R7aEVXh3JUqMCd+jtB7rv4DFjZBw2zAC5szcm6XRFyHunrd0l5lW5cWnz
 /Li3Ado5oOGbVY3DHP9ZjbZBO9yqAUvvsbQn8tejNDv91B1U02n3l4vuC/bW2KQP
 EF7CUoPqWWlXCGAkBLo1wuVK1gjdmdUiLuGl8l1HDRMn/nk8YdowJ+0cfI5LpNVx
 KqrxLk+344bjfOjy/gL1hCf6B8fowlWH73SSaOmmMTbpSP5wIeNrm9oL3SWlegf4
 vggEwBMBWfMWgOycvNpGvEMTVn2MpNb5az+VDdVo/Nvd+SXdKxpbldFxE8aU+I0q
 5YdsbGW7dSoSdf/MB7CIT0wmH0pGg==
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
 by m0384305.ppops.net (PPS) with ESMTPS id 4f90cn00xa-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 06:19:30 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yo1QUyi/NtyFM7mwPMimBK5CoNxzfC2ZtkYR91iJVSC82fQ3dCreeAA4XgIKwcLoicMgQJrhkZ5d25AIhAjUlECT28dfAhp26xProGhL1kampF8ZF1f/4xiVa6CjvjF4Badr+Fbbf15VA/LFVOZgPr9NPEFCgypbXdidGrS7RtBMCw5nKGl5FZhXJ2Fm1kWQ+0tdwwgofpldacnjhI9DymODc6pnhkoweXgmeAJzI3a5ybI3a3FQWjQEC49SpHlekedZtei/dlFdAp+0Mdut4lahQoJVQAQCxZmN53DGY6dbRx+tk95mku1G763EBvDn7/25cDD+563bMgEsDxJ8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LprSxx6Ec748YtBwFhSta9/27fS3zwtnHjEAU2g/ZD8=;
 b=fkUWYBqRZVDRM1lRMGqQIxu9VrOO+ZCc+ll26/QXDCiem/gXCwt3+jM30WuqyGxPOACdDCAIrrhU4Y7dv4XFJQQj0O23yEIi2mRMyZ16LZjefrHvG3djCCA40JQcSYHtqq2oJ0LJU5edxBrnBzKBK9hNmfewSSysc1wYrkI21TZSZMcx4QmHuj1CEBsbPVan21Cra/EnaM5QJyNz7J/sWE2MjtLjQzcv5R2TFCdTrdO/q68Zv3HkH/Um58bEFQ++JIcQWRaWSnBRDPrrjHJiXD2PuqDYxyhc+wIYOGGf8uJpOHhepqiASwcJ9pPRHms3v+mWFX2cFlwZq1WjPrgmyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=etu.esisar.grenoble-inp.fr
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LprSxx6Ec748YtBwFhSta9/27fS3zwtnHjEAU2g/ZD8=;
 b=lsLUFz4K1AxXbun799S3tLubFkFd5xYc3hKRhXn1A1rAQ1bPBE81mhazuC3khO2EGxlmw8kCL4KCxcLXOqm5ZN8SHIL4SZP1YG92g2lhh0QE62ZiodJcH9ORe14zIl9Wxd0V9U4hcO+8JnCy4hdRuyobjrVO3Mkol7FrjwEAp6k=
Received: from IA4P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::13)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Tue, 7 Jul
 2026 11:19:27 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::40) by IA4P221CA0010.outlook.office365.com
 (2603:10b6:208:559::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Tue, 7
 Jul 2026 11:19:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 7 Jul 2026 11:19:26 +0000
Received: from DLEE200.ent.ti.com (157.170.170.75) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 06:19:22 -0500
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE200.ent.ti.com
 (157.170.170.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 7 Jul
 2026 06:19:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 7 Jul 2026 06:19:21 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 667BJJpn092347;
 Tue, 7 Jul 2026 06:19:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] ti_pwm: Add EHRPWM TBCLK clock driver
From: Neha Malcom Francis <n-francis@ti.com>
To: <theodore.oviguian@etu.esisar.grenoble-inp.fr>
CC: <u-boot@lists.denx.de>, Theodore Oviguian <theodore.oviguian@se.com>, "Tom
 Rini" <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, "Neha Malcom
 Francis" <n-francis@ti.com>
In-Reply-To: <20260706083507.18386-2-theodore.oviguian@etu.esisar.grenoble-inp.fr>
References: <20260706083507.18386-1-theodore.oviguian@etu.esisar.grenoble-inp.fr>
 <20260706083507.18386-2-theodore.oviguian@etu.esisar.grenoble-inp.fr>
Date: Tue, 7 Jul 2026 16:49:16 +0530
Message-ID: <178342315666.657164.747217452413984923.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783423159; l=871;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=gHkLj8Vc41xa2sZDY1Qk9493aao9IzYA6umwVcK/6xg=;
 b=tIKoD3MY/XW20isMHldc7QQ9Q2MvScBVNTJot4gkRxCX6huD0kkF5I/xVVj7iOnKAR95YgCZp
 dtIjtn0tAGKA81/efeesCyqObP2FLkI2+epZPL5r1KjjT4IKKpoAJKy
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cb7b35-4b05-4daf-11a2-08dedc199ae8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|13003099007|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: A9uz9oZ6KdXYvxxWkGauGFHaeuk8IgOW6JHDYPh/mMbiIRH7vHZRUmevBdfRUX4lz7gVd63jNtunGGH5K5Qm0On8HLk0o06C46vj/Sh5SEJRYOszmlbT3TYYJtRkjch2w+GKzHqZ8ViHPleMOpzwZ27GcHvWPlnKyJ38Iy2I0D4QwYCsoDb/wdFtv/Lujd6lOxKGy5Lork3Oi743YypNOwNx7qbR2c8U2BavTGLwp+FtGuxwpdCbf2wjkLJEnhNM00m772gNgivmCRillmsQh7jBkehwUe3ZUdGjxxv/h22l/yj2PRvZTtWFVFABr1VoW4DTU4jaMTlQPknmWxddYuVN7VRRH2QR0Qf4lWpHeHHm+NA5d3sfOAXBizh7JHU7+BECx/KCYUWO6dgNw9ZDRzKNVetvnUHzkUk+/SmeVTlT9vbwba/aFhgACPBk2j9L9IbvwzvR/RnTgCS3qKOuFNmjLb+APRHDNQkWn8QqQYYkDqEQ0Rc6peZ4VK2pgeQhSKhybAi/IxVreOk39Ko9D116y1m+/yqvOkC4+TwVCUpqHII+XVde2gP4LVCNfIPYPaqGQh/gvw/yZxQqJLqFLhji7gjBypqt4dhTXzk5pe3rbGOf4yoeeKBfEir+y8/fDdFFOPslixin8UGLHqE9VQ==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(13003099007)(22082099003)(18002099003)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WXyfbb8Z/cZHKa3U3KIazsLE5KbcXI1fRYvSd9MEzVk1odDGCoL9jwaOa3vBR8TusrUpVaPitkA3oV8bg6B8QFVcEU1WziNBDq/1Dnw8OoL2wBsGLpHgcuJOdfB4XURX0w2Witd6G5XaSP6XRP/wZ6tg18t+9Ru4+SNMGvipK5yswgMFeMjiVKu2BXjaVYlDQMNNfdzzyFiog1NCAb9+dD93UzJ/7ajPKGaxIE64mJHiQ0/0x7QDE3rMLkxp80xNAustLHpaeqVVmxve8UgfMFrgCTTVopLsCsK6zd2ruhqPnYndVcVBVqRvjgGeRZj3sZNGrhDuE8+FpDrRyjqOPdgU3VbIJkOOG4qjpmjRgC5kUzlL8JshtZPLujSy8IjmEbNwf+jrgOVnZIuu0ik2dsJccw8fI/ZwVUiXzXLexpQsltJ6fGyLfob0fqW+xIQc
X-Exchange-RoutingPolicyChecked: bzfhJIgMPsi3YQLyR9NOXU/WvWVKUWQFUQ2OpVyll85jg2sCU3BGwIY43ttINXwHI+CfOYX/I7L3ZNjeIMqUEFE227CIYQdT6lgJE7u29S+mJbVXhBeSgVRNxIMX1T90bS0WHgst4/L70zerqUTIhzw5BNPjfLOPE3dWWxLIHwlHHZIcw+olI3438LOXrUZ6O9bjUDA531VSzmjFmhfxgNwlFeR1e0y9QKjbNambOMwM2ZO5wgdgQ9a+15wWjUjo1ruZrC4J27Eop+8LgxUWoU3MGqhvvZlyk52FlndDjAidde0dom4lcebN0tF/ziioAdoRj9II50wGpAAX9WLnBw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 11:19:26.3236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cb7b35-4b05-4daf-11a2-08dedc199ae8
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-GUID: qjYiPqIM-9LCQNkiTqIfGbWMf8e8LUVr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwOCBTYWx0ZWRfX6yDO9UwZfvC2
 zyR22tsvv+Bo3hkQ1WrD1JoI0IJewacnYb9GC3Z3TjPAK7xwlppaMXQr04u2vZ2yzlTcBOAavF2
 qPip7d1umzN8cLkPr3XtdGAZ1KJkNEBRnhXNqyoqe4YCQzeWR26Z2I+T8Hbg4EpSwmj9PcWnHUX
 UgKTI7aOGRl2CgoaBNGP/7GKHNHWo1m/RSZT1i0+V7dR9lDI/kXNZRBElj2Eag5NzgghrJBdkUz
 c1KM4cc+Eafqtme9RWLap48NLFy2qiFNTylPe5C6lKN+krRCnde67tOiYSKGqQx59mdmHAySxhZ
 3+2BYeKOhfS+X0v6QZmbjirrC1LdIDvU9k9tqqiCdKWBN9GHj2nz4GWcNbZRHvSE0eaPJhw5dAV
 QYeoRo7lPgSgZdCIgbhHxUKDhVRbPTIlRndPZD0BsDAceEHhs9FMslCsGY5uSu/mAW+6uBLz91D
 DTlzPaIFlkNPLc6Dz8A==
X-Authority-Analysis: v=2.4 cv=R5gz39RX c=1 sm=1 tr=0 ts=6a4ce0c2 cx=c_pps
 a=EbvyHBp0GqBzY/XWR/wUiw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=UaCSvCwVAAAA:8
 a=sozttTNsAAAA:8 a=ebJ3Pv7BPUCYAjfYkDgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=G716TjlRC271eIfUcke4:22
X-Proofpoint-ORIG-GUID: qjYiPqIM-9LCQNkiTqIfGbWMf8e8LUVr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwOCBTYWx0ZWRfXxplQ/2jzwdz2
 Kz8SITbStuo42SvN+q5ei+ZhbX3wMQnHOqxZCaFiGODQDta2XBPpK714z7Hf9AJmfs1ycovamXN
 PCyy8Sa50hODXdSs32h2sZMf7+XhIIc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070108
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

On Mon, 06 Jul 2026 08:35:00 +0000, theodore.oviguian@etu.esisar.grenoble-inp.fr <theodore.oviguian@etu.esisar.grenoble-inp.fr> wrote:
> diff --git a/drivers/clk/ti/ehrpwm-tbclk.c b/drivers/clk/ti/ehrpwm-tbclk.c
> new file mode 100644
> index 00000000000..d03c009027a
> --- /dev/null
> +++ b/drivers/clk/ti/ehrpwm-tbclk.c
> @@ -0,0 +1,66 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + *
> + * Copyright (C) 2026 Schneider Electric - https://se.com
> + *	Théodore Oviguian <theodore.oviguian@se.com>
> + */
> +#include <clk-uclass.h>
> +#include <dm.h>
> +#include <asm/io.h>
> +#include <stdint.h>

stdint.h is not needed

> [ ... skip 25 lines ... ]
> +static ulong ehrpwm_tbclk_get_rate(struct clk *clk)
> +{
> +	return 0;
> +}
> +
> +static struct clk_ops ehrpwm_tbclk_ops = {

const?

-- 
Neha Malcom Francis <n-francis@ti.com>

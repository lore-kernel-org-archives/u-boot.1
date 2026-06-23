Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1911ACD98F0
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 04:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E851849EB;
	Tue, 23 Jun 2026 06:59:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qVpR5iY1";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="im4XKPKY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C24D6849D2; Tue, 23 Jun 2026 06:59:09 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF4D849E5
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 06:59:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N0hjNG068200;
 Mon, 22 Jun 2026 23:59:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=2baRoOPVT6MKDGLI3IgyKGFn/k2rx9i4hgAyY4Sfr
 0c=; b=qVpR5iY136TRi+uI+XbmqR/Ef4bVY0OzTss47SDPS62owsMAVXB2cyRvk
 wULm3GmOsiva0S6V9khpzLD1L1UNUKecVLImtUIC/VFr/bzMhwAr7tnkW8p8qZFN
 KZ1fZ35LanvHv/MpzRWtLcTRQo/IuJ1SHDL0hNt50c7Z/DZ2WhVhCJN7hxqDneM9
 pywmmISsTsNnLNCti+BLobE7B6aO/o0MLMBwo5FJgd+gEJboNmkVJbSSt9vLwF5S
 Xt4u8ZmCEID+8mVj4RUeBmjrYUGBEOvjW+I9/6JfL/5EOgPggJOQV84yOLF5EUsY
 8XlJK1QLCCBK6+ztJnzLnfhZrladA==
Received: from ph7pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ey04eehd4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 22 Jun 2026 23:59:04 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTx6P06hk1sMlJC7J6wTUN+2oi81bMswkdmzSHAhuIEUrc7pKQcCf6k57G+CrhOJUnvt7u6x0I6JeJlbGYGmy8TTgK8+gKGmkKcE+znefud+I7QlmdoWm1mgkCN4Cc7ku7Q2kq4t8YVmr55DMb30VqQIJvaEzKP3heV19uCrDGxbY/oWGcsde3YehWYuOulZPL9VjhcMWeCMDkxTaxZVBxq0Ow3lFc0fTSbJoRu2JRY+EFoWesoZV5XubaSKYIxqlB4iHbh3P+9OCxc2JkFm8/iwGJyT6HLQGtrIMrOzIyVNTdyaUhGBiyD0tfNz9GxyLZLpqNf1Lf1p41Vv+Zw3qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2baRoOPVT6MKDGLI3IgyKGFn/k2rx9i4hgAyY4Sfr0c=;
 b=VOtC2mZgS1UhBfZqCOn+MioSoKPQPxhfu2Spwt5MDIEv1iXqM5Gp2Jp+M1izsMSNhTT5M4vxx1OFe+9zZWn0vyt9kMVZcxQm24HSXuhFh6zvz4Yw4wQxWLJQLq+lXDYMUXe9doZ9lGIxAEX8sfkQ9kby2RYCRVqOUjGH75ayOuXFa26y5P94la2eFtRJrxLlJZliVsD35vGIVQs0rzkvp+tKdBR48KWEez635vOUS0LOgkJuaZmG077Ku5QclR1CE7/i7hf2WE98IxTHdXzWND4yJPlJgoZody+2/tSTvyb4tqLvDtEL0b1MdwPnwcVqyoedjvjhDWL4oP42T685PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2baRoOPVT6MKDGLI3IgyKGFn/k2rx9i4hgAyY4Sfr0c=;
 b=im4XKPKYsuvmJ7IDa8Ol+5TZdZ62SuRiGTAtzdAvDHkoW2f1xrlg4Gw9nbNj07BSNvs2bf9v6LQQDPu/HHFn8KpS2WgOFVt1zCo7oiJhEGyF3FJsQix6lsdWJlOpC2jxC4iIqaci9pLfBPH4LpEklVQmfiozsUa+EnozziCSKbU=
Received: from SA1PR03CA0001.namprd03.prod.outlook.com (2603:10b6:806:2d3::12)
 by DS7PR10MB7348.namprd10.prod.outlook.com (2603:10b6:8:eb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 04:59:02 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:2d3:cafe::77) by SA1PR03CA0001.outlook.office365.com
 (2603:10b6:806:2d3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Tue,
 23 Jun 2026 04:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 04:59:00 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:59 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 22 Jun
 2026 23:58:58 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 22 Jun 2026 23:58:58 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N4wvUR1490834;
 Mon, 22 Jun 2026 23:58:58 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/4] arm: mack-k3: Kconfig: Add DM firmware reserved
 memory configs
From: Anshul Dalal <anshuld@ti.com>
To: Paresh Bhagat <p-bhagat@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>, <praneeth@ti.com>,
 <vigneshr@ti.com>, <bb@ti.com>, <b-liu@ti.com>, <afd@ti.com>,
 <anshuld@ti.com>
In-Reply-To: <20260609181006.460401-4-p-bhagat@ti.com>
References: <20260609181006.460401-1-p-bhagat@ti.com>
 <20260609181006.460401-4-p-bhagat@ti.com>
Date: Tue, 23 Jun 2026 10:28:49 +0530
Message-ID: <178219072992.1099376.11239988740203023626.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782190731; l=1081;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=hTLc6iFybC4ekFmQmSozQyn4fSKFZCscbqP/CtbdO6o=;
 b=3/E7VZl30RUeTdigcY2t+SxUk0AkQTs7VK4Xxh41dK84kgMSl+S/OBxphCU5EsLdibpAkjJb9
 F+DINmULgogDPgZwhIkDWvPJu0WTwDg46NE7cBSsWd1618RdULNivHr
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|DS7PR10MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: e013f86f-cddf-429e-d7ab-08ded0e423b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: PC/W8ZM54xHSiW/w20ZJaK5jhZaJDJ4sL4UlwAN0VYWDkx8EYqNr+zoOtIrBXoJWLLq4E+tj3KGcaAvcsQTiB+I0o48q9u4eHSeYroqxLS0sx8VhiqCbaRkKekwR+d3YskWK/PMSa+6Wc6YYdeXlIJJsqCnQ320+PYtQDtEG85Csewn0pi/GNCg1Wf2cFTxMO6UcSiGQJ0ezfQH54XJnUX+S94ASX2Y2+XZnp2/viGIwBbEpUVVqOZS+NdLKIdFOSNZD/KvtloDv0Pzefko20pRno8pM+1kVCcKsq4HBxxnuPxoBoc7OiTPuyU2H2YpAlVsnyOuWsDn6pfaC1DqsZPPWDG4ZnvPoku5KJQHZkMC+F7IIClQygTIBrG4+yaJc5bpgf+q2LPTyVlavhXEf7ebyw3mvOWd9d/VIKD3Vl7ZRuZWUAxcpMBFEq0LqNgQb56PrlgDiJ1IRwxL4dS3VDDLCc7oi/Njvcrv5YodmOEsYJfsk5/cBxAOAB+Zb7OLE4CkmwEfuSAauCrrRWJVjxmXQWzwwRkW6ZeTu0NB3BXMES2WzT9UP8xbPWtQ5wccFjF47FjrAsQh6VK3mM5WOCBlkNSfKq3UnGlWbRxxYVLeR1oYa9lsf/Odj9oPzZb7cDIlDIQpm6xqbxxdqxJWqf1rT0YZqK1JaE4pOQbG7aL0Y2iuC2hu7ZoJV4dOgzIAUSg8UZsqN8wL+jbW6Sz/iLQ==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ba7tvrblapwQRi/793ICl6j4bdr/tGfDl17XIr6JMjoPCOIsue9eFLwoKEuamkFAYgd9ctHmxnc6IrAEAFYaeSC+i4HDB3aQy3u0j4hqFtbKj5dVokYDMAbhmBCws0t0nDQkzjPEtCFYA9atvYH0fCepWS03/g6hXnZbQQMwLnP7VAmQYKdN2frKqvsp+Gw5OUdMTRLBcCEfzGPB/xB7P2nzmN+eLd2PNBxsE88N6PnTf/1juW0WCSDjVYAyMFwMwJl2iIfyOH+XePEfobCW3ca8dKObCU8s9u4iKDCy0ekiIMuF6gRyiJnlOYJw46p1biV3ZWlno5YsZ9DL59U6Yz8oUa6buXHnuk6rqH+BCkx6igsTEQW0ARi+cCjKxfUayWTA6ufk1N2m2Qdy82dIgIKvyMYDEZ2GBuJFslwNjeMXObrZHtpfk2T1yZgRR23c
X-Exchange-RoutingPolicyChecked: R/ytEBoXIcW7MnynUG9oYDvoStU2fd+wB+xO82ou+GRvgeKr6XjKfm1xy0hMsuURQfLHzbe95ief2wIQ6UDP+jZEryJIjxuUTVbwDex82TUf6ZjOzMisjGWjvuC4mYd3aY1Fe2ygdZ+RgvnhWskEf3S7L7sC7pQAv92X/MyTwVEBkzwD5MOFc9qKfX1DkjFc7XbxtSSyoYpnqeVKj17uZLKdFUoucbFP1K8wmkKXYUyfnDqqb9dSEChNHo0deCLgylATCHMxTi1JQ42AqIyqktaqtkQzKh76sc1QJIacRpeo4n6L47v74Wk7b2SM9+FdgfIqvXsiUHDJalRLLOWZGw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 04:59:00.2409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e013f86f-cddf-429e-d7ab-08ded0e423b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7348
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX7b0SD9f+N6Ii
 m5vkIpiQnAEcamN/Sglpz4M3ODjgPddmHEy4o8p28y8ZxASArpLzptIhJdHUGoG3uaqtk0+fwuz
 t0+Ha6xmfUKjy2A6X1a6v/SmbOicTf4=
X-Authority-Analysis: v=2.4 cv=X/Fi7mTe c=1 sm=1 tr=0 ts=6a3a1298 cx=c_pps
 a=AhJDvPO6yzy99x9PXTlr3w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=sozttTNsAAAA:8 a=GQjj790IaufkNzprCzgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDAzNyBTYWx0ZWRfX/+5ktsZKfcym
 01sI02jCbJcva5K5SJtCuB97w1j0eyqgGaphkROtfkN8KghKjAARhHq+sYrLvG2zhlvKq4Elc6H
 MgrAEGtcFrLr+jVvx8v24SYS6dxhXsQaUnWcFG/Aj/uow/RF65dgYs3uAtlxoUopnUHAzXWNeBz
 y4HrU475dn42s0/u7iXC/gNdbY6R9uPV4wAct5hFnX8wXxlbbJfKLi6XAUNLeJZb30sD/f19Ymg
 XGH1Gn7K6g21hzcRLuWWhetCdgwYgOrMIEDQuu4mSBN4msNxqQBOB4UMJnTlOMSX8KEdV2o4FTN
 a3jUVPJwcLzxqbTZ5YPZhVdBccJGs1qOhtS09ByPzRkhzyGEAD38By0fvX5UoyvqWRUrLEpt4fd
 5115V/+lwB7Q9O4/Asv70E9sGf7keqZ3snRs4C/weC+z63J/GSM/RTD78xUaBU6XMRLJnBVhVHh
 AqwYFLZ7S79XUWWQbYw==
X-Proofpoint-ORIG-GUID: ZHHaxmP-wYW3tqUtaLCylyhgzLBe69AE
X-Proofpoint-GUID: ZHHaxmP-wYW3tqUtaLCylyhgzLBe69AE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230037
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

On Tue, 09 Jun 2026 23:40:05 +0530, Paresh Bhagat <p-bhagat@ti.com> wrote:
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index a32ed3a9683..ad16de9c7bf 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -165,6 +165,22 @@ config K3_DM_FW
>  	  bootloader, it makes RM and PM services not being available
>  	  during R5 SPL execution time.
>  
> +config K3_DM_FW_RESERVED_ADDR
> +	hex "Start address of DM firmware reserved memory region"
> +	depends on SOC_K3_AM62A7

Why is this exclusive to AM62a? We could have this fixup work K3 wide with the
values defaulting to the correct one depending on the SOC similar to how we
handle the different load addresses for TFA with CONFIG_K3_ATF_LOAD_ADDR.
This would avoid the need for #ifdef in the next patch too.

   config K3_DM_FW_RESERVED_ADDR
     hex "Start address of DM firmware reserved memory region"
     default 0x9db00000 if SOC_K3_AM625
     default 0x9c900000 if SOC_K3_AM62A7
     ...

and same for the size.

-- 
Anshul Dalal <anshuld@ti.com>

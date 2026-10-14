Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777A4CC6B1D
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 10:04:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22189607CA;
	Wed, 14 Oct 2026 10:04:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1i33CiL6gYil; Wed, 14 Oct 2026 10:04:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6932D60783
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791972297;
	b=rt8KOkP1RW7+XxhcDLJIw0I6Kbplwf5xdYS+n49qjEiAZKPwHeJ3tGItS8ggJcZI3uEj
	 3TxHT5QAHTUpOK87atc6SCFMNFECVf+xyihYiN+GYVoYVMaI99xP2jvPLIhLZfyRYEJuw
	 P4RLY/H5y6tv9NxYpogCK/2U62HDMaHHRdVIPAh6kVBMmzTx/8k5gWD+dv+Tk1/4Do5Vz
	 vDfHzuMz2vQrTuRJ0p/Pk40ItNr4P/0GDPUnu0CMdeeggfdNEH2r7J1EpBKWGhU5HOC/U
	 qQFUofQWUwfhAwOiBzlOU3lEdlA6GHjnxqbo9SWeftOvI7QN76/8B6j4OkX6/gTlKbQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791972297;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=gYegfTM9BJTd4DPQDbe9SVr/JZ198kwtB8RiqDw4v9g=;
	b=pRlj3UxIMveypYJ0q1QDn6GW1npu9MwR1TN2lKEcwQWeS+V/M8R2JX1wNz1Sj7FYoUbt
	 J4M3dPH1stH/1jnHuHYMw7eMzU6fAq2W5B5wIgKXrIMVvbbJF38/v4XbUpcocr7x+DyZz
	 6ihi5zVGx6GXvEEKfp0kgH1420FwbjbHwc3yiY7K/f9rQdg3S7+9PhzTFDxKlmBmiO0tJ
	 yguCJxQIyh6jbQ+pXM4oa0pj2IKpW188pL30rn+rIvTUcLFXfq4+XUoROWeJ5xLY3674p
	 pcwH48oJdFAhamY6xGVdqyd/3far70PPuXWO8S7gVoddmjd8jYnyXgGTU9+71YS1b/A==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791972297;
	bh=gYegfTM9BJTd4DPQDbe9SVr/JZ198kwtB8RiqDw4v9g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gcK0OBABaiPmfqVGgGv8wfX1bnjnVVjdl3mFvzPohvwkA0Znhzwbx6sn4XrQA93Qr
	 4/pX6rEuyD/qxUyv+KGHNr/den+psYeBeEORFJ7l6uIf5/h1nrn76dn4JkthA4c5vV
	 w2vszXqUfPH80vGB2vJsg9FIJvcfOXFm8KfREZihgFjkizApKYjBveM1BbQn4+gyjq
	 XsdE/hyb+3SNTxELbDIAMF6GuCMMtmFBxnaL+HDPib5GuQADEwC0bJkEh6L5hcNUG0
	 rldxgrXRUZPIpIH6Lj3ZNr0iVc8ThCxW2ATM9/GOheL4fFfzyZoccNecaVCNWCX3/r
	 VlMDKpvT15S/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6932D60783;
	Wed, 14 Oct 2026 10:04:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 44D932AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:04:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 261ED406AE
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:04:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IvSPQ0e7ksuP for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 10:04:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE5B7406A3
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791972294;
 b=fmr2JuqNwIJE7J59NueCk6PH8klLkQq5Bx+Qz0HzqEzFPPm9wjhBcF81iQmIAoVREMpm
 WTbZveKDFqS2t3oLyHDRqNIfmrag4xJBhKPLRhooyv00WkLAugRAowyqSzvhKp7vRjzzu
 SfmMvpaWR+6Uy4toCcjZrpbKCKBeh6BU422cwwDKr/Ko49y8wZxunFCMYYvFCsJw/wWKd
 GFxetZQX0QkTPGI4NewPiJDfZIGiBUNjnYJhJ50FOWIZV1aa8Yi8GETVe7dF2PguT9l9M
 cytrE6koWcsHQ7fz/7ZknL1crPtSXmiVcJpYGDbKi/hlN9ubI7WP02rlcUFpsJCOuaQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791972294;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-Id:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-LD-Processed:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=gYegfTM9BJTd4DPQDbe9SVr/JZ198kwtB8RiqDw4v9g=;
 b=St6npRXKKKUZYI1+zkt4hbUGuT5Ju5Zg8lDrmMJ2uDn2JBUJHUKSwdeJ/bhPlUPSira1
 /bC8ApktPe53deSy5VX021AFKsUQdphnPhtygnKf6e1nmblOphxHBSRsz2XCB3b1UuL44
 nKdQiGp2ZyocsxxHK4JToPeXpWmycsTe8kdIhHATGBmJ6XUsYnP0kH7uFxZuOBuKjPNcX
 9NXi6FkhpHRMRC3Pc4c8a2HCH7X+ZwWkIaAzflZ3uBY/VBagnEmG3q296fOb//Ot6vSTN
 cLWvdV4Z98q3ZfzGwzWP01Yin9w4mwA3p7AWjW+176sMgJFONhyF6bvbSCcflpqBAZQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=fail header.from=oss.nxp.com;
 dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZD1olDNq;
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=ye.li@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=ZD1olDNq
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DE5B7406A3
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 10:04:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqNcoMg8KYP3DwsZPiyflRKU6fv9Ue8ZYE5Q++QgWHDojbE45b8E6Je7c764CTyFxusMA6Xm44IVB38fNhBJuM2drwS8QX6Bs5rQEvCzbQ4xSjyQ6xsuhCW7cBC3MBvNoQe1AYYC+aosbmuoMxgx/h8ppWHT5yhpgKc6t8hoKI+zvN13G9UHG8H6H4W6MjufXkIZs8foPONd16DSGKgi6js/vsqYs3/T+Q0N4pl15ifpAK0ntUxK5IgezWJBbMkhxBkGZ+nKM7zRx6YWKyIu35yAebRyzwohAfzWGoSXABmminf3TjGuV8FW9RS7GDavJkCqXtmwOfZ3LQhuyula0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYegfTM9BJTd4DPQDbe9SVr/JZ198kwtB8RiqDw4v9g=;
 b=ZGQyM6OtijD0KOPgYGrK+8yANJ0nTfVVtkEWc8sH5YlfS7Te5Y71rthQ0ojfnM2g5rxx+zVi7fGaIONN8oQj0hcWmhuID/hXtQYJz8xexJ44zGAyTaaGy4wIO+4KgMXeI7IaVphUy3s39NkDkE1soCpj9ERG6FHyM2T6NPbYCdy2OzDPPb3hf0fYFys8C/PWVGBITfwqmGoGarteTdkjRgmNbMc4JO6xOS8JAb51jYgQvJSY4cZ8bIyRVYBw5+qOZsqXx3GFn9h00A32OWbmOrCuxLI7FADvZzUNu68FgdbAHy9pXkgXx0MnKb1HX1tuu+fgwLqKuAK4LNxHr9cEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYegfTM9BJTd4DPQDbe9SVr/JZ198kwtB8RiqDw4v9g=;
 b=ZD1olDNqswYK0lTnATFGJwRSAqMv7jb6HpJmKvRmvkFX2+G9I5H6r17gajVLsgVlrOLew+hHdBkdM2ntHUcEqKtvAtbG4gWr90LQY2UtDGtvdZJFII17vFA5fP7XVpjb9gAheLuu4NaALlDWLJ1QEQo0fnPaD+Il+PuxNle1+Ef///zz99z0bG/hSOR9MO9/xdaKl9ot4SI+lzSwQc4zvFE5d20sKJlAuRyL7mDNgH6tnGk/gLgqfDZ6GYuzIKy0S4F2odmiONm86aqKaf3c89A24mX0Yvntwed21CU7pfsfGeOtKTxjJ4BEA3WD0ATtJZ1Ty4FnHG1Phoe+u6Bpiw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com (2603:10a6:208:c1::16)
 by MI9PR04MB444628.eurprd04.prod.outlook.com (2603:10a6:290:85::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 10:04:47 +0000
Received: from AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592]) by AM0PR04MB5121.eurprd04.prod.outlook.com
 ([fe80::da59:a278:1b1a:4592%3]) with mapi id 15.21.0522.012; Wed, 14 Oct 2026
 10:04:47 +0000
From: ye.li@oss.nxp.com
To: festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com,
	uboot-imx@nxp.com,
	alice.guo@nxp.com,
	ye.li@nxp.com
Subject: [PATCH v2 1/2] imx9: scmi: Move u-boot early MMU table to top 2MB of
 first 64MB DDR
Date: Wed, 14 Oct 2026 18:09:14 +0800
Message-Id: <20261014100915.3470159-1-ye.li@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5P287CA0247.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::14) To AM0PR04MB5121.eurprd04.prod.outlook.com
 (2603:10a6:208:c1::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB5121:EE_|MI9PR04MB444628:EE_
X-MS-Office365-Filtering-Correlation-Id: e79c58a9-f22b-47f9-d109-08df29da93db
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|23010399003|1800799024|376014|366016|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6QSmeN62HlwD4JzkMdcPNkrhFuDZWmJBGUzY6siUUQOfkp6lUKL5D8/cSgkCKfeI1IkzE2AaJ+2CeMP28qbc297p5aipX7MzjASeK3+0a1zlDolKAuEPc8jXrfsOlCXLFCNsS5CmShV1p8SbF1EKcbj5DCn/PWsq4K2hZlGdHRXgHiG+qQC8B+V0Cm9I9TQFyeI5bvOZRIU3f3/z4oIdDjPffyNIi/4L/M1R3sMca+FdvTawXL7HydBXHwWVwSA+CB7opcwZsnr4g/r3EUcbu7B1lDQnpdHKGAe0twhX8we0e65HFhUKNEhPpWarFfj89ER2/ryduKPqSJFGOjr2foCOpc0bIDzA9OBhKeQIIftjdTwvy6JmzLldHTvknLEmA04jHZ+JBxI7iUq5dZdPP/COBoCyIcLIqtAGfxc52kDAspgqKDuH1T+CB//Q4nb1kL61iGGwBEd9znwdH7pj0ru7sqSSUpP2/BCitOH60Y4D8WRteQFk55pNYm7NHv28rTm5x7GE/ZcNg3MzJrnjLC2R8G+/7rsmsTD78E1wy2haDtGkDW5FddlD8jRVW9cC3J8KRWXM85nHWzKWCNE4Su+EOYc4l1DfKxp48GwuYGzUUCGrGK0ebrWUcKH/wCCz1UAozwxn9iwDSs/CU94lbLACx4Wag1R7pEmw6yoJU8U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0PR04MB5121.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(23010399003)(1800799024)(376014)(366016)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oStHFCDAK9tjf5N0N2AQUHaAL7MO3fu8OIQOINAVCQagc1t3C77qZvAIytf/?=
 =?us-ascii?Q?h3JcZtyevk1goic+pLb4h4hmiZLhvCIaXC1jo6tp4lNo7b0ZH4trmuDDSO2M?=
 =?us-ascii?Q?Fc9InluWXnTtz/lIdVHY4Ehx5qAmZsBMMnbpKehfKz2Ud1yT2T4Lg7+OprJQ?=
 =?us-ascii?Q?a1cwFzBXzqwXYXHB6lFEiTE/mZDtAkc/c4EvFOay0BtNi+/+kYZny8+ezcR6?=
 =?us-ascii?Q?mmKiVOrMCkRLkz+NZqBL/frz5aYm+TtMVAXNwqowAPA6BDPbFNxbLrmxteSt?=
 =?us-ascii?Q?tgQbXqOwP5zW86hbQgDSw55oOr4Mo2aNnUzj/V2PeX+MPnW6zfFAehVeA1D+?=
 =?us-ascii?Q?u1hmMFgjWwEliNEtgg7Yz5gjc605NRTy9wlIGxQMgTBoS/UJzKerUjBdKLTi?=
 =?us-ascii?Q?sIMAPX7FWDoQFaMPO48HqLX1vGBSHOLIqrnsclChbWJnHJ5PzyHriDaaleoV?=
 =?us-ascii?Q?GwbFmf02BFaKXjuJ1SHD+DnCr6fJTF9q6cEC0ZJCFrVyLQ/9pQFD2C8w5+eK?=
 =?us-ascii?Q?wVHIBbDzD8ohEPFkc6gbLgg2b+pYDtTrrIL0X07cs5IG5/ng/zlYQEG9rdPR?=
 =?us-ascii?Q?F+aNdbacjDeNIa6O769d2XKETP6789moTc0GI5z9Uo84ZVlP9A9//aDEAjtH?=
 =?us-ascii?Q?kV/y92KPEKo3pK0y0L16LRqUM2LDwGJKf5+uKamU0nU1kFTPDonDD16/wVnE?=
 =?us-ascii?Q?gjRvnV3oykYasapZin5nbsT8at6TodAbE4lW3NoJCy6OK+p+UGTV1a4n1eC2?=
 =?us-ascii?Q?cYz9jxka9b7vn96xH+5igQXe7KRho/Np/xE8+3o5few36NqYCYAvThW1v4Nh?=
 =?us-ascii?Q?IqNKM4tGF0gJ6ooyXicm7mseInLOkHdxwm4th7kvK9viX/YOhRB5IKnDE3r4?=
 =?us-ascii?Q?Epjx1DWc22nLJ8NpgcGr8aUQrMhYmXL57x5u8HkiNTrb79o9eDPakFLV7Wgg?=
 =?us-ascii?Q?y5B543yGE31eIHJy6qjY/MbMQ9JyOJi+wHEFZuPocHVbf28OVUWzdAF754Hf?=
 =?us-ascii?Q?GWhw6shY4+BqOOmQARQB5b10VBFhMPw3ckalCAKZhTWKlvgu3o/KpbuQX38B?=
 =?us-ascii?Q?CrGfadTUzD3h77CawFiPPs5z7VY03iHcnQIUCIQM1QgBBnqunE0YYPhlBjQM?=
 =?us-ascii?Q?hDy2ddkQPr823EcBWHLgP7S2+VyEU7o6qvDmM4eMZDhGXQOlram8WaW7lSrX?=
 =?us-ascii?Q?ajsIR/MR3K+Q0I8rAAUWyyMreK2GTA8ShfvYfemGxPMsVLrXkiZf15jVODQQ?=
 =?us-ascii?Q?+rS7MVpQThU+mOmU8/vOPdcRQ67ZZJginCvXL4mEQt3E7UiMGKx7G3do8LN6?=
 =?us-ascii?Q?0qgq1Dv12KOruCrkpouLWxlNo3LFS7wYOLN2+INoBwgeSLNyX/WO4Ljn2jDv?=
 =?us-ascii?Q?Xy5i6zuWO5PPuxvLbhTk0S0/TpdGidV+X98LlbCcHfiS1AcEl9fz6UgmF0KE?=
 =?us-ascii?Q?8gjvFZYJ9CF+FB0np8T4WIEMZzTQXBU7s4rNDpJiQoNRlcjsr8bi9jVUBytv?=
 =?us-ascii?Q?9Z/hekeJgEdYGbww0F5JomAWmTa/1q3W7he316ixKwStDPAj1FBmLHlC7JNj?=
 =?us-ascii?Q?m9T5E2tQsLg+DgaebV8ZY0Z7rB4jFlJ+jnBN02iWvhYYlXf7ZwOLAL1QilZB?=
 =?us-ascii?Q?YZTBFuCag5Nh4DPCy+AA45QoqjS9QY3MrphYHZClOOZb8ZWmSgtfaYDQRe/o?=
 =?us-ascii?Q?62frKvZiFT3TssMWQXByLMr0ZgEiW4iIqmv1TLCTspvXq9YNmxBV23zUjyf/?=
 =?us-ascii?Q?eb0dWHN2sBEDhsvd5pxf4sKJnWFNudQ=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e79c58a9-f22b-47f9-d109-08df29da93db
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB5121.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:04:47.6019 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7Z4miHYJGbZU2rPrdX3NqPxLWtTqJe5fyVUeMCijfAH4E75jK4gMxpzioH6aVSlNT4QTYb1u6evPSgAMML6sDhMIubswjnpgkxaDZnWvFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI9PR04MB444628
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Ye Li <ye.li@nxp.com>

The default u-boot early MMU table address is at CFG_SYS_SDRAM_BASE.
The same address is used as alias target on Toradex's iMX95 boards in
RAM-size probe. When a probe address aliases that location, the test
temporarily overwrites an entry in the active page tables.

To avoid such overlap, move u-boot early MMU table to top 2MB of first
64MB DDR.

Signed-off-by: Ye Li <ye.li@nxp.com>
---
Changes in v2:
 - no change

 arch/arm/mach-imx/imx9/scmi/soc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 22f9c9d045b..fa6b9a0e53d 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -613,9 +613,12 @@ __weak unsigned long board_spl_mmu_tlb_base(void)
 #endif
 }
 
+/* Uboot early MMU only map first 64MB DDR before DM init.
+ * Set default early MMU table at top 2MB of first 64MB DDR
+ */
 __weak unsigned long board_early_mmu_tlb_base(void)
 {
-	return CFG_SYS_SDRAM_BASE;
+	return CFG_SYS_SDRAM_BASE + SZ_64M - SZ_2M;
 }
 
 /*
-- 
2.50.1


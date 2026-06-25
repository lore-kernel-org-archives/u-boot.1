Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D45BCDE001
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 17:49:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3497184A06;
	Thu, 25 Jun 2026 19:48:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Klr17mYi";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Rb49rVeU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 589F38495B; Thu, 25 Jun 2026 15:10:34 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DBA984949
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 15:10:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PAP8ho2988663; Thu, 25 Jun 2026 08:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=zjiIWMbGGHhhuezUH4LgrNiUR8GKLuiJaIR/rtbP8
 Q0=; b=Klr17mYi0xh+uIOH60AAiUFt6fY5ZgtfCNmyfEIilF2dz9YtDWDKIXOyX
 1xXtibntP2InM7dNDYeO+BNSH7e8vVIgq/6wTfbsfGT2PeRcWj8OEJ0+cJwmPR9v
 IhXY9PdmgNMdWtjH4YjNNspsfUhbdnBGffEgHGWEEz30jJ34/JpNru4dzXyXee4D
 Pmmbs9gOMsrnht9fHMKgeF5DlTnq/GnikVN85pIgAlIVdEdT86OsWdtG+ObI/PF0
 x+sZjM/BL+i4rSaLstRKGU+uVH+9781nGrJ/9d6eyTzYAXpvwXicPlRtNLAErdKM
 Hzw8bRlvW5xVDCx4DwSHDpHIwBjag==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f12jcgs2y-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 08:09:05 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWhfLrtp/trZ0sfbnyfncLrJG0oFdTtZdtNhSMECaOqOxfd9jgxbhtc4wNu9DRS7xfF1WQY+5V5AYb1yMRojK/wn1D+1uoyhAApi6YdJbF1gStnEBh5kZvZAUXmILy+d1flLfO1N/zbV2d4W/QkFu79GT2g5YIyX7jnS7QHu/uug1h84NOjUT/mKkYnulUZCHL74blNfCheryFIpfyKS9RXycLTkMMX7GgqqO9IOwiO28ETutZZpP0c4aH+vGZ6zVrqRxJf4MjShxS4CYvzNouFtbwM6tqkKwF0LxrhTtXEoir70KCnvYD3uhYCz5F2p5Ppti6wRNVKN3jJt4/lEOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjiIWMbGGHhhuezUH4LgrNiUR8GKLuiJaIR/rtbP8Q0=;
 b=Q5XPM++46xC63J6+HzzQLMfnmvwpyoZGMmre4+R81dc5bktebKBViYtD1jjkSOr5c8FM12qWza8IV0TruvmjOGk/tpI7vg9gH2+ojkoq3aI6pu/KYXroa7advVzWdudYUYi24vZo9KXZh//VD7mzTy1UHDAG/FFtzPnexfrZVkuNMZqFTBuZmgcXFgAM7sv+gXkBoz/GBMSByFjzJ6bHjBABIAauhrgo4J7SDvpJ7eJY147OoQzyVJmEA2Mgb77F1A22o5vI4SFIKPBZri2istSUk4pq59nB/pbOF0izBtQOhCt89bDrlG0bT1iO8glxtje9n34R06tiCHwYaXhYgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=googlemail.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjiIWMbGGHhhuezUH4LgrNiUR8GKLuiJaIR/rtbP8Q0=;
 b=Rb49rVeU/sLb0WKi/MGDDJjXEmEeDpl2SCVodebw4BU27SP3UeMADCF4cDmlxJt+dTH2CrsdDEQly432wLOscBjlzIj3DXvLWwh1D/UFRKBgfEMAXyrO3Vfxdw7TZgqQTzegv01cBfXq1sCv2bT6CZnTwm+BtTlLBgMtkCYK82A=
Received: from SJ0PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:2c0::14)
 by DS5PR10MB997706.namprd10.prod.outlook.com (2603:10b6:8:341::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Thu, 25 Jun
 2026 13:09:00 +0000
Received: from SJ1PEPF000026C8.namprd04.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::4c) by SJ0PR13CA0009.outlook.office365.com
 (2603:10b6:a03:2c0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6 via Frontend Transport; Thu, 25
 Jun 2026 13:09:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000026C8.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 13:08:58 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 08:08:54 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Thu, 25 Jun
 2026 08:08:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Thu, 25 Jun 2026 08:08:54 -0500
Received: from [10.24.68.110] (uda0492258.dhcp.ti.com [10.24.68.110])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65PD8eAG3371699;
 Thu, 25 Jun 2026 08:08:41 -0500
Message-ID: <613c20ce-42f9-4a2d-bb23-f872b37777a0@ti.com>
Date: Thu, 25 Jun 2026 18:41:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Heiko Schocher
 <hs@nabladev.com>, Dinesh <dinesh.maniyam@altera.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, Neha Malcom Francis
 <n-francis@ti.com>, Marek Vasut <marex@denx.de>, Sebastian Reichel
 <sebastian.reichel@collabora.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, Simon Glass
 <sjg@chromium.org>, Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 "Nick Hu" <nick.hu@sifive.com>, Jimmy Ho <jimmy.ho@sifive.com>,
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Peter Korsgaard <peter@korsgaard.com>, Casey Connolly
 <casey.connolly@linaro.org>,
 Justin Swartz <justin.swartz@risingedge.co.za>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>, Jonathan Stroud
 <jonathan.stroud@amd.com>, Padmarao Begari <padmarao.begari@amd.com>,
 "Mateus Lima Alves" <mateuslima.ti@gmail.com>, Jamie Gibbons
 <jamie.gibbons@microchip.com>, Daniel Palmer <daniel@thingy.jp>, "Angelo
 Dureghello" <angelo@kernel-space.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Lucien.Jheng <lucienzx159@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Beiyan Yun <root@infi.wang>, Weijie Gao
 <weijie.gao@mediatek.com>, Romain Gantois <romain.gantois@bootlin.com>,
 "Alice Guo" <alice.guo@nxp.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 "Ralph Siemsen" <ralph.siemsen@linaro.org>, Boon Khai Ng
 <boon.khai.ng@altera.com>, Shawn Lin <shawn.lin@rock-chips.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Alexey Charkov <alchark@gmail.com>, Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
To: Anshul Dalal <anshuld@ti.com>
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C8:EE_|DS5PR10MB997706:EE_
X-MS-Office365-Filtering-Correlation-Id: ab6645f5-020d-4ef7-a4fc-08ded2baeb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|23010399003|36860700016|1800799024|376014|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rNVJI6hX4BbcNwndxqkXOumXYnw1a66lnU8j42M766tDuOA/hbfCBzFQDqniXOMSYc3cndOVtJfR76/7i9/WBsnyCgFd9HwGS4Xh68CjMDcBZCPghJCL9tcHWpaMcaAXzw2R5O7d9oBijIniLwX3M0XUJ+0S3xdxh31Y3vzORnrpi0yJ5szcPNboVZQRiDqVljSOYyTkpCdWd1VfQowNWlkb3aUHYirrH/71qtGRteZ93m0DWtJe8QQs6dZ8SAFyOxWVagAfMVacek9wxBj/ZvmrG6yO4XIGOej4WnsowHtBlBw0T6xPw305s5WDVw3BOW+SGv2VAkQytPvEU5/M0sNVRFWWbNjdpAd/kaYLUz5LozVZqDza2dOKqDgqGVkPHRl8rR2cSaQ0ZIUjE65Lma/hcqo844xuQ2qW3PXYNYxnYFub/p0FTa1VR+NUQbcqFrXCu/o/X7tHhz3M1witkoxFdiiy7F07nOpjJo118R4mljl2hd2fcx9w8mQv9d6MlF1hxUADmbQE4/e6ZG1UFSR9qUOafbNwPMsHcArP+FaHEEmMglDRTYTd6Q6StIQZraw9wjfJ5yMIaWxp6dl6D0DKoO0aI8OCkD4ve7fteWRo8mY6Yf+cQygonWUTF9b6AOiQdLJ1Wv0LDllqsoWzgn2xyBCLmk1RxV0Rhu8uwvVV5b9zkqrsXnYjvjkJ4agANj52yvdqX5hGM4FL++ILgg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(23010399003)(36860700016)(1800799024)(376014)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zLM69EBYO1iRhaxFhLkkaDT4UXz+hYifn7U4JRcCM5BRnngp7a5q+qj+vh+riqOpU16+Qxw2Mh0NKo4XtrqJ/Z/vm3lpk0XXQ/l3fxtk0Uho0Sq8fG3x2Weoopp4nPGWJK9L27OkrplY9gl92uOQt4IbtITZTgefL6+coUT23XqP/GVuYVN5Yq1MU7w97gt6QkVeq7FqocINnSCnu0NVdFBI/3uQRRSkndTmS7NRIoRu7jVsOXdUnfygXnW0mCZOBOCoVrwUOJed/k1ahnrEf0XDXgL+qG1zBy25MdsvOSmFHzVJXD4W7pGYzZO5FtGIChGynPuvYO6/UDuT/3IPy5ajJ1eYreQRknZhsV2+nhblC0JMhOmgKK3Yz4bb0NfEmv6KACEht7cKAsyLYKTlzBNyvk5Dv4NsX09H/yymD4ULg8qVEBmWN8GZaiTAVB9o
X-Exchange-RoutingPolicyChecked: or29twImkUc5nv4Uwl6664FoDDGvlh0BjohMbs4MRptrGwKV3qpa37Y7Lw8xsY/5yLB0SQp69ynLOYdpMfQ5N27K2F+ZwUkz2SDZ9JqL9P4KW9t06hiA2DmpK+yZkT0ic/Qj4xSbiezecAZXpR6VGblvKFyHhAeWe7ZnCj6TZOPP38O0Rx/8b6SQ4o0oDj94SgDBvoyuSYBklpXRHx7Z5w6jKbEo8tkDehucWOrKgrDHxry6QuvGHyFoH0WYJcFkU4WkEXY9INIgISqbKAfY7s/uy5adfTPbpgaEZ4s4CCf7z0xCFxZHUNq+l1ghZGPOwojU/M+Mr2FXFOVujZqJmQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:08:58.9025 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab6645f5-020d-4ef7-a4fc-08ded2baeb81
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR10MB997706
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExMyBTYWx0ZWRfX4Yd6AltUo6Bm
 Pt8bJ3j10PtGyTs+yehqIT+K4Ccl32oIbDdF5M86uJEUQAe9lACoMLMo4uieJEVjcM2FbPOP7pQ
 aw6b2Px1FiCiYD7CJIi9BI3ldlXsHFj97sPRMv8vgWu2FyUaIYF4lyOPKheKFHAnZyBx+NIzkDl
 ujh6t7scv2wYUMTXqmBZahVn00myqX0NILPB8PbVnq1nwlL1K5+/UoS5d3mMQWLAFQj5Swrzbs8
 IMNdirxWZOWUHAR3Fy8ovqO/N0cKMPlQlG/xsNykIbkF9tu9uk33n5P8AtGrU6mBZHb9eM5NqIO
 e5cOCP1a8a5/x9yDv1Z63+XnZei7/t3Ig9dFQ16BydrApHSzn2vFobSMrF1Qo5Un1xxb25/+ZK0
 20/iGkAqhzydHWrQDN/8ju2bDdMCJNkbzVjxtGwVJGSR016pwUHsijp8W+SL7X+/1EhJ2HsdCRu
 P9Nz00WoVNNk0un49Jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExMyBTYWx0ZWRfX6IwsaSKYQEh1
 pOFHOV3sxAdd7Wj3SrWDb8lSLJZLh2umpd9s+4xCrQLyZgEi0iyNdkIA9C1nNqlujIYj10A/bFl
 QQcASSfBf3VdsaCSdFMjbE0QwcD6Sm8=
X-Proofpoint-GUID: JCGHSFoKbEvN4rQZ1nyqvknUes1SA3Br
X-Authority-Analysis: v=2.4 cv=WrUb99fv c=1 sm=1 tr=0 ts=6a3d2871 cx=c_pps
 a=Ja4avHF4q49+S+GKa94BQQ==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=K9g-p8LCZa6vrTgfnwEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JCGHSFoKbEvN4rQZ1nyqvknUes1SA3Br
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250113
X-Mailman-Approved-At: Thu, 25 Jun 2026 19:48:34 +0200
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

On 25/06/26 08:47, Anshul Dalal wrote:
> U-Boot does not support modules, so having tristate options is useless.
> 
> Therefore this patch does a blind replace of all tristate options to
> bool tree-wide.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.

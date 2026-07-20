Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C915C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:04:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E014838D7;
	Mon, 20 Jul 2026 15:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jRSZvLd9";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="QshT4bER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82D5F84119; Mon, 20 Jul 2026 15:04:38 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F033780517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66KBerrI198254;
 Mon, 20 Jul 2026 08:04:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=proofpoint-05-2026; bh=8b3/Fq2psMzfwHf
 FxBHUlor5WWtbDojWsN6GO+Z7HDs=; b=jRSZvLd9L9ZYqgytXv96yvALdZTjg4M
 UTMhinsHpZzpp0L/BszlrOyfwTmy0lEWEn0VXysPe0tb7P8+0Ba5olZYOZr0u7Be
 2Z4apwE5Tgp3j+IXjkphiurqIlRPzDyxCNhhV67/Dz26SLeyUalwRrMdMgIAx+it
 qL+j86rigeB5WaVcj+h9exm1FD9op81M8RKPilGnZNfbjOFPPa/HpcPPZkj2jxsW
 jRzH2iZej02zyUlZWxfl8zTQDrdBzHYR4gUPr+EBYASLhYGvt8eGIqnzyvT+a0SO
 V4jhwuFDOoAGMjjMC3mOE/x6kWK/NTE8va50IciG6O19MhrQHqrVAzg==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fhk0y0e00-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 08:04:32 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHpWkNPrM+Y8+uwqordzI0bXE+qWQLFlV0+W+R2uMiiUobTnlBuLbGNGcRHx6AkVgp9br1DQronLvSTGs2vEuL1rar9ya9qkvJ/K0wrZcw+QrajuSiEH7m4iuhu8BrLFzexFCE9glr/SDno+8dJkullzfV6UYk9x3dtXk2Rtq9YxWNX0jigztHxhuA2cytumLj2eCIMOKb5uOcm/oc75xP6s/Q5ivxp+aDjnYAaDJiftsRoY0BGnNOOGarNkyHsr1pgX4gufUYj7YivbqkB6HhGTlQaM9OiVSudgpsNlBp7VwJ+0DTyJ2rSlSLdp4yyNy8wPnImqM7w14FfCgY+fnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b3/Fq2psMzfwHfFxBHUlor5WWtbDojWsN6GO+Z7HDs=;
 b=DvebQP/qb/06E6nldi/BCJTQ1aV9Wkad+Y/etIPeUHld7OhSx/DeUov580lzC44dEhWY9wWRgDIRXkm0U/OvYYXB9EYxVPALS+gIgnYAGuTCuL99ozpKClqt9vJDHLtvRgSPQNRPGqNVfFuOAX+XjLVqeugm5w4YCRa+3YWKojeuxjzErfGuMAD3RU3vqIT12WvUVb4f4isJBzsfUAq8B/vY7PAqaNKu76gFoJcQMvqYq0ZP+sT6iZzGE04TlWWhlwueKMOIw9QX4uKR1/XOyjx1Kolp6ENnzyVbbr5/RTv8/RHci6wVXR2w0H6qwJdpT7jU38Jy1PTiFYLiJ/D2Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b3/Fq2psMzfwHfFxBHUlor5WWtbDojWsN6GO+Z7HDs=;
 b=QshT4bERPcMDCranGK86hT2gVSDLho+2fLY6u3+AgPoxOjn3toRfwOwaENosle299Y+jQgqItEYFDep25kSgle9NTNAxD5bH5mVAMn5M26gt7V6ajuOQJGzO68vR7q/nYZ6x5h3ilHOlXhhSO8REBuGi2ucm2u9/KmRLraPoYMc=
Received: from BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::21)
 by CH3PR10MB7118.namprd10.prod.outlook.com (2603:10b6:610:12b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:04:30 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:208:2c5:cafe::20) by BL1P221CA0030.outlook.office365.com
 (2603:10b6:208:2c5::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 13:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 13:04:30 +0000
Received: from DLEE213.ent.ti.com (157.170.170.116) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 08:04:20 -0500
Received: from DLEE204.ent.ti.com (157.170.170.84) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 08:04:19 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 08:04:19 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66KD4J6Y2418563;
 Mon, 20 Jul 2026 08:04:19 -0500
Date: Mon, 20 Jul 2026 08:04:19 -0500
From: Bryan Brattlof <bb@ti.com>
To: Beleswar Padhi <b-padhi@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <afd@ti.com>, <anshuld@ti.com>, 
 <hnagalla@ti.com>, <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>,
 <u-kumar1@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 1/7] arm: mach-k3: Explicitly identify TIFSSTUB images
 when discarding buffers
Message-ID: <20260720130419.q7y6jun2ouo4iv3b@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20260720080114.775206-1-b-padhi@ti.com>
 <20260720080114.775206-2-b-padhi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20260720080114.775206-2-b-padhi@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|CH3PR10MB7118:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f3679d-be92-4816-5ce2-08dee65f6fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|10067099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info: YofmIljhaFPdpZGxoL6gHP/Ts8LD+zAF0LpCrm6xE3rzpMY4Qo0mJN/hwRgs63i1P2coGHyyCtdJ65YI6Iu8sIjQqrYJMLGSxaQKEEGT+nl8ot9RhQ1z2FHu9BKq2465m/rvPdEWPow1/wCpsPPGLU05wl5jD1OLKL/wkRCzy/+bJRdq836iFJqF9BnaOtc+eqY68lTQb5wzUrN2McBgEEJFLIXUtqx+woAIYwfunyx5H0eVzemW/MqcQx4lbSOZTOPhSPFXYf05ZVIcwVrFKPvuN+EoVm/uI+URYGPD/8+lFEb3ZIv9EqxCGVt21muSDNX/fsL0DYyodbrZfQgxs/UuVtiKdEe4neWZWAWwttdtBqQQU3NqmmqlABRGht08izRCHo0a9Wef0dl/gmidjTRgTPd1/ynY3Fn/9QWXRoAMofwqQ8K30OV2p8i8V1pp4IkhoxB51jMikxcCYFRzPxiat7TWIMyHv3AJUtZGYicYxu5dUT1pKO79i22ORnxukEgdUlbdA2yf+gH7mDZ5HGlthSPYf9i9FdG6iNmJW7dyHFEt//xDAsutFr+OVxuRivimfRaH1sDLQm7hOtF85JXfEW3ukYX5YTIxr2+seBvx6wZOAfAitD9LVDLEOIxQ7n96+9aiAeWWm/qVL60VbKXivKNk8dxIzpCpJAkAb6MneHFLuxfzdIovgbxPxLd2jKqYBmV/jcG+m/xG59bPZA==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(56012099006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +trwYlD/q7ce6DdG6PBbxEGEwqJYCiH26I3/0UtFgddNL4WhScy0x12CXit+LBu3EbvX8yL16flH3kjK4QyABisnK3Dw+lJ9ZPcau7jqsGAalYuvghKbQuTbX3eoiPtd8R9kHOhcPg8cMbmkPP/bygHvwGw4FYF2C1Ufw4Gwx3nkpRo3ep5huS8l6Yus2Bnh3zdnpgpesiEO4l/fD0j/O16J1xL3LUeNt0Ldq++jrw+CAEYL2MQxImKap0Kv0KK/fjylnWaz6H/gC5pSfjQfG+bfMyo0DQBQPeqepuEx+TKbHuqnCHGwQlCeUL/BnCMw6LUOhwYnPXOi0d5EiKz0G14LatFhow8XhgrIUbUNOY8xC55sLndwGkzdS/90N4vNKNs3HXtLFN8l1jfFwAVmnKQQPxDQe+qBwL4GaZ6tBFp43K9PS2tX66sNctIfZ9WC
X-Exchange-RoutingPolicyChecked: TXzztkWfWBSsJMmzt4OYy2N0d9chXjs42ENeI/BBAn8rz9z+kgf18nUzq21Sk2UpNwwrXPUgfVmSDaa/SYWJPOadZQq58g2DGvbA9H2G3gnxTm5FkQzwwkZ3drVaDIr/jmA7GD8TtvR5qV9Rjbvz6aql5ZWSDxslrkSnTqWFS4ALkeFnVD9TKw/+039Op9aVJY9A2rUU8OKdgF2RceKMDN0iHZN5NSaiXOc4N7H74SqUPznbbg4ZGIuzyHSzp1Sp13KJMyodx/1qSwoitxZI9LX/cnYf86QqLNoqCi6y3Lj39hhzvAp+DVr7GX57cCLZh+Rm38JRdJxVZIV5XTIgvw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:04:30.2299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f3679d-be92-4816-5ce2-08dee65f6fb2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE0NiBTYWx0ZWRfX0YwPTwfiT3Lc
 Sw3UBiXyZg281qIdZHKES3KBspV8FpMnpMVvw01kU69bXM2XTsrP+SWuMVWoGkZtBnCbgjFudg2
 vBkNxV3eyZZY9xoXpv0ZCrRNDXr2KqgKfDYwoXF0zm8kBIHXZxbIG6ROKSuXVA+iX1AAr6lyH/c
 Dsm9iXivlEiotGHzV7W4SqHmr0Np7QwTtIMWYZQYz9ErvCqXlhNSwVzWORIbf7ustfLNtB73tlN
 lHp98veLZonF2Q4zlsf8XTDr7IrRb+HIpw9zJVaHVYJ3zmEcGZH46kLhn1J6Q7uYpkV7Hp2bnxx
 n0Y2y2b9pIJgTuxhid1XHSqE8PFBhhXHmz+1MOx7dg/0+k7BzNRqieq/jja8fCW/ENTCemY0aGL
 5O13urfYXsfbRA/sjASJcbgQ+a55S462kvwGt3GybQ++0BifX+GxmdmGVvcLs5G+mwTQwqOS3Wc
 8WOmJbr/PpPYK5h3EoA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE0NiBTYWx0ZWRfX1kstidpabIiB
 QaGP6oj/xsqRGwu4CUbrNUobprkLuqScDRo5BpGJQFQVRkMCwu7KGTadRSwZtCtCqa7UKc2bFW6
 fwLYCoxA1W8+v/NFnka+X9x8XS77YdU=
X-Proofpoint-ORIG-GUID: iAdOOFodMPbykWymoC5lQ5HsmBcgMLTl
X-Proofpoint-GUID: iAdOOFodMPbykWymoC5lQ5HsmBcgMLTl
X-Authority-Analysis: v=2.4 cv=J8KaKgnS c=1 sm=1 tr=0 ts=6a5e1ce0 cx=c_pps
 a=YK1kdmGH7fNv6t6SzNeZuQ==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8
 a=DfNHnWVPAAAA:8 a=t9rRwxqRNFOvEOfLj7UA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200146
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

On July 20, 2026 thus sayeth Beleswar Padhi:
> The board_fit_image_post_process() function assumes that all TIFSSTUB
> images appear at the end of the image_os_match[] array by using
> the condition:
> 
> 	i < IMAGE_AMT && i > IMAGE_ID_DM_FW
> 
> However, this assumption breaks when new image types are appended to the
> enum and the array, causing unintended image types to match this
> condition and having their buffer sizes incorrectly set to 0 with:
> 
> 	*p_size = 0
> 
> To avoid this issue, replace the range-based check with an explicit
> match for TIFSSTUB image IDs.
> 

Is this needed anymore? I think Aristo has already fixed this[0]

[0] https://lore.kernel.org/u-boot/20260623141540.618272-5-aristo.chen@canonical.com/

~Bryan

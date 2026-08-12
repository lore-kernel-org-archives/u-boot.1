Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 973E9C5AD5A
	for <u-boot@archiver.kernel.org>; Wed, 12 Aug 2026 21:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2465540827;
	Wed, 12 Aug 2026 21:13:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rhfp1P0w3ZqY; Wed, 12 Aug 2026 21:13:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 39A44408A2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786569198;
	bh=ilO5ZuhOfIfq7x1k1vNjdIGPuWsB7vJOabv3QJMdH9s=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bbweRL642vPF2VKwSMuTb9HxvJ/mZ/hYE1fwVmu0GjMBWopBuZEwHNcStDKiZb6IQ
	 r+yEZWvk0uis9YTDcthhlbpEJeexX6kvSgj9kDX6LQohZY5XexEKtwnZ+wn952Y8Vi
	 AJ6X1dRo4aGvf4vs6gzO3pmZoRwUvM6wIdBNMBJbZcujdV2kwUcpaeimVK1C1RiUha
	 d6thrkiAYAbKpSy0Vct3Ai0a/u9iB78QW7c+nopX3s9NzMAVPuDQXt98HRKLS6BXdT
	 nFd56QYnrU4dA7bxJ/ODsAaGgmhERX1iUJ4BYqAHhyL5w8gIowmVVCzw6mnzcZWsda
	 eZefE71dpYfTA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 39A44408A2;
	Wed, 12 Aug 2026 21:13:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id E32D11AF
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:13:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D53EB40827
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:13:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STILczQyW9Q5 for <u-boot@lists.u-boot-project.org>;
 Wed, 12 Aug 2026 21:13:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org C2D794039C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C2D794039C
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C2D794039C
 for <u-boot@lists.u-boot-project.org>; Wed, 12 Aug 2026 21:13:15 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CK0DMc1217375; Wed, 12 Aug 2026 16:13:01 -0500
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4g0mun4m4h-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 16:13:01 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6k6NHhKqq/6HVgu4XQypvdlrUH/qhwtKa4HDcHLbEI4jrkg/aG6nKpxzc7FH3aZuS+Sv1mvQ0reTYku3A6iMwreHv3D+pNZa44FI0fpH9d5BzMzoQL/rX9Uqn4PjTPF5VbDJX5PYporwCjhmZbYLoJr57Cr1NpMJfgNkqvf8TwTYgbobhn16e930lwavar6n8lthx2PwCruVrcytvgFqJ10MIGg9PVxeERMgrmVN8kI0XHU/i01ev0e54zA3tma09uRwPqfO1wvK2w6yr9vsy4Vyt2GX7izwhi52MK5AUnYHwEz9py8BMdNnk7SVbDybgi/jbaHB7VoFTtIi/qnsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilO5ZuhOfIfq7x1k1vNjdIGPuWsB7vJOabv3QJMdH9s=;
 b=ezUnKnkf8eQXPe4LY0+1NUazN5k1d7YOEmRu7psPnMb8ikPtXLoXHdtQBq94LHZtrxZaR210xkecC2X02zRR9a1m9w2UFFGdNnzj0BLYEt92iAEdqT8lcr2QCEvbX6qsAMjo+VWhL7vnelSyVGqm1Xq9ypZNvKWtf5qBVWOn9Hav5lk9YxcwYbFkyj7pvpqXaTtZzxyXMGb9m7uZkqbfquCXeOFl2Bkz/iXp7V20n2rXtr6wGHdIhYXYur81aF8kRy/Q+y84RFFRIH4CeXpuI2gFqfWQ/aowV6qB7y0E6Gg9zsNtSJ4qfHwqKM6aD2l5i78nd2jaE0RmS4njUPn1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 21:12:56 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::77) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 21:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 21:12:55 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:12:55 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 16:12:54 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 16:12:54 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 67CLCsTA3805655;
 Wed, 12 Aug 2026 16:12:54 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 12 Aug 2026 16:12:54 -0500
Message-ID: <DKN9X0GKDJ44.3H4LT4MMG6PP2@ti.com>
CC: Joseph Guo <qijian.guo@nxp.com>, Emanuele Ghidoli
 <ghidoliemanuele@gmail.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, <u-boot@lists.u-boot-project.org>
Subject: Re: [PATCH v2 1/3] lmb: Return -EFAULT when requested region is not
 part of memory map
From: Randolph Sapp <rs@ti.com>
To: Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>, "Randolph
 Sapp" <rs@ti.com>, Simon Glass <sjg@chromium.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260811231650.3150771-1-jonas@kwiboo.se>
 <20260811231650.3150771-2-jonas@kwiboo.se>
In-Reply-To: <20260811231650.3150771-2-jonas@kwiboo.se>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|BLAPR10MB5025:EE_
X-MS-Office365-Filtering-Correlation-Id: f9091802-d3a5-471c-6c0d-08def8b67a7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: oybGLl3kue4oFahZH5LUqxIoNLYR5eRxHV4TsWdpyI92AESe6mlVdlpEkvzfVHna2pFf2imnQaFWjOPZ837QVUrS5SDp/dJbhcNyRYenH4ocsaj1VebIyqZ3WR//+Vwz11Vy6Kyw2I9O4l9/qSOEl95ryala2qUdwhOOjzm0Ye6ra+TN6dA0tY+LROwX/r5zhHaBPTD/wwWPGWly08NDO6+ry9sNxmDF4x1u/83a08VmkHV7ZVOpsCreP+z/ax7Cq7xqux9aQlMwrtCSsJj3/1frLA1uC8cOiYm2yYBVxS/XdUl1IqZaaeGs43C/Y/Ea0Om6ettBlNBbg5FmxDG5vZMp31nEjCKQuTE9Yt7K/Ru5GsdxLQB/mE5F9wJ3XIEbSgQGD/x4+7EXS2/RBJ1ZrrI37Rx9Ze4vv4Fs3P5Mk/qlEHBNeKivz7Eqq/XtrukcZQxpYr0IoIWtH7PhuFITxKZYfaszGtp+VYkAo5EXwz26yBxyG7zj6CV9Z8fSNrxeLYYg2g0/cn2HWau0Vo0NQVF86hWUXsPydsvrqYnSIfEcXj+za5bYg5rQJo7fyFC8nJ4CcZH4Ked+ZXRDDgtMqmyWC5yn/OZF2KtLAJpzyC802vCMxtR4afhnJCEfaaZnlKtBFhUO/UCRa3cX7V/VMeameflnHoGyJwkb24ac9cZJVbEq+QZuvQhgj+0wR1Vb
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JU6JiddAK08CJzoj5RcRjKmLmJD5Ijkhy7FO3b0ah8Fmm3DftvEiu364LQNXBOkA9hC4pMZxD2iXctm+tMugRbYAjRBMFVagtTA/V+FSejtFp/T7pPWz25diM5XaxRKoUVtfc6GDF/Ma+fLpFeTLWNSR3aeX5BzuQKrYJiZsNy8KltPtusfeCLzjDAL/5y3eRO+FisPjLzjiF0QOnywwB6pmdJI7mGipcNCUVH26KJBkPeFmCWGqRBpTFXn4ZH2R8tlD6kaoT8dQvXirwQOfsz7Zf6HdXanjynRja92rSxhvTfzwOapZDM1UPdOWtSvnKE4IaaRue6KvwJYal2J3UkfdXZd5hkx0Z82Ve2RmXdDtJNnVEM97TEVXRngThMQmuJbocaoKJupgP542ik/16NZiEhwaOMg3jlm282FDvprXfvVOnB1vNtCbGpb8+nxL
X-Exchange-RoutingPolicyChecked: sdvqVLBJNBe/0lmtv1VwejEpmfW/TpBRTVUn00CGi31TwtD9k3RpWmNxzu2DeB/7hyi7+U4Y68dPmNO2Fdf11FpKPE3BGcqrmsJOk/7JpjRBSD6RKylOqilJvwaEvGHMiynFZv6RouLxZlERY2L4KF53KVhNawZ8ic4LwXo39EqXlR0ssi7kqldUOrvGz/HXnxFwtjzYN5KyP87wwqCFGmXNwqXQx/rdkKW11nujGtg5Tbl7hkbzA8dWhMgMn2vAtnaKVdKDPowPVOq4lFSqXnRjnOAxFZhf1D+393ZGtHt4RKpK7ZGTP/IfDJeKkUCl2wfMGBgE96qI51+l1zf2NA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 21:12:55.4841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9091802-d3a5-471c-6c0d-08def8b67a7f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Authority-Analysis: v=2.4 cv=JPQLdcKb c=1 sm=1 tr=0 ts=6a7ce1dd cx=c_pps
 a=PJn3dW4q50A9PoMJtOr6Ng==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=BMSE0Y2szrDmOxzorHoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3MCBTYWx0ZWRfX37IkWxuHpYD/
 VbnzH3Po7rkj/FLPpHlJxejk2UMWrAzGIm2FlIBhQ/MMhoEHYjK31ob5d2JGxlZBavXoWAZ1kuW
 LJl6L/ujifYgfwDZ2O+MEAbx+/cJi3I=
X-Proofpoint-GUID: Oc7HxHCewbVQ6H_RCttJbH_ac_p9Ec_Z
X-Proofpoint-ORIG-GUID: Oc7HxHCewbVQ6H_RCttJbH_ac_p9Ec_Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3MCBTYWx0ZWRfX+qe0Dt8P6u/F
 tcpeEJgoMukN7cOiS1r7pV2KgYOaqIrvVpOMFjQ6EWuSFgo2dl6d94XyOTUtLDL80Q0Lq3mJgMm
 UqmvqforJtwo64Z8V6MRgl3RGB+xT2hR32mGkU+YcbRv/LBo7klN597b1mRX+5n2QFXiHXZtLJU
 Mfzs2fSjpylhhSnQUjyuiEXjh7LmpB3ocl/LIozizvRkvpb+RdAdDgch8xJeNZtpokszEr0a0WA
 Nx4235S6d9DVIrG/QP9eed19bBVCVgIRhs//PRTJ0wqgnDNFlcZ3FejWLD8//LGX7/LFammYl1M
 sDoJqhaBsYtUeVDuslXdnwH17gf84Au44GYoik929NoX+YdLuiBMYD+3EiGh4wk9kIXaFiiZ2ug
 UavKstr4XKUezJiXF/5AuxHq5mu6/RG0CF9094hQeuV7vITHKLDkPlA5GKOAbmjb30Vmf0EOws9
 +7Ivn76jPA8Ja5sRUgw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120170
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ilO5ZuhOfIfq7x1k1vNjdIGPuWsB7vJOabv3QJMdH
 9s=; b=hyW7LFLysZk46TSGqt3AYoZjyQuuZXytsoCIYZu+9LThHETX1vcZGwRds
 GPXianWMEm7fI0lBIrkaUzC9hl75Q7vE1pzbqWG4uUFH9KWlBkL9Yh+K4GQhNJKV
 gZS5XKyqCnfn9q5uMljzbTPFEPoglfeJAGxfksBaG6/2/quRtdaGEZk9kZ75Rzoh
 SY56aThwYd7Qsc5wmEqjQGzHh4DPzOPVuxRsSXbSwmJVSrZuKmQQKCpyJwP1Rwuj
 vYfwJTIBgdeR3QuRFP7XWluqmxPOMgekw6zANso1x8/PcuKba4I+g7QPfeAF6R6J
 Zmn4nFFgVhikpwPVVt6KmbmgF/M6w==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilO5ZuhOfIfq7x1k1vNjdIGPuWsB7vJOabv3QJMdH9s=;
 b=UBul1IzbVsUNgpkPZC6Ya7nDtJLJyDW/TErgy0tTdPXPz/jrmgAmwwTNqQB0qrpm8ZpiiHOYqh0At96RPz7aUB61HNNzCVvSu6jIumqdbb9TwHyc114kpUC0fAOHzpdgIG831F0g/uqueHPHjnont2NCiGYY8RPNX9poknD26+Y=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=hyW7LFLy; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=UBul1Izb
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Tue Aug 11, 2026 at 6:16 PM CDT, Jonas Karlman wrote:
> lmb_alloc_addr() is documented to return -EINVAL when the requested
> memory region is not part of the LMB memory map. However, -EINVAL is
> also used to e.g. indicate that a NULL pointer is passed as the addr
> parameter or when the requested memory region partially overlaps an
> existing region.
>
> Change lmb_alloc_addr() to return -EFAULT when the requested memory
> region is not part of the LMB memory map to make the type of error known
> to callers. Also extend unit tests to validate that the return code has
> stay the same when the requested memory region partially overlaps.
>
> No caller of lmb_alloc_addr() is checking what type of error code is
> returned, so this change has no intended behavior change.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  include/lmb.h  |  2 +-
>  lib/lmb.c      |  4 +++-
>  test/lib/lmb.c | 10 +++++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/lmb.h b/include/lmb.h
> index ed472e9ef2e1..028dabb19e86 100644
> --- a/include/lmb.h
> +++ b/include/lmb.h
> @@ -124,7 +124,7 @@ struct lmb {
>   * Return: 0 on success, -ve value on failure
>   *
>   * When the allocation is of type @LMB_MEM_ALLOC_ADDR, the return value =
can
> - * be -EINVAL if the requested memory region is not part of the LMB memo=
ry
> + * be -EFAULT if the requested memory region is not part of the LMB memo=
ry
>   * map, and -EEXIST if the requested region is already allocated.
>   */

This doc string may need to be updated a little more to indicate that -EINV=
AL is
now used to report partial overlaps.

Reviewed-by: Randolph Sapp <rs@ti.com>

>  int lmb_alloc_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 77440a48486c..f7c2e826d067 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -752,9 +752,11 @@ static int _lmb_alloc_addr(phys_addr_t base, phys_si=
ze_t size, u32 flags)
>  				      base + size - 1, 1))
>  			/* ok, reserve the memory */
>  			return lmb_reserve(base, size, flags);
> +
> +		return -EINVAL;
>  	}
> =20
> -	return -EINVAL;
> +	return -EFAULT;
>  }
> =20
>  int lmb_alloc_mem(enum lmb_mem_type type, u64 align, phys_addr_t *addr,
> diff --git a/test/lib/lmb.c b/test/lib/lmb.c
> index b6259bef4426..b93b903f99f9 100644
> --- a/test/lib/lmb.c
> +++ b/test/lib/lmb.c
> @@ -779,11 +779,19 @@ static int test_alloc_addr(struct unit_test_state *=
uts, const phys_addr_t ram)
>  	/* check that allocating outside memory fails */
>  	if (ram_end !=3D 0) {
>  		ret =3D lmb_alloc_addr(ram_end, 1, LMB_NONE);
> +		ut_asserteq(ret, -EFAULT);
> +		ret =3D lmb_alloc_addr(ram_end - 1, 2, LMB_NOMAP);
> +		ut_asserteq(ret, -EINVAL);
> +		ret =3D lmb_alloc_addr(ram_end - 1, 2, LMB_NOOVERWRITE);
>  		ut_asserteq(ret, -EINVAL);
>  	}
>  	if (ram !=3D 0) {
>  		ret =3D lmb_alloc_addr(ram - 1, 1, LMB_NONE);
> -		ut_asserteq(ret, -EINVAL);
> +		ut_asserteq(ret, -EFAULT);
> +		ret =3D lmb_alloc_addr(ram - 1, 2, LMB_NOMAP);
> +		ut_asserteq(ret, -EEXIST);
> +		ret =3D lmb_alloc_addr(ram - 1, 2, LMB_NOOVERWRITE);
> +		ut_asserteq(ret, -EEXIST);
>  	}
> =20
>  	lmb_pop(&store);


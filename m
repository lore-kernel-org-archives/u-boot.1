Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B173CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 00:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FDD846E2;
	Thu, 28 May 2026 02:02:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="Wuxfj9Ma";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="cySgBn1P";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="FXrUjXTm";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="N/QXjg+I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0BEB846D1; Thu, 28 May 2026 02:02:34 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76053846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 02:02:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367130.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKhu3l1427224
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 00:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=bib3TFIcj/dkvKzxSLpU0W0LVjv
 tNpIOs5+r5kEypok=; b=Wuxfj9Malh0BIz4oO6XZZnnou4CTZ3wmrDMqoo2gn6G
 bgSAZPUM+edsfult+yazGxwxUV126bXbnJeb7FSXGHz485qPGLSwG6/7kKQXlGkv
 P44FWpp23CIXHxQ1y/mdZ8aK0Fl59Jcc7kxP5wwbS0iZogAboErL/jGhT1WDU4jw
 VHdzQ4vcTEknWy+X8D1wAxh0pCGqYOfwSei3vFTU12xzSfN7ALC493CKzA3m7ZXp
 whdpC9QgVnvFo2lyFR+zPW4zh9VwVrSbNilYTx0RyU/tIKxygYSlImt5biYOJlce
 serYUY0pF/6RpSFGvVDFTRsCosmYUQNoQbE5Jo+DqVg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wjs39s-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 00:02:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PM6u2aqgOJNVizp0FpmufMI4pJ2B7SOi9r98q6YVduefLZOqeG+cefUZIJk8VeuOY11zOjKNxzxmj5HPWhMu5QSAy+081gxy1TsGnrie1fXjVaQ3XKRMTVX4bRxzj07ro6OcyjFH1NpOA/gHj+q4bcIBoWXdzx4vFSoIG9ixDo+D3baFEwqkBMxaIWvt35yLN33xOWJBuKGjXVk3REm4IQM2momz+b0F7vFgEwUUEpzHf3rP98XtNlhduZtW4bXXQ7KivN44Jr/6VqtmgTBSKJh2zpAzM5CsEdfmFeRYg5Q+SSAVuZ/iNfAr05lggAhtb0kWAfu8/dRw0UrcFsHwUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bib3TFIcj/dkvKzxSLpU0W0LVjvtNpIOs5+r5kEypok=;
 b=ypEGuNzftR85PHUFJfXFLTHKSZd/MvPy+dhCg7z+BrRP9ocDY3juFHS/sqedRInXqyiu8HrQAsIbDIGNQGL7UHUhg57XRTWHBgYh/lbprAdf+4SW1pCWy9BiLpIxIde/7Qbo1A/laVTP9j+4ou5Q+0tBDraf+fzSJStwc3GfLbEid1QpK57lIJQPURVo/ewxSPPlhkCVGZz5DPD/kn8jdaXYUhrGwca54xS9so28shFizJS114vniX/iHXjKwe+ZsalP+fuWwR4e90+Kt3lND0Q7Uhmu4mt40dVZ+wb0R6Sek6N7AXvO6ZwBFD6ME0xvjIR3Olcb4Gclweem56y6zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bib3TFIcj/dkvKzxSLpU0W0LVjvtNpIOs5+r5kEypok=;
 b=cySgBn1PZ/CVYY4lIahMRn2SP85/zPgKWkuZESTlZIoVaiHW4eoo7eXSXQuJL8JvoIWZaf9/pRTIv4Ile+FRWf8qquIaFP03SY0M/P/kX3dLGGR8IFsJ6usNX81Ak3J300DY8CQfgtK6wzpgHXEdRBRgKFjCuBhr6ctMVnueCzI=
Received: from BL1P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::24)
 by PH0PR16MB6992.namprd16.prod.outlook.com (2603:10b6:510:382::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 00:02:26 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::9c) by BL1P221CA0009.outlook.office365.com
 (2603:10b6:208:2c5::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Thu, 28
 May 2026 00:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 00:02:26 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjFmT2743692
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 20:02:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=bib3TFIcj/dkvKzxSLpU0W0LVjvtNpIOs5+r5kEypok=; b=FXrUjXTmPY7Y
 097MNar9ND/grt1JJj6Yfb7j1+0ceZ9hlNiDrRBKRS5hFeKnoBHQBDRNjZixU0N1
 rSH0WkBgEEyX1a2oKxWKdczh+BGgLQDWz/TeOIAoDbNHGpwVm9KmVODJjH8db0zQ
 ksJvvB7c8r7/SLvDkoHOkRbfqkUSuWap4NNAi404smrCgYvoC5J4Wg7B/vnT3au/
 53swYEHc2bvwdXh0I8iD/XrOKMldz8a3fXLU62ymokpjELXGv4ljQn57xkx3XsgZ
 aObkx4MW9TYf09yizRRtW6aSg0aQx40+bPdBcTXJgvxEB8KSXyB6m8by8uMS3vRF
 uaD6CA0kFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=bib3TFIcj/dkvKzxSLpU
 0W0LVjvtNpIOs5+r5kEypok=; b=N/QXjg+IRbQ/TwMeV6dWgSPI5NpmbMN9gPFv
 RiTf14IwxvEuWAnA/JMzPK8T8K7ZFj411QpnlnHcSQdsvxdVQlm8gz3625NrVXcw
 T8KOMCYkP/s5Ef2d+KARmHaJvCuzqyWLIiCW/0//FSKUgIxVPXpMu8m8SLls4fIH
 PT8giDufe0EZG9WRoZR9yDhhixtE7/vkWwUmY9NB/11Vhf4uePRovQM/7WmJArwQ
 pz6D/H6hzSWG+Y1111O558I1hnn3AwCreZPddKmQxi6GBVDIEyZJuSzWRq5TJaKZ
 F31Mfs7anPwRWdwaOTO/32P58CpCcNCSVkXYe5ld/+O6UEaMvg==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x5r563-11
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 20:02:24 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SOCdwxFilhUj8SOCdwupiv; Thu, 28 May 2026 00:02:24 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SOCdwxFilhUj8SOCdwupiv
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Wed, 27 May 2026 17:02:22 -0700
To: Tom Rini <trini@konsulko.com>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org
Subject: Re: [PATCH v2 6/6] tests: reset: add cold/warm reset types
Message-ID: <aheGDpyZsmXOR+k0@kraken>
References: <20260527231306.1714741-1-dmukhin@ford.com>
 <20260527231306.1714741-7-dmukhin@ford.com>
 <20260527234715.GC93986@bill-the-cat>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527234715.GC93986@bill-the-cat>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270239
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH0PR16MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 49935928-5533-4987-f5a5-08debc4c66df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|56012099006|18002099003|11063799006|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: mB5XAiOT74/yMYrQUUNTFbdaNuisCmPt/xGvHwvYtvf7KAVpCJ9MHiNjryzGcgVNwUxPrEi1M1ECAzXFxvPjuw3NQCJR+8RYUwTYwFtxBBMhoI9dH2C4d0SPIYgaUPSy3sZMamfErjLD1uQOCPAw02B9ZNJ4OjjgDezNgbpM0iF50+09j/rNz9rIK27+9K8XbcbtGIfF7X39Vs1zvxW7eeDgOuG/XqSUxANIOoLiSWYeysmmI2bdecAiYKzJJjV+7qF/sVgWqeJwT+nIdJN315wo416ZDG6ssHiNSnH+1L4KXYAJs/dprB78RCWKOVFJNFVAql08Mrf9HF6fBA0uZErhtFThX3kySAk3ZMqlk8kBgCaa48CQpW1Jo1T0JxplOGU3Xqt94vEz7PjrO440EB68sX0wtZ/rfEBjoXYKIj43r141eg86FCCd9G/smGBtQc3tFE339M2nKrXEpigG7/R2NGcs1hgscrIYmXZiFKu7kzQ/HjY9/DjTrFTEFOCTOkSQu7+yT/Hqa8AVY0hwIAnA1o7GCj/YQFryXoUtfP6eu+6qx5j5vatuKobaLrtass0LXr7ruXtcKnUc7qkdlZSp8fntJADRP27KBbGoUqAOZOEHfPmndELdGDKT5Z+GOTzRs6CWWirv4IzstxwmVVIsZ/x/b0vDmlYNi8P3CscZp4CQyiGCGWU2EC/jnUl3hQTNcJF1MXJ2D8E9aJ20/uoFy88jYscc5CTpY4CMz2s=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(56012099006)(18002099003)(11063799006)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5fOEKOQKlAD0vMfMb7XyaR5b/W2pskUnND8Btg9G4ur7V/qerVhhh0Pne0rzU17N8PB9s4A86Di1w+8+whG62A0WMYNtqQVAkMlyn2ZapKo48CBEdpbY9aN6l+nZM7FwR/SRExfVaWHNX3ehwsAD0eaX//2F9mF0eF0k1eHboxHNbLrjT2ceTLsrgRB44Oh2NDZluX6zqSSvS7C+iqGyWhwrfh1TTjSG45BH7bSkFSNgQ/cE9cI9uaewDJLssTKSBX43dE7fO3ORd6JpHm199kwq6oyBPX8Ot8PCm7OwRvT8pKROSGOtBfMn7XwSNRkN8f+X65OMPX2ScLKUlnf0HiNBvs1oYP5lfdZqUJ2xH76bXj57zH3LJwax38SxBDcshYuh1l/5Knhp5A3eqjefcbB/eby4FMKY4JWuu+WmOzm14klGIk0QodcjygzIsM5u
X-Exchange-RoutingPolicyChecked: a82IQ50cMWuCTFrv02b/T8udqxy9CH/wXAx0AFRq0NyEWKPKgI7ATOunGaO8I1IAl72xMJf8QEJVOcIkVwKGwsvchcdM4yMq1RWNs2yGQbPB0iEmIQTzzh17zuAL/rWFrSGu+5O5Jz/gM6hVmmFti49dPq35OefbkdvToDf5jSkIr2NCwZGSQ4wtu3obEveJkDjoEq8rzea9v/WfSg6b9/qsPRNGMt4pdl0UqFRRzlj19SpEBSGuWoKEpsmA+jRkAdjnvYI0FqWyDX6+5PVHoDkHGwMngt0XGehc09lVgjhisSLhaMoRLjdgqJkykTKN0Bxvbo1gQICCAmxa9XghKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TnwMSC47dwvjRhsDqlYy6Ujru/uXgk5xpLMQe9xxDWLigx12POkzFgsAnIqHDqcgQGBNu7rHE2O+K0ktsO4t9EQr34TB3p3s7VKTpPVtLZEzfleGIA/3Kd7MS5c/YaDiWBVKM26sAhlm9rxeQTbWH7+rZS+SznK3HYSm8E1+H/jZzbvRjhWebvW8BxiS8wPbrMBZyjRPBwFbE63U5iYEmBbhDJbnP/+bsx7dHwQiy/U20MXwWKeo+duHSNBUJhDXxkghU2kDVcCDb9jN/v6EIWzWcz6o8NnNEIruLlUQaLJe8kBRVAY+oQPfR3lRAYU/2P4HfHFJD9kBnrO9IbSg/ZMC0nrImD3501gtFJ0ypOVFJYGqSzH6FI6iEVIS03RBUQGFIwVVlP08ie4O5MUag6+EDOPH9tGzyMv8qGqXKGlAo2chJkziNEFnSa3uv89dcjzAKqdv6Sr3jrAXKQ1n7h8ZW8sgyPiPt5hXOmLB7iRAsBdQNmd5SJR01qTFmsEcPXeAeHHq/UPkPsZJ+KRLdUVxGbWPSEUqXuABKtGwQNPZeuvFhQzTa/Bz1PYyepkPiWGpRNFL3OpMf6NsjQh7SyzSDWKEzUv6t1OblCiGlPq9OOOPm6uM7yRy+dzRu1HZqG8PVU0TDXwhc+LbxRe1fQ==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 00:02:26.0231 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49935928-5533-4987-f5a5-08debc4c66df
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR16MB6992
X-Proofpoint-ORIG-GUID: xgvh3KJmoABvCPN18nWfBhoNTNBl0NX7
X-Proofpoint-GUID: xgvh3KJmoABvCPN18nWfBhoNTNBl0NX7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDI0MCBTYWx0ZWRfX+KVmo7Dkt9/B
 1JoPBlD5xJoxuMghFYJbL5tQQAhD0x+ppTw1biXOzvVGp8nRh3yNsRzpPgoulBiniXMgDMcjRKA
 29euUsFLDJ98VpNAqo1MGKATusIAnFSqI77KY0YXJXwk5uHT0X79iYy2ZnXjjJwtaa/GdGeoB/P
 jRb34CeYKfyu5/DHl/KwkIqisdTxa1uD1uzpQGJ2ec5ro77egezZ0R/87amw1mUm3rTrvAMRkPe
 vBbwOEjLLdO6sE68WYH4H6jmskfncxyO9aPXBHt/km6vjkhtwQ8PRqQyI8fxPCPS5o2nc6Yr37E
 7KFZjh1vDiV3b4QP75XoFDDNvAsZ8bN1vYhdwDDGgZ3bmdkuaAEHGV051m36c2yYTQmc1m7pHcl
 qCPB3VOV/RH79a5CdweRQWMoX7r8WH/8hzIwiKA0gTZK2L565aWm4z1RgR8SSdkMkplgN504zwJ
 DpNH3SOIELpGy07tTyQ==
X-Authority-Analysis: v=2.4 cv=O48Jeh9W c=1 sm=1 tr=0 ts=6a178615 cx=c_pps
 a=Cwg/eoBiIzPoLCvUJpemAw==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=vnUQfov-gS4s1L7hHvr-:22
 a=cbNQJ9GKAAAA:8 a=doHCpH4IxyKdpFjuJzsA:9 a=CjuIK1q_8ugA:10
 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270240
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

On Wed, May 27, 2026 at 05:47:15PM -0600, Tom Rini wrote:
> On Wed, May 27, 2026 at 04:13:06PM -0700, dmukhin@ford.com wrote:
> > From: Denis Mukhin <dmukhin@ford.com> 
> > 
> > Extend reset tests to cover both -c/-w reset command flags.
> > Make sure sandbox reset tests are passing.
> > 
> > Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> > ---
> > Changes since v1:
> > - new patch
> > 
> > Test for sandbox:
> > ./test/py/test.py --bd sandbox --build -k test_reset -v
> > ---
> >  test/py/tests/test_reset.py        | 8 ++++----
> >  test/py/u_boot_boardenv_sandbox.py | 3 +++
> >  2 files changed, 7 insertions(+), 4 deletions(-)
> >  create mode 100644 test/py/u_boot_boardenv_sandbox.py
> 
> I'm not surprised to see we could put a u_boot_boardenv file there, but,
> that's not where it should be really. I think for now we can just keep
> the reset test on the list of tests not running on sandbox and address
> putting a u_boot_boardenv_sandbox.py file in the u-boot-test-hooks
> repository as a follow-up.

OK, thanks!
Will drop the sandbox config.

> 
> -- 
> Tom



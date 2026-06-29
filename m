Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2234BC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 20:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50A9C84A6D;
	Mon, 29 Jun 2026 22:32:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="l2tuTPA8";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NLXPTurT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5436E84A7D; Mon, 29 Jun 2026 22:32:37 +0200 (CEST)
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B948C84A29
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 22:32:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TGUON62579626; Mon, 29 Jun 2026 15:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=xbNGULXaZWql4WVs0n5BOzgiexgzsJwymua6ks66l
 FQ=; b=l2tuTPA8TIlJu7Vts4FR25jIW4EgO6Jd+ShffTRvcBZY3lVjAaiIoOHZQ
 albZGf85D3ArpfwO07q1UgD4CiQsudR4rKw40ePn9PWral4JLFTD3J201bE5hBuV
 EmZ5+4s4fovWNSQTMT4TlWt/FseFxCtf+cWeVCAQ55pyUw5Uo55dxrXTwuQyEfZZ
 m2H908TuBynHcoBQz3lQpi00Uo6oKyt/0ggtHxZ4vQZyiaviALm1GW2WO9MVhnng
 ESgEVSdnULkTd+wKFyhAl0tMhkWmJkxmezoWQXb24stlIzAoLUgus4fAhM0sUNE2
 yQ5CDLVsEcqcZ0GqK1Nazll/M9Teg==
Received: from ch5pr02cu005.outbound.protection.outlook.com
 (mail-northcentralusazon11012070.outbound.protection.outlook.com
 [40.107.200.70])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4f3qp5cjmu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 15:32:27 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lMhTrsQhSHFki1t391aQGIlKH5M8N1HVY8ib3xxTsoFjsydBbYGuRkaO8L6EQi7Gr35CWCq1tJCSsFHA+xwrUrAz2DuBGpGDM1WHYOwpyicdMLEIHmdIMmQ06BPnT2CZDnbguEVPofJPKkaNBIeNS0riepuH87JTvApzmfqOA1p3oE8E2A9UOanChWaRa3pCqHHFAyzrxKSyZmeGY+HF/lkCV38gyVr8RJ+y7pjmQDRS9mhxQjzo4A7KPIVm7aoqBC3/LQPcFbktHwebjNPZ/K/0/1IQz6/COzDmde+7xoPzuZ9og1WOrnQT1DXHc1byfqoONFjl3TyYkkMviqrVLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xbNGULXaZWql4WVs0n5BOzgiexgzsJwymua6ks66lFQ=;
 b=t0TzJBSDXZd9gg60G81z32KvpOCNPshqve6rsUso2Yn4ZVo3knrInhGh8Clk35qyPOCJ3OtpoQKdXu+Yb2TICTbnBUUpghYx+pF0V66Z/4YzOz2PG9vLqBQ24/ujvoQ3idSazwaHBRKbE4jXZ/7+cNvyW9Mw8/zEeBWtlcPFDoVVZBsoDvKq2Ez4H4mJNQMR/C6GORvDIQ2YazDfQ2nG4NvjAMdzl7LAWeexQds0dqnfDT5uHsiuQVmiGwEVfJWblZUzY5cgabTxRXq/eTqY8E5r9FaWEyUi/npynLZ4F9G815m1kopzHYJE0lH7UrStd0a2p1d7A4Kcv/od9YdVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xbNGULXaZWql4WVs0n5BOzgiexgzsJwymua6ks66lFQ=;
 b=NLXPTurTiP1glzehkC52wB45Mpe++d08aiO5JWHjDTc94BNRI+s007amGVXVbJ0Kd+m+yDKYp12/676/Pn58Z9K+eQRNRxuYJai3z+cCIQ2lP4Z3mTPtDj1EyVjHAeqfuLaLynYyOa/3sIBgD1bXLcCUY84qTAg3myW1LfNM3cE=
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by PH3PPFB448A336C.namprd10.prod.outlook.com (2603:10b6:518:1::7c1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 20:32:24 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::62) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 20:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 20:32:24 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 15:32:21 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 29 Jun
 2026 15:32:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 29 Jun 2026 15:32:21 -0500
Received: from localhost (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65TKWLwO822103;
 Mon, 29 Jun 2026 15:32:21 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Jun 2026 15:32:21 -0500
Message-ID: <DJLTHZL0ERIG.JV1UL67GFIVJ@ti.com>
CC: <u-boot@lists.denx.de>
Subject: Re: [PATCHv3 3/4] k3-am62-pocketbeagle2: add support for 1GB variant
From: Randolph Sapp <rs@ti.com>
To: Anshul Dalal <anshuld@ti.com>, Randolph Sapp <rs@ti.com>,
 <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <bb@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <xypron.glpk@gmx.de>, <ilias.apalodimas@linaro.org>,
 <sjg@chromium.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260624211949.327905-1-rs@ti.com>
 <20260624211949.327905-4-rs@ti.com> <DJHO54H0KY54.3SIYX4G0BFWCL@ti.com>
 <DJHZGCZ2O03A.5YOY5378VIKG@ti.com>
In-Reply-To: <DJHZGCZ2O03A.5YOY5378VIKG@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH3PPFB448A336C:EE_
X-MS-Office365-Filtering-Correlation-Id: ce17c529-aaff-468b-562b-08ded61d871a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|6133799003|4143699003|22082099003|18002099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info: 4kGGCGfH2L48SkJnwNOGFauph3vS8iLsbD4V3saaieZ4vP+qR54K8K/Cpy6tsCQsu82EqnQGH/0Oz+oCIVBncPLMnqKu9UNT6S444vULQJpwwGvDe0ATG+mm5m45+k90JGnAmdF4qAy08JIeJ+dkvPRJ1YTt3dyLmoawujDkbRmLA/BrP7qIOKt4K5CnAekYQ03WJMEB8R8y8y/77HAPKRpp8xkr9gS54hNbQOEjWsrG6yu6DP0T07/yFmpVwJzrhfLJJtHu87Y5G11AwD0/sxmG3Xesg6A3dQiY4eeYYDcbMf0NB8F6Wk69pzrUa4jVqYNyTKbbYDiUryjsYHnzK7LDBiODRvKhrMrqmc+b+oSfkoYODF1WZwjua/ekLvXtY0R8WM1rJtI36feRQ3zLJFk6XHhf3wnBn20OxyF6RV91JxOMqgcgPyHnpHYsW3fMLtlBG1yuJz9QHylLoU0Bys5iPHyNAZzGOUDgKRc+KHlNC8V48PfCxNUXwtTYN79QxrPUx+u4OaV2SQep0VjpxNvlJv4t0Cnsor/ROwVmnFVSkqzmmPhlyQQ94lm899Y3PM34cNQcXc56k8jU5fZ2z3r43PLbN5f8rwYqr397WpjVo/cUYpMzUmo+ESUJ8HU/w6ehvTAw166M7v5F4CG3NwriUl555rt8MHNCFE+gruG8WazrARBlvJcpl3jVU1qslZ8YR+BhTGMkAjM/4HS74JKcbt7zYnDGMxAxnbS0N5HOXS/mljM/nXjEi9I/SK4E
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(6133799003)(4143699003)(22082099003)(18002099003)(56012099006)(13003099007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0I2GSS/XYW3y2eHME8cvovrn/qp3zfPS70Ex4Q03wktMGJTkABR2VtoylTVLVYrr6HhFmlmiJq/wuCubObvaZqsrGcc7JyoxAqJMDr5ZSS4TTmqQJNm0y58ICBo0mtilJjcbqCVWfReqOx+5JM6V8mxwk7yS+J90du5//2kgKv7k4VoVFQlzcfxF10a7AmcLMSuC6bz1g8011tsFT3nD8VC8VDNZKr7+S3wZoYR0o/V0hbEzr2Oh8oT7L5EKx97mL3Z0RHErBa5B285XNH3jZ6LcJl8B5USzcRXmxJufgjzh5rgWdfLyYRfqbDe5kWD0IK/obGbQvHCsZ1Wc+niyvoMlTH8R6qP3w8ze9yTBdtJSV5en+23oSYOudj0WkLW9aALfxOmUoYz/xFkhEJNWp9CtyDyvZIsKFweES7dpylo1KorZaWgxLqK/W6wa+NUz
X-Exchange-RoutingPolicyChecked: WRyz0BdfPr18gNGelHzSVr9Xzcz5dvEDbfqs011PnkzgNAmzln3wlSG7FuMRl7sJcGIc7oTL5OaA50ZO9IcrTY7Gh3up7yQ9eyYIkKl69z0gH+eTtI5Zs8a/7KhGNpPgQPXvfMawtJgRpRvK9C2u+O2sWHc352VFyuV3f27YFJctz+1mWeMhPH+j1NzdaV9L1UnTE5b5mBQnS/bxruX6GW/KEszllXMJgZ5+VzLLjKXS0o3u5WMGwoc591f4EXFb6dOmk1WnZ5V1STMioVFg+ghIK/nSL/4BIjUM/bMlcvvYXuUKjNET0zYHde4dxzsxO9yIwYXMeWr4NIvQQQAM8Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 20:32:24.1371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce17c529-aaff-468b-562b-08ded61d871a
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFB448A336C
X-Proofpoint-GUID: lsvINZ--YPuAnG7CMdmuZR2DTVEBOly5
X-Authority-Analysis: v=2.4 cv=ObOoyBTY c=1 sm=1 tr=0 ts=6a42d65b cx=c_pps
 a=XGLhMEKp2bz25O9eZsCnQw==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=lLZmtIKjAAAA:8
 a=NEAV23lmAAAA:8 a=sozttTNsAAAA:8 a=9H2GdEoFjrAmWNwlB0AA:9 a=QEXdDO2ut3YA:10
 a=q5Nj8NTjyn2D8kUwajRn:22
X-Proofpoint-ORIG-GUID: lsvINZ--YPuAnG7CMdmuZR2DTVEBOly5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDE3MyBTYWx0ZWRfXzIYg1CUh153z
 amSqXQHwPXcqMOJ9Fu/YwuV/A9MKG361ircaTJ674OiAJIA1/rGy1cbR1m5SeFNLVaCwf3pekAW
 cUzAlAciGeYQK8RRHWQashvSgi1mxoFZOeeIP4FXuxFBjT4m9icI43KqVorFn30pBUZu3DgfdjO
 xt1JvEAy27X5dv/LaCZ15xKWo9xUWsNF/oK/2AC8kg64RNuR0z0rlclklO6PPRgHQnTb5C1b7Rd
 MWqEOr2q45kZdTmKJq5KRAelYtnGrY+1f4dpsfeFFiuuJTfzfRBcKl0HSscbmhBQ2Zd+JxY7dOi
 OfRaiznn5SGUVwYx3z/loU5GDMfS61GBoEjaVGHEAsMMc/CBx8Ze4Be+H8PeHyeY/PoFIgyeP3/
 P2eBS9BbAjjcjM4+FYmt22Bxhrme6fygk+SjCAkTv4bgx7Z9VHsblYMxY5qw9KyTrf1d/BPvrxN
 tld5N6oMETNCDgVwQsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDE3MyBTYWx0ZWRfX6dKqli9eLRKC
 1lcjbGQPSXZ1D1kDC0hAnQCRYyvpnJvWQHTrhGgYp+10yUBb8Ui5ron5NOT3XYOWXltR1N12Kh5
 L5mAuewKehGAJaR1h4+X+iR4viDl6xw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290173
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

On Thu Jun 25, 2026 at 3:21 AM CDT, Anshul Dalal wrote:
> On Thu Jun 25, 2026 at 4:59 AM IST, Randolph Sapp wrote:
>> On Wed Jun 24, 2026 at 4:19 PM CDT, rs wrote:
>>> From: Randolph Sapp <rs@ti.com>
>>>
>>> Take Phytec's current DDR fixup functions and utilize them to
>>> dynamically adjust for variants in the pocketbeagle2. There are
>>> currently 3 skews, two of which are both 512MB with the same memory
>>> configuration, and one which is 1GB using the same CWL and CL settings
>>> but a modified density [1].
>>>
>>> Based off of Bryan Brattlof's patch [2].
>>>
>>> [1] https://mm.digikey.com/Volume0/opasdata/d220001/medias/docus/5411/8=
G%20Bits%20DDR4%20SDRAM.pdf
>>> [2] https://github.com/bryanbrattlof/beagleboot/commit/fb2f022e27427e99=
0d7a33fd001ffb571e13cfc3
>>>
>>> Signed-off-by: Randolph Sapp <rs@ti.com>
>>> ---
>>>  board/beagle/pocketbeagle2/Kconfig            |  26 +++++
>>>  board/beagle/pocketbeagle2/Makefile           |   2 +
>>>  board/beagle/pocketbeagle2/pocketbeagle2.c    | 103 +++++++++++++++++-
>>>  .../beagle/pocketbeagle2/pocketbeagle2_ddr.h  |  50 +++++++++
>>>  configs/am62_pocketbeagle2_r5_defconfig       |   5 +-
>>>  5 files changed, 184 insertions(+), 2 deletions(-)
>>>  create mode 100644 board/beagle/pocketbeagle2/pocketbeagle2_ddr.h
>>>
>>> [snip]
>>
>> Just thinking out loud here, but maybe we shouldn't take this patch. The
>> industrial version, on top of having more memory, also has eMMC. That al=
ready
>> mandates a new device tree and configuration if people are going to use =
it as a
>> boot method.
>>
>> Then again, maybe it's convenient for the users who don't care about eMM=
C? I
>> dunno. Seems odd either way.
>
> Since it's technically a different board altogether and not just PB2 w/
> extra DDR. I think it might be better if it had a separate DT and we can
> decide the correct one based on the EEPROM at runtime using
> SPL_MULTI_DTB_FIT which would allow us to still have a single defconfig
> in U-Boot.

Syncing some internal comments here:

Zephyr and Jason Kridner apparently agree with me here. They treat the devi=
ce as
a separate model: https://github.com/zephyrproject-rtos/zephyr/pull/106680

To cite Bryan Brattlof:

	I don't think the R5 has the space to switch-out the DT like this during
	bootup. it would need to be another build

Sounds like we'll have to upstream a separate dt and defconfig then. I'll p=
lay
around with this a little on my end before submitting another revision. Sup=
pose
the dt will have to go to the kernel first so it'll be a little bit.

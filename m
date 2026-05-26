Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A9A4CD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 21:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A43B846BD;
	Tue, 26 May 2026 23:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="vvm4f9Sz";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="AQJKqrc4";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="opmBUySl";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="U7g44713";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E493C848D7; Tue, 26 May 2026 23:00:24 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EBDF84659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 23:00:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 64QGZhkn1320977
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:00:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=0FPeKXlTCNrB/l9Hi1p30ody5
 54kOsss1NvvaBI95BU=; b=vvm4f9SzGUKMBoujb14qzMPdZ2rFoH/urgrT5/vYm
 8vdNwJTK93n8tJeJbuwuBETDY9MKjypLELgI2qo6A8xr2dZL8Uq7m4tcs6lsS9zp
 /8REDLIcieKdkyEKFIh+2h5+MyIqbFjgIVyWCz6PYsB3EoE2xFGmkQwi2500Hjjz
 tq4jr8A28no2juNgctqrYQkXrdaWUYRCqzdyp8VmCLae5n4fbPeVipPJ5TQozQfT
 U704rVCkRNSMW7PVdCZtisMKfYUz3RoQgmC3FXYtAUXqbJ+XeTE9sDowk49tZnFs
 zAJkddRbZo7yuFIVLo/eUu4bXqxL+e/UKsZLrikOwOdKA==
Received: from co1pr03cu002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by m0482517.ppops.net (PPS) with ESMTPS id 4edf672a4t-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 14:00:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDrqA5Alz2wkKos830Mv58l2VHgL65ZELRbNDTw9f4zbHm1bHJ3uN7N3J0AhYgHHnlmECW6oXR9fcUlBj30kBW42N1gxv4jMbkANmnv0+L/xrsBpIWzDKjUDIS2Htppt5uFNnWybkmuQzplAoIluBqQKKdbOubZbKpJweed+BsDU+/YgcHRfAH7TJJpWae3e9MvzOyqjAxGhsNOJjj6vl/jH17vRfccDt5ixobwOgtmWNMP/QnJN5jhGUHJKPHBZyFKK960/QhD2YX+4jH6oQMghixqB743aKDt0o69C2F4+Jcl9JYUH2CZ1svxcVbO1gIcB6T5oaYsOCIoEVl/K4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FPeKXlTCNrB/l9Hi1p30ody554kOsss1NvvaBI95BU=;
 b=nSB/jJU9K7/yk5JeF0ygNj1KkEC8wxvF73rd2UqVSKNWQfTKScKcXAMzaPXJkE6Qj/exuQizz/CWCmVSH/Ja3LdV9jdTZdwpyJ6lQmNDClfvMFdhe8Xl0yiBXdExnjQ731rWUFA7ZbG/Ar7FiyoWDHF3jo+lJgnhYt0YYsg00G8M0JCQOXs0Iuo8RM2FrBMiSIHySSAHWYALD5fAfos8TtNuj6W2MoKf9DWDfI/iwqwtDydZNyw4P66dQzYkT94pyx9dHHWp5HNlaWGq4SVg/wsSvuiAOdJijRh2sYTbfhh5fYnMRasMiHLZzHidNtdOM+MBnGNkmUAUE0MyQG07VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FPeKXlTCNrB/l9Hi1p30ody554kOsss1NvvaBI95BU=;
 b=AQJKqrc4ccW9YT9Ms60ANPPixwZHYBu9Y1m3FAE1JjJZjPzoLCy42W4KiH3f9Jip5KcLb6UeQW2UAIaj8L2yqO7tiQrtZSOrPcDolBTtByR7Sb2UbCXCg9qehdna0TlssxEfb3vGVPSzN9Op2aaF3UdC0pUXyCDDKWLec6x1tJI=
Received: from SJ0PR03CA0232.namprd03.prod.outlook.com (2603:10b6:a03:39f::27)
 by DM6PR16MB3895.namprd16.prod.outlook.com (2603:10b6:5:2b5::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Tue, 26 May
 2026 21:00:15 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::2d) by SJ0PR03CA0232.outlook.office365.com
 (2603:10b6:a03:39f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.12 via Frontend Transport; Tue, 26
 May 2026 21:00:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Tue, 26 May 2026 21:00:14 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QJqJLS658002
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 17:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=0FPeKXl
 TCNrB/l9Hi1p30ody554kOsss1NvvaBI95BU=; b=opmBUySlUt0qx640B7PvS7V
 yGeOWjf6rNu1hrV7Kacywf2q2Wgeewzmkzw7w/9IA0OaeszLzi7FVABZyojJz9Yn
 xmW5Gtr8o+PawOW4oZMjVMg5ZvOWatV5aGf7C0bk+lJMexsd2badeQwnpRBC3dq8
 fOR1eKFgHl4tWTXWiDz6MaHkrjEWelHvSnE4AKyGHvJdLqKh/zSDRrMg/j4quhw9
 j6x+x4NN5aMwETl4dLB845XDX0fVggLh+V9TS6m8aPpqPkrObqEaafxkWgMw8Hgf
 yKBY3qcHoTlXNOqPmhqCMlyrT8Q6SM7HrIVrQYQ23259ZDNXZee3icmTejLBq/A=
 =
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=0FPeKXlTCNrB/l9Hi1p30ody554kOss
 s1NvvaBI95BU=; b=U7g44713TrVp7yUpS3eVZ/ZSa0El+WBBw5epGzS7QlJ4JJq
 i9fxfwD0jJub3Xx72eFByPC5zixtPD1rs/j+GMdiklc4/kxxpWCGWfUX/JgWXmua
 s0yJAPdnuKHzu1PkMMvwO0AzDx+tH+Jz6FN9nyqmr7IwjHOD169BpvNxZs9Dv8l7
 gPQ5XVyA7xb2OnjEct/QJ9eVT60kf+G2GWlHHYIb4aUNjZI+uSVCygoesfDLLvyr
 rzgFG1V6XXW3Aphr7zO6ip+dNhO4x+fOda0MxO8mVonU3Wg0Ht0RqWUHRlM1WInT
 otfuIBTCQnVG89OSj9HiV5FOkS+KbQ4MF7t/q3Q==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ebx4s34d0-6
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 17:00:13 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id RyslwEeyMvRqcRysmwCnix; Tue, 26 May 2026 21:00:13 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: RyslwEeyMvRqcRysmwCnix
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2] .gitignore: exclude logo generated file
Date: Tue, 26 May 2026 14:00:02 -0700
Message-ID: <20260526210002.1447806-1-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605130000 definitions=main-2605260185
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|DM6PR16MB3895:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73a7ddf1-dbd6-4e8d-a37c-08debb69c8da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799006|6133799003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: zKmoc5et9dYuCeNPhbrw1lxnJ1NK/aE7US/pFOyRMikrnG9i0mXpx+W6ylsKkIbjyPQnWkuCkwLyvItcps/hgQeo4OGJiLFnX5MFZqlOlXg0PF/pI4gpPygs0pPmiuC4IZ2HxxgnUMDOlLIrlO/LP19C5TIiqZZXUwNWxN8INYOi5W055XZQmXRbZtr8/N1DpcsrxJqPwBFnn26ZiQex5dfJEYiPHrBoseFjf5R8PmUywEHQxX3/5wP56KJAecIAJmyNQW1SoHytpgvDUnXM3q0M+RrFSeTUW8YO56wv9VV7QCb54eYCjdbPQQ/s9iPX+9Jz5RI7zj5rbcRuNpuutpiyey7/tgVkK/efaozMw58qxtyLaWKJaE5W75WUcBw0ifvmvFXNsxAvmhX75PaAddqY4o/lim2YD5PKX6A7QDC/kQEWe+BnyBPNUQC6oB+Uziy+jHLiqofiFrlsRaPTT2/jZKB8H8qk8aqNmRTqciVb+e9XBAL8ok8ndguIFodMJJlVTTbGLlyPuNhQ9R5ZTO0PGJsbRpJr+4lFHqThYw8vvKsdHk81jQx/qOu3lah36/9lGBR21GHAkFomrjW4ezVklOhWdfeE/Wva+IvHbqCFLMnDevquxiRTIrg5YmpVqtx/B3/kY5W4u6B7aRjq5ufdcFMNbgWY+497qVp2zXzS07LOzL6DdXeyqgoofegs
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(6133799003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F7JUcYgirAXSu2B+3f6E6+TRel7UZsT5kk1vFmxJZb/wXdH1HeCUl2wqu7ZL/HejpXgQHLEzGDM+vNVyJ3gJ1kDhVOTpZBsQGtooizOuOjXLDJeDiI0pF/Vyk4OtJPCGodZVGsLvQr7eqawgnbETRCMkXCGbGaM3oILncQp+XtnH3C+UHNpI2SkbJtIi1F3en94I4xjsMph9qzui524KmSJZtyQ6E78GMveh1w28Ok5v0QjKc6le4iF5HNm41IyNuDUKX+25gxrYK8WaC1Sf+fD4NKe+zBknED3YpYDmvMMweAr0XYyf1oUaYY+UdkhXeMqgQ+uaVhhuoKB+K4xVG+SFra/h4R8tCWx6UgCg7RagCld6IZlhXOwfQDQs45vWaSCooFNhz4LiAWdkKESfrhfjHUnpY77TTvlaTlhHRYwMmqhJeQ3WEf8Qemhr//7v
X-Exchange-RoutingPolicyChecked: qdiNlZhyicn0lCtOuAigB0KyvkXInMVcOQ1Lst5q1H3dy00oLmHMj/ZVJ1wVN3e9tG3EheFLWdyoH2pign0CQy6/bq6yT0TYL/x60KEGO7udtALB1QyAj56WDNEID8UiV1eDWNKNmaT6b7SSb99FW88XshTKUTtCCggd/qY0BDbuaOsdPCYdIm8Nmzh/XdQ7aXQA+fyUJLodmG6WWC4aD8E8O0j+jflkWgsF0huPtnEcEWHeVGMv+1tvJd8cwnkOQaCdnwE4tkKzSefySzPnKWEosg1M5N6YhViAlqyc/AnblY8mSd4nn2cd/FQFz5nwYFTDFq6uvtJulYAK3CzcBw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QncQ1Q7UNYpz0Y83CMGL4TqoOgg06SMXrU12XiVFMt6U182kbyN2TcQ4zrctdDyko+lII2SdI0jJXDwF+hWFrhPvkbW9hpQ3wKrcK7yjohvL2mI5bzXg85W0hS4p+MEwWWzT6kJHNgigEwjbg16mqaK6f7++LQ5VhlE89JIGZJiarHYb2hjDsme9sJ45eA/tlXGDV9D+uhngzt1bPD5AIuSwhekBpAa28d+r25lHLqyDfuUylPpdS8owX0xGcrQuhOgTTGukrGt4p8H8AuW6nKPGGH6z0Q/1tZgFsB0uF0Iwj19opydtuJtpSU6hNFfw2JlsV0DD2C/EM3w3132ekExVHFZ3WLqIIk+Jm25e8QRC6pyJifysB0bUxCv2RAqLWQR87a7SfBV1KnYXEyakCd0Ugy3CYidSCDsKbSFakOWMzHn9gJSShNfFjy3i3aA0uWcsMyODy+85sqciD19jfVzLTAUYd4k/jZWvMQuONpccThmshktUJHLrux7rtJ4f2GikzNBc+Sg6b3jo19me9ePIt79EOFsE37smrgPPiId6AfGVy3OLO0RmYO1oWBCjPmZp884uXtzTp8kcKph9A1sNcv79Z+WRnF2Dc1Wyoz32b+CVcE1tbgzCTgQhbDm6NB/ORzwRW+dtYBzY3rCdTA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 21:00:14.6821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a7ddf1-dbd6-4e8d-a37c-08debb69c8da
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR16MB3895
X-Authority-Analysis: v=2.4 cv=VsgTxe2n c=1 sm=1 tr=0 ts=6a1609e4 cx=c_pps
 a=VZSJMqPseUw/+4g/T0Awdw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=VwQbUJbxAAAA:8
 a=cbNQJ9GKAAAA:8 a=cm27Pg_UAAAA:8 a=9_q5yKCOSv7n23pazhYA:9
 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: HaVzlhishyHsGqBLBTByVEXF-2Fmt7wv
X-Proofpoint-GUID: HaVzlhishyHsGqBLBTByVEXF-2Fmt7wv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDE4NSBTYWx0ZWRfX9Z09Mb27HFTS
 dFB6HSQL9HCc/8vieumscQt6Hqc1pZ8I3wXRd71haQaPXKm9eUH+VSZpSRBTnwpnVipDBr/F8Yv
 II0BPjn6+eTLGfOZUuK2JA6bLvpgpdWASlIfnPXaxC38HuIBgcuzR0yrzddgg40WJBOjAIOkoB5
 zu8TAKQnNvLam13YG2NUmrOtRc9tx/lsOPjFz/HREt1nswcrgqsCU9UZEN2P6JuTchG32r6pamp
 zDzv12T4k0BWlFtWcAZLnPbeNt6Hx1CTyATINt8tsLTPNCMUe7pJgvNMbH3CubOohqlOXn4ZkJS
 BS3amuncoO1y8KIYACYDFuPUbziDlBg6JRfBRJ0+dUf+ln/PYwR06fyKr3ciLHsnF1tn83IWKy2
 X7LV3xHkmS8+A75jqn2YvjQHDVHYt45Yt1FhtDFa5nOYybUDbQ2HcPFF9A+gPOhtH3PDtQdD0O8
 STeuwrw8HVAoO0aD42A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260185
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

From: Denis Mukhin <dmukhin@ford.com> 

Correct the rule in .gitignore to skip u_boot_logo.bmp.S artifact which
is generated for any board with CONFIG_VIDEO_LOGO enabled.

Also, correct the stale u_boot_logo name in CLEAN_FILES in top-level
Makefile.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
Changes since v1:
- Added Simon's R-b (update in v2 is minimal)
- Updated commit message
- Included fixup u_boot_logo.bmp.S in top-level Makefile
- Link to v1: https://lore.kernel.org/u-boot/20260522024227.2950976-1-dmukhin@ford.com/
---
 .gitignore | 2 +-
 Makefile   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitignore b/.gitignore
index e5d22dbe8e96..d57d3be0291a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,7 +80,7 @@ fit-dtb.blob*
 /*imx8mimage*
 /*imx8mcst*
 /*rcar4-sa0*
-/drivers/video/u_boot_logo.S
+/drivers/video/u_boot_logo.bmp.S
 /test/fdt_overlay/test-fdt-overlay-stacked.dtbo.S
 /test/fdt_overlay/test-fdt-overlay.dtbo.S
 capsule_esl_file
diff --git a/Makefile b/Makefile
index f07faada3d54..45b5be6317ef 100644
--- a/Makefile
+++ b/Makefile
@@ -2544,7 +2544,7 @@ CLEAN_FILES  += $(MODVERDIR) \
 			$(filter-out include, $(shell ls -1 $d 2>/dev/null))))
 
 CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
-	       include/config.h include/generated/env.* drivers/video/u_boot_logo.S \
+	       include/config.h include/generated/env.* drivers/video/u_boot_logo.bmp.S \
 	       tools/version.h u-boot* MLO* SPL System.map fit-dtb.blob* \
 	       u-boot-ivt.img.log u-boot-dtb.imx.log SPL.log u-boot.imx.log \
 	       lpc32xx-* bl31.c bl31.elf bl31_*.bin image.map tispl.bin* \
-- 
2.54.0


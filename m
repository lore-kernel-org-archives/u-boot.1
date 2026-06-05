Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F4CCD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:59:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFE9F848BC;
	Fri,  5 Jun 2026 05:59:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="uTLflw84";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="R8NkujB2";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="hLVIOgmt";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="AV5VS+xv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5567A848D8; Fri,  5 Jun 2026 05:59:39 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3B418489D
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:59:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654L0qNW1818148
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:59:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=JVAu43WWD/c4bXZWY6yKVFcl2/0
 91UtzlJeFKCLPDks=; b=uTLflw84Ehv2xiGIBqKy7QwZk3GdOHt8yQGQJVsxk7f
 6WTqxWZj2HdHd1TNpmOFToHZ8jpLp7xpfc/qL1s8wXYPpvGQfMv7iG58HXu8txQE
 1vS60GpjSRxgKLsbvgXCxmDCMrSbRk7xZiOLpSW9csSkexhA5ND33vjPz7Q+b59b
 Ybo/fQk5GGKSgFaNCLfDoalGfCIQQlf7Dy/IvNSXEB+cuBZ372jimh6+TnDbMTmr
 85+Yz48A52DXjd8ZdXa/ny70sif/OBuVyq28MGnzgSL4nPGLOK7YDfArPBuF2i6R
 lxq3Xm7twF2CD/hZ165kbt4U5D4wxAzyMjgdswBVacw==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011005.outbound.protection.outlook.com [52.101.52.5])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekgwf1yva-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:59:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c4QshPinjB3kdOxqcDoQx6jQGW/+wkCMZQdKz0nfryUjm/1AR2prkLuD1JYKt+L8eDnAaGLBMVm776zThCnKKyuZiQmd1Iounopw4i7Jj0BTkSxpoeeGEyMnsSDOYygvp1pJgc8q1EO4tn3rrglJ9WMjJtmvbwOBmACaYBpdcDHpcytTh+7d5U6HaZXtIN8H3cqEQQzx64/O9fyWEIx3tufuR1BPvGQA6z7PgM1BhCglrAosTtDZtG/fzfhODZQI5hJZ9N5WwviyHtkyI0u+u+3Xltav3hX/VoRtiRBA2PjtSQb/Mvj3i3NR5bt8d6tyl6lWKdaWeT0RpTK55azzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVAu43WWD/c4bXZWY6yKVFcl2/091UtzlJeFKCLPDks=;
 b=cyvBdbJnFgFa6/s1eDw0Ota8UCQBL9U4wIMY+PRXF0PRf+vNGyDP6TZe87zcgX8tcJtKFY903DdR4+oc8fpxm3Wska+aKRGpX7G7MKYHHILl7UptMTQPtb4BpdPtftaBtD2uatrAM2eRtvROJh25Vd5BIZRbusYGbGFf8n6xVWuQ5kEUbDjsg1lNefOp292t+p+ZqJKNqM3kZsj4cqjS84ypKuQPJOhGiAnVlr54P1TGKHXSzvnGVLWnf3oaJrmOxPGs/H5qkImWqD3zYI0yhhBBKfZK0S5pT8R55dH+fq+CC7GtbkJFoh1WYPxHR/oZf1RZZFRutecYIlsoxeJjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVAu43WWD/c4bXZWY6yKVFcl2/091UtzlJeFKCLPDks=;
 b=R8NkujB2+5WBWT0Lkl8kY2yxWMdDXMsQt/Kj65mumIuGbxQEE+lefaVpv52ze+thnNXn3Zt+ZLtF8JeKlHkM4KQ3tvv1fFNQXjWtUf4IQFQxI33lvzFhvhyn3KbpsJLSt3sPgZeKexgIKfjXiK3YZNyi1c+uEswTInK/vEjhoY0=
Received: from MN2PR06CA0021.namprd06.prod.outlook.com (2603:10b6:208:23d::26)
 by CYYPR16MB5507.namprd16.prod.outlook.com (2603:10b6:930:bb::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:59:31 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:23d:cafe::9c) by MN2PR06CA0021.outlook.office365.com
 (2603:10b6:208:23d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:59:31 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65531XNH034326
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:59:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=JVAu43WWD/c4bXZWY6yKVFcl2/091UtzlJeFKCLPDks=; b=hLVIOgmtmF4s
 uyj7n3QeWCVlASbVrgroKzIp+oKbZ4mxQ3TcWn828QHXKprGQjZdL11frwh8FDHE
 LkBNNFUeQvYveJINfyY5GVs+zShRhl2JqTiY7sD1CfSUYIpznMsiJ9QyYdBcSRwT
 Q8uH1SVEI4e9ljdB22QEFADvjD/tRAsuFA5KSVM+AqgBPWrkZEFOZP4A7bGVmSin
 mPoXRfrMAW0BuZAO1k9tCdExGts55BFB0vXfD+jTajgabdwfYJ3xlJS1gHZbTVwy
 OYy2G97HMDukyfnRnVvit/lnYlgvU9r8+dV07IMSq4Du3qwNiHSrBwRQtELRSmcK
 8fm2/IjxwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=JVAu43WWD/c4bXZWY6yK
 VFcl2/091UtzlJeFKCLPDks=; b=AV5VS+xvgrR1kshU/uGujLaY6anACcXT6xe+
 qwPbFrh+tWO/A2WzVSaOtSqBUhuLk3N9axvG4/n4FElOO/OqR+iJ8eGmYsvtn1as
 3yGD0rbep4eIbGUyboKeBeKKhW+D+YXzWEWl50uVgwLPYYR6HeepZmrdKLdtpkzX
 fGCfIPql6kY0o+Y4NVoHtzJ4RFHaQjkFvo1IqKW3lsvc1HfywX4xhVch4rGyJock
 QFwiHPYYU0y2Br6T5rMH2zTgLnYxK3P0sFwhNV83POvL1+7wLiQvMROOZjj5U1d3
 gqnt61aTZjx0I/evUTj7EzYUEwDwoNEYtPzhKI9Tko9Efi1ZDg==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eghss99kv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:59:30 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id VLiSwPncHbrKTVLiTwcxSv; Fri, 05 Jun 2026 03:59:30 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLiSwPncHbrKTVLiTwcxSv
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 4 Jun 2026 20:59:28 -0700
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, sjg@chromium.org,
 trini@konsulko.com
Subject: Re: [PATCH v2 0/6] nvme: few fixups
Message-ID: <aiJJoBJK0B54Zomy@kraken>
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <dbdc5f45-b4cd-4dae-8cf2-5e6172d5fc2d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbdc5f45-b4cd-4dae-8cf2-5e6172d5fc2d@linaro.org>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050034
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|CYYPR16MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9e460c-db05-4837-ce3a-08dec2b6d923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|13003099007|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: K3paXlb9YhgsnvFDDYu0Wg+EsN9ZElRxdJlgFdg5ffn9VlkQeYUJkmu4TgpYRUgcjZ5EZ32yA3j36P4/lfxB8XhL69MPxAypmwOUlykHlWWKu4e+zThdv2qw72W8Cgcp4cf3wvuSEn6Q5UdKBIf5VTGxe4YGrPFqaH55GxyoXoXavrpcWaWsqEXPPhnlQ1iG2zC6HkBcU3j/r+QX4GuUPRQWX4zOqW7J9egqbe2TjbL6spSwwKCriJ5/3ge+c7Cr8JqsweDeL79//p/y8FOLf/U8OXTPf+B/TEHRwAJ0YRkn6V0S7dUbPseZ++Zs/HsXXHohn9zjymxNtYf+OtdmiVlNQVtM2ORS8AhD1KRD3arbsq2zmzt7zrAaEFhUizT41qSdk4jVkvqy0y41i/mMLbrprsChHyzKgwxk8gkNZAodd5vYr3ttWUM9yDg+oWwcuUWeujXpyteZLz75uNu7TfKliZ2ktXUShur4ERYM4k3Zhbocj9LrVa6DvhBTtQyUYz3x1WnDkzeBwM3kOhvEvI9EgZand7v0FAt3lx/N2PdLfDmSXElkbJa0rrV+KPgfF5GUPoLQ/cHL/0zUrQtPQqjPNBACDRAknekTQ/RSQf4p/EwBKBdRjz3rySGbC7eRNXqDHPkCyHK2AtWRqD7QlnF0HHlnIxQqWA3MmRjc6bXDsnNWQrPxi/BF1YPPsYY6FUg8ck98JG3HRwOHXxRjE7jitEkcipfOV1ced4elAXYmNKrRvPnmI2Uu4Xu07T6V
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(13003099007)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ++vANe8CGA9k1MUGtRdnbjGxJdSqq98osI/oC3A4zy+FZp4FfjlEw0wuMRTUzs9vDJytrLPkYMgbHUbdEmgqBbnsmPQxo+On0OYSXU0isCp7hS2TDmXruDJeanipuZxySAu+6p3JXJDqm7SjX6qZQzamY123VM92piLbGQOnnMuk2nZmuim1WzIh/aWJwtdgXN71UbGTYpeWd+CbfSxowK7vz1sGHebgfpF+eLNaS6IEAHeg/4VBlti+bfNkCV+PqRdirFVFziiEVSI66izJOit+C/zzAmg+yKVAItwyySPpx/bKXe8ad1Pex+9h7HR2iz4UVvsUg4Gmsn51V5XUlLC7KpNgfMsnhBy+cnHSlHZYTvdgCKWnxmGrrKdVXMcGtXvDdaZHBBKBqD7NrdnPUPYFpcvVWaKoGrGMov4AKlK6bqi4jBVsaYF7zwYj1wdl
X-Exchange-RoutingPolicyChecked: bGDVI2S9tJBwhrvKpulgaNkZyrywebshsx2vMLwwkBO/HPlf2A6HTHdcfeznMkmV5IlBQkOiRdyuAMrQahRGGUbuvRCyivh4hS7F203noHp5vIMA0/mmCKC3XbXd6kMbU3NYBOyLqDRKPn7Mmi77yewxoDOb+BmHuFNZfaQMMlO9k75IOYuT0hAuftm7W1BKlQYJdwCz01o0tbCNNQH5sw6qoObGn0QBNkoEWM6Re6iyaLgoD5imeFWc5ealQtvetfvd5RHGGz8knCcuv0C+NJO+XGNJzC4bLhOZDrcMxUtb8zC/GKYT40QxnZ3h82PvOYyLog0GVwUxNxGh1Aw6OA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DXp9ioehXnXYoATmyX3NAQmHP4gA/nqA+m1oPNZwMbp8R4M1aUnTN1JgYSwG25eHVAKJXVPIYE9cAwk3ch+mVQ6Vc3VoEi6JEP9GygLpSLjPj6qkoIogBXGyHQtACTb46elnFq2hwyhm5gnXYhz63/UFzgUYMn2K5Rvsop7wEJtHyLib1rjoOeUBhXJHZFhKVU4LG0lRRe5e05iko5ObCyot/6NctJEJ5kC0Wx51YGDrD/Wv5qga61z/I7PwqlN3lOl+KjzyRJadYe3EyvSgWY7Pt7Q6S8a0EJhnp0k0BMzQW88/42XU3vgLXbxzr0mya2ON/20Qtxh1O0w98J0VFzIhpXYE6xgq6arp1dmbEn6LXoL35D/5ae2OXAM7tB/pSHJ6YvYsHPdq2DuXN4A8WwZPxOtKdglMx5SG1sDPZbYLb23WKYAMV8JLnUbUdhMWIZIVTTkx8np/5DXjnwIFE8jjhucAoeArPmO8+zMYtYXXTzTNGQiEq+mxCj97qutyh4O265P4SGtCLRYebIlpqD9LIQXSBDIjIyfD+SvOw7eBRv326PwyzRaWzaK78s8NAu6sBD57YYKEBn73tN/0yxbZxJXVZ0fDK4HtE22ga5Xqx2Bkx6y0EHn0N4k8rKQC
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:59:31.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9e460c-db05-4837-ce3a-08dec2b6d923
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR16MB5507
X-Authority-Analysis: v=2.4 cv=YJWvDxGx c=1 sm=1 tr=0 ts=6a2249a7 cx=c_pps
 a=IFr6uxAXmWssV7p2N+XdEg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=cbNQJ9GKAAAA:8 a=AuoPO_6Jzy49DELy-cAA:9
 a=CjuIK1q_8ugA:10 a=P0bj-C3X3jJDpopQwM1U:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TzCWOz_VKaQf1YOgc38r8UAOjzaPHtIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzNCBTYWx0ZWRfXzWLe7yFT9VC0
 XeeRQFdU7TeFrsCQhFxVMR5HNHFIzbrv09sZheP0ZLyW1YXq34Fykz1iMWD+ShQJAsA5bTmi0tA
 TsfqBGyUHalNe3cTAdLMl5d2oyHhHYEIjbUxsxw8Y2nR6yAC+/tOKY/pk+rq+SHXfoOiq72Vfun
 sQcUZ7VNtFhKMm4sf6LBpXuy387+ds/Tgb3GDMtAn47clNmHjMKyNssl1pIEThvoA6N7mHj4h7I
 PMy1xB27T9BKyhbXTSTp1NzvV3b2hrDpA/xpyg8lk3IP0LkRAEmsbLYauFc4OZTi+varM4VThJS
 pTOHuJSnBn9msZD8I82Wkmgj6J649W5os4fXXgbslm9vz7qYQ9x28GdXNCOTXJ5s0GcttBAJ74T
 F0mQ1ZvIXq1XotNeWQTIMHKR1fOkjXNH8HgjhJLT9dzKLLIs7mlQCw2uBZiFt1lz2VfhVR5bLzD
 rXwXPVKf22FNPXT8/Kw==
X-Proofpoint-GUID: TzCWOz_VKaQf1YOgc38r8UAOjzaPHtIT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050034
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

Hi Neil,

Thanks for the feedback!

On Thu, Jun 04, 2026 at 08:32:50AM +0200, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 5/29/26 05:44, dmukhin@ford.com wrote:
> > The series adds few fixes for NVMe subsystem.
> > 
> > Patch 1 adds logline for tracing misbehaving NVMe drives.
> > Patch 2 adds plumbing for blk_flush()/blk_dflush().
> > Patch 3 introduces NVMe flush command.
> > Patch 4 enables `flush` for the currently selected block device.
> 
> As my thread on v1, please enable FUA or disable WC to be sure we don't use the WC.

Yes, sorry, I did not have time to respond to v1 feedback (just sent out
an email):

   https://lore.kernel.org/u-boot/aiJFzMdcCu5sAktz@kraken/

I will look into FUA for NVMe.

But I also think it makes sense to add flush to the code base as
an alternative solution for ensuring data is stored.

--
Denis

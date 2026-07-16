Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E1DBC4450A
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:35:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B1A684DF6;
	Fri, 17 Jul 2026 00:34:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="PTPJlhSf";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="BN9C0L7+";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="KdI+p/ml";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="PalcnQjp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FAF84DF6; Fri, 17 Jul 2026 00:34:31 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6A1284D68
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GK9MQB3109847
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:34:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=CNE
 Ljc/wpKqZoO5wyzkJlYGX735HJXe6xca6V72Q0I0=; b=PTPJlhSfq5XaqOMAfgs
 88qoylaF+vBj/4/oOHneMFYw7L8SUqbRIq9cty01tdnR+zx/b6LsgnMYgUgnaAYE
 VkHdB0MgqHZkGLGtV+uqaGV+vS+cKApUvbxNp2SKFBcO/goPmkM/1TOcIm/w6vNx
 RhOCU5cMqtRLVjvqy5mdm1LuStuycnP8tg9lBWnnx+uG7BDycAEEj2Ra43XKaoEo
 QjpEP2GV/f4+C0zuWPOJHS0emX7SWlWCbvGIQ9QqMWI8w5nNVaW10T9hlB+pFVxD
 WYeGo+JI5bEIf0S5psKeFByoyUKSoV9bvI7l4YxWv6JAJS9190OEJlxa+QMRUQbm
 tIA==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012018.outbound.protection.outlook.com [52.101.43.18])
 by m0482517.ppops.net (PPS) with ESMTPS id 4ff5r5saxu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:34:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SsWZ2WzTUOGvClq6u2QF++LGJI/Romf3RjlgKv7IFx+VUG/Vjd4eZTqV2NdjEWqAquizGgQ20ytv6hiRwRi8MtAiZUhj/GnYEyFTyJqfe+Za8OeU69HrrWmjFXNu7jwYC6ycevwgIL+LqbtShnXHFyKShiD79xEy3vo6kEbrnKhWEbpgsjsV3VrKCs+QA4LsSOH9KUId5w+LT7/1KIy33fGmVShRvH9ce0/gVtJTQYXqp7teXKPzZ7HaDTYpOQW/wP8odYzHStYh/5Bc9f5QedwHO2UeI6pKylL626LFC3qK7LpxOWjT0AY9eGWdyQODSJCKLcCxA1au1aMwx3JpOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNELjc/wpKqZoO5wyzkJlYGX735HJXe6xca6V72Q0I0=;
 b=m5kldh/ckmJYoeTzaaPEzov72CoLuZu4/AQ4RofZhzb94ZpohA4ORHfA5OH9kc5Z//NL1JiB6eTXMPkDdufK3/aIyvAEgUXPdOm4IzWmVX7RcrGzhuOSHRDK3TTvQvXx3HSlTeub8HN1pD1kYHQJtpHh5OEc1Mkg2A9ToO/VLXgfK0iKZ+3uPMszd9jl/APZ0zl0uKaNO4/hRdOEab9d3S98EaRhODPn5dmTwI7b1A5Yx4fINxdgCruqnqLNGE94/pSxMZ1MvWeyjvEALKRmrx0IOHz8OdR5AUTpF3zP8VMfMhYFvYCU9FczkMnvMzwgm0XhH4qgiEW5E8PCpIMypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNELjc/wpKqZoO5wyzkJlYGX735HJXe6xca6V72Q0I0=;
 b=BN9C0L7+0gvXQcJnHEPkfYCiZx+I6QP6wDNB74jmiRol2PEcorkqzyGm0bVMM95z7z98k6oU5C6HxhVctpeGVmi8ao48QkFryqVYyFgXwfkQOxg3b7Tv7rc8wLfTGXevALpoXN+cCZl25B+Yt7PCSi0GPbupWqx1WJAEqyfAWvY=
Received: from SJ0PR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:332::9)
 by PH7PR16MB6141.namprd16.prod.outlook.com (2603:10b6:510:2fb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 22:34:23 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::4e) by SJ0PR05CA0064.outlook.office365.com
 (2603:10b6:a03:332::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Thu, 16
 Jul 2026 22:34:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:34:22 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwScR148353
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=CNELjc/wpKqZoO5wyzkJlYGX735HJXe6xca6V72Q0I0=; b=
 KdI+p/mlXOKFUnOISlYNmBOUewgtQ8/CU48/C2oaPDkkVVw7BC/7qnLoDfjGCeoY
 Du19SNISxKtco4F+zrvoRCx1wvJw4NDHM7tC3GXfT5SuPXf4A53WBeFMdvzMOxKM
 Tkr6ell/85BsUnyStyE083wa6NZAgr/8Z37+dUQ8ZKkVbJ5j8gdCuJJ9ddXvBpCW
 z4iE9x1SV7yGcmeUjCqmUpsmpL5cG/eJ8O3B/fqU9RXuX7pcNVis9BbAefdSfFth
 1Omfco0kXmW7vTYumCJbzG9onXtNGLvhMTGs3503CnY4H2DNiEScj73TZD/bMVFO
 2IfC2dkFeWN4ZYpLynRiIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=CNELjc/
 wpKqZoO5wyzkJlYGX735HJXe6xca6V72Q0I0=; b=PalcnQjpG/e8M2QWcjpwQwn
 jTu/JOzKMZ75FIENlX/VUuQ3uvs8DevpWME+nb9qIxxhPI2M3fDi+QCnhy7HK5HY
 3ScWhJVBWAp6Pdsh+8mf2ycKrW/C7UuP1/PZvNp2d9tOKedWaJqqu0nbDe7Iaole
 9DoiCn5sE3XADDFFeGdCCxko1KBS6hj1Lt8kYqCUkCG0uXycD8V+rpiMY7i+quVJ
 tshw4nYuPWtOiE4+pGzoiKEoDanEAwi7BnoCZIKyDEFLGjbxOW87lueO0KC7lZG6
 MNCBwA7iW6Gl6/grCg3m1fbqBjRnNOtMstvfEm0r+GnuLoPamTMwuUU+MpjmA6g=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fc6pxxhmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:34:21 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id kUepwp5W9BiSzkUeqwGKu7; Thu, 16 Jul 2026 22:34:20 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUepwp5W9BiSzkUeqwGKu7
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: neil.armstrong@linaro.org, seanga2@gmail.com, sjg@chromium.org,
 trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v3 7/7] tests: add blk_dflush() coverage
Date: Thu, 16 Jul 2026 15:34:01 -0700
Message-ID: <20260716223401.378989-8-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716223401.378989-1-dmukhin@ford.com>
References: <20260716223401.378989-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160229
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|PH7PR16MB6141:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aad51083-62cb-4e28-dcde-08dee38a620a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|11063799006|56012099006|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info: lGvuJtQsluxQ5MtzMXQz4Fk7yzjUcLMDGsglWh6PNThSG6Ulmkf8aUL8d9BpkBCNdPYihKZcQPzsWK09aSJNvshAdlNAqduHvRJ7djg71FdFNNKktxpd1hAr99b0Md1JOfLjfATeHLD3N0WHvWcxEmxekrKUDQY/0F6w0IE0ohEADzo3oMjo8X+NUv53LVpM7RCqG5PWA8H6Lkb4ZgmVfisP5lymE6U2sw3gAf5JIxFqXf9tgRLdqyZdtPqnviT6on1+p+Y/VqZ+4FD9vm++tVjD7zexdA4/No62uB/uYer2nuLscqvgS+Zn72Lezi2C/0gJM9fnxMOfv4sZMNQjUlqY9jQ6CUaV5M0SO30x3ZffePpZjRDjkn1t1N7d1JA0kJXqP+FQbIxAt3fU0mrIj9DUiYgfX6Ci/712FmQTp1jgFgT6jst4cfIn5fntB8pcJ1GpxmtXi0juh+7gZXmDA8n2WS9C7HLLbFi9Y2+qKDkFBgsz4WjPIRvcfWHrbUqqQxfQs0YqaZ6xCAUznwyOAFnW64u2/tlO8YzZy5AVQlSFZHkDXmZli7fx78G4bGg9NmBIfZqhsU1EG3Vf7N/DP5HLQ1SelwEzRIqjcAgutpwn4Ixf/Dr2lwfZ0IcEeqivZTig0CHWkLz4jwGvXD38xf7ivSCVeZHvRswJNkhenzHkmfjZmfQe4PI1E9UtWm2s/EkUQjC7aNtskrd+nU2H7A==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(11063799006)(56012099006)(10067099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OZhc3+Y9iU+DUQEtub5VkDoMi+Vka22O54xhfZ4mO0r/iJAWCy+hKDg/hFbz9fSe73ycQXqeBrU1bBxNdoHLGDUpchcrSDoJFo7v0EZXMc3UPp79YajUrt8V2nWr+9GlCqxAc0soWkfq6D+5oJERnAZ5PKuaReOD0e4W3H8iSZZgmgVH2vFjUpxIFLTuLWR3RUj5oeQxi0aYQI6eyPuxKCiB/rs9H/RIan44nF4A+L4xkEhhKVLSAY/lUthvJJcbBpUuJKRnwIn4SkqvCkDPVtWLHOyMRWb3HVBcUWXNrIrpClOar1uT2+9zyqdMpDGI3f/na2v6E+D/XUIseso58RRSmHi+3BXUs+gR5+7psm1Vuw3Srb3CMWRr/ktYH78od/aXLNtv3Ij3OtuBFnx03/hqZy8GzBdAp45PCba4EGZvP4putXcSNV1PZngJ34nm
X-Exchange-RoutingPolicyChecked: F81sjfUDbyE97xwCTpzGgDZcG+zPZQ9TOCDSWuA+O+mWrfEN6bkumOF9IatssTtTUUfBtt5uyeVnqhpRrfLd5mGeih8/DrD77pMc92V1lg7oHbmtTh5DYOelgpU8C++bE56vHsvyQyPvZ0R+BSrtzvM/eKOUVUQJRA1LeC3paMPQuJX5rQfLnRL1dxqNK7UKMqvIqLHK6wofbhSQgmmVZGloKuBTa3M4X9NVCoJiFJAiq7xQRXoWiDUaODR+/IjuskmT4FQliy0czkxvFApIINAhGb9yNUpgM43Qv3+CtQN3G6s0FtA40Hq5OEM1+sJRIjJNzLCk2DwL7DDqD1tukA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qE/czo85w+pm3KZf57SmQmAhKYz+NlPk9nq+ZtGMI6vyimJhQSvYnKrbOGS6Zreq80s1GSXpjyPQ8oPlbLgkVj0iXleJmvmVoDMuHqI7D1mkUSPO38Ik9fIkdtNqJPegAdMvcLpRAe9SAG3JrkD7S9A0W/HOTR09lHCIaCI6qCuv1/Ne9PqFRDU4pR3hvwcABLh4O19KgO9Ellhw4sJ/tsgIlxMg/aS2YCjfPiqhOjgy38hEZkp1MEJHEGW8thU4mqn1dZp4B96amgKm3/eMU6ynDuislah3qfAT3SyoUzuE7k6OTb9suss23WskqVY1pHrToZhZ6YJO4FSyYj3/IDqo3Hw/Ui0KucG9zL9ZmxXApL6GfVvDJrOM9PAViF/Oyw64a96nRqQpnjbEYRFp1tqIiBbtiGg0hJTHZ6/5dEVdrKn5zA4zXXw+XZmTjUXV8W0c4zclIhHF+GFl/jm4uM2d6vn/G0yvdDOaQOxSorEfyHGynGlIJD/o6B/onrCM7SN+m+XExCqTsqVFXhHyXr2gUE9vCVRBhCwTAa1maraK77CX9kpWEiMyNnzmX7gsjmUIqWt1XycilbaKxb+4+FP8RsPIK+chqPBKA1L5vlXLEf12ZLQ+bbe6+zgL8NhGuR6rnL9xX9zXzaXtV8jbKA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:34:22.1739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad51083-62cb-4e28-dcde-08dee38a620a
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB6141
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX9iHGPp6Dpoj2
 zuXVS60OBvPdYvAkC2/QPBor+xS4RRpFXsVUUKZURgafNnU9dXvmQgIq2X0IARWqadMGqmaTyIA
 +6xwVUTQ8NSMvwzlhHgSrbtiYIVRgwUxBVaeULymqlEd8DL/4LQL
X-Proofpoint-ORIG-GUID: vgC6VaWGnGTzzEPR7sIa0bH_-BacdW2O
X-Proofpoint-GUID: vgC6VaWGnGTzzEPR7sIa0bH_-BacdW2O
X-Authority-Analysis: v=2.4 cv=efANubEH c=1 sm=1 tr=0 ts=6a595c72 cx=c_pps
 a=aTmL5QNlyH7IpnOKEqsBOA==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22 a=cbNQJ9GKAAAA:8
 a=ymjFvN6OiDLLctx-RqIA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfX+4KdcnSuGcXx
 MYPpzSodBujEYm1i0YZLsz5hNTK3UOAK7+1WVDQQ2JTiyxfDJZMxOZcr9bntECKKvoT3a1F3+kz
 9tPB/1i7DNlwhWqPwGkr/MPosa1VaI72PXhhBX91pkIAHhf083XunNPxNX3oEbmOpQOOmMXebPj
 XxE/PTYhfQboLTs/mOtw7Nm+/bwX3hsWFgGcP3q8M2rUpLPBG1B0a2vz2/N9AEJqaUMve2BJADN
 KdESfEJXKOW6P3yUYr4YhGzyFQhLV6tmr5Oj9HYbjI/nMAH+D0ks0Mjv/QPsA7xjr/kdYAUYQsQ
 6NyURUGS/AG/nUux1XvxRMFUxxyD21wpQfUUZ6tJSZ4F0APl2gnZDwUN+D1HGWj0iELdOhJC0Gi
 dvHimo5ZSU4bo49J0QIZs+ZpWEBPsE2IB9Q9S02xaaZmX581v1MQzHXMbOr1WX98ECgIMFpskuz
 +MRPzOKPpM4HEl8n9aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160229
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

Add minimal test invoking new blk_dflush() API.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v2:
- new patch
---
 arch/sandbox/cpu/os.c   | 5 +++++
 drivers/block/sandbox.c | 9 +++++++++
 include/os.h            | 8 ++++++++
 test/dm/host.c          | 2 ++
 test/dm/mmc.c           | 2 ++
 5 files changed, 26 insertions(+)

diff --git a/arch/sandbox/cpu/os.c b/arch/sandbox/cpu/os.c
index e48eb23cdc01..a39e0fcab795 100644
--- a/arch/sandbox/cpu/os.c
+++ b/arch/sandbox/cpu/os.c
@@ -139,6 +139,11 @@ int os_close(int fd)
 	return -1;
 }
 
+int os_fsync(int fd)
+{
+    return fsync(fd);
+}
+
 int os_unlink(const char *pathname)
 {
 	return unlink(pathname);
diff --git a/drivers/block/sandbox.c b/drivers/block/sandbox.c
index 9cb27561a97f..f7e854fbf982 100644
--- a/drivers/block/sandbox.c
+++ b/drivers/block/sandbox.c
@@ -55,9 +55,18 @@ static unsigned long host_block_write(struct udevice *dev,
 	return -EIO;
 }
 
+unsigned long host_block_flush(struct udevice *dev)
+{
+	struct udevice *host_dev = dev_get_parent(dev);
+	struct host_sb_plat *plat = dev_get_plat(host_dev);
+
+	return os_fsync(plat->fd);
+}
+
 static const struct blk_ops sandbox_host_blk_ops = {
 	.read	= host_block_read,
 	.write	= host_block_write,
+	.flush	= host_block_flush,
 };
 
 U_BOOT_DRIVER(sandbox_host_blk) = {
diff --git a/include/os.h b/include/os.h
index ae3ca6d42a2a..13c7651bf537 100644
--- a/include/os.h
+++ b/include/os.h
@@ -90,6 +90,14 @@ int os_open(const char *pathname, int flags);
  */
 int os_close(int fd);
 
+/**
+ * os_fsync() - synchronize a file's in-core state with storage device
+ *
+ * @fd:	File descriptor to synchronize
+ * Return:	0 on success, negative error code - otherwise
+ */
+int os_fsync(int fd);
+
 /**
  * os_unlink() - access to the OS unlink() system call
  *
diff --git a/test/dm/host.c b/test/dm/host.c
index f577377da6a0..ed55278a701e 100644
--- a/test/dm/host.c
+++ b/test/dm/host.c
@@ -62,6 +62,8 @@ static int dm_test_host(struct unit_test_state *uts)
 	ut_assertok(fs_set_blk_dev_with_part(desc, 0));
 	ut_assertok(fs_write("/testing", 0, 0, 0x1000, &actwrite));
 
+	ut_asserteq(0, blk_dflush(desc));
+
 	ut_assertok(host_detach_file(dev));
 	ut_asserteq(0, plat->fd);
 	ut_asserteq(-ENODEV, blk_get_from_parent(dev, &blk));
diff --git a/test/dm/mmc.c b/test/dm/mmc.c
index cdebb9551967..714fcd1ea508 100644
--- a/test/dm/mmc.c
+++ b/test/dm/mmc.c
@@ -48,6 +48,8 @@ static int dm_test_mmc_blk(struct unit_test_state *uts)
 	ut_asserteq(4, blk_dread(dev_desc, 0, 4, read));
 	ut_asserteq_mem(write, read, sizeof(write));
 
+	ut_asserteq(-ENOSYS, blk_dflush(dev_desc));
+
 	return 0;
 }
 DM_TEST(dm_test_mmc_blk, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.54.0


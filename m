Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F333CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:40:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1019F84A0B;
	Fri,  5 Jun 2026 05:39:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="iFlhR67p";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="SKreVElS";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="GypRH00j";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="QThvfTs7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CEF084999; Fri,  5 Jun 2026 05:39:37 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 551FD848F0
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654Nb0Fp046680
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=x7Q
 Gh26MjKpxSmBvVT0bzLU55Q7bPHqgOMRcxQ5zwn8=; b=iFlhR67pIiEPrH+xctB
 12DSxT9I9fmGGQwkYrozTym8Y8q0/TUHoTBPTsyhQ9EX9Lch+iaLF02cS6MgsGJQ
 gqPSjwb5RXA06UKR/T1X/iXgDD+lyjgFP/XcERcRWdbKO6tK1cXUAAd+f3j4r4Rz
 onfvhneqMp5YkqZac/UXo84mN2ANjaGVw+WknX1ksjX+jGwTVnAe3r83zDuMApPT
 UGYMwZAC15JPvSA3FFxj4HgdJIPHmOqe3NNnpJ6NJ9XACbFJ4PllI2Ch5a9Br+ab
 juRWKaDw0mYYF58kzQ/3FTfld5yAD1GcoCYtuD5HuGJhM9V+1Jh66661qDUJfT+l
 vrg==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013021.outbound.protection.outlook.com
 [40.93.201.21])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ekk6k14cg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:32 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w0LCSi1R5Nw72jHPoL9jUNSrc6nQwWqQqVST/APWsD01NdTwD3OAdLTr4rhMWz6YwFt7VvX1NrAPBB3Msyjw12TEhFMPjv2rXfOk31KeK+fwa4kIkJD95IziSZchzkhBI/vMKVwz1RUHf4Zx8tQWsXBp7SDawLp7kLpEzLRXs32X3aKnqlbFtRwT3pK4DR1YYbGmqDkkSUvcNVlwKhlftuRLYw6nYLHrPzoVP7NTsab/rjUSG86sRrb1RThH1i/6i4jRAPThSsNZAl6BnoPQnC1dp+fDdQJ5OCEe3Mt401pnvIqRdzuiP6PLuByMdDZfQM0etks0x4Vzzf7C6T3RUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7QGh26MjKpxSmBvVT0bzLU55Q7bPHqgOMRcxQ5zwn8=;
 b=A0dv3Lyt34RzSr+EU/c/QfkOhpW70dCu5akb2UenAmpoyHJEFPhTxkC+gjszI2f3JxlPbUo7Pxt/d+psFLrnvWXCQ+4IcST0uwcLR7UhEBATWclxHIZahpxs0YOvV7lUKfpgLNt8wiB25gvvyXKq2At6DUt/CzjsOvsRhl4918r0+6HvlRm3zNQvF+fG3bIAGJUuWiHZ64I6o1CnuL0WJMcM0DvzNgRCnZ5nTplKCb/m8+0C6AzoHKW8gvO4YTezFf72VEYsAu+80vs5KpanaTvb8/7ufnPz4k6a9+iSz1ZAApcgMI/BjoHS86oPLxKv3QlZVOXqIEEO7nh9tcB+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7QGh26MjKpxSmBvVT0bzLU55Q7bPHqgOMRcxQ5zwn8=;
 b=SKreVElS9GUBitVCmrb39oL5jEfNu2vyfGHgOsUU7AQ9UfVeWQsUjXtB8GgFuJ+sX474SCWzhO3cH8jwAuvrYo5/2qU2tYasDYHU3gEdiSv6QFnjrstVqE7LLcGX4t1SsK2XiSLVYfXaOd423zx6iFfZgkObZhqDCU0J9ii/rF4=
Received: from MN2PR07CA0003.namprd07.prod.outlook.com (2603:10b6:208:1a0::13)
 by LV8PR16MB6444.namprd16.prod.outlook.com (2603:10b6:408:224::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Fri, 5 Jun 2026
 03:39:25 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::3f) by MN2PR07CA0003.outlook.office365.com
 (2603:10b6:208:1a0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:25 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6551cBZb098767
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=x7QGh26MjKpxSmBvVT0bzLU55Q7bPHqgOMRcxQ5zwn8=; b=
 GypRH00jL0QuW0yZF1bTRdTOB2u1j9MFtXVMXt4/tQzNQSa4r50KP0+XBAw48tWi
 vdt/FTqZBje99Vn7Sbz+Gd1TsiQI5gyNgM5z54ZQuPqRqKJoXlPeI5fe5ky1Bd0F
 27dwidOHgys6ms/UQMtpOP4IlpJ576TJJ/exIcJdELTVXXFmgPJgEdEJHfTOfXQN
 NzDkknT7epeNO23CxGw9dRbVH+zT+WxvmfaopZChqJk1BsyMZbkRzQ8fxTbThRtW
 EoED07h5xly7P2df4PUV7avhgLHFIrikyicfPF9e9dbh6gPk3tF5uEcPb2CjvAhy
 eB049PFjbS9J3Y/AX/J7lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=x7QGh26
 MjKpxSmBvVT0bzLU55Q7bPHqgOMRcxQ5zwn8=; b=QThvfTs7RVNApaWK/tazBAA
 TNcwTkevbIfTr0dtoa191idvPPaGn0JKUS1C/B2XE438KT4RLWS3vIC/cK8N2/a8
 bY/3S4p3HfEOBsIfrbdyuHCg4nnukyXdpnEMAqQK8AC1Pzid+RXoDEUf0uo1Vj0U
 92JYl72Ja7bIYQ8JUbHEehFSTau1eEI//+yioApNb8mnqXj1TddXLvb9WfASsPca
 AZXkBNoWRXY/4ENXXvNXO5allRdLB7AOmEA8YUcxUOrnN64fohHibdvpXvZ+HHc7
 T0y0F3pYU6v2H7UN7ljzhh6LxQqcZiro23gVU5yH8S3waEYZHt/bkOvS5zKI46Q=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4egeh8hch1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:25 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id VLP1wPvmrpgi7VLP2w7P2A; Fri, 05 Jun 2026 03:39:24 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLP1wPvmrpgi7VLP2w7P2A
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 6/8] bootcount: gpt: introduce GPT-backed bootcount device
Date: Thu,  4 Jun 2026 20:39:05 -0700
Message-ID: <20260605033907.1909319-7-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050031
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|LV8PR16MB6444:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d88ab15-5990-46d5-0430-08dec2b40a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dTP8txjY0smfdQ/YX07oJQD4dGkvOhKjcbUl+RXeCGzoKvPER+x31BveRvNXQm9AYkEvBu7bhcP174IcQCCs43/nMBgBI9NeHT5idFFaTs0HDiWSbZlJo24bo405YTWjotYHTcoTb4BkGPknAHErmNdhl+CX1jPkAtMx2RpuQqFgbHQVq2XYdo55+p3zBKLnVMDxOFLDNKkiYdYTeUEFwZnnYklKt6WHDfICtU8n03Xs95AN3dOyBcMfGZ+ttDI31wBJ8BlNhptS4Z2oyzIOKpXQ1ihFSZIqpcDQTxLJbnS2flZksxkbB8+SFUYG7FEio5px52GcFzNCpu6EuloiV3qXNOp8dV7fPvyC62GGSpdrqAbkwi4eGpSARq+EhEsiLvfgPO7Mgq0Z7VKO+TeJB8ss9a0ojLRQXr8Xtg2G+q2qv8+1Y2PKzDbyxmvX2PlkX/rt0sELs66CsSG67TqAKse42Kos+AZ2nxeA0GVu9loZbKKetY0ePJd9ezu+wotTFZ6xUo0RGXRONEzTxfY1ZTi6DXxemWGTyfciZWwRHCYiy6XUVH/QIZUPGV92+8VTRz6Y80xyXc4tbrHhD4bfqOPANT+WrfgRWfm9uQweJ1NReWsdgFz7RbvfOIt9JGzXs1IDP5CA6+A5Lc9BdyvI+a1ablgEN4pwIxKK0lYDO/wq8cqPUxbyKn3FnGnWcj6pTt2/I5aXiv4TQpk8+72mB/AAa9q55qFtvURq2xGO7I8=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BC4ZXPC6ZCY/Eb1zwNN/g1OdJ29omxWzdOsuPXat8gqm0wA2g3GOh4B6WqKifFsDpewiN1UmhE55xstrsKd6+BbnN8Ke1PtsAQuLlSEjmcU1G5AmAOf9Hu7Wrjqv60Es96cC/2EcndPRXBq0pKOFm3BWayGiWvjJt5jXP/NfsA4HulGTVFGnxE8Uz8tJsWsXPVyBjeRj65RSEP2rO0HALlqyid7Db0H1fv1LZMjBsyQco8CXODuuEajT9UBfdz1EJrUNrRgQmbvpHwPCb2izaTrBFdULcPVcevS9qwH/WgSq6eAL0Pu/qtTfiI0QuSbeIybdjN/1Sfww4SnTWpKd5UtUcJk2JmWB3hlOevSpDR0BOUty4eFTfaatDqF3f0iFx7RWq9YTnD1hXqlD1nfSHu0Q292V7zfn7lk8fgGWQTYa4jqhbgFye8ArQHGHek6c
X-Exchange-RoutingPolicyChecked: T7TwjCu5nVam1GseyFwYbCJuTFWwCXEARJx/MOyrC9WuO5mI+nGVbF++qiZrFygu6DlAe6hgQdxRQakYhXvMcB8j93Kb2gsozclaq63dRppptiPyQZrYsEBMl7hD+y21yumfg7KjAwVrO7sczS9h9aRXaa+5DGI6igr1onerGRrZbiFj8wEiKBS9obGQdFGlpfg6tFQRK81FZlN6ZV4oll+cFwrjC/wJF8fN5mf/aTbhnII1Dw108QRwDLYYUHyJSA162Iyh0TS/irg5EQFiwgj6G/jTtToMjOYTMEa1z15hz/ehto5PlxySzaVYhgersA3DSP9nLXEM43K8EqwiZw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +hOmRv72eU7bNaoqBmROL3Wh66wrneli0/bZjFH+hTrBTjdkGEOGA2LGhaNkzJwnO1TD48DeOuhP4AU3HJ12LF9N69j/BYtYggLCTHkAZkGtvADS0nHXvHElrltN2URG4L1xS37dkkn2n8RNr9yhomTiC2D1GFjpVSdomEkrlka4xCYTFH5YayldJ5aDA1rIenOhai7NKHolqkH+nJENEI8OLiUKlmPeL9Bj0cYx8NM7x8c/AliMMSJTuU8BnZMRLmLgou8a622U118NLYRUjF/9GOntysaGjDlXVLrf05PsDFMY+2Sigd9KiW/NFwA3YvWfs48HRVYmPL+rbk3JGraNWVZoBje9mLvlKxUH9apYlETMyDu7ry2Sp0Cg5t9cUAlv63V+08vO8zWnWjtbHR8K1yIjUvlyndHtxVbtcE6X/cMvZ7DUaCqYbYR9Oda5O9K9uEptNrpr9oVItayWGeOjX1VAOmIB9Gq+Q4Xeue91gC3Sna1bXrmcNhML88mq+UqogbvK/veIX8ndnQPCpd34XEr9E3nF32ZilqHqHMsRWA+hAM1eiYXh6+7HFEpb+7uFKZ+cYQrpyyDYSZTrnZYjHM/QduNu0zyzycczxWUK57j9I9LNzfxSDTt3fZEJ
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:25.7477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d88ab15-5990-46d5-0430-08dec2b40a72
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6444
X-Proofpoint-ORIG-GUID: COh3Rwu40_UmmKzlhUtwuyiXigyHCfCv
X-Authority-Analysis: v=2.4 cv=LoyiDHdc c=1 sm=1 tr=0 ts=6a2244f4 cx=c_pps
 a=j8DUK8/cuCuEDQ3LLq2Aww==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=cbNQJ9GKAAAA:8
 a=fCk9kufqSpNW_H5B4JEA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: COh3Rwu40_UmmKzlhUtwuyiXigyHCfCv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfX3Nnwja+lIXgL
 eKfg3CfcsFOkkBbSqmppsAyIOPLNz4Q2IRTno9riyFSsZmvNwPJ0azNp54+HfI8qWbLQKkGsxdQ
 2CEWJ0hQuwdpDG6eOKrd2aAIFiB5Ce4wCquAAlhqq3wBSUK1yM/foZZI/AJxpYTnSYbcXcIlx+4
 zT5ZEWvQjos+XP3Xsz/MoAANk5chyC91X0gXU1UGwcJSLqfeXYRN03KazxUK/4YprjZWYZ2zPfJ
 rlmGKOKDslhTuXHYGugOIyiorhAU9tNLRNOwf35ZlEsVDiEcsvn3HX/YxqFwD8A+DV8I2mUK7WJ
 ISYdZK1NcW4bWHtkERQWbu7UZA5vf/2PkklaXt3YTu+ETy4PhVrA86J396q7j5cDIC/a09eJDoV
 5mZvKtccksv71TcDN3ygMMgmp+gZXh4OVU6auEPFdaNL4a3O7SNh/WLE0EheU0ck3AIWwJ/0ipL
 G0YVro2JIjbaS+urUxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050031
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

Introduce bootcount device backed by GPT PTE attributes (bits 48:63).

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/bootcount/Kconfig         |   7 ++
 drivers/bootcount/Makefile        |   1 +
 drivers/bootcount/bootcount-gpt.c | 140 ++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/bootcount/bootcount-gpt.c

diff --git a/drivers/bootcount/Kconfig b/drivers/bootcount/Kconfig
index 4c0c8d89bb40..eccd610e3390 100644
--- a/drivers/bootcount/Kconfig
+++ b/drivers/bootcount/Kconfig
@@ -171,6 +171,13 @@ config DM_BOOTCOUNT_ZYNQMP
 	  Enable support for the bootcount API by utilising the Persistent
 	  Global General Storage Register 2 of the PMU.
 
+config DM_BOOTCOUNT_GPT
+	bool "Support GPT PTE-backed boot counter"
+	depends on EFI_PARTITION
+	help
+	  Add support for maintaining boot count within bits 48:63 of GUID
+	  partition table entry attributes (similarly to ChromiumOS).
+
 endmenu
 
 endif
diff --git a/drivers/bootcount/Makefile b/drivers/bootcount/Makefile
index 0cf79e428d68..927694979801 100644
--- a/drivers/bootcount/Makefile
+++ b/drivers/bootcount/Makefile
@@ -17,3 +17,4 @@ obj-$(CONFIG_DM_BOOTCOUNT_I2C)	+= bootcount_dm_i2c.o
 obj-$(CONFIG_DM_BOOTCOUNT_SPI_FLASH)	+= spi-flash.o
 obj-$(CONFIG_DM_BOOTCOUNT_SYSCON) += bootcount_syscon.o
 obj-$(CONFIG_DM_BOOTCOUNT_ZYNQMP)	+= bootcount_zynqmp.o
+obj-$(CONFIG_DM_BOOTCOUNT_GPT)	+= bootcount-gpt.o
diff --git a/drivers/bootcount/bootcount-gpt.c b/drivers/bootcount/bootcount-gpt.c
new file mode 100644
index 000000000000..d2bbff2ba120
--- /dev/null
+++ b/drivers/bootcount/bootcount-gpt.c
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#define pr_fmt(fmt)		"bootcount-gpt: " fmt
+#define LOG_CATEGORY	UCLASS_BOOTCOUNT
+
+#include <blk.h>
+#include <bootcount.h>
+#include <dm.h>
+#include <linux/printk.h>
+#include <part.h>
+
+struct bootcount_gpt_priv {
+	struct blk_desc *blk_desc;
+	const char *partition_name;
+	int uclass_id;
+	int devnum;
+	int partnum;
+};
+
+static int bootcount_gpt_find(struct udevice *dev)
+{
+	struct bootcount_gpt_priv *priv = dev_get_priv(dev);
+	struct udevice *bdev;
+	struct disk_partition info;
+	int partnum, rc;
+
+	rc = blk_get_device(priv->uclass_id, priv->devnum, &bdev);
+	if (rc < 0)
+		return -ENODEV;
+
+	partnum = part_get_info_by_name(dev_get_uclass_plat(bdev),
+	                                priv->partition_name, &info);
+	if (partnum < 0)
+		return -ENODEV;
+
+	if (info.bootable & PART_BOOTABLE) {
+		pr_warn("partition %s: legacy boot flag enabled, no GPT accounting\n",
+		        priv->partition_name);
+		return -EPERM;
+	}
+
+	priv->blk_desc = dev_get_uclass_plat(bdev);
+	priv->partnum = partnum;
+
+	return 0;
+}
+
+static int bootcount_gpt_get(struct udevice *dev, u32 *val)
+{
+	struct bootcount_gpt_priv *priv = dev_get_priv(dev);
+	int rc;
+
+	if (!priv->blk_desc) {
+		rc = bootcount_gpt_find(dev);
+		if (rc < 0)
+			return rc;
+	}
+
+	rc = read_disk_flags(priv->blk_desc, priv->partnum, (u16 *)val);
+	if (rc < 0) {
+		pr_err("partnum %d: failed to read GPT flags: %d\n",
+		       priv->partnum, rc);
+		return rc;
+	}
+
+	pr_debug("partnum %d: read  GPT flags 0x%04x\n", priv->partnum, *val);
+
+	return 0;
+}
+
+static int bootcount_gpt_set(struct udevice *dev, const u32 val)
+{
+	struct bootcount_gpt_priv *priv = dev_get_priv(dev);
+	int rc;
+
+	if (!priv->blk_desc) {
+		rc = bootcount_gpt_find(dev);
+		if (rc < 0)
+			return rc;
+	}
+
+	pr_debug("partnum %d: write GPT flags 0x%04x\n", priv->partnum, val);
+
+	rc = write_disk_flags(priv->blk_desc, priv->partnum, (u16)val);
+	if (rc < 0) {
+		pr_err("partnum %d: failed to write GPT flags: %d\n",
+		       priv->partnum, rc);
+		return rc;
+	}
+
+	return 0;
+}
+
+static int bootcount_gpt_probe(struct udevice *dev)
+{
+	struct bootcount_gpt_priv *priv = dev_get_priv(dev);
+	const char *str;
+	int uclass_id, devnum;
+
+	str = dev_read_string(dev, "device-type");
+	if (!str)
+		return -ENOSYS;
+
+	uclass_id = uclass_get_by_name(str);
+	if (uclass_id == UCLASS_INVALID)
+		return -ENOSYS;
+
+	devnum = dev_read_s32_default(dev, "devnum", 0);
+	if (devnum < 0)
+		return -ENOSYS;
+
+	str = dev_read_string(dev, "partition-name");
+	if (!str)
+		return -ENOSYS;
+
+	priv->uclass_id = uclass_id;
+	priv->devnum = devnum;
+	priv->partition_name = str;
+
+	return 0;
+}
+
+static const struct bootcount_ops bootcount_gpt_ops = {
+	.get = bootcount_gpt_get,
+	.set = bootcount_gpt_set,
+};
+
+static const struct udevice_id bootcount_gpt_ids[] = {
+	{ .compatible = "u-boot,bootcount-gpt" },
+	{ }
+};
+
+U_BOOT_DRIVER(bootcount_gpt) = {
+	.name		= "bootcount-gpt",
+	.id		= UCLASS_BOOTCOUNT,
+	.priv_auto	= sizeof(struct bootcount_gpt_priv),
+	.probe		= bootcount_gpt_probe,
+	.of_match	= bootcount_gpt_ids,
+	.ops		= &bootcount_gpt_ops,
+};
-- 
2.54.0


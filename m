Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08783CD6E75
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:40:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8002D84A17;
	Fri,  5 Jun 2026 05:39:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="hKbJKQC8";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="aDHLHFD6";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="NSqAVqVj";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="sfIHAoSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D3E084999; Fri,  5 Jun 2026 05:39:34 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CDDA84A0B
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654JZ4wb922932
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=grS
 bnl5vbsyC4W7n61ccdgiKqkn30Kv42c4bA0PnJAI=; b=hKbJKQC8hAY/gLgu3o1
 3t14U6uFknRtDobwBVSN0THbQcDd51nzW1+b6e8oemynEryy5dQgXzVOQfSSEZFh
 5DtkJQNkd2X7wSmr+omQU5wFRt5JjFbzLWRvybG4LpdaTNCHCJR/ghezmrQLsihZ
 6bsC3utgYl0eJV3iBFlWiD+hzZrvzNiFG9iagitVP5gDX/L661t/DHjQho9xqea3
 iN3hGq1iboQ9QHgPA8UHeLLA7FJDO/WKHISgn5Z/1klsRXhSPmitxTWQwCJbODVE
 aYEODIhOwk8f07t8c3UKQ2i/jUoVUmeqe1thj9M6fGZ0LKqkilUEJo3s4y16V5Cz
 HJw==
Received: from mw6pr02cu001.outbound.protection.outlook.com
 (mail-westus2azon11012052.outbound.protection.outlook.com [52.101.48.52])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ekfn7tkhf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:29 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqkRj2r0jnQADAxMFAvkmiiXCU/+TSUgp7x6DECaw9jchnfJRsU/X3tji06ybvWQS2GhVATH4I+HLhtjRVQVG/1xKTGLoNcKF5jEGRMBfRyR/MPWZqTPcm2vuthoUqO1A872Ohi0zD+7xtX33SN1v+m8C6XqicBPtRBa3xt7mQ/V/x/5nHXWrN0hRxTGRDB3+eLSi79nTgS6WKgti7P8eO2R16LMjR0xoDVbASSnWZFvfoGsRV4gdYmcAP/Y3TH8sV+tdP3QActMTtSor3uD5T5dnWemH7VUPyHCiSpJ/K0hJ+hAaQDm+pijcIaa2tMG8VmnJyJIXqCmOaO5Ndhv9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grSbnl5vbsyC4W7n61ccdgiKqkn30Kv42c4bA0PnJAI=;
 b=OtYhDQIIWD84QjxEVB9G//SiFJSxixtYCJX1BkVGBu9l/C8AKVhB9ohXGuXABdWGSQZPjwqg+gkNl815PqmV5TTjs1/+WEyMtOn4I2LKXJ5LDd7H5lkWTW4Qyf/nK3Q4FHxV2S0odwSSXy0KYivZTTICkRHbC1a88S00xNw6UYaLTtzKUxqCrNGYk2CQxNk+l9G2D/hezxdDLkqECwvzyMoD4xBLyBh0ZKkk7MBZo9SwcigsaurXi0iKEuA7uMsv56Wpo57+JyOwOtmm8DWJRhKH1XB/pH9zHM5qGXFlFzmU3MV2uQwf1RSC5lwfB6zAGY+ioUmabNFtqKiKw9DZeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grSbnl5vbsyC4W7n61ccdgiKqkn30Kv42c4bA0PnJAI=;
 b=aDHLHFD6dZysN3pJReO6B35E86MtpHQR/sz8F4FOkGItUYMlG0TbTcDDjW1EGWBNf9JCgvfS1JmGPS2ndP7Yn2U4ciaI5O7CKQKpSCiGIPrKYyf+42eOVkJ2CuljY0aYGqu9Fp7z4VaPw/J8LURBOtGgcrP1Ual7rqFzxs//my4=
Received: from SJ0PR13CA0048.namprd13.prod.outlook.com (2603:10b6:a03:2c2::23)
 by LV8PR16MB5733.namprd16.prod.outlook.com (2603:10b6:408:1cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:39:25 +0000
Received: from MWH0EPF000C618B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::6d) by SJ0PR13CA0048.outlook.office365.com
 (2603:10b6:a03:2c2::23) with Microsoft SMTP Server (version=TLS1_3,
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
 MWH0EPF000C618B.mail.protection.outlook.com (10.167.249.123) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:24 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654NKiLS035127
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=grSbnl5vbsyC4W7n61ccdgiKqkn30Kv42c4bA0PnJAI=; b=
 NSqAVqVjdeu1s+asQB4L0h6uIE7P3G0kPzTBvRgMA7IbDmfdOn3E09gKTrIPVWlI
 G6PFRtykgijIQD6gZnDaqGjMyYMUayUxD43fA8tNkpeumoBu2jjF30BQWh8+JPFk
 HpTY4LYvVXY/BLPTMQ4vM6Jf+/WPTi1GXusPFVGcEGlEYjla0U78ik/AVToQwcUT
 bzkIXshvQwLemIOnGYOaIECx7yAbaUBKmo9svPDaqz+IG8nHvFcL0WbveKaOa1jZ
 b2MBCmkesZ9z/FZ8lJALyWw5kYkgKjezeALyJzqQLDCYz96bFv4IMjGL71NDKM5R
 EF7O3b95l2xQbaqPFW8tag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=grSbnl5
 vbsyC4W7n61ccdgiKqkn30Kv42c4bA0PnJAI=; b=sfIHAoSgMZitxUpcEkNJdWX
 23jp8ZSECvwg4TWm/iqocUU1oKj3KBcQvEDhFqk2Je9uWqELfugTaRyoLLWENA4P
 lPGhAQf4h8pEByzUrkPb5KLFtvhNVZ25DB7BFur7VeR7ijmG0r5Yp5FntInMbUhB
 b3B+yzNEe6QK5lmaF6iq4gVhMJPeHOdZCnIKgeidn7YpCoAhldpirrKkbhMyw8Gu
 1Jv+IBkO47DwtLNRfEewiclUoZZY+gecldxDGM0BHKTMc0aRvB9AE3cJwlf097wU
 QnK6Wb8hIQ5Zw0CJQdFvG3l0nZh2grLf6oENM/9QosMGW7tBOKfnrRAS7pweqxg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eghss9922-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:23 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id VLOzwcwnDYPuRVLP0wJZWb; Fri, 05 Jun 2026 03:39:23 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLOzwcwnDYPuRVLP0wJZWb
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 5/8] configs: sandbox: enable GPT flags extension
Date: Thu,  4 Jun 2026 20:39:04 -0700
Message-ID: <20260605033907.1909319-6-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050031
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618B:EE_|LV8PR16MB5733:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d8870c41-7fe6-4c69-196f-08dec2b409d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: /Nmuy2X1Usy+l51kGc4pi8mrClu2EcBpPjShF5B19RfpqjIm67FIyfzFcJSubjV8ukblZpjsmaOpERwkX+z0DelkluQ5v6BDg/Tmge96Fr2iTi9wMyPFLZF373cyA1O6hNMokYqfKF/bmvEcBR/5LcGKjwQ7+hvQwXyCPAgNe5RnxrCpIKupIWt+JbFfc2/dkGoniE5SoKWthyUKExYw1OM1kkm81JWx+4l/ok0W2bEz6iz/lVJ+6iAo2w2rFPOlMkJvwg9xWICSLYJoU8BZ4h1jyzzL0WGkxkrqKmXmAt/uY8AEYrShV1ZPSa84Xo5GGou+Xtp25JUba0JILSuf6x0MQQ6XFFcLW0dZw094rjGbit+uDJnHakMIXH3Xd7qrA9FeFMzFoMpU9zirCRa5Ud1p0ktVTtuM+tedK7VeeW2G0RFmNyVy5BOjMGoNjT9dnDVZPeuQCNLfqhUoMWa6L/8sgePmFR8Dge9U6hjdBTAvyYXBHeIZq9x7NWJTQ2iXUSOqV6dMQdbyI6H90jIfoygkpjSA4gxQRcD7QIrJkP6IMokTpVHAL5Z9BY6RbIFGfAYEQUFdf4njycqhGBXuUyOgDoCKkGqTUdt8MGmC7ymASRznsZjk3ePtmsPhv8/Kj770KKT7bTh/8rso9ljLbEDR83ECRhpZghdO7W5E8mDRR2LyFpOei3FDwB/swKkhJUhu0yRerRocvpcczqycR9Cj28z3r8lOG8fA9njyj40=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LVJAWGuxYKmbZrds2xLVeB7rZ5KWRoI54dB4GorVMrvV4TzrNNNjIeaCeQXRK9R8mtsY8Ca0EWjhUbg8cnsIoRaTFTuDHv6oa8AJFZ/er7ONhiUkAQEhgo7rufYORKSmzo3CEtgksp6BAnt7hz9b087XbH7gJJfM+cUCH+cd/uGIJoAVIt1+5XQAK+qFCRpsiWyTzyTDbUsnZ6wjpm++F0XL27lZYE3zqxMDXQDheHZdkb0SrKoZ5pMMPe9HS51U9x2SrfbqHfTG12LDX977sDFuGBfk87zuC1P72tyVZfCbhebzEgOdC1xFc0/A++mOZ3bgZS/c/nK8sLsL3J6NCTRjDwHSve76h9H/ufDrt3OmI5opZ41tLfTN1m517oExzBkU6PeDD8taCAMPoS2xIpvhH8A8hh7Gknm6sAV0s0mFAvQv6WEUCR+P+IwwwHZk
X-Exchange-RoutingPolicyChecked: UXadpW6ilOGMCIm7vb7KwhHCL7/kz67WLhzEdA7UIH7EWF4kPVD4hAa0JLNnNViKEQhM8WrZFdBZlNxe2Z0TVoWKDnCsZHize4eLrGcoJR7T1KcEYNbFlLoXVAT7oKhYKsciaXHewE4N/QAeCzxNmXUNIG96wRt9wyYVA6fTsgnAQ9z3/FN0g0E3YYgfgmpMEdXfmp+CHJUTK+DHsFxanorPm6M/ujJUPMYfM2eErv/h8tJxQZVjyned/2l1g6pLnIWsHrDVBRYNIaMZn9hoj3lu7Eo6ycn44vtxdHWzM77ArS8fRR8If24yRtCc81YMbvSQsXM9ASKRw+w/qPzHUw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: p+kiqptCBG6S4WI8okM1C/Czn4MIviXZB9CNde1PTOFHgEDilRzLdI+OlOSTshTgpkmJ4rxfWuEFUEgQhkLPT6v+xAHqI70u3QhbfpWEPcSomXNN6W2E1zs3tDDk8vC7Nggy82VepjCYSE481wE5lBoDZ7fFz0QgkZDmtHRREhm83hF49vT4Bq/A6WqfcdRXhL1S86CnuOeJ1MvszL3OcaeMoMcgebtkN/txJ/sKTFf0E6VraKjq+CVAkLEDSQTY90Da7YMShZRH+Ts0dtAp4m3xPMXIIrzUVra8BebCogLCNwKOHeoMAOwcp83VSBtX7U33o9FSfxcdtSd1ICx7C75BKVsbbaTK4qIyfix9kxAtGXC2DDH0HYn2+77Zc6Dp+Mhh7xaXyBeHAcdoGANF2c0o9By42i02zYKfKSsHfjLkuzXaHG+NwwDqUVGMXuvDyIW4hhMgjQLngbtEdQeGRTl3JYHZiwnfJbTppZQe8kdiRQybdJPSzDCn+xY0mwabfhmL21LDb/XAFx+jO+FSaiDS+K8QIJrHSoisiFVYPXR+N0KIJ625lxfmjf0v61fq0Lzv+nusfpR/nc4jMo8womF6qjXrFw7JP91jPAj2rY0ApHVQ9kA+/9OeBLTgK25h
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:24.5743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8870c41-7fe6-4c69-196f-08dec2b409d4
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB5733
X-Proofpoint-GUID: SaJPnINCdKl2PewmAPH7uy4D9lLe2D8x
X-Proofpoint-ORIG-GUID: SaJPnINCdKl2PewmAPH7uy4D9lLe2D8x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfX6tCjQ4OZiI8S
 yyLloKz3tGRv02jCnkXE8M9SRRnrkVlZbUGSfuktEtjto7+9e9jhXkHTeU3TPKDrJgqRHfgr88S
 ktIVlxd12ZSTIZrGK6kfUSguicMYbnNlHef0BWASsusIrP9e+8VsX3shP5OykxR3lLbq4bTwYfD
 5ZNB2Od53PC1ruTSqY/wK988mmN/Db16tna38YuXGtRT5nW1q6hzeKKVb9vOwGkpTxjhKO93s5o
 BAZGyLU33PNMlYJ4VQmdrXAWQAEAQ8hWtCSlm/qw9ilMSKlHzPXTg//Box8etTtWrdFGd9+yVRb
 UXfcMXiC+mtREHe0OqA3+VZo6ZzmcN6ORQD9P1NKr7rpFpt0n7YI8Qy++FxRWO3yDcMY1CaY1bO
 1Px7R1xX8hzc+wPaKwjiNpKIqN7LirEIhk5/iMSaou1vXnQ00lEmwXNnsoDsJpozAEsxOUGekHJ
 eIi5gggFgYXMsD4/K8Q==
X-Authority-Analysis: v=2.4 cv=NKTlPU6g c=1 sm=1 tr=0 ts=6a2244f1 cx=c_pps
 a=NkapyFR+xBWi1egQVwNhyQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=MqYgbl_MLcuh2LLqNG0A:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
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

Enable CONFIG_CMD_GPT_FLAGS to allow users experiment with GPT
flags manipulation via 'gpt' command.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 configs/sandbox_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index ba800f7d19da..07d3645b3d33 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -87,6 +87,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPIO_READ=y
 CONFIG_CMD_PWM=y
 CONFIG_CMD_GPT=y
+CONFIG_CMD_GPT_FLAGS=y
 CONFIG_CMD_GPT_RENAME=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_I2C=y
-- 
2.54.0


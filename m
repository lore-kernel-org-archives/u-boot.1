Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCCCC44512
	for <u-boot@archiver.kernel.org>; Thu, 16 Jul 2026 22:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C930484D96;
	Fri, 17 Jul 2026 00:28:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="bJXlvoGB";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="TlROmll3";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="AA5mlMJ0";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="AQXo0e1v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7673F84D9A; Fri, 17 Jul 2026 00:28:16 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B4E84D68
 for <u-boot@lists.denx.de>; Fri, 17 Jul 2026 00:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0482515.ppops.net [127.0.0.1])
 by m0482515.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66GL48AO3315470
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:28:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=9XvC3I3NSawSNNbK+Sq7QyQLtRj
 2g8HiconptSwJgYw=; b=bJXlvoGB4UNcpnZHuw/9zeoISApQYoQMMtMFZTr/0Sg
 SDs0dlzlLJte+tZzoNUtZnaANXMirogeCZuodux1xf1glGGrUjfOj4GJeJ5XyQn1
 3OJAgiugdfYI9Em2fJ9jNKDwyNTGzfdH9s0rgaABG/m8ULjuQE3z77iGajqxGkmx
 ZXgOWltLqGljsn42Nh6DMCxhIRD+IbpbJ7SVaBVITBEVAmQ4A8U8PZL+DtPXTu5g
 gisH33gMQQZMbbwrr5KcaBDdJZo/1gqbL2CsMcSECOMCgN3vbuA1bla1wNoxXVd4
 WD2odCnMNqQGvyNELo2nmiAcIDcvNno2wN10Mi/EsXw==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013043.outbound.protection.outlook.com
 [40.93.201.43])
 by m0482515.ppops.net (PPS) with ESMTPS id 4ff6w1rjgd-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 15:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj+b6U+YKWxM7ia/t80AEiLVrfixNqeTvLWwlH087oLB0RRZYuj+ljPkoM6oUDLHQ4YY/DGSreGhgSVQEJsV8mh94RHMQBpVShBZMsehcO7tCv7AxLBTPlCAk2wwlcr5h3oWmfgIMaLI6u9DDAqAz+ZI0WedPYcZ1KZgLR+QC8u0ketj6Hcmbdjhh+y8PeZEokHRvfvmltleNBFUZcqg+5Z1AWngoAVTF1iuQe5A9LMmqhAVE/7nhi7nr63DdDt1FhhZVbLAcgM6rQ0QVjaQxeyw5N6OxOaAzy5RKxscn6Iwuv3aNOL5Kazt9GEMl8b4aeM5dEr4sUFGNOmX/SWvqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9XvC3I3NSawSNNbK+Sq7QyQLtRj2g8HiconptSwJgYw=;
 b=i29PxAUBpzk/+6VO1z1EdzW/ENVH0NaunkjZ7aBcHDZzX1vPmPYcQmLF99KBRTu5tnoOfH+cdHKHbiVOVGzYWULlSkzqGNR1BsAtVZILeBTb+v25o5lsIEh0/jqBlLhdFk+kOCrWMsNM3skuNlkI3W1jrJaCIrON9g6F0sSa9SGHbjsFPBfD2uMaaEcChX482OphUfbpyM9t62lG3uWvtbyFmr6lHgJnBwJgIm3L3PvoqSfKOih17bRWTr2VLl1lKlAecW8lFKb/UZoVJszowRQnkRVk/u84uxohXSEwRSeD6CJnbGhL9T9+jOBB8ni3tZY69ywXTS4n45KK+f6oHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XvC3I3NSawSNNbK+Sq7QyQLtRj2g8HiconptSwJgYw=;
 b=TlROmll3L2Z5vjw6daA1D2VC7CR8O4/lzOK/FVZfFv6jQtvbivh93/Sa4P8Ruw0P+zTuDdZlpnTHZhjVnjmxVFskHwNnI6tsdldFrS28VxfpxLBZ5W528d1ZQgD5A7NsDyIuLFToQHKbxx7QbX7ux8FxPNl3RnmtHpPoxPMZrSE=
Received: from MW4PR04CA0151.namprd04.prod.outlook.com (2603:10b6:303:85::6)
 by DS1PR16MB6662.namprd16.prod.outlook.com (2603:10b6:8:1e6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 22:28:08 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::69) by MW4PR04CA0151.outlook.office365.com
 (2603:10b6:303:85::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 22:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Thu, 16 Jul 2026 22:28:06 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GJwnhK2638264
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:28:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=9XvC3I3NSawSNNbK+Sq7QyQLtRj2g8HiconptSwJgYw=; b=AA5mlMJ0INeT
 WIEBxohZlAyXmutyXK5X+7buSoxwHW+yW0lmYKEQR7RyTHhnY0WQozaerWQIPjdF
 Gvz5ZyPsGoqwg0Vsr0oauZCSyGW9aBd5lvvAr0S3/cshBjhfdH/0Bm7b+c/BiccG
 i98R4LkDL795hdQ87s2uUMSr6kccFkQmNzGFpq62EtWz3PqrLkALJYntR0OK5FuS
 4s2vwb4QFyWcHWyOEC5I63O2k9yeliaIgqe6cReT8HjCen8kVo6Nk8+415ttYqZO
 2/TLM+TwrD0KP6DRvjNoP30U/hz4QPydowkLFeIzzHsO0iaObD+soUqAKv5hkhU6
 pc390/458Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=9XvC3I3NSawSNNbK+Sq7
 QyQLtRj2g8HiconptSwJgYw=; b=AQXo0e1vSzyoGVKv4QIIuTAjuy+ZKgnrue/+
 TZ2xoN3yOmwi3+jAamRPaRJp/hq+PeVOUzO/s+y19Sa2AEPimPyDcIQJO8BYZUWZ
 2+ttgB7N7d7SxH5FjiILFXQt1Z/jfgX9cBYDHze8Kygiv2FVKrfY0gP8jOZCs/tj
 HbIZ7QrK7AahUA5p+XIHHyWJjgnWaRAeXec2VWU8+bUjajz4XYl00G+5Qy9pJK1a
 ZNEBVnqIobRHjLVP8JX/Lp1TI++mjRh+IunvWTBF8bWPX0CI5vKKvMVOm4mhLhMS
 GtjDyvrThQkkdFwN1zik0Yqc604aTIsj0LcsqvrQC70GMWerXQ==
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fe3euacnw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 16 Jul 2026 18:28:05 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id kUYjwF4Ewuq5TkUYkwAV37; Thu, 16 Jul 2026 22:28:04 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: kUYjwF4Ewuq5TkUYkwAV37
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
Date: Thu, 16 Jul 2026 15:28:01 -0700
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, neil.armstrong@linaro.org,
 trini@konsulko.com
Subject: Re: [PATCH v2 2/6] drivers: block: Introduce blk_flush()/blk_dflush()
Message-ID: <alla8U6P8/VE8tsG@kraken>
References: <20260529034441.2075305-1-dmukhin@ford.com>
 <20260529034441.2075305-3-dmukhin@ford.com>
 <CAFLszTgz6ia9qgkSq=2=JT+csdo=9O8KpjJeYi1=CS2n_yua4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLszTgz6ia9qgkSq=2=JT+csdo=9O8KpjJeYi1=CS2n_yua4w@mail.gmail.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160228
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DS1PR16MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: b8705f7a-4809-4ebf-cb88-08dee3898208
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: tREvFtBSG2ozZorW0sPAuyT2rTJMyyxLoeOAajERVWWdeJ6dzIHgi/gXeWgiH/eRrD+9rHAVi9qR1GkGwYLoJZMqYhQqf9cWCEdUYFzJRPzkNTTm77ckyKsgRpDhQu9kcdQk9VwQ1rmpYlWGrhdPQsiBjPuXQdGFYL9uEYA63bWEsf7N45x6jfZLpWu3ZUZzaqM1YLcnhO7i4t/UwcFOG19TuoVj57XBUmJeJwJEHtQdYy198WCkLBYMxhr4WPL01v9elHHPZoiub+oggKR0rLEuPPgSriMzCQBdi7Sz9gigD1HqrYZzugwjPU5aBW/pFnrr/9S+vOTLCYrcW6wJRilQCTT6wkD0YRZOJhvRa5DCPuAG07dDU80CTwm78VKrZjUT7uFPLVzEW5k+U2dOJYw1pBTHWeLUTyE8pgW2ACm8A/0OWKLPuXQHjlTozJKTHOr4aAwJF+pMcyOn1yxJYu79SKJfUQ3YlxDjFkX77ndZpU2Yl9Pw6d9FGL3iAdrZR7yo47STPHNEuMqflyVgzIbTZEh98imD+2BJChMQLSSOXGN6VbdzERCCTj3wEb56KXdptMlxGsmqmEbrY5kUTazYAjSuOIkEW/qPnMll2Tlk6TRQdFlSk9gKlJUsI6pSpcGFAhcPzyyFzi7G9vwt1A25Z3Pb3oTgNZSEMLuBWEaDUJQkz0JOTJmF7oT5ZylgclBtxBD2eB22Z6P6ktpF6g==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aqJGOAISzzfTuuuy5/XJNXwmJPbZeM3sLOg2tPEohB07VjgRJkVHnJGU+j8T3QLB9/TK6vjQsCnLB7ZYq7AR9PjsZf0Qiyo4H9rc2dXvDDAGLs2xAqzntZZjYB7iKSP1CjWqLF2/a6o9buAlsLnt8PZEiUZI5jB1qn8BCQP97v++iBPM7a/1NOWInYG6Boy9JipgY2i4iFIkEdD9uVUHdgHC7woglvZ0mOUdXDYolj3f5dV1PNpdvlXZ408B4lRPpf/Ac/+OWsyopi+hZZm0wx5qwtni4wSJJxafAUPIQjWWK4RDzKzToMqYiewaRKW02FzJtiUwI/hiy+hxcYSYYqvQho5vfYk8C5WFjoxhqzpX79f7G8GAF+2lXbFfxdzOIew/MxEdupC+asQF0IfUjunXMNBIBaifFkjdpn6pJ0tR5koQrsFskN8L7hlbDJSD
X-Exchange-RoutingPolicyChecked: oiIWRS812NRguOzrMeB7gqgwBtIdiByqy64R9WjhXXUxGJCUmJxETyYaS4uVJD3K71PAdwCEl+ThxP8v7czdHnQxoApQOnyn8+fsoX6IXOOJEXY0i1jxoa0ke8mtYarYfpA+Ceaplj7IjfENNNihjNgTzQGg3Px/ojFmvJ3Z+6pCPWvTkVvWptY0/3Ee3UgvZ0b3jbfgOYPCQavnoSLzh3tHUk/qjYf1UinUWQzpowx6YDIwNz7X7MOiOTUtGnDQWwPTocQCY2SCBmpZMaoqLLArMG8KY0mov080u5Mpq/UI+mqYlfTaH8Mz1JsHZLhFhvXpSAiAOx2MCue8quENjw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BaIro01EQQB+z3iUcIQ2D6DFwV8pBawMnNOvLNursQxZUqJf4M5lLodDlhxKcDxKDM8sj8GYfEu1Unwgd0E8kJwIJM74W4WHWj+eVTDyTcGay4REAc2yTkoVNfkWy8tlkTVI6abPwojsUPYYye4C01PvS5IS+t+J4f7389raiHSDe3eJ6rifGLpoMq3HBtJ6BSt6UAXxHzX3cFOOuhvNDNYqjftfNBb2dmqp+DcAABKdJ4w5W1RjPhxNY4TH6TSt51kx+aizkXFWeTFNOgG3C7Qay0vgTOPeDzPcjhLI7le9PK5ZPB9+FsI2fOmEwY9WM1R3KyUg7Z9k61Cqim3KO6VghDWMvVDv6qN450i6YwReE4L84HvRqGAPJeaQ88W4tm2w/1jBtnQphsn20Esdjb+ibBJEJSNOhmPy/Ien5tMMnJl7Y1ytyw12cgtbUbGR66jlyKOFHdQT6zw9MUqb776OPSW+Ye3mu6bCMMZpSMx8FeaBvroirX/bEbV/4obYURmYVRAEv7k4PQXtuiZHuQwkifC/1DcmQsKLVNeuTRvXR8uFjPGQ8EA0DmJw9Gez2ZDSZN2VgnMYAi/NgYX1O8V0dGXnjjgS+zED/H1Iq1LpmgisGx6QU0NGl3gCI4Rf8bu5XLVCcP4dCaC6m9JbQA==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 22:28:06.1964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8705f7a-4809-4ebf-cb88-08dee3898208
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR16MB6662
X-Proofpoint-GUID: 6GRoP3-ugjn3i1MjodlvQJgG5N5r0huV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfXzMlqHPzoJwwe
 ltWI9rsjlS2lwV/5FJK+ORqRDcmQetb91UTRSw3d3ajnIwodax/6g96ReqsqGHIqSsPssUHPY6/
 eo5nHpO9MlRrYpj/qm15o/y3LKI9q0aokmpFv73YfcA4faZOxb4+
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDIyOSBTYWx0ZWRfXzoANuIZ3EgJ3
 dnZBVuxdXJAw0ADxGEyG/+eWuLdFixvn125okUCzC0PZ7xn+YiaGjMMcBjUArrc30FQHHJKLfb+
 nAeBD8Pao9sSv4TC8bPT18nl3ZrM12pyv/S1FzSgtpIPOaLrrhG0h8F+K/bJ9zMpydXn0p/2ucc
 qi6e3zXiRWo1wwUvKSTibICeUugN18osc3ftF+HHBKQzR24659zH3GiFu9DPLTbxg2vLoCrYuVP
 Rzi0ygwmZ8umq8W4BMhNEEH+v4hcaNYsrN7SjaM0HTWFRNTTL0CVhUBUKSoANow3KsF33MSilmk
 nDtCJwVZS3Ve/8wSMKLyg59wQCprrKV7v0jiP7W1hv89GW9cVfQXcUzfDdqHWk2r4rNMXasyAvo
 f+6+Al8aonpcGh0Qr/cpAqUs+Bjh8fjeT3fMaqBnR8/4tkHXiWHbZpPXwTBztieN3SgL6YB2a4g
 hJr6vU9uAn1gVsadc/w==
X-Authority-Analysis: v=2.4 cv=GKM41ONK c=1 sm=1 tr=0 ts=6a595afb cx=c_pps
 a=XNh4DmHdy4Cg7KTw7bneTw==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=0GA0A_IKJoUHBEAzNTkD:22
 a=MbEbFUUB8PBLjd_OJaMA:9 a=CjuIK1q_8ugA:10 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: 6GRoP3-ugjn3i1MjodlvQJgG5N5r0huV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_07,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
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

On Fri, May 29, 2026 at 04:57:06AM -0500, Simon Glass wrote:
[..]
> cached contents are still valid. Erase/write mutate device state, but
> flush does not. Please drop the blkcache_invalidate() call (and the
> matching one in the non-DM inline below).
> 
> > diff --git a/include/blk.h b/include/blk.h
> > @@ -99,6 +99,7 @@ struct blk_desc {
> >       unsigned long   (*block_erase)(struct blk_desc *block_dev,
> >                                      lbaint_t start,
> >                                      lbaint_t blkcnt);
> > +     unsigned long   (*block_flush)(struct blk_desc *block_dev);
> 
> This field lives in the !CONFIG_BLK (legacy) branch, but no legacy
> driver in the series wires it up. The only consumer (NVMe) is DM-only.
> Are you going to need the legacy plumbing?

blk_dflush() is used in flush subcommand in cmd/blk_common.c

(I also used it for tests in v3 of the upcoming series).

--
Denis

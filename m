Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE980CD5BAB
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 02:16:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBCFC84910;
	Fri, 22 May 2026 04:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="q9nB6DWE";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="YVAFFXhp";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="JsunvsbL";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="sXYwp1jm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D92F684852; Fri, 22 May 2026 03:23:43 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2F1A8486A
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:23:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367128.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64LKEeBW3214041
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:23:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=IBo
 FJC3d8TwD4T0rQp2kqyQNSYO37H1eWDfUnVFXJHs=; b=q9nB6DWE8rf+TSOON8+
 MTOlPwq5XNX3USYI9446Wxvs6wvfGtdud9+6FZ1s5OV2GPZc//Iy1M3srQtHUhRC
 IJghW8GNHaFj0+PHn7M52b9n7mLxp5Or05eaDMXq90lJVYpjMMM94LC4c0QLvPJr
 5xb5GwC6tT6oLPVnRB6YFmWIHeBJpsPgKschzywgbGKuLmnjZoB1PqKte2U+zKc3
 0Vu6P+fw1uuVamjmcxK+r2OIiy0pAywWjO14C9WRMOljfZ1m++Fy3VH4HF8j+nlr
 ePxs8Z9lZEnTIZ0RJxhWXf9YyulVFV0/103u2Pf3npr+XznEeQxHUP4plwSREsIG
 vOg==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012020.outbound.protection.outlook.com [40.107.209.20])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ea7uytgky-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 01:23:40 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NtujnLTh+3SmFKLLjL/OMfkE81QwTI9R/6NdPpWfizVwnHYkgMuGm6pefSCU18tYcDu8hTNYNpnYhxcPVP8Izp3DDAHI6Q5BhhFWJFdWl6ckZ/jsJBn8iBwQlifgk8AmmqLtgKT+zr/x+HpSz6KaJqHCEVynFdsrnGpoCwNGT+JsZ90qmMtEtFJ9SjpFQmjWYvYECtic1Km8IGQ49v8mnAe8sW2kJlHNSHLbq9GzWis9lTShMs+NkQBI/7UGswEz44hYtTGN1+KWusbBELegbUAxdImC+Ovz5Xys8hjHDzaiu/Xz/B+CD++sVgL86EvwGJKUSd0jBrwrwm1sxYE66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBoFJC3d8TwD4T0rQp2kqyQNSYO37H1eWDfUnVFXJHs=;
 b=gzwCEIXwahBpGTuMiGOlkLRAObDQyKlaTerzQKbG/R0PuW3cElJ9Oxvi/JU0U/SWPE1i3E23BIJ8+baKGVamQ3zK5iTpClETdUZuENNlF0WBAXdkRIIO1DMY9ddP63yx0ayk9ewO+U4lhh6TkyBGx7AVPjY6hu0uGA8Dtc9MPs97JnmHn9WK+t9x7HcvamegI3nriiFVG+rcRCO3jPKLI1T25J2+Bpl5Kf6n5jfPpv3hgrr+Oik9niop3YcvzSVmGmcwQw0VwkCNUf8s7nRyVnnFuGEQh3w5ZyqiWhqKzmkrkwuciWiVf1QYWXJ0B9gRJPTb4nZYyrfb2u0pxk9kag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBoFJC3d8TwD4T0rQp2kqyQNSYO37H1eWDfUnVFXJHs=;
 b=YVAFFXhprDfMX/oHNaaf7Appt92UCCtxm1bAzPQt4TTJiAz7KkdV9Z8t+S/pSUnBB/fbFQefmlOEHlcTcNUWzk51l3fZK4lxX/FXs/901M9xDqryTtV1wJs0iNH1EVp+UXDl39ixzSWjnM5M9yIzXxjKU4rdIjzmKaYz24vlMNA=
Received: from BN9PR03CA0777.namprd03.prod.outlook.com (2603:10b6:408:13a::32)
 by DM4PR16MB5459.namprd16.prod.outlook.com (2603:10b6:8:185::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 01:23:34 +0000
Received: from BN2PEPF000055DB.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::ea) by BN9PR03CA0777.outlook.office365.com
 (2603:10b6:408:13a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.17 via Frontend Transport; Fri, 22
 May 2026 01:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 BN2PEPF000055DB.mail.protection.outlook.com (10.167.245.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.0 via
 Frontend Transport; Fri, 22 May 2026 01:23:34 +0000
Received: from pps.filterd (m0426316.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64M0f8Yv725608
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=IBoFJC3d8TwD4T0rQp2kqyQNSYO37H1eWDfUnVFXJHs=; b=
 JsunvsbLr4yRlG90LgkqUQp/0Wxb83X3bxlzWNF3a96cmt0ON3o3apkVDdeQky2Q
 bGsdXsBOzW1gxo8tGZ/ceWPzP3nFe8vEnneNrahSnADAxqwpdu3XMJCecRmI0jvy
 HTjNz5EVGrAPOC9KCkoS55x7RM4qTlW9/+VRa11wuPAnWF1Ygc56jXPCs7+IvqoF
 /OgxdozyyZIcojfuXhEIRLive2nUAFcL0nYKCX9mJ2IADlQf8CooHzPEzyEh25+D
 Pp0mV7uMGRpuKVH7KkObamW1YBTdwVse/sQORleJac798zKuqtxpE5bd3LB2Msv8
 3JDH8vs7WYiuHbLGBan9dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=IBoFJC3
 d8TwD4T0rQp2kqyQNSYO37H1eWDfUnVFXJHs=; b=sXYwp1jmscKyW1ZA77mLELF
 8pEt3Tz92t95b0/frnmKAYZImjmjrnyDZ89jqVFO2MM13iCrAGc7KLGHwVZCIbua
 yw5+vOQ4ViVDvXF0fODaUwNa2XH0yx6Ld1sUOdOOFSyLY3NW/hSXZWOlm/JxCau5
 I7txA/BzUqG21hwQ2TXEZgksGrVJV4hh+IJdXWNusDwi7J9Ymc014yB9Tn41uK/I
 hUL3TxkUYYThYUwtqSxyvn/EUaW3+67yVZx3jJ4PgMiz7BCvu9cJG+FZGIQ070+9
 yTROt3aqI4/JrHRt5JPD4qRnyRj74DjZ3WXkFYfcgXL9O905CY2XI2LTAAOB4gA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eactrg10q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 21:23:33 -0400 (EDT)
Received: from localhost ([19.12.92.221]) by cmsmtp with ESMTPSA
 id QEbswwRZYtNm4QEbswdFsy; Fri, 22 May 2026 01:23:33 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: QEbswwRZYtNm4QEbswdFsy
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 4/4] reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
Date: Thu, 21 May 2026 18:23:12 -0700
Message-ID: <20260522012312.860026-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522012312.860026-1-dmukhin@ford.com>
References: <20260522012312.860026-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605130000 definitions=main-2605220011
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DB:EE_|DM4PR16MB5459:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 628e152e-ad24-45e0-880f-08deb7a0bde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: 6aVYT31ijofBWgv57YIti5AM6Q+hfsbD+4amNhcYL8r8fSTt0c70k9+hCEsV2DSf2sHXya1Zg71m4RHV3nvdf1CqYYSZmIR90Vmr7q3TQaS2y+ameT/iqpfBzObkVw8V05p29warpLmoPn1pbyKgfuDvQRKXVPvRlZGz7POwo5+g5zB7+wP6G1qBgYMWtEHGxPWznZtDXgZpzrwz8W4j1YutvnKrdrFfozmVKexeUYr1h1jzbCMcq3A6dZol9DkDmxMxISZO+uKuYIOeyXpAiTbUx7C2gdrnb4gsbHeL20AtlZZxsrAZvoBe/ZspzpVN8IqKxcwW5RQZwlBwYtFHVbi142POi05hgy2S/LnIw6k0/7Frov0/bH8hW9hQeeL/VZNagO9R+FwAj0CErhXLlQxqwrJf9UF2qfMALDNnG0nIs5Arzx7krPKj8+3dtm8PPthZ/MTiPlD74cMc8GQMYVI1R6AQflbnOovAXCPiwGgXIVusgX5Yjr9eBLH3jUASDSu2Sv16OiJpZP3AUfeJUJeMI+wrztTR/LlFNQGST0uljScVRxn+U5086RG0BHheHi2E0oKpL7Df6TRuA1JfujvJRTipiwvT4UklSw9lDpIWiWlxtaYeKc3Ou7wwvF71sICFwPx7puW3dRk+raTFJSbbhBzZ14TJB1O1OlpCUsEqt+eRBIKj9e1svqkwGhfEs9rBf9rMOZLm/jtz5n724UoTOLds/iMxcBXZ5Ji7Nok=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 39WeRQOXe/IxQH0gYgx/g/IyCO2wzPE2ZaF+BCwh2wp1GgKrF7SKjatJ5tnI8zNbO0Bt8Z8FgKVfDCb6TGE9k3D+Ni6z/MinwxAFWyBFgcqqHP7f10bwqPFzueZvO91H9iA4XrMJLKjOZ/rmo/9fs2YOdvptbYVmd7Qe06BO6Lj97paf2rEjQhLmSRgGGkO9E5qKzaFoIaqloGZ1gPKTzULVqsY7gRTGOIFv3rHbTMrGqSvhnIHATJLZinrmjegGi2oU3XLQ2FCW4sVNZiTTBBxzlQlaiI8Qpt0paEzlnPfYHYLhmP5oo/svkEHYR3N7zr+I+XWxUXDb8gHn6JrcYdajoDzVCu2q8iZv+kQyHECfs9Es3IdHiyHO8PV8cA+XYZY9KetSMJvzZp/QzQWJUI2ZOXVk37VkdnhtTnANzlN1zawtrGc50iWbc+Ewf2cz
X-Exchange-RoutingPolicyChecked: hAcvdQpbOBJ1Ez6+LsskamFe2IYTepG0Xc2syLOXGtF7kbTo9VECrMsKc7bxMYh0IxENQcvrgwNNcsk1VWlBG05l0Bkm9+J7Is+8Uo6xw+ky/A/74osgbrO/vV/wdvIBQnNRfvGAhbQp2nHLw6pHTPE+IIHw9ny2dsHWzWoRVgnAd4lidFdQ7qm2Q4cJiHUwStrZqLKeSYvEDDGUpnp+NH+WPzwWFRGu5XP5/E+MpMd4Oqgrrxd9lPsKk3Hhtap9oK7wFbp9eLcQXN4d4stSZTdPESi+tTCM8Itx3VpDojKw3gv4TuifFWHlBxMjcHYZyupjwC47tYEgX8R4LrSRNA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AVoUs8UsxHEsNxFXuMJ4MX7xyjmb9hjB1ry0J6sTA9DT/tkumBaWlpbfu2Jo7F8E5OX5Y5UtBBMBiSNmtaBvk8XZaX20JknuVVsHf39RcFCTKFQa7CyNmGepHBEuk4a1k3ur2aCYoY9nYa2luy4BU4gI63cpZMThyGRYWQGmNcG1RNz1BUbQebRezX3/dAWMlU6IRcp41QBh9AoZIxjA/sZIEqYwaA+jKhA5zOXn1kvenLm/xwR6qiKE+2OYDpHZYNrYJ2UxvZY12z0Ij4HQtjXteEXQZcZZsxb1QSlMPRhbnFgT+Eer5pIGoZ2i0fItuoeYYj+C6StA8Pv2LiRW36B/UDk390ui7vG7ESumJQ2DKS1nBZiePEb+J6gsnU6wZrOuxx8WOuEXECty/4Q8l+BQNykDlRRjgLqXyn4mwoO6t1yrqDlo9Yio1ruNE2894H+2fxlhPkh5735vn6s3DRFajty7ntaLhJdh9VmvcQnAdWXP4+NDSGi+QArmMND/9G0ZF8ciGJ0v2Pbw7GkiD47Ci3YWYPZBUKEi8P31vTL09tuy8UvtbEbqVTWUglYcfrGMciGaikerH6UNDa3kmzuJT/GDMy6773Z9eiOaNY5YKHk4QsKdwVj6l/4frcWolR3/csrTjrcBtLSQWWUb3w==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 01:23:34.0868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628e152e-ad24-45e0-880f-08deb7a0bde4
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR16MB5459
X-Authority-Analysis: v=2.4 cv=N+QZ0W9B c=1 sm=1 tr=0 ts=6a0fb01c cx=c_pps
 a=0GA36Cgflur6eTh9hrVzog==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=WER9OelvoqQQjwJToBYG:22 a=cbNQJ9GKAAAA:8
 a=vSM5nWOnqLUKsW1qPdsA:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-GUID: 2rrhRyh2ZiRlxMujRsqRRf8E1MGwZeFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDAxMSBTYWx0ZWRfX4ZucYo82fNh7
 NtUn4JaeHCwUaikqWtXffxNFSmPiCEpdi2S0bas31ib3Fm/ewV6y+/5l/+2DSUX00W+UaAQwY4s
 mQI1tUFvkmRZU2lBSAIheUGuxTbZa1yCxe2I3Pu9YKCjUAT0iwHNlkJVuImA/v2zss4dBYRKyIx
 TEYa0HhbWoura4MHmzbnFQC2nmdUfqdq/vdZJYYyGdjdg4a7v1+kiPJlbo79J2eYTKx/b8qb5QD
 GrVDn0G4kaSZsAQs1NlTFJsP5AWMXTSK4jfTaESb3ykMxzNY+z02LkTkcXoajlff+0SAbpv2yXB
 Oljg3KL5ljTrs/00YxSn2NBl5h58c3sXUUHSRqF3kZHdmG0aMk4q0quB7mAcZwwWCbM0HDyKWCm
 tM9oZFdH3K8R2VEebyFH6ohkNQ2RDAXFIIR/IFKd/xQRLw1BV45QEVoCMz85Oe1jWzjZ7pJlIdW
 m/k7ovFt3bawniImU0g==
X-Proofpoint-ORIG-GUID: 2rrhRyh2ZiRlxMujRsqRRf8E1MGwZeFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_05,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220011
X-Mailman-Approved-At: Fri, 22 May 2026 04:13:03 +0200
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

Use cpu_hlt() instead of open-coded "hlt".
Also, use cpu_hlt() in reset path (including EFI) too.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/sysreset/sysreset_x86.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index c2f28c65280f..c4e34cdc78af 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -10,6 +10,7 @@
 #include <pch.h>
 #include <sysreset.h>
 #include <acpi/acpi_s3.h>
+#include <asm/cpu.h>
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/sysreset.h>
@@ -65,7 +66,7 @@ int pch_sysreset_power_off(struct udevice *dev)
 	outl(reg32, pm.base + pm.pm1_cnt_ofs);
 
 	for (;;)
-		asm("hlt");
+		cpu_hlt();
 }
 
 static int x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
@@ -120,7 +121,8 @@ void __efi_runtime EFIAPI efi_reset_system(
 
 	/* TODO EFI_RESET_SHUTDOWN */
 
-	while (1) { }
+	for (;;)
+		cpu_hlt();
 }
 #endif
 
-- 
2.54.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7559CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:21:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 595BF848B0;
	Thu, 28 May 2026 03:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="c3IY3fs5";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="J7tp1ico";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="kNLIgVGZ";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="lSNh4Wqa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FFFE848AA; Thu, 28 May 2026 03:21:12 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7AA46844CF
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367126.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjIqS822426
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=38r
 oL61TSl0GWvCEtE8l3w+xPWJwzD+vYXTWeGKV3xY=; b=c3IY3fs5aP/VzGSTU5u
 tXsyAL92XmE00bRtwtiUNPBlXaz/k5VUNs3xnxwVInz1jvfTfLJ2XR83vCv5kLsn
 Ue+t9St9aw5irH5xWPmcZTwL30GqrKqINpBtIxTv3W4XEX7TiFsYjnH7EGSYmcMa
 9RpMbmIYCNaNhOG+evbOBxe7rbDHDEl+nne69CfEDDNzn8Y668yZpan7lJRPYOP9
 dgTt0lIEAXoLwkcE1KvfOdXmPpyIUhvSMO3EVOF3OqY+Wd9hq7ps7/XD8vmh1E6Y
 641plEWe8vxIemDPXdXc1YbcfWWwKZOc4rd1zZO8RFcFpt1wfadR3EpzJmbhcwGm
 e/Q==
Received: from sa9pr02cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7x49b8b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:07 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdEykKR9XCfI0Zy6JNEAn8tCTzKxjQEaw5etmmByB76aECn9nV9Nvbaurk96hSxxD+RXqJ+6GzaPDItgyVRbwJ5NPpMKGUwdH+luCoajaVApCY11w7gjXuWCFcCz5sK/5Lei2TCxElEi4k+0/53ShRaNuyuk9FEqvyIY+9fan5IGdxQMqQiTUaAnVLhkXkX1kGovR9+vFvMEO1nAH8iKHECVuka01t4nMnaF8PUzSWzL67OTnA50SodDi9rixvc8cUKgoed6ISyvcO47Ed8FesY0HaNt44ievPTDMBXOQbdEmevQ04exTV+w8kE39Pw2Jxm62wq55nRA3mnewhpjyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38roL61TSl0GWvCEtE8l3w+xPWJwzD+vYXTWeGKV3xY=;
 b=SZFIgvzmgDcMYJXsp6MfybB546WGKbR2Wra+aXXZfseLqmMm8Vx/FvQus1gotdQwHItGSYUCdrWAcdM8df2dPs+ip9jCgHOZZvub5M7AFamgP6DJGffRlTwRhQw5fCchLrT8tlDPdxuHF77ymvNZdTDCIEw55FZCQMCSpysgYZNjIjFu9jRHLPh2sjDniwsJJ9K27QMVnFBoYWC6owfq9ywbADqj6Of+lqxx8gK+jA5UhregLN37Hv06YyUDlbRXxw2YpAwzA51XcIbb0g/SWrwDnrjv4jcMeyeQpyZlijYI619avWNZfnIKat6SkOL+oUQkztapD1cbmoAFi3GXrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=38roL61TSl0GWvCEtE8l3w+xPWJwzD+vYXTWeGKV3xY=;
 b=J7tp1icoAY8XETn5FKCH0E2aZUwE9kDDRLqZ6yQfSg/0e9o3qCq0d5jlkVYdXibj8qsEbM+xVMK6TyUOfpiLfH13W+XLOzG5GgP8kQD2E4ppXkPspOeEStEEnyVQSp1+tmHDPCIN3FVHMgz4piSyq6H919QTwvLbcuV3y/oKZMg=
Received: from MN0P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::20)
 by IA1PR16MB5453.namprd16.prod.outlook.com (2603:10b6:208:457::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 01:21:04 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::4) by MN0P220CA0010.outlook.office365.com
 (2603:10b6:208:52e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 01:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 01:21:04 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjTXe3452364
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=38roL61TSl0GWvCEtE8l3w+xPWJwzD+vYXTWeGKV3xY=; b=
 kNLIgVGZOqEHM0l9SLwOzF3q5N/qeWrRG9VdMdqPt6AjgJ1FhpPEX1/JTF5HcaHh
 fMEbRhdDeePekRxV9AFdVDzSBXlv54vIgJiYeMa7Qj1qq8IzgJzx1VQRKDd1JIC7
 R/Hvj7QKMkBvBchQp4o3UGYKlhR8QbK4JWM3Q+8ipaxktYdWlpmuRGxMG5GMhjDa
 44FMwdnE3xzpNffGmhhPhut9IdyKlJLI7YESJN5fIx+IZp206pEzLzUq0oV3+fmx
 u1yZoWwOPyR/6N74ngUaf/9jIHRfl+8TPkpKuXhKh+DVw5jwfSvPKwQgWdmkQspO
 aBzIRpLU434ftCFWNu2CUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=38roL61
 TSl0GWvCEtE8l3w+xPWJwzD+vYXTWeGKV3xY=; b=lSNh4WqaFBxn5WD+EKCsjM4
 dbtaELrG7LozlgpKHxl6rQ5V6GkjV1Zr+fstU6BNT3hQeDZdzHUWtRE+yywr5nSx
 qXIq/Au4HWpH556q0oUhjj29ukIc+eXq7mI8EqWMkyob/wJJ0tLaJnoGnBUySpXm
 NW/6AxGwR9NASpSE9M/l25rhGSzQsiPzbPTkxBJo33iSI21HXfIVgeNlDMp+ORhX
 bXnPpW3TJ48I0Py+Z1DTnKEnFVYYchVEbOFWYzywAGP8jZjytHqsHlvOfbPrqQ8o
 rvWbyMYXV8weEhmych6mBzYEQTJ63ruXMozrmdqmI9vCLdYlk7pCr3lwJZb40lg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [44.208.76.22])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x887f8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:01 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SPQiwr3J3FYU6SPQiwB1ku; Thu, 28 May 2026 01:21:01 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SPQiwr3J3FYU6SPQiwB1ku
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 1/5] drivers: nvme: Log I/O timeouts
Date: Wed, 27 May 2026 18:20:52 -0700
Message-ID: <20260528012056.1744362-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528012056.1744362-1-dmukhin@ford.com>
References: <20260528012056.1744362-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280010
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA1PR16MB5453:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8900bc32-327a-431e-0c46-08debc57630d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: XDMaxag7FX2UhCXONvw3jb3LWVsVJ1Gyeh72VOcXS3NbfVKfFEeohlG4GHcs3Fhc+du15CVLvTjR/+gCrCqgFowSF+zwXBfibk/FipVG7KhgUegTm33Zf81W2kSCFsZdpGbHgHWoQtNagP1AHnvx8rIiVlc+zbDJveyTE8F8euv3Ds2t67XS+Tt70QEFZKQ3bhE21aZVkk8wSfrjXr7tRPCoZSwd3GjEw7z5b8+X2qhw5Vv1Jwl0DoC0b7XczZ4M0yKf4KlVglGmR33MdzihBf82kzBQMHMMnspXH4c1y8nlJgtBH1pRzok95JmckCtTzi6QRqAE3Ikf4UNpPPkz9qpdz1zfdtOmBHG8PHdNIpC+sy8xBw0nTKatJKXQu3eRASeU3HSLF+OBEecUGRIN9lopksKRcHt1j5K4kQI5NQu9oK3xC18iHCpWsAsveQ8EmDidfhqxmgfqkoFDtdQKYp7Y9bUYQKGZdU9El3lDg1u21lpXRawA0pkfOkG1wSJ7FOClzEQ/c4dccb4u39CsNFuATQ6DUhAnzbMe2j8qbfLszpIGW3XBU5DBoqla6msYpZA1t2dzRNcdlmrVI5rG7uz4C4NiHQcHwuTt5UcgTL+rWdC/ytliSDIzlZOos3AUYsdyMqTlCTirLmuKm0DVPQwXR4jPvS91newA7raCVbxJC5SfH9NyWuVmM5d2HSkWiuc1uPNZ/eaYzf8LxGAj50/q5yGTQluat0Pf4MXQipI=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bqiOKwdRUP7+bkUlvC6YgI2Jo3Lr8izC1urRJKvxNC6mnTfl6oJATrtQNwcJmT7yUc/FYTzkpqy8asDcmapUkEKdWrSPe675aTbb9Zv0L9kCetuM6sFxiERLi4zDbABnqebHElM3QcABfDzj5am5RUu3cfDqAZDsVbkxBqvFeIZxOcG7LcYroU0UicyPMGDlEJPiyIsc3q03BjOlNhPY7TRBUYGIP4EG7SP6eyo1Hf/byv4iYlFNvewnl9TwYUdb0YeNGpkCVRpLlNx72oPVsv5qflvHhReK0wf8CRjtFaC5rTwhvCg6ORlgpzQ7Jwo/2eD5rZbg9hICLRkJGP0J6DWvOquonHoR4DwLUzsBUeo4SVgkAf8E5JIkvLNJmXKppoeGpI0jr/dGjKxI97lokxGb9+oyPF1hC48+DEV1WQxDudPzg+LawLl0L/5CPWsg
X-Exchange-RoutingPolicyChecked: IKqI6aZ5He9lr18sXlsoCNWVHs4ktSoLBTf+9wmstf+5qnzeDNcvLE3bt0wLOw1lv6HEpqgYyU0NP9xGB9be4e1NNrHFraUt5Af6eL/EDx86MRz7VbLBbWLBzfC6N/Fc386Sgux898ZM+8e31IoB9J1xx7wSBLuyoEARbogOPJMcCsqr+r/4NHJp6n57TUkSL5gH2lfg9Bo1RI2KeQ4ed/S5vqQx0xRtkn5DgCApx/KM82D8sCS/Tn0LTqRFLSO6uZlmxwQt15AaSJxG+1Qb6KfqwsMgsdEhW35VNh0PbxL+3QJCEdW/CFwquZBR0QItZfuq37Ludb3QQw8ulGZQKA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KHL00xn+XYFQTfE+yhRrvmRyzbUyAEAq1F5Aw6F602IxdH+or4mnk/9cUAAKwHtSnpoJWTYTofo5J+cqBGCQjg8XTfFCtIXU7ZANy7uET+e5UHVTaG7h+SkFpnfXVdwqE1EjuhDeUQbohmvFCQ3AeEHel/yyTbzklwwWbtusaEFthc5q/OEnbzl9ZB9Ge3cA1dQaAqCGo2vaEFY6McY+bF1ZHsfZP0qzmEDGeyTRcmmunrN/9etJlLtxdi3HKoyNXZ4ZnPYgu6r9Te3dyZHnPCMPTugb1B+Pf/J/Wt8mK0kW1LPVfxoR1VhmsCw8diVdt2cksAF9PGOwTtI4BKlC5PXzI8IIMKkQ3JmVHEXr7/fQ1Ql6UiJrtSL/il98m1ZISuaZdwCHy1TA6ruMNevSkVnMIuTHDVgD11v+xk9vpsuvwMaRYCm/cLpXBSeuzN5gQV41MUKDPQiyt5dNLiCyKpiK/kcJIi/zLSDRzatS6zPMV+ZOW30/hbiMKbqSjk3V1MI9AOwW9+ripM8CC9CVvTFYDM/65Wol/+EnUq0Q9Mukskg1SanKrnKiuLtMM5QY/ldeBK2/eg6Uefywd9Lt/FY5VO8ahI5Sua5M7UZ3q0VoT5I70F48aNVZ/yD0tumaga120XbF3Sjp2t4yRFBh1w==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:21:04.2287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8900bc32-327a-431e-0c46-08debc57630d
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR16MB5453
X-Authority-Analysis: v=2.4 cv=eecNubEH c=1 sm=1 tr=0 ts=6a179883 cx=c_pps
 a=hwAR686YzpmZ7aH69gEPcA==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=-OawqTZBqJjt90xPb8wn:22 a=cbNQJ9GKAAAA:8
 a=FM2k6mJJSBvnV0fzvkIA:9 a=3whSkbs7g9Me0DR5EJEX:22
X-Proofpoint-GUID: wRGSprOYVx_k1gB9MOeJaEOOgpiZbtau
X-Proofpoint-ORIG-GUID: wRGSprOYVx_k1gB9MOeJaEOOgpiZbtau
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAxMCBTYWx0ZWRfXzr9JJHDiaksf
 BgvmWkV9cH7HZZM5ER3+g0Kys1+INYBdkt6+RDyckYmVCs5U8c/sfcR7qS79163BLEULMG5bOAP
 7TDDfUdSZ1HvJXJ7fC+tjIlPMulPWVEf/BpJYyoDhWaJmlLIEnToVD7n+HVTahezHDs3AJNZInl
 Es73tuUsW+H8zd0Ak9z2b4kbICUOJXXWyNEnNYAECQMVlpYhUdK7qabE+rQEfQNfqGoDkJzEUoc
 zw5BC9Sp40Rz9AJyo0N/UfFSxp53KymPRPtPVQv26qDy8RWCW5nStwLqxu/rZPIIKqR2JYtLXb2
 ChTH2zAKhBffc3Xzgu+D0LiE9cTThiLZEbg4frGeh+0gZihxSejlJdsARdOFkUbYK3QyVpS0AWv
 HB3SDz6oIkxC1Y/jDglnwr4KbtEJvRs8SGo3jRBPAl8iG+NqLMO5na2aoPHjA+dPDU6kK/jGDnH
 yZkEE3+IkrGjFShtAkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280010
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

Current code silently swallows any timed-out commands scheduled
to NVMe. Log those to be able to debug any potential problems with
the NVMe hardware/firmware.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 drivers/nvme/nvme.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index 0631b190b978..c3c44e50f19a 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -182,8 +182,10 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 		if ((status & 0x01) == phase)
 			break;
 		if (timeout_us > 0 && (timer_get_us() - start_time)
-		    >= timeout_us)
+		    >= timeout_us) {
+			pr_warn("nvme: cmd %#x timed out\n", cmd->common.command_id);
 			return -ETIMEDOUT;
+		}
 	}
 
 	ops = (struct nvme_ops *)nvmeq->dev->udev->driver->ops;
-- 
2.54.0


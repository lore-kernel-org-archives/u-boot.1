Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D814CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 07:08:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7610184855;
	Wed,  3 Jun 2026 09:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="IR4ziQ6n";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="OaEmnsPQ";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="XHGTB80d";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="nkKTG25e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7117D84878; Wed,  3 Jun 2026 09:08:02 +0200 (CEST)
Received: from mx0b-00498f03.pphosted.com (mx0b-00498f03.pphosted.com
 [148.163.143.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8B78469D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 09:08:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384717.ppops.net [127.0.0.1])
 by mx0b-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6532pwCa3461308
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 07:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=lfQ
 JY3LqTt+SSOSqI6l0W4GsTge0FLAHc/woSOp77I8=; b=IR4ziQ6nZWZbRcNe1sA
 doSACi20csNe4QZ9VDFH+igYDpUDht5NrQB4tmMz+EEFJulsNxMkO5aMMGBVndkq
 +15HLQTrcQh9zyW6u9EgiXDNfO93fSldYYFaCkVX+ugFLBSjy/RK9C77lpo0NEi2
 /2iNcU6ayfXRFYA3VTF16sE3XM/AcWPTTj1T467SOxAfwa4wUCZLyNohsVf8U+7n
 r5jBnWPVkh9B2wSPwY+ngdtO31odrhnyCEzuK7ULZvhEXE3jSmJa58EQc39cRGkA
 svtw9xpk/MhevdyC/8+VI19kX88NrbJmiapguNBiIMzKp3FDYetGNCrkQTtk1W2d
 2hg==
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by mx0b-00498f03.pphosted.com (PPS) with ESMTPS id 4ejbv095a2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 07:07:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzFo/bG9/Yh4ycIHIZ/JO+4qTfErZ3dFNsSald0SoYHFN/ybJ+qLp26dQfsa8jdk4tUek/1wEAKL99u/Q8X5wqzFvlsC9N+V9ADc5/htZ8EWw8BjuPum6msrqvDQTvDM4Y6llEbKrGyeYni2cTxN4+scI5LRBq0Mz0cYSDjak9mEajX0nCBCcU+QGn+BJ/OssX2JOXzOY4JKbwzmDYFvb/uKToGynBdDTPM5RGRYg39Dp4k1ek4/ZeaelWHFJ+hqmTh0ARlzUSBfux1SQEt0iJQjdocuzsSoX9XEgYe6yQiy/U5I5R5o49+CqRmqrMoDhMWDNfApWC0HXODdUFFMsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfQJY3LqTt+SSOSqI6l0W4GsTge0FLAHc/woSOp77I8=;
 b=hL9n5OiSUbUdVK+V26M+WxsB8N1kMDJsH7U3XOI18pIvxlH6up/fQUhmLV2la5DKK5WtCwSYB4/PAES3SmsQbZOAJRbuOTmpc/iHx5CLxFQpR+8Rljy7u4VrTwUWD7rAnJ8/6z2YgYFbUmJjoL50afgHttImpDYGsemkr6U1keeOgvwgIxp/nJfTEFYPqOp03t2WrZliqXvm3E2EtY5i74e9JVktePTPOwSvGkLzT9buaAfcCzDMAhnTntOwMx7uUYsyp9UbEHu3hUhfry7YjtV2mUbRELrql0MLX93vamvAg9xePsgIvhl9vv74GN04tXDjzQyz+3b4tujqveFF1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lfQJY3LqTt+SSOSqI6l0W4GsTge0FLAHc/woSOp77I8=;
 b=OaEmnsPQgC8ReKQlLk9jcFQIYNLA63bh3ng/AT/HyX7osvwJDcYxfh1TlLlB2ehv2MflcAhKImH18qnv98FciA/oSrOvPRquLg5OTfjkNcErBwd8hS9N3pNci6wsEs4/9JPNFgcr37P/FvusyfRHug+dRl3Pxv1uuEa/e1Phvwo=
Received: from SJ0PR13CA0176.namprd13.prod.outlook.com (2603:10b6:a03:2c7::31)
 by SJ0PR16MB5060.namprd16.prod.outlook.com (2603:10b6:a03:436::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 07:07:56 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::5c) by SJ0PR13CA0176.outlook.office365.com
 (2603:10b6:a03:2c7::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 07:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Wed, 3 Jun 2026 07:07:55 +0000
Received: from pps.filterd (m0426315.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65376Ea0038084
 for <u-boot@lists.denx.de>; Wed, 3 Jun 2026 03:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=lfQJY3LqTt+SSOSqI6l0W4GsTge0FLAHc/woSOp77I8=; b=
 XHGTB80drBTyvMxIASnOS+pFWLqrPUw63QikLv0k4BBkLdHHYAKZKHxd4g/PMY06
 02usmTSI9vbd6AqBwEiXxxSBp3pokF3QQ6JgQPotXHH/4yHYfqElk0em/cmb0pux
 s5N2dQ5LJv4U0Z65BDnNBfO/pAuShcgFNt22zwl4/ggeU6CMhFjw1Vf/KdMLk3UM
 rV7hxH7WrozQ4Ei1qFbk2qA7iun8FiuaOH2tnwNlS7/AGvs9iK3LOG/6Mj2oyvsV
 X2EQs4/8M/L8hHqoPdJt5A9v+BEhdqjefoNUuSPqaYp6J5X5wCKlFIRh2N+1cTlf
 Qt2+8sPlnqPf4PP6nAzt1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=lfQJY3L
 qTt+SSOSqI6l0W4GsTge0FLAHc/woSOp77I8=; b=nkKTG25evbkTGNgRPd/2cnn
 lSmvc8CwASGPL7vfsQYvIxINbmeFv688MtH61DTIHE+e1dEOj520wiR7umSMhJTN
 plscLTNx3szzwpHM8gggjl+czZcXCm8wMrmbMo2/nZMOD6manx7Y0UePFzReEk4n
 usco74Tp6TSoe3PTcQeOOPOymzSLA2lMa/EtlyeNSiUOonU6AUsePZMzfZPnKgtc
 LDDwmt3/b9uFhq2LTnEdPzCLCCjIFyqEM6G9O3PXhCP/X0rEmf6ibvWM35gvQr6A
 lPX9Tyt3Z1dPq663FhW/igw8hfucjSVOQ1J2toER6LbjteqY4lkiDZD6k9pyrmA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4eghss4fyp-3
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 03:07:54 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id UfhhwfXxgfWWnUfhhwzxsf; Wed, 03 Jun 2026 07:07:54 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: UfhhwfXxgfWWnUfhhwzxsf
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v4 4/7] reset: x86: Use cpu_hlt() in pch_sysreset_power_off()
Date: Wed,  3 Jun 2026 00:07:40 -0700
Message-ID: <20260603070743.1268544-5-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603070743.1268544-1-dmukhin@ford.com>
References: <20260603070743.1268544-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030066
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ0PR16MB5060:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fd3015ca-407b-4c73-2d3d-08dec13ed622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: enY6XWbK+Y85HNbsCFAE3EnHNYFkArRFLTL43KJyHJHeF4sC0iDCudbDuwbz6i8I7Z1Ls175Y9lVCckCkwJLAzid5UWkYRFSwjah4OoWxZk9eRv1IqMLw/fCDFWZIM/zDpoIfL2zc1xyMf68d/yVswiaZ9Ddrl3lw4ObCziDKnKJoZ6rxcx5JTMmQB8O6F5N1farrOVAk6zmKMunq1hMqoXY0V9NG71m8+F2l2ph5n6yxyAZlT1P+IDYXT/1tX4uTxpbBjolFtmGUuLRahXXjP06iuhgdWtT1Nx5gAJtm3hiOzqNOGczNgDKmHCj5xyjAeSMLeG6QFSCMHr5DOkDEBgSdD3AVEjtyg4ik/kT21AmZFPFPOQj/GI4nZB8tV3okxKRzxSGuxYt+2v/YTwiyslTBB9K6MhAqKMOr1VPiU6P4dskhfO9kSkF8voEwWv7MGmscLNC+9I3Um0ZANLCCbLiq8F9sFwRrR2VJwQw33vp020Qp99/NL4ibZAZElRKMQFJ+TtXTqScpGMdXc8D+Ivf13gcBBICRRBIaIkfl2+NaqFIiLbbhDkeiQ2jHz1seEChCv1POPDTwQ1NIcIXw33gVl+aA6omvOHFmZUThlwBBLXdHjaV/5oiFOnFdxUtkd96Jc1XY8baBGS3mGmd69yd2oQ2eFK6Q6dT/SDg/FAu/86xo3H0ElXOmOQvow42wnMYYg4es/RYwElgnc73kejQiuR3CKe6pL9IwXUGU4g=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7xs1kvclE1jTPrC+i5Ec4mX5n0Du3mJ29xEeKMWHmB5arn0OSY7P1YG68CbLWbnM/4rzP0d6VV7B8L4BK9LhaaTuaSsRkuA7dOhvN0Hs0ohqSr97MOdzoxsB2Oye3brXkulQUr0GsMklfvTaGcJ938LCt8wpQWKm8nYh00UAn7WltodpIJnKxLBsMlxti3FnYckFSmfiupcl0OGe+sthtA9Pww6F0j+dj2hah8FLqnh0Jra8W7v3SW6HE7S0Jaq2cqPoTbIjnmLK1OGuE21HBJK298Muh360llrXTrzbvc8D+2INYLsDN1ATHtXQAiX1jSNr8NGRrEa8RqpSIMJYJ3nBzJWMOKr3HYNYLuPNMFhZP+yISqHuU4v3p5PSVRo8I3oAjd1XXROVWB9xaM6l8xRJWX+W5O0ZOXLDtPOWXsKVQ0VEWiIvD35VI/DlKv2P
X-Exchange-RoutingPolicyChecked: YOzfPIXSQ3EVSwNgKIQ8fkUuQsbRwTR0FzPz5f/HukytyHT6prgBNncIXEBlsoNzuwuZVWUTpg0wNr7PafccNP59nOvnlws0kuu9fvjPwJLoFtlNzz8wz4MOTPgAbv17JdtwiNEzsbGaHkE/jmoCxHHDzZox+zUfmUI9IJ518Fero2CdDnWV4fo/7nKgExVzE+tzqCBdyqfkgBL/QBFb4r6lVMxT5hfZqS0wr6PicHSZAYAhRVaS/2S2gSdkoTo/TcFuiloumC7z/ojJFI349PQO0KO3xBmNU/0cE+2uhmU4kKdhtICUbw048rNI3g4syf8D30u9dgqWI6Xv2Hrrgw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jU1R8660unEJyTaPb1uCn14oZsekB4VkQEl8Wnk/N5BGbtgDG2JwnkXEg1PY6dGSj9ykNtsm9xT+We3lu/s5G//9gbhQp6cH0eYPFaJf2iXMtpi99l1aRq1GWtnDpH2n+45ApG1UwmMe6Qo6Y/MuTq9yjpCz7gUbS03uFuLayJsS4uVL8ABmoUgWo6utE9hAY5J7M+eWQ5eNGFdob9cJw6V5JbahZvx/bUS8Gn8IxYWNqO+p9Y7iGZwryIIixqY2Aw77lAn1wNj1bDQAnIEkCb9bHGoqEAEz6TkvuMBQKgPRbY+OlKVBGCvpGsmGF/rbhKFsb5i5qELjIdyAr+WRv6Qc1ZBZi88NZ7/VNkB411nLVYdXzE8I0HLDxrYIltggamz6s3q+zt4eFnSADP/ObRg8PBjhvkZevHnHfhMcn8tH6ZFHKjHpg2ZFR1GIh2vtd8DczZ+80bpsD3DmZzcDzBfyl9DNHAyi92gQ0cey0kTPhRwjV/BQJszdlwVu2/pDKiV+CIGNIYcGOAzwFZjI0nuFyesHv3502W9JkdlktrRaU6DAnjMFHt8+gjpZEBkHR0jjup9hbWBk3yK489xmmcTWbT1rTrkFAH0oZA/K2Y77Z76roA9YJjnnkmXV7KtL
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 07:07:55.5684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3015ca-407b-4c73-2d3d-08dec13ed622
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR16MB5060
X-Authority-Analysis: v=2.4 cv=E8L9Y6dl c=1 sm=1 tr=0 ts=6a1fd2ce cx=c_pps
 a=St4LTB+eVnQVBP+Ivca1Dg==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=AHe91QgOk3R4nFVtG5At:22 a=cbNQJ9GKAAAA:8
 a=wgw2dxOu4lPxt7w3V14A:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDA2NyBTYWx0ZWRfX3QpZcntc7Kag
 W8inS9EXiNNzK77huU/DcRb35W2N/fZ9kEY2v/SjpjqlMnbdSrOk/jKopU5OM5UFBRVDhKdkgvX
 3wPnaKBBN+xQM0x0KX0u7m65/NbOY+l3fBXx/1PXplwLFT1pDfg7Yg2+yg1oa6IxDanIJsjRpg2
 2wFNFKKCnn93GqKZ7LOlHOPGJJbijysvhIvhqg3J6QOhNJYUTWkewUW2xyWMRKgNo8b1ZOzUvfv
 ijbQlKOv8fkZZD/sQ3SW3P3f/e+rFmjfflM5BCSu8DDk5gcaBw4ilIr7cHrgj0iZmOZ9tnUCvnL
 RnX55p+VOKpAKLfTNjK9G4pLyR6vZhvhJKeXmbHPOjmeYyKjSoTT6813F7LT624d1dnA9RaL4ws
 05oB3+HM3GgtRoU8siOXVv3F/0OOz9AJfTqxBNhVvxUWiEDGrKZkRxCygkwc3Xtw16VszDIWb4h
 IxrZsGVPNl40I45QRDw==
X-Proofpoint-ORIG-GUID: x0Sh5kWJCklYK_3GC_6DeyT-tKfxwsUa
X-Proofpoint-GUID: x0Sh5kWJCklYK_3GC_6DeyT-tKfxwsUa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030067
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

Use cpu_hlt() instead of open-coded "hlt" in pch_sysreset_power_off().

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v3:
- split EFI-part to a separate patch
---
 drivers/sysreset/sysreset_x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sysreset/sysreset_x86.c b/drivers/sysreset/sysreset_x86.c
index c2f28c65280f..05a3ff9c8363 100644
--- a/drivers/sysreset/sysreset_x86.c
+++ b/drivers/sysreset/sysreset_x86.c
@@ -65,7 +65,7 @@ int pch_sysreset_power_off(struct udevice *dev)
 	outl(reg32, pm.base + pm.pm1_cnt_ofs);
 
 	for (;;)
-		asm("hlt");
+		cpu_hlt();
 }
 
 static int x86_sysreset_request(struct udevice *dev, enum sysreset_t type)
-- 
2.54.0


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8755ACD5BD0
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 23:13:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CDC7848B0;
	Thu, 28 May 2026 01:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="jELGDFRP";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="JJxRAUui";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="QqXha9UQ";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Zd03hd1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC629847C4; Thu, 28 May 2026 01:13:25 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9BA4846E2
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384718.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKiT0K3303458
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=rBF
 /i+ZbtVmeKz5XVA5mQNuVe682ZYBX6bTQnPHW22Q=; b=jELGDFRPOH4lM6dq6/i
 K0B3IN9j9bAudMtOg6OjmY3i1AQU7ziZ8D/co8w0cHthJXZBAmL4F7X24vyWrDXc
 df+urzB30PGl74DlJawDzOz2RbgRdpPsYDVUzccjm3Tl+CVkspiuO0cDVWQi5we0
 0Y4bNNhXKAKDDLFieKdToWLha/ept60D1hILSFNaj2OyhYWLgUZpi3ZJaITFyNg8
 gUfeQP/QDULXqzzLT/eL23w7fjttoEd0rKPGw4A1TBXT0TIPk6ABeCjAuBUlHU8m
 +ouj3VzLomXvlrQsmd2aVpWHp8jphrLAOz0Smn7azIgjAHO6XiJSrzwOXFMgFFC+
 mzQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012004.outbound.protection.outlook.com
 [40.93.195.4])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wtgtbh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 23:13:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APEJZBgSYFwVMEQsEqr2ou+gKg5YiBRPXQJrSlB50tnUKkMU1DbdUTR18aV0DfV6ZVb8reVNsjI1a9/vJH4PHXyyINCNLtPNYpotkExasXh2vr3S3g51gFOxwexQ41WRCQ2WVXdC/95TxGCQxtxfT3YJKWA0Ov8Nb6AHfbLIw0gcJ8/vdnmibDEdrMszfwjWMbTDW0lTSmLXfWENZtPjVw5C502sFMIl5sLetmAGBfi+u5l2Ka9vQ6aw7SEo5PZzUnbHXCn3by37r2rEj2NR/4EZgRXobKX6/WmyCKhpsQqAgUoKTIMsxtmtagzaunli4mWsWbMksr9HwGKZ3ELDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBF/i+ZbtVmeKz5XVA5mQNuVe682ZYBX6bTQnPHW22Q=;
 b=yIQM1lSxmgvZeqB52MvMQP+JkzCTfg3afztrg0FkP8uTRXapSO0gQxUUN5aqA5UZ9QkcFP9KGODO+9mZQiJiG/2wt3iPdwP62i7bdEeO57y3PpqT6vcmE3tew1t0WZjnXE6lRFGxSph/mBZFxZW1DbZG5e0hZ0/uQ4/UhslDXcGM6nTJIZY5kLojr7AL4jpAVUE4zXafFspdVVoW1CB5OJ/hgFrrD9VJyO0QNvRrxUTKWY5RcDMXLHt4qSBxHRLgIjKMc6VGRgCZB8fmUc/IJ3ubvpXlviUVv2vnVAV9MsCOPKH9fcRQYUxGN5x892cM9aNHVAwtC+pKjMlBqwcVgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBF/i+ZbtVmeKz5XVA5mQNuVe682ZYBX6bTQnPHW22Q=;
 b=JJxRAUuif/+CyDz4Cb+akqblAWXpilr4bZzvf6POr3WA0TE1PFX1eju3XyB7yx7DNTN3n+IQoVD3TQ2MO62jaVmoOgzmWpjS1Nz+sqDXf/qFUu82gy2Ohgw/U82lMSzhIRhPPwD+vxmYUgyPewMPIF5KvuCITghQzdlpQmRDWgE=
Received: from SJ0PR05CA0185.namprd05.prod.outlook.com (2603:10b6:a03:330::10)
 by LV8PR16MB6500.namprd16.prod.outlook.com (2603:10b6:408:221::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 23:13:17 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:330:cafe::43) by SJ0PR05CA0185.outlook.office365.com
 (2603:10b6:a03:330::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.3 via Frontend Transport; Wed, 27
 May 2026 23:13:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Wed, 27 May 2026 23:13:16 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjYwL3407970
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=rBF/i+ZbtVmeKz5XVA5mQNuVe682ZYBX6bTQnPHW22Q=; b=
 QqXha9UQ9jjmXf9HhzJdV/BStZgIAvHY7bsBNMb99oSecP3xmX56wNqVqiOB9P/Y
 95M569x5CuTm5J+Dol/D/dAyFaQfY53IoaFTsnrKpj5RWZ4VsPwdaqMykj2yMrmw
 chcX+BZpRS1MhxjXu3Wxuxj0hvan97TLI19/g6Woe8QgZOzwnf/ph0M2D7llRlqy
 bg0R8cVhCMf8mjdmi4CwsK07pFsS10gIEfyWsVatgkHa2V9nM33IdnvkgcD+q2GP
 WIPwfvewmnqTgXT91iDJjFFZXN7+6xTBU3zMsEiTnvjxfW2bdCKBft+/jRbDAZOf
 OOGiZxwyb8W8KUaprS3PJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=rBF/i+Z
 btVmeKz5XVA5mQNuVe682ZYBX6bTQnPHW22Q=; b=Zd03hd1oyG3/leyj548mC/7
 Fix99uuI3/+ehfIbkVF0S7et/L23UoxYAVmC8eAD3YgUxRIgmAl8GuqFHuo2SHZJ
 HaYqeIGmFfUw66Rga3buXY6X1gcfc3ryjCBxXhnKDSfsBf7GjXzSunL4UlDzLWEf
 6flbQWRj73dH3Ai1//tcopv5zNweXbFNcJc+YbTNlypGF29e5Ul36vryz1XZlMgk
 e9ptyIyExSnQh2aeVab4EjA7sUdy8tUL9p073p06I1KoazfjE9vwJcztEomT2MIM
 ic4Lj3pp2wvnVUbGLNyfiWFlaLMv4unhLKenZS3ZflZpIYLDPw4qoGVKveFCZcg=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x9g41j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 19:13:15 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SNR3wfbGYevQgSNR4wwhzH; Wed, 27 May 2026 23:13:14 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SNR3wfbGYevQgSNR4wwhzH
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v2 2/6] reset: Add explicit cold reset support
Date: Wed, 27 May 2026 16:13:02 -0700
Message-ID: <20260527231306.1714741-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527231306.1714741-1-dmukhin@ford.com>
References: <20260527231306.1714741-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605270231
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|LV8PR16MB6500:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e808739c-22e1-4a5d-1d9e-08debc4588c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: xXjWQqPB3juuxp7OnG5xQr7fvYkb/CftjqiFV3i1KO6lljS/1QUfrTgcHGxtmp//wnitcWRjdHuRxIUYghJGMdO334yg/h6aUUwUE2X2zTqozfEZxcA9jHjvhwDOIbgMkHfl7RTC3HDvBZRx/Mctns8+hywMA/iAu0vnGL/MhY8rbXBys4Zb/D0xsxb0g8lCGKbEU8Tqqt4bW7xdnr8l8q8/X0I4hRvPapuE4t8AlMeUGjLa+tcOKefuCDGz3ctz4qmmMaFV4br+Jf4BPEc2T1Ukk5aegTFsHV3mUYs77d6Am8jRmbSFbiSWSRkRzrAP9cG5oPxQbkn44EgazWuMjEL4Zri/foxV6WXB8D+QF6jCN/QGcP9Fk2fl50C0DuzcHQKOSxchPJOMMvC/B14Pg2pOksqL77EwDCQyEjzKQP3Ocwh/apAuB0AhgLDfa5EcAYn2JLTf2CNnAZju58sQPbLyZUqcapGZvZH6AFd7Vw+JxSPEcDyre2NCHl7+7Qspf3IBhfXFn22zv2++fQAkYTIrqmRClHocaE056lf8MJ25wi6flg2ZMIKaom39KiTDD05/VHwZlELJEcX6oAZ330vx1alPYETOB+IFHICqb3Qez7t144tlo+ziZYZ1GOOclNEl3rYjmJp+FwvIMdGE0RjYaQOdpEyXa9XHhrETTCN8aNJJG38FFmb/juBZwNpgVeNvHedBgH9BZR9jBwNiwzQQL4G5KdmfvGnNDSPPB88=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 25X1h3+Tc88CkETfMjGMr/S8Y26MIaxBR/jmVLS1b556hLmRTDS9Tcr+qsUwQNjucEHMcsakjwXAiHEYWb3dMUlMPZEcXTkVBltlpmyqHsYokiLXPQfCeYZiAZgcQCNkgL4RPItQ9MgVuU0DlmMG5iXYwV5naP6OJC/WNSY6oL3eMmxDT/n/83e9CjkKNvQDW/PKLzdOBq0fTAzh5F9+6ReUeZMMeYwGPvCuhJneu6erRDbx4hCQNzDArL5Di+BDDBir4bUNYElp4JDlG3PZtFCZtNOk0xjqahGMn2f6fNamBq+Jg5iIWgS9dUFTM9zw8ovGSOo011ZqBICh+Ys8/+F6iKkAOJ099MRS6bSEFA6/hQbK3qzYgsND0AdWKTlZWYCNashNj1JFh5M75XmdueyW6mf7DRrWXWHNnzcKj6J5wE0DUAhBhFFSJm3ADOY/
X-Exchange-RoutingPolicyChecked: iWKU4l+hPco5PTJdwTjWJlUcWBaYKpSWgO5B6iULjHpYIGOTUO6j3mecg71E3AsrqVwLA5uk7MhTgmXv2vb7UKMvYJj3TBubnlw5DXEStkezkcOoZQWqW90GHIYqj9Rx7+TcbEZoXp7xUKXLSM7Hh4SYg4O0ZCdAqQe1JZY0Fx58+VxexZw85mWKWBCBRY0WpocdscFLtionxOlvfNnrOCqkt1WgwzW45DFA3EpcP6E+nK4XHsNF5ZLNm6M8RpKoQ63aZq1jWvzNnCBBIs6qgvMHRnwfBZDGyPcGpyxll2DK0VTj6tvCosYYYg2xRHwO5mKJW4X27G9EpHwR4OxoXQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yROHuvtf95UvHC8ENivdYzKk/sgCz4K7/m7Hd/xOQ0X/U1a4Ak1oRC0P+eKxnZEUv5n5DMtGLi8rWEM/C3M7VtRVhYbz3qx8a48Adk7AwJj6DZLejC2B9LwaUrmNQn01Tcuw9evEm7ziaM5Tw1xdIZdOTgapL3P0kA+Vy70n21IFwANE0Evl5CKzfxooXjNURy0Os5MiXqtOOjbZIziLec99ODJKiq0YawPkUb1RkAnQYy/G/yGls53albVEpGlpolnDIS/G/3BJw12nTGyR/hjFIAcGl1ZI5MSMBrYIKywGq3QvWPL4l5YF0y3G315DZA5WPZVBqTUwk9ibMer0SGQObIqy4LiQezUkv7bb9QGauKN11MFQFtTP3csodQYR31RCKGKH+m2mK2dZp3ajf0vUmchEFtMzBL68gNvrPDFxOFXLIFyX7jm8c+/6b+y43rTam+inCjBd62OKb2WlYlXXL1VqakF4BJZhxsGb6tO/QtphceYHHfNxz0w7pudt7dn9OXxwHczAavdCNtngzq00+525uc2kZeAZS38ndYz4oSX345vPRTdh2B1ogG3kGmo16y21qUDLvkV0jnhEhhHFHWT2+QZfmnQm0S1ACCu0hWN7bj9v9UbblHgkff77WW0T0Y3cjEBlsU8Og714lw==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 23:13:16.5665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e808739c-22e1-4a5d-1d9e-08debc4588c8
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR16MB6500
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDIzMiBTYWx0ZWRfXxeXmWGK/Gw42
 VHchnLNqDsychZKJxZpujf/XPWNEPkahI3AUnFNgj6gz+hvYmfXtmVFQR6y8F76s5e2Sp6jOmfk
 VHi17FXBVvF/zBBMXCGY6DSBlxlNcYYO1IdnecqJwiqxM63+LsILZa6ZvmW7D+cXTjyRNFxJTu7
 qHo9Vco5tIARayvu7MZVwZDZpbewrNA6Z5N8eKBsECNMcpFvK4dBORveCJFVDjSjrWqyRKTMGwf
 4eze5I9zHAMTDzGFcPGpMPTKAivsWME86HOcXcVAUB0EaC+4BXOXiH0TucDQF1G+RZXaAvOPrYW
 dH4nK6aXH3l/239Ah5iU5Gcr/qP+aFFOyGlpa5Wxigfxvc+zg4/+HTVMCy+maW8x5xP+s/fhu7x
 hhlXOl74YzzsPz1RRhgX3ZI2/2oiiatHec6fMrzBRps/lrwo3bo75fCl/8qK6ptW9OswOhY6wBH
 k1F+vxQTYuKO3+sghgg==
X-Proofpoint-GUID: 08E4j6-0nubgsAF0TmNJMUljTgRUi49W
X-Proofpoint-ORIG-GUID: 08E4j6-0nubgsAF0TmNJMUljTgRUi49W
X-Authority-Analysis: v=2.4 cv=Ju/Bas4C c=1 sm=1 tr=0 ts=6a177a90 cx=c_pps
 a=eN70jGNn7EKSdYhrfilGAg==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=ARvDHhclS48edyKYUbLB:22 a=cbNQJ9GKAAAA:8
 a=RPcLDelSkFZS0uLvm74A:9 a=G69WFyCBNqGPyalROSdv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_04,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605270232
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

Some prototype boards default to a non-cold reset type, e.g. warm reset.

Add `reset -c` so users can excplicitly request a cold reset when needed.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
Changes since v1:
- corrected args parsing in do_reset()
- updated commit message
- fixup reset command description
---
 cmd/boot.c                         |  3 ++-
 drivers/sysreset/sysreset-uclass.c | 13 +++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/cmd/boot.c b/cmd/boot.c
index 29cdf4a9a81a..2cef907e291e 100644
--- a/cmd/boot.c
+++ b/cmd/boot.c
@@ -59,13 +59,14 @@ U_BOOT_CMD(
 U_BOOT_CMD(
 	reset, 2, 0,	do_reset,
 	"Perform RESET of the CPU",
-	"- cold boot without level specifier\n"
+	"- reset without level specifier\n"
 #if IS_ENABLED(CONFIG_SYSRESET_CMD_RESET_ARGS)
 // All options handled by sysreset drivers via their sysreset_ops.request_arg callback
 #ifdef CONFIG_SYSRESET_QCOM_PSCI
 	"reset -edl - Boot to Emergency DownLoad mode\n"
 #endif
 #endif
+	"reset -c - cold reset if implemented\n"
 	"reset -w - warm reset if implemented"
 );
 
diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
index d2fddb470bf1..df68b5c3f9eb 100644
--- a/drivers/sysreset/sysreset-uclass.c
+++ b/drivers/sysreset/sysreset-uclass.c
@@ -174,8 +174,17 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	if (argc > 2)
 		return CMD_RET_USAGE;
 
-	if (argc == 2 && argv[1][0] == '-' && argv[1][1] == 'w') {
-		reset_type = SYSRESET_WARM;
+	if (argc == 2 && argv[1][0] == '-') {
+		switch (argv[1][1]) {
+		case 'c':
+			reset_type = SYSRESET_COLD;
+			break;
+		case 'w':
+			reset_type = SYSRESET_WARM;
+			break;
+		default:
+			return CMD_RET_USAGE;
+		}
 	}
 
 	printf("resetting ...\n");
-- 
2.54.0


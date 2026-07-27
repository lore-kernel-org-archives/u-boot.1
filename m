Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4788CC53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 17:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BDE8240793;
	Mon, 27 Jul 2026 17:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id acdsOdemeuWS; Mon, 27 Jul 2026 17:29:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 80B8240647
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785173362;
	bh=W+TxuIxl4jDkFgHvE9NGPtnk/qVAmHDm04ZpenRp5qI=;
	h=Date:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=iVfqBZ6zd54vP9UAvIMeWSOlFix6dB6pLFZcgn7EfsuR3AHEuQ07QKJzj7EwpaAKj
	 LHOINemiCW7JRGCHDq0o06BJ19ZHX/NiKqQlH+0iTVIVAkmZvmxC5HJICe4/D8hue/
	 UFcH3vTlKAQpSmk2nP49vjNusn+uAkWQdHQr+25xAch/5lZaLnBNnTIGAKdjtnXDCj
	 5j5zOB7X/qCrRKZt2oW7lR5xNEG6VeYTKV9Xr6iMOVyV+0Kuk9rLyMNdEzQ5guibgn
	 /+cC5n5Pr06nho5Ox5Sifh5lepi2SrEkdsLigKB/6c0QCAkkVB72JeQgFCwZtNZL8x
	 5wehQ1hHKvXkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80B8240647;
	Mon, 27 Jul 2026 17:29:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 628EA4C4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 486EC4016A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4IsmzAHLXvhS for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 17:29:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E536D4010F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E536D4010F
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E536D4010F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 17:29:17 +0000 (UTC)
Received: from pps.filterd (m0482517.ppops.net [127.0.0.1])
 by m0482517.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66RHJuXN2365361
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:29:16 -0700
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazon11010060.outbound.protection.outlook.com
 [52.101.193.60])
 by m0482517.ppops.net (PPS) with ESMTPS id 4fp7wcuguh-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 10:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VY8ICJxoRtbN5OT5Rv4Qo36iTDgJa8e2F3VHSRwe8ktSTqA0PRnxE6gstVd+6xiiTEpdm6hXuYsj5FxvLC+qTJqFuvZYR97r/6AKEWXmGF2BdyRtC/ab0RR2knR6p5OBvJRcLQn+e5NsGqxvhWDj5UY5EZBNyRY0QsQQotBvC195LTwHOm7WGx3hi75mjemnXKHqpwQqSd/beTAdGpYfHQOHPswmeYKG8HcgmXnrhs4IlhqP795xh7oGmKs6oLwk6h84MyLKY0p/G/8hvI0CxIkYLEqujIoeh/nOv9FZ7VXawfQECMuZKDQMznULE4sJj3ck9U7TQxVRilk+AGxG6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W+TxuIxl4jDkFgHvE9NGPtnk/qVAmHDm04ZpenRp5qI=;
 b=PFCMVo20QLGSU71pF8R5aul6qbzCa64PiisTGbOBmMBab/TJC3E47NA0J4BahLnj03LIWMYXndrJ2jkGCm1LDLiPkV8zd9TTRAwgfUwAqJS+yg6giukwyERCjDjS6jk7t4p8MnPUd72nJnVSxAxCduJJ+tG589/e/2Dx9phlWnldzm5DPtgvP0lGjZywU/ZjbmKscvyjewPAhtBwEIcYi5p/ojkT+t77FxZHpx+2VE+hWV3lM9dyzMCsOcEdXv7bwehmNyAwGP7k4Do7yW7y7cx9qUel80z1XXHk8ey4jUoBROjonuZI6TIcRosBPPt4eL643tkJ1c9l8NNii3h8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from CH2PR15CA0006.namprd15.prod.outlook.com (2603:10b6:610:51::16)
 by PH7PR16MB4771.namprd16.prod.outlook.com (2603:10b6:510:13f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 17:29:04 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::28) by CH2PR15CA0006.outlook.office365.com
 (2603:10b6:610:51::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 17:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Mon, 27 Jul 2026 17:29:03 +0000
Received: from pps.filterd (m0426317.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66RGQLbP2844788
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:29:03 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-use.ser.proofpoint.com
 [3.215.31.156])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4fnc7q9wm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 13:29:02 -0400 (EDT)
Received: from localhost ([19.12.92.222]) by cmsmtp with ESMTPSA
 id oP8Ow9W78ERZKoP8Pw4yCs; Mon, 27 Jul 2026 17:29:01 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: oP8Ow9W78ERZKoP8Pw4yCs
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
Date: Mon, 27 Jul 2026 10:29:00 -0700
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Denis Mukhin <dmukhin@ford.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 1/1] sandbox: fix enum host_platform_flags description
Message-ID: <ameVXBb54ICYdIl3@kraken>
References: <20260727170022.13258-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727170022.13258-1-heinrich.schuchardt@canonical.com>
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270161
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|PH7PR16MB4771:EE_
X-MS-Office365-Filtering-Correlation-Id: 651b4e1f-6bff-4b44-9ca7-08deec048e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QpgY+WQdQlksNRJ0q10ajBRN0/nbdkU1OgCjYSXkXrcts08ley3TfWJNnwxyMCXEQXtxKXGMJJFPMMaUD8L35EJmAOR9CnIT9gudL7TuflJYyFJZRoxUUnKtCoYB01EbiTiaqCl1dUUgucuTTnyG0fu5FfmPdPtj/OXGH9sysJzOG1A7nZpTpZ7dflPbK/PpoFaqKAEiRqLWU5hgtEptfaODqsTjplMpXYx21vLQub2nf5qZkEYkh/g4DKLJrKogobArNj4MpmnadoTstK+9yaKlDutYmIAFMMDcsknWOvBwqLgkEsWnH2oXFyUl9ucLCZAWYJOekrByseuuJEh1ZjcF1LTw3Y7QoyEHb7HDbc91Y0YfHXDlMU3wVTF63Fbyzlq7/1ANLnBPnxJKCHa648Od7JFeiZShHPOoJM+LS+ae7gJpsbW7SzGqUQY1XwOBcjUGNmy1cLVRoVEBGkh6wUguVdYetnlpchb5yfyN+lQfE2cr6N66lYhn1btqNuc34EdbUqBGy8EPfobVwvKBo3/a5q6oURjA3JZIvRahRLg7ZTUC5xijJ6CqM63HQvLWCFesI+I6Vb3U7MyvSNzZ4OAj94R7GLNvV2rhllgUDCX3ngAkMxqPqYWYuhfr4/7OgK9fccYHG66QHRpjbdCa8vhwOkywPDKzJPVIeE+xKH1ZmquiJu4wtdd9SPW7lVxXoUyTh9bKLPMhiJxDwQleMw==
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ok+yeHXvrQg7KgKn5h+ulYLGN1h9yRpqRKP+IulmhZ/YNMsWZeaCS0VAOaDhx24Zz7wQQBVevq+b6hE1uRht8NN4J7/75P1+tJRH8qqoN0YPzufH1dz8WbYVyKQebhw7dUHX5ix0IWDzLWILCqbK+0u7XRHplqRygYMijdVNTcDbl014eCAhvKehosiZS3udG2DhXWvpoLvJjHB64kD5QG/GiOI80EWY9B2Fs+uP23jRYpkQcKj9ZJMo3S6oBayaHZ96c9TR+1coWbwehH3NV7oqfPMacZRRrJOtjncgrwHJ4gQFHtG5yCyoG07mxU3Dqtc54nWxZfsKgByH76B7vkZQ4lHFd37urqryiu3xmcmGj1LgudQ9B4hpTV+bG3dga/9wDTtVP1Cy8AwTqupegQ9F/p/VtwuIfCQ+xxYC8qW19qBX6ODsG72aZKGiSxAN
X-Exchange-RoutingPolicyChecked: mX1grFU2bPVf4lXSmQmw+xOwNsu5EP2UqDnWXzpCmkBFw3Ve99GhLi70IbXqzif1ojkgrWLxPLq1WR+nMWSvG0kfn72Hek2AVhQdN0U4dM+palCL9lxMalu/Oz1RPcuM/gxx8xUEfIHnfMX8sbRDDkhV0BY0P6UA+pM9tPSTpjDOs0Iiz9gf73CQCh/jYYrK0x3WlBAo0YyOiPwv9TSwxJ4U+mf6DUXlAQPx5mV8wk/4ssoDVoWQp/EeF7ixCdJQFZvcQIeGA0LeRktuJ8IcA9yq3hw/JfKyRAuSJTZNoVjKfpw9ZL8L958RBE1hlnZhUsPd7RpVBoocoMMPE86jHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DxAFp50WnCI6+2wBoyce5uhegZFHWDef7ZhXGyoOqH6w3Rq6JKXfOgLxuPq7JZHNHUN5aq+fogOzNtyx/HA6kNEWUQuo+im9rrJT8iTVFqYMUTyWS8ij7RVbOtKjii28xhyG4dTpGiMbV+yQRGE5OFriGGmLOuO6urVgZZopuBuQl0U5cfcavuGE5fYBkpzHFnYAoepKt60X62NDvpXVgON5nJwKf6u5RAXl7k48R536yC0f38a+YYqQsE1CdsvKV9/IqiqS7BVget/Vib1PpZ1M2/tjYhjuNGMqh8vdQm63UDB2IAQLMlUBgpHJBg1q8+7WO4zk6Zg/K33DBYHG0040vENoP1hsMK0uoL/qM77NZ9Et6VKNlwVEAk1GVNYul1hy1qGQjBDv9NmhEOTMGCaUAkpRGiGpGQb78/HCVcUz0j8KQC44cLQcmR95Umpm5lqH1rJDf6ZlLubU7ivkAJ/EfIvhky+JA0KBZWWurzebZm48TDrXXVI3DLKpoMwjMGZnE8xouuVb0lt1cnuu3EJvrZGFXq1BD525H5hGmMxiIonSCO0BFLNySv4t3URGi67zJgdbLdrrj3NqGZW2ddwf2UwPK4brDKZyzJNntsAsMtgm7JvCj1PR8gp7adp7rImbkrQhXO3d9lfQvoZ22Q==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 17:29:03.7984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 651b4e1f-6bff-4b44-9ca7-08deec048e0b
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR16MB4771
X-Proofpoint-ORIG-GUID: CjQM9pOgMFkENlU8lQWdfmL15MOocCG5
X-Authority-Analysis: v=2.4 cv=QaxWeMbv c=1 sm=1 tr=0 ts=6a67956c cx=c_pps
 a=8uZh/oWqEamKeU/uFK3X6A==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10
 a=3PXLN80vpJUA:10 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=P_n1zlmtWsCQbjROFjcg:22 a=MLwXIh1eZMowsRZfVxRb:22
 a=DfNHnWVPAAAA:8 a=cbNQJ9GKAAAA:8 a=BdR2BbxZVKgWel3BgFkA:9 a=CjuIK1q_8ugA:10
 a=G69WFyCBNqGPyalROSdv:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE2MSBTYWx0ZWRfX3nO3cTDYYk/O
 h8Phcj3/L/m1zSVU/fRbQOck2dSrMK947V2ux31yQwhVVAp0sk9UVrTPX5K/8RGzVpBk5ysBb9n
 bsU/8wm6+L6JFnduxSo7Ayr4Vde1ki0iPcFksQV4cq55AfYaV5p4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE2MSBTYWx0ZWRfXxGkDQ4EoodC6
 0eNxu2wOQwkrlXLfg+NNwBua86Q2lf+yq3So2cWj4sZLO0ZfRnxUgTD6I3qCK5s+JqNid976/oi
 t905oK/GXfPM4bZWmZD8TTI/oWuy8gF5AcEbq89YJyPifDIoaxM8arpGQM3mlXFPcDmBmYl6Jbj
 YW62Pfo+thjx8gxL5PRxyaKgNpEQmpx9j2AYYnW2ijfafGcUoDbO0RLzpFPneVtQWPy78JUBb+D
 QLiekmGQuba91NoLCaCxuWxg2d+DNuxexeFfsKRTzd3qZH4Z9LWqf68O5Hc96HnEVBjYKj1DJxL
 gXaYP2XOJbuMoEB6QWz4bp56TOnWTmAzQQw1gf/Lnx9j888OrtFAgZgHuS0qvLAqQ1Urn6/Bafl
 /1JrxbiokwAI6fKPYYlTwC9MCCcBbau07WdP1tjndMQRH1JHJaeLWOrk71XmY1bpfr+3w3A6TQm
 jRZRAawG5oajkJgCO3A==
X-Proofpoint-GUID: CjQM9pOgMFkENlU8lQWdfmL15MOocCG5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270161
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppford; bh=W+TxuIxl4jDkFgHvE9NGPtnk/qV
 AmHDm04ZpenRp5qI=; b=esar1nVHQ2pAEPW/MIGaOdZdAYm4k8nJ0tXC/WiWy8e
 0//r35RjTvC02yB83HBOtD/3FdD3zvWULrlJOlU7TrwC7srutiPkbqKDv4yKT0JR
 yH4UpSWc1OTHErIqU6UbJvYIt9WnIole3oCCTQWlxqhB0fjBFiYtbOWiMMHD/Nvn
 RC1H0xQ4qoRtq8BZY/H9JzHYyFAQt8ZSFnNcyKgpkAgQ1gL3k41g3Jch3/lq/OmJ
 iHmgkXZAtvliGJetuFmeagOBRzEpGI7vk5r+IAUpv9adLBEMd36/OQHm9gAZTl5T
 ZYwG02f7KEVYPkCf+Ufg5SG/zJEfRY55KKKVtF+S7Mw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+TxuIxl4jDkFgHvE9NGPtnk/qVAmHDm04ZpenRp5qI=;
 b=WtV5q0KCTiWFsXWMo0wco8B8qm4BQ1tQcF6sNqqBSvalk8F/orTb1XansLIOVK47zz0PeKLvDNWBZ+Kr6Fu0Rgkmtg/BozoA9hQ62WKKvROaWBFEYZJFgHnRWm48Qyc6UkjDezFMhUgnr6ZDrwKJ4EKPKWD7LoS40JSsd+lBB/s=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppserprodsaar;
 bh=W+TxuIxl4jDkFgHvE9NGPtnk/qVAmHDm04ZpenRp5qI=; b=GJMp5JRGK/bl
 hVX1+PMEUsB+4+uW8C7sHfA0EYlav27d4/BPCB6kdat5GyUC94qgNlvkkvgeG/sI
 Uct8Qg78jbep7pekZlJVKIL97AV9RQZijzaySy15ClAlJz2j2I1DLamJFVYyOHot
 lR33jY+1o8waP3d0MZfSwi/7nNGXHSRWJ5rvnLXblmOauhEYQf5+vHLH+L/dVXlI
 FAb9K8XcSKdVoItRlvKDkr4nFOT0H4AkVmhX5yjVviQ2YWgPtMirEYjIb9B+EBnw
 PnXqB9qiqvLK34q0yDp7cY/5JMDmHPmrL1/jOfSr3OCtjx6QIXUfpG+fGnkGEckV
 dkQVlhmy2Q==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=ppfserpocford; bh=W+TxuIxl4jDkFgHvE9NG
 Ptnk/qVAmHDm04ZpenRp5qI=; b=Tf/VM0ACMLeXIyAyorXnepQ1L92n+CQkL+AQ
 KL7QMFRqNJ3PzjMwSnLPCDrqOk4yj3ZlE5Xb21UJT1szF/in82WaiMpeLCx73kcf
 w7c0SM8pvoytfw29rw+jL0ZD4py1NFhZNVUKRoU3h4yZ0ZoQC5sZCIzii7uPMxaX
 S6HUFG+APLggbImlERyAqByKicQ7J1IWrskty1lL9LM32OPt6oO68yZ6dLu6na2f
 zNvZtbs12qqKRUClanQQK016gIwvAC0dL4ihiZAvf84fiHJlgTzan59VjwtrvCP1
 iNSD0AOpfD+KlqP5vtq0Qb6Qa7FFVSAmfvFihoqz2H4trD4msQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=esar1nVH; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=WtV5q0KC; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=GJMp5JRG; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=Tf/VM0AC
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Denis Mukhin via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: dmukhin@ford.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Mon, Jul 27, 2026 at 07:00:22PM +0200, Heinrich Schuchardt via U-Boot wrote:
> `make htmldocs` reports
> 
>     ./include/sandbox_host.h:14: warning:
>     cannot understand function prototype: 'enum host_platform_flags '
> 
> Align the description with Sphinx style.
> 
> Fixes: 93e9af685fef ("test: bootdev: scan with a broken high-priority device")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Thanks for the fix!

> ---
>  include/sandbox_host.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/include/sandbox_host.h b/include/sandbox_host.h
> index 1330358ef7a..8329cbba537 100644
> --- a/include/sandbox_host.h
> +++ b/include/sandbox_host.h
> @@ -9,10 +9,12 @@
>  #define __SANDBOX_HOST__
>  
>  /**
> - * Device flags.
> + * enum host_platform_flags - device flags
> + *
>   */
>  enum host_platform_flags {
> -	HOST_FLAG_BROKEN		= BIT(0), /** Simulate broken device */
> +	/** @HOST_FLAG_BROKEN:	simulate boken device */

                                     ^^ typo

With typo fixed:

Reviewed-by: Denis Mukhin <dmukhin@ford.com> 


> +	HOST_FLAG_BROKEN		= BIT(0),
>  };
>  
>  /**
> -- 
> 2.53.0
> 

Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF5FC4452D
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 08:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 44007407A1;
	Wed, 22 Jul 2026 08:15:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sBypJbCVGoWL; Wed, 22 Jul 2026 08:15:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 27F664077E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784708135;
	bh=w1QsOergX5b3ebL1O1DLji6qZyBJ7rakUP7x6lW5cr4=;
	h=Date:Subject:To:CC:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=E6xgurh+LqyPVxGSIvkxhvtAxeezepj9Wr+n4fQSWIOzeZKe3YrPLhR8A0fLsA2Hk
	 YEvkoNkPGTdEHSWVAxKn1a9nYXmiDlomA17YNHQmwx2K/h3l7ksKDzEB9A+P29wE9p
	 81op0nvm6BVEe4tbnt8EAUnqmO1H2KWaICSIkjUo4HgRB0wkNsaBCS2TZMUeA3u/ch
	 CLtzGkOrIDW5ei3K5ojw/loKcX/3CcaOKf2cn+4BQ+jdNjQVV+gq6Y19X16nW3A2uY
	 3gezd/O8DUDJPo1JUftY8X+byrxiCq7LrbeVRR5bvKJSgIlXZPDRi5wfaG/CeHlcVF
	 AcEtOX+vknPBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27F664077E;
	Wed, 22 Jul 2026 08:15:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2D831313
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:38:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 13CE960692
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:38:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SOoNI6H473A7 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 05:38:01 +0000 (UTC)
X-Greylist: delayed 2491 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 22 Jul 2026 05:38:00 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org CD7306061D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CD7306061D
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=gehariprasath@ti.com;
 receiver=<UNKNOWN> 
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id CD7306061D
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 05:38:00 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M4YGca2747977; Tue, 21 Jul 2026 23:56:16 -0500
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fjpxvr2ag-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 21 Jul 2026 23:56:16 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g115qa94Ou8d+xWe8n5NTYRo+/e9Gz22ypDUXpWpPVkc+SP4+Q7ge0HL/yNvfFhO0zlmzRWE4CytkoX8zRVYKD0sPD4KsWToqCXuEPODwAC+9Y5d3joVz7rh19LC3ZnzCCgK50gVZLZKzl6xelmUrDNBx4RNdtu2A4CYgVoJzfG6IZfkmwABRb1TBBkAG2SbV28aJCzcfl+ncITx+MueDUjY0f3DPGkXE4ZgsuVYN8VGyfsObP9JuQvm0j9dRAqUDi3DgV6jDH7ja5ZSd6vQQ8n84CPkhijqPUbQTufu5vwYDuZKaw4P3QGY0m3sh2QsyEskzYPBISyVYQaoEa2mBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w1QsOergX5b3ebL1O1DLji6qZyBJ7rakUP7x6lW5cr4=;
 b=C3d4ukKP1xcnacLQNTkTpuesb6xWFxv3EaRiWjOG7uHrGszCDP/iyR3VGfLw35UygLnyTYSzRY9oUy5fKbruumCGAby0y4SGv951s3X2ja0HuOE7jD/vcfrET3iu8zVP1vFzP9FDjFzGGD5VfF21ZhX72FBbHzoGrhfVEXzpQkGYaOcos38kqVVYFP3r/HoBw2kThSq7PLr+Op4N+UIsQByQqlc5xIhYBYXdNDhZ+StiFVgoPpFHflB2I16kF19sUaCEsxoweI43MMUGBxNt8lrhkqIm+43ZrhEIQtB68KUa7pO9FeWA4JF7nmqi1GHsaFDGXUaYbPbKpbPygKP7vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
Received: from PH7P220CA0142.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::12)
 by PH8PR10MB6480.namprd10.prod.outlook.com (2603:10b6:510:22c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Wed, 22 Jul
 2026 04:56:13 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:510:327:cafe::8a) by PH7P220CA0142.outlook.office365.com
 (2603:10b6:510:327::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Wed,
 22 Jul 2026 04:56:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Wed, 22 Jul 2026 04:56:12 +0000
Received: from DLEE202.ent.ti.com (157.170.170.77) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 23:56:12 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 21 Jul
 2026 23:56:12 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 21 Jul 2026 23:56:12 -0500
Received: from [10.249.138.105] ([10.249.138.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66M4u9Ih3016491;
 Tue, 21 Jul 2026 23:56:10 -0500
Message-ID: <c1278a52-9499-4a28-bd1a-6b9de603763a@ti.com>
Date: Wed, 22 Jul 2026 10:26:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: sa8775p: Add SDCC1 clock support with
 frequency table
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, Sumit Garg
 <sumit.garg@kernel.org>, <u-boot-qcom@groups.io>,
 <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Casey Connolly
 <casey.connolly@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 "Tom Rini" <trini@konsulko.com>
References: <20260722-lemans_emmc-v2-1-edc56ce7b768@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260722-lemans_emmc-v2-1-edc56ce7b768@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|PH8PR10MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ea99c7-aca7-4ad9-37e7-08dee7ad8de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|10067099003|56012099006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: fgiyux3VoDWbxLbhUJWv1hrVl1ibB0ZtgugDiWtxmg1tZGixdiFE4d/O2sxXamtRZ39KTEGvUkAuw0qdhs1+rW/sswXQH+sgDFatMHpxaIm1YOij1RD4qpUXjZDD2DcdJwF9LSg9B4VBaYSbYuEoJ9qH0fESRqhEvdJIuVwIkW9/V2JaXBb8zuUx+EokpxGfyXV3JtfglQiB9T0eeLJUzDUQNB65dBREe/M5RYW+lO2enx9bKE8bK4HzJkhpqBq1ESPsbiKb5rNMwSn7nDVThxBukCEw2je5UAjTNA2v41Udqbi3Vv2bESpzZfwhM+USpeyf7q3vetQEs/tnTJ1MbkpZJCaufbVwa+XH+dx45gsiW8S5LF/Qi5k6v/oVk0xt3PJsLCErwniV9lzFSVipERTxiuAhcGAQFmTmWH3OZU41BLU9T/qJk0PfYTSIU+fyZ9RIo7PTTKIgRbpvDVCWW7UztOt22l+w+v8x7p+jhClBIhA4SzQxANGKzUMgsWC2x1rSouBym9eywqUVXNcSl0T7wW0Of0C2ZpaUx9JkDuN8uKmSKIh1WglZoZEvEZ5oAmXjWWPwiTYhG1WwOYSERHZD6TSrkEmNiAE+BUp1cab1kKmcrOkve0WdCmrgjREqV2NWuF8RDUvJtI9Kb7Oo4Q==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(10067099003)(56012099006)(13003099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i/NO0pzhhWhyabrhGidTqYZAAg1AnQkAMHGyS4keGd38p0kQmHJ4wBwRKf3M9yA5i6stS+HB6HuHYap5jAk7j2EgG24K1DY7H0XPm4xRTyRzYC6+ESm32Zi1gigxLC1m2ZRElw18lFJGEk3e14wdwRCZDdV+nsz0gzlnjfGiLp9w1xBm574NMc+WVT1TX+0QdicdJB/oBE+gkKNLaHTcyP5U08KNwTruuv0QhfBgy8Jq2ugeYFno/kVI8cqmOgiV/B2LNxKAFFMAbPM3m76y9WWe4P28t/7/JzR3geab0dWiNJpY+bEcFUX8O5QH0pmnN/YFDaDlZqxI0vahCm8NcJt58cBv10tlHc+jU/1EHL5nomoJufy7UNCeU9bOByZLvhjALGrWzai7l57KH3+UfUBIBjnPi7TBiA5/l8qIrQnkKCBxM2BiC0cGAlSpiNy4
X-Exchange-RoutingPolicyChecked: WEJ4WcBBwtvxFChZBBkgl5nYGVx9h+na5wZrGpZmj1VHEqsV2UMuT3RNI35QOW2A+Jk2F5BaDUBXSUcattIzfEFN9GUTGEp1GZYP6ZmgX0MydXISkKLddsyNnAzOrIiZJklWFNzAt6jqiqAljLISC7LOGs8I6kr4ixM5DyjY2+2psowVqLTtqdagDBgruEl4xx3mmZJ3gqYYjcW58LmY5rWJJ7MCNZMwDN2EMrS3bTCuBiumVoB35yCLMBrP+rg9hZPLQZAVhMdq206EsqW2GU9nPLGyEFn9zIxCjm+IRDIxM+Sg2O/bRswUpUyCyeaAyLabRVd6WTcOBBlGuAYB+A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 04:56:12.8335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ea99c7-aca7-4ad9-37e7-08dee7ad8de3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6480
X-Authority-Analysis: v=2.4 cv=J+uaKgnS c=1 sm=1 tr=0 ts=6a604d70 cx=c_pps
 a=vMZ8N8iCC09X6dpNzQs02g==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=T0Alyp6onfM_nMLPM5YA:9 a=QEXdDO2ut3YA:10
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: DmEhylMEe1BQ1vwadTDOGn4hDzV9FrDX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA0MiBTYWx0ZWRfXxiTuPi0t+LBi
 l4NfVZHTNF8Ilh2BV1g4aIbIkRYNUPlpGoIwpfXaPcNKJNo99DYu9dRLI4qyCCQ27myXnPvt/yG
 1ClVZOmnNNrLstlYGe8KT66o/ah7n4hJxF6I3EmLR3vgHepxaxV6eUWSX9fxl/y+3itSOcKJVD7
 VECTm71N1xt3BRlid6ktEfjUS6NoGJ8jjLQwjTC4oH5QnBsIegnl64R+jnzeUHWEab4kdoPYqvu
 nUmxwD+yi//lLTXxp2b0sSqhAR5UOOF7ngY/V3PiG9T7hvCWJqRpoMr/f4Z71jhvxovdRjxKoZ5
 uXrowAu8PcHxy2CWHcrjz6wzmXLxzKGwVcXKacNKGntRGDh7bPSJytE18jPJSSSuBIwsoJkDaeq
 3KQkdvdv4qDVcvq0NZ7DLpjZBSz8/gnUvjzqn22LzdCp8UuCwXU6mMLl5jUHfFS+wAXc1MP87/F
 UmAMuNxU7e/3Nuh0cNQ==
X-Proofpoint-ORIG-GUID: DmEhylMEe1BQ1vwadTDOGn4hDzV9FrDX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA0MiBTYWx0ZWRfX1i6jfx2TL1K1
 pwzdcwwEgnuS5tST6BvuYfi+WDoYe3MidNBkc9Wj3RV4lo4eMctaZeX2O4H1dScAGAPNOAv59u+
 io6XMFL4/BljvwSGS8J35uMaYXZdSPg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_01,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220042
X-Mailman-Approved-At: Wed, 22 Jul 2026 08:15:34 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=w1QsOergX5b3ebL1O1DLji6qZyBJ7rakUP7x6lW5c
 r4=; b=MYti8SzoH76vtgnyBzelPz3VQihw88z6ZHeV178mijf7Deq9bwimDjm3D
 /qUnSGxNvYUNmSvDqhq3MSGh7L1nhISJ9dIFmojO/eU9n+srHk6Vu/AkDME36pxa
 PMlY6LMcAcE1wkGc4pYNTJmUqYa0N6C1ZX/4mm2Tw/Xb2NcH4Ci2g08C1rwu4Uk5
 HJAjsALXZLfVytl7zcndcBNs+Zzx+xu271A7gdU4GyLiqsHn/3pM7K6V0fMYqrpw
 P77+ZRDF16qlHML7SOUSPqNHrNnevXN1JXndV24frdbklY47PQSe5FTCMnOALFaR
 GqR4/jnSvE6rtvqIeRYoaLX2troOg==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w1QsOergX5b3ebL1O1DLji6qZyBJ7rakUP7x6lW5cr4=;
 b=HluKz1JN6gG9iUwDdLvSmhbz1pBpIsy0VGeJjqlwKwOsrPL4RZ5gOeUF8KGYYW0l+vorT/9LnzQokjt/v0kiWc9pU8fdpDEx39H+TnZ5J/JBVIfQWTqJE9WgCjsGgjjoPY+oilJuc1/L0l7lFCi2f8Hk6L9EX025WSUVw1gLiSM=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=MYti8Szo; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=HluKz1JN
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
From: Hari Prasath G E via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Hari Prasath G E <gehariprasath@ti.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/2026 10:04 AM, Balaji Selvanathan via U-Boot wrote:
> Add support for SDCC1 (eMMC) clock on SA8775P platform.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
>   drivers/clk/qcom/clock-sa8775p.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clock-sa8775p.c b/drivers/clk/qcom/clock-sa8775p.c
> index 7eec4aeae48..a5e84ffba7c 100644
> --- a/drivers/clk/qcom/clock-sa8775p.c
> +++ b/drivers/clk/qcom/clock-sa8775p.c
> @@ -74,6 +74,22 @@ static const struct freq_tbl ftbl_gcc_ufs_phy_unipro_core_clk_src[] = {
>   	{ }
>   };
>   
> +#define SDCC1_APPS_CLK_CMD_RCGR			0x20014
> +
> +/* SDCC1 APPS clock frequency table */
> +static const struct freq_tbl ftbl_gcc_sdcc1_apps_clk_src[] = {
> +	F(144000, CFG_CLK_SRC_CXO, 16, 3, 25),
> +	F(400000, CFG_CLK_SRC_CXO, 12, 1, 4),
> +	F(19200000, CFG_CLK_SRC_CXO, 1, 0, 0),
> +	F(20000000, CFG_CLK_SRC_GPLL0_EVEN, 5, 1, 3),
> +	F(25000000, CFG_CLK_SRC_GPLL0_EVEN, 12, 0, 0),
> +	F(50000000, CFG_CLK_SRC_GPLL0_EVEN, 6, 0, 0),
> +	F(100000000, CFG_CLK_SRC_GPLL0_EVEN, 3, 0, 0),
> +	F(192000000, CFG_CLK_SRC_GPLL9, 4, 0, 0),
> +	F(384000000, CFG_CLK_SRC_GPLL9, 2, 0, 0),
> +	{ }
> +};
> +
>   static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>   {
>   	struct msm_clk_priv *priv = dev_get_priv(clk->dev);
> @@ -94,6 +110,7 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>   				     5, 0, 0, CFG_CLK_SRC_GPLL0, 8);
>   		clk_rcg_set_rate(priv->base, USB3_PRIM_PHY_AUX_CMD_RCGR, 0, 0);
>   		return rate;
> +
>   	case GCC_UFS_PHY_AXI_CLK:
>   		freq = qcom_find_freq(ftbl_gcc_ufs_phy_axi_clk_src, rate);
>   		clk_rcg_set_rate_mnd(priv->base, UFS_PHY_AXI_CLK_CMD_RCGR,
> @@ -112,6 +129,12 @@ static ulong sa8775p_set_rate(struct clk *clk, ulong rate)
>   	case GCC_UFS_PHY_PHY_AUX_CLK:
>   		clk_rcg_set_rate(priv->base, UFS_PHY_PHY_AUX_CLK_CMD_RCGR, 0, CFG_CLK_SRC_CXO);
>   		return 19200000;
> +
> +	case GCC_SDCC1_APPS_CLK:
> +		freq = qcom_find_freq(ftbl_gcc_sdcc1_apps_clk_src, rate);
> +		clk_rcg_set_rate_mnd(priv->base, SDCC1_APPS_CLK_CMD_RCGR,
> +				     freq->pre_div, freq->m, freq->n, freq->src, 8);
> +		return freq->freq;
>   	default:
>   		return 0;
>   	}
> @@ -169,6 +192,10 @@ static const struct gate_clk sa8775p_clks[] = {
>   
>   	/* EDP reference clock (used by UFS PHY) */
>   	GATE_CLK(GCC_EDP_REF_CLKREF_EN, 0x97448, 1),
> +
> +	/* SDCC1 clocks */
> +	GATE_CLK(GCC_SDCC1_AHB_CLK, 0x2000c, 1),
> +	GATE_CLK(GCC_SDCC1_APPS_CLK, 0x20004, 1),

As per the header file at [1], GATE_CLK appears to be deprecated. Can 
you verify once ?

[1] 
https://elixir.bootlin.com/u-boot/v2026.07-rc1/source/drivers/clk/qcom/clock-qcom.h

Cheers,
Hari Prasath G.E

>   };
>   
>   static int sa8775p_enable(struct clk *clk)
> 
> ---
> base-commit: 042e45e026c77227319a426940577856ffe62e7b
> change-id: 20260721-lemans_emmc-f2ccc04e89d0
> 
> Best regards,


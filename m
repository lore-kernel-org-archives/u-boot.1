Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3376C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 10:55:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A13C38119B;
	Wed, 29 Jul 2026 10:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YQSIusOJXIPV; Wed, 29 Jul 2026 10:55:31 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A55781140
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785322531;
	bh=pdMOuhgG/Y0P5nfnttLkhjCeLV1x7m6Af7fAMdvGiT0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KAy/ziHwVF7HNto/3YGC2dhrO2fdqwBnK2k1RVMqfkry+vs2I8LBxuUtPLdgXacui
	 6aOoo2iKEjLXRxLPEVxIeUupG/1S5skwnETl/opO4IK2opLbhyvHX5Yve9qanMBMzY
	 s2sOtX0Vi18hK6omjhrip646Dolab2545Gnbi1J9smHFpyfgZlO4J00E11EqURxU1C
	 M4w1N52zvdY7/nOEy2G8tcZkdvrqBSw4YJS4ZKbLMkiAaTSGq9npB3iGGxXwikn9U5
	 JFE8PSCILfwHjZm7qSR93TLWUj4WAL56S1URWEqh9TaaEYjuVOohTY5W0Xt41h7MNS
	 SMQrKgunejCsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A55781140;
	Wed, 29 Jul 2026 10:55:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BBBB490
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D3B0040B7C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OPRJ8BB299l1 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 10:55:28 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3A19840BA2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3A19840BA2
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3A19840BA2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 10:55:27 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66T7efr22162181; Wed, 29 Jul 2026 05:55:19 -0500
Received: from bn1pr04cu002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fqcwv1200-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 29 Jul 2026 05:55:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXHAvHJ/p4hAOyrfax3cbdUImuAyiMtAeSQ0m9C5JLnYSLrZ9X8qxZaZI/1EEsios3WzkOBIQcfcz7BCVgSrzYm/EK15OFl3IT12CU5/BofIKItmyOkuhG326KShbhveBoEqMsM7Cc2bjZ4Gxl/qweHPzl9/Se0PxxXlB+yT3Ee+NGzseJSV+tkypx2Cz4cCIkUH7AXh3G8IUu24lsE/kVTIkNhGoSP4xeTWmQ329ORitBei4REJYncfg0xOfeWWkIOyazkbIo3sh9PTlX4Vs3Y3dZVXgb/uxcuZTvdiPfPlrF/tpClxnZ/M3xkOLtS55a2EGcdw640jvYUFH/BjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdMOuhgG/Y0P5nfnttLkhjCeLV1x7m6Af7fAMdvGiT0=;
 b=xzBTBXfKtoxwyUNuGm2DIvfsw8rBIvjCf78s5N9Kf7fYBh6X/dEiyIP1IP2n3Xqe0pIOlgeKimXHgwoCOGqGKq8A0Y2/slX8higi9HZB59/tnMkiVy98YM9mH+KupY94v+uoAhfUn9IUFWkbLlREOCOZSehtPjzr+6onfsPg91ROC4g+QdUY65ak0fjhaP5ggbR11APUoah9T1SndkEo+j1uY/c8JjRuDxTFd48tW7OE7Ydww4zw98iPAje/fWDKoXYSd2WDUxz4oKGM1FZY6gGZqffshWejVgDcn9u7q03jlYB5RM8Qhh4P11B31bUvRPB/Ohyar1FnwnmueF2mAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::8) by
 IA1PR10MB6735.namprd10.prod.outlook.com (2603:10b6:208:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:55:13 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::28) by MW4P221CA0003.outlook.office365.com
 (2603:10b6:303:8b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 10:55:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 10:55:11 +0000
Received: from DFLE215.ent.ti.com (10.64.6.73) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:55:08 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 29 Jul
 2026 05:55:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 29 Jul 2026 05:55:07 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66TAt6qA495890;
 Wed, 29 Jul 2026 05:55:07 -0500
From: Anshul Dalal <anshuld@ti.com>
Date: Wed, 29 Jul 2026 16:24:59 +0530
Subject: [PATCH v2 1/2] arm: dts: k3-am625: add template for tiboot3.bin
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260729-k3_binman_refactor-v2-1-9a66fd170040@ti.com>
References: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
In-Reply-To: <20260729-k3_binman_refactor-v2-0-9a66fd170040@ti.com>
To: <upstream@lists.phytec.de>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Nishanth Menon <nm@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Wadim Egorov <w.egorov@phytec.de>, "Francesco
 Dolcini" <francesco.dolcini@toradex.com>, Aristo Chen
 <aristo.chen@canonical.com>, Suhaas Joshi <s-joshi@ti.com>, Bryan Brattlof
 <bb@ti.com>, Neha Malcom Francis <n-francis@ti.com>, Ernest Van Hoecke
 <ernest.vanhoecke@toradex.com>, Sparsh Kumar <sparsh-kumar@ti.com>, "Anshul
 Dalal" <anshuld@ti.com>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785322504; l=19468;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ONLGIKoK0cP/0WsQOETmNVilffZvL6nma167hMrFxU0=;
 b=1Rlc7ELsHyQeBeVLsHvR5XFTEhzWteYM3ceseYjK3NKa/HP2wwCxAViGLxmbyD5iqsF7n6Bum
 AyoHfZaZvyMA4hq4/Mb4O7jyeVbYRsdhJjabU7AqLiP6RmyRBsIYBw+
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|IA1PR10MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 015cd383-9c91-4b00-c335-08deed5fdcf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|7416014|56012099006|10067099003|18002099003|3023799007|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: b8Ltg8xXEpIX+tvdkcfmfFPMMXWUNBqB1V304kahg0ZTv4oSgAsW0XKRzkQoND2hJk45dK3GP0UUqc6+tD/DScJg+eEhhmC+eKgS1aS5APbws3jNguH+gR2aGKTLURGDUbTaKNH6HRaUFaSDGPxVpH5BsyuwSVP/krb2pBH5Ijavaq9l/iMdNwIxq7wtiXt1KOqJKIdYvk6c6K1x4oNn3Jlx/36YpNBCditB968eMjtaLWrvoknS1ZvtHL7RaUnCu2mk3MKmQM4YSTePw4h6tz1QY6XPBZ3mgC/wlkq4v+OVIqxtDYZPWMNEaRZt0usiiZH4y7sR8x4s97Bz/MKJe3wMlAQmQu8elBjhbm/z0AbY0sqKex3jyRWkKhe6lyqQxfVOGLxspaVefAjwvvMYLNaXEoDyMrPpZx2M6N8NsN8n3fqrU0J7dpW8VV2jurZ/cbiuUIG3mYVblMTZwPcgz8ibLC1uToMzBQ5F20EHqlYqOSwcCwqZIvFEPCsLjVaZ557Le4YE0MbLMDIGJ9Keav4oAgTDlnyVUGSOWeV70MHm4hnHTff/QIQgZhfG5vKD1q6qrctcYgPoJwsT30K3fRBz1+zfkddKMx7030luZ5c3YQAs46v/5Zvd+JkHqzh6GhdXIHHW3TrVnn3adCJY2Q==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(7416014)(56012099006)(10067099003)(18002099003)(3023799007)(22082099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xwXD4tMtGRa6MJLchJLQxofEkDridsxNzSJh8JjaFOaX8WTkmgB8qOoBpYr0dCaN+HmIxcUwNc+HqY4S1KeKaa7QX+mffghU/+nuLvZ9nilu9vE0Zi92J/I6T3DAYFae55/ljJI5yI6vyv/sWcrh+xDyM5DosngFGWUBWGX+IcJKN2xwLPMTT+EyOhyBBntsN2PC8HpMV9UfShPLVJ4xWN1QQG3pzmgraAEYIyh00Z6iBTQbgCkObMo+/Ah5rEaE7S7eetw6D5XG8vzaWkMf14Uii9d8+CrY3qsJqMtOqJ9pEzSQpGgcY75HkAaZJM6BFX388lbsHu4Sn0RCTDEP1WS+xWNRvqoHpVx0iXbY6tkpE2pZB/cOD4BiUR/2sr3XELcC9QhO+ckmNEr4h/rMWmi/TpASPWRoEmwe4yyHtgq4WO+Yhl23L+i47ldA4C0L
X-Exchange-RoutingPolicyChecked: La7oYq8tRk+8u0KWaMXA/eHhP9B/eOuKBQhT9r91Xoxy7ghMiSZG96zl5l03IQrKpVjpnOPRDUghsbuG6QN2lXIfhVAT7Zw6mjooo123BMnUZza6vH6lDeRt7Q9QWSCSqJXabzCgHqcW0c0MsP3TxepCOfrFw3fvzntaHO9mOx+72tc6Mkht5sa5r27HrftzweagS6n6YB1mC8YxaTeoUh8zUBziWJhrFU//qmHmqqU/5Xi/N9XxbJzlatMQmoUqVZ0rwzLtc53laJ1uEFEij3lg+y2IPf5HhHThq1iU3p1sMC4w9gdheXLu3wu6jFwydDjnRYm2ftiysiCVzCCv0w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:55:11.5934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 015cd383-9c91-4b00-c335-08deed5fdcf4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6735
X-Proofpoint-ORIG-GUID: iIUecsncgFm90BSXAYpsPEPQzWvHJFTR
X-Proofpoint-GUID: iIUecsncgFm90BSXAYpsPEPQzWvHJFTR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfXyazOnNKs3bQ9
 rHdVmk1mFy0TD/uJTBDuvheEswNM0oSqpZo6dshk2K0AyvNkBHDzy1d8BvKhLGLrMOgFB4fNCJf
 gJzSb99Nj3hvy3ReolrxrIeI54X7pQQ=
X-Authority-Analysis: v=2.4 cv=PsijqQM3 c=1 sm=1 tr=0 ts=6a69dc16 cx=c_pps
 a=St4LTB+eVnQVBP+Ivca1Dg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=cm27Pg_UAAAA:8 a=fGhLjsSNAAAA:8
 a=WPIBqCUo9H82EmqKrd4A:9 a=QEXdDO2ut3YA:10 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA5MCBTYWx0ZWRfX8Yzgqj+754Rj
 xWwk2uoIaFK7vdp84GIr3XdhS4D7CSLGQ6eu0OFSpJ/S52yIuR+sDokvfBEN4D3fqFvwJaWlbaJ
 ei95gLjx0QHbHXuhPeef9li0xzGN+Mo1h/2q5I/HSkzNBzBY+AMADcdIBeSwhcFd2xPTRVx77s7
 5+mQg02p7lkSKp7R3m2BSb4x/ADiIeIk0W41yFAY5CWcfIliDxC6giSgmDFxyRfrCV80hX08VfO
 9adM7zL/DWPC7K4zJOAB0nBlHEzLYImExJP4q6zvw1CWGGJzgMoPfZwm0eVV6CfaPjAOZ2LKI/U
 Pqhs/s7Qsk6cV7Csv4mUrTACb2o7x5MqGZWKX5Ncp5qol4P/CwPSfandjYjqXGdEgrLsW9JLzI6
 9EFPisYu3rJabd0Qld8u6jvVFapCqSAXqC6Ehn53nx0V4Gy6Kb8xsWb5oWT2FcaChTU2Zs2xOAf
 Ylb0hvfemuQYB99elfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290090
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=pdMOuhgG/Y0P5nfnttLkhjCeLV1x7m6Af7fAMdvGi
 T0=; b=NuP0ejnhe0hVWKTop34+TVqlrmo33kxyOLi0trWFER0CUt8KhNZnNWg/U
 L65iD3VYpJkc4ZHWbK/Bvgl2v0FA0xsPNd+uHgEvzrRo6bAO0bbuDoztQbK2JNxo
 ziD26SMD9l/08jfvUWI5XGwvaOv5W4FAWucxY6pHuZadVwrXJCgm9K0y2Eax5vGp
 bWIbbiKEwaAk1Olq5QlGIvHFQX83FXqbX3YA/lDPa589FtY6RtgvrLWbFZpl9NT2
 NwkbfRw8Kwm8Cf9SH9aVcGkPOjkiaZCzM8Q8tjTPAdDEo6lWu0wcyMBhyB82NHwt
 RaqjF844uvjJ9vjFOtL7Z+tiC6oww==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdMOuhgG/Y0P5nfnttLkhjCeLV1x7m6Af7fAMdvGiT0=;
 b=L2tFznHEWMarOC6ieGbH1cghxSyWgS5XENRX0IUsUB3D4Pc182BStEQIidzNwnLzFTaiQSq9DHTAUW05cRqBX8Hh5F1D2atEJ6n0wLsZWfUviX1WAOIJ9R+BPVo3/f+WbE7RAwawdC9kl1cguNhXfStPC52USnQyDooxHtv36uI=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=NuP0ejnh; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=L2tFznHE
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
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Currently we are duplicating binman nodes responsible for building
tiboot3.bin binaries across boards that use TI's AM625 SoC.

This patch adds a SoC level k3-am625-binman.dtsi with templates for the
commonly used tiboot3 variants (i.e. hs, hs-fs and gp) which can be
inserted by the corresponding board's dtsi to promote reuse.

Note that for some boards the hardcoded load address for SPL firmware
has been changed to use CONFIG_SPL_TEXT_BASE but it should cause no
functional change.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi      |   2 +-
 arch/arm/dts/k3-am625-binman.dtsi                 | 122 ++++++++++++++++++++++
 arch/arm/dts/k3-am625-phycore-som-binman.dtsi     | 116 +-------------------
 arch/arm/dts/k3-am625-r5-beagleplay.dts           |  33 +-----
 arch/arm/dts/k3-am625-sk-binman.dtsi              | 117 +--------------------
 arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi | 116 +-------------------
 6 files changed, 136 insertions(+), 370 deletions(-)

diff --git a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
index 2a4f0e453652..78d69499314e 100644
--- a/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
+++ b/arch/arm/dts/k3-am625-beagleplay-u-boot.dtsi
@@ -6,7 +6,7 @@
  * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 / {
 	/* Keep the LEDs on by default to indicate life */
diff --git a/arch/arm/dts/k3-am625-binman.dtsi b/arch/arm/dts/k3-am625-binman.dtsi
new file mode 100644
index 000000000000..a96a2006a087
--- /dev/null
+++ b/arch/arm/dts/k3-am625-binman.dtsi
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "k3-binman.dtsi"
+
+&binman {
+	tiboot3_am625_hs_template: template-tiboot3-hs {
+		ti-secure-rom {
+			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
+				  <&combined_dm_cfg>, <&sysfw_inner_cert>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl>;
+			content-sysfw = <&ti_fs_enc>;
+			content-sysfw-data = <&combined_tifs_cfg>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert>;
+			content-dm-data = <&combined_dm_cfg>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
+			type = "blob-ext";
+		};
+		combined_tifs_cfg: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tiboot3_am625_hs_fs_template: template-tiboot3-hs-fs {
+		ti-secure-rom {
+			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
+				  <&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
+			combined;
+			dm-data;
+			sysfw-inner-cert;
+			keyfile = "custMpk.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_fs>;
+			content-sysfw = <&ti_fs_enc_fs>;
+			content-sysfw-data = <&combined_tifs_cfg_fs>;
+			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
+			content-dm-data = <&combined_dm_cfg_fs>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl_fs: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_enc_fs: ti-fs-enc.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
+			type = "blob-ext";
+		};
+		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		sysfw_inner_cert_fs: sysfw-inner-cert {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg_fs: combined-dm-cfg.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+
+	tiboot3_am625_gp_template: template-tiboot3-gp {
+		ti-secure-rom {
+			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
+				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
+			combined;
+			dm-data;
+			keyfile = "ti-degenerate-key.pem";
+			sw-rev = <1>;
+			content-sbl = <&u_boot_spl_unsigned>;
+			content-sysfw = <&ti_fs_gp>;
+			content-sysfw-data = <&combined_tifs_cfg_gp>;
+			content-dm-data = <&combined_dm_cfg_gp>;
+			load = <CONFIG_SPL_TEXT_BASE>;
+			load-sysfw = <0x40000>;
+			load-sysfw-data = <0x67000>;
+			load-dm-data = <0x43c3a800>;
+		};
+		u_boot_spl_unsigned: u-boot-spl {
+			no-expanded;
+		};
+		ti_fs_gp: ti-fs-gp.bin {
+			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
+			type = "blob-ext";
+		};
+		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
+			filename = "combined-tifs-cfg.bin";
+			type = "blob-ext";
+		};
+		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
+			filename = "combined-dm-cfg.bin";
+			type = "blob-ext";
+		};
+	};
+};
diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
index 6d57a5d9ffa8..d09bdf29a95d 100644
--- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
+++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
@@ -6,7 +6,7 @@
  * Author: Wadim Egorov <w.egorov@phytec.de>
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 #ifdef CONFIG_TARGET_PHYCORE_AM62X_R5
 
@@ -17,124 +17,16 @@
 &binman {
 	tiboot3-am62x-hs-phycore-som.bin {
 		filename = "tiboot3-am62x-hs-phycore-som.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-hs-fs-phycore-som.bin {
 		filename = "tiboot3-am62x-hs-fs-phycore-som.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_fs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-gp-phycore-som.bin {
 		filename = "tiboot3-am62x-gp-phycore-som.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 
diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
index fb0b83b83f1b..0e8c74c0291d 100644
--- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
+++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
@@ -33,38 +33,7 @@
 	tiboot3-am62x-gp-evm.bin {
 		filename = "tiboot3-am62x-gp-evm.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <0x43c00000>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
-
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 
diff --git a/arch/arm/dts/k3-am625-sk-binman.dtsi b/arch/arm/dts/k3-am625-sk-binman.dtsi
index 1717621a8500..9ac0c36f8645 100644
--- a/arch/arm/dts/k3-am625-sk-binman.dtsi
+++ b/arch/arm/dts/k3-am625-sk-binman.dtsi
@@ -3,7 +3,7 @@
  * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 #ifdef CONFIG_TARGET_AM625_R5_EVM
 
@@ -14,125 +14,16 @@
 &binman {
 	tiboot3-am62x-hs-evm.bin {
 		filename = "tiboot3-am62x-hs-evm.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-hs-fs-evm.bin {
 		filename = "tiboot3-am62x-hs-fs-evm.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_fs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-gp-evm.bin {
 		filename = "tiboot3-am62x-gp-evm.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
-
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 
diff --git a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
index 35b7f8b256e9..c57780d876d6 100644
--- a/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
+++ b/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
@@ -3,7 +3,7 @@
  * Copyright 2023 Toradex
  */
 
-#include "k3-binman.dtsi"
+#include "k3-am625-binman.dtsi"
 
 #ifdef CONFIG_TARGET_VERDIN_AM62_R5
 
@@ -14,124 +14,16 @@
 &binman {
 	tiboot3-am62x-hs-verdin.bin {
 		filename = "tiboot3-am62x-hs-verdin.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
-				<&combined_dm_cfg>, <&sysfw_inner_cert>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl>;
-			content-sysfw = <&ti_fs_enc>;
-			content-sysfw-data = <&combined_tifs_cfg>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert>;
-			content-dm-data = <&combined_dm_cfg>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-hs-fs-verdin.bin {
 		filename = "tiboot3-am62x-hs-fs-verdin.bin";
 		symlink = "tiboot3.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
-				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
-			combined;
-			dm-data;
-			sysfw-inner-cert;
-			keyfile = "custMpk.pem";
-			sw-rev = <1>;
-			content-sbl = <&u_boot_spl_fs>;
-			content-sysfw = <&ti_fs_enc_fs>;
-			content-sysfw-data = <&combined_tifs_cfg_fs>;
-			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
-			content-dm-data = <&combined_dm_cfg_fs>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			load-sysfw = <0x40000>;
-			load-sysfw-data = <0x67000>;
-			load-dm-data = <0x43c3a800>;
-		};
-		u_boot_spl_fs: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_enc_fs: ti-fs-enc.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-enc.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		sysfw_inner_cert_fs: sysfw-inner-cert {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-hs-fs-cert.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_fs: combined-dm-cfg.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_hs_fs_template>;
 	};
-};
-
-&binman {
 	tiboot3-am62x-gp-verdin.bin {
 		filename = "tiboot3-am62x-gp-verdin.bin";
-		ti-secure-rom {
-			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
-				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
-			combined;
-			dm-data;
-			content-sbl = <&u_boot_spl_unsigned>;
-			load = <CONFIG_SPL_TEXT_BASE>;
-			content-sysfw = <&ti_fs_gp>;
-			load-sysfw = <0x40000>;
-			content-sysfw-data = <&combined_tifs_cfg_gp>;
-			load-sysfw-data = <0x67000>;
-			content-dm-data = <&combined_dm_cfg_gp>;
-			load-dm-data = <0x43c3a800>;
-			sw-rev = <1>;
-			keyfile = "ti-degenerate-key.pem";
-		};
-		u_boot_spl_unsigned: u-boot-spl {
-			no-expanded;
-		};
-		ti_fs_gp: ti-fs-gp.bin {
-			filename = "ti-sysfw/ti-fs-firmware-am62x-gp.bin";
-			type = "blob-ext";
-		};
-		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
-			filename = "combined-tifs-cfg.bin";
-			type = "blob-ext";
-		};
-		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
-			filename = "combined-dm-cfg.bin";
-			type = "blob-ext";
-		};
+		insert-template = <&tiboot3_am625_gp_template>;
 	};
 };
 

-- 
2.55.0


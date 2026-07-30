Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 654B9C55160
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 01:40:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F25B40871;
	Thu, 30 Jul 2026 01:40:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ebcpe8oe_dcS; Thu, 30 Jul 2026 01:40:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A678540860
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785375641;
	bh=899jAsLFvzhOsXRjoefI4OKH3TAWC2vkDBHh524qP+o=;
	h=To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=XUEh3lYKZAEuF8GwipJXiDpefpZH8d91A/HoVhRkENvIM93x1gGcNPEqVQtPZeNoy
	 1nvObp4fDIy7OVEkGO582X+aUdzR/02vfiuqo2KvxBmj5yatAYj6J/3dcBctwbIJId
	 nvmLZlJUTKMNEPb9X74OxEYCDv2ikmTAT0LUZ/eu+iw/sV1VKois3rDu4I2A5hp7DY
	 EB+R5/1rfh2D40bNVlHeOD4yaxcerX+mfBEzld/JkFZOtltlSKAkbtfayiFL4NOVxV
	 qUCOLukZOSrL8XaPaepJIiLV8JSspYpZ9dgiXQCPeo+7TiwLLH9KZWOng0UG8KBeo1
	 6BMowMN4PYB1Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A678540860;
	Thu, 30 Jul 2026 01:40:41 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F53027C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:40:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 30BCC40081
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:40:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KdgFQ1a9776x for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 01:40:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.146.23;
 helo=mx0a-00498f03.pphosted.com; envelope-from=dmukhin@ford.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D2AE64004D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2AE64004D
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2AE64004D
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:40:33 +0000 (UTC)
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U0jMiu3239551
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:40:33 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4fqsabsgwt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 01:40:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMptv003RUNv0YLGtf/Jx4whLm2Z8DMTK+EZUvV3cNrf81yF1FRz2NVR+t0KxxOH6CYf31oLX6SNXQTkHB77i8sZ0fvU+GDkjwB1yP55SZLGMJ02ksYj6AYLdC9LsWECPrzXDKXRaIyqNer/ZksgX4jj2yC7OMuWkFw+3SLt9zCXvK2krGmNUXnhRINQ5T32Vh/wb9FV6tPS/W4ymjQJpWmECkufGZAq4GKaQE8tjM9X7SUFtIusEZzDmqemD5Lb5ew9kRmHUY6825EItqbUuCituUif4J7IAdZn2UF0ll9iob02nq/8thF9CJ/KcxWAjB2RwGOofhvt+ANyst6obA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=899jAsLFvzhOsXRjoefI4OKH3TAWC2vkDBHh524qP+o=;
 b=rvzMOzk0V/3zDeRN+nFHJw7OrVucfbnvScJbGY9+3lvo0quggYnyAWN1/hK+S1vyI5jRPK5KYNAAToa0UIEk26tELYpjxyhGlQ7kkUFTctd4IX9N4elRAX2Wlu/fksEOOSxUajKljtRr2mf0akXoohVyh2mcwioV2P9Y306vH02/meh5veVz0kRhNTEBlZ7HhHg9fYJ32Y3vjzONLJI2WBczr08F9gjMqdQZJm8q3iNCCahaC64HF7tzInwGvFlIhn/otlWLqpGRp1L2stSoUIX30WZ4EI+6xemJaBa65ha081n05y4C/iHYh37iFGQcS8Ac8ev7XVz1fHOcL4sG1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ford.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com; dkim=pass (signature was verified)
 header.d=ford.com; arc=none (0)
Received: from CH0PR03CA0094.namprd03.prod.outlook.com (2603:10b6:610:cd::9)
 by DM4PR16MB5419.namprd16.prod.outlook.com (2603:10b6:8:186::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Thu, 30 Jul
 2026 01:40:28 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:cd:cafe::3e) by CH0PR03CA0094.outlook.office365.com
 (2603:10b6:610:cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 01:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8
 via Frontend Transport; Thu, 30 Jul 2026 01:40:26 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66U0h2rm059094
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:40:26 -0400
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4fnbs757r5-2
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 21:40:25 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id pFl1wnoH1N70JpFl2wJZHz; Thu, 30 Jul 2026 01:40:25 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: pFl1wnoH1N70JpFl2wJZHz
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
To: u-boot@lists.u-boot-project.org
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1] part: efi: use BOOT_PART_TYPE symbol
Date: Wed, 29 Jul 2026 18:39:47 -0700
Message-ID: <20260730013946.1858341-2-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607300009
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|DM4PR16MB5419:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec9f55ee-0d8a-441a-8c39-08deeddb87e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: fXo45LoKK1o6Tcqf8TPyqjgbpSYAwwOCyf+epqBjhRMFjnWltryshoy81Nj6Cbp/6eZsbReVC4HVCT5pP8BQynt1jWHdCQvabbMmtsQ8gBYJmjdVXe2UzhYJ87ooq9CW3Ry3g/T745PB8VEnrIJ1Q57WfjAGIYKaPoxVk0Q3STuc4twpJbGfhuq+yYWdFbSbdjgG6na7ud5UWZ/mhuw291f422rM4Gxf6jnBSGd2yP3trCCyQh6LgQo23LzerGxxnzimfEIW11IMm436Uuyy5qsvoyJHgRU0RvKMKg089ELIIw8/mq3b4zXoumgvoaK5KtqSvFq+6TpmHMapj2jMkTPX/q6R6h+4VtVDWjse3Tio35AX3UpnMa37X5rudasQlsVRxSmbqdiLlRJAUeMxjrvvFZB6m3xgePivr36h1i5o6NbK3rMJh5KrfJ8gNQSUQYtyyJ9sLkK6M82YfzYxUr/FVeeDUAZ20hDxNIaSJGipryeL6zCSTwzANgbxyuosuIojENzcZnEIvMvtdMEgeKI/+VqT/s8RT/C4etwjTEhdsreQ8xTMiLqmFKhorP/WQ9fbJP/Ph3C+ETtLKlBHM5yl8Q/KmFxe7tcyIOhImcxWKtfU3gfvQaFZhb6ntqcv0me4YJSqTmIRyPnRACcXvOCJtVVyuH2neVGmcvaaWNewHiwJZA2J8DJBexhrSxYk/BQy2r2TbGqhBaaSygOZyw==
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zIDtBsqhgc3Q/nVakqjMEUGXAOIAV7bDukoI2PyLXSFMPr/DmTcgvkQichNa0WbSDMRt0QTdsHhlHxXrrpedmOqFMmZSKMzxOvKMneB0WhhGDLFVQPEChvWsXzDzH27/v2klURBlQngjsVc2OhDRex+Mcb5tUUG3gan4hbnv2h3ZcsXtRxz7MCrDgluzsUAiIYQdjFqFdn91vOiDpC2/9Q1jfn1hv2lf3YRZeETvVvjS9hlamOFK5Gttwzaw7YJHvRoyM3AhEK/Qfl7bRfpKwP9YR3F+uy79cyCEiZTaX2BEl2XGjUImpRx5lGAPO2o+VDOK7cagbfR9/pcuvhD5Apl5Z+gDtj5e7QTx8qUwC3AD4MdmZqRfUVnHCtFdfMp9QzgvD+Yp6k0E6fqOIpweoGaAU/jrz8WaLWrBPJhBU3E5gMNBgf8+4Z+KxAx7+lTM
X-Exchange-RoutingPolicyChecked: hPZDxBlxAFmfdq+L1vJPFroL6BE/m4qp6eHs+OAZ+UrgxV4TfbVtSWdphS8IRIHkki26LTSYDowYyPIfPzw6IuS5hI/CszW/ce3AAyM6EH6PkQwM2326FtkkBjt7rLmxch/5aPd3SM0mxGEiUokfwihTHRoiJIrtIivHXpoM6V3G55vEb5ZjC7+g1vQ9JF/47wnZOINaHbSX8CFPKO8XecqzJYpfLL7CaEzYaPKdE1+GoA+CVxCv3k6kpkf5XxJQdOx9zaQDoq3fGUlBEGcyEI4wpyQPJJPcHZcVUMiYre9z/HKiOvCfQCNF5PatmOTaS24YybY563sMtzue1c0ZXw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: X6xCisAs1gDz7j9uHWa2o6gM5l9KkqdaPk40+7MdmqDkW6i9FJpOzSaK6gADsXbKyTFxDTjwLiyn02o6Cd6OBSoPBHF/vNEpg2JMUMSjQp+JE70oL67NXmkjYyeGErkOFxX/lnyzZhhXG5bTCxgtwGTpYLXHeTo8F09gdcmRfHzGx7M2FxJetM/w8U1M5HUDY/myw7RZBJeXL/8Vq+RxNVwIx0+2PPWhc8icnc5rA6R3BPg7dQChKSxlTQFmaB2tXfU5O+TASlVsYYUXd3Xq+Vz/eUI0kiysM1PpG4KnkyoAn5gMtJliLc97dNjrBAMc/4zxFl3y31U7I1mKQz+QLQrYezS9N7maAQ68/QfP9HwjlZgJ3tIhFsdc0oJLrjv8ev8hNsDSFTK8izsSB++KwHXsofTPPAUPFbq+ZoiiFTYw3Bdvt3w9TVXdqv00ZUuEZmd16kPvD94PodF7836bv2f7hafF6DrLs40XmSA57D4B73o9MUengxNtSFlinYZB1eImxt+hb77a2RUaqjsfZiF4ekigz5ei5Kj7ls1GTf61n9cVbEGamVUSe1VMerc6WjGFkjNjfdo6O1KqdtpTAksrUPnCrJf2M/VkRFfUeHHWVAVM6W5sGYXMXhvPH6lpk+C7WBQ5fO0nYtjjrTVmVg==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 01:40:26.5866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9f55ee-0d8a-441a-8c39-08deeddb87e9
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR16MB5419
X-Authority-Analysis: v=2.4 cv=PfXPQChd c=1 sm=1 tr=0 ts=6a6aab91 cx=c_pps
 a=p5SqRtR3VJW1kgksvcX22A==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=nmvtNpCPeRQA3zbRN4gA:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-ORIG-GUID: ZDcdIyYcIAspl2CbmSUi2CqnI1tYgK8l
X-Proofpoint-GUID: ZDcdIyYcIAspl2CbmSUi2CqnI1tYgK8l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDAwOSBTYWx0ZWRfX968bVc+isPv4
 dtvNbxZrMphaohIYVjogULzSuCpcuC7jbbYXPDtTdfOa/u3plNPeswSRMQxojr+j47N7kqFv28Y
 XYFD9JYZfXk6wyoe8NGCIi9rC4kroFUAz4iV/x/m9wlgBGW3mMBcnSigXyIi4JTLiJC1E253zaV
 kROWT7pAidVkBFVhJerwY2Zn7n4nl0TSulTdYwr0yg6sgpJ+Qzl48UAVQZwhJvyI5I/KYs/Sbm8
 76oxa8k3xRSdYlAQmWSeay3B0+Gsqquzwfu18LReIMWwgISPLk3dQyhQ2mtFHBK/YkJQxuG0kt/
 Tn/pFaiG+uI+fnqY91spLutlq0/VHgouz1WoPCxh43FKXKdF6JEBW3YpwvaaUo6fVH0sLTLaAZa
 LZWHEO/mbGgT+InAxHrXbxSVIlRrTQ1lFAYETf/NnF0ZBqgMAS2xX2hWObxoGMkvfWrzcvyR823
 2FkSnDjXjgHwpnHBExw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDAwOSBTYWx0ZWRfX9v+naGzkqoQU
 Gbu6ZTCMIppbjFriRiG8mkyvW5DSYfotAI+wYEpQXDStGMx9g2S15Z9oE9GVBNLckIC1Dljm011
 tXDsy9G6J56h5KPbxPLS/8a1+81b493bX18FdfAlsohprxxNKXF9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_09,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300009
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=ppford; bh=899jAsLFvzhOsXRjoefI4OKH3
 TAWC2vkDBHh524qP+o=; b=wCIWt0yIFzCI4ra0DkxbLc+x4Nf8GJblbkl5AX945
 rocl/UbwkKKIZtLEZdJnDMD04gQNMD5gLcNK8A5KUWpXC4+RQsOmIhEDNGq8w92p
 kh15iYV5BKyPhLtNyvMo5QdlAillOQoraFZSAhM+iQWsxiiN6HyF+d8/PSOxgshA
 7jrz2TS9tvXlJoj5/WRoiLHL1/LaY8/tC9muMpoCqyDDGJJ5lZDtOLLXm1AihTYJ
 1BcUV1iSI51Ao7tPcBDtwq7QLHxipuErpvjrzS6kR0HWJhvNl6sMO8iWVsM5b+U/
 LZVlAm5VePBy2ozxQtxL+xkxTMPIAlrvLXB0rhQClfqeQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=899jAsLFvzhOsXRjoefI4OKH3TAWC2vkDBHh524qP+o=;
 b=JJ8MonTeRF97pJc6h2clZ4xeUE7FuCsBesBYt84bsEByUXz3tFNeHAKdhzE1Ksg+m4I0hh+y94ZmSK9N/1I2YaXHfaCRomngKcP828TqABh+5fRk7TnQKKSqvkfYAQQEDShwECdlOU66NO32fsURURd3HX3fuXxX75TufVPLK+I=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :message-id:mime-version:subject:to; s=ppserprodsaar; bh=899jAsL
 FvzhOsXRjoefI4OKH3TAWC2vkDBHh524qP+o=; b=GjARddDUmK8mml46wZESWPs
 Y2ZGvhPTSo9VLJDedUWBNOoCo0fJM4ED1dlAE8NrlwfljWUZidiq6tEQVg/8kcLb
 f59RcEtVfnK652rUcuhaUo0yVbP2ztyWRpn+d2HF7Ga7Wg8RNcx7RNDUmX+9p2aG
 MCZjwNtFmG8Q3YKTW59RyGkTkPB1XeMkZKriCfEPwP19jy1lmrwYmmObQ3p13mAk
 a4GdKHcyE4HcbIzIZUrHJYrgflFOX6EpMQ3w1XqdFWuuYFQMTSVXqZWwnBnRdfzu
 a5seSXbzNuho6Ge0Ox+0RCCcNOkFlq6y+D6UEibUxIruqIbEm3je4CPsCAsieCA=
 =
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ford.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=ppfserpocford; bh=899jAsLFvzhOsXRjoefI4OKH3TAWC2v
 kDBHh524qP+o=; b=SnDDvx1uBvL1aNUTNEKv6DQ7QgujFgjJdFF5hb88AiedxxT
 9SiBC0rAy7x6Fp35OUsqUSCrNrNWOXrW1PIR1h6hoOWGsvbXdUsXXUHoCpupDqv6
 oamxikG74ucNv9YaZXp1nZJPNLMdcygsx0Hbpleele8GTQeAUZZ/iNBhXSl6w0NQ
 CspMNRtdeuGaA3fhaB3FT4RxtFy5GjHZeNGP0jQXHWyWV3Qd0pAlj5QQr2aNkuFj
 goU6PxblJfpxWQ85MikjByJu2igik+YIY6tLNyR3+/IFcFaY6Gz94dTE+rHmrsOP
 Sq+iqrsYhVopc3mTlcWRId+h2n0jUDrOStS2lbw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=ford.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ford.com header.i=@ford.com
 header.a=rsa-sha256 header.s=ppford header.b=wCIWt0yI; 
 dkim=pass (1024-bit key, unprotected) header.d=azureford.onmicrosoft.com
 header.i=@azureford.onmicrosoft.com header.a=rsa-sha256
 header.s=selector2-azureford-onmicrosoft-com header.b=JJ8MonTe; 
 dkim=pass (2048-bit key, unprotected) header.d=saarlouis.ford.com
 header.i=@saarlouis.ford.com header.a=rsa-sha256 header.s=ppserprodsaar
 header.b=GjARddDU; 
 dkim=neutral header.d=ford.com header.i=@ford.com header.a=rsa-sha256
 header.s=ppfserpocford header.b=SnDDvx1u
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

From: Denis Mukhin <dmukhin@ford.com> 

Use existing BOOT_PART_TYPE symbol instead of open-coded "U-Boot".

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 disk/part_efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91a..1efd2ea113f0 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -304,7 +304,7 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
 
 	snprintf((char *)info->name, sizeof(info->name), "%s",
 		 print_efiname(&gpt_pte));
-	strcpy((char *)info->type, "U-Boot");
+	strcpy((char *)info->type, BOOT_PART_TYPE);
 	info->bootable = get_bootable(&gpt_pte);
 	info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
 	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
-- 
2.54.0


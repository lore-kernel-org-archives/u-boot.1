Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8ADC55184
	for <u-boot@archiver.kernel.org>; Tue,  4 Aug 2026 11:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6049C60741;
	Tue,  4 Aug 2026 11:57:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i5iBzCid6NRh; Tue,  4 Aug 2026 11:57:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C3AF760600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785844674;
	bh=ZwYtFSfusl9IuGIzzGCqC3x3ybLr7Zipvxx9Bb1p760=;
	h=Date:CC:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qin8ZZt1RH8Abf7Vb0rfUSV6oaBNYIWbaFW9+T5kQ2Tn4LJCDPOLqtWWe5S8BJT4q
	 Ot+0eqVRVYFtjAtHpOpengoVmQgnlpCiDmkQsOqfdPzETkgUQ01v9ntQhRrefzP1bP
	 1dVLuU2cTiwxvv1Z/DTFEIK0f1dn/z3YBvv7ElznYmlE2hBKeyllfO3z0e//47nsQL
	 8v3GNeNRwo6zRjKevj4wZu1ARD5WBfvNbyEUNp+BSe0tQtJGW5WIMj4tmf8ZSHYCOE
	 S1kDdjU6CmIR2+i8xiKA51GOA17pnjNq+besN7i1R+aK9r5airU575GCNcwybhVXvI
	 8DoibFFyLefNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C3AF760600;
	Tue,  4 Aug 2026 11:57:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 490FE194
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:57:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46A88400A2
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:57:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bvgpXWGSB_wf for <u-boot@lists.u-boot-project.org>;
 Tue,  4 Aug 2026 11:57:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1527A40071
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1527A40071
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1527A40071
 for <u-boot@lists.u-boot-project.org>; Tue,  4 Aug 2026 11:57:52 +0000 (UTC)
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674BbCIr2364518; Tue, 4 Aug 2026 06:57:48 -0500
Received: from cy7pr03cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11010050.outbound.protection.outlook.com
 [40.93.198.50])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4fufc6r438-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 04 Aug 2026 06:57:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPnANyUIGZ+nDf4rQ3H+akZlp5KA5OcZNV1iraa49xY+kDHwtbCBddqTtjzJHAMAWAwae0AzD07bG3+0F03yNPAKNAeXH/4sopdG92vyzQWl6fQ6Ej9EKL7Fp7uMi2XGvnRYymZi1/kiuWD/nu4FU7zDhMAlRJ2TgAnpecsIF44cR0W2rkDTD2uwi5p0IjH0SMftBj7ELG/UPlNgSBINqR0sUyMO6RnyWcbYythb5Js83+BDbMwcwSl/YeVoth4/1UBAXQeia4ZX4wAfV+UnJ6PuoW4U0ke07oOPU+vP6sgud7b8I7QayhOYGVOhr8qslwrJFNW/5pilMOFETTHKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwYtFSfusl9IuGIzzGCqC3x3ybLr7Zipvxx9Bb1p760=;
 b=JDHd/YnU4lPsHoyeUNyIjnAwGyhoeDoApdWxiy70raXRuutqryK/lJjijy41MIWsyNf1pnTXPE2RU9p35nQvn3xnaNmT2wYlODaCODGTvIgaO+xQBVDoL8jZfreCwen1GIimZzTbur6jHf9W2T1PSGhEczCpAEYvqVuqQWUdiuco2kyLyn3OCJ+J8jkk/CyBqKeCS9si6nwM31XPQivmCks/iEi4YYmMrJWYuhusUJ1wR7Bi2g/DaMVQgqoljq3z7tNH9UL0ACwYkOsNeleVXHcMMsj8puuJaXpqU9MgzU6IDIJ9a4d6OQ3qV9uHuc/Af6hicpXDtYYBJPPTKP1iDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=mailbox.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
Received: from MN0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:208:52f::8)
 by MN2PR10MB4383.namprd10.prod.outlook.com (2603:10b6:208:1d4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Tue, 4 Aug
 2026 11:57:42 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::44) by MN0PR03CA0003.outlook.office365.com
 (2603:10b6:208:52f::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.16 via Frontend Transport; Tue, 4
 Aug 2026 11:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Tue, 4 Aug 2026 11:57:41 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:57:35 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 4 Aug
 2026 06:57:35 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 4 Aug 2026 06:57:35 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 674BvXrF175487;
 Tue, 4 Aug 2026 06:57:34 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 4 Aug 2026 17:27:33 +0530
Message-ID: <DKG53FX8A1VO.46C9I9TZAJ7G@ti.com>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, "Dan
 Carpenter" <dan.carpenter@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, "Simon Glass" <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 "Ilias Apalodimas" <ilias.apalodimas@linaro.org>, Aristo Chen
 <aristo.chen@canonical.com>, Udit Kumar <u-kumar1@ti.com>, Andrew Davis
 <afd@ti.com>, Daniel Golle <daniel@makrotopia.org>, Johan Jonker
 <jbx6244@gmail.com>, Vignesh Raghavendra <vigneshr@ti.com>, Paresh Bhagat
 <p-bhagat@ti.com>, Swamil Jain <s-jain1@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Shiva Tripathi <s-tripathi1@ti.com>, Apurva Nandan
 <a-nandan@ti.com>, Chintan Vankar <c-vankar@ti.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>
Subject: Re: [PATCH v3 10/11] doc: board: ti: correct path to tcl scripts
From: Anshul Dalal <anshuld@ti.com>
To: Bryan Brattlof <bb@ti.com>, <u-boot@lists.u-boot-project.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260803-am62lx-v3-0-b4f4302b09b4@ti.com>
 <20260803-am62lx-v3-10-b4f4302b09b4@ti.com>
In-Reply-To: <20260803-am62lx-v3-10-b4f4302b09b4@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|MN2PR10MB4383:EE_
X-MS-Office365-Filtering-Correlation-Id: d41dadf4-3fc4-4233-60d8-08def21f967c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700016|23010399003|4143699003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: YStQ+cx2caEUWHtMt9y5NwOzP8a4/Xwwrck4qK+xMvdZZovHNo8rTQ9DX/sjl5ifTJG7eurpApzz4sojgvzna2Q9HVc+/ujXe9SE1nqVBOZhQsZwsJ/YRfkd8QrFoXMncUyE0L2rBfzRkDKXv6xRAMbYdQqhnqGzAH9Cwvw8owI+wLlUrT4hTw2Y73fiPA4US5g+ZpTLTrN3/pspQh5oQ7cIf2VcTZ8OLXAmvcRM/CS1VwXBs6zcMORI3iELv5VyJv/gwZ4iOPM0lqN8w9t9NlBu9mtuEDc4Tg8B3DBfEUt6QZylyIB8iukPRvlKhOQbJfXgkyUMRUE6RL9tW8wDJlzx/0Ni0jR0OKgvLUJvYmkImXcX0at1tXSdtGNBgdaVHw7HMOLJinYY1JL5tsWj5RCRyjWzBDI+KiOsSNFSWxa8QZJHl7Ls2kCGzsusGgjv6BaLLbhK3iKB8SLzJaJx7j0UfZp6fZGLvG76TR+jibGpKrYCEnptXibDNkX8k6hMkOxzAQ8WiTyNUlfOyr2bbuEOOPrGWDlt2vOvr/5tDDMy+YTUKtoNZ7cytdEOnerfx20OSedZ7J02ydphvkFalxyaH7y14udrxYmyjzYqw9kc96TjLPkYIMP/dw9/Rt/B6iTUDMxYVWVOAYIfE+7AxLDnCoP8REUz1cJ3cnQ1qFSpH9CoGrwQtzWZ6L52GbggfC4m0whPeOpHEaGrvfzG7A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(4143699003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7FMjiHjDxPZ6bydoweosT6l2CdNOa+qFB009EkAwmmE176HN60/EsfpzqEGVQZ4Ww/TiXZ7Tki7b2YnCGEylO1N8YaQHxnTfULUCN5dGFBBotrEhHsOla/DSQ7qFe5BZuzMQBKnrtJfCjEJ52ENm37J2C9rizEXpuyWAEU6ZWJ9r+EVxsQASYG8EPz02Jj83zI/cG2FPdrVvBH95I8YWo72dboYQiEProVqd+6SfkAM0uWzdnaFxD8puxbPhqSzsOh3OwKeZE2cl91wV92/Fbcv1VlHKG0xzgTM5sDkdCCCctT1vNSFp97R7ek4bASwCDCwKb9u7a+YAc6M6kRKMqjBpoylU4FvbWkHrYuB/ex2WLIBjWM6z83dYtxEwdKmMBWO9hn2EMuU/AnXQS5IgFzo4Q1HNqA51UsgdLrokad84e89aFz9SfB4gfqAa6RNl
X-Exchange-RoutingPolicyChecked: siRvA0RvVdPTlBx/g1v8fTx8lS6UgMHg/I266jwP6z+onXNVAliHRRCLf15pnwlzIgsHiOg4XLmSOaWqCBoFXsAQ+zfm+IdE3Gn7E5uZAyYuKejfCDpw/PRxVBoJGYxA2OdQ5DU5O9o1GVk1PuzZ3uS1/uTewkzcOnLMMl19wR0JJzUw3kohxzcuO7d/rvo9K/8FsGutoA6tlFw8O0ENmZ2R+tGq16vmM0OjmxGXr70V0PcZD09zaRZ8qvc7Bn+Keq88IFYXwxWe1jmLKgnl9Vrcd46GzeMhrVeF26hQtSefRIfumX1IoQjd7DjUT8hRFpLNhDSmZzeZ8EyVJdBHXA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 11:57:41.4698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d41dadf4-3fc4-4233-60d8-08def21f967c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4383
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NSBTYWx0ZWRfX2mND0KjXGr12
 AA+NhyQeLcW4QBfaIB+42VHPBEc6NjZg+sbf/Vd693S6HaLZcF/f8hKNY7LqPxbUrJLieQmrucJ
 gJN2zS8mEDjPRxqdPGS2WD1kYguDJyaibJ3qsan1xFygjEwNrJefNoAIIpy4W6iki17bLHfDeJp
 znwCBJfxJkrsAOUSC5YOugYL3lzgp9o2a6wJ05WWuhhJj5Q7RRZLwSxNIcspCT5AQuwdP8PBS52
 aZt8jWXTvM8P8tdUFM31ly69WMEDcfbYEYW+Wbw4ueg4SICnRChRe7/1z+TUdKfmzqvau34KrnM
 ICifbJI/z9wKCnldzeXjuBL6Kb5pUSOYxEqstjNSx6IU15MdNUaoSaRg1YUjsh7J37mtsIH1l6K
 mvcOfHtwIYXNJOlS62z5v7DUchgGdO4OD76+Uw6fswrSpTirhHKswf1MdWkTuqkhAR4CyKjYbj7
 uADq72UGESCn5/O3x+A==
X-Proofpoint-GUID: cLzV8Gd8E02bOJ3SW7yo8wvfyNTC4_Qb
X-Proofpoint-ORIG-GUID: cLzV8Gd8E02bOJ3SW7yo8wvfyNTC4_Qb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NSBTYWx0ZWRfXyBtAErIn3YpG
 Aa12mnNFnB2g2vI1l3Gifm9++oZv2OO0ZoEkSTLg+V9xlGpaZUfe+/FRuaSAZdVMvlh3j4Lws5o
 4AbP34BztC377Mb2hPXelzBycdO1qRU=
X-Authority-Analysis: v=2.4 cv=Va3H+lp9 c=1 sm=1 tr=0 ts=6a71d3bc cx=c_pps
 a=xOrz19RqOvhMowGYDVTMqg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=jwouBfj2j3NM8CExmVVE:22 a=sozttTNsAAAA:8 a=jF0lwsS4EOXE_ywVE9UA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040095
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=ZwYtFSfusl9IuGIzzGCqC3x3ybLr7Zipvxx9Bb1p7
 60=; b=OO95k7qSJCbLEKxk0m2Ni+TSSUVvbLhyF4CWbVgEd1pXvPBQu8vSkIiuH
 02+FoAa8fgy77ZAnIBku6hG0wAaSH6u6HQeym0cXWEg/zs4bzr8X9cIdxn73g5cZ
 ahdwgBsdQVZYaJKsoJLpks2o4GSPvHIoHuYQwNyV8uxtv0Y9C1tc3c7gAAqFy/nk
 cA8p9HGyhBJ9oN9Pr49kKRgne9g+Jn4UpDxMX3vVYMs8V+gtFVaMIEcL1Qp5xH/M
 S/iQyHyHUgw25yMmiYRn1RTsTIwe68Q9g0njssHqNnUXoG+I3oVSQzgGD/XUbunS
 qghKFozpaLff+8Rj0Rxg2L6d0IcZQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwYtFSfusl9IuGIzzGCqC3x3ybLr7Zipvxx9Bb1p760=;
 b=W3gL3FBruHeb+G97rOT2noaCdYmEIY0DB8/6ieVLMfr6sWuEw67LCIfZ6mXuuGueQuyZ3+3DRUwGTowAJLNGUrSMN0/u/6scKZtmJxOfUwEYIw8b32W1ltebJL4fBJIJoIZbchbgkBPZA1CPwj5ldOBtxVee1OgInXXrYY8oG0E=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=OO95k7qS; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=W3gL3FBr
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

On Tue Aug 4, 2026 at 5:39 AM IST, Bryan Brattlof wrote:
> OpenOCD has moved where it has placed the tcl scripts for TI's reference
> boards. Update their paths to the new locations.
>
> Tested-by: Anshul Dalal <anshuld@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>

Reviewed-by: Anshul Dalal <anshuld@ti.com>

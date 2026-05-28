Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D1D7CD5BD0
	for <u-boot@archiver.kernel.org>; Thu, 28 May 2026 01:21:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41C82848E6;
	Thu, 28 May 2026 03:21:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="Y08zFb8Z";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="J4D20kBl";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="CgXJG1oZ";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="TJCk2pPn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9004848D1; Thu, 28 May 2026 03:21:18 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DFF8846D1
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 03:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0384718.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKiTR13303555
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=Xit
 zhdL/J2rzXPUaSJiUZO43j06Tm/J8ig5hOEIWKWI=; b=Y08zFb8Zihsi42RAnPn
 0JuehgPjTk5UUlIOItUt5FGngus7g1+yeS+xdEmSzRoEiChRowYn0/konqnOC7XF
 /26dbOoz0G0BzD+CnSGwQPq+XS1TnNwy5yG1elc32rHNoyXxWjziAZpr/cR270R/
 VzKHY4hud9PospUChJ+8Miv/r0UoAyE5kIZEv559Vet3aFfLGHwsbNIj9ADo+W/D
 sQIuHLwybOh8QqNp5WIfk4pHERGPR7os4Gx5In39BRlGupk8/o9Pcki1HQnc6fJt
 yf98M4N4BBK94UbCVFiAyrTQRj7BAlHEAYuqt+BbuxOr76wSwmmq0MXXf8xtRjeY
 iHQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com
 (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ee7wthcmj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 28 May 2026 01:21:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzSPMFD8mVQ5qWImEQg21FkWErGbE+QKroWnji9nKEln14zXWzLfe8Kw8AXO3FgAVs67aEYyHcErHgh0HGWeKOZuhOcY2Tydmgky0u5OkPacfUXU84cH4wB6Hjy1qqUVy5ECOSO/iAAtz03FvrWu5zyjhEpPDNSSf1zK5THSCDWii1bqrc6eS8aUX46QVSLdXB+OxPbu/gGrny75UFTGJluVwzgx0arQWZcbyvcR6n2Xt3OlL0AbPrRysWMPcyBESyJHx/HShRdB0MCuYBVZpESAf+PVLILX50mEDawkWQKU9joXrqp5eXjkH3bJX3qsUGCzuQv86LC5xs3yiLRqzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XitzhdL/J2rzXPUaSJiUZO43j06Tm/J8ig5hOEIWKWI=;
 b=AepxVH4qNf1/poci6KeXtTYrmnYtW6hvX0cBVSO/s/+lJym/PG/IXhU8JvXPZtvcFsnVbWpHf6ETNUNpIw0Biv7VwD3yeQ0EniYBNuivZTJECYsip8SuTr3NBbJ+pXfO0aNh3fCcqlSzscjkEwnxoBozyBQo3xY1xODwYit4dxKIuLeet+1mojOzQ9n+iG/SUj5aGLOgYVBq0o1X/rqTZJRMTng4/ZScy7wzv42e5jZ2zYX9ETkAZweXBzSNR2ic40LLoCB9ELDLq92xsn8YfuZEFkOiUDokOT+EAIK56fp1RDsA2zr9u/OjwsS+u8mDJCdF1RFB6IxsrrH2wiBWwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 148.163.138.245) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XitzhdL/J2rzXPUaSJiUZO43j06Tm/J8ig5hOEIWKWI=;
 b=J4D20kBlEr1wm+SMKiUejVzYr6C//OG3g1lOikbpagbKgCdUjZj2U1Ecj6iTZgnGIDN/c4CwPhQrJ/q+cJMH5RJH0F6cTIvKFGMP9JGYLzR3tkyhPDwhbtW3hUdh4t5KeWqLG3nNhAMUeXRG5L6wgtdcNTpiKoInnKOj4QDf7jQ=
Received: from DS7PR05CA0043.namprd05.prod.outlook.com (2603:10b6:8:2f::22) by
 CH0PR16MB4347.namprd16.prod.outlook.com (2603:10b6:610:110::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 01:21:12 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::20) by DS7PR05CA0043.outlook.office365.com
 (2603:10b6:8:2f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.4 via Frontend Transport; Thu, 28
 May 2026 01:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 148.163.138.245)
 smtp.mailfrom=ford.com;
 dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 148.163.138.245 as permitted sender) receiver=protection.outlook.com;
 client-ip=148.163.138.245; helo=mx0b-00498f04.pphosted.com; pr=C
Received: from mx0b-00498f04.pphosted.com (148.163.138.245) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.7 via
 Frontend Transport; Thu, 28 May 2026 01:21:11 +0000
Received: from pps.filterd (m0373461.ppops.net [127.0.0.1])
 by mx0b-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RKjTXh3452364
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=XitzhdL/J2rzXPUaSJiUZO43j06Tm/J8ig5hOEIWKWI=; b=
 CgXJG1oZaJThMw1FmAO0DxdBTwU0qQCuSLiEnG6Y8Q8c7pTDZzYv9BR/aFaBdkEo
 mKjVlLguou3YggoWaLqZ+rB7uRCpkJD4j+/GZCvoJufpJEj/ttMTKRJWrKkrQyOH
 yDHXpM+Xz1d/weM8SZqA0YyiD/lw5FUjN5+GUhFCF0IGlrGeVN9bLIUcoNfFgMYK
 9GtQIWXUx/YVMUjkaD6XJVeTJiexG9XnPz6/NUvLypBeGntb1P4YVO33h/yBE61T
 ko3OI6AW3dgWSP8eSKKetvbltTFgYg5iRsgDyDIZnQbayppIxrk89A7nu3xihBww
 0eguTL1SG4OBtuodTKE2OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=XitzhdL
 /J2rzXPUaSJiUZO43j06Tm/J8ig5hOEIWKWI=; b=TJCk2pPn8qYywaCjm3UBajp
 n4dDW7H8qZGnB2hv0kmTMpqtrFZ8Di3IfoHQNOahxMWf3YVteTyF7OgRQPZ0HyG5
 y64KIZxKodQIL//RE8Xvb1fd1jWO9F5Q3tW3yoRZiNYwJYjbw5i7hfn85f+B2LvE
 iQLGzw9mCDTbXju+VwJgD2sNbOwKRA3mS/Ty/JdJykkRMtRJLmSLud2fsR9CCzlB
 9/K1o3Lc94z+ct4UWQBqEQUHm2kupGVqVfc5CRNoL2RfoOl6Q7DP52kfH8ecn7aD
 nkui7gpsNA/XbJG0vTFmwmvnoEDGsHcuCcaKH6oQsCyYer6jsiyjZtf191eG7vA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [50.112.124.217])
 by mx0b-00498f04.pphosted.com (PPS) with ESMTPS id 4ee7x887f6-4
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 21:21:10 -0400 (EDT)
Received: from localhost ([19.12.76.221]) by cmsmtp with ESMTPSA
 id SPQqwyKrghUj8SPQrwwC5R; Thu, 28 May 2026 01:21:10 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: SPQqwyKrghUj8SPQrwwC5R
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 5/5] docs: nvme: Update QEMU command for testing
Date: Wed, 27 May 2026 18:20:56 -0700
Message-ID: <20260528012056.1744362-6-dmukhin@ford.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|CH0PR16MB4347:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 83e190c2-b39f-4275-f200-08debc576764
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: a2e5Pb6dLdqMzSpZZ4rLub/Bwxqr1hmoypPCnSgOh0qck8q0YZw8qc/l8480x7zOS5R4I3N/hFMj2NbGOdGrbFs3CZ6ttvR7NB/FcH/iGusRiwq7bB+5pIsa39WCdzCzJFRInx/YIbx+L7txrDtIJjnG9OJID7Z4vnJ5wOWtTTM+AI29OnHwJqBEQQWgfiD36r1RpruvB+u0fZ/cJdQGc01J4RjDpwEj3Kajup4YTdjk1H2fUJeLOH4z/cTtG3EuUxWtDyjaGM5d36kJZs0EQCoqYpCRefXfiTFTTyy/gJw2FXcXbmr2Kh8h+zeNKKqj6+n6X+qL5QWRg9AnhlyYjdrerxRHMsse/DiYG3fzVuLvhWqZxr18ICEa3llPndIqwkOXbs4P7pBfTODm8Gp+EbCJlPWHyEI8vfT04TJq9o66J8be/wyRA9EtIsBVSXZHhEfSGk1lz3tLLItZnfWU6j3kgVZOHEQfEm2Gr6AuMxQb1ZzShhXIH2C5xud4LsAb0u61wb4cp0BeDWdniCqgHi/OFIousP3tFpm9fR4Awx9iWqaQC/7fi5KPlI/qOvv+Es3I2wrO+UzEYMrJ6/PuRZ5LQMRU7es/JN2mdbWUnZ0Yh0Z+8bhxhiTCuQk4AAFq30v0ZRqM08eHHyl7noStFQyVsmPCV8rs/9Uj8ShgBl3w7RrXDGOxT0cKVB69xFmSsSrbnqkNJeiSHHJejcg0b6g394dB5SSG4U7ss+AEVC4=
X-Forefront-Antispam-Report: CIP:148.163.138.245; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0b-00498f04.pphosted.com;
 PTR:mx0b-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pT87aym30izhUFIaGrGGiEJV4R5zmzrKj0GtmRn458K9BBNvzIc7/MvNUm3UtJEQl0W1og9zZNzvROjGEu2zcHvkSKUjCYXOfhqiwbpu0S+gMKwAP95yQ0oOKvb6VTvGox7xrIRrhauDiHVCihC4RqtjFxwkcuU6Gxnbe7hN0YQIT6ZnlHr6ga9fZB3tSPMfFRVIwABOHDjKYOu/0FCEt0ukhlaSMygt6/Pv7EJWKKVvx/PawA+7brAKOxMqo8kIfN/nkba4vWcnO2h7D9AWDwnE/udkRQ2j2CTb0eHfAkGG4qNyjP3cNv+FbdTzDhb1fDdId+b2OzNT04VT0528BOwVj2nrymhyZNqf74e/utEnJLc3ra6bJfUOk1wWjCvmIf9c59hKt6v4t7fuH94dneGbTjGRXNFVJOC3AneVt6doOiSwp6KxTx7LRw2HVOB8
X-Exchange-RoutingPolicyChecked: SYo6zPwQ2qmEbAfJW0JYNgey0MhQ9c55I7pbl0dKBdPaJLh1kMb0TbmqljpKuNlJ02ECyL0xzzx2dSNx0CvyCb8Ggc9FArqVDBI65F3n9LJN9iIOWjnEQSZDrNAlnfkTSdz9fAArgKI93J2j6juw/vFbWYfmcwbOiM/5xscowdcS6GDvTToAGBfZ+OHScUoz4eOpDfOx1BKmRQcp41szQgoTT5ur2HIgO+77koFZ35NobP9tG0FNYl7pm4SueqpFbda/93CdiF4WV1gNwPZcmu9gYH4Ld7E85BIPPulqJPgMn+cuqJzxfdIfIont9LLUlWtErPU9yIeSon4pDLEGpQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jRaVUB515QgDrkbMiMYTJWu8RGjiyTud2OpKOXwE4I0wZsRTqEa9KL6t3sPFLUPWQeuC4/NPvRD4XWSQHB4rRrPpxnKXZnefVw1jUl+3zYV1L1T+nvGl5rAeEXUl3+h1kVbvcIuEpaRsFv3uokFMTAate9ltzqWrADqDLSnn9XC3OvmS2lkep0yIaaxC5Jg6CLXSBUrierpnWDuzW1e+jn+g73/tBHWiG7Ciyujp3dLEMe8NaLpb47Yfv/LR0tIu7VMG0bfbGMxdbyAdWd0lUtG/oJsvbVXvwj+0h0WsoajDgP06Gg3A0/S7LhS5SneMEIy/WyKWEiJ/M8d5WrKWWGJzxXTbkyEnr62+aH7Rk9BKNqXcJo2bukAPlAOThvYFAFYYB3p0iLs8L8MVrQT7/LPRYM/qYZ/ZbieevoN5Ofk1m7AVfXsFK7Lu1roe5GcT85AkdQoxuAhElZjP0ouOkkO6xdB4c3XPaE5b38qc1QvUBbmgcw+li+yypRieYmsBmBeDR6QB2SSJy0yhgSNZrvvKz9Ez7fVXzKd4Az3Hag0tyhwyXYiqNGQao+OOs1ltTencVvpYiy02ISJLgvRKErQI2zcGoQk/XyhX0BTdOzuV52RVxwde6GDkXLX6JarvQYtlvEsv69HRnKNLCR+q7A==
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 01:21:11.4482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e190c2-b39f-4275-f200-08debc576764
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[148.163.138.245];
 Helo=[mx0b-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR16MB4347
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDAxMCBTYWx0ZWRfX5tG9K/yUlPM5
 LBS+CaRCOI2ra2nAL6f5BAVZvHqnMUMZ640zxLHSD5tJrZGmjE46DTW8c8nAepw9kobPwmHSuIC
 92im7aQi2fQMID/+4KCITmlYHlgFzO+FURVUjia4RwY8T9T9CxxkXrbjGLHAHuWtkTJFKnyq41O
 8x6toPpsMUsSyZbUaHSfVGzZP55vg8J/eIy0g7YPG48Z+gh/QUL+ih5JZQBTqwR8lqRqf8Ggt3t
 YmlQv7eK1seszVthbCcqI8gNPWq+4tuqeQ5EYW9d5E4EjtGyYaB9RlddRiSPkXEyNKVNPhwNSjz
 xtjoHPcRx+eNjXhAlTNq/eK2wKJrzStMNBnBKiT5AvggBqMnAUPN4PTrOSxgXFf606DPNGL8G7w
 hx+k34BSDU9J/edGDTemGE017t370t80oeHV/HLdpmpgc83i5R/4gm+BK7wQHeNJG+nfWqM/wa5
 YQ4WL1/WiwxFnRK/jEA==
X-Proofpoint-GUID: e7lUlihjKSqiaw7fVu6N1LcEEgxD3MR6
X-Proofpoint-ORIG-GUID: e7lUlihjKSqiaw7fVu6N1LcEEgxD3MR6
X-Authority-Analysis: v=2.4 cv=Ju/Bas4C c=1 sm=1 tr=0 ts=6a17988a cx=c_pps
 a=Ja4avHF4q49+S+GKa94BQQ==:117 a=b7IhknPlfT0FN1EembXvig==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=NGcC8JguVDcA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=ARvDHhclS48edyKYUbLB:22 a=cbNQJ9GKAAAA:8
 a=IPOQxGYqeswESv_Pzp8A:9 a=DqJYxgmhk6moR-_7_KoZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0
 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
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

Switch to x86-64 QEMU machine for NVMe testing in the docs.
Also, add `format=raw` for empty NVMe disks QEMU command line.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 doc/develop/driver-model/nvme.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/develop/driver-model/nvme.rst b/doc/develop/driver-model/nvme.rst
index 755181331213..0e0624925e0d 100644
--- a/doc/develop/driver-model/nvme.rst
+++ b/doc/develop/driver-model/nvme.rst
@@ -95,4 +95,4 @@ Example command line to call QEMU x86 below with emulated NVMe device:
 
 .. code-block:: bash
 
-  $ ./qemu-system-i386 -drive file=nvme.img,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom
+  $ qemu-system-x86_64 -nographic -drive file=nvme.img,format=raw,if=none,id=drv0 -device nvme,drive=drv0,serial=QEMUNVME0001 -bios u-boot.rom
-- 
2.54.0


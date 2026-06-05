Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 143C4CD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 03:39:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 218D0849ED;
	Fri,  5 Jun 2026 05:39:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ford.com header.i=@ford.com header.b="ZIaE/bTY";
	dkim=pass (1024-bit key; unprotected) header.d=azureford.onmicrosoft.com header.i=@azureford.onmicrosoft.com header.b="BLnRRYo6";
	dkim=pass (2048-bit key; unprotected) header.d=saarlouis.ford.com header.i=@saarlouis.ford.com header.b="Z0bkFMP5";
	dkim=neutral (0-bit key) header.d=ford.com header.i=@ford.com header.b="Fh0sE8VL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 10D45849E4; Fri,  5 Jun 2026 05:39:27 +0200 (CEST)
Received: from mx0a-00498f03.pphosted.com (mx0a-00498f03.pphosted.com
 [148.163.146.23])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43F4384999
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 05:39:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ford.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=dmukhin@ford.com
Received: from pps.filterd (m0367124.ppops.net [127.0.0.1])
 by mx0a-00498f03.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654JZ106922767
 for <u-boot@lists.denx.de>; Fri, 5 Jun 2026 03:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=ppford; bh=9+z
 bUEStKR1xBZfB3EjhwHDHp55ccJHhs4Pfqo9c7vI=; b=ZIaE/bTY2M8EQDBZh6G
 3IsRNLxqE/IZe1Nr0+1VNI+OQ3BAlsqm9VhujfW6tMj0iB7pkq1g7MiG4YkIhXo6
 UEtPgdUBPobTxvGbQsdj+z7EGdfEd6eXahBAY/61Bcav7wfonEG6rcsHQUNLYl7O
 SMwPOFiSPzAD13+oLlaSXRCoeJD6wqpeb6UWecsOZyMc4ycenL9Mw3i1sgnqlCFu
 GkD7w0l64WNjzj1ZGLxPz1RmNdtGyJO110Nv2L1KYoD2zIXCDxFAr0yo7SW5C8i4
 kcb0MiRVFf+oS8lTw4u2UVcWDuH/d3jqHGhuQKHDrWl8THilVpZm/GqMpo1jYFeq
 RnQ==
Received: from cy3pr05cu001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by mx0a-00498f03.pphosted.com (PPS) with ESMTPS id 4ekfn7tkgv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 03:39:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBejVsji8UeoMY8OanDDteVIdDY+GzjijujE9NGUKXoh+RtQojw0Xv5vC3zcJUmv3iqKaJmcrQ9Nd9Bje3i00n+OZWvdyCEKaqmN6uh8dn4HixgLEri7vPhC6ANG+9aeBZVQ3nswJ63NqrQza4wvfuwPPMZKK3nsxvVs/IWWMxC6jZAKLFjdUzMaBNd+LnChte4raA9Fvg7/++C6LHtI5OrcNFCfcYI4Glc7o/UF+mv4yZ17WSpOqwTNEM2SRNU8jC7Rsrilr0PoOGHYjcRGxHOvSHAcRDyN8WsESoiXnafWkgMXbyvCSSQ3hUDF3hvFeOeBS3J/M77QKEW1xic18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+zbUEStKR1xBZfB3EjhwHDHp55ccJHhs4Pfqo9c7vI=;
 b=lVnUiXVmAOMWppNAUYnEkupPdYi4LCUAajf5TFH09r/ooXUr/zdDmwoYD9k8REsFq3X+rK1dQxUpiyIlyzK7CcyiaMCoVgccI8QEIjS6FC/PS77tSJjjHODIZuAwE/1igQgD79tLI0E7N3DCcdzaN0rX6C6Fi1eyxVtcf4Vo/by3zjRgYQ2cRAB/I9fvOQ8bGOPet6TEZpSrEtg/6mzte/2GhTChyU5gNS6R0je7DFbbBDQavY1JqDkRSrk30mU6Ujm4aYjQmBcp/nPpkr/4xzin0MxQH8D927+4hdl9PYqK78Kxx0uSfa8kbOi+sOQMiZv9Rk6pRJuVaWNvF40VoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 205.220.161.53) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ford.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ford.com;
 dkim=pass (signature was verified) header.d=saarlouis.ford.com; dkim=pass
 (signature was verified) header.d=ford.com; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=azureford.onmicrosoft.com; s=selector2-azureford-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+zbUEStKR1xBZfB3EjhwHDHp55ccJHhs4Pfqo9c7vI=;
 b=BLnRRYo6oamZ6OU5JTSvP+M0Y0nPl5FgYmSVE9JejI4p6YJrnPhJB33nkyr6Amm0cysOd5rP3kZbdfLf5RmBqpYIlXWv/NInbVYS6rXgkY+vRlCbMbuu+2JXQbRxQHYDDEsY7ITe5yMKQ7lxb9x3sn/0jOOOMOXXS75ML0JpZHI=
Received: from MN2PR20CA0043.namprd20.prod.outlook.com (2603:10b6:208:235::12)
 by MW4PR16MB4741.namprd16.prod.outlook.com (2603:10b6:303:16a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 03:39:18 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:235:cafe::39) by MN2PR20CA0043.outlook.office365.com
 (2603:10b6:208:235::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Fri, 5
 Jun 2026 03:39:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 205.220.161.53)
 smtp.mailfrom=ford.com; dkim=pass (signature was verified)
 header.d=saarlouis.ford.com;dkim=pass (signature was verified)
 header.d=ford.com;dmarc=pass action=none header.from=ford.com;
Received-SPF: Pass (protection.outlook.com: domain of ford.com designates
 205.220.161.53 as permitted sender) receiver=protection.outlook.com;
 client-ip=205.220.161.53; helo=mx0a-00498f04.pphosted.com; pr=C
Received: from mx0a-00498f04.pphosted.com (205.220.161.53) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via
 Frontend Transport; Fri, 5 Jun 2026 03:39:17 +0000
Received: from pps.filterd (m0373460.ppops.net [127.0.0.1])
 by mx0a-00498f04.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654MjNbk913785
 for <u-boot@lists.denx.de>; Thu, 4 Jun 2026 23:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 saarlouis.ford.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 ppserprodsaar; bh=9+zbUEStKR1xBZfB3EjhwHDHp55ccJHhs4Pfqo9c7vI=; b=
 Z0bkFMP527+PIZI3P/tduxTgjdvQ179eOV2xBMf91OmsmuD6rQMF0uycYXxK6hSq
 rQ+4h0TB3wmlkImiFYmCCNWFvAxn+A40bwJFwc/v4y7x8U6fEwRebNw8sXxbQ4w/
 MX6KNDQxL1uKN7ZOwCYcZYxhesqggUOLM/9BvSbLPYi+rsbgOvESi+wG+EjYjtZg
 kxbOFDTJaGU7lvE7ahE7CcLZhp8t9wpslgY7MGUOUlr24iOr2++3+78Y2b5wV9B/
 E8c7UzT88kkLMkBub0eBOnjb5Ph4bk9i8fGmPH+6LJQM9f53RjJhCcnfosRRaZdt
 9AAGuD2tTsOm7LBiDSK+qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ford.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=ppfserpocford; bh=9+zbUES
 tKR1xBZfB3EjhwHDHp55ccJHhs4Pfqo9c7vI=; b=Fh0sE8VLhjwSkSCMpesQHew
 iwlRlu0iAl0NrsrWtiS7aKaZOr5nIHzsEUKXkMDtKcY0tJEVyBoJSaBUyg5IYTwq
 jHTYRXOeWturc65l13ZDCVbNHCXwKRpw7l7UZhg8OMd5WqA/pYIYY3Ac0c/Xz7qM
 u9QFBaJsGRtqauFaQ7CrGkUyQ8b+kvs0PfNBlAol+xVV1qFVB/SQboRM7DuzzPQk
 pIPCoITa3KkPtI0LwV1mkSipFrSZI1P1QNo1cSgIdN2zsnF+hFhPxV84Q3jRYtWq
 5EVm2gbnvNUTtkzLR1HMTfOWSos/RvJHaUsIkrzJgEFuWM+HBowjwQn15MVRBLA=
 =
Received: from smtp-us.ser.proofpoint.com (pmta-usw.ser.proofpoint.com
 [34.209.42.160])
 by mx0a-00498f04.pphosted.com (PPS) with ESMTPS id 4eggry1caw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 23:39:16 -0400 (EDT)
Received: from localhost ([19.12.76.222]) by cmsmtp with ESMTPSA
 id VLOswPaFTbrKTVLOtwcgsX; Fri, 05 Jun 2026 03:39:16 +0000
X-Mailer: SER-76bead168636dc6ed1c9e51ce4dea80dbdd4163750742b614a4d871e565792b7
X-Cloudmark-MID: VLOswPaFTbrKTVLOtwcgsX
X-Proofpoint-CID: eb09f7eb-2dc2-34ab-a188-7b293c1db1fe
From: dmukhin@ford.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, trini@konsulko.com, dmukhin@ford.com
Subject: [PATCH v1 2/8] disk: efi: introduce {read,write}_disk_flags
Date: Thu,  4 Jun 2026 20:39:01 -0700
Message-ID: <20260605033907.1909319-3-dmukhin@ford.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605033907.1909319-1-dmukhin@ford.com>
References: <20260605033907.1909319-1-dmukhin@ford.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
PSER-M365-App: SER-APP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050030
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MW4PR16MB4741:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9173e9b8-7707-4d05-28aa-08dec2b405d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sktYqMKCRJg0r8HqqhyIpMN2yGVotNgERmkiVXRO/5qLDtuUcozkRxUobDSSV+z3qx1Jhflc3S8YoYTEXGSNBKbr7afZ9CINxh0MPSBCrGDARSvqKr8Eqgycq86hXEtveZQZNs8dgungdUIiM3BU5upK7SD4eLYOhfuo0Am3a4IVgwVtcfFQsIpytzWHfqHtHlWHHt61nmjtYP6a6OqwPkYGMZeWmeiWl+6AyFGUNdWsLj/LwJecDWK3RSN563wmnbT4SdwsPeSfyL4rW27F+dlVJ3Y+5W6+yNFTlCE7KjwFO9/EKn8VT8oQ0j3OI8aEqkRQ0qof2l8fk7Vsumpl4Y9r9Jwc2LHfN5ahlaHCDfJBueRc5nZ9ZjOZDKOZ6gf3P17LyvNUDwWbooPn63yldpeIpV/Nd1P1MspsFTlPskNhBY/M/NqaPhNGzO96OCNLXCNiBarH8rxUXyTpqpRPlamVK0UyH6S5Y9zyDdSc1zEseXmB3x1yHPBuk9Xt+/wY00ciop3m4zcu495k4LBNg0t99q0+H3fsQLucqms41V5irb9W1Yj4kvFzW8FP8VlDLmmdNBvr1mbfYvElJXsKVnq+R1b2btXSfn68SF67eYI0KTcm+vA5HZW0T7zgqxmJ8ks0DmhqD4OTtarYL6/iZ4AzpoDw72CiLLkSCZuZkDbKXxeIEBwVGI4Lb92D4pMWyXBBZpieJ3DiarSkBLW21akmzn/FQA6djX2LqzgOt00=
X-Forefront-Antispam-Report: CIP:205.220.161.53; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mx0a-00498f04.pphosted.com;
 PTR:mx0a-00498f04.pphosted.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kDIceDl5X/vwQaDTXTeoAteMZaOmnCFXpU+VDq0764qu6gPmSQVl3SwIreosAMnRzLwDWM7uDtOnEgHIZbHZdVsuIG9nQLHxw27Or8XvsI5KdvWP9Syv5pYzuoGSUmpc3VCPNAjxvJHVkFoKyJ5Ojs6shpPYi0mYywpvz2xDycDFKWMPLR+WHwGjGl1qYyBbqRvyWtTJNkFGYfMDpoIQHyj7NqzQOX3115M680hO+yO08sunwsCpu/qamZ+x780c54Q6IlvUqQawhmILBpBvoS4FGUWHmhdjnl3o2lF2t7eGI9KGW1wJM4aLGZcB7syFQKwa2TNk/vBMr0gMAQUC7Qjbi9Xys4wawg1H1Ee8mif6MvIFCFKPx2TN6H0r9HS0icqZCFcY4vQT4OQ9O2csAhQLGEJ5CxDPu4/QgbEeTO3vKYnE5aenrhQ42GZ7Nlug
X-Exchange-RoutingPolicyChecked: eFpF0C+NJ3472+LeswgfVVkmW+ZVdxXjqU8OW/4pWLSnjDnezA1GrYab+hA4iGO7KVqBAPiJfTZeSbvxJrIavmOG+v4nt1Kcb6BrP1ZVl/XjA8ogjSaHUaDt4+nftA+Hgx8IspLyGLhBCMKz5wewhhcHNnKuO8YUpkxOG0EWNTXJj08zZEneGokwFjlyd65B0mKOj+0WLKNyPy7BVY3DN1UIX3bS9+vt7XnLW2Ogzoca3K0FWyCXW/dTqiS6CGDVzWCh67VvXPUe/RxybLGl4//P1YXwz3b+rT0BnKZA9h/Pa8bSppsJ2aZ2vR6SY5lhI2P6nSeVPMdKLc8tnPXWpQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: G3XQdXvTqGe5pQMEEP7z8csSRA14DRYrbQiO4kP4aKFyTfCqY7+28Xy0VboMGufqzvSDvyWarO2/tDDlKL0gqSEjk0I21qSeeLRgrqsj8AvxfQir7xHnbzHwDfFZE25B+XoPA7gPaCC8OArAW1zePcXqI4Ou1kVLvIJ9u77Lhfa/v6/vIKz4Afic7BxVrX12t+9pRb33aesbQesBF07Mqla+M8XCRB5v+LSEoOLzvlNYAyOZCAEpwTx+8/J45silyen2RoU0gDLWO9IZiSGs65rdegPhr79GEIBoVr0pP3Q1CkMGt7evo9TRVqw5I5ZEjC33mLOpVR31igmqm/fE14UIHYqCaDEFIJOL9HEge38qseoTNlFzfMcBAFOsfFBZWNfQFhmjMr0iUKy+F59nzW71F8m9EmA6+FKlJFZTkjAfqs2jdBa9VPJz2y0r6jelSmhVefGKQ/HdQ+HdL24ordWT6wCwVprqD8q0Y1lM75UhxfGzvbzHUG2Jz1SvrlZHItqXrABDtWO+EEcPkHasJsiMhe2XIH8HuDAT2UsH95cz243REbyKF4mZOapFYvWiddGqvBZYGROrJIm9p/UFICv7ImQ6C3YgTkCN9O6JAdJVyTT9jn2RI0VDdAQQdbSk
X-OriginatorOrg: ford.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 03:39:17.8059 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9173e9b8-7707-4d05-28aa-08dec2b405d2
X-MS-Exchange-CrossTenant-Id: c990bb7a-51f4-439b-bd36-9c07fb1041c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c990bb7a-51f4-439b-bd36-9c07fb1041c0; Ip=[205.220.161.53];
 Helo=[mx0a-00498f04.pphosted.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR16MB4741
X-Proofpoint-GUID: QWh14S-qcHIcJEUq3Td67yuWceCFunud
X-Proofpoint-ORIG-GUID: QWh14S-qcHIcJEUq3Td67yuWceCFunud
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDAzMSBTYWx0ZWRfX+blMZqlNVzNg
 mfAW6nkSWo/oj4bdwixMFpdlTe9OvKQuDM/iQVUYcJ/XBCkeRFODQIAQHmQLM5pA0tHgrrwcDRf
 VNOhdFqmBurfYf/PMVwsa2OqWRic6RGS9jbc5COJcagtv8E8CkwQQ+sPN/9t6kUjErFP3J0S6bd
 0q0JZ2nvDFYbQTDJ5tK+Sn87XQBXd9MTts7yMHBGA5DhCV/wHp5PWph9aMrFEYxVkjf43o12lo1
 X1HODqnOMCYexK8zlzmvvvOOA/YOWVxx/6WMknyQB7WoAqAkM8wybNDE5DuP10qUnyB1jfElGEz
 ZimNGesbZt+Pt6utpY2InxBTOVBpv7DvgxFEbfuLFuTj/AJORGifnJFPVKtEFCbedYCZbY3bt0b
 Kbhqxbw/U5duGRk0mEMjugsXpMEZWuX/nG2U2yEiQIQmYE/d0icPthEcWo4mbAfzRTSJFROe9Hh
 cIW3IHbse/BSCbgZUww==
X-Authority-Analysis: v=2.4 cv=NKTlPU6g c=1 sm=1 tr=0 ts=6a2244ea cx=c_pps
 a=xO2ldQL2t4XaGU/+k0RdxQ==:117 a=lOEMawUel/sSvQipkIvNbg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=FelO9ux0wxsA:10 a=3PXLN80vpJUA:10
 a=6NUGLSImWEsA:10 a=w9pew1qAHqMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=P_n1zlmtWsCQbjROFjcg:22 a=YJXg7OVxOWrJwj3yZo-i:22 a=cbNQJ9GKAAAA:8
 a=cPf65LkkLi38YxW4vU8A:9 a=P0bj-C3X3jJDpopQwM1U:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050031
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

Introduce helper functions for updating top 16 bits of GUID partition
table entry attributes. The value can be used to store extra information
about bootflow, such as counters and status.

Signed-off-by: Denis Mukhin <dmukhin@ford.com>
---
 disk/part_efi.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/part.h  |  24 +++++++++
 2 files changed, 153 insertions(+)

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91a..6d5520e53912 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -980,6 +980,135 @@ int write_mbr_and_gpt_partitions(struct blk_desc *desc, void *buf)
 
 	return 0;
 }
+
+int read_disk_flags(struct blk_desc *desc, int partnum, u16 *flags)
+{
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_head, 1, desc->blksz);
+	gpt_entry *gpt_pte = NULL;
+	u64 attrs;
+
+	/* "part" argument must be at least 1 */
+	if (partnum < 1)
+		return -EINVAL;
+
+	gpt_repair_headers(desc);
+
+	/* This function validates AND fills in the GPT header and PTE */
+	if (find_valid_gpt(desc, gpt_head, &gpt_pte) != 1)
+		return -EINVAL;
+
+	if (partnum > le32_to_cpu(gpt_head->num_partition_entries) ||
+	    !is_pte_valid(&gpt_pte[partnum - 1])) {
+		free(gpt_pte);
+		return -EPERM;
+	}
+
+	attrs = le64_to_cpu(gpt_pte[partnum - 1].attributes.raw);
+	*flags = (attrs >> 48) & 0xFFFF;
+
+	free(gpt_pte);
+
+	return 0;
+}
+
+static int write_gpt_pte(struct blk_desc *desc, gpt_header *gpt_h, gpt_entry *gpt_e)
+{
+	const int cnt = BLOCK_CNT((le32_to_cpu(gpt_h->num_partition_entries)
+					   * sizeof(gpt_entry)), desc);
+	u32 crc32;
+	int rc;
+
+	crc32 = efi_crc32((const unsigned char *)gpt_e,
+			      le32_to_cpu(gpt_h->num_partition_entries) *
+			      le32_to_cpu(gpt_h->sizeof_partition_entry));
+	gpt_h->partition_entry_array_crc32 = cpu_to_le32(crc32);
+
+	gpt_h->header_crc32 = 0;
+	crc32 = efi_crc32((const unsigned char *)gpt_h,
+			      le32_to_cpu(gpt_h->header_size));
+	gpt_h->header_crc32 = cpu_to_le32(crc32);
+
+	rc = blk_dwrite(desc, le64_to_cpu(gpt_h->my_lba), 1, gpt_h);
+	if (rc != 1) {
+		pr_err("device %d: failed to update GPT header: %d\n",
+		       desc->devnum, rc);
+		return rc ?: -EIO;
+	}
+
+	rc = blk_dwrite(desc, le64_to_cpu(gpt_h->partition_entry_lba), cnt, gpt_e);
+	if (rc != cnt) {
+		pr_err("device %d: failed to update GPT PTE: %d\n",
+		       desc->devnum, rc);
+		return rc ?: -EIO;
+	}
+
+	return 0;
+}
+
+int write_disk_flags(struct blk_desc *desc, int partnum, u16 flags)
+{
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h1, 1, desc->blksz);
+	ALLOC_CACHE_ALIGN_BUFFER_PAD(gpt_header, gpt_h2, 1, desc->blksz);
+	gpt_entry *gpt_e1 = NULL, *gpt_e2 = NULL;
+	u64 attrs;
+	int rc;
+
+	/* "part" argument must be at least 1 */
+	if (partnum < 1)
+		return -EINVAL;
+
+	gpt_repair_headers(desc);
+
+	rc = is_gpt_valid(desc, GPT_PRIMARY_PARTITION_TABLE_LBA, gpt_h1, &gpt_e1);
+	if (!rc) {
+		rc = -EPERM;
+		goto out;
+	}
+	if (partnum > le32_to_cpu(gpt_h1->num_partition_entries) ||
+	    !is_pte_valid(&gpt_e1[partnum - 1])) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	attrs = le64_to_cpu(gpt_e1[partnum - 1].attributes.raw);
+	attrs &= ~(0xFFFFULL << 48);
+	attrs |= ((u64)flags << 48);
+	gpt_e1[partnum - 1].attributes.raw = cpu_to_le64(attrs);
+
+	rc = write_gpt_pte(desc, gpt_h1, gpt_e1);
+	if (rc < 0) {
+		pr_err("partnum %d: failed to update primary GPT PTE\n", partnum);
+		goto out;
+	}
+
+	rc = is_gpt_valid(desc, desc->lba - 1, gpt_h2, &gpt_e2);
+	if (!rc) {
+		rc = -EPERM;
+		goto out;
+	}
+	if (partnum > le32_to_cpu(gpt_h2->num_partition_entries) ||
+	    !is_pte_valid(&gpt_e2[partnum - 1])) {
+		rc = -EINVAL;
+		goto out;
+	}
+
+	attrs = le64_to_cpu(gpt_e2[partnum - 1].attributes.raw);
+	attrs &= ~(0xFFFFULL << 48);
+	attrs |= ((u64)flags << 48);
+	gpt_e2[partnum - 1].attributes.raw = cpu_to_le64(attrs);
+
+	rc = write_gpt_pte(desc, gpt_h2, gpt_e2);
+	if (rc < 0) {
+		pr_err("partnum %d: failed to update secondary GPT PTE\n", partnum);
+		goto out;
+	}
+
+out:
+	free(gpt_e1);
+	free(gpt_e2);
+
+	return rc;
+}
 #endif
 
 /*
diff --git a/include/part.h b/include/part.h
index 15daacd7faaa..4724e01c0a00 100644
--- a/include/part.h
+++ b/include/part.h
@@ -678,6 +678,30 @@ int get_disk_guid(struct blk_desc *desc, char *guid);
  */
 int part_get_gpt_pte(struct blk_desc *desc, int part, gpt_entry *gpt_e);
 
+/**
+ * write_disk_flags() - Write the top 16 bits of GPT partition table
+ *                      entry attributes.
+ *
+ * @desc:	block device descriptor
+ * @partnum:	GPT partition ID
+ * @flags:	attributes value
+ *
+ * Return:	zero on success, otherwise error
+ */
+int write_disk_flags(struct blk_desc *desc, int partnum, u16 flags);
+
+/**
+ * read_disk_flags() - Read the top 16 bits of GPT partition table
+ *                     entry attributes.
+ *
+ * @desc:	block device descriptor
+ * @partnum:	GPT partition ID
+ * @flags:	pointer to attributes value (cannot be NULL)
+ *
+ * Return:	zero on success, otherwise error
+ */
+int read_disk_flags(struct blk_desc *desc, int partnum, u16 *flags);
+
 #endif
 
 #if CONFIG_IS_ENABLED(DOS_PARTITION)
-- 
2.54.0


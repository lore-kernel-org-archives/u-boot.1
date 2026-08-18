Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2629C5DF67
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 03:15:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2212E607DA;
	Tue, 18 Aug 2026 03:15:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0sBBGSNr8JAb; Tue, 18 Aug 2026 03:15:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EF0BE607CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787022902;
	bh=pd7eXpUaEhPHQ9/zpi2XBzhnzFvjOrSGdDCOgZp/UNw=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xKfua1HRHiuTyOOfe8rFsAzlygQ24YU3k8E4s3No8bq41Xlf4dNSFAcFh6Prn7rjk
	 psniFxgJXxh1e3+7F8aSLuOAG+AR2AJAocVV2ryEBux82PpyuAapesrTjqN7XS0dOk
	 /nzln3d+7Q5Th0eD/upo+nMJlVjQY4ZeZVWkhpXp8utiFbaL3Wqz8gz/2Pk7s6OotQ
	 U6f0sO2ZG03eMaSbjVHOxFaaItYAggEdPTBKEc6fwNad0IER3afyaAhtVkHMm26jev
	 jYC48gWxQNwcIDt1wdedKYw4YErfOcI0liIXB2SY7Qg/Dd2FV5CzAmVRqZOA7dVS/y
	 b42EzmsAOjsPA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EF0BE607CF;
	Tue, 18 Aug 2026 03:15:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E3D0E230
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9D6F607CF
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:15:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XBk3E-QFCeh for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 03:15:00 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E4FFF606E5
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E4FFF606E5
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=Zbs3RLKs
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E4FFF606E5
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 03:14:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IEcJJOUzQKdB/fWe2qQiF46NAvpgq7JTj/haKrgURUfjLMPlMXzHQ8V74ywEcwZDdL/vRfFbljsJZS3CCb6vaZysqiw+G95CtaPTNoe5Z3ijVQL4DkO3PJXNAli0DoliggfyAZVYL7ON/zhw2kzBMSFBj6B/+t0zyiypllDe81xAmjEhfZANr9TLkNlrKLMR0F//Loovk/cpjtEuHYV4LMir5Zzvt2qr9iJwyZcj9x7jJC9s9E7C6ck+lECF4tDCHBqm10dhLDrLIfFwuUKULOq6HBQzMnRw9YafncmRNacH6OqKF1UG5B9z9KeCdm8BkwtqsD8BQjZOzA8/HZm1Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pd7eXpUaEhPHQ9/zpi2XBzhnzFvjOrSGdDCOgZp/UNw=;
 b=dtLtJ9MaoeNaAoWRMmzmVaItICrnFJoOu8YcdRaz4El44oFrSjRtoom4X2twX/R6mbd52PP81hlfCrRQ2Q6mzyK/qnpByZLsAtF/MUtR/AG+rvGIz4jYnHrU5kJ1odMQuIW6LLUY0Dc480FNRkOowkVxMvokUZXlizY0joVeAsAwC3Mm4YYm9HkoTSjHZrZ2PmMyv2FsWJ98hCHyB8RXoODuQE3dncORfaZlcXvBowDrdTvnr4rf4258Hl/xy79Rb4D3Pvfi0FWBJF0ByI/a6rTirFbH3s1shphKPNfj9uzOQ5HpcZdALJJsofdFBZP0MqmnimiL7lN0PJCW51V8wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pd7eXpUaEhPHQ9/zpi2XBzhnzFvjOrSGdDCOgZp/UNw=;
 b=Zbs3RLKsmqfNwdUQhP4ugupkHGxeMMy3HFKeCt9uI0zsfHnEJ62dkbHSeZTVEa0DOiDZsFhQuQ2/dPfAwl9YjUGAEB4Sw8NjomowMfBxTtiRyBnmU5p1EUs1/DWDj9tbMZfm3kZZQnKAfVE1Y72QemtVF8gjQ1vwt35TKgQ3v2jJelvranjP664+D7nZFCnPTmkgQpP814/+XmlI5lUdxO2YD+PeN7MV4FbsbianOqmhttgRX1OgwlTm3L0QT9GWaJkHkXL9Y9iVusrLSF+Oca7Ace/93ClDihFJK1jkM0wMx7N8Y2TQUYTNGqRF1LZnFU7yH+twc6aeCoqAquHU6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by VI2PR04MB10113.eurprd04.prod.outlook.com (2603:10a6:800:230::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Tue, 18 Aug
 2026 03:14:53 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0339.007; Tue, 18 Aug 2026
 03:14:53 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v4 0/3] net: fsl_enetc: Add SGMII 1G for i.MX95
Date: Tue, 18 Aug 2026 11:18:47 +0800
Message-Id: <20260818-imx95-v1-0-12ef3eea3943@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIABfPg2oC/yWMyw5AMBQFf0XOWhMaj9aviAV1cSUeaRGJ+HfFc
 iaTueDIMjkUwQVLBzteZg9xGMAM9dyT4NYzZCSzSMVK8HTqVLSpJmVMomVew7erpY7P71PiSFD
 9zu3NSGZ7B7jvByOLQJRtAAAA
X-Change-ID: 20260818-imx95-d59e8cc4927a
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0024.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::20) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|VI2PR04MB10113:EE_
X-MS-Office365-Filtering-Correlation-Id: da9c5249-eead-4b55-e31d-08defcd6df47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|19092799006|1800799024|366016|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: JTmxoSZ1prEVFX8pNK7/1Z97XiTKqgvzCPQPrtq3TXyUxDd31T4Laxpd96+jTXRcOJSiLOtIh+jGIW12/v1wAqgIITwnDt/kP5+kg/2V4KRlM0NbbuP7XQ/p/9X5EL+wawkhBq4TtDNzlp/40hVl4rkLE+Dxl0ehHA5Kf0XpkcKH2GQjooymKKejv/5pDHfcEKoZeqiudSsjA3HCojT5UVsdIhsP/I8US5LBPoFkAgyo6/Prk7ER0TFU+OgrPjWe8YZEz9qRCTAThyUZCLAkV3VUrWRCOyiowTkaflaVXsbuqsScbO1gxtLAFiJ34cD5OUOApiqyRKgRbA17FLAb/QMIJqi1wrYVkldPqZnkIUI+JkfbQGT+hOQyyw9mFjpzm4bxjroNq8SXtvl+9U8beaFDQWa90d3+wSb9nQTVDqEgLDhTDzMzuTi2x6y889vGNvYwR2w78e1wYlZGJ2KOKiJjDa987iRnBaJlVJs/Ed4DhMEx0ZHImrUaxv1A79CriKGBni5DfHxsfWz+YCCSZxIwiePFyoj1brLW1bym1kmMOYlLe6PvQ3mHrz0+z1LCLiyEiS9uxkwK6C4t8xyE233JXoglJVfTVPS+U1NaLTE1pepBZR4nIJmHX/JC6a9Y0kvYRAEkD5aYtSXEOUGETVuvMtofHVQnVY+62kQ6OYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(19092799006)(1800799024)(366016)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZDVUNYUWEwS0JoMnpDSkJNdnRnZDc0TWhheDNzR2UrTlJld0F0Ky9PMTBo?=
 =?utf-8?B?ZkpNUFB2WUNScTRqNHg5R3VDQk15LzFKb0QrRlNUY1pmQUJuVWxPSlpWdGty?=
 =?utf-8?B?RUJoU3JXcUlxK2x6VFhRc09hZ3Y3SUhxT1Z6RUk1cmVBSmpPV1djZHVBb2V4?=
 =?utf-8?B?Smw4RFhrakUrTFdKNkNiTWtrWEt4RW1ON3VFcW1LODRiRnlBMFROeklqejBJ?=
 =?utf-8?B?Z0VZTUJNWjN3cHQ5ZXVCWWRiL3BFUzdNL0VNT0MwanVVMUZ0QjF5S3pqYmFi?=
 =?utf-8?B?NFZTeDMyRHZrQkxSVTNmdlgxckZad2MxSDJGNXFHM1FLc2xjZVNiQXdTVXBn?=
 =?utf-8?B?YVRJTmNNVzBSeGZkb1IwRm95WEgvVUM4S3pmdDMwVjUvMVRYb1k4b0JMRURT?=
 =?utf-8?B?Y0ZhN3BWMVJVbldtMzBkaFZyQlA5R1RvT0FESGVTZk5pTVZraC9KajRUUUdv?=
 =?utf-8?B?M1cwekVZdmRMa1JsOGl1Y09tSGxSMjYrSnJiN0tzOEgyamRKYVJ2VGVJN3BP?=
 =?utf-8?B?cXdPMXZTZkJzR0xvNDBUTTRJNFFQbmxOMnovS1I0TkppaHlVRnplUnZMeXp4?=
 =?utf-8?B?WVpIM2ZYUDNSOHNTVE1wZlIzRURMckJtaXNXbmkrY2FhbDhBK3JSbmZYb2FV?=
 =?utf-8?B?SVVsZDE1VW9ENG12RER6TG94Z0IyYmF3ZlppcmRlQjZOVmJjY0dlRzNBYzdt?=
 =?utf-8?B?WHQyVy8zNXMxdlpoWDcwT05zZk9nQ3BxdXZTR2FlS0h0cVpoc2lKcVRIK3l4?=
 =?utf-8?B?c3VoVHAzVUZtcCt0SHhLaXFSTFhWL1Y4d3Q4Q2JLTVJZU1ZUdEtYMWlzVXYr?=
 =?utf-8?B?YldSYWQvaFNOQUUrMTlvbXpLM2lYZ1NnMDB2R3dFSEE4SDZEMVI2Q0dGMlFE?=
 =?utf-8?B?Y0FYbERvOUFLL2ZmbHdzRnR4cEpCbXNzZHVhUFJnWTFOTHBhR09IbDZRU0I1?=
 =?utf-8?B?MVgxWVFOenhac0FJbnZheE05NEJjdHY0QTMyNmFNMjhsRUFxWG5zN3ViaGNW?=
 =?utf-8?B?dFFGZTlWY05rNjhMa3lXa21pYlhyc0RQdTdvcGE2S2crZ2JUcFgyWE1qZjdS?=
 =?utf-8?B?MVhwUjV1RVRTakl0MmdTMHV2RE5nTkZBWldBT3ZsdFhMbGVDV3lCdEVrOWdq?=
 =?utf-8?B?b0d3WEVDY1hZUllkeHFDZitBU3RqU0JTSE5Lc3J3eGhHMzc0QmNsdElVQ0tX?=
 =?utf-8?B?enNtTEt1NDNzSVhmbVMwbHdadEFLUEtvRzBrQWF1UXZtMGpDRTJCRTNwY2h5?=
 =?utf-8?B?MTZtQkhwTWVjVFJtdXhUZmlqQzh3aXF0WnFDUHlHOGhPeXU4Y1RxM3JLS2Ev?=
 =?utf-8?B?MGpDQk5nYk5HQ0YyTGRiSk1JbktsQzl6QzV0dHZpTG93NnR3QjJBcUhmblVl?=
 =?utf-8?B?cW42RGRhMHBVbVVNNnIybTY5TjgrdDVmYXVRcEF2Rml1bytHblVxNmNtcXhE?=
 =?utf-8?B?Y3JTd1VIZXUxczFPOTdmaGUvS1gzQklTZjhQaTI4ZmhkNDZFMGhsWEUzU3lQ?=
 =?utf-8?B?NDRpaTNEWEZoSHBwNDhxamFJMWMvYUdzNGhlTXpVbXRSci84ZlRwZlJyOTZS?=
 =?utf-8?B?Q3NPVHd3WUNqaHN1ZWtjUTBDMHM4QUhFMktNZ3o3YkdEb0dlZGV5NEJGZjBR?=
 =?utf-8?B?elVzZXJ0dkdWVTYxN0RXNm1hanY4ejZ1SHkxVVFpa1JDc0ExMkFaeS9kcVRR?=
 =?utf-8?B?b2xyam1KWW5pdUJzMEJyYndpSHFUcHp4bnlDdjk3Uy9iNVltL1VON1VkcGNi?=
 =?utf-8?B?ZmRTQlA3NTNqZEFQTUI5Q0Eydzl1blVaRFV1R0FVMER4RU1ncXJXTldsQjRB?=
 =?utf-8?B?YkxKQVZ5M2gyYStRVEQ2amFCcG4yZytWQVc3QTJNQVZ0TnZwWkRmbWFoek1G?=
 =?utf-8?B?dmtraWtFUk02YjBucm5DYjlvYWdHdy92Lzc4c0t6amhtZm5oeWFrVW04Z2dH?=
 =?utf-8?B?ZUtHOWhFUmE1RWk5ZXBWVjRCWmhnT3FGaXpvQVlqQnAvZ1pzUERQSy9WbmJ3?=
 =?utf-8?B?ZVUrRXhkNVY4R25Id3U2cFEwS3FvbXVBQmY5Z3AxRUR0Q0tQRjBPL1dDMTNL?=
 =?utf-8?B?RWlUWXRmc0tlejB0V0ZsdkhnRGNzdkM1VzEwVW1YajZTOW84a3dNaHkzc25N?=
 =?utf-8?B?a05lQ0xMbVo2cGp1OEF0ajcxU00wN3J3c3ZBMy91ci92NndENVlMbGxBbWRk?=
 =?utf-8?B?MFRnV0FBS0xEalRPb3g0NmRVd3RsVEswTklrM1NmUjhvbDBQTjM5cUlrR1NT?=
 =?utf-8?B?am0yNVBMcXlwVFlGWTI4aU1EaFFBdGgwN2NQcHlhMk4rNjIreDBpUGR3ZE4v?=
 =?utf-8?B?dElkSVJnOTM2czY2NTB4b0VMd29pMG1LZmhDMFpINm1lK1I3VWxQS3RhSDgr?=
 =?utf-8?Q?w/bXxBcL8lls4c4aZo/InAb7N6I0qBU0kmwJL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9c5249-eead-4b55-e31d-08defcd6df47
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 03:14:53.5281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cMHfWXVBN2w34be80Upap2F8lGWr7dZ7YNeHveiBPTPmXYN5oRUCZOaH2d2GDzHdz7h1CDqTTT/tFxUto0/PveTZ2jLg2p5KONvA+3wIO2YVKup30+7LK5zcDoy0rICA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10113
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

Changes in v2:
- Fix CI build failure

Changes in v3:
- Replaced #ifdef CONFIG_ARCH_IMX9 guard with a runtime wrapper
  function, improving code cleanliness
- Added explicit 1G-only PHY capability restriction for SGMII on i.MX95
  (no 10/100 support)
- Added a new public wrapper xpcs_phy_sgmii_1g_config(）
  fsl_enetc_xpcs_phy.c for better abstraction

Changes in v4:
- Move the xpcs_phy_sgmii_1g_config() in fsl_enetc_xpcs_phy.c from patch
  3/3 to patch 2/3

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      net: fsl_enetc_xpcs_phy: Extract common PMA MMD init sequence into helper function
      net: fsl_enetc_xpcs_phy: Add SGMII 1G support for i.MX95 Ethernet PHY Wrapper
      net: fsl_enetc: Add 1G SGMII mode support for i.MX95

 drivers/net/fsl_enetc.c          |  19 ++
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 700 ++++++++++++++++++++++++++++++++++-----
 3 files changed, 638 insertions(+), 82 deletions(-)
---
base-commit: 527115ef6783cec49e5610c523c124b399011361
change-id: 20260818-imx95-d59e8cc4927a

Best regards,
--  
Alice Guo <alice.guo@nxp.com>


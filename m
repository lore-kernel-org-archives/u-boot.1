Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B09C531CC
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 03:07:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4943140ABF;
	Fri, 24 Jul 2026 03:07:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dY-xaIWH61Aa; Fri, 24 Jul 2026 03:07:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 52B8A40AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784862442;
	bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r7nCpqfXWsQWg1baHIc8/WtWH4WuwppjYdn7GP3fQkLEnDFBbs6VgVnHzDWolF+MD
	 ock7DKtHWc//gnRA6llHAAhFNDdBb/jkgKiM+B8KgQArYF0XCqce4iZH6FZPbBiL6T
	 j/QFlKPYf5TQltI5sukAZzHc3FdDjhtNI8FIA/q607QAByhj6+n3FZnNM9+A+N63Cc
	 qUu/2L3xlNnmeXry501AvI8adOPgHkmlS05sgl9SJK52/JBvMJxOjVbJLD9Miie5Ui
	 bg2H9kHNoof7jiAqO3SDeaN/Tf+pGwJooE7ymfvzvD3dO0EleWgpITqBSy6PgwecAb
	 u4hYhComIRa+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 52B8A40AC1;
	Fri, 24 Jul 2026 03:07:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 59F54707
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3EF5440AC1
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quKZT4rLOnO4 for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 03:07:20 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 260E040A83
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 260E040A83
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 260E040A83
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:07:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fehg4L0Ih6RBjNKlUOU1U0VTpGJLohLa5SRir4UBZvwRY6FygJ0XYuIHV73iJjQ2DNlWIqp1rrQpx3QtDNcW61AYzDc+qcXD6zgmdoqMRt+cWPAlnFiVvqW98CEDtrNibPQk8QTNgqWjHtOvSYmv3+/zzp5pkMmehHO3Otnrci8UX7wBsmiOKTvvLEhtQXDC7QqbjxcMuzomJ2/vyo1EU/y3qZ0+sbUauxoePD848Eg6mMTj0CGJSHEgAlRZoNJEYLNvW/GpbAlTsP/tOdKpSi7KtfYSXNQtOxwTsmaYtKT+QYtgf7K70BKJSVn8wd+dgjW7zQxzR4xccAAmP9FfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
 b=yeQoZ+zr5jfet1pTtfRVA/jfYmwp2UEBoDJ8xgtxAlqjpvYBQsJru8nJCVFi4Ev2zXx9z7cbT4GOKM8sfk1SoUW+6zqX2s0BbG++gohrRXdiCh+AVKSnKXndoL7c7OJHaNTEKMcN/mda0b8EvF4wPewoKKHL4J4yPGcNUA2TlMnQj6G+UuSC7ARp3hw/j6ZMxIAMNS9nNUp/iPl8gjt3YqxoLOar8RgskEC/3uICJ1OWopjat9Ar7BCuBMFIMcsX2PT/w4vAYTcTJOPxa19oWl+TEmy8s6YXt+BoWa0uWufys2BJNfQnmgcZJyDpOHpVVW+wWahaY4HLEdRDXr4YOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by GV4PR04MB11749.eurprd04.prod.outlook.com (2603:10a6:150:2df::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 03:07:16 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:07:16 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 24 Jul 2026 11:10:43 +0800
Subject: [PATCH v3 1/3] net: fsl_enetc_xpcs_phy: Extract common PMA MMD
 init sequence into helper function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-imx95-v1-1-7131a9e17fe1@nxp.com>
References: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
In-Reply-To: <20260724-imx95-v1-0-7131a9e17fe1@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, Marek Vasut <marex@nabladev.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA0PR01CA0122.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::16) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|GV4PR04MB11749:EE_
X-MS-Office365-Filtering-Correlation-Id: f64f820b-1946-4b1d-7f44-08dee930a9ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|19092799006|6133799003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZNUUSMCErXJ/b//z3xk9VOJl6U5jh9G+CI4q6AjHN1Fk9C3iCYUyJEdbIHUh5W75Flwa2ZzTDKvil2SvcBpdwWKR7ijoKLIMv2ObtkXFr/FEcMUJCvfOkm//Y7plY9MQCVolthD5WB2X+997qD4uKht4fY7qXt7wyOu2kwzYvDJlCKBudgew6xSfrAc9QahALcZCgjw6H8EcbXHXt9arAw7Gm8IXgb9nWrJI6Wpv+zI9bCJoOHQ5ua3OHNU93gMTH32muOsyIlWxmG9doQwm0fD17UhJTl4IKcj35Cp1aNUpCqHnH+VHKWYtU/lHqrD89e7zqSZkLR89mTTQF3PIoxa/XhjSQV8CCBOGRXxzR8rRsNLibkmv/WLxVAUTRXAPmWoTi0cudr/fOZw9TdaD2rA2TAKHT+VY8PHQziFYG49YyjY/nA6yZR4PPMXyV6nKNoW6bsLuga04gRdqVzRVCjSl+GGRPNvEQOhYBCvUm7kfu9VYlMx0sdbFuFDggrg/1AKb/+AkhyAMoKDAQtcMeraJKlTT5rtKfHDkGvhH8YeZ9ddFYdiQFVFA80oodIZgVxUAG8e3Bt6108bk8XL+efESae7UejuXXtAEzcPFVlwsmK/P7B2UDOnoQVxpnPiwb6HkWi9cC3XgcZchDXusVOxalSynce5bf+tUbh9ekJc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(19092799006)(6133799003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajN3Z3ZJeDlVc0lodWRtMEk0N1NoUmVOQkdMbGFXRXNCeGpSQzBWdHNSTnIv?=
 =?utf-8?B?ejRzYmR3VDZIRmtJUHo3TTl3ZkdKM1VNaDRhRGc4ZVpobSs2UCtDUHlhczR2?=
 =?utf-8?B?Z2tjaUZJak5TdGZpUXdSbFhoc2RsekdReDJsbm51bm0ySVEvemNKQTFkWWhM?=
 =?utf-8?B?QVVUU0JYaSt6VHJucWxqNFUyanR2cEhRMVN2VWlZSTdkallpcEk1VW5kNTE0?=
 =?utf-8?B?RzU0OC9SdTkxVE9VRWxIeUtyVnZDZVRtOWpqelpJazkrSWtFZTJmeHJkYStS?=
 =?utf-8?B?TVRjNnl1TFFVbUcrWHRPbHgyYzI1TkdaMlMrNlJvL1o2TlBKbTVwSXY5TDB5?=
 =?utf-8?B?SER4dlpIbmpIM3RXZ2g0L3M0TkN5SC8zN09IWlhDam5iVGYzZjJDSDA3YTFj?=
 =?utf-8?B?dnFlcmFySXJOU3BoR3N5R2s0Q1g1alJQMzlJZnUybjFXYnFsRDZZVFRRT1ZP?=
 =?utf-8?B?RFZzd0ppajhxK01GbW9HOG44L1FYVTd5WkVMQys5dW9rcXRvdDc2WVR4VGxP?=
 =?utf-8?B?ZnZCTVVwc2szdHJHTUxodnFHYjR1bXpKV3Zvc2NCVjNRRVVXRjAzOTJrR1RK?=
 =?utf-8?B?ZjZtb0ZnYXlUbWpEamdjZmFGeHpLSnIyenlTYVBpaERjcmZXVWl1MUNsWFlH?=
 =?utf-8?B?YjNXeFhMQ3BBYm1jcUdkTjFtWkNEelV1OXFvejNJRkJ2K1FSWXdrYy8yR01s?=
 =?utf-8?B?STRPZmdaMldZQzRFVHFSNDRuK1FqMVNXVU0vcFNkbnlRVE5GbVp5ZU93ZHRv?=
 =?utf-8?B?MHl3YW40MWFhendYU1pHUDVpaWxiQmRBSnUybFdMc0xsa2U1QVJSMHJYNVpo?=
 =?utf-8?B?Yjc3SnJHdWxOTHRBcFZqNjlXdXZzdVJsUlg5S243emtkdW1wZWRSSVlpTWs1?=
 =?utf-8?B?SloxSjd5WXNSNU9hdE9wdlJhalVadFNUbUE2MTZVWW1oek9CZ3VKTDlmaEV2?=
 =?utf-8?B?R09zUkVZM1hmYlZuY1dDeUxUeHBOOGpHRU9CSWFCVHdiRldKQVY4R0diZUp4?=
 =?utf-8?B?Ylc3SUZoNkJSdzJERFVVQnNRS2Rvd3B2SElKWlpXZzBmdDk5VzNHV3NrWWor?=
 =?utf-8?B?aStSeFBHR1RlZUY1RXZZalFzUG54TFJXWi8rSWtQdGsyZytRZDExd29leS9u?=
 =?utf-8?B?elNmTmNjcGJ6ZjhxY1VHSDQwRlc0M1MxU2lIWFliQXplUExlNDBDd2Z3dzQr?=
 =?utf-8?B?RFBFaStzcHdYYlNPSlY0UUY5anRSM0xCQlJTWFpVcVFuVzN0cXRKemE1MXZV?=
 =?utf-8?B?ejMzLzhVcTVWY3dWdG9vVS9NQTNERThFSmxUc2Y4djlnTHlXNnBreXRUSnhx?=
 =?utf-8?B?dVFBeUZ6dWdMNUZQdDZaektWelZubDhFcjU5bnljRWNmOFZEckMyWVRweFda?=
 =?utf-8?B?eDQvcXhKVm45clRZN2UzbkYxTFZFZW10Z0RROVEzaUVJenRiZkxaK3JuYnhR?=
 =?utf-8?B?WFU2WXN4TnQ2a3lLSi9SRDhNQ0pyUjRhMjAxWEdLQjgyWTVLenREOGhUZUtu?=
 =?utf-8?B?eGR2cUhKd1ZrQXBxeFkxcGd4NnA1ZHNpT3c3emFJbjVhN0h0dmFCNUYzcDB4?=
 =?utf-8?B?QXlnTVRmZVlRdE9uWWJld1ZkM1hFZHRwYm5tNHZ0QXVwR0ZFM0JSYnpOVEZR?=
 =?utf-8?B?VVlHUXhSM2NIZndtWklMZVU0WTFpTEh5NEJPbDRlTHoxNWVzbmZJSDRkL05V?=
 =?utf-8?B?WjJhazV2TGhQYm5uMkVONEg2M3NtTnQrQkw2SkFQTzE5VUNLN0RLeDVUWXVs?=
 =?utf-8?B?UGxjdjlvZUQ2dXNuU2VDTVFram1TN3FIVUpYQXJ2UXYzeDFnZXp0ZTFQWi9P?=
 =?utf-8?B?ZGsrbHJLRXR3Q2FvUlZMV2pYNmRkdW5SNVV1V2t0cnVJZ3lXUjRSb3BCazJH?=
 =?utf-8?B?MCtHakFZMGFnTFFrakV0dFZtRzFTajVnb1hPZDZLMHNRUUt1UDdJN2xUTk5q?=
 =?utf-8?B?YXdCM0JWSkRsT016SU1TQXIyOGFGOEx2M2pHZHZPS3lubjJnc3VWanpZdDYx?=
 =?utf-8?B?ZGhvSUhMOGdycmJiaDhSNFZJcklURHJsMm40Y0FuTGlsT08yL3BERmsvQndE?=
 =?utf-8?B?bWFnTnZPRGtXemw1aTJuenVaTUxyQ0ViNUhoZFlCKzhHb2ZNaDFTRGNhTHAz?=
 =?utf-8?B?ME5VSjRaT3BXbUxHT2EyRk5vQzd2a1dxMjZhait5eUNiTjExVk1EMTNwaC8v?=
 =?utf-8?B?d0FmL28yTjVnVjJJMHppRTIvZElhVVB5eHF3WnhWU2RCRUxuSjgrRFZQQVdh?=
 =?utf-8?B?S1pWRFJ5MGlwMmlUTHYrdUZrR2krRmhYY3ZHSlhFcjVMcnc5OWhwdWZsWStV?=
 =?utf-8?B?amhob3ArYUF4cXFKb2U4S21wMHEwRzFFOVdKNU5TOTRkN2hvelprNlIvT1JW?=
 =?utf-8?Q?+J0k4fq54nAxOrDIfRBVrJkc8n+NAuwGaggTn?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64f820b-1946-4b1d-7f44-08dee930a9ac
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:07:16.1535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IX1Sd9P9mBlHLD+BhAfGWzKFUXtHsywvd3W9lxsjpk6MzppuPmFYK3jeGM6rncTgsVPc4S+cAWvsMfGBdJVZdFU14ZbqBUa9/EEO7fQyYJc9PxCjMldfHkxJSs8ZB7R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11749
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=obBnECder6V0fR+/A7ffYzBgemGy51KzhYAqP63q41U=;
 b=jNTeCagqgtheEwHOu9mIOYS2sRI6US+3LD0bnQaqMDbdx+QQIYKtE6srMwTMXJ8q8zvJZV1D8mMAwlxBiijHv7EpXTQiFHz7wCT6vZJQ/WpvUT3ixmMOyBl5WtcWWYaflC5uXVdlTAiQ86akLtB9bVDlSZ3bGr563ZAojLXmxjsrfi8tnnj3hKVCwCOaUWGfjPn2i0xxObdLpEvMw9l0bEXqrYTqKY3E1sPK9EheMj1NiEquftVZiYtXVi64HIgXP9z4jbqSAGoE15lL14uf8bJ6/USaIypwfqk9xsNTyRVK0db/k4RQ8V50uhsmETCGtWYPHeQVSLeWUpSG9JIIdA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com
 header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-NXP1-onmicrosoft-com header.b=jNTeCagq
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
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

From: Alice Guo <alice.guo@nxp.com>

Extract steps 1.6-1.13 of PMA MMD initialization from
xpcs_phy_usxgmii_pma_config() into xpcs_phy_common_init_seq_1() to
improve code reusability.

No functional changes.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc_xpcs_phy.c | 179 +++++++++++++++++++++------------------
 1 file changed, 97 insertions(+), 82 deletions(-)

diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index 4039690223d..006a2bd2238 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -261,6 +261,99 @@ int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
 	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
 }
 
+static int xpcs_phy_common_init_seq_1(struct udevice *dev)
+{
+	ulong begin;
+	u16 val;
+
+	/* 1.6 Turn off C37 auto-negotiation */
+	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
+	val &= ~MII_CTRL_AN_ENABLE;
+	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
+
+	/* 1.7 Assert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val |= PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val |= PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.8 Wait for more than 1us */
+	udelay(5);
+
+	/* 1.9 Deassert tx_reset and rx_reset */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
+	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
+
+	/* 1.10 Power down MPLL */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
+	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
+	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
+
+	/* 1.11 Change RX0 power state to P2 */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
+	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
+	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
+
+	/* 1.12 Assert request of transmit and receive */
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+	val |= PMA_TX_GENCTRL2_TX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
+
+	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+	val |= PMA_RX_GENCTRL2_RX_REQ_0;
+	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
+
+	/* 1.13 Poll for acknlowledge */
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
+
+	begin = get_timer(0);
+	do {
+		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
+		if (get_timer(begin) > 500) {
+			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
+			goto timeout;
+		}
+		mdelay(10);
+	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+
+	return 0;
+
+timeout:
+	return -ETIMEDOUT;
+}
+
 int xpcs_phy_usxgmii_init_seq_2(struct udevice *dev)
 {
 	ulong begin;
@@ -436,93 +529,15 @@ timeout:
 
 int xpcs_phy_usxgmii_pma_config(struct udevice *dev)
 {
+	int ret;
 	ulong begin;
 	u16 val;
 
 	xpcs_phy_reg_lock(dev);
 
-	/* 1.6 Turn off C37 auto-negotiation */
-	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
-	val &= ~MII_CTRL_AN_ENABLE;
-	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
-
-	/* 1.7 Assert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val |= PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val |= PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.8 Wait for more than 1us */
-	udelay(5);
-
-	/* 1.9 Deassert tx_reset and rx_reset*/
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1);
-	val &= ~PMA_RX_GENCTRL1_RX_RST_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL1, val);
-
-	/* 1.10 Power down MPLLA */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL);
-	val &= ~PMA_MPLL_CMN_CTRL_MPLL_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_MPLL_CMN_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0);
-	val &= ~PMA_TX_GENCTRL0_TX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_TX_GENCTRL0, val);
-
-	/* 1.11 Change RX0 power state to P2 */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0);
-	val &= ~PMA_RX_GENCTRL0_RX_DT_EN_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_GENCTRL0, val);
-
-	/* TODO: check if it is needed */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 1, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL);
-	val = u16_replace_bits(val, 3, PMA_RX_POWER_STATE_CTRL_RX0_PSTATE_MASK);
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_25G_RX_POWER_STATE_CTRL, val);
-
-	/* 1.12 Assert request of transmit and receive */
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-	val |= PMA_TX_GENCTRL2_TX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2, val);
-
-	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-	val |= PMA_RX_GENCTRL2_RX_REQ_0;
-	xpcs_phy_write_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2, val);
-
-	/* 1.13 Poll for acknlowledge */
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_TX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_TX_GENCTRL2_TX_REQ_0);
-
-	begin = get_timer(0);
-	do {
-		val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_RX_GENCTRL2);
-		if (get_timer(begin) > 500) {
-			dev_err(dev, "Polling timeout, line: %d\n", __LINE__);
-			goto timeout;
-		}
-		mdelay(10);
-	} while (val & PMA_RX_GENCTRL2_RX_REQ_0);
+	ret = xpcs_phy_common_init_seq_1(dev);
+	if (ret)
+		goto timeout;
 
 	/* 2 Config MPLL for 10G XGMII */
 	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_REF_CLK_CTRL);

-- 
2.34.1


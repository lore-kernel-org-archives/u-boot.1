Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789F6CC6B16
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 15:05:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3862B404C1;
	Tue, 13 Oct 2026 15:05:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63jMPRhixfG5; Tue, 13 Oct 2026 15:05:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5D8C34052A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791903947;
	b=tTonehedT3/1YENDlzTGc6BZTP7QSJIINSuRhjc2vbFFgIyi8xNqail07U4NiijN3chz
	 HpltsSQYBwIq3Dn5+f1/7N5k3+oZ5Zrz1NQjYlY+fk1l5s0QX0YrbfIhOcR3cOp49aeGD
	 THynQSFEJkLjftq0PPOVWxryYQTdZBE3LZet8HRa9/JKtMc3NxfzJSncMeVzaJ6FdPeCh
	 VlOkqeRXxnhkizCiCFP1HuJKZ9h5VxLtTAkA8FcCBEFqNpaQ5o0BKzz803KVLCtXykyHE
	 ydlYQd0OXAnIHDU0bIoFen2X35tWJ+HFbAYC+/9m1y+Z5Yb/fuFcryTS5t38sZU+lHQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791903947;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SZ5ytif689T0emCf+V4OEnRCkPObabIdBp/Gl74aS2Q=;
	b=TaBy7mF98sY4D8O6oKOJgFppWZXH0fC5nY0j1VGlc5wIRjvlUnnYL08U0V7tRdnsTEDK
	 xgWpHgjWYjlYlrBrSJcjQK9N15YD207TQhHZO5Xy5yV05QwXtjFvlWgP2XrdJfg+hB7TM
	 HIz0OZKelBPEgJZ+bObecJ/ftltyxYi0aWZJOKK8Q4ThZxNckYzmo+C8EfhPPzWVMYA7V
	 1mp8COPRG9o0PysYQfg7MtZJiFNayp81gCS5rMua8vqyW9Ipr3pkC30jJK7xaqj4QKmx9
	 Ulfdd5XnT2eQJSrFJTb2brItjmiq3sN24ZRcwcCqlBO9YF7iNFxmelBPqIYmE+9kq1Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791903947;
	bh=SZ5ytif689T0emCf+V4OEnRCkPObabIdBp/Gl74aS2Q=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vNkyNJPxlFJSMXBIhcmwGq13f3e+eUMDLNhk4fVcXDMfk25eyFl3wo88RYpyDMazK
	 kV6NkQ5T6gY71uIIt0RVdM3kfwL4BhWh7amL7AeA5976V4Y0MPJ/Z1RtFIsmcCyX31
	 Ejle4aTJvLnnjAYX+ywVTAetLkhqSywaKsSB3VPoqtOGJu4KQ2KSw85/AQoAsEV3rZ
	 T3ETxH0DzxnTeVI2Q6VP6z8tbZte86KBxhMV/UrWpJOZnSJVUjqFOjq4zdsa90kooq
	 y3KJFfRlsDYA+q+DmFA8rQDyhadFEUqPWnOKUTuUPl9EcVAhvnmewtjc+LhcC48+Kg
	 N29H7KUySMLTg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5D8C34052A;
	Tue, 13 Oct 2026 15:05:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 32483788
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14EA36077F
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6GTyhENSHcsB for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 15:05:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 352CD60786
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:d406::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791903943;
 b=Ic2JUaJTl4AVOOdqGZEFXATav3R38go0xwdubO+KargZzBx7q/V/4Hq6E9HUclZM1ISE
 NO4C5QX4k/7mkUHg52VrrcFRbdu2dDm/4BcHxbw0k+syzGz2MmdP8hQc0ry5ve9mYO6Zp
 K67HM8YBJq2jZ4Te6PlbR5n50znQC/y26Itismgsi809rQjsA6XiDF7LUXlhLRYctTAuG
 xPQiUEcQ142tppGYZZY4T/ss70BLCHsePkI2tfjdkGdlbp7Z6QbrPsE5PrCMwa4a30pih
 Z5E7H7uph6XfO7MIsw84ib+UaYh8+/LzB+/qBTHxcVi+XP30WdDPodewUQQPBDV2IZQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791903943;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=SZ5ytif689T0emCf+V4OEnRCkPObabIdBp/Gl74aS2Q=;
 b=OCRRmIzVngaNIauz2mNFZhEGuwAsd1RSNQHk7xgof/um/AS9JIPBLXd2N0KujL9MnZCd
 6Ef9oCDg2gJzZ9IEtTT6JK01dQPWR2Zr9aze1o96XrLg/DBaB165AP/wLrvZ46zmjXeEu
 0p9ETOkzPGILzPnV9+TrkliR1k+DDqYJyVPHMnbj2UKBRkR1DfARRAsJeOeTctg7wXndP
 8wAgIa4I1JNgPWzrJaCOdeTg3DuBfkUfamLqNjkY1xWM0vvLMwy/pWT2HPJfM8kjM183g
 7x1DfI+xSYUhZGH+SJ1HncGQQa6vqDtD4EbXlgDR2QdarZl9x3i0Ftw2z0K//uoc68g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=outlook.com;
 dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=gnDcnsTu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:d406::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:d406::;
 helo=os0p286cu011.outbound.protection.outlook.com;
 envelope-from=yangshiji66@outlook.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=gnDcnsTu
Received: from OS0P286CU011.outbound.protection.outlook.com
 (mail-japanwestazolkn190100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:d406::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 352CD60786
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 15:05:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZCp5CdKlat+9/KG4nFYdAwuIAtnHy4iaWLoCaTPjym3OvX8iLnuVRvl5+JhJtAGaAA3VZRy44ts0cSJSnFqIEFJOap5ib7gU3NCHOOYW0u/7i4SuruhlvyBydjk/3R24PcwDVNGBt2WrA7M2aSAyWAt5PCZAySp2QqkXFZOPtU0PGv4zrSp/tfzNbXTdzCavJaJoXbd+je7rQ5A6e1qm882K6b/L8Ulz4iyZ6Z6v8wf9KjWkUrKHNSdMVjxV75/z8aB9ZfrTwHwJdNIubYa+0VjqDZehI5xE5cy50TquA3QYgCGyRBPrcWNPxW8ko60iJq1bTrs9qfoj/w+noLAjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SZ5ytif689T0emCf+V4OEnRCkPObabIdBp/Gl74aS2Q=;
 b=S0WRenwf+fIyqrXcVvimT+LLuqC024kF6W59wGLlQwyvKGZ6MPg46qQXaRnNXsPY0WvTnIwJb4wNjSfz83iBS1hNVxWU/Ro8A2TsMgv7meIT/YBQKoMA8g5V6cK+iyKIXt82ILRjnbYh5zf5pPOh1N+xOp8pch+Y4K54YEQ2bApaLpBKRS8Xd9FUKWZJauoUJvTBCj8Hs74KnU0In4Ka7QBprptfjaXJW7ENGqnmBRt2IIq0AJ/QEfiI9np+sUyqtaBikMP6y997hfg238yVRQmpiszxR0sIaHRaFJX3N1c8QxKi22gDrVXzivCDxrZ2/vWB+IbGdgHAaqNQTNnlWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SZ5ytif689T0emCf+V4OEnRCkPObabIdBp/Gl74aS2Q=;
 b=gnDcnsTuYZYKP1tVehzHaBmvu+fKq0VDCLHkn+ITl1kh/T/RTJ4tWrBe3SUt/Zv5R3RKwTf2NwprsQ3+Tw9Brk4S5ed7Ujtlla2Fvvb5GvA4XBh8wWSYAmgpXCX7nL94WwD78Iho7n5A/luJoeK9m3q6lnYdXYcRycYV1onKJm3buYRdnap4Zdr1cdMkO0L6QDaLA+/nt7XhGQhEvFc4FtbOXmXS6kdNmf5TUUVqHvdQvrgx3Jlii+o3c2KQt4w8mmpZECowOY5sFACjXPlI6k+BM3dQ/p73Ng4L0ZNbX1xoLin25pLPkd3iNEzjAQmMqxmc7PHdlvwivUJstkOMBQ==
Received: from OSCPR01MB15019.jpnprd01.prod.outlook.com
 (2603:1096:604:3ab::14) by TY5PR01MB18255.jpnprd01.prod.outlook.com
 (2603:1096:405:3e3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 15:05:39 +0000
Received: from OSCPR01MB15019.jpnprd01.prod.outlook.com
 ([fe80::d06:4844:6b2f:9fa2]) by OSCPR01MB15019.jpnprd01.prod.outlook.com
 ([fe80::d06:4844:6b2f:9fa2%4]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 15:05:38 +0000
From: Shiji Yang <yangshiji66@outlook.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
	Shiji Yang <yangshiji66@outlook.com>
Subject: [PATCH] cmd/meminfo: fix top lmb information
Date: Tue, 13 Oct 2026 23:04:41 +0800
Message-ID: <OSCPR01MB15019C116B8EF0F0F25638E80BC9E2@OSCPR01MB15019.jpnprd01.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0040.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::14) To OSCPR01MB15019.jpnprd01.prod.outlook.com
 (2603:1096:604:3ab::14)
X-Microsoft-Original-Message-ID: <20261013150442.54230-1-yangshiji66@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSCPR01MB15019:EE_|TY5PR01MB18255:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0fa3a8-ef35-45e7-dadb-08df293b708a
X-Microsoft-Antispam: BCL:0;
 ARA:14566002|15080799012|5072599009|24121999003|22091999003|23021999003|5062599005|260925184616899003|24021099003|8022599003|12121999013|25010399006|8060799015|19110799012|12091999003|3071699003|2607281247196008|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?d53ySlVbcZjm0xV3xGzERuhzUejtxglZ7AmyeB3W78I4KgYd0SPwB+XVtR1B?=
 =?us-ascii?Q?PvtMkZ8iCcn+6s2V4qG16A70l0cZpUfnZjNf2Vb7qf3ZIZAVlFZIEAHPj7M4?=
 =?us-ascii?Q?wEaQ/0hK7r7kEbJdXU+7kAXWdHmQMnImTw4icP2cIzrM1a2pavzketnfpNE1?=
 =?us-ascii?Q?W8vPOQdkCMcm10JE6HTWPrcBDgApJepWEnSuXshkd7uTemZfJuMU2xmhL71m?=
 =?us-ascii?Q?Fi9sYrJcCxdlfsEfzUWOQ2XO9qli3TGSxq5OYhdJJRI7Why60QA37HQ51w1/?=
 =?us-ascii?Q?xmHxcmKWE/e2n143U3aSUiVb2RKxK9t7mpgrZ0lGySx47pfmCgdQ9/XRiblD?=
 =?us-ascii?Q?wp5qrIrdekh9N4xgMj43plyJSlQMHrCo/RmHnX0plVlsjJAmlvgKIiRnokYi?=
 =?us-ascii?Q?LB3bUEJx9xNVBf5TYVPiqkmwMsTf+yEf8f+W7jkfeFFQ0QO/sENDSdK4xoIZ?=
 =?us-ascii?Q?Y3QhfrDLuEq36+CoLMAv3mIrks4ssy5Jl56xiOHf/4RFjEr/pMIzrxu68B3O?=
 =?us-ascii?Q?qWOKxTn/p/neS7NCXsRRUHw3m6fgLYo3qs4VZX19sPF/JHSaBK7tPK1rrrEf?=
 =?us-ascii?Q?17TR41nP8SpUQbSvYZc8v9JWA9QZ0zgjtsmDNIghDwrQtmINAkt/DMtGISqb?=
 =?us-ascii?Q?ZAI/9h9YfjSZ8NqiRuKxe3apWoxtqC5Zd7Jm0JObso1B87/j2fNdo/aATJmr?=
 =?us-ascii?Q?zj0u0UZohH2mXLO6InMVchAt4yijqT4IykxmboH1/YQg6bcTm0fQULEeikFc?=
 =?us-ascii?Q?+IkW3/eE0GjVdIg4BOsd30OsOXkboYmzUPQYiEN2Bol4UtTJvG+iB5JDEzDW?=
 =?us-ascii?Q?JsiMRsOhIuw1A3LBKv3PscgBoWfI6fWKBDwm8eAiCYnb5tGwGOlQuvODMUNW?=
 =?us-ascii?Q?YwoNyW5aBVSX6e5t4VFQBdAoosPPJddc8QZIeN6u59XqezFrrO4YGcDb8LpF?=
 =?us-ascii?Q?7XgQx5i2ATm+4kbENJG0Z5rPXJKVo0UDBEy0e7S9laj5AzdWrLZD3bu3GRLm?=
 =?us-ascii?Q?Vi8bPZ/lGlTSvoSYRa7bLUGaT30GYxS7HZiGd9PSiA4A/cNdB1xIikmRRoAv?=
 =?us-ascii?Q?rtouthjrKCp5tTIhUO1xgrVk5ZZbwPXvlaVh/SN9qb80M8+QvCfv8R0dZQEO?=
 =?us-ascii?Q?e3c4jVVEAo8/?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RK1ThWtEMtAAieyxWV9MUplcP5wlLmlOK7A2GcYKAfxTRE+RpI2TDatk27FV?=
 =?us-ascii?Q?pcjTylw9hd/u3P/VjSwN4I3w98VjsXVZ5scl0P2idVcM/tsxt3bmPBzWIhku?=
 =?us-ascii?Q?JlpO5UI6hbSVtMZEwhhuj3wRFwOnB0+ND4fkmwiYZZRbYS5Xip2SwhmC56lG?=
 =?us-ascii?Q?YoHw2V8FI2iDMPdKX9u5Smwy1SXcSt/x6wqaXJPREHYRBVMe8R/qH/YMSrN4?=
 =?us-ascii?Q?I9zAaZGuT9rronMxSbSx551+lwg6DU/LCVJ959xGNG4S1TWtllmstJkuJP7i?=
 =?us-ascii?Q?YDUUNBY3LkEDfcWoKesenyHp0nfi1nASGxQsQjxxfPV1+rVRidF2vXcf1670?=
 =?us-ascii?Q?X1pLEFunzZTvaYATNCt3AkAIg74wEebdS90D2NWNtBVoWcfFv3hjBZnGl9tP?=
 =?us-ascii?Q?Pnei/jl68hqLP2AXG3Ib9sY7YOemM+9QwHOS4aQ5hHcR8bEZJDTr3aVzTbkf?=
 =?us-ascii?Q?JZy6yTSSkq1x7q0kEkbgY4RAX0rQ8aCGKzLEInUIS2gzeQWNAT3fWrVjD59U?=
 =?us-ascii?Q?0huT3k7DPqShfdvxF+u6Ftk1ld9K5vjUAIz32orlsVrCZgWKLpuQ9OTI059B?=
 =?us-ascii?Q?fMeB9Ra6MnjCt88scsz1DlTjJe+ZDCh1nNhLUjbGv700z7Mhyz9uTAPBGgbx?=
 =?us-ascii?Q?zV9FlGQ7oHCFOKy0pZjAqWOw/eB4bqZr9rc4deLY7KhHdzsFlOZXnJOVbtcZ?=
 =?us-ascii?Q?NQKSCchrPM7NCCOpVO2ju0dTJ60u+SDpChb1Gw5Dc2WI17oJDN7Bc8oycYA6?=
 =?us-ascii?Q?wGrLXXV48iJZwzaoRxb+cwrkjSQts2lMUkS87RPciy/+YmZP/XchcztPu93u?=
 =?us-ascii?Q?RHGcGex7Ro1YMhOcg6o9LyyjpwAkubUE189Lo69jOJhZ0CUOAX760QD1Znvr?=
 =?us-ascii?Q?dN9BOswpWOZ4Xt+pQlW4GjexDXpUo9qso6KohneY2ntKsjR0crwFM3hGBCmF?=
 =?us-ascii?Q?cANHPe5GJ+cMswCixffSEZ3msniONBUrU5qgrtCLGut+MGqXRhDi7j5uErAp?=
 =?us-ascii?Q?18koAO32u6zanrDd+KbBSS0xAdyD/4QlryfxEsCzjt/0MhKerCt2zbL8EPYp?=
 =?us-ascii?Q?ZERFnfz4MJTS5qTycEGIRIQOWcor05T2sTDkp7J9LFTv5VUnPBF1fW1zNsGO?=
 =?us-ascii?Q?nkVtctqUNNVZWyvvqhFtYFuMTYUt5Z0Ogr5BxlQJExxOg8w6xdBOTRat3+QE?=
 =?us-ascii?Q?YPvXUXHeQUzYGR1gdbxfLji/R6QV5L4lzBEOrBLIMYflNM8BGVZAezlqpoaF?=
 =?us-ascii?Q?Yihy5bTQ3BIQo3/z2854t80tokC1xr/UnbnFVabwDIOKW0i9L574vtTFII55?=
 =?us-ascii?Q?aBBzh/3fiR1js2MLfnOGttrdo6ImG9cgC3RUu+8JUHxA3cCsZQVqHs+to1VW?=
 =?us-ascii?Q?zi4f3uQDzwrheaSz1eUBY4JcqlYR?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0fa3a8-ef35-45e7-dadb-08df293b708a
X-MS-Exchange-CrossTenant-AuthSource: OSCPR01MB15019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 15:05:38.6785 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY5PR01MB18255
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

Always assume that the top lmb is the u-boot region. Set *uptop to
0 to avoid printing meaningless Gap size, as it ends at the end of
memory, just like the `code` region.

Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
---

Before(one lmb):
Region                Base          Size           End           Gap
--------------------------------------------------------------------
code              83fa0000         5c858      83ffc858
malloc            83b9e000        402000      83fa0000             0
board_info        83b9dfd0            28      83b9dff8             8
global_data       83b9df10            c0      83b9dfd0             0
devicetree        83b9cd10          11fa      83b9df0a             6
stack             8339c000        800000      83b9c000           d10
lmb               8339c000        c64000      84000000      ff39c000  <-- wrong meaningless Gap size
free              80000000       339c000      8339c000             0

After(one lmb):
Region                Base          Size           End           Gap
--------------------------------------------------------------------
code              83fa0000         5c858      83ffc858
malloc            83b9e000        402000      83fa0000             0
board_info        83b9dfd0            28      83b9dff8             8
global_data       83b9df10            c0      83b9dfd0             0
devicetree        83b9cd10          11fa      83b9df0a             6
stack             8339c000        800000      83b9c000           d10
lmb               8339c000        c64000      84000000
free              80000000       339c000      8339c000             0


Before(two lmb):
Region                Base          Size           End           Gap
--------------------------------------------------------------------
code              83fa0000         5c858      83ffc858
malloc            83b9e000        402000      83fa0000             0
board_info        83b9dfd0            28      83b9dff8             8
global_data       83b9df10            c0      83b9dfd0             0
devicetree        83b9cd10          11fa      83b9df0a             6
stack             8339c000        800000      83b9c000           d10
lmb               8339c000             0      8339c000             0  <-- strange zero length lmb region
lmb               82000000       139c000      8339c000             0
free              80000000       2000000      82000000             0

After(two lmb):
Region                Base          Size           End           Gap
--------------------------------------------------------------------
code              83fa0000         5c858      83ffc858
malloc            83b9e000        402000      83fa0000             0
board_info        83b9dfd0            28      83b9dff8             8
global_data       83b9df10            c0      83b9dfd0             0
devicetree        83b9cd10          11fa      83b9df0a             6
stack             8339c000        800000      83b9c000           d10
lmb               8339c000        c64000      84000000
lmb               82000000       139c000      8339c000             0
free              80000000       2000000      82000000             0
 cmd/meminfo.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/cmd/meminfo.c b/cmd/meminfo.c
index 69a5b1b51a2..3063cb92d3d 100644
--- a/cmd/meminfo.c
+++ b/cmd/meminfo.c
@@ -40,15 +40,14 @@ static void show_lmb(const struct lmb *lmb, ulong *uptop)
 		const struct lmb_region *rgn = alist_get(&lmb->used_mem, i,
 							 struct lmb_region);
 
-		/*
-		 * Assume that the top lmb region is the U-Boot region, so just
-		 * take account of the memory not already reported
-		 */
-		if (lmb->used_mem.count - 1)
+		/* Assume that the top lmb region is the U-Boot region */
+		if (i == lmb->used_mem.count - 1) {
+			*uptop = 0;
+			print_region("lmb", rgn->base, rgn->size, uptop);
+		} else {
 			print_region("lmb", rgn->base, *uptop - rgn->base,
 				     uptop);
-		else
-			print_region("lmb", rgn->base, rgn->size, uptop);
+		}
 		*uptop = rgn->base;
 	}
 }
-- 
2.53.0


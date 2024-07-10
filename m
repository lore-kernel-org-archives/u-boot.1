Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C437C3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 22:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC6788871E;
	Thu, 11 Jul 2024 00:51:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=haivision.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=haivision.com header.i=@haivision.com header.b="LE22KN0m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C283388665; Wed, 10 Jul 2024 19:50:45 +0200 (CEST)
Received: from YQZPR01CU011.outbound.protection.outlook.com
 (mail-canadaeastazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c104::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBCED8872D
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 19:50:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=haivision.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sbasset@haivision.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=fail;
 b=Zdgo6HS/UIQLZziLs5OrNCx00g2gaEWAzXHBt/7sPqGgNttDGnwQDdJ2wVlPBXKx1npXCiRd+XMFVRaG00KIn2rIFY3KVgKDp+dgVNCdCYWX8vaqbGyLegQrZjaumWtiUXicmXi22eqa4a1XaZanvEC20DdaVDMT+JwuO/zHiZqBHjgfR+bXpnsSgjaSbPsqKxESdlkWC/WqLppvDQyrigWrmDpg/GN/VeQivPCz/IQVYx9h7RFOTXoOEewOFEX8/H+MAt25G+X47jaHe2gUSKth5j9EbuteyfSPDMnBMmxTj7+5jgy7484enzufL9sPLLnHQM7b4xbHTiK2N1IiUg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpQlSwqwuWNi40QPFtG1iQkFXIeJsQ/8nUiL+OyaiWI=;
 b=elB7ynoZOfGa3H+GPMx/3zN6tnYoeQXolDAjkbxFZunjTTf2dZ20s4LDbs3R391N3+c8YMQImY3aLWmGj0f2LA4hRhNHmkm8tAKI8UWWPoQZBKvAuGNewUphO6LHr/WW96LRFzO9KihSvrfJYc8n6p0wdukWNlk0cKbQ5QL+J864K0XcrJwS8ljSnuyti9HJbrEYYRaNNyFSW9Dx1F1cymb03G8lEDBMMyZzTsTNYLzjm0Or3l9Zc2CNFf/ZgkBRh26ufqbpSIK/tGlReoO6hPW+bmY+jqV5iyr9SelApLSq/m96lV2k8JRqZfSN4R06Q24N7jMmJItgXoOLgYJ7vA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 69.175.35.2) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=haivision.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=haivision.com;
 dkim=none (message not signed); arc=fail (47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haivision.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpQlSwqwuWNi40QPFtG1iQkFXIeJsQ/8nUiL+OyaiWI=;
 b=LE22KN0mooHJO3MlrUJIghOR0kLUE66zskbUIwMqWraOZ2PbcKIZC4wmDX7h8VKALEEznm90NuG76SWZ+EreaBlzMBQ4xq8Xfz4dTsCA/Fl4qnRaKcrGM4eqt5C4ggefDzZ5PgL2ZmByf3BnOVNuML33+slq5uiyaIkVpAcZa9c=
Received: from YT4PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ac::13)
 by YT2PR01MB8343.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:b2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 17:50:40 +0000
Received: from TO1PEPF00005345.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac:cafe::aa) by YT4PR01CA0148.outlook.office365.com
 (2603:10b6:b01:ac::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20 via Frontend
 Transport; Wed, 10 Jul 2024 17:50:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 69.175.35.2)
 smtp.mailfrom=haivision.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=haivision.com;
Received-SPF: Pass (protection.outlook.com: domain of haivision.com designates
 69.175.35.2 as permitted sender) receiver=protection.outlook.com; 
 client-ip=69.175.35.2; helo=chi2-new-relay.sendergen.com; pr=C
Received: from chi2-new-relay.sendergen.com (69.175.35.2) by
 TO1PEPF00005345.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7762.17
 via Frontend Transport; Wed, 10 Jul 2024 17:50:39 +0000
Received: from localhost (localhost [127.0.0.1])
 by chi2-new-relay.sendergen.com (Postfix) with ESMTP id 3D447C2E00
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 13:50:39 -0400 (EDT)
Received: from YT6PR01CU002.outbound.protection.outlook.com
 (mail-canadacentralazlp17012026.outbound.protection.outlook.com
 [40.93.18.26])
 by chi2-new-relay.sendergen.com (envelope-sender <sbasset@haivision.com>)
 (MIMEDefang) with ESMTP id 99831C2E17; Wed, 10 Jul 2024 13:50:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QB2BfZwkfy7aXNdnap2OTNWxlEORQdWtVwAdMSLhphEc1QRmbDBny1UmGiZQ46A75w23BmwnjfWR5/hiFF56PlN7L5e/v9sb10RpuX+vxcuvxWi/uJrJLIBv9Jc+zdhL2vdZPGKGgIYaLWrb5E5EHvf5v1iuh71dtff4sw/Yajmnj3+Nd5SI2ita5HC+6+Jo20t59OWzZQC/rt88dgtNMELaE5A5X8XwwrjwEnqDtBFyOkOKz8YwwLsKheLw4DmHnlKKaZb0pc+/0GBrgbyFv5Yo59T0hqxBXd1I+uGOB7gjf44+sfMCMtD+OfgZcL90WQj1ENjYLJr4RPk0qd7gOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJIQnPWunf1/8+ssaVtmlm9to8Oy2fmQutNbp9NIXKk=;
 b=oGRVgtB8mihL6iJXN2/tx83e5eS6TnEcwM56YHBqk8IvByNuvhIPaoiPNcjjh7BLBrtJ7vPEcz9ISO6tbXhlBoNw5udnM+nanuiwdqdXy12CFNncYu6PFb3C7Xrwly/Q1+T+BbI8bKE6i4CazQMvASHQzSv7xQwA6nO0xEsBJ16LAzCyD5/XM/XRnL6EeRGIEhLxwOhKdm8N1LDlXQxqzkzYcGyjgJtNUlLVYz7erEA12HFjr1H3F6Tt52MM6irKq8slGU9CPRZ40D+B/vuQpwdHZJloLb+2J/3SkMrBFBEPPRd+Kqu8YbNnH20q/3ZVd8l598l5Fg4bgkYHABFhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=haivision.com; dmarc=pass action=none
 header.from=haivision.com; dkim=pass header.d=haivision.com; arc=none
Received: from YQXPR01MB4358.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:11::23)
 by YQBPR0101MB5687.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:39::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21; Wed, 10 Jul
 2024 17:50:35 +0000
Received: from YQXPR01MB4358.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b37f:178a:8af7:6039]) by YQXPR01MB4358.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::b37f:178a:8af7:6039%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 17:50:35 +0000
From: =?iso-8859-1?Q?S=E9bastien_Basset?= <sbasset@haivision.com>
To: "aiden.park@intel.com" <aiden.park@intel.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: slimbootloader and u-boot payload mmc communication issue
Thread-Topic: slimbootloader and u-boot payload mmc communication issue
Thread-Index: AQHa0vFRHY60QH878ECsVfeHnE8S+g==
X-SG-Signature: true
Date: Wed, 10 Jul 2024 17:50:35 +0000
Message-ID: <YQXPR01MB43580B88592492F17110C4BFB0A42@YQXPR01MB4358.CANPRD01.PROD.OUTLOOK.COM>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=haivision.com;
x-ms-traffictypediagnostic: YQXPR01MB4358:EE_|YQBPR0101MB5687:EE_|TO1PEPF00005345:EE_|YT2PR01MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 7801d14c-7368-4211-085e-08dca108cfda
X-MS-Exchange-AtpMessageProperties: SA
x-sg-stamp: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?81xV+qLD1/7Sy2QM7LP+2Wgi2v6K/P+q+0yWxPyWr/4/sa82K1qwjeEZLk8S?=
 =?us-ascii?Q?gyfe5hsgRnWGhZ2tKbv5b47ZVWlbufGfd6KwbwtIjSh9FPdTD2tSo3hzMuMm?=
 =?us-ascii?Q?t7VFakCtXSFBDt1DzFoZwywlE1WcQA3TlVb3X4126mlV8KKz7z4wy7Ykbnwd?=
 =?us-ascii?Q?QyPI9HrR+iwnx63Vp2GxArBg6xTW1ixtIJamDsSZEYH5heVtXJ2BJDwdyKsj?=
 =?us-ascii?Q?jnaxxMZ6UImDRWMbXb0MhTc2VYc3jfgyy+5V8sMgBcXpnNs0vLvh08JsdIZL?=
 =?us-ascii?Q?p//VwxvrhW+yULp9Zfh29B+hetIMKwPOXYtkcrS2edFqDmhPbIBXwhGhyZrA?=
 =?us-ascii?Q?15XLsGquEvi27DZerAsCvFS6PkmWcAJUPOuKqxUTolJv7ZtGpnV4wEL9zRl4?=
 =?us-ascii?Q?/IsJ+LC9ZMgzC8pPWoQMNGAp4ryG5WVOv3hrkvC54aN96IJ8CoewSAsPEu5M?=
 =?us-ascii?Q?bxXWpAlxWESywAbYdM60QrXuiiMHkWp4OZlZaSs8sC2sw+S6RSU6YWcAy/Ad?=
 =?us-ascii?Q?HwWXiqfM3Vs4MDv/7KTmdvNRptgH5S6PdmlaJjsyvdoqH9tG8qd8qMKaywWX?=
 =?us-ascii?Q?wghdsPchV//EHMc/PvWV6TFCx2EzCtVC1rGvISrm53uA8fv/g5Lpd+hxyTp9?=
 =?us-ascii?Q?Ze3FBP7s6VLDF1jtePfTJWP+JcNIgUgZxSShKUz+gdJbOCvRaHbkF4w3Lpff?=
 =?us-ascii?Q?/jetG4kIoqbA5YS+lr6lVFJMNmUX5MOX4iVYCob9LyRWNjLgknMZo4kSxiBU?=
 =?us-ascii?Q?hvdMS7ffyQYoMWZvwjlDTz0rV0ZLvUxBam4LVygTPlvqjhus/c6vZ/Nn/h7D?=
 =?us-ascii?Q?EmIXHgFryO93P1ctEmBxb2mElH+ut2mqbMxjn54q4idoEC+gDTrOLQ5Ufgy/?=
 =?us-ascii?Q?GrtFU9qaEBgobxytv5d7HRVJzOkCVNWOn0WnsX60a+6WZsp130iIObu5XgXQ?=
 =?us-ascii?Q?Q2mtWmj6fsiD4ls3Mq4WdDjKPXxzDFYtW8Fdm50Y3ey6eDq6KrhsvRDaKDFF?=
 =?us-ascii?Q?it6DRvkCnn2IBWuYXC+AAF7ap2NAR5Tg6DOEv3OJywTbg3M3hQ0cBdLsi8ru?=
 =?us-ascii?Q?zFYvbLNqtdciA9MK3eHKwHi1vXL0IBkk8c0ym5cdCtNA4oJXQqUdBZRV3Ke8?=
 =?us-ascii?Q?Jabmo/3p3kCBRA3BFy59S1i7aARZDmUrERxr4XYTtLOeCXQLSREi87wKJfNO?=
 =?us-ascii?Q?a5ZwK25RiXiuYtlTd7yiKjLc25Y3kgUCu24hA/u6Ps3Ys1/dW9zXwM/0rw6S?=
 =?us-ascii?Q?CKjmp0WlIfu3RT/hF3WEZl1YdOBmCScHir+uWYWLue55Ra0FHoQnIXJfs9Ji?=
 =?us-ascii?Q?OltVnNbR9Btaz6xBencaO0/SYbNtiyCOKWe+62GoQZVLr24M6H5TR3I33GEY?=
 =?us-ascii?Q?IahYzsl0RtBzszSaDXcb66r+uWNO6CxsCgkn2G1a0c8pYZO6Tw=3D=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:YQXPR01MB4358.CANPRD01.PROD.OUTLOOK.COM;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(38070700018);
 DIR:OUT; SFP:1102; 
Content-Type: multipart/alternative;
 boundary="_000_YQXPR01MB43580B88592492F17110C4BFB0A42YQXPR01MB4358CANP_"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5687
X-Scanned-By: EmailPostmaster on 69.175.35.2
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: TO1PEPF00005345.CANPRD01.PROD.OUTLOOK.COM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0477187a-7924-4791-3f6b-08dca108cd17
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1143399012|36860700013|82310400026|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUIxdlY5NGhpWXh6TzJGaEhaNU5qelBOM1BRSHZoOWdJSndiTXBOWk4rcFZX?=
 =?utf-8?B?ZmRyRk14M1c5S09oem9VeHdCSjZUT1B6QUFFeGJSWFFUSmxOTzR5SGpCQ0Ni?=
 =?utf-8?B?Wk15NE9rUVk4cjB1TnVBeURnNGpJMXQrUit2MStSUnB0b0ZNelJZWEZjRlI3?=
 =?utf-8?B?YmhLNFlhNlN3b29zYWpyaDRnbzhpZTd5MTFCWlZWOGJUMWM5VTdZQkgrZ0lL?=
 =?utf-8?B?bi9JaUNyRnA5Y0VrVTJlZVFQU0tVbEpEV0IwT3FFWkNqRFczU0dCeTUzYjR3?=
 =?utf-8?B?UVAzcG54ZVFyazE0NG95NHNpeFpRbkZrUTczMGZkZWxiUmJlS211WFhkdmQx?=
 =?utf-8?B?U1JXMTVIYVBWdDFPUzBnL0l3OTZzWGR6N2Q0TmNuRVU3M21qdkNJZ0hma3Zl?=
 =?utf-8?B?d0dBSlRpSC92S0hrSmVSWk9vbXAyN2V1OFgzZEhLSXRxVlBpRWdmV1RhdHZY?=
 =?utf-8?B?a05LSWQvT2hDcUlTOXhxL2NtcXpwNkhaaEljMTdyWHFrY1hPZWhHS2p5blVJ?=
 =?utf-8?B?UjMvS0FnTndvMWtOclFBWXZRd3pXZGsrd1c1YjRwUy9iN1VZUHNWMDZ1Qmov?=
 =?utf-8?B?am1WSGo1TEZsNjBuWDN5WjhwcSszN1VNNVNGTzNaUm43b0ZsSDNxbmlucmlK?=
 =?utf-8?B?Z0ZkQVc3U28yU0Q2d2xCRFE1akw1S1drblBYMytpNmJiZUNGQW1vdmcxU1pZ?=
 =?utf-8?B?NFQ1RUoySk8rd2V2blBwQ1VJYTkzMkc5aVY1aXRYU0gwRE43WGszTE5FK1Rr?=
 =?utf-8?B?U0NMMXBMVFROMGIyNlV1QURBdngrbllnNlpCQnVyLzJtaDlXZkN0ZW10bnFV?=
 =?utf-8?B?R1hvOVVPT0VuWE1McnJMSm9qNm5CQy9BK0tJYlh4ZnExemU0SzhSZjdXSnlD?=
 =?utf-8?B?YzhkQUIxampseFFwdGpyS2V2VGp0eGdoeWdieGt0LzM5NXYvR2gyd0ttLzRk?=
 =?utf-8?B?RVlNWTdSaThEeFJrYmZsU3hGUzJveHMxa3Rpb09oZzV5ZVBlTURXYmYzZE82?=
 =?utf-8?B?Y0U3ell6WTA5Q1R2N29XRlpOR0pKamd1VDV1SG5Sa0JSU29mK0FVN1hvMjJp?=
 =?utf-8?B?SjdYVldSK0daeFVvR2k2QlVXb1NPcWRJek1tWjVjbEs3VE5aR3hjVlg0MjhE?=
 =?utf-8?B?aDVvZmVuYmFuNzdKYVAwZzVBM0V4bjMxdFlqVitVQVBUbS9samI4RVdCY21I?=
 =?utf-8?B?eFM1b0pRMnRYNkRzOGtBSnBtL3RCUis2WWNYU0oxTDdkQVo5ZFQxc3IvVzIx?=
 =?utf-8?B?eWFjTVhGZ0Zlbk1HZG1QMUtGcEVGN0J6VEJPTnk5NGh0SjhMWER6MHRoYjdC?=
 =?utf-8?B?Yjd5Z2NWOVdIRitsUWErZ1JQNEM0OW9JcnBSRjJ1ODVyclFrZHY0YlE1RVY2?=
 =?utf-8?B?R2R4dy9LbEl5V29PeTU1VVVHV2xPS2sxRWxCK1FGY2ZLUjgya24xdTdtOWFB?=
 =?utf-8?B?RTcvdi8wbUJPQ2NXaVFiUFI5ckVsMGpjc3Q2dTBKSVdqeHNTSXlvaUdXdWhG?=
 =?utf-8?B?dE5lQnlVZ1hrZnByZ2ROMC93K2pWV1ZHbWRsVzRNZTdRTGtyTHhOeW84eXVF?=
 =?utf-8?B?SklKcW5uNXdKaVFla1pjR1o2SlhDMThKMVpVYVdOaDF0eUZhUnZWN3NqdVVQ?=
 =?utf-8?B?aVVuMkovRzhCRTc5UHA3cFVNZjd0aWJrQ2t1TGY2YTFPU2VFcC9XUWE4Rnlo?=
 =?utf-8?B?UlZraVBUZEQ1RGYrVWY5ajJ2UzlUb3NNOTUrcTZKOHhkbHp4cW91My9TRWhs?=
 =?utf-8?B?UVVQTi9qV2MxNUNjYnVxdXFxUk02MHdsZFVzYlpRQ0tnenlyNk03cnJaa1A4?=
 =?utf-8?B?c3h5TjV0ek04Zk50WDhXWCtRdWtuRTUrb0FZakJFV1FQeHFoM3BTWmxSVUxo?=
 =?utf-8?B?RVQ1bFg3dWxmVmpPSVh1NWR3cHYxQTd4ZVdrdzJsQS84cWZuZjVidnVQM01p?=
 =?utf-8?Q?pKFh3vY0ZIQ=3D?=
X-Forefront-Antispam-Report: CIP:69.175.35.2; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:chi2-new-relay.sendergen.com;
 PTR:chi2-new-relay.sendergen.com; CAT:NONE;
 SFS:(13230040)(1143399012)(36860700013)(82310400026)(376014)(35042699022)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: haivision.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 17:50:39.7813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7801d14c-7368-4211-085e-08dca108cfda
X-MS-Exchange-CrossTenant-Id: a88156c4-f3f7-4104-8fad-43b93f27493d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a88156c4-f3f7-4104-8fad-43b93f27493d; Ip=[69.175.35.2];
 Helo=[chi2-new-relay.sendergen.com]
X-MS-Exchange-CrossTenant-AuthSource: TO1PEPF00005345.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB8343
X-Mailman-Approved-At: Thu, 11 Jul 2024 00:51:03 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

--_000_YQXPR01MB43580B88592492F17110C4BFB0A42YQXPR01MB4358CANP_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

I try with slimbootloader and u-boot payload to read on mmc, i have this is=
sue:

=3D> mmc info
sdhci_set_clock: Timeout to wait cmd & data inhibit
sdhci_set_clock: Timeout to wait cmd & data inhibit
sdhci_set_clock: Timeout to wait cmd & data inhibit
CMD_SEND:0
                ARG                      0x00000000
sdhci_send_command: MMC: 0 busy timeout.
                RET                      -70

My setup is CRB cherryboard with alderlake N with slimbootloader and u-boot=
. With config slimbootloader_defconfig:

CONFIG_X86=3Dy
CONFIG_ENV_SIZE=3D0x1000
CONFIG_DEFAULT_DEVICE_TREE=3D"slimbootloader"
CONFIG_VENDOR_INTEL=3Dy
CONFIG_TARGET_SLIMBOOTLOADER=3Dy
# CONFIG_USE_CAR is not set
CONFIG_BOOTSTAGE=3Dy
CONFIG_BOOTSTAGE_REPORT=3Dy
CONFIG_BOOTDELAY=3D3
CONFIG_AUTOBOOT_KEYED=3Dy
CONFIG_AUTOBOOT_STOP_STR=3D"s"
CONFIG_AUTOBOOT_KEYED_CTRLC=3Dy
CONFIG_USE_BOOTCOMMAND=3Dy
CONFIG_BOOTCOMMAND=3D"usb start ; if usb storage ; then if fatload usb 0:1 =
$loadaddr boot.scr; then source $loadaddr ; fi ; else if  mmc list; then if=
 fatload mmc 0:1 $loadaddr boot.scr ; then source $loadaddr ; fi ; fi ; fi"
CONFIG_SYS_CONSOLE_INFO_QUIET=3Dy
CONFIG_BOARD_EARLY_INIT_R=3Dy
CONFIG_LAST_STAGE_INIT=3Dy
CONFIG_HUSH_PARSER=3Dy
CONFIG_SYS_PBSIZE=3D532
# CONFIG_BOOTM_PLAN9 is not set
# CONFIG_BOOTM_RTEMS is not set
# CONFIG_BOOTM_VXWORKS is not set
CONFIG_CMD_MEMINFO=3Dy
CONFIG_CMD_LSBLK=3Dy
CONFIG_CMD_MMC=3Dy
CONFIG_CMD_BKOPS_ENABLE=3Dy
CONFIG_CMD_MMC_SWRITE=3Dy
CONFIG_CMD_USB=3Dy
CONFIG_CMD_DHCP=3Dy
CONFIG_BOOTP_BOOTFILESIZE=3Dy
CONFIG_CMD_PXE=3Dy
CONFIG_CMD_EXT2=3Dy
CONFIG_CMD_EXT4=3Dy
CONFIG_CMD_FAT=3Dy
CONFIG_CMD_SQUASHFS=3Dy
CONFIG_CMD_FS_GENERIC=3Dy
CONFIG_CMD_ZFS=3Dy
CONFIG_EFI_PARTITION=3Dy
CONFIG_ENV_OVERWRITE=3Dy
CONFIG_SYS_RELOC_GD_ENV_ADDR=3Dy
CONFIG_USE_BOOTFILE=3Dy
CONFIG_BOOTFILE=3D"bzImage"
CONFIG_TFTP_TSIZE=3Dy
CONFIG_BOOTP_SERVERIP=3Dy
CONFIG_USE_ROOTPATH=3Dy
CONFIG_REGMAP=3Dy
CONFIG_SYSCON=3Dy
# CONFIG_ACPIGEN is not set
CONFIG_LBA48=3Dy
CONFIG_SYS_64BIT_LBA=3Dy
CONFIG_SUPPORT_EMMC_BOOT=3Dy
CONFIG_MMC_IO_VOLTAGE=3Dy
CONFIG_MMC_UHS_SUPPORT=3Dy
CONFIG_MMC_HS400_ES_SUPPORT=3Dy
CONFIG_MMC_HS400_SUPPORT=3Dy
CONFIG_MMC_TRACE=3Dy
CONFIG_MMC_DW=3Dy
CONFIG_MMC_SDHCI_ADMA=3Dy
# CONFIG_PCI_PNP is not set
CONFIG_SYS_NS16550_PORT_MAPPED=3Dy
CONFIG_CONSOLE_SCROLL_LINES=3D5
# CONFIG_GZIP is not set

Have you an good idea?

Best regards,

S=C3=A9bastien
S=C3=A9bastien Basset
Senior Embedded Systems Developer

=E2=80=8A=

--_000_YQXPR01MB43580B88592492F17110C4BFB0A42YQXPR01MB4358CANP_
Content-Type: image/png; name="Haivision_Logo__200.png"
Content-Transfer-Encoding: base64
Content-Disposition: inline; filename="Haivision_Logo__200.png"

iVBORw0KGgoAAAANSUhEUgAAAMgAAAAZCAMAAABD5JEmAAAAUVBMVEVHcEwA
oOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAA
oOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoOAAoODsd1uYAAAAGnRSTlMA
wdn1JZv5B8jmGnkLQM5HbRLuibZVLqk2YXsOLDIAAAQFSURBVFjDnZhXgoUg
DEV5Kqhgefay/4WOJCgE0HGGL2vgQJIbYEVRNLxipk3Ncbsxr2XJPvjPct4U
zSjhuluO34rJfa20oSGH6/VzXCvXnip6kTa87aLmrs++Y5mKPlmmjjxv0/Tr
3FZc9872oxUXyFffKn/Qx9NEes+qz/FlmeHNoH8bK/tWJvqJ6a4WxzW3Y97g
5dH6z1TFzKEJdX62p8VWuSBi751Zqwr9zRuQrrCDioPMpe6uJegWvk4JyDfd
ryZ4dwNSF7vTxJIRkL2s/wEy6RktugeQnOv/lpygX3YoSN27Izy92geZyp22
ZiUge7L+GSQfYU6mB5DDbbWnrAS9nKMgC4yrbBL99CPjrlUbjvKIHAPeZATE
3r8GMVPohkDQcwWwA7mza+CCQPSIIetkzftkjpuT6FfNN+uqbh2QaqkIyDUJ
r0G4ibj6AcSsQeauTx0FWXvrp3V9Y27A+DmXa0af2CjIvnR/AplPb+VPICQq
AH3M4yAp6TBqLoN8NeQ2g31gCToKYgLsLchwhtvl89HohD8beaE7MUVAMng5
PGbzrztsxIe/Wg8EWR2QJpPYOhWAoCKkbghEQfC77UJ3shwBwdSxN2rO78zl
kA+mcDoHH0QoCiKSs5UBCM402EmyBxDsSk9j5ophmLVaIyPl0lZxc12yBwoM
Noy3YvqFFKQl3gHxmgvSgXcq6Q8uBEFRnDwxjAiiOgUxHePBDt43kgXDBTer
DCB8AzOHxL8DORUBfK7pHkCYEUUM+4HdgtgSZe9VHjE368levOoisf0jCFPg
YWX7CgTdlZ8xOj2BgN70KxXDCMhhbEhcJ//firAc01DSfl7ECGR9UATuiWII
gmHMxyBVByDHuLYRHexUG9ecfBMjXJe9SFK+yFpWEQDJqQtDEHRDIYgY3oAc
/7ejq04ka41hSRRkLQ7bB+tGzzriOBQ6ma0LIyCYGPbAL6Igx+eY56rQnAp0
hJTXFwiT40sQtXueWa4PIPh3OJt+sK+mu6y3AUzMgfwRZR8DZUd7WfEKRDZO
0oWubDaKgUgTw17JT0Fy1ZsiChQltiLo0WLoHmotY29O3oBsRBE2IooxEFzB
YBNGlX0QWNbKKbmJkVNT9wKrX7NVpNUv9wr+JxBvDXB91BMIFpj+ttgFMTlT
70dABk6/98y1/W/7EVsplL+CwNI7iqBsXXgDgj7hH1QQECWIZvH8nztEG3Nb
/wvIJYaMLPj2BKKTNK2SA9f6ukMcJXu1Z9/Hmd2BsK94BkHlqFmkLrwF0fBB
ovVOUdbl3LX3tpqPnqKciyeab8fuQWCV2f251taQV+aAqvjMtwdRIIruYQqL
nmtVLW96kSa8Zo/nWnJbkvT4btnkoz0t8eIHAjm2Huop/lUAAAAASUVORK5C
YII=

--_000_YQXPR01MB43580B88592492F17110C4BFB0A42YQXPR01MB4358CANP_--

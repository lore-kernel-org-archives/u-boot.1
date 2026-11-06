Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FDC606A31B
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 03:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=x7MfrOuU;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=rP9eu0U/
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D3FBC811D9;
	Fri,  6 Nov 2026 03:18:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtRWxfdkrWv9; Fri,  6 Nov 2026 03:18:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1C4A2811B9
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793935137;
	b=FBuJukqoJWVvqkTjFRTEJrJQMSClPknZqOwZtfd1LDOIKCTFlwXWDKz+YXkYN21gEsw/
	 HrKEb4x0k7CHD3W2kjcUmpn5fs+ECV0u5rxXOYcQwvplr7JRPyeqNXiYQr27MOPgdUmW1
	 mahmZPGN1UFCFsjgqcLdvxfHPOoNgntNdh7jVhGczg6o4Pa8RbWFoJGNir3qu+GOHK+PM
	 3SCw818FZBzOm0B5FkwTuaYFUmdPipBQ64lOMKJswhd3FFOJK2lWafwNPCiqMf6IujgTH
	 iFDsiYpFXdNsVUI9cuHQeqdZw5b2Fkepd8mLjDEqsap1OmS2xg3vO5PZaQ58FX+QGcw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793935137;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
	b=QSYX0Uzfo7cQSuqmTrbK4TwdvSyrieI2921sQ5alfg/OtePtrcXJ+0/yui9UkU2qBjvm
	 1JNEXknLQ6ZXcwgU0u1rgWwRNMvXBqmATJCksohdCM8F6vkckQdWXilHW7rlT3rIkEo06
	 QRHdcoFrzIQnXGOkoZzykomdbVp2hZMWkirhLaLFZL8QbSXKGh1sdvY2CocXgtbew+Egd
	 AkR4JbPEilAy5zoiz6ZOYQMVzSopbLh3q4IcsWQ82nqq6IpLx7cIpWQuiWunf6YXDxF5r
	 nGkED4zu6G9dO8mUEFAfViBOc1KcWsnXVt4R1hCtX9aNyXTrKQMHSdAzEXKpGtfeU1w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b="rP9eu0U/";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793935137;
	bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=x7MfrOuUUJGk1YHNn8JHDJsuvnpO5+HQMJCmIhy6nSEC+P1PUb1cIHdlcSJ9hWs7q
	 CkG9pLOlgjUCqBmie3cbnpjXeKdnq8iP5b8D1GZSO0T/dKfQXc5JY1bxlu31vsqVkQ
	 0MGQP/s1A9Gece1z5dPaIMiz1hI7rl/YxNsrlZsaULCnjGVWtNh1ZKIaEaX2e+3Xuh
	 4QYolLJUd+Otm6E2cSRfAl6RcoF0PHLWPPhH2DzbHa83+3NrGcuJV2jltRI/G1Mot9
	 EO2k0wc07tgjCOlq5xIXZFZZxiY7K6lZgonTB9I6jJr1TzpoTk9e9GA/prkoBBhztQ
	 Ao9tbIwo/Iqlg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C4A2811B9;
	Fri,  6 Nov 2026 03:18:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 09B672FE
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3AA5811C9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PZJhd1U6nKtV for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 03:18:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 148818118F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c105::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::7;
 helo=ch4pr04cu002.outbound.protection.outlook.com;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=rP9eu0U/
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 148818118F
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DICN7pwFIVEpkh36xeWzTIcwWaQrPCFfEr2ESq5NmB4=;
 b=rP9eu0U/WoLGhnCAN4wWb2zJkxPWCXxb7jxq8VhdmPg0zbzklVQTNwTvPvQE4JLxtth/Qw4cEMMe1CYkoHzJ2tDGthlx3AVVMXb1tfF5zHnB1pkK1ryxBB+p8dR7zCKwKncR7D7/dEf6VtXxWmiLKJ23LS8zPwtobcxcthvaBR6wlUklaGIRbGs8ppIIV+1fzVIbBghmV/jlW1qPp3v03L6q8MTaIskAhFTrEVVZB5GwBKPtRXUG7bXwSXOXkrsRUk2N/srSe3+atLPNIkLCD2xSPodb+MzReE7QhmPKo+0zG/PVByXZd9zdigMxZJw7qlLdEEKfJtROmeksDKai3A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA3PR03MB7301.namprd03.prod.outlook.com (2603:10b6:806:2f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 03:18:48 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 03:18:48 +0000
From: alif.zakuan.yuslaimi@altera.com
To: U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>, Tom Rini <trini@konsulko.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, Heiko Schocher <hs@nabladev.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Subject: [resend 1/2] i3c: dw: validate device index and clear slot on detach
Date: Fri,  6 Nov 2026 11:18:29 +0800
Message-ID: <20261106031830.13625-2-alif.zakuan.yuslaimi@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
References: <20261106031830.13625-1-alif.zakuan.yuslaimi@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To PH7PR03MB7063.namprd03.prod.outlook.com
 (2603:10b6:510:2a4::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB7063:EE_|SA3PR03MB7301:EE_
X-MS-Office365-Filtering-Correlation-Id: 843b15f1-e2f6-45ae-a2c1-08df3bb4ac35
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|261102123227099003|11063799006|56012099006|261009220027099003|261009223327099003|261021121427099003|261021123027099003|261009221727099003|261009221227099003|261026140227099003|261028144727099003|261022105027099003|261009223027099003|18002099003|22082099003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: N7X8pFzWW4lcuF4GPKU2z7Vva/AyuQEDsjT7skiJjT6qGgv1eV00ghI5yJDmmWsduPMJo+Pauy6IBTa4mpoNuGkNlwlayUMpYY/nB50qhyF4g1lgD4FFl81wlUbufUJd8nzqkWunbVYoHW1YUzUR9w78p5RqIxEOaNRvNqCeKS8Z07gBnV1bUcpvcEgq4MqlGugsY/u5rbgyuPUS5YoBh61qoAO2hjR7TRTF+N9a3jT8X4sgLog7GdgYr/5/JxoIjg4yA0kGuhJG/fPKbCvJlhgB4H8o8vqqMoFYwjR/jK2zcN+F/wg8JiUU7BiNfoOSK/ecV6ck+nBzo01hcGYvQ88LC+j2rdB0qonfp0OQk5pPFqcZNfyGi/R/YorqvefoLohTw/29ryl2fjAetDmWcvX11aQKzQsEXznnsYdr/Bl8v1jijZ2ncWEj7SFMWI+zmUc6F20t9V/FoJrMIoUJeoFgpZuLvfEV/GL3Z4eGG/nPqJGqfiInGoVGMYmA91542OQfttmaPMytBaOfVcBrDRNkrACQH52VJWlg23PF+4UgMOcWWxgQlTBrBZbqOG2wWl+D1uScPsZf3O5oXnB7LoJIId0v/6dPw1mKfl2iygRsOpiJHcRHNpcnCta9TEPGdNOLu9jVHHh9foLGJscmksA2ndGJEoXcVJmip78LcXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(261102123227099003)(11063799006)(56012099006)(261009220027099003)(261009223327099003)(261021121427099003)(261021123027099003)(261009221727099003)(261009221227099003)(261026140227099003)(261028144727099003)(261022105027099003)(261009223027099003)(18002099003)(22082099003)(55112099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ggHknBWDUrWtVBBrvynQhwlA1w2jIeJCpeNdmDqQcq6Fy4tbwYUE3s99tthc?=
 =?us-ascii?Q?nh5C5HmBnvnGdenSquYa8EujwG5pgsAyVGVLcID3RNPp7k4lPIuxacTENmAv?=
 =?us-ascii?Q?9a871tBbhUHbstSChBEF8jEzuhLf1rLAE9kOCngW1F9z5ghPfCFyRRU5maLy?=
 =?us-ascii?Q?XyxgZ94xr8mJK6m5P8tQZAQ6ZoeWaAaFZYaRx92wCykW/yTOEIEvYnxT2oTi?=
 =?us-ascii?Q?TNG6KeF7rK/3owQ5hSX6eNb+EbAJbZ+UZBZMagLT8csvb9H7iQa2+ZXASY3O?=
 =?us-ascii?Q?b61Dn6uFNnEibLGxNby3IqDsPTsTsN1lLl0fNRywOwOIFkGxJIu5PGZ4JDIY?=
 =?us-ascii?Q?K96X3YLFH4Vn/poilucII8NMzh/6BklhR2joUwhEPVng1+o7QPxCZZapLVBi?=
 =?us-ascii?Q?/T4DlO6b5o2FZAxT+c5T29ntZQ43Fu3owJNvQeE5EckUvu/Q3MiLOcQKsMXq?=
 =?us-ascii?Q?b0nnlH02nwJWB8SVxNLXF6tppyOs2jOLTgmKhTHpGJsURISnnfLVGcO/+/ki?=
 =?us-ascii?Q?y6Yx7LAa/gqo7DPfEnTvGCaMDVZ6dvUROUL+vyra0w+9EmXwiB07FGaOOSIM?=
 =?us-ascii?Q?3sMcjvmKxsRFv+mONpaFWbBcrlczROj/XUqF9zyMG7eKvzW1/fWMbrheLZPl?=
 =?us-ascii?Q?wKHMb8t+xgT3hFpKUc2kl5e+31/EvbvFFsFJhlRgB6wVLEhW73fVbT4W7iQN?=
 =?us-ascii?Q?OMGgC/R8ZojQBzRV5+tD7MIcvhtM23Su1eOTf/uXCYD9ip19h7ynSQkE21Yd?=
 =?us-ascii?Q?KG/Bx1ncBUSZ2TY0D4nyqIl27+5mfHsLCZUVagEAA1P4mPEnZn/vYtAGpaqb?=
 =?us-ascii?Q?1JhuQVcXqLhirt3IevrHGeuJZrfu+lU0cDLuG9u+mQHIYyIEwnPnhVc1bpJK?=
 =?us-ascii?Q?8chIY64loNxpwxk8BJNDaW9JZeq6oKJl6nly+gYRenGotjlShPfkJpmBCtbo?=
 =?us-ascii?Q?gzO7A19yWZnDos6YWotu1ltJPMVJMVuoT6FN7iKzZCcbOTsLhkf0FJ9T216B?=
 =?us-ascii?Q?vEWdy19pKycqgc5wUNe+P/uerAM4ZPDO7qON3pwSroNZrnT5Q9JK0BrWF3vo?=
 =?us-ascii?Q?hv33G3H1sJAaWqsgF7fLVTo9SWpzJtRWKOTxf9anbqaQL40h7rBTs4wE7/3f?=
 =?us-ascii?Q?I3Dj5EkdSRX9kVRhYiRZTMCgFA3YePxRgMBX8xEogxnunAilehKKfCXxfKlf?=
 =?us-ascii?Q?sV3Pg5WlgLZf2RyhYoYmRN7CpB5dOHxZk/EQDCzQLlHUUHR+a2c4iMFaCGzk?=
 =?us-ascii?Q?nGMqbfapvdCSvU/31nkMrpDWvxOYSJqSdRO3h/fHtAFsAVrayrjOYQ4/FIwK?=
 =?us-ascii?Q?NvdsxI8IdEz6mJnLrm7fBJ9uooZ4SEW026ZCO+3AJ0ziOKDdYo54EkQdt9B7?=
 =?us-ascii?Q?B7ayi2V8rCBXs6KRZqoC6W2rIijFNeIBNUzJLgSiK3zNW6bvSJWKgpikQIeX?=
 =?us-ascii?Q?bPySyGZMOooDlN778X76R6vwj08risS2OlEWophoxeHFp3O+WznOpTO/QX5Q?=
 =?us-ascii?Q?+nVnTlnMSjFLluD7kus0AMoEKbs5maxP8X8vd/VonX+5NBmMlctGrXcWrJHA?=
 =?us-ascii?Q?0WwofzhxMuVzqFGlWCDbTqijWLgSF/ITx1XTubgDirgOh3RKBXkVuqPKB6NI?=
 =?us-ascii?Q?cYj2iwpgnXO9QBOfrFxe/BKqpoNP0Nw9iKzenjjcwfMVMJEP9FP/qDQ6B2cq?=
 =?us-ascii?Q?FXkxuiSucxzkCTufxjfAVqUjpcS6Kr8tiUjrlTQHC8zdkmUXwPm/EPr8HtM7?=
 =?us-ascii?Q?v3UlDBwucZpR482m6J4Pw4gfhkBSg2g=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 843b15f1-e2f6-45ae-a2c1-08df3bb4ac35
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 03:18:48.1703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nNOeJXmyrvm7kydOdd/u3wWgBiJPE6q4Ew1rC3OJrzmmVQd1W3PCyWsLJeEgDQlm0a1Ro8Br++lDzxAY33ZTvy037L3FWImod1/ZRprX+k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7301
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>

dm_i3c_read/write indexed master->i3cdev[] without checking the device
number or a NULL slot, which can crash on a bad index. Reject out-of-
range and empty slots with -EINVAL.

On detach, clear the matching i3cdev[] entry so a later transfer cannot
reuse a stale descriptor pointer. Leave num_i3cdevs unchanged so the
existing dense listing path keeps its prior meaning.

Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
---
 drivers/i3c/master/dw-i3c-master.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
index 25933adf010..e5a437781fc 100644
--- a/drivers/i3c/master/dw-i3c-master.c
+++ b/drivers/i3c/master/dw-i3c-master.c
@@ -826,6 +826,7 @@ static void dw_i3c_master_detach_i3c_dev(struct i3c_dev_desc *dev)
 	       DEV_ADDR_TABLE_LOC(master->datstartaddr, data->index));
 
 	i3c_dev_set_master_data(dev, NULL);
+	master->i3cdev[data->index] = NULL;
 	master->addrs[data->index] = 0;
 	master->free_pos |= BIT(data->index);
 	kfree(data);
@@ -1014,9 +1015,14 @@ static int dw_i3c_master_priv_read(struct udevice *dev, u32 dev_number,
 				   u8 *buf, u32 buf_size)
 {
 	struct dw_i3c_master *master = dev_get_priv(dev);
-	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_dev_desc *i3cdev;
 	struct i3c_priv_xfer i3c_xfers;
 
+	if (dev_number >= ARRAY_SIZE(master->i3cdev) ||
+	    !master->i3cdev[dev_number])
+		return -EINVAL;
+
+	i3cdev = master->i3cdev[dev_number];
 	i3c_xfers.data.in = buf;
 	i3c_xfers.len = buf_size;
 	i3c_xfers.rnw = I3C_MSG_READ;
@@ -1028,9 +1034,14 @@ static int dw_i3c_master_priv_write(struct udevice *dev, u32 dev_number,
 				    u8 *buf, u32 buf_size)
 {
 	struct dw_i3c_master *master = dev_get_priv(dev);
-	struct i3c_dev_desc *i3cdev = master->i3cdev[dev_number];
+	struct i3c_dev_desc *i3cdev;
 	struct i3c_priv_xfer i3c_xfers;
 
+	if (dev_number >= ARRAY_SIZE(master->i3cdev) ||
+	    !master->i3cdev[dev_number])
+		return -EINVAL;
+
+	i3cdev = master->i3cdev[dev_number];
 	i3c_xfers.data.out = buf;
 	i3c_xfers.len = buf_size;
 	i3c_xfers.rnw = I3C_MSG_WRITE;
-- 
2.43.7


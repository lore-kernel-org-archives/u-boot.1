Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA1606A31B
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=s5pXjc+j;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zrJvE+WW
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11F5580DA7;
	Tue, 27 Oct 2026 14:47:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6rG8wNYsgfw3; Tue, 27 Oct 2026 14:47:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B03480DEB
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793112458;
	b=B3FnrxsDeMvN+CzXUgla5NPijyRlFn3e2gey+dj3Qj7AB5v1qm2uFApmBoDaOTb2W/st
	 fI2xd6/h7OU7ttue1OAxaznf7/YM+D5+a9MyhBYSasGE/qi94oRXAjIbOV5LcYfL5F14H
	 8E1Px16EBklxKFm7iXb62zU3fUsaRrppmYdvD9FQTbXwl+SRUJqusJMoZNBxLupYYB7EY
	 RGs92R84FsjbVs04W+D2uoodSDBRGk+U4wqleYU4hVUvlZFL7XyyGS6V8vaQb35Gy8135
	 F70KYYPf+p/x7u5mdK0p8tmwesXLMqnbNcDx0byzeI5b0eJJk6rJmVrXliSh8jYmLCQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793112458;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=omxnwZON2Fb/bajOTvsRBLRTdbrGEqHbfz3cH9ry9YY=;
	b=pMX+CCIUzPfGtgLXQmI7VL59NVu7NtJDjEf7n9xqczUlyW8W6q5jvbeOy/AAfhEJ/wVR
	 0olAQbUk3L6ylnP4+X0zj5XNGEafFjZLUpXPbIv8oQFWaIUQiosKMlyjGFQQiSxF+r7k+
	 BVcGz2pnFZhqv68acWKDdN58Jx9X/0o4pARy9UoYfEPutxGPzQwKJa8pepVRcE1BQKGCE
	 8MkshJ/o2atCW6up9JpfJzbw3fHEnzvN0lwBsS5ppjZRX8FWShhEbIaJs8PUu+i3R3+j4
	 yZJP65b4Kar9frGvZZcumw2O5HPkHK2CbjVRR4Q9nYqGC6yXcWtfHH9UzKGMpFDkE6A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793112458;
	bh=omxnwZON2Fb/bajOTvsRBLRTdbrGEqHbfz3cH9ry9YY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=s5pXjc+jr+Wp2ZhHuEwzg9IW+IydF9IypX6qL8z1VUBiej45zY1JFIxMQxvhRIbmm
	 LvXtwkm4LsXhicXm5NdwUd4TWujPWvAqR27w/GoBrrbgP92BVo/Y9M7AJxiV8RDdPb
	 9A49t4NoC49DWXcEVap+uWyppR+lBtlIQOrwBy2LjYTW0JAsuVT+LW4uYXDA8WjQfH
	 5nBV7sJop/5Xa6ORPlKNb5F+3XcgHP03ouUYEHMbXesPuUP/r8/uiZ+JdnKaOpH/5R
	 7gHvHDtiiMlZr5Lq/aDC22zrm/gmjmQebJ9cQ3tQtISMmLlLh4UTQaOpInEy/G+HUF
	 nFYyv7awAnG2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B03480DEB;
	Tue, 27 Oct 2026 14:47:38 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 13747279
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:47:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id EDE7240760
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:47:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YqS6bYakmt6w for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 14:47:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3E90440768
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=52.101.62.16
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793112456;
 b=VqWUyO44wdqNtKl3ETLx9e1SHACQun6KS3f+nW1nL50+hbcgdS1NLQdS19HeLuZU3AIT
 rYa0/JOtinvQYWwmAXUZ2xodpHEJ5/lr5NpGyLWg3KbXWE7D1aYPgf0gJYq7Ika1rVHKH
 eSmc28tVDO2t6I/LjozgUvs66GA2OvUb6vwhoz1O70MjQdz4klYZ6z9WF2RYq8timL1/h
 H0CL6eHjJYd9ohhRr8qS1UwW8lphUNz0/FSJDnwGF0eZct+3lU3/Lb621tfI99nG5nRoe
 75ifR2pWDzOgTeeGIU7/cvIkN3xPqSWXczV5F0saYe1yFEEMSCWsXdmBNBxHc3oAupQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793112456;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=omxnwZON2Fb/bajOTvsRBLRTdbrGEqHbfz3cH9ry9YY=;
 b=N/+emLZk0MK5ucKiKu7qM4+szHh0mlZHzD8Bf38qYRT5aSuXQNKMEuCB9CePPNK03I7r
 euG/AgQxV+B/KbqTfwu1zD595Q05FzZLevwsrPWdc1O0O324frlw0iIbYuT0WY7tVi8JW
 6Ejolry95xaSxV8kJfyIfPuZW8otRWlHQt0+N71TY0pqPSxSLOz25jRjvOUDPlZzEieb5
 EZbegxIi4b7yPJNlpF2y0tllXIw4NacO+LafUbSbUeH6bbp957sXT3B4F9s7E/eqautsA
 lY/hP7DNVrpuJDigcVxzaMsTp9f8CKV+XATSkt8tuSNa8cLF4uni/QS2+3azEFgqRiQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zrJvE+WW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.62.16
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=52.101.62.16;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zrJvE+WW
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011016.outbound.protection.outlook.com [52.101.62.16])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3E90440768
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 14:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LkufS3LUxKigAytVSJCzQZIOtT49HjVZDI25+lX+x3w9juZgwadU8FKaXQfojDYdh3A/1pU9aZbF9Gv1CDiVf7pIevef4lIjBjz1LwAajkKHoaHhaq/aGHpRm8xN2BeHzjTmNNac5gqsjtpf8slFdsoB/jzOVi6uMo/GkleZafAKGXj+fDD9d72facJw4n4XZGJxrn+zycRLErmJWWrmFDTfLVxxybySVmrPYYFNVm31lJwPpZ2x+w2zGuNiD1PJPNSwazv+TilPy/acwnuEYMZNmqF+BM7xbMkL1VJQKpwYcusXCMc3Qyhr7k4PkHmHggxf9ZkfWTmwOtqKujE8CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omxnwZON2Fb/bajOTvsRBLRTdbrGEqHbfz3cH9ry9YY=;
 b=F52DVQPxAyRyj66XdFFCLAWETSluBxufb0HN82R55pzaBEo2DVKMaanj8TnI1DXeQMWQWhGq3R2+K3CKWX8nL2TpBvxHn5cMW5+31ljf1VKHV+C4t01FGk7uxZCivaUsv4RQvKLWD20UXEg9sjM5MlCuGMvSfwEdZTpg88mrrC+yIm5EKQP7ZUGL69kDr5Iqh3TyQyN11HUszq2sNwhi1AFTsqLaTkm71RafHEZ8byB6uNljo4lEkxUTbI2FS5U45vJtFIoJaQLP6qYsRLV1Y56JggiSTe8bJ8N0SIQq8d1DR5E2n/OsdxdAQMBnnkFjYpNNm1gDRHNSDaMiaqlSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omxnwZON2Fb/bajOTvsRBLRTdbrGEqHbfz3cH9ry9YY=;
 b=zrJvE+WWdb69n4h5a04cbMng6YtoUSZF91exrU6w7U3ddPRIjdCPuWTwcbEj+9JxtI6crrPeCg6PG5iiw3N1UIJV5Dq33QgfrjpvTAdOsz9/4G/UFXU/8aBTKOuF0Pw4l9PEE/AEppK0O5EzjvX4YjBw4qtYJmtdqW8J9qHpkS8=
Received: from PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 by DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 14:42:26 +0000
Received: from PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211]) by PH0PR12MB7470.namprd12.prod.outlook.com
 ([fe80::c3e8:ee3e:aae:e211%4]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 14:42:24 +0000
From: "Begari, Padmarao" <Padmarao.Begari@amd.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "Simek, Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 1/4] mtd: Move struct mtd_concat definition to header file
Thread-Topic: [PATCH 1/4] mtd: Move struct mtd_concat definition to header file
Thread-Index: AQHdYi2NMdfKq0/QbkGV/fcVSM/7ErcMQQ+AgASs6uA=
Date: Tue, 27 Oct 2026 14:42:24 +0000
Message-ID: <PH0PR12MB74706E82576A024E75B67DADEC602@PH0PR12MB7470.namprd12.prod.outlook.com>
References: <20261022135740.3869144-1-padmarao.begari@amd.com>
 <20261022135740.3869144-2-padmarao.begari@amd.com>
 <CAFLszTiVXYwsCJQqyxEL2x8MS2NTJ8jqtUphUjB6+m4jYYqmDQ@mail.gmail.com>
In-Reply-To: <CAFLszTiVXYwsCJQqyxEL2x8MS2NTJ8jqtUphUjB6+m4jYYqmDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-27T06:05:28.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7470:EE_|DS7PR12MB9503:EE_
x-ms-office365-filtering-correlation-id: a9d46b9d-e1ba-4900-cd6d-08df3438840b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|261026140227099003|38070700021|4143699003|56012099006|11063799006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|10067099003|22082099003|18002099003|261026121527099003;
x-microsoft-antispam-message-info: 6jX9OURlfyLadXAVE/8RAlKMmeY7a1GxRi5CpGI8hThPQA9Op5lrBSUi+ShJRyOewF2YgcNy+8vAT+sd8teBCk/ygIAGZKtdvC5HeXBGM6hHygxw6vs5wQJX1FCtOJYWEXCS1fpfaNheY+2GT1Z3JTv20V7mu3MVRFY47axs0zaaBh7Jazu2pw6admujg/cx7xBSYN6ZP56GH7KPD3c1ChJYBRyp887SgtAatgt1x4KZjlEyciA/KS8u9HGecKagagEI/h+bbriHLyO/5Pi8UhaTzbOpAC8DRJMcL58ZZMSMTST5RN6dfK7ESGQcl7jpHPsuitsddXc9/KSaT+pz1ia0RBnWLtOgGnavjsCxYGMxtBOmJfaheKk3gD/uor5dJSqCDB2Tqgl7bss7vL4uPFf+WBHqQ0H3g5ZgSJ9QO/vYTmjwpp2uV8vpjPKoTR1LI1pAY/FE6zfyOWvo8e2GzRjsUTTsxlUx4FQHprVW4rKhn+xI3oy1rpBJM8w4XzzMDUvnuWUoN6tszUoUUdRrvzcDnRLTXGiKpV/QtyqZ5BraBNavc0/Hkmcyf/723cBLriT4qelbyKRytg5GZowtL3O1sQhlvLOIm/gtJQpBVQWlSa+B8woNihWaXIyFsWsSCF7R9dvinhEWeShmzSXRomk8pf64AvRCySOlZosuU63P9zd3BrmWJjDUnDGsmAFpPceCf0XbsYH4HOSqh3k/IBhKAQ6Y5TWnLaG/ORnyfnM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7470.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(261026140227099003)(38070700021)(4143699003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lQOHRbBTA9P/cq2aym7qI6R335FM82sAYXc1z2u/lCu8pnsTTsQqALftopum?=
 =?us-ascii?Q?JDs8nfBLPJHFWGiUi//81g6Tt5Jcp4WCrfSEj2MK4kJJpH0grccPakiBxNmb?=
 =?us-ascii?Q?Z08elflMrc6nkDp5YbD4Yn2SNahMOn4qVSBLCL2xbQ7AQ0lIKIRyMBeWBznz?=
 =?us-ascii?Q?qTXn23AZU8zKw9u/xVrluQ/ch56mxGzBVE9vrMH4h3dHM0DiuFkMetgxhGK1?=
 =?us-ascii?Q?LNKKdRJ1PN1eS+7fSBjd2MF6WFUST5gL75chb8kqadsVvOouhmSINov+YoIE?=
 =?us-ascii?Q?3QlssNcn7QMRQ+MCmYxJ+WRlJzMTdfWFIhSNDe8AG1RRuLy8ghZOG1DGOn2p?=
 =?us-ascii?Q?tOQMiYiOoQqEGjCdxheEig61Wa0aXRXAX4pqZ0S7z6gnG5PnvH1SCWGvw4TZ?=
 =?us-ascii?Q?BRcPSMW8iVijHQ5t5G/vLYPdBqUQscX755GfbmS4EP7KxQMvBuacl6/BQZsp?=
 =?us-ascii?Q?xl5B1NFZ3DkIUl88eLEDl55wya//djAOFKr78ARiaEpoHf78+/9shc1RN0J5?=
 =?us-ascii?Q?SuGjp9go1NJGVN6RdE62Ak7gkJFgfEt5CGUEg7DYKLQr1E5XBQXbRHeg/wJV?=
 =?us-ascii?Q?kma9w5lrEJIp/Lw1hya3Y+QCtho0bHmzqy4ovmJNAaQ3JKpqYbi/GWr5INMv?=
 =?us-ascii?Q?dt9Zyr5lVze9/NfhKivNS5N+Ma4OHvrOYrT91W/cIiax53FAJXw7BLcLCOMF?=
 =?us-ascii?Q?Pg0B/MHR1X0eg75+OleQKb/0PKi0N9ntA8Pw6e+7IP+sF7CznnBzpGcx7x4U?=
 =?us-ascii?Q?AgsFh4n3jIoAxDqa7ohIV6HBdS14zzJcD8DDIqjr64KRYL2fNPb5Cdt/bl4w?=
 =?us-ascii?Q?MxTcF6xWS2R1C1UVMWwp7sWKLn6B5K+xrUBajsKWdww77esKl5XqRhERYW3q?=
 =?us-ascii?Q?p/UzhJ3bYdwhB2YZkoYI2Xty5YThJMvCXKjJ0oAlCXdwUQTEl8XURk2vY/xh?=
 =?us-ascii?Q?iyGepmi+ZfY7EWglz+VwaYUFFLbLRSzWTAvibD/K9NJYj2+YT+k7r9VAnQ8p?=
 =?us-ascii?Q?+m3S9cQyo1W1Lv+XgVNT9z5vVz2l6CS+96Cnv7USx600WwRkDwW/YwNU1Q/1?=
 =?us-ascii?Q?NnwOPltNipj/fMP5FPL7GdTpMdGFzKN4NP6OslygUeLkrFf23VWcLEnOZ06F?=
 =?us-ascii?Q?zU3Fo+liBCQhcXA2MoBkjBEHpbyiq0TWDLLy2wbF6eHSqmcCmXqIcpoxyHyW?=
 =?us-ascii?Q?D4nTTczFnmA5+d19WF9kYl92qo/CbhU0mub0Y1sNCDhU8HME4QMu+aJjQrtV?=
 =?us-ascii?Q?kR6S0uD0aerdlck4EKzyOsdNFxYI6z8VdeZUl6C7UIuIor8yUVR51JdVT7Vp?=
 =?us-ascii?Q?VARShn5U9JaCcN89pZRpoQhAX3F18mpan82NIbWENLNUl41NLEej895ioVOh?=
 =?us-ascii?Q?47oAq8f57b9jjPqCOQFhXYIFVrkhTbSYrg7ehiR2aVRl1z12jwX1CN2DOM2I?=
 =?us-ascii?Q?jJmw3j2NvWnNkKl7GFrMBHlfHR72JmAjfJUnZDhFeX+X4fgJNZGGydXl25wj?=
 =?us-ascii?Q?G4nDvlQCMmfmPuvjOML2dVf2s+mC8N1BLjPJNIBlyn04NqXWuS2kV3QhPDhf?=
 =?us-ascii?Q?22NW/O/5YYDdQEHcq3EzlBPGRmGcRkpIidSYvNzzqQMCx5NH2IhECYnpiUAs?=
 =?us-ascii?Q?ZtivmTi/mCh8xsw52cYmyghlSYrQG9wiPcRpB+wK/BLhb1+CGBG1bWiuw/xf?=
 =?us-ascii?Q?yfvuWZ1KWS679/UcDHy8lYxq4WcWgvrdrOMs7BNv5nJHTia5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7470.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9d46b9d-e1ba-4900-cd6d-08df3438840b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 14:42:24.7843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bsi5RjDKJIAr+V6RBqKalZE9H7NHkgfgUBrPYbsP8xXbMY5GP9dlnq+HoU3ZzaSgLXiJlgHlivEpUvJ7i/DjfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9503
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

Hi Simon,

Thanks for the review.

> From: Simon Glass <sjg@chromium.org>
> Sent: Saturday, October 24, 2026 12:12 PM
> To: Begari, Padmarao <Padmarao.Begari@amd.com>
> Cc: u-boot@lists.u-boot-project.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 1/4] mtd: Move struct mtd_concat definition to header=
 file
>
> Hi Padmarao,
>
> On 2026-10-22T13:57:03, Padmarao Begari <padmarao.begari@amd.com> wrote:
> > mtd: Move struct mtd_concat definition to header file
> >
> > Move the struct mtd_concat definition from mtdconcat.c to
> > include/linux/mtd/concat.h, so that code outside the mtdconcat driver,
> > such as the upcoming virtual concat support, can access it.
> >
> > Co-developed-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
> > Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> >
> >  drivers/mtd/mtdconcat.c    | 15 +--------------
> >  include/linux/mtd/concat.h | 13 +++++++++++++
> >  2 files changed, 14 insertions(+), 14 deletions(-)
>
> > diff --git a/include/linux/mtd/concat.h b/include/linux/mtd/concat.h
> > @@ -9,6 +9,19 @@
> > +/*
> > + * Our storage structure:
> > + * Subdev points to an array of pointers to struct mtd_info objects
> > + * which is allocated along with this structure  */ struct mtd_concat
> > +{
> > +   struct mtd_info mtd;
> > +   int num_subdev;
> > +   struct mtd_info **subdev;
> > +};
>
> Now that this is in a public header, please can you make the comment a pr=
oper
> kernel-doc comment for the struct and its members? 'Our storage structure=
' only
> makes sense inside mtdconcat.c. Please also say that 'mtd' must stay the =
first
> member, since callers cast a struct mtd_info
> * straight to this struct.
>
> It would also be worth moving the CONCAT() macro from mtdconcat.c into th=
is
> header (or replacing it with a container_of() helper). The next patch ope=
n-codes
> '(struct mtd_concat *)item->mtd' in four places in mtd_virt_concat.c, so =
a shared
> helper would tidy that up. What do you think?

Agree with both points and they'll be in v2

Regards
Padmarao
>
> Regards,
> Simon

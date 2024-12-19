Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B18EE77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 16:53:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3969980196;
	Thu, 19 Dec 2024 17:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="iS2ShtWr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.b="iS2ShtWr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14111802EF; Thu, 19 Dec 2024 17:13:56 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 633EB80196
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 17:13:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Anton.Antonov@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=w30u24gAIGY2uQnwEvf9y3OuJ99OJjO+OAXWf5G7gOdA0lWKJGSc8Xl0M4wJeK+Qd+CGDOkKJHXJdgzY1v8A0+gP15NFT2Ng3C735ZkQjqYoQ8szXU/w3ZmKKesgVIOg3AEUsiQAmqo1ppHlODKRp4FWoXJPIIkPiuzXUB1EAFoaUqeeliYsAS2CEfAE8mcPoZQmwOtzR2mJROHkVF3NpZEcIfSrS3On+oo6sx9xfKKDA6x3k+Zudsde5mWejyEYdXCfCwfST+ucnM3nVa6+RJlyI3BaWxquJakTwtTqqjTaSksO8+oPFfcMVIzg+4I0Tq0F3fDI3At7T6FKQFuBDg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC2z0DhCMjBxg9otk3YAxV9e9skfIDvHmxVcZcqMCrw=;
 b=sPity4lSiqMQhpKO1g/7YVCJfIzHp4ROP/JndzsU+waTiOq9Dx4y12ftI/MQEL/y3TJfHca4M5aq/uc+pellMZ5eUFuG9dACCoD/PkBW4DSCrQ6YW/IKnc4VeHIUYUmP2fIly1D4FtBnLj+3b8VAJGtR8jFiAtkuvdLUKhZ/cGo8zn/D7+M0fszsQwvwHjWShau17tBN9Vw9/fdTIutjeSUJHOzf6tR5FcvzdclMa+8gdFcZxWnTNgIlOS2HMdUtlxpPHkNyDy9Tu+PcGgck+mZWWw0M3JDUXZZxFg+twwllayj+5Ye7qGnK9HZ0p+9DMMBDl+nrqgQ3VTOpNZ1f9A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC2z0DhCMjBxg9otk3YAxV9e9skfIDvHmxVcZcqMCrw=;
 b=iS2ShtWrXGvzFQKGrcFkm+LiUAw1L7o16mg/gRFJIT/Bb7k9euF1nr+uHLkmO8MiGsw1w8gBsPIFqJ2cMK0J39jMcHzAk+0RU+SYsb+hzJiE9xi9AoHEGmwRYKM9z34wHKlzJNp7B1vEKXUw4tvvE5edZGV+QQZFUWRzboJ36II=
Received: from DB7PR05CA0049.eurprd05.prod.outlook.com (2603:10a6:10:2e::26)
 by VI1PR08MB5519.eurprd08.prod.outlook.com (2603:10a6:803:133::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:13:48 +0000
Received: from DU6PEPF0000A7DE.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::9a) by DB7PR05CA0049.outlook.office365.com
 (2603:10a6:10:2e::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.23 via Frontend Transport; Thu,
 19 Dec 2024 16:13:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000A7DE.mail.protection.outlook.com (10.167.8.38) with
 Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via
 Frontend Transport; Thu, 19 Dec 2024 16:13:47 +0000
Received: ("Tessian outbound 8c86f99b1b13:v528");
 Thu, 19 Dec 2024 16:13:46 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: fde5577eac94d2f2
X-TessianGatewayMetadata: OftNvdvlDAgWjUeFAFz6ElJsvDVY/gl0rPVICeMMaIjpkHlYqyKVchZLunf1BwBdAN0+e5aOd3rjlQymPCkKVt6X0KdStHvbco1aNXdh+aDLPw+T/TCfQ+6lUGkNjrFAwpsjB45/LNTYx2PPgOOHWgoXxdmXT5gRlSiS/14n/tfFmGA0p2AEFflpmNUTIafDc9PKJhqyaIWR24TgDdGhKA==
X-CR-MTA-TID: 64aa7808
Received: from L42f64c643f78.2
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 D012EF8B-A6C1-4869-8494-7859E74478DC.1; 
 Thu, 19 Dec 2024 16:13:39 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L42f64c643f78.2 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 19 Dec 2024 16:13:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpRuT3vPZgsQOWt6snX+CVsv/9oqJ4tZCMaxUPPC9vH3wCDkf5pqJlDGrpSyaRADaEM4IUkeTzCiwFCaVdjN9uLiNj40GDrqwFCok2zlVeOO8x1jHZHQxmt5hcveDqu4RaodTmrK7LV7MGgXBYcwZgYuMbsjLsg/S6O792LdqOoKFW70sEF3NXa9COn4Fda3J1GIBwh8CGiJAvGkrg82SlcwKwW4Q5IwQsIa9cckQzREgyjf0kwHMCVtmtu+B4dbiBWxxvmzjido0Tm1wEH0d6+ih2ZEcLHxkeMEhBQdY7IulCDSC0/kESHBiVWcjncgipXxCBjEDhG8ZGA2q5w+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dC2z0DhCMjBxg9otk3YAxV9e9skfIDvHmxVcZcqMCrw=;
 b=FC9G+YSkVTwG58DrFs6b9gILJah8xSKYGquJGM1N65cUjThfrk+26FdHfQXH+JkdJTKoNAn85o7+ayxNt7ojtOIVWvX/sH/mrUhbRVdrwr2xfRuZaUHOAxo2wbqdJT+f+SZPnOkfXQ3BLZ4qENMYbfcEX+w6dJJa0DbbCNzfG9e2aBLhqsYqjHaftQU416O4siTLBG0AFpOwIBYXRoozqDwOep6r+NViRfE+mnrk8jJ9zj1YpomnFaafAy48B1RV0GfQRd5WJZ7WDECBqQNI0UhrVxIdzsvOE4bcMrDO7LTwG08fheA2+19f0yjLsg0lx6b6qyauRDYAWmvt+KGbyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dC2z0DhCMjBxg9otk3YAxV9e9skfIDvHmxVcZcqMCrw=;
 b=iS2ShtWrXGvzFQKGrcFkm+LiUAw1L7o16mg/gRFJIT/Bb7k9euF1nr+uHLkmO8MiGsw1w8gBsPIFqJ2cMK0J39jMcHzAk+0RU+SYsb+hzJiE9xi9AoHEGmwRYKM9z34wHKlzJNp7B1vEKXUw4tvvE5edZGV+QQZFUWRzboJ36II=
Received: from PAVPR08MB8919.eurprd08.prod.outlook.com (2603:10a6:102:324::21)
 by AS8PR08MB6694.eurprd08.prod.outlook.com (2603:10a6:20b:39e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 16:13:37 +0000
Received: from PAVPR08MB8919.eurprd08.prod.outlook.com
 ([fe80::e149:7529:21f1:314b]) by PAVPR08MB8919.eurprd08.prod.outlook.com
 ([fe80::e149:7529:21f1:314b%4]) with mapi id 15.20.8251.015; Thu, 19 Dec 2024
 16:13:37 +0000
From: Anton Antonov <Anton.Antonov@arm.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, Sughosh Ganu
 <sughosh.ganu@linaro.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>,
 =?iso-2022-jp?B?S29qaW1hLCBNYXNhaGlzYS8bJEI+LkVnGyhCIBskQjJtNVcbKEI=?=
 <kojima.masahisa@socionext.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 0/4] Add pmem node for preserving distro ISO's
Thread-Topic: [PATCH v2 0/4] Add pmem node for preserving distro ISO's
Thread-Index: AQHbUgbRAf/T/1WdmUuwQY4IhdW9+7LtuZy8
Date: Thu, 19 Dec 2024 16:13:37 +0000
Message-ID: <PAVPR08MB891945F41983B79DEEB12CB7FC062@PAVPR08MB8919.eurprd08.prod.outlook.com>
References: <20241203163605.1482152-1-sughosh.ganu@linaro.org>
 <CAC_iWjLZ=4RAJuMBbxEZuuM6c61x=grO0T82k=x5P8R0dpXBOw@mail.gmail.com>
In-Reply-To: <CAC_iWjLZ=4RAJuMBbxEZuuM6c61x=grO0T82k=x5P8R0dpXBOw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: PAVPR08MB8919:EE_|AS8PR08MB6694:EE_|DU6PEPF0000A7DE:EE_|VI1PR08MB5519:EE_
X-MS-Office365-Filtering-Correlation-Id: bf30e6e0-12af-4bab-a1df-08dd20481e1e
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|8096899003|38070700018; 
X-Microsoft-Antispam-Message-Info-Original: =?us-ascii?Q?GimGSHvizrt56hpERx+8ksZWbbGbKrhHDXO4SY9jh9oQlWrjJ4qOdzxbdnHj?=
 =?us-ascii?Q?ovlSu0OV88TtWm1PqfiX98Ab1A5zIYUzWDfmU+n2aUoSTTN0n+BNn9r5Ggco?=
 =?us-ascii?Q?b710Advdz2Q9E/NjRpvcxuNVoN5UveW47SoNLUWN0knAwm+21xTLZ9lPlOET?=
 =?us-ascii?Q?QyV0h7K6utJqo0anPep/ih6MoaeeOMRL/euKtVCd1pAHb3XbvL5pwxTpkGVL?=
 =?us-ascii?Q?CRJiljHCsdIk6SriMEN7K5XErwXLM5NokIEe7mAH9VOS4hjmG76YjqcAEXqY?=
 =?us-ascii?Q?Z0i758WSfo6nirfmBdxVIfecLYLzTqEWQ9+zIoMmqFDDtyIriOjBCMXJSfDT?=
 =?us-ascii?Q?YiUI9Se7apqAXH6a7S2HakyDGmAheB0iq4XCSpxh5jsW9CZq29C5nP/qAS4W?=
 =?us-ascii?Q?0zHgDfO58Gxm0zpNEyprDXO1mOScrQMY1ZhinC2PGUabF/yNtVe7OqOEZgNV?=
 =?us-ascii?Q?i67DMJz6idcJvv3mH5vzqFVy5j8ApeBPVddmsmk8sA4JxDLvdmGvPSBxchsa?=
 =?us-ascii?Q?E10I850Xb2xYDzuYiRD48JSsHft5lC0z8tMiDXWzPJ8ODX6A/YwjGN1LdOvV?=
 =?us-ascii?Q?0hzKoQmcnWayeKFvh72NjFJIod+Olovg7SvVSdLF8jNG6YwYtm5HD6uh50vk?=
 =?us-ascii?Q?ibfXhQiQwNiEyJfAW1hrrRDiF+9pUaYX9i+miuqr5fZmSpradnqUmCLznqPQ?=
 =?us-ascii?Q?dozhhDCwL/gHpujbhuGiaYghzYIHVY64X7O+hL2svqMCSLoicSEKXzvYYda4?=
 =?us-ascii?Q?DMbx0ICszHmS7hgVCUxbSXWs5eVev1D5reU0BkPJJxhGjD9iLS9VaVWHv/k5?=
 =?us-ascii?Q?gvZ29ym9jj1v0tVQAn7728uTVuUjH1dlaW8yqx+6GxhA6cfoZ6JQfVP1NhAw?=
 =?us-ascii?Q?V9U7eFW+1m8ZEI3U9Mszooty/Ku5Zw3NtYA3fkZVNHnOpLq4N7NWtnfv6UPN?=
 =?us-ascii?Q?fHIIaBlzD4uDcgWPTn9GLmeQ+3Mcc1oYL3qPje5B1IKhTYn15WgeIoWQKBNT?=
 =?us-ascii?Q?XDqIaGHhmYQGWmVBafPCVpMyXqgKrhs9L5NVuFMPFqXdcz/mRFKgKUcR4KSv?=
 =?us-ascii?Q?4lZNYv3kC06yt1bK+8xmQIxcmkvgtEuB8jGZwSwelBTU6dv0y0KM9HnP7EA6?=
 =?us-ascii?Q?vgdoo3sExyqbyFZdVFwadPpRW9nLLast0PY0JSXBZJbXM7h0OHmx/TJGyc1c?=
 =?us-ascii?Q?kS3b48QizEjitwWSyOOM0Pd5XHOHRbi1y9yyN4rb/5FUBFZdupQa1zVrVxmK?=
 =?us-ascii?Q?v7ky3tFbMq9iBqMn4CE8bDdYiGPnUH2yLfhXGkvrcwowElLKZ5idQP/FleOZ?=
 =?us-ascii?Q?VkeIcX+vU37e8Cq6Jfo/XjZDoeGnkwqtPpQUwrQPbKP6HO20CIFu14n5UwJA?=
 =?us-ascii?Q?3kCexu9tEG2umbvFO6dVh64MvQRJ?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:ja;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR08MB8919.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003)(38070700018);
 DIR:OUT; SFP:1101; 
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6694
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:102:324::21];
 domain=PAVPR08MB8919.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5a7122f1-e975-46f7-732a-08dd2048181e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|376014|82310400026|1800799024|36860700013|8096899003;
X-Microsoft-Antispam-Message-Info: =?iso-2022-jp?B?SkFvc0pNM2paTzRWdUFid3FwQ2Mwa2pkWTU1Qi9POWFVWDM3a1NtR2lK?=
 =?iso-2022-jp?B?YnE3RmYrQTFySlZwc0JVbkluU3c4OXlNeWRPS3c1N3I4d1lPR3prNVZy?=
 =?iso-2022-jp?B?UUZYWFJoeWQzZ3FPUnhqYU1BVmE2TmVTLzNMYmM1NHlSZ0YwUHg2cVdT?=
 =?iso-2022-jp?B?bDVZek5acGd2T2cyZ2xtamUweFJQUG1WM0Y1ekd1N1BIeThSYWFyOEJO?=
 =?iso-2022-jp?B?Qzh2K1hPejFXSlU3VG9WNWVacXg5MDFDKzFSSHlYcExOamhLczZTMmM1?=
 =?iso-2022-jp?B?N293d0FUNmVYYVZYQUJrc2N1bFBQRmJTNzdseWRPd3lHZzdXeHBzSDJL?=
 =?iso-2022-jp?B?Q0QrSytKUVhzL2lZaEJXdW1ER09nbjZoQUM4clEyRjR0VS90ZW54a3Ex?=
 =?iso-2022-jp?B?V0toVS9qNStjTGg4ZE54VWVmKzNxL0s2VGRuTUVManpPZUxNQ2h1eCtl?=
 =?iso-2022-jp?B?ekJQejQ5UGdTc2Jvdis3MVY3T2dDVDBUQ1h2dm43b0ZYTWxEQ0tabWU2?=
 =?iso-2022-jp?B?K01uSGhUcGdIcys2Sk5mSDNpM3l4bS91ODZZUE5JN2hKVU40TmllYjZu?=
 =?iso-2022-jp?B?cG5EdU9oVkRmRDU2ZFNNWXdRUmNQZU5ocmdGYlZNWVF3bXVLNmM2SzNQ?=
 =?iso-2022-jp?B?RzhQTTZocWd3b3RyRVJNUEhDZFVnNjFCTUwwOUZJZURKbmtBSG4rT25v?=
 =?iso-2022-jp?B?TGlpZGlYTFAyeGN5WkIvTHBMTVNJNkw1THRNc2JoVFQzQ0FPNEFNejg3?=
 =?iso-2022-jp?B?NWtySmxadDZHbVVyYWZXVDdFQjJwSkUyWlZORWZXekRXTkJ3OUx1UUdO?=
 =?iso-2022-jp?B?bnlmdkVOWVpiMjByaGZPbjUvQ2lDUmlsQ1RZTnBqR3RJM2tYanNZVXpB?=
 =?iso-2022-jp?B?VTh5L3RHWWJhZ2VrU09nWjUvZUViUzBSQUhaZHAwQXYwNDZpemxlU2ZG?=
 =?iso-2022-jp?B?QWlnSWJreDZhYVVDVjdBT2VRTzh0Z2ZuengydHBpNXBTNllnN1lRMWtu?=
 =?iso-2022-jp?B?ZFN3SFNhSDVDcDNZRy92OWMvcDlocDNmcktHanFndUk4UWtybjh4VGFw?=
 =?iso-2022-jp?B?Y2pydnpMdldyTmFXclBsWWJMVFU5dy9BNXBDWnMxSENJQk9QVis3MXBm?=
 =?iso-2022-jp?B?MFh5SWVHZXdTazEydVVHTTFhRXBhTm9CZVJXYktFSzdiZmpnVE5SWXpu?=
 =?iso-2022-jp?B?S0VTUTZ5UWxqN25mRFlWS3Z0ekplWi90TE5FbVFRL0o0Uy9lbmtyUTRh?=
 =?iso-2022-jp?B?Sitic1lVb0w1c1JOMzVIY1JxeVdGSWI2bGFzdTJXUi9kbldsM2pQUzBT?=
 =?iso-2022-jp?B?NzN0alBFVlMyaU1ld3BWQXpBbGNjRU9Qb2dxaE1tWTA0UnR5RHNYMHY3?=
 =?iso-2022-jp?B?K0NObWM1TGJWYTlwcXB3Y05uZDlieE4zK1FPKzhYdTNuMEpPWXVsRHF3?=
 =?iso-2022-jp?B?UHJ6OUNmc0tpUzR5TDMwaS95MDNuK0hkKzkrSUY2UTRyWWYzM1dScHcx?=
 =?iso-2022-jp?B?SlQ0ZUFUYWtCbGdRcDVVdUd6ZVBDaHE0WVpQUkh0UWVBZkpOTXBndkRn?=
 =?iso-2022-jp?B?TU9QNG9WUE1IK2d4dnFoVXlxenBONmRHV0tuMEV1NWp1RGdnS242ZnFQ?=
 =?iso-2022-jp?B?L3hrTUdlT3dJL3VkeFAwenhrS3F2MUZwQWRBelAyek85WEpNSXVidTY0?=
 =?iso-2022-jp?B?V0ZLRHM1OFEyVFU3aFJ5WjZ5ekF3UFM0amo3SlgweUNJVVFOb1ZIK01z?=
 =?iso-2022-jp?B?cjRodENpV1JDOGhKOHVWanpoNE83VmhzTVJwNzI5bkIzakZaM0hGTENI?=
 =?iso-2022-jp?B?OHJ4UDg4SUY0THdZdGEvVXloVlg3WjllY003RE5uZHorWHh5SU5KaUpa?=
 =?iso-2022-jp?B?UUV0YmVpcFBSai9qYzRxN2dlSkxzZzdmM1FCMU4vd1VrV0N1NzlpY1lT?=
 =?iso-2022-jp?B?UEdsblNPajQ4SEpnL1hUK0lNUW1DQ3lreURsd0IxVEtpZkRLTVRncWIx?=
 =?iso-2022-jp?B?ZWIxQW0vN000LzNvd09zYllYRmRLRWd2SkhZbXhrdW1pWnV1OE9ORHdU?=
 =?iso-2022-jp?B?UTI1R3NvNDR2R0dPcEsvZ000WFdBb1RqUHNpQUhTamRkTnJ2MTlIRlAw?=
 =?iso-2022-jp?B?cmo=?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(376014)(82310400026)(1800799024)(36860700013)(8096899003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 16:13:47.0755 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf30e6e0-12af-4bab-a1df-08dd20481e1e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7DE.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5519
X-Mailman-Approved-At: Thu, 19 Dec 2024 17:53:09 +0100
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
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

Hi all,

   I=1B$B!G=1B(Bve tested the PMEM patches with quite a few Linux distros. =
These are the results:

Installation images:

  1.  These images include all required drivers and can be used for success=
ful installations:
     *   RHEL 9.4
     *   Ubuntu 22.04 and Ubuntu 24.04
     *   OpenSUSE Tumbleweed
     *   Rocky 9.4
     *   RHEL for Edge (Full installer)
  2.  These images are missing some kernel drivers:
     *   Fedora 40, Fedora 41 - nd_pmem driver is missing (CONFIG_BLK_DEV_P=
MEM)
     *   Fedora 40 IOT, Fedora 41 IOT - nvdimm/nd_pmem/of_pmem drivers are =
missing
     *   Debian 12.6.0, Debian 12.7.0 - nvdimm/nd_pmem/of_pmem drivers are =
missing. debian installer requires a small fix to mount /dev/pmem
     *   RHEL for Edge with FIDO Device onboarding - of_pmem driver is miss=
ing (CONFIG_OF_PMEM)

Live images:

  1.  Rocky-9-Workstation-aarch64-latest.iso and Rocky-9-Workstation-Lite-a=
arch64-latest.iso include all the required drivers and boot successfully.
  2.  Yocto genericarm64 image is missing nvdimm/nd_pmem/of_pmem drivers, b=
ut with a manually applied kernel config can be booted successfully.


Cheers,
Anton

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Just a ping in case we can move this forward.

Heinrich we've tested with various distros including the generic arm64
poky image and this works fine. The poky image[0] is missing OF_MEM
support, but someone is working to add it already. With a modified
kernel this boots fine including the missing modules this boots to the
login screen [1]

[0] https://www.yoctoproject.org/development/releases/
[1] https://paste.debian.net/1340517/

Thanks
/Ilias

On Tue, 3 Dec 2024 at 18:36, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
>
> When installing a distro via EFI HTTP boot some OS installers expect
> the .iso image to be preserved and treat it as a "CDROM" to install
> packages.
>
> This is problematic in EFI, since U-Boot mounts the image, starts the
> installer, and eventually calls ExitBootServices. At that point the
> image U-Boot mounted disappears. Some distros don't care and download
> the missing packages from a web archive, while others halt the
> installation complaining they can't find certain packages.
>
> If the firmware uses ACPI, this is supported by using NFIT which
> provides NVDIMM ramdisks to the OS and preserves the image.
> We don't have anything in place for Device Trees though. Since DT
> supports persistent memory nodes (pmem) use those and preserve the
> .iso for installers.
>
> The issue can be reproduced by attempting an EFI HTTP boot with Ubuntu
> live server ISO, or a Rocky Linux ISO. The installation would fail
> with the failure to locate certain packages.
>
>
> Changes since V1:
> * s/ommit/remove in the commit message
> * s/rfom/from in the commit message
> * Add a period at the end of the sentence in the commit message
> * Use log_err() to print the error message in image_setup_libfdt()
> * Remove "ERROR:" from the error print in image_setup_libfdt()
>
>
> Ilias Apalodimas (2):
>   efi_loader: add a function to remove memory from the EFI map
>   efi_loader: preserve installer images in pmem
>
> Masahisa Kojima (1):
>   fdt: add support for adding pmem nodes
>
> Sughosh Ganu (1):
>   efi: add helper functions to insert pmem node for DT fixup
>
>  boot/fdt_support.c           | 41 +++++++++++++++++++++++++++--
>  boot/image-fdt.c             |  9 +++++++
>  include/efi_loader.h         | 28 +++++++++++++++++---
>  include/fdt_support.h        | 13 +++++++++
>  lib/efi_loader/efi_bootmgr.c | 43 ++++++++++++++++++++++++++----
>  lib/efi_loader/efi_helper.c  | 12 +++++++++
>  lib/efi_loader/efi_memory.c  | 51 +++++++++++++++++++++++++++---------
>  lib/lmb.c                    |  4 +--
>  8 files changed, 175 insertions(+), 26 deletions(-)
>
> --
> 2.34.1
>
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

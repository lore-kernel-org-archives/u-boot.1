Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BBDCA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:52:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF0883093;
	Tue, 19 Aug 2025 11:52:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="NUYslpL+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 325B382BF6; Tue, 19 Aug 2025 10:35:30 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09AC780FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:35:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6cwijKKltKQnA3eNzo7QYn9IIfUU0tW4IQZ62vqJjNInMxNmSpfMSn2LvT6cR4Oq9dscPR48VDl7ZsoDtsIAduLEP6GewQFD9pfA0IwSpb6lhFvHU+8ipEcDVBEIL4HF5qzqKLULfGrJ2tJ9m24d48iD35wJsM/wWXx7vX2O6lK+aL2PgpfRJCODGdv9xR2wQzuEFN9AMzPklX/+WukoC33VfLYZ1mQz2KK/Ajns7n0LWZYg3PwheVnmcWJjPEGY7Lk9+L5vk1bCnt6BE4RHimnb2MjoYSHPl7Z0xo93METMkc4cSwVqdVa0DlHjycXVcZLzAGoD9nBsmX2CsZy9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+VrV6IBPuUFMhJk+p4NbzXjdM+xoZNYFyTDVTcR5O54=;
 b=N1rSXRc9HoPoCCHX6C17tfbTp65gj53FcZD+5CkvtkF7mNokPSKqNKF5aLzJZfH/Tt+dCiVJQDIHLGTx7nfUCCKd4nJgs4h0gt35jcEw0uexp1NYtw1pCyy+O07eLsnx6OtFyxXWhjPpoZEJFKUsTHIfF8KmJ8jbPXlVWoNkC9DfYYf+Xo0jwqBLsiWi3N80lWJ62dT3k8nXVbBojEhdHuEdLkd5BzcINpHv6Ti9txkp5LT+OFunzSYCiitKcL//G0nqzXINrNkqjYmf4dTyZAU9gAjUcc3iqj/Ns7boRx+C2P2yOo0MrTBCDNNFsPFRSk+ozaKkcTOmd2HDi1T6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VrV6IBPuUFMhJk+p4NbzXjdM+xoZNYFyTDVTcR5O54=;
 b=NUYslpL+aCPGlJWizAgmhoaJCqZ9m/zWI75UAHHXSlfWvCBqo+lbnEorSrqfnwq/jzNZ2xDHGq7PTbSbiJHcyUhr+GlHo5BDxh7oNQH7J0QlJ5qnYhCka98m343keS9rXugh0yWziER+3PFgJjEERM+BMawQ6phVHoNY0NjV+GBr5ZXgkR42ndSJ7pPoJQn43Lv7wnlLU+fcvoVJvzpkQXOj4sQgsExiMuEFAcRV6hFfNVqWjDKMX15bdyt0A1vr4Leq4A4meRVLRKPN3tjpARJG64xf4eqyebQDZDMGFfTqQcMJ8QJAENFdRc0X/YzNQjnYzJGDVVy88+6QGqXI7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA3PR03MB7442.namprd03.prod.outlook.com (2603:10b6:806:39f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 08:35:24 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 08:35:24 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v3] mtd: nand: cadence: Fix device assignment to avoid warm
 reset issue
Date: Tue, 19 Aug 2025 16:35:09 +0800
Message-Id: <20250819083509.23108-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::17) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA3PR03MB7442:EE_
X-MS-Office365-Filtering-Correlation-Id: daadd57f-0920-4821-772e-08dddefb578b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K29XOHZScVpYeFh4bStsR2NWT3huV2theEQyZGhnc1pvNzRqOEl5a1h6anJE?=
 =?utf-8?B?Mm11MGZieGhTTUxScjF3a1FabEZjTDE2dmIyTDdUdzZmNUg3dzBUOEJhZnRx?=
 =?utf-8?B?QW9iRFZmSUJsTnZJeUhDdHA1L25KVTd5dXRZZTZjRFhHdXBSYlNnTUYyTzZY?=
 =?utf-8?B?SW1YSFlzcEpaSUZMaW1ld3pOZ0xsaXU2QUFYdGRLYzhYeC94V2JxaG5TOWpG?=
 =?utf-8?B?eDIrTWJxVE5hVUduQkpveG5neVArSWNrQmdYeWtNMkZIamFob3RrL1E3dWhI?=
 =?utf-8?B?RnkxdUxrdUM1UERRZ0VsdHhtYmcya2Q1eFhhKzRWT0FyRXlBbXhteDBWM1ZK?=
 =?utf-8?B?MkVaWEI4REs3TE91Wkp6KzBQcngreW9zSE1VeVhqakxlY0wwek9aZXdwUGJ0?=
 =?utf-8?B?NGlvNS9sMDhXdEVQNlRPSGs1Yi9Ud0ZLMkZod3NadHpWN3dpdmkzTXMrUzQy?=
 =?utf-8?B?UVBsVmdJSU5ySzZIOUp3Wm9Jb1dYd0xhRWF5dGE3NDBSTGxWb3haK2N1SVl2?=
 =?utf-8?B?ZHUrb1RDSWR6VkJYUnZPN0ZBUkZ2Y2hhVmF2aGdGejNMc3RiSENFTjlCSVd6?=
 =?utf-8?B?U3JqS0NOc3k4eTRINFFmamdwcTFZZmtYcURPNFdSWmQzaXhtVUY5aGNMb3J6?=
 =?utf-8?B?em1SKzVPckttdXJyRGtDL1N4c244TVRBZEFYbHNLSnk3QXRkWE5IbjF6RHBn?=
 =?utf-8?B?Nm5ZM1VLdWlCdWtzUkVZYUUvOFZLSnJZVTZXZHZxYjZjSDVuVER6emk1VjZF?=
 =?utf-8?B?M3JZQm1uTFR1MXJLc1cycDhZTHdwbWZhcTB1dVlTZFAxV2UzNkVKVlN2Mi8y?=
 =?utf-8?B?WmpTOEl2RktrK0d6NlppQnlhbWtYU2dRMzJ3bWJjVEpXVkhQbHg5M2ovZ2pK?=
 =?utf-8?B?SktZV3hhaW83L0ljU1c3eVVQUi91WUUvb2t2V3h1cWhpZkZnU2J0Z2hTeXhP?=
 =?utf-8?B?eldINExvM3dwNnR3d29ZRmRGaC85a25rNGFpNzlwMThpNlFMVWlkb2s4Q1Bn?=
 =?utf-8?B?bk9uR216K0t4YkZtTFl4Qk8wdFlCbXRwT3JxU09heUJzTVJGSXVzRzhQYm1Q?=
 =?utf-8?B?aEFCUlFqaGRkc2lPODlVWjg0RVJEckhGbllESFlKMU5nWlR1SWJiUldXeUNr?=
 =?utf-8?B?Y0tjNkNrV2x5WUg5dGM1M0ZVdVdUNWJyVkhRWDJTS0dBWm1ydm1YME1PNWFo?=
 =?utf-8?B?YWZjUWVFanVMVjc5ZUFUQnNuZk5rdU1nNko1cVpxTWFLWHlicXE4ZE9NdlNK?=
 =?utf-8?B?amw3TVB6MGduZ3JDd29ZL0ZtQUpBVlY4SE1qdjBDVlBXWS9iS21KZkRhamdO?=
 =?utf-8?B?SjFYMFJ5cWNwUlQ4b0M0Z013djJYd3hGM0kwUzh6dlY0MVY5bnBFZHJtRzFH?=
 =?utf-8?B?bEdWMXVGQTFVcHpVUTFQZVBVWTZoZmUyQ0ZLOTJzdGlrVXFyZ3g4eVpZcC9n?=
 =?utf-8?B?R0c2a2wybEhTSjBJdHBJR3BXSVRKMzZtUTBTMDB6NEtHUWdZR0lTZkpkSHVS?=
 =?utf-8?B?M1Y3NWl4UUo0QmZRRWtBTTltK3k1azdsSm5QeHZQR3B5VDR2bWYrUXJrYXRE?=
 =?utf-8?B?OUJ5cjdpUUduM0tiSTZzTUpMZ3BKSlFQaEc5REpWU0xhT0prL0p0T3RBczVY?=
 =?utf-8?B?b08wTmdUMW51YzNFSkI4NzFlc1AveVB6QXl2NmRqL2VnYkM3aW1lYytxMDNs?=
 =?utf-8?B?T2FteWU3TzJPMEVibWE0SUwyTE4rcEIxNVEvYm9ybTROZEtMTnZ5cWJLNzcv?=
 =?utf-8?B?dFdPME43TGpLNExyZUVFelluWFhydUdoZVpDMEdHb0Z5UlQwcHRzQ2toMDRL?=
 =?utf-8?B?M2R1TDBlbjF0SU8xSTc3bytzUkhRR3dSTmhmay9ZY21Db3pvUEl6Y2d4WVFC?=
 =?utf-8?B?UklFSDdFZWNzamJRcCtMRDVHSitwZjl1WVdrQnl5ZVpiVHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDJVREdnMEJvRm9LUXdGMkQ4R2tUUE9lTVZ6Q2w4MHVFQ1dvbHpNYU44Y1hr?=
 =?utf-8?B?VjE0c3diNzB1ajZXb3JGTjNWQ1RiMlErS2NXaDFXMVp6WGhBdEZ4aU9hQndt?=
 =?utf-8?B?aTZOVDhPTzd2cTV0MTFTZkxpZC9jSDlwL3BaNDhmck1PMHpMUTY5eTJlcWRR?=
 =?utf-8?B?RWlTbmVyOVVWMHo2SmRqclpMb3RPcFdwUnhKVG9ocWMxMy8rNEg1YWh1Snhs?=
 =?utf-8?B?cURUTzNuNFUzdzBFSEc4NjY1RlI5S2JacG40MXkwaDRSa0ZDWjNjZlFEZVJT?=
 =?utf-8?B?Y1JaZVZ6aE9zdEVXbXplVjk2L3RpSVhGb3pVSThtNFFPN2hlQ09rR2tUUTlL?=
 =?utf-8?B?eXJCMUZ0UFJ3Q2lJQzk5d1M2enpiZ29TRlNNN3ZVdXZUMG9UdUNyN2pLTnY0?=
 =?utf-8?B?TlhLT3M5NWRvL0lyd2VoRThjeERYaEgwSy93OXVEeTdPcmNuWEVndVBHbW8z?=
 =?utf-8?B?SFNVczVoZzZBRXhoOW9zMEFzVDlUQlVmUEFybEk2UFJYSFJBd3B1RFJBWklP?=
 =?utf-8?B?VVF5TXdpNGJQaUhlcWRSelJWSUxmZXFVR2FlRkNCbVl0UTFGZS9UZW1Oc0ky?=
 =?utf-8?B?SW00eVR4bWgzazVyRktJZnFDNlo3b2FZRDRndHFQc0lRSXlQQVppZFhIa2di?=
 =?utf-8?B?Y2dKeTV0ZjliTkFwZ0p5Z3hBdHp4M0JVK01KbW1SdzZCZ3Y4cmQ5M2p1ejZ1?=
 =?utf-8?B?WlJMK2NmS1N0S1AxdW1aZ0Z1Ym16MGZ5RkFhd1E0U1BMVGVPOTZDaUs0bjJE?=
 =?utf-8?B?N3RBNlcyOTZtdXlSWUovWDNqTFhWQmZCdGV4RkxDN0lqclBPWVlYdWl0OGM4?=
 =?utf-8?B?Q2EwaFp2S2Z5cU56anR6WTBtQ0tjQ0d2OEQ3WXNOWUFvZUErRmgxQjUyQ1h6?=
 =?utf-8?B?Q1N1OUcybjdpdW5yV0RoZ205b2JZcjNwdldyYm1nS2lGWVdqd0JGdmFFd01q?=
 =?utf-8?B?SlhNNjFlMEtUdEhrMy9BVmp3aTlKTUdMRE80bSs4b1RsNC9zMmdRWFdNT052?=
 =?utf-8?B?TXEvd1BCZjhKU1ZqbnBXaGdVTXhDM1lmVWZKZkF6amVNaXVRcjlUeEFUM0pH?=
 =?utf-8?B?RExLQy8wMU14aFFnUGpkODF4MlhNRVhTa1kyUlFHYVpXZzJpT25zN2JHZE5i?=
 =?utf-8?B?TnB2WlBOd2tqTzlabEM3WUpsRVhEWk16UXkxUkVzUkZCSVlCSnB3V2NLbVUv?=
 =?utf-8?B?SFZSTjAydHZtTzJjOUdkQWV5MktnK2xBRnEyK1Njek1xeGVPejFuK0pOQWlS?=
 =?utf-8?B?aFVhVjg0QmZqLytVZzR4aXdmTU8zQ2d1WVFtNDdXS3RFaFg1SDBQUDR4dDlR?=
 =?utf-8?B?S3Z6WWszZnNNVzFGeUR2ZTNwVUp6RmplWk5KZ2doZzlKUkljdHgvWCsvVzJG?=
 =?utf-8?B?WnZGaDBvZVhaRmM1amdISVhYWlhGUVNZTXY5OW9TRHpndUF0ZU9ZUlR4SVM2?=
 =?utf-8?B?SXdVdVhZNXFjWWVNWngzM3laQlhXMVJoNmZXaURZVTg1VTg2dVZ1dHhNNkFJ?=
 =?utf-8?B?blNPRHA0ZDNpTGwvVEx0WkUrY0h5ekR4UGd4RUZuYzY3ZHJLc3BwOFlXV2RI?=
 =?utf-8?B?cytySDZoU0VreDhlZzE4YS9LYkViaXJuTWN0VEFiYytmM0J1TERNSEF5L3lw?=
 =?utf-8?B?aUZDVlVhMmd2ZVBjcHhvcHRUKzVPSjJhWUxvb0E5em0xNi9kWXhma0ZjZVdz?=
 =?utf-8?B?bmIyT3ppUDlzdVJtZlRzOVppamQ2L3FpcXpqL2daVXNMUkNhbW81djFPby84?=
 =?utf-8?B?Y0tCNTZTMW5Ec1ZXTmJ0UUxkZTFEcnNHbnpYc3pZUmo1aDY4VjdOL1RTcVZn?=
 =?utf-8?B?a2tKVEZKdEtGZ3dNeUoxV0V1Y2Y3STFSckwxbXVxUjJYRHhHMFNYMGxhVmtS?=
 =?utf-8?B?SjJpZnFHWEh0MnhIbS9OYU53d2VaUzFFV1VQRmNIbzdZc2RObDVxYi9hMDMz?=
 =?utf-8?B?cWQweHZIZ2lOMHk4VHJGMm1CY1RoREFMdFo1MFdGTFNBYXFrR3N0MzlGc0hv?=
 =?utf-8?B?VHIwM1dGMjZ6UVY4S3NHNUtrRDJYcmxZbjhpc1Qwak5qQlFLQUlMK25KL3BP?=
 =?utf-8?B?OE5JTTlDRENlTTZ6OUFOekV1TTU4VTNaNUtndnZhRlNLTHRDekJzQWsrQzRG?=
 =?utf-8?B?T253dTMvNFFoSkkwMUM0Y3BJcU9SVS9EWjcxRVdqWXBvQmhOSW1qSjlHY2V1?=
 =?utf-8?B?Mnc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daadd57f-0920-4821-772e-08dddefb578b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:35:24.6710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OG9Xa7PuUPh0y3NjnMp7M3kEKfHG3qN5vZHMFyUMSrVrb9y0lr3AAxS0n9b8470RBK6z+IKOqRo61/NvTAD5MrCb3Y4m69Y8BEdFcHGLnVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR03MB7442
X-Mailman-Approved-At: Tue, 19 Aug 2025 11:52:11 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

The driver currently does:
    mtd->dev->parent = cadence->dev;

This works in Linux because `struct mtd_info` embeds a `struct device`,
so `mtd->dev` is always valid and its `.parent` can be set.

In U-Boot, however, `mtd->dev` is only a pointer to a `struct udevice`.
Dereferencing it before assignment is invalid, which breaks the device
hierarchy. As a result, consumers relying on `mtd->dev` (e.g. partition
parser, reset and re-init paths) operate on a dangling pointer. This
leads to failures during warm reset when the NAND device is accessed
again.

Fix by assigning the device pointer directly:
    mtd->dev = cadence->dev;

This matches U-Boot’s device model, preserves a valid hierarchy, and
resolves the warm reset issue on Cadence NAND.

Fixes: ebc41cad ("drivers: mtd: nand: Add driver for Cadence Nand")
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 27aa7f97a45..4771440d1de 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -2196,7 +2196,7 @@ static int cadence_nand_chip_init(struct cadence_nand_info *cadence, ofnode node
 	chip->controller = &cadence->controller;
 	nand_set_flash_node(chip, node);
 	mtd = nand_to_mtd(chip);
-	mtd->dev->parent = cadence->dev;
+	mtd->dev = cadence->dev;
 
 	chip->options |= NAND_BUSWIDTH_AUTO;
 	chip->select_chip = cadence_nand_select_chip;
-- 
2.35.3


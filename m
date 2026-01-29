Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB542D6101A
	for <u-boot@archiver.kernel.org>; Thu, 29 Jan 2026 15:23:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0491383F32;
	Thu, 29 Jan 2026 16:23:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="awEsxkYZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="awEsxkYZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 962FB83FC5; Thu, 29 Jan 2026 16:23:55 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C3783D9C
 for <u-boot@lists.denx.de>; Thu, 29 Jan 2026 16:23:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GOlDPrD5yGBWa0o2/ZJTru8LzP6OOE7RO2rnnrqP21r5wVI+cTkBE5Nx0Y2cN0TFVS0kBlHmbEATyKgfmxxfDGzzzNlLG+opuK6YH/g6VNg7n/Hy1p3Jz4pqbFTetQmcjBgx1xL0qxoeMHOjqejbwWNcGeViLIq/msxCTlNOkgNZL2RKgWKkqE3YWowoAk4xl8KC37hdSvjrKqw35B4dTsWinr//TYvWEtDmh5+cjzM7ffE+9nO+uLQaZlTFBc5XQwbHoxV/B9k9LeUbfS82YDqYGeQ/sney4HMWob3+Klt1IwasNlOTVC0aLZmBR07wLuUdlKBn19PXfce5nVTzBQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+E+4ilKc+NAU1siJVu0HjV7pNWd5RC/9L4B1b2EP00=;
 b=iaGdUSxzonRfNShKcaHHl9Gal1krKNFrY9naTus4r9RINb17YflOxhemrRskhj362C1w/+sB125/yvXoNK2i8lSrhlx7kLoWO0y4UUHb/f7C1vSCrzlwg3jlLk82On04U2GEEvlgyR5mcBe+bcM+YBtCq68JwdnPvVCdS5O4S5712nfZpGxNYWDEFY9+ZFWsXBo8bthNxCtUoNvEwBaKNVON7ztZaYtlRCpM8zoT1l7whwl15SGI/ZPDqHBwWAvTbtRraPo5J4QV0sMB+nEUkUNsGwYPDbzx6Er/c/FjyOpkb1Urojvzu2YtTWCfO3eapx3/FyZgB4mQPxroEpBkXA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=mailbox.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+E+4ilKc+NAU1siJVu0HjV7pNWd5RC/9L4B1b2EP00=;
 b=awEsxkYZyJp21X8chC34EEvchJnS8yXT9KYhzgm2P1EanSutCaITX1EGgzY12j31RwsKME+aLsLfBHG+VO10YWqTBEJ902M2K4IeRf75Cihhcd4cRiD50XntRgMFz8zLMVJMR0EclwV3YIqQxeDag6B29U6SU9mY8JWk5sXH1GE=
Received: from DU7PR01CA0036.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:50e::25) by GV1PR08MB10953.eurprd08.prod.outlook.com
 (2603:10a6:150:1f5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 15:23:47 +0000
Received: from DB1PEPF0003922E.eurprd03.prod.outlook.com
 (2603:10a6:10:50e:cafe::3f) by DU7PR01CA0036.outlook.office365.com
 (2603:10a6:10:50e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 15:24:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF0003922E.mail.protection.outlook.com (10.167.8.101) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Thu, 29 Jan 2026 15:23:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PeseGdYFLzIlH0NEAxtZQbtv34wMlD3ZuJMZ+MIjHuVaoKhmWXJcRqfE0Xc9qVBPhQfnHQJ+CCi9P8QV1F+uR0qrsai7MHQpSVdv/Yuamsw5D0jLY8nGspVwZVjIWSbRsLybwGKYzGICUiguevBY7ddy0BBtBPLeLPqMw6vQzAP+XCbk7+wbDuRhAjWuZRKL5MbHvcIl13w5ad0tFMjr5dmsBIFUrdqfo5LMuHDXnW22gRT8blQ/vQO2qhyZvZ287zvXGV+hFk2dqeZtAfk7jXQEyUXJ6IX183sf50dL5e8khqa+9AspFFgP+o1Jbz4FHA+ULgpGbGZ3HMJCorzt8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+E+4ilKc+NAU1siJVu0HjV7pNWd5RC/9L4B1b2EP00=;
 b=wbOgqtMz3CG7Wfrfb3JYbJk/TFe5zDE+PwnAEjh38bMI/DgBpHFbOEfbsYVhBSINajUFSTeQdYc6UkEmwxsDmay1GI97JWlTpKrR+DJ6Vv8Fwdch90aLY55SztW/TpkN/3N+7vOFk8Siof1Kam6Sm1hdI7UMU+k5GI1++AIX64aqeRGWF84OY5SrmoxRvbvh9V5tF+P8L9LX21/+I5wMwll8wvN+u0Vdd2LEkw+Ivxymq9E4pthri4Z6tNa1/61m7ixuPKa3u4U4mKBhiw8oMp+rTSJzy7mQ5vIjzPTL+xtlOcmM9cwmjPJ6uZnV2A9FusO2tQS0C39OYSkkyQf4mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+E+4ilKc+NAU1siJVu0HjV7pNWd5RC/9L4B1b2EP00=;
 b=awEsxkYZyJp21X8chC34EEvchJnS8yXT9KYhzgm2P1EanSutCaITX1EGgzY12j31RwsKME+aLsLfBHG+VO10YWqTBEJ902M2K4IeRf75Cihhcd4cRiD50XntRgMFz8zLMVJMR0EclwV3YIqQxeDag6B29U6SU9mY8JWk5sXH1GE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PR3PR08MB5657.eurprd08.prod.outlook.com
 (2603:10a6:102:87::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Thu, 29 Jan
 2026 15:22:43 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 15:22:43 +0000
Message-ID: <ddf9d7db-017f-4f19-8163-c28caf320e89@arm.com>
Date: Thu, 29 Jan 2026 16:22:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: wget: rework the '#' printing
To: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>, nd@arm.com
References: <20260129002348.433050-1-marek.vasut+renesas@mailbox.org>
 <fb3183eb-c389-4508-9316-33c88824bbf1@arm.com>
 <f5ec9ab2-5f20-4121-a3bb-f97d7d108c1b@mailbox.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <f5ec9ab2-5f20-4121-a3bb-f97d7d108c1b@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0223.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PR3PR08MB5657:EE_|DB1PEPF0003922E:EE_|GV1PR08MB10953:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e889ae5-df84-4a08-16fa-08de5f4a659f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?RlQ0cEhqa1ptRnV1NkhSeUx2eGN0dXNnSzhRWUZGRXlJdDN6aUFDOThyRmNo?=
 =?utf-8?B?ZjV0eis3U1pBNTZqcU1mSXZpaXpldCtBRytMOHZaWWlZNm0rNUFzN3ozamZ5?=
 =?utf-8?B?d0JVMS8vSDg2aklzOHZ0NE15Mkl0cTBhcFdUcEZFQmJYUnZyeVhVT2FpeTFx?=
 =?utf-8?B?VWJML0dPL24yVS9DWng4bU1JWlU3azZmNGt4UjJrRXVSNlRJSzk2WGQza0dZ?=
 =?utf-8?B?dFpWQmhWcEhJY2ovT3dGNWk0U0dCc0hMRU1rMDh3MGEzZEpDMVZIVkhSNkM0?=
 =?utf-8?B?QWZrOFBGWkpmNU40bzBNWGdLQWZLbmpNd3NoOEdpNGdsRnZzdzdTNGROUEtr?=
 =?utf-8?B?YmhLYnl6MU5TYnBIakwyS1BSdm9OQ1RNYmZrTHlhY096QXhlQURBYi93Wk9t?=
 =?utf-8?B?aXlrMTg2c0FwWHd2QXc5dVU1T09aK0tjVUk4eUp5Q3dlNnppUVpzOEs2dmpQ?=
 =?utf-8?B?MXN4ejUweUxtcVozZkNJUmJ0Tm5Va2c5dUdSWWJkYlIwSjBLY1k0LzR3NjVq?=
 =?utf-8?B?YVU1TzNCU2pwUFBuNEVoT3l3M3M4cWZzbHIzWVZoTkVwbjltWUxwZFVXcFE1?=
 =?utf-8?B?djNUYkxoTTlXR1lKWGJFRWYrRGl5UVFkWTlwYy9VU1pwVFlUOFoxTEFlOFd2?=
 =?utf-8?B?VzZNMU5ic3Z5UVFQOWJlWTJudGxtd0JCY3hKTDJKZ0ptSE12YkZmTXFhcUt4?=
 =?utf-8?B?UW9YWXBFOUllU1FJbjNqWkIvekZDSGJITldzODVNU0JOWXRVQ0x4WG5rT1V1?=
 =?utf-8?B?SFVoRG1ZQkJtTUpCZU9wdHZJQ1BtUnlxRUh4RXBxUlpqd0lYUE1kS3pEOU5t?=
 =?utf-8?B?ZFhzV0ovZWkxUlViVVBzbVpyQytMUmtZZ1Z6OHhKRGJHKzZNVHhzWkNrUnVR?=
 =?utf-8?B?NlVmL0pNN1Nyd2w4bXZ1NlRWY0FPUDh0Q015UnlnSy9Zck9CMHRONWQ4enZ4?=
 =?utf-8?B?UVV5WnVNNCtHQjgvaldrVHdxb25IRFBHTEQrZGdTa3dmSzV0a2JnTXdmRXBD?=
 =?utf-8?B?VnhtdytBRlppU003ZEltQ2IwMXZ6R1dJNjc1RmpVWDVQVlowZFRnamIxVWsy?=
 =?utf-8?B?bDJ1ZlZRS1hsY2p6ZFJmeThrTEF4K2tMRFlhSnFPRE9lYVdRVncxcExTbFBk?=
 =?utf-8?B?S1RyN1hxMXFmNHo0ek1vNnZMRmhjcDdMSCsxU2NQZWp4anROVEN1UWU1c0J2?=
 =?utf-8?B?WVJuOGlIdjJMaEhVWG1qVkExWndPRHA5eks1ZnlBc2gwMEdzUStrcUVjWURY?=
 =?utf-8?B?ZUkrOFpKTlRSeTNrdnlOWmZZaCtzZmtUUFdEdmhVSlhRcGQwSjVjTGxJTzJP?=
 =?utf-8?B?ckRJWFpYODB5K3hRdzY5YjE2Um40U0txUTBIaVVHQ2puWWVHdVkwVDFBV2ps?=
 =?utf-8?B?aVdvelQvOVJpRkM3V0U5NDR6bVNvN2o5UDlzQzhQeWk5Ymg2bk1YN1pOMCtV?=
 =?utf-8?B?SXYrK3BpaTZxYzFYSkdLNnUyMjFHWVF3VEVPczRyVFlCcFZJVkp2NXhSSzYw?=
 =?utf-8?B?M2pyOEh5NkFtU1ZtamZ4RTlMUjNCbVNoRXU3N3YrbTg4elZMU2pNYllvOHVI?=
 =?utf-8?B?SFJiVlhNT0FjVDZLY3lBejBJamExeUw2OVFNcDJwOHlLMFhTczVhL3JHdXU5?=
 =?utf-8?B?bVRqMzc0VEtHVzdvY3UxaUtDaEZEWjRPZmJuODhNMmdXNlZUckU4d1lBZ0NE?=
 =?utf-8?B?MmJ3TUpHTUpaeWxQRUVIcFhYRVI4UTRxTkEvSXREaXdidnZxK0xBWjNVZHRO?=
 =?utf-8?B?YVdJcTJQYy9xSlFHd1lneThOajlZb29VNXJmbXMxMWdlZ2oyV3VYRHA2bXM1?=
 =?utf-8?B?VTF2Q0xpc0ZqNEwyMi9NWlZlTjR6c0ZzdGtDRFh0TEZQSENBR0VtOVU4ZkNx?=
 =?utf-8?B?RVYzNWZzcFdlVERvNC9TUXoyZ0p5QVJoc2tQcjZ0aVgrZ3ViOTFPNkM4NENX?=
 =?utf-8?B?cVY4WC93ZlAzYXQ0c3Q2VFJxemdtVE1YYXNLYnMxNzlMblJObzB0eGtTaGsz?=
 =?utf-8?B?RklzdUJzV2c5aGhBVy9JRHlRNDF4LzNDSHlFMC8yMVQ3LzVPRHRoclJUckJp?=
 =?utf-8?B?aDkwc29ZZzdneTFqN0Z5YlJCVXBiZ2hxaEkrV1orZ3AvUUtKa1VEa0pCK0ln?=
 =?utf-8?Q?yLpQ=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5657
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e83a0d62-eaed-4888-2526-08de5f4a3fb7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|35042699022|36860700013|14060799003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OElYbThsV2VkdTVOYnc4akdUTVU2VXY3NzNmVy9pWnpCd2swRmUrSHh4WlNM?=
 =?utf-8?B?UHpVVmpzdkJKYlRxSGlkY3V4S3lTWWRZWWhIOU1TeUNLc1Y1cWJjaTZIL1hF?=
 =?utf-8?B?aGhNM3BXTktKOXRhclpWV012M05sMnJMK0ttMTFHY21XS2d0ZFBLZ1RMd0Nu?=
 =?utf-8?B?UGx0Znl1ZVR5U1lBbzVDdDMzRXV5WEFsL2JVbm1WbVJPdUVaTFd1OU1SUWo5?=
 =?utf-8?B?UTY1ckxQY0FuWE5ydTQreEtqOVMvc2N6YTROQ3pGU20vL2lxaEJDRE5kOUhF?=
 =?utf-8?B?UTFKeG1wQW9oM3hGOWdHQTBZc3ptdFZQVnlxdzlwbjdqU0ZLOWxSd2NmWGlY?=
 =?utf-8?B?RXZHbmN1SmVZTnMyYmk3WmxpOWtHa0wwMzB6c1Fsc2NBMDZlN0w0d0VTMTVR?=
 =?utf-8?B?dXowak1XSlQvOFpScWdraDYxWUFKQnBxL3pTN2dDdTNNTG9yclAxL3pvNVdI?=
 =?utf-8?B?aVZaTkJ5UnNXUWJ0N1Nzcm9waVVRUG5PTldqT2l1Y0F6U0N5cFp5dVN5MU9Z?=
 =?utf-8?B?S0Y4dmdJRTUrdG96VXc1eGlsdko1UjlYa3EyOSsyMHNiZDJlR3NjYWlwcWw2?=
 =?utf-8?B?OHpDOFhSYnFHcnFoTGw1NTNnT3JFY3lBVzhXT09TZW1MeHM2RDUvQzl0RDNz?=
 =?utf-8?B?RUpGSWVwNGJ5T3VLVTdKVUtHeGppbjRwQjFWelM4UUJ6a2I4OWltNUFFcnRO?=
 =?utf-8?B?azR5ei81SDd2YUo3c0dtcjVWejJuQzNmYzV2bldKNUwyM3ZGUnZ0WTlCbW1m?=
 =?utf-8?B?LytvYjZuR1VPbUlQL1BiY0VhcGpJL0xRRHkxUUMvUWl3cW9yV0FialdDT1po?=
 =?utf-8?B?WlBCV1d2aGlUVzdlbjN5QlZBRVo0bForTWp2YWtyNEpNa1llNjlxSEZuSVFa?=
 =?utf-8?B?dWhOaHpZVEhjTG5FdEsxUmNjczl2b1RRWFZDeTh2VmRYTzRLRE1SUzNmQngy?=
 =?utf-8?B?SFp3NUlCdEhudCtWRzBGVmIzcWxjTGRaWGhMUW05WEN4QzBZTDk4OWFxTE5l?=
 =?utf-8?B?UENnWWgzMGFHVU0wKzQvTXpDd1JKTHZXM2hZR2tGa2dtL2pIZlJiYzZOSHN2?=
 =?utf-8?B?VW1Bczd0dkZ6b3lOaTlIaFBrUVl2elI1UjlHTTU1cDJLOStvN3kvWkJBNUNi?=
 =?utf-8?B?ZVcySW9NWG5qaDllS2dMYWI3VUllbFVXZk9jL0pGU3NwNkd4dUtTcm0xVDQy?=
 =?utf-8?B?cmlVdEhoR3RqTWIxR3BPMWYvdW5NQzArdDBXcXdiSy82QTY1VzlBSGs1a1J2?=
 =?utf-8?B?OFJNNmtKTTZYa1E0M2ZpMlo0ZWhjTk0xYzhlWUhtbFozVWFWek9YZ2pSWTI2?=
 =?utf-8?B?czNFVEs3ZkE2d3dMMVd6SUcvNDNUdGloV2p1UlVrQzRGNDU1NFpWKzB3bXh4?=
 =?utf-8?B?RjJJM2VGeGd0MDdlZHc2ekcvUmF4YUQ3OHlxYktlb1QyS1p2RHdHNm1TU1Ba?=
 =?utf-8?B?V2V2UTBWU0o2N1AxdG5NMVE3NzN6eUVGRG5RTGFsQTRhbDVhT1VWWXNDRzRu?=
 =?utf-8?B?ZlkvT2RFM0YraGd4eDZqMHcwZXRRZWxCZVVQYTNURVFQeTdPbWN3NVMrV2Zk?=
 =?utf-8?B?ZU44T3l0K2p0TmExeGd2Y2NFcUxjVzVrQzV4dENZVFZCeTJNRmYxdmh4a1Rp?=
 =?utf-8?B?VnJXemZJVWg4VTVreFNGRmNqVWxYUHVwQUdCT2NhQWpyclV0MGJSNEc4d3JT?=
 =?utf-8?B?OWNPMGhtMisyaElhK0NUM2hzRVJLNlo0V0RFSkRzSnRrT3NGTlBIQnYvVVFv?=
 =?utf-8?B?YmNHN2E5OGVycTJhUXlvSHQ2TEN4RUlTNTlKc2FJU3ljWEF4T09yMmIzcVRn?=
 =?utf-8?B?RXFUTXQxdEdWMzRNN1VYWWk2Y2E3N0RNVjNFalJ3enV2djBZaFNNSTBiejNU?=
 =?utf-8?B?NmxLcklKUzhacjhsT29QSlVZdDVVSkpPaE1tRHhpLzZGb28yeE50MjlsWmdT?=
 =?utf-8?B?LzZYaHZTQ0wwNzRGeW9vSGVEVlRxMFhVS3RaajQrMFJ5UnFsUVAwcW9vZGdU?=
 =?utf-8?B?bFJjZkJLdEtUaElhU0E1VndyMkd2ekp4YkpuRmxwallvZjdOK010K3JhT0Nj?=
 =?utf-8?B?WW1LSHlEZnA5bUVUS3VwTkNDS1p3NjVOamxmdW8wcUc1dytVQzBiYWtBZXVY?=
 =?utf-8?B?MmVYdFFneVNrUXM4a3BqREN5MEkwNDFrVmFaQ3RhR2RNZk1jVlJvMGVqNUhB?=
 =?utf-8?B?ekQvUDY3U2lYWmhsL293b0FPVTFVR1A1VHZkbGFmYm1hVEYxYnZFMUN6blRG?=
 =?utf-8?B?UzF6UTlQL0ZQUEhwVjNUUVpEWU53PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(35042699022)(36860700013)(14060799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5MKI8tYbCzf0+j0ogpiveaJcd67H+UoLvr5wNRAPmYB+9QYOMJETZvuOI4b731Ao6tu8F44Ah4x+bpl3wjxAwXxferbiqdhDIFvOYL84YNz0UgtNWvSNlo8+8lxTffY0TDaanS8M53HRdFuhxPuvv4CyxKRUTkNCa/ARoQe8CDOG0r92NpaZz93GM2ooRHxats205KU8EjOZLtSprx+mm8SSqqrdKWAZBuRPQji79LgPbOPCQMciE9vBb4Tl6D/MVnY9sVfDWjU/BMSqbVIZ9rvr0hu3s7KCSht6a4pVwPJ4Y1MufpK6nbvQJgN/mb7D6xujFLw90t6WTb66EtEHuILbawr2a+0DrNRONtEu0cMbkyHM2UNL2YYUlfxcWxDQFyqLS+0SOUmqdgo2k7Hm/0nIdYM58JcVAOzAp0cZQCITJVr9Y0z4+Tp1hnSzj5ZQ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 15:23:46.9246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e889ae5-df84-4a08-16fa-08de5f4a659f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF0003922E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10953
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



On 29/01/2026 15:53, Marek Vasut wrote:
> On 1/29/26 11:18 AM, Jerome Forissier wrote:
>> Hi Marek,
>>
>> On 29/01/2026 01:23, Marek Vasut wrote:
>>> Currently, the LWIP wget command prints excessive amount of progress
>>> indicator '#' for very long file downloads,
>>
>> So true! ;-)
>>
>>> limit this to one line
>>> that scales according to transfer size.
>>>
>>> The HTTP server does report the size of the entire file in protocol
>>> headers, which are received before the actual data transfer. Cache
>>> this information and use it to adaptively print progress indicator
>>> '#' until it fills one entire line worth of '#', which indicates the
>>> transfer has completed. This way, long transfers don't print pages of
>>> '#', but every transfer will print exactly one line worth of '#'. The
>>> algorithm for '#' printing is the same as TFTP tsize one.
>>
>> That's not one line strictly speaking, it is 50 characters.
>> Like I suggested re. your TFTP patch, perhaps a percent-based format
>> would be better?
>>
>> 0%....10%....20%... etc.
> 
> I would like to retain as much compatibility with the old network stack as possible, to make the switch over easy for existing users.

It is a valid argument but I doubt changing the display can break important
things, aside from test frameworks maybe, but that should be manageable.
Tom what do you think?

> 
> Is there already such a "pretty printing" function available somewhere ?

Not that I know of :-/

>> In any case:
>>
>> Acked-by: Jerome Forissier <jerome.forissier@rm.com>
> Thank you
> 
> (it seems someone rm'd a character from the AB string above, so I reinstated it according to the source email address)

That someone might be me. Muscle memory not yet trained.

Thanks,
-- 
Jerome

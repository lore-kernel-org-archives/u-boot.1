Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AA0C25B75
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 12:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C17798877C;
	Fri, 31 May 2024 14:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cern.ch header.i=@cern.ch header.b="nYnl37Zu";
	dkim=pass (1024-bit key) header.d=cern.ch header.i=@cern.ch header.b="nYnl37Zu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2373C885AF; Fri, 31 May 2024 12:09:31 +0200 (CEST)
Received: from ZR1P278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c213::5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20D6488607
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 12:09:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=cern.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=vasileios.amoiridis@cern.ch
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fiWJDArUbVV7eno/+8oYkQFG8QBlY+3cGzSAwB3ni0s2BLiLd00mTozzRddhQ4E0rJPyEJlsy1IYW94uvbjtq3IneHq4T6cd+257VVFBdg5ICKRv3a+0+EtnxK7HDHl5nLsExenUccHi2UJ49m003e/uLm5MWnYPN9IkPm31CFDt6QQNEYn4ZLEB/HEmsfrikGaEsHGnPNbLAALzzC+DW7I3rFZVt9BRkWai+DjJK9s1z3gKJYvZ6jH3AESgC+M5x8PxhtiNw/dB+Wa9492IDXkhbS950gSnsw+UbyiSoMy7UvMepVdRX56d7JjKR4jQgTmffMP53SGeV5K10C/Ygw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btC4hyh/q0q4ag8Kbf9rEYoVr1190c720NnKb2PIh5Y=;
 b=FYndBV3rePAmAjv0LURwySU+7vkXqUnVb53nAd7Mh86ixysUfHoCPmlSMlMUQWvS2iqpqOH3/F2ZYSS8j68rLiO02GBD6VOP1dJmMw2+oFGunbMW9m+Vi+2ciYSsAZn7QGEeLZ+pNBGBQ9Se+CGgWN+dCtyXWTwh4++eqJbGNbVpLhYI1vj0Hq7Wypn70vY3i3w5rbRg170ezs1Zgl/xLAnM8UYQJ4L6IwjMzLjfny+7e5qDLQWD66Ibgpl5UvE1i35ZWS67pG6xKrNWS08sgBpiniqzNsNIhyOmqZY4uRDBgcs7T4gJUGBJFztxBzL4jhqX/k/wQGNdRdco3qFkKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.208.138.155) smtp.rcpttodomain=amd.com smtp.mailfrom=cern.ch; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cern.ch; dkim=pass
 (signature was verified) header.d=cern.ch; arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btC4hyh/q0q4ag8Kbf9rEYoVr1190c720NnKb2PIh5Y=;
 b=nYnl37Zu+lQ2sU6ILw9Gdad0E2dlY3u9ID4YLrqN3UwyEknRhO3peANMGi6Qlw2ogtJBknLmnA9K9zwl04DY2nEc6xEbIbRXxy5Y9QEpRsofuwJTKgZU6aPHDV438fvGVk0+Gw83T147dTuBOsWehlsH36nMcWH1+mP4jHV3R+I=
Received: from DUZPR01CA0133.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::28) by GV0P278MB0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:1e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Fri, 31 May
 2024 10:09:26 +0000
Received: from DB5PEPF00014B9C.eurprd02.prod.outlook.com
 (2603:10a6:10:4bc:cafe::e4) by DUZPR01CA0133.outlook.office365.com
 (2603:10a6:10:4bc::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23 via Frontend
 Transport; Fri, 31 May 2024 10:09:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.208.138.155)
 smtp.mailfrom=cern.ch; dkim=pass (signature was verified)
 header.d=cern.ch;dmarc=pass action=none header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 20.208.138.155 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.208.138.155; helo=mx3.crn.activeguard.cloud; pr=C
Received: from mx3.crn.activeguard.cloud (20.208.138.155) by
 DB5PEPF00014B9C.mail.protection.outlook.com (10.167.8.170) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.7633.15
 via Frontend Transport; Fri, 31 May 2024 10:09:25 +0000
Received: from xguard (ag_core.activeguard.xor [172.18.0.5])
 by mx3.crn.activeguard.cloud (Postfix) with ESMTP id 9023E7E526;
 Fri, 31 May 2024 12:09:25 +0200 (CEST)
Received: from ZRZP278CU001.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17011007.outbound.protection.outlook.com
 [40.93.85.7])
 by mx3.crn.activeguard.cloud (Postfix) with ESMTPS id 4B3797ECBE;
 Fri, 31 May 2024 12:09:24 +0200 (CEST)
Authentication-Results-Original: auth.opendkim.xorlab.com; dkim=pass (1024-bit
 key; unprotected) header.d=cern.ch
 header.i=@cern.ch header.a=rsa-sha256
 header.s=selector1 header.b=nYnl37Zu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.ch; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btC4hyh/q0q4ag8Kbf9rEYoVr1190c720NnKb2PIh5Y=;
 b=nYnl37Zu+lQ2sU6ILw9Gdad0E2dlY3u9ID4YLrqN3UwyEknRhO3peANMGi6Qlw2ogtJBknLmnA9K9zwl04DY2nEc6xEbIbRXxy5Y9QEpRsofuwJTKgZU6aPHDV438fvGVk0+Gw83T147dTuBOsWehlsH36nMcWH1+mP4jHV3R+I=
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5f::9) by
 GV0P278MB1540.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:65::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.23; Fri, 31 May 2024 10:09:22 +0000
Received: from ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67]) by ZR2P278MB1164.CHEP278.PROD.OUTLOOK.COM
 ([fe80::b971:7e0c:3b2d:cc67%3]) with mapi id 15.20.7633.018; Fri, 31 May 2024
 10:09:22 +0000
From: Vasileios Amoiridis <vasileios.amoiridis@cern.ch>
To: "michal.simek@amd.com" <michal.simek@amd.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "santoshsagar.algapally@amd.com" <santoshsagar.algapally@amd.com>,
 "vassilisamir@gmail.com" <vassilisamir@gmail.com>, "ashok.reddy.soma@amd.com"
 <ashok.reddy.soma@amd.com>, "LPolak@arri.de" <LPolak@arri.de>,
 "venkatesh.abbarapu@amd.com" <venkatesh.abbarapu@amd.com>, Vasileios
 Amoiridis <vasileios.amoiridis@cern.ch>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "sr@denx.de" <sr@denx.de>
Subject: [PATCH] xilinx: Add option to load environment from outside of boot
 media
Thread-Topic: [PATCH] xilinx: Add option to load environment from outside of
 boot media
Thread-Index: AQHas0Kbt0GMDUrz7E+NyZKWbHYPuQ==
Date: Fri, 31 May 2024 10:09:22 +0000
Message-ID: <976d57fe9080e9068421bec882ade85faaa3e30f.camel@cern.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cern.ch;
x-ms-traffictypediagnostic: ZR2P278MB1164:EE_|GV0P278MB1540:EE_|DB5PEPF00014B9C:EE_|GV0P278MB0002:EE_
X-MS-Office365-Filtering-Correlation-Id: 15db8cee-21ae-4ed4-2126-08dc8159c06f
x-ld-processed: c80d3499-4a40-4a8c-986e-abce017d6b19,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?S28xbHpKeHYzZ1FWalU4S2lEVGV3VXhTTjBBSVM5Sm02M3RIK2FGTndvT3hR?=
 =?utf-8?B?TFVkZm9ML1pnbXpVTFR5NVhRczlZamJHR2poRmZ3MGNmTXZ1cEVreTFYRkRS?=
 =?utf-8?B?V0xOL2oxSEQzcDFadTNBU3c4SmZZbHFMS3VmVzhhZHFHMC9BRndqK281bGJM?=
 =?utf-8?B?bmJ3MzM4TjNVcjBjSm9vU2ExYTVuU2lMOGgwc3hpdVhTQ0RpQnZIcWYwSlRW?=
 =?utf-8?B?VWd4QzlPVFNzQmVLbFU4SGMxbHRmUnZyZjBDQ3FUTjJVTVZPUCsxREk0aTRZ?=
 =?utf-8?B?NzZZaGx3WGJlUDdnU20vc1hEa3lQbGxsZmxnblpPakhTdUx5RU9XTWpMK2h0?=
 =?utf-8?B?MTJaeFI1bFRGcmV3TDUzNTdZMnZnV1JRYTVmOEJUekhEUytpb2FiNE92eHpI?=
 =?utf-8?B?SjhXc3M1TEx3bGlIRmZQTjhHV1NmTFVaVk1VWUdpS2RWTWl3aGdnY2RXbk1k?=
 =?utf-8?B?NEs4QWJLMFdFVytUbDZtOWlFY1N3WkJ6dWJGL0k2RGJ0VU1SOWt3dng5R2o0?=
 =?utf-8?B?YS9ZcFUvTVNxT1hMUzhHZGQ4R0xMVUVIdEVWRUtaVjVDZmtFV1JkWTZPZWJG?=
 =?utf-8?B?TDR5R2U3NnNTNVlBV3VvU3RpRWp3YzFQTEw1TTRINHRkWURGZXFzaTVEdUFX?=
 =?utf-8?B?cWovM1E2SFQ2VURLUFZxMWcyTkNSbXRoLzc4Ti9OWlZ2VVJlR1diYTd5VFpk?=
 =?utf-8?B?Z3lLLzlxa0xpbkhXMUJnaU1uN3V1RmcyMVB6QjZ6Q1ViWTdibDNsRi8vY1JI?=
 =?utf-8?B?MGN4SlNTK016RVRZaVhxa0tQK01UQU1DcjRqeEMvd01sVG5raDk1N1FNZ0xH?=
 =?utf-8?B?b21DZ1pBdTlQRkU1YVRPSUY1WGIxWEdzVUhZYUNZU0laeVd6dW92V2xERWk0?=
 =?utf-8?B?bmZwQVgzVUJYSncrNXg0Nm5RelB3ZmRwS01CWFV5ZEpTbi9mRUg0T1g0NXlW?=
 =?utf-8?B?NWJaZXhGNjRqZHNibGw3VGNNUXc3eGFpYnNmSkdxWXhURXp0RnNxY3YxWXFS?=
 =?utf-8?B?ZXpWdW9BM2dPNGM1blBFdHgwQVJqMlg3RVA5MDN0ZjRYZ1JSZ1dZWnloQy9N?=
 =?utf-8?B?bGZpYmlXcEd5TjZ6OElKQytReDY2RTg0WVlrREZ4eW45V0tENWNJdjZ0Skxy?=
 =?utf-8?B?aUVBcmprcWhrT2JrelM1Z2pJUVhPKzE4azY4Ukw5UlhKL2tjb3pJTEhPZVJQ?=
 =?utf-8?B?VmNxVWVWbHYrWVIwcm50em5GTEpMTjRKZkV3SnJ1Ylc0MWVnRGNvcEFWU01I?=
 =?utf-8?B?cWl5Sk44LzR3Y0ZVSUM0RVNoQUprN0dqWDlqOHIvbTFuVzRrdTdNelFEV0VU?=
 =?utf-8?B?RjZpbjNEWlVsdmFVMi9vbllrVzVsU1RFdHY4VThqUzdCTDhySFdoQlAwb0ZL?=
 =?utf-8?B?S1ZFUExxa245bDdydG5uNnpHaDdBQ21tMGZQTHExUEVCOVVCYVNLM2Q4U3N0?=
 =?utf-8?B?RDB6aW5LTzU3SlBBOU5uU293bi9tODRFZ3o5VjJ3ZGtQMHRDSXdsT3RvM1U2?=
 =?utf-8?B?VDA0MDFjNFhBTlBpWWRiQkExbTZPSHZqUlNEWFJBNDZEMjNQdXY3SnprTVhu?=
 =?utf-8?B?WU5xVFJLMTJrZy91L3BlOHU2TklUcDZCQzdxeTQxcjdFYXRhdFNxZWdkU002?=
 =?utf-8?B?Q055ZjJ1TzZJMGlBc1I2Qk1rb3JpRnRkVFMvajJjQTBTQmRXQkxLOWJRWlAw?=
 =?utf-8?B?VnZqNXJJeENxMk9OdzBCeTMweGJoWWVWVERObmE2SC94ZWFaTEI2cjZPODRW?=
 =?utf-8?B?dDlUSTBteU9VKzg2U2YyRm1LNUdrbS91VklNTWprUFBYQmF0QWpwSUlBRmVr?=
 =?utf-8?B?MUJqTkRQREhIb084SThkZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E65154915E7F3E428347AD4159C12908@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1540
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1c59dc93-d2e9-428e-c82d-08dc8159be1d
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|82310400017|376005|35042699013|1800799015; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1djcGNMRzVUMGZFaXNVVVFQMUJ4TTdXR1ZuUWwwT1FLdDc2WjliQzEvOFlt?=
 =?utf-8?B?VVIvY2g5amJOcnhCV0NsRmFBUU9QQS8rd3RDRXd6YVVvT3FVanFwcnhKU0ho?=
 =?utf-8?B?T2hqSlpYM2dpNHpKbHA4MzJORW9iQTNTWDFoRkM0aDQyUHYwanFmaUJ0TG9p?=
 =?utf-8?B?RDl3ZkgvbncxbDVTdmFOL0RYdnpwZzhBTndhZFhrTjkzY2JwZTNMSzM3K2pU?=
 =?utf-8?B?RFB0RWlNNGUrVmpBZkZNY0ZDUlUva2o3YVNCY2R1aFFjVkxUeWNXY01UTmxl?=
 =?utf-8?B?ekR6eEVEL3ZJaEIxM0p3U3QwMk1oVXV0WTlDQlNhK2hxemZzaWFMbFgrZkd0?=
 =?utf-8?B?Qm8yNGt6bzQzMlVORko1eXpWNzN5OUpsM0s3ZEVmdUhhZXExS0E4NzF6LzVu?=
 =?utf-8?B?VDZaYW9jUS9EUFV6U3BQMkZwT2RNRU1nZURHdENUMnlTVHA0bDlFZ1IvMTJZ?=
 =?utf-8?B?akJncWYvSFVTazBSbGNwaXFnY0JZYnhVY1FoemRJa2NpdVZHT2FJSkF6LzlB?=
 =?utf-8?B?NTVtRFBRbU1XZ0FKTUxkNEd5UGJOSy93TEJMY3FDRkhyOUJZM2FyRDB5aEdJ?=
 =?utf-8?B?YXNmbWw1NXM2MG9MZENGQlVzaiszTjgwUG9Pc1VCZk9IQTJxcnIzbWdpK2sw?=
 =?utf-8?B?a2J2dWNBakVRODl5eHdNOFRaTE1ZdTllUnF5cE9udVdNd0NPUTB5a2hZVUdl?=
 =?utf-8?B?YnBkV0tzM0xOT1dKMUttRWh3MlkxeGRWUy9sOCtMeS9nbFlDTnlqR0NQSnhr?=
 =?utf-8?B?ZUtqc09WZ0dPR1BEOW1IVlJGZXlFUkxVWno2U2VCUm9kUWxCRmNHblp4bGcw?=
 =?utf-8?B?QkhDMDdBMVFyTXE1VmlicndER0p2OGU1UTVZb3NGMFNLNCtEVmh4cHl6Yk5E?=
 =?utf-8?B?UFR5VXozYUgxWlNrczZ1ZG9oeGRLN0k2MlluNjZDOE5jNE5tNlo4Mjg3Y29H?=
 =?utf-8?B?MGNMSTY3Y1ZZd3lDdmxkeUdSamgydGtwcnhZbDMwcjlBeFR1TkNYR2k4YytV?=
 =?utf-8?B?TjJ1Yk9iTVY3b25RKzFoK2hvdDFNK2c2OVJCQmI2NEhqQll3M2wxY0E2YVYw?=
 =?utf-8?B?QXdRU29vck43M04yOVZnWTJyMHRiNm5EZDdXYkhIdDZvU3pmSG1HZkZvdW1q?=
 =?utf-8?B?VTZtMWMzZUJwdWgrekI2b1k1YmtIQjcxMytQaStlNmhYVlQ1RkgrZVU4K2RJ?=
 =?utf-8?B?OTFQZ3VlSURROFhzZHpBdGdaMVplUkpXOU5lS21PUDdVbVZMYWc2K2hMa2ht?=
 =?utf-8?B?eWZwTTdjd0VKckFjUzFLTlRKOURsTDMxYmtGYTJpdzBlcm4yMjdXN0liNjZm?=
 =?utf-8?B?c3NPRW1qQTE1TzZGV2FmNVdvL0p2QWlOT0UxZHBWOUdmSkpCaVFkcVRtVzFB?=
 =?utf-8?B?TzVuVnJyVFl4dEQrQjNGbzBtRzBEbFd6ZlNKNGF0NllSUFNlREJhUGV3czJ2?=
 =?utf-8?B?TVF4d1ZJLzVJQkxkY3FpWjBSUGJySEFFei94Vmk4Y3BkWmVHakIyeGlzenhH?=
 =?utf-8?B?ZzEzWDBFcFowVnRIUEhtVTZpQUxFcU9kTC95cC9OM2dDNDZDd1hwU1NrZkI0?=
 =?utf-8?B?NlpnV1BqY2sraktCUXdkdG55UXZYbTB5bnRGWjVFQVdsK0NKMnhkQkw0MjJn?=
 =?utf-8?B?OWhXM2kzTm5qZ3dtem8yWGtyMlBqajZoZzRxNDJ2Y3hhRW5uYVZEWnprVG5V?=
 =?utf-8?B?dDhORG9uMUZqWjU2WUlLK1JRcU4wbW00bDB3MzlZQVZZUzNPeVpKQVNITTVR?=
 =?utf-8?B?WGtoSVh3d0FGaVZvNEJmbHZlS0F6V2UzNUxJeVVXMjljbUcwcnRIeE5TVCtZ?=
 =?utf-8?B?a0JkVTA3NVdURUxaRmFSRWRLWTBBUUUyUTByNmpnK0FSWHFnMU91dTB1NHhS?=
 =?utf-8?Q?Yu0/ZHykeOPRk?=
X-Forefront-Antispam-Report: CIP:20.208.138.155; CTRY:CH; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mx3.crn.activeguard.cloud; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230031)(36860700004)(82310400017)(376005)(35042699013)(1800799015);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 10:09:25.9411 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15db8cee-21ae-4ed4-2126-08dc8159c06f
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19; Ip=[20.208.138.155];
 Helo=[mx3.crn.activeguard.cloud]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0002
X-Mailman-Approved-At: Fri, 31 May 2024 14:46:11 +0200
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

Q3VycmVudGx5LCBpZiB0aGUgZW52aXJvbm1lbnQgaXMgbm90IGluIHRoZSBjdXJyZW50IGJvb3Qg
bWVkaWEsIHRoZQ0KZW52X2dldF9sb2NhdGlvbigpIGlzIHJldHVybmluZyBFTlZMX1VOS05PV04g
b3IgRU5WTF9OT1dIRVJFIHdoaWNoDQppcyBub3QgdHJ1ZSAoaS5lIGJvb3RpbmcgZnJvbSBGTEFT
SCB3aXRoIGVudmlyb25tZW50IGluIGVNTUMpLiBUaGlzDQpjb21taXQgYWRkcyBhbiBleHRyYSBj
aGVjayB0byBmaW5kIHRoZSBlbnZpcm9ubWVudCBpbiB0aGUgb3RoZXINCnN1cHBvcnRlZCBib290
IG1lZGlhLCBrZWVwaW5nIHRoZSBzYW1lIHByaW9yaXR5IGFzIG9mIG5vdy4NCg0KU2lnbmVkLW9m
Zi1ieTogVmFzaWxlaW9zIEFtb2lyaWRpcyA8dmFzaWxlaW9zLmFtb2lyaWRpc0BjZXJuLmNoPg0K
LS0tDQogYm9hcmQveGlsaW54L3ZlcnNhbC1uZXQvYm9hcmQuYyB8IDQ3ICsrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0NCiBib2FyZC94aWxpbngvdmVyc2FsL2JvYXJkLmMgICAgIHwgNDcgKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIGJvYXJkL3hpbGlueC96eW5xL2JvYXJkLmMgICAg
ICAgfCA0OSArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLQ0KIGJvYXJkL3hpbGlueC96eW5x
bXAvenlucW1wLmMgICAgfCA1NSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0NCiA0
IGZpbGVzIGNoYW5nZWQsIDEwMSBpbnNlcnRpb25zKCspLCA5NyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2JvYXJkL3hpbGlueC92ZXJzYWwtbmV0L2JvYXJkLmMgYi9ib2FyZC94aWxpbngv
dmVyc2FsLW5ldC9ib2FyZC5jDQppbmRleCBkYTAzMDI0ZTE2Li41Mjk1MjIxYWFhIDEwMDY0NA0K
LS0tIGEvYm9hcmQveGlsaW54L3ZlcnNhbC1uZXQvYm9hcmQuYw0KKysrIGIvYm9hcmQveGlsaW54
L3ZlcnNhbC1uZXQvYm9hcmQuYw0KQEAgLTM3NywyOSArMzc3LDMwIEBAIGVudW0gZW52X2xvY2F0
aW9uIGVudl9nZXRfbG9jYXRpb24oZW51bSBlbnZfb3BlcmF0aW9uIG9wLCBpbnQgcHJpbykNCiB7
DQogCXU4IGJvb3Rtb2RlID0gdmVyc2FsX25ldF9nZXRfYm9vdG1vZGUoKTsNCiANCi0JaWYgKHBy
aW8pDQotCQlyZXR1cm4gRU5WTF9VTktOT1dOOw0KLQ0KLQlzd2l0Y2ggKGJvb3Rtb2RlKSB7DQot
CWNhc2UgRU1NQ19NT0RFOg0KLQljYXNlIFNEX01PREU6DQotCWNhc2UgU0QxX0xTSEZUX01PREU6
DQotCWNhc2UgU0RfTU9ERTE6DQotCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfRU5WX0lTX0lOX0ZB
VCkpDQotCQkJcmV0dXJuIEVOVkxfRkFUOw0KLQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9J
U19JTl9FWFQ0KSkNCi0JCQlyZXR1cm4gRU5WTF9FWFQ0Ow0KLQkJcmV0dXJuIEVOVkxfTk9XSEVS
RTsNCi0JY2FzZSBPU1BJX01PREU6DQotCWNhc2UgUVNQSV9NT0RFXzI0QklUOg0KLQljYXNlIFFT
UElfTU9ERV8zMkJJVDoNCi0JCWlmIChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fU1BJX0ZM
QVNIKSkNCi0JCQlyZXR1cm4gRU5WTF9TUElfRkxBU0g7DQotCQlyZXR1cm4gRU5WTF9OT1dIRVJF
Ow0KLQljYXNlIEpUQUdfTU9ERToNCi0JY2FzZSBTRUxFQ1RNQVBfTU9ERToNCi0JZGVmYXVsdDoN
Ci0JCXJldHVybiBFTlZMX05PV0hFUkU7DQorCWlmICghcHJpbykgew0KKwkJc3dpdGNoIChib290
bW9kZSkgew0KKwkJY2FzZSBFTU1DX01PREU6DQorCQljYXNlIFNEX01PREU6DQorCQljYXNlIFNE
MV9MU0hGVF9NT0RFOg0KKwkJY2FzZSBTRF9NT0RFMToNCisJCQlpZiAoSVNfRU5BQkxFRChDT05G
SUdfRU5WX0lTX0lOX0ZBVCkpDQorCQkJCXJldHVybiBFTlZMX0ZBVDsNCisJCQlpZiAoSVNfRU5B
QkxFRChDT05GSUdfRU5WX0lTX0lOX0VYVDQpKQ0KKwkJCQlyZXR1cm4gRU5WTF9FWFQ0Ow0KKwkJ
CWJyZWFrOw0KKwkJY2FzZSBPU1BJX01PREU6DQorCQljYXNlIFFTUElfTU9ERV8yNEJJVDoNCisJ
CWNhc2UgUVNQSV9NT0RFXzMyQklUOg0KKwkJCWlmIChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNf
SU5fU1BJX0ZMQVNIKSkNCisJCQkJcmV0dXJuIEVOVkxfU1BJX0ZMQVNIOw0KKwkJCWJyZWFrOw0K
KwkJY2FzZSBKVEFHX01PREU6DQorCQljYXNlIFNFTEVDVE1BUF9NT0RFOg0KKwkJZGVmYXVsdDoN
CisJCQlyZXR1cm4gRU5WTF9OT1dIRVJFOw0KKwkJfQ0KIAl9DQorDQorCXJldHVybiBhcmNoX2Vu
dl9nZXRfbG9jYXRpb24ob3AsIHByaW8pOw0KIH0NCiAjZW5kaWYNCmRpZmYgLS1naXQgYS9ib2Fy
ZC94aWxpbngvdmVyc2FsL2JvYXJkLmMgYi9ib2FyZC94aWxpbngvdmVyc2FsL2JvYXJkLmMNCmlu
ZGV4IDRmNmQ1NjExOWQuLjQyMDFjM2UyZWYgMTAwNjQ0DQotLS0gYS9ib2FyZC94aWxpbngvdmVy
c2FsL2JvYXJkLmMNCisrKyBiL2JvYXJkL3hpbGlueC92ZXJzYWwvYm9hcmQuYw0KQEAgLTI5Niwy
OSArMjk2LDMwIEBAIGVudW0gZW52X2xvY2F0aW9uIGVudl9nZXRfbG9jYXRpb24oZW51bSBlbnZf
b3BlcmF0aW9uIG9wLCBpbnQgcHJpbykNCiB7DQogCXUzMiBib290bW9kZSA9IHZlcnNhbF9nZXRf
Ym9vdG1vZGUoKTsNCiANCi0JaWYgKHByaW8pDQotCQlyZXR1cm4gRU5WTF9VTktOT1dOOw0KLQ0K
LQlzd2l0Y2ggKGJvb3Rtb2RlKSB7DQotCWNhc2UgRU1NQ19NT0RFOg0KLQljYXNlIFNEX01PREU6
DQotCWNhc2UgU0QxX0xTSEZUX01PREU6DQotCWNhc2UgU0RfTU9ERTE6DQotCQlpZiAoSVNfRU5B
QkxFRChDT05GSUdfRU5WX0lTX0lOX0ZBVCkpDQotCQkJcmV0dXJuIEVOVkxfRkFUOw0KLQkJaWYg
KElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9FWFQ0KSkNCi0JCQlyZXR1cm4gRU5WTF9FWFQ0
Ow0KLQkJcmV0dXJuIEVOVkxfTk9XSEVSRTsNCi0JY2FzZSBPU1BJX01PREU6DQotCWNhc2UgUVNQ
SV9NT0RFXzI0QklUOg0KLQljYXNlIFFTUElfTU9ERV8zMkJJVDoNCi0JCWlmIChJU19FTkFCTEVE
KENPTkZJR19FTlZfSVNfSU5fU1BJX0ZMQVNIKSkNCi0JCQlyZXR1cm4gRU5WTF9TUElfRkxBU0g7
DQotCQlyZXR1cm4gRU5WTF9OT1dIRVJFOw0KLQljYXNlIEpUQUdfTU9ERToNCi0JY2FzZSBTRUxF
Q1RNQVBfTU9ERToNCi0JZGVmYXVsdDoNCi0JCXJldHVybiBFTlZMX05PV0hFUkU7DQorCWlmICgh
cHJpbykgew0KKwkJc3dpdGNoIChib290bW9kZSkgew0KKwkJY2FzZSBFTU1DX01PREU6DQorCQlj
YXNlIFNEX01PREU6DQorCQljYXNlIFNEMV9MU0hGVF9NT0RFOg0KKwkJY2FzZSBTRF9NT0RFMToN
CisJCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfRU5WX0lTX0lOX0ZBVCkpDQorCQkJCXJldHVybiBF
TlZMX0ZBVDsNCisJCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfRU5WX0lTX0lOX0VYVDQpKQ0KKwkJ
CQlyZXR1cm4gRU5WTF9FWFQ0Ow0KKwkJCWJyZWFrOw0KKwkJY2FzZSBPU1BJX01PREU6DQorCQlj
YXNlIFFTUElfTU9ERV8yNEJJVDoNCisJCWNhc2UgUVNQSV9NT0RFXzMyQklUOg0KKwkJCWlmIChJ
U19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fU1BJX0ZMQVNIKSkNCisJCQkJcmV0dXJuIEVOVkxf
U1BJX0ZMQVNIOw0KKwkJCWJyZWFrOw0KKwkJY2FzZSBKVEFHX01PREU6DQorCQljYXNlIFNFTEVD
VE1BUF9NT0RFOg0KKwkJZGVmYXVsdDoNCisJCQlyZXR1cm4gRU5WTF9OT1dIRVJFOw0KKwkJfQ0K
IAl9DQorDQorCXJldHVybiBhcmNoX2Vudl9nZXRfbG9jYXRpb24ob3AsIHByaW8pOw0KIH0NCiAj
ZW5kaWYNCmRpZmYgLS1naXQgYS9ib2FyZC94aWxpbngvenlucS9ib2FyZC5jIGIvYm9hcmQveGls
aW54L3p5bnEvYm9hcmQuYw0KaW5kZXggNmMzNjU5MTAwMS4uNGM5OTIzZGUxOCAxMDA2NDQNCi0t
LSBhL2JvYXJkL3hpbGlueC96eW5xL2JvYXJkLmMNCisrKyBiL2JvYXJkL3hpbGlueC96eW5xL2Jv
YXJkLmMNCkBAIC0xMzgsMzEgKzEzOCwzMiBAQCBlbnVtIGVudl9sb2NhdGlvbiBlbnZfZ2V0X2xv
Y2F0aW9uKGVudW0gZW52X29wZXJhdGlvbiBvcCwgaW50IHByaW8pDQogew0KIAl1MzIgYm9vdG1v
ZGUgPSB6eW5xX3NsY3JfZ2V0X2Jvb3RfbW9kZSgpICYgWllOUV9CTV9NQVNLOw0KIA0KLQlpZiAo
cHJpbykNCi0JCXJldHVybiBFTlZMX1VOS05PV047DQotDQotCXN3aXRjaCAoYm9vdG1vZGUpIHsN
Ci0JY2FzZSBaWU5RX0JNX1NEOg0KLQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9G
QVQpKQ0KLQkJCXJldHVybiBFTlZMX0ZBVDsNCi0JCWlmIChJU19FTkFCTEVEKENPTkZJR19FTlZf
SVNfSU5fRVhUNCkpDQotCQkJcmV0dXJuIEVOVkxfRVhUNDsNCi0JCXJldHVybiBFTlZMX05PV0hF
UkU7DQotCWNhc2UgWllOUV9CTV9OQU5EOg0KLQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9J
U19JTl9OQU5EKSkNCi0JCQlyZXR1cm4gRU5WTF9OQU5EOw0KLQkJaWYgKElTX0VOQUJMRUQoQ09O
RklHX0VOVl9JU19JTl9VQkkpKQ0KLQkJCXJldHVybiBFTlZMX1VCSTsNCi0JCXJldHVybiBFTlZM
X05PV0hFUkU7DQotCWNhc2UgWllOUV9CTV9OT1I6DQotCWNhc2UgWllOUV9CTV9RU1BJOg0KLQkJ
aWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9TUElfRkxBU0gpKQ0KLQkJCXJldHVybiBF
TlZMX1NQSV9GTEFTSDsNCi0JCXJldHVybiBFTlZMX05PV0hFUkU7DQotCWNhc2UgWllOUV9CTV9K
VEFHOg0KLQlkZWZhdWx0Og0KLQkJcmV0dXJuIEVOVkxfTk9XSEVSRTsNCisJaWYgKCFwcmlvKSB7
DQorCQlzd2l0Y2ggKGJvb3Rtb2RlKSB7DQorCQljYXNlIFpZTlFfQk1fU0Q6DQorCQkJaWYgKElT
X0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9GQVQpKQ0KKwkJCQlyZXR1cm4gRU5WTF9GQVQ7DQor
CQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9FWFQ0KSkNCisJCQkJcmV0dXJuIEVO
VkxfRVhUNDsNCisJCQlicmVhazsNCisJCWNhc2UgWllOUV9CTV9OQU5EOg0KKwkJCWlmIChJU19F
TkFCTEVEKENPTkZJR19FTlZfSVNfSU5fTkFORCkpDQorCQkJCXJldHVybiBFTlZMX05BTkQ7DQor
CQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9VQkkpKQ0KKwkJCQlyZXR1cm4gRU5W
TF9VQkk7DQorCQkJYnJlYWs7DQorCQljYXNlIFpZTlFfQk1fTk9SOg0KKwkJY2FzZSBaWU5RX0JN
X1FTUEk6DQorCQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9TUElfRkxBU0gpKQ0K
KwkJCQlyZXR1cm4gRU5WTF9TUElfRkxBU0g7DQorCQkJYnJlYWs7DQorCQljYXNlIFpZTlFfQk1f
SlRBRzoNCisJCWRlZmF1bHQ6DQorCQkJcmV0dXJuIEVOVkxfTk9XSEVSRTsNCisJCX0NCiAJfQ0K
Kw0KKwlyZXR1cm4gYXJjaF9lbnZfZ2V0X2xvY2F0aW9uKG9wLCBwcmlvKTsNCiB9DQogDQogI2lm
IGRlZmluZWQoQ09ORklHX1NFVF9ERlVfQUxUX0lORk8pDQpkaWZmIC0tZ2l0IGEvYm9hcmQveGls
aW54L3p5bnFtcC96eW5xbXAuYyBiL2JvYXJkL3hpbGlueC96eW5xbXAvenlucW1wLmMNCmluZGV4
IGYzNzBmYjczNDcuLmI2MTA2NjhkMjggMTAwNjQ0DQotLS0gYS9ib2FyZC94aWxpbngvenlucW1w
L3p5bnFtcC5jDQorKysgYi9ib2FyZC94aWxpbngvenlucW1wL3p5bnFtcC5jDQpAQCAtNTkzLDM0
ICs1OTMsMzUgQEAgZW51bSBlbnZfbG9jYXRpb24gZW52X2dldF9sb2NhdGlvbihlbnVtIGVudl9v
cGVyYXRpb24gb3AsIGludCBwcmlvKQ0KIHsNCiAJdTMyIGJvb3Rtb2RlID0genlucW1wX2dldF9i
b290bW9kZSgpOw0KIA0KLQlpZiAocHJpbykNCi0JCXJldHVybiBFTlZMX1VOS05PV047DQotDQot
CXN3aXRjaCAoYm9vdG1vZGUpIHsNCi0JY2FzZSBFTU1DX01PREU6DQotCWNhc2UgU0RfTU9ERToN
Ci0JY2FzZSBTRDFfTFNIRlRfTU9ERToNCi0JY2FzZSBTRF9NT0RFMToNCi0JCWlmIChJU19FTkFC
TEVEKENPTkZJR19FTlZfSVNfSU5fRkFUKSkNCi0JCQlyZXR1cm4gRU5WTF9GQVQ7DQotCQlpZiAo
SVNfRU5BQkxFRChDT05GSUdfRU5WX0lTX0lOX0VYVDQpKQ0KLQkJCXJldHVybiBFTlZMX0VYVDQ7
DQotCQlyZXR1cm4gRU5WTF9OT1dIRVJFOw0KLQljYXNlIE5BTkRfTU9ERToNCi0JCWlmIChJU19F
TkFCTEVEKENPTkZJR19FTlZfSVNfSU5fTkFORCkpDQotCQkJcmV0dXJuIEVOVkxfTkFORDsNCi0J
CWlmIChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fVUJJKSkNCi0JCQlyZXR1cm4gRU5WTF9V
Qkk7DQotCQlyZXR1cm4gRU5WTF9OT1dIRVJFOw0KLQljYXNlIFFTUElfTU9ERV8yNEJJVDoNCi0J
Y2FzZSBRU1BJX01PREVfMzJCSVQ6DQotCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfRU5WX0lTX0lO
X1NQSV9GTEFTSCkpDQotCQkJcmV0dXJuIEVOVkxfU1BJX0ZMQVNIOw0KLQkJcmV0dXJuIEVOVkxf
Tk9XSEVSRTsNCi0JY2FzZSBKVEFHX01PREU6DQotCWRlZmF1bHQ6DQotCQlyZXR1cm4gRU5WTF9O
T1dIRVJFOw0KKwlpZiAoIXByaW8pIHsNCisJCXN3aXRjaCAoYm9vdG1vZGUpIHsNCisJCWNhc2Ug
RU1NQ19NT0RFOg0KKwkJY2FzZSBTRF9NT0RFOg0KKwkJY2FzZSBTRDFfTFNIRlRfTU9ERToNCisJ
CWNhc2UgU0RfTU9ERTE6DQorCQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19JTl9GQVQp
KQ0KKwkJCQlyZXR1cm4gRU5WTF9GQVQ7DQorCQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9J
U19JTl9FWFQ0KSkNCisJCQkJcmV0dXJuIEVOVkxfRVhUNDsNCisJCQlicmVhazsNCisJCWNhc2Ug
TkFORF9NT0RFOg0KKwkJCWlmIChJU19FTkFCTEVEKENPTkZJR19FTlZfSVNfSU5fTkFORCkpDQor
CQkJCXJldHVybiBFTlZMX05BTkQ7DQorCQkJaWYgKElTX0VOQUJMRUQoQ09ORklHX0VOVl9JU19J
Tl9VQkkpKQ0KKwkJCQlyZXR1cm4gRU5WTF9VQkk7DQorCQkJYnJlYWs7DQorCQljYXNlIFFTUElf
TU9ERV8yNEJJVDoNCisJCWNhc2UgUVNQSV9NT0RFXzMyQklUOg0KKwkJCWlmIChJU19FTkFCTEVE
KENPTkZJR19FTlZfSVNfSU5fU1BJX0ZMQVNIKSkNCisJCQkJcmV0dXJuIEVOVkxfU1BJX0ZMQVNI
Ow0KKwkJCWJyZWFrOw0KKwkJY2FzZSBKVEFHX01PREU6DQorCQlkZWZhdWx0Og0KKwkJCXJldHVy
biBFTlZMX05PV0hFUkU7DQorCQl9DQogCX0NCisNCisJcmV0dXJuIGFyY2hfZW52X2dldF9sb2Nh
dGlvbihvcCwgcHJpbyk7DQogfQ0KICNlbmRpZg0KIA0KDQpiYXNlLWNvbW1pdDogYTdmMDE1NGM0
MTI4NTkzMjMzOTYxMTFkZDBjMDlkYmFmYmMxNTNjYg0KLS0gDQoyLjM0LjENCg0KDQo=

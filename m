Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C5AC0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 10:30:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF5F181877;
	Wed, 29 Jan 2025 11:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="H7QZHw2c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 940C981276; Wed, 29 Jan 2025 11:30:19 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 100CB81101
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 11:30:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pdley9FWNnExE1K/gRySGO+2wA3RokbTY7y01dtmFtS5QquDSf3QUNRkMY/4NvtzRarmPaNIDZub3KKVtPYPAmKesjGVWohSFjqq3lHbM9G0cnZCB/8CMwwacvtUEimSzu6qkkUHk9n2HrmAC1NkJ3WLLQ+8J6dJJtJotC84CchO1amrk/KqDzn23k/5sBoTbWInyO5esKAgcHaevEHEkarh8CnGeMEAOqpVAsKQZ3shoXNJe2psQER1I74F8t1NvyxlG6qIVPKACbV3pjWadWf/vgAEQMLP9wv5O1adwhygWhZXCbPFwez43HQwj5rQUe/T0IPCcv5j0bx8vMTT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5QRtQVRuZOq+atAP0CtMbmVRd+ChgHq9rHuiAwcOo4=;
 b=C52DS04BfOo2W7FnFroivy3c60BHj/k1raMv9dJ+BuRznRdNEiJ/lTxBc2DrepjJ9/H22KGYvaZYe/AxxumsqY7SUpaQVj7CNPZ3qPyLhra0iq9Zw6xQvUI/5ijcEKX8x0TUB74/8Tpt45VFG1ehTm/qtScAyW02SrjowEQfogtxCEu7vqgQSSSLq6TvxVw+/wyjU0PE48E6d+wAgyl+gnGW9lQSJ5/gchJ9SnCgTTlHe2rk8771Eptlf0cP+gr6E2jnIS0X/3N0ci8g4fjdNzy3h4L/h3hVtLxRI0cypQ08gB8Em4ipCl2qiRG8ZezH9hFKd1vFHkvE7g7YoX9BwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5QRtQVRuZOq+atAP0CtMbmVRd+ChgHq9rHuiAwcOo4=;
 b=H7QZHw2cMs3efgMK39NU641O/mGAQuLmhlTutz0u8pTvGqPBGlUb4xYefK50V3zJpdM63nviByFrjY1UXCrCe3+K6LQ/9OEW3uPSIIem1HAFpFwsaeyxoLuQ/I1F0TVVd1tnV7pXshYgWfaH4BXCEg3KQ9bG3RoZjCKiUvusR3ak12avbarmrmHVa7qJTiMYJHoYq9VV2WztWJ40G52JRgF3I/oPJYwd0OVBzYJ8KjiVqLbIiaUaV2rwHz9CqP1F4ixdWJWXLdKgrj56Jaf/YEUK5DdlIrB0Vs7NMi2kh3Zj7Hb0qx5J5w3GqIHvhgt+fzjd7PDGYEiKAFFW1avA+w==
Received: from AS9PR06CA0177.eurprd06.prod.outlook.com (2603:10a6:20b:45c::34)
 by GV2P195MB2331.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 10:30:11 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:45c:cafe::2d) by AS9PR06CA0177.outlook.office365.com
 (2603:10a6:20b:45c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.17 via Frontend Transport; Wed,
 29 Jan 2025 10:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 29 Jan 2025 10:30:10 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
Received: from lws-moog.phytec.de (172.25.32.60) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 29 Jan
 2025 11:30:10 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH RFC 0/6] Fix handling of optional blobs in binman
Date: Wed, 29 Jan 2025 11:29:45 +0100
Message-ID: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABkDmmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDQyMj3aTMvNzEvPi0xOzUlPj8ghKg+sQcXVOgdJq5gYlZqpGpElBvQVF
 qWmYF2NxopSA3Z6XY2loAtSsgs2wAAAA=
To: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>
CC: Fabio Estevam <festevam@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Benjamin Hahn <b.hahn@phytec.de>, Teresa Remmet <t.remmet@phytec.de>,
 Yashwanth Varakala <y.varakala@phytec.de>, <upstream@lists.phytec.de>,
 <u-boot@lists.denx.de>, Yannic Moog <y.moog@phytec.de>
X-Mailer: b4 0.14.1
X-Originating-IP: [172.25.32.60]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|GV2P195MB2331:EE_
X-MS-Office365-Filtering-Correlation-Id: ff5dd484-7b94-4d66-e4d5-08dd404fe8ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE9LOUcxZzlDbmtUU01GZ0RPQjAvZDVRL0NEdlBnMUpBZ0kyT01QdVdHTVcy?=
 =?utf-8?B?VUxpRVM4eUNjdjkwTEMyeVFvWEdsdm0zNTRuVXhUTnFXS1VKUXBOSm9aWEYv?=
 =?utf-8?B?SVlnd2wwL0VzWWloRElrdDFtVVh4azA5MDQ4ZFU1QkdOL3JPSkpiVHlTQVlK?=
 =?utf-8?B?aGhpdHNDZDhkMlNyZ1JKWUVjZE9sYVk1MEQ0R2dRZG52cTdGZGhVczQxSkpT?=
 =?utf-8?B?WkxpMTdzb0N0czZFN3BhWW5reDJHaXV6UEdWMllLRDVPbExpamNwNlBuZi9R?=
 =?utf-8?B?QWVDUzkybzEyclZOWWY5Y21Vd2tWMER1LzhZdXdzampxbXNBSnZpTHJucDJM?=
 =?utf-8?B?RlNxRG43blpTOURKZ1ZKR05HY2NTK2ZERjRSb2hIZmNKOHU1SDJ1Sm1MSWh2?=
 =?utf-8?B?ZGRtd3JQc1N5Z3V3WStBTWVhZ1RNVC9scFJsUXZscDlmdy9qc1JKWlg4aFY0?=
 =?utf-8?B?a2ZkbDNxRHhlaHNhNHhSRzY2Y2JzMVFYWDVibXgvWng2aUozZ0JyVHhNdVRo?=
 =?utf-8?B?OG5aUzc0cEtDclVkSGhPUUYwdHVHc1FLR2x1dHFzc0l6NFFESk1jSExOUjNv?=
 =?utf-8?B?UWJzUUg0VkQyYXpyOEFsbEo1V2lpQVZSK05wZVo4Z2tucTUwOC9EYTdsRi9m?=
 =?utf-8?B?ZVZETlB0TWtGbGxvYks4ek5UQlBTVW5kWmt1R2pBT2h4RjZ0a0VMeGRYLzF4?=
 =?utf-8?B?UHpLc0FFb2t4Zm90emZ4c2kzZk5nYUIwQkFlUkVqTk85OGV1cklDTXBtMU9j?=
 =?utf-8?B?di9SOHBBTGkxRUV5bCtVR0tuSUhKa0RuQURwa1A3OG5jVjBPa2Q2WHdlSDk0?=
 =?utf-8?B?Vk9nbGFUeDkyZWtaNk00VytvLy9BbkhyTzRVQnpkdEM5QzBSR3RsalJ5c0ho?=
 =?utf-8?B?Q3ZPUmN1SXRha3BncTNJQ29mUUtFKy9BUE42cWFkRFlkZ3VEeHJGWGFoWjRN?=
 =?utf-8?B?QTlVaUxYUmpoV3JobDVnOTJQMjJPVXZSQmtIeFZrbSt4ZjNmLzJ3bmI2YTl1?=
 =?utf-8?B?VVR2bVRnWXpCdDdSY21OT2ErbXpac2oyN0hMZko0OTU0MlVKRUgzSk1iSEs4?=
 =?utf-8?B?TmdUbzNRNFFRZDhvSUxuTEo1NzZwcXRKNTlRaHg2cGVpb29ERG1TdUNPd3Ar?=
 =?utf-8?B?Q3ZMcWhWQlVKMHp1b1hHdkI4VERZNFhtZUpKM1NqbHAwK2VmSjJIWVdhR2FO?=
 =?utf-8?B?cnhOM09IdlVwZFRGaDZiaCtwQzZxSHEvOE0rTE5mS2dYL05JOGZJZzllYUdV?=
 =?utf-8?B?cFZkaTVxNEQzWkdqQXNmUVhnVkV0VHNOU2JNUnB3NEpMTVZ0TUUrbTNxb0wy?=
 =?utf-8?B?U3dDc2drQVJ3NE9KMlF3eVBPblNMd0p5WlBjeGRMRXNEanMwVG0xbUZQUTlt?=
 =?utf-8?B?R09UV3NhWEEzY3J4amhSN01zaGYraXRJOU9iWGhaemR3YU5oS0hsdTc4NjFH?=
 =?utf-8?B?SlFOTHI3M2FSYVRCcE9aL2hDQ3pyd3RUMUxna1NnOVU2VWFZTEt5SysxUHF4?=
 =?utf-8?B?U1dxMUVOWWVtR1IzcW50U2N3WEtjM2Faa1FWNGp1djlxRFdVVG1EbU9QeFJO?=
 =?utf-8?B?WUdPSCt1bnFiTE9acWExcTJBbXVkN2JNZncyMkMzMUpBMURsa1pybHdQOVJB?=
 =?utf-8?B?eklLb2ZyWTJoK2JSb2VScUdnRGpxWVlaUkJaRWhXdUY3bnVodXBUaGRjcTl3?=
 =?utf-8?B?dTZTeGRnZWpqQTZTUVNiTytsTFplUXJVTzBQMXl5ZFRnN1dZT0hoKys1Yjlv?=
 =?utf-8?B?QU12VTV3N01mV0N3aHFybkZOYnVtWTNaTy9LWVFIREY0ZVF2NGc0QldIMWJj?=
 =?utf-8?B?SWZJdXBJb283YWVYSlNEVlg0S1E2MjJrWUVIakhzZXVSTkY5akZGTDc0K1gw?=
 =?utf-8?B?aVo3RjFkSVRGWDNoNjRhdytQZllIckh3RjZlZzFHK245b3BIYkllaU8vZVpL?=
 =?utf-8?B?K3hvQzhSd3JhU0wrR2d4TGFxV1h6V1RiTXlJMTBqaElBWHBKM2pkL3d6TldS?=
 =?utf-8?Q?Vb6KfkfhsRjpnufv3pAegMkQG7Thg0=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 10:30:10.8633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff5dd484-7b94-4d66-e4d5-08dd404fe8ce
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2331
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

This series solves a contradiction regarding ext blobs packaged in
binman. When they are marked as optional, by default they are faked, two
messages are emitted. One says the image is not functional the other
says the image is still functional. Both concern the same binman
entry/blob. To solve this, don't emit a warning when an image is faked
AND optional.
Make binman tests consistent with this behaviour.
Add regex to test cases checking that the non-functional
message is indeed not emitted. Update the documentation to inform users
of this interaction.

Binman is set up to have fake external blobs in case they are missing.
This is regardless on whether they are optional or not.
The implementation does not allow different types of entries to override
the faking decision; at least there wouldn't be much sense in doing so.

Here is an example build output of a phycore-imx8mp:

  BINMAN  .binman_stamp
Image 'image' is missing optional external blobs but is still functional: tee-os

/binman/section/fit/images/tee/tee-os (tee.bin):
   See the documentation for your board. You may need to build Open Portable
   Trusted Execution Environment (OP-TEE) and build with TEE=/path/to/tee.bin

Image 'image' has faked optional external blobs and is still functional: tee.bin

  OFCHK   .config

The first patch makes binman test with --fake_ext_blobs by default to be
consistent with the default make target when building U-Boot. This
exposes an error as one test is failing where it should not (loadables).
Then, fix some tests that must not fake ext blobs and thus failed due to
the change.
Further, fix the behaviour of binman itself as explained above. Fixing
this bug also makes the loadables test pass again.
Finally, add test coverage for this new case and extend the
documentation.

---
Yannic Moog (6):
      tools: binman: ftest.py: fake ext blobs per default
      tools: binman: ftest: pass allow_fake_blob to _DoReadFileDtb
      tools: binman: ftest: fix tests that require non-faked ext blobs
      binman: fix faked optional entry handling
      binman: test: assert optional blobs don't cause non-functionality
      binman: doc: update Optional entries

 tools/binman/binman.rst |  9 ++++++++-
 tools/binman/control.py | 19 ++++++++++++++++---
 tools/binman/ftest.py   | 43 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 56 insertions(+), 15 deletions(-)
---
base-commit: a2b489b170f8382f746202c36616eaf2bc38fe86
change-id: 20250122-binman_faked_optional-5025f7046e25

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>


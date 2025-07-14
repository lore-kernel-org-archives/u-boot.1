Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E017C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 13:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2D7583045;
	Mon, 14 Jul 2025 15:31:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tABOg6hD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6410A83055; Mon, 14 Jul 2025 15:31:13 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20712.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::712])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7685A83022
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 15:31:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U9TueiunCgMlIvB/dHBlcfHLnt/Y/FXXd42JqdhVrGi2BU2/h6jeHnr5pfa0DcHY+mWFohix9NsXoIQGVJoubFuQUbHRDuLY4Acrbvi1LWd1S27hsQnXc+NzS67Upeq7IgO86id7c3P1pzJnMopty0wqjCdF/TjEcqsYSroBMBlggjoHL5V0qCAXZevaWNi1okV8/gWo9lct/WesVHXgAX5mQf3SG0/xQ1gTmVBtMiqiZVnrOLE2Ty4Y8B058hkYRw7hyhLiNbEybCPZ6j3T7tLleCo0UVw4uv2w/ki7poaph+bGqxY1mmR4Djv/8sGqv/EoIEfeXIM3VHVe/VnaiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYCOXDfkFpMrlUmqBLskXBhqJqV3ueMGzSJVqvdZP7E=;
 b=ccn5d8g+jRYd8HdHI1pE1DoRD9+eZKGE3PMSxvdJueqIK06ELVSFpympNf+ME9P1/YBngsOGfTmN5PYzTQFdBJFcQRWmYfTYyLomcyPnbLb4MmiV8diDFKLcTTd3CoHA6FI8t6n8k1nCjWkNjJGMR5LJ3Px+C2IMWmEzJT+ZUoFEADs6zxG2kiT2Gy02LJMylApIKFp8xtqeZhj/DBIJz2FPIe7DqDdOvF2DDcyw7PbOEUBX35qN4P8A/VrpWh4c4IL+aDVwtdvh8PCbIEQFKRv1+3orTQYIZrDD9Ik7tooPKbK7PRSbx59RhVPcjQAA86ujS05xN33bc4nHvB39Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYCOXDfkFpMrlUmqBLskXBhqJqV3ueMGzSJVqvdZP7E=;
 b=tABOg6hDimlWA66jI1CHmyuIB1A13P9uWsWvI10K1RA1d4TITXfG5XHyb06B8XWJtkvSwMHAvnwAgb2xsqE5Bk54d9w190vfvG4aUE6IYkY3HgFHlHgKdRvKe7B6CyG9CKi6qY4xc2bGFypbIk3+irVXXLvhcjqTH1Y+//Q0gSp3JD4lZaqnM/jRmRjjwkUksKM6xIt7/91CCGXkISwCJLCUAZdQgi/CkTDj327kS97TPHEonEclkz66d/bj/I5DM3MWQvCwBmukq3VMLVGd1Tmn0kPicqZj17GCsAO0FXbObGf8KnePsDHpAeeTO5vkP/aaHg7egCpLBDjXf168Uw==
Received: from PR1P264CA0097.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2cf::12)
 by DB8P195MB0614.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:158::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 13:31:08 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:102:2cf:cafe::e) by PR1P264CA0097.outlook.office365.com
 (2603:10a6:102:2cf::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 13:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 13:31:08 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:08 +0200
Received: from [127.0.1.1] (172.25.39.83) by Florix.phytec.de (172.25.0.13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 14 Jul
 2025 15:31:07 +0200
From: Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH 0/3] bootstd: rauc: Small fixes
Date: Mon, 14 Jul 2025 15:30:07 +0200
Message-ID: <20250714-wip-bootmeth-rauc-fixes-v1-0-69d2b80e7606@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF8GdWgC/x3L3QpAQBCG4VvRHJuyI5FbkYPFhzlgteuv5N5tD
 p/e3ocCvCJQnTzkcWpQt0aYNKF+tusE1iGaJJMiK43hSzfunNsX7DN7e/Q86o3AkE5KGS3yvKJ
 4bx5/iHPTvu8HT6n6jmkAAAA=
X-Change-ID: 20250711-wip-bootmeth-rauc-fixes-e2b272fae338
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, "Wadim
 Egorov" <w.egorov@phytec.de>
CC: Leonard Anderweit <l.anderweit@phytec.de>, <u-boot@lists.denx.de>, "Martin
 Schwan" <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.39.83]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000198:EE_|DB8P195MB0614:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ff318f9-e6d0-4e6f-3bcb-08ddc2dab0f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGw4aDBuYldpM3V0WHoxL3NYd0JXNlZEV1lzUmRRaGhLT29iTkp1dWVFUFhw?=
 =?utf-8?B?ay9jSkRHQk5jTHY5aEpIZ282cjBTeVQzcjFlcGcyMWtWRUpTcmREYWZRRU4x?=
 =?utf-8?B?ODhRMS9DSldVRUhmTnBqWlZzTXp5MFFMZ1A2NVV2VmpGU1hIRXNWSDdXcXkv?=
 =?utf-8?B?NGg1V2g1ZzNYSUV4UWhxdlJBRldLNVZRa3Y4R2o4emNZK3l1TmtLck96MlQv?=
 =?utf-8?B?czNWNmlmUVcwbEVJa3FaYzhzN05ZTU5sdjBOYzlSNFhuRVFTakJxOGlWSVNJ?=
 =?utf-8?B?dVNpckJ1S3FBSUtrVzA3TDNOZ0h4WC9hajRDU21HWXhCZnFOT2tOTk5Ua2RW?=
 =?utf-8?B?MTM1czA5V1BMMlpFRlA5Q0lpaTM0TFQrcnV6K0IwT3lRVkl3UyszRkc3ajV4?=
 =?utf-8?B?YkRZR0F4NFJmMlhDZWxhQW9oT3dlU0ZzeEtDQWg4VW5RYWlMSUJUU3drRGpO?=
 =?utf-8?B?b2RXcnpxNG5WaXNTRWxaN0tyTlJRMnp3Z3BKbFROWUk0aDVyakJPRVhURDFE?=
 =?utf-8?B?OHQ4N0hHaUptdkpKRm1wc1dVMU1GT0d6TUV5RVlzQjkyaUFqU3dGeHljRGMv?=
 =?utf-8?B?eE51ZHpVWUQyNDJNQ2NDekE3TGtBU2I4RHA2QnpNRXcwQ1FiRnZpL0kyQlRK?=
 =?utf-8?B?MWF4T040Q3JKNTdWRkZDZjl3WURTa1ZXZEtVNFk3RmRZTE5sTmZRdUxNSzEr?=
 =?utf-8?B?U3Q2bnBsb3dFd0ZCdjA1bytMeVpURzI3eTlwTlVqMUx1ZkVCelQ3QnhydENo?=
 =?utf-8?B?cDBiKzBzTTg5b2VUT1JzTldsMG5lTFdJd3BxOFZ3VGo0MEc3dGJzc0FtcnhB?=
 =?utf-8?B?M2wxdjkreDJxNmpsOHRXYjBIc2VnNFU4RzJybmw0dDM3YmU0a2dZNUZuYXBa?=
 =?utf-8?B?S1ZjMGZMVTVDZ0VVQkZUTkttWXVrSzltSS9UTXNLMlhRY1dBdlROa2NaUlpo?=
 =?utf-8?B?OGhHRGRBN2IvcFpYSnRkQTJhL3llNGFiSUJmZ1QweHV3dll1RzBTYXhMM0xt?=
 =?utf-8?B?em1BckUrL0RYUXM3Qm80NlpmSlhIYzNOWXJhYlk3WUR5V0VwOWUxczB4bFlt?=
 =?utf-8?B?REFYUFdnNTVsU3dKTHhVbUdPT05PZWUzbUZaUFBDY2pTV2licVJrMkR5SllE?=
 =?utf-8?B?Q3BEejVXSS9SWUlsQ2IwUXE0YlVlSVN1L2I5QXJ5Umpvc1hRRUg1MUdrc1Ft?=
 =?utf-8?B?R0I3MUVpeEtjT1hpOFdDZ3BhSldiTmdDdmhRbWFXTXlNZGExbzlDNllrRC9W?=
 =?utf-8?B?K0FnbFp2MTBoN2JoUUdkRkE4N25DRmxJdmVweWZBTXFtQStOVGlJd0JqUEE2?=
 =?utf-8?B?cTVzcERiVHg4TGJ4S3pZVlY3RThxNGJjT1hvOUxWWVJhVzVVWUxGWndTcmJv?=
 =?utf-8?B?Q05qWjhxSjFROWZCdVJHVHBLWmgxVXJWSHdOMEhtS0lHbGdMN2xDQTZISDVQ?=
 =?utf-8?B?eDlqNDBPbDdCeS9PUnNnaTBTUTdSMzRMQ3A3bUNqZ3UySy9tZFRCVEJyZ2lN?=
 =?utf-8?B?aVdmcUxTQkJ4UkNsZm53eGxXZng1MXo4T1JWVDIvSjloV0lyS2JzQVVtSTFx?=
 =?utf-8?B?dzdiR1ZUb3Njbnhib25ZMC8vR3ZNQ2E3NDRZVTAzdGxjZURRenZUSlk1eGJ2?=
 =?utf-8?B?b0I4WTVPb211NDB3WG9SVnBzckJSMWEyNWlxMFJhTGorV2tZaEp0WkxmQUNr?=
 =?utf-8?B?OVlsMUFSY09TL0Mxb3ltTzY0ejdWT243QWtSTFg2cTdQTEI5SHhYdnVIb3Iz?=
 =?utf-8?B?YjdmcUM3ZkVUNzZPK2Y3MUpyL05KQ2xIWVpnQVBLWW1sR2pkdnpadEZlWkkz?=
 =?utf-8?B?YkFkaXFFOGE1MEJ1dHlJeXVEckJSQ0lwY1QzZWZneWhDaEU1SkVyYTFkQlhq?=
 =?utf-8?B?eHk3QzVnUzN4aExwakxPZzc3c2tLT0VadVljV0xiRGgwaTVIN09KaDl2YURJ?=
 =?utf-8?B?TmRBUVhMRE5ncnVTLzZXZTFOS0NocnIvNWV6cFlsVS9NbUM3aGZFNUcyUnBS?=
 =?utf-8?B?bTk1bDFrd0xCcVV2S2p0d1VRb0ZSMVVlc3VkK1Rzd2tYMkp4TTdzQ3NUYXZ5?=
 =?utf-8?Q?qfMlst?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 13:31:08.3733 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff318f9-e6d0-4e6f-3bcb-08ddc2dab0f8
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0614
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

Fix some small bugs that I noticed during testing.

Signed-off-by: Martin Schwan <m.schwan@phytec.de>
---
Martin Schwan (3):
      bootstd: rauc: Fix potential memory leak
      bootstd: rauc: Fix segfault occurring during private struct access
      bootstd: rauc: Only scan all partitions instead of boot files

 boot/bootmeth_rauc.c | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)
---
base-commit: 6bb0679377abb01a82db1ce69b5bf1d40aa02ace
change-id: 20250711-wip-bootmeth-rauc-fixes-e2b272fae338

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>


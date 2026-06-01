Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A15C5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 03:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35F2D848F0;
	Tue,  2 Jun 2026 05:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="SAylWIsM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC71E848A5; Tue,  2 Jun 2026 00:48:27 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75ACF84898
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 00:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=mateusz.furdyna@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evZXKYnsrjdC79q6QL1TArazKI3KqXON+/QihPm43u01KokxiJNZXMv1lbWcuslK1ULO0Pqsnd2hcGDIRMEsGrU3HYu9Ynrb5IZUjrejOQ0QZCCO9xUmTe9frnq6WRnRcMSrqcqPs6fOExgYY1PeMwJh/KgpBS0zdcHOkbqbY1aKLkjKycCmVk8eM5S4Vf/oVmYpA/MrVIVq2NFPv6ntlMr0VizXao014IE8h6DA+guGz9UcKHZE0eFQ6k1zy2sCDSqT/d9PL+NlX9CaKF+cmukYEAa9hDOfMye5GubxugGKDRxVfjWowILSnJptmLeSbir8vPI9v/p6SEjDsXyLgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IS3KXe+Iv+iHmZnH5fty695PwQcNF6yw0tB4zS4S80=;
 b=i9N0Lt3o4jkS5sl8DQno4EY5COxnvWpZYMbohI+afCL4dnLkG24UFIYvd0650oYT8o6GuzFlKbSI38nB64gr6mEnVSMFlIO3O7bfkThU/Iu2GZPG0ckJZ9FaBb7HnPp4auT2ujKtw1w/NOieX9Qsb9RAOw7cvt/Y2qQfqtHsDZUfumoYkHSkkEFA/lR/Q8wmfta5iCXjZRiGP7z73BTCSuYY4QZYR9ImSB8smKsF1QlEPZnC9v1IP71ck7iErVeV+C+EiM53NJRL/Hp9mErouvBtMTbn4Ynwxn0K2E3Ptlpe+qUvdgSdzuzMkRtn7A2snul0e5sy3RWzDWA6a+KUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5IS3KXe+Iv+iHmZnH5fty695PwQcNF6yw0tB4zS4S80=;
 b=SAylWIsM/rNmlM+dkzNIScGWvdRIE5TGpit+Qq6amPInL+WrPexhn0SufpBh2UKrAYueDmUD2t4FtxdW+TcRzPK7rm8JWCGfRyykd5Q+qmJO0oShXZ3UWSrYJpzPznYH3X1j4QU1gkFTTonQsingC5cGBM9/IVshq6mujN5s8E9eqg1LTgc6C2yZAcJSGNR/l/3CQN1NjsVE2883LC0p//3CbXGw7jQ/Tu+jH6h0Jvq6glLN6SWRJmTQa30csin18rKSxkX0PokJ6++sFzdv5a8gFPf3IrudSLZENNyO/Ca2HcGpXdkE18BGIZ35xMfgr9X9oLVVoLajv0UaZhfwBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com (2603:10a6:20b:2af::12)
 by DB9PR07MB12346.eurprd07.prod.outlook.com (2603:10a6:10:602::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 22:48:24 +0000
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc]) by AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc%3]) with mapi id 15.21.0071.015; Mon, 1 Jun 2026
 22:48:24 +0000
From: Mateusz Furdyna <mateusz.furdyna@nokia.com>
Date: Tue, 02 Jun 2026 00:48:21 +0200
Subject: [PATCH] net: clear IP defragmentation state after returning a
 complete packet
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ip_defrag-v1-1-f4cc1265cc49@nokia.com>
X-B4-Tracking: v=1; b=H4sIADQMHmoC/yXM0QpAMBSA4VfRubYaM8WrSGLn4LhAG1Jr7264/
 Orv9+DIMjmoEw+WLna8rRFZmoCZ+3UiwRgNucxLqZUUvHdIo+0nkSlpVKERKxwg9rulke/v1bS
 /3TksZI53ACE807dHwG0AAAA=
X-Change-ID: 20260530-ip_defrag-130c345dd9db
To: Ben Warren <biggerbadderben@gmail.com>, 
 Alessandro Rubini <rubini-list@gnudd.com>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Mariusz Madej <mariusz.madej@nokia.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: WA1P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::18) To AS8PR07MB7461.eurprd07.prod.outlook.com
 (2603:10a6:20b:2af::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR07MB7461:EE_|DB9PR07MB12346:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d6a8bec-77d7-4a89-f85d-08dec02fe31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099006|11063799006; 
X-Microsoft-Antispam-Message-Info: F636C1lEutjabsPgUGUIsyY96IK4tlwxYLoHSrMtwLkOKtJKX2Tg4UAu+EBbL4WmicAxGwpeOaz1Kp5cSltH0Kn4sx5lrRgZXi57d9UsgSpQejsSnDILLVz7i4793JLHHsA4UjfyOIRtoySe8vOWBJ7BuS1NU2K7TDY9LInerNY7tm2JntOTrDiY7X81tn1qhrk5FyG2DmBaSqlmy64ywoxNpvrbVIB5tGhQLYGiUJQMXPeD0VVZIrkjCXztDFKGl9EseimmvMajD820FZkSVODW9T3E2mAX2ax2/Skd0K+X1v22sKmRAG47lwgrfD7IFKeqTZTGKeBQTWkf+3gUUVIPIT0msgHRCOPFWTqFhtSDXDA601v+WB4j7xfSlUu74kdb6zZ6ZNjtU5asrDSbjPlZux5/cggSuCUMaoZhsSd+P8h/a4Z/XfJG0a9nv/prbeVIxBiS30v1TK9mRqeR43/3JYnLdnEst8QysvRyhzBCrP6uGVwWoZfBm5i+PRYCXifh8IKrOiYy3MK++iSpPkqonvoEywSyRMnnsrd3CkA8gnTzaq/6s79U07wuQyj/po+62TNWdgfyH/Ra2MZngyJkfmKw5k91a8ISP0MaghXY8kuqQPyTopMbr3yEXCJsInvScB6NvvXqk4JAYtBt2wgAvTI6hxsrXlP0wRsYMAklzUooIxOMT574ZP+J7esB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR07MB7461.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWxaS3UxOXN6UjBVendSbmlueEJOcVIwMDZIWlY3QlliWnQxamhJWW4yRTlz?=
 =?utf-8?B?L1dKMktNV3ZCajJvQjVWVlg3cEt5M2wyeWVuWE9pNDd4Q3NreHkySlVGdWlQ?=
 =?utf-8?B?ZUJEV2x6UHZ5OHhsUzhMeUg2YUIxOTlERFBxUjBlNi91WHlTUmdDSjlUdkpu?=
 =?utf-8?B?NCszZzNvN2N0OVErck9DcGsxbnYwLzNSdFBwMmpiZ0EwTGJoNHBQdUxra2p2?=
 =?utf-8?B?QUNVR0JHTjVsR0UzT0lReXA1Uzg0dS9QVXdLaXBhUFF1aEZ6Ym8waFNWN1hy?=
 =?utf-8?B?OEhObWFUQ0psMit0Y2V0QnlEaUgvMjFBL0xmQ3FsZmFWdW1KNVg5T0VlUEJJ?=
 =?utf-8?B?Q1IvRjFjV240QzB2bmYrbFZBV0hxa3lNeFpWWFlxRzNKczBUWVNtQ3BndXY3?=
 =?utf-8?B?aDFRdnd6dWo2Z1hvUml4ZTVsR2pPN3FSd0VWbE9pRjhhQmdVcmpsRjVjTjRi?=
 =?utf-8?B?VER4TFZ4UVJnaXIyNE1WaENBWlRzQkl5SzZCT3dueXdaWHJiZjZ0dzAvWC9z?=
 =?utf-8?B?VmpvWXB2Y2hNYXRORlFIRWZuak5ReGJ5NEQ5akNwclV4SEprSHhHRHZ4Rmt6?=
 =?utf-8?B?bUdXZ1BTSzF3dHUxS0tmd3BXMUtZUnY4eXpja3FadkZEZWNiVzBWOXd2cW5M?=
 =?utf-8?B?b0pyZHNBY242MnorYTZSSjV3Wmtpb1B6WWQxVW5pT3RoYytPUnpTdjZGcU1L?=
 =?utf-8?B?RUh6M1F0UnFRY3VlZ3RObzNIdG5TZndTVjdYcytzQ2ExQlVQSXZITThzSGJu?=
 =?utf-8?B?Nk5qd0pzM3ZPbFVUWmxSNFNJcGh3eEw2elpJdjhhMUFNMVlxQm5UL2phcmwx?=
 =?utf-8?B?OWZlNTJScFhsNFBHQnBTRWlzWDd6VnB5SCtFc2Y1OUplK3IwZEZFSTNYaUQv?=
 =?utf-8?B?OFRPMGxkWExFNmFzVVBWTkwzZURiT0IvR2FHSURVNW9ZZmlSZFBJTEI5ZlV0?=
 =?utf-8?B?VGZTVWp0M3lpeXQvUlVLVXpsYlBDN3Azbko3bVcwdGc0cDl6WC9NajljOVdq?=
 =?utf-8?B?NzlVd0JCMmtaa1ZSanFPRDZjRGxVSG1jOUxxTkxqU2pBT29hSnh1UkhTNEow?=
 =?utf-8?B?RkZLM3c5Qm5Jelh6eUdYbzdTcE1FcC9aUnh2cUlyVzlvZG5jbitYazFOa3Nt?=
 =?utf-8?B?TXhobW5YMFh0cmYrR1JNYUErVUhKZnVqc2JVTEVnTXFqMEhqSlUwbWdGcHpO?=
 =?utf-8?B?Qkc4dGVhY05QTmEvYkFNb0o1R2VIRU5TY3RmdlZtTDV1QVplczA1NEdoQTJv?=
 =?utf-8?B?ZFR6Z0ZZdEh1cWxjQXRDWVl0N0FFVlBiY1lNVDAzcUZwamFNZHNTYVAxUWNI?=
 =?utf-8?B?RTUwTFRjdWo1ZUI5T2FjRTV4LzliOXJjNHkyN2ZMdmhjTWVqblEwOUE4dWh5?=
 =?utf-8?B?Ykdnc29ydkpJOWJocEpKNWlZVnBDTmhiQVlQMUpaUDRXSjhyVWJmeGIxeGhL?=
 =?utf-8?B?dW5iVytIOGhIRy9lbmkzdUY4VjNLempqSlNKMXhMMHQ1bmtzL1dmU1l0Y0lX?=
 =?utf-8?B?YUJ5dVNzK3RkbXBhUjZMZFVpWWR3RGc0c0FnSGNPcDIrV2srRlgrdExFcm5J?=
 =?utf-8?B?blk0SFBnWXk0RzM4eGxXaHdYN2ZYUlk2S09SbU9pcUhvaGtvTUhodHdLbXF1?=
 =?utf-8?B?N1pBZTZpYUV2SFd0Y21TY3hyMkhkQ29vaEpaeFd2Wm5scGFwcjRlN2QwMW1Z?=
 =?utf-8?B?ZitYZVVPejFaNldsMEM3cTFpLzBtQW1hKzcvRkQxRjVKWC8yaUQ3Mk1qa2lW?=
 =?utf-8?B?dGhWbTVkdzRlLzdZQjJWUHNsYjQ5a0FGaXB1UkJHeXA2YlhkcHQ0RkxoYytW?=
 =?utf-8?B?UTl0OG4zK1Q5bXFoK3FseG5NWXBiNkZ6Q2hJU1F6QW5yalZpdnVabGY0YWxw?=
 =?utf-8?B?M2xmK2drMVpyY3JlTFhUd21WQnpRVkc1TFFBcUdBY09ha2lIVTYwSnlyM09k?=
 =?utf-8?B?SUV1WkZESk5wWTVyZFhYM2hFcTZFdmtGMjVITTBVcUZCUGl3UnlnOUx4eU15?=
 =?utf-8?B?cWFZQnZDaVVnenBYZU42MTZ5WW5odVIydThuUVdmTy9sbm9rMi9zaUlRMWhF?=
 =?utf-8?B?clBXYW10L2wxb2RETS90ZE9rL0gyMFpiR1NCZkpSZ3JGVmsyeWljMUc5Y3lV?=
 =?utf-8?B?SEJsTCtzWjFNMkNFUWVxblRLNnk4VUFZYjlPUWJTaFBmVjV4TUp0NmxUVVBM?=
 =?utf-8?B?ZlRkeEZQb1JibFlDTE5YWW9va1Nham1MVW5lRGp0ZzdPSFphcnVYS0swRzR6?=
 =?utf-8?B?R2dqSkV3TUdhTzBBYldFVkIyMG9hTk5sR3NpR2Z4dXVuZ0xqQWJudVNZaURC?=
 =?utf-8?B?aW9WQWdzRVgzWGJ6Uk90Um1sV3M2ZVcyYzUrUDArRGxWK1VPVk1IM1FBaERU?=
 =?utf-8?Q?+j0oKUeO8x5hQ3nA=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d6a8bec-77d7-4a89-f85d-08dec02fe31e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7461.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 22:48:24.0350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FZ7X0Ux7PhLZwya4PrqluQlLul6HC1ZbiHr6dsIeX49EWQWs9ckFLLUo+fLwiDxkosCzTtReXQWJs5Y6T0oIoyKBRw9vHZFes1NJQ/rQync=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB12346
X-Mailman-Approved-At: Tue, 02 Jun 2026 05:54:32 +0200
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

During the IP defragmentation process, after the reassembly is finished
with the last packet arriving with MF=0, the reassembly state wrt.
static counters is not cleared. In case this last arriving packet with
MF=0 gets duplicated, payload bytes are mistakingly treated as hole data.

A malicious actor who can deliver fragmented IP traffic to a U-Boot
instance with CONFIG_IP_DEFRAG=y can corrupt memory via out-of-bound
writes and redirect control flow into attacker-supplied payload bytes
that already sit in `pkt_buff[]`.

Publicly available AI models are able to generate a reproducer based
on the provided information.

Fix: once the assembled packet has been handed back to the caller, mark
the reassembly state empty so that any further fragment (duplicate,
replay, or a brand-new datagram that happens to reuse the `ip_id`) goes
through the normal re-init path and rebuilds a clean hole list instead
of dereferencing payload bytes as struct hole.

Fixes: 5cfaa4e54d0e ("net: defragment IP packets")
Reported-by: Mariusz Madej <mariusz.madej@nokia.com>
Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
---
 net/net.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/net.c b/net/net.c
index ae3b977781f..caaee3ff30c 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1103,6 +1103,14 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
 
 	*lenp = total_len + IP_HDR_SIZE;
 	localip->ip_len = htons(*lenp);
+
+	/* Mark the reassembly state empty so that any further
+	 * fragment goes through the normal re-init path and
+	 * rebuilds a clean hole list
+	 */
+	total_len = 0;
+	first_hole = 0;
+
 	return localip;
 }
 

---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260530-ip_defrag-130c345dd9db

Best regards,
--  
Mateusz Furdyna <mateusz.furdyna@nokia.com>


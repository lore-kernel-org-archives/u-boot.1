Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AAEECD98C6
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 02:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84831849B8;
	Thu, 11 Jun 2026 04:54:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="QN77x8Bz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACDE884940; Wed, 10 Jun 2026 16:25:57 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B85E9848DC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=mateusz.furdyna@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RjmJdYIbkKg0n1NrP1x6lS/3I1X3ZyKej99eOdg8zPO/aEUjLbEVcAVlX5eHLFBsO/9yHKeg2ythGDr2+V/ShF2RlgrzgJgBEbYGo3gWd0KPxaYdaNj6Fuu6zteU0r/JYFFJxTs5K0BOmAhS+hGQWRsKAFJ18TyXNwjzorjD/nvA5H+SdVjrhM8NjQ3gcK0AiRkntHnfN91FYWCHIzy5nrmfn9C9Iw6jzz+S5JXrkSm/QI9w/Mn2xImLWmiQGPn+eTczxs5kbWV68nJXVStksf39/OkL85zgDC/fiHYoVeVXCGjE68pvBr6qc+Hjr8t5puWoo2u3tFE9irPOYQRuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5KCRS76ZMY0N2uQIQeuziMM9/0ua9P9ROtLl9dEoZY=;
 b=lhGJdcIT+PMKxXfrmXTkZPHt6ErVHlXYBW8DJi4/UpBBt05CrPavYHKyesj1OEiqBlywiy4xcpNPLHknvENwJbUUQbMS+PunvW4YR+hrEZH8cOG56nf0k7YvRB/J9uZKPny8HRawB0zTF5YXYGNRJIXhnprxBJuuzAACMxX4uOBs0hxptcxn9XRG4wJaq71cR7qYzYwFABfsi3fgcIWNqMqMoudZsqZkRMjIW+cI7eGnTL2ftReDvzXO1mHEJc0Y8sMN4iS1PV3JQKulk3XTUH5yyLKwYBQLbdJxhSy2Ha4p5FU1Mc2aPEO+bmwaFpqFXHweGo2OJEtobIr9X2qSoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5KCRS76ZMY0N2uQIQeuziMM9/0ua9P9ROtLl9dEoZY=;
 b=QN77x8BzIJ3CzK4CWf7cZRG1J20sC9D8dDNd16PdLT4sRdxpQxGIf2LOK6OXHCihvZLdsWuIjegnFLld6bIxFbkUXokUrVh/OKJEyIJSs9xkXqbwdLcywyIfRW2UughpJ9e4PobRUEHfGDhK2CCrQH1atPSLt7Zc6WcbnJ+DUyeVhL44OQeDFACCPJyVy9/pTKIYs+yOj4iJJp1QqWrjXqzjj2fdBbpU7vNwPgVDfrBwsjFMrwRsX5ltaPToYKdIA8u6qU2EMcfHGwR/bNc/FuMuOKKdWtM8sA29FEij72WJqIeLVmtVjlHjsEUe1O7X3TRPpHV9hSjk4uyasJxO5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com (2603:10a6:20b:2af::12)
 by AS4PR07MB8827.eurprd07.prod.outlook.com (2603:10a6:20b:4f5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 14:25:53 +0000
Received: from AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc]) by AS8PR07MB7461.eurprd07.prod.outlook.com
 ([fe80::8dc8:cbbd:e4cf:83bc%3]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 14:25:53 +0000
From: Mateusz Furdyna <mateusz.furdyna@nokia.com>
Date: Wed, 10 Jun 2026 16:25:33 +0200
Subject: [PATCH v2 1/2] net: clear IP defragmentation state after returning
 a complete packet
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-ip_defrag-v2-1-060f6eeaeaa1@nokia.com>
References: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
In-Reply-To: <20260610-ip_defrag-v2-0-060f6eeaeaa1@nokia.com>
To: Ben Warren <biggerbadderben@gmail.com>, 
 Alessandro Rubini <rubini-list@gnudd.com>, u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Mariusz Madej <mariusz.madej@nokia.com>, 
 Mikko Heinonen <mikko.heinonen@nokia.com>, 
 Mateusz Furdyna <mateusz.furdyna@nokia.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alessandro Rubini <rubini@gnudd.com>, Simon Glass <sjg@chromium.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: WA2PEPF000008A1.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::64e) To AS8PR07MB7461.eurprd07.prod.outlook.com
 (2603:10a6:20b:2af::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR07MB7461:EE_|AS4PR07MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: c0361c8e-3135-4eab-f1b7-08dec6fc2d7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: XTU4hQLkVfjvgcmL5y9+hY81iNcbcM1Fb6wLJQXR0/+FP6FP6cLkBj45VKRG9yKyB52Ojwsy/H8UTucBQHcQO+9b99WPjh3+8tn9O3uGdXOsC0zzUFC383VkXYSqD1V+lglAQ3+6AM7l2OGYDyEAOjFJEtxoIhAncOXUzB/UhfrGyeY1wCekhGoxyQYYG3Q0cEVN6aFYrtN/9y7PHCHILjOikd0R/TcBwO3qGP6Cig235JdUv59WdC0ZAbu3C+oJvNLuIXkUWRr27Nq3wdlTe1GUMfSakJjb0HICBlh9UXH+achMfsrr+l64tWGawbXM9dfAYezBYRvrpH7xRgS1FZ+mGEmoHL2UHNRTZ6crqRF+PP7OA1aguZfFfupnVK+GkXmZ0aBC/Oxn5b8CP4AAjw+4SLEFDCCBwX30Qlj/DYcvxC4FHN+QsiAUpHo+srTuo3LtZlqdigGr8zgBlnn6cp+D+WDzaPSReujnnmwXM0AxA24gprguohaKw/3CCAtZNm8WLxZQu6/H2OD2mRt/HrJILmh4WlG/PkA4AuusrjuwDuDm2h6QftRkX6oi7ZA/I/Gag0FhtwcA3ttQ8/nifvxIAEZb2xpt3csvf9VJNEgYhiNFKUZQsfpgCgMWKhS7GCTurmYKEDd7naOHkSUcQyXM1jRzsNZ7LkXfo2V2ZqsmQ1z5jQo1XhSFBiIJJHvl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR07MB7461.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmZvOUtXc1lkNGttZXlmanR5Vk0wNFBtekQ3RVdsWWlwK2pxb1Exc09HQ2lF?=
 =?utf-8?B?YmdLKzZBUzQwa3E0THVkS0xaYjRNalhMdGtzdC9YaDVwQmlWRHBXYzJHZmpT?=
 =?utf-8?B?YTF1Q1lDWGl3c2tld0dZcUVUOUlnU001ZTJ6KzI5eDBBWEtyM1M2cDFXamJp?=
 =?utf-8?B?RmRlUW9CTWZmUFhhQUR5WXhqSU54dC8xMVVZcVI5N1A3ZnFrTk5DUHp3Tk1C?=
 =?utf-8?B?V0kwOG15TmI2M2NKN1FMaHd2STVWUXZDc0JiZS9Tdlk2Q3hTMHA2N3EzQkNj?=
 =?utf-8?B?UDNxUHhqSDBEd29obEZYNEdlTnRmTmticnJSaXBKSFZ1ZEw0cUN0QXlHWDlM?=
 =?utf-8?B?a3JiZ2lkbi8vcktqd25VN1ZQMTBvT2N5RUlOY0VNaC9WWjBOSGJZNElOM1dq?=
 =?utf-8?B?MEJsUlZLT3RmYjdqLzVEczFmSzB5bXZNT2t6ZEhjSUp4ZzBCRDRnSlg1eWta?=
 =?utf-8?B?NXBnUGpDaXVlRGY5YUdxTHVXcG9NbGpMNzNKczgxSlJVY3c0LzVTdW04ZFZj?=
 =?utf-8?B?ZWtCUnR1REVmTTFzNmIxZGhSam1tckt2QnN0YW9nWGRHTlBodnFrWUdsdkl3?=
 =?utf-8?B?V1Z5MUlIby9nbnRtSWJ3N2RtWXdEUHE0ZDNLTmtrMUpYTGdPU1daRVBwdkV3?=
 =?utf-8?B?MjhxSlZXUUxJRy9LZDhiaWsvZnE4bW5lbzRoOC93Q0RTQWgzQkxTdFQvV1NU?=
 =?utf-8?B?a0NFekRFbjRSMVZXTHoxOVlNUTlDTG1mY2w2TEZUV2lLK2t2K0t0V3JzNU52?=
 =?utf-8?B?ZU1id3M3SkN0T1JyaVdHTEZ4WHZucks5eGtUWU1jckE5MndYbHViVEpWTHpo?=
 =?utf-8?B?aWpDdENReUVkQnpOSmZkWkxXMS9WWUdxdlFuUkRuVjZNTS9XMUZsdGMrcmJr?=
 =?utf-8?B?ZkJzQUdhcGR3TmJyM1U0alZIajVxMUh3MGRoVFRycjF1K09vWVB5MGVFREpS?=
 =?utf-8?B?T21JbjZWTXhaVm9lbVRaOVVGNVRNVkJ2aU0xM0Jmd1laVG95N1VlR3doS0NX?=
 =?utf-8?B?S1FpWWFnQmhIcGVZaFRZMHJQU00xcCs2ME9tV2pCU0ozK0RLbDlMWFJDNi94?=
 =?utf-8?B?RVYybkY0OStIQlB0dUNhSUlsYWlvb3JaTm5ZQWxYWFNmT2VlaUt5bUdSL2dY?=
 =?utf-8?B?RGl3eklDNTU3dVBMaGx2VGVmYVdJRng4bGhza0k5K1Erb01LUFl6TGtaQndU?=
 =?utf-8?B?OWVHa05WMWY0RUFhMDN0aTUyZVNQVnFwRlczNUdhQTV0NzlUSDJZNTlYRE1y?=
 =?utf-8?B?R0xrbDU0SzBPM2hnNXdhUys2VGtPWjRWMmxDdnN0Qkc1TWJrTFIrdWJBOTJ3?=
 =?utf-8?B?Tm03UzgyOFNJOG83TlFjbWcxeW05ZG5Qd1lKd1l2a1QxTVBWRy9hVEl1d29z?=
 =?utf-8?B?ZG9uWjJwd01PdG9oVjRxWFovRDdSd2E1T3pzeFQzUGlpSlBDZmVpQmE5S3NN?=
 =?utf-8?B?bGYrMFk0ZlBKSUI5MURtMElwUWZ4UU9jNkx4bFZ3WkVCMzNiWmZQVCt2OFgy?=
 =?utf-8?B?NDd1VEdMNUhmelZKQzdGSSsxUW13SDFpbG5DTVNPTi9hc202M3BaYTd6MENJ?=
 =?utf-8?B?T3J1K09uNzNuSSs5NDlNVFFMWUllcUYyWDF2TVJkT1l5aFRaNG9zSENkcDdM?=
 =?utf-8?B?WkFydExDZWR1M295V2cyNzY2YUcxamdWSHVVVmxBdlBTSkdRNVdlTDNGTGpp?=
 =?utf-8?B?ZGZrbHhQWFZpQVZ0WUE5R0ptaExiM1NUYStsQUVtSW9PNW1Zb2txN3g4MWJF?=
 =?utf-8?B?NEpPT2V3MEgyNnVhMUtuRGtHSWxhdEUxSjBLS3habzVmUFd1WFV1d3JPeHpx?=
 =?utf-8?B?SzF3MWhKTmxLMGVrSGVzeGdIMXR4UmFzRFlpNTZKRGpKOWtueVErVy80TWFv?=
 =?utf-8?B?NW1NcTEzcDlMK25xZDN0ZUVJeXpjM1crRU1NUGNIUHIvZitVb2NpU2JIMGt2?=
 =?utf-8?B?T0tLWVdOenhRQTk1SVMwSzhId0Jqbm9YbExERGhyQlM3Z1BDUWN2NFpPWTl3?=
 =?utf-8?B?SytXcThuZmFuZGdDWlV0RnhRUkVoU1RKeGJvVE9jb2hMYjB4ZGZUOENWeHBm?=
 =?utf-8?B?U2RtbWNtbTBwWllldnN0ek5ud3NJVStsMU1TMWtPTjN0WUNSdVpoK0NHQlRu?=
 =?utf-8?B?SklPc0tFZVdhZjVIOG43b25pTVpRMGZDQVNwZVMvWEhueHFLR1h6N2dsR05T?=
 =?utf-8?B?NVQzdEthS1BOT3h1c0JEckRPZkJLeG1QWkN6aWxaTGFoRllLWWJlNFpIQXUz?=
 =?utf-8?B?bW1XWUVOblcwY1JPQS9qNDdHaVhzRm9DYzl5RW5NVUFhZjRWNzVHME91M1pk?=
 =?utf-8?B?Y01ZRGRTQ0dhNFpuWjdoK1ZMMHB6eXpyRmdpdkRIb2lWdEJ6OW1UVm1YVnZT?=
 =?utf-8?Q?P5zdNSNL9w/P2fyA=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0361c8e-3135-4eab-f1b7-08dec6fc2d7a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR07MB7461.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 14:25:53.1629 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJ3n2ugPTAIozPYmUw4Y9mWiMwqtr0Ahb9ESFft+6eoeuX6Rvt0oeR4H4Jh2ZuLfShc+AvbJu76kqcIofjQ4o/qWWupTTFAOY+l62weG+yQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8827
X-Mailman-Approved-At: Thu, 11 Jun 2026 04:54:05 +0200
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
MF=0 gets duplicated, payload bytes are mistakenly treated as hole data.

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
Reviewed-by: Simon Glass <sjg@chromium.org>
Acked-by: Alessandro Rubini <rubini@gnudd.com>
Signed-off-by: Mateusz Furdyna <mateusz.furdyna@nokia.com>
---
 net/net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/net.c b/net/net.c
index ae3b977781f..61c5a6ef6c4 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1103,6 +1103,15 @@ static struct ip_udp_hdr *__net_defragment(struct ip_udp_hdr *ip, int *lenp)
 
 	*lenp = total_len + IP_HDR_SIZE;
 	localip->ip_len = htons(*lenp);
+
+	/*
+	 * Mark the reassembly state empty so that any further
+	 * fragment goes through the normal re-init path and
+	 * rebuilds a clean hole list
+	 */
+	total_len = 0;
+	first_hole = 0;
+
 	return localip;
 }
 

-- 
2.53.0


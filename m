Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B41CC7EE30
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 04:44:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC20A81FEE;
	Tue,  1 Jul 2025 06:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="tiXvDwy2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04FC981FFC; Tue,  1 Jul 2025 06:44:28 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1A108006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 06:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W5B83i0LUb7u0BOQdmeNPox1RWpCfcXbDemUJgv8QxsrWAijGaXoeBV+JGDykneud8MMt6gOoLU/DVEDBTZavIF3PcWC3TkDjSER8wO2j6w0bN/BHi+fisWez/v8jVRxQT68XPfDDpfUa5KY2tE2IxPvOPF5pYLjf0q+b3dhHcPEeYCmBpR98JL6ECJJbv+1Nrwl834WmOcuC8RKDm5ZLdDngBVeTSuyJ8pIBBDG8u2NZcDHLQjsRNpYv3cgTad5KrZP5Zdd62z7festkJJvFsUAUXRVd8e+5Rtqy9N04xqYZexcuUZgT0Ks2kee8aEF1nwnvgdDZjixppj2SPPjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypZl0jQOhaTCkm2YlRnh8ii4fGMijDqhbjwxrMyamwM=;
 b=BzIK7N5HsUcpH0YVifSVtzbG0MVOn6NMn18BSR/1CeGGk7cPKm1CezUsmqDjs7a/XW3WWtp5JjQIcqu8g5MzSc86RoYHOHY+AbzhYqrzJMssWv68kLSfKYcbDO4d3s5jCbmczX7qyBXjgZtKgSkLt1rAVgVjPSZTReoGO8Tn2hI6/g5JtYagYylvPGUZwMX9VGFfDxujPzNVY9nnSRN25MLncMKrF/14vvF/zGT3xkHoESQF1YGsuZ5WYMbFdFgNoT1MKl/6rBwJGU+/vgXhK/+xrHQvS5g8SIEBYkdDcNo4VJ/M1l1R1JTkcWKyAq1dC5aDa+ftwZL1YisAavNK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypZl0jQOhaTCkm2YlRnh8ii4fGMijDqhbjwxrMyamwM=;
 b=tiXvDwy2D6NT0yI0KZcu4X7sfzPyh7d8A7hRRWe5vsaRguqQWvYX+nTq6AEqyhXyJLxEg0e5oe41x6iWnHSqTxR1sdIqnvZGzYXDzDm8vSaDRXiwqU9V409PRFr+bAnL5RQjm+cC+HUy2BifSPJ+WlFZXWZH0diPAXibcI40ToKg0PjzR8ugKuL8zV6wv6mknYKT2YJZprGadb3mO7Mehkvi0Wzj8Lb0odFHRYIPGe6yqQ6H673RbCjvnWjUISLOa8LzmZ+dqxzkJdXj7ytZeJ40C2gBQd9n5n6VoY2CQ93msrCvCBPZjohEmTdKcZ9ySu6oyxTeZpG6s/Lfj+hc0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by CH5PR03MB7792.namprd03.prod.outlook.com (2603:10b6:610:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Tue, 1 Jul
 2025 04:44:18 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8880.024; Tue, 1 Jul 2025
 04:44:17 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] drivers: fpga: intel_sdm_mb: Check SIP SMC status in
 send_bitstream()
Date: Mon, 30 Jun 2025 21:43:11 -0700
Message-Id: <20250701044311.3670-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:a03:60::23) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|CH5PR03MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f384f81-b9eb-4aec-3ba2-08ddb859efed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yuMRBeBr55a9tJppFORzKoxDj6L3X7wrjoRc+U6fUX+NaAmfPQmkoIHe0z5U?=
 =?us-ascii?Q?vkjHuk1BTVl/+UqwZDVm9U1pLTnafhTPBVstfE7OU3ovgB+OVZfrp6oggzhq?=
 =?us-ascii?Q?IefUGXxeJqJMhsd6fugTK/4hSFGxEowIzer5Tnzwit3sM7w6mdSmu+tGWKH5?=
 =?us-ascii?Q?ILOzgO4rO8jdrQkuj64OVnLlsGgenZxRUUA1yszYegF7CKq+YgSoyONHQ0pa?=
 =?us-ascii?Q?wn+J7vmc2eHN3muWH6Ns9W1vUZKzdMNqBg0nFbu+Az0WvYLnmZSF1FQ9fxXL?=
 =?us-ascii?Q?jdMjSoi3FIuZ9xyWNIWs6JaYmw6qnKsDBWk5QfI4aJHA4CNWxtg/txhpog5H?=
 =?us-ascii?Q?XSs8NuF2paAlgiBhAUHGKxBTd/y39LTwoSQEu6lNtI+wkvO3Ux3NAer56J1x?=
 =?us-ascii?Q?H+s5USEr1LidV1HwzsRKnGGHPEDBriU4SI3J2zyyV16+UWGUF5oOdes/i0D4?=
 =?us-ascii?Q?GECqp3TPiToOguwvbyz4BoKKctc9EySgTeYE2hkOTJ9e3b8s7/6Bjs7Pzva2?=
 =?us-ascii?Q?kN2snrnvEhF6e3sU1ieIuTIMheTY/cP6cwygbo0p4rJenIQDa2HxndP0W+mR?=
 =?us-ascii?Q?X9TpMCPuz+C26JdJVuH18fVhUV+y8fpkORq+T+zeNaoC7D0upfs45vP9wOdA?=
 =?us-ascii?Q?7FFI6YH+bX02l26u8siZ07ZqheIJsyGDvBUydyRW9CJhJmCdmI5xIcCSAdb5?=
 =?us-ascii?Q?R6sPbL9saQe79FmynNAGdYzlEzh6Po834oVPAiFz2sWQmMMoOUVN3xiOUzQc?=
 =?us-ascii?Q?+Vc9OR6KtdKcGpKMGa/sJezkQxUKlVcS1jw7aNjRAosmeWsSp60sRuI1F+bD?=
 =?us-ascii?Q?d3+4EGeUntVjv4Wk5SUa4P4znCNNMxYW/vx/emyWskzGNfo4NmihasdbwXE6?=
 =?us-ascii?Q?Nuu7aGgb5wA8GJrR0zIc3dGL0gaLj2YMxx4vUq3RpP2A9ReiU1OW17m3rgbr?=
 =?us-ascii?Q?faSHQno6GX0PJbbILmUri1dFvjQ/+HgZrFCVB8HyPeUumXfMZGFIXhm76X3/?=
 =?us-ascii?Q?fiLyEry4CYXrSZpjeRd1Xnu4BqEEGWd44RC7nJAW0nK1EIu1yR1Az4uMMuqG?=
 =?us-ascii?Q?8NvFsUWoodzQ95PMzC4AEG6QC6GlWjfjWg+jkwaAAdWKseTuUWL6YEXYZiL3?=
 =?us-ascii?Q?NzMeQqQ1G4V5EXIhgzkPm+7X6IMkZK0+Rl7d8fsNpYWpS6ucem2PCNfW4Htc?=
 =?us-ascii?Q?5jWOVvgA/uIKuzb6e7H29mx26DhrDz9GGb1yVKBJLKHkpc6JV5nnoPzPch/U?=
 =?us-ascii?Q?x+FuBfRo3OjfWOM3kE91H54VyTjM4yBcqgf5A8oW+iXJbJeBJAihb39b6Foo?=
 =?us-ascii?Q?cfO44lzKyDB9PpYyk06+Zl8SOs4RmkQ7e71+6Vi2Mb+c2L06zXQ0pu2qsPhG?=
 =?us-ascii?Q?imlAuTUgOISySBy74or5K4lYzNTaMzziWaJYpXF189OktDOi2Lq17CfTqHh8?=
 =?us-ascii?Q?ZCYncdZC2IE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EE138ItKWWUBn/ie2a3frbq805lE6PVXRU97CkvdNmx4U4ERIKrVzmmb/UAf?=
 =?us-ascii?Q?geGfMS4qgofmipVBdupBE0mqmYjHsEUmULqHX7m1BYo1fBCY/VQ3CCidSunG?=
 =?us-ascii?Q?cAXV4Z6jMgkJ6aB+fBmHCyWSuagbrywbzE41lHe/vz7hRSScGrvogdCvQftR?=
 =?us-ascii?Q?lcHqFbEvP92akq0RegZH1VeRIz+NvjBgRMAXebpqNyAX620ZcGqCpr8ytJ2x?=
 =?us-ascii?Q?6IF6L8YZ9O5KcoS9eNFU6/K5rhf3NyquNlw4mukuShXPxXGTZiej+ePfUaVU?=
 =?us-ascii?Q?fBAJiwekYH7GdibkYcD5EQBkijXrvGLiWSA1OUClwxd90JP7uwYRUlcS3kt2?=
 =?us-ascii?Q?Zh/4nc2fXIMzjL2++AqYbFzIGXg3cstj3Jc3HMAPftui5nTov8Cx3/0XB39x?=
 =?us-ascii?Q?j7RsvBpkQPzLmCqZOZsF6ooxES+6Jq8lLYnKWygvhK/5cQQIHowm/DCLkLI5?=
 =?us-ascii?Q?NrdgYe3ffgFiOUO6UQtsRdu9jHeBCvToEMTrxDbeNEaeflj+pny6ig3MucVI?=
 =?us-ascii?Q?PQemNHAXJtR6KS/w7CvKNITrNvf8rzk0C8u3IvcD6ORsKltEBxAq1KEsmjr3?=
 =?us-ascii?Q?XLxtzZB5IOVSA1avXsJN3ISVw7QvY8V4bU6Q2qSDjVHoxBkB/bmsitWMi2sQ?=
 =?us-ascii?Q?wDekh8LQc6rY8VthvQlFbLIuIq8+RVMv/Mv5GvHgSyMhngtDKI+ghXACo2GF?=
 =?us-ascii?Q?oQPPWUI2K6XeoiqC0Wd5zvWmefEV9CQJ+D1aIJvyHpOwOUqRn+FVYbL2++gh?=
 =?us-ascii?Q?ouRsyXV5DODbaOz+7sbN6xDK6p2i8y6+VVCPQjBVP4+5KFL/26owe6icV3Er?=
 =?us-ascii?Q?jtHuTWlPWuZ3v5c8tp7qq0xRS1hO7YZ8LjymyfG4UgtmLR+GqD96RGLST5a3?=
 =?us-ascii?Q?qUWBDMIXNo5BuKO5Ckb7vF5dQgYXoCsmsimckI1IQ11YfuxL3eagFl8OfB6J?=
 =?us-ascii?Q?mhpCOSGIEhKUGqOA0JRa0VorfQhN+0/XO3bEvHHNdgmXo674yudyODgNeRDO?=
 =?us-ascii?Q?M7aFxsQZlL0P6+fVioSIYyXC92XNxbeYQus1ysAkt+W9l3zyeCgl4GU4VZ2B?=
 =?us-ascii?Q?F+/nBxpd//lTbhprYJDVgjRG7TdEDIgmgbTCsep6q8iRisC/fD4KrliSbEtp?=
 =?us-ascii?Q?xfPYbaXG6JG/NK1RSU1ab5ZMMXm+8ejL+M+nV6NBsqUhgkhNjMo2R1rZfDxx?=
 =?us-ascii?Q?fLHmQGvOwYdgnrPVuAA2TwHzLfOFerkdG5OZ7i9cx0jGcYR0bMP7Nz2prwmy?=
 =?us-ascii?Q?iSDN3NmC9cBRGXKcLYzvV9+jZVS2rTPJS+0vcTUFvfFHJTXGz32X21oJJlk4?=
 =?us-ascii?Q?bkO+1eEAybk/3GBKQaH4X1Or26h8Wg0V0GfYhGrif5P2T3Zab6XII8+IqWBV?=
 =?us-ascii?Q?xW5Rp/9xxTdwp9xJSWFkcjJGBirXOSq07i+mscQtdEcgAK/x7UpcTTjNekKK?=
 =?us-ascii?Q?Qj5c6qzjgxmD3GSMEEJLA5JTXuuGM+mDOivIOm8HxBlrIL0eTjvhrqnJ/7n0?=
 =?us-ascii?Q?Nnso3m9qPSaVQ2B3AfTB2yofZGMj1YIl6C5Bdw3WQYBN6FOjM4SVg73jSUUC?=
 =?us-ascii?Q?nrkmkxGUZWbxObcpXaWoBS0w1j2S23nD7UWprGJf420mm66r5ABSb//klt7a?=
 =?us-ascii?Q?nbYt+Xr/MOaDTzN711zS6xU=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f384f81-b9eb-4aec-3ba2-08ddb859efed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:44:17.6146 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7ADe7+Y07ZjzO2BQB15QS7LOrN0+2akqwqOhOnLg1Zor+FhlkKPPHf3QzP+8BYhOKV26Zx3rNq9BMkQ+ZOHTuH+ZMuDpLEFvk2DVdz/9BSasvl3j8x5QqXGL7d1gj3n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7792
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

While sending bitstream via SIP SMC, busy status received does not
correspond to error, instead it means transfer is accepted but SDM
doesn't have any more free buffer space. Hence, data transmission
is continued when busy status is received.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/fpga/intel_sdm_mb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index a2f3b160a73..5f4aae47d6d 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -687,7 +687,8 @@ static int send_bitstream(const void *rbf_data, size_t rbf_size)
 			debug("wr_ret = %d, rbf_data = %p, buf_size = %08lx\n",
 			      wr_ret, rbf_data, buf_size);
 
-			if (wr_ret)
+			if (wr_ret != INTEL_SIP_SMC_STATUS_OK &&
+			    wr_ret != INTEL_SIP_SMC_STATUS_BUSY)
 				continue;
 
 			rbf_size -= buf_size;
-- 
2.35.3


Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64488CA0EE9
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 04:26:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A0D802C1;
	Tue, 19 Aug 2025 06:26:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="byhF/qW1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43AEA80422; Tue, 19 Aug 2025 06:26:07 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AE980050
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 06:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX288nPwoPxJ7Px33NzP5ZCnHpCr8wuKhFa687sacOeSzECkCTNbzcw+PRhXgxXfQuJnd0MVkLEvISU7eTNXP8a5iFTvrXZNOzgN9AkcQ3MXM7fsqd7NqxN79rrbNw+TMdH1AOSMbVbEoLe0f46hDFRiY0VGUoqzUV4Fl3YYKAobG89uFudxgAXnSmow2mXuwu+5XkQJRdzKa5Hm0AldDdSpJvsYdVBDt+JVxD/8f0jx5iigiWT7+XYBShUgO/qOe0rIt0bvbqvLYW5utpEsxTqzPAhmGPlLOQe/V5d1wwnbtGHKVhUx5ZFesuPuN0QjLAzYdIEZXZ3AxL5GX0qlbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LQ1nqzA/nVxcqQ66JOsD/0ug3tLThZhJC41wozPaB4E=;
 b=kR0+DQrGIMgddxP4xKveW7i6BKtIHfJo2fIBIBGK+F78Z4CJIwzq6XwCzO8et68HuHy89nYKG+arm6sBEdWE1JqfNhP55NiEWbIbC/54D8ZcXl+p+N41jG8ys61nkOmgwqBmSEl6f+C+k0oN1OXV3ip22ngr9BQ/BJiGiycUEYbVQhKoNssSZGsuTboe0xIcUYjm7SxfuYZd8yFtvquadmSP949LDoER1WEWAQpKhu3nDJ4N0pUUzKOnJ/ZSMLCPX320rz9fZjP5GZFV0DnOCReN2myr2jiI3jhIXpr67prfn+v/zFU+j2kHiuznTLRe3ifKBCD13IlaSxx3kP0ayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LQ1nqzA/nVxcqQ66JOsD/0ug3tLThZhJC41wozPaB4E=;
 b=byhF/qW1XwSpvYLrzU2mbJqciiiztKyvTTE+CXWEO1DI0DC67a3WK6R6N6U7bA0WN5okv7KsSVX2KYWiN8nLD3UUrr4N81zWH3YkotbwmWQ3zNf5qKxVyqXVQs8zR2SPPZU62kfVetWrfR/qVBWboQFqmWBiEHXgXVcJcVhUu+QGeAGQzXVX+KcBKyGkHi7LNf755ZZXRokSkD/0qSRCZU8i9+y0MyR8ansR0tUwJL0tBPk0OlS8VLaSbR4cCOLR94RnJSYm8uXpYQdf3pz6Gdlv0dVh9dspL1ACJzCts0bsEQ4+yEFPhxZElqDuu/KkPNBWk823jH0QKWEkReAa1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by CH2PR03MB5287.namprd03.prod.outlook.com (2603:10b6:610:9e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 19 Aug
 2025 04:26:01 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 04:25:59 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH] arch: arm: socfpga: Remove speed and mode from flash probe
Date: Mon, 18 Aug 2025 21:25:55 -0700
Message-Id: <20250819042555.28113-1-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY1P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::16) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|CH2PR03MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: c26eba43-a94a-46cc-532c-08ddded87fea
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pylqQW3LWYg9xRcMqyxOqfsUpCvwx+rGyvkwN54j6v22Ykobje4yddYBtpyi?=
 =?us-ascii?Q?ee2gx7gwYEDXG9NT1oFu1mJWAyeL1vqTfTBH4BYDcERcEKz8Q9SPp1qCL2z1?=
 =?us-ascii?Q?2KwYDSlvpE6z2TJLtsMmuWgtGKFIEhGehHyMD+wOGsLoON6EVmp74h+MqAZ5?=
 =?us-ascii?Q?Kc4c4myFtBEr/GoMmQI0gxkaQFbmdsPvMX08SDzpvkLm5i/GRXh/lalo5fMX?=
 =?us-ascii?Q?TbNFZYkMoMisQnGt/c/MWYGP3b+vf40J0Zl6lvzAvQA1+tnhqlJcK6FgDfoS?=
 =?us-ascii?Q?01atxN8+KfYoYqJzJT4oaUrfjGaFjyiI2nUvy1I9yaQHph7Sf40+xjxI5UJg?=
 =?us-ascii?Q?o9rSsL4Ufp69fgGmzdRHbLKTWlTdickeBb627bkIpxzjAgciL4yCP8BZEHYv?=
 =?us-ascii?Q?37YLoZ+uwCn7JDR4SEXMpy5bpjrIdRX1uT5QX0G3DPkdLo4U/r55CPdp9BTo?=
 =?us-ascii?Q?TLEdEJqe8NMyZKbFIu7nAkhoobge6CYQTmETb2BViuMHoNn3JBNPEDr9k0UP?=
 =?us-ascii?Q?zsE1IxhPBDAUXRLp7TocOK3Il1YLj4LGuKyC/cYZ3B0tQ0KfCmBHnVRvizOS?=
 =?us-ascii?Q?2b9I/snR3l2av/osmSKMBX8w+McmaiZmev6ZZWzMQuw/x0Svq5fPo5RGG3AF?=
 =?us-ascii?Q?k89BQtHI5QaF7/cq9Cg6HXfTpN3wMCGlx6imq5uZhb6mlSGXMVUPx0Yz/OYV?=
 =?us-ascii?Q?bBg2spUqciwUEgYbArQkzMtd3RUsG5pBSNN268J4bJ/hQUdhVmNlXCGqT++E?=
 =?us-ascii?Q?kbClmkd5gSgfoR+kn35yNd8mx+8lA/MmF4kJ0ZdC/eMLCMi7d/tGt8pTJv7K?=
 =?us-ascii?Q?rQp+eEt8lC/Ebe8i3IJcs9ClyBmasVZozy5m0h1UM6swBzh3SOcKJH+MSsyf?=
 =?us-ascii?Q?eLHPVbKUzlTM8ekoCu/jeFAXywPVed7Db0tUScjGARvBB3AWlk4TEx3CUSQw?=
 =?us-ascii?Q?3Cinmjro025oYFl3jFYTRN8uSqhctF9jO3U5cGUmoD29IYKtleMZVDqayyPs?=
 =?us-ascii?Q?5VT56tV1ajcBPSqssO5hjvrI+0vHx51AoERtdtplOref5vM3kt6SrR7ZF5ys?=
 =?us-ascii?Q?9rEjW66/rYOR7Fitp/Ai83gQZYrgIoXfg/4UVXO41PDzU7Z/mtDKzAms+ogL?=
 =?us-ascii?Q?eEmSYaQkF4BZ3zv0JwrmugIPRbM7Vgb/2IgV83c12qO0nPtvCrZh6GsVNyrL?=
 =?us-ascii?Q?62KoWVWvvt0u1s+F+GxSxP1vwdC3MQJ3K3U7XbtAmxbYfyZfQJfizEcUfdu1?=
 =?us-ascii?Q?rORAi2s1mi9a/gyu5TF4qHpJirMq0Qi4pOJTOLgC62Q9Rb7UeH2r97q+PQzJ?=
 =?us-ascii?Q?x+5SmIAWCi8sBXr9fWIwVhyMdunlkttxdPQjNzRKvQwgCravWMjLH2k0W0wk?=
 =?us-ascii?Q?VtwdS5W08xp6Y1W3eyfZdQRXSqPtvGDPnL3+w4nSNCWivvEfTBgb6N4W8bSU?=
 =?us-ascii?Q?wuQ88Zc1/do=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/xiT/ZSs8zMYt6YMg2P26dt4GsNi4L6SrhFK7tRScm9oaZAZwxL4wEDH4ePp?=
 =?us-ascii?Q?CBEVD+CKg75w538BKf2PFyQ/tTZDQuHBm5oLJEPHxJaAru3XpCq30epOGY3k?=
 =?us-ascii?Q?TkVgPVXlMHh4PDBzgcELezUdqt6DtySicebg3zLDAgmJhEQ8n0fa4rIZq1n9?=
 =?us-ascii?Q?Su24fvMKd/nv70wiIympw/k/MTSFlml3+1YGeTgp8lOnhI+rWdNoLtHw08/3?=
 =?us-ascii?Q?eQvcUmTrEMh4Vg0/Z1mQMcn7tPeFpn2i5sWOWqFqo1eM0o/1n9aSo96Yx2Xz?=
 =?us-ascii?Q?WCauR6qUGV9j1xnYAV84/M3yZspX7uMC6rdhoBonlaYc9Tvg2w/QBnTK/nGc?=
 =?us-ascii?Q?1V3N+sflJ6lRuyH1y0LvoNXwwYkTW6ttk2X05PZWH5WcntmCNgsK1tspxvvM?=
 =?us-ascii?Q?W2/QIIJxqS7yo/pbjgm+v8hTzSH+XDMYmZXRjiNNG+jWyzxWAmqM1+M0/jkT?=
 =?us-ascii?Q?6je5+4NhMo7h3eJe0VjOJvYpEowy5MVkuMs3PTTnnaHI9I/hdzTKiZ/KR1Fp?=
 =?us-ascii?Q?q7GA3XQvGURV7j/W5iUXMaYGa8wIcNXvpQGCbJ3P6KWsaLpf74mr51OfwM4j?=
 =?us-ascii?Q?zKbDWadoUc4urKMJTCTZCM5kuc6F3viLJEDgDUn8vbNyRExYcKEjJWmypewr?=
 =?us-ascii?Q?0fOu8Su0oTiZOZfMVHsGLaFNf8Z2mnJCYNug/8RtMi0qpJdZaFABhArbCpdk?=
 =?us-ascii?Q?9XdMIbOoKwViG98FVbTg+Ne727g10aap99Kocfdi4ky99t9AyCYakmarUFOs?=
 =?us-ascii?Q?4HmPP3/O8nm/ijlUwhi7FDgfH1vh55kr20TzWPG3hd/spBfsfaaa+1A9+utF?=
 =?us-ascii?Q?xqsJ8B1jf3FStCiit4FhuKMV7nm++a6olW9PsczmYdSEby2Tkd4LvY6XkOqZ?=
 =?us-ascii?Q?7nJEsabgy3fLAA1xSFO+/JlyQeTT1w3EjIUStZEnhG2p18RMuTII1moeOM79?=
 =?us-ascii?Q?w+L47Efh+EsMJXurxIRachjtVSgOTFezGBNl+1fCc1+QKP7a/Nr6wjaK/oMw?=
 =?us-ascii?Q?R5jCH/5JvoVM4RhnyqlTf5KZyphxSoxqiqcSxvIVPa8jLwwmxnFxXZxGDyxc?=
 =?us-ascii?Q?w7uNDc5JiHwkNyAmVLpNck+k5rDP0lyH1djwDpkuV92fuuz5skINjPY8kE4U?=
 =?us-ascii?Q?uAWyH1dA/SSKrj1zoB1LLhN4KvG6f4OW9Q5nW/ViP37UgT0WutI7n+ilZA7N?=
 =?us-ascii?Q?r7S2D8kodFY9ctYcyIBQZsEQI6NgoY4ERqUXtdS7qQtgviZ8AeBnJ8iiUX6/?=
 =?us-ascii?Q?Hxb+cQ+W0upTSwt4ChQoqbEddc75ILTMZKzeII5PkdAUJjAzs4GNeFBgwzqH?=
 =?us-ascii?Q?yBGaI6tnWAfUCRCQFvJ70RCbJlm1Q5w64nHIZfvOk7daj02dkR1f7z745Qzf?=
 =?us-ascii?Q?v815ydggt0T70HJeCrznC74VWmNIZhbYxlwsrmTwneYxTw1XgZfx0mT6ZHN+?=
 =?us-ascii?Q?wACwmEboFRZZEeCMLWq7dhIhmIgiTP9Z62BBbyyaTpscEQjUp4OHlbN/Iz9Q?=
 =?us-ascii?Q?P5+loRJq6Ae/qS9cwupUgtRMxPDPSdxxhu+PM3Ma4jXu8BOYq3Crq5fPkqZI?=
 =?us-ascii?Q?jhCHJNG2ii+4ZTsAWn/ys5//E1rqmU9Brs15GOgszKtGQP2quayhWpisSPoW?=
 =?us-ascii?Q?o+INEZ8WqlkOMZnmuiwPhwg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c26eba43-a94a-46cc-532c-08ddded87fea
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 04:25:59.9143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bnnxtpiuqbm+FI9gpr9OJPf8xycuyYUCk6isNPsg4jGQymJF4IsXFBJAc+BHHjJeDf7DNE1liKdAJR2Og9AW3XD37FA9I6czERvWXzlQo+Z6wFBqkwYya1+CFQdSo6Rr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5287
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

Change is to allow the user to choose speed and mode values
from dts or the default ones.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 arch/arm/mach-socfpga/misc_arria10.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index c442af02888..7e0f3875b7c 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -214,10 +214,7 @@ int qspi_flash_software_reset(void)
 	/* Get the flash info */
 	ret = spi_flash_probe_bus_cs(CONFIG_SF_DEFAULT_BUS,
 				     CONFIG_SF_DEFAULT_CS,
-				     CONFIG_SF_DEFAULT_SPEED,
-				     CONFIG_SF_DEFAULT_MODE,
 				     &flash);
-
 	if (ret) {
 		debug("Failed to initialize SPI flash at ");
 		debug("%u:%u (error %d)\n", CONFIG_SF_DEFAULT_BUS,
-- 
2.35.3


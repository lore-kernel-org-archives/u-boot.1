Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE6A8C5AE59
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 11:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5120C82AF6;
	Tue,  3 Jun 2025 13:55:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="SOLV3Uud";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86E558212B; Tue,  3 Jun 2025 13:55:06 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B42B82145
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 13:55:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkA1+q5RskAtR2Sq39nf1lzQE++XG0e0bAmCqVKTbTh60i/kavsXIoiHs5Kv8Sq5s5c4+k3qQ9BYwK8VUaaBEt07J9udmIVlcn3UL89nD6lpFAKtJ8lKkiilykbigYCrFiFcAaoWJt3EmDsXMNuvJuSYFJYowT1We+z/6HUyfoVHK/ABdQkKe4XRPKRStj86sJuwPlX2ou9iH7HFNktNXcFci8iBh11u37yW5ryQQ2VXGb6PEP4jzfIUoEtrqgxgDBVVg5zuyTAFIqWEJaDV1u0lul0UuUujS/VW/wcTaio8yIpHm2/kUe7FuD4FifYnBvRG0AHSgoox8cdO9AmPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lpJgyBBZHyjCL0nixazEc4930dgZAdWG8v5LZfvP/Qw=;
 b=eFzUf+UYO26kSSMPMChN54mjxQRDUK3avv3UaG7KS4BDSpwo6Ix6RtGQT4Y6ZJrf2qs1RKIdYcG6NgCLFexmj3uV5oROOtOThLF0wccJEgY7K2VF4NGmB15BTyrmcIjDfN4hFggHk10dpFFfz0N3LYKpnVXwQnpWIfV5BzoiFvniCtr1R7kVRBM5u5agorH9trdMvSirCY62gY22SzMkO+NdCmHdSTnD0vRghUxIvNefellzdZ+iiCuGIUAPZ4NDx8AU09UZl0dC/8pFOkV/6TMTwItvjhe0RPBBECj1lf6SpCJFzp/kYjlCRqAreegCzYMvwUQClE/1u71HnGodqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lpJgyBBZHyjCL0nixazEc4930dgZAdWG8v5LZfvP/Qw=;
 b=SOLV3UudIH2BTZcdZ6EDNSGjvUQ73agrlfpul0quFNFDAGVEdLbr8fw713rkGy26XSd1oDXyCMXAOyF5mSdjGYRmjwffmFw020vXB8n54lShustR2QcGGQxqp4uqAXt4ijrOX1FiqLkjpsB+AHQbFoV8PD0aafa/U4w5z2NRie/4nalzTVLDMWcJTWrQ0Jy+1gv2KDahGhivfp919RQZthtJDo+nJy7TvQNQ5Chhi/edRAWkSdt2InaOH9oRmFEF1ju8sliWyX3egOlmLIxtRzliPS6QyLcNEmkCsKNfRd0EOmkrZDrzkZ+Cn7Vvu3Qf1RDDNPLqq52BfPqo4kx+jA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by BY5PR03MB5000.namprd03.prod.outlook.com (2603:10b6:a03:1ee::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 11:54:58 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 11:54:58 +0000
From: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
Subject: [PATCH v3 3/7] drivers: ddr: altera: Fix incorrect address for
 arria10 mpu1
Date: Tue,  3 Jun 2025 04:54:38 -0700
Message-Id: <20250603115442.19971-4-nareshkumar.ravulapalli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0036.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::49) To SN6PR03MB4288.namprd03.prod.outlook.com
 (2603:10b6:805:c6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|BY5PR03MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 6561992c-56fe-422e-9876-08dda29576b1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R1sCDiFYzaQ+f0GucICuMrbA+EYg8sHDAMyWsHeTNrByOh4MZHTZ/2LlPfPN?=
 =?us-ascii?Q?iFcKbKbyK3WTpv+m7SUabqeb/+fS5ZtcK/iJDzqiGS/iwhZClcFriT2ML4T8?=
 =?us-ascii?Q?iL8jIqAlctiRGKe92IxSb3EheljSiCssV9r4SIozD/odeODOd8AhaxpmkeN+?=
 =?us-ascii?Q?9Qv/pK9UM0G9bD4IjMSgtmFL9boxGyOqOUKJd7HgKmvu3lT8Pdbc2WOpWZ+3?=
 =?us-ascii?Q?721LXFcHkySmsbCMfr9RnkRqOwf7w4Bhleft1ialRBx+KbC4zu/mqZy7Dg3I?=
 =?us-ascii?Q?9l5WKyUbpdydTlVPefDosXLdY0G74P6pee/CWg0YL5+4uUHmPQOvrgJFI9bx?=
 =?us-ascii?Q?HZr8doVfd87zgKtdcM/ew6oVRQacZ1BMNGg9vbYqHr6uYJrIb74S55WHPUjA?=
 =?us-ascii?Q?9ozUOC+sH69sl1ZwuiD2p4D6YJaIsFJzhkp+O3k/XoaBYmmok2mtNX/cXA6J?=
 =?us-ascii?Q?/6G+OmMO93F217CgdpfghuVv2e9k05y0ZVZ5A6YyOFkrOpqZ1o2rbe5lnWcn?=
 =?us-ascii?Q?bSebO/6NsPZXERQ1Xmw99CIcbKzAKYd141pMZ9mFzft1ckRx/FuoTi1y0b5w?=
 =?us-ascii?Q?AZyzORyLYGVQSeLhAS9vf3iqKoDPebCe6JQTBecA64TiKWoQcMNMZqnDpXiP?=
 =?us-ascii?Q?OTl/1SsZDsuTKGimg142jQad9HIpmAhXTFnbUPvGrBsdc9Rh51qGIoeaWZ8q?=
 =?us-ascii?Q?xeXTDSK1PZsY7gmVjBcDZkJwglWYEb+nzODHA1i3i7XW1LzysMmwOBuGyW1x?=
 =?us-ascii?Q?VqTU6bcJqmN6Q0nM64uJkX2gavz6LmajWN0FLDwcYlh9TrKX+FcEWR5jsW7y?=
 =?us-ascii?Q?yTFdYK3pftOCjq1YcirA6XKf9xN67tceI+Tsfh+54sSlqjIxQUlL7K7xH4+H?=
 =?us-ascii?Q?9RngiE1lLwwHzbDpm8BROFmeJDRjveJUCYH/kvsk/sdL4X5lXfvkUlC7T1IA?=
 =?us-ascii?Q?ig0h1+eR18mkW4tKFIztmNu8V60+4u1GwDcVedOj6bPsOqBtAa4PF1nXgBl/?=
 =?us-ascii?Q?Ml/ludbb/7f1uQGrHN9/ebtkpJiqTdi4cmaXS7m7KzSi+LqZgMnbf5zyd0kp?=
 =?us-ascii?Q?QaZakN1L9dpUy9Y+/51dj+GsnOFSUTGlpPWJHS6qc8zkjLMtGnOK1ErxKEh6?=
 =?us-ascii?Q?3vKCN5qWuJnKzXKDE4ikPeXuiOs2gNHXnYaZI3+WI+OuPSSJONG/So8jQYcX?=
 =?us-ascii?Q?GFII5JtIzb/2en8w1dqUoWmP7sOs8KdvMKPHIHFSl5WCPhVzViZcEvuFa7xs?=
 =?us-ascii?Q?hR+K7IC0xk9vBL5nzENrAcyQkhF1CsElfKBffKd9CuDVYatCOr2gy05zc4wW?=
 =?us-ascii?Q?336BFRK+SbgHQGIWGL7UPPPSlCu2TH9Atk5Rtyk+plm6SXJhylBUUzVoC32O?=
 =?us-ascii?Q?q+7I6z7XVbF1SGevwF328cIkDJpiR4iC8JcD0oBpiL/6zb+JXe5WfZqjY3oO?=
 =?us-ascii?Q?rmGl+P+P8C0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?giFsPRuP7bEehuQhtZiGRD104E3LL2Q9tPaYYvjbWWczuRaLprqt044xOT31?=
 =?us-ascii?Q?rzqSj5ZCVHiprIe3bjmt4CiZmhLWf1XbNlYiMiuLaviaZEE1XAW+zbkjxRQ7?=
 =?us-ascii?Q?Xfn8Pmbl8S+4sdz8gGo3PyFgmFz2DFfJSXy+3w5qdzQ8dxshTP/PAD64RLjc?=
 =?us-ascii?Q?BbLEZkT/4A3eKha/MHGhvdvfk6xzj2cic3LPuvgPIYHUgxSdyaCMdh0/EUOR?=
 =?us-ascii?Q?PjqTw4MGX5YKcxXI1Mg5utJgylczwy/EzLGayT5PXU3y1J2SMsa5J54MVMSt?=
 =?us-ascii?Q?lnrqrKPlrO35DEc7TCKrvlrAxiU4giB0FsD6NofWqZCZTr2cOcSBVHSD910l?=
 =?us-ascii?Q?zsyThtldF8WCtXRhgzpq7cUJCeFsCEEPVtuFLUXKTZazhX3kuVyW0dyEZtiJ?=
 =?us-ascii?Q?5dUfVhZCTlXcnqVSCHLQuSZ32cbuNg+EnkcSI2LRjbqx/vkz6iLzkuTNDMGF?=
 =?us-ascii?Q?364BP6SoTa9a0sOBafmZrAnkVNUwL3VudOEMalCRkRtO/dqo2NbuVAphIDN3?=
 =?us-ascii?Q?j0bKKeSpN0kHkDLYwndWcdd0w36A1alq86L7WbutkXL4nHAQFREWs5o6w7Hi?=
 =?us-ascii?Q?xFKtHiEVcKdexd9gYkMwLSSDIKJ2wdFEUeU0yu/D9Giaw/z1ICFyA5oX4K03?=
 =?us-ascii?Q?z09JouvTwARtOezd6g2tae57Rk3DrjYxKrVMEu/XwsGc5SiO93KYqQ6j6YCF?=
 =?us-ascii?Q?PMdnA7HBTYljgmKgVG0B560OdUR0nWByRRBCOvxMZdts+WeeJhy2rsOl6lRd?=
 =?us-ascii?Q?M3uur9RD8SUpfuobyRUXnSIZ7GYqrh3iOYo3pgea1/16V9x7zJr9XLRQw2QW?=
 =?us-ascii?Q?062rtttSB1ccVuiEo1HMCovgMePgfyqz5ftg7II7IXk6Ew4DpJfRVxGcQLJZ?=
 =?us-ascii?Q?ZPWJEA2TbFZ4fBIP6kErkyOI1cTZ3tFzxxFE65ayUjMYzsGek+AG2Y79gKpF?=
 =?us-ascii?Q?sQJqzbhOSVvdluSfeu4nZqZx/CeRbVL/UkB5vGCUJkHMPD6IBrirmdBDzt3j?=
 =?us-ascii?Q?9EHOzRRxQw//azrAW2QKviVkK4TvFGBa3+ays7LnUlRuW4ZkLANPdJofeG8q?=
 =?us-ascii?Q?74YB8GlOuXHJRpJog9ptph5NuTx6SZdIwF6QEbhcZAZ7svlIlYwaFf2roojU?=
 =?us-ascii?Q?4zoge2kn3uRneF+ls7PZLn6umqlk+bGjI9CEBiAv/09D8FiW7vgfYVQp7lgX?=
 =?us-ascii?Q?p5/mNM3LrD+9f2oMqmiyv+Iijo93LJ22dF1LYK5Lza7u3nVvI3tmDoG+2hc3?=
 =?us-ascii?Q?ZYDriHzVluU/mUXM7ZTV1kX76r6LWyqlTUbWBuA3Y9L8DjlRZhBCnBjxg8Xz?=
 =?us-ascii?Q?bUtb6v+O+rkMXZ0ODYNnP2De+oid1jiDb1Ld2r2AsFmceYWFsTJ0DRcYA6wo?=
 =?us-ascii?Q?uR/Xpt7oc/5MF4ACef/IKvOThAatbD64IvicqZE5JjfqiCuMJOaC4l32XzCg?=
 =?us-ascii?Q?YgKPYxZYF8Mri9/0ay+0Aw8IwOFAm7e90hGLQk97lO4hNsuyI+jiEWTzdU3Z?=
 =?us-ascii?Q?GYgYpOqR1gYhuJ8IoXyiuJAg0uU3Zm6M/y19pXOAcvS7RT9WrCdY6ek/pjF9?=
 =?us-ascii?Q?oZ1Z7GhKtewVlZuYqdKMQiJfjVF1Tw5GrVPERm5gj3b3rz3l0FnnORzlpFY7?=
 =?us-ascii?Q?75QZUiPC6/yN7wfmwkRXAWc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6561992c-56fe-422e-9876-08dda29576b1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR03MB4288.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 11:54:58.3538 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vprCvZ8OlZmmP37l9ie945G+x56ydiDoliI8UskDquOXEAQepGPqm9HNW2kiHGwysfpCL0fUz4JFkgjM1tcbUhmuGEV8HqkO2P/sXnf+cYVTYO8lX0PFLxe/AaWQowh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5000
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

SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS is added in
SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET() macro already.
Remove extra SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS in mpu1 address
computation.

Signed-off-by: Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>
---
 drivers/ddr/altera/sdram_arria10.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
index 7d7bea153c8..ba6f0f4160f 100644
--- a/drivers/ddr/altera/sdram_arria10.c
+++ b/drivers/ddr/altera/sdram_arria10.c
@@ -477,7 +477,6 @@ const struct firewall_entry firewall_table[] = {
 	},
 	{
 		"mpu1",
-		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS +
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(mpuregion1addr),
 		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(enable),
 		ALT_NOC_FW_DDR_SCR_EN_MPUREG1EN_SET_MSK
-- 
2.35.3


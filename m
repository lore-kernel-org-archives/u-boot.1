Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C329C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 07:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA5A809A5;
	Thu, 24 Apr 2025 09:46:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="DfEhI+ad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1A51809D4; Thu, 24 Apr 2025 09:46:02 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2071e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::71e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E1B78082A
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 09:46:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4rH+zbIMj7oV3vDYrqYl46153mHDGrGbF1qFcqwu4x5kvfnSLdZy6R4EmnzP3drLRdHecs/RmHWrLfNyZJe+CLyeHb4cLkb0K+9p/JpiFs2Or4jNV2EDulrRoyXHHxozFjMZ2iqg3MqPWpiAQMoKOf9Y36A3snXm2+fAk1KVx/7VLhouQW0TBj5nsOdwscJPOU/gbpBy15bMGBIzlSWeXj6remwiMO3Hd2oJBsp7v/w3u00nRt7ARPG1paQSCgnk9Hk4Q5hhNh72gkO4FJUR9++TcDpqroRSbYijdbxunEu3EqM+/xVgcQI+9lMolJmCaLP3GbcQ7mfhFP8Ef1czA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrVgT+Zk7/jaeTi+j+EO++waaqq8ip/0P9uAVWIJKBk=;
 b=hvi3kObT38P7gT9QZ/Mw6zPZjJ6QSi/tM2Ak5Nq6rBN0DelArMG3ePoQLhq1C9EMx5AVBT0POIfwQRPeEqtIt+noxyi0o8v8Oy0Z9p4h/8/hZJto6SmFOx+qKqeya2DLTJr2d+9rx36FXUJF/Aln56+DKoxgD5Ss3FAunrkMimoRrDitnV4jdwlCAIDPfSCWtLgcitWmoQ8WU1C7/b3TYoZtGcjJ983EgptP3fq4vc2OmnWS0hbnQ4PRYwXgJo/YTYPZo41Wmw7DPCTrlk0XH4cR36Jn0vnpfq1XN7OB1NFB0jtzfmjPJmP68TB20SLzHY9nO2sQkhAttPe1XRUe+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrVgT+Zk7/jaeTi+j+EO++waaqq8ip/0P9uAVWIJKBk=;
 b=DfEhI+adORKrnZYvqA6nzDWd0cHxQgwXs0g4E9uKoVZzIY9GapmSsbZPia8VDYSuf74ow3hDJsZPPofjphmu0A0DbR6sWg+pRtV/oGZsrDRTlOLyggu6BffutifM/j5rloEoE5YL6AD8GNse0C2tz4CEGNjm8dWy9/gbizqQa1zdlbZymYJOZkypYzVVdrqs79R01Ght8JLPJFDRoVORuKJBW16Olixsi7tr013gdlOMWyWdIJBjZNDEvpC05IMqMhAN1eeZrQTUF+VD09K/grwW+p52uah/tnS/1ddNon1/2N2ywGGL3URDn6jhjg5sjX8QeFsq/34bJiAtw0f82Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by AS1P191MB2127.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:4a3::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Thu, 24 Apr
 2025 07:45:59 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8655.033; Thu, 24 Apr 2025
 07:45:59 +0000
From: Pawel Kochanowski <pkochanowski@sii.pl>
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>
Subject: [PATCH] spi: fsl_qspi: Move AHB read buffer config after LUT
Date: Thu, 24 Apr 2025 09:45:39 +0200
Message-ID: <20250424074539.12096-1-pkochanowski@sii.pl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::26) To AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ea::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P191MB1394:EE_|AS1P191MB2127:EE_
X-MS-Office365-Filtering-Correlation-Id: 726a89c1-f4c0-4d73-054a-08dd83040dc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ssh1i8O841MqYRE3aWdzF+XLIlo+hTXn/FZxZbQGqW5u6jZf/bGb4hcPLVmz?=
 =?us-ascii?Q?8rAe83fUvcODhrqM5r3EaO6lVEGd9P7EeUoosxEWWj3EkjyWtA2va1oQUTcl?=
 =?us-ascii?Q?7CozjH/CWAYS6AEENKhJ8CBNNM6QGLE2DvTotHpOnK4fo+W0zkekF2qSw37C?=
 =?us-ascii?Q?BCyJ/i94YejsQ2CL/5dkDUWdetXslwtn4t7HkRGsoi032OFOjifhkxth1qCV?=
 =?us-ascii?Q?bR5XReZ1N94KaxvBf4mhvWd7IbtON2VSL2049myIM/mboKc+THuJw5iU/P41?=
 =?us-ascii?Q?gAxaK0tYp+e2NAtZ/LDC7A1BPzxumvQJ4v8elQJxx98Bng8hggmYz1v1V2WR?=
 =?us-ascii?Q?qRkBypaPM/Uv/mauHMHyx1MfoNLD0n3G/RYVNqCLM6rz0gir16artACgr4fG?=
 =?us-ascii?Q?1HCm/Pj9sQDjv6ClnbSR65eeCupOKjn/zeIklLt5MMI3YiJTU1Oaf1rpWoVP?=
 =?us-ascii?Q?4uJ9VGugz8eQSgAXA9t2hDIlpJ9YGGq81hYUwK0NqLLiIrmMWOqSbpM7dE9O?=
 =?us-ascii?Q?uGFb6CDIWVNAOQ/5B6wP2h+15/7/0nbCcnAtY6W7pcsQD3Tg6hGnPScT4z+6?=
 =?us-ascii?Q?RieShJsW8Kkog+sFvoSxRM5fseTazfy4xxxkArLLpd3VcQcxQ7SpvogyZMIi?=
 =?us-ascii?Q?ItCXeGwwHWiKfPcKTBob4ipZOYsLxYZLZdAc4FxnE98gbbTeFItciun9jyqH?=
 =?us-ascii?Q?F4rRqq2ntBCTO61gKtbcJ7rApYg+iPhkTVIthzaok/DC5j8czCuDKulIfemN?=
 =?us-ascii?Q?2g2GrFhTtMzga1oZwMac916iix3365oYo85peySPeKrCpmt+emBDtNmCVS2B?=
 =?us-ascii?Q?6jE43UCVORMLO/zpvW9wx7kxzGoqH4lXU4S8FU1wWxcjATF2pPP5uktBscMq?=
 =?us-ascii?Q?YwHAAkUoGJHnG7AubwBDkCioKxTnMgCkxCLK0HWN1dRcaL4DnT3wUpQVDl+U?=
 =?us-ascii?Q?X6OL+WDZ4J0uRM4aSHUJsDbu0ygzMYxfW4NlGPl4dc74Cfd/MaJ3Fphwp+Ca?=
 =?us-ascii?Q?OH5gYWQ0zjojN18QGAPidlLLS+R6qSHEow/bWCy+SnQ+LD82FYT4mlscuDF7?=
 =?us-ascii?Q?zWkd6oYxAaBHbMKxI7KaXv9h/6Wv7wXfirE5h75xOron/VJZFNX4W1xGntr4?=
 =?us-ascii?Q?lK1doa0JYZe2WRB8BL/F/dhpAu/YjvY0Qcjrxkyimps7YvWhB7gHMfSMZRbu?=
 =?us-ascii?Q?tvuOCyByaEd2k8JrEYv3Mp9gh1tku67TevriJXmYwocisj0h4nieWvsfFJ4D?=
 =?us-ascii?Q?dCMDZmIrzvmwgkAQm1swDXAoZ58CzVocjbhuoc0OdQMV13xjOUSoABa4ce5z?=
 =?us-ascii?Q?I4eT2xdyrOEiQNi3JJH5UdOQNOfCYRoY20V25Fq4RUz2qiubomau6IkQwZOg?=
 =?us-ascii?Q?Y42qQ8C/6BTFznBNISlo8LD3VzkRHvEVJYPMCxWowyb472R9kcVPLxcOwMh8?=
 =?us-ascii?Q?P4wMKdVQd0V9ftP7Ru2gHA7dyb8LFKlszUxMaq1wrdL5PfQ2Z7/dEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MSVVXKzFYna2WEZlMZFGV1tOvmcNkflx1rW7/DCdeZQi+vEYRNlY7iGFbuc7?=
 =?us-ascii?Q?7WKPbteB6E0Z9ts0xm8AcnISMmHa5Dhk+8ZkRUSIaxUetp7cR4qabBdNHWv7?=
 =?us-ascii?Q?WkmXVrhnHGipKZVFhDAFZ4ZYFb90LoPka7zMFodl7a+8rSrzE8HO7PvoqiZU?=
 =?us-ascii?Q?aJoNThJJcOh2cFjvef8esbFXWMSoFusKgoOoKf8X2dgtSz4LRlQJrX8+ZkWv?=
 =?us-ascii?Q?tLU6B2hxv2fw09ECLBnQLbKryUGfHbUQXz/Z0eUP0us8b1w0Mni4p1/G+Y0O?=
 =?us-ascii?Q?29XS+FbU07Nn/15V1Tov/5NPne+RPvI+Wuaz/CMBNMzBskUCVrE5BnT1gGrX?=
 =?us-ascii?Q?rzAN9YuWIIvRwsvXWrq1Y+j3qulOnd0h7uOl4lC49Vs4OfnQrsJHh2JGEMle?=
 =?us-ascii?Q?+yVR9Kqvx/doM0XOt7VRM5X3ariZdtVjs9ypGhUsB+7Hmv+AlBdAdzjyL+Zo?=
 =?us-ascii?Q?tPGeq7pWvGCe8079sbuZO049iQMRWK1BefTq7+xICUwQNcRJtH8c24YYNxS4?=
 =?us-ascii?Q?lnZHaPOOGHJSbhqjncifFp8+cakEuhzQvYao/9jmV7hVRadyyrBNkf5oDA09?=
 =?us-ascii?Q?t1leWbyqJqvB53GJL6qmdhvhX5PzpHYag0UScSl0mK3DzMmculbFGp+JPvuk?=
 =?us-ascii?Q?Iy5sZzrMflfMRL9VTajUqn8X69mpBwTV8a4jBQq6uScbDW27nAgAqpBVgAcu?=
 =?us-ascii?Q?ymUQ7lKyRN/oGW63b3vOmigTO5yOTcaIpuIaUPvvIQm6g/JqI1u1jiRtE6W7?=
 =?us-ascii?Q?GJG7ONInY2KTsmRmt9cvC+saZDihrHADKjB74CEeNuyPyx7Zu39RDc/pqYch?=
 =?us-ascii?Q?bi3Itse5gOdJ0g1ef/G1qx4MX3DO9LYfEQQOGkf3mkeWWFDZXLp3J9XIqeQC?=
 =?us-ascii?Q?cBqcnkheimNEikFb8dxzNlVvv/HfWX2Ss3/Zl1E8kLPtMoLzi4+SnQVm92EZ?=
 =?us-ascii?Q?NZqIVnHMiCyDJQeSQgiNmxqNhQJGiaXhjMu4ltOUp9S4nG37lZd4+D7+dvqZ?=
 =?us-ascii?Q?HHixyTfblAxgyociok5ZpIVZwNG5C/bUQp/mbzwKkH97MYGkC9RGmcUuWime?=
 =?us-ascii?Q?YZh9NQASiusfrhPTo7YiqPXGoUhZJ16V6dvZKZ8TfD5lkZLWKwS0g3y8I+LP?=
 =?us-ascii?Q?Ahuy5G9dgA0mpwVuGjiEFrRkwhTcKTAxzvasDic4sWyfk5xT0PqCh4A725zs?=
 =?us-ascii?Q?MMHx1eKj/GJMlVNll6uEe4YYV9VmZWeGIqElCD59lJVKFQ1339nZwBQbajXV?=
 =?us-ascii?Q?bLTgYHHBo9P4JP3rQSq+xMa45i5w99iSdjIKJNCqRajk/ITx2L024da944GO?=
 =?us-ascii?Q?0hEluFwORxICUT6SdKO+IG5IFq5msTMQU0XbAgdpLqEh84kl+0nKdgXPPjt2?=
 =?us-ascii?Q?1mYyo2eNdr6GYcZBypjpCykROY0XLQKmj33zEOLJTJ1vPALDnOCuTbkvLInk?=
 =?us-ascii?Q?pHre2hshmF5OhEYLHrDMn9nJH5iH9h2fcXDnwBUFLavLU6RiMyc9sghh+1d+?=
 =?us-ascii?Q?t17kB7DWUehZ2dAA/XM5IsElZl0Ijl2rhMY8Q4iHzsb1PBvnl3LuP/iZ6e4d?=
 =?us-ascii?Q?LgUiyU+l8nzm5S2Bz4mIlkUXP8/HMMp1eZNqH4OF?=
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: 726a89c1-f4c0-4d73-054a-08dd83040dc2
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 07:45:59.1747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6j0+bN5PzcBBM3iGEnfxzuNwjaMrmXl/Y52uiJEqnykHSBWW2uYUG1sQa/Fc9JdsT68WC3FBY6CbpumS8ozM/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P191MB2127
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

When using CONFIG_FSL_QSPI_AHB_FULL_MAP the fsl_qspi_default_setup() sets
the BFGENCR register to use the LUT(SEQID_LUT_AHB) before the Look Up Table
is populated.

This result in a situation that after 'sf probe' command any memory
read from qspi using AHB will result in undefined behaviour (hang) untill
first 'sf read' op is executed.

Move the BFGENCR write to fsl_qspi_prepare_lut() to ensure that the setup
is consistent. AHB reads will use the default LUT(index 0) setup by previous
boot stage untill the first read op.

Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
---
 drivers/spi/fsl_qspi.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index c7f554826c3..65ab3e306d7 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -472,7 +472,13 @@ static void fsl_qspi_prepare_lut(struct fsl_qspi *q,
 		    op->addr.nbytes) {
 			for (i = 0; i < ARRAY_SIZE(lutval); i++)
 				qspi_writel(q, lutval[i], base + QUADSPI_AHB_LUT_REG(i));
+
+			qspi_writel(q, QUADSPI_BFGENCR_SEQID(SEQID_LUT_AHB),
+				q->iobase + QUADSPI_BFGENCR);
 		}
+	} else {
+		qspi_writel(q, QUADSPI_BFGENCR_SEQID(SEQID_LUT),
+			q->iobase + QUADSPI_BFGENCR);
 	}
 
 	/* lock LUT */
@@ -737,13 +743,6 @@ static int fsl_qspi_default_setup(struct fsl_qspi *q)
 	qspi_writel(q, 0, base + QUADSPI_BUF1IND);
 	qspi_writel(q, 0, base + QUADSPI_BUF2IND);
 
-	if (IS_ENABLED(CONFIG_FSL_QSPI_AHB_FULL_MAP))
-		qspi_writel(q, QUADSPI_BFGENCR_SEQID(SEQID_LUT_AHB),
-			    q->iobase + QUADSPI_BFGENCR);
-	else
-		qspi_writel(q, QUADSPI_BFGENCR_SEQID(SEQID_LUT),
-			    q->iobase + QUADSPI_BFGENCR);
-
 	qspi_writel(q, QUADSPI_RBCT_WMRK_MASK, base + QUADSPI_RBCT);
 	qspi_writel(q, QUADSPI_BUF3CR_ALLMST_MASK |
 		    QUADSPI_BUF3CR_ADATSZ(q->devtype_data->ahb_buf_size / 8),
-- 
2.43.0


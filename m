Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0237CAC5A7
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 13:04:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B3C283510;
	Tue, 23 Sep 2025 15:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="x/XuPqdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12C5B80C93; Tue, 23 Sep 2025 10:00:57 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 283A18004F
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 10:00:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mf9hXhWlqtopOMMuVM4UnXyjbD3LahbS0Dl6eQQCS1t1ceCDE8ZtGNQDRk3q9N/+8ZizkMA3YcavA4/t3a8Lt2qsAMJ5TZQYGpYsRKEfCNVUh5PteAHqs01uJwLh4qSLrc++fpl7P21eVEzEHkVFR6UndRk85Bi+vioNtbB2tkBXTASD4Eve7KXPeQa5i4fNrY4hy91zS4Zd0DTcuRvEkhj6IGGKHXttxtYHn+H0hKEq7C2tasGPeoHUpAdnothjSWOzxCJNg+98kTl3JF75CDK9iKWNXRaTDFAOmUd9NuYiLhoo5djWXeMjUl3cEYdT10Ouj8Kwco0eZdmmczCcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uMs7HVouUyVe05lZJEya0eVDRkWvunKPuzpEGxhRno=;
 b=tgUbenK8M6w+MvqLkayWw2NMwVuWiSz50fteyUXFW7fA2LAXZz1H8xH+yfyjc27qGvffV9kltcpSjaCmq20jyrvkNNQya8CE3cnku3a9u4aZMM98XWy/AyzpqAh13am8IrfwyOR2yVV63+LRyC2XM8ZbY1O97eKACyIF2982PLdgNtWoAIZHa4p5XiQpffeBIAkKbHZNenv4yHzaopHCMEdI7T2tI1Eyah20hIn1q0wp5nm5Y47422Yg8TQCT8yfanu5Zvi33EYQjJ8UEXSfqLPeWyFagwUfdsia+2P5ksd9RV6cFt6sRiWD2C3FcuCAr5jd1QvQs8brBOaJnKzESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uMs7HVouUyVe05lZJEya0eVDRkWvunKPuzpEGxhRno=;
 b=x/XuPqdc3km7jUicKkoPPlZqGwDb1yB5On/yAMDvqCqzPqyxG0IVm57qznglsMNyGhEr1/4uFpRArOsDrHVyemB04DNNYsCuVAI9KkzJzEt1EsAKFWT89CV8tLXVYq3Ln4Zz28FCz8JModvEYZ+wdNxLINYaUk1L1Y0190WgDqAb8/SQz6WJTJrP73ybvjWznjGQZZiLM3oNRvO6tTh2DyF4K/0XtnuUYqtC9UPhWpD0WsVJJEB4QY6gMv6DGdfAv7iuepbbBoxngHzk7TJbeGeIkwxqpv9mWvFlGVZnmaxtdwsOpc/YmkgbLrLJY/j8Lunw0lh6dwlb6my1+HkhsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by FRWPR04MB11281.eurprd04.prod.outlook.com (2603:10a6:d10:19e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 08:00:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 08:00:53 +0000
Date: Tue, 23 Sep 2025 17:12:38 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Horia Geanta <horia.geanta@nxp.com>,
 Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
 Silvano Di Ninno <silvano.dininno@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Tom Rini <trini@konsulko.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>,
 Olaf Baehring <olaf.baehring@draeger.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: Re: [PATCH] crypto/rng: double the entropy delay interval for retry
Message-ID: <20250923091238.GF31170@nxa18884-linux.ap.freescale.net>
References: <20250905093348.204409-1-gaurav.jain@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905093348.204409-1-gaurav.jain@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|FRWPR04MB11281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8589c762-2309-44b9-b0c0-08ddfa77515f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rm0Kf+KHHvhR/53oHuBykFIS3N/FZW4+v9k+MySeHxkdUL5f8xDdusZKIr8F?=
 =?us-ascii?Q?VCNoMIium2ebNie5rpcnJGahxDnYRZJDpzqW9B2z7k6UM6XpZ+POtY0PAMjq?=
 =?us-ascii?Q?kCxC1DH57voXwDBpvkwIz1ifUvX0O3xNDCuLc4aFGJsJjJXfvKZQho/VBIbQ?=
 =?us-ascii?Q?ZoBQyJZTBfHv1uooHS7rfnv43alpgoZe5UNipJwWFtukqbHLy67K7hUPWFXe?=
 =?us-ascii?Q?/vhrqwiWVTYCO+u16SNSLc9pJo7G8djRp0VXdpRBjkJdpgWCDKIuGX1WefRx?=
 =?us-ascii?Q?ODmbCWcq7ObSZGIpSMvfOV4n1znN8qA39daYp/3YE514zwYaVlVPikBgLCWu?=
 =?us-ascii?Q?GbK2EtUa9cx3qrJzkCFhkxB9M1WZQrpU/AZJlempGTsvwXdPLT1fjANFwWkM?=
 =?us-ascii?Q?2qUG6iwK9mZxm04zuve0P0lIX1LJhyA0OyoZYb/BYR+mS6RHFS2au247Il9h?=
 =?us-ascii?Q?DWY1XOfE9L3wtwNpfJlMtE29zq9yNRTVA+fbpPkEj4bBxy7oYqP0P0/hL4nj?=
 =?us-ascii?Q?lSL9Dp3TOohhzwQeGV0LZWq50pQXdZkKxHFy51zIiulslW1NXe2mg1tzQyTh?=
 =?us-ascii?Q?2GJdjIldQ3p4iqjdrZ1oXpESLnpVNldfZhCfWloGN9LWGGUxMljqFet6iTX3?=
 =?us-ascii?Q?ApgXzbpljm+DwvjDummfJPV98/3rVEiACtqZ0zNr3lUrU3gmAZYWyTBtDImY?=
 =?us-ascii?Q?f1ucEOqOwLnaJbR+jSshKTTt8g/f0mBZZjpbR19IqmyW3d1ZdCG+Ij330lgS?=
 =?us-ascii?Q?+78SHr+zqh8L+b2VW2c5TBOHmeKjwFRcSaDbE+lTzuA94jVeD4/+BOQ4sM6c?=
 =?us-ascii?Q?OBi0BsWsysTKUEITXZu1yfoivscRLO5MHPxwftzZYj4UxjJBKKV9+mqxhpHj?=
 =?us-ascii?Q?Gj6AP84BzvieE0HKZZbDdVXu0kMUb+lBlJ4jWZQqBvYGd7bfD24eTxnPujbB?=
 =?us-ascii?Q?vOqxjjRG2zi7IiVTc5Z50FMQhh78vbv+j8zwsw2HceXNc9zk/WHzQfrEkNvC?=
 =?us-ascii?Q?WE0KmRgStYqgudg9HjlKBaTjFc458H47VmolAwWWAtOS+KUdyat5hgGe7tMJ?=
 =?us-ascii?Q?wyUzuiKY2XqaRfXr4HrzwH0DvE+QMFW+RDPHQ0t00rPORNntoasESumgmCBH?=
 =?us-ascii?Q?25OkhPr5ESWQHBZwiMj5+RSxIuFR6e1M/q7OUYwZDKU9/2zjRbzHvjhp4Rt6?=
 =?us-ascii?Q?MyxxBvkltX4tbB2vBdNsWCYsgT0h+MLc2t3flFWpI7iZHD+ZkUDeZUDkAEB/?=
 =?us-ascii?Q?5WZ4PAL5+ltCPsuE3MSTTbA9oMHGafAE66RXHJlnlt+Gj+GpX8iQ9xl1Qxqm?=
 =?us-ascii?Q?Ta9Spvz3C7YVZY4U232FaEM2n+JGBvAxee4mHIKB0jH3AesFVlfzYIjlFmXx?=
 =?us-ascii?Q?x0iEeLsDDH+8ac1eGNJmqqt8a8QLUlkbeBatY7kHaWWs2pS1tCh1drpAzK2d?=
 =?us-ascii?Q?swxaf8RZHbt4b9P9afYLYQ6x9k18+gWXRfP47mAzEPhA4PSy2h3ArfV2SOj3?=
 =?us-ascii?Q?EbLZWWGATlMv55s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KdqBBULqr8W+KR+nB9PTNum7I1U0UIrK4ElNu2rzSnZCrSwxU7yYCOeNuJnP?=
 =?us-ascii?Q?TfM+DRB61tfThG4I9rOQ/5oRPEedxZaRWNW2jbNuFlEa5zaBG8Eam2KhfhLn?=
 =?us-ascii?Q?pe4q3oc7dM2UXW66u8D4cM9FXL61Gt5Uy8vAz8uKnXTBWHOsllth953sa150?=
 =?us-ascii?Q?fkMuNL7P079IZTF30TrLxBiVIwgk1RNTXdYAqnq2JoXQddk2ovafd8/yfBuj?=
 =?us-ascii?Q?om4w+1DtuF1fVmkv5T5I5YH+wFC6avyB26GW1izEMQ8KQEvKwhmH1xf0DCWh?=
 =?us-ascii?Q?OClSHKMGx8HDFhAiUNT3uuelroAJACmAM7nps8SgPy2N5ZNZYw4qcIS75ir9?=
 =?us-ascii?Q?HZMeNhdzdFXei8WBBzfGPnY4tsTZXLjucM/Yp3nR8ZAunU6L/KeCDtMTtnPk?=
 =?us-ascii?Q?wLlkMk+JMyr9wUGntpd9ACc9wHr88CBfemYZpaVY69+AAOWd3zxQbTjT/Dli?=
 =?us-ascii?Q?q6vYaTXBcEnvUrodIDPZ+CEfyuW2b12D5TJnZGVsEwV9Qm3O1xpHOyjMcitJ?=
 =?us-ascii?Q?Ou9FsiR7uCoMyOFnie4tfU/aCWR6lLXTG8KX0ZmUy5dLSTFO3ZRrZmZR3GZN?=
 =?us-ascii?Q?pfHU5k/zMnQ/q0tbV82RSqhuMdtX5UyQnpo/yLjwCj7Kz/chJDL5+GG9lEAE?=
 =?us-ascii?Q?Cgu6nRz3gWEOceiQQHsfZcx9LmXUlJ5QZVElCX9/BduMydGGmbheooRC0Aq0?=
 =?us-ascii?Q?pSWi2+O34TDbbky4nPrJKJrrotwo925CvUzQxzbNryqA2LKFEsaXM2vBGXkn?=
 =?us-ascii?Q?4dag1QB4tvcAeom4lbmBNcykdNDnhKbGArgJEvLw7mS36YSB60Jk04KNeNWc?=
 =?us-ascii?Q?N6ajVffbrcp6h/lC2xH+eMTCv3gXJGspPL5Bv8GkvJR59ehVEQ02KhD6CAIB?=
 =?us-ascii?Q?p14zJxIeAs0VopOVKiP+Q5s/HsplYiOS7ETfqGAiYhEwJx9Sx9E6qFJI8HbS?=
 =?us-ascii?Q?tMfJLivVsf+VABzPmo24YN0TNaF/cNIwuJI/JNY3k/hYopD8hn2zgpaxE4L7?=
 =?us-ascii?Q?cvyADEXDx05ZEQ7GY0OZQfzOXCaeIlMs49YehXilQHCSUNkZ/0Ir1iRxS2vI?=
 =?us-ascii?Q?RelNMosVejPjglKHvQS+uMGdNQmIIEpzgFGOYnceleoQxsWOVaZZLFieq9WJ?=
 =?us-ascii?Q?Oz/QE3BJ3jfG6ITPOXcN13JQyA8sz3+c7ArqQ6JaR4nUmoQhXDumiCtoA786?=
 =?us-ascii?Q?3zhjUipxcr8ANOTmIN7ujlMGUSVlUg8qZ6IggxwolvFdX004G5RGIr5RpILz?=
 =?us-ascii?Q?+5wpUCAje5hrR7lSXT2j+my61j10q06Q5oaKPv5LhEJfX8MmacpomI0FiXCC?=
 =?us-ascii?Q?fRYw3vPCRh61a9aNHPIiZzjbHWbbLmb16JlA1tXfbQNkDxpc6vdJfnKjPNXj?=
 =?us-ascii?Q?pg1ZsDKcvr2P5Zd/63jx1hAUU60mROEVEbIZJUovgAnrG8pvuzKcR0oXZiIe?=
 =?us-ascii?Q?Y+Em4t03BkYrhpeBzUzRTATNFZT2ovFDQhi5KxwTZu33EUwATz4OJ81SF/sy?=
 =?us-ascii?Q?tBVQjTrgkrYi9AMEOCmiICxQeQsXwZ2feK3SiLEFxD/FC2LClns/bxLbHliM?=
 =?us-ascii?Q?/C7V3LI9mUfNyro0ZR710Y0xkybbip4Metl3S67I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8589c762-2309-44b9-b0c0-08ddfa77515f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 08:00:53.1828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZ59hzg1d/N907h2OJFnS5CwSHE4OZ3wZ8LyQF8JuleDDuiwzX2JcUDwusqOoNhn782L6LPRo4/2it+pK9DkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11281
X-Mailman-Approved-At: Tue, 23 Sep 2025 15:04:30 +0200
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

Hi Gaurav,

On Fri, Sep 05, 2025 at 03:03:48PM +0530, Gaurav Jain wrote:
>during entropy evaluation, if the generated samples fail
>any statistical test, then, all of the bits will be discarded,
>and a second set of samples will be generated and tested.
>
>the entropy delay interval should be doubled before performing retry.
>
>Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
>---
> drivers/crypto/fsl/jr.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/crypto/fsl/jr.c b/drivers/crypto/fsl/jr.c
>index 8f7a821ebf3..07d336c074a 100644
>--- a/drivers/crypto/fsl/jr.c
>+++ b/drivers/crypto/fsl/jr.c
>@@ -642,7 +642,7 @@ static int rng_init(uint8_t sec_idx, ccsr_sec_t *sec)
> 		 */
> 		if (!inst_handles) {
> 			kick_trng(ent_delay, sec);
>-			ent_delay += 400;
>+			ent_delay = ent_delay * 2;

I not get the point on why need to double, would you please update
the commit why not 500, 800 or else. What make ent_delay * 2 the best
choice?

Thanks,
Peng

> 		}
> 		/*
> 		 * if instantiate_rng(...) fails, the loop will rerun
>-- 
>2.25.1
>

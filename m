Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFDCCCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C8D18391C;
	Wed, 22 Oct 2025 09:21:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GY2yH61y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0122D83303; Wed, 22 Oct 2025 09:09:53 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CA0882E34
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 09:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2A5Qle/EYGLgtlP8BfoOM6Ri+QmrkwGgOCQrtjJvjVdg5/4xHtqoXVZC8IKmq/M6A2WhIgIA3AlZ2a8pgWgExXvSZQUo5hxED5XHJeLpe8x3yaa5D/NBKBjGDaSxd9rAMz0fE2v04c1VjRCPL9zoHW89lQ6PsgaNY+whWAOZuICbixXMTocuDGWU43RN56ymeXVoEcjWEjZ1sRhjlmyBaJdb6Ta80YDD4HMbqrvVit9FYORfuNjnqzQsVI4vdtPtsuh0vNLrncXeD+MkEF4a1xWLVB3gPggAZCe9f4fvlbIa3nSa/NuZ/kD0WKREgBetV5bxTbNZ9Pt7fjfhQgn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcQbu1F/+rJ8tQ8U0wcbul4sgxW+fSIJ/wBQx4tzs/w=;
 b=IkXVNj4hDbY1eEP9XDZXdLpl708KhwL4+DAr62YJPn7tJKrb5QKwwiaU+B/eA8PB1kuQy+156FyEGyWikb7XlG2Exe2DUF2X4BiDVgPCH4AbCjqlGxJk/TlDgtJRr1bpLgs2sANyijQaWqQ30g0jM24kKanAq5D1TRCMarjrblxp+rPchdgzaNXcvh5EYO4DWgu8iV0HYBv+v78dTsqk8L1xqe0IxiNGkymGRRGlFh9iOZRUH4sMhvazT0l926y5zFzSJ7m2gheVSDrX+1+Wf/REaLYm18OJ1NT5t1cWOhiFmDTeRURSIzU3Z+HOf6G9UmkFa3v8FAD4PnUklHQaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcQbu1F/+rJ8tQ8U0wcbul4sgxW+fSIJ/wBQx4tzs/w=;
 b=GY2yH61yeZ2KZnctZR7Ke2OntHiKfOzTMk6xMxVYjla+d/jjmtBWSreDMi6kZ/ES4k+clPaA803Vi9akhKFJIOXzFYhExHO1pqh8yDW/sQlyMHJtdq/dqA0XmojxlAQisegNm1OtV51VeCOJodDMVZvaX0SwBL2pXHyKzTEJjOxs2wf3+3+NmmfPmLpzJenhASwiMlfPsdA7BqJp+hgTwWz41RymjywULgOk9Ni1LjIgggfCPA98zs6Qo+IAGoOIeNYUrjmDX8MvUH1t87h/SyVH69LzVuJltQtYA/+q6hq0cwfvrvhXdoQWN2jXKaXxOPs/m40EbE5qhYlFRq/Jug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 07:09:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 07:09:45 +0000
Date: Wed, 22 Oct 2025 16:21:59 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Henrik Grimler <henrik@grimler.se>, Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH 1/6] power: pmic: s2mps11: change the probe function to
 bind
Message-ID: <20251022082159.GJ30163@nxa18884-linux.ap.freescale.net>
References: <20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org>
 <20251017-power-pmic-regulator-s2mpu05-v1-1-91cadc0f4156@disroot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-power-pmic-regulator-s2mpu05-v1-1-91cadc0f4156@disroot.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:195::16) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 899bdd47-7912-4abe-280a-08de1139fac6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oe311wc5MYYHO1hMFUgj8/l2DPYEnXnTVhFtDO40KYo5Q1+qdO64rzc+EyvK?=
 =?us-ascii?Q?nWBUug26yNmKTJf4e0o9Y3VoEy0OQQoqiI3jVoWr5qzARTlYYf2XFOPDNqwq?=
 =?us-ascii?Q?UOhBjeN4xaRG6zs1YnZAL7agUTLrfJdhs2F+E1cUa46qP/kJA+7OOnJDqQ1T?=
 =?us-ascii?Q?CJEk4NeEn6iLx9ARCFVX7xm9H/OAPrvfXvXQ7rolRhNRnAsdZ5OqV5b/Z485?=
 =?us-ascii?Q?cyC/vD8Rv5glsaYgCCBQkpY92oi7d6SJYighfPJQZI25/g39RqwKsL6WEpHZ?=
 =?us-ascii?Q?LmXrG8CQgZFfMThWDjWerDNsUEDDI6/wsYDwx9BApoPFvSWxSbPtzwqAy+qc?=
 =?us-ascii?Q?yMjQuBtu1Yd+Dy6Cc5le0DD7E9qgALxn8GGnaYZwFA07rZlyBVbEyRsTbMf2?=
 =?us-ascii?Q?fxv0yKlYHnlt6LBRICxlIMoV6W6wOQDMu7Y7XHkkTGtDhk7KQOe9udvICB08?=
 =?us-ascii?Q?wsU/eWBzHZ8J0liFuZDsCLL4zkXu6WUzj713yayIRYf2g80x+7yNjZ3wxJBm?=
 =?us-ascii?Q?vFO/9TkNpF/jpiwhtVIGus3ZvzGDQJv7rAnPLY1+RcdkBOIJjnfFSM+fwvOF?=
 =?us-ascii?Q?SkSnbMf0aXB4XZ4WZbHreGPIspxw28RlMFa0eg7/N2yq6oLiuDR3op/m2uMk?=
 =?us-ascii?Q?j9IVM68esWPJKRcfv7hv086CsmWsZAHAB07K14Cdkz4NdyUisXkJBfE7wEUe?=
 =?us-ascii?Q?2JmqeP1mIXC8vx/+3zaYYBUi1KyhKlAtIq3J972O8lQQa/6dSQ1Nh0IceyPQ?=
 =?us-ascii?Q?S4J/SLu1GzvTAqngeP0tEbewnqQUDSeT0PGW0ZRAx+GsiJWNjMOLwr89ICHC?=
 =?us-ascii?Q?XLOh6qfwsUwgpOf8KxJPMW0c0xMW2mnF1u7jpsM+YyNzL2U+IIK0b1QKg78n?=
 =?us-ascii?Q?T2bTGVQICo+lOXrBs6yjpvmWjgbxaI0i2GY/6KxCRvgHinO5EK2ELWnf7vln?=
 =?us-ascii?Q?onJL3rdNvNwlAsugJuQ8/OB3XTYY2/gNACHJEdQ3DNk2vely9DZ6fpBdCEdr?=
 =?us-ascii?Q?LSpdvU1Fj07u9akvw0mt0FDDt6Y8euEGkylwVQpE8NaK1DM5S8nwUIdbaYFo?=
 =?us-ascii?Q?1xW7QkcNp005ETEiXA+AQWkeEe22rgB9wrsK+mW0933E71ZKJaKYPSYqpyjL?=
 =?us-ascii?Q?9acywcHx8G/WzBj/r1p795+V+L+YRvO8kJ2UzjeEc3+mswa8FYNh744mRUyd?=
 =?us-ascii?Q?QgdkgMxbpq9siZdeMxDuBgvLsxw2GvU3GF3EjGiA3o3PEMut9VA6oqYBQzg3?=
 =?us-ascii?Q?wM0XNZjfokaBiHGTYaNh+muiGXznS1rTkmawGM2ffeJnOTJYiEdenUJAXhDT?=
 =?us-ascii?Q?N1kGmvQAS9hWS9UQxCOEMLuZB4MZrWwWlb4QYvrBJ/WYCO2QWR3Jt5NXVJ2d?=
 =?us-ascii?Q?Gpze0Bp9Goiq6toEOWeUVr2ygKLfpYYCy5545uraJiOzi7JhAnqiUZ8RJ095?=
 =?us-ascii?Q?FcwUG3xiDCd8yLKOE2DxoqWlZmcQmyL7IjXbFnKS2Crt7HntC8mWbZwIsnRt?=
 =?us-ascii?Q?UoxoviqV0ViTkBQzqa8TcpSjyYxzXE1ZPrsA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67U//mNFebotOaaOHVUsO6NUc/0iI6OEvw3AKYjhDqwHIfNjwpJlf/XJRDNi?=
 =?us-ascii?Q?lhvuM5eyqVgGz9HHT8obHY3GVV4csEXUGJbfOBIlrnRjFs9l4cf86yr8P606?=
 =?us-ascii?Q?Dy1hRH93OY7Tt8WEfKwEke20/8+ox1BWeLhNgvaZzXHbjRo7IhC0NTQ3Dk5Q?=
 =?us-ascii?Q?684Kswp5HP+APJJAxJZr23mZ1hx3jbVwLcASL8ggVXdTImHGXStEFReEHObc?=
 =?us-ascii?Q?q+Hca8zktQL6raDl8+LcHppH4gX5MEYezO1CGCL77A38rH8mxCz/JCZ1SZsV?=
 =?us-ascii?Q?2TwI7yqS57qFCtnBusza7UquHNaXISG8qZjxIJloRdet5IqZG+OnAORr4i8n?=
 =?us-ascii?Q?cve5LGI9+YbzRykKp1YhBru99oGSdUmpjVcKTU3RYB4nuPE6UgwvvtENOTRo?=
 =?us-ascii?Q?KitgjH8cmtvOC/zSCdmPP/V5VCJcfGNFRQuhH7o9FDuPxAVfC+HWJhMmOp9M?=
 =?us-ascii?Q?rILQffUNRTpTpZSWVqNHYeWaDfG5CU2flJx97h9bRi7Xa6yPNnCfra7lcRow?=
 =?us-ascii?Q?OcePykTdRe48vNpVQAa5Wda3j+YYi1/aIGEPwEV2nJ5S9o90Sm6M7mgdC4xg?=
 =?us-ascii?Q?gvktJTqDVZXta0Uh4swemn/kgDLgkameJ6an43tWkE9KtGxg6fGLbPF7jU9v?=
 =?us-ascii?Q?QWCoJHGsLJvAYvRMFBy3FanfzoUToVbplAfHVahABZrg7wxLlD9Aiv0OmafV?=
 =?us-ascii?Q?oGzS37iFf+5hX7zGLzJD/Pvv0/vesK8Nec2QW/+xVeEpLhMP8amWmzdnRnFT?=
 =?us-ascii?Q?qKMT4ikdJzlgLOWB7Kn8MsOvFhe2D69SNrm52/Z2QbZEwuIKa3grf/YovRYq?=
 =?us-ascii?Q?D2fhY42n4cIrB0mEpwdoUWR08t5wdETjiVBJ682i/Y0jFs/wnYA1cD7jNamu?=
 =?us-ascii?Q?W17tRzBJBDh2YJhhoJOw0GVFYS3zA6nTogxDy0yCwqQITk9I5eQ85NpIM49O?=
 =?us-ascii?Q?5Q4Gp00B7EtMbXs3CQqlT7dxdHYPvnBitxwBo2DiMeTqTIpeCEaydzaiNzuL?=
 =?us-ascii?Q?sd4LAc8Lp0vIjXChqmY0AFTp1CQTvTyB2dla3035zKJ+8l3VhJadUYQVqhXa?=
 =?us-ascii?Q?v4nFVPPfbhz+vnUb1uAHjOHoFlf+DvzTAvxd6aAJMSKyqJHhAbPPveFR349e?=
 =?us-ascii?Q?dFHUSEkhVxsv23ldQtzvrhKjTN3tIK5C+iMKMnysrlyznCZGmnoHfJ/bJPem?=
 =?us-ascii?Q?JYY2ZKHI+I9TCmeot5d+7eou6ehzLoKK8K9SPwDkUOFWzPFdwj1RVZ2QJSc5?=
 =?us-ascii?Q?AY4HAuyHPRAFx8MalJVCX66GfeQF/JOZkuUUXtejkCWMvYYD9o0o4KA8vkYt?=
 =?us-ascii?Q?jiaJgTyZuCBxvocNOvbt2ZsHDFwE1MwKxF10fLQaCu1AMlHOyVaDMTxPQ7lE?=
 =?us-ascii?Q?iUcO9bquCfS8JddAM/GcnqX73akhnlMhyMVDsMWmgjATUbkQEkzpCrtAmEU8?=
 =?us-ascii?Q?pmifgZUBOKjC2X9Spe1+axkn6GltLVFJvllpR73M9M6JO+orNarGiz8ooeHO?=
 =?us-ascii?Q?0HuVmx5MFh9D/eA4PcQtgt7GKf+RfqnQtXIRs+BOf10noOsoM3BSnm2TYIaS?=
 =?us-ascii?Q?qwadbT+hcZBoHGbr2Jvb22Cl3eh0VPVxpou5O5V4?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 899bdd47-7912-4abe-280a-08de1139fac6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:09:45.4244 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2kCzo0y5G+Rz4RoOPfvnb1VO2pMu76wzqBoFAgmvFTQ8o9RGbOlRy+CMwHYwDHvvP+w1tz1fXODT+U4GncW9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

On Fri, Oct 17, 2025 at 08:58:16PM +0530, Kaustabh Chakraborty wrote:
>The probe function, s2mps11_probe() is responsible for binding its PMIC
>children. The driver doesn't have any functionality directly, but has
>sub-devices which are parts of the device. Therefore, this should be a
>bind function. This is the case in the Samsung S5M8767 PMIC driver.
>
>Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09A2CD6E4A
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 10:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A79A384898;
	Tue,  2 Jun 2026 12:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AeBx90rN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 543C7848A1; Tue,  2 Jun 2026 12:49:16 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62CAD83FEC
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 12:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZPtC7yZBEXamI47y8c6pahPCIkv1SrkQOIM2vkaTng2ndEhFQW5O+z/YzeUa4nUzwwvSujrPdpQN9i/hi8AUf42XNZD9E38vvwOmeLY7WK8MDLyIHmfVT9Cx/iwFvvKsY1wLzprB5Vmp4kfDlZi9n72KbulPT50u3pPMPZG3uwAe+LPJsw02aUq8DP/z+3IebljSWl1++5h6PI6OsUPAHuCK5L3paDkPtPH6T2IdnI0xsNCIfqRcTJ/j2D/MUUxrbAWtHZPVrQs952ZJMJn/KvKmLR2tP4wx9W1GgbVhQROeL1SleAAzDdxgEpoRYzi5k1oSbRx/0idkn6wg8B7x2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4YGhRDt22iVYqBcSYeWsDLH+1arpbRO4QRGIfiL/X0I=;
 b=W4eGHnc0T4VU4uvPLWz8XaI8AqNVa3eyz0G3D0It5pcn/p5BlxRv7XI+91uVM6JBb7gwBXbC398VDvOAhg7JpngYiR9lqBaAiR0mpqpfOR5Vi2aVXS2LRI+Xa9gKpPTlphrbNQB5H8WaNzWVeF0QpIdMylTLyUZUvZlk6J9BriJoltJ/5UxiG9BOwLwfQ8gU4JQEtsgpLsR4wnlfPpxoWOPZa1gkWaG2qfchdMNi8R5m2UbY9yNqb1BaPIcY5h0+soH0YoHBGF3oSFXHGwJUX18tRQBkPuF4iGzX/RiOWz9ZBLVKY8fcOC4Jy2jZCxOTOi3XSPXga0TMSRXbofUErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4YGhRDt22iVYqBcSYeWsDLH+1arpbRO4QRGIfiL/X0I=;
 b=AeBx90rNPQrbsLomjOwm/cwEyzxQDM/NR7kpeFOo1GMHt6OfpbZCrmCv12tK2l1nSFb1vVHFqVnMyY9nPstbF+viw3qnH/A1rW8Q/Ed1ebimmUr/iN/GQMks0jHxoTFnxcd5zy7h1rZvpuwpMd7NAu9uumPadluAzJi0z8L8HuLzZt/UKexCVyDq9RYOCNKhO3cIGQP0jHMe0NPbtCVXhJ8ECGFDmL7Qy39Tc1I+qsvuDfo8RZuSofoz30ses0mEaQOJZwFXLWGVzC/P5c1BmCdOCUJfbIUbDKOLs903ydScaEt5NQ+B/82qNhOU+tf8AuQdvhzMZVA/F9VFwpASVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by VE1PR04MB7439.eurprd04.prod.outlook.com (2603:10a6:800:1ab::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Tue, 2 Jun 2026
 10:49:06 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 10:49:06 +0000
Date: Tue, 2 Jun 2026 13:59:39 +0300
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com, fedor.ross@ifm.com, 
 marex@nabladev.com, joao.goncalves@toradex.com, ravi@prevas.dk,
 ping.bai@nxp.com, 
 ji.luo@nxp.com, qijian.guo@nxp.com, "Francis, Neha" <n-francis@ti.com>, 
 Siddhant.Kumar@synopsys.com
Subject: Re: [PATCH v4 1/4] imx9: Add support for saving DDR training data to
 NVM
Message-ID: <istftwxw7nnvk2q6ef4zsfuhsemupbd6fyjwwso3pqf2nagdqw@m4qujx6w4noy>
References: <cover.1777536451.git.simona.toaca@nxp.com>
 <d9038d69963976399d8e8e26dbf84b98ee1f82da.1777536451.git.simona.toaca@nxp.com>
 <b3d0d4aa-9058-4d2f-bc1c-bfb51fa4ad04@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3d0d4aa-9058-4d2f-bc1c-bfb51fa4ad04@ti.com>
X-ClientProxiedBy: FR2P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::14) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|VE1PR04MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe2b90a-4512-45bb-a0ff-08dec09491ab
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|19092799006|366016|1800799024|56012099006|4143699003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OpnU7kAegSjgU/RLcOmXQetbRjREuvK3HT7liHpXZ5dsyS2dM7BfWm/CGSYTlVlLuggHyetlIkCZIfhE4qyIP69/fEKouRLj1A04+NMjv3MpTR/ynHjIQuvItyWuU65o6utNe4exURgudiZoiCDF4BnAlX5e4YGtliGXJPNmuxnezLPTRGqIBIFfwGNsnj707ZWhDlYRC4JKSRbW2T+hWToIEQuqDHlZK96xfKXl8FYKopnOb+pe3tkXHwEYSIqVcXfzB7khc2UVlyqx7VcgbNgxxw75aK9Jkn+sD/aeOgApoF8luD3EAoHplRwRo4QqYzDfIf9rBEgge4gcY1AEMyfriVr4yEzyhRRi+BhiKKDAt6pFwCopVNhGfO27tca4QeTkhD0nVRzrxxpRK0kiCVxf5qmLCne5lyaabLriUU8I+UFadOE/Vnf17N0tt8kXqxahCPNY7CNsE0zLQkdiWoTkNzqV6QLhrglHeyleltdrQtZ2044IWX3douJv4oHpJrJCRuyfguSdoHxbofUwIKVWcH4CFlm8/AJ2uAo0Pi0NtnX8AHdZf2N6z92nKB5K/GfBk6e7o/OcFF3a5gSLOsRVUJzUJX3IKYNfAW2atfjBi3/b2gDuOGMXyfi6057gbwLQHmeQ5iiJjphM38OtnPUCJL6snGC3nDjtf1TxpilP1uVB5rjd2snyklWgETz6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(19092799006)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tl/N5KUKcXVWsMetLCNu3HYa08CP5B45nTgiCgCPAknuJEJgQGjAzjixZriq?=
 =?us-ascii?Q?IIsiUeLMM4gTaZ6D+9doY+UkKz/Yqiz5OyXmUi2HwokIaV94HPWhv1P9LCLB?=
 =?us-ascii?Q?kPVeLm0CAtiWWKRJ8SlXNdwSzxwpquf9TwQxf8F5Z258xO/pdF/ZImV4Uwzq?=
 =?us-ascii?Q?K+8RFk0ulocUJLxSfjq+4yQ217Vsxi58uowHohStd5VcY+XSsn8Mbw76t9s7?=
 =?us-ascii?Q?A7V4QQ3Wj1u9FFZFuk0Z/blmXu0QcXdkbdUZ9ua3yS3uplLZuW75d7uge6Z/?=
 =?us-ascii?Q?Q00vhkKYNVgBJP+1Fz2mT9xxpiW4JQc52/R7YIVrO8sBX3M9yfMrTlYKGaGp?=
 =?us-ascii?Q?q/XYTNvONiWKn4ChWNxok0CSaHzhfjnwX5N/SOt9WOEC6AVlhAUjUzz26OAU?=
 =?us-ascii?Q?fyb5TTWFf+DpMyw79RC/wS0VA2ZXZsVDofgoAQrim4ZSfLIkhw8cDZXCzATv?=
 =?us-ascii?Q?d6CUVnoOfYrcft/x6SR1BHatDftoEA/bACGb0DBTrqM8ASycRyxvY0hu6wyd?=
 =?us-ascii?Q?W/BPKl9jakU9guQOX9hP4pKVSjDhCw4fTJi6k9G+zUevpqYF7It4ftjgbq80?=
 =?us-ascii?Q?UAzA+NmnP7CZac5zj/8MvUuIi/EuzfqutQInHMffPvg3UcI8bMlKdSGq9h4g?=
 =?us-ascii?Q?OT85e6ekLHpqb1UI2VUWnaLmcXoleGQ2d4u4QQ4SNIyc14udWs+0GkyX+j0B?=
 =?us-ascii?Q?ZrKlxyCkuQr0lYpwX5SSfkLB4gssr5WvUnGJ4/yLu8z6e2/TOaE0GThx4K4t?=
 =?us-ascii?Q?wdxNlbilJmSXj0g2QVZw46TVb4Fwptbc3I5bpyKOykKofR4Na1nZHJZZFigW?=
 =?us-ascii?Q?hHM5vtXaUgOPPyUUXoMUndJUoKilQh4PsuyOF++OwRq15v4r8MyDUIsXUXlV?=
 =?us-ascii?Q?3WULBDjlU5q6DNRhswWpZtLXxOfKJlto02IYq6/HWQHX743zn0Ww3rqAItSS?=
 =?us-ascii?Q?ZDokw/ENEhhBNRBH13fTTGB8yS1/P+7Q7na0nXjzk/DP61v0A9rK8ZY6HdV8?=
 =?us-ascii?Q?+INEFmESIySkRK0pqnxDpIJtzPAhv2gbLR3ZC/ZinBP6+/yIuCpYKbpIQvtM?=
 =?us-ascii?Q?sxO+F/mRTMWayLcISNO+e2FMKzic6gMHIz92XdGi/qV2sK5Xyo3G8cHm4aHn?=
 =?us-ascii?Q?ZzovTbxWUNIi4G6YtSCq1e0MkKTwMDJVPmyZ0mrefnbAf9hf9l2ZXWkFC0uD?=
 =?us-ascii?Q?r0avICPgYeH9xnt7nhdtisKDln+k3D6VlSemEaK/zY5ANhdyx+NPk/a5sUOH?=
 =?us-ascii?Q?r0Rp0LorMbX29LzIfdr+YL5y0PK+6ZW5iym4oeQoRgm28RdIfoyrMN9MS1fE?=
 =?us-ascii?Q?ktO1gBF47bwORKGoxr71GBxqth2NiTEJvUdaCFr6YqeEauCVsf6aCZk7C1Op?=
 =?us-ascii?Q?K9dfi6Kn51GiHH1+SvZxiNkAmqBHvIj9t8aWG1BoOi5QIvRA7lmUG5xymIN3?=
 =?us-ascii?Q?MXJ7t6xFb9ZIZNgjC+6yCeyzlSqrFSzvgmW8XqWRtFNEB+RyArWwNQJS+273?=
 =?us-ascii?Q?zwXJwldcLu5TkdEc2G35Ig/xvnQBDL5eOnOv8Vjcjc4Q9plh1gSwZ5oxKmYJ?=
 =?us-ascii?Q?rsOHTqmxIyxkR7mlMNJv8lkTjqLM0NT3015zvaBe0Ludpf7nRc5Xn/vhJF0+?=
 =?us-ascii?Q?lN4TVm/Ee0/tHI6VKjbVGuXWH7ZUyT9Zsmpo4CcEh1oS7uFLQPhclPHeFcO2?=
 =?us-ascii?Q?GG0kHYooSmOX5M+PjqROIZp65vNnosAYdr2ZeREkg8zmKAl1Y0xEwlGujBXL?=
 =?us-ascii?Q?Gq/8UT/yUw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe2b90a-4512-45bb-a0ff-08dec09491ab
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 10:49:06.7081 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgq3I2iO35CnE1vuMG3ztDuak3JmJ7j354aV66YTFtNNDJyrlCTuNRfqfquFTs2VJCpG7MMqxnRapQayqHad1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7439
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

Hello Kumar,

On Thu, May 28, 2026 at 10:55:23AM +0530, Kumar, Udit wrote:
> 
> 
> On 4/30/2026 2:03 PM, Simona Toaca (OSS) wrote:
> > From: Simona Toaca <simona.toaca@nxp.com>
> > 
> > DDR training data can be saved to NVM and be available
> > to OEI at boot time, which will trigger QuickBoot flow.
> > 
> > U-Boot only checks for data integrity (CRC32), while
> > OEI is in charge of authentication when it tries to
> > load the data from NVM.
> > 
> >  
[...]
> > +#define DDRPHY_QB_PSTATES	0
> > +#define DDRPHY_QB_PST_SIZE	(DDRPHY_QB_PSTATES * 4 * 1024)
> 
> [..]
> Sorry for basic question, in case OEI layer changes format due to one of
> other reason then how you are making sure, struct ddrphy_qb_state is
> aligned
> 
> + * This structure needs to be aligned with the one in OEI.
> 
For now, the structure is stable. If anything changes, I will take care
to update U-Boot accordingly.

> 
> [..]
> > +
> > +bool imx_qb_check(void)
> > +{
> > +	struct ddrphy_qb_state *qb_state;
> > +	u32 size, crc;
> > +
> > +	/**
> > +	 * Ensure CRC is not empty, the reason is that
> > +	 * the data is invalidated after first save run
> > +	 * or after it is overwritten.
> > +	 */
> 
> In case OEI layer using saved DDR training data, then will
> passed CRC will be zero ?
> 
No, the data in DRAM isn't guaranteed to be 0 after 'qb save' and
then reset. It is 0 only immediately after a successful 'qb save'.

> > +	qb_state = (struct ddrphy_qb_state *)CONFIG_QB_SAVED_STATE_BASE;
> 
> If yes then you can return from here, if no CRC found instead of doing
> crc calculation.
Agreed, but the CRC32 doesn't add significant overhead and, more often than
not, the data will not be 0, but something else.
> 
> > +	size = sizeof(struct ddrphy_qb_state) - sizeof(qb_state->crc);
> > +	crc = crc32(0, (u8 *)qb_state->mac, size);
> > +
> > +	if (!qb_state->crc || crc != qb_state->crc)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> [..]
> > +
> > +void spl_imx_qb_save(void)
> > +{
> > +	/* Save QB data on current boot device */
> > +	if (imx_qb("auto", "", true))
> > +		printf("QB save failed\n");
> 
> In case, of 3rd boot or so, there is no need to save training data,
> whereas you will return error, in case this feature is auto enabled.
> 
There is no way to tell from U-Boot if Quickboot flow was run or not,
so that is why 'qb save' is tried everytime. The data in DRAM can be
invalid for 2 reasons:
- it was saved by Training flow, but it got corrupted/got saved wrong
- Quickboot flow was run so no data was saved - this doesn't mean that the
data in DRAM will be 0

> > +}
> [..]

Best regards,
Simona

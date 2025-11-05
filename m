Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F5ECCFA04
	for <u-boot@archiver.kernel.org>; Wed,  5 Nov 2025 00:49:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71519839D6;
	Wed,  5 Nov 2025 01:49:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="B82EBtia";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E5C5839E8; Wed,  5 Nov 2025 01:49:54 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2AB183981
 for <u-boot@lists.denx.de>; Wed,  5 Nov 2025 01:49:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJgaWIrt9veW/m7pN/5au2wvOdvGNRyG5xrSrotzYk8IoKt0Ys7s7SM6w20vTbdUyp34aQda4zrhFfq+K/vRwLoBYLwUo8z/79dAe0onZSDhYRlF5DSgy9koZrcj0wYVDzKgKD+KyrnaFz1DvoQncixSjhxv4bXzva4Bo+aOVn0X8wCUA6uGojCWsZZcquJ2iJGhGj1FyfbzxHFmKvb6vHgZM5X+UZTna6n4MGr3bvN+tfJgfnZ/vWQirG4w7ZAX/eibu4nM8pOF5uOEa97yY1jkCm4x9rrFcm2QJiNsAKtrmvkqV2Q56pgCqhMkvzRwGHxUpPF+KAH99ggBgFAXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c03VqZOIt0Xx3TZBTdzHel4R3Xm/mBa+QsaHTXBL7LM=;
 b=bgnd7SjuUCnrMz15ajn7+RqLaEwujoWr6kM90KgKlyaKQgYx3C4ii9zvAJVaz2E1jG+aWIIKy4Mz5wCi3LQUsHklf48RHD3jI1kkEuQlMOm8VOG5XOUetC4Q53LmG9kCs24OfrojGnl0mCm+LjE7MvPR5Suz0x64vlbG3/0+4lFrD53pIFVoXe9JffUVwtZvEhCMRvGykFsz8FhLDf2FMxvWRfGkoYLLho6+rYlwfp+MqfP/S4Xm0glLSGlyv0u7kCtL4SicqvPVcCvzDX2bVbSj0J/1Qi8ZIvbS9TkkOSIutmdkEMGAOYWoeZv7+SBH5ZxgrFiRjY+Wel5+T9aWcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c03VqZOIt0Xx3TZBTdzHel4R3Xm/mBa+QsaHTXBL7LM=;
 b=B82EBtia4danWCi2Kve8F/qsYpLSCqQXSpIHolIMtjKWIrRLOHI4FSiMj4uJV+qjHTeVydMsEHrtfpJjO5lhBLaKYPdsAeWUYvjXC9LHU+d6tGP5zzNzIoq75kZ9O50EzgQBaUjjO9tU1xWIpVOUTk+u7ZPGdwXmTqG7mmmuQTbFDrfjgV6Jx/Dc+nWyMghvAqxt5lKBX+Sw0lcnfh/F57qSlURQPfQ9f7H6uZ4cZ+EjFhNlD5YE/qmJdqSQrWZDRF1u1sWSJStzB01MstCG+AUKJ/dycCHbnUUWqPPh8yQ/b5MJsFs69e8MtwyNB1rZJLqIRmFHYxUzYzKyKwC9Ow==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8152.eurprd04.prod.outlook.com (2603:10a6:20b:3fb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 00:49:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 00:49:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Alice Guo <alice.guo@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Sean Anderson <seanga2@gmail.com>, Valentin
 Caron <valentin.caron@foss.st.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: RE: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Thread-Topic: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance data
Thread-Index: AQHcR7zp4jV0iKBiu0W688MtdpysUrTiM8FAgACGvICAAJGwMA==
Date: Wed, 5 Nov 2025 00:49:44 +0000
Message-ID: <PAXPR04MB8459585528148DC8B365867B88C5A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <PAXPR04MB84590D1D084E14A5D6B6BA7188C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <20251104160631.GY6688@bill-the-cat>
In-Reply-To: <20251104160631.GY6688@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8152:EE_
x-ms-office365-filtering-correlation-id: 2676922c-616c-42d8-be97-08de1c0536a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?ODJgSWn4Zgvdwet8Q0/WQJ22Ra8IJwACH26DryL0t0z2ybmN+X9f4j6+615+?=
 =?us-ascii?Q?QRBi4gJzCagmvGeQY9o32D72aQAh9fumtz9dDFlOZq7aQO2W72dPp2CqfTva?=
 =?us-ascii?Q?/zXfCW93niK9k0BaLq4xI2JZgJOVor4wRIDLcmILyuX4gkTkaFFaAuq13xEM?=
 =?us-ascii?Q?JVg0LbSPMXLVrn4kiVmsfL/wlA1wt+K7sS5ziIPR8kprigHtGjTOlHRT/KRb?=
 =?us-ascii?Q?VdmoK+/30DNrG+pnvmMccpI1CMnTetJO+Gk/AJ8FhEVa23LG77deQQMGT0eV?=
 =?us-ascii?Q?w/Qz/NpYYv+R7SJwl3VWkonAkOdGoAHXCZ6A9rxGCrT76Tg7CN2y1uE9jwbh?=
 =?us-ascii?Q?fPHSUqI4g+hTVCU8GFN1THWOwOyDJ2nTEOVTqsdVcSXbk+AmdgIY3EUiqbX5?=
 =?us-ascii?Q?KvER/g6t+iuOWArYHjECvu6StoTpE6m/d49uhC1NjFUEMWE12+PrZ7DnIWCF?=
 =?us-ascii?Q?9XdSndmEcbLhIj3bodemJTAIHg084uzemGCrFGm05QaxGXNm3AYAd7u8tb6y?=
 =?us-ascii?Q?Dvmj+Pwii7+JA7MiOpOTZbSrJV1jCVjvIxJ9GkrFm2+MWMP3YSZdtYDTDTyB?=
 =?us-ascii?Q?GLCwOnZEY8bqW735XQ20LSZI9Sv0RVmtX3mRz+uEn15pzYsrA12WuvzJHmvk?=
 =?us-ascii?Q?NHBPNCTe2eE8T6lHzDPOt7tbzPFE62lQNvd/L2AK9zvQFHWu02Pz2/ViibNo?=
 =?us-ascii?Q?kqay/IN8aqRnZVj/M4jVxzVDYwhBl2J3g0r7lj/dYze+GpxmgdR/HhqL/xKo?=
 =?us-ascii?Q?MFcBbxZ/bBlS6j9yu0EvVSQMYeXOV+QprI5tLR++8X97nRpsts+sBZlkAnG3?=
 =?us-ascii?Q?N9QWGEYlVXad5pQJhQQoRa5bFeMuO4Urh3K08har4P8vCyhnf4iEVM9j5qhP?=
 =?us-ascii?Q?Px3a6Nn9NEMzB+mgRo9G+PBfBbscXcMMaNQVAbnOIYFlzbXRLMevEzp+w+YD?=
 =?us-ascii?Q?oDfITzeW5NfdRvjJrtcASIewEfqCGCye1urU2hMv83Of5c/tt6K8XNNhOSSt?=
 =?us-ascii?Q?dtej5l1BnyogsTaDamIxUnc0oTwfzx2k8In45nai/NEU1vzhrNleQKdlyQ3y?=
 =?us-ascii?Q?WAgyRiAa0Q1mSNIXEsUulJfuUOT9cdxWcBGLqLhopmETZ4+unMurNEYova/q?=
 =?us-ascii?Q?XO4hg8pKkBGfMaxmR6tQMhh4oiS3UgDgX/C4LBNbci+qgKRZaTeEsvbYh+L9?=
 =?us-ascii?Q?fDquWkb3Z/Lq0JNAxP0zU0m5ayTptP8Y59l8cpUTf/iSnqPh9TLk8gbR7leu?=
 =?us-ascii?Q?mGk/pHtGdKrjwnX2QWx63G7M9kYFavVHsNGEco6+c4T4BB9nNwmXmM40YcnU?=
 =?us-ascii?Q?GeO9M33iRmEkD579r4T1lq7HVYi8T38IeawfAdwKdfa8pTPaK6Mn0Q8wSaB9?=
 =?us-ascii?Q?33Dn/WUGnAl3Ym4xLnZ4pJRp9wpNKt2GDtE6kNEzQTtJW635DiCLYOM2omoV?=
 =?us-ascii?Q?21A9MPOTS48LfBcMAOf13L+NtpRvvtqW2uqdikQ4wvjKt/k1i07N9LDxyOpG?=
 =?us-ascii?Q?V8JYPQn7HnRQ1ggeW/uTaE9Ehnbk8yFgjJ0U?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o+t7DKNh7sR5xXbpwgYWA0fEbvBZsObeyE8r7il11Eh0xlMDZBBVZzM6Bnii?=
 =?us-ascii?Q?TNb4vYH4PMF3k848PPwM1sdEPsj3gxtqKVYScqZooMO0ifxlHuZ/+XBpudtR?=
 =?us-ascii?Q?aeDhAvF/2SAGyNvLZGj5xGhYrk7rHZqLGmB57l8w30fKlEg9K8VuLHO25/xq?=
 =?us-ascii?Q?pD3FBBKlo/NzM5jrwJBRdSRu0ZZvF5ReQ8a2LJvRId3+6uRQM7JlIwP6/7I6?=
 =?us-ascii?Q?SOJ6iZHUfz4E0RTViQAQz7CH9y/J5jHF/Co7v1NcFGWGc6B9Ao9pde9anUK/?=
 =?us-ascii?Q?w1Qxs1rpMF6m4DS69swJ7lLQQYLhwGQKVCEkA8LGmPxpaD54zqwJIVkEQQeP?=
 =?us-ascii?Q?CGo5dT6G0kDaB+dcClDT5wiVEIsEcdtghTG/5Q/oXg3hGaxg63MazqIwNCYg?=
 =?us-ascii?Q?gi1tuHQ6stVWnC4WQZRwrfct3Eopzc+lc3/DYHJxgveRJK4KepyFoaKxXJcJ?=
 =?us-ascii?Q?pWx9jQTALPKLo41ru92fMzIWkpo+G1w8SPvGZDMaTRfvadhwstZ9DCc1DnoZ?=
 =?us-ascii?Q?PzE715IBdzxPxyA1RYzPlrZzTZOOQ44TH3YpmX/kCeRGYNQnjOjhW+7cyq/D?=
 =?us-ascii?Q?Jup/T/Ae2Re+V4rkEmHdgvp8iy7PXensdYbP313quPRlgt0x+gAgx+NEIYIt?=
 =?us-ascii?Q?n/BWDtBZUfZPUabZPmIwgKOZCP0YHCyAS7kPtMOo8a9heYhKOTjjlREjn7fT?=
 =?us-ascii?Q?/xRYpXfn3S5hCLczMvfaDZIKa+NEWB3RG7jufSZHCdriOYvUWBaQIq6KYwvf?=
 =?us-ascii?Q?GuhJnkK6ag0J3XrX0HdX8kwSgyN4KZzZm6lNwLtTMo5ngOfPYra4D5qqqghY?=
 =?us-ascii?Q?Frt5ZZtDzW0SF7y6VHoOrGblYE4KY8sDzmaoE4+pAZ2Sd0ZablVTLTOy90p0?=
 =?us-ascii?Q?Tmx/bne7dM52AdamthylDGi/jTd45x5bg9EJI/r6nj14wZZAq48x7Dnj74De?=
 =?us-ascii?Q?fbxtOm+2Wd+kzLayqNmx1ToICYEl9bHGrSPophgxs/wOSwCr8DODaChE06hr?=
 =?us-ascii?Q?96gQ9lHdgbQR8Oo4FuPeEOcv2Ot6LdxgeyZIlCPGWXnBBjVzKJOFltogi+2+?=
 =?us-ascii?Q?qJNO+FCBU7R2Nj3xRaLib1UiiYZ5h5a4a2YFQinwd1RD+wrNGjwE14qqQE/V?=
 =?us-ascii?Q?U7LTbumBs1zgZslZw0FVVx+xH9yM24QAPMkYXA2E9vFLDbEji56+fV3FDgUv?=
 =?us-ascii?Q?JG4QvwCMbbpm4y1T+VnP9A5TB1IWyIAJfY8VlO8FyPBhrGB1x2/DcKh89V5I?=
 =?us-ascii?Q?lXKO9ochNkDtlMZ9Z77Q8qzMKLBQs5k+KVLeWT2qkhSvpBz5VAMYB5nDP0+Y?=
 =?us-ascii?Q?IoVqFls5o2OnDKpCuyPzd6MLLJqp6AW6xOB3uLCysm4joYepXaK2qPjen1AD?=
 =?us-ascii?Q?+62pVf38KL+BBnwbt374nG8k3ghQMPudP99uYi1y3MQvpChCWgwsPfdOnsoQ?=
 =?us-ascii?Q?1oEMkIKxwQtCI/H/eHo+Va3r7N+tRVvYH6VQ16L1ZkkTFW8TezNktv5fiNyJ?=
 =?us-ascii?Q?G6mgr9Tg4ZL19RMU6rwnTuGz2QlQRrkuIikHxHRWRq3nb2gQNXmPV5Stfw/N?=
 =?us-ascii?Q?UNVmhgh4cmsLdfr5XTU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2676922c-616c-42d8-be97-08de1c0536a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 00:49:44.9685 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnBJX/6+pqcxvymSkdHaDk3T9KgZozR0VDsHUOMtVHvlAnrUfN+3vJWL17Y1kMI3sP/AUxZKkRsIbnJxTjk52A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8152
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

Hi Tom,

> Subject: Re: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver instance
> data
>=20
> On Tue, Nov 04, 2025 at 08:05:53AM +0000, Peng Fan wrote:
> > Hi Marek, Tom,
> >
> > > Subject: [PATCH 1/4] clk: scmi: Bulk allocate all sub-driver
> > > instance data
> >
> > I just see this patchset was delegated to me in patchwork. But there
> > is no scmi repo, could I use the u-boot-fsl-qoriq.git repo for
> > managing the scmi patches?
>=20
> It's a question for you as well. I'm fine with a PR from that repository,
> but if you want I can make a u-boot-scmi repository fairly easily and
> add you to that.

No need a new a repo. I could use u-boot-fsl-qoriq.git for scmi
patches.

Thanks,
Peng.

>=20
> --
> Tom

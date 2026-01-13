Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13B2D0C84A
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 10:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B13FD82B20;
	Tue, 13 Jan 2026 11:39:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rPxj08sh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC8A835FD; Tue, 13 Jan 2026 11:39:25 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09F698004F
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 11:39:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tL8paVWqDY/QBf7thOyN8z3A5t4H31aqz9AHu/mWAhBLwvdv6BahOIEnxjHZsnB1b48Jeot2KYEYsaP7UzqzpfKQS9lFNFBdfqGdL+Rrwq36x7jbnPZ39Ai951KeMkfTeUN7L7m6pJM/ZmLUBPqxE/yEl8OE/bsIhXJPgCjl1EH/JmfNhBaJ1Jk2/YymX1iYDRI2HemmnLN/Im37Hp+7D91A1rts4RC4qFwaDSiWoyrN68bXyVp9GxU9xl/ch3c46eswHP8XAZkQ0S5u+S6oVqxjqRgjNbR8HAl6cFrU/9QQQs7KvR9r1w7uoR3C3p74cpVtzBtXam2Xe3IEJjIsVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R57GIPJ1gYSzu3J70ldd/dOjFxjsDbS7YC9aQXM4Nx4=;
 b=lZTF1uMW6E3VflPF37XSpRI99fwww5oHPjU7+vSJiSXS5igbvRrskgZIyF0BQy2IvxXVddpY0NrBrWNHn7p14c2ITJ1ZrRkLE4aI+bQSi6RhM+3I4GA/Mp0kmMG08wP8xdXKPkF3zOTrW8ZmyJJfMZiHcLbJKA9uvB7xPA03yhOyrQW5Bm3I2Z/yIZhjFApK49/GuOfa6uOJMFmCG4YRid5fp1lpOc75Pa0tKrdAlzzFUh70ia3gafst/bXPk4yPccfmeqyXncvcUkfey9fU2igm9P8ZQlequwnCt+mx+z+C0BUHxpdJQsD7npBuFAARmUSxQMN2UIS+GwP1ZZMMcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R57GIPJ1gYSzu3J70ldd/dOjFxjsDbS7YC9aQXM4Nx4=;
 b=rPxj08shEDLnWdPgI6Y1vNCkn9wD5tk7dvvDhExdljsLG2W8C8yDK5SsdPEEPyaFqsM2DZJOuzR06d59uoyTzRdsuQIG/07+8rTNDHF9r4HI/ChM6R1T4Xc+ZW2gHIo9gxCDMyruv5pjpqkBk/PQ3eSfBrj1EZ98s4WQGGy7N1s=
Received: from BN0PR04CA0035.namprd04.prod.outlook.com (2603:10b6:408:e8::10)
 by SJ0PR10MB5671.namprd10.prod.outlook.com (2603:10b6:a03:3ee::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 10:39:19 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:e8:cafe::22) by BN0PR04CA0035.outlook.office365.com
 (2603:10b6:408:e8::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 10:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 10:39:17 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 04:39:14 -0600
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 04:39:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 13 Jan 2026 04:39:14 -0600
Received: from [10.24.73.74] (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60DAd9k82011706;
 Tue, 13 Jan 2026 04:39:10 -0600
Message-ID: <25c59291bdf9dbdf01d5225e20062b19f4852b28.camel@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-*: Replace rgmii-rxid with rgmii-id
 for CPSW ports
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: Tom Rini <trini@konsulko.com>, Francesco Dolcini <francesco@dolcini.it>
CC: <u-boot@lists.denx.de>, <nm@ti.com>, <vigneshr@ti.com>,
 <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <srk@ti.com>, <s-vadapalli@ti.com>
Date: Tue, 13 Jan 2026 16:10:27 +0530
In-Reply-To: <20260112180637.GR3416603@bill-the-cat>
References: <20251025073802.1790437-1-s-vadapalli@ti.com>
 <20260112074948.GA101138@francesco-nb>
 <20260112075636.GA105765@francesco-nb>
 <20260112180637.GR3416603@bill-the-cat>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SJ0PR10MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 26dcbf20-9c21-4870-6e2f-08de52900101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|36860700013|34020700016|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnB0TnVld245UGptbVJ4SFJ1MzJqMGhIcDljaENmZDdoRGp1WGU4bmRPMnNS?=
 =?utf-8?B?R3hJOURLZDBQemFpcWF6Z3d3WFBIbFplRmhwTGZYM2Fib2dGbVdwdVgvZ0Q4?=
 =?utf-8?B?cGdMT21Iak4ydEhWL25FNEZjVHdkdzJUODVYU25LSXdpWEdCQmlwcDBGVzU4?=
 =?utf-8?B?U2FmME5HZGFQTVVhbFdpOWhmeExEbTNaUmlPaWx3Z3pMNFZibHI2dDI3WURB?=
 =?utf-8?B?aFFyNE5QbzZZbVE4VFRjVkVpYVlWNmNwVndsbGN3Um9qWVRiQndma3pndThE?=
 =?utf-8?B?U0puMGswU0laTFV2MmtKZTVGSk1HeHJ3OWdVT1RJaUc1OUp5ZkpTcGl6SHAy?=
 =?utf-8?B?WVE5aklwSG56cWxya20xS0RWb3pGTW1RRi9YQkhtdWxOcmc0K1gwMUxLVkFq?=
 =?utf-8?B?VjFJMmgzb2pIQXBtaHBNWWJwS0RvVWhocTh3SVk0aDRkcGdiYlovUlZXSTZr?=
 =?utf-8?B?d3N3ZUQxMXN1ZmcyeXQyempsNEtucCtHemZmY2Q5b1Q1R1NjMVN1aGRnczJw?=
 =?utf-8?B?Y01BZzB2OHlZM0VUMlBkNkZwNE1lczdXNytmVFV5cEROeFYzQ2FkZlBiY3dC?=
 =?utf-8?B?RHFlNlBtQmhMM3I3TEpsSitvL29GRE1FSWJaNktSMk8rdEVnaWJ3K3ZVWk45?=
 =?utf-8?B?OC9COHJGUW10K0tpbGl0SURUWGlkUDV4dmljcExXV25jbjhzWFB2eUZuNDdL?=
 =?utf-8?B?Uk5zaWV0dlhKSWNVc3ZLdXc4NVcyemwwNThPeFJaMGJ4N3krT21LSFBpaHhP?=
 =?utf-8?B?cUdtT0tkWnRGMDY1bUtkclNkejdqRTNEQUQ3ZUVzSjc5MGZQWXhZWUZPcDFN?=
 =?utf-8?B?Z0xjcUFXNVNFbVBRbUxiMVVUNjVLTnJFL1lldGxQbllFTmRXcHpEeGorTFBX?=
 =?utf-8?B?aVg1cER6aEo4d2tvdDh0TWtaekdIY3hnS1VMUExVYlhPWWQrbkM1T09remV5?=
 =?utf-8?B?OTJGMGZLZUR6cUNEYUNRcmFZMnRvNWJYeWRDNFpkWndZTVh4QVZ1aEdPNWFh?=
 =?utf-8?B?a09tNG1Pc3pYS1JuUUgxZE8vSHRoakhaZ1RXc1lJMkpERVlkRThiYU5LbkI1?=
 =?utf-8?B?Y2dlOGhEQXRnRFVFZ2JGcTU1TkNhcDBvZEhGSXpjZU5HY3NlNExOT1hYUjEz?=
 =?utf-8?B?UnVTZlBxY1hhbkhrc1JNWEp0TkhsSkIvUFdhdVFHYVBjWHpFVkRyWlpYcVFK?=
 =?utf-8?B?emZKS21zTHJUUW9qY2RsT3ZBRDcwQ1pPVFhMcVhGb3I0c0RaTFErMTFXYnMz?=
 =?utf-8?B?UmxiTldIbkhkekhIWUthVUVkZVRFd09lUFd6eVpUU0tTcm40SkUrbG1keE1q?=
 =?utf-8?B?K2JzbVNoUHJlRGNhNm5DTDlMVUFxVXNWOEVkZEVYN1piby95MWx2dFpPV0FV?=
 =?utf-8?B?Tnhha1NMeHpxOG5Zc21Pblo2OS8yejdFVi9FWndvcURmWjQwV1p2MFp3MHNE?=
 =?utf-8?B?NGl5dHYyZDVZWWh2b200NWNpNlAvUlpja2xJUzdDWUF5VXlGTUU3VFd5aHc0?=
 =?utf-8?B?c2lqSXRkNU40MEs3RjlkdjF6ampOYzZmZkZxVkdYSGE1VnhBc1JVbjF3blFm?=
 =?utf-8?B?Sk9ONGtEbnhFOThRQjI5b0wwT3hTV2dJS2FyZ2dseFIxRk1sQ245NktyOVlR?=
 =?utf-8?B?WkFEMTNwNDdVazQ1bmxlN3pLTWZYQ21HVU9qQ0cwWUNpc3o4ZUdXMzkzK0F0?=
 =?utf-8?B?UXNZZFNVbHo5dDBGMHk1UldFQ1p2Q2ZsUWJ5ZExjSTV6UlZCQ2JLMk4rYmhn?=
 =?utf-8?B?c2o3bjA3U3p6SS9TaWtmbVpCemNTVkQxOVNBZFV0Zy8zZFNldmN6SjZjaTdw?=
 =?utf-8?B?ZW1pQVQvRjk3UHFZTEY2dGUxUUdPcjhrVEZYTTM2c1N0U2ZYQ254MnE4S2w0?=
 =?utf-8?B?eXhJOGFOQjhiYURYTlQrdnZFeXVpbWxsZ1hlYjY4V01KR0V5dityTnludnFs?=
 =?utf-8?B?WE1aaVh3NUhlK3RVVkpCMithY3N6SUJTTEtVQ2VlMFRrdnUvNUFzbzRKNmdv?=
 =?utf-8?B?NzUvV1RzMzZLVXJFQ3R3SXVlNHIvYVNDdS9MWlljMnFHenFWRTNZK1VGcWJl?=
 =?utf-8?B?NVI5VEY5MFhnQkRQRWF2U3ljejIwZ2c3ZWFlMFVTanR6TytweW15YVgxUk9p?=
 =?utf-8?Q?1blg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(34020700016)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:39:17.7645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26dcbf20-9c21-4870-6e2f-08de52900101
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5671
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

On Mon, 2026-01-12 at 12:06 -0600, Tom Rini wrote:
> On Mon, Jan 12, 2026 at 08:56:36AM +0100, Francesco Dolcini wrote:
> > On Mon, Jan 12, 2026 at 08:49:56AM +0100, Francesco Dolcini wrote:
> > > +Tom +U-Boot ML
> > >=20
> > > Hello Siddharth,
> > >=20
> > > On Sat, Oct 25, 2025 at 01:07:59PM +0530, Siddharth Vadapalli wrote:
> > > > The MAC Ports across all of the CPSW instances (CPSW2G, CPSW3G, CPS=
W5G and
> > > > CPSW9G) present in various K3 SoCs only support the 'RGMII-ID' mode=
. This
> > > > correction has been implemented/enforced by the updates to:
> > > > a) Device-Tree binding for CPSW [0]
> > > > b) Driver for CPSW [1]
> > > > c) Driver for CPSW MAC Port's GMII [2]
> > > >=20
> > > > To complete the transition from 'RGMII-RXID' to 'RGMII-ID', update =
the
> > > > 'phy-mode' property for all CPSW ports by replacing 'rgmii-rxid' wi=
th
> > > > 'rgmii-id'.
> > > >=20
> > > > [0]: commit 9b357ea52523 ("dt-bindings: net: ti: k3-am654-cpsw-nuss=
: update phy-mode in example")
> > > > [1]: commit ca13b249f291 ("net: ethernet: ti: am65-cpsw: fixup PHY =
mode for fixed RGMII TX delay")
> > > > [2]: commit a22d3b0d49d4 ("phy: ti: gmii-sel: Always write the RGMI=
I ID setting")
> > >=20
> > > What about U-Boot?
> > > I just noticed this in today U-Boot master:
> > >=20
> > >   RGMII mode without internal TX delay unsupported; please fix your D=
evice Tree
> > >=20
> > > and I think this is coming from the DTS update from Linux to U-Boot.
> > >=20
> > > Can you look into that?
> >=20
> > Ok, I think that the issue is that the U-Boot code was updated
> > correctly, but now we need the v6.19 DT in U-Boot, and as of now we hav=
e
> > 6.18 DT.
> >=20
> > Tom: are you planning to sync the U-Boot DT to Linux v6.19 before the n=
ext
> > U-Boot release?
>=20
> Once it's out, yes. But, uh, this tells me some TI folks forgot to
> backport all of the dts changes too then as we shouldn't have broken
> platforms in-tree like this.

In both Linux and U-Boot, the error (warning) message:
    RGMII mode without internal TX delay unsupported; please fix your
Device Tree
only indicates that the device-tree should be updated to use 'rgmii-id'
instead of 'rgmii-rxid'. The functionality however remains unaffected. The
current Linux device-tree patch is not really fixing an issue from a
functionality perspective, and the same holds true for U-Boot.

I realize however that a DT sync patch could (should) have been posted by
me to the U-Boot mailing list after this patch had been merged to Linux
instead of waiting for the periodic DT sync.

Regards,
Siddharth.

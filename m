Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE187CCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F4F68323A;
	Thu, 23 Oct 2025 09:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="JOqOFCKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A7D833AD; Thu, 23 Oct 2025 09:08:48 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFD0482E34
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:08:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrphO5a+oS7tQIv+qmIUc3kR3oif0g1MrVR4RomRRzxgg3vMB9n9aQ3s7SBt2GYjm8a2GK2ODV7fYKc8ALjw3IDxeeqwXVdpYC4MOHhZJKzM+WvZi7/fdeUJJt3QQEkycq6VzOJQadI+NzOv+o4wuKbQkvj/U2vVEm+x9c9i1o8J25OYebSkOg4yAlCC1/pV87XZFsY6GHEYPXOuf5qYkr/8pABRZpt9X3Vo4inqUnBWEL81bA6UVtZr3epaI5UPqrf5e+7+Mi4fIrs9xaWUyhw5IPnkMZ4+BUvXnIu4TIEPI/zGnqd6fSx1i8nVxVQ5NXdw7F/DvFNHdmO0UkHweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g/d3eCoBN55fh5bn7KYQgOHXp3Zf1OWxIBOQKz5ZI8E=;
 b=ww850xJ8XymDO31sk7g6BnIoytAZgl2RYBqjZS6jLwhIhPWwDS7ns6eaZ+46xjHnxC9is3X5WIY7SUP5cuJOcJaTtxLG06MsR8mMoDhxSVWgrrw04MaY9bXtbFLNEmoNNIIpZZtXFLUBej9cjLqtbBXNs8yUt21xkRJYOdtDC/het0T3MrEUMgtU/3mi8RcQ6fqUVkxiH1xiPmJ/+tbpPaLqpZ5TjOJR1LZgLEn2yGBwtdltln94gAZ8paKraRG6kFTzTxtU+hgbqjSAOuLTfoeVXKQH1UNXsS1vB9MH61Hvg0KpDWdf7TZ6nfD5OnxVQxQd7jcdixoIGhEPlTBOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g/d3eCoBN55fh5bn7KYQgOHXp3Zf1OWxIBOQKz5ZI8E=;
 b=JOqOFCKyhOL5iLyrBdu95bOKZ7TRJ0FQkZh20gkfHvKr+Q2NyvWLq1MTZP9iNEZVYq48/NlKSCaJIWStDw8A6TfcpXlXIMtSb/buuoDqopMnP0qcc4EvNa3iOtHAGnmq36bLDjsUL3ZaSaX+aGDdjq0vsFkg6Qlue2CgQ/RLoC032h261DF6jegpY8yb5zCpML/lxnKFx4F2kbJjpn8sQTvMMBbwe+7hE/p75By5lzQ/M7JD+cnDKOhj2qXlVAu9IlfID8uISy4+czJjZ5HRxbAMl3/zeyVCkgnbY/ngaeh9Kzr0PNIzl34eyrlnvhVVi4mLGTVAgmSbOlqc8AY8sQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9862.eurprd04.prod.outlook.com (2603:10a6:102:391::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:08:45 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:08:45 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>
Subject: RE: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version
 defines
Thread-Topic: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version
 defines
Thread-Index: AQHcQ+MtfxqA1IIJRUaAyvNbOe1UDrTPT7qQ
Date: Thu, 23 Oct 2025 07:08:45 +0000
Message-ID: <PAXPR04MB8459DA42188F3B88E21C007588F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251023060614.6441-1-tanmay.kathpalia@altera.com>
In-Reply-To: <20251023060614.6441-1-tanmay.kathpalia@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAWPR04MB9862:EE_
x-ms-office365-filtering-correlation-id: 23677693-e3e4-4228-c954-08de12030162
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|19092799006|1800799024|376014|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+beDl35rpMaCVJZK8gYabnHWRgiGl62y7VbIXjsoW5qOGoMxPIgEdydyJHaN?=
 =?us-ascii?Q?bI79Q9YfPAp+BTmGtbhHNUUTDMa+NrLXWlPN3ELL3nL2eeNGCxzvbAA+Mu1H?=
 =?us-ascii?Q?Ns387UZswTvJ4vzWiYdQaBwiMnMclMh0JrxFDIQArkhMX3jCY3mv5Nn9YqSQ?=
 =?us-ascii?Q?+ibFgaU2V6GnVjvbq260eVpY/J9JlpbHVV058hXLT8nTB0Y7Dg8I6fCo/XRl?=
 =?us-ascii?Q?aF88UBsAhzNAEmIUrm6jVsJdiq/G0GTv4O14gR2jIlD/dFZsYYeuxRc9WbvF?=
 =?us-ascii?Q?hksPgnKggjhpnwJbPl+BRZZl/BaV5rx6JkpiEW7TZnGRHajZ1sw9j5C4qD6L?=
 =?us-ascii?Q?bmRpOsx5JFrmrIuFWQm0AjsH92KjGskOomV1TFAStvXaj4VO65s8/ggW1HFu?=
 =?us-ascii?Q?tLrctYQ5YJLa3pcTfyk7J0lTws9PEVys7BWoJ2LiKayqPh9RqEUTYVPnHKj5?=
 =?us-ascii?Q?JXUxkDImUGplre8scDMkQTIb8jYQwIM/OI452CZQ2bOdhYXnSvSgwi7Uppi2?=
 =?us-ascii?Q?mub1sFiLSKmsRAxYoZt16J5ZJOH6440d1zNhnUKdtV5Scmt92LQ+CkiJpeKC?=
 =?us-ascii?Q?dO/ac0I8WTgRNELmvhA0EoWqIXGMNhqrtyiQdGAjJd4WazTdfsxx2cjUr1Wq?=
 =?us-ascii?Q?Ys8umSlQxc6XcMuZ87qB9NLfbv6zgnJGz/acmbq7YMRJJX00q/OOYvxwp3NW?=
 =?us-ascii?Q?N/i+NU8bTx64o9BlOPN60GryNqubgW+8d+B2MvtXtq0uVW9lqSvUrgRYU0Y9?=
 =?us-ascii?Q?6KEZ/KWXygBmntpWJkLD9BL1eTEl+AkkBf08Yh2hGxzqA/sFnXhBoxbs4fPd?=
 =?us-ascii?Q?UFTovnB1ERjy4xaFoenfn7hoRxjhfffRqFa5HIVar53w5fBwTK51mPLmBm7i?=
 =?us-ascii?Q?QMXZs42geLFUJvhhJHRIzFsrnlWgNGEA9H0y5zy4y1jQrFOSeTuvwS9dt0RA?=
 =?us-ascii?Q?7eeO0reJv8dD/3gde5hoBc/VNm9TzetoPezTie3i2E1du/8vLEmcbw/B6W91?=
 =?us-ascii?Q?T894uZ8agDKB18EWHuQrVRuhVkzhII+MYpTAEuof4OYwHydp0gEGN80OZ1BJ?=
 =?us-ascii?Q?dTEYXMKsREOTcf7/APBFMmUncNr+5xK1/RTTMaMjYc5RFmn7BPGzeyZF3ync?=
 =?us-ascii?Q?rYyW6vmBUE0Ga2ovLAGnv/rPtNo/QQ/6wz3vP+fHp2LCY7tTub/eA5KA70bG?=
 =?us-ascii?Q?1iIWnHawqt3k1W/9P7+H79rNMsAqMxYC0gHL4ZRoKSgU3/R1SlMvOZnhujpw?=
 =?us-ascii?Q?7G8YdWR1sJZkJHyT96e1hHByMCjF/GMMDjS/+aNd1z2wOy1jz/q06BZtxFJo?=
 =?us-ascii?Q?FxvK0chRQoSCyyPuEuBV9nKxLwSFQNVOPGAqRNfsG1zCTCP2851snpBccJw8?=
 =?us-ascii?Q?O6mHjgusgvzMHWj0lD4VOqYzNil1OixNvsZG2CgNmii9jfFZt76dkPaKAQ0P?=
 =?us-ascii?Q?2INRI9T5Ikvt34LaBunGR7NHFwoaudBBs881y42SF1vymbbDUsKV9gyMcZP+?=
 =?us-ascii?Q?d8+6XoXFdduAndnqSm4Kbg3P+BHBSx+vwwG4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GqxgFF5f/LxOpoKiPOvBFfhEE5Zp8aW13iWg/Y8cuseMNdgAQNdii7NDn3ek?=
 =?us-ascii?Q?6YjGP3BqfZeEItthrx1vW5+PZU0wL0wLDeVnNJgXoRhy2ZbMYNPhgN+YbYup?=
 =?us-ascii?Q?qXw3XYC1kerCKhMl8pGBFeNPWcAqE24iAoDYZxWqGhUqjK/F8PluBVH1F8a1?=
 =?us-ascii?Q?zjWEb3x32BLYCvzRIvaEnG8wf06M0g0A1D4sy+xB6Mv+1nXcloVp/dEfqMC5?=
 =?us-ascii?Q?3ZrZulgz8lA9GhG9ZgrTf6lqEOO6Sp1+0Pbqv0OQzXjfIU3Ko4eK9YMpFooR?=
 =?us-ascii?Q?WrGg8h1EmiLXI/lpNQ1dvBqktZSJP2CVPBGHioFIJqqTx6Oidlwg6EqVYCDG?=
 =?us-ascii?Q?JGK84dhf9iPRB3lt1kvan6Ve8ENjY2stPdpw6gS/8QjT59XpRkF5sFYAIAva?=
 =?us-ascii?Q?7tkXkp7VCl0WbfGDqhnJmDbq7jy5zdBSqsjkl/jeZlYsM1y/hxUgKA1ahbw2?=
 =?us-ascii?Q?RaKXphXtAIXksUMFBSlfGDArR+8mZv1ptP3lbR1tNGSFJFhgHLqHxNSNL+2/?=
 =?us-ascii?Q?HMEsJF3sn3d51DaigOdPPx76+BtUc6gwbzPcf+ym1o2LCPkH3CAQa1mxDQwX?=
 =?us-ascii?Q?yl4UvSJ3/f0Q+eObOgpOzZeBW1vC3xjS0Kwcx7akVTH8FWeGtHCGEU65VM2n?=
 =?us-ascii?Q?MhE3CIcqsY7EV9niG71MIZbE25r9G6SxhY1wo4WjnHBD+NnA8vWGFxo0lSPe?=
 =?us-ascii?Q?iLdcc2ytbdt+gnCWJSr0tCt/HWyuEgYbAhGRfffVD/JWVMIQUYge7umGX/wU?=
 =?us-ascii?Q?blZn92yLZL4vIS5AD6s/OUKRfuB6gFVpmtGZOKH5CN5YCTE2ih0mFVujEl1d?=
 =?us-ascii?Q?i0+R0auNPMftT4mrzLo4IYFBTw7NT1USH77SDUuNgX+ZIlQ8sk6mUcy5+4UF?=
 =?us-ascii?Q?Z+nknf+P5Re0bsfeV9dn0UqMdPSqVL/S1ceSE2fzP5RISZrM2rw5aemd6QEJ?=
 =?us-ascii?Q?R9u7IjIN1XHBMqLAj0TcxbKuYbiUYuF9HsyVRHQ4YM8xAgC4XQ8pNRvqrLEX?=
 =?us-ascii?Q?i5cxMajS9vYdJT5aEX6KV55IBUTWVf3IGss2AlgbadNJUtsPZbaBGDAJo50+?=
 =?us-ascii?Q?CRmJugE0SboRQLciwDU412i86sNaMfWraz5wf9GbhGDUSYcms81vae+kKIoa?=
 =?us-ascii?Q?Xq26jftrpYhusgXj1Amid4w5LGGjwhXL2PMxrTnBstHx9YFKAh1dPvYHlbT6?=
 =?us-ascii?Q?peo0RwaLrfGqPH2H/q6TOgao7fzOvwlpmECUSRqLy7kumzL0Sqi2dd1QXfCs?=
 =?us-ascii?Q?fjDbsAjp2b3gCfX3aH3fbUOImsMOrBRxRHDPS1DLFr/NJAYv510eiHY/5kOf?=
 =?us-ascii?Q?mPp4gkRE41qWYbLKEm7Xdd+irFAGP3YOK+wiqDF8B+TFCsizialK71Bzcc5Q?=
 =?us-ascii?Q?dTG9bX6qjX8aoThAKkQrdGQa2cd8Up9fL1QeEc/23NPXcRXIQgzwD/9txTRN?=
 =?us-ascii?Q?QLwNXMO54ArMtm2u8WxR99sqQnTr/NT4aAduF0Z0UhIWIpyJE3mzoHLnSsUH?=
 =?us-ascii?Q?O2M48exNoG9acA904lwCBpsPNlkbMu4/tAxY0YwcVh7jIKZnDIGdkE3F5Yaq?=
 =?us-ascii?Q?o/xNcQbjCxNQjNqfcOM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23677693-e3e4-4228-c954-08de12030162
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 07:08:45.0528 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XEavj9Aa7fiL71yxrvwUf+o9ixkfvfGtLT7rZuQTuM8LMeqGjZ2+53fgGRMyuGc6aeIj8R5dXGr88Z67KEH1rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9862
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

Hi Tanmay,

> Subject: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420
> version defines
>=20
> Add SDHCI_SPEC_400, SDHCI_SPEC_410, and SDHCI_SPEC_420 macros
> to sdhci.h to support newer SDHCI specification versions. These defines
> are required for compatibility with controllers implementing SDHCI 4.0
> and above.
>=20
> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> ---
>  include/sdhci.h | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/include/sdhci.h b/include/sdhci.h index
> 2372697b743..a962cc93caa 100644
> --- a/include/sdhci.h
> +++ b/include/sdhci.h
> @@ -223,6 +223,9 @@
>  #define   SDHCI_SPEC_100	0
>  #define   SDHCI_SPEC_200	1
>  #define   SDHCI_SPEC_300	2
> +#define   SDHCI_SPEC_400	3
> +#define   SDHCI_SPEC_410	4
> +#define   SDHCI_SPEC_420	5

Let's add them when there are real users of these macros.

Thanks,
Peng.

>=20
>  #define SDHCI_GET_VERSION(x) (x->version & SDHCI_SPEC_VER_MASK)
>=20
> --
> 2.43.7


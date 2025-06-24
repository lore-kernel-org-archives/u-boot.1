Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF26C7115B
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 02:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D2E8006D;
	Tue, 24 Jun 2025 04:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="P4NZ1A3m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68E7582C2F; Tue, 24 Jun 2025 03:31:56 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313F481E13
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 03:31:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ye.li@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAe5IlML9tozZrmXKRhFXnQQmy1tPNg4D1hggqD1jrppeIxlzlrYoQsF02h1O7NQx7SWsGNDZPsv7tptfkmzq+mLWWzWdPU19Q5HR5uT+f5qHF/FQa8hRzPu/J8G3pTE9w9vIDPYAkwDVyDFeo3Ys+xkC29gViek7oHqVNyKqDzu0OivDuARX0uGtgR+/7Ho4BGZ5hOdukkuMFkLxipisrvAfRqgSoDu2YTlpu0rspJrZ1Srg8Bg6QAr3x1pdaDv8jMu+hhmSgA05N990FgDQzxvbWGb/NABqPXjA4MLI7bpLnIR7BHVlINeogB+IrW6Yf59a5rRAU8NRQqmzDndQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZHBE+JJriNDRXXJavzhhiW31hTRIvS7qYusMpi3ezHM=;
 b=mc6B1PybhQaftRTjSDzW/K6EeJSMykIkjgdOotKPgK2b6/WNvIiDAg003KAZOtyStPxHix1jw+gXj9zgZN0Pcnxs84DZc+7KMIqJoi5IpDtPRtnJvqukztP8syFHyo+FyNEXcgT79WMpeKWSEN5R8xsp9+xyUiAKZ+fRBouabv/49Wml4LzmF0+7MmV+0g076n4hVSXFIns3ki1pUrtxEW3BycUJqZzL0YxV9OB9s5oVEvyq/qZ9qy3jiV4MY7OkHbPBVUhR3Yvun22th7qQVk+3R6Xnz3ouV+eevK/0tkmZkinwi3J1bHLDHdBrKtoUHT6VVeTHi9v0Nsc/CYlt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZHBE+JJriNDRXXJavzhhiW31hTRIvS7qYusMpi3ezHM=;
 b=P4NZ1A3mE0u/h+hHiDsy/M2meuOHAabsHvE+MheBWa5meWJRwsG9Eo3ZK+wFTxJt4M8kvOyypk5AFkCPme6+6xXRpous7sdd7eaS+lzWg6RWGpGH+PRkgS+d9VIZJSqSEkaFKz9IfrCjcMjQNrHjaa4UVVb+fUx57kSubyiE+vk4RzW7SldHqHHoKc2WyLAEDLBP9L1UPH8iFCNJd8DAlm7/r4dX4W5r5OVjJ8iQdYnpzxD95tKO7KU6LcigE0pYTeF8poYNezqxsDW0Czieu+Peik3x4YVU0m1IIBJodQ9WQRdEF3kNlWKfbBEqpPeTG+kEPS7EE7VAUbPTWdi4yA==
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::5)
 by PAXPR04MB9668.eurprd04.prod.outlook.com (2603:10a6:102:243::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 01:31:52 +0000
Received: from AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90]) by AS4PR04MB9436.eurprd04.prod.outlook.com
 ([fe80::afae:fb35:fc8:5c90%7]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 01:31:52 +0000
From: Ye Li <ye.li@nxp.com>
To: Tom Rini <trini@konsulko.com>, Rolf Eike Beer <eb@emlix.com>, Stefano
 Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, dl-uboot-imx
 <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [EXT] Re: Was plain U-Boot affected by CVE-2023-39902?
Thread-Topic: [EXT] Re: Was plain U-Boot affected by CVE-2023-39902?
Thread-Index: AQHb5FFoD825jvoatkSXy2XKlnOhR7QRhgjQ
Date: Tue, 24 Jun 2025 01:31:52 +0000
Message-ID: <AS4PR04MB943674BD75DABD5804C026B9E478A@AS4PR04MB9436.eurprd04.prod.outlook.com>
References: <5896532.DvuYhMxLoT@devpool92.emlix.com>
 <20250623151335.GD4003484@bill-the-cat>
In-Reply-To: <20250623151335.GD4003484@bill-the-cat>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9436:EE_|PAXPR04MB9668:EE_
x-ms-office365-filtering-correlation-id: ff512c12-ff1c-487f-af47-08ddb2bee58f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ScTTwvzzJ/yENkulOGZrERyCNRrS9vzxvM9Gy7PkiTjmaClalfhD1LsofyIi?=
 =?us-ascii?Q?qxsULzXZf7QlqiiunA8+S+/G4R02a9UpcRjnISI/Vd4vIpeHc47cXeNfn4zx?=
 =?us-ascii?Q?5QY+99gGZHYnNHLVlC1O4LoOY+8E2TBKFn2unQwPZj0iojdAM49Csq6oItiJ?=
 =?us-ascii?Q?qft2vTnNFTfBTAqCk/gzmYcjgRxDL6tDsw9el5t7nEde5s3QRfj5YbjnTNIw?=
 =?us-ascii?Q?u/zUxb6HeqUcaBTYkcZv1ozXM9INEDjUDx4wnd9XlyyF2DpfKKLdfUVHCx/5?=
 =?us-ascii?Q?kY5zfqLG+E8e3UzOUpUNxFwtBdVpb+4yWdT0YacdWI+GdF8Qdkw1DXQ0EybL?=
 =?us-ascii?Q?5HZxp+GDWFVHYXwH0M5kUZ5woLzRwTJdVAkLmbnbcjm+eNqM0OIzQoANYmkK?=
 =?us-ascii?Q?O7JB0ispaq1zK0b3+82NjWyZlZGvi+Xeci7G+TLzLrH2duLezDxuWiwzP2+G?=
 =?us-ascii?Q?GJ4tAAacjCZQvaCQ5oryW+HWT2YhTCz3pDgtPF6jx9VQPeYVqCTZ9Tfe/Tt+?=
 =?us-ascii?Q?xbXS1Pku62qee8r47ZhOWMXlwhyO6qEMezXOqEiUAx8mWKFb8i3t3BWLaJfi?=
 =?us-ascii?Q?kFUJusBv2HnBbpAFBcFdB9kLOWZjoHVX8vgnbcumNjsB2z0inYGZS/k8vS2U?=
 =?us-ascii?Q?gpnjqaUBkFiW+m/ritjTS7rtWexyTHB95d0aU7U61ZHtyW+Ocwhye2n4UP4J?=
 =?us-ascii?Q?eKBh/5ZypIYkPqoQ0PH+vhIL9rV01TUekUrNb8uv+8e1LWoBRozPOQb3K91p?=
 =?us-ascii?Q?YZB8o0kanxueil9vBeuNcr44ANz7GWqhq2v6bZPklIM9wbVMbgWIJau9E8Fp?=
 =?us-ascii?Q?GB5An4PMuh2POHxpT2VBVy/YCa5frSjUxJPBWFKS+DeoPMTushNq1Lxe1ImM?=
 =?us-ascii?Q?vGOYCKYVcV2zbMd1rU5RJye6UbsH5Sts3Rz5pGhDJvYtSciHAWqlqDymdaNv?=
 =?us-ascii?Q?KcZzTyHHg0PEYhK7z7wdI9B7T97RgPPdfeNDcSUjcEDTRL/QEUzfIBRisrrO?=
 =?us-ascii?Q?1exaRW53ehY9nhbGjgH8htJI7WT2iFjE7vvxofd42x/2XNxf3Z4HAQhUw+2I?=
 =?us-ascii?Q?6MXr4jeWLGjSfuCaoZ9QMTr2XU6ChB5qKGpnUw00rGFxGPpQiy3LW7/NBUHu?=
 =?us-ascii?Q?InCegFLncmKU2Q2yTZjfV+vyp59z6pnluSfGzY5YQVil5prB5NoRM2C0sPXU?=
 =?us-ascii?Q?yf8EQ6/35xKmbNGczHfXW/QwtJM3bV4x9SZd03oWrDQBA+hS/OmHUI/PB08v?=
 =?us-ascii?Q?F7Q4AIA3WVYj3JHw5GWdQY02AFz9Rj9Vq7a/eQ/4UI30QTKjkQ/4Qfxt/uSd?=
 =?us-ascii?Q?tLTVxaw+Pkmje1rVYaKGrWST2ijE91N1JIrKL8hMugFWsQ76Zeq3NLy/Hh3u?=
 =?us-ascii?Q?zgJNnqjWxhWs3pGVc7k3YPE4vYR2tQS1B1yDwEMX7tzDXLZtSD5iXmUGk8E1?=
 =?us-ascii?Q?8lROTXe0OA+2pDBRaXFMIF2O6EyGvHLprToYX8nouUNIluuxwasQgt9WVYLN?=
 =?us-ascii?Q?Yne5rSinBb8Ym5Y=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR04MB9436.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y2t1cPStih6pyhdJ4myRAMPbk4+Dw97fwWFql9QwwMRK7vhNw9/L1eSKN2UX?=
 =?us-ascii?Q?HVW9KEWRBPEy8HnGUWSQryRuuEuxYVdQu6GQD9NkSkDXalaMHYkahoC/c5X6?=
 =?us-ascii?Q?YQ4Hd8dQi6LWhtze0cgOMOwGAyCAPMHUramU97P/KX+OJhUR31IyFYwig7em?=
 =?us-ascii?Q?YwS0ZtQTpI76Ue8jPsikbKSob7LFGDI9crqjbp8M7gjt/ahqB8weyiN6ZrtN?=
 =?us-ascii?Q?yrNcAk2xb5UDeghEI588KWG7SC0rLEoRSQ5EjWPcaDOQbhcXLN2AkcS2G86a?=
 =?us-ascii?Q?E4lE9MQOSeN0ucYfJJs+supyQjaTYkuABT3zbIQlNWRKfVioZkItFnhl2mpN?=
 =?us-ascii?Q?xYn7m3yL7DN0FYNnR1w4fasqFo482zMmCcMtIyaETKfHfUxsdcwijwa58C5w?=
 =?us-ascii?Q?+ml8zQk1+csBB5P3V4jx0dARIVNi7utp43dHEKT95+XBnIsUeL+0ttK54lgj?=
 =?us-ascii?Q?jzUCdWNaDczJPi0kaZ6PrU5MhoMBQCVzI/2RVmm8jAQfjk6kXULOs43Shj0o?=
 =?us-ascii?Q?1UwLpURzjrTgEufK1XcrE+4q+aBcoK6veurh3ugA0NOtL8pfxMCTfhbOvVXt?=
 =?us-ascii?Q?ntavtnXsIHKESvIIStXcpQ6QdE1HVilPzI8rM16PVEcRv1HymFkLsVzVBEzl?=
 =?us-ascii?Q?PLcvQs0H5HNkk+3BqB1O+mvPeotV2PkeVy5ZKx5vlHJ5S+bYt6JxSlQIF68+?=
 =?us-ascii?Q?FFJZs+HB5DRasO6Fj8AKy3isdYsmUQ5LIss9///X/CPKZhxNyK6EMxsZoqeU?=
 =?us-ascii?Q?ipgx5VPmcePtjTCAfSQTwofm7/ma1yXPcNOXKODsgauaz4erxeuS9cJWFMX5?=
 =?us-ascii?Q?LbMfBPeVHPLKhAzRNqBpEnqJIYWLnFmzYrOOFQi1DGxcd3t6OHo1TBQglP/v?=
 =?us-ascii?Q?X/yVaGP6lKvjvB9iaPD4YrygaEEGOKDsKdCOkJUBo7H2q3/tQAeQelQrGy3u?=
 =?us-ascii?Q?eSyjK7/JHqCj3Wls8hyFuir5BbrUETy1dilp8ZAtg9vngyA66Bd5jHul345Y?=
 =?us-ascii?Q?MKo61YqWZv9G+Kq5yNWnvPE0ssN7ORBi79fljc5tlcpuHMP0gz8VtI9DqsMG?=
 =?us-ascii?Q?L7fj1kJakj/N+mxykN7T1ZJxkurCY/96mnPgZQW59TgwdrRb1npFKwzmyJv4?=
 =?us-ascii?Q?sKBB8eH+M2XWFQvvBcehNsIt1VwST7SEBBM/hRhr72ApT1WUdGotaLQp/Ib5?=
 =?us-ascii?Q?yqGr6bzJ+2MiCa0e50nYhdt/QC+a5wm79U86CeajiuG+bGzU5hB7DpWD+uL9?=
 =?us-ascii?Q?UexaWIHMpc3bXMGJDlZaUFyNIjpL8fpQd9yFiaE/qAXjuGBec9Zn9gEf8kXv?=
 =?us-ascii?Q?+gO/wVJFxZcbN6io4ahLLDtoD2kYyE1y/pZftFxyGt2f7F9tJUJYxF+cke/a?=
 =?us-ascii?Q?ZNm02OJjdove1py8rlEcApMjRi0Mk16oQvLWtb0KSoC+TVX3sGDqvXUmAJPb?=
 =?us-ascii?Q?qe6u6xBkCnB4zOCI88rYi+648XhkzdKDId9IKIrvcLigo1JMB1vOdneN1fM8?=
 =?us-ascii?Q?fbktoL0GX+W8uUKPUl2HFz97bYpQDRSTk+3TGyMsWz1RRVTZffwMARbV+QgM?=
 =?us-ascii?Q?SO0gVULu89wPC3U+XYo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9436.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff512c12-ff1c-487f-af47-08ddb2bee58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 01:31:52.0931 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UIOgzim90KtD4ec64P0KMeHMiWNruTnOqkxL84N3nUN4ZCob2THnehn+TCRU6xN/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9668
X-Mailman-Approved-At: Tue, 24 Jun 2025 04:35:00 +0200
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

It is same bug also resolved by 6039e0edc8540bd2a ("imx: hab:Simplify the m=
echanism").=20
NXP Downstream uses different implementation with upstream.

Best regards,
Ye Li
> -----Original Message-----
> From: Tom Rini <trini@konsulko.com>
> Sent: Monday, June 23, 2025 11:14 PM
> To: Rolf Eike Beer <eb@emlix.com>; Stefano Babic <sbabic@nabladev.com>;
> Fabio Estevam <festevam@gmail.com>; dl-uboot-imx <uboot-imx@nxp.com>;
> Peng Fan <peng.fan@nxp.com>
> Cc: u-boot@lists.denx.de
> Subject: [EXT] Re: Was plain U-Boot affected by CVE-2023-39902?
>=20
> On Thu, Jun 19, 2025 at 09:35:25AM +0200, Rolf Eike Beer wrote:
> > Hi all,
> >
> > for entirely unrelated reasons I came accross CVE-2023-39902:
> >
> > > A software vulnerability has been identified in the U-Boot Secondary
> > > Program Loader (SPL) before 2023.07 on select NXP i.MX 8M family
> > > processors. Under certain conditions, a crafted Flattened Image Tree
> > > (FIT) format structure can be used to overwrite SPL memory, allowing
> > > unauthenticated software to execute on the target, leading to privile=
ge
> escalation.
> >
> > This links to
> > https://community.nxp.com/t5/i-MX-Security/U-Boot-Secondary-Program-
> Lo
> > ader-Authentication-Vulnerability-CVE/ta-p/1736196, which links 4
> > patches. The relevant one seems to me
> > https://github.com/nxp-imx/uboot-imx/
> > commit/0746cfd931de8f7591d263ff60dd806ffe23c093, and for my limited
> > understanding the actual fix is the first hunk.
> >
> > A similar change has been made in 6039e0edc8540bd2a ("imx: hab:
> > Simplify the mechanism"), so I wonder if this is just an unnoticed
> > instance of the very same bug?
> >
> > Opinions?
>=20
> Lets add the iMX folks..
>=20
> --
> Tom

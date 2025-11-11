Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ED1CCF9E3
	for <u-boot@archiver.kernel.org>; Tue, 11 Nov 2025 10:14:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2325383B4E;
	Tue, 11 Nov 2025 11:14:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=br-automation.com header.i=@br-automation.com header.b="X47rR9OT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3577183B5D; Tue, 11 Nov 2025 11:14:26 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C42883A6A
 for <u-boot@lists.denx.de>; Tue, 11 Nov 2025 11:14:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=br-automation.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=wolfgang.wallner@br-automation.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlakSvlr51F/U5gdJBbunieAoX1LSzl1nQWKWQMvQdG1MfFN0Yk8GuoVfNCexaV75cOvHuprpIurAWtWMVL3nlMJnkSzDHn1u43MnQzmw2+9Cxkg/C9yk+yxVIQ85As4aUPO8tlxpQou6azPAkqok0WU74hUqxE9nofw/3qVqsJrM7rZwZhG4GGX5OJ5nYsyBSBU3N1MscOOr9IL/03PMtymM0V58u9c8Lgyo3eKLnDIbuiQXfLrsCX4tDixAQspC1P2fNJQ9bI9Qc563clX9cxXYTw1xmQLYVcnTLxeaW0Zeocz1x1ayARsWWB6Xm3vOltb1z4e4Y7WldDQi6o2bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Je2K1aBAnxXtLJfxrNZd4QdEzgcbyaTHiDDAmjAKvq4=;
 b=r2vMGfgcs0zZZjoot558Si4e5UWVNgkvWNmwP3hQR4O0YzMuzkVzk5i1LdvrtAWUUYcknkugi83OETb0nnmbmFR+mx4sJhrSc9kn9VGruqGoZjPyP/aB4we836ZMrfiGl3/ge1qxDyhtPesyEss3Ro8ic00DJEAFUzdLohvXlB1HxGBPzpvbJzSE+s0DZlmMdX4yZ6lOFBbpvaoX4YEo1Ps1YNB9SrUFVUes0H0+IEPDLYJMtlD1oEN1m09kuns7o7SKH4LY+mxIGnxMogMFBrh45Fs1njmAxIApfWyppAS38wCXPa/VZulufeo54UtsDmZg/O0hlqIUXP2M89+TOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=br-automation.com; dmarc=pass action=none
 header.from=br-automation.com; dkim=pass header.d=br-automation.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=br-automation.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Je2K1aBAnxXtLJfxrNZd4QdEzgcbyaTHiDDAmjAKvq4=;
 b=X47rR9OT8pmSWAIR3UkmXSQxYW2aQ0EBsbxBk6SWN1kGyfX5VsNZCi0jrCvFalM70LC2qMKCv3AoxHjRFPchOddDy5bpkPVhdc2PJSsSmPQ9hiWg2UgOLw/5iz8Lm3Co0XLkFF5OcDbC51OEUlPRoqjiQGrzGhz++m3nWZ+xeuVNxYpYgbt1qbDv4QLeXxkMyExB23L3abtrC/EgkskK1hvB90SMm20OfjY+GUHp5oGOw4mrmqYlJz+yS/RqvQ9eJTJ2fLDyDXpiZ1tiGHGteQGXS0ESHtkhVCfECzDhfmW9HSE2fdECaKwC1U/5w08GzGI8fBwOZuIg00mZjNzAIQ==
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com (2603:10a6:10:36c::17)
 by DBAPR06MB6837.eurprd06.prod.outlook.com (2603:10a6:10:1a8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Tue, 11 Nov
 2025 10:14:22 +0000
Received: from DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5]) by DB9PR06MB8512.eurprd06.prod.outlook.com
 ([fe80::5f8:554f:fee1:6cd5%4]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 10:14:22 +0000
From: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
To: Peter Robinson <pbrobinson@gmail.com>, Quentin Schulz
 <foss+uboot@0leil.net>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>, Rasmus
 Villemoes <ravi@prevas.dk>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <sjg@chromium.org>, Paul HENRYS <paul.henrys_ext@softathome.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shiji Yang
 <yangshiji66@outlook.com>, Anton Moryakov <ant.v.moryakov@gmail.com>, Alper
 Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, Bryan
 Brattlof <bb@ti.com>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
Thread-Topic: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
Thread-Index: AQHcSnpWtbOTkZTLRUmDzdHZnSoPTLThJukAgAwo0Nk=
Date: Tue, 11 Nov 2025 10:14:22 +0000
Message-ID: <DB9PR06MB85123A4CF4B3A698386F9EE9CBCFA@DB9PR06MB8512.eurprd06.prod.outlook.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
 <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
In-Reply-To: <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2025-11-11T10:14:21.422Z;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard; 
x-processedbytemplafy: true
templafy-owa-emailsignature-processed: true
templafy-owa-emailsignature-version: 1.1.0.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=br-automation.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB8512:EE_|DBAPR06MB6837:EE_
x-ms-office365-filtering-correlation-id: 68722124-bda4-4ae2-3154-08de210b1582
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?hYpOiULf+4aYzQR8GrikCxY74rmuXHEpgPDBiE0gOTphXHAb7PWf8TMxG4?=
 =?iso-8859-1?Q?QXgkoAb1RBHJH7Gl9vvs8FHW5URH0iqtGf7VYGoeAhSetWZaVjHW/luuiF?=
 =?iso-8859-1?Q?5vOQgpdlE4qkjJBI1lOf2OexUGscJ37F52QLxv+BSMTpzOv+MWvCZV7B69?=
 =?iso-8859-1?Q?4X86+ROKSTlXGtjoBr0Q9qxE0OV17RrHmvGOqtAfYr5cZsK4rfxpnWRrRm?=
 =?iso-8859-1?Q?3yGgye8lMPZh3BehIraifFlRXPSIyppgLdQBvWNW3xIxxeM+UCm8h836Fm?=
 =?iso-8859-1?Q?a0uewa5hIWKP5SoDxejuV4yEh50IsdObX3FyFvi4jMEnqEd6TYEHeAgSFv?=
 =?iso-8859-1?Q?v6c6C+AKhDdAlo6sW1I7FvkP12HfjT0wRnMwkkIvQR+SDpnGddTj3LlQXi?=
 =?iso-8859-1?Q?LNff1atkL4Guj1CTScEK2amT8f19TCxaa4F9E5vNKBE2IqZpXOW29k33+U?=
 =?iso-8859-1?Q?hRdT1979FL5GgEUwdhJB3+Mb1KBlPrY1DeYhMj/bgOYX7WU/uFc8e52iSE?=
 =?iso-8859-1?Q?OjEIIN8zZj+pmoPvdp20Cd88fBoxuDGs/vryq8Wp7ssSFYOltTFIwM1olB?=
 =?iso-8859-1?Q?v30MiKpapSzyhWdN/E3weScd//SaOr6iBSomMdqB+rDkmV/wtt5Ak3u4Bl?=
 =?iso-8859-1?Q?fYiMvTbAfVeDMxYDYt4hJbLecuqDsrD4aNfg5NnkO1sB0Sxb3dJRWxghvC?=
 =?iso-8859-1?Q?9t4nPWWcvygYdn4oBJnhJ+g63J29A8/6YRhCZjFkZY8AubvVXn+MdXDRR2?=
 =?iso-8859-1?Q?kKFhDJBkLLkDBXzHHcyzEEWGEGIil7hzhh/4pAerwlCzSKN7813PyT35uW?=
 =?iso-8859-1?Q?cmOAIqFNWnofVOU2EuQpyvjKGGIxazTCs9NgG/NceBC5kpgQdYddLvPD9t?=
 =?iso-8859-1?Q?f6gXSo353ZrvWu5QsOfWAi8BTIAEguc1/Lm6KhqHA5MtTxSx/0sbmqnAks?=
 =?iso-8859-1?Q?8Tjmrc/Hb8cHNat+Rf1ev+KnKaumHSnySccBW7/P64eJszm6+AEIwdhdd+?=
 =?iso-8859-1?Q?6lI7rPzGPQz6L7yBRyXzlJVWAscn2ZANtLuSzNF8juv/uSnoK3MubPYr2C?=
 =?iso-8859-1?Q?p88F5un4JnJLA0ku6R4c5v/xidMcWKBOF12r8ofd+N/g1QYJ6xDA6pO7LW?=
 =?iso-8859-1?Q?OVlpgHrEp4eeZd9LV2ppuioRIraFcKQxic/8c9IDn/XiSow7hx4EBXv2F6?=
 =?iso-8859-1?Q?p711Z+d99vEPcs8v/BnnEQGPDo1UpX83irh1dQkaZwa6j83+IBEwSXhtap?=
 =?iso-8859-1?Q?sa65NW05cHIFHuvLsx5JktFaTHV5DKje62NsewKM3wF13Mr9mgsBqhJjxH?=
 =?iso-8859-1?Q?jji6/WUucSENeN5xRR1Q1vPLPWLapREZ/YHJ84zdnwLtFuVDbjn+PrAFZn?=
 =?iso-8859-1?Q?3y1IPkbqhHWZ0sTRMaB70leyP1cvo5vvSqkIjekpeyiRvAmC+nP1+JaXEQ?=
 =?iso-8859-1?Q?wZ13QSXpcgCIyTFbgJlCIlP5HBdv08gG1z+hQCvz3E2xGgS2QsWqS9zd9G?=
 =?iso-8859-1?Q?e45J7C5gDem3idhkfmBiZ7Zb5eH+NolzMvTTtK6BMo/pFOsNtiqeBOKAja?=
 =?iso-8859-1?Q?XLen098hEeqG4/0VbS1oQJg+G1VB?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB8512.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?X5Sr3xndwcKftNcDFHQ3MSBOcXiSClXVcDiH1KLEyi4kySEtsbXXPCICAW?=
 =?iso-8859-1?Q?tcx3tq10x99RWLtYZeqeGDxPfMUNSjAPqfbuHBGCPsBt7KfDCZeXLpYrby?=
 =?iso-8859-1?Q?EP2l+qslY04tewP5a5v1p11iN35me5SZ2QUrrtcumS3RcVgDWFZ57P9CtG?=
 =?iso-8859-1?Q?Z/ppcJwFT0hlcaJq37xg7bh4AX+rcpd1v1zxJsLWo8EH1/G90nKVAV/NmV?=
 =?iso-8859-1?Q?jgR5YgF95yKI++6U8LVb/kXCBxA3A3/SriyA+9dK/2Drhply0k99KwYB/B?=
 =?iso-8859-1?Q?wA5g6aZFI6u0RO+5QiZUntMTU+bFL+Jgfbs+iB9wc+10s2008srKSPFbIA?=
 =?iso-8859-1?Q?7XN96Je3rsIC4TM4J01gnLJ31hEFjb2MSD12fwpEHtxuVWJvh/WHRbEBoE?=
 =?iso-8859-1?Q?FPQtzL19PJvfVYwCd6T7TrP5YF1sH5cl5SQFKUHNuWvMA7ypqHCnG0AXUl?=
 =?iso-8859-1?Q?fhmZh8ddXjbMLS6hnlUOOA3FmAUO5+XIYF76GjMomeMyzMro2QxdQVpMR/?=
 =?iso-8859-1?Q?+eQ7SVpF41itg67XsUIvvOrKGAfX+BI9AipCJ+dU60iBK8bRSFzVW3xV/j?=
 =?iso-8859-1?Q?MmqDdW2AEi++ZIxJ13VL47LZXM3nHt/I9J1bnTk9F2+VZaY196z34OHnxk?=
 =?iso-8859-1?Q?/opLc/eRVVq0vKB9BqosmNO5mVDl5tV0i1Amqh6YK+HOLf7RMZZnTd0nr/?=
 =?iso-8859-1?Q?uLeCAPkaP8KVHCm6VrE0UqsYI5wmOp5vJ7jZg+l1cx+VFSnsKcjw8mKHpe?=
 =?iso-8859-1?Q?81s6+E9PfXcrz+gaPJ8ZwVLVlsyKR8Fj9WLNTi391M3rjzjDehLWcwbwzl?=
 =?iso-8859-1?Q?zUrONWk1nMZJFubkpauXmW4BEhaPuwYTb/elpIDp9HjHcvgXlJdb1XroST?=
 =?iso-8859-1?Q?WRkzf/p/Vk2Qu1QDoo+cbAj8zvjW+Eq/WK4NIFaMBW40wQru8KZ7rc8F7t?=
 =?iso-8859-1?Q?z0Sh87BGGNjZPogXJba+e9/x9MYJQZCgaQQNlZ6RzTTZoWjAMg6hMf3ZRd?=
 =?iso-8859-1?Q?O1GFQ405BR7zt8BhoYvzUzFUgKxAXYJ50fQVDXarGeIYfxllAa40W6VOJj?=
 =?iso-8859-1?Q?vFN4J9TXC8EwybXm46e8yL6RwAu1hVGge6sRszSeTQdACAB1N2UCNNmGdJ?=
 =?iso-8859-1?Q?GMNDXy+pBDZiwXWO37h1ZMEkSgMdqokJ4flJ5tiVNgfrLxYqMC2YQuVBnL?=
 =?iso-8859-1?Q?O9LVl4NEq2RNVAKswKIasjhsbzzhUAthaodvrqKqbOHW8nxf5YdxBJHiPe?=
 =?iso-8859-1?Q?TrUmte60X4j8ytY7pxIT9JSW7xOfJOruWrnmgFsjJtxnNLBeXy4DGM45x7?=
 =?iso-8859-1?Q?wxemgxdaRiAY50noVyvHN+6J93pNkY7/RQtChi6pLxeUp2FPtAXKku5cQe?=
 =?iso-8859-1?Q?VyZjUZfEdNXGX4izkh/m2LUZ1oz/oDkx65hTOYbAhMrCTsjlP0gVsaG9rc?=
 =?iso-8859-1?Q?q3Km1rBOYlZycflQ9shPrWkCzQQcG4akFc+oDPjDuTLnBwOnpnCd9IoA9U?=
 =?iso-8859-1?Q?WyS1vAYF/iv1DYvTQSJp0N68AgAyZfo0Fd9MBYBwoWYQ63Sh9z4w1w7G1d?=
 =?iso-8859-1?Q?GIQ9bgZEh1Dadng02qBm8RCl3pbLNzGemxpL9bK8wh3km1ZDKXA2+qMndc?=
 =?iso-8859-1?Q?DnEUsK46OvuuKsbcYrCBPoWKQJFW2HtnjaIIm5j4hGoOS3iy2/KNV81A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: br-automation.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB8512.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68722124-bda4-4ae2-3154-08de210b1582
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 10:14:22.1999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bg22fl3gGBYPPvNP3SAPlZVSqSTMAc9K0Q6+AWRuH6+PHOJAJT9cC/xvzSMgIt8+ixqgEHmai2hTiDRnwnK67GUz366Xeom/44NzYN0uJIEpGMpQUonEdMeTPz61fjYC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6837
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

Hi Peter,=0A=
           =0A=
> > This adds support for using an OpenSSL engine for signing a FIT image.=
=0A=
> > To use it, one should set the fit,sign-engine property at the FIT node=
=0A=
> > level with the engine to use. This will in turn call mkimage with the -=
N=0A=
> > option.=0A=
> =0A=
> Just to be aware this should likely be a OpenSSL provider, engines in=0A=
> OpenSSL are deprecated and due to be removed in 4.0. A lot of distros=0A=
> are already dropping support for engines. There's a patch [1] adding=0A=
> support for Providers support to U-Boot, I suspect we shouldn't be=0A=
> adding more deps on the Engine support. OpenSSL 4 is due in March.=0A=
         =0A=
I'm aware that the engine API is deprecated in OpenSSL, and that the provid=
er=0A=
API is the way to go forward.=0A=
=0A=
But the PKI provider of my employer currently only provides a PKCS#11 libra=
ry=0A=
with an engine API, and I'm not aware of any plans yet if/when they will=0A=
be supporting the provider API.=0A=
=0A=
So for the transition period it would be nice to keep the engine API around=
 as=0A=
such use cases still depend on it.=0A=
=0A=
Kind regards, Wolfgang=

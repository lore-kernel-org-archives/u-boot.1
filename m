Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38FC3CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:25:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC4E9839B7;
	Tue, 28 Oct 2025 09:25:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="eHAK2JPm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E0BF839DD; Tue, 28 Oct 2025 09:25:23 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0279C839B5
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:25:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6sIFX1BlACN0ooVTPzf99rzCFIeU45NAYCHmfEybojKhBAAdGd41/kglewBhbBFNA76jjt9X5BvA2Uzp+bS8ZSi6vrKB8OpUeUFOQaUdmqO7WAmVAeS80v/D230U5Hw1n7jHCN/kzJ009L3hk3nNE7S8ioQE7j7VXJtEPl95MLQQChhfJExYaCzKmVFWFKhexp7EpR5e4UaxCU1shBiuty+CozGIxbywXH/akr8yU3OvN72UfrLqawUAn/dkjB3mI9XiPjJtFelJbtzI/W/9evXJxTyp8XyrHyN9nQzOJpt0pbYEcFynu71SRl/eve9EpXelwYo55NfC402MGWLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDN78cUApLpJ9dmsJBS92SrcWUQmpCQ+Zvk2aN9BmaM=;
 b=rf90WbgI9joSs13eIaPeMuBABHgY6BJ9B8H/G+z1ogOeWh/k7vSw3gfbtzQZ9GXK4fatJN+U+9cnqFivDNGpjj5pKpAscluFP15pZwHvRLFjfbNJdYeidiqwuiYYkbeteEfl62JKOYfWL+oR9Pqu8dNVk8eTzbfC3UxW45g9p/uFJdhpmekA4GFMiSYfLhhecBV8s1h3aX4TykKdOelnjY5IDdWxAnbfr0z8r9ZD0JVUf2srVhKLoBP9ncUGEK8FAS0AO13QmF5z1XBkE1wCR6SPUTo+NgnneA3AvZSoTEyIo++/BrkB+iKGmp7rzDYNtSbC86+hijLnTyDThC/h1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDN78cUApLpJ9dmsJBS92SrcWUQmpCQ+Zvk2aN9BmaM=;
 b=eHAK2JPmA8ZDa7yKzcxJ1GY6TDfQTCXYspQ4t9ExzcYMaKvx0laHhmI/idrhY4824h7nRyqFNQSJjiX2HiMBhnT9jgEO2Ybg2b5KhuDB85VdCGgaNg6p13DWQU838FGs4sVde8rE3m6lwE3TamZbv4MX0m/N+5tnohQiI5TQujRkIhJ+jGPalVVkZSqNKjcxPyFsUE8+5FnMtMJjsPNXu0x/AXDHjqOE70N/f0Qwf0wqaL2y4zZW5dZmqqFWgmkmhXS1B42amEhQQF/JJWyTxK3yD2MV63KE5mz3Sq5uTIChO0BTJF9m5rbRveHPL5cB/cRBMNUKD54G1cK1yMKSZQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7908.eurprd04.prod.outlook.com (2603:10a6:20b:24c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 08:25:19 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 08:25:19 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Etienne Carriere
 <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Viorel Suman <viorel.suman@nxp.com>, Ye Li
 <ye.li@nxp.com>
Subject: RE: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
Thread-Topic: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
Thread-Index: AQHcRfdbWm99hZDObESOmKTyJOhNR7TXOyQQ
Date: Tue, 28 Oct 2025 08:25:18 +0000
Message-ID: <PAXPR04MB84593511CF2B43470CDD8ABD88FDA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7908:EE_
x-ms-office365-filtering-correlation-id: bb962ffd-b555-411e-ffc8-08de15fb87a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|19092799006|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0gtMZfjxzmaTd0C7b4fnZR28sxfoK6BZxp94/ICdk7vdRl6wEPP1VozSCkpY?=
 =?us-ascii?Q?90zhsQHIe8Tu/fJ5IxKoVp8OMWMErncpvPAixpG+dKzb3PMOPTt3XapvLCrG?=
 =?us-ascii?Q?UFPM66ZWTIkw2rp+6z+bFSh8f00AJWDhw2tK9Br7DPdb7II5vSi0OMRXhfjs?=
 =?us-ascii?Q?00tdpvpFFYlVYGyBwegsHjBGD+CuoetAPfJUJqVwsKiZuaZGDquRm5U6KG1a?=
 =?us-ascii?Q?2y2RoY6R27FF/lEXTvsVm5lmfbUh+I2iSDtVdPRA782yTCs/jE/YIIm35ozl?=
 =?us-ascii?Q?zpNbEk5Ld8VAceCDesLhjodo3l7eU9rnwHL489jGG6/Y71swZAydnrF9rlCt?=
 =?us-ascii?Q?NSu9+xXaPPydQccBa67OsBFh8kTrXooyKIBGS8PNLOJ12K3W0jJmK+m7LTZ+?=
 =?us-ascii?Q?FOYfMWQC6edfJTPLxO16qSUqpZsmBO6Z/RacxWPT0PeIJH5K8nJHfRRzq0hY?=
 =?us-ascii?Q?iA/jjEZfs8WTJcG/xfiRtw2Bc1SOZixdpqrXtNq0ahDcTGM15vqJGSTXZk1W?=
 =?us-ascii?Q?u8t/5DjTz3s4YEqF2OvewH/izP60UvYAfzzM/bbJHR5YjBuLLU4Qq+vfk6zw?=
 =?us-ascii?Q?X0xVEfShLeFu5VPPAtvizWPXtdiJizT/JBQnyY5MJiHdyJdfNvrW1jaenyZT?=
 =?us-ascii?Q?frp/T/AHsA7ScKNozRqW24SzI5SCQjZhdfbCoHZXU3X8EggXFaQq76CiUQHn?=
 =?us-ascii?Q?DXqxxCByWx56U1GilWAtYfzQZ2UnsTJb30R/3JD1/OJTd3aYmcjR29uFNzjT?=
 =?us-ascii?Q?J+m20Za73soWLsHpP1E5lXtItarFLI68x86Q88E9YSEn7gKGf850/gwpuHQr?=
 =?us-ascii?Q?2yroPWQao6U2M0MT/WXjxbLxGS3kZ77h20jZewyF29Ph7NOEGfIXdCzl8h+e?=
 =?us-ascii?Q?7feghWD0PF6uea7Mm3E1CXBvaRdYMoiuu23GiaVgzcLlqfWd81cZpcnNaXFa?=
 =?us-ascii?Q?LDs/2Z3UiOmEbhINHwspD1p49iWGdVZkHmUdgF0eRspNSWdw6hx/hlvhu3Wm?=
 =?us-ascii?Q?J1jTbN9HSrg9P0SAF0yKtIsgDx+gfQ6u5hQFu6Iq8J9uTTqY2ypA5ytASFQG?=
 =?us-ascii?Q?X8WilHDPdhXoG7RUS3ieFhcmePgXBIqKxomArnUwfVecgMOAiWEtcq0VLV8N?=
 =?us-ascii?Q?G/qY4V6npSb84rWs3RlVwX+YzP1JRVVKTTcuREkzP26J39qHdqCNhblJZLN6?=
 =?us-ascii?Q?c32Ko/Zu0pKZqHB7jTNaIKqX4WOVOypQqeGJnnW5ENLma6vuo0fU9WLVa0Md?=
 =?us-ascii?Q?6D5ZnYfdKEdtPJYvlXZe+Vc0dtjue5b7lblh9hLjCuwyXleB9cTcyvS7hpOT?=
 =?us-ascii?Q?P8ntzxPb2FjGWgG4viQ18jeM3wjtOnCsMZRYtkOkT3jSIF3k7aI+sJ4mT2/B?=
 =?us-ascii?Q?iXTdUUWqHoAgknAud77nV6YdUIi/luH5HyZhaLkei5KrsIwk49EozXX69TlG?=
 =?us-ascii?Q?M7kbpkIRDR4aIm1/VCKFhKUQ6YBtq5+iGdiS+l9meMFrwh6tn0szbzHmynIA?=
 =?us-ascii?Q?FFctMpmLOtlEPABIy2/5bhvAaqNrQC+Umh5c?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E1/mbkAaeorJxfaSD3SS7dYb9b1Rc9I0s93iJbmil4R1RIF6jD23RIbd/Re+?=
 =?us-ascii?Q?L7QSXLcXvuBT1IRJm4sOTJArwb4s1bPvZ+a7fbV2MEDr0MxxKQlNjvTkex7d?=
 =?us-ascii?Q?vQzUyO1cDKVNnEwevf2255niN3ji5jCLVG5xRU6SbziqiawfGPVzUmDVpnTK?=
 =?us-ascii?Q?PPCKaFP0FGMBcMwXFPIyDPfkzuYCVYglo9bJvEvGjIe3BlGSg1y56wYvWQzx?=
 =?us-ascii?Q?qPDWiMlecp2tEO2HD4mDM2cAmMMzK1I5MDcVJxWQMHWuaAas1j4ccuZatEju?=
 =?us-ascii?Q?nvviqx3/iF5pG+ZbiZy/NZBRJCFkd9slDWx5nZNqQluxPWGPffH30aj8vptp?=
 =?us-ascii?Q?3r4ARIy8FZss1DybS/u7HZdk+l4k7+FtNFS7mQ8QioopP9RiguShRc3J2hq+?=
 =?us-ascii?Q?C6jKPbx/z1ZmEnU0SzKiW5f8fE4es0YC0Z8JvTiv+dKd225pJTHDNGsa6cTE?=
 =?us-ascii?Q?8svS7zaDZneeyVw/cs3qco2VQWwN1+oz8xZqxRoGP9EOmihA/LmN7TMLN0Mw?=
 =?us-ascii?Q?0Fiag7kyyptqhvHTUmb47SK+DIWHUo0q+QH6wWH+HzJGKIakb4758/1ysarz?=
 =?us-ascii?Q?IFJOIn0iff3W5jWjPlQGg71s/wM5iUuE1SiqSjrGQYbVVmfNTwzVUdS90bxO?=
 =?us-ascii?Q?EfHEajl/Zpj2TG0R4kPDJINO/VXE3qYg2gmn7Qwz2dJp27U7MbPTXkRGYIFh?=
 =?us-ascii?Q?7gPZzRpFia3CnL3ch4qwOPiw1TqxGe1s3nhN48eJskR72FLoPFCUDEvfjNwI?=
 =?us-ascii?Q?iF6bAoT5NTqqcIjY4v1VroQ0AZu2zvUgMcNFxsvRAlxEhXMdR5mcKChrfvl+?=
 =?us-ascii?Q?EDkMPp59go1At8F7FSNKLym6uEOaAZ1hzoMoCyRusZj61PRBG8j0rK4Y6EUg?=
 =?us-ascii?Q?CQjHcvBymiK9moJeogq2Lue296/FXZDXGqoDfBgzea4OMZMyK3EF/LqJkub/?=
 =?us-ascii?Q?lp+pL5zrN5rzbVDDcGvWH+8HkwwbmTmxmcyE0dVgcxSmfHzRYHfM5K6VXm7h?=
 =?us-ascii?Q?+KbynVpjnmLD8hOL1aicHfcbux3BDwr0x28nix9EHD12hFQMX3Ic5FmswVzz?=
 =?us-ascii?Q?ATgFYI/eP0rU+Aph1Q5rAjC+GBS6PM5VrBqKkgXZ9FC6EFjoqWkzhDGY9J2+?=
 =?us-ascii?Q?pOQ1rymV8eBX4yzBHDg6m4/8bXVWagprrH3+y7UYO62x+X9daqRnqg8GO6AY?=
 =?us-ascii?Q?M21I7TNHmKat30Wc5JTZ1OWjyi/Y4QpMm4BlVLzjAC11ZEaY3BI0kmE1sScA?=
 =?us-ascii?Q?k5/dxmFr8yeMEyQgr2j54gfbR69u/DRJbr/wXbmfU6AFJcARQTJBK5p7PaDm?=
 =?us-ascii?Q?rs9fau/dVffLuIv2oNKfsz6G+vGqqqyFd0WJ0LYk0pLwsHJagM+CuCMumbP/?=
 =?us-ascii?Q?NB+MIztcRefVs+XMqbM3bN4hHkFDWv5YyFIZOrUBaiGnlg7a/BOoeI1hhAD7?=
 =?us-ascii?Q?4pDFcIUuYFvVgiiJxobSgjJHv1Fl1d3WPDRl613pOQEZkfWRxZMzceX5IAY+?=
 =?us-ascii?Q?lP7DbKgbMJT7JzbejIF0IFOvBk3oWqMOHOxXqBeTLjF7wl6/LqIFbChqkSGA?=
 =?us-ascii?Q?cHXNiSOzjWp5UdRLuTg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb962ffd-b555-411e-ffc8-08de15fb87a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 08:25:18.9373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z3MjhSpgbY3SdluAcwQ5L0XHzc/9isXfuzFDOHi/C2OscpPSr+DQ2DRlswC4Rjk1zevLfInKITyaxHy5NQZOVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7908
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

Hi Marek,

> Subject: [PATCH] firmware: scmi: Drop
> mmu_set_region_dcache_behaviour() misuse
>=20
> MMU region cache behavior configuration for SCMI/SMT mailboxes is
> platform specific. Even on ARM systems, the mailbox memory may not
> even be located in any cacheable MMU region and may instead reside
> in some SRAM. Remove this non-generic cache behavior configuration
> code from generic code path.
>=20
> It is unlikely that any platform is affected by this change if it did
> configure its MMU regions correctly on start up. Platforms which might
> be affected are i.MX94/95 and STM32MP.
>=20

If the memory is mapped before running SCMI stuff, it is ok.
But if memory is dynamic mapped at run time, there might be issue.

I saw TI platforms has some changes to use dynamic mappings,
I have not read the details, TBH.

Thanks,
Peng.

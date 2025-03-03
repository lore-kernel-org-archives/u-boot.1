Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75550C282C5
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 10:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE26A811B3;
	Mon,  3 Mar 2025 11:35:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="dPPYWX2Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2388C811CE; Mon,  3 Mar 2025 11:34:59 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 043D4810ED
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 11:34:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y3EBNTRT9IYhrflphabsBQP4LXUL/v5z4f3VIIp0qjdz0HUA79gaNoEGzNEhtlY0ddxpQht9YDGgkUDw2Y2VwUzsyyifZhkREcQxMSzQixBrQWBWMivHVRkWUpJ2dk+9LwwwI1NFGD09DnzcQYnOQlBgRhu3FSwgrUKHCGbn7vm6FNhb/Lk/MLK/lvC1GX917fBdN0RC0fuHApCzyvBjhRX7HUiCTkqSbDWPlHssbYwjr6vxzVLBIaWEaJ+pvupTacJiJoMdj9tMtEuch4d8XO3GEqQ+VtpkLlz+rd35eLHZ9lZZSKp7a+lANYHX3nJtzBHgBhLkk5exH1GiBBDQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbxZrDTReAz42bZQ1DhKED4VqjlYjpBAx0oBfCRJazA=;
 b=KzPCOAI60qt+qm9h9H1J0MaTew4FScZoU4P3TfrbhWRfCOC0cDFujZr6JZX4ITpZKRkT/V2a/qWwaqiW75kQxw/+7Nn3Aje1gzhicbVFdgu+AbspgXI8MSrLDCtVZnrYm+sQo0qzRhpIogM8pNyq0LSy+F4+89qsf/LvTUuWehjo7M27/W//S2dLWPuo0s35JQqBXW/CIANE9LBuUDj0EhgoGF6dPokeLoMkIHYMklN8KEp7mElE2mohPDBvyIveGIxni7b67rvdChAksMQRc177RnXLt32YGd5OqmHGljjRYJsFCDStoUArrUUwYFqTzLJA+HUezTZdmaHe5FXPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbxZrDTReAz42bZQ1DhKED4VqjlYjpBAx0oBfCRJazA=;
 b=dPPYWX2Q4tS3RM+wlIuZkqIb/hWNzGas+NDvqeWaF9yuZ5IvNHFyJIO6LY6zBmfl1dqX3Loq+F0lpuV4YxGnMQl6xFDNLMoUbbksqhz/UZUcBfDMyvcEm2xaLNM8Buad9z0q4Me36cFpeNvltEpwVnv0p9Mzu0SEQ3OTme7qvaLt4ukrtYDzePHaLXsD+sWPMlUIkpujJp80wYzXEUdNMXt6yNsc4N/36T+jR4ebFT/I8fZFfarWV/u+bPbfbpu49zVqsfzGDp6q21wjmN2bI1iXgvYFQ2aNWwjG58gHREyxOIagkZ5y3QSopy5C0zXUvS4e61bbVYESs/KeljaCmw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8284.eurprd04.prod.outlook.com (2603:10a6:10:25e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 10:34:53 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 10:34:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Tom Rini <trini@konsulko.com>
CC: "U-Boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [GIT PULL] please pull fsl-qoriq-2025-3-3
Thread-Topic: [GIT PULL] please pull fsl-qoriq-2025-3-3
Thread-Index: AduMJ9m+AJdElnSMSSONQwApZLry+Q==
Date: Mon, 3 Mar 2025 10:34:53 +0000
Message-ID: <PAXPR04MB8459E662EB7A8A430FE706A788C92@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DB9PR04MB8284:EE_
x-ms-office365-filtering-correlation-id: bb11e1c9-0a20-4678-94a5-08dd5a3f08bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?mOPoE6S7a91YUQxv3DieItTrcFBxrQ+F3+YfGd4aqotcBgJmgOePSY59tm?=
 =?iso-8859-1?Q?tTM7AZJX7b7qpPk4HTCmN+L4LykgqhSql/wr7vjWmea8iU+5G+ILDc3SzA?=
 =?iso-8859-1?Q?hFj13tIEIdSXG+TJtLR5JcAEkbfjPtT6vEteND8Cf0npoTQvyQW4qagPOt?=
 =?iso-8859-1?Q?TIYn/C53qc8L3wSymKly3xxNzvPBomUv+LGAZXL17GguqGzqBFlHfRdXXH?=
 =?iso-8859-1?Q?knTMBbettifQtNwS3AVb1L7wQPlIHa4SkyeB2RgW41aG9q2CMV6KwQ/QfW?=
 =?iso-8859-1?Q?UKYjSyB4soTlPqzJ8rhrf3L1JBOqT9y7TYGiFIGldr5gPSCfCgj5Q+5PXp?=
 =?iso-8859-1?Q?1h7QC+AiaalQhbb4lSQ9gzqBbpQ6AHMw/Y7g1MPjix9LQ5aO9ITN/FEyz/?=
 =?iso-8859-1?Q?JUCDYhFAJpHUwBi6tMqZsdvmbYuOCeuXI3U5tRk0vIYaYr77Ec/6S49bWv?=
 =?iso-8859-1?Q?T0NchAjDI6zudFvqoxUoSHVMk/gcDHVX8sC7sR4jBVDn0TDfABnyGqy1vQ?=
 =?iso-8859-1?Q?CwdtWvi3c7VQEe3Tj1di9EMhrAIwOTzOsioorYXtwIR1tg+A/4ZCOE6eqe?=
 =?iso-8859-1?Q?BfFa8Ax36WhILC89uEgwLwB7gRVZFrRRyB7ophcudOq3r+r1gg2gcpBQQR?=
 =?iso-8859-1?Q?uPoJkdOPVHTr0HO2OvIvDJXeVoXaQDCN52AmK/kJRjQddDiWIpqz218wBH?=
 =?iso-8859-1?Q?lAOS+6BE51vWfOhjETnAcCj+jTz6533u/C0L1EwuNBhM0RGpb5WzgcpZCc?=
 =?iso-8859-1?Q?V1FUpIh3ybSIVzsB1Wu4EMlnPAiBizwL2sRggLGsqoMDl67Lvbqti5MTzl?=
 =?iso-8859-1?Q?C6lur5+NUWU/9PID8KBy9TgKRVe7ERKqralXuQjtabLG1oIsuVFAnXpxHA?=
 =?iso-8859-1?Q?PUazExqkRrkTvCy0bwH5AaqA+wzSuxPNxgX9zdUf65oRBUyKmTsTO4I0cT?=
 =?iso-8859-1?Q?M3xKM5rd9YYUsqmHWrxg6NL5COk3XT7Ttno3i4twuncHijwYqWPkvUWDP+?=
 =?iso-8859-1?Q?gpom3Lpri7fjEihhxcix9hX1fOqeTARUwuMKKN4yXc41k1R/k+eAC5AYUC?=
 =?iso-8859-1?Q?u6lGUjqnbCYwuDn90/aGHDPkyTawqrGDfR5znTrYDzds4bZBuRxg0Hvb3k?=
 =?iso-8859-1?Q?9Do7N0K7XATNPK8UFNwziIxkuKc6alPDV9tzUN8ZN0TjoYSZ3wXqwFkumO?=
 =?iso-8859-1?Q?CDNUn5mgritpFUaphSsz7oocAXjAgIxM1eCmWBbM3HCxbwfQalZ9yYrW1e?=
 =?iso-8859-1?Q?uc9CWVPvOycgMZK35QOZ3YQxy1+f64lw6JugJkMYhJJ6uFU0cG1VrwfGIH?=
 =?iso-8859-1?Q?kWKyY7+nV/O3NEgfOvM6W4c9XGyh3Y4DUHfoRGn0/lL6CROpsWj5x1b9xC?=
 =?iso-8859-1?Q?lZJ73zWGgfjViGYDGjz8vdsRUN9NhIGizAZeo27NUMflKNFXm68CHRkGXw?=
 =?iso-8859-1?Q?+nQiLHVORadlzkSO?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SKAahdBzyBpV3HNgCxrCgbWHByGAzpQOyrZ2rcrgA7eKbYUWt8Wb8KGCQ7?=
 =?iso-8859-1?Q?k8ZtZ7c0BFegQz7U93i2tixJ1lYwY/5jnOWLPbb1eQvaOGh/WYBX5d67Rc?=
 =?iso-8859-1?Q?0TlksFXxnb7P22GcOrv3sD8vLL0oKguCGX0ATxr0L7VsN07k6H0kLUiv5L?=
 =?iso-8859-1?Q?5aFgBjHK8SisZQa2TqAEtOyJRgb0y4/0RiZjjGw4iyxPfueugjoQYG1c8K?=
 =?iso-8859-1?Q?kGOsBwrQswmzXN1Sz5v6eIkEVkzK+KtQPLxCo/yNuxbBCnhiIlRzbQbrwm?=
 =?iso-8859-1?Q?JIqoSsJ0X66O2E2FwkqqcFyTg0o98mlYTKzUUP6E97+vz2dh3BjIJ0DMdi?=
 =?iso-8859-1?Q?TWuw21Tj7jztzPVsqpjQF1TvvNhadAgnVmvJbI4a5uZtC/3DfGZaAcAuXq?=
 =?iso-8859-1?Q?8p3QnhmOckCVWe6+X8GtPASy+1szezGznQwGgUH9wDPPvtyfEc89PlSdVK?=
 =?iso-8859-1?Q?0AwB5TL5lszz/V03k7AxSBmkPhQ8Y56I9nU6cdwOl2T9nMSPXUb+B86A8q?=
 =?iso-8859-1?Q?RbuIltKlXIL9lvM+EmtgBOWkCISV5SsthFMG049metQEavqf/nqW1gV0Wx?=
 =?iso-8859-1?Q?Nxu8yIuenRiSbgV6FJrjCTmjMGypmUCh7buVmDQFWFTkaR8Hc3cFQTbsc1?=
 =?iso-8859-1?Q?rUtO/G485CDwh0Hrf/Hh6+ssrl3Nvf5FnyOe8iK3C6CTIvMJC6AroRpU/z?=
 =?iso-8859-1?Q?4WGIp7fXPeEP8DEPEnNs6UAOrTiGqXXg/nBwa4uQyCck/EJULPzRjy8y1F?=
 =?iso-8859-1?Q?qRLN5qcryxGQmR3sgVmb3YGLdbPs2yKjrdhQjA/eH06McXS4uePl1FtZB9?=
 =?iso-8859-1?Q?y1efqCPsjYTTacEgy2GWBpo1ev5PD8WsAiQxOnZNYfFBkysZ0hUuVQp/yX?=
 =?iso-8859-1?Q?f+w5WCLyVQLa9dEB5gWi9ub3ytrN6iTl0OvC12YKeljPQDUpVGfYMcT8/B?=
 =?iso-8859-1?Q?AZ0BecQRtepko+aunmYHttLXz5ApaIjZju/ekKgiqSlGrww+LDri9EcLwX?=
 =?iso-8859-1?Q?laq7KypSRVrcy4bmdIL7j6389GdxzFrm4qP55bndccXTWdZkl9SJeSUK2T?=
 =?iso-8859-1?Q?39rIzWj7efOrcVt8+1vTlKy483rTkbuk779IVLVQafbbejY6NzldoetyEN?=
 =?iso-8859-1?Q?Q5vO02OevoaZFLo+TVL36o+N/rnJ/yaQonNi7G+PXBsc8bwCwBexrtQnJk?=
 =?iso-8859-1?Q?BZkQAINFIVkrHdeSEEy0nHpUWfm58m5Yz08eN0ZL3pA3dFKFZvRM620So2?=
 =?iso-8859-1?Q?1IXVEmQu8Pt31i1mzQZFhm+U2lJvUP5ZQBsvD1ejNXR6bILMH9VEFSN4Ab?=
 =?iso-8859-1?Q?Z893Km2qXaZyIhYvcOsc8v61K3Lav0jHGiX6YBCdCbO4FTbmGFjeRnVboe?=
 =?iso-8859-1?Q?hRP6nhzcM1qTSoIs8wrhvdsP1p3c5O2yyET/+EXrgQLg0UGPvQVkb3OQzP?=
 =?iso-8859-1?Q?HGOEKLMpz/tbw92TkuNA0CuVNnWrEhzLcqTpt1JW6UI7yC/QkTat0RjrNp?=
 =?iso-8859-1?Q?gSskpsr53IBRUe4pWisYO/zCJZFSp+kgOYHQLByl1TOwPIlNXCZeqqZfL9?=
 =?iso-8859-1?Q?Aq4uI6jBghmHxx5xESE2cqH6Jj1pCP50z/14Blhh9UOWUoyCD894A1RcTZ?=
 =?iso-8859-1?Q?LFPaRe/xw4wGQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb11e1c9-0a20-4678-94a5-08dd5a3f08bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 10:34:53.2011 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2N7zJuIgXILY0aYnTV15XiVcgr05nMzxxcSjSmU2W0bAitPD4cdu5BSVnJwFPfUI54f72wzKrSWzpeZ0fLiWsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8284
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

Please pull fsl-qoriq-2025-3-3.

----------------------------------------------------------------
Re-arm packet buffer in error case in tsec driver
fix LS1021a build
fix flush dcache alignment in caam_hash
----------------------------------------------------------------

CI: https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq/-/commit/ef0e=
979e14332e37421eb3ebe5b88c2409a8803a

Thanks,
Peng.

The following changes since commit 6ae0a578de67038df291a5fea3e7ab67cc520680=
:

  Merge tag 'u-boot-rockchip-20250301' of https://source.denx.de/u-boot/cus=
todians/u-boot-rockchip (2025-03-01 07:51:14 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-fsl-qoriq.git tags/fsl-qo=
riq-2025-3-3

for you to fetch changes up to ef0e979e14332e37421eb3ebe5b88c2409a8803a:

  crypto: fsl_hash: fix flush dcache alignment in caam_hash() (2025-03-03 1=
4:18:50 +0800)

----------------------------------------------------------------
Benjamin Lemouzy (2):
      board: freescale: fix LS1021a build
      crypto: fsl_hash: fix flush dcache alignment in caam_hash()

J. Neusch=E4fer (2):
      net: tsec: Reorder tsec_recv and tsec_free_pkt
      net: tsec: Re-arm packet buffer in error case

 board/freescale/ls1021atsn/ls1021atsn.c | 15 ++++++++-------
 board/freescale/ls1021atwr/ls1021atwr.c | 15 ++++++++-------
 drivers/crypto/fsl/fsl_hash.c           |  6 ++++--
 drivers/net/tsec.c                      | 39 +++++++++++++++++++++--------=
----------
 4 files changed, 41 insertions(+), 34 deletions(-)

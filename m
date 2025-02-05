Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0290C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 13:19:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE5380C58;
	Wed,  5 Feb 2025 14:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="c4Ksyk/i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C39C480819; Wed,  5 Feb 2025 11:15:56 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0FF807DC
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 11:15:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Oleksii_Moisieiev@epam.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2HGxHzPno9OFbdOsldvwYvFUsUr2GjerVuhix5t691hCwlMcTMP5LGdL/ADh0t8iSlSgnbc7UQExPpz9rzAES9hNsomRwAb7RtQ6Co5zP1s/hbhjgMg8dG/EZdD+ZsU/njZQSE0bf53DEVYM7b3kZOMgw9S2zHvWOjm68LYysJmCjyIB8fbod1cM7eVYdwAgbsQMU/DefkEQ2kW40D9rvaGG0pwQIVC0ngr430d98h+gK58YzV0STj2Gb9xaXYQUrvBtLQ24X0BnIyJ7TpLc2oqA9qR8QsX0x15b52SD8IhJyr7gKO4vvJ1ZnJxqDq9cwBMqFSX7idkvIIs7tTqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p88iADW7gvcl/ghnPLUavChoJGCvtE8V2VLEC3eoe/w=;
 b=LZ+5cm5OCeECyxq/2j6iofJTvytAgBiy1vXazdnEFzjw1FyFZtLsfM7TWcwLG7bfeiOR6BluP97SBjorIJS23iPJlvpisV8qTP6KbqwN8uDNYdRQCI6d9o2iw/Tu5Z7MKq7/K2ZZSmR1RaPR4xElzI52uax5bR2o/5Eyn6yYdOSkjtnYzHc4WaS39UdxYNL7CGdB2DPVJWpo0sfLJWF9hJzg7kYmXusNG6EssYYVnu9jADqimSYyY0fMVrHOwSf201b3DEM4ED3Cb8opQiZ5OGHNnZTCr2XcuxqkkZXDakHnhZ/CYo75MjzQNwgtcN20XX9vmoZLg3U7XiW4WgAiHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p88iADW7gvcl/ghnPLUavChoJGCvtE8V2VLEC3eoe/w=;
 b=c4Ksyk/igBGWAxjgy1OwBkHeUv3WLFrwG59ZfHce3uKUK5NG66iXi6NK+81W+3XHC4W6CAtsUk4jKbip2SK8PHPos5/hSjdxLMUJjM8GiheMPCdSLXW22LfjNgZew/7VZb879cZu6ZdzQo+D6A1fUArIn8dj/ED9O0xN3PgS99Kvoh+6OP2JavH9kkVvK5gYOI7GWEbJhLnWK72kn1EBxfoWt1qfXviTmcuYgF+VIJmJZCKSms7OTeLtKbP3lNwLKd5pnRw+KgCGIXk02fKavVG5XmR98+9/JhOE8uWWYwwP/ZZ1G+1lxtP6M5676lJXgB2Hgp9HUoRT6tE5j7inAg==
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com (2603:10a6:102:32e::21)
 by AS2PR03MB9879.eurprd03.prod.outlook.com (2603:10a6:20b:547::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Wed, 5 Feb
 2025 10:15:52 +0000
Received: from PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc]) by PAVPR03MB8946.eurprd03.prod.outlook.com
 ([fe80::f12d:7394:bbe3:dfc%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 10:15:52 +0000
From: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>, Tom Rini
 <trini@konsulko.com>, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Subject: [RFC PATCH v1 18/20] drivers: pci: pcie_brcmstb: use bus_base to
 config PCI device
Thread-Topic: [RFC PATCH v1 18/20] drivers: pci: pcie_brcmstb: use bus_base to
 config PCI device
Thread-Index: AQHbd7bsX0pRiOHWBUad7OvbLEoXPA==
Date: Wed, 5 Feb 2025 10:15:48 +0000
Message-ID: <ff06b6b734de11e0dec9cdcf307db8bd77989f5c.1738749764.git.oleksii_moisieiev@epam.com>
References: <cover.1738749764.git.oleksii_moisieiev@epam.com>
In-Reply-To: <cover.1738749764.git.oleksii_moisieiev@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=epam.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAVPR03MB8946:EE_|AS2PR03MB9879:EE_
x-ms-office365-filtering-correlation-id: 0f2e4fc5-1de5-4ada-478e-08dd45ce11ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?bAKV8kKPVNKNfzba6hGi9hWtrFkhzAt38p9Q+uIan7PlRMU//IrubuMA82?=
 =?iso-8859-1?Q?vCnBO3Z3NRMTG8qqWpdLG4xdt/HZwyHNpez1Fq2s9k+vLqLlJXeP4VtxVN?=
 =?iso-8859-1?Q?IojS8StPHTUHXCuS4jpyNaAhV3WjXqqd4J4iPely7BTzKM6QN9t5PgWPfZ?=
 =?iso-8859-1?Q?HernDaIysG/Nl5tOOvm/0RGYTvymuQd/oZR0K9uY+qsPigWfUMs8Bxjg3i?=
 =?iso-8859-1?Q?+t+1DGZJangmrZ1xTjQRWtwmprypp44hLn2joUPASDeklxIcfrCn1ZKVt7?=
 =?iso-8859-1?Q?7fGwmkmZCXtCBdyWs8j/ajNZcc9RY//+7zaC30eYkqRy00Y1U7fh5EAuDU?=
 =?iso-8859-1?Q?1Sy/bgcHh8W/TxopBBwXCZUJ2Wt1WumDLoXAzv3YDYo+qJ8PdwsAb6XCcy?=
 =?iso-8859-1?Q?sw7cZzirFsFBEncfXwq5C2ATlyuSXATpAl/ntLg4H/2ulyYS1B3qzFJXvv?=
 =?iso-8859-1?Q?vnxUrYH0c7oxWPAlv0g5bvl8EqLzDIypgFdAqK5wD5KyJTyg1FpNPRE3OH?=
 =?iso-8859-1?Q?nklpH0S3liZWPFVuDEuKp1b6sRiE4DPP5yL41GIyEnVce2SmcUgB5XhHDR?=
 =?iso-8859-1?Q?AxUYka6o/yaGKJFhBTdiBlqKTjxQbnJn15tfzyChPKudCK5+t9Rzfh4WXr?=
 =?iso-8859-1?Q?3EvG5eZmlxrfvvv1hTMT9J0EmStb7p2LUcH1EfyrkDM2mE2TNXiFsROa+t?=
 =?iso-8859-1?Q?fevlU7TYns1JdKbfL6f7/lt2Yga/BU0PR34mno5eMZt22Vb5bwVfwPMLnW?=
 =?iso-8859-1?Q?cN5FRy6XsL+4I2qKbZAGRB1O7HnRUJY0B6REmeBtbmnVJDjWSSz6U+EH7u?=
 =?iso-8859-1?Q?ODjWayKtisEjJ2ii8Ede4Ye9U4UGZ159ua5MKV1GybeyKbqQkpFbCl9kj+?=
 =?iso-8859-1?Q?vluLBGeZSm9LPv7nAtmlsERc7OzkBe5ZJSh8KHKGHEWF0Obj91NvcFqyh3?=
 =?iso-8859-1?Q?qI6VluL2lSVZBL9JBIg7rjfmJO7p98SBWl537XTfAs34E+jlJmVb4aa7ef?=
 =?iso-8859-1?Q?Allh7sFs9OCCuraqiZ0bO98lwGlE0P39TyNpmdjp/Q3GnvIZsl2IBLIm3D?=
 =?iso-8859-1?Q?4X8v3QOI6cwlXCiN9JX7KJtEBcifBwtJgbmlyxhQfh6LY/S5GPvTyhzNbE?=
 =?iso-8859-1?Q?IVNYf+wVGw8JYYNLSuVS/RqLDMVEYW5kteDkJgAV5iudmRAtrtCr4wxoyv?=
 =?iso-8859-1?Q?izLmT2xaTOFG2/0AeIvhK5BkAC1q+gFrtcA3Ad2F/w/EI8wnkYDpLb82C5?=
 =?iso-8859-1?Q?NxJU5ldOp6PfjuPVOSCEMj2Q88VaHU+sdgm2rJxKDaYnpjyiQbkFpPUfNi?=
 =?iso-8859-1?Q?N2UYljQNG+9G1wiXF6tgQAh3I/LFPZp0TeIrtUfz+5jlkKvRHuzkdnfdoZ?=
 =?iso-8859-1?Q?v19uePixuSL/Dnpxq3XzxHW7ujTF50l8fScXFf5sMzWgHMIeBIJMaCAzVP?=
 =?iso-8859-1?Q?wpDQWQnUJ/Hyym5btXeaVQpBUAuWwYG4NPUHd7cHzfLA0kNooDDtZm8w17?=
 =?iso-8859-1?Q?rq9f3PWuwdgDb2ckNdWoc0?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAVPR03MB8946.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SCX73G531+ooaYZfm7/fm1fkPDBpsWz3o4tzjHuyIbOWPKgzHXBD/5Ms0O?=
 =?iso-8859-1?Q?+7blCUW/6E3omzCa2UJ4Nt0z8eewopz03Guhm1CB5CGuNaYJF+RPa35lAn?=
 =?iso-8859-1?Q?NExSLhuHdONlW3K70RWCRVRE6Ju81p3+1EcHPR3i3PYX9ZWipRDwIkKlbs?=
 =?iso-8859-1?Q?bJVWJmwVqmgpUpl4n0M9bvgM2s3PiFqTqu5/FlLH4Y+70FTq/mLW5tde1X?=
 =?iso-8859-1?Q?FbAt0loVtb7dnyWOWuvp9lZkVPWKTFYw07GiLuL0iL5wqyNezo7t0ATr6v?=
 =?iso-8859-1?Q?yscJPxfq/7EE/hFZbvdcuR3u3ftYFTkQcs6Wa1WO+Gd9uq/Tiys/uq0dEk?=
 =?iso-8859-1?Q?q8gVggf6H5H9F9bnxK2we6/MDTGh9miLqXDbAGCJeLjFS1eHv0meyBzgsI?=
 =?iso-8859-1?Q?8jX9TzUf30HzpVQte+yU/LTxNOwgn/zSCERDX8YdksqhSHxjncolJxIlEj?=
 =?iso-8859-1?Q?eisnjy+QVgpq9mn0gtAgOWYaXvkxJesB5/sMJxn6XrHSvspAf7AY7GJoHZ?=
 =?iso-8859-1?Q?e8rKdqRegmVvSUnGwHK3RfIeJehwdGR1xIDyxp6uW/e9D/ardDkzyVojjc?=
 =?iso-8859-1?Q?NgTexYDEGNd7kKYbxD81M05forV1tbv84uobh9KU6I1lUd3+09BY5VwRq7?=
 =?iso-8859-1?Q?xnZrTDCtXPEuGUuctLEpPEqzs702CSv9NajbIfkJzzchxHr2ellQws4Xoc?=
 =?iso-8859-1?Q?ECiE7UxJyR7rzjks0yNc/q1pc0ZxmeRZXixpbMfxmfGONUn5DgCyC1uIZM?=
 =?iso-8859-1?Q?nXhVT/kG9MH1Uh2decxHH6oZp0AeiEUF1iMIcrlA3wQBS4peQXUvDqXLGK?=
 =?iso-8859-1?Q?ZhV5SYzktxVQCBxSi7Ia74BTVHqw8nQ5Frp31T2eZhu9MPGwGJWGcsNJMu?=
 =?iso-8859-1?Q?Xs1h7Jf9UxgzOixWCO7z2I6lmXNRtgDIdW9Yq/hO4+vCTiGUhZu4MEbFR+?=
 =?iso-8859-1?Q?t4bT8xRDFwUUpUen72u9BaLZHkE12BZEh/hDUricoEogAScfpzF7W4NXmv?=
 =?iso-8859-1?Q?fO12t43rTiz2OLdXVgHn1DYINnz5d3pdQ/bfMBHhpGYsMasuyLPq/87UdW?=
 =?iso-8859-1?Q?IceHu1bI+PoBQjAs5uYnKPmsHDtkD/ltXKv7N0R3nBOFTnj3iuCcojnwEt?=
 =?iso-8859-1?Q?P48PfkO9q92/AA70zBgpvHvPLr/Kl+ZulQvd8rPO6KI1WTcyG6hJWz4H8D?=
 =?iso-8859-1?Q?ItcKrnLlxKjQ+ESGXaLxFOysnNKCqVy6+RBj+Mld3ytIE/pJ7DiJ0EWSpy?=
 =?iso-8859-1?Q?PlCJVK/dNr222r2xLeqp224l5MpQRtkFYhCO3QeE8y4SeAiT7E7JVylBta?=
 =?iso-8859-1?Q?vGQSjzGaUwjHBJ7Blsg4Epmq7TQBcX4BM44tQ0oCO7EvZthR3VzBpvP2sU?=
 =?iso-8859-1?Q?TkxtqqrpJULe2sKgJR2HgKY68n39UeKzTx0ZNZ+vNz9U1YntudH6p0j2mA?=
 =?iso-8859-1?Q?KE9+ceZ7DKIKP5QheMrGyIBr74O1HdaDmYN0wqtIMqzqBWxP+fkrDWudJg?=
 =?iso-8859-1?Q?yofLthRZJAUZauij71aJIJca4fQWR8u8/ydITwRMQjEacubW/HOn9Mu7/K?=
 =?iso-8859-1?Q?0Qhgwbm0JAfJf9CNq5pdcp7rECns9vcC56uY+nE/7kCcWkl6R0r3SNNCX9?=
 =?iso-8859-1?Q?iNsx+aKf2I0GBW1OVcHGxVVbQAVkTmANylKVCTXF6ZHH4oW19mdg3H4g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAVPR03MB8946.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2e4fc5-1de5-4ada-478e-08dd45ce11ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2025 10:15:48.0867 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEMFJQGtsOEwqDS1icEq29e3lRWMTuSxDXH7M2WBU1eRkSOHIqrwl/IfbCCg0YNOm3vSdBOT3anh5I64s0/iL6t4AzFlBmBJllrXqONRnss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9879
X-Mailman-Approved-At: Wed, 05 Feb 2025 14:15:26 +0100
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

BRCM PCIe controller has different means of accessing to its own
config space and to device's config space. To support this quirk,
its driver uses simple heuristic:
when PCI subsystem probes Bus 0, the driver assumes
that the subsystem tries to accesses PCIe controller config space,
when PCI subsystem probes other busses, the driver uses mechanism
for device config space access. This heuristic works well when
there is only one PCIe controller in the system.
But U-Boot does not support concept of "PCI Segment", so when there
are more than one PCI controller:
- first one gets Bus address 0,
- second one - Bus address 2 and so on.
This breaks the brcm driver, because it tries to access second PCIe
controller config space as if it is device. To fix this, we introduce
additional property bus_base that holds a PCIe controller own Bus
address.
We use this property to calculate "real" Bus address for
underlying devices.
Please note that this fix may not support a case when we have
PCI-to-PCI bridges behind the second PCIe controller.

Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Reviewed-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---

 drivers/pci/pcie_brcmstb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/pcie_brcmstb.c b/drivers/pci/pcie_brcmstb.c
index 9de5c0e980..2e58ea453e 100644
--- a/drivers/pci/pcie_brcmstb.c
+++ b/drivers/pci/pcie_brcmstb.c
@@ -202,6 +202,7 @@ struct brcm_pcie {
 	struct reset_ctl	rescal;
 	struct reset_ctl	bridge_reset;
 	const struct brcm_pcie_cfg_data *pcie_cfg;
+	uint16_t		bus_base;
 };
=20
 /**
@@ -313,6 +314,7 @@ static int brcm_pcie_config_address(const struct udevic=
e *dev, pci_dev_t bdf,
 	 * Busses 0 (host PCIe bridge) and 1 (its immediate child)
 	 * are limited to a single device each
 	 */
+	pci_bus -=3D pcie->bus_base;
 	if (pci_bus < 2 && pci_dev > 0)
 		return -EINVAL;
=20
@@ -631,6 +633,8 @@ static int brcm_pcie_probe(struct udevice *dev)
 	u16 nlw, cls, lnksta;
 	u32 tmp;
=20
+	pcie->bus_base =3D hose->first_busno;
+
 	/*
 	 * Deassert rescal reset for BCM2712.
 	 */
--=20
2.34.1

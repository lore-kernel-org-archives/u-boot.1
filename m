Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C6810F284B
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 16:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFCB841A2;
	Fri, 27 Mar 2026 17:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="jfk/5zMu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA44840AB; Fri, 27 Mar 2026 15:13:38 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5436283FEC
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 15:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeaL7O7yX1Fc5BGXHaPuoQaL9iZoBIC1LMC3qC+lHImEkm+0BPDCug8jFn3Vu6pOGm5e0FbUS5wKi7QlSD1gFdeguedSJZZTD6vxvNMWAxVusurBVLGdcUgneKkkz9WR9RLa0ZJMgdRNiPgXenA9glPx7RqLkTP9tlo3E+b560tHBYxYhlLxACGpXB95YExpHVpIw4XxX8y77lF0nM/A6GtOYQn647OSkzEH751hslPHYSEDoutzcLEb73uiTmfV3cEgQpwsG1/8GFZ3X75a6Tt5aiTPzbhdetPqFDZ0OSMoGb0xbhYDgwlxXwCAauAflfP/mnvFBLBrPoJrhl4qmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=ORurwY+yjb6DwGWl5C/79E+YvmkNaz0WzsbG0qbTwMEEIMyxIPGbdUthAB+UkCY8kzczSKbXZRWpzK1+cEwlK2b58RqdyI8v8z8YaPkiXwvLS3YgmQyuQAVt+HhORm8P40XVY4paitgOiPmGXDru57sAxQeaMm1JVnTvT965vTn02zoD+o2+NuZ66Oxccc1Oju6RIlHFMYIjPttg7UdlUtTxdQDGq94sYg/n39DfSlQYBNpElBUlosLr6eISVhYzO+I0azxinINN++z/d45TQZFFqIZBrMPeXAVeiexCeEQtvc7HaHSsW/EPVQkJ1nRu0WMGztdbS6LN2HYL4N4clQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=jfk/5zMunC8k795Q44/XdRGhxYQSn9SJNHcqw8HOdsysKtU7V6csDe66Gb+gVfm1hkgLDsVs4KaBxBqNHVffPN333EVp9LY6Hip/FJy3uKL9r+Y622gMDm84lM5zToyny1xEAUvE5ew7rDnJGyN36Vh079XH80xOo73yhsFBqayQQCg8+SZMOyFYUHxvHRnZIsj/XO2k7TSBVxMStszXke6JdqLZSrlyazzKbm5fuG2W99nf91GjprbWPM/offRui1MGIRhr53U3cp/cWVK7A84DVLFfIbj95wdd2THheu60Kd2W1Y2bubKcm0l77fdy/4zwyFHTRTl9TNHzCp3WaQ==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by GV4PR09MB8437.eurprd09.prod.outlook.com (2603:10a6:150:2da::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.23; Fri, 27 Mar
 2026 14:13:34 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9745.019; Fri, 27 Mar 2026
 14:13:34 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v6 4/7] pci: xilinx: Avoid writing memory base/limit for root
 bridge
Thread-Topic: [PATCH v6 4/7] pci: xilinx: Avoid writing memory base/limit for
 root bridge
Thread-Index: AQHcvfPl9HhiDen5nkK3xQx2OfaRWw==
Date: Fri, 27 Mar 2026 14:13:34 +0000
Message-ID: <20260327141029.628483-5-uros.stajic@htecgroup.com>
References: <20260327141029.628483-1-uros.stajic@htecgroup.com>
In-Reply-To: <20260327141029.628483-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|GV4PR09MB8437:EE_
x-ms-office365-filtering-correlation-id: fbd1f533-7e0a-4cdd-e2b6-08de8c0b0862
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: kWyraywT/TLr+xpjhsFwNzw7FeM/qq5FVtSSi8kmJvLK0BgjSZldZciXR2X3lZnzlNN9sl4b/vl/ye/5emSGU4LMCYH2F5WnoHE/x9kfvJ4og2gQMOrge2MUqPSQjxqTsDO0Xoxoc3MU8yrBxIzZCpsSVrvAS1rrECXfVfyG80Vucd5wNsQ/L3a+EucTsuU7ymYpDYQHeD0o8FAFkkRW/gO3lGRihWigUKCkb+SB+nvVV44KUQPlTFJ8cynTselgTFUsDOaDW9OTHUkw3fNV6dMl5rNwmHjcOlCro5om6SrTY+oOZExT2RKnl3VDH+TmmrWBQkAbEED+cpHYtWa0LatPsHCmi8gPNTappf3Gl1OVzxS9t3fejapsp8RPTFr4kT5hbA/tDiHTwn1pgRtehVoK2PFw0WHhwpUN/g3E9FI5kOE3wU40qZat5rATuAmWlLY+VzYc2jTE4OWuCroI9Vqit3sioRBHhjN0ubjtQ5PTcAoKtVNPOWmDz1F4lDe5h//wM2MOpQ1XWz5IJDWzlWMG7z7VfwaMLlPZkfBR/54EvNsAhddbaERBWVlV4JK+bNgpRtxtGE5lcmCdVoDBAkX6OMuTWM6Fk0T1lZOQnfiY5eC3mnms9tTKaGAO7qFNivSN96qT7lmBnPff+pVLcYbCrQaVy/IvxowWn/9Ytk/R9Q53lWOS3cm+xuUzc4ECA4x4c8m0MhY8DaUSzb2WG61GpswXtdHJmHuoECEDoD9vd30wEyUJh5BYA7CVkPldnoDO/QMkNP3pZSGrInq5ybqilQVJNGbIArzzBy3Y2+Q=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BvzPwZwMkF2ttu4UtJelDWqYsWZwht1WApND745FuEApWlUzOEEeCdHZyS?=
 =?iso-8859-1?Q?NN2J+5RQb9Ub1FADc3KrmXXtXeDBA9hpPaZ/e8JSgBlHK3aLYGEuTbq0Q9?=
 =?iso-8859-1?Q?vJD/IwMsP4PzkvVbMtVAutMVhEJ795eUCoBW0alqvkvw4ggtYilHHeyjaZ?=
 =?iso-8859-1?Q?9lSu9RjJeLgdH/nGzcR7v+unQ7c9Uu3AmUHg50Uq5NjtRXw88OEID2E9qw?=
 =?iso-8859-1?Q?Q4oJWVHkV3bgBmYLpDnDO7zd2eMn9EGR+AMcVwqwWC8hQOwRNaXHVd4qGd?=
 =?iso-8859-1?Q?nxbItIlE/2K10IMjX87D/Tkgw6sheC+Zla1MIOw25f5t3bJSdRB/+ZTb5c?=
 =?iso-8859-1?Q?UO2b0IZF8LJyryMK1/6p7/atRUSxyV7d0RbfawyTfELwOMkHFBWrpThhTH?=
 =?iso-8859-1?Q?DSomMzHk+D+sMy10J+y8Tq119jA3dQ3DYfz2flm7uMaBE2ZbC0dWAIplE+?=
 =?iso-8859-1?Q?McGMrmjYiU0Y24fP7Ajw+BzMliyG2WClCKAypxbSFC6XpC5JsI0+pTeGUi?=
 =?iso-8859-1?Q?EUEsYcbuJqrZxpAfSI/YFA+c32+wDuCkthCY04ZCmTXKD4bCynav8JZDHF?=
 =?iso-8859-1?Q?W7XznsI6BjAvdErnOTyOyDhJhFwFaQq8zdLWvPJapvcTpQH/Kfip1iIYNz?=
 =?iso-8859-1?Q?r2xeaYZ03Vb0U0oaCkcHetJ5lcgH3wYKlq0E82i0QMI6dvJlPY8WrmwHf9?=
 =?iso-8859-1?Q?0BbF1YBh0l5amjXxPG/5EGtGclPEP/Sm8wW77YovqU7hTUcQvAvrXvW2xN?=
 =?iso-8859-1?Q?3Ec8pAw6cOiqsBINwvHXOQRFrI9iCmKVWpgT9N6h4qEWWYNGi9XZDlnB76?=
 =?iso-8859-1?Q?9NlLwlF/y6pbvyTu2drVc/yzh+eHzvxapaRdSTS2KgsCvD0Y1PGOLsmxGE?=
 =?iso-8859-1?Q?jdFp9vM34+k6WLjcvQeb7eYYZ47Qx4wQ09PLFz8I8AX1pNWhzESzMB/239?=
 =?iso-8859-1?Q?0VABJ3XA1KqeBu++G8jpxkHu+Pj4xnEI3aHkIcefE7dGrIHIdm2fopRcEu?=
 =?iso-8859-1?Q?pF/NgQUQIFjEbpKrrp7WZmrLwiEyDEvsXwTWgObVqWo42xoySsHx+JD2Pl?=
 =?iso-8859-1?Q?nNCxaZQuWqudOKr6GgOVrLwpcG8KX2XsH32UMKds4e/MQlDoQJLcJc4JLK?=
 =?iso-8859-1?Q?1bnCg/csmyb4l+iYXiLRVzyQjRO+VIc1DW2Wt16t+xAG72SfqBAlRzCzpr?=
 =?iso-8859-1?Q?gkS/Ou+iAQvh6wD1tjuNEJpSYDrF/NynKF99SsIqCDd+1zEXFP092niX9U?=
 =?iso-8859-1?Q?5f4jnyWRrCO5NCtuw0RHw56vKceO5PiQ2uwrOoahMVbbb1BVijphWoj3PE?=
 =?iso-8859-1?Q?AbJ8CksVAG0RmlQPYKsoYn4JcTi37n9fih8pE8EgpHcF3w7noBZKMHZJkD?=
 =?iso-8859-1?Q?NV8+ePhaKtt1RpqBfTSXgS4e4LbMk/PQOCDFSa/QP7IVU9kA0RVgukqeKJ?=
 =?iso-8859-1?Q?Cs1+lkjYEnCBkKjCQAXv2t8kRz2xkxeYhUMkTYA1cDOEOjL9W/uvaZ/xZt?=
 =?iso-8859-1?Q?RLy62UT+rTS7g2URKUrL26IS83FyUyxm+GdfgPTJaPkJbzuvKe5m1PZ+Dv?=
 =?iso-8859-1?Q?wK+G2hYDqzWL5r0LvK1pQ5/jtpeDWRZOx4+NZ9BHhUm7zbLsxlIa+g9tdP?=
 =?iso-8859-1?Q?6SiZtncIcWjjPQwoPDcGfja43xdOfM+eLNVsi45B/zEZNjDVzjTiQ7nij1?=
 =?iso-8859-1?Q?AwAcUob31LUi1ob7APGakydPfPJciiGGu+jmAB2bRIkPeOmckvtOPMyFIt?=
 =?iso-8859-1?Q?ccW7pOJaJmJvSq3MIEsHrz6Xp4kz6tdDtcPUNhvNYbW02ofjgdd1VpUcYW?=
 =?iso-8859-1?Q?3pw5Qc4szFmgGfC46g5vwRCUIJLMAB4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbd1f533-7e0a-4cdd-e2b6-08de8c0b0862
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 14:13:34.6093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8JbgjfT/vJTDzfJX+SfKXZ9IABW2jXRs7g8ljWFwsgmVB0ze5Ys3zjfjkY5mZhRExAtDhuM6hnK3ejE61/r9mMJA8MNn9m4sZSKQMslL/k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR09MB8437
X-Mailman-Approved-At: Fri, 27 Mar 2026 17:24:54 +0100
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

From: Chao-ying Fu <cfu@mips.com>

Avoid writing to PCI_MEMORY_BASE and PCI_MEMORY_LIMIT registers for
bus 0, device 0 (the root bridge) in the Xilinx PCIe driver.

On platforms such as the MIPS Boston board, writing to these fields
results in incorrect values (e.g. base =3D 0x0, limit =3D 0x1600), which
causes Linux to fail PCIe memory space assignment.

As a result, Linux can boot successfully and probe the PCIe bus and
all connected devices on platforms like the MIPS Boston board.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Uros Stajic <uros.stajic@htecgroup.com>
---
 drivers/pci/pcie_xilinx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/pci/pcie_xilinx.c b/drivers/pci/pcie_xilinx.c
index 63058e8e7c5..4ef20474a0b 100644
--- a/drivers/pci/pcie_xilinx.c
+++ b/drivers/pci/pcie_xilinx.c
@@ -132,6 +132,15 @@ static int pcie_xilinx_write_config(struct udevice *bu=
s, pci_dev_t bdf,
 				    uint offset, ulong value,
 				    enum pci_size_t size)
 {
+	if (bdf =3D=3D PCI_BDF(bus->seq_, 0, 0)) {
+		switch (offset) {
+		case PCI_MEMORY_BASE:
+		case PCI_MEMORY_LIMIT:
+			/* Writing the memory base or limit causes problems */
+			return 0;
+		}
+	}
+
 	return pci_generic_mmap_write_config(bus, pcie_xilinx_config_address,
 					     bdf, offset, value, size);
 }
--=20
2.34.1

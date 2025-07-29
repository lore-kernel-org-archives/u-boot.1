Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDB3C87FCB
	for <u-boot@archiver.kernel.org>; Wed, 30 Jul 2025 05:12:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E03D88324C;
	Wed, 30 Jul 2025 07:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="FfcWiNFB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BCA83045; Tue, 29 Jul 2025 18:23:05 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E65D682BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gebbutcQKvi3WsGgFRPr5guYGkL+H++q8qVD0Md8m9QV6RpGA6uvgzklJs9947w6XkEz4KP+VZE0oFBqx67gju42ISElStBVSEFsOVveaOOz1tSgacndRm8gWa7893OUbPy2IX42Uynywb6mhzM8Tfn6RGcsCqvGl49AlaTVqcBvDXB1uQ1kNavtTVDvq8eKEA5HFwkX4/h1y/+WZ1R6BX4qXachTcf6yQxJPhceZOi4tW0pfqXc+cVZQMTv+fo1GnO82PQly+hCgU0p2BJpWfeeKegE5r1Q2lhWy0PwY1BNkyrJzi2SnQdMmINFL/ie/NtP8RhyVLbxE4pUMbdUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=QNHmBhK8Ive57xKNVcdU6PPnz/bbHOR4d/cRAnVONFgQOV0NOOneq8ZtoOxQ9FVxtm305faY9xaodo90BnzxVolAwH0QC86CfAmykwhFPvI87Pb0Wrl2tKbN922RWP37Mkv5LSOZAfpnNEmN16OCD/lr8pRygBu/B0Nm3UqBnit1MBSosy5QHbwWO4jO1XD9LnJz1KZQqcsAPGK2OSyJ5HxG/jMXlQa3pLzB39UWYA6epUg2XwfWhjzWWrELLwy7YXcZMfdCV4g/gg14kQb6tuMjQ3ZZST/2pG/RC7sHyhWPiy9ZOS2dGqFojr48s3jEnMjaXATQqopzrT366gJ6sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=FfcWiNFBMvqwCKZ0beElZjqjeBM929ur8TWzBilQNS992jfweZYUAswuGDQfGvfhKaEi7tkQF0WZ9pXedg345J1yO5M5aB81qBb1SFwwO0vmU7A+o+dWukjlUhoE4UceAwSQ7DwU6rdcQnkjhLEmpSg0kimPWsr5NIGg3NGNiAnXJS6KfP8kQsVCzQpiIbQ6GR987x5AIqVXtVzGL0bZu2ZD1o5N+YvjEq3qdcZDoqJnHzUJLdi4/IVRf4zNvB29hSYYCq8wLI7fbt18nxhkbkxv/ay+WkiHHNl0I8YiOWsJO7SovNajC3tZ06oLNfYq5u72VVZfX16FX7CZmtR1Dg==
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com (2603:10a6:150:a2::7)
 by AM7PR09MB4021.eurprd09.prod.outlook.com (2603:10a6:20b:114::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.11; Tue, 29 Jul
 2025 16:23:01 +0000
Received: from GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7]) by GV1PR09MB5977.eurprd09.prod.outlook.com
 ([fe80::5e01:31b8:ed86:eca7%4]) with mapi id 15.20.8964.025; Tue, 29 Jul 2025
 16:23:01 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v3 04/12] pci: xilinx: Avoid writing memory base/limit for
 root bridge
Thread-Topic: [PATCH v3 04/12] pci: xilinx: Avoid writing memory base/limit
 for root bridge
Thread-Index: AQHcAKUNTvlfJcwzp0acirICMq4Vkg==
Date: Tue, 29 Jul 2025 16:23:01 +0000
Message-ID: <20250729162035.209849-5-uros.stajic@htecgroup.com>
References: <20250729162035.209849-1-uros.stajic@htecgroup.com>
In-Reply-To: <20250729162035.209849-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR09MB5977:EE_|AM7PR09MB4021:EE_
x-ms-office365-filtering-correlation-id: dda08a2c-d34d-417a-56ee-08ddcebc3076
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?7YVY2rULc+52FE1T6wR7NNNopSMaEImyB3HJjpMVAm+8Ox/Z8eO0K1fb88?=
 =?iso-8859-1?Q?rcVBYhl0Y12X7F37z1pBv+tCdP+R9DHRWi1TYJkecssuJnj4i0ujweCgWf?=
 =?iso-8859-1?Q?Ir2KwEX+aMf9q421iTbSLSOWPw6LnXK6p2hn5dx4uozLXvEx8h4NJUJ/wF?=
 =?iso-8859-1?Q?Dn6AGjAryZGf5vtj8N0Tm6WtFHb3U5ttxJj2HVeXnHnBl5VYQTHnzpacCP?=
 =?iso-8859-1?Q?CdT4CsV+5g5YELqTxPBd4VTOdaL2CMTTseVbKGazOgd2/IodnqinfQ00bp?=
 =?iso-8859-1?Q?suUIo0AqUpfQfPqVfB+qBGIV9SySy8EJZ1xKVXCEdvTNRL1Yi64Had5/jI?=
 =?iso-8859-1?Q?8Fb+SfjpKwHgGvCtKkZRrYMd9GxxeFipG4m2zFcaRZqTwv5+uUEiIWuvoy?=
 =?iso-8859-1?Q?P9+uaPk7kRlpe3EuTb9gkcmsGq/l9PMxygD1cF/a3AhThOHPsoqZ3atz0z?=
 =?iso-8859-1?Q?HQA/ASIuSIKVU1hNgjU0xmsSC/8tCDDzsZ0C+N1r8O4LVNVy2hi/DYyi1m?=
 =?iso-8859-1?Q?QHtDBHRnRwLjAal7shqm9lBsKeUcsMiWuu42QJWFwfSVv1HMLjnSwt4dmX?=
 =?iso-8859-1?Q?QXwPTNYVcD5tdTi62/GruBWrjYktensO9L+4aEpjh5KruT5vnCSuVKuPCW?=
 =?iso-8859-1?Q?GT+PS0XntG4tzVZGXyjDgUPYfEHdrH4DEELk7bSXG2Pwqj0z/xVWeHDjjQ?=
 =?iso-8859-1?Q?0cZZSzYyotxUupQeE3tmzBoDSrBSBBJO1WNE5mz03a/kptW+GntMbPdO34?=
 =?iso-8859-1?Q?WMyFmfkiqxuUU9uwMWFjfejLdso+XJKUtlm/lht1epgqdXB8Tjv0IHT3mp?=
 =?iso-8859-1?Q?TcMrBcW4Ac6b4MQqBGDwhxvt4R1CINnjhs/NJgXENEfeB+24y85nnSULiw?=
 =?iso-8859-1?Q?f5t3F9H4/6YjzWx+TYFcB3VG66Fr+lN/IIXrrQ5j4loS0NJkqpOuzO5/tV?=
 =?iso-8859-1?Q?gL5dH6Aq0h17rXMu5C114enMxDWI4wW0JdgBZODZqWXXMGO/tN2JYZeV52?=
 =?iso-8859-1?Q?1VoAFKt0v+Bz6VEH0hqiMD+7hQiI3zDkl0x1LCT3/PmDUVqgKWUaCthSAZ?=
 =?iso-8859-1?Q?oTXRx2MjqwejuMQSWGkolSmwcjsrWkUXyLZYYym1hc+36z5xwBCNdVrrER?=
 =?iso-8859-1?Q?c9PwBaEtS0cTztVYdmQCp+oSEBFRqgPQ7oUI6FPCo6TLc/cxN7LcxNFVK9?=
 =?iso-8859-1?Q?t6EYCoo8xxPhUdfM4csTj2MStklJrjTyNii9JZd1LduIYtW90zbrz+1nHz?=
 =?iso-8859-1?Q?LGFYkTWkbKQpd/+/sQcJUgj7NZKV+K7opIEvB6LG5RwDfi2Rn7OQO5iGFE?=
 =?iso-8859-1?Q?RML5E3n1kk+TWTILzo0T72Pk6DJRAeyUlbszhyjQ350CoYqvBBsKDVbpOH?=
 =?iso-8859-1?Q?vHRlXvokFKzO2obn0IqARnxsWiUaSbClTBR+AyLwxYF4xW1yvLGNeYmzWD?=
 =?iso-8859-1?Q?uxRJp3nHNgnAbOE1KILzyDHZ2GNWIy9BWYx8pNqt0TNTxWQL32PzpTCzfv?=
 =?iso-8859-1?Q?nnkgGRL8ZjttmZJUJzIRbDaPdZpFJxCl+M8BUO0ORQtBJmyFIiXGL3yYrz?=
 =?iso-8859-1?Q?kT5XuYk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR09MB5977.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9kBi6rW0hWHARlRXYan0SuSvn2n5FIyaA9HH8XiRURPTcFEhtJfGrxqvcq?=
 =?iso-8859-1?Q?ZK0IaMBd9moAx9mP//3/jT3vKz/p/oufHnKCnCq1bpjdB0s8NmkVQ/0glS?=
 =?iso-8859-1?Q?IWwVr9fsrdMOvQiYDOderB5iMLhs8IJViRQkru5A0qIgoaKBLVt9DPDnFi?=
 =?iso-8859-1?Q?iaeScE42Ceoa1/VuLVabr/Um52uLDCyXCqEc4pR0LXOSz+oTWUUYl+S2df?=
 =?iso-8859-1?Q?NHJ81hRBRhQtSBL3BPUwTPICc/T2o8FwTt/s4T2fXwBcaBcVv9krzws0sx?=
 =?iso-8859-1?Q?m5JimhZFeNpRAYdtzg19nKZ8QG8xYbMvb+w4tMrZoJqBcdn2aut9p10Bjc?=
 =?iso-8859-1?Q?eYSqU2o3ZbSfJKRXRwjiqYtb7KMZB/QM+y7D0/DjTB7xhzm1xFMltIpNlw?=
 =?iso-8859-1?Q?E1H2b9eRv/EKhPzAhvuZvWVmVgmgA5Kiymqn4oj3uO3/AbG9icOXJO034A?=
 =?iso-8859-1?Q?ITZrziLcoOn05qrZK26YeNz5Smt/fia+izugULCPEb+u9Nz0RyvVaQpC1+?=
 =?iso-8859-1?Q?/4y2bDO7pCLMobn0vtiHa9vTvmERPPoQGdA+0v9ZfL9xIvPKhYNX+w1AKH?=
 =?iso-8859-1?Q?rrqwfcbf6HuS+ah4W6XdTBx1AobI/UX7uQMQxplE/gKcJgcSm1zyEjqdDg?=
 =?iso-8859-1?Q?OoeeUOyb4lkxoMRR+qRXMcm31J6E9bKIZQJl21jrhQneY6/kmToO2fEX/I?=
 =?iso-8859-1?Q?b+In41X6YWk7VBmAB3HID4n02VJvqjERzGLLUd0W7SnLKWcWYuQafp3KTm?=
 =?iso-8859-1?Q?Usd1XIV/JHuM68kHkzjYFdtWcZPvoFc1lYQTkU8s2bsY0DEkAb5U7uZR8Y?=
 =?iso-8859-1?Q?nUsGlWLgTaiimRw2Wn1aMvvqdQ4nIsGRAm24HUi6VMoN3A2yv2kpCEXNUH?=
 =?iso-8859-1?Q?yQukzF3PACraxglQzE+VyqIg7FsdR4zR+Y9ZlUG8DZtg1mn+os3rjXRHm5?=
 =?iso-8859-1?Q?xPO89wixUiCNUh9eckZbhE/RkkpAurUsDb3wG48czuKOeTiKgOYNv2rMNU?=
 =?iso-8859-1?Q?cF9FJHJK0o19ifY8XZ/WbaRBIU4hl3R13Nwu9fj5E8Liz6h+ncGs1FHPkj?=
 =?iso-8859-1?Q?IzyrojPrX49u5wjsRn4F7ZgpgzTg06J4yj9lG43oRRetS5HLlC6Lf7ctgK?=
 =?iso-8859-1?Q?4ItjHb2vLUpfjo0JqZVyRYCXneBYQg3SQ0qfZyppHOhN0zaLRYi9y93/X8?=
 =?iso-8859-1?Q?QGfodfgjuZcTh+BBgZnPDpRNfsLVyY9rPj7uQ+OLRW0j3Zh5FRffPJmOES?=
 =?iso-8859-1?Q?3JMmAmnn6CS9pXQXBwz8WQsPLg2qInLffHnd3ImXPVkMduTBYkO+1ph9hB?=
 =?iso-8859-1?Q?KQkBYcoYMr14VOByYxbMSVlr4oapENgjYyZ/ARaDvzAYl35V7ezSiPiig5?=
 =?iso-8859-1?Q?rTjCe/CAxcWjdYdCD6kLVLXEqB2YYDlKRh4deYp70TdHCpAHrcov9jpgtX?=
 =?iso-8859-1?Q?6xm1Nmo8fyf1Azmn+vQ25BXJIi0qxufCc3mTjK7Y2LqYljA/kwVKLKstRB?=
 =?iso-8859-1?Q?qTyH6p2HG+zEXwQWZ+bPdb8WSCMN36Xbj8IqvBCD0PZL8Ousn6WXhTAVvd?=
 =?iso-8859-1?Q?JrDmmn5zZec57ygyzf4bepvp32yYGQWMDjpQ3bEn3xshNLxDxufcAYwJiG?=
 =?iso-8859-1?Q?I7G2wUnbmpnt0ArmlxytaG0/xmTKLjVW2r/sGJECaZ/NQwa8ERYnUmVQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR09MB5977.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dda08a2c-d34d-417a-56ee-08ddcebc3076
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2025 16:23:01.8429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4JKqzZ0heRHfg55n0Vc4pOsBUc6plld95nQXMgLdFe9KkHEI1Mefx4G0M9a+0Dg2qtz6Zc90CMyer0ZNFs7ae8zF5RyXJkHjfqRiuU+0d6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB4021
X-Mailman-Approved-At: Wed, 30 Jul 2025 07:10:08 +0200
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

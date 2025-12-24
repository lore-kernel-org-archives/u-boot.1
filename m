Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE005E776EA
	for <u-boot@archiver.kernel.org>; Wed, 24 Dec 2025 16:41:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18FBF842D1;
	Wed, 24 Dec 2025 17:41:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=htecgroup.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=htecgroup.com header.i=@htecgroup.com header.b="PTBC26fb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29FBB84295; Wed, 24 Dec 2025 16:46:28 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35CC884261
 for <u-boot@lists.denx.de>; Wed, 24 Dec 2025 16:46:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=htecgroup.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=uros.stajic@htecgroup.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grO2mnKA4KukRyeqDLz4CILdcWBbVMehkj71sLsFsA7i01s+vBlbFxp8rKtDdupOC8KoQdOkkLWVITKp5Gx4n36fHuYEj/QqfX4OT/mGNXe5Ox90KAEJdbAs3jUAqE8fpkB4Ny+990s9n6PA94537+64XaJSgz492mhrIROb+6GyGt6TMSZwrHfBASWuNfgRVfLEYpKqUMhBoeIen1I2uzWdLYaaYpy3gI3uGj6/WtZ/hHEJO90Qi8k2e2ySZ1UqcO7NdRpJm2BilLU/n5pIAEue8FZjx2+qAdmzDikN97/st6LRpAnWqPSg+PZgaqOr+B/jsUmnmnzogWvLwebOng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=sG56TeleOYqKLdkr55T49mcDpc43ZgOey5i6m68A/wOWInKJd9cOayf1jHniv1HJWGfJq7kSaptnc9wGxCcNZC+spBJAgV1NyumKOfLLuNWr3dXE6/jzYrsZ7Y3hp5/3tyhngwdUR9TPkFn1R4dHN+xqi3LRFir1jjTBDdBglDMwO9M+nkl0JI6xOsVBpWECJj1QHFZ/VBGJl4cYVYwITIiAo9Gg6QrweMG/qTEFTyh7suoU7c5oDn1XhGzi84OaCgtYIARMdedN1EX65BjQ+Sz8CRGhPFKW8qc8wbG5rzL6Y8qi1DkVSqPummJCW3Kg4ZMq8pxD58LyZ69LdsCo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJkuNUK7c62Zz4f0E16cS5K6MLL+EQNLk5a85VTvfPs=;
 b=PTBC26fbHQnTsLfTduUYSd32RD4o+lels4S5L0Vsak5Z4zXwnMCaqE6X0XGjXxoTPDpvg56eT3iDYhkMoQPwAlayneU6ufGrVt4WkGQaKm50Fekohybzmx+mbkDFDNZUELtRAKD8pZpJo+KfYYoQWcxrMsNU9xPpu7m/jDNBR+lkkwPLT7Z6/0rbqmBQFFqkBE2pgYIQW2NygC30/In6GFC1CCIokz7cCIDUDbaTpjhFp34yADIUx128a5cEZA9tfL8v71ZC8aNv6i+tIGnuRhaNEFZFXp8Ff8DiOwZspruSpXr4lpSCGVtdNeUwSq1tMFAY95UbuChYdQMgV/UQqA==
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com (2603:10a6:102:4d4::20)
 by PA3PR09MB8195.eurprd09.prod.outlook.com (2603:10a6:102:4ad::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.10; Wed, 24 Dec
 2025 15:46:25 +0000
Received: from PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81]) by PA3PR09MB8140.eurprd09.prod.outlook.com
 ([fe80::ca17:d4db:b6cd:fb81%6]) with mapi id 15.20.9434.009; Wed, 24 Dec 2025
 15:46:25 +0000
From: Uros Stajic <uros.stajic@htecgroup.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, Chao-ying Fu
 <cfu@mips.com>, Uros Stajic <uros.stajic@htecgroup.com>
Subject: [PATCH v5 4/8] pci: xilinx: Avoid writing memory base/limit for root
 bridge
Thread-Topic: [PATCH v5 4/8] pci: xilinx: Avoid writing memory base/limit for
 root bridge
Thread-Index: AQHcdOx1VLm/5KFK10CH4p2OC6weFA==
Date: Wed, 24 Dec 2025 15:46:25 +0000
Message-ID: <20251224154449.946780-5-uros.stajic@htecgroup.com>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
In-Reply-To: <20251224154449.946780-1-uros.stajic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA3PR09MB8140:EE_|PA3PR09MB8195:EE_
x-ms-office365-filtering-correlation-id: deb1657d-d688-4e1f-1df4-08de43039844
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nagIzhaasgrYFOjuL1DZjZujkepUQNxH7Mm0F2ulZICpzfajQJ77b5F//N?=
 =?iso-8859-1?Q?LvyAxyEVKzIxluZnruyeOPVmYq/3CwzQFVxCHdytPjXo4mKTZhvdDl/1nt?=
 =?iso-8859-1?Q?kunElBdqdBeylNirYF7SzDNdV98/0gLCVwk06eKx3BmsoXryIFeXdxC2/m?=
 =?iso-8859-1?Q?zwK78i+lrg2Ycw6T1LcJWpE/zUKL/PwLjk5nBZTGjpQdEr9+5hGY+I8DC/?=
 =?iso-8859-1?Q?+ZZaLOyM0y3vICrPWNJQ8yfeduDYWZXUBc9xFijocwkLCdV/ydakNLaQkG?=
 =?iso-8859-1?Q?OD5i3IRZDQAO8Yam8Yq8rB2/XIlP2FoICcYxDWFegBtbazTaTTI4ag8nJl?=
 =?iso-8859-1?Q?7TM4dlbLGmclWHiItWi/n6MiitMGKSgcjJ3pyEH46cHMUMwZgZ2eiTGt/B?=
 =?iso-8859-1?Q?B5HMvBjrlSzESAnHLZlzreb+Omy2N9nI0Urv3Tw2ppkEVrLCEqACUOD5+d?=
 =?iso-8859-1?Q?BzIPSTMZe8Gag90CqVnX+vQ8o1FgZzeBPI+PAKHWbnvJofNC1C2LcgaOpC?=
 =?iso-8859-1?Q?HyZ3Ztn9EYYBDLu5a/i4dH3Rvz3UljVzpBgs5nyRynFHCzxLoE7fD61Q1z?=
 =?iso-8859-1?Q?1vICtHtqHZ7eZeivDFvI/9gB8F0+vCA9dVOK4vqfvvdHE0bbbYy1ZblUKa?=
 =?iso-8859-1?Q?nLgYPGNlU+Ik4As7MkKxuyIWMPDgcMox3Jltyo1Zt1EE6UMJWHLn38BPEv?=
 =?iso-8859-1?Q?zV6Lb7Zy8bjeplhmMBVQq3RUluoRXqjJIqVHoY1+ojNw7Ja7+KWvX6WAQn?=
 =?iso-8859-1?Q?cNtMJCvENoPnyYV1mc+CGiByuSJtaz3aHwHj4Rm8LF36w+8axTPEftaLe1?=
 =?iso-8859-1?Q?Q6BwzX23fpal0IaPScOmfhKm5+nxhBu0+fhvUjIkASHBsoMYjsvwQElJCj?=
 =?iso-8859-1?Q?XQHVztfMeAgiobIz63y09PUvu1ccy8jy/MxzzIV278TY74C0hf9UZkwCj6?=
 =?iso-8859-1?Q?g1sySWmmWEZOrKgypvu6CKBc9bakPBJFO681QXsZQrG5/qRLMe3hNFntS+?=
 =?iso-8859-1?Q?kt6c3NIot/ug5wksZ+vT6FG4XNNl9odS9ZKCc4m6SpSinzocrSjaXgig7B?=
 =?iso-8859-1?Q?1j2Eg+OAKOKFpiig9hwoVI3f89A48fapKhx5Hq6VkoBrqW5aHrqqmt4Csf?=
 =?iso-8859-1?Q?1vJF4jAAFVSBzz+yXU2IJVC8bFfftoynKHs7nCw0A5L0Sab7CJJZ5XuoN9?=
 =?iso-8859-1?Q?aCdH3IP/9yX114rM4eNHT/tgEDsz1n/hU0dDqA5cZWoD9trMaGJS6YIm93?=
 =?iso-8859-1?Q?0xlJ3qO+iaM05xGrVHwlHoV30suPxWdlVERUs84so1jckqzBSyUUGDqZ0Z?=
 =?iso-8859-1?Q?W35A67NtkJu5uZVTX9xS9qmLPqYUoc8NlhdAih5fq+MkRTuZ9y3FhpE6uW?=
 =?iso-8859-1?Q?aJhxA+V1Aq4la+Yng/X+T9vHaFT28FCGxSI4eMQ3J2E+cwczCvevmYeJVN?=
 =?iso-8859-1?Q?hc/ql1lwDlqbnu7ArA3+53+swpxtQ/rleq/anv7V9rny6G9pACpb0+f+kG?=
 =?iso-8859-1?Q?d9jf/wPEHQOaHhcJvoOgjCK8CpOhAf+qV9TLZVSGn1hZ21S85lSShun0Pm?=
 =?iso-8859-1?Q?k8ia+Mm/eMrbIw1pJXrgbv+xLdYn?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR09MB8140.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WPNz9Z8fmVtGW829B6rRxswB3MVmKLFpiuBLjuLbW5N2HdJRYr9MMEt/iH?=
 =?iso-8859-1?Q?LzlpIk3+CjsIZwB+ZJZQxHHkql0zYwjw7hXlmBpRHE49I96RDUay2sCHUi?=
 =?iso-8859-1?Q?kp9jHHJZ/nKgvxEzm2BLYHVgNsn9+gjUhhSKnp6PNChOWnjroxv6eI+UYn?=
 =?iso-8859-1?Q?KBj1NCLVI2XqxGAS2nuiWll/Qzv8IT8ZgNql4sPhcGUanhOz3nJ/zAasK1?=
 =?iso-8859-1?Q?tOOhNpasO43j2klWZcyGEeLAv2FXe3mJPCdT6E0rDVBpcntdhyMvIQqik+?=
 =?iso-8859-1?Q?TYMySDOcffkyTMgcWwx6D5UeHYf3r6TNs+pWrtNvzC1QWtb+HtGZUBWA0h?=
 =?iso-8859-1?Q?rKn/PyYhWjPbJEyCPd18yy+GwmctE48LriwFL5jEDnWiBpIZCimJZ8o+tq?=
 =?iso-8859-1?Q?N0CwL6HGV5cM6063JK/EAiCFSx5z8kjzcA4tQYpvlWY0Q5Oq6wUj6dTJyb?=
 =?iso-8859-1?Q?J8SOS4hZ3KWClT6aGKKRfjhO/jrSZBV2FGT/i7voEfrAYF70u6U/gU0zzc?=
 =?iso-8859-1?Q?nUzkm14x8HJQTKvweZXJ0p+wdZWQtI88pqrKN0/NOdVz9Lvp7FhVzu+ZGI?=
 =?iso-8859-1?Q?Qu8ktJLR0IsNlLHssSOeGTqGpd2Ajsarp8+vaOsLO6NIHipwULexKMGqkW?=
 =?iso-8859-1?Q?h0dOQZkc4dMJ3p5ENZv/1/bVnOZLR9lP/yHthEQN38fbt3P4II82HOy2d7?=
 =?iso-8859-1?Q?96/33pDML7qXlMaPTMPtjY7GzfU7PyfPUzEOxGMLS13SO+r0ButxLtCdy4?=
 =?iso-8859-1?Q?it0btNLrFmFbz+uNje6hleVUKDAwBFCZs9mWqMVvpBlw7XjKkZ+DGuLY1P?=
 =?iso-8859-1?Q?kFezkAlagXjTjTKGrUSn+Ic2lCkEWt5cBB9oM1bzM4v1nVCAjNvJAh0NnT?=
 =?iso-8859-1?Q?6JDzW2aB+gTfZJ2rlXlVxUggRz/MeBfzf3TsCOe32oC8Z5AnDIvx7rgyZw?=
 =?iso-8859-1?Q?JLARUOLRSco0zwSWUUsa4N6N5MIDTGchlG5vMiGmuxa7DPcVLzUw9godlB?=
 =?iso-8859-1?Q?ujYZawYvVUbigDsa+cp3lkcz1UdFhhYJUhHJFyrU8kqr3rYGUCtP57y4E9?=
 =?iso-8859-1?Q?V2FsksqTFe2UHwsT0aew7ptPy4v3Dj0rBv+PXwOzP8uG1EUDjBg8K6Fjmm?=
 =?iso-8859-1?Q?TeYNsqR4r9PRoNx8kfNHC2fuYmjMqKOAljzbZx9t0wb1IiBiJky5/zl9rj?=
 =?iso-8859-1?Q?DWnvMz4uOGRCl5hD8Yf8trK5e/wS1eqpvkFyIkQ280+aK9GWLw490/eu4m?=
 =?iso-8859-1?Q?0zukJ+utMCE6ZY4TY2HhiW/uvi8XkN/w20ufsXgCq76vkLnftsw7ke/hng?=
 =?iso-8859-1?Q?WiBrFQNTURzP+rNw3M1rS39SdhWGRJQ4nYdH+VR901/WlkL2BvAF2AEQlK?=
 =?iso-8859-1?Q?X+IeXMkjhm1bW+GpZckDPmgyey5dUIJvSfem7me+HZWWw7Pdt4y72kipTI?=
 =?iso-8859-1?Q?3hGWdevnFPenGmxZOgLUgf1UrqdMDquz0nkMigLHoB+cL37DOrYQZOwxvw?=
 =?iso-8859-1?Q?gBobd6JvSooDXEFPkB3ws+Qc/Vd1K8It7Rnof2LZ28ZabJyofLDOCwl7NP?=
 =?iso-8859-1?Q?T5t3RL/FOx62kLZ1oXZ/sLNbjFwtercqpwjz06wHT2vImMPA0TahuHHR2T?=
 =?iso-8859-1?Q?N+h+h0wpNBIHFRgewwbJL96Wlq0iIEAZdoqRwme3nIYYjDGG9q6vcDzxmZ?=
 =?iso-8859-1?Q?zcudrcba7ZUPbKa1YDc058Z19ccTI8tL0G85u+C1d2dTTvQRPx/0weRLFI?=
 =?iso-8859-1?Q?3WxT+V+C0DccVahSIaDxRA/KtyfbFoSGk4cjFebFUHeovxOgaXCbP+4jCk?=
 =?iso-8859-1?Q?aahiWQqNUTrXEoUyDzk6ZjqQSnTRmbA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA3PR09MB8140.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deb1657d-d688-4e1f-1df4-08de43039844
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 15:46:25.1343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEzMvg61TIihj628Wd584ZcD5PDXJQ/8gijwDh2UPYQn5OfokpjNsmMbyQipKnRqsay6dH7B6dcvn++oHA605+nqTj7Q94Mfd3EXExWCnp8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR09MB8195
X-Mailman-Approved-At: Wed, 24 Dec 2025 17:41:15 +0100
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

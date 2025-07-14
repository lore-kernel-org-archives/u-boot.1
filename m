Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290B0C83F1B
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 18:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B5098300B;
	Mon, 14 Jul 2025 20:46:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="Lx55jE05";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D966283046; Mon, 14 Jul 2025 20:01:35 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB0983020
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 20:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=anthony.pighin@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yy3+IeK4+olbkib8HjDiRBs043lFg9hc5Mk3zmyoeHynmo7mQ65tH9zrgdHWnaAj3W3AHRilTS+NaBHllGsvV4aePIbmbM+VYFhTLwodSDNARpXD0eJSiuF01cKOllZGp4w0UUgVwgl1b+aZ49EnHYoJOeq4hQnyudAWXcUk/MjZga7oCzoVE+8DRdp95dllXvMb3gemZMDXl03JiWfJz5aZWzjMzdZQv7B3rsqN0Tp39rgJw2SUOMdm1s+pqaiqOmcGwr5UdlKNaTBG3jU++xBJ94dugSMS7WL9yRSdYckXjGPHMhUWk3X5OLDGnSKZUS3qLrmEFcNNNKI1Jggucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgMmgPPtK5IqT/7as4zoS8bWD0xnbJrfYGEVqB2cilc=;
 b=XTVXzY5vL7BwthDeC75oIB0o0XR25eTUkvtTk6e/BwrLfHB03huEFZkKF4BpoOxXnwW6jtpef5df4/x+rSDpgIW7yLB7k7/ManrbSePyfPofMDmzV1bg8eAmiSRDiKq0MkTFlQY8loexNvlauIdT4zeSQJu1fHevYudGk3cFmeT37gHdGL53JeKOCzvthfR9ONMdDoLa9HiLPoWScDLpjUaimq+eIMhrBGHplKNQU3ZzwmKvnpFrsjB/i9KypvPp7pUS2S9foxB9Rq9/wBoHyHxzJ5G+3jR41zeENwJ08LEt9WiR+ev9giUahF6N7s8fnL6k49g7lkISwhJw+qaYkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgMmgPPtK5IqT/7as4zoS8bWD0xnbJrfYGEVqB2cilc=;
 b=Lx55jE05U/7jEicef+PMZKyE2oqppoxfykMDcIXLEiXwRr9stQr8wctyykwgb/TD043SSwbJfQgvP+75eJFfaV0CbRQ0sdtlj7h7Ev8ug0AfNljU2+XjisfJkhX4i9tFvPZCpHiekmz5cVwBZ2FLE3zuJ/bL70zlOf41F9WB2cYXCuil+AR5QAM/1nyMnGtHrr4j4MjX8WeHpuFuQxgPhVJFOiePTm5aGQBZ8EadbFYIjgZSzRtz4Ecj40ck4C8I3rhKrbw+ESiIJ+Nw0Teydk0zLeho7xuYF6HRlkTHUB4Cl/Re3SMS4B/pNW1A1Dn1GfGxM0WMQzg3WaCWfpH0UQ==
Received: from BN0PR08MB6951.namprd08.prod.outlook.com (2603:10b6:408:128::14)
 by DM6PR08MB6347.namprd08.prod.outlook.com (2603:10b6:5:1e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 18:01:29 +0000
Received: from BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36]) by BN0PR08MB6951.namprd08.prod.outlook.com
 ([fe80::9ea8:ab2e:4ce1:2d36%6]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 18:01:28 +0000
From: "Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: "gaurav.jain@nxp.com" <gaurav.jain@nxp.com>, Fabio Estevam
 <festevam@gmail.com>
Subject: [PATCH] drivers: crypto: fsl: rng: Reinitialize job ring descriptor
 for each iteration
Thread-Topic: [PATCH] drivers: crypto: fsl: rng: Reinitialize job ring
 descriptor for each iteration
Thread-Index: Adv06CvHynxQxl05SyaIAFw4TNIM4g==
Date: Mon, 14 Jul 2025 18:01:28 +0000
Message-ID: <BN0PR08MB6951D0B436D20B1306B6AC818354A@BN0PR08MB6951.namprd08.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR08MB6951:EE_|DM6PR08MB6347:EE_
x-ms-office365-filtering-correlation-id: 3d5c26b3-b25e-4db5-423e-08ddc3007511
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?RzWEu7iPF2f1BP3xvHzwz1oSvXORIrjXkPipeReHXNVXmzdAIub4RoeIfI51?=
 =?us-ascii?Q?cEn0uwf45JDlMTDYVZLjlO2HF3LBWyPE5GTUPfFTVXVQiHzaxsKZN/K/TA3O?=
 =?us-ascii?Q?u63RXXDBwKnzhvVGMcfdXQrq4iAsZu5ZFP3wkBY8rjQJP/6nAXn/pZ5AVfiX?=
 =?us-ascii?Q?z973mwckXw7urQkaFqMBVarpRJjtSLVs/yW/7U7DT+J0vDQKM7/zjhKB3dwq?=
 =?us-ascii?Q?VoaV0QHVJQfbL7upY5ajTeR+t51QdU7YyA5VoDgTHbbuTDVZO7hA6+dV2VQ9?=
 =?us-ascii?Q?OjH6sfUbUl1MMdBTxczH3lkWJQOFwrBjsuNBSeYrDEZVh4l0G1fdIoznBCSN?=
 =?us-ascii?Q?dsAI1pY4mlAfX4kiDeko1ltqzZqLfYjLVKM2C4awnqNfB9gfR2+6wMLUXXrc?=
 =?us-ascii?Q?5cAmOFZjBhhbtxnP8RtllC+0z/LJ2l02MDO2hXCXfAALQZcK+o08wDVzr85h?=
 =?us-ascii?Q?Uc/0K41J0nGbfWxBXcAfwhflG9TfG0cuVLRoyfSqaloo2HYmEJh3apkds9PE?=
 =?us-ascii?Q?3mDYrtJql8uJ/HjZpLmuIKOOdDeyb39Kim5i8oO3y53zRA0wPYa9QZpQcSk3?=
 =?us-ascii?Q?o72xvQkTOj9/MZcZPGI4aoHsuTLpUfeEeaNU73a4T+m2VxpE+hGQeYtjc7gH?=
 =?us-ascii?Q?VISsuc3XYYBqNVZK1K0FX1s/IGjRjiCimY0DlyYBjiibOdWsgDW/ZoWkkoaj?=
 =?us-ascii?Q?Ms/5ITciiWeIR2o2w+zB1M8CyEdpWj8JwpVubuFlI4peguibpPKh8rYo8N0y?=
 =?us-ascii?Q?8tsrMRLuT9pcVstKfYYzQt3MjMgTHMpqO9I3eQsrkinCS1T54Qj+xTseXmcr?=
 =?us-ascii?Q?vnCebXPNBDztN2jN+qCZmbsaOntgh3iu/aOU0cDfCihBETkMdYIGMNGOOylc?=
 =?us-ascii?Q?W3DAk/Nvv/8WzVnustnIp8cWI0Ko0TiHDrRLmy+mUJmvmyMKJ/oKbNTn2wRQ?=
 =?us-ascii?Q?oc+n8CqPI1R2MJf+aJVe/66ucK9B4UnrTFPpq0JnyX/El8MVpwMbjJdPJE9E?=
 =?us-ascii?Q?HnaZUf6F6CVpfZLRNn9gt34B8vC607pkOqOvwgI+Ti420WTAjGxYmaVIOk8G?=
 =?us-ascii?Q?+Xg6gZXrJrCFGEA6bRUjJwa3cCMtD9EpWh3I/w2PK1uJAuQ3T1l62K/9iUSL?=
 =?us-ascii?Q?MI+Qm3/YEyG1aICjEujVNcXXbwAxnib5ppFntsGo1u+E1rMkKkbLVAxEQC7z?=
 =?us-ascii?Q?lD1lb+3BhennwIEEqpA6DtyceBehjbRo2Q5yKQhvgvIhB22wTi312+4sLob4?=
 =?us-ascii?Q?oXACMGhNiugdyzzWX2UXPhanxGmD/ournsfpHWlRYgw3azHUs6+Awh0ntyZ+?=
 =?us-ascii?Q?Yhpt2OTSXmQpkfiO2gDFOdnfEarvUt8iJW7OOsgbTWBnzcTsrghpkfFXCnpj?=
 =?us-ascii?Q?+lxZlH3/It18JoNuqFvBT59m8G56XF4ZuxBBsLFIsJMBgA1RyjHQ06TgNmaQ?=
 =?us-ascii?Q?XU6GQP8ns7DllIAdDy7+2EGnctQeVPw68kN/BlwmDp6NJ+Nhsop8MA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR08MB6951.namprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PYzquzzyBE5B/CEUfwO7h8YP/akr1X6SNsbLTY+sXYw3HajOXfi/DAup/XFz?=
 =?us-ascii?Q?2XbeuENkOv1wdz/WJvVHwEWnhzszQY3ugIPZidnbv9BEZa3Ox6ybEtV/pJCm?=
 =?us-ascii?Q?BDQ6TmH5lvgeGPcM6i9P8Ed/Uwa5amUf2ys9v6ubnagIjwbKsGpDWzjsBHch?=
 =?us-ascii?Q?0YT6Yfm1QvyBycHr60GFGLrRr/I16bxKeYqRuGiL/bhpyMkDetrSkh5VSTj+?=
 =?us-ascii?Q?qano0dVkX30ZChatn6EHnisHrKRUqIWGSauUAYhl8r7RLqqC3YL+BTvW57XA?=
 =?us-ascii?Q?opeVGmE6gteIQ78aICSe3vyqzNfqXtxU5e5uDszeR/JEdMz4rre1yVbx0Ll4?=
 =?us-ascii?Q?M90s/AKBu53dHen9G+FblEMYz4XW5J5uGSJdLgZne0NhXOmOW608qxtXgVeJ?=
 =?us-ascii?Q?f8L1+KgdDykSqeyYJKklPHtMjQMU8RIzGeWhRsHAErXfv8k0q6AW562BjndR?=
 =?us-ascii?Q?O1/jFy9MzoAWRknQfAfKj/39QHXWjUA7aOCRRCDVQ8GBxG4WfTDHgHJaNifA?=
 =?us-ascii?Q?7wcbZwm+HMMRd5FOCjvp8PNtoYBQqEoDfghAk4LB7utzxIyRKkpJN9GHipfP?=
 =?us-ascii?Q?0g1GHHSo54SM/HFmsPhI5JgRfhoL/Nu0KnSUqYWzO+mmxUiWRlO/pgqQYAjL?=
 =?us-ascii?Q?lbw4GgewEO2mF4fOpfazvlWUnN5RcSQHbM5Jot06edQd1mTFtrojD20Cooo4?=
 =?us-ascii?Q?V6VF+2+/BgErBtfZ6IRFPaY8m3/c1lK/t7KgyY9IFMi22+VI4Qudb9SH1PHU?=
 =?us-ascii?Q?WIiQ9BKaviOu60yfUv7QamUtAa2gNKe2BDsDdScLM37J9RzUfCrmMvS28b/f?=
 =?us-ascii?Q?pad7X0g5vwKkyi2jrhZdrpWBcOku9/nM+DLS8vseefIxSkOralSKkMRUBKz6?=
 =?us-ascii?Q?C3YYWAezo5zLn/EDymOjQjWYQniJ6dU0yl6QRR+lBcOmn2n0SUOFV5r9YsmB?=
 =?us-ascii?Q?lPnkYB42tGBSXq8XdIf/wUyurPJH0t10npv4YG0Er1KMVe5KNXiUReUoGVQS?=
 =?us-ascii?Q?tU7lCfUEul9kAXwKqh4+0fMH7k39Gb4dKrqahP2B8Rnaz3yo9/5Dr3j6AMfR?=
 =?us-ascii?Q?2oVcONK2nDWt4xgH5PIOhhnLZ6akhz6Yj9bTeF80l0Nwpo5p7KjzmLklWYF6?=
 =?us-ascii?Q?JDXTatsf7vrpEllvN2VGK8KvFqfuz6/n1u0+ls3F8rjOzIhj5QlDgqvQSWOl?=
 =?us-ascii?Q?4N7WZlp8ZU2tVoMKuVitkJ/aw+BcuSqpPOFMoImQyvgzI94e1vGQKFR0MinE?=
 =?us-ascii?Q?b9O+nr/J6vwxnwZdDvLr+UPY6BLw3PrJoF/N8GUBQxLBbEYYYpF32QTwTwUY?=
 =?us-ascii?Q?sAVdaHYzacku4bH7ZbUDiKbf/pPJqizG+dGCVU7DG5JsZWfUnRUSwClKMX5n?=
 =?us-ascii?Q?JuBma2YHM9HWFf/gJTP9AQWrStmRhsbAafPy7m7h2KVjRmLsZyrYWCAD3Ehf?=
 =?us-ascii?Q?llIBDY/6kQApfhqV+QSrrHq8/FykX0lBFYwjmv4565zV/qj9WaD8SuG0BhTO?=
 =?us-ascii?Q?CZ2+thkHodMiXGgIR9oqtbGOpaaZyD6r030mQY5R28o82mJzCyh1wkRCt/QR?=
 =?us-ascii?Q?vgolSG1u+QqlC7ky674gvgIQlWAq712QMAle2RMR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR08MB6951.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d5c26b3-b25e-4db5-423e-08ddc3007511
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 18:01:28.7463 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z26RfeojBwJa1vct35DSqqX2oizSfHVyJuy4gLoa0FUVzOHoOaOaLYYmfg4N8LswWIJtNR0+nP62swhzzEHc0CbvPuqjVRgLMXbXfo8W6r0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR08MB6347
X-Mailman-Approved-At: Mon, 14 Jul 2025 20:46:29 +0200
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

u-boot internals were being corrupted following an EFI callback to
get_rng(). One of the many footprints was a corruption of the EFI
protocols linked list.

A request for >16 bytes of random data is broken into smaller requests.
Those requests are fed in a loop to the CAAM RNG, which uses a job
queue ring for interaction.

However, the job queue descriptor is created only at probe time. That=20
descriptor may end up needing an endian swap (LS1046A) before being fed
to the CAAM RNG. This corrupts the descriptor for the next iteration,
since it will be blindly endian swapped yet again.

Two issues arise. The number of words to endian swap is taken from the
input descriptor itself. So on the second iteration, the length has been
corrupted. This results in a corruption past the end of the descriptor:
whatever is after in memory is endian swapped too. Second, some of the
entries in the descriptor are DMA addresses. If the descriptor is still
somehow considered valid after swapping, the data at the corrupted DMA
address is now trampled.

Linux properly initializes the descriptor for each iteration. This is
what is now done with this commit.

Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
---
 drivers/crypto/fsl/rng.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c
index 786a710f5fb..85544f931cb 100644
--- a/drivers/crypto/fsl/rng.c
+++ b/drivers/crypto/fsl/rng.c
@@ -23,11 +23,24 @@ struct caam_rng_priv {
        u8 data[CAAM_RNG_MAX_FIFO_STORE_SIZE] __aligned(ARCH_DMA_MINALIGN);
 };

+static int caam_init_desc(struct caam_rng_priv *priv)
+{
+       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);
+
+       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
+                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
+       flush_dcache_range((unsigned long)priv->desc,
+                          (unsigned long)priv->desc + size);
+
+       return 0;
+}
+
 static int caam_rng_read_one(struct caam_rng_priv *priv)
 {
        int size =3D ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE, ARCH_DMA_MINALIGN)=
;
        int ret;

+       caam_init_desc(priv);
        ret =3D run_descriptor_jr(priv->desc);
        if (ret < 0)
                return -EIO;
@@ -63,12 +76,8 @@ static int caam_rng_read(struct udevice *dev, void *data=
, size_t len)
 static int caam_rng_probe(struct udevice *dev)
 {
        struct caam_rng_priv *priv =3D dev_get_priv(dev);
-       ulong size =3D ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);

-       inline_cnstr_jobdesc_rng(priv->desc, priv->data,
-                                CAAM_RNG_MAX_FIFO_STORE_SIZE);
-       flush_dcache_range((unsigned long)priv->desc,
-                          (unsigned long)priv->desc + size);
+       caam_init_desc(priv);

        return 0;
 }
--
2.43.0


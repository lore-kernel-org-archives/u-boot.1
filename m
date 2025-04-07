Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4643EC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D312082E38;
	Mon,  7 Apr 2025 14:52:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="O+SjFEzd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABD9F82E40; Mon,  7 Apr 2025 14:52:00 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20727.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::727])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CAEC82CFD
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:51:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PNwcN2UdK92J/KUrhHxubQPfcwef2HHeahf0o9DVZDwJdeSjGZmSL0yC6SXpCrUxD3Y/pcFbD8iQid0BY7ivJJdAhXS4ew+E0R7wo9St83zzvZNHZMl5s6Rn2zuD0dNm0exvb4HktGfTAr3ftUp2En/ZD6PwlN3lC6ghw37rOKZCqLoCn9sK72VLzbHYMHoM2OBrHltg08wJhZsVaMoHxDsmbz4EULnwzUzAsRrYvK0iC3z+oausiiSngpQj43uqVj9Iwyat/vpTeqREGK4dxi2/6/iOfy9mByStXHT4Do6BGriRjlI8mgm/GaYB5F2SPqRY1fFUim4mJskwktrhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtYOq/oKp7ZlERRJB+N3pyM8ZHXnKWgF8zyw+GGzlGg=;
 b=FCg6e98pSIvjPFvkR+GSQMLPHe3aB/fxteUUW9aZX826TfVtSOX8v48xEpVxqLGqUoVeV4IGj9jwJsJG5shul07G7C6LuWyEREB6H//x0Qp0f4xyS6GltUdfd6/1YP00FDYTViPtwNmNPskDqAyi/VsVh1IBWvCpgyn2FZ9HDv7WNIkjgTWAned3uG0JpabyjmGKwK3lQI/Y4FmbJDOEGjXCSGyiJWNTU08xCybWDmi599ckIqflDcmrtg2NNNXITLAFMb/GXgZhNyfd0W7ml8Fr4f0c3VvdgcIqp05clx8V4yw4mMIGuWeUWmRe7eir0sPEAQwAR1Umv3v3bJUPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LtYOq/oKp7ZlERRJB+N3pyM8ZHXnKWgF8zyw+GGzlGg=;
 b=O+SjFEzdt3v1wrDjcHAs+CEi7FDEcnw1Vm0pD8pA2txOGmO7Xj9YDoq9I/c2Glz/LRoO7ZTEIfcedn5wdFP8gFmxSMxutHXvVT2Zw8oPeVq/Xijx8uZYtFwvKp9osnk0WjhWDpSE2Pj76Pfz2x/wsxdUoPyKRKj2ulzyboCDIqLgaVjXjUNUfFxvIbFtwH9Plp6GwehvQoBR//ms9oBCFFkvF+3ZosufI1rjr6wD0NPFkk1RckVTBt5bOjqPwPhL71kFcHfxgrDQJ55juYxPSocJBqaqd9OGl53hQd+Ay5gzTgPNQId5Ts+ix+QYG0rvuc/2ePHtSZl488SjRYfIaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by VI0P191MB2533.EURP191.PROD.OUTLOOK.COM (2603:10a6:800:237::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.34; Mon, 7 Apr
 2025 12:51:56 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8606.029; Mon, 7 Apr 2025
 12:51:56 +0000
From: Pawel Kochanowski <pkochanowski@sii.pl>
To: u-boot@lists.denx.de
Cc: Priyanka Jain <priyanka.jain@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 Gabriel Nesteruk <gnesteruk@sii.pl>,
 Pawel Kochanowski <pkochanowski@sii.pl>
Subject: [PATCH] crypto: fsl - Fix RNG generation for lengths greater than 16
 bytes
Date: Mon,  7 Apr 2025 14:47:14 +0200
Message-ID: <20250407124714.177059-1-pkochanowski@sii.pl>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0009.POLP291.PROD.OUTLOOK.COM (2603:10a6:1d0:1::9)
 To AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:1ea::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8P191MB1394:EE_|VI0P191MB2533:EE_
X-MS-Office365-Filtering-Correlation-Id: a54c41bb-e390-4349-31ba-08dd75d2fa93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?61RgSxymsA8oHkHyVc7f9p5vNkIO/L4tzRXZOIZJMYt7nJ9pXyOOSQvO+D8B?=
 =?us-ascii?Q?x9hlmBG2jXOBDDnD1SzeqgLfBxucx0/UPyUbVVcERTfPfxNORapwsn287MBt?=
 =?us-ascii?Q?gmlxhChwFoEHCf6LwEa79yBPV5KxGx6bBIrCj+2/R7S8LnTFIXcunlesJ8Hw?=
 =?us-ascii?Q?wQR7haaezICJmsMFoK52qFp2ql3sh7ud/YdAPGp3zefBEyU6ndu6VZuU3dn8?=
 =?us-ascii?Q?fQn1WpHiyO5nMkKI97YrJPFSVVhHVOG9zotU8lujkgM8v7pbwVJSqCh7IHmZ?=
 =?us-ascii?Q?oCrBg7iOudmT6z4s2rSBeIycxGSLQ88b5Y51AKh0oXcF0URjz2lzGZtXHAqF?=
 =?us-ascii?Q?nZdtj+Bt0L2ZGA8RVAHQ2GP6tF3tpSUrMSybGrxles/iOm6xoui0OI0YLhjH?=
 =?us-ascii?Q?Z3meaauSlfSkqZj/r/TE78eNVdSzxv4q/cjkk84pJyVzzm2NHuehONlhN/Vx?=
 =?us-ascii?Q?WkRYf3hjbyWTDPWZYYjP79tKa9zWv+88nBg0rMbz3e489GVVjtYxuYjGMCyE?=
 =?us-ascii?Q?VFk/1OpaPzv9nNX34dlwlwBhMiQL5yXYL2os3DZzrIJiNdpOQT9ZebjxvDCr?=
 =?us-ascii?Q?H6+1Nx+hKVWSLAK+ZqEAtWYRo1QBvA7DdwBCND0Gxsgo4ehqofXqXFPQWpgD?=
 =?us-ascii?Q?O8VVjdaVEvZtk1cwICHtS3cz8qB83DnQhYR2m43amNdJWll5e1vrIoGQgsa/?=
 =?us-ascii?Q?P5kacBA6aLdj+5wRcyqDQ60F2nQiEQnps0+J1izIlKrDm8RlxH2u/kOt6I71?=
 =?us-ascii?Q?/oFPYnYW6qHwPg8rj+FMrpwg07EyGWuUXPPBi4nlM0LThxMKq6T1BP34UEGl?=
 =?us-ascii?Q?nhzDYyJ/nw75s/BdQnfriyDPNBpEBg0Tuom4YcKjXpVTkOt2R3GlpRhnI8Gx?=
 =?us-ascii?Q?Tvr4razfz5ymLDPwW7L3lMRX2e6fqCfwH17WS7h0bFGnZStUdoNhD76ApLbp?=
 =?us-ascii?Q?plpizbL6W36xNaduT9B2mPiy5uNQqo/5yG2gX97RozesJOiZnUGLYskCwc+t?=
 =?us-ascii?Q?ZGKQCfu7aBvZnISwy+7lrM5Ytl28YY87UZm3vj2LerKneCwPnmmpcHmt3oyY?=
 =?us-ascii?Q?BjRfiQrPC6LSPPrhfW0kzE7nfVtIUdjC1w65rw2nk7RfcmqJBKiZIpj7fhZj?=
 =?us-ascii?Q?qNBX2c6IaW3wn03boTDfaWZ3giTEIehg6xSddmuJJSMRKwqOYXjm9nK9KnAb?=
 =?us-ascii?Q?/ySKDTOBXYfP0p+Os5PdvoOUoeZkWRIbrhiV2r4rsDXXz041rUW7iIaH+oSm?=
 =?us-ascii?Q?Bup/GdxFQFRXiz9fJcmjdKH/xJ/49i5gOa28AQyO7+7jbVWZQUnuCkf8aTuZ?=
 =?us-ascii?Q?vbHVYqjXivYTdEv+DiopEzNmxcBfRwk6Iso0CZvc14z2MMnVVNRecghFuLzL?=
 =?us-ascii?Q?ZLiF3n/L3Dd4rfxMlD2J2D6a0vARD2NwnLwkQft+n7pIHRVggtfaJEPnAlFI?=
 =?us-ascii?Q?fHXAiCxDlibHOb0nxoIikguYM94OHT7w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t/XV7FnFlf8LcS1Xw6GSk73cOWAWzoGqeCnnAnerm5l0GZWI+2AAS1WG7/ck?=
 =?us-ascii?Q?OsXHTRK72aXFtWk8V+vJqM1rRtHjLB5UR8zlmLs5OwfLSSK870huOcqtN9yE?=
 =?us-ascii?Q?BDpD0LxpgKlSNx4l3VCLiIp1kB4i+Qei5W/PfzfkObU0LVO4+qmEwG8E7hJE?=
 =?us-ascii?Q?sk267dSRXssNl1PMYDSwgi4Imzq8NgiImkNEshsVMVQbOmVGE8Pz0G2NbQ9t?=
 =?us-ascii?Q?nWSvfAmtmm4wO20d+mzEAToksaRBE/cYWkRldCpnYBvhA5WzQhAoWVT//mKy?=
 =?us-ascii?Q?qYWPeZ2T2rCBgV3gu5Yjdzb/QWQnE2MdSBmphUF7oHvagIWjy+g/2XJuVGIn?=
 =?us-ascii?Q?wEJv3F1AmEn3MMp6EriQS+t8DRsHkcMtDyFz+fafmeGl1J+asRdUpzV3eoDa?=
 =?us-ascii?Q?rfTekwgeROQ5KZmLX8qcvzAlSjYvMW7CF6ilqUeg7fm6hxKzOVQhr4mT1ONB?=
 =?us-ascii?Q?95cwdJuyDdQUVzfSkPXJ6Ph2Jl34bP+GEyQ5BSJO3bcAEUmTJ7Dqu8tuDzkI?=
 =?us-ascii?Q?gcCWirOgj0GYH3a5VonnLu6Jtnga31zhBnFTBy1J4vpgzrluf2y6rkyu/WvK?=
 =?us-ascii?Q?nsiubSmXhV53JHyRBFC2Umc+gEjxeSxqHp9De6LMZC3bWOM92i2N/IpdU/aw?=
 =?us-ascii?Q?aMqYXHQxN6fLFgb8PInfw+LM4mqBV0aGz+w3cIGWopUj0CE3P/+i+0s6W8LL?=
 =?us-ascii?Q?/swK5SzC9GFUWdVKFqBQJRjrZy0AZ19//CcxwVwj0FKuUHcikpO8bIzhQX8b?=
 =?us-ascii?Q?mmLRJn5hnkdesAg+I4v8Uu+M8RFYSwY6CUMcXy5G1Z2Ls+1z6RKSGRKYCCuF?=
 =?us-ascii?Q?/A5Tu1/UZ4po2WH7ufHgdqtTXaFVDa8FWEG2DVKNcKDL+gD5IIgqQgLv7GyD?=
 =?us-ascii?Q?ZF/m57dOTPatK3ZjGCmp4aFzl/ds1cWzWwGlBmZx5So5s/6qJ1/doAlcjP5v?=
 =?us-ascii?Q?cuEagWx1I+iIeIfQpq3W9sPTAGtngAjMpGtLKIfj0FeYVSPKDvbJu1vP6RFi?=
 =?us-ascii?Q?L9OkM7JKryQQogZXueECPop74/6HcDlqkA/wqrRaM28lVXNRpgeUzgYScn/V?=
 =?us-ascii?Q?Kvb496t9daHVUXsEd00CKWSB9+9zh+hYDVc00MHLc7v/EZOdMu116DD86vO9?=
 =?us-ascii?Q?LMjPBQ2RNl2ELVtdtthnvH591eVfv+oht6I56D/Icf/48nTmCmRXikqAhtUL?=
 =?us-ascii?Q?0STqb8Yq0xMRT2Ji1dzFg1o2kEaujHcMaDYMnGDn40tgEWlF3hTewb82Xee+?=
 =?us-ascii?Q?JEpFjwy0S+5jWJJg68Gds92HnPbtEdIdMyH4UA/NN6kJfPfmJ4GeVOyxcx5w?=
 =?us-ascii?Q?NEKbaI9HVxeO2KpdFoKhF4RBFDgmSHGC3D52u3mCPR5DALeSezqnXmMwdi6r?=
 =?us-ascii?Q?noHUYpJauoJMVT5E9GmDARRDlGgH9Kb5a0qXlnhcdtGogM2jqPNjM8L6ktLA?=
 =?us-ascii?Q?GeWuuMbjuiNrNWsVt1TLu+qNowBO6wATdTcEQWL7zV5WMO+rAVwmYD9UdwZN?=
 =?us-ascii?Q?pxyJz99MvAcah9uZHffdB3sK9lL3OzdqY9GGpaEi3MM69ZQgV6hI6Xdq3rjH?=
 =?us-ascii?Q?rPHnIaqgZS1D3Y45eq+ke+L0fi+ugG8EXuTAWZ9i?=
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-Network-Message-Id: a54c41bb-e390-4349-31ba-08dd75d2fa93
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 12:51:56.5295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JUWDwYjaFTUn5en0NLevp8ABnpGrk0uoVCtVId89qYqauI/MubfD9DYbjlgFb4H0/OY1QU3Nr6KiuU63dcQ8bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P191MB2533
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

From: Gabriel Nesteruk <gnesteruk@sii.pl>

Reinitialize the descriptor for each RNG job, as it
may be modified by run_descriptor_jr().
Failing to do so can result in memory corruption when
dm_rng_read() is called a second time on NXP devices
with CONFIG_SYS_FSL_SEC_BE enabled.

Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
---
 drivers/crypto/fsl/rng.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/fsl/rng.c b/drivers/crypto/fsl/rng.c
index 06364948052..440b26e3c94 100644
--- a/drivers/crypto/fsl/rng.c
+++ b/drivers/crypto/fsl/rng.c
@@ -27,8 +27,14 @@ struct caam_rng_priv {
 static int caam_rng_read_one(struct caam_rng_priv *priv)
 {
 	int size = ALIGN(CAAM_RNG_MAX_FIFO_STORE_SIZE, ARCH_DMA_MINALIGN);
+	ulong rng_desc_size = ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);
 	int ret;
 
+	inline_cnstr_jobdesc_rng(priv->desc, priv->data,
+		CAAM_RNG_MAX_FIFO_STORE_SIZE);
+	flush_dcache_range((unsigned long)priv->desc,
+	  (unsigned long)priv->desc + rng_desc_size);
+
 	ret = run_descriptor_jr(priv->desc);
 	if (ret < 0)
 		return -EIO;
@@ -63,14 +69,6 @@ static int caam_rng_read(struct udevice *dev, void *data, size_t len)
 
 static int caam_rng_probe(struct udevice *dev)
 {
-	struct caam_rng_priv *priv = dev_get_priv(dev);
-	ulong size = ALIGN(CAAM_RNG_DESC_LEN, ARCH_DMA_MINALIGN);
-
-	inline_cnstr_jobdesc_rng(priv->desc, priv->data,
-				 CAAM_RNG_MAX_FIFO_STORE_SIZE);
-	flush_dcache_range((unsigned long)priv->desc,
-			   (unsigned long)priv->desc + size);
-
 	return 0;
 }
 
-- 
2.43.0


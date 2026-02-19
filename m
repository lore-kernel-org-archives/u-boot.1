Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962B6E9A049
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 13:26:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF24983DBF;
	Thu, 19 Feb 2026 14:26:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="gaT1QSV+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B04183E1E; Thu, 19 Feb 2026 14:26:16 +0100 (CET)
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25A7B83D2E
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 14:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQTQx99A/0wC8K0j13GGdZZlBeqWS5PJQxRQRGX1e4PowMeJtE3G4WqHLXQTRXL5GHQbgCN/4yaCsK4qWpkvIVpXdDiFnLtUSXZDugwlonCYZfwn8dT8bm3YwR77YCciC20spOr2ioNSAGBK0W/MBtw+Yzpe234DWWcE/enPu3JnTbkKSmX40MEBjiedc6IkKbkx15+NvK/BxZmyeY3djwzZGh+ExKnLooveYdVVHwNsoIGicmCK+52a7wsRjOjsJgdeECGM44HlOcObDODddShmmRt78f3nhabvekA6q0flhbCFFC8e1eRp7qHvIw1MGxlAU522/UnZFpxgHKvMHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmihIIHrfPwyuB0NdCHqpLza2NN9lP5ba29XYZnFMHM=;
 b=ddG5I8+QxeO6wcRczi710v14y7mOtQ9h0pQRUp73AyomyJnuuXgh37crB9S73Gv8ijUUmA5mxT995CbVzNUtFBvBfR27xqbMvlRmSjSQ58TvOcPlQEtYQTCx073Zt2blDuPw33ZuyN5xYUeQm+cttt8XVfcdOGasrMzNGfW7HUXXHNYOwLlTfh1v9cQr5Nlnw1IdVGejI0Z/5m9qwsQ8jAm84sTAAvuQnj/sIOSuvZa2e6Dj0cS03kSUT0GoHYDdbEDS18zaYcqtHJTcuwSIby7PgZ5x9pW2u5BkyH8bmNVjiTlosTi+WVuxVjyXlYVcS4Oy6STl1YJltVnX+FUsFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=gmail.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmihIIHrfPwyuB0NdCHqpLza2NN9lP5ba29XYZnFMHM=;
 b=gaT1QSV+XrtLW6CfSH+OXJGSAL/KqrMHqK3TOo+rvvGtOLN+0Pxf5OUFJK/xN6Q7Arj9cSY2DqlWUhA0X8B/VCErV9q4CCsl9sXbemdAEcLW8s4eQ0TfP9rK6JOjp1x3NH2ykqEwYs5+IAw81B/S1hBqqt83MwSWZW2KQ3aDEIjVGXRhXqtRb0XF9Bhr2Gn1dzB7al/gzjXjAqHfEru1Xp3eiejnEqOr/azKS1vGGLB8SiRcIUasfGitaT/J4p+16YQHKA8kap97cxuzoR6AkuJZFpPLfyVp2yELe5sci0YrnSZnJqJFMd2dZX4r2T5CYmZIb9D7WduJLDgiqEIgBg==
Received: from MR1P264CA0196.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:57::14)
 by PR0P264MB1931.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Thu, 19 Feb
 2026 13:26:10 +0000
Received: from MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57:cafe::fb) by MR1P264CA0196.outlook.office365.com
 (2603:10a6:501:57::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Thu,
 19 Feb 2026 13:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D58.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.12
 via Frontend Transport; Thu, 19 Feb 2026 13:26:10 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id EF095202D7;
 Thu, 19 Feb 2026 14:26:09 +0100 (CET)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Philippe Reynes <philippe.reynes@softathome.com>
Subject: [RFC PATCH v2 5/9] ecdsa: fix support of secp521r1
Date: Thu, 19 Feb 2026 14:25:48 +0100
Message-ID: <20260219132552.1499698-6-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219132552.1499698-1-philippe.reynes@softathome.com>
References: <20260219132552.1499698-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D58:EE_|PR0P264MB1931:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eb07201e-30b1-468b-352b-08de6fba7240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cjncWkMSwEnCZtUrxW/vBz+WllYlbJSatAQ+QoJmn/gcF9RzfE2H2nAziDzz?=
 =?us-ascii?Q?JPYufwNqL43GDHB5E7q6739r4kcftwq4u4jHDnzGqJfxOqe4AJaxgH2MM6gg?=
 =?us-ascii?Q?+T4qWZZujDITYTYDuip0164rXT+0ULsVBhaZ1MuNxXjQRHj2vWH9XehiBnnr?=
 =?us-ascii?Q?zQlMYA06bxILp+QSHNCN08pJLa/IWeUpYSAvBTZ8rou9YCSsRB0zoCLD8lSn?=
 =?us-ascii?Q?afkSDqNHIPj2ibRMb3vhcFDUCIDd40xR77tm7LbuvCtbiimkIEtHXiNjUWN6?=
 =?us-ascii?Q?MQegScuvnRpxrhVJsoZwyO6Azh0BofHFyDd78e+908dE2IPamdgOsap6rc7p?=
 =?us-ascii?Q?b/JjOG1ktS4vOYjRcLdcun4At7hdi5ySQ64B+whg77udlW55uLcdchAm412O?=
 =?us-ascii?Q?/ETeRNF3QSBjKEr/YPTRB3J8ZZ1pX+0JC1snhgcK5wJrvyuU5rkq1EJqt3qA?=
 =?us-ascii?Q?cVz8AuOtV3c8HMnpPa29KX2DFfcqta2kFQGHk2ob3jy162aE1ewqNxd+U1D9?=
 =?us-ascii?Q?Fu4QIQbkpKqPBmk7sY8gwKgM75h6+zQf3BZiJzE0l7sL/aIVDTt15lRfClfL?=
 =?us-ascii?Q?xxTGzsmkrXS18KeM3jqp0hJ90GNv9n//G7NYxwM1TV1YJbQX4QTSe2fmcUGv?=
 =?us-ascii?Q?W3QCy6YuFw8IwX03ggM9npMM/lcZsxnLxbEE/WcgLt538WV0duOHWPrJ0d2a?=
 =?us-ascii?Q?3ziYvibi++TARf1aJvFUebo7xkP86DpQ2taE6J1Tb3z4FwhWLpmx+0AaY+Q6?=
 =?us-ascii?Q?P5evN8cGSTot4glNjCbv/2ott9G8PtO6ytd65qcPaZ0lsMWs4UCHaI8C0NKc?=
 =?us-ascii?Q?LjijzUqxRWgGXnQ1B8rKHms6Q/7N9byS5Nxd2vJ2UzEoWZtP4FXF9bAj2f3/?=
 =?us-ascii?Q?worRCCFX8ZLdX68Rs71HsneiuyVpoyfNoinuhzTz4ZEQ137dApyRHAft62PD?=
 =?us-ascii?Q?zAnMpETtwy7oFEgM/nRMcR7SRf8czH1RSatN0Cbh3qGSsp6TpaZeAd7eJBWh?=
 =?us-ascii?Q?y2Ho1cnuscUxzElIG8LWZ39pyCz+zK8gWfQOWNwjQc9syTfsoGF+rGOaQZqe?=
 =?us-ascii?Q?nPVzrvEHYC76K8X3GABZg9R7dQUG3NCg52OXmF2nqnwoiyw1cqIYHnvgPJzJ?=
 =?us-ascii?Q?ofn3Hp+uyFSWncSCnkQ3vr8aLBMclAsjVYMxm2psENWMq7zc+rLmEmtR2+37?=
 =?us-ascii?Q?jN4yAlBQZQo6reQcCHJ0EYnpADmjZLY6ka4fe+/kX39Jkb76f5Vm7bN7u+Xe?=
 =?us-ascii?Q?fSuEQKB058RgVqerpCgluG5r1ad2J3zVRy5t+6SjXJE7Cg8u9zkFM0ap2z1f?=
 =?us-ascii?Q?eqQDaVRQYYDzjBXMOqAD3ILc00LrhzDWC+ou2z7BZ+K61SIe5xtgT8KP0FmS?=
 =?us-ascii?Q?1Bwo9wO9CYCdorgYMpYlHk8p/sPRjn7SKl+FQoAnVsc1fYZkL4im8rH9iRhD?=
 =?us-ascii?Q?tRKDtyN/psEp7+bcbn3BClsakyb2fahsYXx3QvnUmgJkOd64g+tHOFyWvpoQ?=
 =?us-ascii?Q?ylIbEZrUyTAtQPN86CIrvsT7fMkolPGRygC0mcGI/TSN6yWhzkT3ipAAPwrr?=
 =?us-ascii?Q?E4+WTTtzum1xxmSRrdghlVjizDDYKKY0a+tUrXha2i1/Lq5urUn0Br/8eg2J?=
 =?us-ascii?Q?hgMzRtXKz/LbI3hLV3LJJ5jeUHMomDJs9JxT0n7q9aYJTmHoeAq2cu0ZgwEc?=
 =?us-ascii?Q?CqJ0FA=3D=3D?=
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AMbPFN2Ha9ejQb1g66fDM3t4MgAi1Yf1Q7ROUfy1T5KUSr8jmhr52+27uqfU9q8P3OrfgXsKSsL2sIseqPuaCdqdlna+5erchxFLSJuoFhQqo83bdwAeyOiivDD5XS/na3gP4qcAOFSlcto0sbVhl1cY3iVYjB+uhxQ6P7HPpaj8y+2DQLNcSFSIErQNlPPnpWpxkBp0EEyMoUi7noOI6a7XgTPRN2EvDxEgIomS6enrPlaxgMPqn1X5If6f1gYebm7hmMl3w9S+sQDp9evSrndNQVldC8KpEPkBnf/q9g0wgaQkIBCc4Q8TCG2PqpbzAjbQ1EnBxKbwt4I2rq0Ld8ipMWSyjhk4c84K3V58SYEi0flL6soVuE7wdmXgF/tSf5xmDNrC9KuZrIMYfznWuVfORCH7uNwoZAcqvOCAIPmtbg3wsy7rFljo1uHTRauS
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 13:26:10.3948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb07201e-30b1-468b-352b-08de6fba7240
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D58.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1931
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

Current implementation of ecdsa only supports key len aligned on
8 bits. But the curve secp521r1 use a key of 521 bits which is not
aligned on 8 bits. In this commit, we update the key management
for ecdsa to support key of any lenght.

Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- intitial version

 lib/ecdsa/ecdsa-libcrypto.c | 21 +++++++++++++++++++--
 lib/ecdsa/ecdsa-verify.c    | 24 ++++++++++++++++++++++--
 lib/fdt-libcrypto.c         |  2 +-
 tools/image-sig-host.c      |  2 +-
 4 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/lib/ecdsa/ecdsa-libcrypto.c b/lib/ecdsa/ecdsa-libcrypto.c
index c4bfb2cec61..6f25ccc783d 100644
--- a/lib/ecdsa/ecdsa-libcrypto.c
+++ b/lib/ecdsa/ecdsa-libcrypto.c
@@ -45,6 +45,7 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
 	int x_len;
 	int y_len;
+	int expected_len;
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name)
@@ -54,6 +55,8 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 		key->size_bits = 256;
 	else if (!strcmp(key->curve_name, "secp384r1"))
 		key->size_bits = 384;
+	else if (!strcmp(key->curve_name, "secp521r1"))
+		key->size_bits = 521;
 	else
 		return -EINVAL;
 
@@ -63,7 +66,19 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != key->size_bits / 8 || y_len != key->size_bits / 8)
+	/*
+	 * the public key is stored as an array of u32, so if the key size if
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = (key->size_bits + 7) / 8;
+	if (x_len > expected_len)
+		key->x += x_len - expected_len;
+	if (y_len > expected_len)
+		key->y += y_len - expected_len;
+
+	if (x_len < expected_len || y_len < expected_len)
 		return -EINVAL;
 
 	return 0;
@@ -89,6 +104,8 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		nid = NID_X9_62_prime256v1;
 	} else if (!strcmp(pubkey.curve_name, "secp384r1")) {
 		nid = NID_secp384r1;
+	} else if (!strcmp(pubkey.curve_name, "secp521r1")) {
+		nid = NID_secp521r1;
 	} else {
 		fprintf(stderr, "Unsupported curve name: '%s'\n", pubkey.curve_name);
 		return -EINVAL;
@@ -111,7 +128,7 @@ static int read_key_from_fdt(struct signer *ctx, const void *fdt, int node)
 		return -ENOMEM;
 	}
 
-	len = pubkey.size_bits / 8;
+	len = (pubkey.size_bits + 7) / 8;
 
 	uint8_t buf[1 + len * 2];
 
diff --git a/lib/ecdsa/ecdsa-verify.c b/lib/ecdsa/ecdsa-verify.c
index 629b662cf6c..d87d95a5002 100644
--- a/lib/ecdsa/ecdsa-verify.c
+++ b/lib/ecdsa/ecdsa-verify.c
@@ -24,13 +24,15 @@ static int ecdsa_key_size(const char *curve_name)
 		return 256;
 	else if (!strcmp(curve_name, "secp384r1"))
 		return 384;
+	else if (!strcmp(curve_name, "secp521r1"))
+		return 521;
 
 	return 0;
 }
 
 static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 {
-	int x_len, y_len;
+	int expected_len, x_len, y_len;
 
 	key->curve_name = fdt_getprop(fdt, node, "ecdsa,curve", NULL);
 	if (!key->curve_name) {
@@ -50,7 +52,19 @@ static int fdt_get_key(struct ecdsa_public_key *key, const void *fdt, int node)
 	if (!key->x || !key->y)
 		return -EINVAL;
 
-	if (x_len != (key->size_bits / 8) || y_len != (key->size_bits / 8)) {
+	/*
+	 * the public key is stored as an array of u32, so if the key size if
+	 * not a multiple of 32 (for example 521), we may have extra bytes.
+	 * To avoid any issue later, we shift the x and y pointer to the first
+	 * useful byte.
+	 */
+	expected_len = (key->size_bits + 7) / 8;
+	if (x_len > expected_len)
+		key->x += x_len - expected_len;
+	if (y_len > expected_len)
+		key->y += y_len - expected_len;
+
+	if (x_len < expected_len || y_len < expected_len) {
 		printf("%s: node=%d, curve@%p x@%p+%i y@%p+%i\n", __func__,
 		       node, key->curve_name, key->x, x_len, key->y, y_len);
 		return -EINVAL;
@@ -135,6 +149,12 @@ U_BOOT_CRYPTO_ALGO(ecdsa384) = {
 	.verify = ecdsa_verify,
 };
 
+U_BOOT_CRYPTO_ALGO(ecdsa521) = {
+	.name = "ecdsa521",
+	.key_len = ECDSA521_BYTES,
+	.verify = ecdsa_verify,
+};
+
 /*
  * uclass definition for ECDSA API
  *
diff --git a/lib/fdt-libcrypto.c b/lib/fdt-libcrypto.c
index ecb0344c8f6..090246b44e9 100644
--- a/lib/fdt-libcrypto.c
+++ b/lib/fdt-libcrypto.c
@@ -10,7 +10,7 @@
 int fdt_add_bignum(void *blob, int noffset, const char *prop_name,
 		   BIGNUM *num, int num_bits)
 {
-	int nwords = num_bits / 32;
+	int nwords = (num_bits + 31) / 32;
 	int size;
 	uint32_t *buf, *ptr;
 	BIGNUM *tmp, *big2, *big32, *big2_32;
diff --git a/tools/image-sig-host.c b/tools/image-sig-host.c
index 5285263c616..a2272b196e7 100644
--- a/tools/image-sig-host.c
+++ b/tools/image-sig-host.c
@@ -84,7 +84,7 @@ struct crypto_algo crypto_algos[] = {
 		.verify = ecdsa_verify,
 	},
 	{
-		.name = "secp521r1",
+		.name = "ecdsa521",
 		.key_len = ECDSA521_BYTES,
 		.sign = ecdsa_sign,
 		.add_verify_data = ecdsa_add_verify_data,
-- 
2.43.0


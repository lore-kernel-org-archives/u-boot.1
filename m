Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69417D609A5
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:09:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B467483A7A;
	Tue, 16 Dec 2025 16:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=mt.com header.i=@mt.com header.b="uTnZw3UI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C8A83923; Tue, 16 Dec 2025 16:09:06 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D013E836AC
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:09:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mt.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Wojciech.Dubowik@mt.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahKfbe9FoiFj4hsRr9VMK2Wg3cZRyFiRkpRgqf29BGzoNzraUN1a87tfDFaeEjwdmJxOOjMyZUjYxXaii4VbwQbFhQiheuxxkmAnNEYjL5qwonFFNbHz8C5euQVZFAkEIHa7xZ4P07fjN/mL5a9qtTiH+COqtFJ6BMMXaNdqd42UeEmArqiIhoGV9Er91y+hftGpwygMKeocR3DFys79PzJirQS99Fv1d+DimXMRbjsHnfMq46wBYMyGmda/Vb5vBDLaLhZ5W7WJZ/O96nJLPLQBXDBQ7kAz0q0X6W/PP56zwqk3hungcJmJHoCzMRVg3Ntlny72GXUKxlOKA0hmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZyyHVQVnCVXKXTPfWXknGZYLGsb3WlBNGmTmyYF6Bs=;
 b=Z2Zz0VVdw/P/55NZJ5MQZzBPk0t6wPtDsZCbFyjV/b/oYXQ3Bs0BsWPZF3QYfv+OQCNozTPDjkuKo9RnblAyXue3FfkvQuFJQCCHbOCfKg4nv5pU7ppSf13l1mnl0aC/1a6CVmQpu8kemkUVF8Hs+UaDyfrxm+GAAqW0CeTxuq9tLusT5taC9WdwukkHTL6lmKY2ZxyDzs0Q84Er+uEEpf1IUBclqDe/eUoK+muwILPvkMdVghtPP9/IsYId3y0BLsR/b81cmLvoHlVlLsn5V6pqTskkgxRtRAE3Gp7Yx3jz5slcMcuYL8B+c0HCSnupRr6Rw4AAE3pJNrLC5AgNHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mt.com; dmarc=pass action=none header.from=mt.com; dkim=pass
 header.d=mt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZyyHVQVnCVXKXTPfWXknGZYLGsb3WlBNGmTmyYF6Bs=;
 b=uTnZw3UI2UpQeXMAcZGmf5tLcgpPouSSGqdnznyq5rBatiah9397Dej9fTQJ5JdMVkgTaskMc9Ll9uLEcd0UVYnBa1K+3rRL2PyjIiGFZmyIoQs1p1Km4EbV7hSUHoi1RrwI48a/Qmr8IrRuwLT9SGVs1WTSATssrwHSzbq4hra3pOa4SSp0jQ4waAnoqh0RYM4cyt8Xv/8vgAt6XlLnmlniDJPKENaPi6bzCQbL3os/XdXV5j5I/ggGhE09PxQOijLHCMH0ZOdY3LJnYZKr2FQgEga2QoevsKJG3Ni7SJY3FUeCWlW0hHqzQwnWHwUFXqd4yyKfjpwH5y4PmN51Ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mt.com;
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com (2603:10a6:10:22d::13)
 by AS8PR03MB7414.eurprd03.prod.outlook.com (2603:10a6:20b:2ed::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 15:09:00 +0000
Received: from DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466]) by DB9PR03MB7180.eurprd03.prod.outlook.com
 ([fe80::2e7d:3185:676e:2466%2]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 15:09:00 +0000
From: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
	trini@konsulko.com
Subject: [PATCH 1/2] tools: mkeficapsule: Add support for pkcs11
Date: Tue, 16 Dec 2025 16:08:28 +0100
Message-ID: <20251216150841.331408-2-Wojciech.Dubowik@mt.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
References: <20251216150841.331408-1-Wojciech.Dubowik@mt.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0146.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::7) To DB9PR03MB7180.eurprd03.prod.outlook.com
 (2603:10a6:10:22d::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR03MB7180:EE_|AS8PR03MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 317b32e6-b74e-4726-f7a5-08de3cb50a4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k1cAqTRwBGX8LaftEg9aA8NkVRuxylVE8C3weaDTYhGuJW3WJ+czeaaHYeOj?=
 =?us-ascii?Q?mnYbR3iOrVUvfuc2TaB1hrAzDgVHhUGTmRauL59gqtwux6O1AAdIp1v8SKcA?=
 =?us-ascii?Q?FMvg1Dz2HbI9j9LuQWq+kDkpKwEBupfZ4CwbIJlUh0Eyu/Rx2yLP/fqyyPXV?=
 =?us-ascii?Q?TD/HvYCCT1gX6lRs5k0pbRaheqQ20ilqLgfLrhFo7sJenpIVHv6aV5tNgwWY?=
 =?us-ascii?Q?RphANqav5JGPTc5W2GWzahD1geRavoQfBk6Xk93g0FLYME+ju5KadL5TLIjK?=
 =?us-ascii?Q?63poGYWdBU93MQF2nfiDBZyTP0/UBAapf5O9TPaYukROchGzrQngAuDvUJfB?=
 =?us-ascii?Q?lXDdpNTp66tE3FsHt83W07nhp59cQX/9aYzQ2+PAM1SsvEZSI5jkMEAOznvt?=
 =?us-ascii?Q?Q2gReOozUaQ85UifYhqW/0o4K2y4nesSWnTPjdCapWdCqkIhqcPG+d7S8KWE?=
 =?us-ascii?Q?bLVtwqSIlKrrWndhaTPwvKpa4oYpOTSINtlM9385Cwnetai/dWxbwqFWDv2V?=
 =?us-ascii?Q?5vskKLj0K8wU/NGJ7M6LA/ZSneuGdZ28y7fkH2FILMPn+NBe27OfyD1UZfvH?=
 =?us-ascii?Q?zFUwIlzi2P6el++e8C33w/gkFqVDoFuHalZVK4XGdZ4l1UEntCnABIPjY0ZB?=
 =?us-ascii?Q?oOuF/Bq/OKKpeL50wvhPnU/dyabDAOvo6gtq6JTOrEiF++3Vj8JNuUgdy69Z?=
 =?us-ascii?Q?MOiGfpMq/rfOfJUP3xdAKKRbFjL15f+omTkmlfAwlPlgoHGLqfHmgDtn6uZx?=
 =?us-ascii?Q?8WqyNue7mA3OVfFtDdzTfwBGx1dVVnu8gemYFfq6grhymHByMC1lcN/N6xT5?=
 =?us-ascii?Q?CX30/qATBMqWDYSSQtCVGsW7tvVvmREqwXqKAzQDPfX6bxrOlXKzpbOh2roX?=
 =?us-ascii?Q?0f8AMvyyqzrB0OJjANm6QTTDKa71bdpt+xlnF0X55i4WpklUd28MpJrxkf3d?=
 =?us-ascii?Q?8cXcXn2EThlPqeEcFCwZVmCewkI0yX/5Xpo6Ajkz4JqHLu9qPG4G1k+X4/Gh?=
 =?us-ascii?Q?QkZVF5G8d2pc+sBPP4MTncAstwIO4COKQ4LDIpJdNAMs1qfG6AGLAwcuZbEd?=
 =?us-ascii?Q?f8m/UhSUmeZBOMwXo1qHkRmvlAjtmRCCTGxQC14iVr9UPyAjufbXAQ4gpsYm?=
 =?us-ascii?Q?TqOpYmmI6AkCPXdzfFrYEoswtN2jA74Vn9Pe55GAYZ7IjUCq6b5Ux9I6d2TG?=
 =?us-ascii?Q?wf9n3Fe35xfSrg89n6XIb7wtmm//Lj3RBrNdsMEMXrjoJpxm4Bw0nszz3+L5?=
 =?us-ascii?Q?c/lZos9GAD7u4aS2VoVFPh3Jt/pZmXeGxkOK/NdwZkzq+PHfr9FsAcsn4Nn+?=
 =?us-ascii?Q?llLO8crw5KDz6eTg6JNSGLtdSIWFxfTOdo+PC0wuZTCjE1WiKgAHqSVbO2md?=
 =?us-ascii?Q?IzGI6/BDkZRziQ4/i40hP8R4L4BelFeh7ZRVp2b2jGuZ3krc9QOn0kbdnvyq?=
 =?us-ascii?Q?qrv1piPmuaqcqHT6BI5WBBmP4isP2lmXdOR4W0wX0EN65dsKe9zStlyrOHjO?=
 =?us-ascii?Q?YszzhZ3mJJ+7eKW0c6mX11gVs/Iwqj18Ruqd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR03MB7180.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(52116014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upO7pIhh4/99H9gabtvrGFflrPZ9ibqtlcxigCO55EvwuAJhv1SEzpkToaGP?=
 =?us-ascii?Q?dykW6/vBc/JoAwtJWZBGF6rrFwiybq3iN8L513hk2xWX5gjhgh+FuRVBLYMt?=
 =?us-ascii?Q?sr7X0tepSRdxyJ/dKlyauC0MIA3X4Wv5eb4c6HH5MvNeJw6cqycPL2SUX8kJ?=
 =?us-ascii?Q?PhGSh2bjGkFredkqLJoJGl3fferiDW4mUExuMdCDD23QRXncerB3Rbl3TD5N?=
 =?us-ascii?Q?ivlVIXARTBjfzyE8esemTwkf0tkzu2GpcTJoZla+L1RqSPYVyqHQ4r7MuLwg?=
 =?us-ascii?Q?yeQeixdwzkavfcwsJSMxU5OSXHEWr9SXwcqIAWvxajf2oYgncU9/X99VOyng?=
 =?us-ascii?Q?S+kf92knSY03s5r2K2/CEGI84h7kaJMnBN+E05EUyDuv0VGoyd3VZMWz4JKE?=
 =?us-ascii?Q?AuarTZK06MILsTPlRGCyNvmA9g6TEwy/3tfH4ztn3Hujs9al2ieVMm7SMW7U?=
 =?us-ascii?Q?7vvYXdbGV/rP5C42ULPWAU2r50z6D+3QjzFt9+Z66IoMWzLqFIdo900krXcc?=
 =?us-ascii?Q?DIGPqWHtFdhbvB8Z0IAb+b74IPSBfUfFYWGeCCZQxYB+Gxoxye6JnWptdM7N?=
 =?us-ascii?Q?lasmjsZf8uWKHtUyymCemT2yWvdYWPol7t1JD4yjHIwjXhPx4ZMFKQPFrGf/?=
 =?us-ascii?Q?wH1AZAEnLe/lE2U5Wds2+0dExVSGLStO9htVzxh6Qj1+QnUIehYGhpGwkxsU?=
 =?us-ascii?Q?jWX13J7MR3U9he972omPGONc3/fe7JP4q8IDZJQGNXGPN57ZsLTbrLQTmECG?=
 =?us-ascii?Q?V41JmJtbhSt1DoUNe3MaJDWV7SNkbxcrvUj5OMEWN73w+t8G9RUvcHK/VdBC?=
 =?us-ascii?Q?ZISMULFe88tz+6NWiE5Iq/9Xi1AH3RLLD1VEstJcR0U1eRVIGk/AzIJnmyrR?=
 =?us-ascii?Q?wFXuEpm8YZ0k8QHdpYgWlM9jbmZ94c27v/zka2mN8QHhFjdpEGh9zwjHqFCG?=
 =?us-ascii?Q?QJTIGsiZj764vMyCwy4gHO8YQC4Mg0DSGWP8Mrp87VeAAPH9e+W9djg8JiBh?=
 =?us-ascii?Q?nvBWMz7nI2eZJTERKdjBVdDRQjf5tk6qz3LYrgVMQhCcPVkjTDfug01/aGG5?=
 =?us-ascii?Q?VCtyUBjnfoVcrgRzG+A5/2QBLPdVExptFkghjYEwrp8jtcwpEn64r0VE/Vmr?=
 =?us-ascii?Q?AJ2QpOJbfDwj4r5cqgk+BtIwpLnACVaeblH0aV0Yn0ukQDJIX7VKIqtkqmE4?=
 =?us-ascii?Q?IVbzgA7DJnUweFDkTn7H2VcPKShhr969x6oBnUNIWWLBJ+KzjWDoIbRNP3DK?=
 =?us-ascii?Q?HWarJcde35MULBimPkl50/PRLPhiA9AX0oI866JT+Nkq+J9C+BVZZ+hbQtQi?=
 =?us-ascii?Q?oQWbPsd2MTKo1GxiLwT4MUGtaCxCDfE1OF4bajIgrpklW6V74dvDalgS9hNL?=
 =?us-ascii?Q?dNFY52wI3vLjVrkljs6N/c/QfMbbnCp6U38AbqgMvWkqqrlH6rio0OTaOTnl?=
 =?us-ascii?Q?GjMpyIe/VkQfOwSXzlCAzTPVgZpo05S5G/YRC5nOn4SlWp+spuGAi+5Bw/6a?=
 =?us-ascii?Q?vD4oWH85RN/gGQXPPepqiyT4+Y/QJ6cYGDEfVhK4ybU/+DPx8i3rdIiMET+s?=
 =?us-ascii?Q?XVR0S/B4MvK2kCZ7EZRxS7nxwmRHJSL1KqSyUio2O6UP3eWrtGmS2m9h/IDN?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: mt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 317b32e6-b74e-4726-f7a5-08de3cb50a4c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR03MB7180.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 15:08:59.3675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fb4c0aee-6cd2-482f-a1a5-717e7c02496b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKp3hsxJb5EXoD/vF6VUpQeWUFimTlOMkusggaf3kj8kUKeYf9FudW3aSZpNEzIFHSALbVVv8VfiaQ40czdBaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7414
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

With pkcs11 support it's now possible to spefify keys
with URI format. To use this feature the filename must
begin "pkcs11:.." and have valid URI pointing to certificate
and private key in HSM.

The environemnt variable PKCS11_MODULE_PATH must point to the
right pkcs11 provider i.e. with softhsm:
export PKCS11_MODULE_PATH=<path>/libsofthsm2.so

Example command line:
tools/mkeficapsule --monotonic-count 1 \
 --private-key "pkcs11:token=EX;object=capsule;type=private;pin-source=pin.txt" \
 --certificate "pkcs11:token=EX;object=capsule;type=cert;pin-source=pin.txt" \
 --index 1 \
 --guid XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXX \
 "capsule-payload" \
 "capsule.cap"

Signed-off-by: Wojciech Dubowik <Wojciech.Dubowik@mt.com>
---
 tools/mkeficapsule.c | 102 +++++++++++++++++++++++++++++++------------
 1 file changed, 74 insertions(+), 28 deletions(-)

diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
index 0f41cdb64f54..c55d4f1000b3 100644
--- a/tools/mkeficapsule.c
+++ b/tools/mkeficapsule.c
@@ -228,21 +228,46 @@ static int create_auth_data(struct auth_context *ctx)
 	gnutls_pkcs7_t pkcs7;
 	gnutls_datum_t data;
 	gnutls_datum_t signature;
+	gnutls_pkcs11_obj_t *obj_list;
+	unsigned int obj_list_size = 0;
+	const char *lib;
 	int ret;
+	bool pkcs11 = false;
 
-	ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
-	if (ret < 0)
-		return -1;
-	if (file_size > UINT_MAX)
-		return -1;
-	cert.size = file_size;
+	if (!strncmp(ctx->cert_file, "pkcs11:", 7) &&
+	    !strncmp(ctx->key_file, "pkcs11:", 7)) {
+		pkcs11 = true;
 
-	ret = read_bin_file(ctx->key_file, &key.data, &file_size);
-	if (ret < 0)
-		return -1;
-	if (file_size > UINT_MAX)
-		return -1;
-	key.size = file_size;
+		lib = getenv("PKCS11_MODULE_PATH");
+		if (!lib) {
+			fprintf(stdout,
+				"PKCS11_MODULE_PATH not set in the environment\n");
+			return -1;
+		}
+
+		gnutls_pkcs11_init(GNUTLS_PKCS11_FLAG_MANUAL, NULL);
+		gnutls_global_init();
+
+		ret = gnutls_pkcs11_add_provider(lib, "trusted");
+		if (ret < 0) {
+			fprintf(stdout, "Failed to add pkcs11 provider\n");
+			return -1;
+		}
+	} else {
+		ret = read_bin_file(ctx->cert_file, &cert.data, &file_size);
+		if (ret < 0)
+			return -1;
+		if (file_size > UINT_MAX)
+			return -1;
+		cert.size = file_size;
+
+		ret = read_bin_file(ctx->key_file, &key.data, &file_size);
+		if (ret < 0)
+			return -1;
+		if (file_size > UINT_MAX)
+			return -1;
+		key.size = file_size;
+	}
 
 	/*
 	 * For debugging,
@@ -264,25 +289,41 @@ static int create_auth_data(struct auth_context *ctx)
 			gnutls_strerror(ret));
 		return -1;
 	}
+	if (pkcs11) {
+		ret = gnutls_pkcs11_obj_list_import_url4(&obj_list, &obj_list_size,
+							 ctx->cert_file, 0);
+		if (ret < 0 || obj_list_size == 0) {
+			fprintf(stdout, "Failed to import crt_file URI objects\n");
+			return -1;
+		}
 
-	/* load a private key */
-	ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
-					     0, 0);
-	if (ret < 0) {
-		fprintf(stderr,
-			"error in gnutls_privkey_import_x509_raw(): %s\n",
-			gnutls_strerror(ret));
-		return -1;
-	}
+		gnutls_x509_crt_import_pkcs11(x509, obj_list[0]);
 
-	/* load x509 certificate */
-	ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
-	if (ret < 0) {
-		fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
-			gnutls_strerror(ret));
-		return -1;
-	}
+		ret = gnutls_privkey_import_pkcs11_url(pkey, ctx->key_file);
+		if (ret < 0) {
+			fprintf(stderr, "error in %d: %s\n", __LINE__,
+				gnutls_strerror(ret));
+			return -1;
+		}
+	} else {
+		/* load a private key */
+		ret = gnutls_privkey_import_x509_raw(pkey, &key, GNUTLS_X509_FMT_PEM,
+						     0, 0);
+		if (ret < 0) {
+			fprintf(stderr,
+				"error in gnutls_privkey_import_x509_raw(): %s\n",
+				gnutls_strerror(ret));
+			return -1;
+		}
 
+		/* load x509 certificate */
+		ret = gnutls_x509_crt_import(x509, &cert, GNUTLS_X509_FMT_PEM);
+		if (ret < 0) {
+			fprintf(stderr, "error in gnutls_x509_crt_import(): %s\n",
+				gnutls_strerror(ret));
+			return -1;
+		}
+	}
 	/* generate a PKCS #7 structure */
 	ret = gnutls_pkcs7_init(&pkcs7);
 	if (ret < 0) {
@@ -349,6 +390,11 @@ static int create_auth_data(struct auth_context *ctx)
 	 *   gnutls_free(signature.data);
 	 */
 
+	if (pkcs11) {
+		gnutls_global_deinit();
+		gnutls_pkcs11_deinit();
+	}
+
 	return 0;
 }
 
-- 
2.47.3


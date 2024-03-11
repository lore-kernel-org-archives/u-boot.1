Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278B4C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 21:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493B287E3D;
	Mon, 11 Mar 2024 22:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="lNozHGaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC62987E32; Mon, 11 Mar 2024 22:33:52 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D844B87E62
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 22:33:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9800dbbead=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BHvYd1015991; Mon, 11 Mar 2024 21:33:48 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wt25w9fem-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 21:33:47 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBBOh2Xz4TNhT93K02XKuXDhg0B7OBT75RVijIJ0QUDFblwavsVeBMSatnc/bkaPbWar0hoduuynJZ83ik+C58y/y+qIr1VtbPwhRIkTURdl+apTNvhDHShOV4+TNEckzV0AiJW0EExIQhbuZuIhYHE7Futu0Fg84MMIJV7RdGw/dEocDjAopQ7OMcK32J+zj880JvylxL3i5hHq5f0HdRQau/NUIZ/qT5sdZb+PrsEK5THT7GGp9/+DvshD6W7VeCoRgwGxq0PpGW930PdLqbjmDB55wtaXzyh9jea1IaeVO8LfvCpAz17ZqpPm2dh3g6gglhpZKqEecMyJjvlcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgVNpf39i0ITSVBHIseNwN48lpNCQfP/QKJ4at7FmYE=;
 b=XS+jVN3jWOGk7bwv8lUrpqLhke67Sq53Er0NpOYlbkE7ho+/h85gOQy7+jX0Iyj0fePidnAQK/9D4VUzvbnVurOoNTajqzcxWww+Wo1p+VPg+qRxnSHO743l4FOQO/YsfpamfLQk9GyC4AXuRyjilLFS/fkIKF9E9tdUqZr60R6pFnIZ+mrv2tuaKcpTeci+m1u3kSKKyMH3OXmAteyVN9iDdaWlwCqAClP0b9y0hUCzugLU4VIKtEdVEGXcRIKK3Bqp4x9V9Cw9KVFm9VP2cs9pgxWTf2xA2FTAM6WjaPEIbDUCqsYTLEFie4zMG4t3kdvkAxld8yZXqoQxwmxIow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgVNpf39i0ITSVBHIseNwN48lpNCQfP/QKJ4at7FmYE=;
 b=lNozHGaLeDpMxhQwjagbcXcWENdUkVUQd5FydImxu2kLHpf0ZSES8p4YgOv/BNrlfs4Cc79mUVdXBvXvPZC6jAmuxthFVlro8eSmUgoG1vz0VeeO7M2W+tBr3Bq+ALgT/3c/cVmIBi4Q+3HosjhCsAebSFvBBg8zsedNJAhf86VS0IjK88920b8LtM/ubF/MvQI6LCPqGS4q9vjRWqwvx0dOz2U4n3+eohhcyhzUtQy8Zl3Joe8ZowGiJkGsgM96nO2EaIOrqaT4yHEKiIhGaFofe3oPyA7FWe19E9WmA5fiTPzqA9DqnylbJkNiJAUCm3K907KavD4NZbjIH3gDnA==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU5PR03MB10472.eurprd03.prod.outlook.com
 (2603:10a6:10:526::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:33:45 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 21:33:45 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Sumit Garg
 <sumit.garg@linaro.org>, Caleb Connolly <caleb.connolly@linaro.org>, Neil
 Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 1/4] qcom: board: validate fdt before trying to use it
Thread-Topic: [PATCH v3 1/4] qcom: board: validate fdt before trying to use it
Thread-Index: AQHac/vLhbTIij5ILkOdKIUh9Z1tOw==
Date: Mon, 11 Mar 2024 21:33:45 +0000
Message-ID: <20240311213334.3567389-2-volodymyr_babchuk@epam.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU5PR03MB10472:EE_
x-ms-office365-filtering-correlation-id: cb17318a-4ab6-45f4-3726-08dc4212ee48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QX7bxLiTx4tprMLFLfixn96hxYZalkmuJ9v0VLkeIhGPR7twdMNWbpPVTmOX8miwOSAdI8znGBCEeYI6Jpnx6XPfVQDDqQkwBMif9+F0Bo5Dq2tJLPo1IpHSPW7oLt4k85UCa1qclbwILkAqLwMa/10CakNlfhE9eWh2k5/4Jl6Iu1PCGUhu9X/Z3LkdYWx+2bzjmVdwmre9gK+FT6jlQoxWl/hFOL7JeFcdU2zOoZ0Qn7wVJlmFGpoEl4UhUehtdDmqME6wAEEgLIZl/K+UUyVT5JsjiahsniK0RVDDQGiF0hqZp77O85aWr2gF9kymDpwQAg0lQabre9reOsgBSK6EgMaOLcMH6CZ9yAsVCLY/ea24ETAID4TuVUzNkgBVZEsMLjAH+oDnGaUp1pnuMKDPljjdWjp8HvFI+RsxsJOZR0hxdE5X5pHLYvUxoSSobum/7OECCBOmNOAOFEXo0p87JxocH5a07fwut889i4CJs7+IO7uJ0paQnRnwszhLFNuymFUk9OOecS2BGqaD34Bb3pVq2JYQSYxJoMxvrYEjUBophexfW8Ns7Y7M0UEsMoITqw9fEbxHTLg1fi0AeBwHRrD2PeJzEvo7g2BiuU7OgiqOzVvOHXrnFL170zh83pe+4pLAfHvwYM1yzv0ZBNzrM8VvgXzR2qsLPP7C+IRVO9TOCyIdWIdLJVUxuXSfYzhzKGawenEIduy3EO/BzbXoNmCqXtXctHrpNOHLs8M=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ldjvJiCAEXOljZnr3C68NIN2J+f/QNixq6QYkf/Ov44NiIF7757y9EFVcS?=
 =?iso-8859-1?Q?8adCQTUh6DDT+U8kz1dtV/GIu4CIkeHDge8mn1xhZ/95BsO7UuLml7yANr?=
 =?iso-8859-1?Q?qt8PMWMSgiU0PkmDQe3UsBExiRoLceeCohRoUyqqdupSEFYOxVFE7w1mG0?=
 =?iso-8859-1?Q?PLyYdOov9l5tObSUHA9sWj5xBp83T2k4Ktfj8CCC7Mwq1lNbDM5gwCHQvO?=
 =?iso-8859-1?Q?okYvNQ5WWcctMigBoVzFaixNs54YziunFTJ+Gd7rZRKaxe9OMEwsfwtWeR?=
 =?iso-8859-1?Q?kJpdv15jEtLo5/RiDm9zIR5gR4JtqW8QYiB3gtSvz9uCTt1w2tGJixUfzz?=
 =?iso-8859-1?Q?/URFTt8TC4OG55eoQlWYdAugdK90HBz5NfM5PztW2Dx7Aqb0p/kh/Pf+rG?=
 =?iso-8859-1?Q?yF30ebESzFry9R3lkaoVQ5Z9BzpHmtYBRws0kKgv5ZVtmDKz9A3bAgtjxL?=
 =?iso-8859-1?Q?/QxMBP5VDVZ/Ui4jgQvn3bqtZBo+bDkyb90kf/zBlgowEEZ8TJdS187md9?=
 =?iso-8859-1?Q?Evr4/lQRSM8VUrMKlUfteVLmuarXrchxir6EwpCc5A6ZE7k2BiWLx0il20?=
 =?iso-8859-1?Q?LT/hDyxcTX54plFtVl4YxClstb873qFkE184jKM3GNT2Cm560mMu9Wr4VW?=
 =?iso-8859-1?Q?sZlny6IXJDh1/Cijg/DZSVcYvC31g8O5C1VgbpravQew/5dPKcixoKhUjW?=
 =?iso-8859-1?Q?DzS5DAxSvZD8VUK649KcyYZ8lGtOCM4xpL/8o1AxD0RPv2k26mHxeiu0TV?=
 =?iso-8859-1?Q?WMFsCo8tffq6JWL+KXyMUW2WkB7p/He5quC01kfB1jIaKd62BaXmxxY0Ll?=
 =?iso-8859-1?Q?I0M1rTBXF+0/kSvyqJ+o8Y29ZPoLUplK+NiIzlWpAGZ+Nx6jj6VeNVBRbl?=
 =?iso-8859-1?Q?U9z79uaP67ZYrosnaf1zeit7tl13/dVWBKtoFj/N1CfhHLhvmfRy8/Fom2?=
 =?iso-8859-1?Q?ZQ+gg9ZbZavypVHbL64/WeNgtIx1PzcmmiJlyxwChXi6sYus2kjUMHMqtt?=
 =?iso-8859-1?Q?2IbdXKB19HHh0c/uNI4exNjuajbYULl/R2mpeCC/CIaxdHH5MVJZlhbvSf?=
 =?iso-8859-1?Q?Z1thequan2Z1JRTNVny7p+K89Ytpt3s6HLD6nOQVwIQvKVzP5q5BnFBHmj?=
 =?iso-8859-1?Q?IexDhFNdZujY2+OJRy7/lwi+3VT9GZpOeJ2ZceQHPULHFgqICIQzAASVFl?=
 =?iso-8859-1?Q?AKsLXVen04qNof3mxaCSn1h6dM8YtfmKE6HVfApCKCV+v1O24Sj3Sf/NHO?=
 =?iso-8859-1?Q?CR8051tAmXQ4bjDtIyuWLGtq7gkY720bho50kHv4LeMj8Yvjg5jBg5nBcF?=
 =?iso-8859-1?Q?vcrFPwOHm4TONXWTH2DpnWPNvR/VE5dqeTacdnhQ+uddEvYPU/eJwLjcA2?=
 =?iso-8859-1?Q?nmwoOdYhO6VGJncoK2OCII3KXUzb/wZUALndL8hwwgpyBc9RGBLIWDF/fK?=
 =?iso-8859-1?Q?WZAtPpMIm3IGWyvh9D2wuu/PWxI4H3b9J56vYn9n/RB3ZRnUqK5nDDlXim?=
 =?iso-8859-1?Q?xeSttBqXuPBiY9TZjzahm5bHjplCCPEipJzHn9fh30j71HSjDQFHSHWBJ/?=
 =?iso-8859-1?Q?0+uy4A7lWGZ+Lrbwbd7ikTSdFOqLyRSUwUz3ntDyOFc3ODmpHuvTdgpauB?=
 =?iso-8859-1?Q?Ei+j68iNN0GyhFAhgdZarn0tLR3goBSJQb4AHUHjjeLHLPmlDwtfDSUA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb17318a-4ab6-45f4-3726-08dc4212ee48
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:33:45.0253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6evDzj0nSujsQjUoJ/VW55IzX9zxTSmizU1VjeRjCa92ZdVqKHf3pEmt20Kz9erVP8fpCyduiZ4kdkXMfemxUq2eYmpPLsnLkjZ1OLSOZFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10472
X-Proofpoint-GUID: OFfteP8w6zugrWZ6PAt7vkQL90feHkv4
X-Proofpoint-ORIG-GUID: OFfteP8w6zugrWZ6PAt7vkQL90feHkv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=729 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110166
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

There are cases when previous bootloader stage leaves some seemingly
valid value in r0, which in fact does not point to valid FDT
blob. This behavior was encountered when trying to boot U-Boot as
"hyp" loader on SA8155P-ADP.

To be sure that we really got the pointer to a device tree we need to
validate it with fdt_check_header() function.

Note: This approach is not 100% fool-proof, as get_prev_bl_fdt_addr()
theoretically can return a pointer to a region that is not physically
mapped and we will get data abort exception when fdt_check_header()
will try to access it. But at this early boot stage we don't know
where RAM is anyways so there is little we can do.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

---

Changes in v3:
 - Replaced fdt_valid() with fdt_check_header()
 - Added Sumit's R-B tag

Changes in v2:
 - New patch in v2

 arch/arm/mach-snapdragon/board.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/bo=
ard.c
index f12f5791a1..6f762fc948 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -24,6 +24,7 @@
 #include <linux/sizes.h>
 #include <lmb.h>
 #include <malloc.h>
+#include <fdt_support.h>
 #include <usb.h>
 #include <sort.h>
=20
@@ -93,7 +94,9 @@ void *board_fdt_blob_setup(int *err)
 	 * try and use the FDT built into U-Boot if there is one...
 	 * This avoids having a hard dependency on the previous stage bootloader
 	 */
-	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt !=3D ALIGN(fdt, SZ_4K)=
)) {
+
+	if (IS_ENABLED(CONFIG_OF_SEPARATE) && (!fdt || fdt !=3D ALIGN(fdt, SZ_4K)=
 ||
+					       fdt_check_header((void *)fdt))) {
 		debug("%s: Using built in FDT, bootloader gave us %#llx\n", __func__, fd=
t);
 		return (void *)gd->fdt_blob;
 	}
--=20
2.43.0

Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D858C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 21:34:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDB4E87F16;
	Mon, 11 Mar 2024 22:33:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=epam.com header.i=@epam.com header.b="IYPk4lIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7ADF87DD5; Mon, 11 Mar 2024 22:33:55 +0100 (CET)
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com
 [148.163.137.242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EB6F87EFF
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 22:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=epam.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=9800dbbead=volodymyr_babchuk@epam.com
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42BHvYd3015991; Mon, 11 Mar 2024 21:33:49 GMT
Received: from eur03-dba-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2169.outbound.protection.outlook.com [104.47.51.169])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3wt25w9fem-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 Mar 2024 21:33:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjkQHa5A5oKjrlueZmeDY+mZJHRWroMnzrB9uUht7W/EDhvUT9QSrQpHS/khIRtAYh2ZEZiDA9lU4YABecfiO1XY3vOJeEdBHy4YOGBxrEDiDxsuxgWk2R2IEN42KKLpDtg5rBI6vOpY3VEKcS9o607FaiSISnTDJhj8bTqUE4gWDraX3RMWLbONpsrdv7Gs54YewE6hFQlm7GsyIfi+4u6VAmO/34dCWAL+YQwWMm4eAXB63BRNKXlJrBEvDAOgf3akc3Nl/iPJD3MowN/in7kvIzI7giSaFqPx1ctBaTH0CSoN7Ym1oOJX8nuUP8BIhbDhXAT3J+BF9fht0zbb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfDZVSFCWoGXI4Clml1cmz4/I2sA7vzoQgxmSfHRY9I=;
 b=CRkp8f673axDHYyiSa+czQWaKBq3tnRvGhhG9XE+VPCUn8HdxyIuwGHa0lmeK8rHWfB7vjQH1ncuwCFrwFmFXhasHKH+pFz7sCnx6MDaZ/ibI1NMWgkflnSmLLWtQduM+mNxi2Be/M36aFDlmcjsnSXPFIBp/WBBEXteH7mdaWVSVk1zeCob42I5IJakHndu9WH7yvKsHEViEilwBEzQrXHw0XNlSw+Fj92tC8K6QN05Qo4nhDof3gkRg/zyiF3Bw24QiXXM3/heLhsckcQV88M1CjH0Yn6R2q+GHhqlBaJJQzSrMVxvSqTvq/3RkBAsHbp17X3fr9aVvM67CRkDlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfDZVSFCWoGXI4Clml1cmz4/I2sA7vzoQgxmSfHRY9I=;
 b=IYPk4lIUpNPlOpoii/wg+k9qYZmGaKqhtGPIQ9L7EutqPS3ShO8jVxmwQzO2ELDdiNxzZtLJvndl4CZvE45arJYJxa+g1UbKz7la8K16gWywyvsssv1HtyTCd2HmZiQXULRjlsnl2nNM9FzGzYXQFWqyeQPvVhIWu9qfpIqLdKgZl/uCRZXhKrp/Erpa2iBCUG69BWO1SSBFezOSh4HM9UDDWHsLndh+BmlTtuNU96DJONUSEQ0iEsfYE904HexGX7zg+TYnGR0qByMonx7NOMcIXAqitWCd4Z3AvbgEEAg04Ijh/LuF/c/9L96rXmwhQk4AonqeDETe7RpLjB4K0Q==
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 (2603:10a6:150:16a::21) by DU5PR03MB10472.eurprd03.prod.outlook.com
 (2603:10a6:10:526::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 21:33:46 +0000
Received: from GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8]) by GV1PR03MB10456.eurprd03.prod.outlook.com
 ([fe80::bfa8:3549:ac92:d0d8%4]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 21:33:46 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Sean
 Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>, Tom Rini
 <trini@konsulko.com>
Subject: [PATCH v3 3/4] clk: qcom: add support for power domains uclass
Thread-Topic: [PATCH v3 3/4] clk: qcom: add support for power domains uclass
Thread-Index: AQHac/vLyPMTEcvCYEmwz6c72CEgBw==
Date: Mon, 11 Mar 2024 21:33:45 +0000
Message-ID: <20240311213334.3567389-4-volodymyr_babchuk@epam.com>
References: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20240311213334.3567389-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.43.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1PR03MB10456:EE_|DU5PR03MB10472:EE_
x-ms-office365-filtering-correlation-id: baa8c143-aaae-4264-25d3-08dc4212eecc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4a89Bwh3DT8QZY2I+uRcvuCea7qs2BRPfBTn7Fdv+nMFq/YJrKO4Xz/PKMeL2xynM+cONdoQTis+t0v5+CYUnOIX+mXNbWr1878CdJdVLVIiSlno9/+LJUe37N5927BSP2GS1cLmbbeiIVaRH44V/l6wzUpqBD22mjSlEWuKDtKrZ4NPVYP5aHNM5Yv4TG9P0uJ5vV+NnoldMr+jdwei5VR/tPQ1Hhe0luyjRkuK6AemNytgEeKGiZ+qupQF1Y+TMlnNL9ViQZqIM7qmgQWWLlzWwR2VaqkaMfzVyz91CDO6i6y7ka5E6gWGR2VmZjm54L1C1A2m/m6GOtE/FoVc14pOp3NCgcdJADHpSGpjEMrqlmT4pxFktbUg0GufJeG6UM9K5hnMm51UmET7ojZIHDyIL2G0nyGTRqGIEUGaLXz5dfJYKHAVeYIspUzViXgYM7vnsEqzOHOfl2DhrcDEZiRfXYzds5a78o3GLW9Wr+UyVikmFuQFUx4M4PLCL5nJ/5/YB0FJZhJQCZq/jsWl4IteLGhL3qQdpVWOJZzE0sIGGLKTXoqiizHl/2nCyKd7c2c3Qdf6WhIUHq0SWD08eztFKptXX5SppSmkCL+4cCCVwBCrzTXExoOVeoTImR99RPAm8I6jabJ2ioer5bMUiLr9KwuTlDPgOeBOV9pzbW0JhELdIvlkbua0EjzC4SeM2pgDb14hQZotQjV+5KHlG6dN4Cu8LexllIdvh0/kJt0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV1PR03MB10456.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iufsBwVRNkvFV7Y1dds1AZY++nr3YDPIuqhhJTYP+RTsxuUrAzJDh++ROt?=
 =?iso-8859-1?Q?Ge/F6HAcBdaAw5iOK/nofOyXnH0lGvyGLChxll1eukNnNHZA1fPJCAbafb?=
 =?iso-8859-1?Q?W62/sZAFoTnhr8c6+y2Q4kaknO2QwZqPlYi7KR10GwQxgSN96VyovP+Qso?=
 =?iso-8859-1?Q?KSmaiWNJFVOKIMnYyYYUHCtVK3BatjZESJl8vIX290btBjcA8uSPu536c0?=
 =?iso-8859-1?Q?O6geyWfIgwdtZlTRdbLed5Gpc66mWe3Y1tUQva7/uEzlBS3Slzuq04IpP3?=
 =?iso-8859-1?Q?a87YrTBxgNQT7nXclJziN46bgrBBEgrs3rHW9Y4i8RHyRmrj6tWDDVVqSv?=
 =?iso-8859-1?Q?wDwe7cPVLc5fgSV0ykdBeb37l92KX35pYtp3U50Du4Sp4wNDeFLda1Mbu8?=
 =?iso-8859-1?Q?qoyIRjoXEAPiEsUZlM6QonAwsCyNf+bB3SAeC5tSjT5fqu5dE8LSLS7W3E?=
 =?iso-8859-1?Q?QozAskx1EbuTOXqI9yMgXis8ZOGsPzzDZaBqJIuOYorPu6Jgt2KdZ+jaxW?=
 =?iso-8859-1?Q?7rAhFMyT5SLKXyeCIBd0Ve0WgDab0cG+9ytUCnGLZMjmvF2hqEiWdFrvNr?=
 =?iso-8859-1?Q?PRBQsqseqlOeZNVWoZH23Ehx89NUE55XE2Q2k5O9b4sw4EBOEWTf7wylRG?=
 =?iso-8859-1?Q?P+Et1XK0fK2/l/oHgkwT/pvkvxYSGnYKv4Ibayhu6ytQP98XWJZXIqUkOM?=
 =?iso-8859-1?Q?wytvxCbHbJMIFL+4cRJ60eoQCOTuGxM9IFyJrwwTutGuNu2NKlCwidaQ4I?=
 =?iso-8859-1?Q?IALrTGoQ36+zZrTdxh++EqQwMLdkJF33mLm6JJi7WEnCwQByKML5+gfy+I?=
 =?iso-8859-1?Q?S1ev6CNVZys2PVhkUAazoKEvaeyuRUfSaJ0xHKlQW0Zlma5/pjrO07+hju?=
 =?iso-8859-1?Q?ZDramqndFIQwF5IWn44F6Gpnpw0qivwsgWJSqCFzaDIjrODNsCOEOFxjZQ?=
 =?iso-8859-1?Q?7K2kBSgiAoGPN89hxnBzt5HUuA+x2S+njfxZAbLqHEcM0mqFqnIppG8k7J?=
 =?iso-8859-1?Q?BMFu3LBDW7ek4VjS+pvs34bGU95iCr8KUDBGiWsu8Tt/LK8AfvaicsHWDo?=
 =?iso-8859-1?Q?lL1DcYNzyz7AqTy1QQwtNmhih1U3eXndyqOhgmFoNbuJ5gx/YMF7yv9h/N?=
 =?iso-8859-1?Q?z29c96J+a97Ja2bp8oww3FKwRv81nJf8eb3noudm4OM5P9uY35fHXkDTXw?=
 =?iso-8859-1?Q?VgmQXnNNiJQmEW0oDtE8TdSEFQjPsZHiTqfuq8/k4G8gx6P0kJAK1LbKBD?=
 =?iso-8859-1?Q?ikQDWBFPL5h+E6h2ULGh7IgmX2R9XojNp+ik+U00U3fxq/q/krtaPR82l/?=
 =?iso-8859-1?Q?EeNTL09jxWysRy60o10tCwLfX3m12eURfRgjKT4fZ3ZOVmlpifgW/zZYmL?=
 =?iso-8859-1?Q?sE87iy1Xq2Nj9bPSoxivZ80M/uj20E1jKgGOcTu/JA4vVg/FEWuVEfmPxd?=
 =?iso-8859-1?Q?+8KvuK+dzJnNIIM3Epz/Tgm71cuCRVA9OxpKY5pIXqlfOuAGOsJGuyxVfx?=
 =?iso-8859-1?Q?a4xuxNbcwPVtoJyapLsHpzrwesg9iSUMuMJOTBIOz6E1vBdTJd0xQZa4t1?=
 =?iso-8859-1?Q?L2Nr03LT5rlOlT7fdELe+370+OH5sVgrHVkBrXSD+HtTrWMd9nQ8FJkVUc?=
 =?iso-8859-1?Q?TdOlbRKL+CiEHfSPyOb4ZECcuSUUrvbC+t/xUOHvMx3DpTwniRxXpxjQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1PR03MB10456.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baa8c143-aaae-4264-25d3-08dc4212eecc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:33:45.7538 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DFpoU2j+sfxTPROoQl4YKp5A/we2CEURKx2XQBQydeaxcpQK+mrne6+Drg0MJR4HNu5esihcnfmrjsgeIinaeKrZF//gi8s3i5xy7cZskQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10472
X-Proofpoint-GUID: kEs0J9Pe4safm-gRvlqr9SR1pcSV4F9r
X-Proofpoint-ORIG-GUID: kEs0J9Pe4safm-gRvlqr9SR1pcSV4F9r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 lowpriorityscore=0 adultscore=0 mlxlogscore=943 clxscore=1015
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

Now sub-drivers for particular SoCs can register them as power domain
drivers. This is needed for upcoming SM8150 support, because it needs
to power up the Ethernet module.

Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>

---
Caleb suggested to use "imply POWER_DOMAIN", not "depends
POWER_DOMAIN" in the Kconfig, but this does not work:
$ make CROSS_COMPILE=3Daarch64-linux-gnu- ARCH=3Darm
scripts/kconfig/conf  --syncconfig Kconfig
drivers/clk/Kconfig:3:error: recursive dependency detected!
drivers/clk/Kconfig:3:  symbol CLK is selected by IMX8M_POWER_DOMAIN
drivers/power/domain/Kconfig:35:        symbol IMX8M_POWER_DOMAIN depends o=
n POWER_DOMAIN
drivers/power/domain/Kconfig:3: symbol POWER_DOMAIN is implied by CLK_QCOM
drivers/clk/qcom/Kconfig:3:     symbol CLK_QCOM depends on CLK
For a resolution refer to Documentation/kbuild/kconfig-language.txt
subsection "Kconfig recursive dependency limitations"


Changes in v3:
 - Added "depends POWER_DOMAIN" to Kconfig (see note)
 - Use readl_poll_timeout() instead of open coded wait loop
 - Print warning if power domain can't be enabled/disabled

Changes in v2:
 - Reworked qcom_cc_bind() function
 - Added timeout to qcom_power_set()
 - Minor fixes in register names and formatting

 drivers/clk/qcom/Kconfig      |   2 +-
 drivers/clk/qcom/clock-qcom.c | 132 ++++++++++++++++++++++++++++++----
 drivers/clk/qcom/clock-qcom.h |   6 ++
 3 files changed, 126 insertions(+), 14 deletions(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 0df0d1881a..8dae635ac2 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -2,7 +2,7 @@ if ARCH_SNAPDRAGON || ARCH_IPQ40XX
=20
 config CLK_QCOM
 	bool
-	depends on CLK && DM_RESET
+	depends on CLK && DM_RESET && POWER_DOMAIN
 	def_bool n
=20
 menu "Qualcomm clock drivers"
diff --git a/drivers/clk/qcom/clock-qcom.c b/drivers/clk/qcom/clock-qcom.c
index 729d190c54..7a5938a06a 100644
--- a/drivers/clk/qcom/clock-qcom.c
+++ b/drivers/clk/qcom/clock-qcom.c
@@ -22,7 +22,9 @@
 #include <linux/bug.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
+#include <linux/iopoll.h>
 #include <reset-uclass.h>
+#include <power-domain-uclass.h>
=20
 #include "clock-qcom.h"
=20
@@ -30,6 +32,13 @@
 #define CBCR_BRANCH_ENABLE_BIT  BIT(0)
 #define CBCR_BRANCH_OFF_BIT     BIT(31)
=20
+#define GDSC_SW_COLLAPSE_MASK		BIT(0)
+#define GDSC_POWER_DOWN_COMPLETE	BIT(15)
+#define GDSC_POWER_UP_COMPLETE		BIT(16)
+#define GDSC_PWR_ON_MASK		BIT(31)
+#define CFG_GDSCR_OFFSET		0x4
+#define GDSC_STATUS_POLL_TIMEOUT_US	1500
+
 /* Enable clock controlled by CBC soft macro */
 void clk_enable_cbc(phys_addr_t cbcr)
 {
@@ -223,7 +232,7 @@ U_BOOT_DRIVER(qcom_clk) =3D {
 int qcom_cc_bind(struct udevice *parent)
 {
 	struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_driver_data(=
parent);
-	struct udevice *clkdev, *rstdev;
+	struct udevice *clkdev =3D NULL, *rstdev =3D NULL, *pwrdev;
 	struct driver *drv;
 	int ret;
=20
@@ -238,20 +247,41 @@ int qcom_cc_bind(struct udevice *parent)
 	if (ret)
 		return ret;
=20
-	/* Bail out early if resets are not specified for this platform */
-	if (!data->resets)
-		return ret;
+	if (data->resets) {
+		/* Get a handle to the common reset handler */
+		drv =3D lists_driver_lookup_name("qcom_reset");
+		if (!drv) {
+			ret =3D -ENOENT;
+			goto unbind_clkdev;
+		}
+
+		/* Register the reset controller */
+		ret =3D device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)d=
ata,
+						   dev_ofnode(parent), &rstdev);
+		if (ret)
+			goto unbind_clkdev;
+	}
=20
-	/* Get a handle to the common reset handler */
-	drv =3D lists_driver_lookup_name("qcom_reset");
-	if (!drv)
-		return -ENOENT;
+	if (data->power_domains) {
+		/* Get a handle to the common power domain handler */
+		drv =3D lists_driver_lookup_name("qcom_power");
+		if (!drv) {
+			ret =3D -ENOENT;
+			goto unbind_rstdev;
+		}
+		/* Register the power domain controller */
+		ret =3D device_bind_with_driver_data(parent, drv, "qcom_power", (ulong)d=
ata,
+						   dev_ofnode(parent), &pwrdev);
+		if (ret)
+			goto unbind_rstdev;
+	}
=20
-	/* Register the reset controller */
-	ret =3D device_bind_with_driver_data(parent, drv, "qcom_reset", (ulong)da=
ta,
-					   dev_ofnode(parent), &rstdev);
-	if (ret)
-		device_unbind(clkdev);
+	return 0;
+
+unbind_rstdev:
+	device_unbind(rstdev);
+unbind_clkdev:
+	device_unbind(clkdev);
=20
 	return ret;
 }
@@ -306,3 +336,79 @@ U_BOOT_DRIVER(qcom_reset) =3D {
 	.ops =3D &qcom_reset_ops,
 	.probe =3D qcom_reset_probe,
 };
+
+static int qcom_power_set(struct power_domain *pwr, bool on)
+{
+	struct msm_clk_data *data =3D (struct msm_clk_data *)dev_get_driver_data(=
pwr->dev);
+	void __iomem *base =3D dev_get_priv(pwr->dev);
+	const struct qcom_power_map *map;
+	u32 value;
+	int ret;
+
+	if (pwr->id >=3D data->num_power_domains)
+		return -ENODEV;
+
+	map =3D &data->power_domains[pwr->id];
+
+	if (!map->reg)
+		return -ENODEV;
+
+	value =3D readl(base + map->reg);
+
+	if (on)
+		value &=3D ~GDSC_SW_COLLAPSE_MASK;
+	else
+		value |=3D GDSC_SW_COLLAPSE_MASK;
+
+	writel(value, base + map->reg);
+
+	if (on)
+		ret =3D readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+					 value,
+					 (value & GDSC_POWER_UP_COMPLETE) ||
+					 (value & GDSC_PWR_ON_MASK),
+					 GDSC_STATUS_POLL_TIMEOUT_US);
+
+	else
+		ret =3D readl_poll_timeout(base + map->reg + CFG_GDSCR_OFFSET,
+					 value,
+					 (value & GDSC_POWER_DOWN_COMPLETE) ||
+					 !(value & GDSC_PWR_ON_MASK),
+					 GDSC_STATUS_POLL_TIMEOUT_US);
+
+
+	if (ret =3D=3D -ETIMEDOUT)
+		printf("WARNING: GDSC %lu is stuck during power on/off\n",
+		       pwr->id);
+	return ret;
+}
+
+static int qcom_power_on(struct power_domain *pwr)
+{
+	return qcom_power_set(pwr, true);
+}
+
+static int qcom_power_off(struct power_domain *pwr)
+{
+	return qcom_power_set(pwr, false);
+}
+
+static const struct power_domain_ops qcom_power_ops =3D {
+	.on =3D qcom_power_on,
+	.off =3D qcom_power_off,
+};
+
+static int qcom_power_probe(struct udevice *dev)
+{
+	/* Set our priv pointer to the base address */
+	dev_set_priv(dev, (void *)dev_read_addr(dev));
+
+	return 0;
+}
+
+U_BOOT_DRIVER(qcom_power) =3D {
+	.name =3D "qcom_power",
+	.id =3D UCLASS_POWER_DOMAIN,
+	.ops =3D &qcom_power_ops,
+	.probe =3D qcom_power_probe,
+};
diff --git a/drivers/clk/qcom/clock-qcom.h b/drivers/clk/qcom/clock-qcom.h
index 01088c1901..12a1eaec2b 100644
--- a/drivers/clk/qcom/clock-qcom.h
+++ b/drivers/clk/qcom/clock-qcom.h
@@ -59,9 +59,15 @@ struct qcom_reset_map {
 	u8 bit;
 };
=20
+struct qcom_power_map {
+	unsigned int reg;
+};
+
 struct clk;
=20
 struct msm_clk_data {
+	const struct qcom_power_map	*power_domains;
+	unsigned long			num_power_domains;
 	const struct qcom_reset_map	*resets;
 	unsigned long			num_resets;
 	const struct gate_clk		*clks;
--=20
2.43.0

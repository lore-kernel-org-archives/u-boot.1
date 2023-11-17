Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4DCC072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 11:39:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97A74874A5;
	Fri, 17 Nov 2023 12:38:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="iln8gKL5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126848700F; Fri, 17 Nov 2023 12:38:43 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20724.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::724])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A6C487087
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 12:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKrn0saQj0sFGWmDNlcZghCImisTU3Tue2xTXS5ArQV15AE8HF9ldtNU1JWuOFJ71pBj1Uxe1gQUwoLm0rObhhRs/Y6jC1SlvYsyJSyrGBuOmoktLctTU7HGf5LcBpCztBIVQyUSNRJdMM4PHvG49qn4AJkCDCyNNqU5Ati9irgY1qA00/KMnmnzNMV35VzkcDNLtLH8/Hz/2P+mtZxaXBBcpOPuD9URRG7m+aRZLlgE1+ecozGxWHo/uGt1H1QS4CF1g8VGw2ZyqGxzne5Le2zUWKckpVEfgJiG4242T2diEoQTMaHoEXlGUjqHOb9169Fh8d3YZl4ttOMURhHGBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/q5igHhV2kVwUKy6W8WQHbkat1NJInULUMkHCWlEv8=;
 b=FMYJhr/9Vl442fM/QY7XmzT+Y8jv+CR5teO2I8DhdLbeWYg03AmONS9JeuMxbRJpQS/Ws3BzqfheK+RtN5XX7nGdOgonuSDCUrFfnj7f7K2dlAMPYdupQflyT+RwgQNdzcCO1Yxdq/+W3HOgHIMzrwR7ELCv0KZdeqBl/zahYssGIj459q2FP9rEQNWFMFJBJzPF5rWpHPtOW+h9okZl5csjaCJGZKw+P86iJA8K7MJoIvHg8KY5umtSGQ4hwJ4hVL1OR2M0SkZ1tTNZBCSwd6fdsyj3tXvFtkF4Q7sBIDR5cikJYLMztWdwTMCScv3IBh0LAilyaMACLoFpj3vk+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/q5igHhV2kVwUKy6W8WQHbkat1NJInULUMkHCWlEv8=;
 b=iln8gKL5Oz94wcFkwftfMJmXYUDGViH6V7d9hxlLuH+PY3NOxE73MckP4p+EN8PLgT13c1hh5v4U42czoPtbcBTVWHlmJzzCoUmIS6jWL1sSoNio2cupZOsaUCNFQZLrGDnf9GfO8jEM8elxBD2FM/+wpS02QAC1nx23uyb1L8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by VI1PR10MB3664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.23; Fri, 17 Nov
 2023 11:38:23 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 11:38:23 +0000
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Doug Zobel <douglas.zobel@climate.com>, Tom Rini <trini@konsulko.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: [PATCH v2 3/6] led: introduce led_bind_generic()
Date: Fri, 17 Nov 2023 12:38:08 +0100
Message-Id: <20231117113811.149329-4-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
In-Reply-To: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
References: <20231117113811.149329-1-rasmus.villemoes@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0000FA93.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:4:0:16) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|VI1PR10MB3664:EE_
X-MS-Office365-Filtering-Correlation-Id: adef9cd9-5886-4edb-bebc-08dbe761b48f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1LelGqD+AauBLrxrAQ1boWksuBH2vaCMyDpVx3TwhReokSCYACO/bT2K5kgYHbL8FeK19vcoM3zl6kgbB2QSb+FHRs8Bi6WxkMs2NHQpf2k4BbJ33JvpT2H0cp1CmoutZHdIMCyJ7oZ1P1vqcR9ObSoZOnnG7sXl0mMQrC6YlGRBTbj2VOvPCHZ5hq8b06coLfhprHucx1T4K6Een6vKvuUlwGf+5XygcSVYdJWTgwCFK1o8hImDIy6SFP9U5noWTG4ojtDq4dPIs2DekbzXVfDlJzdeHeE+t0RwwPHUZlPTP0JlmSJWGu+DJL6rart7OLPWq7NMbIVRPH2B6WNTrrJNIESmHLZ5v+lWtE3JF3v/Nyf/HBTRhSyUqnL3Vml7lzyrmO/oqjuFo+H6hZfTVSo3i4I3aQ4zBB7j/wuw/HtwGvbfZqbgC2ZmvgiwjTPfQ8q45asDnTLboQaVEcTkOQ9BrDWpj8yl6wlK9SPuSwgfw5vDJYxh/IGQQcNvD4+5rH3PvNgkj81ltlWZxjBA8L4rpQU3aRxUsX0rikXw5LXzpyeSM4IZEuFabJNeK3uO+5VrlYeXUOWuaCoZ8cL+DBg3Z9UctlI+4yodUcDfDQqWCP9onYZpnOFdlrfu/fjC2SUagCp/gC/J4ruyPzbWDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(376002)(39840400004)(136003)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(38350700005)(52116002)(6506007)(6512007)(36756003)(6486002)(41300700001)(8976002)(8936002)(6666004)(107886003)(5660300002)(86362001)(1076003)(8676002)(4326008)(38100700002)(26005)(2906002)(44832011)(66476007)(66556008)(54906003)(66946007)(478600001)(6916009)(316002)(2616005)(41533002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GQRBxReyso7LW3aL/tw+2iVXe6Z1sxr7Dcy1xcLv3vHwPepKC4slZYrmHO96?=
 =?us-ascii?Q?jfO+M2Y+KJH60AUiO7sMa3ohMZBTTNDrzWkQKGk0XTxVbBqoHmFUWXcqFP9b?=
 =?us-ascii?Q?rj5eGKy2ZtsaRkh5Gq8zyzyWF1Sn4SbtsVUWvEDGVosJzl1cPrN8OShPz0Nb?=
 =?us-ascii?Q?NZD8HwR+tPqwMop3V2LNpqHBltlGT/lLnF0ZExQQuWJKg4AmTTzVqLbqVmsu?=
 =?us-ascii?Q?0RoY96SSXYm3dXP8h+NKxgpGYJaUg1VpOCNGHuFMITQOTF6JnLt07jogz0iB?=
 =?us-ascii?Q?UMgrr8/yHgeII9uBpn2yEWqNJRk2e2yRp49kfeQvhlZ6xkjd8AbdKP4ZgIyo?=
 =?us-ascii?Q?1Sp/rCEX6TGNM34ehWA9hD44a1bnrMevgprisyfdFizTbOPHQWgL1VstkS7a?=
 =?us-ascii?Q?iTRaUIrjq82j3v53x2bK9CzTJrMeXUjhETgcFiaDmz02PoVD3ejBnciOFPYG?=
 =?us-ascii?Q?sBtk0Uh9ljWDFH7XvokkbC303QZXUlmOLwOq0EKwO5NjJ6E3K1tPgfpd5Zd4?=
 =?us-ascii?Q?xXmr28llGub7oAvC8VdqrzFLAGRZYa5qK09pxPT4qSUT6EoZz3eEeZc4l/z+?=
 =?us-ascii?Q?q2VTBSmRcGCEMoSRmNaNwMDBZaHZ+eI9MiDv13wA1/YKzF/c01n5O8drGxdQ?=
 =?us-ascii?Q?juLfkzMV1CWaEnCJLMDYAEFumQPUCeJ27A7dUDZaTqDDsD5Mol/7sGpzzIIq?=
 =?us-ascii?Q?E0NRrnUR19TYg8Ku4giQUhsmSOs/dbA3OHZVtxq3gnKwQC9zP21asrxl//ib?=
 =?us-ascii?Q?DTiFCPDF/NvNEu+JchumgpgT57/ZnWWuxl1NC2EPVj6/DLP1rUnGC7gTMHV8?=
 =?us-ascii?Q?ipNgO+oWmdhwDvW7XFrOy00cNWXSc6X4wS9siGAl13GFtXbKkJth8ZoeZeqx?=
 =?us-ascii?Q?k8a4V+zcfnEhWBksrmdB1thyF5HvsiBQX+/amMr3ZzvuGTSYJ0fGUpPBAgMt?=
 =?us-ascii?Q?mM28PeD4TL8IwGJJcCZg6ZRVcH4j2Ui3yZ7WTKM9Zl+LPSM4QHgmH9e/lUOE?=
 =?us-ascii?Q?hGWrVxkcntdyz2xn289TI/SpDfq/33UAA3TY3D4zmQ50aW0n2FipjjUZYMhc?=
 =?us-ascii?Q?J5Z9+HaTTz4It+VC6ZoqmMyKPcZ/hK0RO8xPooBnuuvBc5EnHwGLDya//PZJ?=
 =?us-ascii?Q?jFplly/UuVmevGI10l77HaOLRxVYNFS+VxHEBLQ09IiCkHbAuzIK36yuLQ+v?=
 =?us-ascii?Q?oT/mg/EmcegMLEdPiECOCSEx7VDL5U2DxtSCftmWaGXvoA+lS41pKb8e8rUH?=
 =?us-ascii?Q?XBXWSTT8vrJ9tZKLNn1hsRRRO1YITPGLjAREdThn6hpHTnVZKhqsyxwaCigz?=
 =?us-ascii?Q?9ch0eD8yez3DVsWYpmqBygFmE0LYnw0KJfISKTSawCcFu8I659ZIVG0ulybx?=
 =?us-ascii?Q?2saPGaDVTiWsTye15nN3jXd0e7jr8c89YXFC7R5FEGn4TTSmd5+Xm5LEdXqR?=
 =?us-ascii?Q?xSocjzGRacxrG3Lr9+F/ja3pcxAHJ2/SURUYxAKFNYvbVV2cnDLQCM9ymJ7w?=
 =?us-ascii?Q?ZFcoWeAdnFqUCxmM3mzxlfuZHCWvUCdt2sTJVrkWUdQ+jbg/Rvyykts6qjmP?=
 =?us-ascii?Q?caDYJR0L+P/qGBSBiFovOeWm4CvqBNF6r7IZ+NJzHzFSKY28Ehrn+q6bVJj6?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: adef9cd9-5886-4edb-bebc-08dbe761b48f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 11:38:23.1073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iDvTVWo4l7C/oLF2WwV0et1FDPnmvMvYUemEARKz81YdTZPC5e5M9VBhIaZHLHSQ5ACRya+t9mXfb3C9hrA3oNeFEo5fyBra4Vv1IPTuMgU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3664
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

All existing drivers in drivers/led/ contain a .bind method that does
exactly the same thing, with just the actual driver name
differing. Create a helper so all those individual methods can be
changed to one-liners.

Reviewed-by: Marek Vasut <marex@denx.de>
Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
 drivers/led/led-uclass.c | 18 ++++++++++++++++++
 include/led.h            |  8 ++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
index 0232fa84def..a4be56fc258 100644
--- a/drivers/led/led-uclass.c
+++ b/drivers/led/led-uclass.c
@@ -11,9 +11,27 @@
 #include <errno.h>
 #include <led.h>
 #include <dm/device-internal.h>
+#include <dm/lists.h>
 #include <dm/root.h>
 #include <dm/uclass-internal.h>
 
+int led_bind_generic(struct udevice *parent, const char *driver_name)
+{
+	struct udevice *dev;
+	ofnode node;
+	int ret;
+
+	dev_for_each_subnode(node, parent) {
+		ret = device_bind_driver_to_node(parent, driver_name,
+						 ofnode_get_name(node),
+						 node, &dev);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int led_get_by_label(const char *label, struct udevice **devp)
 {
 	struct udevice *dev;
diff --git a/include/led.h b/include/led.h
index 329041008c1..a6353166289 100644
--- a/include/led.h
+++ b/include/led.h
@@ -110,4 +110,12 @@ enum led_state_t led_get_state(struct udevice *dev);
  */
 int led_set_period(struct udevice *dev, int period_ms);
 
+/**
+ * led_bind_generic() - bind children of parent to given driver
+ *
+ * @parent:      Top-level LED device
+ * @driver_name: Driver for handling individual child nodes
+ */
+int led_bind_generic(struct udevice *parent, const char *driver_name);
+
 #endif
-- 
2.40.1.1.g1c60b9335d


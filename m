Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C8C9C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:11:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DA0187ABA;
	Wed, 10 Jan 2024 10:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="Ufph/QeQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79AF18797B; Wed, 10 Jan 2024 10:10:53 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::617])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C2187A47
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cD1qagJtD7ymg3NBpoPa7N+sBfM80etmGB2n05me3bUEkjOooTc6XbObaiIvQDds3uUbZ2rYg2g6xdwuASr1hgVACYs6cPy3zgoJMPYgRj53U/ZGw46ZhNfC7AgR+69W7s7yiwG6E78ODzuxWy8E59+ht0UkUhZTOOObq4kcdXfL/ZfqiOCqp5xli4cgB/VPd0SYoYtClJ3ygNcvySkxDwGgcQ/vcEBQYbGohmyzCrfp/qwPkZKKchH0ffkavKxMViOpx89PFiBYRcup+upQmPr6msCr4QWPljxLiq8Dus26xpYvm9Fe28Y4qJKvAMoWOv+RuQi600DyN8iunPlGeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0BfjzbvqHDU3PasZhDmHRDR/BapW/RtSK5tMcI4qYrE=;
 b=UAXoH97/FMf9XDk3RMtGhsBOaudViREJp7K663+NCcibFroRW2zGs2/3V2LBi1S8QRODs6WD56KvldpRUQcnXqePaCJBu8zV+Kp9a4Gv2VycQKdEDeJVtBlNLaQCCeWLiQy3JuUBOgxBC52m/xQOuc7rvNaPccl4tOPizyJXVBd9fHsJMZF1h2zhM3dF5UauD3N1yUaooCxfD1qTFRRulZEx7khm+3CzIzRQ4Mchpmxv26DPmuqKzV7itRsF/ras4XWmNYLKJYpq/so8gSqtV7HYGnAkBUHhMUDX0ORuck26+7nFt+XcJQYnUBdv2sIwTaVQQhiGfR5tGw2TVaWqWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0BfjzbvqHDU3PasZhDmHRDR/BapW/RtSK5tMcI4qYrE=;
 b=Ufph/QeQgAO1iuXHV54q5HYcgTfn54jwpaaFLpl6PzSTT5+BgCcjP/Aownw1WmULlhEROTIhSjV5W0VIiIImScfqh9Lyc9hmf1G9RDWfaY/lpVgzFxHthbGDC7yS566qa1iYr0vhWFTOwAg2bA1tFrcNdJ+Zt58DHRwArHNnh6Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:49 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:49 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v3 06/11] lib: Add hextobarray() function
Date: Wed, 10 Jan 2024 10:10:32 +0100
Message-Id: <20240110091037.392520-7-lukas.funke-oss@weidmueller.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
References: <20240110091037.392520-1-lukas.funke-oss@weidmueller.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0200.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::11) To AS2PR08MB8431.eurprd08.prod.outlook.com
 (2603:10a6:20b:55a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR08MB8431:EE_|GV1PR08MB8641:EE_
X-MS-Office365-Filtering-Correlation-Id: 94f096e1-45c2-4d0b-66a0-08dc11bc09bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QPSFUajYL8rJK3MOL13m6HphUXLiutEG+WyhB9xTaHofFsbkhwr7f/zX4EtKvDNbkIAI3ZnnaIjXfixRm4GrbpZ7tRFY5cYjMBLysiOjgTst+7TUXbQ9KUZDBAD8Adcy4BKm3pWBK+2BUcm4a+PRQSqMkw96nrlNrVeIer9k+UAzZArv/501UkpyB56B03UBlqwrUklX0rHa12O+NPAYa/9RB6X8+nzd2+UAIlDddYwZ2VacfVUdjQLD50BoA/sGjzz2uJZrk24Xmm8BTxhXCQxwv5CJjXQBVAcpK9tQSJf218JWHGnPnAub7Edf84vOiuRyth7OSlvMoAwkQH9kOs1cPBiyGosWU/hchyeb2HCy7fq7Mn3xT8dHo6zw6TXipF5OO0mIWVZxPC7f7TFvyrK1NpKxainZYasjqvlfYrPP100MeUYsHb+bxN5SbWJpx/m5rUDa1wD7yTEVSkYWSVXwfjAFNklLVlh1idlVq1DYqhzM+A46FZoU1cB698cwDiIsU5eQdqZiEOZ2vtQLw0rDykZwVujYi5Mn4/kQZVR7mGfufCU/iJ+0RwOZJb6YQqqpOxORWFKOapUl0R/xeZdX3ehhPC9C/5d1lD7ntQU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(107886003)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDfhjXhR3zNEkGdd7J7clwNddaVqTFSpwIhoL3/2ECiXDng+d8QS1ZVAfeo8?=
 =?us-ascii?Q?DODsMC3W76wuXTkGi901tXuEGRm96DTtJilLQuWp3mi0K8abktb74pIA84QB?=
 =?us-ascii?Q?35vyXB2c/kyRsy3AsXPWIpjpsUYxytNE79QUh0SdY9a6HbhsXuPx2zEC9QFO?=
 =?us-ascii?Q?5eLaPKRkHP8MWmujcDMraS6F/PkUckIG6XsRrIFOLHU6RmwoWax0xX/yw8MM?=
 =?us-ascii?Q?OUDtqi5weaX6VZ398/4SHqHE1Qtv0Me3llvFIccbEQ4nII+PYH+a0uNzKGrE?=
 =?us-ascii?Q?OfSOofqVyyxIxoGxmGmZElt4yUwmamKOdAaYrYFCtYehbGSqEftqz7Y0LGYn?=
 =?us-ascii?Q?O5uJ+UCUKT4y7iE9988/KMDZdSyF2Axl1tx+0PbDSW5UUXCC0Rcq0vtabIAt?=
 =?us-ascii?Q?zpJmde7QYy0tVuGjGVT43b03Ah2BGRqLoSxgxRkpVPPnGb/XUZLa+vo3WhS4?=
 =?us-ascii?Q?vff3ff6+L7mCI8/NvsCvhvvWfgrn0shRiXd8Vo4GEf3o5fpLOdw0tt1vgdVQ?=
 =?us-ascii?Q?LIQYb9b3Gv4nPioHgSWI+Fn4azU4Qxx/8Mts6ol6zJoyJ1HDKCEU0sWqLG/2?=
 =?us-ascii?Q?Pe+F0kznBecKNDpFQloAD7CGe9DD63ssjynsBED7nxRjxla+vnqOwZUaEltp?=
 =?us-ascii?Q?h3f2gEDPH1ijGPd0F/2vJY2X4ag+DXYHNVvh9msqUFiGgHsFQFZI/3/z/Xd/?=
 =?us-ascii?Q?/6ELQXQb3T/vUVZfEsq6XJ5M2cAqWpgFj6TCainEocHwg94YDN+lt9/PuEiV?=
 =?us-ascii?Q?VAoSUxi8RHeqMh3uUnVttnN673afEBduyn8RedNHhOOk+nrfmVOx0YMNAGTl?=
 =?us-ascii?Q?4SBOcAllzRODjUd5GeLbva+Du2e/22YHEAR4zB+7ZV39+6E00ogD95VP+npQ?=
 =?us-ascii?Q?tedSbsQYRUAjgBfIu6ymk9rIUhbFBq4G9jA0EpREh+xnPtZCNDsXX5FxlsZ6?=
 =?us-ascii?Q?bnv6fI4iH2luIk7ta8EKz9LK8z+L6U7PZCblq4wTyS5/iscxnyio/2XgJpup?=
 =?us-ascii?Q?7M56hoX73zGQ21SNsXv2TOzb8CXIV7ue7+bQpkGcdYzed5KuJOtqH/xZ0cCl?=
 =?us-ascii?Q?17GTOX2v3FZQ7mmiSLGGaQLrxcfo0rJUEEJLWBGOAPPK/E9AuIHu1qZrozGM?=
 =?us-ascii?Q?M/RN/WjLh0HVlErpFkxUO09kalA7PXLcCBY+S7v/XU5s1PePYdugPTGzSvAM?=
 =?us-ascii?Q?YmNxGJvtlq6fkiI/0YFbIKO0u43/TugqEN47zVWusU4p5muaT9qRILPUeof8?=
 =?us-ascii?Q?K5b6sulaIEDZy+Mn9FCF1A9KEKXENn9A1prHsVD0FFC5XbEqXYRKbGCvTOIs?=
 =?us-ascii?Q?Wci9levK+KizLtk+BKbM1HpVlKsPQlYlJRWr1RcesuuJtA7xShDBLQLc0oVH?=
 =?us-ascii?Q?finXlZx3wosYwLxxZv4L8SAmJ/IKP/C7ldwzTmeMsHy7pKgLKV2PDIcM1Q3y?=
 =?us-ascii?Q?11/j3BAriP4m5r8wWPcdKPTws2pF5tr9T789AxrMDecyFBHiJT1KszMCX/+m?=
 =?us-ascii?Q?0+PbwEzpDGykR96pGqgTPxZHH5+NzBl6NLJVxzdzxfqGM9Hb5/yCWlcAAfvk?=
 =?us-ascii?Q?Vjp4ZeLeOTTQcb6kY3sfTO+Si977yvsnHRwdIliq1BC3W4WG7guxRVlH15o9?=
 =?us-ascii?Q?xA=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94f096e1-45c2-4d0b-66a0-08dc11bc09bc
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:49.5711 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aw5IK4HZVBWFpVQ283vlYUGhJkqMAN1eMXwW/EGfqmty40bks34V4Dx3prk9ZY4PScUx5fzPyXLa9Lzx7Bz9Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB8641
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

From: Lukas Funke <lukas.funke@weidmueller.com>

Add a 'hextobarray()' function which converts a hex string to it's
memory representation. This can be used to represent large integer
numbers or bitmasks which do not fit in a regular unsigned long value.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
---

(no changes since v1)

 include/vsprintf.h |  7 +++++++
 lib/strto.c        | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/vsprintf.h b/include/vsprintf.h
index ed8a060ee1..82c8bf029e 100644
--- a/include/vsprintf.h
+++ b/include/vsprintf.h
@@ -368,4 +368,11 @@ int vsscanf(const char *inp, char const *fmt0, va_list ap);
  */
 int sscanf(const char *buf, const char *fmt, ...);
 
+/**
+ * hextobarray - Convert a hex-string to a byte array
+ * @cp:		hex string to convert
+ * Return: a pointer to a byte array, -ENOMEM on error
+ */
+uchar *hextobarray(const char *cp);
+
 #endif
diff --git a/lib/strto.c b/lib/strto.c
index 5157332d6c..eb507e4ab8 100644
--- a/lib/strto.c
+++ b/lib/strto.c
@@ -13,6 +13,7 @@
 #include <malloc.h>
 #include <vsprintf.h>
 #include <linux/ctype.h>
+#include <linux/err.h>
 
 /* from lib/kstrtox.c */
 static const char *_parse_integer_fixup_radix(const char *s, uint *basep)
@@ -73,6 +74,40 @@ ulong simple_strtoul(const char *cp, char **endp, uint base)
 	return result;
 }
 
+uchar *hextobarray(const char *cp)
+{
+	int i, len;
+	__maybe_unused unsigned int base;
+	__maybe_unused const char *endptr;
+	unsigned char *array;
+
+	len = strlen(cp);
+	array = (unsigned char *)malloc(len);
+	if (!array)
+		return ERR_PTR(-ENOMEM);
+
+	memset(array, 0, len);
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+	endptr = (cp + len - 1);
+	for (i = 0; i < len && endptr > cp; i++) {
+		array[i] |= decode_digit(*(endptr));
+		endptr--;
+		array[i] |= decode_digit(*endptr) << 4;
+		endptr--;
+	}
+#else
+	cp = _parse_integer_fixup_radix(cp, &base);
+	for (i = 0; i < len && *cp; i++) {
+		array[i] |= decode_digit(*cp) << 4;
+		cp++;
+		array[i] |= decode_digit(*cp);
+		cp++;
+	}
+#endif
+	return array;
+}
+
 ulong hextoul(const char *cp, char **endp)
 {
 	return simple_strtoul(cp, endp, 16);
-- 
2.30.2


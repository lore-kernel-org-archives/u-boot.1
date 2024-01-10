Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56385C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 09:10:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96F8087A61;
	Wed, 10 Jan 2024 10:10:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=weidmueller.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=weidmueller.onmicrosoft.com header.i=@weidmueller.onmicrosoft.com header.b="oxzn0BhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 731BB87A4B; Wed, 10 Jan 2024 10:10:51 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A088792C
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 10:10:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=weidmueller.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Lukas.Funke-oss@weidmueller.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BlvCZ+22OwR59hFT/Gxb3gluU4SEp+1Gn06c0UCYqi3huc7+q8xVjDwfczeKsEOtxiYAqXc5Gw0iDP3e2CsEqUDoMWwXxRopc2wxvQpXdep+nUC+oXz+OxPL+WPP4sa4SlSbDXOo+yGgr5R4FdI90pW2YloID6zrRf9p0jU12oSCMJ4kaI0AuS93SVVipCHiNZf83spXTKyKpRjAvV+DiciUr+MepMT8R3tHG5SDmG3cb5UfEVDUe/970xqPcGZUxPX1nLmHkf3UXqyAVC6z8Er+6EJoXffQ+1Kqo2yj0vN61RflgvAzV/u49gPC9+JYSzdOWBJ+uI2gXF+hNOZi/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUfQ7EZ/b2xAfXz2YAhns1pSq1ZFB23FnsAewKWR/dM=;
 b=C/d72Fy63Ebj0/oAqL1Bc+OE9bcWKR8MoFv+SvzpwHijyGsjNhmDg3ZEX7y5FlqsBBz0iqw1eYkzv/qCIMfIBcIWzVrVISQixKTdW5ZflxfbIEsPPo3rdopbbDEgOeFyt3L3nEoXqiTTOf0o2i0iqzDRogJrjASdnaJTl8La5vQDCgRFvdV8o2q59hd52aqmU1TYdD1RZUp2sYNzktZpzyQLCGWfjVgs3DUCHVR+hBTy1uFvufTprkRb2Z8lEerDB5PBXce30t7bKoGH3O6HxK0q4Cc6regR6hC6DZrXi828DFOx7MfKYd/KG4nF7enGs8TocTv52WDOMz0U7tiYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=weidmueller.onmicrosoft.com; s=selector1-weidmueller-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUfQ7EZ/b2xAfXz2YAhns1pSq1ZFB23FnsAewKWR/dM=;
 b=oxzn0BhXCeqahXU494xrby+TCjTc/jC21q7/dLX7OWSiUlFVi4iuMoB7/jD9VD7QTsMiZ2eXF/ORDXPyMqQPtljs/c3aaArXf15T3hSZP727leFD7VjvrQ6auV3yj4j+h8DggZj+uS3ahhu1rR9D+96VeKxpe1sBRJOjCxv0OEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com (2603:10a6:20b:55a::18)
 by GV1PR08MB8641.eurprd08.prod.outlook.com (2603:10a6:150:82::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 09:10:47 +0000
Received: from AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278]) by AS2PR08MB8431.eurprd08.prod.outlook.com
 ([fe80::daa3:b3af:ec52:4278%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:10:47 +0000
From: lukas.funke-oss@weidmueller.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Lukas Funke <lukas.funke@weidmueller.com>
Subject: [PATCH v3 01/11] sandbox: add generic find_next_zero_bit
 implementation
Date: Wed, 10 Jan 2024 10:10:27 +0100
Message-Id: <20240110091037.392520-2-lukas.funke-oss@weidmueller.com>
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
X-MS-Office365-Filtering-Correlation-Id: 48c42aaa-0d66-4f21-9b0b-08dc11bc088d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8FCw3lz74W2AHYs3HynPQxr8K1DCmzMKxa9ZZikqm4vr7JPRltKIPbiIKge3iynXq2IjFMDEoHJPiLr1koBFyPa0XNPgk8DBNAdzXbMpTp6stDTY8Jt4jyGyEOknwNLbAVi++5YKTkRYhoTfLOPgYdz9Nr311ywW5kkBASJ7ZGRuN1JnZGtbLjr8yGqvCXC2osl8cJmh7cBquz6VQ7aUT/TgqaYURxFBNxu4i8IUWkXjxzAHKeOu9QndfYlo1Hr8IGVG7Ba3Eu9Mifh5G1rlR4JoscE/bHE0guUC8felU/AnI5hAkfYnRafxLErBrPxyRg9Ma3eo/HToBEuPyDLSGhKav9Hvb/wUUeZIKIe4hmdKY+FGgAe7gSLA+HkAP5OmbXNELj4Di6b/6wnax3XvfGI9fGl3DYvXfNl6YzHeTAZ4ENeJRlzN5VQ0AMfagCnXF/AavJTzsZPvVLiVMM/G70U+15djJXTsByY8xkD0/6ElhhDa3lYw679HpxDSuJibTfcvPWQASLgz4e22W22VSoCBp+8y/Cc01TqzHO1pIeyGyLsWdU1s87fdC8m+woiCzFDtjdHi3jKc9iBkSc2I6twu32tg8cLKmo/FADeAYHiC7Bmu+fD/iOhPARIAdy0d+IOz57QHFWE4oBmRD99o3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS2PR08MB8431.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39860400002)(396003)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(86362001)(107886003)(26005)(1076003)(2616005)(6666004)(478600001)(6506007)(9686003)(6512007)(52116002)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(6486002)(8676002)(8936002)(6916009)(66556008)(66946007)(66476007)(54906003)(316002)(38100700002)(38350700005)(36756003)(41533002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Du+VIJnGr30YVjW3jZk4xNH4RzbA1YLD2kUontp9SDa+AI29/Y30I2DmyFvn?=
 =?us-ascii?Q?2bghX1kOHkV9x26Ikq8N5fP3U2mlSIExBPSVvdju4zT5WThK1qzlPeMFpO+B?=
 =?us-ascii?Q?79AmhxDkz1z57j1EgXHaEAprKbHe9WdyE8NMDiT8FWZtRi6a4vKrLDtLdWN5?=
 =?us-ascii?Q?SJo7Z9UqPt9sAcgNcUjP3OnyjOzT+92Z42YRJ4tjVtUBWQ6madHxK1zgDRqG?=
 =?us-ascii?Q?Mwdc2Zim6UCWXEP7bxdy1KpjJgZfLaKMM+yqzLzXNWuD3ZHyaCmybJl8p8lM?=
 =?us-ascii?Q?d+8ETH/Tq+SDoesHnJTi/Zb+MIPvu5Jk06AsRGT41LdC9hy4HS0YWMyG+xtd?=
 =?us-ascii?Q?eUDekRnV4CidJebsIDv3oRqA11X6PrqcU1h6KRH791eXF5pjdwAdYGZY5GJB?=
 =?us-ascii?Q?sks3e9u1YgQJ+SBHMzyMQFsolyzPs9ViYWnEorFPq1ne3XD5pcwMA9TOls07?=
 =?us-ascii?Q?cF+somX8n/wJB0vOS8Bpx1Kz7h4nvJxsCcjq/hv4EVxd4csMAbURSrnqiczo?=
 =?us-ascii?Q?tTh9yZMeVx8UJY45fRxwovey4RrvMqJt+9inmDI5Xzcolcv7iW28ByzKg6aY?=
 =?us-ascii?Q?bxaxGxNQQxSx0dNYQDavtw+AEJH71jw/Btf0JHguAfXspOQSoSvtOsH6ltn2?=
 =?us-ascii?Q?5iUiMLcGulGIIbHq6lckZ5kxVCi43IJX/Icvm6kArBDNUnZnqTjfNs0ZIcgu?=
 =?us-ascii?Q?3OJPcDjL7ea8rYyZEInwn97gl/xcq1R7fHXDCHAh0zcnZn8HDwrUfLK6tag1?=
 =?us-ascii?Q?1D9PJHT4OLu76UmDFEVlg7jdwXRE7UNoeocQ/35+XBsyHXU1wz+fplisWlFs?=
 =?us-ascii?Q?b2ZSWPfbA5rT+J+iwsiqO6O2BLQ07Nm0mktc6WBZu7LvjmWdjvSq9DIeBmjX?=
 =?us-ascii?Q?pD4EG5WWWIArtAI6/Izlg2j7n6pRs9xN5YSrCVZfOSsFWWFkw4AIhDURUypB?=
 =?us-ascii?Q?Ip9P9Ut2rTSk1lfKPwmv+VvdM7l/PXyXi37/rexm91pAElU9PzTQsHlsjS3t?=
 =?us-ascii?Q?UIel+gDaYNQLvB9OpXjRrCziVIXPdZj9WGixGNI0JyxZKUrU/yRVzPbsclYJ?=
 =?us-ascii?Q?yU/HzC5FBFEvLNJ2fdGv2nRFOKJAsH/DTYhhGwDQiNt5ih9giCYKmdu840JD?=
 =?us-ascii?Q?bq1XmKP2i7VHCv3owbAbYGaHUiBthaabYwrdsvogaw4fxSpdBFypaexR3hQR?=
 =?us-ascii?Q?lWH3lbhrZxpqJC05PRfMS9FfWoAPBJeqdiAwiUXrU1i62I2TIg3BDsJTZ1Bn?=
 =?us-ascii?Q?HgUYvTuSr7va887b/1Ox7bx/M+Jr8r2G04rM4F5RCujXC1020NulKCubTM3L?=
 =?us-ascii?Q?ZTX6+LveTKtr8SehRfJW+kQoYXRew6vjQq/CrW1vO0dQxXZhRffY7prhJ5MB?=
 =?us-ascii?Q?eA5DNu/skc0b+apj8EhbV+7aKbP8/9AVmyBanH/gASAuv9H4Q10a1Vujot1I?=
 =?us-ascii?Q?YyqXx4Ocorb111+xyCet0IMsK2a8BREuIRqgPrCdVhhpP8fX5QJB0bXW+wc7?=
 =?us-ascii?Q?BmimX7cFmnG6nrr0j8xrs3fpt5EDD+66OLVY76rDr9w/xgYsQY+1U5Xxa6B/?=
 =?us-ascii?Q?oMsStFQAMuI0dIUBRSn1kjf1RWhC373I8XAOPkwr7TlmHnRdaRKVd35ttwfE?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c42aaa-0d66-4f21-9b0b-08dc11bc088d
X-MS-Exchange-CrossTenant-AuthSource: AS2PR08MB8431.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:10:47.5666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfGUxABEDr9Nn3gCBvlGOAY3AGwgeLbsQGYSI6Mblh3cII1CYcm2VkR3asDS6wrdJPEDkiVAjjtByGvsC8l2Mg==
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

Add generic 'find_next_zero_bit()' implementation in order to enable the
use of the 'for_each_set_bitrange' macro. The implementation is currently
missing for the sandbox-arch and using the function results in a linker
error. The implementation is copied from the 'arm' implementation.

Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use generic find_next_zero_bit() from arch/arm/include/asm/bitops.h
- Redirect sandbox ffz() implementation to generic __ffs() impl

 arch/sandbox/include/asm/bitops.h | 60 +++++++++++++++++++------------
 1 file changed, 38 insertions(+), 22 deletions(-)

diff --git a/arch/sandbox/include/asm/bitops.h b/arch/sandbox/include/asm/bitops.h
index f27d5e98c5..6950916962 100644
--- a/arch/sandbox/include/asm/bitops.h
+++ b/arch/sandbox/include/asm/bitops.h
@@ -104,9 +104,6 @@ static inline int __test_and_change_bit(int nr, void *addr)
 	return (old & mask) != 0;
 }
 
-extern int find_first_zero_bit(void *addr, unsigned size);
-extern int find_next_zero_bit(void *addr, int size, int offset);
-
 /*
  * This routine doesn't need to be atomic.
  */
@@ -119,27 +116,46 @@ static inline int test_bit(int nr, const void *addr)
  * ffz = Find First Zero in word. Undefined if no zero exists,
  * so code should check against ~0UL first..
  */
-static inline unsigned long ffz(unsigned long word)
-{
-	int k;
-
-	word = ~word;
-	k = 31;
-	if (word & 0x0000ffff) {
-		k -= 16; word <<= 16;
-	}
-	if (word & 0x00ff0000) {
-		k -= 8;  word <<= 8;
-	}
-	if (word & 0x0f000000) {
-		k -= 4;  word <<= 4;
+#define ffz(x)  __ffs(~(x))
+
+#define find_first_zero_bit(addr, size) \
+	find_next_zero_bit((addr), (size), 0)
+
+static inline int find_next_zero_bit(const unsigned long *addr, int size,
+				     int offset) {
+	unsigned long *p = ((unsigned long *)addr) + (offset / BITS_PER_LONG);
+	unsigned long result = offset & ~(BITS_PER_LONG - 1);
+	unsigned long tmp;
+
+	if (offset >= size)
+		return size;
+	size -= result;
+	offset &= (BITS_PER_LONG - 1);
+	if (offset) {
+		tmp = *(p++);
+		tmp |= ~0UL >> (BITS_PER_LONG - offset);
+		if (size < BITS_PER_LONG)
+			goto found_first;
+		if (~tmp)
+			goto found_middle;
+		size -= BITS_PER_LONG;
+		result += BITS_PER_LONG;
 	}
-	if (word & 0x30000000) {
-		k -= 2;  word <<= 2;
+	while (size & ~(BITS_PER_LONG - 1)) {
+		tmp = *(p++);
+		if (~tmp)
+			goto found_middle;
+		result += BITS_PER_LONG;
+		size -= BITS_PER_LONG;
 	}
-	if (word & 0x40000000)
-		k -= 1;
-	return k;
+	if (!size)
+		return result;
+	tmp = *p;
+
+found_first:
+	tmp |= ~0UL << size;
+found_middle:
+	return result + ffz(tmp);
 }
 
 /*
-- 
2.30.2


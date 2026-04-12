Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF17E93802
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 20:00:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBC6484119;
	Sun, 12 Apr 2026 22:00:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="DEb0/2Zj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E32984199; Sun, 12 Apr 2026 22:00:04 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CFE84181
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 22:00:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPCmjRlLghNn/LZ/9eN9Rsd1uqLCb46oBWu035RpZX/iO2IJDZQWm4A8tenpZfGd571EfprjAz16r/HFhb64al6Cxme/DHdgLBdM7i8/EBiITfcjfFxY49hdXVAzMpHleGQYWr+OVXo229UuMMQQSLcQL0J2RdALDxkpImISt5hjlIivRAquAQ+2q1VFzxaRDqhXKWMpRnFOVPcTnPowbBV2Px+N2b26AjHnbQup4ZmBD3U/W7OTzUtVvGqtCVMhiuUJhWnbTIEyo/qkAfEzl25xMI/q5LwFJrfl7oCtkWrdbgr/e3tvWG6UIMx6XogsZ2v3Ot0PdUDTv1bM/V10yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2PPCu6fnl72oIp9WIAsH3gNT2bIwN3eUHI7SAtpPoc=;
 b=oBmsR+vjHC43HhSYaAPSvibyYVCmF2el2MYmpitQO5TOMxb67s5efCDyuFX9vhBkIoPwzRCrUyAptVmQPG5DaqQd1MPAkiBZ7IhcR2vQGlC+iNFBXxdgG/Nc+s0xSOMLSj1E8C/46Ef1Iw49GchwwE6JnJsYnN105ZXo60m9VPGWvWqk+0bFeKIRmcYdE7KP6gaYmhSdfBAwD6hL8v4E1rtCmR4Pw1R1FffzzrHieON5BBQ+hT37V8lmkkbc2AUStoEppJTjDIO0J0ylp+kPZzLvlsw98z8idtMpMUz0FfOCj+8vXdyizo5/UGVLYWvn7tIHKYh1Ukh3dJdBbNfcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2PPCu6fnl72oIp9WIAsH3gNT2bIwN3eUHI7SAtpPoc=;
 b=DEb0/2ZjUV7b1EocIzW0PEmp/vgWwWzHu6Nv1N4ysdLr0k6xAwiAuRl8Tpyn/PWhBXqxQHHPkG+5dgYV9WAc1UusRRIUYJOvNLs3e0IkKwQ8DQQBXvjqgmn8ge8fXmkcUft1O8WWT+4n1+8l+J9LWaerkGOJEaL0uhY+jZa0ehs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by GV2PR10MB9930.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:341::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Sun, 12 Apr
 2026 19:59:59 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.20.9769.046; Sun, 12 Apr 2026
 19:59:59 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 4/8] lib/string.c: introduce memdup_nul() helper
Date: Sun, 12 Apr 2026 21:59:43 +0200
Message-ID: <20260412195947.1982729-5-ravi@prevas.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260412195947.1982729-1-ravi@prevas.dk>
References: <20260412195947.1982729-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CPBP307CA0001.DNKP307.PROD.OUTLOOK.COM
 (2603:10a6:380:1::11) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|GV2PR10MB9930:EE_
X-MS-Office365-Filtering-Correlation-Id: db4a2bba-4169-4b38-55ce-08de98ce135f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: rncXzqW/Sv8bZvuPGU5yt8atU9+So+SgOCzI0xbJ195KC40anVPD+lOFyc4JzTIrcdEnt7smimqG5Xug4dJQa1pSaPs2MAhvc5vMdnJ4uap1A1RMluuI7Vh1w4/JdJmI2GaOVLRF7+C/QcharLudMkK43gGLFrwElgVUwM9HZnvIxRgXY0HymS8EicrsRAyNWh5hs3K/mnsiQD4w5gAzE09IfAO534Piq0GQrN6JrDWl3asDOI3OYmS2P8RyV0HwTgvpYrun1DJ7FtPMMAu3GYIWsfzMIemQtymygdPtjz4uvGM0BGxtm1pTb8YtlkgOw1vsS3CyD6BM0FUurCmT+dWmx355Ly/urwxMUDujh5kLZRg4C8Ms+lWl0TDicWi2yby9muZ8f8FA+GY3nvcpAx9uiqTC4K+ddoz8AKANYrDS5fePVTjyCUlUyH2dkNhAi4X4f6qu2aQz1T/4saZPG3rbIem/FKyw3xGKCO0QOL/Ledmzmc3ZbS474+7KiScb5HXg9kphTZPXpX3rNV3RQl3Xd+MVQ64XsFeQiaMo8b5voP0wHOVN9z5/UKGty17pPrhKuE2MeT+2B2RNKs0bGM1MTykQJkq+cdTK7F1k/9FQKLh92HNhxL35AT2IErdwMWX5kdicmJsiDYtrtz0wuRWABVrlAPTpn4PCBa01EPxxlTuKBmtt8fQA4PRwxZjWli9Dj4QokEuyWr/ilRFjri0SwT77id2KCHDPXkM7Rj/WNwgQ1RyuiNmzxwlonHGpXMnJb5t3DH9s/FXZqEn5E+JlDpEpOncEjbip9WMOs8Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FIR/7cMBSLJo5IdLEVI8p16Fln5OZ+JqIm++pRI49OG/xRW0Jgp6gC8qfcVe?=
 =?us-ascii?Q?kh3F3vakrNk5brJXcb3Aza0Am4u2ht/7XH4sEs5B9/S0phwmJujYZOBw7EWJ?=
 =?us-ascii?Q?1HPNZ9ZJBvG/LfdRUNDrJ3KKiVmQxLEOhEyuZjxpll0PJJidyxKIy56GxZeS?=
 =?us-ascii?Q?xz3V+nH0T84/cHnAY7zRitkUVK/L21VFcF+uC07YcKQ1Qa4jFkQwx50q1oxH?=
 =?us-ascii?Q?V+FszGKX51rzt4494zeDevXiPk9nOQZgbpyB/pggoSf4bGmFgIik5MwRUoCd?=
 =?us-ascii?Q?vB1AihZ/syE4lBeaMTKjXFVo1ZFuBGH6zKpQ7OFF5ix6qDgMxlKAa85dTeHu?=
 =?us-ascii?Q?43dIGN+tU+L6HEK6PpDzStv1qmrZBXtNBy2nea5R9v/wnQ5Ni/F1scqlCPOe?=
 =?us-ascii?Q?TY6Qtk6Pr9DLGgfvjaD7p5irEzVbviONZjFvSqD9UyZdpScnDD+fP5lFMR5m?=
 =?us-ascii?Q?YSp3IizKL0SnBgr4j+kkpoSfTT44l/r1vsiBh/aV7cj3aE/p54CyPAhXhu4+?=
 =?us-ascii?Q?CROJLLb96GSuKmoElYfctpjLPyH8AU7mR/xZHn1X3LqCpgAFgDyQLzh8FPBE?=
 =?us-ascii?Q?0d3UyYXnkmt0bz6okf7b4DLqHw0LKivuCd5F9wog7OBSAPdYDtoSjY0pOv3l?=
 =?us-ascii?Q?w2NPBsJ/Qh9vX/zlVhj9/hbxznlwVToQpPISGapFuZSiIL+h4hvl9zBgEdDT?=
 =?us-ascii?Q?cIoOhhV4nTFVRCVCMwExlzffgyOLtzd2mVIgibAkb/QQHBMZINWFfL2X0VJK?=
 =?us-ascii?Q?7DL2OcFdXK9vLxqCVWmM7uOLsN8j00zetLkESPYi21W19KRqKqYqYqfCewwl?=
 =?us-ascii?Q?4iSzKzM/i6Zg+PPVl7tftQHB6aw/afpmb5h+umkhkSukAL1bWdgvEXA76Da/?=
 =?us-ascii?Q?iSnh0FHMppGj03ldxXLj1jw98kPutuisAiyCPaXlZRKupk/Hlj2yG/H81dt5?=
 =?us-ascii?Q?dkUr6Ycovku+YXZ/8CtM2QV08jeDCKkRa0rUgkEwWvQ2HzwEEFPjbZd356py?=
 =?us-ascii?Q?FQCmw74sS0ufuZ270T6evkbpyDFqouc7DsEypYgwdX3+SZrefGgSQIUwpIf4?=
 =?us-ascii?Q?hLaE/jpIfJ3NZ6bPpTDV4mVmMf3rTcVLQvlqlAqcyvjT/Q65qSIGWdTdZCKI?=
 =?us-ascii?Q?+mdZ6X5vSZr8wJm2dmK7ZMAEEuIy9Y8/Lh1JU2N5fizPQZZUhYy4cLYIXh1J?=
 =?us-ascii?Q?qm0eBtDgFnufeKXNh7pI1eyXjvgH6EqtSlu76/krRuDIJ9zxXLE8dZYK+YUb?=
 =?us-ascii?Q?odHdXc4DY/uTbLxn3TG0VEiUkv4/9A3/+865MPllFYadPaohG8xD1YfKCMMu?=
 =?us-ascii?Q?u/PryrncjCIw1rEYctOVGqP5F+RTmBypJomIqFrTUJTmeDdGwn51GYabynGJ?=
 =?us-ascii?Q?Wqhgl21/LwVl8i9SLVVXDPKrN1tqhWBLZfQ6mUchW2V6DCYxiggAafpCG0XA?=
 =?us-ascii?Q?f0kNYALdSWgEWjUaypRkf/lrUX3QkxpLTzW3t5QcNCzCrylpwoarCTHuN/iB?=
 =?us-ascii?Q?Nk9Huv+FAaAsNXYUDeGl7l49r4ajXmD6/4rFua/xOl5fFM9R5cunKwNAXMcz?=
 =?us-ascii?Q?lOPXWZ/hrrqxYHizwkJs7j+AcdWi3V75+5pc13FUnElT96NKR3YKO5gH2vXK?=
 =?us-ascii?Q?qCJHnOhVCxcpZ4DXCJK0kOgcz25Xs44fmqKJMSST9z+LFEgRXYj8ng+pEb9C?=
 =?us-ascii?Q?VcSA1LsJIjeJ3e87x07QypYjVmjkOVQjsEwnN5LkLxY9El2Ydh8lTMQ8duOZ?=
 =?us-ascii?Q?QNTvXzh6oPtl+MXQSGQZvvigh9l0i5Q=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: db4a2bba-4169-4b38-55ce-08de98ce135f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2026 19:59:58.9486 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hkz06hmskh24zzKX8veRfdat8U3fImTrUgiPhgqcBeH/byGLpnmabUvFfd1d51dTCVc/0o9urhpS3SR5SQUlqIhqYL3HVpVrCboWWtFtD54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB9930
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

This is completely analogous to the linux kernel's kmemdup_nul()
helper, apart from the lack of the gfp_t argument: Allocate a buffer
of size {len}+1, copy {len} bytes from the given buffer, and add a
final nul byte.

This pattern exists in a number of places, so this helper can reduce
some boilerplate code.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linux/string.h | 13 +++++++++++++
 lib/string.c           | 15 +++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index a28150fa578..b2e38ecf26e 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -143,6 +143,19 @@ void *memchr_inv(const void *, int, size_t);
  */
 void *memdup(const void *src, size_t len);
 
+/**
+ * memdup_nul() - allocate a buffer and copy in the contents, appending a nul byte
+ *
+ * Note that this returns a valid pointer even if @len is 0
+ *
+ * @src: data to copy in
+ * @len: number of bytes to copy
+ * Return: allocated buffer with the copied contents and an extra nul byte,
+ *      or NULL if not enough memory is available
+ *
+ */
+void *memdup_nul(const void *src, size_t len);
+
 unsigned long ustrtoul(const char *cp, char **endp, unsigned int base);
 unsigned long long ustrtoull(const char *cp, char **endp, unsigned int base);
 
diff --git a/lib/string.c b/lib/string.c
index 2c1baa568b9..3923cce5561 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -343,6 +343,21 @@ size_t strcspn(const char *s, const char *reject)
 }
 #endif
 
+void *memdup_nul(const void *src, size_t len)
+{
+	char *dst;
+
+	if (len + 1 < len)
+		return NULL;
+
+	dst = malloc(len + 1);
+	if (!dst)
+		return NULL;
+
+	dst[len] = '\0';
+	return memcpy(dst, src, len);
+}
+
 char * strdup(const char *s)
 {
 	char *new;
-- 
2.53.0


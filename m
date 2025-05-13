Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 577B9C3ABC3
	for <u-boot@archiver.kernel.org>; Tue, 13 May 2025 08:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA92482AC4;
	Tue, 13 May 2025 10:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="O/wR+99l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB5D98091A; Tue, 13 May 2025 10:40:54 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADD5C82991
 for <u-boot@lists.denx.de>; Tue, 13 May 2025 10:40:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwoagDBjXVrDXHkYK+nXfedzCaCN4msEWBJqSkt9Lx5MbZ3mTqEhMi+/hxYaIfUrMoRSEnBcomNNtr6M80uSXmuZY81UnL+teBQGhF9jfoCyMunM718oSOA6NqoKrygQQ5zpl8NDkLoKHhFSlXTNLFDhlhTJgDUCWPlCfeu0FQvZett6d3sE/Cv+UHPx3O2wi0TVPnsFMTWraNDAzGzhzonm7z7eZnROZY3kmB6lcabOLW5Q2E9AV4M7ts0Rhvlf1kMTeBr1z+LwtFtx+B1Uo7C38/Q+z9aoORxyrAAfvwH7tWd7I2wH9Amc/XOLPkgP7ZCabz303mWVzIOf3DWUJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8LTMYMsJV4PWJqcnsSCoOdkS171ZCj00gw/MohuOIE=;
 b=yNn3MgUGPGZv+gk1wuxY1xmQrm+IdfNDEPWmYnCr/bVwzTxMmT3TYj7FikQGti+CV3gUEOTFcyfmS5VONtD+pkDNptfUmlj0Adljley1bYQJZUiXJkXWwPTp0iX/1PidB1AygXYhhSHqmIhZNrBwzuBJ+eZB69OMybYO7GjxGWRZ5xzT8rVvlBjYIsD47XCm7gxE382qrL/MH8219IpFOiyvauZg/3z9Mz5G/ZrOk0I/OrnXzNcR607smKjpoFEvadMmhtOXOqHHY12g0uKogWSszo+lLo+UTiWNQF0ZQluWtvjefIaBco0XtuRSZDxoLEZKp3ov1nLsxRiCIDtszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8LTMYMsJV4PWJqcnsSCoOdkS171ZCj00gw/MohuOIE=;
 b=O/wR+99lfHlmpDybhhQKhn98OXliNwIpHMGaka4Yhi2DZkDiR9GEQ9Nc9FfY7FC5zIN664yp4GYml4iptPxJzMeZYtwznC+wqvBfoLeK6YFoCssy62JNC2QzS8G2xB0+GxSCgZzcPAvMa9Bl6JzqTJmn/dL+I4MOrbFExsDoHM0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by VI1PR10MB3693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:131::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 08:40:50 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 08:40:50 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v2 10/12] slre: implement support for ranges in character
 classes
Date: Tue, 13 May 2025 10:40:32 +0200
Message-ID: <20250513084034.654865-11-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513084034.654865-1-ravi@prevas.dk>
References: <20250513084034.654865-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|VI1PR10MB3693:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d22d43c-914f-4615-4c7b-08dd91f9dd5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I5U2XSG1TL5NvoiYh38q91EYFE/YRjRDX6mKKWzbeDAr0tEGsBpS8ptANo91?=
 =?us-ascii?Q?lJaMeSBUPT9ebbg2tErSLoOLKFJZvagv9AuwsDl5feaNpkw/Ac4CqOn7YHLx?=
 =?us-ascii?Q?8sGLTuHRFYpcAWtKIttqZXKL4hAnEy98NFhRWvHI8mw+14nyxz3SnIimhmMg?=
 =?us-ascii?Q?PJJYXCjJnD0yIWvbfCVC7GwNGnt5OLq5O4qceXhzYu0BJ/hqUFXrFvzqF7Yx?=
 =?us-ascii?Q?pxVdg6l4HwO5Qq8i+/E/o4bmuIxmcbwEK8Qa3Ly4GPG+uuc/oHz9xkICDXN/?=
 =?us-ascii?Q?dhWZwDRks1gDEXmAMmWyEqGyn0AEk85pT8VZ1D8j+j4VoiMyEwvq3ijoLGtO?=
 =?us-ascii?Q?Vl2lSjYUwq0Q1QpXENHD0lcusYjzYxJKrNOQkxpo86e7Jof8dYlTE6nItouf?=
 =?us-ascii?Q?tFL329X/4S72xyAVDhK8znwmrawwbkWCswr0hfAPmbaQJzrL9aJBAfdsPkUx?=
 =?us-ascii?Q?vghQGWWXdd6LIWT2Icl4U6GAbJ3IzsPXL8Y8JELLV0d1vA+P9Mp4ese2QEry?=
 =?us-ascii?Q?6olutk4NhovNN0dWvaa2kgrvxb4FgEOMe578Xg1EkKbJmkJVbyYA/8nUbF/f?=
 =?us-ascii?Q?iYtPimcZjEu+yhVXxb8GJkmBYGvXlDBn6CiipuKFzHq+eXxbQT2RlqqBlUgO?=
 =?us-ascii?Q?Fe3ulnwDPlUAPmC7g3tLf/bLzzCQ05M40lIF63vdVWcTc/tZRyyb1OEIfu8T?=
 =?us-ascii?Q?iepu/WXWf0ZPhLV30ySVWiLvnfyAazJq9Uy3L1SQVuaWj7vuYPYu/xNZJMDA?=
 =?us-ascii?Q?6FxZAhPE7ZDErnAE3rzFex5OScwIBP6bKphAGQKjlGPRLxtrOWh5mC5eIjgj?=
 =?us-ascii?Q?Rx5AZ9b+oEIyCHybEv2d9PQVT+0k9tge6eTm04f/lxMMQrINs3T/m9+IwXo3?=
 =?us-ascii?Q?yg/Y7cIFUeyHVf9Lge1lGr7XTrESKv5LCcl/g02yaKxtlz2/Yr2/dTHt4dEo?=
 =?us-ascii?Q?Af7Ctxveufn3EuDzhwWGjt4HHvG8qQ1FJFQyeX1HR6yyksOcAMMDnEMIn2b6?=
 =?us-ascii?Q?Nrd7QVXC2KTxYdvswAplWnGqvoTMXHCLhmJmDQc9nfHJVmSu42qrMpWZ/mY1?=
 =?us-ascii?Q?DFdYRNllPqZVwEVo7Ww7YSlzjfK/3dVXEbr9E6gEEQOZ4wNZxETErqt8pOhX?=
 =?us-ascii?Q?1lVHKgFlJ83alq+lD4iUdFJhPa5e9h/CSFc6qCWm3f+83OjGjdHBz9XqA1MP?=
 =?us-ascii?Q?Vuo7Ilz9NE7/P+0qKp3e7QfPuUoCKuxNKyZdf/73xo6MggncH3gc6PkSroCr?=
 =?us-ascii?Q?v+XQCOXvEkrHZss03GE5N9+52K0LPeQz8ujyOWaaTsAZm2T1P39fwfTHARzt?=
 =?us-ascii?Q?k8DtTi5y+PQXUPJJG8BQUtrricLAz35Rp4+Ef8UsKGDmAl2Ml5RUe81urs5V?=
 =?us-ascii?Q?PbAUexOe+nyDOtxvgXnDxpbeHCKMQNxkc3SRkpd08Mt7HHXkiMzbTYCh4U7U?=
 =?us-ascii?Q?itBaBacJ71im0e3m598oUeH6Cuw7pFEvAhBL7bfT6B3ywvhQi3Q5IQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2T03puNte6UAI+UDKMpMWqBomcX13gFel/tKyunZAheEtTMjLbLt+DKavUqp?=
 =?us-ascii?Q?r/zsNEj+utiSWMFTBpc/DGM41UkcH0ZzPFcaxZc+UgYgvej8p9yscA/S6Cld?=
 =?us-ascii?Q?8A1dUYyU+HONmDRFwMaSImA+3njbqCnQPFxSL/Vv1SCdUq+COM7CkxrD8Zpz?=
 =?us-ascii?Q?dueI+fySCHwT0f34bQeDBk5qVUshpf5EC11fKszNbBkpXZ9Rv+mBKTaMVq6C?=
 =?us-ascii?Q?NTR3HoKGSrPDghaD3DtAtHMqPjua3UomiuN1PaV2iOBU5MoO+Zm1Ryb8Uu/c?=
 =?us-ascii?Q?FcxuMk0AWfyxwzF9rpM9kObYRooV3K0NVHnjCBy2xiuVJ8YVQzaCJ+WZoXSq?=
 =?us-ascii?Q?HUWzUFNT0lLyQiShfM9mP3VXW2e6R/j8PaFZTDIUJfwUu4zhpDB8r3+0jStM?=
 =?us-ascii?Q?s05XkzLP7AUfAV/+aEQeouJfovimmfvYKtje5KvD2RU/jEiKaYlKxUbDArAC?=
 =?us-ascii?Q?1uyGyznF/KcgwqbNzKLYP1YgEdhayDTAqh0ypPFtqLcs+0fFd3wCbMgcsO2l?=
 =?us-ascii?Q?D2YdXUY2Q4ZGx7NIFtTjce9uHiER9bJkOUWIVU9aPbiuCCK539roD+S5c2am?=
 =?us-ascii?Q?QNUWZRS8NJF1IZwIvqDYf+XVPmlPXLgyBIS7W4/OqWJQjubh/rfdl4m4R3Y9?=
 =?us-ascii?Q?b4WYAh86D+c1kE68xARUZcdyID8EgUxdi+WL/XqJPKnHTVHdpCtHfc2RH2vN?=
 =?us-ascii?Q?fjl16d7oTINHdHedH8DnGA6NSXbQbYD95SClFb65q4F8JO3YRUTrbW/fe0vd?=
 =?us-ascii?Q?/Mz22ZwXb54ynD3fRKXFJIKn17uHoYco214Sz97Wm4w/vtcUakqeEl8FIjS2?=
 =?us-ascii?Q?b6Aza0ZS31op+E5vJ3cZ/0M9UtVWrkI8Eah1lWePAVBWYwdIV0lrZ6qQsiAL?=
 =?us-ascii?Q?RblofFx6nUulAsYSlPDLVgObIJK27xxUvnhYa7P7C79oWaxBg5sPPrFmUnAJ?=
 =?us-ascii?Q?/Lt191xR7qXFieVATxm/JltUQbSeDNW2WURpXgfEGcud6trq05CkT4tXphA8?=
 =?us-ascii?Q?xnkXUnDtqA7ibD9Kvqoz4IC/eatAuwuv1TgCSgGW24WMv3qw0E1sQgo2kNxU?=
 =?us-ascii?Q?MRs5h+14bvcyMqHPgiszs9nOFboRtpI9HgeOgB0MftiZhO4vnrvYbde3gw03?=
 =?us-ascii?Q?kYw9Dv7J+GVqbHnFSpXWRntVHADEKzTE6IZpE/qR4wHdAl8h1H0CK9n+hArj?=
 =?us-ascii?Q?0sJnPpkgAa3Ax+s5gZuJwfY5FnZ+5EVoE6OapbvjMeo9rnY7CNmBj/RDvLMH?=
 =?us-ascii?Q?PW0FR4k/wD9sIBOo7gUPC80BBg+3t4mvZQI2ZSysDi63jGbhdMM4rX3Kx3Cf?=
 =?us-ascii?Q?pJQoodxaZnZJ3HLrB8yKSG3/fMAXBOyz5Fa78KATA2W7nJ8YRRQbEWYFI2ua?=
 =?us-ascii?Q?Pjft/YbVpCtrhP3i1OE8x6cBaxYkRR/hzsx8N3FEi6gwaJfgi0kx5ZIgyPNE?=
 =?us-ascii?Q?0FJkXXRdtXVFBI1i5hNkCi09/PTUK58ubT32SFKDT28B3ub9FlR61vs5Sa+Q?=
 =?us-ascii?Q?ur3KvjxlfhjX2xNG6BWq5TIbgZe2DI8UlOwRg+H9qF5L1r/xu3YapS/JGoTj?=
 =?us-ascii?Q?9XhFkxBktj5i1FbXhg/oGxXBFC7mut5386iRzu6y/FsoyHghZpRPqiF7C8cD?=
 =?us-ascii?Q?Sg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d22d43c-914f-4615-4c7b-08dd91f9dd5a
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 08:40:50.4175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RQNMSqOppwwIgBmV0LOKbiaH8NA85rS1vA0HDByOov3wxENwK3Lmcyjj84UktFl7t6DRUOCSTDY4484ZcDlGfPkNFCQC/hpUJesj3FFIhzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3693
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

When trying to use U-Boot's regex facility, it is a rather large
gotcha that [a-z] range syntax is not supported. It doesn't require a
lot of extra code to implement that; we just let the regular parsing
emit the start and end literal symbols as usual, and add a new
"escape" code RANGE.

At match time, this means the code will first just see an 'a' and try
to match that, and only then recognize that it's actually part of a
range and then do the 'a' <= ch <= 'z' test.

Of course, this means that a - in the middle of a [] pair no longer
matches a literal dash, but I highly doubt anybody relies on
that. Putting it first or last, or escaping it with \, as in most
other RE engines, continues to work.

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 lib/slre.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/lib/slre.c b/lib/slre.c
index 87dfde720e9..117815a6d60 100644
--- a/lib/slre.c
+++ b/lib/slre.c
@@ -30,7 +30,7 @@
 #include <slre.h>
 
 enum {END, BRANCH, ANY, EXACT, ANYOF, ANYBUT, OPEN, CLOSE, BOL, EOL,
-	STAR, PLUS, STARQ, PLUSQ, QUEST, SPACE, NONSPACE, DIGIT};
+	STAR, PLUS, STARQ, PLUSQ, QUEST, SPACE, NONSPACE, DIGIT, RANGE};
 
 #ifdef SLRE_TEST
 static struct {
@@ -55,7 +55,8 @@ static struct {
 	{"QUEST",	1, "o"},	/* Match zero or one time, "?"	*/
 	{"SPACE",	0, ""},		/* Match whitespace, "\s"	*/
 	{"NONSPACE",	0, ""},		/* Match non-space, "\S"	*/
-	{"DIGIT",	0, ""}		/* Match digit, "\d"		*/
+	{"DIGIT",	0, ""},		/* Match digit, "\d"		*/
+	{"RANGE",	0, ""},		/* Range separator -		*/
 };
 #endif /* SLRE_TEST */
 
@@ -260,6 +261,15 @@ anyof(struct slre *r, const char **re)
 			return;
 			/* NOTREACHED */
 			break;
+		case '-':
+			if (r->data_size == old_data_size || **re == ']') {
+				/* First or last character, just match - itself. */
+				store_char_in_data(r, '-');
+				break;
+			}
+			store_char_in_data(r, 0);
+			store_char_in_data(r, RANGE);
+			break;
 		case '\\':
 			esc = get_escape_char(re);
 			if ((esc & 0xff) == 0) {
@@ -487,6 +497,14 @@ is_any_of(const unsigned char *p, int len, const char *s, int *ofs)
 				if (isdigit(ch))
 					goto match;
 				break;
+			case RANGE:
+				/*
+				 * a-z is represented in the data array as {'a', \0, RANGE, 'z'}
+				 */
+				++i;
+				if (p[i - 3] <= (unsigned char)ch && (unsigned char)ch <= p[i])
+					goto match;
+				break;
 			}
 			continue;
 		}
-- 
2.49.0


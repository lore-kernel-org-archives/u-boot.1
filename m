Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772DFC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 14:17:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EFC682B16;
	Tue,  6 May 2025 16:15:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="GxMIIZJc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA03E82A4D; Tue,  6 May 2025 16:15:34 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::619])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEB1882A64
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 16:15:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RZFejkEKgch7A2Ua72EPcYawhLg0OiEvouJYFwiKoAlaz5zlXiQKeJHgxN7x5T/ctJPCGAmT8UBBX51m6ihp3t5wMlv3y9g6V4fESHrD4t8J6bUcHNtqxhhXYUd+tsXKovs5I6xsvRalOqe9+z4ajnFjq39UlY/gPZ1sxNcBxVjhXPqBPPsD1G49B/bmcKfyA6XME3tE2ziyz3GM7hKRhMX0t/ZjybwPdGwMquk9rUOt4uZUeW6ZKVz4wTa7uDoRJ/DOE1IzDHjW+p4iIiXgR9n46vp/F4NFdmDRTOg4oz0lNnvKNIwD7cOxvKtgwgNmnje/cVN8qxPFRePj9DRwIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lk1lLgz/C+QMGyVHasiO6sJemSrpFaqJWs7ZBxhxT/Y=;
 b=Cg9x3E6BgBQdslTLql3cA5rOZNSxtWgXwnmWO939DaFXmnYPKu9DNlH5h5CVuKVhy+fGYIYDSEmFR/eJ77guL9X/AJx2RDI84gzKqrPrdAcXUO4vBWM5yJuXUOMbrodOb9tKNYTRCGsdha69paAi1KSCvGBzP/rWcTAL8ihDO0A9nw1kKvAYpJaSlMzW/ckvolx36CFCjH/Yi8hnAIIVL+882UTktXlXczXmyvXFBbx1eCWeUIq2vYt/7Nc7E3o51PeqS8dNPgsZUqF/LHsXR4mqORKY2gc54w05H3hM5sWP1B0QgZg9/ZH94GsyPLyYqUik9nen6aAE/tGYhqHnCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lk1lLgz/C+QMGyVHasiO6sJemSrpFaqJWs7ZBxhxT/Y=;
 b=GxMIIZJcVSjDXV2nfTlp+6Yu5IVZmqmxySRJ5ovdeXIR6KaCbu6Pk3u2QF4YkYFRjbsRqxMCzUtrbdEFr36ZPsPWGqgxMsIJaqq8nDB+wwvM26UVBB+JneYrnIvYbkSyMiAaG/OBMRrb+sp4wkJqKfPSdIacojuBI3ldDvWKQuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4ca::21)
 by VI1PR10MB8208.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:15:30 +0000
Received: from DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769]) by DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::bb5b:4bac:5471:b769%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:15:30 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 10/11] slre: implement support for ranges in character classes
Date: Tue,  6 May 2025 16:10:34 +0200
Message-ID: <20250506141035.385756-11-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250506141035.385756-1-ravi@prevas.dk>
References: <20250506141035.385756-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:4ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB8248:EE_|VI1PR10MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 069b1223-4b19-4b5c-a8a4-08dd8ca87522
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R5ZvcBXMjyQpyhRDfOtt2hZV3ZikIAD/g/1gao09ERngzGElkp/oIf/56wOG?=
 =?us-ascii?Q?dpirWhbDQBGWt3o/BBl73p40a3Umpb+puZx/XraxwHXqlX2Pw2d4Hy2hotf/?=
 =?us-ascii?Q?ZjiG2ZLdmyB9hzQQAS/I/gDt9zgeIKhNA15wR9qcKBtX5firZaKsWkfaZzFo?=
 =?us-ascii?Q?vbpyFHg7286swKlFtvV+/mmDN7zaUCK3jam7lmRs5fcoy34DzIxtGdfNSf7D?=
 =?us-ascii?Q?zOI6d5jHn2dz4BYBdo8WZK+sj0S9uJg1Rd20S9jX54HP9z/d5Lp4r2R32qQu?=
 =?us-ascii?Q?sBNqSAwxEWF+O0r8iR3Vn61ZmvpnJcygpJOM5cfRmDZje3WwdUXgZk1H5QGv?=
 =?us-ascii?Q?0jKBuANo8Irgr98PB+HoQV7DaYQKgzcmV5Ep2JdLN7cPqnSQP2+7pXprXd5I?=
 =?us-ascii?Q?/WkaMZSQ0owd/RVxflIJj6ATAo1Ob+GwA1EbghaKen04HufyBdT03Fxv0jrl?=
 =?us-ascii?Q?c11hLkN+O2SCAj82amUIe8q1uVen7UczPk8hD/2snzntfsbJutcXlhDVkE1D?=
 =?us-ascii?Q?+2RRQTlD/97EWqtMRCHVpPf7oNHNFEAdThY6lYMOwAwA90EcTM1JCb01QbQ1?=
 =?us-ascii?Q?FisRVXfeq0ftUedp0GEDx5Jq6H41HXNxuhF3iXK82DvoEWRRlnYHw5CbC1nU?=
 =?us-ascii?Q?F80SoMCXnug8vLPZJF04PaFFsppPpipM+5HO3RefvcRutsB75+lQ28kDAs22?=
 =?us-ascii?Q?NnYG++LBtq8G0ly0sn9OKTIsnPf5OYemdFWVyFG7SHhaBfP8QgYk5zmg55fb?=
 =?us-ascii?Q?lw1qXAtP0EDFdu3nDIobgdGEjRNDu6T5etKJ17DvOA4ZOtrANmkAE6q8t/FO?=
 =?us-ascii?Q?pV5U/CvFc/4c4bhxCznIljealkiWwVyPMnvkswN8jj2j42dPR8KN6EU+Ee1U?=
 =?us-ascii?Q?4q6Z+FrHAepyi1jSb+JWUT76tDNPssJ1KqXIUbIQ40FrOY0FkiHGmsUSNtbd?=
 =?us-ascii?Q?vUNJpDLDzm6QQ7Z6Y8HtdhKs1LX7pUMFEf9zp1iIqj+W/cBMeUauhkxlCPLs?=
 =?us-ascii?Q?+cWipGVUQizPu4gdGxwi8miVr1SRG7k9jA2lKPBkofvXqevhxUFQ8LlY04rC?=
 =?us-ascii?Q?OMpfP3mklLXM0hW+4O1Sb4MCsPzx4LpLVr5ZqTH0fmqvbsm8yu4cqUx29w03?=
 =?us-ascii?Q?OtHWMUk3I6ne1DhkIdgifHmG6RIxajT9YhuZ9f+Y17f1mBvnC6zFAWmSvb9q?=
 =?us-ascii?Q?NWqQlJLCABLTGNYsVHhxBetmg77mYXf9/ta4BRC6tlGdrubM1D2Tr/o3Y230?=
 =?us-ascii?Q?Ad6sGBJ4Pl3y5hvqg1aX6xzTomWyOhsALLsNkQiJo1cup7Edt0cVzkRskuuL?=
 =?us-ascii?Q?6XIdK6q5s4E5MV9tQMCFwgsXifRxqjWkn7aGPi6JkkCPsu+KvHFsrt6fyL1R?=
 =?us-ascii?Q?osSKV2vFIAtweyguhshz264VdecwgEzkKkDwqETzhYqBKbKT23wbhPEKNv23?=
 =?us-ascii?Q?jWqJPlDazFNKU8/AuysT5qT0RpZlF0IGb8rYtYDRvjkLfLXASu2qcQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zXm+VaCVOZeim2w/zVG0LTo9JBy3GwKoca92vjAoDpWshMAt73Gdk0EwKafm?=
 =?us-ascii?Q?51jmQMT3/umpZon20g/vZjH+dWRkzT3VQwn0wKK88qinwe2ii4C8TSBx89DS?=
 =?us-ascii?Q?bssYjN2qnLP7ieNgvZZ8KYd9BLlT1HOL0KVLUuS1mWnwoO/5IjAgGF4ddxaz?=
 =?us-ascii?Q?+gj5op6MCC/UfeVwqLyiF2Qo6XCne9iCXqgxRKHO7nuyt8fM6Ua5eq99qMU4?=
 =?us-ascii?Q?zehwkc6nyzIhlWXn0Fc+M/GSpODAcarBZrFGyy/9FGzcOcYpXB/wZrAfhGvj?=
 =?us-ascii?Q?Bi4L8CcA56drgUYAks+1d5VSNbjkOb2nbdaOWcAM8UUpPo/9Qo1rRo2FCsFB?=
 =?us-ascii?Q?ezaQkPB/9/cXoFiiesgvM3+KcNeI89LYABEAg+VIQS5vy+9WrG67qofMlWZJ?=
 =?us-ascii?Q?bp+mG9M26CNd3QcekGENZoQEl5UPmh8paqprQvUGfRuNJdeNaYTOHUzD51qb?=
 =?us-ascii?Q?ygKxSQt8WnI8/+sanLSjMrDL+owStNSpbl7sit3q5HE6I9gPIs+RJIMXu+cC?=
 =?us-ascii?Q?BVMqD+6Y9vyG/hFnQEWRP9eemtiqLa4WFO7OMiTKT/2zvvn3Yh9xma0wHwbI?=
 =?us-ascii?Q?MPmkr/D/N+x/5kOq4N933hBDuQNw6e2KxW74JCRcpL7ShqzmRTYeZECTtl2u?=
 =?us-ascii?Q?Kj2U9xqFCfvsNXyQMQlHcq1AtvwPnHqSCZa0PjoqXTSFceI5vxVuvC2UDCMK?=
 =?us-ascii?Q?j70yiTX+YyIJNlUQf7BbcXyDT82AYJP4RgAcWV02Ym7ntcNioPKWZGKmxIy0?=
 =?us-ascii?Q?kA6sRBS/TthXZK+UjOXzSDIFViRulZVHXcqvcQqDqmibtRtayqeuGPUWwdz9?=
 =?us-ascii?Q?58WgFvYfr6hMW0aZbmAQR6uWj7w8cqI9PW5w4ThWvRBeuQuDjHY+d4v7IwC7?=
 =?us-ascii?Q?C2jZeZnaIdfOvvvs2O6KHf8DV6NWNI90WOzNdJO5M21C/dV/aVuV7IFeTERw?=
 =?us-ascii?Q?0O9aLK5el2EyZMgY2OXfvcY2kW72NAQ0WfkgqI2uejA1W5PMPKFr6cJ2bBDg?=
 =?us-ascii?Q?eVqDaJKxTiMh+H2jrrz/Oyi426xELxcsk9Z7fBa5vf3l0F3V/9Q9Nps96Ovm?=
 =?us-ascii?Q?2bIjh/yYCAiO1uGApy50HYqhxWCqiOSU23Bz6B29sZXZPKRZjBtLJhFO7LaT?=
 =?us-ascii?Q?kgeGErTGajYQrQ2wxW0uoapABwwSocSa3MyDnRukBKWpvnMlkHP47kHAl+Wg?=
 =?us-ascii?Q?u/XWQMJqGf/ESV79QlGyOaPX8Wyrd5U8+3xkbbAOGYqa4tVujOL8t0I0VwIW?=
 =?us-ascii?Q?9n5dMtbNprYGOrwI6f+hxYF6gL/zdos3nqT8VA1u+HIVa8a8rvpYQxs0FkGe?=
 =?us-ascii?Q?d3tSaAhrsPC448bUFzHTeDgUjHkrgxPInDO15dp/v68iv8n5qb8h0mXhyfnx?=
 =?us-ascii?Q?W6AAdQPqBbJUOifjix+Mx0+NeRsgCn7zzarkY2Yzo+xUSI7eRU7taKAQfTwg?=
 =?us-ascii?Q?1iS+6234OpxmbPJZ70m9//4O4SDxTiqO/O0zWIMgmCIMftbVi641xD1Q+kRN?=
 =?us-ascii?Q?xEPb2gxv6EvS2loEmL7phnJunZYjLex55aOs0xAHhmjUCNH5WMLjA0ecZJhK?=
 =?us-ascii?Q?l3cX1/uolWvNYHPPdmP1JQaZLEyLzBtfhMegONYSK4Uu+n3rWvmQL3jUT1t5?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 069b1223-4b19-4b5c-a8a4-08dd8ca87522
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB8248.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:15:30.6458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+f5kEC9ZuHJz7woZjYlecbRGh+AHttJP80m2CcnHqm/MDf/6fTXHCQq1yrorWP8nQQnQEJyyXpPN8+jSb11I9G/aikSupfFgAtF4kE5Xpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8208
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


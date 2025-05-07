Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E277C3ABC0
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 12:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0223D8212F;
	Wed,  7 May 2025 14:12:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="dr9P/zz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACD7C81F32; Wed,  7 May 2025 14:12:56 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FFEA8212F
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 14:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0gYtT1P0KlXFNOx+uq9VD6eoMacV+ySGlLANsmpJ4qC7VvhqjhBmr2JyKhR/IUey8cn7futElMiCNxQkuoQXwzU3U7QZVHCphzW+2AA7jisMSIp6nHBKf1VzkpENbzwIFyeZB2EsR0sLJAYAo5AI1yjpT8Lf5W20V8qqNl8I0VpoQLqGeh1+T2qbUPXQCdFa3b8PAKgxTYuXzYfRCdenC5uU1uxbkwWnI9DrTmu1eNRYEtTUn8A0LezybdQeE73022mUYspYwolD5E2IQrWfDiq2yiCH4p+BMaNPX9x059F70xwWN2ReEgTNrSKHpb7tZ8aNWfNrN1XYhNiqSjHXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yCV7vdpfsmQpYnDYm90YyCMYyK8u3PsB01Lgyv80yw=;
 b=ewqVpVycgsh6cud4QnhAaFdV/uqzEZjHtOxgNZJD+932Ufe0oie/snrZA6j7dFKf/DffhDK7y1SMkTguGCb/Dn0nxo3O2K0oVsMON40HGZlPrSTzYJ7plvK3Ma2IwFz8MWkSwwwg4+uBazD1H+trAueQhx3arl3Zs+qz1gLEZj3kzi8a6Kmpn3GaWU8lXUvgsJ26sMWkpL47gOFLR3mFZ6A3olZctiq1IQ+PUe6JEuo2UVNiDQktRCt+1HmDCLmhn1wrHax+FIcagq0ob7ED258+fCC1TtwyCMllDwFka8DIz36C9jECfgQAWZ02jwZkHuu+v5Q98a4jT0YRt50g1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yCV7vdpfsmQpYnDYm90YyCMYyK8u3PsB01Lgyv80yw=;
 b=dr9P/zz7p16DAIGG4y2BSeojm1XTpDDl0wieP/GpoYabyIHU9h8q6gN6cuTd5SjXvUaR4CIteP/716AngBlrM5F7VTB8gkvocXstPiTBeiCMgc/Ev6Fk/PzKZsze4bJK7Qi5t65TNqOLPfGxbCVTxLDxwawLoPvn+Hrmxs5M5AM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS4PR10MB6014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:51d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.38; Wed, 7 May
 2025 12:12:51 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c2c9:6363:c7c2:fad5%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 12:12:50 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.denx.de
Cc: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 1/4] linux/list.h: drop use of prefetch()
Date: Wed,  7 May 2025 14:12:43 +0200
Message-ID: <20250507121246.518691-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507121246.518691-1-ravi@prevas.dk>
References: <20250507121246.518691-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0028.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:a::8)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS4PR10MB6014:EE_
X-MS-Office365-Filtering-Correlation-Id: 89cfc1a9-43af-44a3-3de2-08dd8d607cb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3w7RKqXDPtQn1y9DIVGK0bLgHCTplYZMVnw9gvvxQMD//pg1VNrESEOmFi/x?=
 =?us-ascii?Q?csHGXHArzUvItEWZNFcjgYdb5Ral4Fl0x1b+hrHBE0ldEO3T52jc3+UcrgHQ?=
 =?us-ascii?Q?Em6I+TSPlVk5webRIy/QZk7YtZWtZBS6fmi4MTm/wtXweNGxiWQLKWtkfWcu?=
 =?us-ascii?Q?LQHdaTOY14xoI2JqblIRX+SJSCl5xq2t3JIzEjcQTFfBeBHJF2yDvrAOwJHO?=
 =?us-ascii?Q?q3Z3i0nlJXYLM342cNwpGKWzbcMqGBPflnwVYq4LAAkyy8qCv6HI5fs0BU8c?=
 =?us-ascii?Q?ZEjx0cG/52mUwagRitsxsRZCY7JHcU36yXnj80ZKzLZxPjG8Wk2bdIYCIVUZ?=
 =?us-ascii?Q?qCqCL7v1WG17cp4FhyjAV7IoApJ0NAvMEUapXUZ8j5OepjhRwO0FMJAe200a?=
 =?us-ascii?Q?Uu1yNLhuo7gvaP6P+zt/wxvcH5LJSwDaZyXhYsRhAN0yCeMz0YQ5qpfFu599?=
 =?us-ascii?Q?r11ovtyIi8OIMI1iKpmwfgRzhLsepsRH2MlOCSyPDARr0ILDMyANfYeEr1HW?=
 =?us-ascii?Q?gPjE0KqhW941aQcETzMLlzpN7kuflHFPlouR/g1wqmE6nM/fTs+LixUDSvn+?=
 =?us-ascii?Q?9w/F83n9DdywhdtFVP0moW8yCXny6GT32GNQRnxc9q6FaaAuh7Hs9v3sNwQA?=
 =?us-ascii?Q?5HITS90yfRxPtZOGPkDpp1904GXArY1KzmweRn9m+gdaWULD+xD88bh8pSM9?=
 =?us-ascii?Q?o8DIxUnMD2DOTJsejO9GnuE3sDDMxWfRNKBt2nDG01aRwJhl1FnMLKJf8Jr6?=
 =?us-ascii?Q?cWzTyRqKJ5DiAezcUWfs0tnrya44xki8mfsBc6EA5Cswt4PyjKGXzInmrZA/?=
 =?us-ascii?Q?PJLoBN1KgE3Rfj/y+PRx1OFm0baFGg+oNoBBM3E/08xj7TgATf3xGpod4ucL?=
 =?us-ascii?Q?TD6WrFGj5gi1sCxJ6zjBEjLBikJg3idQMMwoiKSCwv+eRZG5oCwtrhL2H0s2?=
 =?us-ascii?Q?GjOynkTAz86uruWtlHio1OutFI3eWdzMhXtnhEzihngOya+ggeBzFreyAYb+?=
 =?us-ascii?Q?tJVDpNCgafdTomFw28/aBPg4X6bQtn4VCoJ+HGmcCReCaUaG98mxbMt0TaXR?=
 =?us-ascii?Q?skkSatZvnV/wQSSBNndYdqPKuXW7Cu70dqXBEKz+ZbE4b857F0mNe6ZAHdhn?=
 =?us-ascii?Q?qMfs7prRA6ORsJa6/moSgbofNwCyUg0UwkaZLNuXK+RC75O+bPnm9IFV5UEq?=
 =?us-ascii?Q?BraqhDZs6AhJ4sSvBCFefCWDIqSU3lAfY8SFE/N3OBy5IcAdksG70QXsx9z6?=
 =?us-ascii?Q?/KUaxj7+Lvx8gQluxzcvqZgS0StYAHnmRKervXBngUabkeVI3FvrumisxJ0J?=
 =?us-ascii?Q?Nfl6rZ7w2uWcpwYzDo0bsbYenUccAPZsS/sp79MRSMPOLcEqXkOx0sek2W2p?=
 =?us-ascii?Q?I0jjtLoNBWQdn3jFbuRcC1uMg4FuukCWL2wX6ChFlHpeLDlprFLpxuYfPO5S?=
 =?us-ascii?Q?g4OdRZ45calsjLcpRKAXwdbgdWEC2zkyf3xiwKVy8VS14Y939iZL1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6BceqMquR8Pkjtuc07fRYmRX+IDK7Ynx5dmMahAvlRUakKsVUN4wV85pHCx8?=
 =?us-ascii?Q?CLcKVX3ReZXdD2Kq59w1zTg93TUUqib+OWORW7j08vODX7iSSYl3XUGmjdXO?=
 =?us-ascii?Q?Mxg3zu6blezgnFQYbSTsV5Jr/4WSBjpYCxPfwKTDvC+AaPNIdXLZQZaaYzj+?=
 =?us-ascii?Q?vgrTVr6pkQ5VXWv03mDEfv4M6t/p8DUFhnx7vSyBXK0HIC051eAd7sFDlkI0?=
 =?us-ascii?Q?nlLJ1lBEsd5V7+dO5/L1wwjXvF5ADFYRaKZuZ7OG5nWwqYBdnxASaDoqIzJ+?=
 =?us-ascii?Q?62mIM2gLtltBxJHK+o9sDLv+/ZZaAwZd0hf+j98/xF/hI53FURDtG8LEmyal?=
 =?us-ascii?Q?m+fhJbNQ9dqTLk+JtPnOGdR50eBK2nhCguv0OEf69u24xskn7k16z/tD++RN?=
 =?us-ascii?Q?T1RPnE+Hu6ugbp9PXrIqg6WYEIPDyA+svQY9lAfzP3r9euNTVt0LQo8AmfcI?=
 =?us-ascii?Q?zYbCZrVqvg5n8mCi1tSeHGWBTq0FDpVuFBKULvVZvjzjcpS0DIKV9OVd33sv?=
 =?us-ascii?Q?g3MMHvgxuymAg/Ku1NyIq8++rTf+L1IYlWXi8mKVAsajAxZnRK58PObMUVdo?=
 =?us-ascii?Q?zBtctKvV3XfHoeRapAsZD1f8S5dWsExPjXysG923wQSXcQnKv4mlmmwCKKF2?=
 =?us-ascii?Q?3uBGPLJ9rvgL8vbEjX/5CwRyerRH8QSVbY9t3L8PIn9ZIMqgKkX7XAOEqAay?=
 =?us-ascii?Q?RaLowpOs8ZArJup4KiYNSptsSEdnTINypANNxYhyu+BYMRPPP+1UmPBaW6uN?=
 =?us-ascii?Q?Hxzb25E9Vx4Xi2/8YOid9XuvjVSWCqhNmpIgud06KgIpi8JSXwdKY/ag87Bq?=
 =?us-ascii?Q?BTl2ksbZvAD/5qs+fPo0lqDAcZ3lgUsVdcK2HZ/s7pcZrhVQ5fHcKNMSEd74?=
 =?us-ascii?Q?fzR2KDWYgsKrSI28MD5Sj4IzcvIlJiyb7UGcCGucq3Vy9QIC0wyQSOyoTdgb?=
 =?us-ascii?Q?3ytekq2bN5yu0LBELKiQtnvSTKrS87i6iRrdNR2osoWmEh4qRG7+t1ejhziF?=
 =?us-ascii?Q?3J6Dj2HiW5IcUzkNy0Pg6h3bsIfv2E49o2Uz1padlZQ4eYPPCUrR2PpnYyge?=
 =?us-ascii?Q?qA5xCCWlVIl0Yo+wqqGoyWhGAPUBQPVQKyDhfPJcaocnaHx+42YJNdcRnfTx?=
 =?us-ascii?Q?VzkUPBWBNlzj1pGD7i7Evh9+ba2TYeHWBVvqM5bGWVaE/E/p6AozgB1jWGKe?=
 =?us-ascii?Q?Palqt3aYOHCjkeOfdxEa/BHrnqwXqlfcq6DnNVVFCKi12THnXcasQgG9Bb5i?=
 =?us-ascii?Q?VaYT1LMIvJbUdrrh132ESPr28E6OxfELbuGSE6bshqdqpxxAzZG591C6RkQI?=
 =?us-ascii?Q?kiw0wbSBodcYAvdTCgq/b7jKUtgOzjmwAM+5pOXe/TG6AfRZytF/Azbh8xms?=
 =?us-ascii?Q?rwRa/+sMcZ5DoCcgpvb+8IJM7yONnlLiI46i3aDp8Yknm6GEBHbTystnl36E?=
 =?us-ascii?Q?kcV2QrEuSnk6drK4HqT/slnZ0IeZ0lBWlXXrNnM6IMEHuWpO67ni0cZEh027?=
 =?us-ascii?Q?tflVnzWfX1AyXPg3Em+XwJjiHNwZq9HDWa8Y0RR3dT2Y4lfuFgmfuU0ScF/0?=
 =?us-ascii?Q?Ew3m8F8cK0hDTtGqtqfNx9veAvx4+tSkGf826LSfda0HvFN7simvx3IUWW+v?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cfc1a9-43af-44a3-3de2-08dd8d607cb3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 12:12:50.6920 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/OxsZGgbQw8E86GPDKbbyZjp23P1aiq6X7vuFQS3X2iORVKxGji4qikOA4bevSKXxooOiN+sAFauOFlv+oyUvs3t8KnW6XYZ6U1qd4lM70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB6014
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

The use of prefetch() in these list helpers was dropped back in 2011
in linux (e66eed651fd1 ("list: remove prefetching from regular list
iterators")). No arch in U-Boot defines any actual prefetch(), and as
the referenced commit says, it's usually not a win anyway.

Whole-sale sync of list.h is not really feasible, but we can
synchronize the macros containing a prefetch() with their linux
implementations as of v6.15-rc5, also importing the various helpers
needed, e.g. list_is_head() and list_next_entry().

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 include/linux/list.h | 99 ++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 40 deletions(-)

diff --git a/include/linux/list.h b/include/linux/list.h
index 0f9d939b05f..e21ae03b208 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -169,6 +169,16 @@ static inline int list_is_last(const struct list_head *list,
 	return list->next == head;
 }
 
+/**
+ * list_is_head - tests whether @list is the list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_head(const struct list_head *list, const struct list_head *head)
+{
+	return list == head;
+}
+
 /**
  * list_empty - tests whether a list is empty
  * @head: the list to test.
@@ -363,26 +373,28 @@ static inline void list_splice_tail_init(struct list_head *list,
 })
 
 /**
- * list_for_each	-	iterate over a list
- * @pos:	the &struct list_head to use as a loop cursor.
- * @head:	the head for your list.
+ * list_next_entry - get the next element in list
+ * @pos:	the type * to cursor
+ * @member:	the name of the list_head within the struct.
  */
-#define list_for_each(pos, head) \
-	for (pos = (head)->next; prefetch(pos->next), pos != (head); \
-		pos = pos->next)
+#define list_next_entry(pos, member) \
+	list_entry((pos)->member.next, typeof(*(pos)), member)
+
+/**
+ * list_prev_entry - get the prev element in list
+ * @pos:	the type * to cursor
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_prev_entry(pos, member) \
+	list_entry((pos)->member.prev, typeof(*(pos)), member)
 
 /**
- * __list_for_each	-	iterate over a list
+ * list_for_each	-	iterate over a list
  * @pos:	the &struct list_head to use as a loop cursor.
  * @head:	the head for your list.
- *
- * This variant differs from list_for_each() in that it's the
- * simplest possible list iteration code, no prefetching is done.
- * Use this for code that knows the list to be very short (empty
- * or 1 entry) most of the time.
  */
-#define __list_for_each(pos, head) \
-	for (pos = (head)->next; pos != (head); pos = pos->next)
+#define list_for_each(pos, head) \
+	for (pos = (head)->next; !list_is_head(pos, (head)); pos = pos->next)
 
 /**
  * list_for_each_prev	-	iterate over a list backwards
@@ -390,8 +402,7 @@ static inline void list_splice_tail_init(struct list_head *list,
  * @head:	the head for your list.
  */
 #define list_for_each_prev(pos, head) \
-	for (pos = (head)->prev; prefetch(pos->prev), pos != (head); \
-		pos = pos->prev)
+	for (pos = (head)->prev; !list_is_head(pos, (head)); pos = pos->prev)
 
 /**
  * list_for_each_safe - iterate over a list safe against removal of list entry
@@ -411,30 +422,39 @@ static inline void list_splice_tail_init(struct list_head *list,
  */
 #define list_for_each_prev_safe(pos, n, head) \
 	for (pos = (head)->prev, n = pos->prev; \
-	     prefetch(pos->prev), pos != (head); \
+	     !list_is_head(pos, (head)); \
 	     pos = n, n = pos->prev)
 
+/**
+ * list_entry_is_head - test if the entry points to the head of the list
+ * @pos:	the type * to cursor
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ */
+#define list_entry_is_head(pos, head, member)				\
+	list_is_head(&pos->member, (head))
+
 /**
  * list_for_each_entry	-	iterate over list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
-	for (pos = list_entry((head)->next, typeof(*pos), member);	\
-	     prefetch(pos->member.next), &pos->member != (head);	\
-	     pos = list_entry(pos->member.next, typeof(*pos), member))
+	for (pos = list_first_entry(head, typeof(*pos), member);	\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
 
 /**
  * list_for_each_entry_reverse - iterate backwards over list of given type.
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry_reverse(pos, head, member)			\
-	for (pos = list_entry((head)->prev, typeof(*pos), member);	\
-	     prefetch(pos->member.prev), &pos->member != (head);	\
-	     pos = list_entry(pos->member.prev, typeof(*pos), member))
+	for (pos = list_last_entry(head, typeof(*pos), member);		\
+	     !list_entry_is_head(pos, head, member); 			\
+	     pos = list_prev_entry(pos, member))
 
 /**
  * list_prepare_entry - prepare a pos entry for use in list_for_each_entry_continue()
@@ -451,41 +471,41 @@ static inline void list_splice_tail_init(struct list_head *list,
  * list_for_each_entry_continue - continue iteration over list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Continue to iterate over list of given type, continuing after
  * the current position.
  */
-#define list_for_each_entry_continue(pos, head, member)			\
-	for (pos = list_entry(pos->member.next, typeof(*pos), member);	\
-	     prefetch(pos->member.next), &pos->member != (head);	\
-	     pos = list_entry(pos->member.next, typeof(*pos), member))
+#define list_for_each_entry_continue(pos, head, member) 		\
+	for (pos = list_next_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
 
 /**
  * list_for_each_entry_continue_reverse - iterate backwards from the given point
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Start to iterate over list of given type backwards, continuing after
  * the current position.
  */
 #define list_for_each_entry_continue_reverse(pos, head, member)		\
-	for (pos = list_entry(pos->member.prev, typeof(*pos), member);	\
-	     prefetch(pos->member.prev), &pos->member != (head);	\
-	     pos = list_entry(pos->member.prev, typeof(*pos), member))
+	for (pos = list_prev_entry(pos, member);			\
+	     !list_entry_is_head(pos, head, member);			\
+	     pos = list_prev_entry(pos, member))
 
 /**
  * list_for_each_entry_from - iterate over list of given type from the current point
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Iterate over list of given type, continuing from current position.
  */
-#define list_for_each_entry_from(pos, head, member)			\
-	for (; prefetch(pos->member.next), &pos->member != (head);	\
-	     pos = list_entry(pos->member.next, typeof(*pos), member))
+#define list_for_each_entry_from(pos, head, member) 			\
+	for (; !list_entry_is_head(pos, head, member);			\
+	     pos = list_next_entry(pos, member))
 
 /**
  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
@@ -654,8 +674,7 @@ static inline void hlist_add_after(struct hlist_node *n,
 #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
 
 #define hlist_for_each(pos, head) \
-	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
-	     pos = pos->next)
+	for (pos = (head)->first; pos ; pos = pos->next)
 
 #define hlist_for_each_safe(pos, n, head) \
 	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
-- 
2.49.0


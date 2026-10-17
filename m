Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7803CCF2CE
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A835560744;
	Sat, 17 Oct 2026 13:01:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rVN1mtTdnGyL; Sat, 17 Oct 2026 13:01:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org BEF4A6069A
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242106;
	b=f0Svb4t3bCMrvnJHf0kUO8QU5vHay1CH3SXMGhaBpWmNd9YH5CLCNwKaJrFDb39xhJ2r
	 HgrM2PI++kOlbCJ5JLV8YMcYfLsKDhXa6mFMCFMueM6laOxDKgBMDaLNUUW1kxYR7FYe9
	 82phP0uM8T6ojFj2dwn4mN1sf7HASUFCDFA5hNnhr1afQ9EzwW9IbQDQNccT3U5+KgFT4
	 gLTlEVCDPzxC9sjVOyfgBLFeiyklyIVzYP71lWtfvzIjyiFJ5Y5z8x8WIEbJs4HYs6ebg
	 8YAKyRkS7UFnBEL7XAYL+voXXbl8Wc/RMQmXZNNRdZHfIBDnDcaKePYd2/pFcu9BpVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242106;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=0R94q2+Ygp5NyytvTFxH8/NTZyveKZ7MEACjWQJY04s=;
	b=Ad0eZ5VTTh2N/QQGurhV6R9Bjc2YCkaVEmGrrkoK1Y8GQ/hLkvRH+XXDy35nhBEAZDAD
	 6p3UseqRVZt3BbmzZPe89hWn1qx3cusVQH53Ssz7B9/FiYo4pfsP1C6eZWPNqt1IqWFN8
	 6fqYQLfQ1ni5OTUoCT0ELCk1fNkSt5Z1NucZYYgufa/EIMmHNoIHLia/+48YgrlHWftsy
	 xB/pcmEoLfnxsrCpv+zeVOoNlDcwIKuyThLsu+lfqy1HyCLqA/GSkClZFHMwr8gn/9CeZ
	 PtiCy/4yZnTObW3Q89OglH9SjI7V65XPDg1W/LWkb3XjVy/rvGNmTpvxQBwA6U+KsUQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242106;
	bh=0R94q2+Ygp5NyytvTFxH8/NTZyveKZ7MEACjWQJY04s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=afX5474PjKVYobcs7/Wbmy1PIFlVesLUX/9+wh/i+pu6obD5tsyUCr9pof2N/AQmY
	 zkgDWXs9ZlVcCnGvZ4Kski3C+eI9k3n9f9AddaWYfuoziKTCBg3uBWVtnIrnekNu+u
	 wjXxATWdksM6KPDI+Gc3bJvfNM6TkgE5E8WqcMwIAYp1cu6edFAE+R2XWeDk3t6MXS
	 E4xDFUyJsaErt3e2ruOjFoY0Tgtbi4itcWWdJxzNGcmaY+2/EVpSR0jMhjv/DBCz3f
	 U/ZejNKStZ5gjLQ6aNVz3TNV8okNJEZ59HvY6I1ouAK3AgX82x44GtjuKiNv1Vcdr1
	 8r/tJo+zmBuog==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEF4A6069A;
	Sat, 17 Oct 2026 13:01:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 571FE7AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54F3281324
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4QZKHI-rJ5Qb for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 766EC813DC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=eO7ohbbDOcpPYXmnr+xPtJH17Je2xpVVV4MwujAXtyHzk1YX8YT0Rg3k29ao/wpG0Y3e
 se98oA+KwJ7aaZGO/sob8Hd4og7Gwh8iX0JbA6QUXvFdApqCyFC3xRjAsCLq+a9j0JPi6
 xMAF2FB7WRGac1ZcRvnUfy+2H/bYKMTaPqPjHuUrOdh2CIzRWQ9740VGOoukJ8lK40/+K
 GzI0tqtcLiz5QzYlphCGp2QiNZ21vqvb0C6974BshQLyWrZCuHDOnlpX5QXo4UEJItSKK
 7uP0b1MyYPagWvH3IfCp3Fzw640MQuYKWunhvA5r/yCXj81Q/SFMubpzfMirQLV/QhA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=0R94q2+Ygp5NyytvTFxH8/NTZyveKZ7MEACjWQJY04s=;
 b=GfB0bV73Fbcqxuupd2mVw4aKV4XdRxrn7zMcGPUEWaY6fFqO+U9RkZ6p4hxJWD7Uk46w
 Q+AkLKLmjdOcxDJSWupI6z/nA/rXTI8aPi72spEwt967DBOfAARtzCBpW01VwRMn1aZj9
 xpv+rHwjmAw5Mzksqv20uZKKKbf6uZ3M9H1szQ6QAh/++ic2LAISIJmaqHimXLnta2l5C
 mNL4So1IhhZRG5mYCHnwuKPOmZT0qGxVu3zDfJvrd1cbiGMChtrXSYO41+qBYpTHnVnoB
 /ZcpmqD9cyLd4aKuwxQq6leHGGwAM5DdhPMtHrUzjQDuI9Pm5j4ATtz3vx4eOubr9HA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=l3yEYoIg; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=l3yEYoIg
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 766EC813DC
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8745560A99;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37F0DC2BCF5;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=Pz4Pez24jSyO8gqNt1+bN2MTi6Ny9IwiScc3P08yE1w=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=l3yEYoIgalF8PZesZ55iDfCZG46pu/BPrp+W/3vBBTZZ7J1a4a7KW4ugI0M6t9dzk
 J6ZLxQrkj9eYf40nTFuutsu26dZENKkRXX/e0ULbfOyHqNm0+r1P6ro+sEe8QgDGzH
 31tTOwK8mH+liyQe6zQzfKKN5vsmndtHolRluCt8dNv3J2g29ZleILwJ5uge2qWKy4
 OoWuwE4GNb8EnmYXVSTChoKIa3IFonRVx5DqZlFloGQLA2Exbia69ttEHASXbfLVUm
 KmgRAo8UllzzVmDKC3Fulxh0FaaK+GeztKVYr9N5LbnmzkReJPu8SYiMPIGwzY7744
 hyZ2AxK+uiQeQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 256C3CCF2C9;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:19 +0200
Subject: [PATCH 03/14] expo: Allow a text object to have its own colour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-3-479ac06e7642@protonmail.com>
References: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
In-Reply-To: <20261017-b4-expo-colours-v1-0-479ac06e7642@protonmail.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Alexander Martinz <amartinz@shiftphones.com>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Petr Pavlata <petr@acrux.cz>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=4372;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=UPB0LHVZw5Jb28TCAoxQMD5l5dcBNqsaNcayOVg/y+U=;
 b=ObGaBB2Zl5z90ccG51eijn73KEWv26yRQYsruCZx0UNiIKvpZCSJndzoJyc2lqCCYeL9YjEXH
 abUffo5JBQTBk9kU8SFZ5no2ol4sQzUhZIRqliy5/aNDpVFO3vCudrh
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Sat, 17 Oct 2026 13:01:25 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: petr.hodina@protonmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Petr Hodina <petr.hodina@protonmail.com>

Add scene_txt_set_colour() to draw a text object in a chosen foreground
colour, on the normal background.

The colour is not used while the object is highlighted which keeps
the reverse-video bar.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/scene.c     | 22 +++++++++++++++++++++-
 include/expo.h   | 17 +++++++++++++++++
 test/boot/expo.c |  4 ++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/boot/scene.c b/boot/scene.c
index fa8f540bfb0..6073ab5a9f5 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -245,6 +245,19 @@ int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 	return 0;
 }
 
+int scene_txt_set_colour(struct scene *scn, uint id, enum colour_idx colour)
+{
+	struct scene_obj_txt *txt;
+
+	txt = scene_obj_find(scn, id, SCENEOBJT_TEXT);
+	if (!txt)
+		return log_msg_ret("find", -ENOENT);
+	txt->gen.has_colour = true;
+	txt->gen.colour = colour;
+
+	return 0;
+}
+
 int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 {
 	struct scene_obj *obj;
@@ -526,6 +539,7 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 	enum colour_idx fore, back;
 	struct scene_obj_dims dims;
 	struct scene_obj_bbox bbox;
+	bool tinted = false;
 	const char *str;
 	int ret;
 
@@ -561,6 +575,12 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 		video_fill_part(dev, x - inset, y,
 				obj->bbox.x1, obj->bbox.y1,
 				vid_priv->colour_bg);
+	} else if (gen->has_colour) {
+		tinted = true;
+		old.colour_fg = vid_priv->colour_fg;
+		old.colour_bg = vid_priv->colour_bg;
+		vid_priv->colour_fg = video_index_to_colour(vid_priv,
+							    gen->colour);
 	}
 
 	mline = alist_get(&gen->lines, 0, typeof(*mline));
@@ -592,7 +612,7 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 		vidconsole_set_cursor_pos(cons, x, y);
 		vidconsole_put_stringn(cons, str + mline->start, mline->len);
 	}
-	if (obj->flags & SCENEOF_POINT)
+	if ((obj->flags & SCENEOF_POINT) || tinted)
 		vidconsole_pop_colour(cons, &old);
 
 	return 0;
diff --git a/include/expo.h b/include/expo.h
index 3127b4fd5f2..ac7644d8392 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -12,6 +12,7 @@
 #include <dm/ofnode_decl.h>
 #include <linux/bitops.h>
 #include <linux/list.h>
+#include <video.h>
 
 struct udevice;
 
@@ -352,6 +353,8 @@ struct scene_obj_img {
  * @str_id: ID of the text string to display
  * @font_name: Name of font (allocated by caller)
  * @font_size: Nominal size of font in pixels
+ * @has_colour: true to draw the text in @colour instead of the default
+ * @colour: Foreground colour to use if @has_colour
  * @lines: alist of struct vidconsole_mline with a separate record for each
  *	line of text
  */
@@ -359,6 +362,8 @@ struct scene_txt_generic {
 	uint str_id;
 	const char *font_name;
 	uint font_size;
+	bool has_colour;
+	enum colour_idx colour;
 	struct alist lines;
 };
 
@@ -803,6 +808,18 @@ int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 int scene_txted_set_font(struct scene *scn, uint id, const char *font_name,
 			 uint font_size);
 
+/**
+ * scene_txt_set_colour() - Set the foreground colour of a text object
+ *
+ * The colour is ignored while the object is highlighted.
+ *
+ * @scn: Scene to update
+ * @id: ID of text object to update
+ * @colour: Foreground colour to use
+ * Return: 0 if OK, -ENOENT if @id is not a text object
+ */
+int scene_txt_set_colour(struct scene *scn, uint id, enum colour_idx colour);
+
 /**
  * scene_obj_set_pos() - Set the postion of an object
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 5ea8c016706..19148a8892e 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -898,6 +898,10 @@ static int expo_menu_header(struct unit_test_state *uts)
 	ut_assert(scene_menuitem(scn, OBJ_MENU, "item4", ITEM4, 0, ITEM4_LABEL,
 				 0, 0, 0, NULL) > 0);
 
+	/* a header can be tinted; other IDs are not text objects */
+	ut_assertok(scene_txt_set_colour(scn, ITEM1_LABEL, VID_LIGHT_BLUE));
+	ut_asserteq(-ENOENT, scene_txt_set_colour(scn, OBJ_MENU, VID_RED));
+
 	/* the first selectable item is current, not the header before it */
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(ITEM2, menu->cur_item_id);

-- 
2.55.0



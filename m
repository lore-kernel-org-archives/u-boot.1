Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F20FCCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 326FE813F9;
	Sat, 17 Oct 2026 13:01:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 35QVU1IB2YJl; Sat, 17 Oct 2026 13:01:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 56293814D5
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242103;
	b=aQFjpkyVSQ6CAwww0DIlzV/Xle9Cg2ZdYENDaV3D9Wx5SlZxv/K4oToOTHMuNqKHk6W3
	 cBvAheY1AgB6hquAlAkz5jC9pK5ep5lZf4Qax96R5II597CWqi4IfTKsqxq75Fug7WfVj
	 pl+JNhwD9wNk20CXtiXekNCgBOT1lCqEQabiHaEJ5o0actIGqL3bUJi7gz5zgo29/GVWX
	 p6DHB/lzOS+96Fj9wbqgsBmwyNHJdWb4RKDE0MEjiVT5rC4+GWL4pv0PQagbWz3/RjYzi
	 9/IPW5d7tYztLKzzE0tqu1W4sg90CWd/AQc9KEnTIfjlf09eRPKfC4ndFX36tcVcitw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242103;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=HSvtBAgGL17IHqekyqgGFDH+vazL+tpzZwUC5VozLNE=;
	b=lkDwuis/4aWq5ginwrBbmL41bSJML+SUazTEG6I2xxQ+fRaS0GLnVPjEjOk8sgW+HsSn
	 jrUF2qbsPqhfwhwyPsxCyKbJRzdT/F98jEaHTU+QKxepkV8yGNQHGfmemo9BSCKXxX4Nx
	 uKy8kPtBxHlyrlEyxggYm/n+Ux2iafNrlpxu6+uBuwcUYUO05XVZxdBwiZgUEH3tNwrvt
	 uYWoCB+Nhy6S40YzWGvHp/BBRhrLsKzzY7gvvL1z113wBJjuZn42RcCxmTbSt5tr1QcOF
	 w8adsoFJqDY/qiNVZAzfFIKcuaNdqMYpoMEEC+xayKu2igyzy7ndpJbT18JXfYYXC1Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242103;
	bh=HSvtBAgGL17IHqekyqgGFDH+vazL+tpzZwUC5VozLNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=aFyykagscaEO8w93CVbvto5CWn6ZKunDb4jr6R3mGjbvgCXV97Y7zfItyoH4WoZOt
	 v4Pp6LJSv7NcOuESLnwC+MXfFimO7SdQ23nL9Wx9bq5Tnpi+rWouuG+xkkbFghCau1
	 rSugH9D6NYKu5olyn0T3N1aOh+LuZONIvNP3D/hf0EdKX+MR9nvwc74caukei3gitV
	 D+N5JsAZupdtEddjZqA5q166pSCuiYWc8SVQ5gQeCAxk3/QPXlBbOA1KIXZIs/2rLk
	 qvI2PWwl4AAE22I8cGEGzySPat/PHcvgJz+R4fKnFc3iOnOxc1MA8eDy6biV6HPhsc
	 x0tliO8d87wtQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 56293814D5;
	Sat, 17 Oct 2026 13:01:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1EB02F45
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0DDD3409D0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P4A3NTpnleZ6 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4505F409BD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=fjns+V7FPJbpybnrrPgfNmvkdV0kwanpWX7ClxjvWuNyQD2XGP++8/ccYYunJ065oPSE
 f+WHCNLsFCNzpefH7mgItcF3WA7UvLaxoYfhZZQFm5dWc7lXo87swWI2klp1Cvx21Shk6
 JPh8wbRrSBH5qQJMxdCpJd6Fmi9+kE+q1sZVWSdFSYM9e3h37cpGamTQMwHjjR6n9W7Lc
 YAgzjCsEcaeht2jdn8B03Eo+7giwzPMJab0/f4iqjESvjbHNvAaxktCuBb0yD2bQtiRDH
 PELPWJdMma3emkpAbCP8AMtea+rz5klcoxfbD3z9im8bT1MlxU/QFDQGKSXD/Ezn71Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=HSvtBAgGL17IHqekyqgGFDH+vazL+tpzZwUC5VozLNE=;
 b=D1uQLi8LPhygZBYeJTjMK7UyanfUTaWjJ6LQ2eftrDNkV/AxvIK2Vos7C1m74zVuQbYp
 +W5PkgIMEFm/JX7zyjMEOjpTXL30kslgDsYKHahSaFSrv+QtOi5dMBq5mxXT2CdogohSU
 g671NHc8SVoq/E67ytGN/TjLO/5kEgCUl9CqCechEOJLW1UzlmgccvWq43deWH+uGf1jO
 7zC8081TLC5UkjWqDACCCilRrEpkXSs9O6VL8VusTrzIXt7XY2WGqLxHRJ2dtobNYLbAU
 YGyyXotnb6LpzN/vcMqOvmz5kde9T/ylXB+8qE3cAdJXhUgRsvNP69CA+qkykMFizlA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=DVyfkQtD; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=DVyfkQtD
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4505F409BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9D96743C56;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82FA4C2BCFF;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=zdWKUVvs+IAr7cxzOc4dyX3J0Ao0Tb6Two2zQHP4vJA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DVyfkQtDUa72Rw90ocIIuhKjgYHpylw8/W1+vfFo6QGOFrBnYIwqqYomVXJzW/myj
 ++JnfBMQrVgvoBlPZwSsrfnL7UzKyZBTA+ktq1atfLlbdospJRnHDtekKWEH9T32FS
 lXfFQXaALKWCFIDR5ML8FZuPuB9e0ycFK0au4o8UxxCexzHvm8LZsw9SAbORW4/sqL
 MRzXvQY6tiTw1UHtSrfiq8RePlvJN238k8P1r36f95pdqY7vmndP4syiN+lOubLz7L
 BJuDH+jeUebIe95FrPYLOen9qD545DuFcH62NEzVxRKay98mPW+/04xQ/dr7FASYuL
 O42O7Tau7O2/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 73F83CCF2C7;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:23 +0200
Subject: [PATCH 07/14] expo: Allow the background colour to be set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-7-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=3612;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=/5HgJCOGqNFJiafhkd9vG8WjoIN4LkQs0IKPtMQSRlA=;
 b=8NcSkgFAHMavsqe8g8whVn9asAQ6BI0L075nXfqQjDjfvkpIzM6FmL9lc5ZpWKLjyf8H+vEQg
 d5g6HpWWupGAMu3dtWndwsialltS5k3qenljwE1UqBnJN3eGJVAZKOU
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

Expo clears the display to black or white depending on the video
device's white_on_black setting.

Add expo_set_bg_rgb() to use another colour instead. The colour is also set
as the background of text while the expo is rendered.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/expo.c    | 42 +++++++++++++++++++++++++++++++++---------
 include/expo.h | 15 +++++++++++++++
 2 files changed, 48 insertions(+), 9 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index 94413acd381..fb67a80a29f 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -215,30 +215,54 @@ int expo_render(struct expo *exp)
 {
 	struct udevice *dev = exp->display;
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev);
+	u32 old_bg = vid_priv->colour_bg;
 	struct scene *scn = NULL;
 	enum colour_idx back;
 	u32 colour;
 	int ret;
 
-	back = vid_priv->white_on_black ? VID_BLACK : VID_WHITE;
-	colour = video_index_to_colour(vid_priv, back);
+	if (exp->has_bg_rgb) {
+		colour = video_rgb_to_colour(vid_priv, exp->bg_rgb >> 16,
+					     exp->bg_rgb >> 8, exp->bg_rgb);
+		/* text is drawn on this colour too, not on black or white */
+		vid_priv->colour_bg = colour;
+	} else {
+		back = vid_priv->white_on_black ? VID_BLACK : VID_WHITE;
+		colour = video_index_to_colour(vid_priv, back);
+	}
 	ret = video_fill(dev, colour);
-	if (ret)
-		return log_msg_ret("fill", ret);
+	if (ret) {
+		ret = log_msg_ret("fill", ret);
+		goto done;
+	}
 
 	if (exp->scene_id) {
 		scn = expo_lookup_scene_id(exp, exp->scene_id);
-		if (!scn)
-			return log_msg_ret("scn", -ENOENT);
+		if (!scn) {
+			ret = log_msg_ret("scn", -ENOENT);
+			goto done;
+		}
 
 		ret = scene_render(scn);
-		if (ret)
-			return log_msg_ret("ren", ret);
+		if (ret) {
+			ret = log_msg_ret("ren", ret);
+			goto done;
+		}
 	}
 
 	video_sync(dev, true);
+	ret = scn ? 0 : -ECHILD;
 
-	return scn ? 0 : -ECHILD;
+done:
+	vid_priv->colour_bg = old_bg;
+
+	return ret;
+}
+
+void expo_set_bg_rgb(struct expo *exp, u32 rgb)
+{
+	exp->has_bg_rgb = true;
+	exp->bg_rgb = rgb;
 }
 
 int expo_send_key(struct expo *exp, int key)
diff --git a/include/expo.h b/include/expo.h
index fe20c68750e..61fec3d52c5 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -108,6 +108,8 @@ struct expo_theme {
  * @text_mode: true to use text mode for the menu (no vidconsole)
  * @popup: true to use popup menus, instead of showing all items
  * @show_highlight: show a highlight bar on the selected menu item
+ * @has_bg_rgb: true to use @bg_rgb as the background instead of black or white
+ * @bg_rgb: Background colour as 0xRRGGBB used if @has_bg_rgb
  * @priv: Private data for the controller
  * @done: Indicates that a cedit session is complete and the user has quit
  * @save: Indicates that cedit data should be saved, rather than discarded
@@ -126,6 +128,8 @@ struct expo {
 	bool text_mode;
 	bool popup;
 	bool show_highlight;
+	bool has_bg_rgb;
+	u32 bg_rgb;
 	void *priv;
 	bool done;
 	bool save;
@@ -636,6 +640,17 @@ int expo_render(struct expo *exp);
  */
 void expo_set_text_mode(struct expo *exp, bool text_mode);
 
+/**
+ * expo_set_bg_rgb() - Set the background colour of the expo
+ *
+ * By default the display is cleared to black or white depending on the video
+ * device's white_on_black setting. This selects another colour instead
+ *
+ * @exp: Expo to update
+ * @rgb: Background colour as 0xRRGGBB
+ */
+void expo_set_bg_rgb(struct expo *exp, u32 rgb);
+
 /**
  * scene_new() - create a new scene in a expo
  *

-- 
2.55.0



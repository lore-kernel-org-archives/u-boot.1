Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 400B9CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:02:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 077D681545;
	Sat, 17 Oct 2026 13:02:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id svHWJg2j_7Js; Sat, 17 Oct 2026 13:02:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3A56681316
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242125;
	b=M38GnRUQaW3CNqbnIeD8TtWd1oa/tIustKLzg6tYFj9xwYkBUJP/IAZ+hJdgZTwOu952
	 9fPOunqnoVOSlMTMkyu+5mYHvGNS38R8p6Uboi4tV9b7NmlGgLYuZGdIrQGenjZynPjpV
	 UvqeH5F05w7GkZdmpBfKnVlfTPNg/S3KMXPtkVRYPKs0OnP4ztCWBpczFWe+jePtjHDU5
	 GEsfZ5DfiUWCsT3vf0NTayyvX7Epn3jok09/lUKgXy53mKv66d/9zwaZVZi+5GFoAeW6m
	 TIqFuzuzf9jYdtsDrNdNhd5UZArNS6fBdEh9ozF0aI5c7YFaVkV1ISxk8WlJAWSAYCA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242125;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=k25g2tp32Z/FEZQiLQUV/ldrK99r0F/9GcL+PAIb22A=;
	b=IrCCJ6LR5ZyI+AxC0z/KjO1UBthMqPXXghHWS1O4NCE4UAtC92M/vLGvrbU80F//wo0k
	 KWFCyKI7X0fEzkyHHdM7Dx0PBOBCylZ5cLvQ6pArOmAlMintVqg1K2qNoZK7gVfAbpD5Q
	 enrE2+usnKuV5IAQEE+l38GOJyfKFH/t3W4nQkjuRWCyHIoIBoxVLjW9ql/xXKhpQlTwN
	 h7Hlgp5M+ZINpf7651Dttm4taE/FDJ1WKnYdL311LzC7VzSDo80YWeNH/CiSbwzCwT7Zm
	 ELtDk1NHLDliDGLCmQGtqKaGaG5ZRYGu9mXKE6EvCbOZSA6Tat7kd3KGdg0DYSjylRA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242125;
	bh=k25g2tp32Z/FEZQiLQUV/ldrK99r0F/9GcL+PAIb22A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NLL29liPUaWjvs0E8i8wYvEy7Nsz+mrwmGseC3rFod+92SRH1m4hOiURqRk7tV4cc
	 c5aCfjsb/wcsaR8BkllpozOfZPWkEDucO6obNsN9ADxnc4r1yQyQYen0Bosxj0PJIz
	 ruW4CwhzEgVMp+3QI9vI/8qf8+mOPfH4Kqv/5PDo4FpHKItexgCrg3JLGeSLTK8P3x
	 yad1bxtEsdoB97svRVBTUKdNu+jNcmjtLUjzmZUsrsNxX6xxQGYk/pf1EQ/nYuZMgG
	 yK0DtSsRbl3JjZnNJX4wV/3nu3OzAgIkW+1vjOHR8nWrt1x+kLBXEVRl7IpSfoYG3u
	 c9cSZgQgRSQNw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3A56681316;
	Sat, 17 Oct 2026 13:02:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8DE51AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF52A40122
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fqLYEbuM7OjH for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 24F9E40185
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228230;
 b=pdBVMt8vb1pqlNpuTOPMzFcpamPZkCvwqryuTpaovm8+dgdQpALYkvs2d1D3TE6xxMgK
 w2Yzoi8PCccFS4fgFczFlfKkeX5LkDORFp+YrrhgQ84weTrSupuaqkeGcXsT2tTq67rMm
 bGWbrTlwmmEt1lWFjZgWvfVOzcTL8MuWCNlNluTk6ZrHNcJAnIgeNeAiHR+FE0OPtpdgZ
 QDal2glLdBfwR5IOV/oqBB5aPJ/ybRjs4j0rr2tWT47se9urZtLm2UyrlYEeqfeljvdtS
 6uW3VtmzuuWZTYa17O8KcBKFPp0hhduFFfQR/yfk2sNxCsjmGBbwYl9plxpPVzEp4xg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228230;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=k25g2tp32Z/FEZQiLQUV/ldrK99r0F/9GcL+PAIb22A=;
 b=od2U6Ry+wzgpXAqTjxjNkRk0h0hu1o4BBHcN3sCEZl3QilJVOyEczVuGCK1lysW8kk6+
 OIqJEj+W47mnMZoYrcunNsWXPGw7Ud1rcgUB7uasi2L2d4vjMlzukLbyIYk1Lp2dhAT5B
 V5hUOCDecqu2cFv1TFow9jpraynbJbuJQIzdNj42inuv+fNPtYGS2/sQ/FumCFdGl5nh6
 4LxCqSrS/0XIem1KLjV9XKGmg2QtNxL0mTxPw0zBN0pX0X7rXf2MwLMVMx00FuSoRRgWP
 2tzYym0eepLtfy5SxNv2tbc1nkStRfO3rGu7+aZy5oWBFY54xhr9vgX0yGKW2RhTCXA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P4Cz7RvN; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=P4Cz7RvN
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24F9E40185
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2176B41A72;
 Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01DC8C2BCF5;
 Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228228;
 bh=wD5HEFjz5Yqp8vLQ7XbOiICDxw0GP5EY46hxF6ixjRg=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=P4Cz7RvNKUKEzGRi9CGkpsZFdAG6Vkji7X21G13SbWYRx/5SX/8zFiBcyvn4gTox6
 F2R7ls6kP7ClDWVHJiSiCwht48msFP6SOBkGO0VcmJUANWaPk5frhf/QD98Q/eDjaq
 l1QsPIDfkvN+aWr5Ub5w0N8NI0kmeg/wHqijLgAHC/SbhJjfToeAcFMp6lSSk4j5FT
 8ZS4oD2THkcN+U3L3lUe+i8/D9hjflH8WFereYIJbYYiyrRJF1pOloaOTmRAMxeQxA
 4bPKNuylVDl0WZglymAgcXViqXEE/RnIc47M3IbRmTmJZv1qZrbWwWmoWSWvGME+sB
 +2JYU/Hj5dqQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id E5C08CCF2C7;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:29 +0200
Subject: [PATCH 13/14] expo: Allow a text object to have an RGB colour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-13-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=3321;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=hfhRmbv0dP9i7Vv5j6qfTA1XgO594G8Eofa70uxUQl0=;
 b=6vDT9XZf6k8IsMi3IYNL0NapPpo88QdQ2qt/JzRE7hZBJewVn0fF6AHgKalvr/7bAiDVS3gno
 mX62GQC/FenDwV2AXgi3PpjsYGYQatXoNgPmsF6qmdX0btGW0cdrl63
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

scene_txt_set_colour() is limited to the sixteen console colours. Add
scene_txt_set_rgb() to draw a text object in any 0xRRGGBB colour.

Similar to the console colours it is not used while the object
is highlighted.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/scene.c   | 22 +++++++++++++++++++---
 include/expo.h | 18 ++++++++++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 06f46a3c7c2..968c21e448a 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -271,6 +271,19 @@ int scene_txt_set_colour(struct scene *scn, uint id, enum colour_idx colour)
 	return 0;
 }
 
+int scene_txt_set_rgb(struct scene *scn, uint id, u32 rgb)
+{
+	struct scene_obj_txt *txt;
+
+	txt = scene_obj_find(scn, id, SCENEOBJT_TEXT);
+	if (!txt)
+		return log_msg_ret("find", -ENOENT);
+	txt->gen.has_rgb = true;
+	txt->gen.rgb = rgb;
+
+	return 0;
+}
+
 int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 {
 	struct scene_obj *obj;
@@ -602,12 +615,15 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 		video_fill_part(dev, x - inset, y,
 				obj->bbox.x1, obj->bbox.y1,
 				vid_priv->colour_bg);
-	} else if (gen->has_colour) {
+	} else if (gen->has_colour || gen->has_rgb) {
 		tinted = true;
 		old.colour_fg = vid_priv->colour_fg;
 		old.colour_bg = vid_priv->colour_bg;
-		vid_priv->colour_fg = video_index_to_colour(vid_priv,
-							    gen->colour);
+		if (gen->has_rgb)
+			vid_priv->colour_fg = rgb_to_colour(vid_priv, gen->rgb);
+		else
+			vid_priv->colour_fg = video_index_to_colour(vid_priv,
+								    gen->colour);
 	}
 
 	mline = alist_get(&gen->lines, 0, typeof(*mline));
diff --git a/include/expo.h b/include/expo.h
index 258b9b66993..48e1d2d58e1 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -365,6 +365,8 @@ struct scene_obj_img {
  * @font_size: Nominal size of font in pixels
  * @has_colour: true to draw the text in @colour instead of the default
  * @colour: Foreground colour to use if @has_colour
+ * @has_rgb: true to draw the text in @rgb instead of the default or @colour
+ * @rgb: Foreground colour as 0xRRGGBB used if @has_rgb
  * @lines: alist of struct vidconsole_mline with a separate record for each
  *	line of text
  */
@@ -374,6 +376,8 @@ struct scene_txt_generic {
 	uint font_size;
 	bool has_colour;
 	enum colour_idx colour;
+	bool has_rgb;
+	u32 rgb;
 	struct alist lines;
 };
 
@@ -873,6 +877,20 @@ int scene_txted_set_font(struct scene *scn, uint id, const char *font_name,
  */
 int scene_txt_set_colour(struct scene *scn, uint id, enum colour_idx colour);
 
+/**
+ * scene_txt_set_rgb() - Set the foreground colour of a text object to an RGB
+ *
+ * Similar to scene_txt_set_colour() but allows any colour rather than one
+ * of the console colours. It takes precedence over scene_txt_set_colour().
+ * The colour is ignored while the object is highlighted
+ *
+ * @scn: Scene to update
+ * @id: ID of text object to update
+ * @rgb: Foreground colour to use as 0xRRGGBB
+ * Return: 0 if OK, -ENOENT if @id is not a text object
+ */
+int scene_txt_set_rgb(struct scene *scn, uint id, u32 rgb);
+
 /**
  * scene_obj_set_pos() - Set the postion of an object
  *

-- 
2.55.0



Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BF6CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5F746064A;
	Sat, 17 Oct 2026 13:01:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gUVHBQkxwKnC; Sat, 17 Oct 2026 13:01:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DE8A360677
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242112;
	b=n12Idssh6T9+SiufIPcMXZjQUY9zXo5+lAi49W3Bx4L49z4e5FNe/CSigM15wdLXpIZy
	 8VxU3twooIM1nunp7PK3fJycNqO3PuHjFd8waFem+BBdVmvSfItomsUAV6FqhCXB6B/mW
	 KBpOT4Lz/qezybfJQAlcnUUb44KvrPIBTKUgH+0kqKw4Ed5mZFZQaXPQyiiq4C5zSsgqz
	 TQqsHd/5tLYZnUQtmtFyZamo4FArZdDaLsOh6YanKkYs1bMmUzvUEU2x+1I5NnxWf8Q/d
	 NnQiM1o49odu5RyScfobSyz7BWNlAd8pJfCjsugy6spPJVwBeIwnFWvhx0p7U4aJUpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242112;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jkEWB8ZjZjuvRo8M02Hayjy1HkijgBcWBjjgNzaddlk=;
	b=Liogo1i2ynJd0bXRUClbolPQRnV9rT2pkLzhXJ0fP7gY/mlO9a/pNLufvIzmfcIIDrQ6
	 HutFhsNpUFnHQ9tZ8jii4I3CCIl6ZwMP6M6uPZDBiWAN/YvPF+9UuEHCY/O5mN4Y3M+rH
	 qkleKNnM8afO+HOyaxLGDRjW98ECENg1Pev7kptHeYuAzUUZtnISA2zzVKsLWaw3Tc4fW
	 hsvolyl2xClZfzvyXzryCbix5wuRkuCuFpGTJD+7oBky4Jw07Na8wlT9cVkUzPeLboFCc
	 v9qcm8UK3ouyLiyT0MJlsL9fXHlenjvq1CFitc4wdxNzL5T+RTpzbePj3gqf/h66Klw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242112;
	bh=jkEWB8ZjZjuvRo8M02Hayjy1HkijgBcWBjjgNzaddlk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NfYpIq0vlV4zaW1gzCWQHJvz+UlpKAqW3gi3tClMj2th1hl67c+ZOuB/Dpd1tQ0rs
	 gctEPkjSqlbEkycxvtxkPLjIPJkgK95f8/Ln5jZUSTMxkmeSH1Io3Zw3Zndz+/lZcF
	 3GUFa8bIBcGJzEp1nGX6EHreZmmf8VQlfjKoRN0PPk60URtDOtm0vqgns794QmDX6D
	 Qehw44fPRK1xc9IVGtLoX4v4mCf3U/uXyeMqoMbOGz33WltZMIEezwqML2Med5RAQ4
	 Gn9mqXZz+6p4wnZ8mFbD5frKz+crKUuxeFedzsCTBPXQiaUT2IW5NDl6kSSHOWcVi+
	 p+/iu6eRxfbhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DE8A360677;
	Sat, 17 Oct 2026 13:01:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AE947AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C14081324
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 11JqgUdn-nPf for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7C1CC81496
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=acICRe2m/jAXpYKKIbiVum3SlZDzsB8cnUJazsUEeBPOnsQom09Up8ifUe56gqC60Gv5
 ca2WBE/17pb4ul6EvFhceaVR4p/BvYns3XPzAjRYBmQ6NBByFVbQFUs/oWqigR2WxINtm
 qXnnY9ggP3uxX2iXYT7y/vpbnrquzH6Wq7iM7b5db2sjMc93MYrKfJYCvrNtzt0ChmfOK
 GMgjqsz4XnYMFiU5GnROCMY0gaboRYmdkjZSbiGgT4669KJzpWWUb9h4UVOpZ4RQgXMqk
 ndg1Q1nphNhSJcv3T+4ysGuxI04ki1OziPqFOsGhhxFzvEPPD/ngCMRcLkC1c5hLzCg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=jkEWB8ZjZjuvRo8M02Hayjy1HkijgBcWBjjgNzaddlk=;
 b=cczN0vobJfPdKmcjEUIoyU3oW31uZRZMo1I60lZ9IIN7IfTfXwfQjFQGpERlaNWjc8s/
 IRj7taMx9RXJX21l7fCvcOWlTnMq0f3AF1coZl+m81i2sa9myxmjbIRAslZZyYfoGLazO
 O6krffWBk0P2eBrbHwM8uOgbYAr4CMi0aq4r99F/UhD313M5+D19+wU7rMBOuguzem1Vw
 SA+lFtX2/ZI/oh0fsInGs+3gvd+o7wYCYr6hPoWVe7DesEg+H1t+zLpG+ncKbSO37K9S7
 LMx+exAi+UiMH7HWADrRfgGAmu219Gm9cMaMfAkD6hxKcqSw2UjN3CgSBHY2KssEd3A==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=q2tkLk2p; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=q2tkLk2p
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7C1CC81496
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2B22660AA1;
 Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFA1BC2BCFC;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=OGs228mkB5Ls5PwCPHKqJmh7/qxD5i23YSdWdqn8NdA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=q2tkLk2pmRNqqamjTbkh/aYfZqZRsG0ZbSE+FQNVOkIFH2CTnmCRVXO+MbYGNIi0c
 JWqorrE2+voH0pBV52gd9VPNj5OQW3fZEksa3JO2jc5Zzf0NFCO483KSBLFsA+k9Y1
 0By82F+uXUEM8Lor3WVS5grWYCVE+krxR90nh2XUBwwpIP32OcSYd9N7mlY0jCAY9S
 jOye4kzUcy/+uJe9IM3+LXvR0XAQJiXvUoItVTN49lSo6ZZ4mb2S7U8OZykvQ+SITI
 Hb3EvdgdDao7UK62oE0PSHvRI/3NP5FtVBPwpgUbJjYxfOh+M3Ys54JBCnNOlovYVp
 2ea4hR5uSS0Hw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BC739CCF2CE;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:27 +0200
Subject: [PATCH 11/14] expo: Allow the highlight colours to be set
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-11-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=4295;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=ARVtdUmZv2Sp+/cn4Q8naNycjEBWyYRaqFWxvhaz3wE=;
 b=RDZBClmXUaFpTcFEondqte0hHbR7PjejuySVpvMmInlzkZoBRuR+Kqrt3qBKI8n9oi7saqBBV
 n0dNiFgAcngAMJhcefLUErTc4In2JICQnhWAYRFxwMdWtkj69KyJIJ9
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

The selected menu item is drawn in reverse video. Add
expo_set_highlight_rgb() to choose the colour of the highlight bar and of
the text on it instead.

The video device's colours are put back after each item is drawn.

Also add a small helper to convert 0xRRGGBB to a display colour and use it
for boxes as well.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/expo.c    |  7 +++++++
 boot/scene.c   | 19 ++++++++++++++++---
 include/expo.h | 19 +++++++++++++++++++
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index fb67a80a29f..8e05f98f2ad 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -265,6 +265,13 @@ void expo_set_bg_rgb(struct expo *exp, u32 rgb)
 	exp->bg_rgb = rgb;
 }
 
+void expo_set_highlight_rgb(struct expo *exp, u32 bg_rgb, u32 fg_rgb)
+{
+	exp->has_hl_rgb = true;
+	exp->hl_bg_rgb = bg_rgb;
+	exp->hl_fg_rgb = fg_rgb;
+}
+
 int expo_send_key(struct expo *exp, int key)
 {
 	struct scene *scn = NULL;
diff --git a/boot/scene.c b/boot/scene.c
index 3f63c84a331..06f46a3c7c2 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -541,6 +541,11 @@ static void scene_render_background(struct scene_obj *obj, bool box_only,
 	}
 }
 
+static u32 rgb_to_colour(struct video_priv *vid_priv, u32 rgb)
+{
+	return video_rgb_to_colour(vid_priv, rgb >> 16, rgb >> 8, rgb);
+}
+
 static int scene_txt_render(struct expo *exp, struct udevice *dev,
 			    struct udevice *cons, struct scene_obj *obj,
 			    struct scene_txt_generic *gen, int x, int y,
@@ -584,7 +589,16 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 		int inset;
 
 		inset = exp->popup ? menu_inset : 0;
-		vidconsole_push_colour(cons, fore, back, &old);
+		if (exp->has_hl_rgb) {
+			old.colour_fg = vid_priv->colour_fg;
+			old.colour_bg = vid_priv->colour_bg;
+			vid_priv->colour_fg = rgb_to_colour(vid_priv,
+							    exp->hl_fg_rgb);
+			vid_priv->colour_bg = rgb_to_colour(vid_priv,
+							    exp->hl_bg_rgb);
+		} else {
+			vidconsole_push_colour(cons, fore, back, &old);
+		}
 		video_fill_part(dev, x - inset, y,
 				obj->bbox.x1, obj->bbox.y1,
 				vid_priv->colour_bg);
@@ -712,8 +726,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 		u32 colour = vid_priv->colour_fg;
 
 		if (box->has_rgb)
-			colour = video_rgb_to_colour(vid_priv, box->rgb >> 16,
-						     box->rgb >> 8, box->rgb);
+			colour = rgb_to_colour(vid_priv, box->rgb);
 		video_draw_box(dev, obj->bbox.x0, obj->bbox.y0, obj->bbox.x1,
 			       obj->bbox.y1, box->width, colour);
 		break;
diff --git a/include/expo.h b/include/expo.h
index 995c57e7bad..258b9b66993 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -110,6 +110,9 @@ struct expo_theme {
  * @show_highlight: show a highlight bar on the selected menu item
  * @has_bg_rgb: true to use @bg_rgb as the background instead of black or white
  * @bg_rgb: Background colour as 0xRRGGBB used if @has_bg_rgb
+ * @has_hl_rgb: true to use @hl_bg_rgb and @hl_fg_rgb for the highlight bar
+ * @hl_bg_rgb: Colour of the highlight bar as 0xRRGGBB
+ * @hl_fg_rgb: Colour of the text on the highlight bar as 0xRRGGBB
  * @priv: Private data for the controller
  * @done: Indicates that a cedit session is complete and the user has quit
  * @save: Indicates that cedit data should be saved, rather than discarded
@@ -130,6 +133,9 @@ struct expo {
 	bool show_highlight;
 	bool has_bg_rgb;
 	u32 bg_rgb;
+	bool has_hl_rgb;
+	u32 hl_bg_rgb;
+	u32 hl_fg_rgb;
 	void *priv;
 	bool done;
 	bool save;
@@ -655,6 +661,19 @@ void expo_set_text_mode(struct expo *exp, bool text_mode);
  */
 void expo_set_bg_rgb(struct expo *exp, u32 rgb);
 
+/**
+ * expo_set_highlight_rgb() - Set the colours of the highlight bar
+ *
+ * By default the selected menu item is shown in reverse video. This selects
+ * the colours to use instead. It only has an effect when @exp->show_highlight
+ * is set.
+ *
+ * @exp: Expo to update
+ * @bg_rgb: Colour of the bar as 0xRRGGBB
+ * @fg_rgb: Colour of the text on the bar as 0xRRGGBB
+ */
+void expo_set_highlight_rgb(struct expo *exp, u32 bg_rgb, u32 fg_rgb);
+
 /**
  * scene_new() - create a new scene in a expo
  *

-- 
2.55.0



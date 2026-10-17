Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3194CCF2CE
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8C50A607D3;
	Sat, 17 Oct 2026 13:01:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yumTOQoapSRC; Sat, 17 Oct 2026 13:01:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org CE725607D7
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242117;
	b=RpCr8fNgTPCxANKCz05WK+30XFGR8fhPfq4c3PD9vZ/8cnju/aTgAowRZgmXoTHICPey
	 D4GNlzbJoIeiFglMeOxthEN2RirVnXPbYFkFAoa9O7o14xf+wYnHS6rjl0Lg1o9DgNU9L
	 m3evPCLwcjoSfGWWB9xvB8Pw3F5I2na8kwIIERMxjozv9Plrs5bNX24Ti8RI7I+oKCitz
	 h2MePUTqEf6qUXWtuxDKmP+NGMjyWsxlNmyegVjSKhZ9yUIUdFksjiZtksSLm5+hFbmDi
	 o1MFnAPo4lM1T87IjvZUSLGUWFjSgx1DI83fVn0bD6b8Fldc6dAIjWUq2oUhKk/HFtg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242117;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=/CaZ3nISJladv50XrFVmKk28g89elGto8w9sbh/mwPA=;
	b=onWCNIWxgLf7x+6H91QjerixYMwkpqpYAn0O35/tyOBcU+dt2wDI/9Y7Vw08tq6twU1m
	 svDgZCCqUWCw8KRdH4EbXN6X/gCUUyT6f0MGOziU6Jmdtlh1JsmmmSvC+KL44Dihz4Gyz
	 wyhwp2MJ4saSgXSoWgRvKc2k18tzYiWQkl5cNX+3W3Ni2y916Rdt4zZmPtUrGf3rKTM05
	 DHJGgvSazr6IRFOAANnuz1tlWCcqeAf7rNIuzdtfUSNDRBUJVDr1OuodXuNcGzFT3non3
	 0LA6uvMEMsa23T8uE4R193Zc6cVoFh36a9C7Re64nZvw9rVBpZx+fIw7DT8E/hDvYbg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242116;
	bh=/CaZ3nISJladv50XrFVmKk28g89elGto8w9sbh/mwPA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Hvn5sqFzq9ACbLRib/sU9x5jhCwzwWTebr01qcvCvKf7Pcx+guyiKrzGTv9iVreJh
	 3VM+s4X3ZU4IEvOFgcbvIJe8H4+8BV1gxL/t/3mSsQDLm/shpTdjQivpOqJuKFudhz
	 jdDrsA0uKQET+/hkZuVWidd/6MDutm3puF4cbmdt37mi0iPNY7F+5ZN73yE6CLoQSs
	 0ihBNNW9pNODA3RGVPLghhqsqaanAkpkV0c0VW57DDyUp+tVQPU6DWMdG4PI5CdsNy
	 hF3wm7ZJGU9hmL97NoTIxjBvObjYSkuiKSA7/2+IOVccsb7I6uXQbkXUKccKV/WtMF
	 fymhgsi3i9g4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CE725607D7;
	Sat, 17 Oct 2026 13:01:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A008362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6DDE4813DC
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QCCkYtsKEwFE for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B966A8149A
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=h6FU5ieiwZM8zp2VlUmWbVJ78PVQKLppPfAaX2FNwZXsKUSFxq3xrO6MbigLr9AQCgNS
 rZR4c4KpUdj4PdPnhx2G+af7A9rOlFhkmMDa4khfl0rwFmPXkEtccTJ2CVLfaHf7FtMcl
 gaIgDoT1JY9V7UT72vmCte5PYHviMumH5t8k6lh+r94w+1u1lTOWpwUl7SGhnIMPXR7AL
 AufoqWg5OuSekQVSkUBJVPKgqBIv7nd88RNcm502JehiFzla1RQdUjsmbAY1Zcyxqh9CN
 kVGVOOV9QWvhHf0OdVX8qm2+3BoJM0WF2IwdXi+UfC6/+zFw2uDSE7lHchvZV0M4uZg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=/CaZ3nISJladv50XrFVmKk28g89elGto8w9sbh/mwPA=;
 b=ThAl3iU2+gBXXgamPjftkkHlz2+aHvSoNDpQsCveY/nCKf4epY171EfAismVpUZX1XaH
 1jmvlO6dNlf2XO/OfaqDjrXoSCuX1P769ROqNvzNYs2dSqwCi/ZeIsk+1Wvjnxa7G7cmI
 qk8psTAabgtBFED301g3hd80k8LN/oTUt3QRXbGFTF9hGwGPpl5ko0/I795WvIcIhPoOZ
 vn0IjTuP5DHNxHToC2/b/IBDUNhrkbI/jQglsa6at2+Ea7yxZAn1tSSJbC4EuQX+DIw8m
 ZMfadmxHj839AeoPj8aBiZxVWBnJmxhkqX1ZJVnaV4QqY7H7J0zC15ptEoKCz3FLROQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=PB3f2LIh; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=PB3f2LIh
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B966A8149A
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C768144008;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A98ECC2BCF5;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=NgOAPlXBNSWnm16+6xvAiReW+oOVNuaZ9NncMHKHWbU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=PB3f2LIh82hhdo6FYurOKspekED1sENsjKKxLj5VJ8tvEtmmRWleIQ4zwxuz0i75r
 DIEJm3qFjBeSfmkDmBmGQUZ7mJ7IcpV3XbE3FteBi0zbcjsw5+KT6fa2Ng2+QcjHoW
 99AmRDgMW+xZJFVmTUL3d19amT07hx9MfYtqyai94RqMXA5gHTN175Dc0aK4svgfvx
 qzds6mMzUr9Z5z2Pu8MT8nVIlIrHcmN+plpAMfUouRpFyl3SLcLxdlpl+tjk2WaG/9
 CMEucOR/zvPhyM0FWeMN/NLJn2Ad7iH3XRaHLEx5avWM/C1l1k5t/03QSsLbjuKVYw
 pCld9ZcgIfIlQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 97F03CCF2CC;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:25 +0200
Subject: [PATCH 09/14] expo: Allow a box to have its own colour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-9-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=2696;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=9YaaXsdEUmQIItAOT+My/QhEBjL0DWy8CWDfbsYOQvg=;
 b=8V8U8AvRwcO6E8aFdiN9SYYKBHstR0/wq5yYQVZ833NxK3guZUPKacJbN67rAK6Wf3FhOmJKE
 iZVE09b6dEDBYpENPrYJD4llfGi22mZ/oqzz5kNs2MUx5QGaPgBwrc5
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

Add scene_box_set_rgb() to draw a box in a chosen colour instead of the
console foreground.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 boot/scene.c   | 20 +++++++++++++++++++-
 include/expo.h | 17 +++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/boot/scene.c b/boot/scene.c
index 6073ab5a9f5..3f63c84a331 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -231,6 +231,19 @@ int scene_box(struct scene *scn, const char *name, uint id, uint width,
 	return box->obj.id;
 }
 
+int scene_box_set_rgb(struct scene *scn, uint id, u32 rgb)
+{
+	struct scene_obj_box *box;
+
+	box = scene_obj_find(scn, id, SCENEOBJT_BOX);
+	if (!box)
+		return log_msg_ret("find", -ENOENT);
+	box->has_rgb = true;
+	box->rgb = rgb;
+
+	return 0;
+}
+
 int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 		       uint font_size)
 {
@@ -696,8 +709,13 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	case SCENEOBJT_BOX: {
 		struct scene_obj_box *box = (struct scene_obj_box *)obj;
 
+		u32 colour = vid_priv->colour_fg;
+
+		if (box->has_rgb)
+			colour = video_rgb_to_colour(vid_priv, box->rgb >> 16,
+						     box->rgb >> 8, box->rgb);
 		video_draw_box(dev, obj->bbox.x0, obj->bbox.y0, obj->bbox.x1,
-			       obj->bbox.y1, box->width, vid_priv->colour_fg);
+			       obj->bbox.y1, box->width, colour);
 		break;
 	}
 	case SCENEOBJT_TEXTEDIT: {
diff --git a/include/expo.h b/include/expo.h
index 61fec3d52c5..995c57e7bad 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -481,10 +481,14 @@ struct scene_obj_textline {
  *
  * @obj: Basic object information
  * @width: Line-width in pixels
+ * @has_rgb: true to draw in @rgb instead of the default foreground colour
+ * @rgb: Colour to draw in as 0xRRGGBB used if @has_rgb
  */
 struct scene_obj_box {
 	struct scene_obj obj;
 	uint width;
+	bool has_rgb;
+	u32 rgb;
 };
 
 /**
@@ -790,6 +794,19 @@ int scene_textline(struct scene *scn, const char *name, uint id, uint max_chars,
 int scene_box(struct scene *scn, const char *name, uint id, uint width,
 	      struct scene_obj_box **boxp);
 
+/**
+ * scene_box_set_rgb() - Set the colour of a box
+ *
+ * A box with a bounding box no taller than its line-width is a solid line, so
+ * this can be used to draw a horizontal rule.
+ *
+ * @scn: Scene to update
+ * @id: ID of box object to update
+ * @rgb: Colour to draw the box in as 0xRRGGBB
+ * Return: 0 if OK, -ENOENT if @id is not a box
+ */
+int scene_box_set_rgb(struct scene *scn, uint id, u32 rgb);
+
 /**
  *  scene_texted() - create a text editor
  *

-- 
2.55.0



Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40489CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE463409C6;
	Sat, 17 Oct 2026 13:01:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6prq6_Y0X9RW; Sat, 17 Oct 2026 13:01:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37AA740998
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242115;
	b=ZZJVINaywt38WCn8iNea+TsDzDcix++I5Cxz10K0bD+5TzZJAKmA4+REqzpgi36YWPAi
	 u4ItmjOI61d+r4BXdlmPVVwsKUgRS4XpYW7028qkpWYntlZOzbqoo0YeKQQEwu5bJVSi6
	 DWrif9EjBQcQaIEmTaa4mOszdXJtyHiH2OYO8ua5lz/0N3C8p1ai6s88GJJ3RuVzUqbpw
	 ACj8nBzuQsD+sNgE3Ss276kkM1ZTmmMJAD+gvK1nC24Y3nWKfjFrc0fLmBUWlmch/i+hR
	 Nb/alD8lg4J3loMiDPWpkqKt0iJcD69eVj3VUAPcSNnYEqpCxJgaJK2ZD/zb/sTccAA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242115;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=SA730GrHGu70V4ZEtjYKLfnHsW1D89O71TSpyFcJhB4=;
	b=Jc+nrp+YT2y8YOIceIywi1AaSC0lbY/hUp9srsQReu8mu6wl6OIJfU4Vfcm5q9amJBEV
	 7Yn+6rGZDt9a12XR1NBlwe4zI/wBls7l5L+mG0VJ7VDA1kD+vZz4V97NhSOU89YdFqt51
	 sxEmVdT/XFuRTITtjrGlw2h4o1OmqpBAzPHTbJFrrLf954W9KZm/TFGbpfPb/5ch1IyYp
	 1ki7oZeP3YpRq2ackqG9HZV3fJ33J6UNsj+Giu8kzC5kXwPAyQZi8fNXvv2J6XJDAhOow
	 2PRtEDhgGfgRz1NJF29oMwFJ+8RkRF/BNJBkFrMOZRnnl5AnMNdgVkNED5Y/r/rtyNg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b="tl/FBT/e";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242115;
	bh=SA730GrHGu70V4ZEtjYKLfnHsW1D89O71TSpyFcJhB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=sbO0AQff2oJ3gUD+SfBSZ9CejjDiEsHBVxuW2Aa3r1mbKyCS02V6EouMDPn7J6k4H
	 bejpvNvj9luYgQzxt9eFuEIHOAlJ+htaIY+Cp7jZsoPDlYEP6bIPSysiOW141zbvnN
	 bmS34I2ffWdjcC0zdz6nAoD4sKZbmbo4+RM5D3fQxyLMSnlzTvS1pqYKUOmQSYkHTg
	 hPz+IQnbgFx8WGcFwR6kF+0W5a+loEYqG8ua+Qd/qA6NgskMwpgiPPSLcFhGGWK19i
	 q4sQHo0DPzz8a12rgHoDNfnNZ9WvH88X0V7jp5NyNZI3Kcm0+oZvuN8xzmuxdCB7Q2
	 h+uQZD3WftdBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37AA740998;
	Sat, 17 Oct 2026 13:01:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 885F01AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 77A7C409BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L_wWw3f13O19 for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org A334C409D9
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=ePuaovq4AeYKng9Qh7RLsCEECzLZF98jAwkUi5Izf3aXBJMthu2LEWLtkmCi1Kg0dIOs
 SMcnZeuWwKmndi4ZDzDWLd+aG7PjueJkPRKbLcSiZ/iHs2JtNh5r+7B4nsUXy9FH03awi
 WZ9+yL7ABFCibWADJ3nnrfw65YU0sqDSZLIOj5i4hx8VS5Vf0rJZrK2czWKU3Fuonl0Jf
 0KOFHclaQryrfICKjSdgzdVqt+jAQSV5f997UaZqm28Pae486COQpOu5ECqIztZwzSezw
 j8IUeUGBOU+b+xideXM36DSc8c9NrDlYWHdqwAWZPOcngTn1o7NAVaAGp55Qtj8mSPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=SA730GrHGu70V4ZEtjYKLfnHsW1D89O71TSpyFcJhB4=;
 b=NJBq0sCHz8dBQX1v9AWpnACKVtWyhZtAceHK2v8jH7tqbL7dVXVloGKvLZ2V5QW76iFk
 Yl+sKQvHUT0WiUSD77rDRnb7RVl3MMnVr60W9g1gWGBh1Fxdr+H0YSjJL6FISi26qg03D
 Fy3uL/Trw3JaXBIyAdXjLQ+6iKo4dxwDkgjDzm4Oz84jZIDb0scFb1eeyERMLnVKPoecg
 TzOKK81uBDzd3aQlwLHbY/PA+PYUYDF5mgYcpT2ZSI7fm/uZP8Zsy/9HC4F/44FvAcGHj
 w82+DaRKZMHWDm6uLnpStmfN3BRmqxANjiPDAePWuxy53kdt6qyWV/DdvYkX6g1A5LQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b="tl/FBT/e"; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=tl/FBT/e
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A334C409D9
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3CFA660AA3;
 Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E260AC2BCFA;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=PoRdGx6iA6RZzUH/GFQHMNwxcyY6uN88QixW03aqpeA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tl/FBT/enNQQCJAotPQSr7DCrhJvZHo0V8f/2StJ0Ow2YFoZJHAgam+dmx11qofGr
 DjynODQ6O3mO3WEdUBeJIZkRj9xJ62+hjcDVT0DkUbEdpbf+JAfc2Zq4bbyq2J7me6
 XSVdrMUR1pR6nGks0J4YHv4v1E4979E84lVw0p6ODduA75TEC2LxfBSlZEt2ui1DAt
 mzMJhqn5bJTiPyfVodqPm3wNgwpsVG4g98eNL+2glhI6q6SOhwVQuG8I7xt6hdVWE6
 tRmCDUWR6/URw/1lroDBkqNPgHX9pggrRy+cWFYVG/nX8mq47Q2s3pVi9JWImHbfxf
 Ij4dUyy7h1CTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D290ECCF2CA;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:28 +0200
Subject: [PATCH 12/14] test: expo: Test setting the highlight colours
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-12-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=2269;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=r/A1+zfVVHxHzN6Ykw8gBWo77vTIojcmydtusTmGxPU=;
 b=Zgx5ebijGokT878W6Eu/B/aP3R8heNTfClTjQv36x2xczYmQBC4zZ3ep6zWtKjFo91YW50Xub
 aEaXKYZ8yYGAoC1oA+lBunSTOilBVOL8Nl9+ap1ncq4DHH1+2DOjTIN
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

Add expo_highlight_rgb() to check that expo_set_highlight_rgb() records
both colours.

Check that rendering a menu with a highlight leaves the video device's own
foreground and background colours as they were.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 test/boot/expo.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index 2374e61f864..9a8012cbd51 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -1014,3 +1014,49 @@ static int expo_box_rgb(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(expo_box_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* Test setting the colours of the highlight bar */
+static int expo_highlight_rgb(struct unit_test_state *uts)
+{
+	struct scene_obj_menu *menu;
+	struct video_priv *vid_priv;
+	struct scene *scn;
+	struct udevice *dev;
+	struct expo *exp;
+	u32 old_fg, old_bg;
+
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	vid_priv = dev_get_uclass_priv(dev);
+	old_fg = vid_priv->colour_fg;
+	old_bg = vid_priv->colour_bg;
+
+	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
+	ut_assert(scene_new(exp, SCENE_NAME1, SCENE1, &scn) > 0);
+	ut_assertok(expo_set_display(exp, dev));
+
+	ut_assert(scene_menu(scn, "main", OBJ_MENU, &menu) > 0);
+	ut_assert(scene_txt_str(scn, "label1", ITEM1_LABEL, STR_ITEM1_LABEL,
+				"Play", NULL) > 0);
+	ut_assert(scene_menuitem(scn, OBJ_MENU, "item1", ITEM1, 0,
+				 ITEM1_LABEL, 0, 0, 0, NULL) > 0);
+	scene_set_highlight_id(scn, OBJ_MENU);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, ITEM1));
+	exp->show_highlight = true;
+
+	ut_assert(!exp->has_hl_rgb);
+	expo_set_highlight_rgb(exp, 0x1f6feb, 0xffffff);
+	ut_assert(exp->has_hl_rgb);
+	ut_asserteq(0x1f6feb, exp->hl_bg_rgb);
+	ut_asserteq(0xffffff, exp->hl_fg_rgb);
+
+	/* rendering uses the colours but leaves the video device's alone */
+	ut_assertok(expo_set_scene_id(exp, SCENE1));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(old_fg, vid_priv->colour_fg);
+	ut_asserteq(old_bg, vid_priv->colour_bg);
+
+	expo_destroy(exp);
+
+	return 0;
+}
+BOOTSTD_TEST(expo_highlight_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.55.0



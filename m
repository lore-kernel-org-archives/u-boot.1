Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B55CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 183F08150C;
	Sat, 17 Oct 2026 13:01:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0lvEj55BABJr; Sat, 17 Oct 2026 13:01:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 645FE814C3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242118;
	b=Aobzt+BclcRgac+WX9Aa0j0kDm+RrehqfN7Cftix0fR4oh+sx0/zFZsoZ2JLbh3UPyoa
	 pTJN7Uzcf4A338DDbxRyy27bHIkKPBSA8nzv3KIJ92Rp/HqnJkQJs8LLWbYavL7YAswQ/
	 /QsFOugEFpNsdDj8qJIcOsDJo8OWERMtkJUi0EX4lPTvPiFvKPFPyNYfWj9ilPf6IpyMK
	 wAqKrFeozzlYP6qKCfnHtnjQvxcTgTmLK5SfQfW5pl8Lwa99J0c51EUw+WzfjrmAe2aU3
	 56i403qJQI3rCZVrPhLYd103TuQ4873fCituBahCCmRvhKxKqvFZQcpdgA/M2D6WSBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242118;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=mu0by/ZQ4X6pBlg90fT61cT4RBUTB+TnFV+yjQGwnu4=;
	b=N+qvsvr9J/GXREvVxsac7yiYLo5ATRil0Rfea8lezfPZbFik8NL+/aOUPpxGP6duoFMZ
	 6+x5OMn3tCROuqb417QMcNe5/lXd05mEivBW8O+IeBhBna2IQ42Teu3THCVhVSPDgPcJp
	 BYuA/IwRaLS1jL6kLjoXNkm3lQ9FJ4Hwc8mEpcHbTALBgtdL4j4Aq9QjZ6ae28zXR0prj
	 rdVbgqYbsoW9qXPdJZO1WCdgefDvG9SDtychJsfRqAJpY1S+jnZ/xRh/F4orSVFobXhI0
	 wV5qJNaPPNxaEkbHPSRcD5DV1vYHPGUYm5yWEL8QfNnZYDSU50jsmdl1sD+UAIwxEyg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242118;
	bh=mu0by/ZQ4X6pBlg90fT61cT4RBUTB+TnFV+yjQGwnu4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ZndPA5bt0rpcmoBuvqUnnWXdrEHeMBPfVSsqeB2RVylebt0XuYfgpv7rCK+x/8Yep
	 Yqj7HOfLEOc/2k10sSLAyqMC7RAUL1CwQd8Ddg8C8hxB2gBMhgoHq2xIdrGHl1MMxR
	 /9vdgmGee9833loc7BimIv7bzpw0PjgnC5ABkqaYuNHujUolhxUT9Of50BOci19H5U
	 jri6759/rfvtZbIv08GFvYI+KpvN0CQXGlfc6EpA0OZbsiZUIU3UFATxtG+OgCyXsY
	 peKef3/XO3rY79BnZCtHpiHHv+WMuPcazdwtT4bWsl2jlMYgMWsqcBuAHEOcw21WN1
	 O57Fq1cl/SKaA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 645FE814C3;
	Sat, 17 Oct 2026 13:01:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B9357AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8D84440176
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nJf-fOQ2JydV for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E283740122
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228230;
 b=C2w0Pn8ocFc2Zs2X5zuAke0zEoXgOKJ83oJUkgCcT5LdJFTmaCpQVJfV5DE+FFOs8rC4
 jfc0ZXeurbFdM3TIICQSShsGbvcVTOxZ0Mk0V/7EReW2EojxAtXeuewe5RZDvqSm4f30b
 0g9u5qg6UtDdg109EwLP+fj5DZ1BgccUhYRpEYIcFgdMJ0Om88So/lcedhjygsSHA5lNh
 pE6yj7JjvDGFQFlwgY51s8ecAgLxBNKsbC4cBBCkP3lmYJxtnZDjMyjHiOpt0/bMbl6rI
 1nfE2T7g5ZU0IBKJqSHkp+jQV3MYAErJSWinAWWfGYaM7GkDx6xugW3SCMRBDGjx5sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228230;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=mu0by/ZQ4X6pBlg90fT61cT4RBUTB+TnFV+yjQGwnu4=;
 b=JkikIreeCcL0romIb2+4uCIjAVeIxYBntmtSefnlMNEyobd6hBV6IR8zznP9slBpDHXN
 V60Xo/Uv7lwEG99c/B3THVESYU8gi3L2wxwnsUx2PBCsDDlLeWzhKxlM7GwQo1mSjWCfr
 ejEzABu7PURFhc0KTRyEgFUNfTAd83dHYNfqTTyHt4j61zrIH77AfNGFmgrHBz89yYn/C
 Kw9MaaYKCewpwCYJq7DlTFtEUKqVzPK19yrhPlpHGDO+1qb6OSTbwFqBYe2tkBJZnIIB7
 24X2G9GSJq1BCUpZEn4NLwerNalGEo4kspxaUs59iFLrQbAkqXgo82yjhSMdOjJ40vQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bOO2xKTR; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=bOO2xKTR
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E283740122
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B0C9343D2B;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95FDAC2BCFA;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=ZPoGg1deIRZl2Q3oKwIE5pT+uvPtxLNONlTZ8WvPXCA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=bOO2xKTRhXJ7wSYT2SD4vSB1cV8HMzx4TLP0fiqPbtLouOqloyOwXRnQO3DTHgeAO
 SGhL3/Bz8q65CMW+S1tgGbvWQ7NZwATNGyZJy3dDiy8FSHAhmgnB133+N4Ya63vjn8
 jDHP5QZaPAnqxxDNKtQr8X6bIGZLlmXC4k9Nk9DyGfPSk6veud1E5qMOwmfdqq8dk/
 0p4wf5ViV8fvxtOZ+KqETADOGyARJsjmcYBqgAgSMrnUntEtz8+VfL76i0/COM6zpS
 4GNFeMzuZCFYmWI/294Tf4mc+tPcDKyMcfIwsZOqlcP53pR83uBZagC8807tG9thVv
 /iX7Zqay/xHWw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 85109CCF2CA;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:24 +0200
Subject: [PATCH 08/14] test: expo: Test setting the background colour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-8-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=1577;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=zOT9KuiJwBhCFWl3FN4WtxbXfzlBrDYCsfqOv+hX7X4=;
 b=FD3DSPg005od8XM7M8mgPJS/O/Tr5/B/yWn6PnVxDhzddxza77U5yUv9bu9LDe3oYD6t7OYlF
 Rzr4WuO76LhCG14iS0xuiZbJGuZ+H2ED0l6AvQpI1XljYvdBRbQzKlw
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

Add expo_bg_rgb() to check that expo_set_bg_rgb() records the colour and
that rendering leaves the video device's own background colour as it was.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 test/boot/expo.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index e52de029477..b50c32c0860 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -944,3 +944,36 @@ static int expo_menu_header(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(expo_menu_header, UTF_DM | UTF_SCAN_FDT);
+
+/* Test setting the background colour */
+static int expo_bg_rgb(struct unit_test_state *uts)
+{
+	struct video_priv *vid_priv;
+	struct scene *scn;
+	struct udevice *dev;
+	struct expo *exp;
+	u32 old_bg;
+
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	vid_priv = dev_get_uclass_priv(dev);
+	old_bg = vid_priv->colour_bg;
+
+	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
+	ut_assert(scene_new(exp, SCENE_NAME1, SCENE1, &scn) > 0);
+	ut_assertok(expo_set_display(exp, dev));
+	ut_assertok(expo_set_scene_id(exp, SCENE1));
+
+	ut_assert(!exp->has_bg_rgb);
+	expo_set_bg_rgb(exp, 0x0d1117);
+	ut_assert(exp->has_bg_rgb);
+	ut_asserteq(0x0d1117, exp->bg_rgb);
+
+	/* rendering uses the colour but leaves the video device's alone */
+	ut_assertok(expo_render(exp));
+	ut_asserteq(old_bg, vid_priv->colour_bg);
+
+	expo_destroy(exp);
+
+	return 0;
+}
+BOOTSTD_TEST(expo_bg_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.55.0



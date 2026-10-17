Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6BDCCF2C7
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:02:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC50040987;
	Sat, 17 Oct 2026 13:02:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cxeIjXTE5Za4; Sat, 17 Oct 2026 13:02:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2B8D6409A8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242120;
	b=gIfupP9neM8Bi9iwZ8/2oT8Mpryv8uWPqm+sA2IyzVd0fENU7uKVnXaHwrwPv005wFHT
	 k51kxCaTnoHyH9j5QQV9nJdXWHoy7FO+oErIuM5AgaAqe0DzxUYJLMz6QzwPJbivfLVCO
	 oxO1LuP8gxjTkJ09xxRR6reBym5RsrxxwY4e9x3zgwtdnNzV96vzTpxrNrsp3zd7z5xKW
	 16tB5N3P3Lf6CDoz7M+4LNDQZH0nSMtIiTbuhTZGmHwLpSTAvwGjkk0T8/r84dKOij3yz
	 4pWXl0Q+yZiQbAEYUA/n2o9iFXfsNcz8cz4UaQ4kjGiqER8wd4UsTrJRLUX6e6MlSSQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242120;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=GoPRPvv8Vrhg1cwgvHdZVBm/EmVJlVzMSLB7ai7UUBI=;
	b=m5Zmy2JLQ/r9Qo8QGY3MGGxJKJEGnOz9Nu2Q0hnoZueDEOpnJkLVRaqtjxBrXH1Aoric
	 wx+KPXpBPbPc/kfbeRQ0gzniEqp0xAFUve0I3dSPC6Hl9lSFrP6ERSN8q5DXe1TRwLeeD
	 Nbh7Aq0Z7jTPY5DmJNvsNYdE9JBUK67slfGM3ueC149xVhqHgpCw/g6DdPzrgSw6PGcMs
	 SL3J037zLJAdhofNDla8RIXAltLTvxLWf80o5CdUSn/lHLL3sCfDSBSZxvdhlhuZmMs8g
	 ocwGQI7RifXYmWWPxXk8eVI9PMoapbpv9GV5w7FDGLq31G8PpjoJju1PIoGGB0T4dJw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242120;
	bh=GoPRPvv8Vrhg1cwgvHdZVBm/EmVJlVzMSLB7ai7UUBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=VLW4W3NJYR8nJ+CW2wrr+ZudMEgARkJe4B10Uh9QlH033r5CrIRqbYFxuE5YZ6gh0
	 atLzFGNWSG1a11E+e/VGzt7VXMmfgeAjrOjL8FoScDG6Ih8zZnwkV0fk623NdagnR/
	 xOLq5DXmhA7DaCuv0Zhem4oYmD5DHwzk43cWn+c+q2g/YLeFyTLim/n/11iYv0Tcwo
	 cuu2Rbmv5sOz0uP58Tq92k2GpHTNJgxW1NEuTANbblaRVk3vO7mqzhZXCM/ueEXaJ/
	 GC8e7N3KE77LNk8zHsOQWVH9NIOPWSspvXUkKdRh7U167iV16qrGcLgBkGMylkHqSi
	 E2PvjPHgW+LSQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2B8D6409A8;
	Sat, 17 Oct 2026 13:02:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id BD8A51AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B026E40122
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aSWVlHnL2jQt for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2362440180
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228230;
 b=YKUtSQBtI5zIIMChpXZcxd2p4A9HQc7sHme29DtwuZCnxu08hYOHs9knSnLRJyTX2+gT
 rhv8/ZVthkSTIs0iwZNmYfLBlZJFxui2rBI40MGcOSlLGw6w6qeXQhXgYX0GRrWFTh3nY
 ZlvlpwFg2EiLc1u59VzBTyw6Kv2d0wZ66js/nIAUhqCqcEnDEGMrl94ymXf7LqYul7Qse
 M7Z0a2VLhvbyxsLOlbg7AybAg94iPsgXdiZMSgWcQjPYy/QnVk5uD0OxXPeMPfwxx7j0b
 jPriHN43kY4g135McAlQjM9XFqgYf/y6HzDFUU//I2X62h4BLgivsGb0VwrknOaVdgA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228230;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=GoPRPvv8Vrhg1cwgvHdZVBm/EmVJlVzMSLB7ai7UUBI=;
 b=SdV4WFvk7+fzz3Vbyr92SVPL6H8D7KE+P3CwsEfy94+KA3JIP0VnyG8B6ROUVr9Udgjt
 LQpLKZv+03Te1/3D2EQ4UXKxysbRoOsa2pI1DsBAmX4fo+LjLHsK3aLLeKpEco1eZrLTm
 wW/RyXymdl2hmxom0clqfPH/34JA9NqRFYtlBIeefwnZxFGsMBNeZ0wVi4DGu23m1vwv0
 uPmWBXxezI4ZzsPvBbNG1U5EYGGIMTrNzp3UEJIJH/st4XiA0f1cumrpzUaiYrr4Slvms
 h1xHXfp9kN6Br9vAMzHbdUgWUz1QBqcsMTdsAN/NDrkUrc6TXIy6DEPdpfakDaCAmww==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=HvTJp89j; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=HvTJp89j
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2362440180
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 30EA1447BA;
 Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 152CCC2BCFF;
 Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228228;
 bh=gAKlMyPRFy5rpZPgiqdHJ5IT34m6e9aons3Trdovato=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=HvTJp89jH4Vq5Fu+zTyhbvqm5qECs54WR0h+UJmxs7aqQW56gzBfULoY5xoLkUkzg
 Lv+G6aacDPR3335al7x7Tm5zwYioxLysTzDkNoF3JAWxy48GOk60X6RkNIj68oXsKD
 Apxk4reOvjHHykJdib16A5sU3eiBGqnUvcvoPFvGYJg8pIRYDTM/eij5uoE3g39hQK
 J4XHgPBV9tPnMY5AOv7KTXWXi97xl09YnbQ4zon+zWxFqQjSELRwagNc69tZCcziR6
 IIBHNfELActuZuMub+tLsjVwMR6yLL851xCMq1XKDpMbTEqG5xrGXOF60GIjak0gwV
 aetSod5hvdkEA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 03B5CCCF2C9;
 Sat, 17 Oct 2026 09:10:28 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:30 +0200
Subject: [PATCH 14/14] test: expo: Test a text object with an RGB colour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-14-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=1857;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=xxKsFm6ww2Zbe1I+mjfKuL8mjt9Djj194g4yJQh4yvA=;
 b=lo6z/a0g/ppsepvYn3NO+eeJIkjtx6KVEKj0khoHuGDzkCnDgZvtJyHzX9D0ZpbfJHQjTY9yh
 RISE45tCR2RCbfATGhmneG5f/sx2kggh2ly5Xa9mxJAHRZHtptCUQlC
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

Add expo_txt_rgb() to check that scene_txt_set_rgb() records the colour on
a text object.

Check it returns -ENOENT for an unknown ID and that rendering
leaves the video device's own foreground colour as it was.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 test/boot/expo.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index 9a8012cbd51..5ea0e6b51c4 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -1060,3 +1060,41 @@ static int expo_highlight_rgb(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(expo_highlight_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* Test giving a text object an RGB colour */
+static int expo_txt_rgb(struct unit_test_state *uts)
+{
+	struct scene_obj_txt *txt;
+	struct video_priv *vid_priv;
+	struct scene *scn;
+	struct udevice *dev;
+	struct expo *exp;
+	u32 old_fg;
+
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+	vid_priv = dev_get_uclass_priv(dev);
+	old_fg = vid_priv->colour_fg;
+
+	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
+	ut_assert(scene_new(exp, SCENE_NAME1, SCENE1, &scn) > 0);
+	ut_assertok(expo_set_display(exp, dev));
+
+	ut_assert(scene_txt_str(scn, "text", OBJ_TEXT, STR_TEXT, "my string",
+				&txt) > 0);
+	ut_assert(!txt->gen.has_rgb);
+	ut_assertok(scene_txt_set_rgb(scn, OBJ_TEXT, 0xc9d1d9));
+	ut_assert(txt->gen.has_rgb);
+	ut_asserteq(0xc9d1d9, txt->gen.rgb);
+
+	/* only text objects have a colour */
+	ut_asserteq(-ENOENT, scene_txt_set_rgb(scn, 9999, 0));
+
+	ut_assertok(expo_set_scene_id(exp, SCENE1));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(old_fg, vid_priv->colour_fg);
+
+	expo_destroy(exp);
+
+	return 0;
+}
+BOOTSTD_TEST(expo_txt_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.55.0



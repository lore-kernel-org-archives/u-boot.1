Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59DC0CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F61881387;
	Sat, 17 Oct 2026 13:01:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oi_kvO1vdlLJ; Sat, 17 Oct 2026 13:01:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66C77813FC
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242108;
	b=N/WGwZQcjLO3RaCRQjOlVCHOW3pfgrbNNO+1Edup/chxpkvzryK1Jwjem1IFUeeTZOjT
	 2Iy4/ndeRJSmPS7F/8R7Jv9kynM/3pGpGHdK9fIObQqf5McfEWCi9GNT/NWWbaJVzXy1Y
	 FCxASgQpXt3Cr1aG+0rF2NgtiqMaR14fUGyD9ZE5g7fdXvpdopjm93++CKVDrX1gH14Pv
	 7HGqAJMJg7uMxfyMG/T+sQ0UkcswF7ls/0kNsV9qND893Eebbu9KXShbINbaQCq5jW6vf
	 YYj/2T9mWdvd+dVQZ/RTpFXZyoQ3XVaFfjaHrD9PvrzsvKZZ42/Byyu6d5mgXTCLwfg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242108;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=lybUT0N3joVAqqF7ORUJTj5DfvK7uupd0cV71jEs+0c=;
	b=pOW0XVYzQ43Q7Ptz/CrxvjLU01XWscpcFRseGqxtqKnKCypyPkBA4a1tNHQO5MKfszT3
	 l2ith27cUV8VR2gmxc+SuPUD6z5mWHFwBlxhGKIrPrRqCLFeexpwMqtmcBgXcw35FhXXB
	 KfR82laL3jbZ2qkYg/4uXJI6iVXPJALkB9sIqkIte1YtsHEninwlA16PfUcAMB9QRTZOW
	 7/2RXo9pgzzrKdq6J779W962Bikd5IDCplnpaO5Bu7Ooz6svJoC3G69xelojyi5hMep+w
	 1TZvU/V/gnGPRdDEVMSpxXYqlEjPXtnQCpg9mYHXDewu1bXXNEzMT8ld0iO0zahbuTg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242108;
	bh=lybUT0N3joVAqqF7ORUJTj5DfvK7uupd0cV71jEs+0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=Uemd4pfVB7r3OYzfwcwsLtMiIjwP2OAlZYNwP9DVSRVKKDqELUi4BqEc5baNeAMh/
	 fQpGoFgyDkQEx4N8q/TcnUqQ794c+FopE6uAShMgtOQQKrQv3ofKBuA+KH8gnGz0DF
	 CZ+3GFmcwjqW5v6USR8DTFVmj0ptiLJ98Ty76PWBKCKD8wOOerChAWJwI2ATRumyuk
	 oiniwG6BxjhJosgsX396CQawpgdyICgudWsJEyuNLESjrc8s95wABuY+FRcfAW/dPq
	 NDAPnTkK4LjuUTnrY1wtdxhcuIU9BbZXoLRBG7+KsvzrRLIQ5EXz9UMhExjgBIs58G
	 vXe8XypQ865GA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C77813FC;
	Sat, 17 Oct 2026 13:01:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 69A42362
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4DE6D4018D
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rErMNV1xHEBt for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 9E89D40176
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=WOuC0Np/czI/DWINqkr7jGaAGfminj/yqFPCNwQpZJkMoDZ7bkFut+7p+ZstDFi+h9jL
 zUaYL02yjXNZDyEZlXeDLy9F2++rD7ztX5sBCMtN6qHSjBaKRh113HL6xoUO0p7mN8JUS
 x6HDNGZz7IgKYCZ8MMIZ/LFRZFFUWt1cQRdSUN8PHhazdOzA4paU2PFTkWLYJjhWYEaJk
 fdrrtuQje69mw9fYCTOyQxHWONohPMxvm4kFgfdLnsqYP/+wqxNNFbSKmt7vKDxliK21b
 IhQwUSudFCTNr9aVAZiXsviDa0Y2oQ93BqvfNlg55ICJzoPLSJqIJxFtJjDIlYzLW2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=lybUT0N3joVAqqF7ORUJTj5DfvK7uupd0cV71jEs+0c=;
 b=TWyffpRsew2NJHgky1MfgNfDU2vnFiNgWcFSF0qC4Hsr8KXQynTtoNzppq9IWwmQCMfJ
 X/O+/ArYXnfQXDSbz5WOKDJUU3CG6XW7JaH0V2S4bcA1AEXGpaSWF0PWAh39uOOkpIilu
 oHV2yZJ0bWQRA89BUIdCXqFMqm+tB8v38rIiiVoBNhqdj9UFKbCDyawiiFSYhTU+8ZCqD
 qCh2DCMK5iRcD2UOJvrtBfZrCG8nBszvVO/o5iwCDgZk3U6ZsY1+vGD1DLGVl8BAD/m1G
 JuShDqnGLKctBg0NoIZ1pmuQ25nKVdF3d2nj8u5tXau8SS8eDZ15ftQmzPoniurdrhA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=iFdry2dn; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=iFdry2dn
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9E89D40176
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D81EA4479D;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA550C2BCFA;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=ueJM+a7vXGNBCVF6teXYhGT/FZL4prLZ3HbtP8UlHR4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=iFdry2dn2RlSnqDQGJi1Pp3W3/Q8H9VywTZbK78VsukIPRuytvZ7U7cTdDUKQcN+E
 TgLB6wPJ/+NYK+ILYCMH9aBiXGCTTpVSKyHhtTJR8K5cJHiUgacFe7nugMeUov7t84
 1vMwhSpIN+3g7TSlkFGkNgs4sEqn4Y8TVumGmkLmRv8kTKB9ID1HQminau1ONXfsl8
 l1olwq3DuMwmVRns7JzcTj8Y6aYMAL8cSx6D4V5xlwOZ0gGLB4aWQ39+PLjmTUDn7Y
 xxVmOxOpLgKDUfsdyK0j5PZ/jrK4zDGJMv0+n5tANt0j8HrXdX1AtbZa7oZddIZi9q
 ZoMYJjR7PFgOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AA5E2CCF2C9;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:26 +0200
Subject: [PATCH 10/14] test: expo: Test a box with its own colour
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-10-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=1800;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=Vbjcl9pQZ3UyhdQBRck7uib88dk+EsLCEq41Sxopc3c=;
 b=EbFKQfR29znNZa+ELxsmI6B+bMMyo0q1+JJ2xWrsL4WmmPzTz9tNyrdglbzu2E0aMwsaFeMqu
 J2jjnLinN8VDFU1bykNXfeUIWe5D958yoE7/uDkEIxedlcSM5mWvUXu
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

Add expo_box_rgb() to check that scene_box_set_rgb() records the colour on
a box.

Returns -ENOENT for a non-box object or an unknown ID.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 test/boot/expo.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index b50c32c0860..2374e61f864 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -977,3 +977,40 @@ static int expo_bg_rgb(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(expo_bg_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
+
+/* Test drawing a box in its own colour, as used for a horizontal rule */
+static int expo_box_rgb(struct unit_test_state *uts)
+{
+	struct scene_obj_box *box;
+	struct scene *scn;
+	struct udevice *dev;
+	struct expo *exp;
+
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+
+	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
+	ut_assert(scene_new(exp, SCENE_NAME1, SCENE1, &scn) > 0);
+	ut_assertok(expo_set_display(exp, dev));
+
+	ut_assert(scene_box(scn, "rule", OBJ_BOX, 2, &box) > 0);
+	ut_assertok(scene_obj_set_bbox(scn, OBJ_BOX, 10, 20, 200, 22));
+	ut_assert(!box->has_rgb);
+	ut_assertok(scene_box_set_rgb(scn, OBJ_BOX, 0x30363d));
+	ut_assert(box->has_rgb);
+	ut_asserteq(0x30363d, box->rgb);
+
+	ut_assert(scene_txt_str(scn, "text", OBJ_TEXT, STR_TEXT, "my string",
+				NULL) > 0);
+
+	/* only boxes have a colour */
+	ut_asserteq(-ENOENT, scene_box_set_rgb(scn, OBJ_TEXT, 0));
+	ut_asserteq(-ENOENT, scene_box_set_rgb(scn, 9999, 0));
+
+	ut_assertok(expo_set_scene_id(exp, SCENE1));
+	ut_assertok(expo_render(exp));
+
+	expo_destroy(exp);
+
+	return 0;
+}
+BOOTSTD_TEST(expo_box_rgb, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);

-- 
2.55.0



Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5D9CCF2C4
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E6AC340976;
	Sat, 17 Oct 2026 13:01:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id INXPbcvMf1_z; Sat, 17 Oct 2026 13:01:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35C4D4095D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242110;
	b=cEqRcPtLFuX0K6L63c9PiYphUCJZbVDhWDPbBW9BS4Az7c8qieWw58UDFSgvbDP+eo7F
	 e2oCOEk/G4qlPYusR8OBeb5R/eMwfM8WjN7xo7CVXjnwjOcC3+fPjKcqYu/+A+V8CiHpN
	 9+1M0cLiAvCHuk8vqTTLPo4m0nB/1qRYPLHbytQcDAGeEKW/N/JZuHWdfwA+UO2bbxoSM
	 hy3P20QXECR/h82B6iOraSwGRM2JaMYUxYFKiSUj0ur94/MbEq90EzLmaQWTT9ySRISFH
	 sI89+PwRdB3KO7WkSkYgO9cjbg5CBrsGCdS5vBWs00qns4yRnXr5hURTjTXJq9xFqoQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242110;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=jrAiSfzoHyGfdrkDjk0nPCuPkFcA8HOa7E26aZtiQ4Y=;
	b=EJFsUPzuGbb6rZlicN3/pgwFZaiCUScJVP6yE44D1o1SFrtdIIBDyHPzlBLRAuO6hy7U
	 guZztGWwIZUVJ5fY34yuwuRmZvVY4+l95HdpZb5QyS0eryJpoZ5d3A3Ca1aHyEfjmTQOz
	 FRj3DpCkbws041ZykAmVoQ+E8oFBafm11yfXfOzPhXWlpBDCvgH2xPhPGtn55/zEG1Jwm
	 owNbtPGoybmmghEF/4ajA1cVHmKc4K7RvWJhOvncgJ89EUdF+yaNIffoMaV4y98YRBCkb
	 c+migvfXK85L/sSvWN2XJkE9AYy1zj3YH2wUeHH5IREV9+dOoD8g37iA7eotfMy/cbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AkM4l810;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242110;
	bh=jrAiSfzoHyGfdrkDjk0nPCuPkFcA8HOa7E26aZtiQ4Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mBJh6ZFQsiHqaUiG9A3MuH2rJc+mqNh2mYFM2dmI8FHK8KERW0lgLue5WSfLOwFdK
	 BgtQwLC88dHU3kIXfa6A7lhLTpGj8B1LFRLQGgnwIjpyAJNQloa5+HcnVv0J5wL/Sh
	 j2y4Cyjoe/gZycIgUiaGU7f27+ZX8y7/CG6KwxLZxPL796VCf6r7QhRU27A37z2TmA
	 rGiEsGVQiHPu1AMjoAmwmGBNRgY74NjCeDPlqR9sayZrY+ouBTOSNy54XUov6GQD4M
	 Xu43hBtIR8e3q3u2hd1/H/j+W/Pysy16Bz7k5xx0PmIzrqZt7RpeVlBnBdhuQCaZ6B
	 3uzW/rQX/bQaw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35C4D4095D;
	Sat, 17 Oct 2026 13:01:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F3551AB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CC12409BD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id t9zouhMtSkFt for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 8F95E409D8
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=S3+EnRI5LNpyZWhV7OQdvyNkQDG+h1rTvIJahiwJMvoXJ6QHHSi9qiOQWWoGsyMolKaw
 5T99oJq0374bKIU9EeQ2DGW9ZVJ9ewIYSlZca8EsfXWIbNa/igbqJvLr6n0eR39AvDxzI
 kHbuTMloNGldMDHcXTs7u3gW/6nuYJfMI7lVZJeStifQUOCOFjcl2+mq7MXGz+GFIXIdo
 bKTU3xENyvt4eKJWTwrvH2esvK5KtGRHkRz0SFVDptT1hGtLTjaGvjgdn+pecgUPJQITv
 EICGZRYf6h4pFIjEF1OwGqw5zCldkPTsH0yGV3ajDgG5Lliuh/7YLNGeXEHx8gr8vNQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=jrAiSfzoHyGfdrkDjk0nPCuPkFcA8HOa7E26aZtiQ4Y=;
 b=LsFGYoACmSPxIMhkhaVvtaxkX17vqPhtnkQLMpCsH5GkFuuyAX8bFCyhq9EVGC6YY4QM
 MQjS2tAQY0jjnOrEkTqL++arggWK4MW5ggvB0gsWC3o5rQkYvFb8hcNS3BAIsDeppCtjl
 AuVdB7F+W94NoRDIYAO1PKMOTuoreSD9EQND6MdTG2unLB9eGqtbi9uV70KuwXxepf74W
 GlIRf4xH6oi4SJjJrYfAIA/85FTJ8YlkBrMSwXEo8RA9KZIzdOP32AqL1c+QFvBCB6w80
 C/UE3DQGUzDzoFCX1n446ENhboRD7YKFCIjzwH+tU2K4nl9819V/8q2xQiIRx+UYcUQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AkM4l810; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=AkM4l810
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F95E409D8
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A34E6022E;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AA6DC2BCFA;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=mOL3XEtHAbOwTrxhLTeuxQa1ZmaorbfaK+kA7D/LLBE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=AkM4l810faF3SJGPgcg4IW+Y9cyQ0XFzJ3RrQ1MkOCLKWGGu0b+x4HO/28Du797Lh
 BDIxuzspRCYTpwtV+m9c00d/NFbFtKbdN8yUWpnJMSPTrmoUdj6KqjyfFcBgeaxN3h
 7UxfSlvk/Ckh2WBvWjqtvIgviMacI45f5jB0ofCX3YVVRjdXJnMzXGqxiJL78mpONL
 YWxU506Nmo0g4CD09kj7JWNWiBRjY/2WdfiEf6koHwil1nJagg+rNLwGuQkQi5y65v
 ojUIgypDMJuOMxrbJkCceRplRuND3nOm8Ne0iILd9O3lb9UMjugRQ99A317b3L1zao
 wHtnlpYfWP58g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 0E502CCF2CA;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:18 +0200
Subject: [PATCH 02/14] test: expo: Add a test for menu section headers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-2-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=3257;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=AnoiUr+7DbHmSJ/S8XWOSnV6gGNomi+vIaAAAe0n6Ko=;
 b=yS1euP1foHp1UpqRFiF8sKQN0NfNOIxK9EQhznpyi+/P7C8FeplGKG5XDfeuRupqX7Kygtt3V
 4xqAGFhaypBAo/wFHfxu1QYUZhX57wrdd4JOXPH9HgD0ViX5OfDgFyf
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

Check that up/down and the initial selection skip a SCENEMIF_HEADER item
and that scene_menu_select_item() refuses it.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 test/boot/expo.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index ddfb739f9cf..5ea8c016706 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -67,6 +67,13 @@ enum {
 
 	/* pointer to current item */
 	POINTER_TEXT,
+
+	STR_ITEM3_LABEL,
+	STR_ITEM4_LABEL,
+	ITEM3,
+	ITEM3_LABEL,
+	ITEM4,
+	ITEM4_LABEL,
 };
 
 #define BAD_POINTER	((void *)1)
@@ -857,3 +864,68 @@ static int expo_test_build(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(expo_test_build, UTF_DM);
+
+/* Test that section-header menu items are skipped by selection and keys */
+static int expo_menu_header(struct unit_test_state *uts)
+{
+	struct scene_obj_menu *menu;
+	struct expo_action act;
+	struct scene *scn;
+	struct expo *exp;
+	ulong start_mem;
+
+	start_mem = ut_check_free();
+
+	ut_assertok(expo_new(EXPO_NAME, NULL, &exp));
+	ut_assert(scene_new(exp, SCENE_NAME1, SCENE1, &scn) > 0);
+	ut_assert(scene_menu(scn, "main", OBJ_MENU, &menu) > 0);
+
+	/* header, item, header, item */
+	ut_assert(scene_txt_str(scn, "h1", ITEM1_LABEL, STR_ITEM1_LABEL, "A",
+				NULL) > 0);
+	ut_assert(scene_menuitem(scn, OBJ_MENU, "hdr1", ITEM1, 0, ITEM1_LABEL,
+				 0, 0, SCENEMIF_HEADER, NULL) > 0);
+	ut_assert(scene_txt_str(scn, "l2", ITEM2_LABEL, STR_ITEM2_LABEL, "B",
+				NULL) > 0);
+	ut_assert(scene_menuitem(scn, OBJ_MENU, "item2", ITEM2, 0, ITEM2_LABEL,
+				 0, 0, 0, NULL) > 0);
+	ut_assert(scene_txt_str(scn, "h3", ITEM3_LABEL, STR_ITEM3_LABEL, "C",
+				NULL) > 0);
+	ut_assert(scene_menuitem(scn, OBJ_MENU, "hdr3", ITEM3, 0, ITEM3_LABEL,
+				 0, 0, SCENEMIF_HEADER, NULL) > 0);
+	ut_assert(scene_txt_str(scn, "l4", ITEM4_LABEL, STR_ITEM4_LABEL, "D",
+				NULL) > 0);
+	ut_assert(scene_menuitem(scn, OBJ_MENU, "item4", ITEM4, 0, ITEM4_LABEL,
+				 0, 0, 0, NULL) > 0);
+
+	/* the first selectable item is current, not the header before it */
+	ut_assertok(scene_arrange(scn));
+	ut_asserteq(ITEM2, menu->cur_item_id);
+
+	/* a header cannot be selected directly */
+	ut_asserteq(-EINVAL, scene_menu_select_item(scn, OBJ_MENU, ITEM1));
+
+	/* down skips the second header */
+	ut_assertok(expo_set_scene_id(exp, SCENE1));
+	ut_assertok(expo_send_key(exp, BKEY_DOWN));
+	ut_assertok(expo_action_get(exp, &act));
+	ut_asserteq(EXPOACT_POINT_ITEM, act.type);
+	ut_asserteq(ITEM4, act.select.id);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, ITEM4));
+
+	/* up skips it again */
+	ut_assertok(expo_send_key(exp, BKEY_UP));
+	ut_assertok(expo_action_get(exp, &act));
+	ut_asserteq(ITEM2, act.select.id);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, ITEM2));
+
+	/* nothing selectable above: the leading header gives no action */
+	ut_assertok(expo_send_key(exp, BKEY_UP));
+	ut_asserteq(-EAGAIN, expo_action_get(exp, &act));
+
+	expo_destroy(exp);
+	ut_assertok(ut_check_delta(start_mem));
+
+	return 0;
+}
+BOOTSTD_TEST(expo_menu_header, UTF_DM | UTF_SCAN_FDT);

-- 
2.55.0



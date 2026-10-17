Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2265CCF2CE
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 695E66072E;
	Sat, 17 Oct 2026 13:01:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NXyBxzvBMjmU; Sat, 17 Oct 2026 13:01:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AEDF1606BD
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242101;
	b=fqrk5PVw4PMibb4zd+kU+TuoHp3XF/YiyE+B7hPenhijpN2VFvyUCVD35LkhNAr77W8X
	 2OxT4Zz+Fi2qh8/PulyiGQEOsCFOY8a9CfJQueih0Fpytm9Bn3ZNpQpbmpHTreqAyAFi1
	 GCLRYQWKUlvg+bBsF3yODhG0mKPiiABBhHRGedmWHK5aGQyuxLoalf1vc8Ly1xDpTM81e
	 0R60PxSRlsk1wQoNgNkIs9L6UkNM3zqX4WS8dsgFlj7BCIWju4uR6hhSChs4Za/sZJAqj
	 ubh4ZmbQcdUrvWmQzZUpSlWBiBGBR3NJXdTVqvi1oNHWciEvfHzb72v5R1et4oG458g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242101;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=AbyqrN2FDByxciyzlzZkAVt2khMNqUvt9N1x/6pCyBA=;
	b=db98yPXhfDWsFn1NAzAsPrungUdB7r2nYg3n3uE19nCHvq5SbxT6UPW5OhTpmz5HAMzz
	 ro30F/KN5rvDCJb1FIbL/bBJBdHjX7gNm02mT1mcEk7101Zn1wTuusit8qedpHNN3OZKC
	 /ssbhgK+X34goDMv+0V2gjZKL5qLfRB+Ek3QzXb373fglskRqlRYU1copf27bZTLmL272
	 +lG5yFiRvt1L1P22yvW42LV/o5enK0bsM+FtafSLxfekh5Tza55i+g6FB4OMORIlxMm0e
	 LURyADTmgBComqVZ+NSE/rAOhocjoaJR5Ah4FpUV2SJftVca/dZWgIjUsLQGN3fn4+A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242101;
	bh=AbyqrN2FDByxciyzlzZkAVt2khMNqUvt9N1x/6pCyBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=DGjX5hAzCkMkdZJwK/RfI2coMJgxPdorC3R3Am6gOntelVgHHX+5vUzg7Esu2OXMT
	 PvbsXKR7HrQyLc6rCzlnImxj/gmX9MRBLWyQr11RGGe5Um/zrBA/uvmMzLySJ7UagO
	 b1bMMfeC9rAnPd5nisOgkxtp0a6JtqEqhB9KSALoQK2c4ax5HJogFqXJaCPYODDb5+
	 GtHq51eYlb9SUGPBrXQq+UcHINlpihVZGpyP4p6sSfh6XF2IIUIg2d3BAHfU27ZAYp
	 jpKYULHAnewOd20CCmnDwd4Dc9ulOQSZrrRXE0OWTOjYlKmOr3NcR/8TGIpNxq1J7T
	 cL2k6m4A8k6Ng==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEDF1606BD;
	Sat, 17 Oct 2026 13:01:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 18F9F7AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0AD7B409DB
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njdWgmHCNiBL for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 4D0EE409D0
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=qAYBVpynApkXs0QTl8pTYQHDzvE1GqhvS7J2iBpBS6foFk7lJp6OxFlEIxttVUgPNvjM
 8r4Y/yeJbGqgNwvMCwl9NDN3vfkKDr/uRbFauIDh9hqqQOLtVLHYflPZRtRkOECs3hqXl
 DrsEVSq/gI6kAIWfmhEr1/aYAc+6ZEj0ev60oDqJ7FsqLKoD2ptBQ1Mu6noxQrjAvr75W
 X6KJRgZ76lWUSVWdj5eRZc57GS1pfwSNvsTw+F3kPg4hL28WcyeUWmwtsfwg6EaDqTqm7
 vt2F3PBAONYQjO8KmrpU8sE2FUxhUCkvkDWfsPCnj7NXwAf8pzyrn8q8GvlPhswyNJw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=AbyqrN2FDByxciyzlzZkAVt2khMNqUvt9N1x/6pCyBA=;
 b=Gqkg7xfaM5xb8Fn3IFt36oVgW+xOsy4/cvFwcebO0r+KO0EcIiMTDXnZX9bog45jDG0i
 urGFJ2CN0XrN/ikHicLhb+MzxIDYeyDsm0FoOQbAc16yvOD5SLyygKE+c333N2u/yx81n
 WHmD1HfDdc3vzO4B3JfQu25GavsIgOAEv+kwfVrs2G0Yv3KFQ2s8MyloPGsKBI9TGdCaQ
 LH4X4WN226cpXnqQ9XUQWgvVw2+7cXo6jKA7PEUlqpNamSrYpawygSl/FG7RfPr3ai/4L
 q4L/mYP3bRQH1yEsBCA/rj7cq8KwwNfceT3QeEhL0jRMjb3wiNbn+U1tEMI8PioZZog==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=VxPG2SLF; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=VxPG2SLF
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4D0EE409D0
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7952D43AF4;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B5EDC2BD00;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=7BB97k3hzF7cQPbRXXuzOHcWGUCedSXFmnsgovk2+rc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=VxPG2SLF+4PnnY4U8gMmWTa0yQHtNb4LYapX5qgfLS+j58heN7JcW6Bk3C6EuwjC3
 E0Pd62m8s3FUTezxG4BlNbKUP7KXRP6O2CeYh/sNkx237pOBkiZyQkg+vxPH9EjBdZ
 9g19LHZ5cDQ5jXtrU+Cp/m6YGR85fsLcvo57HOKgvwBQs7GOXZzYpZXepq5cDt1kYj
 7AJLBgrUxPZAfTISsx9O7RKle10LjqHQsRvvLHDbYEjyOiiBE9DmxwVzWcRnvUQvGf
 l55tXVSa8b1kSkJGkPZpF5v/eT2fcCUtqIG1Hrpu02Xm4+pRW+xPCLjbeWIBiFzWn1
 mW2FdRo1ZN3QA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAE6CCF2C7;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:21 +0200
Subject: [PATCH 05/14] test: expo: Test menu wrap-around
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-5-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=1726;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=tcuyYZ6bOFix6DB65XGo7ybP7hqjrHESxrvYuJQ+VIQ=;
 b=24XcAnNfohkIQBEQMP4jMF2QiwUWO0+/NZN6aME3g+1SIJqV2dKOcZh3wwLWL5DPtQUz0DwNp
 Cn0oGsSfcXpAn8KSXfMwk3tBVZZSgWaarpl6hIOJ/cG1Ewn0z8hXDu2
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

Extend expo_menu_header() to check that with wrapping enabled up from
the first selectable item goes to the last item and down from the last
goes back to the first.

Check it's also skipping the section header and that scene_menu_set_wrap()
returns -ENOENT for an object which is not a menu.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 test/boot/expo.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/test/boot/expo.c b/test/boot/expo.c
index 19148a8892e..e52de029477 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -865,7 +865,7 @@ static int expo_test_build(struct unit_test_state *uts)
 }
 BOOTSTD_TEST(expo_test_build, UTF_DM);
 
-/* Test that section-header menu items are skipped by selection and keys */
+/* Test section headers and wrapping with up/down keys */
 static int expo_menu_header(struct unit_test_state *uts)
 {
 	struct scene_obj_menu *menu;
@@ -927,6 +927,17 @@ static int expo_menu_header(struct unit_test_state *uts)
 	ut_assertok(expo_send_key(exp, BKEY_UP));
 	ut_asserteq(-EAGAIN, expo_action_get(exp, &act));
 
+	/* with wrapping, it goes to the last item, then back to the first */
+	ut_assertok(scene_menu_set_wrap(scn, OBJ_MENU, true));
+	ut_asserteq(-ENOENT, scene_menu_set_wrap(scn, ITEM2, true));
+	ut_assertok(expo_send_key(exp, BKEY_UP));
+	ut_assertok(expo_action_get(exp, &act));
+	ut_asserteq(ITEM4, act.select.id);
+	ut_assertok(scene_menu_select_item(scn, OBJ_MENU, ITEM4));
+	ut_assertok(expo_send_key(exp, BKEY_DOWN));
+	ut_assertok(expo_action_get(exp, &act));
+	ut_asserteq(ITEM2, act.select.id);
+
 	expo_destroy(exp);
 	ut_assertok(ut_check_delta(start_mem));
 

-- 
2.55.0



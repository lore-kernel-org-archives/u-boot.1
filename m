Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0A4CD4935
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 22:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E93EB86C3F;
	Thu, 21 Sep 2023 00:58:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="plzuOW3W";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="uQP8E/mX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E06A86BC8; Thu, 21 Sep 2023 00:58:43 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D9F86BC8
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 00:58:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4RrYqN6RsHz9tLy;
 Thu, 21 Sep 2023 00:58:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6pL89n/kiBKTntYhy8woicopR/h1SQAT3VrMkTIXA4=;
 b=plzuOW3WUsu2/Z3+ivQ4soGjprcL6P/mfAUktsdcGFwXKNdF9ZgnRb9w48HoakqRRk8PKn
 KlXhjyAXsOxjc9N9eq8zgA67NA93l0lFnI6y52Je9rgWOqJl/JiXEPVhcDxMaaE7JZgexo
 SLXGRbPuGRrz+Yg89N4cxRWrYd9AfE/vm37fykaQs0faaTPpdQtbY77sl7KEF22DjThCqO
 1qUrdR8o/RY+s15aw4G/hakVBfWJvk96M+5C/VP34rnEUwSxA6UMzWaewCMr9Q4jlVY4zi
 oSrQ4+hqlY+IPFHv7eFdnGfH/fr+CCEdT9sS1gfjPOy22p0UrtzznlHnymtX6w==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1695250719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X6pL89n/kiBKTntYhy8woicopR/h1SQAT3VrMkTIXA4=;
 b=uQP8E/mXAD1wr24Eb+djvm6YHKLAG3M1q8SsQG5kD1GKF1xIh7sZKG7ZLGRoCQ8tuMIDTo
 1K/sUhu0tcp9yX7UZj0olmWEWOP9r0QINiYzVLHC8OjFhhCP5YgzGUfF0PYIxsSg6eRH4D
 M3cduORRhdov03zMJUjOZP6D+VrUR59XB/sUr7N7OXULm9xe5JIUFloZ9TkD038RB0B2zg
 GJjhblLzRSe8pJiDEdIeixyyIPZwAedsjxp+VCBLaUIfQfUyBTnSxhnZckfSvVlLnXvqmu
 pdHeLHyl+rPfgwGXX0IA/tkbA3aYr4y1DyvEucmcrw1AdNZUQUt6X4JGQrLwng==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Bin Meng <bmeng.cn@gmail.com>, Mario Six <mario.six@gdsys.cc>,
 Nikhil M Jain <n-jain1@ti.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/9] test: bdinfo: Rename bdinfo_test_move() to
 bdinfo_test_full()
Date: Thu, 21 Sep 2023 00:58:07 +0200
Message-Id: <20230920225811.153474-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
References: <20230920225811.153474-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 1et51nftaxig5ag8i76354s4ioniw994
X-MBO-RS-ID: 9d536c18c01c8ef6eed
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Rename bdinfo_test_move() to bdinfo_test_full(). The former is a
remnant of deriving this test from another test. No functional
change.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Mario Six <mario.six@gdsys.cc>
Cc: Nikhil M Jain <n-jain1@ti.com>
Cc: Simon Glass <sjg@chromium.org>
---
 test/cmd/bdinfo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/cmd/bdinfo.c b/test/cmd/bdinfo.c
index 8c09281cac0..b2896e8eb41 100644
--- a/test/cmd/bdinfo.c
+++ b/test/cmd/bdinfo.c
@@ -130,7 +130,7 @@ static int lmb_test_dump_all(struct unit_test_state *uts, struct lmb *lmb)
 	return 0;
 }
 
-static int bdinfo_test_move(struct unit_test_state *uts)
+static int bdinfo_test_full(struct unit_test_state *uts)
 {
 	struct bd_info *bd = gd->bd;
 	int i;
@@ -217,7 +217,7 @@ static int bdinfo_test_move(struct unit_test_state *uts)
 	return 0;
 }
 
-BDINFO_TEST(bdinfo_test_move, UT_TESTF_CONSOLE_REC);
+BDINFO_TEST(bdinfo_test_full, UT_TESTF_CONSOLE_REC);
 
 int do_ut_bdinfo(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 {
-- 
2.40.1


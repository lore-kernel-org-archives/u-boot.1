Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 666D2FEFB56
	for <u-boot@archiver.kernel.org>; Fri, 27 Feb 2026 14:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E9283E76;
	Fri, 27 Feb 2026 15:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=armadeus.com header.i=@armadeus.com header.b="MPd1TdM1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17AED83E81; Fri, 27 Feb 2026 15:48:51 +0100 (CET)
Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net
 [188.165.52.203])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E53F583CDF
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 15:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=armadeus.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=sebastien.szymanski@armadeus.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.110.58.221])
 by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4fMrmw3KhMz5wRr
 for <u-boot@lists.denx.de>; Fri, 27 Feb 2026 14:48:48 +0000 (UTC)
Received: from ghost-submission-7d8d68f679-5g2rp (unknown [10.110.178.59])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3D21BC2D27;
 Fri, 27 Feb 2026 14:48:48 +0000 (UTC)
Received: from armadeus.com ([37.59.142.101])
 by ghost-submission-7d8d68f679-5g2rp with ESMTPSA
 id 5EHuAtCuoWmdoRIAtfgDwA
 (envelope-from <sebastien.szymanski@armadeus.com>);
 Fri, 27 Feb 2026 14:48:48 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00456ef4f8d-0b65-46be-ba93-8a21c53c24b8,
 637205F1049F294AB8DDADB87BBF1E29B8EEA35C)
 smtp.auth=sebastien.szymanski@armadeus.com
X-OVh-ClientIp: 90.126.104.208
From: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
Date: Fri, 27 Feb 2026 15:48:26 +0100
Subject: [PATCH] kconfig/[mn]conf: handle backspace (^H) key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-kfconfig-backspace-v1-1-b8467ef50ebc@armadeus.com>
X-B4-Tracking: v=1; b=H4sIALmuoWkC/x3MQQqAIBBA0avErBNKy6KrRAubRhsEC4UIxLsnL
 d/i/wyJIlOCpckQ6eHEV6jo2wbwNMGR4KMaZCd1J+UkvMUrWHZiN+jTbZDEjKMadW9I6QFqeEe
 y/P7TdSvlA2svWZNkAAAA
X-Change-ID: 20260227-kfconfig-backspace-8c53561ae364
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>
X-Mailer: b4 0.14.3
x-ovh-tracer-id: 12596568157884569146
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGhyVXUBW1RpYNWG6MQsYcXXAyqP6k+ZeWvfBdG+il+NcB2wN2G+oaAas/Ko3TXZpAr944St55Xc3y9e/K9Hxa/TM4iez/WTAewKncLadKAQl+/SG2TTjyxDGdY6djQY/j7CXCAO10ZtYl+drwPiesL52zsJE2dxCQCmSo3vQy0CqIJMDmrYtZthgVNRybukEth6OJ07ZHGjUOGMS+59yQSAgMINAPxgJ14ucdWgJFaeAATFQwexHqKpCkiPo1drAXVwEpVkI72wnw8V1umDBv72fTc9OeEWOrtS0bpIM6eHRHCfiLpqRI88b0wNHG3M/p5qJRQpp0FOCDgQbzWfQ8sAH5NAVFJF+t48troGJqo0IgJ5jlMc9n0eGdtp0T73qIyDueaUcH5YCi5XVk57lPJFr+2SM/3IEMDVGlBRHbzApbZ+YCsTxUrIUwzxVRPwy9D2oKiMQwnX3BI4sRaxG/8h/642MFTFXBmWuZYyiEJYGj4q06Dvetgcnl83B4v6S8Hd+DL9zYzHd/rwaqN7yFUEmbO2vFjCYz69296VyxWcv3VAJHjNlCH81r4/SAr5Pve9V8j93WFg1V9g4FzvU+RWJ0Wns5HUt7pTmGiJ37goMApq4vqiL6iRkcRY/7frI8Ud8JHVWmlMZ5hNCcusKL8MUFUlrAlkRKDcPQlyDxsQQ
DKIM-Signature: a=rsa-sha256; bh=D43rH93q4g5tNzCzALYxJ/KW1bmNFm0uExH6MoH2ZkA=; 
 c=relaxed/relaxed; d=armadeus.com; h=From;
 s=ovhmo103079-selector1; t=1772203728; v=1;
 b=MPd1TdM1IBB8d7GdfBcB1zPQq1ZzMq/b2AyrIgqqdxAvecq/A3ol8XFw7979IWKwwPnov2C7
 SoEDtKaiNgoixJPWEIkSF2MaFudn+QlAsucXFCu69duzKQ5eOqdkDw/dvNYuaf3NDHtrWpJvz73
 /HAQSgce4t8p1ejArmL1ZfuMMNeSwoyO0rc24q/XnqovygKgmqNXDtpIxfRyu7tdDjsfkyudfjN
 LwGt04tJu2ByippXzFcFqVkgwlAjGkHI18zl8jpzg8qeQIdB0p8UrXVUXXWUf+EGWD044U0wTEB
 kNyPjFToOmJwNWTCAt0GqD+a14hGAsfsAcGQxvC6jlVAQ==
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

This is in the mainline kernel since v5.1-rc3:
9c38f1f04408 ("kconfig/[mn]conf: handle backspace (^H) key")

Quoting the commit's log:

"
Backspace is not working on some terminal emulators which do not send the
key code defined by terminfo. Terminals either send '^H' (8) or '^?' (127).
But currently only '^?' is handled. Let's also handle '^H' for those
terminals.
"

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 scripts/kconfig/lxdialog/inputbox.c | 3 ++-
 scripts/kconfig/nconf.c             | 2 +-
 scripts/kconfig/nconf.gui.c         | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/scripts/kconfig/lxdialog/inputbox.c b/scripts/kconfig/lxdialog/inputbox.c
index 611945611bf8..1dcfb288ee63 100644
--- a/scripts/kconfig/lxdialog/inputbox.c
+++ b/scripts/kconfig/lxdialog/inputbox.c
@@ -113,7 +113,8 @@ do_resize:
 			case KEY_DOWN:
 				break;
 			case KEY_BACKSPACE:
-			case 127:
+			case 8:   /* ^H */
+			case 127: /* ^? */
 				if (pos) {
 					wattrset(dialog, dlg.inputbox.atr);
 					if (input_x == 0) {
diff --git a/scripts/kconfig/nconf.c b/scripts/kconfig/nconf.c
index ca878212f0ab..8aba4c38cc71 100644
--- a/scripts/kconfig/nconf.c
+++ b/scripts/kconfig/nconf.c
@@ -1046,7 +1046,7 @@ static int do_match(int key, struct match_state *state, int *ans)
 		state->match_direction = FIND_NEXT_MATCH_UP;
 		*ans = get_mext_match(state->pattern,
 				state->match_direction);
-	} else if (key == KEY_BACKSPACE || key == 127) {
+	} else if (key == KEY_BACKSPACE || key == 8 || key == 127) {
 		state->pattern[strlen(state->pattern)-1] = '\0';
 		adj_match_dir(&state->match_direction);
 	} else
diff --git a/scripts/kconfig/nconf.gui.c b/scripts/kconfig/nconf.gui.c
index 2a3b853e7eaf..e88ee91af6aa 100644
--- a/scripts/kconfig/nconf.gui.c
+++ b/scripts/kconfig/nconf.gui.c
@@ -435,7 +435,8 @@ int dialog_inputbox(WINDOW *main_window,
 		case KEY_F(F_EXIT):
 		case KEY_F(F_BACK):
 			break;
-		case 127:
+		case 8:   /* ^H */
+		case 127: /* ^? */
 		case KEY_BACKSPACE:
 			if (cursor_position > 0) {
 				memmove(&result[cursor_position-1],

---
base-commit: 437ea9f8be5afaebe2d8cbab6242f1182857f21e
change-id: 20260227-kfconfig-backspace-8c53561ae364

Best regards,
-- 
Sébastien Szymanski <sebastien.szymanski@armadeus.com>


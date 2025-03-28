Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD909C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:10:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6E9820B7;
	Fri, 28 Mar 2025 14:08:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kM1LNcUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E54281E5A; Fri, 28 Mar 2025 14:07:56 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E99CF81EC5
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso63428039f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167272; x=1743772072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ka9Q4iib85U8bx0P0AWcUy8TXBoNBI7etnfiu7quEPc=;
 b=kM1LNcUxk6xqqXrCzwG0P5o9FPxOXRbYN3Okr3QOSSNE7EhAFDVwuowlH3TC88Kx5/
 0C/su2n1TPCYS/Zj6ECCAcNrdotEHsmGyMPXxiUcC6zsDmIHrZeZjZdYj+Mlmkqbg5Wr
 8t96l0XXmktIYl8B2VO87pp3q3gA+MXMwd2v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167272; x=1743772072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ka9Q4iib85U8bx0P0AWcUy8TXBoNBI7etnfiu7quEPc=;
 b=hlfQLV6RF3sJn3mfM5IKGkuj3Z+Eu3Ba1zArQSSeysm0UUcXZRt+v5gvqK5SVtT6gW
 Fd/pkMzi/U12NyoK6aMJKke3CNkBFNy6+QrwbmOJ3Ax50Bw+W4L3uZ1729WajZyIgjOJ
 G4bk7GcM48IW2p50hxmZYYD2lv0aFtXdqs9jmEifXYR2/06RFhQ4PYaejHq6VZvbNRzh
 s8OIwq6hbgfqF73K1W+Fq5A7ZGXy/0S6fGGSDTK0q/7GB68mzQCjWJgVjtWqYZ3Vxclh
 Qq5KB2tLO9y5Hfrt4p8FneA65Lm8WvRFux9OU44G7b+WBjNuSFU7jkux3AKdjfCyqqib
 wMjw==
X-Gm-Message-State: AOJu0YzLZSAaHDlWUFLwuv2vq/ZF5U9q/6Tv2IGpymndJn++r82+AMcn
 XTlTRG1L8qmid2XoR7sYxLPDbns+wAq57/tXILzdhWXLixCiNVcUpH8IcpreVadkEi1L9lK0dSU
 =
X-Gm-Gg: ASbGncv6pjPMpckmNpXdaO3YlSFl41TUI3b246aKYuGlQuvolpXtHb1rsNetIm0V86m
 554+YQkecNyUniPv+ahC2bO7H3i7V37XzN3Gf0P0OOvJcOJ0baNM19FhnHtnoivwWOfzi4S6zAP
 2hwKGOall8IeHpn/pjTICdNC7gVpZememgp4J4pksJkj3gGezaizoQDKdXbWvnD2czdxLcKkTrN
 HP1wd8J5H0nRXFKq46A5YT1OKqI9TrnqCchcmdTgBcwDS+n+Kok/s5ZlU/2dKU0h31RjMnyLgVJ
 lcrexrUqMBiaKLl/tKW9ddngvnZFu9PnW8v8cTgonecj96jbsf7+2pqKtw9a0xE8Xav6wetouF6
 mGKdAjw==
X-Google-Smtp-Source: AGHT+IHKxoJVFig7wq03/G+vwQZBDbEyilFf7tEO9URkSD+g0V3zxKthuK5fitXgumZw5qT++nQJxA==
X-Received: by 2002:a05:6602:3897:b0:85c:c7f9:9a23 with SMTP id
 ca18e2360f4ac-85e8217f462mr1099434139f.14.1743167271856; 
 Fri, 28 Mar 2025 06:07:51 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/56] expo: Move cedit-state fields into expo
Date: Fri, 28 Mar 2025 07:06:05 -0600
Message-ID: <20250328130713.2612648-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Move the boolean flags into struct expo so that the state can be
maintained over function calls.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c   | 17 ++++++++---------
 include/expo.h |  4 ++++
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 9baef39a0cd..3703538e5dc 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -154,7 +154,6 @@ int cedit_run(struct expo *exp)
 	struct video_priv *vid_priv;
 	uint scene_id;
 	struct scene *scn;
-	bool done, save;
 	int ret;
 
 	ret = cedit_prepare(exp, &vid_priv, &scn);
@@ -162,8 +161,8 @@ int cedit_run(struct expo *exp)
 		return log_msg_ret("prep", ret);
 	scene_id = ret;
 
-	done = false;
-	save = false;
+	exp->done = false;
+	exp->save = false;
 	do {
 		struct expo_action act;
 
@@ -179,11 +178,11 @@ int cedit_run(struct expo *exp)
 				cedit_arange(exp, vid_priv, scene_id);
 				switch (scn->highlight_id) {
 				case EXPOID_SAVE:
-					done = true;
-					save = true;
+					exp->done = true;
+					exp->save = true;
 					break;
 				case EXPOID_DISCARD:
-					done = true;
+					exp->done = true;
 					break;
 				}
 				break;
@@ -197,7 +196,7 @@ int cedit_run(struct expo *exp)
 				break;
 			case EXPOACT_QUIT:
 				log_debug("quitting\n");
-				done = true;
+				exp->done = true;
 				break;
 			default:
 				break;
@@ -205,11 +204,11 @@ int cedit_run(struct expo *exp)
 		} else if (ret != -EAGAIN) {
 			LOGR("cep", ret);
 		}
-	} while (!done);
+	} while (!exp->done);
 
 	if (ret)
 		return log_msg_ret("end", ret);
-	if (!save)
+	if (!exp->save)
 		return -EACCES;
 
 	return 0;
diff --git a/include/expo.h b/include/expo.h
index 63452bbdd6a..f8d44c0ea20 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -105,6 +105,8 @@ struct expo_theme {
  * @text_mode: true to use text mode for the menu (no vidconsole)
  * @popup: true to use popup menus, instead of showing all items
  * @priv: Private data for the controller
+ * @done: Indicates that a cedit session is complete and the user has quit
+ * @save: Indicates that cedit data should be saved, rather than discarded
  * @theme: Information about fonts styles, etc.
  * @scene_head: List of scenes
  * @str_head: list of strings
@@ -120,6 +122,8 @@ struct expo {
 	bool text_mode;
 	bool popup;
 	void *priv;
+	bool done;
+	bool save;
 	struct expo_theme theme;
 	struct list_head scene_head;
 	struct list_head str_head;
-- 
2.43.0


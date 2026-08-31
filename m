Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0A36C624A4
	for <u-boot@archiver.kernel.org>; Mon, 31 Aug 2026 16:57:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D12360658;
	Mon, 31 Aug 2026 16:57:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Pcq9X7C6w_Ak; Mon, 31 Aug 2026 16:57:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788195477;
	bh=/D6v3LAQGDzIQ1Vx1gtiCq97NveasOxhFeLIyCs9L4I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=bxA89/n49SnUdcIfF6z/z6BQndOcOgzb0g6qJ+ihBAE+lTIX2cqdWxrem5DJteaGT
	 OIQ01MnRTkh84CqshFhjQAc6Ur4PgcF6BazgQ0Lvoe6CaJa4TONEYRF0dHd+Mk2DWu
	 5JtERFL519UEgZSg3HbQeykU4QuIU/6j7ntf2MzcBTj9nC4Y3MxMKZyec/BQ2qmrHa
	 3Zn9kzZht6mKc/fue4J3UINN5dT5j+ljoHIobr3MZp1JNaIAkuTAssbZWXrvNdsyxT
	 jhpqtQyvO8CejUw3MepuY96mMex8F7j2hmEUvP63qvQl7T6Vw9MZNws3dNG6R5w7X7
	 mbI4pWVQ2lWwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9180D60627;
	Mon, 31 Aug 2026 16:57:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9E8EF2AA
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 16:31:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 84157404F6
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 16:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvGJJ_TBU5JB for <u-boot@lists.u-boot-project.org>;
 Mon, 31 Aug 2026 16:31:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=valentin.haudiquet@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=m810gzn5
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 7A478404F2
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 16:31:14 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5EE093F610
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1788193872;
 bh=/D6v3LAQGDzIQ1Vx1gtiCq97NveasOxhFeLIyCs9L4I=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=m810gzn5eNnhir2r4LAqh+YCYcABPLSAp/yf520tAQ00F6aXLQKAYkp6yu1FIefhl
 4SohPilXjFYfRiMG3PLd6ANioETEvs0Iz+v3tZtTUthcwt1ooc9qjeneiNyxhG56tg
 MaP00IR+LkYrjlcDWARfys8s6erkNV79bZrC8gMLFBSu5y75ev9vq9QiFmkQkxjoit
 r62NZDPv4gXUmy5NXMPzVy/2N+jtD3FyLGKUo1o4isdBU0pqsBaOcDw2/2iKuuIcBd
 h1dqGRPZJzuugqjkTwPle8N8ntCdLpu6AEaOrviXKmVZ8hWBr1P4FBAw5QEueQwG6t
 7KnJ7NAui0Gvyssop1GaJWJdCTT+6yfKoNfJIvSyMGmVw1EFZA6NG+GTBaYZeWLAUP
 CkAQLYF3G1TYJQEwwqlA/Yym1+HEwsGjHtMWOjvD40p8krFy4HQjO8FV7ElrcK9niN
 GvQqcIukNIoJK3aTZ8lioiKTLAkNROfOHuF8BRyvyr5mckkVcLLvpJ+uSm5bHEWa6s
 J62E6j1+xM0gNZyrDEn2Q9k8tvdAe0h6/S8vFzkAtyzHeW9zIxbJqF5dF3eqCXBoyw
 TEaPe+mGQnsfgFqb68QE7Pjw6rsSV99Bn8VNz162jcxfei+H0DcTzOtGogY5jDoNtC
 L2qUEjkxmgbg5SWJrB2khlBg=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4997b060af8so22272175e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 31 Aug 2026 09:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788193872; x=1788798672;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/D6v3LAQGDzIQ1Vx1gtiCq97NveasOxhFeLIyCs9L4I=;
 b=I/k6xK7HCZGHzKynLrNDYLj+Iv6KNsv/dKBVObPAauEUwBcYAEBgJIL8pihwCyFL57
 L3dW4IksDJi98mgLcCw+oCdHtjkYcHfvlO7WLydRushf6ZufGco7N8oHr684MzwOwmyA
 cgQotvJA7K65Ro15gR3f6bawDL0ylVkVMeLoAbbub7RvZAL9XQabTA/VarylOlRp8McK
 +PUe/rKU18STUd0trmKXCkxVd5WNtyz4YPli/yMaVDPzadUiiEH4xtM1nYZqQ3kZgn0O
 EbvJ5W1SINtERId3XBlc3hO/b8cOO4UNywZtjXZlzZ1rwjXS9Bf87AVLYw9H4MXvIQ46
 4dbg==
X-Gm-Message-State: AFuF++nBHU4biwMqG/nikK8+PFfAUhiSodKyPjB7MLBBQ6+ae54FO4AE
 EFPKzOvmFY1j+e2OUjtqMYqBs1wgXHmS/CeR6kgGCRLr4SknrzWBIzCqz2EZiXoioTkh1O/Hq3m
 Y51D7oRQHVjeOhMofBOmpt0Tn2LZeugv4qw4h/jRWMgx5IRLPeT/aKIEECY0rSlN0HKKlMY/3Aj
 rQf6ZAWl4LAGok6GXv/Q==
X-Gm-Gg: AR+sD10OgU2ezl1b+HKK30LTxIyUZgHOm2mAC7SldjcXmBV/ySWfaGxAr/DLvxGJjR6
 OdIW6ysjRobC1eWNzMRCEl7wiPYz3c+qwob/EQeJlG9CmSV7LEs1CibhaADtr3Ff7wBCOTlzVE5
 Dkzme0wycqJ9wNkohV/GoNzPY9qfquSLEgDcv5gTtcyPQsLZpDr8dYOQpsBwtbKelqIErnr2fWD
 gV+Kvq8lnEJVJD9gMfdszPKeD/CCMNx1lz5+wEKoHYb4eo2JH7A4/oAMyd/VjJZAnj2jezUMTg9
 RPoF60mSUwr26VZsHV75oymfyhX7L3XVTomY0YRDd13jxw9/XNvJm+46n8ckkFK/vMSc3hx/SN3
 Z4lBTx6IoL3UlvzpdF6dRAJNnbkL/f20Wng==
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr446689495e9.6.1788193871785; 
 Mon, 31 Aug 2026 09:31:11 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0a:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-49b91c276efmr446688485e9.6.1788193871255; 
 Mon, 31 Aug 2026 09:31:11 -0700 (PDT)
Received: from k6.lan (141.175.65.37.rev.sfr.net. [37.65.175.141])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cca3e642dsm180013475e9.2.2026.08.31.09.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 09:31:10 -0700 (PDT)
From: Valentin Haudiquet <valentin.haudiquet@canonical.com>
To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] video: console: fix scrolling on rotated consoles
Date: Mon, 31 Aug 2026 18:30:56 +0200
Message-ID: <20260831163056.3854693-1-valentin.haudiquet@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 31 Aug 2026 16:57:55 +0000
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

For odd rotations (rot=1 and rot=3) the console rows advance along the
physical X axis by the font height (priv->y_charsize): console_move_rows()
and console_set_row() treat a row as fontdata->height physical columns.

But the scroll condition in vidconsole_newline() compared the cursor
position against the font *width* (priv->x_charsize):

    priv->ycur + priv->x_charsize > vid_priv->xsize

The condition is only met at the bottom boundary when
(xsize % font_height) < font_width. With CONFIG_VIDEO_FONT_16X32 on a
1200x1920 panel used with rot=3, xsize % 32 == 16 == font_width, so the
condition is never true at the boundary: the console fills the visible
rows and then keeps drawing past the right screen edge, corrupting the
following scanout line (and past the framebuffer allocation on the last
scanout line), with no visible scrolling.

Use priv->y_charsize in the odd-rotation branch, matching the even-
rotation branch which already correctly compares against the character
height. With this the cursor wraps back to row 0 and scrolling advances
by one row per newline as expected.

Fixes: 18a85cf7b5da ("video: Avoid starting a new line to close to the bottom")
Signed-off-by: Valentin Haudiquet <valentin.haudiquet@canonical.com>
---

Tested on a Kukui-Krane Lenovo IdeaPad Duet ARM Chromebook (rot=3 panel), 
while experimenting with getting U-Boot to run on that platform. 

 drivers/video/vidconsole-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index f1b2d61bd8f..008c8b70e08 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -95,7 +95,7 @@ static void vidconsole_newline(struct udevice *dev)
 
 	/* Check if we need to scroll the terminal */
 	if (vid_priv->rot % 2 ?
-	    priv->ycur + priv->x_charsize > vid_priv->xsize :
+	    priv->ycur + priv->y_charsize > vid_priv->xsize :
 	    priv->ycur + priv->y_charsize > vid_priv->ysize) {
 		vidconsole_move_rows(dev, 0, rows, priv->rows - rows);
 		for (i = 0; i < rows; i++)
-- 
2.53.0


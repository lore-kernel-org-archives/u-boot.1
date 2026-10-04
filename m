Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23B4CA5FFE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 05:13:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3D0C80D99;
	Mon,  5 Oct 2026 05:13:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TxJvh768AAYQ; Mon,  5 Oct 2026 05:13:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3B5D380E1A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791177190;
	b=SY5aWioEENY8S2839VIIrsRUDABnDVSjb3Q2O7oG0nm/B4VyYOwGjbQa1vpFopY/FYnb
	 gSDd9b4xEbelf3vE5YeXeU7BUbxuMZrzhZJ7L3bkZJjSecHOTmA5RXC7qAxelzg16+yYk
	 i6tSCATr+fLeRFYHvRVDb+0EnBQ620BtrSnjpJy00vEIDzOkOI8IOZLDZlmrRosNaUutF
	 f+7z5Mze/KyvQCCQxB9222XaPTC41aPq5TS0hrz550LPeJHmjty5KVU/KwmftMIjoG2Pm
	 evCsZvMEV53BzvRLhFHIdM3AvPtEFE1CCz+xmJhHYogtPVYZOjy6ZrNdAC83w0QOXVg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791177190;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=Ns2OPZXmg99WgbCY1dAJrLMYUEH2QJUNlRXypuYqieU=;
	b=jz1bSMXnB6Q8FtcahCuz63LqK7fj4DmEO1nI0bp2DuLZ7CrW7oVGSKqZNuhOYkHR0lNh
	 QUrz0URiBnFDLOaYzjb/nzSI1mPHn0sC8cBb2/pi6teq8ZD6EwfrrNB+8Irr+5FvYyMne
	 Nyb0fjZnG+2t6vJ6D8avM0cs/kr72/ZEbPHqkl3dzyvxAWAeA3C7iYt1B2V2Vlp0YRmJW
	 glPKo39TWtQzcr6zboAy1f2B+R0TjWD+6nux/vWzwXgN1F92TSFv9jt+2Xh71FVDmZeIi
	 V2JV3G2waW0SQNJv5NFaOxhZ9UF6ItNXlCpQ0l8vdjLN3QFcVM+3UrBiX3TalHubDgw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791177190;
	bh=Ns2OPZXmg99WgbCY1dAJrLMYUEH2QJUNlRXypuYqieU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=NqozN9t/yUKRzx05Yp3trUEpVq9uvwEi/aj+Li9Sy3asU/U5B+lQ5lio/p7N2oIK0
	 DcYXIh21MQ6W9phQVQK2OGgGsWWPWdHeRvNSZ5yKaBMMO66DA2i9K7SyLUKmANzZ62
	 wbS4yymZrT0f+nrGGaBzM93Ce5+TiGi9xejCVa70TlRYwaU67zgleUPR1VWv7tbrvj
	 mzli3CxYedeYt6ALvJsfwT81pFm0jWv+z4uXKW1NDwp4D1X3mTKBWvno/C3jYWO1IU
	 c/4hoOZxZS9dGhcXs2zSHVifYij+A9/AIpDSJJn1YUqwGCBmoCymMfVzynMJ4RpI1f
	 UwKBeN+/HVKBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B5D380E1A;
	Mon,  5 Oct 2026 05:13:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id C6C91323
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:47:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ACC46406BE
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:47:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lI5bg09jyeGm for <u-boot@lists.u-boot-project.org>;
 Sun,  4 Oct 2026 19:47:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org AE014406B9
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791143253;
 b=rkA9Z4i1DFcpjRsPXcANUmcYernKPA4QqHJDBJsmmODROgmF+ph3QmKg4rVtUZwSQsbJ
 d/BlITyr1nragB0XEfWhjfMudNngMm6Q/hHQMG+ja3r3gqpIfwZ9vYjv8O7NILa3Yq5Rc
 31Md25pRtfm84vZzSjki81kfhj1bTBC+ZrSTCt2plrgb8SryqdPWTNf4DC2iFptLqFiGR
 aqFPKWPSN5yEMaB9jUAyiRGMWS1HNoZRxb9jRb615iSsHSE5r87oAE6lY6BW+2xIoEuUG
 puNkBA/VWYt42ArdFKCCRt9xhwI9sNzVLs9lZdX9VBk8omD8Sf807etNXoMwoDQR/CQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791143253;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=Ns2OPZXmg99WgbCY1dAJrLMYUEH2QJUNlRXypuYqieU=;
 b=WAkKx4AXxaOlASMdpi0CuUKPYlSMbm9Xr58a/8iLH7LxO6Ueg3M3qXPja20/kfiYha2z
 2k+9avFdv2X3TvWrKOvBtVkDcCSqrOUyPLku/LqSag273yK11+tC6Fqkf1TKUqBNu6hfz
 RsgVmmBtkou5z4MHUHSLOTo4RkWC1CyxgYdDbYs0Pi5ux32unkE+nKTWrB0xcE9rsAxYh
 vDMNvBhjQ6LaWK1u4ckJnZ1ueLwgVrr4zdwnFxv9WFc97kqA+92CAfWpleugbNXesKZUI
 ZGUkSH9oCP+55tGBFB0q92CgpQSNVLQLmH7mguQlLZnMUrI33Ei5R0/MqaX0yWfohAg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=kLPVBYTk; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=kLPVBYTk
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp4.osuosl.org (Postfix) with ESMTPS id AE014406B9
 for <u-boot@lists.u-boot-project.org>; Sun,  4 Oct 2026 19:47:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 588A460120;
 Sun,  4 Oct 2026 19:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E68CFC2BCB9;
 Sun,  4 Oct 2026 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791143249;
 bh=frnSP+CdEPLLbkccf2GM2YzkxP35/vQdvncax2fztIY=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=kLPVBYTkbr1OhzsazMjkxoauMbN8SsFgbTo/iliiHIpg+bS3G7xd508F03HAc3IJ0
 bcZf4kSY3+IsPm4d+dJCCuX9uZk1f+pYEceknq7vD9yRTImpa/kkcZqIGZDe6qkw5F
 6aDuj0+VyT/pJSkg+dOsx96bUQL+XuylF+H4vt9lc3QBeGXem3+mKJqltPJ0LthydA
 O9JzUk+m9tk/MxuZx3BE9m64PyqlQIlClMAI4nguCk6otVxFLFHbYLYuPvsSIG4o4P
 9h2MU++R9JStkTVyYRKPMnyVb9dgMS4LvxQUR55ZkmU0hxqC0qxkl2SU1U6lF9muR1
 FFL+H6a9HkjLA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id C306CCA5FEC;
 Sun,  4 Oct 2026 19:47:29 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sun, 04 Oct 2026 21:47:24 +0200
Subject: [PATCH v2] video: console: clear rows stride-aware in set_row
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-b4-framebuffer-stride-fix-v2-1-923af6708491@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NSw6CMBRFt2I69pm+puHjyH0YBv28So1Q0haiI
 ezdghtweG7uvWdliaKnxK6nlUVafPJhLCDOJ2Z6NT4IvC3MBBcVci5AS3BRDaRn5yhCytFbAuf
 fUNUGbW3bBqllZT9FKvHxfe9+nGb9JJP3w73R+5RD/BzyBffeP54FAUGqRraNxEpzvE0x5DAOy
 r8uJgys27btC6jm23vZAAAA
X-Change-ID: 20261002-b4-framebuffer-stride-fix-67c1d7d981e9
To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>, Simon Glass <sjg@chromium.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791143248; l=3984;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=HwbrIMmhKvc7bUtP00b6jwcxMskb4BSruE7UiQCRNDI=;
 b=z3CzFSZNnK/Vp+PMAMMjRtTIdi1qJmIY5/y3j2QzoS2ballZ2JRhxnXPVFoPyrwVzrsX9+/Ai
 Bgotq5JW9xtABh5BAeputI0u38mg3bq84wFS1+Jmxv1/6JcjVjwrSKL
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 05:12:03 +0000
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

console_set_row() and console_set_row_2() clear a row with a single
contiguous fill assuming line_length == xsize * pbytes. A stride-padded
framebuffer inherited from a prior boot stage (e.g. via
simple-framebuffer) breaks that assumption leaving stale pixels after
scroll.

Use video_fill_part() which already steps per scanline by
line_length.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Found while testing the scrollback viewer against a stride-padded
splash framebuffer inherited via simple-framebuffer.

console_set_row() and console_set_row_2() clear rows assuming
line_length == xsize * pbytes. Fix them to step per scanline by
line_length instead.
---
Changes in v2:
- Switch to video_fill_part() which already handles stride
- Link to v1: https://patch.msgid.link/20261002-b4-framebuffer-stride-fix-v1-1-4a8498416b01@protonmail.com

To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/video/console_normal.c | 26 +++-----------------------
 drivers/video/console_rotate.c | 23 ++++-------------------
 2 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
index 07db613ac53..9a3d08aad02 100644
--- a/drivers/video/console_normal.c
+++ b/drivers/video/console_normal.c
@@ -18,30 +18,10 @@ static int console_set_row(struct udevice *dev, uint row, int clr)
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
 	struct console_simple_priv *priv = dev_get_priv(dev);
 	struct video_fontdata *fontdata = priv->fontdata;
-	void *line, *dst, *end;
-	int pixels = fontdata->height * vid_priv->xsize;
-	int ret;
-	int i;
-	int pbytes;
 
-	ret = check_bpix_support(vid_priv->bpix);
-	if (ret)
-		return ret;
-
-	line = vid_priv->fb + row * fontdata->height * vid_priv->line_length;
-	dst = line;
-	pbytes = VNBYTES(vid_priv->bpix);
-	for (i = 0; i < pixels; i++)
-		fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
-	end = dst;
-
-	video_damage(dev->parent,
-		     0,
-		     fontdata->height * row,
-		     vid_priv->xsize,
-		     fontdata->height);
-
-	return 0;
+	return video_fill_part(dev->parent, 0, row * fontdata->height,
+				vid_priv->xsize,
+				(row + 1) * fontdata->height, clr);
 }
 
 static int console_move_rows(struct udevice *dev, uint rowdst,
diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
index 886b25dcfaf..6feacd43b6c 100644
--- a/drivers/video/console_rotate.c
+++ b/drivers/video/console_rotate.c
@@ -112,26 +112,11 @@ static int console_set_row_2(struct udevice *dev, uint row, int clr)
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
 	struct console_simple_priv *priv = dev_get_priv(dev);
 	struct video_fontdata *fontdata = priv->fontdata;
-	void *start, *line, *dst, *end;
-	int pixels = fontdata->height * vid_priv->xsize;
-	int i;
-	int pbytes = VNBYTES(vid_priv->bpix);
-
-	start = vid_priv->fb + vid_priv->ysize * vid_priv->line_length -
-		(row + 1) * fontdata->height * vid_priv->line_length;
-	line = start;
-	dst = line;
-	for (i = 0; i < pixels; i++)
-		fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
-	end = dst;
 
-	video_damage(dev->parent,
-		     0,
-		     vid_priv->ysize - (row + 1) * fontdata->height,
-		     vid_priv->xsize,
-		     fontdata->height);
-
-	return 0;
+	return video_fill_part(dev->parent, 0,
+				vid_priv->ysize - (row + 1) * fontdata->height,
+				vid_priv->xsize,
+				vid_priv->ysize - row * fontdata->height, clr);
 }
 
 static int console_move_rows_2(struct udevice *dev, uint rowdst, uint rowsrc,

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261002-b4-framebuffer-stride-fix-67c1d7d981e9

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>



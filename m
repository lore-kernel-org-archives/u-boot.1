Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E42FCA5FDD
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 21:31:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66D9260DB6;
	Fri,  2 Oct 2026 21:31:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8yuD9Enm7chT; Fri,  2 Oct 2026 21:31:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9FB6A60D93
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790976681;
	b=SS41CRMS6TZGKUw3iHnmZuJDhN9TftZr/41uMPcwJMxoxkculVjPQbyaWuyHUyIxqp+l
	 DiQr6g0M+YMj9hoj2Q9ShckgyLBDbNpgz/knS+5Vo+sqxnIpsmbdv5tvmcsTsRmJWWb5t
	 bSePkIo6O+QDnjlCe8Q2dP9EnXRlopXNAhZlqiQK6Ja6udNDd7yA4dTbEHIFbjaWr3u08
	 497wm2Hu8Syz6kjVgk+0efF6ncJ+vwXf3yjAKtagepDcb/9IK0PLqSH+gRRekaTY7p0+O
	 oyioNoSs9FMzLUsAoGtIkwJcHbutVZpB3ijKsA+J66K2fgNGSRSURkpUC59TEofA4kg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790976681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=K4BSTuZwisVd9W9u3cwhxo2o+HQce5LjXP1Y71bujlM=;
	b=osv0F7n51kok8V0O1Cey030MFwCuk/jumkJpPW0le1WuDKbPEy94S1kLu+ZPB/H+W6uO
	 Uj81K8hQKEvqrT2aKCBD2OeR1LfH/2eqNMqRS2YLPB5oAIe7fe23fG3+jy18WDAJRAPdP
	 AYiLdZyPjA5G+MUZyndAsfUUsko0A0UM4kCfI/U2zlyYsbuy+HGg+vrZFWpbprYpjLzHS
	 Xj3dFZsGw/BB/GBfdJ4fMFYT8kikTuSzK42dfGKnKdgVKC3OIfTZBiQLLb4eZmWbNnzE/
	 NdUIhSpgjn3jyKiz4MxYrhPt3j8OBHHm3HT7cf/3iU1/SxDbiN/rcloJQQwJYyRmRFQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790976681;
	bh=K4BSTuZwisVd9W9u3cwhxo2o+HQce5LjXP1Y71bujlM=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=vGREQziIw3ZQ387E3qJIgqkRFQRiOQpxOOERjXKG/49klwn7WHztbjTcnV+Rt3U6M
	 fSGUevuDr2s8op9vkGk/WAeFOUpLJw6Z/FTTboeFIWmLWyXjDryAiNiMjNdpU/MZDY
	 BQRgPXDYysAYmHdf+2VQDFMHVc/cX4qdNBnoL7IhpEcvd+ZT2da1HqNxx3EEWWCzDk
	 J3JrtocUB5qlCkmtGtn4Zyi9g2oZ9iE2Y/DLbA9KN783ieXk99M5KoXeOyy2kOAUAk
	 nyhDP3Xc1aeIgKf0XxrLiAPx0ywGUdwdLyfWCBU/UmYMY2NNbbTCHDbnoVcXuof5PS
	 HEREX2BbIsYnQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9FB6A60D93;
	Fri,  2 Oct 2026 21:31:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id D363D1D2
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:19:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C4D7C40DEC
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:19:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z49nCYINP7Nl for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 21:19:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 07FF240BE4
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790975981;
 b=WTa3gczmavGJcXB8A/bIvQVDPT7rgNP7UyrkmAfyDPUrqPbSMHyHVrxftRDF/G+1CrTq
 XHMvghRFrYTAlrkUDa9Fo/lPWYp2lh9FMLsUYqwqyzz60P6f4o/GOq7ncYXGxFNvJND5F
 G6fMIcp6rPK7ZAQvWmOjVnoglIi27xT5CWvyDye+PRbkKtyDUAB4+zSmlrzNHrRrHz7d+
 2cw9a/SFbLNerE2+Rnpf1p7lV+4dZ/4ky1WzOUo0mNwmNsAOTxx0xDKizktMwGB7X5rag
 JP8ipo9dV6iWMMgVOjm5iQxzr2qL4rEOlFIqolpld5gUJYbz72zboIEKqY4UxlMsaoA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790975981;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=K4BSTuZwisVd9W9u3cwhxo2o+HQce5LjXP1Y71bujlM=;
 b=GF8sT0fG8iroWlVeOIGIMXTdfqV8ou+nuvqO37UpgW6QCmHJREFMDQN+bdFBT18m+xF3
 nv9Flfh71WIaTEWOsdgrfvNGTEimLWdBQWrd0Fink5duUXTGKH+KjnymlRGOPTW7srviT
 jYs9fqo0rzwoJRVDGYFRPYfZtSztSkBJNu8B5bCyFaHP+ftVr9SelgqjGbmYW968sL1G1
 KyrlHlFGvdQTrVuUDKRa9aopm2Pae/oCKfLliuUVmEiAtrMPwvW6H14JjFTF2C1/ncVje
 d0FfCt+BIF0FIKmKztnwnYcw+bc66Cxbqs/l/vAoVa9u1oUZpFSn4CNkrFuuGuaxHPg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CfvAcbxs; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=CfvAcbxs
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 07FF240BE4
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 21:19:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 926B660AB0;
 Fri,  2 Oct 2026 21:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44A46C2BCF4;
 Fri,  2 Oct 2026 21:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1790975979;
 bh=HWB+4PGyOoxCItyhDUMZEkFYaP2vQOPxkpttgoyQiPE=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=CfvAcbxs3hjt8J1I63GzoEHmp6p+BaffTa68Z38MRzyLJoow4Xh981E78Wn5z2DfO
 0OrspHPiBxsHoOM+cezxrind0HRvAmjy9ZPScF/D9pt/5mPhg9EG9pZ7OHVG5lq4q8
 oMhEY8w6ujX4iYGtloTsn0JPRqIzxXAx056ef5uSxIQHvfJWCo/QyMZMcpzJxORlRI
 xFsfS7x8ooBQUx1MTkWnDG5X4sabZiAYbv3hR3r9liGk8YWhQWuf6Yvzrq0AG+SQPu
 LYIFz7xhpMGxJWHiJf0bC9MhaeBsydroKIdAAUgrfFg8fj6GIPiIndOwEQA8LRQAtg
 xMfIaVnpA5PwA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 20249CA5FDD;
 Fri,  2 Oct 2026 21:19:39 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Fri, 02 Oct 2026 23:19:31 +0200
Subject: [PATCH] video: console: clear rows stride-aware in set_row
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-b4-framebuffer-stride-fix-v1-1-4a8498416b01@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMUQrCMBCE4auUfXYhCdJaryI+NMlEV7DKbitC6
 d2N7eM3MP9CBhUYnZuFFB8xeY0V/tBQug/jDSy5moILrXcucDxy0eGJOJcCZZtUMrjIl9su+dz
 l/uTRU/2/FXXe2pfrbpvjA2n6B2ldfz9m7jp9AAAA
X-Change-ID: 20261002-b4-framebuffer-stride-fix-67c1d7d981e9
To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, David Heidelberg <david@ixit.cz>, 
 Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790975978; l=3436;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=EuFkYrM/XuLNQZtyrH4tPGeKWmdV6xYzb0sMMzvRHp4=;
 b=AUDj6+1RHnfXiTgpPjroRS3k4bb2e0ojBfqGfytiRUPzh3OyS+uHkf96gd9mRR/0UHAlg0hWF
 TA0y4/mXxGLADUbLauac0kBzNgxnXv/lXZPGxp8MwVth68KwnnG9uS+
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 02 Oct 2026 21:31:14 +0000
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

Step per scanline by line_length instead matching the glyph renderer.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Found while testing the scrollback viewer against a stride-padded
splash framebuffer inherited via simple-framebuffer.

console_set_row() and console_set_row_2() clear rows assuming
line_length == xsize * pbytes. Fix them to step per scanline by
line_length instead.
---
 drivers/video/console_normal.c | 16 +++++++++-------
 drivers/video/console_rotate.c | 16 +++++++++-------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
index 07db613ac53..f86cf24349d 100644
--- a/drivers/video/console_normal.c
+++ b/drivers/video/console_normal.c
@@ -18,10 +18,9 @@ static int console_set_row(struct udevice *dev, uint row, int clr)
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
 	struct console_simple_priv *priv = dev_get_priv(dev);
 	struct video_fontdata *fontdata = priv->fontdata;
-	void *line, *dst, *end;
-	int pixels = fontdata->height * vid_priv->xsize;
+	void *line, *dst;
 	int ret;
-	int i;
+	int i, j;
 	int pbytes;
 
 	ret = check_bpix_support(vid_priv->bpix);
@@ -29,11 +28,14 @@ static int console_set_row(struct udevice *dev, uint row, int clr)
 		return ret;
 
 	line = vid_priv->fb + row * fontdata->height * vid_priv->line_length;
-	dst = line;
 	pbytes = VNBYTES(vid_priv->bpix);
-	for (i = 0; i < pixels; i++)
-		fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
-	end = dst;
+
+	for (j = 0; j < fontdata->height; j++) {
+		dst = line;
+		for (i = 0; i < vid_priv->xsize; i++)
+			fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
+		line += vid_priv->line_length;
+	}
 
 	video_damage(dev->parent,
 		     0,
diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
index 886b25dcfaf..4423aded25a 100644
--- a/drivers/video/console_rotate.c
+++ b/drivers/video/console_rotate.c
@@ -112,18 +112,20 @@ static int console_set_row_2(struct udevice *dev, uint row, int clr)
 	struct video_priv *vid_priv = dev_get_uclass_priv(dev->parent);
 	struct console_simple_priv *priv = dev_get_priv(dev);
 	struct video_fontdata *fontdata = priv->fontdata;
-	void *start, *line, *dst, *end;
-	int pixels = fontdata->height * vid_priv->xsize;
-	int i;
+	void *start, *line, *dst;
+	int i, j;
 	int pbytes = VNBYTES(vid_priv->bpix);
 
 	start = vid_priv->fb + vid_priv->ysize * vid_priv->line_length -
 		(row + 1) * fontdata->height * vid_priv->line_length;
 	line = start;
-	dst = line;
-	for (i = 0; i < pixels; i++)
-		fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
-	end = dst;
+
+	for (j = 0; j < fontdata->height; j++) {
+		dst = line;
+		for (i = 0; i < vid_priv->xsize; i++)
+			fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
+		line += vid_priv->line_length;
+	}
 
 	video_damage(dev->parent,
 		     0,

---
base-commit: ece349ade2973e220f524ce59e59711cc919263f
change-id: 20261002-b4-framebuffer-stride-fix-67c1d7d981e9

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>



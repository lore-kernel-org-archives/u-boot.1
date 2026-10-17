Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C408CCF2C9
	for <u-boot@archiver.kernel.org>; Sat, 17 Oct 2026 13:01:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E58E7409D5;
	Sat, 17 Oct 2026 13:01:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFo-qesNdxOF; Sat, 17 Oct 2026 13:01:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 20A0C409C7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792242100;
	b=ELh8MDAPiVZGZdaJFq4tnHk72UUtY6Si2Vdmw+GKHxFFIa2Buw9ahNR9bHwW3MZUFBhh
	 54Q4GnpkNL8GlDX54Y9O1TUNKCCL7S6Yt2aaEpt/voe4RVhxlTQH8hH1/Bqt+jP6uenQ1
	 GXq0abZS3ydVCgQET08pXYpMQ2IVaun5+o2nCr+CtfyicT+HONt5GBVwNzDLwAZYFqxcA
	 ZCfB65eOdytXgSoFASEe5B7eDEVHflQUe6kJqrd8RS0CDgfvSsKXYf8sMhNUECIEfQWxK
	 oKrOaW6SSkCgYjBbIbY0y+dz+QZ2i9aEPfzbhVkccFt5Tvu9ktjve/4OCXWg1jJ1n3Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792242100;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=DXHNvnS4Hu54qrFBgBtW9TS6dEho+29hgTcmFNXdASc=;
	b=nc72kaKPCBwxbaQ4oYSqpHWt+m2CVdfzl+cqQDyIVMuNR+rU2curYSU/KyImytnKMEEV
	 1r5aBMMatPPSN+SwHpsH1PaZDTpE+Z3jD7+I/3uLcEBtBDCEOM9Me9klScT5tmphMaYgD
	 YajI6W+94eUxEgohD2dyWrFEZ7njbPSRurt/8GJSyQmlFcZT1VgJbMRqz9CPd8NmmQtSQ
	 cWn48T/LNEcOS+IR2L1fJbe9fKsgD6EeXP5nmtKJqAXInQ+wJ7aMqMp9GSAaQZiTVK3jm
	 nQPonFByLHqW7D36KCFL/f7KacuEUEIhfvcQPgGth7bj7ccnRuSjB2EAMv3O6iYxzZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792242100;
	bh=DXHNvnS4Hu54qrFBgBtW9TS6dEho+29hgTcmFNXdASc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=HPbueuHFB1k5+CuFa4gnIgTTruqMQgA2qJOHHVYFyPDcUjGWOI9GcaPKlDv66FjZX
	 3JGBgYISIqJS6bkdEKADICB5u6v8zi4QeWhnOrAUHtOA9o/UKbIpOJnR/cQB1ZOfmH
	 Lx2kN149QUDHOkg6B/ZnTWk0cArRHERyPS9h3BUI82M9jo2/48VARaO01NMeGODxr0
	 szyRoA3wpZs+Puu7wHguSEbkYWauStR9bJgPQI5Y7oJ1pPqiKtEVJT4qXqkd5HJXfd
	 Rh4TwdbluAE60Oaskvn0zsDKcVdBUEZPf3SfiY0g8+RUUsZ/20KLjKWvnkLtlHVlaD
	 qfj2TAuQ508oQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20A0C409C7;
	Sat, 17 Oct 2026 13:01:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DF61A7AD
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D094E40180
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Oy3ouzsGbXOL for <u-boot@lists.u-boot-project.org>;
 Sat, 17 Oct 2026 09:10:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 32C0D40122
Authentication-Results: smtp2.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792228229;
 b=c+ojA709xc9toHL7MpUV6IJRka8Hr2H14u6k8nvYb89fHZigtah7YyI8hVwcQ3pepHQ9
 OV9BlXk6FBo+hOS2mluZ0B+Pb0Lp2JwLTe2qyvRnMtu+eBdo4Dkbo2p09RqovNizbPX8f
 0luwd/gwJ76594roCso+1KQoXad9aZlHJxOyFQUBroQD1q4MyYzN9GkVo1fsQzg8H6qlB
 8mVEJOwwMaOs6gNP9MCicXD29Zyto9H0q6LPL/axwoWjbtDMO41MLvShBJeNcgGI3sT4R
 gj0d0IE41pGsmAyXalOmKgh7IFz0klzbvqs/ErSq/30P5zpfTpzQQBEnuC/2VZv7pXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792228229;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=DXHNvnS4Hu54qrFBgBtW9TS6dEho+29hgTcmFNXdASc=;
 b=p+ijcJxaLCtTyeA0POvDAF/Uuf9iNx79vNx+JM73G224Zku+ub+40fduBnS5IfKCc41W
 p5Cf7sLDbada544Cowz2D/JfiKUgefI1RTBnsn46p4PoEnUdhzyyH8XYm5Xqmek+6P2aj
 Kkgc3p5PauMFQwQez4E3JISRJBGWQUyC1KzaCCKkL7oa5M7IWCZffoIT+kULySEySR7sh
 ybgQaiWf+9mmhWAWyLoNduP0gqQD5hrv7aP1ycknjxNoR7Zrkqcvz4p5exE+5KC60g4SB
 CkLV5UQ+uyyM4NvnxkKxnEDtk4CSOqSRFOdQkvb2SCBfyvtjLvCUf4q/hfGWQiD3c2Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=OPtB++zG; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=OPtB++zG
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 32C0D40122
 for <u-boot@lists.u-boot-project.org>; Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 90CEB43BD1;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71271C2BD01;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792228227;
 bh=ZgSacdR0WddzNu7On0IZxqSCYgcBvnldHP8yGqQ01cU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=OPtB++zGUhPbzLsoRf24wK0A6Z3Sd+ymCu21uGyaYKdnzm4RYq+M/O8pxCXOiDegQ
 eeDE+YgDPrl/8SVSUM5G/tWHWxLcHnAWyJcICHeLpddsxMTEvtEaQih79QeN1FgRwU
 hJ0z8FgDOqb4HwD1zh4hstqkp/QtIczRu1lrbkQTL74IyPWeD3Yj/M58jvL5eYphtr
 Cxwm0MqrpcEoKDHH8nEgEN1SMsIfI53495SrOYKqJm24siuirCCTAjxgr/vW09bMOY
 K0oNEXZ3SXStZOCfb2yHxA4Cbi2H44gJ1d0BUeRdb5on2ZUTe0xQUqLY91TaVMPsW4
 FfORDNfcX1Xpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 60D0CCCF2C9;
 Sat, 17 Oct 2026 09:10:27 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 11:10:22 +0200
Subject: [PATCH 06/14] video: Add video_rgb_to_colour()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-expo-colours-v1-6-479ac06e7642@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792228225; l=3390;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=eWA4+RawQU/jqqAiPzdzgGMDEGPyuRCFQ3YH/wzujK4=;
 b=TijiBWOtdzeqgaya0sqgf+QuyoJJlhAf8107hGL+kYHqeuK93D75jM9b/iso5UPLW7Xlluutj
 UL1dEMJm98JCvd4AFmPr8matBmzQAKVwjE5mvcK16mmvivEs8oT+tqx
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

video_index_to_colour() can only produce the sixteen console colours.

Split its pixel format conversion out into video_rgb_to_colour() so that
code which wants an arbitrary colour can get a value matching the
framebuffer format.

Make video_index_to_colour() call it.

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
 drivers/video/video-uclass.c | 27 +++++++++++++--------------
 include/video.h              | 13 +++++++++++++
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 22183d00d97..cba961ad467 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -333,31 +333,24 @@ static const struct vid_rgb colours[VID_COLOUR_COUNT] = {
 	{ 0x40, 0x40, 0x40 },  /* dark gray */
 };
 
-u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
+u32 video_rgb_to_colour(struct video_priv *priv, u8 r, u8 g, u8 b)
 {
 	switch (priv->bpix) {
 	case VIDEO_BPP16:
 		if (CONFIG_IS_ENABLED(VIDEO_BPP16)) {
-			return ((colours[idx].r >> 3) << 11) |
-			       ((colours[idx].g >> 2) <<  5) |
-			       ((colours[idx].b >> 3) <<  0);
+			return ((r >> 3) << 11) | ((g >> 2) << 5) |
+			       ((b >> 3) << 0);
 		}
 		break;
 	case VIDEO_BPP32:
 		if (CONFIG_IS_ENABLED(VIDEO_BPP32)) {
 			switch (priv->format) {
 			case VIDEO_X2R10G10B10:
-				return (colours[idx].r << 22) |
-				       (colours[idx].g << 12) |
-				       (colours[idx].b <<  2);
+				return (r << 22) | (g << 12) | (b << 2);
 			case VIDEO_RGBA8888:
-				return (colours[idx].r << 24) |
-				       (colours[idx].g << 16) |
-				       (colours[idx].b << 8) | 0xff;
+				return (r << 24) | (g << 16) | (b << 8) | 0xff;
 			default:
-				return (colours[idx].r << 16) |
-				       (colours[idx].g <<  8) |
-				       (colours[idx].b <<  0);
+				return (r << 16) | (g << 8) | (b << 0);
 			}
 		}
 		break;
@@ -369,12 +362,18 @@ u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
 	 * For unknown bit arrangements just support
 	 * black and white.
 	 */
-	if (idx)
+	if (r || g || b)
 		return 0xffffff; /* white */
 
 	return 0x000000; /* black */
 }
 
+u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
+{
+	return video_rgb_to_colour(priv, colours[idx].r, colours[idx].g,
+				   colours[idx].b);
+}
+
 void video_set_default_colors(struct udevice *dev, bool invert)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
diff --git a/include/video.h b/include/video.h
index 8e4c1544e56..72f1dc936c8 100644
--- a/include/video.h
+++ b/include/video.h
@@ -209,8 +209,21 @@ enum colour_idx {
  * @idx		color index (e.g. VID_YELLOW)
  * Return:	color value
  */
+
 u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx);
 
+/**
+ * video_rgb_to_colour() - convert an RGB value to a pixel's internal format
+ *
+ * @priv	private data of the video device (UCLASS_VIDEO)
+ * @r		red component (0-255)
+ * @g		green component (0-255)
+ * @b		blue component (0-255)
+ * Return:	colour value, suitable for @priv->colour_fg / @priv->colour_bg
+ *		or video_fill()
+ */
+u32 video_rgb_to_colour(struct video_priv *priv, u8 r, u8 g, u8 b);
+
 /**
  * video_reserve() - Reserve frame-buffer memory for video devices
  *

-- 
2.55.0



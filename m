Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D566CCF2C3
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 22:52:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2331A81819;
	Fri, 16 Oct 2026 22:52:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mXMT8AcAxLfq; Fri, 16 Oct 2026 22:52:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5BD03817ED
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792191145;
	b=CcOdownxrw/1ehPgsrnd12lOU/Qm2Ro+1q8ZUBjKVr9l/bbSpX2hlDVlh7lAFfj1y0vt
	 yr8vT0TYd6pt8Z6gmxiJ+isAan5A7Rd2FTXWZX7NsX/vsRG9JHyLQKnAttGCqgIbxZXY8
	 FNaxj5VUAszOKvq3AEf3lXR7RR1PebL8mzGJNu7v3mOrG1wh3N4k/mSJf+uzZpYOb1aMK
	 ku7HUPz6QMlsddwiCONF3Am30MNXS9XT99IfQvKIv3QvHJ4CHmHzOBRYmUROW6yiF75hj
	 fHVDOUFqimyKbbtphdAvuWbIXAJGoou65y61eD8kgx3/XHQz3FIe7sTwsCc+4mbJUKQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792191145;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=9LyALmQlUuCV242Z2bNfd9JbYm8DiFTWWuKlFljFN6U=;
	b=OOD/58RQlSwXxkA2FcGjsu/lEBINCAwy7WXu/mm8iiL9AAZaeGcAVzkb5+Y8+5/aJckP
	 0Ax3IfWDoK1E8NwfuAbEn4OE/DAuP0O/jtVFb+6mSlZSk9INZdByLSnMiLx7xzUXb9rJC
	 LM5JcKtkk91ZST5PsO73/gLWHZCdv3fGdfOtbx/mcm1wvycUcxu9egYiIs6apbrN+zQWI
	 rN5hdA4ZqOaEi0shuaxsGn+pt8ENz5sfxjMauu7BttnLjphwOhtCWKKNlImcrfszJdC8V
	 UX6JfUixvZEqtF5gHKhPVhoM7TD2hyq/ZYVKKcs7KJqFngIjClMJJNcnEIFo4Ddv2zA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792191145;
	bh=9LyALmQlUuCV242Z2bNfd9JbYm8DiFTWWuKlFljFN6U=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=AMpKGz7c9aWb+6pqkcL7WvcPFrWSAZzT0eyMLMVw+mZ1Gz+iNLKue9db6hTB9XL7+
	 KmopvCZCkI8ypbaIx9syJAwIknJVriiq1jLBk0x+t6SQClijU4vwKq5ov2FfWlwMDg
	 y8aijzDUvFLR4Ak+TL1NqqyXT/MPtfXdomROU4cVCYwZ5AeTgVQVMm+onJy7w/qZks
	 KoDjAGYam8cdfXP3BskzRgdpwnRA/4BSvu6SGmF08ehVWxJ4zOR/MsQDNksaW01DGu
	 MK/SPArA4MkxJaoa3nqenNnUM2zhCEoq/k6X16ZJ/OagQ/thoy+aGWzmcJftJjoQu7
	 KeoMMLR5p+N5A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BD03817ED;
	Fri, 16 Oct 2026 22:52:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0CCDE255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E754D60AEC
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:08:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FxjfRH-BU-ZI for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 22:08:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 32D90608E7
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792188487;
 b=pBxvt2gcl+pd0EH3IfLDx6mIMz7+zWHunEANAwDjnJCVZDRc9Kr84LVvrjI91P5YiC4J
 7zGDeAdpbenDuW6VZ0KNdd85017HhvCkXFxbYcI40FKKAAnlo7xeE8G/LK3xxXO/J/ETV
 EsknKctIsnrTwZNb1/qCQ+BD9iPBogv/3GM+GMN6DMifP0BnfJIQMFrJBZB9lAVLTChHP
 ri0fC5XCE+q9lKyTRPXX5EKcPVTTCCt1iXF/mbnrIQNkti8BLaTHAMAiTrV+oU+H8mHOU
 RuoBiWoeXWHwJQodjDeUela9FS/MNJXjqjywd9IHoa3aer1guuV/zQ6s5JR0Yo3HJPw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792188487;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=9LyALmQlUuCV242Z2bNfd9JbYm8DiFTWWuKlFljFN6U=;
 b=LnE34Adha/cj6KvI2SXzBnijnP3eNQvWNedJCI0SsLVEzhPNc+XZ3vsiiKh62lZioOuo
 LsAT6h2A1VW+0fwodey0z0DgOblY0YKNi8UwzqXz4kKtYlU1CgFiOWBqlLHF/AF+DTQtc
 c4gqdWkWer5MFFGQqRjse2PV1TEg/2GPeXQSOGPjoNeFGb2htD/RDu9+R9Lfb1+PO+RDH
 cK6Dj1uCNq4VqjX9Q1RCK3ii0maeoW3BexmqvRnWVVpZzl8MqfTEPaimpBeuaUwsiVR5a
 CeGBHNKSDcvAUwvaPbsdg6jSBRcQVgVc2pseCSimfFzY+QuOuACpcCR9z4BPQ1eccqA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=cnXmo5yR; 
 arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=devnull+petr.hodina.protonmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=cnXmo5yR
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 32D90608E7
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 22:08:04 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0B8A16022E;
 Fri, 16 Oct 2026 22:08:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4CCDC2BCF4;
 Fri, 16 Oct 2026 22:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1792188482;
 bh=d/BA8b4PJLro6JPMlfW/TCfav3Rx+kgnn9PNhEmSPQc=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=cnXmo5yR1UlwMYTrrk5w+MgZ6Y/NrfP02woNs+sLudTiboKP2yXYttfDFCxK/LVHr
 diCKDj+Ho1E3qxj8HR/adI9L/+1FsamdrXsOTy6e4ftH7+hZuXgHfdM1e/clPG4saQ
 5JYqxNZraIsHFCZG417X705yZPT/c+nzYnhrSVsQtHmgRyrLV043EiNeWKT2veYH+3
 SY5M3zCEZfT/xOtoMLiCrQkP69M4CSBnPxKcfbK2bXE1BHL+65w3806s/L0lzkeYRu
 sPAwoaJbqEapMFwA4KnX0Il6LXwsyF3ztMeftTgXxkV3UngOQyF7VlzCDO8k+V8cdu
 UWdCvl6IO7naQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 88D20CCF2C1;
 Fri, 16 Oct 2026 22:08:02 +0000 (UTC)
From: Petr Hodina via B4 Relay <devnull+petr.hodina.protonmail.com@kernel.org>
Date: Sat, 17 Oct 2026 00:07:56 +0200
Subject: [PATCH] video: simplefb: add an a8r8g8b8 format with an opaque alpha
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261017-b4-simplefb-a8r8g8b8-v1-1-ce7e80682a5c@protonmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDuQBEmDV5EunDjREauS0VIQ7
 960Xb7F/ycoZ2GFpjoh80tU1qXA3iqIY7cMjNIXgzPOW2M9Uo0qz23mRNiFHIZAAV0f74bY1yk
 SlHTLnOT927aPv/WgieP+fcF1fQBSdF96eAAAAA==
X-Change-ID: 20261016-b4-simplefb-a8r8g8b8-2dc70be64fcb
To: u-boot@lists.u-boot-project.org
Cc: Anatolij Gustschin <ag.dev.uboot@gmail.com>, 
 Tom Rini <trini@konsulko.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Aelin Reidel <aelin@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, David Heidelberg <david@ixit.cz>, 
 Petr Pavlata <petr@acrux.cz>, Petr Hodina <petr.hodina@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792188481; l=3780;
 i=petr.hodina@protonmail.com; s=20260107; h=from:subject:message-id;
 bh=YOPmvffoCNj7UsY0sY0TJB0H0U4VwmiM/L0E2yVOwww=;
 b=BHw2g3kJGfT4+a2AfHiOvl0I2sdXwnBo9QWLTbuYQ67syAjpm27uoIJRirzU2zIOemtCkKSI6
 VXPQ0CgGXBvA5LqiOCKAHoTAbhoxzrYOcWqGLZP6/rAFInbO5yjz9Xl
X-Developer-Key: i=petr.hodina@protonmail.com; a=ed25519;
 pk=3QaVc6AaAu1IsyyH86+LIOOFhD7kCws8Xhe+wwyE7Bg=
X-Endpoint-Received: by B4 Relay for petr.hodina@protonmail.com/20260107
 with auth_id=594
X-Original-From: Petr Hodina <petr.hodina@protonmail.com>
X-Mailman-Approved-At: Fri, 16 Oct 2026 22:52:07 +0000
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

Map "a8r8g8b8" to a new VIDEO_A8R8G8B8 format that writes 0xff in the
alpha byte for the console colours and for the BMP/logo paths.

Adds support for the framebuffer on Xiaomi Redmi Note 8 Pro (begonia).

Signed-off-by: Petr Hodina <petr.hodina@protonmail.com>
---
Doing bringup on the Xiaomi Xiaomi Redmi Note 8 Pro (begonia) and
encountered the following frambuffer format.

For a simple-framebuffer node with format "a8r8g8b8" U-Boot currently writes
the pixels as x8r8g8b8 leaving the alpha byte zero. Therefore the console
background and logo are fully transparent and the screen stays black.
---
 drivers/video/simplefb.c     | 6 ++++--
 drivers/video/video-uclass.c | 5 +++++
 drivers/video/video_bmp.c    | 9 ++++++---
 include/video.h              | 1 +
 4 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/video/simplefb.c b/drivers/video/simplefb.c
index 8d0772d4e51..3dc073bce9e 100644
--- a/drivers/video/simplefb.c
+++ b/drivers/video/simplefb.c
@@ -71,8 +71,10 @@ static int simple_video_probe(struct udevice *dev)
 		   strcmp(format, "x8b8g8r8") == 0) {
 		uc_priv->bpix = VIDEO_BPP32;
 		uc_priv->format = VIDEO_X8B8G8R8;
-	} else if (strcmp(format, "a8r8g8b8") == 0 ||
-		   strcmp(format, "x8r8g8b8") == 0) {
+	} else if (strcmp(format, "a8r8g8b8") == 0) {
+		uc_priv->bpix = VIDEO_BPP32;
+		uc_priv->format = VIDEO_A8R8G8B8;
+	} else if (strcmp(format, "x8r8g8b8") == 0) {
 		uc_priv->bpix = VIDEO_BPP32;
 		uc_priv->format = VIDEO_X8R8G8B8;
 	} else if (strcmp(format, "a2r10g10b10") == 0 ||
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 53641fc28b6..68fd9ef38c0 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -354,6 +354,11 @@ u32 video_index_to_colour(struct video_priv *priv, enum colour_idx idx)
 				return (colours[idx].r << 24) |
 				       (colours[idx].g << 16) |
 				       (colours[idx].b << 8) | 0xff;
+			case VIDEO_A8R8G8B8:
+				return 0xff000000 |
+				       (colours[idx].r << 16) |
+				       (colours[idx].g <<  8) |
+				       (colours[idx].b <<  0);
 			default:
 				return (colours[idx].r << 16) |
 				       (colours[idx].g <<  8) |
diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 1f267d45812..98ed59e275e 100644
--- a/drivers/video/video_bmp.c
+++ b/drivers/video/video_bmp.c
@@ -88,7 +88,7 @@ static void write_pix8(u8 *fb, uint bpix, enum video_format eformat,
 			*fb++ = cte->blue;
 			*fb++ = cte->green;
 			*fb++ = cte->red;
-			*fb++ = 0;
+			*fb++ = eformat == VIDEO_A8R8G8B8 ? 0xff : 0;
 		}
 	}
 }
@@ -409,7 +409,8 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 						*fb++ = *bmap++;
 						*fb++ = *bmap++;
 						*fb++ = *bmap++;
-						*fb++ = 0;
+						*fb++ = eformat == VIDEO_A8R8G8B8 ?
+							0xff : 0;
 					}
 				}
 				fb -= priv->line_length + width * (bpix / 8);
@@ -447,7 +448,9 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 						*fb++ = *bmap++;
 						*fb++ = *bmap++;
 						*fb++ = *bmap++;
-						*fb++ = *bmap++;
+						/* blend on alpha */
+						*fb++ = eformat == VIDEO_A8R8G8B8 ?
+							(bmap++, 0xff) : *bmap++;
 					}
 				}
 				fb -= priv->line_length + width * (bpix / 8);
diff --git a/include/video.h b/include/video.h
index 9ea6b676463..71e9558dba1 100644
--- a/include/video.h
+++ b/include/video.h
@@ -67,6 +67,7 @@ enum video_format {
 	VIDEO_X8B8G8R8,
 	VIDEO_X8R8G8B8,
 	VIDEO_X2R10G10B10,
+	VIDEO_A8R8G8B8,
 };
 
 /**

---
base-commit: 1bcb2fe324180d0a8cfbdb0511737eba1d5b8550
change-id: 20261016-b4-simplefb-a8r8g8b8-2dc70be64fcb

Best regards,
--  
Petr Hodina <petr.hodina@protonmail.com>



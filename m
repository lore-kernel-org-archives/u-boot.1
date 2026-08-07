Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F46C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 08:13:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 41D0B608D0;
	Fri,  7 Aug 2026 08:13:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xU754SM3FkJG; Fri,  7 Aug 2026 08:13:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 017CD608BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786090426;
	bh=HEP2PCzARN+rPeO7o2uJKpnHeaCeWZ1E4uYgdc0GUp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YqXxYsl0yiHkzYo+3yu7SfEUaGl7w6hF93FOs7iU/9JCvcHQWPukicPhdkD3EA2b8
	 bU01Jf6cIYs+M1sZeZyT5f7AGmuTJfVV/lDz1IrBGcVuu03UmY4H5kZdcXB3tVDpel
	 oZiQwe3DxgSXGTNQSk9nq0BQxg7aEiFMq09FEeOFPBQRGXNXEA5Ednxqkh++dfsi9Y
	 o+9Wo955dxfsRNAZa3peler4N84Xhp4NtJdxv7afsQi9zvoW2Strku8LWKf4ERJD3M
	 uFdGca3szm1toy0W+7tHOEVU1uJBOv0Hz4X5Mh6iI4P5n6SJpwIIl3RAKACzNNzBz8
	 9HzPt9Zkk97/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 017CD608BB;
	Fri,  7 Aug 2026 08:13:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64D7F397
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:13:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A993403C4
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:13:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mHJDUmFiw_lg for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 08:13:42 +0000 (UTC)
X-Greylist: delayed 432 seconds by postgrey-1.37 at util1.osuosl.org;
 Fri, 07 Aug 2026 08:13:42 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 6F01540122
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6F01540122
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a02:6b8:c02:900:1:45:d181:d205; helo=forward205b.mail.yandex.net;
 envelope-from=nikita.shubin@maquefel.me; receiver=<UNKNOWN> 
Received: from forward205b.mail.yandex.net (forward205b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d205])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6F01540122
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 08:13:42 +0000 (UTC)
Received: from forward101b.mail.yandex.net (forward101b.mail.yandex.net
 [IPv6:2a02:6b8:c02:900:1:45:d181:d101])
 by forward205b.mail.yandex.net (postfix) with ESMTPS id 97BB385EB8
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 11:06:36 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
 by forward101b.mail.yandex.net (postfix) with ESMTPS id 17E79C0076;
 Fri, 07 Aug 2026 11:06:28 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id L6FKBuIeKuQ0-amtRKChX; 
 Fri, 07 Aug 2026 11:06:27 +0300
X-Yandex-Fwd: 1
From: Nikita Shubin <nikita.shubin@maquefel.me>
Date: Fri, 07 Aug 2026 11:06:39 +0300
Subject: [PATCH 2/5] common: spl: ram: Add LOAD_FIT_FULL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-riscv-full-fit-support-v1-2-21a34f79c350@maquefel.me>
References: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
In-Reply-To: <20260807-riscv-full-fit-support-v1-0-21a34f79c350@maquefel.me>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Francesco Valla <francesco@valla.it>, 
 Nikita Shubin <nikita.shubin@maquefel.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786089998; l=1067;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=99EgMay/geFPHmqMwS16SHLGrTBXGV3tVOZ8CqdZvMc=;
 b=cNJQk1GaSycnX6ootKYV+h1qYe4k7uyZ8X1x9If0SeAuOfkMzhHZk38KTiJd0t+bVhUeFfs23
 XKZuBYDUlUIAFiM+ObQUmmpTKTZodnr1ZSy+2vBBj5xv1skQmQKuolh
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maquefel.me; s=mail; 
 t=1786089987; bh=HEP2PCzARN+rPeO7o2uJKpnHeaCeWZ1E4uYgdc0GUp8=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=Z8z3T0eB664mpjAQc+R0/QGkacqP3gdGJ4cvDOcb3W+z5TqOWmKc5ysPPvIcEy00a
 aITy5iktzQs1DbIsnNOICu+7xIVqEYdD85RzVchJCb3rs+lX+Yq1AhjKFvSvc70JGf
 LaCBm1SR13g85qkLxw1ku4sqm3WCuHceLCHdl1mI=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=maquefel.me
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=maquefel.me header.i=@maquefel.me header.a=rsa-sha256
 header.s=mail header.b=Z8z3T0eB
X-Mailman-Original-Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net;
 dkim=pass header.i=@maquefel.me
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Allow booting with spl_load_fit_image() if LOAD_FIT_FULL enabled.

Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 common/spl/spl_ram.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/spl/spl_ram.c b/common/spl/spl_ram.c
index 0c501cf02f2..551cd8f4e2d 100644
--- a/common/spl/spl_ram.c
+++ b/common/spl/spl_ram.c
@@ -81,11 +81,15 @@ static int spl_ram_load_image(struct spl_image_info *spl_image,
 
 	if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 	    image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
-
 		debug("Found FIT\n");
-		spl_load_init(&load, spl_ram_load_read, NULL, 1);
-		ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		if (CONFIG_IS_ENABLED(LOAD_FIT_FULL)) {
+			ret = spl_load_fit_image(spl_image, header);
+		} else {
+			struct spl_load_info load;
+
+			spl_load_init(&load, spl_ram_load_read, NULL, 1);
+			ret = spl_load_simple_fit(spl_image, &load, 0, header);
+		}
 	} else {
 		ulong u_boot_pos = spl_get_image_pos();
 

-- 
2.52.0

